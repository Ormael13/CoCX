/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Battlefield 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.Scenes.Areas.Battlefield.BattlefieldEnemiesScenes;
import classes.internals.*;

	public class Zombies extends Monster
	{
		public var Jiangshi:BattlefieldEnemiesScenes = new BattlefieldEnemiesScenes();
		private var hopping:Number = 0;
		
		private function ZombiesHop():void {
			outputText("The zombies tries to get closer by hopping toward you.");
			hopping += 1;
		}
		
		public function ZombiesUndyingFlurry():void {
			outputText("The zombies flails wildly attempting to strike you with their pale purple claw like nails. ");
			var zuf:Number = 25;
			while (zuf-->0) ZombiesUndyingFlurryH();
		}
		private function ZombiesUndyingFlurryH():void {
			if (player.getEvasionRoll()) outputText("<b>Miss</b> ");
			else {
				var zuf1:Number = 0;
				zuf1 += this.str;
				zuf1 += eBaseStrengthDamage()
				zuf1 = player.takePhysDamage(zuf1, true);
				var damageLust:Number = Math.round(this.lib / 50);
				player.takeLustDamage(damageLust, true);
				outputText(" ");
			}
		}
		
		public function ZombiesDrainingKiss():void {
			outputText("One of the zombies shambles towards you. You shove it back, but as you do, another hops in from the side, grabbing at you! ");
			if (player.hasPerk(PerkLib.TitanicSize)) {
				outputText("They try to grab you, but they can barely reach your knees. You easily shrug them off, slapping one in the face for good measure.");
				hopping = 0;
			}
			else {
				if (player.getEvasionRoll()) outputText("Out of the corner of your eyes, you see the flank coming. You back up, breaking the attempted circle. The horde keeps coming, but you’re not drained.");
				else {
					outputText("From all angles, you feel them grab you. Your arms, your [legs], they drag you down, piling on. While you struggle, you feel their lips, cold and clammy, on your [skin]. Your vitality is draining, and fast! ");
					outputText("You struggle, freeing an arm. You strike one of them hard, sending it tumbling off. Several more are dislodged, and you get your [legs] underneath you, wriggling out from underneath the pile of flesh.");
					var damageLust:Number = Math.round(player.lib * 2);
					player.takeLustDamage(damageLust, true, false);
					EngineCore.changeFatigue(Math.round(player.maxFatigue()*0.2));
					EngineCore.ManaChange(-Math.round(player.maxMana()*0.2));
					EngineCore.SoulforceChange( -Math.round(player.maxSoulforce() * 0.2));
					addHP(Math.round(maxHP() * 0.5));
					hopping = 0;
				}
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hopping < 2) ZombiesHop();
			else {
				if (rand(2) == 0) ZombiesUndyingFlurryH();
				else ZombiesDrainingKiss();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			Jiangshi.defeatZombies();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			Jiangshi.loseToZombies();
		}
		
		public function Zombies() 
		{
			this.a = "the ";
			this.short = "zombies";
			this.imageName = "zombies";
			this.long = "Those pale naked women and men slowly hops toward you with unwavering determination, their greedy hands hanging in front of them as they tries to grab you. Their mouths sports a set of fiendish canines more at home on a monster then a human and regularly lets out a dim-witted moan. Those zombies, for lacking of a better word, are starved for sex and intends to rape you to satisfy their craving for life.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(15,2);
			this.createCock(15,2,CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 78;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.bodyColor = "pale blue";
			this.hairColor = "white";
			this.hairLength = 4;
			initStrTouSpeInte(288, 310, 32, 28);
			initWisLibSensCor(28, 280, 280, 0);
			this.weaponName = "glowing purple nails";
			this.weaponVerb="claws";
			this.weaponAttack = 30;
			this.armorName = "skin";
			this.armorDef = 120;
			this.armorMDef = 600;
			this.bonusHP = 500;
			this.bonusLust = 600;
			this.level = 40;
			this.gems = 10 + rand(5);
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyUndeadType, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.LowtierMagicImmunity, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
