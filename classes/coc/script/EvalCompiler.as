package coc.script {
import classes.internals.Utils;

public class EvalCompiler {
	private var expr:String;
	private var _src:String;
	public function EvalCompiler(expr:String) {
		this._src = expr;
		this.expr = expr;
	}
	
	// Expressions are converted to [OPCODE, X, Y, Z] (X, Y, Z optional)
	
	// Special operations
	private static const OPCODE_ERROR:int    =   0; // throw X (X is literal string)
	private static const OPCODE_ID:int       =   1; // X (X is an identifier string)
	private static const OPCODE_LITERAL:int  =   2; // X (X is a primitive)
	private static const OPCODE_INDEX:int    =   3; // X[Y]
	private static const OPCODE_DOT:int      =   4; // X.Y (y is literal string)
	private static const OPCODE_CALL:int     =   5; // X(Y1, Y2, ...)
	private static const OPCODE_ARRAY:int    =   6; // [X1, X2, X3, ...]
	private static const OPCODE_OBJECT:int   =   7; // { [X1]: X2, [X3]: X4, ... }
	// Unary operations
	private static const OPCODE_NOT:int      = 100; // !X
	private static const OPCODE_NEG:int      = 101; // -X
	private static const OPCODE_BINNOT:int   = 102; // ~X
	// Binary operations
	private static const OPCODE_OR:int       = 200; // X || Y
	private static const OPCODE_AND:int      = 201; // X && Y
	private static const OPCODE_GTE:int      = 202; // X >= Y
	private static const OPCODE_GT:int       = 203; // X > Y
	private static const OPCODE_LTE:int      = 204; // X <= Y
	private static const OPCODE_LT:int       = 205; // X < Y
	private static const OPCODE_NEQUIV:int   = 206; // X !== Y
	private static const OPCODE_NEQ:int      = 207; // X != Y
	private static const OPCODE_EQUIV:int    = 209; // X === Y
	private static const OPCODE_EQ:int       = 210; // X == Y
	private static const OPCODE_ADD:int      = 211; // X + Y
	private static const OPCODE_SUB:int      = 212; // X - Y
	private static const OPCODE_MUL:int      = 213; // X * Y
	private static const OPCODE_DIV:int      = 214; // X / Y
	private static const OPCODE_MOD:int      = 215; // X % Y
	private static const OPCODE_ISIN:int     = 216; // X isin Y
	private static const OPCODE_NOTIN:int    = 217; // X notin Y
	// Ternary operation
	private static const OPCODE_IF:int       = 300; // X ? Y : Z
	
	public static const RX_FLOAT:RegExp = /^[+\-]?(?:\d+(\.\d+)?|\.\d+)(?:e[+\-]?\d+)?$/;
	public static const RX_INT:RegExp = /^[+\-]?(?:0x)?\d+$/;
	public static const RX_SIMPLESTRING:RegExp = /^(?:'[^'\\]*'|"[^"\\]*")$/;
	
	private static const LA_BLOCK_COMMENT:RegExp = /^\/\*([^*\/]|\*[^\/]|[^\*]\/)*\*+\//;
	private static const LA_FLOAT:RegExp = /^[+\-]?(\d+(\.\d+)?|\.\d+)(e[+\-]?\d+)?/;
	private static const LA_INT:RegExp = /^[+\-]?(0x)?\d+/;
	private static const LA_SIMPLESTRING:RegExp = /^('[^'\\]*'|"[^"\\]*")/;
	private static const LA_ID:RegExp = /^[a-zA-Z_$][a-zA-Z_$0-9]*/;
	private static const LA_OPERATOR:RegExp = /^(>=?|<=?|!==?|={1,3}|\|\||&&|or|and|isin|notin|eq|neq?|[lg](te|t|e)|[-+*\/%])/;
	private static const OP_PRIORITIES:* = {
		'||':    10,
		'or':    10,
		'&&':    20,
		'and':   20,
		'isin':  30,
		'notin': 30,
		'>=':    30,
		'>':     30,
		'<=':    30,
		'<':     30,
		'!==':   30,
		'!=':    30,
		'===':   30,
		'==':    30,
		'=':     30,
		'lt':    30,
		'le':    30,
		'lte':   30,
		'gt':    30,
		'ge':    30,
		'gte':   30,
		'neq':   30,
		'ne':    30,
		'eq':    30,
		'+':     40,
		'-':     40,
		'*':     50,
		'/':     50,
		'%':     50
	};
	private static const OP_OPCODES:*    = {
		'||':    OPCODE_OR,
		'or':    OPCODE_OR,
		'&&':    OPCODE_AND,
		'and':   OPCODE_AND,
		'isin':  OPCODE_ISIN,
		'notin': OPCODE_NOTIN,
		'>=':    OPCODE_GTE,
		'>':     OPCODE_GT,
		'<=':    OPCODE_LTE,
		'<':     OPCODE_LT,
		'!==':   OPCODE_NEQUIV,
		'!=':    OPCODE_NEQ,
		'===':   OPCODE_EQUIV,
		'==':    OPCODE_EQ,
		'=':     OPCODE_EQ,
		'lt':    OPCODE_LT,
		'le':    OPCODE_LTE,
		'lte':   OPCODE_LTE,
		'gt':    OPCODE_GT,
		'ge':    OPCODE_GTE,
		'gte':   OPCODE_GTE,
		'neq':   OPCODE_NEQ,
		'ne':    OPCODE_NEQ,
		'eq':    OPCODE_EQ,
		'+':     OPCODE_ADD,
		'-':     OPCODE_SUB,
		'*':     OPCODE_MUL,
		'/':     OPCODE_DIV,
		'%':     OPCODE_MOD
	};

	public static function execute(code:*, scopes:Array):* {
		if (!(code is Array)) return code;
		const opcode:int = code[0];
		var x:*, y:*, z:*, i:int;
		switch (opcode) {
			case OPCODE_ERROR:
				throw new Error(String(code[1]));
			case OPCODE_ID:
				return lookup(code[1], scopes);
			case OPCODE_LITERAL:
				return code[1];
			case OPCODE_INDEX:
				x = execute(code[1], scopes);
				y = execute(code[2], scopes);
				z = x[y];
				if (z is Function) z = Utils.bindThis(z, x);
				return z;
			case OPCODE_DOT:
				x = execute(code[1], scopes);
				y = String(code[2]);
				z = x[y];
				if (z is Function) z = Utils.bindThis(z, x);
				return z;
			case OPCODE_CALL:
				x = execute(code[1], scopes);
				y = [];
				for (i = 2; i < code.length; ) y.push(execute(code[i++], scopes));
				return (x as Function).apply(null, y);
			case OPCODE_ARRAY:
				x = [];
				for (i = 1; i < code.length; ) x.push(execute(code[i++], scopes));
				return x;
			case OPCODE_OBJECT:
				x = {};
				for (i = 1; i < code.length; ) {
					var key:String = String(execute(code[i++], scopes));
					var value:* = execute(code[i++], scopes);
					x[key] = value;
				}
				return x;
			case OPCODE_NOT:
				return !execute(code[1], scopes);
			case OPCODE_NEG:
				return -execute(code[1], scopes);
			case OPCODE_BINNOT:
				return ~execute(code[1], scopes);
			case OPCODE_IF:
				return execute(code[1], scopes) ? execute(code[2], scopes) : execute(code[3], scopes);
			case OPCODE_OR:
				return execute(code[1], scopes) || execute(code[2], scopes);
			case OPCODE_AND:
				return execute(code[1], scopes) && execute(code[2], scopes);
			case OPCODE_GTE:
				return execute(code[1], scopes) >= execute(code[2], scopes);
			case OPCODE_GT:
				return execute(code[1], scopes) > execute(code[2], scopes);
			case OPCODE_LTE:
				return execute(code[1], scopes) <= execute(code[2], scopes);
			case OPCODE_LT:
				return execute(code[1], scopes) < execute(code[2], scopes);
			case OPCODE_NEQUIV:
				return execute(code[1], scopes) !== execute(code[2], scopes);
			case OPCODE_NEQ:
				return execute(code[1], scopes) != execute(code[2], scopes);
			case OPCODE_EQUIV:
				return execute(code[1], scopes) === execute(code[2], scopes);
			case OPCODE_EQ:
				return execute(code[1], scopes) == execute(code[2], scopes);
			case OPCODE_ADD:
				return execute(code[1], scopes) + execute(code[2], scopes);
			case OPCODE_SUB:
				return execute(code[1], scopes) - execute(code[2], scopes);
			case OPCODE_MUL:
				return execute(code[1], scopes) * execute(code[2], scopes);
			case OPCODE_DIV:
				return execute(code[1], scopes) / execute(code[2], scopes);
			case OPCODE_MOD:
				return execute(code[1], scopes) % execute(code[2], scopes);
			case OPCODE_ISIN:
				return execute(code[1], scopes).indexOf(execute(code[2], scopes)) >= 0;
			case OPCODE_NOTIN:
				return execute(code[1], scopes).indexOf(execute(code[2], scopes)) < 0;
		}
		throw new Error("Unknown Eval opcode "+String(opcode));
	}
	
	private static function lookup(id:String, scopes:Array):* {
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
	
	private static function error(src:String, expr:String, msg:String, tail:Boolean = true):Error {
		return new Error("In expr: "+src+"\n"+msg+(tail?": "+expr:""));
	}
	public static function compile(expr:String):* {
		if (expr.match(RX_INT)) return parseInt(expr);
		if (expr.match(RX_FLOAT)) return parseFloat(expr);
		if (expr.match(RX_SIMPLESTRING)) return expr.substring(1, expr.length-1);
		return new EvalCompiler(expr).evalUntil("");
//		trace("Expression "+JSON.stringify(expr)+" compiled into "+JSON.stringify(value));
//		return value;
	}
	
	private function evalUntil(until:String):* {
		var x:* = evalExpr(0);
		if (expr == until || expr.charAt(0) == until) return x;
		if (until) throw error(_src,expr,"Operator or " + until + "expected");
		throw error(_src,expr,"Operator expected");
	}
	private function evalExpr(minPrio:int):* {
		var m:/*String*/Array;
		var x:*;
		eatWs();
		if (eatStr('not') || eatStr('!')) {
			return [OPCODE_NOT, evalExpr(minPrio)];
		} else if (eatStr('-')) {
			return [OPCODE_NEG, evalExpr(minPrio)];
		} else if (eatStr('~')) {
			return [OPCODE_BINNOT, evalExpr(minPrio)];
		} else if (eatStr('(')) {
			x = evalUntil(")");
			eatStr(")");
		} else if (eatStr('[')) {
			if (eatStr(']')) {
				x = [OPCODE_ARRAY];
			} else {
				x = [OPCODE_ARRAY,evalExpr(0)];
				while (eatStr(',')) {
					x.push(evalExpr(0));
				}
				if (!eatStr("]")) throw error(_src,expr,"Expected ',' or ']'");
			}
		} else if ((m = eat(LA_FLOAT))) {
			x = parseFloat(m[0]);
		} else if ((m = eat(LA_INT))) {
			x = parseInt(m[0]);
		}  else if ((m = eat(LA_SIMPLESTRING))) {
			x = m[0].substring(1, m[0].length-1);
		} else if ((m = eat(/^['"]/))) {
			var delim:String = m[0];
			var s:String = '';
			var rex:RegExp = delim == '"' ? /^[^"\\]+/ : /^[^'\\]+/;
			while(true) {
				if (eatStr('\\')) {
					var c:String = eatN(1);
					if (c === 'n') s += '\n';
					else if (c === 't') s += '\t';
					else if (c === '\r') s += '';
					else s += c;
				} else if (eatStr(delim)) {
					break
				} else if ((m = eat(rex))) {
					s += m[0];
				} else {
					throw error(_src,expr,"Expected text");
				}
			}
			x = s;
		} else if ((m = eat(LA_ID))) {
			x = [OPCODE_ID, m[0]];
		} else {
			throw error(_src,expr,"Not a sub-expr");
		}
		return evalPostExpr(x,minPrio);
	}
	private function evalPostExpr(x:*,minPrio:int):* {
		var m:Array;
		var y:*,z:*;
		while (true) {
			eatWs();
			if (eatStr('()')) {
				x = [OPCODE_CALL, x];
			} else if (eatStr('(')) {
				x = [OPCODE_CALL, x];
				while(true){
					y = evalExpr(0);
					x.push(y);
					if (eatStr(')')) break;
					if (!eatStr(',')) throw error(_src,expr,"Expected ')' or ','");
				}
			} else if (eatStr('.')) {
				m = eat(LA_ID);
				if (!m) throw error(_src,expr,"Identifier expected");
				x = [OPCODE_DOT, x, m[0]];
			} else if (eatStr('[')) {
				y = evalUntil("]");
				eatWs();
				if (!eatStr(']')) throw error(_src,expr,"Expected ']'");
				x    = [OPCODE_INDEX, x, y];
			} else if (eatStr('?')) {
				y = evalUntil(':');
				if (!eatStr(':')) throw error(_src,expr,"Expected ':'");
				z = evalExpr(0);
				x = [OPCODE_IF,x,y,z];
			} else if ((m = eat(LA_OPERATOR))) {
				var opcode:int = OP_OPCODES[m[0]];
				var p:int = OP_PRIORITIES[m[0]];
				if (p>minPrio) {
					y = evalExpr(p);
					x = [opcode, x, y];
				} else {
					unshift(m[0]);
					break;
				}
			} else break;
		}
		return x;
	}
	private function eat(rex:RegExp):Array {
		var m:Array = expr.match(rex);
		if (m) eatN(m[0].length);
		return m;
	}
	private function unshift(s:String):void {
		expr = s+expr;
	}
	private function eatN(n:int):String {
		var s:String = expr.substr(0,n);
		expr = expr.substr(n);
		return s;
	}
	private function eatStr(s:String):Boolean {
		if (expr.substr(0,s.length).indexOf(s) == 0) {
			eatN(s.length);
			return true;
		}
		return false;
	}
	private function eatWs():void {
		//noinspection StatementWithEmptyBodyJS
		while (eat(/^\s+/) || eat(LA_BLOCK_COMMENT)){}
	}
}
}
