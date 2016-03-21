package classes.Scenes.Dungeons.DeepCave
{
	import classes.*;
	import classes.internals.*;

	public class Zetaz extends Monster
	{
		public function zetazAI():void {
			//Zetaz taunts.
			zetazTaunt();
			outputText("\n\n", false);
			//If afflicted by blind or whispered and over 50% lust,
			//burns lust and clears statuses before continuing with 
			//turn.
			if (lust > 50 && (findStatusEffect(StatusEffects.Fear) >= 0 || findStatusEffect(StatusEffects.Blind) >= 0)) {
				removeStatusEffect(StatusEffects.Fear);
				removeStatusEffect(StatusEffects.Blind);
				lust -= 10;
				outputText("Zetaz blinks and shakes his head while stroking himself.  After a second his turgid member loses some of its rigidity, but his gaze has become clear.  He's somehow consumed some of his lust to clear away your magic!", false);
			}
			
			//STANDARD COMBAT STATUS AFFECTS HERE
			if (findStatusEffect(StatusEffects.Stunned) >= 0) {
				outputText("Your foe is too dazed from your last hit to strike back!", false);
				removeStatusEffect(StatusEffects.Stunned);
				combatRoundOver();
				return;
			}
			var select:Number=1;
			var rando:Number=1;
			//Exgartuan gets to do stuff!
			if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0 && player.statusEffectv2(StatusEffects.Exgartuan) == 0 && rand(3) == 0) {
				game.exgartuan.exgartuanCombatUpdate();
				outputText("\n\n", false);
			}
			if (findStatusEffect(StatusEffects.Constricted) >= 0) {
				//Enemy struggles - 
				outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.", false);
				if (statusEffectv1(StatusEffects.Constricted) <= 0) {
					outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.", false);
					removeStatusEffect(StatusEffects.Constricted);
				}
				addStatusValue(StatusEffects.Constricted,1,-1);
				combatRoundOver();
				return;
			}
			//STANDARD COMBAT STATUS AFFECTS END HERE
			//-If over 50 lust and below 50% hp
			//--burns 20 lust to restore 20% hp. 
			if (lust > 50 && HPRatio() <= .5) {
				outputText("The imp lord shudders from his wounds and the pulsing member that's risen from under his tattered loincloth.  He strokes it and murmurs under his breath for a few moments.  You're so busy watching the spectacle of his masturbation that you nearly miss the sight of his bruises and wounds closing!  Zetaz releases his swollen member, and it deflates slightly.  He's used some kind of black magic to convert some of his lust into health!", false);
				addHP(0.25 * eMaxHP());
				lust -= 20;
				game.dynStats("lus", 2);
			}
			else {
				var attackChoice:Number = rand(3);
				if (attackChoice == 0) {
					//Chucks faux-heat draft ala goblins. - 
					outputText("Zetaz grabs a bottle from a drawer and hurls it in your direction!  ", false);
					if ((player.findPerk(PerkLib.Evade) >= 0 && rand(4) == 0) ||
						(player.findPerk(PerkLib.Flexibility) >= 0 && rand(6) == 0) ||
						(player.spe > 65 && rand(10) == 0) ||
						(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 20 && player.armorName == "red, high-society bodysuit")) {
						outputText("You sidestep it a moment before it shatters on the wall, soaking the tapestries with red fluid!", false);
					}
					else {
						outputText("You try to avoid it, but the fragile glass shatters against you, coating you in sticky red liquid.  It seeps into your " + player.skinDesc + " and leaves a pleasant, residual tingle in its wake.  Oh no...", false);
						//[Applies: "Temporary Heat" status]
						if (player.findStatusEffect(StatusEffects.TemporaryHeat) < 0) player.createStatusEffect(StatusEffects.TemporaryHeat,0,0,0,0);
					}
				}
				else if (attackChoice == 1) {
					//'Gust' – channels a pidgy's spirit to beat 
					//his wings and kick up dust, blinding the PC 
					//next turn and dealing light damage. - 
					outputText("The imp leaps into the air with a powerful spring, beating his wings hard to suspend himself in the center of his bedchamber.  Dust kicks up into the air from the force of his flight and turns the room into a blinding tornado!  Small objects smack off of you, ", false);
					//(causing little damage/
					if (player.tou > 60) outputText("causing little damage", false);
					else {
						var dmg:Number = 1 + rand(6);
						outputText("wounding you slightly ", false);
						dmg = player.takeDamage(dmg, true);
					}
					outputText(" while the dust gets into your eyes, temporarily blinding you!", false);
					player.createStatusEffect(StatusEffects.Blind,1,0,0,0);
				}
				//Gigarouse – A stronger version of normal imp's 
				//'arouse' spell. - copy normal arouse text and 
				//spice it up with extra wetness!
				else {
					gigaArouse();
				}
			}
			combatRoundOver();
		}
		
		public function gigaArouse():void {
			outputText("You see " + a + short + " make familiar arcane gestures at you, but his motions seem a lot more over the top than you'd expect from an imp.\n\n", false);
			game.dynStats("lus", rand(player.lib/10) +player.cor/10+15);
			if (player.lust < 30) outputText("Your nethers pulse with pleasant warmth that brings to mind pleasant sexual memories.  ", false);
			if (player.lust >= 30 && player.lust < 60) outputText("Blood rushes to your groin in a rush as your body is hit by a tidal-wave of arousal.  ", false);
			if (player.lust >= 60) outputText("Your mouth begins to drool as you close your eyes and imagine yourself sucking off Zetaz, then riding him, letting him sate his desires in your inviting flesh.  The unnatural visions send pulses of lust through you so strongly that your body shivers.  ", false);
			if (player.cocks.length > 0) {
				if (player.lust >= 60 && player.cocks.length > 0) outputText("You feel " + player.SMultiCockDesc() + " dribble pre-cum, bouncing with each beat of your heart and aching to be touched.  ", false);
				if (player.lust >= 30 && player.lust < 60 && player.cocks.length == 1) outputText(player.SMultiCockDesc() + " hardens and twitches, distracting you further.  ", false);
			}
			if (player.vaginas.length > 0) {
				if (player.lust >= 60 && player.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL && player.vaginas.length == 1) outputText("Your " + player.vaginaDescript() + " dampens perceptibly, feeling very empty.  ", false);
				if (player.lust >= 60 && player.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET && player.vaginas.length > 0) outputText("Your crotch becomes sticky with girl-lust, making it clear to " + a + short + " just how welcome your body finds the spell.  ", false);
				if (player.lust >= 60 && player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK && player.vaginas.length == 1) outputText("Your " + player.vaginaDescript() + " becomes sloppy and wet, dribbling with desire to be mounted and fucked.  ", false);
				if (player.lust >= 60 && player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING && player.vaginas.length > 0) outputText("Thick runners of girl-lube stream down the insides of your thighs as your crotch gives into the demonic magics.  You wonder what " + a + short + "'s cock would feel like inside you?  ", false);
				if (player.lust >= 60 && player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING && player.vaginas.length == 1) outputText("Your " + player.vaginaDescript() + " instantly soaks your groin with the heady proof of your need.  You wonder just how slippery you could " + a + short + "'s dick when it's rammed inside you?  ", false);
			}
			if (player.lust >= player.maxLust()) doNext(game.combat.endLustLoss)
			else combatRoundOver();
		}

		
		public function zetazTaunt():void {
			if (findStatusEffect(StatusEffects.round) < 0) {
				createStatusEffect(StatusEffects.round,1,0,0,0);
				outputText("Zetaz asks, \"<i>Do you even realize how badly you fucked up my life, ", false);
				if (player.humanScore() >= 4) outputText("human", false);
				else outputText("'human'", false);
				outputText("?  No, of course not.  That's the kind of attitude I'd expect from one of you!</i>\"", false);
			}
			else {
				addStatusValue(StatusEffects.round,1,1);
				if (statusEffectv1(StatusEffects.round) == 2) outputText("\"<i>I lost my post!  And when you screwed up the factory?  I barely escaped with my life!  You ruined EVERYTHING!</i>\" screams Zetaz.", false);
				else if (statusEffectv1(StatusEffects.round) == 3) outputText("Zetaz snarls, \"<i>Do you know how hard it is to hide from Lethice?  DO YOU HAVE ANY IDEA!?  I've had to live in this fetid excuse for a jungle, and just when I found some friends and made it livable, you show up and DESTROY EVERYTHING!</i>\"", false);
				else if (statusEffectv1(StatusEffects.round) == 4) outputText("Zetaz explains, \"<i>I won't let you go.  I'm going to break you.</i>\"", false);
				else if (statusEffectv1(StatusEffects.round) == 5) outputText("\"<i>Would it have been that bad to go along with me?  You've seen the factory.  We would've kept you fed, warm, and provided you with limitless pleasure.  You would've tasted heaven and served a greater purpose.  It's not too late.  If you come willingly I can make sure they find a good machine to milk you with,</i>\" offers the imp lord.", false);
				else if (statusEffectv1(StatusEffects.round) == 6) outputText("\"<i>Why won't you fall?</i>\" questions Zetaz incredulously.", false);
				else if (statusEffectv1(StatusEffects.round) == 7) outputText("The imp lord suggests, \"<i>If you give up and let me fuck your ass maybe I'll let you go.</i>\"", false);
				else if (statusEffectv1(StatusEffects.round) == 8) outputText("Zetaz pants, \"<i>Just give up!  I'm nothing like the weakling you met so long ago!  I've been through hell to get here and I'm not giving it up just because you've shown up to destroy my hard work!</i>\"", false);
				else outputText("He glares at you silently.", false);
			}
		}

		override public function doAI():void
		{
			zetazAI();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.deepcave.defeatZetaz();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem put off enough to care...");
				doNext(game.combat.endLustLoss);
			} else {
				game.dungeons.deepcave.loseToZetaz();
			}
		}

		public function Zetaz()
		{
			this.a = "";
			this.short = "Zetaz";
			this.imageName = "zetaz";
			this.long = "Zetaz has gone from a pipsqueak to the biggest imp you've seen!  Though he has the familiar red skin, curving pointed horns, and wings you would expect to find on an imp, his feet now end in hooves, and his body is covered with thick layers of muscle.  If the dramatic change in appearance is any indication, he's had to toughen up nearly as much as yourself over the past "+(game.model.time.days < 60? "weeks":"months") +".  Zetaz still wears the trademark imp loincloth, though it bulges and shifts with his movements in a way that suggest a considerable flaccid size and large, full sack.  His shoulders are wrapped with studded leather and his wrists are covered with metallic bracers.  The imp has clearly invested in at least a little additional protection.  It does not look like he carries a weapon.";
			this.createCock(rand(2) + 11,2.5,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = 4*12+1;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.lowerBody = LOWER_BODY_TYPE_KANGAROO;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(65, 60, 45, 52);
			initLibSensCor(55, 35, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.armorName = "leathery skin";
			this.bonusHP = 350;
			this.lust = 40;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 12;
			this.gems = rand(55) + 150;
			this.additionalXP = 100;
			this.drop = new WeightedDrop(consumables.BIMBOLQ, 1);
			this.wingType = WING_TYPE_IMP;
			this.wingDesc = "small";
			this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}