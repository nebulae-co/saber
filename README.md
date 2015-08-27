# saber

**saber** es un paquete de datos de R con la información de las pruebas Saber.
Las pruebas Saber son pruebas estandarizadas llevadas a cabo por el
[ICFES (Instituto Colombiano para la Evaluación de la Educación)](http://www.icfes.gov.co/)
y son utilizadas por el gobierno (a través del Ministerio de Educación y el
ICFES) para evaluar la calidad de la educación. Los datos estan disponibles
para investigadores interesados a través del
[ICFES](http://www.icfes.gov.co/investigacion/acceso-a-bases-de-datos), pero
los hemos hecho de fácil acceso para usuarios de R en este paquete.

*Actualmente solo contiene datos de las pruebas Saber 11 desde 2005.*


## Instalación

Para instalarlo es necesario tener [`devtools`](https://github.com/hadley/devtools) instalado:

```r
    install.packages("devtools")
    devtools::install_github("nebulae-co/saber")
```

Nota: la instalación del paquete puede tardar un poco ya que implica la
descarga de los archivos con los datos.

## Uso

Una vez instalado se puede cargar para tener acceso a los `data.frame`s con
`data()` como se describe a continuación (y en la ayuda del paquete `?saber`).

Cada conjunto de datos se llama con el prefijo `SB11_` seguido por el año
(YYYY) y el periodo (1 o 2):

```r
    # Cargamos el paquete:
    library("saber")

    # Cargamos los datos de la prueba 2005-1
    data(SB11_20051)

    # head(SB11_20051)
    # class(SB11_20051)
```

Nota: los datos fueron llevados a R con [`readr`](https://github.com/hadley/readr)
así que preservan las clases `tbl_df` y `tbl` además de `data.frame` para un 
mejor desempeño con [`dplyr`](https://github.com/hadley/dplyr).

## Saber 11

Las pruebas Saber 11 son pruebas estandarizadas requeridas a todos los
estudiantes de Bachillerato para obtener el título de Bachiller y son
utilizadas por el gobierno para medir la calidad de la Educación secundaria y
por universidades para la admisión a programas de educación superior y acceso
a becas.

Las pruebas se realizan dos veces al año para acomodarse a cada calendario
escolar. Hay un conjunto de datos por cada prueba aplicada desde 2005 que
contiene los resultados de las pruebas e información socio-económica de cada
estudiante que tomó la prueba durante el periodo dado.

En el futuro, buscaremos incluir los datos de las pruebas Saber PRO y otras y
posiblemente un solo conjunto de datos estandarizado para todos los años. De
igual manera esperamos documentar las variables de manera compacta.
