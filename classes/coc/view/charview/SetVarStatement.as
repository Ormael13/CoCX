/**
 * Coded by aimozg on 30.08.2019.
 */
package coc.view.charview {
import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class SetVarStatement extends Statement {
	public var name:String;
	public var expr:Eval;
	
	public function SetVarStatement(name:String,expr:String) {
		this.name = name;
		this.expr = Eval.compile(expr);
	}
	
	override public function execute(context:ExecContext):void {
		var value:* = expr.vcall(context.scopes);
		context.debug(this," -> "+value);
		context.scopes[0][name] = value;
	}
	
	public function toString():String {
		return "<set var='"+name+"' value=\""+expr.src+"\">"
	}
}
}
