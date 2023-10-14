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

public class TheCorruptedHandmaidens extends Monster {
		
		public function corruptedHandmaidensStinger():void {
			outputText("One of the handmaidens strikes through your defenses, trying to burrow her stinger in. ");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) outputText("Luckly it missed you.");
			//Hit:
			else {
				outputText("The arousal and pleasure spike from the aphrodisiac in the sting leaves you stunned.");
				if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				createStatusEffect(StatusEffects.AbilityCooldown1,5,0,0,0);
				player.takeLustDamage(100 + rand(50), true);
			}
		}
		
		public function corruptedHandmaidensCompellingAria():void {
			if (hasStatusEffect(StatusEffects.CHCompellingAria)) {
				outputText("The fallen handmaidens keep singing.");
				var CHCA1:Number = statusEffectv1(StatusEffects.CHCompellingAria);
				addStatusValue(StatusEffects.CHCompellingAria, 1, CHCA1);
			}
			else {
				outputText("The handmaidens begin to sing together in a full-fledged chorus. You feel your desire increase as their insidious song gets to you.");
				var CHCA:Number = inte + wis;
				createStatusEffect(StatusEffects.CHCompellingAria, CHCA, 0, 0, 0);
				createStatusEffect(StatusEffects.AbilityCooldown2, 6, 0, 0, 0);
			}
			player.takeLustDamage(statusEffectv1(StatusEffects.CHCompellingAria), true);
		}
		
		override protected function performCombatAction():void {
			if (monsterIsStunned()) removeStatusEffect(StatusEffects.CHCompellingAria);
			else if (hasStatusEffect(StatusEffects.CHCompellingAria)) corruptedHandmaidensCompellingAria();
			else {
				if (rand(2) == 0 && !hasStatusEffect(StatusEffects.AbilityCooldown1) && !hasStatusEffect(StatusEffects.AbilityCooldown2)) {
					if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) corruptedHandmaidensCompellingAria();
					else corruptedHandmaidensStinger();
				}
				else eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.beehive.defeatCorruptedHandmiadens();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.beehive.defeatedByCorruptedHandmaidens();
		}
		
		public function TheCorruptedHandmaidens() 
		{
			super();
			this.a = "the ";
			this.short = "corrupted handmaidens";
			this.long = "You are fighting a full group of handmaidens. These girls are all corrupted, their large penises, bigger breasts and horns a clear sign of their demonification.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("F"));
			this.createCock(18,3,CockTypesEnum.DEMON);
			this.plural = true;
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.lowerBody = LowerBody.BEE;
			this.bodyColor = "yellow";
			this.hairColor = randomChoice("black","black and yellow");
			this.hairLength = 6;
			initStrTouSpeInte(68, 160, 92, 50);
			initWisLibSensCor(50, 185, 140, 100);
			this.weaponName = "chitin-plated fist";
			this.weaponVerb="armored punch";
			this.weaponAttack = 15;
			this.armorName = "chitin";
			this.armorDef = 60;
			this.armorMDef = 24;
			this.bonusHP = 100;
			this.bonusLust = 360;
			this.lustVuln = .5;
			this.level = 35;
			this.gems = rand(35) + 30;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.antennae.type = Antennae.BEE;
			this.wings.type = Wings.BEE_SMALL;
			this.tailType = Tail.BEE_ABDOMEN;
			this.tailVenom = 100;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 35, 0, 0, 0);
			checkMonster();
		}
		
	}

}