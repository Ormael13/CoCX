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
			outputText("Luna attempts to rend you with her claws.");
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
		}
		
		public function usingPounce():void {
			outputText("Luna pounces on you, pinning you to the ground as she gets in position, claws at the ready.");
			player.createStatusEffect(StatusEffects.WolfHold,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takePhysDamage(8+rand(10));
			}
		}
		
		public function usingRavage():void {
			outputText("Luna rends you with her claws.");
			eBaseStrengthDamage();
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(5);
			if (choice < 3) usingClawCombo();
			if (choice == 3) {
				if (!player.hasStatusEffect(StatusEffects.WolfHold) && rand(2) == 0) usingPounce();
				else usingRavage();
			}
			if (choice == 4) usingRavage();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.LUNA_FOLLOWER] > 10) SceneLib.lunaFollower.sparLunaWon();
			else SceneLib.lunaFollower.fullMoonEventResistWin();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.LUNA_FOLLOWER] > 10) SceneLib.lunaFollower.sparLunaLost();
			else SceneLib.lunaFollower.fullMoonEventResistDefeat();
		}
		
		public function Luna() 
		{
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
			if (flags[kFLAGS.LUNA_LVL_UP] == 0) {
				initStrTouSpeInte(30, 90, 40, 50);
				initWisLibSensCor(50, 80, 40, 75);
				this.weaponAttack = 37;
				this.armorDef = 200;
				this.bonusHP = 800;
				this.level = 9;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 1) {
				initStrTouSpeInte(30, 95, 45, 50);
				initWisLibSensCor(50, 80, 40, 75);
				this.weaponAttack = 37;
				this.armorDef = 200;
				this.bonusHP = 800;
				this.level = 15;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 2) {
				initStrTouSpeInte(35, 100, 50, 50);
				initWisLibSensCor(50, 80, 40, 75);
				this.weaponAttack = 37;
				this.armorDef = 200;
				this.bonusHP = 850;
				this.level = 21;
			}
			if (flags[kFLAGS.LUNA_LVL_UP] == 3) {
				initStrTouSpeInte(35, 100, 55, 50);
				initWisLibSensCor(50, 80, 40, 75);
				this.weaponAttack = 37;
				this.armorDef = 200;
				this.bonusHP = 900;
				this.level = 27;
			}
			this.weaponName = "paws";
			this.weaponVerb="paw-slash";
			this.armorName = "fur";
			this.bonusLust = 10;
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
			checkMonster();
		}
		
	}

}