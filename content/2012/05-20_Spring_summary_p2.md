---
kind: article
title: Resumen Spring - Parte 2
created_at: 2012/05/20
excerpt: Resumen del Framework Spring - Segunda parte
tags: [spring, wdt, web, java]
---

Esta es la segunda parte del resumen del framework de desarrollo Java (principalmente Web) Spring, basado en el libro <a href="http://www.manning.com/walls4/" target="_blank">Spring in Action, Third Edition</a>

# Database
* DAO (Data Access Object): define el acceso a datos por medio de una interface usada por el resto de la aplicación para consultar/guardar información

##### Principio POO: Programe para Interfaces para reducir acoplamiento

## Data access exceptions in Spring
* Spring provee un rango mucho mas variado y detallado de excepciones de accesso a base de datos que JDBC.
* Todas las excepciones extienden _DataAccessException_ la cual es _unchecked_ y por lo tanto no necesita tener un _handle_ (pero en alguna capa superior debe ser tratada).

## Data Access Templates
* Spring sigue el patrón _TemplateMethod_ para definir reducir la escritura de código repetitivo, como inicialización de recursos, transacciones, commits, etc. De esta forma, solo es necesario implementar un método que prepara los datos para la consulta, la ejecuta y procesa los resultados.
* Spring ofrece diferentes template dependiendo la plataforma, pueden ser JdbcTemplate, HibernateTemplate o JpaTemplate, entre otros.
* Para la implementación de DAOs, Spring también ofrece varios tipos de DAO  para ser extendidas y reaprovechar código (SimpleJdbcDaoSupport, HibernateDaoSupport, JpaDaoSupport, entre otros).

## Configuración del DataSource
Un DataSource mantiene la configuración de accesso a la base de datos, puede ser JDBC driver, JNDI o Pool connections (último es recomendado)
### JNDI
    <jee:jndi-lookup id="dataSource"
    jndi-name="/jdbc/MyDataBaseDS" resource-ref="true" />
* resource-ref=true: adds `java:/comp/env` to jndi-name

### Pooled data
Ejemplo usando Jakarta Commons Database Connection Pooling (DBCP)
    <bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource">
      <property name="driverClassName" value="org.hsqldb.jdbcDriver" />
      <property name="url" value="jdbc:hsqldb:hsql://localhost/name1/name2" />
      <property name="username" value="user" />
      <property name="password" value="pass" />
      <property name="initialSize" value="5" />
      <property name="maxActive" value="10" />
    </bean>

### JDBC driver-based
Ejemplo usa la misma estructura que Pooled data, pero cambia la clase del bean:
* org.springframework.jdbc.datasource.DriverManagerDataSource: Retorna una conexión nueva siempre.
* org.springframework.jdbc.datasource.SingleConnectionDataSource: retorna siempre la misma conexión.

## JDBC template en Spring
Hay tres tipos de templates: (1) JdbcTemplate, (2) NameParameterTemplate y (3) SimpleJdbcTemplate. El tercero es el mas usado actualmente.
### SimpleJdbcTemplate
Pasos (ejemplo)
 
* Configurar el template incluyendo el `datasource`

     <bean id="myJdbcTemplate"
       class="org.springframework.jdbc.core.simple.SimpleJdbcTemplate">
       <constructor-arg ref="dataSource" />
     </bean>
* Configurar los DAO para usar el template

     public class MyObjectJdbcDAO implements MyObjectDAO {
     ...
       private SimpleJdbcTemplate jdbcTemplate;
       public void setJdbcTemplate(SimpleJdbcTemplate jdbcTemplate) {
         this.jdbcTemplate = jdbcTemplate;
       }
     }
     //En el XML
      <bean id="myObjectDao"
       class="net.emtg.spring.persistence.SimpleJdbcTemplateSpitterDao">
       <property name="jdbcTemplate" ref="jdbcTemplate" />
      </bean>
  
* Usar el template: para usar el template pueden ser usados _named parameters_ para definir sentencias SQL:
 
      public class MyObjectJdbcDAO implements MyObjectDAO {
       private static final String INSERT_OBJECT="insert into mytable " +
         "(name, lastname, birthday) " +
         "values (:firstname, :lastname, :birthday)";
 
       public saveObject(MyObject myObj){
         Map<String, Object> params = new HashMap<String, Object>();
         params.put("firstname", myObj.getName());
         params.put("lastname", myObj.getLastName());
         params.put("birthday", myObj.getBirthday());

         jdbcTemplate. update(INSERT_OBJECT, params);
       }
* Consultar la base de datos:

    public class MyObjectJdbcDAO implements MyObjectDAO{
      private static final String SELECT_OBJECT="select * from "+
        mytable where id=?";
    
      public MyObject getObject(String id){
        return jdbTemplate.queryForObject(
          SELECT_OBJECT, new ParametrizedRowMapper<MyObject>(){
            public MyObject mapRow(ResultSet rs, int rowNum) throws SQLException{
              MyObject myObj = new MyObject();
              myObj.setId(rs.getString(1));
              myObj.setName(rs.getString(2)); 
              myObj.setLastName(rs.getString(3));
              myObj.setBirthday(rs.getString(4));
              return myObj;
            }
          }, id);
      }

#### DAO Support
Spring viene con e clases que pueden ser extendidas por los DAOs e evitar código repetitivo (SimpleJdbcDAOSupport).


## Integracion Spring / Hibernate
### Hibernate Session Factory
* Interface org.hibernate.Session define todas las operaciones CRUD
* En Spring se usa Hibernate Session Factory para obtener una Session, las factories son encargadas de administrar la session (abrir, cerrar...)

Hay dos formas de configurar Hiberntate en Spring:

* LocalSessionFactoryBean: Configura Hibernate usando XML que mapean las tablas, ejemplo:

    <bean id="sessionFactory"
      class="org.springframework.orm.hibernate3.LocalSessionFactoryBean">
        <property name="dataSource" ref="dataSource" />
        <property name="mappingResources">
          <list>
            <value>MyObject.hbm.xml </value>
          </list>
        </property>
        <property name="hibernateProperties">
          <props>
          <prop key="dialect">org.hibernate.dialect.HSQLDialect</prop>
          </props>
        </property>
      </bean>

* AnnotationSessionFactoryBean: las clases deben estar anotadas con @Entity (JPA), @MappedSuperclass o @Entity (Hibernate)

     <bean id="sessionFactory"
      class="org.springframework.orm.hibernate3.annotation.AnnotationSessionFactoryBean">
        <property name="dataSource" ref="dataSource" />
        <property name="packagesToScan"
        value="com.habuma.spitter.domain" />
        <property name="hibernateProperties">
          <props>
           <prop key="dialect">org.hibernate.dialect.HSQLDialect</prop>
         </props>
        </property>
    </bean>

### Usando Hibernate

    @Repository
    public class MyObjectHbDao extends MyObjectDAO{
      @Autowired
      private SessionFactory sessionFactory;
    
      public setSessionFactory(SessionFactory sessionFactory){
        this.sessionFactory = sessionFactory;
      }
    
      private Session getSession(){
        return sessionFactory.getCurrentSession();
      }
    
      public MyObject getMyObject(String id){
        return getSession().get(MyObject.class, id);
      }
    
      public void save(MyObject obj){
        getSession().update(obj);
      }
    }

### Exception en Hibernate
Para capturar excepciones de Hibernate usamos `PersistenceExceptionTranslationPostProcessor`, el cual es un bean que "intercepta" las excepciones de cualquier `@Repository` y las convierte en Excepciones de Spring.
