package classes.Scenes.Monsters
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class Imp extends Monster
	{
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			if (findStatusEffect(StatusEffects.KitsuneFight) >= 0) {
				game.forest.kitsuneScene.winKitsuneImpFight();
			} else {
				game.impScene.impVictory();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (findStatusEffect(StatusEffects.KitsuneFight) >= 0) {
				game.forest.kitsuneScene.loseKitsuneImpFight();
			} else if (pcCameWorms) {
				outputText("\n\nThe imp grins at your already corrupted state...", false);
				player.lust = player.maxLust();
				doNext(game.impScene.impRapesYou);
			} else {
				game.impScene.impRapesYou();
			}
		}
		
		protected function lustMagicAttack():void {
			outputText("You see " + a + short + " make sudden arcane gestures at you!\n\n");
			game.dynStats("lus", player.lib / 10 + player.cor / 10 + 10);
			if (player.lust < 30) outputText("You feel strangely warm.  ");
			if (player.lust >= 30 && player.lust < 60) outputText("Blood rushes to your groin as a surge of arousal hits you, making your knees weak.  ");
			if (player.lust >= 60) outputText("Images of yourself fellating and fucking the imp assault your mind, unnaturally arousing you.  ");
			if (player.cocks.length > 0) {
				if (player.lust >= 60)
					outputText("You feel your " + player.multiCockDescriptLight() + " dribble pre-cum.");
				else if (player.lust >= 30 && player.cocks.length == 1)
					outputText("Your " + player.cockDescript(0) + " hardens, distracting you further.");
				else if (player.lust >= 30 && player.cocks.length > 1)
					outputText("Your " + player.multiCockDescriptLight() + " harden uncomfortably.");
				if (player.hasVagina()) outputText("  ");
			}
			if (player.lust >= 60 && player.hasVagina()) {
				switch (player.vaginas[0].vaginalWetness) {
					case VAGINA_WETNESS_NORMAL:
						outputText("Your " + player.allVaginaDescript() + " dampen" + (player.vaginas.length > 1 ? "" : "s") + " perceptibly.");
						break;
					case VAGINA_WETNESS_WET:
						outputText("Your crotch becomes sticky with girl-lust.");
						break;
					case VAGINA_WETNESS_SLICK:
						outputText("Your " + player.allVaginaDescript() + " become" + (player.vaginas.length > 1 ? "" : "s") + " sloppy and wet.");
						break;
					case VAGINA_WETNESS_DROOLING:
						outputText("Thick runners of girl-lube stream down the insides of your thighs.");
						break;
					case VAGINA_WETNESS_SLAVERING:
						outputText("Your " + player.allVaginaDescript() + " instantly soak" + (player.vaginas.length > 1 ? "" : "s") + " your groin.");
					default: //Dry vaginas are unaffected
						
				}
			}
			outputText("\n");
			if (player.lust >= player.maxLust())
				doNext(game.combat.endLustLoss);
			else doNext(game.playerMenu);
		}
		
		public function Imp(noInit:Boolean=false)
		{
			if (noInit) return;
			trace("Imp Constructor!");
			this.a = "the ";
			this.short = "imp";
			this.imageName = "imp";
			this.long = "An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.";
			// this.plural = false;
			this.createCock(rand(2) + 11, 2.5, CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(24) + 25;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(20, 10, 25, 12);
			initLibSensCor(45, 45, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.armorName = "leathery skin";
			this.lust = 40;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 1;
			this.gems = rand(5) + 5;
			this.drop = new WeightedDrop().
					add(consumables.SUCMILK,3).
					add(consumables.INCUBID,3).
					add(consumables.IMPFOOD,4);
			this.special1 = lustMagicAttack;
			this.wingType = WING_TYPE_IMP;
			checkMonster();
		}

	}

}