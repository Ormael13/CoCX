/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DeepSea 
{
import classes.*;
import classes.Scenes.Areas.Ocean.UnderwaterSharkGirlsPack;
import classes.Scenes.SceneLib;

public class AbyssalSharkScene extends BaseContent
	{
		
		public function AbyssalSharkScene() 
		{
		}
		
public function oceanJuvenileAbyssalSharkEncounter():void {
	clearOutput();
	outputText("Your boat is hit from the side and violently rocked, throwing you right into the water! As you look for your opponent you see an indistinct shape doing circle in the distance and closing in on you at high speed until its shape becomes clear, jaw wide with a toothy grin.\n\n");
    outputText("After approaching it grabs your leg and pulling you to the watery deeps under! As you scan the water to find your attacker, you end up face to face with what looks to be a shark-morph but with deformed into hammer shape head. His two ember eyes looking at you and in his massive jaws is part of your body it ripped off while dragging you underwater. He slowly chewing on the bitten part and then giving you wide smile despite pieces of meat still between the teeth.\n\n");
	outputText("Blood from your wound start spreading and you see on the side small groups of shark girls lead by alpha male approaching fast. But when the leading shark notice your attacker it slowls down and change the cuourse into one that cause his pack circle you both. Apparently even he not feel daring enough to provoke your attacker and just waits how would this situation develop.\n\n");
	outputText("You are fighting a Scylla!");
	if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir,0,0,0,0);
	startCombat(new JuvenileAbyssalShark());
}

public function oceanJuvenileAbyssalSharkDefeated():void {
	clearOutput();
	outputText("The abyssal shark falls, clearly defeated. And without skipping beat he start to fleeing. Do you try to purse him?\n\n");
	menu();
	addButton(1, "No", oceanJuvenileAbyssalSharkDefeatedNo);
	addButton(3, "Yes", oceanJuvenileAbyssalSharkDefeatedYes);
}
public function oceanJuvenileAbyssalSharkDefeatedNo():void {
	outputText("Feeling something isn't right you wait without moving as the enemy flee. Your instincts prove true when previously circling pack of sharks starts to slwoly comming closer. But due to previously vigilance you manage to escape to your boat which cause them to loose interest to attack you. maybe they not belive you're weakend enough by last fight or they vigilant against abyssal shark that may still be in vinicity. Either way it's not your problem anymore.\n\n");
	cleanupAfterCombat();
}
public function oceanJuvenileAbyssalSharkDefeatedYes():void {
	cleanupAfterCombat();
	outputText("How dare he run away now that you gain upper head. Without care you rush after him but looks like he expected this to happen. As you rush after him you both ends up divided by circling during previous fight pack of shark-morphs. Seeing you not in top form leading male decides to take a chance and command attack. Damn looks like abyssal shark set you up into another fight while getting chance to safetly retreat.\n\n");
	outputText("You are under attack by a shark girls pack!");
    if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir,0,0,0,0);
	startCombat(new UnderwaterSharkGirlsPack());
}

public function oceanJuvenileAbyssalSharkVictorious():void {
	clearOutput();
	outputText("You slump down in defeat, too ");
    if (player.HP < 1) outputText("hurt ");
    else outputText("horny ");
    outputText("to fight on.\n\n");
	outputText("The shark boy does a little victory dance, before moving over to you. Without any ceremonies he simply knocks you out. You wake up half hour later feeling pain in all your body and trying to check your condition despite pain finds you have many places where you missing chunks of your body. That gonna tak long to regorw or heal if you find healer enough capable to hadle such wounds.");
	cleanupAfterCombat();
}
		
	}

}