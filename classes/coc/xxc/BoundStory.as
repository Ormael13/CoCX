/**
 * Coded by aimozg on 01.09.2017.
 */
package coc.xxc {
import coc.xlogic.ExecContext;

public class BoundStory {
	private var story:Story;
	private var context:ExecContext;
	public function BoundStory(story:Story, context:ExecContext) {
		this.story = story;
		this.context = context;
	}
	public function execute():void {
		story.execute(context);
	}
	public function display(ref:String,locals:Object=null):void {
		var obj:Story = story.locate(ref);
		if (!obj) {
			context.error(story,"Cannot dereference "+ref);
			return;
		}
		if (locals) context.pushScope(locals);
		context.execute(obj);
		if (locals) context.popScope();
	}
}
}
