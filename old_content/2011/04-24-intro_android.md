---
kind: article
title: Introducción a Android
created_at: 2011/04/24
excerpt: Introduciendo Android, el SO para móviles de Google
tags: [android, mobile, google]
updated_at: 2011/04/24
draft = true
---

Este post tiene por objetivo dar un vistazo general de __Android__. Dar definiciones básicas sobre la plataforma y pasos iniciales para el desarrollo de aplicaciones para esta plataforma.

Que es Android? ![android][1]
--------------
<a href='http://developer.android.com' target='_blank'>Android</a> es un sistema operativo para dispositivos móviles (celulares, PDAs, tablets, etc.) desarrollado principalmente por Google. Android sigue la filosofia de codigo abierto, por lo tanto, cualquier persona puede bajar el código, modificarlo dependiendo sus necesidades, y compartir esas modificaciones con la comunidad.

Arquitectura de Android
-----------------------
<center>
<table border='1'>
 <tr><td>Custom & built-in apps (Java)</td></tr>
 <tr><td>Dalvik virtual machine</td></tr>
 <tr><td>Linux Kernel</td></tr>
 <tr><td>Hardware</td></tr>
</table>
</center>


Android está estructurado básicamente como un sistema en capas:

 1. Hardware: son los componentes físicos del sistema (GPS, memoria, acelerometro, etc).
 2. Linux kernel: Abstracción del hardware. Contiene los drivers de acceso al hardware, bibliotecas nativas, etc.
 3. Dalvik vitual machine (DVM): Maquina virtual donde son ejecutadas las aplicaciones de Android. Las aplicaciones son programadas utilizando Java (en su mayoría). Tanto las apps del sistema como las apps del usuario son ejecutadas en maquina virtual. También es posible desarrollar aplicaciones nativas (en C o C++) usando NDK (Native development kit)
 4. Custom & built-in apps: Son las aplicaciones instaladas en el sistema.
 
Desarrollo de aplicaciones
--------------------------
### Conceptos básicos:
 * __Intent__: (Declaration of need) Especifica el requerimiento de alguna funcionalidad al sistema. (*Necesito XYZ*)
 * __Intent filters__: (Declaration of capability): Definición de funcionalidad ante el sistema. (*Ofrezco ABC*)
 * __Activity__: Componente de una aplicación que presenta una interfaz gráfica al usuario. (*Toda GUI tiene una activity*)
 * __Service__: Componente para ejecución en background. *ejecución de tareas de larga duración*
 * __Broadcast receiver__: Componente para ejecución de tareas pequeñas en background. (*Ejecución de tareas de corta duración*)
 * __Content provider__: Provee datos a otras aplicaciones. (*proveedor de base de datos (SQLite)*)
 * __Manifiest.xml__: Archivo descriptor de la aplicación. Define los componentes de la aplicación (activities, services, receivers and providers). Describe las funcionalidades (capabilities) requeridas para ejecutar la aplicación (ejemplo: GPS, red, SMS)
 
[1]: /assets/images/android.png
