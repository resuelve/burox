defmodule EncoderTest do
  use ExUnit.Case

  import Burox.Request.Encoder
  alias Burox.Request

  @sample_request %Request{
    persona: %{
      apellido_paterno: "MENDEZ",
      apellido_materno: "GONZALEZ",
      primer_nombre: "ANTUANET",
      rfc: "MEGA510503RE3"
    },
    direccion: %{
      primera_linea_de_direccion: "PICO DE VERAPAZ 435 PISO 5",
      colonia: "JARDINES EN LA MONTANA",
      municipio: "TLALPAN",
      ciudad: "MEXICO",
      estado: "CDMX",
      codigo_postal: "14210",
      origen_del_domicilio: "MX"
    }
  }

  @sample_request_auth %Request{
    autenticacion: %{
      cuenta_con_tarjeta_de_credito: "V",
      ultimos_cuatro_digitos: "7890",
      ha_ejercido_un_credito_hipotecario: "F",
      ha_ejercido_un_credito_automotriz_en_los_ultimos_24_meses: "V"
    },
    persona: %{
      apellido_paterno: "MENDEZ",
      apellido_materno: "GONZALEZ",
      primer_nombre: "ANTUANET",
      rfc: "MEGA510503RE3"
    },
    direccion: %{
      primera_linea_de_direccion: "PICO DE VERAPAZ 435 PISO 5",
      colonia: "JARDINES EN LA MONTANA",
      municipio: "TLALPAN",
      ciudad: "MEXICO",
      estado: "CDMX",
      codigo_postal: "14210",
      origen_del_domicilio: "MX"
    }
  }

  @sample_response "INTL13                         507MX0000userpasswordICCMX000000000SP01     0000000PN06MENDEZ0008GONZALEZ0208ANTUANET0513MEGA510503RE3PA26PICO DE VERAPAZ 435 PISO 50122JARDINES EN LA MONTANA0207TLALPAN0306MEXICO0404CDMX0505142101302MXES05002500002**"

  @sample_response_auth "AU03RCN000120125                         0201V040478900701F1101VINTL13                         007MX0000userpasswordICCMX000000000SP01     0000000PN06MENDEZ0008GONZALEZ0208ANTUANET0513MEGA510503RE3PA26PICO DE VERAPAZ 435 PISO 50122JARDINES EN LA MONTANA0207TLALPAN0306MEXICO0404CDMX0505142101302MXES05003140002**"

  test "Encode Request to string used in Buro de Crédito" do
    assert @sample_response == @sample_request |> encode_buro("507") |> String.slice(0..-2)
  end

  test "Encode Request with authentication" do
    assert @sample_response_auth == @sample_request_auth |> encode_buro("007") |> String.slice(0..-2)
  end

end
