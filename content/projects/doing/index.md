---
title: Doing!
tags: [mobile, doing, pomodoro, timer]
excerpt: ""
---
What is the Pomodoro Technique?
-------------------------------

The _Pomodoro Technique_ is a way to get the most out of time management. Turn time into a valuable ally to accomplish what we want to do and chart continuous improvement in the way we do it. <sup>1</sup>

What is _Doing_ ?
------------------
![Doing][7] is a _Java ME_ software that will implement the features of the Pomodoro Technique.

_Doing!_ is an Open Source software, the source is hosted in Sourceforge (<a href="https://sourceforge.net/projects/doing/" target="_blank">Go...</a>).

Current features ![Doing][6]
-----------------

1. Pomodoro timer, with a 25 minutes per pomodoro, 5 minutes per break and 15 minutes for a longer break every 4 pomodoros.

2. _Doing!_ reads the _ToDo list_ of the Mobile device to show it in the software interface. You can choose an activity to set as _current activity_ and start the pomodoro timer.

3. When a Pomodoro or a Break ends, the mobile will vibrate and reproduce a tone. Next cycle will start automatically.

4. Task can be completed directly in the interface. 

5. Current version: alpha 0.0.6

Getting started with _Doing!_
-----------------------------

1. Download the software from the following link, from the mobile device, or download from a PC and copy to device.
  * <a href="https://sourceforge.net/projects/doing/files/current/Doing.jad/download" target="_blank">Doing.jad</a>
  * <a href="https://sourceforge.net/projects/doing/files/current/Doing.jar/download" target="_blank">Doing.jar</a>

2. Install the Doing.jar

3. When _Doing!_ is installed the executable is called **Doing**. 

4. Execute the Doing. When you start the application it will request permissions to access the phone data (the To Do list), you must agree in order to _Doing!_ reads the activity list

5. If _Doing!_ can get the activity list, you will see a screen as the following:
 <center> ![Initial screenshot][1]</center>
 If is not possible to get the ToDo list, you can use _Doing!_ like a Pomodoro timer.

6. Select an activity and set it as _current_
 <center>![Set current activity][2]</center>

7. Start the timer by pressing the "Play" command

8. The Title bar will show the current status of the application (in Pomodoro or in Break)
 <center>![Pomodoro][3] ![Break][4] </center>

9. If you change the current activity when the timer is running, Doing will restart the timer.

10. A **new** configured panel has been added. There you can enable/disable vibration, tone and backlight alerts.
 <center>![Configuration panel][5]</center>

11. **New** configurable pomodoro tab, here you can customize the duration of the pomodoros, breaks and extended breaks
 <center>![Pomodoro configuration][8]</center>

----------
<sub>1. http://www.pomodorotechnique.com/
</sub>


  [1]: /assets/doing/screen1.png
  [2]: /assets/doing/setCurrent.jpg
  [3]: /assets/doing/pomodoro.jpg
  [4]: /assets/doing/break.jpg
  [5]: /assets/doing/screen2.png
  [6]: /assets/doing/doingIcon.png
  [7]: /assets/doing/doingLogo.png
  [8]: /assets/doing/screenTabPom.png


<div id="disqus_thread"></div><script type="text/javascript" src="http://disqus.com/forums/emiguelwebpage/embed.js"></script><noscript><a href="http://disqus.com/forums/emiguelwebpage/?url=ref">View the discussion thread.</a></noscript><a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>

<script type="text/javascript">
//<![CDATA[
(function() {
	var links = document.getElementsByTagName('a');
	var query = '?';
	for(var i = 0; i < links.length; i++) {
	if(links[i].href.indexOf('#disqus_thread') >= 0) {
		query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
	}
	}
	document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/emiguelwebpage/get_num_replies.js' + query + '"></' + 'script>');
})();
//]]>
</script>
