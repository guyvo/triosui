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
import javafx.stage.Alert;
import javafx.io.http.HttpHeader;

public var toRead;
public var bytesRead;
public var toWrite;
public var bytesWritten;

public function doHttp(method : String) : Void{

    var getRequest: HttpRequest = HttpRequest {
        location: "http://guyvo.no-ip.biz:60000/";
        
        method: method

        headers:
        [
            HttpHeader{name:"cortex" value:"{sizeof cortexes}"}
        ]

        onStarted: function () {
            //println("onStarted - started performing method: {getRequest.method} on location: {getRequest.location}");
        }
        onConnecting: function () {
            bytesRead=0;
            bytesWritten=0;
            //println("onConnecting")
        }
        onDoneConnect: function () {
            //println("onDoneConnect")
        }
        onReadingHeaders: function () {
            //println("onReadingHeaders")
        }
        onResponseCode: function (code: Integer) {
            //println("onResponseCode - responseCode: {code}")
        }
        onResponseMessage: function (msg: String) {
            //println("onResponseMessage - responseMessage: {msg}")
        }
        onResponseHeaders: function (headerNames: String[]) {
            println("onResponseHeaders - there are {headerNames.size()} response headers:");
            for (name in headerNames) {
                println("    {name}: {getRequest.getResponseHeaderValue(name)}");
            }
        }
        onReading: function () {
            //println("onReading")
        }
        onToRead: function (bytes: Long) {
            toRead = bytes;
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
            bytesRead = bytes;
            //println("{bytesRead}");
            //println("onRead - bytes read: {bytes} {progress}");
        }
        // The content of a response can be accessed in the onInput callback function.
        // Be sure to close the input sream when finished with it in order to allow
        // the HttpRequest implementation to clean up resources related to this
        // request as promptly as possible.
        onInput: function (is: InputStream) {
            // use input stream to access content here.
            // can use input.available() to see how many bytes are available.
            try {
                //println("onInput - bytes of content available: {is.available()}");
                doParse(is);
            } finally {
                is.close();
            }
        }
        onException: function (ex: Exception) {
            getRequest.stop();
            println("onException - exception: {ex.getClass()} {ex.getMessage()}");
        }
        onDoneRead: function () {
            //println("onDoneRead")
        }
        onDone: function () {
            println("doneRead");
        }
        onWriting: function () {
            //println("onWriting")
        }
        // The content of a PUT or POST can be specified in the onOutput callback function.
        // Be sure to close the output sream when finished with it in order to allow
        // the HttpRequest implementation to clean up resources related to this
        // request as promptly as possible.  The calling next callback (onToWrite) depends
        // the output stream being closed.
        onOutput: function (os: OutputStream) {
            try {
               writeToXmlFile(os);
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
            toWrite = bytes;
            //println("onToWrite - entire content to be written: {bytes} bytes")
        }
        onWritten: function (bytes: Long) {
            bytesWritten = bytes;
            //println("onWritten - {bytes} bytes has now been written")
        }
        onDoneWrite: function () {
            println("doneWrite")
        }
    }

    getRequest.start();
}

public function getHttpWorker ( method : String ) : function() : Void{
    return function (): Void { doHttp(method); }
}

public function doParse(in : InputStream): Void{

    var parse = PullParser {

        var cortexName;

        documentType: PullParser.XML;
        input: in
        onEvent: function (event: Event) {
            if (event.type == PullParser.START_ELEMENT) {
                if ((event.qname.name.startsWith("Cortex")) and event.level == 2) {
                    cortexName = event.getAttributeValue("CORTEX");
                    for (cortex in c where cortex.name == cortexName ){
                            cortex.general.sensor = event.getAttributeValue("SENSOR");
                            cortex.general.watchdog = event.getAttributeValue("WATCHDOG");
                            cortex.general.toggle = event.getAttributeValue("TOGGLE");
                            cortex.general.dimmer = event.getAttributeValue("DIMMER");
                            cortex.general.hours = event.getAttributeValue("HOURS");
                            cortex.general.masks = event.getAttributeValue("MASKS");
                    }                }
            }
            else if (event.type == PullParser.END_ELEMENT) {
                if (event.qname.name == "Light" and event.level == 4) {
                    for (cortex in c where cortex.name == cortexName ){
                        for ( light in cortex.light where light.id == event.getAttributeValue("NAME")  ){
                            light.value = event.getAttributeValue("VALUE");
                            light.min =  event.getAttributeValue("MIN");
                            light.max =  event.getAttributeValue("MAX");
                            light.delta =  event.getAttributeValue("DELTA");
                            light.pinin =  event.getAttributeValue("PININ");
                            light.pinout =  event.getAttributeValue("PINOUT");
                        }

                    }
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

public function writeToXmlFile ( os: OutputStream){

    //file.resource.maxLength = 10 * 1024;
    //var file = file.resource.openOutputStream(true);

    try{


        os.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n".getBytes());
        os.write("<DATA>\n".getBytes());
        os.write("<Cortexes>\n".getBytes());


        os.write(c[0].toXml().getBytes());
        os.write(c[1].toXml().getBytes());
        os.write(c[2].toXml().getBytes());
        os.write(c[3].toXml().getBytes());

        os.write("</Cortexes>\n".getBytes());
        os.write("</DATA>\n".getBytes());
        os.flush();

        os.close();
    }
    catch(ex : IOException) {
            Alert.confirm(ex.toString());
    }
}