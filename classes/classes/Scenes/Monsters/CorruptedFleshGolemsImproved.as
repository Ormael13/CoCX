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
	
	public class CorruptedFleshGolemsImproved extends CorruptedFleshGolemsBasic
	{
		public function corruptedGolemsFire():void {
			var damage:int = (inte + wis + rand(10)) * 3;
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard, 1, -1);
				outputText("The corrupted golems mutters something. Before you have time to react the demonic golems hands are filled with a bright red fire that their hurls at you.  The flames lick at your body leaving a small burn on you torso due to protedction of blizzard, as well as an arousing heat in your groin. ");
				damage *= 0.2;
			}
			else outputText("The corrupted golems mutters something. Before you have time to react the demonic golems hands are filled with a bright red fire that their hurls at you.  The flames lick at your body leaving a painful burn on you torso, as well as an arousing heat in your groin. ");
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			player.dynStats("lus", 50 + player.cor / 5);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Provoke)) {
				var choiceP:Number = rand(4);
				if (choiceP < 2) eAttack();
				if (choiceP > 1) corruptedGolemsSwordSlash();
			}
			else {
				var choice:Number = rand(5);
				if (choice < 2) eAttack();
				if (choice == 2) corruptedGolemsFire();
				if (choice == 3) corruptedGolemsSwordSlash();
				if (choice == 4) corruptedGolemsLustAttack();
			}
		}
		
		public function CorruptedFleshGolemsImproved() 
		{
			this.a = "the ";
			this.short = "corrupted improved flesh golems";
			this.imageName = "corrupted improved flesh golems";
			this.long = "You're currently fighting corrupted improved flesh golems. They're eight feet tall with flesh covered by white armor fragments, which still leaving genitalia, with pretty sizable cocks, or breasts exposed. Despite not possesing visible eyes on her elongated head, they're using pair of weapons to attack enemies.";
			this.createCock(15,2.25,CockTypesEnum.DEMON);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 300, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_LOOSE;
			this.ass.analWetness = AssClass.WETNESS_SLIMY;
			this.createStatusEffect(StatusEffects.BonusACapacity, 300, 0, 0, 0);
			initStrTouSpeInte(240, 280, 220, 15);
			initWisLibSensCor(15, 200, 100, 100);
			this.tallness = 96;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_JIGGLY;
			this.skinTone = "pink";
			this.weaponName = "dual swords";
			this.weaponVerb = "slash";
			this.weaponAttack = 100;
			this.armorName = "white armor";
			this.armorDef = 80;
			this.armorMDef = 40;
			this.bonusHP = 700;
			this.lust = 30;
			this.bonusLust = 361;
			this.lustVuln = .4;
			this.level = 61;
			this.additionalXP = 350;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.gems = rand(10)+5;
			this.wings.type = Wings.BAT_LIKE_TINY;
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
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}