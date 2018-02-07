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
          "type" => "string"
        },
        "10" => %{
          "key" => :number_of_payments,
          "type" => "string"
        },
        "11" => %{
          "key" => :payment_frequency,
          "type" => "string"
        },
        "12" => %{
          "key" => :amount_to_pay,
          "type" => "string"
        },
        "13" => %{
          "key" => :date_of_account_opening,
          "type" => "string"
        },
        "14" => %{
          "key" => :last_date_of_payment,
          "type" => "string"
        },
        "15" => %{
          "key" => :last_date_of_use,
          "type" => "string"
        },
        "16" => %{
          "key" => :date_of_close,
          "type" => "string"
        },
        "17" => %{
          "key" => :date_of_report,
          "type" => "string"
        },
        "18" => %{
          "key" => :reporting_mode,
          "type" => "string"
        },
        "19" => %{
          "key" => :last_date_of_nil_balance,
          "type" => "string"
        },
        "20" => %{
          "key" => :warranty,
          "type" => "string"
        },
        "21" => %{
          "key" => :maximum_credit_authorized,
          "type" => "string"
        },
        "22" => %{
          "key" => :current_balance,
          "type" => "string"
        },
        "23" => %{
          "key" => :credit_limit,
          "type" => "string"
        },
        "24" => %{
          "key" => :balance_due,
          "type" => "string"
        },
        "25" => %{
          "key" => :,
          "type" => "string"
        },
        "26" => %{
          "key" => :,
          "type" => "string"
        },
        "27" => %{
          "key" => :date_of_update,
          "type" => "date"
        },
        "28" => %{
          "key" => :date_of_update,
          "type" => "date"
        },
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
        }
      }
    },
    "CR" => %{
      "key" => :consumer_declaration,
      "struct" => Burox.Response.ConsumerDeclaration,
      "type" => "list",
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
    }
  }

  def sections_map, do: @sections_map

end
