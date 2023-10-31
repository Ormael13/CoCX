/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.BeeHive 
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
	
	public class DemonicBee extends Monster {
		
		public function demonicBeeStinger():void {
			outputText("The demonic bee guard strikes through your defenses, trying to burrow her stinger in. ");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) outputText("Luckily it missed you.");
			//Hit:
			else {
				outputText("The arousal and pleasure spike from the aphrodisiac in the sting leaves you stunned.");
				if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				createStatusEffect(StatusEffects.AbilityCooldown1,5,0,0,0);
				player.takeLustDamage(120 + rand(60), true);
			}
		}
		
		public function demonicBeeSpearStrike():void {
			outputText("The demonic bee guard attempts to impale you with her spear, ");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) outputText("but misses you.");
			//Hit:
			else {
				outputText("and the weapon goes right through you! ");
				var damage:Number = weaponAttack + str * 2 + rand(str);
				damage = player.takePhysDamage(damage, true);
				outputText("What's worse, she applied venom on it!");
				player.takeLustDamage(20 + rand(10), true);
			}
		}
		
		override protected function performCombatAction():void {
			if (rand(2) == 0 && !hasStatusEffect(StatusEffects.AbilityCooldown1)) demonicBeeStinger();
			else demonicBeeSpearStrike();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			cleanupAfterCombat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.beehive.defeatedByDemonicBee();
		}
		
		public function DemonicBee() 
		{
			super();
			this.a = "";
			this.short = "Demonic bee";
			this.long = "This bee guard is severely corrupted clearly having become an omnibus. Her bat shaped bee wings, unholy cock and demonic horns is a testament to how far she has fallen.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.createCock(12,2,CockTypesEnum.DEMON);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.lowerBody = LowerBody.BEE;
			this.bodyColor = "yellow";
			this.hairColor = randomChoice("black","black and yellow");
			this.hairLength = 6;
			initStrTouSpeInte(75, 180, 95, 45);
			initWisLibSensCor(45, 180, 135, 100);
			this.weaponName = "chitin-plated fist";
			this.weaponVerb="armored punch";
			this.weaponAttack = 19;
			this.armorName = "chitin";
			this.armorDef = 55;
			this.armorMDef = 22;
			this.bonusHP = 150;
			this.bonusLust = 350;
			this.lustVuln = .5;
			this.level = 30;
			this.gems = rand(35) + 20;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.antennae.type = Antennae.BEE;
			this.wings.type = Wings.BEE_SMALL;
			this.tailType = Tail.BEE_ABDOMEN;
			this.tailVenom = 100;
			checkMonster();
		}
		
	}

}