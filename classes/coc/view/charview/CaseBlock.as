/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.script.Eval;

public class CaseBlock extends ModelPart {
	private var testExpr:Eval;
	private var valueExpr:Eval;
	private var body:/*ModelPart*/Array;
	public function CaseBlock(testAttr:String,valueAttr:String,body:/*ModelPart*/Array) {
		if (testAttr != null) this.testExpr = Eval.compile(testAttr);
		if (valueAttr != null) this.valueExpr = Eval.compile(valueAttr);
		this.body = body;
	}
	public function check(character:Object,useValue:Boolean,checkValue:*):Boolean {
		if (useValue && valueExpr.call(character) == checkValue) return true;
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
