/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.IMutations.LizanMarrowMutation;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

use namespace CoC;
	
	public class Ted extends Monster
	{
		private function tedSpecialAttackOne():void {
			var damage:Number = 0;
			if (player.getEvasionRoll()) {
				outputText("You barely manage to avoid a wide sweeping attack from dragon-boy by rolling under it.");//Ted's
				return;
			}
			damage = int((str + 60 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			damage /= 2;
			if (damage <= 0) {
				damage = 0;
				outputText("You easily deflect and block the damage from dragon boy wide swing.");//Ted's
			}
			else outputText((flags[kFLAGS.TED_LVL_UP] >= 3 ?"Ted":"Dragon-boy")+" easily hits you with a wide, difficult to avoid swing.  ");//Ted
			if(damage > 0) player.takePhysDamage(damage, true);
		}
		private function tedSpecialAttackTwo():void {
			var damage:Number = 0;
			if (player.getEvasionRoll()) {
				outputText("You manage to roll out of the way of a massive overhand swing.");
				return;
			}
			damage = int((str + 30 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if (damage <= 0) {
				damage = 0;
				outputText("You somehow manage to deflect and block dragon-boy massive overhead swing.");//Ted's
			}
			if (damage > 0) {
				outputText("You are struck by a two-handed overhead swing from the enraged dragon-boy.  ");//Ted
				damage = player.takePhysDamage(damage, true);
			}
		}//poniżej ataki jakie bedzie używać w dodatku do 2 powyżej w czasie spotkań po Hidden Cave
		private function tedSpecialAttack1():void {
			var damage:Number = 0;
		}
		private function tedSpecialAttack2():void {
			var damage:Number = 0;
		}
		private function tedSpecialAttack3():void {
			var damage:Number = 0;
		}
		
		override protected function performCombatAction():void
		{/*
			if (flags[kFLAGS.TED_LVL_UP] >= 2) {
				var choice1:Number = rand(4);
				if (choice1 == 0) eAttack();
				if (choice1 == 1) tedSpecialAttackOne();
				if (choice1 == 2) tedSpecialAttackTwo();
				if (choice1 == 3) tedSpecialAttack1();
			}
			else {*/
				var choice2:Number = rand(3);
				if (choice2 == 0) eAttack();
				if (choice2 == 1) tedSpecialAttackOne();
				if (choice2 == 2) tedSpecialAttackTwo();
			//}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			clearOutput();
			outputText((flags[kFLAGS.TED_LVL_UP] >= 3 ?"Ted":"A dragon-boy")+" fall on his knees ");
			if (this.HP < 1)outputText("beaten up");
			else outputText("too horny to fight back");
			if (flags[kFLAGS.TED_LVL_UP] >= 1) SceneLib.tedScene.defeatedTedPostHiddenCave();
			else SceneLib.tedScene.defeatedTed();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.TED_LVL_UP] >= 1) SceneLib.tedScene.lostToTedPostHiddenCave();
			else SceneLib.tedScene.lostToTed();
		}
		
		public function Ted() 
		{
			if (flags[kFLAGS.TED_LVL_UP] < 1) {
				initStrTouSpeInte(30, 50, 50, 30);
				initWisLibSensCor(30, 20, 40, 0);
				this.weaponAttack = 8;
				this.armorDef = 5;
				this.armorMDef = 50;
				this.bonusLust = 69;
				this.level = 9;
			}
			if (flags[kFLAGS.TED_LVL_UP] == 1) {
				initStrTouSpeInte(40, 70, 70, 40);
				initWisLibSensCor(40, 25, 50, 0);
				this.weaponAttack = 10;
				this.armorDef = 10;
				this.armorMDef = 55;
				this.bonusLust = 90;
				this.level = 15;
			}
			if (flags[kFLAGS.TED_LVL_UP] == 2) {
				initStrTouSpeInte(50, 90, 90, 50);
				initWisLibSensCor(50, 30, 60, 0);
				this.weaponAttack = 12;
				this.armorDef = 15;
				this.armorMDef = 60;
				this.bonusLust = 111;
				this.level = 21;
			}
			if (flags[kFLAGS.TED_LVL_UP] == 3) {
				initStrTouSpeInte(63, 115, 115, 62);
				initWisLibSensCor(62, 35, 70, 0);
				this.weaponAttack = 15;
				this.armorDef = 21;
				this.armorMDef = 66;
				this.bonusLust = 132;
				this.level = 27;
			}
			if (flags[kFLAGS.TED_LVL_UP] >= 3) {
				this.a = "";
				this.short = "Ted";
			}
			else {
				this.a = "the ";
				this.short = "mysterious dragon-boy";
			}
			if (flags[kFLAGS.TED_LVL_UP] >= 6) this.drop = new WeightedDrop(consumables.BAGOCA3, 1);
			else if (flags[kFLAGS.TED_LVL_UP] >= 3 && flags[kFLAGS.TED_LVL_UP] < 6) this.drop = new WeightedDrop(consumables.BAGOCA2, 1);
			else this.drop = new WeightedDrop(consumables.BAGOCA1, 1);
			this.imageName = "mysterious dragon-boy";
			this.long = "Before you stands a dragon-boy.  He stands only six and half feet tall and is covered in lean muscle. He moves with a grace akin to a skilled ballet dancer.  He wears armor made of green dragon scales and fight using an oversized hammer that got inscribed on it words 'bam' and 'hammer'. As you glance over it, the word 'bam' looks like it was originally word 'ban'.";
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
			this.weaponName = "bam hammer";
			this.weaponVerb="bam";
			this.armorName = "dragonscales armor";
			this.lust = 15;
			this.lustVuln = .9;
			this.gems = rand(10) + 5;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
			this.createPerk(IMutationsLib.LizanMarrowIM, 1, 0, 0, 0);
			this.createPerk(PerkLib.EnemyDragonType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			IMutationsLib.LizanMarrowIM.acquireMutation(this, "none");
			checkMonster();
		}
		
	}

}