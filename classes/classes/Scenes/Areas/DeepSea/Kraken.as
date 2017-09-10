/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DeepSea 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class Kraken extends Monster
	{
		public function krakenConstrict():void {
			outputText("The " + this.short + "’s tentacles grab you all at once and start to squeeze you!");
			player.createStatusEffect(StatusEffects.ScyllaBind,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takeDamage(4+rand(6));
			}
		}
		
		public function krakenInkSpray():void {
			clearOutput();
			outputText("The kraken stretches all her tentacles apart revealing a huge gaping pussy at the center which spray a cloud of ink all around you impairing your vision. ");
			player.createStatusEffect(StatusEffects.Blind, 3, 0, 0, 0);
		}
		
		public function krakenTentacleSlap():void {
			clearOutput();
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 2;
			outputText("The scylla slaps you with her tentacles, dealing ");
			player.takeDamage(damage, true);
			player.takeDamage(damage, true);
			player.takeDamage(damage, true);
			player.takeDamage(damage, true);
			player.takeDamage(damage, true);
			player.takeDamage(damage, true);
			outputText(" damage!");
		}
		public function krakenTentacleSlap2():void {
			clearOutput();
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 2;
			outputText("The scylla slaps you with her tentacles, dealing ");
			player.takeDamage(damage, true);
			player.takeDamage(damage, true);
			outputText(" damage!");
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(6);
			if (choice < 3) {
				if (player.hasStatusEffect(StatusEffects.ScyllaBind)) krakenTentacleSlap2();
				else krakenTentacleSlap();
			}
			if (choice == 3 || choice == 4) {
				if (player.hasStatusEffect(StatusEffects.ScyllaBind)) krakenTentacleSlap2();
				else krakenConstrict();
			}
			if (choice == 5) {
				if (player.hasStatusEffect(StatusEffects.Blind) || player.hasStatusEffect(StatusEffects.ScyllaBind)) {
					if (player.hasStatusEffect(StatusEffects.ScyllaBind)) krakenTentacleSlap2();
					else krakenTentacleSlap();
				}
				else krakenInkSpray();
			}
			combatRoundOver();
		}
		
		public function Kraken() 
		{
			this.a = "";
			this.short = "Kraken";
			this.imageName = "kraken";
			this.long = "You are currently fighting 24 feet tall Kraken.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 300, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 24*12;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.lowerBody = LOWER_BODY_TYPE_SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(700, 200, 200, 250);
			initLibSensCor(200, 50, 50);
			this.weaponName = "large tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 145 + (30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "super thick skin";
			this.armorDef = 95 + (10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 10000;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 100;
			this.gems = 0;
			this.drop = new WeightedDrop(consumables.SPPEARL, 1);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			this.str += 350 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 100 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 100 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 125 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 100 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 85250;
			checkMonster();
		}
		
	}

}