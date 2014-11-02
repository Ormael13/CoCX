package classes.Scenes.Dungeons.Factory
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armors.LustyMaidensArmor;
	import classes.Scenes.Dungeons.Factory;
	import classes.Scenes.Dungeons.LethiceCastle;
	import classes.internals.*;
	import flash.display.InteractiveObject;
	import classes.GlobalFlags.kFLAGS;

	public class IncubusMechanic extends Monster 
	{
		public var factory:Factory = new Factory()
		private var temp:Number = 0;
		
		public function cocktripAttack():void {
			//Blind dodge change
			if(findStatusAffect(StatusAffects.Blind) >= 0) {
				outputText(capitalA + short + " suddenly grows his dick to obscene lengths and tries to trip you with it.  Thankfully he's so blind he wasn't aiming anywhere near you!");
				combatRoundOver();
				return;
			}
			outputText("The incubus lunges forward in a clumsy attack that you start to side-step, only to feel something grip behind your " + player.buttDescript() + " and pull your  " + player.legs() + " out from under you.");
			if((player.spe-30) > rand(60)) {
				outputText("  You spin as you fall, twisting your " + player.legs() + " free and springing back to your " + player.feet() + " unharmed.", false);
			}
			//Fall down go boom
			else {
				outputText("  You land hard on your ass, momentarily stunned as the demonic cock-tentacle curls around your " + player.legs() + ", smearing them with oozing demonic fluids. ");
				if(player.lust >= 80 || player.cor >= 80) {
					outputText("  Moaning with desire, you lick your lips as you slide your well-lubricated " + player.legs() + " free.  You gather a dollop of cum and lick it seductively, winking at the incubus and hoping to make him cave into his desire. ");
					game.dynStats("lus", 13, "cor", 1);
					if (flags[kFLAGS.LETHICE_CASTLE_INCUBUS_GREETED] > 0) game.dynStats("lus", 10);
				}
				else {
					if(player.lust >= 50 || player.cor >= 50) {
						outputText("  Blushing at the scent and feel of cum on your " + player.legs() + ", you twist and pull free.  You find yourself wondering what this demon's dick would taste like. ");
						game.dynStats("lus", 8 + player.cor / 20);
						if (flags[kFLAGS.LETHICE_CASTLE_INCUBUS_GREETED] > 0) game.dynStats("lus", 15);
						
					}
					else {
						outputText("  Disgusted, you pull away from the purplish monstrosity, the act made easier by your well-slimed " + player.legs() + ". ");
						game.dynStats("lus", 5 + player.cor / 20);
						if (flags[kFLAGS.LETHICE_CASTLE_INCUBUS_GREETED] > 0) game.dynStats("lus", 15);
					}
				}
				var damage:Number = 5;
				player.takeDamage(damage, true);
			}
			outputText("\nThe incubus gives an overconfident smile as his cock retracts away from you, returning to its normal size.", false);
			combatRoundOver();
		}
		
		public function cumCannon():void {
			trace("Cum cannon");
			//Blind dodge change
			if(findStatusAffect(StatusAffects.Blind) >= 0) {
				outputText(capitalA + short + " pumps his thrust lewdly before cumming with intense force in your direction!  Thankfully his aim was off due to the blindness currently affect him.", false);
				combatRoundOver();
				return;
			}
			outputText("Your demonic foe places his hands behind his head and lewdly pumps and thrusts his hips at you.  Your eyes open wide as a globule of cum erupts from the demon-prick and flies right at you.  ", false);
			if (player.weaponName == "dragon-shell shield" && rand(2) == 0)
			{
				outputText("Your shield managed to absorb the attack!")
				combatRoundOver();
				return;
			}
			outputText("You do your best to dodge, but some still lands on your ", false);
			temp = rand(3);
			//Face
			if(temp == 0) {
				outputText("face.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your mouth and nose!  You can feel it moving around inside you, doing its best to prepare you for its master.", false);
				game.dynStats("lus", 3);
				if(player.findStatusAffect(StatusAffects.DemonSeed) < 0) player.createStatusAffect(StatusAffects.DemonSeed,5,0,0,0);
				else player.addStatusValue(StatusAffects.DemonSeed,1,7);
				player.slimeFeed();
			}
			//Chest
			if(temp == 1) {
				if(player.hasFuckableNipples()) {
					outputText(allBreastsDescript() + ".  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your open nipples.  You can feel it moving around inside you, doing its best to prepare you for its master.", false);
					game.dynStats("lus", 3);
					if (flags[kFLAGS.LETHICE_CASTLE_INCUBUS_GREETED] > 0) game.dynStats("lus", 15);
					if(player.findStatusAffect(StatusAffects.DemonSeed) < 0) player.createStatusAffect(StatusAffects.DemonSeed,5,0,0,0);
					else player.addStatusValue(StatusAffects.DemonSeed,1,8);
					player.slimeFeed();
				}
				else outputText(allBreastsDescript() + ".  Thankfully it doesn't seem to have much effect.", false);
			}
			//Crotch
			if(temp == 2) {
				if(player.vaginas.length > 0) {
					outputText("crotch.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way past your " + player.armorName + " and into your " + player.vaginaDescript() + ".  You can feel it moving around inside you, doing its best to prepare you for its master.", false);
					game.dynStats("lus", 3);
					if (flags[kFLAGS.LETHICE_CASTLE_INCUBUS_GREETED] > 0) game.dynStats("lus", 15);
					if(player.findStatusAffect(StatusAffects.DemonSeed) < 0) player.createStatusAffect(StatusAffects.DemonSeed,5,0,0,0);
					else player.addStatusValue(StatusAffects.DemonSeed,1,8);
					player.slimeFeed();
				}
				else outputText("crotch.  Thankfully, it doesn't seem to have much effect.", false);
			}
			combatRoundOver();
			lust -= 10;
			if(lust < 0) lust = 0;
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.D3_DISCOVERED] == 0)
			{
				defeatedInDungeon1(hpVictory);
			}
			else
			{
				defeatedInDungeon3(hpVictory);
			}
		}
		
		private function defeatedInDungeon1(hpVictory:Boolean):void
		{
			if(player.gender == 0) {
				if (hpVictory){
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to test his demonic tool...\n\nHow do you want to handle him?", true);
				} 
				else {
					outputText("You smile in satisfaction as the " + short + " collapses, masturbating happily.  Now would be the perfect opportunity to test his demonic tool...\n\nHow do you want to handle him?", true);
				}
				game.simpleChoices("Anally", factory.doRideIncubusAnally, "Orally", factory.doOralIncubus, "", 0, "", 0, "Leave", factory.doLeaveIncubus);
			}
			else {
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to put his tool to use...\n\nWhat do you do, rape him, service him, or let him take you anally?", true);
					game.dynStats("lus", 1);
					game.simpleChoices("Rape", factory.doRapeIncubus, "Service Him", factory.doOralIncubus, "Anal", factory.doRideIncubusAnally, "Nothing", factory.doLeaveIncubus, "", 0);
				} 
				else {
					outputText("You smile in satisfaction as the " + short + " collapses, masturbating happily.  Now would be the perfect opportunity to put his tool to use...\n\nWhat do you do?", true);
					var temp2:Function = null;
					if(player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor") temp2 = game.createCallBackFunction2((player.armor as LustyMaidensArmor).lustyMaidenPaizuri,player,this);
					game.dynStats("lus", 1);
					game.simpleChoices("Rape", factory.doRapeIncubus, "Service Him", factory.doOralIncubus, "Anal", factory.doRideIncubusAnally, "B.Titfuck", temp2, "Nothing", factory.doLeaveIncubus)
				}
			}
			else {
				game.dungeons.lethicecastle.incubusMechanic.incubusDefeated();
			}
		}
		
		private function defeatedInDungeon3(hpVictory:Boolean):void
		{
			game.d3.incubusMechanic.beatDaMechanic(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.D3_DISCOVERED] == 0)
			{
				wonInDungeon1(hpVictory, pcCameWorms);
			}
			else
			{
				wonInDungeon3(hpVictory, pcCameWorms);
			}
		}
		
		private function wonInDungeon1(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(game.endLustLoss);
			} else {
				game.dungeons.factory.doLossIncubus();
			}
		}
		
		private function wonInDungeon3(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.d3.incubusMechanic.mechanicFuckedYouUp(hpVictory, pcCameWorms);
		}

		public function IncubusMechanic() {
			this.a = "the ";
			this.short = "incubus mechanic";
			this.imageName = "incubusmechanic";
			this.long = "The demon before you is clad only in cut-off denim overalls.  Covered in stains of oil and other strange fluids, they appear to be in pretty rough shape.  There is a large hole ripped in the crotch, allowing the demon's foot-long member to hang free.  His skin is light purple and perfect, contrasting with the slovenly appearance of his clothing.  His face is rugged and handsome, topped with a simple black ponytail and two large horns that sprout from his forehead like twisted tree-trunks.  He wears a narrow goatee on his chin that is kept skillfully braided.  A cocky smile always seems to grace his features, giving him an air of supreme confidence.";
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
			initStrTouSpeInte(65, 40, 45, 85);
			initLibSensCor(80, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 10;
			this.bonusHP = 150;
			this.lust = 50;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 8;
			this.drop = new WeightedDrop(consumables.GROPLUS, 1);
			this.gems = rand(25)+10;
			this.special1 = cocktripAttack;
			this.special2 = cumCannon;
			this.tailType = TAIL_TYPE_DEMONIC;
			this.wingType = WING_TYPE_BAT_LIKE_TINY;
			this.wingDesc = "tiny hidden";
			checkMonster();
		}
	}
}