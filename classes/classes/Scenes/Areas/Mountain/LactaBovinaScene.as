/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Mountain 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class LactaBovinaScene extends BaseContent
	{
		
		public function LactaBovinaScene() 
		{
		}

public function lactaBovinaInto():void {
	clearOutput();
	spriteSelect(SpriteDb.s_LactaBovine_16bit);
	outputText("As you explore the mountain you run into a what appears to be a naked woman with gigantic jugs! At first you mistake her for a human but it's obvious from the ears, small horn nubs, tail and hooves that she is not. The cow girl, also having noticed you smiles dreamily, drools at the mouth, as she holds her breast with both hands.\n\n");
	outputText("\"<i>Milked… finally I will get milked! Come over cutie, let mama pour her white creamy love into you!</i>\"\n\n");
	outputText("Oh god, it seems this lacta bovine hasn't been milked for quite sometime and she clearly intends to force breastfeed you!");
	camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_LABOVINES);
	startCombat(new LactaBovina());
}

public function lactaBovinaVictoryRapeChoices():void {
	clearOutput();
	spriteSelect(SpriteDb.s_LactaBovine_16bit);
	outputText("Sexually frustrated and weak from the battle, the lacta bovine falls off on her substantial butt with a loud thump. She looks at you with pleading eyes, begging you to relieve her from her load, but you know better and find it hard not to fall for the trap that is her giant titties. In this world the winner does to the loser whatever it wants, so how will you handle that psychotic walking milk storage?");
	menu();
	addButtonIfTrue(1, "Lick it!", lactaBovinaVictoryLickIt, "Req. to have pussy.", player.hasVagina());
	addButtonIfTrue(2, "Sitting Boobjob", lactaBovinaVictorySittingBoobjob,
		"Req. to have a cock.",
		player.hasCock());
	addButton(10, "Convert Elf", SceneLib.woodElves.CaptureCowgirl).hint("Take the milky slut to the Sacred Tree to become a new sister!").disableIf(!player.isWoodElf(), "Wood elves only!");
	addButton(14, "Leave", lactaBovinaVictoryLeave);
}
public function lactaBovinaVictoryLickIt():void {
	clearOutput();
	spriteSelect(SpriteDb.s_LactaBovine_16bit);
	outputText("You undress before forcing the cow down on her back. This done you sit firmly on the bovine bitch face intent on making your intentions clear. Guess the slut is a born sub as without a word she gets to licking your waiting [cunt].\n\n");
	outputText("The bovine bitch tongue is hilariously big, like that of an actual cattle she easily reaches your sweet spot like a dick would. Before long your moaning, your cunt vibrating pleasantly around the intruding organ" + (player.wetness() >= 3 ? " and dripping a good amount of juice":"") + ". You try your best not to choke the cow by pressing your cunt in her face lest the licking end prematurely. ");
	outputText("Only when you finally reach climax drenching the bovine girl face with your happiness juice do you lift up.\n\n");
	outputText("Utterly satisfied you stand up and redress leaving the pleading needy cow behind as you head back to your camp.");
	player.sexReward("saliva","Vaginal");
	cleanupAfterCombat();
}
public function lactaBovinaVictorySittingBoobjob():void {
	clearOutput();
	spriteSelect(SpriteDb.s_LactaBovine_16bit);
	outputText("Determined to make use of the cow's greatest asset, you force the milky slut on her back and sit on her belly ordering her to get to work!\n\n");
	if (player.longestCockLength() >= 18) outputText("The cow eyes go wide in surprise at your [cock], but she gets to work wrapping her pillows like breasts around your towering erection. ");
	outputText("You watch patiently as the cow uses her massive tits to pleasure aching cock, bitch must be used to treating minotaurs on a daily basis because she's very good at this. "+(player.horseCocks() > 0?"That your cock is equine in shape probably helps put her in the mood. ":"")+"You moan as the cow slowly edges you toward the inevitable climax, her jiggly orbs moving across your length. ");
	outputText("You almost feel the bump of fresh cum move along the length of you prick as you finally explode painting the cow face with your seed.\n\n");
	outputText("Satisfied you stand up and redress leaving the pleading needy cow behind heading back to your camp.");
	player.sexReward("no", "Dick");
	cleanupAfterCombat();
}
public function lactaBovinaVictoryLeave():void {
	outputText("Not interested in any part of that filthy cow you leave her be still pleading on the ground as you head back to camp.");
	cleanupAfterCombat();
}

public function lactaBovinaRape():void {
	clearOutput();
	spriteSelect(SpriteDb.s_LactaBovine_16bit);
	outputText("You barely have the time to fall over before the cow-girl is on you, a crazed expression plastered in her face. She aggressively forces her massive tits up your face like her life depends on it. Guess there’s no helping it, you're going to have to drink the milk out, or she's never going to let you free.\n\n");
	outputText("The moment your lips connect and suckle on her overburdened tit the cow lets out a blissful moo of appreciation.\n\n");
	outputText("\"<i>Moooore keep suckling sweetie drink your fill!</i>\"\n\n");
	outputText("The more you suckle the harder she shoves her massive tits up your face. ");
	if (player.gender > 0) outputText("Just as you work her mammaries you feel a hand reach for "+(player.hasCock()? "your [cock] slowly jerking it to life":"the folds of your [pussy], parting the lips away in order to insert digits after digits inside")+".");
	outputText("The cow, smiling, begins to pleasure you in earnest, rewarding your efforts, which makes you deliver moans of your own and making her heavy breast jiggle with the sound.\n\n");
	outputText("\"<i>Moooooooooo boobgasming! I'm BOOBGASMING!</i>\"\n\n");
	outputText("As a signal of her impending climax the cow’s breast seems to have slightly deflated from their prodigious size and"+((player.hasCock() || player.hasVagina()) ? " she doubles up the pace, making you finally cum and achieve a messy orgasm as":"")+" the cow cum from her free breast showering your face with milk.\n\n");
	outputText("With her breasts finally becoming lighter, the lacta bovine lifts away from you with a happy sigh, leaving you dazed on the ground. You break out from your stupor a few min later, gearing back up before heading to camp\n\n");
	cleanupAfterCombat();
}

	}
}