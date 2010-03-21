/*
 * LightMap.fx
 *
 * Created on Feb 15, 2010, 8:55:37 PM
 */
package trios;

import javafx.data.Pair;
import trios.LightEnum;
import trios.CortexxEnum;

/**
 * @author guy
 */
// place your code here

def cortex1Map: Pair[] = {
            [
                Pair { name: LightEnum.OUT1.toString() value: "toilet beneden     " },
                Pair { name: LightEnum.OUT2.toString() value: "berging            " },
                Pair { name: LightEnum.OUT3.toString() value: "vide draad brug    " },
                Pair { name: LightEnum.OUT4.toString() value: "garage             " },
                Pair { name: LightEnum.OUT5.toString() value: "vrij               " },
                Pair { name: LightEnum.OUT6.toString() value: "living voor        " },
            ]
        };
def cortex2Map: Pair[] = {
            [
                Pair { name: LightEnum.OUT1.toString() value: "living midden      " },
                Pair { name: LightEnum.OUT2.toString() value: "slaapkamer beneden " },
                Pair { name: LightEnum.OUT3.toString() value: "slaapkamer 1       " },
                Pair { name: LightEnum.OUT4.toString() value: "slaapkamer 4       " },
                Pair { name: LightEnum.OUT5.toString() value: "wand trap          " },
                Pair { name: LightEnum.OUT6.toString() value: "hal passage        " },
            ]
        };
def cortex3Map: Pair[] = {
            [
                Pair { name: LightEnum.OUT1.toString() value: "wand living        " },
                Pair { name: LightEnum.OUT2.toString() value: "living achter      " },
                Pair { name: LightEnum.OUT3.toString() value: "keuken tafel       " },
                Pair { name: LightEnum.OUT4.toString() value: "keuken werkblad    " },
                Pair { name: LightEnum.OUT5.toString() value: "vrij               " },
                Pair { name: LightEnum.OUT6.toString() value: "terras buitendeur  " },
            ]
        };
def cortex4Map: Pair[] = {
            [
                Pair { name: LightEnum.OUT1.toString() value: "badkamer beneden   " },
                Pair { name: LightEnum.OUT2.toString() value: "zolder             " },
                Pair { name: LightEnum.OUT3.toString() value: "badkamer boven     " },
                Pair { name: LightEnum.OUT4.toString() value: "slaapkamer 2       " },
                Pair { name: LightEnum.OUT5.toString() value: "slaapkamer 3       " },
                Pair { name: LightEnum.OUT6.toString() value: "vrij               " },
            ]
        }

public class CortexLightMap {

    public-init var cortex: CortexxEnum;
    public-init var theMap: Pair[];

    init {
        if (cortex == CortexxEnum.Cortex1) {
            theMap = cortex1Map;
        } else if (cortex == CortexxEnum.Cortex2) {
            theMap = cortex2Map;
        } else if (cortex == CortexxEnum.Cortex3) {
            theMap = cortex3Map;
        } else if (cortex == CortexxEnum.Cortex4) {
            theMap = cortex4Map;
        }

    }

}
