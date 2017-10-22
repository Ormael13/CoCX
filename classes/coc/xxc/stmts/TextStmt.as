/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import classes.EngineCore;
import classes.internals.Utils;

import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class TextStmt extends Statement {
	public static const TRIMSTYLE_NONE:int = 0;
	public static const TRIM_LEFT:int      = 1; //  Trim leading whitespace
	public static const TRIM_RIGHT:int     = 2; //  Trim trailing whitespace
	public static const TRIM_UNINDENT:int  = 4; //  Remove whitespace right after line break
	public static const TRIM_SQUEEZE:int   = 8; //  Replace single line breaks with spaces
	public static const TRIM_NT_TN:int     = 16; // Remove leading \n\t+ and trailing \t*\n
	public static const TRIMSTYLE_MAX:int  = TRIM_LEFT | TRIM_RIGHT | TRIM_UNINDENT | TRIM_SQUEEZE;
	private var content:String;
	public function TextStmt(content:String, trimStyle:int) {
		content = content.replace(/\r/g, '');
		if ((trimStyle & TRIM_LEFT) != 0) {
			content = Utils.trimLeft(content);
		}
		if ((trimStyle & TRIM_RIGHT) != 0) {
			content = Utils.trimRight(content);
		}
		if ((trimStyle & TRIM_NT_TN) != 0) {
			content = content.replace(/^\n[ \t]+/,'')
							 .replace(/[ \t]*\n$/,'');
		}
		if ((trimStyle & TRIM_UNINDENT) != 0) {
			content = content.replace(/\n[ \t]+/g,'\n');
		}
		if ((trimStyle & TRIM_SQUEEZE) != 0) {
			content = content.replace(/\n\n/g,'\\n\\n')
							 .replace(/\\n\n/g,'\\n\\n')
							 .replace(/\n/g,' ');
		}
		this.content = content;
	}

	override public function execute(context:ExecContext):void {
		context.debug(this,'print');
		EngineCore.outputText(content);
	}

	public function toString():String {
		return '(text) "'+Eval.escapeString(content.substr(0,20))+(content.length>20?'"...[+'+(content.length-20)+']':'"');
	}
}
}
