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

	public function toString():String {
		return '<'+tagname+' name="'+name+'" isLib='+isLib+'"> ['+stmts.length+'] </'+tagname+'>';
	}
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
		forceExecute(context);
	}
	/**
	 * Executes Story even if it is a lib
	 */
	public function forceExecute(context:ExecContext):void {
		context.debug(this,'enter');
		super.execute(context);
	}
	public function bind(context:ExecContext):BoundStory {
		return new BoundStory(this,context);
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
