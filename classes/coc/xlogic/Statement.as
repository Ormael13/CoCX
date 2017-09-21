/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
import classes.CoC_Settings;

public class Statement {
	public function Statement() {
	}
	public function execute(context:ExecContext):void{
		CoC_Settings.errorAMC("coc.xlogic.Statement","execute",""+this);
	}
}
}
