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

import javafx.io.Storage;
import trios.TriosView.*;


// used to test XML parsing
var entry = Storage {
            source: "model"
}

function run()  {

    //doParse(entry.resource.openInputStream());

    //writeToXmlFile();

    // overview of lights as first view bind with scene
   setStartView();
    //FX.exit();
}
