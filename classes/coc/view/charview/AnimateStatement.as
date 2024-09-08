package coc.view.charview {
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class AnimateStatement extends Statement {
	public var layer:String;
	public var name:String;
	public var _prefix:Boolean;
	public var _hasVars:Boolean;
	
	public function AnimateStatement(layer:String, name:String) {
		this.name = name;
		var pp:Array = layer.match(/([^\*]*)\*/);
		if (pp) {
			this._prefix = true;
			this.layer = pp[1];
		} else {
			this.layer = layer;
		}
		this._hasVars = name.indexOf('$')>=0;
	}
	
	override public function execute(context:ExecContext):void {
		var cv: CharViewContext = context as CharViewContext;
		var name:String = this.name;
		if (_hasVars) {
			name = context.substituteVars(name);
		}
		if (_prefix) {
			cv.charview.composite.setMultiAnimation(layer, name);
		} else {
			cv.charview.composite.setAnimation(layer, name);
		}
	}
	
	public function toString():String {
		return '<animate layer="'+layer+'" name="'+name+'"/>'
	}
}
}
