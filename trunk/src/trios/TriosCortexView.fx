/*
 * TriosCortexView.fx
 *
 * Created on Mar 27, 2010, 11:24:49 AM
 */
package trios;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.control.Label;
import javafx.scene.Group;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.control.Button;
import trios.TriosView.*;
import com.sun.javafx.scene.control.caspian.ButtonSkin;
import javafx.scene.shape.Rectangle;
import javafx.scene.layout.VBox;

/**
 * @author guy
 */
// place your code here
public class TriosCortexView extends CustomNode {

    def beginx = 20;
    def beginy = 20;
    def offset = 200;
    def spacing = 50;
    public var name: String;
    public var sensor: String;
    public var watchdog: String;
    public var toggle: String;
    public var dimmer: String;
    public var hours: String;
    public var masks: String;
    var sensorLabel = LabelValueNode { labelText: "Temperature:" valueText: bind sensor };
    var watchdogLabel = LabelValueNode { labelText: "Watchdog:" valueText: bind watchdog };
    var toggleLabel = LabelValueNode { labelText: "Toggles:" valueText: bind toggle };
    var dimmerLabel = LabelValueNode { labelText: "Dimmers:" valueText: bind dimmer };
    var hoursLabel = LabelValueNode { labelText: "Hours:" valueText: bind hours };
    var masksLabel = LabelValueNode { labelText: "Masks:" valueText: bind masks };
    var nameLabel = LabelValueNode { labelText: "Cortex:" valueText: bind name };
    var backButton = Button {
                width: 400
                height: 100
                text: "Main menu"
                font: Font {
                    name: "Arial"
                    size: 30
                }
                skin: ButtonSkin {
                    cornerRadius: 20
                    textFill: Color.CORAL
                    fill: Color.LIGHTBLUE
                }
                action: function () {
                    setMenuView();
                }
            }

    override protected function create(): Node {
        Group {
            content: [
                VBox {
                    width:480
                    spacing: 20
                    content: [nameLabel, sensorLabel, watchdogLabel, toggleLabel, dimmerLabel, hoursLabel, masksLabel, backButton]
                }
            ]
        }
    }

}
