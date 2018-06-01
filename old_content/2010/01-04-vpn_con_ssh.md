--- 
kind: article
title: Creando una VPN atrav&eacute;s de SSH
created_at: 2010/01/04
excerpt: Creando una VPN para accesar artículos de las bases de datos de la Universidad.
tags: [vpn, ssh]
---

Hoy he estado revisando parte de la bibliografía relacionada con mi tema de investigaci&oacute;n para mi maestría en la USP.  Generalmente las universidades tienen convenios con bases de datos para descargar o revisar bibliografía desde adentro de la institución, sin embargo, cuando uno esta en su casa y quiere hacer ese tipo de tareas se encuentra en frente de un gran problema, para descargar el archivo el PDF (o cualquier otro archivo) es necesario autenticarse (o sea suscribirse...).

Una solución sencilla es utilizar el protocolo VPN de Microsoft para "simular" que se está dentro de la universidad, sin embargo, dicho el uso de dicho protocolo es fácil desde Windows, pero un poco mas difícil desde Linux.  Buscando un poco en la página de la [USP](http://www.usp.br) encontré un buen post en cual se hace uso de SSH para crear la red privada y realizar las descargas desde el equipo local (en linux) sin problemas.

En enlace al que me refiero es [http://stoa.usp.br/oda/weblog/8113.html](http://stoa.usp.br/oda/weblog/8113.html), está en portugués y aunque es fácil de entender a continuación está el paso-a-paso del procedimiento:

Requerimientos
--------------
1. Solo hay un requerimiento, tener una cuenta en algún equipo (*NIX) con acceso SSH desde el exterior de la red de la institución

Procedimiento
-------------

1. En una consola, ejecutar el comando: _$ ssh user@host -ND 8888 sleep 99999_, donde **user** es el nombre de usuario en el **host** en la institución
    * -N: Inhibe la ejecución de comandos remotos
    * -D: Indica el puerto del proxy, este número puede cambiarse por cualquier otro que no esté ocupado. (Se recomienda no usar uno menor de 1024)
    * sleep 99999: Mantiene la conexión abierta
2. Abrir firefox e ir a _Edit->Preferences->Advanced->Network->Settings_ y seleccionar la opcion de _Manual proxy configuration_. Deje todo en blanco, menos el SOCKS Host en el que se coloca *localhost* con puerto *8888*.
3. Listo, para verificar el funcionamiento entre a [www.showip.com](www.showip.com) y revise que la IP pertenece al mismo esquema que el de la institución, o simplemente intente bajar el archivo que necesitaba.

Agradecimientos
---------------

Gracias a _Oda_ y su post [http://stoa.usp.br/oda/weblog/8113.html](http://stoa.usp.br/oda/weblog/8113.html).
