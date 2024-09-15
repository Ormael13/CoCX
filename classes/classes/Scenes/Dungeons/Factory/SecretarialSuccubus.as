package classes.Scenes.Dungeons.Factory
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.Monsters.AbstractSuccubus;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class SecretarialSuccubus extends AbstractSuccubus
	{

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.factory.secretarialSuccubusDefeated(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				doNext(SceneLib.dungeons.factory.doLossSuccubus);
			}
		}

		public function SecretarialSuccubus() {
			this.a = "the ";
			this.short = "secretarial succubus";
			this.imageName = "secretarialsuccubus";
			this.long = "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 60;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.bodyColor = "blue";
			this.hairColor = "blond";
			this.hairLength = 13;
			initStrTouSpeInte(60, 52, 89, 35);
			initWisLibSensCor(35, 85, 70, 100);
			this.weaponName = "claws";
			this.weaponVerb="slap";
			this.weaponAttack = 12;
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 8;
			this.armorMDef = 2;
			this.bonusHP = 220;
			this.bonusLust = 171;
			this.lust = 30;
			this.level = 16;
			this.gems = rand(25) + 20;
			this.additionalXP = 75;
			this.drop = new WeightedDrop(consumables.LACTAID, 1);
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: kissAttack, type: ABILITY_TEASE, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: seduceAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
				{ call: whipAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_WEAPON]}
			];
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 16, 0, 0, 0);
			checkMonster();
		}
	}

}
