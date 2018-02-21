defmodule Burox do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  alias Burox.Request

  @doc """
  Solicita la información crediticia de una persona al buró de crédito
  ## Ejemplos

      iex> Burox.solicitar{%Burox.Request{}}
      {:ok, term}

  """
  @spec solicitar(Request.t) :: {:ok, term} | {:error, term}
  def solicitar(data) do
    peticion = struct(Request, data)
    case peticion do
      %Request{} -> {:ok}
      _ -> {:error}
    end
  end
end
