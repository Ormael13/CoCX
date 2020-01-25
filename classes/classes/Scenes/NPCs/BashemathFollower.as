/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	//import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.Malikore;
	import classes.display.SpriteDb;
	
	public class BashemathFollower extends NPCAwareContent
	{
		
		public function BashemathFollower() 
		{}

public function repeatEnc():void
{
	//spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("You take a stroll in the mountain area when a spike passes a few inches away from your side.\n\n");
	/*if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Bashemath");
	else */outputText("The malikore");
	outputText(" moves out of the shadow of a nearby cave, adopting a predatory stance.\n\n");
	//outputText("\"<i>Why won't you just stay still and get shot like everyone else? Well whatever! I’m gonna take my time toying with you once I've poisoned you into a good fuckpet.</i>\"");
	outputText("\n\nYou're under attack by ");
	/*if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Bashemath!");
	else */outputText("a malicore!");
	/*if (player.hasStatusEffect(StatusEffects.WildMalikore)) */startCombat(new Malikore());
	//else startCombat(new Bashemath());
	doNext(playerMenu);
}
public function repeatEncWM():void {
	player.createStatusEffect(StatusEffects.WildMalikore, 0, 0, 0, 0);
	repeatEnc();
}

	}

}