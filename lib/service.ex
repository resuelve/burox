defmodule Burox.Service do
  @moduledoc false

  @doc """
  Function to request info to Buro de Crédito synchronously
  """
  @spec post(String.t) :: String.t
  def post(data) do
    {:ok, sock} = Socket.connect(Application.get_env(:burox, :buro_url))
    Socket.Stream.send!(sock, cadena)
    Socket.Stream.recv!(sock)
  end

end
