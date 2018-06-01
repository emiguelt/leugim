---
kind: article
title: Usando Cassandra_CLI (Básico)
created_at: 2011/10/21
excerpt: Comandos básicos para el cliente (consola) de Cassandra
tags: [cassandra, nosql, database]
---
Cassandra es un gestor de bases de datos distribuidas altamente escalable basado en NoSQL (mas info en: http://wiki.apache.org/cassandra).
Este post presenta el uso básico de la consola de definición y manipulación de datos *cassandra_cli*. Se asume conocimientos básicos de Cassandra y de su modelo de datos.

## Iniciando __cassandra_cli__
Desde el directorio de cassandra ejecutar el comando:
    ./bin/cassandra_cli --host localhost --port 9160
 * host: localhost o la dirección del cluster.
 * port: Puerto definido en conf/cassandra.yaml

## Creando un Keyspace
Un Keyspace es como un Schema en una base de datos relacional.
    create keyspace MiBase;
La salida de consola será algo como:
    448a4920-fbe9-11e0-0000-242d50cf1ffd
    Waiting for schema agreement...
    ... schemas agree across the cluster
Ahora usamos el keyspace recien creado:
    use MiBase;
Salida:
    Authenticated to keyspace: MiBase

## Creando una Column Family (CF)
Una CF seria como una tabla...
    create column family Usuario with comparator = UTF8Type;        
    5c064a30-fbea-11e0-0000-242d50cf1ffd
    Waiting for schema agreement...
    ... schemas agree across the cluster
Creamos una CF llamada Usuario, la cual asume que las llaves están en UTF8 para realizar comparaciones.

## Añadiendo datos en la CF
    set Usuario['mtriana']['apellido'] = 'miguel'; 
    org.apache.cassandra.db.marshal.MarshalException: cannot parse 'mtriana' as hex bytes
Intentamos adicionar un usuario, sin embargo obtenemos un error porque las columnas aceptan datos en formato en hexadecimal, entonces ejecutamos el siguiente comando para que sean aceptadas cadenas de caracteres en ASCII:
    assume UsUARIO keys as ascii;
    Assumption for column family 'Usuario' added successfully

De nuevo vamos a añadir el usuario:
    set Usuario['mtriana']['nombre'] = 'miguel';            
    Value inserted.
    set Usuario['mtriana']['apellido'] = 'triana';          
    Value inserted.
    set Usuario['mtriana']['edad'] = '10';        
    Value inserted.
En este caso *mtriana* es la llave de accesso a la super columna (es como una fila)  y *nombre*, *apellido* y *edad* son las columnas da la CF.
## Consultando la CF
    get Usuario['mtriana'];
    => (column=apellido, value=747269616e61, timestamp=1319205144832000)
    => (column=edad, value=3130, timestamp=1319205156161000)
    => (column=nombre, value=6d696775656c, timestamp=1319205140859000)

Obtenemos los datos de super columna con llave *mtriana*, sin embargo, los datos son presentados en hexadecimal (ByteType). Para presentarlos en un formato legible se actualizan los metadatos de las columnas.
<% code(:bash) do %>update column family Usuario                                    
...	with
...	column_metadata =                                               
...	[
...	{column_name: nombre, validation_class: UTF8Type},              
...	{column_name: apellido, validation_class: UTF8Type},
...	{column_name: edad, validation_class: UTF8Type, index_type: KEYS}
...	];

c373ec10-fbed-11e0-0000-242d50cf1ffd
Waiting for schema agreement...
... schemas agree across the cluster
<% end %>

De nuevo se consulta la base de datos:
    get Usuario['mtriana'];
    => (column=apellido, value=triana, timestamp=1319205144832000)
    => (column=edad, value=10, timestamp=1319205156161000)
    => (column=nombre, value=miguel, timestamp=1319205140859000)
    Returned 3 results.

### Consultando la base por otro indice
Cuando modificamos los metadatos de las columnas, también se incluyó un índice para la edad para realizar búsquedas por este parámetro, ahora vamos a consultar la base usando este índice.

    get Usuario where 'edad' = '10';
    -------------------
    RowKey: mtriana
    => (column=apellido, value=triana, timestamp=1319205144832000)
    => (column=edad, value=10, timestamp=1319205156161000)
    => (column=nombre, value=miguel, timestamp=1319205140859000)
    1 Row Returned.

### Listando todos los datos de la CF
Añadimos un usuario y después usamos el comando *list* para obtener todos los datos de la super columna:
<% code(:bash) do %>[default@MiBase] set Usuario['egomez']['apellido'] = 'gomez';                     
Value inserted.
[default@MiBase] set Usuario['egomez']['nombre'] = 'edwin';  
Value inserted.
[default@MiBase] set Usuario['egomez']['edad'] = '15';     
Value inserted.
[default@MiBase] list Usuario;                        
Using default limit of 100
-------------------
RowKey: egomez
=> (column=apellido, value=gomez, timestamp=1319206905155000)
=> (column=edad, value=15, timestamp=1319206929439000)
=> (column=nombre, value=edwin, timestamp=1319206919988000)
-------------------
RowKey: mtriana
=> (column=apellido, value=triana, timestamp=1319205144832000)
=> (column=edad, value=10, timestamp=1319205156161000)
=> (column=nombre, value=miguel, timestamp=1319205140859000)

2 Rows Returned.
<% end %>

## Borrando Columnas y Super Columnas 
Podemos borrar una columna completa de una fila usando el comando `del NombreCF['llaveDeFila']['columna'];`
<% code(:bash) do %>[default@MiBase] del Usuario['mtriana']['nombre']; 
column removed.
[default@MiBase] get Usuario['mtriana'];
=> (column=apellido, value=triana, timestamp=1319205144832000)
=> (column=edad, value=10, timestamp=1319205156161000)
Returned 2 results.
<% end %>

O se puede borrar una fila completa (super columna) con `del NombreCF['nombreDeFila'];
    del Usuario['mtriana'];          
    row removed.

## Eliminando una CF y un Keyspace (KS)
 * Para eliminar una CF: `drop column family NombreCF;`
 * Para eliminar una Base (KS): `drop keyspace NombreKS;` 

<% code(:bash) do %>[default@MiBase] drop column family Usuario;
cbfa22a0-fbf2-11e0-0000-242d50cf1ffd
Waiting for schema agreement...
... schemas agree across the cluster
[default@MiBase] drop keyspace MiBase;
d5b6a890-fbf2-11e0-0000-242d50cf1ffd
Waiting for schema agreement...
... schemas agree across the cluster
<% end %>

## Salir de __cassandra_cli__
    quit;

<hr>
### Referéncias
 * http://wiki.apache.org/cassandra/CassandraCli
 * http://www.datastax.com/docs/0.8/dml/using_cli
