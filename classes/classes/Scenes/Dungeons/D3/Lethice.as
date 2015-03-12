package classes.Scenes.Dungeons.D3 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.internals.WeightedDrop;
	//The final boss.
	public class Lethice extends Monster
	{
		override public function defeated(hpVictory:Boolean):void
		{
			if (findStatusAffect(StatusAffects.Berzerking) >= 0) game.d3.lethice.theFinalEnding();
			else game.d3.lethice.finalBattlePart2();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.d3.lethice.loseToLethiceEpicFuckUp();
		}
		
		private function lethiceHeals():void {
			outputText("Lethice raises her lethicite-topped staff and chants repeatedly. The staff glows and the wounds disappear from her body! She glares at you and says, \"<i>Foolish Champion.</i>\"");
			addHP(eMaxHP() / 2);
			fatigue += 10;
			combatRoundOver();
		}
		private function lethiceCums():void {
			outputText("Lethice glares at you and says, \"<i>I'm not going to let you arouse me till I'm too distracted to fight back!</i>\" " + (findStatusAffect(StatusAffects.Berzerking) >= 0 ? "Her already-exposed clit shifts and twists until it becomes a cock that hangs freely in the air." : "Her clit shifts and twists until it becomes a cock that peeks out the slit in her thong.") + " She tweaks her exposed nipples, strokes her cock and fingers her vagina. She lets out a loud moan and screams in ecstasy as pink milk dribbles from her nipples. Cum and feminine juice spills forth, " + (rand(3) > 0 ? "splashing onto the floor" : "staining the carpet") + ". Her cock shrinks back into a clit. She frowns and scolds, \"<i>This is a fatiguing process and I'm not going to let you do it.</i>\"");
			lust = 0;
			fatigue += 25;
			if (lustVuln > 0.1) lustVuln -= 0.05;
			game.dynStats("lus", 15);
			combatRoundOver();
		}
		
		private function lethiceArouse():void {
			outputText("Lethice raises her lethicite-topped staff and chants repeatedly. She makes a series of arcane gestures, drawing on her own lust to inflict it upon you! ");
			var lustDmg:Number = (5 + (inte / 10) * spellMod() + rand(player.lib - player.inte * 2 + player.cor) / 5);
			if (lustDmg < 10) lustDmg = 10;
			lustDmg *= game.lustPercent() / 100;
			fatigue += 3;
			game.dynStats("lus+", lustDmg, "resisted", false);
			if(player.lust < 30) outputText("You squirm as the magic affects you. ", false);
			if(player.lust >= 30 && player.lust < 60) {
				outputText("You stagger, suddenly weak and having trouble focusing on staying upright. ", false);
			}
			if(player.lust >= 60) {
				outputText("Your eyes glaze over with desire for a moment. ", false);
			}
			outputText("<b>(<font color=\"#ff00ff\">+" + Math.round(lustDmg*10)/10 + "</font>)</b>");
			combatRoundOver();
		}
		
		//Not used at the moment
		private function lethiceWhitefire():void {
			outputText("");
			combatRoundOver();
		}
		
		private function lethiceUberAttack():void {
			outputText("Lethice raises her lethicite-topped staff and chants. Large dark magical orb appears just above her stuff. <b>You must do something to avoid getting hit!</b>");
			createStatusAffect(StatusAffects.Uber, 0, 0, 0, 0);
			combatRoundOver();
		}

		private function lethiceUberAttackHit():void {
			outputText("Lethice lets out an evil laughter and throws the orb towards you with her staff! ");
			if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] > 0) outputText("Thanks to your readiness, you manage to leap out of the way! Lethice lets out a curse. \"<i>Fuck! Why won't you stand still?</i>\"");
			else {
				outputText("It's too late! The orb hits you and explodes, causing a blinding flash across the room! You groan and writhe in pain. ");
				var dmg:int = ((inte * 2) + (100 - player.cor) + 100 + rand(150) * spellMod());
				dmg = player.reduceDamage(dmg);
				player.takeDamage(dmg, true);
			}
			fatigue += 30;
			removeStatusAffect(StatusAffects.Uber);
			combatRoundOver();
		}
		
		override public function doAI():void {
			if (findStatusAffect(StatusAffects.Stunned) >= 0) {
				outputText("Your foe is too dazed from your last hit to strike back!", false)
				if (findStatusAffect(StatusAffects.Uber) >= 0) {
					outputText(" You've managed to interrupt her spell!");
					removeStatusAffect(StatusAffects.Uber);
				}
				if (statusAffectv1(StatusAffects.Stunned) <= 0) removeStatusAffect(StatusAffects.Stunned);
				else addStatusValue(StatusAffects.Stunned, 1, -1);
				combatRoundOver();
				return;
			}
			if (findStatusAffect(StatusAffects.Fear) >= 0) {
				game.outputText("\"<i>You think I'm afraid of anything? Foolish champion!</i>\" Lethice snarls.\n\n");
				removeStatusAffect(StatusAffects.Fear);
			}
			if (findStatusAffect(StatusAffects.Uber) >= 0) {
				lethiceUberAttackHit();
				return;
			}
			if (HPRatio() < 0.6 && fatigue <= 90) {
				lethiceHeals();
				return;
			}
			if (lust >= 70 && fatigue <= 75) {
				lethiceCums();
				return;
			}
			var chooser:int = rand(6);
			if (chooser <= 1) lethiceArouse();
			else if (chooser == 2 && fatigue <= 70) lethiceUberAttack();
			//else if (choooser <= 4) lethiceWhitefire();
			else eAttack();
		}
		
		private function spellMod():Number {
			var temp:int = 1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL] * 0.5;
			if (temp > 2.5) temp = 2.5;
			if (findStatusAffect(StatusAffects.Berzerking) >= 0) temp += 0.5;
			return temp;
		}
		
		public function Lethice() 
		{
			this.a = "";
			this.short = "Lethice";
			this.long = "She is no doubt the Queen of the Demons. She has pink skin, a rare example among demons. Her eyes are black with yellow iris and slit pupil. Her fangs are clearly visible, protruding along her upper row of teeth. She has long, luxurious purple hair with black roses woven in it, parted by her pair of goat horns and multiple pairs of demonic horns. She has numerous lethicite piercings piercing her ears. Huge draconic wings grow from her back, easily rivaling a full-fledged dragon-morph. Her feet end in high heels. " + (findStatusAffect(StatusAffects.Berzerking) >= 0 ? "She's wearing a suit of lethicite armor that exposes her lethicite-pierced nipples and her glistening vagina." : "She's wearing a set of fetishy churchwear that doesn't seem to cover her B-cup breasts and her glistening vagina.") + " She's currently wielding an ebony staff topped with lethicite.";
			this.imageName = "lethice";
			this.tallness = 12 * 8;
			this.createBreastRow(Appearance.breastCupInverse("B"));
			//this.createCock(8, 1.5, CockTypesEnum.DEMON);
			this.createVagina(false, 5, 3); 
			
			this.skinTone = "pink";
			this.buttRating = 12;
			this.hipRating = 10;
			
			initStrTouSpeInte(100, 100, 85, 105);
			initLibSensCor(85, 40, 100);
			
			this.weaponName = "lethicite staff";
			this.weaponAttack = 15;
			this.weaponVerb = "thwack";
			this.armorName = "fetishy churchwear";
			this.armorDef = 2;
			
			this.bonusHP = 1200;
			this.additionalXP = 1000;
			this.gems = 500 + rand(50);
			this.level = 30;
			
			this.lustVuln = 0.3;
			
			this.drop = NO_DROP //new WeightedDrop(weapons.L_STAFF, 1);
			
			this.checkMonster();
		}
		
	}

}