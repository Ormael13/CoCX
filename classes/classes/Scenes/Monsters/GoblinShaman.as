package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class GoblinShaman extends Goblin
	{
		public var spellCostCharge:int = 6;
		public var spellCostBlind:int = 8;
		public var spellCostWhitefire:int = 12;
		public var spellCostArouse:int = 6;
		public var spellCostHeal:int = 8;
		public var spellCostMight:int = 10;
		
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
				outputText("The goblin utters word of power, summoning an electrical charge around her staff. <b>It looks like she'll deal more physical damage now!</b>");
				createStatusEffect(StatusEffects.ChargeWeapon, 25 * spellMultiplier(), 0, 0, 0);
				this.weaponAttack += 25 * spellMultiplier();
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
				createStatusEffect(StatusEffects.Might, 20 * spellMultiplier(), 20 * spellMultiplier(), 0, 0);
				str += 20 * spellMultiplier();
				tou += 20 * spellMultiplier();
				fatigue += spellCostMight;
			}
			combatRoundOver();
		}
		
		private function spellMultiplier():Number {
			var mult:Number = 1;
			mult += player.newGamePlusMod() * 0.5;
			return mult;
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(8);
			if (choice < 3) eAttack();
			else if (choice == 3) goblinDrugAttack();
			else if (choice == 4) goblinTeaseAttack();
			else castSpell();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.goblinShamanScene.goblinShamanRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0 || flags[kFLAGS.SFW_MODE] > 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She growls and kicks you in the head, making your vision swim. As your sight fades, you hear her murmur, \"<i>Fucking dicks can't even bother to grow a dick or cunt.</i>\"", false);
				game.combat.cleanupAfterCombat();
			} 
			else {
				game.goblinShamanScene.goblinShamanBeatYaUp();
			}
		}
		
		public function GoblinShaman()
		{
			this.a = "the ";
			this.short = "goblin shaman";
			this.imageName = "goblinshaman";
			this.long = "The goblin before you stands approximately three feet and a half. Her ears appear to be pierced more times than the amount of piercings a typical goblin has. Her hair is deep indigo. She’s unlike most of the goblins you’ve seen. She’s wielding a staff in her right hand. In addition to the straps covering her body, she’s wearing a necklace seemingly carved with what looks like shark teeth. She’s also wearing a tattered loincloth, unlike most goblins who would show off their pussies. From the looks of one end of her staff glowing, she’s clearly a shaman!";
			if (player.hasCock()) this.long += "  She's clearly intent on casting you into submission just so she can forcibly make you impregnate her.";
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 44 + rand(7);
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "dark green";
			this.hairColor = "indigo";
			this.hairLength = 4;
			initStrTouSpeInte(75, 50, 70, 87);
			initLibSensCor(45, 45, 60);
			this.weaponName = "wizard staff";
			this.weaponVerb = "bludgeon";
			this.weaponAttack = 14;
			this.armorName = "fur loincloth";
			this.armorDef = 6;
			this.fatigue = 0;
			this.bonusHP = 275;
			this.lust = 35;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 14;
			this.gems = rand(15) + 15;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					add(weapons.W_STAFF,1).
					add(undergarments.FURLOIN,1).
					add(jewelries.MYSTRNG, 1).
					add(jewelries.LIFERNG,1).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			this.special3 = castSpell;
			checkMonster();
		}
		
	}

}