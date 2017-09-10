/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview {
import coc.view.*;
import coc.view.charview.LayerPart;
import coc.xlogic.Compiler;
import coc.xlogic.Statement;

public class CharViewCompiler extends Compiler{
	private var charview:CharView;
	public function CharViewCompiler(charview:CharView) {
		this.charview = charview;
	}

	override protected function unknownTag(tag:String, x:XML):Statement {
		switch (tag){
			case 'show':
				return new LayerPart(charview.composite, x.@part, true);
			case 'hide':
				return new LayerPart(charview.composite, x.@part, false);
		}
		return super.unknownTag(tag, x);
	}
}
}
