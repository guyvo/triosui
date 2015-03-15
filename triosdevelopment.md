linking an embedded system with a front end written in javaFx

# Introduction #

Programs involved:

  * embedded program using freeRTOS traget cortex STM32 written C
  * USB2serial driver written in ansi C
  * front end UI written in java/javaFx

# Details #

  * Netbeans IDE
  * XCODE IDE
  * Ride7 / Keil IDE

# Scoop #

Only the front end will be covered in this project

```
var mainStage = Stage {
            title: "TriosView"
            scene: Scene {

                fill: Color.BLACK
                width: SCREENWIDTH
                height: SCREENHEIGTH
                content: []
            }
}
```