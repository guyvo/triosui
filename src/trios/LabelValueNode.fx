/*
 * LabelValueNode.fx
 *
 * Created on Mar 31, 2010, 10:05:07 PM
 */
package trios;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.control.Label;
import javafx.scene.text.Font;
import javafx.scene.paint.Color;
import javafx.scene.layout.HBox;

/**
 * @author guy
 */
// place your code here
public class LabelValueNode extends CustomNode {

    def fontSize = 30;
    def screenWidth = 480;

    public var labelText: String;
    public var valueText: String;

    def label = Label {
                text: bind labelText
                textFill: Color.CORAL
                font: Font {
                    name: "Arial"
                    size: fontSize
                }
            }
    def value = Label {
                text: bind valueText
                textFill: Color.CORAL
                font: Font {
                    name: "Arial"
                    size: fontSize
                }
            }

    override protected function create(): Node {
        HBox {
            spacing: (screenWidth/2) - label.boundsInLocal.width
            content: [label, value]
        }
    }
}
