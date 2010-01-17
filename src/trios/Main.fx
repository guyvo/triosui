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
import trios.TriosView.TileView;



public def SCREENWIDTH = 480;
public def SCREENHEIGTH = 800;

var entry = Storage {
            source: "model"
        }


var mainStage = Stage {
            title: "TriosView"
            scene: Scene {

                fill: Color.BLACK
                width: SCREENWIDTH
                height: SCREENHEIGTH
                content: []
            }
}

function run() {
  
  doParse(entry.resource.openInputStream());

 
  //writeToXmlFile();

    mainStage.scene.content = [
            TriosView.TileView {}
            ]
    //FX.exit();


}
