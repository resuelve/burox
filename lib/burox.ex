defmodule Burox do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  alias Burox.Request
  alias Burox.Request.Encoder
  alias Burox.Response.Parser
  alias Burox.Utils
  alias Burox.Utils.Validator

  require Logger

  @doc """
  Solicita la información crediticia de una persona al buró de crédito
  ## Ejemplos

  iex> Burox.solicitar{%Burox.Request{}}
  {:ok, term}

  """
  @spec solicitar(Request.t()) :: {:ok, term} | {:error, term}
  def solicitar(peticion) do
    solicitar(peticion, "507")
  end

  @doc """
  Solicita la información crediticia de una persona al buró de crédito
  ## Ejemplos

      iex> Burox.solicitar{%Burox.Request{}, "507"}
      {:ok, term}

  """
  @spec solicitar(Request.t(), String.t()) :: {:ok, term} | {:error, term}
  def solicitar(data, codigo_producto) do

    with {:ok, request} <- Validator.valid?(data) do
      request_string = Encoder.encode_buro(request, codigo_producto)
      buro_service = Application.get_env(:burox, :buro_service)

      with {:ok, buro_response} <- buro_service.post(request_string, codigo_producto) do
        response = Parser.process_response(buro_response)

        retorno = %{
          cadena_peticion: request_string,
          respuesta: response,
          cadena_respuesta: String.slice(buro_response, 0..-2)
        }

        {:ok, retorno}
      end
    end
  end
end
