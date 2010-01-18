/*
 * TriosController.fx
 *
 * Created on Dec 27, 2009, 8:53:39 PM
 */
package trios;

import javafx.io.http.HttpRequest;
import java.io.OutputStream;
import java.io.InputStream;
import java.lang.Exception;
import java.io.IOException;
import javafx.data.pull.Event;
import javafx.data.pull.PullParser;

import trios.TriosModel.*;
import javafx.io.Storage;
import javafx.stage.Alert;

// to test XML conversion for model
var file = Storage {
            source: "xml"
}

public function doHttp(method : String): Void {

    var getRequest: HttpRequest = HttpRequest {
        location: "http://localhost:8080/";
        //GVO TODO
        method: method
        onStarted: function () {
            println("onStarted - started performing method: {getRequest.method} on location: {getRequest.location}");
        }
        onConnecting: function () {
            println("onConnecting")
        }
        onDoneConnect: function () {
            println("onDoneConnect")
        }
        onReadingHeaders: function () {
            println("onReadingHeaders")
        }
        onResponseCode: function (code: Integer) {
            println("onResponseCode - responseCode: {code}")
        }
        onResponseMessage: function (msg: String) {
            println("onResponseMessage - responseMessage: {msg}")
        }
        onResponseHeaders: function (headerNames: String[]) {
            println("onResponseHeaders - there are {headerNames.size()} response headers:");
            for (name in headerNames) {
                println("    {name}: {getRequest.getResponseHeaderValue(name)}");
            }
        }
        onReading: function () {
            println("onReading")
        }
        onToRead: function (bytes: Long) {

            if (bytes < 0) {
                println("onToRead - Content length not specified by server; bytes: {bytes}");
            } else {
                println("onToRead - total number of content bytes to read: {bytes}");
            }
        }
        // The onRead callback is called when some data has been read.  If an
        // output stream is provided in the sink variable, onRead shows the progress
        // of bytes read from location and written to the sink.  If no value is
        // specified for the sink variable, the onRead callback shows the progress of
        // bytes read from location to a buffer allocated by HttpRequest.  These bytes
        // will be made available when the reading is complete, in the form of an
        // input stream provided by the onInput callback.
        onRead: function (bytes: Long) {
            // The toread variable is non negative only if the server provides the content length
            def progress =
                    if (getRequest.toread > 0) "({(bytes * 100 / getRequest.toread)}%)" else "";
            println("onRead - bytes read: {bytes} {progress}");
        }
        // The content of a response can be accessed in the onInput callback function.
        // Be sure to close the input sream when finished with it in order to allow
        // the HttpRequest implementation to clean up resources related to this
        // request as promptly as possible.
        onInput: function (is: InputStream) {
            // use input stream to access content here.
            // can use input.available() to see how many bytes are available.
            try {
                println("onInput - bytes of content available: {is.available()}");
                //model.GetBytes(is);


            } finally {
                is.close();
            }
        }
        onException: function (ex: Exception) {
            getRequest.stop();
            println("onException - exception: {ex.getClass()} {ex.getMessage()}");
        }
        onDoneRead: function () {
            println("onDoneRead")
        }
        onDone: function () {
            println("onDone");
        }
        onWriting: function () {
            println("onWriting")
        }
        // The content of a PUT or POST can be specified in the onOutput callback function.
        // Be sure to close the output sream when finished with it in order to allow
        // the HttpRequest implementation to clean up resources related to this
        // request as promptly as possible.  The calling next callback (onToWrite) depends
        // the output stream being closed.
        onOutput: function (os: OutputStream) {
            try {
                //out = os;
            } catch (ex: IOException) {
                ex.printStackTrace();
            } finally {
                println("onOutput - about to close output stream.");
                try {
                    os.close();
                } catch(ex : IOException) {
                    ex.printStackTrace();
                }
            }
        }
        onToWrite: function (bytes: Long) {
            println("onToWrite - entire content to be written: {bytes} bytes")
        }
        onWritten: function (bytes: Long) {
            println("onWritten - {bytes} bytes has now been written")
        }
        onDoneWrite: function () {
            println("doneWrite")
        }
    }

    getRequest.start();
}

public function doParse(in : InputStream): Void{

    var parse = PullParser {

        var cortexIndex;
        var lightIndex;

        documentType: PullParser.XML;
        input: in
        onEvent: function (event: Event) {
            if (event.type == PullParser.START_ELEMENT) {
                if ((event.qname.name.startsWith("CORTEX1")) and event.level == 1) {
                    cortexIndex = 0;
                }
                else if ((event.qname.name.startsWith("CORTEX2")) and event.level == 1) {
                    cortexIndex = 1;
                }
                else if ((event.qname.name.startsWith("CORTEX3")) and event.level == 1) {
                    cortexIndex = 2;
                }
                else if ((event.qname.name.startsWith("CORTEX4")) and event.level == 1) {
                    cortexIndex = 3;
                }
                else if ((event.qname.name.startsWith("OUT1")) and event.level == 2) {
                    lightIndex = 0;
                }
                else if ((event.qname.name.startsWith("OUT2")) and event.level == 2) {
                    lightIndex = 1;
                }
                else if ((event.qname.name.startsWith("OUT3")) and event.level == 2) {
                    lightIndex = 2;
                }
                else if ((event.qname.name.startsWith("OUT4")) and event.level == 2) {
                    lightIndex = 3;
                }
                else if ((event.qname.name.startsWith("OUT5")) and event.level == 2) {
                    lightIndex = 4;
                }
                else if ((event.qname.name.startsWith("OUT6")) and event.level == 2) {
                    lightIndex = 5;
                }
            }
            else if (event.type == PullParser.END_ELEMENT) {
                if (event.qname.name == "VALUE" and event.level == 3) {
                    c[cortexIndex].light[lightIndex].value = event.text
                }
                else if (event.qname.name == "MIN" and event.level == 3) {
                    c[cortexIndex].light[lightIndex].min = event.text
                }
                else if (event.qname.name == "MAX" and event.level == 3) {
                    c[cortexIndex].light[lightIndex].max = event.text
                }
                else if (event.qname.name == "STEP" and event.level == 3) {
                    c[cortexIndex].light[lightIndex].delta = event.text
                }
                else if (event.qname.name == "PININ" and event.level == 3) {
                    c[cortexIndex].light[lightIndex].pinin = event.text
                }
                else if (event.qname.name == "PINOUT" and event.level == 3) {
                    c[cortexIndex].light[lightIndex].pinout = event.text
                }
                else if (event.qname.name == "GEN1" and event.level == 3) {
                    c[cortexIndex].general.free1 = event.text
                }
                else if (event.qname.name == "GEN2" and event.level == 3) {
                    c[cortexIndex].general.watchdog = event.text
                }
                else if (event.qname.name == "GEN3" and event.level == 3) {
                    c[cortexIndex].general.pvd = event.text
                }
                else if (event.qname.name == "GEN4" and event.level == 3) {
                    c[cortexIndex].general.free2 = event.text
                }
                else if (event.qname.name == "GEN5" and event.level == 3) {
                    c[cortexIndex].general.free3 = event.text
                }
                else if (event.qname.name == "GEN6" and event.level == 3) {
                    c[cortexIndex].general.flags = event.text
                }
            }
        }
    }

    parse.parse();

    // model update
    for (cortex in c){
      cortex.fromXml();
    }
}

public function writeToXmlFile (){

    file.resource.maxLength = 10 * 1024;
    var os = file.resource.openOutputStream(true);

    try{
        os.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n".getBytes());
        os.write("<DATA>\n".getBytes());

        os.write("<CORTEX1>\n".getBytes());
        os.write(c[0].toXml().getBytes());
        os.write("</CORTEX1>\n".getBytes());

        os.write("<CORTEX2>\n".getBytes());
        os.write(c[1].toXml().getBytes());
        os.write("</CORTEX2>\n".getBytes());

        os.write("<CORTEX3>\n".getBytes());
        os.write(c[2].toXml().getBytes());
        os.write("</CORTEX3>\n".getBytes());

        os.write("<CORTEX4>\n".getBytes());
        os.write(c[3].toXml().getBytes());
        os.write("</CORTEX4>\n".getBytes());

        os.write("</DATA>\n".getBytes());

        os.close();
    }
    catch(ex : IOException) {
            Alert.confirm(ex.toString());
    }
}