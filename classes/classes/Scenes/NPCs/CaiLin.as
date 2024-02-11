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
import classes.Stats.Buff;
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
				if(player.str > 8 && player.tou > 8 && player.spe > 8 && player.inte > 8) {
					player.statStore.addBuffObject({"str":-2,"tou":-2,"spe":-2,"int":-1},"Poison", {text:"Poisoned!",time:Buff.RATE_HOURS, tick:4})
					showStatDown( 'str' );
					showStatDown( 'tou' );
					showStatDown( 'spe' );
					showStatDown( 'inte' );
					player.createStatusEffect(StatusEffects.MedusaVenom,2,1,0,0);
				}
				else {
					player.createStatusEffect(StatusEffects.MedusaVenom,2,1,0,0);
					player.takePoisonDamage(5+rand(5));
				}
				player.takePoisonDamage(5+rand(5));
			}
			else {
				outputText("The venom's effects intensify causing yor body and mind further weaker and mind even more muddled.");
				if(player.str > 7 && player.tou > 7 && player.spe > 7 && player.inte > 7) {
					player.statStore.addBuffObject({"str":-4,"tou":-4,"spe":-4,"int":-2},"Poison", {text:"Poisoned!",time:Buff.RATE_HOURS, tick:4})
					showStatDown( 'str' );
					showStatDown( 'tou' );
					showStatDown( 'spe' );
					showStatDown( 'inte' );
					player.addStatusValue(StatusEffects.MedusaVenom,1,1);
				}
				else player.takePoisonDamage(5+rand(5));
				player.takePoisonDamage(5+rand(5));
			}
		}
		
		public function medusaConstrict():void {
			if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
			else outputText("The gorgon");
			outputText(" draws close and suddenly wraps herself around you, binding you in place! You can't help but feel strangely aroused by the sensation of her scales rubbing against your body. All you can do is struggle as she begins to squeeze tighter!");
			player.createStatusEffect(StatusEffects.NagaBind,0,0,0,0); 
			if (!player.hasPerk(PerkLib.Juggernaut) && armorPerk != "Heavy") {
				player.takePhysDamage(3+rand(6));
			}
		}
		
		public function TailWhip():void {
			if (game.flags[kFLAGS.CAILIN_AFFECTION] >= 10) outputText("Cai'Lin");
			else outputText("The gorgon");
			outputText(" tenses and twists herself forcefully.  ");
			if(player.getEvasionRoll()) {
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
			if (hasPerk(PerkLib.JobSorcerer)) mod += .1;
			//if (hasPerk(PerkLib.Mage)) mod += .2;
			//if (hasPerk(PerkLib.Spellpower)) mod += .2;
			//if (hasPerk(PerkLib.WizardsFocus)) mod += .5;
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
			player.takeFireDamage(damage, true);
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
				this.armorMDef = 30;
				this.bonusHP = 300;
				this.bonusLust = 70;
				this.lustVuln = .9;
				this.level = 20;
			}
			if (flags[kFLAGS.CAILIN_LVL_UP] == 1) {
				this.long = "You are fighting Cai'Lin. Despite that she not looking exactly the same as other gorgon due to huge parts of her skin not covered in seven-colored scales, striped in a pattern reminiscent of the dunes around you. Scaleless areas includes most of her face, front torso and abdomen. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's wearing only make-shift bra over her A-cup breasts and simple loincloth. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);//każde 2 lvl up podwyższają wetness
				this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);//zwieksza sie czy tez nie?
				createBreastRow(Appearance.breastCupInverse("B"));//wpierw wzrost do B na 1,2 lvl-up potem do C na 3,4 i do D na 5,6 a dodtkowe urośnicie jak użyje jakiś TF - albo zostaje na A i potem użycie itemów zmienić może rozmiar tylko (first increase to B at level-up 1 and 2, then to C at levels 3 and 4, and to D at levels 5 and 6. Additional growth occurs when using specific TF (Transformation) - either stay at A and later use items to change size.)

				this.tallness = 6*12;//potem z każdą zmianą dodawać jej 2 wzrostu tak aby ostatecznie osiągneła coś koło 6*12+10 (then with each change, add 2 units of growth so that eventually she reaches something around 6*12+10.)
				this.hairLength = 12;
				initStrTouSpeInte(90, 120, 110, 70);//lvl-up daje +15, +20, +15, +20
				initWisLibSensCor(70, 45, 30, 40);//lvl-up daje +20, +15, +10, +0
				this.weaponAttack = 45;
				this.armorDef = 40;
				this.armorMDef = 30;
				this.bonusHP = 400;
				this.bonusLust = 100;
				this.lustVuln = .8;//każdy lvl up to kolejne 0.1 niżej
				this.level = 25;//każdy lvl up to +5 lvl-i chyba xD
				this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			}
			// this.plural = false;
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.hips.type = Hips.RATING_BOYISH;//hip size - ostatecznie size 15 (używać eggs jak Amily)
			this.butt.type = Butt.RATING_BUTTLESS;//butt size -  ostatecznie size 12 (używać eggs jak Amily)
			this.lowerBody = LowerBody.NAGA;
			this.skin.growCoat(Skin.SCALES,{color:"seven-colored"},Skin.COVERAGE_COMPLETE);
			this.hairColor = "seven-colored";
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.armorName = "scales";
			this.lust = 30;
			this.fatigue = 0;
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