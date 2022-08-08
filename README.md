# txtMicroBlog [TXTMB]

** txtMicroBlog [TXTMB]** genera archivos de texto y entradas en los archivos de texto en orden cronológico. Puede ser usado como un microblog simple en formato .txt para subirlo en un servidor o para guardar notas rápidas en texto plano.

## Instalación

Se trata de un script en Bash. Así que, simplemente, clona este repositorio

    git clone https://github.com/lenguajeprivado/txtMicroBlog.git

o descarga el script y cópialo al directorio en donde vayas a usarlo.

## Configuración

En el inicio del script están las variables a configurar. Todas están comentadas y explicadas brevemente. Camialas para poner tu nombre, el nombre de tu txtMicroBlog y demás cosas.

## Uso

Una vez que hayas revisado el script **porque es importante revisar siempre los scripts de bash que vamos a correr**, vuélvelo un ejecutable:

    chmod +x txtmb.sh

TXTMB tiene dos unos pricipales. El primero es crear un archivo .txt con una cabecera adecuada. Para ello, se usa la flag *N* con el nombre del nuevo proyecto:

    ./txtmb.sh -N nuevotxtmb

y sigue las instrucciones.

Para crear nuevas entradas, se utiliza la flag *p*, acompañada del nombre y extensión del proyecto.

    ./txtmb.sh -p nuevotxtmb.txt

es importante que no olvides la extensión *.txt*. Sigue las instrucciones en la terminal para crear una nueva entrada.

## Cuestiones importantes

Si llegas a modificar la cabecera del txt, cambia la variable "T_AJUSTE" para indicar dónde es que las nuevas entradas deben colocarse.

También puede cambiar el comando que está dentro de la función ACCION. Es útil poner scp para enviarlo a un servidor donde pueda estar disponible.

Ten en cuenta que es un script que hice en una sola tarde libre. No esperes que sea perfecto, que funcione bien o que esté bien escrito.

## Demo

Si quieres ver cómo luce, visita mi propio [TXTMB](https://lenguajeprivado.com/txtmb.txt).


