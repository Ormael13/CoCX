/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview {
import coc.view.*;
import coc.xlogic.ExecContext;

public class CharViewContext extends ExecContext{
	private var charview:CharView;
	public function CharViewContext(charview:CharView,character:*) {
		super([character]);
		this.charview = charview;
	}
}
}
