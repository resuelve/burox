defmodule Burox do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  alias Burox.Request
  alias Burox.Request.Encoder
  alias Burox.Response.Parser
  alias Burox.Utils.Validator
  alias Burox.Utils.Strip

  require Logger

  @doc """
  Solicita la información crediticia de una persona al buró de crédito
  ## Examples

      iex> Burox.solicitar{%Burox.Request{}, "507"}
      {:ok, term}

  """
  @spec solicitar(Request.t(), map()) :: {:ok, map()} | {:error, map()}
  def solicitar(data, config \\ %{}) doL
    product_code = Map.get(config, :product_code, "507")
    special = Map.get(config, :special, false)
    credentials = Map.get(config, :credentials, "fmg")
    response_map = %{
      cadena_peticion: "",
      cadena_respuesta: ""
    }

    Logger.info(inspect(data))
    Logger.info(inspect(config))

    with {:ok, request} <- Validator.valid?(data) do
      buro_service = Application.get_env(:burox, :buro_service)
      # Convierte la petición a una cadena de texto
      request_string = Encoder.encode_buro(request, product_code, special, credentials)

      Logger.info(request_string)

      with {:ok, buro_response} <- buro_service.post(request_string, product_code) do
        parsed_response = Parser.process_response(buro_response)
        response_string =
          buro_response
          |> Strip.strip_utf()
          |> String.slice(0..-2)

        result = Map.merge(
          response_map,
          %{
            cadena_peticion: request_string,
            cadena_respuesta: response_string,
            respuesta: parsed_response
          }
        )

        case parsed_response do
          {:ok, _} ->
            {:ok, result}
          {:error, error_list} ->
            {:error, result |> Map.put(:respuesta, error_list)}
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
