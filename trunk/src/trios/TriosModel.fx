/*
 * TriosModel.fx
 *
 * Created on Jan 16, 2010, 9:24:10 AM
 */
package trios;

var cortexes = [
    CortexxEnum.CORTEX1,
   // CortexxEnum.CORTEX2,
   // CortexxEnum.CORTEX3,
   // CortexxEnum.CORTEX4
];

var lights = [
    LightEnum.LIGHT1,
    LightEnum.LIGHT2,
    LightEnum.LIGHT3,
    LightEnum.LIGHT4,
    LightEnum.LIGHT5,
    LightEnum.LIGHT6
];

// model initialization
public def c: Cortex[] = {
    for (i in cortexes){
        Cortex {id: i};
    }
}

public class Light {

    def minRange = 0;
    def maxRange = 100;
    def maxTime = 10000.0;


    // as string coming from XML
    public var value: String;
    public var min: String;
    public var max: String;
    public var delta: String;
    public var pinin: String;
    public var pinout: String;

    // as integers with conversion
    public var ivalue: Integer on replace {
        if ((imin != 0) and (imax != 0)) {
            if (ivalue < imin) ivalue = 0;
            if (ivalue > imax) ivalue = 100;
        }

    };

    var imin: Integer on replace {
        if (ivalue < imin) ivalue = 0;
    };

    var imax: Integer on replace {
        if (ivalue > imax) ivalue = 100;
    };

    var idelta: Integer;
    var ipinin: Integer;
    var ipinout: Integer;

    // some id
    public var id: LightEnum;
    public var name: String;

    function convertToRange(x: Integer): Integer {
        ((maxTime - x) / maxTime) * maxRange as Integer;
    }

    function convertToTime(x: Integer): Integer {
        (maxTime - (maxRange * x)) as Integer;
    }

    override function toString(): String {
        return " {value} {min} {max} {delta} {pinin} {pinout } \n";
    }

    function fromXml() {
        ivalue = convertToRange(Integer.parseInt(value));
        imin = convertToRange(Integer.parseInt(min));
        imax = convertToRange(Integer.parseInt(max));
        idelta = Integer.parseInt(delta);
        ipinin = Integer.parseInt(pinin);
        ipinout = Integer.parseInt(pinout);
    }

    function toXml(): String {

        value = String.valueOf(convertToTime(ivalue));
        min = String.valueOf(convertToTime(imin));
        max = String.valueOf(convertToTime(imax));
        delta = String.valueOf(idelta);
        pinin = String.valueOf(ipinin);
        pinout = String.valueOf(ipinout);

        return "<Light NAME=\"{name}\" VALUE=\"{value}\" MIN=\"{min}\" "
        "MAX=\"{max}\" DELTA=\"{delta}\" PININ=\"{pinin}\" PINOUT=\"{pinout}\" />"
        "\n";
    }
}

public class General {

    // as string coming from XML
    public var free1: String;
    public var watchdog: String;
    public var pvd: String;
    public var free2: String;
    public var free3: String;
    public var flags: String;

    override function toString(): String {
        return " {free1} {watchdog} {pvd} {free2} {free3} {flags } \n";
    }

    function toXml(): String {
        return "<GEN1>{free1}</GEN1>"
        "<GEN2>{watchdog}</GEN2>"
        "<GEN3>{pvd}</GEN3>"
        "<GEN4>{free2}</GEN4>"
        "<GEN5>{free3}</GEN5>"
        "<GEN6>{flags}</GEN6>"
        "\n";
    }
}

public class Cortex {
    // model class
    public def light = for (i in lights) Light {id: i};
    public def general = General {};
    public var id: CortexxEnum;
    public var name;

    public function toXml(): String {
        return 
        "<Cortex CORTEX=\"{name}\" >\n"
        "<Lights>\n"
        "{light[0].toXml()}"
        "{light[1].toXml()}"
        "{light[2].toXml()}"
        "{light[3].toXml()}"
        "{light[4].toXml()}"
        "{light[5].toXml()}"
        "</Lights>\n"
        "</Cortex>\n"
        //"<GENERAL>\n"
        //"{general.toXml()}"
        //"</GENERAL>\n"
    }

    public function fromXml() {
        for (l in light) {
            l.fromXml();
        }
    }
}
