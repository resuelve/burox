defmodule Burox.Request.Person do
  @moduledoc false

  # @enforce_keys [
  #   :name, :middle_name,
  #   :last_name, :last_name_2,
  #   :birth_date
  # ]

  defstruct [
    :name,
    :middle_name,
    :last_name,
    :last_name_2,
    :birth_date,
    :rfc
  ]
end

defmodule Burox.Request.Address do
  @moduledoc false

  # @enforce_keys [
  #   :settlement, :municipality,
  #   :city, :state, :zip_code
  # ]

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

  @enforce_keys [:person, :address]

  defstruct [
    person: %Burox.Request.Person{},
    address: %Burox.Request.Address{},
    credit: %Burox.Request.Credit{}
  ]

end
