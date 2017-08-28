/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import coc.xlogic.Compiler;
import coc.xlogic.Statement;
import coc.xxc.stmts.*;

public class StoryCompiler extends Compiler {
	private var _basedir:String;

	public function get basedir():String {
		return _basedir;
	}
	public function StoryCompiler(basedir:String) {
		this._basedir = basedir;
		if (basedir.charAt(basedir.length-1)!='/') this._basedir+='/';
	}
	private var stack:/*Story*/Array = [];
	public function clone(basedir:String=""):StoryCompiler {
		return new StoryCompiler(basedir?basedir:_basedir);
	}

	public function attach(story:Story):StoryCompiler {
		if (stack.length>0) throw new Error("StoryCompiler.attach called mid-compilation");
		while(story) {
			stack.push(story);
			story = story.parent;
		}
		return this;
	}
	public function detach(story:Story):StoryCompiler {
		while(story) {
			if (stack.length == 0) throw new Error("Inconsistent stack during detach");
			if (stack.pop() != story) throw new Error("Inconsistent stack during detach");
			story = story.parent;
		}
		return this;
	}
	override protected function unknownTag(tag:String, x:XML):Statement {
		switch (tag) {
			case "display":
				return compileDisplay(x);
			case "dynStats":
				return compileDynStats(x);
			case "encounter":
				return compileEncounter(x);
			case "include":
				return includeFile(x.@path);
			case "lib":
			case "scene":
			case "story":
				return compileStory(x, tag == "lib");
			case "zone":
				return compileZone(x);
			case "extend-story":
				return extendStory(x);
			case "extend-zone":
				return extendZone(x);
			default:
				throw new Error("Unknown tag "+tag);
		}
	}
	public function includeFile(path:String):IncludeStmt {
		var basedir:String = _basedir;
		var l:int = path.lastIndexOf('/');
		if (l>0) basedir += path.substring(0,l);
		return new IncludeStmt(stack[0],clone(basedir),path);
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
		var encounter:Story = compileStory(x,false,x.@name);
		zone.add(encounter,x.@chance,x.@when);
		return null;
	}
	protected function compileStory(x:XML, isLib:Boolean = false,rename:String=""):Story {
		var story:Story = new Story(stack[0], rename||x.@key, isLib);
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
	protected function extendStory(x:XML):Story {
		var story:Story = stack[0].locate(x.@key);
		if (!story) throw new Error("Unable to locate <extend-story> key="+x.@key);
		compileStoryBody(story,x);
		return story;
	}
	protected function extendZone(x:XML):ZoneStmt {
		var zone:ZoneStmt = stack[0].locate(x.@key) as ZoneStmt;
		if (!zone) throw new Error("Unable to locate <extend-zone> key="+x.@key);
		compileStoryBody(zone,x);
		return zone;
	}
}
}
