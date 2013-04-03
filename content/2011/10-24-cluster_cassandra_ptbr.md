---
kind: article
title: Criando um cluster de Cassandra
create_at: 2011/10/24
excerpt: Criação de um cluster de cassandra para testes e desenvolvimento.
tags: [nosql, cassandra, cluster]
publish: false
---
Vamos configurar um cluster com 3 maquinas virtuais com Cassandra usando VirtualBox. Este cluster pode ser usado depois para desenvolvimento e teste de aplicações que utilizem esta tecnologia.

## Pre-requisítos e configurações inicias:
 * O host vai ser um Ubuntu 11.10 (32-bit)
 * Os guest vão ser Ubuntu Server 11.04 (32-bit), não tinha o último e ia demorar muito baixá-lo...rsrs
 * Vamos usar Oracle - VirtualBox 4.1.4
 * Assumese conhecimento básico de VirtualBox, Linux e Cassandra (bem básico, tudo bem!).

## Criar a máquina virtual
### Configurar la maquina como Bridge
## Instalar Cassandra
__1. Instalar Java__
    sudo apt-get install python-software-properties
    sudo add-apt-repository ppa:ferramroberto/java
    sudo apt-get update
    sudo apt-get install sun-java6-jdk
__2. Baixar Cassandra__
    wget http://linorg.usp.br/apache//cassandra/1.0.0/apache-cassandra-1.0.0-bin.tar.gz
__3. Descompactar__
    cd /opt
    sudo tar -xvvzf ~/apache-cassandra-1.0.0-bin.tar.gz
__4. Criar usuario Cassandra__
    sudo groupadd -g 501 cassandra
    $ sudo useradd -m -u 501 -g cassandra -d /home/cassandra -s /bin/bash \
    > -c "Cassandra Software Owner" cassandra
    $ id cassandra
    uid=501(cassandra) gid=501(cassandra) groups=501(cassandra)
__5. Criar pastas para dados e logs
    sudo mkdir /opt/cassandra
    sudo mkdir /opt/cassandra/data
    sudo mkdir /opt/cassandra/commitlog
    sudo mkdir /opt/cassandra/saved-caches
__6. Incluir no .bashrc__
    export JAVA_HOME=/usr/lib/jvm/java-6-sun
    export CASSANDRA_HOME=/opt/apache-cassandra-1.0.0
    export CASSANDRA_PATH=$CASSANDRA_HOME/bin
    export PATH=$CASSANDRA_PATH:$PATH
## Configurar cassandra
__1. Configurar o arquivo conf/cassandra.yaml__
    # directories where Cassandra should store data on disk.
    data_file_directories: 
        - /opt/cassandra/data

    # commit log
    commitlog_directory: /opt/cassandra/commitlog

    # saved caches
    saved_caches_directory: /opt/cassandra/saved_caches

    ...

    # seeds is actually a comma-delimited list of addresses.
          # Ex: "<ip1>,<ip2>,<ip3>"
          - seeds: "192.168.1.105, 192.168.1.106"

    #Listen address
    listen_address: 
    #rpc address 0.0.0.0 para escutar em todas as interfaces
    rpc_address: 0.0.0.0
__2. Configurar Log4j__
    vim conf/log4j-server.properties
Modificar:
    log4j.appender.R.File=/opt/cassandra/logs/system.log
    
## Probar la configuração
__1. Teste em foreground__
    ./bin/cassandra -f
    ---
    INFO 17:11:14,102 Logging initialized
    INFO 17:11:14,106 JVM vendor/version: Java HotSpot(TM) Client VM/1.6.0_26
    INFO 17:11:14,106 Heap size: 253558784/253558784
    INFO 17:11:14,106 Classpath: /opt/apache-cassandra-1.0.0
    ...
    INFO 17:11:16,253 Listening for thrift clients...

__2. Acessar via cassandra_cli
   ./bin/cassandra-cli --host 192.168.1.105 --port 9160
    Connected to: "Test Cluster" on 192.168.1.105/9160
    Welcome to the Cassandra CLI.

    Type 'help;' or '?' for help.
    Type 'quit;' or 'exit;' to quit.
    quit;

## Configuração inicio automático
__1. Criar o arquivo /etc/init.d/cassandra__ com o segunte:
<% code(:c) do %>#!/bin/bash
#
# /etc/init.d/cassandra
#
# Startup script for Cassandra
#

export JAVA_HOME=/usr/lib/jvm/java-6-sun
export CASSANDRA_HOME=/opt/apache-cassandra-1.0.0
export CASSANDRA_PATH=$CASSANDRA_HOME/bin
export PATH=$CASSANDRA_PATH:$PATH
export CASSANDRA_OWNR=cassandra

log_file=/opt/cassandra/logs/stdout
pid_file=/opt/cassandra/logs/pid_file

if [ ! -f $CASSANDRA_HOME/bin/cassandra -o ! -d $CASSANDRA_HOME ]
then
    echo "Cassandra startup: cannot start"
    exit 1
fi

case "$1" in
    start)
        # Cassandra startup
        echo -n "Starting Cassandra: "
        su $CASSANDRA_OWNR -c "$CASSANDRA_HOME/bin/cassandra -p $pid_file" > $log_file 2>&1
        echo "OK"
        ;;
    stop)
        # Cassandra shutdown
        echo -n "Shutdown Cassandra: "
        su $CASSANDRA_OWN -c "kill `cat $pid_file`"
        echo "OK"
        ;;
    reload|restart)
        $0 stop
        $0 start
        ;;
    status)
        ;;
    *)
        echo "Usage: `basename $0` start|stop|restart|reload"
        exit 1
esac

exit 0
<% end %>

## Novos nós
1. Clonar (clonação completa)
2. Arreglar la mac_address de eth0
3. Set hostname (/etc/hostname /etc/hosts)
4. Configurar cassandra.yaml

<hr>
### Referências
 * http://posulliv.github.com/2009/09/07/building-a-small-cassandra-cluster-for-testing-and-development.html
 * http://linuxservertutorials.blogspot.com/2009/02/how-to-change-hostname-in-ubuntu-server.html
 * http://www.serenux.com/2009/11/howto-fix-a-missing-eth0-adapter-after-moving-ubuntu-server-from-one-box-to-another/
