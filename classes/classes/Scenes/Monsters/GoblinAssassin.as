﻿package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GoblinAssassin extends Monster
	{
		
		protected function goblinDrugAttack():void {
			var color:String = randomChoice("red", "green", "blue", "white", "black");
			var multiplier:Number = 1.2 + 0.5 * newGamePlusMod();
			//Throw offensive potions at the player
			if (color != "blue") {
				outputText(capitalA + short + " uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.");
			}
			//Drink blue pots
			else {
				outputText(capitalA + short + " pulls out a blue vial and uncaps it, swiftly downing its contents.");
				if(HPRatio() < 1) {
					outputText("  She looks to have recovered from some of her wounds!\n");
					addHP(maxHP() / 4 * multiplier);
				}
				else outputText("  There doesn't seem to be any effect.\n");
			}
			//Dodge chance!
			if(player.getEvasionRoll()) {
				outputText("\nYou narrowly avoid the gush of alchemic fluids!\n");
			} else {
				//Get hit!
				//Temporary heat
				if (color == "red") {
					outputText("\nThe red fluids hit you and instantly soak into your skin, disappearing.  Your skin flushes and you feel warm.  Oh no...\n");
					if (!player.hasStatusEffect(StatusEffects.TemporaryHeat)) player.createStatusEffect(StatusEffects.TemporaryHeat, 0, multiplier, 0, 0);
				}
				//Green poison
				if (color == "green") {
					outputText("\nThe greenish fluids splash over you, making you feel slimy and gross.  Nausea plagues you immediately - you have been poisoned!\n");
					if (!player.hasStatusEffect(StatusEffects.Poison)) player.createStatusEffect(StatusEffects.Poison, 0, multiplier, 0, 0);
				}
				//sticky flee prevention
				if (color == "white") {
					outputText("\nYou try to avoid it, but it splatters the ground around you with very sticky white fluid, making it difficult to run.  You'll have a hard time escaping now!\n");
					if (!player.hasStatusEffect(StatusEffects.NoFlee)) player.createStatusEffect(StatusEffects.NoFlee, 0, 0, 0, 0);
				}
				//Increase fatigue
				if (color == "black") {
					outputText("\nThe black fluid splashes all over you and wicks into your skin near-instantly.  It makes you feel tired and drowsy.\n");
					EngineCore.fatigue(10 + rand(25) * multiplier);
				}
			}
		}
		//Lust Needle
		protected function lustNeedle():void {
			outputText("With a swift step, the assassin vanishes, her movements too quick for you to follow. You take a sharp breath as you feel her ample thighs clench your head in between them, her slick cunt in full view as you take in her scent.");
			//Miss
			if (player.getEvasionRoll())
			{
				//Miss:
				outputText("\nYou’ve already prepared, however, as you hold your breath and grab the goblin by her sides. Unhindered by her advance, you take the opportunity to move backwards, throwing the goblin off balance and leaving you only faintly smelling of her pussy.");
				player.takeLustDamage(rand(player.lib/10)+4, true);
			}
			//Hit:
			else
			{
				outputText("\nYou’re far too distracted to notice the needle injected into the back of your neck, but by the time she flips back into her original position you already feel the contents of the syringe beginning to take effect.");
				player.takeLustDamage(rand(player.lib/4)+20, true);
			}
		}
		//Dual Shot
		protected function dualShot():void {
			outputText("The assassin throws a syringe onto the ground, shattering it and allowing the dissipating smoke from its contents to distract you long enough for her to slip underneath you. With a quick flick of her wrists two needles are placed into her hands, though you’ve already caught wind of her movements.");
			//Miss:
			if (player.getEvasionRoll())
			{
				outputText("\nYou jump backwards, far enough to avoid her quick thrust upwards as she attempts to lick the area in which your crotch once stood. Realising her situation, she quickly removes herself from the ground and faces you, more determined than before.");
			}
			//Hit:
			else {
				outputText("\nBefore you can do anything to stop her, she lifts her head and takes a swift lick of your crotch, taking a small moan from you and giving her enough time to stab into the back of your knees. She rolls out of the way just as you pluck the two needles out and throw them back to the ground. They didn’t seem to have anything in them, but the pain is enough to make you stagger. ");
				//(Medium HP loss, small lust gain)
				var damage:int = int((str + weaponAttack + 40) - rand(player.tou) - player.armorDef);
				player.takePhysDamage(damage, true);
			}
		}
		//Explosion
		protected function goblinExplosion():void {
			outputText("Without a second thought, the assassin pulls a thin needle from the belt wrapped around her chest and strikes it against the ground, causing a flame to erupt on the tip. She twirls forward, launching the needle in your direction which subsequently bursts apart and showers you with heat.");
			outputText("\nYou shield yourself from the explosion, though the goblin has already lit a second needle which she throws behind you, launching your body forwards as it explodes behind your back. ");
			//(High HP loss, no lust gain)
			var damage:int = 25 + rand(75);
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
		}
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArenaGauntlet)) SceneLib.hexindao.gauntletchallange2fight2();
			else SceneLib.goblinScene.gobboRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.goblinScene.gobboSpecialBeatYaUp();
		}
		public function GoblinAssassin(noInit:Boolean=false)
		{
			if (noInit) return;
			this.a = "the ";
			if (player.hasStatusEffect(StatusEffects.SoulArenaGauntlet)) {
				this.short = "goblin adventurer";
				this.level = 9;
				this.bonusHP = 70;
				this.bonusLust = 108;
			}
			else {
				this.short = "goblin assassin";
				this.level = 8;
				this.bonusHP = 100;
				this.bonusLust = 107;
			}
			this.imageName = "goblinAssassin";
			this.long = "Her appearance is that of a regular goblin, curvy and pale green, perhaps slightly taller than the norm. Her wavy, untamed hair is a deep shade of blue, covering her pierced ears and reaching just above her shoulders. Her soft curves are accentuated by her choice of wear, a single belt lined with assorted needles strapped across her full chest and a pair of fishnet stockings reaching up to her thick thighs. She bounces on the spot, preparing to dodge anything you might have in store, though your eyes seem to wander towards her bare slit and jiggling ass. Despite her obvious knowledge in combat, she’s a goblin all the same – a hard cock can go a long way.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 90, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,50,0,0,0);
			this.tallness = 35 + rand(4);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "dark green";
			this.hairColor = "blue";
			this.hairLength = 7;
			initStrTouSpeInte(45, 45, 110, 95);
			initWisLibSensCor(95, 64, 35, 20);
			this.weaponName = "needles";
			this.weaponVerb = "stabbing needles";
			this.weaponAttack = 2;
			this.armorName = "leather straps";
			this.armorDef = 1;
			this.armorMDef = 1;
			this.lust = 50;
			this.gems = rand(50) + 25;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE, 5).
					add(consumables.PONAILS,2).
					addMany(1, consumables.L_DRAFT,
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
				{ call: dualShot, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[TAG_WEAPON]},
				{ call: goblinExplosion, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_FIRE]},
				{ call: lustNeedle, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[TAG_WEAPON]},
			];
			checkMonster();
		}

	}
}
