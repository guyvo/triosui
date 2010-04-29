/*
 * DetailView.fx
 *
 * Created on Feb 12, 2010, 10:29:36 AM
 */
package trios;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import trios.LevelBarNode.*;
import trios.TriosModel.*;
import javafx.scene.control.Button;
import javafx.scene.text.Font;
import javafx.scene.Group;
import javafx.scene.control.TextBox;
import javafx.scene.control.Label;
import javafx.scene.paint.Color;

/**
 * @author guy
 */
// place your code here


public class TriosDetailView extends CustomNode {

    def posLeft = 20;
    def posLabelsX = 100;
    def posLabelsY = 100;
    def spacingLabels = 50;
    def posEditsx = posLabelsX + 150;
    def widthEdits = 150;
    def heigthEdits = 35;
    def colorText = Color.CORAL;
    public-init var theCortex: CortexxEnum;
    public-init var theLight: Light;
    public-init var actionFunction: function(): Void;
    def temp = theLight;
    var imax = bind temp.imax with inverse on replace {
                maxString = String.valueOf(imax);
            };
    var imin = bind temp.imin with inverse on replace {
                minString = String.valueOf(imin)
            };
    var idelta = bind temp.idelta with inverse on replace {
                deltaString = String.valueOf(idelta);
            };
    var maxString: String on replace {
                imax = Integer.parseInt(maxString);
            };
    var minString: String on replace {
                imin = Integer.parseInt(minString);
            };
    var deltaString: String on replace {
                idelta = Integer.parseInt(deltaString);
            };
    def label = Label {
                translateX: posLeft
                translateY: 5
                textFill: colorText
                text: bind temp.name;
                font: Font {
                    name: "Arial"
                    size: 30
                }
            }
    def labelMax = Label {
                translateX: posLabelsX
                translateY: posLabelsY
                textFill: colorText
                text: "Maximum";
                font: Font {
                    name: "Arial"
                    size: 30
                }
            }
    def labelMin = Label {
                translateX: posLabelsX
                translateY: posLabelsY + spacingLabels
                textFill: colorText
                text: "Minimum";
                font: Font {
                    name: "Arial"
                    size: 30
                }
            }
    def labelStep = Label {
                translateX: posLabelsX
                translateY: posLabelsY + (2 * spacingLabels)
                textFill: colorText
                text: "Step";
                font: Font {
                    name: "Arial"
                    size: 30
                }
            }
    def max = TextBox {

                translateX: posEditsx
                translateY: posLabelsY
                height: heigthEdits
                width: widthEdits
                text: bind maxString with inverse
                columns: 10
                selectOnFocus: true
                font: Font {
                    name: "Arial"
                    size: 25
                }
            }
    def min = TextBox {
                translateX: posEditsx
                translateY: posLabelsY + spacingLabels
                height: heigthEdits
                width: widthEdits
                text: bind minString with inverse
                columns: 10
                selectOnFocus: true
                font: Font {
                    name: "Arial"
                    size: 25
                }
            }
    def delta = TextBox {
                translateX: posEditsx
                translateY: posLabelsY + (2 * spacingLabels)
                height: heigthEdits
                width: widthEdits
                text: bind deltaString with inverse
                columns: 5
                selectOnFocus: true
                font: Font {
                    name: "Arial"
                    size: 25
                }
            }
    def levelBar = VerticalBar {
                posx: posLeft
                posy: 100
                width: 70
                screenHeight: 700
                valmodel: bind temp.ivalue with inverse
            }
    def button = Button {
                translateX: posLeft + 70
                translateY: 620
                width: 350
                height: 80
                text: "Back to overview"
                font: Font {
                    name: "Arial"
                    size: 30
                }
                action: function () {
                    actionFunction();
                };
            }

    override protected function create(): Node {
        Group {
            content: [label, labelMax, labelMin, labelStep, levelBar, button, max, min, delta]
        }
    }

}
