package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
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
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("FF"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 47;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "dark green";
			this.hairColor = "dark green";
			this.hairLength = 4;
			initStrTouSpeInte(85, 64, 70, 100);
			initWisLibSensCor(100, 55, 35, 30);
			this.weaponName = "sword";
			this.weaponVerb = "slash";
			this.weaponAttack = 14;
			this.armorName = "fur loincloth";
			this.armorDef = 6;
			this.armorMDef = 6;
			this.fatigue = 0;
			this.bonusHP = 275;
			this.bonusLust = 104;
			this.lust = 35;
			this.lustVuln = 0.4;
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
							consumables.PURPDYE,
							consumables.HEALHERB,
							consumables.MOONGRASS,
							consumables.SNAKEBANE,
							consumables.IRONWEED,
							consumables.BLADEFERN,
							consumables.RAUNENECT,
							consumables.GINSENG);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			//this.special3 = castSpell;
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
