--- 
kind: article
title: Jade, Backbone.js and Require.js, a running example
created_at: 2013/11/30
excerpt: This is an example of Jade (runtime) integration with Backbone.js with RequireJS
tags: [jade, backbone.js, require.js, jade-amd, runtime.js, client-side]

publish: true
---

I like <a href='http://jade-lang.com/' target='_blank'>Jade</a> a lot for HTML templating. Currently I'm learning Backbone.js, so after a couple of examples I wanted to use Jade for HTML generation as well as HTML template engine in the client-side. During my searching I didn't found a concrete example using the three technologies (Jade, Backbone and Require), so with this post I want to give some clues to use them successfully.

## The example

The example is the typical TODO application. The original code is from the <a href='http://addyosmani.github.io/backbone-fundamentals/#exercise-3-your-first-modular-backbone-requirejs-app' target='_blank'>example 3</a> of the book Developing Backbone.js (by Addy Osmani). The final code can be checked <a href='https://github.com/emiguelt/javascriptLearning/tree/master/backbone/dbba_todos_requirejs' target='_blank'>here</a>.

## Configuring Jade
### HTML generation

The start page (_index.html_) is generated with _Jade_ and the _index.jade_ file.
    jade -P -o ./deploy ./app/index.jade

### Jade templates on client-side
There is a Jade browser-compatible version to compile the Jade templates on the cliente-side, but it is advisable to compile the jade files (as javascript) on the server-side and execute them on the browser. For this reason runtime.js to is used to merge the jade-compiled files.

Runtime.js is AMD-compatible, but compiled templates are anonymous functions, so <a href='https://github.com/mysociety/node-jade-amd' target:'_blank'>node-jade-amd</a> is used to generate require.js-compatible functions.
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

Once the templates have been compiled on the server-side, now we can call them at the client_side via require.js on the module definition:

    define(['templates/my_jade_compiled_witout_dotjs'], function(templatesVariable){
      template: templateVariable,...

_templateVariable_ is a function that receives the model to be merged with the template. It is no necessary  _jadeRuntime_ on the module definition since it is called  in the template compiled with _jade-amd_.

Then it could be invoked in the _render_ method to generate the HTML

    ...
    render: function(){
      this.$el.html(this.template(this.model.toJSON())); 
      },
    ...


### Deploy
The _Makefile_ defines how the application is organized on the client side. 
    - deploy
    |- index.html //Jade-generated
    |- css
    |- js
       |- collections // backbone
       |- libs // jadeRuntime.js (runtime.js from Jade renamed), other libs (backbone, underscore, etc)
       |- models //backone
       |- templates  // js jade-compiled with jade-amd
       |- routers //backbone
       |- views //backone
       |- main.js // require config, app start
       |- common.js //utils

That's all. For more details about the implementation, please check the full example <a href='https://github.com/emiguelt/javascriptLearning/tree/master/backbone/dbba_todos_requirejs' target='_blank'>here</a>. 
