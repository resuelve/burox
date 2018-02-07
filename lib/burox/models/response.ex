defmodule Burox.Response.Person do
  @moduledoc false

  defstruct [
    :first_name,
    :second_name,
    :last_name,
    :last_name_2,
    :aditional_last_name,
    :birth_date,
    :rfc,
    :title,
    :suffix,
    :nationality,
    :residential_type,
    :license_id,
    :marital_status,
    :genre,
    :professional_license_id,
    :identity_id,
    :curp,
    :country_code,
    :dependents_number,
    :dependents_ages,
    :dependents_registration_date,
    :date_of_death
  ]
end

defmodule Burox.Response.Address do
  @moduledoc false
  defstruct [
    :street,
    :street_2,
    :settlement,
    :municipality,
    :city,
    :state,
    :zip_code,
    :date_of_residence,
    :phone_number,
    :ext,
    :fax,
    :type,
    :special_indicator,
    :date_of_registration,
    :country_code
  ]
end

defmodule Burox.Response.WorkAddress do
  @moduledoc false
  defstruct [
    :street,
    :street_2,
    :settlement,
    :municipality,
    :city,
    :state,
    :zip_code,
    :date_of_residence,
    :phone_number,
    :ext,
    :fax,
    :occupation,
    :date_of_hire,
    :currency_of_salary,
    :salary,
    :payment_period,
    :employee_number,
    :last_day_of_employment,
    :date_of_registration,
    :date_of_verification,
    :verification_method,
    :country_code
  ]
end

defmodule Burox.Response.Credit do
  @moduledoc false
  defstruct [
    :date_update,
    :record_disputed
  ]
end

defmodule Burox.Response.Query do
  @moduledoc false
  defstruct [
    :date_of_query,
    :member_code,
    :user_name,
    :user_phone_number,
    :product,
    :currency,
    :credit_amount,
    :contract_value,
    :responsability_type,
    :new_client_indicator,
    :reserved
  ]
end

defmodule Burox.Response.Summary do
  @moduledoc false
  defstruct [
    :date_of_integration
  ]
end

defmodule Burox.Response.HawkInquiry do
  @moduledoc false
  defstruct [
    :date_of_report
  ]
end

defmodule Burox.Response.HawkResponse do
  @moduledoc false
  defstruct [
    :date_of_report
  ]
end

defmodule Burox.Response.ConsumerDeclaration do
  @moduledoc false
  defstruct [
    :type,
    # :declaration
  ]
end

defmodule Burox.Response.Score do
  @moduledoc false
  defstruct [
    :name,
    :score_code,
    :score_value,
    :first_reason_code,
    :second_reason_code,
    :third_reason_code,
    :error_code
  ]
end

defmodule Burox.Response do
  @moduledoc """
  Basic struct for responses from Buro de Crédito
  """

  alias Burox.Response

  defstruct [
    person: %Response.Person{},
    addresses: [%Response.Address{}],
    work_addresses: [%Response.WorkAddress{}],
    credits: [%Response.Credit{}],
    queries: [%Response.Query{}],
    summary: %Response.Summary{},
    hawk_inquiry: %Response.HawkInquiry{},
    hawk_response: %Response.HawkInquiry{},
    consumer_declaration: [%Response.ConsumerDeclaration{}],
    score: %Response.Score{}
  ]

end
