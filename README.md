# Control N°3 - Laboratorio de Taller de Base de Datos
Este repositorio contiene todos los archivos relacionados con el Control N°3 del
laboratorio de Taller de Base de Datos (Base de Datos Avanzadas 13317) desarrollado
por el equipo 5. 

## Integrantes del equipo 5
* [Vanina Correa](https://github.com/Vanina11)
* [Nícolas Farfán](https://github.com/nic0q)
* [Vicente Muñoz](https://github.com/LeVixo)
* [Xavier Muñoz](https://github.com/iChavy)
* [John Serrano](https://github.com/PodssilDev)
* [Nicolas Venegas](https://github.com/nicovenegas2)

## Descripción
El repositorio contiene dos archivos principales:
* [tbd_sig.backup](https://github.com/nic0q/TBD-Control-3/blob/master/tbd_sig.backup): Archivo proporcionado para el control, que contiene un backup de 
la Base de Datos y las dos tablas a utilizar. Las tablas incluidas son, en primer lugar, **minimarkets_gs**, la cual es una tabla de los minimarkets del Gran Santiago
y en segundo lugar, **zonas_censales_gs**, la cual es una tabla correspondiente a la capa espacial de las zonas censales del Gran Santiago.
* [querys.sql](https://github.com/nic0q/TBD-Control-3/blob/master/querys.sql): Archivo que contiene las querys solicitadas para el control, las cuales crean
dos nuevas tablas: **zc_500m** y **comunas_ptje_mini**

## Requisitos y herramientas de desarrollo
Para ejecutar correctamente todo el script **querys.sql**, además de los archivos del repositorio se requieren las siguientes tecnologías:

* [Postgres SQL](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads) versión 12 o superior. 
* [PgAdmin](https://www.pgadmin.org) versión 4.
* [PostGis](https://postgis.net) versión 3.2 o superior

También, para el desarrollo del Control se utilizó:
* [Visual Studio Code](https://code.visualstudio.com) versión 1.73
* [GitKraken](https://www.gitkraken.com) versión 8.10.3

## Como ejecutar
* 1). En PgAdmin, crear una Base de Datos, haciendo click derecho en "Databases" y luego "Create". No importa el nombre de la Base de Datos.
* 2). Con la Base de Datos ya creada, hacer click derecho en ella y seleccionar la opción "Restore". Se debe utilizar el archivo **tbd_sig.backup** para restaurar la Base de Datos
* 3). Luego, click derecho en la Base de Datos y seleccionar la opción "Query Tool". Copiar la primera query del archivo **querys.sql** y ejecutarlo.
* 4). Repetir el paso 3 para la segunda query.
