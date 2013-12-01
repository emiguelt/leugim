--- 
kind: article
title: Jade, Backbone.js and Require.js briefly
created_at: 2013/11/30
excerpt: This is an example of Jade (runtime) integration with Backbone.js with RequireJS
tags: [jade, backbone.js, require.js, jade-amd, runtime.js]
publish: true
---

I like a lot <a href='http://jade-lang.com/' target='_blank'>Jade</a> for HTML templating. Currently I'm learning Backbone.js, so after a couple of examples I wanted to use Jade for HTML generation as well as HTML template engine in the client-side. During my searching I didn't found a concrete example using the three technologies (Jade, Backbone and Require), so with this post I want to give some clues to use them successfully.

## The example

The example is the typical TODO application. The original code is from the <a href='http://addyosmani.github.io/backbone-fundamentals/#exercise-3-your-first-modular-backbone-requirejs-app' target='_blank'>example 3</a> of the book Developing Backbone.js (by Addy Osmani). The final code can be checked <a href='https://github.com/emiguelt/javascriptLearning/tree/master/backbone/dbba_todos_requirejs' target='_blank'>here</a>.

## Configuring Jade
### HTML generation
The start page (_index.html_) is generated with _Jade_ and the _index.jade_ file.
    jade -P -o ./deploy ./app/index.jade

### Jade templates on client-side
There are a Jade browser-compatible version to compile the Jade templates on the cliente-side, but it is advisable to compile the jade files (as javascript) on the server-side and execute them on the browser. For this reason I used the runtime.js to use the jade-compiled files.

Runtime.js is AMD-compatible, but compiled templates are anonymous functions, so <a href='https://github.com/mysociety/node-jade-amd' target:'_blank'>node-jade-amd</a> is used to generate require.js compatible functions.
    jade-amd  --from app/templates --to deploy/js/templates

## Integrating Jade and Backbone.js with Require.js
Underscore.js is the default Backbone templating engine. It is ovewritten by loading the runtime.js (from Jade) and calling the jade-compiled files in the module definitions.
### require.config

    require.config({
      shim: {
        backbone:{
          deps:['jquery'],
          exports: 'Backbone'
        }
      },
      paths:{
        jquery: 'libs/jquery.min',
        backbone: 'libs/backbone-min',
        "backbone.localStorage": 'libs/backbone.localStorage',
        underscore: 'libs/underscore-min',
        jadeRuntime: 'libs/jadeRuntime',
      }
    });

* Backbone is not AMD-compatible, so Require's _shim_ feature is used
* The _paths_ config says to require.js where required .js files are located (note that just external files are referenced)
* runtime.js calls _define_ method from require.js without name, so it is configured with the file's name, so I renamed it to _jadeRuntime.js_ because it is the default name used with _node-jade-amd_ compiled templates.

### Using jade-compile files in Backbone.js with Require.js
### Deploy
