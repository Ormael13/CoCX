/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Beach 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.Scenes.Areas.Desert.NagaScene;
import classes.internals.*;

public class Gorgon extends Monster
	{
		public var nagaScene:NagaScene = new NagaScene(true);
		
		override public function defeated(hpVictory:Boolean):void
		{
			nagaScene.nagaRapeChoice();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe gorgon's eyes go wide and she turns to leave, no longer interested in you.");
				player.orgasm();
				doNext(cleanupAfterCombat);
			} else {
				nagaScene.nagaFUCKSJOOOOOO();
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) eAttack();
			if (choice == 1) gorgonPoisonBiteAttack();
			if (choice == 2) {
				if (player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.Stunned)) TailWhip();
				else gorgonConstrict();
			}
			if (choice == 3) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) eAttack();
				else if (player.hasStatusEffect(StatusEffects.NagaBind)) gorgonPoisonBiteAttack();
				else TailWhip();
			}
			if (choice == 4) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) eAttack();
				else if (player.hasStatusEffect(StatusEffects.NagaBind)) {
					if (rand(2) == 0) gorgonPoisonBiteAttack();
					else TailWhip();
				}
				else {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) {
						if (rand(2) == 0) gorgonPoisonBiteAttack();
						else TailWhip();
					}
					else {
						if (hasStatusEffect(StatusEffects.Blind)) eAttack();
						else petrify();
					}
				}
			}
		}
		
		public function gorgonPoisonBiteAttack():void {
			//(Deals damage over 4-5 turns, invariably reducing 
			//your speed. It wears off once combat is over.)
			outputText("The " + this.short + " strikes with the speed of a cobra, sinking her fangs into your flesh!  ");
			if(!player.hasStatusEffect(StatusEffects.NagaVenom)) {
				outputText("The venom's effects are almost instantaneous; your vision begins to blur and it becomes increasingly harder to stand.");
				if(player.spe > 6) {
					player.spe -= 5;
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.createStatusEffect(StatusEffects.NagaVenom,5,0,0,0);
				}
				else {
					player.createStatusEffect(StatusEffects.NagaVenom,0,0,0,0);
					player.takePhysDamage(15+rand(15));
				}
				player.takePhysDamage(15+rand(15));
			}
			else {
				outputText("The venom's effects intensify as your vision begins to blur and it becomes increasingly harder to stand.");
				if(player.spe > 5) {
					//stats(0,0,-2,0,0,0,0,0);
					player.spe -= 4;
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.addStatusValue(StatusEffects.NagaVenom,1,4);
				}
				else player.takePhysDamage(15+rand(15));
				player.takePhysDamage(15+rand(15));
			}
		}
		
		public function gorgonConstrict():void {
			outputText("The " + this.short + " draws close and suddenly wraps herself around you, binding you in place! You can't help but feel strangely aroused by the sensation of her scales rubbing against your body. All you can do is struggle as she begins to squeeze tighter!");
			player.createStatusEffect(StatusEffects.NagaBind,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takePhysDamage(4+rand(8));
			}
		}
		
		public function TailWhip():void {
			outputText("The gorgon tenses and twists herself forcefully.  ");
			//[if evaded]
			if((player.findPerk(PerkLib.Evade) && rand(6) == 0)) {
				outputText("You see her tail whipping toward you and evade it at the last second. You quickly roll back onto your feet.");
			}
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s tail-whip.");
			}
			else if(player.spe > rand(300)) {
				outputText("You see her tail whipping toward you and jump out of the way at the last second. You quickly roll back onto your feet.");
			}
			else {
				outputText("Before you can even think, you feel a sharp pain at your side as the gorgon's tail slams into you and shoves you into the sands. You pick yourself up, wincing at the pain in your side. ");
				var damage:Number = str;
				if(player.armorDef < 50) damage += 50 - player.armorDef;
				damage += rand(25);
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function petrify():void {
			outputText("With a moment of concentration she awakens normaly dormant snake hair that starts to hiss and then casual glance at you. Much to your suprise you noticing your fingers then hands starting to pertify... ");
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
			if (player.hasStatusEffect(StatusEffects.NagaBind)) player.removeStatusEffect(StatusEffects.NagaBind);
		}
		
		public function Gorgon() 
		{
			this.a = "the ";
			this.short = "gorgon";
			this.imageName = "gorgon";
			this.long = "You are fighting a gorgon. She resembles a slender woman from the waist up, with green scale covered hair hanging down to her neck. Her whole body is covered with shiny green scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round D-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 60, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 6*12+2;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.NAGA;
			this.skin.growCoat(Skin.SCALES,{color:"green"});
			this.hairColor = "green";
			this.hairLength = 16;
			initStrTouSpeInte(91, 125, 110, 75);
			initWisLibSensCor(75, 72, 55, 40);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 31;
			this.armorName = "scales";
			this.armorDef = 31;
			this.bonusHP = 500;
			this.bonusLust = 10;
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 24;
			this.gems = rand(16) + 30;
			this.drop = new WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,5).
					add(consumables.GORGOIL,4);
			this.faceType = Face.SNAKE_FANGS;
			checkMonster();
		}
		
	}

}