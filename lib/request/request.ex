defmodule Burox.Request.Encabezado do
  @moduledoc false
  defstruct [
    :codigo_de_producto,
    :pais,
    :clave_del_usuario
  ]
end

defmodule Burox.Request.Autenticacion do
  @moduledoc false
  defstruct [
    :tipo_reporte,
    :tipo_salida,
    :referencia_del_operador,
    :cuenta_con_tarjeta_de_credito,
    :ultimos_cuatro_digitos,
    :ha_ejercido_un_credito_hipotecario,
    :ha_ejercido_un_credito_automotriz_en_los_ultimos_24_meses
  ]
end

defmodule Burox.Request.Persona do
  @moduledoc false

  defstruct [
    :apellido_paterno,
    :apellido_materno,
    :primer_nombre,
    :segundo_nombre,
    :fecha_de_nacimiento,
    :rfc
  ]

  use Vex.Struct
end

defmodule Burox.Request.Direccion do
  @moduledoc false

  defstruct [
    :primera_linea_de_direccion,
    :colonia,
    :municipio,
    :ciudad,
    :estado,
    :codigo_postal,
    :origen_del_domicilio
  ]

  use Vex.Struct

  validates(:primera_linea_de_direccion,
    presence: true,
    length: [max: 40],
    format: ~r(^[[:alnum:]\s]+$)
  )

  validates(:colonia,
    presence: true,
    length: [max: 40],
    format: ~r(^[[:alnum:]\s]+$)
  )

  validates(:municipio,
    presence: true,
    length: [max: 40],
    format: ~r(^[[:alnum:]\s]+$)
  )

  validates(:ciudad,
    presence: true,
    length: [max: 40],
    format: ~r(^[[:alnum:]\s]+$)
  )

  validates(:estado,
    presence: true,
    length: [max: 4],
    format: ~r(^[[:alpha:]\s]+$)
  )

  validates(:codigo_postal,
    presence: true,
    length: [is: 5],
    format: ~r(^[[:digit:]]+$)
  )

  validates(:origen_del_domicilio,
    presence: true,
    length: [is: 2],
    format: ~r(^[A-Z]+$)
  )
end

defmodule Burox.Request do
  @moduledoc """
  Estructura básica para hacer consultas al buró de crédito
  """
  alias Burox.Request

  @enforce_keys [:persona, :direccion]

  defstruct autenticacion: %Request.Autenticacion{},
            encabezado: %Request.Encabezado{},
            persona: %Request.Persona{},
            direccion: %Request.Direccion{}

  use Vex.Struct

  validates(:persona, presence: true)
  validates(:direccion, presence: true)
end
