defmodule Burox.Request.Config do
  @moduledoc false

  @authentication %{
    key: "AU",
    tags: [
      tipo_reporte: "",
      tipo_salida: "00",
      referencia_del_operador: "01",
      cuenta_con_tarjeta_de_credito: "02",
      ultimos_cuatro_digitos: "04",
      ha_ejercido_un_credito_hipotecario: "07",
      ha_ejercido_un_credito_automotriz_en_los_ultimos_24_meses: "11"
    ]
  }

  @sections_list [
    persona: %{
      key: "PN",
      tags: [
        apellido_paterno: "",
        apellido_materno: "00",
        primer_nombre: "02",
        segundo_nombre: "03",
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

  def autenticacion, do: @authentication

end
