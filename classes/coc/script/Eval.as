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

	private var scopes:/*Object*/Array;
	private var expr:String;
	private var src:String;
	private var _call:Function;
	public function call(...scopes:/*Object*/Array):* {
		return vcall(scopes);
	}
	public function vcall(scopes:/*Object*/Array):* {
		this.scopes = scopes;
		try {
			return _call();
		} catch (e:Error){
			error(src,"",e.message,false);
		}
	}

	public function Eval(thiz:*, expr:String) {
		this.scopes = [thiz];
		this.src = expr;
		this.expr = expr;
	}

	private static const RX_FLOAT:RegExp = /^[+\-]?(\d+(\.\d+)?|\.\d+)(e[+\-]?\d+)?$/;
	private static const RX_INT:RegExp = /^[+\-]?(0x)?\d+$/;

	private static const LA_FLOAT:RegExp = /^[+\-]?(\d+(\.\d+)?|\.\d+)(e[+\-]?\d+)?/;
	private static const LA_INT:RegExp = /^[+\-]?(0x)?\d+/;
	private static const LA_ID:RegExp = /^[a-zA-Z_$][a-zA-Z_$0-9]*/;
	private static const LA_OPERATOR:RegExp = /^(>=?|<=?|!==?|={1,3}|\|\||&&|or|and|eq|neq?|[lg](te|t|e)|[-+*\/%])/;
	private static const OP_PRIORITIES:* = {
		'||' : 10,
		'or' : 10,
		'&&' : 20,
		'and': 20,
		'>=' : 30,
		'>'  : 30,
		'<=' : 30,
		'<'  : 30,
		'!==': 30,
		'!=' : 30,
		'===': 30,
		'==' : 30,
		'='  : 30,
		'lt' : 30,
		'le' : 30,
		'lte': 30,
		'gt' : 30,
		'ge' : 30,
		'gte': 30,
		'neq': 30,
		'ne' : 30,
		'eq' : 30,
		'+'  : 40,
		'-'  : 40,
		'*'  : 50,
		'/'  : 50,
		'%'  : 50
	};
	public static function eval(thiz:*, expr:String):* {
		if (expr.match(RX_INT)) return int(expr);
		return new Eval(thiz, expr).evalUntil("")();
	}
	public static function compile(expr:String):Eval {
		var e:Eval = new Eval({}, expr);
		if (expr.match(RX_INT)) {
			const i:int = parseInt(expr);
			e._call     = function ():int {return i;};
		} else if (expr.match(RX_FLOAT)) {
			const f:Number = parseFloat(expr);
			e._call     = function ():Number {return f;};
		} else {
			e._call = e.evalUntil("");
		}

		return e;
	}
	private static function error(src:String, expr:String, msg:String, tail:Boolean = true):Error {
		return new Error("In expr: "+src+"\n"+msg+(tail?": "+expr:""));
	}
	private function evalPostExpr(x:Function,minPrio:int):Function {
		var m:Array;
		var y:Function,z:Function;
		while (true) {
			eatWs();
			if (eatStr('()')) {
				x = wrapCall(x,[]);
			} else if (eatStr('(')) {
				var args:/*Function*/Array = [];
				while(true){
					y = evalExpr(0);
					args.push(y);
					if (eatStr(')')) break;
					if (!eatStr(',')) throw error(src,expr,"Expected ')' or ','");
				}
				x = wrapCall(x,args);
			} else if (eatStr('.')) {
				m = eat(LA_ID);
				if (!m) throw error(src,expr,"Identifier expected");
				x = wrapDot(x, wrapVal(m[0]));
			} else if (eatStr('[')) {
				y = evalUntil("]");
				eatWs();
				if (!eatStr(']')) throw error(src,expr,"Expected ']'");
				x    = wrapDot(x, y);
			} else if (eatStr('?')) {
				y = evalUntil(':');
				if (!eatStr(':')) throw error(src,expr,"Expected ':'");
				z = evalExpr(0);
				x = wrapIf(x, y, z);
			} else if ((m = eat(LA_OPERATOR))) {
				var p:int = OP_PRIORITIES[m[0]];
				if (p>minPrio) {
					y = evalExpr(p);
					x = wrapOp(x, m[0], y);
				} else {
					unshift(m[0]);
					break;
				}
			} else break;
		}
		return x;
	}
	private function calculate(x:Function,op:String,y:Function):* {
//		trace("Evaluating " + (typeof x) + " " + x + " " + op + " " + (typeof y) + " " + y);
		switch (op) {
			case '>':
			case 'gt':
				return x() > y();
			case '>=':
			case 'gte':
			case 'ge':
				return x() >= y();
			case '<':
			case 'lt':
				return x() < y();
			case '<=':
			case 'lte':
			case 'le':
				return x() <= y();
			case '=':
			case '==':
			case 'eq':
				return x() == y();
			case '===':
				return x() === y();
			case '!=':
			case 'ne':
			case 'neq':
				return x() != y();
			case '!==':
				return x() !== y();
			case '+':
				return x() + y();
			case '-':
				return x() - y();
			case '%':
				return x() % y();
			case '*':
				return x() * y();
			case '/':
				return x() / y();
			case '||':
			case 'or':
				return x() || y();
			case '&&':
			case 'and':
				return x() && y();
			default:
				throw error(src, expr, "Unregistered operator " + op, false);
		}
	}
	private function evalExpr(minPrio:int):Function {
		var m:/*String*/Array;
		var x:Function;
		eatWs();
		if (eatStr('(')) {
			x = evalUntil(")");
			eatStr(")");
		} else if (eatStr('[')) {
			var f:/*Function*/Array;
			if (eatStr(']')) {
				f = [];
			} else {
				f = [evalExpr(0)];
				while (eatStr(',')) {
					f.push(evalExpr(0));
				}
				if (!eatStr("]")) throw error(src,expr,"Expected ',' or ']'");
			}
			x = wrapArray(f);
		} else if ((m = eat(LA_INT))) {
			x = wrapVal(parseInt(m[0]));
		} else if ((m = eat(LA_FLOAT))) {
			x = wrapVal(parseFloat(m[0]));
		} else if (eatStr("'")) {
			m = eat(/^[^'\\]*/);
			if (!eatStr("'")) throw error(src,expr,"Expected '\\''");
			x = wrapVal(m[0]);
		} else if (eatStr('"')) {
			m = eat(/^[^"\\]*/);
			if (!eatStr('"')) throw error(src,expr,"Expected '\"'");
			x = wrapVal(m[0]);
		} else if ((m = eat(LA_ID))) {
			x = wrapId(m[0]);
		} else {
			throw error(src,expr,"Not a sub-expr");
		}
		return evalPostExpr(x,minPrio);
	}
	private function evalUntil(until:String):* {
		var x:* = evalExpr(0);
		if (expr == until || expr.charAt(0) == until) return x;
		if (until) throw error(src,expr,"Operator or " + until + "expected");
		throw error(src,expr,"Operator expected");
	}
	private function eat(rex:RegExp):Array {
		var m:Array = expr.match(rex);
		if (m) expr = expr.substr(m[0].length);
		return m;
	}
	private function unshift(s:String):void {
		expr = s+expr;
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
			case 'true': return true;
			case 'false': return false;
			default:
				for each (var thiz:* in scopes) if (id in thiz) return thiz[id];
				return undefined;
		}
	}
	private function wrapId(id:String):Function {
		return function():*{ return evalId(id); };
	}
	private function evalDot(obj:Object,key:String):* {
		if (!(key in obj)) return undefined;
		var y:* = obj[key];
		if (y is Function) {
			y = Utils.bindThis(y,obj);
		}
		return y;
	}

	private function wrapVal(x:*):Function {
		return function ():* { return x; };
	}
	private function wrapCall(fn:Function,args:/*Function*/Array):Function {
		return function ():* {
			var a:Array = [];
			for (var i:int = 0, n:int = args.length; i < n; i++) a[i] = args[i]();
			return (fn() as Function).apply(null, a);
		};
	}
	private function wrapIf(condition:Function,then:Function,elze:Function):Function {
		return functionIf(condition,then,elze);
	}
	private function wrapDot(obj:Function,index:Function):Function {
		return function():* {
			return evalDot(obj(),index());
		};
	}
	private function wrapOp(x:Function,op:String,y:Function):Function {
		return function():* {
			return calculate(x,op,y);
		};
	}
	private function wrapArray(array:/*Function*/Array):Function {
		return function():Array {
			return array.map(function (el:Function,id:int,arr:Array):* {
				return el();
			})
		};
	}
}
}
