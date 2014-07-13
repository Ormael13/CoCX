package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.internals.WeightedDrop;

	public class BeeGirl extends Monster
	{


		override public function defeated(hpVictory:Boolean):void
		{
			if(player.gender > 0) {
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully, and you see an easy way to relieve it..\n\nWhat do you do to her?", true);
				} else {
					outputText("You smile in satisfaction as the " + short + " spreads her legs and starts frigging her honey-soaked cunt.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully, and you see an easy way to relieve it..\n\nWhat do you do to her?", true);
				}
				player.lust = 98;
				game.dynStats("lus", 1);
				var temp2:Function =null;
				var temp3:Function =null;
				if(player.findStatusAffect(StatusAffects.Feeder) >= 0) temp3 = game.forest.beeGirlScene.milkAndHoneyAreKindaFunny;
				if(player.hasKeyItem("Deluxe Dildo") >= 0) temp2 = kGAMECLASS.beeGirlsGetsDildoed;
				game.simpleChoices("Rape",game.forest.beeGirlScene.rapeTheBeeGirl,"Dildo Rape",temp2,"",0,"B. Feed",temp3,"Leave",game.cleanupAfterCombat);
			}
			//Genderless can still breastfeed
			else if(player.findStatusAffect(StatusAffects.Feeder) >= 0) {
				if (hpVictory){
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully.\n\nWhat do you do?", true);
				} else {
					outputText("You smile in satisfaction as the " + short + " spreads her legs and starts frigging her honey-soaked cunt.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully.\n\nWhat do you do?", true);
				}
				game.simpleChoices("B. Feed", game.forest.beeGirlScene.milkAndHoneyAreKindaFunny,"",0,"",0,"",0,"Leave",game.cleanupAfterCombat);
			} else {
                game.finishCombat();
            }
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe bee-girl goes white and backs away with a disgusted look on her face.\n\n", false);
				game.cleanupAfterCombat();
			} else {
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
			this.drop = new WeightedDrop().add(consumables.BEEHONY,4).addMany(1,consumables.OVIELIX,consumables.W__BOOK,useables.B_CHITN,null);
			this.antennae = ANTENNAE_BEE;
			this.wingType = WING_TYPE_BEE_LIKE_SMALL;
			this.tailType = TAIL_TYPE_BEE_ABDOMEN;
			this.tailVenom = 100;
			this.special1 = 5036;
			checkMonster();
		}

	}

}
