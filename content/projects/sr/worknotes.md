--- 
title: Speech Recognition on Mobile devices - Work notes
tags: [mobile, speech_recognition, pocketsphinx, cmusphinx]
excerpt: ""
---

Work notes
----------
 - <a href="#setting">Setting up CMUSphinx</a>
 - <a href="#training">Training - Acoustic and Language model creation</a>

### <a name="setting"></a>Setting up CMUSphinx (SphinxTrain, Pocketsphinx, Sphinx3)
In my case, I created a folder for all the projects

	mkdir speech/sphinx
	cd speech/sphinx

*Note:* Since I'm working in a external computer I have no root access, so, any installation will be done on `$HOME`

#### Installing SphinxTrain

	svn co https://cmusphinx.svn.sourceforge.net:/svnroot/cmusphinx/trunk/sphinxbase
	cd sphinxbase/
	./autogen.sh
	./configure --prefix=$HOME
	make
	make install #(optional)
	cd ..
	svn co https://cmusphinx.svn.sourceforge.net:/svnroot/cmusphinx/trunk/SphinxTrain
	cd SphinxTrain/
	./configure
	make
	cd .. #comming back to sphinx folder

#### Installing Pocketsphinx

	svn co https://cmusphinx.svn.sourceforge.net/svnroot/cmusphinx/trunk/pocketsphinx
	cd ../pocketsphinx/
	./autogen.sh
	./configure --prefix=$HOME
	make
	make install
	cd .. #comming back to sphinx folder

#### Installing Sphinx3

	svn co https://cmusphinx.svn.sourceforge.net/svnroot/cmusphinx/trunk/sphinx3
	cd ../sphinx3/
	./autogen.sh
	./configure --prefix=$HOME
	make
	make install
	cd .. #comming back to sphinx folder

### <a name="training"></a>Training - Acoustic and Language model creation
The following are related links for training process:
- <a href="http://www.bakuzen.com/?p=16" target="_blank">Acoustic Model Creation using _SphinxTrain_</a>
- <a href="http://cmusphinx.sourceforge.net/wiki/tutorialam" target="_blank">Training Acoustic Model For _CMUSphinx_</a>
- <a href="http://ronaldramdhan.wordpress.com/2010/03/11/sphinxtrain/" target="_blank">How to use _SphinxTrain_</a>
