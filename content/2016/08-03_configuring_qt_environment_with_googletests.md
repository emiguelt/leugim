---
kind: article
title: Configuring Qt environment for Mobile development with TDD
create_at: 2016/08/03
excerpt: Code once, deploy any platform. That is the premise of Qt/C++. In this post I'm going to put all information related to start developing for Android and Desktop using Qt since there are missing steps about
tags: [qt, c++, android, mobile]
publish: true
---

__IN PROGRESS...__

## Project structure

    root   
    |- root.pro       <--- multiproject
    |- src
       |- source.pro  <--- lib project
    |- app
       |- app.pro     <--- Desktop/mobile app
    |- tests
       |- tests.pro   <--- Console project

## Configuring GoogleTest framework

* Download and compile google tests
* Add library to project
* Execute tests

### Links
* https://github.com/google/googletest/blob/master/googletest/docs/Primer.md
* http://ninetyninefree.blogspot.com.co/2016/02/using-google-test-framework-with-qt.html

## Testing signals & slots
* http://stackoverflow.com/questions/33829949/how-to-use-qtimers-in-googletest
* http://stackoverflow.com/questions/35509374/qt-test-how-to-stop-execution-when-a-signal-is-emitted
*
## Known problems

* Executing tests from console, not from IDE
* Executing from console needs extra import: http://www.qtcentre.org/threads/26934-Can-t-run-executable-file-directly-Cannot-open-shared-object-file

