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
import javafx.geometry.HPos;
import javafx.geometry.VPos;
import javafx.scene.layout.Tile;
import trios.TriosController.*;
import trios.TriosModel.*;
import javafx.scene.shape.Circle;
import javafx.animation.transition.FadeTransition;
import javafx.animation.transition.RotateTransition;
import javafx.animation.transition.ScaleTransition;
import javafx.scene.input.MouseEvent;
import javafx.scene.text.Text;
import trios.LabelButtonNode.LabelButtonInHBox;
import trios.LevelBarNode.HorizontalBar;
import javafx.scene.Group;

/**
 * @author guy
 */
var dis = true;

public class TileView extends CustomNode {

    init{
        PlayBlock();
    }
    
    var cir = Circle {
                centerX: Main.SCREENWIDTH / 2
                centerY: Main.SCREENHEIGTH / 2
                radius: 100
                fill: Color.YELLOW
                visible: bind dis
                onMousePressed: function (me: MouseEvent): Void {
                    dis = false;

                }
            }
    var txt = Text {
                visible: bind dis
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
    var tile = Tile {
                translateX: 10
                hgap: 10
                vgap: 1
                columns: 2
                rows: 24
                tileHeight: 30
                tileWidth: 240
                nodeVPos: VPos.BOTTOM
                nodeHPos: HPos.LEFT
                content:
                for (i in [0..3])
                    for (j in [0..5])
                        [
                            HorizontalBar {
                                disable: bind dis;
                                def x = c[i].light[j];
                                width: 200
                                height: 20
                                posx: 10
                                posy: 10
                                valmodel: bind x.ivalue with inverse
                            }
                            LabelButtonInHBox {
                                disable:bind dis
                                actionFunction : writeToXmlFile
                                labelText: "{c[i].light[j].id}"
                            }
                        ]
            };

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


