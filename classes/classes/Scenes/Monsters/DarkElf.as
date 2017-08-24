/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.DarkElfScene;
	
	public class DarkElf extends Monster
	{
		public var darkelf:DarkElfScene = new DarkElfScene()
		
		override public function defeated(hpVictory:Boolean):void
		{
			darkelf.wonWithDarkElf();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			darkelf.lostToDarkElf();
		}
		
		public function PoisonedBowShoot():void
		{
			
		}
		
		public function AnkleShot():void
		{
			outputText("The dark skinned elf shot you through the ankle and gains some distance. Crippled like you are, it will be annoying to catch her, if not impossible. Better use ranged attack until you recover mobility.");
			player.createStatusEffect(StatusEffects.Sealed2, 4, 0, 0, 0);
		}
		
		public function WingClip():void
		{
			outputText("The dark elf makes a wicked smirk before letting out an arrow straight into your wing. You fall down, unable to fly and crashing to the ground.");
			player.removeStatusEffect(StatusEffects.Flying);
			var damage:Number = 0;
			damage += this.str + this.spe;
			damage = Math.round(damage);
			player.takeDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice == 0) eAttack();
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.Sealed2)) AnkleShot();
				else eAttack();
			}
			if (choice == 2) {
				if (player.hasStatusEffect(StatusEffects.Flying) && rand(4) == 0) WingClip();
				else eAttack();
			}
			combatRoundOver();
		}
		
		public function DarkElf() 
		{
			this.a = "the ";
			this.short = "dark elf scout";
			this.imageName = "dark elf";
			this.long = "This woman with dark skin has long pointed ears. You suspect her to be a dark elf, though why she’s here on the surface, you have no idea. Regardless, she’s dangerous and seems well equipped for kidnapping.";
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = 72;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
			this.skinTone = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(25, 40, 75, 40);
			initLibSensCor(45, 45, 60);
			this.weaponName = "elven bow";
			this.weaponVerb = "shoot";
			this.weaponAttack = 1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.armorName = "elven armor";
			this.armorDef = 1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.bonusLust = 20;
			this.lust = 50;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 20;
			this.gems = rand(5) + 5;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.SUCMILK,6);//elf tf item here
			this.str += 14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1020;
			checkMonster();
		}
	}
}