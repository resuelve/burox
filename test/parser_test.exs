defmodule ParserTest do
  use ExUnit.Case

  import Burox.Parser

  @success_response "INTL13                         MX0010FF4736100100PN06AVELAR0009HERNANDEZ0204JOSE0304LUIS0408131019830513AEHL8310136J6PA08HUERTA 10121VILLAS DE LA HACIENDA0220TLAJOMULCO DE ZUNIGA0320TLAJOMULCO DE ZUNIGA0403JAL0505456541208180720161302MXIQ08180720160110FF473610010208RESUELVE031055864796020402CC060100701I0801Y09010IQ0818072016000400000215BURO DE CREDITO0402CC0502MX06090000000000801Y09011RS08180720160002000102000202000302000402000502000602000702000802000904000010040000110400001204000013040000140400001502001602011701Y1805NNNNN1901N210900000000022090000000002310000000000+24090000000002509000000000260300027090000000002810000000000+29090000000003009000000000310200320200330200340800000000350800000000360201370818072016380200390800000000400200410800000000SC08BC SCORE00030070103709ES0500811001012123420590102**"

  @error_response "ERRRUR25                         0506PN0408ES05000580002**"

  test "parse succesful response" do
    assert process_response(@success_response) ==
    %Burox.Response{
              addresses: [
                %{
                  city: "TLAJOMULCO DE ZUNIGA",
                  country_code: "MX",
                  date_of_registration: "18072016",
                  municipality: "TLAJOMULCO DE ZUNIGA",
                  settlement: "VILLAS DE LA HACIENDA",
                  state: "JAL",
                  street: "HUERTA 1",
                  zip_code: "45654"
                }
              ],
              consumer_declaration: %{},
              credits: [],
              hawk_inquiry: %{},
              hawk_response: %{},
              person: %{
                birth_date: "13101983",
                first_name: "JOSE",
                last_name: "AVELAR",
                last_name_2: "HERNANDEZ",
                rfc: "AEHL8310136J6",
                second_name: "LUIS"
              },
              queries: [
                %{
                  contract_value: "0",
                  date_of_query: "18072016",
                  member_code: "FF47361001",
                  new_client_indicator: "Y",
                  product: "CC",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "RESUELVE",
                  user_phone_number: "5586479602"
                } |
                %{
                  contract_value: "000000000",
                  currency: "MX",
                  date_of_query: "18072016",
                  member_code: "FF47361001",
                  new_client_indicator: "Y",
                  product: "CC",
                  reserved: "1",
                  responsability_type: "I",
                  user_name: "BURO DE CREDITO",
                  user_phone_number: "5586479602"
                }
              ],
              score: %{
                name: "BC SCORE",
                score_code: "007",
                score_value: "709"
              },
              summary: %{
                number_of_accounts_with_MOP_01: "00",
                number_of_accounts_with_MOP_97: "00",
                opening_date_of_newest_account: "00000000",
                most_recent_openning_date_of_account_in_collection_agency: "00000000",
                total_limit_credit_of_accounts_with_revolving_credit: "000000000",
                number_of_buro_requests_made_by_collection_agencies: "00",
                date_of_latest_request: "18072016",
                alert_message: "NNNNN",
                total_maximum_credit_of_accounts_with_revolving_credit: "000000000",
                number_of_accounts_with_MOP_04: "00",
                number_of_buro_request: "01",
                new_address_in_last_60_days: "Y",
                total_maximum_credit_of_accounts_of_mortage_or_fixed_payments: "000000000",
                number_of_accounts_with_MOP_03: "00",
                date_of_integration: "18072016",
                number_of_accounts_in_collection_agencies: "00",
                number_of_accounts_with_MOP_00: "00",
                number_of_accounts_with_MOP_96: "00",
                total_payment_amount_of_accounts_with_revolving_credit: "000000000",
                customer_declaration: "N",
                number_of_accounts_in_clarification: "00",
                percentage_of_limit_credit_of_accounts_with_revolving_credit: "000",
                number_of_accounts_with_slowness_in_pay_history: "0000",
                number_of_accounts_with_MOP_07: "00",
                number_of_accounts_with_MOP_05: "00",
                total_current_balance_of_accounts_of_mortage_or_fixed_payments: "000000000+",
                number_of_closed_accounts: "0000",
                date_of_last_request_of_buro_made_by_a_collection_agency: "00000000",
                number_of_requests_to_client_record: "01",
                number_of_accounts_with_MOP_06: "00",
                number_of_accounts_of_mortage_or_fixed_payments: "0000",
                number_of_accounts_with_current_slowness_in_pay: "0000",
                total_balance_due_of_accounts_of_mortage_or_fixed_payments: "000000000",
                number_of_accounts_with_MOP_98: "00",
                number_of_accounts_with_MOP_02: "00",
                opening_date_of_older_account: "00000000",
                number_of_accounts_with_revolving_credit: "0000",
                total_current_balance_of_accounts_with_revolving_credit: "000000000+",
                number_of_accounts: "0000",
                number_of_accounts_with_MOP_UR: "00",
                total_payment_amount_of_accounts_of_mortage_or_fixed_payments: "000000000",
                total_balance_due_of_accounts_with_revolving_credit: "000000000"
              },
              work_addresses: []
            }
  end

  test "parse failed response" do
    assert process_response(@error_response) == %{
        "ERRR" => "  0506PN04",
        "ES" => %{"" => "00058", "00" => "**"},
        "tail" => ""}
  end

  test "match section value" do
    string = "PN05Perez0005LopezPA123"
    assert match_section(string, "PN", ["PN", "PA"]) ==
    {
      %{last_name: "Perez",
        last_name_2: "Lopez"},
      "PA123"
    }
  end

  test "match multiple section values" do
    string = "PN06URBANO0004MAZA0206HECTOR0408160219880513UAMH880216S190802MX"
    assert match_section(string, "PN", ["PN"]) == {%{"" => "URBANO",
                                             "00" => "MAZA",
                                             "02" => "HECTOR",
                                             "04" => "16021988",
                                             "05" => "UAMH880216S19",
                                             "08" => "MX"}, ""}
  end

end
