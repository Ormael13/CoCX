/**
 * Coded by aimozg on 06.08.2017.
 */
package coc.view.charview {
import flash.display.BitmapData;

public class CharViewSprite {
	public var bmp:BitmapData;
	public var dx:int;
	public var dy:int;
	public function CharViewSprite(
			bmp:BitmapData,
			dx:int,
			dy:int
	) {
		this.bmp = bmp;
		this.dx = dx;
		this.dy = dy;
	}
}
}
