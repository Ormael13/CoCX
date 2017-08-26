/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
import coc.script.Eval;

public class IfBlock extends ModelPart{
	private var expr:Eval;
	private var thenBlock:/*ModelPart*/Array;

	public function IfBlock(condition:String,thenPart:/*ModelPart*/Array) {
		this.expr = Eval.compile(condition);
		this.thenBlock = thenPart;
	}

	override public function display(character:Object):void {
		if (!expr.call(character)) return;
		for each (var part:ModelPart in thenBlock) {
			part.display(character);
		}
	}
}
}
