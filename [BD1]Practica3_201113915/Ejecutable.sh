
#CREANDO LA TABLA TEMPORAL
echo exit | psql -U victorsdb -h 127.0.0.1 -d practica3 -f [BD1]ScriptTT_201113915.sql
echo "\e[92mSE CARGARON LOS DATOS A LA TABLA TEMPORAL. ENTER PARA CONTINUAR... \e[0m"
read leer

#CREANDO LA TABLA TEMPORAL
echo exit | psql -U victorsdb -h 127.0.0.1 -d practica3 -f [BD1]ScriptMR_201113915.sql
echo "\e[92mSE CARGARON LOS DATOS A LA BASE DE DATOS. ENTER PARA CONTINUAR... \e[0m"
read leer

#CREANDO LA TABLA TEMPORAL
echo exit | psql -U victorsdb -h 127.0.0.1 -d practica3 -f [BD1]ScriptMR_201113915.sql
echo "\e[92mSE MOSTRARON LOS CONTEOS DE LAS TABLAS EN LA BASE DE DATOS. ENTER PARA CONTINUAR... \e[0m"
read leer