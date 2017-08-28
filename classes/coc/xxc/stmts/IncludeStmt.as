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
			if (!success || _loaded) return;
			_loaded = true;
			XML.ignoreWhitespace = false;
			try {
				body = compiler.attach(story).compile(XML(content));
			} catch (e:Error) {
				_loaded = false;
				compiler.detach(story);
				throw e;
			}
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
