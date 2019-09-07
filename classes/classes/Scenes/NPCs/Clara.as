package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;

public class Clara extends Monster
	{
		private function notMurbleEnjoysTheLacticAcid():void
		{
			//Clara drinks her own milk to recover health and give a minor lust gain to the PC
			outputText("Clara suddenly starts roughly manhandling her tit, noisily stuffing it into her mouth and starting to suck and slobber. Frothy milk quickly stains her mouth and she releases her breast, letting it fall back down. She belches and takes a stance to defend herself again; you can see the injuries you’ve inflicted actually fading as the healing power of her milk fills her.");
			HP += 45;
			lust += 5;
			player.dynStats("lus", (5+player.lib/5));
		}
		//Clara throws a goblin potion, she has the web potion, the lust potion, and the weakening potion
		//should she try to drug them instead?
		protected function claraDrugAttack():void {
			var temp2:Number = rand(2);
			var color:String = "";
			if(temp2 == 0) color = "red";
			if(temp2 == 1) color = "black";
			//Throw offensive potions at the player
			outputText("Clara suddenly snatches something from a pouch at her belt. \"<i>Try this, little cutie!</i>\" She snarls, and throws a vial of potion at you.");
			//Dodge chance!
			if((player.findPerk(PerkLib.Evade) >= 0 && rand(10) <= 3) || (rand(100) < player.spe/5)) {
				outputText("\nYou narrowly avoid the gush of alchemic fluids!\n");
			}
			else
			{
				//Get hit!
				//Temporary heat
				if(color == "red") {
					outputText("\nThe red fluids hit you and instantly soak into your skin, disappearing.  Your skin flushes and you feel warm.  Oh no...\n");
					if(!player.hasStatusEffect(StatusEffects.TemporaryHeat)) player.createStatusEffect(StatusEffects.TemporaryHeat,0,0,0,0);
				}
				//Increase fatigue
				if(color == "black") {
					outputText("\nThe black fluid splashes all over you and wicks into your skin near-instantly.  It makes you feel tired and drowsy.\n");
					EngineCore.fatigue(10 + rand(25));
				}
			}
		}
		//Clara teases the PC, and tries to get them to give up
		protected function claraTeaseAttack():void
		{
			//[cocked PCs only] 
			if(rand(3) == 0) outputText("Clara hesitates, then lifts up her dress and shows you her womanhood.  Then she slowly utters, \"<i>You know, I’m still a virgin.  You’d be the first thing to ever enter inside this hole, something that Marble never could have offered you.</i>\"  What would it be like, you wonder for a moment, before catching yourself and trying to focus back on the fight.");
			else if(rand(2) == 0) outputText("Clara seems to relax for a moment and bounces her breasts in her hands.  \"<i>Come on, you know how good it is to drink cow-girl milk, just give up!</i>\" she coos.  Despite yourself, you can’t help but remember what it was like, and find yourself becoming aroused.");
			else outputText("Instead of attacking, Clara runs her hands up and down her body, emphasizing all the curves it has.  \"<i>You were made to be the milk slave of this, stop fighting it!</i>\" she says almost exasperated.  Even so, you find your gaze lingering on those curves against your will.");
			outputText("\n");
			player.dynStats("lus",5+player.lib/20);
		}

		//Once Clara is at half health or lower, she'll cast blind.
		public function claraCastsBlind():void
		{
			outputText("Clara glares at you, clearly being worn down.  Then strange lights start dancing around her hand and she points it in your direction.");
			//Successful: 
			if((player.findPerk(PerkLib.GorgonsEyes) < 0 && player.inte / 5 + rand(20) + 1 < 14) && !player.hasPerk(PerkLib.BlindImmunity))
			{
				outputText("\nA bright flash of light erupts in your face, blinding you!  You desperately blink and rub your eyes while Clara cackles with glee.");
				player.createStatusEffect(StatusEffects.Blind,1,0,0,0);
			}
			else if (player.findPerk(PerkLib.GorgonsEyes) >= 0) {
					outputText("Your mutated eyes not been affected at all by this flash!");
				}
			else outputText("\nYou manage to close your eyes just in time to avoid being blinded by the bright flash of light that erupts in your face!  Clara curses when she see's you're unaffected by her magic.");
		}
		public function claraGropesBlindPCs():void
		{
			//Clara gropes the PC while they're blinded.  Damage is based on corruption + sensitivity.
			if(player.hasCock() && (!player.hasVagina() || rand(2) == 0)) outputText("Suddenly Clara wraps an arm around you, and sticks a hand into your [armor]!  She is able to give your " + multiCockDescriptLight + " a good fondle before you can push her away.  \"<i>Admit it - I make you soo hard, don't I?</i>\" she taunts you behind your dazzled vision.");
			//Vagina: 
			else if(player.hasVagina()) outputText("A sudden rush of Clara's hoofs clopping is the only warning you get before her attack comes, and you try to bring up your guard, only for her to deftly move past your defense and stick a hand into your [armor]!  She manages to worm her way to your [vagina] and pinches your [clit] before you can push her back out!  \"<i>Hmm, yeah, you're soo wet for me.</i>\" she taunts you behind your dazzled vision.");
			//Bum: 
			else outputText("Thanks to Clara robbing you of your sight, you lose track of her.  She takes advantage of this, and grabs you from behind, and rubs her considerable curvy cans against your undefended back!  You manage to get her off you after a moment, but not before she gives your [ass] a smack.  \"<i>Everyone will be soo much happier when yoou finally stop fighting me!</i>\" she taunts you behind your dazzled vision.");
			player.dynStats("lus",7+player.lib/15);
		}
		//Every round if you're in Clara’s base; the PC’s lust is raised slightly.
		protected function claraBonusBaseLustDamage():void
		{
			outputText("\nThe early effects of your addiction are making it harder and harder to continue the fight.  You need to end it soon or you’ll give in to those urges.");
			player.dynStats("lus",2+player.lib/20);
		}
		override protected function performCombatAction():void
		{
			if(player.hasStatusEffect(StatusEffects.ClaraFoughtInCamp) && player.statusEffectv1(StatusEffects.ClaraCombatRounds) >= 10)
			{
				HP = 0;
			}
			if(HP < 50 && rand(2) == 0) {
				notMurbleEnjoysTheLacticAcid();
			}
			else if(player.hasStatusEffect(StatusEffects.Blind))
			{
				claraGropesBlindPCs();
			}
			else
			{
				var actions:Array = [eAttack,claraDrugAttack,claraTeaseAttack,claraCastsBlind];
				var action:int = rand(actions.length);
				trace("ACTION SELECTED: " + action);
				actions[action]();
			}
			if(!player.hasStatusEffect(StatusEffects.ClaraCombatRounds)) player.createStatusEffect(StatusEffects.ClaraCombatRounds,1,0,0,0);
			else player.addStatusValue(StatusEffects.ClaraCombatRounds,1,1);

			//Bonus damage if not in camp
			if(HP > 0 && lust < maxLust() && !player.hasStatusEffect(StatusEffects.ClaraFoughtInCamp)) claraBonusBaseLustDamage();
		}
		override public function defeated(hpVictory:Boolean):void
		{
			//PC wins via turn count
			if(player.hasStatusEffect(StatusEffects.ClaraFoughtInCamp) && player.statusEffectv1(StatusEffects.ClaraCombatRounds) >= 10) {}
			else {
				clearOutput();
				//PC wins via health
				if(HP <= 0) outputText("The pissed off cowgirl finally collapses to the ground.  She tries to stand up again, but finds that she can’t.  \"<i>Noo!</i>\" she cries out in frustration, \"<i>You were the perfect slave!  We were meant to be toogether!</i>\"\n\n");
				//PC wins via lust
				else outputText("The fury and anger finally give out to the overwhelming lust that you’ve help Clara feel.  She can’t fight anymore, and falls onto her backside.  She starts feeling herself up, and desperately asks you to fuck her.\n\n");
			}
			SceneLib.marblePurification.defeatClaraCuntInAFight();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.marblePurification.loseToClara();
		}

		public function Clara()
		{
			trace("Clara Constructor!");
			this.a = "";
			this.short = "Clara";
			this.imageName = "marble";
			this.long = "You are fighting Marble’s little sister Clara!  The cow-girl looks spitting mad, determined to steal you from her sister and make you into her milk slave, with her breasts hanging out for all to see.  Fortunately, she doesn’t look as big or strong as her sister, and you don’t think she’s been trained to fight like Marble has either.  Still, there is no telling what tricks she has up her sleeves, and she is holding a very angry looking heavy mace.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("F"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 6*12+4;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.HOOFED;
			this.skinTone = "pale";
			this.hairColor = "brown";
			this.hairLength = 13;
			initStrTouSpeInte(57, 64, 35, 60);
			initWisLibSensCor(60, 25, 45, 40);
			this.weaponName = "mace";
			this.weaponVerb="smack";
			this.weaponAttack = 16;
			this.armorName = "tough hide";
			this.armorDef = 6;
			this.armorMDef = 1;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 12;
			this.bonusHP = 30;
			this.bonusLust = 20;
			this.gems = rand(5) + 25;
			this.drop = NO_DROP;
			this.tailType = Tail.COW;
			//this.special1 = marbleSpecialAttackOne;
			//this.special2 = marbleSpecialAttackTwo;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
