---
kind: article
title: Resumen Spring
created_at: 2012/04/08
excerpt: Resumen del Framework Spring
tags: [spring, wdt, web, java]
---

Este es un resumen del framework de desarrollo Java (principalmente Web) Spring, basado en el libro <a href="http://www.manning.com/walls4/" target="_blank">Spring in Action, Third Edition</a>

# Spring
Framework de desarrollo Java que ofrece _Dependency Injection_, _Aspect Oriented Programming_ y _Templates_. 

 * Inyección de Dependencias (DI): Configuración automático de dependencias de una clase.
 * Programación Orientada a Aspectos: Adición de funcionalidades comunes a lo largo de un sistema (ej. Sistema de Logging).
 * Plantillas: Permiten reutilizar código y reducir escribir funciones repetitivas.

Spring administra clases en un sistema por medio de un _Container_, en este contenedor se encuentran todas las referencias de los objetos administrados por Spring. Hay dos tipos de contenedores, los _BeanFactories_, para inyección de dependencia, y _ApplicationContexts_, que incluyen DI ademas de otros servicios Event Listeners, interceptors, etc.  

_ApplicationContexts_ relevantes en Spring:

 * ClassPathApplicationContext: en classpath
 * FileSystemApplicationContext: en el sistema de archivos
 * XmlWebApplicationContext: para aplicaciones web

## Ciclo de vida de un Bean
Un Bean es una clase POJO administrada por Spring. 

Ciclo de vida:

 * Instantiate
 * PopulateProperties
 * BeanNameAware's setBeanName
 * BeanFactoryAware's setBeanFactory
 * ApplicationContextAware's setApplicationContext
 * Pre-initialization BeanPostProcessors
 * InitializatingBean's afterPropertiesSet
 * Call custom init method
 * Post-initialization BeanPostProcessors
 *  **BEAN READY TO USE**
 * Container is shutdown
 * DisposableBean's destroy
 * Call custom destroy method


## Configuración de Beans
### Constructor injection
    <bean id="beanId1" class="package.Class">
      <constructor-arg value="10"/>
      <constructor-arg ref="beanId2"/>
    </bean>
    ...
    <bean id="beanId2" class="package.Class2"/>
### Factory Method injection
    <bean id="beanId1" class="package.Class" factory-method="getInstance"/>

**Nota**: Bean son Singleton por default, el atributo _prototype_ se utiliza para sobrescribir este patrón. Opciones posibles: singleton, prototypee, request, session, global-session.

### Init/Destroy beans
    <bean id="beanId1" class="package.Class"
    init-method="methodWhenInit" destroy-method="methodWhenDestroy"/>

 * Otro método para inicializar o finalizar un bean es implementando las interfaces _InitializingBean y DisposableBean_.
 * También se puede configurar un método default para inicializar y finalizar de forma global configurando _default-init-method_ y _default_destroy_method_ como atributos del tag _beans_.

### Properties injection
    <bean id="beanId1" class="package.Class">
      <property name="property1" value="10"/>
      <property name="property2" ref="beanId2"/>
    </bean>
    ...
    <bean id="beanId2" class="package.Class2"/>
### Inner beans
    <bean id="beanId1" class="package.Class">
      <property name="property2">
        <bean class="package.Class2"/>
      </property>
    </bean>

Funciona igual para `contructor-arg`
### Wiring Collections
#### List, sets, arrays
    <bean id="beanId1" class="package.Class">
      <property name="mycollection">
        <list>
          <ref bean="beanId2"/>
          <ref bean="beanId3"/>
          <ref bean="beanId4"/>
        </list>
      </property>
    </bean>
#### Maps, Props
    <bean id="beanId1" class="package.Class">
      <property name="mycollection">
        <map>
          <entry key="aKey" value="aValue"/>
          <entry key-ref="keyBean" value-ref="beanId3"/>
          <entry key="aKey" value-ref="beanId2"/>
        </list>
      </property>
    </bean>
### Wiring to NULL
    <property name="thisPropNull"><null/></property>

## Autowiring
Básicamente, hay dos tipos de resolución automática de beans: "autowire" en el XML o usando "annotations".
### Autowiring in XML
Durante la configuración de un bean en el _ApplicationContext_ se define el tipo de "autowire", es de decir, como son conectadas las propiedades de un bean.

    <bean ... autowire='TIPO_DE_AUTOWIRE' />

#### Tipos de _Autowire_
 * byName: busca un bean con el mismo NOMBRE de la propiedad (atributo)
 * byType: busca un bean con el mismo TIPO de la propiedad, si hay varios beans que puedan ser seleccionados, se genera una excepción, a menos que hay solo un bean marcado como "_primary_", por default, todos los beans son _primary=true_, se debe marcar _primary=false_ para evitar la excepción.
 * constructor: igual que _byType_ pero para los parametros del constructor
 * autodetect: realiza _constructor_ y si no es posible, realiza _byType_

Para definir _autowire_ para todos los beans se usa: `<beans ... default-autowire='TIPO_DE_AUTOWIRE' />`, en este caso también esta la opción _none_.

### Autowiring with Annotations
Para habilitar las _anotaciones_ se coloca el elemento `<context:annotation-config/>` en el tag `<beans>`.

#### @Autowired
 * La anotacion_@Autowired_ colocada en atributos o métodos informa a Spring que esa propiedad debe ser configurada por el _Framework_. 
 * _@Autowired_ es equivalente a _@Inject_ en la especificación JSR-330.
 * _@Autowired_ es equivalente a _Autowire byType_
 * (required=false): parametro opcional para evitar la generación de excepciones en el caso que no sea posible suplir la dependencia.
 * _@Qualifier("name")_: Usado para eliminar la ambigüedad en la resolución de dependencias (Similar a _byName_). Equivalente a _@Named("name") en la especificación Java.
 * _Qualifiers_ pueden ser extendidos en Spring o en Java
 * _@Value("xyz")_: Usado para pasar valores a la propiedad. Usado principalmente con _Spring Expression Language_ (SpEL).

Hasta aquí, los beans (anotados o no) debían estar listados en el _applicationContext_, para evitar esto se usa el _descubrimiento automático de beans_.

### Descubrimiento automático de Beans
Se usa `<context:component-scan/>` en vez de `<context:annotation-config/>`. se debe configurar el atributo `base-package="xyz.abc"` para indicar donde deben ser buscados los beans. Los Beans pueden ser de 4 tipos:

* _@Component("nombre_opcional")_:  Bean común de Spring.
* _@Controller("nombre_opcional")_: Controlador de Spring MVC
* _@Service("nombre_opcional")_: Servicio de Spring
* _@Repository("nombre_opcional")_: Repositorio de accesso a datos (similar a DAOs)

Es posible usar _filtros_ para incluir o excluir _beans_ sin anotaciones, usando  el tag `<context:include-filter/>` o `<context:exclude-filter/>`.

## Configuración de Spring usando Java
Se usa una clase Java para obtener la configuración de los beans. La clase debe estar anotada con _@Configuration_ y cada método que genera un bean debe ser anotada con _@Bean_. También se utiliza `<context:component-scan/>`.

## Spring AOP Framework
AOP: Aspect Oriented Programming, ayuda a modularizar funcionalidades transversales de un sistema, como _logging_ o seguridad, donde varios puntos de un sistema pueden ser afectados.

### Vocabulario:
 * Advice: Método a ser ejecutado y cuando.
   * Before,
   * After,
   * After-returning: con exito,
   * After-throwing: con error (_throws an exception_)
   * Around: Envuelve un método (antes, despues)
 * Join Point: Lugar donde podria ser llamado un _Advice_
 * Pointcuts: Donde DEBE ser llamado un Aspecto
 * Ascpect: Advice + Pointcut
 * Introductions: Adición de nuevos métodos o atributos a una clase
 * Weaving: Proxy an object, puede ser en:
   * Compilation time
   * Class load time
   * Runtime: asi lo hace Spring AOP

### Abordajes de Spring AOP:
 * Classic: Proxy-based (1)
 * Anotaciones _@AspectJ_ (1)
 * Pure POJO aspects (1)
 * Injected AspectJ aspects

 (1): Solo para métodos

Spring solo soporta _Proxied-objects_ en tiempo de ejecución, por lo tanto solo puede interceptar métodos.

### Pointcuts
Spring soporta un subconjunto de pointcuts de AspectJ debido a la restricción de intercepción solo en metodos.
#### Pointcut expression language para Spring:
 * args(): Los argumentos deben ser instancias de los tipos definidos
 * @args(): Los argumentos deben estar anotados con los tipos definidos
 * this(): Bean reference of a AOP proxy is of a given type
 * target(): El objeto debe ser del tipo especificado
 * @target: El objeto debe tener la anotación especificada
 * within: El objeto debe ser de alguno de los tipos dados
 * @within: El objeto debe tener una de las anotaciones especificadas
 * @annotation: El método tiene la anotación especificada
 * execution: El joint point es un _method execution_. Es el mas importante, porque es el único que realiza matching.
 * bean: Especifíca en que Bean debe ser creado el Pointcut (Solo en Spring)

Ejemplo:
     execution(* net.co.Class.play(..))

Explicación:
 * execution: interceptar en la ejecución del método
 * _\*_: Retorna cualquier tipo
 * net.co.Class: Clase a la que el método pertenece
 * play: Método
 * (..): Cualquier argumento

 En la creación de Pointcuts puede usarse operadores logicos && (and), || (or), ! (not)

### Declaración de Aspects en Spring
 * Namespace: aop

Elementos:

 * `<aop:advisor>`
 * `<aop:after>`
 * `<aop:after-returning>`
 * `<aop:after-throwing>`
 * `<aop:around>`
 * `<aop:aspect>`
 * `<aop:aspectj-autoproxy>`: Permite anotaciones @AspectJ
 * `<aop:before>`
 * `<aop:config>`: Top level AOP elements
 * `<aop:declare-parents>`
 * `<aop:pointcut>`

Ejemplo:

    <aop:config>
      <aop:aspect ref='BeanConFuncionalidad'>
         <aop:pointcut id='pointId'
             expression='execution(....)'/>
         <aop:before pointcut-ref='pointId'
             method='MetodoAEjectuarEnBeanConFuncionalidad'/>
      </aop:aspect>
    </aop:config>

La definición de un Pointcut puede ser por fuera del aspecto, asi, esta definición estará disponible para otros aspectos.

### Around advice
Intercepción de un método Antes y Despues (`<aop:around`>).

    public void aroundMethod(ProceedingJoinPoint point){
      //instrucciones antes de llamar el método
      point.proceed(); //ejecución del método
      //instrucciónes despues del método
    }

Configuración en XML igual que los otros aspectos

### Pasar parámetros a un advice
    <aop:config>
      <aop:aspect ref='BeanConFuncionalidad'>
         <aop:pointcut id='pointId'
             expression='execution(* net.co.Class.play(String) and args(argname)'/>
         <aop:before pointcut-ref='pointId'
             method='MetodoAEjectuarEnBeanConFuncionalidad'
             arg-names='argName'/>
      </aop:aspect>
    </aop:config>

El método _MetodoAEjecutarEnBeanConFuncionalidad_ debe recibir un String

### Anotando aspects en Spring
Spring usa anotaciones _@AspectJ_, sin embargo, se encuentra limitado a la intercepción de métodos (con AspectJ tabmién es posible interceptar atributos y constructores).

    @Aspect //define un aspecto
      public class MyAspect{
      @Pointcut("execution(*.com.mypackage.MyInterceptedClass.interceptedMethod(..))")
      public void pointcutName(){}//Este método solo define el pointcut, debe permanecer vacio
    
      @Before("pointcutName()")
      public void method1(){ ... do stuff ...}
    
      @AfterReturning("pointcutName()")
      public void method2(){ ... do stuff ...}
    
      @AfterThrowing("pointcutName()")
      public void metho3(){ ... do stuff ...}
    
      @Aroun("pointcutName()")
      public void method4(ProcedingJoinPoint joinpoint){
        try{
          ... do stuff befoe ...
          joinpoint.proceed(); // ejecutá el método
          ... do stuff after ...
        }catch(SomeException ex){
          ... do stuff for throwing ...
        }

      /** Pasando Parametros **/
      @Pointcut("execution(*.com.mypackage.MyInterceptedClass.interceptedMethod2(String))" +
      " && args(someArgumentName)")
      public void pointcutOther(String someArgumentName){}//Este método solo define el pointcut, debe permanecer vacio

      @Before("pointcutOther(someArgumentName)")
      public void method5(String someArgumentName){
        ... do stuff with arguments ...
      }
    }

    

 * Anotaciones requieren tener el código fuente. XML no necesita (Con XML se pueden interceptar objetos de bibliotecas externas)
 * La clase definida como aspecto sigue siendo un POJO, por lo tanto puede ser usada como un Bean en Spring
 * Se deve incluir `<aop:aspectj-autoproxy/>` al xml para dar soporte a anotaciones

