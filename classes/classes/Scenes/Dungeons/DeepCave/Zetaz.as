package classes.Scenes.Dungeons.DeepCave
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Zetaz extends Monster
	{
		public function zetazAI():void {
			//Zetaz taunts.
			zetazTaunt();
			outputText("\n\n");
			//If afflicted by blind or whispered and over 50% lust,
			//burns lust and clears statuses before continuing with 
			//turn.
			if(lust > 50 && (hasStatusEffect(StatusEffects.Fear) || hasStatusEffect(StatusEffects.Blind))) {
				removeStatusEffect(StatusEffects.Fear);
				removeStatusEffect(StatusEffects.Blind);
				lust -= 10;
				outputText("Zetaz blinks and shakes his head while stroking himself.  After a second his turgid member loses some of its rigidity, but his gaze has become clear.  He's somehow consumed some of his lust to clear away your magic!");
			}
			
			//STANDARD COMBAT STATUS EFFECTS HERE
			if(hasStatusEffect(StatusEffects.Stunned)) {
				outputText("Your foe is too dazed from your last hit to strike back!");
				removeStatusEffect(StatusEffects.Stunned);
				return;
			}
			var select:Number=1;
			var rando:Number=1;
			//Exgartuan gets to do stuff!
			if(player.hasStatusEffect(StatusEffects.Exgartuan) && player.statusEffectv2(StatusEffects.Exgartuan) == 0 && rand(3) == 0) {
				SceneLib.exgartuan.exgartuanCombatUpdate();
				outputText("\n\n");
			}
			if(hasStatusEffect(StatusEffects.Constricted)) {
				//Enemy struggles - 
				outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.");
				if(statusEffectv1(StatusEffects.Constricted) <= 0) {
					outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.");
					removeStatusEffect(StatusEffects.Constricted);
				}
				addStatusValue(StatusEffects.Constricted,1,-1);
				return;
			}
			//STANDARD COMBAT STATUS AFFECTS END HERE
			//-If over 50 lust and below 50% hp
			//--burns 20 lust to restore 20% hp. 
			if(lust > 50 && HPRatio() <= .5) {
				outputText("The imp lord shudders from his wounds and the pulsing member that's risen from under his tattered loincloth.  He strokes it and murmurs under his breath for a few moments.  You're so busy watching the spectacle of his masturbation that you nearly miss the sight of his bruises and wounds closing!  Zetaz releases his swollen member, and it deflates slightly.  He's used some kind of black magic to convert some of his lust into health!");
				addHP(0.25 * maxHP());
				lust -= 20;
				player.dynStats("lus", 2);
			}
			else {
				var attackChoice:Number = rand(3);
				if(attackChoice == 0) {
					//Chucks faux-heat draft ala goblins. - 
					outputText("Zetaz grabs a bottle from a drawer and hurls it in your direction!  ");
					if((player.findPerk(PerkLib.Evade) >= 0 && rand(4) == 0) ||
						(player.findPerk(PerkLib.Flexibility) >= 0 && rand(6) == 0) ||
						(player.spe > 65 && rand(10) == 0) ||
						(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 20 && player.armorName == "red, high-society bodysuit")) {
						outputText("You sidestep it a moment before it shatters on the wall, soaking the tapestries with red fluid!");
					}
					else {
						outputText("You try to avoid it, but the fragile glass shatters against you, coating you in sticky red liquid.  It seeps into your [skin.type] and leaves a pleasant, residual tingle in its wake.  Oh no...");
						//[Applies: "Temporary Heat" status]
						if(!player.hasStatusEffect(StatusEffects.TemporaryHeat)) player.createStatusEffect(StatusEffects.TemporaryHeat,0,0,0,0);
					}
				}
				else if(attackChoice == 1) {
					//'Gust' – channels a pidgy's spirit to beat 
					//his wings and kick up dust, blinding the PC 
					//next turn and dealing light damage. - 
					outputText("The imp leaps into the air with a powerful spring, beating his wings hard to suspend himself in the center of his bedchamber.  Dust kicks up into the air from the force of his flight and turns the room into a blinding tornado!  Small objects smack off of you, ");
					//(causing little damage/
					if(player.tou > 60) outputText("causing little damage");
					else {
						var dmg:Number = 1 + rand(6);
						outputText("wounding you slightly ");
						dmg = player.takePhysDamage(dmg, true);
					}
					outputText(" while the dust gets into your eyes, temporarily blinding you!");
					player.createStatusEffect(StatusEffects.Blind,1,0,0,0);
				}
				//Gigarouse – A stronger version of normal imp's 
				//'arouse' spell. - copy normal arouse text and 
				//spice it up with extra wetness!
				else {
					gigaArouse();
				}
			}
		}
		
		public function gigaArouse():void {
			outputText("You see " + a + short + " make familiar arcane gestures at you, but his motions seem a lot more over the top than you'd expect from an imp.\n\n");
			player.dynStats("lus", rand(player.lib/10)+player.cor/10+15);
			if(player.lust < 30) outputText("Your nethers pulse with pleasant warmth that brings to mind pleasant sexual memories.  ");
			if(player.lust >= 30 && player.lust < 60) outputText("Blood rushes to your groin in a rush as your body is hit by a tidal-wave of arousal.  ");
			if(player.lust >= 60) outputText("Your mouth begins to drool as you close your eyes and imagine yourself sucking off Zetaz, then riding him, letting him sate his desires in your inviting flesh.  The unnatural visions send pulses of lust through you so strongly that your body shivers.  ");
			if(player.cocks.length > 0) {
				if(player.lust >= 60 && player.cocks.length > 0) outputText("You feel [eachcock] dribble pre-cum, bouncing with each beat of your heart and aching to be touched.  ");
				if(player.lust >= 30 && player.lust < 60 && player.cocks.length == 1) outputText(player.SMultiCockDesc() + " hardens and twitches, distracting you further.  ");
			}
			if(player.vaginas.length > 0) {
				if(player.lust >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL && player.vaginas.length == 1) outputText("Your [vagina] dampens perceptibly, feeling very empty.  ");
				if(player.lust >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET && player.vaginas.length > 0) outputText("Your crotch becomes sticky with girl-lust, making it clear to " + a + short + " just how welcome your body finds the spell.  ");
				if(player.lust >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK && player.vaginas.length == 1) outputText("Your [vagina] becomes sloppy and wet, dribbling with desire to be mounted and fucked.  ");
				if(player.lust >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING && player.vaginas.length > 0) outputText("Thick runners of girl-lube stream down the insides of your thighs as your crotch gives into the demonic magics.  You wonder what " + a + short + "'s cock would feel like inside you?  ");
				if (player.lust >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING && player.vaginas.length == 1) outputText("Your [vagina] instantly soaks your groin with the heady proof of your need.  You wonder just how slippery you could " + a + short + "'s dick when it's rammed inside you?  ");
			}
			if(player.lust >= player.maxLust()) doNext(SceneLib.combat.endLustLoss);
		}

		
		public function zetazTaunt():void {
			if(!hasStatusEffect(StatusEffects.round)) {
				createStatusEffect(StatusEffects.round,1,0,0,0);
				outputText("Zetaz asks, \"<i>Do you even realize how badly you fucked up my life, ");
				if(player.humanScore() >= 4) outputText("human");
				else outputText("'human'");
				outputText("?  No, of course not.  That's the kind of attitude I'd expect from one of you!</i>\"");
			}
			else {
				addStatusValue(StatusEffects.round,1,1);
				if(statusEffectv1(StatusEffects.round) == 2) outputText("\"<i>I lost my post!  And when you screwed up the factory?  I barely escaped with my life!  You ruined EVERYTHING!</i>\" screams Zetaz.");
				else if(statusEffectv1(StatusEffects.round) == 3) outputText("Zetaz snarls, \"<i>Do you know how hard it is to hide from Lethice?  DO YOU HAVE ANY IDEA!?  I've had to live in this fetid excuse for a jungle, and just when I found some friends and made it livable, you show up and DESTROY EVERYTHING!</i>\"");
				else if(statusEffectv1(StatusEffects.round) == 4) outputText("Zetaz explains, \"<i>I won't let you go.  I'm going to break you.</i>\"");
				else if(statusEffectv1(StatusEffects.round) == 5) outputText("\"<i>Would it have been that bad to go along with me?  You've seen the factory.  We would've kept you fed, warm, and provided you with limitless pleasure.  You would've tasted heaven and served a greater purpose.  It's not too late.  If you come willingly I can make sure they find a good machine to milk you with,</i>\" offers the imp lord.");
				else if(statusEffectv1(StatusEffects.round) == 6) outputText("\"<i>Why won't you fall?</i>\" questions Zetaz incredulously.");
				else if(statusEffectv1(StatusEffects.round) == 7) outputText("The imp lord suggests, \"<i>If you give up and let me fuck your ass maybe I'll let you go.</i>\"");
				else if(statusEffectv1(StatusEffects.round) == 8) outputText("Zetaz pants, \"<i>Just give up!  I'm nothing like the weakling you met so long ago!  I've been through hell to get here and I'm not giving it up just because you've shown up to destroy my hard work!</i>\"");
				else outputText("He glares at you silently.");
			}
		}

		override public function doAI():void
		{
			zetazAI();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.deepcave.defeatZetaz();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem put off enough to care...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.dungeons.deepcave.loseToZetaz();
			}
		}

		public function Zetaz()
		{
			this.a = "";
			this.short = "Zetaz";
			this.imageName = "zetaz";
			this.long = "Zetaz has gone from a pipsqueak to the biggest imp you've seen!  Though he has the familiar red skin, curving pointed horns, and wings you would expect to find on an imp, his feet now end in hooves, and his body is covered with thick layers of muscle.  If the dramatic change in appearance is any indication, he's had to toughen up nearly as much as yourself over the past "+(game.model.time.days < 60? "weeks":"months")+".  Zetaz still wears the trademark imp loincloth, though it bulges and shifts with his movements in a way that suggest a considerable flaccid size and large, full sack.  His shoulders are wrapped with studded leather and his wrists are covered with metallic bracers.  The imp has clearly invested in at least a little additional protection.  It does not look like he carries a weapon.";
			this.createCock(rand(2) + 11,2.5,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 4*12+1;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.lowerBody = LowerBody.KANGAROO;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(125, 100, 70, 55);
			initWisLibSensCor(55, 55, 35, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 21;
			this.armorName = "leathery skin";
			this.armorDef = 14;
			this.bonusHP = 600;
			this.bonusLust = 50;
			this.lust = 40;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 30;
			this.gems = rand(75) + 175;
			this.additionalXP = 200;
			this.drop = new WeightedDrop(consumables.BIMBOLQ, 1);
			this.wings.type = Wings.IMP;
			this.wings.desc = "small";
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
