package classes.Scenes.Combat {
import classes.*;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Dungeons.D3.Doppleganger;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Holli;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.SceneLib;
import classes.StatusEffects.VampireThirstEffect;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class MagicSpecials extends BaseCombatContent {
	public function MagicSpecials() {}
	//------------
	// M. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		if (player.hasPerk(PerkLib.JobSorcerer)) {
			bd = buttons.add("M.Bolt", magicbolt);
			if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") bd.hint("Attempt to attack the enemy with magic bolt from your [weapon].  Damage done is determined by your intelligence and weapon.", "Magic Bolt");
			else bd.hint("Attempt to attack the enemy with magic bolt.  Damage done is determined by your intelligence.", "Magic Bolt");
		}
		if (player.harpyScore() >= 8 || player.sirenScore() >= 10) {
			bd = buttons.add("Compelling Aria", singCompellingAria, "Sing for a moment.");
			bd.requireFatigue(spellCost(50));
			if (player.hasStatusEffect(StatusEffects.CooldownCompellingAria)) {
				bd.disable("<b>You need more time before you can use Compelling Aria again.</b>\n\n");
			}
		}

		if (player.sphinxScore() >= 14) {
			bd = buttons.add("Cursed Riddle", CursedRiddle, "Weave a curse in the form of a magical riddle. If the victims fails to answer it, it will be immediately struck by the curse. Intelligence determines the odds and damage.");
			bd.requireFatigue(spellCost(50));
			if (player.hasStatusEffect(StatusEffects.CooldownCursedRiddle)) {
				bd.disable("<b>You need some time to think of a new riddle.</b>\n\n");
			}
		}

		if (player.hasPerk(PerkLib.Incorporeality)) {
			buttons.add("Possess", possess).hint("Attempt to temporarily possess a foe and force them to raise their own lusts.");
		}
		if (player.raijuScore() >= 7 && player.findPerk(PerkLib.ElectrifiedDesire) >= 0) {
			bd = buttons.add("Orgasmic L.S.", OrgasmicLightningStrike, "Masturbate to unleash a massive discharge.", "Orgasmic Lightning Strike");
		}
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.tailType == Tail.FOX && player.tailCount >= 7) {
			bd = buttons.add("F.FoxFire", fusedFoxFire, "Unleash fused ethereal blue and corrupted purple flame at your opponent for high damage. \n");
			bd.requireSoulforce(100 * soulskillCost() * soulskillcostmulti());
			bd.requireFatigue(spellCost(250) * kitsuneskillCost());
			if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
			}
		}
		if (player.hasPerk(PerkLib.CorruptedKitsune) && player.tailType == Tail.FOX && player.tailCount >= 7) {
			// Corrupt Fox Fire
			bd = buttons.add("C.FoxFire", corruptedFoxFire,"Unleash a corrupted purple flame at your opponent for high damage. Less effective against corrupted enemies. \n");
			bd.requireSoulforce(40*soulskillCost() * soulskillcostmulti());
			bd.requireFatigue(spellCost(100) * kitsuneskillCost(),true);
			if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
			}
			// Terror
			bd = buttons.add("Terror", kitsuneTerror,"Instill fear into your opponent with eldritch horrors. The more you cast this in a battle, the lesser effective it becomes.  ");
			if (player.tailCount == 9 && player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 3 + " rounds\n";
				bd.requireSoulforce(20* soulskillCost() * soulskillcostmulti());
				bd.requireFatigue(200);
			} else if (player.tailCount == 9 || player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 6 + " rounds\n";
				bd.requireSoulforce(20* soulskillCost() * soulskillcostmulti());
				bd.requireFatigue(100);
			} else {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 9 + " rounds\n";
				bd.requireSoulforce(20* soulskillCost() * soulskillcostmulti());
				bd.requireFatigue(50);
			}
			if (player.hasStatusEffect(StatusEffects.CooldownTerror)) {
				bd.disable("<b>You need more time before you can use Terror again.</b>\n\n");
			} else if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.");
			}
		}
		if (player.hasPerk(PerkLib.EnlightenedKitsune) && player.tailType == Tail.FOX && player.tailCount >= 7) {
			// Pure Fox Fire
			bd = buttons.add("P.FoxFire", pureFoxFire, "Unleash an ethereal blue flame at your opponent for high damage. More effective against corrupted enemies. \n");
			bd.requireFatigue(spellCost(100),true);
			bd.requireSoulforce(40 * soulskillCost() * soulskillcostmulti());
			if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
			}
			// Illusion
			bd = buttons.add("Illusion",kitsuneIllusion,"Warp the reality around your opponent to temporary boost your evasion for 3 rounds and arouse target slightly.");
			if (player.tailCount == 9 && player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 3 + " rounds\n";
				bd.requireSoulforce(20* soulskillCost() * soulskillcostmulti());
				bd.requireFatigue(200);
			} else if (player.tailCount == 9 || player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 6 + " rounds\n";
				bd.requireSoulforce(20* soulskillCost() * soulskillcostmulti());
				bd.requireFatigue(100);
			} else {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 9 + " rounds\n";
				bd.requireSoulforce(20* soulskillCost() * soulskillcostmulti());
				bd.requireFatigue(50);
			}
			if (player.hasStatusEffect(StatusEffects.CooldownIllusion)) {
				bd.disable("You need more time before you can use Illusion again.");
			} else if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
			}
		}
	/*	if (player.tailType == CAT && player.tailCount == 2) {
			ui.addMagicButton("FoxFire", foxFire).hint("Unleash a fox flame at your opponent for high damage. \n\nFatigue Cost: " + spellCost(60) + "\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti() + "");
		}	//przerobic potem na ghost fire dla nekomata race special also combining fatigue and soulfroce
	*/
		if (player.hasPerk(PerkLib.DarkCharm)) {
			// Fascinate
			bd = buttons.add("Fascinate",Fascinate, "Put on a sexy display capting the target attention, arrousing it and maybe even stunning for a short moment. \n");
			bd.requireFatigue(spellCost(30), true);
			if (player.hasStatusEffect(StatusEffects.CooldownFascinate)) {
				bd.disable("<b>You need more time before you can use Fascinate again.</b>\n\n");
			} else if(player.hasStatusEffect(StatusEffects.Stunned)) {
				bd.disable("You cannot focus to reach the enemy's mind with your charming display while you can't even move.");
			}
			// Lust Strike
			bd = buttons.add("Lust Strike", LustStrike);
			if (player.hasPerk(PerkLib.BlackHeart)) {
				bd.hint("Use arcane gestures to flare up enemy lust. The higher your libido, intelligence and horny you're at the moment the higher enemy lust will rise. \n");
			} else {
				bd.hint("Use arcane gestures to flare up enemy lust. The higher your libido and horny you're at the moment the higher enemy lust will rise. \n");
				
			}
			bd.requireFatigue(50, true);
			if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus on drawing symbols while you're having so much difficult breathing.");
			}
		}
		if (player.hasPerk(PerkLib.Transference)) {
			bd = buttons.add("Transfer", lustTransfer).hint("Transfer some of your own arousal to your opponent. \n");
			bd.requireFatigue(spellCost(40),true);
		}
		if (player.devilkinScore() >= 10) {
			bd = buttons.add("Infernal flare", infernalflare).hint("Use corrupted flames to burn your opponent. \n");
			bd.requireMana(spellCost(40),true);
		}
		if (player.statusEffectv1(StatusEffects.VampireThirst) >= 20) {
			// Eclipsing shadow
			bd = buttons.add("Eclipsing shadow", EclipsingShadow, "Plunge the area in complete darkness denying vision to your opponent. \n");
			if (player.hasStatusEffect(StatusEffects.CooldownEclipsingShadow)) {
				bd.disable("<b>You need more time before you can use Eclipsing shadow again.</b>\n\n");
			}
			// Sonic scream
			bd = buttons.add("Sonic scream", SonicScream, "Draw on your tainted blood power to unleash a powerful sonic shockwave. \n");
			if (player.hasStatusEffect(StatusEffects.CooldownSonicScream)) {
				bd.disable("<b>You need more time before you can use Sonic scream again.</b>\n\n");
			}
		}
		if (player.hasStatusEffect(StatusEffects.ShieldingSpell)) buttons.add("Shielding", shieldingSpell);
		if (player.hasStatusEffect(StatusEffects.ImmolationSpell)) buttons.add("Immolation", immolationSpell);
		if (player.hasStatusEffect(StatusEffects.IcePrisonSpell)) buttons.add("Ice Prison", iceprisonSpell);
		if (player.hasPerk(PerkLib.DragonFireBreath)) {
			bd = buttons.add("DragonFire", dragonfireBreath).hint("Unleash fire from your mouth. This can only be done once a day. \n", "Dragon Fire Breath");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			}
		}
		if (player.hasPerk(PerkLib.DragonIceBreath)) {
			bd = buttons.add("DragonIce", dragoniceBreath).hint("Unleash ice from your mouth. This can only be done once a day. \n", "Dragon Ice Breath");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			}
		}
		if (player.hasPerk(PerkLib.DragonLightningBreath)) {
			bd = buttons.add("DragonLightning", dragonlightningBreath).hint("Unleash lightning from your mouth. This can only be done once a day. \n", "Dragon Lightning Breath");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			}
		}
		if (player.hasPerk(PerkLib.DragonDarknessBreath)) {
			bd = buttons.add("DragonDarkness", dragondarknessBreath).hint("Unleash dakness from your mouth. This can only be done once a day. \n", "Dragon Darkness Breath");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			}
		}
		if (player.faceType == Face.WOLF && player.hasKeyItem("Fenrir Collar") >= 0) {
			bd = buttons.add("FreezingBreath", fenrirFreezingBreath,"Freeze your foe solid with a powerful breath attack. \n\nWould go into cooldown after use for: 10 rounds  \n<b>AoE attack.</b>");
			bd.requireFatigue(spellCost(150));
			if (player.hasStatusEffect(StatusEffects.CooldownFreezingBreath)) {
				bd.disable("You need more time before you can use Freezing Breath again.");
			}
		}
		if (player.hasPerk(PerkLib.FreezingBreathYeti)) {
			bd = buttons.add("FreezingBreath", yetiFreezingBreath, "Freeze your foe solid with a powerful breath attack. \n\nWould go into cooldown after use for: 10 rounds");
			bd.requireFatigue(spellCost(50));
			if (player.hasStatusEffect(StatusEffects.CooldownFreezingBreathYeti)) {
				bd.disable("You need more time before you can use Freezing Breath again.");
			}
		}
		if (player.hasPerk(PerkLib.FireLord)) {
			bd = buttons.add("Fire Breath",fireballuuuuu).hint("Unleash fire from your mouth. \n", "Fire Breath");
			bd.requireFatigue(20);
		}
		if (player.hasPerk(PerkLib.Hellfire)) {
			bd = buttons.add("Hellfire",hellFire).hint("Unleash fire from your mouth. \n");
			bd.requireFatigue(spellCost(20));
		}
		if (player.hasPerk(PerkLib.PhoenixFireBreath)) {
			bd = buttons.add("PhoenixFire", phoenixfireBreath).hint("Unleash fire from your mouth. \n\nWould go into cooldown after use for: 5 rounds", "Phoenix Fire Breath");
			bd.requireFatigue(spellCost(40));
			if (player.hasStatusEffect(StatusEffects.CooldownPhoenixFireBreath)) {
				bd.disable("You need more time before you can use Phoenix Fire again.");
			}
		}
		if (player.hasPerk(PerkLib.JobWarrior)) {
			bd = buttons.add("DwarfRage", dwarfrage).hint("Throw yourself into a dwarf rage!  Greatly increases your strength, speed and fortitude! \n", "Dwarf Rage");
			bd.requireWrath(50);
			if(player.hasStatusEffect(StatusEffects.DwarfRage)) {
				bd.disable("You already raging!");
			}
		}
		if (player.hasPerk(PerkLib.Berzerker)) {
			bd = buttons.add("Berserk", berzerk);
			if (player.hasPerk(PerkLib.ColdFury)) {
				bd.hint("Throw yourself into a cold rage!  Greatly increases the strength of your weapon and increases lust resistance! \n");
			} else {
				bd.hint("Throw yourself into a rage!  Greatly increases the strength of your weapon and increases lust resistance, but your armor defense is reduced to zero! \n");
			}
			bd.requireWrath(50);
			if (player.hasStatusEffect(StatusEffects.Berzerking)) {
				bd.disable("You're already pretty goddamn mad!");
			}
		}
		if (player.hasPerk(PerkLib.Lustzerker)) {
			bd = buttons.add("Lustserk", lustzerk);
			if (player.hasPerk(PerkLib.ColdLust)) {
				bd.hint("Throw yourself into a cold lust rage!  Greatly increases the strength of your weapon and increases armor defense! \n");
			} else {
				bd.hint("Throw yourself into a lust rage!  Greatly increases the strength of your weapon and increases armor defense, but your lust resistance is reduced to zero! \n")
			}
			bd.requireWrath(50);
			if (player.hasStatusEffect(StatusEffects.Lustzerking)) {
				bd.disable("You're already pretty goddamn mad & lustfull!");
			}
		}
		if (player.hasPerk(PerkLib.JobBeastWarrior)) {
			if (player.hasStatusEffect(StatusEffects.CrinosShape)) {
				buttons.add("Return", returnToNormalShape).hint("Return to normal from Crinos Shape.");
			} else {
				bd = buttons.add("CrinosShape", assumeCrinosShape).hint("Let your wrath flow thou you, transforming you into more bestial shape!  Greatly increases your strength, speed and fortitude! \n\nWrath Cost: " + crinosshapeCost() + " per turn");
				if (player.wrath < crinosshapeCost()) {
					bd.disable("Your wrath is too low to enter this state!");
				}
			}
		}
		if (player.oniScore() >= 12) {
			bd = buttons.add("Oni Rampage", startOniRampage).hint("Increase all damage done by a massive amount but silences you preventing using spells or magical oriented soulskills.");
			bd.requireFatigue(spellCost(50));
			if(player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You already rampaging!");
			}
		}
		if (player.eyes.type == Eyes.GORGON && player.hairType == Hair.GORGON || player.hasPerk(PerkLib.GorgonsEyes)) {
			bd = buttons.add("Petrify", petrify).hint("Use your gaze to temporally turn your enemy into a stone. \n");
			bd.requireFatigue(spellCost(100),true);
			if (monster is LivingStatue) {
				bd.disable("Your enemy seems to be immune to the petrify immobilizing effect.");
			}
		}
		if (player.hasPerk(PerkLib.Whispered)) {
			bd = buttons.add("Whisper", superWhisperAttack).hint("Whisper and induce fear in your opponent. \n");
			bd.requireFatigue(spellCost(10));
			if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.");
			}
		}
		if (player.devilkinScore() >= 10) {
			bd = buttons.add("Maleficium", maleficium).hint("Infuse yourself with corrupt power empowering your magic but reducing your resistance to carnal assault.");
			if(player.hasStatusEffect(StatusEffects.Maleficium)) {
				bd.disable("You already empowered with corrupt power!");
			}
		}
		if (player.cheshireScore() >= 11) {
			bd = buttons.add("Ever&Nowhere", EverywhereAndNowhere).hint("Periodically phase out of reality increasing your invasion as well as granting you the ability to surprise your opponent denying their defences.  \n\nWould go into cooldown after use for: 10 rounds");
			bd.requireFatigue(physicalCost(30));
			if (player.hasStatusEffect(StatusEffects.CooldownEveryAndNowhere)) {
				bd.disable("You need more time before you can use Everywhere and nowhere again.\n\n");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) {
			bd = buttons.add("Air E.Asp", ElementalAspectAir);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectAir)) {
				bd.disable("You already used air elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) {
			bd = buttons.add("Earth E.Asp", ElementalAspectEarth);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectEarth)) {
				bd.disable("You already used earth elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) {
			bd = buttons.add("Fire E.Asp", ElementalAspectFire);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectFire)) {
				bd.disable("You already used fire elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) {
			bd = buttons.add("Water E.Asp", ElementalAspectWater);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectWater)) {
				bd.disable("You already used water elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) {
			bd = buttons.add("Ether E.Asp", ElementalAspectEther);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectEther)) {
				bd.disable("You already used ether elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) {
			bd = buttons.add("Wood E.Asp", ElementalAspectWood);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectWood)) {
				bd.disable("You already used wood elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) {
			bd = buttons.add("Metal E.Asp", ElementalAspectMetal);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectMetal)) {
				bd.disable("You already used metal elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) {
			bd = buttons.add("Ice E.Asp", ElementalAspectIce);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectIce)) {
				bd.disable("You already used ice elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) {
			bd = buttons.add("Lightning E.Asp", ElementalAspectLightning);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectLightning)) {
				bd.disable("You already used lightning elemental aspect in this fight.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) {
			bd = buttons.add("Darkness E.Asp", ElementalAspectDarkness);
			if (player.hasStatusEffect(StatusEffects.CooldownEAspectDarkness)) {
				bd.disable("You already used darkness elemental aspect in this fight.");
			}
		}
		//?lust/corruption?
		
		// JOJO specials - moved from Spells (no longer silenceable)
		if (player.hasPerk(PerkLib.CleansingPalm)) {
			bd = buttons.add("C.Palm", combat.magic.spellCleansingPalm).hint("Unleash the power of your cleansing aura! More effective against corrupted opponents. Doesn't work on the pure.  \n", "Cleansing Palm");
			bd.requireFatigue(spellCost(30),true);
			if (player.cor >= (10 + player.corruptionTolerance())) {
				bd.disable("You are too corrupt to use this ability!");
			}
		}
	}

	//New Abilities and Items
	//[Abilities]
	//Whisper
	public function superWhisperAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
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
		fatigue(10, USEFATG_MAGIC_NOBM);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if(monster.hasPerk(PerkLib.Focused)) {
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
		fatigue(150, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.CooldownFreezingBreath,10,0,0,0);
		var damage:Number = int(player.level * (8 + player.wolfScore()) + rand(60));
		damage = calcGlacialMod(damage);
		if (monster.hasPerk(PerkLib.EnemyGroupType)) damage *= 5;
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
		if (player.hasPerk(PerkLib.ColdMastery)) damage *= 2;
		if (player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
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
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice wave with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own ice wave smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
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
		combat.heroBaneProc(damage);
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
		fatigue(50, USEFATG_MAGIC_NOBM);
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
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
		if (player.hasPerk(PerkLib.ColdMastery)) damage *= 2;
		if (player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
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
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice wave with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own ice wave smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
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
		combat.heroBaneProc(damage);
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
			var lustDmgF:Number = monster.lustVuln * 3 * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.ArcaneLash)) lustDmgF *= 1.5;
			if (monster.hasPerk(PerkLib.EnemyGroupType)) {
				if (player.hasPerk(PerkLib.ArouseTheAudience)) lustDmgF *= 7.5;
				else lustDmgF *= 5;
			}
			lustDmgF = Math.round(lustDmgF);
			monster.teased(lustDmgF);
			if(!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,4,0,0,0);
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
			var lustDmg2:Number = monster.lustVuln * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.ArcaneLash)) lustDmg2 *= 1.5;
			lustDmg2 = Math.round(lustDmg2);
			monster.teased(lustDmg2);
			player.addStatusValue(StatusEffects.ChanneledAttack, 1, 1);
			outputText("\n\n");
			enemyAI();
		}
		else {
			fatigue(50, USEFATG_MAGIC_NOBM);
			clearOutput();
			outputText("You start singing a enrapturing song.");
			var lustDmg:Number = monster.lustVuln * 0.5 * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.ArcaneLash)) lustDmg *= 1.5;
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 1, 0, 0, 0);
			outputText("\n\n");
			enemyAI();
		}
	}
	
	public function OrgasmicLightningStrike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var temp2:Number = 0;
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
			outputText("You achieve a thundering orgasm, lightning surging out of your body as you direct it toward " + monster.a + monster.short + ", gleefully zapping " + monster.pronoun2 + " body with your accumulated lust! Your desire, however, only continue to ramp up.\n\n");
			temp2 = 5 + rand(player.lib / 5 + player.cor / 10);
			dynStats("lus", temp2, "scale", false);
			var lustDmgF:Number = 20 + rand(6);
			var bimbo:Boolean   = false;
			var bro:Boolean     = false;
			var futa:Boolean    = false;
			if (player.findPerk(PerkLib.SensualLover) >= 0) {
				lustDmgF += 2;
			}
			if (player.findPerk(PerkLib.Seduction) >= 0) lustDmgF += 5;
			if (player.findPerk(PerkLib.SluttySeduction) >= 0) lustDmgF += player.perkv1(PerkLib.SluttySeduction);
			if (player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) lustDmgF += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
			if (bimbo || bro || futa) {
				lustDmgF += 5;
			}
			lustDmgF += scalingBonusLibido() * 0.1;
			if (player.findPerk(PerkLib.JobSeducer) >= 0) lustDmgF += player.teaseLevel * 3;
			else lustDmgF += player.teaseLevel * 2;
			if (player.findPerk(PerkLib.JobCourtesan) >= 0 && monster.findPerk(PerkLib.EnemyBossType) >= 0) lustDmgF *= 1.2;
			switch (player.coatType()) {
				case Skin.FUR:
					lustDmgF += (1 + player.newGamePlusMod());
					break;
				case Skin.SCALES:
					lustDmgF += (2 * (1 + player.newGamePlusMod()));
					break;
				case Skin.CHITIN:
					lustDmgF += (3 * (1 + player.newGamePlusMod()));
					break;
				case Skin.BARK:
					lustDmgF += (4 * (1 + player.newGamePlusMod()));
					break;
			}
			if (player.findPerk(PerkLib.SluttySimplicity) >= 0 && player.armorName == "nothing") lustDmgF *= (1 + ((10 + rand(11)) / 100));
			if (player.findPerk(PerkLib.ElectrifiedDesire) >= 0) {
				lustDmgF *= (1 + (player.lust100 * 0.01));
			}
			if (player.findPerk(PerkLib.HistoryWhore) >= 0 || player.findPerk(PerkLib.PastLifeWhore) >= 0) {
				lustDmgF *= 1.15;
			}
			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.findPerk(PerkLib.CriticalPerformance) >= 0) {
				if (player.lib <= 100) critChance += player.lib / 5;
				if (player.lib > 100) critChance += 20;
			}
			if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				lustDmgF *= 1.75;
			}
			if (player.findPerk(PerkLib.ChiReflowLust) >= 0) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
			if (player.findPerk(PerkLib.ArouseTheAudience) >= 0 && player.findPerk(PerkLib.EnemyGroupType) >= 0) lustDmgF *= 1.5;
			lustDmgF = lustDmgF * monster.lustVuln;
			lustDmgF = Math.round(lustDmgF);
			monster.teased(lustDmgF);
			if (crit == true) outputText(" <b>Critical!</b>");
			outputText("\n\n");
			if (monster.findPerk(PerkLib.Resolute) < 0) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			enemyAI();
		}
		else if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You continue masturbating, lost in the sensation as lightning run across your form. You are almost there!\n\n");
			temp2 = 5 + rand(player.lib / 5 + player.cor / 10);
			dynStats("lus", temp2, "scale", false);
			player.addStatusValue(StatusEffects.ChanneledAttack, 1, 1);
			enemyAI();
		}
		else {
			clearOutput();
			outputText("You begin to fiercely masturbate, ");
			if (player.gender == 2) outputText("fingering your [pussy]");
			if (player.gender == 1) outputText("jerking your [cock]");
			if (player.gender == 3) outputText("jerking your [cock] and fingering your [pussy]");
			outputText(". Static electricity starts to build in your body.\n\n");
			temp2 = 5 + rand(player.lib / 5 + player.cor / 10);
			dynStats("lus", temp2, "scale", false);
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 3, 0, 0, 0);
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
			enemyAI();
		}
		else {
			fatigue(50, USEFATG_MAGIC_NOBM);
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
		fatigue(40, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.CooldownPhoenixFireBreath,5,0,0,0);
		var damage:Number = 0;
		damage += 50 + rand(20);
		damage += (player.level * 10);
		damage = calcInfernoMod(damage);
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
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
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
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
				damage = player.takeMagicDamage(damage);
				outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		//Goos burn
		else if(monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5);
			damage = doDamage(damage);
			outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		}
		else {
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		if(!monster.hasPerk(PerkLib.Resolute)) {
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
		combat.heroBaneProc(damage);
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
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonFireBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusIntelligence();// * 0.5
		damage += scalingBonusWisdom();// * 0.5
		damage += rand(player.level + player.dragonScore());
		damage = calcInfernoMod(damage);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
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
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
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
				damage = player.takeMagicDamage(damage);
				outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		//Goos burn
		else if(monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5);
			damage = doDamage(damage);
			monster.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
			outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
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
		combat.heroBaneProc(damage);
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
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonIceBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusIntelligence();// * 0.5
		damage += scalingBonusWisdom();// * 0.5
		damage += rand(player.level + player.dragonScore());
		damage = calcGlacialMod(damage);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
		if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
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
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own ice smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
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
		combat.heroBaneProc(damage);
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
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonLightningBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusIntelligence();// * 0.5
		damage += scalingBonusWisdom();// * 0.5
		damage += rand(player.level + player.dragonScore());
		damage = calcVoltageMod(damage);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 2;
        if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 5;
        if (player.hasPerk(PerkLib.LightningAffinity)) damage *= 2;
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
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
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own lightning with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own lightning smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
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
		combat.heroBaneProc(damage);
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
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonDarknessBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusIntelligence();// * 0.5
		damage += scalingBonusWisdom();// * 0.5
		damage += rand(player.level + player.dragonScore());
		damage = calcEclypseMod(damage);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 5;
//	if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
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
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own darkness with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own darkness smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
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
		combat.heroBaneProc(damage);
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
		fatigue(20);

		//[Failure]
		//(high damage to self, +10 fatigue on top of ability cost)
		if(rand(5) == 0 || player.hasStatusEffect(StatusEffects.WebSilence)) {
			if(player.hasStatusEffect(StatusEffects.WebSilence)) outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, it backs up in your throat, blocked by the webbing across your mouth.  It causes you to cry out as the sudden, heated force explodes in your own throat. ");
			else if(player.hasStatusEffect(StatusEffects.GooArmorSilence)) outputText("You reach for the terrestrial fire but as you ready the torrent, it erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat.  The slime covering your mouth bubbles and pops, boiling away where the escaping flame opens small rents in it.  That wasn't as effective as you'd hoped, but you can at least speak now. ");
			else outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, the fire inside erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat. ");
			fatigue(10);
			player.takeMagicDamage(10 + rand(20), true);
			outputText("\n\n");
			enemyAI();
			return;
		}

		var damage:Number;
		damage = int(player.level * 10 + 45 + rand(10));
		damage = calcInfernoMod(damage);
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
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
			if (SceneLib.isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n");
			else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n");
			enemyAI();
			return;
		}
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ");
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
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
				player.takeMagicDamage(damage);
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
				if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
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
		combat.heroBaneProc(damage);
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
		fatigue(20, USEFATG_MAGIC_NOBM);
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
			else if(monster.lust >= monster.maxLust()) {
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
			if (SceneLib.isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n");
			else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n");
			enemyAI();
			return;
		}
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("  Vala beats her wings with surprising strength, blowing the fireball back at you!  ");
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
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
				if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
				if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
				if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
				if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
				if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
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
		combat.heroBaneProc(damage);
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		if(monster.HP < 1) {
			doNext(endHpVictory);
		}
		else if(monster.lust >= monster.maxLust()) {
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
//	fatigue(40, USEFATG_MAGIC);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic bolt touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		outputText("You narrow your eyes, focusing your mind with deadly intent.  ");
		if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") outputText("You point your staff and shots magic bolt toward " + monster.a + monster.short + "!\n\n");
		else outputText("You point your hand toward " + monster.a + monster.short + " and shots magic bolt!\n\n");
		var damage:Number = player.inte;
		if (player.inte >= 21) damage += ((player.inte - 20) * 0.25);
		if (player.inte >= 41) damage += ((player.inte - 40) * 0.25);
		if (player.inte >= 61) damage += ((player.inte - 60) * 0.25);
		if (player.inte >= 81) damage += ((player.inte - 80) * 0.25);
		if (player.inte >= 101) damage += ((player.inte - 100) * 0.25);
		if (player.inte >= 151) damage += ((player.inte - 150) * 0.25);
		if (player.inte >= 201) damage += ((player.inte - 200) * 0.25);
		if (player.inte >= 251) damage += ((player.inte - 250) * 0.25);
		if (player.inte >= 301) damage += ((player.inte - 300) * 0.25);
		if (player.inte >= 351) damage += ((player.inte - 350) * 0.25);
		if (player.inte >= 401) damage += ((player.inte - 400) * 0.25);
		if (player.inte >= 451) damage += ((player.inte - 450) * 0.25);
		if (player.inte >= 501) damage += ((player.inte - 500) * 0.25);
		if (player.inte >= 551) damage += ((player.inte - 550) * 0.25);
		if (player.inte >= 601) damage += ((player.inte - 600) * 0.25);
		if (player.inte >= 651) damage += ((player.inte - 650) * 0.25);
		if (player.inte >= 701) damage += ((player.inte - 700) * 0.25);
		if (player.inte >= 751) damage += ((player.inte - 750) * 0.25);
		if (player.inte >= 801) damage += ((player.inte - 800) * 0.25);
		if (player.inte >= 851) damage += ((player.inte - 850) * 0.25);
		if (player.inte >= 901) damage += ((player.inte - 900) * 0.25);
		if (player.inte >= 951) damage += ((player.inte - 950) * 0.25);
		if (player.inte >= 1001) damage += ((player.inte - 1000) * 0.25);
		if (player.inte >= 1051) damage += ((player.inte - 1050) * 0.25);
		if (player.inte >= 1101) damage += ((player.inte - 1100) * 0.25);
		if (player.inte >= 1151) damage += ((player.inte - 1150) * 0.25);
		if (player.inte >= 1201) damage += ((player.inte - 1200) * 0.25);
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") {
			if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
			else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
			else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
			else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
			else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + damage + "</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		checkAchievementDamage(damage);
		monster.HP -= damage;
		combat.heroBaneProc(damage);
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
		player.wrath -= 50;
		var temp:Number = 0;
		var tempStr:Number = 0;
		var tempTouSpe:Number = 0;
		var dwarfrageDuration:Number = 10;
		var DwarfRageBoost:Number = 10;
		if (player.hasPerk(PerkLib.JobSwordsman)) DwarfRageBoost += 5;
		if (player.hasPerk(PerkLib.JobBrawler)) DwarfRageBoost += 5;
		if (player.hasPerk(PerkLib.Berzerker)) DwarfRageBoost += 5;
		if (player.hasPerk(PerkLib.Lustzerker)) DwarfRageBoost += 5;
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
		player.wrath -= 50;
		var berzerkDuration:Number = 10;
		if (player.hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved)) berzerkDuration += 2;
		if (player.hasPerk(PerkLib.ColdFury)) {
			outputText("You roar and unleash your savage fury in order to destroy your foe!\n\n");
		}
		else outputText("You roar and unleash your savage fury, forgetting about defense in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.Berzerking,berzerkDuration,0,0,0);
		enemyAI();
	}

	public function lustzerk():void {
		clearOutput();
		player.wrath -= 50;
		var lustzerkDuration:Number = 10;
		if (player.hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved)) lustzerkDuration += 2;
		if (player.hasPerk(PerkLib.ColdLust)) {
			outputText("You roar and unleash your lustful fury in order to destroy your foe!\n\n");
		}
		else outputText("You roar and unleash your lustful fury, forgetting about defense from any sexual attacks in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.Lustzerking,lustzerkDuration,0,0,0);
		enemyAI();
	}
	
	public function crinosshapeCost():Number {
		var modcsc:Number = 5;
		if (player.hasPerk(PerkLib.ImprovedCrinosShape)) modcsc += 5;
		if (player.hasPerk(PerkLib.GreaterCrinosShape)) modcsc += 10;
		if (player.hasPerk(PerkLib.MasterCrinosShape)) modcsc += 20;
		return modcsc;
	}
	public function assumeCrinosShape():void {
		clearOutput();
		player.wrath -= crinosshapeCost();
		var temp1:Number = 0;
		var temp2:Number = 0;
		var temp3:Number = 0;
		var tempStr:Number = 0;
		var tempTou:Number = 0;
		var tempSpe:Number = 0;
		if (player.hasPerk(PerkLib.ImprovedCrinosShape)) {
			if (player.hasPerk(PerkLib.GreaterCrinosShape)) {
				if (player.hasPerk(PerkLib.MasterCrinosShape)) {
					temp1 += player.str * 1.6;
					temp2 += player.tou * 1.6;
					temp3 += player.spe * 1.6;
				}
				else {
					temp1 += player.str * 0.8;
					temp2 += player.tou * 0.8;
					temp3 += player.spe * 0.8;
				}
			}
			else {
				temp1 += player.str * 0.4;
				temp2 += player.tou * 0.4;
				temp3 += player.spe * 0.4;
			}
		}
		else {
			temp1 += player.str * 0.2;
			temp2 += player.tou * 0.2;
			temp3 += player.spe * 0.2;
		}
		temp1 = Math.round(temp1);
		temp2 = Math.round(temp2);
		temp3 = Math.round(temp3);
		outputText("You roar and unleash your inner beast assuming Crinos Shape in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.CrinosShape, 0, 0, 0, 0);
		tempStr = temp1;
		tempTou = temp2;
		tempSpe = temp3;
		player.changeStatusValue(StatusEffects.CrinosShape,1,tempStr);
		player.changeStatusValue(StatusEffects.CrinosShape,2,tempTou);
		player.changeStatusValue(StatusEffects.CrinosShape,3,tempSpe);
		mainView.statsView.showStatUp('str');
		mainView.statsView.showStatUp('tou');
		mainView.statsView.showStatUp('spe');
		player.str += player.statusEffectv1(StatusEffects.CrinosShape);
		player.tou += player.statusEffectv2(StatusEffects.CrinosShape);
		player.spe += player.statusEffectv3(StatusEffects.CrinosShape);
		statScreenRefresh();
		enemyAI();
	}
	public function returnToNormalShape():void {
		clearOutput();
		outputText("Gathering all you willpower you forcefully subduing your inner beast and returning to your normal shape.");
		player.dynStats("str", -player.statusEffectv1(StatusEffects.CrinosShape));
		player.dynStats("tou", -player.statusEffectv2(StatusEffects.CrinosShape));
		player.dynStats("spe", -player.statusEffectv3(StatusEffects.CrinosShape));
		player.removeStatusEffect(StatusEffects.CrinosShape);
		enemyAI();
	}

	public function EverywhereAndNowhere():void {
		clearOutput();
		fatigue(30, USEFATG_PHYSICAL);
		outputText("You smirk as you start to phase in and out of existence. Good luck to whoever going to try and hit you because they will have to try extra hard.\n\n");
		player.createStatusEffect(StatusEffects.EverywhereAndNowhere,6,0,0,0);
		player.createStatusEffect(StatusEffects.CooldownEveryAndNowhere,10,0,0,0);
		enemyAI();
	}
	
	public function maleficium():void {
		clearOutput();
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
		var damage:Number = (scalingBonusIntelligence() * 0.8) * spellMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (monster.cor >= 66) damage = Math.round(damage * 1.0);
		else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
		else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
		else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
		else damage = Math.round(damage * 1.4);
		//High damage to goes.
		damage = calcInfernoMod(damage);
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		damage = Math.round(damage);
		outputText("for <b><font color=\"#800000\">" + damage + "</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
	//	if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
	//	spellPerkUnlock();
		monster.HP -= damage;
		combat.heroBaneProc(damage);
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
		fatigue(100, USEFATG_MAGIC_NOBM);
		if(monster.plural) {
			outputText("With a moment of concentration you activating petrifying properties of your gaze");
			if (player.hairType == Hair.GORGON) outputText(" and awaken normaly dormant snake hair that starts to hiss ");
			outputText(" and then casual glance at enemies.  Due to many of them your petrifying power spread on too many targets to be much effective. Still few of them petrified for a short moment and rest scared or suprised by such turn of events also refrain from attacking you for a moment.\n\n");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		else {
			outputText("With a moment of concentration you activating petrifying properties of your gaze");
			if (player.hairType == Hair.GORGON) outputText(" and awaken normaly dormant snake hair that starts to hiss ");
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
	 if ((!player.hasPerk(PerkLib.BloodMage) && player.fatigue + spellCost(60) > player.maxFatigue()) || (player.soulforce < 30 * soulskillCost() * soulskillcostmulti())) {
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
	 	 fatigue(60, USEFATG_MAGIC);
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
	 if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
	 if (player.inte <= 100) critChance += (player.inte - 50) / 50;
	 if (player.inte > 100) critChance += 10;
	 }
	 if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
	 if (rand(100) < critChance) {
	 crit = true;
	 dmg *= 1.75;
	 }
	 dmg = calcInfernoMod(dmg);
	 dmg *= 0.25;
	 //Hosohi No Tama bonus dmg
	 //	if (player.hasPerk(PerkLib.KitsuneThyroidGland)) dmg *= 2;
	 //High damage to goes.
	 if(monster.short == "goo-girl") dmg = Math.round(dmg * 1.5);
	 //Using fire attacks on the goo]
	 if(monster.short == "goo-girl") {
	 outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
	 if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
	 }
	 if (monster.hasPerk(PerkLib.IceNature)) dmg *= 5;
	 if (monster.hasPerk(PerkLib.FireVulnerability)) dmg *= 2;
	 if (monster.hasPerk(PerkLib.IceVulnerability)) dmg *= 0.5;
	 if (monster.hasPerk(PerkLib.FireNature)) dmg *= 0.2;
	 if (player.hasPerk(PerkLib.FireAffinity)) dmg *= 2;
	 if ((player.tailType != FOX || (player.tailType == FOX && player.tailCount < 2)) && (player.hasPerk(PerkLib.EnlightenedNinetails) || player.hasPerk(PerkLib.CorruptedNinetails)) && !player.hasPerk(PerkLib.KitsuneThyroidGland)) dmg *= 0.2;
	 if (player.tailCount == 2) dmg *= 0.2;
	 if (player.tailCount == 3) dmg *= 0.4;
	 if (player.tailCount == 4) dmg *= 0.6;
	 if (player.tailCount == 5) dmg *= 0.8;
	 if (player.shieldName == "spirit focus") dmg *= 1.2;
	 if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") dmg *= 1.2;
	 if (player.jewelryName == "fox hairpin") dmg *= 1.2;
	 if (player.hasPerk(PerkLib.StarSphereMastery)) dmg *= (1 + (player.perkv1(PerkLib.StarSphereMastery) * 0.05));
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
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
	 }
	 else {
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
	 if (monster.lust >= (monster.eMaxLust() * 0.6) && monster.vaginas[0].vaginalWetness == WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
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
		var soulforcecost:int = 40 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		corruptedFoxFire2();
	}
	public function corruptedFoxFire2():void {
		fatigue((100 * kitsuneskillCost()),USEFATG_MAGIC);
		//Deals direct damage and lust regardless of enemy defenses.  Especially effective against non-corrupted targets.
		outputText("Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling lavender sparks everywhere.  ");
		var damage:Number = (scalingBonusWisdom() * 0.5) + (scalingBonusIntelligence() * 0.5);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = calcInfernoMod(damage);
		damage *= 0.125;
		if (player.hasPerk(PerkLib.CorruptedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) damage *= 0.5;
		var corruptedfoxfiredmgmulti:Number = 1;
		corruptedfoxfiredmgmulti += spellMod() - 1;
		corruptedfoxfiredmgmulti += soulskillMod() - 1;
		if (player.shieldName == "spirit focus") corruptedfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") corruptedfoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") corruptedfoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.StarSphereMastery)) corruptedfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) corruptedfoxfiredmgmulti += .25;
		//Hosohi No Tama bonus damage
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) corruptedfoxfiredmgmulti += .5;
		damage *= corruptedfoxfiredmgmulti;
		if (monster.cor >= 66) damage = Math.round(damage * 1.0);
		else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
		else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
		else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
		else damage = Math.round(damage * 1.4);
		//High damage to goes.
		if(monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		if (player.jewelryName == "fox hairpin") damage *= 1.2;
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + soulskillMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		lustDmg *= 0.5;
		if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 2;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.tailType == Tail.FOX && player.tailCount == 9)  lustDmg *= 1.2;
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText("  <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		if(monster.HP > 0 && monster.lust < monster.maxLust()) enemyAI();
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		}
	}
//Fused Fox Fire
	public function fusedFoxFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 100 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		fusedFoxFire2();
	}
	public function fusedFoxFire2():void {
		fatigue((250 * kitsuneskillCost()),USEFATG_MAGIC);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		outputText("Holding out your palms, you conjure an ethereal blue on one palm and corrupted purple flame on other which dances across your fingertips.  After well practised move of fusing them both into one of mixed colors ball of fire you launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling azure and lavender sparks everywhere.  ");
		var damage:Number = (scalingBonusWisdom() * 0.5) + (scalingBonusIntelligence() * 0.5);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = calcInfernoMod(damage);
		damage *= 0.5;
		if (player.tailType == Tail.FOX && player.tailCount == 9) damage *= 2;
		var fusedfoxfiredmgmulti:Number = 1;
		fusedfoxfiredmgmulti += spellMod() - 1;
		fusedfoxfiredmgmulti += soulskillMod() - 1;
		if (player.shieldName == "spirit focus") fusedfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") fusedfoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") fusedfoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.StarSphereMastery)) fusedfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) fusedfoxfiredmgmulti += .5;
		//Hosohi No Tama and Fusion bonus damage
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) fusedfoxfiredmgmulti += 1;
		damage *= fusedfoxfiredmgmulti;
		//High damage to goes.
		if(monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + soulskillMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		lustDmg *= 0.5;
		if (player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 2.8;
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText("  <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		if(monster.HP > 0 && monster.lust < monster.maxLust()) enemyAI();
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		}
	}
//Pure Fox Fire
	public function pureFoxFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 40 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		pureFoxFire2();
	}
	public function pureFoxFire2():void {
		fatigue((100 * kitsuneskillCost()),USEFATG_MAGIC);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		outputText("Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You launch it at " + monster.a + monster.short + " with a ferocious throw, and it bursts on impact, showering dazzling azure sparks everywhere.  ");
		var damage:Number = (scalingBonusIntelligence() * 0.5) + (scalingBonusWisdom() * 0.5);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = calcInfernoMod(damage);
		damage *= 0.5;
		if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) damage *= 2;
		var purefoxfiredmgmulti:Number = 1;
		purefoxfiredmgmulti += spellMod() - 1;
		purefoxfiredmgmulti += soulskillMod() - 1;
		if (player.shieldName == "spirit focus") purefoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") purefoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") purefoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.StarSphereMastery)) purefoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) purefoxfiredmgmulti += .25;
		//Hosohi No Tama bonus damage
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) purefoxfiredmgmulti += .5;
		damage *= purefoxfiredmgmulti;
		if (monster.cor < 33) damage = Math.round(damage * 1.0);
		else if (monster.cor < 50) damage = Math.round(damage * 1.1);
		else if (monster.cor < 75) damage = Math.round(damage * 1.2);
		else if (monster.cor < 90) damage = Math.round(damage * 1.3);
		else damage = Math.round(damage * 1.4); //30% more damage against very high corruption.
		//High damage to goes.
		if(monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + soulskillMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		lustDmg *= 0.125;
		if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 0.5;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 1.2;
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText("  <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		if(monster.HP > 0 && monster.lust < monster.maxLust()) enemyAI();
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		}
	}

	public function kitsuneskillCost():Number {
		var modksc:Number = 1;
		if ((player.tailCount == 9 && player.tailType == Tail.FOX) || player.hasPerk(PerkLib.KitsuneThyroidGland)) modksc += 1;
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.hasPerk(PerkLib.KitsuneThyroidGland)) modksc += 2;
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) modksc += 0.5;
		return modksc;
	}

//Terror
	public function kitsuneTerror():void {
		clearOutput();
		//Fatigue Cost: 25
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
		var soulforcecost:int = 20 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		kitsuneTerror2();
	}
	public function kitsuneTerror2():void {
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.hasPerk(PerkLib.KitsuneThyroidGland)) {
			player.createStatusEffect(StatusEffects.CooldownTerror, 3, 0, 0, 0);
			fatigue(200, USEFATG_MAGIC_NOBM);
		}
		else if ((player.tailCount == 9 && player.tailType == Tail.FOX) || player.hasPerk(PerkLib.KitsuneThyroidGland)) {
			player.createStatusEffect(StatusEffects.CooldownTerror, 6, 0, 0, 0);
			fatigue(100, USEFATG_MAGIC_NOBM);
		}
		else {
			player.createStatusEffect(StatusEffects.CooldownTerror, 9, 0, 0, 0);
			fatigue(50, USEFATG_MAGIC_NOBM);
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
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.hasPerk(PerkLib.KitsuneThyroidGland)) {
			player.createStatusEffect(StatusEffects.CooldownIllusion,3,0,0,0);
			fatigue(200, USEFATG_MAGIC_NOBM);
		}
		else if ((player.tailCount == 9 && player.tailType == Tail.FOX) || player.hasPerk(PerkLib.KitsuneThyroidGland)) {
			player.createStatusEffect(StatusEffects.CooldownIllusion,6,0,0,0);
			fatigue(100, USEFATG_MAGIC_NOBM);
		}
		else {
			player.createStatusEffect(StatusEffects.CooldownIllusion,9,0,0,0);
			fatigue(50, USEFATG_MAGIC_NOBM);
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
		if (monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if (monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		lustDmg *= 0.1;
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText("\n\n");
		if(monster.lust < monster.maxLust()) enemyAI();
		else {
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		}
	}

	//cursed riddle
	public function CursedRiddle():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownCursedRiddle, 0, 0, 0, 0);
		outputText("You stop fighting for a second and speak aloud a magical riddle.\n\n");
		var chosen:String = randomChoice(
		"\"<i>If you speak my name, you destroy me. Who am I?</i>\"\n\n",
		"\"<i>It belongs to me, but both my friends and enemies use it more than me. What is it?</i>\"\n\n",
		"\"<i>What is the part of the bird that is not in the sky, which can swim in the ocean and always stay dry.</i>\"\n\n",
		"\"<i>What comes once in a minute, twice in a moment, but never in a thousand years?</i>\"\n\n",
		"\"<i>The more you take, the more you leave behind. What am I?</i>\"\n\n",
		"\"<i>I reach for the sky, but clutch to the ground; sometimes I leave, but I am always around. What am I?</i>\"\n\n",
		"\"<i>I am a path situated between high natural masses. Remove my first letter & you have a path situated between man-made masses. What am I?</i>\"\n\n",
		"\"<i>I am two-faced but bear only one, I have no legs but travel widely. Men spill much blood over me, kings leave there imprint on me. I have greatest power when given away, yet lust for me keeps me locked away. What am I?</i>\"\n\n",
		"\"<i>I always follow you around, everywhere you go at night. I look very bright to people, but I can make the sun dark. I can be in many different forms and shapes. What am I?</i>\"\n\n",
		"\"<i>I have hundreds of legs but I can only lean. You make me feel dirty so you feel clean. What am I?</i>\"\n\n",
		"\"<i>My tail is long, my coat is brown, I like the country, I like the town. I can live in a house or live in a shed, and I come out to play when you are in bed. What am I?</i>\"\n\n",
		"\"<i>I welcome the day with a show of light, I steathily came here in the night. I bathe the earthy stuff at dawn, But by the noon, alas! I'm gone. What am I?</i>\"\n\n",
		"\"<i>Which creature in the morning goes on four feet, at noon on two, and in the evening upon three?</i>\"\n\n"
		);
		outputText(chosen);
		outputText("Startled by your query, " + monster.a + monster.short + " gives you a troubled look, everyone knows of the terrifying power of a sphinx riddle used as a curse. You give " + monster.a + monster.short + " some time crossing your forepaws in anticipation. ");

		//odds of success
		var baseInteReq:Number = 200
		var chance:Number = Math.max(player.inte/baseInteReq, 0.05) + 25
		chance = Math.min(chance, 0.80);

		if (Math.random() < chance){
		outputText("\n\n" + monster.a + monster.short + " hazard an answer and your smirk as you respond, “Sadly incorrect!” Your curse smiting your foe for its mistake, leaving it stunned by pain and pleasure.");
		//damage dealth
		var damage:Number = ((scalingBonusWisdom() * 0.5) + scalingBonusIntelligence()) * spellMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");

		//Lust damage dealth
		if (monster.lustVuln > 0) {
			outputText(" ");
			var lustDmg:Number = monster.lustVuln * ((player.inte + (player.wis * 0.50)) / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			monster.teased(lustDmg);
		}
		monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		}
		else {
		outputText("\n\nTo your complete frustration, " + monster.a + monster.short + " answers correctly.");
		outputText("\n\n");
		}
	if(monster.HP < 1) doNext(endHpVictory);
	else enemyAI();
	}

//Transfer
	public function lustTransfer():void {
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
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
			if(monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		monster.lust += lusttransfered;
		outputText("\n\n");
		doNext(playerMenu);
		if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		else enemyAI();
		return;
	}

//Fascinate
	public function Fascinate():void {
		clearOutput();
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
		fatigue(30, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownFascinate,4,0,0,0);
		outputText("You start with first pose to attract " + monster.a + monster.short + " attention.  Then you follow with second and then third pose of your enchanting dance.");
		var lustDmg:Number = 5;
		if (player.hasPerk(PerkLib.BlackHeart)) lustDmg += 5;
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			enemyAI();
			return;
		}
		if(monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if(monster.cocks.length > 0) {
			if(monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		monster.teased(lustDmg);
		if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText(" <b>Your erotic show aside slight arousing manages to put " + monster.a + monster.short + " into dazze caused by too strong sexual stimulation!</b> ");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (!monster.hasStatusEffect(StatusEffects.TimesCharmed)) monster.createStatusEffect(StatusEffects.TimesCharmed, player.hasPerk(PerkLib.DarkCharm) ? 0.5 : 1, 0, 0, 0);
			else monster.addStatusValue(StatusEffects.TimesCharmed, 1, player.hasPerk(PerkLib.DarkCharm) ? 0.5 : 1);
		}
		outputText("\n\n");
		doNext(playerMenu);
		if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		else enemyAI();
		return;
	}

//Lust strike
	public function LustStrike():void {
		clearOutput();
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		fatigue(30, USEFATG_MAGIC_NOBM);
		outputText("You start drawing symbols in the air toward " + monster.a + monster.short + ".");
		var lustDmg:Number = player.lust / 10 + player.lib / 10;
		if (player.hasPerk(PerkLib.BlackHeart)) lustDmg += player.inte / 10;
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			enemyAI();
			return;
		}
		if(monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if(monster.cocks.length > 0) {
			if(monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		monster.teased(lustDmg);
		outputText("\n\n");
		doNext(playerMenu);
		if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		else enemyAI();
		return;
	}
	
	public function possess():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		if(monster.short == "plain girl" || monster.hasPerk(PerkLib.Incorporeality)) {
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
		if(!combatIsOver()) enemyAI();
	}

//Eclipsing shadow
	public function EclipsingShadow():void {
		clearOutput();
		var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		thirst.modSatiety(-20);
		player.createStatusEffect(StatusEffects.CooldownEclipsingShadow,20,0,0,0);
		outputText("You open your wings wide and call upon the power of your tainted blood a pair of black orbs forming at your fingertips. You shatter them on the ground plunging the area in complete darkness and extinguishing all light. While your opponent will be hard pressed to see anything your ability to echolocate allows you to navigate with perfect clarity.");
		monster.createStatusEffect(StatusEffects.Blind, 10, 0, 0, 0);
		enemyAI();
	}

//Sonic scream
	public function SonicScream():void {
		clearOutput();
		var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		thirst.modSatiety(-20);
		player.createStatusEffect(StatusEffects.CooldownSonicScream, 15, 0, 0, 0);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		var damage:Number = 0;
		damage += scalingBonusToughness();
		if (monster.hasPerk(PerkLib.EnemyGroupType)) damage *= 5;
		damage = Math.round(damage);
		monster.HP -= damage;
		outputText("You call on the power of your tainted blood drawing out an almighty scream so strong and sharp it explode from you like a shockwave sending " + monster.a + monster.short + " flying. " + monster.Pronoun1 + " will be shaken from the glass shattering blast for a moment " + damage + " damage.");
		if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
			if (monster.findPerk(PerkLib.Resolute) < 0) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		doNext(playerMenu);
		if (monster.HP <= 0) doNext(endHpVictory);
		else enemyAI();
	}

	public function ElementalAspectAir():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectAir, 0, 0, 0, 0);
		var windwallduration:Number = 0;
		windwallduration += 1;
		if (player.inte >= 20) windwallduration += 1;
		if (player.inte >= 40) windwallduration += 1;
		if (player.inte >= 60) windwallduration += 1;
		if (player.inte >= 80) windwallduration += 1;
		if (player.inte >= 100) windwallduration += Math.round((player.inte - 50) / 50);
		if (player.wis >= 20) windwallduration += 1;
		if (player.wis >= 40) windwallduration += 1;
		if (player.wis >= 60) windwallduration += 1;
		if (player.wis >= 80) windwallduration += 1;
		if (player.wis >= 100) windwallduration += Math.round((player.wis - 50) / 50);
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 1) windwallduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 2) windwallduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 3) windwallduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 4) windwallduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 5) windwallduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 6) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 7) windwallduration += 2;
		player.createStatusEffect(StatusEffects.WindWall, 0, windwallduration, 0, 0);
		outputText("You call on your elemental projecting a air wall between you and " + monster.a + monster.short + " to deflect incoming projectiles.\n\n");
		enemyAI();
	}

	public function ElementalAspectEarth():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectEarth, 0, 0, 0, 0);
		var stoneskinbonus:Number = 0;
		stoneskinbonus += player.inte * 0.1;
		stoneskinbonus += player.wis * 0.1;
		stoneskinbonus = Math.round(stoneskinbonus);
		var stoneskinduration:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 1) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 2) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 3) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 4) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 5) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 6) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 7) stoneskinduration += 2;
		player.createStatusEffect(StatusEffects.StoneSkin, stoneskinbonus, stoneskinduration, 0, 0);
		outputText("Your elemental lifts stone and dirt from the ground, encasing you in a earthen shell stronger than any armor.\n\n");
		enemyAI();
	}

	public function ElementalAspectFire():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		player.createStatusEffect(StatusEffects.CooldownEAspectFire, 0, 0, 0, 0);
		var damage:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 7) damage += scalingBonusIntelligence();
							else damage += scalingBonusIntelligence() * 0.8;
						}
						else damage += scalingBonusIntelligence() * 0.6;
					}
					else damage += scalingBonusIntelligence() * 0.4;
				}
				else damage += scalingBonusIntelligence() * 0.3;
			}
			else damage += scalingBonusIntelligence() * 0.2;
		}
		else damage += scalingBonusIntelligence() * 0.1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 7) damage += scalingBonusWisdom();
							else damage += scalingBonusWisdom() * 0.8;
						}
						else damage += scalingBonusWisdom() * 0.6;
					}
					else damage += scalingBonusWisdom() * 0.4;
				}
				else damage += scalingBonusWisdom() * 0.3;
			}
			else damage += scalingBonusWisdom() * 0.2;
		}
		else damage += scalingBonusWisdom() * 0.1;
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		//crits for elementals specials inclused too? with some perk maybe or just like that same as crit % chance for PC?
		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		damage = doDamage(damage);
		outputText("Your fire elemental douses your opponent with a torrent of fire <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		outputText(" damage.\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectWater():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectWater, 0, 0, 0, 0);
		var temp:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 7) temp += scalingBonusIntelligence();
							else temp += scalingBonusIntelligence() * 0.8;
						}
						else temp += scalingBonusIntelligence() * 0.6;
					}
					else temp += scalingBonusIntelligence() * 0.4;
				}
				else temp += scalingBonusIntelligence() * 0.3;
			}
			else temp += scalingBonusIntelligence() * 0.2;
		}
		else temp += scalingBonusIntelligence() * 0.1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 7) temp += scalingBonusWisdom();
							else temp += scalingBonusWisdom() * 0.8;
						}
						else temp += scalingBonusWisdom() * 0.6;
					}
					else temp += scalingBonusWisdom() * 0.4;
				}
				else temp += scalingBonusWisdom() * 0.3;
			}
			else temp += scalingBonusWisdom() * 0.2;
		}
		else temp += scalingBonusWisdom() * 0.1;
		temp = Math.round(temp);
		outputText("Your elemental encases your body within a bubble of curative spring water, slowly closing your wounds. The bubbles pop leaving you wet, but on the way to full recovery. <b>(<font color=\"#008000\">+" + temp + "</font>)</b>");
		HPChange(temp,false);
		outputText("\n\n");
		enemyAI();
	}

	public function ElementalAspectEther():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		player.createStatusEffect(StatusEffects.CooldownEAspectEther, 0, 0, 0, 0);
		var damage:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 7) damage += scalingBonusIntelligence();
							else damage += scalingBonusIntelligence() * 0.8;
						}
						else damage += scalingBonusIntelligence() * 0.6;
					}
					else damage += scalingBonusIntelligence() * 0.4;
				}
				else damage += scalingBonusIntelligence() * 0.3;
			}
			else damage += scalingBonusIntelligence() * 0.2;
		}
		else damage += scalingBonusIntelligence() * 0.1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 7) damage += scalingBonusWisdom();
							else damage += scalingBonusWisdom() * 0.8;
						}
						else damage += scalingBonusWisdom() * 0.6;
					}
					else damage += scalingBonusWisdom() * 0.4;
				}
				else damage += scalingBonusWisdom() * 0.3;
			}
			else damage += scalingBonusWisdom() * 0.2;
		}
		else damage += scalingBonusWisdom() * 0.1;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 2;
		//crits for elementals specials inclused too? with some perk maybe or just like that same as crit % chance for PC?
		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		damage = doDamage(damage);
		outputText("Your elemental unleash a barrage of star shaped bolts of arcane energy, blasting your opponent. <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectWood():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectWood, 0, 0, 0, 0);
		var barkskinbonus:Number = 0;
		barkskinbonus += player.inte * 0.05;
		barkskinbonus += player.wis * 0.05;
		barkskinbonus = Math.round(barkskinbonus);
		var barkskinduration:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 1) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 2) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 3) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 4) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 5) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 6) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 7) barkskinduration += 2;
		player.createStatusEffect(StatusEffects.BarkSkin, barkskinbonus, barkskinduration, 0, 0);
		var temp:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 7) temp += scalingBonusIntelligence();
							else temp += scalingBonusIntelligence() * 0.4;
						}
						else temp += scalingBonusIntelligence() * 0.3;
					}
					else temp += scalingBonusIntelligence() * 0.2;
				}
				else temp += scalingBonusIntelligence() * 0.15;
			}
			else temp += scalingBonusIntelligence() * 0.1;
		}
		else temp += scalingBonusIntelligence() * 0.05;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 7) temp += scalingBonusWisdom();
							else temp += scalingBonusWisdom() * 0.4;
						}
						else temp += scalingBonusWisdom() * 0.3;
					}
					else temp += scalingBonusWisdom() * 0.2;
				}
				else temp += scalingBonusWisdom() * 0.15;
			}
			else temp += scalingBonusWisdom() * 0.1;
		}
		else temp += scalingBonusWisdom() * 0.05;
		temp = Math.round(temp);
		outputText("Your elemental temporarily covers your skin with bark, shielding you against strikes. This is the bark of medicinal plants and as such you recover from your injuries. <b>(<font color=\"#008000\">+" + temp + "</font>)</b>");
		HPChange(temp,false);
		outputText("\n\n");
		enemyAI();
	}

	public function ElementalAspectMetal():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectMetal, 0, 0, 0, 0);
		var metalskinbonus:Number = 0;
		metalskinbonus += player.inte * 0.1;
		metalskinbonus += player.wis * 0.1;
		metalskinbonus = Math.round(metalskinbonus);
		var metalskinduration:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 1) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 2) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 3) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 4) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 5) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 6) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 7) metalskinduration += 2;
		player.createStatusEffect(StatusEffects.MetalSkin, metalskinbonus, metalskinduration, 0, 0);
		outputText("Your elemental encases your body into a layer of flexible yet solid steel. The metal gives strength to your frame, empowering your unarmed strikes.\n\n");
		enemyAI();
	}

	public function ElementalAspectIce():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		player.createStatusEffect(StatusEffects.CooldownEAspectIce, 0, 0, 0, 0);
		var damage:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 7) damage += scalingBonusIntelligence();
							else damage += scalingBonusIntelligence() * 0.8;
						}
						else damage += scalingBonusIntelligence() * 0.6;
					}
					else damage += scalingBonusIntelligence() * 0.4;
				}
				else damage += scalingBonusIntelligence() * 0.3;
			}
			else damage += scalingBonusIntelligence() * 0.2;
		}
		else damage += scalingBonusIntelligence() * 0.1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 7) damage += scalingBonusWisdom();
							else damage += scalingBonusWisdom() * 0.8;
						}
						else damage += scalingBonusWisdom() * 0.6;
					}
					else damage += scalingBonusWisdom() * 0.4;
				}
				else damage += scalingBonusWisdom() * 0.3;
			}
			else damage += scalingBonusWisdom() * 0.2;
		}
		else damage += scalingBonusWisdom() * 0.1;
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
		if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		damage = doDamage(damage);
		outputText("Your elemental produces a ray of hyper condensed cold and aims it straight at " + monster.a + monster.short + "  <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		outputText(" damage.\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectLightning():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		player.createStatusEffect(StatusEffects.CooldownEAspectLightning, 0, 0, 0, 0);
		var damage:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 7) damage += scalingBonusIntelligence();
							else damage += scalingBonusIntelligence() * 0.8;
						}
						else damage += scalingBonusIntelligence() * 0.6;
					}
					else damage += scalingBonusIntelligence() * 0.4;
				}
				else damage += scalingBonusIntelligence() * 0.3;
			}
			else damage += scalingBonusIntelligence() * 0.2;
		}
		else damage += scalingBonusIntelligence() * 0.1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 7) damage += scalingBonusWisdom();
							else damage += scalingBonusWisdom() * 0.8;
						}
						else damage += scalingBonusWisdom() * 0.6;
					}
					else damage += scalingBonusWisdom() * 0.4;
				}
				else damage += scalingBonusWisdom() * 0.3;
			}
			else damage += scalingBonusWisdom() * 0.2;
		}
		else damage += scalingBonusWisdom() * 0.1;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 5;
		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		damage = doDamage(damage);
		outputText("Your elemental charges electricity, then discharges it with a blinding bolt  <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		outputText(" damage.\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectDarkness():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		player.createStatusEffect(StatusEffects.CooldownEAspectDarkness, 0, 0, 0, 0);
		var damage:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 7) damage += scalingBonusIntelligence();
							else damage += scalingBonusIntelligence() * 0.8;
						}
						else damage += scalingBonusIntelligence() * 0.6;
					}
					else damage += scalingBonusIntelligence() * 0.4;
				}
				else damage += scalingBonusIntelligence() * 0.3;
			}
			else damage += scalingBonusIntelligence() * 0.2;
		}
		else damage += scalingBonusIntelligence() * 0.1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 2) {
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 3) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 4) {
					if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 5) {
						if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 6) {
							if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 7) damage += scalingBonusWisdom();
							else damage += scalingBonusWisdom() * 0.8;
						}
						else damage += scalingBonusWisdom() * 0.6;
					}
					else damage += scalingBonusWisdom() * 0.4;
				}
				else damage += scalingBonusWisdom() * 0.3;
			}
			else damage += scalingBonusWisdom() * 0.2;
		}
		else damage += scalingBonusWisdom() * 0.1;
		if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 5;
		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		damage = doDamage(damage);
		outputText("Your darkness elemental condenses shadows into solid matter, striking your opponent with them doing <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		outputText(" damage.\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	//Arian's stuff
//Using the Talisman in combat
	public function immolationSpell():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of burning flames gathers around " + monster.a + monster.short + ", slowly burning " + monster.pronoun2 + ".");
		var damage:int = int(100+(player.inte/2 + rand(player.inte)) * spellMod());
		damage = calcInfernoMod(damage);
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
//	if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		player.removeStatusEffect(StatusEffects.ImmolationSpell);
		SceneLib.arianScene.clearTalisman();
		monster.createStatusEffect(StatusEffects.ImmolationDoT,3,0,0,0);
		combat.heroBaneProc(damage);
		enemyAI();
	}

	public function shieldingSpell():void {
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A barrier of light engulfs you, before turning completely transparent.  Your defense has been increased.\n\n");
		player.createStatusEffect(StatusEffects.Shielding,0,0,0,0);
		player.removeStatusEffect(StatusEffects.ShieldingSpell);
		SceneLib.arianScene.clearTalisman();
		enemyAI();
	}

	public function iceprisonSpell():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of cold air gathers around " + monster.a + monster.short + ", slowly freezing " + monster.pronoun2 + ".");
		var damage:int = int(100+(player.inte/2 + rand(player.inte)) * spellMod());
		damage = calcGlacialMod(damage);
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
//	if (player.hasPerk(PerkLib.ColdMastery)) damage *= 2;
//	if (player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		player.removeStatusEffect(StatusEffects.IcePrisonSpell);
		SceneLib.arianScene.clearTalisman();
		monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		combat.heroBaneProc(damage);
		enemyAI();
	}

}

}
