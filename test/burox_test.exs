defmodule BuroxTest do
  use ExUnit.Case, async: true

  import Mox
  alias Burox.Request

@valid_person_data %Request{
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

  @invalid_person_data %{
    person: %{
      name: nil,
      middle_name: nil,
      last_name: nil,
      last_name_2: nil,
      birth_date: nil,
      rfc: nil,
    },
    address: %{
      street: nil,
      settlement: nil,
      municipality: nil,
      city: nil,
      state: nil,
      zip_code: nil
    }
  }

  # setup :verify_on_exit!

  test "Gets the information of a person in Buro de Crédito" do
    Burox.BuroService.Mock
    |> expect(:post, fn _ ->
      IO.puts "Hello mock"
      "mocked data"
    end)

    setup :set_mox_global

    # assert Burox.BuroService.Mock.post("") == "algo"

    assert Burox.solicitar(@valid_person_data) == {:ok, "data"}
  end

  test "Raises an error when library is not properly configured" do
    assert_raise Burox.Error, "Debe configurarse la url del buro", fn ->
      Burox.solicitar(@valid_person_data)
    end
  end

  test "Gets an error trying to get information of a person in Buro de Crédito" do
    Burox.BuroService.Mock
    |> expect(:post, fn _ ->
      IO.puts "Hello mock"
      "mocked data"
    end)
    assert Burox.solicitar(@invalid_person_data) == {:invalid}
  end

end
