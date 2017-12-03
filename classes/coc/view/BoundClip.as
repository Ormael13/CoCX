/**
 * Coded by aimozg on 02.12.2017.
 */
package coc.view {
import flash.display.MovieClip;
import flash.display.Sprite;

public class BoundClip extends MovieClip{
	public static var nextContent:Sprite;
	public function BoundClip() {
		if (nextContent != null) {
			addChild(nextContent);
		}
	}
	
}
}
