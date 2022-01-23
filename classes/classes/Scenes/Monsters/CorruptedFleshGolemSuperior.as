/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Wings;
	import classes.internals.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	
	public class CorruptedFleshGolemSuperior extends CorruptedFleshGolemsBasic
	{
		
		public function CorruptedFleshGolemSuperior() 
		{
			
			this.createCock(21,2.75,CockTypesEnum.DEMON);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 500, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("F"));
			this.ass.analLooseness = AssClass.LOOSENESS_GAPING;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity, 500, 0, 0, 0);
			initStrTouSpeInte(120, 140, 110, 10);
			initWisLibSensCor(10, 100, 50, 100);
			this.tallness = 120;
			this.hips.type = Hips.RATING_INHUMANLY_WIDE;
			this.butt.type = Butt.RATING_INCONCEIVABLY_BIG;
			this.skinTone = "pink";
			this.weaponName = "dual swords";
			this.weaponVerb = "slash";
			this.weaponAttack = 50;
			this.armorName = "white armor";
			this.armorDef = 40;
			this.armorMDef = 20;
			this.bonusHP = 350;
			this.lust = 30;
			this.bonusLust = 186;
			this.lustVuln = .2;
			this.level = 36;
			this.additionalXP = 350;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.gems = rand(10)+5;
			this.wings.type = Wings.BAT_LIKE_LARGE_2;
			this.tailType = Tail.DEMONIC;
			this.drop = new WeightedDrop().
					add(consumables.BIMBOLQ, 1).
					add(consumables.BROBREW, 1).
					add(weapons.DDAGGER, 10).
					add(weapons.DL_AXE_, 10).
					add(weapons.DSWORD_, 10).
					add(weapons.DKATANA, 10).
					add(weapons.D_LANCE, 10);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}