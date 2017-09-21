/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.StoryContext;

public class OutputStmt extends Statement{
	private var content:Eval;
	public function OutputStmt(content:String) {
		this.content = Eval.compile(content);
	}

	override public function execute(context:ExecContext):void {
		(context as StoryContext).game.outputText(""+content.vcall(context.scopes));
	}
}
}
