/**
 * Coded by aimozg on 12.07.2017.
 */
package coc.script {
import classes.internals.Utils;

public class Eval {
	// (condition,then,elze) => ()=>(condition()?then():elze())
	public static function functionIf(condition:Function,then:Function,elze:Function):Function {
		return function ():* {
			return condition() ? then() : elze();
		};
	}

	private var thiz:*;
	private var expr:String;
	private var src:String;
	private var _call:Function;
	public function call(thiz:Object):* {
		this.thiz = thiz;
		return _call();
	}

	public function Eval(thiz:*, expr:String) {
		this.thiz = thiz;
		this.src = expr;
		this.expr = expr;
	}

	private static const RX_INT:RegExp = /^-?(0x)?\d+$/;
	private static const LA_INT:RegExp = /^-?(0x)?\d+/;
	private static const LA_ID:RegExp = /^[a-zA-Z_$][a-zA-Z_$0-9]*/;
	private static const LA_OPERATOR:RegExp = /^(>=?|<=?|!==?|={1,3}|lte?|gte?|[-+*\/%])/;
	public static function eval(thiz:*, expr:String):* {
		if (expr.match(RX_INT)) return int(expr);
		return new Eval(thiz, expr).evalUntil("",'eval');
	}
	public static function compile(expr:String):Eval {
		var e:Eval = new Eval({}, expr);
		e._call = e.evalUntil("",'compile');
		return e;
	}
	private static function error(src:String, expr:String, msg:String, tail:Boolean = true):Error {
		return new Error("In expr: "+src+"\n"+msg+(tail?": "+expr:""));
	}
	private function evalPostExpr(x:*,mode:String):* {
		var m:Array;
		var y:*,z:*;
		while (true) {
			eatWs();
			if (eatStr('()')) {
				x = wrapCall(mode,x,[]);
			} else if (eatStr('(')) {
				var args:Array = [];
				while(true){
					y = evalExpr(mode);
					args.push(y);
					if (eatStr(')')) break;
					if (!eatStr(',')) throw error(src,expr,"Expected ')' or ','");
				}
				x = wrapCall(mode,x,args);
			} else if (eatStr('.')) {
				m = eat(LA_ID);
				if (!m) throw error(src,expr,"Identifier expected");
				x = wrapDot(mode, x, m[0]);
			} else if (eatStr('[')) {
				y = evalUntil("]",mode);
				eatWs();
				if (!eatStr(']')) throw error(src,expr,"Expected ']'");
				x    = wrapDot(mode, x, y);
			} else if (eatStr('?')) {
				y = evalUntil(':', mode == 'eval' && !x ? 'skip' : mode);
				if (!eatStr(':')) throw error(src,expr,"Expected ':'");
				z = evalExpr(mode == 'eval' && x ? 'skip' : mode);
				x = wrapIf(mode, x, y, z);
			} else if ((m = eat(LA_OPERATOR))) {
				y = evalExpr(mode);
				x = wrapOp(mode,x,m[0],y);
			} else break;
		}
		return x;
	}
	private function calculate(x:*,op:String,y:*):* {
//		trace("Evaluating " + (typeof x) + " " + x + " " + op + " " + (typeof y) + " " + y);
		switch (op) {
			case '>':
			case 'gt':
				return x > y;
			case '>=':
			case 'gte':
				return x >= y;
			case '<':
			case 'lt':
				return x < y;
			case '<=':
			case 'lte':
				return x <= y;
			case '=':
			case '==':
				return x == y;
			case '===':
				return x === y;
			case '!=':
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
			default:
				throw error(src, expr, "Unregistered operator " + op, false);
		}
	}
	private function evalExpr(mode:String):* {
		var m:Array;
		var x:*;
		eatWs();
		if (eatStr('(')) {
			x = evalUntil(")",mode);
			eatStr(")");
		} else if ((m = eat(LA_INT))) {
			x = wrapVal(mode,parseInt(m[0]));
		} else if (eatStr("'")) {
			m = eat(/^[^'\\]*/);
			if (!eatStr("'")) throw error(src,expr,"Expected '\\''");
			x = wrapVal(mode,m[0]);
		} else if (eatStr('"')) {
			m = eat(/^[^"\\]*/);
			if (!eatStr('"')) throw error(src,expr,"Expected '\"'");
			x = wrapVal(mode,m[0]);
		} else if ((m = eat(LA_ID))) {
			x = wrapId(mode,m[0]);
		} else {
			throw error(src,expr,"Not a sub-expr");
		}
		return evalPostExpr(x,mode);
	}
	private function evalUntil(until:String,mode:String):* {
		var x:* = evalExpr(mode);
		if (expr == until || expr.charAt(0) == until) return x;
		if (until) throw error(src,expr,"Operator or " + until + "expected");
		throw error(src,expr,"Operator expected");
	}
	private function eat(rex:RegExp):Array {
		var m:Array = expr.match(rex);
		if (m) expr = expr.substr(m[0].length);
		return m;
	}
	private function eatStr(s:String):Boolean {
		if (expr.substr(0,s.length).indexOf(s) == 0) {
			expr = expr.substr(s.length);
			return true;
		}
		return false;
	}
	private function eatWs():void {
		eat(/^\s+/);
	}
	private function evalId(id:String):* {
		switch (id) {
			case 'Math': return Math;
			case 'undefined': return undefined;
			case 'null': return null;
			case 'int': return int;
			case 'uint': return uint;
			case 'String': return String;
			case 'string': return String;
			case 'Number': return Number;
			default:
				if (id in thiz) return thiz[id];
				return undefined;
		}
	}
	private function wrapId(mode:String,id:String):* {
		if (mode == 'eval') return evalId(id);
		if (mode == 'compile') return function():*{ return evalId(id); };
		return undefined;
	}
	private function evalDot(obj:Object,key:String):* {
		var y:* = obj[key];
		if (y is Function) {
			y = Utils.bindThis(y,obj);
		}
		return y;
	}

	private function wrapVal(mode:String,x:*):* {
		if (mode == 'eval') return x;
		if (mode == 'compile') return function ():* { return x; };
	}
	private function wrapCall(mode:String,fn:*,args:Array):* {
		if (mode === 'eval') {
			if (!(fn is Function)) throw error(src,expr,"Not a function");
			return (fn as Function).apply(null, args);
		}
		if (mode === 'compile') return function ():* {
			var a:Array = [];
			for (var i:int = 0, n:int = args.length; i < n; i++) a[i] = args[i]();
			return (fn() as Function).apply(null, a);
		};
		return undefined;
	}
	private function wrapIf(mode:String,condition:*,then:*,elze:*):* {
		if (mode === 'eval') return condition ? then : elze;
		if (mode === 'compile') return functionIf(condition,then,elze);
		return undefined;
	}
	private function wrapDot(mode:String,obj:*,index:*):* {
		if (mode == 'eval') return evalDot(obj,index);
		if (mode == 'compile') return function():* {
			return evalDot(obj(),index());
		};
		return undefined;
	}
	private function wrapOp(mode:String,x:*,op:String,y:*):* {
		if (mode == 'eval') return calculate(x,op,y);
		if (mode == 'compile') return function():* {
			return calculate(x(),op,y());
		};
		return undefined;
	}
}
}
