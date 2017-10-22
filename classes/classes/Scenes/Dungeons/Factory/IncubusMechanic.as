package classes.Scenes.Dungeons.Factory
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armors.LustyMaidensArmor;
import classes.internals.*;

public class IncubusMechanic extends Monster {
		
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
		
		private function defeatedInDungeon1(hpVictory:Boolean):void {
			clearOutput();
			EngineCore.menu();
			if (hpVictory)
				outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.");
			else outputText("You smile in satisfaction as the " + short + " collapses, masturbating happily.");
			if (player.gender == 0) {
				outputText("  Now would be the perfect opportunity to test his demonic tool...\n\nHow do you want to handle him?");
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && flags[kFLAGS.FACTORY_INCUBUS_BRIBED] == 0) outputText("\n\n<b>You swear you can hear a clicking sound coming from the west.</b>");
				EngineCore.addButton(0, "Anally", game.dungeons.factory.doRideIncubusAnally).hint("Ride him anally.");
				EngineCore.addButton(1, "Orally", game.dungeons.factory.doOralIncubus).hint("Service the incubus orally.");
				EngineCore.addButton(4, "Leave", game.cleanupAfterCombat);
			}
			else {
				player.dynStats("lus", 1);
				if (hpVictory) {
					outputText("  Now would be the perfect opportunity to put his tool to use...\n\nWhat do you do, rape him, service him, or let him take you anally?");
					if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && flags[kFLAGS.FACTORY_INCUBUS_BRIBED] == 0) outputText("\n\n<b>You swear you can hear a clicking sound coming from the west.</b>");
				}
				else {
					outputText("  Now would be the perfect opportunity to put his tool to use...\n\nWhat do you do?");
					if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && flags[kFLAGS.FACTORY_INCUBUS_BRIBED] == 0) outputText("\n\n<b>You swear you can hear a clicking sound coming from the west.</b>");
					if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armor == armors.LMARMOR) EngineCore.addButton(3, "B.Titfuck", (player.armor as LustyMaidensArmor).lustyMaidenPaizuri, player, this);
				}
				EngineCore.addButton(0, "Rape", game.dungeons.factory.doRapeIncubus).hint(player.hasCock() ? "Fuck his butt." : "Ride him vaginally.");
				EngineCore.addButton(1, "Service Him", game.dungeons.factory.doOralIncubus).hint("Service the incubus orally.");
				EngineCore.addButton(2, "Anal", game.dungeons.factory.doRideIncubusAnally).hint("Ride him anally.");
				EngineCore.addButton(4, "Nothing", game.cleanupAfterCombat);
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
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) game.dungeons.factory.doLossIncubus();
			else game.d3.incubusMechanic.mechanicFuckedYouUp(hpVictory, pcCameWorms);
		}
		
		private function cockTripAttack():void {
			if (hasStatusEffect(StatusEffects.Blind)) { //Blind dodge change
				outputText(capitalA + short + " suddenly grows it's dick to obscene lengths and tries to trip you with it.  Thankfully he's so blind he wasn't aiming anywhere near you!");
				game.combatRoundOver();
				return;
			}
			outputText("The incubus lunges forward in a clumsy attack that you start to side-step, only to feel something grip behind your " + game.buttDescript() + " and pull your [legs] out from under you.");
			if ((player.spe-30) > rand(60)) {
				outputText("  You spin as you fall, twisting your [legs] free and springing back to your [feet] unharmed.");
			}
			else { //Fall down go boom
				outputText("  You land hard on your ass, momentarily stunned as the demonic cock-tentacle curls around your [legs], smearing them with oozing demonic fluids.");
				if (player.lust >= 80 || player.cor >= 80) {
					outputText("  Moaning with desire, you lick your lips as you slide your well-lubricated [legs] free.  You gather a dollop of cum and lick it seductively, winking at the incubus and hoping to make him cave into his desire.");
					player.dynStats("lus", 13, "cor", 1);
				}
				else if (player.lust >= 50 || player.cor >= 50) {
					outputText("  Blushing at the scent and feel of cum on your [legs], you twist and pull free.  You find yourself wondering what this demon's dick would taste like.");
					player.dynStats("lus", 8 + player.cor / 20);
				}
				else {
					outputText("  Disgusted, you pull away from the purplish monstrosity, the act made easier by your well-slimed [legs].");
					player.dynStats("lus", 5 + player.cor / 20);
				}
				game.combat.takeDamage(5);
			}
			outputText("\nThe incubus gives an overconfident smile as his cock retracts away from you, returning to its normal size.");
			game.combatRoundOver();
		}
		
		private function spoogeAttack():void {
			if (hasStatusEffect(StatusEffects.Blind)) { //Blind dodge change
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
					player.dynStats("lus", 3);
					if (!player.hasStatusEffect(StatusEffects.DemonSeed))
						player.createStatusEffect(StatusEffects.DemonSeed, 5, 0, 0, 0);
					else player.addStatusValue(StatusEffects.DemonSeed, 1, 7);
					player.slimeFeed();
					break;
				case 1: //Chest
					if (player.hasFuckableNipples()) {
						outputText(allBreastsDescript() + ".  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your open nipples.  You can feel it moving around inside you, doing its best to prepare you for its master.");
						player.dynStats("lus", 3);
						if (!player.hasStatusEffect(StatusEffects.DemonSeed))
							player.createStatusEffect(StatusEffects.DemonSeed, 5, 0, 0, 0);
						else player.addStatusValue(StatusEffects.DemonSeed, 1, 8);
						player.slimeFeed();
					}
					else outputText(allBreastsDescript() + ".  Thankfully it doesn't seem to have much effect.");
					break;
				default: //Crotch
					if (player.vaginas.length > 0) {
						outputText("crotch.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way past your [armor] and into your " + player.vaginaDescript(0) + ".  You can feel it moving around inside you, doing its best to prepare you for its master.");
						player.dynStats("lus", 3);
						if (!player.hasStatusEffect(StatusEffects.DemonSeed))
							player.createStatusEffect(StatusEffects.DemonSeed, 5, 0, 0, 0);
						else player.addStatusValue(StatusEffects.DemonSeed, 1, 8);
						player.slimeFeed();
					}
					else outputText("crotch.  Thankfully, it doesn't seem to have much effect.");
			}
			game.combatRoundOver();
			lust -= 10;
			if (lust < 0) lust = 10;
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
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hipRating = AppearanceDefs.HIP_RATING_AMPLE;
			this.buttRating = AppearanceDefs.BUTT_RATING_TIGHT;
			this.lowerBody = AppearanceDefs.LOWER_BODY_TYPE_DEMONIC_CLAWS;
			this.skinTone = "light purple";
			this.hairColor = "black";
			this.hairLength = 12;
			initStrTouSpeInte(95, 60, 45, 85);
			initLibSensCor(80, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 12 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 12 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 350;
			this.bonusLust = 40;
			this.lust = 50;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 14;
			this.drop = new WeightedDrop(consumables.GROPLUS, 1);
			this.gems = rand(25) + 20;
			this.additionalXP = 100;
			if (flags[kFLAGS.D3_MECHANIC_LAST_GREET] > 0) {
				this.gems += rand(30) + 60;
				this.additionalXP += 250;
				this.level += 24;
				this.bonusHP += 600 + (60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.str += 50 + (10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.tou += 50 + (10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.spe += 35 + (7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.inte += 30 + (6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.weaponAttack += 10 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.HP = maxHP();
				this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			}
			this.special1 = cockTripAttack;
			this.special2 = spoogeAttack;
			this.tailType = AppearanceDefs.TAIL_TYPE_DEMONIC;
			this.wingType = AppearanceDefs.WING_TYPE_BAT_LIKE_TINY;
			this.wingDesc = "tiny hidden";
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.str += 19 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 17 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1460;
			checkMonster();
		}
	}
}
