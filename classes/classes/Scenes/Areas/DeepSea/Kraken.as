/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DeepSea 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.internals.*;

public class Kraken extends Monster
	{
		public function krakenConstrict():void {
			outputText("The " + this.short + "’s tentacles grab you all at once and start to squeeze you!");
			player.createStatusEffect(StatusEffects.ScyllaBind,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takePhysDamage(4+rand(6));
			}
		}
		
		public function krakenInkSpray():void {
			clearOutput();
			outputText("The kraken stretches all her tentacles apart revealing a huge gaping pussy at the center which spray a cloud of ink all around you impairing your vision. ");
			if (!player.hasPerk(PerkLib.BlindImmunity)) player.createStatusEffect(StatusEffects.Blind, 3, 0, 0, 0);
		}
		
		public function krakenTentacleSlap():void {
			clearOutput();
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 2;
			outputText("The kraken slaps you with her tentacles, dealing ");
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			outputText(" damage!");
		}
		public function krakenTentacleSlap2():void {
			clearOutput();
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 2;
			outputText("The kraken slaps you with her tentacles, dealing ");
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
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
		}
		
		public function Kraken() 
		{
			this.a = "";
			this.short = "Kraken";
			this.imageName = "kraken";
			this.long = "You are currently fighting 24 feet tall Kraken.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 300, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 24*12;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.lowerBody = LowerBody.SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(700, 400, 400, 250);
			initWisLibSensCor(250, 300, 250, 50);
			this.weaponName = "large tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 145;
			this.armorName = "super thick skin";
			this.armorDef = 190;
			this.armorMDef = 95;
			this.bonusHP = 10000;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 100;
			this.gems = 0;
			this.drop = NO_DROP;
			//this.drop = new WeightedDrop(consumables.SPPEARL, 1);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}