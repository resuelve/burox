defmodule Burox do
  @moduledoc """
  Documentation for Burox.
  """
  alias Burox.Request

  @doc """
  Request the credit information to the Buro de Crédito

  ## Examples

      iex> Burox.request_info{%Burox.Request{}}
      {:ok}

  """
  def request_info(data) do
    request = struct!t statsu(Request, data)
    case request do
      %Request{} -> {:ok}
      _ -> {:error}
    end
  end
end
