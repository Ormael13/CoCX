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

public class GoblinAdventurers extends Monster
	{
		override protected function outputPlayerDodged(dodge:int):void{
			var pRdm:Number = rand(3);
			switch(pRdm){
				case 0:
					outputText("\nYou narrowly avoid the gush of alchemic fluids!\n");
					break;
				case 1:
					outputText("With a swift step, one of adventurers vanishes, her movements too quick for you to follow. You take a sharp breath as you feel her ample thighs clench your head in between them, her slick cunt in full view as you take in her scent.\nYou’ve already prepared, however, as you hold your breath and grab the goblin by her sides. Unhindered by her advance, you take the opportunity to move backwards, throwing the goblin off balance and leaving you only faintly smelling of her pussy.");
					player.takeLustDamage(rand(player.lib/10)+4, true);
					break;
				case 2:
					outputText("Three adventurers throws a syringe onto the ground, shattering it and allowing the dissipating smoke from its contents to distract you long enough for them to slip underneath you or to your sides. With a quick flick of wrists two needles are placed into their hands, though you’ve already caught wind of their movements.\nYou jump backwards, far enough to avoid quick thrust upwards as the middle one attempts to lick the area in which your crotch once stood. Realising situation, they quickly remove themselves from the ground and faces you, more determined than before.");
					break;
			}
		}
		protected function goblinDrugAttack():void {
			var color:String = randomChoice("red", "green", "blue", "white", "black");
			var multiplier:Number = 4 + player.newGamePlusMod() * 0.5;
			//Throw offensive potions at the player
			if (color != "blue") {
				outputText("Few of " + a + short + " uncorks a glass bottle full of " + color + " fluid and swings their arms, flinging a wave of fluid at you.");
			}
			//Drink blue pots
			else {
				outputText("Few of " + a + short + " pull out a blue vial and uncaps it, swiftly downing its contents.");
				if(HPRatio() < 1) {
					outputText("  They looks to have recovered from some of their wounds!\n");
					addHP(maxHP() / 10 * multiplier);
				}
				else outputText("  There doesn't seem to be any effect.\n");
			}
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
					EngineCore.fatigue(30 + rand(30) * multiplier);
				}
		}
		//Lust Needle
		protected function lustNeedle():void {
			outputText("With a swift step, one of adventurers vanishes, her movements too quick for you to follow. You take a sharp breath as you feel her ample thighs clench your head in between them, her slick cunt in full view as you take in her scent.");
			outputText("\nYou’re far too distracted to notice few needle injected into your back and neck, but by the time she flips back into her original position you already feel the contents of the syringe beginning to take effect.");
			player.takeLustDamage(rand(player.lib)+50, true);
		}
		//Dual Shot
		protected function dualShot():void {
			outputText("Three adventurers throws a syringe onto the ground, shattering it and allowing the dissipating smoke from its contents to distract you long enough for them to slip underneath you or to your sides. With a quick flick of wrists two needles are placed into their hands, though you’ve already caught wind of their movements.");

				outputText("\nBefore you can do anything to stop them, the middle one lifts her head and takes a swift lick of your crotch, taking a small moan from you and giving her, and her two companions, enough time to stab into the back of your knees. They all rolls out of the way just as you pluck the needles out and throw them back to the ground. They didn’t seem to have anything in them, but the pain is enough to make you stagger. ");
				//(Medium HP loss, small lust gain)
				var damage:int = int(str + weaponAttack + 40);
				damage *= 3;
				damage -= rand(player.tou);
				damage -= player.armorDef;
				damage = player.takePhysDamage(damage, true);
		}
		//Explosion
		protected function goblinExplosion():void {
			outputText("Without a second thought, few of the adventurers pulls a thin needle from the belt wrapped around their chest and strikes them against the ground, causing a flame to erupt on the tip. They twirl forward, launching the needle in your direction which subsequently bursts apart and showers you with heat.");
			outputText("\nYou shield yourself from the explosion, though the goblins has already lit a second one needles which they throws behind you, launching your body forwards as they explode behind your back. ");
			//(High HP loss, no lust gain)
			var damage:int = 50 + rand(50);
			damage *= 5;
			damage = Math.round(damage);
			damage = player.takeFireDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			var actions:Array = [eAttack,goblinDrugAttack,lustNeedle,dualShot,goblinExplosion];
			actions[rand(actions.length)]();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.goblinScene.gobboRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.goblinScene.gobboSpecialBeatYaUp();
		}
		
		public function GoblinAdventurers()
		{
			this.a = "the ";
			this.short = "goblin adventurers";
			this.imageName = "goblinassassin";
			this.long = "Their appearances are those of a regular goblin, curvy and pale green, perhaps slightly taller than the norm. Their wavy, untamed hair is a deep shade of blue, covering their pierced ears and reaching just above shoulders. Soft curves are accentuated by their choice of wear, a single belt lined with assorted needles strapped across full chest and a pair of fishnet stockings reaching up to thick thighs. They bounces on the spot, preparing to dodge anything you might have in store, though your eyes seem to wander towards their bare slits and jiggling asses. Despite obvious knowledge in combat, they’re a goblins all the same – a hard cock can go a long way.";
			this.plural = true;
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
			initStrTouSpeInte(60, 77, 125, 100);
			initWisLibSensCor(100, 74, 35, 60);
			this.weaponName = "needles";
			this.weaponVerb = "stabbing needles";
			this.weaponAttack = 2;
			this.armorName = "leather straps";
			this.armorDef = 1;
			this.armorMDef = 1;
			this.bonusHP = 70;
			this.bonusLust = 130;
			this.lust = 50;
			this.level = 21;
			this.gems = rand(50) + 50;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE, 5).
					add(consumables.PONAILS, 3).
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
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
