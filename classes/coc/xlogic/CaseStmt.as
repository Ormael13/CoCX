/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
import coc.script.Eval;

public class CaseStmt extends Statement {
	private var testExpr:Eval;
	private var valueExpr:Eval;
	private var valuesExpr:Eval;
	private var ltExpr:Eval;
	private var lteExpr:Eval;
	private var gtExpr:Eval;
	private var gteExpr:Eval;
	private var neExpr:Eval;
	public var thenBlock:StmtList = new StmtList();
	public function set testAttr(value:String):void {
		testExpr = value ? Eval.compile(value) : null;
	}
	public function set valueAttr(value:String):void {
		valueExpr = value ? Eval.compile(value) : null;
	}
	public function set valuesAttr(value:String):void {
		valuesExpr = value ? Eval.compile('[' + value + ']') : null;
	}
	public function set ltAttr(value:String):void {
		ltExpr = value ? Eval.compile(value) : null;
	}
	public function set lteAttr(value:String):void {
		lteExpr = value ? Eval.compile(value) : null;
	}
	public function set gtAttr(value:String):void {
		gtExpr = value ? Eval.compile(value) : null;
	}
	public function set gteAttr(value:String):void {
		gteExpr = value ? Eval.compile(value) : null;
	}
	public function set neAttr(value:String):void {
		neExpr = value ? Eval.compile(value) : null;
	}
	public function CaseStmt() {
	}
	public function check(context:ExecContext, useValue:Boolean, checkValue:*):Boolean {
		if (testExpr != null && testExpr.vcall(context.scopes)) {
			context.debug(this, ' => test true');
			return true;
		}
		if (useValue) {
			var pass:Boolean = true;
			if (valueExpr) pass &&= checkValue == valueExpr.vcall(context.scopes);
			if (valuesExpr) pass &&= valuesExpr.vcall(context.scopes).indexOf(checkValue) >= 0;
			if (ltExpr) pass &&= checkValue < ltExpr.vcall(context.scopes);
			if (lteExpr) pass &&= checkValue <= lteExpr.vcall(context.scopes);
			if (gtExpr) pass &&= checkValue > gtExpr.vcall(context.scopes);
			if (gteExpr) pass &&= checkValue >= gteExpr.vcall(context.scopes);
			if (neExpr) pass &&= checkValue != neExpr.vcall(context.scopes);
			context.debug(this, pass?'value pass':'value fail');
			return pass;
		}
		context.debug(this, 'skip');
		return false;
	}

	override public function execute(context:ExecContext):void {
		context.execute(thenBlock);
	}

	public function toString():String {
		return '<case' +
				(testExpr ? ' test="' + testExpr.src + '"' : '') +
				(valueExpr ? ' value="' + valueExpr.src + '"' : '') +
				(valuesExpr ? ' values="' + valuesExpr.src + '"' : '') +
				(ltExpr ? ' lt="' + ltExpr.src + '"' : '') +
				(lteExpr ? ' lte="' + lteExpr.src + '"' : '') +
				(gtExpr ? ' gt="' + gtExpr.src + '"' : '') +
				(gteExpr ? ' gte="' + gteExpr.src + '"' : '') +
				(neExpr ? ' ne="' + neExpr.src + '"' : '') +
				'> [' + thenBlock.stmts.length + '] </case>'
	}
}
}
