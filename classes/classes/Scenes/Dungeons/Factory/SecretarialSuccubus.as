package classes.Scenes.Dungeons.Factory
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Dungeons.Factory;
import classes.Scenes.Monsters.AbstractSuccubus;
import classes.internals.*;

public class SecretarialSuccubus extends AbstractSuccubus
	{
		public var factory:Factory = new Factory()
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.gender > 0) {
				var dildo:Function = (player.hasKeyItem("Deluxe Dildo") >= 0 ? game.succubusGetsDildoed : null);
				
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you rape her?", true);
					player.dynStats("lus", 1);
					game.simpleChoices("Yes", factory.doRapeSuccubus, "", null, "", null, "", null, "No", factory.doLeaveSuccubus);
					if (player.hasKeyItem("Deluxe Dildo") >= 0) game.addButton(1, "Dildo Rape", factory.dildoSuccubus);
				} else if (player.lust>=33){
					outputText("You smile in satisfaction as the " + short + " gives up on fighting you and starts masturbating, begging for you to fuck her.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you fuck her?", true);
					player.dynStats("lus", 1);
					game.simpleChoices("Yes", factory.doRapeSuccubus, "", null, "", null, "", null, "No", factory.doLeaveSuccubus);
					if (player.hasKeyItem("Deluxe Dildo") >= 0) game.addButton(1, "Dildo Rape", factory.dildoSuccubus);
				} else {
					doNext(factory.doLeaveSuccubus);
				}
			} else {
				doNext(factory.doLeaveSuccubus);
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(game.endLustLoss);
			} else {
				doNext(factory.doLossSuccubus);
			}
		}

		public function SecretarialSuccubus() {
			this.a = "the ";
			this.short = "secretarial succubus";
			this.imageName = "secretarialsuccubus";
			this.long = "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.";
			// this.plural = false;
			this.createVagina(false, AppearanceDefs.VAGINA_WETNESS_SLAVERING, AppearanceDefs.VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 60;
			this.hipRating = AppearanceDefs.HIP_RATING_CURVY;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE+1;
			this.lowerBody = AppearanceDefs.LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
			this.skinTone = "blue";
			this.hairColor = "blond";
			this.hairLength = 13;
			initStrTouSpeInte(60, 50, 85, 35);
			initLibSensCor(80, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="slap";
			this.weaponAttack = 12 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 6 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 200;
			this.bonusLust = 40;
			this.lust = 30;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 12;
			this.gems = rand(25) + 20;
			this.additionalXP = 75;
			this.drop = new WeightedDrop(consumables.LACTAID, 1);
			this.wingType = AppearanceDefs.WING_TYPE_BAT_LIKE_TINY;
			this.wingDesc = "tiny hidden";
			this.tailType = AppearanceDefs.TAIL_TYPE_DEMONIC;
			this.special1 = kissAttack;
			this.special2 = seduceAttack;
			this.special3 = whipAttack;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.str += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 17 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1240;
			checkMonster();
		}

	}

}
