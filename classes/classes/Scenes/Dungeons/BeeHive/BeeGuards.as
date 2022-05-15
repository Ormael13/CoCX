/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.BeeHive 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.Scenes.Areas.Forest.BeeGirl;

	public class BeeGuards extends BeeGirl {
		
		public function beeGuardsStinger():void {
			outputText("One of the guards strikes through your defenses, trying to burrow her stinger in. ");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) outputText("Luckly it missed you.");
			//Hit:
			else {
				outputText("The arousal and pleasure spike from the aphrodisiac in the sting leaves you stunned.");
				if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				createStatusEffect(StatusEffects.AbilityCooldown1,5,0,0,0);
				player.dynStats("lus", 90 + rand(45));
			}
		}
		
		public function beeGuardsSpearStrike():void {
			outputText("One of the guards attempts to impale you with her spear! ");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) outputText("The weapon missed you.");
			//Hit:
			else {
				outputText("The weapon goes right through you! ");
				var damage:Number = weaponAttack + str * 2 + rand(str);
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void {
			if (rand(2) == 0 && !hasStatusEffect(StatusEffects.AbilityCooldown1)) beeGuardsStinger();
			else beeGuardsSpearStrike();
		}
		
		override public function defeated(hpVictory:Boolean):void {
			clearOutput();
			outputText("The two guards fall to the ground, " + (hpVictory ? "their wounds too great":"too busy masturbating") + " to keep up on fighting. You get past them and enter the Hive.");
			if (hpVictory) flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] = 2;
			else flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] = 2.5;
			cleanupAfterCombat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.beehive.room1LostToGuards();
		}
		
		public function BeeGuards() 
		{
			super();
			this.a = "";
			this.short = "Bee guards";
			this.long = "These two bee guards are trying to prevent you from entering the Hive. While most bees are covered in chitin-like plating, these girls look even tougher than their less combative counterparts.";
			createBreastRow(Appearance.breastCupInverse("D"));
			initStrTouSpeInte(70, 220, 90, 35);
			initWisLibSensCor(35, 170, 125, 0);
			this.weaponAttack = 15;
			this.armorDef = 50;
			this.armorMDef = 20;
			this.bonusHP = 1000;
			this.bonusLust = 325;
			this.level = 30;
			this.gems = rand(30) + 30;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			checkMonster();
		}
		
	}

}