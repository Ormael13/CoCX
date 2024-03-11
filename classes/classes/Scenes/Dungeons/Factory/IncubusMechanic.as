package classes.Scenes.Dungeons.Factory
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class IncubusMechanic extends Monster {
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (DungeonAbstractContent.dungeonLoc == DungeonAbstractContent.DUNGEON_FACTORY_FURNACE_ROOM) SceneLib.dungeons.factory.incubusMechanicDefeated(hpVictory);
			else SceneLib.d3.incubusMechanic.beatDaMechanic(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (DungeonAbstractContent.dungeonLoc == DungeonAbstractContent.DUNGEON_FACTORY_FURNACE_ROOM)
				wonInDungeon1(hpVictory, pcCameWorms);
			else
				wonInDungeon3(hpVictory, pcCameWorms);
		}
		
		private function wonInDungeon1(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.dungeons.factory.doLossIncubus();
			}
		}
		
		private function wonInDungeon3(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.isGargoyle()) SceneLib.d3.gargoyleBadEndD3();
			else {
				if (flags[kFLAGS.LETHICE_DEFEATED] > 0) SceneLib.dungeons.factory.doLossIncubus();
				else SceneLib.d3.incubusMechanic.mechanicFuckedYouUp(hpVictory, pcCameWorms);
			}
		}

		private function cockTripAttack():void {
			if (hasStatusEffect(StatusEffects.Blind)) { //Blind dodge change
				outputText(capitalA + short + " suddenly grows it's dick to obscene lengths and tries to trip you with it.  Thankfully he's so blind he wasn't aiming anywhere near you!");
				return;
			}
			outputText("The incubus lunges forward in a clumsy attack that you start to side-step, only to feel something grip behind your " + Appearance.buttDescription(player) + " and pull your [legs] out from under you.");
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
					player.takeLustDamage(8 + player.cor / 20, true);
				}
				else {
					outputText("  Disgusted, you pull away from the purplish monstrosity, the act made easier by your well-slimed [legs].");
					player.takeLustDamage(5 + player.cor / 20, true);
				}
				player.takePhysDamage(5);
			}
			outputText("\nThe incubus gives an overconfident smile as his cock retracts away from you, returning to its normal size.");
		}
		
		private function spoogeAttack():void {
			if (hasStatusEffect(StatusEffects.Blind)) { //Blind dodge change
				outputText(capitalA + short + " pumps and thrusts his hips lewdly before cumming with intense force in your direction!  Thankfully his aim was off due to the blindness currently affect him.");
				return;
			}
			outputText("Your demonic foe places his hands behind his head and lewdly pumps and thrusts his hips at you.  Your eyes open wide as a globule of cum erupts from the demon-prick and flies right at you.  ");
			if (player.shield == game.shields.DRGNSHL && rand(2) == 0)
			{
				outputText("Your shield managed to absorb the attack!");
				return;
			}
			outputText("You do your best to dodge, but some still lands on your ");
			switch (rand(3)) {
				case 0: //Face
					outputText("face.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your mouth and nose!  You can feel it moving around inside you, doing its best to prepare you for its master.");
					player.takeLustDamage(3, true);
					if (!player.hasStatusEffect(StatusEffects.DemonSeed))
						player.createStatusEffect(StatusEffects.DemonSeed, 5, 0, 0, 0);
					else player.addStatusValue(StatusEffects.DemonSeed, 1, 7);
					player.slimeFeed();
					break;
				case 1: //Chest
					if (player.hasFuckableNipples()) {
						outputText(allBreastsDescript() + ".  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your open nipples.  You can feel it moving around inside you, doing its best to prepare you for its master.");
						player.takeLustDamage(3, true);
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
						player.takeLustDamage(3, true);
						if (!player.hasStatusEffect(StatusEffects.DemonSeed))
							player.createStatusEffect(StatusEffects.DemonSeed, 5, 0, 0, 0);
						else player.addStatusValue(StatusEffects.DemonSeed, 1, 8);
						player.slimeFeed();
					}
					else outputText("crotch.  Thankfully, it doesn't seem to have much effect.");
			}
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
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_TIGHT;
			this.lowerBody = LowerBody.DEMONIC_CLAWS;
			this.bodyColor = "light purple";
			this.hairColor = "black";
			this.hairLength = 12;
			initStrTouSpeInte(95, 65, 51, 85);
			initWisLibSensCor(85, 85, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 14;
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 15;
			this.armorMDef = 3;
			this.bonusHP = 370;
			this.bonusLust = 173;
			this.lust = 50;
			this.lustVuln = .5;
			this.level = 18;
			this.drop = new WeightedDrop(consumables.GROPLUS, 1);
			this.gems = rand(25) + 20;
			this.additionalXP = 100;
			if (flags[kFLAGS.D3_MECHANIC_LAST_GREET] > 0) {
				this.gems += rand(20) + 100;
				this.additionalXP += 500;
				this.level += 50;
				this.bonusLust += 50;
				this.bonusHP += 1200 + (120 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.strStat.core.value += 120 + (24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.touStat.core.value += 120 + (24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.speStat.core.value += 85 + (17 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.intStat.core.value += 80 + (16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.weaponAttack += 20;
				this.armorDef += 15;
				this.armorMDef += 3;
				this.HP = maxOverHP();
				this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			}
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: cockTripAttack, type: ABILITY_TEASE, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: spoogeAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[TAG_FLUID]},
			];
			this.tailType = Tail.DEMONIC;
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			if (flags[kFLAGS.D3_MECHANIC_LAST_GREET] > 0) this.createPerk(PerkLib.OverMaxHP, 68, 0, 0, 0);
			else this.createPerk(PerkLib.OverMaxHP, 18, 0, 0, 0);
			checkMonster();
		}
	}
}
