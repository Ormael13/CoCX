package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.Scenes.Areas.HighMountains.Harpy;
import classes.Scenes.SceneLib;
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
			SceneLib.sophieBimbo.sophieSprite();
			outputText("Sophie bobs and weaves as she closes the distance between you in an instant.  ");
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText(capitalA + short + " looks like she's trying to kiss you, but it's easy to avoid the blind harpy!\n");
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("Sophie changes direction in a flash, trying to slip inside your guard, but you manage to sidestep the incredibly fast harpy's attack.\n");
				return;
			}
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.\n");
				return;
			}
			if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s attack.\n");
				return;
			}
			//Determine if cat'ed
			if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "");
				outputText("'s attack.\n");
				return;
			}
			//YOU GOT HIT SON
			outputText("Before you can react, she gives you a chaste peck on the lips.  The harpy pulls back with a sultry smile, watching you expectantly.");
			
			//Already affected by it
			if(player.hasStatusEffect(StatusEffects.Luststick)) {
				outputText("  Blood rushes to [eachcock] as you grow so hard so fast that it hurts.  ");
				SceneLib.sophieScene.luststickApplication(2);
				player.dynStats("lus", (12+player.lib/10));
				if(player.lust < 0.7*player.maxLust()) outputText("The drugged lip-gloss is starting to get to you!\n");
				else if(player.lust < 0.8*player.maxLust()) outputText("Her curvy thighs look so inviting.  You barely stop yourself before you climb in between them!\n");
				else if(player.lust < 0.9*player.maxLust()) outputText("A trickle of pre-cum leaks from [eachcock].  Sophie coos, \"<i>Why don't you give in and let mommy Sophie drain out all that juicy cum?</i>\"\n");
				else if(player.lust < 1.0*player.maxLust()) outputText(player.SMultiCockDesc() + " twitches and bounces in time with your heartbeat, practically pulling you towards Sophie's gaping, pink-linked snatch.\n");
				else outputText("So horny.  You need to copulate - no, fuck - right NOW.  Your hand touches your [cock] and you swoon, pumping your hips lewdly as you submit.\n");
			}
			else {
				outputText("  Your whole body blushes as your lips tingle with some unnatural sensation.  Her lips were drugged!  Your whole body flushes as arousal begins to course through your veins.  ");
				SceneLib.sophieScene.luststickApplication(2);
				player.dynStats("lus", 8+player.lib/10);
				if(player.lust < 0.7*player.maxLust()) outputText("The drugged lip-gloss is starting to get to you!\n");
				else if(player.lust < 0.8*player.maxLust()) outputText("Her curvy thighs look so inviting.  You barely stop yourself before you climb in between them!\n");
				else if(player.lust < 0.9*player.maxLust()) outputText("A trickle of pre-cum leaks from [eachcock].  Sophie coos, \"<i>Why don't you give in and let mommy Sophie drain out all that juicy cum?</i>\"\n");
				else if(player.lust < 1.0*player.maxLust()) outputText(player.SMultiCockDesc() + " twitches and bounces in time with your heartbeat, practically pulling you towards Sophie's gaping, pink-linked snatch.\n");
				else outputText("So horny.  You need to copulate - no, fuck - right NOW.  Your hand touches your [cock] and you swoon, pumping your hips lewdly as you submit.\n");
			}
		}
		
		//Harpy-Boating (Only used on males)
		//Takes off and flies directly at PC, locking her hips 
		//around PC's torso and smothering the PC with breasts 
		//for a few moments.
		//Easily dodged with evade or flexibility.
		private function sophieHarpyBoatsPC():void {
			SceneLib.sophieBimbo.sophieSprite();
			outputText(capitalA + short + " flaps her wings and launches herself forwards with her talons up.  ");
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText(capitalA + short + "'s talons are easy to avoid thanks to her blindness!\n");
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText(a + short + "'s movements are incredibly fast but you manage to sidestep them.\n");
				return;
			}
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 60) {
				outputText("Using your skills at evading attacks, you determine " + a + short + " is aiming for your upper body and slide under the attack.\n");
				return;
			}
			if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 40 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s attack.\n");
				return;
			}
			//Determine if cat'ed
			if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 40) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "");
				outputText("'s attack.\n");
				return;
			}
			//YOU GOT HIT SON
			outputText("She hits you hard, nearly bowling you over.  Thankfully, her talons passed to either side of your torso.  They lock together behind your back and your face is pulled tightly into Sophie's smotheringly large mounds!");
			if(rand(2) == 0) outputText("  She jiggles them around you pleasantly and coos, \"<i>Don't fight it baby.  Just let your body do what comes naturally.</i>\"\n");
			else outputText("  She runs her long fingernails through your hair as she whispers, \"<i>Why fight it?  I'll make you feel so good.  Just relax and play with momma Sophie's tits.</i>\"\n");
			player.dynStats("lus", (13 + player.effectiveSensitivity()/10));
		}
		
		//Compulsion (Male Only)
		private function sophieCompulsionAttack():void {
			SceneLib.sophieBimbo.sophieSprite();
			outputText("Sophie spreads her thick thighs and slips four fingers into her slippery sex.  She commands, \"<i>Touch yourself for me.  Be a good pet and masturbate for me.</i>\"  ");
			//Autosucceeds if player inte < 40
			//autofails if player inte > 80
			//Player fails:
			if(player.inte < 40 || (player.inte < 80 && rand(40) > (player.inte - 40))) {
				outputText("You moan out loud as your arms move of their own volition.  They reach inside your [armor] and stroke [eachcock], caress the tip, and continue to fondle you a few moments.");
				outputText("Even after regaining control of your limbs, you're left far more turned on by the ordeal.");
				player.dynStats("lus", (15 + player.cor/20 + player.lib/20));
			}
			//Player resists
			else {
				outputText("You can feel her words carrying the force of a magical compulsion behind them, but you focus your willpower and overcome it.");
			}
		}
		
		//ON FEMALE PCz
		//Talons (Female Only)
		//High damage attack easily avoided by evade/flexibility.
		private function talonsSophie():void {
			SceneLib.sophieBimbo.sophieSprite();
			outputText("Sophie pulls her leg up, cocking her thigh dangerously.  Look out!  ");
			var damage:Number = 0;
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText(capitalA + short + "'s talons are easy to avoid thanks to her blindness!\n");
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText(a + short + "'s tears through the air, but you manage to just barely dodge it.\n");
				return;
			}
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 60) {
				outputText("Using your skills at evading attacks, you watch " + a + short + " and deftly sidestep her brutal talons.\n");
				return;
			}
			if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 30 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s attack.\n");
				return;
			}
			//Determine if cat'ed
			if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 40) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "");
				outputText("'s attack.\n");
				return;
			}
			outputText("Her leg lashes forwards, lightning-quick, and tears bloody gashes into your [skin.type] with her razor-sharp talons! ");
			//Determine damage - str modified by enemy toughness!
			damage = int((str + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if(damage < 0) damage = 0;
			damage += 40;
			damage = player.takePhysDamage(damage);
			outputText("(" + damage + ")\n");
			
		}
		//Batter (Female Only)
		//Batters PC with wings – 4x attack impossible to dodge.*/
		private function batterAttackSophie():void {
			SceneLib.sophieBimbo.sophieSprite();
			var damage:Number = 0;
			outputText("Sophie comes at you in a flurry of beating wings!  There's no way to dodge the flurry of strikes!\n");
			
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - Math.random()*(player.tou) - player.armorDef);
			if(damage < 0) damage = 0;
			damage = player.takePhysDamage(damage);
			outputText("Her left primary wing batters your head! (" + damage + ")\n");
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - Math.random()*(player.tou) - player.armorDef);
			if(damage < 0) damage = 0;
			damage = player.takePhysDamage(damage);
			outputText("Her right, wing-like arm slaps at your torso! (" + damage + ")\n");
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - Math.random()*(player.tou) - player.armorDef);
			if(damage < 0) damage = 0;
			damage = player.takePhysDamage(damage);
			outputText("Her other feathery arm punches at your shoulder! (" + damage + ")\n");
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - Math.random()*(player.tou) - player.armorDef);
			if(damage < 0) damage = 0;
			damage = player.takePhysDamage(damage);
			outputText("Her right wing slams into the other side of your head! (" + damage + ")\n");
		}

		override protected function performCombatAction():void
		{
			//Sophie has special AI in harpySophie.as
			SceneLib.sophieBimbo.sophieSprite();
			var select:Number = 1;
			var rando:Number = 1;
//Update attacks for girls/neuters
			if (!player.hasCock() || hasStatusEffect(StatusEffects.BimboBrawl)) {
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
				return;
			}
			if (player.hasCock() && !hasStatusEffect(StatusEffects.BimboBrawl)) rando = 1 + rand(3);
			else rando = 1 + rand(2);
			if (rando == 1) special1();
			if (rando == 2) special2();
			if (rando == 3) special3();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.BimboBrawl))
				SceneLib.sophieFollowerScene.beatUpDebimboSophie();
			else
				SceneLib.sophieScene.sophieLostCombat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.BimboBrawl))
				SceneLib.sophieFollowerScene.debimboSophieBeatsYouUp();
			else if (pcCameWorms) {
				outputText("\n\nYour foe seems disgusted by the display and leaves you to recover alone...");
				SceneLib.combat.cleanupAfterCombatImpl();
			} else {
				SceneLib.sophieScene.sophieWonCombat();
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
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING_WIDE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 5*12+5;
			this.hips.type = Hips.RATING_INHUMANLY_WIDE;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.skin.setBaseOnly({color:"pink"});
			this.skinDesc = "feathers";
			this.hairColor = "pink";
			this.hairLength = 16;
			initStrTouSpeInte(80, 70, 130, 80);
			initWisLibSensCor(80, 60, 50, 60);
			this.weaponName = "talons";
			this.weaponVerb="slashing talons";
			this.weaponAttack = 40;
			this.armorName = "feathers";
			this.armorDef = 10;
			this.armorMDef = 0;
			this.bonusHP = 300;
			this.bonusLust = 132;
			this.lust = 10;
			this.lustVuln = .3;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 22;
			this.gems = 40 + rand(45);
			this.drop = new ChainedDrop().add(armors.W_ROBES,1/10)
					.elseDrop(consumables.GLDSEED);
			this.wings.type = Wings.HARPY;
			this.wings.desc = "large feathery";
			this.special1 = harpyUberCharge;
			this.special2 = harpyTease;
			checkMonster();
		}

	}

}
