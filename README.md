# Burox

Este es una biblioteca para facilitar el uso de servicios y obtención de información del Buró de Crédito 

**¿Qué es el Buró de Crédito?**

[Buró de Crédito](https://www.burodecredito.com.mx/)  
Es una compañía mexicana dedicada a proporcionar servicios sobre recopilación, manejo y entrega o envío de información relativa al historial crediticio de personas físicas y morales, así como operaciones de crediticias y otras de naturaleza análoga que dichas personas mantengan con Entidades Financieras (Bancos, Uniones de Crédito, Sociedades de Ahorro y Préstamo, etc.) así como con Empresas Comerciales (Tiendas departamentales) y Sofomes, E.N.R.. 

## Instalación

Si [esta disponible en Hex](https://hex.pm/docs/publish), el paquete puede ser instalado  añadiendo
`burox` a tu lista de dependencias en el `mix.exs` de tu proyecto:

```elixir
def deps do
  [
    {:burox, "~> 0.3.0"}
  ]
end
```

## Uso

### Configuración

Añade las llaves que te proporciono el buró  a tu archivo `config.exs`:

```elixir

config :burox,
  buro_url: "BURO_HOST",
  buro_user: "YPUR-BURO-USER",
  buro_password: "YOUR-BURO-PASSWORD",
  buro_service: Burox.BuroService.Socket

```

Al momento de la publicación, el Buró solo soporta el servicio de prospector en la versión 11.  
Si necesitas usar `prospector`, añade los siguiente:

```elixir
  buro_url_prospector: "PROSPECTOR-HOST",
  buro_user_prospector: "YOUR-PROSPECTOR-USER",
  buro_password_prospector: "YOUR-PROSPECTOR-PASSWORD"
```

### Petición

La petición debe ser una estructura del tipo **`%Burox.Request`**.  
También puede mandarse el módulo de autenticación.

```elixir

%Burox.Request{
    autenticacion: %{
      cuenta_con_tarjeta_de_credito: "V",
      ultimos_cuatro_digitos: "4761",
      ha_ejercido_un_credito_hipotecario: "F",
      ha_ejercido_un_credito_automotriz_en_los_ultimos_24_meses: "F"
    },
    persona: %{
      apellido_paterno: "CABRERA",
      apellido_materno: "RODRIGUEZ",
      primer_nombre: "ADRIANA",
      rfc: "CARA8105144V1"
    },
    direccion: %{
      primera_linea_de_direccion: "CUMBRES MZ 15 28",
      colonia: "PRADERAS DE  SAN MATEO",
      municipio: "NAUCALPAN",
      ciudad: "NAUCALPAN DE Juarez",
      estado: "EM",
      codigo_postal: "53228",
      origen_del_domicilio: "MX"
    }
  }

```

**Nota:** En el caso del código del Estado, se le puede mandar el nombre y la biblioteca se encarga de cambiarlo por el código que recibe el Buró, i.e

```elixir
 "Estado de México"

```

se convierte a:

```elixir
 "EM"

```

### Enviar petición al Buró

Para solicitar la información, se usa la función **`Burox.solicitar`** 

Esta recibe la petición y el tipo de prpducto que se requiere, por default, es el "507" (Informe de Crédito)


```elixir
Burox.solicitar(request, "507") 
```

Para otros tipos de productos, refiérase a la documentación que le proporcione Buró de Crédito


### Respuesta del Buró

La respuesta es una estructura del tipo  **`%Burox.Response`**

```elixir
%Burox.Response{
                     score: %{
                       codigo_del_score: "007",
                       nombre_del_score: "BC SCORE",
                       valor_del_score: -9,
                       valor_de_exclusion: "Expediente sin cuentas para cálculo de BC-Score"
                     },
                     direcciones: [
                       %{
                         ciudad: "TLAJOMULCO DE ZUNIGA",
                         codigo_postal: "45654",
                         colonia: "VILLAS DE LA HACIENDA",
                         estado: "JAL",
                         fecha_de_reporte_de_la_direccion: ~D[2016-07-18],
                         municipio: "TLAJOMULCO DE ZUNIGA",
                         origen_del_domicilio: "MX",
                         primera_linea_de_direccion: "HUERTA 1"
                       }
                     ],
                     consultas: [
                       %{
                         clave_del_usuario: "Usuario123",
                         fecha_de_consulta: ~D[2016-07-18],
                         importe_del_credito: "0",
                         indicador_de_cliente_nuevo: "Y",
                         nombre_del_usuario: "RESUELVE",
                         numero_telefonico_del_usuario: "5586479602",
                         reserved: "0",
                         tipo_de_producto: "CC",
                         tipo_de_responsabilidad_de_la_cuenta: "I"
                       },
                       %{
                         clave_del_usuario: "Usuario123",
                         fecha_de_consulta: ~D[2016-07-18],
                         importe_del_credito: "000000000",
                         indicador_de_cliente_nuevo: "Y",
                         moneda_del_credito: "MX",
                         nombre_del_usuario: "BURO DE CREDITO",
                         numero_telefonico_del_usuario: "5586479602",
                         reserved: "1",
                         tipo_de_producto: "CC",
                         tipo_de_responsabilidad_de_la_cuenta: "I"
                       }
                     ],
                     creditos: [],
                     declarativa_consumidor: %{},
                     direcciones: [
                       %{
                         ciudad: "TLAJOMULCO DE ZUNIGA",
                         codigo_postal: "45654",
                         colonia: "VILLAS DE LA HACIENDA",
                         estado: "JAL",
                         fecha_de_reporte_de_la_direccion: ~D[2016-07-18],
                         municipio: "TLAJOMULCO DE ZUNIGA",
                         origen_del_domicilio: "MX",
                         primera_linea_de_direccion: "HUERTA 1"
                       }
                       
                       ...

```


## Licencia

The MIT License (MIT)

Copyright (c) 2018 [Resuelve](https://github.com/resuelve)
