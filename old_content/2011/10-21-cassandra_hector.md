---
kind: article
title: Cassandra y Hector
created_at: 2011/10/21
excerpt: Uso de la biblioteca Hector para accesar Cassandra
tags: [hector, cassandra, database, java]
---
## Crear el proyecto:
    mvn archetype:generate \
    -DarchetypeGroupId=org.apache.maven.archetypes \
    -DgroupId=net.emtg.db.hector \
    -DartifactId=HectorStarted

## Añadir la dependencia de Hector en el POM
    <dependency>
      <groupId>me.prettyprint</groupId>
      <artifactId>hector-core</artifactId>
      <version>0.8.0-2</version>
    </dependency>

## Creando la clase ejemplo

<% code(:java) do %>public class HectorStarted 
{
  public static final String CLUSTER="Test-Cluster";
  public static final String KEYSPACE="MiBase";
  public static final String USER_CF = "Usuario";
  private Cluster myCluster;
  private ColumnFamilyDefinition userCFDef;
  private KeyspaceDefinition myTestKSDef;
  private Keyspace myKS;
  private ColumnFamilyTemplate<String, String> userCFTemplate;
  
<% end %>

## Inicializando classes
<% code(:java) do %>private void init(){
    myCluster = HFactory.getOrCreateCluster(CLUSTER, "localhost:9160");
    System.out.println("Cluster instantiated");
    
    userCFDef = HFactory.createColumnFamilyDefinition(KEYSPACE, USER_CF, ComparatorType.UTF8TYPE);
    
    myTestKSDef = myCluster.describeKeyspace(KEYSPACE);//tries to instantiate an existing keyspace
    if(myTestKSDef == null){
      //if the keyspace doesn't exist, it creates one
      myTestKSDef = HFactory.createKeyspaceDefinition(KEYSPACE, 
          ThriftKsDef.DEF_STRATEGY_CLASS,
          1,
          Arrays.asList(userCFDef));
      myCluster.addKeyspace(myTestKSDef, true);
      System.out.println("Keyspace " +  KEYSPACE + " created");
    }else{
      try {
        myCluster.addColumnFamily(userCFDef);
      } catch (HectorException e) {
        
      }
      
    }
    myKS = HFactory.createKeyspace(KEYSPACE, myCluster);
    System.out.println("Keyspace " +  KEYSPACE + " instantiated");

    userCFTemplate = new ThriftColumnFamilyTemplate<String, String>(myKS,
        USER_CF,
        StringSerializer.get(),
        StringSerializer.get());
  }
<% end %>

## Creando/Actualizando datos
<% code(:java) do %>private void update(String key, String name, String last) {
    ColumnFamilyUpdater<String, String> updater = userCFTemplate.createUpdater(key);
    updater.setString("name", name);
    updater.setString("last", last);
    try {
      userCFTemplate.update(updater);
      System.out.println("value inserted");
    } catch (HectorException e) {
      System.out.println("Error during insertion");
      System.out.println(e.getMessage());
    }  
  }
<% end %>

## Consultando datos
<% code(:java) do %>private void read(String key) {
    try {
      ColumnFamilyResult<String, String> result = userCFTemplate.queryColumns(key);
      System.out.println("User: " + result.getString("name") + " " + result.getString("last"));
    } catch (HectorException e) {
      System.out.println("Not possible to read the column with key " + key);
    }
  }
<% end %>

## Borrando datos
<% code(:java) do %>private void delete(String key) {
    try {
      userCFTemplate.deleteRow(key);
    } catch (HectorException e) {
      System.out.println("Not possible to delete row with key " + key);
    }
    
  }
<% end %>

## Probando los métodos
<% code(:java) do %>public static void main( String[] args )
  {
    HectorStarted test = new HectorStarted();
    System.out.println("instantiates cluster, keyspace and column family");
    test.init();
    System.out.println("//Insert a row in" + USER_CF);
    test.update("key1", "miguel", "triana");
    System.out.println("Reading data");
    test.read("key1");
    System.out.println("//Updating a row in" + USER_CF);
    test.update("key1", "miguel", "gomez");
    System.out.println("//Reading data");
    test.read("key1");
    System.out.println("//Deleteing data");
    test.delete("key1");
    System.out.println("//Reading non existing data");
    test.read("key1");
  }
}
<% end %>

<hr>
#### Referéncias
* http://rantav.github.com/hector/build/html/index.html
