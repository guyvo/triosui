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
import com.sun.javafx.scene.control.caspian.ButtonSkin;


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
                translateX:150
                width: 70
                height: 20
                text: "Detail"
                font: Font {
                    name: "Arial"
                    size: 10
                }
                focusTraversable:true

                action :function(){
                        actionFunction();
                };
                skin : ButtonSkin{
                    cornerRadius:20
                    textFill:Color.CORAL
                    fill:Color.LIGHTGREY
                    
                }

                
     }


    override protected function create(): Node {
        Group {
            content: [label, button]
        }

    }
}

