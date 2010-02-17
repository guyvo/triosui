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
                Pair { name: LightEnum.OUT1.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT2.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT3.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT4.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT5.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT6.toString() value: "abcdefghjklmnopqrstuvwyz" },
            ]
        };
def cortex2Map: Pair[] = {
            [
                Pair { name: LightEnum.OUT1.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT2.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT3.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT4.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT5.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT6.toString() value: "abcdefghjklmnopqrstuvwyz" },
            ]
        };
def cortex3Map: Pair[] = {
            [
                Pair { name: LightEnum.OUT1.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT2.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT3.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT4.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT5.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT6.toString() value: "abcdefghjklmnopqrstuvwyz" },
            ]
        };
def cortex4Map: Pair[] = {
            [
                Pair { name: LightEnum.OUT1.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT2.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT3.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT4.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT5.toString() value: "abcdefghjklmnopqrstuvwyz" },
                Pair { name: LightEnum.OUT6.toString() value: "abcdefghjklmnopqrstuvwyz" },
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
