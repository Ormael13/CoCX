/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.view.CharView;
import coc.view.CompositeImage;

public class LayerPart extends ModelPart {
	private var name:String;
	private var image:CompositeImage;

	public function LayerPart(image:CompositeImage,name:String) {
		this.image = image;
		this.name = name;
	}

	override public function display(character:Object):void {
		image.setVisibility(name,character);
	}
}
}
