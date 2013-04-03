---
kind: article
title: Flyway, migración de bases de datos
created_at: 2011/04/25
excerpt: Ejemplo de migración de bases de datos para Java
tags: [flyway, migration, database, java, maven]
---
Ejemplo de migración de bases de datos para Java usando <a href='http://code.google.com/p/flyway/' target='_blank'>Flyway</a> y <a href='http://maven.apache.org' target='_blank'>Maven</a>

1. Crear un projecto simple en Maven:
`mvn archetype:create -DgroupId=com.example.db -DartifactId=db-project`
2. Adicionar el plug-in de flyway en el POM
<% code(:xml) do %><build>
  ...
  <plugins>
    <plugin>
      <groupId>com.googlecode.flyway</groupId>
      <artifactId>flyway-maven-plugin</artifactId>
      <version>1.3.1</version>
      <configuration>
        <driver>org.postgresql.Driver</driver>
        <url>jdbc:postgresql://localhost:5432/teste_migration</url>
        <user>postgres</user>
        <password>postgres</password>
        <table>schema_history</table>
        <initialVersion>1.0</initialVersion>
        <initialDescription>Base Migration</initialDescription>
        <baseDir>db/migration</baseDir>
      </configuration>
    </plugin>
  </plugins>
  ...
</build>
<% end %>
3. Adicionar la dependencia del driver de postgres
<% code(:xml) do %><dependency>
  <groupId>postgresql</groupId>
  <artifactId>postgresql</artifactId>
  <version>8.3-603.jdbc3</version>
</dependency>
<% end %>
4. Crear la tabla de versiones: `mvn flyway:init`
5. Crear el directorio de migraciones: `mkdir src/main/resources/db/migration -p` . Esta es la ubicación predeterminada
6. Crear la primera migración: crea el archivo V1.1.first_table.sql en el folder anterior con el siguiente contenido:
<% code(:sql) do %>
CREATE TABLE test_user (
  name VARCHAR(25) NOT NULL,
  PRIMARY KEY(name)
);
<% end %>
7. Migrar la base de datos: `mvn install flyway:migrate`
8. Listo!, para ver el estado de la base de datos ejecutar: `mvn flyway:status`. Maven va a presentar el siguiente resultado:

		[INFO] ------------------------------------------------------------------------
		[INFO] [flyway:status {execution: default-cli}]
		[INFO] +-------------+------------------------+---------------------+---------+
		[INFO] | Version     | Description            | Installed on        | State   |
		[INFO] +-------------+------------------------+---------------------+---------+
		[INFO] | 1.1         | initial tables         | 2011-04-25 11:07:18 | SUCCESS |
		[INFO] +-------------+------------------------+---------------------+---------+
9. Para las siguientes migraciones repetir pasos 6 y 7, siguiendo el patrÓn *Vnumero_descripcion.sql*.
