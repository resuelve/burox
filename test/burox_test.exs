defmodule BuroxTest do
  use ExUnit.Case

  import Mox
  alias Burox.Request
  alias Burox.Request.Persona
  alias Burox.Request.Direccion

  @valid_person_data %Request{
    persona: %Persona{
      apellido_paterno: "MENDEZ",
      apellido_materno: "GONZALEZ",
      primer_nombre: "ANTUANET",
      rfc: "MEGA510503RE3"
    },
    direccion: %Direccion{
      primera_linea_de_direccion: "PICO DE VERAPAZ 435 PISO 5",
      colonia: "JARDINES EN LA MONTANA",
      municipio: "TLALPAN",
      ciudad: "MEXICO",
      estado: "CDMX",
      codigo_postal: "14210",
      origen_del_domicilio: "MX"
    }
  }

  @invalid_state_data %Request{
    persona: %Persona{
      apellido_paterno: "MENDEZ",
      apellido_materno: "GONZALEZ",
      primer_nombre: "ANTUANET",
      rfc: "MEGA510503RE3"
    },
    direccion: %Direccion{
      primera_linea_de_direccion: "PICO DE VERAPAZ 435 PISO 5",
      colonia: "JARDINES EN LA MONTANA",
      municipio: "TLALPAN",
      ciudad: "MEXICO",
      estado: "Ciudad de México",
      codigo_postal: "14210",
      origen_del_domicilio: "MX"
    }
  }

  @invalid_address_data %Request{
    persona: %Persona{
      apellido_paterno: "MENDEZ",
      apellido_materno: "GONZALEZ",
      primer_nombre: "ANTUANET",
      rfc: "MEGA510503RE3"
    },
    direccion: %Direccion{
      primera_linea_de_direccion:
        "Una direccion con una larga descripcion sin importancia. No es aceptada XD XD XD",
      colonia: "JARDINES EN LA MONTANA No 54",
      municipio: "TLALPAN",
      ciudad: "MEXICO",
      estado: "Ciudad de México",
      codigo_postal: "14210",
      origen_del_domicilio: "MX"
    }
  }

  setup [:verify_on_exit!]

  @valid_person_data_string "INTL13                         507MX0000userpasswordICCMX000000000SP01     0000000PN06MENDEZ0008GONZALEZ0208ANTUANET0513MEGA510503RE3PA26PICO DE VERAPAZ 435 PISO 50122JARDINES EN LA MONTANA0207TLALPAN0306MEXICO0404CDMX0505142101302MXES05002500002**"

  @success_response "INTL13                         MX0010Usuario12300PN06AVELAR0009HERNANDEZ0204JOSE0304LUIS0408131019830513AEHL8310136J6PA08HUERTA 10121VILLAS DE LA HACIENDA0220TLAJOMULCO DE ZUNIGA0320TLAJOMULCO DE ZUNIGA0403JAL0505456541208180720161302MXIQ08180720160110Usuario1230208RESUELVE031055864796020402CC060100701I0801Y09010IQ0818072016000400000215BURO DE CREDITO0402CC0502MX06090000000000801Y09011RS08180720160002000102000202000302000402000502000602000702000802000904000010040000110400001204000013040000140400001502001602011701Y1805NNNNN1901N210900000000022090000000002310000000000+24090000000002509000000000260300027090000000002810000000000+29090000000003009000000000310200320200330200340800000000350800000000360201370818072016380200390800000000400200410800000000SC08BC SCORE00030070104-009ES0500811001012123420590102**"

  @invalid_user_response "ERRRUR25                         0312UserPasswordES05000700002**"


  test "Gets the information of a person in Buro de Crédito" do
    Burox.BuroService.Mock
    |> expect(:post, fn _, _ ->
      {:ok, @success_response <> <<19>>}
    end)

    assert Burox.solicitar(@valid_person_data) ==
             {:ok,
              %{
                cadena_peticion: @valid_person_data_string,
                cadena_respuesta: @success_response,
                respuesta:
                  {:ok,
                   %Burox.Response{
                     consultas: [
                       %{
                         clave_del_usuario: "Usuario123",
                         fecha_de_consulta: ~D[2016-07-18],
                         importe_del_credito: "0",
                         indicador_de_cliente_nuevo: "Y",
                         nombre_del_usuario: "RESUELVE",
                         numero_telefonico_del_usuario: "5586479602",
                         reserved: "0",
                         tipo_de_producto: "CC",
                         tipo_de_responsabilidad_de_la_cuenta: "I"
                       },
                       %{
                         clave_del_usuario: "Usuario123",
                         fecha_de_consulta: ~D[2016-07-18],
                         importe_del_credito: "000000000",
                         indicador_de_cliente_nuevo: "Y",
                         moneda_del_credito: "MX",
                         nombre_del_usuario: "BURO DE CREDITO",
                         numero_telefonico_del_usuario: "5586479602",
                         reserved: "1",
                         tipo_de_producto: "CC",
                         tipo_de_responsabilidad_de_la_cuenta: "I"
                       }
                     ],
                     creditos: [],
                     declarativa_consumidor: %{},
                     direcciones: [
                       %{
                         ciudad: "TLAJOMULCO DE ZUNIGA",
                         codigo_postal: "45654",
                         colonia: "VILLAS DE LA HACIENDA",
                         estado: "JAL",
                         fecha_de_reporte_de_la_direccion: ~D[2016-07-18],
                         municipio: "TLAJOMULCO DE ZUNIGA",
                         origen_del_domicilio: "MX",
                         primera_linea_de_direccion: "HUERTA 1"
                       }
                     ],
                     direcciones_de_trabajo: [],
                     error: %Burox.Response.ErrorUser{
                       clave_de_usuario_o_contrasena_erronea: nil,
                       error_en_el_sistema_de_buro_de_credito: nil,
                       etiqueta_de_segmento__erronea: nil,
                       expediente_bloqueado_para_consulta: nil,
                       falta_campo_requerido: nil,
                       informacion_erronea_para_consulta: nil,
                       numero_de_referencia_del_operador: nil,
                       numero_erroneo_de_segmentos: nil,
                       orden_erroneo_del_segmento: nil,
                       producto_solicitado_erroneo: nil,
                       segmento_requerido_no_proporcionado: nil,
                       solicitud_del_cliente_erronea: nil,
                       ultima_informacion_valida_del_cliente: nil,
                       valor_erroneo_en_una_campo_relacionado: nil,
                       version_proporcionada_erronea: nil
                     },
                     fin: %{
                       fin_del_registro_de_respuesta: "**",
                       longitud_de_transmision: 811,
                       numero_de_control_de_la_consulta: "1212342059"
                     },
                     hawk_inquiry: %{},
                     hawk_response: [],
                     persona: %{
                       apellido_materno: "HERNANDEZ",
                       apellido_paterno: "AVELAR",
                       fecha_de_nacimiento: ~D[1983-10-13],
                       primer_nombre: "JOSE",
                       rfc: "AEHL8310136J6",
                       segundo_nombre: "LUIS"
                     },
                     resumen: %{
                       fecha_de_apertura_de_cuenta_mas_reciente: nil,
                       fecha_de_apertura_mas_reciente_de_una_cuenta_en_despacho_de_cobranza: nil,
                       total_de_importe_de_pago_para_cuentas_revolventes: 0.0,
                       numero_de_cuentas: 0,
                       total_de_saldos_vencidos_para_cuentas_revolventes: 0.0,
                       numero_de_solicitudes_de_informe_de_buro: 1,
                       numero_de_solicitudes_del_informe_buro_realizadas_por_despachos_de_cobranza:
                         0,
                       total_de_saldos_vencidos_para_cuentas_de_pagos_fijos_e_hipotecarios: 0,
                       numero_de_cuentas_con_MOP_98: 0,
                       total_de_limites_de_credito_para_cuentas_revolventes: 0.0,
                       numero_de_cuentas_con_historial_de_morosidad_actual: 0,
                       total_de_creditos_maximos_para_cuentas_de_pagos_fijos_e_hipotecarios: 0,
                       fecha_de_integracion: ~D[2016-07-18],
                       numero_de_cuentas_en_aclaracion: 0,
                       numero_de_cuentas_con_morosidad_actual: 0,
                       fecha_de_apertura_de_cuenta_mas_antigua: nil,
                       nueva_direccion_en_los_ultimos_60_dias: "Y",
                       numero_de_cuentas_de_pagos_fijos_e_hipotecario: 0,
                       numero_de_cuentas_con_MOP_07: 0,
                       numero_de_cuentas_revolventes_y_sin_limite_establecido: 0,
                       numero_de_cuentas_con_MOP_01: 0,
                       declarativa: "N",
                       fecha_de_la_consulta_mas_reciente_realizada_por_un_despacho_de_cobranza:
                         nil,
                       numero_de_cuentas_con_MOP_05: 0,
                       total_de_saldos_actuales_para_cuentas_revolventes: 0.0,
                       mensaje_de_alerta: "NNNNN",
                       numero_de_cuentas_cerradas: 0,
                       numero_de_cuentas_con_MOP_97: 0,
                       total_de_creditos_maximos_para_cuentas_revolventes: 0.0,
                       numero_de_cuentas_con_MOP_03: 0,
                       numero_de_solicitudes_de_consulta: 1,
                       numero_de_cuentas_con_MOP_00: 0,
                       numero_de_cuentas_con_MOP_96: 0,
                       total_de_importe_de_pago_para_cuentas_de_pagos_fijos_e_hipotecarios: 0,
                       number_of_accounts_with_MOP_03: 0,
                       numero_de_cuentas_con_MOP_02: 0,
                       numero_de_cuentas_con_MOP_06: 0,
                       porcentaje_del_limite_de_credito_utilizado_para_cuentas_revolventes: 0.0,
                       numero_de_cuentas_con_MOP_UR: 0,
                       fecha_de_la_consulta_mas_reciente: ~D[2016-07-18],
                       total_de_saldos_actuales_para_cuentas_de_pagos_fijos_e_hipotecarios: 0.0,
                       numero_de_cuentas_en_despacho_de_cobranza: 0
                     },
                     score: %{
                       codigo_del_score: "007",
                       nombre_del_score: "BC SCORE",
                       valor_del_score: -9,
                       valor_de_exclusion: "Expediente sin cuentas para cálculo de BC-Score"
                     }
                   }}
              }}
  end

  test "Gets a generic error when trying to get information of a person in Buro de Crédito" do
    Burox.BuroService.Mock
    |> expect(:post, fn _, _ ->
      {:ok, "ERRRUR25                         1101YES05000530002**"}
    end)

    assert Burox.solicitar(@valid_person_data) ==
             {:ok,
              %{
                cadena_respuesta: "ERRRUR25                         1101YES05000530002**",
                respuesta: {:error, [
                               error_en_el_sistema_de_buro_de_credito: "Y",
                               numero_de_referencia_del_operador: "                         "]},
                cadena_peticion: @valid_person_data_string
              }}
  end

  test "Gets an error when the request sent is invalid" do
    Burox.BuroService.Mock
    |> expect(:post, fn _, _ ->
      {:ok, @invalid_user_response <> <<19>>}
    end)

    assert Burox.solicitar(@valid_person_data) ==
             {:ok,
              %{
                cadena_peticion: @valid_person_data_string,
                cadena_respuesta: @invalid_user_response,
                respuesta: {:error, [
                               clave_de_usuario_o_contrasena_erronea: "UserPassword",
                               numero_de_referencia_del_operador: "                         "]
                }
              }
             }
  end

  test "Gets an error trying to autenticate a client in Buro de Crédito" do
    Burox.BuroService.Mock
    |> expect(:post, fn _, _ ->
      {:ok, "ERRRAR25                         0014NO AUTENTICADOES05000660002**"}
    end)

    assert Burox.solicitar(@valid_person_data) ==
    {:ok, %{
        cadena_peticion:  @valid_person_data_string,
        cadena_respuesta: "ERRRAR25                         0014NO AUTENTICADOES05000660002**",
        respuesta: {:error, [
                       numero_de_referencia_del_operador: "                         ",
                       solicitud_del_cliente_erronea: "NO AUTENTICADO"]}
     }
    }
  end

  test "Gets an error trying to send an invalid address" do
    assert Burox.solicitar(@invalid_address_data) ==
    {:error, %{
        cadena_peticion: "",
        cadena_respuesta: "",
        respuesta: [
          {"primera_linea_de_direccion(length)", "must have a length of no more than 40"},
          {"primera_linea_de_direccion(format)", "must have the correct format"}]}
    }

  end

  test "Change the code when trying to send an invalid state" do
    Burox.BuroService.Mock
    |> expect(:post, fn _, _ ->
      {:ok, @success_response <> <<19>>}
    end)

    result = Burox.solicitar(@invalid_state_data)
    assert elem(result, 0) == :ok
  end
end
