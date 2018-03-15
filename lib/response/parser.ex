defmodule Burox.Response.Parser do
  @moduledoc false

  import Burox.Response.Config
  alias Burox.Response

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
  Process and parse the string response from Buro
  """
  @spec process_response(String.t) :: map
  def process_response(response) do

    # The response from buro is divided into segments
    response
    |> String.starts_with?("INTL")
    |> if  do
      success = response
        |> _process_response(@success_sections)
        |> Map.to_list()
        |> (&struct(Response, &1)).()
      {:ok, success}
    else
      {:error, _process_response(response, @error_sections)}
    end

  end

  # Process the response depending if it was succesful or failed.
  defp _process_response(response, sections) do
    Enum.reduce(sections, %{"tail" => response}, fn(tag, section_values) ->
        # Seek for sections and their values
        {values, tail} = match_section(section_values["tail"], tag, sections)

        # Read config to map section
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
  end

  @doc """
  Retrieves a map with all section values
  """
  @spec match_section(String.t, String.t, list) :: tuple
  def match_section(string, section, sections_keys) do
    section_values = %{}

    cond do
      String.starts_with?(string, "INTL") ->
        {value_string, tail} = String.split_at(string, 49)
        {String.slice(value_string, 31, 15), tail}

      String.starts_with?(string, "ERRR") ->
        {_, tail} = String.split_at(string, 4)
        _match_section(section, tail, "", section_values, sections_keys)

      String.starts_with?(string, section) ->
        _match_section(section, string, "", section_values, sections_keys)

      true ->
        # Skip section not found
        {%{}, string}
    end

  end

  # Retrieves values until the next section is found
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
        value = tag_model
        |> Map.get("type")
        |> case  do
             "integer" -> String.to_integer(value)
             "float" ->
               value
               |> Float.parse()
               |> elem(0)
             "date" -> parse_string_to_date(value)
             _ -> value
           end

        Map.merge(values, %{tag_key => value})
      end
    end

    values = sections_map()
    |> Map.get(section)
    |> merge.()

    next_tag = String.slice(tail, 0, 2)

    # Check if we reach the end of section
    is_member = Enum.member?(sections, next_tag)

    # Section could be a list instead of a map_tag
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

  # Parse the length of a value and return the slice that contains it
  defp read_value(string) do
    # The length of the value is after the tag, 2 digits always
    {length, _} = string
    |> String.slice(0, 2)
    |> Integer.parse()

    read_value(string, length)
  end

  defp read_value(string, length) do
    # Value starts after the lenght info
    value_start = 0 + 2

    # Return the string not processed yet
    tail = string
    |> String.split_at(value_start + length)
    |> elem(1)

    {String.slice(string, value_start, length), tail}
  end

  # Convierte una cadena a Fecha, 'yyyymmmdd'
  defp parse_string_to_date("000000000"), do: nil
  defp parse_string_to_date(str_date) do
    [d, m, y1, y2] = for <<x::binary-2 <- str_date>>, do: x

    y1 <> y2
    |> String.to_integer
    |> Date.new(String.to_integer(m), String.to_integer(d))
    |> elem(1)

  end

  # Esta función ayuda a separar las declarativas de credito
  # Estan estan en una sola cadena separadas por ##CREDITO
  def extract_declarations(string, length) do
    {string, tail} = String.split_at(string, length)
    only_credits? = String.starts_with?(string, "##")

    # Las declarativas se presentan de acuerdo a la secuencia de los
    # créditos mostrados en el buro

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

end
