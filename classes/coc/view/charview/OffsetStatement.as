package coc.view.charview {
import coc.view.CompositeImage;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class OffsetStatement extends Statement {
	private var image:CompositeImage;
	private var _prefix:Boolean;
	private var _hasVars:Boolean;
	private var part:String;
	private var dx:int;
	private var dy:int;
	private var layer:String;
	
	public function OffsetStatement(
			image:CompositeImage,
			part:String,
			dx:int,
			dy:int,
			layer:String
	) {
		this.image    = image;
		this._prefix  = CharViewCompiler.partIsPrefix(part);
		this.part     = _prefix ? CharViewCompiler.partPrefix(part) : part;
		this._hasVars = CharViewCompiler.nameHasVars(part);
		this.dx       = dx;
		this.dy       = dy;
		this.layer    = layer ? layer+'/' : null;
	}
	
	
	override public function execute(context:ExecContext):void {
		var name:String = this.part;
		if (_hasVars) {
			name = context.substituteVars(name);
		}
		context.debug(this,name);
		image.setOffset(name, _prefix, dx, dy, layer);
	}
	
	public function toString():String {
		return '<offset part="' + part +
				'" dx="' + dx +
				'" dy="' + dy +
				(layer ? '" layer="' + layer + '"' : '"') + '/>'
	}
}
}
