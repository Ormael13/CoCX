/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Caves.CaveWyrmScene;
import classes.internals.*;

use namespace CoC;

	public class CaveWyrm extends Monster
	{
		public var cavewyrmScene:CaveWyrmScene = new CaveWyrmScene();
		
		public function moveCaveWyrmOmniSlash():void {
			outputText("The cave wyrm begin to furiously dance around you hacking and slicing with her axes and feets!");
			outputText("\n\nThe cave wyrm hack you with her axe. ");
			omnislashDmgBleed();
			outputText("\n\nThe cave wyrm hack you with her axe. ");
			omnislashDmgBleed();
			outputText("\n\nThe cave wyrm hack you with her axe. ");
			omnislashDmgBleed();
			outputText("\n\nThe cave wyrm hack you with her axe. ");
			omnislashDmgBleed();
			outputText("\n\nThe cave wyrm claw at you with her feet. ");
			omnislashDmgBleed();
			outputText("\n\nThe cave wyrm claw at you with her feet. ");
			omnislashDmgBleed();
		}
		private function omnislashDmgBleed():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += this.weaponAttack;
			damage += rand(str);
			damage += rand(weaponAttack);
			damage += 1.2;
			damage = Math.round(damage);
			damage = player.takePhysDamage(damage, true);
			if (rand(10) == 0) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else {
					player.createStatusEffect(StatusEffects.Hemorrhage, 3, 0.05, 0, 0);
					outputText(" Reeling in pain you begin to bleed.");
				}
			}
		}
		
		public function moveBlueFlamethrower():void
		{
			outputText("The cave wyrm woman inhales then suddenly douse you with blue fire, setting you aflame! ");
			var firedamage:int = rand(inte);
			firedamage += eBaseIntelligenceDamage() * 1.2;
			firedamage = Math.round(firedamage);
			player.takeFireDamage(firedamage, true);
			if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
			else {
				player.createStatusEffect(StatusEffects.BurnDoT,3,0.05,0,0);
				outputText(" Reeling in pain you begin to burn.");
			}
		}
		
		public function cavewyrmLustzerk():void {
			wrath -= 50;
			outputText("The lizard woman scream a warcry as she enter a tantrum! Her vagina beginning to get wetter");
			if (flags[kFLAGS.HERM_CAVE_WYRM] == 1) outputText(" as her dick begin to dribble precum");
			outputText(".\n\n");
			var lustzerkBonus:Number = (40 + (40 * (1 + player.newGamePlusMod())));
			createStatusEffect(StatusEffects.Lustzerking, 10, lustzerkBonus, 0, 0);
			this.weaponAttack += statusEffectv2(StatusEffects.Lustzerking);
		}
		
		override protected function performCombatAction():void
		{
			wrath += 5;
			var choice:Number = rand(4);
			if (choice == 0) {
				if (!hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 50) cavewyrmLustzerk();
				else moveBlueFlamethrower();
			}
			if (choice == 1) moveBlueFlamethrower();
			if (choice >= 2) moveCaveWyrmOmniSlash();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			cavewyrmScene.winningOverCaveWyrm();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.HERM_CAVE_WYRM] == 1) {
				if (player.hasCock() && rand(3) == 0) cavewyrmScene.loosingToCaveWyrmDMelting();
				else cavewyrmScene.loosingToHermCaveWyrm();
			}
			if (player.hasCock() && rand(3) == 0) cavewyrmScene.loosingToCaveWyrmDMelting();
			else cavewyrmScene.loosingToCaveWyrm();
		}
		
		override public function get long():String {
			var str:String = "";
			str += "This lizard woman has a tail larger than the average, similar to that of a newt. Furthermore, from her 6 feet tall frame, she has many aspects of her body that glow in the dark such as her nipples and eyes. While you would take more time to inspect her, the nasty pair of war axe’s she wildly swing around in a crazed tantrum is preventing you from getting closer.";
			if (game.flags[kFLAGS.HERM_CAVE_WYRM] == 1) str += " Between her leg a somewhat evident bulging lizard cock that is pulsing with both a neon blue light and luminescent precum.";
			return str;
		}
		
		public function CaveWyrm() 
		{
			this.a = "the ";
			this.short = "cave wyrm";
			this.imageName = "cave wyrm";
			this.long = "";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 120, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity, 120, 0, 0, 0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_INHUMANLY_WIDE;
			this.butt.type = Butt.RATING_INCONCEIVABLY_BIG;
			//this.lowerBody = LowerBody.ELF;
			this.skinTone = "dark blue";
			this.hairColor = "black";
			this.hairLength = 9;
			initStrTouSpeInte(142, 121, 110, 74);
			initWisLibSensCor(74, 100, 50, 30);
			this.weaponName = "double axe";
			this.weaponVerb= "double cleave";
			this.weaponAttack = 30;
			this.armorName = "scales";
			this.armorDef = 45;
			this.armorMDef = 15;
			this.bonusHP = 500;
			this.bonusWrath = 250;
			this.wrath = 130;
			this.bonusLust = 20;
			this.lustVuln = .35;
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 35;
			this.gems = rand(10) + 20;
			this.drop = new ChainedDrop().
					add(useables.EBONBLO,1/20).
					add(consumables.METHIRC,0.7);
			//this.tailType = Tail.SALAMANDER;
			//this.tailRecharge = 0;
			checkMonster();
		}	
	}
}