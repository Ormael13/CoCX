/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.HiddenCave 
{

	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class LoliBatGolem extends Monster
	{
		public function clawstrike():void {
			outputText("The golem's visage twists into a grimace of irritation, and she thrust her hand at you in a vicious strike.");
			var damage:Number = int ((str + spe + weaponAttack) - rand(player.tou) - player.armorDef);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise thrust!");
			else
			{
				outputText(" It strikes you in the chest. ");
				damage = player.takeDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(2);
			if (choice == 0) eAttack();
			if (choice == 1) clawstrike();
			combatRoundOver();
		}
		
	//	override public function defeated(hpVictory:Boolean):void
	//	{
	//		game.dungeons.hiddencave.cumWitchDefeated();
	//	}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.dungeons.hiddencave.defeatedByLoliBatGolem();
		}
		
		public function LoliBatGolem() 
		{
			this.a = "the ";
			this.short = "loli bat golem";
			this.imageName = "loli bat golem";
			this.long = "You're currently fighting loli bat golem. It's four feet tall bat that looks like twelves years old girl, her stone body is smooth and polished and she's using bare stone claws to fight. In the middle of her forehead there is tatto'd a big letter A.";
			this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_NORMAL, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 100, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("A"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,100,0,0,0);
			initStrTouSpeInte(30, 30, 50, 10);
			initLibSensCor(10, 10, 50);
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "light grey";
			this.lustVuln = .2;
			this.tallness = 48;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1);
			this.level = 8;
			this.bonusHP = 100;
			this.weaponName = "stone claws";
			this.weaponVerb = "claw";
			this.weaponAttack = 20 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "polished stone";
			this.armorDef = 26 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 260;
			checkMonster();
		}
		
	}

}