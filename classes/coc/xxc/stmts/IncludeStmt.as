/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import coc.view.CoCLoader;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.Story;
import coc.xxc.StoryCompiler;

import flash.events.Event;

public class IncludeStmt extends Statement{
	private var _loaded:Boolean = false;
	private var body:Statement = null;
	private var path:String;
	public function get loaded():Boolean {
		return _loaded;
	}
	public function IncludeStmt(story:Story,compiler:StoryCompiler,path:String) {
		this.path = path;
		CoCLoader.loadText(compiler.basedir+path,function(success:Boolean,content:*,event:Event):void {
			_loaded = true;
			if (!success) return;
			XML.ignoreWhitespace = false;
			body = compiler.attach(story).compile(XML(content));
			compiler.detach(story);
		});
	}

	override public function execute(context:ExecContext):void {
		if (!_loaded) {
			trace("Content not loaded: "+path);
			return;
		}
		if (body) context.execute(body);
	}
}
}
