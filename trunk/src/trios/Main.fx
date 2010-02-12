/*
 * Main.fx
 * Created on Dec 20, 2009, 6:24:05 PM
 *
 * @author GVO
 *
 * Targeted screen will be a HTC HD screen of
 *      Heigth = 800 pixels
 *      Width  = 480 pixels
 *
 * Initial check in in google reposity
 */
package trios;

import javafx.stage.Stage;
import javafx.scene.paint.Color;
import javafx.scene.Scene;
import javafx.io.Storage;
import trios.TriosController.*;
import trios.TriosView.*;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;


// used to test XML parsing
var entry = Storage {
            source: "model"
}

function run()  {

    //doParse(entry.resource.openInputStream());

    //writeToXmlFile();

    // overview of lights as first view bind with scene
   setMainView();
    //FX.exit();
}
