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
import classes.internals.*;
import classes.Scenes.Combat.CombatAbilities;

public class DarkElfs extends Monster
	{
		public function DarkElfBowShooting():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("The black skinned elf aims her bow at you, drawing several arrows and starts shooting.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();//Dark Elf Scout
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (70 + Acc)) PoisonedBowShoot();//Dark Elf Slaver
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (60 + Acc)) PoisonedBowShoot();//Dark Elf Ranger
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (50 + Acc)) PoisonedBowShoot();//Dark Elf Sniper
			else outputText("An arrow missed you.\n\n");
		}
		
		public function PoisonedBowShoot():void
		{
			if (CombatAbilities.EAspectAir.isActive()) {
				outputText("An arrow hits the wind wall dealing no damage to you.\n\n");
				CombatAbilities.EAspectAir.advance(true);
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
			outputText("The dark skinned elf shoot you through the ankle and takes some distance. Crippled like you are, it will be annoying to catch her--if not impossible. Better use ranged attacks until you recover mobility.");
			player.createStatusEffect(StatusEffects.Sealed2, 4, 0, 0, 0);
		}
		
		public function WingClip():void
		{
			if (CombatAbilities.EAspectAir.isActive()) {
				outputText("An arrow hits wind wall dealing no damage to you.\n\n");
				CombatAbilities.EAspectAir.advance(true);
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
		
		public function DarkElfs()
		{
			this.a = "the ";
			this.short = "dark elf sniper";
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
			this.bodyColor = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(120, 190, 260, 130);
			initWisLibSensCor(130, 80, 90, 90);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5;
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 36;
			this.armorName = "elven armor";
			this.armorDef = 16;
			this.armorMDef = 16;
			this.bonusLust = 231;
			this.lustVuln = .7;
			this.lust = 50;
			this.level = 61;
			this.gems = rand(10) + 25;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: DarkElfBowShooting, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON]},
				{
					call: AnkleShot,
					type: ABILITY_PHYSICAL,
					range: RANGE_RANGED,
					tags:[TAG_WEAPON],
					condition: function():Boolean{
						return !player.hasStatusEffect(StatusEffects.Sealed2)
					}
				},
				{
					call: WingClip,
					type: ABILITY_PHYSICAL,
					range: RANGE_RANGED,
					tags:[TAG_WEAPON],
					condition: function():Boolean {
						return player.isFlying()
					},
					weight: Infinity
				}
			];
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			checkMonster();
		}

		override public function preAttackSeal():Boolean
		{
			if (player.hasStatusEffect(StatusEffects.Sealed2) && player.statusEffectv2(StatusEffects.Sealed2) == 0) {
				outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Recent enemy attack have made normal melee attacks impossible!  Maybe you could try something else?\n\n");
				// enemyAI();
				return false;
			}
			else return true;
		}
	}

}
/*
		{
			this.a = "the ";
			this.short = "dark elf slaver";
			this.imageName = "dark elf";
			this.long = "This lightly armored woman is a Dark elf. She's slender and elegant, with dark skin and long pointed ears. The look in her eyes, a mixture of bloodlust and greed, give her intentions away...as does her equipment. Ropes, poisoned arrows, she's come to the surface to capture slaves. You can hear faint voices from somewhere nearby. Has she already captured people today?";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.ELF;
			this.bodyColor = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(60, 80, 140, 70);
			initWisLibSensCor(70, 60, 70, 70);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5;
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 24;
			this.armorName = "elven armor";
			this.armorDef = 8;
			this.armorMDef = 8;
			this.bonusLust = 159;
			this.lustVuln = .7;
			this.lust = 50;
			this.level = 29;
			this.gems = rand(10) + 15;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: DarkElfBowShooting, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON]},
				{ call: AnkleShot, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: !player.hasStatusEffect(StatusEffects.Sealed2)},
				{ call: WingClip, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: player.isFlying(), weight: Infinity}
			];
			checkMonster();
		}
		
	}

}
*/
