/**
 * Coded by aimozg on 12.07.2017.
 */
package coc.script {

public class Eval {

	private var _src:String;
	private var _code:*;
	public function get src():String {
		return _src;
	}
	public function call(...scopes:/*Object*/Array):* {
		try {
			return EvalCompiler.execute(_code, scopes);
		} catch (e:Error){
			error(_src,"",e.message,false);
		}
	}
	public function vcall(scopes:/*Object*/Array):* {
		try {
			return EvalCompiler.execute(_code, scopes);
		} catch (e:Error){
			error(_src,"",e.message,false);
		}
	}

	public function Eval(expr:String, code:*) {
		this._src   = expr;
		this._code  = code;
	}

	public static function eval(thiz:*, expr:String):* {
		if (expr.match(EvalCompiler.RX_INT)) return parseInt(expr);
		if (expr.match(EvalCompiler.RX_FLOAT)) return parseFloat(expr);
		if (expr.match(EvalCompiler.RX_SIMPLESTRING)) return expr.substring(1, expr.length-1);
		return compile(expr).call(thiz);
	}
	public static function compile(expr:String):Eval {
		return new Eval(expr, EvalCompiler.compile(expr));
	}
	private static function error(src:String, expr:String, msg:String, tail:Boolean = true):Error {
		return new Error("In expr: "+src+"\n"+msg+(tail?": "+expr:""));
	}
	public static function calculateOp(x:*,op:String,y:*):* {
		switch (op) {
			case '>':
			case 'gt':
				return x > y;
			case '>=':
			case 'gte':
			case 'ge':
				return x >= y;
			case '<':
			case 'lt':
				return x < y;
			case '<=':
			case 'lte':
			case 'le':
				return x <= y;
			case '=':
			case '==':
			case 'eq':
				return x == y;
			case '===':
				return x === y;
			case '!=':
			case 'ne':
			case 'neq':
				return x != y;
			case '!==':
				return x !== y;
			case '+':
				return x + y;
			case '-':
				return x - y;
			case '%':
				return x % y;
			case '*':
				return x * y;
			case '/':
				return x / y;
			case '||':
			case 'or':
				return x || y;
			case '&&':
			case 'and':
				return x && y;
			case 'isin':
				return y.indexOf(x) >= 0;
			case 'notin':
				return y.indexOf(x) < 0;
			default:
				throw new Error("Unregistered operator " + op);
		}
	}

	public static function escapeString(s:String):String {
		return s.replace(/\n/g,'\n').replace(/\r/g,'\r').replace(/'/g,"\\'").replace(/"/g,'\\"').replace(/\\/g,'\\\\');
	}
}
}
