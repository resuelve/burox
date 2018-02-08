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
    :record_disputed,
    :member_code,
    :user_name,
    :user_phone_number,
    :account_number,
    :responsability_type,
    :account_type,
    :product,
    :currency,
    :valuation_amount,
    :number_of_payments,
    :payment_frequency,
    :amount_to_pay,
    :date_of_account_opening,
    :last_date_of_payment,
    :last_date_of_use,
    :date_of_close,
    :date_of_last_report,
    :reporting_mode,
    :last_date_of_nil_balance,
    :warranty,
    :maximum_credit_authorized,
    :current_balance,
    :credit_limit,
    :balance_due,
    :number_of_payments_due,
    :manner_of_payment,
    :payments_history,
    :last_date_of_payments_history,
    :older_date_payments_history,
    :observation_code,
    :total_number_of_payments_reported,
    :total_number_of_payments_with_MOP_02,
    :total_number_of_payments_with_MOP_03,
    :total_number_of_payments_with_MOP_04,
    :total_number_of_payments_with_MOP_05_or_more,
    :maximum_balance_of_defaulting,
    :date_of_maximum_defaulting,
    :slowness_in_pay_MOP,
    :init_date_of_the_debt_reestructuring,
    :amount_of_last_payment
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
    :date_of_integration,
    :number_of_accounts_with_MOP_07,
    :number_of_accounts_with_MOP_06,
    :number_of_accounts_with_MOP_05,
    :number_of_accounts_with_MOP_04,
    :number_of_accounts_with_MOP_03,
    :number_of_accounts_with_MOP_02,
    :number_of_accounts_with_MOP_01,
    :number_of_accounts_with_MOP_00,
    :number_of_accounts_with_MOP_UR,
    :number_of_accounts,
    :number_of_accounts_of_mortage_or_fixed_payments,
    :number_of_accounts_with_revolving_credit,
    :number_of_closed_accounts,
    :number_of_accounts_with_current_slowness_in_pay,
    :number_of_accounts_with_slowness_in_pay_history,
    :number_of_accounts_in_clarification,
    :number_of_requests_to_client_record,
    :new_address_in_last_60_days,
    :alert_message,
    :customer_declaration,
    :credit_currency,
    :total_maximum_credit_of_accounts_with_revolving_credit,
    :total_limit_credit_of_accounts_with_revolving_credit,
    :total_current_balance_of_accounts_with_revolving_credit,
    :total_balance_due_of_accounts_with_revolving_credit,
    :total_payment_amount_of_accounts_with_revolving_credit,
    :percentage_of_limit_credit_of_accounts_with_revolving_credit,
    :total_maximum_credit_of_accounts_of_mortage_or_fixed_payments,
    :total_current_balance_of_accounts_of_mortage_or_fixed_payments,
    :total_balance_due_of_accounts_of_mortage_or_fixed_payments,
    :total_payment_amount_of_accounts_of_mortage_or_fixed_payments,
    :number_of_accounts_with_MOP_96,
    :number_of_accounts_with_MOP_97,
    :number_of_accounts_with_MOP_98,
    :opening_date_of_older_account,
    :opening_date_of_newest_account,
    :number_of_buro_request,
    :date_of_latest_request,
    :number_of_accounts_in_collection_agencies,
    :most_recent_openning_date_of_account_in_collection_agency,
    :number_of_buro_requests_made_by_collection_agencies,
    :date_of_last_request_of_buro_made_by_a_collection_agency
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
    :declaration
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
