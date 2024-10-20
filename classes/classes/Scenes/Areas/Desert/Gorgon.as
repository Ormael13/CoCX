/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Desert 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Desert.NagaScene;
import classes.Stats.Buff;
import classes.internals.*;

public class Gorgon extends Monster
	{
		public var nagaScene:NagaScene = new NagaScene(true);

		override public function combatStatusesUpdateWhenBound():void{
			nagaBindUpdateWhenBound();
		}

		override public function playerBoundStruggle():Boolean{clearOutput();
			if (rand(3) == 0 || rand(80) < player.str / 1.5 || player.hasPerk(PerkLib.FluidBody)) {
				outputText("You wriggle and squirm violently, tearing yourself out from within [themonster]'s coils.");
				player.removeStatusEffect(StatusEffects.PlayerBoundPhysical);
			} else {
				outputText("The [monster name]'s grip on you tightens as you struggle to break free from the stimulating pressure.");
				player.takeLustDamage(player.effectiveSensitivity() / 10 + 2, true);
				player.takePhysDamage(17 + rand(15));
			}
			return true;
		}

		override public function playerBoundWait():Boolean{
			return nagaBindWait();
		}

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
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical) || player.hasStatusEffect(StatusEffects.Stunned)) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) {
					if (rand(2) == 0) eAttack();
					else TailWhip();
				}
				else {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) gorgonPoisonBiteAttack();
					else {
						if (hasStatusEffect(StatusEffects.Blind)) eAttack();
						else petrify();
					}
				}
			}
			else {
				var choice:Number = rand(5);
				if (choice == 0) eAttack();
				if (choice == 1) gorgonPoisonBiteAttack();
				if (choice == 2) gorgonConstrict();
				if (choice == 3) TailWhip();
				if (choice == 4) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) gorgonConstrict();
					else if (hasStatusEffect(StatusEffects.Blind)) eAttack();
					else petrify();
				}
			}
		}
		
		public function gorgonPoisonBiteAttack():void {
			//(Deals damage over 4-5 turns, invariably reducing 
			//your speed. It wears off once combat is over.)
			outputText("The " + this.short + " strikes with the speed of a cobra, sinking her fangs into your flesh!  ");
			if(!player.hasStatusEffect(StatusEffects.NagaVenom)) {
				outputText("The venom's effects are almost instantaneous; your vision begins to blur and it becomes increasingly harder to stand.");
				if(player.spe > 8) {
					player.buff("Poison").addStats({"spe":-7}).withText("Poisoned!").forHours(4);
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.createStatusEffect(StatusEffects.NagaVenom,7,0,0,0);
				}
				else {
					player.createStatusEffect(StatusEffects.NagaVenom,0,0,0,0);
					player.takePhysDamage(15+rand(15));
				}
				player.takePhysDamage(15+rand(15));
			}
			else {
				outputText("The venom's effects intensify as your vision begins to blur and it becomes increasingly harder to stand.");
				if(player.spe > 7) {
					//stats(0,0,-2,0,0,0,0,0);
					player.buff("Poison").addStats({"spe":-6}).withText("Poisoned!").forHours(4);
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.addStatusValue(StatusEffects.NagaVenom,1,6);
				}
				else player.takePhysDamage(15+rand(15));
				player.takePhysDamage(15+rand(15));
			}
		}
		
		public function gorgonConstrict():void {
			outputText("The " + this.short + " draws close and suddenly wraps herself around you, binding you in place! You can't help but feel strangely aroused by the sensation of her scales rubbing against your body. All you can do is struggle as she begins to squeeze tighter!");
			player.createStatusEffect(StatusEffects.PlayerBoundPhysical,0,0,0,0); 
			if (!player.hasPerk(PerkLib.Juggernaut) && armorPerk != "Heavy") {
				player.takePhysDamage(4+rand(8));
			}
		}
		
		public function TailWhip():void {
			outputText("The gorgon tenses and twists herself forcefully.  ");
			//[if evaded]
			if (player.getEvasionRoll()) {
				outputText("You see her tail whipping toward you and jump out of the way at the last second. You quickly roll back onto your feet.");
			}
			else {
				outputText("Before you can even think, you feel a sharp pain at your side as the gorgon's tail slams into you and shoves you into the sands. You pick yourself up, wincing at the pain in your side. ");
				var damage:Number = str;
				if(player.armorDef < 50) damage += 50 - player.armorDef;
				damage += rand(25);
				damage *= 10;
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function petrify():void {
			outputText("With a moment of concentration she awakens normally dormant snake hair that starts to hiss and then casual glance at you. Much to your surprise you notice your fingers then hands starting to petrify... ");
			player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) player.removeStatusEffect(StatusEffects.PlayerBoundPhysical);
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
			initStrTouSpeInte(311, 340, 319, 205);
			initWisLibSensCor(205, 232, 210, -40);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 81;
			this.armorName = "scales";
			this.armorDef = 200;
			this.armorMDef = 80;
			this.bonusHP = 2000;
			this.bonusLust = 486;
			this.lust = 30;
			this.level = 44;
			this.gems = rand(26) + 40;
			this.drop = new WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,2).
					add(consumables.GORGOIL,5);
			this.faceType = Face.SNAKE_FANGS;
			checkMonster();
		}
		
	}

}