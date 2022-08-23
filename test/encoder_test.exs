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

  describe "Encode request" do
    test "with score code, it should return prospector credentials" do
      assert encode_buro(@sample_request, "107") ==
        get_sample_response("11", "107", "user_prospector", "password_prospector", "00272")
    end

    test "by default, it should return the default credentials" do
      assert encode_buro(@sample_request) ==
        get_sample_response("13", "507", "user", "password", "00250")
    end

    test "with sae credential type, it should return sae credentials" do
      assert encode_buro(@sample_request, "507", false, "sae") ==
        get_sample_response("13", "507", "user_sae", "password_sae", "00258")
    end

    test "for special report from buro, it should return special credentials" do
      assert encode_buro(@sample_request, "507", true) ==
        get_sample_response("13", "507", "user_special", "password_special", "00266")
    end

    test "for special report from buro and sae type it should return special sae credentials" do
      assert encode_buro(@sample_request, "507", true, "sae") ==
        get_sample_response("13", "507", "user_special_sae", "password_special_sae", "00274")
    end
  end

  describe "Encode request with authentication" do
    test "with score code, it should return prospector credentials" do
      assert encode_buro(@sample_request_auth, "107") ==
        get_sample_response("11", "107", "user_prospector", "password_prospector", "00336", true)
    end

    test "by default, it should return the default credentials" do
      assert encode_buro(@sample_request_auth) ==
        get_sample_response("13", "507", "user", "password", "00314", true)
    end

    test "with sae credential type, it should return sae credentials" do
      assert encode_buro(@sample_request_auth, "507", false, "sae") ==
        get_sample_response("13", "507", "user_sae", "password_sae", "00322", true)
    end

    test "for special report from buro, it should return special credentials" do
      assert encode_buro(@sample_request_auth, "507", true) ==
        get_sample_response("13", "507", "user_special", "password_special", "00330", true)
    end

    test "for special report from buro and sae type it should return special sae credentials" do
      assert encode_buro(@sample_request_auth, "507", true, "sae") ==
        get_sample_response("13", "507", "user_special_sae", "password_special_sae", "00338", true)
    end
  end

  @spec get_sample_response(
    String.t(), String.t(), String.t(), String.t(), String.t(), boolean()
  ) :: String.t()
  defp get_sample_response(version, product_code, user, password, padded, auth \\ false) do
    header =
      if auth, do: "AU03RCN000120125                         0201V040478900701F1101V", else: ""

    "#{header}INTL#{version}                         #{product_code}MX0000#{user}#{password}" <>
    "ICCMX000000000SP01     0000000PN06MENDEZ0008GONZALEZ0208ANTUANET0513MEGA510503RE3PA26" <>
    "PICO DE VERAPAZ 435 PISO 50122JARDINES EN LA MONTANA0207TLALPAN0306MEXICO0404CDMX" <>
    "0505142101302MXES05" <> padded <> "0002**"
  end
end
