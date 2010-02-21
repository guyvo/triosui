/*
 * TimeLine.fx
 *
 * Created on Feb 11, 2010, 5:45:05 PM
 */

package trios;

import javafx.animation.Timeline;
import javafx.animation.KeyFrame;


/**
 * @author guy
 */

// place your code here

public class ScreenBlockTimer extends Timeline {
    public var waitTime : Duration;
    public var actionFunction : function () : Void;
   
    public var timeline = Timeline {
        repeatCount: Timeline.INDEFINITE
        interpolate: false
        keyFrames: [
            KeyFrame {
                time: waitTime
                action: actionFunction
            }
        ]
    }
    
}

public class RefreshTimer extends Timeline {
    public var waitTime : Duration;
    public var actionFunction : function () : Void;

    public var timeline = Timeline {
        repeatCount: Timeline.INDEFINITE
        interpolate: false
        keyFrames: [
            KeyFrame {
                time: waitTime
                action: actionFunction
            }
        ]
    }

}




