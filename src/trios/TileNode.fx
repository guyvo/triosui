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

    public var rows: Integer;
    public var cols: Integer;
    public var tileHeigth: Integer;
    public var tileWidth: Integer;
    public var nodes: Node[];
    var tile = Tile {
                translateX: 10
                translateY: 10
                hgap: 10
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

