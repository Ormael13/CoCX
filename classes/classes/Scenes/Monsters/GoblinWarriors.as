/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GoblinWarriors extends Goblin
	{
		public function goblinsDrugAttack():void {
			var temp2:Number = rand(5);
			var multiplier:Number = 6 + player.newGamePlusMod() * 0.5;
			var color:String = "";
			if(temp2 == 0) color = "red";
			if(temp2 == 1) color = "green";
			if(temp2 == 2) color = "blue";
			if(temp2 == 3) color = "white";
			if(temp2 == 4) color = "black";
			//Throw offensive potions at the player
			if(color != "blue") outputText(capitalA + short + " uncorks a glass bottle full of " + color + " fluid and swings thier arms, flinging a wave of fluid at you.");
			//Drink blue pots
			else {
				outputText(capitalA + short + " pulls out a blue vial and uncaps it, swiftly downing its contents.");
				if(HPRatio() < 1) {
					outputText("  They looks to have recovered from some of their wounds!\n");
					addHP((maxHP() / 4) * multiplier);
				}
				else outputText("  There doesn't seem to be any effect.\n");
				return;
			}
			//Dodge chance!
			if(player.getEvasionRoll()) {
				outputText("\nYou narrowly avoid the gush of alchemic fluids!\n");
			}
			else {
				//Get hit!
				if (color == "red") {
					//Temporary heat
					outputText("\nThe red fluids hit you and instantly soak into your skin, disappearing.  Your skin flushes and you feel warm.  Oh no...\n");
					if (!player.hasStatusEffect(StatusEffects.TemporaryHeat)) player.createStatusEffect(StatusEffects.TemporaryHeat, 0, multiplier, 0, 0);
				}
				else if (color == "green") {
					//Green poison
					outputText("\nThe greenish fluids splash over you, making you feel slimy and gross.  Nausea plagues you immediately - you have been poisoned!\n");
					if (!player.hasStatusEffect(StatusEffects.Poison)) player.createStatusEffect(StatusEffects.Poison, 0, multiplier, 0, 0);
				}
				else if (color == "white") {
					//sticky flee prevention
					outputText("\nYou try to avoid it, but it splatters the ground around you with very sticky white fluid, making it difficult to run.  You'll have a hard time escaping now!\n");
					if (!player.hasStatusEffect(StatusEffects.NoFlee)) player.createStatusEffect(StatusEffects.NoFlee, 0, 0, 0, 0);
				}
				else if (color == "black") {
					//Increase fatigue
					outputText("\nThe black fluid splashes all over you and wicks into your skin near-instantly.  It makes you feel tired and drowsy.\n");
					EngineCore.fatigue(15 + rand(30) * multiplier);
				}
			}
			outputText("\n");
		}
		
		public function goblinsTeaseAttack():void {
			var det:Number = rand(3);
			if (det == 0) outputText("Few of " + a + short + " runs their hands along their metal-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" one or two of them asks.");
			if (det == 1) outputText("Few of " + a + short + " grabs their heel and lifts it to head in an amazing display of flexibility despite the armor they're wearing.  They caresses their snatches and gives you a come hither look.");
			if (det == 2) outputText("Few of " + a + short + " bends over, putting on a show and jiggling their heart-shaped ass at you.  Their looks over the shoulder and sucks on their finger, batting their eyelashes.");
			var lustDmg:int = rand(player.lib / 2) + 80;
			player.takeLustDamage(lustDmg, true);
			outputText("  The display distracts you long enough to prevent you from taking advantage of their awkward pose, leaving you more than a little flushed.\n\n");
		}
		
		public function goblinsSlash():void {
			outputText("Goblins charges at you with their swords!  As soon as they approach you, they swings their swords! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid their slashes!");
			}
			else {
				outputText("You fail to dodge and you get hit. ");
				//Get hit
				var damage:int = ((str + weaponAttack) * 5) + rand(100);
				player.takePhysDamage(damage, true);
			}
		}
		
		public function goblinsShieldBash():void {
			outputText("Goblins charges at you with their shields! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid their shield bashes!");
			}
			else {
				outputText("Many of their shields hits you! ");
				//Get hit
				if (rand(100) < 40 && !player.hasPerk(PerkLib.Resolute)) {
					outputText("The impact from the shields has left you with a concussion. <b>You are stunned.</b> ");
					player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				}
				var damage:int = 10 + str + rand(20);
				player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) eAttack();
			if (choice == 1) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) goblinsSlash();
				else goblinsShieldBash();
			}
			if (choice == 2) goblinsSlash();
			if (choice == 3) goblinsTeaseAttack();
			if (choice == 4) goblinsDrugAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.goblinScene.gobboRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.goblinScene.gobboSpecialBeatYaUp();
		}
		
		public function GoblinWarriors()
		{
			this.a = "the ";
			this.short = "goblin warriors";
			this.imageName = "goblinwarrior";
			this.long= "The group is composed of roughly eighteen goblins before you that are slightly taller than most of the goblins and their hair are a deep red hue. Unlike most goblins you've seen, this ones are well armed. The small group wearing a metal breastplate and wielding a shortsword in right hand and a wooden shield in left hand. Between them there is one female goblin that is much taller then rest been almost as tall as typical human, wearing what appears to be snakeskin across her shoulders. You spot an odd patch that reads, \"<i>31st South Warriors Company: Breeding Studs</i>\" on her shoulder.";
			this.plural = true;
			if (player.hasCock()) this.long += "\n\n  They are clearly intent on beating you up just so they can forcibly make you impregnate them, begining with their leader.";
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 44 + rand(7);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "dark green";
			this.hairColor = "red";
			this.hairLength = 4;
			initStrTouSpeInte(175, 250, 170, 172);
			initWisLibSensCor(170, 145, 105, 60);
			this.weaponName = "sword and shield";
			this.weaponVerb = "slash";
			this.weaponAttack = 42;
			this.armorName = "platemail";
			this.armorDef = 36;
			this.armorMDef = 3;
			this.bonusHP = 1200;
			this.bonusLust = 290;
			this.lust = 50;
			this.lustVuln = 0.44;
			this.level = 40;
			this.gems = rand(50) + 75;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					add(consumables.PONAILS,2).
					add(jewelries.POWRRNG,1).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE,
							consumables.HEALHERB,
							consumables.MOONGRASS,
							consumables.SNAKEBANE,
							consumables.IRONWEED,
							consumables.BLADEFERN);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
