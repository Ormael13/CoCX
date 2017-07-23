/**
 * Coded by aimozg on 12.07.2017.
 */
package coc.script {
import classes.internals.Utils;

public class Eval {
	private var thiz:*;
	private var expr:String;
	private var src:String;
	public function Eval(thiz:*, expr:String) {
		this.thiz = thiz;
		this.src = expr;
		this.expr = expr;
	}

	private static const RX_INT:RegExp = /^(0x)?\d+$/;
	private static const LA_INT:RegExp = /^(0x)?\d+/;
	private static const LA_ID:RegExp = /^[a-zA-Z_$][a-zA-Z_$0-9]*/;
	private static const LA_OPERATOR:RegExp = /^(>=?|<=?|!==?|={1,3}|lte?|gte?)/;
	public static function eval(thiz:*, expr:String):* {
		if (expr.match(RX_INT)) return int(expr);
		return new Eval(thiz, expr).evalUntil("",false);
	}
	private function evalPostExpr(x:*,skip:Boolean):* {
		var m:Array;
		var y:*,z:*;
		while (true) {
			eatWs();
			if (eatStr('()')) {
				if (!skip && !(x is Function)) throw new Error("In expr: "+src+"\n" +
													  "Not a function before: "+expr);
				if (skip) continue;
				x = (x as Function).apply();
			} else if (eatStr('(')) {
				if (!skip && !(x is Function)) throw new Error("In expr: "+src+"\n" +
													  "Not a function before: "+expr);
				var args:Array = [];
				while(true){
					y = evalExpr(skip);
					args.push(y);
					if (eatStr(')')) break;
					if (!eatStr(',')) throw new Error("In expr: "+src+"\n" +
													  "Expected ')' or ',': "+expr);
				}
				if (skip) continue;
				return (x as Function).apply(null,args);
			} else if (eatStr('.')) {
				m = eat(LA_ID);
				if (!m) throw new Error("In expr: " + src + "\n" +
										"Identifier expected: " + expr);
				if (skip) continue;
				x = evalDot(x, m[0]);
			} else if (eatStr('[')) {
				y = evalUntil("]",skip);
				eatWs();
				if (!eatStr(']')) throw new Error("In expr: "+src+"\n" +
												  "Expected ']': "+expr);
				if (skip) continue;
				x    = evalDot(x, y);
			} else if (eatStr('?')) {
				y = evalUntil(':',skip || !x);
				if (!eatStr(':')) throw new Error("In expr: "+src+"\n" +
												  "Expected ':': "+expr);
				z = evalExpr(skip || x);
				if (skip) continue;
				x = x ? y : z;
			} else if ((m = eat(LA_OPERATOR))) {
				y = evalExpr(skip);
				if (skip) continue;
				x = evalOp(x,m[0],y);
			} else break;
		}
		return x;
	}
	private function evalOp(x:*,op:String,y:*):* {
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
			default:
				throw new Error("In expr: " + src + "\n" +
								"Unregistered operator " + op);
		}
	}
	private function evalExpr(skip:Boolean):* {
		var m:Array;
		var x:*;
		eatWs();
		if (eatStr('(')) {
			x = evalUntil(")",skip);
			eatStr(")");
		} else if ((m = eat(LA_INT))) {
			if (!skip) x = parseInt(m[0]);
		} else if ((m = eat(LA_ID))) {
			if (!skip) x = evalId(m[0]);
		} else {
			throw new Error("In expr: " + src+"\n" +
							"Not a sub-expr: " + expr);
		}
		return evalPostExpr(x,skip);
	}
	private function evalUntil(until:String,skip:Boolean):* {
		var x:* = evalExpr(skip);
		if (expr == until || expr.charAt(0) == until) return x;
		if (until) throw new Error("In expr: " + src+"\n" +
								   "Operator or " + until + "expected: " + expr);
		throw new Error("In expr: " + src+"\n" +
						"Operator expected: " + expr);
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
		if (id in thiz) return thiz[id];
//		trace("Not found key "+id);
		return undefined;
	}
	private function evalDot(obj:Object,key:String):* {
		var y:* = obj[key];
		if (y is Function) {
			y = Utils.bindThis(y,obj);
		}
		return y;
	}
}
}
