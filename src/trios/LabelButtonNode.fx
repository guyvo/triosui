/*
 * LabelButtonNode.fx
 *
 * Created on Jan 17, 2010, 7:37:21 PM
 */

package trios;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.geometry.HPos;


/**
 * @author guy
 */

public class LabelButtonInHBox extends CustomNode{

    public var labelText : String;
    public var actionFunction : function():Void;

    var label = Label {
                translateY: 5
                textFill: Color.WHITE
                text: bind labelText
                font: Font {
                    name: "Courier"
                    size: 10
                }
    }

    var button = Button {
                width: 200
                height: 20
                text: " detail "
                font: Font {
                    name: "Courier"
                    size: 10
                }
                action :function(){
                        actionFunction();
                        };
                
                }

    override protected function create(): Node {
        HBox {
            hpos:HPos.LEFT
            spacing: 5
            content: [label, button]
        }

    }
}

