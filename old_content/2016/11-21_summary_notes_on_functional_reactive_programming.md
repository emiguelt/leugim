---
kind: article
title: Summary - Notes on Functional Reactive programming
create_at: 2016/11/21
excerpt: Summary from "Notes on reactive programming Spring blog"
tags: [functional, programming, java, reactive, React]
publish: true
---

# PART I

https://spring.io/blog/2016/06/07/notes-on-reactive-programming-part-i-the-reactive-landscape

Intelligent routing of events

## Use cases

* External Service Calls: make REST call to heavy services that could block the thread.
* Highly Concurrent message Consumers: Processing through message sending
* Spreadsheets: Set dependencies to execute events that trigger chains of events
* Abstraction Over (A)synchronous Processing

## Comparisons

* Ruby Event-machine: Event machine for heavy IO applications
* Actor model: like Akka
* Deferred results (Futures): from Java 1.5 concurrent api
* Map-reduce and fork-join
* Coroutines: building blocks for higher abstractions like actors or streams

## Reactive Programming in Java
Coroutines are not native in java, until JDK 9. 

* Reactive streams: Java 9
* RxJava: Netflix library. Good for Java 8 'cause the lambdas
* Reactor: Java framework from Pivotal. Build on Reactive Streams
* Spring framework 5.0: Uses Reactor, but can use RxJava too.
* RatPack: Libraries for High performance services over HTTP. Built on Netty. Can use different Reactive Streams.
* Akka: Actor model for java or scala. Uses Akka streams or Reactive streams

Why now?
"The promise of Reactive is that you can do more with less, specifically you can process higher loads with fewer threads. This is where the intersection of Reactive and non-blocking, asynchronous I/O comes to the foreground."

# PART II

`https://spring.io/blog/2016/06/13/notes-on-reactive-programming-part-ii-writing-some-code`

*Source code*: `https://github.com/emiguelt/funprog/tree/master/notesOnReactive`

_Reactive programming_ is composed of a sequence of _events_, a _publisher_ and a _suscriber_. The sequence of events are also called _Streams_.

In _ProjectReactor_ a publisher is a *Flux*  (_Observable_ in RxJava)

* _Generators_: A Flux generates events of a T type (Generics), and has static factory methods.
* _Single valued sequences_: For Streams with zero or one element it is used _Mono_ class.
* _Operators_: Make operations with/over stream's elements, like `.log()` or `.map()`.

<b></b>
    
    Flux<String> flux = Flux.just("juan", "pedro", "maria");
    flux.log().map(String::toUpperCase);

   *Note:* No data is processed until the flux has at least one subscriber (then the data starts to flow)(Use one of the _suscribe()_ methods)

* _Suscribers_: The _suscribe()_ methods return operators (if any) and request the flux to start generating data. _Subscribe()_ methods are overridden, so there are a lot of options to start the flux. One options is to pass a function for the _onNext()_ methods or pass a full subscriber.

   * Use _doOn*_ methods to listen for specific events of the flux
   * _Subscribe()_ methods are overridden with a lot of options, for example, receiving a function for the _onNext_ event or to receive the full Subscriber.

<b></b>

    flux.subscribe() //basic subscription, no listeners
    flux.subscribe(System.out::println())  //onNext listener
    flux.subscribe(new Subscriber(){...impl...}) //custom subscriber

### Batching

The _Subscription_ could be used to control the Flux flow, for example to control the number of requests.

    flux.subscribe(new Subscriber(){
      @Override
      public void onSubscribe(Subscription subs){
        subs.request(2);
      }
    }

Since it is a very common used pattern, there is _subscribe()_ method for that

    Flux.just("red", "white", "flue")
      .log()
      .map(String::toUpperCase)
      .subscribe(null, 2);

### Concurrent processing
_Reactor_ optimizes the use of threads and give us the control of the async processing exposing some configurer methods, for examploe `Flux.subscribeOn(Schedulers.parallel())`

`Schedulers.parallel()` will send the flow processing to a brackground thread (just one), to create more threads, it is necessary to specify it by subscriber:

### Extractors: the Dark side

Use extractors to pass from Reactor benefits to blocking side. Use it for Legacy APIs.
