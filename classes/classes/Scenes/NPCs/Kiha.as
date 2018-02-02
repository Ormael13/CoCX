package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;

public class Kiha extends Monster
	{
		private function kihaTimeWaster():void {
			game.spriteSelect(72);
			outputText("She supports the axe on a shoulder, cracking her neck and arching her back to stretch herself, giving you an unintended show.  ");
			player.dynStats("lus", 5);
		}

		//This could be silly mode worthy! Should Expand? oh ok
		private function sillyModeKihaAttack():void {
			game.spriteSelect(72);
			outputText("Before you can stop to think, the dragon-woman steps back - throwing her axe into the air before she starts sprinting towards you. In seconds she's reached a hair's distance between her lithe form and your own, her fist recoiling and time seemingly stopping to allow you to note the powerful energy seeping from her arms.  ");
			//Miss:
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("You take the opportunity to walk away, watching the slow-motion attack unravel before you; the fire bursts from her knuckle in the shape of a bird in flight, wings unfurled.  ");
				if(rand(2) == 0) outputText("You only owned an XJasun back home, so you don't really understand the reference.");
				else outputText("You stifle a laugh as your memories turn to many an evening spent with your friends in front of your SharkCube console, contesting each other in games of ridiculous, stylized combat.");
			}
			else {
				//Determine damage - str modified by enemy toughness!
				var damage:int = int((str + weaponAttack) - rand(player.tou) - player.armorDef);
				damage += 5;
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
				if (flags[kFLAGS.KIHA_LVL_UP] >= 1) damage *= (1 + (flags[kFLAGS.KIHA_LVL_UP] * 0.1));
				damage = Math.round(damage);
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
					player.addStatusValue(StatusEffects.Blizzard, 1, -1);
					damage *= 0.2;
					damage = Math.round(damage);
				}
				
				outputText("A torrent of heat bursts from between her fingertips as she thrusts her clenched fist forward, the ball of intense flame writhing and burning with a fury unknown to mankind. With one fell swoop, the combined power of her love, anger, and sorrow pushes you backward, launching you out of the swamp and into Marble's pillowy chest. \"<i>Ara ara,</i>\" she begins, but you've already pushed yourself away from the milky hell-prison as you run back towards ");
				if(!SceneLib.kihaFollower.followerKiha()) outputText("the swamp");
				else outputText("the fight");
				outputText(". ");
				damage = player.takeMagicDamage(damage, true);
				outputText("\n");
				if(player.HP >= 1) outputText("You follow the shrill cry of \"<i>B-BAKA!</i>\" in the distance until you reach the exact location you were in a few seconds earlier, prepared to fight again.");
			}
		}

		private function kihaFirePunch():void {
			game.spriteSelect(72);
			outputText("The draconic girl throws her trusty weapon into the sodden ground, using the distraction to build up balls of flame around her fists.  She runs towards you, launching herself in your direction with a flurry of punches.\n");

			//Dodged
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("You manage to jump to the side, intense heat rushing past you as you narrowly avoid her advance.  You twist around, finding that she's reunited with her axe and angrier than before.");
			}
			//Determine if evaded
			else if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evasion, you manage to jump to the side, intense heat rushing past you as you narrowly avoid her advance.  You twist around, finding that she's reunited with her axe and angrier than before.");
			}
			//("Misdirection"
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using your skills at misdirection, you manage to make Kiha think you're going to dodge one way before stepping in the other direction.  You turn back, finding she has her axe in hand and looks rather steamed.");
			}
			//Determine if cat'ed
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("Using your cat-like reflexes, you manage to jump to the side, intense heat rushing past you as you narrowly avoid her advance.  You twist around, finding that she's reunited with her axe and angrier than before.");
			}
			//HIT!
			else {
				var damage:int = int((str) - (player.armorDef));
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
				if (flags[kFLAGS.KIHA_LVL_UP] >= 1) damage *= (1 + (flags[kFLAGS.KIHA_LVL_UP] * 0.1));
				damage = Math.round(damage);
				outputText("Before you can react, you're struck by the power of her blows, feeling an intense pain in your chest as each fist makes contact.  With a final thrust, you're pushed backwards onto the ground; the dragoness smiles as she pulls her axe out of the ground, her hands still steaming from the fingertips. ");
				damage = player.takeMagicDamage(damage, true);
				outputText("\n");
			}
		}


		//Fire breath
		private function kihaFireBreath():void {
			game.spriteSelect(72);
			outputText("Kiha throws her arms back and roars, exhaling a swirling tornado of fire directly at you!\n");
			//Miss:
			//Determine if evaded
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your talent for evasion, you manage to sidestep the flames in the nick of time; much to the dragoness' displeasure.");
			}
			//("Misdirection"
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using your talent for misdirection, you manage to sidestep the flames in the nick of time; much to the dragoness' displeasure.");
			}
			//Determine if cat'ed
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("Using your cat-like flexibility, you manage to sidestep the flames in the nick of time; much to the dragoness' displeasure.");
			}
			else {
				var damage:Number = Math.round(90 + rand(10) + (player.newGamePlusMod() * 30));
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
				if (flags[kFLAGS.KIHA_LVL_UP] >= 1) damage *= (1 + (flags[kFLAGS.KIHA_LVL_UP] * 0.1));
				damage = Math.round(damage);
				outputText("You try to avoid the flames, but you're too slow!  The inferno slams into you, setting you alight!  You drop and roll on the ground, putting out the fires as fast as you can.  As soon as the flames are out, you climb back up, smelling of smoke and soot. ");
				damage = player.takeMagicDamage(damage, true);
				outputText("\n");
			}
		}
		/*
		Special 2: Kiha lifts her axe overhead and then hurls it at you in a surprising feat of speed and strength. Not keen on getting cleaved in two, you sidestep the jagged metal.
		Hit: But when your attention refocuses on the dragoness, you realize she's right in front of you! She hits you in the face with a vicious straight punch, knocking you on your back.
		Miss: When your gaze returns to the dragoness, you realize she's right in front of you! Luckily your reflexes are good enough that you manage to duck under the incoming punch. By the time you've recovered, Kiha is already standing, battle-ready and axe in hand. (uh, no? in the time it takes the PC to unbend from a simple duck, she's already disentangled herself from close quarters, run over to where the axe landed on the opposite side of him, extracted it from whatever it may be stuck in, and toted it back to the player? do it again with sense; she should be stunned or disarmed for at least a turn if she misses -Z)

		Special 3: Kiha suddenly lets out a roar, swings her axe down and then charges headlong at you!
		Hit: Like a runaway boulder, the dragoness slams into you, brutally propelling you to the ground, jarring bone and leaving you dazed. //Stun effect applies for 2 rounds//
		Miss: You nimbly turn aside and roll her off your shoulder at the last moment, leaving her ploughing on uncontrollably until she (catches her foot in a sinkhole and twists her ankle painfully, faceplanting in the bog)/(slams headfirst into a half-rotten tree with a shower of mouldering splinters). She quickly rights herself and turns to face you, but it clearly took its toll on her. //Kiha takes damage//
		*/
		override protected function handleFear():Boolean
		{
			removeStatusEffect(StatusEffects.Fear);
			outputText("Kiha shudders for a moment, then looks your way with a clear head.  \"<i>Fear was the first thing the demons taught us to overcome.  Do you think it would stay my blade?</i>\"\n");
			return true;
		}

		override protected function handleBlind():Boolean
		{
			return true;
		}


		override protected function postAttack(damage:int):void
		{
			super.postAttack(damage);
			var flame:int = level + rand(6);
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) flame *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) flame *= 0.3;
			if (flags[kFLAGS.KIHA_LVL_UP] >= 1) flame *= (1 + (flags[kFLAGS.KIHA_LVL_UP] * 0.1));
			flame = Math.round(flame);
			outputText("\nAn afterwash of flames trails behind her blow, immolating you! ");
			flame = player.takeMagicDamage(flame, true);
		}

		override protected function performCombatAction():void
		{
			var select:Number = rand(5);
			if (select == 0) kihaTimeWaster();
			if (select == 1) kihaFireBreath();
			if (select == 2) {
				if (EngineCore.silly()) sillyModeKihaAttack();
				else kihaFirePunch();
			}
			if (select > 2) eAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.spiderfight))
				SceneLib.kihaFollower.playerBeatsUpKihaPreSpiderFight();
			else if(hasStatusEffect(StatusEffects.DomFight))
				SceneLib.kihaFollower.pcWinsDomFight();
			else if(hasStatusEffect(StatusEffects.Spar))
				SceneLib.kihaFollower.winSparWithKiha();
			else SceneLib.kihaScene.kihaVictoryIntroduction();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.spiderfight))
				SceneLib.kihaFollower.loseKihaPreSpiderFight();
			else if(hasStatusEffect(StatusEffects.DomFight))
				SceneLib.kihaFollower.pcLosesDomFight();
			else if(hasStatusEffect(StatusEffects.Spar))
				SceneLib.kihaFollower.sparWithFriendlyKihaLose();
			else if (pcCameWorms){
				outputText("\n\nKiha seems visibly disturbed by your infection, enough that she turns to leave.");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.kihaScene.kihaLossIntro();
			}
		}

		public function Kiha()
		{
			this.a = "";
			this.short = "Kiha";
			this.imageName = "kiha";
			this.long = "Kiha is standing across from you, holding a double-bladed axe that's nearly as big as she is.  She's six feet tall, and her leathery wings span nearly twelve feet extended.  Her eyes are pure crimson, save for a black slit in the center, and a pair of thick draconic horns sprout from her forehead, arcing over her ruby-colored hair to point behind her.  Dim red scales cover her arms, legs, back, and strong-looking tail, providing what protection they might to large areas of her body.  The few glimpses of exposed skin are dark, almost chocolate in color, broken only by a few stray scales on the underside of her bosom and on her cheekbones.  ";
			if (game.flags[kFLAGS.KIHA_UNDERGARMENTS] > 0)
				this.long += "Damp patch forms in her silk " + (game.flags[kFLAGS.KIHA_UNDERGARMENTS] == 1 ? "panties" : "loincloth") + ", regardless of her state of arousal.  Despite her near nudity, Kiha stands with the confidence and poise of a trained fighter.";
			else 
				this.long += "Her vagina constantly glistens with moisture, regardless of her state of arousal.  Despite her nudity, Kiha stands with the confidence and poise of a trained fighter.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_LOOSE;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 6*12+1;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.HOOFED;
			this.skin.coverage = Skin.COVERAGE_MEDIUM;
			this.skin.base.color = "dark";
			this.skin.coat.color = "red";
			this.skin.coat.type = Skin.SCALES;
			this.hairColor = "red";
			this.hairLength = 3;
			if (flags[kFLAGS.KIHA_LVL_UP] < 1) {
				initStrTouSpeInte(85, 80, 85, 60);
				initWisLibSensCor(60, 50, 45, 66);
				this.weaponAttack = 28;
				this.armorDef = 35;
				this.bonusHP = 500;
				this.level = 21;
			}
			if (flags[kFLAGS.KIHA_LVL_UP] == 1) {
				initStrTouSpeInte(110, 105, 110, 70);
				initWisLibSensCor(70, 70, 55, 66);
				this.weaponAttack = 38;
				this.armorDef = 50;
				this.bonusHP = 600;
				this.level = 27;
			}
			if (flags[kFLAGS.KIHA_LVL_UP] == 2) {
				initStrTouSpeInte(135, 130, 135, 80);
				initWisLibSensCor(80, 90, 65, 66);
				this.weaponAttack = 48;
				this.armorDef = 65;
				this.bonusHP = 700;
				this.level = 33;
			}
			if (flags[kFLAGS.KIHA_LVL_UP] == 3) {
				initStrTouSpeInte(160, 155, 160, 90);
				initWisLibSensCor(90, 110, 75, 66);
				this.weaponAttack = 58;
				this.armorDef = 80;
				this.bonusHP = 800;
				this.level = 39;
			}
			if (flags[kFLAGS.KIHA_LVL_UP] == 4) {
				initStrTouSpeInte(185, 180, 185, 100);
				initWisLibSensCor(100, 130, 85, 66);
				this.weaponAttack = 68;
				this.armorDef = 95;
				this.bonusHP = 900;
				this.level = 45;
			}
			if (flags[kFLAGS.KIHA_LVL_UP] == 5) {
				initStrTouSpeInte(210, 205, 210, 110);
				initWisLibSensCor(110, 150, 95, 66);
				this.weaponAttack = 78;
				this.armorDef = 110;
				this.bonusHP = 1000;
				this.level = 51;
			}
			if (flags[kFLAGS.KIHA_LVL_UP] == 6) {
				initStrTouSpeInte(235, 230, 235, 120);
				initWisLibSensCor(120, 170, 105, 66);
				this.weaponAttack = 88;
				this.armorDef = 125;
				this.bonusHP = 1200;
				this.level = 57;
			}
			if (flags[kFLAGS.KIHA_LVL_UP] == 7) {
				initStrTouSpeInte(260, 255, 260, 130);
				initWisLibSensCor(130, 190, 115, 66);
				this.weaponAttack = 98;
				this.armorDef = 140;
				this.bonusHP = 1400;
				this.level = 63;
			}
			this.weaponName = "double-bladed axe";
			this.weaponVerb="fiery cleave";
			this.armorName = "thick scales";
			if (game.flags[kFLAGS.KIHA_UNDERGARMENTS] > 0)
				this.armorDef += (2 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			this.bonusLust = 20;
			this.lust = 10;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.gems = rand(15) + 95;
			this.drop = new ChainedDrop().add(useables.D_SCALE, 0.2);
			this.wings.type = Wings.DRACONIC_LARGE;
			this.wings.desc = "huge";
			this.tailType = Tail.LIZARD;
			if (flags[kFLAGS.KIHA_LVL_UP] >= 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			if (flags[kFLAGS.KIHA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.Lifeline, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KIHA_LVL_UP] >= 3) {
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
				this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KIHA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KIHA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
				this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KIHA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedTranquilness, 0, 0, 0, 0);
			}
			//if (flags[kFLAGS.KIHA_LVL_UP] >= 7) this.createPerk(PerkLib., 0, 0, 0, 0);
			if (flags[kFLAGS.KIHA_LVL_UP] >= 8) this.createPerk(PerkLib.LizanMarrow, 0, 0, 0, 0);
			//if (flags[kFLAGS.KIHA_LVL_UP] >= 9) this.createPerk(PerkLib., 0, 0, 0, 0);
			if (flags[kFLAGS.KIHA_LVL_UP] >= 10) this.createPerk(PerkLib.LizanMarrowEvolved, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
