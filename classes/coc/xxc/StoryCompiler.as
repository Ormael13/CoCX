/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import coc.xlogic.Compiler;
import coc.xlogic.Statement;
import coc.xxc.stmts.*;

public class StoryCompiler extends Compiler {
	public function StoryCompiler() {
	}
	private var stack:/*Story*/Array = [];


	override protected function unknownTag(tag:String, x:XML):Statement {
		switch (tag) {
			case "display":
				return compileDisplay(x);
			case "dynStats":
				return compileDynStats(x);
			case "encounter":
				return compileEncounter(x);
			case "lib":
			case "scene":
			case "story":
				return compileStory(x, tag == "lib");
			case "zone":
				return compileZone(x);
			default:
				return super.unknownTag(tag, x);
		}
	}
	protected function compileDisplay(x:XML):DisplayStmt {
		return new DisplayStmt(stack[0],x.@ref);
	}

	protected function compileDynStats(x:XML):DynStatsStmt {
		var attrs:Object = attrMap(x);
		var d:DynStatsStmt = new DynStatsStmt();
		for (var attr:String in attrs) d.setAttr(attr,attrs[attr]);
		return d;
	}
	protected function compileEncounter(x:XML):Statement {
		var zone:ZoneStmt = stack[0] as ZoneStmt;
		if (!zone) throw new Error("<encounter> not in <zone>: "+x.toString().substr(0,20));
		var encounter:Story = compileStory(x);
		zone.add(encounter,x.@chance,x.@when);
		return null;
	}
	protected function compileStory(x:XML, isLib:Boolean = false):Story {
		var story:Story = new Story(stack[0], x.@key, isLib);
		compileStoryBody(story, x);
		return story;
	}
	protected function compileStoryBody(story:Story, x:XML):void {
		stack.unshift(story);
		compileChildrenInto(x, story.stmts);
		stack.shift();
	}
	override protected function compileText(x:XML):Statement {
		if (stack.length == 0) return super.compileText(x);
		return new TextStmt(x.toString());
	}
	protected function compileZone(x:XML):ZoneStmt {
		var zone:ZoneStmt = new ZoneStmt(stack[0], x.@key);
		compileStoryBody(zone,x);
		return zone;
	}
}
}
