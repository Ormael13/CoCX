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
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class LightElfs extends Monster
	{
		public var lightelf:LightElfScene = new LightElfScene();
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) {
				SceneLib.hexindao.gaunletchallange1postfight();
			}
			else lightelf.wonWithLightElf();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			lightelf.lostToLightElf();
		}
		
		public function LightElfBowShooting():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("The light skinned elf aims her bow at you, drawing several arrows and starts shooting.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 11) {
				if (rand(100) < (70 + Acc)) PoisonedBowShoot();
				else outputText("An arrow missed you.\n\n");
			}
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 12) {
				if (rand(100) < (60 + Acc)) PoisonedBowShoot();
				else outputText("An arrow missed you.\n\n");
			}
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 13) {
				if (rand(100) < (50 + Acc)) PoisonedBowShoot();
				else outputText("An arrow missed you.\n\n");
			}
		}
		
		public function PoisonedBowShoot():void
		{
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("An arrow hits the wind wall dealing no damage to you.\n\n");
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
				player.addCombatBuff('spe', -3, "Poisoned Arrow", "PoisonedArrow");
			}
		}
		
		public function AnkleShot():void
		{
			outputText("The light skinned elf shoot you through the ankle and takes some distance. Crippled like you are, it will be annoying to catch her--if not impossible. Better use ranged attacks until you recover mobility.");
			player.createStatusEffect(StatusEffects.Sealed2, 4, 0, 0, 0);
		}
		
		public function WingClip():void
		{
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("An arrow hits wind wall dealing no damage to you.\n\n");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				outputText("The light elf smirks wickedly before shooting an arrow straight into your wing. You fall, unable to fly, and crash into the ground. ");
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
			if (choice == 0) LightElfBowShooting();
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.Sealed2)) AnkleShot();
				else LightElfBowShooting();
			}
			if (choice == 2) {
				if (player.isFlying() && rand(4) == 0) WingClip();
				else LightElfBowShooting();
			}
		}
		
		public function LightElfs()
		{
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 10) {
				this.short = "light elf scout";
				this.long = "This woman with light skin has long pointed ears. You suspect her to be a light elf, though why she’s here, you have no idea. Regardless, she’s dangerous and seems well equipped for kidnapping.";
				initStrTouSpeInte(30, 30, 90, 40);
				initWisLibSensCor(40, 50, 60, 80);
				this.armorDef = 4;
				this.armorMDef = 4;
				this.weaponAttack = 5;
				this.weaponRangeAttack = 18;
				this.bonusLust = 124;
				this.level = 14;
				this.gems = rand(10) + 10;
			}
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 11) {
				this.short = "light elf slaver";
				this.long = "This lightly armored woman is a Light elf. She's slender and elegant, with light skin and long pointed ears. The look in her eyes, a mixture of bloodlust and greed, give her intentions away...as does her equipment. Ropes, poisoned arrows, she's come to capture slaves. You can hear faint voices from somewhere nearby. Has she already captured people today?";
				initStrTouSpeInte(60, 80, 140, 70);
				initWisLibSensCor(70, 60, 70, 85);
				this.armorDef = 8;
				this.armorMDef = 8;
				this.weaponAttack = 8;
				this.weaponRangeAttack = 27;
				this.bonusLust = 159;
				this.level = 29;
				this.gems = rand(10) + 25;
			}
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 12) {
				this.short = "light elf ranger";
				this.long = "This woman is a Light elf. She's slender and elegant, with light skin and long pointed ears. The look in her eyes, a mixture of bloodlust and greed, give her intentions away...as does her equipment. Ropes, poisoned arrows, she's come to capture slaves.";
				initStrTouSpeInte(90, 150, 195, 110);
				initWisLibSensCor(110, 70, 80, 90);
				this.armorDef = 16;
				this.armorMDef = 16;
				this.weaponAttack = 11;
				this.weaponRangeAttack = 50;
				this.bonusLust = 197;
				this.level = 47;
				this.gems = rand(15) + 50;
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 13) {
				this.short = "light elf sniper";
				this.long = "This woman with light skin has long pointed ears. You suspect her to be a light elf, though why she’s here, you have no idea. Regardless, she’s dangerous and seems well equipped for kidnapping.";
				initStrTouSpeInte(120, 220, 295, 160);
				initWisLibSensCor(160, 80, 90, 95);
				this.armorDef = 16;
				this.armorMDef = 16;
				this.weaponAttack = 15;
				this.weaponRangeAttack = 86;
				this.bonusLust = 233;
				this.level = 63;
				this.gems = rand(15) + 100;
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			}
			this.a = "the ";
			this.imageName = "light elf";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 5, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("GG"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = 72;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.ELF;
			this.bodyColor = "light";
			this.hairColor = "blond";
			this.hairLength = 13;
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.armorName = "elven armor";
			this.lustVuln = .7;
			this.lust = 50;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: LightElfBowShooting, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON]},
				{ call: AnkleShot, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: function():Boolean{return!player.hasStatusEffect(StatusEffects.Sealed2)}},
				{ call: WingClip, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: function():Boolean{return player.isFlying()}, weight: Infinity}
			];
			checkMonster();
		}
	}
}
