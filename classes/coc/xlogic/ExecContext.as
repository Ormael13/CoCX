/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic {
import classes.CoC;

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
	public function getValue(varname:String):* {
		for each (var s:* in _scopes) if (varname in s) return s[varname];
		return undefined;
	}
	public function setValue(varname:String,value:*):void {
		for each (var s:* in _scopes) {
			if (varname in s) {
				s[varname] = value;
				return;
			}
		}
		_scopes[0][varname] = value;
	}
	public function hasValue(varname:String):Boolean {
		for each (var s:* in _scopes) if (varname in s) return true;
		return false;
	}
	public function execute(stmt:Statement):void {
		stmt.execute(this);
	}
	public function executeAll(stmts:/*Statement*/Array):void {
		for each (var statement:Statement in stmts) {
			statement.execute(this);
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
	/**
	 * For debugging
	 */
	public function debug(where:Statement,s:String):void {
		if (!CoC.instance.debug) return;
		trace(''+where+' '+s);
	}
}
}
