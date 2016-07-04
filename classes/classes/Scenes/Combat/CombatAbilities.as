package classes.Scenes.Combat 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.Scenes.Areas.GlacialRift.FrostGiant;
	import classes.Scenes.Dungeons.D3.*;
	import classes.Scenes.Dungeons.HelDungeon.*;
	import classes.Scenes.NPCs.*;
	import classes.Scenes.Places.TelAdre.UmasShop;

	public class CombatAbilities extends BaseContent
	{
		public function CombatAbilities() {}
		
		//------------
		// SPELLS
		//------------
		public var fireMagicLastTurn:int = -100;
		public var fireMagicCumulated:int = 0;
		
		//UTILS
		public function canUseMagic():Boolean {
			if (player.findStatusEffect(StatusEffects.ThroatPunch) >= 0) return false;
			if (player.findStatusEffect(StatusEffects.WebSilence) >= 0) return false;
			if (player.findStatusEffect(StatusEffects.GooArmorSilence) >= 0) return false;
			return true;
		}
		
		public function getWhiteMagicLustCap():Number {
			var whiteLustCap:int = player.maxLust() * 0.75;
			if (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whiteLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.FocusedMind) >= 0) whiteLustCap += (player.maxLust() * 0.1);
			return whiteLustCap;
		}
		
		public function spellPerkUnlock():void {
			if (flags[kFLAGS.SPELLS_CAST] >= 5 && player.findPerk(PerkLib.SpellcastingAffinity) < 0) {
				outputText("<b>You've become more comfortable with your spells, unlocking the Spellcasting Affinity perk and reducing fatigue cost of spells by 20%!</b>\n\n");
				player.createPerk(PerkLib.SpellcastingAffinity,20,0,0,0);
			}
			if (flags[kFLAGS.SPELLS_CAST] >= 15 && player.perkv1(PerkLib.SpellcastingAffinity) < 35) {
				outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 15%!</b>\n\n");
				player.setPerkValue(PerkLib.SpellcastingAffinity,1,35);
			}
			if (flags[kFLAGS.SPELLS_CAST] >= 45 && player.perkv1(PerkLib.SpellcastingAffinity) < 50) {
				outputText("<b>You've become more comfortable with your spells, further reducing your spell costs by an additional 15%!</b>\n\n");
				player.setPerkValue(PerkLib.SpellcastingAffinity,1,50);
			}
		}
		
		public function isExhausted(cost:int):Boolean {
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(cost) > player.maxFatigue()) {
				outputText("You are too tired to cast this spell.", true);
				doNext(magicMenu);
				return true;
			}
			else {
				return false;
			}
		}
		
		//MENU
		public function magicMenu():void {
			if (combat.inCombat && player.findStatusEffect(StatusEffects.Sealed) >= 0 && player.statusEffectv2(StatusEffects.Sealed) == 2) {
				clearOutput();
				outputText("You reach for your magic, but you just can't manage the focus necessary.  <b>Your ability to use magic was sealed, and now you've wasted a chance to attack!</b>\n\n");
				monster.doAI();
				return;
			}
			menu();
			clearOutput();
			outputText("What spell will you use?\n\n");
			//WHITE SHITZ			
			if (player.lust >= getWhiteMagicLustCap())
				outputText("You are far too aroused to focus on white magic.\n\n");
			else {
				if (player.findStatusEffect(StatusEffects.KnowsCharge) >= 0) {
					if (player.findStatusEffect(StatusEffects.ChargeWeapon) < 0)
						addButton(0, "Charge W.", spellChargeWeapon, null, null, null, "The Charge Weapon spell will surround your weapon in electrical energy, causing it to do even more damage.  The effect lasts for the entire combat.  \n\nFatigue Cost: " + player.spellCost(15) + "", "Charge Weapon");
					else outputText("<b>Charge weapon is already active and cannot be cast again.</b>\n\n");
				}
				if (player.findStatusEffect(StatusEffects.KnowsBlind) >= 0) {
					if (monster.findStatusEffect(StatusEffects.Blind) < 0)
						addButton(1, "Blind", spellBlind, null, null, null, "Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted.  \n\nFatigue Cost: " + player.spellCost(20) + "");
					else outputText("<b>" + monster.capitalA + monster.short + " is already affected by blind.</b>\n\n");
				}
				if (player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0) addButton(2, "Whitefire", spellWhitefire, null, null, null, "Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.  \n\nFatigue Cost: " + player.spellCost(30) + "");
			}
			//BLACK MAGICSKS
			if (player.lust < 50)
				outputText("You aren't turned on enough to use any black magics.\n\n");
			else {
				if (player.findStatusEffect(StatusEffects.KnowsArouse) >= 0) addButton(5, "Arouse", spellArouse, null, null, null, "The arouse spell draws on your own inner lust in order to enflame the enemy's passions.  \n\nFatigue Cost: " + player.spellCost(15) + "");
				if (player.findStatusEffect(StatusEffects.KnowsHeal) >= 0) addButton(6, "Heal", spellHeal, null, null, null, "Heal will attempt to use black magic to close your wounds and restore your body, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you.  \n\nFatigue Cost: " + player.spellCost(20) + "");
				if (player.findStatusEffect(StatusEffects.KnowsMight) >= 0) {
					if (player.findStatusEffect(StatusEffects.Might) < 0)
						addButton(7, "Might", spellMight, null, null, null, "The Might spell draws upon your lust and uses it to fuel a temporary increase in muscle size and power.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  \n\nFatigue Cost: " + player.spellCost(25) + "");
					else outputText("<b>You are already under the effects of Might and cannot cast it again.</b>\n\n");
				}
			}
			// JOJO ABILITIES -- kind makes sense to stuff it in here along side the white magic shit (also because it can't fit into M. Specials :|
			if (player.findPerk(PerkLib.CleansingPalm) >= 0 && player.cor < (10 + player.corruptionTolerance())) {
				addButton(3, "C.Palm", spellCleansingPalm, null, null, null, "Unleash the power of your cleansing aura! More effective against corrupted opponents. Doesn't work on the pure.  \n\nFatigue Cost: " + player.spellCost(30) + "", "Cleansing Palm");
			}
			addButton(14, "Back", combat.combatMenu, false);
		}
		
		//WHITE SPELLS
		//(15) Charge Weapon – boosts your weapon attack value by 10 * player.spellMod till the end of combat.
		public function spellChargeWeapon(silent:Boolean = false):void {
			if (silent) {
				player.createStatusEffect(StatusEffects.ChargeWeapon,10*player.spellMod(),0,0,0);
				statScreenRefresh();
				return;
			}
			
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(15) > player.maxFatigue()) {
				outputText("You are too tired to cast this spell.", true);
				doNext(magicMenu);
				return;
			}
			doNext(combat.combatMenu);
			player.changeFatigue(15, 1);
			if (monster is FrostGiant && player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
				(monster as FrostGiant).giantBoulderHit(2);
				monster.doAI();
				return;
			}
			outputText("You utter words of power, summoning an electrical charge around your " + player.weaponName + ".  It crackles loudly, ensuring you'll do more damage with it for the rest of the fight.\n\n", true);
			var temp:int = 10 * player.spellMod();
			if (temp > 100) temp = 100;
			player.createStatusEffect(StatusEffects.ChargeWeapon, temp, 0, 0, 0);
			statScreenRefresh();
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			monster.doAI();
		}
		
		//(20) Blind – reduces your opponent's accuracy, giving an additional 50% miss chance to physical attacks.
		public function spellBlind():void {
			clearOutput();
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(20) > player.maxFatigue()) {
				outputText("You are too tired to cast this spell.", true);
				doNext(magicMenu);
				return;
			}
			doNext(combat.combatMenu);
			player.changeFatigue(20,1);
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				monster.doAI();
				return;
			}
			if (monster is JeanClaude)
			{
				outputText("Jean-Claude howls, reeling backwards before turning back to you, rage clenching his dragon-like face and enflaming his eyes. Your spell seemed to cause him physical pain, but did nothing to blind his lidless sight.");

				outputText("\n\n“<i>You think your hedge magic will work on me, intrus?</i>” he snarls. “<i>Here- let me show you how it’s really done.</i>” The light of anger in his eyes intensifies, burning a retina-frying white as it demands you stare into it...");
				
				if (rand(player.spe) >= 50 || rand(player.inte) >= 50)
				{
					outputText("\n\nThe light sears into your eyes, but with the discipline of conscious effort you escape the hypnotic pull before it can mesmerize you, before Jean-Claude can blind you.");

					outputText("\n\n“<i>You fight dirty,</i>” the monster snaps. He sounds genuinely outraged. “<i>I was told the interloper was a dangerous warrior, not a little [boy] who accepts duels of honour and then throws sand into his opponent’s eyes. Look into my eyes, little [boy]. Fair is fair.</i>”");
					
					monster.HP -= int(10+(player.inte/3 + rand(player.inte/2)) * player.spellMod());
				}
				else
				{
					outputText("\n\nThe light sears into your eyes and mind as you stare into it. It’s so powerful, so infinite, so exquisitely painful that you wonder why you’d ever want to look at anything else, at anything at- with a mighty effort, you tear yourself away from it, gasping. All you can see is the afterimages, blaring white and yellow across your vision. You swipe around you blindly as you hear Jean-Claude bark with laughter, trying to keep the monster at arm’s length.");

					outputText("\n\n“<i>The taste of your own medicine, it is not so nice, eh? I will show you much nicer things in there in time intrus, don’t worry. Once you have learnt your place.</i>”");
					
					player.createStatusEffect(StatusEffects.Blind, rand(4) + 1, 0, 0, 0);
				}
				if (monster is FrostGiant && player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
					(monster as FrostGiant).giantBoulderHit(2);
					monster.doAI();
					return;
				}
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				if (monster.HP < 1) doNext(combat.endHpVictory);
				else monster.doAI();
				return;
			}
			outputText("You glare at " + monster.a + monster.short + " and point at " + monster.pronoun2 + ".  A bright flash erupts before " + monster.pronoun2 + "!\n", true);
			if (monster is LivingStatue)
			{
				// noop
			}
			else if (rand(3) != 0) {
				outputText(" <b>" + monster.capitalA + monster.short + " ", false);
				if (monster.plural && monster.short != "imp horde") outputText("are blinded!</b>", false);
				else outputText("is blinded!</b>", false);
				monster.createStatusEffect(StatusEffects.Blind,5*player.spellMod(),0,0,0);
				if (monster.short == "Isabella")
					if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>Nein! I cannot see!</i>\" cries Isabella.", false);
					else outputText("\n\n\"<i>No! I cannot see!</i>\" cries Isabella.", false);
				if (monster.short == "Kiha") outputText("\n\n\"<i>You think blindness will slow me down?  Attacks like that are only effective on those who don't know how to see with their other senses!</i>\" Kiha cries defiantly.", false);
				if (monster.short == "plain girl") {
					outputText("  Remarkably, it seems as if your spell has had no effect on her, and you nearly get clipped by a roundhouse as you stand, confused. The girl flashes a radiant smile at you, and the battle continues.", false);
					monster.removeStatusEffect(StatusEffects.Blind);
				}
			}
			else outputText(monster.capitalA + monster.short + " blinked!", false);	
			outputText("\n\n", false);
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			statScreenRefresh();
			monster.doAI();
		}
		
		//(30) Whitefire – burns the enemy for 10 + int/3 + rand(int/2) * player.spellMod.		
		private function calcInfernoMod(damage:Number):int {
			if (player.findPerk(PerkLib.RagingInferno) >= 0) {
				var multiplier:Number = 1;
				if (combat.combatRound - fireMagicLastTurn == 2) {
					outputText("Traces of your previously used fire magic are still here, and you use them to empower another spell!\n\n");
					switch(fireMagicCumulated) {
						case 0:
						case 1:
							multiplier = 1;
							break;
						case 2:
							multiplier = 1.2;
							break;
						case 3:
							multiplier = 1.35;
							break;
						case 4:
							multiplier = 1.45;
							break;
						default:
							multiplier = 1.5 + ((fireMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
					}
					damage = Math.round(damage * multiplier);
					fireMagicCumulated++;
					// XXX: Message?
				} else {
					if (combat.combatRound - fireMagicLastTurn > 2 && fireMagicLastTurn > 0)
						outputText("Unfortunately, traces of your previously used fire magic are too weak to be used.\n\n");
					fireMagicCumulated = 1;
				}
				fireMagicLastTurn = combat.combatRound;
			}
			return damage;
		}

		public function spellWhitefire():void {
			clearOutput();
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(30) > player.maxFatigue()) {
				outputText("You are too tired to cast this spell.", true);
				doNext(magicMenu);
				return;
			}
			doNext(combat.combatMenu);
			player.changeFatigue(30,1);
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				monster.doAI();
				return;
			}
			if (monster is Doppleganger)
			{
				(monster as Doppleganger).handleSpellResistance("whitefire");
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				return;
			}
			if (monster is FrostGiant && player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
				(monster as FrostGiant).giantBoulderHit(2);
				monster.doAI();
				return;
			}
			outputText("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and " + monster.a + monster.short + " is enveloped in a flash of white flames!\n", true);
			temp = int(10 + (player.inte / 3 + rand(player.inte / 2)) * player.spellMod());
			//High damage to goes.
			temp = calcInfernoMod(temp);
			if (monster.short == "goo-girl") temp = Math.round(temp * 1.5);
			if (monster.short == "tentacle beast") temp = Math.round(temp * 1.2);
			outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + temp + "</font></b> damage.", false);
			//Using fire attacks on the goo]
			if (monster.short == "goo-girl") {
				outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.", false);
				if (monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
			}
			if (monster.short == "Holli" && monster.findStatusEffect(StatusEffects.HolliBurning) < 0) (monster as Holli).lightHolliOnFireMagically();
			outputText("\n\n", false);
		 	combat.checkAchievementDamage(temp);
			flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			monster.HP -= temp;
			statScreenRefresh();
			if (monster.HP < 1) doNext(combat.endHpVictory);
			else monster.doAI();
		}
		
		//BLACK SPELLS
		public function spellArouse():void {
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(15) > player.maxFatigue()) {
				outputText("You are too tired to cast this spell.", true);
				doNext(magicMenu);
				return;
			}
			doNext(combat.combatMenu);
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			player.changeFatigue(15,1);
			statScreenRefresh();
			if (monster is FrostGiant && player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
				(monster as FrostGiant).giantBoulderHit(2);
				monster.doAI();
				return;
			}
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				monster.doAI();
				return;
			}
			outputText("You make a series of arcane gestures, drawing on your own lust to inflict it upon your foe!\n", true);
			//Worms be immune
			if (monster.short == "worms") {
				outputText("The worms appear to be unaffected by your magic!", false);
				outputText("\n\n", false);
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				doNext(playerMenu);
				if (monster.lust >= monster.eMaxLust()) doNext(combat.endLustVictory);
				else monster.doAI();
				return;
			}
			if (monster.lustVuln == 0) {
				outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n", false);
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				monster.doAI();
				return;
			}
			var lustDmg:Number = monster.lustVuln * (player.inte/5*player.spellMod() + rand(monster.lib - monster.inte*2 + monster.cor)/5);
			if (monster.lust < 30) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ", false);
			if (monster.lust >= 30 && monster.lust < 60) {
				if (monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ", false);
				else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ", false);
			}
			if (monster.lust >= 60) {
				outputText(monster.capitalA + monster.short + "'");
				if (!monster.plural) outputText("s");
				outputText(" eyes glaze over with desire for a moment.  ", false);
			}
			if (monster.cocks.length > 0) {
				if (monster.lust >= 60 && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ", false);
				if (monster.lust >= 30 && monster.lust < 60 && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ", false);
				if (monster.lust >= 30 && monster.lust < 60 && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ", false);
			}
			if (monster.vaginas.length > 0) {
				if (monster.plural) {
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ", false);
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ", false);
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ", false);
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ", false);
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ", false);
				}
				else {
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ", false);
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ", false);
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ", false);
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ", false);
					if (monster.lust >= 60 && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ", false);
				}
			}
			monster.teased(lustDmg);
			outputText("\n\n", false);
			doNext(playerMenu);
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			if (monster.lust >= monster.eMaxLust()) doNext(combat.endLustVictory);
			else monster.doAI();
			return;	
		}
		public function spellHeal():void {
			if (/*player.findPerk(PerkLib.BloodMage) < 0 && */player.fatigue + player.spellCost(20) > player.maxFatigue()) {
				outputText("You are too tired to cast this spell.", true);
				doNext(magicMenu);
				return;
			}
			doNext(combat.combatMenu);
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			player.changeFatigue(20, 3);
			if (monster is FrostGiant && player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
				(monster as FrostGiant).giantBoulderHit(2);
				monster.doAI();
				return;
			}
			outputText("You focus on your body and its desire to end pain, trying to draw on your arousal without enhancing it.\n", true);
			//25% backfire!
			var backfire:int = 25;
			if (player.findPerk(PerkLib.FocusedMind) >= 0) backfire = 15;
			if (rand(100) < backfire) {
				outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ", false);
				if (player.gender == 0) outputText(player.assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.", false);
				if (player.gender == 1) {
					if (player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.", false);
					else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.", false);
				}
				if (player.gender == 2) outputText(player.vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.", false);
				if (player.gender == 3) outputText(player.vaginaDescript(0) + " and " + player.multiCockDescriptLight() + " overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.", false);
				dynStats("lib", .25, "lus", 15);
			}
			else {
				temp = int((player.level + (player.inte / 1.5) + rand(player.inte)) * player.spellMod());
				outputText("You flush with success as your wounds begin to knit. ", false);
				HPChange(temp, true);
			}
			
			outputText("\n\n", false);
			statScreenRefresh();
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			if (player.lust >= player.maxLust()) doNext(combat.endLustLoss);
			else monster.doAI();
			return;
		}

		//(25) Might – increases strength/toughness by 5 * player.spellMod, up to a 
		//maximum of 15, allows it to exceed the maximum.  Chance of backfiring 
		//and increasing lust by 15.
		public function spellMight(silent:Boolean = false):void {
			
			var doEffect:Function = function():* {
				player.createStatusEffect(StatusEffects.Might,0,0,0,0);
				temp = 10 * player.spellMod();
				if (temp > 100) temp = 100;
				tempStr = temp;
				tempTou = temp;
				//if (player.str + temp > 100) tempStr = 100 - player.str;
				//if (player.tou + temp > 100) tempTou = 100 - player.tou;
				player.changeStatusValue(StatusEffects.Might,1,tempStr);
				player.changeStatusValue(StatusEffects.Might,2,tempTou);
				mainView.statsView.showStatUp('str');
				mainView.statsView.showStatUp('tou');
				player.str += player.statusEffectv1(StatusEffects.Might);
				player.tou += player.statusEffectv2(StatusEffects.Might);
				statScreenRefresh();
			}
			
			if (silent)	{ // for Battlemage
				doEffect.call();
				return;
			}
			
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(25) > player.maxFatigue()) {
				outputText("You are too tired to cast this spell.", true);
				doNext(magicMenu);
				return;
			}
			doNext(combat.combatMenu);
			player.changeFatigue(25,1);
			var tempStr:Number = 0;
			var tempTou:Number = 0;
			if (monster is FrostGiant && player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) {
				(monster as FrostGiant).giantBoulderHit(2);
				monster.doAI();
				return;
			}
			outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n", true);
			//25% backfire!
			var backfire:int = 25;
			if (player.findPerk(PerkLib.FocusedMind) >= 0) backfire = 15;
			if (rand(100) < backfire) {
				outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ", false);
				if (player.gender == 0) outputText(player.assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.", false);
				if (player.gender == 1) {
					if (player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.", false);
					else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.", false);
				}
				if (player.gender == 2) outputText(player.vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.", false);
				if (player.gender == 3) outputText(player.vaginaDescript(0) + " and " + player.multiCockDescriptLight() + " overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.", false);
				dynStats("lib", .25, "lus", 15);
			}
			else {
				outputText("The rush of success and power flows through your body.  You feel like you can do anything!", false);
				doEffect.call();
			}
			outputText("\n\n", false);
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			if (player.lust >= player.maxLust()) doNext(combat.endLustLoss);
			else monster.doAI();
			return;
		}
		
		//SPECIAL SPELLS
		public function spellCleansingPalm():void
		{
			clearOutput();
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(30) > player.maxFatigue()) {
				outputText("You are too tired to cast this spell.", true);
				doNext(magicMenu);
				return;
			}
			doNext(combat.combatMenu);
			player.changeFatigue(30,1);
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				monster.doAI();
				return;
			}
			
			if (monster.short == "Jojo")
			{
				// Not a completely corrupted monkmouse
				if (kGAMECLASS.monk < 2)
				{
					outputText("You thrust your palm forward, sending a blast of pure energy towards Jojo. At the last second he sends a blast of his own against yours canceling it out\n\n");
					flags[kFLAGS.SPELLS_CAST]++;
					spellPerkUnlock();
					monster.doAI();
					return;
				}
			}
			
			if (monster is LivingStatue)
			{
				outputText("You thrust your palm forward, causing a blast of pure energy to slam against the giant stone statue- to no effect!");
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				monster.doAI();
				return;
			}
				
			var corruptionMulti:Number = (monster.cor - 20) / 25;
			if (corruptionMulti > 1.5) {
				corruptionMulti = 1.5;
				corruptionMulti += ((monster.cor - 57.5) / 100); //The increase to multiplier is diminished.
			}
			
			temp = int((player.inte / 4 + rand(player.inte / 3)) * (player.spellMod() * corruptionMulti));
			
			if (temp > 0)
			{
				outputText("You thrust your palm forward, causing a blast of pure energy to slam against " + monster.a + monster.short + ", tossing");
				if ((monster as Monster).plural == true) outputText(" them");
				else outputText((monster as Monster).mfn(" him", " her", " it"));
				outputText(" back a few feet.\n\n");
				if (silly() && corruptionMulti >= 1.75) outputText("It's super effective!  ");
				outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + temp + "</font></b> damage.\n\n");
			}
			else
			{
				temp = 0;
				outputText("You thrust your palm forward, causing a blast of pure energy to slam against " + monster.a + monster.short + ", which they ignore. It is probably best you don’t use this technique against the pure.\n\n");
			}
			
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			monster.HP -= temp;
			statScreenRefresh();
			if (monster.HP < 1) doNext(combat.endHpVictory);
			else monster.doAI();
		}
		
		//------------
		// TALISMAN
		//------------
		//Using the Talisman in combat
		public function dispellingSpell():void {
			clearOutput();
			outputText("You gather energy in your Talisman and unleash the spell contained within.  An orange light appears and flashes briefly before vanishing. \n");
			//Remove player's effects
			if (player.findStatusEffect(StatusEffects.ChargeWeapon) >= 0) {
				outputText("\nYour weapon no longer glows as your spell is dispelled.");
				player.removeStatusEffect(StatusEffects.ChargeWeapon);
			}
			if (player.findStatusEffect(StatusEffects.Might) >= 0) {
				outputText("\nYou feel a bit weaker as your strength-enhancing spell wears off.");
				player.str -= player.statusEffectv1(StatusEffects.Might);
				player.tou -= player.statusEffectv2(StatusEffects.Might);
				player.removeStatusEffect(StatusEffects.Might);
				showStatDown("str");
				showStatDown("tou");
				statScreenRefresh();
			}
			//Remove opponent's effects
				if (player.findStatusEffect(StatusEffects.ChargeWeapon) >= 0) {
				outputText("\nThe glow around " + monster.a + monster.short + "'s " + monster.weaponName + " fades completely.");
				monster.weaponAttack -= monster.statusEffectv1(StatusEffects.ChargeWeapon);
				monster.removeStatusEffect(StatusEffects.ChargeWeapon);
			}
			if (monster.findStatusEffect(StatusEffects.Fear) >= 0) {
				outputText("\nThe dark illusion around " + monster.a + " " + monster.short + " finally dissipates, leaving " + monster.pronoun2 + " no longer fearful as " + monster.pronoun1 + " regains confidence.");
				monster.spe += monster.statusEffectv1(StatusEffects.Fear);
				monster.removeStatusEffect(StatusEffects.Fear);
			}
			if (monster.findStatusEffect(StatusEffects.Illusion) >= 0) {
				outputText("\nThe reality around " + monster.a + " " + monster.short + " finally snaps back in place as your illusion spell fades.");
				monster.spe += monster.statusEffectv1(StatusEffects.Illusion);
				monster.removeStatusEffect(StatusEffects.Illusion);
			}

			if (player.findStatusEffect(StatusEffects.Might) >= 0) {
				outputText("\nYou feel a bit weaker as your strength-enhancing spell wears off.");
				monster.str -= monster.statusEffectv1(StatusEffects.Might);
				monster.tou -= monster.statusEffectv2(StatusEffects.Might);
				monster.removeStatusEffect(StatusEffects.Might);
				statScreenRefresh();
			}
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("\nThe magical shell around " + monster.a + " " + monster.short + " shatters!");
				monster.removeStatusEffect(StatusEffects.Shell);
			}
			outputText("\n");
			getGame().arianScene.clearTalisman();
			monster.doAI();
		}
		
		public function healingSpell():void {
			clearOutput();
			outputText("You gather energy in your Talisman and unleash the spell contained within.  A green aura washes over you and your wounds begin to close quickly. By the time the aura fully fades, you feel much better. ");
			var temp:int = ((player.level * 5) + (player.inte / 1.5) + rand(player.inte)) * player.spellMod() * 1.5;
			HPChange(temp, true);
			getGame().arianScene.clearTalisman();
			monster.doAI();
		}
		
		public function immolationSpell():void {
			clearOutput();
			outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of burning flames gathers around " + monster.a + monster.short + ", slowly burning " + monster.pronoun2 + ". ");
			var temp:int = int(75 + (player.inte / 2 + rand(player.inte)) * player.spellMod());
			temp = calcInfernoMod(temp);
			temp = combat.doDamage(temp, true, true);
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(player.inte / 25), 0, 0, 0);
			if (monster.short == "goo girl") {
				outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ", false);
				if (monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
			}
			getGame().arianScene.clearTalisman();
			monster.doAI();
		}

		public function lustReductionSpell():void {
			clearOutput();
			outputText("You gather energy in your Talisman and unleash the spell contained within.  A pink aura washes all over you and as soon as the aura fades, you feel much less hornier.");
			var temp:int = 30 + rand(player.inte / 5) * player.spellMod();
			outputText(" <b>(-" + temp + " lust)</b>\n\n");
			getGame().arianScene.clearTalisman();
			monster.doAI();
		}
		
		public function shieldingSpell():void {
			clearOutput();
			outputText("You gather energy in your Talisman and unleash the spell contained within.  A barrier of light engulfs you, before turning completely transparent.  Your defense has been increased.\n\n");
			player.createStatusEffect(StatusEffects.Shielding,0,0,0,0);
			getGame().arianScene.clearTalisman();
			monster.doAI();
		}
		
		//------------
		// M. SPECIALS
		//------------
		public function magicalSpecials():void {
			if (combat.inCombat && player.findStatusEffect(StatusEffects.Sealed) >= 0 && player.statusEffectv2(StatusEffects.Sealed) == 6) {
				clearOutput();
				outputText("You try to ready a special ability, but wind up stumbling dizzily instead.  <b>Your ability to use magical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
				monster.doAI();
				return;
			}
			menu();
			var button:int = 0;
			//Berserk
			if (player.findPerk(PerkLib.Berzerker) >= 0) {
				addButton(button++, "Berserk", berzerk, null, null, null, "Throw yourself into a rage!  Greatly increases the strength of your weapon and increases lust resistance, but your armor defense is reduced to zero!");
			}
			//Lustzerk
			if (player.findPerk(PerkLib.Lustzerker) >= 0) {
				addButton(button++, "Lustserk", lustzerk, null, null, null, "Throw yourself into a lust rage!  Greatly increases the strength of your weapon and increases armor defense, but your lust resistance is halved!");
			}
			//Fire Breath
			if (player.findPerk(PerkLib.Dragonfire) >= 0) {
				addButton(button++, "DragonFire", dragonBreath, null, null, null, "Unleash fire from your mouth. This can only be done once a day. \n\nFatigue Cost: " + player.spellCost(20), "Dragon Fire");
			}
			if (player.findPerk(PerkLib.FireLord) >= 0) {
				addButton(button++,"Fire Breath",fireballuuuuu, null, null, null, "Unleash fire from your mouth. \n\nFatigue Cost: 20", "Fire Breath");
			}
			if (player.findPerk(PerkLib.Hellfire) >= 0) {
				addButton(button++,"Hellfire",hellFire, null, null, null, "Unleash fire from your mouth. \n\nFatigue Cost: " + player.spellCost(20));
			}
			//Possess
			if (player.findPerk(PerkLib.Incorporeality) >= 0) {
				addButton(button++, "Possess", possess, null, null, null, "Attempt to temporarily possess a foe and force them to raise their own lusts.");
			}
			//Whisper
			if (player.findPerk(PerkLib.Whispered) >= 0) {
				addButton(button++, "Whisper", superWhisperAttack, null, null, null, "Whisper and induce fear in your opponent. \n\nFatigue Cost: " + player.spellCost(10) + "");
			}
			//Kitsune Spells
			if (player.findPerk(PerkLib.CorruptedNinetails) >= 0) {
				addButton(button++, "C.FoxFire", corruptedFoxFire, null, null, null, "Unleash a corrupted purple flame at your opponent for high damage. Less effective against corrupted enemies. \n\nFatigue Cost: " + player.spellCost(35), "Corrupted FoxFire");
				addButton(button++, "Terror", kitsuneTerror, null, null, null, "Instill fear into your opponent with eldritch horrors. The more you cast this in a battle, the lesser effective it becomes. \n\nFatigue Cost: " + player.spellCost(20));
			}
			if (player.findPerk(PerkLib.EnlightenedNinetails) >= 0) {
				addButton(button++, "FoxFire", foxFire, null, null, null, "Unleash an ethereal blue flame at your opponent for high damage. More effective against corrupted enemies. \n\nFatigue Cost: " + player.spellCost(35));
				addButton(button++, "Illusion", kitsuneIllusion, null, null, null, "Warp the reality around your opponent, lowering their speed. The more you cast this in a battle, the lesser effective it becomes. \n\nFatigue Cost: " + player.spellCost(25));
			}
			if (player.hasKeyItem("Arian's Charged Talisman") >= 0) {
				if (player.keyItemv1("Arian's Charged Talisman") == 1) addButton(button++, "Dispel", dispellingSpell);
				if (player.keyItemv1("Arian's Charged Talisman") == 2) addButton(button++, "Healing", healingSpell);
				if (player.keyItemv1("Arian's Charged Talisman") == 3) addButton(button++, "Immolation", immolationSpell);
				if (player.keyItemv1("Arian's Charged Talisman") == 4) addButton(button++, "Lust Reduc", lustReductionSpell);
				if (player.keyItemv1("Arian's Charged Talisman") == 5) addButton(button++, "Shielding", shieldingSpell);
			}
			addButton(14, "Back", combat.combatMenu, false);
		}
		
		/*private function fireBreathMenu():void { (Doesn't seem to be used. Besides, there are 14 slots.)
			clearOutput();
			outputText("Which of your special fire-breath attacks would you like to use?");
			simpleChoices("Akbal's", fireballuuuuu, "Hellfire", hellFire, "Dragonfire", dragonBreath, "", null, "Back", playerMenu);
		}*/
		
		public function berzerk():void {
			clearOutput();
			if (player.findStatusEffect(StatusEffects.Berzerking) >= 0) {
				outputText("You're already pretty goddamn mad!");
				doNext(magicalSpecials);
				return;
			}
			outputText("You roar and unleash your savage fury, forgetting about defense in order to destroy your foe!\n\n");
			player.createStatusEffect(StatusEffects.Berzerking, 0, 0, 0, 0);
			monster.doAI();
		}
		
		public function lustzerk():void {
			clearOutput();
			if(player.findStatusEffect(StatusEffects.Lustzerking) >= 0) {
				outputText("You're already pretty goddamn mad and lustfull!", true);
				doNext(magicalSpecials);
				return;
			}
			//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			outputText("You roar and unleash your lustful fury, forgetting about defense from any sexual attacks in order to destroy your foe!\n\n", true);
			player.createStatusEffect(StatusEffects.Lustzerking,0,0,0,0);
			monster.doAI();
		}
		
		//Dragon Breath
		//Effect of attack: Damages and stuns the enemy for the turn you used this attack on, plus 2 more turns. High chance of success.
		public function dragonBreath():void {
			clearOutput();
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(20) > player.maxFatigue())
			{
				outputText("You are too tired to breathe fire.", true);
				doNext(combat.combatMenu);
				return;
			}
			//Not Ready Yet:
			if (player.findStatusEffect(StatusEffects.DragonBreathCooldown) >= 0) {
				outputText("You try to tap into the power within you, but your burning throat reminds you that you're not yet ready to unleash it again...");
				doNext(combat.combatMenu);
				return;
			}
			player.changeFatigue(20, 1);
			player.createStatusEffect(StatusEffects.DragonBreathCooldown,0,0,0,0);
			var damage:Number = int(player.level * 8 + 25 + rand(10));
			
			damage = calcInfernoMod(damage);
			
			if (player.findStatusEffect(StatusEffects.DragonBreathBoost) >= 0) {
				player.removeStatusEffect(StatusEffects.DragonBreathBoost);
				damage *= 1.5;
			}
			//Shell
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				monster.doAI();
				return;
			}
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
				monster.doAI();
				return;
			}
			if (monster is LivingStatue)
			{
				outputText("The fire courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
				monster.doAI();
				return;
			}
			outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
			if (monster.findStatusEffect(StatusEffects.Sandstorm) >= 0) {
				outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
				damage = Math.round(0.2 * damage);
			}
			//Miss: 
			if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
				outputText("  Despite the heavy impact caused by your roar, " + monster.a + monster.short + " manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
			}
			//Special enemy avoidances
			else if (monster.short == "Vala" && monster.findStatusEffect(StatusEffects.Stunned) < 0) {
				outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ", false);		
				if (player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
					outputText("You dive out of the way and evade it!", false);
				}
				else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
					outputText("You use your flexibility to barely fold your body out of the way!", false);
				}
				//Determine if blocked!
				else if (combat.combatBlock(true)) {
					outputText("You manage to block your own fire with your " + player.shieldName + "!");
				}
				else {
					damage = player.takeDamage(damage);
					outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>", false);
				}
				outputText("\n\n", false);
			}
			//Goos burn
			else if (monster.short == "goo-girl") {
				outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ", false);
				if (monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
				damage = Math.round(damage * 1.5);
				damage = combat.doDamage(damage);
				monster.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
				outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n", false);
			}
			else {
				if (monster.findPerk(PerkLib.Resolute) < 0) {
					outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
					monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
				}
				else {
					outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
					if (!monster.plural) outputText("is ");
					else outputText("are");
					outputText("too resolute to be stunned by your attack.</b>");
				}
				damage = combat.doDamage(damage);
				outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		 	combat.checkAchievementDamage(damage);
			if (monster.short == "Holli" && monster.findStatusEffect(StatusEffects.HolliBurning) < 0) (monster as Holli).lightHolliOnFireMagically();
			combat.combatRoundOver();
		}
		
		//* Terrestrial Fire
		public function fireballuuuuu():void {
			clearOutput();
			if (player.fatigue + 20 > player.maxFatigue()) {
				outputText("You are too tired to breathe fire.", true);
				doNext(combat.combatMenu);
				return;
			}
			player.changeFatigue(20);
			
			//[Failure]
			//(high damage to self, +10 fatigue on top of ability cost)
			if (rand(5) == 0 || player.findStatusEffect(StatusEffects.WebSilence) >= 0) {
				if (player.findStatusEffect(StatusEffects.WebSilence) >= 0) outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, it backs up in your throat, blocked by the webbing across your mouth.  It causes you to cry out as the sudden, heated force explodes in your own throat. ", false);
				else if (player.findStatusEffect(StatusEffects.GooArmorSilence) >= 0) outputText("You reach for the terrestrial fire but as you ready the torrent, it erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat.  The slime covering your mouth bubbles and pops, boiling away where the escaping flame opens small rents in it.  That wasn't as effective as you'd hoped, but you can at least speak now. ");
				else outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, the fire inside erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat. ", false);
				player.changeFatigue(10);
				player.takeDamage(10 + rand(20), true);
				outputText("\n\n");
				monster.doAI();
				return;
			}
			
			var damage:Number;
			damage = int(player.level * 10 + 45 + rand(10));
			damage = calcInfernoMod(damage);
			
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				monster.doAI();
				return;
			}
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
				monster.doAI();
				return;
			}
			if (monster is LivingStatue)
			{
				outputText("The fire courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
				monster.doAI();
				return;
			}
			if (monster is Doppleganger)
			{
				(monster as Doppleganger).handleSpellResistance("fireball");
				flags[kFLAGS.SPELLS_CAST]++;
				spellPerkUnlock();
				return;
			}
			if (player.findStatusEffect(StatusEffects.GooArmorSilence) >= 0) {
				outputText("<b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  When you can finally work your jaw enough to open your mouth, you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b> ", false);
				player.removeStatusEffect(StatusEffects.GooArmorSilence);
				damage += 25;
			}
			else outputText("A growl rumbles deep with your chest as you charge the terrestrial fire.  When you can hold it no longer, you release an ear splitting roar and hurl a giant green conflagration at your enemy. ", false);

			if (monster.short == "Isabella" && monster.findStatusEffect(StatusEffects.Stunned) < 0) {
				outputText("Isabella shoulders her shield into the path of the emerald flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to the sides.\n\n", false);
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n", false);
				else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n", false);
				monster.doAI();
				return;
			}
			else if (monster.short == "Vala" && monster.findStatusEffect(StatusEffects.Stunned) < 0) {
				outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ", false);		
				if (player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
					outputText("You dive out of the way and evade it!", false);
				}
				else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
					outputText("You use your flexibility to barely fold your body out of the way!", false);
				}
				else {
					//Determine if blocked!
					if (combat.combatBlock(true)) {
						outputText("You manage to block your own fire with your " + player.shieldName + "!");
						combat.combatRoundOver();
						return;
					}
					outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>", false);
					player.takeDamage(damage);
				}
				outputText("\n\n", false);
			}
			else {
				//Using fire attacks on the goo]
				if (monster.short == "goo-girl") {
					outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ", false);
					if (monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
					damage = Math.round(damage * 1.5);
				}
				if (monster.findStatusEffect(StatusEffects.Sandstorm) >= 0) {
					outputText("<b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>  ");
					damage = Math.round(0.2 * damage);
				}
				outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n", false);
				monster.HP -= damage;
				if (monster.short == "Holli" && monster.findStatusEffect(StatusEffects.HolliBurning) < 0) (monster as Holli).lightHolliOnFireMagically();
			}
		 	combat.checkAchievementDamage(damage);
			if (monster.HP < 1) {
				doNext(combat.endHpVictory);
			}
			else monster.doAI();
		}
		
		//Hellfire deals physical damage to completely pure foes, 
		//lust damage to completely corrupt foes, and a mix for those in between.  Its power is based on the PC's corruption and level.  Appearance is slightly changed to mention that the PC's eyes and mouth occasionally show flicks of fire from within them, text could possibly vary based on corruption.
		public function hellFire():void {
			clearOutput();
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(20) > player.maxFatigue()) {
				outputText("You are too tired to breathe fire.\n", true);
				doNext(combat.combatMenu);
				return;
			}
			player.changeFatigue(20, 1);
			var damage:Number = (player.level * 8 + rand(10) + player.inte / 2 + player.cor / 5);
			damage = calcInfernoMod(damage);
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
				monster.doAI();
				return;
			}
			if (monster is LivingStatue)
			{
				outputText("The fire courses over the stone behemoths skin harmlessly. It does leave the surface of the statue glossier in its wake.");
				monster.doAI();
				return;
			}
			
			if (player.findStatusEffect(StatusEffects.GooArmorSilence) < 0) outputText("You take in a deep breath and unleash a wave of corrupt red flames from deep within.", false);
			
			if (player.findStatusEffect(StatusEffects.WebSilence) >= 0) {
				outputText("  <b>The fire burns through the webs blocking your mouth!</b>", false);
				player.removeStatusEffect(StatusEffects.WebSilence);
			}
			if (player.findStatusEffect(StatusEffects.GooArmorSilence) >= 0) {
				outputText("  <b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  When you can finally work your jaw enough to open your mouth, you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b>", false);
				player.removeStatusEffect(StatusEffects.GooArmorSilence);
				damage += 25;
			}
			if (monster.short == "Isabella" && monster.findStatusEffect(StatusEffects.Stunned) < 0) {
				outputText("  Isabella shoulders her shield into the path of the crimson flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to the sides.\n\n", false);
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n", false);
				else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n", false);
				monster.doAI();
				return;
			}
			else if (monster.short == "Vala" && monster.findStatusEffect(StatusEffects.Stunned) < 0) {
				outputText("  Vala beats her wings with surprising strength, blowing the fireball back at you!  ", false);		
				if (player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
					outputText("You dive out of the way and evade it!", false);
				}
				else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
					outputText("You use your flexibility to barely fold your body out of the way!", false);
				}
				else {
					damage = int(damage / 6);
					outputText("Your own fire smacks into your face, arousing you!", false);
					dynStats("lus", damage);
				}
				outputText("\n", false);
			}
			else {
				if (monster.inte < 10) {
					outputText("  Your foe lets out a shriek as their form is engulfed in the blistering flames.", false);
					damage = int(damage);
					outputText("<b>(<font color=\"#800000\">+" + damage + "</font>)</b>\n", false);
					monster.HP -= damage;
				}
				else {
					if (monster.lustVuln > 0) {
						outputText("  Your foe cries out in surprise and then gives a sensual moan as the flames of your passion surround them and fill their body with unnatural lust.", false);
						monster.teased(monster.lustVuln * damage / 6);
						outputText("\n");
					}
					else {
						outputText("  The corrupted fire doesn't seem to have effect on " + monster.a + monster.short + "!\n", false);
					}
				}
			}
			outputText("\n", false);
			if (monster.short == "Holli" && monster.findStatusEffect(StatusEffects.HolliBurning) < 0) (monster as Holli).lightHolliOnFireMagically();
			if (monster.HP < 1) {
				doNext(combat.endHpVictory);
			}
			else if (monster.lust >= 99) {
				doNext(combat.endLustVictory);
			}
			else monster.doAI();
		}
		
		//Possess
		public function possess():void {
			clearOutput();
			if (monster.short == "plain girl" || monster.findPerk(PerkLib.Incorporeality) >= 0) {
				outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself toward the opponent's frame.  Sadly, it was doomed to fail, as you bounce right off your foe's ghostly form.", false);
			}
			else if (monster is LivingStatue)
			{
				outputText("There is nothing to possess inside the golem.");
			}
			//Sample possession text (>79 int, perhaps?):
			else if ((!monster.hasCock() && !monster.hasVagina()) || monster.lustVuln == 0 || monster.inte == 0 || monster.inte > 100) {
				outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame.  Unfortunately, it seems ", false);
				if (monster.inte > 100) outputText("they were FAR more mentally prepared than anything you can handle, and you're summarily thrown out of their body before you're even able to have fun with them.  Darn, you muse.\n\n", false);
				else outputText("they have a body that's incompatible with any kind of possession.\n\n", false);
			}
			//Success!
			else if (player.inte >= (monster.inte - 10) + rand(21)) {
				outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent's frame. Before they can regain the initiative, you take control of one of their arms, vigorously masturbating for several seconds before you're finally thrown out. Recorporealizing, you notice your enemy's blush, and know your efforts were somewhat successful.", false);
				var damage:Number = Math.round(player.inte/5) + rand(player.level) + player.level;
				monster.teased(monster.lustVuln * damage);
				outputText("\n\n");
			}
			//Fail
			else {
				outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame. Unfortunately, it seems they were more mentally prepared than you hoped, and you're summarily thrown out of their body before you're even able to have fun with them. Darn, you muse. Gotta get smarter.\n\n", false);
			}
			if (!combat.combatRoundOver()) monster.doAI();
		}
		
		//Whisper 
		public function superWhisperAttack():void {
			clearOutput();
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(10) > player.maxFatigue())
			{
				outputText("You are too tired to focus this ability.", true);
				doNext(combat.combatMenu);
				return;
			}
			if (player.findStatusEffect(StatusEffects.ThroatPunch) >= 0 || player.findStatusEffect(StatusEffects.WebSilence) >= 0) {
				outputText("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.", true);
				doNext(combat.combatMenu);
				return;
			}
			if (monster.short == "pod" || monster.inte == 0) {
				outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n", true);
				player.changeFatigue(1);
				monster.doAI();
				return;
			}
			if (monster is LivingStatue)
			{
				outputText("There is nothing inside the golem to whisper to.");
				player.changeFatigue(1);
				monster.doAI();
				return;
			}
			player.changeFatigue(10, 1);
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				monster.doAI();
				return;
			}
			if (monster.findPerk(PerkLib.Focused) >= 0) {
				if (!monster.plural) outputText(monster.capitalA + monster.short + " is too focused for your whispers to influence!\n\n");
				monster.doAI();
				return;
			}
			//Enemy too strong or multiplesI think you 
			if (player.inte < monster.inte || monster.plural) {
				outputText("You reach for your enemy's mind, but can't break through.\n", false);
				player.changeFatigue(10);
				monster.doAI();
				return;
			}
			//[Failure] 
			if (rand(10) == 0) {
				outputText("As you reach for your enemy's mind, you are distracted and the chorus of voices screams out all at once within your mind. You're forced to hastily silence the voices to protect yourself.", false);
				player.changeFatigue(10);
				monster.doAI();
				return;
			}
			outputText("You reach for your enemy's mind, watching as its sudden fear petrifies your foe.\n\n", false);
			monster.createStatusEffect(StatusEffects.Fear,1,0,0,0);
			monster.doAI();
		}
		
		//Corrupted Fox Fire
		public function corruptedFoxFire():void {
			clearOutput();
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(35) > player.maxFatigue()) {
				outputText("You are too tired to use this ability.", true);
				doNext(magicalSpecials);
				return;
			}
			if (player.findStatusEffect(StatusEffects.ThroatPunch) >= 0 || player.findStatusEffect(StatusEffects.WebSilence) >= 0) {
				outputText("You cannot focus to use this ability while you're having so much difficult breathing.", true);
				doNext(magicalSpecials);
				return;
			}
			player.changeFatigue(35,1);
			//Deals direct damage and lust regardless of enemy defenses.  Especially effective against non-corrupted targets.
			outputText("Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling lavender sparks everywhere.");

			var dmg:int = int(10 + (player.inte / 3 + rand(player.inte / 2)) * player.spellMod());
			dmg = calcInfernoMod(dmg);
			if (monster.cor >= 66) dmg = Math.round(dmg * .66);
			else if (monster.cor >= 50) dmg = Math.round(dmg * .8);
			else if (monster.cor >= 25) dmg = Math.round(dmg * 1.0);
			else if (monster.cor >= 10) dmg = Math.round(dmg * 1.2);
			else dmg = Math.round(dmg * 1.3);
			//High damage to goes.
			if (monster.short == "goo-girl") temp = Math.round(temp * 1.5);
			//Using fire attacks on the goo]
			if (monster.short == "goo-girl") {
				outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.", false);
				if (monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
			}
			outputText("  ");
			dmg = combat.doDamage(dmg, true, true);
			outputText("\n\n");
			statScreenRefresh();
			flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			if (monster.HP < 1) doNext(combat.endHpVictory);
			else monster.doAI();
		}
		//Fox Fire
		public function foxFire():void {
			clearOutput();
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(35) > player.maxFatigue()) {
				outputText("You are too tired to use this ability.", true);
				doNext(magicalSpecials);
				return;
			}
			if (player.findStatusEffect(StatusEffects.ThroatPunch) >= 0 || player.findStatusEffect(StatusEffects.WebSilence) >= 0) {
				outputText("You cannot focus to use this ability while you're having so much difficult breathing.", true);
				doNext(magicalSpecials);
				return;
			}
			player.changeFatigue(35,1);
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				monster.doAI();
				return;
			}
			//Deals direct damage and lust regardless of enemy defenses.  Especially effective against corrupted targets.
			outputText("Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling azure sparks everywhere.");
			var dmg:int = int(10+(player.inte/3 + rand(player.inte/2)) * player.spellMod());
			dmg = calcInfernoMod(dmg);
			if (monster.cor < 33) dmg = Math.round(dmg * .66);
			else if (monster.cor < 50) dmg = Math.round(dmg * .8);
			else if (monster.cor < 75) dmg = Math.round(dmg * 1.0);
			else if (monster.cor < 90) dmg = Math.round(dmg * 1.2);
			else dmg = Math.round(dmg * 1.3); //30% more damage against very high corruption.
			//High damage to goes.
			if (monster.short == "goo-girl") temp = Math.round(temp * 1.5);
			//Using fire attacks on the goo]
			if (monster.short == "goo-girl") {
				outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.", false);
				if (monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
			}
			outputText("  ");
			dmg = combat.doDamage(dmg, true, true);
			outputText("\n\n");
			statScreenRefresh();
			flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
			flags[kFLAGS.SPELLS_CAST]++;
			spellPerkUnlock();
			if (monster.HP < 1) doNext(combat.endHpVictory);
			else monster.doAI();
		}
		//Terror
		public function kitsuneTerror():void {
			clearOutput();
			//Fatigue Cost: 25
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(20) > player.maxFatigue()) {
				outputText("You are too tired to use this ability.", true);
				doNext(magicalSpecials);
				return;
			}
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				monster.doAI();
				return;
			}
			if (player.findStatusEffect(StatusEffects.ThroatPunch) >= 0 || player.findStatusEffect(StatusEffects.WebSilence) >= 0) {
				outputText("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.", true);
				doNext(magicalSpecials);
				return;
			}
			if (monster.short == "pod" || monster.inte == 0) {
				outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n", true);
				player.changeFatigue(1);
				monster.doAI();
				return;
			}
			player.changeFatigue(20,1);
			//Inflicts fear and reduces enemy SPD.
			outputText("The world goes dark, an inky shadow blanketing everything in sight as you fill " + monster.a + monster.short + "'s mind with visions of otherworldly terror that defy description.");
			//(succeed)
			if (player.inte / 10 + rand(20) + 1 > monster.inte / 10 + 10 + (monster.statusEffectv2(StatusEffects.Fear) * 2)) {
				outputText("  They cower in horror as they succumb to your illusion, believing themselves beset by eldritch horrors beyond their wildest nightmares.\n\n");
				//Create status effect and increment.
				if (monster.statusEffectv2(StatusEffects.Fear) > 0)
					monster.addStatusValue(StatusEffects.Fear, 2, 1)
				else
					monster.createStatusEffect(StatusEffects.Fear, 0, 1, 0, 0);
				monster.addStatusValue(StatusEffects.Fear, 1, 5);
				monster.spe -= 5;
				if (monster.spe < 1) monster.spe = 1;
			}
			else {
				outputText("  The dark fog recedes as quickly as it rolled in as they push back your illusions, resisting your hypnotic influence.");
				if (monster.statusEffectv2(StatusEffects.Fear) >= 4) outputText(" Your foe might be resistant by now.");
				outputText("\n\n");
			}
			monster.doAI();
		}
		//Illusion
		public function kitsuneIllusion():void {
			clearOutput();
			//Fatigue Cost: 25
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + player.spellCost(25) > player.maxFatigue()) {
				outputText("You are too tired to use this ability.", true);
				doNext(magicalSpecials);
				return;
			}
			if (player.findStatusEffect(StatusEffects.ThroatPunch) >= 0 || player.findStatusEffect(StatusEffects.WebSilence) >= 0) {
				outputText("You cannot focus to use this ability while you're having so much difficult breathing.", true);
				doNext(magicalSpecials);
				return;
			}
			if (monster.short == "pod" || monster.inte == 0) {
				outputText("In the tight confines of this pod, there's no use making such an attack!\n\n", true);
				player.changeFatigue(1);
				monster.doAI();
				return;
			}
			player.changeFatigue(25,1);
			if (monster.findStatusEffect(StatusEffects.Shell) >= 0) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				monster.doAI();
				return;
			}
			//Decrease enemy speed and increase their susceptibility to lust attacks if already 110% or more
			outputText("The world begins to twist and distort around you as reality bends to your will, " + monster.a + monster.short + "'s mind blanketed in the thick fog of your illusions.");
			//Check for success rate. Maximum 100% with over 90 Intelligence difference between PC and monster. There are diminishing returns. The more you cast, the harder it is to apply another layer of illusion.
			if (player.inte/10 + rand(20) > monster.inte/10 + 9 + monster.statusEffectv1(StatusEffects.Illusion) * 2) {
			//Reduce speed down to -20. Um, are there many monsters with 110% lust vulnerability?
				outputText("  They stumble humorously to and fro, unable to keep pace with the shifting illusions that cloud their perceptions.\n\n");
				if (monster.statusEffectv1(StatusEffects.Illusion) > 0) monster.addStatusValue(StatusEffects.Illusion, 1, 1);
				else monster.createStatusEffect(StatusEffects.Illusion, 1, 0, 0, 0);
				if (monster.spe >= 0) monster.spe -= (20 - (monster.statusEffectv1(StatusEffects.Illusion) * 5));
				if (monster.lustVuln >= 1.1) monster.lustVuln += .1;
				if (monster.spe < 1) monster.spe = 1;
			}
			else {
				outputText("  Like the snapping of a rubber band, reality falls back into its rightful place as they resist your illusory conjurations.\n\n");
			}
			monster.doAI();
		}
		
		//------------
		// P. SPECIALS
		//------------
		public function physicalSpecials():void {
			if (getGame().urtaQuest.isUrta()) {
				getGame().urtaQuest.urtaSpecials();
				return;
			}
			if (getGame().inCombat && player.findStatusEffect(StatusEffects.Sealed) >= 0 && player.statusEffectv2(StatusEffects.Sealed) == 5) {
				clearOutput();
				outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
				monster.doAI();
				return;
			}
			menu();
			var button:int = 0;
			if (player.hairType == 4) {
				addButton(button++, "AnemoneSting", anemoneSting, null, null, null, "Attempt to strike an opponent with the stinging tentacles growing from your scalp.  Reduces enemy speed and increases enemy lust.", "Anemone Sting");
			}
			//Bitez
			if (player.faceType == FACE_SHARK_TEETH) {
				addButton(button++, "Bite", bite, null, null, null, "Attempt to bite your opponent with your shark-teeth.");
			}
			else if (player.faceType == FACE_SNAKE_FANGS) {
				addButton(button++, "Bite", nagaBiteAttack, null, null, null, "Attempt to bite your opponent and inject venom.");
			}
			else if (player.faceType == FACE_SPIDER_FANGS) {
				addButton(button++, "Bite", spiderBiteAttack, null, null, null, "Attempt to bite your opponent and inject venom.");
			}
			//Bow attack
			if (player.hasKeyItem("Bow") >= 0 || player.hasKeyItem("Kelt's Bow") >= 0) {
				addButton(button++, "Bow", fireBow, null, null, null, "Use a bow to fire an arrow at your opponent.");
			}
			//Constrict
			if (player.lowerBody == LOWER_BODY_TYPE_NAGA) {
				addButton(button++, "Constrict", getGame().desert.nagaScene.nagaPlayerConstrict, null, null, null, "Attempt to bind an enemy in your long snake-tail.");
			}
			//Kick attackuuuu
			else if (player.isTaur() || player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_BUNNY || player.lowerBody == LOWER_BODY_TYPE_KANGAROO) {
				addButton(button++, "Kick", kick, null, null, null, "Attempt to kick an enemy using your powerful lower body.");
			}
			//Gore if mino horns
			if (player.hornType == HORNS_COW_MINOTAUR && player.horns >= 6) {
				addButton(button++, "Gore", goreAttack, null, null, null, "Lower your head and charge your opponent, attempting to gore them on your horns.  This attack is stronger and easier to land with large horns.");
			}
			//Upheaval - requires rhino horn
			if (player.hornType == HORNS_RHINO && player.horns >= 2 && player.faceType == FACE_RHINO) {
				addButton(button++, "Upheaval", upheavalAttack, null, null, null, "Send your foe flying with your dual nose mounted horns. \n\nFatigue Cost: " + player.physicalCost(15) + "");
			}
			//Infest if infested
			if (player.findStatusEffect(StatusEffects.Infested) >= 0 && player.statusEffectv1(StatusEffects.Infested) == 5 && player.hasCock()) {
				addButton(button++, "Infest", getGame().mountain.wormsScene.playerInfest, null, null, null, "The infest attack allows you to cum at will, launching a stream of semen and worms at your opponent in order to infest them.  Unless your foe is very aroused they are likely to simply avoid it.  Only works on males or herms. \n\nAlso great for reducing your lust.");
			}
			//Kiss supercedes bite.
			if (player.findStatusEffect(StatusEffects.LustStickApplied) >= 0) {
				addButton(button++, "Kiss", kissAttack, null, null, null, "Attempt to kiss your foe on the lips with drugged lipstick.  It has no effect on those without a penis.");
			}
			switch (player.tailType) {
				case TAIL_TYPE_BEE_ABDOMEN:
					addButton(button++, "Sting", playerStinger, null, null, null, "Attempt to use your venomous bee stinger on an enemy.  Be aware it takes quite a while for your venom to build up, so depending on your abdomen's refractory period, you may have to wait quite a while between stings.  \n\nVenom: " + Math.floor(player.tailVenom) + "/100");
					break;
				case TAIL_TYPE_SPIDER_ADBOMEN:
					addButton(button++, "Web", PCWebAttack, null, null, null, "Attempt to use your abdomen to spray sticky webs at an enemy and greatly slow them down.  Be aware it takes a while for your webbing to build up.  \n\nWeb Amount: " + Math.floor(player.tailVenom) + "/100");
					break;
				case TAIL_TYPE_SALAMANDER:
					addButton(button++, "Tail Slap", tailSlapAttack, null, null, null, "Set your tail ablaze in red-hot flames to whip your foe with it to hurt and burn them!");
					//break;
				case TAIL_TYPE_SHARK:
				case TAIL_TYPE_LIZARD:
				case TAIL_TYPE_KANGAROO:
				case TAIL_TYPE_DRACONIC:
				case TAIL_TYPE_RACCOON:
					addButton(button++, "Tail Whip", tailWhipAttack, null, null, null, "Whip your foe with your tail to enrage them and lower their defense!");
				default:
			}
			if (player.shield != ShieldLib.NOTHING) {
				addButton(button++, "Shield Bash", shieldBash, null, null, null, "Bash your opponent with a shield. Has a chance to stun. Bypasses stun immunity. \n\nThe more you stun your opponent, the harder it is to stun them again.");
			}
			addButton(14, "Back", combat.combatMenu, false);
		}
		
		public function anemoneSting():void {
			clearOutput();
			//-sting with hair (combines both bee-sting effects, but weaker than either one separately):
			//Fail!
			//25% base fail chance
			//Increased by 1% for every point over PC's speed
			//Decreased by 1% for every inch of hair the PC has
			var prob:Number = 70;
			if (monster.spe > player.spe) prob -= monster.spe - player.spe;
			prob += player.hairLength;
			if (prob < rand(100)) {
				//-miss a sting
				if (monster.plural) outputText("You rush " + monster.a + monster.short + ", whipping your hair around to catch them with your tentacles, but " + monster.pronoun1 + " easily dodge.  Oy, you hope you didn't just give yourself whiplash.", false);
				else outputText("You rush " + monster.a + monster.short + ", whipping your hair around to catch it with your tentacles, but " + monster.pronoun1 + " easily dodges.  Oy, you hope you didn't just give yourself whiplash.", false);
			}	
			//Success!
			else {
				outputText("You rush " + monster.a + monster.short + ", whipping your hair around like a genie", false);
				outputText(", and manage to land a few swipes with your tentacles.  ", false);
				if (monster.plural) outputText("As the venom infiltrates " + monster.pronoun3 + " bodies, " + monster.pronoun1 + " twitch and begin to move more slowly, hampered half by paralysis and half by arousal.", false);
				else outputText("As the venom infiltrates " + monster.pronoun3 + " body, " + monster.pronoun1 + " twitches and begins to move more slowly, hampered half by paralysis and half by arousal.", false);
				//(decrease speed/str, increase lust)
				//-venom capacity determined by hair length, 2-3 stings per level of length
				//Each sting does 5-10 lust damage and 2.5-5 speed damage
				var damage:Number = 0;
				temp = 1 + rand(2);
				if (player.hairLength >= 12) temp += 1 + rand(2);
				if (player.hairLength >= 24) temp += 1 + rand(2);
				if (player.hairLength >= 36) temp += 1;
				while(temp > 0) {
					temp--;
					damage += 5 + rand(6);
				}
				damage += player.level * 1.5;
				monster.spe -= damage/2;
				damage = monster.lustVuln * damage;
				//Clean up down to 1 decimal point
				damage = Math.round(damage*10)/10;		
				monster.teased(damage);
			}
			//New lines and moving on!
			outputText("\n\n", false);
			doNext(combat.combatMenu);
			if (!combat.combatRoundOver()) monster.doAI();
		}
		
		//Mouf Attack
		public function bite():void {
			if (player.fatigue + player.physicalCost(25) > player.maxFatigue()) {
				outputText("You're too fatigued to use your shark-like jaws!", true);
				menu();
				addButton(0, "Next", combat.combatMenu, false);
				return;
			}
			//Worms are special
			if (monster.short == "worms") {
				outputText("There is no way those are going anywhere near your mouth!\n\n", true);
				menu();
				addButton(0, "Next", combat.combatMenu, false);
				return;
			}
			player.changeFatigue(25,2);
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
				monster.doAI();
				return;
			}
			outputText("You open your mouth wide, your shark teeth extending out. Snarling with hunger, you lunge at your opponent, set to bite right into them!  ", true);
			if (player.findStatusEffect(StatusEffects.Blind) >= 0) outputText("In hindsight, trying to bite someone while blind was probably a bad idea... ", false);
			var damage:Number = 0;
			//Determine if dodged!
			if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) != 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
				if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
				if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
				if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
				outputText("\n\n", false);
				monster.doAI();
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((player.str + 45) * (monster.damagePercent() / 100));
			
			//Deal damage and update based on perks
			if (damage > 0) {
				if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
				if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
				if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
				damage = combat.doDamage(damage);
			}
			
			if (damage <= 0) {
				damage = 0;
				outputText("Your bite is deflected or blocked by " + monster.a + monster.short + ". ", false);
			}
			if (damage > 0 && damage < 10) {
				outputText("You bite doesn't do much damage to " + monster.a + monster.short + "! ", false);
			}
			if (damage >= 10 && damage < 20) {
				outputText("You seriously wound " + monster.a + monster.short + " with your bite! ", false);
			}
			if (damage >= 20 && damage < 30) {
				outputText("Your bite staggers " + monster.a + monster.short + " with its force. ", false);
			}
			if (damage >= 30) {
				outputText("Your powerful bite <b>mutilates</b> " + monster.a + monster.short + "! ", false);
			}
			if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>", false)
			else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>", false)
			outputText("\n\n", false);
		 	combat.checkAchievementDamage(damage);
			//Kick back to main if no damage occured!
			if (monster.HP > 0 && monster.lust < 100) {
				monster.doAI();
			}
			else {
				if (monster.HP <= 0) doNext(combat.endHpVictory);
				else doNext(combat.endLustVictory);
			}
		}
		
		public function nagaBiteAttack():void {
			clearOutput();
			//FATIIIIGUE
			if (player.fatigue + player.physicalCost(10) > player.maxFatigue()) {
				outputText("You just don't have the energy to bite something right now...", true);
				menu();
				addButton(0, "Next", combat.combatMenu, false);
				return;
			}
			player.changeFatigue(10,2);
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
				monster.doAI();
				return;
			}
			if (monster is LivingStatue)
			{
				outputText("Your fangs can't even penetrate the giant's flesh.");
				monster.doAI();
				return;
			}
			//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		    if (rand(player.spe/2 + 40) + 20 > monster.spe/1.5 || monster.findStatusEffect(StatusEffects.Constricted) >= 0) {
				//(if monster = demons)
				if (monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your needle-like fangs deep into his flesh. You quickly release your venom and retreat before he, or the rest of the group manage to react.", false);
				//(Otherwise) 
				else outputText("You lunge at the foe headfirst, fangs bared. You manage to catch " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.pronoun1 + " manages to react.", false);
		        //The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
		        monster.str -= 5 + rand(5);
				monster.spe -= 5 + rand(5);
				if (monster.str < 1) monster.str = 1;
				if (monster.spe < 1) monster.spe = 1;
				if (monster.findStatusEffect(StatusEffects.NagaVenom) >= 0)
				{
					monster.addStatusValue(StatusEffects.NagaVenom,1,1);
				}
				else monster.createStatusEffect(StatusEffects.NagaVenom,1,0,0,0);
			}
			else {
		       outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as " + monster.a + monster.short + " manages to counter your lunge, knocking your head away with enough force to make your ears ring.", false);
			}
			outputText("\n\n", false);
			if (monster.HP < 1 || monster.lust >= monster.eMaxLust()) combat.combatRoundOver();
			else monster.doAI();
		}
		
		public function spiderBiteAttack():void {
			clearOutput();
			//FATIIIIGUE
			if (player.fatigue + player.physicalCost(10) > player.maxFatigue()) {
				outputText("You just don't have the energy to bite something right now...", true);
				menu();
				addButton(0, "Next", combat.combatMenu, false);
				return;
			}
			player.changeFatigue(10,2);
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
				monster.doAI();
				return;
			}
			if (monster is LivingStatue)
			{
				outputText("Your fangs can't even penetrate the giant's flesh.");
				monster.doAI();
				return;
			}
			//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		    if (rand(player.spe/2 + 40) + 20 > monster.spe/1.5) {
				//(if monster = demons)
				if (monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your needle-like fangs deep into his flesh. You quickly release your venom and retreat before he, or the rest of the group manage to react.", false);
				//(Otherwise) 
				else {
					if (!monster.plural) outputText("You lunge at the foe headfirst, fangs bared. You manage to catch " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manages to react.", false);
					else outputText("You lunge at the foes headfirst, fangs bared. You manage to catch one of " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manage to react.", false);
				}
				//React
				if (monster.lustVuln == 0) outputText("  Your aphrodisiac toxin has no effect!", false);
				else {
					if (monster.plural) outputText("  The one you bit flushes hotly, though the entire group seems to become more aroused in sympathy to their now-lusty compatriot.", false);
					else outputText("  " + monster.mf("He","She") + " flushes hotly and " + monster.mf("touches his suddenly-stiff member, moaning lewdly for a moment.","touches a suddenly stiff nipple, moaning lewdly.  You can smell her arousal in the air."), false);
					var lustDmg:int = 25 * monster.lustVuln;
					if (rand(5) == 0) lustDmg *= 2;
					monster.teased(lustDmg);
				}
			}
			else {
		       outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as " + monster.a + monster.short + " manages to counter your lunge, pushing you back out of range.", false);
			}
			outputText("\n\n", false);
			if (monster.HP < 1 || monster.lust >= monster.eMaxLust()) combat.combatRoundOver();
			else monster.doAI();
		}
		
		public function fireBow():void {
			clearOutput();
			if (player.fatigue + player.physicalCost(25) > player.maxFatigue()) {
				outputText("You're too fatigued to fire the bow!");
				menu();
				addButton(0, "Next", combat.combatMenu, false);
				return;
			}
			if (monster.findStatusEffect(StatusEffects.BowDisabled) >= 0) {
				outputText("You can't use your bow right now!");
				menu();
				addButton(0, "Next", combat.combatMenu, false);
				return;
			}
			player.changeFatigue(25, 2);
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
				monster.doAI();
				return;
			}
			//Prep messages vary by skill.
			if (player.statusEffectv1(StatusEffects.Kelt) < 30) {
				outputText("Fumbling a bit, you nock an arrow and fire!\n");
			}
			else if (player.statusEffectv1(StatusEffects.Kelt) < 50) {
				outputText("You pull an arrow and fire it at " + monster.a + monster.short + "!\n");
			}
			else if (player.statusEffectv1(StatusEffects.Kelt) < 80) {
				outputText("With one smooth motion you draw, nock, and fire your deadly arrow at your opponent!\n");
			}
			else if (player.statusEffectv1(StatusEffects.Kelt) <= 99) {
				outputText("In the blink of an eye you draw and fire your bow directly at " + monster.a + monster.short + ".\n");
			}
			else {
				outputText("You casually fire an arrow at " + monster.a + monster.short + " with supreme skill.\n");
				//Keep it from going over 100
				player.changeStatusValue(StatusEffects.Kelt, 1, 100);
			}
			if (monster.findStatusEffect(StatusEffects.Sandstorm) >= 0 && rand(10) > 1) {
				outputText("Your shot is blown off target by the tornado of sand and wind.  Damn!\n\n");
				monster.doAI();
				return;
			}
			//[Bow Response]
			if (monster.short == "Isabella") {
				if (monster.findStatusEffect(StatusEffects.Blind) >= 0)
					outputText("Isabella hears the shot and turns her shield towards it, completely blocking it with her wall of steel.\n\n");
				else outputText("You arrow thunks into Isabella's shield, completely blocked by the wall of steel.\n\n");
				if (getGame().isabellaFollowerScene.isabellaAccent())
					outputText("\"<i>You remind me of ze horse-people.  They cannot deal vith mein shield either!</i>\" cheers Isabella.\n\n");
				else outputText("\"<i>You remind me of the horse-people.  They cannot deal with my shield either!</i>\" cheers Isabella.\n\n");
				monster.doAI();
				return;
			}
			//worms are immune
			if (monster.short == "worms") {
				outputText("The arrow slips between the worms, sticking into the ground.\n\n");
				monster.doAI();
				return;
			}
			//Vala miss chance!
			if (monster.short == "Vala" && rand(10) < 7 && monster.findStatusEffect(StatusEffects.Stunned) < 0) {
				outputText("Vala flaps her wings and twists her body. Between the sudden gust of wind and her shifting of position, the arrow goes wide.\n\n");
				monster.doAI();
				return;
			}
			//Blind miss chance
			if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
				outputText("The arrow hits something, but blind as you are, you don't have a chance in hell of hitting anything with a bow.\n\n");
				monster.doAI();
				return;
			}
			//Miss chance 10% based on speed + 10% based on int + 20% based on skill
			if (monster.short != "pod" && player.spe / 10 + player.inte / 10 + player.statusEffectv1(StatusEffects.Kelt) / 5 + 60 < rand(101)) {
				outputText("The arrow goes wide, disappearing behind your foe.\n\n");
				monster.doAI();
				return;
			}
			//Hit!  Damage calc! 20 +
			var damage:Number = 0;
			damage = int(((20 + player.str / 3 + player.statusEffectv1(StatusEffects.Kelt) / 1.2) + player.spe / 3) * (monster.damagePercent() / 100));
			if (damage < 0) damage = 0;
			if (damage == 0) {
				if (monster.inte > 0)
					outputText(monster.capitalA + monster.short + " shrugs as the arrow bounces off them harmlessly.\n\n");
				else outputText("The arrow bounces harmlessly off " + monster.a + monster.short + ".\n\n");
				monster.doAI();
				return;
			}
			if (monster.short == "pod")
				outputText("The arrow lodges deep into the pod's fleshy wall");
			else if (monster.plural)
				outputText(monster.capitalA + monster.short + " look down at the arrow that now protrudes from one of " + monster.pronoun3 + " bodies");
			else outputText(monster.capitalA + monster.short + " looks down at the arrow that now protrudes from " + monster.pronoun3 + " body");
			if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
			if (player.hasKeyItem("Kelt's Bow") >= 0) damage *= 1.3;
			damage = combat.doDamage(damage);
			monster.lust -= 20;
			if (monster.lust < 0) monster.lust = 0;
			if (monster.HP <= 0) {
				if (monster.short == "pod")
					outputText(". ");
				else if (monster.plural)
					outputText(" and stagger, collapsing onto each other from the wounds you've inflicted on " + monster.pronoun2 + ". ");
				else outputText(" and staggers, collapsing from the wounds you've inflicted on " + monster.pronoun2 + ". ");
				outputText("<b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>");
				outputText("\n\n");
			 	combat.checkAchievementDamage(damage);
				doNext(combat.endHpVictory);
				return;
			}
			else outputText(".  It's clearly very painful. <b>(<font color=\"#800000\">" + String(damage) + "</font>)</b>\n\n");
			flags[kFLAGS.LAST_ATTACK_TYPE] = 1;
		 	combat.checkAchievementDamage(damage);
			monster.doAI();
		}
		
		public function kick():void {
			clearOutput();
			if (player.fatigue + player.physicalCost(15) > player.maxFatigue()) {
				outputText("You're too fatigued to use a charge attack!", true);
				menu();
				addButton(0, "Next", combat.combatMenu, false);
				return;
			}
			player.changeFatigue(15,2);
			//Variant start messages!
			if (player.lowerBody == LOWER_BODY_TYPE_KANGAROO) {
				//(tail)
				if (player.tailType == TAIL_TYPE_KANGAROO) outputText("You balance on your flexible kangaroo-tail, pulling both legs up before slamming them forward simultaneously in a brutal kick.  ", false);
				//(no tail) 
				else outputText("You balance on one leg and cock your powerful, kangaroo-like leg before you slam it forward in a kick.  ", false);
			}
			//(bunbun kick) 
			else if (player.lowerBody == LOWER_BODY_TYPE_BUNNY) outputText("You leap straight into the air and lash out with both your furred feet simultaneously, slamming forward in a strong kick.  ", false);
			//(centaur kick)
			else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_PONY || player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED)
				if (player.isTaur()) outputText("You lurch up onto your backlegs, lifting your forelegs from the ground a split-second before you lash them out in a vicious kick.  ", false);
				//(bipedal hoof-kick) 
				else outputText("You twist and lurch as you raise a leg and slam your hoof forward in a kick.  ", false);

			if (flags[kFLAGS.PC_FETISH] >= 3) {
				outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal attack impossible!  Maybe you could try something else?\n\n", false);
				monster.doAI();
				return;
			}
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
				monster.doAI();
				return;
			}
			//Blind
			if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
				outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
			}
			//Worms are special
			if (monster.short == "worms") {
				//50% chance of hit (int boost)
				if (rand(100) + player.inte/3 >= 50) {
					temp = int(player.str/5 - rand(5));
					if (temp == 0) temp = 1;
					outputText("You strike at the amalgamation, crushing countless worms into goo, dealing " + temp + " damage.\n\n", false);
					monster.HP -= temp;
					if (monster.HP <= 0) {
						doNext(combat.endHpVictory);
						return;
					}
				}
				//Fail
				else {
					outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n", false);
				}
				monster.doAI();
				return;
			}
			var damage:Number;
			//Determine if dodged!
			if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
				//Akbal dodges special education
				if (monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious attack with the speed and grace befitting his jaguar body.\n", false);
				else {		
					outputText(monster.capitalA + monster.short + " manage", false);
					if (!monster.plural) outputText("s", false);
					outputText(" to dodge your kick!", false);
					outputText("\n\n", false);
				}
				monster.doAI();
				return;
			}
			//Determine damage
			//Base:
			damage = player.str;
			//Leg bonus
			//Bunny - 20, Kangaroo - 35, 1 hoof = 30, 2 hooves = 40
			if (player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_PONY || player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED)
				damage += 30;
			else if (player.lowerBody == LOWER_BODY_TYPE_BUNNY) damage += 20;
			else if (player.lowerBody == LOWER_BODY_TYPE_KANGAROO) damage += 35;
			if (player.isTaur()) damage += 10;
			//Damage post processing!
			if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
			if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			//Reduce damage
			damage *= monster.damagePercent() / 100;
			//(None yet!)
			if (damage > 0) damage = combat.doDamage(damage);
			
			//BLOCKED
			if (damage <= 0) {
				damage = 0;
				outputText(monster.capitalA + monster.short, false);
				if (monster.plural) outputText("'", false);
				else outputText("s", false);
				outputText(" defenses are too tough for your kick to penetrate!", false);
			}
			//LAND A HIT!
			else {
				outputText(monster.capitalA + monster.short, false);
				if (!monster.plural) outputText(" reels from the damaging impact! <b>(<font color=\"#800000\">" + damage + "</font>)</b>", false);
				else outputText(" reel from the damaging impact! <b>(<font color=\"#800000\">" + damage + "</font>)</b>", false);
			}
			if (damage > 0) {
				//Lust raised by anemone contact!
				if (monster.short == "anemone") {
					outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.", false);
					//(gain lust, temp lose str/spd)
					(monster as Anemone).applyVenom((1+rand(2)));
				}
			}
			outputText("\n\n", false);
		 	combat.checkAchievementDamage(damage);
			if (monster.HP < 1 || monster.lust >= monster.eMaxLust()) combat.combatRoundOver();
			else monster.doAI();
		}
		
		//Gore Attack - uses 15 fatigue!
		public function goreAttack():void {
			clearOutput();
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			if (monster.short == "worms") {
				outputText("Taking advantage of your new natural weapons, you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your horns to stab only at air.\n\n");
				monster.doAI();
				return;
			}
			if (player.fatigue + player.physicalCost(15) > player.maxFatigue()) {
				outputText("You're too fatigued to use a charge attack!");
				menu();
				addButton(0, "Next", combat.combatMenu, false);
				return;
			}
			player.changeFatigue(15,2);
			var damage:Number = 0;
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
				monster.doAI();
				return;
			}
			//Bigger horns = better success chance.
			//Small horns - 60% hit
			if (player.horns >= 6 && player.horns < 12) {
				temp = 60;
			}
			//bigger horns - 75% hit
			if (player.horns >= 12 && player.horns < 20) {
				temp = 75;
			}
			//huge horns - 90% hit
			if (player.horns >= 20) {
				temp = 80;
			}
			//Vala dodgy bitch!
			if (monster.short == "Vala") {
				temp = 20;
			}
			//Account for monster speed - up to -50%.
			temp -= monster.spe/2;
			//Account for player speed - up to +50%
			temp += player.spe/2;
			//Hit & calculation
			if (temp >= rand(100)) {
				var horns:Number = player.horns;
				if (player.horns > 40) player.horns = 40;
				damage = int(player.str + horns * 2 * (monster.damagePercent() / 100)); //As normal attack + horn length bonus
				//normal
				if (rand(4) > 0) {
					outputText("You lower your head and charge, skewering " + monster.a + monster.short + " on one of your bullhorns!  ");
				}
				//CRIT
				else {
					//doubles horn bonus damage
					damage *= 2;
					outputText("You lower your head and charge, slamming into " + monster.a + monster.short + " and burying both your horns into " + monster.pronoun2 + "! <b>Critical hit!</b>  ");
				}
				//Bonus damage for rut!
				if (player.inRut && monster.cockTotal() > 0) {
					outputText("The fury of your rut lent you strength, increasing the damage!  ");
					damage += 5;
				}
				//Bonus per level damage
				damage += player.level * 2;
				//Reduced by armor
				damage *= monster.damagePercent() / 100;
				if (damage < 0) damage = 5;
				//CAP 'DAT SHIT
				if (damage > player.level * 10 + 100) damage = player.level * 10 + 100;
				if (damage > 0) {
					if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
					if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
					if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
					damage = combat.doDamage(damage);
				}
				//Different horn damage messages
				if (damage < 20) outputText("You pull yourself free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
				if (damage >= 20 && damage < 40) outputText("You struggle to pull your horns free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
				if (damage >= 40) outputText("With great difficulty you rip your horns free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
			}
			//Miss
			else {
				//Special vala changes
				if (monster.short == "Vala") {
					outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your horns as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
					dynStats("lus", 5);
				}
				else outputText("You lower your head and charge " + monster.a + monster.short + ", only to be sidestepped at the last moment!");
			}
			//New line before monster attack
			outputText("\n\n");
		 	combat.checkAchievementDamage(damage);
			flags[kFLAGS.LAST_ATTACK_TYPE] = 0;
			//Victory ORRRRR enemy turn.
			if (monster.HP > 0 && monster.lust < 100) monster.doAI();
			else {
				if (monster.HP <= 0) doNext(combat.endHpVictory);
				if (monster.lust >= monster.eMaxLust()) doNext(combat.endLustVictory);
			}
		}
		
		//Upheaval Attack
		public function upheavalAttack():void {
			clearOutput();
			if (monster.short == "worms") {
				outputText("Taking advantage of your new natural weapon, you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your horns to stab only at air.\n\n");
				monster.doAI();
				return;
			}
			if (player.fatigue + player.physicalCost(15) > player.maxFatigue()) {
				outputText("You're too fatigued to use a charge attack!");
				doNext(combat.combatMenu);
				return;
			}
			player.changeFatigue(15,2);
			var damage:Number = 0;
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
				monster.doAI();
				return;
			}
			//Bigger horns = better success chance.
			//Small horns - 60% hit
			if (player.horns >= 6 && player.horns < 12) {
				temp = 60;
			}
			//bigger horns - 75% hit
			if (player.horns >= 12 && player.horns < 20) {
				temp = 75;
			}
			//huge horns - 90% hit
			if (player.horns >= 20) {
				temp = 80;
			}
			//Vala dodgy bitch!
			if (monster.short == "Vala") {
				temp = 20;
			}
			//Account for monster speed - up to -50%.
			temp -= monster.spe/2;
			//Account for player speed - up to +50%
			temp += player.spe/2;
			//Hit & calculation
			if (temp >= rand(100)) {
				var horns:Number = player.horns;
				if (player.horns > 40) player.horns = 40;
				damage = int(player.str + (player.tou / 2) + (player.spe / 2) + (player.level * 2) * 1.2 * (monster.damagePercent() / 100)); //As normal attack + horn length bonus
				if (damage < 0) damage = 5;
				//Normal
				outputText("You hurl yourself towards the foe with your head low and jerk your head upward, every muscle flexing as you send your enemy flying. ");
				//Critical
				if (combat.combatCritical()) {
					outputText("<b>Critical hit! </b>");
					damage *= 1.75;
				}
				//CAP 'DAT SHIT
				if (damage > player.level * 10 + 100) damage = player.level * 10 + 100;
				if (damage > 0) {
					if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
					if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
					if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
					//Round it off
					damage = int(damage);
					damage = combat.doDamage(damage, true);
				}
				outputText("\n\n");
			}
			//Miss
			else {
				//Special vala changes
				if (monster.short == "Vala") {
					outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your horns as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
					dynStats("lus", 5);
				}
				else outputText("You hurl yourself towards the foe with your head low and snatch it upwards, hitting nothing but air.");
			}
			//New line before monster attack
			outputText("\n\n");
			flags[kFLAGS.LAST_ATTACK_TYPE] = 0;
		 	combat.checkAchievementDamage(damage);
			//Victory ORRRRR enemy turn.
			if (monster.HP > 0 && monster.lust < 100) monster.doAI();
			else {
				if (monster.HP <= 0) doNext(combat.endHpVictory);
				if (monster.lust >= monster.eMaxLust()) doNext(combat.endLustVictory);
			}
		}
		
		//Player sting attack
		public function playerStinger():void {
			clearOutput();
			if (player.tailVenom < 33) {
				outputText("You do not have enough venom to sting right now!");
				doNext(physicalSpecials);
				return;
			}
			//Worms are immune!
			if (monster.short == "worms") {
				outputText("Taking advantage of your new natural weapons, you quickly thrust your stinger at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving you to stab only at air.\n\n");
				monster.doAI();
				return;
			}
			//Determine if dodged!
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
				monster.doAI();
				return;
			}
			if (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80) {
				if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your stinger!\n\n");
				if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your stinger with superior quickness!\n\n");
				if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attempts to sting " + monster.pronoun2 + ".\n\n");
				monster.doAI();
				return;
			}
			//determine if avoided with armor.
			if (monster.armorDef - player.level >= 10 && rand(4) > 0) {
				outputText("Despite your best efforts, your sting attack can't penetrate " +  monster.a + monster.short + "'s defenses.\n\n");
				monster.doAI();
				return;
			}
			//Sting successful!
			outputText("Searing pain lances through " + monster.a + monster.short + " as you manage to sting " + monster.pronoun2 + "!  ");
			if (monster.plural) outputText("You watch as " + monster.pronoun1 + " stagger back a step and nearly trip, flushing hotly.");
			else outputText("You watch as " + monster.pronoun1 + " staggers back a step and nearly trips, flushing hotly.");
			//Tabulate damage!
			var damage:Number = 35 + rand(player.lib/10);
			//Level adds more damage up to a point (level 30)
			if (player.level < 10) damage += player.level * 3;
			else if (player.level < 20) damage += 30 + (player.level - 10) * 2;
			else if (player.level < 30) damage += 50 + (player.level - 20) * 1;
			else damage += 60;
			monster.teased(monster.lustVuln * damage);
			if (monster.findStatusEffect(StatusEffects.lustvenom) < 0) monster.createStatusEffect(StatusEffects.lustvenom, 0, 0, 0, 0);
			//New line before monster attack
			outputText("\n\n");
			//Use tail mp
			player.tailVenom -= 25;
			//Kick back to main if no damage occured!
			if (monster.HP > 0 && monster.lust < 100) monster.doAI();
			else doNext(combat.endLustVictory);
		}
		
		public function PCWebAttack():void {
			clearOutput();
			//Keep logic sane if this attack brings victory
			if (player.tailVenom < 33) {
				outputText("You do not have enough webbing to shoot right now!", true);
				doNext(physicalSpecials);
				return;
			}
			player.tailVenom-= 33;
			//Amily!
			if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n", true);
				monster.doAI();
				return;
			}
			if (monster.short == "lizan rogue") {
				outputText("As your webbing flies at him the lizan flips back, slashing at the adhesive strands with the claws on his hands and feet with practiced ease.  It appears he's used to countering this tactic.");
				monster.doAI();
				return;
			}
			//Blind
			if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
				outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
			}
			else outputText("Turning and clenching muscles that no human should have, you expel a spray of sticky webs at " + monster.a + monster.short + "!  ", false);
			//Determine if dodged!
			if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
				outputText("You miss " + monster.a + monster.short + " completely - ", false);
				if (monster.plural) outputText("they", false);
				else outputText(monster.mf("he","she") + " moved out of the way!\n\n", false);
				monster.doAI();
				return;
			}
			//Over-webbed
			if (monster.spe < 1) {
				if (!monster.plural) outputText(monster.capitalA + monster.short + " is completely covered in webbing, but you hose " + monster.mf("him","her") + " down again anyway.", false);
				else outputText(monster.capitalA + monster.short + " are completely covered in webbing, but you hose them down again anyway.", false);
			}
			//LAND A HIT!
			else {
				if (!monster.plural) outputText("The adhesive strands cover " + monster.a + monster.short + " with restrictive webbing, greatly slowing " + monster.mf("him","her") + ". ", false);
				else outputText("The adhesive strands cover " + monster.a + monster.short + " with restrictive webbing, greatly slowing " + monster.mf("him","her") + ". ", false);
				monster.spe -= 45;
				if (monster.spe < 0) monster.spe = 0;
			}
			awardAchievement("How Do I Shot Web?", kACHIEVEMENTS.COMBAT_SHOT_WEB);
			outputText("\n\n", false);
			if (monster.HP < 1 || monster.lust >= monster.eMaxLust()) combat.combatRoundOver();
			else monster.doAI();
		}
		
		public function kissAttack():void {
			clearOutput();
			if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
				outputText("There's no way you'd be able to find their lips while you're blind!");
				doNext(physicalSpecials);
				return;
			}
			var attack:Number = rand(6);
			switch(attack) {
				case 1:
					//Attack text 1:
					outputText("You hop up to " + monster.a + monster.short + " and attempt to plant a kiss on " + monster.pronoun3 + ".", false);
					break;
				//Attack text 2:
				case 2:
					outputText("You saunter up and dart forward, puckering your golden lips into a perfect kiss.", false);
					break;
				//Attack text 3: 
				case 3:
					outputText("Swaying sensually, you wiggle up to " + monster.a + monster.short + " and attempt to plant a nice wet kiss on " + monster.pronoun2 + ".", false);
					break;
				//Attack text 4:
				case 4:
					outputText("Lunging forward, you fly through the air at " + monster.a + monster.short + " with your lips puckered and ready to smear drugs all over " + monster.pronoun2 + ".", false);
					break;
				//Attack text 5:
				case 5:
					outputText("You lean over, your lips swollen with lust, wet with your wanting slobber as you close in on " + monster.a + monster.short + ".", false);
					break;
				//Attack text 6:
				default:
					outputText("Pursing your drug-laced lips, you close on " + monster.a + monster.short + " and try to plant a nice, wet kiss on " + monster.pronoun2 + ".", false);
					break;
			}
			//Dodged!
			if (monster.spe - player.spe > 0 && rand(((monster.spe - player.spe)/4)+80) > 80) {
				attack = rand(3);
				switch(attack) {
					//Dodge 1:
					case 1:
						if (monster.plural) outputText("  " + monster.capitalA + monster.short + " sees it coming and moves out of the way in the nick of time!\n\n", false);
						break;
					//Dodge 2:
					case 2:
						if (monster.plural) outputText("  Unfortunately, you're too slow, and " + monster.a + monster.short + " slips out of the way before you can lay a wet one on one of them.\n\n", false);
						else outputText("  Unfortunately, you're too slow, and " + monster.a + monster.short + " slips out of the way before you can lay a wet one on " + monster.pronoun2 + ".\n\n", false);
						break;
					//Dodge 3:
					default:
						if (monster.plural) outputText("  Sadly, " + monster.a + monster.short + " moves aside, denying you the chance to give one of them a smooch.\n\n", false);
						else outputText("  Sadly, " + monster.a + monster.short + " moves aside, denying you the chance to give " + monster.pronoun2 + " a smooch.\n\n", false);
						break;
				}
				monster.doAI();
				return;
			}
			//Success but no effect:
			if (monster.lustVuln <= 0 || !monster.hasCock()) {
				if (monster.plural) outputText("  Mouth presses against mouth, and you allow your tongue to stick out to taste the saliva of one of their number, making sure to give them a big dose.  Pulling back, you look at " + monster.a + monster.short + " and immediately regret wasting the time on the kiss.  It had no effect!\n\n");
				else outputText("  Mouth presses against mouth, and you allow your tongue to stick to taste " + monster.pronoun3 + "'s saliva as you make sure to give them a big dose.  Pulling back, you look at " + monster.a + monster.short + " and immediately regret wasting the time on the kiss.  It had no effect!\n\n");
				monster.doAI();
				return;
			}
			attack = rand(4);
			var damage:Number = 0;
			switch(attack) {
				//Success 1:
				case 1:
					if (monster.plural) outputText("  Success!  A spit-soaked kiss lands right on one of their mouths.  The victim quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.", false);
					else outputText("  Success!  A spit-soaked kiss lands right on " + monster.a + monster.short + "'s mouth.  " + monster.mf("He","She") + " quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.", false);
					damage = 15;
					break;
				//Success 2:
				case 2:
					if (monster.plural) outputText("  Gold-gilt lips press into one of their mouths, the victim's lips melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every bit of their mouth with your lipstick before you let them go.", false);
					else outputText("  Gold-gilt lips press into " + monster.a + monster.short + ", " + monster.pronoun3 + " mouth melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every inch of " + monster.pronoun3 + " with your lipstick before you let " + monster.pronoun2 + " go.", false);
					damage = 20;
					break;
				//CRITICAL SUCCESS (3)
				case 3:
					if (monster.plural) outputText("  You slip past " + monster.a + monster.short + "'s guard and press your lips against one of them.  " + monster.mf("He","She") + " melts against you, " + monster.mf("his","her") + " tongue sliding into your mouth as " + monster.mf("he","she") + " quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to " + monster.mf("his","her") + " mouth, you break back and observe your handwork.  One of " + monster.a + monster.short + " is still standing there, licking " + monster.mf("his","her") + " his lips while " + monster.mf("his","her") + " dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way " + monster.mf("he","she") + " will go soft now.  Though you didn't drug the rest, they're probably a little 'heated up' from the show.", false);
					else outputText("  You slip past " + monster.a + monster.short + "'s guard and press your lips against " + monster.pronoun3 + ".  " + monster.mf("He","She") + " melts against you, " + monster.pronoun3 + " tongue sliding into your mouth as " + monster.pronoun1 + " quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to " + monster.pronoun3 + " mouth, you break back and observe your handwork.  " + monster.capitalA + monster.short + " is still standing there, licking " + monster.pronoun3 + " lips while " + monster.pronoun3 + " dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way " + monster.pronoun1 + " will go soft now.", false);
					damage = 30;
					break;
				//Success 4:
				default:
					outputText("  With great effort, you slip through an opening and compress their lips against your own, lust seeping through the oral embrace along with a heavy dose of drugs.", false);
					damage = 12;
					break;
			}
			//Add status if not already drugged
			if (monster.findStatusEffect(StatusEffects.LustStick) < 0) monster.createStatusEffect(StatusEffects.LustStick,0,0,0,0);
			//Else add bonus to round damage
			else monster.addStatusValue(StatusEffects.LustStick,2,Math.round(damage/10));
			//Deal damage
			monster.teased(monster.lustVuln * damage);
			outputText("\n\n");
			//Sets up for end of combat, and if not, goes to AI.
			if (!combat.combatRoundOver()) monster.doAI();
		}
		
		//special attack: tail whip? could unlock button for use by dagrons too
		//tiny damage and lower monster armor by ~75% for one turn
		//hit
		public function tailWhipAttack():void {
			clearOutput();
			//miss
			if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
				outputText("Twirling like a top, you swing your tail, but connect with only empty air.");
			}
			else {
				if (!monster.plural) outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, " + monster.pronoun1 + " looks disbelieving, as if " + monster.pronoun3 + " world turned upside down, but " + monster.pronoun1 + " soon becomes irate and redoubles " + monster.pronoun3 + " offense, leaving large holes in " + monster.pronoun3 + " guard.  If you're going to take advantage, it had better be right away; " + monster.pronoun1 + "'ll probably cool off very quickly.");
				else outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, " + monster.pronoun1 + " look disbelieving, as if " + monster.pronoun3 + " world turned upside down, but " + monster.pronoun1 + " soon become irate and redouble " + monster.pronoun3 + " offense, leaving large holes in " + monster.pronoun3 + " guard.  If you're going to take advantage, it had better be right away; " + monster.pronoun1 + "'ll probably cool off very quickly.");
				if (monster.findStatusEffect(StatusEffects.CoonWhip) < 0) monster.createStatusEffect(StatusEffects.CoonWhip,0,0,0,0);
				temp = Math.round(monster.armorDef * .75);
				while(temp > 0 && monster.armorDef >= 1) {
					monster.armorDef--;
					monster.addStatusValue(StatusEffects.CoonWhip,1,1);
					temp--;
				}
				monster.addStatusValue(StatusEffects.CoonWhip,2,2);
				if (player.tailType == TAIL_TYPE_RACCOON) monster.addStatusValue(StatusEffects.CoonWhip,2,2);
			}
			outputText("\n\n");
			monster.doAI();
		}
		
		public function tailSlapAttack():void {
			clearOutput();
			outputText("With a simple thought you set your tail ablaze.");
			//miss
			if((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80)) {
				outputText(" Twirling like a top, you swing your tail, but connect with only empty air.");
			}
			else {
				if(!monster.plural) outputText(" Twirling like a top, you bat your opponent with your tail.");
				else outputText(" Twirling like a top, you bat your opponents with your tail.");
				var damage:Number = int((player.str) - rand(monster.tou) - monster.armorDef);
				damage = calcInfernoMod(damage);
				damage = combat.doDamage(damage);
				outputText("  Your tail slams against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
				combat.checkAchievementDamage(damage);
			}
			player.changeFatigue(40,2);
			outputText("\n\n");
			monster.doAI();
		}

		public function shieldBash():void {
			clearOutput();
			if (player.fatigue + player.physicalCost(20) > player.maxFatigue()) {
				outputText("You are too tired to perform a shield bash.");
				doNext(combat.combatMenu);
				return;
			}
			outputText("You ready your [shield] and prepare to slam it towards " + monster.a + monster.short + ".  ");
			if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
				if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
				if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
				if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
				monster.doAI();
				return;
			}
			var damage:int = 10 + (player.str / 1.5) + rand(player.str / 2) + (player.shieldBlock * 2);
			if (player.findPerk(PerkLib.ShieldSlam) >= 0) damage *= 1.2;
			damage *= (monster.damagePercent() / 100);
			var chance:int = Math.floor(monster.statusEffectv1(StatusEffects.TimesBashed) + 1);
			if (chance > 10) chance = 10;
			damage = combat.doDamage(damage);
			outputText("Your [shield] slams against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
			if (monster.findStatusEffect(StatusEffects.Stunned) < 0 && rand(chance) == 0) {
				outputText("<b>Your impact also manages to stun " + monster.a + monster.short + "!</b> ");
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				if (monster.findStatusEffect(StatusEffects.TimesBashed) < 0) monster.createStatusEffect(StatusEffects.TimesBashed, player.findPerk(PerkLib.ShieldSlam) >= 0 ? 0.5 : 1, 0, 0, 0);
				else monster.addStatusValue(StatusEffects.TimesBashed, 1, player.findPerk(PerkLib.ShieldSlam) >= 0 ? 0.5 : 1);
			}
			flags[kFLAGS.LAST_ATTACK_TYPE] = 0;
			combat.checkAchievementDamage(damage);
			player.changeFatigue(20,2);
			outputText("\n\n");
			monster.doAI();
		}
		
	}

}
