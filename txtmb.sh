#!/bin/bash

# TXTMB: txtMicroBlog 
# Ver 0.1
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

# Título del txtmicroblog. Aparece después del banner de inicio. 
TITULO="EL TÍTULO DE TU TXTMB"

# Nombre del autor como aparece en la cabecera después de "Autor: "
AUTOR="TU NOMBRE"

# Descripción del microblog
DESCRIPCION="DE QUÉ TRATA"

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
DELIMITADOR="-------------"


# OTRAS CONFIGURACIONES

# La alerta de caracteres indica el tamaño máximo de las entradas. Si las entradas que escribas son más largas que este número, se mostrará una alerta que te permitirá continuar (aunque sea más larga de lo usual) o salvar el texto y salir.
ALERTA_CARACTERES=300

# Ajuste de línea. Indíca dónde es que se deben de cortar las líneas demasiado largas en el txMicroBlog. Las líneas siempre se cortan en los espacios, por lo que no quedará ninguna palabra "mutilada". Los valores muy cortos pueden echar a perder la cabecera o las entradas.
T_AJUSTE=70

# Indica el NÚMERO DE LÍNEA del archivo en la cual se agregarán las nuevas entradas que se escriban. Si se modifica la cabecera del archivo, es importante modificar este valor para indicar dónde iniciará de nuevo el feed.
LINEA_INICIO=18

# Acción predeterminada. Al terminar de escribir tu entrada, el script te preguntará si quieres que realice una acción predterminada. Esto es útil para actualizar el blog y subirlo a un servidor por medio de scp o para copiarlo a alguna carpeta. Cambia el comando que sigue.
# Modifica con la variable $tb para el nombre de tu TXTMB actual.
function ACCION(){
#### Cambia esto
#scp $tb daniel@servidor:/dir/servidor/$tb
echo "No hay acción predeterminada"
####
return
}

#####################################3
# Aquí inicia el programa

set -o errexit
set -o nounset
set -o pipefail

# Funciones de salida
function QUIT(){
echo "..."
echo "Bueno, pues. ¿Quién te entiende?"
echo -e "\e[34m[Saliendo de txtMicroBlog]\e[0m"
echo -e "\e[95mBye!\e[0m"
exit
}

function MAL(){
echo "..."
echo "Dije 'sí' o 'no'. Esa no es una respuesta válida."
echo -e "\e[34m[Saliendo de txtMicroBlog]\e[0m"
echo -e "\e[95mBye!\e[0m"
exit
}


# La "ayuda" con las flags de uso.
function USO() {
clear
echo " "
echo -e "\e[46;1;37m[ TXTMB -- txtMicroBlog V. 0.1 ]\e[0m" 
echo -e "\e[96mDaniel M. Olivera -- https://lenguajeprivado.com\e[0m" 
cat <<USO

    Descripción: Genera archivos de texto y entradas en los archivos de texto en orden cronológico. Puede ser usado como un microblog simple en formato .txt para subirlo en un servidor o para guardar notas rápidas en texto plano.

    Uso:                $0 [-N nombre] [-p texto.txt] [-h ]

    Opciones:
    
        -N nombre    :  Genera un nuevo txt para ser preconfigurado como txtMicroBlog.
        -p texto.txt :  Agrega una nueva entrada al txtMicroBlog preexistene. 
                        Cuidado con conservar la extensión ".txt".
        -h           :  Muestra este mensaje


USO
    exit
}


# Esta es la función que crea un nuevo txtMicroBlog

function nuevo(){
clear
echo " "
echo -e "\e[46;1;37m[ TXTMB -- txtMicroBlog V. 0.1 ]\e[0m" 
echo -e "\e[96mDaniel M. Olivera -- https://lenguajeprivado.com\e[0m" 
echo " "
echo -e "\e[1;92mCREACIÓN DE NUEVO txtMicroBlog\e[0m"   
read -p "¿Quieres crear un nuevo txtblog llamado '$ntexto.txt'? (s/n): " sn
case $sn in
[sS] )
if test -f "$ntexto.txt"; then
   echo -e "\e[41mPRECAUCIÓN\e[0m: '$ntexto.txt' ya existe. Elimina este archivo antes de continuar."
   echo -e "\e[34m[Saliendo de txtMicroBlog]\e[0m"
   echo -e "\e[95mBye!\e[0m"
   exit
fi

cat << EOF > $ntexto.txt
[TXTMB] 
txtMicroBlog V. 0.1

     
❱  LENGUAJE PRIVADO

$DESCRIPCION

    Autor: $AUTOR
    Creación: $(date +%D)
    $DATO1
    $DATO2

Creado con txtMicroBlog:
https://github.com/lenguajeprivado/txtMicroBlog
###################




☠

EOF
echo " "
echo "================================="
head -n 30 $ntexto.txt
echo "================================="
echo " "
echo -e ">>    \e[42mEl nuevo txtMicroBlog llamado '$ntexto.txt' ha sido creado.\e[0m"
echo " "
echo -e "\e[34m[Saliendo de txtMicroBlog]\e[0m"
echo -e "\e[95mBye!\e[0m"
exit;;

[nN] )
QUIT
exit;;

*)
echo -e "\e[35m¡¿Qué demonios es esa letra?!.\e[0m Escribe UNICAMENTE's' o 'n' (y nada más)."
sleep 2
nuevo
exit 1;;
esac
}


# Esta es la función que crea los posts al inicio del feed.
# Toda la magia la hace "sed".
function post(){
clear
echo " "
echo -e "\e[46;1;37m[ txtMicroBlog V. 0.1 ]\e[0m" 
echo -e "\e[92mDaniel M. Olivera -- https://lenguajeprivado.com\e[0m" 
echo " "
echo -e "\e[1;92mCreación de nueva entrada en\e[0m: \e[45m'$tb'\e[0m."   
echo " "
read -p "¿Quieres escribir una nueva entrada en el txtblog llamado '$tb'? (s/n): " sn
case $sn in
[sS] )
if [ ! -f "$tb" ]; then
   echo -e "\e[41mPRECAUCIÓN\e[0m: $tb no existe. Revisa que el nombre esté bien escrito (con la extensión '.txt') y el archivo exista."
   exit
fi
if [ -d "$tb" ]; then
   echo -e "\e[41mPRECAUCIÓN\e[0m: $tb es un directorio, no un archivo. Ponte vergas."
   exit
fi

echo " "
echo -e "\e[1;92mCopia de respaldo de\e[0m: \e[45m'$tb'\e[0m."
echo "Te recomiendo, antes de hacer cualquier cambio, hacer una copia de resplado de tu archivo por si algo sale mal. Especialmente hazlo si planear usar la opción de 'Ajuste de línea' al terminar de escribir tu entrada."
echo " "
read -p "¿Quieres crear una copia de respaldo antes de continuar? (s/n):  " resp
case $resp in
        [sS] )
            echo " "
            respaldo="$RANDOM-$(date +%F)-bak-$tb"
            cat $tb > $respaldo
            echo -e "\e[92mCopia de respaldo creada en:\e[0m '$respaldo'."
            ;;
        [nN] )
            echo "ok!"
            ;;
        *)
            MAL
            ;;
esac

echo " "
echo -e "\e[42mEscribe tu entrada: \e[0m"
echo " " 
read -p "txtmb> " texto

if [ ${#texto} -gt 300 ];then
    echo -e "\e[41mPRECAUCIÓN\e[0m:"
    echo -e "\e[33mEl texto muy largo. Contiene ${#texto} caracteres. La alerta de caracteres está fijada para menos de $ALERTA_CARACTERES caracteres.\e[0m"
    read -p "¿Deseas continuar a pesar de lo largo que es el texto? (s/n): " continuar
    case $continuar in
    [sS])
        echo "ok!"
        ;;
    [nN])
        sav="salvado$RANDOM"
        echo $texto > $sav.txt
        echo -e "    \e[105mTexto salvado en el archivo $sav.txt\e[0m" 
        exit
        ;;
    *)
        MAL
        ;;
    esac
fi
clear
echo " "
echo "========================"
ahora=$(date "$FECHA")
PIE="\n>  $NOMBRE@$TCORTO\n$ahora\n$DELIMITADOR\n\n"
sed -i "$LINEA_INICIO a $texto $PIE" $tb
head -n 30 $tb
echo "========================"
echo " "
echo -e "\e[1;42mEntrada creada en $tb !\e[0m"
echo " "
echo " "
echo -e "\e[1;92mAjuste de línea de\e[0m: \e[45m'$tb'\e[0m."
echo "El ajuste de línea corta TODAS las entradas para que sean más legibles. Recorta las líneas largas colocándolas en una nueva línea. Esto puede afectar a todo el texto y romper tu txtMicroBlog. Hazlo solo si hiciste una copia de respaldo antes. Puedes cambiar el tamaño del ajuste de línea en las configuraciones."
echo " "
read -p "¿Quieres ajustar la línea de texto? (s/n):  " linea

    case $linea in
    [sS] )
        fold -sw $T_AJUSTE $tb > temporal
        mv temporal $tb
        clear
        echo " "
        echo "==============================="
        head -n 30 $tb
        echo "==============================="
        echo " "
        echo -e "\e[1;42mAjuste de línea realizado en $tb !\e[0m"
        ;;
    [nN] )
        echo "No: ok!"
        ;;
    *)
        MAL
        exit
        ;;
    esac

echo " "
echo " "
echo -e "\e[1;92mAcción posterior para\e[0m: \e[45m'$tb'\e[0m."
echo "Si está configurada, se pude realizar una acción (como subir al servidor el txt, con scp, por ejemplo)."
read -p "¿Quiéres realizar la acción posterior preconfigurada? (s/n):  " accion
    case $accion in
    [sS] )
        ACCION
        echo -e "\e[1;42mAcción ejecutada.\e[0m"
        echo "Sin embargo, verifica que se haya realizado correctamente."
        echo " "
        ;;
    [nN] )
        echo "No: ok!"
        ;;
    *)
        MAL
        exit
        ;;
    esac

echo " "
echo -e "\e[34m[Saliendo de txtMicroBlog]\e[0m"
echo -e "\e[95mBye!\e[0m"
sleep 1
exit;;

[nN] )
QUIT
exit;;

*)
echo -e "\e[35m¡¿Qué demonios es esa letra?!.\e[0m Escribe UNICAMENTE's' o 'n' (y nada más)."
sleep 2
post
exit;;
esac
}

# Asignación de las flags.

if [ $# -eq 0 ]; then
    USO
    exit 0
fi

while getopts ':N:p:h' OPTION; do
  case "$OPTION" in
    N)
      ntexto=${OPTARG}
      nuevo
      ;;
    p)
      tb=${OPTARG}
      post
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
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
