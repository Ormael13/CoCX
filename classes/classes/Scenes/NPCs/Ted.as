/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class Ted extends Monster
	{
		private function tedSpecialAttackOne():void {
			var damage:Number = 0;
			if (hasStatusEffect(StatusEffects.Blind)) {
				outputText("Dragon-boy makes a wide sweeping attack with his hammer, which is difficult to avoid even from a blinded opponent.\n");
			}
			if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("You barely manage to avoid a wide sweeping attack from dragon-boy by rolling under it.");
				return;
			}
			damage = int((str + 60 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			damage /= 2;
			if (damage <= 0) {
				damage = 0;
				outputText("You easily deflect and block the damage from dragon boy wide swing.");//Ted's
			}
			else outputText("Dragon boy easily hits you with a wide, difficult to avoid swing.  ");
			if(damage > 0) player.takePhysDamage(damage, true);
			statScreenRefresh();
		}
		private function tedSpecialAttackTwo():void {
			var damage:Number = 0;
			if (hasStatusEffect(StatusEffects.Blind)) {
				outputText("Dragon-boy unwisely tries to make a massive swing while blinded, which you are easily able to avoid.");
				return;
			}
			if (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 60) {
				outputText("You manage to roll out of the way of a massive overhand swing.");
				return;
			}
			if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 60) {
				outputText("You easily sidestep as dragon-boy tries to deliver a huge overhand blow.");
				return;
			}
			damage = int((str + 30 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if (damage <= 0) {
				damage = 0;
				outputText("You somehow manage to deflect and block dragon-boy massive overhead swing.");//Ted's
			}
			if (damage > 0) {
				outputText("You are struck by a two-handed overhead swing from the enraged dragon-boy.  ");
				damage = player.takePhysDamage(damage, true);
			}
			statScreenRefresh();
		}//poniżej ataki jakie bedzie używać w dodatku do 2 powyżej w czasie spotkań po Hidden Cave
		private function tedSpecialAttack1():void {
			var damage:Number = 0;
			statScreenRefresh();
		}
		private function tedSpecialAttack2():void {
			var damage:Number = 0;
			statScreenRefresh();
		}
		private function tedSpecialAttack3():void {
			var damage:Number = 0;
			statScreenRefresh();
		}
		
		override protected function performCombatAction():void
		{
			var choice1:Number = rand(3);
			if (choice1 == 0) eAttack();
			if (choice1 == 1) tedSpecialAttackOne();
			if (choice1 == 2) tedSpecialAttackTwo();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			clearOutput();
			outputText("A dragon-boy fall on his knees ");
			if (this.HP < 1)outputText("beaten up");
			else outputText("too horny to fight back");
			SceneLib.tedScene.defeatedTed();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.tedScene.lostToTed();
		}
		
		public function Ted() 
		{
			this.a = "the ";
			this.short = "mysterious dragon-boy";
			this.imageName = "mysterious dragon-boy";
			this.long = "Before you stands a dragon-boy.  Though he stands only six and half feet tall, he is covered in lean muscle and moves with grace no lesser than most skilled balet dancers.  He wears armor made of green dragon scales and fight using an oversized hammer that got inscribed on it words 'bam' and 'hammer'. Thou to be truth to be said word 'bam' looks like it was orginaly word 'ban'.";
			// this.plural = false;
			this.createCock(4,1);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 50;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 78;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.setBaseOnly({color:"white"});
			this.skinDesc = "skin";
			this.hairColor = "brown";
			this.hairLength = 2;
			initStrTouSpeInte(30, 50, 50, 30);
			initWisLibSensCor(30, 20, 40, 50);
			this.weaponName = "bam hammer";
			this.weaponVerb="bam";
			this.weaponAttack = 8;
			this.armorName = "dragonscales armor";
			this.armorDef = 5;
			this.lust = 15;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 9;
			this.gems = rand(10) + 5;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanMarrow, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}