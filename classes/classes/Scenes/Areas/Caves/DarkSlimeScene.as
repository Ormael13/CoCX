/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{
	import classes.*;
	import classes.Items.Shields.DarkAegis;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class DarkSlimeScene extends BaseContent
	{
		
		public function DarkSlimeScene() 
		{
		}

public function cavesDarkSlimeEncounter():void {
	clearOutput();
//	spriteSelect(32);
	if (rand(3) == 0) flags[kFLAGS.HERM_CAVE_WYRM] = 1;
	else flags[kFLAGS.HERM_CAVE_WYRM] = 0;
	outputText("As you engage in a new tunnel you come face to face with a purplish jelly-like woman. She giggles upon spotting you, her small, sphere-shaped core emitting an ominous light as she surges toward you with a gooey smile.\n\n");
	outputText("\"<i>Dinner is served! Your fluids are mine, so surrender them now intruder and I promise to make it very pleasurable for you!</i>\"\n\n");
//	if (flags[kFLAGS.CODEX_ENTRY_] <= 0) {
//		flags[kFLAGS.CODEX_ENTRY_] = 1;
//		outputText("<b>New codex entry unlocked: Dark Slime!</b>\n\n")
//	}
	outputText("You are fighting a dark slime!");
	startCombat(new DarkSlime());
}



	}
}