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
//	spriteSelect(32);
	outputText("As you row around on the ocean tentacles surge around your boat grabbing your leg and pulling you to the watery deeps under! As you scan the water to find your pseudo attacker you end up face to face with what looks to be a mix between an octopus and a woman. Eight long tentacle grow at the place where her leg should be. She’s clearly intent on using them on you as she pulls you closer to her and open her arms wide to welcome you in. That and the fact she's smirking like she’s about to have dinner tell you that you're clearly on the menu.\n\n");
//	if (flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] <= 0) {
//		flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] = 1;
//		outputText("<b>New codex entry unlocked: Shark-girls & Tigershark-girls!</b>\n\n")
//	}
	outputText("You are fighting a Scylla!");
	if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir,0,0,0,0);
	startCombat(new Scylla());
	//spriteSelect(32);
}
		
	}

}