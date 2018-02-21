defmodule Burox.Request.Config do
  @moduledoc false

  @sections_sorted [
    :persona,
    :direccion
  ]

  @sections_list [
    persona: %{
      key: "PN",
      tags: [
        apellido_paterno: "",
        apellido_materno: "00",
        primer_nombre: "02",
        rfc: "05"
      ]
    },
    direccion: %{
      key: "PA",
      tags: [
        primera_linea_de_direccion: "",
        segunda_linea_de_direccion: "00",
        colonia: "01",
        municipio: "02",
        ciudad: "03",
        estado: "04",
        codigo_postal: "05",
        origen_del_domicilio: "13"
      ]
    }
  ]

  def sections_list, do: @sections_list


end
