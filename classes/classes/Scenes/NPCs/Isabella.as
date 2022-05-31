package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
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
			else if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You easily evade her incredibly linear attack.\n");
			}
			//("Misdirection"
			else if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("You easily misdirect her and step aside at the last moment.\n");
			}
			//Determine if cat'ed
			else if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("You throw yourself out of the way with cat-like agility at the last moment, avoiding her attack.\n");
			}
			else {
				var damage:Number;
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) damage = Math.round(((weaponAttack + str + 20) * flags[kFLAGS.ISABELLA_LVL_UP]) - rand(player.tou+player.armorDef));
				else damage = Math.round((weaponAttack + str + 20) - rand(player.tou + player.armorDef));
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8) damage *= 0.2;
				if (wrath >= 50) {
					if (flags[kFLAGS.ISABELLA_LVL_UP] >= 12 && wrath >= 300) {
						wrath -= 300;
						damage *= 5;
					}
					else if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8 && wrath >= 200) {
						wrath -= 200;
						damage *= 4;
					}
					else if (flags[kFLAGS.ISABELLA_LVL_UP] >= 4 && wrath >= 100) {
						wrath -= 100;
						damage *= 3;
					}
					else {
						wrath -= 50;
						damage *= 2;
					}
				}
				if (damage < 0) {
					outputText("You brace yourself and catch her shield in both hands, dragging through the dirt as you slow her charge to a stop.  She gapes down, completely awestruck by the show of power.");
				}
				else {
					outputText("She's coming too fast to dodge, and you're forced to try to stop her.  It doesn't work.  Isabella's shield hits you hard enough to ring your ears and knock you onto your back with bruising force. ");
					damage = player.takePhysDamage(damage, true);
					outputText("\n");
				}
			}
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
			else if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You easily evade her incredibly linear attack.\n");
			}
			//("Misdirection"
			else if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("You easily misdirect her and step aside at the last moment.\n");
			}
			//Determine if cat'ed
			else if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("You bend backward with cat-like agility to avoid her attack.\n");
			}
			else {
				var damage:Number = 0;
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) damage = Math.round(((weaponAttack + str) * (1 + (flags[kFLAGS.ISABELLA_LVL_UP] * 0.1))) - rand(player.tou+player.armorDef));
				else damage = Math.round((weaponAttack + str) - rand(player.tou+player.armorDef));
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8) damage *= 0.2;
				if(damage < 0) {
					outputText("You deflect her blow away, taking no damage.\n");
					damage = 0;
				}
				else if(player.hasPerk(PerkLib.Resolute) && player.tou >= 75) {
					outputText("You resolutely ignore the blow thanks to your immense toughness.\n");
					damage = 0;
				}
				else {
					outputText("You try to avoid it, but her steely attack connects, rocking you back.  You stagger about while trying to get your bearings, but it's all you can do to stay on your feet.  <b>Isabella has stunned you!</b> ");
					damage = player.takePhysDamage(damage, true);
					outputText("\n");
					player.createStatusEffect(StatusEffects.IsabellaStunned,0,0,0,0);
				}
			}
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
			else if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You easily evade her incredibly linear attack.\n");
			}
			//("Misdirection"
			else if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("You easily misdirect her and step aside at the last moment.\n");
			}
			//Determine if cat'ed
			else if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("You bend backward with cat-like agility to avoid her attack.\n");
			}
			else {
				var damage:Number;
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) damage = Math.round((str * (1 + (flags[kFLAGS.ISABELLA_LVL_UP] * 0.1))) - rand(player.tou+player.armorDef));
				else damage = Math.round(str - rand(player.tou + player.armorDef));
				if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8) damage *= 0.2;
				if(damage <= 0) {
					outputText("You manage to block her with your own fists.\n");
				}
				else if(player.hasPerk(PerkLib.Resolute) && player.tou >= 75) {
					outputText("You resolutely ignore the blow thanks to your immense toughness.\n");
				}
				else {
					outputText("You try your best to stop the onrushing fist, but it hits you square in the throat, nearly collapsing your windpipe entirely.  Gasping and sputtering, you try to breathe, and while it's difficult, you manage enough to prevent suffocation. <b>It will be impossible to focus to cast a spell in this state!</b> ");
					damage = player.takePhysDamage(damage, true);
					outputText("\n");
					player.createStatusEffect(StatusEffects.ThroatPunch,2,0,0,0);
				}
			}
		}

		//[Milk Self-Heal]
		public function drankMalkYaCunt():void {
			outputText("Isabella pulls one of her breasts out of her low-cut shirt and begins to suckle at one of the many-tipped nipples. Her cheeks fill and hollow a few times while you watch with spellbound intensity.  She finishes and tucks the weighty orb away, blushing furiously.  The quick drink seems to have reinvigorated her, and watching it has definitely aroused you.");
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) HP += 100 * flags[kFLAGS.ISABELLA_LVL_UP];
			else HP += 100;
			lust += 5;
			player.dynStats("lus", (10+player.lib/20));
		}

		override protected function performCombatAction():void
		{
			//-If below 70% HP, 50% chance of milk drinking
			if (HPRatio() < .7 && rand(2) == 0) drankMalkYaCunt();
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
				SceneLib.combat.cleanupAfterCombatImpl();
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
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("EE+"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,38,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			if (flags[kFLAGS.ISABELLA_LVL_UP] < 1) {
				initStrTouSpeInte(80, 108, 75, 64);
				initWisLibSensCor(64, 64, 25, 40);
				this.weaponAttack = 18;
				this.armorDef = 16;
				this.armorMDef = 4;
				this.bonusHP = 600;
				this.bonusLust = 109;
				this.level = 20;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 1) {
				initStrTouSpeInte(100, 130, 85, 73);
				initWisLibSensCor(73, 70, 30, 40);
				this.weaponAttack = 21;
				this.armorDef = 24;
				this.armorMDef = 6;
				this.bonusHP = 800;
				this.bonusLust = 126;
				this.level = 26;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 2) {
				initStrTouSpeInte(120, 155, 100, 82);
				initWisLibSensCor(82, 80, 35, 40);
				this.weaponAttack = 24;
				this.armorDef = 32;
				this.armorMDef = 8;
				this.bonusHP = 1000;
				this.bonusLust = 147;
				this.level = 32;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 3) {
				initStrTouSpeInte(140, 180, 115, 91);
				initWisLibSensCor(91, 90, 40, 40);
				this.weaponAttack = 27;
				this.armorDef = 40;
				this.armorMDef = 10;
				this.bonusHP = 1200;
				this.bonusLust = 168;
				this.level = 38;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 4) {
				initStrTouSpeInte(160, 210, 130, 100);
				initWisLibSensCor(100, 100, 45, 40);
				this.weaponAttack = 30;
				this.armorDef = 48;
				this.armorMDef = 12;
				this.bonusHP = 1400;
				this.bonusLust = 189;
				this.level = 44;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 5) {
				initStrTouSpeInte(180, 240, 145, 110);
				initWisLibSensCor(110, 110, 50, 40);
				this.weaponAttack = 33;
				this.armorDef = 54;
				this.armorMDef = 14;
				this.bonusHP = 1600;
				this.bonusLust = 210;
				this.level = 50;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 6) {
				initStrTouSpeInte(200, 270, 160, 120);
				initWisLibSensCor(120, 120, 55, 40);
				this.weaponAttack = 36;
				this.armorDef = 62;
				this.armorMDef = 16;
				this.bonusHP = 1800;
				this.bonusLust = 231;
				this.level = 56;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 7) {
				initStrTouSpeInte(220, 300, 175, 130);
				initWisLibSensCor(130, 130, 60, 40);
				this.weaponAttack = 39;
				this.armorDef = 70;
				this.armorMDef = 18;
				this.bonusHP = 2000;
				this.bonusLust = 252;
				this.level = 62;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 8) {
				initStrTouSpeInte(240, 330, 190, 140);
				initWisLibSensCor(140, 140, 65, 40);
				this.weaponAttack = 42;
				this.armorDef = 78;
				this.armorMDef = 20;
				this.bonusHP = 2200;
				this.bonusLust = 273;
				this.level = 68;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 9) {
				initStrTouSpeInte(260, 360, 205, 150);
				initWisLibSensCor(150, 150, 70, 40);
				this.weaponAttack = 45;
				this.armorDef = 86;
				this.armorMDef = 22;
				this.bonusHP = 2400;
				this.bonusLust = 294;
				this.level = 74;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 10) {
				initStrTouSpeInte(280, 390, 220, 160);
				initWisLibSensCor(160, 160, 75, 40);
				this.weaponAttack = 48;
				this.armorDef = 94;
				this.armorMDef = 24;
				this.bonusHP = 2600;
				this.bonusLust = 315;
				this.level = 80;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 11) {
				initStrTouSpeInte(300, 420, 235, 170);
				initWisLibSensCor(170, 170, 80, 40);
				this.weaponAttack = 51;
				this.armorDef = 102;
				this.armorMDef = 26;
				this.bonusHP = 2800;
				this.bonusLust = 336;
				this.level = 86;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 12) {
				initStrTouSpeInte(320, 450, 250, 180);
				initWisLibSensCor(180, 180, 85, 40);
				this.weaponAttack = 54;
				this.armorDef = 110;
				this.armorMDef = 28;
				this.bonusHP = 3000;
				this.bonusLust = 357;
				this.level = 92;
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 13) {
				initStrTouSpeInte(340, 480, 265, 190);
				initWisLibSensCor(190, 190, 90, 40);
				this.weaponAttack = 57;
				this.armorDef = 118;
				this.armorMDef = 30;
				this.bonusHP = 3200;
				this.bonusLust = 378;
				this.level = 98;
			}//level up giving 2x all growns and so follow next level ups's as long each npc break lvl 100 (also makes npc use new better gear)
			this.weaponName = "giant shield";
			this.weaponVerb="smash";
			this.armorName = "giant shield";
			this.armorPerk = "";
			this.armorValue = 70;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = rand(10) + 25;
			this.tailType = Tail.COW;
			this.tailRecharge = 0;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.Lifeline, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 3) this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 5) this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.ImprovedLifeline, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 7) this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 8) {
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToAdvancedTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 9) this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 10) {
				this.createPerk(PerkLib.GreaterLifeline, 0, 0, 0, 0);
				this.createPerk(PerkLib.AdvancedTranquilness, 0, 0, 0, 0)
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 11) this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 12) {
				this.createPerk(PerkLib.EpicLifeline, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToSuperiorTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 13) this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
