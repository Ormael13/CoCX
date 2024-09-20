/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.view.CompositeImage;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class HideStatement extends Statement {
	private var part:String;
	private var image:CompositeImage;
	private var _prefix:Boolean;
	private var _hasVars:Boolean;

	public function HideStatement(image:CompositeImage, part:String) {
		this.image = image;
		this._prefix = CharViewCompiler.partIsPrefix(part);
		this.part = _prefix ? CharViewCompiler.partPrefix(part) : part;
		this._hasVars = CharViewCompiler.nameHasVars(part);
	}

	override public function execute(context:ExecContext):void {
		var name:String = this.part;
		if (_hasVars) {
			name = context.substituteVars(name);
		}
		context.debug(this,name);
		if (_prefix) {
			image.setVisibility(name, true, false);
		} else {
			image.setVisibility(name, false, false);
		}
	}
	
	
	public function toString():String {
		return "<hide part='"+part+"'>"+(_prefix?" [prefix+]":"")+(_hasVars?" [vars+]":"");
	}
}
}
