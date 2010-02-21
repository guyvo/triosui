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
import javafx.scene.control.TextBox;

/**
 * @author guy
 */
// place your code here
public class TriosDetailView extends CustomNode {

    public var theLight: Light;
    public var actionFunction: function(): Void;

    def temp = theLight;

    var imax = bind temp.imax with inverse on replace{
        maxString = String.valueOf(imax);
    };

    var imin = bind temp.imin with inverse on replace{
        minString = String.valueOf(imin)
    };

    var idelta = bind temp.idelta with inverse on replace{
        deltaString = String.valueOf(idelta);
    };

    var maxString : String on replace {
        imax = Integer.parseInt(maxString);
    };

    var minString : String on replace {
        imin = Integer.parseInt(minString);
    };
    var deltaString : String on replace {
        idelta = Integer.parseInt(deltaString);
    };

    var levelBar = VerticalBar {
                posx: 20
                posy: 100
                width: 70
                screenHeight: 700
                valmodel: bind temp.ivalue with inverse
            }
    var button = Button {
                translateY: 600
                translateX: 100
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
    var max = TextBox {
                translateX:200
                translateY:50
                text: bind maxString with inverse
                columns: 5
                selectOnFocus: true
            }

   var min = TextBox {
                translateX:200
                translateY:70
                text: bind minString with inverse
                columns: 5
                selectOnFocus: true
            }
   var delta = TextBox {
                translateX:200
                translateY:90
                text: bind deltaString with inverse
                columns: 5
                selectOnFocus: true
            }            
    override protected function create(): Node {
        Group {
            content: [levelBar, button,max,min,delta]
        }
    }

}