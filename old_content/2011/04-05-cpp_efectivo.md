--- 
kind: article
title: C++ efectivo!
created_at: 2011/04/05
updated_at: 2011/04/12
excerpt: Recomendaciones para desarrollo en Lenguaje C++
tags: [c++]
publish: false
draft = true
---

Durante el desarrollo de mi carrera he tenido que aprender diversos lenguajes de programación. En muchos casos he aprendido conceptos básicos y he dejado de lado aspectos importantes que durante el desarrollo de una aplicación pueden hacer diferencia, ya sea en tiempo de ejecución o uso de recursos.

Este página reúne recomendaciones importantes para el desarrollo en C++. Estas recomendaciones son un resumen del libro <a href="http://www.amazon.com/Effective-Specific-Improve-Programs-Designs/dp/0321334876" target="_blank">*Effective C++*</a>, y he decido publicarlas al mismo tiempo que las pongo en práctica. Espero que también sean útiles para los lectores.

### 1. Vea C++ como una unión de lenguajes (View C++ as a federation of languages)


Dada el origen y la complejidad de C++, este puede ser visto como la reunión de cuatro lenguajes y/o paradigmas de programación. En un problema determinado, cada lenguaje puede tener ventajas y desventajas, las cuales deben ser tenidas en cuenta para obtener los mejores resultados durante la resolución del problema. Los cuatro cuatros lenguajes son:
 1. __C__: Esta es la base de C++, se caracteriza por su estructura procedimental, el preprocesador, el tipos de datos, etc. 
 2. __C++ orientado a objetos__: Trae el soporte a clases en C, incluyendo el polimorfismo, la herencia, los constructores, destructores, entre otros. Todas las reglas de diseño orientado a objetos pueden ser aplicadas aquí.
 3. __Template C++__: Trae a C++ el paradigma de programación con platillas, que facilita la reutilización de código y disminuye el tiempo de desarrollo.
 4. __STL__: Son bibliotecas de platillas con algoritmos y estructuras de datos diseñados para obtener buen desempeño durante el desarrollo de aplicaciones. Incluyen contenedores como mapas, tablas hash, listas enlazadas son sus respectivos algoritmos de búsqueda, inserción, etc.

### 2. Prefiera *const*, *enums* e *inlines* sobre *#defines*
El problema de usar `#define` para definir constantes, es que estas son reemplazadas por el valor real durante la fase de pre-procesamiento, así, en el caso que ocurra un error relacionado con algún `#define` durante la fase de compilación, este error no sería fácilmente identificable pues el símbolo no existe en la tabla de símbolos, este ha sido reemplazado por el valor establecido. Una solución para este problema es el uso de constantes, por ejemplo:

<% code(:c) do %>#define EDAD_ADULTO 18 
//Este símbolo puede ser reemplazado por:
const int EdadAdulto=18; 
<% end %>

Dado que las constantes son normalmente definidas en los *headers*, los punteros a las constantes deben ser constantes, por ejemplo `const std:string nombre("Juan");`. En el caso de constantes de clase, estas deben ser declaradas como miembros estáticos de la clase. Ejemplo:

<% code(:c) do %>class Dog{
  private:
    static const int Legs = 4; //Declaracion de constante
    ...
};
<% end %>

En el caso que el compilador no acepte esta declaración, es necesario colocar la definición en el archivo de implementación (cpp). Ej: `const int Dog::Legs;`. Para compiladores que no aceptan este tipo de sintaxis, normalmente se usa *enum*, por ejemplo:
<% code(:c) do %>class Dog{
  private:
    enum{Legs = 4}; //Declaracion de constante
    ...
};
<% end %>

Para el caso de macros se recomienda usar funciones *inline*
