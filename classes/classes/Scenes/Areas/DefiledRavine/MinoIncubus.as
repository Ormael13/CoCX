/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DefiledRavine 
{
	import classes.*;
	import classes.internals.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Areas.BlightRidge.DemonScene;
	
	use namespace CoC;
	
	public class MinoIncubus extends Monster 
	{
		
		public function MinoIncubus() 
		{
			this.a = "the ";
			this.short = "minotaur";
			this.imageName = "minotaur";
			this.long = "";
			// this.plural = false;
			this.createCock(rand(13)+ 24,2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = rand(37) + 84;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			this.lowerBody = LowerBody.HOOFED;
			this.skin.growFur({color:furColor});
			this.skinDesc = "shaggy fur";
			this.hairColor = furColor;
			this.hairLength = 3;
			this.faceType = Face.COW_MINOTAUR;
			initStrTouSpeInte(100, 70, 35, 20);
			initWisLibSensCor(20, 40 + this.ballSize * 2, 15 + this.ballSize * 2, 35);
			this.weaponName = "axe";
			this.weaponVerb = "cleave";
			this.weaponAttack = 50;
			this.armorName = "thick fur";
			this.armorDef = 12;
			this.armorMDef = 1;
			this.bonusHP = 20 + rand(this.ballSize * 2);
			this.lust = this.ballSize * 3;
			this.lustVuln = 0.84;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 15;
			this.gems = rand(15) + 15;
			//this.special1 = SceneLib.mountain.minotaurScene.minoPheromones;
			this.tailType = Tail.COW;
			this.bonusLust = 70 + this.ballSize * 4 + rand(this.ballSize * 3);
			this.drop = new WeightedDrop().
					add(consumables.BROBREW, 1).
					add(weapons.DL_AXE_, 2).
					add(consumables.MINOCUM, 6).
					add(consumables.MINOBLO, 8).
					add(consumables.INCUBID, 10);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
	}
}