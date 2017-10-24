package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class Isabella extends Monster
	{

		//IZZY AI:

		//Isabella Combat texttttttsss
		public function isabellaAttack():void {
			//[Standard attack]
			outputText("Isabella snorts and lowers a shield a moment before she begins to charge towards you. Her hooves tear huge divots out of the ground as she closes the distance with surprising speed!  ");

			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText("Isabella blindly tries to charge at you, but misses completely.\n");
			}
			//Determine if dodged!
			else if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("You duck aside at the last moment, relying entirely on your speed.\n");
			}
			//Determine if evaded
			else if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("You easily evade her incredibly linear attack.\n");
			}
			//("Misdirection"
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("You easily misdirect her and step aside at the last moment.\n");
			}
			//Determine if cat'ed
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("You throw yourself out of the way with cat-like agility at the last moment, avoiding her attack.\n");
			}
			else {
				var damage:Number;
				damage = Math.round((weaponAttack + str + 20) - rand(player.tou+player.armorDef));
				if(damage < 0) {
					outputText("You brace yourself and catch her shield in both hands, dragging through the dirt as you slow her charge to a stop.  She gapes down, completely awestruck by the show of power.");
				}
				else {
					outputText("She's coming too fast to dodge, and you're forced to try to stop her.  It doesn't work.  Isabella's shield hits you hard enough to ring your ears and knock you onto your back with bruising force. ");
					damage = player.takeDamage(damage, true);
					outputText("\n");
				}
			}
			combatRoundOver();
		}

		public function isabellaStun():void {
			//[Stunning Impact]
			outputText("Isabella spins her shield back at you in a potent, steel-assisted backhand.  ");

			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText("Isabella blindly tries to charge at you, but misses completely.\n");
			}
			//Determine if dodged!
			else if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("You duck aside at the last moment, relying entirely on your speed.\n");
			}
			//Determine if evaded
			else if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("You easily evade her incredibly linear attack.\n");
			}
			//("Misdirection"
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("You easily misdirect her and step aside at the last moment.\n");
			}
			//Determine if cat'ed
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("You bend backward with cat-like agility to avoid her attack.\n");
			}
			else {
				var damage:Number = 0;
				damage = Math.round((weaponAttack + str) - rand(player.tou+player.armorDef));
				if(damage < 0) {
					outputText("You deflect her blow away, taking no damage.\n");
					damage = 0;
				}
				else if(player.findPerk(PerkLib.Resolute) >= 0 && player.tou >= 75) {
					outputText("You resolutely ignore the blow thanks to your immense toughness.\n");
					damage = 0;
				}
				else {
					outputText("You try to avoid it, but her steely attack connects, rocking you back.  You stagger about while trying to get your bearings, but it's all you can do to stay on your feet.  <b>Isabella has stunned you!</b> ");
					damage = player.takeDamage(damage, true);
					outputText("\n");
					player.createStatusEffect(StatusEffects.IsabellaStunned,0,0,0,0);
				}
			}
			combatRoundOver();
		}

		public function isabellaThroatPunch():void {
			outputText("Isabella punches out from behind her shield in a punch aimed right at your throat!  ");

			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
				outputText("Isabella blindly tries to charge at you, but misses completely.\n");
			}
			//Determine if dodged!
			else if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("You duck aside at the last moment, relying entirely on your speed.\n");
			}
			//Determine if evaded
			else if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("You easily evade her incredibly linear attack.\n");
			}
			//("Misdirection"
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("You easily misdirect her and step aside at the last moment.\n");
			}
			//Determine if cat'ed
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("You bend backward with cat-like agility to avoid her attack.\n");
			}
			else {
				var damage:Number;
				damage = Math.round(str - rand(player.tou+player.armorDef));
				if(damage <= 0) {
					outputText("You manage to block her with your own fists.\n");
				}
				else if(player.findPerk(PerkLib.Resolute) >= 0 && player.tou >= 75) {
					outputText("You resolutely ignore the blow thanks to your immense toughness.\n");
				}
				else {
					outputText("You try your best to stop the onrushing fist, but it hits you square in the throat, nearly collapsing your windpipe entirely.  Gasping and sputtering, you try to breathe, and while it's difficult, you manage enough to prevent suffocation. <b>It will be impossible to focus to cast a spell in this state!</b> ");
					damage = player.takeDamage(damage, true);
					outputText("\n");
					player.createStatusEffect(StatusEffects.ThroatPunch,2,0,0,0);
				}
			}
			combatRoundOver();
		}

		//[Milk Self-Heal]
		public function drankMalkYaCunt():void {
			outputText("Isabella pulls one of her breasts out of her low-cut shirt and begins to suckle at one of the many-tipped nipples. Her cheeks fill and hollow a few times while you watch with spellbound intensity.  She finishes and tucks the weighty orb away, blushing furiously.  The quick drink seems to have reinvigorated her, and watching it has definitely aroused you.");
			HP += 100;
			lust += 5;
			player.dynStats("lus", (10+player.lib/20));
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			//-If below 70% HP, 50% chance of milk drinking
			if (HPRatio() < .7 && rand(3) == 0) drankMalkYaCunt();
			//if PC has spells and isn't silenced, 1/3 chance of silence.
			else if (player.hasSpells() && !player.hasStatusEffect(StatusEffects.ThroatPunch) && rand(3) == 0) {
				isabellaThroatPunch();
			}
			//if PC isn't stunned, 1/4 chance of stun
			else if (!player.hasStatusEffect(StatusEffects.IsabellaStunned) && rand(4) == 0) {
				isabellaStun();
			}
			else isabellaAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.isabellaScene.defeatIsabella();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\n\"<i>Ick,</i>\" Isabella tuts as she turns to leave...");
				game.cleanupAfterCombat();
			} else {
				SceneLib.isabellaScene.isabellaDefeats();
			}
		}

		public function Isabella()
		{
			this.a = "";
			this.short = "Isabella";
			this.imageName = "isabella";
			this.long = "Isabella is a seven foot tall, red-headed tower of angry cow-girl.  She's snarling at you from behind her massive shield, stamping her hooves in irritation as she prepares to lay into you.  Her skin is dusky, nearly chocolate except for a few white spots spattered over her body.  She wears a tight silk shirt and a corset that barely supports her bountiful breasts, but it's hard to get a good look at them behind her giant shield.";
			// this.plural = false;
			this.createVagina(false, AppearanceDefs.VAGINA_WETNESS_DROOLING, AppearanceDefs.VAGINA_LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("EE+"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,38,0,0,0);
			this.tallness = 7*12+6;
			this.hipRating = AppearanceDefs.HIP_RATING_CURVY+2;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE+1;
			this.skinTone = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			if (flags[kFLAGS.ISABELLA_LVL_UP] < 1) {
				initStrTouSpeInte(80, 108, 75, 64);
				initLibSensCor(64, 25, 40);
				this.weaponAttack = 18 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 18 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 700;
				this.level = 20;
				this.str += 16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 2280;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 1) {
				initStrTouSpeInte(110, 150, 100, 90);
				initLibSensCor(90, 25, 40);
				this.weaponAttack = 24 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 24 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 1000;
				this.level = 30;
				this.str += 33 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 6480;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 2) {
				initStrTouSpeInte(150, 200, 130, 120);
				initLibSensCor(120, 25, 40);
				this.weaponAttack = 30 + (7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 30 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 1400;
				this.level = 40;
				this.str += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 39 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 10900;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 3) {
				initStrTouSpeInte(200, 250, 160, 150);
				initLibSensCor(150, 25, 40);
				this.weaponAttack = 36 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 36 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 1800;
				this.level = 50;
				this.str += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 75 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 48 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 16380;
			}
			this.weaponName = "giant shield";
			this.weaponVerb="smash";
			this.armorName = "giant shield";
			this.armorPerk = "";
			this.armorValue = 70;
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = rand(10) + 25;
			this.tailType = AppearanceDefs.TAIL_TYPE_COW;
			this.tailRecharge = 0;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 2) this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 3) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
