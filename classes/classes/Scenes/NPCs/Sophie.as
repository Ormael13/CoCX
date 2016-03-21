package classes.Scenes.NPCs
{
	import classes.*;
	import classes.Scenes.Areas.HighMountains.Harpy;
	import classes.internals.*;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Sophie extends Harpy
	{
		//Combat Attacks
		//ON DICK'ED PCz
		//Kiss (Only used on males) - +10 lust on kiss.  25% chance
		//per round of increasing lust by 20.  Repeat kisses add
		//+20 lust.  Each kiss adds 2 hours to length of status
		//affect.
		private function sophieKissAttack():void {
			game.sophieBimbo.sophieSprite();
			outputText("Sophie bobs and weaves as she closes the distance between you in an instant.  ", false);
			//Blind dodge change
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2) {
				outputText(capitalA + short + " looks like she's trying to kiss you, but it's easy to avoid the blind harpy!\n", false);
				return;
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4) +80)) > 80) {
				outputText("Sophie changes direction in a flash, trying to slip inside your guard, but you manage to sidestep the incredibly fast harpy's attack.\n", false);
				return;
			}
			//Determine if evaded
			if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.\n", false);
				return;
			}
			if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s attack.\n", false);
				return;
			}
			//Determine if cat'ed
			if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "", false);
				outputText("'s attack.\n", false);
				return;
			}
			//YOU GOT HIT SON
			outputText("Before you can react, she gives you a chaste peck on the lips.  The harpy pulls back with a sultry smile, watching you expectantly.", false);
			
			//Already affected by it
			if (player.findStatusEffect(StatusEffects.Luststick) >= 0) {
				outputText("  Blood rushes to " + player.sMultiCockDesc() + " as you grow so hard so fast that it hurts.  ", false);
				game.sophieScene.luststickApplication(2);
				game.dynStats("lus", (12+player.lib/10));
				if (player.lust < 70) outputText("The drugged lip-gloss is starting to get to you!\n", false);
				else if (player.lust < 80) outputText("Her curvy thighs look so inviting.  You barely stop yourself before you climb in between them!\n", false);
				else if (player.lust < 90) outputText("A trickle of pre-cum leaks from " + player.sMultiCockDesc() + ".  Sophie coos, \"<i>Why don't you give in and let mommy Sophie drain out all that juicy cum?</i>\"\n", false);
				else if (player.lust < 100) outputText(player.SMultiCockDesc() + " twitches and bounces in time with your heartbeat, practically pulling you towards Sophie's gaping, pink-linked snatch.\n", false);
				else outputText("So horny.  You need to copulate - no, fuck - right NOW.  Your hand touches your " + player.cockDescript(0) + " and you swoon, pumping your hips lewdly as you submit.\n", false);
			}
			else {
				outputText("  Your whole body blushes as your lips tingle with some unnatural sensation.  Her lips were drugged!  Your whole body flushes as arousal begins to course through your veins.  ", false);
				game.sophieScene.luststickApplication(2);
				game.dynStats("lus", 8+player.lib/10);
				if (player.lust < 70) outputText("The drugged lip-gloss is starting to get to you!\n", false);
				else if (player.lust < 80) outputText("Her curvy thighs look so inviting.  You barely stop yourself before you climb in between them!\n", false);
				else if (player.lust < 90) outputText("A trickle of pre-cum leaks from " + player.sMultiCockDesc() + ".  Sophie coos, \"<i>Why don't you give in and let mommy Sophie drain out all that juicy cum?</i>\"\n", false);
				else if (player.lust < 100) outputText(player.SMultiCockDesc() + " twitches and bounces in time with your heartbeat, practically pulling you towards Sophie's gaping, pink-linked snatch.\n", false);
				else outputText("So horny.  You need to copulate - no, fuck - right NOW.  Your hand touches your " + player.cockDescript(0) + " and you swoon, pumping your hips lewdly as you submit.\n", false);
			}
		}
		
		//Harpy-Boating (Only used on males)
		//Takes off and flies directly at PC, locking her hips 
		//around PC's torso and smothering the PC with breasts 
		//for a few moments.
		//Easily dodged with evade or flexibility.
		private function sophieHarpyBoatsPC():void {
			game.sophieBimbo.sophieSprite();
			outputText(capitalA + short + " flaps her wings and launches herself forwards with her talons up.  ", false);
			//Blind dodge change
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2) {
				outputText(capitalA + short + "'s talons are easy to avoid thanks to her blindness!\n", false);
				return;
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4) +80)) > 80) {
				outputText(a + short + "'s movements are incredibly fast but you manage to sidestep them.\n", false);
				return;
			}
			//Determine if evaded
			if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 60) {
				outputText("Using your skills at evading attacks, you determine " + a + short + " is aiming for your upper body and slide under the attack.\n", false);
				return;
			}
			if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 40 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s attack.\n", false);
				return;
			}
			//Determine if cat'ed
			if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 40) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "", false);
				outputText("'s attack.\n", false);
				return;
			}
			//YOU GOT HIT SON
			outputText("She hits you hard, nearly bowling you over.  Thankfully, her talons passed to either side of your torso.  They lock together behind your back and your face is pulled tightly into Sophie's smotheringly large mounds!", false);
			if (rand(2) == 0) outputText("  She jiggles them around you pleasantly and coos, \"<i>Don't fight it baby.  Just let your body do what comes naturally.</i>\"\n", false);
			else outputText("  She runs her long fingernails through your hair as she whispers, \"<i>Why fight it?  I'll make you feel so good.  Just relax and play with momma Sophie's tits.</i>\"\n", false);
			game.dynStats("lus", (13 + player.sens/10));
		}
		
		//Compulsion (Male Only)
		private function sophieCompulsionAttack():void {
			game.sophieBimbo.sophieSprite();
			outputText("Sophie spreads her thick thighs and slips four fingers into her slippery sex.  She commands, \"<i>Touch yourself for me.  Be a good pet and masturbate for me.</i>\"  ", false);
			//Autosucceeds if player inte < 40
			//autofails if player inte > 80
			//Player fails:
			if (player.inte < 40 || (player.inte < 80 && rand(40) > (player.inte - 40))) {
				outputText("You moan out loud as your arms move of their own volition.  They reach inside your " + player.armorName + " and stroke " + player.sMultiCockDesc() + ", caress the tip, and continue to fondle you a few moments.", false);
				outputText("Even after regaining control of your limbs, you're left far more turned on by the ordeal.", false);
				game.dynStats("lus", (15 + player.cor/20 + player.lib/20));
			}
			//Player resists
			else {
				outputText("You can feel her words carrying the force of a magical compulsion behind them, but you focus your willpower and overcome it.", false);
			}
		}
		
		//ON FEMALE PCz
		//Talons (Female Only)
		//High damage attack easily avoided by evade/flexibility.
		private function talonsSophie():void {
			game.sophieBimbo.sophieSprite();
			outputText("Sophie pulls her leg up, cocking her thigh dangerously.  Look out!  ", false);
			var damage:Number = 0;
			//Blind dodge change
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2) {
				outputText(capitalA + short + "'s talons are easy to avoid thanks to her blindness!\n", false);
				return;
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4) +80)) > 80) {
				outputText(a + short + "'s tears through the air, but you manage to just barely dodge it.\n", false);
				return;
			}
			//Determine if evaded
			if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 60) {
				outputText("Using your skills at evading attacks, you watch " + a + short + " and deftly sidestep her brutal talons.\n", false);
				return;
			}
			if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 30 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s attack.\n", false);
				return;
			}
			//Determine if cat'ed
			if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 40) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "", false);
				outputText("'s attack.\n", false);
				return;
			}
			outputText("Her leg lashes forwards, lightning-quick, and tears bloody gashes into your " + player.skinDesc + " with her razor-sharp talons! ", false);
			//Determine damage - str modified by enemy toughness!
			damage = int((str + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if (damage < 0) damage = 0;
			damage += 40;
			damage = player.takeDamage(damage);
			outputText("(" + damage + ")\n", false);
			
		}
		//Batter (Female Only)
		//Batters PC with wings – 4x attack impossible to dodge.*/
		private function batterAttackSophie():void {
			game.sophieBimbo.sophieSprite();
			var damage:Number = 0;
			outputText("Sophie comes at you in a flurry of beating wings!  There's no way to dodge the flurry of strikes!\n", false);
			
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - Math.random()*(player.tou) - player.armorDef);
			if (damage < 0) damage = 0;
			damage = player.takeDamage(damage);
			outputText("Her left primary wing batters your head! (" + damage + ")\n", false);
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - Math.random()*(player.tou) - player.armorDef);
			if (damage < 0) damage = 0;
			damage = player.takeDamage(damage);
			outputText("Her right, wing-like arm slaps at your torso! (" + damage + ")\n", false);
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - Math.random()*(player.tou) - player.armorDef);
			if (damage < 0) damage = 0;
			damage = player.takeDamage(damage);
			outputText("Her other feathery arm punches at your shoulder! (" + damage + ")\n", false);
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - Math.random()*(player.tou) - player.armorDef);
			if (damage < 0) damage = 0;
			damage = player.takeDamage(damage);
			outputText("Her right wing slams into the other side of your head! (" + damage + ")\n", false);
		}

		override protected function performCombatAction():void
		{
			//Sophie has special AI in harpySophie.as
			game.sophieBimbo.sophieSprite();
			var select:Number = 1;
			var rando:Number = 1;
//Update attacks for girls/neuters
			if (!player.hasCock() || findStatusEffect(StatusEffects.BimboBrawl) >= 0) {
				//Talons
				special1 = talonsSophie;
				//Batter
				special2 = batterAttackSophie;
				//Clear
				special3 = null;
			}
			//Dicks ahoy
			else {
				//kiss
				special1 = sophieKissAttack;
				//harpy-boating
				special2 = sophieHarpyBoatsPC;
				//compulsion
				special3 = sophieCompulsionAttack;
			}
			select = rand(4);
			if (select == 0) {
				eAttack();
				combatRoundOver();
				return;
			}
			if (player.hasCock() && findStatusEffect(StatusEffects.BimboBrawl) < 0) rando = 1 + rand(3);
			else rando = 1 + rand(2);
			if (rando == 1) special1();
			if (rando == 2) special2();
			if (rando == 3) special3();
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (findStatusEffect(StatusEffects.BimboBrawl) >= 0)
				game.sophieFollowerScene.beatUpDebimboSophie();
			else
				game.sophieScene.sophieLostCombat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (findStatusEffect(StatusEffects.BimboBrawl) >= 0)
				game.sophieFollowerScene.debimboSophieBeatsYouUp();
			else if (pcCameWorms) {
				outputText("\n\nYour foe seems disgusted by the display and leaves you to recover alone...");
				game.combat.cleanupAfterCombat();
			} else {
				game.sophieScene.sophieWonCombat();
			}
		}

		public function Sophie()
		{
			super(true);
			trace("Sophie Constructor!");
		
			this.a = "";
			this.short = "Sophie";
			this.imageName = "sophie";
			this.long = "Sophie is approximately the size of a normal human woman, not counting the large feathery wings that sprout from her back.  Her face is gorgeous, with large rounded eyes and glimmering amber lip-gloss painted on her lush, kissable lips.  In spite of her beauty, it's clear from the barely discernible laugh lines around her mouth that she's been around long to enough to have quite a few children.  Her feathers are light pink, though the downy plumage that comprises her 'hair' is brighter than the rest.  She moves with practiced grace despite the large, jiggling breasts that hang from her chest.  Judging from her confident movements, she's an experienced fighter.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_GAPING_WIDE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 5*12+5;
			this.hipRating = HIP_RATING_INHUMANLY_WIDE;
			this.buttRating = BUTT_RATING_EXPANSIVE;
			this.skinTone = "pink";
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinDesc = "feathers";
			this.hairColor = "pink";
			this.hairLength = 16;
			initStrTouSpeInte(55, 40, 110, 60);
			initLibSensCor(60, 50, 60);
			this.weaponName = "talons";
			this.weaponVerb="slashing talons";
			this.weaponAttack = 20;
			this.armorName = "feathers";
			this.armorDef = 5;
			this.bonusHP = 250;
			this.lust = 10;
			this.lustVuln = .3;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 11;
			this.gems = 20 + rand(25);
			this.drop = new ChainedDrop().add(armors.W_ROBES,1/10)
					.elseDrop(consumables.GLDSEED);
			this.wingType = WING_TYPE_HARPY;
			this.wingDesc = "large feathery";
			this.special1 = harpyUberCharge;
			this.special2 = harpyTease;
			checkMonster();
		}

	}

}