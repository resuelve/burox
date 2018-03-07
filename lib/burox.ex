defmodule Burox do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  alias Burox.Request
  alias Burox.Request.Encoder
  alias Burox.Response.Parser
  alias Burox.Utils

  require Logger

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
    Logger.info "Peticion:\n#{inspect peticion}"

    request_string = Encoder.encode_buro(peticion)
    Logger.info "Request:\n#{inspect request_string}"

    with {:ok, buro_response} <- Burox.BuroService.Socket.post(request_string) do
      response = Parser.process_response(buro_response)
      Logger.info "Response:\n#{inspect response}"

      case peticion do
        %Request{} -> {:ok, response}
        _ -> {:error, "error"}
      end
    end

  end

end
