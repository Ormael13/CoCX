package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.internals.ChainedDrop;

	public class BeeGirl extends Monster {

		override public function defeated(hpVictory:Boolean):void {
			clearOutput();
			if(player.gender > 0 && flags[kFLAGS.SFW_MODE] <= 0) {
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully, and you see an easy way to relieve it..\n\nWhat do you do to her?");
				}
				else {
					outputText("You smile in satisfaction as the " + short + " spreads her legs and starts frigging her honey-soaked cunt.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully, and you see an easy way to relieve it..\n\nWhat do you do to her?");
				}
				player.lust = 98;
				game.dynStats("lus", 1);
				var dildoRape:Function = (player.hasKeyItem("Deluxe Dildo") >= 0 ? game.forest.beeGirlScene.beeGirlsGetsDildoed : null);
				var milkAndHoney:Function = (player.findStatusAffect(StatusAffects.Feeder) >= 0 ? game.forest.beeGirlScene.milkAndHoneyAreKindaFunny : null);
				game.simpleChoices("Rape", game.forest.beeGirlScene.rapeTheBeeGirl, "Dildo Rape", dildoRape, "", null, "B. Feed", milkAndHoney, "Leave", leaveAfterDefeating);
			}
			else if (player.findStatusAffect(StatusAffects.Feeder) >= 0 && flags[kFLAGS.SFW_MODE] <= 0) { //Genderless can still breastfeed
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully.\n\nWhat do you do?");
				}
				else {
					outputText("You smile in satisfaction as the " + short + " spreads her legs and starts frigging her honey-soaked cunt.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully.\n\nWhat do you do?");
				}
				game.simpleChoices("B. Feed", game.forest.beeGirlScene.milkAndHoneyAreKindaFunny, "", null, "", null, "", null, "Leave", leaveAfterDefeating);
			}
			else {
                game.finishCombat();
            }
		}
		
		private function leaveAfterDefeating():void {
			if (HP < 1) {
				flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITHOUT_RAPE]++; //This only happens if you beat her up and then don't rape her
			}
			else {
				flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITH_RAPE]++; //All wins by lust count towards the desire option, even when you leave
			}
			game.cleanupAfterCombat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe bee-girl goes white and backs away with a disgusted look on her face.\n\n");
				game.cleanupAfterCombat();
			}
			else {
				game.forest.beeGirlScene.beeRapesYou();
			}
		}

		public function BeeGirl()
		{
			super();
			this.a = "a ";
			this.short = "bee-girl";
			this.imageName = "beegirl";
			this.long = "A bee-girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hipRating = HIP_RATING_CURVY+3;
			this.buttRating = BUTT_RATING_EXPANSIVE;
			this.lowerBody = LOWER_BODY_TYPE_BEE;
			this.skinTone = "yellow";
			this.hairColor = randomChoice("black","black and yellow");
			this.hairLength = 6;
			initStrTouSpeInte(30, 30, 30, 20);
			initLibSensCor(60, 55, 0);
			this.weaponName = "chitin-plated fist";
			this.weaponVerb="armored punch";
			this.armorName = "chitin";
			this.armorDef = 9;
			this.lust = 20 + rand(40);
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 4;
			this.gems = rand(15) + 1;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 10)
					.add(consumables.W__BOOK, 1 / 10)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.antennae = ANTENNAE_BEE;
			this.wingType = WING_TYPE_BEE_LIKE_SMALL;
			this.tailType = TAIL_TYPE_BEE_ABDOMEN;
			this.tailVenom = 100;
			this.special1 = 5036;
			checkMonster();
		}

	}

}
