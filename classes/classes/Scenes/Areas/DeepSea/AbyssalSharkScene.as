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
	outputText("A violent ram rocks your boat at the side, the force enough to shake you directly into the water! Your frantically search for your opponent as you notice an indistinct figure beneath the water circling you as it closes the distance with a burst of speed. Nearing, its shape grows clearer as you're met with a massive jaw supporting a toothy grin with razor-like teeth.\n\n");
    outputText("Upon approaching, it grabs your leg, pulling you straight into the watery depths! You're now face to face with what appears to be a shark-morph, but his head has deformed into a hammer-like shape. His amber eyes stare through you as his massive jaws grin maliciously with bits of [skin] cling to his teeth... Is that... was that a part of you? ");
    outputText("Bits of adrenaline begin to fade as you realize he has taken a chunk out of your body, still chewing on the part of you he stole, smiling wide as he clearly is seeking more.\n\n");
	outputText("The blood from your wound spreads as you spot several other sharks encircle you, and the pack leader approaches you rapidly. As the leader spots your attacker, it drifts, changing course to circle around the two of you. Apparently, even he doesn't feel daring enough to provoke your attacker, waiting to see the situation develop.\n\n");
	outputText("You are fighting a Juvenile Abyssal Shark!");
	if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir, 0, 0, 0, 0);
	if (player.hasStatusEffect(StatusEffects.CombatWounds)) player.addStatusValue(StatusEffects.CombatWounds, 1, 0.05);
	else player.createStatusEffect(StatusEffects.CombatWounds,0.05,0,0,0);
	monster.createStatusEffect(StatusEffects.Bloodlust,10,0,0,0);
	startCombat(new JuvenileAbyssalShark());
}

public function oceanJuvenileAbyssalSharkDefeated():void {
	clearOutput();
	cleanupAfterCombat();
	outputText("Just as you manage to surmount him, he turns tail and torpedos away. You almost begin to chase after him, yet are swiftly cut off by the nearby swarm of sharks closing the distance upon you, giving him a chance to escape, seemingly as he had anticipated.\n\n");
	outputText("The hunting pack leader reveals a devious, toothy grin upon commanding the offense. Looks like you're in for more as the pack closes in for a fight!\n\n");
	outputText("You are under attack by a shark girls pack!");
    if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir, 0, 0, 0, 0);
	monster.createStatusEffect(StatusEffects.Bloodlust,10,0,0,0);
	startCombat(new UnderwaterSharkGirlsPack());
}

public function oceanJuvenileAbyssalSharkVictorious():void {
	clearOutput();
	outputText("You slum down in defeat, ");
    if (player.HP < 1) outputText("your wounds too severe to carry on");
    else outputText("arousal taking the best of you");
    outputText(". The shark boy careens his body side to side with a wide, toothy grin as if relishing his victory, slowly encroaching upon you. Without further ceremony, his tail swings from around you, striking you unconscious.\n\n");
	outputText("You wake up some time later, your body bloody and aching, drifting gently at the shore of the beach. You glance around your body, bruised and scarred, these wounds won't heal naturally... At least, not quickly. You need to find some way to remedy such a severe condition.");
	player.addStatusValue(StatusEffects.CombatWounds, 1, 0.1);
	cleanupAfterCombat();
}
		
	}

}