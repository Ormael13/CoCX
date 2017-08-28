/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.Story;

public class DisplayStmt extends Statement{
	private var story:Story;
	private var ref:/*String*/Array;
	public function DisplayStmt(story:Story,ref:String) {
		this.story = story;
		this.ref = ref.split('/');
	}

	override public function execute(context:ExecContext):void {
		var obj:Story = Story.locateSplit(story,ref);
		if (!obj) {
			context.error(this,"Cannot dereference "+ref.join('/'));
			return;
		}
		context.execute(obj);
	}
}
}
