# txtMicroBlog [TXTMB]

**V. 0.3**

**txtMicroBlog [TXTMB]** es un script en Bash que genera un microblog simple en formato .txt el cual se puede subir en un servidor o puede servir para crear notas rápidas en texto plano.

## Instalación

Simplemente, clona este repositorio o descarga el script y cópialo al directorio en donde vayas a usarlo.

## Configuración

En el inicio del script están las variables a configurar. Todas están comentadas y explicadas brevemente. Cámbialas para colocar tu nombre, el nombre de tu TXTMB y demás cosas.

## Uso

Una vez que hayas revisado el script, vuélvelo un ejecutable:

    chmod +x txtmb.sh

TXTMB tiene dos usos pricipales. El primero es crear un archivo .txt con una cabecera adecuada. Para ello, se usa la flag *-X* con el nombre del nuevo proyecto:

    ./txtmb.sh -N nuevotxtmb

El segundo uso es crear entradas o  *posts* (como si fuera un blog). Para crear nuevas entradas, utiliza la flag *-n* con el nombre del .txt, y luego la flag *-p "<texto>"* para la nueva entrada.

    ./txtmb.sh -n nuevotxtmb.txt -p "Esta es una nueva entrada en mi TXTMB."

TXTMB permite hacer ajuste de texto, crear copias de respaldo, sincronizar con un servidor (por medio de scp). Para más información sobre el uso, utiliza la flag *-h*

    ./txtmb.sh -h

## Demo

Si quieres ver cómo luce, visita mi propio [TXTMB](https://lenguajeprivado.com/txtmb.txt).


