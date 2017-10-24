package classes.Scenes.Monsters 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.internals.*;

public class GoblinQueen extends Goblin
	{
		//użyć ten wzór do zrobienia tej succubigoblinqueen ^^
		public function GoblinQueen() 
		{
			this.a = "the ";
			this.short = "goblin queen";
			this.imageName = "goblinqueen";
			this.long = "The goblin before you stands nearly four feet tall. Her ears appear to be pierced more times than the amount of piercings a typical goblin has. Her hair is dark green and her skin color is a vibrant yellow, a sheer rarity. She’s unlike most of the goblins you’ve seen. She’s wielding a staff in her right hand. In addition to the straps covering her body, she’s wearing a necklace seemingly carved with what looks like shark teeth. She's wielding a glowing sword in her right hand and a shield in her left hand. ";
			this.createVagina(false, AppearanceDefs.VAGINA_WETNESS_DROOLING, AppearanceDefs.VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("FF"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 47;
			this.hipRating = AppearanceDefs.HIP_RATING_AMPLE+2;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE;
			this.skinTone = "dark green";
			this.hairColor = "dark green";
			this.hairLength = 4;
			initStrTouSpeInte(85, 64, 70, 100);
			initLibSensCor(55, 35, 65);
			this.weaponName = "sword";
			this.weaponVerb = "slash";
			this.weaponAttack = 14 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "fur loincloth";
			this.armorDef = 6 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.fatigue = 0;
			this.bonusHP = 275;
			this.bonusLust = 20;
			this.lust = 35;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 14;
			this.gems = rand(15) + 15;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					add(weapons.W_STAFF,1).
					//add(armors.FURLOIN,1).
					add(jewelries.MYSTRNG,1).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			//this.special3 = castSpell;
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.str += 17 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1480;
			checkMonster();
		}
		
	}

}
