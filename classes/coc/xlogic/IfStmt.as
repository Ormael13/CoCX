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
			context.executeAll(thenBlock);
		} else if (elseBlock != null) {
			context.execute(elseBlock);
		}
	}
}
}
