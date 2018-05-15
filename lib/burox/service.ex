defmodule Burox.BuroService do
  @moduledoc """
  Este módulo contiene la lógica para mandar y
  recibir información del buro de crédito
  """
  @callback post(String.t(), String.t) :: String.t()
end
