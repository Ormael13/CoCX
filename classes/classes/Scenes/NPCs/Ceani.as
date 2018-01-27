/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponLib;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Ceani extends Monster
	{
		public function moveBleedingBite():void {
			outputText("Ceani lunges in for a bite tearing a fair chunk out of you and you begin bleeding. ");
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += rand(this.str);
			player.takePhysDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.IzmaBleed)) player.addStatusValue(StatusEffects.IzmaBleed,1,3);
			else player.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
		}
		
		public function moveHarpoonDancing():void {
			outputText("Ceani whirls her harpoon around, striking with both ends of the weapon with calculated and devastating strikes.\n\n");
			outputText("Ceani slashes you for ");
			moveHarpoonDancingDamage();
			outputText(" damage.\n\nCeani impales you for");
			moveHarpoonDancingDamage();
			outputText(" damage.\n\nCeani slams her weapon down onto you for");
			moveHarpoonDancingDamage();
			outputText(" damage.");
		}
		public function moveHarpoonDancingDamage():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 0.5;
			damage += rand(this.str);
			player.takePhysDamage(damage, true);
		}
		
		public function moveTailSlam():void {
			outputText("Ceani’s tail sends you flying to the other edge of the ring. ");
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += rand(this.str);
			player.takePhysDamage(damage, true);
			if (!player.hasPerk(PerkLib.Resolute)) {
				outputText(" <b>You are stunned and disarmed by the impact!</b>");
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
				player.setWeapon(WeaponLib.FISTS);
				player.createStatusEffect(StatusEffects.Disarmed, 2, 0, 0, 0);
				player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
			createStatusEffect(StatusEffects.AbilityCooldown1, 6, 0, 0, 0);
		}
		
		public function moveTremor():void {
			outputText("Ceani slam her foot in the ground causing it to shake under your feet. You lose your footing and land on your back.");
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		
		public function moveAwesomeBlow():void {
			outputText("Ceani grabs her harpoon with both hands and slams it on you in an attempt to hammer you into the ground like a nail. You manage to block the weapon but the titanic impact sends you reeling in pain. ");
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 0.6;
			damage += rand(this.str);
			player.takePhysDamage(damage, true);
			outputText(" damage.");
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		
		override protected function performCombatAction():void
		{
			var size:Number = 0;
			if (player.tallness >= 120) size += 3;
			else if (player.tallness >= 108) size += 4;
			else if (player.tallness < 108) size += 5;
			var choice:Number = rand(size);
			if (choice == 0) moveHarpoonDancingDamage();
			if (choice == 1) moveBleedingBite();
			if (choice == 2) {
				if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) moveTailSlam();
				else moveHarpoonDancingDamage();
			}
			if (choice == 3) moveTremor();
			if (choice == 4) moveAwesomeBlow();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.ceaniScene.sparringWithCeaniWon();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.ceaniScene.sparringWithCeaniLost();
		}
		
		public function Ceani() 
		{
			if (flags[kFLAGS.CEANI_LVL_UP] == 0) {
				this.level = 38;
				initStrTouSpeInte(150, 300, 170, 200);
				initWisLibSensCor(200, 200, 80, 50);
				this.weaponAttack = 16;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 1) {
				this.level = 46;
				initStrTouSpeInte(180, 300, 190, 200);
				initWisLibSensCor(200, 200, 80, 50);
				this.weaponAttack = 24;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 2) {
				this.level = 54;
				initStrTouSpeInte(210, 300, 210, 200);
				initWisLibSensCor(200, 200, 80, 50);
				this.weaponAttack = 32;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 3) {
				this.level = 62;
				initStrTouSpeInte(240, 300, 230, 200);
				initWisLibSensCor(200, 200, 80, 50);
				this.weaponAttack = 40;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 4) {
				this.level = 70;
				initStrTouSpeInte(270, 300, 250, 200);
				initWisLibSensCor(200, 200, 80, 50);
				this.weaponAttack = 48;
			}
			if (flags[kFLAGS.CEANI_LVL_UP] == 5) {
				this.level = 76;
				initStrTouSpeInte(300, 320, 270, 210);
				initWisLibSensCor(210, 210, 80, 50);
				this.weaponAttack = 56;
			}
			this.a = "";
			this.short = "Ceani";
			this.long = "You are sparing with Ceani the orca morph. While she is normally smiling all the time this time around she looks like an angry beast about to tear you to shreds. You realise only now how scary her sharp teeth are let alone that massive harpoon she wields. Both strong and swift, she easily proves that underneath her friendly, and at time goofy, demeanor she still is a deadly fighter most people on mareth would rather avoid the wrath of.";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("JJ"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 132;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "black with a white underside";
			this.hairColor = "blue";
			this.hairLength = 13;
			this.weaponName = "harpoon";
			this.weaponVerb="piercing stab";
			this.armorName = "pink bikini";
			this.armorDef = 25;
			this.bonusHP = 2000;
			this.bonusLust = 50;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 50;
			this.drop = new ChainedDrop().
				//	add(armors.INDESSR,1/10).
				//	add(consumables.L_DRAFT,1/4).
					add(consumables.ORCASUN,0.7);
			this.rearBody.type = RearBody.ORCA_BLOWHOLE;
			this.arms.type = Arms.ORCA;
			this.lowerBody = LowerBody.ORCA;
			this.tailType = Tail.ORCA;
			this.tailRecharge = 0;
			//if (flags[kFLAGS.ETNA_FOLLOWER] > 1 || flags[kFLAGS.ETNA_TALKED_ABOUT_HER] > 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			//this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}