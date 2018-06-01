--- 
kind: article
title: Programando con Qt/C++ - Tips
created_at: 2011/08/23
excerpt: Algunas recomendaciones que me han parecido importantes durante el desarrollo con Qt 4.X
tags: [qt, c++]
updated_at: 2011/08/23
publish: false
---

Las recomendaciones en esta publicación estan basadas en experiencias propias y en libros como _Foundations of Qt Development_

### Signals and Slots

* Setter methods are natural slots. By making all setters slots, you guarantee that you can connect signals to all interesting parts of your class. The only time when a setter should not also be a slot is when the setter accepts some very custom type that you are sure will never come from a signal.

* When matching arguments, the match is checked only for the arguments accepted by the slot. This means that a slot that does not take any arguments matches all signals. The arguments not accepted by the slot are simply dropped by the signal-emitting code.

