defmodule ParserTest do
  use ExUnit.Case

  import Burox.Parser

  @success_response "INTL13                         MX0010FF4736100100PN06AVELAR0009HERNANDEZ0204JOSE0304LUIS0408131019830513AEHL8310136J6PA08HUERTA 10121VILLAS DE LA HACIENDA0220TLAJOMULCO DE ZUNIGA0320TLAJOMULCO DE ZUNIGA0403JAL0505456541208180720161302MXIQ08180720160110FF473610010208RESUELVE031055864796020402CC060100701I0801Y09010IQ0818072016000400000215BURO DE CREDITO0402CC0502MX06090000000000801Y09011RS08180720160002000102000202000302000402000502000602000702000802000904000010040000110400001204000013040000140400001502001602011701Y1805NNNNN1901N210900000000022090000000002310000000000+24090000000002509000000000260300027090000000002810000000000+29090000000003009000000000310200320200330200340800000000350800000000360201370818072016380200390800000000400200410800000000SC08BC SCORE00030070103709ES0500811001012123420590102**"

  @success_response_2 "INTL13                         MX1010FF4736100110PN06URBANO0004MAZA0206HECTOR0408160219880513UAMH880216S190802MX090111101S1201M1518UAMH880216HPLRZC09PA09ILAMA 3130123PEDREGAL DE STO DOMINGO0208COYOACAN0312CD DE MEXICO0402DF050504369071055454322911001H120819092014PA15FILIPINAS 613 A0008PORTALES0213BENITO JUAREZ0312CD DE MEXICO0402DF05050350007105545432291120807022013PA1114 DE FEB 900085 DE OCT0119LLANO DE BUENAVISTA0212HUAUCHINANGO0403PUE050573160060801011989070776277891001H1208160320101302MXPA18CTO DE LA UNION 340019MISIONES DE SN FRAN0303PUE0403PUE05057200007107767627789120831102009PE34GEOTECNIA Y SUPERVICION TECNICA SA00001003AUX1108050520051708080920152002MXPE17RESUELVE TU DEUDA00002002MXTL08160520160205BANCO030100501I0601R0702CC0802MX1101Z12032121308010420121408020520161508220420161708020520161801A21051209022054433+2305175002401026020127241111111111111111111111112808300420162908290420124503500TL08060520160205BANCO030100501I0601R0702CC0802MX1101Z120101308020120111408160620121508280820111708300420161801A2104727622020+23048400240102602UR2724UUUUUUUUUUUUUUUUUUUUUUUU280830032016290830012011360103708310120113802004503610TL08030520160216TIENDA COMERCIAL030100501I0601R0702CC0802MX1101Z1308061120101708300420161801A2101022020+23041000240102602UR2724UUUUUUUUUUUUUUUUUUUUUUUU2808300320162908301120103002IATL08030520160216TIENDA COMERCIAL030100501I0601R0702CC0802MX1101Z1308271020091408030620101508291120131708300420161801A210322422020+23041100240102602UR2724UUUUUUUUUUUUUUUUUUUUUUUU280830032016290830112013TL08040520160205BANCO030100501I0601R0702CC0802MX1101Z12033791308240320101408280420161508180420161708300420161801A2105172332204459+23053030024010260201TL08050520160214COMUNICACIONES030100501I0601O0702CL0802MX1101M120101308190520131408180420161508130420161708300420161801A210393322020+230520000240102602012724111111111111111111111111280822032016290822022013370831052014380202TL08110520160205BANCO030100501I0601R0702CC0802MX1101Z12033791308240320101408280420161508180420161708300420161801A2105172332204459+230530300240102602012724111111111111111111111111280830032016290830062011TL08090520160205BANCO030100501I0601R0702CC0802MX1101Z12032201308101220141408240420161508240420161708290420161801A2104583622051423+2305176002401026020127161111111111111111280829032016290829122014TL08180320160209SERVICIOS030100501I0601O0702CL0802MX1101M12034001308050920151408220220161508010220161708290220161801A210102204400+230102401026020127041111280829012016290829102015TL08240920110205BANCO030100501I0601R0702CC0802N$1101Z120101308240320101408310820111508270820111608310820111708310820111801A2104295422020+23043000240102602012714111111111111112808020720112908300620103002CCTL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308100120101408090320101508100120101608090320101708310320112101022020+230451002401026020127111111UUUUU11280831032011290801011901TL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308240220101408060720101508240220101608060720101708310320112101022020+23045100240102602012706UUUUU1280831032011290801011901TL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308180420101408170720101508180420101608170720101708310320112101022020+23045100240102602012706UUUUU1280831032011290801011901TL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308160520101408110820101508160520101608110820101708310320112101022020+23045100240102602012706UUUUU1280831032011290801011901TL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308101020101408281020101508101020101608281020101708310320112101022020+23045100240102602012702U1280831032011290801011901IQ08190520160110FF473610010208RESUELVE0402CC060100701I09010IQ0819052016000400000215BURO DE CREDITO0402CC0502MX060900000000009011IQ08061220150205BANCO0402UK060100701I09010IQ08080920150205BANCO0402UK060100701I09010IQ08100720150216CONSUMIDOR FINAL0402UK060100701I09010IQ0810072015000400000203SIC0402010502MX060900000000009011IQ08010520150205BANCO0402CC060100701I09010IQ08150120150205BANCO0402CC060100701I09010IQ08021220140205BANCO0402CC060100701I09010IQ08021220140205BANCO0402CC060100701I09010IQ0802122014000400000215BURO DE CREDITO0402010502MX060900000000009011IQ08190920140216CONSUMIDOR FINAL0402UK060100701I09010IQ0819092014000400000203SIC0402010502MX060900000000009011IQ08100720140216CONSUMIDOR FINAL0402UK060100701I09010RS08061120090002000102000202000302000402000502000602120702000802030904001510040005110400101204000613040000140400001502001602021701N1805NNNNN1901N2002MX210900006082522090001062002310000007174+24090000000002509000001590260300627090000000002810000000000+29090000000003009000000000310200320200330200340827102009350805092015360213370819052016380200390800000000400200410800000000SC08BC SCORE000300701040725020204ES0504822001011792509390102**"

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
              declarativa_consumidor: %{},
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

  test "parse another succesful response" do
    assert process_response(@success_response_2) == %Burox.Response{
              addresses: [
                %{
                  city: "CD DE MEXICO",
                  date_of_registration: "19092014",
                  municipality: "COYOACAN",
                  phone_number: "5545432291",
                  settlement: "PEDREGAL DE STO DOMINGO",
                  state: "DF",
                  street: "ILAMA 313",
                  type: "H",
                  zip_code: "04369"
                },
                %{
                  city: "CD DE MEXICO",
                  date_of_registration: "07022013",
                  municipality: "BENITO JUAREZ",
                  nil: "PORTALES",
                  phone_number: "5545432291",
                  settlement: "PEDREGAL DE STO DOMINGO",
                  state: "DF",
                  street: "FILIPINAS 613 A",
                  type: "H",
                  zip_code: "03500"
                },
                %{
                  city: "CD DE MEXICO",
                  country_code: "MX",
                  date_of_registration: "16032010",
                  date_of_residence: "01011989",
                  municipality: "HUAUCHINANGO",
                  nil: "5 DE OCT",
                  phone_number: "7627789",
                  settlement: "LLANO DE BUENAVISTA",
                  state: "PUE",
                  street: "14 DE FEB 9",
                  type: "H",
                  zip_code: "73160"
                } |
                %{
                  city: "PUE",
                  country_code: "MX",
                  date_of_registration: "31102009",
                  date_of_residence: "01011989",
                  municipality: "HUAUCHINANGO",
                  nil: "MISIONES DE SN FRAN",
                  phone_number: "7767627789",
                  settlement: "LLANO DE BUENAVISTA",
                  state: "PUE",
                  street: "CTO DE LA UNION 34",
                  type: "H",
                  zip_code: "72000"
                }
              ],
              declarativa_consumidor: %{},
              credits: [
                %{
                  account_type: "R",
                  amount_of_last_payment: "500",
                  amount_to_pay: "212",
                  balance_due: "0",
                  credit_limit: "17500",
                  currency: "MX",
                  current_balance: "4433+",
                  date_of_account_opening: "01042012",
                  date_of_report: "02052016",
                  date_of_update: "16052016",
                  last_date_of_payment: "02052016",
                  last_date_of_payments_history: "30042016",
                  last_date_of_use: "22042016",
                  manner_of_payment: "01",
                  maximum_credit_authorized: "12090",
                  older_date_payments_history: "29042012",
                  payment_frequency: "Z",
                  payments_history: "111111111111111111111111",
                  product: "CC",
                  reporting_mode: "A",
                  responsability_type: "I",
                  user_name: "BANCO",
                  user_phone_number: "0"
                },
                %{
                  account_type: "R",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "8400",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "02012011",
                  date_of_maximum_defaulting: "31012011",
                  date_of_report: "30042016",
                  date_of_update: "06052016",
                  last_date_of_payment: "16062012",
                  last_date_of_payments_history: "30032016",
                  last_date_of_use: "28082011",
                  manner_of_payment: "UR",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "7276",
                  older_date_payments_history: "30012011",
                  payment_frequency: "Z",
                  payments_history: "UUUUUUUUUUUUUUUUUUUUUUUU",
                  product: "CC",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "00",
                  user_name: "BANCO",
                  user_phone_number: "0"
                },
                %{
                  account_type: "R",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "1000",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "06112010",
                  date_of_maximum_defaulting: "31012011",
                  date_of_report: "30042016",
                  date_of_update: "03052016",
                  last_date_of_payment: "16062012",
                  last_date_of_payments_history: "30032016",
                  last_date_of_use: "28082011",
                  manner_of_payment: "UR",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "0",
                  observation_code: "IA",
                  older_date_payments_history: "30112010",
                  payment_frequency: "Z",
                  payments_history: "UUUUUUUUUUUUUUUUUUUUUUUU",
                  product: "CC",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "00",
                  user_name: "TIENDA COMERCIAL",
                  user_phone_number: "0"
                },
                %{
                  account_type: "R",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "1100",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "27102009",
                  date_of_maximum_defaulting: "31012011",
                  date_of_report: "30042016",
                  date_of_update: "03052016",
                  last_date_of_payment: "03062010",
                  last_date_of_payments_history: "30032016",
                  last_date_of_use: "29112013",
                  manner_of_payment: "UR",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "224",
                  observation_code: "IA",
                  older_date_payments_history: "30112013",
                  payment_frequency: "Z",
                  payments_history: "UUUUUUUUUUUUUUUUUUUUUUUU",
                  product: "CC",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "00",
                  user_name: "TIENDA COMERCIAL",
                  user_phone_number: "0"
                },
                %{
                  account_type: "R",
                  amount_of_last_payment: "610",
                  amount_to_pay: "379",
                  balance_due: "0",
                  credit_limit: "30300",
                  currency: "MX",
                  current_balance: "459+",
                  date_of_account_opening: "24032010",
                  date_of_maximum_defaulting: "31012011",
                  date_of_report: "30042016",
                  date_of_update: "04052016",
                  last_date_of_payment: "28042016",
                  last_date_of_payments_history: "30032016",
                  last_date_of_use: "18042016",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "17233",
                  observation_code: "IA",
                  older_date_payments_history: "30112013",
                  payment_frequency: "Z",
                  payments_history: "UUUUUUUUUUUUUUUUUUUUUUUU",
                  product: "CC",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "00",
                  user_name: "BANCO",
                  user_phone_number: "0"
                },
                %{
                  account_type: "O",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "20000",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "19052013",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "30042016",
                  date_of_update: "05052016",
                  last_date_of_payment: "18042016",
                  last_date_of_payments_history: "22032016",
                  last_date_of_use: "13042016",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "933",
                  observation_code: "IA",
                  older_date_payments_history: "22022013",
                  payment_frequency: "M",
                  payments_history: "111111111111111111111111",
                  product: "CL",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "COMUNICACIONES",
                  user_phone_number: "0"
                },
                %{
                  account_type: "R",
                  amount_of_last_payment: "610",
                  amount_to_pay: "379",
                  balance_due: "0",
                  credit_limit: "30300",
                  currency: "MX",
                  current_balance: "459+",
                  date_of_account_opening: "24032010",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "30042016",
                  date_of_update: "11052016",
                  last_date_of_payment: "28042016",
                  last_date_of_payments_history: "30032016",
                  last_date_of_use: "18042016",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "17233",
                  observation_code: "IA",
                  older_date_payments_history: "30062011",
                  payment_frequency: "Z",
                  payments_history: "111111111111111111111111",
                  product: "CC",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "BANCO",
                  user_phone_number: "0"
                },
                %{
                  account_type: "R",
                  amount_of_last_payment: "610",
                  amount_to_pay: "220",
                  balance_due: "0",
                  credit_limit: "17600",
                  currency: "MX",
                  current_balance: "1423+",
                  date_of_account_opening: "10122014",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "29042016",
                  date_of_update: "09052016",
                  last_date_of_payment: "24042016",
                  last_date_of_payments_history: "29032016",
                  last_date_of_use: "24042016",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "5836",
                  observation_code: "IA",
                  older_date_payments_history: "29122014",
                  payment_frequency: "Z",
                  payments_history: "1111111111111111",
                  product: "CC",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "BANCO",
                  user_phone_number: "0"
                },
                %{
                  account_type: "O",
                  amount_of_last_payment: "610",
                  amount_to_pay: "400",
                  balance_due: "0",
                  credit_limit: "0",
                  currency: "MX",
                  current_balance: "400+",
                  date_of_account_opening: "05092015",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "29022016",
                  date_of_update: "18032016",
                  last_date_of_payment: "22022016",
                  last_date_of_payments_history: "29012016",
                  last_date_of_use: "01022016",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "0",
                  observation_code: "IA",
                  older_date_payments_history: "29102015",
                  payment_frequency: "M",
                  payments_history: "1111",
                  product: "CL",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "SERVICIOS",
                  user_phone_number: "0"
                },
                %{
                  account_type: "R",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "3000",
                  currency: "N$",
                  current_balance: "0+",
                  date_of_account_opening: "24032010",
                  date_of_close: "31082011",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "31082011",
                  date_of_update: "24092011",
                  last_date_of_payment: "31082011",
                  last_date_of_payments_history: "02072011",
                  last_date_of_use: "27082011",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "2954",
                  observation_code: "CC",
                  older_date_payments_history: "30062010",
                  payment_frequency: "Z",
                  payments_history: "11111111111111",
                  product: "CC",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "BANCO",
                  user_phone_number: "0"
                },
                %{
                  account_type: "I",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "5100",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "10012010",
                  date_of_close: "09032010",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "31032011",
                  date_of_update: "31032011",
                  last_date_of_payment: "09032010",
                  last_date_of_payments_history: "31032011",
                  last_date_of_use: "10012010",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "0",
                  number_of_payments: "12",
                  observation_code: "CC",
                  older_date_payments_history: "01011901",
                  payment_frequency: "M",
                  payments_history: "1111UUUUU11",
                  product: "AF",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "TIENDA COMERCIAL",
                  user_phone_number: "1"
                },
                %{
                  account_type: "I",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "5100",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "24022010",
                  date_of_close: "06072010",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "31032011",
                  date_of_update: "31032011",
                  last_date_of_payment: "06072010",
                  last_date_of_payments_history: "31032011",
                  last_date_of_use: "24022010",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "0",
                  number_of_payments: "12",
                  observation_code: "CC",
                  older_date_payments_history: "01011901",
                  payment_frequency: "M",
                  payments_history: "UUUUU1",
                  product: "AF",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "TIENDA COMERCIAL",
                  user_phone_number: "1"
                },
                %{
                  account_type: "I",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "5100",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "18042010",
                  date_of_close: "17072010",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "31032011",
                  date_of_update: "31032011",
                  last_date_of_payment: "17072010",
                  last_date_of_payments_history: "31032011",
                  last_date_of_use: "18042010",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "0",
                  number_of_payments: "12",
                  observation_code: "CC",
                  older_date_payments_history: "01011901",
                  payment_frequency: "M",
                  payments_history: "UUUUU1",
                  product: "AF",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "TIENDA COMERCIAL",
                  user_phone_number: "1"
                },
                %{
                  account_type: "I",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "5100",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "16052010",
                  date_of_close: "11082010",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "31032011",
                  date_of_update: "31032011",
                  last_date_of_payment: "11082010",
                  last_date_of_payments_history: "31032011",
                  last_date_of_use: "16052010",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "0",
                  number_of_payments: "12",
                  observation_code: "CC",
                  older_date_payments_history: "01011901",
                  payment_frequency: "M",
                  payments_history: "UUUUU1",
                  product: "AF",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "TIENDA COMERCIAL",
                  user_phone_number: "1"
                } |
                %{
                  account_type: "I",
                  amount_of_last_payment: "610",
                  amount_to_pay: "0",
                  balance_due: "0",
                  credit_limit: "5100",
                  currency: "MX",
                  current_balance: "0+",
                  date_of_account_opening: "10102010",
                  date_of_close: "28102010",
                  date_of_maximum_defaulting: "31052014",
                  date_of_report: "31032011",
                  date_of_update: "31032011",
                  last_date_of_payment: "28102010",
                  last_date_of_payments_history: "31032011",
                  last_date_of_use: "10102010",
                  manner_of_payment: "01",
                  maximum_balance_of_defaulting: "0",
                  maximum_credit_authorized: "0",
                  number_of_payments: "12",
                  observation_code: "CC",
                  older_date_payments_history: "01011901",
                  payment_frequency: "M",
                  payments_history: "U1",
                  product: "AF",
                  reporting_mode: "A",
                  responsability_type: "I",
                  slowness_in_pay_MOP: "02",
                  user_name: "TIENDA COMERCIAL",
                  user_phone_number: "1"
                }
              ],
              hawk_inquiry: %{},
              hawk_response: %{},
              person: %{
                birth_date: "16021988",
                curp: "UAMH880216HPLRZC09",
                first_name: "HECTOR",
                genre: "M",
                last_name: "URBANO",
                last_name_2: "MAZA",
                marital_status: "S",
                nationality: "MX",
                residential_type: "1",
                rfc: "UAMH880216S19"
              },
              queries: [
                %{
                  contract_value: "0",
                  date_of_query: "19052016",
                  member_code: "FF47361001",
                  product: "CC",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "RESUELVE"
                },
                %{
                  contract_value: "000000000",
                  currency: "MX",
                  date_of_query: "19052016",
                  member_code: "FF47361001",
                  product: "CC",
                  reserved: "1",
                  responsability_type: "I",
                  user_name: "BURO DE CREDITO"
                },
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "06122015",
                  member_code: "FF47361001",
                  product: "UK",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "BANCO"
                },
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "08092015",
                  member_code: "FF47361001",
                  product: "UK",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "BANCO"
                },
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "10072015",
                  member_code: "FF47361001",
                  product: "UK",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "CONSUMIDOR FINAL"
                },
                %{
                  contract_value: "000000000",
                  currency: "MX",
                  date_of_query: "10072015",
                  member_code: "FF47361001",
                  product: "01",
                  reserved: "1",
                  responsability_type: "I",
                  user_name: "SIC"
                },
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "01052015",
                  member_code: "FF47361001",
                  product: "CC",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "BANCO"
                },
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "15012015",
                  member_code: "FF47361001",
                  product: "CC",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "BANCO"
                },
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "02122014",
                  member_code: "FF47361001",
                  product: "CC",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "BANCO"
                },
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "02122014",
                  member_code: "FF47361001",
                  product: "CC",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "BANCO"
                },
                %{
                  contract_value: "000000000",
                  currency: "MX",
                  date_of_query: "02122014",
                  member_code: "FF47361001",
                  product: "01",
                  reserved: "1",
                  responsability_type: "I",
                  user_name: "BURO DE CREDITO"
                },
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "19092014",
                  member_code: "FF47361001",
                  product: "UK",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "CONSUMIDOR FINAL"
                },
                %{
                  contract_value: "000000000",
                  currency: "MX",
                  date_of_query: "19092014",
                  member_code: "FF47361001",
                  product: "01",
                  reserved: "1",
                  responsability_type: "I",
                  user_name: "SIC"
                } |
                %{
                  contract_value: "0",
                  currency: "MX",
                  date_of_query: "10072014",
                  member_code: "FF47361001",
                  product: "UK",
                  reserved: "0",
                  responsability_type: "I",
                  user_name: "CONSUMIDOR FINAL"
                }
              ],
              score: %{
                first_reason_code: "04",
                name: "BC SCORE",
                score_code: "007",
                score_value: "0725"
              },
              summary: %{
                number_of_accounts_with_MOP_02: "00",
                total_current_balance_of_accounts_of_mortage_or_fixed_payments: "000000000+",
                percentage_of_limit_credit_of_accounts_with_revolving_credit: "006",
                opening_date_of_newest_account: "05092015",
                customer_declaration: "N",
                number_of_accounts: "0015",
                number_of_accounts_with_MOP_UR: "03",
                number_of_accounts_with_MOP_05: "00",
                opening_date_of_older_account: "27102009",
                number_of_accounts_with_revolving_credit: "0010",
                total_limit_credit_of_accounts_with_revolving_credit: "000106200",
                number_of_accounts_with_MOP_03: "00",
                number_of_accounts_with_MOP_06: "00",
                total_payment_amount_of_accounts_with_revolving_credit: "000001590",
                total_balance_due_of_accounts_of_mortage_or_fixed_payments: "000000000",
                total_current_balance_of_accounts_with_revolving_credit: "000007174+",
                number_of_accounts_of_mortage_or_fixed_payments: "0005",
                number_of_accounts_with_MOP_96: "00",
                alert_message: "NNNNN",
                number_of_accounts_with_MOP_07: "00",
                number_of_accounts_with_MOP_01: "12",
                most_recent_openning_date_of_account_in_collection_agency: "00000000",
                number_of_requests_to_client_record: "02",
                total_balance_due_of_accounts_with_revolving_credit: "000000000",
                date_of_latest_request: "19052016",
                number_of_buro_requests_made_by_collection_agencies: "00",
                date_of_integration: "06112009",
                number_of_buro_request: "13",
                new_address_in_last_60_days: "N",
                number_of_accounts_with_MOP_98: "00",
                number_of_accounts_with_current_slowness_in_pay: "0000",
                credit_currency: "MX",
                number_of_accounts_with_MOP_97: "00",
                total_payment_amount_of_accounts_of_mortage_or_fixed_payments: "000000000",
                number_of_accounts_with_MOP_00: "00",
                date_of_last_request_of_buro_made_by_a_collection_agency: "00000000",
                number_of_closed_accounts: "0006",
                number_of_accounts_with_slowness_in_pay_history: "0000",
                total_maximum_credit_of_accounts_with_revolving_credit: "000060825",
                number_of_accounts_with_MOP_04: "00",
                total_maximum_credit_of_accounts_of_mortage_or_fixed_payments: "000000000",
                number_of_accounts_in_collection_agencies: "00",
                number_of_accounts_in_clarification: "00"
              },
              work_addresses: [
                %{
                  country_code: "MX",
                  date_of_hire: "05052005",
                  date_of_registration: "08092015",
                  street_2: "",
                  ocuppation: "AUX",
                  street: "GEOTECNIA Y SUPERVICION TECNICA SA"
                } |
                %{
                  country_code: "MX",
                  date_of_hire: "05052005",
                  date_of_registration: "08092015",
                  street_2: "",
                  ocuppation: "AUX",
                  street: "RESUELVE TU DEUDA"
                }
              ]
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

  test "match inquiry HWK section" do
    string = "HI083105201500035200116SERV. PUB. SANC.0219003-24052015- - -0-"
    assert match_section(string, "HI", ["HI", "HR"]) ==
    {
      %{
        codigo_de_la_prevencion: "520",
        fecha_de_reporte: ~D[2015-05-31],
        mensaje: "003-24052015- - -0-",
        tipo_de_usuario: "SERV. PUB. SANC."
      }, ""}
  end

  test "match response HWK section" do
    string = "HR081112201500035400116SERV. PUB. SANC.02335006-15072015-16072015-12012017-5"
    assert match_section(string, "HR", ["HR"]) ==
    {
      %{
        tipo_de_usuario: "SERV. PUB. SANC.",
        codigo_de_la_prevencion: "540",
        fecha_de_reporte: ~D[2015-12-11],
        mensaje: "5006-15072015-16072015-12012017-5"
      }, ""}
  end

  test "Extraer varias declarativas del cliente" do
    string = "CR0402700000ESTA ES UNA DECLARATIVA DE PRUEBA##CREDITO01 POR CADA CREDITO EL CONSUMIDOR PUEDE MANIFESTAR SU INCONFORMIDAD##CREDITO02 CADA DECLARATIVA PUEDE CONTENER HASTA MIL PALABRAS##CREDITO03 LAS DECLARATIVAS SE DESPLEGARAN DE ACUERDO CON LA SECUENCIA DE LOS CREDITOS"
    assert match_section(string, "CR", ["CR"]) ==
    {
      %{
        declarativa: [
          {"Expediente", "ESTA ES UNA DECLARATIVA DE PRUEBA"},
          {"01", " POR CADA CREDITO EL CONSUMIDOR PUEDE MANIFESTAR SU INCONFORMIDAD"},
          {"02", " CADA DECLARATIVA PUEDE CONTENER HASTA MIL PALABRAS"},
          {"03", " LAS DECLARATIVAS SE DESPLEGARAN DE ACUERDO CON LA SECUENCIA DE LOS CREDITOS"}],
        tipo_de_segmento: "0270"}, ""}
  end

  test "match multiple section values" do
    string = "PN06URBANO0004MAZA0206HECTOR0408160219880513UAMH880216S190802MX"
    assert match_section(string, "PN", ["PN"]) ==  {
      %{:birth_date => ~D[1988-02-16],
        :first_name => "HECTOR",
        :last_name => "URBANO",
        :last_name_2 => "MAZA",
        :nationality => "MX",
        :rfc => "UAMH880216S19"}, ""}

  end

  test "parse multiple sintetiza features" do
    string = "CL02150001101019020523432CL021500011010210020820100203"
    assert match_section(string, "CL", ["CL"]) == {
      [%{
          identificador_de_caracteristica_de_plantilla: "1",
          numero_de_caracteristica: 9,
          plantilla_solicitada: "15",
          valor_de_la_caracteristica: "23432"
       } |
       %{
         identificador_de_caracteristica_de_plantilla: "1",
         numero_de_caracteristica: 10,
         plantilla_solicitada: "15",
         valor_de_la_caracteristica: "20100203"
       }
      ], ""}

  end

end
