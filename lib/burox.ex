defmodule Burox do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  alias Burox.Request
  alias Burox.Request.Encoder
  alias Burox.Response.Parser
  alias Burox.Utils

  @buro_service Application.get_env(:burox, :buro_service)

  @doc """
  Solicita la información crediticia de una persona al buró de crédito
  ## Ejemplos

      iex> Burox.solicitar{%Burox.Request{}}
      {:ok, term}

  """
  @spec solicitar(Request.t) :: {:ok, term} | {:error, term}
  def solicitar(data) do
    peticion = Utils.to_struct(data, Burox.Request)
    # IO.inspect peticion

    request_string = Encoder.encode_buro(peticion)
    # IO.inspect request_string

    with {:ok, buro_response} <- @buro_service.post(request_string) do
      IO.inspect buro_response

      response = Parser.process_response(buro_response)
      IO.inspect response

      case peticion do
        %Request{} -> {:ok, response}
        _ -> {:error, "error"}
      end
    end

  end

end
