/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{

import classes.Scenes.Combat.Combat;
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.display.SpriteDb;
import classes.PerkLib;
import classes.StatusEffects;
	
public class DisplacerBeastScene extends BaseContent {
		
    public function DisplacerBeastScene() {}

    public function displacerBeastEncounter():void {
        clearOutput();
        if (player.hasPerk(PerkLib.Feeder)) {
            displacerBeastMilkfeeding();
            return;
        }
        //Regular encounter
        outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would be terrifying already even without the two tentacles on her back that writhe in excitation. Readying for battle is the best you can do as the beast woman charges you with a gleam of hunger in her feral eyes.\n\n");
        if (flags[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST] <= 0) {
            flags[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST] = 1;
            outputText("<b>New codex entry unlocked: Displacer beast!</b>\n\n")
        }
        outputText("You are fighting a Displacer beast!");
        startCombat(new DisplacerBeast());
    }

    public function displacerBeastVictory():void {
        clearOutput();
        outputText("The beast is defeated, but as you expected it simply decides to flee by teleporting elsewhere. It left some gems behind however, which is a welcome sight.");
        cleanupAfterCombat();
    }

    public function displacerBeastMilkfeeding():void {
        clearOutput();
        outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would look terrifying if not for the fact that she is exactly what you needed right now, a walking milker. Licking your lips in anticipation, you giddily walk toward the displacer beast which confused by your friendly demeanor let's you come closer.\n\n");
        outputText("She wants milk, eh? Ain’t she lucky, you have more milk than she can take and you will be more than happy to give it all to her!\n\n");
        outputText("You playfully grab her tentacles, to her complete surprise, as you rub them against your chest showing your obvious intent to the catgirl. She slowly calms down, smiling wide as you make it clear that you want to breastfeed her. She gently latches her suction cup-like tentacles to your chest and you moo in pleasure as your milk udders are slowly being drank from. The displacer beast purrs, ");
        outputText("delighted as she feeds from your top quality milk and you reward her attention by slipping a finger into her pussy. Soon, both of you begin to moan, you from the pleasurable sensation in your chest and her from your invading fingers. It doesn't take long for the both of you to finally cum together as you fill her tentacles with a massive output of milk, the beverage going all the way to her now balloony stomach.\n\n");
        outputText("She pats her belly with a delighted smile as she unplugs from you and kisses you in gratitude, leaving a few gems behind and teleporting to some unknown location. Wow, out of all the possible breast feeds, that sure was one of the best. You hope to meet her again.\n\n<b>You got 100 gems from this chance encounter how nice!</b>");
        player.sexReward("Default", "Nipples", true, false);
        player.addStatusValue(StatusEffects.Feeder,1,1);
        player.changeStatusValue(StatusEffects.Feeder,2,0);
        player.boostLactation(0.1);
        player.gems += 100;
        cleanupAfterCombat();
    }

    public function displacerBeastDefeat():void {
        clearOutput();
        outputText("As you fall defeated by the octopi-cat woman. Her expression change from aggressive to delighted as she strips your gear away. You expect your crotch to get played with but to your surprise, she goes for your [breasts] applying her tentacles on them like a pair of suction cups. You gasp in surprise as something not unlike needles somehow enter your nipples doing god knows what inside of your chest which inflate to ");
        if (player.breastRows[0].breastRating < 5) {
            if (player.breastRows.length == 0) {
                player.createBreastRow();
                player.breastRows[0].breasts = 2;
                player.breastRows[0].nipplesPerBreast = 1;
                player.breastRows[0].breastRating = 5;
            }
            else player.growTits(2, 1, true, 3);
        }
        else player.growTits(2, 1, false, 3);
        if (player.breastRows[0].lactationMultiplier < 1) player.breastRows[0].lactationMultiplier = 1.25;
        outputText(player.breastCup(0) + " cup! You feel sudden dribbles of milk begin to flow out of your overgrown breasts as the tentacles begin to suckle on them and you moan in surprise at this violation!\n\n");
        outputText("The four-armed catgirl seems to be enjoying herself, mewling as she forcefully sucks your" + (player.breastRows[0].lactationMultiplier == 1.25 ?" newly flowing":"") + " milk out! The feeling in your chest eventually becomes too much for you and you");
        if (player.hasCock()) {
            if (player.hasVagina()) outputText("r cock and pussy leak fluids");
            else outputText(" cum");
        }
        if (player.hasVagina()) outputText(" squirt");
        outputText(" in accordance with your breastgasm.\n\nThankfully the beast finally unplugs her tentacles from your tortured breasts, licking her lips in delight and done with her meal, teleports away from your view. You lay there still lost in the feeling of your heaving chest as you lose consciousness.\n\n");
        
        player.sexReward("Default", "Nipples", true, false);
        if (inDungeon) //EL check
            inDungeon = false;
        cleanupAfterCombat();
    }
}

}