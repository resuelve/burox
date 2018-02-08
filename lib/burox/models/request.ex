defmodule Burox.Request.Person do
  @moduledoc false

  defstruct [
    :first_name,
    :second_name,
    :last_name,
    :last_name_2,
    :birth_date,
    :rfc
  ]
end

defmodule Burox.Request.Address do
  @moduledoc false

  defstruct [
    :street,
    :settlement,
    :municipality,
    :city,
    :state,
    :zip_code
  ]
end

defmodule Burox.Request.Credit do
  @moduledoc false
  defstruct [
    :credit_card,
    :card_4_last_digits,
    :mortage?,
    :car_credit?
  ]
end

defmodule Burox.Request do
  @moduledoc """
  Basic struct to make requests to Buro de Crédito
  """
  alias Burox.Request

  @enforce_keys [:person, :address]

  defstruct [
    person: %Request.Person{},
    address: %Request.Address{},
    credit: %Request.Credit{}
  ]
end
