/**
 * ...
 * @author Zevos
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;

	public class IgnisArenaSeer extends Monster
	{
		
		public function IgnisArenaSeer() 
		{
			this.a = "";
			this.short = "Ignis, the Seer of the Arena";
			this.imageName = "ignis";
			this.long = "You’re facing Ignis, a kitsune seer.   The white furred kitsune is wearing a {hp<50:torn }grey kimono, flickering with magical flames. {Charged armor known:It seems Ignis is using a variant of charged armor. }Ignis’ left hand is lit up by an aura of blue flames, ready to flare up into gouts of foxfire at a moment’s notice. In his right hand is his metal staff, foxfire burning at it’s tip.";
			// this.plural = false;
			this.createCock(15,2.5,CockTypesEnum.FOX);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 6;
			this.hoursSinceCum = 400;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = rand(24) + 60;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "white";
			this.hairColor = "silver";
			this.hairLength = 13 + rand(20);
			initStrTouSpeInte(35, 55, 110, 105);
			initLibSensCor(60, 65, 45);
			this.weaponName = "staff";
			this.weaponVerb="smack";
			this.weaponAttack = 8 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "grey kimono";
			this.armorDef = 5 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 120;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 45;//mają wtedy tylko 2 ogony ale z czasem jak PC też rośnie w siłe z lvl-em bdą mieć awans to lvl może 18-20 i trzeci ogon plus wzmocnienie statów itp.
			this.gems = rand(20) + 20;
			this.drop = new WeightedDrop().
					add(consumables.MG_SFRP,1).
					add(consumables.FOXJEWL,4);
			this.tailType = TAIL_TYPE_FOX;
			this.str += 7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 22 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1460;//50hp x i 30% boost do statów
			checkMonster();
		}
		
	}

}