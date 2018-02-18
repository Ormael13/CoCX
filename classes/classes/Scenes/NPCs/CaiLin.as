/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

public class CaiLin extends Monster
	{
		override protected function performCombatAction():void
		{
			var choice:Number = rand(6);
			if (choice == 0) eAttack();
			if (choice == 1) medusaPoisonBiteAttack();
			if (choice == 2) {
				if (player.hasStatusEffect(StatusEffects.NagaBind) || player.hasStatusEffect(StatusEffects.Stunned)) TailWhip();
				else medusaConstrict();
			}
			if (choice == 3) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) castSpell();
				else if (player.hasStatusEffect(StatusEffects.NagaBind)) medusaPoisonBiteAttack();
				else TailWhip();
			}
			if (choice == 4) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) castSpell();
				else if (player.hasStatusEffect(StatusEffects.NagaBind)) {
					if (rand(2) == 0) medusaPoisonBiteAttack();
					else TailWhip();
				}
				else {
					if (player.hasStatusEffect(StatusEffects.AbilityCooldown1)) {
						if (rand(2) == 0) medusaPoisonBiteAttack();
						else TailWhip();
					}
					else petrify();
				}
			}
			if (choice == 5) castSpell();
		}
		
		public function medusaPoisonBiteAttack():void {
			//(Deals damage over 4-5 turns, invariably reducing 
			//your speed. It wears off once combat is over.)
			if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
			else outputText("The gorgon");
			outputText("'s strikes with the speed of a cobra, sinking her fangs into your flesh!  ");
			if(!player.hasStatusEffect(StatusEffects.MedusaVenom)) {
				outputText("The venom's effects are almost instantaneous; your body begins to weaken and even your mind becoming muddled.");
				if(player.str > 8 && player.tou > 8 && player.spe > 8 && player.inte > 7) {
					player.str -= 2;
					showStatDown( 'str' );
					player.tou -= 2;
					showStatDown( 'tou' );
					player.spe -= 2;
					showStatDown( 'spe' );
					player.inte -= 1;
					showStatDown( 'inte' );
					player.createStatusEffect(StatusEffects.MedusaVenom,2,2,2,1);
				}
				else if(player.str > 8 && player.tou > 8 && player.spe > 9) {
					player.str -= 2;
					showStatDown( 'str' );
					player.tou -= 2;
					showStatDown( 'tou' );
					player.spe -= 3;
					showStatDown( 'spe' );
					player.createStatusEffect(StatusEffects.MedusaVenom,2,2,3,0);
				}
				else if(player.tou > 9 && player.spe > 10) {
					player.tou -= 3;
					showStatDown( 'tou' );
					player.spe -= 4;
					showStatDown( 'spe' );
					player.createStatusEffect(StatusEffects.MedusaVenom,0,3,4,0);
				}
				else if(player.spe > 12) {
					player.spe -= 6;
					showStatDown( 'spe' );
					player.createStatusEffect(StatusEffects.MedusaVenom, 0,0,6,0);
					player.takeMagicDamage(5+rand(5));
				}
				else {
					player.createStatusEffect(StatusEffects.MedusaVenom,0,0,0,0);
					player.takeMagicDamage(5+rand(5));
				}
				player.takeMagicDamage(5+rand(5));
			}
			else {
				outputText("The venom's effects intensify causing yor body and mind further weaker and mind even more muddled.");
				if(player.str > 7 && player.tou > 7 && player.spe > 7 && player.inte > 7) {
					player.str -= 1;
					showStatDown( 'str' );
					player.tou -= 1;
					showStatDown( 'tou' );
					player.spe -= 1;
					showStatDown( 'spe' );
					player.inte -= 1;
					showStatDown( 'inte' );
					player.addStatusValue(StatusEffects.MedusaVenom,1,1);
					player.addStatusValue(StatusEffects.MedusaVenom,2,1);
					player.addStatusValue(StatusEffects.MedusaVenom,3,1);
					player.addStatusValue(StatusEffects.MedusaVenom,4,1);
				}
				else if(player.str > 7 && player.tou > 7 && player.spe > 8) {
					player.str -= 1;
					showStatDown( 'str' );
					player.tou -= 1;
					showStatDown( 'tou' );
					player.spe -= 2;
					showStatDown( 'spe' );
					player.addStatusValue(StatusEffects.MedusaVenom,1,1);
					player.addStatusValue(StatusEffects.MedusaVenom,2,1);
					player.addStatusValue(StatusEffects.MedusaVenom,3,2);
				}
				else if(player.tou > 8 && player.spe > 8) {
					player.tou -= 2;
					showStatDown( 'tou' );
					player.spe -= 2;
					showStatDown( 'spe' );
					player.addStatusValue(StatusEffects.MedusaVenom,2,2);
					player.addStatusValue(StatusEffects.MedusaVenom,3,2);
				}
				else if(player.spe > 9) {
					player.spe -= 3;
					showStatDown( 'spe' );
					player.addStatusValue(StatusEffects.MedusaVenom,3,3);
					player.takeMagicDamage(5+rand(5));
				}
				else player.takeMagicDamage(5+rand(5));
				player.takeMagicDamage(5+rand(5));
			}
		}
		
		public function medusaConstrict():void {
			if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
			else outputText("The gorgon");
			outputText(" draws close and suddenly wraps herself around you, binding you in place! You can't help but feel strangely aroused by the sensation of her scales rubbing against your body. All you can do is struggle as she begins to squeeze tighter!");
			player.createStatusEffect(StatusEffects.NagaBind,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takePhysDamage(3+rand(6));
			}
		}
		
		public function TailWhip():void {
			if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
			else outputText("The gorgon");
			outputText(" tenses and twists herself forcefully.  ");
			//[if evaded]
			if((player.findPerk(PerkLib.Evade) && rand(6) == 0)) {
				outputText("You see her tail whipping toward you and evade it at the last second. You quickly roll back onto your feet.");
			}
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s tail-whip.");
			}
			else if(player.spe > rand(400)) {
				outputText("You see her tail whipping toward you and jump out of the way at the last second. You quickly roll back onto your feet.");
			}
			else {
				outputText("Before you can even think, you feel a sharp pain at your side as ");
				if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
				else outputText("the gorgon's");
				outputText(" tail slams into you and knocking over. You fast pick yourself up, wincing at the pain in your side. ");
				var damage:Number = str;
				if(player.armorDef < 100) damage += 100 - player.armorDef;
				damage += rand(30);
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function petrify():void {
			outputText("With a moment of concentration she awakens normaly dormant snake hair that starts to hiss and then casual glance at you. Much to your suprise you noticing your fingers then hands starting to pertify... ");
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
			if (player.hasStatusEffect(StatusEffects.NagaBind)) player.removeStatusEffect(StatusEffects.NagaBind);
		}
		
		public function spellCostWhitefire():Number {
			var cost:Number = 40;
			if (flags[kFLAGS.CAILIN_SPELLS_CASTED] >= 10) cost -= 4;
			if (flags[kFLAGS.CAILIN_SPELLS_CASTED] >= 30) cost -= 4;
			if (flags[kFLAGS.CAILIN_SPELLS_CASTED] >= 70) cost -= 4;
			if (flags[kFLAGS.CAILIN_SPELLS_CASTED] >= 150) cost -= 4;
			if (flags[kFLAGS.CAILIN_SPELLS_CASTED] >= 310) cost -= 4;
			return cost;
		}
		
		public function SpellMod():Number {
			var mod:Number = 1;
			if (findPerk(PerkLib.JobSorcerer) >= 0) mod += .1;
			//if (findPerk(PerkLib.Mage) >= 0) mod += .2;
			//if (findPerk(PerkLib.Spellpower) >= 0) mod += .2;
			//if (findPerk(PerkLib.WizardsFocus) >= 0) mod += .5;
			return mod;
		}
		
		public function WhiteFireSpell():void {
			var damage:int = (inte/3 + rand(inte/2));
			if (inte >= 21 && inte < 41) damage += (inte / 2 + rand((inte * 3) / 4));
			if (inte >= 41 && inte < 61) damage += ((inte * 2) / 3 + rand(inte));
			if (inte >= 61 && inte < 81) damage += ((inte * 5) / 6 + rand(inte * 1.25));
			if (inte >= 81 && inte < 101) damage += (inte + rand(inte * 1.5));
			if (inte >= 101 && inte < 151) damage += ((inte * 1.25) + rand(inte * 1.75));
			if (inte >= 151 && inte < 201) damage += ((inte * 1.5) + rand(inte * 2));
			if (inte >= 201) damage += ((inte * 1.75) + rand(inte * 2.25));
			damage *= SpellMod();
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
			player.addStatusValue(StatusEffects.Blizzard, 1, -1);
			if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
			else outputText("The gorgon");
			outputText(" narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  Thanks to surrounding you ice shards this attack isn't at it peak power!  ");
			damage *= 0.2;
			}
			else {
			if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
			else outputText("The gorgon");
			outputText(" narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  ");
			}
			if (player.isGoo()) {
				damage *= 1.5;
				outputText("It's super effective!  ");
			}
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
			fatigue += spellCostWhitefire();
			flags[kFLAGS.CAILIN_SPELLS_CASTED]++;
		}
		
		public function castSpell():void {
			if (fatigue < (maxFatigue() - spellCostWhitefire())) WhiteFireSpell();//później jak dodam ice, lighting spells rozbudować wybór zakleć
			else eAttack();
		}
		
		public function CaiLin() 
		{
			if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) {
				this.a = "";
				this.short = "Cai'Lin";
			}
			else {
				this.a = "the ";
				this.short = "gorgon";
			}
			this.imageName = "gorgon";
			if (flags[kFLAGS.CAILIN_LVL_UP] == 0) {
				if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) this.long = "You are fighting Cai'Lin. Despite that she not looking exactly the same as other gorgon due to huge parts of her skin not covered in seven-colored scales, striped in a pattern reminiscent of the dunes around you. Scaleless areas includes most of her face, front torso and abdomen. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's wearing only make-shift bra over her A-cup breasts and simple loincloth. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
				else this.long = "You are fighting a gorgon. Despite that she not looking exactly the same as other gorgon due to huge parts of her skin not covered in seven-colored scales, striped in a pattern reminiscent of the dunes around you. Scaleless areas includes most of her face, front torso and abdomen. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's wearing only make-shift bra over her A-cup breasts and simple loincloth. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
				createBreastRow(Appearance.breastCupInverse("A"));
				this.tallness = 5*12+10;
				this.hairLength = 10;
				initStrTouSpeInte(75, 100, 95, 50);
				initWisLibSensCor(50, 30, 20, 40);
				this.weaponAttack = 45;
				this.armorDef = 40;
				this.bonusHP = 300;
				this.lustVuln = .9;
				this.level = 20;
			}
			if (flags[kFLAGS.CAILIN_LVL_UP] == 1) {
				this.long = "You are fighting Cai'Lin. Despite that she not looking exactly the same as other gorgon due to huge parts of her skin not covered in seven-colored scales, striped in a pattern reminiscent of the dunes around you. Scaleless areas includes most of her face, front torso and abdomen. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's wearing only make-shift bra over her A-cup breasts and simple loincloth. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);//każde 2 lvl up podwyższają wetness
				this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);//zwieksza sie czy tez nie?
				createBreastRow(Appearance.breastCupInverse("B"));//wpierw wzrost do B na 1,2 lvl-up potem do C na 3,4 i do D na 5,6 a dodtkowe urośnicie jak użyje jakiś TF
				this.tallness = 6*12;//potem z każdą zmianą dodawać jej 2 wzrostu tak aby ostatecznie osiągneła coś koło 6*12+10
				this.hairLength = 12;
				initStrTouSpeInte(90, 120, 110, 70);//lvl-up daje +15, +20, +15, +20
				initWisLibSensCor(70, 45, 30, 40);//lvl-up daje +20, +15, +10, +0
				this.weaponAttack = 45;
				this.armorDef = 40;
				this.bonusHP = 400;
				this.lustVuln = .8;//każdy lvl up to kolejne 0.1 niżej
				this.level = 25;//każdy lvl up to +5 lvl-i chyba xD
				this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			}
			// this.plural = false;
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.hips.type = Hips.RATING_AMPLE;//hip size - ostatecznie size 15 (używać eggs jak Amily)
			this.butt.type = Butt.RATING_NOTICEABLE;//butt size -  ostatecznie size 12 (używać eggs jak Amily)
			this.lowerBody = LowerBody.NAGA;
			this.skin.growCoat(Skin.SCALES,{color:"seven-colored"},Skin.COVERAGE_COMPLETE);
			this.hairColor = "seven-colored";
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.armorName = "scales";
			this.bonusLust = 10;
			this.lust = 30;
			this.fatigue = 0;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 0;
			this.drop = new WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,5).
					add(consumables.GORGOIL,4);
			this.faceType = Face.SNAKE_FANGS;
			this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}