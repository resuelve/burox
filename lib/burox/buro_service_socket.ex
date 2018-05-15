defmodule Burox.BuroService.Socket do
  @moduledoc """
  Este módulo contiene la lógica para mandar y
  recibir información del Buró de Crédito
  """
  @behaviour Burox.BuroService

  require Logger

  @doc """
  Función para consultar información del Buró de Crédito
  De manera síncrona
  """
  @spec post(String.t, String.t) :: String.t
  def post(data, codigo_producto) do

    config_url = if codigo_producto == "107", do: :buro_url_prospector, else: :buro_url
    buro_url = Application.get_env(:burox, config_url)
    Logger.info "URL del Buró: #{buro_url}"

    if is_nil(buro_url) do
      raise Burox.Error, message: "Debe configurarse la url del Buró de Crédito"
    end

    with {:ok, sock} <- Socket.connect(buro_url) do
      Logger.info "Connected"
      Socket.Stream.send!(sock, data <> <<19>>)
      response = get_response(sock)

      if response == "" do
        {:error, %{error: %{message: "No se pudo obtener respuesta del Buró de Crédito"}}}
      else
        {:ok, response}
      end
    else
      {:error, reason} -> {:error, reason}
       _ -> {:error, %{error: %{message: "No se puede conectar al Buró de Crédito"}}}
    end
  end

  # Concatena toda la respuesta del Stream
  defp get_response(sock) do
    case Socket.Stream.recv!(sock) do
      nil -> ""
      chunk -> chunk <> get_response(sock)
    end
  end

end
