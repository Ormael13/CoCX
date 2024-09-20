/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.view.CompositeImage;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class ShowStatement extends Statement {
	private var part:String;
	private var image:CompositeImage;
	private var visible:Boolean;
	private var _hasVars:Boolean;
	private var animation:String;
	
	public function ShowStatement(image:CompositeImage, part:String, animation:String) {
		this.image = image;
		this.visible = true;
		this.part = part;
		this._hasVars = CharViewCompiler.nameHasVars(part);
		this.animation = animation;
	}

	override public function execute(context:ExecContext):void {
		var name:String = this.part;
		if (_hasVars) {
			name = context.substituteVars(name);
		}
		context.debug(this,name);
		image.setVisibility(name, false, visible);
		if (animation) image.setAnimation(name, false, animation);
	}
	
	
	public function toString():String {
		return "<"+(visible?"show":"hide")+" part='"+part+"'>"+(_hasVars?" [vars+]":"");
	}
}
}
