/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Scenes.SceneLib;
import classes.internals.*;

import coc.view.CoCButton;

public class WoodElvesHuntingParty extends Monster
	{
		override public function defeated(hpVictory:Boolean):void
		{
			woodElfWeaponRestoreAtCombatEnd();
			SceneLib.woodElves.ElfFightWin();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			woodElfWeaponRestoreAtCombatEnd();
			SceneLib.woodElves.ElfFightLoose();
		}

		public function woodElfWeaponRestoreAtCombatEnd():void{
			if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0){
				outputText("Now that the fight's over, you go and retrieve your melee weapon from the ground where they knocked it out your hands.\n");
				player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
			}
			if(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0){
				outputText("Now that the fight's over, you go and retrieve your ranged weapon from the ground where they knocked it out your hands.\n");
				player.setWeaponRange(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID]) as WeaponRange);
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = 0;
			}
		}

		public function WoodElfsGroupAttack():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("You get randomly struck from every side as spears strike out from various angles all around you, the elves using their inborn ability to deliver quick blows before retreating back just out of reach.");
			WoodElfSpearStab();
			WoodElfSpearStab();
			WoodElfSpearStab();
			WoodElfSpearStab();
			if (rand(100) < (95 + Acc)) WoodElfSpearStab();
			if (rand(100) < (90 + Acc)) WoodElfSpearStab();
			if (rand(100) < (85 + Acc)) WoodElfSpearStab();
			if (rand(100) < (80 + Acc)) WoodElfSpearStab();
			outputText("\n\n");
		}
		
		public function WoodElfSpearStab():void
		{
			var damage:Number = 0;
			damage += eBaseSpeedDamage() * 0.25;
			damage += eBaseStrengthDamage() * 0.1;
			if (damage < 10) damage = 10;
			if (this.weaponAttack < 51) damage *= (1 + (this.weaponAttack * 0.03));
			else if (this.weaponAttack >= 51 && this.weaponAttack < 101) damage *= (2.5 + ((this.weaponAttack - 50) * 0.025));
			else if (this.weaponAttack >= 101 && this.weaponAttack < 151) damage *= (3.75 + ((this.weaponAttack - 100) * 0.02));
			else if (this.weaponAttack >= 151 && this.weaponAttack < 201) damage *= (4.75 + ((this.weaponAttack - 150) * 0.015));
			else damage *= (5.5 + ((this.weaponAttack - 200) * 0.01));
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
		}
		
		public function PinDown():void
		{
			outputText("While you have your back turned one of the archers aims for your foot and pins you to the ground! Now using the advantage of range against you it will be very difficult to catch up to them long enough to deliver a melee blow!");
			player.createStatusEffect(StatusEffects.Sealed2, 4, 0, 0, 0);
		}
		
		public function GroupTease():void
		{
			outputText("The elves aren't just fighting, each and every movement of these graceful warriors is like a well refined pole dance giving you a playful glimpse of their privates. Through the motion of their clothes they manage to both entice your lust and vex your effort at fighting, making a complete sexy show of their combat performance. ");
			outputText("While you're distracted, out of nowhere one closes the gap forcing you to block her strike. Using your confusion as an opportunity she crosses the distance between your weapon in a flash and delivers a surprise kiss before leaping back out of striking range.\n\n");
			outputText("\"<i>Aw why all the violence when we could be having so much fun right now? Why don't you drop your weapon already so we can get to the nice and cuddly part?~♥</i>\"\n\n");
			outputText("The elves giggle at this suggestion which only adds to both the humiliation and your arousal.");
			player.takeLustDamage(40 + rand(20), true);
		}
		
		public function Disarm():void
		{
			outputText("A random bow shot hits your weapon's hand forcing you to drop it. <b>You are disarmed from your ");
			if (player.weapon.canUnequip(false)) {
				outputText("melee weapon!</b>");
				if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) {
					outputText(" \"<i>Woah who are you blond bimbos to dare remove <b>ME</b>?</i>\" <b>You Aether Twin melee weapon returned to your hand!</b>");
				}
				else {
					flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
					player.unequipWeapon(false);
				}
			}
			else {
				outputText("range weapon!</b>");
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = player.weaponRange.id;
				player.unequipWeaponRange(false);
			}
		}
		public function pickUpMelee():void
		{
			clearOutput();
			outputText("You reach for and pick up your "+player.weaponName+" from the ground.");
			player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
			EngineCore.doNext(SceneLib.combat.combatMenu);
			EngineCore.statScreenRefresh();
            SceneLib.combat.enemyAIImpl();
        }
		public function pickUpRange():void
		{
			clearOutput();
			outputText("You reach for and pick up your "+player.weaponRangeName+" from the ground.");
			player.setWeaponRange(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID]) as WeaponRange);
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = 0;
			EngineCore.doNext(SceneLib.combat.combatMenu);
			EngineCore.statScreenRefresh();
            SceneLib.combat.enemyAIImpl();
        }

		override public function postPlayerBusyBtnSpecial(btnSpecial1:CoCButton, btnSpecial2:CoCButton):void{
				if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0) btnSpecial1.show("Pick (M)", pickUpMelee, "Pick up your melee weapon.");
				if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0) btnSpecial2.show("Pick (R)", pickUpRange, "Pick up your range weapon.");
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
			var choice:Number = rand(4);
			if (choice == 0) {
				if (!player.hasStatusEffect(StatusEffects.Sealed2)) PinDown();
				else WoodElfsGroupAttack();
			}
			if (choice == 1) {
				if (player.weapon.canUnequip(false) || player.weaponRange.canUnequip(false)) Disarm();
				else WoodElfsGroupAttack();
			}
			if (choice == 2) WoodElfsGroupAttack();
			if (choice == 3) GroupTease();
		}
		
		public function WoodElvesHuntingParty()
		{
			this.a = "the ";
			this.short = "wood elf hunting party";
			this.imageName = "wood elf hunting party";
			this.long = "You are fighting a wood elf hunting party. The girls are all dressed up light and use bows or spears if they have a weapon at all. It'd be a good guess to think they intend to tease you into submission rather than beat you into it seeing as they hardly seem to take the battle all that seriously.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("II"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.plural = true;
			this.tallness = 72;
			this.hips.type = Hips.RATING_AMPLE + 1;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.ELF;
			this.bodyColor = "light";
			this.hairColor = "blonde";
			this.hairLength = 13;
			initStrTouSpeInte(50, 50, 180, 40);
			initWisLibSensCor(40, 130, 170, 100);
			this.weaponName = "spear";
			this.weaponVerb= "stab";
			this.weaponAttack = 45;
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 54;
			this.armorName = "elven armor";
			this.armorDef = 12;
			this.armorMDef = 12;
			this.bonusLust = 323;
			this.lustVuln = .7;
			this.lust = 50;
			this.level = 23;
			this.gems = rand(10) + 10;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(weapons.SPEAR,1).
					add(consumables.ELFEARS, 4);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
