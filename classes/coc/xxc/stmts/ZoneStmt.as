/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import classes.Scenes.API.GroupEncounter;

import coc.script.Eval;

import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

import coc.xxc.Story;

public class ZoneStmt extends Story {
	public var encounters:GroupEncounter;
	private var lastContext:ExecContext;
	public function ZoneStmt(parent:Story, key:String) {
		super(parent, key, false);
		this.encounters = new GroupEncounter(key,[]);
	}
	public function add(content:Story,chance:String="1",when:String="true"):void {
		var fchance:Eval = chance?Eval.compile(chance):null;
		var fwhen:Eval = when?Eval.compile(when):null;
		this.encounters.add({
			name:content.key,
			call: function():void {
				content.execute(lastContext);
			},
			chance:fchance?function():* {
				fchance.call(lastContext.thiz);
			}:undefined,
			when:fwhen?function():* {
				fwhen.call(lastContext.thiz);
			}:undefined
		});
	}
	override public function execute(context:ExecContext):void {
		lastContext = context;
		super.execute(context);
		encounters.execEncounter();
		lastContext = null;
	}
}
}
