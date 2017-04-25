package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.internals.ChainedDrop;

	public class BeeGirl extends Monster {

		override public function defeated(hpVictory:Boolean):void {
			game.forest.beeGirlScene.beeGirlPCVictory(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe bee-girl goes white and backs away with a disgusted look on her face.\n\n");
				game.combat.cleanupAfterCombat();
			}
			else {
				game.forest.beeGirlScene.beeRapesYou();
			}
		}
		
		private function beeStingAttack():void {
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind)) {
				outputText(capitalA + short + " completely misses you with a blind sting!!");
				combatRoundOver();
				return;
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s stinger!");
				if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s stinger with superior quickness!");
				if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow attempts to sting you.");
				combatRoundOver();
				return;
			}
			//determine if avoided with armor.
			if (player.armorDef >= 10 && rand(4) > 0) {
				outputText("Despite her best efforts, " + a + short + "'s sting attack can't penetrate your armor.");
				combatRoundOver();
				return;
			}
			//Sting successful!  Paralize or lust?
			//Lust 50% of the time
			if (rand(2) == 0) {
				outputText("Searing pain lances through you as " + a + short + " manages to sting you!  You stagger back a step and nearly trip, flushing hotly.  ");
				outputText("Oh no!  You've been injected with some kind of aphrodisiac.  You've got to keep focused, you can't think about... fucking... ");
				if (player.gender == 1) outputText("or dripping honey-slicked cunts beckoning you. ");
				if (player.gender == 2) outputText("planting your aching sex over her face while you lick her sweet honeypot. ");
				if (player.gender == 3) outputText("or cocks, tits, and puffy nipples. ");
				game.dynStats("lus", 25);
				if (player.lust > 60) {
					outputText(" You shake your head and struggle to stay focused,");
					if (player.gender == 1 || player.gender == 3) outputText(" but it's difficult with the sensitive bulge in your groin.");
					if (player.gender == 2) outputText(" but can't ignore the soaking wetness in your groin.");
					if (player.sens > 50) outputText("  The sensitive nubs of your nipples rub tightly under your " + player.armorName + ".");
				}
				else outputText(" You shake your head and clear the thoughts from your head, focusing on the task at hand.");
				if (!player.hasStatusEffect(StatusEffects.lustvenom)) player.createStatusEffect(StatusEffects.lustvenom, 0, 0, 0, 0);
			}
			//Paralise the other 50%!
			else {
				outputText("Searing pain lances through you as " + a + short + " manages to sting you!  You stagger back a step and nearly trip, finding it hard to move yourself.");
				var paralyze:StatusEffectClass = player.statusEffectByType(StatusEffects.ParalyzeVenom);
				if (paralyze != null) {
					paralyze.value1 += 2.9; //v1 - strenght penalty, v2 speed penalty
					paralyze.value2 += 2.9;
					game.dynStats("str", -3, "spe", -3);
					outputText("  It's getting much harder to move, you're not sure how many more stings like that you can take!");
				} else {
					player.createStatusEffect(StatusEffects.ParalyzeVenom, 2, 2, 0, 0);
					game.dynStats("str", -2, "spe", -2);
					outputText("  You've fallen prey to paralyzation venom!  Better end this quick!");
				}
			}
			if (player.lust >= player.maxLust())
				doNext(game.combat.endLustLoss);
			else doNext(game.playerMenu);
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
			this.special1 = beeStingAttack;
			checkMonster();
		}

	}

}
