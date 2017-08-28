/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import coc.xlogic.ExecContext;
import coc.xlogic.StmtList;

public class Story extends StmtList{
	public var parent:Story;
	public var key:String;
	public var lib:Object; /* [key:String]:Story */
	public var isLib:Boolean;
	public function Story(parent:Story,key:String,isLib:Boolean=false) {
		this.parent = parent;
		this.key = key;
		this.isLib = isLib;
		this.lib = {};
		if (parent) parent.addChild(this);
	}
	public function addChild(story:Story):void {
		if (story.key=="") return;
		if (story.key in lib) throw new Error("Duplicate story key "+story.key);
		lib[story.key] = story;
	}
	public function locate(ref:String):Story {
		return locateSplit(this,ref.split("/"));
	}

	override public function execute(context:ExecContext):void {
		if (isLib) return;
		super.execute(context);
	}
	public static function locateSplit(story:Story,ref:/*String*/Array):Story {
		ref = ref.slice();
		while(ref.length>0 && story) {
			var key:String = ref.shift();
			switch(key) {
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
					if (key in story.lib) {
						story = story.lib[key];
					} else {
						story = null;
					}
			}
		}
		return story;
	}
}
}
