package classes.Scenes.Combat {
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.ItemTags;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Areas.Tundra.YoungFrostGiant;
import classes.Scenes.Dungeons.D3.Doppleganger;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.Dungeons.DeepCave.EncapsulationPod;
import classes.Scenes.NPCs.Holli;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.Places.Mindbreaker;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.SceneLib;
import classes.StatusEffects.VampireThirstEffect;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class MagicSpecials extends BaseCombatContent {
	public function MagicSpecials() {}
	internal function applyAutocast2():void {
		outputText("\n\n");
		if ((player.wrath >= 50 || player.hasPerk(PerkLib.EndlessRage)) && (flags[kFLAGS.ZERKER_COMBAT_MODE] == 1 || flags[kFLAGS.ZERKER_COMBAT_MODE] == 3)) {
			var berzerkDuration:Number = 0;
			if (player.hasPerk(PerkLib.EndlessRage)) berzerkDuration += 1;
			else {
				player.wrath -= 50;
				berzerkDuration += 10;
			}
			if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 2) berzerkDuration += 1;
			if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) berzerkDuration += 4;
			player.createStatusEffect(StatusEffects.Berzerking,berzerkDuration,0,0,0);
			outputText("<b>Berzerking was used successfully.</b>\n\n");
		}
		if ((player.wrath >= 50 || player.hasPerk(PerkLib.EndlessRage)) && (flags[kFLAGS.ZERKER_COMBAT_MODE] == 2 || flags[kFLAGS.ZERKER_COMBAT_MODE] == 3)) {
			var lustzerkDuration:Number = 0;
			if (player.hasPerk(PerkLib.EndlessRage)) lustzerkDuration += 1;
			else {
				player.wrath -= 50;
				lustzerkDuration += 10;
			}
			if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 2) lustzerkDuration += 1;
			if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) lustzerkDuration += 4;
			player.createStatusEffect(StatusEffects.Lustzerking,lustzerkDuration,0,0,0);
			outputText("<b>Lustzerking was used successfully.</b>\n\n");
		}
		if (flags[kFLAGS.CRINOS_SHAPE_COMBAT_MODE] == 1 && player.wrath >= crinosshapeCost() && !player.hasPerk(PerkLib.ElementalBody)) {
			outputText("You roar and unleash your inner beast assuming Crinos Shape in order to destroy your foe!\n\n");
			assumeCrinosShape007();
		}
		if (flags[kFLAGS.ASURA_FORM_COMBAT_MODE] == 1 && flags[kFLAGS.CRINOS_SHAPE_COMBAT_MODE] == 0 && player.wrath >= combat.asuraformCost() && !player.hasPerk(PerkLib.ElementalBody)) {
			outputText("As you starts to unleash your inner wrath two additional faces emerge from head"+(player.faceType == Face.CERBERUS?"s":"")+" on sides and " + (player.playerHasFourArms() ? "":"two ") + "additional pair" + (player.playerHasFourArms() ? "":"s") + " of arms grows under your " + (player.playerHasFourArms() ? "second":"first") + " pair" + (player.playerHasFourArms() ? "s":"") + " of arms. ");
			if (player.hasPerk(PerkLib.AsuraStrength)) {
				outputText("Additionaly from your back emerge ");
				outputText("pair");
				outputText(" of semi-transparent arms. ");
			}
			outputText("Finishing assuming Asura form you're ready to destroy anyone that would dare to stand in your way!\n\n");
			combat.assumeAsuraForm007();
		}
		if (flags[kFLAGS.ASURA_FORM_COMBAT_MODE] == 1 && flags[kFLAGS.CRINOS_SHAPE_COMBAT_MODE] == 1) {

		}
		if (player.wrath >= 50 && flags[kFLAGS.WARRIORS_RAGE_COMBAT_MODE] == 1 && !player.statStore.hasBuff("WarriorsRage")) {
			player.wrath -= 50;
			outputText("<b>Warrior's rage was used successfully.</b>\n\n");
			warriorsrage007();
		}
		if (player.hasStatusEffect(StatusEffects.KnowsTyrantState) && flags[kFLAGS.TYRANT_STATE_COMBAT_MODE] == 1) {
			outputText("<b>Tyrant State was used successfully.</b>\n\n");
			player.createStatusEffect(StatusEffects.TyrantState, 0, 0, 0, 0);
		}
	}
	//------------
	// M. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		var isEnemyInvisible:Boolean = combat.isEnemyInvisible;
		var isEnemyInvisibleButNotUnderground:Boolean = combat.isEnemyInvisibleButNotUnderground;
		if (player.isRaceCached(Races.SPHINX)) {
			bd = buttons.add("Cursed Riddle", CursedRiddle, "Weave a curse in the form of a magical riddle. If the victims fails to answer it, it will be immediately struck by the curse. Intelligence determines the odds and damage.");
			bd.requireFatigue(spellCost(50));
			if (player.hasStatusEffect(StatusEffects.CooldownCursedRiddle)) {
				bd.disable("<b>You need some time to think of a new riddle.</b>\n\n");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.isRaceCached(Races.WENDIGO)) {
			bd = buttons.add("Spectral scream", SpectralScream, "Let out a soul-chilling scream to stun your opponent and damage their sanity and soul. \n");
			if (player.hasStatusEffect(StatusEffects.CooldownSpectralScream)) {
				bd.disable("<b>You need more time before you can use Spectral scream again.</b>\n\n");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if ((player.isRaceCached(Races.RAIJU) || (player.isRaceCached(Races.THUNDERBIRD) && player.tailType == Tail.THUNDERBIRD) || player.isRaceCached(Races.KIRIN)) && player.hasPerk(PerkLib.ElectrifiedDesire) >= 0) {
			bd = buttons.add("Orgasmic L.S.", OrgasmicLightningStrike, "Masturbate to unleash a massive discharge.", "Orgasmic Lightning Strike");
			if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			bd = buttons.add("Pleasure bolt", PleasureBolt, "Release a discharge of your lust inducing electricity. It will rise your lust by 2% of max lust after each use.", "Pleasure bolt");
			if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			if ((player.hasVagina() && (player.isRaceCached(Races.COW) || player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 1 || (player.perkv1(IMutationsLib.HumanOvariesIM) >= 3 && player.racialScore(Races.HUMAN) > 17))) ||
			(player.hasCock() && (player.isRaceCached(Races.MINOTAUR) || player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 1 || (player.perkv1(IMutationsLib.HumanTesticlesIM) >= 3 && player.racialScore(Races.HUMAN) > 17)))) {
				bd = buttons.add("Plasma blast", PlasmaBlast, "Masturbate to unleash a massive discharge of milk/cum mixed with plasma.", "Plasma blast");
				if (player.hasStatusEffect(StatusEffects.CooldownPlasmaBlast)) {
					if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3 || player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) bd.disable("\n<b>You need more time before you can do it again.</b>");
					else bd.disable("You can't use it more than once during fight.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.isRaceCached(Races.THUNDERBIRD) && player.isFlying()) {
				// Lust Storm
				bd = buttons.add("Lust storm", Luststorm).hint("Supercharge the air with your lusty electricity to unleash a thunderstorm.");
				if (player.hasStatusEffect(StatusEffects.lustStorm)) bd.disable("<b>You already unleashed a thunderstorm on the battlefield</b>\n\n");
			}
			if (player.isRaceCached(Races.KIRIN)) {
				//Electrify Weapon
				bd = buttons.add("Electrify Weapon", ElectrifyWeapon).hint("Coat your weapon with a sheet of lusty electricity.");
				if (player.hasStatusEffect(StatusEffects.ElectrifyWeapon)) {
					bd.disable("Your weapon is already imbued with lightning!");
				}
			}
		}
		if (!player.hasPerk(PerkLib.ElementalBody)) {
			if ((player.hasPerk(PerkLib.Incorporeality) || player.isRaceCached(Races.WENDIGO))) {
				bd = buttons.add("Possess", possess).hint("Attempt to temporarily possess a foe and force them to raise their own lusts.\nWould go into cooldown after use for: " + (player.hasPerk(PerkLib.NaturalInstincts) ? "1 round" : "2 rounds") + "\n");
				if (player.hasStatusEffect(StatusEffects.CooldownPossess)) {
					bd.disable("<b>You need more time before you can use Possess again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.wings.type == Wings.SEA_DRAGON && player.antennae.type == Antennae.SEA_DRAGON && player.skin.base.pattern == Skin.PATTERN_SEA_DRAGON_UNDERBODY) {
				bd = buttons.add("Electric Discharge", ElectricDischarge, "Release a deadly discharge of electricity.", "Electric discharge");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.TransformationImmunity2) && player.lowerBody == LowerBody.ATLACH_NACHA && !monster.hasStatusEffect(StatusEffects.MysticWeb)) {
				bd = buttons.add("Mystic Web", MysticWeb, "Spin a thread of animated web using your magic to tie up your victim in place. Also reduce opponent speed after each use. \n");
				bd.requireMana(spellCost(50));
				if (player.tailVenom < 25) {
					bd.disable("You do not have enough webbing to shoot right now!");
				} else if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if ((player.tailType == Tail.FOX && player.tailCount >= 2 && player.tailCount < 7) || (player.tailType == Tail.KITSHOO && player.tailCount >= 2)) {
				bd = buttons.add("Fox Fire", basicFoxFire, "Unleash fox flame at your opponent for high damage. \n");
				if (!player.statStore.hasBuff("FoxflamePelt")) {
					bd.requireSoulforce(30 * soulskillCost() * soulskillcostmulti());
					bd.requireMana(spellCost(60 * kitsuneskillCost()));
				}
				if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.tailType == Tail.FOX && player.tailCount >= 7) {
				bd = buttons.add("F.FoxFire", fusedFoxFire, "Unleash fused ethereal blue and corrupted purple flame at your opponent for high damage. \n");
				bd.requireSoulforce(100 * soulskillCost() * soulskillcostmulti());
				bd.requireMana(spellCost(200 * kitsuneskillCost()));
				if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.CorruptedKitsune) && player.tailType == Tail.FOX && player.tailCount >= 7) {
				// Corrupt Fox Fire
				bd = buttons.add("C.FoxFire", corruptedFoxFire, "Unleash a corrupted purple flame at your opponent for high damage. Less effective against corrupted enemies. \n");
				bd.requireSoulforce(40 * soulskillCost() * soulskillcostmulti());
				bd.requireMana(spellCost(80 * kitsuneskillCost()));
				if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				// Terror
				bd = buttons.add("Terror", kitsuneTerror, "Instill fear into your opponent with eldritch horrors. The more you cast this in a battle, the lesser effective it becomes.  ");
				var terror:Number = 9;
				if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) terror -= 1;
				if (player.hasPerk(PerkLib.NaturalInstincts)) terror -= 1;
				if (player.tailCount == 9 && player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) {
					bd.toolTipText += "\nWould go into cooldown after use for: " + (terror - 4) + " rounds\n";
					bd.requireSoulforce(20 * soulskillCost() * soulskillcostmulti());
					bd.requireFatigue(200 * kitsuneskill2Cost());
				} else if (player.tailCount == 9 || player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) {
					bd.toolTipText += "\nWould go into cooldown after use for: " + (terror - 2) + " rounds\n";
					bd.requireSoulforce(20 * soulskillCost() * soulskillcostmulti());
					bd.requireFatigue(100 * kitsuneskill2Cost());
				} else {
					bd.toolTipText += "\nWould go into cooldown after use for: " + terror + " rounds\n";
					bd.requireSoulforce(20 * soulskillCost() * soulskillcostmulti());
					bd.requireFatigue(50 * kitsuneskill2Cost());
				}
				if (player.hasStatusEffect(StatusEffects.CooldownTerror)) {
					bd.disable("<b>You need more time before you can use Terror again.</b>\n\n");
				} else if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.EnlightenedKitsune) && player.tailType == Tail.FOX && player.tailCount >= 7) {
				// Pure Fox Fire
				bd = buttons.add("P.FoxFire", pureFoxFire, "Unleash an ethereal blue flame at your opponent for high damage. More effective against corrupted enemies. \n");
				bd.requireSoulforce(40 * soulskillCost() * soulskillcostmulti());
				bd.requireMana(spellCost(80 * kitsuneskillCost()));
				if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				// Illusion
				bd = buttons.add("Illusion", kitsuneIllusion, "Warp the reality around your opponent to temporary boost your evasion for 3 rounds and arouse target slightly.");
				var illusion:Number = 9;
				if (player.hasPerk(PerkLib.InariBlessedKimono)) illusion -= 1;
				if (player.hasPerk(PerkLib.NaturalInstincts)) illusion -= 1;
				if (player.tailType == 13 && player.tailCount == 9 && player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) {
					bd.toolTipText += "\nWould go into cooldown after use for: " + (illusion - 4) + " rounds\n";
					bd.requireSoulforce(20 * soulskillCost() * soulskillcostmulti());
					bd.requireFatigue(200 * kitsuneskill2Cost());
				} else if ((player.tailType == 13 && player.tailCount == 9) || player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) {
					bd.toolTipText += "\nWould go into cooldown after use for: " + (illusion - 2) + " rounds\n";
					bd.requireSoulforce(20 * soulskillCost() * soulskillcostmulti());
					bd.requireFatigue(100 * kitsuneskill2Cost());
				} else {
					bd.toolTipText += "\nWould go into cooldown after use for: " + illusion + " rounds\n";
					bd.requireSoulforce(20 * soulskillCost() * soulskillcostmulti());
					bd.requireFatigue(50 * kitsuneskill2Cost());
				}
				if (player.hasStatusEffect(StatusEffects.CooldownIllusion)) {
					bd.disable("You need more time before you can use Illusion again.");
				} else if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot focus to use this ability while you're having so much difficulty breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.tailType == Tail.KITSHOO && player.tailCount >= 6) {
				if (player.statStore.hasBuff("FoxflamePelt")) {
					buttons.add("Return", extinguishFoxflamePelt).hint("Release foxflames.");
				} else {
					bd = buttons.add("Foxflame Pelt", lightupFoxflamePelt, "Coat yourself with foxflame pelt. (It would drain soulforce and mana until deactivated)\n");
					bd.requireSoulforce(50 * soulskillCost() * soulskillcostmulti());
					bd.requireMana(spellCost(100 * kitsuneskill2Cost()));
				}
			}
			if ((player.tailType == Tail.NEKOMATA_FORKED_1_3 || player.tailType == Tail.NEKOMATA_FORKED_2_3 || (player.tailType == Tail.CAT && player.tailCount == 2))) {//player.hasPerk(MutationsLib.NekomataThyroidGland) ||
				bd = buttons.add("GhostFire", nekomataGhostFire).hint("Unleash a ghost flame at your opponent for high damage. It's unstoped by barriers that stops magic spells or attacks. \n");
				/*if (player.tailType == 8 && player.tailCount == 2 && player.hasPerk(PerkLib.)) {
                    bd.requireSoulforce(150 * soulskillCost() * soulskillcostmulti());
                    bd.requireMana(spellCost(120));
                } else */
				if (player.tailType == 8 && player.tailCount == 2) {// || player.hasPerk(PerkLib.)
					bd.requireSoulforce(100 * soulskillCost() * soulskillcostmulti());
					bd.requireMana(spellCost(80));
				} else {
					bd.requireSoulforce(50 * soulskillCost() * soulskillcostmulti());
					bd.requireMana(spellCost(40));
				}
				if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				//bd = buttons.add("Puppeteer", nekomataPuppeteer).hint(". \n");
			}	//also combining fatigue and soulfroce
			if (player.rearBody.type == RearBody.TENTACLE_EYESTALKS && player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 2) {
				bd = buttons.add("Chaos beams", ChaosBeams).hint("Unleash a salvo of random eye beams at your opponent. \n", "Chaos beams");
				bd.requireFatigue(spellCost((player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) * 10)));
				//Not Ready Yet:
				if (player.hasStatusEffect(StatusEffects.CooldownChaosBeams)) {
					bd.disable("You need time to gather enough winds to unleash a Chaos beams again.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.eyes.type == Eyes.MONOEYE && !monster.plural) {
				bd = buttons.add("Dominating Gaze", DominatingGaze).hint("Obliterate your foe sense of self with your powerful gaze. \n", "Dominating Gaze");
				bd.requireFatigue(spellCost(50));
				//Not Ready Yet:
				/*if(player.hasStatusEffect(StatusEffects.CooldownWindScythe)) {
                    bd.disable("You need time to gather enough winds to unleash a wind scythe again.");
                } else */
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if ((player.hasPerk(PerkLib.JobBeastWarrior) || player.necklaceName == "Crinos Shape necklace")) {
				if (player.statStore.hasBuff("CrinosShape")) {
					buttons.add("Return", returnToNormalShape).hint("Return to normal from Crinos Shape.");
				} else {
					bd = buttons.add("CrinosShape", assumeCrinosShape).hint("Let your wrath flow thou you, transforming you into more bestial shape!  Greatly increases your strength, speed and fortitude! \n\nWrath Cost: " + crinosshapeCost() + " per turn");
					if (player.wrath < crinosshapeCost()) {
						bd.disable("Your wrath is too low to enter this state!");
					}
					if (player.statStore.hasBuff("AsuraForm")) {// && !player.hasPerk(PerkLib.HiddenJobAsura)
						bd.disable("You are under transformantion effect incompatibile with Crinos Shape!");
					}
				}
			}
			if (player.hasPerk(PerkLib.HiddenJobAsura)) {
				if (player.statStore.hasBuff("AsuraForm")) {
					bd = buttons.add("Return", combat.returnToNormalShape).hint("Return to normal from Asura form.");
					bd = buttons.add("Asura's Howl", combat.asurasHowl).hint("Unleash a howl before giving enemy good punching. \n\nWrath Cost: 50");
					if (player.wrath < 50) {
						bd.disable("Your wrath is too low to unleash howl!");
					}
					if (player.hasPerk(PerkLib.AbsoluteStrength)) {
						if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) bd = buttons.add("TFoD", combat.asuras10FingersOfDestruction).hint("Ten Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
						else if (player.hasPerk(PerkLib.AsuraStrength)) bd = buttons.add("EFoD", combat.asuras8FingersOfDestruction).hint("Eight Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
						else bd = buttons.add("SFoD", combat.asuras6FingersOfDestruction).hint("Six Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
						if (player.wrath < (player.maxWrath() * 0.5)) {
							bd.disable("Your wrath is too low to poke your enemies Asura Style!");
						}
					}
					if (player.hasPerk(PerkLib.AsuraStrength)) {

					}
					if (player.hasPerk(PerkLib.ICastAsuraFist)) {

					}
					if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {

					}
				} else {
					bd = buttons.add("Asura Form", combat.assumeAsuraForm).hint("Let your wrath flow thou you, transforming you into Asura! \n\nWrath Cost: " + combat.asuraformCost() + " per turn");
					if (player.wrath < combat.asuraformCost()) {
						bd.disable("Your wrath is too low to enter this state!");
					}
					if (player.statStore.hasBuff("CrinosShape")) {// && !player.hasPerk(PerkLib.HiddenJobAsura)
						bd.disable("You are under transformantion effect incompatibile with Asura Form!");
					}
				}
			}
			if (player.racialScore(Races.ONI) >= minOniScoreReq()) {
				bd = buttons.add("Oni Rampage", startOniRampage).hint("Increase all damage done by a massive amount but silences you preventing using spells or magical oriented soulskills.");
				bd.requireFatigue(spellCost(50));
				if (player.hasStatusEffect(StatusEffects.OniRampage)) {
					bd.disable("You already rampaging!");
				}
			}
			if (((player.eyes.type == Eyes.GORGON && player.hairType == Hair.GORGON) || player.perkv1(IMutationsLib.GorgonEyesIM) >= 1)) {
				bd = buttons.add("Petrify", curry(petrify, false)).hint("Use your gaze to temporally turn your enemy into a stone. \n");
				bd.requireFatigue(spellCost(100), true);
				if (monster is LivingStatue && player.perkv1(IMutationsLib.GorgonEyesIM) < 3) {
					bd.disable("Your enemy seems to be immune to the petrify immobilizing effect.");
				} else if (isEnemyInvisibleButNotUnderground && player.perkv1(IMutationsLib.GorgonEyesIM) < 3) {
					bd.disable("You cannot use a gaze attack against an opponent you cannot see or target.");
				} else if (isEnemyInvisible && player.hasStatusEffect(StatusEffects.MonsterDig)) {
					bd.disable("You cannot use a gaze attack against an opponent you cannot see or target.");
				}
				if (player.perkv1(IMutationsLib.GorgonEyesIM) >= 4) {
					bd = buttons.add("E. Petrify", curry(petrify, true)).hint("Use your enhanced gaze to temporally turn your enemy into a stone and even halt it recovery temporaly. \n");
					bd.requireFatigue(spellCost(1000), true);
					if (isEnemyInvisible && player.hasStatusEffect(StatusEffects.MonsterDig)) {
						bd.disable("You cannot use a gaze attack against an opponent you cannot see or target.");
					}
				}
			}
			if (player.lowerBody == LowerBody.HYDRA) {
				bd = buttons.add("Hydra acid breath", hydraAcidBreath).hint("Deal acid damage based on natural weapon damage and toughness modifier. Increase by 100% for each head and deals increased damage against groups. Increase damage taken from physical attacks by 10% for each heads for 6 rounds and stun for one round. \n\nWould go into cooldown after use for: " + (player.hasPerk(PerkLib.NaturalInstincts) ? "7" : "8") + " rounds \n");
				if (player.hasStatusEffect(StatusEffects.CooldownHydraAcidBreath)) {
					bd.disable("You need more time before you can use Hydra acid breath again.\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.isNaga() && flags[kFLAGS.SAMIRAH_HYPNOSIS] == 6 && !monster.plural) {
				bd = buttons.add("Tactical Distraction", TacticalDistraction).hint("Make the target lose its current turn forcing it to interrupt whatever it is doing. \n\nWould go into cooldown after use for: " + (player.hasPerk(PerkLib.NaturalInstincts) ? "4" : "5") + " rounds", "Tactical Distraction");
				if (player.hasStatusEffect(StatusEffects.CooldownTDistraction)) {
					bd.disable("You need more time before you can use Tactical Distraction again.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				bd = buttons.add("Hypnosis", NagaHypnosis).hint("Lull your opponent into a trance but only allow a limited set of options.", "Hypnosis");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.racialScore(Races.ARIGEAN) >= 16) {
				bd = buttons.add("Mana Shot", manaShot).hint("Fire a single blast from "+(player.tailCount>1?"one of your extra maws":"your large extra mouth")+". \n");
				bd.requireMana(spellCost(40*arigeanMagicSpecialsCost()), true);
				if (player.hasStatusEffect(StatusEffects.CooldownManaShot)) {
					bd.disable("You need more time before you can use Mana Shot again.\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				bd = buttons.add("Mana Barrage", manaBarrage).hint("Fire a barrage of blasts from your extra maw"+(player.tailCount>1?"s":"")+". \n");
				bd.requireMana(spellCost(200*arigeanMagicSpecialsCost()), true);
				if (player.hasStatusEffect(StatusEffects.CooldownManaBarrage)) {
					bd.disable("You need more time before you can use Mana Barrage again.\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			//Charged Shot & Finality Barrage
			if (player.tailType == Tail.ARIGEAN_PRINCESS) {
				bd = buttons.add("Charged Shot", arigeanChargedShot).hint("Charge and fire a barrage of blasts from your extra maw. \n");
				bd.requireMana(spellCost(400*arigeanMagicSpecialsCost()), true);
				if (player.hasStatusEffect(StatusEffects.CooldownChargedShot)) {
					bd.disable("You need more time before you can use Charged Shot again.\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 4) {
					var amount:Number = 0.6;
					if (player.hasStatusEffect(StatusEffects.DarkRitual)) amount += 0.1;
					bd = buttons.add("Finality Barrage", arigeanFinalityBarrage).hint("Sacrifice 60% of your max hp to deal 30% of the enemy’s max hp. \n");
					if (player.HP - Math.round(player.maxHP() * amount) < player.minHP() + 1) {
						bd.disable("Your HP is too low to use Finality Barrage.\n\n");
					} else if (player.hasStatusEffect(StatusEffects.CooldownFinalityBarrage)) {
						bd.disable("You need more time before you can use Finality Barrage again.\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
			}
		}
		if (player.hasPerk(PerkLib.DarkCharm)) {
			// Fascinate
			bd = buttons.add("Fascinate",Fascinate, "Put on a sexy display capting the target attention, arrousing it and maybe even stunning for a short moment. \n");
			bd.requireFatigue(spellCost(30), true);
			if (player.hasStatusEffect(StatusEffects.CooldownFascinate)) {
				bd.disable("<b>You need more time before you can use Fascinate again.</b>\n\n");
			} else if(player.hasStatusEffect(StatusEffects.Stunned)) {
				bd.disable("You cannot focus to reach the enemy's mind with your charming display while you can't even move.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			// Lust Strike
			bd = buttons.add("Lust Strike", LustStrike);
			var word1:String = player.perkv1(IMutationsLib.BlackHeartIM) >= 1? ", intelligence" : "";
			var word2:String = player.perkv1(IMutationsLib.BlackHeartIM) >= 2? ", wisdom" : "";
			var word3:String = player.perkv1(IMutationsLib.BlackHeartIM) >= 3? ", sensitivity" : "";
			bd.hint("Use arcane gestures to flare up enemy lust. The higher your libido" + word3 + word2 + word1 + " and horny you're at the moment the higher enemy lust will rise. \n");
			bd.requireFatigue(50, true);
			if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus on drawing symbols while you're having so much difficult breathing.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.Transference)) {
			bd = buttons.add("Transfer", lustTransfer).hint("Transfer some of your own arousal to your opponent. \n");
			if (player.hasPerk(PerkLib.GreaterGiftOfLust)) bd.requireFatigue(spellCost(60),true);
			else if (player.hasPerk(PerkLib.GiftOfLust)) bd.requireFatigue(spellCost(30),true);
			else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			else bd.requireFatigue(spellCost(40),true);
		}
		if (player.isRaceCached(Races.AZAZEL) || player.perkv1(IMutationsLib.DiamondHeartIM) >= 1) {
			bd = buttons.add("Exorcism",exorcism).disableIf(player.hasStatusEffect(StatusEffects.Exorcism), "Already used in this fight.").hint("Damage any creature above 25% corruption for 50% of its hit point total. Can be used only once per battle. \n");
			if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 3) bd.requireMana(spellCost(100),true);
			else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			else bd.requireMana(spellCost(80),true);
		}
		if (player.isRaceCached(Races.DEVIL) || player.perkv1(IMutationsLib.ObsidianHeartIM) >= 1) {
			bd = buttons.add("Infernal flare", infernalflare).hint("Use corrupted flames to burn your opponent. \n");
			if (player.perkv1(IMutationsLib.ObsidianHeartIM) >= 3) bd.requireMana(spellCost(50),true);
			else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			else bd.requireMana(spellCost(40),true);
		}
		if (player.isRaceCached(Races.AZAZEL) || player.perkv1(IMutationsLib.DiamondHeartIM) >= 1) {
			bd = buttons.add("JudgementFlare",judgementflare).hint("Unleash a burst of holy fire. \n");
			if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 3) bd.requireMana(spellCost(50),true);
			else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			else bd.requireMana(spellCost(40),true);
		}
		if (player.isRaceCached(Races.HELLCAT)) {
			//Feline Curse
			bd = buttons.add("Feline curse", FelineCurse, "Turn the victim into a small domestic cat for 3 rounds at the cost of arousing yourself. \n");
			if (player.hasStatusEffect(StatusEffects.CooldownFelineCurse)) {
				bd.disable("<b>You need more time before you can use Feline curse again.</b>\n\n");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			//Infernal Claw
			bd = buttons.add("Infernal claw", InfernalClaw, "Enhance your attack with magic then wound an opponent with your claw to inflict damage and status. \n");
			if (player.hasStatusEffect(StatusEffects.CooldownInfernalClaw)) {
				bd.disable("<b>You need more time before you can use Infernal claw again.</b>\n\n");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.statusEffectv1(StatusEffects.VampireThirst) >= 1) {
			//Eclipsing shadow
			bd = buttons.add("Eclipsing shadow", EclipsingShadow, "Plunge the area in complete darkness denying vision to your opponent. \n");
			if (player.hasStatusEffect(StatusEffects.CooldownEclipsingShadow)) {
				bd.disable("<b>You need more time before you can use Eclipsing shadow again.</b>\n\n");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			//Sonic scream
			bd = buttons.add("Sonic scream", SonicScream, "Draw on your tainted blood power to unleash a powerful sonic shockwave. \n");
			if (player.hasStatusEffect(StatusEffects.CooldownSonicScream)) {
				bd.disable("<b>You need more time before you can use Sonic scream again.</b>\n\n");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			//Vampire Thirst Stacks To Health/Mana
			bd = buttons.add("Health Tap (1)", curry(VampireThirstStacksToHealth, 1), "Draw on your tainted blood power to heal yourself. \n");
			if (player.hasStatusEffect(StatusEffects.VampThirstStacksHPMana) && player.statusEffectv1(StatusEffects.VampThirstStacksHPMana) > 0) {
				bd.disable("<b>You can't use Health Tap more than once a turn.</b>\n\n");
			}
			bd = buttons.add("Mana Tap (1)", curry(VampireThirstStacksToMana, 1), "Draw on your tainted blood power to recover some of your magic energies. \n");
			if (player.hasStatusEffect(StatusEffects.VampThirstStacksHPMana) && player.statusEffectv2(StatusEffects.VampThirstStacksHPMana) > 0) {
				bd.disable("<b>You can't use Mana Tap more than once a turn.</b>\n\n");
			}
			if (player.statusEffectv1(StatusEffects.VampireThirst) >= 5) {
				bd = buttons.add("Health Tap (5)", curry(VampireThirstStacksToHealth, 5), "Draw on your tainted blood power to heal yourself. \n");
				if (player.hasStatusEffect(StatusEffects.VampThirstStacksHPMana) && player.statusEffectv1(StatusEffects.VampThirstStacksHPMana) > 0) {
					bd.disable("<b>You can't use Health Tap more than once a turn.</b>\n\n");
				}
				bd = buttons.add("Mana Tap (5)", curry(VampireThirstStacksToMana, 5), "Draw on your tainted blood power to recover some of your magic energies. \n");
				if (player.hasStatusEffect(StatusEffects.VampThirstStacksHPMana) && player.statusEffectv2(StatusEffects.VampThirstStacksHPMana) > 0) {
					bd.disable("<b>You can't use Mana Tap more than once a turn.</b>\n\n");
				}
			}
		}
		if (player.isRaceCached(Races.COUATL) && player.isFlying()) {
			bd = buttons.add("Hurricane", Hurricane).hint("Kickstart a hurricane unleashing violent winds on your opponent. The hurricane intensifies every round and may even stun your victim\n", "Hurricane");
			bd.requireMana(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.CooldownHurricane)) {
				bd.disable("You need time to gather enough winds to empower your Hurricane again.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.isRaceCached(Races.KAMAITACHI) && player.arms.type == Arms.KAMAITACHI) {
			bd = buttons.add("Wind scythe", WindScythe).hint("Create a sharp wave of wind, slashing everything in its path for heavy bleed damage. More powerful against groups. \n", "Wind Scythe");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.CooldownWindScythe)) {
				bd.disable("You need time to gather enough winds to unleash a wind scythe again.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonFireBreath)) {
			bd = buttons.add("Dragon(Fire)", dragonfireBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 1 || player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) {
				bd.hint("Unleash fire from your mouth. This can only be done once per fight. \n", "Dragon Fire Breath");
			} else {
				bd.hint("Unleash fire from your mouth. This can only be done once a day. \n", "Dragon Fire Breath");
			}
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonIceBreath)) {
			bd = buttons.add("Dragon(Ice)", dragoniceBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 1 || player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) {
				bd.hint("Unleash ice from your mouth. This can only be done once per fight. \n", "Dragon Ice Breath");
			} else {
				bd.hint("Unleash ice from your mouth. This can only be done once a day. \n", "Dragon Ice Breath");
			}
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonLightningBreath)) {
			bd = buttons.add("Dragon(Light)", dragonlightningBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 1 || player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) {
				bd.hint("Unleash lightning from your mouth. This can only be done once per fight. \n", "Dragon Lightning Breath");
			} else {
				bd.hint("Unleash lightning from your mouth. This can only be done once a day. \n", "Dragon Lightning Breath");
			}
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonDarknessBreath)) {
			bd = buttons.add("Dragon(Dark)", dragondarknessBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 1 || player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) {
				bd.hint("Unleash darkness from your mouth. This can only be done once per fight. \n", "Dragon Darkness Breath");
			} else {
				bd.hint("Unleash darkness from your mouth. This can only be done once a day. \n", "Dragon Darkness Breath");
			}
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonPoisonBreath)) {
			bd = buttons.add("Dragon(Poison)", dragonpoisonBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 1 || player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) {
				bd.hint("Unleash poison from your mouth. This can only be done once per fight. \n", "Dragon Poison Breath");
			} else {
				bd.hint("Unleash poison from your mouth. This can only be done once a day. \n", "Dragon Poison Breath");
			}
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonPoisonBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonWaterBreath)) {
			bd = buttons.add("Dragon(Water)", dragonWaterBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 1 || player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) {
				bd.hint("Unleash water from your mouth. This can only be done once per fight. Massively increase lightning damage taken by the target. \n", "Dragon Water Breath");
			} else {
				bd.hint("Unleash water from your mouth. This can only be done once a day. Massively increase lightning damage taken by the target. \n", "Dragon Water Breath");
			}
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonWaterBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonFaerieBreath)) {
			bd = buttons.add("Dragon(Faerie)", dragonFaerieBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 1 || player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) {
				bd.hint("Breathe purple flames which deal damage and may randomly afflict the target with a status. This can only be done once per fight. \n", "Dragon Faerie Breath");
			} else {
				bd.hint("Breathe purple flames which deal damage and may randomly afflict the target with a status. This can only be done once a day. \n", "Dragon Faerie Breath");
			}
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonFaerieBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonRegalBreath)) {
			bd = buttons.add("Dragon(Royal)", dragonRoyalBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 1 || player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) {
				bd.hint("Unleash a roar so powerful it creates a shockwave damaging and stunning enemies. Confuse the opponent and bleed them as well. This can only be done once per fight. \n", "Dragon Royal Breath");
			} else {
				bd.hint("Unleash a roar so powerful it creates a shockwave damaging and stunning enemies. Confuse the opponent and bleed them as well. This can only be done once a day. \n", "Dragon Royal Breath");
			}
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonRoyalBreathCooldown)) {
				bd.disable("You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3 || (player.isRaceCached(Races.DRAGON, 2) && player.perkv1(IMutationsLib.DraconicLungIM) >= 1)) {
			bd = buttons.add("TrueDragonBreath", trueDragonBreath);
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) {
				bd.hint("Unleash all four elements fused together from your mouth. This can only be done once per fight. \n", "True Dragon Breath");
			} else {
				bd.hint("Unleash all four elements fused together from your mouth. This can only be done once a day. \n", "True Dragon Breath");
			}
			bd.requireFatigue(spellCost(200));
			//Not Ready Yet:
			if(player.hasStatusEffect(StatusEffects.DragonBreathCooldown)) {
				if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) bd.disable("Your throat is incredibly sore and hoarse. You aren’t sure you can talk let alone try that attack for a while.");
				else bd.disable("Your throat is incredibly sore and hoarse. You aren’t sure you can talk let alone try that attack for more than a day.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.DragonLustPoisonBreath)) {
			bd = buttons.add("Poison Breath", DragonLustPoisonBreath).hint("Unleash a cloud of aphrodisiac poison. Particularly powerful against groups.  \n\nVenom: " + player.tailVenom + "/" + player.maxVenom());
			if (player.tailVenom < player.VenomWebCost() * 5) {
				bd.disable("You do not have enough poison in your glands to breath a cloud right now! (Req. "+player.VenomWebCost()*5+"+)");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.faceType == Face.WOLF && player.hasKeyItem("Gleipnir Collar") >= 0) {
			bd = buttons.add("FreezingBreath", fenrirFreezingBreath,"Freeze your foe solid with a powerful breath attack. \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "9":"10")+" rounds  \n<b>AoE attack.</b>");
			bd.requireFatigue(spellCost(150));
			if (player.hasStatusEffect(StatusEffects.CooldownFreezingBreath)) {
				bd.disable("You need more time before you can use Freezing Breath again.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.FreezingBreathYeti)) {
			bd = buttons.add("FreezingBreath", yetiFreezingBreath, "Freeze your foe solid with a powerful breath attack. \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "9":"10")+" rounds");
			bd.requireFatigue(spellCost(50));
			if (player.hasStatusEffect(StatusEffects.CooldownFreezingBreathYeti)) {
				bd.disable("You need more time before you can use Freezing Breath again.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if ((player.isRaceCached(Races.YUKIONNA) && player.hasPerk(PerkLib.ColdAffinity)) || player.perkv1(IMutationsLib.FrozenHeartIM) >= 1) {
			bd = buttons.add("Ice Barrage", iceBarrage).hint("Call up a frigid storm to freeze and bombard your enemies.", "Ice Barrage");
			bd.requireFatigue(spellCost(40));
			var HCCDv:Number = 10;
			if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 2) HCCDv -= 1;
			if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 3) HCCDv -= 3;
			if (player.hasPerk(PerkLib.NaturalInstincts)) HCCDv -= 1;
			bd = buttons.add("HungeringCold", hungeringCold).hint("Freeze the air around your target, encasing it in ice and dealing hypothermia damage. Weakens opponents ice resistance to further attacks damage by 50% stacking up to 3 times. \n\nWould go into cooldown after use for: " + HCCDv + " rounds", "Hungering cold");
			bd.requireFatigue(spellCost(40));
			if (player.hasStatusEffect(StatusEffects.CooldownHungeringCold)) {
				bd.disable("You need more time before you can use Hungering Cold again.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.isRaceCached(Races.YUKIONNA) && player.hasPerk(PerkLib.ColdAffinity)) {
			bd = buttons.add("Frozen Kiss", frozenKiss).hint("Inflict damage, drain health, stun for 2 rounds and lust out the opponent. Usable only if the victim is humanoid and non giant.", "Frozen Kiss");
			bd.requireFatigue(spellCost(60));
			if (player.hasStatusEffect(StatusEffects.CooldownFrozenKiss)) {
				bd.disable("You need more time before you can use Frozen Kiss again.");

			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.FireLord)) {
			bd = buttons.add("Fire Breath",fireballuuuuu).hint("Unleash fire from your mouth. \n", "Fire Breath");
			bd.requireFatigue(20);
			if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.Hellfire)) {
			if (player.faceType == Face.CERBERUS) {
				bd = buttons.add("Hellfire",hellFire).hint("Unleash fire from your mouths.\n");
				bd.requireFatigue(spellCost(150));
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			else {
				bd = buttons.add("Hellfire",hellFire).hint("Unleash fire from your mouth.\n");
				bd.requireFatigue(spellCost(50));
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
		}
		if (player.hasPerk(PerkLib.PhoenixFireBreath)) {
			bd = buttons.add("PhoenixFire", phoenixfireBreath).hint("Unleash fire from your mouth. \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "4":"5")+" rounds", "Phoenix Fire Breath");
			bd.requireFatigue(spellCost(40));
			if (player.hasStatusEffect(StatusEffects.CooldownPhoenixFireBreath)) {
				bd.disable("You need more time before you can use Phoenix Fire again.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.AcidSpit)) {
			bd = buttons.add("Acid Spit", acidSpit).hint("Spit acid at your opponent corroding his defence and dealing progressive damage.", "Acid Spit");
			bd.requireFatigue(spellCost(40));
			if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.AzureflameBreath)) {
			bd = buttons.add("Azureflame B.", azureflameBreath).hint("Inhale a cone of bluish flames at your opponent. Cause burn.", "Azureflame Breath");
			bd.requireFatigue(spellCost(40));
			if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if ((player.isRaceCached(Races.MOUSE, 2)) || player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring") {
			bd = buttons.add("Blazing battle spirit", blazingBattleSpirit);
			if (player.isRaceCached(Races.MOUSE, 2) && player.jewelryName == "Infernal Mouse ring") {
				bd.hint("Unarmed damage is increased by 150% as fire damage, lust resistance is maximized. Take very highly increased damage from ice attacks. (Cannot be used underwater) \n", "Blazing battle spirit");
			} else {
				bd.hint("Unarmed damage is increased by 100% as fire damage, lust resistance is maximized. Take massively increased damage from ice attacks. (Cannot be used underwater) \n", "Blazing battle spirit");
			}
			if(player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				bd.disable("You already raging!");
			}
			if(player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				bd.disable("You can't use this underwater!");
			}
		}
		if (player.hasPerk(PerkLib.FromTheFrozenWaste)){
			bd = buttons.add("Winter Claws", WinterClaws).hint("Natural weapon damage is increased by 200% as cold damage but take very highly increased damage from fire attacks.");
			if(player.hasStatusEffect(StatusEffects.WinterClaw)) {
				bd.disable("Your natural weapons are already generating cold!");
			}
		}
		if ((player.isRaceCached(Races.MOUSE, 2)) || player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 3) {
			bd = buttons.add("Cauterize", cauterize).hint("Flash burn your wounds to cause them to close. Take damage but recover over time. \n", "Cauterize");
			if(player.hasStatusEffect(StatusEffects.Cauterize)) {
				bd.disable("You already cauterizing your wounds!");
			}
		}
		if ((((player.racialScore(Races.SALAMANDER) >= 12 || player.racialScore(Races.PHOENIX) >= 15) && player.tail.type == Tail.SALAMANDER) || (player.racialScore(Races.KITSHOO) >= 12 && player.tail.type == Tail.KITSHOO)) && (player.isDuelingTypeWeapon() || player.isSwordTypeWeapon() || player.isAxeTypeWeapon() || player.isDaggerTypeWeapon() || player.isScytheTypeWeapon())) {
			bd = buttons.add("Flame Blade", flameBlade).hint("Set your weapon on fire. \n", "Flame Blade");
			if (player.hasStatusEffect(StatusEffects.FlameBlade)) {
				bd.disable("Your weapon is already on fire!");
			}
		}
		if (player.hasPerk(PerkLib.JobWarrior)) {
			bd = buttons.add("WarriorRage", warriorsrage).hint("Throw yourself into a warrior's rage!  Greatly increases your strength, speed and fortitude! \n", "Warrior's Rage");
			bd.requireWrath(50);
			if(player.statStore.hasBuff("WarriorsRage")) {
				bd.disable("You already raging!");
			}
		}
		if (player.hasPerk(PerkLib.Berzerker)) {
			bd = buttons.add("Berserk G1", berzerk);
			if (player.hasPerk(PerkLib.ColderFury)) {
				bd.hint("Throw yourself into a cold(er) rage!  Greatly increases the strength of your weapon and increases lust resistance. \n");
			} else if (player.hasPerk(PerkLib.ColdFury)) {
				bd.hint("Throw yourself into a cold rage!  Greatly increases the strength of your weapon and increases lust resistance, but your magical resistance is reduced to zero! \n");
			} else {
				bd.hint("Throw yourself into a rage!  Greatly increases the strength of your weapon and increases lust resistance, but your armor defense and magical resistance are reduced to zero! \n");
			}
			bd.requireWrath(50);
			if (player.hasStatusEffect(StatusEffects.Berzerking)) {
				bd.disable("You're already pretty goddamn mad!");
			}/*
			if () {
				bd = buttons.add("Berserk G1+2", berzerk);
			}*/
		}
		if (player.hasPerk(PerkLib.PrestigeJobBerserker) && player.hasStatusEffect(StatusEffects.Berzerking)) {
			bd = buttons.add("Berserk G2", berzerkG2);
			if (player.statusEffectv2(StatusEffects.Berzerking) >= 1) {
				bd.disable("You're already reached 2nd grade of Berserk!");
			}
			if (player.statusEffectv2(StatusEffects.Berzerking) >= 1) {
				bd = buttons.add("Berserk G3", berzerkG3);
				if (player.statusEffectv2(StatusEffects.Berzerking) >= 2) {
					bd.disable("You're already reached 3rd grade of Berserk!");
				}
			}
			if (player.hasPerk(PerkLib.EndlessRage) && player.statusEffectv2(StatusEffects.Berzerking) >= 2) {
				bd = buttons.add("Berserk G4", berzerkG4);
				if (player.statusEffectv2(StatusEffects.Berzerking) >= 3) {
					bd.disable("You're already reached 4th grade of Berserk!");
				}
			}
		}
		if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 1 || player.isAnyRaceCached(Races.SHARK, Races.ABYSSAL_SHARK)) {
			bd = buttons.add("Blood Frenzy", bloodFrenzy);
			if (monster.monsterIsBleeding()) {
				bd.hint("Lose yourself to a blood fueled trance increasing your speed, libido and weakening your inteligence. The trance last for as long as the opponent is bleeding and cannot be disangaged willingly.\n");
			}
			else bd.disable("You can't go into a blood frenzy if your opponent is not bleeding.");
			if (player.statStore.hasBuff("Blood Frenzy")) {
				bd.disable("You're already frenzied!");
			}
		}
		if (player.hasPerk(PerkLib.Lustzerker) || player.jewelryName == "Flame Lizard ring" || player.jewelryName2 == "Flame Lizard ring" || player.jewelryName3 == "Flame Lizard ring" || player.jewelryName4 == "Flame Lizard ring") {
			bd = buttons.add("Lustserk G1", lustzerk);
			if (player.hasPerk(PerkLib.ColderLust)) {
				bd.hint("Throw yourself into a cold(er) lust rage!  Greatly increases the strength of your weapon and increases armor defense. \n");
			} else if (player.hasPerk(PerkLib.ColdLust)) {
				bd.hint("Throw yourself into a cold lust rage!  Greatly increases the strength of your weapon and increases armor defense, but your magical resistance is reduced to zero! \n");
			} else {
				bd.hint("Throw yourself into a lust rage!  Greatly increases the strength of your weapon and increases armor defense, but your lust and magical resistances are reduced to zero! \n")
			}
			bd.requireWrath(50);
			if (player.hasStatusEffect(StatusEffects.Lustzerking)) {
				bd.disable("You're already pretty goddamn mad & lustfull!");
			}/*
			if () {
				bd = buttons.add("Lustserk G1+2", lustzerk);
			}*/
		}
		if (player.hasPerk(PerkLib.PrestigeJobBerserker) && player.hasStatusEffect(StatusEffects.Lustzerking)) {
			bd = buttons.add("Lustserk G2", lustzerkG2);
			if (player.statusEffectv2(StatusEffects.Lustzerking) >= 1) {
				bd.disable("You're already reached 2nd grade of Lustserk!");
			}
			if (player.statusEffectv2(StatusEffects.Lustzerking) >= 1) {
				bd = buttons.add("Lustserk G3", lustzerkG3);
				if (player.statusEffectv2(StatusEffects.Lustzerking) >= 2) {
					bd.disable("You're already reached 3rd grade of Lustserk!");
				}
			}
			if (player.hasPerk(PerkLib.EndlessRage) && player.statusEffectv2(StatusEffects.Lustzerking) >= 2) {
				bd = buttons.add("Lustserk G4", lustzerkG4);
				if (player.statusEffectv2(StatusEffects.Lustzerking) >= 3) {
					bd.disable("You're already reached 4th grade of Lustserk!");
				}
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsTyrantState)) {
			var boost:Number = 50;
			if (TyrantiaFollower.TyrantiaTrainingSessions >= 10) boost += 20;
			if (player.hasStatusEffect(StatusEffects.TyrantState)) {
				bd = buttons.add("TyrantState(Off)", deactivaterTyrantState).hint("Deactivate Tyrant State.");
			} else {
				bd = buttons.add("TyrantState(On)", activaterTyrantState).hint("Strain your body to its limit to increase melee damage dealt by "+boost+"% at the cost of getting horny. This also decrease physical resistance.");
			}
			if (TyrantiaFollower.TyrantiaTrainingSessions >= 15) {
				bd = buttons.add("False Weapon", activaterFalseWeapon).hint("Create False weapon based on currently wielded melee weapon to attack each time you attack with it. Deals 20% dmg (Phalluspear False Weapon deals 100%).");
				bd.requireFatigue(physicalCost(100));
				if (player.lust < Math.round(player.maxLust() * 0.1)) {
					bd.disable("Your lust is too low!");
				}
			}
		}
		if (player.hasPerk(PerkLib.Whispered)) {
			bd = buttons.add("Whisper", superWhisperAttack).hint("Whisper and induce fear in your opponent. \n");
			bd.requireFatigue(spellCost(10));
			if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.isRaceCached(Races.DEVIL) || player.perkv1(IMutationsLib.ObsidianHeartIM) >= 1) {
			bd = buttons.add("Maleficium", maleficium).hint("Infuse yourself with corrupt power empowering your magic but reducing your resistance to carnal assault.");
			if(player.hasStatusEffect(StatusEffects.Maleficium)) {
				bd.disable("You already empowered with corrupt power!");
			}
		}
		if (player.isRaceCached(Races.AZAZEL) || player.perkv1(IMutationsLib.DiamondHeartIM) >= 1) {
			bd = buttons.add("PerfectClarity", perfectclarity).hint("Infuse yourself with holy power empowering your magic but reducing your resistance to physical assault.");
			if(player.hasStatusEffect(StatusEffects.PerfectClarity)) {
				bd.disable("You already empowered with holy power!");
			}
		}
		if ((player.isRaceCached(Races.PLANT) || player.isRaceCached(Races.YGGDRASIL) || player.isRaceCached(Races.ALRAUNE) || player.isRaceCached(Races.WOODELF)) && player.hasStatusEffect(StatusEffects.KnowsGreenCovenant)) {
			bd = buttons.add("Green Covenant", greenCovenant).hint("Enforce the full might of your elven pact. Connect with nearby plants gaining high regeneration damage reduction, and empowering elven magic but taking periodic lust damage and reducing evade.");
			bd.requireMana(spellCostWhite(1250));
			if(player.hasStatusEffect(StatusEffects.GreenCovenant)) {
				bd.disable("You already connected with nearby plants!");
			}
			else if(!combat.isNearPlants()) {
				bd.disable("Green Covenant requires having plants nearby.");
			}
			else if(player.hasStatusEffect(StatusEffects.CooldownGreenCovenant)) {
				bd.disable("You need more time before you can use Green Covenant again.");
			}
		}
		if (player.isRaceCached(Races.CHESHIRE)) {
			bd = buttons.add("Ever&Nowhere", EverywhereAndNowhere).hint("Periodically phase out of reality increasing your invasion as well as granting you the ability to surprise your opponent denying their defences.  \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "9":"10")+" rounds");
			bd.requireFatigue(physicalCost(30));
			if (player.hasStatusEffect(StatusEffects.CooldownEveryAndNowhere)) {
				bd.disable("You need more time before you can use Everywhere and nowhere again.\n\n");
			}
		}
		if (player.isRaceCached(Races.FAIRY)) {
			bd = buttons.add("Fae Storm", FaeStorm).hint("Use a beam of chaotic magic, damaging your foe and inflicting various status effects. Single target but very likely to cause a lot of effects.");
			bd.requireMana(spellCost(80));
			bd = buttons.add("Baleful Polymorph", BalefulPolymorph).hint("Turn an opponent into a cute harmless critter.");
			bd.requireMana(spellCost(80));
			if (player.hasStatusEffect(StatusEffects.CooldownBalefulPolymorph)) {
				bd.disable("You need more time before you can use Baleful Polymorph again.\n\n");
			}
		}
		if (player.isRaceCached(Races.FAIRY) || player.isRaceCached(Races.FAERIEDRAGON)) {
			bd = buttons.add("Flicker", Flicker).hint("Vanish out of sight for a short time. \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "3":"4")+" rounds");
			bd.requireMana(spellCost(40));
			if (player.hasStatusEffect(StatusEffects.CooldownFlicker)) {
				bd.disable("You need more time before you can use Flicker again.\n\n");
			}
		}
		if (player.isRaceCached(Races.FAIRY) && !player.hasStatusEffect(StatusEffects.Minimise)) {
			bd = buttons.add("Minimise", Minimise).hint("Shrink to the size of 5 inches, gaining highly increased evasion but reducing melee and ranged damage as well as physical strength.");
			bd.requireMana(spellCost(50));
		}
		if (player.isRaceCached(Races.FAIRY) && player.hasStatusEffect(StatusEffects.Minimise)) {
			bd = buttons.add("Enlarge", Enlarge).hint("Grow back to your normal size.");
			bd.requireMana(spellCost(40));
		}
		if (player.isRaceCached(Races.DISPLACERBEAST)) {
			bd = buttons.add("Displacement", Displacement).hint("Teleport around to avoid your opponents attacks. \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "9":"10")+" rounds");
			bd.requireFatigue(physicalCost(30));
			if (player.hasStatusEffect(StatusEffects.CooldownDisplacement)) {
				bd.disable("You need more time before you can use Displacement again.\n\n");
			}
		}
		if (player.isRaceCached(Races.RACCOON, 2) || player.perkv1(IMutationsLib.NukiNutsIM) >= 1) {
			if (!monster.plural) {
				bd = buttons.add("Prank", Prank).hint("Distract the enemy for 1 round interupting its action. \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "4":"5")+" rounds", "Prank");
				if (player.hasStatusEffect(StatusEffects.CooldownPrank)) {
					bd.disable("You need more time before you can prank your opponent again.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			bd = buttons.add("Money Strike", MoneyStrike).hint("Attack your opponent using magically enhanced money. Damage is based on personal wealth. Cost some gems upon use.", "Money Strike");
			bd.requireFatigue(spellCost(40),true);
			if (player.gems < 100) bd.disable("You need more gems in order to use Money Strike.");
			else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.isRaceCached(Races.RATATOSKR)) {
			var cdko:Number = 12;
			if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 2) cdko -= 1;
			if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) cdko -= 1;
			if (player.hasPerk(PerkLib.NaturalInstincts)) cdko -= 1;
			bd = buttons.add("Knowledge overload", KnowledgeOverload).hint("Stun your opponents by overflowing their head with knowledge. \n\nWould go into cooldown after use for: "+cdko+" rounds", "Knowledge overload");
			bd.requireMana(spellCost(80));
			if (player.hasStatusEffect(StatusEffects.CooldownKnowledgeOverload)) {
				bd.disable("You need more time before you can use Knowledge overload again.\n\n");
			}
			var cdp:Number = 6;
			if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) cdp -= 1;
			if (player.hasPerk(PerkLib.NaturalInstincts)) cdp -= 1;
			bd = buttons.add("Provoke", Provoke).hint("Insult your opponent and cause it to fly into a murderous rage increasing its damage but negating its defences and ability to do anything but attack blindly with physical strikes. \n\nWould go into cooldown after use for: "+cdp+" rounds", "Provoke");
			bd.requireMana(spellCost(80));
			if (player.hasStatusEffect(StatusEffects.CooldownProvoke)) {
				bd.disable("You need more time before you can use Provoke again.\n\n");
			}
		}
		if (player.isRaceCached(Races.RATATOSKR) || player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 1) {
			var cdww:Number = 4;
			if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) cdww -= 1;
			if (player.hasPerk(PerkLib.NaturalInstincts)) cdww -= 1;
			bd = buttons.add("Weird words", WeirdWords).hint("Strike at your opponent with weird sentences charged with magic, so hard to comprehend it hurts. More potent based on your personal knowledge. \n\nWould go into cooldown after use for: "+cdww+" rounds", "Weird words");
			bd.requireMana(spellCost(80));
			if (player.hasStatusEffect(StatusEffects.CooldownWeirdWords)) {
				bd.disable("You need more time before you can use Weird words again.\n\n");
			}
		}
		if (player.isRaceCached(Races.SLIME) || player.isRaceCached(Races.MAGMASLIME) || player.isRaceCached(Races.DARKSLIME)) {
			bd = buttons.add("Slime Bolt", SlimeBolt).hint("Summon a huge slimy projectile and toss it at your opponent causing serious lust and physical damage, reducing speed.\n\nMana Cost: " + spellCostWhite(50) + "");
			if (player.mana < spellCost(50)) {
				bd.disable("Your mana is too low to toss slime bolt.");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (Mindbreaker.MindBreakerQuest == Mindbreaker.QUEST_STAGE_ISMB){
			bd = buttons.add("Mind Thrust", mindThrust).hint("Use your psychic powers to strike at the opponent’s mind dealing severe physical damage.\n\nMana Cost: " + spellCostWhite(100) + "");
			if (player.mana < spellCost(100)) {
				bd.disable("Your mana is too low to use mind thrust.");
			}
			bd = buttons.add("Mind Blast", mindBlast).hint("Overload an opponent’s mind with lewd information, stunning it.\n\nMana Cost: " + spellCostWhite(100) + "");
			if (player.mana < spellCost(50)) {
				bd.disable("Your mana is too low to use mind blast.");
			}
			if (player.hasStatusEffect(StatusEffects.CooldownSpellMindBlast)) {
				bd.disable("You need more time before you can use mind blast again.\n\n");
			}
			bd = buttons.add("Mirror Image", mirrorImage).hint("Create multiple clone of yourself to distract your opponent.\n\nMana Cost: " + spellCostWhite(100) + "");
			if (player.mana < spellCost(100)) {
				bd.disable("Your mana is too low to use mirror image.");
			}
		}
		//Sing
		if (player.hasPerk(PerkLib.MelkieSong) || player.hasPerk(PerkLib.HarpySong) || player.hasPerk(PerkLib.PrestigeJobBard)) {
			bd = buttons.add("Sing", SingInitiate).hint("Begin singing. While singing, you may add various powerful effects to your tune.\n.");
		}
		//Telekinetic Grab
		if ((player.racialScore(Races.VAMPIRE) >= 20 || player.racialScore(Races.DRACULA) >= 22) && !monster.hasStatusEffect(StatusEffects.TelekineticGrab)) {
			bd = buttons.add("Telekinetic Grab", TelekineticGrab, "Use telekinesis to hold your opponent. \n\nWould go into cooldown after use for: 6 rounds");
			bd.requireMana(spellCost(50));
			if (player.hasStatusEffect(StatusEffects.CooldownTelekineticGrab)) {
				bd.disable("You need more time before you can use Telekinetic Grab again.\n\n");
			} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
		}
		if (player.hasPerk(PerkLib.ElementalBody)) {
			for each (var fusionAbility:CombatAbility in CombatAbilities.ALL_ELEMENTAL_FUSION_ATTACKS) {
                if (fusionAbility.isKnown) {
                    buttons.append(fusionAbility.createButton(monster));
                }
            }
		}
		if (player.hasStatusEffect(StatusEffects.ShieldingSpell)) buttons.add("Shielding", shieldingSpell);
		if (player.hasStatusEffect(StatusEffects.ImmolationSpell)) buttons.add("Immolation", immolationSpell);
		if (player.hasStatusEffect(StatusEffects.IcePrisonSpell)) buttons.add("Ice Prison", iceprisonSpell);
	}

	//New Abilities and Items
	//[Abilities]
	//Whisper
	public function superWhisperAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(monster is EncapsulationPod || monster.inte == 0) {
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
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if(monster.hasPerk(PerkLib.Focused)) {
			if(!monster.plural) outputText("[Themonster] is too focused for your whispers to influence!\n\n");
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
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownFreezingBreath,9,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownFreezingBreath,10,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusStrength() * 0.2;
		damage += scalingBonusToughness() * 0.2;
		damage += rand(60);
		damage = calcGlacialMod(damage, true);
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 5;
		if (combat.wearingWinterScarf()) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.hasPerk(PerkLib.AscensionOneRaceToRuleThemAllX)) damage += (0.25 * player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX));
		damage = Math.round(damage * combat.iceDamageBoostedByDao());
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, a powerful wave of cold blasting the area in front of you.  [Themonster] does [monster his] best to avoid it, but the wave of freezing air is too fast.");
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.");
			enemyAI();
			return;
		}
		//Special enemy avoidances
		if (valaReflect(damage, "ice wave", player.takeIceDamage)) {}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] scream for an instant as it is flash frozen solid by the wave along with everything around it! Your opponent now trapped in a block of ice tries very hard to burst out and get free of its glacial prison.");
				monster.createStatusEffect(StatusEffects.FrozenSolid,3,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be frozen by your attack.</b>");
			}
			outputText(" ");
			doIceDamage(damage, true , true);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	private function checkLethiceAndCombatRoundOver():void {
		if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
			outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
		enemyAI();
	}

	public function yetiFreezingBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		var cooldown:Number = 10;
		if (player.perkv1(IMutationsLib.YetiFatIM) >= 3) cooldown -= 3;
		if (player.hasPerk(PerkLib.NaturalInstincts)) cooldown -= 1;
		player.createStatusEffect(StatusEffects.CooldownFreezingBreathYeti,cooldown,0,0,0);
		var damage:Number = 0;
		if (player.tou < 21) damage += (player.tou/3 + rand(player.tou/2));	//omfg why....
		else if (player.tou < 41) damage += (player.tou / 2 + rand((player.tou * 3) / 4));
		else if (player.tou < 61) damage += ((player.tou * 2) / 3 + rand(player.tou));
		else if (player.tou < 81) damage += ((player.tou * 5) / 6 + rand(player.tou * 1.25));
		else if (player.tou < 101) damage += (player.tou + rand(player.tou * 1.5));
		else if (player.tou < 151) damage += ((player.tou * 1.25) + rand(player.tou * 1.75));
		else if (player.tou < 201) damage += ((player.tou * 1.5) + rand(player.tou * 2));
		else if (player.tou < 251) damage += ((player.tou * 1.75) + rand(player.tou * 2.25));
		else if (player.tou < 301) damage += ((player.tou * 2) + rand(player.tou * 2.5));
		else if (player.tou < 351) damage += ((player.tou * 2.25) + rand(player.tou * 2.75));
		else if (player.tou < 401) damage += ((player.tou * 2.5) + rand(player.tou * 3));
		else if (player.tou < 451) damage += ((player.tou * 2.75) + rand(player.tou * 3.25));
		else if (player.tou < 501) damage += ((player.tou * 3) + rand(player.tou * 3.5));
		else if (player.tou < 551) damage += ((player.tou * 3.25) + rand(player.tou * 3.75));
		else if (player.tou < 601) damage += ((player.tou * 3.5) + rand(player.tou * 4));
		else if (player.tou < 651) damage += ((player.tou * 3.75) + rand(player.tou * 4.25));
		else if (player.tou < 701) damage += ((player.tou * 4) + rand(player.tou * 4.5));
		else if (player.tou < 751) damage += ((player.tou * 4.25) + rand(player.tou * 4.75));
		else if (player.tou < 801) damage += ((player.tou * 4.5) + rand(player.tou * 5));
		else if (player.tou < 851) damage += ((player.tou * 4.75) + rand(player.tou * 5.25));
		else if (player.tou < 901) damage += ((player.tou * 5) + rand(player.tou * 5.5));
		else if (player.tou < 951) damage += ((player.tou * 5.25) + rand(player.tou * 5.75));
		else damage += ((player.tou * 5.5) + rand(player.tou * 6));
		damage = calcGlacialMod(damage, true);
		if (combat.wearingWinterScarf()) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.perkv1(IMutationsLib.YetiFatIM) >= 1) damage *= 1.50;
		damage = Math.round(damage * combat.iceDamageBoostedByDao());
		outputText("You inhale deeply, then blow a freezing breath attack at your opponent, encasing it in ice!");
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.");
			enemyAI();
			return;
		}
		//Special enemy avoidances
		if (valaReflect(damage, "freezing breath", player.takeIceDamage)) {}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText(" frozen solid!");
				var freezetime:Number = 3;
				if (player.perkv1(IMutationsLib.YetiFatIM) >= 3) freezetime += 1;
				monster.createStatusEffect(StatusEffects.FrozenSolid,freezetime,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be frozen by your attack.</b>");
			}
			outputText(" ");
			doIceDamage(damage, true, true);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function SingInitiate(Bee:Boolean = false):void {
		clearOutput();
		if (Bee) outputText("You start singing an enrapturing song. Buzzing over enticingly.");
		else outputText("You start singing an enrapturing song.");
		if (player.hasPerk(PerkLib.EmpoweredAria)) player.createStatusEffect(StatusEffects.Sing,5,0,0,0);
		else player.createStatusEffect(StatusEffects.Sing,1,0,0,0);
		outputText("\n\n");
		enemyAI();
	}

	public function singCompellingAria():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var IntligenceModifier:Number = 0;
		if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) IntligenceModifier += scalingBonusIntelligence();
		if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) IntligenceModifier += scalingBonusIntelligence();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
			outputText("You end your theme with a powerful finale compelling everyone around to adore and love you.");
			var lustDmgF:Number = monster.lustVuln * 3 * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			lustDmgF += IntligenceModifier;
			if (player.hasPerk(PerkLib.EromancyExpert)) lustDmgF *= 1.5;
			if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
				if (player.hasPerk(PerkLib.ArouseTheAudience)) lustDmgF *= 7.5;
				else lustDmgF *= 5;
			}
			if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 1) lustDmgF *= 1.2;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) lustDmgF *= 1.3;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) lustDmgF *= 1.4;
			if (player.armor == armors.ELFDRES && player.isElf()) lustDmgF *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmgF *= 2;
			lustDmgF = Math.round(lustDmgF);
			monster.teased(lustDmgF);
			if(!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,4,0,0,0);
			if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownCompellingAria,11,0,0,0);
			else player.createStatusEffect(StatusEffects.CooldownCompellingAria,10,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			outputText("\n\n");
			if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
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
			lustDmg2 += IntligenceModifier * 0.5;
			if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg2 *= 1.5;
			if (player.hasPerk(PerkLib.RacialParagon)) lustDmg2 *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg2 *= 1.50;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 1) lustDmg2 *= 1.2;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) lustDmg2 *= 1.3;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) lustDmg2 *= 1.4;
			if (player.armor == armors.ELFDRES && player.isElf()) lustDmg2 *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg2 *= 2;
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
			lustDmg += IntligenceModifier * 0.25;
			if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
			if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 1) lustDmg *= 1.2;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) lustDmg *= 1.3;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) lustDmg *= 1.4;
			if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 1, 0, 0, 0);
			outputText("\n\n");
			enemyAI();
		}
	}

	public function ElectricDischarge():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You begin to gather energy within your electrocytes your bodily lights turning bright white as you enter overcharge. Suddenly you deliver the amassed current your energy running throught the air like a bright bolt of white death and roaring thunder.");
		if (monster.hasStatusEffect(StatusEffects.DragonWaterBreath)){
			outputText("Electrified Water is blasted all around your wet target as lightning and fluid turn into a booming explosion the force of wich plaster [monster him] to the ground dazed the violence of the impact!");
			monster.removeStatusEffect(StatusEffects.DragonWaterBreath);
			monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		}
		var damage:Number = scalingBonusIntelligence() * spellModWhite() * 4;
		//Determine if critical hit!
		var crit1:Boolean = false;
		var critChance1:int = 5;
		critChance1 += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
		if (rand(100) < critChance1) {
			crit1 = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcVoltageMod(damage, true);
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.lightningDamageBoostedByDao());
		doLightningDamage(damage, true, true);
		outputText(" damage. ");
		if (crit1) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function OrgasmicLightningStrike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var temp2:Number;
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
			outputText("You achieve a thundering orgasm, lightning surging out of your body as you direct it toward [themonster], gleefully zapping [monster him] body with your accumulated lust! Your desire, however, only continues to ramp up.\n\n");
			temp2 = 5 + rand(player.lib / 5 + player.cor / 10);
			dynStats("lus", temp2, "scale", false);
			var lustDmgF:Number = combat.teases.teaseBaseLustDamage();
			var lustBoostToLustDmg:Number = 0;
			if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemTags.A_REVEALING)) lustDmgF *= (1 + ((10 + rand(11)) / 100));
			if (player.hasPerk(PerkLib.ElectrifiedDesire)) {
				lustDmgF *= (1 + (player.lust100 * 0.01));
			}
			if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) {
				lustDmgF *= (1 + combat.historyWhoreBonus());
			}
			lustBoostToLustDmg += lustDmgF * 0.01;
			lustDmgF *= 0.2;
			if (player.lust100 * 0.01 >= 0.9) {
				lustDmgF += (lustBoostToLustDmg * 140);
			}
			else if (player.lust100 * 0.01 < 0.2) {
				lustDmgF += (lustBoostToLustDmg * 140);
			}
			else {
				lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
			}
			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combat.teases.combatTeaseCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				lustDmgF *= 1.75;
			}
			if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) lustDmgF *= 1.1;
			if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) lustDmgF *= 1.2;
			if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) lustDmgF *= 1.3;
			if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
			lustDmgF = Math.round(monster.lustVuln * lustDmgF);
			monster.teased(lustDmgF);
			if (crit) outputText(" <b>Critical!</b>");
			outputText("\n\n");
			if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,5,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			enemyAI();
		}
		else if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You continue masturbating, lost in the sensation as lightning runs across your form. You are almost there!\n\n");
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

	public function PleasureBolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You gasp in pleasure your body charging up before discharging a bolt of electricity at your foe dealing ");
		var damage:Number = scalingBonusIntelligence() * spellModWhite() * 4;
		//Determine if critical hit!
		var crit1:Boolean = false;
		var critChance1:int = 5;
		critChance1 += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
		if (rand(100) < critChance1) {
			crit1 = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcVoltageMod(damage, true);
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.perkv1(IMutationsLib.FloralOvariesIM) >= 1) damage *= 1.25;
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.lightningDamageBoostedByDao());
		doLightningDamage(damage, true, true);
		outputText(" damage. ");
		if (crit1) outputText(" <b>*Critical Hit!*</b>");
		dynStats("lus", (Math.round(player.maxLust() * 0.02)), "scale", false);
		var lustDmgF:Number = combat.teases.teaseBaseLustDamage();
		var lustBoostToLustDmg:Number = 0;
		lustBoostToLustDmg += lustDmgF * 0.01;
		if (player.lust100 * 0.01 >= 0.9) lustDmgF += (lustBoostToLustDmg * 140);
		else if (player.lust100 * 0.01 < 0.2) lustDmgF += (lustBoostToLustDmg * 140);
		else lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
		//Determine if critical tease!
		var crit2:Boolean = false;
		var critChance2:int = 5;
		critChance2 += combat.teases.combatTeaseCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance2 = 0;
		if (rand(100) < critChance2) {
			crit2 = true;
			lustDmgF *= 1.75;
		}
		if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
		if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) lustDmgF *= 1.5;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) damage *= 1.1;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) damage *= 1.2;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) damage *= 1.3;
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
		lustDmgF = lustDmgF * monster.lustVuln;
		lustDmgF = Math.round(lustDmgF);
		monster.teased(lustDmgF);
		if (crit2) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		if (monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3 && rand(100) < 10 && !monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
		enemyAI();
	}

	public function Luststorm():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var damage:Number = scalingBonusIntelligence() * spellModWhite() * 4 * combat.lightningDamageBoostedByDao();
		//Determine if critical hit!
		var crit1:Boolean = false;
		var critChance1:int = 5;
		critChance1 += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
		if (rand(100) < critChance1) {
			crit1 = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcVoltageMod(damage, true);
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage);
		dynStats("lus", (Math.round(player.maxLust() * 0.02)), "scale", false);
		var lustDmgF:Number = combat.teases.teaseBaseLustDamage();
		var lustBoostToLustDmg:Number = 0;
		lustBoostToLustDmg += lustDmgF * 0.01;
		lustDmgF *= 0.2;
		if (player.lust100 * 0.01 >= 0.9) lustDmgF += (lustBoostToLustDmg * 140);
		else if (player.lust100 * 0.01 < 0.2) lustDmgF += (lustBoostToLustDmg * 140);
		else lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
		//Determine if critical tease!
		var crit2:Boolean = false;
		var critChance2:int = 5;
		critChance2 += combat.teases.combatTeaseCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance2 = 0;
		if (rand(100) < critChance2) {
			crit2 = true;
			lustDmgF *= 1.75;
		}
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) lustDmgF *= 1.1;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) lustDmgF *= 1.2;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) lustDmgF *= 1.3;
		lustDmgF = lustDmgF * monster.lustVuln;
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
		lustDmgF = Math.round(lustDmgF);
		outputText("You let electricity build up in your body before unleashing it into the ambient sky, the clouds roaring with thunder. Here comes the storm! ");
		doLightningDamage(damage, true, true);
		if (crit1) outputText(" <b>*Critical!*</b>");
		monster.teased(lustDmgF, false);
		if (crit2) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3){
			if (rand(100) < 10) {
				if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
			}
		}
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		statScreenRefresh();
		player.createStatusEffect(StatusEffects.lustStorm,0,0,0,0);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		if (monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		else enemyAI();
	}

	public function PlasmaBlast():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3 || player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) {
			if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownPlasmaBlast,3,0,0,0);
			else player.createStatusEffect(StatusEffects.CooldownPlasmaBlast, 4, 0, 0, 0);
		}
		else player.createStatusEffect(StatusEffects.CooldownPlasmaBlast, 0, 0, 0, 0);
		var damage:Number = 0;
		if (player.gender == 1) {
			if (player.isTaur()) outputText("You rear up and moan, using your forepaws to jerk and molest your [cock] as you grope your [chest] with your free hands. Finally you scream in thunderous orgasmic bliss as your cock shoots a massive jet of cum mixed with plasma. ");
			else outputText("You begin to masturbate fiercely, your [balls] expending with stacked semen as you ready to blow. Your cock shoots a massive jet of cum mixed with plasma, projecting [themonster] away and knocking it prone. ");
			damage += player.cumQ();
			damage *= (player.lust100 * 0.01);
			damage *= 1.2;
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			doPlasmaDamage(damage, true, true);
			if (monster.lustVuln > 0) {
				outputText(" ");
				var CumLustDmg:Number = combat.teases.teaseBaseLustDamage();
				CumLustDmg += player.cumQ()/100;
				CumLustDmg *= (player.lust100 * 0.01);
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) CumLustDmg *= 1.20;
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) CumLustDmg *= 1.20;
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) CumLustDmg *= 1.20;
				monster.teased(Math.round(monster.lustVuln * CumLustDmg));
				combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			}
			player.lust += (player.lust100 * 0.05);
		}
		if (player.gender == 2) {
			outputText("You grab both of your udder smirking as you point them toward your somewhat confused target. You moan a pleasured Mooooooo as you open the dam, splashing [themonster] with twin jets of milk mixed with plasma so powerful it is blown away, hitting the nearest obstacle. ");
			damage += player.lactationQ();
			damage *= (player.lust100 * 0.01);
			damage *= 1.2;
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			doPlasmaDamage(damage, true, true);
			if (monster.lustVuln > 0) {
				outputText(" ");
				var MilkLustDmg:Number = combat.teases.teaseBaseLustDamage();
				MilkLustDmg += player.lactationQ()/100;
				MilkLustDmg *= (player.lust100 * 0.01);
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) MilkLustDmg *= 1.20;
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) MilkLustDmg *= 1.20;
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) MilkLustDmg *= 1.20;
				monster.teased(Math.round(monster.lustVuln * MilkLustDmg));
				combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			}
			player.lust += (player.lust100 * 0.05);
		}
		if (player.gender == 3) {
			if (player.isTaur()) outputText("You rear up and moan, using your forepaws to jerk and molest your [cock] as you grope your [chest] with your free hands. Finally you scream in thunderous orgasmic bliss as your cock shoots a massive jet of cum mixed with plasma followed shortly by a twin shot of plasma infused breast milk. ");
			else outputText("You moan as you begin to molest your [cock] using your free hand to grope at your [chest]. Finally you scream in a thunderous orgasmic pleasure as your cock shoots a massive jet of cum mixed with plasma followed shortly by a twin shot of plasma infused breast milk. ");
			damage += player.lactationQ();
			damage += player.cumQ();
			damage *= 1.5;
			damage *= (player.lust100 * 0.02);
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			doPlasmaDamage(damage, true, true);
			if (monster.lustVuln > 0) {
				outputText(" ");
				var MilkCumLustDmg:Number = combat.teases.teaseBaseLustDamage();
				MilkCumLustDmg += player.lactationQ()/100;
				MilkCumLustDmg += player.cumQ()/100;
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) MilkCumLustDmg *= 1.20;
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) MilkCumLustDmg *= 1.20;
				if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) MilkCumLustDmg *= 1.20;
				monster.teased(Math.round(monster.lustVuln * MilkCumLustDmg));
				combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			}
			player.lust += (player.lust100 * 0.1);
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		enemyAI();
	}

	public function startOniRampage():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("A terrifying red aura of power shroud your body as you shout a loud thundering war cry and enter a murderous rampage.");
			var onirampageDuration:Number = 6;
			var onirampageCooldown:Number = 10;
			if (player.perkv1(IMutationsLib.OniMusculatureIM) >= 3) {
				onirampageDuration += 3;
				onirampageCooldown -= 1;
			}
			if (player.hasPerk(PerkLib.OniEnlightenedKimono)) onirampageDuration += 10;
			if (player.hasPerk(PerkLib.OniTyrantKimono)) onirampageDuration += 5;
			if (player.armor == armors.SPKIMO) onirampageDuration += 2;
			if (player.necklace == necklaces.OBNECK) onirampageDuration += 1;
			if (player.hasPerk(PerkLib.NaturalInstincts)) onirampageCooldown -= 1;
			player.createStatusEffect(StatusEffects.OniRampage,onirampageDuration,0,0,0);
			player.createStatusEffect(StatusEffects.CooldownOniRampage,onirampageCooldown,0,0,0);
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
	public function minOniScoreReq():Number {
		var miniOniscored:Number = 12;
		if (player.perkv1(IMutationsLib.OniMusculatureIM) >= 1) miniOniscored -= 6;
		if (player.perkv1(IMutationsLib.OniMusculatureIM) >= 2) miniOniscored -= 3;
		return miniOniscored;
	}

	private function valaReflect(damage:Number, attack:String, takeDmgF:Function, applyBlizzard:Boolean = false):Boolean {
		if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the " + attack + " back at you! ");
			if(player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if(player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if(applyBlizzard && player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the " + attack + " energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
				damage = player.takeFireDamage(damage);
				combat.CommasForDigits(damage);
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own " + attack + " with your [shield]!");
			}
			else {
				damage = takeDmgF(damage);
				outputText("Your own " + attack + " smacks into your face! ");
				combat.CommasForDigits(damage);
			}
			outputText("\n\n");
			return true;
		} else return false;
	}


	public function phoenixfireBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownPhoenixFireBreath,4,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownPhoenixFireBreath,5,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusStrength() * 0.5;
		damage += scalingBonusToughness() * 0.5;
		damage += 50 + rand(20);
		damage = calcInfernoMod(damage, true);
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
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
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but the wave of force is too fast.");
		if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || ((monster.getEvasionRoll(false, player.spe)))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your attack, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "fire breath", player.takeFireDamage, true)) {}
		//Goos burn
		else if(monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer. ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5 * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		else {
			outputText(" ");
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}
		outputText("\n\n");
		if (monster is Holli && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function iceBarrage():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		var damage:Number = scalingBonusIntelligence() * spellModBlack() * 4;
		if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 1) {
			var IBM:Number = 1.1;
			if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 2) IBM += 0.2;
			if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 3) IBM += 0.3;
			damage *= IBM;
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcGlacialMod(damage, true);
		if (combat.wearingWinterScarf()) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.iceDamageBoostedByDao());
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText("You thrust both hands forward, gathering moisture and freezing it in the shape of Icy dagger like shards. The wind whips past you, cold and carrying with it long pointed shards of ice. They crash against [themonster]. [monster he] screams in pain as [monster his] body is impaled multiple times by the barrage of projectiles. ");
		doIceDamage(damage, true, true);
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		monster.createStatusEffect(StatusEffects.Hemorrhage, 4, 0.05, 0, 0);
		if (monster.hasStatusEffect(StatusEffects.FrostburnDoT)) {
			monster.addStatusValue(StatusEffects.FrostburnDoT,1,1);
			monster.addStatusValue(StatusEffects.FrostburnDoT,3,1);
		}
		else monster.createStatusEffect(StatusEffects.FrostburnDoT,4,0.02,0,0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function hungeringCold():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		var HCCD:Number = 10;
		var HCD:Number = 8;
		if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 2) {
			HCCD -= 1;
			HCD += 1;
		}
		if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 3) {
			HCCD -= 3;
			HCD += 3;
		}
		if (player.hasPerk(PerkLib.NaturalInstincts)) HCCD -= 1;
		player.createStatusEffect(StatusEffects.CooldownHungeringCold,HCCD,0,0,0);
		var damage:Number = scalingBonusIntelligence() * spellModBlack() * 0.8;
		if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 1) {
			var HCM:Number = 1.1;
			if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 2) HCM += 0.2;
			if (player.perkv1(IMutationsLib.FrozenHeartIM) >= 3) HCM += 0.3;
			damage *= HCM;
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcGlacialMod(damage, true);
		if (combat.wearingWinterScarf()) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.iceDamageBoostedByDao());
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText("You condense the natural humidity ambient in the air to a focal point and encase [themonster] in a solid block of ice! You can almost feel [monster him] shivering in there from the sudden temperature spike. ");
		doIceDamage(damage, true, true);
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		if (monster.hasStatusEffect(StatusEffects.FrostburnDoT)) {
			monster.addStatusValue(StatusEffects.FrostburnDoT,1,1);
			if (monster.statusEffectv3(StatusEffects.FrostburnDoT) < 3) monster.addStatusValue(StatusEffects.FrostburnDoT,3,1);
		}
		else monster.createStatusEffect(StatusEffects.FrostburnDoT,HCD,0.02,1,0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function frozenKiss():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(60, USEFATG_MAGIC_NOBM);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownFrozenKiss,7,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownFrozenKiss,8,0,0,0);
		var damage:Number = scalingBonusIntelligence() * spellModBlack() * 0.8;
		//High damage to goes.
		damage = calcGlacialMod(damage, true);
		if (combat.wearingWinterScarf()) damage *= 1.2;
		damage = Math.round(damage);
		outputText("You suddenly close the gap between you and [themonster] embracing [monster him] with both arms and drawing [monster him] in for a sudden kiss. At first [themonster] is surprised but [monster his] expression changes to horror as it starts to realise you're draining [monster his] warmth away. ");
		var lustDmg:Number = player.lust / 10 + player.lib / 10;
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			enemyAI();
			return;
		}
		outputText(" [monster he] barely manages to shove you off before you turn [monster him] into a frozen husk, highly shocked yet aroused by the experience.  ");
		mosterTeaseText();
		monster.teased(Math.round(monster.lustVuln * lustDmg));
		outputText("  ");
		damage = Math.round(damage * combat.iceDamageBoostedByDao());
		doIceDamage(damage, true, true);
		HPChange(damage,false);
		outputText("\n\n");
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		doNext(playerMenu);
		if (monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		else if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	private function mosterTeaseText():void {
		if (monster.cocks.length > 0) {
			if (monster.lust >= (monster.maxLust() * 0.6)) outputText("You see [monster his] [monster cocks] dribble pre-cum.  ");
			else if (monster.lust >= (monster.maxLust() * 0.3) && monster.cocks.length == 1) outputText("[Themonster]'s [monster cock] hardens, distracting [monster him] further.  ");
			else if (monster.lust >= (monster.maxLust() * 0.3)) outputText("You see [monster his] [monster cocks] harden uncomfortably.  ");
		}
		if (monster.vaginas.length > 0) {
			if (monster.plural) {
				if (monster.lust >= (monster.maxLust() * 0.6)) {
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText("[Themonster]'s [monster vag]s dampen perceptibly.  ");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText("[Themonster]'s crotches become sticky with girl-lust.  ");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText("[Themonster]'s [monster vag]s become sloppy and wet.  ");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of [themonster]'s thighs.  ");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText("[Themonster]'s [monster vag]s instantly soak [monster him] groin.  ");
				}
			} else {
				if (monster.lust >= (monster.maxLust() * 0.6)) {
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText("[Themonster]'s [monster vag] dampens perceptibly.  ");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText("[Themonster]'s crotch becomes sticky with girl-lust.  ");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText("[Themonster]'s [monster vag] becomes sloppy and wet.  ");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of [themonster]'s thighs.  ");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText("[Themonster]'s [monster vag] instantly soaks her groin.  ");
				}
			}
		}
	}

	public function acidSpit():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		var damage:Number = 0;
		var damult:Number = 1;
		var scalingmulti:Number = 1;
		var debufstr:Number = 1;
		if (player.perkv1(IMutationsLib.CaveWyrmLungsIM) >= 1) damult += 2;
		if (player.perkv1(IMutationsLib.CaveWyrmLungsIM) >= 2) {
			damult += 2;
			scalingmulti += 1;
		}
		if (player.perkv1(IMutationsLib.CaveWyrmLungsIM) >= 3) {
			damult += 2;
			debufstr += 2;
		}
		damage += player.str;
		damage += scalingBonusStrength() * scalingmulti;
		damage += player.tou;
		damage += scalingBonusToughness() * scalingmulti;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= damult;
		damage = calcCorrosionMod(damage, true);
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The acid courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}
		outputText("You spit a blob of neon blue acid at [themonster] your corrosive fluids burning at "+((monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) ? "their" : "[monster his]")+" flesh.");
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || ((monster.getEvasionRoll(false, player.spe)))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your attack, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "acid spit", player.takeAcidDamage)) {}
		else {
			outputText(" ");
			doAcidDamage(damage, true, true);
		}
		outputText("\n\n");
		if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
			monster.addStatusValue(StatusEffects.AcidDoT,1,1);
			monster.addStatusValue(StatusEffects.AcidDoT,3,debufstr);
		}
		else monster.createStatusEffect(StatusEffects.AcidDoT,4,0.02,debufstr,0);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function azureflameBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		var damage:Number = 0;
		var damult:Number = 1;
		var scalingmulti:Number = 1;
		if (player.perkv1(IMutationsLib.CaveWyrmLungsIM) >= 1) damult += 2;
		if (player.perkv1(IMutationsLib.CaveWyrmLungsIM) >= 2) {
			damult += 2;
			scalingmulti += 1;
		}
		if (player.perkv1(IMutationsLib.CaveWyrmLungsIM) >= 3) damult += 2;
		damage += player.str;
		damage += scalingBonusStrength() * scalingmulti;
		damage += player.tou;
		damage += scalingBonusToughness() * scalingmulti;
		damage = calcInfernoMod(damage, true);
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= damult;
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
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
		outputText("You inhale and torch [themonster] with your bluish flames setting your opponent on fire.");
		if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your attack, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "azure flame breath", player.takeFireDamage, true)) {}
		//Goos burn
		else if(monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer. ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5 * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
			if (player.perkv1(IMutationsLib.CaveWyrmLungsIM) >= 3) monster.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
		}
		else {
			if (player.perkv1(IMutationsLib.CaveWyrmLungsIM) >= 3) {
				if(!monster.hasPerk(PerkLib.Resolute)) {
					outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
					monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
				}
				else {
					outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
					if(!monster.plural) outputText("is ");
					else outputText("are");
					outputText("too resolute to be stunned by your attack.</b> ");
				}
			}
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		outputText("\n\n");
		monster.createStatusEffect(StatusEffects.BurnDoT,5,0.02,0,0);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
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
		var damult:Number = 1;
		damage += scalingBonusIntelligence();
		damage += scalingBonusWisdom();
		damage *= 1 + (rand(51) / 100);
		damage = calcInfernoMod(damage, true);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 4;
		damage *= damult;
		damage = Math.round(damage);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
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
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but the wave of force is too fast.");
		if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "fire breath", player.takeFireDamage, true)) {}
		//Goos burn
		else if(monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer. ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5 * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
			monster.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster is Holli && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		checkLethiceAndCombatRoundOver();
	}

	public function dragoniceBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonIceBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		var damult:Number = 1;
		damage += scalingBonusIntelligence();
		damage += scalingBonusWisdom();
		damage *= 1 + (rand(51) / 100);
		damage = calcGlacialMod(damage, true);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
		if (combat.wearingWinterScarf()) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 4;
		damage *= damult;
		damage = Math.round(damage * combat.iceDamageBoostedByDao());
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but the wave of force is too fast.");
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "ice", player.takeIceDamage)) {}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doIceDamage(damage, true, true);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function dragonlightningBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonLightningBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		var damult:Number = 1;
		damage += scalingBonusIntelligence();
		damage += scalingBonusWisdom();
		damage *= 1 + (rand(51) / 100);
		damage = calcVoltageMod(damage, true);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 4;
		damage *= damult;
		damage = Math.round(damage * combat.lightningDamageBoostedByDao());
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The lightning courses by the stone skin harmlessly. Thou it does leave the surface of the statue sparkling with a few residual lighting discharges.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but the wave of force is too fast.");
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "lightning breath", player.takeLightningDamage)) {}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doLightningDamage(damage, true, true);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function dragondarknessBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonDarknessBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		var damult:Number = 1;
		damage += scalingBonusIntelligence();
		damage += scalingBonusWisdom();
		damage *= 1 + (rand(51) / 100);
		damage = calcEclypseMod(damage, true);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 4;
		damage *= damult;
		damage = Math.round(damage * combat.darknessDamageBoostedByDao());
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The darkness courses by the stone skin harmlessly. Thou it does leave the surface of the statue with a thin layer of dark glow.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but the wave of force is too fast.");
		//Miss:
		if((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "darkness breath", player.takeDarknessDamage)) {}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doDarknessDamage(damage, true, true);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function dragonpoisonBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonPoisonBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		var damult:Number = 1;
		damage += scalingBonusIntelligence();
		damage += scalingBonusWisdom();
		damage *= 1 + (rand(51) / 100);
		damage = calcEclypseMod(damage, true);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 4;
		damage *= damult;
		damage = Math.round(damage * combat.poisonDamageBoostedByDao());
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The poison courses by the stone skin harmlessly. Thou it does leave the surface of the statue with a thin layer of dark glow.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but the wave of force is too fast.");
		//Miss:
		if((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "poison breath", player.takePoisonDamage)) {}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doPoisonDamage(damage, true, true);
			var strDebuff:Number = 0;
			if (monster.spe >= 21) strDebuff += 20;
			else strDebuff += 20 - monster.spe;
			monster.strStat.core.value -= strDebuff;
			var speDebuff:Number = 0;
			if (monster.spe >= 21) speDebuff += 20;
			else speDebuff += 20 - monster.spe;
			monster.speStat.core.value -= speDebuff;
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function dragonWaterBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonWaterBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		var damult:Number = 1;
		damage += scalingBonusIntelligence();
		damage += scalingBonusWisdom();
		damage *= 1 + (rand(51) / 100);
		damage = calcTideMod(damage, true);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 4;
		damage *= damult;
		damage = Math.round(damage * combat.waterDamageBoostedByDao());
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The water courses by the stone skin harmlessly. Thou it does leave the surface of the statue with a thin layer of dark glow.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but the wave of force is too fast.<b>Your opponent is now wet with water!</b>");
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "water breath", player.takeWaterDamage)) {}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doWaterDamage(damage, true, true);
			monster.createStatusEffect(StatusEffects.DragonWaterBreath,0,0,0,0);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function dragonFaerieBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonFaerieBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		var damult:Number = 1;
		damage += scalingBonusIntelligence();
		damage += scalingBonusWisdom();
		damage *= 1 + (rand(51) / 100);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 4;
		damage *= damult;
		damage = Math.round(damage * combat.waterDamageBoostedByDao());
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The water courses by the stone skin harmlessly. Thou it does leave the surface of the statue with a thin layer of dark glow.");
			enemyAI();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but the wave of force is too fast.");
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (valaReflect(damage, "faerie breath", player.takeMagicDamage)) {}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doMagicDamage(damage, true, true);
		}
		//Randomising effects
		var EffectList:Array = [];
		EffectList.push(FaeStormLightning);
		EffectList.push(FaeStormAcid);
		EffectList.push(FaeStormBurn);
		EffectList.push(FaeStormPoison);
		EffectList.push(FaeStormFrozen);
		EffectList.push(FaeStormLust);
		EffectList.push(FaeStormSleep);
		var ProcChance:Number = 40;
		if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 2) ProcChance -= 10;
		if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 3) ProcChance -= 10;
		//if (ProcChance < 0) ProcChance = 0;
		var procCount:int = 0;
		for (var i:int = 0; i < 6; i++) {
			if (rand(100) >= ProcChance) {
				procCount++;
			} else {
				break;
			}
		}
		for (i=1; i<=procCount; i++) {
			var choice:Function = randomChoice(EffectList);
			if(i == 1) {
				outputText("Your opponent ");
			}
			if(i == 2) {
				outputText(". At the same time as [monster he] ");
			}
			if(i == 3) {
				outputText(". As if to add insult to injury, [monster he] ");
			}
			if(i == 4) {
				outputText(" while [monster he] ");
			}
			if(i == 5) {
				outputText(". Finally [monster he] ");
			}
			if(i == 6) {
				outputText(". Just as you thought you couldn’t get luckier [monster he] ");
			}
			choice();
			EffectList.splice(EffectList.indexOf(choice), 1)
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function dragonRoyalBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonRoyalBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		var damult:Number = 1;
		damage += scalingBonusIntelligence();
		damage += scalingBonusWisdom();
		damage *= 1 + (rand(51) / 100);
		if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
		if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 4;
		damage *= damult;
		if (combat.checkConcentration()) return; //Amily concentration
		outputText("You inhale deeply before releasing a roar so long it erupts into a shockwave of sound pushing debris away and blasting [monster him]! Leaving them stunned and confused and bleeding! ");
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doDamage(damage, true, true);
			monster.createStatusEffect(StatusEffects.ConfusionM,5,0,0,0);
			monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05*combat.BleedDamageBoost(true), 0, 0);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function trueDragonBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			player.createStatusEffect(StatusEffects.DragonBreathCooldown,0,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			for each (var perkObj:Object in CombatMagic.magicCounterPerks) {
				if ((player.hasPerk(perkObj.tier3) || player.hasPerk(perkObj.tier4)) && player.hasStatusEffect(perkObj.counter)) player.addStatusValue(perkObj.counter, 3, -1);
			}

			var damage:Number = 0;
			var damult:Number = 1;
			damage += scalingBonusIntelligence() * 5;
			damage += scalingBonusWisdom() * 5;
			damage *= 1.5 + (rand(101) / 100);
			damage = calcInfernoMod(damage, true);
			damage = calcGlacialMod(damage, true);
			damage = calcVoltageMod(damage, true);
			damage = calcEclypseMod(damage, true);

			if(player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
				player.removeStatusEffect(StatusEffects.DragonBreathBoost);
				damage *= 3;
			}
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 2) damult += 3;
			if (player.perkv1(IMutationsLib.DraconicLungIM) >= 3) damult += 6;
			if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) damult += 3;
			if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) damult += 3;
			if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) damult += 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 1.25;
			if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 1.25;
			if (player.hasPerk(PerkLib.LightningAffinity)) damage *= 1.25;
			if (player.hasPerk(PerkLib.DarknessAffinity)) damage *= 1.25;
			if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + ((player.lust100 * 0.01) * 0.25));
			if (combat.wearingWinterScarf()) damage *= 1.05;
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			damage *= 4;
			damage *= damult;
			damage = Math.round(damage * (combat.fireDamageBoostedByDao() + combat.iceDamageBoostedByDao() + combat.lightningDamageBoostedByDao() + combat.darknessDamageBoostedByDao() - 3));
			//Shell
			if(monster.hasStatusEffect(StatusEffects.Shell)) {
				outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				enemyAI();
				return;
			}
			if (combat.checkConcentration()) return; //Amily concentration
			if (monster is LivingStatue)
			{
				outputText("The elemental energies courses by the stone skin harmlessly. Thou it does leave the surface of the statue with a thin layer of multicolor glow.");
				enemyAI();
			return;
			}
			outputText("You wreel back your head, sucking in a large breath of air before letting out all the collected energy. You let loose a bellowing roar at [themonster], so forceful that even the landscape begins to warp around the blast. [Themonster] attempts to dodge but the sheer size and speed is to immense to avoid as they are slammed with Fire, Ice, Lightning and Darkness. ");
			//Miss:
			if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
				outputText("  Despite the heavy impact caused by your roar, [themonster] manages to take it at an angle and remain on [monster his] feet and focuses on you, ready to keep fighting.");
			}
			//Special enemy avoidances
			else if (valaReflect(damage, "true dragon breath", player.takeMagicDamage)) {}
			else {
				if(!monster.hasPerk(PerkLib.Resolute)) {
					outputText(" [Themonster] is stunned and");
					monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
				}
				else {
					outputText(" [Themonster] ");
					if(!monster.plural) outputText("is ");
					else outputText("are");
					outputText("too resolute to be stunned by your attack, but still");
				}
				outputText(" takes ");
				doMagicDamage(damage, true, true);
				outputText(" from the immense blast.");
			}
			outputText("\n\n");
			checkAchievementDamage(damage);
			combat.heroBaneProc(damage);
			checkLethiceAndCombatRoundOver();
		}
		else {
			fatigue(200, USEFATG_MAGIC_NOBM);
			outputText("You open your jaw, collecting all your draconic power into your chest. The light of your mixed power coalescing in your throat as you focus.\n\n");
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 4, 0, 0, 0);
			for each (var perkDragonObj:Object in CombatMagic.magicCounterPerks) {
				if (player.hasPerk(perkDragonObj.tier3) || player.hasPerk(perkDragonObj.tier4)) player.addStatusValue(perkDragonObj.counter, 3, 1);
			}
			enemyAI();
		}
	}

	public function DragonLustPoisonBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("This thing is just seldom immune to poison like come on its a statue!");
			enemyAI();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		else {
			outputText("You inhale deeply before releasing a cloud of aphrodisiacs poison on your foe!");
			var venomType:StatusEffectType = StatusEffects.JabberwockyVenom;
			var d2Bdcc:Number = 2;
			var lustDmg2:Number = combat.teases.teaseBaseLustDamage();
			var poisonScaling:Number = 1;
			if (monster.plural){
				d2Bdcc *=5;
				lustDmg2 *=5
			}
			poisonScaling += player.lib/100;
			poisonScaling += player.tou/100;
			if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) poisonScaling += 1;
			if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 1) poisonScaling += 2;
			if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 2) poisonScaling += 2;
			if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 3) poisonScaling += 2;
			if (player.perkv1(IMutationsLib.DrakeLungsIM) >= 4) poisonScaling += 2;
			if (player.hasPerk(PerkLib.RacialParagon)) poisonScaling += 0.5;
			if (player.hasPerk(PerkLib.Apex)) poisonScaling += 0.5;
			if (player.hasPerk(PerkLib.AlphaAndOmega)) poisonScaling += 0.5;
			if (player.hasPerk(PerkLib.NaturalArsenal)) poisonScaling += 0.5;
			lustDmg2 *= poisonScaling;
			lustDmg2 *= d2Bdcc;
			monster.teased(Math.round(monster.lustVuln * lustDmg2), true);
			combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) d2Bdcc *= 2;
			monster.statStore.addBuffObject({tou:-d2Bdcc}, "Poison",{text:"Poison"});
			if(monster.hasStatusEffect(venomType))
			{
				monster.addStatusValue(venomType,2,2);
				monster.addStatusValue(venomType,1,d2Bdcc);
			}
			else monster.createStatusEffect(venomType,d2Bdcc,2,0,0);
		}
		outputText("\n\n");
		player.tailVenom -= player.VenomWebCost() * 5;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		checkLethiceAndCombatRoundOver();
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
			player.takeFireDamage(10 + rand(20), true);
			outputText("\n\n");
			enemyAI();
			return;
		}
		var damage:Number = 0;
		damage += 45 + rand(10);
		damage += scalingBonusIntelligence() * 0.25;
		damage += scalingBonusWisdom() * 0.25;
		damage = calcInfernoMod(damage, true);
		damage *= 4;
		damage = Math.round(damage);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
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
		else if (valaReflect(damage, "fireball", player.takeFireDamage, true)) {}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!\n\n");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 10 + 45 + rand(10));
			damage *= 4;
			damage *= 1.75;
			outputText(" (" + damage + ")");
			monster.HP -= damage;
			if(monster.HP <= monster.minHP()) {
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
				outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer. ");
				if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
				damage = Math.round(damage * 1.5);
			}
			if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
				outputText("<b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>  ");
				damage = Math.round(0.5 * damage);
			}
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
			outputText("\n\n");
			if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		}
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if(monster.HP <= monster.minHP()) {
			doNext(endHpVictory);
		}
		else enemyAI();
	}

//player gains hellfire perk.
//Hellfire deals physical damage to completely pure foes,
//lust damage to completely corrupt foes, and a mix for those in between.  Its power is based on the PC's corruption and level.  Appearance is slightly changed to mention that the PC's eyes and mouth occasionally show flicks of fire from within them, text could possibly vary based on corruption.
	public function hellFire():void
	{
		if (monster.cor < 50) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		if (player.faceType == Face.CERBERUS) fatigue(150, USEFATG_MAGIC_NOBM);
		else fatigue(50, USEFATG_MAGIC_NOBM);
		/* var damage:Number = (player.level * 8 + rand(10) + player.inte / 2 + player.wis / 2 + player.cor / 5);
		damage = calcInfernoMod(damage, true);
		damage *= 4;*/
		var damage:Number = combat.scalingBonusStrength(true) + combat.scalingBonusLibido(true);
		var lustDamagePercent:Number = monster.cor / 100;
		var lustDamage:Number;
		var fireDamage:Number;
		damage *= combat.pcScalingBonusCorruption(player.cor);
		damage *= spellModBlack();
		lustDamage = combat.teases.teaseBaseLustDamage() * lustDamagePercent * monster.lustVuln;
		fireDamage = calcInfernoMod(damage * (1 - lustDamagePercent), true);
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue) {
			outputText("The fire courses over the stone behemoths skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2) {
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			doFireDamage(1, true, true);
			monster.takeLustDamage(1, true);
			/*damage = int(player.level * 8 + rand(10) + player.cor / 5);
			damage *= 4;
			damage *= 1.75;
			outputText(" (" + damage + ")");
			monster.HP -= damage;*/
			if(monster.HP <= monster.minHP()) {
				doNext(endHpVictory);
			}
			else if(monster.lust >= monster.maxOverLust()) {
				doNext(endLustVictory);
			}
			else enemyAI();
			return;
		}
		else if(monster.short == "Isabella" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("  Isabella shoulders her shield into the path of the crimson flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to the sides.\n\n");
			if (SceneLib.isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n");
			else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n");
			enemyAI();
			return;
		}
		else if (valaReflect(damage, "hellfire", player.takeLustDamage, true)) {}
		if(!player.hasStatusEffect(StatusEffects.GooArmorSilence)) outputText("You take in a deep breath and unleash a wave of corrupt red flames from deep within.");
		if(player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("  <b>The fire burns through the webs blocking your mouth!</b>");
			player.removeStatusEffect(StatusEffects.WebSilence);
		}
		if(player.hasStatusEffect(StatusEffects.GooArmorSilence)) {
			outputText("  <b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  ");
			outputText("When you can finally work your jaw"+(player.faceType == Face.CERBERUS?"s":"")+" enough to open your mouth"+(player.faceType == Face.CERBERUS?"s":"")+", you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b>");
			player.removeStatusEffect(StatusEffects.GooArmorSilence);
			damage *= 2;
		}
		else {
			if(monster.lustVuln > 0) {
				if(monster.cor >= 90) outputText("  Your foe cries out in surprise and then gives a sensual moan as the flames of your passion surround them and scorches their body with unnatural lust.");
				else if(monster.cor <= 10) outputText("  Your foe lets out a shriek as their form is engulfed in the blistering flames, leaving them slightly aroused.");
				else outputText("  Your foe lets out a shriek as their form is engulfed in the blistering flames searing their body while filling it with an unnatural lust.");
				doFireDamage(fireDamage, true, true);
				monster.takeLustDamage(lustDamage, true);
				if (player.faceType == Face.CERBERUS) {
					doFireDamage(fireDamage, true, true);
					monster.takeLustDamage(lustDamage, true);
					doFireDamage(fireDamage, true, true);
					monster.takeLustDamage(lustDamage, true);
					fireDamage *= 3;
				}
			}
			else {
				outputText("  Your foe lets out a shriek as their form is engulfed in the blistering flames, charring their body");
				doFireDamage(fireDamage, true, true);
			}
			/* if(monster.inte < 10) {
				outputText("  Your foe lets out a shriek as their form is engulfed in the blistering flames.");
				damage = Math.round(damage * combat.fireDamageBoostedByDao());
				damage = int(damage);
				doFireDamage(damage, true, true);
				outputText("<b>(<font color=\"#800000\">+" + damage + "</font>)</b>\n");
			}
			else
			{
				if(monster.lustVuln > 0) {
					outputText("  Your foe cries out in surprise and then gives a sensual moan as the flames of your passion surround them and fill their body with unnatural lust.");
					if (player.hasPerk(PerkLib.EromancyExpert)) damage *= 1.5;
					if (player.armor == armors.ELFDRES && player.isElf()) damage *= 2;
        			if (player.armor == armors.FMDRESS && player.isWoodElf()) damage *= 2;
					monster.teased(Math.round(monster.lustVuln * (damage / 6)));
					outputText("\n");
					if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
				}
				else {
					outputText("  The corrupted fire doesn't seem to have effect on [themonster]!\n");
				}
			}
		*/
		}
		outputText("\n");
		combat.heroBaneProc(fireDamage);
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		if(monster.HP <= monster.minHP()) {
			doNext(endHpVictory);
		}
		else if(monster.lust >= monster.maxOverLust()) {
			doNext(endLustVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}

	public function berzerk():void {
		clearOutput();
		player.wrath -= 50;
		var berzerkDuration:Number = 10;
		if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 2) berzerkDuration += 2;
		if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) berzerkDuration += 8;
		if (player.hasPerk(PerkLib.ColderFury)) {
			outputText("You roar and unleash your savage fury in order to destroy your foe!\n\n");
		}
		else if (player.hasPerk(PerkLib.ColdFury)) {
			outputText("You roar and unleash your savage fury, forgetting about defense from magical attacks in order to destroy your foe!\n\n");
		}
		else outputText("You roar and unleash your savage fury, forgetting about defense from any physical or magical attacks in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.Berzerking,berzerkDuration,0,0,0);
		enemyAI();
	}
	public function berzerkG2():void {
		clearOutput();
		outputText("Placeholder text that only meantion savage fury reaching Grade 2."+(player.hasPerk(PerkLib.Anger)?" +1 large/massive weapon atk.":"")+" - 50% max over HP.\n\n");
		player.HP -= Math.round(player.maxOverHP() * 0.5);
		if (!player.hasPerk(PerkLib.EndlessRage)) player.addStatusValue(StatusEffects.Berzerking, 1, -2);
		player.addStatusValue(StatusEffects.Berzerking, 2, 1);
		enemyAI();
	}
	public function berzerkG3():void {
		clearOutput();
		outputText("Placeholder text that only meantion savage fury reaching Grade 3."+(player.hasPerk(PerkLib.Anger)?" +1 large/massive weapon atk.":"")+" - 50% max over HP.\n\n");
		player.HP -= Math.round(player.maxOverHP() * 0.5);
		if (!player.hasPerk(PerkLib.EndlessRage)) player.addStatusValue(StatusEffects.Berzerking, 1, -2);
		player.addStatusValue(StatusEffects.Berzerking, 2, 1);
		enemyAI();
	}
	public function berzerkG4():void {
		clearOutput();
		outputText("Placeholder text that only meantion savage fury reaching Grade 4. +1 large/massive weapon atk. - 50% max over HP.\n\n");
		player.HP -= Math.round(player.maxOverHP() * 0.5);
		if (!player.hasPerk(PerkLib.EndlessRage)) player.addStatusValue(StatusEffects.Berzerking, 1, -2);
		player.addStatusValue(StatusEffects.Berzerking, 2, 1);
		enemyAI();
	}

	public function bloodFrenzy():void {
		clearOutput();
		var MultiplierBonus:Number = 0.5;
		if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 3) MultiplierBonus += 1.5;
		outputText("You inhale deeply the smell of running blood in the air, mouth");
		if(!player.isHerm()) outputText(" and");
		else outputText(",");
		if(player.hasCock()) outputText(" cock");
		if(player.isHerm()) outputText(" and");
		if(player.hasVagina()) outputText(" vagina");
		outputText(" drooling as you let go of your ability to reason and lose yourself, sinking into a blood driven frenzy!\n\n");
		player.buff("Blood Frenzy").setStats({'spe.mult':Math.round(player.speStat.mult.value*MultiplierBonus),'int.mult':-Math.round(player.intStat.mult.value),'lib.mult':Math.round(player.libStat.mult.value*MultiplierBonus)}).combatPermanent();
		enemyAI();
	}

	public function lustzerk():void {
		clearOutput();
		player.wrath -= 50;
		var lustzerkDuration:Number = 10;
		if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 2) lustzerkDuration += 2;
		if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) lustzerkDuration += 8;
		if (player.hasPerk(PerkLib.ColderLust)) {
			outputText("You roar and unleash your lustful fury in order to destroy your foe!\n\n");
		}
		else if (player.hasPerk(PerkLib.ColdLust)) {
			outputText("You roar and unleash your lustful fury, forgetting about defense from magical attacks in order to destroy your foe!\n\n");
		}
		else outputText("You roar and unleash your lustful fury, forgetting about defense from any sexual attacks or magical attacks in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.Lustzerking,lustzerkDuration,0,0,0);
		enemyAI();
	}
	public function lustzerkG2():void {
		clearOutput();
		outputText("Placeholder text that only meantion lusty fury reaching Grade 2."+(player.hasPerk(PerkLib.Anger)?" +1 large/massive weapon atk.":"")+" - 50% max over HP.\n\n");
		player.HP -= Math.round(player.maxOverHP() * 0.5);
		if (!player.hasPerk(PerkLib.EndlessRage)) player.addStatusValue(StatusEffects.Lustzerking, 1, -2);
		player.addStatusValue(StatusEffects.Lustzerking, 2, 1);
		enemyAI();
	}
	public function lustzerkG3():void {
		clearOutput();
		outputText("Placeholder text that only meantion lusty fury reaching Grade 3."+(player.hasPerk(PerkLib.Anger)?" +1 large/massive weapon atk.":"")+" - 50% max over HP.\n\n");
		player.HP -= Math.round(player.maxOverHP() * 0.5);
		if (!player.hasPerk(PerkLib.EndlessRage)) player.addStatusValue(StatusEffects.Lustzerking, 1, -2);
		player.addStatusValue(StatusEffects.Lustzerking, 2, 1);
		enemyAI();
	}
	public function lustzerkG4():void {
		clearOutput();
		outputText("Placeholder text that only meantion lusty fury reaching Grade 4. +1 large/massive weapon atk. - 50% max over HP.\n\n");
		player.HP -= Math.round(player.maxOverHP() * 0.5);
		if (!player.hasPerk(PerkLib.EndlessRage)) player.addStatusValue(StatusEffects.Lustzerking, 1, -2);
		player.addStatusValue(StatusEffects.Lustzerking, 2, 1);
		enemyAI();
	}

	public function blazingBattleSpirit():void {
		clearOutput();
		var blazingBattleSpiritDuration:Number = 10;
		if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 1) blazingBattleSpiritDuration += 1;
		if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 2) blazingBattleSpiritDuration += 2;
		if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 3) blazingBattleSpiritDuration += 7;
		outputText("Your bodily flames begin to rage as you enter a passionate battle fury.\n\n");
		player.createStatusEffect(StatusEffects.BlazingBattleSpirit,blazingBattleSpiritDuration,0,0,0);
		statScreenRefresh();
		enemyAI();
	}

	public function cauterize():void {
		clearOutput();
		player.HP -= player.HP * 0.05;
		outputText("You wince in pain but feel relief as your wounds begin to smoke and close.\n\n");
		player.createStatusEffect(StatusEffects.Cauterize,10,0,0,0);
		statScreenRefresh();
		enemyAI();
	}

	public function WinterClaws():void {
		clearOutput();
		var WinterClawsDuration:Number = 10
		//if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 1) blazingBattleSpiritDuration += 1;
		//if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 2) blazingBattleSpiritDuration += 2;
		//if (player.perkv1(IMutationsLib.HinezumiBurningBloodIM) >= 3) blazingBattleSpiritDuration += 7;
		outputText("Your claws coat themselves with a thick layer of sharp ice.\n\n");
		player.createStatusEffect(StatusEffects.WinterClaw,WinterClawsDuration,0,0,0);
		statScreenRefresh();
		enemyAI();
	}

	public function flameBlade():void {
		clearOutput();
		var flameBladeDuration:Number = 10;
		if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 1) flameBladeDuration += 1;
		if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 2) flameBladeDuration += 2;
		if (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) flameBladeDuration += 7;
		outputText("Your run "+((player.racialScore(Races.KITSHOO) >= 12 && player.tail.type == Tail.KITSHOO)?"one of your tails":"your tail")+" across your weapon igniting it with raging flames.\n\n");
		player.createStatusEffect(StatusEffects.FlameBlade,flameBladeDuration,0,0,0);
		statScreenRefresh();
		enemyAI();
	}

	public function ElectrifyWeapon():void {
		clearOutput();
		var electrifyWeaponDuration:Number = 10;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) electrifyWeaponDuration += 1;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) electrifyWeaponDuration += 2;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) electrifyWeaponDuration += 7;
		outputText("Your lift your weapon toward the sky, drawing bolts of lightning towards it.\n\n");
		player.createStatusEffect(StatusEffects.ElectrifyWeapon,electrifyWeaponDuration,0,0,0);
		statScreenRefresh();
		enemyAI();
	}

	public function warriorsrage():void {
		clearOutput();
		player.wrath -= 50;
		outputText("You roar and unleash your warrior's rage in order to destroy your foe!\n\n");
		warriorsrage007();
		statScreenRefresh();
		enemyAI();
	}
	public function warriorsrage007():void {
		var temp:Number;
		var tempStr:Number;
		var tempTou:Number;
		var tempSpe:Number;
		var warriorsrageDuration:Number = 10;
		var WarriorsRageBoost:Number = 10;
		if (player.hasPerk(PerkLib.JobSwordsman)) WarriorsRageBoost += 15;
		if (player.hasPerk(PerkLib.JobBrawler)) WarriorsRageBoost += 15;
		if (player.hasPerk(PerkLib.Berzerker)) WarriorsRageBoost += 20;
		if (player.hasPerk(PerkLib.Lustzerker)) WarriorsRageBoost += 20;
		if (player.hasPerk(PerkLib.AsuraToughness)) WarriorsRageBoost += 20;
		var oldHPratio:Number = player.hp100/100;
		temp = WarriorsRageBoost;
		tempStr = temp;
		tempTou = temp;
		tempSpe = temp;
		if (player.hasPerk(PerkLib.WayOfTheWarrior)) {
			tempStr += Math.round(player.strStat.core.value * 0.1);
			tempTou += Math.round(player.touStat.core.value * 0.1);
			tempSpe += Math.round(player.speStat.core.value * 0.1);
		}
		if (player.hasPerk(PerkLib.EnchancedWarriorsRage)) {
			tempStr += Math.round(player.strStat.core.value * 0.2);
			tempTou += Math.round(player.touStat.core.value * 0.2);
			tempSpe += Math.round(player.speStat.core.value * 0.2);
		}
		if (player.perkv1(IMutationsLib.HumanMusculatureIM) >= 3 && player.racialScore(Races.HUMAN) > 17) {
			tempStr += Math.round(player.strStat.core.value * 0.1);
			tempTou += Math.round(player.touStat.core.value * 0.1);
			tempSpe += Math.round(player.speStat.core.value * 0.1);
			warriorsrageDuration += 6;
		}
		if (player.hasPerk(PerkLib.AsuraToughness)) {
			tempStr += Math.round(player.strStat.core.value * 0.1);
			tempTou += Math.round(player.touStat.core.value * 0.1);
			tempSpe += Math.round(player.speStat.core.value * 0.1);
		}
		tempStr *= 2;
		mainView.statsView.showStatUp('str');
		mainView.statsView.showStatUp('tou');
		mainView.statsView.showStatUp('spe');
		if (player.hasPerk(PerkLib.BerserkerArmor) || (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 3 && player.racialScore(Races.HUMAN) > 17)) {
			var tempB:Number = 1.5;
			if (player.hasPerk(PerkLib.BerserkerArmor) && player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 3 && player.racialScore(Races.HUMAN) > 17) {
				if (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 4) tempB += 1.5;
				else tempB += 0.5;
			}
			tempStr = tempStr*tempB;
			tempTou = tempTou*tempB;
			tempSpe = tempSpe*tempB;
		}
		if (player.hasPerk(PerkLib.JobWarrior) && player.hasPerk(PerkLib.AsuraToughness)) player.buff("WarriorsRage").addStats({str:tempStr,tou:tempTou,spe:tempSpe}).withText("Warriors Rage").combatPermanent();
		else player.buff("WarriorsRage").addStats({str:tempStr,tou:tempTou,spe:tempSpe}).withText("Warriors Rage").combatTemporary(warriorsrageDuration);
		player.HP = oldHPratio*player.maxHP();
	}

	public function crinosshapeCost():Number {
		var modcsc:Number = 5;
		if (player.hasPerk(PerkLib.ImprovedCrinosShape)) modcsc += 5;
		if (player.hasPerk(PerkLib.GreaterCrinosShape)) modcsc += 10;
		if (player.hasPerk(PerkLib.MasterCrinosShape)) modcsc += 20;
		if (player.hasPerk(PerkLib.JobBeastWarrior) && player.necklaceName == "Crinos Shape necklace") modcsc += 5;
		if (player.perkv1(IMutationsLib.FerasBirthrightIM) >= 2) modcsc = Math.round(modcsc * 0.5);
		return modcsc;
	}
	public function assumeCrinosShape():void {
		clearOutput();
		player.wrath -= crinosshapeCost();
		outputText("You roar and unleash your inner beast assuming Crinos Shape in order to destroy your foe!\n\n");
		assumeCrinosShape007();
		statScreenRefresh();
		enemyAI();
	}
	public function assumeCrinosShape007():void {
		var temp1:Number = 0;
		var temp2:Number = 0;
		var temp3:Number = 0;
		var tempStr:Number;
		var tempTou:Number;
		var tempSpe:Number;
		temp1 += player.strStat.core.value * 0.2;
		temp2 += player.touStat.core.value * 0.2;
		temp3 += player.speStat.core.value * 0.2;
		if (player.hasPerk(PerkLib.ImprovedCrinosShape)) {
			temp1 += player.strStat.core.value * 0.2;
			temp2 += player.touStat.core.value * 0.2;
			temp3 += player.speStat.core.value * 0.2;
		}
		if (player.hasPerk(PerkLib.GreaterCrinosShape)) {
			temp1 += player.strStat.core.value * 0.4;
			temp2 += player.touStat.core.value * 0.4;
			temp3 += player.speStat.core.value * 0.4;
		}
		if (player.hasPerk(PerkLib.MasterCrinosShape)) {
			temp1 += player.strStat.core.value * 0.8;
			temp2 += player.touStat.core.value * 0.8;
			temp3 += player.speStat.core.value * 0.8;
		}
		if (player.hasPerk(PerkLib.JobBeastWarrior) && player.necklaceName == "Crinos Shape necklace") {
			temp1 += player.strStat.core.value * 0.2;
			temp2 += player.touStat.core.value * 0.2;
			temp3 += player.speStat.core.value * 0.2;
		}
		if (player.hasPerk(PerkLib.BerserkerArmor) || (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 3 && player.racialScore(Races.HUMAN) > 17)) {
			var tempB:Number = 1.5;
			if (player.hasPerk(PerkLib.BerserkerArmor) && player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 3 && player.racialScore(Races.HUMAN) > 17) {
				if (player.perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 4) tempB += 1.5;
				else tempB += 0.5;
			}
			temp1 *= tempB;
			temp2 *= tempB;
			temp3 *= tempB;
		}
		if (player.hasPerk(PerkLib.Lycanthropy) && player.racialScore(Races.WEREWOLF) > 11) {
			var tempWW:Number = 1;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) tempWW += 0.01;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) tempWW += 0.02;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) tempWW += 0.03;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) tempWW += 0.04;
			if (tempWW > 1) {
				if (player.racialScore(Races.WEREWOLF) > 15) tempWW *= 2;
				if (player.racialScore(Races.WEREWOLF) > 19) tempWF *= 1.5;
				temp1 *= (tempWW * 10);
				temp2 *= (tempWW * 6);
				temp3 *= (tempWW * 4);
			}
		}
		if (player.hasPerk(PerkLib.Vulpesthropy) && player.racialScore(Races.WEREFOX) > 11) {
			var tempWF:Number = 1;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) tempWF += 0.01;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) tempWF += 0.02;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) tempWF += 0.03;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) tempWF += 0.04;
			if (tempWF > 1) {
				if (player.racialScore(Races.WEREFOX) > 15) tempWF *= 2;
				if (player.racialScore(Races.WEREFOX) > 19) tempWF *= 1.5;
				temp1 *= tempWF;
				temp2 *= (tempWF * 10);
				temp3 *= (tempWF * 4);
			}
		}
		temp1 = Math.round(temp1);
		temp2 = Math.round(temp2);
		temp3 = Math.round(temp3);
		var oldHPratio:Number = player.hp100/100;
		tempStr = temp1;
		tempTou = temp2;
		tempSpe = temp3;
		mainView.statsView.showStatUp('str');
		mainView.statsView.showStatUp('tou');
		mainView.statsView.showStatUp('spe');
		player.buff("CrinosShape").addStats({str:tempStr,tou:tempTou,spe:tempSpe}).withText("Crinos Shape").combatPermanent();
		player.HP = oldHPratio*player.maxHP();
	}
	public function returnToNormalShape():void {
		clearOutput();
		outputText("Gathering all you willpower you forcefully subduing your inner beast and returning to your normal shape.");
		player.statStore.removeBuffs("CrinosShape");
		enemyAI();
	}

	public function activaterTyrantState():void {
		clearOutput();
		outputText("You stare at your foe, letting your Lust build and bubble within you. Sweet release is in front of you…But first… You feel the heat building in your loins, and you let out a roar, the heat spreading through your body. You face your opponent with an unsettling grin. Let’s Dance!\n\n");
		player.createStatusEffect(StatusEffects.TyrantState, 0, 0, 0, 0);
		enemyAI();
	}
	public function deactivaterTyrantState():void {
		clearOutput();
		outputText("Breathing heavily, you focus your mind. The heat through your body isn’t going away yet, but at the very least, you aren’t generating more. With a lot of mental effort, you reign in your lusty thoughts.\n\n");
		player.removeStatusEffect(StatusEffects.TyrantState);
		enemyAI();
	}
	public function activaterFalseWeapon():void {
		clearOutput();
		fatigue(100, USEFATG_PHYSICAL);
		player.lust -= Math.round(player.maxLust() * 0.1);
		outputText("You focus on the heat in your body, and with your mind focused, you send your heat down, into the ground. The ground cracks under your [legs], and from the crack emerges a stone, shaped nearly perfectly into the shape of your [weapon].\n\n");
		player.createStatusEffect(StatusEffects.FalseWeapon, 0, 0, 0, 0);
		enemyAI();
	}
	
	public function lightupFoxflamePelt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		lightupFoxflamePelt2();
	}
	public function lightupFoxflamePelt2():void {
		useMana((100 * kitsuneskill2Cost()), Combat.USEMANA_MAGIC_NOBM);
		outputText("Holding out your palm, you conjure fox flame that dances across your fingertips.  Then is spread all over your arm to rest of your body!\n\n");
		var temp1:Number = 0;
		var tempSpe:Number;
		temp1 += player.speStat.core.value * 0.1;
		if (player.tailCount >= 7) temp1 += player.speStat.core.value * 0.1 * (player.tailCount - 6);
		temp1 = Math.round(temp1);
		var oldHPratio:Number = player.hp100/100;
		tempSpe = temp1;
		mainView.statsView.showStatUp('spe');
		player.buff("FoxflamePelt").addStats({spe:tempSpe}).withText("Foxflame Pelt").combatPermanent();
		player.HP = oldHPratio*player.maxHP();
		statScreenRefresh();
		enemyAI();
	}
	public function extinguishFoxflamePelt():void {
		clearOutput();
		outputText("Gathering you willpower you forcefully extinguish flames coating your body.");
		player.statStore.removeBuffs("FoxflamePelt");
		enemyAI();
	}

	public function EverywhereAndNowhere():void {
		clearOutput();
		fatigue(30, USEFATG_PHYSICAL);
		outputText("You smirk as you start to phase in and out of existence. Good luck to whoever going to try and hit you because they will have to try extra hard.\n\n");
		player.createStatusEffect(StatusEffects.EverywhereAndNowhere,6,0,0,0);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.EverywhereAndNowhere,9,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownEveryAndNowhere,10,0,0,0);
		enemyAI();
	}

	public function Displacement():void {
		clearOutput();
		fatigue(30, USEFATG_PHYSICAL);
		outputText("You begin teleporting at high speed in order to avoid your opponents strikes.\n\n");
		player.createStatusEffect(StatusEffects.Displacement,6,0,0,0);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownDisplacement,9,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownDisplacement,10,0,0,0);
		enemyAI();
	}

	public function Prank():void {
		clearOutput();
		outputText("You prank [themonster] surprising [monster him]. This causes your opponent to temporarily stop what [monster he] was doing for a second, realising too late this was your plan all along.\n\n");
		monster.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownPrank,3,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownPrank,4,0,0,0);
		enemyAI();
	}

	public function KnowledgeOverload():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(80, Combat.USEMANA_MAGIC);
		var KOCD:Number = 12;
		if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 2) KOCD -= 1;
		if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) KOCD -= 1;
		if (player.hasPerk(PerkLib.NaturalInstincts)) KOCD -= 1;
		player.createStatusEffect(StatusEffects.CooldownKnowledgeOverload,KOCD,0,0,0);
		outputText("You share some of your well earned knowledge with [themonster] who stands there blankly listening to your spiel in confusion. It's going to take [monster him] a moment to come down from the absurd amount of info you forced into [monster his] tiny head"+(monster.plural?"s":"")+".\n\n");
		var overloadduration:Number = 0;
		overloadduration += Math.round(camp.codex.checkUnlocked() / 10);
		monster.createStatusEffect(StatusEffects.Stunned, overloadduration, 0, 0, 0);
		enemyAI();
	}

	public function Provoke():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(80, Combat.USEMANA_MAGIC);
		var PCD:Number = 6;
		if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) PCD -= 1;
		if (player.hasPerk(PerkLib.NaturalInstincts)) PCD -= 1;
		player.createStatusEffect(StatusEffects.CooldownProvoke,PCD,0,0,0);
		outputText("You start out right away with the classic introduction of \"<i>You know, there's a rumor about you, it says that…</i>\" sharing with [themonster] the nastiest rumors about [monster him]. In disbelief and absolute rage [monster he] attacks relentlessly in an effort to shut you up. ");
		outputText("Geeze how susceptible, at least it dropped all forms of defence, throwing caution to the wind to attempt to beat the hell out of you.\n\n");
		var armordebuff:Number = monster.armorDef;
		var provokeornah:Number = 1.2;
		monster.armorDef -= armordebuff;
		provokeornah += Math.round(camp.codex.checkUnlocked() / 100);
		monster.createStatusEffect(StatusEffects.Provoke, 3, provokeornah, armordebuff, 0);
		enemyAI();
	}

	public function WeirdWords():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(80, Combat.USEMANA_MAGIC);
		combat.darkRitualCheckDamage();
		var WWCD:Number = 4;
		if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) WWCD -= 1;
		if (player.hasPerk(PerkLib.NaturalInstincts)) WWCD -= 1;
		player.createStatusEffect(StatusEffects.CooldownWeirdWords,WWCD,0,0,0);
		var damage:Number = scalingBonusIntelligence() * spellMod() * 4;
		damage *= 1 + (camp.codex.checkUnlocked() * 0.01);
		if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 2) damage *= 1.2;
		if (player.perkv1(IMutationsLib.RatatoskrSmartsIM) >= 3) damage *= 1.25;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText("You purposely utter a sentence so weird and messed up [themonster] grabs [monster his] head with both hands in pain. Ouch, that’s what one calls harmful information. ");
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		enemyAI();
	}

	public function MoneyStrike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		var damage:Number = (scalingBonusIntelligence() * spellMod());
		var moneyMultiplier:Number = 1+(player.gems/100000);
		if (moneyMultiplier > 2) moneyMultiplier = 2;
		damage *= moneyMultiplier;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//High damage to goes.
		if (player.hasPerk(PerkLib.TravelingMerchantOutfit)) damage *= 1.50;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage += player.gems;
		if (player.perkv1(IMutationsLib.NukiNutsIM) >= 3) damage *= 2;
		damage = Math.round(damage);
		outputText("You grab some of your gems imbuing your Tanuki golden magics in them before throwing them at your foe, the gems your makeshift projectiles exploding upon impact.");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if (silly()) {
			if (monster.plural)	outputText("Adding insult to injury you scream at your opponent. \"Go buy yourself some friend you losers!\"\n\n");
			else outputText("Adding insult to injury you scream at your opponent. \"Go buy yourself some friend you loser!\"\n\n");
		}
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (player.gems * 0.99 <= 100) player.gems -= 100;
		else player.gems *= 0.99;
		if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
			outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
		enemyAI();
	}

	public function Minimise():void {
		clearOutput();
		useMana(50, Combat.USEMANA_MAGIC);
		var evasionIncrease:Number = 0;
		if (player.hasPerk(PerkLib.FairyQueenRegalia)) evasionIncrease = 25;
		outputText("You shrink to your minimum size, evading your opponent as you mock [monster his] attempt to hit you.\n\n");
		player.createStatusEffect(StatusEffects.Minimise,50+evasionIncrease,0,0,0);
		player.buff("Minimise").addStats({"str":-50}).withText("Minimise").combatPermanent();
		enemyAI();
	}

	public function Enlarge():void {
		clearOutput();
		useMana(40, Combat.USEMANA_MAGIC);
		outputText("You grow back to your normal size.\n\n");
		player.buff("Minimise").remove();
		player.removeStatusEffect(StatusEffects.Minimise);
		enemyAI();
	}

	public function Flicker():void {
		clearOutput();
		useMana(40, Combat.USEMANA_MAGIC);
		outputText("Your form shimmers for a second as you vanish into thin air. Your opponent starts looking for you, annoyed.\n\n");
		var DurationIncrease:Number = 0;
		if (player.hasPerk(PerkLib.FairyQueenRegalia)) DurationIncrease = 1;
		monster.createStatusEffect(StatusEffects.InvisibleOrStealth,2+DurationIncrease,0,0,0);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownFlicker, 3, 0, 0, 0);
		else player.createStatusEffect(StatusEffects.CooldownFlicker,4,0,0,0);
		enemyAI();
	}

	public function TacticalDistraction():void {
		clearOutput();
		outputText("You give [themonster] a belly dance show, moving your hip from a side to another and displaying your assets. [Themonster] is so distracted by your dancing it doesn’t realise the two of you are still in battle for a few seconds before snapping out only in time to realise [monster he] did absolutely nothing for the last six seconds. ");
		var lustDmg:Number = (5 + rand(5));
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg);
		outputText(" \n\n");
		monster.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownTDistraction,4,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownTDistraction,5,0,0,0);
		enemyAI();
	}

	public function NagaHypnosis():void {
		clearOutput();
		var hypnosisDuration:Number = 5;
		if (player.armorName == "desert naga pink and black silk dress") hypnosisDuration += 1;
		if (player.headjewelryName == "pair of Golden Naga Hairpins") hypnosisDuration += 1;
		outputText("You give [themonster] a sexy belly dance show, moving your hip from a side to another and displaying your assets as you insidiously mesmerise it into laying down [monster his] guard, all the while maintaining eye contact. [Themonster] is completely captivated by your dancing.");
		monster.createStatusEffect(StatusEffects.HypnosisNaga,hypnosisDuration,0,0,0);
		enemyAI();
	}

	public function maleficium():void {
		clearOutput();
		player.lust += 50;
		var maleficiumDuration:Number = 10;
		if (player.perkv1(IMutationsLib.ObsidianHeartIM) >= 2) maleficiumDuration += 5;
		outputText("You moan in delight as your body fills with profane powers, empowering your spells and making you blush with barely contained desire.\n\n");
		if (player.cor < 60 && player.perkv1(IMutationsLib.ObsidianHeartIM) >= 1) dynStats("cor", 0.3);
		player.createStatusEffect(StatusEffects.Maleficium,maleficiumDuration,0,0,0);
		enemyAI();
	}

	public function infernalflare():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.perkv1(IMutationsLib.ObsidianHeartIM) >= 3) useMana(50, Combat.USEMANA_MAGIC);
		else useMana(40, Combat.USEMANA_MAGIC);
		combat.darkRitualCheckDamage();
		if (player.cor < 60 && player.perkv1(IMutationsLib.ObsidianHeartIM) >= 1) dynStats("cor", 0.3);
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your attack touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your attack!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You grin malevolently and weave an arcane sign, causing an infernal fire to surge from below and scorching your opponent ");
		var damage:Number = scalingBonusIntelligence() * 3.2;
		if (player.perkv1(IMutationsLib.ObsidianHeartIM) >= 2) damage += scalingBonusIntelligence() * 0.8;
		if (player.perkv1(IMutationsLib.ObsidianHeartIM) >= 3) damage += scalingBonusIntelligence() * 1.6;
		damage *= spellMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (player.perkv1(IMutationsLib.ObsidianHeartIM) >= 3) critChance += 20;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = combat.monsterCorruptDamageBonus(damage);
		//High damage to goes.
		damage = calcInfernoMod(damage, true);
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.countMiscJewelry(miscjewelries.DMAGETO) > 0) damage *= 1.25;
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		outputText("for ");
		doFireDamage(damage, true, true);
		outputText(" damage.");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
	//	if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
	//	spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP())
		{
			doNext(endHpVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}

	public function greenCovenant():void {
		outputText("You direct your desire to the nearby plants causing them to surge and wrap around you as a tendril gently wraps itself around your left leg, embracing your form like a lover, before "+(player.hasVagina()?"plunging within your welcoming elven nether lips. A second one ":"it ")+"");
		outputText("finds the hole to your pucker plugging it perfectly as embery sap flows directly from the plants into your core. Now one with the nearby corrupted vegetation you overflow with magical might as the plants literally pump their power directly into you.\n");
		player.createStatusEffect(StatusEffects.CooldownGreenCovenant, 12, 0, 0, 0);
		player.createStatusEffect(StatusEffects.GreenCovenant, 0, 0, 0, 0);
		enemyAI();
	}

	public function perfectclarity():void {
		clearOutput();
		player.lust += 50;
		var clarityDuration:Number = 10;
		if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 2) clarityDuration += 5;
		outputText("You gasp as your body fills with holy powers, empowering your spells but making you feel more fragile.\n\n");
		//if (player.cor < 60 && player.perkv1(IMutationsLib.DiamondHeartIM) >= 1) dynStats("cor", 0.3);
		player.createStatusEffect(StatusEffects.PerfectClarity,clarityDuration,0,0,0);
		enemyAI();
	}

	public function judgementflare():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 3) useMana(50, Combat.USEMANA_MAGIC);
		else useMana(40, Combat.USEMANA_MAGIC);
		combat.darkRitualCheckDamage();
		//if (player.cor < 60 && player.perkv1(IMutationsLib.ObsidianHeartIM) >= 1) dynStats("cor", 0.3);
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your attack touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your attack!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You concentrate and weave an arcane sign, causing a holy fire to surge from below and scorching your opponent ");
		var damage:Number = scalingBonusIntelligence() * 3.2;
		if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 2) damage += scalingBonusIntelligence() * 0.8;
		if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 3) damage += scalingBonusIntelligence() * 1.6;
		damage *= spellMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 3) critChance += 20;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = combat.monsterPureDamageBonus(damage);
		//High damage to goes.
		damage = calcInfernoMod(damage, true);
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.countMiscJewelry(miscjewelries.DMAGETO) > 0) damage *= 1.25;
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		outputText("for ");
		doFireDamage(damage, true, true);
		outputText(" damage.");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
	//	if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
	//	spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP())
		{
			doNext(endHpVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}

	public function exorcism():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.perkv1(IMutationsLib.DiamondHeartIM) >= 3) useMana(100, Combat.USEMANA_MAGIC);
		else useMana(80, Combat.USEMANA_MAGIC);
		//if (player.cor < 60 && player.perkv1(IMutationsLib.ObsidianHeartIM) >= 1) dynStats("cor", 0.3);
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your attack touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your attack!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You smite [themonster] by drawing on [monster his] inner corruption and igniting it like a match in an oil barrel. [Themonster] wails in pain as you deliver the devastating blow, [monster his] body shining as it is burnt from the inside by [monster his] own corruption. Repent sinner!");
		var damage:Number = ((monster.maxHP()-monster.minHP()) * ((monster.cor / 2) / 100) / 2);
		//Deal damage to any creature above 25% corruption for 50% for a percentage of hit point equal to half its corruption percentage
		if (monster.cor < 25) {
			damage = 0;
			outputText(", but unfortunately for you, the attack has no effect on [themonster] as it is not corrupt enough!")
		}
		player.createStatusEffect(StatusEffects.Exorcism, 0, 0, 0, 0);

		if (damage > 0) {
			outputText("for ");
			doDamage(damage, true, true);
			outputText(" damage.");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
	//	if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
	//	spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP())
		{
			doNext(endHpVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}

	public function petrify(enhanced:Boolean = false):void {
		clearOutput();
		var petrifycost:Number = 100;
		if (enhanced) petrifycost *= 10;
		var petrifyduration:Number = 1;
		fatigue(petrifycost, USEFATG_MAGIC_NOBM);
		if(monster.plural) {
			outputText("With a moment of concentration you activating petrifying properties of your gaze");
			if (player.hairType == Hair.GORGON) outputText(" and awaken normaly dormant snake hair that starts to hiss");
			outputText(" and then casual glance at enemies. Due to many of them your petrifying power spread on too many targets to be much effective. Still few of them petrified for a short moment and rest scared or suprised by such turn of events also refrain from attacking you for a moment.\n\n");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
				if (enhanced) {
					petrifyduration += 1;
					if (player.hairType == Hair.GORGON) petrifyduration += 1;
				}
				else {
					if (player.perkv1(IMutationsLib.GorgonEyesIM) >= 2) petrifyduration += 1;
					if (player.perkv1(IMutationsLib.GorgonEyesIM) >= 3) {
						petrifyduration += 1;
						if (player.hairType == Hair.GORGON) petrifyduration += 1;
					}
					if (player.perkv1(IMutationsLib.GorgonEyesIM) >= 4) {
						petrifyduration += 1;
						if (player.hairType == Hair.GORGON) petrifyduration += 1;
					}
				}
				monster.createStatusEffect(StatusEffects.Stunned, petrifyduration, 0, 0, 0);
			}
		}
		else {
			outputText("With a moment of concentration you activating petrifying properties of your gaze");
			if (player.hairType == Hair.GORGON) outputText(" and awaken normaly dormant snake hair that starts to hiss");
			outputText(" and then casual glance at enemy. Caught off guard [themonster] petrify.\n\n");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
				petrifyduration += 1;
				if (enhanced) {
					petrifyduration += 2;
					if (player.hairType == Hair.GORGON) petrifyduration += 2;
				}
				else {
					if (player.perkv1(IMutationsLib.GorgonEyesIM) >= 2) petrifyduration += 1;
					if (player.perkv1(IMutationsLib.GorgonEyesIM) == 3) {
						petrifyduration += 1;
						if (player.hairType == Hair.GORGON) petrifyduration += Math.round(player.perkv1(IMutationsLib.GorgonEyesIM) * 0.5);
					}
					if (player.perkv1(IMutationsLib.GorgonEyesIM) == 4) {
						petrifyduration += 2;
						if (player.hairType == Hair.GORGON) petrifyduration += player.perkv1(IMutationsLib.GorgonEyesIM);
					}
				}
				monster.createStatusEffect(StatusEffects.Stunned, petrifyduration, 0, 0, 0);
				monster.createStatusEffect(StatusEffects.RegenInhibitorPetrify, petrifyduration, 0, 0, 0);
			}
		}
		enemyAI();
	}

	public function manaShot():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		doNext(combatMenu);
		useMana((40*arigeanMagicSpecialsCost()), Combat.USEMANA_MAGIC);
		combat.darkRitualCheckDamage();
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your attack touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your attack!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownManaShot,2,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownManaShot, 3, 0, 0, 0);
		outputText("You focus your eyes upon your target and fire a single blast from " + (player.tailCount > 1?"one of your extra maws":"your large extra mouth") + ". ");
		if (40 + rand(player.spe) > monster.spe) {
			var damage:Number = scalingBonusStrength() * 2;
			damage *= spellMod();
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combatMagicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			//High damage to goes.
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			if (player.armor == armors.ANE_UNI) damage *= 1.2;
			if (player.armor == armors.P_REGAL) damage *= 1.5;
			if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 1) damage *= arigeanAssociationCortexBoost();
			damage = Math.round(damage);
			outputText("It hits its mark dealing ");
			doMagicDamage(damage, true, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			outputText(" damage!\n\n");
			if (player.armor == armors.P_REGAL) HPChange(Math.round(damage*0.15), true);
			checkAchievementDamage(damage);
			combat.heroBaneProc(damage);
			statScreenRefresh();
		}
		else outputText("Your target evades out of the way causing the shot to go wide.\n\n");
		if (monster.HP <= monster.minHP())
		{
			doNext(endHpVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}
	public function manaBarrage():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		doNext(combatMenu);
		useMana((200*arigeanMagicSpecialsCost()), Combat.USEMANA_MAGIC);
		combat.darkRitualCheckDamage();
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your attack touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your attack!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownManaBarrage,2,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownManaBarrage, 3, 0, 0, 0);
		outputText("You focus your eyes upon your target and fire a barrage of blasts from your extra maw" + (player.tailCount > 1?"s":"") + ". ");
		if (40 + rand(player.spe) > monster.spe) {
			var damage:Number = scalingBonusStrength() * 2;
			damage *= spellMod();
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combatMagicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			//High damage to goes.
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			if (player.armor == armors.ANE_UNI) damage *= 1.2;
			if (player.armor == armors.P_REGAL) damage *= 1.5;
			if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 1) damage *= arigeanAssociationCortexBoost();
			damage = Math.round(damage);
			outputText("Your target is unable to avoid the barrage of blasts and takes ");
			doMagicDamage(damage, true, true);
			doMagicDamage(damage, true, true);
			doMagicDamage(damage, true, true);
			doMagicDamage(damage, true, true);
			doMagicDamage(damage, true, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			outputText(" damage!\n\n");
			damage *= 5;
			if (player.armor == armors.P_REGAL) HPChange(Math.round(damage*0.15), true);
			checkAchievementDamage(damage);
			combat.heroBaneProc(damage);
			statScreenRefresh();
		}
		else outputText("Your target evades out of the way causing the barrage to go wide.\n\n");
		if (monster.HP <= monster.minHP())
		{
			doNext(endHpVictory);
		}
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}
	public function arigeanChargedShot():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You release the built up energy into a powerful combination of shots towards your target with a yell! The combined shots hit dealing ");
			var damage:Number = scalingBonusStrength() * 2;
			damage *= spellMod();
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combatMagicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			//High damage to goes.
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			if (player.armor == armors.ANE_UNI) damage *= 1.2;
			if (player.armor == armors.P_REGAL) damage *= 1.5;
			if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 1) damage *= arigeanAssociationCortexBoost();
			damage *= 20;
			damage = Math.round(damage);
			doMagicDamage(damage, true, true);
			if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownChargedShot,3,0,0,0);
			else player.createStatusEffect(StatusEffects.CooldownChargedShot,4,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			outputText(" damage!\n\n");
			if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
				enemyAI();
			}
			else enemyAI();
		}
		else {
			useMana((400*arigeanMagicSpecialsCost()), Combat.USEMANA_MAGIC);
			combat.darkRitualCheckDamage();
			clearOutput();
			outputText("You begin charging your extra mouth in preparation for a heavy attack.\n\n");
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 8, 0, 0, 0);
			enemyAI();
		}
	}
	public function arigeanFinalityBarrage():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownFinalityBarrage,9,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownFinalityBarrage,10,0,0,0);
		outputText("You let loose a blood curdling yell, driving all the force you can into your maw for a overcharged blast of raw uncontrolled mana, scorching your insides as well as the foe in front of you! ");
		if (player.hasStatusEffect(StatusEffects.DarkRitual)) {
			HPChange(-Math.round(player.maxHP() * 0.7), true);
			monster.HP -= Math.round(monster.maxHP() * 0.9);
		}
		else {
			HPChange(-Math.round(player.maxHP() * 0.6), true);
			monster.HP -= Math.round(monster.maxHP() * 0.3);
		}
		enemyAI();
	}
	private function arigeanAssociationCortexBoost():Number {
		var aACB:Number = 1.2;
		if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 2) aACB += 0.3;
		if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 3) aACB += 0.4;
		return aACB;
	}
	private function arigeanMagicSpecialsCost():Number {
		var aMSC:Number = 1;
		if (player.armor == armors.ANE_UNI) aMSC -= 0.2;
		if (player.armor == armors.P_REGAL) aMSC -= 0.5;
		if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 2) aMSC -= 0.2;
		if (player.perkv1(IMutationsLib.ArigeanAssociationCortexIM) >= 3) aMSC -= 0.1;
		if (aMSC < 0.1) aMSC = 0.1;
		return aMSC;
	}

	public function hydraAcidBreath():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your breath touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The acid courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownHydraAcidBreath,7,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownHydraAcidBreath, 8, 0, 0, 0);
		outputText("You move your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " Hydra heads in an attack formation, belching acid at [themonster]. Your acid begins to eat at your opponents natural defences. ");
		for (var i:int = player.statusEffectv1(StatusEffects.HydraTailsPlayer); i > 0; i--) {
			hydraAcidBreathWeaponD(i == player.statusEffectv1(StatusEffects.HydraTailsPlayer));
		}
		outputText("\n\n");
		combat.heroBaneProc2();
		checkLethiceAndCombatRoundOver();
	}
	//Only increase Acid damage counter the first time per attack
	public function hydraAcidBreathWeaponD(incAcidCounter:Boolean = true):void {
		var damage:Number = 0;
		damage += combat.unarmedAttack();
		damage += player.tou;
		damage += scalingBonusToughness();// * 0.5
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = calcCorrosionMod(damage, incAcidCounter);
		damage = Math.round(damage);
		doAcidDamage(damage, true, true);
		if (monster.hasStatusEffect(StatusEffects.AcidDoT)) monster.addStatusValue(StatusEffects.AcidDoT, 4, 1); //More heads will produce more potent acid
		else monster.createStatusEffect(StatusEffects.AcidDoT, 6, 0, 0, 1);
		checkAchievementDamage(damage);
		if (player.hasStatusEffect(StatusEffects.HeroBane)) flags[kFLAGS.HERO_BANE_DAMAGE_BANK] += damage;
	}

	//(Ghost Fire)
	public function nekomataGhostFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		if (player.tailCount == 2 && player.tailType == Tail.CAT) soulforcecost *= 2;
		player.soulforce -= soulforcecost;
		nekomataGhostFire2();
	}
	public function nekomataGhostFire2():void {
		if (player.tailCount == 2 && player.tailType == Tail.CAT) useMana((80), Combat.USEMANA_MAGIC_NOBM);
		else useMana((40), Combat.USEMANA_MAGIC_NOBM);
		combat.darkRitualCheckDamage();
		outputText("Holding out your palm, you conjure ghastly greenish flame that dances across your fingertips.  You launch it at [themonster] with a ferocious throw, and it bursts on impact, showering dazzling emerald sparks everywhere.  ");
		var damage:Number = (scalingBonusWisdom() * 0.6) + (scalingBonusIntelligence() * 0.4);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = calcInfernoMod(damage, true);
		damage = calcEclypseMod(damage, true);
		//damage *= 1.25;
		if (player.tailType == 8 && player.tailCount == 2) damage *= 0.5;
		else damage *= 0.2;
		var nekomatasfiredmgmulti:Number = 1;
		nekomatasfiredmgmulti += spellMod() - 1;
		nekomatasfiredmgmulti += soulskillMagicalMod() - 1;
		//Bonus damage
		//jakieś bonusy do obrażeń dodawać tu
		damage *= nekomatasfiredmgmulti;
		//High damage to goes.
		if(monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.  ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		damage *= 2;
		if (player.hasPerk(PerkLib.Necromancy)) damage *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * (combat.fireDamageBoostedByDao() + combat.darknessDamageBoostedByDao() - 1));
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + soulskillMagicalMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText("[Themonster]'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		mosterTeaseText();
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		lustDmg *= 0.1;
		//ew. bonusy do lust dmg tutaj
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg);
		outputText(" ");
		doFireDamage(damage, true, true);
		doDarknessDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		}
	}
	//(Basic Fox Fire)
	public function basicFoxFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (!player.statStore.hasBuff("FoxflamePelt")) {
			var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
			player.soulforce -= soulforcecost;
		}
		basicFoxFire2();
	}
	public function basicFoxFire2():void {
		if (!player.statStore.hasBuff("FoxflamePelt")) useMana((60 * kitsuneskillCost()), Combat.USEMANA_MAGIC_NOBM);
		combat.darkRitualCheckDamage();
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		outputText("Holding out your palm, you conjure fox flame that dances across your fingertips.  You launch it at [themonster] with a ferocious throw, and it bursts on impact, showering dazzling sparks everywhere.  ");
		var damage:Number = (scalingBonusWisdom() * 0.5) + (scalingBonusIntelligence() * 0.3);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = calcInfernoMod(damage, true);
		damage *= 0.25;
		var basicfoxfiredmgmulti:Number = 1;
		basicfoxfiredmgmulti += spellMod() - 1;
		basicfoxfiredmgmulti += soulskillMagicalMod() - 1;
		if (player.shieldName == "spirit focus") basicfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono" || player.armorName == "black kimono") basicfoxfiredmgmulti += .2;
		if (player.headjewelryName == "fox hairpin") basicfoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) basicfoxfiredmgmulti += .5;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) basicfoxfiredmgmulti += 1.5;
		if (player.hasPerk(PerkLib.StarSphereMastery)) basicfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) basicfoxfiredmgmulti += .5;
		//Hosohi No Tama and bonus damage
		if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2) basicfoxfiredmgmulti += 1;
		damage *= basicfoxfiredmgmulti;
		//High damage to goes.
		if(monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.  ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		damage *= 4;
		damage = Math.round(damage);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 12 + player.wis / 8) * ((spellMod() + soulskillMagicalMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText("[Themonster]'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		mosterTeaseText();
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		lustDmg *= 0.25;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.headjewelryName == "fox hairpin") lustDmg *= 1.2;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) lustDmg *= 2.5;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) lustDmg *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg);
		outputText(" ");
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		doFireDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		}
	}
	//Corrupted Fox Fire
	public function corruptedFoxFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 40 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		corruptedFoxFire2();
	}
	public function corruptedFoxFire2():void {
		useMana((80 * kitsuneskillCost()), Combat.USEMANA_MAGIC_NOBM);
		combat.darkRitualCheckDamage();
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Deals direct damage and lust regardless of enemy defenses.  Especially effective against non-corrupted targets.
		outputText("Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You launch it at [themonster] with a ferocious throw, and it bursts on impact, showering dazzling lavender sparks everywhere.  ");
		var damage:Number = (scalingBonusWisdom() * 0.6) + (scalingBonusIntelligence() * 0.4);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = calcInfernoMod(damage, true);
		damage *= 0.125;
		if (player.hasPerk(PerkLib.CorruptedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) damage *= 0.5;
		var corruptedfoxfiredmgmulti:Number = 1;
		corruptedfoxfiredmgmulti += spellMod() - 1;
		corruptedfoxfiredmgmulti += soulskillMagicalMod() - 1;
		if (player.shieldName == "spirit focus") corruptedfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono" || player.armorName == "black kimono") corruptedfoxfiredmgmulti += .2;
		if (player.headjewelryName == "fox hairpin") corruptedfoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) corruptedfoxfiredmgmulti += .5;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) corruptedfoxfiredmgmulti += 1.5;
		if (player.hasPerk(PerkLib.StarSphereMastery)) corruptedfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) corruptedfoxfiredmgmulti += .25;
		//Hosohi No Tama bonus damage
		if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2 && player.tailType == Tail.FOX && player.tailCount == 9) corruptedfoxfiredmgmulti += .5;
		damage *= corruptedfoxfiredmgmulti;
		damage = combat.monsterCorruptDamageBonus(damage);
		//High damage to goes.
		if(monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.  ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (player.headjewelryName == "fox hairpin") damage *= 1.2;
		damage *= 4;
		damage = Math.round(damage);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 12 + player.wis / 8) * ((spellMod() + soulskillMagicalMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText("[Themonster]'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		mosterTeaseText();
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		lustDmg *= 0.5;
		if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 2;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.tailType == Tail.FOX && player.tailCount == 9)  lustDmg *= 1.2;
		if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2 && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.headjewelryName == "fox hairpin") lustDmg *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg);
		outputText(" ");
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		doFireDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
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
		useMana((200 * kitsuneskillCost()), Combat.USEMANA_MAGIC_NOBM);
		combat.darkRitualCheckDamage();
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		outputText("Holding out your palms, you conjure an ethereal blue on one palm and corrupted purple flame on other which dances across your fingertips.  After well practised move of fusing them both into one of mixed colors ball of fire you launch it at [themonster] with a ferocious throw, and it bursts on impact, showering dazzling azure and lavender sparks everywhere.  ");
		var damage:Number = (scalingBonusWisdom() * 1.5) + scalingBonusIntelligence();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = calcInfernoMod(damage, true);
		damage *= 0.5;
		if (player.tailType == Tail.FOX && player.tailCount == 9) damage *= 2;
		var fusedfoxfiredmgmulti:Number = 1;
		fusedfoxfiredmgmulti += spellMod() - 1;
		fusedfoxfiredmgmulti += soulskillMagicalMod() - 1;
		if (player.shieldName == "spirit focus") fusedfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono" || player.armorName == "black kimono") fusedfoxfiredmgmulti += .2;
		if (player.headjewelryName == "fox hairpin") fusedfoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) fusedfoxfiredmgmulti += .5;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) fusedfoxfiredmgmulti += 1.5;
		if (player.hasPerk(PerkLib.StarSphereMastery)) fusedfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) fusedfoxfiredmgmulti += .5;
		//Hosohi No Tama and Fusion bonus damage
		if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2 && player.tailType == Tail.FOX && player.tailCount == 9) fusedfoxfiredmgmulti += 1;
		damage *= fusedfoxfiredmgmulti;
		damage = Math.round(damage * 2);
		//High damage to goes.
		if(monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.  ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		damage *= 4;
		damage = Math.round(damage);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 11 + player.wis / 7) * ((spellMod() + soulskillMagicalMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText("[Themonster]'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		mosterTeaseText();
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		lustDmg *= 0.5;
		if (player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 2.8;
		if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2 && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.headjewelryName == "fox hairpin") lustDmg *= 1.2;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) lustDmg *= 2.5;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) lustDmg *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg);
		outputText(" ");
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		doFireDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		}
	}
	//Pure Fox Fire
	public function pureFoxFire():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = Math.floor(40 * soulskillCost() * soulskillcostmulti());
		player.soulforce -= soulforcecost;
		pureFoxFire2();
	}
	public function pureFoxFire2():void {
		useMana((80 * kitsuneskillCost()), Combat.USEMANA_MAGIC_NOBM);
		combat.darkRitualCheckDamage();
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		outputText("Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You launch it at [themonster] with a ferocious throw, and it bursts on impact, showering dazzling azure sparks everywhere.  ");
		var damage:Number = (scalingBonusIntelligence() * 0.6) + (scalingBonusWisdom() * 0.4);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = calcInfernoMod(damage, true);
		damage *= 0.5;
		if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) damage *= 2;
		var purefoxfiredmgmulti:Number = 1;
		purefoxfiredmgmulti += spellMod() - 1;
		purefoxfiredmgmulti += soulskillMagicalMod() - 1;
		if (player.shieldName == "spirit focus") purefoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono" || player.armorName == "black kimono") purefoxfiredmgmulti += .2;
		if (player.headjewelryName == "fox hairpin") purefoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) purefoxfiredmgmulti += .5;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) purefoxfiredmgmulti += 1.5;
		if (player.hasPerk(PerkLib.StarSphereMastery)) purefoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) purefoxfiredmgmulti += .25;
		//Hosohi No Tama bonus damage
		if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2 && player.tailType == Tail.FOX && player.tailCount == 9) purefoxfiredmgmulti += .5;
		damage *= purefoxfiredmgmulti;
		damage = combat.monsterPureDamageBonus(damage);
		//High damage to goes.
		if(monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy [monster color] skin has lost some of its shimmer.  ");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		damage *= 4;
		damage = Math.round(damage);
		if (monster.lustVuln == 0) {
			outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
		}
		var lustDmg:Number = monster.lustVuln * ((player.inte / 12 + player.wis / 8) * ((spellMod() + soulskillMagicalMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText("[Themonster]'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		mosterTeaseText();
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		lustDmg *= 0.125;
		if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 0.5;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 1.2;
		if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2 && player.tailType == Tail.FOX && player.tailCount == 9) lustDmg *= 1.5;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.headjewelryName == "fox hairpin") lustDmg *= 1.2;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) lustDmg *= 2.5;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) lustDmg *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg);
		outputText(" ");
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		doFireDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		}
	}

	public function kitsuneskillCost():Number {
		var modksc:Number = 1;
		if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 1) modksc -= 0.5;
		if (player.tailCount == 9 && (player.tailType == Tail.FOX || player.tailType == Tail.KITSHOO)) {
			if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 3) modksc *= 3;
			else if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2) modksc *= 2;
			else modksc += 0.5;
		}
		return modksc;
	}
	public function kitsuneskill2Cost():Number {
		var modks2c:Number = 1;
		if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 2) modks2c -= 0.5;
		return modks2c;
	}

	//Terror
	public function kitsuneTerror():void {
		clearOutput();
		//Fatigue Cost: 25
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if(monster is EncapsulationPod || monster.inte == 0) {
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
		var ItemMod:Number = 0;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) ItemMod += 1;
		if (player.hasPerk(PerkLib.NaturalInstincts)) ItemMod += 1;
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) {
			player.createStatusEffect(StatusEffects.CooldownTerror, 5-ItemMod, 0, 0, 0);
			fatigue((200 * kitsuneskill2Cost()), USEFATG_MAGIC_NOBM);
		}
		else if ((player.tailCount == 9 && player.tailType == Tail.FOX) || player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) {
			player.createStatusEffect(StatusEffects.CooldownTerror, 7-ItemMod, 0, 0, 0);
			fatigue((100 * kitsuneskill2Cost()), USEFATG_MAGIC_NOBM);
		}
		else {
			player.createStatusEffect(StatusEffects.CooldownTerror, 9-ItemMod, 0, 0, 0);
			fatigue((50 * kitsuneskill2Cost()), USEFATG_MAGIC_NOBM);
		}
		//Inflicts fear and reduces enemy SPD.
		outputText("The world goes dark, an inky shadow blanketing everything in sight as you fill [themonster]'s mind with visions of otherworldly terror that defy description.  They cower in horror as they succumb to your illusion, believing themselves beset by eldritch horrors beyond their wildest nightmares.\n\n");
		var speedDebuff:Number = 0;
		if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 3) {
			if (monster.spe >= 71) speedDebuff += 70;
			else speedDebuff += 70 - monster.spe;
		}
		else {
			if (monster.spe >= 21) speedDebuff += 20;
			else speedDebuff += 20 - monster.spe;
		}
		if (player.hasPerk(PerkLib.RacialParagon)) speedDebuff *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) speedDebuff *= 1.5;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) speedDebuff *= 2;
		monster.speStat.core.value -= speedDebuff;
		monster.createStatusEffect(StatusEffects.Fear, 2+ItemMod, speedDebuff, 0, 0);
		enemyAI();
	}

	//Illusion
	public function kitsuneIllusion():void {
		clearOutput();
		//Fatigue Cost: 25
		if(monster is EncapsulationPod || monster.inte == 0) {
			outputText("In the tight confines of this pod, there's no use making such an attack!\n\n");
			fatigue(1);
			enemyAI();
			return;
		}
		var soulforcecost:int = Math.floor(20 * soulskillCost() * soulskillcostmulti());
		player.soulforce -= soulforcecost;
		kitsuneIllusion2();
	}
	public function kitsuneIllusion2():void {
		var ItemMod:Number = 0;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) ItemMod += 1;
		if (player.hasPerk(PerkLib.NaturalInstincts)) ItemMod += 1;
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) {
			player.createStatusEffect(StatusEffects.CooldownIllusion,5-ItemMod,0,0,0);
			fatigue((200 * kitsuneskill2Cost()), USEFATG_MAGIC_NOBM);
		}
		else if ((player.tailCount == 9 && player.tailType == Tail.FOX) || player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 1) {
			player.createStatusEffect(StatusEffects.CooldownIllusion,7-ItemMod,0,0,0);
			fatigue((100 * kitsuneskill2Cost()), USEFATG_MAGIC_NOBM);
		}
		else {
			player.createStatusEffect(StatusEffects.CooldownIllusion,9-ItemMod,0,0,0);
			fatigue((50 * kitsuneskill2Cost()), USEFATG_MAGIC_NOBM);
		}
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		//Decrease enemy speed and increase their susceptibility to lust attacks if already 110% or more
		outputText("The world begins to twist and distort around you as reality bends to your will, [themonster]'s mind blanketed in the thick fog of your illusions.");
		player.createStatusEffect(StatusEffects.Illusion,3+ItemMod,0,0,0);
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
		var lustDmg:Number = combat.lustDamageCalc();
		if (monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
		if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if (monster.lust >= (monster.maxLust() * 0.6)) {
			outputText("[Themonster]'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		mosterTeaseText();
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) lustDmg *= 3;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		lustDmg *= 0.1;
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg);
		outputText("\n\n");
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if(monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		}
	}

	public function MysticWeb():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't web something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		useMana(50);
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		outputText("You ready your spinner and weave a spell animating your webbing to immobilise [themonster]. ");
		//WRAP IT UPPP
		if (40 + rand((player.inte+player.lib)/2) > monster.spe) {
			outputText("A second later [monster he] is firmly tied up by your enchanted thread.");
			monster.createStatusEffect(StatusEffects.MysticWeb, 4 + rand(2),0,0,0);
			var Multiplier:Number = 1;
			if(player.perkv1(IMutationsLib.ArachnidBookLungIM) >= 2) Multiplier += 0.5;
			if(player.perkv1(IMutationsLib.ArachnidBookLungIM) >= 3) Multiplier += 0.5;
			if(player.hasPerk(PerkLib.RacialParagon)) Multiplier += (combat.RacialParagonAbilityBoost() - 1);
			monster.statStore.addBuffObject({spe:-45*Multiplier}, "Web",{text:"Web"});
			if(player.perkv1(IMutationsLib.ArachnidBookLungIM) >= 3 && rand(100) > 50) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			awardAchievement("How Do I Shot Web?", kACHIEVEMENTS.COMBAT_SHOT_WEB);
		}
		//Failure
		else outputText("Your target proves too fast for your technique to catch up.");
		outputText("\n\n");
		enemyAI();
	}

	public function TelekineticGrab():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't grab something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		useMana(50);
		outputText("You weave your hand causing [themonster] body to levitate and fly to you as you use telekinesis to hold your opponent.\n\n");
		monster.createStatusEffect(StatusEffects.TelekineticGrab, 4 + rand(2), 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownTelekineticGrab, 12, 0, 0, 0);
		enemyAI();
	}

	//Slime Bolt
	public function SlimeBolt():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		useMana(50);
		combat.darkRitualCheckDamage();
		outputText("You wave a sign in the air, summoning a huge slime blob which you proceed to hurl at your opponent. [Themonster] is caught in the sticky blast, getting completely soaked in slime. ");
		var lustDmgF:Number = 20 + rand(6);
		var lustBoostToLustDmg:Number = 0;
		var bimbo:Boolean   = false;
		var bro:Boolean     = false;
		var futa:Boolean    = false;
		if (player.hasPerk(PerkLib.SensualLover)) lustDmgF += 2;
		if (player.hasPerk(PerkLib.Seduction)) lustDmgF += 5;
		lustDmgF += player.teaseDmgStat.value;
		if (bimbo || bro || futa) lustDmgF += 5;
		if (player.hasPerk(PerkLib.FlawlessBody)) lustDmgF += 10;
		lustDmgF += scalingBonusLibido() * 0.1;
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmgF *= 1.5;
		if (player.hasPerk(PerkLib.JobSeducer)) lustDmgF += player.teaseLevel * 3;
		else lustDmgF += player.teaseLevel * 2;
		if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) lustDmgF *= 1.2;
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
		if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemTags.A_REVEALING)) lustDmgF *= (1 + ((10 + rand(11)) / 100));
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) lustDmgF *= (1 + (player.lust100 * 0.01));
		if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) lustDmgF *= (1 + combat.historyWhoreBonus());
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmgF *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmgF *= 2;
		lustBoostToLustDmg += lustDmgF * 0.01;
		lustDmgF *= 0.2;
		if (player.lust100 * 0.01 >= 0.9) lustDmgF += (lustBoostToLustDmg * 140);
		else if (player.lust100 * 0.01 < 0.2) lustDmgF += (lustBoostToLustDmg * 140);
		else lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
		//Determine if critical tease!
		var critL:Boolean = false;
		var critChanceL:int = 5;
		critChanceL += combat.teases.combatTeaseCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChanceL = 0;
		if (rand(100) < critChanceL) {
			critL = true;
			lustDmgF *= 1.75;
		}
		if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
		if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) lustDmgF *= 1.5;
		lustDmgF = lustDmgF * monster.lustVuln;
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
		lustDmgF = Math.round(monster.lustVuln * lustDmgF);
		monster.teased(lustDmgF);
		if (critL) outputText(" <b>Critical!</b>");
		monster.statStore.addBuffObject({spe:-15}, "Poison",{text:"Poison"});
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		var damage:Number = scalingBonusIntelligence() * spellMod() * 1.2;
		if (damage < 10) damage = 10;
		//Determine if critical hit!
		var critP:Boolean = false;
		var critChanceP:int = 5;
		critChanceP += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChanceP = 0;
		if (rand(100) < critChanceP) {
			critP = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText(" ");
		doMagicDamage(damage, true, true);
		if (critP) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		statScreenRefresh();
		outputText("\n\n");
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	//Cursed Riddle
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
		outputText("Startled by your query, [themonster] gives you a troubled look, everyone knows of the terrifying power of a sphinx riddle used as a curse. You give [themonster] some time crossing your forepaws in anticipation. ");

		//odds of success
		var baseInteReq:Number = 200;
		var chance:Number = Math.max(player.inte/baseInteReq, 0.05) + 25;
		chance = Math.min(chance, 0.80);

		if (Math.random() < chance) {
			outputText("\n\n[themonster] hazard an answer and your smirk as you respond, \"Sadly incorrect!\" Your curse smiting your foe for its mistake, leaving it stunned by pain and pleasure.");
			//damage dealth
			var damage:Number = ((scalingBonusWisdom() * 0.5) + scalingBonusIntelligence()) * spellMod();
			if (player.headJewelry == headjewelries.SPHINXAS) damage *= 1.5;
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combatMagicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				damage *= 1.75;
			}
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			damage = Math.round(damage);
			doMagicDamage(damage, true, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			//Lust damage dealth
			if (monster.lustVuln > 0) {
				outputText(" ");
				var lustDmg:Number = ((player.inte + (player.wis * 0.50)) / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
				if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
				if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
				if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
				monster.teased(monster.lustVuln * lustDmg);
				if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			}
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			outputText("\n\n");
			combat.heroBaneProc(damage);
		}
		else {
			outputText("\n\nTo your complete frustration, [themonster] answers correctly.");
			outputText("\n\n");
		}
	if(monster.HP <= monster.minHP()) doNext(endHpVictory);
	else enemyAI();
	}

	//Fae Storm
	public function FaeStorm():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(80, Combat.USEMANA_MAGIC);
		combat.darkRitualCheckDamage();
		outputText("Your wings start shining with rainbowish light as you charge and unleash a beam of primal energy on [themonster]. ");
		var damage:Number = (scalingBonusIntelligence() * spellMod());
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.5;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 3) damage *= 1.50;
		damage = Math.round(damage);
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>. ");
		//Randomising secondary effects
		var EffectList:Array = [];
		EffectList.push(FaeStormLightning);
		EffectList.push(FaeStormAcid);
		EffectList.push(FaeStormBurn);
		EffectList.push(FaeStormPoison);
		EffectList.push(FaeStormFrozen);
		EffectList.push(FaeStormLust);
		EffectList.push(FaeStormSleep);
		var ProcChance:Number = 60;
		if (player.hasPerk(PerkLib.FairyQueenRegalia)) ProcChance -= 30;
		if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 2) ProcChance -= 10;
		if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 3) ProcChance -= 10;
		var procCount:int = 0;
		var procChecks:int = (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 4)? 12: 6;
		for (var i:int = 0; i < procChecks; i++) {
			if (rand(100) >= ProcChance) {
				procCount++;
			}
		}
		for (i=1; i <= Math.min(procCount, 6); i++) {
			var choice:Function = randomChoice(EffectList);
			if(i == 1) {
				outputText("Your opponent ");
			}
			if(i == 2) {
				outputText(". At the same time as [monster he] ");
			}
			if(i == 3) {
				outputText(". As if to add insult to injury, [monster he] ");
			}
			if(i == 4) {
				outputText(" while [monster he] ");
			}
			if(i == 5) {
				outputText(". Finally [monster he] ");
			}
			if(i == 6) {
				outputText(". Just as you thought you couldn’t get luckier [monster he] ");
			}
			choice();
			EffectList.splice(EffectList.indexOf(choice), 1)
		}
		outputText(".\n\n");
		enemyAI();
	}
	
	//Pixie Dust
	public function PixieDust():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(80, Combat.USEMANA_MAGIC);
		outputText("You fly above your opponent"+((monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))?"s":"")+" and flap a cloud of magical dust at [monster him]. ");
		combat.darkRitualCheckDamage();
		
		//Randomising effects
		var EffectList:Array = [];
		EffectList.push(FaeStormLightning);
		EffectList.push(FaeStormAcid);
		EffectList.push(FaeStormBurn);
		EffectList.push(FaeStormPoison);
		EffectList.push(FaeStormFrozen);
		EffectList.push(FaeStormLust);
		EffectList.push(FaeStormSleep);
		var ProcChance:Number = 80;
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) ProcChance -= 30;
		if (player.hasPerk(PerkLib.FairyQueenRegalia)) ProcChance -= 30;
		if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 2) ProcChance -= 10;
		if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 3) ProcChance -= 10;
		
		var procCount:int = 0;
		var procChecks:int = (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 4)? 10: 5;
		for (var i:int = 0; i < procChecks; i++) {
			if (rand(100) >= ProcChance) {
				procCount++;
			}
		}
		for (i=1; i <= Math.min(procCount, 5); i++) {
			var choice:Function = randomChoice(EffectList);
			if(i == 1) {
				outputText("Your opponent ");
			}
			if(i == 2) {
				outputText(". At the same time as [monster he] ");
			}
			if(i == 3) {
				outputText(". As if to add insult to injury, [monster he] ");
			}
			if(i == 4) {
				outputText(" while [monster he] ");
			}
			if(i == 5) {
				outputText(". Finally [monster he] ");
			}
			choice();
			EffectList.splice(EffectList.indexOf(choice), 1)
		}
		outputText(".\n\n");
		enemyAI();
	}

	private function FaeStormLightning():void{
		if(monster.plural) {
			outputText("begin spasming while [monster his] bodies are ran through by electricity");
		}
		else outputText("begin spasming while [monster his] body is ran through by electricity");

		var damage:Number = (scalingBonusIntelligence() * spellMod());
		
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.5;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM) >= 3) damage *= 1.5;
		damage *= combat.lightningDamageBoostedByDao();
		damage = calcVoltageMod(damage, true);

		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}

		doLightningDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
	}
	private function FaeStormAcid():void{
		if(monster.plural) {
			outputText("begins screaming as [monster his] bodies is suddenly coated with acid and [monster his] armor melting");
		}
		else outputText("begins screaming as [monster his] body is suddenly coated with acid and [monster his] armor melting");
		monster.armorDef *= 0.5;
	}
	private function FaeStormBurn():void{
		if(monster.plural) {
			outputText("starts to burn as [monster his] bodies catch fire");
		}
		else outputText("starts to burn as [monster his] body catch fire");
		var burnPercent:Number = 0.02;

		if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT, 1, 1);
		else monster.createStatusEffect(StatusEffects.BurnDoT, 10, burnPercent, 0, 0);
	}
	private function FaeStormPoison():void {
		outputText("turns green as a potent poison saps [monster his] strength");
		var statDecrease:int = 1;

		monster.createOrAddStatusEffect(StatusEffects.NagaVenom, 1, statDecrease);
	}
	private function FaeStormFrozen():void{
		outputText("shivers as [monster his] skin covers with ice, the surrounding air freezing solid");
		var freezeDuration:int = 3;

		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.FrozenSolid,freezeDuration,0,0,0);
		else outputText(". Sadly, [themonster] quickly dodges before they are completely frozen");
		
	}
	private function FaeStormLust():void{
		var lustDmg:Number = scalingBonusIntelligence() / 3;
		lustDmg *= spellMod();
		lustDmg = combat.teases.teaseAuraLustDamageBonus(monster, lustDmg);
		if (monster) lustDmg *= monster.lustVuln;

		if(monster.plural) outputText("are magically aroused by the spell");
		else outputText("is magically aroused by the spell");
		monster.teased(Math.round(lustDmg), false);
	}
	private function FaeStormSleep():void{
		if (monster.plural) outputText("are sent straight to the dream lands by the spell’s powerful hypnotic effects");
		else outputText("is sent straight to the dream lands by the spell’s powerful hypnotic effects");

		var sleepDuration:Number = 2;

		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Sleep,sleepDuration,0,0,0);
		else outputText(", only to quickly shake themselves awake");
	}

	public function BalefulPolymorph():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(80, Combat.USEMANA_MAGIC);
		outputText("You chuckle playfully as you throw this spell on [themonster], turning [monster he] temporarily into a cute harmless ");
		var chosen:String = randomChoice("rabbit.", "squirrel.", "sheep.", "mouse.", "cat.", "dog.");
		outputText(chosen+"\n\n");
		var DurationIncrease:Number = 0;
		if (player.hasPerk(PerkLib.FairyQueenRegalia)) DurationIncrease = 2;
		monster.createStatusEffect(StatusEffects.Polymorphed, 3+DurationIncrease, 0, 0, 0);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownBalefulPolymorph,15,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownBalefulPolymorph, 16, 0, 0, 0)
		enemyAI();
	}

	//Transfer
	public function lustTransfer():void {
		clearOutput();
		if (player.hasPerk(PerkLib.GreaterGiftOfLust)) fatigue(60, USEFATG_MAGIC_NOBM);
		else if (player.hasPerk(PerkLib.GiftOfLust)) fatigue(30, USEFATG_MAGIC_NOBM);
		else fatigue(40, USEFATG_MAGIC_NOBM);
		var lusttransfered:Number = 0;
		var lusttransfered2:Number = 0.15;
		if (player.hasPerk(PerkLib.GiftOfLust)) lusttransfered2 += 0.1;
		if (player.hasPerk(PerkLib.GreaterGiftOfLust)) lusttransfered2 += 0.15;
		lusttransfered += Math.round(player.lust * lusttransfered2);
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
		mosterTeaseText();
		monster.lust += lusttransfered;
		outputText("\n\n");
		doNext(playerMenu);
		if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		else enemyAI();
	}

//Fascinate
	public function Fascinate():void {
		clearOutput();
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if(monster is EncapsulationPod || monster.inte == 0) {
			outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n");
			fatigue(1);
			enemyAI();
			return;
		}
		fatigue(30, USEFATG_PHYSICAL);
		var FascCD:Number = 4;
		if (player.perkv1(IMutationsLib.BlackHeartIM) >= 2) FascCD -= 1;
		if (player.perkv1(IMutationsLib.BlackHeartIM) >= 4) FascCD -= 1;
		if (player.hasPerk(PerkLib.NaturalInstincts)) FascCD -= 1;
		player.createStatusEffect(StatusEffects.CooldownFascinate,FascCD,0,0,0);
		outputText("You start with first pose to attract [themonster] attention.  Then you follow with second and then third pose of your enchanting dance.");
		var lustDmg:Number = 5;
		if (player.perkv1(IMutationsLib.BlackHeartIM) >= 1) lustDmg += 5;
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			enemyAI();
			return;
		}
		if(monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
		if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.maxLust() * 0.6)) {
			outputText("[Themonster]'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		mosterTeaseText();
		monster.teased(Math.round(monster.lustVuln * lustDmg));
		if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText(" <b>Your erotic show aside slight arousing manages to put [themonster] into dazze caused by too strong sexual stimulation!</b> ");
			if (player.perkv1(IMutationsLib.BlackHeartIM) >= 3) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			else monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (!monster.hasStatusEffect(StatusEffects.TimesCharmed)) monster.createStatusEffect(StatusEffects.TimesCharmed, player.hasPerk(PerkLib.DarkCharm) ? 0.5 : 1, 0, 0, 0);
			else monster.addStatusValue(StatusEffects.TimesCharmed, 1, player.hasPerk(PerkLib.DarkCharm) ? 0.5 : 1);
		}
		outputText("\n\n");
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		doNext(playerMenu);
		if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		else enemyAI();
	}

//Lust strike
	public function LustStrike():void {
		clearOutput();
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		fatigue(50, USEFATG_MAGIC_NOBM);
		outputText("You start drawing symbols in the air toward [themonster].");
		var lustRatio:Number = 10;
		if (player.perkv1(IMutationsLib.BlackHeartIM) >= 4) lustRatio -= 5;
		var lustDmg:Number = player.lust / lustRatio + player.lib / 10;
		if (player.perkv1(IMutationsLib.BlackHeartIM) >= 1) lustDmg += player.inte / 10;
		if (player.perkv1(IMutationsLib.BlackHeartIM) >= 2) lustDmg += player.wis / 10;
		if (player.perkv1(IMutationsLib.BlackHeartIM) >= 3) lustDmg += player.sens / 10;
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			enemyAI();
			return;
		}
		if(monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
		if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.maxLust() * 0.6)) {
			outputText("[Themonster]'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		mosterTeaseText();
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
		if(player.armorName == "Scandalous Succubus Clothing") lustDmg *= 1.25;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		if (player.perkv1(IMutationsLib.BlackHeartIM) >= 4) lustDmg += combat.teases.teaseBaseLustDamage();
		monster.teased(Math.round(monster.lustVuln * lustDmg));
		outputText("\n\n");
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		doNext(playerMenu);
		if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		else enemyAI();
	}

	public function mindThrust():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		useMana(100, USEFATG_MAGIC_NOBM);
		combat.darkRitualCheckDamage();
		var damage:Number = (scalingBonusIntelligence() * spellMod());
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.hasPerk(PerkLib.MindbreakerBrain1toX)) damage*=1+(0.5*(1+player.perkv1(PerkLib.MindbreakerBrain1toX)));
		damage = Math.round(damage);
		outputText("Your third eye opens wide and glow a vicious green as you viciously impale [themonster]’s mind with a mental spike.");
		doTrueDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(".\n\n");
		enemyAI();
	}

	public function mindBlast():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		useMana(100, USEFATG_MAGIC_NOBM);
		//cooldown 8 round
		var duration:int = 2;
		var PsionicEmpowermentBonus:int = 0;
		if (player.hasPerk(PerkLib.MindbreakerBrain1toX)) PsionicEmpowermentBonus = (1+player.perkv1(PerkLib.MindbreakerBrain1toX))/2;
		if (PsionicEmpowermentBonus < 1) PsionicEmpowermentBonus=0;
		if (PsionicEmpowermentBonus > 5) PsionicEmpowermentBonus=5;
		PsionicEmpowermentBonus = Math.round(PsionicEmpowermentBonus);
		if (player.hasPerk(PerkLib.PsionicEmpowerment)) duration -= PsionicEmpowermentBonus;
		outputText("You assault your opponent’s mind with lewd thoughts, locking them into a blissful daze.");
		player.createStatusEffect(StatusEffects.CooldownSpellMindBlast,14-PsionicEmpowermentBonus,0,0,0);
		monster.createStatusEffect(StatusEffects.Stunned, duration,0,0,0);
		enemyAI();
	}

	public function mirrorImage():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		useMana(100, USEFATG_MAGIC_NOBM);
		var numberOfImage:int = 2+Math.round(player.inte/100);
		var PsionicEmpowermentBonus:int = 0;
		if (player.hasPerk(PerkLib.MindbreakerBrain1toX)) PsionicEmpowermentBonus = (1+player.perkv1(PerkLib.MindbreakerBrain1toX))/2;
		if (PsionicEmpowermentBonus < 1) PsionicEmpowermentBonus=0;
		if (PsionicEmpowermentBonus > 10) PsionicEmpowermentBonus=10;
		PsionicEmpowermentBonus = Math.round(PsionicEmpowermentBonus);
		numberOfImage += PsionicEmpowermentBonus;
		if (player.hasPerk(PerkLib.MindbreakerBrain1toX)) numberOfImage += player.perkv1(PerkLib.MindbreakerBrain1toX);
		if (player.hasStatusEffect(StatusEffects.MirrorImage)){
			numberOfImage = numberOfImage-player.statusEffectv1(StatusEffects.MirrorImage);
			outputText("You weave back the spell, resplenishing "+ numberOfImage +" additionnal replicas of yourself to the remaining ones.\n\n");
			player.addStatusValue(StatusEffects.MirrorImage, 1,numberOfImage);
		}
		else{
			outputText("You weave a powerful illusion, creating "+ numberOfImage +" replicas of yourself.\n\n");
			player.createStatusEffect(StatusEffects.MirrorImage,numberOfImage,0,0,0);
		}
		enemyAI();
	}

	public function possess():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		var maxIntCapForFail:Number = player.inte;
		var luckyNumber:Number = rand(7);
		if (player.isRaceCached(Races.POLTERGEIST,2)) {
			maxIntCapForFail += Math.round(player.inte * 0.5);
			luckyNumber += 3 + rand(4);
		}
		if (player.isRaceCached(Races.POLTERGEIST,3)) {
			maxIntCapForFail += player.inte;
			luckyNumber += 6 + rand(7);
		}
		if (monster.hasPerk(PerkLib.EnemyGhostType)) {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself toward the opponent's frame.  Sadly, it was doomed to fail, as you bounce right off your foe's ghostly form.");
		}
		else if (monster is LivingStatue)
		{
			outputText("There is nothing to possess inside the golem.");
		}
		else if ((!monster.hasCock() && !monster.hasVagina()) || monster.lustVuln == 0 || monster.inte == 0 || monster.inte > maxIntCapForFail) {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame.  Unfortunately, it seems ");
			if (monster.inte > maxIntCapForFail) outputText("they were FAR more mentally prepared than anything you can handle, and you're summarily thrown out of their body before you're even able to have fun with them.  Darn, you muse.\n\n");
			else outputText("they have a body that's incompatible with any kind of possession.\n\n");
		}
		//Success!
		else if (player.inte + luckyNumber - monster.armorMDef >= monster.inte) {
			if (player.isRaceCached(Races.POLTERGEIST,3)) {
				outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent’s frame. Before they can regain the initiative, you take control of their entire body, though still facing a form of resistance, making you unable to take certain drastic actions, though there is one tried method that definitely works, based on your experience. ");
				outputText("With great vigor you begin masturbating as you see yourself most fit with your current temporary host, rubbing your adversary’s body all over for several seconds before you’re finally thrown out. Recorporealizing, you see a puddle of fluids around your enemy, and know your efforts were quite more than successful. You feel as if your own lust has subsided somewhat.");
			}
			else if (player.isRaceCached(Races.POLTERGEIST,2)) {
				outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent’s frame. Before they can regain the initiative, you take control of both of their arms, vigorously masturbating with both hands for several seconds before you’re finally thrown out. ");
				outputText("Recorporealizing, you notice your enemy’s blush and arousal, and know your efforts were definitely successful.");
			}
			else {
				outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent's frame. Before they can regain the initiative, you take control of one of their arms, vigorously masturbating for several seconds before you're finally thrown out. ");
				outputText("Recorporealizing, you notice your enemy's blush, and know your efforts were somewhat successful.");
			}
			var damage:Number = Math.round(player.inte / 5) + rand(player.level) + player.level;
			damage *= Math.round(1 + (0.1 * player.racialScore(Races.POLTERGEIST)));
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			if (player.hasPerk(PerkLib.EromancyExpert)) damage *= 1.5;
			if (player.armor == armors.ELFDRES && player.isElf()) damage *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) damage *= 2;
			if (player.isRaceCached(Races.POLTERGEIST,3)) {
				damage += Math.round(player.lust * 0.1);
				player.lust -= Math.round(player.lust * 0.1);
			}
			monster.teased(Math.round(monster.lustVuln * damage));
			outputText("\n\n");
			if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownPossess,1,0,0,0);
			else player.createStatusEffect(StatusEffects.CooldownPossess,2,0,0,0);
		}
		//Fail
		else {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame. Unfortunately, it seems they were more mentally prepared than you hoped, and you're summarily thrown out of their body before you're even able to have fun with them. Darn, you muse. Gotta get smarter.\n\n");
		}
		if(!combatIsOver()) enemyAI();
	}
	public function possess2():void {
		if (player.hasStatusEffect(StatusEffects.HarpyBind)) player.removeStatusEffect(StatusEffects.HarpyBind);
		if (player.hasStatusEffect(StatusEffects.GooBind)) player.removeStatusEffect(StatusEffects.GooBind);
		if (player.hasStatusEffect(StatusEffects.TentacleBind)) player.removeStatusEffect(StatusEffects.TentacleBind);
		if (player.hasStatusEffect(StatusEffects.NagaBind)) player.removeStatusEffect(StatusEffects.NagaBind);
		if (player.hasStatusEffect(StatusEffects.ScyllaBind)) player.removeStatusEffect(StatusEffects.ScyllaBind);
		if (player.hasStatusEffect(StatusEffects.WolfHold)) player.removeStatusEffect(StatusEffects.WolfHold);
		if (player.hasStatusEffect(StatusEffects.TrollHold)) player.removeStatusEffect(StatusEffects.TrollHold);
		if (monster.hasStatusEffect(StatusEffects.QueenBind)) monster.removeStatusEffect(StatusEffects.QueenBind);
		if (monster.hasStatusEffect(StatusEffects.PCTailTangle)) monster.removeStatusEffect(StatusEffects.PCTailTangle);
		if (player.hasStatusEffect(StatusEffects.HolliConstrict)) player.removeStatusEffect(StatusEffects.HolliConstrict);
		if (player.hasStatusEffect(StatusEffects.GooArmorBind)) player.removeStatusEffect(StatusEffects.GooArmorBind);
		if (monster.hasStatusEffect(StatusEffects.MinotaurEntangled)) monster.removeStatusEffect(StatusEffects.MinotaurEntangled);
		if (player.hasStatusEffect(StatusEffects.UBERWEB)) player.removeStatusEffect(StatusEffects.UBERWEB);
		if (player.hasStatusEffect(StatusEffects.Bound)) player.removeStatusEffect(StatusEffects.Bound);
		if (player.hasStatusEffect(StatusEffects.Chokeslam)) player.removeStatusEffect(StatusEffects.Chokeslam);
		if (player.hasStatusEffect(StatusEffects.Titsmother)) player.removeStatusEffect(StatusEffects.Titsmother);
		if (player.hasStatusEffect(StatusEffects.GiantGrabbed)) player.removeStatusEffect(StatusEffects.GiantGrabbed);
		if (player.hasStatusEffect(StatusEffects.Tentagrappled)) player.removeStatusEffect(StatusEffects.Tentagrappled);
		possess();
	}

//Spectral Scream
	public function SpectralScream():void {
		clearOutput();
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownSpectralScream,5,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownSpectralScream,6,0,0,0);
		outputText("You let out a soul-chilling scream freezing your opponent" + (monster.plural ? "s":"") + " in [monster his] tracks from sheer terror. This also seems to have damaged [monster his] sanity. ");
		var damage:Number = 0;
		damage += scalingBonusIntelligence() * spellMod();
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage);
		doMagicDamage(damage, true, true);
		monster.createStatusEffect(StatusEffects.Fear,1+rand(3),0,0,0);
		enemyAI();
	}

//Feline Curse
	public function FelineCurse():void {
		clearOutput();
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownFelineCurse,14,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownFelineCurse,15,0,0,0);
		outputText("You almost purr the curse aloud, heat filling your mind and body as you turn your foe into a small harmless house cat. It begins running around screeching in terror and confusion.");
		var selflust:Number = 6 + rand(3);
		selflust += scalingBonusLibido() * 0.1;
		selflust = Math.round(selflust);
		dynStats("lus", selflust);
		monster.createStatusEffect(StatusEffects.Polymorphed, 3, 0, 0, 0);
		if (player.lust >= player.maxOverLust()) doNext(endLustLoss);
		else enemyAI();
	}

//Infernal Claw
	public function InfernalClaw():void {
		clearOutput();
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownInfernalClaw,7,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownInfernalClaw, 8, 0, 0, 0);
		var damage:Number = 0;
		damage += unarmedAttack();
		damage *= spellMod();
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage);
		outputText("You growl as you unsheath your claws, enhancing them with a dash of fire magic. You leap forward and viciously rend your opponent for " + damage + " physical and ");
		doDamage(damage);//phys dmg
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		doFireDamage(damage, true, true);
		outputText(" fire damage. Reeling in pain [themonster] begins to bleed and burn at the same time.");
		monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05*combat.BleedDamageBoost(true), 0, 0);
		monster.createStatusEffect(StatusEffects.BurnDoT, 5, 0.05, 0, 0);
		outputText("\n\n");
		checkAchievementDamage(damage * 2);
		combat.heroBaneProc(damage * 2);
		doNext(playerMenu);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

//Eclipsing shadow
	public function EclipsingShadow():void {
		clearOutput();
		var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		thirst.modSatiety(-1);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownEclipsingShadow,19,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownEclipsingShadow,20,0,0,0);
		outputText("You open your wings wide and call upon the power of your tainted blood a pair of black orbs forming at your fingertips. You shatter them on the ground plunging the area in complete darkness and extinguishing all light. While your opponent will be hard pressed to see anything your ability to echolocate allows you to navigate with perfect clarity.");
		monster.createStatusEffect(StatusEffects.Blind, 15, 0, 0, 0);
		enemyAI();
	}

//Sonic scream
	public function SonicScream():void {
		clearOutput();
		var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		thirst.modSatiety(-1);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownSonicScream,14,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownSonicScream, 15, 0, 0, 0);
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		var damage:Number = 0;
		damage += scalingBonusIntelligence()+scalingBonusToughness()+scalingBonusLibido();
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 5;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage);
		monster.HP -= damage;
		outputText("You call on the power of your tainted blood drawing out an almighty scream so strong and sharp it explode from you like a shockwave sending [themonster] flying. [monster he] will be shaken from the glass shattering blast for a moment " + damage + " damage.");
		if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
			if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		doNext(playerMenu);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	
//Vampire Thirst Stacks To Health/Mana
	public function VampireThirstStacksToHealth(stack:Number = 1):void {
		clearOutput();
		var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		thirst.modSatiety(-stack);
		outputText("You convert some of your stolen blood back to health.");
		if (player.hasStatusEffect(StatusEffects.VampThirstStacksHPMana)) player.addStatusValue(StatusEffects.VampThirstStacksHPMana,1,1);
		else player.createStatusEffect(StatusEffects.VampThirstStacksHPMana,1,0,0,0);
		HPChange(Math.round(player.maxHP()*0.05*stack), false);
		combat.combatMenu(false);
	}
	public function VampireThirstStacksToMana(stack:Number = 1):void {
		clearOutput();
		var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		thirst.modSatiety(-stack);
		outputText("You convert some of your stolen blood back to energy.");
		if (player.hasStatusEffect(StatusEffects.VampThirstStacksHPMana)) player.addStatusValue(StatusEffects.VampThirstStacksHPMana,2,1);
		else player.createStatusEffect(StatusEffects.VampThirstStacksHPMana,0,1,0,0);
		EngineCore.ManaChange(Math.round(player.maxMana()*0.05*stack));
		combat.combatMenu(false);
	}

	public function Hurricane():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(50, Combat.USEMANA_MAGIC_NOBM);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownHurricane,4,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownHurricane,5,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusSpeed() * 2;
		damage += scalingBonusIntelligence() * 2;
		damage += rand(player.level + player.racialScore(Races.COUATL));
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) damage *= 1.5;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) damage *= 1.5;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) damage *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = calcGaleMod(damage, true);
		damage = Math.round(damage * combat.windDamageBoostedByDao());
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your winds touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The winds courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You gather winds around you and unleash them on the horde of demons like a tidal wave, tossing them around like mere chaff to the wind. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them! ");
			damage = int(player.level * 8 + 25 + rand(10));
			damage *= (1.75 * combat.windDamageBoostedByDao());
			damage = Math.round(damage);
			doWindDamage(damage, true, true);
			if (!monster.hasStatusEffect(StatusEffects.CouatlHurricane)) monster.createStatusEffect(StatusEffects.CouatlHurricane,3,0,0,0);
			else {
				monster.addStatusValue(StatusEffects.CouatlHurricane, 1, 1);
				monster.changeStatusValue(StatusEffects.CouatlHurricane, 2, 1);
				outputText("\n\nThe strength of the hurricane winds has increased even further.");
			}
			combatRoundOver();
			return;
		}
		outputText("You gather winds around you and unleash them on your opponent into a raging hurricane. Winds have began to swirl around the battlefield sanding random objects at your opponents and sowing general chaos across the battleground.");
		if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your wind are massively dissipated by the swirling vortex, causing them to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Against all odds, [themonster] manages to avoid your deadly winds. [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, somehow countering your attack with winds of her owns!\n\n");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your windstorm slams into [monster him] with full force leaving behind deep wounds!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your windstorm slams into [monster him] with full force leaving behind deep wounds!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doWindDamage(damage, true, true);
			if (!monster.hasStatusEffect(StatusEffects.CouatlHurricane)) monster.createStatusEffect(StatusEffects.CouatlHurricane,3,0,0,0);
			else {
				monster.addStatusValue(StatusEffects.CouatlHurricane, 1, 1);
				monster.changeStatusValue(StatusEffects.CouatlHurricane, 2, 1);
				outputText("\n\nThe strength of the hurricane winds has increased even further.");
			}
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function WindScythe():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownWindScythe,4,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownWindScythe,5,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusSpeed() * 2;
		damage += scalingBonusWisdom() * 2;
		damage += rand(player.level + player.racialScore(Races.KAMAITACHI));
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) damage *= 1.5;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) damage *= 1.5;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) damage *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = calcGaleMod(damage, true);
		damage = Math.round(damage * combat.windDamageBoostedByDao());
		//Shell
		if(monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your winds touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("The winds courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.");
			enemyAI();
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You gather winds around you and unleash them on the horde of demons like a tidal wave, scarring and bleeding their tainted flesh. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them! ");
			damage = int(player.level * 8 + 25 + rand(10));
			damage *= (1.75 * combat.windDamageBoostedByDao());
			damage = Math.round(damage);
			doWindDamage(damage, true, true);
			if (!monster.hasStatusEffect(StatusEffects.KamaitachiBleed)) monster.createStatusEffect(StatusEffects.KamaitachiBleed,3,0,0,1);
			else{
				monster.addStatusValue(StatusEffects.KamaitachiBleed, 1, 1);
				monster.addStatusValue(StatusEffects.KamaitachiBleed, 4, 1);
				outputText("\n\nYour attack greatly worsened the bleeding your opponents suffers.");
			}
			combatRoundOver();
			return;
		}
		outputText("You gather winds around you and unleash them on your opponent into a deadly gust sharper then any blade, its so powerful that even the environs crumble around [monster him].  [Themonster] does [monster his] best to avoid it, but windstorm is too fast.");
		if(monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your wind are massively dissipated by the swirling vortex, causing them to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if(((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			outputText("  Against all odds, [themonster] manages to avoid your deadly winds. [monster his] feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if(monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, somehow countering your attack with winds of her owns!\n\n");
		}
		else {
			if(!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  [Themonster] reels as your windstorm slams into [monster him] with full force leaving behind deep wounds!  The impact sends [monster him] crashing to the ground, too dazed to strike back. ");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  [Themonster] reels as your windstorm slams into [monster him] with full force leaving behind deep wounds!  The impact sends [monster him] staggering back, but <b>[monster he] ");
				if(!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b> ");
			}
			doWindDamage(damage, true, true);
			if (!monster.hasStatusEffect(StatusEffects.KamaitachiBleed)) monster.createStatusEffect(StatusEffects.KamaitachiBleed,3,0,0,1);
			else {
				monster.addStatusValue(StatusEffects.KamaitachiBleed, 1, 1);
				outputText("\n\nYour attack greatly worsened the bleeding your opponent suffers.");
			}
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		checkLethiceAndCombatRoundOver();
	}

	public function ChaosBeams():void {
		clearOutput();
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownChaosBeams,11,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownChaosBeams,12,0,0,0);
		fatigue((player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) * 10), USEFATG_MAGIC_NOBM);
		outputText("You shoot a salvo of chaotic eye beams at your foe.\n");
		ChaosBeamsRulette();
		ChaosBeamsRulette();
		if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 4) {
			ChaosBeamsRulette();
			ChaosBeamsRulette();
		}
		if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6) {
			ChaosBeamsRulette();
			ChaosBeamsRulette();
		}
		if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
			ChaosBeamsRulette();
			ChaosBeamsRulette();
		}
		if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
			ChaosBeamsRulette();
			ChaosBeamsRulette();
		}
		outputText("\n\n");
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function ChaosBeamsRulette():void {
		var damage:Number = scalingBonusIntelligence() * spellModWhite();
		switch (rand(10)) {
			case 0:
				outputText("[Themonster] takes heavy electricity damage from the eyebeam! ");
				damage = Math.round(damage * combat.lightningDamageBoostedByDao());
				doLightningDamage((damage * 3), true, true);
				break;
			case 1:
				outputText("[Themonster]  starts to burn as [monster his] body catches fire from the eyebeam! ");
				damage = Math.round(damage * combat.fireDamageBoostedByDao());
				doFireDamage(damage, true, true);
				if (monster.hasStatusEffect(StatusEffects.Stunned)) monster.addStatusValue(StatusEffects.Stunned, 1, 1);
				else monster.createStatusEffect(StatusEffects.BurnDoT, 2, 0.01, 0, 0);
				break;
			case 2:
				outputText("[Themonster]  turns green as a potent poison inflicted by the eyebeam saps [monster his] strength! ");
				damage = Math.round(damage * combat.poisonDamageBoostedByDao());
				doPoisonDamage(damage, true, true);
				var strDebuff:Number = 0;
				if (monster.spe >= 6) strDebuff += 5;
				else strDebuff += 5 - monster.spe;
				monster.strStat.core.value -= strDebuff;
				var speDebuff:Number = 0;
				if (monster.spe >= 6) speDebuff += 5;
				else speDebuff += 5 - monster.spe;
				monster.speStat.core.value -= speDebuff;
				break;
			case 3:
				outputText("[Themonster]  skin is covered with ice from the eyebeam as the air surrounding [monster him] freezes solid! ");
				damage = Math.round(damage * combat.iceDamageBoostedByDao());
				doIceDamage(damage, true, true);
				if (!monster.hasPerk(PerkLib.Resolute)) {
					if (monster.hasStatusEffect(StatusEffects.Stunned)) monster.addStatusValue(StatusEffects.Stunned, 1, 1);
					else monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				} else {
					outputText("However, [themonster] is able to quickly break themselves free! ");
				}
				break;
			case 4:
				outputText("[Themonster]  takes heavy cold damage! ");
				damage = Math.round(damage * combat.iceDamageBoostedByDao());
				doIceDamage((damage * 3), true, true);
				break;
			case 5:
				outputText("[Themonster]  is magically aroused by the eyebeam. ");
				var lustDmg:Number = player.lib / 10;
				if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
				if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
				monster.teased(Math.round(monster.lustVuln * lustDmg));
				break;
			case 6:
				outputText("The eyebeam’s powerful hypnotic effects send your target straight to the dream lands! ");
				if (!monster.hasPerk(PerkLib.Resolute)) {
					if (monster.hasStatusEffect(StatusEffects.Sleep)) monster.addStatusValue(StatusEffects.Sleep, 1, 1);
					else monster.createStatusEffect(StatusEffects.Sleep,2,0,0,0);
				} else {
					outputText("However, [themonster] was able to quickly shake themselves awake! ");
				}
				break;
			case 7:
				outputText("[Themonster] is turned to stone by the petrification ray shooting from your eyestalk! It's going to be immobile for a while. ");
				if (!monster.hasPerk(PerkLib.Resolute)) {
					if (monster.hasStatusEffect(StatusEffects.Stunned)) monster.addStatusValue(StatusEffects.Stunned, 1, 1);
					else monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
				} else {
					outputText("However, [themonster] was able to quickly shake off the effect! ");
				}
				break;
			case 8:
				outputText("[Themonster] takes heavy fire damage being seared by the ray shooting from one of your eyestalks! ");
				damage = Math.round(damage * combat.fireDamageBoostedByDao());
				doFireDamage((damage * 3), true, true);
				break;
			case 9:
				outputText("[Themonster] is struck by your disintegration ray! ");
				if (rand(2) == 0) {
					outputText("It manages to avoid most of the beam damage. ");
					doMagicDamage((damage * 2), true, true);
				}
				else {
					outputText("It takes tremendous damage as the beam creates a hole in [monster his] body! ");
					doMagicDamage((damage * 10), true, true);
				}
				break;
		}
		outputText("\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}

	public function DominatingGaze():void {
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		outputText("You gaze deep into [themonster] eyes smashing [monster his] thoughts and resolve to nothingness along the way. [monster his] is nothing, you are everything. [Themonster] is left stunned by the experience.\n\n");
		//player.createStatusEffect(StatusEffects.CooldownNet,8,0,0,0);
		monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
		enemyAI();
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
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 6) windwallduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 7) windwallduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 8) windwallduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 9) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 10) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 11) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 12) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 13) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 14) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 15) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 16) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 17) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 18) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 19) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 20) windwallduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 21) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 22) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 23) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 24) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 25) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 26) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 27) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 28) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 29) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 30) windwallduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) >= 31) windwallduration += 3;
		windwallduration *= 2;
		player.createStatusEffect(StatusEffects.WindWall, 0, windwallduration, 0, 0);
		outputText("You call on your elemental projecting a air wall between you and [themonster] to deflect incoming projectiles.\n\n");
		enemyAI();
	}

	public function ElementalAspectEarth():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectEarth, 0, 0, 0, 0);
		var stoneskinbonus:Number = 0;
		stoneskinbonus += player.inte * 0.5;
		stoneskinbonus += player.wis * 0.5;
		stoneskinbonus = Math.round(stoneskinbonus);
		var stoneskinduration:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 1) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 2) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 3) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 4) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 5) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 6) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 7) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 8) stoneskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 9) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 10) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 11) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 12) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 13) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 14) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 15) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 16) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 17) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 18) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 19) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 20) stoneskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 21) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 22) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 23) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 24) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 25) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 26) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 27) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 28) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 29) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 30) stoneskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) >= 31) stoneskinduration += 3;
		player.createStatusEffect(StatusEffects.StoneSkin, stoneskinbonus, stoneskinduration, 0, 0);
		outputText("Your elemental lifts stone and dirt from the ground, encasing you in a earthen shell stronger than any armor.\n\n");
		enemyAI();
	}

	public function ElementalAspectFire():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectFire, 0, 0, 0, 0);
		var damage:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsFire) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;
		
		//crits for elementals specials inclused too? with some perk maybe or just like that same as crit % chance for PC?
		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		outputText("Your fire elemental douses your opponent with a torrent of fire ");
		doFireDamage(damage, true, true);
		outputText("\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectWater():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectWater, 0, 0, 0, 0);
		var temp:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWater) - 28);
		}
		temp += scalingBonusIntelligence() * multiInt;
		temp += scalingBonusWisdom() * multiWis;
		temp = Math.round(temp);
		outputText("Your elemental encases your body within a bubble of curative spring water, slowly closing your wounds. The bubbles pop leaving you wet, but on the way to full recovery. <b>([font-heal]+" + temp + "</font>)</b>");
		HPChange(temp,false);
		outputText("\n\n");
		enemyAI();
	}

	public function ElementalAspectEther():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectEther, 0, 0, 0, 0);
		var damage:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsEther) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;
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
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		outputText("Your elemental unleash a barrage of star shaped bolts of arcane energy, blasting your opponent. ");
		doMagicDamage(damage, true, true);
		outputText("\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectWood():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectWood, 0, 0, 0, 0);
		var barkskinbonus:Number = 0;
		barkskinbonus += player.inte * 0.25;
		barkskinbonus += player.wis * 0.25;
		barkskinbonus = Math.round(barkskinbonus);
		var barkskinduration:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 1) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 2) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 3) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 4) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 5) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 6) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 7) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 8) barkskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 9) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 10) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 11) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 12) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 13) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 14) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 15) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 16) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 17) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 18) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 19) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 20) barkskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 21) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 22) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 23) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 24) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 25) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 26) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 27) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 28) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 29) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 30) barkskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 31) barkskinduration += 3;
		player.createStatusEffect(StatusEffects.BarkSkin, barkskinbonus, barkskinduration, 0, 0);
		var temp:Number = 0;
		var multiInt:Number = 0.25;
		var multiWis:Number = 0.25;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 2) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 1);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 5) {
			multiInt += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 4);
			multiWis += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 9) {
			multiInt += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 8);
			multiWis += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 13) {
			multiInt += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 12);
			multiWis += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 17) {
			multiInt += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 16);
			multiWis += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 21) {
			multiInt += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 20);
			multiWis += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 25) {
			multiInt += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 24);
			multiWis += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) >= 29) {
			multiInt += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 28);
			multiWis += 0.05 * (player.statusEffectv2(StatusEffects.SummonedElementalsWood) - 28);
		}
		temp += scalingBonusIntelligence() * multiInt;
		temp += scalingBonusWisdom() * multiWis;
		temp = Math.round(temp);
		outputText("Your elemental temporarily covers your skin with bark, shielding you against strikes. This is the bark of medicinal plants and as such you recover from your injuries. <b>([font-heal]+" + temp + "</font>)</b>");
		HPChange(temp,false);
		outputText("\n\n");
		enemyAI();
	}

	public function ElementalAspectMetal():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectMetal, 0, 0, 0, 0);
		var metalskinbonus:Number = 0;
		metalskinbonus += player.inte * 0.5;
		metalskinbonus += player.wis * 0.5;
		metalskinbonus = Math.round(metalskinbonus);
		var metalskinduration:Number = 0;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 1) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 2) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 3) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 4) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 5) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 6) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 7) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 8) metalskinduration += 1;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 9) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 10) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 11) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 12) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 13) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 14) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 15) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 16) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 17) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 18) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 19) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 20) metalskinduration += 2;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 21) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 22) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 23) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 24) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 25) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 26) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 27) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 28) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 29) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 30) metalskinduration += 3;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) >= 31) metalskinduration += 3;
		player.createStatusEffect(StatusEffects.MetalSkin, metalskinbonus, metalskinduration, 0, 0);
		outputText("Your elemental encases your body into a layer of flexible yet solid steel. The metal gives strength to your frame, empowering your unarmed strikes.\n\n");
		enemyAI();
	}

	public function ElementalAspectIce():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectIce, 0, 0, 0, 0);
		var damage:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsIce) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;
		damage *= combat.elementalAmplificationMod(5 * player.statusEffectv2(StatusEffects.SummonedElementalsIce));

		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		outputText("Your elemental produces a ray of hyper condensed cold and aims it straight at [themonster] dealing ");
		doIceDamage(damage, true, true);
		outputText("\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectLightning():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectLightning, 0, 0, 0, 0);
		var damage:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;

		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		outputText("Your elemental charges electricity, then discharges it with a blinding bolt doing ");
		doLightningDamage(damage, true, true);
		outputText("\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectDarkness():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectDarkness, 0, 0, 0, 0);
		var damage:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;

		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		outputText("Your darkness elemental condenses shadows into solid matter, striking your opponent with them ");
		doDarknessDamage(damage, true, true);
		outputText("\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectPoison():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectPoison, 0, 0, 0, 0);
		var damage:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;

		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		outputText("Your poison elemental condenses aphrodisiac poison into spike, striking your opponent with them ");
		doPoisonDamage(damage, true, true);

		var lustdamage:Number = 20 + rand(player.statusEffectv2(StatusEffects.SummonedElementalsPoison) + 1);
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 2) lustdamage += 1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 1);
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 9) lustdamage += 1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 8);
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) >= 21) lustdamage += 1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) - 20);
		if (player.armor == armors.ELFDRES && player.isElf()) lustdamage *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) lustdamage *= 2;
		monster.teased(Math.round(monster.lustVuln * lustdamage));
		outputText("\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectPurity():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectPurity, 0, 0, 0, 0);
		var damage:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;
		damage *= combat.purityScalingDA();

		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		outputText("Your purity elemental produces a ray of hyper condensed and pure light and aims it straight at [themonster] ");
		doMagicDamage(damage, true, true);
		outputText("\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}

	public function ElementalAspectCorruption():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		player.createStatusEffect(StatusEffects.CooldownEAspectCorruption, 0, 0, 0, 0);
		var damage:Number = 0;
		var multiInt:Number = 0.5;
		var multiWis:Number = 0.5;
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 2) {
			multiInt += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 1);
			multiWis += 0.2 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 1);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 5) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 4);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 4);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 9) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 8);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 8);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 13) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 12);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 12);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 17) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 16);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 16);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 21) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 20);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 20);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 25) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 24);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 24);
		}
		if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) >= 29) {
			multiInt += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 28);
			multiWis += 0.1 * (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;
		damage *= combat.corruptionScalingDA();

		damage = Math.round(damage);
		/*if(!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}//późniejsze lvl-e dodadzą stun chance
		else {
			outputText("  [Themonster] reels as your wave of force slams into [monster him] like a ton of rock!  The impact sends [monster him] staggering back, but <b>[monster he] ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}*/
		outputText("Your corruption elemental condenses corruption from air into solid matter, striking your opponent with them ");
		doMagicDamage(damage, true, true);
		outputText("\n\n");
		//checkMinionsAchievementDamage(damage);
		enemyAI();
	}
	
	public function FusionSpecialFirst(element:Number, type:Number):void {
		clearOutput();
		var soulforcecost:Number = 10 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		player.soulforce -= soulforcecost;
		var damage:Number = 0;
		var multiInt:Number = 2;
		var multiWis:Number = 2;
		if (element >= 4) {
			multiInt += 0.4 * (element - 3);
			multiWis += 0.4 * (element - 3);
		}
		if (element >= 7) {
			multiInt += 0.4 * (element - 6);
			multiWis += 0.4 * (element - 6);
		}
		if (element >= 10) {
			multiInt += 0.4 * (element - 9);
			multiWis += 0.4 * (element - 9);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;
		if (type == 1) {
			outputText("You rub your palms together before unleashing the energy in the form of razor sharp winds. [Themonster] eyes grow wide in surprise as your attack leaves deep bleeding cuts in its flesh! ");
			damage = calcGaleMod(damage, true);
			damage = Math.round(damage * combat.windDamageBoostedByDao());
			doWindDamage(damage, true, true);
			if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch)) {
				if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1*combat.BleedDamageBoost());
				else monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.05*combat.BleedDamageBoost(), 0, 0);
			}
		}
		if (type == 2) {
			outputText("You smash both of your fists into the ground, causing vegetation to grow at an accelerated rate. [Themonster] is punched out of nowhere as a grown tree suddenly sprouts from beneath! ");
			damage = calcQuakeMod(damage, true);
			damage = Math.round(damage * combat.earthDamageBoostedByDao());
			doEarthDamage(damage, true, true);
			if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch)) {
				if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
					monster.addStatusValue(StatusEffects.AcidDoT,1,1);
					monster.addStatusValue(StatusEffects.AcidDoT,3,1);
				}
				else monster.createStatusEffect(StatusEffects.AcidDoT,4,0.02,1,0);
			}
		}
		if (type == 3) {
			outputText("You gather energy in your mouth before spitting a pyroclastic mather at your opponent, searing their flesh and setting [themonster] on fire. ");
			damage = calcInfernoMod(damage, true);
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
			if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch)) {
				if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,1);
				else monster.createStatusEffect(StatusEffects.BurnDoT,10,0.02,0,0);
			}
		}
		if (type == 4) {
			outputText("You push both of your palms toward your opponent, your arms turning to a pair of powerful water jets that batters [themonster] with rock crushing pressure! ");
			damage = calcTideMod(damage, true);
			damage = Math.round(damage * combat.waterDamageBoostedByDao());
			doWaterDamage(damage, true, true);
			if (player.isFistOrFistWeapon() && player.hasPerk(PerkLib.ElementalTouch)) {
				monster.statStore.addBuffObject({str:-10,spe:-10}, "Poison",{text:"Poison"});
				if (monster.hasStatusEffect(StatusEffects.FrostburnDoT)) monster.addStatusValue(StatusEffects.FrostburnDoT,1,1);
				else monster.createStatusEffect(StatusEffects.FrostburnDoT,4,0,0,0);
			}
		}
		outputText("\n\n");
		enemyAI();
	}
	public function FusionSpecialSecond(element:Number, type:Number):void {
		clearOutput();
		var soulforcecost:Number = 10 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		player.soulforce -= soulforcecost;
		var temp:Number = 0;
		var multiInt:Number = 2;
		var multiWis:Number = 2;
		if (element >= 4) {
			multiInt += 0.8 * (element - 3);
			multiWis += 0.8* (element - 3);
		}
		if (element >= 7) {
			multiInt += 0.8 * (element - 6);
			multiWis += 0.8 * (element - 6);
		}
		if (element >= 10) {
			multiInt += 0.8 * (element - 9);
			multiWis += 0.8 * (element - 9);
		}
		temp += scalingBonusIntelligence() * multiInt;
		temp += scalingBonusWisdom() * multiWis;
		temp = Math.round(temp);
		if (type == 1) outputText("You soothe your wounds with a calm breeze dulling down the pain.");
		if (type == 2) outputText("You gather energy from sunlight into the vines covering your body, converting the nutrients and repairing some of your sustained damage.");
		if (type == 3) outputText("You channel warmth into your wounds soothing the pain and repairing the damages you sustained.");
		if (type == 4) outputText("You relax and concentrate on your liquid form closing breaches and repairing any damage you sustained.");
		outputText(" <b>([font-heal]+" + temp + "</font>)</b>");
		HPChange(temp,false);
		outputText("\n\n");
		enemyAI();
	}
	public function FusionSpecialTrueEvasion():void {
		clearOutput();
		outputText("You disperse with the ambient air letting things run through you rather than blocking them. Good fucking luck to whoever would want to strike you right now.\n\n");
		player.createStatusEffect(StatusEffects.CooldownTrueEvasion, 10, 0, 0, 0);
		player.createStatusEffect(StatusEffects.TrueEvasion, 3, 0, 0, 0);
		enemyAI();
	}
	public function FusionSpecialAdamantineShell():void {
		clearOutput();
		outputText("You draw strength from the earth, your rock body turning to the metallic sheen and hardness of pure adamantium.\n\n");
		player.createStatusEffect(StatusEffects.CooldownAdamantineShell, 10, 0, 0, 0);
		player.createStatusEffect(StatusEffects.AdamantineShell, 7, 0, 0, 0);
		enemyAI();
	}
	public function FusionSpecialFieryRageActivate():void {
		clearOutput();
		outputText("You let the flame of anger consume you entering a fiery rage.\n\n");
		player.createStatusEffect(StatusEffects.FieryRage, 0, 0, 0, 0);
		enemyAI();
	}
	public function FusionSpecialFieryRageDeactivate():void {
		clearOutput();
		outputText("You extinguish your flames, calming down from your fiery rage.\n\n");
		player.removeStatusEffect(StatusEffects.FieryRage);
		enemyAI();
	}
	public function FusionSpecialMomentOfClarity():void {
		clearOutput();
		outputText("You empty your mind from needless thought turning yourself calm like the immobile water of a pond, only letting the ripple of the moment bother you. Thanks to your inner calm you manage to shrug off the desires that plagues you to concentrate on the ongoing battle with perfect clarity.\n\n");
		player.createStatusEffect(StatusEffects.CooldownMomentOfClarity, 6, 0, 0, 0);
		player.createStatusEffect(StatusEffects.MomentOfClarity, 3, 0, 0, 0);
		enemyAI();
	}

	//Arian's stuff
//Using the Talisman in combat
	public function immolationSpell():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of burning flames gathers around [themonster], slowly burning [monster him].");
		var damage:int = int(100+(player.inte/2 + rand(player.inte)) * spellMod());
		damage = calcInfernoMod(damage, true);
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
//	if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		damage = Math.round(damage);
		doDamage(damage);
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
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of cold air gathers around [themonster], slowly freezing [monster him].");
		var damage:int = int(100+(player.inte/2 + rand(player.inte)) * spellMod());
		damage = calcGlacialMod(damage, true);
		damage = Math.round(damage);
		doIceDamage(damage);
		outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		player.removeStatusEffect(StatusEffects.IcePrisonSpell);
		SceneLib.arianScene.clearTalisman();
		monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		combat.heroBaneProc(damage);
		enemyAI();
	}
}
}