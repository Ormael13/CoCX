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
			outputText("The black skinned elf aims her crossbow at you, drawing several bolts and starts shooting.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("A bolt missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();
			else outputText("A bolt missed you.\n\n");
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 1) {
				if (rand(100) < (70 + Acc)) PoisonedBowShoot();
				else outputText("A bolt missed you.\n\n");
			}
			//if (rand(100) < (60 + Acc)) PoisonedBowShoot();//Dark Elf Ranger
			//else outputText("A bolt missed you.\n\n");
			//if (rand(100) < (50 + Acc)) PoisonedBowShoot();//Dark Elf Sniper
			//else outputText("A bolt missed you.\n\n");
		}
		
		public function PoisonedBowShoot():void
		{
			if (CombatAbilities.EAspectAir.isActive()) {
				outputText("A bolt hits the wind wall dealing no damage to you.\n\n");
				CombatAbilities.EAspectAir.advance(true);
			}
			else {
				var damage:Number = 0;
				damage += eBaseSpeedDamage() * 0.4;
				if (damage < 20) damage = 20;
				if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
				else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
				else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
				else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
				else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
				damage = Math.round(damage);
				outputText("A bolt hits you for ");
				player.takePhysDamage(damage, true);
				outputText(" damage. It was poisoned! You feel your strength failing you!\n\n");
				player.addCombatBuff('spe', -6, "Poisoned Arrow", "PoisonedArrow");
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
				outputText("A bolt hits wind wall dealing no damage to you.\n\n");
				CombatAbilities.EAspectAir.advance(true);
			}
			else {
				outputText("The dark elf smirks wickedly before shooting a bolt straight into your "+(player.hasPerk(PerkLib.Icerunner)?"legs":"wing")+". You fall, unable to fly, and crash into the ground. ");
				player.removeStatusEffect(StatusEffects.Flying);
				var damage:Number = eBaseSpeedDamage() * 6 + eBaseStrengthDamage() * 3;
				if (damage < 15) damage = 15;
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

		override public function preAttackSeal():Boolean
		{
			if (player.hasStatusEffect(StatusEffects.Sealed2) && player.statusEffectv2(StatusEffects.Sealed2) == 0) {
				outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Recent enemy attack have made normal melee attacks impossible!  Maybe you could try something else?\n\n");
				// enemyAI();
				return false;
			}
			else return true;
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
				if ((player.isFlying() || player.hasPerk(PerkLib.Icerunner)) && rand(4) == 0) WingClip();
				else DarkElfBowShooting();
			}
		}
		
		public function DarkElfs()
		{
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 0) {
				this.short = "dark elf scout";
				initStrTouSpeInte(240, 380, 520, 260);
				initWisLibSensCor(260, 160, 180, -100);
				this.weaponAttack = 25;
				this.weaponRangeAttack = 180;
				this.armorDef = 160;
				this.armorMDef = 160;
				this.bonusLust = 400;
				this.level = 60;
				this.gems = rand(10) + 25;
			}
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] == 1) {
				this.short = "dark elf slaver";
				initStrTouSpeInte(345, 500, 610, 370);
				initWisLibSensCor(370, 240, 280, -100);
				this.weaponAttack = 35;
				this.weaponRangeAttack = 270;
				this.armorDef = 200;
				this.armorMDef = 200;
				this.bonusLust = 600;
				this.level = 80;
				this.gems = rand(15) + 35;
			}
			this.a = "the ";
			this.imageName = "dark elf";
			this.long = "This woman with dark skin has long pointed ears. You suspect her to be a dark elf and fighting underground on her own turf you are almost worried more of her kind would join the battle. Regardless, she’s dangerous and seems well equipped.";
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
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponRangeName = "elven crossbow";
			this.weaponRangeVerb= "shoot";
			this.armorName = "elven armor";
			this.lustVuln = .7;
			this.lust = 50;
			this.drop = new WeightedDrop()
					.add(useables.EBONBLO,2)
					.add(weaponsrange.LCROSBW,3)
					.add(consumables.DELFEARS,5);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: DarkElfBowShooting, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON]},
				{ call: AnkleShot, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: function():Boolean{return !player.hasStatusEffect(StatusEffects.Sealed2)}},
				{ call: WingClip, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_WEAPON], condition: function():Boolean {return ((player.isFlying() || player.hasPerk(PerkLib.Icerunner)) && player.statusEffectv2(StatusEffects.Flying) == 0)}, weight: Infinity}
			];
			this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] >= 1) this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] >= 2) this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] >= 3) this.createPerk(PerkLib.MythicalSpeed, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
