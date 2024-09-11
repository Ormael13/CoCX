/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview {

import coc.script.Eval;
import coc.view.*;
import coc.xlogic.Compiler;
import coc.xlogic.Statement;

public class CharViewCompiler extends Compiler {
	public static function nameHasVars(name:String):Boolean {
		return name.indexOf('$')>=0;
	}
	public static function partIsPrefix(part:String):Boolean {
		return !!part.match(/^[^\*]*\*$/);
	}
	public static function partPrefix(part:String):String {
		return part.substring(0, part.length-1);
	}
	
	private var charview:CharView;
	
	public function CharViewCompiler(charview:CharView) {
		this.charview = charview;
	}
	
	override protected function unknownTag(tag:String, x:XML):Statement {
		var attrs:* = attrMap(x);
		switch (tag) {
			case 'set':
				if ('value' in attrs) {
					return new SetVarStatement(attrs['var'], attrs['value']);
				} else {
					return new SetVarStatement(attrs['var'], '"' + Eval.escapeString(x.text().toString()) + '"');
				}
			case 'show':
				return new ShowStatement(
						charview.composite,
						attrs['part'],
						'animation' in attrs ? attrs['animatiton'] : null
				);
			case 'hide':
				return new HideStatement(charview.composite, attrs['part']);
			case 'animate':
				return new AnimateStatement(charview.composite, attrs['part'] || attrs['layer'], attrs['name']);
			case 'offset':
				return new OffsetStatement(charview.composite, attrs['part'], attrs['dx'], attrs['dy'], attrs['layer']);
		}
		return super.unknownTag(tag, x);
	}
}
}
