/**
 * Created by K.Quesom 11.06.14
 */
package classes.Scenes.Areas.Bog
{
	import classes.*;
	import classes.internals.WeightedDrop;

	public class Phouka extends Monster
	{
		protected function phoukaFightAttack():void
		{ 
			var damage:int;
			//Only the bunny, goat and horse forms make physical attacks
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you due to his blindness!\n", false);
			}
			else if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY) {
				damage = Math.round((60 + 30 + 10) - rand(player.tou) - player.armorDef); //60 == Bunny Strength, 30 == Bunny Weapon Attack
				outputText("The bunny morph hops towards you.  At the last second he changes direction and throws a kick toward you with his powerful hind legs.");
				if (player.getEvasionRoll())
					outputText("\nThrowing yourself out of the way, you manage to avoid the kick.  The " + this.short + " hops out of reach and prepares for another attack.");
				else if (damage <= 0)
					outputText("\nYou block his attack by moving your shoulder in close, absorbing the energy of the kick harmlessly.");
				else {
					player.takeDamage(damage);
					outputText("\nThe kick connects and leaves you reeling.");
				}
			}
			else if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_GOAT) {
				damage = Math.round((80 + 40 + 10) - rand(player.tou) - player.armorDef); //80 == Goat Strength, 40 == Goat Weapon Attack
				outputText("The goat morph races toward you, head down.");
				if (player.getEvasionRoll())
					outputText("\nThrowing yourself out of the way, you manage to keep from getting skewered.");
				else if (damage <= 0)
					outputText("\nYou manage to smack the goat morph in the side of the head.  The horns pass you by harmlessly.");
				else {
					player.takeDamage(damage);
					outputText("\nIts head and horns crash into you, leaving you winded and bruised.");
				}
			}
			else { //HORSE
				damage = Math.round((95 + 55 + 10) - rand(player.tou) - player.armorDef); //95 == Horse Strength, 55 == Horse Weapon Attack
				outputText("The stallion charges you, clearly intending to trample you under its hooves.");
				if (player.getEvasionRoll() || (damage <= 0))
					outputText("\nAs the stallion passes you twist in place and manage to stay clear of its legs.");
				else {
					player.takeDamage(damage);
					outputText("\nYou get clipped by the stallion's legs and hooves as he charges. As he comes around for another pass you check over your body, amazed none of your bones are broken after that.");
				}
			}
			combatRoundOver();
		}

		protected function phoukaFightLustAttack():void
		{ //Only the faerie, bunny and horse forms make lust attacks
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_FAERIE)
				outputText("The " + this.short + " uses his wings to climb high up in the air above you.  Then he starts jerking his cock at you with one hand while fondling his balls with the other.  ");
			else if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY)
				outputText("The bunny morph leaps forward, trying to catch you off guard and grapple you.  ");
			else outputText("The stallion rears up on his hind legs, waving his massive cock at you.  ");

			if (player.getEvasionRoll()) {
				if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY)
					outputText("You throw yourself out of the way at the last moment and succeed in throwing the " + this.short + " off balance. He staggers away, his attempted attack ruined.\n");
				else outputText("You manage to look away in time and the " + this.short + "'s lewd display has no real effect on you.\n");
			}
			else {
				if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_FAERIE)
					outputText("A drizzle of precum rains down around you.  The sight of the " + this.short + " pumping his shaft along with the smell of the salty yet sweet fluids makes you wish you could stop fighting and concentrate on pleasuring yourself.");
				else if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY)
					outputText("He grabs you and rubs up against your body.  For a moment you are lost in the feeling of his soft black fur.  Then you feel his cock pressing against your ribs and shove him away.");
				else outputText("You are hypnotized by the equine cock jabbing at the air.  Then the " + this.short + " charges past you and you can taste the musk in the air.");
				game.dynStats("lus", 15 + player.lib / 10 + player.cor / 5 + rand(10));
			}
			combatRoundOver();
		}

		protected function phoukaFightSilence():void
		{ //Reuses the statusEffect Web-Silence from the spiders
			outputText(this.capitalA + this.short + " scoops up some muck from the ground and rams it down over his cock.  After a few strokes he forms the lump of mud and precum into a ball and whips it at your face.  ");
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2)
				outputText("Since he's blind the shot goes horribly wide, missing you entirely.");
			else
			{
				var evade:String = player.getEvasionReason();
				if (evade == EVASION_SPEED)
					outputText("You lean back and let the muck ball whip pass to one side, avoiding the attack.");
				else if (evade == EVASION_EVADE)
					outputText("You pull back and to the side, blocking the shot with your arm. The muck splatters against it uselessly.");
				else if (evade == EVASION_MISDIRECTION)
					outputText(this.capitalA + this.short + " was watching you carefully before his throw.  That proves to be his undoing as your misleading movements cause him to lob the muck at the wrong time");
				else if (evade == EVASION_FLEXIBILITY)
					outputText("As the ball leaves his fingers you throw yourself back, your spine bending in an inhuman way.  You feel the ball sail past, inches above your chest.");
				else if (evade != null) // failsafe
					outputText("You throw yourself out of the way at the last moment!");
				else {
					outputText("The ball smacks into your face like a wet snowball.  It covers most of your nose and mouth with a layer of sticky, salty mud which makes it hard to breathe.  You'll be unable to use your magic while you're struggling for breath!\n");
					player.createStatusEffect(StatusEffects.WebSilence, 0, 0, 0, 0); //Probably safe to reuse the same status affect as for the spider morphs
				}
			}
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			var blinded:Boolean = findStatusEffect(StatusEffects.Blind) >= 0;
			if ((!blinded) && player.findStatusEffect(StatusEffects.WebSilence) < 0 && rand(4) == 0) {
				phoukaTransformToPhouka(); //Change to faerie form so that it can lob the ball of muck at you
				phoukaFightSilence();
			}
			else {
				var transformChance:int = rand(9); //2 in 3 chance of staying in current form
				if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_FAERIE) {
					if (blinded) transformChance = rand(3); //100% chance of change from blind phouka if not doing silence attack
					else transformChance = rand(4); //75% chance of change from phouka if not doing silence attack
				}
				switch (transformChance){
					case 0: phoukaTransformToBunny(); break;
					case 1: phoukaTransformToGoat(); break;
					case 2: phoukaTransformToHorse();
					default:
				}
				if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_FAERIE)
					phoukaFightLustAttack(); //Can only get here if the phouka isn’t blind
				else if ((PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY) && (rand(4) != 0) && (!blinded))
					phoukaFightLustAttack(); //Bunny has a 75% chance of teasing attack, no teasing while blind
				else if ((PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_HORSE) && (rand(4) == 0) && (!blinded))
					phoukaFightLustAttack(); //Horse has a 25% chance of teasing attack, no teasing while blind
				else phoukaFightAttack();
			}
		}

		override public function teased(lustDelta:Number):void
		{
			if (lustDelta >= 10)
				outputText("\n\nThe " + this.short + " breaks off its attack in the face of your teasing.  Its drooling member leaves a trail of precum along the ground and you get the feeling it needs to end this fight quickly.");
			else if (lustDelta >= 5)
				outputText("\n\nThe " + this.short + " stops its assault for a moment.  A glob of precum oozes from its cock before it shakes its head and gets ready to attack again.");
			else if (lustDelta > 0)
				outputText("\n\nThe " + this.short + " hesitates and slows down.  You see its cock twitch and then it readies for the next attack.", false);
			applyTease(lustDelta);
		}
        
		override public function defeated(hpVictory:Boolean):void
		{
			game.bog.phoukaScene.phoukaPlayerWins(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe " + this.short + " looks on, amused. <i>“Kinky! But those wee things can't handle whiskey, so I’m safe from ‘em. Now be a good ");
				if (player.hasVagina())
					outputText("lass and spread yer legs for me.”</i>\n\n");
				else outputText("lad and spread yer asscheeks for me.”</i>\n\n");
				doNext(game.combat.endLustLoss);
			}
			else {
				if (player.hasVagina()) { //Phouka prefer vaginal if they can get it
					if (player.isTaur() || rand(2) == 0)
						game.bog.phoukaScene.phoukaSexHorse(true, !hpVictory); //And they love mating with female or herm centaurs in their horse form
					else game.bog.phoukaScene.phoukaSexBunny(true, !hpVictory);
				}
				else game.bog.phoukaScene.phoukaSexGoat(true, !hpVictory);
			}
		}

		protected function phoukaTransformToBunny():void
		{
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY) return; //Already a bunny, so no change
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_FAERIE) {
				outputText("The faerie suddenly drops out of the air.  A look of concentration sets in on its face and it begins to expand and warp.  You blink and see that in front of you there is now a 5 foot tall bunny morph.\n\n");
			}
			else if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_GOAT) {
				outputText("As the goat morph charges towards you it starts to grow.  By the time it gets close it has changed completely and you now face a 5 foot tall bunny morph.\n\n");
			}
			else { //Was a horse
				outputText("As the horse morph charges towards you it quite suddenly shrinks.  You have to adjust your defence as a 5 foot tall bunny morph is now hopping your way.\n\n");
			}
			this.long = "The " + this.short + " is hopping around near you, waiting for an opening.  He has the general appearance of a bunny with coal black fur.  A large cock stands erect between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
			this.armorValue = 60;
			this.spe = 90;
			PhoukaScene.phoukaForm = PhoukaScene.PHOUKA_FORM_BUNNY;
		}

		protected function phoukaTransformToGoat():void
		{
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_GOAT) return; //Already a goat, so no change
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_FAERIE) {
				outputText("The faerie suddenly drops out of the air.  A look of concentration sets in on its face and it begins to expand and warp.  You blink and see that in front of you there is now a 4 foot tall goat morph.\n\n");
			}
			else if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY) {
				outputText("The bunny morph hops back from you and starts to melt and change.  You blink and see that in front of you there is now a 4 foot tall goat morph.\n\n");
			}
			else { //Was a horse
				outputText("As the horse morph charges towards you it quite suddenly shrinks.  You have to adjust your defence as it is now a 4 foot tall goat morph.\n\n");
			}
			this.long = "The " + this.short + " is charging back and forth just out of reach, waiting for an opening.  He has the general appearance of a goat with coal black fur.  He has large glossy black horns and a large cock between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
			this.armorValue = 60;
			this.spe = 70;
			PhoukaScene.phoukaForm = PhoukaScene.PHOUKA_FORM_GOAT;
		}

		protected function phoukaTransformToHorse():void
		{
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_HORSE) return; //Already a horse, so no change
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_FAERIE) {
				outputText("The faerie suddenly drops out of the air.  A look of concentration sets in on its face and it begins to grow larger and larger.  You watch amazed as the creature's form stretches.  Finally it seems unable to grow further and settles into the form of a massive stallion.\n\n");
			}
			else if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY) {
				outputText("The bunny morph hops back from you and starts to grow and melt.  You watch amazed as the creature's form stretches.  Finally it seems unable to grow further and settles into the form of a massive stallion.\n\n");
			}
			else { //Was a goat
				outputText("The goat morph eyes you then seems to think better of charging again.  It backs away and starts to grow larger and larger, its features and body shape twisting and reforming.  Finally it seems unable to grow further and settles into the form of a massive stallion.\n\n");
			}
			this.long = "The " + this.short + " is running in a wide circle around you, waiting for an opening.  He has the general appearance of a stallion with coal black fur.  A massive cock stands erect between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
			this.armorValue = 75;
			this.spe = 55;
			PhoukaScene.phoukaForm = PhoukaScene.PHOUKA_FORM_HORSE;
		}
		
		protected function phoukaTransformToPhouka():void
		{
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_FAERIE) return; //Already a faerie, so no change
			if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_BUNNY) {
				outputText("The bunny morph hops back from you and starts to melt and shrink.  In seconds only a tiny faerie is left floating in the air where the bunny once was.\n\n");
			}
			else if (PhoukaScene.phoukaForm == PhoukaScene.PHOUKA_FORM_GOAT) {
				outputText("The goat morph bounds away from you and starts to melt and deform.  In seconds only a tiny faerie is left floating in the air where the goat once was.\n\n");
			}
			else { //Was a horse
				outputText("The horse morph charges past you.  You look over your shoulder and wonder where the stallion could have gone.  Then you see the tiny faerie zipping back for another attack.\n\n");
			}
			this.long = "The " + this.short + " is flying around near you, waiting for an opening.  He has the general appearance of a faerie, though he is slightly larger and his skin and wings are coal black.  A large cock stands erect between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
			this.armorValue = 80;
			this.spe = 80;
			PhoukaScene.phoukaForm = PhoukaScene.PHOUKA_FORM_FAERIE;
		}

		override public function handleAwardItemText(itype:ItemType):void
		{
			outputText("  You are just about to leave when you remember that glint from the hollow of that nearby tree.");
			if (itype == null)
				outputText("\n\nYou take a look and curse the " + this.short + ".  Looks like it used a piece of a broken bottle to lure you in.  At least you learned more about fighting the little pests.  You gain " + this.XP + " XP from your victory.");
			else outputText("\n\nYou look inside the hollow and are pleased to find " + itype.longName + ".  You also gain " + this.XP + " XP from your victory, since you learned a bit more about fighting these little pests.\n\n");
		}

		override public function handleAwardText():void
		{
			//Talk about gems and XP when the player looks in the hollow of the tree instead of here
		}
		
		override public function handleCombatLossText(inDungeon:Boolean, gemsLost:int):int
		{
			if (player.gems > 1)
				outputText("  Once free you check your gem pouch and realize the " + this.short + " took " + gemsLost + " of your gems.");
			else if (player.gems == 1)
				outputText("  Once free you check your gem pouch and realize the " + this.short + " took your only gem.");
			return 1; //Only use up one hour after combat loss
		}
		
		public function Phouka(phoukaName:String)
		{
			super();

			this.a = "the ";
			this.short = phoukaName;
			this.long = "The " + this.short + " is flying around near you, waiting for an opening.  He has the general appearance of a faerie, though he is slightly larger and his skin and wings are coal black.  A large cock stands erect between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";

			this.createCock(1, 0.5, CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 5;
			this.hoursSinceCum = 20;

			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;

			this.tallness = 5;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.lowerBody = LOWER_BODY_TYPE_HUMAN
			this.armType = ARM_TYPE_HUMAN;

			this.skinTone = "black";
			this.hairColor = "black";
			this.hairLength = 1;

			this.earType = EARS_ELFIN;

			initStrTouSpeInte(55, 25, 80, 40);
			initLibSensCor(75, 35, 100);

			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 15;
			this.armorName = "skin";
			this.armorDef = 80;

			this.bonusHP = 300;
			this.lust = 30;
			this.lustVuln = .5;

			this.level = 14;
			this.gems = 0;
			this.drop = new WeightedDrop().add(consumables.BLACK_D, 20)
				.add(consumables.RIZZART, 10)
				.add(consumables.GROPLUS, 2)
				.add(consumables.SDELITE, 13)
				.add(consumables.P_WHSKY, 35)
				.add(null, 20);

			this.wingType = WING_TYPE_GIANT_DRAGONFLY; //Maybe later, if the PC can get them, make a Faerie wing type.
			this.wingDesc = "small black faerie wings";
			checkMonster();
		}

	}

}
