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

/**
 * @author guy
 */

public class LabelButtonInHBox extends CustomNode{

    public var labelText : String;
    public var actionFunction : function();

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
                action: function () {
                    //TriosController.doHttp(buf);
                    actionFunction();
                    //dis = true;
                    }
            }

    override protected function create(): Node {
        HBox {
            spacing: 5
            content: [label, button]
        }

    }
}

