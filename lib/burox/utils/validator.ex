defmodule Burox.Utils.Validator do
  @moduledoc """
  Sirve para validar los parámetros en la petición del Buró
  """
  alias Burox.Request
  alias Burox.Request.Direccion
  alias Burox.Utils.StateCode
  alias Burox.Utils

  require Logger

  @doc """
  Valida si los datos de la petición son correctos, de lo contrario regresa
  los errores
  """
  @spec valid?(map()) :: {:ok, term} | {:error, term}
  def valid?(data) do
    request = Utils.to_struct(data, Request)

    case request do
      %Request{} ->
        if Vex.valid?(request) do
          request
          |> validate_state()
          |> validate_address()
        else
          {:error, Vex.errors(request)}
        end

      error ->
        {:error, error}
    end
  end

  @doc """
  Valida el código del estado, si es incorrecto lo cambia por uno que si lo sea
  """
  @spec validate_state(Request.t()) :: Request.t()
  def validate_state(request) do
    with %Request{direccion: address} <- request,
         %{estado: state_code} <- address do
      # address = struct(Direccion, address)

      new_code = if StateCode.valid?(state_code), do: state_code, else: StateCode.assign(state_code)
        %Request{request | direccion: %Direccion{address | estado: new_code}}
     end
  end

  # Valida si los datos enviados en la dirección son correctos
  defp validate_address(request) do
    if Direccion.valid?(request.direccion) do
      {:ok, request}
    else
      {:error, Vex.errors(request.direccion)}
    end
  end

end
