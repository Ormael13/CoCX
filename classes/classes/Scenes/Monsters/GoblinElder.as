package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.*;
	
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
			if (spellChooser == 0 && findStatusEffect(StatusEffects.ChargeWeapon) >= 0) {
				spellChooser = rand(5) + 1;
			}
			if (spellChooser == 4 && HPRatio() >= 0.7) {
				spellChooser++;
			}
			if (spellChooser == 5 && findStatusEffect(StatusEffects.Might) >= 0) {
				spellChooser = rand(5);
				if (spellChooser == 0 && findStatusEffect(StatusEffects.ChargeWeapon) >= 0) spellChooser++;
			}
			//Spell time!
			//Charge Weapon
			if (spellChooser == 0 && fatigue <= (100 - spellCostCharge)) {
				outputText("The goblin utters word of power, summoning an electrical charge around her sword. <b>It looks like she'll deal more physical damage now!</b>");
				createStatusEffect(StatusEffects.ChargeWeapon, 15 * spellMultiplier(), 0, 0, 0);
				this.weaponAttack += 15 * spellMultiplier();
				fatigue += spellCostCharge;
			}
			//Blind
			else if (spellChooser == 1 && fatigue <= (100 - spellCostBlind)) {
				outputText("The goblin glares at you and points at you! A bright flash erupts before you!  ");
				if (rand(player.inte / 5) <= 4) {
					outputText("<b>You are blinded!</b>");
					player.createStatusEffect(StatusEffects.Blind, 1 + rand(3), 0, 0, 0);
				}
				else {
					outputText("You manage to blink in the nick of time!");
				}
				fatigue += spellCostBlind;
			}
			//Whitefire
			else if (spellChooser == 2 && fatigue <= (100 - spellCostWhitefire)) {
				outputText("The goblin narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  ");
				var damage:int = inte + rand(50) * spellMultiplier();
				if (player.isGoo()) {
					damage *= 1.5;
					outputText("It's super effective! ");
				}
				if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damage *= 1.15;
				else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damage *= 1.3;
				else if (flags[kFLAGS.GAME_DIFFICULTY] >= 3) damage *= 1.5;
				player.takeDamage(damage, true);
				fatigue += spellCostWhitefire;
			}
			//Arouse
			else if (spellChooser == 3 && fatigue <= (100 - spellCostArouse)) {
				outputText("She makes a series of arcane gestures, drawing on her lust to inflict it upon you! ");
				var lustDamage:int = (inte / 10) + (player.lib / 10) + rand(10) * spellMultiplier();
				lustDamage = lustDamage * (player.lustPercent() / 100);
				game.dynStats("lus", lustDamage, "resisted", false);
				outputText(" <b>(<font color=\"#ff00ff\">" + (Math.round(lustDamage * 10) / 10) + "</font>)</b>");
				fatigue += spellCostArouse;
			}
			//Heal
			else if (spellChooser == 4 && fatigue <= (100 - spellCostHeal)) {
				outputText("She focuses on her body and her desire to end pain, trying to draw on her arousal without enhancing it.");
				var temp:int = int(10 + (inte/2) + rand(inte/3)) * spellMultiplier();
				outputText("She flushes with success as her wounds begin to knit! <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.", false);
				addHP(temp);
				fatigue += spellCostHeal;
			}
			//Might
			else if (spellChooser == 5 && fatigue <= (100 - spellCostMight)) {
				outputText("She flushes, drawing on her body's desires to empower her muscles and toughen her up.");
				outputText("The rush of success and power flows through her body.  She feels like she can do anything!", false);
				createStatusEffect(StatusEffects.Might, 15 * spellMultiplier(), 15 * spellMultiplier(), 0, 0);
				str += 15 * spellMultiplier();
				tou += 15 * spellMultiplier();
				fatigue += spellCostMight;
			}
			combatRoundOver();
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
				damage = player.reduceDamage(damage);
				if (damage < 10) damage = 10;
				player.takeDamage(damage, true);
			}
			combatRoundOver();
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
				damage = player.reduceDamage(damage);
				if (damage < 10) damage = 10;
				player.takeDamage(damage, true);
			}
			combatRoundOver();
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
			game.goblinElderScene.goblinElderRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0 || flags[kFLAGS.SFW_MODE] > 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She growls and kicks you in the head, making your vision swim. As your sight fades, you hear her murmur, \"<i>Fucking dicks can't even bother to grow a dick or cunt.</i>\"", false);
				game.combat.cleanupAfterCombat();
			} 
			else {
				game.goblinElderScene.goblinElderBeatYaUp();
			}
		}
		
		public function GoblinElder() 
		{
			this.a = "the ";
			this.short = "goblin elder";
			if (flags[kFLAGS.GOBLIN_ELDER_TALK_COUNTER] > 0) {
				a = "";
				short = "Priscilla";
			}
			this.imageName = "goblinelder";
			this.long = "The goblin before you stands a little over four feet tall. It's difficult to determine an age of goblin thanks to their corrupt nature but this one looks unusual. Her skin tone is yellowish-green skin and her hair is crimson black. Her body is painted in imp and minotaur blood to scare away anybody who would try to rape her. She's wearing a shark-tooth necklace and her ears are pierced with what appears to be lethicite. Her breasts look to be FF-cups despite her \"age\". Unlike most goblins, she's well armed. She's wielding a crudely fashioned metal sword and a large metal square shield. She's wearing a spider-silk loincloth and the imp skulls hang from the leather strap holding her loincloth together. Her helmet is fashioned out of a minotaur skull and her chestpiece appears to be carved from minotaur ribcage. Her pauldrons are also fashioned from bones. Despite how well-armored she is, her lethicite-pierced nipples are exposed. It's obvious she has travelled quite a lot and slain a lot of minotaurs and imps. She must have lived long thanks to Reducto to keep her breasts at normal size.";
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("FF"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 48;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "yellowish-green";
			this.hairColor = "dark green";
			this.hairLength = 4;
			initStrTouSpeInte(95, 75, 70, 100);
			initLibSensCor(55, 35, 45);
			this.weaponName = "primal sword";
			this.weaponVerb = "slash";
			this.weaponAttack = 25;
			this.armorName = "bone armor";
			this.armorDef = 24;
			this.fatigue = 0;
			this.bonusHP = 425;
			this.lust = 35;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 20;
			this.gems = rand(15) + 25;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE, 5).
					add(consumables.REDUCTO, 2).
					add(jewelries.POWRRNG, 1).
					add(useables.LETHITE, 1).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			this.createPerk(PerkLib.Tank, 0, 0, 0, 0);
			this.createPerk(PerkLib.Tank2, 0, 0, 0, 0);
			//this.special3 = castSpell;
			checkMonster();
		}
		
	}

}