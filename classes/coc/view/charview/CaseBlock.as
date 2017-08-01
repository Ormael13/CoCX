/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.script.Eval;

public class CaseBlock extends ModelPart {
	private var testExpr:Eval;
	private var valuesExpr:Eval;
	private var body:/*ModelPart*/Array;
	public function CaseBlock(testAttr:String,valuesAttr:String,body:/*ModelPart*/Array) {
		if (testAttr != null) this.testExpr = Eval.compile(testAttr);
		if (valuesAttr != null) this.valuesExpr = Eval.compile(valuesAttr);
		this.body = body;
	}
	public function check(character:Object,useValue:Boolean,checkValue:*):Boolean {
		if (useValue) {
			var values:Array = valuesExpr.call(character) as Array;
			if (values && values.indexOf(checkValue) >= 0) return true;
		}
		if (testExpr!=null) return testExpr.call(character);
		return null
	}

	override public function display(character:Object):void {
		for each (var part:ModelPart in body) {
			part.display(character);
		}
	}
}
}
