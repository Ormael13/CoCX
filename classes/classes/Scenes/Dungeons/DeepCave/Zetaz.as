package classes.Scenes.Dungeons.DeepCave
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.GlobalFlags.kFLAGS;

public class Zetaz extends Monster
	{

		public function lustHeal():void {
			outputText("The imp lord shudders from his wounds and the pulsing member that's risen from under his tattered loincloth.  He strokes it and murmurs under his breath for a few moments.  You're so busy watching the spectacle of his masturbation that you nearly miss the sight of his bruises and wounds closing!  Zetaz releases his swollen member, and it deflates slightly.  He's used some kind of black magic to convert some of his lust into health!");
			addHP(0.25 * maxHP());
			lust -= maxLust() * 0.2;
			player.takeLustDamage(eBaseDamage() / 5, true);
			createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
		}

		public function heatDraft():void {
			//Chucks faux-heat draft ala goblins. -
			outputText("Zetaz grabs a bottle from a drawer and hurls it in your direction!  ");
			if(player.getEvasionRoll()) {
				outputText("You sidestep it a moment before it shatters on the wall, soaking the tapestries with red fluid!");
			}
			else {
				outputText("You try to avoid it, but the fragile glass shatters against you, coating you in sticky red liquid.  It seeps into your [skin.type] and leaves a pleasant, residual tingle in its wake.  Oh no...");
				//[Applies: "Temporary Heat" status]
				if(!player.hasStatusEffect(StatusEffects.TemporaryHeat)) player.createStatusEffect(StatusEffects.TemporaryHeat,0,10,0,0);
			}
		}

		public function gust():void {
			//'Gust' – channels a pidgy's spirit to beat
			//his wings and kick up dust, blinding the PC
			//next turn and dealing light damage. -
			outputText("The imp leaps into the air with a powerful spring, beating his wings hard to suspend himself in the center of his bedchamber.  Dust kicks up into the air from the force of his flight and turns the room into a blinding tornado!  Small objects smack off of you, ");
			//(causing little damage/
			if(player.tou > 60) outputText("causing little damage");
			else {
				var dmg:Number = eBaseDamage();
				outputText("wounding you slightly");
				dmg = player.takePhysDamage(dmg, true);
			}
			outputText(" while the dust gets into your eyes, temporarily blinding you!");
			if (!player.isImmuneToBlind()) player.createStatusEffect(StatusEffects.Blind,1,0,0,0);
		}
		
		public function gigaArouse():void {
			outputText("You see " + a + short + " make familiar arcane gestures at you, but his motions seem a lot more over the top than you'd expect from an imp. ");
			var lustDmg:Number = inteligencescalingbonus() / 3;
			lustDmg *= 1 + (0.5 * (player.cor / 100));
			lustDmg += 15;
			
			player.takeLustDamage(lustDmg, true);
			outputText("\n");
			if(player.lust100 < 30) outputText("Your nethers pulse with pleasant warmth that brings to mind pleasant sexual memories.  ");
			if(player.lust100 >= 30 && player.lust100 < 60) outputText("Blood rushes to your groin in a rush as your body is hit by a tidal-wave of arousal.  ");
			if(player.lust100 >= 60) outputText("Your mouth begins to drool as you close your eyes and imagine yourself sucking off Zetaz, then riding him, letting him sate his desires in your inviting flesh.  The unnatural visions send pulses of lust through you so strongly that your body shivers.  ");
			if(player.cocks.length > 0) {
				if(player.lust100 >= 60 && player.cocks.length > 0) outputText("You feel [eachcock] dribble pre-cum, bouncing with each beat of your heart and aching to be touched.  ");
				if(player.lust100 >= 30 && player.lust100 < 60 && player.cocks.length == 1) outputText(player.SMultiCockDesc() + " hardens and twitches, distracting you further.  ");
			}
			if(player.vaginas.length > 0) {
				if(player.lust100 >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL && player.vaginas.length == 1) outputText("Your [vagina] dampens perceptibly, feeling very empty.  ");
				if(player.lust100 >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET && player.vaginas.length > 0) outputText("Your crotch becomes sticky with girl-lust, making it clear to " + a + short + " just how welcome your body finds the spell.  ");
				if(player.lust100 >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK && player.vaginas.length == 1) outputText("Your [vagina] becomes sloppy and wet, dribbling with desire to be mounted and fucked.  ");
				if(player.lust100 >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING && player.vaginas.length > 0) outputText("Thick runners of girl-lube stream down the insides of your thighs as your crotch gives into the demonic magics.  You wonder what " + a + short + "'s cock would feel like inside you?  ");
				if (player.lust100 >= 60 && player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING && player.vaginas.length == 1) outputText("Your [vagina] instantly soaks your groin with the heady proof of your need.  You wonder just how slippery you could " + a + short + "'s dick when it's rammed inside you?  ");
			}
			if(player.lust >= player.maxOverLust() && !SceneLib.combat.tyrantiaTrainingExtension()) doNext(SceneLib.combat.endLustLoss);
		}

		public function gigaWhitefire():void {
			outputText("The imp lord glares daggers at you, before snapping his fingers.");
			outputText(" In a flash, you and the area around are bathed in white flames!");

			var damage:Number = eBaseIntelligenceDamage() * 5;

			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard, 1, -1);
				damage *= 0.2;
				outputText(" Luckily, your conjured blizzard lessens the effect. ")
			}
			player.takeFireDamage(damage, true);

			var burnChance:Number = 25;
			if (player.hasStatusEffect(StatusEffects.BurnDoT)) {
				player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
			} else if (!player.immuneToBurn()) {
				player.createStatusEffect(StatusEffects.BurnDoT, 3, 0.1, 0, 0);
				outputText(" His spell leaves burns all over your body!");
			}
		}
		

		public function zetazTaunt():void {
			if(!hasStatusEffect(StatusEffects.round)) {
				createStatusEffect(StatusEffects.round,1,0,0,0);
				outputText("Zetaz asks, \"<i>Do you even realize how badly you fucked up my life, ");
				if(player.isRace(Races.HUMAN, 1, false)) outputText("human");
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

		//One time heal and empowerment for difficulties above normal
		public function zetazMight():void {
			outputText("Zetaz flushes, drawing on his body's desires to empower his muscles and spells. ");
			outputText("Laughing from the rush of power, he quickly rises into air!");
			statStore.addBuffObject({"int.mult":0.3, "tou.mult":0.3}, "ImpMight");
			this.createStatusEffect(StatusEffects.Flying, 30, 0, 0, 0);
			addHP(0.25 * maxHP());
			this.mightCasted = true;
		}

		override protected function performCombatAction():void {
			if (hasStatusEffect(StatusEffects.Blind) && lust100 > 50)
				blindHeal();
			
			//Zetaz taunts.
			zetazTaunt();
			outputText("\n\n");

			super.performCombatAction();
		}

		override protected function handleFear():Boolean {
			if (lust100 > 50) {
				this.speStat.core.value += statusEffectv2(StatusEffects.Fear);
				removeStatusEffect(StatusEffects.Fear);
				removeStatusEffect(StatusEffects.Blind);
				outputText("Zetaz blinks and shakes his head while stroking himself.  After a second his turgid member loses some of its rigidity, but his gaze has become clear.  He's somehow consumed some of his lust to clear away your magic!\n");
				lust -= maxLust()/10;
				return true;
			}
			return super.handleFear();
		}

		override public function displaySpecialStatuses():Array {
			var statusArray:Array = super.displaySpecialStatuses();
			if (statStore.hasBuff("ImpMight")) statusArray.push("Imp Might");
			return statusArray;
		}

		public function blindHeal():void {
			removeStatusEffect(StatusEffects.Blind);
			outputText("Zetaz blinks and shakes his head while stroking himself.  After a second his turgid member loses some of its rigidity, but his gaze has become clear.  He's somehow consumed some of his lust to clear away your magic!\n");
			lust -= maxLust()/10;
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

		private function buildAbilities():Array {
			var abilities:Array = [
				{call: lustHeal, type: ABILITY_SPECIAL, range: RANGE_SELF, condition: lustHealCheck, weight: Infinity, tags:[TAG_HEAL] },
				{call: heatDraft, type: ABILITY_MAGIC, range: RANGE_RANGED},
				{call: gigaArouse, type: ABILITY_MAGIC, range: RANGE_RANGED, weight: 2},
				{call: gust, type: ABILITY_PHYSICAL, condition: gustCheck, range: RANGE_RANGED},
				{call: gigaWhitefire, type: ABILITY_MAGIC, range: RANGE_RANGED, weight: 2, tags:[TAG_FIRE]}
			];

			//Zetaz gains the ability to use Might under 50%HP in difficulties over Normal 
			if (flags[kFLAGS.GAME_DIFFICULTY] > 0) {
				abilities.push({call: zetazMight, type: ABILITY_SPECIAL, range: RANGE_SELF, condition: mightCheck, weight: Infinity, tags:[TAG_HEAL]});
			}

			return abilities;
		}

		public function lustHealCheck():Boolean {
			return lust100 >= 10 && HPRatio() <= .5 && !hasStatusEffect(StatusEffects.AbilityCooldown1);
		}

		public function mightCheck():Boolean {
			return HPRatio() <= .5 && !mightCasted;
		}

		public function gustCheck():Boolean {
			return !player.hasStatusEffect(StatusEffects.Blind);
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
			this.tallness = 56;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.lowerBody = LowerBody.HOOFED;
			this.bodyColor = "red";
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(190, 180, 120, 55);
			initWisLibSensCor(55, 105, 65, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 49;
			this.armorName = "leathery skin";
			this.armorDef = 28;
			this.armorMDef = 14;
			this.bonusHP = 1000;
			this.bonusLust = 260;
			this.lust = 30;
			this.lustVuln = .3;
			this.level = 40;
			this.gems = rand(75) + 175;
			this.additionalXP = 400;
			this.drop = new WeightedDrop(consumables.BIMBOLQ, 1);
			this.wings.type = Wings.IMP;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 40, 0, 0, 0);
			this.abilities = this.buildAbilities();
			checkMonster();
		}

		private var mightCasted:Boolean = false;
		
	}

}
