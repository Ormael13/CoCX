//Succubus, one of the classic encounters from Unnamed Text Game, now modified to be up to modern standards, with new fight.
package classes.Scenes.Monsters 
{
	import classes.BaseContent;

	public class SuccubusScene extends BaseContent
	{
		
		public function SuccubusScene() {}
		
		public function encounterSuccubus():void {
			clearOutput();
			//Glared at
			outputText("While you're minding your own business, you spot a figure in the distance. It appears to be a succubus with ivory skin and she glares at you.\n\n");
			if (player.hasCock()) {
				outputText("She's expressing interest in your [cock] and says, \"<i>Hello dearie. You've got that wonderful cock of yours and I'd like to offer my pussy to you. It'll be very pleasurable. What do you say?</i>\"");
				menu();
				addButton(0, "Fight", fightAgainstSuccubus);
				addButton(1, "Accept", loseToSuccubus, false);
				addButton(4, "Run", tryToFlee);
			}
			else {
				outputText("She starts to close the distance by charging at you! It's a fight!");
				startCombat(new Succubus());
			}
		}
		
		public function fightAgainstSuccubus():void {
			startCombatImmediate(new Succubus());
		}
		
		public function winAgainstSuccubus():void {
			clearOutput();
			outputText("The succubus falls to her knees, too badly " + (monster.HP <= 0 ? "beaten" : "aroused") + "beaten to continue fighting.");
			if (player.hasCock() && player.lust >= 33) { //Cocks only at the moment.
				outputText("\n\nSadly, your desires have not been met. Of course, you can always rape the poor thing. Do you?");
				doYesNo(winAgainstSuccubusRape, combat.cleanupAfterCombat);
			}
			else {
				combat.cleanupAfterCombat();
			}
		}
		
		public function winAgainstSuccubusRape():void {
			clearOutput();
			outputText("Seeing the succubus in such a vulnerable state \n\n");
			outputText("Lost in the moment, you grind your pelvic region into hers, feeling around for her fuckhole with your erect member", false);
			//Has cocks
			if (player.hasCock()) {
				if (player.cockTotal() > 1) outputText("s. When you feel at least one of them sink in a bit, you thrust in her hard, the others splaying out in all directions. The succubus screams at you, obviously violated. But that only serves to drive you on further, fucking her faster and harder. One of your cocks slips out, slathered in her own juices and someone else's cum, and another takes its place.\n\n", false);
				else outputText(" When you feel yourself sink in a bit, you thrust in her hard. The succubus screams at you, obviously violated. But that only serves to drive you on further, fucking her faster and harder.\n\n", false);
				outputText("Her tight cunt, combined with your crazed lust, has you shooting a huge load into her deepest reaches. But just once isn't enough right now. You keep going, staying hard the whole time.", false);
				if (player.cockTotal() > 1) outputText("She only wears herself out trying to wriggle away from you, and you use the chance to carefully cram another of your cocks into her. You can feel her getting stretched out. ", false);
				outputText("With the glint of a pervert in your eye, you look down on her, drinking in the anguish in her face as you rape her slowly this time. She gets increasingly wet as you keep fucking her, and you mock her openly for supposedly enjoying this. You lick the tears rolling down her face and continue for some time. When you decide she's ben broken, you decide to finish and change suddenly to much faster strokes. The succubus howls, ruffling your hair as you cum all over her insides yet again. Satisfied, you pull out and leave her there panting and wasted, evidence of the incursion leaking from her snatch. ", false);
			}
			player.orgasm();
			dynStats("lib", -2, "cor", 3);
			combat.cleanupAfterCombat();
		}
		
		public function loseToSuccubus(fromBattle:Boolean = true):void {
			clearOutput();
			if (fromBattle) outputText("Too badly " + (player.HP <= 0 ? "beaten" : "aroused") + " by the succubus, you give in and let the succubus do whatever she wants to you.\n\n");
			if (player.hasCock()) {
				outputText("She saunters toward you, swaying her hips the whole way. When she gets within your reach she kisses you instantly, shoving her tongue into your mouth as far as it can go. At the same time, she wraps a leg around you and hooks it behind you, grabbing your stiff cock and guiding it to her nethers.");
				outputText("\n\nHer insides and warm and wet already, squeezing around you and twisting eagerly. The succubus moans into your mouth as she caresses your body with her hands. She expertly lowers the both of you from standing to the ground, with her staying on top of you. She switches to bouncing on your cock, taking it as far as she can. Her powerful legs bounce at a pace few human women could match. She coaxes you to shoot inside her quite easily, and the feeling of this ejaculation is so powerful you feel like you could die of pleasure right there. The succubus moans erotically as she accepts your seed inside of her, and leans over to kiss you on the forehead as if to wish you good night.");
				outputText("\n\nStrangely, the kiss is the last thing you remember, and you awaken on the cold ground, feeling completely exhausted. It feels like she took part of your soul with her...but it felt so good.");
			}
			else {
				outputText("She saunters toward you, swaying her hips the whole way. When she gets within your reach, she caresses your cheeks and pulls your face in close to hers, sliding her tongue deep into your mouth. You " + (player.lib + player.cor < 80 ? "reluctantly" : "eagerly") + " engage in the kiss, dueling her tongue with your own, trying to pin it down. She expertly laps your tongue and crushes it against the floor of your mouth. She swings one leg up to your head to scissor against your pubic region, and grinds against it hard despite there being nothing there. She flits her gaze down, then back up to yours, her eyes filled with lust regardless. She makes out with you longer, going on to lick all around your lips. All the way she pushes against you hard enough to let you feel her pubic bone crushing against yours, along with her considerable wetness.", false);
				outputText("\n\nWhen it's finally over she leaves you wordlessly. Suddenly on the ground there's a bottle that wasn't there before. You pick it up and examine it. It's a viscous white fluid labeled '<i>Incubus Draft</i>'.");
				inventory.takeItem(consumables.INCUBID, combat.cleanupAfterCombat); //it's Incubus Draft
			}
			player.orgasm();
			dynStats("lib", -2, "cor", 3);
			if (fromBattle)
				combat.cleanupAfterCombat();
			else
				doNext(camp.returnToCampUseTwoHours);
		}
		
		public function tryToFlee():void {
			clearOutput();
			startCombat(new Succubus());
			combat.runAway();
		}
		
	}

}