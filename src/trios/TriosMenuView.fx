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
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;

/**
 * @author guy
 */
// place your code here
public class TriosMenuView extends CustomNode {
    var view : TriosCortexView[];

    init{
        for ( cortex in c ){
            insert
               TriosCortexView {
                    name: bind cortex.name
                    sensor: bind cortex.general.sensor
                    watchdog: bind cortex.general.watchdog
                    toggle: bind cortex.general.toggle
                    dimmer: bind cortex.general.dimmer
                    hours: bind cortex.general.hours
                    masks: bind cortex.general.masks
                }
             into view;
        }
    }


    def beginx = 20;
    def beginy = 20;
    def buttonHeigth = 100;
    def buttonWidth = 400;
    def spacing = 20;


    def gradient = LinearGradient {
            proportional: true
            startX: 0
            startY: 0
            endX: 0
            endY: 1.0
            stops: [
                Stop {offset: 0.6 color: Color.BLUE }
                Stop {offset: 0.9 color: Color.BLACK }
            ]
        }
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
                    fill: gradient

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
                    fill: gradient
                   
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
                    fill: gradient
                }
                action: function () {
                    mainStage.scene.content = [
                        for ( cortex in view where cortex.name == "Cortex1") cortex
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
                    fill: gradient
                }
                action: function () {
                   mainStage.scene.content = [
                        for ( cortex in view where cortex.name == "Cortex2") cortex
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
                    fill: gradient
                }
                action: function () {
                   mainStage.scene.content = [
                        for ( cortex in view where cortex.name == "Cortex3") cortex
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
                    fill: gradient
                }
                action: function () {
                   mainStage.scene.content = [
                        for ( cortex in view where cortex.name == "Cortex4") cortex
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

