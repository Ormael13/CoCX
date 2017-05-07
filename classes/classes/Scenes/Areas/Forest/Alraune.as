/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.internals.ChainedDrop;

	public class Alraune extends Monster
	{
		
		public function Alraune() 
		{
			super();
			this.a = "an ";
			this.short = "Alraune";
			this.imageName = "alraune";
			this.long = "You are fighting against an alraune, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
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
			initStrTouSpeInte(30, 50, 30, 20);
			initLibSensCor(60, 55, 0);
			this.weaponName = "chitin-plated fist";
			this.weaponVerb="armored punch";
			this.weaponAttack = 4 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "chitin";
			this.armorDef = 12 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 40;
			this.bonusLust = 20;
			this.lust = 20 + rand(40);
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 20;
			this.gems = rand(20) + 5;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 6)
					.add(consumables.W__BOOK, 1 / 4)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.antennae = ANTENNAE_BEE;
			this.wingType = WING_TYPE_BEE_LIKE_SMALL;
			this.tailType = TAIL_TYPE_BEE_ABDOMEN;
			this.tailVenom = 100;
			this.special1 = beeStingAttack;
			this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 380;
			checkMonster();
		}
		
	}

}