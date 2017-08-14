/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.view.CharView;
import coc.view.CompositeImage;

public class LayerPart extends ModelPart {
	private var name:String;
	private var image:CompositeImage;
	private var visible:Boolean;

	public function LayerPart(image:CompositeImage,name:String,visible:Boolean) {
		this.image = image;
		this.name = name;
		this.visible = visible;
	}

	override public function display(character:Object):void {
		image.setVisibility(name,visible);
	}
}
}
