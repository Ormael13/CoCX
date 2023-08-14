package coc.view {
import flash.display.BitmapData;
import flash.display.Graphics;

/**
 * Cuts an image into 9 parts:
 * ```
 *  <-l-> <-cW-> <-r-->
 * |     |      |      | ^
 * |  0  |  1   |  2   | | top
 * |     |      |      | v
 * +-----+------+------+
 * |     |      |      | ^
 * |  3  |  4   |  5   | | centerHeight
 * |     |      |      | v
 * +-----+------+------+
 * |     |      |      | ^
 * |  6  |  7   |  8   | | bottom
 * |     |      |      | v
 * +-----+------+------+
 * ```
 * and covers another image with it:
 * * parts 0, 2, 6, 8 - not stretched
 * * parts 1, 7 - streched horizontally
 * * parts 3, 5 - streched vertically
 * * part 4 - streched in both axis
 */
public class BorderImage {
	public function BorderImage(
            source: BitmapData,
            top: int,
            bottom: int,
            left: int,
            right: int
    ) {
        var width:int = source.width;
        var height:int = source.height;
        this.top = top;
        this.bottom = bottom;
        this.left = left;
        this.right = right;
        centerWidth = Math.max(0, width - left - right);
        centerHeight = Math.max(0, height - top - bottom);
        parts = [];
        var x0:int = 0,
            x1:int = left,
            x2:int = left+centerWidth,
            w0:int = left,
            w1:int = centerWidth,
            w2:int = right,
            y0:int = 0,
            y1:int = top,
            y2:int = top+centerHeight,
            h0:int = top,
            h1:int = centerHeight,
            h2:int = bottom;
        parts[0] = UIUtils.subsprite(source, x0, y0, w0, h0);
        parts[1] = UIUtils.subsprite(source, x1, y0, w1, h0);
        parts[2] = UIUtils.subsprite(source, x2, y0, w2, h0);
        parts[3] = UIUtils.subsprite(source, x0, y1, w0, h1);
        parts[4] = UIUtils.subsprite(source, x1, y1, w1, h1);
        parts[5] = UIUtils.subsprite(source, x2, y1, w2, h1);
        parts[6] = UIUtils.subsprite(source, x0, y2, w0, h2);
        parts[7] = UIUtils.subsprite(source, x1, y2, w1, h2);
        parts[8] = UIUtils.subsprite(source, x2, y2, w2, h2);
	}
    private var top:int;
    private var bottom:int;
    private var left:int;
    private var right:int;
    private var centerWidth:int;
    private var centerHeight:int;
    public var parts:/*BitmapData*/Array;
    
    public function drawOver(dst:Graphics, dstWidth:int, dstHeight:int, fillCenter:Boolean):void {
        dst.lineStyle();
        var dstCenterWidth:int = Math.max(0, dstWidth - left - right);
        var dstCenterHeight:int = Math.max(0, dstHeight - top - bottom);
        var widths:/*int*/Array = [left, dstCenterWidth, right];
        var heights:/*int*/Array = [top, dstCenterHeight, bottom];
        var y:int = 0, k:int = 0;
        
        for (var i:int = 0; i < 3; i++) {
            var x:int = 0;
            for (var j:int = 0; j < 3; j++) {
                UIUtils.drawBitmap(dst, parts[k], x, y, widths[j], heights[i]);
                x += widths[j];
                k++;
            }
            y += heights[i];
        }
    }
}
}
