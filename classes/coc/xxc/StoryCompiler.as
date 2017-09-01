/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import coc.xlogic.Compiler;
import coc.xlogic.Statement;
import coc.xlogic.StmtList;
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
			case "b":
			case "i":
				var list:StmtList = new StmtList();
				list.stmts.push(new TextStmt("<"+tag+">",0));
				compileChildrenInto(x,list.stmts);
				list.stmts.push(new TextStmt("</"+tag+">",0));
				return list;
			case "display":
				return compileDisplay(x);
			case "dynStats":
				return compileDynStats(x);
			case "encounter":
				return compileEncounter(x);
			case "include":
				return includeFile(x.@path, x.@required != "false");
			case "output":
				return compileOutput(x);
			case "lib":
				return compileStory(x, true);
			case "text":
			case "story":
			case "string":
				return compileStory(x, false);
			case "zone":
				return compileStoryBody(new ZoneStmt(stack[0], x.@name), x) as ZoneStmt;
			/*case "extend-encounter":
				return extendEncounter(x);*/
			case "extend-story":
				return compileStoryBody(locate(x.@name), x);
			case "extend-zone":
				return compileStoryBody(locate(x.@name), x) as ZoneStmt;
			default:
				throw new Error("Unknown tag "+tag);
		}
	}
	public function includeFile(path:String,required:Boolean):IncludeStmt {
		var basedir:String = _basedir;
		var l:int = path.lastIndexOf('/');
		if (l>0) {
			basedir += path.substring(0,l);
			path = path.substring(l+1);
		}
		return new IncludeStmt(stack[0],clone(basedir),path,required);
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
	protected function peekZone():ZoneStmt {
		var zone:ZoneStmt = stack[0] as ZoneStmt;
		if (!zone) throw new Error("Not a <zone> "+stack[0].toString().substr(0,20));
		return zone;
	}
	protected function compileEncounter(x:XML):Statement {
		var encounter:Story = compileStory(x);
		peekZone().add(encounter,x.@chance,x.@when);
		return null;
	}
	protected function compileOutput(x:XML):OutputStmt {
		return new OutputStmt(x.text().toString());
	}
	protected function compileStory(x:XML, isLib:Boolean = false):Story {
		return compileStoryBody(new Story(x.localName(),stack[0], x.@name, isLib), x);
	}
	protected function compileStoryBody(story:Story, x:XML):Story {
		stack.unshift(story);
		compileChildrenInto(x, story.stmts);
		stack.shift();
		return story;
	}
	override protected function compileText(x:XML):Statement {
		if (stack.length == 0 || stack[0].tagname == 'lib') return super.compileText(x);
		var s:String = x.toString();
		if (s.replace(/^\s+/g,'').replace(/\s+$/g,'') == '') return null;
		var trimStyle:int;
		if (stack[0].tagname == 'string') {
			trimStyle = TextStmt.TRIMSTYLE_NONE;
		} else {
			trimStyle = TextStmt.TRIM_SQUEEZE | TextStmt.TRIM_UNINDENT;
			if (x==x.parent().children()[0]) trimStyle |= TextStmt.TRIM_LEFT;
		}
		return new TextStmt(x.toString(), trimStyle);
	}
	protected function locate(ref:String):Story {
		var story:Story = stack[0].locate(ref);
		if (!story) throw new Error("Unable to locate ref="+ref+" from "+stack[0].toString().substr(0,20));
		return story;
	}
}
}
