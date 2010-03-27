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
import trios.TriosView.mainStage;
import trios.TriosView.menuView;
import trios.TriosView.setMenuView;

/**
 * @author guy
 */
// place your code here
public class TriosCortexView extends CustomNode {

    def beginx = 20;
    def beginy = 20;
    def spacing = 50;
    public var name;
    public var sensor;
    public var watchdog;
    public var toggle;
    public var dimmer;
    public var hours;
    public var masks;
    var sensorLabel = Label {
                translateX: beginx
                translateY: beginy
                text: "Temperature:        {sensor}"
                textFill: Color.CORAL
                font: Font {
                    name: "Courier"
                    size: 30
                }
            }
    var watchdogLabel = Label {
                translateX: beginx
                translateY: beginy + spacing
                text: "Watchdog count:     {watchdog}"
                textFill: Color.CORAL
                font: Font {
                    name: "Courier"
                    size: 30
                }
            }
    var toggleLabel = Label {
                translateX: beginx
                translateY: beginy + 2 * spacing
                text: "Toggle count:       {toggle}"
                textFill: Color.CORAL
                font: Font {
                    name: "Courier"
                    size: 30
                }
            }
    var dimmerLabel = Label {
                translateX: beginx
                translateY: beginy + 3 * spacing
                text: "Dimmer count:       {dimmer}"
                textFill: Color.CORAL
                font: Font {
                    name: "Courier"
                    size: 30
                }
            }
    var hoursLabel = Label {
                translateX: beginx
                translateY: beginy + 4 * spacing
                text: "Hours up:           {hours}"
                textFill: Color.CORAL
                font: Font {
                    name: "Courier"
                    size: 30
                }
            }
    var masksLabel = Label {
                translateX: beginx
                translateY: beginy + 5 * spacing
                text: "Masks:              {masks}"
                textFill: Color.CORAL
                font: Font {
                    name: "Courier"
                    size: 30
                }
            }
    var backButton = Button {
                translateX: beginx
                translateY: beginy + 6 * spacing
                width: 375
                height: 200
                text: "Main menu"
                font: Font {
                    name: "Arial"
                    size: 30
                }
                action: function () {
                    setMenuView();
                }
            }
    var nameLabel = Label {
                translateX: beginx
                translateY: 700
                text: "Counters for {name}"
                textFill: Color.CORAL
                font: Font {
                    name: "Courier"
                    size: 30
                }
            }

    override protected function create(): Node {
        Group {
            content: [sensorLabel, watchdogLabel, toggleLabel, dimmerLabel, hoursLabel, masksLabel, backButton,nameLabel]
        }
    }

}
