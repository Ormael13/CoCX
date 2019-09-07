/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview {

import coc.script.Eval;

import coc.view.*;
import coc.xlogic.Compiler;
import coc.xlogic.Statement;

public class CharViewCompiler extends Compiler{
	private var charview:CharView;
	public function CharViewCompiler(charview:CharView) {
		this.charview = charview;
	}

	override protected function unknownTag(tag:String, x:XML):Statement {
		var attrs:* = attrMap(x);
		switch (tag){
			case 'set':
				if ('value' in attrs) {
					return new SetVarStatement(attrs['var'], attrs['value']);
				} else {
					return new SetVarStatement(attrs['var'], '"'+Eval.escapeString(x.text().toString())+'"');
				}
			case 'show':
				return new LayerPart(charview.composite, attrs['part'], true);
			case 'hide':
				return new LayerPart(charview.composite, attrs['part'], false);
		}
		return super.unknownTag(tag, x);
	}
}
}
