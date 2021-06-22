package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Imp extends Monster
	{
		public var Evangeline:EvangelineFollower = new EvangelineFollower();

		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			if (hasStatusEffect(StatusEffects.KitsuneFight)) {
				SceneLib.forest.kitsuneScene.winKitsuneImpFight();
			}
			else if (flags[kFLAGS.EVANGELINE_AFFECTION] == 1) {
				Evangeline.winEvangelineImpFight();
			}
			else {
				SceneLib.impScene.impVictory();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hasStatusEffect(StatusEffects.KitsuneFight)) {
				SceneLib.forest.kitsuneScene.loseKitsuneImpFight();
			}
			else if (pcCameWorms) {
				outputText("\n\nThe imp grins at your already corrupted state...");
				player.lust = player.maxLust();
				doNext(SceneLib.impScene.impRapesYou);
			}
			else if (flags[kFLAGS.EVANGELINE_AFFECTION] == 1) {
				flags[kFLAGS.EVANGELINE_AFFECTION] = 2;
				SceneLib.impScene.impRapesYou();
			}
			else {
				SceneLib.impScene.impRapesYou();
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
					case VaginaClass.WETNESS_NORMAL:
						outputText("Your " + allVaginaDescript() + " dampen" + (player.vaginas.length > 1 ? "" : "s") + " perceptibly.");
						break;
					case VaginaClass.WETNESS_WET:
						outputText("Your crotch becomes sticky with girl-lust.");
						break;
					case VaginaClass.WETNESS_SLICK:
						outputText("Your " + allVaginaDescript() + " become" + (player.vaginas.length > 1 ? "" : "s") + " sloppy and wet.");
						break;
					case VaginaClass.WETNESS_DROOLING:
						outputText("Thick runners of girl-lube stream down the insides of your thighs.");
						break;
					case VaginaClass.WETNESS_SLAVERING:
						outputText("Your " + allVaginaDescript() + " instantly soak" + (player.vaginas.length > 1 ? "" : "s") + " your groin.");
					default: //Dry vaginas are unaffected

				}
			}
			outputText("\n");
			if (player.lust >= player.maxLust())
				doNext(SceneLib.combat.endLustLoss);
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
					case VaginaClass.WETNESS_NORMAL:
						outputText("Your " + allVaginaDescript() + " dampen" + (player.vaginas.length > 1 ? "" : "s") + " perceptibly.");
						break;
					case VaginaClass.WETNESS_WET:
						outputText("Your crotch becomes sticky with girl-lust.");
						break;
					case VaginaClass.WETNESS_SLICK:
						outputText("Your " + allVaginaDescript() + " become" + (player.vaginas.length > 1 ? "" : "s") + " sloppy and wet.");
						break;
					case VaginaClass.WETNESS_DROOLING:
						outputText("Thick runners of girl-lube stream down the insides of your thighs.");
						break;
					case VaginaClass.WETNESS_SLAVERING:
						outputText("Your " + allVaginaDescript() + " instantly soak" + (player.vaginas.length > 1 ? "" : "s") + " your groin.");
					default: //Dry vaginas are unaffected

				}
			}
			outputText("\n");
			if (player.lust >= player.maxLust())
				doNext(SceneLib.combat.endLustLoss);
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
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(24) + 25;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(18, 9, 18, 11);
			initWisLibSensCor(11, 45, 45, 100);
			this.weaponName = "claws";
			this.weaponVerb = "claw-slash";
			this.weaponAttack = 1;
			this.armorName = "leathery skin";
			this.armorDef = 1;
			this.armorMDef = 0;
			this.bonusLust = 91;
			this.lust = 40;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 1;
			this.gems = rand(5) + 5;
			this.drop = new WeightedDrop().
					add(consumables.SUCMILK,3).
					add(consumables.INCUBID,3).
					add(consumables.IMPFOOD,4);
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
				{call: lustMagicAttack1, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[]}
			];
			this.wings.type = Wings.IMP;
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
