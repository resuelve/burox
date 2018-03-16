defmodule Burox.Response.Persona do
  @moduledoc false

  defstruct [
    :primer_nombre,
    :segundo_nombre,
    :apellido_paterno,
    :apellido_materno,
    :apellido_adicional,
    :fecha_de_nacimiento,
    :rfc,
    :prefijo_personal,
    :sufijo_personal,
    :nacionalidad,
    :tipo_de_residencia,
    :numero_de_licencia_de_conducir,
    :estado_civil,
    :genero,
    :numero_de_cedula_profesional,
    :numero_de_registro_electoral,
    :curp,
    :clave_de_pais,
    :numero_de_dependientes,
    :edades_de_los_dependientes,
    :fecha_de_recepcion_de_informacion_de_los_dependientes,
    :fecha_de_defuncion
  ]
end

defmodule Burox.Response.Direccion do
  @moduledoc false
  defstruct [
    :primera_linea_de_direccion,
    :segunda_linea_de_direccion,
    :colonia,
    :municipio,
    :ciudad,
    :estado,
    :codigo_postal,
    :fecha_de_residencia,
    :numero_de_telefono,
    :extension_telefonica,
    :fax,
    :tipo_de_domicilio,
    :indicador_especial,
    :fecha_de_reporte_de_la_direccion,
    :origen_del_domicilio
  ]
end

defmodule Burox.Response.DireccionDeTrabajo do
  @moduledoc false
  defstruct [
    :primera_linea_de_direccion,
    :segunda_linea_de_direccion,
    :colonia,
    :municipio,
    :ciudad,
    :estado,
    :codigo_postal,
    :fecha_de_residencia,
    :numero_de_telefono,
    :extension_telefonica,
    :fax,
    :ocupacion,
    :fecha_de_contratacion,
    :clave_de_la_moneda_del_sueldo,
    :monto_del_sueldo,
    :perido_de_pago,
    :numero_de_empleado,
    :fecha_de_ultimo_dia_de_empleo,
    :fecha_de_reporte_de_empleo,
    :fecha_de_verificacion_de_empleo,
    :modo_de_verificacion,
    :origen_de_la_razon_social
  ]
end

defmodule Burox.Response.Credito do
  @moduledoc false
  defstruct [
    :fecha_de_actualizacion,
    :registro_impugando,
    :clave_del_usuario,
    :nombre_del_usuario,
    :numero_telefonico_del_usuario,
    :numero_de_cuenta,
    :tipo_de_responsabilidad_de_la_cuenta,
    :tipo_de_cuenta,
    :tipo_de_producto,
    :currency,
    :moneda_del_credito,
    :importe_del_avaluo,
    :numero_de_pagos,
    :frecuencia_de_pagos,
    :monto_a_pagar,
    :fecha_de_apertura_de_cuenta,
    :fecha_del_ultimo_pago,
    :fecha_de_ultima_compra,
    :fecha_de_cierre,
    :fecha_de_reporte_de_informacion,
    :modo_de_reportar,
    :ultima_fecha_de_saldo_cero,
    :garantia,
    :credito_maximo_autorizado,
    :saldo_actual,
    :limite_de_credito,
    :saldo_vencido,
    :numero_de_pagos_vencidos,
    :clasificacion_de_puntualidad_de_pago,
    :historico_de_pagos,
    :fecha_mas_reciente_del_historico_de_pagos,
    :fecha_mas_antigua_del_historico_de_pagos,
    :clave_de_observacion,
    :total_de_pagos_reportados,
    :total_de_pagos_con_MOP_02,
    :total_de_pagos_con_MOP_03,
    :total_de_pagos_con_MOP_04,
    :total_de_pagos_con_MOP_05_o_mayor,
    :saldo_en_la_morosidad_historica_mas_alta,
    :fecha_de_la_morosidad_historica_mas_alta,
    :MOP_de_la_morosidad_mas_alta,
    :fecha_de_inicio_de_la_reestructura,
    :monto_del_ultimo_pago
  ]
end

defmodule Burox.Response.Consulta do
  @moduledoc false
  defstruct [
    :fecha_de_consulta,
    :clave_del_usuario,
    :nombre_del_usuario,
    :numero_telefonico_del_usuario,
    :tipo_de_producto,
    :moneda_del_credito,
    :importe_del_contrato,
    :tipo_de_responsabilidad_de_la_cuenta,
    :indicador_de_cliente_nuevo,
    :reservado
  ]
end

defmodule Burox.Response.Resumen do
  @moduledoc false
  defstruct [
    :fecha_de_integracion,
    :numero_de_cuentas_con_MOP_07,
    :numero_de_cuentas_con_MOP_06,
    :numero_de_cuentas_con_MOP_05,
    :numero_de_cuentas_con_MOP_04,
    :numero_de_cuentas_con_MOP_03,
    :numero_de_cuentas_con_MOP_02,
    :numero_de_cuentas_con_MOP_01,
    :numero_de_cuentas_con_MOP_00,
    :numero_de_cuentas_con_MOP_UR,
    :numero_de_cuentas_de_pagos_fijos_e_hipotecario,
    :numero_de_cuentas_revolventes_y_sin_limite_establecido,
    :numero_de_cuentas_cerradas,
    :numero_de_cuentas_con_morosidad_actual,
    :numero_de_cuentas_con_historial_de_morosidad_actual,
    :numero_de_cuentas_en_aclaracion,
    :numero_de_solicitudes_de_consulta,
    :nueva_direccion_en_los_ultimos_60_dias,
    :mensaje_de_alerta,
    :declarativa,
    :moneda_del_credito,
    :total_de_creditos_maximos_para_cuentas_revolventes,
    :total_de_limites_de_credito_para_cuentas_revolventes,
    :total_de_saldos_actuales_para_cuentas_revolventes,
    :total_de_saldos_vencidos_para_cuentas_revolventes,
    :total_de_importe_de_pago_para_cuentas_revolventes,
    :porcentaje_del_limite_de_credito_utilizado_para_cuentas_revolventes,
    :total_de_creditos_maximos_para_cuentas_de_pagos_fijos_e_hipotecarios,
    :total_de_saldos_actuales_para_cuentas_de_pagos_fijos_e_hipotecarios,
    :total_de_saldos_vencidos_para_cuentas_de_pagos_fijos_e_hipotecarios,
    :total_de_importe_de_pago_para_cuentas_de_pagos_fijos_e_hipotecarios,
    :numero_de_cuentas_con_MOP_96,
    :numero_de_cuentas_con_MOP_97,
    :numero_de_cuentas_con_MOP_98,
    :fecha_de_apertura_de_cuenta_mas_antigua,
    :fecha_de_apertura_de_cuenta_mas_reciente,
    :numero_de_solicitudes_de_informe_de_buro,
    :fecha_de_la_consulta_mas_reciente,
    :numero_de_cuentas_en_despacho_de_cobranza,
    :fecha_de_apertura_mas_reciente_de_una_cuenta_en_despacho_de_cobranza,
    :numero_de_solicitudes_del_informe_buro_realizadas_por_despachos_de_cobranza,
    :fecha_de_la_consulta_mas_reciente_realizada_por_un_despacho_de_cobranza
  ]
end

defmodule Burox.Response.HawkInquiry do
  @moduledoc false
  defstruct [
    :fecha_de_reporte,
    :codigo_de_la_prevencion,
    :tipo_de_usuario,
    :mensaje
  ]
end

defmodule Burox.Response.HawkResponse do
  @moduledoc false
  defstruct [
    :fecha_de_reporte,
    :codigo_de_la_prevencion,
    :tipo_de_usuario,
    :mensaje
  ]
end

defmodule Burox.Response.DeclarativaConsumidor do
  @moduledoc false
  defstruct [
    :tipo_de_segmento,
    :declarativa
  ]
end

defmodule Burox.Response.Score do
  @moduledoc false
  defstruct [
    :nombre_del_score,
    :codigo_del_score,
    :valor_del_score,
    :primer_codigo_de_razon,
    :segundo_codigo_de_razon,
    :tercer_codigo_de_razon,
    :codigo_de_error
  ]
end

defmodule Burox.Response.Fin do
  @moduledoc false
  defstruct [
    :longitud_de_transmision,
    :numero_de_control_de_la_consulta,
    :fin_del_registro_de_respuesta
  ]
end

defmodule Burox.Response.ErrorUser do
  @moduledoc false
  defstruct [
    :numero_de_referencia_del_operador,
    :solicitud_del_cliente_erronea,
    :version_proporcionada_erronea,
    :producto_solicitado_erroneo,
    :clave_de_usuario_o_contrasena_erronea,
    :segmento_requerido_no_proporcionado,
    :ultima_informacion_valida_del_cliente,
    :informacion_erronea_para_consulta,
    :valor_erroneo_en_una_campo_relacionado,
    :error_en_el_sistema_de_buro_de_credito,
    :etiqueta_de_segmento__erronea,
    :orden_erroneo_del_segmento,
    :numero_erroneo_de_segmentos,
    :falta_campo_requerido,
    :expediente_bloqueado_para_consulta
  ]
end

defmodule Burox.Response.Sintetiza do
  @moduledoc false
  defstruct [
    :plantilla_solicitada,
    :identificador_de_caracteristica_de_plantilla,
    :numero_de_caracteristica,
    :valor_de_la_caracteristica,
    :codigo_de_error
  ]
end

defmodule Burox.Response do
  @moduledoc """
  Basic struct for responses from Buro de Crédito
  """

  alias Burox.Response

  defstruct [
    persona: %Response.Persona{},
    direcciones: [%Response.Direccion{}],
    direcciones_de_trabajo: [%Response.DireccionDeTrabajo{}],
    creditos: [%Response.Credito{}],
    consultas: [%Response.Consulta{}],
    resumen: %Response.Resumen{},
    hawk_inquiry: %Response.HawkInquiry{},
    hawk_response: %Response.HawkResponse{},
    declarativa_consumidor: [%Response.DeclarativaConsumidor{}],
    score: %Response.Score{},
    fin: %Response.Fin{},
    error: %Response.ErrorUser{}
  ]

end
