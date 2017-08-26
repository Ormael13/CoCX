/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class ScyllaScene extends BaseContent
	{
		
		public function ScyllaScene() 
		{
		}
		
public function oceanScyllaEncounter():void {
	clearOutput();
	spriteSelect(32);
	outputText("As you row around on the ocean tentacles surge around your boat grabbing your leg and pulling you to the watery deeps under! As you look in the water to fight your pseudo attacker you gaze face to face with what looks to be a mix between an octopus and a woman. Eight long tentacle grow at the place where her leg should be. She’s clearly intent on using them on you as she pulls you closer and her arms open wide to welcome you in. She's smirking like she’s about to have dinner and you're clearly on the menu.\n\n");
//	if (flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] <= 0) {
//		flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] = 1;
//		outputText("<b>New codex entry unlocked: Shark-girls & Tigershark-girls!</b>\n\n")
//	}
	outputText("You are fighting a Scylla!");
	startCombat(new Scylla());
	//spriteSelect(32);
}
		
	}

}