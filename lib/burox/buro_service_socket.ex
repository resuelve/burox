defmodule Burox.BuroService.Socket do
  @moduledoc """
  Este módulo contiene la lógica para mandar y
  recibir información del buro de crédito
  """
  @behaviour Burox.BuroService

  require Logger

  @doc """
  Función para consultar información del buro
  De manera sincrona
  """
  @spec post(String.t) :: String.t
  def post(data) do
    buro_url = Application.get_env(:burox, :buro_url)
    Logger.info "Buro url: #{buro_url}"

    if is_nil(buro_url) do
      raise Burox.Error, message: "Debe configurarse la url del buro"
    end

    with {:ok, sock} <- Socket.connect(buro_url) do
      Logger.info "Connected"
      Socket.Stream.send!(sock, data)
      Socket.Stream.recv!(sock)
    else
      {:error, reason} -> {:error, reason}
    _ -> {:error, "No se puede conectar al Buro de Crédito"}
    end
  end

end
