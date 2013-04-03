--- 
kind: article
title: Captura de audio para Java ME
created_at: 2010/02/25
excerpt: Este es un ejemplo para la captura de audio con J2ME
tags: [java, javame, mobile, audio]
---

Este es un ejemplo para la captura de audio con J2ME. La aplicación está basada en [Voice Recording in J2ME][1], un ejemplo que captura audio por 5 segundos y lo reproduce en la misma aplicación. He adicionado una pequeña modificación para que almacene la captura en la memoria del dispositivo.

A continuación está el código modificado:

<% code(:java) do %>
package recorder;

import java.io.*;
import javax.microedition.io.Connector;
import javax.microedition.io.file.FileConnection;
import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;
import javax.microedition.media.*;
import javax.microedition.media.control.*;

public class VoiceRecordMidlet extends MIDlet {

    private Display display;

    public void startApp() {
        display = Display.getDisplay(this);
        display.setCurrent(new VoiceRecordForm());
    }

    public void pauseApp() {
    }

    public void destroyApp(boolean unconditional) {
        notifyDestroyed();
    }
}

class VoiceRecordForm extends Form implements CommandListener {

    private StringItem message;
    private StringItem errormessage;
    private final Command record, play;
    private Player player;
    private byte[] recordedAudioArray = null;

    public VoiceRecordForm() {
        super("Recording Audio");
        message = new StringItem("", "Select Record to start recording.");
        this.append(message);
        errormessage = new StringItem("", "");
        this.append(errormessage);
        record = new Command("Record", Command.OK, 0);
        this.addCommand(record);
        play = new Command("Play", Command.BACK, 0);
        this.addCommand(play);
        this.setCommandListener(this);
    }

    public void commandAction(Command comm, Displayable disp) {
        if (comm == record) {
            Thread t = new Thread() {

                public void run() {
                    try {
                        player = Manager.createPlayer("capture://audio?encoding=pcm");
                        player.realize();
                        RecordControl rc = (RecordControl) player.getControl("RecordControl");
                        ByteArrayOutputStream output = new ByteArrayOutputStream();
                        rc.setRecordStream(output);
                        rc.startRecord();
                        player.start();
                        message.setText("Recording...");
                        Thread.sleep(5000);
                        message.setText("Recording Done!");
                        rc.commit();
                        recordedAudioArray = output.toByteArray();
                        player.close();
                        saveAudio();
                    } catch (Exception e) {
                        errormessage.setLabel("Error");
                        errormessage.setText(e.toString());
                    }
                }
            };
            t.start();

        } else if (comm == play) {
            try {
                ByteArrayInputStream recordedInputStream = new ByteArrayInputStream(recordedAudioArray);
                Player p2 = Manager.createPlayer(recordedInputStream, "audio/basic");
                p2.prefetch();
                p2.start();
            } catch (Exception e) {
                errormessage.setLabel("Error");
                errormessage.setText(e.toString());
            }
        }
    }

    private void saveAudio() {
        try {
            //Abre o directorio donde se va a guardar el archivo
            FileConnection fc = (FileConnection) Connector.open("file:///E:/records");
            if (!fc.exists()) {
                fc.mkdir();
            }
            //crea el archivo de audio
            fc = (FileConnection) Connector.open("file:///E:/records/som1.pcm");
            if (!fc.exists()) {
                fc.create();
            }
            DataOutputStream dos = fc.openDataOutputStream();
            //Guarda el audio capturado en el archivo
            dos.write(recordedAudioArray);
            dos.close();
            fc.close();
        } catch (IOException e) {
            errormessage.setLabel("Error");
            errormessage.setText(e.toString());
        }
    }
}
<% end %>

La aplicación está guardando siempre en el mismo archivo, por lo tanto después de la primera vez se va sobre escribir el audio capturado.

Pueden encontrar mas información sobre el manejo de multimedia y archivos para J2ME  en los siguientes enlaces:

* [Mobile Media API (JSR-135) ][2]
* [Ejemplo de manejo de archivos][3]
* [JSR 75 File connection API][4]


  [1]: http://j2mesamples.blogspot.com/2009/06/voice-recording-in-j2me.html
  [2]: http://java.sun.com/javame/reference/apis/jsr135/index.html
  [3]: http://www.java-tips.org/java-me-tips/midp/how-to-access-local-file-systems-from-j2me-devices-using-fileconnectio-2.html
  [4]: http://wiki.forum.nokia.com/index.php/JSR_75_File_connection_API
