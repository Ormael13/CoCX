/**
 * ...
 * @author Ormael & Pyromania
 */
package classes.Scenes.Dungeons.RiverDungeon
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class Vegot extends Monster
	{
		private function vegotBasicAttack():void {
			outputText("Vegot swings Frostlight ferociously, leaving you momentarily staggered from the slash of his icy blade. ");
			var dmg0:Number = 0;
			dmg0 += this.str;
			dmg0 += eBaseStrengthDamage();
			dmg0 += this.weaponAttack;
			dmg0 = Math.round(dmg0);
			player.takePhysDamage(dmg0, true);
			dmg0 += Math.round(this.inte * 1.5);
			dmg0 += Math.round(this.wis * 1.25);
			player.takeIceDamage(dmg0, true);
			player.buff("Frostlight Slow").addStats( {"spe":-10} ).withText("Frostlight Slow").combatPermanent();
			player.takeLightningDamage(dmg0, true);
			if (HP < maxOverHP()) {
				var temp1:Number = 0;
				temp1 += Math.round(dmg0 * 0.1);
				if (HP + temp1 > maxOverHP()) temp1 -= (this.maxOverHP() - HP);
				HP += temp1;
				outputText(" <b>([font-heal]+" + temp1 + "[/font])</b>");
			}
		}
		
		private function vegotQ():void {
			outputText("He gasps in pleasure as his body begins charging. Cackles of electricity arc around him before he discharges a bolt of blue electricity toward you. ");
			this.lust += Math.round(maxLust() * 0.02);
			var dmg1:Number = 0;
			dmg1 += eBaseIntelligenceDamage() * 0.8;
			player.takeLightningDamage(dmg1, true);
			player.takeLustDamage(3+(player.effectiveLibido()/10)+rand(6), true);
		}
		
		private function vegotW():void {
			if (hasStatusEffect(StatusEffects.lustStorm)) {
				outputText("The Raiju King continues building up the energy before he thrusts his hands forward, causing strikes of lightning to hit the ground around you! ");
				player.takeLightningDamage(vegotW1() * 3, true);
				player.takeLustDamage(vegotW2() * 3, true);
			}
			else {
				outputText("The Raiju King clenches his fists as electricity builds up within his body. Clouds begin forming from above, blocking out the ceiling, thunder rumbles. The storm encroaches! ");
				player.takeLightningDamage(vegotW1() * 2, true);
				player.takeLustDamage(vegotW2() * 2, true);
				createStatusEffect(StatusEffects.lustStorm, 0, 0, 0, 0);
			}
		}
		private function vegotW1():Number {
			var dmg2:Number = 0;
			dmg2 += Math.round(eBaseIntelligenceDamage() * 1.2);
			return dmg2;
		}
		private function vegotW2():Number {
			var lust0:Number = 0;
			lust0 += Math.round(1 + (player.effectiveLibido()/10) + rand(2));
			return lust0;
		}
		
		private function vegotE():void {
			outputText("The Raiju King clutches onto his amulet as energy begins welling up before he unleashes it. A wave of cold air whirls around your party as the deathly chill freezes you in your tracks. ");
			if (player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			else {
				if (player.hasStatusEffect(StatusEffects.Stunned)) player.addStatusValue(StatusEffects.Stunned, 1, 4);
				else player.createStatusEffect(StatusEffects.Stunned, 4, 0, 0, 0);
			}
			createStatusEffect(StatusEffects.AbilityCooldown1, 2, 0, 0, 0);
		}
		
		private function vegotR():void {
			if (hasStatusEffect(StatusEffects.Uber)) {
				removeStatusEffect(StatusEffects.Uber);
				if (monsterIsStunned() || monsterIsConstricted() || hasStatusEffect(StatusEffects.Fear)) {
					removeStatusEffect(StatusEffects.AbilityCooldown2);
					outputText("Vegot reels in frustration as his concentration breaks under your assaults.\n\n");
				}
				else {
					var damage:Number = 0;
					damage += eBaseIntelligenceDamage() * 20;
					if (hasStatusEffect(StatusEffects.Maleficium)) damage *= 2;
					outputText("\"<i>Desolation Era</i>\". In just two words, the entire room is coated in the white blizzard. The unnatural chill combined with roaring thunder is blinding and deafening.");
					player.takeIceDamage(damage, true);
					player.takeLightningDamage(damage, true);
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
			}
			else {
				outputText("Vegot starts incanting a spell, of which you cannot understand. Nothing seems to happen until you notice the room getting colder. Static begins arcing as sparks flash about you.");
				createStatusEffect(StatusEffects.Uber, 0, 0,0,0);
				createStatusEffect(StatusEffects.AbilityCooldown2, 6, 0, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.lustStorm)) {
				outputText("You're struck by lightning as lust storm rages on.");
				player.takeLightningDamage(vegotW1(), true);
				player.takeLustDamage(vegotW2(), true);
				outputText("\n\n");
			}
			if (hasStatusEffect(StatusEffects.Uber)) vegotR();
			else RandomiseAction();
		}
		
		protected function RandomiseAction():void {
			var choice:Number = rand(6);
			switch (choice) {
				case 0:
					vegotBasicAttack();
					break;
				case 1:
					vegotQ();
					break;
				case 2:
					vegotW();
					break;
				case 3:
					if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) vegotE();
					else RandomiseAction();
					break;
				case 4:
					if (!hasStatusEffect(StatusEffects.AbilityCooldown2)) vegotR();
					else RandomiseAction();
					break;
				default:
					vegotBasicAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatVegot();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByVegot();
		}
		
		override public function get long():String {
			var str:String = "";
			str += "You are fighting Vegot. He appears to be an adult raiju and proclaims himself to be the king.\n\n";
			str += "His face is cold with icy blue eyes that stare at you intently. The fur that coats his head and parts of his body is white and erratic, like rushing static, ending with a light blue tip.\n\n";
			str += "He wears an ice-encrusted crown adorned over his head. The crown is black, like charcoal, yet the glints of frost give it a glittery glow.\n\n";
			str += "He wears little clothing across his toned frame. A fur cape, similar to the fur covering his arms cloaks his back. Ornate spaulders are linked together and weave into his cloak through a series of ice-like chains.\n\n";
			str += "He wears a fur vest, parting to reveal his torso. The raiju wears no pants, his legs coated only by his fur.\n\n";
			str += "Wrapped around his neck is an amulet, seemingly a font of magical power. The amulet has a large jewel that hangs between his pectorals. It shines with a frosty crust, yet pulses faintly with electricity.\n\n";
			str += "Wielded in his arms is a longsword that he swings seamlessly. It's seemingly completely made of ice, but the interior shines with the spark of electricity. The weapon crackles occasionally with a pulse of electricity, ready to discharge a freezing cut as well as several amps of power.";
			return str;
		}

		public function Vegot()
		{
			this.a = "";
			this.short = "Vegot";
			this.long = "";
			this.createCock(30,5);
			this.balls = 2;
			this.ballSize = 5;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 120;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_TIGHT;
			this.bodyColor = "light";
			this.hairColor = "white";
			this.hairLength = 10;
			initStrTouSpeInte(260, 390, 460, 400);
			initWisLibSensCor(400, 435, 305, 60);
			this.weaponAttack = 108;
			this.weaponName = "Frostlight";
			this.weaponVerb="slash";
			this.armorName = "vest";
			this.armorDef = 64;
			this.armorMDef = 120;
			this.bonusHP = 300;
			this.bonusLust = 790;
			this.lust = 30;
			this.lustVuln = .8;
			this.level = 40;
			this.gems = 65 + rand(30);
			this.drop = new WeightedDrop().
					add(consumables.VOLTTOP,3).
					add(consumables.ALCTHUN,2).
					add(useables.EL_CORE,1);
			this.wings.type = Wings.THUNDEROUS_AURA;
			this.rearBody.type = RearBody.RAIJU_MANE;
			this.arms.type = Arms.RAIJU;
			this.lowerBody = LowerBody.RAIJU;
			this.tailType = Tail.RAIJU;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobCourtesan, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}