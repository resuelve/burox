defmodule Burox.Parser.ResponseMap do
  @moduledoc false

  @sections_map %{
    "PN" => %{
      "key" => :person,
      "struct" => Burox.Response.Person,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :last_name,
          "type" => "string"
        },
        "00" => %{
          "key" => :last_name_2,
          "type" => "string"
        },
        "02" => %{
          "key" => :first_name,
          "type" => "string"
        },
        "03" => %{
          "key" => :second_name,
          "type" => "string"
        },
        "04" => %{
          "key" => :birth_date,
          "type" => "date"
        },
        "05" => %{
          "key" => :rfc,
          "type" => "string"
        },
        "06" => %{
          "key" => :title,
          "type" => "string"
        },
        "07" => %{
          "key" => :sufix,
          "type" => "string"
        },
        "08" => %{
          "key" => :nationality,
          "type" => "string"
        },
        "09" => %{
          "key" => :residential_type,
          "type" => "string"
        },
        "10" => %{
          "key" => :license_id,
          "type" => "string"
        },
        "11" => %{
          "key" => :marital_status,
          "type" => "string"
        },
        "12" => %{
          "key" => :genre,
          "type" => "string"
        },
        "13" => %{
          "key" => :professional_license_id,
          "type" => "string"
        },
        "14" => %{
          "key" => :identity_id,
          "type" => "string"
        },
        "15" => %{
          "key" => :curp,
          "type" => "string"
        },
        "16" => %{
          "key" => :country_code,
          "type" => "string"
        },
        "17" => %{
          "key" => :dependents_number,
          "type" => "string"
        },
        "18" => %{
          "key" => :dependents_registration_date,
          "type" => "string"
        }
      }
    },
    "PA" => %{
      "key" => :addresses,
      "struct" => Burox.Response.Address,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :street,
          "type" => "string"
        },
        "01" => %{
          "key" => :settlement,
          "type" => "string"
        },
        "02" => %{
          "key" => :municipality,
          "type" => "string"
        },
        "03" => %{
          "key" => :city,
          "type" => "string"
        },
        "04" => %{
          "key" => :state,
          "type" => "string"
        },
        "04" => %{
          "key" => :state,
          "type" => "string"
        },
        "05" => %{
          "key" => :zip_code,
          "type" => "string"
        },
        "06" => %{
          "key" => :date_of_residence,
          "type" => "date"
        },
        "07" => %{
          "key" => :phone_number,
          "type" => "string"
        },
        "08" => %{
          "key" => :ext,
          "type" => "string"
        },
        "09" => %{
          "key" => :fax,
          "type" => "string"
        },
        "10" => %{
          "key" => :type,
          "type" => "string"
        },
        "11" => %{
          "key" => :special_indicator,
          "type" => "string"
        },
        "12" => %{
          "key" => :date_of_registration,
          "type" => "date"
        },
        "13" => %{
          "key" => :country_code,
          "type" => "string"
        }
      }
    },
    "PE" => %{
      "key" => :work_addresses,
      "struct" => Burox.Response.WorkAddress,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :street,
          "type" => "string"
        },
        "00" => %{
          "key" => :street_2,
          "type" => "string"
        },
        "01" => %{
          "key" => :settlement,
          "type" => "string"
        },
        "02" => %{
          "key" => :municipality,
          "type" => "string"
        },
        "03" => %{
          "key" => :city,
          "type" => "string"
        },
        "04" => %{
          "key" => :state,
          "type" => "string"
        },
        "04" => %{
          "key" => :state,
          "type" => "string"
        },
        "05" => %{
          "key" => :zip_code,
          "type" => "string"
        },
        "06" => %{
          "key" => :date_of_residence,
          "type" => "date"
        },
        "07" => %{
          "key" => :phone_number,
          "type" => "string"
        },
        "08" => %{
          "key" => :ext,
          "type" => "string"
        },
        "09" => %{
          "key" => :fax,
          "type" => "string"
        },
        "10" => %{
          "key" => :ocuppation,
          "type" => "string"
        },
        "11" => %{
          "key" => :date_of_hire,
          "type" => "date"
        },
        "12" => %{
          "key" => :currency_of_salary,
          "type" => "string"
        },
        "13" => %{
          "key" => :salary,
          "type" => "float"
        },
        "14" => %{
          "key" => :payment_period,
          "type" => "string"
        },
        "15" => %{
          "key" => :employee_number,
          "type" => "string"
        },
        "16" => %{
          "key" => :last_day_of_employment,
          "type" => "date"
        },
        "17" => %{
          "key" => :date_of_registration,
          "type" => "date"
        },
        "18" => %{
          "key" => :date_of_verification,
          "type" => "date"
        },
        "19" => %{
          "key" => :verification_method,
          "type" => "string"
        },
        "20" => %{
          "key" => :country_code,
          "type" => "string"
        }
      }
    },
    "TL" => %{
      "key" => :credits,
      "struct" => Burox.Response.Credit,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :date_of_update,
          "type" => "date"
        },
        "00" => %{
          "key" => :record_disputed,
          "type" => "string"
        },
        "01" => %{
          "key" => :member_code,
          "type" => "string"
        },
        "02" => %{
          "key" => :user_name,
          "type" => "string"
        },
        "03" => %{
          "key" => :user_phone_number,
          "type" => "string"
        },
        "04" => %{
          "key" => :account_number,
          "type" => "string"
        },
        "05" => %{
          "key" => :responsability_type,
          "type" => "string"
        },
        "06" => %{
          "key" => :account_type,
          "type" => "string"
        },
        "07" => %{
          "key" => :product,
          "type" => "string"
        },
        "08" => %{
          "key" => :currency,
          "type" => "string"
        },
        "09" => %{
          "key" => :valuation_amount,
          "type" => "float"
        },
        "10" => %{
          "key" => :number_of_payments,
          "type" => "integer"
        },
        "11" => %{
          "key" => :payment_frequency,
          "type" => "string"
        },
        "12" => %{
          "key" => :amount_to_pay,
          "type" => "float"
        },
        "13" => %{
          "key" => :date_of_account_opening,
          "type" => "date"
        },
        "14" => %{
          "key" => :last_date_of_payment,
          "type" => "date"
        },
        "15" => %{
          "key" => :last_date_of_use,
          "type" => "date"
        },
        "16" => %{
          "key" => :date_of_close,
          "type" => "date"
        },
        "17" => %{
          "key" => :date_of_report,
          "type" => "date"
        },
        "18" => %{
          "key" => :reporting_mode,
          "type" => "string"
        },
        "19" => %{
          "key" => :last_date_of_nil_balance,
          "type" => "date"
        },
        "20" => %{
          "key" => :warranty,
          "type" => "string"
        },
        "21" => %{
          "key" => :maximum_credit_authorized,
          "type" => "float"
        },
        "22" => %{
          "key" => :current_balance,
          "type" => "float"
        },
        "23" => %{
          "key" => :credit_limit,
          "type" => "float"
        },
        "24" => %{
          "key" => :balance_due,
          "type" => "float"
        },
        "25" => %{
          "key" => :number_of_payments_due,
          "type" => "integer"
        },
        "26" => %{
          "key" => :manner_of_payment,
          "type" => "string"
        },
        "27" => %{
          "key" => :payments_history,
          "type" => "string"
        },
        "28" => %{
          "key" => :last_date_of_payments_history,
          "type" => "date"
        },
        "29" => %{
          "key" => :older_date_payments_history,
          "type" => "date"
        },
        "30" => %{
          "key" => :observation_code,
          "type" => "string"
        },
        "31" => %{
          "key" => :total_number_of_payments_reported,
          "type" => "integer"
        },
        "32" => %{
          "key" => :total_number_of_payments_with_MOP_02,
          "type" => "integer"
        },
        "33" => %{
          "key" => :total_number_of_payments_with_MOP_03,
          "type" => "integer"
        },
        "34" => %{
          "key" => :total_number_of_payments_with_MOP_04,
          "type" => "integer"
        },
        "35" => %{
          "key" => :total_number_of_payments_with_MOP_05_or_more,
          "type" => "integer"
        },
        "36" => %{
          "key" => :maximum_balance_of_defaulting,
          "type" => "float"
        },
        "37" => %{
          "key" => :date_of_maximum_defaulting,
          "type" => "date"
        },
        "38" => %{
          "key" => :slowness_in_pay_MOP,
          "type" => "string"
        },
        "42" => %{
          "key" => :init_date_of_the_debt_reestructuring,
          "type" => "date"
        },
        "45" => %{
          "key" => :amount_of_last_payment,
          "type" => "float"
        }
      }
    },
    "IQ" => %{
      "key" => :queries,
      "struct" => Burox.Response.Query,
      "type" => "list",
      "tags" => %{
        "" => %{
          "key" => :date_of_query,
          "type" => "date"
        },
        "00" => %{
          "key" => :reserved,
          "type" => "string"
        },
        "01" => %{
          "key" => :member_code,
          "type" => "string"
        },
        "02" => %{
          "key" => :user_name,
          "type" => "string"
        },
        "03" => %{
          "key" => :user_phone_number,
          "type" => "string"
        },
        "04" => %{
          "key" => :product,
          "type" => "string"
        },
        "05" => %{
          "key" => :currency,
          "type" => "string"
        },
        "06" => %{
          "key" => :credit_amount,
          "type" => "date"
        },
        "06" => %{
          "key" => :contract_value,
          "type" => "string"
        },
        "07" => %{
          "key" => :responsability_type,
          "type" => "string"
        },
        "08" => %{
          "key" => :new_client_indicator,
          "type" => "string"
        },
        "09" => %{
          "key" => :reserved,
          "type" => "string"
        }
      }
    },
    "RS" => %{
      "key" => :summary,
      "struct" => Burox.Response.Summary,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :date_of_integration,
          "type" => "string"
        },
        "00" => %{
          "key" => :number_of_accounts_with_MOP_07,
          "type" => "string"
        },
        "01" => %{
          "key" => :number_of_accounts_with_MOP_06,
          "type" => "string"
        },
        "02" => %{
          "key" => :number_of_accounts_with_MOP_05,
          "type" => "string"
        },
        "03" => %{
          "key" => :number_of_accounts_with_MOP_04,
          "type" => "string"
        },
        "04" => %{
          "key" => :number_of_accounts_with_MOP_03,
          "type" => "string"
        },
        "05" => %{
          "key" => :number_of_accounts_with_MOP_02,
          "type" => "string"
        },
        "06" => %{
          "key" => :number_of_accounts_with_MOP_01,
          "type" => "string"
        },
        "07" => %{
          "key" => :number_of_accounts_with_MOP_00,
          "type" => "string"
        },
        "08" => %{
          "key" => :number_of_accounts_with_MOP_UR,
          "type" => "string"
        },
        "09" => %{
          "key" => :number_of_accounts,
          "type" => "string"
        },
        "10" => %{
          "key" => :number_of_accounts_of_mortage_or_fixed_payments,
          "type" => "string"
        },
        "11" => %{
          "key" => :number_of_accounts_with_revolving_credit,
          "type" => "string"
        },
        "12" => %{
          "key" => :number_of_closed_accounts,
          "type" => "string"
        },
        "13" => %{
          "key" => :number_of_accounts_with_current_slowness_in_pay,
          "type" => "string"
        },
        "14" => %{
          "key" => :number_of_accounts_with_slowness_in_pay_history,
          "type" => "string"
        },
        "15" => %{
          "key" => :number_of_accounts_in_clarification,
          "type" => "string"
        },
        "16" => %{
          "key" => :number_of_requests_to_client_record,
          "type" => "string"
        },
        "17" => %{
          "key" => :new_address_in_last_60_days,
          "type" => "string"
        },
        "18" => %{
          "key" => :alert_message,
          "type" => "string"
        },
        "19" => %{
          "key" => :customer_declaration,
          "type" => "string"
       },
        "20" => %{
          "key" => :credit_currency,
          "type" => "string"
        },
        "21" => %{
          "key" => :total_maximum_credit_of_accounts_with_revolving_credit,
          "type" => "float"
        },
        "22" => %{
          "key" => :total_limit_credit_of_accounts_with_revolving_credit,
          "type" => "float"
        },
        "23" => %{
          "key" => :total_current_balance_of_accounts_with_revolving_credit,
          "type" => "float"
        },
        "24" => %{
          "key" => :total_balance_due_of_accounts_with_revolving_credit,
          "type" => "float"
        },
        "25" => %{
          "key" => :total_payment_amount_of_accounts_with_revolving_credit,
          "type" => "float"
        },
        "26" => %{
          "key" => :percentage_of_limit_credit_of_accounts_with_revolving_credit,
          "type" => "float"
        },
        "27" => %{
          "key" => :total_maximum_credit_of_accounts_of_mortage_or_fixed_payments,
          "type" => "integer"
        },
        "28" => %{
          "key" => :total_current_balance_of_accounts_of_mortage_or_fixed_payments,
          "type" => "float"
        },
        "29" => %{
          "key" => :total_balance_due_of_accounts_of_mortage_or_fixed_payments,
          "type" => "integer"
        },
        "30" => %{
          "key" => :total_payment_amount_of_accounts_of_mortage_or_fixed_payments,
          "type" => "integer"
        },
        "31" => %{
          "key" => :number_of_accounts_with_MOP_96,
          "type" => "integer"
        },
        "32" => %{
          "key" => :number_of_accounts_with_MOP_97,
          "type" => "integer"
        },
        "33" => %{
          "key" => :number_of_accounts_with_MOP_98,
          "type" => "integer"
        },
        "34" => %{
          "key" => :opening_date_of_older_account,
          "type" => "date"
        },
        "35" => %{
          "key" => :opening_date_of_newest_account,
          "type" => "date"
        },
        "36" => %{
          "key" => :number_of_buro_request,
          "type" => "integer"
        },
        "37" => %{
          "key" => :date_of_latest_request,
          "type" => "integer"
        },
        "38" => %{
          "key" => :number_of_accounts_in_collection_agencies,
          "type" => "integer"
        },
        "39" => %{
          "key" => :most_recent_openning_date_of_account_in_collection_agency,
          "type" => "date"
        },
        "40" => %{
          "key" => :number_of_buro_requests_made_by_collection_agencies,
          "type" => "integer"
        },
        "41" => %{
          "key" => :date_of_last_request_of_buro_made_by_a_collection_agency,
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
          "key" => :date_of_report,
          "type" => "date"
        },
        "00" => %{
          "key" => :preventon_code,
          "type" => "string"
        },
        "01" => %{
          "key" => :user_type,
          "type" => "string"
        },
        "02" => %{
          "key" => :message,
          "type" => "string"
        }
      }
    },
    "HR" => %{
      "key" => :hawk_response,
      "struct" => Burox.Response.HawkResponse,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :date_of_report,
          "type" => "date"
        },
        "00" => %{
          "key" => :preventon_code,
          "type" => "string"
        },
        "01" => %{
          "key" => :user_type,
          "type" => "string"
        },
        "02" => %{
          "key" => :message,
          "type" => "string"
        }
      }
    },
    "CR" => %{
      "key" => :consumer_declaration,
      "struct" => Burox.Response.ConsumerDeclaration,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :type,
          "type" => "string"
        }
      }
    },
    "SC" => %{
      "key" => :score,
      "struct" => Burox.Response.Score,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :name,
          "type" => "string"
        },
        "00" => %{
          "key" => :score_code,
          "type" => "string"
        },
        "01" => %{
          "key" => :score_value,
          "type" => "integer"
        },
        "02" => %{
          "key" => :first_reason_code,
          "type" => "string"
        },
        "03" => %{
          "key" => :second_reason_code,
          "type" => "string"
        },
        "04" => %{
          "key" => :third_reason_code,
          "type" => "string"
        },
        "06" => %{
          "key" => :error_code,
          "type" => "string"
        },
      }
    },
    "ES" => %{
      "key" => :end,
      "struct" => Burox.Response.ConsumerDeclaration,
      "type" => "map",
      "tags" => %{
        "" => %{
          "key" => :longitude,
          "type" => "integer"
        },
        "00" => %{
          "key" => :request_id,
          "type" => "string"
        },
        "01" => %{
          "key" => :end,
          "type" => "string"
        },
      }
    }
  }

  def sections_map, do: @sections_map

end
