defmodule Burox.Response.Parser do
  @moduledoc """
  Este modulo es el encargado de mapear la cadena del Buró a la estructura de:
  %Response
  """

  import Burox.Response.Config
  alias Burox.Response
  alias  Burox.Response.Config

  @success_sections [
    "INTL",  # Response header
    "PN",    # General info from client
    "PA",    # Client Addresses
    "PE",    # Work Addresses
    "TL",    # Credits or accounts
    "IQ",    # Queries of Buro de crédito
    "RS",    # Summary of Buro de Crédito
    "HI",    # HI Hawk Alert
    "HR",    # HR Hawk Alert
    "CR",    # Declarativa
    "SC",    # BC-Score
    "CL",    # Sintetiza
    "ES"     # End
  ]

  @error_sections [
    "UR",
    "ES"
  ]

  @doc """
  Procesa y parsea la cadena recibida del Buró de Crédito
  """
  @spec process_response(String.t) :: map
  def process_response(response) do

    # La respuesta del Buró de Crédito esta divida en segmentos
    response
    # Si la cadena comienza con INTL, quiere decir que se obtuvieron los datos solicitados
    |> String.starts_with?("INTL")
    |> if  do
      success = response
        |> _process_response(@success_sections)
        |> Map.to_list()
        |> add_score_exclusion()
        |> (&struct(Response, &1)).()
      {:ok, success}
    else
      errors = response
        |> _process_response(@error_sections)
        |> Map.get(:error)
        |> Map.to_list()

      {:error, errors}
    end

  end

  # Procesa la cadena de respuesta, sin importar si fue exitosa o fallida
  defp _process_response(response, sections) do
    sections
    |> Enum.reduce(%{"tail" => response}, fn(tag, section_values) ->
        # Busca las secciones y sus valores
        {values, tail} = match_section(section_values["tail"], tag, sections)

        # Lee la configuración para mapear la respuesta
        section_key = sections_map[tag]["key"]
        type = sections_map[tag]["type"]

        convert_to_list? = type == "list" and is_map(values)

        values = if convert_to_list? do
            if Enum.empty?(values), do: [] , else: [values]
          else
            values
          end

        Map.merge(section_values, %{section_key => values, "tail" => tail})
      end
    )
    |> Map.delete("tail")
  end

  @doc """
  Retorna un mapa con los todos los valores de la sección a buscar
  """
  @spec match_section(String.t, String.t, list) :: tuple
  def match_section(string, section, sections_keys) do
    section_values = %{}
    cond do
      String.starts_with?(string, "INTL") ->
        {value_string, tail} = String.split_at(string, 49)
        {String.slice(value_string, 5, 44), tail}

      String.starts_with?(string, "ERRR") ->
        {_, tail} = String.split_at(string, 4)
        _match_section(section, tail, "", section_values, sections_keys)

      String.starts_with?(string, section) ->
        _match_section(section, string, "", section_values, sections_keys)

      true ->
        # Se omite la sección, si no se encuentra en la respuesta
        {%{}, string}
    end

  end

  # Retorna todos los valores encontrados hasta que la
  # siguiente section es encontrada
  defp _match_section(_, "", _, values, _), do: {values, ""}
  defp _match_section(_, "", _, values, _), do: {values, ""}

  defp _match_section(section, tail, tag, values, sections) do

    # Elimina el tag
    tail = tail
      |> String.split_at(2)
      |> elem(1)

    # Caso especial para extraer las declarativas del cliente en una lista
    {value, tail} =
    if section == "CR" && tag == "00" do
      length = String.to_integer(values[:tipo_de_segmento])

      tail
      |> read_value()
      |> elem(1)
      |> extract_declarations(length)
    else
      read_value(tail)
    end

    merge = fn section_map ->
      if is_nil(section_map) do
        Map.merge(values, %{tag => value})
      else
        tag_model = section_map
        |> Map.get("tags")
        |> Map.get(tag)

        tag_key = tag_model["key"]

        translation =  Map.get(tag_model, "translate")
        type = Map.get(tag_model, "type")

        value = cond do
          is_function(translation) ->
            translation.(value)
          type == "integer" ->
            String.to_integer(value)
          type == "float" ->
            value
            |> Float.parse()
            |> elem(0)
          type == "date" ->
            parse_string_to_date(value)
          true -> value
        end

        Map.merge(values, %{tag_key => value})
      end
    end

    values = sections_map()
    |> Map.get(section)
    |> merge.()

    next_tag = String.slice(tail, 0, 2)

    # Revisa si realmente se llegó al final de la sección
    is_member = Enum.member?(sections, next_tag)

    # La sección puede ser una lista o un mapa
    is_same_section = section == next_tag
    cond do
      is_same_section ->
        {next_values, final_tail} =
          _match_section(section, tail, "", values, sections)

        {List.flatten([values] ++ [next_values]) , final_tail}

      is_member ->
        {values, tail}

      true ->
        _match_section(section, tail, next_tag, values, sections)
    end

  end

  # Regrese la cadena con el valor y su tamaño
  defp read_value(string) do
    # El tamaño del valor esta despúes de la etiqueta, siempre son 2 dígitos
    {length, _} = string
    |> String.slice(0, 2)
    |> Integer.parse()

    read_value(string, length)
  end

  defp read_value(string, length) do
    # El valor esta siempre despúes del tamaño
    value_start = 0 + 2

    # Regresa la cadena no procesada
    tail = string
    |> String.split_at(value_start + length)
    |> elem(1)

    {String.slice(string, value_start, length), tail}
  end

  # Convierte una cadena a Fecha, 'yyyymmmdd'
  defp parse_string_to_date("00000000"), do: nil
  defp parse_string_to_date("000000000"), do: nil
  defp parse_string_to_date(str_date) do
    [d, m, y1, y2] = for <<x::binary-2 <- str_date>>, do: x

    y1 <> y2
    |> String.to_integer
    |> Date.new(String.to_integer(m), String.to_integer(d))
    |> elem(1)

  end

  # Esta función ayuda a separar las declarativas de crédito
  # Es un proceso diferente a las otras secciones
  # Estas estan en una sola cadena separadas por ##CREDITO
  defp extract_declarations(string, length) do
    {string, tail} = String.split_at(string, length)
    only_credits? = String.starts_with?(string, "##")

    # Las declarativas se presentan de acuerdo a la secuencia de los
    # créditos mostrados en el Buró de Crédito

    value = string
      |> String.split(~r(##CREDITO))
      |> Enum.with_index()
      |> Enum.map(fn {credit, index} ->
           if index == 0 && !only_credits? do
             {"Expediente", credit}
           else
             String.split_at(credit, 2)
           end
         end)
    {value, tail}
  end

  # Si el valor del score es negativo, entonces se agrega un campo indicando la razón
  defp add_score_exclusion(sections) do
    score_values = Keyword.get(sections, :score)

    %{valor_del_score: score} = score_values

     if score > 0 do
        sections
     else
       new_values = Map.put(score_values, :valor_de_exclusion, Config.score_exclusion(score))
       Keyword.merge(sections, [score: new_values])
      end
  end

end

