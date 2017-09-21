/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
public class ExecContext {
	public function ExecContext(_thiz:Array) {
		this._scopes = _thiz;
	}
	private var _scopes:Array = [];
	public function get scopes():Array {
		return _scopes;
	}
	public function set scopes(value:Array):void {
		_scopes = value;
	}
	public function execute(stmt:Statement):void {
		stmt.execute(this);
	}
	public function executeAll(stmts:/*Statement*/Array):void {
		for each (var statement:Statement in stmts) {
			execute(statement);
		}
	}
	public function error(where:Statement,message:String):void {
		throw new Error("In "+where+": "+message);
	}
	public function pushScope(scope:Object):void {
		scopes.unshift(scope);
	}
	public function popScope():void {
		scopes.shift();
	}
}
}
