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


// the screen boundaries
public def SCREENWIDTH = 480;
public def SCREENHEIGTH = 800;

// used to test XML parsing
var entry = Storage {
            source: "model"
}

// theStage
var mainStage = Stage {
    title: "TriosView"
    scene: Scene {
        fill: Color.BLACK
        width: SCREENWIDTH
        height: SCREENHEIGTH
        content: []
    }
}
public class SimpleTimer {
    public def timeline = Timeline {
        repeatCount: Timeline.INDEFINITE
        interpolate: false
        keyFrames: [
            KeyFrame {
                time: 5s
                action: function () : Void {
                    doHttp("GET");
                }
            }
        ]
    }
}

function run()  {

    var refresh = SimpleTimer{};

    refresh.timeline.playFromStart();
   
    //doParse(entry.resource.openInputStream());

    //writeToXmlFile();

    // overview of lights as first view bind with scene
    mainStage.scene.content = [
        TriosView.TileView {}
    ]

    //FX.exit();
}
