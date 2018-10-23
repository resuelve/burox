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
    response_map = %{
      cadena_peticion: "",
      cadena_respuesta: ""
    }

    with {:ok, request} <- Validator.valid?(data) do
      buro_service = Application.get_env(:burox, :buro_service)
      request_string = Encoder.encode_buro(request, codigo_producto)
      with {:ok, buro_response} <- buro_service.post(request_string, codigo_producto) do
        result = Map.merge(
          response_map,
          %{
            cadena_peticion: request_string,
            cadena_respuesta: String.slice(buro_response, 0..-2),
            respuesta: Parser.process_response(buro_response)
          }
        )
        {:ok, result}
      end
    else
      {:error, errors} ->
        # Traduce los errores de validación de campos a un mapa.
        error_list = Enum.map(errors, fn {e, k, s, v} -> {"#{k}(#{s})", v}end)
        {:error, Map.put(response_map, :respuesta , error_list)}
    end

  end

end
