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
	private function error(msg:String,tail:Boolean=true):Error {
		return new Error("In expr: "+src+"\n"+msg+(tail?": "+expr:""));
	}
	private function evalPostExpr(x:*,skip:Boolean):* {
		var m:Array;
		var y:*,z:*;
		while (true) {
			eatWs();
			if (eatStr('()')) {
				if (!skip && !(x is Function)) throw error("Not a function before");
				if (skip) continue;
				x = (x as Function).apply();
			} else if (eatStr('(')) {
				if (!skip && !(x is Function)) throw error("Not a function before");
				var args:Array = [];
				while(true){
					y = evalExpr(skip);
					args.push(y);
					if (eatStr(')')) break;
					if (!eatStr(',')) throw error("Expected ')' or ','");
				}
				if (skip) continue;
				x = (x as Function).apply(null,args);
			} else if (eatStr('.')) {
				m = eat(LA_ID);
				if (!m) throw error("Identifier expected");
				if (skip) continue;
				x = evalDot(x, m[0]);
			} else if (eatStr('[')) {
				y = evalUntil("]",skip);
				eatWs();
				if (!eatStr(']')) throw error("Expected ']'");
				if (skip) continue;
				x    = evalDot(x, y);
			} else if (eatStr('?')) {
				y = evalUntil(':',skip || !x);
				if (!eatStr(':')) throw error("Expected ':'");
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
				throw error("Unregistered operator " + op,false);
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
		} else if (eatStr("'")) {
			m = eat(/^[^'\\]*/);
			if (!eatStr("'")) throw error("Expected '\\''");
			x = m[0];
		} else if (eatStr('"')) {
			m = eat(/^[^"\\]*/);
			if (!eatStr('"')) throw error("Expected '\"'");
			x = m[0];
		} else if ((m = eat(LA_ID))) {
			if (!skip) x = evalId(m[0]);
		} else {
			throw error("Not a sub-expr");
		}
		return evalPostExpr(x,skip);
	}
	private function evalUntil(until:String,skip:Boolean):* {
		var x:* = evalExpr(skip);
		if (expr == until || expr.charAt(0) == until) return x;
		if (until) throw error("Operator or " + until + "expected");
		throw error("Operator expected");
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
