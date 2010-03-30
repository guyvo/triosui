/*
 * MenuView.fx
 *
 * Created on Mar 27, 2010, 10:39:08 AM
 */
package trios;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.Group;
import trios.TriosView.*;
import trios.TriosModel.*;
import javafx.scene.text.Font;
import javafx.animation.transition.FadeTransition;
import com.sun.javafx.scene.control.caspian.ButtonSkin;
import javafx.scene.paint.Color;

/**
 * @author guy
 */
// place your code here
public class TriosMenuView extends CustomNode {

    def beginx = 20;
    def beginy = 20;
    def buttonHeigth = 100;
    def buttonWidth = 400;
    def spacing = 20;
    def overviewButton = Button {
                translateX: beginx
                translateY: beginy
                width: buttonWidth
                height: buttonHeigth;
                text: "Overview"
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
                    mainStage.scene.content = [
                        overview
                    ]

                }
            }
    def setupButton = Button {
                translateX: beginx
                translateY: beginy + buttonHeigth + spacing
                width: buttonWidth
                height: buttonHeigth;
                text: "Setup"
                skin: ButtonSkin {
                    cornerRadius: 20
                    textFill: Color.CORAL
                    fill: Color.LIGHTBLUE
                }
                font: Font {
                    name: "Arial"
                    size: 30
                }
                action: function () {

                }
            }
    def cortex1Button = Button {
                translateX: beginx
                translateY: beginy + 2 * (buttonHeigth + spacing)
                width: buttonWidth
                height: buttonHeigth;
                text: "Cortex 1"
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
                    mainStage.scene.content = [
                        TriosCortexView {
                            name: c[0].name
                            sensor: c[0].general.sensor
                            watchdog: c[0].general.watchdog
                            toggle: c[0].general.toggle
                            dimmer: c[0].general.dimmer
                            hours: c[0].general.hours
                            masks: c[0].general.masks
                        }
                    ];

                }
            }
    def cortex2Button = Button {
                translateX: beginx
                translateY: beginy + 3 * (buttonHeigth + spacing)
                width: buttonWidth
                height: buttonHeigth;
                text: "Cortex 2"
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
                    mainStage.scene.content = [
                        TriosCortexView {
                            name: c[1].name
                            sensor: c[1].general.sensor
                            watchdog: c[1].general.watchdog
                            toggle: c[1].general.toggle
                            dimmer: c[1].general.dimmer
                            hours: c[1].general.hours
                            masks: c[1].general.masks
                        }
                    ];
                }
            }
    def cortex3Button = Button {
                translateX: beginx
                translateY: beginy + 4 * (buttonHeigth + spacing)
                width: buttonWidth
                height: buttonHeigth;
                text: "Cortex 3"
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
                    mainStage.scene.content = [
                        TriosCortexView {
                            name: c[2].name
                            sensor: c[2].general.sensor
                            watchdog: c[2].general.watchdog
                            toggle: c[2].general.toggle
                            dimmer: c[2].general.dimmer
                            hours: c[2].general.hours
                            masks: c[2].general.masks
                        }
                    ];
                }
            }
    def cortex4Button = Button {
                translateX: beginx
                translateY: beginy + 5 * (buttonHeigth + spacing)
                width: buttonWidth
                height: buttonHeigth;
                text: "Cortex 4"
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
                    mainStage.scene.content = [
                        TriosCortexView {
                            name: c[3].name
                            sensor: c[3].general.sensor
                            watchdog: c[3].general.watchdog
                            toggle: c[3].general.toggle
                            dimmer: c[3].general.dimmer
                            hours: c[3].general.hours
                            masks: c[3].general.masks
                        }
                    ];
                }
            }
    def mainScreen = Group {
                content: [
                    overviewButton,
                    setupButton,
                    cortex1Button,
                    cortex2Button,
                    cortex3Button,
                    cortex4Button
                ]
            }
    public var fadeTransition = FadeTransition {
                duration: 2s
                node: mainScreen
                fromValue: 0.1
                toValue: 1
                repeatCount: 2
                autoReverse: false
            }

    override protected function create(): Node {
        mainScreen
    }

}

