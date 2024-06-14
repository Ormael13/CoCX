/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Charybdis extends Monster
	{
		private var coldFury:Number = 0;
		
		private function charybdisAttack1():void {
			var hits:Number = 1 + rand(8);
			if (hits > 1) outputText("The daggers gleams as they slices into your flesh.");
			else outputText("The dagger gleams as it slices into your flesh.");
			var hibD:Number = hits;
			while (hibD-->0) daggers();
			statScreenRefresh();
			outputText("\n");
		}
		private function charybdisAttack2():void {
			outputText("Cherybdis leans back, throwing six daggers at you! ");
			var hibD:Number = 6;
			while (hibD-->0) daggers();
			statScreenRefresh();
			outputText(" They reappear in his hands, and you look down at the floor. The daggers that had hit you are gone.\n");
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.IzmaBleed)) player.addStatusValue(StatusEffects.IzmaBleed, 1, 1);
				else player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
			}
		}
		private function daggers():void {
			var damage:Number = weaponAttack;
			damage += eBaseStrengthDamage();
			damage *= 2;
			var crit:Boolean = false;
			var critChance:int = 5;
			if (this.wis <= 200) critChance += this.wis / 10;
			if (this.wis > 200) critChance += 20;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			damage = Math.round(damage);
			damage = player.takePhysDamage(damage, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
		}
		
		public function charybdisConstrict():void {
			outputText("With a growl of effort, Charybdis launches himself into the air. ");
			if (player.getEvasionRoll()) outputText("You hit the ground hard, narrowly dodging as Charybdis flies past. You roll to your feet, turning around to face him. The Scylla’s eyes narrow, and he exhales deeply, splaying his knives for the next attack.");
			else {
				outputText("You try to dodge, but he grabs you with several of his tentacles. Wrapped around your arms, pinning your [weapon] to your side, all you can do is struggle and try to throw the pissed Scylla off you.");
				player.createStatusEffect(StatusEffects.ScyllaBind, 0, 0, 0, 0);
				if (!player.hasPerk(PerkLib.Juggernaut) && armorPerk != "Heavy") {
					player.takePhysDamage(4+rand(6));
				}
			}
		}
		
		private function charybdisRejuvenationRhythm():void {
			outputText("The instruments at his gills sound out, a brassy sound in time with the beleaguered Scylla’s heartbeat. You notice his wounds begin to close. ");
			var temp:Number = Math.round(maxHP() * 0.15);
			outputText("<b>([font-heal]+" + temp + "[/font])</b>");
			addHP(temp);
			var hpChange2:int = inte;
			createStatusEffect(StatusEffects.MonsterRegen2, 8, hpChange2, 0, 0);
			outputText("\n");
		}
		
		private function charybdisColdFury():void {
			if (HPRatio() < .2 && coldFury == 2) charybdisColdFury2();
			else if (HPRatio() < .4 && coldFury == 1) charybdisColdFury2();
			else if (HPRatio() < .7 && coldFury == 0) charybdisColdFury2();
		}
		private function charybdisColdFury2():void {
			outputText("Charybdis’s Violet eyes turn a bright crimson, and his usual grin or smirk gives way to a violent scowl.");
			lustVuln -= 0.05;
			var speSta:Number = speStat.core.value;
			speSta *= 1.25;
			speSta = Math.round(speSta);
			speStat.core.value += speSta;
			var weaponAtt:Number = weaponAttack;
			weaponAtt *= 1.25;
			weaponAtt = Math.round(weaponAtt);
			weaponAttack += weaponAtt;
			coldFury += 1;
		}
		
		override protected function performCombatAction():void
		{
			if (HPRatio() < .7 && coldFury < 3) charybdisColdFury();
			var choice:Number = rand(4);
			if (choice == 0) {
				if (player.hasStatusEffect(StatusEffects.ScyllaBind)) charybdisAttack2();
				else charybdisAttack1();
			}
			if (choice == 1) {
				if (HPRatio() < .8) charybdisRejuvenationRhythm();
				else {
					if (rand(2) == 0) charybdisAttack2();
					else charybdisAttack1();
				}
			}
			if (choice == 2) {
				if (rand(2) == 0) charybdisAttack2();
				else charybdisAttack1();
			}
			if (choice == 3) {
				if (player.hasStatusEffect(StatusEffects.ScyllaBind)) {
					if (rand(2) == 0) charybdisAttack2();
					else charybdisAttack1();
				}
				else charybdisConstrict();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.charybdisScene.charyWin();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.charybdisScene.charyLoss();
		}
		
		override public function get long():String
		{
			var str:String = "";
			if (this.HP >= this.maxHP() * 0.7) str += "Charybdis stands, bobbing to and fro on two tentacles. His purple eyes stare at you nervously, and his gills flare. Evidently this battle’s starting to anger the Scylla.";
			else if (this.HP >= this.maxHP() * 0.4) str += "Red eyes stare at you from inside slightly sunken sockets. The knives on his tentacles are levelled towards you, and his barrel chest heaves. Charybdis has almost completely stopped moving except to avoid a blow or deal one in turn. Be careful.";
			else str += "His body is slumping, but the glow in his red eyes have only intensified. His guard seems to have loosened, but his tendrils and arms have gotten noticeably faster. Keep on your guard.";
			return str;
		}
		
		public function Charybdis() 
		{
			this.a = "";
			this.short = "Charybdis";
			this.imageName = "kraken";
			this.long = "";
			// this.plural = false;
			this.createCock(13,2,CockTypesEnum.SCYLLATENTACLE);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 6;
			this.hoursSinceCum = 400;
			createBreastRow();
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 65;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.lowerBody = LowerBody.SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(300, 300, 400, 150);
			initWisLibSensCor(100, 300, 150, 50);
			this.weaponName = "large tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 160;
			this.armorName = "super thick skin";
			this.armorDef = 190;
			this.armorMDef = 380;
			this.bonusHP = 10000;
			this.bonusLust = 520;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 70;
			this.gems = 0;
			this.drop = new WeightedDrop(consumables.WHITEIN, 1);
			//this.drop = new WeightedDrop(consumables.SPPEARL, 1);
			//this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			//this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
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