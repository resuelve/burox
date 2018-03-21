defmodule Burox.Request.Encoder do
  @moduledoc """
  Este módulo contiene la especificación de los datos
  que pueden ir en la petición del Buró de Crédito
  """

  import Burox.Request.Config
  alias Burox.Request

  @doc """
  Convierte una estructura de respuesta al formato
  recibido por el buró de crédito
  """
  @spec encode_buro(Request.t, String.t) :: {:ok, term} | {:error, term}
  def encode_buro(peticion, codigo_de_producto) do

    "#{build_header(codigo_de_producto)}" <>
    "#{build_body(peticion)}"

  end

  # Crea el encabezado de la petición,
  # solo esta soportada la versión 13
  defp build_header(codigo_de_producto) do

    buro_user = Application.get_env(:burox, :buro_user)
    buro_password = Application.get_env(:burox, :buro_password)

    if is_nil(buro_user) or is_nil(buro_password) do
      raise Burox.Error, message: "Deben configurarse las credenciales del Buró de Crédito"
    end

    "INTL13                         "
    <> codigo_de_producto
    <> "MX"
    <> "0000"
    <> buro_user
    <> buro_password
    <> "I"
    <> "CC"
    <> "MX"
    <> "000000000"
    <> "SP"
    <> "01"
    <> " "
    <> "    "
    <> "000000"

  end

  # Crea el cuerpo de la petición
  # donde van codificados los datos de la persona
  defp build_body(request) do
    request_map = Map.from_struct(request)

    # Reduce sobre la lista de configuración y no sobre los
    # parametros, para mantener el orden en la cadena de salida
    Enum.reduce(sections_list(), "",
      fn({segmento, config}, acc) ->
        values = request_map[segmento]

        # ¿Hay valores del segmento?
        if values != nil do
          # Agrega la llave del segmento
          acc = acc <> config[:key]

          # Agrega los valores
          acc <> build_tag_values(config[:tags], values)
        end
      end)
  end

  # Función para construir los valores de las etiquetas de un segmento
  # Nombre + tamaño + valor
  defp build_tag_values(tags, values) do
    Enum.reduce(tags, "", fn({key, tag}, acc) ->
      value = Map.get(values, key)

      if value != nil do
        acc <> tag <> size_of(value) <> value
      else
        acc
      end

    end)
  end

  # Retorna el numero de caracteres de una cadena
  # El valor retornado siempre estará expresado en dos caracteres
  # i.e '12'
  # Si el valor es menor a 10, comenzará con 0
  # i.e '02'
  defp size_of(string) do
    size = String.length(string)

    cond do
      size < 10 -> "0#{size}"
      size > 99 -> raise "El valor es demasiado grande para ser codificado"
      true -> "#{size}"
    end

  end
end
