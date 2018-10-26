defmodule ParserTest do
  use ExUnit.Case

  import Burox.Response.Parser

  @success_response "INTL13                         MX1010FF4736100110PN06URBANO0004MAZA0206HECTOR0408160219880513UAMH880216S190802MX090111101S1201M1518UAMH880216HPLRZC09PA09ILAMA 3130123PEDREGAL DE STO DOMINGO0208COYOACAN0312CD DE MEXICO0402DF050504369071055454322911001H120819092014PA15FILIPINAS 613 A0008PORTALES0213BENITO JUAREZ0312CD DE MEXICO0402DF05050350007105545432291120807022013PA1114 DE FEB 900085 DE OCT0119LLANO DE BUENAVISTA0212HUAUCHINANGO0403PUE050573160060801011989070776277891001H1208160320101302MXPA18CTO DE LA UNION 340019MISIONES DE SN FRAN0303PUE0403PUE05057200007107767627789120831102009PE34GEOTECNIA Y SUPERVICION TECNICA SA00001003AUX1108050520051708080920152002MXPE17RESUELVE TU DEUDA00002002MXTL08160520160205BANCO030100501I0601R0702CC0802MX1101Z12032121308010420121408020520161508220420161708020520161801A21051209022054433+2305175002401026020127241111111111111111111111112808300420162908290420124503500TL08060520160205BANCO030100501I0601R0702CC0802MX1101Z120101308020120111408160620121508280820111708300420161801A2104727622020+23048400240102602UR2724UUUUUUUUUUUUUUUUUUUUUUUU280830032016290830012011360103708310120113802004503610TL08030520160216TIENDA COMERCIAL030100501I0601R0702CC0802MX1101Z1308061120101708300420161801A2101022020+23041000240102602UR2724UUUUUUUUUUUUUUUUUUUUUUUU2808300320162908301120103002IATL08030520160216TIENDA COMERCIAL030100501I0601R0702CC0802MX1101Z1308271020091408030620101508291120131708300420161801A210322422020+23041100240102602UR2724UUUUUUUUUUUUUUUUUUUUUUUU280830032016290830112013TL08040520160205BANCO030100501I0601R0702CC0802MX1101Z12033791308240320101408280420161508180420161708300420161801A2105172332204459+23053030024010260201TL08050520160214COMUNICACIONES030100501I0601O0702CL0802MX1101M120101308190520131408180420161508130420161708300420161801A210393322020+230520000240102602012724111111111111111111111111280822032016290822022013370831052014380202TL08110520160205BANCO030100501I0601R0702CC0802MX1101Z12033791308240320101408280420161508180420161708300420161801A2105172332204459+230530300240102602012724111111111111111111111111280830032016290830062011TL08090520160205BANCO030100501I0601R0702CC0802MX1101Z12032201308101220141408240420161508240420161708290420161801A2104583622051423+2305176002401026020127161111111111111111280829032016290829122014TL08180320160209SERVICIOS030100501I0601O0702CL0802MX1101M12034001308050920151408220220161508010220161708290220161801A210102204400+230102401026020127041111280829012016290829102015TL08240920110205BANCO030100501I0601R0702CC0802N$1101Z120101308240320101408310820111508270820111608310820111708310820111801A2104295422020+23043000240102602012714111111111111112808020720112908300620103002CCTL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308100120101408090320101508100120101608090320101708310320112101022020+230451002401026020127111111UUUUU11280831032011290801011901TL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308240220101408060720101508240220101608060720101708310320112101022020+23045100240102602012706UUUUU1280831032011290801011901TL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308180420101408170720101508180420101608170720101708310320112101022020+23045100240102602012706UUUUU1280831032011290801011901TL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308160520101408110820101508160520101608110820101708310320112101022020+23045100240102602012706UUUUU1280831032011290801011901TL08310320110216TIENDA COMERCIAL030110501I0601I0702AF0802MX1002121101M120101308101020101408281020101508101020101608281020101708310320112101022020+23045100240102602012702U1280831032011290801011901IQ08190520160110FF473610010208RESUELVE0402CC060100701I09010IQ0819052016000400000215BURO DE CREDITO0402CC0502MX060900000000009011IQ08061220150205BANCO0402UK060100701I09010IQ08080920150205BANCO0402UK060100701I09010IQ08100720150216CONSUMIDOR FINAL0402UK060100701I09010IQ0810072015000400000203SIC0402010502MX060900000000009011IQ08010520150205BANCO0402CC060100701I09010IQ08150120150205BANCO0402CC060100701I09010IQ08021220140205BANCO0402CC060100701I09010IQ08021220140205BANCO0402CC060100701I09010IQ0802122014000400000215BURO DE CREDITO0402010502MX060900000000009011IQ08190920140216CONSUMIDOR FINAL0402UK060100701I09010IQ0819092014000400000203SIC0402010502MX060900000000009011IQ08100720140216CONSUMIDOR FINAL0402UK060100701I09010RS08061120090002000102000202000302000402000502000602120702000802030904001510040005110400101204000613040000140400001502001602021701N1805NNNNN1901N2002MX210900006082522090001062002310000007174+24090000000002509000001590260300627090000000002810000000000+29090000000003009000000000310200320200330200340827102009350805092015360213370819052016380200390800000000400200410800000000HR082609201800030020116BURO DE CREDITO 0221NO EXISTE INFORMACIONSC08BC SCORE000300701040725020204ES0504822001011792509390102**"

  @error_response "ERRRUR25                         1101YES05000530002**"

  test "parse succesful response" do
    assert {:ok, response} = process_response(@success_response)

    assert response ==
             %Burox.Response{
               consultas: [
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2016-05-19],
                   importe_del_credito: "0",
                   nombre_del_usuario: "RESUELVE",
                   reserved: "0",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2016-05-19],
                   importe_del_credito: "000000000",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "BURO DE CREDITO",
                   reserved: "1",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2015-12-06],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "BANCO",
                   reserved: "0",
                   tipo_de_producto: "UK",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2015-09-08],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "BANCO",
                   reserved: "0",
                   tipo_de_producto: "UK",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2015-07-10],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "CONSUMIDOR FINAL",
                   reserved: "0",
                   tipo_de_producto: "UK",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2015-07-10],
                   importe_del_credito: "000000000",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "SIC",
                   reserved: "1",
                   tipo_de_producto: "01",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2015-05-01],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "BANCO",
                   reserved: "0",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2015-01-15],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "BANCO",
                   reserved: "0",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2014-12-02],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "BANCO",
                   reserved: "0",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2014-12-02],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "BANCO",
                   reserved: "0",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2014-12-02],
                   importe_del_credito: "000000000",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "BURO DE CREDITO",
                   reserved: "1",
                   tipo_de_producto: "01",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2014-09-19],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "CONSUMIDOR FINAL",
                   reserved: "0",
                   tipo_de_producto: "UK",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2014-09-19],
                   importe_del_credito: "000000000",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "SIC",
                   reserved: "1",
                   tipo_de_producto: "01",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   clave_del_usuario: "FF47361001",
                   fecha_de_consulta: ~D[2014-07-10],
                   importe_del_credito: "0",
                   moneda_del_credito: "MX",
                   nombre_del_usuario: "CONSUMIDOR FINAL",
                   reserved: "0",
                   tipo_de_producto: "UK",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 }
               ],
               creditos: [
                 %{
                   clasificacion_de_puntualidad_de_pago: "01",
                   credito_maximo_autorizado: 12_090.0,
                   fecha_de_actualizacion: ~D[2016-05-16],
                   fecha_de_apertura_de_cuenta: ~D[2012-04-01],
                   fecha_de_reporte_de_informacion: ~D[2016-05-02],
                   fecha_de_ultima_compra: ~D[2016-04-22],
                   fecha_de_ultimo_pago: ~D[2016-05-02],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2012-04-29],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-04-30],
                   frecuencia_de_pagos: "Z",
                   historico_de_pagos: "111111111111111111111111",
                   limite_de_credito: 1.75e4,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 212.0,
                   monto_del_ultimo_pago: 500.0,
                   nombre_del_usuario: "BANCO",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 4433.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "R",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "00",
                   clasificacion_de_puntualidad_de_pago: "UR",
                   credito_maximo_autorizado: 7276.0,
                   fecha_de_actualizacion: ~D[2016-05-06],
                   fecha_de_apertura_de_cuenta: ~D[2011-01-02],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2011-01-31],
                   fecha_de_reporte_de_informacion: ~D[2016-04-30],
                   fecha_de_ultima_compra: ~D[2011-08-28],
                   fecha_de_ultimo_pago: ~D[2012-06-16],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2011-01-30],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-03-30],
                   frecuencia_de_pagos: "Z",
                   historico_de_pagos: "UUUUUUUUUUUUUUUUUUUUUUUU",
                   limite_de_credito: 8.4e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "BANCO",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "R",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "00",
                   clasificacion_de_puntualidad_de_pago: "UR",
                   clave_de_observacion: "IA",
                   credito_maximo_autorizado: 0.0,
                   fecha_de_actualizacion: ~D[2016-05-03],
                   fecha_de_apertura_de_cuenta: ~D[2010-11-06],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2011-01-31],
                   fecha_de_reporte_de_informacion: ~D[2016-04-30],
                   fecha_de_ultima_compra: ~D[2011-08-28],
                   fecha_de_ultimo_pago: ~D[2012-06-16],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2010-11-30],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-03-30],
                   frecuencia_de_pagos: "Z",
                   historico_de_pagos: "UUUUUUUUUUUUUUUUUUUUUUUU",
                   limite_de_credito: 1.0e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "TIENDA COMERCIAL",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "R",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "00",
                   clasificacion_de_puntualidad_de_pago: "UR",
                   clave_de_observacion: "IA",
                   credito_maximo_autorizado: 224.0,
                   fecha_de_actualizacion: ~D[2016-05-03],
                   fecha_de_apertura_de_cuenta: ~D[2009-10-27],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2011-01-31],
                   fecha_de_reporte_de_informacion: ~D[2016-04-30],
                   fecha_de_ultima_compra: ~D[2013-11-29],
                   fecha_de_ultimo_pago: ~D[2010-06-03],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2013-11-30],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-03-30],
                   frecuencia_de_pagos: "Z",
                   historico_de_pagos: "UUUUUUUUUUUUUUUUUUUUUUUU",
                   limite_de_credito: 1.1e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "TIENDA COMERCIAL",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "R",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "00",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "IA",
                   credito_maximo_autorizado: 17_233.0,
                   fecha_de_actualizacion: ~D[2016-05-04],
                   fecha_de_apertura_de_cuenta: ~D[2010-03-24],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2011-01-31],
                   fecha_de_reporte_de_informacion: ~D[2016-04-30],
                   fecha_de_ultima_compra: ~D[2016-04-18],
                   fecha_de_ultimo_pago: ~D[2016-04-28],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2013-11-30],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-03-30],
                   frecuencia_de_pagos: "Z",
                   historico_de_pagos: "UUUUUUUUUUUUUUUUUUUUUUUU",
                   limite_de_credito: 3.03e4,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 379.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "BANCO",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 459.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "R",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "IA",
                   credito_maximo_autorizado: 933.0,
                   fecha_de_actualizacion: ~D[2016-05-05],
                   fecha_de_apertura_de_cuenta: ~D[2013-05-19],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2016-04-30],
                   fecha_de_ultima_compra: ~D[2016-04-13],
                   fecha_de_ultimo_pago: ~D[2016-04-18],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2013-02-22],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-03-22],
                   frecuencia_de_pagos: "M",
                   historico_de_pagos: "111111111111111111111111",
                   limite_de_credito: 2.0e4,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "COMUNICACIONES",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "O",
                   tipo_de_producto: "CL",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "IA",
                   credito_maximo_autorizado: 17_233.0,
                   fecha_de_actualizacion: ~D[2016-05-11],
                   fecha_de_apertura_de_cuenta: ~D[2010-03-24],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2016-04-30],
                   fecha_de_ultima_compra: ~D[2016-04-18],
                   fecha_de_ultimo_pago: ~D[2016-04-28],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2011-06-30],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-03-30],
                   frecuencia_de_pagos: "Z",
                   historico_de_pagos: "111111111111111111111111",
                   limite_de_credito: 3.03e4,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 379.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "BANCO",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 459.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "R",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "IA",
                   credito_maximo_autorizado: 5836.0,
                   fecha_de_actualizacion: ~D[2016-05-09],
                   fecha_de_apertura_de_cuenta: ~D[2014-12-10],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2016-04-29],
                   fecha_de_ultima_compra: ~D[2016-04-24],
                   fecha_de_ultimo_pago: ~D[2016-04-24],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2014-12-29],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-03-29],
                   frecuencia_de_pagos: "Z",
                   historico_de_pagos: "1111111111111111",
                   limite_de_credito: 1.76e4,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 220.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "BANCO",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 1423.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "R",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "IA",
                   credito_maximo_autorizado: 0.0,
                   fecha_de_actualizacion: ~D[2016-03-18],
                   fecha_de_apertura_de_cuenta: ~D[2015-09-05],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2016-02-29],
                   fecha_de_ultima_compra: ~D[2016-02-01],
                   fecha_de_ultimo_pago: ~D[2016-02-22],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2015-10-29],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2016-01-29],
                   frecuencia_de_pagos: "M",
                   historico_de_pagos: "1111",
                   limite_de_credito: 0.0,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 400.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "SERVICIOS",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 400.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "O",
                   tipo_de_producto: "CL",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "CC",
                   credito_maximo_autorizado: 2954.0,
                   fecha_de_actualizacion: ~D[2011-09-24],
                   fecha_de_apertura_de_cuenta: ~D[2010-03-24],
                   fecha_de_cierre: ~D[2011-08-31],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2011-08-31],
                   fecha_de_ultima_compra: ~D[2011-08-27],
                   fecha_de_ultimo_pago: ~D[2011-08-31],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[2010-06-30],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2011-07-02],
                   frecuencia_de_pagos: "Z",
                   historico_de_pagos: "11111111111111",
                   limite_de_credito: 3.0e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "N$",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "BANCO",
                   numero_telefonico_del_usuario: "0",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "R",
                   tipo_de_producto: "CC",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "CC",
                   credito_maximo_autorizado: 0.0,
                   fecha_de_actualizacion: ~D[2011-03-31],
                   fecha_de_apertura_de_cuenta: ~D[2010-01-10],
                   fecha_de_cierre: ~D[2010-03-09],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2011-03-31],
                   fecha_de_ultima_compra: ~D[2010-01-10],
                   fecha_de_ultimo_pago: ~D[2010-03-09],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[1901-01-01],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2011-03-31],
                   frecuencia_de_pagos: "M",
                   historico_de_pagos: "1111UUUUU11",
                   limite_de_credito: 5.1e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "TIENDA COMERCIAL",
                   numero_de_pagos: 12,
                   numero_telefonico_del_usuario: "1",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "I",
                   tipo_de_producto: "AF",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "CC",
                   credito_maximo_autorizado: 0.0,
                   fecha_de_actualizacion: ~D[2011-03-31],
                   fecha_de_apertura_de_cuenta: ~D[2010-02-24],
                   fecha_de_cierre: ~D[2010-07-06],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2011-03-31],
                   fecha_de_ultima_compra: ~D[2010-02-24],
                   fecha_de_ultimo_pago: ~D[2010-07-06],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[1901-01-01],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2011-03-31],
                   frecuencia_de_pagos: "M",
                   historico_de_pagos: "UUUUU1",
                   limite_de_credito: 5.1e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "TIENDA COMERCIAL",
                   numero_de_pagos: 12,
                   numero_telefonico_del_usuario: "1",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "I",
                   tipo_de_producto: "AF",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "CC",
                   credito_maximo_autorizado: 0.0,
                   fecha_de_actualizacion: ~D[2011-03-31],
                   fecha_de_apertura_de_cuenta: ~D[2010-04-18],
                   fecha_de_cierre: ~D[2010-07-17],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2011-03-31],
                   fecha_de_ultima_compra: ~D[2010-04-18],
                   fecha_de_ultimo_pago: ~D[2010-07-17],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[1901-01-01],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2011-03-31],
                   frecuencia_de_pagos: "M",
                   historico_de_pagos: "UUUUU1",
                   limite_de_credito: 5.1e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "TIENDA COMERCIAL",
                   numero_de_pagos: 12,
                   numero_telefonico_del_usuario: "1",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "I",
                   tipo_de_producto: "AF",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "CC",
                   credito_maximo_autorizado: 0.0,
                   fecha_de_actualizacion: ~D[2011-03-31],
                   fecha_de_apertura_de_cuenta: ~D[2010-05-16],
                   fecha_de_cierre: ~D[2010-08-11],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2011-03-31],
                   fecha_de_ultima_compra: ~D[2010-05-16],
                   fecha_de_ultimo_pago: ~D[2010-08-11],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[1901-01-01],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2011-03-31],
                   frecuencia_de_pagos: "M",
                   historico_de_pagos: "UUUUU1",
                   limite_de_credito: 5.1e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "TIENDA COMERCIAL",
                   numero_de_pagos: 12,
                   numero_telefonico_del_usuario: "1",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "I",
                   tipo_de_producto: "AF",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 },
                 %{
                   MOP_de_la_morosidad_mas_alta: "02",
                   clasificacion_de_puntualidad_de_pago: "01",
                   clave_de_observacion: "CC",
                   credito_maximo_autorizado: 0.0,
                   fecha_de_actualizacion: ~D[2011-03-31],
                   fecha_de_apertura_de_cuenta: ~D[2010-10-10],
                   fecha_de_cierre: ~D[2010-10-28],
                   fecha_de_la_morosidad_historica_mas_alta: ~D[2014-05-31],
                   fecha_de_reporte_de_informacion: ~D[2011-03-31],
                   fecha_de_ultima_compra: ~D[2010-10-10],
                   fecha_de_ultimo_pago: ~D[2010-10-28],
                   fecha_mas_antigua_del_historico_de_pagos: ~D[1901-01-01],
                   fecha_mas_reciente_del_historico_de_pagos: ~D[2011-03-31],
                   frecuencia_de_pagos: "M",
                   historico_de_pagos: "U1",
                   limite_de_credito: 5.1e3,
                   modo_de_reportar: "A",
                   moneda_del_credito: "MX",
                   monto_a_pagar: 0.0,
                   monto_del_ultimo_pago: 610.0,
                   nombre_del_usuario: "TIENDA COMERCIAL",
                   numero_de_pagos: 12,
                   numero_telefonico_del_usuario: "1",
                   saldo_actual: 0.0,
                   saldo_de_la_morosidad_historica_mas_alta: 0.0,
                   saldo_vencido: 0.0,
                   tipo_de_cuenta: "I",
                   tipo_de_producto: "AF",
                   tipo_de_responsabilidad_de_la_cuenta: "I"
                 }
               ],
               declarativa_consumidor: %{},
               direcciones: [
                 %{
                   ciudad: "CD DE MEXICO",
                   codigo_postal: "04369",
                   colonia: "PEDREGAL DE STO DOMINGO",
                   estado: "DF",
                   fecha_de_reporte_de_la_direccion: ~D[2014-09-19],
                   municipio: "COYOACAN",
                   numero_de_telefono: "5545432291",
                   primera_linea_de_direccion: "ILAMA 313",
                   tipo_de_domicilio: "H"
                 },
                 %{
                   ciudad: "CD DE MEXICO",
                   codigo_postal: "03500",
                   colonia: "PEDREGAL DE STO DOMINGO",
                   estado: "DF",
                   fecha_de_reporte_de_la_direccion: ~D[2013-02-07],
                   municipio: "BENITO JUAREZ",
                   numero_de_telefono: "5545432291",
                   primera_linea_de_direccion: "FILIPINAS 613 A",
                   segunda_linea_de_direccion: "PORTALES",
                   tipo_de_domicilio: "H"
                 },
                 %{
                   ciudad: "CD DE MEXICO",
                   codigo_postal: "73160",
                   colonia: "LLANO DE BUENAVISTA",
                   estado: "PUE",
                   fecha_de_reporte_de_la_direccion: ~D[2010-03-16],
                   fecha_de_residencia: ~D[1989-01-01],
                   municipio: "HUAUCHINANGO",
                   numero_de_telefono: "7627789",
                   origen_del_domicilio: "MX",
                   primera_linea_de_direccion: "14 DE FEB 9",
                   segunda_linea_de_direccion: "5 DE OCT",
                   tipo_de_domicilio: "H"
                 },
                 %{
                   ciudad: "PUE",
                   codigo_postal: "72000",
                   colonia: "LLANO DE BUENAVISTA",
                   estado: "PUE",
                   fecha_de_reporte_de_la_direccion: ~D[2009-10-31],
                   fecha_de_residencia: ~D[1989-01-01],
                   municipio: "HUAUCHINANGO",
                   numero_de_telefono: "7767627789",
                   origen_del_domicilio: "MX",
                   primera_linea_de_direccion: "CTO DE LA UNION 34",
                   segunda_linea_de_direccion: "MISIONES DE SN FRAN",
                   tipo_de_domicilio: "H"
                 }
               ],
               direcciones_de_trabajo: [
                 %{
                   fecha_de_contratacion: ~D[2005-05-05],
                   fecha_de_reporte_de_empleo: ~D[2015-09-08],
                   ocupacion: "AUX",
                   origen_de_la_razon_social: "MX",
                   primera_linea_de_direccion: "",
                   nombre_o_razon_social_del_empleador: "GEOTECNIA Y SUPERVICION TECNICA SA"
                 },
                 %{
                   fecha_de_contratacion: ~D[2005-05-05],
                   fecha_de_reporte_de_empleo: ~D[2015-09-08],
                   ocupacion: "AUX",
                   origen_de_la_razon_social: "MX",
                   primera_linea_de_direccion: "",
                   nombre_o_razon_social_del_empleador: "RESUELVE TU DEUDA"
                 }
               ],
               fin: %{
                 fin_del_registro_de_respuesta: "**",
                 longitud_de_transmision: 4822,
                 numero_de_control_de_la_consulta: "1179250939"
               },
               hawk_inquiry: %{},
               hawk_response: [
                 %{
                   codigo_de_la_prevencion: "002",
                   fecha_de_reporte: ~D[2018-09-26],
                   mensaje: "NO EXISTE INFORMACION",
                   tipo_de_usuario: "BURO DE CREDITO "
                 }
               ],
               persona: %{
                 apellido_materno: "MAZA",
                 apellido_paterno: "URBANO",
                 curp: "UAMH880216HPLRZC09",
                 estado_civil: "S",
                 fecha_de_nacimiento: ~D[1988-02-16],
                 genero: "M",
                 nacionalidad: "MX",
                 primer_nombre: "HECTOR",
                 rfc: "UAMH880216S19",
                 tipo_de_residencia: "1"
               },
               resumen: %{
                 number_of_accounts_with_MOP_03: 0,
                 porcentaje_del_limite_de_credito_utilizado_para_cuentas_revolventes: 6.0,
                 numero_de_cuentas_con_MOP_96: 0,
                 numero_de_cuentas: 15,
                 numero_de_cuentas_con_MOP_00: 0,
                 numero_de_solicitudes_de_consulta: 2,
                 numero_de_cuentas_con_MOP_06: 0,
                 total_de_limites_de_credito_para_cuentas_revolventes: 1.062e5,
                 fecha_de_apertura_de_cuenta_mas_antigua: ~D[2009-10-27],
                 mensaje_de_alerta: "NNNNN",
                 numero_de_cuentas_con_MOP_05: 0,
                 numero_de_cuentas_con_MOP_02: 0,
                 total_de_creditos_maximos_para_cuentas_revolventes: 60_825.0,
                 declarativa: "N",
                 total_de_saldos_actuales_para_cuentas_de_pagos_fijos_e_hipotecarios: 0.0,
                 numero_de_cuentas_con_MOP_UR: 3,
                 numero_de_cuentas_con_MOP_97: 0,
                 fecha_de_la_consulta_mas_reciente_realizada_por_un_despacho_de_cobranza: nil,
                 total_de_saldos_vencidos_para_cuentas_revolventes: 0.0,
                 numero_de_cuentas_revolventes_y_sin_limite_establecido: 10,
                 fecha_de_apertura_de_cuenta_mas_reciente: ~D[2015-09-05],
                 total_de_importe_de_pago_para_cuentas_revolventes: 1590.0,
                 total_de_creditos_maximos_para_cuentas_de_pagos_fijos_e_hipotecarios: 0,
                 moneda_del_credito: "MX",
                 numero_de_cuentas_con_MOP_07: 0,
                 numero_de_solicitudes_del_informe_buro_realizadas_por_despachos_de_cobranza: 0,
                 numero_de_cuentas_con_morosidad_actual: 0,
                 total_de_saldos_actuales_para_cuentas_revolventes: 7174.0,
                 fecha_de_la_consulta_mas_reciente: ~D[2016-05-19],
                 total_de_importe_de_pago_para_cuentas_de_pagos_fijos_e_hipotecarios: 0,
                 numero_de_cuentas_con_MOP_03: 0,
                 numero_de_solicitudes_de_informe_de_buro: 13,
                 numero_de_cuentas_en_despacho_de_cobranza: 0,
                 numero_de_cuentas_en_aclaracion: 0,
                 numero_de_cuentas_de_pagos_fijos_e_hipotecario: 5,
                 nueva_direccion_en_los_ultimos_60_dias: "N",
                 numero_de_cuentas_cerradas: 6,
                 numero_de_cuentas_con_MOP_01: 12,
                 numero_de_cuentas_con_MOP_98: 0,
                 numero_de_cuentas_con_historial_de_morosidad_actual: 0,
                 fecha_de_integracion: ~D[2009-11-06],
                 total_de_saldos_vencidos_para_cuentas_de_pagos_fijos_e_hipotecarios: 0,
                 fecha_de_apertura_mas_reciente_de_una_cuenta_en_despacho_de_cobranza: nil
               },
               score: %{
                 codigo_del_score: "007",
                 nombre_del_score: "BC SCORE",
                 primer_codigo_de_razon: "Consulta reciente",
                 valor_del_score: 725
               }
             }
  end

  test "parse failed response" do
    {:error, response} = process_response(@error_response)

    assert response ==
      [
        error_en_el_sistema_de_buro_de_credito: "Y",
        numero_de_referencia_del_operador: "                         "
      ]
  end

  test "match section value" do
    string = "PN05Perez0005LopezPA123"

    assert match_section(string, "PN", ["PN", "PA"]) ==
             {%{
                apellido_materno: "Lopez",
                apellido_paterno: "Perez"
              }, "PA123"}
  end

  test "match inquiry HWK section" do
    string = "HI083105201500035200116SERV. PUB. SANC.0219003-24052015- - -0-"

    assert match_section(string, "HI", ["HI", "HR"]) ==
             {%{
                codigo_de_la_prevencion: "520",
                fecha_de_reporte: ~D[2015-05-31],
                mensaje: "003-24052015- - -0-",
                tipo_de_usuario: "SERV. PUB. SANC."
              }, ""}
  end

  test "match response HWK section" do
    string = "HR081112201500035400116SERV. PUB. SANC.02335006-15072015-16072015-12012017-5"

    assert match_section(string, "HR", ["HR"]) ==
             {%{
                tipo_de_usuario: "SERV. PUB. SANC.",
                codigo_de_la_prevencion: "540",
                fecha_de_reporte: ~D[2015-12-11],
                mensaje: "5006-15072015-16072015-12012017-5"
              }, ""}
  end

  test "Extraer varias declarativas del cliente" do
    string =
      "CR0402700000ESTA ES UNA DECLARATIVA DE PRUEBA##CREDITO01 POR CADA CREDITO EL CONSUMIDOR PUEDE MANIFESTAR SU INCONFORMIDAD##CREDITO02 CADA DECLARATIVA PUEDE CONTENER HASTA MIL PALABRAS##CREDITO03 LAS DECLARATIVAS SE DESPLEGARAN DE ACUERDO CON LA SECUENCIA DE LOS CREDITOS"

    assert match_section(string, "CR", ["CR"]) ==
             {%{
                declarativa: [
                  {"Expediente", "ESTA ES UNA DECLARATIVA DE PRUEBA"},
                  {"01", " POR CADA CREDITO EL CONSUMIDOR PUEDE MANIFESTAR SU INCONFORMIDAD"},
                  {"02", " CADA DECLARATIVA PUEDE CONTENER HASTA MIL PALABRAS"},
                  {"03",
                   " LAS DECLARATIVAS SE DESPLEGARAN DE ACUERDO CON LA SECUENCIA DE LOS CREDITOS"}
                ],
                tipo_de_segmento: "0270"
              }, ""}
  end

  test "match multiple section values" do
    string = "PN06URBANO0004MAZA0206HECTOR0408160219880513UAMH880216S190802MX"

    assert match_section(string, "PN", ["PN"]) ==
             {%{
                rfc: "UAMH880216S19",
                apellido_materno: "MAZA",
                apellido_paterno: "URBANO",
                fecha_de_nacimiento: ~D[1988-02-16],
                nacionalidad: "MX",
                primer_nombre: "HECTOR"
              }, ""}
  end

  test "parse multiple sintetiza features" do
    string = "CL02150001101019020523432CL021500011010210020820100203"

    assert match_section(string, "CL", ["CL"]) ==
             {[
                %{
                  identificador_de_caracteristica_de_plantilla: "1",
                  numero_de_caracteristica: 9,
                  plantilla_solicitada: "15",
                  valor_de_la_caracteristica: "23432"
                },
                %{
                  identificador_de_caracteristica_de_plantilla: "1",
                  numero_de_caracteristica: 10,
                  plantilla_solicitada: "15",
                  valor_de_la_caracteristica: "20100203"
                }
              ], ""}
  end
end
