defmodule EncoderTest do
  use ExUnit.Case

  import Burox.Request.Encoder
  alias Burox.Request

  @sample_request %Request{
    encabezado: %{
      codigo_de_producto: "007",
      pais: "MX",
      clave_del_usuario: "Resuelve",
      buro_user: "",
      buro_password: ""
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

  @sample_response "INTL13                         007MX0000ICCMX000050000SP01     000000PN06MENDEZ0008GONZALEZ0208ANTUANET0513MEGA510503RE3PA26PICO DE VERAPAZ 435 PISO 50122JARDINES EN LA MONTANA0207TLALPAN0306MEXICO0404CDMX0505142101302MX"

  test "Encode Request to string used in Buro de Crédito" do
    # IO.inspect "#{encode_buro(@sample_request)}"
    assert encode_buro(@sample_request) == @sample_response
  end

end
