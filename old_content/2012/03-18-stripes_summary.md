---
kind: article
title: Resumen de Stripes
created_at: 2012/03/18
excerpt: Resumen de Desarrollo Web (Stripes)
tags: [stripes, wdt, web, java, maven]
---

Este es un resumen del material para desarrollo de aplicaciones web usando Stripes. Este resumen esta basado en el libro <a href="http://pragprog.com/book/fdstr/stripes" target="_blank">_Stripes ...and Java Web Development Is Fun Again_</a>.

Durante el resumen, va a ser implementado un administrador de tareas (ToDo list). 

Son utilizadas las siguientes herramientas:

- Maven 2: Sistema de construcción y administrador de dependencias
- Stripes: Framework para desarrollo de aplicaciones Web usando MVC (Model-View-Controller)
- Eclipse: IDE
- JDK: Entorno de Desarrollo de Java
- Git: Control de versiones

**Nota:** Se asume que el lector ya ha instalado maven, eclipse, java y git.

**Sources**: Todo el código esta disponible en <a href="https://github.com/emiguelt/ToDo-s" target="_blank">GitHub</a>

# Stripes
Stripes es un framework MVC para el desarrollo de aplicaciones Web para Java.

### Configuración de Stripes
__*Tag en Git: WDT-P01*__:  Implementa un CRUD básico para el administrador de tareas de ejemplo

Para integrar Stripes en una aplicación web es necesario modificar el archivo *web.xml* con la siguiente información:

 * Declaración del filtro de Stripes: `net.sourceforge.stripes.controller.StripesFilter`.
 * Establecer en que paquete se encuentran los *ActionBeans* (`ActionResolver.Packages`).
 * Declaración de `net.sourceforge.stripes.controller.DispatcherServlet`.
 * Configuración del filtro para interceptar todos los requests que van atraves del dispatcher.
 * Mapeamento del patrón de las URLs para ser capturadas por Stripes (Ej: .action)

### ActionBeans
Un _ActionBean_ es una clase que implementa la interfaz _ActionBean_, esta clase define los métodos (eventos, _event handler_) disponibles para procesamiento de los requerimientos (requests) de los usuarios. 
    public interface ActionBean {
      public void setContext(ActionBeanContext context);
      public ActionBeanContext getContext();
    }

### Event Handlers
Un _Event Handler_ es un método que captura un request de un usuario. Dentro del _Action Bean_, es un método público, sin parámetros y que retorna un objeto _Resolution_.
Por ejemplo, en la clase TaskAction está el método _delete_, que es invocado para borrar un registro en la lista de tareas
    public class TaskAction extends BaseAction {
    ...
      public Resolution delete() {
		      getTaskDao().delete(getTaskId());
		      return redirectToTaskList();
	      } 
    ...
    }

El cual podría ser llamado desde el browser asi: `http://localhost:8080/todos/Task.action?event=delete&taskId=10`

**Nota:** Todos los _ActionBeans_ deben tener un método predeterminado que debe ser marcado con `@DefaultHandler`

### Resolutions
Un objeto _Resolution_ es una "respuesta" para Stripes, indicando cual es el siguiente paso de procesamiento del request. Resolutions pueden ser: ForwardResolution, RedirectResolution, StreamingResolution, JavaScriptResolution, ErrorResolution o cualquier otra que implemente la interfaz:
    public interface Resolution {
      void execute(HttpServletRequest request, HttpServletResponse response)
      throws Exception;
    }

### Referenciando un ActionBean desde JSP
Un método o atributo de un ActionBean puede ser invocado desde una página JSP usando _Expression Language_ con la palabra clave _actionBean_, por ejemplo, la expresión `${actionBean.task.id}` obtiene el ID de una tarea a partir del ActionBean activo.

### Preaction Pattern
Este patrón recomienda que todos los request en una aplicación web sean hechos a los _ActionBeans_  y NO directamente a las JSPs, de esta forma se garantiza que todos los JSPs van a tener un _actionBean_, es posible interceptar el ciclo de vida request-response de Stripes y se puede tener un mejor control de acceso. Para evitar el acceso directo a los JSPs, estos deben colocarse en la carpeta _WEB-INF_ de la aplicación.

## Validación
__Tag en Git: WDT-P02__: Fueron adicionadas validaciones básicas en la edición de tareas.

Para realizar validaciones de formularios se hace uso de _Anotaciones_ en los _ActionBeans_. Sintaxis básica:

 * *@Validate(required=true, OTRAS RESTRICCIONES)*: esta anotación se coloca en el atributo o método que se quiere validar
 * *@ValidateNestedProperties({@Validate(field=xxx, Restricción),...)*: Anotación para realizar validaciones en atributos de objetos en el _ActionBean_, por ejemplo _Persona.edad_
 * *@Validate(expression=${REGEX})*: Permite validación con expresiones regulares
 * *@DontValidate*: Anotación para evitar la validación en un evento (Event handler)
 * *@Validate(on="handler")*: Restringe la validación al método referenciado en el parámetro *on*.
 * *@ValidationMethod(on={handlers})*: Anota un método como validador para uno o mas *handlers*. El método debe ser publico y debe recibir *ValidationErrors* o ningún parametro.
 * Interceptar Errores de Validación. Si el _ActionBean_ implementa la *Interface ValidationErrorHandler* es posible interceptar la validación de errores, para eliminar, adicionar o modificar errores

## Data types
 * De String a <T> : **Conversión** de una cadena de caracteres a objeto T.
 * De <T> a String: **Formato** de un objeto T a cadena de caracteres.

### Conversión
Un _Conversor_ en Stripes implementa la interfaz _TypeConverter<T>_

#### Conversores propios de Stripes:
 * Conversión de tipos primitivos y _wrappers_. Ej. String -> Integer : "1" -> Integer(1)
 * java.util.Date: Stripes usa DateFormat de Java para realizar conversión de fechas, realizando primero un preprocesamiento donde los separadores, como `/` o `-`, son reemplazados por espacios en blanco, entre otros procedimientos, para obtener un String dentro de los formatos de Java. También es posible configurar un o mas patron propio colocandolo en el archivo StripesResources.properties, usando la clave `stripes.dateTypeCoverter.formatString=yyyy MM d, otros... `
 * Tipos _Enumerated_: Stripes soporta conversión automática de tipos _Enumerated_. Es case-sensitive
 * _Booleans_: Stripes acepta como verdadero las siguientes cadenas: _true, t, yes, y, on, 1_, el resto es considerado como falso.
 * Single Caracteres: "Hello" -> "H"
 * Otros: _EmailTypeConverter, CreditCardConverter, PercentageTypeConverter, OneToManyTypeConverter_

Para usar un conversor específico,  el atributo debe ser anotado con `@Validate(converter=ElConversorEspecifico.class)`.

### Formato
Un _Formateador_ en Stripes implementa la interfaz _Formatter<T>_

#### Formateadores propios de Stripes
 * Dates: SimpleDateFormta + Locale
 * Número: DecimalFormt + Locale
 * Enumerated: Enum.name()
 * Objects: obj.toString()

_Formatters_ son usados en tags que aceptan atributos _formatType_ y _formatPattern_ como `<s:format> y <s:text>`

**Nota:** Converters, formatters y componentes adicionales de Stripes pueden ser utilizados configurando en el web.xml, configurando el parámetro _Extension.Packages_ en el _StripesFilter_.
