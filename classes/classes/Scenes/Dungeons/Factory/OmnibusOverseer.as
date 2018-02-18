package classes.Scenes.Dungeons.Factory
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.Dungeons.Factory;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class OmnibusOverseer extends Monster
	{
		public var factory:Factory = new Factory();
		private var temp:Number = 0;
		
		override public function defeated(hpVictory:Boolean):void
		{
			factory.winAgainstOmnibus();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				factory.doLossOmnibus();
			}
		}
		
		private function lustAura():void {
			outputText("The demoness blinks her eyes closed and knits her eyebrows in concentration.  The red orbs open wide and she smiles, licking her lips.   The air around her grows warmer, and muskier, as if her presence has saturated it with lust.");
			if (hasStatusEffect(StatusEffects.LustAura)) {
				outputText("  Your eyes cross with unexpected feelings as the taste of desire in the air worms its way into you.  The intense aura quickly subsides, but it's already done its job.");
				player.dynStats("lus", (8 + int(player.lib / 20 + player.cor / 25)));
			}
			else {
				createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
			}
		}
		
		private function milkAttack():void {
			if (rand(2) == 0)
				outputText("The demoness grips her sizable breasts and squeezes, spraying milk at you.\n");
			else outputText("Your foe curls up to pinch her nipples, tugging hard and squirting milk towards you.\n");
			if ((player.spe > 50 && rand(4) == 0) || (player.findPerk(PerkLib.Evade) >= 0 && rand(3) == 0) || (player.findPerk(PerkLib.Misdirection) >= 0 && rand(4) == 0 && player.armorName == "red, high-society bodysuit")) {
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
						player.dynStats("lus", 5);
					}
					if (player.vaginas.length > 0) {
						outputText("You rub your thighs together as the milk slides between your pussy lips, stimulating you far more than it should.  ");
						player.dynStats("lus", 5);
					}
				}
				player.dynStats("lus", 7 + player.sens / 20);
				if (player.biggestLactation() > 1) outputText("Milk dribbles from your [allbreasts] in sympathy.");
			}
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
			this.skinTone = "light purple";
			this.hairColor = "purple";
			this.hairLength = 42;
			initStrTouSpeInte(100, 70, 45, 85);
			initWisLibSensCor(85, 90, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 12;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 18;
			this.bonusHP = 400;
			this.bonusLust = 50;
			this.lust = 20;
			this.lustVuln = 0.75;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 16;
			this.gems = rand(35) + 30;
			this.additionalXP = 200;
			this.drop = new WeightedDrop(null, 1);
			this.special1 = lustAura;
			this.special2 = milkAttack;
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
