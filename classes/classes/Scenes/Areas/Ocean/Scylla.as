/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class Scylla extends Monster
	{
		public function scyllaConstrict():void {
			outputText("The " + this.short + "’s tentacles grab you all at once and start to squeeze you!");
			player.createStatusEffect(StatusEffects.ScyllaBind,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takeDamage(4+rand(6));
			}
		}
		
		public function scyllaInkSpray():void {
			clearOutput();
			outputText("The scylla stretches all her tentacles apart revealing a huge gaping pussy at the center which spray a cloud of ink all around you impairing your vision. ");
			player.createStatusEffect(StatusEffects.Blind, 2, 0, 0, 0);
		}
		
		public function scyllaTentacleSlap():void {
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
		public function scyllaTentacleSlap2():void {
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
				if (player.hasStatusEffect(StatusEffects.ScyllaBind)) scyllaTentacleSlap2();
				else scyllaTentacleSlap();
			}
			if (choice == 3 || choice == 4) {
				if (player.hasStatusEffect(StatusEffects.ScyllaBind)) scyllaTentacleSlap2();
				else scyllaConstrict();
			}
			if (choice == 5) {
				if (player.hasStatusEffect(StatusEffects.Blind) || player.hasStatusEffect(StatusEffects.ScyllaBind)) {
					if (player.hasStatusEffect(StatusEffects.ScyllaBind)) scyllaTentacleSlap2();
					else scyllaTentacleSlap();
				}
				else scyllaInkSpray();
			}
			combatRoundOver();
		}
		
		public function Scylla() 
		{
			this.a = "the ";
			this.short = "scylla";
			this.imageName = "scylla";
			this.long = "You are currently fighting 10 feet tall scylla.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 10*12;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.lowerBody = LOWER_BODY_TYPE_SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(350, 100, 100, 150);
			initLibSensCor(100, 50, 50);
			this.weaponName = "tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 86 + (18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "thick skin";
			this.armorDef = 52 + (6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 5000;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 70;
			this.gems = 0;
			this.drop = new WeightedDrop(consumables.BLACKIN, 1);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.str += 140 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 26400;
			checkMonster();
		}
		
	}

}