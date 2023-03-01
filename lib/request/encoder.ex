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
  @spec encode_buro(Request.t(), String.t(), boolean(), String.t()) :: String.t()
  def encode_buro(request, product_code \\ "507", special \\ false, credentials_type \\ "fmg")
  def encode_buro(
    %{autenticacion: %{cuenta_con_tarjeta_de_credito: nil}} = request,
    product_code,
    special,
    credentials_type
  ) do
    body = build_header(product_code, special, credentials_type) <> "#{build_body(request)}"
    body <> build_end(body)
  end

  def encode_buro(request, product_code, special, credentials_type) do
    body =
      "#{build_authentication(request.autenticacion)}" <>
      "#{build_header(product_code, special, credentials_type)}" <> "#{build_body(request)}"

    body <> build_end(body)
  end

  # Build the request header with the associated credentials
  @spec build_header(String.t(), boolean(), String.t()) :: String.t()
  defp build_header(product_code, special, credentials_type) do
    product_code
    |> get_credentials(special, credentials_type)
    |> validate_credentials()
    |> get_header_payload(product_code)
  end

  # El servicio de prospector solo esta disponible en la versión 11
  # Currently, all requests for score are with sae credentials
  @spec get_credentials(String.t(), boolean(), String.t()) :: tuple()
  defp get_credentials("107", _special, _type) do
    user = Application.get_env(:burox, :buro_user_prospector)
    password = Application.get_env(:burox, :buro_password_prospector)

    {user, password, "11"}
  end

  defp get_credentials(_product_code, true, "sae") do
    user = Application.get_env(:burox, :buro_user_special_sae)
    password = Application.get_env(:burox, :buro_password_special_sae)

    {user, password, "13"}
  end

  # request are with 'fmg' credentials by default
  defp get_credentials(_product_code, true, _type) do
    user = Application.get_env(:burox, :buro_user_special)
    password = Application.get_env(:burox, :buro_password_special)

    {user, password, "13"}
  end

  defp get_credentials(_product_code, _special, "sae") do
      user = Application.get_env(:burox, :buro_user_sae)
      password = Application.get_env(:burox, :buro_password_sae)

      {user, password, "13"}
  end

  # request are with 'fmg' credentials by default
  defp get_credentials(_product_code, _special, _type) do
      user = Application.get_env(:burox, :buro_user)
      password = Application.get_env(:burox, :buro_password)

      {user, password, "13"}
  end

  @spec validate_credentials(
    {String.t(), String.t(), String.t()}
  ) :: {String.t(), String.t(), String.t()}
  defp validate_credentials({user, password, _version}) when is_nil(user) or is_nil(password),
    do: raise(Burox.Error, message: "Deben configurarse las credenciales del buró de crédito")

  defp validate_credentials(credentials), do: credentials

  @spec get_header_payload(tuple(), String.t()) :: String.t()
  defp get_header_payload({user, password, version}, product_code) do
    "INTL"
    <> version
    <> "                         "
    <> product_code
    <> "MX"                             # Clave de pais
    <> "0000"                           # Reservado
    <> user
    <> password
    <> "I"                              # Tipo de responsabilidad(I: Individual)
    <> "CC"                             # Tipo de contrato
    <> "MX"                             # Mondea del crédito
    <> "000000000"                      # Importe del contrato
    <> "SP"                             # Idioma (SP: ingles)
    <> "01"                             # Tipo de salida (01: Archivo de cadena de datos)
    <> " "                              # Tamaño de bloque de salida
    <> "    "                           # Identificación de la impresora
    <> "0000000"                        # Reservado para uso futuro
  end

  # Crea el cuerpo de la petición
  # donde van codificados los datos de la persona
  @spec build_body(Request.t()) :: String.t()
  defp build_body(request) do
    request_map = Map.from_struct(request)

    # Reduce sobre la lista de configuración y no sobre los
    # parametros, para mantener el orden en la cadena de salida
    Enum.reduce(sections_list(), "", fn {segmento, config}, acc ->
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

  # Función para construir los valores de segmento de autenticación del cliente
  @spec build_authentication(list()) :: String.t()
  defp build_authentication(values) do
    auth = autenticacion()
    acc = "AU03RCN000120125                         "

    # ¿Hay valores del segmento?
    if values != nil do
      # Agrega los valores
      acc <> build_tag_values(auth[:tags], values)
    end
  end

  # Función para construir el segmento de fin de petición
  @spec build_end(String.t()) :: String.t()
  defp build_end(request_string) do
    # Retorna el tamaño de la cadena de petición
    # Siempre es una cadena de 5 caracteres, si hace
    # falta se agregan ceros a la izquierda
    number_with_pad =
      request_string
      |> String.length() # 17 del tamaño de este segmento
      |> Kernel.+(100_017)
      |> to_string()
      |> String.slice(1..-1)

    "ES05" <> number_with_pad <> "0002**"
  end

  # Función para construir los valores de las etiquetas de un segmento
  # Nombre + tamaño + valor
  @spec build_tag_values(list(), list()) :: String.t()
  defp build_tag_values(tags, values) do
    Enum.reduce(tags, "", fn {key, tag}, acc ->
      value = Map.get(values, key)

      if value != nil do
        acc <> tag <> size_of(value) <> value
      else
        acc
      end
    end)
  end

  # Retorna el número de caracteres de una cadena
  # El valor retornado siempre estará expresado en dos caracteres
  # i.e '12'
  # Si el valor es menor a 10, comenzará con 0
  # i.e '02'
  @spec size_of(String.t()) :: String.t()
  defp size_of(string) do
    size = String.length(string)

    cond do
      size < 10 -> "0#{size}"
      size > 99 -> raise "El valor es demasiado grande para ser codificado"
      true -> "#{size}"
    end
  end
end
