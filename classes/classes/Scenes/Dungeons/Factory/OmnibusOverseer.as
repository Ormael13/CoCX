package classes.Scenes.Dungeons.Factory
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class OmnibusOverseer extends Monster
	{
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.factory.winAgainstOmnibus();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.dungeons.factory.doLossOmnibus();
			}
		}
		
		private function lustAura():void {
			outputText("The demoness blinks her eyes closed and knits her eyebrows in concentration.  The red orbs open wide and she smiles, licking her lips.   The air around her grows warmer, and muskier, as if her presence has saturated it with lust.");
			if (hasStatusEffect(StatusEffects.LustAura)) {
				outputText("  Your eyes cross with unexpected feelings as the taste of desire in the air worms its way into you.  The intense aura quickly subsides, but it's already done its job.");
				player.takeLustDamage((eBaseLibidoDamage() / 20 + int(player.lib / 20 + player.cor / 25)), true);
			}
			else {
				createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
				outputText("\nIf you don't do something, you'll quickly succumb!");
				clearTempResolute(false);
			}
		}
		
		private function milkAttack():void {
			if (rand(2) == 0)
				outputText("The demoness grips her sizable breasts and squeezes, spraying milk at you.\n");
			else outputText("Your foe curls up to pinch her nipples, tugging hard and squirting milk towards you.\n");
			if (player.getEvasionRoll()) {
				outputText("You sidestep the gushing fluids.");
			}
			//You didn't dodge
			else {
				if (rand(2) == 0) {
					outputText("The milk splatters across your face and chest, soaking you with demonic cream.  Some managed to get into your mouth, and you swallow without thinking.  It makes you tingle with warmth.  ");
				}
				else {
					outputText("The milk splashes into your [armor], soaking you effectively.  ");
					if (player.cocks.length > 0) {
						outputText("Your [cock] gets hard as the milk lubricates and stimulates it.  ");
						player.takeLustDamage(eBaseLibidoDamage() / 50, true);
					}
					if (player.vaginas.length > 0) {
						outputText("You rub your thighs together as the milk slides between your pussy lips, stimulating you far more than it should.  ");
						player.takeLustDamage(eBaseLibidoDamage() / 50, true);
					}
				}
				if (player.biggestLactation() > 1) outputText("Milk dribbles from your [allbreasts] in sympathy.");
				player.takeLustDamage(eBaseLibidoDamage() / 30 + player.effectiveSensitivity() / 20, true);

			}
		}

		override protected function handleStun():Boolean {
			if (hasStatusEffect(StatusEffects.LustAura)) {
				outputText("The Overseer's concentration shatters, dispelling the lust aura!\n\n");
				removeStatusEffect(StatusEffects.LustAura);
			}

			return super.handleStun();
		}

		override protected function handleFear():Boolean {
			if (hasStatusEffect(StatusEffects.LustAura)) {
				outputText("The Overseer's concentration shatters, dispelling the lust aura!\n\n");
				removeStatusEffect(StatusEffects.LustAura);
			}

			return super.handleFear();
		}

		override protected function handleConfusion():Boolean {
			if (hasStatusEffect(StatusEffects.LustAura)) {
				outputText("The Overseer's concentration shatters, dispelling the lust aura!\n\n");
				removeStatusEffect(StatusEffects.LustAura);
			}

			return super.handleConfusion();
		}

		override public function displaySpecialStatuses():Array {
			var statusArray:Array = super.displaySpecialStatuses();
			trace("Check Called: " + hasStatusEffect(StatusEffects.LustAura));
			if (hasStatusEffect(StatusEffects.LustAura)) statusArray.push("Lust Aura");
			return statusArray;
		}
		
		public function OmnibusOverseer()
		{
			this.a = "the ";
			this.short = "Omnibus Overseer";
			this.imageName = "omnibusoverseer";
			this.long = "The 'woman' before you is clothed only in a single strip of fabric that wraps around her bountiful chest.  She has striking red eyes that contrast visibly with her blue skin and dark make-up.  Shiny black gloss encapsulates her kissable bubbly black lips.  Her most striking feature is her crotch, which appears neither male nor female.  She has a puffy wet vulva, but a cock-shaped protrusion sprouts from where a clit should be.";
			// this.plural = false;
			this.createCock(10,1.5);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_TIGHT;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.bodyColor = "light purple";
			this.hairColor = "purple";
			this.hairLength = 42;
			initStrTouSpeInte(100, 73, 49, 85);
			initWisLibSensCor(85, 95, 70, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 15;
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 22;
			this.armorMDef = 3;
			this.bonusHP = 420;
			this.bonusLust = 185;
			this.lust = 20;
			this.lustVuln = 0.75;
			this.level = 20;
			this.gems = rand(35) + 30;
			this.additionalXP = 200;
			this.drop = new WeightedDrop(null, 1);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: lustAura, type: ABILITY_TEASE, range: RANGE_SELF, tags:[]},
				{ call: milkAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[TAG_FLUID]},
			];
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 20, 0, 0, 0);
			checkMonster();
		}
		
	}

}
