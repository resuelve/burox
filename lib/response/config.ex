defmodule Burox.Response.Config do
  @moduledoc false

  @score_reasons %{
    "1" => "Nivel de endeudamiento",
    "4" => "Consulta reciente",
    "5" => "Pago vencido reciente",
    "7" => "Cuentas abiertas con morosidad",
    "9" => "Bajo promedio de antigüedad en créditos abiertos",
    "12" => "Tipo de crédito con mayor riesgo",
    "13" => "Número de cuentas abiertas",
    "14" => "Relación entre créditos revolventes y no revolventes",
    "15" => "Utilización significativa de límites de crédito revolventes",
    "16" => "Tiempo desde última cuenta aperturada",
    "17" => "Meses desde último atraso",
    "18" => "Duración de cuenta abierta más antigua",
    "20" => "Relación entre cuentas con morosidad y sin morosidad",
    "21" => "Atrasos frecuentes o recientes",
    "24" => "Créditos con morosidad importante",
    "27" => "Varios créditos cerrados",
    "28" => "Proporción alta de saldos contra crédito máximo ",
    "29" => "Proporción de cuentas nuevas en los últimos 24 meses",
    "31" => "Atrasos frecuentes o recientes",
    "32" => "Relación entre experiencias con y sin morosidad",
    "33" => "Tipo de crédito con mayor riesgo",
    "34" => "Cuentas con morosidad reciente",
    "51" => "Pago adecuado del crédito",
    "52" => "Pago adecuado del crédito",
    "53" => "Pagos adecuados de los créditos",
    "54" => "Pagos adecuados de los créditos",
    "55" => "Créditos con morosidad",
    "56" => "Créditos nuevos con morosidad",
    "57" => "Créditos con historial de morosidad",
    "58" => "Créditos con atrasos",
    "59" => "Créditos con atrasos mayores a 90 días",
    "60" => "Créditos con atrasos mayores a 90 días",
    "61" => "Créditos con atrasos mayores a 90 días"
  }

  @score_errors %{
    "1" => "Solicitud No Autorizada",
    "2" => "Solicitud de Score Invalida",
    "3" => "Score No Disponible"
  }

  @score_exclusion %{
    "-1" => "☠️Consumidor fallecido",
    "-5" => "Expediente con todas las cuentas cerradas y por lo menos con una en atraso mayor o igual a 90 días",
    "-6" => "Expediente con todas sus cuentas con antigüedad menor a 6 meses y al menos una tiene MOP >= 03",
    "-7" => "Expediente con todas sus cuentas con antigüedad menor a 6 meses y al menos una tiene MOP >= 02",
    "-8" => "Expediente no tiene al menos una cuenta actualizada en el último año o con antigüedad mínima de 6 meses, y/o con cuentas que no se incluyen en el cálculo del BC-Score",
    "-9" => "Expediente sin cuentas para cálculo de BC-Score"
  }

  @doc """
  Regresa la descripción del código de exclusión
  """
  def score_exclusion(score_value) when is_number(score_value) do
    Map.get(@score_exclusion, Integer.to_string(score_value))
  end

  @doc """
  En este mapa se definen los nombres de los campos y
  cómo deben tratarse al ser parseados
  """
  @spec sections_map() :: map
  def sections_map do
  %{
    "PN" => %{
      "key" => :persona,
      "struct" => Burox.Response.Persona,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :apellido_paterno,
          "type" => "string"
        },
        "00" => %{
          "key" => :apellido_materno,
          "type" => "string"
        },
        "01" => %{
          "key" => :apellido_adicional,
          "type" => "string"
        },
        "02" => %{
          "key" => :primer_nombre,
          "type" => "string"
        },
        "03" => %{
          "key" => :segundo_nombre,
          "type" => "string"
        },
        "04" => %{
          "key" => :fecha_de_nacimiento,
          "type" => "date"
        },
        "05" => %{
          "key" => :rfc,
          "type" => "string"
        },
        "06" => %{
          "key" => :prefijo_personal,
          "type" => "string"
        },
        "07" => %{
          "key" => :sufijo_personal,
          "type" => "string"
        },
        "08" => %{
          "key" => :nacionalidad,
          "type" => "string"
        },
        "09" => %{
          "key" => :tipo_de_residencia,
          "type" => "string"
        },
        "10" => %{
          "key" => :numero_de_licencia_de_conducir,
          "type" => "string"
        },
        "11" => %{
          "key" => :estado_civil,
          "type" => "string"
        },
        "12" => %{
          "key" => :genero,
          "type" => "string"
        },
        "13" => %{
          "key" => :numero_de_cedula_profesional,
          "type" => "string"
        },
        "14" => %{
          "key" => :numero_de_registro_electoral,
          "type" => "string"
        },
        "15" => %{
          "key" => :curp,
          "type" => "string"
        },
        "16" => %{
          "key" => :clave_de_pais,
          "type" => "string"
        },
        "17" => %{
          "key" => :numero_de_dependientes,
          "type" => "string"
        },
        "18" => %{
          "key" => :edades_de_los_dependientes,
          "type" => "string"
        },
        "19" => %{
          "key" => :fecha_de_recepcion_de_informacion_de_los_dependientes,
          "type" => "date"
        },
        "20" => %{
          "key" => :fecha_de_defuncion,
          "type" => "date"
        }
      }
    },
    "PA" => %{
      "key" => :direcciones,
      "struct" => Burox.Response.Direccion,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :primera_linea_de_direccion,
          "type" => "string"
        },
        "00" => %{
          "key" => :segunda_linea_de_direccion,
          "type" => "string"
        },
        "01" => %{
          "key" => :colonia,
          "type" => "string"
        },
        "02" => %{
          "key" => :municipio,
          "type" => "string"
        },
        "03" => %{
          "key" => :ciudad,
          "type" => "string"
        },
        "04" => %{
          "key" => :estado,
          "type" => "string"
        },
        "05" => %{
          "key" => :codigo_postal,
          "type" => "string"
        },
        "06" => %{
          "key" => :fecha_de_residencia,
          "type" => "date"
        },
        "07" => %{
          "key" => :numero_de_telefono,
          "type" => "string"
        },
        "08" => %{
          "key" => :extension_telefonica,
          "type" => "string"
        },
        "09" => %{
          "key" => :fax,
          "type" => "string"
        },
        "10" => %{
          "key" => :tipo_de_domicilio,
          "type" => "string"
        },
        "11" => %{
          "key" => :indicador_especial,
          "type" => "string"
        },
        "12" => %{
          "key" => :fecha_de_reporte_de_la_direccion,
          "type" => "date"
        },
        "13" => %{
          "key" => :origen_del_domicilio,
          "type" => "string"
        }
      }
    },
    "PE" => %{
      "key" => :direcciones_de_trabajo,
      "struct" => Burox.Response.DireccionDeTrabajo,
      "type" => "list",
      "tags" => %{
        "" => %{
        "key" => :nombre_o_razon_social_del_empleador,
        "type" => "string"
        },
        "00" => %{
          "key" => :primera_linea_de_direccion,
          "type" => "string"
        },
        "01" => %{
          "key" => :segunda_linea_de_direccion,
          "type" => "string"
        },
        "02" => %{
          "key" => :colonia,
          "type" => "string"
        },
        "03" => %{
          "key" => :municipio,
          "type" => "string"
        },
        "04" => %{
          "key" => :ciudad,
          "type" => "string"
        },
        "05" => %{
          "key" => :estado,
          "type" => "string"
        },
        "06" => %{
          "key" => :codigo_postal,
          "type" => "string"
        },
        "07" => %{
          "key" => :numero_de_telefono,
          "type" => "string"
        },
        "08" => %{
          "key" => :extension_telefonica,
          "type" => "string"
        },
        "09" => %{
          "key" => :fax,
          "type" => "string"
        },
        "10" => %{
          "key" => :ocupacion,
          "type" => "string"
        },
        "11" => %{
          "key" => :fecha_de_contratacion,
          "type" => "date"
        },
        "12" => %{
          "key" => :clave_de_la_moneda_del_sueldo,
          "type" => "string"
        },
        "13" => %{
          "key" => :salario,
          "type" => "float"
        },
        "14" => %{
          "key" => :perido_de_pago,
          "type" => "string"
        },
        "15" => %{
          "key" => :numero_de_empleado,
          "type" => "string"
        },
        "16" => %{
          "key" => :fecha_de_ultimo_dia_de_empleo,
          "type" => "date"
        },
        "17" => %{
          "key" => :fecha_de_reporte_de_empleo,
          "type" => "date"
        },
        "18" => %{
          "key" => :fecha_de_verificacion_de_empleo,
          "type" => "date"
        },
        "19" => %{
          "key" => :modo_de_verificacion,
          "type" => "string"
        },
        "20" => %{
          "key" => :origen_de_la_razon_social,
          "type" => "string"
        }
      }
    },
    "TL" => %{
      "key" => :creditos,
      "struct" => Burox.Response.Credito,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :fecha_de_actualizacion,
          "type" => "date"
        },
        "00" => %{
          "key" => :registro_impugando,
          "type" => "string"
        },
        "01" => %{
          "key" => :clave_del_usuario,
          "type" => "string"
        },
        "02" => %{
          "key" => :nombre_del_usuario,
          "type" => "string"
        },
        "03" => %{
          "key" => :numero_telefonico_del_usuario,
          "type" => "string"
        },
        "04" => %{
          "key" => :numero_de_cuenta,
          "type" => "string"
        },
        "05" => %{
          "key" => :tipo_de_responsabilidad_de_la_cuenta,
          "type" => "string"
        },
        "06" => %{
          "key" => :tipo_de_cuenta,
          "type" => "string"
        },
        "07" => %{
          "key" => :tipo_de_producto,
          "type" => "string"
        },
        "08" => %{
          "key" => :moneda_del_credito,
          "type" => "string"
        },
        "09" => %{
          "key" => :importe_del_avaluo,
          "type" => "float"
        },
        "10" => %{
          "key" => :numero_de_pagos,
          "type" => "integer"
        },
        "11" => %{
          "key" => :frecuencia_de_pagos,
          "type" => "string"
        },
        "12" => %{
          "key" => :monto_a_pagar,
          "type" => "float"
        },
        "13" => %{
          "key" => :fecha_de_apertura_de_cuenta,
          "type" => "date"
        },
        "14" => %{
          "key" => :fecha_de_ultimo_pago,
          "type" => "date"
        },
        "15" => %{
          "key" => :fecha_de_ultima_compra,
          "type" => "date"
        },
        "16" => %{
          "key" => :fecha_de_cierre,
          "type" => "date"
        },
        "17" => %{
          "key" => :fecha_de_reporte_de_informacion,
          "type" => "date"
        },
        "18" => %{
          "key" => :modo_de_reportar,
          "type" => "string"
        },
        "19" => %{
          "key" => :ultima_fecha_de_saldo_cero,
          "type" => "date"
        },
        "20" => %{
          "key" => :garantia,
          "type" => "string"
        },
        "21" => %{
          "key" => :credito_maximo_autorizado,
          "type" => "float"
        },
        "22" => %{
          "key" => :saldo_actual,
          "type" => "float"
        },
        "23" => %{
          "key" => :limite_de_credito,
          "type" => "float"
        },
        "24" => %{
          "key" => :saldo_vencido,
          "type" => "float"
        },
        "25" => %{
          "key" => :numero_de_pagos_vencidos,
          "type" => "integer"
        },
        "26" => %{
          "key" => :clasificacion_de_puntualidad_de_pago,
          "type" => "string"
        },
        "27" => %{
          "key" => :historico_de_pagos,
          "type" => "string"
        },
        "28" => %{
          "key" => :fecha_mas_reciente_del_historico_de_pagos,
          "type" => "date"
        },
        "29" => %{
          "key" => :fecha_mas_antigua_del_historico_de_pagos,
          "type" => "date"
        },
        "30" => %{
          "key" => :clave_de_observacion,
          "type" => "string"
        },
        "31" => %{
          "key" => :total_de_pagos_reportados,
          "type" => "integer"
        },
        "32" => %{
          "key" => :total_de_pagos_con_MOP_02,
          "type" => "integer"
        },
        "33" => %{
          "key" => :total_de_pagos_con_MOP_03,
          "type" => "integer"
        },
        "34" => %{
          "key" => :total_de_pagos_con_MOP_04,
          "type" => "integer"
        },
        "35" => %{
          "key" => :total_de_pagos_con_MOP_05_o_mayor,
          "type" => "integer"
        },
        "36" => %{
          "key" => :saldo_de_la_morosidad_historica_mas_alta,
          "type" => "float"
        },
        "37" => %{
          "key" => :fecha_de_la_morosidad_historica_mas_alta,
          "type" => "date"
        },
        "38" => %{
          "key" => :MOP_de_la_morosidad_mas_alta,
          "type" => "string"
        },
        "42" => %{
          "key" => :fecha_de_inicio_de_la_reestructura,
          "type" => "date"
        },
        "45" => %{
          "key" => :monto_del_ultimo_pago,
          "type" => "float"
        }
      }
    },
    "IQ" => %{
      "key" => :consultas,
      "struct" => Burox.Response.Consulta,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :fecha_de_consulta,
          "type" => "date"
        },
        "00" => %{
          "key" => :reserved,
          "type" => "string"
        },
        "01" => %{
          "key" => :clave_del_usuario,
          "type" => "string"
        },
        "02" => %{
          "key" => :nombre_del_usuario,
          "type" => "string"
        },
        "03" => %{
          "key" => :numero_telefonico_del_usuario,
          "type" => "string"
        },
        "04" => %{
          "key" => :tipo_de_producto,
          "type" => "string"
        },
        "05" => %{
          "key" => :moneda_del_credito,
          "type" => "string"
        },
        "06" => %{
          "key" => :importe_del_credito,
          "type" => "string"
        },
        "07" => %{
          "key" => :tipo_de_responsabilidad_de_la_cuenta,
          "type" => "string"
        },
        "08" => %{
          "key" => :indicador_de_cliente_nuevo,
          "type" => "string"
        },
        "09" => %{
          "key" => :reserved,
          "type" => "string"
        }
      }
    },
    "RS" => %{
      "key" => :resumen,
      "struct" => Burox.Response.Resumen,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :fecha_de_integracion,
          "type" => "date"
        },
        "00" => %{
          "key" => :numero_de_cuentas_con_MOP_07,
          "type" => "integer"
        },
        "01" => %{
          "key" => :numero_de_cuentas_con_MOP_06,
          "type" => "integer"
        },
        "02" => %{
          "key" => :numero_de_cuentas_con_MOP_05,
          "type" => "integer"
        },
        "03" => %{
          "key" => :numero_de_cuentas_con_MOP_03,
          "type" => "integer"
        },
        "04" => %{
          "key" => :number_of_accounts_with_MOP_03,
          "type" => "integer"
        },
        "05" => %{
          "key" => :numero_de_cuentas_con_MOP_02,
          "type" => "integer"
        },
        "06" => %{
          "key" => :numero_de_cuentas_con_MOP_01,
          "type" => "integer"
        },
        "07" => %{
          "key" => :numero_de_cuentas_con_MOP_00,
          "type" => "integer"
        },
        "08" => %{
          "key" => :numero_de_cuentas_con_MOP_UR,
          "type" => "integer"
        },
        "09" => %{
          "key" => :numero_de_cuentas,
          "type" => "integer"
        },
        "10" => %{
          "key" => :numero_de_cuentas_de_pagos_fijos_e_hipotecario,
          "type" => "integer"
        },
        "11" => %{
          "key" => :numero_de_cuentas_revolventes_y_sin_limite_establecido,
          "type" => "integer"
        },
        "12" => %{
          "key" => :numero_de_cuentas_cerradas,
          "type" => "integer"
        },
        "13" => %{
          "key" => :numero_de_cuentas_con_morosidad_actual,
          "type" => "integer"
        },
        "14" => %{
          "key" => :numero_de_cuentas_con_historial_de_morosidad_actual,
          "type" => "integer"
        },
        "15" => %{
          "key" => :numero_de_cuentas_en_aclaracion,
          "type" => "integer"
        },
        "16" => %{
          "key" => :numero_de_solicitudes_de_consulta,
          "type" => "integer"
        },
        "17" => %{
          "key" => :nueva_direccion_en_los_ultimos_60_dias,
          "type" => "string"
        },
        "18" => %{
          "key" => :mensaje_de_alerta,
          "type" => "string"
        },
        "19" => %{
          "key" => :declarativa,
          "type" => "string"
       },
        "20" => %{
          "key" => :moneda_del_credito,
          "type" => "string"
        },
        "21" => %{
          "key" => :total_de_creditos_maximos_para_cuentas_revolventes,
          "type" => "float"
        },
        "22" => %{
          "key" => :total_de_limites_de_credito_para_cuentas_revolventes,
          "type" => "float"
        },
        "23" => %{
          "key" => :total_de_saldos_actuales_para_cuentas_revolventes,
          "type" => "float"
        },
        "24" => %{
          "key" => :total_de_saldos_vencidos_para_cuentas_revolventes,
          "type" => "float"
        },
        "25" => %{
          "key" => :total_de_importe_de_pago_para_cuentas_revolventes,
          "type" => "float"
        },
        "26" => %{
          "key" => :porcentaje_del_limite_de_credito_utilizado_para_cuentas_revolventes,
          "type" => "float"
        },
        "27" => %{
          "key" => :total_de_creditos_maximos_para_cuentas_de_pagos_fijos_e_hipotecarios,
          "type" => "integer"
        },
        "28" => %{
          "key" => :total_de_saldos_actuales_para_cuentas_de_pagos_fijos_e_hipotecarios,
          "type" => "float"
        },
        "29" => %{
          "key" => :total_de_saldos_vencidos_para_cuentas_de_pagos_fijos_e_hipotecarios,
          "type" => "integer"
        },
        "30" => %{
          "key" => :total_de_importe_de_pago_para_cuentas_de_pagos_fijos_e_hipotecarios,
          "type" => "integer"
        },
        "31" => %{
          "key" => :numero_de_cuentas_con_MOP_96,
          "type" => "integer"
        },
        "32" => %{
          "key" => :numero_de_cuentas_con_MOP_97,
          "type" => "integer"
        },
        "33" => %{
          "key" => :numero_de_cuentas_con_MOP_98,
          "type" => "integer"
        },
        "34" => %{
          "key" => :fecha_de_apertura_de_cuenta_mas_antigua,
          "type" => "date"
        },
        "35" => %{
          "key" => :fecha_de_apertura_de_cuenta_mas_reciente,
          "type" => "date"
        },
        "36" => %{
          "key" => :numero_de_solicitudes_de_informe_de_buro,
          "type" => "integer"
        },
        "37" => %{
          "key" => :fecha_de_la_consulta_mas_reciente,
          "type" => "date"
        },
        "38" => %{
          "key" => :numero_de_cuentas_en_despacho_de_cobranza,
          "type" => "integer"
        },
        "39" => %{
          "key" => :fecha_de_apertura_mas_reciente_de_una_cuenta_en_despacho_de_cobranza,
          "type" => "date"
        },
        "40" => %{
          "key" => :numero_de_solicitudes_del_informe_buro_realizadas_por_despachos_de_cobranza,
          "type" => "integer"
        },
        "41" => %{
          "key" => :fecha_de_la_consulta_mas_reciente_realizada_por_un_despacho_de_cobranza,
          "type" => "date"
        }
      }
    },
    "HI" => %{
      "key" => :hawk_inquiry,
      "struct" => Burox.Response.HawkInquiry,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :fecha_de_reporte,
          "type" => "date"
        },
        "00" => %{
          "key" => :codigo_de_la_prevencion,
          "type" => "string"
        },
        "01" => %{
          "key" => :tipo_de_usuario,
          "type" => "string"
        },
        "02" => %{
          "key" => :mensaje,
          "type" => "string"
        }
      }
    },
    "HR" => %{
      "key" => :hawk_response,
      "struct" => Burox.Response.HawkResponse,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :fecha_de_reporte,
          "type" => "date"
        },
        "00" => %{
          "key" => :codigo_de_la_prevencion,
          "type" => "string"
        },
        "01" => %{
          "key" => :tipo_de_usuario,
          "type" => "string"
        },
        "02" => %{
          "key" => :mensaje,
          "type" => "string"
        }
      }
    },
    "CR" => %{
      "key" => :declarativa_consumidor,
      "struct" => Burox.Response.DeclarativaConsumidor,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :tipo_de_segmento,
          "type" => "string"
        },
        "00" => %{
          "key" => :declarativa,
          "type" => "list"
        },
      }
    },
    "SC" => %{
      "key" => :score,
      "struct" => Burox.Response.Score,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :nombre_del_score,
          "type" => "string"
        },
        "00" => %{
          "key" => :codigo_del_score,
          "type" => "string"
        },
        "01" => %{
          "key" => :valor_del_score,
          "type" => "integer",
        },
        "02" => %{
          "key" => :primer_codigo_de_razon,
          "type" => "string",
          "translate" => &(score_translate(&1, @score_reasons))
        },
        "03" => %{
          "key" => :segundo_codigo_de_razon,
          "type" => "string",
          "translate" => &(score_translate(&1, @score_reasons))
        },
        "04" => %{
          "key" => :tercer_codigo_de_razon,
          "type" => "string",
          "translate" => &(score_translate(&1, @score_reasons))
        },
        "06" => %{
          "key" => :codigo_de_error,
          "type" => "string",
          "translate" => &(score_translate(&1, @score_errors))
        },
      }
    },
    "CL" => %{
      "key" => :sintetiza,
      "struct" => Burox.Response.Sintetiza,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :plantilla_solicitada,
          "type" => "string"
        },
        "00" => %{
          "key" => :identificador_de_caracteristica_de_plantilla,
          "type" => "string"
        },
        "01" => %{
          "key" => :numero_de_caracteristica,
          "type" => "integer"
        },
        "02" => %{
          "key" => :valor_de_la_caracteristica,
          "type" => "string"
        },
        "03" => %{
          "key" => :codigo_de_error,
          "type" => "string"
        }
      }
    },
    "ES" => %{
      "key" => :fin,
      "struct" => Burox.Response.Fin,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :longitud_de_transmision,
          "type" => "integer"
        },
        "00" => %{
          "key" => :numero_de_control_de_la_consulta,
          "type" => "string"
        },
        "01" => %{
          "key" => :fin_del_registro_de_respuesta,
          "type" => "string"
        },
      }
    },
    "UR" => %{
      "key" => :error,
      "struct" => Burox.Response.ErrorUser,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :numero_de_referencia_del_operador,
          "type" => "string"
        },
        "00" => %{
         "key" => :solicitud_del_cliente_erronea,
         "type" => "string"
        },
        "01" => %{
          "key" => :version_proporcionada_erronea,
          "type" => "string"
           },
        "02" => %{
          "key" => :producto_solicitado_erroneo,
          "type" => "string"
           },
        "03" => %{
          "key" => :clave_de_usuario_o_contrasena_erronea,
          "type" => "string"
           },
        "04" => %{
          "key" => :segmento_requerido_no_proporcionado,
          "type" => "string"
           },
        "05" => %{
          "key" => :ultima_informacion_valida_del_cliente,
          "type" => "string"
           },
        "06" => %{
          "key" => :informacion_erronea_para_consulta,
          "type" => "string"
           },
        "07" => %{
          "key" => :valor_erroneo_en_una_campo_relacionado,
          "type" => "string"
           },
        "11" => %{
          "key" => :error_en_el_sistema_de_buro_de_credito,
          "type" => "string"
           },
        "12" => %{
          "key" => :etiqueta_de_segmento__erronea,
          "type" => "string"
           },
        "13" => %{
          "key" => :orden_erroneo_del_segmento,
          "type" => "string"
           },
        "14" => %{
          "key" => :numero_erroneo_de_segmentos,
          "type" => "string"
           },
        "16" => %{
          "key" => :falta_campo_requerido,
          "type" => "string"
           },
        "20" => %{
          "key" => :expediente_bloqueado_para_consulta,
          "type" => "string"
           }
        }
    }
  }
  end

  # Esta función ayuda a traducir los códigos definidos para el
  # score en el Buró de Crédito
  defp score_translate(value, config) do
    with {number, _} <- Integer.parse(value) do
        Map.get(config, Integer.to_string(number))
      else
        {error} -> value
      end
  end

end
