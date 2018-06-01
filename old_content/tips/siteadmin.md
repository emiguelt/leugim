---
kind: article
title: Administración de sitio web estático
created_at: 2011/07/19
excerpt: Comandos utiles para la administración de mi página web estática
tags: [admin, sitecopy, tips]
---

## Instalación de herramientas

    sudo apt get-install ruby ruby1.8-dev rubygems sitecopy
    sudo gem install nanoc3 BlueCloth mime-types coderay rack builder rdiscount haml sass

## Uso de sitecopy
### Creación de archivos iniciales: 
	mkdir -m 700 ~/.sitecopy
	touch .sitecopyrc
	chmod 600 .sitecopyrc

### Configurar el sitio en el archivo _sitecopyrc_
Ver configuración en `man sitecopy`

### Actualizar archivo de contenido de sitecopy
	sitecopy --fetch mysite

### Sincronizar
 	sitecopy --update mysite  (sube las modificaciones locales)

