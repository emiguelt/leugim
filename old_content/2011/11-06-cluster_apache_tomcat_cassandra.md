---
kind: article
title: Cluster Apache, Tomcat, Cassandra
create_at: 2011/11/06
excerpt: Criação de um cluster completo Apache/Tomcat, Cassandra básico.
tags: [nosql, cassandra, cluster, apache, tomcat]
publish: false
--- 
## Apache
### Clonar imagen
 * editar hostname, hosts, mac
### instalar apache: 
    sudo apt-get install apache2
    sudo apt-get install libapache2-mod-jk
 * testar no browser: http://192.168.1.105 -> It works!
## Tomcat 1
### Clonar imagen
 * Igual que Apache
### Instalar tomcat6
    sudo apt-get install tomcat6 
 * testar no browser: http://192.168.1.107:8080 -> It Works!
#### configurar tomcat6
 * editar o arquivo /etc/tomcat6/server.xml
  * descomentar
    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
    <Engine name="Catalina" defaultHost="localhost" jvmRoute="tomcat1">

      <!--For clustering, please take a look at documentation at:
          /docs/cluster-howto.html  (simple how to)
          /docs/config/cluster.html (reference documentation) -->
      
      <Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"/>

## Tomcat 2
 1. Clonar imagen de Tomcat 1
 2. Editar hostname, hosts, rules /apagar e iniciar de nuevo
 3. Editar /etc/tomcat6/server.xml (trocar o nome do jvmRoute para tomcat2)
 4. Incluir la nueva ip en apache workers.properties

## Configurar Apache
### workers.properties
### jk.load
### JkMountCopy em sites-enabled
## Testing jk_status
poner imagen de jk_status

## Cassandra (2 hosts)
 * ver tutorial xxx
 * update seeds

## Servlet para testes

## References
* http://www.serenux.com/2009/11/howto-fix-a-missing-eth0-adapter-after-moving-ubuntu-server-from-one-box-to-another/
* http://linuxservertutorials.blogspot.com/2009/02/how-to-change-hostname-in-ubuntu-server.html
* http://posulliv.github.com/2009/09/07/building-a-small-cassandra-cluster-for-testing-and-development.html
