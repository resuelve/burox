defmodule Burox do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  alias Burox.Request

  @doc """
  Request the credit information to the Buro de Crédito

  ## Examples

      iex> Burox.request{%Burox.Request{}}
      {:ok, term}

  """
  @spec request(Burox.Request.t) :: {:ok, term} | {:error, term}
  def request(data) do
    request = struct(Request, data)
    case request do
      %Request{} -> {:ok}
      _ -> {:error}
    end
  end
end
