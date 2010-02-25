/*
 * LevelBarNode.fx
 *
 * Created on Jan 16, 2010, 9:46:06 AM
 */
package trios;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import trios.TriosController.*;

public abstract class LevelBar extends CustomNode {

    def min = 0;

    public-init var name: String;
    public-init var height: Integer;
    public-init var posx: Float;
    public-init var posy: Float;
    public-init var width: Integer;

    var value: Integer;
    var textX: Float;
    var textY: Float;
    var gradStartX: Float;
    var gradStartY: Float;
    var gradEndX: Float;
    var gradEndY: Float;

    var theBox = Rectangle {
        x: bind posx
        y: bind posy
        width: bind width
        height: bind height
        fill: LinearGradient {
            proportional: true
            startX: gradStartX, startY: gradStartY, endX: gradEndX, endY: gradEndY
            stops: [
                Stop {offset: 0.0 color: Color.GRAY},
                Stop {offset: 0.2 color: Color.LIGHTYELLOW},
                Stop {offset: 1 color: Color.YELLOW}]
        }
    }
}

public class HorizontalBar extends LevelBar {

    def scale = 2;
    def max = 200;
    def sizeVal = 15;

    public var valmodel: Integer on replace {
        value = (valmodel * scale);
    };

    override var value = bind width with inverse on replace {
        if ( scale != 0)
         valmodel = (Integer.valueOf(value)) / scale;
    };

    override var textX = bind (width + 10);
    override var textY = bind (posy + 10);
    override var gradStartX = 0;
    override var gradStartY = 0.5;
    override var gradEndX = 1;
    override var gradEndY = 0.5;

    var theShadowBox = Rectangle {
        x: bind posx
        y: bind posy
        width: max
        height: bind height
        fill: Color.BLACK;
        stroke: Color.WHITE
        strokeWidth: 1.0
        opacity:0.2
        onMousePressed: function (me: MouseEvent): Void {
            this.width = me.x as Integer;
        }
    }

    var theValue = Text {
        x: bind textX + 5
        y: bind textY + 5
        content: bind ((value / scale).toString())
        font: Font {
            name: "Arial"
            size: sizeVal
        }
        fill: Color.CORAL
    }

    override protected function create(): Node {

        Group {
            content: [theBox, theValue, theShadowBox]
            onMousePressed: function (me: MouseEvent): Void {
               
            }
            onMouseReleased: function (me: MouseEvent): Void {
                doHttp("POST");
            }
            onMouseDragged: function (me: MouseEvent): Void {
                if (me.x < min)
                    width = min
                else if (me.x > max)
                    width = max
                else
                    width = me.x as Integer;

            }
        }
    }
}

public class VerticalBar extends LevelBar {
    def scale = 6;
    def max = 600;
    def sizeVal = 30;

    public-init var screenHeight : Integer;

    public var valmodel: Integer on replace {
        value = valmodel * scale;
        posy = screenHeight - value;
    };

    override var value = bind height with inverse on replace{
        if ( scale != 0)
         valmodel = (Integer.valueOf(value)) / scale;
        
    };

    override var textX = bind posx;
    override var textY = bind posy;
    override var gradStartX =0.5;
    override var gradStartY = 1;
    override var gradEndX = 0.5;
    override var gradEndY = 0;

    var theShadowBox = Rectangle {
        x: bind posx
        y: bind screenHeight - max
        width: width
        height: screenHeight - (screenHeight - max )
        fill: Color.BLACK;
        stroke: Color.WHITE
        strokeWidth: 1.0
        opacity: 0.2
        onMousePressed: function (me: MouseEvent): Void {
            this.posy = me.y;
            this.height = (screenHeight - me.y) as Integer;;
        }
    }

    var theValue = Text {
        x: bind textX
        y: bind textY - 5
        content: bind ((value / scale).toString())
        font: Font {
            name: "Arial"
            size: sizeVal
        }
        fill: Color.CORAL
    }

    override protected function create(): Node {
        Group {
            content: [theShadowBox, theBox, theValue]
            onMousePressed: function (me: MouseEvent): Void {
            }
            onMouseReleased: function (me: MouseEvent): Void {
                 doHttp("POST");
            }
            onMouseDragged: function (me: MouseEvent): Void {
                posy = me.y;
                height = (screenHeight - me.y) as Integer;
                
                if (height < min) {
                    height = min;
                    posy = screenHeight;
                } else if (height > max) {
                    height = max;
                    posy = screenHeight - max
                }
            }
        }
    }
}
