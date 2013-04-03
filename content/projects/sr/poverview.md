--- 
title: Speech Recognition on Mobile devices - problem overview
tags: [mobile, speech_recognition]
excerpt: ""
---
Speech Recognition on Mobile devices
----------

<h2><a name="poverview">Problem overview</a></h2>

<P>
The use of mobile devices in daily activities has become something common. They are used in small tasks like memo taking, address books and multimedia players, or more complex task like calendar managers and web browsing. An example of a more sophisticated application is the Borboleta system, a J2ME project in development to collect medical information in the primary care program of the Brazilian health system SUS [<A
 HREF="#Correia2008">3</A>]. This work examines human computer interaction for the  Borboleta system and the implementation of an automatic speech recognition (ASR) module to the navigation schema.
</p>
<P>
The massive increase in the use of mobile devices and their many applications have come with new scientific challenges. In electronics, these include developing higher performance equipment with greater memory, improving screen resolution and including new features, such GPS, Bluetooth and WIFI. In computer science, challenges require developing robust applications with user-friendly interfaces and making better use of hardware resources. Mobile devices allow a range of input options, from T9 keyboards to multi-touch screens, to qwerty keyboards. Touch screens can allow option section and/or handwriting detection. Some devices include accelerometers and global position information. Output can range from black and white to multicolor screens and can include animation, sounds and vibration.
</p>
<P>
Some very useful or important applications require user attention and focus to produce correct input or perceive device output. However, when these are done in combination with important tasks, there can be detrimental effects to the task at hand as well as to the data input. An example is getting directions form a GPS system while driving in a large city, writing a destination address and reading the map result in a 5 inch screen. An approach that tries to reduce this type of problem is the use of multimodal interfaces, involving different input and output methods to reduce the required attention level by making the device easier to use. An example of this approach is the use of speech recognition as an input method along with a touch screen and speech synthesis to indicate system response.
</p>
<P>
One advantage of using voice input is that it is a natural skill and does not require much attention or direct observation to use the device, allowing increased attention to others activities []. Other advantages are the reduction of hand use or keyboard interaction to input information. This makes access easier for handicapped persons. Nevertheless, using voice input for interaction has some challenges like environment noise, speech accent, large vocabularies, low quality microphones and device capability in voice processing.  In the last twenty years robust speech recognition systems have addressed these problems. Examples are HTK [<A
 HREF="#Odell1995">8</A>] and Sphinx 4 [<A
 HREF="#Walker2004">15</A>], which have very acceptable performance levels with low word error rates [<A
 HREF="#Schmitt2008">12</A>], but these systems were developed for desktop computers with good processing resources.  
</p>
<P>
A typical speech recognition system is composed of two phases, a front-end and a back-end. The front-end module process the voice signal to get observation vectors that are be used in training and recognition [<A
 HREF="#Bates1">1</A>]. The back-end module is comprised of a word search, combining information from acoustic and language models. 
</p>
<P>
In mobile devices, the limited processing and storage resources make the implementation of voice recognition systems difficult. Because the system consists of two phases, it can be decoupled. Possible approaches for implementing ASR include embedded terminal systems (ETS), network speech recognition systems (NSR) and distributed speech recognition systems (DSR). An ETS has full ASR enbedded in the device. This system often has a small vocabulary does not require external communication. In the NSR the front-end and the back-end are on the server and the mobile device transmits the speech signal to the server Results could be returned to the mobile device. The main advantage of an NSR is  larger resources which allow the use of large vocabularies with low word error rates. On DSR systems the front-end is embedded in the mobile device and the back-end is on a server. The device extracts the observation vectors and sends these to the server where they are recognized. An advantage of DSR over NSR is the low band used in the communication process, because the vectors are samller than the waveforms. 
</p>
<P>
Borboleta is a system for collecting patient information using mobile devices and requires a high level of user attention. During a medical visit, the doctors must attend to the patients, check theirs health conditions and at the same time input this information to the device. For this reason, the objective is to implement a speech recognition system  that helps healthcare professionals in of their work by reducing the level of attention required by device interaction during the medical visits, letting the user focus on the more important activity of patient care.
</p>

<H2>Bibliography</H2>
<DL COMPACT><DD><P></P><DT><A NAME="Bates1">1</A>
<DD>
Rebecca&nbsp;Anne Bates.
<BR><EM>Speaker dynamics as a source of pronunciation variability for
  continuous speech recognition models</EM>.
<BR>PhD thesis, University of Washington, 2003.

<P></P><DT><A NAME="Cohen2008">2</A>
<DD>
J.&nbsp;Cohen.
<BR>Embedded speech recognition applications in mobile phones: Status,
  trends, and challenges.
<BR>In <EM>Acoustics, Speech and Signal Processing, 2008. ICASSP 2008.
  IEEE International Conference on</EM>, pages 5352-5355, 2008.

<P></P><DT><A NAME="Correia2008">3</A>
<DD>
Rafael Correia, Fabio Kon, and Rubens Kon.
<BR>Borboleta: A mobile telehealth system for primary homecare.
<BR><EM>23rd ACM Symposium on Applied Computing</EM>, 2008.

<P></P><DT><A NAME="Goodman2002">4</A>
<DD>
J.&nbsp;Goodman, G.&nbsp;Venolia, K.&nbsp;Steury, and C.&nbsp;Parker.
<BR>Language modeling for soft keyboards.
<BR><EM>Proc. AAAI 2002</EM>, 2002.

<P></P><DT><A NAME="Hetherington2007">5</A>
<DD>
I.L. Hetherington.
<BR>Pocketsummit: small footprint continuous speech recognition.
<BR><EM>INTERSPEECH 2007</EM>, 2007.

<P></P><DT><A NAME="Huggins-Daines2006">6</A>
<DD>
D.&nbsp;Huggins-Daines.
<BR>Pocketsphinx: a free real-time continuous speech recognition system
  for hand-held devices.
<BR><EM>Proc. ICASSP 2006</EM>, pages 185-188, 2006.

<P></P><DT><A NAME="Lumsden2008">7</A>
<DD>
J.&nbsp;Lumsden.
<BR><EM>Handbook of research on user interface design and evaluation for
  mobile technology</EM>.
<BR>Idea Group, 2008.

<P></P><DT><A NAME="Odell1995">8</A>
<DD>
J.&nbsp;Odell, D.&nbsp;Ollason., and P.&nbsp;Woodland.
<BR><EM>The HTK book for HTK V2.0</EM>.
<BR>Cambridge University Press, 1995.

<P></P><DT><A NAME="Price2006">9</A>
<DD>
J.&nbsp;Price, Min Lin, Jinjuan Feng, Rich Goldman, Andrew Sears, and A.&nbsp;Jacko.
<BR>Motion does matter: an examination of speech-based text entry on the
  move.
<BR><EM>Univers. Access Inf. Soc.</EM>, 4(3):246-257, 2006.

<P></P><DT><A NAME="Rose2003">10</A>
<DD>
R.&nbsp;C. Rose, I.&nbsp;Arizmendi, and S.&nbsp;Parthasarathy.
<BR>An efficient framework for robust mobile speech recognition services.
<BR><EM>Proc. ICASSP</EM>, 1:316-319, 2003.

<P></P><DT><A NAME="Rose2002">11</A>
<DD>
R.C. Rose.
<BR>A tutorial on asr for wireless mobile devices.
<BR>2002.

<P></P><DT><A NAME="Schmitt2008">12</A>
<DD>
Alexander Schmitt, Dmitry Zaykovskiy, and Wolfgang Minker.
<BR>Speech recognition for mobile devices.
<BR><EM>Int J Speech Technol</EM>, 11:63-72, 2008.

<P></P><DT><A NAME="Silva2008">13</A>
<DD>
Patrick Silva, Nelson Neto, Aldebaro Klautau, Andre Adami, and Isabel Trancoso.
<BR>Speech recognition for brazilian portuguese using the spoltech and
  ogi-22 corpora.
<BR><EM>XXVI Simposio Brasileiro de Telecomunica&#231;&#245;es</EM>, 2008.

<P></P><DT><A NAME="Vertanen2009">14</A>
<DD>
Keith Vertanen and Per&nbsp;Ola Kristensson.
<BR>Parakeet: a continuous speech recognition system for mobile
  touch-screen devices.
<BR>In <EM>IUI '09: Proceedings of the 13th international conference on
  Intelligent user interfaces</EM>, pages 237-246, New York, NY, USA, 2009. ACM.

<P></P><DT><A NAME="Walker2004">15</A>
<DD>
W.&nbsp;Walker, P.&nbsp;Lamere, P.&nbsp;Kwok, and B.&nbsp;Raj.
<BR>Sphinx-4: A flexible open source framework for speech recognition.
<BR>Technical report, Sun Microsystems Laboratories, 2004.

<P></P><DT><A NAME="Zaykovskiy2007">16</A>
<DD>
Dmitry Zaykovskiy and Alexander Schmitt.
<BR>Java (j2me) front-end for distributed speech recognition.
<BR><EM>21st International Conference on Advanced Information Networking
  and Applications Workshops (AINAW'07)</EM>, 2007.
</DL>

