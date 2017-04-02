/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.BlightRidge
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Areas.BlightRidge.DemonScene;
	
	use namespace kGAMECLASS;
	
	public class Incubus extends Monster
	{
		public var TrueDemons:DemonScene = new DemonScene();
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			TrueDemons.defeatIncubus();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			TrueDemons.loseToAIncubus();
		}
		
		private function cockTripAttack():void {
			if (findStatusAffect(StatusAffects.Blind) >= 0) { //Blind dodge change
				outputText(capitalA + short + " suddenly grows it's dick to obscene lengths and tries to trip you with it.  Thankfully he's so blind he wasn't aiming anywhere near you!");
				game.combatRoundOver();
				return;
			}
			outputText("The incubus lunges forward in a clumsy attack that you start to side-step, only to feel something grip behind your " + game.buttDescript() + " and pull your " + player.legs() + " out from under you.");
			if ((player.spe-30) > rand(60)) {
				outputText("  You spin as you fall, twisting your " + player.legs() + " free and springing back to your " + player.feet() + " unharmed.");
			}
			else { //Fall down go boom
				outputText("  You land hard on your ass, momentarily stunned as the demonic cock-tentacle curls around your " + player.legs() + ", smearing them with oozing demonic fluids.");
				if (player.lust >= 80 || player.cor >= 80) {
					outputText("  Moaning with desire, you lick your lips as you slide your well-lubricated " + player.legs() + " free.  You gather a dollop of cum and lick it seductively, winking at the incubus and hoping to make him cave into his desire.");
					game.dynStats("lus", 13, "cor", 1);
				}
				else if (player.lust >= 50 || player.cor >= 50) {
					outputText("  Blushing at the scent and feel of cum on your " + player.legs() + ", you twist and pull free.  You find yourself wondering what this demon's dick would taste like.");
					game.dynStats("lus", 8 + player.cor / 20);
				}
				else {
					outputText("  Disgusted, you pull away from the purplish monstrosity, the act made easier by your well-slimed " + player.legs() + ".");
					game.dynStats("lus", 5 + player.cor / 20);
				}
				game.takeDamage(5);
			}
			outputText("\nThe incubus gives an overconfident smile as his cock retracts away from you, returning to its normal size.");
			game.combatRoundOver();
		}
		
		private function cockTripAttack2():void {
			if (findStatusAffect(StatusAffects.Blind) >= 0) { //Blind dodge change
				outputText(capitalA + short + " suddenly grows it's dick to obscene lengths and tries to trip you with it.  Thankfully he's so blind he wasn't aiming anywhere near you!");
				game.combatRoundOver();
				return;
			}
			outputText("The incubus lunges forward in a clumsy attack that you start to side-step, only to feel something grip behind your " + game.buttDescript() + " and pull your " + player.legs() + " out from under you.");
			if ((player.spe-30) > rand(60)) {
				outputText("  You spin as you fall, twisting your " + player.legs() + " free and springing back to your " + player.feet() + " unharmed.");
			}
			else { //Fall down go boom
				outputText("  You land hard on your ass, momentarily stunned as the demonic cock-tentacle curls around your " + player.legs() + ", smearing them with oozing demonic fluids.");
				if (player.lust >= 80 || player.cor >= 80) {
					outputText("  Moaning with desire, you lick your lips as you slide your well-lubricated " + player.legs() + " free.  You gather a dollop of cum and lick it seductively, winking at the incubus and hoping to make him cave into his desire.");
					game.dynStats("lus", 12, "cor", 0.5);
				}
				else if (player.lust >= 50 || player.cor >= 50) {
					outputText("  Blushing at the scent and feel of cum on your " + player.legs() + ", you twist and pull free.  You find yourself wondering what this demon's dick would taste like.");
					game.dynStats("lus", 7 + player.cor / 25);
				}
				else {
					outputText("  Disgusted, you pull away from the purplish monstrosity, the act made easier by your well-slimed " + player.legs() + ".");
					game.dynStats("lus", 4 + player.cor / 25);
				}
				game.takeDamage(4);
			}
			outputText("\nThe incubus gives an overconfident smile as his cock retracts away from you, returning to its normal size.");
			game.combatRoundOver();
		}
		
		private function spoogeAttack2():void {
			if (findStatusAffect(StatusAffects.Blind) >= 0) { //Blind dodge change
				outputText(capitalA + short + " pumps and thrusts his hips lewdly before cumming with intense force in your direction!  Thankfully his aim was off due to the blindness currently affect him.");
				game.combatRoundOver();
				return;
			}
			outputText("Your demonic foe places his hands behind his head and lewdly pumps and thrusts his hips at you.  Your eyes open wide as a globule of cum erupts from the demon-prick and flies right at you.  ");
			if (player.shield == game.shields.DRGNSHL && rand(2) == 0)
			{
				outputText("Your shield managed to absorb the attack!")
				combatRoundOver();
				return;
			}
			outputText("You do your best to dodge, but some still lands on your ");
			switch (rand(3)) {
				case 0: //Face
					outputText("face.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your mouth and nose!  You can feel it moving around inside you, doing its best to prepare you for its master.");
					game.dynStats("lus", 3);
					if (player.findStatusAffect(StatusAffects.DemonSeed) < 0)
						player.createStatusAffect(StatusAffects.DemonSeed, 4, 0, 0, 0);
					else player.addStatusValue(StatusAffects.DemonSeed, 1, 6);
					player.slimeFeed();
					break;
				case 1: //Chest
					if (player.hasFuckableNipples()) {
						outputText(allBreastsDescript() + ".  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your open nipples.  You can feel it moving around inside you, doing its best to prepare you for its master.");
						game.dynStats("lus", 3);
						if (player.findStatusAffect(StatusAffects.DemonSeed) < 0)
							player.createStatusAffect(StatusAffects.DemonSeed, 4, 0, 0, 0);
						else player.addStatusValue(StatusAffects.DemonSeed, 1, 7);
						player.slimeFeed();
					}
					else outputText(allBreastsDescript() + ".  Thankfully it doesn't seem to have much effect.");
					break;
				default: //Crotch
					if (player.vaginas.length > 0) {
						outputText("crotch.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way past your " + player.armorName + " and into your " + player.vaginaDescript(0) + ".  You can feel it moving around inside you, doing its best to prepare you for its master.");
						game.dynStats("lus", 3);
						if (player.findStatusAffect(StatusAffects.DemonSeed) < 0)
							player.createStatusAffect(StatusAffects.DemonSeed, 4, 0, 0, 0);
						else player.addStatusValue(StatusAffects.DemonSeed, 1, 7);
						player.slimeFeed();
					}
					else outputText("crotch.  Thankfully, it doesn't seem to have much effect.");
			}
			game.combatRoundOver();
			lust -= 10;
			if (lust < 0) lust = 10;
		}
		
		public function Incubus()
		{
			this.a = "the ";
			this.short = "incubus";
			this.imageName = "incubus";
			this.long = "The demon before you is clad only in cut-off denim overalls.  There is a large hole ripped in the crotch, allowing the demon's foot-long member to hang free.  His skin is light purple and perfect, face rugged and handsome, topped with a simple black ponytail and two large horns that sprout from his forehead like twisted tree-trunks.  He not seems to be using any weapon aside of his own claws.";
			// this.plural = false;
			this.createCock(12,1.75,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 2;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_TIGHT;
			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_CLAWS;
			this.skinTone = "light purple";
			this.hairColor = "black";
			this.hairLength = 12;
			initStrTouSpeInte(150, 100, 110, 105);
			initLibSensCor(110, 70, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 16 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 18 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 500;
			this.bonusLust = 40;
			this.lust = 30;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 26;
			this.drop = new WeightedDrop().
					add(consumables.BROBREW, 1).
					add(consumables.INCUBID, 12);
			this.gems = rand(30) + 15;
			this.additionalXP = 50;
			this.special1 = cockTripAttack2;
			this.special2 = spoogeAttack2;
			this.tailType = TAIL_TYPE_DEMONIC;
			this.wingType = WING_TYPE_BAT_LIKE_TINY;
			this.wingDesc = "tiny hidden";
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.str += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 33 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 31 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 33 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 5070;
			checkMonster();
		}
	}
}