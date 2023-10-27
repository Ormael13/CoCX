/**
 * ...
 * @author Ohaxer & Sylabt
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
	
public class GraydaRetainer extends NPCAwareContent
	{
		
		public function GraydaRetainer() 
		{
			
		}

public function graydaEncounter():void {
	clearOutput();
	outputText("Whilst sailing along the ocean’s waters, a thick fog rolls in that’s so dense you’ll fear it will cause you to get lost at sea should you not turn back. Suddenly something sizzling files overhead, missing the boat and audibly hitting the water, you snap your head in the direction it came from and ready your weapon. A woman wearing a strange hat with tentacle-like appendages seems to walk out of the fog on the water’s surface, A dark patch of yellow fog seems to cling to her skin, as she summons another bird-shaped projectile you realize...\n\n");
	startCombat(new Grayda());
}
public function graydaEncounterWin():void {
	outputText("A final blow from your opponent sends you off your boat and into the water and with your body as tired as it is, you're unable to keep your head above the water. however the Arigean decides to spare you from a watery grave, Picking you up out of the water and carrying your tired body onto the boat, she ungraciously drops you onto the deck. Struggling to look up you find she’s very quickly pinned you to the floor, her cheeks are flushed blue and her breathing is heavy, it’s clear what her intentions are.\n\n");
	if (player.gender == 3) {
		if (player.hasVagina() && rand(2) == 0) graydaEncounterWinFemale();
		else graydaEncounterWinMale();
	}
	else {
		if (player.hasVagina()) graydaEncounterWinFemale();
		if (player.hasCock()) graydaEncounterWinMale();
	}
}
private function graydaEncounterWinFemale():void {
	outputText("She pins your arms above your head, your breath heavy. You can’t seem to push her off you! you struggle against her warm body, hoping to escape. She begins to slowly lick your wounds, her tongue soft and wet. You let out a small moan, your body and mind betraying you as she works her slick tongue down your body. She stares at you intensely with her bright glowing orbs filled with lust. Her heaving chest presses with yours as she kisses you rough and quick. ");
	outputText("You quickly clench your lips shut in hopes of not caving into her desires, but she quickly pinches your ass making you gasp out in surprise letting her tongue dance with yours. Your breath quickens as you feel your oxygen running out. She still pins you down as she explores your mouth. You feel your vision fading as you run out of oxygen. She slowly withdrawals from your lips, leaving a trail of saliva in her stead. Her hands let you go, but you can’t seem to move. ");
	outputText("She lets her hands wander your body leaving no part untouched, you can’t help but turn and sigh into pleasure, but sometimes her sharp nails break your skin making you gasp. Small streaks of blood fall down your bare exposed body as she violates your body inch by inch. As she positions her head between your legs. Her licks on your thigh make you shiver, her fingers touching the wet nub between your legs, your back arching into the rough ground. ");
	outputText("Her slick hands go inside of you, deeper her fingers went inside of you the more you continue to moan in pleasure. Your mind is polluted with lust as your climax comes quick. "+(silly()?"Your mind polluted with lust as my climax came quick. ":"")+"Her licks were fast and then slow, her tantalizing touch making you yearn for more. ");
	outputText("Her other hand wandering around your body, grabbing anywhere she could. You could feel your climax coming quick and grab her hair to push her mouth even deeper inside of your folds. Your mind goes blank in ecstasy as her glowing eyes peer at you once more…\n\n");
	graydaEncounterWinSharedEnd();
}
private function graydaEncounterWinMale():void {
	outputText("Her mischievous eyes look you up and down. you swallow down in fear and slight lust at the sight of her body. Her hands pinning you down with extreme force. She begins sucking on your neck as you shift uncomfortably, her eyes never leaving yours. you feel her hands slide down your chest, holding you in place still. Her lips trailing down your fresh wounds, leaving an arousing stinging pain. you sigh in pleasure as she continues to work herself down your body. Her hands rubbing your growing bulge as she kisses your abdomen. ");
	outputText("You hear her unbuckle your pants, you begin to panic and quickly sit up but she quickly turns and sits on your chest, her hands pulling out your member with accuracy. Her mouth quickly engulfing it, shocking you with intense pleasure. Her tongue moves skillfully against you, sucking the tip with such gentle firmness, you gasp out in pleasure as you desperately try to grab her hips. She comes off of you with a pop of her lips, moving her garments while she slides your hands up your shoulders and pushes you down. ");
	outputText("Slipping yourself inside of her, her moans and yours mixed together. Her hips move quickly at first, bouncing her entire body on you, you can’t seem to even see straight. Your hands longed to roam hers but she keeps you pinned to the ground, her eyes staring straight into yours. You begin to feel yourself unwind in the pleasure, her body slowing down, savoring every second. ");
	outputText("Her hands release you as she licks your neck and with one final grind of her hips, you feel yourself pouring into her, your moans escaping your lips with ease and her sighs of pleasure mixing with your voice. You feel your whole body become loose as she stands above you. your mind going blank in ecstasy as her glowing eyes peer at you once more…\n\n");
	graydaEncounterWinSharedEnd();
}
private function graydaEncounterWinSharedEnd():void {
	outputText("Afterward, she allows you a brief moment of respite before propping you up in her lap maintaining a firm grip on your arms, and before your even capable of protesting a tentacle-like appendage is forced down your throat, and a cold viscous liquid is pumped through it into your gullet, before long you're unable to keep your eyes open and pass out in her lap.\n\n");
	outputText("You awake several hours later with a bitter taste in your mouth, a stomach ache, and a few gems shorter.\n\n");
	outputText("<b>Your Stomach aches, you may want to rest.</b>\n\n");
	if (!player.blockingBodyTransformations()) player.createStatusEffect(StatusEffects.ArigeanInfected, 0, 0, 0, 0);
	cleanupAfterCombat();
}
public function graydaEncounterLoss():void {
	outputText("The Arigean grimaces as she tries to support her shaking body on her staff, however she’s unable to hold her weight and collapses into the water, quickly sinking back into the depths. The dense fog clears and you find a small satchel of gems floating in the water. You opt to return to camp for now and sail back to solid land.\n\n");
	cleanupAfterCombat();
}
/*
private	function aaa():void {
	
}*/
	}

}