package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GoblinElder extends Goblin
	{
		public var spellCostCharge:int = 6;
		public var spellCostBlind:int = 8;
		public var spellCostWhitefire:int = 12;
		public var spellCostArouse:int = 6;
		public var spellCostHeal:int = 8;
		public var spellCostMight:int = 10;
		
		//Magical specials
		public function castSpell():void {
			var spellChooser:int = rand(6);
			//Makes sure to not stack spell effects.
			if (lust < 50) spellChooser = rand(3);
			if (lust > 75) spellChooser = rand(3) + 3;
			if (spellChooser == 0 && hasStatusEffect(StatusEffects.ChargeWeapon)) {
				spellChooser = rand(5) + 1;
			}
			if (spellChooser == 4 && HPRatio() >= 0.7) {
				spellChooser++;
			}
			if (spellChooser == 5 && hasStatusEffect(StatusEffects.Might)) {
				spellChooser = rand(5);
				if (spellChooser == 0 && hasStatusEffect(StatusEffects.ChargeWeapon)) spellChooser++;
			}
			//Spell time!
			//Charge Weapon
			if (spellChooser == 0 && (mana + spellCostCharge) <= maxMana()) {
				outputText("The goblin utters word of power, summoning an electrical charge around her sword. <b>It looks like she'll deal more physical damage now!</b>");
				createStatusEffect(StatusEffects.ChargeWeapon, 15 * spellMultiplier(), 0, 0, 0);
				this.weaponAttack += 15 * spellMultiplier();
				mana -= spellCostCharge;
			}
			//Blind
			else if (spellChooser == 1 && (mana + spellCostBlind) <= maxMana()) {
				outputText("The goblin glares at you and points at you! A bright flash erupts before you!  ");
				if ((player.findPerk(PerkLib.GorgonsEyes) < 0 && rand(player.inte / 5) <= 4) && !player.hasPerk(PerkLib.BlindImmunity)) {
					outputText("<b>You are blinded!</b>");
					player.createStatusEffect(StatusEffects.Blind, 1 + rand(3), 0, 0, 0);
				}
				else if (player.findPerk(PerkLib.GorgonsEyes) >= 0) {
					outputText("Your mutated eyes not been affected at all by this flash!");
				}
				else {
					outputText("You manage to blink in the nick of time!");
				}
				mana -= spellCostBlind;
			}
			//Whitefire
			else if (spellChooser == 2 && (mana + spellCostWhitefire) <= maxMana()) {
				outputText("The goblin narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  ");
				var damage:int = inte + rand(50) * spellMultiplier();
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard, 1, -1);
				outputText("Luckly protective ice maelstorm still surrounding you lessening amount of damage.  ");
				damage *= 0.2;
				}
				if (player.isGoo()) {
					damage *= 1.5;
					outputText("It's super effective! ");
				}
				if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damage *= 1.15;
				else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damage *= 1.3;
				else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damage *= 1.5;
				else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damage *= 2;
				damage = Math.round(damage);
				player.takeFireDamage(damage, true);
				mana -= spellCostWhitefire;
			}
			//Arouse
			else if (spellChooser == 3 && (mana + spellCostArouse) <= maxMana()) {
				outputText("She makes a series of arcane gestures, drawing on her lust to inflict it upon you! ");
				var lustDamage:int = (inte / 10) + (player.lib / 10) + rand(10) * spellMultiplier();
				lustDamage = lustDamage * (EngineCore.lustPercent() / 100);
				player.dynStats("lus", lustDamage, "scale", false);
				outputText(" <b>(<font color=\"#ff00ff\">" + (Math.round(lustDamage * 10) / 10) + "</font>)</b>");
				mana -= spellCostArouse;
			}
			//Heal
			else if (spellChooser == 4 && (mana + spellCostHeal) <= maxMana()) {
				outputText("She focuses on her body and her desire to end pain, trying to draw on her arousal without enhancing it.");
				var temp:int = int(10 + (inte/2) + rand(inte/3)) * spellMultiplier();
				outputText("She flushes with success as her wounds begin to knit! <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
				addHP(temp);
				mana -= spellCostHeal;
			}
			//Might
			else if (spellChooser == 5 && (mana + spellCostMight) <= maxMana()) {
				outputText("She flushes, drawing on her body's desires to empower her muscles and toughen her up.");
				outputText("The rush of success and power flows through her body.  She feels like she can do anything!");
				createStatusEffect(StatusEffects.Might, 15 * spellMultiplier(), 15 * spellMultiplier(), 0, 0);
				str += 15 * spellMultiplier();
				tou += 15 * spellMultiplier();
				mana -= spellCostMight;
			}
		}
		
		//Melee specials
		public function slash():void {
			outputText("The goblin charges at you with her sword!  As soon as she approaches you, she swings her sword! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid her slash!");
			}
			else {
				outputText("Her strike connects with you! ");
				//Get hit
				var damage:int = str + weaponAttack + rand(40);
				if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 1) damage += (flags[kFLAGS.PRISCILLA_LVL_UP] + rand(15)) * 4;
				if (damage < 40) damage = 40;
				player.takePhysDamage(damage, true);
			}
		}
		
		public function shieldBash():void {
			outputText("The goblin charges at you with her shield! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid her shield bash!");
			}
			else {
				outputText("Her shield hits you! ");
				//Get hit
				if (rand(100) < 40 && player.findPerk(PerkLib.Resolute) < 0) {
					outputText("The impact from the shield has left you with a concussion. <b>You are stunned.</b> ");
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
				var damage:int = str + rand(10);
				if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 1) damage += flags[kFLAGS.PRISCILLA_LVL_UP] + rand(15);
				if (damage < 10) damage = 10;
				player.takePhysDamage(damage, true);
			}
		}
		
		private function spellMultiplier():Number {
			var mult:Number = 1;
			mult += 0.5 * player.newGamePlusMod();
			return mult;
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(10);
			if (choice < 4) eAttack();
			else if (choice == 4) goblinDrugAttack();
			else if (choice == 5) goblinTeaseAttack();
			else castSpell();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.goblinElderScene.goblinElderRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0 || flags[kFLAGS.SFW_MODE] > 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She growls and kicks you in the head, making your vision swim. As your sight fades, you hear her murmur, \"<i>Fucking dicks can't even bother to grow a dick or cunt.</i>\"");
				SceneLib.combat.cleanupAfterCombatImpl();
			} 
			else {
				SceneLib.goblinElderScene.goblinElderBeatYaUp();
			}
		}
		
		public function GoblinElder() 
		{
			if (flags[kFLAGS.PRISCILLA_LVL_UP] < 1) {
				initStrTouSpeInte(115, 95, 80, 120);
				initWisLibSensCor(120, 65, 35, 45);
				this.weaponAttack = 35;
				this.armorDef = 48;
				this.armorMDef = 18;
				this.bonusHP = 900;
				this.level = 32;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 1) {
				initStrTouSpeInte(135, 105, 98, 140);
				initWisLibSensCor(140, 70, 40, 45);
				this.weaponAttack = 40;
				this.armorDef = 55;
				this.armorMDef = 21;
				this.bonusHP = 1050;
				this.level = 38;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 2) {
				initStrTouSpeInte(155, 115, 116, 160);
				initWisLibSensCor(160, 75, 45, 45);
				this.weaponAttack = 45;
				this.armorDef = 62;
				this.armorMDef = 24;
				this.bonusHP = 1200;
				this.level = 44;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 3) {
				initStrTouSpeInte(175, 125, 134, 180);
				initWisLibSensCor(180, 80, 50, 45);
				this.weaponAttack = 50;
				this.armorDef = 69;
				this.armorMDef = 27;
				this.bonusHP = 1350;
				this.level = 50;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 4) {
				initStrTouSpeInte(195, 135, 152, 200);
				initWisLibSensCor(200, 85, 55, 45);
				this.weaponAttack = 55;
				this.armorDef = 76;
				this.armorMDef = 30;
				this.bonusHP = 1500;
				this.level = 56;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 5) {
				initStrTouSpeInte(215, 145, 170, 220);
				initWisLibSensCor(220, 90, 60, 45);
				this.weaponAttack = 60;
				this.armorDef = 83;
				this.armorMDef = 33;
				this.bonusHP = 1650;
				this.level = 62;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 6) {
				initStrTouSpeInte(235, 155, 188, 240);
				initWisLibSensCor(240, 95, 65, 45);
				this.weaponAttack = 65;
				this.armorDef = 90;
				this.armorMDef = 36;
				this.bonusHP = 1800;
				this.level = 68;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 7) {
				initStrTouSpeInte(255, 165, 206, 260);
				initWisLibSensCor(260, 100, 70, 45);
				this.weaponAttack = 70;
				this.armorDef = 97;
				this.armorMDef = 39;
				this.bonusHP = 1950;
				this.level = 74;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 8) {
				initStrTouSpeInte(275, 175, 224, 280);
				initWisLibSensCor(280, 105, 75, 45);
				this.weaponAttack = 75;
				this.armorDef = 104;
				this.armorMDef = 42;
				this.bonusHP = 2100;
				this.level = 80;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 9) {
				initStrTouSpeInte(295, 185, 242, 300);
				initWisLibSensCor(300, 110, 80, 45);
				this.weaponAttack = 80;
				this.armorDef = 111;
				this.armorMDef = 45;
				this.bonusHP =2250;
				this.level = 86;
			}
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 10) {
				initStrTouSpeInte(315, 195, 250, 320);
				initWisLibSensCor(320, 115, 85, 45);
				this.weaponAttack = 85;
				this.armorDef = 118;
				this.armorMDef = 48;
				this.bonusHP = 2400;
				this.level = 92;
			}
			this.a = "the ";
			this.short = "goblin elder";
			if (flags[kFLAGS.GOBLIN_ELDER_TALK_COUNTER] > 0) {
				a = "";
				short = "Priscilla";
			}
			this.imageName = "goblinelder";
			this.long = "The goblin before you stands a little over four feet tall. It's difficult to determine an age of goblin thanks to their corrupt nature but this one looks unusual. Her skin tone is yellowish-green skin and her hair is crimson black. Her body is painted in imp and minotaur blood to scare away anybody who would try to rape her. She's wearing a shark-tooth necklace and her ears are pierced with what appears to be lethicite. Her breasts look to be FF-cups despite her \"age\". Unlike most goblins, she's well armed. She's wielding a crudely fashioned metal sword and a large metal square shield. She's wearing a spider-silk loincloth and the imp skulls hang from the leather strap holding her loincloth together. Her helmet is fashioned out of a minotaur skull and her chestpiece appears to be carved from minotaur ribcage. Her pauldrons are also fashioned from bones. Despite how well-armored she is, her lethicite-pierced nipples are exposed. It's obvious she has travelled quite a lot and slain a lot of minotaurs and imps. She must have lived long thanks to Reducto to keep her breasts at normal size.";
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("FF"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 48;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "yellowish-green";
			this.hairColor = "dark green";
			this.hairLength = 4;
			this.weaponName = "primal sword";
			this.weaponVerb = "slash";
			this.armorName = "bone armor";
			this.fatigue = 0;
			this.bonusLust = 20;
			this.lust = 35;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = rand(10) + 40;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE, 5).
					add(consumables.REDUCTO,2).
					add(jewelries.POWRRNG,1).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 1) this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 2) this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 3) this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 4) this.createPerk(PerkLib.ManaAffinityI, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 5) this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 6) this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 7) this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 8) this.createPerk(PerkLib.PrestigeJobSpellKnight, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 9) this.createPerk(PerkLib.EpicLifeline, 0, 0, 0, 0);
			if (flags[kFLAGS.PRISCILLA_LVL_UP] >= 10) this.createPerk(PerkLib.MythicalToughness, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
