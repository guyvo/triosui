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
import javafx.scene.Group;


/**
 * @author guy
 */

public class LabelButtonInHBox extends CustomNode{

    public-init var labelText : String;
    public-init var actionFunction : function():Void;

    def label = Label {
                translateY: 3
                textFill: Color.CORAL
                text: bind labelText
                font: Font {
                    name: "Arial"
                    size: 15
                }
    }

    def button = Button {
                translateX:170
                width: 40
                height: 20
                text: "Detail"
                font: Font {
                    name: "Arial"
                    size: 9
                }

                action :function(){
                        actionFunction();
                        };
                
                }

    override protected function create(): Node {
        Group {
            content: [label, button]
        }

    }
}

