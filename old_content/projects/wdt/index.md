--- 
title: Desarrollo de Aplicaciones Web - Minitutoriales
tags: [wdt, stripes, maven, mvc]
excerpt: ""
publish: false
---

## Desarrollo de Aplicaciones Web

El objetivo de estos mini-tutoriales es revisar rapidamente algunas de las principales caracteristicas de las tecnologias utilizadas, mostrando su uso básico usando un projecto de ejemplo que iremos mejorando a lo largo de cada entrega. La idea es mejorar mis conocimientos sobre el tema y compartirlo con quien también esté interesado.

Inicialmente vamos a implementar una herramienta simple para administración de tareas (ToDo list), usando el patrón de desarrollo MVC (Model-View-Controller), ampliamente utilizado en aplicaciones Web. 

Todo el código esta disponible en github.

### Tutoriales
 * [Parte 1](/2012/03/18/wdt_p01.html) Introducción a Stripes

<script type="text/javascript">
//<![CDATA[
(function() {
	var links = document.getElementsByTagName('a');
	var query = '?';
	for(var i = 0; i < links.length; i++) {
	if(links[i].href.indexOf('#disqus_thread') >= 0) {
		query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
	}
	}
	document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/emiguelwebpage/get_num_replies.js' + query + '"></' + 'script>');
})();
//]]>
</script>

