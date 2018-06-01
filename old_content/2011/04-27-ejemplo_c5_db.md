---
kind: article
title: c5-db-migration, migración de bases de datos
created_at: 2011/04/25
excerpt: Ejemplo de migración de bases de datos para Java
tags: [c5-db, migration, database, java, maven]
---
Ejemplo de migración de bases de datos para Java usando <a href='http://code.google.com/p/c5-db-migration/' target='_blank'>C5-DB-Migration</a> y <a href='http://maven.apache.org' target='_blank'>Maven</a>

1. Crear un projecto simple en Maven:
`mvn archetype:create -DgroupId=com.example.db -DartifactId=db-project`
2. Adicionar el repositorio de Carbonfive
<% code(:xml) do %><project ...>
  ...
  <pluginRepositories>
    <pluginRepository>
      <id>c5-public-repository</id>
      <url>http://mvn.carbonfive.com/public</url>
    </pluginRepository>
  </pluginRepositories>
  ...
  <build>
  ...<!-- Plugin -->
  </build>
</project>
<% end %>
3. Adicionar el plug-in de C5-DB en el POM y el repositorio de CarbonFive
<% code(:xml) do %><build>
  ...
  <plugins>
    <plugin>
      <groupId>com.carbonfive.db-support</groupId>
      <artifactId>db-migration-maven-plugin</artifactId>
      <version>RELEASE</version>
      <configuration>
        <url>jdbc:postgresql://localhost:5432/teste2_migration</url>
        <username>postgres</username>
        <password>postgres</password>
        <migrationsPath>${basedir}/src/c5_db/migrations</migrationsPath>
      </configuration>
      <dependencies>
        <dependency>
          <groupId>postgresql</groupId>
          <artifactId>postgresql</artifactId>
          <version>8.3-603.jdbc3</version>
        </dependency>
      </dependencies>
    </plugin>
  </plugins>
  ...
</build>
<% end %>
4. Crear el directorio de migraciones: `mkdir src/c5_db/migrations -p` . Esta ubicación fue configurada en el plugin.
5. Crear la primera migración: Usar el comando `mvn db-migration:new -Dname=nombre_de_migracion`. Este comando crea un archivo *sql* siguiendo el modelo *YYYYMMDDHHMMSS_nombre_de_migracion.sql*.
		mvn db-migration:new -Dname=base_inicial
6. Adicionar al archivo creado anteriormente el siguiente contenido:
<% code(:sql) do %>CREATE TABLE test_user (
  name VARCHAR(25) NOT NULL,
  PRIMARY KEY(name)
);
<% end %>
7. Migrar la base de datos: `mvn db-migration:migrate`. El resultado es el siguiente:
		[INFO] Building db-project
		[INFO]    task-segment: [db-migration:migrate]
		[INFO] ------------------------------------------------------------------------
		[INFO] [db-migration:migrate {execution: default-cli}]
		[INFO] Migrating jdbc:postgresql://localhost:5432/teste2_migration using
		migrations at /path/to/project/db-project/src/c5_db/migrations.
		[INFO] Loaded JDBC driver: org.postgresql.Driver
		[INFO] Successfully enabled migrations.
		[INFO] Migrating database... applying 1 migration.
		[INFO] Running migration 20110428010126_base_inicial.sql.
		[INFO] Migrated database in 0:00:00.094.
		[INFO] ------------------------------------------------------------------------

8. Listo!, para revisar si base de datos esta actualizada y ver las migraciones pendientes, ejecutar: `mvn db-migration:validate`. Maven va a presentar un resultado similar al siguiente:

		[INFO] ------------------------------------------------------------------------
		[INFO] Building db_migration Maven Webapp
		[INFO]    task-segment: [db-migration:validate]
		[INFO] ------------------------------------------------------------------------
		[INFO] [db-migration:validate {execution: default-cli}]
		[INFO] Validating jdbc:postgresql://localhost:5432/teste2_migration
		using migrations at /path/to/project/src/db_migration/src/c5_db/migrations.
		[INFO] Loaded JDBC driver: org.postgresql.Driver
		[INFO] 
        Database: jdbc:postgresql://localhost:5432/teste2_migration
		      Up-to-date: true
			Pending Migrations: 
		[INFO] ------------------------------------------------------------------------
9. Para las siguientes migraciones ejecutar los pasos 5 a 7.

También es posible verificar el estado de la base de datos y emitir un error durante la construcción del projecto si hay migraciones pendientes, adicionando el siguiente código en la configuración del plugin:
<% code(:xml) do %><executions>
  <execution>
    <phase>validate</phase>
    <goals>
      <goal>check</goal>
    </goals>
  </execution>
</executions>
<% end %>
