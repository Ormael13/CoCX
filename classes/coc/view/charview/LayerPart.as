/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.view.CharView;
import coc.view.CompositeImage;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class LayerPart extends Statement {
	private var name:String;
	private var image:CompositeImage;
	private var visible:Boolean;
	private var _prefix:Boolean;

	public function LayerPart(image:CompositeImage,name:String,visible:Boolean) {
		this.image = image;
		this.visible = visible;
		this.name = name;
		var pp:Array = name.match(/([^\/]+\/)\*/);
		if (pp) {
			this._prefix = true;
			this.name = pp[1];
		}
	}

	override public function execute(context:ExecContext):void {
		if (_prefix) {
			image.setMultiVisibility(name,visible);
		} else {
			image.setVisibility(name, visible);
		}
	}
}
}
