/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.view.CompositeImage;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class LayerPart extends Statement {
	private var name:String;
	private var image:CompositeImage;
	private var visible:Boolean;
	private var _prefix:Boolean;
	private var _hasVars:Boolean;

	public function LayerPart(image:CompositeImage,name:String,visible:Boolean) {
		this.image = image;
		this.visible = visible;
		this.name = name;
		var pp:Array = name.match(/([^\/]+\/)\*/);
		if (pp) {
			this._prefix = true;
			this.name = pp[1];
		}
		this._hasVars = name.indexOf('$')>=0;
	}

	override public function execute(context:ExecContext):void {
		var name:String = this.name;
		if (_hasVars) {
			name = name.replace(/\$(\w+)/g,function():String{
				return context.getValue(arguments[1]);
			});
		}
		context.debug(this,name);
		if (_prefix) {
			image.setMultiVisibility(name,visible);
		} else {
			image.setVisibility(name, visible);
		}
	}
	
	
	public function toString():String {
		return "<"+(visible?"show":"hide")+" part='"+name+"'>"+(_prefix?" [prefix+]":"")+(_hasVars?" [vars+]":"");
	}
}
}
