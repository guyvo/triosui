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

public abstract class LevelBar extends CustomNode {

    def min = 0;
    def max = 200;
    def scale = 2;
    public var name: String;
    public var height: Float;
    public var posx: Float;
    public var posy: Float;
    public var width: Integer;
    public var opa: Float = 0.3;
    public var value: Integer;
    public var textX: Float;
    public var textY: Float;
    public var gradStartX: Float;
    public var gradStartY: Float;
    public var gradEndX: Float;
    public var gradEndY: Float;
    var theFocus: Boolean = bind focused;

    var theShadowBox = Rectangle {
        x: bind posx
        y: bind posy
        width: max
        height: bind height
        fill: Color.BLACK;
        stroke: Color.WHITE
        strokeWidth: 3.0
        opacity: 0.2
        onMousePressed: function (me: MouseEvent): Void {
            this.width = me.x as Integer;
        }
    }

    var theBox = Rectangle {
        x: bind posx
        y: bind posy
        width: bind width
        height: bind height
        fill: LinearGradient {
            proportional: false
            startX: gradStartX, startY: gradStartY, endX: gradEndX, endY: gradEndY
            stops: [
                Stop {offset: 0.0 color: Color.GRAY},
                Stop {offset: 0.9 color: Color.YELLOW}]
        }
        opacity: bind opa
    }

    var theValue = Text {
        x: bind textX
        y: bind textY
        content: bind ((value / scale).toString())
        font: Font {
            name: "Arial"
            size: 10
        }
        fill: Color.WHITE
    }
}

public class HorizontalBar extends LevelBar {

    public override var value = bind width with inverse on replace {
        valmodel = (Integer.valueOf(value)) / scale;
    };

    public var valmodel: Integer on replace {
        value = (valmodel * scale);
    };

    public override var textX = bind (width + 10);
    public override var textY = bind (posy + 10);
    public override var gradStartX = bind posx;
    public override var gradStartY = bind posy;
    public override var gradEndX = bind width;
    public override var gradEndY = bind height;

    override protected function create(): Node {

        Group {
            content: [theBox, theValue, theShadowBox]
            onMousePressed: function (me: MouseEvent): Void {
                opa = 0.5;
            }
            onMouseReleased: function (me: MouseEvent): Void {
                opa = 1;
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

    public var screenHeight ;
    public override var value = bind height as Integer;
    public override var textX = bind posx;
    public override var textY = bind posy;
    public override var gradStartX = bind posx;
    public override var gradStartY = bind (posy + height);
    public override var gradEndX = bind (posx + width);
    public override var gradEndY = bind posy;

    override protected function create(): Node {
        Group {
            content: [theBox, theValue]
            onMousePressed: function (me: MouseEvent): Void {
                opa = 0.5;
            }
            onMouseReleased: function (me: MouseEvent): Void {
                opa = 1;
            }
            onMouseDragged: function (me: MouseEvent): Void {

                posy = me.y;
                height = (screenHeight - me.y);
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
