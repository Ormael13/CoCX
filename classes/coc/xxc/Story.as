/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import coc.xlogic.ExecContext;
import coc.xlogic.StmtList;

public class Story extends StmtList{
	public var parent:Story;
	public var name:String;
	public var lib:Object; /* [name:String]:Story */
	public var isLib:Boolean;
	public var tagname:String;
	public function Story(tagname:String,parent:Story,name:String,isLib:Boolean=false) {
		this.tagname = tagname;
		this.parent = parent;
		this.name   = name;
		this.isLib  = isLib;
		this.lib    = {};
		if (parent) parent.addChild(this);
	}
	public function addChild(story:Story):void {
		if (story.name == "") return;
		if (story.name in lib) throw new Error("Duplicate story name " + story.name);
		lib[story.name] = story;
	}
	public function locate(ref:String):Story {
		return locateSplit(this,ref.split("/"));
	}

	override public function execute(context:ExecContext):void {
		if (isLib) return;
		super.execute(context);
	}
	public function display(context:ExecContext,ref:String,locals:Object=null):void {
		var obj:Story = locate(ref);
		if (!obj) {
			context.error(this,"Cannot dereference "+ref);
			return;
		}
//		context.locals = locals || {};
		if (locals) context.pushScope(locals);
		context.execute(obj);
		if (locals) context.popScope();
	}
	public static function locateSplit(story:Story,ref:/*String*/Array):Story {
		ref = ref.slice();
		while(ref.length>0 && story) {
			var name:String = ref.shift();
			switch(name) {
				case '':
					if (story.parent) {
						story = story.parent;
						ref.unshift('');
					}
					break;
				case '.':
					// do nothing
					break;
				case '..':
					story = story.parent;
					break;
				default:
					if (name in story.lib) {
						story = story.lib[name];
					} else {
						story = null;
					}
			}
		}
		return story;
	}
}
}
