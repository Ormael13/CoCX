/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
import coc.script.Eval;

public class IfStmt extends Statement {
	public var expr:Eval;
	public var thenBlock:/*Statement*/Array = [];
	public var elseBlock:Statement          = null;

	public function IfStmt(condition:String) {
		super();
		this.expr = Eval.compile(condition);
	}

	override public function execute(context:ExecContext):void {
		if (expr.vcall(context.scopes)) {
			context.debug(this,'then');
			context.executeAll(thenBlock);
		} else if (elseBlock != null) {
			context.debug(this,'else');
			context.execute(elseBlock);
		} else {
			context.debug(this,'skip');
		}
	}

	public function toString():String {
		return '<if test="'+expr.src+'"> [then '+thenBlock.length+'] '+
				(elseBlock?'<else/> ':'')+'</if>';
	}
}
}
