/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Dinah extends Monster
	{
		public var spellCostArouse:int = 6;
		
		public function castArouseDinah():void {
			outputText("She makes a series of arcane gestures, drawing on her lust to inflict it upon you! ");
			var lustDamage:int = (inte / 5) + rand(10);
			lustDamage = lustDamage * (EngineCore.lustPercent() / 100);
			player.dynStats("lus", lustDamage, "scale", false);
			outputText(" <b>(<font color=\"#ff00ff\">" + (Math.round(lustDamage * 10) / 10) + "</font>)</b>");
			mana -= spellCostArouse;
		}
		
		public function hellcatFireballDinah():void
		{
			var damage:int = (inte * 1.1) + rand(25);
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			outputText("Dinah cast a spell, materializing a fireball before throwing it at you. " + damage + " fire damage!");
		}
		
		public function hellcatInfernalClawDinah():void
		{
			outputText("Dinah growls at you, unsheathing her claws which turns orange-red like hot irons as she enhances it with a dash of fire magic. She leaps forward and viciously attempts to rend you. ");
			var firedamage:int = (inte * 0.45) + rand(10);
			firedamage = Math.round(firedamage);
			player.takeFireDamage(firedamage, true);
			if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
			else player.createStatusEffect(StatusEffects.BurnDoT,3,0.05,0,0);
			var physdamage:Number = 0;
			physdamage += eBaseDamage();
			player.takePhysDamage(physdamage, true);
			if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
			else player.createStatusEffect(StatusEffects.Hemorrhage,3,0.05,0,0);
			outputText("" + physdamage + " physical damage, " + firedamage + " fire damage. Reeling in pain you begin to bleed and burn at the same time.");
		}
		
		public function hellcatFelineCurseDinah():void
		{
			outputText("Dinah incants a curse and you suddenly shrink in size. To your complete horror, you realize she polymorphed you into a small housecat!");
			player.createStatusEffect(StatusEffects.Polymorphed, 3, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 8, 0, 0, 0);
		}
		/*
		override protected function performCombatAction():void {
			var choice:Number = rand(5);
			switch (choice) {
				case 0:
				case 1:
					if ((mana - spellCostArouse) >= 0) castArouse();
					else eAttack();
					break;
				case 2:
					hellcatFireball();
					break;
				case 3:
					hellcatInfernalClaw();
					break;
				case 4:
					if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) hellcatFelineCurse();
					else eAttack();
					break;
				default:
					eAttack();
			}
		}
		*/
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.DINAH_LVL_UP] < 0.5) flags[kFLAGS.DINAH_DEFEATS_COUNTER]++;
			if (player.hasStatusEffect(StatusEffects.CampSparingDinah)) {
				player.removeStatusEffect(StatusEffects.CampSparingDinah);
				SceneLib.dinahScene.DinahLostSparring();
			}
			else {
				cleanupAfterCombat();
				SceneLib.dinahScene.DinahMainMenu();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.CampSparingDinah)) {
				player.removeStatusEffect(StatusEffects.CampSparingDinah);
				SceneLib.dinahScene.DinahWonSparring();
			}
			else {
				cleanupAfterCombat();
				SceneLib.dinahScene.DinahMainMenu();
			}
		}
		
		public function Dinah() 
		{
			if (flags[kFLAGS.DINAH_LVL_UP] < 1) {
				this.a = "the ";
				this.short = "cat";
				this.long = "You are fighting a cat-morph. She would looks quite averange if not for black stripes on purple fur.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
				this.tallness = 5*12+10;
				this.hairLength = 7;
				initStrTouSpeInte(20, 20, 20, 60);
				initWisLibSensCor(30, 20, 20, 50);
				this.weaponAttack = 5;
				this.armorDef = 3;
				this.armorMDef = 6;
				this.armorName = "fur";
				this.bonusHP = 30;
				this.bonusLust = 10;
				this.lustVuln = .9;
				this.level = 2;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 1) {
				this.a = "";
				this.short = "Dinah";
				this.long = "You are fighting Dinah. She's a cat chimera that mixes nearly all, if not all, cat races you could find in this demonic realm. Burning eyes like those of hellcats and fiery hair with colors like those of cheshire cats, parted by twin pair of small horns. Behind her slowly moves two blazing tails, and two long tentacles similar to that of a calamari. Her four arms completes her chimeric visage.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
				//createBreastRow(Appearance.breastCupInverse("A"));
				this.tallness = 7*12+8;
				this.hairLength = 21;//very long, flowing locks of - between shouled length and ass length
				this.armorName = "fur";
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 1) {
				initStrTouSpeInte(30, 25, 60, 80);
				initWisLibSensCor(40, 40, 30, 50);
				this.weaponAttack = 10;
				this.armorDef = 40;
				this.armorMDef = 30;
				this.bonusHP = 60;
				this.bonusMana = 50;
				this.bonusLust = 10;
				this.lustVuln = .9;
				this.level = 8;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 2) {
				initStrTouSpeInte(40, 30, 100, 100);
				initWisLibSensCor(50, 60, 40, 50);
				this.weaponAttack = 20;
				this.armorDef = 40;
				this.armorMDef = 30;
				this.bonusHP = 90;
				this.bonusMana = 100;
				this.bonusLust = 10;
				this.lustVuln = .9;
				this.level = 14;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 3) {
				initStrTouSpeInte(50, 35, 140, 120);
				initWisLibSensCor(60, 80, 50, 50);
				this.weaponAttack = 30;
				this.armorDef = 40;
				this.armorMDef = 30;
				this.bonusHP = 120;
				this.bonusMana = 150;
				this.bonusLust = 10;
				this.lustVuln = .9;
				this.level = 20;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 4) {
				initStrTouSpeInte(60, 40, 180, 140);
				initWisLibSensCor(70, 100, 60, 50);
				this.weaponAttack = 40;
				this.armorDef = 40;
				this.armorMDef = 30;
				this.bonusHP = 150;
				this.bonusMana = 150;
				this.bonusLust = 10;
				this.lustVuln = .9;
				this.level = 26;
			}
			createBreastRow(game.flags[kFLAGS.DINAH_CUP_SIZE]);
			this.hips.type = Hips.RATING_BOYISH+game.flags[kFLAGS.DINAH_HIPS_ASS_SIZE];
			this.butt.type = Butt.RATING_BUTTLESS+game.flags[kFLAGS.DINAH_HIPS_ASS_SIZE];
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.hairColor = "black and purple";
			this.weaponName = "claws";
			this.weaponVerb = "slash";
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 0;
			this.drop = NO_DROP;
			checkMonster();
		}
	}
}