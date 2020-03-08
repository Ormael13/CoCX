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
	if (player.gooScore() >= 11 || player.magmagooScore() >= 13 || player.darkgooScore() >= 13) {
		outputText("You take the turn at the end of the cave and run right into a dark slime. For a few second the both of you consider each other before the slime shrugs and simply asks.\n\n");
		outputText("\"<i>No luck finding fluids that way?</i>\"");
		outputText("You didn’t find any and if you did you would have pumped it out until it ran dry.\n\n");
		outputText("\"<i>Well darn, if you spot a fleshling do share!</i>\"");
		outputText("Well that was easy… you can only guess slimes don’t get much out of other slimes’ bodies. You proceed deeper into the caves unhindered, though, you wish you indeed had found someone to milk the fluids off.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("As you engage in a new tunnel you come face to face with a purplish jelly-like woman. She giggles upon spotting you, her small, sphere-shaped core emitting an ominous light as she surges toward you with a gooey smile.\n\n");
		outputText("\"<i>Dinner is served! Your fluids are mine, so surrender them now intruder and I promise to make it very pleasurable for you!</i>\"\n\n");
//		if (flags[kFLAGS.CODEX_ENTRY_] <= 0) {
//			flags[kFLAGS.CODEX_ENTRY_] = 1;
//			outputText("<b>New codex entry unlocked: Dark Slime!</b>\n\n")
//		}
		outputText("You are fighting a dark slime!");
		startCombat(new DarkSlime());
	}
}

public function beatingDarkSlime():void {
	clearOutput();
	outputText("You smirk as the creature falls to the ground, flattened in every possible way.\n\n");
	outputText("\"<i>L..look I did not mean to try and eat you… I mean yes I did but it’s just the instincts I need fluids and…</i>\"\n\n");
	menu();
	addButton(1, "Scram", beatingDarkSlimeScram);
	addButton(2, "Use her", beatingDarkSlimeUseHer);
}
public function beatingDarkSlimeScram():void {
	clearOutput();
	outputText("You silence her pathetic excuses and tell her to get the fuck away. Something to which she gladly complies with.\n\n");
	cleanupAfterCombat();
}
public function beatingDarkSlimeUseHer():void {
	clearOutput();
	outputText("You silence her pathetic excuses and tell her to regain shape right fucking now, the fun is about to begin.\n\n");
	outputText("The grape-colored jelly girl obeys without question molding itself into something you can fuck with.\n\n");
	outputText("She makes a mischievous smile understanding that she may get that meal after all and turns into what appears to be a bed, with slimy sheets and a pillow. Well now, this is a most interesting proposal. You lay down in the slime bed and order her to show you her talents double time.\n\n");
	outputText("You slowly sink into the bed up to the neck, your head still carefully rested on the pillow as the slime begins its exploration of your body. ");
	if (player.hasCock()) outputText("Something in the slime grabs hold of your penis, slowly and gently massaging it within the confines of the lewd bed. You gasp in pleasure as your cock begins to harden under the slime’s methodical ministration some even going inside your urethra. ");
	if (player.hasVagina()) outputText("Your pussy begins to drool as slime floods inside, filling you up to and way past the cervix. This is the nice thing about these creatures, no matter how small the orifices they can move right in. Your belly inflates to an overly pregnant size as the slime begins to gently fuck you up to into your womb. ");
	if (player.biggestTitSize() >= 2) outputText("The slime gets to tenderly massaging your two mounds of flesh small pressure applying to your nipples in just the right way. ");
	outputText("You could stick to vanilla and enjoy yourself but you ponder if you should not go one step further and ask for anal stretching.\n\n");
	menu();
	addButton(1, "Nope", beatingDarkSlimeUseHerNope);
	addButton(2, "Fill", beatingDarkSlimeUseHerFillMyAssWithGoo).hint("Fill my ass with goo");
}
public function beatingDarkSlimeUseHerNope():void {
	outputText("Nah no anal for today.\n\n");
	beatingDarkSlimeUseHer2();
}
public function beatingDarkSlimeUseHerFillMyAssWithGoo():void {
	outputText("Yea some anal would be appreciated too. Your malleable toy gets the message and slowly floods into your pucker widening inside in just the right way.\n\n");
	beatingDarkSlimeUseHer2();
}
public function beatingDarkSlimeUseHer2():void {
	outputText("Regardless of the number of tendrils massaging you in every right way, your having one hell of a great session. The slime is pleasing you in a rhythmic tempo not unlike that of your heartbeat its body pulsing with every small drop of fluid you produce. At this rate, you won’t be able to hold off any further and the slime knowing it speeds up its pace eager for the reward.\n\n");
	outputText("You cum magnificently your fluids mixing and flooding in the slime’s body mass. You almost doze off to sleep too but the mass of the slime moving off from you jar you awake, guess she does not double up as a real bed for resting purposes. She waves off goodbye as she takes her departure leaving you there to ponder who truly raped who.\n\n");
	player.sexReward("Default", "Default",true,false);
	cleanupAfterCombat();
}

	}
}