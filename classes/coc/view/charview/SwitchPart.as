/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.script.Eval;

public class SwitchPart extends ModelPart {
	private var valueExpr:Eval;
	private var cases:/*CaseBlock*/Array;
	private var defaultBlock:/*ModelPart*/Array;

	public function SwitchPart(valueAttr:String, cases:/*CaseBlock*/Array, defaultBlock:/*ModelPart*/Array) {
		this.valueExpr    = valueAttr != null ? Eval.compile(valueAttr) : null;
		this.cases        = cases;
		this.defaultBlock = defaultBlock;
	}


	override public function display(character:Object):void {
		var hasValue:Boolean = valueExpr != null;
		var value:*          = hasValue ? valueExpr.call(character) : null;
		for each (var block:CaseBlock in cases) {
			if (block.check(character, hasValue, value)) {
				block.display(character);
				return;
			}
		}
		for each (var part:ModelPart in defaultBlock) {
			part.display(character);
		}
	}
}
}
