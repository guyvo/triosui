/*
 * TriosModel.fx
 *
 * Created on Jan 16, 2010, 9:24:10 AM
 */
package trios;

import trios.LightMap.*;

public-read var cortexes = [
    CortexxEnum.Cortex1,
    CortexxEnum.Cortex2,
    CortexxEnum.Cortex3,
    CortexxEnum.Cortex4
];

public-read var lights = [
    LightEnum.OUT1,
    LightEnum.OUT2,
    LightEnum.OUT3,
    LightEnum.OUT4,
    LightEnum.OUT5,
    LightEnum.OUT6
];

// model initialization
public def c: Cortex[] = {
    for (i in cortexes){
        Cortex {
                id: i
                name: i.toString()
        };
    }
}

public class Light {

    def minRange = 0;
    def maxRange = 100;
    def maxTime = 10000.0;


    // as string coming from XML
    public var value: String;
    public var id: String;
    public var name: String;

    public var min: String on replace{
        if ( min != "") imin = convertToRange(Integer.parseInt(min));

    };

    public var max: String on replace{
        if (max != "") imax = convertToRange(Integer.parseInt(max));
    };

    public var delta: String on replace{
        if ( delta != "") idelta = Integer.parseInt(delta);

    };
    
    public var pinin: String;
    public var pinout: String;

    // as integers with conversion
    public var ivalue: Integer on replace {
        if ((imin != 0) and (imax != 0)) {
            if (ivalue < imin) ivalue = 0;
            if (ivalue > imax) ivalue = 100;
        }
    };

    public var imin: Integer on replace {
        if (ivalue < imin) ivalue = 0;
    };

    public var imax: Integer on replace {
        if (ivalue > imax) ivalue = 100;
    };

    public var idelta: Integer;
    public var ipinin: Integer;
    public var ipinout: Integer;

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
    public-init var free1: String;
    public-init var watchdog: String;
    public-init var pvd: String;
    public-init var free2: String;
    public-init var free3: String;
    public-init var flags: String;

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

    def general = General {};

    public-init var light : Light[];
    public-init var id: CortexxEnum;
    public-init var name;

    var mapping: CortexLightMap;

    init {
        mapping = CortexLightMap { cortex: id }
        for ( map in mapping.theMap ){
            insert Light{id : map.name name:map.value} into light
        }
    }

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
