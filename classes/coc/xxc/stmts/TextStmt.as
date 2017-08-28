/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.StoryContext;

public class TextStmt extends Statement{
	private var content:String;
	public function TextStmt(content:String) {
		this.content = content;
	}

	override public function execute(context:ExecContext):void {
		(context as StoryContext).game.outputText(content);
	}
}
}
