package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Forest.Tamani;
import classes.Scenes.Areas.Forest.TamanisDaughters;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Goblin extends Monster
	{
		protected function goblinDrugAttack():void {
			var multiplier:Number = 1; //Higher tier goblins have powerful potions.
			if (this is GoblinShaman) multiplier += 0.4;
			if (this is GoblinWarrior) multiplier += 0.5;
			if (this is Priscilla) multiplier += 1;
			if (this is Tamani) multiplier += (1 + flags[kFLAGS.TAMANI_LVL_UP]);
			if (this is TamanisDaughters) multiplier += (1 + flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP]);
			multiplier += player.newGamePlusMod() * 0.5;
			var color:String;
			if (this is Tamani || this is TamanisDaughters) color = randomChoice("red", "green", "blue", "white", "black");
			else color = randomChoice("red", "green");
			//Throw offensive potions at the player
			if(color != "blue") {
				if(this is TamanisDaughters) outputText("Tamani uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.");
				else outputText(capitalA + short + " uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.");
			}
			//Drink blue pots
			else {
				if(this is TamanisDaughters) {
					outputText("Tamani pulls out a blue vial and uncaps it, then douses the mob with the contents.");
					if(HPRatio() < 1) {
						outputText("  Though less effective than ingesting it, the potion looks to have helped the goblins recover from their wounds!\n");
						addHP(80 * multiplier);
					}
					else outputText("  There doesn't seem to be any effect.\n");
					outputText("\n");
				}
				else {
					outputText(capitalA + short + " pulls out a blue vial and uncaps it, swiftly downing its contents.");
					if(HPRatio() < 1) {
						outputText("  She looks to have recovered from some of her wounds!\n");
						addHP((maxHP() / 4) * multiplier);
						if (this is Tamani) addHP((maxHP() / 4) * multiplier);
					}
					else outputText("  There doesn't seem to be any effect.\n");
				}
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
					EngineCore.fatigue(10 + rand(25) * multiplier);
				}
			}
			if (plural) outputText("\n");
		}
		protected function goblinTeaseAttack():void {
			var det:Number = rand(3);
			if (this is GoblinWarrior) {
				if (det == 0) outputText(capitalA + short + " runs her hands along her metal-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.");
				if (det == 1) outputText(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility despite the armor she's wearing.  She caresses her snatch and gives you a come hither look.");
				if (det == 2) outputText(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.");
			}
			else if (this is GoblinShaman) {
				if (det == 0) outputText(capitalA + short + " runs her hands along her leather-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.");
				if (det == 1) outputText(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility.  She lifts her loincloth and caresses her snatch and gives you a come hither look.");
				if (det == 2) outputText(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.");
			}
			else if (this is Priscilla) {
				if (det == 0) outputText(capitalA + short + " runs her hands along her bone-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.");
				if (det == 1) outputText(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility.  She lifts her loincloth and caresses her snatch and gives you a come hither look.");
				if (det == 2) outputText(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.");
			}
			else { //regular?
				if (det == 0) outputText(capitalA + short + " runs her hands along her leather-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.");
				if (det == 1) outputText(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility.  She caresses her snatch and gives you a come hither look.");
				if (det == 2) outputText(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.");
			}
			var lustDmg:int = rand(player.lib / 10) + 8;
			if (this is GoblinAssassin) lustDmg *= 1.4;
			if (this is GoblinWarrior) lustDmg *= 1.6;
			if (this is GoblinShaman) lustDmg *= 1.6;
			if (this is Priscilla) lustDmg *= 2;
			if (this is Tamani) lustDmg += (1 + flags[kFLAGS.TAMANI_LVL_UP]);
			if (this is TamanisDaughters) lustDmg += (1 + flags[kFLAGS.TAMANI_DAUGHTERS_LVL_UP]);
			player.takeLustDamage(lustDmg, true);
			outputText("  The display distracts you long enough to prevent you from taking advantage of her awkward pose, leaving you more than a little flushed.\n\n");
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.goblinScene.gobboRapeIntro();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She giggles and takes out a tube of lipstick smearing it whorishly on your face.  You pass into unconsciousness immediately.  It must have been drugged.");
				SceneLib.combat.cleanupAfterCombatImpl();
			} else if (pcCameWorms) {
				outputText("\n\nThe goblin's eyes go wide and she turns to leave, no longer interested in you.");
				player.orgasm();
				doNext(SceneLib.combat.cleanupAfterCombatImpl);
			} else {
				SceneLib.goblinScene.goblinRapesPlayer();
			}
		}

		public function Goblin(noInit:Boolean=false)
		{
			if (noInit) return;
			this.a = "the ";
			this.short = "goblin";
			this.imageName = "goblin";
			this.long = "The goblin before you is a typical example of her species, with dark green skin, pointed ears, and purple hair that would look more at home on a punk-rocker.  She's only about three feet tall, but makes up for it with her curvy body, sporting hips and breasts that would entice any of the men in your village were she full-size.  There isn't a single scrap of clothing on her, just lewd leather straps and a few clinking pouches.  She does sport quite a lot of piercings – the most noticeable being large studs hanging from her purple nipples.  Her eyes are fiery red, and practically glow with lust.  This one isn't going to be satisfied until she has her way with you.  It shouldn't be too hard to subdue such a little creature, right?";
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 35 + rand(4);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "dark green";
			this.hairColor = "purple";
			this.hairLength = 4;
			initStrTouSpeInte(14, 17, 30, 38);
			initWisLibSensCor(38, 45, 45, 20);
			this.weaponName = "fists";
			this.weaponVerb = "tiny punch";
			this.weaponAttack = 1;
			this.armorName = "leather straps";
			this.armorDef = 1;
			this.armorMDef = 0;
			this.bonusLust = 92;
			this.lust = 50;
			this.level = 2;
			this.gems = rand(5) + 5;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					add(consumables.PONAILS,2).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.PURPDYE,
							consumables.HEALHERB,
							consumables.MOONGRASS,
							consumables.SNAKEBANE,
							consumables.IRONWEED,
							consumables.BLADEFERN);
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: goblinDrugAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[TAG_FLUID]},
				{ call: goblinTeaseAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
			];
			this.createPerk(PerkLib.EnemyForBeginnersType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
