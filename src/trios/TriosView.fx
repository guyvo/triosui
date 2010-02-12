/*
 * TriosView.fx
 *
 * Created on Jan 17, 2010, 7:20:43 PM
 */
package trios;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import trios.TriosController.*;
import trios.TriosModel.*;
import javafx.scene.shape.Circle;
import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.RotateTransition;
import javafx.animation.transition.ScaleTransition;
import javafx.scene.input.MouseEvent;
import javafx.scene.text.Text;
import javafx.scene.Group;
import trios.LabelButtonNode.*;
import trios.LevelBarNode.*;
import trios.TimeLine.ScreenBlockTimer;
import trios.TimeLine.RefreshTimer;
import trios.DetailView.*;
import javafx.stage.Stage;
import javafx.scene.Scene;

/**
 * @author guy
 */

 // the screen boundaries
public def SCREENWIDTH = 480;
public def SCREENHEIGTH = 800;



var saver : ScreenBlockTimer;
var refresh : RefreshTimer;
var overview =  TriosView.TileView {};

var mainStage = Stage {
    title: "TriosView"
    scene: Scene {
        fill: Color.BLACK
        width: SCREENWIDTH
        height: SCREENHEIGTH
        content: []
    }
}



public function setMainView(): Void {
     mainStage.scene.content = [
        overview
    ]
}

public function setDetailView (cortex : Integer , light : Integer){
    var detailview = TriosDetailView{
        cortexIdx:cortex
        lightIdx:light
        actionFunction:setMainView
    };

    
    mainStage.scene.content = [
        detailview
    ]
}

public function getDetailView (cortex : Integer , light : Integer) : function() : Void{
    return function (): Void { setDetailView(cortex, light) }
};

public function screenSaver () : Void {

   var cir = Circle {
                centerX: SCREENWIDTH / 2
                centerY: SCREENHEIGTH / 2
                radius: 100
                fill: Color.YELLOW
                visible: true
                onMousePressed: function (me: MouseEvent): Void {
                   setMainView();
                   saver.timeline.play();
                   refresh.timeline.play();
                }
            }

    var txt = Text {
                visible: true
                x: bind (cir.centerX - 50)
                y: bind cir.centerY
                content: "ENABLE CONTROL"
                font: Font {
                    name: "Arial"
                    size: 25
                }
                fill: Color.BLUE
            }
    var scaleTransition = ScaleTransition {
                duration: 5s
                node: cir
                byX: 1.5
                byY: 1.5
                repeatCount: ScaleTransition.INDEFINITE
                autoReverse: false
            }
    var fadeTransition = FadeTransition {
                duration: 5s
                node: cir
                fromValue: 0.2
                toValue: 0.8
                repeatCount: FadeTransition.INDEFINITE;
                autoReverse: false
            }
    var rotTransition = RotateTransition {
                duration: 5s
                node: txt
                byAngle: 360
                repeatCount: RotateTransition.INDEFINITE
                autoReverse: false
            }

    mainStage.scene.content = [
        cir,txt
    ];

    scaleTransition.play();
    fadeTransition.play();
    rotTransition.play();

    refresh.timeline.stop();
    saver.timeline.stop();

}

public function setTileNodes(cortex :Integer) : Node[]{

       var nodes : Node[];

       for (i in [0..cortex]){
            for (j in [0..5]){
                var h = HorizontalBar {
                    def temp = c[i].light[j];
                    width: 200
                    height: 20
                    posx: 10
                    posy: 10
                    
                    valmodel: bind temp.ivalue with inverse
                }

                insert h into nodes;

                var l  = LabelButtonInHBox {
                    actionFunction:getDetailView(i,j)
                    labelText: "{c[i].light[j].id}"

                }
               
                insert l into nodes;
            }
        }
        return nodes;
}

public class TileView extends CustomNode {

    init {
             
        saver = ScreenBlockTimer {
            waitTime: 1m
            actionFunction:screenSaver
        }
        
        
        refresh = RefreshTimer {
            waitTime: 5s;
            actionFunction:Resfresh
        }

        saver.timeline.play();
        refresh.timeline.play();
        
    }

    public function Resfresh(): Void{
        //doHttp("GET");
     }

    var tile = TileNode {
                cols: 2
                rows: 24
                tileHeigth: 30
                tileWidth: 240
                nodes: setTileNodes(3)
                }

  
    override protected function create(): Node {
        Group {
            content: [tile]
        }
    }
}


