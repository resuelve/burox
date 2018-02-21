defmodule Burox.Request.Encabezado do
  @moduledoc false

  # @enforce_keys [:codigo_de_producto]

  defstruct [
    :codigo_de_producto,
    :pais,
    :clave_del_usuario,
  ]
end

defmodule Burox.Request.Persona do
  @moduledoc false

  # @enforce_keys [:apellido_paterno, :apellido_materno, :primer_nombre]

  defstruct [
    :apellido_paterno,
    :apellido_materno,
    :primer_nombre,
    :segundo_nombre,
    :fecha_de_nacimiento,
    :rfc
  ]
end

defmodule Burox.Request.Direccion do
  @moduledoc false

  # @enforce_keys [
  #   :primera_linea_de_direccion,
  #   :municipio,
  #   :ciudad,
  #   :estado,
  #   :codigo_postal,
  #   :origen_del_domicilio
  # ]

  defstruct [
    :primera_linea_de_direccion,
    :colonia,
    :municipio,
    :ciudad,
    :estado,
    :codigo_postal,
    :origen_del_domicilio
  ]
end

defmodule Burox.Request do
  @moduledoc """
  Estructura básica para hacer consultas al buró de crédito
  """
  alias Burox.Request

  @enforce_keys [:persona, :direccion]

  defstruct [
    encabezado: %Request.Encabezado{},
    persona: %Request.Persona{},
    direccion: %Request.Direccion{}
  ]
end
