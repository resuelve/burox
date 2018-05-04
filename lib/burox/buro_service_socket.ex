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
  @spec post(String.t) :: String.t
  def post(data) do
    buro_url = Application.get_env(:burox, :buro_url)
    Logger.info "URL del Buró: #{buro_url}"

    if is_nil(buro_url) do
      raise Burox.Error, message: "Debe configurarse la url del Buró de Crédito"
    end

    with {:ok, sock} <- Socket.connect(buro_url) do
      Logger.info "Connected"
      Socket.Stream.send!(sock, data)
      response = sock
      |> Socket.Stream.recv!()

      if response == "" do
        {:error, %{error: %{message: "No se pudo obtener respuesta del Buró de Crédito"}}
      else
        {:ok, response}
      end
    else
      {:error, reason} -> {:error, reason}
    _ -> {:error, %{error: %{message: "No se puede conectar al Buró de Crédito"}}
    end
  end

end
