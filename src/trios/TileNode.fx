/*
 * TileNode.fx
 *
 * Created on Jan 18, 2010, 7:14:02 PM
 */
package trios;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.layout.Tile;
import javafx.geometry.VPos;
import javafx.geometry.HPos;

/**
 * @author guy
 */
public class TileNode extends CustomNode {

    public-init var rows: Integer;
    public-init var cols: Integer;
    public-init var tileHeigth: Integer;
    public-init var tileWidth: Integer;
    public-init var nodes: Node[];
    def tile = Tile {
                translateX: 10
                translateY: 40
                hgap: 5
                vgap: 1
                columns: bind cols
                rows: bind rows
                tileHeight: bind tileHeigth
                tileWidth: bind tileWidth
                nodeVPos: VPos.BOTTOM
                nodeHPos: HPos.LEFT
                content: nodes
            }

    override protected function create(): Node {
        tile
    }
}

