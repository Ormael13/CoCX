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
				var takeD:Number;
				if (flags[kFLAGS.LUNA_LVL_UP] >= 15) takeD = 18+rand(35);
				else if (flags[kFLAGS.LUNA_LVL_UP] >= 12) takeD = 16+rand(30);
				else if (flags[kFLAGS.LUNA_LVL_UP] >= 9) takeD = 14+rand(25);
				else if (flags[kFLAGS.LUNA_LVL_UP] >= 6) takeD = 12+rand(20);
				else if (flags[kFLAGS.LUNA_LVL_UP] >= 3) takeD = 10+rand(15);
				else takeD = 8 + rand(10);
				player.takePhysDamage(takeD, true);
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
			player.takePhysDamage(RavageDmg, true);
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
				initWisLibSensCor(50, 80, 40, 50);
				this.weaponAttack = 36;
				this.armorDef = 200;
				this.armorMDef = 5;
				this.bonusHP = 800;
				this.bonusLust = 129;
				this.level = 9;
			}
			else if (flags[kFLAGS.LUNA_LVL_UP] == 15) {
				initStrTouSpeInte(135, 400, 145, 80);
				initWisLibSensCor(80, 230, 190, 50);
				this.weaponAttack = 66;
				this.armorDef = 350;
				this.armorMDef = 20;
				this.bonusHP = 1600;
				this.bonusLust = 519;
				this.level = 99;
			}
			else {  //leave min and max levels to easily balance npc combat
				var lvlMulti:Number = flags[kFLAGS.LUNA_LVL_UP];
				initStrTouSpeInte(30 + 7*lvlMulti, 100 + 20*lvlMulti, 40 + 7*lvlMulti, 50 + 2*lvlMulti);
				initWisLibSensCor(50 + 2*lvlMulti, 80 + 10*lvlMulti, 40+10*lvlMulti, 50);
				this.weaponAttack = 36 + 2*lvlMulti;
				this.armorDef = 200 + 10*lvlMulti;
				this.armorMDef = 5 + lvlMulti;
				this.bonusHP = 800 + 50*lvlMulti;
				this.bonusLust = 129 + 26*lvlMulti;
				this.level = 9 + 6*lvlMulti;
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
			this.lustVuln = 0.01;
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