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
import trios.TimeLine.*;
import trios.DetailView.*;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.ProgressIndicator;
import com.sun.javafx.scene.control.caspian.ProgressIndicatorSkin;


/**
 * @author guy
 */
// the screen boundaries
public def SCREENWIDTH = 480;
public def SCREENHEIGTH = 800;

var saver: ScreenBlockTimer;
var refresh: RefreshTimer;
var overview : TriosView.TileView;
var detailViews: TriosDetailView[];

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
    doHttp("GET");
    mainStage.scene.content = [
        overview
    ]
}

public function setStartView(): Void {
    doHttp("GET");
    overview = TriosView.TileView{ };
    mainStage.scene.content = [
        overview
    ]
}

public function setDetailView(light: Light, cortex: CortexxEnum) {
    def detailview = TriosDetailView {
                theCortex: cortex;
                theLight: light
                actionFunction: setMainView
            };
    insert detailview into detailViews;
}

public function getDetail(light: Light, cortex: CortexxEnum): Void {
    for (cor in c where cor.id == cortex) {
        for (li in cor.light where li.id == light.id) {
            for (detail in detailViews where (detail.theCortex == cor.id)
                    and (detail.theLight == light)) {
                mainStage.scene.content = [
                    detail
                ]
            }
        }
    }
}

public function getDetailView(light: Light, cortex: CortexxEnum): function(): Void {
    return function (): Void {
                getDetail(light, cortex)
            }
};

public function screenSaver(): Void {
    def cir = Circle {
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
    def txt = Text {
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
    def scaleTransition = ScaleTransition {
                duration: 5s
                node: cir
                byX: 1.5
                byY: 1.5
                repeatCount: ScaleTransition.INDEFINITE
                autoReverse: false
            }
    def fadeTransition = FadeTransition {
                duration: 5s
                node: cir
                fromValue: 0.2
                toValue: 0.8
                repeatCount: FadeTransition.INDEFINITE;
                autoReverse: false
            }
    def rotTransition = RotateTransition {
                duration: 5s
                node: txt
                byAngle: 360
                repeatCount: RotateTransition.INDEFINITE
                autoReverse: false
            }

    mainStage.scene.content = [
        cir, txt
    ];

    scaleTransition.play();
    fadeTransition.play();
    rotTransition.play();
    refresh.timeline.stop();
    saver.timeline.stop();
}

public function setTileNodes(): Node[] {
    var nodes: Node[];
    for (cortex in c) {
        for (light in cortex.light) {
            setDetailView(light, cortex.id);
            var h = HorizontalBar {
                        def temp = light;
                        width: 200
                        height: 20
                        posx: 10
                        posy: 10
                        valmodel: bind temp.ivalue with inverse
                    }
            insert h into nodes;
            var l = LabelButtonInHBox {
                        actionFunction: getDetailView(light, cortex.id)
                        labelText: "{light.name}"
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
            actionFunction: screenSaver
        }


        refresh = RefreshTimer {
            waitTime: 5s;
            actionFunction: Resfresh
        }

        saver.timeline.play();
        refresh.timeline.play();

    }

    public function Resfresh(): Void {
    
    }

    def progressRead = ProgressIndicator {
        translateX:20
        translateY:SCREENHEIGTH - 110
        id:"GET"
	progress: bind ProgressIndicator.computeProgress( toRead, bytesRead )

        skin:ProgressIndicatorSkin{
                accent:Color.GREEN
                base:Color.RED
                radius:30
        }
    }

    def progressWrite = ProgressIndicator {
        translateX:100
        translateY:SCREENHEIGTH - 110
        id:"POST"
        progress: bind ProgressIndicator.computeProgress( toWrite, bytesWritten )

        skin:ProgressIndicatorSkin{
                accent:Color.GREEN
                base:Color.RED
                radius:30
        }
    }

    def tile = TileNode {
                cols: 2
                rows: (sizeof cortexes) * (sizeof lights)
                tileHeigth: 25
                tileWidth: 240
                nodes: setTileNodes()
            }

    override protected function create(): Node {
        Group {
            content: [tile,progressRead,progressWrite]
        }
    }

}
