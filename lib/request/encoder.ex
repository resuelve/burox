defmodule Burox.Request.Encoder do
  @moduledoc """
  Este modulo contiene la especificación de los datos
  que pueden ir en la petición del buro
  """

  import Burox.Request.Config
  alias Burox.Request

  @doc """
  Convierte una estructura de respuesta al formato
  recibido por el buró de crédito
  """
  @spec encode_buro(Request) :: {:ok, term} | {:error, term}
  def encode_buro(peticion) do

    # TODO: Validar datos de entrada
    "#{build_header(peticion.encabezado)}" <>
    "#{build_body(peticion)}"

  end

  # Crea el encabezado de la peticion,
  # solo esta soportada la versión 13
  defp build_header(encabezado) do
    "INTL13                         "
    <> encabezado.codigo_de_producto
    <> encabezado.pais
    <> "0000"
    <> encabezado.buro_user
    <> encabezado.buro_password
    <> "I"
    <> "CC"
    <> "MX"
    <> "000050000"
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

        if values != nil do
          # Agrega la llave del segmento
          acc = acc <> config[:key]

          body = Enum.reduce(config[:tags], "", fn({key, tag}, acc) ->
              value = values[key]

              if value != nil do
                acc <> tag <> size_of(value) <> value
              else
                acc
              end
            end)

          # Agrega los valores
          acc <> body
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
