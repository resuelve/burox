defmodule Burox.Utils.StateCode do
  @moduledoc """
  Módulo que ayuda a asignar el código correcto para cada Estado o
  vaidar si un código dado en correcto
  """

  @states_codes [
    Mexico: "EM",
    CDMX: "CDMX",
    Aguascalientes: "AGS",
    "Baja California": "BCN",
    "Baja California Sur": "BCN",
    Campeche: "CAM",
    Chiapas: "CHS",
    Chihuahua: "CHI",
    "Ciudad de México": "CDMX",
    Coahuila: "COA",
    Colima: "COL",
    Durango: "DGO",
    "Estado de México": "EM",
    Guanajuato: "GTO",
    Guerrero: "GRO",
    Hidalgo: "HGO",
    Jalisco: "JAL",
    "Michoacán": "MICH",
    Morelos: "MOR",
    Nayarit: "NAY",
    "Nuevo León": "NL",
    Oaxaca: "OAX",
    Puebla: "PUE",
    "Querétaro": "QRO",
    "Quintana Roo": "QR",
    "San Luis Potosí": "SLP",
    Sinaloa: "SIN",
    Sonora: "SON",
    Tabasco: "TAB",
    Tamaulipas: "TAM",
    Tlaxcala: "TLAX",
    Veracruz: "VER",
    "Yucatán": "YUC",
    Zacatecas: "ZAC"
  ]

  @doc """
  Retorna el código del Estado que más se parezca al nombre enviado
  """
  @spec assign(String.t()) :: String.t()
  def assign(state_name) do
    @states_codes
    |> Enum.max_by(fn {name, code} ->
      String.jaro_distance(state_name, to_string(name))
    end)
    |> elem(1)
  end

  @doc """
  Valida si el código pertenece a un Estado
  """
  @spec valid?(String.t()) :: bool
  def valid?(untested_code) do
    @states_codes
    |> Enum.find(fn {_name, code} -> code == untested_code end)
    |> Kernel.!=(nil)
  end
end
