defmodule Burox do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  alias Burox.Request
  alias Burox.Request.Encoder
  alias Burox.Response.Parser
  alias Burox.Utils.Validator

  require Logger

  @doc """
  Solicita la información crediticia de una persona al buró de crédito
  ## Examples

      iex> Burox.solicitar{%Burox.Request{}, "507"}
      {:ok, term}

  """
  @spec solicitar(Request.t(), String.t(), boolean()) :: {:ok, term} | {:error, term}
  def solicitar(data, codigo_producto \\"507", special \\ false) do
    response_map = %{
      cadena_peticion: "",
      cadena_respuesta: ""
    }

    # Valida los datos de la petición
    with {:ok, request} <- Validator.valid?(data) do
      buro_service = Application.get_env(:burox, :buro_service)
      # Convierte la petición a una cadena de texto
      request_string = Encoder.encode_buro(request, codigo_producto, special)
      # Solicita el buró
      with {:ok, buro_response} <- buro_service.post(request_string, codigo_producto) do
        parsed_response = Parser.process_response(buro_response)
        result = Map.merge(
          response_map,
          %{
            cadena_peticion: request_string,
            cadena_respuesta: String.slice(buro_response, 0..-2),
            respuesta: parsed_response
          }
        )
        case parsed_response do
          {:ok, _} ->
            {:ok, result}
          {:error, error_list} ->
            {:error, result}
        end
      end
    else
      {:error, errors} ->
        # Traduce los errores de validación de campos a un mapa.
        error_list = Enum.map(errors, fn {_e, k, s, v} -> {"#{k}(#{s})", v}end)
        {:error, Map.put(response_map, :respuesta , error_list)}
    end
  end

end
