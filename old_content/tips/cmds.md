---
kind: article
title: Commands summary
created_at: 2011/10/21
excerpt: Commands reference for develoment with Maven, Git, Ant, SVN, CVS, VirtualBox, etc.
tags: [maven, git, cvs, tips, virtualbox, bash]
---
# Commands reference for development
## Maven

* New project:
      mvn archetype:generate \
      -DarchetypeGroupId=org.apache.maven.archetypes \
      -DgroupId=com.mycompany.app \
      -DartifactId=my-app
* mvn compile
* mvn test
* mvn install
* MAVEN_HOME in Ubuntu: `/usr/share/maven2/`
* Skip test in maven: add parameter `-DskipTests=true` in the command

## Git
* Import from CVS (install git-cvs)
      mkdir tempTest
      cd tempTest
      git cvsimport -v -d :pserver:username@cvs.sourceserver.com:/path/to/cvs module
* Edit a Tag and resend to the server
      git tag TAGNAME -f
      git push --tags
* Add origin for RW in GitHub (must have the keyfile configured)
      git remote add origin git@github.com:username/projectname.git
* Save local modifications in a temporal place to be able to push
      git stash #creates a stash git the changes
      git stash pop #get the changes back and merge
* Delete a remote tag
      git tag -d TAGNAME
      git push origin :refs/tags/TAGNAME
* Show current branch in the shell: Add
      PS1="\u@\h:\w\$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/{\1}/') \$ "
    to `~/.profile` or `~/.bashrc` <br/>
    Ref: _http://gregk.me/2011/display-active-git-branch-in-bash-prompt/_

## Bash
* Get an error in bash
      if [ "$?" -ne 0 ]; then echo "command failed"; exit 1; fi
* Execute a script when Ubuntu starts or define a variable: add the script to `~/.profile`
* Send a task to background: `echo "executableToBackground" | at now`
* Monitor file changes (like server logs): `tail -f logfilePath`

## VirtualBox
* Start a VM without GUI
      VBoxManage startvm --type headless VMNAME
* Shutdow a VM from console
      VBoxManage controlvm VMNAME poweroff
