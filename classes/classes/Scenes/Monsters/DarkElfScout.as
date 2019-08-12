/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.Places.HeXinDao;
import classes.internals.*;

public class DarkElfScout extends Monster
	{
		public var darkelf:DarkElfScene = new DarkElfScene();
		public var golems:HeXinDao = new HeXinDao();
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) {
				golems.gaunletchallange1postfight();
			}
			else darkelf.wonWithDarkElf();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			darkelf.lostToDarkElf();
		}
		
		public function DarkElfBowShooting():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("The black skinned elf aims her bow at you, drawing several arrows and starts shooting.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
		}
		
		public function PoisonedBowShoot():void
		{
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("An arrow hits wind wall dealing no damage to you.\n\n");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				var damage:Number = 0;
				damage += eBaseSpeedDamage() * 0.2;
				if (damage < 10) damage = 10;
				if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
				else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
				else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
				else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
				else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
				damage = Math.round(damage);
				outputText("An arrow hits you for ");
				player.takePhysDamage(damage, true);
				outputText(" damage. It was poisoned! You feel your strength failing you!\n\n");
				player.addCombatBuff('spe', -3);
			}
		}
		
		public function AnkleShot():void
		{
			outputText("The dark skinned elf shoot you through the ankle and takes some distance. Crippled like you are, it will be annoying to catch her--if not impossible. Better use ranged attacks until you recover mobility.");
			player.createStatusEffect(StatusEffects.Sealed2, 4, 0, 0, 0);
		}
		
		public function WingClip():void
		{
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("An arrow hits wind wall dealing no damage to you.\n\n");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				outputText("The dark elf smirks wickedly before shooting an arrow straight into your wing. You fall, unable to fly, and crash into the ground. ");
				player.removeStatusEffect(StatusEffects.Flying);
				var damage:Number = 0;
				damage += this.str * 2.5;
				damage += eBaseSpeedDamage() * 2.5;
				if (damage < 10) damage = 10;
				if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
				else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
				else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
				else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
				else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
				damage = Math.round(damage);
				player.takePhysDamage(damage, true);
				outputText("\n\n");
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice == 0) DarkElfBowShooting();
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.Sealed2)) AnkleShot();
				else DarkElfBowShooting();
			}
			if (choice == 2) {
				if (player.isFlying() && rand(4) == 0) WingClip();
				else DarkElfBowShooting();
			}
		}
		
		public function DarkElfScout() 
		{
			this.a = "the ";
			this.short = "dark elf scout";
			this.imageName = "dark elf";
			this.long = "This woman with dark skin has long pointed ears. You suspect her to be a dark elf, though why she’s here on the surface, you have no idea. Regardless, she’s dangerous and seems well equipped for kidnapping.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.ELF;
			this.skinTone = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(30, 30, 90, 40);
			initWisLibSensCor(40, 50, 60, 80);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5;
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 18;
			this.armorName = "elven armor";
			this.armorDef = 4;
			this.armorMDef = 4;
			this.bonusLust = 20;
			this.lustVuln = .7;
			this.lust = 50;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 15;
			this.gems = rand(10) + 10;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			checkMonster();
		}
	}
}