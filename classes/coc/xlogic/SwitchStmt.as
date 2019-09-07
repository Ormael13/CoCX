/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
import coc.script.Eval;

public class SwitchStmt extends Statement{
	public var valueExpr:Eval;
	public var cases:/*CaseStmt*/Array = [];
	public var defaults:StmtList = new StmtList();

	public function SwitchStmt(valueAttr:String=null) {
		if (valueAttr) valueExpr = Eval.compile(valueAttr);
	}

	override public function execute(context:ExecContext):void {
		var hasValue:Boolean = valueExpr != null;
		var value:*          = hasValue ? valueExpr.vcall(context.scopes) : null;
		if (hasValue) context.debug(this,'value = '+value);
		else context.debug(this,'enter');
		for each (var block:CaseStmt in cases) {
			if (block.check(context, hasValue, value)) {
				context.execute(block);
				return;
			}
		}
		context.debug(this,'default');
		context.execute(defaults);
	}

	public function toString():String {
		return '<switch'+(valueExpr?' value="'+valueExpr.src+'">':'')+
				' [case '+cases.length+']'+
				' [default '+defaults.stmts.length+'] </switch>';
	}
}
}
