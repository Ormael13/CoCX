package classes.Scenes.Monsters
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.internals.*;

public class Imp extends Monster
	{
		public var Evangeline:EvangelineFollower = new EvangelineFollower()
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			if (hasStatusEffect(StatusEffects.KitsuneFight)) {
				game.forest.kitsuneScene.winKitsuneImpFight();
			}
			else if (flags[kFLAGS.EVANGELINE_AFFECTION] == 1) {
				Evangeline.winEvangelineImpFight();
			}
			else {
				game.impScene.impVictory();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hasStatusEffect(StatusEffects.KitsuneFight)) {
				game.forest.kitsuneScene.loseKitsuneImpFight();
			}
			else if (pcCameWorms) {
				outputText("\n\nThe imp grins at your already corrupted state...");
				player.lust = player.maxLust();
				doNext(game.impScene.impRapesYou);
			}
			else if (flags[kFLAGS.EVANGELINE_AFFECTION] == 1) {
				flags[kFLAGS.EVANGELINE_AFFECTION] = 2;
				game.impScene.impRapesYou();
			}
			else {
				game.impScene.impRapesYou();
			}
		}
		
		protected function lustMagicAttack():void {
			outputText("You see " + a + short + " make sudden arcane gestures at you!\n\n");
			player.dynStats("lus", player.lib / 10 + player.cor / 10 + 10);
			if (player.lust < (player.maxLust() * 0.3)) outputText("You feel strangely warm.  ");
			if (player.lust >= (player.maxLust() * 0.3) && player.lust < (player.maxLust() * 0.6)) outputText("Blood rushes to your groin as a surge of arousal hits you, making your knees weak.  ");
			if (player.lust >= (player.maxLust() * 0.6)) outputText("Images of yourself fellating and fucking the imp assault your mind, unnaturally arousing you.  ");
			if (player.cocks.length > 0) {
				if (player.lust >= (player.maxLust() * 0.6))
					outputText("You feel your [cocks] dribble pre-cum.");
				else if (player.lust >= (player.maxLust() * 0.3) && player.cocks.length == 1)
					outputText("Your [cock] hardens, distracting you further.");
				else if (player.lust >= (player.maxLust() * 0.3) && player.cocks.length > 1)
					outputText("Your [cocks] harden uncomfortably.");
				if (player.hasVagina()) outputText("  ");
			}
			if (player.lust >= (player.maxLust() * 0.6) && player.hasVagina()) {
				switch (player.vaginas[0].vaginalWetness) {
					case AppearanceDefs.VAGINA_WETNESS_NORMAL:
						outputText("Your " + allVaginaDescript() + " dampen" + (player.vaginas.length > 1 ? "" : "s") + " perceptibly.");
						break;
					case AppearanceDefs.VAGINA_WETNESS_WET:
						outputText("Your crotch becomes sticky with girl-lust.");
						break;
					case AppearanceDefs.VAGINA_WETNESS_SLICK:
						outputText("Your " + allVaginaDescript() + " become" + (player.vaginas.length > 1 ? "" : "s") + " sloppy and wet.");
						break;
					case AppearanceDefs.VAGINA_WETNESS_DROOLING:
						outputText("Thick runners of girl-lube stream down the insides of your thighs.");
						break;
					case AppearanceDefs.VAGINA_WETNESS_SLAVERING:
						outputText("Your " + allVaginaDescript() + " instantly soak" + (player.vaginas.length > 1 ? "" : "s") + " your groin.");
					default: //Dry vaginas are unaffected
						
				}
			}
			outputText("\n");
			if (player.lust >= player.maxLust())
				doNext(game.endLustLoss);
			else doNext(EventParser.playerMenu);
		}
		
		protected function lustMagicAttack1():void {
			outputText("You see " + a + short + " make sudden arcane gestures at you!\n\n");
			player.dynStats("lus", player.lib / 20 + player.cor / 20 + 5);
			if (player.lust < (player.maxLust() * 0.3)) outputText("You feel strangely warm.  ");
			if (player.lust >= (player.maxLust() * 0.3) && player.lust < (player.maxLust() * 0.6)) outputText("Blood rushes to your groin as a surge of arousal hits you, making your knees weak.  ");
			if (player.lust >= (player.maxLust() * 0.6)) outputText("Images of yourself fellating and fucking the imp assault your mind, unnaturally arousing you.  ");
			if (player.cocks.length > 0) {
				if (player.lust >= (player.maxLust() * 0.6))
					outputText("You feel your [cocks] dribble pre-cum.");
				else if (player.lust >= (player.maxLust() * 0.3) && player.cocks.length == 1)
					outputText("Your [cock] hardens, distracting you further.");
				else if (player.lust >= (player.maxLust() * 0.3) && player.cocks.length > 1)
					outputText("Your [cocks] harden uncomfortably.");
				if (player.hasVagina()) outputText("  ");
			}
			if (player.lust >= (player.maxLust() * 0.6) && player.hasVagina()) {
				switch (player.vaginas[0].vaginalWetness) {
					case AppearanceDefs.VAGINA_WETNESS_NORMAL:
						outputText("Your " + allVaginaDescript() + " dampen" + (player.vaginas.length > 1 ? "" : "s") + " perceptibly.");
						break;
					case AppearanceDefs.VAGINA_WETNESS_WET:
						outputText("Your crotch becomes sticky with girl-lust.");
						break;
					case AppearanceDefs.VAGINA_WETNESS_SLICK:
						outputText("Your " + allVaginaDescript() + " become" + (player.vaginas.length > 1 ? "" : "s") + " sloppy and wet.");
						break;
					case AppearanceDefs.VAGINA_WETNESS_DROOLING:
						outputText("Thick runners of girl-lube stream down the insides of your thighs.");
						break;
					case AppearanceDefs.VAGINA_WETNESS_SLAVERING:
						outputText("Your " + allVaginaDescript() + " instantly soak" + (player.vaginas.length > 1 ? "" : "s") + " your groin.");
					default: //Dry vaginas are unaffected
						
				}
			}
			outputText("\n");
			if (player.lust >= player.maxLust())
				doNext(game.endLustLoss);
			else doNext(EventParser.playerMenu);
		}
        public function allVaginaDescript():String {
            if (player.vaginas.length == 1) return Appearance.vaginaDescript(player,rand(player.vaginas.length - 1));
            if (player.vaginas.length > 1) return (Appearance.vaginaDescript(player,rand(player.vaginas.length - 1)) + "s");

            CoC_Settings.error("ERROR: allVaginaDescript called with no vaginas.");
            return "ERROR: allVaginaDescript called with no vaginas.";
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
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_NORMAL;
			this.tallness = rand(24) + 25;
			this.hipRating = AppearanceDefs.HIP_RATING_BOYISH;
			this.buttRating = AppearanceDefs.BUTT_RATING_TIGHT;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(20, 10, 20, 12);
			initLibSensCor(45, 45, 100);
			this.weaponName = "claws";
			this.weaponVerb = "claw-slash";
			this.weaponAttack = 1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.armorName = "leathery skin";
			this.armorDef = 1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.bonusLust = 30;
			this.lust = 40;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 1;
			this.gems = rand(5) + 5;
			this.drop = new WeightedDrop().
					add(consumables.SUCMILK,3).
					add(consumables.INCUBID,3).
					add(consumables.IMPFOOD,4);
			this.special1 = lustMagicAttack1;
			this.wingType = AppearanceDefs.WING_TYPE_IMP;
			this.str += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 105;
			checkMonster();
		}

	}

}
