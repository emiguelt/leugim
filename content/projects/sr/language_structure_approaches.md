--- 
title: Language Recognition Structure
tags: [mobile, speech_recognition]
excerpt: ""
---

Language Recognition Structure
----

#####26/Jun/2010

This document describes the 4 different approaches to achieve the speech recognition for commands.

### 1. Definitions

 * Dictionary (dicX): This file contains the supported commands with their transcriptions. For example:
 
 <code>
word1 mod1 mod2 mod3 <br/>
word2 mod1 mod3 mod5 <br/>
word3 mod3 mod5
 </code>
 
 *wordX*: is the supported word or command in the system
 *modX*: represents a model of a word of subword (phoneme)

 * Acoustic model (phoneX): supported word models

 <code>
 mod1 <br/>
 mod2 <br/>
 ...  <br/>
 mod5 <br/>
 </code>

 * Language Model - LM (jsgf): Defines the structure of the language, that is, define how the commands must be formatted to be accepted by the system. For the command speech recognition system a finite grammar structure (FSG) language will be used. The following is an example of language model:

 <code>
 &nbsp;&nbsp;&nbsp;&nbsp;--> word1 --<br/>
&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br/>
 -->o--> word2 --o--><br/>
&nbsp;&nbsp;&nbsp;\&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  /<br/>
&nbsp;&nbsp;&nbsp; --> word3 --
</code>

 In this case *word1*, *word2* or *word3* are accepted 

### 2. Approaches

 1. Whole_word / Composed command: Whole word in dictionary and phone files, language model with composed commands.

  <center><table border='1'>
  <tr><th>Dictionary (dict1)</th>
      <th>Phone (phone1)</th>
      <th>LM (jsgf1)</th>
  <tr>
  <tr><td>
<code>
word1 word1 <br/>
word2 word2 <br/>
word3 word3
 </code>
</td>
<td>
<code>
word1 <br/>
word2 <br/>
word3 
</code>
</td>
<td>
<code>
(word1) | (word2) | (word3)
 </code>
</td></tr>
  </table><br/></center>

 2. Phoneme / Composed command: Whole word in dictionary, but words are composed by phonemes, phone files contains all supported phonemes (included silence).

  <center><table border='1'>
  <tr><th>Dictionary (dict2)</th>
      <th>Phone (phone2)</th>
      <th>LM (jsgf1)</th>
  <tr>
  <tr><td>
<code>
word1 mod1 mod2 mod3 <br/>
word2 mod1 mod4 <br/>
word3 mod3 mod4 mod5
 </code>
</td>
<td>
<code>
mod1 <br/>
mod2 <br/>
... <br/>
mod5
</code>
</td>
<td>Same that approach 1</td></tr>
  </table><br/></center>

 3. Whole command / whole word: The dictionary contains the commands as a unique word, composed of the supported words. The language model contains the whole commands.

  <center><table border='1'>
  <tr><th>Dictionary (dict3)</th>
      <th>Phone (phone1)</th>
      <th>LM (jsgf2)</th>
  <tr>
  <tr><td>
<code>
word1_word2 word1 word2<br/>
word3_word4 word3 word3
 </code>
</td>
<td>Same that approach 1</td>
<td>
<code>
 (word1\_word2) | (word3\_word4)
 </code>
</td></tr>
  </table><br/></center>

 4. Whole command / Phonemes: The dictionary contains the commands as a unique word, composed of the supported phonemes.

  <center><table border='1'>
  <tr><th>Dictionary (dict4)</th>
      <th>Phone (phone2)</th>
      <th>LM (jsgf2)</th>
  <tr>
  <tr><td>
<code>
word1_word2 mod1 mod2 mod3 mod1 mod4<br/>
word3_word4 mod3 mod4 mod5 mod5 mod1 mod2
 </code>
</td>
<td>Same that approach 2</td>
<td>Same that approach 3</td>
</tr>
</table><br/></center>

There will be generate 4 dict files, 2 phone files and 2 language models to test the 4 approaches
