defmodule Burox do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  alias Burox.Request
  alias Burox.Request.Encoder
  alias Burox.Response.Parser
  alias Burox.Utils

  require Logger

  @doc """
  Solicita la información crediticia de una persona al buró de crédito
  ## Ejemplos

  iex> Burox.solicitar{%Burox.Request{}}
  {:ok, term}

  """
  @spec solicitar(Request.t) :: {:ok, term} | {:error, term}
  def solicitar(peticion) do
    solicitar(peticion, "507")
  end


  @doc """
  Solicita la información crediticia de una persona al buró de crédito
  ## Ejemplos

      iex> Burox.solicitar{%Burox.Request{}, "507"}
      {:ok, term}

  """
  @spec solicitar(Request.t, String.t) :: {:ok, term} | {:error, term}
  def solicitar(data, codigo_producto) do
    peticion = Utils.to_struct(data, Burox.Request)
    Logger.info "Petición:\n#{inspect peticion}"

    request_string = Encoder.encode_buro(peticion, codigo_producto)
    Logger.info "Cadena de petición:\n#{inspect request_string}"

    buro_service = Application.get_env(:burox, :buro_service)

    with {:ok, buro_response} <- buro_service.post(request_string) do
      Logger.info "Respuesta del buro: \n #{buro_response}"

      response = Parser.process_response(buro_response)
      Logger.info "Respuesta:\n#{inspect response}"

      retorno = %{
        "cadena_peticion" => request_string,
        "respuesta" => response,
        "cadena_respuesta" => buro_response
      }

      case peticion do
        %Request{} -> {:ok, retorno}
        _ -> {:error, retorno}
      end
    end

  end

end
