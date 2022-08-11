#!/bin/bash

# TXTMB: txtMicroBlog 
# Ver 0.3
# Daniel M. Olivera
# https://lenguajeprivado.com
#
# Descripción: Genera archivos de texto y entradas
# en los archivos de texto en orden cronológico.
# Puede ser usado como un microblog simple en formato
# .txt para subirlo en un servidor o para guardar notas
# rápidas en texto plano.


# CONFIGURACIONES

#Cabecera

# Título del TXTMB. Aparece después del banner de inicio. 
TITULO="TÍTULO DEL TXTMB"

# Nombre del autor como aparece en la cabecera después de "Autor: "
AUTOR="AUTOR DEL TXTMB"

# Descripción del TXTMB
DESCRIPCION="DESCRIPCIÓN DEL TXTMB"

# Un par de datos que el autor quiera agregar a la cabecera.
# En caso de no usarlos, lo mejor es dejar un espacio en blanco
# o revisar el valor "LINEA_INICIO" para que los posts inicien
# en el lugar que les corresponde
DATO1="Twitter: @lenguajeprivado"
DATO2="Web: https://lenguajeprivado.com"

# Entradas

# Nombre corto o nick del autor, y título corto del blog
# para que aparezcan en el pie de cada entrada de la forma
# NOMBRE@TCORTO. En esta configuración produce, al pie de
# cada entrada, "daniel@lenguajeprivado"
NOMBRE="daniel"
TCORTO="lenguajeprivado"

# Formato de fecha. La fecha se crea con el comando "date".
# Si se requieren otros formatos, se puede consultar "man date".
# +%c : dia DD mes AAAA HH:MM:SS
# +%D : MM/DD/AA
# +%F : AAAA/MM/DD
# +[%H:%M] - %a %d de %B de %Y : [HH:MM] día DD de MM de AAAA
FECHA="+[%H:%M] -> %a %d de %B de %Y."

# Delimitador de entradas. La línea que aparece al final de cada
#entrada para marcar que ha finalizado
DELIMITADOR="---------------"


# OTRAS CONFIGURACIONES

# La alerta de caracteres indica el tamaño máximo de las entradas. 
# Si las entradas que escribas son más largas que este número, se 
# mostrará una alerta que te permitirá continuar (aunque sea más 
# larga de lo usual) o salvar el texto y salir.
ALERTA_CARACTERES=300

# Ajuste de línea. Indíca dónde es que se deben de cortar las líneas demasiado largas en el txMicroBlog. Las líneas siempre se cortan en los espacios, por lo que no quedará ninguna palabra "mutilada". Los valores muy cortos pueden echar a perder la cabecera o las entradas.
T_AJUSTE=70

# Indica el NÚMERO DE LÍNEA del archivo en la cual se agregarán las nuevas entradas que se escriban. Si se modifica la cabecera del archivo, es importante modificar este valor para indicar dónde iniciará de nuevo el feed.
LINEA_INICIO=15

# Acción predeterminada. Al terminar de escribir tu entrada, el script te preguntará si quieres que realice una acción predterminada. Esto es útil para actualizar el blog y subirlo a un servidor por medio de scp o para copiarlo a alguna carpeta. Cambia el comando que sigue.
# Modifica con la variable $tb para el nombre de tu TXTMB actual.
function accion(){
#### Cambia esto
# Puedes poner, por ejemplo:
# scp $txtmb daniel@6.6.6:/directorio/del/servidor/miblog.txt
echo "No se ha ajustado una acción predeterminada."
####
}

#####################################3
# Aquí inicia el programa

set -o errexit
set -o nounset
set -o pipefail


# La "ayuda" con las flags de uso.
function USO() {
echo -e "\e[96mDaniel M. Olivera -- https://lenguajeprivado.com\e[0m" 
cat <<USO
  Descripción: Genera archivos de texto y entradas en los archivos de texto en orden cronológico. Puede ser usado como un microblog simple en formato .txt para subirlo en un servidor o para guardar notas rápidas en texto plano.

  Uso:                
    ./txtmb.sh [-X nombre]
    ./txtmb.sh -n <archivo>.txt [-b] [-p "<nueva entrada>"] [-a] [-d]
    ./txtmb.sh [-h]

  Opciones:
    -X nombre    : Genera un nuevo .txt para ser preconfigurado como TXTMB.

    -n <.txt>    : Llama al archivo de texto plano TXTMB para trabajar en él. 
    -p "<post>"  : El texto de la nueva entrada que se escribirá en el TXTMB.
    -b           : Crea una copia de respaldo (.bak).
    -a           : Ajuste de línea en el TXTMB.
    -d           : Llama a la acción posterior (previamente fijada).
    -h           : Muestra este mensaje

  Ejemplos:

    ./txtmb.sh -X prueba
    > Crea un nuevo TXTMB llamado "prueba.txt".

    ./txtmb.sh -n prueba.txt -p "Esta es una nueva entrada"
    > Crea una nueva entrada en el TXTMB llamado "prueba.txt"

    ./txtmb.sh -n prueba.txt -b -p "Esta es una nueva entrada"
    > Crea una copia de respaldo y una nueva entrada en el TXTMB llamado "prueba.txt"

    ./txtmb.sh -n prueba.txt -b -p "Esta es una nueva entrada" -a
    > Crea una copia de respaldo, una nueva entrada en el TXTMB llamado "prueba.txt" y ajusta la línea

Las configuraciones posibles se encuentran al inicio del script.

Bye!
USO
    exit
}


function nuevo(){
    if test -f "$ntexto.txt"; then
        echo -e "\e[41mPRECAUCIÓN: '$ntexto.txt' ya existe. Elimina este archivo antes de continuar.\e[0m"
        echo -e "\e[95mBye!\e[0m"
        exit
    fi

cat << EOF > $ntexto.txt
[TXTMB] 
     
❱  LENGUAJE PRIVADO

$DESCRIPCION

    Autor: $AUTOR
    Creación: $(date +%D)
    $DATO1
    $DATO2


---------------


---------------
Creado con txtMicroBlog V. 0.3
https://github.com/lenguajeprivado/txtMicroBlog
EOF
echo -e "\e[1;32mEl nuevo txtMicroBlog llamado '$ntexto.txt' ha sido creado.\e[0m"
echo -e "\e[95mBye!\e[0m"
exit
}

function check() {
if [ ! -f "$txtmb" ]; then
   echo -e "\e[41mPRECAUCIÓN\e[0m: '$txtmb' no existe!"
   echo "Revisa que el nombre esté bien escrito (con la extensión '.txt') y el archivo exista."
   echo -e "\e[95mBye!\e[0m"
   exit
fi

tipo=$(file -i $txtmb | cut -d' ' -f2)
if [ $tipo != "text/plain;" ]; then
   echo -e "\e[41mPRECAUCIÓN\e[0m: '$txtmb' no es un archivo .txt!"
   echo -e "\e[95mBye!\e[0m"
   exit
fi
}

function checkarchivo() {
if [ -z ${txtmb+x} ]; then 
   echo -e "\e[41mPRECAUCIÓN\e[0m: No se ha establecido el archivo TXTMB. Usa '-n nombrearchivo.txt'."
   echo -e "\e[95mBye!\e[0m"
   exit
fi
}

function backup() {
    checkarchivo
    respaldo="$RANDOM-$(date +%F).bak"
    cp $txtmb $respaldo
    echo -e "\e[1;32mCopia de respaldo creada:\e[0m '$respaldo'."    
}

function checkpost() {
    if [ ${#entrada} -gt $ALERTA_CARACTERES ];then
        echo -e "\e[1;43mADVERTENCIA: \e[0m El texto muy largo. Contiene ${#entrada} caracteres. La alerta de caracteres está fijada para menos de $ALERTA_CARACTERES caracteres."
        read -p "¿Deseas continuar? [s/n]: " continuar
        case $continuar in
        [sS])
            echo "Ok!!!!"
            ;;
        [nN])
            sav="salvado-$RANDOM.txt"
            echo $entrada > $sav
            echo -e "\e[1;32mTexto salvado en el archivo '$sav' \e[0m."
            echo -e "\e[95mBye!\e[0m"
            exit
            ;;
        *)
            echo -e "\e[1;41mOpción no válida.\e[0m"
            checkpost
            ;;
        esac
    fi
}

function post() {
    checkarchivo
    checkpost
    ahora=$(date "$FECHA")
    PIE="\n>  $NOMBRE@$TCORTO\n$ahora\n$DELIMITADOR\n\n"
    sed -i "$LINEA_INICIO a $entrada $PIE" $txtmb
    echo -e "\e[1;32mEntrada creada en '$txtmb'.\e[0m"
}

function ajustelin() {
    checkarchivo
    fold -sw $T_AJUSTE $txtmb > temporal
    mv temporal $txtmb
    echo -e "\e[1;32mAjuste de línea realizado en '$txtmb'.\e[0m"
}

##################

if [ $# -eq 0 ]; then
    USO
    exit 0
fi

echo -e "\e[1;96m[ TXTMB -- txtMicroBlog V. 0.3 ]\e[0m\n" 

while getopts ':X:n:bp:adh' OPTION; do
  case "$OPTION" in
    X)
      ntexto=${OPTARG}
      nuevo
      exit
      ;;
    n)
      txtmb=${OPTARG}
      check
      ;;
    b)
      backup
      ;;
    p)
      entrada=${OPTARG}
      post
      ;;
    a)
      ajustelin
      ;;
    d)
      accion
      echo -e "\e[1;32mAcción ejecutada.\e[0m Sin embargo, verifica que se haya realizado correctamente."
      ;;
    h)
      USO
      exit 1
      ;;
    *)
      USO
      exit 1
      ;;
    ?)
      USO
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
exit

