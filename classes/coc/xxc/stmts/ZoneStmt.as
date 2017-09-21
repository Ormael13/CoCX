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
	public function ZoneStmt(parent:Story, name:String) {
		super('zone',parent, name, false);
		this.encounters = new GroupEncounter(name,[]);
	}
	public static function wrap(group:GroupEncounter,parent:Story,rename:String=""):ZoneStmt {
		var zone:ZoneStmt = new ZoneStmt(parent,rename||group.encounterName());
		zone.encounters = group;
		return zone;
	}
	public function add(content:Story,chance:String=null,when:String=null):void {
		var fchance:Eval = chance?Eval.compile(chance):null;
		var fwhen:Eval = when?Eval.compile(when):null;
		this.encounters.add({
			name:content.name,
			call: function():void {
				content.execute(lastContext);
			},
			chance:fchance?function():* {
				return fchance.vcall(lastContext?lastContext.scopes:[]);
			}:undefined,
			when:fwhen?function():* {
				return fwhen.vcall(lastContext?lastContext.scopes:[]);
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
