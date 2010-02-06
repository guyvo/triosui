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

/**
 * @author guy
 */
var disableNode = true;

public function setTileNodes(cortex :Integer) : Node[]{

       var nodes : Node[];

       for (i in [0..cortex]){
            for (j in [0..5]){
                var h = HorizontalBar {
                    disable: bind disableNode;
                    def x = c[i].light[j];
                    width: 200
                    height: 20
                    posx: 10
                    posy: 10
                    valmodel: bind x.ivalue with inverse
                }

                insert h into nodes;

                var l  = LabelButtonInHBox {
                    disable:bind disableNode
                    actionFunction:getHttpWorker("POST")
                    labelText: "{c[i].light[j].id}"

                }
                
                insert l into nodes;
            }
        }
        return nodes;
}

public class TileView extends CustomNode {

   
    init {

        PlayBlock();
    }

    var cir = Circle {
                centerX: Main.SCREENWIDTH / 2
                centerY: Main.SCREENHEIGTH / 2
                radius: 100
                fill: Color.YELLOW
                visible: bind disableNode
                onMousePressed: function (me: MouseEvent): Void {
                    doHttp("GET");
                    disableNode = false;

                }
            }
    var txt = Text {
                visible: bind disableNode
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
    var tile = TileNode {
                cols: 2
                rows: 6
                tileHeigth: 30
                tileWidth: 240
                nodes: setTileNodes(0)
                }

    public function PlayBlock() {
        scaleTransition.play();
        fadeTransition.play();
        rotTransition.play();
    }

    public function PauseBlock() {
        scaleTransition.pause();
        fadeTransition.pause();
        rotTransition.pause();
    }

    override protected function create(): Node {
        Group {
            content: [tile, cir, txt]
        }
    }
}


