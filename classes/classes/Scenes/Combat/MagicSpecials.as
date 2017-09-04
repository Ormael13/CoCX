package classes.Scenes.Combat {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Dungeons.D3.Doppleganger;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Holli;

public class MagicSpecials extends BaseCombatContent {
	public function MagicSpecials() {}
	//------------
// M. SPECIALS
//------------
	public function msMenu():void {
		if(kGAMECLASS.urtaQuest.isUrta()) {
			kGAMECLASS.urtaQuest.urtaMSpecials();
			return;
		}
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && (player.statusEffectv2(StatusEffects.Sealed) == 6 || player.statusEffectv2(StatusEffects.Sealed) == 10)) {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.Sealed) == 6) outputText("You try to ready a special ability, but wind up stumbling dizzily instead.  <b>Your ability to use magical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			if (player.statusEffectv2(StatusEffects.Sealed) == 10) outputText("You try to use a magical ability but you are currently silenced by the alraune vines!\n\n");
			enemyAI();
			return;
		}
		menu();
		var button:int = 0;
		if (player.findPerk(PerkLib.JobSorcerer) >= 0) {
			if (player.findPerk(PerkLib.StaffChanneling) >= 0 && player.weaponPerk == "Staff") addButton(button++, "M.Bolt", magicbolt).hint("Attempt to attack the enemy with magic bolt from your " + player.weaponName + ".  Damage done is determined by your intelligence and weapon.", "Magic Bolt");
			else addButton(button++, "M.Bolt", magicbolt).hint("Attempt to attack the enemy with magic bolt.  Damage done is determined by your intelligence.", "Magic Bolt");
		}
		if (player.harpyScore() >= 8 || player.sirenScore() >= 10) {
			if (!player.hasStatusEffect(StatusEffects.CooldownCompellingAria)) {
				addButton(button++, "Compelling Aria", singCompellingAria).hint("Sing for a moment.");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownCompellingAria)) {
				outputText("<b>You need more time before you can use Compelling Aria again.</b>\n\n");
			}
		}
		if (player.findPerk(PerkLib.Incorporeality) >= 0) {
			addButton(button++, "Possess", possess).hint("Attempt to temporarily possess a foe and force them to raise their own lusts.");
		}
		if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount >= 7) {
			addButton(button++, "F.FoxFire", fusedFoxFire).hint("Unleash fused ethereal blue and corrupted purple flame at your opponent for high damage. \n\nFatigue Cost: " + spellCost(250) + "\nSoulforce cost: " + 100 * soulskillCost() * soulskillcostmulti() + "");
		}
		if (player.findPerk(PerkLib.CorruptedKitsune) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount >= 7) {
			addButton(button++, "C.FoxFire", corruptedFoxFire).hint("Unleash a corrupted purple flame at your opponent for high damage. Less effective against corrupted enemies. \n\nFatigue Cost: " + spellCost(100) + "\nSoulforce cost: " + 40 * soulskillCost() * soulskillcostmulti() + "");
			if (!player.hasStatusEffect(StatusEffects.CooldownTerror)) {
				if (player.tailCount == 9 && player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) addButton(button++, "Terror", kitsuneTerror).hint("Instill fear into your opponent with eldritch horrors. The more you cast this in a battle, the lesser effective it becomes.  \n\nWould go into cooldown after use for: 3 rounds  \n\nFatigue Cost: " + spellCost(200) + "\nSoulforce cost: " + 20 * soulskillCost() * soulskillcostmulti() + "");
				else if (player.tailCount == 9 || player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) addButton(button++, "Terror", kitsuneTerror).hint("Instill fear into your opponent with eldritch horrors. The more you cast this in a battle, the lesser effective it becomes.  \n\nWould go into cooldown after use for: 6 rounds  \n\nFatigue Cost: " + spellCost(100) + "\nSoulforce cost: " + 20 * soulskillCost() * soulskillcostmulti() + "");
				else addButton(button++, "Terror", kitsuneTerror).hint("Instill fear into your opponent with eldritch horrors. The more you cast this in a battle, the lesser effective it becomes.  \n\nWould go into cooldown after use for: 9 rounds  \n\nFatigue Cost: " + spellCost(50) + "\nSoulforce cost: " + 20 * soulskillCost() * soulskillcostmulti() + "");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownTerror)) {
				outputText("<b>You need more time before you can use Terror again.</b>\n\n");
			}
		}
		if (player.findPerk(PerkLib.EnlightenedKitsune) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount >= 7) {
			addButton(button++, "P.FoxFire", pureFoxFire).hint("Unleash an ethereal blue flame at your opponent for high damage. More effective against corrupted enemies. \n\nFatigue Cost: " + spellCost(100) + "\nSoulforce cost: " + 40 * soulskillCost() * soulskillcostmulti() + "");
			if (!player.hasStatusEffect(StatusEffects.CooldownIllusion)) {
				if (player.tailCount == 9 && player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) addButton(button++, "Illusion", kitsuneIllusion).hint("Warp the reality around your opponent to temporary boost your evasion for 3 round and arouse target slightly.  \n\nWould go into cooldown after use for: 3 rounds  \n\nFatigue Cost: " + spellCost(200) + "\nSoulforce cost: " + 20 * soulskillCost() * soulskillcostmulti() + "");
				else if (player.tailCount == 9 || player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) addButton(button++, "Illusion", kitsuneIllusion).hint("Warp the reality around your opponent to temporary boost your evasion for 3 round and arouse target slightly.  \n\nWould go into cooldown after use for: 6 rounds  \n\nFatigue Cost: " + spellCost(100) + "\nSoulforce cost: " + 20 * soulskillCost() * soulskillcostmulti() + "");
				else addButton(button++, "Illusion", kitsuneIllusion).hint("Warp the reality around your opponent to temporary boost your evasion for 3 round and arouse target slightly.  \n\nWould go into cooldown after use for: 9 rounds  \n\nFatigue Cost: " + spellCost(50) + "\nSoulforce cost: " + 20 * soulskillCost() * soulskillcostmulti() + "");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownIllusion)) {
				outputText("<b>You need more time before you can use Illusion again.</b>\n\n");
			}
		}
	/*	if (player.tailType == TAIL_TYPE_CAT && player.tailCount == 2) {
			addButton(button++, "FoxFire", foxFire).hint("Unleash a fox flame at your opponent for high damage. \n\nFatigue Cost: " + spellCost(60) + "\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti() + "");
		}	//przerobic potem na ghost fire dla nekomata race special also combining fatigue and soulfroce
	*/	if (player.findPerk(PerkLib.DarkCharm) >= 0) {
			if (!player.hasStatusEffect(StatusEffects.CooldownFascinate)) {
				addButton(button++, "Fascinate", Fascinate).hint("Put on a sexy display capting the target attention, arrousing it and maybe even stunning for a short moment. \n\nFatigue Cost: " + spellCost(30));
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownFascinate)) {
				outputText("<b>You need more time before you can use Fascinate again.</b>\n\n");
			}
			if (player.findPerk(PerkLib.BlackHeart) >= 0) {
				addButton(button++, "Lust Strike", LustStrike).hint("Use arcane gestures to flare up enemy lust. The higher your libido, intelligence and horny you're at the moment the higher enemy lust will rise. \n\nFatigue Cost: " + spellCost(50));
			}
			else addButton(button++, "Lust Strike", LustStrike).hint("Use arcane gestures to flare up enemy lust. The higher your libido and horny you're at the moment the higher enemy lust will rise. \n\nFatigue Cost: " + spellCost(50));
		}
		if (player.findPerk(PerkLib.Transference) >= 0) {
			addButton(button++, "Transfer", lustTransfer).hint("Transfer some of your own arousal to your opponent. \n\nFatigue Cost: " + spellCost(40) + "");
		}
		if (player.devilkinScore() >= 10) {
			addButton(button++, "Infernal flare", infernalflare).hint("Use corrupted flames to burn your opponent. \n\nMana Cost: " + spellCost(40));
		}
		if (player.hasStatusEffect(StatusEffects.ShieldingSpell)) addButton(9, "Shielding", shieldingSpell);
		if (player.hasStatusEffect(StatusEffects.ImmolationSpell)) addButton(9, "Immolation", immolationSpell);
		if (player.hasStatusEffect(StatusEffects.IcePrisonSpell)) addButton(9, "Ice Prison", iceprisonSpell);
		addButton(10, "Misc", specialsMisc);
		addButton(11, "BreathAtk", specialsBreathAttacks);
		addButton(12, "(De)Buffs", specialsBuffsDebuffs);
		addButton(13, "E.Aspect", specialsElementalAspect);
		addButton(14, "Back", combatMenu, false);
	}

	private function specialsMisc():void {
		menu();
		addButton(14, "Back", msMenu);
	}

	private function specialsBuffsDebuffs():void {
		menu();
		if (player.findPerk(PerkLib.JobWarrior) >= 0) {
			addButton(0, "DwarfRage", dwarfrage).hint("Throw yourself into a dwarf rage!  Greatly increases your strength, speed and fortitude! \n\nWrath Cost: 50");
		}
		if (player.findPerk(PerkLib.Berzerker) >= 0) {
			if (player.findPerk(PerkLib.ColdFury) >= 0) {
				addButton(1, "Berserk", berzerk).hint("Throw yourself into a cold rage!  Greatly increases the strength of your weapon and increases lust resistance! \n\nWrath Cost: 50");
			}
			else addButton(1, "Berserk", berzerk).hint("Throw yourself into a rage!  Greatly increases the strength of your weapon and increases lust resistance, but your armor defense is reduced to zero! \n\nWrath Cost: 50");
		}
		if (player.findPerk(PerkLib.Lustzerker) >= 0) {
			if (player.findPerk(PerkLib.ColdLust) >= 0) {
				addButton(2, "Lustserk", lustzerk).hint("Throw yourself into a cold lust rage!  Greatly increases the strength of your weapon and increases armor defense! \n\nWrath Cost: 50");
			}
			else addButton(2, "Lustserk", lustzerk).hint("Throw yourself into a lust rage!  Greatly increases the strength of your weapon and increases armor defense, but your lust resistance is reduced to zero! \n\nWrath Cost: 50");
		}
		if (player.devilkinScore() >= 10) {
			addButton(3, "Maleficium", maleficium).hint("Infuse yourself with corrupt power empowering your magic but reducing your resistance to carnal assault.");
		}
		if (player.oniScore() >= 12) {
			addButton(4, "Oni Rampage", startOniRampage).hint("Increase all damage done by a massive amount but silences you preventing using spells or magical oriented soulskills.");
		}
		if (player.eyeType == EYES_GORGON && player.hairType == HAIR_GORGON || player.findPerk(PerkLib.GorgonsEyes) >= 0) {
			addButton(5, "Petrify", petrify).hint("Use your gaze to temporally turn your enemy into a stone. \n\nFatigue Cost: " + spellCost(100));
		}
		if (player.findPerk(PerkLib.Whispered) >= 0) {
			addButton(6, "Whisper", superWhisperAttack).hint("Whisper and induce fear in your opponent. \n\nFatigue Cost: " + spellCost(10) + "");
		}
		addButton(14, "Back", msMenu);
	}

	private function specialsBreathAttacks():void {
		menu();
		if (player.findPerk(PerkLib.DragonFireBreath) >= 0) {
			addButton(0, "DragonFire", dragonfireBreath).hint("Unleash fire from your mouth. This can only be done once a day. \n\nFatigue Cost: " + spellCost(50), "Dragon Fire Breath");
		}
		if (player.findPerk(PerkLib.DragonIceBreath) >= 0) {
			addButton(1, "DragonIce", dragoniceBreath).hint("Unleash ice from your mouth. This can only be done once a day. \n\nFatigue Cost: " + spellCost(50), "Dragon Ice Breath");
		}
		if (player.findPerk(PerkLib.DragonLightningBreath) >= 0) {
			addButton(2, "DragonLightning", dragonlightningBreath).hint("Unleash lightning from your mouth. This can only be done once a day. \n\nFatigue Cost: " + spellCost(50), "Dragon Lightning Breath");
		}
		if (player.findPerk(PerkLib.DragonDarknessBreath) >= 0) {
			addButton(3, "DragonDarkness", dragondarknessBreath).hint("Unleash dakness from your mouth. This can only be done once a day. \n\nFatigue Cost: " + spellCost(50), "Dragon Darkness Breath");
		}
		if (player.faceType == FACE_WOLF && player.hasKeyItem("Fenrir Collar") >= 0) {
			if (!player.hasStatusEffect(StatusEffects.CooldownFreezingBreath)) {
				addButton(5, "FreezingBreath", fenrirFreezingBreath).hint("Freeze your foe solid with a powerful breath attack. \n\nFatigue Cost: " + spellCost(150) + "  \n\nWould go into cooldown after use for: 10 rounds  \n\n<b>AoE attack.</b>");
			}
			else addButtonDisabled(5, "FreezingBreath", "You need more time before you can use Freezing Breath again.");
		}
		if (player.findPerk(PerkLib.FreezingBreathYeti) >= 0) {
			if (!player.hasStatusEffect(StatusEffects.CooldownFreezingBreathYeti)) {
				addButton(6, "FreezingBreath", yetiFreezingBreath).hint("Freeze your foe solid with a powerful breath attack. \n\nFatigue Cost: " + spellCost(50) + "  \n\nWould go into cooldown after use for: 10 rounds");
			}
			else addButtonDisabled(6, "FreezingBreath", "You need more time before you can use Freezing Breath again.");
		}
		if (player.findPerk(PerkLib.FireLord) >= 0) {
			addButton(7,"Fire Breath",fireballuuuuu).hint("Unleash fire from your mouth. \n\nFatigue Cost: 20", "Fire Breath");
		}
		if (player.findPerk(PerkLib.Hellfire) >= 0) {
			addButton(8,"Hellfire",hellFire).hint("Unleash fire from your mouth. \n\nFatigue Cost: " + spellCost(20));
		}
		if (player.findPerk(PerkLib.PhoenixFireBreath) >= 0) {
			if (!player.hasStatusEffect(StatusEffects.CooldownPhoenixFireBreath)) {
				addButton(9, "PhoenixFire", phoenixfireBreath).hint("Unleash fire from your mouth. \n\nFatigue Cost: " + spellCost(40) + "  \n\nWould go into cooldown after use for: 5 rounds", "Phoenix Fire Breath");
			}
			else addButtonDisabled(9, "PhoenixFire", "You need more time before you can use Phoenix Fire again.");
		}
		addButton(14, "Back", msMenu);
	}

	private function specialsElementalAspect():void {
		menu();
		//if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) addButton(0, "Air", ElementalAspectAir);
		//if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) addButton(1, "Earth", );
		//if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) addButton(2, "Fire", ElementalAspectFire);
		//if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) addButton(3, "Water", );
		//if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) addButton(4, "Ice", ElementalAspectIce);
		//if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) addButton(5, "Lightning", );
		//if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) addButton(6, "Darkness", );
		//wood
		//metal
		//?lust/corruption?
		addButton(14, "Back", msMenu);
	}

//New Abilities and Items
//[Abilities]
//Whisper
	public function superWhisperAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(10) > player.maxFatigue())
		{
			clearOutput();
			outputText("You are too tired to focus this ability.");
			doNext(combatMenu);
			return;
		}
		if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
			clearOutput();
			outputText("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.");
			doNext(combatMenu);
			return;
		}
		if(monster.short == "pod" || monster.inte == 0) {
			clearOutput();
			outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n");
			fatigue(1);
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("There is nothing inside the golem to whisper to.");
			fatigue(1);
			enemyAI();
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(10, 1);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if(monster.findPerk(PerkLib.Focused) >= 0) {
			if(!monster.plural) outputText(monster.capitalA + monster.short + " is too focused for your whispers to influence!\n\n");
			enemyAI();
			return;
		}
		//Enemy too strong or multiplesI think you
		if(player.inte < monster.inte || monster.plural) {
			outputText("You reach for your enemy's mind, but can't break through.\n");
			fatigue(10);
			enemyAI();
			return;
		}
		//[Failure]
		if(rand(10) == 0) {
			outputText("As you reach for your enemy's mind, you are distracted and the chorus of voices screams out all at once within your mind. You're forced to hastily silence the voices to protect yourself.");
			fatigue(10);
			enemyAI();
			return;
		}
		outputText("You reach for your enemy's mind, watching as its sudden fear petrifies your foe.\n\n");
		monster.createStatusEffect(StatusEffects.Fear,1,0,0,0);
		enemyAI();
	}

	public function fenrirFreezingBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(150) > player.maxFatigue())
		{
			clearOutput();
			outputText("You are too tired to breathe ice.");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(150, 1);
		player.createStatusEffect(StatusEffects.CooldownFreezingBreath,10,0,0,0);
		var damage:Number = int(player.level * (8 + player.wolfScore()) + rand(60));
		damage = calcGlacialMod(damage);
		if (monster.findPerk(PerkLib.EnemyGroupType) >= 0) damage *= 5;
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.2;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 5;
		if (player.findPerk(PerkLib.ColdMastery) >= 0) damage *= 2;
		if (player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 2;
		damage = Math.round(damage);
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, a powerful wave of cold blasting the area in front of you.  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of freezing air is too fast.");
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.");
			enemyAI();
			return;
		}
		//Special enemy avoidances
		if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the ice wave back at you! ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice wave with your [shield]!");
			}
			else {
				damage = takeDamage(damage);
				outputText("Your own ice wave smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(monster.findPerk(PerkLib.Resolute) < 0) {
				outputText("  " + monster.capitalA + monster.short + " scream for an instant as it is flash frozen solid by the wave along with everything around it! Your opponent now trapped in a block of ice tries very hard to burst out and get free of its glacial prison.");
				monster.createStatusEffect(StatusEffects.FreezingBreathStun,3,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be frozen by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			enemyAI();
		}
		else combatRoundOver();
	}

	public function yetiFreezingBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(50) > player.maxFatigue())
		{
			clearOutput();
			outputText("You are too tired to breathe ice.");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(50, 1);
		player.createStatusEffect(StatusEffects.CooldownFreezingBreathYeti,10,0,0,0);
		var damage:Number = 0;
		if (player.tou >= 21 && player.tou < 41) damage += (player.tou / 2 + rand((player.tou * 3) / 4));
		if (player.tou >= 41 && player.tou < 61) damage += ((player.tou * 2) / 3 + rand(player.tou));
		if (player.tou >= 61 && player.tou < 81) damage += ((player.tou * 5) / 6 + rand(player.tou * 1.25));
		if (player.tou >= 81 && player.tou < 101) damage += (player.tou + rand(player.tou * 1.5));
		if (player.tou >= 101 && player.tou < 151) damage += ((player.tou * 1.25) + rand(player.tou * 1.75));
		if (player.tou >= 151 && player.tou < 201) damage += ((player.tou * 1.5) + rand(player.tou * 2));
		if (player.tou >= 201 && player.tou < 251) damage += ((player.tou * 1.75) + rand(player.tou * 2.25));
		if (player.tou >= 251 && player.tou < 301) damage += ((player.tou * 2) + rand(player.tou * 2.5));
		if (player.tou >= 301 && player.tou < 351) damage += ((player.tou * 2.25) + rand(player.tou * 2.75));
		if (player.tou >= 351 && player.tou < 401) damage += ((player.tou * 2.5) + rand(player.tou * 3));
		if (player.tou >= 401 && player.tou < 451) damage += ((player.tou * 2.75) + rand(player.tou * 3.25));
		if (player.tou >= 451 && player.tou < 501) damage += ((player.tou * 3) + rand(player.tou * 3.5));
		if (player.tou >= 501 && player.tou < 551) damage += ((player.tou * 3.25) + rand(player.tou * 3.75));
		if (player.tou >= 551 && player.tou < 601) damage += ((player.tou * 3.5) + rand(player.tou * 4));
		if (player.tou >= 601 && player.tou < 651) damage += ((player.tou * 3.75) + rand(player.tou * 4.25));
		if (player.tou >= 651 && player.tou < 701) damage += ((player.tou * 4) + rand(player.tou * 4.5));
		if (player.tou >= 701 && player.tou < 751) damage += ((player.tou * 4.25) + rand(player.tou * 4.75));
		if (player.tou >= 751 && player.tou < 801) damage += ((player.tou * 4.5) + rand(player.tou * 5));
		if (player.tou >= 801 && player.tou < 851) damage += ((player.tou * 4.75) + rand(player.tou * 5.25));
		if (player.tou >= 851 && player.tou < 901) damage += ((player.tou * 5) + rand(player.tou * 5.5));
		if (player.tou >= 901 && player.tou < 951) damage += ((player.tou * 5.25) + rand(player.tou * 5.75));
		if (player.tou >= 951) damage += ((player.tou * 5.5) + rand(player.tou * 6));
		else damage += (player.tou/3 + rand(player.tou/2));
		damage = calcGlacialMod(damage);
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.2;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 5;
		if (player.findPerk(PerkLib.ColdMastery) >= 0) damage *= 2;
		if (player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 2;
		damage = Math.round(damage);
		outputText("You inhale deeply, then blow a freezing breath attack at your opponent, encasing it in ice!");
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.");
			enemyAI();
			return;
		}
		//Special enemy avoidances
		if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the ice wave back at you! ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice wave with your [shield]!");
			}
			else {
				damage = takeDamage(damage);
				outputText("Your own ice wave smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(monster.findPerk(PerkLib.Resolute) < 0) {
				outputText("  " + monster.capitalA + monster.short + " ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText(" frozen solid!");
				monster.createStatusEffect(StatusEffects.FreezingBreathStun,3,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be frozen by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			enemyAI();
		}
		else combatRoundOver();
	}

	public function singCompellingAria():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
			outputText("You end your theme with a powerful finale compelling everyone around adore and love you.");
			var lustDmgF:Number = monster.lustVuln * 3 * (player.inte / 5 * player.teaseLevel + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.findPerk(PerkLib.ArcaneLash) >= 0) lustDmgF *= 1.5;
			if (monster.findPerk(PerkLib.EnemyGroupType) >= 0) {
				if (player.findPerk(PerkLib.ArouseTheAudience) >= 0) lustDmgF *= 7.5;
				else lustDmgF *= 5;
			}
			lustDmgF = Math.round(lustDmgF);
			monster.teased(lustDmgF);
			if(monster.findPerk(PerkLib.Resolute) < 0) monster.createStatusEffect(StatusEffects.Stunned,4,0,0,0);
			player.createStatusEffect(StatusEffects.CooldownCompellingAria,10,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			outputText("\n\n");
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
				enemyAI();
			}
			else enemyAI();
		}
		else if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You are still singing. Your compelling aria reaches far up to your opponent");
			if(monster.plural) outputText("s");
			outputText(" ears.");
			var lustDmg2:Number = monster.lustVuln * (player.inte / 5 * player.teaseLevel + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.findPerk(PerkLib.ArcaneLash) >= 0) lustDmg2 *= 1.5;
			lustDmg2 = Math.round(lustDmg2);
			monster.teased(lustDmg2);
			player.addStatusValue(StatusEffects.ChanneledAttack, 1, 1);
			outputText("\n\n");
			enemyAI();
		}
		else {
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(50) > player.maxFatigue())
			{
				clearOutput();
				outputText("You are too tired to sing.");
				doNext(combatMenu);
				return;
			}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			fatigue(50, 1);
			clearOutput();
			outputText("You start singing a enrapturing song.");
			var lustDmg:Number = monster.lustVuln * 0.5 * (player.inte / 5 * player.teaseLevel + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.findPerk(PerkLib.ArcaneLash) >= 0) lustDmg *= 1.5;
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 1, 0, 0, 0);
			outputText("\n\n");
			enemyAI();
		}
	}

	public function startOniRampage():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("A terrifying red aura of power shroud your body as you shout a loud thundering war cry and enter a murderous rampage.");
			var onirampageDuration:Number = 6;
			player.createStatusEffect(StatusEffects.OniRampage,onirampageDuration,0,0,0);
			player.createStatusEffect(StatusEffects.CooldownOniRampage,10,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			outputText("\n\n");
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
				enemyAI();
			}
			else enemyAI();
		}
		else {
			if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(50) > player.maxFatigue())
			{
				clearOutput();
				outputText("You are too tired to start rampage.");
				doNext(msMenu);
				return;
			}
			if(player.hasStatusEffect(StatusEffects.OniRampage)) {
				outputText("You already rampaging!");
				doNext(msMenu);
				return;
			}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			fatigue(50, 1);
			clearOutput();
			outputText("That does it! You crouch and lift a leg then another in alternance, stomping the ground as you focus your anger.\n\n");
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 2, 0, 0, 0);
			enemyAI();
		}
	}

	public function phoenixfireBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(40) > player.maxFatigue())
		{
			clearOutput();
			outputText("You are too tired to breathe fire.");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(40, 1);
		player.createStatusEffect(StatusEffects.CooldownPhoenixFireBreath,5,0,0,0);
		var damage:Number = 0;
		damage += 50 + rand(20);
		damage += (player.level * 10);
		damage = calcInfernoMod(damage);
		if (player.findPerk(PerkLib.DraconicLungsEvolved) >= 0) damage *= 3;
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 2;
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The fire courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!\n\n");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 8 + 25 + rand(10));
			if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
				player.removeStatusEffect(StatusEffects.DragonBreathBoost);
				damage *= 1.5;
			}
			damage *= 1.75;
			outputText(" (" + damage + ")");
			monster.HP -= damage;
			combatRoundOver();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your attack, " + monster.a + monster.short + " manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if(player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the fireball energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own fire with your [shield]!");
			}
			else {
				damage = takeDamage(damage);
				outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		//Goos burn
		else if(monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ");
			if(monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5);
			damage = doDamage(damage);
			outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		}
		else {
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		if(monster.findPerk(PerkLib.Resolute) < 0) {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}
		else {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		if (monster is Holli && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			enemyAI();
		}
		else combatRoundOver();
	}

//Attack used:
//This attack has a cooldown and is more dramatic when used by the PC, it should be some sort of last ditch attack for emergencies. Don't count on using this whenever you want.
	//once a day or something
	//Effect of attack: Damages and stuns the enemy for the turn you used this attack on, plus 2 more turns. High chance of success.
	public function dragonfireBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(50) > player.maxFatigue())
		{
			clearOutput();
			outputText("You are too tired to breathe fire.");
			doNext(combatMenu);
			return;
		}
		//Not Ready Yet:
		if(player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown)) {
			outputText("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(50, 1);
		player.createStatusEffect(StatusEffects.DragonFireBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += inteligencescalingbonus();// * 0.5
		damage += wisdomscalingbonus();// * 0.5
		damage += rand(player.level + player.dragonScore());
		damage = calcInfernoMod(damage);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.findPerk(PerkLib.DraconicLungsEvolved) >= 0) damage *= 3;
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 2;
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The fire courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!\n\n");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 8 + 25 + rand(10));
			if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
				player.removeStatusEffect(StatusEffects.DragonBreathBoost);
				damage *= 1.5;
			}
			damage *= 1.75;
			outputText(" (" + damage + ")");
			monster.HP -= damage;
			combatRoundOver();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, " + monster.a + monster.short + " manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if(player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the fireball energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own fire with your [shield]!");
			}
			else {
				damage = takeDamage(damage);
				outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		//Goos burn
		else if(monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ");
			if(monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5);
			damage = doDamage(damage);
			monster.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
			outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		}
		else {
			if(monster.findPerk(PerkLib.Resolute) < 0) {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		if (monster is Holli && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			enemyAI();
		}
		else combatRoundOver();
	}

	public function dragoniceBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(50) > player.maxFatigue())
		{
			clearOutput();
			outputText("You are too tired to breathe ice.");
			doNext(combatMenu);
			return;
		}
		//Not Ready Yet:
		if(player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown)) {
			outputText("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(50, 1);
		player.createStatusEffect(StatusEffects.DragonIceBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += inteligencescalingbonus();// * 0.5
		damage += wisdomscalingbonus();// * 0.5
		damage += rand(player.level + player.dragonScore());
		damage = calcGlacialMod(damage);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.findPerk(PerkLib.DraconicLungsEvolved) >= 0) damage *= 3;
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.2;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 5;
		if (player.findPerk(PerkLib.ColdMastery) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 2;
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		//Miss:
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, " + monster.a + monster.short + " manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the iceball back at you! ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice with your [shield]!");
			}
			else {
				damage = takeDamage(damage);
				outputText("Your own ice smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(monster.findPerk(PerkLib.Resolute) < 0) {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			enemyAI();
		}
		else combatRoundOver();
	}

	public function dragonlightningBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(50) > player.maxFatigue())
		{
			clearOutput();
			outputText("You are too tired to breathe lightning.");
			doNext(combatMenu);
			return;
		}
		//Not Ready Yet:
		if(player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) {
			outputText("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(50, 1);
		player.createStatusEffect(StatusEffects.DragonLightningBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += inteligencescalingbonus();// * 0.5
		damage += wisdomscalingbonus();// * 0.5
		damage += rand(player.level + player.dragonScore());
//	damage = calcGlacialMod(damage);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.findPerk(PerkLib.DraconicLungsEvolved) >= 0) damage *= 3;
		if (monster.findPerk(PerkLib.LightningNature) >= 0) damage *= 0.2;
		if (monster.findPerk(PerkLib.DarknessVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.LightningVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.DarknessNature) >= 0) damage *= 5;
//	if (player.findPerk(PerkLib.ColdMastery) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 2;
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The lightning courses by the stone skin harmlessly. Thou it does leave the surface of the statue sparkling with a few residual lighting discharges.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		//Miss:
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, " + monster.a + monster.short + " manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the lightning bolt back at you! ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own lightning with your [shield]!");
			}
			else {
				damage = takeDamage(damage);
				outputText("Your own lightning smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(monster.findPerk(PerkLib.Resolute) < 0) {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			enemyAI();
		}
		else combatRoundOver();
	}

	public function dragondarknessBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(50) > player.maxFatigue())
		{
			outputText("You are too tired to breathe dakness.");
			doNext(combatMenu);
			return;
		}
		//Not Ready Yet:
		if(player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown)) {
			outputText("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(50, 1);
		player.createStatusEffect(StatusEffects.DragonDarknessBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += inteligencescalingbonus();// * 0.5
		damage += wisdomscalingbonus();// * 0.5
		damage += rand(player.level + player.dragonScore());
//	damage = calcGlacialMod(damage);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.findPerk(PerkLib.DraconicLungsEvolved) >= 0) damage *= 3;
		if (monster.findPerk(PerkLib.DarknessNature) >= 0) damage *= 0.2;
		if (monster.findPerk(PerkLib.LightningVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.DarknessVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.LightningNature) >= 0) damage *= 5;
//	if (player.findPerk(PerkLib.ColdMastery) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 2;
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The darkness courses by the stone skin harmlessly. Thou it does leave the surface of the statue with a thin layer of dark glow.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		//Miss:
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, " + monster.a + monster.short + " manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the darkness shard back at you! ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own darkness with your [shield]!");
			}
			else {
				damage = takeDamage(damage);
				outputText("Your own darkness smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(monster.findPerk(PerkLib.Resolute) < 0) {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			enemyAI();
		}
		else combatRoundOver();
	}
//* Terrestrial Fire
	public function fireballuuuuu():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.fatigue + 20 > player.maxFatigue()) {
			clearOutput();
			outputText("You are too tired to breathe fire.");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(20);

		//[Failure]
		//(high damage to self, +10 fatigue on top of ability cost)
		if(rand(5) == 0 || player.hasStatusEffect(StatusEffects.WebSilence)) {
			if(player.hasStatusEffect(StatusEffects.WebSilence)) outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, it backs up in your throat, blocked by the webbing across your mouth.  It causes you to cry out as the sudden, heated force explodes in your own throat. ");
			else if(player.hasStatusEffect(StatusEffects.GooArmorSilence)) outputText("You reach for the terrestrial fire but as you ready the torrent, it erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat.  The slime covering your mouth bubbles and pops, boiling away where the escaping flame opens small rents in it.  That wasn't as effective as you'd hoped, but you can at least speak now. ");
			else outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, the fire inside erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat. ");
			fatigue(10);
			takeDamage(10 + rand(20), true);
			outputText("\n\n");
			enemyAI();
			return;
		}

		var damage:Number;
		damage = int(player.level * 10 + 45 + rand(10));
		damage = calcInfernoMod(damage);
		if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 2;
		damage = Math.round(damage);

		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The fire courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}
		if (monster is Doppleganger)
		{
			(monster as Doppleganger).handleSpellResistance("fireball");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			return;
		}
		if(player.hasStatusEffect(StatusEffects.GooArmorSilence)) {
			outputText("<b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  When you can finally work your jaw enough to open your mouth, you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b> ");
			player.removeStatusEffect(StatusEffects.GooArmorSilence);
			damage += 25;
		}
		else outputText("A growl rumbles deep with your chest as you charge the terrestrial fire.  When you can hold it no longer, you release an ear splitting roar and hurl a giant green conflagration at your enemy. ");

		if(monster.short == "Isabella" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Isabella shoulders her shield into the path of the emerald flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to the sides.\n\n");
			if (kGAMECLASS.isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n");
			else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n");
			enemyAI();
			return;
		}
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if(player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the fireball energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
			}
			else {
				//Determine if blocked!
				if (combatBlock(true)) {
					outputText("You manage to block your own fire with your [shield]!");
					combatRoundOver();
					return;
				}
				outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
				takeDamage(damage);
			}
			outputText("\n\n");
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!\n\n");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 10 + 45 + rand(10));
			damage *= 1.75;
			outputText(" (" + damage + ")");
			monster.HP -= damage;
			if(monster.HP < 1) {
				doNext(endHpVictory);
			}
			else if(monster.lust >= 99) {
				doNext(endLustVictory);
			}
			else enemyAI();
			return;
		}
		else {
			//Using fire attacks on the goo]
			if(monster.short == "goo-girl") {
				outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ");
				if(monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
				damage = Math.round(damage * 1.5);
			}
			if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
				outputText("<b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>  ");
				damage = Math.round(0.5 * damage);
			}
			outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
			monster.HP -= damage;
			if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		}
		checkAchievementDamage(damage);
		if(monster.HP < 1) {
			doNext(endHpVictory);
		}
		else enemyAI();
	}

	//player gains hellfire perk.
//Hellfire deals physical damage to completely pure foes,
//lust damage to completely corrupt foes, and a mix for those in between.  Its power is based on the PC's corruption and level.  Appearance is slightly changed to mention that the PC's eyes and mouth occasionally show flicks of fire from within them, text could possibly vary based on corruption.
	public function hellFire():void {
		if (monster.cor < 50) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		if (player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(20) > player.maxFatigue()) {
			outputText("You are too tired to breathe fire.\n");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(20, 1);
		var damage:Number = (player.level * 8 + rand(10) + player.inte / 2 + player.cor / 5);
		damage = calcInfernoMod(damage);
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("The fire courses over the stone behemoths skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}

		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 8 + rand(10) + player.cor / 5);
			damage *= 1.75;
			outputText(" (" + damage + ")");
			monster.HP -= damage;
			if(monster.HP < 1) {
				doNext(endHpVictory);
			}
			else if(monster.lust >= monster.eMaxLust()) {
				doNext(endLustVictory);
			}
			else enemyAI();
			return;
		}

		if(!player.hasStatusEffect(StatusEffects.GooArmorSilence)) outputText("You take in a deep breath and unleash a wave of corrupt red flames from deep within.");

		if(player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("  <b>The fire burns through the webs blocking your mouth!</b>");
			player.removeStatusEffect(StatusEffects.WebSilence);
		}
		if(player.hasStatusEffect(StatusEffects.GooArmorSilence)) {
			outputText("  <b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  When you can finally work your jaw enough to open your mouth, you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b>");
			player.removeStatusEffect(StatusEffects.GooArmorSilence);
			damage += 25;
		}
		if(monster.short == "Isabella" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("  Isabella shoulders her shield into the path of the crimson flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to the sides.\n\n");
			if (kGAMECLASS.isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n");
			else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n");
			enemyAI();
			return;
		}
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("  Vala beats her wings with surprising strength, blowing the fireball back at you!  ");
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if(player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the fireball energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
			}
			else {
				damage = int(damage / 6);
				outputText("Your own fire smacks into your face, arousing you!");
				dynStats("lus", damage);
			}
			outputText("\n");
		}
		else {
			if(monster.inte < 10) {
				outputText("  Your foe lets out a shriek as their form is engulfed in the blistering flames.");
				if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
				if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
				if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
				if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 2;
				damage = Math.round(damage);
				damage = int(damage);
				outputText("<b>(<font color=\"#800000\">+" + damage + "</font>)</b>\n");
				monster.HP -= damage;
			}
			else {
				if(monster.lustVuln > 0) {
					outputText("  Your foe cries out in surprise and then gives a sensual moan as the flames of your passion surround them and fill their body with unnatural lust.");
					monster.teased(monster.lustVuln * damage / 6);
					outputText("\n");
				}
				else {
					outputText("  The corrupted fire doesn't seem to have effect on " + monster.a + monster.short + "!\n");
				}
			}
		}
		outputText("\n");
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		if(monster.HP < 1) {
			doNext(endHpVictory);
		}
		else if(monster.lust >= monster.eMaxLust()) {
			doNext(endLustVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}
	public function magicbolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
//	fatigue(40,1);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic bolt touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		outputText("You narrow your eyes, focusing your mind with deadly intent.  ");
		if (player.findPerk(PerkLib.StaffChanneling) >= 0 && player.weaponPerk == "Staff") outputText("You point your staff and shots magic bolt toward " + monster.a + monster.short + "!\n\n");
		else outputText("You point your hand toward " + monster.a + monster.short + " and shots magic bolt!\n\n");
		temp = 0;
		temp += player.inte;
		if (player.inte >= 21) temp += ((player.inte - 20) * 0.25);
		if (player.inte >= 41) temp += ((player.inte - 40) * 0.25);
		if (player.inte >= 61) temp += ((player.inte - 60) * 0.25);
		if (player.inte >= 81) temp += ((player.inte - 80) * 0.25);
		if (player.inte >= 101) temp += ((player.inte - 100) * 0.25);
		if (player.inte >= 151) temp += ((player.inte - 150) * 0.25);
		if (player.inte >= 201) temp += ((player.inte - 200) * 0.25);
		if (player.inte >= 251) temp += ((player.inte - 250) * 0.25);
		if (player.inte >= 301) temp += ((player.inte - 300) * 0.25);
		if (player.inte >= 351) temp += ((player.inte - 350) * 0.25);
		if (player.inte >= 401) temp += ((player.inte - 400) * 0.25);
		if (player.inte >= 451) temp += ((player.inte - 450) * 0.25);
		if (player.inte >= 501) temp += ((player.inte - 500) * 0.25);
		if (player.inte >= 551) temp += ((player.inte - 550) * 0.25);
		if (player.inte >= 601) temp += ((player.inte - 600) * 0.25);
		if (player.inte >= 651) temp += ((player.inte - 650) * 0.25);
		if (player.inte >= 701) temp += ((player.inte - 700) * 0.25);
		if (player.inte >= 751) temp += ((player.inte - 750) * 0.25);
		if (player.inte >= 801) temp += ((player.inte - 800) * 0.25);
		if (player.inte >= 851) temp += ((player.inte - 850) * 0.25);
		if (player.inte >= 901) temp += ((player.inte - 900) * 0.25);
		if (player.inte >= 951) temp += ((player.inte - 950) * 0.25);
		if (player.inte >= 1001) temp += ((player.inte - 1000) * 0.25);
		if (player.inte >= 1051) temp += ((player.inte - 1050) * 0.25);
		if (player.inte >= 1101) temp += ((player.inte - 1100) * 0.25);
		if (player.inte >= 1151) temp += ((player.inte - 1150) * 0.25);
		if (player.inte >= 1201) temp += ((player.inte - 1200) * 0.25);
		if (temp < 10) temp = 10;
		//weapon bonus
		if (player.findPerk(PerkLib.StaffChanneling) >= 0 && player.weaponPerk == "Staff") {
			if (player.weaponAttack < 51) temp *= (1 + (player.weaponAttack * 0.04));
			else if (player.weaponAttack >= 51 && player.weaponAttack < 101) temp *= (3 + ((player.weaponAttack - 50) * 0.035));
			else if (player.weaponAttack >= 101 && player.weaponAttack < 151) temp *= (4.75 + ((player.weaponAttack - 100) * 0.03));
			else if (player.weaponAttack >= 151 && player.weaponAttack < 201) temp *= (6.25 + ((player.weaponAttack - 150) * 0.025));
			else temp *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		temp = Math.round(temp);
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + temp + "</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		checkAchievementDamage(temp);
		monster.HP -= temp;
		statScreenRefresh();
		if (monster.HP < 1)
		{
			doNext(endHpVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
//	if(monster.lustVuln > 0) {
//			if(player.weaponPerk == "Aphrodisiac Weapon") {
//				outputText("\n" + monster.capitalA + monster.short + " shivers as your weapon's 'poison' goes to work.");
//				monster.teased(monster.lustVuln * (5 + player.cor / 10));
//			}
	}
	
	public function dwarfrage():void {
		clearOutput();
		if (player.wrath < 50) {
			outputText("Your wrath is too low to enter this state!");
			doNext(msMenu);
			return;
		}
		if(player.hasStatusEffect(StatusEffects.DwarfRage)) {
			outputText("You already raging!");
			doNext(msMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		player.wrath -= 50;
		var temp:Number = 0;
		var tempStr:Number = 0;
		var tempTouSpe:Number = 0;
		var dwarfrageDuration:Number = 10;
		var DwarfRageBoost:Number = 10;
		if (player.findPerk(PerkLib.JobBarbarian) >= 0) DwarfRageBoost += 5;
		if (player.findPerk(PerkLib.JobBrawler) >= 0) DwarfRageBoost += 5;
		if (player.findPerk(PerkLib.Berzerker) >= 0) DwarfRageBoost += 5;
		if (player.findPerk(PerkLib.Lustzerker) >= 0) DwarfRageBoost += 5;
	//	DwarfRageBoost += player.tou / 10;player.tou * 0.1 - im wytrzymalesze ciało tym wiekszy bonus może udźwignąć
		outputText("You roar and unleash your dwarf rage in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.DwarfRage, 0, 0, dwarfrageDuration, 0);
		temp = DwarfRageBoost;
		tempStr = temp * 2;
		tempTouSpe = temp;
		player.changeStatusValue(StatusEffects.DwarfRage,1,tempStr);
		player.changeStatusValue(StatusEffects.DwarfRage,2,tempTouSpe);
		mainView.statsView.showStatUp('str');
		mainView.statsView.showStatUp('tou');
		mainView.statsView.showStatUp('spe');
		player.str += player.statusEffectv1(StatusEffects.DwarfRage);
		player.tou += player.statusEffectv2(StatusEffects.DwarfRage);
		player.spe += player.statusEffectv2(StatusEffects.DwarfRage);
		statScreenRefresh();
		enemyAI();
	}

	public function berzerk():void {
		clearOutput();
		if (player.wrath < 50) {
			outputText("Your wrath is too low to enter this state!");
			doNext(msMenu);
			return;
		}
		if (player.hasStatusEffect(StatusEffects.Berzerking)) {
			outputText("You're already pretty goddamn mad!");
			doNext(msMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		player.wrath -= 50;
		var berzerkDuration:Number = 10;
		if (player.findPerk(PerkLib.ColdFury) >= 0) {
			outputText("You roar and unleash your savage fury in order to destroy your foe!\n\n");
		}
		else outputText("You roar and unleash your savage fury, forgetting about defense in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.Berzerking,berzerkDuration,0,0,0);
		enemyAI();
	}

	public function lustzerk():void {
		clearOutput();
		if (player.wrath < 50) {
			outputText("Your wrath is too low to enter this state!");
			doNext(msMenu);
			return;
		}
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) {
			outputText("You're already pretty goddamn mad & lustfull!");
			doNext(msMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		player.wrath -= 50;
		var lustzerkDuration:Number = 10;
		if (player.findPerk(PerkLib.ColdLust) >= 0) {
			outputText("You roar and unleash your lustful fury in order to destroy your foe!\n\n");
		}
		else outputText("You roar and unleash your lustful fury, forgetting about defense from any sexual attacks in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.Lustzerking,lustzerkDuration,0,0,0);
		enemyAI();
	}
	
	public function maleficium():void {
		clearOutput();
		if(player.hasStatusEffect(StatusEffects.Maleficium)) {
			outputText("You already empowered with corrupt power!");
			doNext(msMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		player.lust += 50;
		var maleficiumDuration:Number = 10;
		outputText("You laugh malevolently as your body fills with profane powers empowering your spells but making you blush with barely contained desire.\n\n");
		player.createStatusEffect(StatusEffects.Maleficium,maleficiumDuration,0,0,0);
		enemyAI();
	}
	
	public function infernalflare():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.findPerk(PerkLib.BloodMage) < 0 && player.mana < spellCostWhite(40)) {
			clearOutput();
			outputText("Your mana is too low to cast this.");
			doNext(msMenu);
			return;
		}
		doNext(combatMenu);
		useMana(40,1);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your attack touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your attack!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You grin malevolently and wave an arcane sign, causing infernal fire to surges from below and scorching your opponent \n");
		temp = 0;
		temp += inteligencescalingbonus() * 0.8;
		temp *= spellMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		if (monster.cor >= 66) temp = Math.round(temp * 1.0);
		else if (monster.cor >= 50) temp = Math.round(temp * 1.1);
		else if (monster.cor >= 25) temp = Math.round(temp * 1.2);
		else if (monster.cor >= 10) temp = Math.round(temp * 1.3);
		else temp = Math.round(temp * 1.4);
		//High damage to goes.
		temp = calcInfernoMod(temp);
		if (monster.short == "goo-girl") temp = Math.round(temp * 1.5);
		if (monster.short == "tentacle beast") temp = Math.round(temp * 1.2);
		if (monster.findPerk(PerkLib.IceNature) >= 0) temp *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) temp *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) temp *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) temp *= 0.2;
		if (player.findPerk(PerkLib.FireAffinity) >= 0) temp *= 2;
		temp = Math.round(temp);
		outputText("for <b><font color=\"#800000\">" + temp + "</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			if(monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		checkAchievementDamage(temp);
		flags[kFLAGS.SPELLS_CAST]++;
	//	if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
	//	spellPerkUnlock();
		monster.HP -= temp;
		statScreenRefresh();
		if (monster.HP < 1)
		{
			doNext(endHpVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}

	public function petrify():void {
		clearOutput();
		if(player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(100) > player.maxFatigue()) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		if (monster is LivingStatue) {
			outputText("Your enemy seems to be immune to the petrify immobilizing effect.");
			doNext(msMenu);
			return;
		}
		fatigue(100,1);
		if(monster.plural) {
			outputText("With a moment of concentration you activating petrifying properties of your gaze");
			if (player.hairType == HAIR_GORGON) outputText(" and awaken normaly dormant snake hair that starts to hiss ");
			outputText(" and then casual glance at enemies.  Due to many of them your petrifying power spread on too many targets to be much effective. Still few of them petrified for a short moment and rest scared or suprised by such turn of events also refrain from attacking you for a moment.\n\n");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		else {
			outputText("With a moment of concentration you activating petrifying properties of your gaze");
			if (player.hairType == HAIR_GORGON) outputText(" and awaken normaly dormant snake hair that starts to hiss ");
			outputText(" and then casual glance at enemy.  Caught off guard " + monster.a + monster.short + " petrify.\n\n");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		}
		enemyAI();
	}
	/*
	 //(Basic Fox Fire) do przerobienia na ghost fire dla nekomanty
	 public function foxFire():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
	 clearOutput();
	 if ((player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(60) > player.maxFatigue()) || (player.soulforce < 30 * soulskillCost() * soulskillcostmulti())) {
	 outputText("You lacking enough magical energies to use this ability.", true);
	 doNext(msMenu);
	 return;
	 }
	 if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
	 outputText("You cannot focus to use this ability while you're having so much difficult breathing.", true);
	 doNext(msMenu);
	 return;
	 }
	 var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
	 player.soulforce -= soulforcecost;
	 foxFire2();
	 }
	 public function foxFire2():void {
	 //This is now automatic - newRound arg defaults to true:	menuLoc = 0;
	 fatigue(60, 1);
	 if(monster.hasStatusEffect(StatusEffects.Shell)) {
	 outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
	 enemyAI();
	 return;
	 }
	 //Deals direct damage and lust regardless of enemy defenses.  Especially effective against corrupted targets.
	 outputText("Holding out your palm, you conjure an red flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling red sparks everywhere.  ");
	 var dmg:Number = 0;
	 dmg += inteligencescalingbonus();
	 dmg *= spellMod();
	 //Determine if critical hit!
	 var crit:Boolean = false;
	 var critChance:int = 5;
	 if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
	 if (player.inte <= 100) critChance += (player.inte - 50) / 50;
	 if (player.inte > 100) critChance += 10;
	 }
	 if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
	 if (rand(100) < critChance) {
	 crit = true;
	 dmg *= 1.75;
	 }
	 dmg = calcInfernoMod(dmg);
	 dmg *= 0.25;
	 //Hosohi No Tama bonus dmg
	 //	if (player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) dmg *= 2;
	 //High damage to goes.
	 if(monster.short == "goo-girl") dmg = Math.round(dmg * 1.5);
	 //Using fire attacks on the goo]
	 if(monster.short == "goo-girl") {
	 outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
	 if(monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
	 }
	 if (monster.findPerk(PerkLib.IceNature) >= 0) dmg *= 5;
	 if (monster.findPerk(PerkLib.FireVulnerability) >= 0) dmg *= 2;
	 if (monster.findPerk(PerkLib.IceVulnerability) >= 0) dmg *= 0.5;
	 if (monster.findPerk(PerkLib.FireNature) >= 0) dmg *= 0.2;
	 if (player.findPerk(PerkLib.FireAffinity) >= 0) dmg *= 2;
	 if ((player.tailType != TAIL_TYPE_FOX || (player.tailType == TAIL_TYPE_FOX && player.tailCount < 2)) && (player.findPerk(PerkLib.EnlightenedNinetails) >= 0 || player.findPerk(PerkLib.CorruptedNinetails) >= 0) && player.findPerk(PerkLib.KitsuneThyroidGland) < 0) dmg *= 0.2;
	 if (player.tailCount == 2) dmg *= 0.2;
	 if (player.tailCount == 3) dmg *= 0.4;
	 if (player.tailCount == 4) dmg *= 0.6;
	 if (player.tailCount == 5) dmg *= 0.8;
	 if (player.shieldName == "spirit focus") dmg *= 1.2;
	 if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") dmg *= 1.2;
	 if (player.jewelryName == "fox hairpin") dmg *= 1.2;
	 if (player.findPerk(PerkLib.StarSphereMastery) >= 0) dmg *= (1 + (player.perkv1(PerkLib.StarSphereMastery) * 0.05));
	 dmg = Math.round(dmg);
	 dmg = doDamage(dmg);
	 if (monster.lustVuln == 0) {
	 outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
	 }
	 var lustDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
	 if (monster.lust < (monster.eMaxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) {
	 if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
	 else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
	 }
	 if (monster.lust >= (monster.eMaxLust() * 0.6)) {
	 outputText(monster.capitalA + monster.short + "'");
	 if(!monster.plural) outputText("s");
	 outputText(" eyes glaze over with desire for a moment.  ");
	 }
	 if (monster.cocks.length > 0) {
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
	 }
	 if (monster.vaginas.length > 0) {
	 if (monster.plural) {
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
	 }
	 else {
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
	 }
	 }
	 lustDmg *= 0.25;
	 if (player.shieldName == "spirit focus") lustDmg *= 1.2;
	 if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
	 lustDmg = Math.round(lustDmg);
	 monster.teased(lustDmg);
	 outputText("  <b>(<font color=\"#800000\">" + dmg + "</font>)</b>");
	 if (crit == true) outputText(" <b>*Critical Hit!*</b>");
	 outputText("\n\n");
	 statScreenRefresh();
	 flags[kFLAGS.SPELLS_CAST]++;
	 if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
	 spellPerkUnlock();
	 if(monster.HP > 0 && monster.lust < monster.eMaxLust()) enemyAI();
	 else {
	 if(monster.HP <= 0) doNext(endHpVictory);
	 if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
	 }
	 }
	 */
//Corrupted Fox Fire
	public function corruptedFoxFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if ((player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + (spellCost(100) * kitsuneskillCost()) > player.maxFatigue()) || (player.soulforce < 40 * soulskillCost() * soulskillcostmulti())) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("You cannot focus to use this ability while you're having so much difficult breathing.");
			doNext(msMenu);
			return;
		}
		var soulforcecost:int = 40 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		corruptedFoxFire2();
	}
	public function corruptedFoxFire2():void {
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue((100 * kitsuneskillCost()),1);
		//Deals direct damage and lust regardless of enemy defenses.  Especially effective against non-corrupted targets.
		outputText("Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling lavender sparks everywhere.  ");
		var dmg:Number = 0;
		dmg += inteligencescalingbonus() * 0.5;
		dmg += wisdomscalingbonus() * 0.5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			dmg *= 1.75;
		}
		dmg = calcInfernoMod(dmg);
		dmg *= 0.125;
		if (player.findPerk(PerkLib.CorruptedNinetails) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) dmg *= 0.5;
		var corruptedfoxfiredmgmulti:Number = 1;
		corruptedfoxfiredmgmulti += spellMod() - 1;
		corruptedfoxfiredmgmulti += soulskillMod() - 1;
		if (player.shieldName == "spirit focus") corruptedfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") corruptedfoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") corruptedfoxfiredmgmulti += .2;
		if (player.findPerk(PerkLib.StarSphereMastery) >= 0) corruptedfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0) corruptedfoxfiredmgmulti += .25;
		//Hosohi No Tama bonus dmg
		if (player.findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0) corruptedfoxfiredmgmulti += .5;
		dmg *= corruptedfoxfiredmgmulti;
		if (monster.cor >= 66) dmg = Math.round(dmg * 1.0);
		else if (monster.cor >= 50) dmg = Math.round(dmg * 1.1);
		else if (monster.cor >= 25) dmg = Math.round(dmg * 1.2);
		else if (monster.cor >= 10) dmg = Math.round(dmg * 1.3);
		else dmg = Math.round(dmg * 1.4);
		//High damage to goes.
		if(monster.short == "goo-girl") dmg = Math.round(dmg * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if(monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (monster.findPerk(PerkLib.IceNature) >= 0) dmg *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) dmg *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) dmg *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) dmg *= 0.2;
		if (player.findPerk(PerkLib.FireAffinity) >= 0) dmg *= 2;
		if (player.jewelryName == "fox hairpin") dmg *= 1.2;
		dmg = Math.round(dmg);
		dmg = doDamage(dmg);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + soulskillMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.eMaxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.eMaxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		lustDmg *= 0.5;
		if (player.findPerk(PerkLib.EnlightenedNinetails) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) lustDmg *= 2;
		if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9)  lustDmg *= 1.2;
		if (player.findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText("  <b>(<font color=\"#800000\">" + dmg + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(monster.HP > 0 && monster.lust < monster.eMaxLust()) enemyAI();
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
//Fused Fox Fire
	public function fusedFoxFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if ((player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + (spellCost(250) * kitsuneskillCost()) > player.maxFatigue()) || (player.soulforce < 100 * soulskillCost() * soulskillcostmulti())) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("You cannot focus to use this ability while you're having so much difficult breathing.");
			doNext(msMenu);
			return;
		}
		var soulforcecost:int = 100 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		fusedFoxFire2();
	}
	public function fusedFoxFire2():void {
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue((250 * kitsuneskillCost()),1);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		outputText("Holding out your palms, you conjure an ethereal blue on one palm and corrupted purple flame on other which dances across your fingertips.  After well practised move of fusing them both into one of mixed colors ball of fire you launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling azure and lavender sparks everywhere.  ");
		var dmg:Number = 0;
		dmg += inteligencescalingbonus() * 0.5;
		dmg += wisdomscalingbonus() * 0.5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			dmg *= 1.75;
		}
		dmg = calcInfernoMod(dmg);
		dmg *= 0.5;
		if (player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) dmg *= 2;
		var fusedfoxfiredmgmulti:Number = 1;
		fusedfoxfiredmgmulti += spellMod() - 1;
		fusedfoxfiredmgmulti += soulskillMod() - 1;
		if (player.shieldName == "spirit focus") fusedfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") fusedfoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") fusedfoxfiredmgmulti += .2;
		if (player.findPerk(PerkLib.StarSphereMastery) >= 0) fusedfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0) fusedfoxfiredmgmulti += .5;
		//Hosohi No Tama and Fusion bonus dmg
		if (player.findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0) fusedfoxfiredmgmulti += 1;
		dmg *= fusedfoxfiredmgmulti;
		//High damage to goes.
		if(monster.short == "goo-girl") dmg = Math.round(dmg * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if(monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (monster.findPerk(PerkLib.IceNature) >= 0) dmg *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) dmg *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) dmg *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) dmg *= 0.2;
		if (player.findPerk(PerkLib.FireAffinity) >= 0) dmg *= 2;
		dmg = Math.round(dmg);
		dmg = doDamage(dmg);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + soulskillMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.eMaxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.eMaxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		lustDmg *= 0.5;
		if (player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) lustDmg *= 2.8;
		if (player.findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText("  <b>(<font color=\"#800000\">" + dmg + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(monster.HP > 0 && monster.lust < monster.eMaxLust()) enemyAI();
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
//Pure Fox Fire
	public function pureFoxFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if ((player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + (spellCost(100) * kitsuneskillCost()) > player.maxFatigue()) || (player.soulforce < 40 * soulskillCost() * soulskillcostmulti())) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("You cannot focus to use this ability while you're having so much difficult breathing.");
			doNext(msMenu);
			return;
		}
		var soulforcecost:int = 40 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		pureFoxFire2();
	}
	public function pureFoxFire2():void {
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue((100 * kitsuneskillCost()),1);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		outputText("Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling azure sparks everywhere.  ");
		var dmg:Number = 0;
		dmg += inteligencescalingbonus() * 0.5;
		dmg += wisdomscalingbonus() * 0.5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			dmg *= 1.75;
		}
		dmg = calcInfernoMod(dmg);
		dmg *= 0.5;
		if (player.findPerk(PerkLib.EnlightenedNinetails) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) dmg *= 2;
		var purefoxfiredmgmulti:Number = 1;
		purefoxfiredmgmulti += spellMod() - 1;
		purefoxfiredmgmulti += soulskillMod() - 1;
		if (player.shieldName == "spirit focus") purefoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") purefoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") purefoxfiredmgmulti += .2;
		if (player.findPerk(PerkLib.StarSphereMastery) >= 0) purefoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0) purefoxfiredmgmulti += .25;
		//Hosohi No Tama bonus dmg
		if (player.findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0) purefoxfiredmgmulti += .5;
		dmg *= purefoxfiredmgmulti;
		if (monster.cor < 33) dmg = Math.round(dmg * 1.0);
		else if (monster.cor < 50) dmg = Math.round(dmg * 1.1);
		else if (monster.cor < 75) dmg = Math.round(dmg * 1.2);
		else if (monster.cor < 90) dmg = Math.round(dmg * 1.3);
		else dmg = Math.round(dmg * 1.4); //30% more damage against very high corruption.
		//High damage to goes.
		if(monster.short == "goo-girl") dmg = Math.round(dmg * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if(monster.findPerk(PerkLib.Acid) < 0) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (monster.findPerk(PerkLib.IceNature) >= 0) dmg *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) dmg *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) dmg *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) dmg *= 0.2;
		if (player.findPerk(PerkLib.FireAffinity) >= 0) dmg *= 2;
		dmg = Math.round(dmg);
		dmg = doDamage(dmg);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + soulskillMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.eMaxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.eMaxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		lustDmg *= 0.125;
		if (player.findPerk(PerkLib.EnlightenedNinetails) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) lustDmg *= 0.5;
		if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) lustDmg *= 1.2;
		if (player.findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0 && player.tailType == TAIL_TYPE_FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText("  <b>(<font color=\"#800000\">" + dmg + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(monster.HP > 0 && monster.lust < monster.eMaxLust()) enemyAI();
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}

	public function kitsuneskillCost():Number {
		var modksc:Number = 1;
		if ((player.tailCount == 9 && player.tailType == TAIL_TYPE_FOX) || player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) modksc += 1;
		if (player.tailCount == 9 && player.tailType == TAIL_TYPE_FOX && player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) modksc += 2;
		if (player.tailCount == 9 && player.tailType == TAIL_TYPE_FOX && player.findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0) modksc += 0.5;
		return modksc;
	}

//Terror
	public function kitsuneTerror():void {
		clearOutput();
		//Fatigue Cost: 25
		if(player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + (spellCost(50) * kitsuneskillCost()) > player.maxFatigue() || (player.soulforce < 20 * soulskillCost() * soulskillcostmulti())) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.");
			doNext(msMenu);
			return;
		}
		if(monster.short == "pod" || monster.inte == 0) {
			outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n");
			fatigue(1);
			enemyAI();
			return;
		}
		var soulforcecost:int = 20 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		kitsuneTerror2();
	}
	public function kitsuneTerror2():void {
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.tailCount == 9 && player.tailType == TAIL_TYPE_FOX && player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) {
			player.createStatusEffect(StatusEffects.CooldownTerror, 3, 0, 0, 0);
			fatigue(200,1);
		}
		else if ((player.tailCount == 9 && player.tailType == TAIL_TYPE_FOX) || player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) {
			player.createStatusEffect(StatusEffects.CooldownTerror, 6, 0, 0, 0);
			fatigue(100,1);
		}
		else {
			player.createStatusEffect(StatusEffects.CooldownTerror, 9, 0, 0, 0);
			fatigue(50,1);
		}
		//Inflicts fear and reduces enemy SPD.
		outputText("The world goes dark, an inky shadow blanketing everything in sight as you fill " + monster.a + monster.short + "'s mind with visions of otherworldly terror that defy description.  They cower in horror as they succumb to your illusion, believing themselves beset by eldritch horrors beyond their wildest nightmares.\n\n");
		monster.createStatusEffect(StatusEffects.Fear, 2, 0, 0, 0);
		enemyAI();
	}

//Illusion
	public function kitsuneIllusion():void {
		clearOutput();
		//Fatigue Cost: 25
		if(player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + (spellCost(50) * kitsuneskillCost()) > player.maxFatigue() || (player.soulforce < 20 * soulskillCost() * soulskillcostmulti())) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("You cannot focus to use this ability while you're having so much difficult breathing.");
			doNext(msMenu);
			return;
		}
		if(monster.short == "pod" || monster.inte == 0) {
			outputText("In the tight confines of this pod, there's no use making such an attack!\n\n");
			fatigue(1);
			enemyAI();
			return;
		}
		var soulforcecost:int = 20 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		kitsuneIllusion2();
	}
	public function kitsuneIllusion2():void {
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.tailCount == 9 && player.tailType == TAIL_TYPE_FOX && player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) {
			player.createStatusEffect(StatusEffects.CooldownIllusion,3,0,0,0);
			fatigue(200,1);
		}
		else if ((player.tailCount == 9 && player.tailType == TAIL_TYPE_FOX) || player.findPerk(PerkLib.KitsuneThyroidGland) >= 0) {
			player.createStatusEffect(StatusEffects.CooldownIllusion,6,0,0,0);
			fatigue(100,1);
		}
		else {
			player.createStatusEffect(StatusEffects.CooldownIllusion,9,0,0,0);
			fatigue(50,1);
		}
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Decrease enemy speed and increase their susceptibility to lust attacks if already 110% or more
		outputText("The world begins to twist and distort around you as reality bends to your will, " + monster.a + monster.short + "'s mind blanketed in the thick fog of your illusions.");
		player.createStatusEffect(StatusEffects.Illusion,3,0,0,0);
//	//Check for success rate. Maximum 100% with over 90 Intelligence difference between PC and monster. There are diminishing returns. The more you cast, the harder it is to apply another layer of illusion.
//	if(player.inte/10 + rand(20) > monster.inte/10 + 9 + monster.statusEffectv1(StatusEffects.Illusion) * 2) {
//	//Reduce speed down to -20. Um, are there many monsters with 110% lust vulnerability?
//		outputText("  They stumble humorously to and fro, unable to keep pace with the shifting illusions that cloud their perceptions.\n\n");
//		if (monster.statusEffectv1(StatusEffects.Illusion) > 0) monster.addStatusValue(StatusEffects.Illusion, 1, 1);
//		else monster.createStatusEffect(StatusEffects.Illusion, 1, 0, 0, 0);
//		if (monster.spe >= 0) monster.spe -= (20 - (monster.statusEffectv1(StatusEffects.Illusion) * 5));
//		if (monster.lustVuln >= 1.1) monster.lustVuln += .1;
//		if (monster.spe < 1) monster.spe = 1;
//	}
//	else {
//		outputText("  Like the snapping of a rubber band, reality falls back into its rightful place as they resist your illusory conjurations.\n\n");
//	}
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
		if (monster.lust < (monster.eMaxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.eMaxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if (monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		lustDmg *= 0.1;
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText("\n\n");
		if(monster.lust < monster.eMaxLust()) enemyAI();
		else {
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}

//Transfer
	public function lustTransfer():void {
		clearOutput();
		if(player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(40) > player.maxFatigue()) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		fatigue(40,1);
		var lusttransfered:Number = 0;
		lusttransfered += Math.round(player.lust * 0.15);
		player.lust -= lusttransfered;
		outputText("Your eyes glaze over and you feel your mind suddenly becoming more clear after you transfered some blurs of every sexual perversion you could possibly think of to your enemy");
		if(!monster.plural) outputText(".");
		else outputText("s.");
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			player.lust += lusttransfered;
			enemyAI();
			return;
		}
		if(monster.cocks.length > 0) {
			if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		monster.lust += lusttransfered;
		outputText("\n\n");
		doNext(playerMenu);
		if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		else enemyAI();
		return;
	}

//Fascinate
	public function Fascinate():void {
		clearOutput();
		if(player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(30) > player.maxFatigue()) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if(monster.short == "pod" || monster.inte == 0) {
			outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n");
			fatigue(1);
			enemyAI();
			return;
		}
		if(player.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("You cannot focus to reach the enemy's mind with your charming display while you can't even move.");
			doNext(msMenu);
			return;
		}
		fatigue(30, 1);
		player.createStatusEffect(StatusEffects.CooldownFascinate,4,0,0,0);
		outputText("You start with first pose to attract " + monster.a + monster.short + " attention.  Then you follow with second and then third pose of your enchanting dance.");
		var lustDmg:Number = 5;
		if (player.findPerk(PerkLib.BlackHeart) >= 0) lustDmg += 5;
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			enemyAI();
			return;
		}
		if(monster.lust < (monster.eMaxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if(monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.eMaxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if(monster.cocks.length > 0) {
			if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		monster.teased(lustDmg);
		if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText(" <b>Your erotic show aside slight arousing manages to put " + monster.a + monster.short + " into dazze caused by too strong sexual stimulation!</b> ");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (!monster.hasStatusEffect(StatusEffects.TimesCharmed)) monster.createStatusEffect(StatusEffects.TimesCharmed, player.findPerk(PerkLib.DarkCharm) >= 0 ? 0.5 : 1, 0, 0, 0);
			else monster.addStatusValue(StatusEffects.TimesCharmed, 1, player.findPerk(PerkLib.DarkCharm) >= 0 ? 0.5 : 1);
		}
		outputText("\n\n");
		doNext(playerMenu);
		if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		else enemyAI();
		return;
	}

//Lust strike
	public function LustStrike():void {
		clearOutput();
		if(player.findPerk(PerkLib.BloodMage) < 0 && player.fatigue + spellCost(50) > player.maxFatigue()) {
			outputText("You are too tired to use this ability.");
			doNext(msMenu);
			return;
		}
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("You cannot focus on drawing symbols while you're having so much difficult breathing.");
			doNext(msMenu);
			return;
		}
		fatigue(30,1);
		outputText("You start drawing symbols in the air toward " + monster.a + monster.short + ".");
		var lustDmg:Number = player.lust / 10 + player.lib / 10;
		if (player.findPerk(PerkLib.BlackHeart) >= 0) lustDmg += player.inte / 10;
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			enemyAI();
			return;
		}
		if(monster.lust < (monster.eMaxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if(monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.eMaxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if(monster.cocks.length > 0) {
			if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.eMaxLust() * 0.3) && monster.lust < (monster.eMaxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		monster.teased(lustDmg);
		outputText("\n\n");
		doNext(playerMenu);
		if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		else enemyAI();
		return;
	}
	
	public function possess():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		if(monster.short == "plain girl" || monster.findPerk(PerkLib.Incorporeality) >= 0) {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself toward the opponent's frame.  Sadly, it was doomed to fail, as you bounce right off your foe's ghostly form.");
		}
		else if (monster is LivingStatue)
		{
			outputText("There is nothing to possess inside the golem.");
		}
		//Sample possession text (>79 int, perhaps?):
		else if((!monster.hasCock() && !monster.hasVagina()) || monster.lustVuln == 0 || monster.inte == 0 || monster.inte > 100) {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame.  Unfortunately, it seems ");
			if(monster.inte > 100) outputText("they were FAR more mentally prepared than anything you can handle, and you're summarily thrown out of their body before you're even able to have fun with them.  Darn, you muse.\n\n");
			else outputText("they have a body that's incompatible with any kind of possession.\n\n");
		}
		//Success!
		else if(player.inte >= (monster.inte - 10) + rand(21)) {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent's frame. Before they can regain the initiative, you take control of one of their arms, vigorously masturbating for several seconds before you're finally thrown out. Recorporealizing, you notice your enemy's blush, and know your efforts were somewhat successful.");
			var damage:Number = Math.round(player.inte/5) + rand(player.level) + player.level;
			monster.teased(monster.lustVuln * damage);
			outputText("\n\n");
		}
		//Fail
		else {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame. Unfortunately, it seems they were more mentally prepared than you hoped, and you're summarily thrown out of their body before you're even able to have fun with them. Darn, you muse. Gotta get smarter.\n\n");
		}
		if(!combatRoundOver()) enemyAI();
	}
/*
	public function ElementalAspectAir():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		enemyAI();
	}

	public function ElementalAspectEarth():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		enemyAI();
	}
*/
	public function ElementalAspectFire():void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.CooldownEAspectFire)) {
			outputText("You already used fire elemental aspect in this fight.");
			doNext(specialsElementalAspect);
			return;
		}
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		enemyAI();
	}
/*
	public function ElementalAspectWater():void {
		clearOutput();
		enemyAI();
	}
*/
	public function ElementalAspectIce():void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.CooldownEAspectIce)) {
			outputText("You already used ice elemental aspect in this fight.");
			doNext(specialsElementalAspect);
			return;
		}
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		enemyAI();
	}
/*
	public function ElementalAspectLightning():void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.CooldownEAspectLightning)) {
			outputText("You already used lightning elemental aspect in this fight.");
			doNext(specialsElementalAspect);
			return;
		}
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		enemyAI();
	}

	public function ElementalAspectDarkness():void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.CooldownEAspectDarkness)) {
			outputText("You already used darkness elemental aspect in this fight.");
			doNext(specialsElementalAspect);
			return;
		}
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		enemyAI();
	}
*/
	//Arian's stuff
//Using the Talisman in combat
	public function immolationSpell():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of burning flames gathers around " + monster.a + monster.short + ", slowly burning " + monster.pronoun2 + ".");
		var temp:int = int(100+(player.inte/2 + rand(player.inte)) * spellMod());
		temp = calcInfernoMod(temp);
		if (monster.findPerk(PerkLib.IceNature) >= 0) temp *= 5;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) temp *= 2;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) temp *= 0.5;
		if (monster.findPerk(PerkLib.FireNature) >= 0) temp *= 0.2;
//	if (player.findPerk(PerkLib.FireAffinity) >= 0) temp *= 2;
		temp = Math.round(temp);
		temp = doDamage(temp);
		outputText(" <b>(<font color=\"#800000\">" + temp + "</font>)</b>\n\n");
		player.removeStatusEffect(StatusEffects.ImmolationSpell);
		kGAMECLASS.arianScene.clearTalisman();
		monster.createStatusEffect(StatusEffects.ImmolationDoT,3,0,0,0);
		enemyAI();
	}

	public function shieldingSpell():void {
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A barrier of light engulfs you, before turning completely transparent.  Your defense has been increased.\n\n");
		player.createStatusEffect(StatusEffects.Shielding,0,0,0,0);
		player.removeStatusEffect(StatusEffects.ShieldingSpell);
		kGAMECLASS.arianScene.clearTalisman();
		enemyAI();
	}

	public function iceprisonSpell():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of cold air gathers around " + monster.a + monster.short + ", slowly freezing " + monster.pronoun2 + ".");
		var temp:int = int(100+(player.inte/2 + rand(player.inte)) * spellMod());
		temp = calcGlacialMod(temp);
		if (monster.findPerk(PerkLib.IceNature) >= 0) temp *= 0.2;
		if (monster.findPerk(PerkLib.FireVulnerability) >= 0) temp *= 0.5;
		if (monster.findPerk(PerkLib.IceVulnerability) >= 0) temp *= 2;
		if (monster.findPerk(PerkLib.FireNature) >= 0) temp *= 5;
//	if (player.findPerk(PerkLib.ColdMastery) >= 0) temp *= 2;
//	if (player.findPerk(PerkLib.ColdAffinity) >= 0) temp *= 2;
		temp = Math.round(temp);
		temp = doDamage(temp);
		outputText(" <b>(<font color=\"#800000\">" + temp + "</font>)</b>\n\n");
		player.removeStatusEffect(StatusEffects.IcePrisonSpell);
		kGAMECLASS.arianScene.clearTalisman();
		monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		enemyAI();
	}

}

}
