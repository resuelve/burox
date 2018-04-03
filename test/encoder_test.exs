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

  @sample_response "INTL13                         507MX0000userpasswordICCMX000000000SP01     000000PN06MENDEZ0008GONZALEZ0208ANTUANET0513MEGA510503RE3PA26PICO DE VERAPAZ 435 PISO 50122JARDINES EN LA MONTANA0207TLALPAN0306MEXICO0404CDMX0505142101302MX"

  test "Encode Request to string used in Buro de Crédito" do
    assert encode_buro(@sample_request, "507") == @sample_response
  end

end
