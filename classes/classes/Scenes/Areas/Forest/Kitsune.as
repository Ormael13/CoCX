package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;

	public class Kitsune extends Monster
	{


		// Combat Abilities:
		// the kitsune are an almost purely magical mob, relying mainly on tease attacks and spells that raise lust.
		//Entwine:
		private function kitsuneEntwine():void
		{
			outputText("The kitsune closes in on you with a mischievous glint in her eyes.  You raise your guard, keeping your eyes trained on her to ensure that she doesn't try to pull anything.  Suddenly, you feel something coiling around your " + player.leg() + ", and let out a yelp as you are suddenly lifted into the air, entangled in the kitsune's tails!");
			outputText("\n\nYour limbs are bound tightly while coils of delightfully soft fur caress you on all sides.  You can do little besides struggle against your furry bonds as the constant writhing of her tails sends shudders flying up and down your spine.");
			createStatusEffect(StatusEffects.PCTailTangle, 0, 0, 0, 0);
			game.dynStats("lus", 10 + player.sens / 8);
			combatRoundOver();
		}

		//Struggle - event 5077 in combat.as
		public function kitsuneStruggle():void
		{
			clearOutput();
			//Struggle:
			outputText("You struggle against the kitsune's tails with all your might, desperately trying to free yourself before she has her way with you.");
			//Success
			if (rand(20) + player.str / 20 + statusEffectv1(StatusEffects.PCTailTangle) >= 12) {
				outputText("  Summoning up reserves of strength you didn't know you had, you wrench yourself free of her tails, pushing her away.\n\n");
				removeStatusEffect(StatusEffects.PCTailTangle);
				doAI();
			}
			//Failure - +5-10 LUST
			else {
				outputText("  Despite your valiant efforts, your wriggling only serves to get you deeper entangled in the fluffy tails, eliciting an amused giggle from the kitsune.");
				outputText("\n\nShe licks her lips, running her hands along you wherever she can find exposed flesh.  Her fingertips leave small trails of dazzling blue that make you flush with lust - you must escape her grasp soon or else you will be like putty in her hands!");
				game.dynStats("lus", 5 + player.sens / 10);
				addStatusValue(StatusEffects.PCTailTangle, 1, 3);
				combatRoundOver();
			}
		}

		public function kitsuneWait():void
		{
			clearOutput();
			outputText("Happily, you slump deeper into the fluffy tails, eliciting an amused giggle from the kitsune.");
			if (game.silly()) outputText("  You're so glad you got to touch fluffy tail.");
			outputText("\n\nShe licks her lips, running her hands along you wherever she can find exposed flesh.  Her fingertips leave small trails of dazzling blue that make you flush with lust - you must escape her grasp soon or else you will be like putty in her hands!");
			game.dynStats("lus", 5 + player.sens / 10);
			combatRoundOver();
		}

		//Fox Fire: - Low piercing damage, +10-15 LUST
		private function foxFireAttack():void
		{
			outputText("The kitsune makes a small circle in the air with her fingers, conjuring up a pale blue flame into her palm with the sound of flint striking against steel.  Pursing her lips, she blows it toward you with a kiss.");
			outputText("\n\nThe flames burn furiously, but leave you with an incredibly pleasant tingling sensation all over your body.  Your skin flushes with excitement, and you can feel blood rushing to your extremities, making you shudder with pleasure. ");
			var damage:int = 5 + rand(20);
			damage = player.takeDamage(damage, true);
			game.dynStats("lus", 15 + player.sens / 10);
			combatRoundOver();
		}

//Illusion: - Raises enemy evasion, but can be resisted.
//Factors affecting resist: INT (1% per point, max 70%), "Whispered" perk (20% flat bonus), "Religious" background and < 20 corruption (20% bonus at 0, losing 1% per point of corruption.)
//Success:
		private function illusionKitsuneAttack():void
		{
			outputText("You struggle to keep your eyes on the kitsune, ghostly laughter echoing all around you as you turn to and fro, trying to track her movements.  It almost seems like the edges of reality are blurring around her, severely distorting your perceptions and making it hard to follow her.  It's going to be much harder to hit her if she keeps this up!");
			//Resist: - successfully resisting deals small health & lust damage to kitsune
			var resist:int = 0;
			if (player.inte < 30) resist = Math.round(player.inte);
			else resist = 30;
			if (player.findPerk(PerkLib.Whispered) >= 0) resist += 20;
			if (player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor < 20) resist += 20 - player.cor;
			if (rand(100) < resist) {
				outputText("\n\nThe kitsune seems to melt away before your eyes for a moment, as though the edges of reality are blurring around her.  You tighten your focus, keeping your eyes trained on her, and she suddenly reels in pain, clutching her forehead as she is thrust back into view.  She lets out a frustrated huff of disappointment, realizing that you have resisted her illusions.");
			}
			else {
				createStatusEffect(StatusEffects.Illusion, 0, 0, 0, 0);
				spe += 20;
			}
			combatRoundOver();
		}

//Seal: - cancels and disables whatever command the player uses this round. Lasts 3 rounds, cannot seal more than one command at a time.
//PCs with "Religious" background and < 20 corruption have up to 20% resistance to sealing at 0 corruption, losing 1% per corruption.
		private function kitsuneSealAttack():void
		{
			var resist:int = 0;
			if (player.inte < 30) resist = Math.round(player.inte);
			else resist = 30;
			if (player.findPerk(PerkLib.Whispered) >= 0) resist += 20;
			if (player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor < 20) resist += 20 - player.cor;
			var select:int = rand(7);
			//Attack:
			if (select == 0) {
				outputText("The kitsune playfully darts around you, grinning coyly.  She somehow slips in under your reach, and before you can react, draws a small circle on your chest with her fingertip.  As you move to strike again, the flaming runic symbol she left on you glows brightly, and your movements are halted mid-swing.");
				outputText("\n\n\"<i>Naughty naughty, you should be careful with that.</i>\"");

				outputText("\n\nDespite your best efforts, every time you attempt to attack her, your muscles recoil involuntarily and prevent you from going through with it.  <b>The kitsune's spell has sealed your attack!</b>  You'll have to wait for it to wear off before you can use your basic attacks.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 0, 0, 0);
			}
			else if (select == 1) {
				//Tease:
				outputText("You are taken by surprise when the kitsune appears in front of you out of nowhere, trailing a fingertip down your chest.  She draws a small circle, leaving behind a glowing, sparking rune made of flames.  You suddenly find that all your knowledge of seduction and titillation escapes you.  <b>The kitsune's spell has sealed your ability to tease!</b>  Seems you won't be getting anyone hot and bothered until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 1, 0, 0);
			}
			//Spells:
			else if (select == 2) {
				outputText("\"<i>Oh silly, trying to beat me at my own game are you?</i>\"  the kitsune says with a smirk, surprising you as she appears right in front of you.  She traces a small circle around your mouth, and you find yourself stricken mute!  You try to remember the arcane gestures to cast your spell and find that you've forgotten them too.  <b>The kitsune's spell has sealed your magic!</b>  You won't be able to cast any spells until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 2, 0, 0);
			}
			//Items:
			else if (select == 3) {
				outputText("\"<i>Tsk tsk, using items?  That's cheating!</i>\"  the kitsune says as she appears right in front of you, taking you off guard.  Her finger traces a small circle on your pouch, leaving behind a glowing rune made of crackling flames.  No matter how hard you try, you can't seem to pry it open.  <b>The kitsune's spell has sealed your item pouch!</b>  Looks like you won't be using any items until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 3, 0, 0);
			}
			//Run:
			else if (select == 4) {
				outputText("\"<i>Tsk tsk, leaving so soon?</i>\"  the kitsune says, popping up in front of you suddenly as you attempt to make your escape.  Before you can react, she draws a small circle on your chest with her fingertip, leaving behind a glowing rune made of crackling blue flames.  You try to run the other way, but your " + player.legs() + " won't budge!\n\n\"<i>Sorry baby, you'll just have to stay and play~.</i>\" she says in a singsong tone, appearing in front of you again.  <b>The kitsune's spell prevents your escape!</b>  You'll have to tough it out until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 4, 0, 0);
			}
			//P.Special:
			else if (select == 5) {
				outputText("You jump with surprise as the kitsune appears in front of you, grinning coyly.  As she draws a small circle on your forehead with her fingertip, you find that you suddenly can't remember how to use any of your physical skills!");
				outputText("\n\n\"<i>Oh no darling, </i>I'm<i> the one with all the tricks here.</i>\"");
				outputText("\n\n<b>The kitsune's spell has sealed your physical skills!</b>  You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 5, 0, 0);
			}
			//M.Special:
			else {
				outputText("You jump with surprise as the kitsune appears in front of you, grinning coyly.  As she draws a small circle on your forehead with her fingertip, you find that you suddenly can't remember how to use any of your magical skills!");
				outputText("\n\n\"<i>Oh no darling, </i>I'm<i> the one with all the tricks here.</i>\"");
				outputText("\n\n<b>The kitsune's spell has sealed your magical skills!</b>  You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 6, 0, 0);
			}
			if (resist >= rand(100)) {
				outputText("\n\nUpon your touch, the seal dissipates, and you are free of the kitsune's magic!  She pouts in disappointment, looking thoroughly irritated, but quickly resumes her coy trickster facade.");
				player.removeStatusEffect(StatusEffects.Sealed);
			}
			combatRoundOver();
		}

//Tease Texts:
		private function kitSuneTeases():void
		{
			var select:int = rand(3);
			if (hairColor == "red" && rand(2) == 0) select = 3;
			if (select == 0) outputText("You rub your eyes, suddenly seeing triple as you find yourself in the midst of a crowd of kitsune doppelgangers.  They run their hands all over you, teasing and doting on you as their tails caress every inch of your body.  Taken by surprise, you forget to fight back until they have already dispersed, blending back into a single fox-woman.");
			else if (select == 1) outputText("Bending forward, the kitsune runs her hands down over her breasts, jiggling them enticingly and squeezing them together.  Hooking a finger in her robes, she slides it down, tugging them aside until her nipples are just barely covered, and with a teasing smirk, pulls them back up, leaving you wanting.");
			else if (select == 2) outputText("Turning her back to you, the kitsune fans out her tails, peering back as she lifts the hem of her robe to expose her plump hindquarters.  Her tails continually shift and twist, blocking your view, but it only serves to make you want it even <i>more</i>, licking your lips in anticipation.");
			//Redhead only:
			else outputText("The kitsune sways her hips enticingly as she appears in front of you abruptly, rubbing up against your side.  Her teasing caresses make you shiver with arousal, and you can feel something thick and warm pressing against your [hips].  She gives you a wry grin as she breaks away from you, sporting an obvious tent in her robes.  \"<i>Just you wait...</i>\"");
			game.dynStats("lus", 5 + player.sens / 7);
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			var moves:Array = [foxFireAttack, foxFireAttack, kitSuneTeases, kitSuneTeases];
			if (player.findStatusEffect(StatusEffects.Sealed) < 0) moves.push(kitsuneSealAttack);
			if (player.findStatusEffect(StatusEffects.Sealed) < 0) moves.push(kitsuneSealAttack);
			if (findStatusEffect(StatusEffects.PCTailTangle) < 0) moves.push(kitsuneEntwine);
			if (findStatusEffect(StatusEffects.Illusion) < 0) moves.push(illusionKitsuneAttack);
			moves[rand(moves.length)]();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.forest.kitsuneScene.defeatTheKitsunes();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe kitsune recoils before running off, no longer interested in you...");
				game.combat.cleanupAfterCombat();
			} else {
				game.forest.kitsuneScene.loseToKitsunes();
			}
		}

		public function Kitsune(hairColor:String)
		{

			if (rand(3) != 2) game.flags[kFLAGS.redheadIsFuta] = 1;
			this.a = "a ";
			this.short = "kitsune";
			this.imageName = "kitsune";
			this.long = "A kitsune stands in front of you, about five and a half feet tall.  She has a head of " + ({
						"blonde": "long flaxen",
						"black": "lustrous, ass-length black",
						"red": "unkempt, shoulder-length reddish"
					}[hairColor]) +
							" hair.  She appears mostly human, except for a pair of large, furry ears poking through her hair and six luxurious silky tails swaying in the air behind her.  Her robes are revealing but comfortable-looking, hugging her voluptuous curves and exposing large swaths of tattooed skin.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely, and each movement brings a pleasant jiggle from her plump backside and large breasts.";
			// this.plural = false;
			if (hairColor=="red" && game.flags[kFLAGS.redheadIsFuta] == 1) {
				this.createCock(rand(13) + 14,1.5 + rand(20)/2,CockTypesEnum.HUMAN);
				this.balls = 2;
				this.ballSize = 2 + rand(13);
				this.cumMultiplier = 1.5;
				this.hoursSinceCum = ballSize * 10;
			}
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = rand(24) + 60;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_AVERAGE+1;
			this.skinTone = "pale";
			this.hairColor = hairColor;
			this.hairLength = 13 + rand(20);
			initStrTouSpeInte(35, 45, 90, 95);
			initLibSensCor(60, 65, 45);
			this.weaponName = "claws";
			this.weaponVerb="punch";
			this.armorName = "skin";
			this.bonusHP = 120;
			this.lust = 20;
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 6;
			this.gems = rand(10) + 10;
			this.drop = new WeightedDrop(consumables.FOXJEWL, 1);
			this.tailType = TAIL_TYPE_FOX;
			checkMonster();
		}

	}

}