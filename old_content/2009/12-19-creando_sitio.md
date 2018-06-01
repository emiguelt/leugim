--- 
kind: article
title: Creando mi Sitio Web
created_at: 2009/12/19
excerpt: Creación de sitio web usando Nanoc
tags: [nanoc, web]
draft = true
---
Hola, por fin he decido iniciar formalmente mi sitio web. Ya habia hecho un par de intentos con servicios gratuitos de hosting, sin embargo, siempre exisitian limitaciones en este tipo de servicios, como restriccion de contenidos, estilos, derechos reservados, etc.  Despúes de una gran busqueda me he decidido por usar una página web estática, pero generada automáticamente por una herramienta que me permite manejar agilmente el diseño y recursos, y dedicarme a lo que mas me interesa, el contenido.

He decido dedicar este primer post al todo el procedimiento que llevé a cabo para poner mi sitio web en el aire. En una vista rapida, lo que basicamente hice fue buscar un diseño (admito que soy malo con ccs), buscar y aprender a usar (todavia estoy aprendiendo) una herramienta para generación de sitios web estaticos, personalizar mi sitio y finalmente, ponerlo en la Web.

Vale la pena aclarar antes de comenzar que este no es un tutorial paso a paso y no se busca aprofundar mucho en cada tema, simplemente es un recuento del trabajo realizado para alcanzar mi objetivo. En el caso que sea necesária alguna aclaración, por favor escribanme que con mucho gusto y en el menor tiempo posible responderé.

## Buscando un diseño para mi página ##
Hay que confesar que esto ha sido lo mas fácil del proceso. Simplemente hice una exploración por varios portales que ofrecen plantillas para sitios web.  Los sitios que revisé son los siguientes:

* [Free CSS Templates](http://www.freecsstemplates.org/)
* [Open Source Web Desig](http://www.oswd.org/)
* [Open Source Templates](http://opensourcetemplates.org/)
* [OpenDesigns](http://www.opendesigns.org/)
* [Open Web Designs](http://www.openwebdesign.org/)

Finalmente y después de probar muchos diseños decidí usar [TerraFirma<sup>2</sup>](http://www.freecsstemplates.org/preview/terrafirma2), espero haya sido una buena elección.

## Generación de sitios web estáticos con Nanoc ##
Principalmente he optado por usar una página estatica por el hecho que puedo tener el control sobre todo el contenido directamente en los archivos, sin depender de bases de datos, lenguajes de programación, etc. Existen varias opciones para diseñar y mantener un sitio web estático, por lo tanto, también hice una evaluación de algunos con el fin de usar el que mejor se ajustara a mis necesidades. Algunas de las opciones evaluadas fueron:

* Editor simple de texto (ej, GEdit): tener una página completamente estatica, como se hacia a la "antigüita", usando archivos de texto, tags HTML, etc.
* Editor de páginas HTML (ej, Bluefish): herramienta que permite desarrollar páginas web sin necesidad de tener conocimiento profundo sobre etiquetas HTML, simplemente escribiendo como en cualquier procesador de texto y la herramienta va traduciendo a HTML o lo que en este medio llaman de *WYSIWYG* (_W_hat _Y_ou _S_ee _I_s _W_hat _Y_ou _G_et).
* Generador de páginas web estáticas: es una herramienta que permite administrar un sitio web estatico por medio de la generación de las páginas HTML a partir de archivos de texto (contenido) con pequeñas reglas de sintaxis, archivos de configuración (reglas de generación, aplicación de estilos) y si se quiere, plantillas y hojas de estilo para definir un diseño para la página. Generalmente estas herramientas utilizan un lenguage de programación sencillo para correr los scripts, como Python o Ruby. También es posible colocar código embebido en las paginas con el fin de generar contenido "semi-dinámico" durante la generación del sitio.

En mi caso he seleccionado una herramienta que me permita tener control sobre el contenido de mi sitio, poder acceder directamente a cada archivo usando un editor de texto sencillo, que pueda configurar el diseño de la página en forma general y que pueda usar código embebido para generar contenido dinamico como indices, menús, entre otros. La herramienta elegida es [Nanoc](http://nanoc.stoneship.org/), un generador de sitios web estaticos que utiliza Ruby para compilar las páginas y con la cual puedo escribir en código Ruby, HTML, Markdown, Textile, Haml, entre otros. Otras opciones que revisé son:

* [Webby](http://webby.rubyforge.org/)
* [Webgen](http://webgen.rubyforge.org/)
* [StaticMatic](http://staticmatic.rubyforge.org/)

En las siguientes secciones encontrarán un resumen las acciones realizadas para tener el sitio web listo para colocar en un servidor web.

-----------------------------------

## Descripción de mi ambiente de trabajo y requerimientos ##
### Ambiente de trabajo ###
* Hardware (no muy importante): Amd Atlhon 64 3400, 1Gb Ram
* Sistema Operativo: Ubuntu 9.0.4 X86
* Editor de texto: Gedit

### Requerimientos ###
* Ruby 1.8 o superior (Creo que ya viene instalado con Ubuntu
* Rubygems: Administrador de paquetes para Ruby

-----------------------------------
## Instalación de Nanoc ##
La instalación de *nanoc* es muy sencilla despues que ya se tiene Ruby, yo he siguido el [tutorial](http://nanoc.stoneship.org/tutorial/) del sitio oficial de nanoc. En una consola correr el siguiente comando:

<pre><code>sudo gem install nanoc3</code></pre>

Ahora, yo he decidido usar *Markdown* para poder escribir el contenido en forma simple dejando para el compilador la generación de la mayoria de etiquetas HTML. Corremos el siguiente comando en la consola para instalarlo:

<pre><code>sudo gem install BlueCloth</code></pre>

### Error en Rubygems de Ubuntu ###
Normalmente cuando es instalado un paquete para Ruby usando Gems es posible acceder directamente a los nuevos comandos usando la consola, sin embargo, en Ubuntu 9.0.4 no es posible encontrar el comando `nanoc` en la consola. Para corregir este problema rapidamente simplemente se pega a la variable de entorno *PATH* la ruta de los binarios instalados com Gems. Para esto puede correrse el comando siguiente:

<pre><code>export PATH=$PATH:/var/lib/gems/1.8/bin</code></pre>

Esta solución solo es temporal, cuando sea cerrada la consola o se abra una diferente de nuevo no sera posible acceder a estos comandos. Una solución definitiva podria ser colocar este comando en el archivo *.profile* en el home del usuario o en */etc/profile* (con permisos de root)

-----------------------------------

## Creación y configuración del Sitio Web ##

Creamos el sitio con:

	nanoc3 create_site sitename

Este comando genera la siguiente salida:

	create  config.yaml
	create  Rakefile
	create  Rules
	create  content/index.yaml
	create  content/index.html
	create  layouts/default.yaml
	create  layouts/default.html

### Configuración del estilo ###

El archivo *layouts/default.html* contiene el diseño básico de todas las páginas y la organización de su contenido

Editamos el archivo *layouts/default.html* con el diseño del archivo HTML de *TerraFirma<sup>2</sup>*, en otras palabras, se coloca todo el contenido del archivo HTML del estilo, se elimina el contenido no deseado, se coloca el título que va a tener todas las paginas, asi como el el lugar donde se va a desplegar el contenido de las páginas. A continuación un pequeño fragmento del archivo:

<% code(:html) do %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Miguel Triana - <%= @item[:title] %></title>
<link rel="stylesheet" type="text/css" href="/style.css" media="screen" />
</head>
<body>
<div id="wrapper">
    <div id="header" class="container">
        <div id="logo">
            <h1><a href="#">Edwin Miguel</a></h1>
            <p>Página personal</p>
...
<% end %>

El comando <strong>&lt;%= @item[:title] %&gt;</strong> nos permite cambiar el título de la página dependiendo del archivo que está siendo generada.


<% code(:html) do %>
        </div>
    </div>
    <div id="page" class="container">
        <div id="content">
         < %= yield % > //Without spaces between % and < or >
        </div>
        <div id="sidebar">
            <ul>
<% end %>

En este caso, <strong>&lt;%= yield %&gt;</strong> nos permite colocar el contenido del archivo procesado en esta parte de la página.

El archivo *layouts/default.yaml* tiene parametros de configuración, si embargo, en este momento no tiene ninguna configuración.

#### Archivos de estilo
El directorio *images* y el archivo *style.css* se copia en el directorio *output/* y se reemplazan las imágenes de presentación y de perfil. El directorio *output/* es donde es colocado el resultado de la generación de la página web, es decir, este directorio va a contener nuestro sitio web listo para colocar en el servidor web.

### Organización del Sitio ###
Inicialmente el sitio va a tener una página inicial con un mensaje de bienvenida, el parrafo inicial de los cinco últimos articulos, una página *posts* con todos los articulos y una páginca por cada artículo publicado.  En esta parta seguí completamente el tutorial de *Starr Horne*, que puede ser encontrado [aquí](http://starrhorne.com/posts/howto_build_a_blog_with_nanoc/), por lo tanto queda de tarea revisar este sito que contiene el paso a paso para configurar el sitio como blog.

-----------------------------------

## Compilación y Despliegue del Sitio ##

Durante la edición de la página y en la creación de contenido se hace necesario realizar pruebas con el fin de evaluar el resultado final antes de colocarlo en Internet. Un modo sencillo es usando el comando <code>nanoc3 compile</code> o en versión abraviada <code>nanoc3 co</code>, el cual genera el sitio completa en el directorio *output/* el cual puede ser colocado en un servidor web local para ser visualizado.  Nanoc ofrece la facilidad de realizar la compilación y despliegue automático en un servidor local por medio del comando <code>nanoc3 aco</code>, este comando inicia un servidor web en el puerto 3000 (con -p XXXX se configura el puerto) y compila el sitio cada vez que se hace un request desde el navegador web. <br />

Para visualizar el sitio, use un navegador web (ej, Firefox) y entre a la URL http://localhost:3000/sitename, lá pagina web principal deberia desplegarse.

-----------------------------------

## Agradecimentos y enlaces importantes ##

Para llevar a cabo la creación de mi sitio web he seguido los tutoriales de *nanoc* y de *Starr Horne*, asi como he utilizado *Markdown* para crear contenido en archivos de texto plano. Agradezco a todas las personas involucradas en el desarrollo de estos proyectos, por poner a disponibilidad del público en general estas herramientas que facilitan el desarrollo de sitios web, asi como brindar parte de su conocimiento y compartilo con todos. Tambien gracias a *nodethirtythree* quien disponibilizó la plantilla TerraFirma<sup>2</sup>.

Enlaces:
* [Nanoc](http://nanoc.stoneship.org/)
* [Markdown](http://daringfireball.net/projects/markdown/)
* [TerraFirma<sup>2</sup>](http://www.freecsstemplates.org/preview/terrafirma2)
* [Starr Horne](http://starrhorne.com/posts/howto_build_a_blog_with_nanoc/)
* [Free CSS Templates](http://www.freecsstemplates.org/)
