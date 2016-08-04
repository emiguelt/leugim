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

## Known problems

* Executing tests from console, not from IDE


