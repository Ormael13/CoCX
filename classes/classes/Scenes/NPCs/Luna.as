/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.Scenes.SceneLib;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;
	
	use namespace CoC;
	
	public class Luna extends Monster
	{
		public var lunaScene:LunaFollower = SceneLib.lunaFollower;
		
		public function usingClawCombo():void {
			outputText("Luna attempts to rend you with her claws.\n");
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			if (flags[kFLAGS.LUNA_LVL_UP] >= 4) eAttack();
			if (flags[kFLAGS.LUNA_LVL_UP] >= 8) eAttack();
			if (flags[kFLAGS.LUNA_LVL_UP] >= 12) eAttack();
		}
		
		public function usingPounce():void {
			outputText("Luna pounces on you, pinning you to the ground as she gets in position, claws at the ready.");
			player.createStatusEffect(StatusEffects.WolfHold,0,0,0,0);
			if (player.hasPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				if (flags[kFLAGS.LUNA_LVL_UP] >= 15) player.takePhysDamage(18+rand(35));
				else if (flags[kFLAGS.LUNA_LVL_UP] >= 12) player.takePhysDamage(16+rand(30));
				else if (flags[kFLAGS.LUNA_LVL_UP] >= 9) player.takePhysDamage(14+rand(25));
				else if (flags[kFLAGS.LUNA_LVL_UP] >= 6) player.takePhysDamage(12+rand(20));
				else if (flags[kFLAGS.LUNA_LVL_UP] >= 3) player.takePhysDamage(10+rand(15));
				else player.takePhysDamage(8+rand(10));
			}
		}
		
		public function usingRavage():void {
			outputText("Luna rends you with her claws.");
			var RavageDmg:Number = eBaseStrengthDamage();
			if (flags[kFLAGS.LUNA_LVL_UP] >= 3) RavageDmg += eBaseStrengthDamage() * 0.2;
			if (flags[kFLAGS.LUNA_LVL_UP] >= 6) RavageDmg += eBaseStrengthDamage() * 0.3;
			if (flags[kFLAGS.LUNA_LVL_UP] >= 9) RavageDmg += eBaseStrengthDamage() * 0.4;
			if (flags[kFLAGS.LUNA_LVL_UP] >= 12) RavageDmg += eBaseStrengthDamage() * 0.5;
			if (flags[kFLAGS.LUNA_LVL_UP] >= 15) RavageDmg += eBaseStrengthDamage() * 0.6;
			RavageDmg = Math.round(RavageDmg);
			player.takePhysDamage(RavageDmg);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if(player.hasStatusEffect(StatusEffects.LunaMoonAttack)){
				player.removeStatusEffect(StatusEffects.LunaMoonAttack);
			}
			if (flags[kFLAGS.LUNA_FOLLOWER] > 10) SceneLib.lunaFollower.sparLunaWon();
			else SceneLib.lunaFollower.fullMoonEventResistWin();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.LUNA_FOLLOWER] > 10){
				if(player.hasStatusEffect(StatusEffects.LunaMoonAttack)){
					player.removeStatusEffect(StatusEffects.LunaMoonAttack);
					SceneLib.lunaFollower.MooningLunaLost();
				}
				else SceneLib.lunaFollower.sparLunaLost();
			}
			else SceneLib.lunaFollower.fullMoonEventResistDefeat();
		}
		
		public function Luna() 
		{
			if (flags[kFLAGS.LUNA_LVL_UP] == 0) {
				initStrTouSpeInte(30, 100, 40, 50);
				initWisLibSensCor(50, 80, 40, 75);
				this.weaponAttack = 36;
				this.armorDef = 200;
				this.armorMDef = 5;
				this.bonusHP = 800;
				this.bonusLust = 129;
				this.level = 9;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 1) {
				initStrTouSpeInte(37, 120, 47, 52);
				initWisLibSensCor(52, 90, 50, 75);
				this.weaponAttack = 38;
				this.armorDef = 210;
				this.armorMDef = 6;
				this.bonusHP = 850;
				this.bonusLust = 155;
				this.level = 15;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 2) {
				initStrTouSpeInte(44, 140, 54, 54);
				initWisLibSensCor(54, 100, 60, 75);
				this.weaponAttack = 40;
				this.armorDef = 220;
				this.armorMDef = 7;
				this.bonusHP = 900;
				this.bonusLust = 181;
				this.level = 21;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 3) {
				initStrTouSpeInte(51, 160, 61, 56);
				initWisLibSensCor(56, 110, 70, 75);
				this.weaponAttack = 42;
				this.armorDef = 230;
				this.armorMDef = 8;
				this.bonusHP = 950;
				this.bonusLust = 207;
				this.level = 27;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 4) {
				initStrTouSpeInte(58, 180, 68, 58);
				initWisLibSensCor(58, 120, 80, 75);
				this.weaponAttack = 44;
				this.armorDef = 240;
				this.armorMDef = 9;
				this.bonusHP = 1000;
				this.bonusLust = 233;
				this.level = 33;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 5) {
				initStrTouSpeInte(65, 200, 75, 60);
				initWisLibSensCor(60, 130, 90, 75);
				this.weaponAttack = 46;
				this.armorDef = 250;
				this.armorMDef = 10;
				this.bonusHP = 1050;
				this.bonusLust = 259;
				this.level = 39;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 6) {
				initStrTouSpeInte(72, 220, 82, 62);
				initWisLibSensCor(62, 140, 100, 75);
				this.weaponAttack = 48;
				this.armorDef = 260;
				this.armorMDef = 11;
				this.bonusHP = 1100;
				this.bonusLust = 285;
				this.level = 45;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 7) {
				initStrTouSpeInte(79, 240, 89, 64);
				initWisLibSensCor(64, 150, 110, 75);
				this.weaponAttack = 50;
				this.armorDef = 270;
				this.armorMDef = 12;
				this.bonusHP = 1150;
				this.bonusLust = 311;
				this.level = 51;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 8) {
				initStrTouSpeInte(86, 260, 96, 66);
				initWisLibSensCor(66, 160, 120, 75);
				this.weaponAttack = 52;
				this.armorDef = 280;
				this.armorMDef = 13;
				this.bonusHP = 1200;
				this.bonusLust = 337;
				this.level = 57;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 9) {
				initStrTouSpeInte(93, 280, 103, 68);
				initWisLibSensCor(68, 170, 130, 75);
				this.weaponAttack = 54;
				this.armorDef = 290;
				this.armorMDef = 14;
				this.bonusHP = 1250;
				this.bonusLust = 363;
				this.level = 63;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 10) {
				initStrTouSpeInte(100, 300, 110, 70);
				initWisLibSensCor(70, 180, 140, 75);
				this.weaponAttack = 56;
				this.armorDef = 300;
				this.armorMDef = 15;
				this.bonusHP = 1300;
				this.bonusLust = 389;
				this.level = 69;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 11) {
				initStrTouSpeInte(107, 320, 117, 72);
				initWisLibSensCor(72, 190, 150, 75);
				this.weaponAttack = 58;
				this.armorDef = 310;
				this.armorMDef = 16;
				this.bonusHP = 1400;
				this.bonusLust = 415;
				this.level = 75;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 12) {
				initStrTouSpeInte(114, 340, 124, 74);
				initWisLibSensCor(74, 200, 160, 75);
				this.weaponAttack = 60;
				this.armorDef = 320;
				this.armorMDef = 17;
				this.bonusHP = 1450;
				this.bonusLust = 441;
				this.level = 81;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 13) {
				initStrTouSpeInte(121, 360, 131, 76);
				initWisLibSensCor(76, 210, 170, 75);
				this.weaponAttack = 62;
				this.armorDef = 330;
				this.armorMDef = 18;
				this.bonusHP = 1500;
				this.bonusLust = 467;
				this.level = 87;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 14) {
				initStrTouSpeInte(128, 380, 138, 78);
				initWisLibSensCor(78, 220, 180, 75);
				this.weaponAttack = 64;
				this.armorDef = 340;
				this.armorMDef = 19;
				this.bonusHP = 1550;
				this.bonusLust = 493;
				this.level = 93;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 15) {
				initStrTouSpeInte(135, 400, 145, 80);
				initWisLibSensCor(80, 230, 190, 75);
				this.weaponAttack = 66;
				this.armorDef = 350;
				this.armorMDef = 20;
				this.bonusHP = 1600;
				this.bonusLust = 519;
				this.level = 99;
			}//level up giving 2x all growns and so follow next level ups's as long each npc break lvl 100 (also makes npc use new better gear)
			this.a = "";
			this.short = "Luna";
			this.imageName = "luna";
			this.long = "Luna is a werewolf, a shapeshifting hybrid between animal-morph and human capable of altering her form at will. Right now she looks more like a feral beast than the refined maid you are used to. The lust crazed she-wolf circles you as she looks for an opportunity to strike.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 6*12+6;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.skin.growFur({color:"ashen"});
			this.hairColor = "ashen";
			this.hairLength = 8;
			this.weaponName = "paws";
			this.weaponVerb="paw-slash";
			this.armorName = "fur";
			this.lust = 10;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.gems = 5 + rand(5);
			this.drop = NO_DROP;
			this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 1) this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 2) this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 3) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 4) this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 5) this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 6) this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 7) this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 8) this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 9) this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 10) this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 11) this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 12) this.createPerk(PerkLib.GreaterDiehard, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 13) this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 14) this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.LUNA_LVL_UP] >= 15) this.createPerk(PerkLib.MythicalToughness, 0, 0, 0, 0);
			this.abilities = [
				{call: usingRavage, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY], weight:2 },
				{call: usingClawCombo, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{call: usingPounce, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY], condition: function():Boolean { return !player.hasStatusEffect(StatusEffects.WolfHold) } },
				{call: usingRavage, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY], condition: function():Boolean { return player.hasStatusEffect(StatusEffects.WolfHold) }, weight:Infinity },
			];
			checkMonster();
		}
		
	}

}