/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
import coc.script.Eval;

public class CaseStmt extends Statement{
	public var testExpr:Eval;
	public var valuesExpr:Eval;
	public var thenBlock:StmtList = new StmtList();
	public function CaseStmt(testAttr:String,valuesAttr:String="") {
		this.testExpr = testAttr ? Eval.compile(testAttr) : null;
		this.valuesExpr    = valuesAttr ? Eval.compile('['+valuesAttr+']') : null;
	}
	public function check(context:ExecContext,useValue:Boolean,checkValue:*):Boolean {
		if (useValue) {
			var values:Array = valuesExpr.call(context.thiz) as Array;
			if (values && values.indexOf(checkValue) >= 0) return true;
		}
		if (testExpr!=null) return testExpr.call(context.thiz);
		return false
	}

	override public function execute(context:ExecContext):void {
		context.execute(thenBlock);
	}
}
}
