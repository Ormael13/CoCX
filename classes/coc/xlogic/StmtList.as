/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
public class StmtList extends Statement{
	private var _stmts:/*Statement*/Array = [];

	public function get stmts():Array {
		return _stmts;
	}
	public function StmtList(init:/*Statement*/Array = null) {
		if (init!=null) _stmts.push.apply(_stmts,init);
	}

	override public function execute(context:ExecContext):void {
		context.executeAll(_stmts);
	}
}
}
