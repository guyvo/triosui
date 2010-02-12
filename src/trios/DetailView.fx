/*
 * DetailView.fx
 *
 * Created on Feb 12, 2010, 10:29:36 AM
 */
package trios;

import javafx.scene.CustomNode;
import java.lang.UnsupportedOperationException;
import javafx.scene.Node;
import trios.LevelBarNode.VerticalBar;
import trios.TriosModel.*;
import javafx.scene.control.Button;
import javafx.scene.text.Font;
import javafx.scene.Group;

/**
 * @author guy
 */
// place your code here
public class TriosDetailView extends CustomNode {

    public var cortexIdx: Integer;
    public var lightIdx: Integer;
    public var actionFunction : function() : Void;

    var levelBar = VerticalBar {
                posx: 20
                posy: 100
                width: 70

                screenHeight:700
                
                def temp = c[cortexIdx].light[lightIdx]
                valmodel: bind temp.ivalue with inverse
            }

    var button = Button {
                translateY:600
                translateX:100
                width: 200
                height: 20

                text: "Back to overview"
                font: Font {
                    name: "Courier"
                    size: 10
                }
                action: function () {
                    actionFunction();
                };
            }


    override protected function create(): Node {
        Group{
            content: [levelBar,button]
        }

    }

}
