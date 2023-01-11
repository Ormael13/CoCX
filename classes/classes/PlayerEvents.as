package classes {

import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.*;
import classes.IMutations.IMutationsLib;
import classes.Items.*;
import classes.Items.Dynamic.Effects.RaceTfEnchantmentType;
import classes.Races.UnicornRace;
import classes.Scenes.Camp.CampScenes;
import classes.Scenes.Camp.HarvestMoonScenes;
import classes.Scenes.Camp.UniqueCampScenes;
import classes.Scenes.Dreams;
import classes.Scenes.Dungeons.DeepCave.ValaScene;
import classes.Scenes.Holidays;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.NPCs.DriderTown;
import classes.Scenes.NPCs.LilyFollower;
import classes.Scenes.NPCs.LunaFollower;
import classes.Scenes.NPCs.SophieFollowerScene;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.NPCs.ZenjiScenes;
import classes.Scenes.Places.WoodElves;
import classes.Scenes.SceneLib;
import classes.Scenes.Soulforce;
import classes.StatusEffects.VampireThirstEffect;
import classes.lists.BreastCup;

public class PlayerEvents extends BaseContent implements TimeAwareInterface {
		//Handles all timeChange events for the player. Needed because player is not unique.

		public function PlayerEvents():void {
			EventParser.timeAwareClassAdd(this);
		}

		private var campUniqueScene:UniqueCampScenes = new UniqueCampScenes();
		private var campScenes:CampScenes = new CampScenes();
		private var checkedTurkey:int; //Make sure we test each of these events just once in timeChangeLarge
		private var checkedHellhound:int; //Make sure we test each of these events just once in timeChangeLarge
		private var checkedDream:int;
		private var dreams:Dreams = new Dreams();

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean {
			var needNext:Boolean;
			if (time.hours == 6) {
				checkedTurkey = 0;
				checkedHellhound = 0;
				checkedDream = 0;
			}

			if (player.cumMultiplier > 19999) player.cumMultiplier = 19999;
			if (player.ballSize > 400) player.ballSize = 400;
			var maxSlots:int = inventory.getMaxSlots();
			player.itemSlot6.unlocked = maxSlots >= 6;
			player.itemSlot7.unlocked = maxSlots >= 7;
			player.itemSlot8.unlocked = maxSlots >= 8;
			player.itemSlot9.unlocked = maxSlots >= 9;
			player.itemSlot10.unlocked = maxSlots >= 10;
			player.itemSlot11.unlocked = maxSlots >= 11;
			player.itemSlot12.unlocked = maxSlots >= 12;
			player.itemSlot13.unlocked = maxSlots >= 13;
			player.itemSlot14.unlocked = maxSlots >= 14;
			player.itemSlot15.unlocked = maxSlots >= 15;
			player.itemSlot16.unlocked = maxSlots >= 16;
			player.itemSlot17.unlocked = maxSlots >= 17;
			player.itemSlot18.unlocked = maxSlots >= 18;
			player.itemSlot19.unlocked = maxSlots >= 19;
			player.itemSlot20.unlocked = maxSlots >= 20;
			if (flags[kFLAGS.SOCK_COUNTER] > 0) {
				flags[kFLAGS.SOCK_COUNTER]--;
				if (flags[kFLAGS.SOCK_COUNTER] < 0) flags[kFLAGS.SOCK_COUNTER] = 0;
				if (flags[kFLAGS.SOCK_COUNTER] > 24) flags[kFLAGS.SOCK_COUNTER] = 24;
			}
			if (flags[kFLAGS.HUNGER_ENABLED] <= 0 || (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger >= 10)) { //If you're starving, your cum won't build up over time.
				player.hoursSinceCum++;
				//Super cumbuilding activate!
				if (player.hasPerk(PerkLib.MaraesGiftProfractory)) player.hoursSinceCum += 2;
				if (player.hasPerk(PerkLib.FerasBoonAlpha)) player.hoursSinceCum += 2;
			}
			//Normal
			if (!player.hasPerk(PerkLib.WellAdjusted)) {
				dynStats("lus", player.libStat.totalCore * 0.04, "scale", false); //Raise lust
				if (player.hasPerk(PerkLib.Lusty)) dynStats("lus", player.libStat.totalCore * 0.01, "scale", false); //Double lust rise if lusty.
			}
			else { //Well adjusted perk
				dynStats("lus", player.libStat.totalCore * 0.02, "scale", false); //Raise lust
				if (player.hasPerk(PerkLib.Lusty)) dynStats("lus", player.libStat.totalCore * 0.005, "scale", false); //Double lust rise if lusty.
			}
			//Jewelry effect
			if (player.jewelryEffectId == JewelryLib.CORRUPTION)
			{
				if (player.cor < 80) dynStats("cor", (player.jewelryEffectMagnitude/10));
			}
			if (player.jewelryEffectId == JewelryLib.PURITY)
			{
				dynStats("cor", -0.1);
			}
			//Armor
			if (player.armor == armors.LTHCARM)
			{
				if (player.cor < 50) dynStats("cor", 0.05);
				if (player.cor < 80) dynStats("cor", 0.05);
			}
			//Armor
			if (player.armor == armors.LTHCARM)
			{
				if (player.cor < 50) dynStats("cor", 0.05);
				if (player.cor < 80) dynStats("cor", 0.05);
			}
			if (player.armor == armors.DBARMOR)
			{
				dynStats("cor", -0.1);
			}
			//Hunger! No effect if hunger is disabled, even if your hunger is at 0/100.
			Begin("PlayerEvents","hourlyHunger");
			hourlyHunger();
			End("PlayerEvents","hourlyHunger");
			//Evangeline went out for the items counter
			if (flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] > 0) flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS]--;
			//cumOmeter dropping down
			if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 0) {
				/*if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] == 1) */flags[kFLAGS.SEXUAL_FLUIDS_LEVEL]--;/*
				else flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] -= 2;*/
			}
			//Corruption check for achievement.
			if (player.cor >= 80) {
				if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA] == 0 || flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA] == 2) flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA]++
			}
			if (player.cor <= 20) {
				if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA] == 1 || flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA] == 3) flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA]++
			}
			if (player.cor >= 100) {
				if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_CLEAN_SLATE] == 0) flags[kFLAGS.ACHIEVEMENT_PROGRESS_CLEAN_SLATE]++
			}
			if (player.cor <= 0) {
				if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_CLEAN_SLATE] == 1) flags[kFLAGS.ACHIEVEMENT_PROGRESS_CLEAN_SLATE]++
			}
			//Decrement Valeria's fluid in New Game+.
			if (SceneLib.valeria.valeriaFluidsEnabled()) {
				if (flags[kFLAGS.VALERIA_FLUIDS] > 0) {
					flags[kFLAGS.VALERIA_FLUIDS]--;
				}
				else if (player.armor == armors.GOOARMR) {
					dynStats("lus", 2 + (player.lib / 10), "scale", false);
					needNext = true;
				}
				if (flags[kFLAGS.VALERIA_FLUIDS] > 100) flags[kFLAGS.VALERIA_FLUIDS] = 100;
			}
			//Camp npc's training time countdown timers
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) {
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers1) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 1, -1);
				if (player.statusEffectv2(StatusEffects.CampSparingNpcsTimers1) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 2, -1);
				if (player.statusEffectv3(StatusEffects.CampSparingNpcsTimers1) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 3, -1);
				if (player.statusEffectv4(StatusEffects.CampSparingNpcsTimers1) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, -1);
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers1) <= 0 && player.statusEffectv2(StatusEffects.CampSparingNpcsTimers1) <= 0 && player.statusEffectv3(StatusEffects.CampSparingNpcsTimers1) <= 0 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers1) <= 0) {
					player.removeStatusEffect(StatusEffects.CampSparingNpcsTimers1);
				}
			}
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) {
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers2) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, -1);
				if (player.statusEffectv2(StatusEffects.CampSparingNpcsTimers2) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 2, -1);
				if (player.statusEffectv3(StatusEffects.CampSparingNpcsTimers2) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 3, -1);
				if (player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, -1);
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers2) <= 0 && player.statusEffectv2(StatusEffects.CampSparingNpcsTimers2) <= 0 && player.statusEffectv3(StatusEffects.CampSparingNpcsTimers2) <= 0 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) <= 0) {
					player.removeStatusEffect(StatusEffects.CampSparingNpcsTimers2);
				}
			}
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) {
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers3) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, -1);
				if (player.statusEffectv2(StatusEffects.CampSparingNpcsTimers3) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, -1);
				if (player.statusEffectv3(StatusEffects.CampSparingNpcsTimers3) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, -1);
				if (player.statusEffectv4(StatusEffects.CampSparingNpcsTimers3) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 4, -1);
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers3) <= 0 && player.statusEffectv2(StatusEffects.CampSparingNpcsTimers3) <= 0 && player.statusEffectv3(StatusEffects.CampSparingNpcsTimers3) <= 0 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers3) <= 0) {
					player.removeStatusEffect(StatusEffects.CampSparingNpcsTimers3);
				}
			}
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) {
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 1, -1);
				if (player.statusEffectv2(StatusEffects.CampSparingNpcsTimers4) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, -1);
				if (player.statusEffectv3(StatusEffects.CampSparingNpcsTimers4) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 3, -1);
				if (player.statusEffectv4(StatusEffects.CampSparingNpcsTimers4) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 4, -1);
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) <= 0 && player.statusEffectv2(StatusEffects.CampSparingNpcsTimers4) <= 0 && player.statusEffectv3(StatusEffects.CampSparingNpcsTimers4) <= 0 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers4) <= 0) {
					player.removeStatusEffect(StatusEffects.CampSparingNpcsTimers4);
				}
			}
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers5)) {
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers5) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers5, 1, -1);
				if (player.statusEffectv2(StatusEffects.CampSparingNpcsTimers5) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers5, 2, -1);
				if (player.statusEffectv3(StatusEffects.CampSparingNpcsTimers5) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers5, 3, -1);
				if (player.statusEffectv4(StatusEffects.CampSparingNpcsTimers5) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers5, 4, -1);
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers5) <= 0 && player.statusEffectv2(StatusEffects.CampSparingNpcsTimers5) <= 0 && player.statusEffectv3(StatusEffects.CampSparingNpcsTimers5) <= 0 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers5) <= 0) {
					player.removeStatusEffect(StatusEffects.CampSparingNpcsTimers5);
				}
			}
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers6)) {
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers6) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers6, 1, -1);
				if (player.statusEffectv2(StatusEffects.CampSparingNpcsTimers6) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers6, 2, -1);
				if (player.statusEffectv3(StatusEffects.CampSparingNpcsTimers6) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers6, 3, -1);
				if (player.statusEffectv4(StatusEffects.CampSparingNpcsTimers6) > 0) player.addStatusValue(StatusEffects.CampSparingNpcsTimers6, 4, -1);
				if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers6) <= 0 && player.statusEffectv2(StatusEffects.CampSparingNpcsTimers6) <= 0 && player.statusEffectv3(StatusEffects.CampSparingNpcsTimers6) <= 0 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers6) <= 0) {
					player.removeStatusEffect(StatusEffects.CampSparingNpcsTimers6);
				}
			}
			//Ayo Armors SF drain
			if (player.isInAyoArmor() && flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) {
				if (player.armor == armors.LAYOARM) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 60;
				if (player.armor == armors.HAYOARM) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 120;
				if (player.armor == armors.UHAYOARM) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 240;
				if (player.armor == armors.HBARMOR) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 180;
				if (player.vehicles == vehicles.HB_MECH) {
					/*if (upgrade 1) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= ?40?;
					else */flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 60;
				}
				if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] <= 0) {
					player.buff("Ayo Armor").remove();
					flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
					outputText("\nYour ayo armor power reserves reached bottom. With a silent hiss armor depowers itself making you feel slower and heavier.\n");
					if (player.armor == armors.LAYOARM) player.buff("Ayo Armor").addStats( {"str": -10, "spe": -10} );
					if (player.armor == armors.HAYOARM) player.buff("Ayo Armor").addStats( {"str": -20, "spe": -20} );
					if (player.armor == armors.UHAYOARM) player.buff("Ayo Armor").addStats( {"str": -50, "spe": -50} );
					if (player.armor == armors.HBARMOR) player.buff("Ayo Armor").addStats( {"str": -30, "spe": -30} );
					EngineCore.statScreenRefresh();
					needNext = true;
				}
			}
			//Sidonie checks
			if (flags[kFLAGS.SIDONIE_RECOLLECTION] > 0) flags[kFLAGS.SIDONIE_RECOLLECTION]--;
			if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) {
				if (flags[kFLAGS.LUNA_JEALOUSY] < 400) flags[kFLAGS.LUNA_JEALOUSY]++;
				if ((flags[kFLAGS.LUNA_FOLLOWER] %2 == 0 && flags[kFLAGS.LUNA_FOLLOWER] > 4) && flags[kFLAGS.LUNA_JEALOUSY] < 100) flags[kFLAGS.LUNA_FOLLOWER]--;
				if ((flags[kFLAGS.LUNA_FOLLOWER] %2 == 1) && flags[kFLAGS.LUNA_JEALOUSY] >= 100 && (CoC.instance.model.time.hours > 6 && CoC.instance.model.time.hours < 23)) SceneLib.lunaFollower.warrningAboutJelously();
			}
			//Zenji loneliness
			if (ZenjiScenes.isLover()) player.addStatusValue(StatusEffects.ZenjiModificationsList, 1, 1);
			//Tripxi firearms restoration progress
			if (player.statusEffectv3(StatusEffects.TelAdreTripxi) > 0) player.addStatusValue(StatusEffects.TelAdreTripxi, 3, -1);
			//
			if (player.hasStatusEffect(StatusEffects.WendigoPsychosis)) {
				player.addStatusValue(StatusEffects.WendigoPsychosis, 1, -1);
				if (player.statusEffectv1(StatusEffects.WendigoPsychosis) <= 0) player.removeStatusEffect(StatusEffects.WendigoPsychosis);
			}
			if (InCollection("Kiha", flags[kFLAGS.PLAYER_COMPANION_0], flags[kFLAGS.PLAYER_COMPANION_2], flags[kFLAGS.PLAYER_COMPANION_3])) {
				outputText("\nKiha waves to you as she leaves your side. You can call her to battle again next time, or ask her to be your main combat companion.\n");
				if (flags[kFLAGS.PLAYER_COMPANION_0] == "Kiha") flags[kFLAGS.PLAYER_COMPANION_0] = "";
				if (flags[kFLAGS.PLAYER_COMPANION_2] == "Kiha") flags[kFLAGS.PLAYER_COMPANION_2] = "";
				if (flags[kFLAGS.PLAYER_COMPANION_3] == "Kiha") flags[kFLAGS.PLAYER_COMPANION_3] = "";
				player.removeStatusEffect(StatusEffects.CombatFollowerKiha);
				needNext = true;
			}
			//
			for each (var clone:StatusEffectType in Soulforce.clones) {
				if (player.hasStatusEffect(clone)) {
					var cloneDao:int = player.statusEffectv1(clone);
					if (cloneDao > 10 && cloneDao < 21) {
						for (var i:int = 0; i < Soulforce.daos.length; ++i) {
							if (Soulforce.daos[i][2] == cloneDao && player.statusEffectv2(Soulforce.daos[i][1]) < SceneLib.soulforce.highestLayerOfDaoComprehension())
								SceneLib.soulforce.daoContemplationsEffect(Soulforce.daos[i][1], Soulforce.daos[i][0], true);
						}
					}
				}
			}
			//
			if (player.hasStatusEffect(StatusEffects.DinahGift)) {
				if (player.statusEffectv1(StatusEffects.DinahGift) <= 0) player.removeStatusEffect(StatusEffects.DinahGift);
				else player.addStatusValue(StatusEffects.DinahGift, 1, -1);
			}
			//Spooders pregnancy
			if (DriderTown.BelisaPregnancy > 1) DriderTown.BelisaPregnancy -= 1;
			if (DriderTown.BelisaKidsEggsHatching > 1) DriderTown.BelisaKidsEggsHatching -= 1;
			if (DriderTown.BelisaKidsEggsHatching1 > 1) DriderTown.BelisaKidsEggsHatching1 -= 1;
			if (DriderTown.BelisaKidsEggsHatching2 > 1) DriderTown.BelisaKidsEggsHatching2 -= 1;
			if (DriderTown.LilyKidsPCPregnancy > 1) DriderTown.LilyKidsPCPregnancy -= 1;
			if (DriderTown.LilyKidsPCEggsHatching > 1) DriderTown.LilyKidsPCEggsHatching -= 1;
			if (DriderTown.LilyKidsPCEggsHatching1 > 1) DriderTown.LilyKidsPCEggsHatching1 -= 1;
			if (DriderTown.LilyKidsPCEggsHatching2 > 1) DriderTown.LilyKidsPCEggsHatching2 -= 1;
			if (DriderTown.TyrantiaPregnancy > 1) DriderTown.TyrantiaPregnancy -= 1;
			if (DriderTown.TyrantiaKidsEggsHatching > 1) DriderTown.TyrantiaKidsEggsHatching -= 1;
			if (DriderTown.TyrantiaKidsEggsHatching1 > 1) DriderTown.TyrantiaKidsEggsHatching1 -= 1;
			if (DriderTown.TyrantiaKidsEggsHatching2 > 1) DriderTown.TyrantiaKidsEggsHatching2 -= 1;
			//Alter max speed if you have oversized parts. (Realistic mode)
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				//Balls
				var tempSpeedPenalty:Number = 0;
				var lim:int = player.isTaur() ? 9 : 4;
				if (player.ballSize > lim && player.hasBalls()) tempSpeedPenalty += Math.round((player.ballSize - lim) / 2);
				//Breasts
				lim = player.isTaur() ? BreastCup.I : BreastCup.G;
				if (player.hasBreasts() && player.biggestTitSize() > lim) tempSpeedPenalty += ((player.biggestTitSize() - lim) / 2);
				//Cocks
				lim = player.isTaur() ? 72 : 24;
				if (player.biggestCockArea() > lim) tempSpeedPenalty += ((player.biggestCockArea() - lim) / 6);
				//Min-cap
				var penaltyMultiplier:Number = 1;
				penaltyMultiplier -= player.str * 0.1;
				penaltyMultiplier -= (player.tallness - 72) / 168;
				if (penaltyMultiplier < 0.4) penaltyMultiplier = 0.4;
				tempSpeedPenalty *= penaltyMultiplier;
				player.buff("RealisticMode").setStat("spe.mult",-tempSpeedPenalty/100).withText("Oversized Endowments");
			}
			else{
				player.buff("RealisticMode").remove();
			}
			Begin("PlayerEvents","hourlyCheckRacialPerks");
			if (!needNext) needNext = hourlyCheckRacialPerks();
			End("PlayerEvents","hourlyCheckRacialPerks");
			if (player.hasStatusEffect(StatusEffects.Feeder)) { //Feeder checks
				if (player.cor <= (20-player.corruptionTolerance)) { //Go away if pure
					outputText("\nThe desire to breastfeed fades into the background.  It must have been associated with the corruption inside you.\n\n(<b>You have lost the 'Feeder' perk.</b>)\n");
					player.removeStatusEffect(StatusEffects.Feeder);
					player.removePerk(PerkLib.Feeder);
					needNext = true;
				}
				else { //Bigga titayz
					if (player.breastRows[0].breastRating < 5) {
						outputText("\nYour [breasts] start to jiggle and wobble as time passes, seeming to refill with your inexhaustible supply of milk.  It doesn't look like you'll be able to keep them below a DD cup so long as you're so focused on breast-feeding.\n");
						player.breastRows[0].breastRating = 5;
						needNext = true;
					}
					player.addStatusValue(StatusEffects.Feeder, 2, 1); //Increase 'time since breastfed'
					//trace("Feeder status: " + player.statusEffectv2(StatusEffects.Feeder) + " (modded " + ((player.statusEffectv2(StatusEffects.Feeder)) - 70) + ")");
					//After 3 days without feeding someone sensitivity jumps.
                    if (player.statusEffectv2(StatusEffects.Feeder) >= 72 && CoC.instance.model.time.hours == 14 && player.weaponRange != weaponsrange.LBLASTR) {
                        outputText("\n<b>After having gone so long without feeding your milk to someone, you're starting to feel strange.  Every inch of your skin practically thrums with sensitivity, particularly your sore, dripping nipples.</b>\n");
						player.dynStats("sen", 2 + (((player.statusEffectv2(StatusEffects.Feeder)) - 70) / 20));
						needNext = true;
					}
				}
			}
			if (player.hasStatusEffect(StatusEffects.WormPlugged) && flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] == 0) { //Update worm drippy-cooch
				if (player.hasVagina()) {
					if (rand(5) == 0) {
						flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] = 1;
						outputText("\nA sudden gush of semen-coated worms noisily slurps out of your womb.  It runs down your legs as the worms do their damnedest to escape.  The feeling of so many squiggling forms squirting through your cunt-lips turns you on more than you'd like to admit.  You wonder why they stayed as long as they did, and some part of you worries that their stay may have reduced your capacity to bear children, though in a place like this that might be a blessing.\n");
						player.dynStats("lus", 2 + player.effectiveSensitivity() / 10, "scale", false);
						if (player.fertility > 5) player.fertility -= (1 + Math.round(player.fertility / 4));
						player.addStatusValue(StatusEffects.WormPlugged, 1, -1); //Lower chances
						if (player.statusEffectv1(StatusEffects.WormPlugged) <= 0) { //Remove if too low
							player.removeStatusEffect(StatusEffects.WormPlugged);
							player.knockUpForce(); //Clear worm 'pregnancy'
						}
						needNext = true;
					}
				}
				else { //Non cunts lose worm plugged
					player.removeStatusEffect(StatusEffects.WormPlugged);
					player.knockUpForce(); //Clear worm 'pregnancy'
				}
			}
			if (player.hasStatusEffect(StatusEffects.Milked)) { //"Milked"
				player.addStatusValue(StatusEffects.Milked, 1, -1);
				if (player.statusEffectv1(StatusEffects.Milked) <= 0) {
					outputText("\n<b>Your [nipples] are no longer sore from the milking.</b>\n");
					player.removeStatusEffect(StatusEffects.Milked);
					needNext = true;
				}
			}
			if (player.hasStatusEffect(StatusEffects.Jizzpants)) {
				outputText("\nYour [armor] squishes wetly with all the semen you unloaded into them, arousing you more and more with every movement.\n");
				player.dynStats("lus", 10 + player.effectiveSensitivity() / 5, "scale", false);
				player.removeStatusEffect(StatusEffects.Jizzpants);
				needNext = true;
			}
			if (player.hasStatusEffect(StatusEffects.Dysfunction)) {
				if (player.statusEffectv1(StatusEffects.Dysfunction) <= 1) {
					player.removeStatusEffect(StatusEffects.Dysfunction);
					outputText("\nYou feel a tingling in your nethers... at last full sensation has returned to your groin.  <b>You can masturbate again!</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.Dysfunction, 1, -1);
			}
            //Lactation reduction
            if (player.biggestLactation() > 0 && !player.hasStatusEffect(StatusEffects.Feeder) && !player.hasPerk(PerkLib.MilkMaid) && player.pregnancyIncubation == 0) {
                if (!player.hasStatusEffect(StatusEffects.LactationReduction))
                    player.createStatusEffect(StatusEffects.LactationReduction, 0, 0, 0, 0);
                else {//reduction effect
                    player.addStatusValue(StatusEffects.LactationReduction, 1, 1); //increase timer
                    //first warning
                    if (player.statusEffectv1(StatusEffects.LactationReduction) == 48 && player.biggestLactation() >= 1)
                        outputText("\n<b>Your " + Appearance.nippleDescription(player, 0) + "s feel swollen and bloated, needing to be milked.</b>\n");
                    if (player.statusEffectv1(StatusEffects.LactationReduction) > 48) {
                        var before:Number = player.biggestLactation();
                        player.boostLactation(-0.5 * player.breastRows.length / 24); //decrease by 0.5 each day
                        var after:Number = player.biggestLactation();
                        //compare and show message
                        if (before > 2.5 && after <= 2.5) {
						    outputText("\n<b>Your breasts feel lighter as your body's milk production winds down.</b>\n");
						    needNext = true;
                        }
                        if (before > 1.5 && after <= 1.5) {
						    outputText("\n<b>Your body's milk output drops down to what would be considered 'normal' for a pregnant woman.</b>\n");
						    needNext = true;
                        }
                        if (before > 1.0 && after <= 1.0) {
						    outputText("\n<b>Your body no longer produces any milk.</b>\n");
						    needNext = true;
                        }
                    }
                }
            }
			if (player.hasStatusEffect(StatusEffects.CuntStretched)) { //Cunt stretching stuff
				player.addStatusValue(StatusEffects.CuntStretched, 1, 1);
				if (player.vaginas.length > 0) {
					if (!player.hasPerk(PerkLib.FerasBoonWideOpen)) {
						if ((player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE && player.statusEffectv1(StatusEffects.CuntStretched) >= 200) ||
							(player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING && player.statusEffectv1(StatusEffects.CuntStretched) >= 100) ||
							(player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE && player.statusEffectv1(StatusEffects.CuntStretched) >= 70)) {
							outputText("\nYour [vagina] recovers from your ordeals and becomes tighter.\n");
							player.vaginas[0].vaginalLooseness--;
							player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
							needNext = true;
						}
					}
					if (player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR && player.statusEffectv1(StatusEffects.CuntStretched) >= 50) {
						outputText("\nYour [vagina] recovers from the brutal stretching it has received and tightens up a little bit, but not much.\n");
						player.vaginas[0].vaginalLooseness--;
						player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
						needNext = true;
					}
				}
			}
			if (player.hasStatusEffect(StatusEffects.ButtStretched)) { //Butt stretching stuff
				player.addStatusValue(StatusEffects.ButtStretched, 1, 1);
				if ((player.ass.analLooseness == 2 && player.statusEffectv1(StatusEffects.ButtStretched) >= 72) ||
					(player.ass.analLooseness == 3 && player.statusEffectv1(StatusEffects.ButtStretched) >= 48) ||
					(player.ass.analLooseness == 4 && player.statusEffectv1(StatusEffects.ButtStretched) >= 24) ||
					(player.ass.analLooseness == 5 && player.statusEffectv1(StatusEffects.ButtStretched) >= 12)) {
					outputText("\n<b>Your [asshole] recovers from the brutal stretching it has received and tightens up.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
			}
			//Salamander bullshit
			if (player.isRaceCached(Races.SALAMANDER,2) && !player.hasPerk(PerkLib.LustingWarrior) && player.hasStatusEffect(StatusEffects.Overheat))
			{

				outputText("\n\nYour so horny right now... so damn horny, you would beat up someone if only for something to blow up the steam." +
						" As the thought rush to your mind your body react strangely it would seem your overwelming need as a salamander and your ability to lustzerk has actualy unlocked some form of new power within you." +
						" You feel newfound strength, the strength required to defeat any adversary if only for a chance to fuck and you are very keen on using it right about now.");
				player.createPerk(PerkLib.LustingWarrior, 0, 0, 0,0);
				needNext = true;
			}
			if (!player.isRaceCached(Races.SALAMANDER, 2) && player.hasPerk(PerkLib.LustingWarrior))
			{
				outputText("\n\nAs you become less of a salamander the prodigious strength granted to you by your incontrollable libido recedes.");
				player.removePerk(PerkLib.LustingWarrior);
				needNext = true;
			}

			if (!player.hasStatusEffect(StatusEffects.Overheat) && (player.isRaceCached(Races.SALAMANDER) || player.isRaceCached(Races.KITSHOO) || player.isRaceCached(Races.HELLCAT) || player.hasStatusEffect(StatusEffects.HinezumiCoat)))
			{
				//Argument 1 is weither pc is in heat stage or not 1 means active
				//Argument 2 is how many day left before player enter heats again typicaly 3;
				//Argument 3 tells if player had sex and satisfied its overheat set to 1 when true;
				outputText("\n\nWoa your body is heating up like crazy. You suddenly realise that due to being a");
				if (player.isRaceCached(Races.SALAMANDER)) outputText(" salamander");
				else if (player.isRaceCached(Races.KITSHOO)) outputText(" kitshoo");
				else if (player.isRaceCached(Races.HELLCAT)) outputText(" hellcat");
				else outputText(" hinezumi");
				outputText(" your body has started overheating with lust. You will have to constantly sate your uncontrollable burning need for sex if only to stay sane long enough not to jump on everything that moves.");
				player.createStatusEffect(StatusEffects.Overheat, 1, 0, 0,0);
				if (player.hasCock() || (player.gender == 3 && rand(2) == 0)) player.goIntoRut(false);
				else if (player.hasVagina()) player.goIntoHeat(false);
				needNext = true;
			}
			if (player.hasStatusEffect(StatusEffects.Overheat) && (!player.isRaceCached(Races.SALAMANDER) && !player.isRaceCached(Races.KITSHOO) && !player.isRaceCached(Races.HELLCAT) && !player.hasStatusEffect(StatusEffects.HinezumiCoat)))
			{
				outputText("\n\nYour body finally calms down. It would seem you are no longer as hot as you used to be, which might be a good thing as you won't have to deal with heat problems... for now.");
				player.removeStatusEffect(StatusEffects.Overheat);
				player.removeStatusEffect(StatusEffects.Heat);
				player.removeStatusEffect(StatusEffects.Rut);
				player.statStore.removeBuffs("Overheat");
				needNext = true;
			}
			//Player overheat was cleaned by sex!
			if (player.statusEffectv1(StatusEffects.Overheat) == 1 && player.statusEffectv3(StatusEffects.Overheat) == 1) {
				player.addStatusValue(StatusEffects.Overheat, 1, -1);
				player.addStatusValue(StatusEffects.Overheat, 2, 3);
				player.addStatusValue(StatusEffects.Overheat, 3, -1);
				player.statStore.removeBuffs("Overheat");
				player.removeStatusEffect(StatusEffects.Heat);
				player.removeStatusEffect(StatusEffects.Rut);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.SlimeCore)) { //Lose slime core perk
				if (player.rearBody.type != RearBody.METAMORPHIC_GOO || player.arms.type != Arms.GOO || !LowerBody.isGoo(player)) {
                    outputText("\nYour form ripples, as if uncertain at the changes your body is undergoing.  The goo of your flesh cools, its sensitive, responsive membrane thickening into [skin] while bones and muscles knit themselves into a cohesive torso, chest and hips gaining definition.  Translucent ooze clouds and the gushing puddle at your feet melts together, splitting into solid trunks as you regain your legs.  Before long, you can no longer see through your own body and, with an unsteady shiver, you pat yourself down, readjusting to solidity.  A lurching heat in your chest suddenly reminds you of the slime core that used to float inside you.  Gingerly touching your " + CoC.instance.player.chestDesc() + ", you can feel a small, second heartbeat under your ribs that gradually seems to be sinking, past your belly. A lurching wave of warmth sparks through you, knocking you off your fresh legs and onto your " + Appearance.buttDescription(player) + ".  A delicious pressure pulses in your abdomen and you loosen your [armor] as sweat beads down your neck.  You clench your eyes, tongue lolling in your mouth, and the pressure builds and builds until, in ecstatic release, your body arches in an orgasmic release.\n\n");
                    outputText("\nPanting, you open your eyes and see that, for once, the source of your climax wasn't your loins.  Feeling a warm, wetness on your abs, you investigate and find the small, heart-shaped nucleus that used to be inside your body has somehow managed to pass through your belly button. Exposed to the open air, the crimson organ slowly crystallizes, shrinking and hardening into a tiny ruby.  Rubbing the stone with your thumb, you're surprised to find that you can still feel a pulse within its glittering facets.  You stow the ruby heart, in case you need it again.\n");
					player.createKeyItem("Ruby Heart", 0, 0, 0, 0); //[Add 'Ruby Heart' to key items. Player regains slime core if returning to goo body]
					player.removePerk(PerkLib.SlimeCore);
					needNext = true;
				}
			}
			if (player.hasKeyItem("Ruby Heart") >= 0) { //Regain slime core
				if (player.hasStatusEffect(StatusEffects.SlimeCraving) && !player.hasPerk(PerkLib.SlimeCore) && player.isGoo() && player.rearBody.type == RearBody.METAMORPHIC_GOO && player.arms.type == Arms.GOO) {
					outputText("\nAs you adjust to your new, goo-like body, you remember the ruby heart you expelled so long ago.  As you reach to pick it up, it quivers and pulses with a warm, cheerful light.  Your fingers close on it and the nucleus slides through your palm, into your body!\n\n");
					outputText("There is a momentary pressure in your chest and a few memories that are not your own flicker before your eyes.  The dizzying sight passes and the slime core settles within your body, imprinted with your personality and experiences.  There is a comforting calmness from your new nucleus and you feel as though, with your new memories, you will be better able to manage your body's fluid requirements.\n");
					//(Reduces Fluid Addiction to a 24 hour intake requirement).
					outputText("(<b>Gained New Perk: Slime Core - Moisture craving builds at a greatly reduced rate.</b>\n)");
					player.createPerk(PerkLib.SlimeCore, 0, 0, 0, 0);
					player.removeKeyItem("Ruby Heart");
					needNext = true;
				}
			}
			if (player.hasPerk(PerkLib.DarkSlimeCore)) { //Lose DARK slime core perk
				if (player.rearBody.type != RearBody.METAMORPHIC_GOO || player.arms.type != Arms.GOO || !LowerBody.isGoo(player)) {
					outputText("\nYour form ripples, as if uncertain at the changes your body is undergoing.  The goo of your flesh cools, its sensitive, responsive membrane thickening into [skin] while bones and muscles knit themselves into a cohesive torso, chest and hips gaining definition.  Translucent ooze clouds and the gushing puddle at your feet melts together, splitting into solid trunks as you regain your legs.  Before long, you can no longer see through your own body and, with an unsteady shiver, you pat yourself down, readjusting to solidity.  A lurching heat in your chest suddenly reminds you of the slime core that used to float inside you.  Gingerly touching your " + CoC.instance.player.chestDesc() + ", you can feel a small, second heartbeat under your ribs that gradually seems to be sinking, past your belly. A lurching wave of warmth sparks through you, knocking you off your fresh legs and onto your " + Appearance.buttDescription(player) + ".  A delicious pressure pulses in your abdomen and you loosen your [armor] as sweat beads down your neck.  You clench your eyes, tongue lolling in your mouth, and the pressure builds and builds until, in ecstatic release, your body arches in an orgasmic release.\n\n");
					outputText("\nPanting, you open your eyes and see that, for once, the source of your climax wasn't your loins.  Feeling a warm, wetness on your abs, you investigate and find the small, heart-shaped nucleus that used to be inside your body has somehow managed to pass through your belly button. Exposed to the open air, the crimson organ slowly crystallizes, shrinking and hardening into a tiny ruby.  Rubbing the stone with your thumb, you're surprised to find that you can still feel a pulse within its glittering facets.  You stow the ruby heart, in case you need it again.\n");
					player.createKeyItem("Ruby Orb", 0, 0, 0, 0); //[Add 'Ruby Heart' to key items. Player regains slime core if returning to goo body]
					player.removePerk(PerkLib.DarkSlimeCore);
					needNext = true;
				}
			}
			if (player.hasKeyItem("Ruby Orb") >= 0) { //Regain DARK slime core
				if (player.hasStatusEffect(StatusEffects.SlimeCraving) && !player.hasPerk(PerkLib.DarkSlimeCore) && player.isGoo() && player.rearBody.type == RearBody.METAMORPHIC_GOO && player.arms.type == Arms.GOO && LowerBody.isGoo(player)) {
					outputText("\nAs you adjust to your new, goo-like body, you remember the ruby heart you expelled so long ago.  As you reach to pick it up, it quivers and pulses with a warm, cheerful light.  Your fingers close on it and the nucleus slides through your palm, into your body!\n\n");
					outputText("There is a momentary pressure in your chest and a few memories that are not your own flicker before your eyes.  The dizzying sight passes and the slime core settles within your body, imprinted with your personality and experiences.  There is a comforting calmness from your new nucleus and you feel as though, with your new memories, you will be better able to manage your body's fluid requirements.\n");
					//(Reduces Fluid Addiction to a 24 hour intake requirement).
					outputText("(<b>Gained New Perk: Dark Slime Core - Moisture craving builds at a greatly reduced rate.</b>\n)");
					player.createPerk(PerkLib.DarkSlimeCore, 0, 0, 0, 0);
					player.removeKeyItem("Ruby Orb");
					needNext = true;
				}
			}
			if (player.hasStatusEffect(StatusEffects.SlimeCraving)) { //Slime craving stuff
				if (player.rearBody.type != RearBody.METAMORPHIC_GOO || player.arms.type != Arms.GOO || !LowerBody.isGoo(player)) {
					outputText("\n<b>You no longer feel the need to stockpile fluids in your body. Geeze just how much of a slut did this make you?</b>\n");
					player.removeStatusEffect(StatusEffects.SlimeCraving);
					player.removeStatusEffect(StatusEffects.SlimeCravingFeed);
					player.buff("Fluid Growth").remove();
					needNext = true;
				}
				else { //Slime core reduces fluid need rate
					if (player.isSlime())
						player.addStatusValue(StatusEffects.SlimeCraving, 1, 0.5);
					else player.addStatusValue(StatusEffects.SlimeCraving, 1, 1);
					if (player.statusEffectv1(StatusEffects.SlimeCraving) >= 18) {
						if (!player.hasStatusEffect(StatusEffects.SlimeCravingOutput)) { //Protects against this warning appearing multiple times in the output
							player.createStatusEffect(StatusEffects.SlimeCravingOutput, 0, 0, 0, 0);
							outputText("\n<b>Bigger... stronger, each intake of fluid you take only makes you more starved for the next as you grow in power each time, the need to fuck and feed slowly overwriting any other desire you may have.</b>\n");
							needNext = true;
						}
						if (player.spe > 1) player.addStatusValue(StatusEffects.SlimeCraving, 3, 0.1); //Keep track of how much has been taken from speed
						player.dynStats("str",-1,"spe", -0.1, "lus", 2);
						player.buff("Fluid Growth").addStat("tou.mult",-0.04,0).withText("Fluid Growth!");
						player.buff("Fluid Growth").addStat("int.mult",-0.04,0).withText("Fluid Growth!");
						player.addStatusValue(StatusEffects.SlimeCraving, 2, 0.1); //Keep track of how much has been taken from strength
					}
				}
			}
			if (player.hasStatusEffect(StatusEffects.SlimeCravingFeed)) { //Slime feeding stuff
				outputText("\n<b>You feel revitalized from your recent intake, but soon you'll need more...</b>\n");
				player.dynStats( "spe", player.statusEffectv3(StatusEffects.SlimeCraving)); //Boost speed and restore half the player's lost strength
				player.removeStatusEffect(StatusEffects.SlimeCravingFeed); //Remove feed succuss status so it can be reset
				player.removeCurse("str",1, 2);
				player.changeStatusValue(StatusEffects.SlimeCraving, 2, 0); //Reset stored hp/toughness values
				needNext = true;
			}
			if (!player.hasPerk(PerkLib.FluidBody) && player.isGoo() && (player.isAnyRace(Races.SLIME, Races.MAGMASLIME, Races.DARKSLIME))) {
				outputText("\nWoa your body is so malleable now attacks running through you can't damage you much anymore. This said the feeling of being penetrated by just anything leaves you with mind melting pleasure.\n(<b>Gained New Perk: Fluid Body.</b>)\n");
				player.createPerk(PerkLib.FluidBody, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.FluidBody) && !player.isGoo() && (!player.isAnyRace(Races.SLIME, Races.MAGMASLIME, Races.DARKSLIME))) {
				outputText("\nYour body no longer being slime enough you worry that weapon will draw blood the next time they strike you as you lose your fluidic nature.\n(<b>Lost Perk: Fluid Body.</b>)\n");
				player.removePerk(PerkLib.FluidBody);
				needNext = true;
			}
			if (player.rearBody.type == RearBody.METAMORPHIC_GOO && !LowerBody.isGoo(player)) {
				outputText("\n<b>Your body becomes way less malleable due to being less slime like.</b>\n");
				player.rearBody.type = RearBody.NONE;
				needNext = true;
			}
			if (!player.hasPerk(PerkLib.MorphicWeaponry) && (player.isRace(Races.DARKSLIME, 2) || player.isRace(Races.SLIME,2) || player.isRace(Races.MAGMASLIME, 2)) && player.buff("Fluid Growth").getValueOfStatBuff("tou.mult") > 50){
				player.createPerk(PerkLib.MorphicWeaponry,0,0,0,0);
				outputText("\nYour body has become so bloated with fluids and so large that you gain the ability to use your excess mass to form any number of additionnal tendrils wich you can use to attack your opponents.\n(<b>Gained New Perk: Morphic Weaponry.</b>\n>\n");
			}
			if (player.hasPerk(PerkLib.MorphicWeaponry) && ((!player.isRace(Races.DARKSLIME, 2) && !player.isRace(Races.SLIME,2) && !player.isRace(Races.MAGMASLIME, 2)) && player.buff("Fluid Growth").getValueOfStatBuff("tou.mult") <= 50)){
				player.removePerk(PerkLib.MorphicWeaponry);
				if((!player.isRace(Races.DARKSLIME, 2) && !player.isRace(Races.SLIME,2) && !player.isRace(Races.MAGMASLIME,2))){
					outputText("\nAs you are mo longer a slime, you can't use the morphic weaponry ability anymore.\n(<b>Lost Perk: Morphic Weaponry.</b>\n>\n");
				}
				else{
					outputText("\nHaving lost fluids, you no longer have enough body mass to produce extra tendril attacks.\n(<b>Lost Perk: Morphic Weaponry.</b>\n>\n");
				}
			}
			if (player.hasStatusEffect(StatusEffects.Fullness)) {
				player.addStatusValue(StatusEffects.Fullness, 1, -1);
				if (player.statusEffectv1(StatusEffects.Fullness) <= 0) player.removeStatusEffect(StatusEffects.Fullness);
			}
			if (player.hasStatusEffect(StatusEffects.AndysSmoke)) {
				player.addStatusValue(StatusEffects.AndysSmoke, 1, -1);
				if (player.statusEffectv1(StatusEffects.AndysSmoke) <= 0) {
					outputText("\n<b>The change in your mental prowess confirms that the effects of Nepenthe must have worn off.</b>\n");
					var tempSpe:int = player.statusEffectv2(StatusEffects.AndysSmoke);
					var tempInt:int = player.statusEffectv3(StatusEffects.AndysSmoke);
					player.removeStatusEffect(StatusEffects.AndysSmoke);
					dynStats("spe", -tempSpe, "inte", -tempInt); //Properly revert speed and intelligence.
					needNext = true;
				}
			}
			if (player.hasStatusEffect(StatusEffects.BlessingOfDivineFera)) {
				player.addStatusValue(StatusEffects.BlessingOfDivineFera, 1, -1);
				if (player.statusEffectv1(StatusEffects.BlessingOfDivineFera) <= 0) {
					outputText("\n<b>The divine blessing starts to fade. You think it’s high time you go back to the temple and pray.</b>\n");
					player.removeStatusEffect(StatusEffects.BlessingOfDivineFera);
					needNext = true;
				}
			}
			if (player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae)) {
				player.addStatusValue(StatusEffects.BlessingOfDivineMarae, 1, -1);
				if (player.statusEffectv1(StatusEffects.BlessingOfDivineMarae) <= 0) {
					outputText("\n<b>The divine blessing starts to fade. You think it’s high time you go back to the temple and pray.</b>\n");
					player.removeStatusEffect(StatusEffects.BlessingOfDivineMarae);
					needNext = true;
				}
			}
            if (camp.IsSleeping && player.armorName == "bimbo skirt" && rand(10) == 0 && player.biggestTitSize() < 12) {
                outputText("\n<b>As you wake up, you feel a strange tingling starting in your nipples that extends down into your breasts.  After a minute, the tingling dissipates in a soothing wave.  As you cup your tits, you realize they've gotten larger!</b>");
				player.growTits(1, player.bRows(), false, 2);
				player.dynStats("lus", 10, "scale", false);
				needNext = true;
			}
			if (flags[kFLAGS.BIKINI_ARMOR_BONUS] > 0) {
				if (player.armorName == "lusty maiden's armor") {
                    if (CoC.instance.model.time.hours == 0) flags[kFLAGS.BIKINI_ARMOR_BONUS]--; //Adjust for inflation
                    if (flags[kFLAGS.BIKINI_ARMOR_BONUS] < 0) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 0; //Keep in bounds.
					if (flags[kFLAGS.BIKINI_ARMOR_BONUS] > 8) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 8;
				}
				else flags[kFLAGS.BIKINI_ARMOR_BONUS] = 0;
			}
			if (player.isRaceCached(Races.WEREWOLF) && player.hasPerk(PerkLib.LycanthropyDormant)) {
				outputText("\nAs you become wolf enough your mind recedes into increasingly animalistic urges. It will only get worse as the moon comes closer to full. <b>Gained Lycanthropy.</b>\n");
				var bonusStats:Number = 0;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats += 10;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats += 20;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats += 30;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats += 40;
				player.createPerk(PerkLib.Lycanthropy,bonusStats,0,0,0);
				player.statStore.replaceBuffObject({ 'str': bonusStats,'tou': bonusStats,'spe': bonusStats}, 'Lycanthropy', { text: 'Lycanthropy'});
				player.removePerk(PerkLib.LycanthropyDormant);
				needNext = true;
			}
			if (!player.isRaceCached(Races.WEREWOLF) && player.hasPerk(PerkLib.Lycanthropy)) {
				outputText("\nYou feel your animalistic urges go dormant within you as you no longer are the werewolf you once were. <b>Gained Dormant lycanthropy.</b>\n");
				player.createPerk(PerkLib.LycanthropyDormant,0,0,0,0);
				player.statStore.removeBuffs("Lycanthropy");
				player.removePerk(PerkLib.Lycanthropy);
				needNext = true;
			}
			if (player.isRaceCached(Races.CERBERUS) && player.hasMutation(IMutationsLib.HellHoundFireBallsIM)) {
				var pTier:Number = player.perkv1(IMutationsLib.HellHoundFireBallsIM);
				if (pTier < 4 && player.level >= 30*pTier && player.perkv2(IMutationsLib.HellHoundFireBallsIM) >= 30*2*pTier) {
					IMutationsLib.HellHoundFireBallsIM.acquireMutation(player, outputText("\nYour balls begin to suddenly feel heavier… warmer. You begin pumping your two penis absentmindedly thinking of all the bitches you recently broke on your twin shaft as the heat rushes all the way to your pair of erect members. You cum a humongous load of smoking warm cum, way to warm for normal seeds. It looks like your balls are progressively continuing their evolution to be more hellhound-like as your seed takes on burning hot property just like that of a hellhound.\n"));
					needNext = true;
				}
			}
			if (player.hasPerk(PerkLib.DominantAlpha)) player.DominantAlphaBonus();
			if (player.hasPerk(PerkLib.Immortality) && !player.isRaceCached(Races.AZAZEL)) {
				outputText("\nYou lose your sense of invulnerability as you are no longer an Azazel. <b>Perk lost: Immortality</b>\n");
				player.removePerk(PerkLib.Immortality);
				needNext = true;
			}
			if (!player.hasPerk(PerkLib.Immortality) && player.isRaceCached(Races.AZAZEL)) {
				outputText("\nYou gain a sense of invulnerability as you are now an Azazel. <b>Perk gained: Immortality</b>\n");
				player.createPerk(PerkLib.Immortality, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.WhatIsReality) && player.hasPerk(PerkLib.VorpalClaw) && !player.isRaceCached(Races.CHESHIRE)) {
				outputText("\nYou lose your sense of invulnerability as you are no longer an Cheshire. <b>Perks lost: What is Reality? && Vorpal Claw</b>");
				player.removePerk(PerkLib.WhatIsReality);
				player.removePerk(PerkLib.VorpalClaw);
				needNext = true;
			}
			if (!player.hasPerk(PerkLib.WhatIsReality) && !player.hasPerk(PerkLib.WhatIsReality) && player.isRaceCached(Races.CHESHIRE)) {
				outputText("\nYou gain a sence of invulnerability as you are now an Cheshire. <b>Perk gained: What is Reality? && Vorpal Claw</b>");
				player.createPerk(PerkLib.WhatIsReality, 0, 0, 0, 0);
				player.createPerk(PerkLib.VorpalClaw, 0, 0, 0, 0);
				needNext = true;
			}
			//No better place for these since the code for the event is part of CoC.as or one of its included files
			if (flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] > 0) flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC]--; //Vala post-rape countdown
			if (flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] > 0 && flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] < 500) flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY]++;
			if (player.statStore.hasBuff("Crossed Holy Band") && player.cor > 0) player.cor -= 1;
			if (CoC.instance.model.time.hours > 23) { //Once per day
				flags[kFLAGS.BROOKE_MET_TODAY] = 0;
                if (CoC.instance.model.time.days % 2 == 0 && flags[kFLAGS.KAIJU_BAD_END_COUNTER] > 0) {
                    flags[kFLAGS.KAIJU_BAD_END_COUNTER]--;
					if (flags[kFLAGS.KAIJU_BAD_END_COUNTER] < 0) flags[kFLAGS.KAIJU_BAD_END_COUNTER] = 0;
				}
				flags[kFLAGS.GILDED_JERKED] = 0;
				flags[kFLAGS.FED_SCYLLA_TODAY] = 0;
				flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] = 0;
				if (flags[kFLAGS.RUBI_PROSTITUTION] > 0) flags[kFLAGS.RUBI_PROFIT] += 2 + rand(4);
				flags[kFLAGS.BENOIT_TALKED_TODAY] = 0;
                SceneLib.bazaar.benoit.updateBenoitInventory();
                flags[kFLAGS.ROGAR_FUCKED_TODAY] = 0;
				if (flags[kFLAGS.LUSTSTICK_RESISTANCE] > 0) flags[kFLAGS.LUSTSTICK_RESISTANCE]--; //Reduce lust-stick resistance building
				if (flags[kFLAGS.DOMINIKA_MAGIC_COOLDOWN] > 0) { //Dominika fellatrix countdown
					flags[kFLAGS.DOMINIKA_MAGIC_COOLDOWN]--;
					if (flags[kFLAGS.DOMINIKA_MAGIC_COOLDOWN] < 0) flags[kFLAGS.DOMINIKA_MAGIC_COOLDOWN] = 0;
				}
				if (flags[kFLAGS.LOPPE_DENIAL_COUNTER] > 0) { //Loppe denial counter
					flags[kFLAGS.LOPPE_DENIAL_COUNTER]--;
					if (flags[kFLAGS.LOPPE_DENIAL_COUNTER] < 0) flags[kFLAGS.LOPPE_DENIAL_COUNTER] = 0;
				}
				if (flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN] > 0) { //Countdown to next faerie orgy
					flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN]--;
					if (flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN] < 0) flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN] = 0;
				}
                if (CoC.instance.model.time.days % 7 == 0) flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] = 0; //Clear Whitney's Weekly limit
                flags[kFLAGS.USED_MILKER_TODAY] = 0; //Clear 'has fucked milker today'
                if (SceneLib.latexGirl.latexGooFollower()) { //Latex goo follower daily updates
                    SceneLib.latexGirl.gooFluid(-2, false);
                    if (SceneLib.latexGirl.gooFluid() < 50) SceneLib.latexGirl.gooHappiness(-1, false);
                    if (SceneLib.latexGirl.gooFluid() < 25) SceneLib.latexGirl.gooHappiness(-1, false);
                    if (SceneLib.latexGirl.gooHappiness() < 75) SceneLib.latexGirl.gooObedience(-1, false);
                    if (SceneLib.latexGirl.gooHappiness() >= 90) SceneLib.latexGirl.gooObedience(1, false);
                }
                SceneLib.farm.farmCorruption.updateFarmCorruption(); //Farm Corruption updating
                if (player.hasStatusEffect(StatusEffects.Contraceptives)) { // Herbal contraceptives countdown
					if (player.statusEffectv1(StatusEffects.Contraceptives) == 1) {
						player.addStatusValue(StatusEffects.Contraceptives, 2, -1);
						if (player.statusEffectv1(StatusEffects.Contraceptives) < 0) player.removeStatusEffect(StatusEffects.Contraceptives);
					}
				}
				if (player.statusEffectv1(StatusEffects.SharkGirl) > 0) player.addStatusValue(StatusEffects.SharkGirl, 1, -1); //Lower shark girl counter
				if (flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] > 0) {
					switch (flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]) {
						case 1:
							if (!needNext) needNext = EventParser.growHair(0.2);
							else EventParser.growHair(0.2);
							break;
						case 2:
							if (!needNext) needNext = EventParser.growHair(0.5);
							else EventParser.growHair(0.5);
							break;
						case 3:
							if (!needNext) needNext = EventParser.growHair(1.1);
							else EventParser.growHair(1.1);
					}
					flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING]--;
					//reset hair growth multiplier and timer when
					//expired.
					if (flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] <= 0) {
						flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] = 0;
						flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] = 0;
						outputText("<b>\nThe tingling on your scalp slowly fades away as the hair extension serum wears off.  Maybe it's time to go back to the salon for more?</b>");
						//Restart hair growth if wuz lizard-stopped
						if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0) {
							flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
							outputText("  <b>You hair is now growing normally again.</b>");
						}
						outputText("\n");
						needNext = true;
					}
				}
				//Hair grows if not disabled by lizardness
				if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
					if (!needNext) needNext = EventParser.growHair(0.1);
					else EventParser.growHair(0.1);
					if (player.beardLength > 0 && player.beardLength < 12) EventParser.growBeard(0.02);
				}
				//Clear dragon breath cooldowns!
				if (player.hasStatusEffect(StatusEffects.DragonBreathCooldown) && !player.perkv1(IMutationsLib.DraconicLungIM) >= 3) player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && !player.perkv1(IMutationsLib.DraconicLungIM) >= 1) player.removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && !player.perkv1(IMutationsLib.DraconicLungIM) >= 1) player.removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && !player.perkv1(IMutationsLib.DraconicLungIM) >= 1) player.removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && !player.perkv1(IMutationsLib.DraconicLungIM) >= 1) player.removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonPoisonBreathCooldown) && !player.perkv1(IMutationsLib.DraconicLungIM) >= 1) player.removeStatusEffect(StatusEffects.DragonPoisonBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonWaterBreathCooldown) && !player.perkv1(IMutationsLib.DraconicLungIM) >= 1) player.removeStatusEffect(StatusEffects.DragonWaterBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonFaerieBreathCooldown) && !player.perkv1(IMutationsLib.DraconicLungIM) >= 1) player.removeStatusEffect(StatusEffects.DragonFaerieBreathCooldown);
				//Reset Mara Fruit daily counter
				flags[kFLAGS.DAILY_MARA_FRUIT_COUNTER] = 0;
				//Alraune flags
				flags[kFLAGS.ALRAUNE_DAILY_WATERING] = 0;
				if (flags[kFLAGS.ALRAUNE_GROWING] > 0 && flags[kFLAGS.ALRAUNE_GROWING] < 15) flags[kFLAGS.ALRAUNE_GROWING]++;
				//Reset SelfSustain & RepresLust daily counter
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] = 0;
				//Reset Electra Storm Jewel daily limit
				flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL] = 0;
				//Reset Etna Venom Vial daily limit
				flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] = 0;
				//Reset Ceani Training daily limit
				flags[kFLAGS.CEANI_DAILY_TRAINING] = 0;
				//Reset Kindra Training daily limit
				flags[kFLAGS.KINDRA_DAILY_TRAINING] = 0;
				//Elf training reset
				WoodElves.hasTrainedToday = false;
				if (player.isWoodElf()) if (SceneLib.woodElves.ConvertNewSisters()) needNext = true;
				//Reset Chi Chi Training daily limit
				flags[kFLAGS.CHI_CHI_DAILY_TRAINING] = 0;
				//Reset Luna Meal CD
				flags[kFLAGS.LUNA_MEAL] = 0;
				//Reset Diva Red Vial daiy limit
				DivaScene.instance.tookVialToday = false;
				//Refill Sand Witches items storage
				if (flags[kFLAGS.SAND_WITCH_LOOT_TAKEN] > 0) flags[kFLAGS.SAND_WITCH_LOOT_TAKEN]--;
				//Clear sidewinder cooldown
				if (player.hasStatusEffect(StatusEffects.CooldownSideWinder)) player.removeStatusEffect(StatusEffects.CooldownSideWinder);
				//Energy Dependent
				if (player.hasPerk(PerkLib.EnergyDependent)) {
					var intBuff:Number = player.buff("Energy Vampire").getValueOfStatBuff("int.mult");
					var speBuff:Number = player.buff("Energy Vampire").getValueOfStatBuff("spe.mult");
					if (intBuff > -0.9) {
						player.buff("Energy Vampire").addStats({ "int.mult": -0.05 }).withText("Energy Vampire");
					}
					if (speBuff > -0.9) {
						player.buff("Energy Vampire").addStats({ "spe.mult": -0.05 }).withText("Energy Vampire");
					}
				}
				//Daily Fishery production
				if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] > 0) {
					if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1) {
						flags[kFLAGS.FISHES_STORED_AT_FISHERY] += 5;
						if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 2) flags[kFLAGS.FISHES_STORED_AT_FISHERY] += 2;
					}
					if (flags[kFLAGS.CEANI_FOLLOWER] > 0) flags[kFLAGS.FISHES_STORED_AT_FISHERY] -= 5;
				}
				//Daily barrels refill
				if (player.hasStatusEffect(StatusEffects.MitziDaughtersBarrels)) {
					if (rand(3) == 0) player.addStatusValue(StatusEffects.MitziDaughtersBarrels, 1, 5);
					else {
						if (rand(2) == 0) player.addStatusValue(StatusEffects.MitziDaughtersBarrels, 2, 5);
						else player.addStatusValue(StatusEffects.MitziDaughtersBarrels, 3, 5);
					}
				}
				//Daily regeneration of soulforce for non soul cultivators && Metamorph bonus SF gain till cap
				if (!player.hasPerk(PerkLib.JobSoulCultivator) && (player.soulforce < player.maxOverSoulforce())) {
					player.soulforce += 50;
					if (player.soulforce > player.maxOverSoulforce()) player.soulforce = player.maxOverSoulforce();
				}
				if (player.hasPerk(PerkLib.Metamorph) && player.perkv1(PerkLib.Metamorph) < 18) player.addPerkValue(PerkLib.Metamorph, 1, 1);
				if (player.hasPerk(PerkLib.MetamorphEx) && player.perkv1(PerkLib.MetamorphEx) < 10) player.addPerkValue(PerkLib.MetamorphEx, 1, 1);
				//if (player.hasPerk(PerkLib.MetamorphMastery) && player.perkv1(PerkLib.MetamorphMastery) < 5) player.addPerkValue(PerkLib.MetamorphMastery, 1, 1);
				//Daily regeneration of mana for non mages
				if (!player.hasPerk(PerkLib.JobSorcerer) && !player.hasPerk(PerkLib.JobHealer) && !player.hasPerk(PerkLib.JobElementalConjurer) && !player.hasPerk(PerkLib.JobGolemancer)) {
					EngineCore.ManaChange(150);
				}
				//Chi Chi healing progress
				if (flags[kFLAGS.CHI_CHI_LVL_UP] < 5 && flags[kFLAGS.CHI_CHI_DAILY_TRAINING] < 1) {
					if (flags[kFLAGS.CHI_CHI_LVL_UP] < 2) flags[kFLAGS.CHI_CHI_LVL_UP] = 2;
					else flags[kFLAGS.CHI_CHI_LVL_UP]++;
				}
				//Belisa Confession event
				if (TyrantiaFollower.isLover() && BelisaFollower.BelisaFollowerStage > 2 && BelisaFollower.BelisaFollowerStage < 6) {
					BelisaFollower.BelisaFollowerStage += 1;
				}
				//DriderTown Construction
				if (BelisaFollower.BelisaInCamp && LilyFollower.LilyFollowerState && TyrantiaFollower.isLover()) {
					DriderTown.DriderTownComplete = true;
				}
				//Excellia fixing counter
				if (flags[kFLAGS.EXCELLIA_RECRUITED] > 2 && flags[kFLAGS.EXCELLIA_RECRUITED] < 30) flags[kFLAGS.EXCELLIA_RECRUITED]++;
				//Alvina timer
				if (SceneLib.dungeons.checkFactoryClear() && flags[kFLAGS.ALVINA_FOLLOWER] < 8) flags[kFLAGS.ALVINA_FOLLOWER]++;
				//Siegweird
				if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 1 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 10) flags[kFLAGS.SIEGWEIRD_FOLLOWER]++;
				if (player.statusEffectv1(StatusEffects.SiegweirdSoup) == 1) player.addStatusValue(StatusEffects.SiegweirdSoup, 1, -1);
				//Dominant Alpha buff
				if (player.statusEffectv1(StatusEffects.DominantAlpha) >= 1) {
					player.addStatusValue(StatusEffects.DominantAlpha, 1, -1);
					if (player.statusEffectv1(StatusEffects.DominantAlpha) == 0) {
						player.removeStatusEffect(StatusEffects.DominantAlpha);
						player.buff("Dominant Alpha").removeFromStat("str");
					}
				}
				//Mishaps reset
				if (player.hasStatusEffect(StatusEffects.CampLunaMishaps1)) player.removeStatusEffect(StatusEffects.CampLunaMishaps1);
				if (player.hasStatusEffect(StatusEffects.CampLunaMishaps2)) player.removeStatusEffect(StatusEffects.CampLunaMishaps2);
				if (player.hasStatusEffect(StatusEffects.CampLunaMishaps3)) player.removeStatusEffect(StatusEffects.CampLunaMishaps3);
				//Full moon
				flags[kFLAGS.LUNA_MOON_CYCLE]++;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] > 8) flags[kFLAGS.LUNA_MOON_CYCLE] = 1;
				if (player.hasPerk(PerkLib.Lycanthropy)) {
					var ngMult:Number = (player.newGamePlusMod() + 1);
					var changeV:Number = 0;
					switch (flags[kFLAGS.LUNA_MOON_CYCLE]) {
						case 1:
							changeV = 30;
							outputText("<b>\nThe moon is waning, you are feeling less powerful.</b>\n");
							break;
						case 2:
							changeV = 20;
							outputText("<b>\nThe moon is waning, you are feeling less powerful.</b>\n");
							break;
						case 3:
							changeV = 10;
							outputText("<b>\nThe moon is waning, you are feeling less powerful.</b>\n");
							break;
						case 4:
							changeV = 0;
							outputText("<b>\nIt's a new moon tonight, you feel somewhat weak.</b>\n");
							break;
						case 5:
							changeV = 10;
							outputText("<b>\nYou can’t help but notice the waxing moon as it rises up.  It seems transfixing like it is calling to you.");
							outputText("\n\nYou feel your might increasing as the moon draws closer to fullness.</b>\n");
							break;
						case 6:
							changeV = 20;
							outputText("<b>\nWhen the half-moon appears it causes your heart to race with excitement.  You hearing seems better than ever.  Every breath brings a rush of smells through your nose that seem much more pronounced than they should.");
							outputText("\n\nYou feel your might increasing as the moon draws closer to fullness.</b>\n");
							break;
						case 7:
							changeV = 30;
							outputText("<b>\nYou gaze at the moon and it seems to gaze back into you.   Something is coming and it won’t be long now.   You feel like your skin is crawling.  It feels like tear out of your body and be born anew.");
							outputText("\n\nYou feel your might increasing as the moon draws closer to fullness. It's almost time.</b>\n");
							break;
						case 8:
							changeV = 40;
							outputText("<b>\nYou are at the peak of your strength, it's a full moon tonight and you feel yourself burning with maddening desire as you go into " + player.mf("rut your cock hardening and dripping precum at the prospect of impregnating a bitch womb full of your lupine seeds", "heat your womb aching for the fresh semen of a virile male.") + "</b>\n.");
							if (player.hasCock() || (player.gender == 3 && rand(2) == 0)) player.goIntoRut(false);
							else if (player.hasVagina()) player.goIntoHeat(false);
							break;
					}
					player.statStore.replaceBuffObject({ 'str': changeV*ngMult,'tou': changeV*ngMult,'spe': changeV*ngMult}, 'Lycanthropy', { text: 'Lycanthropy'});
					player.setPerkValue(PerkLib.Lycanthropy,1,changeV);
					needNext = true;
				}
				if (player.hasStatusEffect(StatusEffects.MitziIzmaDaughters)) player.removeStatusEffect(StatusEffects.MitziIzmaDaughters);
				if (flags[kFLAGS.SAMIRAH_HYPNOSIS] == 4 || flags[kFLAGS.SAMIRAH_HYPNOSIS] == 2) flags[kFLAGS.SAMIRAH_HYPNOSIS]++;
				//Soul Arena Gaunlet reset
				if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlets1)) {
					if (player.statusEffectv1(StatusEffects.SoulArenaGaunlets1) > 1) player.addStatusValue(StatusEffects.SoulArenaGaunlets1, 1, -1);
					if (player.statusEffectv2(StatusEffects.SoulArenaGaunlets1) > 1) player.addStatusValue(StatusEffects.SoulArenaGaunlets1, 2, -1);
				}
				//Adventure Quild daily quests reset
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) {
					if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) > 6) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, -3);
					if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) > 6) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, -3);
					if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) > 6) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, -3);
				}
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests2)) {
					if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) > 6) player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, -3);
					if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) > 6) player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, -3);
				}
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests3)) {
					if (player.statusEffectv1(StatusEffects.AdventureGuildQuests3) > 6) player.addStatusValue(StatusEffects.AdventureGuildQuests3, 1, -3);
					if (player.statusEffectv2(StatusEffects.AdventureGuildQuests3) > 6) player.addStatusValue(StatusEffects.AdventureGuildQuests3, 2, -3);
				}
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests4)) {
					if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) > 4) player.addStatusValue(StatusEffects.AdventureGuildQuests4, 1, -3);
					if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) > 4) player.addStatusValue(StatusEffects.AdventureGuildQuests4, 2, -3);
				}
				if (flags[kFLAGS.AURORA_LVL] > 0.3 && flags[kFLAGS.AURORA_LVL] < 0.7) flags[kFLAGS.AURORA_LVL] += 0.05;
				//Zenji training conuters
				if (player.hasStatusEffect(StatusEffects.ZenjiTrainingsCounters1)) {
					if (player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters1) > 0) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters1, 1, -player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters1));
					if (player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters1) > 0) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters1, 2, -player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters1));
					if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters1) > 0) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters1, 3, -player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters1));
				}
				if (player.hasStatusEffect(StatusEffects.ZenjiTrainingsCounters2)) {
					if (player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters2) > 0) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters2, 1, -player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters2));
					if (player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters2) > 0) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters2, 2, -player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters2));
				}
				if (ZenjiScenes.isLover()) {
					if (player.statusEffectv2(StatusEffects.ZenjiPreparationsList) < 20) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 2, 1);
					if (player.statusEffectv1(StatusEffects.ZenjiModificationsList) > 0) player.addStatusValue(StatusEffects.ZenjiModificationsList, 1, -1);
					if (player.statusEffectv3(StatusEffects.ZenjiZList) > 0) {
						var deduce:Number = player.statusEffectv3(StatusEffects.ZenjiZList);
						player.addStatusValue(StatusEffects.ZenjiZList, 3, -deduce);
					}
					ZenjiScenes.ZenjiFood = false;
				}
				//Neisa counter to payment
				if (flags[kFLAGS.NEISA_FOLLOWER] >= 7 && flags[kFLAGS.NEISA_FOLLOWER] < 17) flags[kFLAGS.NEISA_FOLLOWER]++;
				//Kaiba daily buy limit refresh
				if (player.hasStatusEffect(StatusEffects.KaibaDailyLimit)) player.removeStatusEffect(StatusEffects.KaibaDailyLimit);
				//Daily reset on finding blessed ittem(s) at the lake
				if (player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake)) player.removeStatusEffect(StatusEffects.BlessedItemAtTheLake);
				//Player overheat is intensifying
				if (player.statusEffectv1(StatusEffects.Overheat) == 1) {
					var intensified:Boolean
					if (player.isMale() || (player.gender == 3 && rand(2) == 0)){
						intensified = player.inRut;
						if (player.goIntoRut(false)) {
							if (intensified) {
								outputText("\nYour cock aches for a wet snatch to cool itself in. It would seem your burning body has gone into rut.\n");
								player.statStore.addBuffObject({sens:2}, "Overheat",{text:"Overheat"});
							} else {
								outputText("\nYour cock aches for a wet snatch to cool itself in. <b>It seems you have went into rut!</b>\n");
								player.statStore.addBuffObject({sens:2}, "Overheat",{text:"Overheat"});
							}
						}
					} else if (player.hasVagina()){
						intensified = player.inHeat;
						if (player.goIntoHeat(false)) {
							if (intensified) {
								outputText("\nThe hot throbbing in you intensify as your burning body aches for sex. It's difficult NOT to think about a cock slipping inside your moist fuck-tunnel as you realy could use some form of cooling for your furnace.\n");
								player.statStore.addBuffObject({sens:2}, "Overheat",{text:"Overheat"});
							} else {
								outputText("\nThe hot throbbing in you intensify as your burning body aches for sex. <b>It seems you have went into heat!</b>\n");
								player.statStore.addBuffObject({sens:2}, "Overheat",{text:"Overheat"});
							}
						}
					}
					needNext = true;
				}
				//Player overheat is progressing toward active
				if (player.statusEffectv1(StatusEffects.Overheat) == 0 && player.statusEffectv2(StatusEffects.Overheat) > 0) {
					player.addStatusValue(StatusEffects.Overheat, 2, -1);
					if(player.statusEffectv2(StatusEffects.Overheat) == 0){
						player.addStatusValue(StatusEffects.Overheat, 1, 1);
						outputText("\nYour body start overheating again, you really could use sex right now.\n");
						if (player.hasCock() || (player.gender == 3 && rand(2) == 0)) player.goIntoRut(false);
						else if (player.hasVagina()) player.goIntoHeat(false);
						needNext = true;
					}
				}
				//Easter bunny egg balls
				if (player.hasPerk(PerkLib.EasterBunnyBalls) && player.balls >=2) {
					outputText("\n<b>Your balls grow as your eggs increase in size.</b>\n");
					player.ballSize++;
					if (player.perkv1(IMutationsLib.EasterBunnyEggBagIM) >= 2) {
						var changeLib:Number = (player.ballSize*5/100)+1; //Exemple (1*5/100)+1= 1.05 wich is the modifier to libido
						if (player.perkv1(IMutationsLib.EasterBunnyEggBagIM) >= 3){
							changeLib = (player.ballSize*10/100)+1;
							player.ballSize++;
						}
						player.buff("EasterBunnyBalls").setStat("lib.mult",changeLib).withText("Easter Bunny Balls");
					}
					if (player.ballSize > 3 && player.ballSize < 4) {
						outputText("\n\nYou begin penting in wanton lust, thought of filling some welcoming wet holes flooding your head. Your balls have increased enough that you are ready to lay your eggs.\n");
					}
					if (player.ballSize > 4) {
						outputText("\n\nYou begin penting in wanton lust, thought of filling some welcoming wet holes flooding your head, as the size of your increasingly growing balls remind you that you need to expel those eggs one way or another before they become too big.\n");
					}
				}
				//Armor daily event
				//Scandalous succubus armor and other corruption updates
				if ((player.armor == armors.SCANSC || player.countMiscJewelry(miscjewelries.DMAGETO) > 0) && player.cor < 100) {
					outputText("\nCorruption seethes from your defiled equipment into you.\n");
					player.cor += 5;
				}
				//Reset clone creation tracker
				if (player.hasStatusEffect(StatusEffects.PCClone) && player.statusEffectv3(StatusEffects.PCClone) == 0 && player.statusEffectv4(StatusEffects.PCClone) == 0) player.removeStatusEffect(StatusEffects.PCClone);
			}
			//Easter bunny egg balls Loosing
			if (!player.isRaceCached(Races.EASTERBUNNY) && player.hasPerk(PerkLib.EasterBunnyBalls) && !player.perkv1(IMutationsLib.EasterBunnyEggBagIM) >= 1) {
				outputText("\nSomething changes in your balls you can feel them as if they stopped growing. Guess you're no longer enough of a easter bunny to produce eggs.\n\n");
				player.removePerk(PerkLib.EasterBunnyBalls)
			}
			//Easter bunny egg balls Cumming the eggs out
			if (player.hasStatusEffect(StatusEffects.EasterBunnyCame)) { //Easter bunny cumming its eggs out
				if (player.balls == 2)outputText("\nYou sigh in relief as your balls now empty of their eggs dangle under your cock two new way smaller eggs sliding " +
						"inside to fill the void in them. Of course you also collected those that you shot out, never know when these can come in handy.\n");
				if (player.balls == 4)outputText("\nYou sigh in relief as your balls now empty of their eggs dangle under your cock four new way smaller eggs sliding " +
						"inside to fill the void in them. Of course you also collected those that you shot out, never know when these can come in handy.\n");
				player.ballSize = 1;
				var changeLib1:Number = (player.ballSize*5/100)+1; //Exemple (1*5/100)+1= 1.05 wich is the modifier to libido
				player.buff("EasterBunnyBalls").setStat("lib.mult",changeLib1).withText("Easter Bunny Balls");
				player.removeStatusEffect(StatusEffects.EasterBunnyCame); //Remove cumming status
				flags[kFLAGS.EASTER_BUNNY_EGGS_STORED]+=2;
				if (player.balls == 4)flags[kFLAGS.EASTER_BUNNY_EGGS_STORED]+=2;
				outputText("\n\n<b>You currently have "+flags[kFLAGS.EASTER_BUNNY_EGGS_STORED]+" eggs stored</b>\n");
				needNext = true;
			}
			if (CoC.instance.model.time.hours == 6) {
				var vthirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
				if (vthirst != null) {
					if (vthirst.value2 > 0) vthirst.value2--;
					if (vthirst.value2 <= 0) {
						if (player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 4) vthirst.value2 = 3;
						else if (player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 2) vthirst.value2 = 2;
						else vthirst.value2 = 1;
						vthirst.modSatiety(-1);
					}
				}
				//Getting chrismas tree
				if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 2) {
					outputText("Around the edge of your camp, you spot some plant-life beginning to sprout.  The barren, wasteland crust is fractured and broken, giving up a leafy green shoot.  It only reaches up to your knee, but the plant looks healthy and young.  Perhaps it will grow larger?  There is a central stem that supports most of the weight, but a dozen branches fork off, supporting a bevy of shiny green leaves. Looks like the seed was able to take root in the barren land after all.\n");
					flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] = 0;
					flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 3;
					needNext = true;
				}
				if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 9 && !player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
					campScenes.PCGoblinDaughtersBuilingWorkshop();
					needNext = true;
				}
				if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 9 && player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
					var protection:Number = 0;
					if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] <= 25) protection = 25;
					else if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] <= 50) protection = 50;
					else if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] <= 75) protection = 75;
					else protection += flags[kFLAGS.PC_GOBLIN_DAUGHTERS];
					var nails:Number = 0;
					if (protection > rand(100)) nails += 5 + rand(11);
					if (protection > rand(100)) nails += 5 + rand(11);
					if (protection > rand(100)) nails += 5 + rand(11);
					if (protection > rand(100)) nails += 5 + rand(11);
					if (protection > rand(100)) nails += 5 + rand(11);
					if (protection > rand(100)) nails += 5 + rand(11);
					var metalpieces:Number = 0;
					if (protection > rand(100)) metalpieces += 1;
					if (protection > rand(100)) metalpieces += 1;
					if (protection > rand(100)) metalpieces += 1;
					if (protection > rand(100)) metalpieces += 1;
					if (protection > rand(100)) metalpieces += 1;
					var mechanism:Number = 0;
					if (protection > rand(100)) mechanism += 1;
					var energycore:Number = 0;
					if (protection > rand(100)) energycore += 1;
					if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshopSpareParts)) {
						if (nails > 0) {
							if (player.statusEffectv1(StatusEffects.PCDaughtersWorkshopSpareParts) + nails > 300) nails = 300 - player.statusEffectv1(StatusEffects.PCDaughtersWorkshopSpareParts);
							player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 1, nails);
						}
						if (metalpieces > 0) {
							if (player.statusEffectv2(StatusEffects.PCDaughtersWorkshopSpareParts) + metalpieces > 15) metalpieces = 15 - player.statusEffectv2(StatusEffects.PCDaughtersWorkshopSpareParts);
							player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 2, metalpieces);
						}
						if (mechanism > 0 && player.statusEffectv3(StatusEffects.PCDaughtersWorkshopSpareParts) + mechanism < 4) player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 3, mechanism);
						if (energycore > 0 && player.statusEffectv4(StatusEffects.PCDaughtersWorkshopSpareParts) + energycore < 4) player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 4, energycore);
					}
					else {
						nails += 1;
						player.createStatusEffect(StatusEffects.PCDaughtersWorkshopSpareParts,nails,metalpieces,mechanism,energycore);
					}
				}
				if (flags[kFLAGS.SLEEP_WITH] == "Zenji") {
					if (player.statusEffectv2(StatusEffects.ZenjiZList) == 0) SceneLib.zenjiScene.loverZenjiSleepWithMorning();
					if (player.statusEffectv2(StatusEffects.ZenjiZList) == 1) SceneLib.zenjiScene.loverZenjiSleepWithGetPenetratedMorning();
					if (player.statusEffectv2(StatusEffects.ZenjiZList) == 2) SceneLib.zenjiScene.loverZenjiSleepWithCatchAnalMorning();
					if (player.statusEffectv2(StatusEffects.ZenjiZList) == 3) SceneLib.zenjiScene.loverZenjiSleepWithNoSexMorning();
					needNext = true;
				}
			}
			//Heaven Tribulations
			if (player.hasStatusEffect(StatusEffects.TribulationCountdown)) {
				if (player.statusEffectv1(StatusEffects.TribulationCountdown) <= 1 && !player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) {
					player.removeStatusEffect(StatusEffects.TribulationCountdown);
					campScenes.HclassHTintro();
					needNext = true;
				}
				else if (player.statusEffectv1(StatusEffects.TribulationCountdown) <= 1 && !player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) {
					player.removeStatusEffect(StatusEffects.TribulationCountdown);
					campScenes.GclassHTintro();
					needNext = true;
				}
				else if (player.statusEffectv1(StatusEffects.TribulationCountdown) <= 1 && !player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) {
					player.removeStatusEffect(StatusEffects.TribulationCountdown);
					campScenes.FclassHTintro();
					needNext = true;
				}
				else if (player.statusEffectv1(StatusEffects.TribulationCountdown) <= 1 && !player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) {
					player.removeStatusEffect(StatusEffects.TribulationCountdown);
					campScenes.FFclassHTintro();
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.TribulationCountdown, 1, -1);
			}
			if (needNext) mainViewManager.updateCharviewIfNeeded();
			return needNext;
		}

		private function hourlyHunger():Boolean {
			var needNext:Boolean = false;
			var hungerActive:Boolean = false;
			if (flags[kFLAGS.HUNGER_ENABLED] > 0 || player.hasPerk(PerkLib.EndlessHunger)) hungerActive = true;
			if (hungerActive) {
				if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 2 || flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) hungerActive = false;
				else if (player.hasPerk(PerkLib.DeadMetabolism)) hungerActive = false;
			}
			if (hungerActive) {
				var multiplier:Number = 1.0;
				if (player.hasPerk(PerkLib.Survivalist)) multiplier -= 0.2;
				if (player.hasPerk(PerkLib.Survivalist2)) multiplier -= 0.2;
				if (player.hasPerk(PerkLib.Survivalist3)) multiplier -= 0.2;
				if (player.hasPerk(PerkLib.HighlyVenomousDiet) && player.tailVenom < player.maxVenom()) {
					if (player.maxHunger() > 1600) multiplier += 0.25;
					else if (player.maxHunger() > 800) multiplier += 0.25;
					else if (player.maxHunger() > 400) multiplier += 0.25;
					else if (player.maxHunger() > 200) multiplier += 0.25;
					else if (player.maxHunger() > 100) multiplier += 0.25;
					else multiplier += 0.25;
				}
				if (player.hasPerk(PerkLib.ManticoreCumAddict)) multiplier *= 2;
				if (player.hasPerk(PerkLib.HydraRegeneration)) multiplier *= 2;
				if (player.hasPerk(PerkLib.AxillaryVenomGlands) && player.tailVenom < player.maxVenom()) multiplier *= 2;
				//Hunger drain rate. If above 50, 1.5 per hour. Between 25 and 50, 1 per hour. Below 25, 0.5 per hour.
				//So it takes 100 hours to fully starve from 100/100 to 0/100 hunger. Can be increased to 125 then 166 and 250 hours with Survivalist perks.
				if (player.hasStatusEffect(StatusEffects.FastingPill)) player.hunger += 1;
				if (player.internalChimeraRating() >= 1) player.hunger -= (0.5 * player.internalChimeraRating());
				if (player.hunger > 80) player.hunger -= (0.5 * multiplier); //If satiated, depletes at 2 points per hour.
				if (player.hunger > 50) player.hunger -= (0.5 * multiplier);
				if (player.hunger > 25) player.hunger -= (0.5 * multiplier);
				if (player.hunger > 0) player.hunger -= (0.5 * multiplier);
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_GOO_STUFFED) player.hunger = player.maxHunger(); //After Valeria x Goo Girl, you'll never get hungry until you "birth" the goo-girl.
				if (player.hunger < 50 && player.hasPerk(PerkLib.MagicMetabolism)) {
					var manaDrain:Number = 0;
					manaDrain += 50 - player.hunger;
					if (player.mana >= (manaDrain * 5)) {
						player.mana -= (manaDrain * 5);
						player.hunger = 50;
					}
				}
				if (player.hunger <= 0) {
					if (player.isGargoyle()) campUniqueScene.droppingToZeroSatietyAsGargoyle();
					else {
						//Lose HP and makes fatigue go up. Lose body weight and muscles.
						if (player.thickness < 25) {
							player.takePhysDamage(player.maxHP() / 25);
							fatigue(2);
							dynStats("tou", -0.5);
							dynStats("str", -0.5);
						}
						else if ((model.time.hours + 2) % 4 == 0) { //Lose thickness 2x as fast.
							player.modThickness(1, 1);
							player.modTone(1, 1);
						}
					}
					player.hunger = 0; //Prevents negative
				}
				if (player.hunger < 10 && model.time.hours % 4 == 0) {
					player.modThickness(1, 1);
					player.modTone(1, 1);
				}
				if (player.hunger < 25) {
					if (player.hunger > 0) flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING]++;
					else flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] = 0;
				}
				else flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] = 0;
				//Goo armor prevents starvation completely!
				if (player.armor == armors.GOOARMR)
				{
					if (player.hunger < 15)
					{
						outputText("Sensing that you're hungry as indicated by your growling stomach, the armor-goo stuffs some blue goo into your mouth. You swallow the goo and it makes its way into your stomach. You also can feel some goo being absorbed into your " + player.skinFurScales() + ".");
						player.hunger = 20;
					}
					if (player.hunger < 20) player.hunger = 20;
				}
				if (player.hunger > player.maxHunger()) player.hunger = player.maxHunger();
			}
			return needNext;
		}

		private function hourlyCheckRacialPerks():Boolean {
			var needNext:Boolean = false;
			// RaceTf itemeffect
			var eff:StatusEffectClass = player.statusEffectByType(StatusEffects.ItemEffectRaceTf);
			if (eff) {
				if (RaceTfEnchantmentType.advance(eff)) {
					needNext = true;
				}
			}
			//Armor unequip zone
			if (player.armor == armors.CTPALAD && !player.isTaur())
			{
				outputText("Due to your current body shape you are no longer able to wear the centaur armor and thus you drop the over encumbering equipment back into your inventory");
				SceneLib.inventory.takeItem(player.unequipArmor(false, true), playerMenu);
				needNext = true;
			}
			if (player.armor == armors.KBDRESS && !player.isScylla())
			{
				outputText("Due to your current body shape you are no longer able to wear the Kraken black dress and thus you put the over item back into your inventory");
				SceneLib.inventory.takeItem(player.unequipArmor(false, true), playerMenu);
				needNext = true;
			}

			player.updateRacialCache();
			//Demonic hunger perk
			if (player.isRaceCached(Races.DEMON) || player.hasPerk(PerkLib.Phylactery)) { //Check for being a demon enough
				if (!player.hasPerk(PerkLib.DemonEnergyThirst)) {
					outputText("\nYou begin fantasising about pussies and cocks foaming at the idea of fucking or getting fucked. It would look like you aquired the demons hunger for sex and can now feed from the orgasms of your partners. \n\n(<b>Gained Perk: Demonic Hunger</b>)\n");
					player.createPerk(PerkLib.DemonEnergyThirst, 0, 0, 0, 0);
					needNext = true;
				}
			} else { //Check for being a demon enough
				if (player.hasPerk(PerkLib.DemonEnergyThirst)) {
					outputText("\nYour mind clears up as becoming less of a demon you also lost the demonic hunger only sex could sate. \n\n(<b>Lost Perk: Demonic Hunger</b>)\n");
					player.removePerk(PerkLib.DemonEnergyThirst);
					needNext = true;
				}
			}
			//Demonic energy thirst
			if (player.hasStatusEffect(StatusEffects.DemonEnergyThirstFeed)) {
				if (player.hunger < player.maxHunger()) player.refillHunger(10, false);
				EngineCore.HPChange(100 + (player.tou*2), true);
				EngineCore.ManaChange(100 + (player.inte*2));
				EngineCore.changeFatigue(-(100 + (player.spe*2)));
				outputText("You feel energised and empowered by the energy drained out of the cum of your recent fuck. What a meal!");
				player.removeStatusEffect(StatusEffects.DemonEnergyThirstFeed)
			}
			//Flexibility perk
			if ((Tail.hasFelineTail(player)) && (LowerBody.hasFelineLegs(player)) && (Arms.hasFelineArms(player))) { //Check for gain of cat agility - requires legs, tail, and arms
				if (!player.hasPerk(PerkLib.Flexibility)) {
					outputText("\nWhile stretching, you notice that you're much more flexible than you were before.  Perhaps this will make it a bit easier to dodge attacks in battle?\n\n(<b>Gained Perk: Flexibility</b>)\n");
					player.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.Flexibility) && player.perkv4(PerkLib.Flexibility) == 0 && !player.perkv1(IMutationsLib.CatLikeNimblenessIM) >= 1) { //Remove flexibility perk if not meeting requirements
				outputText("\nYou notice that you aren't as flexible as you were when you had a more feline body.  It'll probably be harder to avoid your enemies' attacks now.\n\n(<b>Lost Perk: Flexibility</b>)\n");
				player.removePerk(PerkLib.Flexibility);
				needNext = true;
			}
			//Ghost-slinger perk
			if (player.isRaceCached(Races.POLTERGEIST, 2) && !player.hasPerk(PerkLib.Ghostslinger)) {
				outputText("\nYour head is suddenly filled with strange otherworldly knowledge. Things you didn't think possible before could become a reality now thanks to your supernatural intellect and abilities. You could even apply these newfound abilities to your equipment.\n\n(<b>Gained Perk: Ghost-slinger</b>)\n\n(<b>Gained Perk: Telekinesis</b>)");
				player.createPerk(PerkLib.Ghostslinger, 0, 0, 0, 0);
				player.createPerk(PerkLib.Telekinesis, 0, 0, 0, 0);
				needNext = true;
			}
			else if (!player.isRaceCached(Races.POLTERGEIST, 2) && player.hasPerk(PerkLib.Ghostslinger)) {// && !player.perkv1(IMutationsLib.LizanMarrowIM) >= 1
				outputText("\nYour supernatural knowledge fades along with the abilities that came with it as you become more corporeal.\n\n(<b>Lost Perk: Ghost-slinger</b>)\n\n(<b>Lost Perk: Telekinesis</b>)");
				player.removePerk(PerkLib.Ghostslinger);
				player.removePerk(PerkLib.Telekinesis);
				needNext = true;
			}
			//Hydra Regeneration and Hydra acid breath perk
			if (player.hasPerk(PerkLib.HydraRegeneration) && player.lowerBody != LowerBody.HYDRA) { //Remove hydra regeneration perk if not meeting requirements
				outputText("\nYou accidentally cut yourself but to your stupor the wound does not close as fast as it should. Guess you are no longer a hydra enough to benefit from superior regeneration.\n\n(<b>Lost Perk: Hydra Regeneration</b>)");
				player.removePerk(PerkLib.HydraRegeneration);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.HydraAcidBreath) && player.lowerBody != LowerBody.HYDRA) { //Remove hydra acid breath perk if not meeting requirements
				outputText("\nAs your lead hydra head vanishes so do your ability to belch acid.\n\n(<b>Lost Perk: Hydra Acid Breath</b>)");
				player.removePerk(PerkLib.HydraAcidBreath);
				needNext = true;
			}
			//Knowledge is power
			if (player.isRaceCached(Races.RATATOSKR) && !player.hasPerk(PerkLib.KnowledgeIsPower)) {
				outputText("\nBecoming more of a Ratatoskr your memory seems to have grown and as such the ability the analyze and properly catalogue your opponents many weaknesses as well as new fighting skills you gained the Knowledge is Power perk!\n\n(<b>Gained Perk: Knowledge is power</b>)");
				player.createPerk(PerkLib.KnowledgeIsPower, 0, 0, 0, 0);
				needNext = true;
			}
			else if (!player.isRaceCached(Races.RATATOSKR) && player.hasPerk(PerkLib.KnowledgeIsPower)) {// && !player.perkv1(IMutationsLib.LizanMarrowIM) >= 1
				outputText("\nBecoming less of a Ratatoskr your memory has become hazy, your wits slowing down to that of a standard human.\n\n(<b>Lost Perk: Knowledge is power</b>)");
				player.removePerk(PerkLib.KnowledgeIsPower);
				needNext = true;
			}
			//Improved venom gland
			if (flags[kFLAGS.VENOM_TIMES_USED] >= 50 && !player.hasPerk(PerkLib.ImprovedVenomGland)) {
				outputText("\nYou feel wonderfully healthy. After using your venom so many times your body finally got acclimated to the presence of your venom gland allowing for increased capacity and production. \n\n(<b>Gained Perk: Improved venom gland</b>)\n");
				player.createPerk(PerkLib.ImprovedVenomGland, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.VENOM_TIMES_USED] >= 125 && !player.hasPerk(PerkLib.ImprovedVenomGlandEx)) {
				outputText("\nYou feel wonderfully healthy. After using your venom so many times your venom gland development reached it next stage. Allowing for increased capacity, production and lowering usage of venom. \n\n(<b>Gained Perk: Improved venom gland (Ex)</b>)\n");
				player.createPerk(PerkLib.ImprovedVenomGlandEx, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.VENOM_TIMES_USED] >= 375 && !player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
				outputText("\nYou feel wonderfully healthy. After using your venom so many times your venom gland started to produce more potent venom. Allowing for increased capacity, production and increased effects of venom. \n\n(<b>Gained Perk: Improved venom gland (Su)</b>)\n");
				player.createPerk(PerkLib.ImprovedVenomGlandSu, 0, 0, 0, 0);
			}
			//Kitsune hunger perk
			if (player.isRaceCached(Races.KITSUNE) || player.isRaceCached(Races.KITSHOO)) { //Check for being a kitsune enough
				if (!player.hasPerk(PerkLib.KitsuneEnergyThirst)) {
					outputText("\nYou begin fantasizing about pussies and cocks, foaming at the idea of fucking or getting fucked. It looks like you acquired the kitsune's hunger for sex and can now feed off the life force extracted from the orgasms of your partners. \n\n(<b>Gained Perk: Kitsune Hunger</b>)\n");
					player.createPerk(PerkLib.KitsuneEnergyThirst, 0, 0, 0, 0);
					needNext = true;
				}
			}
			if (!player.isRaceCached(Races.KITSUNE) && !player.isRaceCached(Races.KITSHOO)) { //Check for being a kitsune enough
				if (player.hasPerk(PerkLib.KitsuneEnergyThirst)) {
					outputText("\nYour mind clears up as you become less of a kitsune. You also lost the hunger for life force only sex could provide you. \n\n(<b>Lost Perk: Kitsune Hunger</b>)\n");
					player.removePerk(PerkLib.KitsuneEnergyThirst);
					needNext = true;
				}
			}
			//Kitsune energy thirst
			if (player.hasStatusEffect(StatusEffects.KitsuneEnergyThirstFeed)) {
				if (player.hunger < player.maxHunger()) {
					player.refillHunger(10, false);
				}
				EngineCore.HPChange(100 + (player.tou*2), true);
				EngineCore.ManaChange(100 + (player.inte*2));
				EngineCore.changeFatigue(-(100 + (player.spe*2)));
				EngineCore.SoulforceChange(500 + (player.wis*2));
				outputText("You feel energised and empowered by the life force drained out of the fluids of your recent blind date. What a meal!");
				player.removeStatusEffect(StatusEffects.KitsuneEnergyThirstFeed);
			}
			//Hydra heads
			if (player.lowerBody != LowerBody.HYDRA && player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
			//Greed Perk
			if (player.isRaceCached(Races.RACCOON, 2) && !player.hasPerk(PerkLib.Greedy)) {
				outputText("\nYou are feeling absurdly lucky today, so lucky that there's no way fortune could turn against you! Your nature as a tanuki has improved your ability to generate wealth, wherever there are more gems to be made, there you will be. [pg](Gained Perk: Greedy)");
				player.createPerk(PerkLib.Greedy, 0, 0, 0, 0);
				needNext = true;
			}
			//Lizan Regeneration perk
			if ((!player.hasPerk(PerkLib.LizanRegeneration) && player.perkv1(IMutationsLib.LizanMarrowIM) >= 1) || (player.tailType == Tail.LIZARD && player.lowerBody == LowerBody.LIZARD && player.arms.type == Arms.LIZARD)) { //Check for gain of lizan regeneration - requires legs, arms and tail
				if (!player.hasPerk(PerkLib.LizanRegeneration)) {
					outputText("\nYou start to feel an unusual feeling somewhere within your body. Like tiny ripples moving inside your veins, making you feel so much more refreshed than a moment ago. Considering the fact that lizans are so much like lizards and that they usually possess a natural talent to regenerate from even severe injuries, you wonder if it could be that. [pg](Gained Perk: Lizan Regeneration)");
					player.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.LizanRegeneration) && player.tailType != Tail.LIZARD && player.lowerBody != LowerBody.LIZARD && player.arms.type != Arms.LIZARD && player.perkv4(PerkLib.LizanRegeneration) == 0 && !player.perkv1(IMutationsLib.LizanMarrowIM) >= 1) { //Remove lizan regeneration perk if not meeting requirements && !player.hasPerk(PerkLib.HydraRegeneration)
				outputText("\nAll of a sudden, something changes inside your body. You think about it for a long time until it dawns on you. You can't feel that refreshing feeling inside your body anymore, meaning your recovery rate has reverted back to normal. [pg](Lost Perk: Lizan Regeneration)");
				player.removePerk(PerkLib.LizanRegeneration);
				needNext = true;
			}
			//Lustzerker perk
			if (!player.hasPerk(PerkLib.Lustzerker) && (player.isRaceCached(Races.SALAMANDER) || player.isRaceCached(Races.PHOENIX) || player.isRaceCached(Races.KITSHOO))) { //Check for gain of lustzerker - requires legs, arms and tail
				outputText("\nYou start to feel a weird, slightly unpleasant feeling inside your body. Like many tiny flames coursing through your veins, making you ponder what is happening with your body. Remembering about salamanders' natural talent for entering a berserk-like state, you guess that should be it. [pg](Gained Perk: Lustzerker)");
				player.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.hasPerk(PerkLib.Lustzerker) && !player.isRaceCached(Races.SALAMANDER) && !player.isRaceCached(Races.PHOENIX) && !player.isRaceCached(Races.KITSHOO) && player.perkv4(PerkLib.Lustzerker) == 0 && !player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 1) { //Remove lustzerker perk if not meeting requirements
				outputText("\nAll of a sudden, something changes inside your body. You think about it for a long time until it dawns on you. You can't feel that fire in your veins anymore, meaning for now, no more lustzerking. [pg](Lost Perk: Lustzerker)");
				player.removePerk(PerkLib.Lustzerker);
				needNext = true;
			}
			//Phantom Shooting perk
			if (player.isRaceCached(Races.POLTERGEIST, 2) && !player.hasPerk(PerkLib.PhantomShooting)) {
				outputText("\n");
				if (player.weaponRangePerk == "Throwing" || player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") outputText("With your expanded otherworldly knowledge, a thought comes to mind. You apply your ghostly abilities to your " + player.weaponRangeName + " then "+(player.weaponRangePerk == "Throwing" ? "throw it":"shoot")+" at a nearby rock. You can feel a small piece of yourself leave, but the impact of your weapon all but shatters the rock. Using a bit of your ectoplasm instead of basic ammunition definitely made your " + player.weaponRangeName + " stronger.");
				else outputText("With your expanded otherworldly knowledge, a thought comes to mind. If you used some of your ectoplasm instead of basic ammunition for a firearm or throwing weapon, perhaps your weapons will have more of an impact.");
				outputText("\n\n(<b>Gained Perk: Phantom Shooting</b>)");
				player.createPerk(PerkLib.PhantomShooting, 0, 0, 0, 0);
				needNext = true;
			}
			else if (!player.isRaceCached(Races.POLTERGEIST, 2) && player.hasPerk(PerkLib.PhantomShooting)) {// && !player.perkv1(IMutationsLib.LizanMarrowIM) >= 1
				outputText("\nAs you become more corporeal again, the otherworldly knowledge you once held begins to fade along with your ectoplasm. Looks like it's back to using normal ammunition for your firearms and throwing weapons again...\n\n(<b>Lost Perk: Phantom Shooting</b>)");
				player.removePerk(PerkLib.PhantomShooting);
				needNext = true;
			}
			//Recharge venom/web pool
			if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTICORE_PUSSYTAIL || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SPIDER_FANGS || player.lowerBody == LowerBody.HYDRA || player.lowerBody == LowerBody.ATLACH_NACHA
			|| player.hasPerk(PerkLib.ImprovedVenomGland) || player.perkv1(IMutationsLib.VenomGlandsIM) >= 2 || player.hasPerk(PerkLib.VenomousDiet) || player.hasPerk(PerkLib.HighlyVenomousDiet) || player.hasPerk(PerkLib.AxillaryVenomGlands) || player.hasPerk(PerkLib.VenomousAdiposeTissue)) { //Spider, Bee, Scorpion, Manticore, Naga and Altach Nacha Venom Recharge
				var venomHRecharge:Number = 0;
				venomHRecharge += combat.venomCombatRecharge2();
				if (player.hasPerk(PerkLib.HighlyVenomousDiet)) {
					if (player.maxHunger() > 1600) venomHRecharge += 27.5;
					else if (player.maxHunger() > 800) venomHRecharge += 22.5;
					else if (player.maxHunger() > 400) venomHRecharge += 17.5;
					else if (player.maxHunger() > 200) venomHRecharge += 12.5;
					else if (player.maxHunger() > 100) venomHRecharge += 7.5;
					else venomHRecharge += 2.5;
				}
				player.tailVenom += venomHRecharge;
				if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
			}
			//DarkCharm
			if (player.isRaceCached(Races.DEMON)) {
				if (!player.hasPerk(PerkLib.DarkCharm)) {
					outputText("\nYou feel a strange sensation in your body. With you looking like a demon, you have unlocked the potential to use demonic charm attacks!\n\n(<b>Gained Perk: Dark Charm</b>)\n");
					player.createPerk(PerkLib.DarkCharm, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.DarkCharm) && player.perkv4(PerkLib.DarkCharm) == 0 && player.perkv1(IMutationsLib.BlackHeartIM) == 0) {
				outputText("\nWith some of your demon-like traits gone, so does your ability to use charm attacks.\n\n(<b>Lost Perk: Dark Charm</b>)\n");
				player.removePerk(PerkLib.DarkCharm);
				needNext = true;
			}
			//Jungle’s Wanderer
			if (player.isRaceCached(Races.REDPANDA)) {
				if (!player.hasPerk(PerkLib.JunglesWanderer)) {
					//outputText("\nWhile stretching, you notice that you're much more flexible than you were before.  \n\n(<b>Gained Perk: Jungle’s Wanderer</b>)\n");
					player.createPerk(PerkLib.JunglesWanderer, 0, 0, 0, 0);
					//needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.JunglesWanderer) && !player.isRaceCached(Races.REDPANDA)) {
				//outputText("\nYou notice that you aren't as flexible as you were when you had a more feline body.  \n\n(<b>Lost Perk: Jungle’s Wanderer</b>)\n");
				player.removePerk(PerkLib.JunglesWanderer);
				//needNext = true;
			}
			//Freezing Breath
			if (player.faceType == Face.WOLF && !player.hasPerk(PerkLib.FreezingBreath) && player.hasKeyItem("Gleipnir Collar") >= 0) {
				outputText("\nYou suddenly feel something raging in you wanting to be unleashed as it slowly climbs out of your chest. It rushes through your throat and you scream a titanic primordial roar as the air in front of you ondulate with a massive drop of temperature and everything covers with a thick layer of solid ice. You massage your throat for a moment noticing as thin volume of condensation constantly escape from your maw.\n\n(<b>Gained Perk: Freezing Breath</b>)\n");
				player.createPerk(PerkLib.FreezingBreath, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.faceType != Face.WOLF && player.hasPerk(PerkLib.FreezingBreath) && player.hasKeyItem("Gleipnir Collar") >= 0) {
				outputText("\nAs you no longer are wolf like enough to maintain the form of a full Fenrir your breath no longer freezes the ambient air.\n\n<b>(Lost Perk: Freezing Breath)</b>\n");
				player.removePerk(PerkLib.FreezingBreath);
				needNext = true;
			}
			//Fenrir Soulbite
			if (player.faceType == Face.WOLF && !player.hasPerk(PerkLib.FenrirSpiritstrike) && player.hasKeyItem("Gleipnir Collar") >= 0) {
				outputText("\nLike Fenrir you have aquired the ability to not only see souls but also tear them devouring your opponent very essence with every particularly devastating bite.\n\n(<b>Gained Perk: Spirit strike</b>)\n");
				player.createPerk(PerkLib.FenrirSpiritstrike, 0, 0, 0, 0);
				needNext = true;
			}
			//Fenrir Eyes
			if (CoC.instance.transformations.EyesFenrir.isPossible() && player.hasKeyItem("Gleipnir Collar") >= 0) {
				outputText("\n");
				CoC.instance.transformations.EyesFenrir.applyEffect();
				outputText("\n");
				needNext = true;
			}
			//Fenrir Back Ice Shards
			if (player.rearBody.type != RearBody.FENRIR_ICE_SPIKES && player.hasKeyItem("Gleipnir Collar") >= 0) {
				outputText("\nYou feel an icy chill run through your body as your divine nature reasserts itself over your body. You won't escape your destiny as the Fenrir so easily, it seems.");
				outputText("\n\nYou double over as ice once more bursts from your skin down your spine, covering your back in frozen spikes.\"<b>Your back is now covered with sharp ice spike, constantly cooling the air around you. (Gained Frozen Waste and Cold Mastery perks)</b>\"\n");
				player.rearBody.type = RearBody.FENRIR_ICE_SPIKES;
				needNext = true;
			}
			//Cold Affinity
			if (player.perkv1(IMutationsLib.WhaleFatIM) >= 1 && !player.hasPerk(PerkLib.ColdAffinity)) {
				outputText("\nYou suddenly no longer feel the cold thanks to your whale fat so you guess you finally got acclimated to the icy winds of the glacial rift. \n\n(<b>Gained Perks: Cold Affinity</b>)\n");
				player.createPerk(PerkLib.ColdAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.isRaceCached(Races.YETI) && (!player.hasPerk(PerkLib.ColdAffinity) || !player.hasPerk(PerkLib.FreezingBreathYeti))) {
				outputText("\nYou suddenly no longer feel the cold so you guess you finally got acclimated to the icy winds of the glacial rift. You feel at one with the cold. So well that you actually developed icy power of your own.\n\n(<b>Gained Perks: Cold Affinity and Freezing Breath Yeti</b>)\n");
				player.createPerk(PerkLib.ColdAffinity, 0, 0, 0, 0);
				player.createPerk(PerkLib.FreezingBreathYeti, 0, 0, 0, 0);
				needNext = true;
			}
			if ((player.isRaceCached(Races.MELKIE) || player.isRaceCached(Races.FROSTWYRM)) && !player.hasPerk(PerkLib.ColdAffinity)) {
				outputText("\nYou suddenly no longer feel the cold so you guess you finally got acclimated to the icy winds of the glacial rift. You feel at one with the cold. So well that you actually developed icy power of your own.\n\n(<b>Gained Perks: Cold Affinity</b>)\n");
				player.createPerk(PerkLib.ColdAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			else if (!player.isRaceCached(Races.YETI) && !player.isRaceCached(Races.YUKIONNA) && !player.isRaceCached(Races.MELKIE) && !player.isRaceCached(Races.FROSTWYRM) && !player.perkv1(IMutationsLib.WhaleFatIM) >= 1 && player.hasPerk(PerkLib.ColdAffinity)) {
				outputText("\nYou suddenly feel a chill in the air. You guess you somehow no longer resist the cold.\n\n<b>(Lost Perks: Cold Affinity");
				player.removePerk(PerkLib.ColdAffinity);
				if (player.hasPerk(PerkLib.FreezingBreathYeti)){
					outputText(" and Freezing Breath Yeti");
					player.removePerk(PerkLib.FreezingBreathYeti);
				}
				outputText(")</b>\n");
				needNext = true;
			}
			//Dark Affinity
			if ((player.racialScoreCached(Races.VAMPIRE) >= 15 || player.isRaceCached(Races.APOPHIS)) && (!player.hasPerk(PerkLib.DarknessAffinity))) {
				outputText("\nYou at home in darkness seeing as clearly in the shadows wich you find comforting as in broad daylight.\n\n(<b>Gained Perks: Darkness Affinity</b>)\n");
				player.createPerk(PerkLib.DarknessAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.racialScoreCached(Races.VAMPIRE) < 15 && !player.isRaceCached(Races.APOPHIS) && player.hasPerk(PerkLib.DarknessAffinity)) {
				outputText("\nThe pitch black darkness becomes hostile toward you again as you lose your affinity toward it.\n\n<b>(Lost Perks: Darkness Affinity");
				player.removePerk(PerkLib.DarknessAffinity);
				outputText(")</b>\n");
				needNext = true;
			}
			if ((player.isRaceCached(Races.SIREN) || player.isRaceCached(Races.HARPY) || player.isRaceCached(Races.PHOENIX) || player.isRaceCached(Races.THUNDERBIRD)) && !player.hasPerk(PerkLib.HarpySong)) {
				outputText("\n Your voice sound like magicaly entrancing music to your ears now, it would seem you have gained the infamous magicaly compeling voices common to harpies. <b>Gained Perks: Harpy Song</b>)\n");
				player.createPerk(PerkLib.HarpySong, 0, 0, 0, 0);
				needNext = true;
			}
			//Compelling Aria
			if (player.tongue.type != Tongue.MELKIE && player.hasPerk(PerkLib.MelkieSong) && !player.perkv1(IMutationsLib.MelkieLungIM) >= 1) {
				outputText("\n Your voice no longer carries the magical power it used to and thus you are no longer able to use your compelling aria. <b>Lost Perks: Melkie Song</b>)\n");
				player.removePerk(PerkLib.MelkieSong);
				needNext = true;
			}
			if (!player.isRaceCached(Races.SIREN) && !player.isRaceCached(Races.HARPY) && !player.isRaceCached(Races.PHOENIX) && !player.isRaceCached(Races.THUNDERBIRD) && player.hasPerk(PerkLib.HarpySong) && !player.perkv1(IMutationsLib.HarpyHollowBonesIM) >= 1) {
				outputText("\n Your voice no longer carries the magical power it used to and thus you are no longer able to use your compelling aria. <b>Lost Perks: Harpy Song</b>)\n");
				player.removePerk(PerkLib.HarpySong);
				needNext = true;
			}
			//Icy flesh
			if (!player.isRaceCached(Races.YUKIONNA) && player.hasPerk(PerkLib.IcyFlesh)) {
				outputText("\nYour body slowly comes back to life as if it has been hibernating for a long time. You feel sickly as if dying, hungry as if you'd been starving for weeks and thirstier than if you'd been wandering the desert without drinks for about half as much.\n\n(<b>Lost Perks: "+((player.hasPerk(PerkLib.ColdAffinity) && !player.isRaceCached(Races.YETI)) ? "Cold Affinity, ":"")+"Dead metabolism and Icy flesh</b>)\n");
				if (player.hasPerk(PerkLib.ColdAffinity) && !player.isRaceCached(Races.YETI)) player.removePerk(PerkLib.ColdAffinity);
				player.removePerk(PerkLib.DeadMetabolism);
				player.removePerk(PerkLib.IcyFlesh);
				needNext = true;
			}
			//Alraune perks
			if (player.isAlraune() && (!player.hasPerk(PerkLib.AlrauneNectar) || player.vaginaType() != VaginaClass.ALRAUNE)){
				if (player.vaginaType() != VaginaClass.ALRAUNE){
					player.vaginaType(VaginaClass.ALRAUNE);
					outputText("\nYour flower now produces a delicious nectar the scent of wich is sure to draw in partners.");
				}
				if (!player.hasPerk(PerkLib.AlrauneNectar)){
					outputText(" <b>Gained Perk: Alraune Nectar</b>");
					player.createPerk(PerkLib.AlrauneNectar, 0,0,0,0);
				}
				outputText("\n");
				needNext = true;
			}
			if (player.isAlraune() && !player.hasPerk(PerkLib.PlantKnowledge)){
				outputText("\nIt would seem you aquired additionnal skills in herbalism thanks to behing a plant yourself. <b>Gained Perk: Plant Knowledge</b>\n");
				player.createPerk(PerkLib.PlantKnowledge, 0,0,0,0);
				needNext = true;
			}
			if (!player.isAlraune() && player.hasPerk(PerkLib.AlrauneNectar)){
				outputText("\nAs you no longer have a pitcher to produce nectar your scent has became more like that of an ordinary human. <b>Lost Perk: Alraune Nectar</b>\n");
				player.removePerk(PerkLib.AlrauneNectar);
				player.vaginaType(VaginaClass.HUMAN);
				needNext = true;
			}
			if (!player.isAlraune() && player.hasPerk(PerkLib.PlantKnowledge)){
				outputText("\nNo longer a plant you lost some of your innate floral knowledge. <b>Lost Perk: Plant Knowledge</b>\n");
				player.removePerk(PerkLib.PlantKnowledge);
				needNext = true;
			}
			//Kamaitachi perks
			if (player.arms.type == Arms.KAMAITACHI && !player.hasPerk(PerkLib.CursedWound)){
				outputText("\nYour kamaitachi blades shines with a sharp, deadly glow. Those will clearly leaves deadly wounds. <b>Gained Perk: Cursed Wound</b>\n");
				player.createPerk(PerkLib.CursedWound, 0,0,0,0);
				needNext = true;
			}
			if (player.arms.type != Arms.KAMAITACHI && player.hasPerk(PerkLib.CursedWound)){
				outputText("\nLacking a pair of kamaitachi scythe you can no longer inflict your trademark cursed kamaitachi wounds. <b>Lost Perk: Cursed Wound</b>\n");
				player.removePerk(PerkLib.CursedWound);
				needNext = true;
			}
			if (player.isRaceCached(Races.KAMAITACHI) && !player.hasPerk(PerkLib.NaturalHerbalism)){
				outputText("\nGreat knowledges flows throught you mind as you become more Kamaitachi like. " +
						"It dawns on you that you have aquired a natural affinity for medicine and herbalism, " +
						"something your species is famous for, heck you can identify every single plant near your camp by name and species now. " +
						"<b>Gained Perk: Natural Herbalism</b>\n");
				player.createPerk(PerkLib.NaturalHerbalism, 0,0,0,0);
				needNext = true;
			}
			if (!player.isRaceCached(Races.KAMAITACHI) && player.hasPerk(PerkLib.NaturalHerbalism)){
				outputText("\nNo longer a Kamaitachi, you seem to have lost your knack for herbs and medicines. <b>Lost Perks: Natural Herbalism</b>)\n");
				player.removePerk(PerkLib.NaturalHerbalism);
				needNext = true;
			}
			//Aquatic Affinity
			if (InCollection(player.lowerBody,LowerBody.ORCA,LowerBody.SEA_DRAGON) && InCollection(player.arms.type,Arms.ORCA,Arms.SEA_DRAGON) && player.tailType == Tail.ORCA && InCollection(player.ears.type,Ears.ORCA,Ears.ORCA) && !player.hasPerk(PerkLib.AquaticAffinity)) {
				outputText("\nYou suddenly feel an urge to jump into the nearest pool of water as your breath becomes ragged and messy. You swiftly run up to the stream and scream in release as you fill your aching respiratory systems with water. Wait water? You realise you just gained the ability to breath underwater but to make sure you can still breath normal air you go back to the surface. It soon appears you can still breath fresh air. Reassured on your condition you head back to camp.\n");
				if (player.rearBody.type == RearBody.ORCA_BLOWHOLE) outputText("\nIt dawns on you that you didn't breath for a full hour. When you realise this you relax your blowhole and take in some air. Well wow it seems you can now hold in your oxigen for very lengthy period. This will be perfect for underwater explorations.\n");
				outputText("\n(<b>Gained Perk: Aquatic Affinity</b>)\n");
				player.createPerk(PerkLib.AquaticAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			else if ((!InCollection(player.lowerBody,LowerBody.ORCA,LowerBody.SEA_DRAGON) || !InCollection(player.arms.type,Arms.ORCA,Arms.SEA_DRAGON) || player.tailType != Tail.ORCA || !InCollection(player.ears.type,Ears.ORCA,Ears.ORCA)) && player.hasPerk(PerkLib.AquaticAffinity)) {
				outputText("\nAs you lose the respiratory organ to breath underwater it also becomes obvious that you will drown if attempting to breath water in. You will need to get items or transform to breath underwater again.\n");
				if (player.rearBody.type == RearBody.ORCA_BLOWHOLE) outputText("\nYou take a deep breath in then out. It seems you can no longer hold your breath like the whales do. It will take some using to.</b>\n");
				outputText("\n<b>(Lost Perk: Aquatic Affinity)</b>\n");
				player.removePerk(PerkLib.AquaticAffinity);
				needNext = true;
			}
			//Fire Affinity
			if ((player.racialScoreCached(Races.SALAMANDER) >= 4 || player.isRaceCached(Races.PHOENIX) || player.isRaceCached(Races.HELLCAT) || player.isRaceCached(Races.FIRESNAILS) || (player.isRaceCached(Races.MOUSE, 2)) || player.isRaceCached(Races.KITSHOO) || player.isRaceCached(Races.CERBERUS)) && !player.hasPerk(PerkLib.FireAffinity)) {
				outputText("\nYou suddenly feels your body temperature rising to ridiculus level. You pant for several minutes until you're finally at ease with your bodily heat. You doubt any more heat is going to make you more uncomfortable then this as you quietly soak in the soothing warmth your body naturally produce. It's like your body is made out of living fire.\n\n(<b>Gained Perk: Fire Affinity</b>)\n");
				player.createPerk(PerkLib.FireAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			else if ((player.racialScoreCached(Races.SALAMANDER) < 4 && !player.isRaceCached(Races.PHOENIX) && !player.isRaceCached(Races.HELLCAT) && !player.isRaceCached(Races.FIRESNAILS) && !player.isRaceCached(Races.MOUSE, 2) && !player.isRaceCached(Races.KITSHOO) && !player.isRaceCached(Races.CERBERUS)) && player.hasPerk(PerkLib.FireAffinity)) {
				outputText("\nYou suddenly feel chilly as your bodily temperature drop down to human level. You lost your natural warmth reverting to that of a standard human.\n\n<b>(Lost Perk: Fire Affinity)</b>\n");
				player.removePerk(PerkLib.FireAffinity);
				needNext = true;
			}
			//Lightning Affinity
			if ((player.isRaceCached(Races.SEA_DRAGON)) && !player.hasPerk(PerkLib.LightningAffinity)) {
				outputText("\nYou suddenly feel a rush of electricity run across your skin as your biolight goes crazy! It would seem you gained the ability to generate and control electricity not unlike an electric eel or more specificaly a sea dragon\n");
				outputText("\n(<b>Gained the lightning affinity perk and Electric discharge ability!</b>)\n");
				player.createPerk(PerkLib.LightningAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			if ((player.isRaceCached(Races.RAIJU) || player.isRaceCached(Races.THUNDERBIRD) || player.isRaceCached(Races.KIRIN)) && !player.hasPerk(PerkLib.LightningAffinity)) {
				outputText("\nYou suddenly feel a rush of electricity run across your skin as your arousal builds up and begin to masturbate in order to get rid of your creeping desire. However even after achieving orgasm not only are you still aroused but you are even hornier than before! You realise deep down that the only way for you to be freed from this jolting pleasure is to have sex with a partner!\n");
				if (player.isRaceCached(Races.THUNDERBIRD)){
					player.createStatusEffect(StatusEffects.IsThunderbird,0,0,0,0);
					player.createPerk(PerkLib.Supercharged,0,0,0,0);
				}
				if (player.isRaceCached(Races.RAIJU)) {
					player.createStatusEffect(StatusEffects.IsRaiju,0,0,0,0);
					player.createPerk(PerkLib.LightningClaw,0,0,0,0);
					player.createPerk(PerkLib.Supercharged,0,0,0,0);
					outputText("\n(<b>Gained the lightning affinity perk, electrified desire perk, Lightning claw perk, Pleasure bolt ability and Orgasmic lightning strike ability!</b>)\n");
				}
				if (player.isRaceCached(Races.KIRIN)) {
					player.createStatusEffect(StatusEffects.IsKirin,0,0,0,0);
					player.createPerk(PerkLib.Supercharged,0,0,0,0);
					outputText("\n(<b>Gained the lightning affinity perk, electrified desire perk, Electrify Weapon, Thunder Gore, Thunder Charge, Pleasure bolt ability and Orgasmic lightning strike ability!</b>)\n");
				}
				player.createPerk(PerkLib.LightningAffinity, 0, 0, 0, 0);
				player.createPerk(PerkLib.ElectrifiedDesire, 0, 0, 0, 0);
				needNext = true;
			}
			else if (!player.isRaceCached(Races.RAIJU) && !player.isRaceCached(Races.THUNDERBIRD) && player.hasPerk(PerkLib.LightningAffinity) && player.hasStatusEffect(StatusEffects.IsRaiju) && !player.hasStatusEffect(StatusEffects.IsThunderbird)  && !player.hasStatusEffect(StatusEffects.IsKirin)) {
				outputText("\nYour natural electricity production start dropping at a dramatic rate until finally there is no more. You realise you likely aren’t raiju enough to build electricity anymore which, considering you can reach satisfaction again, might not be a bad thing.\n\n<b>(Lost the lightning affinity perk, electrified desire perk, Lightning claw perk, Pleasure bolt ability and Orgasmic lightning strike ability!)</b>\n");
				player.removeStatusEffect(StatusEffects.IsRaiju);
				player.removePerk(PerkLib.LightningAffinity);
				player.removePerk(PerkLib.ElectrifiedDesire);
				player.removePerk(PerkLib.LightningClaw);
				player.removePerk(PerkLib.Supercharged);
				needNext = true;
			}
			else if (!player.isRaceCached(Races.KIRIN) && !player.isRaceCached(Races.RAIJU) && !player.isRaceCached(Races.THUNDERBIRD) && player.hasPerk(PerkLib.LightningAffinity) && player.hasStatusEffect(StatusEffects.IsRaiju) && !player.hasStatusEffect(StatusEffects.IsThunderbird) && !player.hasStatusEffect(StatusEffects.IsKirin)) {
				outputText("\nYour natural electricity production start dropping at a dramatic rate until finally there is no more. You realise you likely aren’t kirin enough to build electricity anymore which, considering you can reach satisfaction again, might not be a bad thing.\n\n<b>(Lost the lightning affinity perk, electrified desire perk, Lightning claw perk, Pleasure bolt ability and Orgasmic lightning strike ability!)</b>\n");
				player.removeStatusEffect(StatusEffects.IsKirin);
				player.removePerk(PerkLib.LightningAffinity);
				player.removePerk(PerkLib.ElectrifiedDesire);
				player.removePerk(PerkLib.Supercharged);
				needNext = true;
			}
			else if (!player.isRaceCached(Races.THUNDERBIRD) && player.hasPerk(PerkLib.LightningAffinity) && player.hasStatusEffect(StatusEffects.IsThunderbird) && !player.hasStatusEffect(StatusEffects.IsRaiju) && !player.hasStatusEffect(StatusEffects.IsKirin)) {
				outputText("\nYour natural electricity production starts dropping at a dramatic rate until finally there is no more. You realise you likely aren’t thunderbird enough to build electricity anymore which, considering you can reach satisfaction again, might not be a bad thing.\n\n<b>(Lost the lightning affinity perk, electrified desire perk, Lightning claw perk, Pleasure bolt ability and Orgasmic lightning strike ability!)</b>\n");
				player.removeStatusEffect(StatusEffects.IsThunderbird);
				player.removePerk(PerkLib.LightningAffinity);
				player.removePerk(PerkLib.ElectrifiedDesire);
				player.removePerk(PerkLib.Supercharged);
				needNext = true;
			}
			else if (!player.isRaceCached(Races.SEA_DRAGON) && player.hasPerk(PerkLib.LightningAffinity) && !player.hasStatusEffect(StatusEffects.IsKirin) && !player.hasStatusEffect(StatusEffects.IsThunderbird) && !player.hasStatusEffect(StatusEffects.IsRaiju)) {
				outputText("\nYour natural electricity production starts dropping at a dramatic rate until finally there is no more. You realise you likely aren’t a sea dragon enough to build electricity anymore.\n\n<b>(Lost the lightning affinity perk and electric discharge ability!!)</b>\n");
				player.removePerk(PerkLib.LightningAffinity);
				needNext = true;
			}
			if (player.isRaceCached(Races.RAIJU) && player.hasPerk(PerkLib.LightningAffinity) && !player.hasStatusEffect(StatusEffects.IsRaiju)) {
				player.createStatusEffect(StatusEffects.IsRaiju,0,0,0,0);
			}
			if (!player.isRaceCached(Races.RAIJU) && (player.hasStatusEffect(StatusEffects.IsThunderbird) || player.hasStatusEffect(StatusEffects.IsKirin)) && player.hasStatusEffect(StatusEffects.IsRaiju)) {
				player.removeStatusEffect(StatusEffects.IsRaiju);
			}
			if (player.isRaceCached(Races.THUNDERBIRD) && player.hasPerk(PerkLib.LightningAffinity) && !player.hasStatusEffect(StatusEffects.IsThunderbird)) {
				player.createStatusEffect(StatusEffects.IsThunderbird,0,0,0,0);
			}
			if (!player.isRaceCached(Races.THUNDERBIRD) && (player.hasStatusEffect(StatusEffects.IsRaiju) || player.hasStatusEffect(StatusEffects.IsKirin)) && player.hasStatusEffect(StatusEffects.IsThunderbird)) {
				player.removeStatusEffect(StatusEffects.IsThunderbird);
			}
			if (player.isRaceCached(Races.KIRIN) && player.hasPerk(PerkLib.LightningAffinity) && !player.hasStatusEffect(StatusEffects.IsKirin)) {
				player.createStatusEffect(StatusEffects.IsKirin,0,0,0,0);
			}
			if (!player.isRaceCached(Races.KIRIN) && (player.hasStatusEffect(StatusEffects.IsRaiju) || player.hasStatusEffect(StatusEffects.IsThunderbird)) && player.hasStatusEffect(StatusEffects.IsKirin)) {
				player.removeStatusEffect(StatusEffects.IsKirin);
			}
			/*

			if (player.thundermantis() >= 10 && player.tailType == Tail.THUNDERBIRD && !player.hasPerk(PerkLib.LightningAffinity)) {
				outputText("\nYou suddenly feel a rush of electricity run across your skin as your static energy builds up. You realise deep down that the only way for you to be freed from this is to unleash it on someone else.\n\n(<b>Gained the lightning affinity perk and Orgasmic lightning strike ability!</b>)\n");
				player.createPerk(PerkLib.LightningAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.thundermantis() < 10 && player.tailType != Tail.THUNDERBIRD && player.hasPerk(PerkLib.LightningAffinity)) {
				outputText("\nYour natural electricity production start dropping at a dramatic rate until finally there is no more. You realise you likely aren’t thunderbird enough to build electricity anymore.\n\n<b>(Lost the lightning affinity perk and Orgasmic lightning strike ability!)</b>\n");
				player.removePerk(PerkLib.LightningAffinity);
				needNext = true;
			}*/
			//Yeti stuff
			if (player.rearBody.type == RearBody.YETI_FUR && !player.hasStatusEffect(StatusEffects.YetiScarf)) {
				player.createStatusEffect(StatusEffects.YetiScarf,0,0,0,0);
			}
			if (player.rearBody.type != RearBody.YETI_FUR && player.hasStatusEffect(StatusEffects.YetiScarf)) {
				player.removeStatusEffect(StatusEffects.YetiScarf);
			}
			if (player.lowerBody == LowerBody.YETI && player.arms.type == Arms.YETI && !player.hasPerk(PerkLib.BigHandAndFeet)) {
				outputText("\nGeeze, with those oversized hands and feet you should just drop your weapon and punch things out cold. Why do you even need a weapon for anyway?\n\n<b>(Gained the Big hand and feet perk!)</b>\n");
				player.createPerk(PerkLib.BigHandAndFeet, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.BigHandAndFeet) && (player.lowerBody != LowerBody.YETI || player.arms.type != Arms.YETI)) {
				outputText("\nYour limbs are now back to their normal size, it might be smart to use a weapon over your bare hands and feet for fighting.\n\n<b>(Lost the Big hand and feet perk!)</b>\n");
				player.removePerk(PerkLib.BigHandAndFeet);
				needNext = true;
			}
			//Levitation wing slot
			if (player.wings.type == Wings.LEVITATION && player.rearBody.type != RearBody.GLACIAL_AURA && player.lowerBody != LowerBody.WENDIGO && player.lowerBody != LowerBody.GAZER) {
				outputText("\nAs you do not meet the requirements, you also lose the knowledge on how to levitate!\nHint: Aura of the Yuki Onna or legs of the Wendigo or Gazer");
				player.wings.type = Wings.NONE;
				needNext = true;
			}
			//Wendigo stuff
			if (!player.blockingBodyTransformations() && player.hasStatusEffect(StatusEffects.WendigoPsychosis) && !player.hasPerk(PerkLib.EndlessHunger) && ((flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger <= 0) || (flags[kFLAGS.HUNGER_ENABLED] <= 0 && player.lust >= player.maxOverLust()))) SceneLib.glacialRift.wendigoScene.becomeWendigo();
			//Gazer perks
			if (player.eyes.type == Eyes.MONOEYE && !player.hasPerk(PerkLib.TrueSeeing)) {
				outputText("\nAs part of acquiring an all seeing eye your sight has improved greatly. It would seem you now possess the innate ability to dismiss illusions and falsehood seeing the world as it truly is. <b>You acquired True Seeing.</b> \n\n(<b>Gained Perk: True seeing</b>)");
				player.createPerk(PerkLib.TrueSeeing, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.eyes.type != Eyes.MONOEYE && player.hasPerk(PerkLib.TrueSeeing) && !player.perkv1(IMutationsLib.GazerEyesIM) >= 1) {
				outputText("\nYour sigh is not what it used to be. No longer having a cyclopean vision you have lost the power of true sight. \n\n(<b>Lost Perk: True seeing</b>)");
				player.removePerk(PerkLib.TrueSeeing);
				needNext = true;
			}
			if (player.rearBody.type == RearBody.TENTACLE_EYESTALKS && player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6 && !player.hasPerk(PerkLib.Omnicaster)) {
				outputText("\nSomething weird is happening with your magic! Just to confirm you use a standard magic bolt and watch in surprise as you instinctively split the spell using your eyes to launch multiple projectiles at once. <b>It would seem you acquired the ability to omnicast!</b> \n\n(<b>Gained Perk: Omnicaster</b>)");
				player.createPerk(PerkLib.Omnicaster, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.rearBody.type != RearBody.TENTACLE_EYESTALKS && player.hasPerk(PerkLib.Omnicaster)) {
				if (player.hasStatusEffect(StatusEffects.GazerEyeStalksPlayer)) player.removeStatusEffect(StatusEffects.GazerEyeStalksPlayer);
				outputText("\nLacking the occulatory prowess of many eyes you also lose the ability to omnicast. \n\n(<b>Lost Perk: Omnicaster</b>)");
				player.removePerk(PerkLib.Omnicaster);
				needNext = true;
			}
			//Necromancy perk
			if (((player.tailType == Tail.CAT && player.tailCount == 2) || player.tailType == Tail.NEKOMATA_FORKED_2_3 || player.tailType == Tail.NEKOMATA_FORKED_1_3) && !player.hasPerk(PerkLib.Necromancy)) {
				outputText("\nYou feel tremendous fell powers investing your being. You blink and almost jump as you realise you can literally can see the souls of the dead as well as those of the living now. Your powers over life and death have grown as <b>you seem to have acquired a natural talents for the darker arts.</b>\n\n(<b>Gained Perk: Necromancy</b>)\n");
				player.createPerk(PerkLib.Necromancy, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.hasPerk(PerkLib.Necromancy) && player.perkv4(PerkLib.Necromancy) == 0 && player.tailCount != 2 && player.tailType != Tail.CAT && player.tailType != Tail.NEKOMATA_FORKED_2_3 && player.tailType != Tail.NEKOMATA_FORKED_1_3) { //Remove Necromancy perk if not meeting requirements
				outputText("\nHaving lost the source of your nekomata powers the fell energy in your body seems to recede and vanish completely.\n\n(<b>Lost Perk: Necromancy</b>)\n");
				player.removePerk(PerkLib.Necromancy);
				needNext = true;
			}
			//Cancer stance
			if (player.arms.type == Arms.HUMAN && player.lowerBody == LowerBody.CANCER && !player.hasStatusEffect(StatusEffects.CancerCrabStance)) {
				outputText("\n\nEver since your lower body became that of a crab you began instinctively folding your arms and hands like those of a mantis or rather, the pincers of a crab. " +
						"This pose, natural to you, somewhat looks weird or mystical to the onlooker, " +
						"as if you were taking some form of martial art stance though for you this is just the natural way to rest your limbs.\n");
				player.createStatusEffect(StatusEffects.CancerCrabStance,0,0,0,0);
				needNext = true;
			}
			//Cancer stance
			if ((player.arms.type != Arms.HUMAN || player.lowerBody != LowerBody.CANCER) && player.hasStatusEffect(StatusEffects.CancerCrabStance)) {
				outputText("\nYour body is now less crab-like, you have stopped folding your arms like one would.\n");
				player.removeStatusEffect(StatusEffects.CancerCrabStance);
				needNext = true;
			}
			//Elven Sense
			if ((player.eyes.type != Eyes.ELF || player.ears.type != Ears.ELVEN) && player.hasPerk(PerkLib.ElvenSense) && !player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 1 && !player.hasPerk(PerkLib.BlessingOfTheAncestorTree)) {
				outputText("\nYou feels yourself less aware of your surroundings. Heck your vision seems less keen then it used to be. Most likely because you no longer possess the senses of an elf.\n\n<b>(Lost the Elven Sense perk!)</b>\n");
				player.removePerk(PerkLib.ElvenSense);
				needNext = true;
			}
			//Wood elf fixed by blessing of the ancestor tree
			if (player.hasPerk(PerkLib.BlessingOfTheAncestorTree)) {
				if (!player.hasPerk(PerkLib.ElvenSense)) {
					outputText("\nYour acute hearing warns you of imminent danger and you dodge as a branch falls from a nearby tree missing your head by mere inches. You realise your newly sharpened senses granted you increased agility and precision.  <b>You gained the ability Elven Senses.</b>\n\n");
					outputText("<b>(Gained Perk: Elven Sense</b>)");
					player.createPerk(PerkLib.ElvenSense, 0, 0, 0, 0);
				}
				if (!player.hasPerk(PerkLib.FlawlessBody)) {
					outputText("\nYou examine your body discovering with surprise your skin is now extremely sensitive but also flawless just like that of an elf. ");
					outputText("It is beautiful and inviting to the touch, surely your opponents would beg for a chance to get but a single taste of your flawless body. <b>Your " + player.skinColor + " skin is now flawless just like that of the elves.</b>");
					outputText("\n\n<b>(Gained Perk: Flawless Body</b>)");
					player.createPerk(PerkLib.FlawlessBody, 0, 0, 0, 0);
				}
				if (!player.hasPerk(PerkLib.NaturalSpellcasting)) {
					outputText("\nAs your body finishes changing you feel something fundamental shift in your essence. Magic… You somehow feel magic come to you more easily. Casting spells should be easier to you now that your voice sings the incantations and your hand weaves the signs with ideal precisions.  <b>You gained the ability Natural Spellcasting.</b>");
					outputText("\n\n<b>(Gained Perk: Natural Spellcasting</b>)");
					player.createPerk(PerkLib.NaturalSpellcasting, 0, 0, 0, 0);
				}
			}
			//Flawless Body
			else if (player.hasPerk(PerkLib.FlawlessBody) && (player.lowerBody != LowerBody.ELF || player.arms.type != Arms.ELF || !player.hasPlainSkinOnly() || player.skinAdj != "flawless")) {
				outputText("\nYour body has becomes less alluring and graceful as part of reverting to a more mundane appearance.\n\n<b>(Lost the Flawless Body perk and the perfect skin!)</b>\n");
				player.removePerk(PerkLib.FlawlessBody);
				player.skin.setBaseOnly({type: Skin.PLAIN, adj:""});
				needNext = true;
			}
			//Ferocity
			if (!player.isRaceCached(Races.ORC) && player.hasPerk(PerkLib.Ferocity) && !player.perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 3) {
				outputText("\nYour natural ferocity starts vanishing at a dramatic rate until finally there is no more. You realise you likely aren’t orc enough anymore, considering you felt so invincible with it, which might not be a good thing.\n\n<b>(Lost the Ferocity perk!)</b>\n");
				player.removePerk(PerkLib.Ferocity);
				needNext = true;
			}
			//Acid Spit and Azureflame Breath
			if (player.racialScore(Races.CAVEWYRM) < 7 && player.hasPerk(PerkLib.AcidSpit) && player.hasPerk(PerkLib.AzureflameBreath)) {// && !player.hasPerk(PerkLib.)
				outputText("\nAs you become less of a cave wyrm your spit and fluids begins to lose their acidic properties until its back to being ordinary drool and fluids. With no acid to ignite it seems you also lost the ability to breath fire.\n\n<b>(Lost the Acid Spit and Azureflame Breath perks!)</b>\n");
				player.removePerk(PerkLib.AcidSpit);
				player.removePerk(PerkLib.AzureflameBreath);
				needNext = true;
			}
			//Titan Might
			if (player.tallness >= 80 &&
				(player.isRaceCached(Races.HYDRA)
					|| player.isRaceCached(Races.SCYLLA, 2)
					|| player.isRaceCached(Races.FROSTWYRM))) {
				if (!player.hasPerk(PerkLib.TitanicSize)) {
					outputText("\nWhoa, you've grown so big its a sheer miracle you don't damage the landscape while moving. That said, your size now contributes to your strength as well.\n\n<b>(Gained Titanic Size perk!)</b>\n");
					player.createPerk(PerkLib.TitanicSize, 0, 0, 0, 0);
					needNext = true;
				}
			} else {
				if (player.hasPerk(PerkLib.TitanicSize)) {
					if (player.tallness < 80) outputText("\nYou sadly are no longer able to benefit from your size as much as you did before. Probably because you have shrunk to a smaller size.\n\n<b>(Lost the Titanic Size perk!)</b>\n");
					else outputText("\nYou sadly are no longer able to benefit from your size as much as you did before. Probably because you have transformed again.\n\n<b>(Lost the Titanic Size perk!)</b>\n");
					player.removePerk(PerkLib.TitanicSize);
					needNext = true;
				}
			}
			//Oni Might
			if (player.isRaceCached(Races.ONI) || player.isRaceCached(Races.CYCLOP) || player.isRaceCached(Races.ORCA) || player.isRaceCached(Races.SEA_DRAGON)) {
				if (!player.hasPerk(PerkLib.GiantMight)) {
					outputText("\nWhoa, you just feel so damn powerful like you could move mountains like your size has no relative correlation with your current strenght. That must be the so called fabled strenght of the giants.\n\n<b>(Gained Oni Might perk!)</b>\n");
					player.createPerk(PerkLib.GiantMight, 0, 0, 0, 0);
					needNext = true;
				}
			} else {
				if (player.hasPerk(PerkLib.GiantMight)) {
					outputText("\nYou sadly are no longer able to benefit from the giant natural might as much as you did before. Probably because you have transformed again.\n\n<b>(Lost the Oni Might perk!)</b>\n");
					player.removePerk(PerkLib.GiantMight);
					needNext = true;
				}
			}
			//VerdantMight
			if ((player.isRaceCached(Races.PLANT) || player.isRaceCached(Races.ALRAUNE)) && !player.hasPerk(PerkLib.VerdantMight)) {
				outputText("\nRaw green power flows throught your veins while being a plant hasnt done so much to improve your muscle your general sturdyness more then makes up for it allowing you to use your toughness instead of your strength when delivering blows.\n\n<b>(gained the Verdant Might perk!)</b>\n");
				player.createPerk(PerkLib.VerdantMight,0,0,0,0);
				needNext = true;
			}
			if (!player.isRaceCached(Races.PLANT) && !player.isRaceCached(Races.ALRAUNE) && player.hasPerk(PerkLib.VerdantMight)) {
				outputText("\nBeing less of a plant you loose the ability to add your own sturdyness to your attacks.\n\n<b>(Lost the Verdant Might perk!)</b>\n");
				player.removePerk(PerkLib.VerdantMight);
				needNext = true;
			}
			//Enigma
			if (player.isRaceCached(Races.SPHINX) && !player.hasPerk(PerkLib.Enigma)) {
				outputText("\nBeing a sphinx has granted you insight on many things including various secrets to martial combat, guess this is what they mean about using your smarts before your brawn.\n\n<b>(Gained Enigma perk!)</b>\n");
				player.createPerk(PerkLib.Enigma, 0, 0, 0, 0);
				needNext = true;
			}
			if (!player.isRaceCached(Races.SPHINX) && player.hasPerk(PerkLib.Enigma)) {
				outputText("\nAs you no longer possess the insight of a sphinx you no longer have the ability to fully use your smarts to improve your martial prowess.\n\n<b>(Lost the Enigma perk!)</b>\n");
				player.removePerk(PerkLib.Enigma);
				needNext = true;
			}/*
			//Rampant Might & Wisdom of the Ages
			if (player.isRaceCached(Races.YGGDRASIL) && !player.hasPerk(PerkLib.VerdantMight) && !player.hasPerk(PerkLib.VerdantMight)) {
				outputText("\nRaw green power flows throught your veins while being a partialy plant hasnt done so much to improve your muscle your general sturdyness more then makes up for it allowing you to use your toughness supplementing your strength when delivering blows. Becoming member of yggdrasil race also granted you insight on many things, which you could use in combat. ");
				outputText("\n\n<b>(gained the Rampant Might & Wisdom of the Ages perk!)</b>\n");
				if (!player.hasPerk(PerkLib.VerdantMight)) player.createPerk(PerkLib.VerdantMight,0,0,0,0);
				if (!player.hasPerk(PerkLib.VerdantMight)) player.createPerk(PerkLib.VerdantMight,0,0,0,0);
				needNext = true;
			}
			if (!player.isRaceCached(Races.YGGDRASIL) && (player.hasPerk(PerkLib.VerdantMight) || player.hasPerk(PerkLib.VerdantMight))) {
				outputText("\nBeing less of a plant dragon you loose the abilities to add your own sturdyness to your attacks and fully use your smarts to improve your martial prowess.\n\n<b>(Lost the Rampant Might & Wisdom of the Ages perks!)</b>\n");
				if (player.hasPerk(PerkLib.VerdantMight)) player.removePerk(PerkLib.VerdantMight);
				if (player.hasPerk(PerkLib.VerdantMight)) player.removePerk(PerkLib.VerdantMight);
				needNext = true;
			}*/
			//Vegetal Affinity
			if ((player.isRaceCached(Races.PLANT) || player.isRaceCached(Races.ALRAUNE) || player.isRaceCached(Races.YGGDRASIL) || player.isRaceCached(Races.WOODELF)) && !player.hasPerk(PerkLib.VegetalAffinity)) {
				outputText("\nWith your connection to the natural flora growing stronger you gained an affinity with plantlife.\n\n<b>(gained the Vegetal Affinity perk!)</b>\n");
				player.createPerk(PerkLib.VegetalAffinity,0,0,0,0);
				needNext = true;
			}
			if (!player.isRaceCached(Races.PLANT) && !player.isRaceCached(Races.ALRAUNE) && !player.isRaceCached(Races.YGGDRASIL) && !player.isRaceCached(Races.WOODELF) && player.hasPerk(PerkLib.VegetalAffinity)) {
				outputText("\nWith your connection to the natural world growing weaker you lose your affinity with plantlife.\n\n<b>(Lost the Vegetal Affinity perk!)</b>\n");
				player.removePerk(PerkLib.VegetalAffinity);
				needNext = true;
			}
			//Lacta bovine immunities
			if (player.isRaceCached(Races.COW) && !player.hasPerk(PerkLib.LactaBovineImmunity)) {
				outputText("\nAs you become more of a lacta bovine you become increasingly obsessed with thoughts of horsecocks and cum sloshing balls, namely minotaur balls. While you are aware you naturally became addicted to minotaur cum you also know your nature as a lacta bovine will protect you from most of its harmful effects allowing you to sample the substance to your heart's content without risks.");
				outputText(".\n\n<b>(Gained the Lacta Bovine Immunity perk!)</b>\n");
				player.createPerk(PerkLib.LactaBovineImmunity, 0, 0, 0, 0);
				needNext = true;
			}
			if (!player.isRaceCached(Races.COW) && player.hasPerk(PerkLib.LactaBovineImmunity)) {
				outputText("\nYour mind clears up as you cease to obsess over minotaur dicks. This is also a sign that you are no longer considered a cow enough to be immune to the addictive effects of minotaur cum.\n\n<b>(Lost the Lacta Bovine Immunity perk!)</b>\n");
				player.removePerk(PerkLib.LactaBovineImmunity);
				needNext = true;
			}
			//Bull Strength
			if ((player.isRaceCached(Races.MINOTAUR, 2) || player.isRaceCached(Races.COW, 2)) && !player.hasPerk(PerkLib.BullStrength)) {
				outputText("\nWhoa, you feel tremendous power accumulate in ");
				if (player.isRaceCached(Races.MINOTAUR, 2)) outputText("your balls. It fills your body with bovine strength, nourishing your muscles with manly power. They say having big balls makes you stronger... Well its not like you can deny the correlation anymore!");
				if (player.isRaceCached(Races.COW, 2)) outputText("your mammaries. It fills your body with bovine strength, nourishing your muscles with milky power. Talk about storing all your might into your jugs!");
				outputText(".\n\n<b>(Gained Bull Strength perk!)</b>\n");
				player.createPerk(PerkLib.BullStrength, 0, 0, 0, 0);
				needNext = true;
			}
			if ((!player.isRaceCached(Races.MINOTAUR, 2) && !player.isRaceCached(Races.COW, 2)) && player.hasPerk(PerkLib.BullStrength)) {
				outputText("\nYou feel weaker, it looks like you lost the benefit of your bull strength. Probably because you are no longer bovine enough.\n\n<b>(Lost the Bull Strength perk!)</b>\n");
				player.removePerk(PerkLib.BullStrength);
				needNext = true;
			}
			//Soul Sense
			if (!player.hasPerk(PerkLib.SoulSense) && player.hasKeyItem("'Soul Sense and You' Manual") >= 0 && player.hasPerk(PerkLib.SoulPersonage)) {
				outputText("\nDuring a casual walk around your camp you suddenly notice, or rather feel, something unexpected. Your surrounding blurs for a moment, to be replaced with a forest. You notice a goblin strolling nearby. Suddenly, she stops and slowly looks around, staring directly at you. A moment later, your vision of the forest becomes blurry, eventually fading away to be replaced by your camp and its surroundings. ");
				outputText("You shake your head, trying to figure out what had just happened. The only solution that you find within yourself is something that Mrs. Shigure you met in He’Xin’Dao at lectures mentioned. Another sense that they had developed, which allowed them to perceive distant places or find specific people over long distances. It looks as though you finaly developed it too.\n");
				player.removeKeyItem("'Soul Sense and You' Manual");
				player.createPerk(PerkLib.SoulSense, 0, 0, 0, 0);
				needNext = true;
			}
			//Hinezumi Coat
			if (player.isRaceCached(Races.MOUSE, 2) && !player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				outputText("\nYour body suddenly coats itself with fire turning incandescent as your lust and body heat spikes up reaching a critical point, this must be the infamous hinezumi coat. You gasp as your lust begins to overwelm you, the flare of desire burns in you and you need to vent it one way or another. ");
				outputText("Feeling inspired you try and expel it through kick and punch on a tree and indeed it works the more you discharge your flames the clearer your mind get. Your hinezumi coat finally stable you sigh in relief.\n\n<b>(Gained Hinezumi Coat!)</b>\n");
				player.createStatusEffect(StatusEffects.HinezumiCoat, 1, 0, 0, 0);
				needNext = true;
			}
			if (!player.isRaceCached(Races.MOUSE, 2) && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				outputText("\nFor one reason or another your inner flames suddenly die down leaving you penting but clear of mind. Seems you no longer are hinezumi enough for the coat to maintain itself.\n\n<b>(Lost the Hinezumi Coat!)</b>\n");
				player.removeStatusEffect(StatusEffects.HinezumiCoat);
				needNext = true;
			}
			//Goblinoid blood & Bouncy body & goblin mechs periodical check up
			if ((player.isGoblinoid()) && !player.hasPerk(PerkLib.GoblinoidBlood)) {
				outputText("\nAs you become a goblinoid again you can feel the chemicals pumped in by your gadgets resume working.\n");
				outputText("\n(<b>Gained Perk: Goblinoid blood</b>)\n");
				if (player.hasKeyItem("Drug injectors") >= 0){
					player.statStore.replaceBuffObject({'sens':5,'lib.mult':0.25},'DrugInjector',{text:'Drug injectors'})
				}
				if (player.hasKeyItem("Improved Drug injectors") >= 0){
					player.statStore.replaceBuffObject({'sens':10,'lib.mult':0.50},'DrugInjector',{text:'Improved Drug injectors'})
				}
				if (player.hasKeyItem("Potent Drug injectors") >= 0){
					player.statStore.replaceBuffObject({'sens':15,'lib.mult':0.75},'DrugInjector',{text:'Potent Drug injectors'})
				}
				if (player.hasKeyItem("Power bracer") >= 0) {
					player.statStore.replaceBuffObject({'sens':5,'str.mult':0.50},'Power bracer',{text:'Power bracer'})
				}
				if (player.hasKeyItem("Powboy") >= 0) {
					player.statStore.replaceBuffObject({'sens':10,'str.mult':0.75},'Power bracer',{text:'Powboy'})
				}
				if (player.hasKeyItem("M.G.S. bracer") >= 0) {
					player.statStore.replaceBuffObject({'sens':15,'str.mult':1},'Power bracer',{text:'M.G.S. bracer'})
				}
				player.createPerk(PerkLib.GoblinoidBlood, 0, 0, 0, 0);
				needNext = true;
			}
			else if ((!player.isGoblinoid()) && player.hasPerk(PerkLib.GoblinoidBlood)) {
				outputText("\nYou feel the drugs in your blood losing effect. Damnit, of course it won’t work since those chemical power ups were tested for goblinoids only. Perhaps in few years you could try and develop a variant...\n");
				outputText("\n<b>(Lost Perk: Goblinoid blood)</b>\n");
				player.removePerk(PerkLib.GoblinoidBlood);
				player.statStore.removeBuffs("DrugInjector");
				player.statStore.removeBuffs("Power bracer");
				needNext = true;
			}
			if ((player.isGoblinoid()) && !player.hasPerk(PerkLib.BouncyBody)) {
				outputText("\nGeeze, with how round and small you've become its like you’ve become a natural cushion now. The worst that will happen is that you'll get yourself punted by some random people mistaking you for a ball. Your body is so bouncy that it naturally has a chance to reduce damage from attacks.\n");
				outputText("\n(<b>Gained Perk: Bouncy body</b>)\n");
				player.createPerk(PerkLib.BouncyBody, 0, 0, 0, 0);
				needNext = true;
			}
			else if ((!player.isGoblinoid()) && player.hasPerk(PerkLib.BouncyBody) && player.perkv1(IMutationsLib.NaturalPunchingBagIM) < 3) {
				outputText("\nYou're not as cushiony as you used to be. Better avoid getting hit.\n");
				outputText("\n<b>(Lost Perk: Bouncy body)</b>\n");
				player.removePerk(PerkLib.BouncyBody);
				needNext = true;
			}
			if (player.vehiclesName == "Goblin Mech Alpha" && (player.isRaceCached(Races.ELF) || player.tallness > 48 || player.tailType != Tail.NONE || player.hasPhysicalWings())) { //Elf OR Taller than 4 ft or having wings/tail
				if (player.isRaceCached(Races.ELF)) outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
				else outputText("Your current anatomy or size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
				if (player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) player.HP /= 1.2;
				if (player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) player.HP /= 1.35;
				if (player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) player.HP /= 1.5;
				player.HP = Math.round(player.HP);
				player.setVehicle(VehiclesLib.NOTHING);
				inventory.takeItem(vehicles.GOBMALP, null);
				needNext = true;
			}
			if (player.vehiclesName == "Goblin Mech Prime" && (player.isRaceCached(Races.ELF) || player.tallness > 48 || player.tailType != Tail.NONE || player.hasPhysicalWings())) { //Elf OR Taller than 4 ft or having wings/tail
				if (player.isRaceCached(Races.ELF)) outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
				else outputText("Your current anatomy or size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
				if (player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) player.HP /= 1.4;
				if (player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) player.HP /= 1.7;
				if (player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) player.HP /= 2;
				player.HP = Math.round(player.HP);
				player.setVehicle(VehiclesLib.NOTHING);
				inventory.takeItem(vehicles.GOBMPRI, null);
				needNext = true;
			}
			if (player.vehiclesName == "Giant Slayer Mech" && (player.isRaceCached(Races.ELF) || player.isRaceCached(Races.WOODELF) || player.tallness > 66 || player.hasPhysicalWings())) { //Elf OR Taller than 5'5" ft or having large wings
				if (player.isRaceCached(Races.ELF) || player.isRaceCached(Races.WOODELF)) outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
				else outputText("Your current anatomy or size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
				if (player.hasKeyItem("Upgraded Armor plating 1.0") >= 0 || player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) {
					var RHP:Number = 1;
					if (player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) RHP += 0.25;
					if (player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) RHP += 0.5;
					if (player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) RHP += 0.75;
					if (player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) RHP += 0.25;
					if (player.hasKeyItem("Upgraded Leather Insulation 2.0") >= 0) RHP += 0.5;
					if (player.hasKeyItem("Upgraded Leather Insulation 3.0") >= 0) RHP += 0.75;
					player.HP /= RHP;
				}
				player.HP = Math.round(player.HP);
				player.setVehicle(VehiclesLib.NOTHING);
				inventory.takeItem(vehicles.GS_MECH, null);
				needNext = true;
			}
			if (player.vehiclesName == "Howling Banshee Mech" && player.tallness < 84) {
				outputText("You aren't tall enough to properly use this vehicle anymore.\n\n");
				var oldHPratio:Number = player.hp100/100;
				if (player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) {
					var oldMax:Number = player.maxOverHP();
					player.buff("HB Mech").remove();
					player.HP *= (player.maxOverHP() / oldMax);
				}
				else player.buff("HB Mech").remove();
				player.HP = oldHPratio*player.maxHP();
				player.HP = Math.round(player.HP);
				player.setVehicle(VehiclesLib.NOTHING);
				inventory.takeItem(vehicles.HB_MECH, null);
				needNext = true;
			}
			if (player.isGoblinoid() && (!player.statStore.hasBuff('DrugInjector') || !player.statStore.hasBuff('Power bracer'))) {
				if (!player.statStore.hasBuff('DrugInjector')) {
					if (player.hasKeyItem("Drug injectors") >= 0){
						outputText("\nYou can feel the chemicals pumped in by your gadgets resume working.\n");
						player.statStore.replaceBuffObject({'sens':5,'lib.mult':0.25},'DrugInjector',{text:'Drug injectors'});
						needNext = true;
					}
					if (player.hasKeyItem("Improved Drug injectors") >= 0){
						outputText("\nYou can feel the chemicals pumped in by your gadgets resume working.\n");
						player.statStore.replaceBuffObject({'sens':10,'lib.mult':0.50},'DrugInjector',{text:'Improved Drug injectors'});
						needNext = true;
					}
					if (player.hasKeyItem("Potent Drug injectors") >= 0){
						outputText("\nYou can feel the chemicals pumped in by your gadgets resume working.\n");
						player.statStore.replaceBuffObject({'sens':15,'lib.mult':0.75},'DrugInjector',{text:'Potent Drug injectors'});
						needNext = true;
					}
				}
					else {
					if (player.hasKeyItem("Power bracer") >= 0) {
						outputText("\nYou can feel the chemicals pumped in by your gadgets resume working.\n");
						player.statStore.replaceBuffObject({'sens':5,'str.mult':0.50},'Power bracer',{text:'Power bracer'});
						needNext = true;
					}
					if (player.hasKeyItem("Powboy") >= 0) {
						outputText("\nYou can feel the chemicals pumped in by your gadgets resume working.\n");
						player.statStore.replaceBuffObject({'sens':10,'str.mult':0.75},'Power bracer',{text:'Powboy'});
						needNext = true;
					}
					if (player.hasKeyItem("M.G.S. bracer") >= 0) {
						outputText("\nYou can feel the chemicals pumped in by your gadgets resume working.\n");
						player.statStore.replaceBuffObject({'sens':15,'str.mult':1},'Power bracer',{text:'M.G.S. bracer'});
						needNext = true;
					}
				}
			}
			//Cow bell
			if (player.necklace == necklaces.COWBELL && player.isRaceCached(Races.COW) && !player.statStore.hasBuff('Cow bell')) player.statStore.replaceBuffObject({'str.mult':0.2, 'lib.mult':0.2}, 'Cow bell', { text: 'Cow bell' });
			if (!player.isRaceCached(Races.COW) && player.statStore.hasBuff('Cow bell')) player.statStore.removeBuffs('Cow bell');
			//Jiangshi cursed tag
			if (player.headJewelry == headjewelries.JIANGCT && player.isRaceCached(Races.JIANGSHI) && !player.statStore.hasBuff('Jiangshi Curse Tag')) player.statStore.replaceBuffObject({'str.mult':0.2,'tou.mult':0.2,'lib.mult':0.2,'sens':80}, 'Jiangshi Curse Tag', { text: 'Jiangshi Curse Tag' });
			//Hot Spring
			if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 1 && rand(4) == 0) {
				outputText("\nWhile wandering around the border of your camp, you randomly kick a rock and a stream of water sprays out. Surprised, you touch the water, discovering it to be startlingly hot. An idea comes to your mind. You get a shovel, digging around the fountaining water which soon turns into a small pool. This is the perfect place to build a hot spring. You smile, delighted at the idea of being able to take frequent baths in it! You resolve to get to work as soon as possible.");
				flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS]++;
				needNext = true;
			}
			//Marae corrupted or killed + Zenji
			if (ZenjiScenes.isLover() && (flags[kFLAGS.MET_MARAE_CORRUPTED] >= 1 || flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) && !ZenjiScenes.ZenjiMarae) {
				outputText("\nZenji approaches you, \"<i>[name]. I.. I felt something, not long ago. Someting terrible has happened, I feel it deep within me.</i>\"");
				outputText("\n\nHe pulls you into his protective arms, \"<i>Stay close, [name], dis world just doesn’t feel right anymore.</i>\"");
				ZenjiScenes.ZenjiMarae = true;
				needNext = true;
			}
			//Tail Hunger
			if (player.tailType == Tail.MANTICORE_PUSSYTAIL && !player.hasPerk(PerkLib.ManticoreCumAddict)) {
				outputText("\nYou suddenly feel a desire to eat, or rather, drink. It's like you have been thirsty for months, yet the thirst does not originate from your throat. Your tail pussy is dying for a mans meat and you feel that as long as you don't sate it, you will only be getting hornier! Cum... You need cum, a lot of it. It’s obvious now why manticores are this crazy for sex as you feel the urge to pounce and feed on every single male in Mareth you can find!\n");
				flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] = 50;
				player.createPerk(PerkLib.ManticoreCumAddict, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.tailType != Tail.MANTICORE_PUSSYTAIL && player.hasPerk(PerkLib.ManticoreCumAddict)) {
				outputText("\nYou suddenly feel like your mind is clear of the constant haze of lust and hunger for the first time since you had that tail. Losing it was perhaps for the best.\n");
				player.removePerk(PerkLib.ManticoreCumAddict);
				needNext = true;
			}
			//Milk Hunger
			if (player.rearBody.type == RearBody.DISPLACER_TENTACLES && !player.hasPerk(PerkLib.DisplacerMilkAddict)) {
				outputText("\nYou suddenly feel a desire to eat, or rather, drink. It's like you have been thirsty for months, yet the thirst does not originate from your throat. Your tentacles are dying for milks and you feel that as long as you don't sate them, you will only be getting hornier! Milk... You need milk, a lot of it. It’s obvious now why displacer beasts are this crazy for sex as you feel the urge to pounce and feed on every single pair of breast in Mareth you can find!\n");
				flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] = 50;
				player.createPerk(PerkLib.DisplacerMilkAddict, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.rearBody.type != RearBody.DISPLACER_TENTACLES && player.hasPerk(PerkLib.DisplacerMilkAddict)) {
				outputText("\nYou suddenly feel like your mind is clear of the constant haze of lust and hunger for the first time since you had these tentacles. Losing them was perhaps for the best.\n");
				player.removePerk(PerkLib.DisplacerMilkAddict);
				needNext = true;
			}
			//Vampire Thirst
			if (player.faceType == Face.VAMPIRE && !player.hasStatusEffect(StatusEffects.VampireThirst)) {
				outputText("\nAn ominous thirst settle in your throat as you begin to hallucinate glasses of blood... how delicious it would feel on your palates. You realise you are salivating and do your best to control yourself. Still you now are clearly dependant on blood.\n");
				player.createStatusEffect(StatusEffects.VampireThirst, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.faceType != Face.VAMPIRE && player.hasStatusEffect(StatusEffects.VampireThirst) && !player.perkv1(IMutationsLib.HollowFangsIM) >= 1) {
				outputText("\nAs your fang disappear so do your vampiric urges. You become disgusted with yourself as you realise how much blood you drank.\n");
				player.removeStatusEffect(StatusEffects.VampireThirst);
				needNext = true;
			}
			//Loosing hellcat body parts
			if (player.isRaceCached(Races.HELLCAT) && flags[kFLAGS.WITCHES_SABBATH] > 1) {
				var hellcatparts:Number = 3;
				if (player.tailType != Tail.BURNING && player.tailType != Tail.TWINKASHA) hellcatparts -= 1;
				if (player.hairType != Hair.BURNING) hellcatparts -= 1;
				if (player.eyes.type != Eyes.INFERNAL) hellcatparts -= 1;
				if (hellcatparts < 3) {
					outputText("\nAs you become less of a hellcat your inner fire entirely dies down, your body reverting to that of a standard feline.\n");
					if (player.tailType == Tail.BURNING || player.tailType == Tail.TWINKASHA) player.tailType = Tail.CAT;
					if (player.hairType == Hair.BURNING) transformations.HairHuman.applyEffect(false);
					if (player.eyes.type == Eyes.INFERNAL) player.eyes.type = Eyes.CAT;
					if (flags[kFLAGS.WITCHES_SABBATH] > 1) flags[kFLAGS.WITCHES_SABBATH] = 1;
					needNext = true;
				}
			}
			//Reset bad end warning
			if (player.hasStatusEffect(StatusEffects.TFWarning)) {
				player.addStatusValue(StatusEffects.TFWarning, 3, -1);
				if (player.getStatusValue(StatusEffects.TFWarning, 3) <= 0) player.removeStatusEffect(StatusEffects.TFWarning);
			}
			//ABOBA
			if (flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] >= 100 && !player.hasPerk(PerkLib.BasiliskResistance)) {
				if (player.perkv1(IMutationsLib.GorgonEyesIM) >= 1) outputText("\nYou notice that you feel a bit stiff and your skin is a bit harder.  Something clicks in your mind as you finally unlock the potential to protect yourself from the goddamn basilisks! \n\n(<b>Gained Perk: Basilisk Resistance - You are now immune to the basilisk's gaze!</b>)\n");
				else outputText("\nYou notice that you feel a bit stiff and your skin is a bit harder.  Something clicks in your mind as you finally unlock the potential to protect yourself from the goddamn basilisks! \n\n(<b>Gained Perk: Basilisk Resistance - Your maximum speed is permanently decreased but you are now immune to the basilisk's gaze!</b>)\n");
				player.createPerk(PerkLib.BasiliskResistance, 0, 0, 0, 0);
				needNext = true;
			}
			if (flags[kFLAGS.TIMES_TRANSFORMED] >= 25 && !player.hasPerk(PerkLib.GeneticMemory)) {
				outputText("\nYour body behave weirdly as if all the transformation, which you have undergone started to make it unsure about what it truly is. Sometime you even try to move limbs that are no longer there. Suddenly you realise that no mather how many time you change your body remembers it. Your body developed genetic memory! \n\n(<b>Gained Perk: Genetic Memory</b>)\n");
				player.createPerk(PerkLib.GeneticMemory, 0, 0, 0, 0);
				needNext = true;
			}
			if (flags[kFLAGS.TIMES_TRANSFORMED] >= 100 && !player.hasPerk(PerkLib.TransformationResistance)) {
				outputText("\nYou feel a strange tingling sensation. It seems as if you've finally adapted to the transformative properties of the food in Mareth and your body has finally built up enough resistance! You suspect that you can still transform but at somewhat diminished rate. \n\n(<b>Gained Perk: Transformation Resistance - Transformative items now have less chance to transform you. In addition, any Bad Ends related to overdose of certain transformative items are now disabled.</b>)\n");
				player.createPerk(PerkLib.TransformationResistance, 0, 0, 0, 0);
				needNext = true;
			}
			if (flags[kFLAGS.TIMES_TRANSFORMED] >= 200 && !player.hasPerk(PerkLib.TransformationAcclimation)) {
				outputText("\nDue to you're continued consumption of transformative items, you have discovered a way to draw out more of the transformative properties of the food in Mareth. \n\n(<b>Gained Perk: Transformation Acclimation - Transformative items now have double the chance to transform you.</b>)\n");
				player.createPerk(PerkLib.TransformationAcclimation, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.perkv4(PerkLib.EnlightenedNinetails) == 0 && (player.tailType != Tail.FOX || player.tailCount < 9)) { //Check ninetails perks!
				outputText("\n<b>Without your tails, the magic power they once granted withers and dies, vanishing completely.</b>\n");
				player.removePerk(PerkLib.EnlightenedNinetails);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.CorruptedNinetails) && player.perkv4(PerkLib.CorruptedNinetails) == 0 && (player.tailType != Tail.FOX || player.tailCount < 9)) { //Check ninetails perks!
				outputText("\n<b>Without your tails, the magic power they once granted withers and dies, vanishing completely.</b>\n");
				player.removePerk(PerkLib.CorruptedNinetails);
				needNext = true;
			}
			if (!player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.hasPerk(PerkLib.EnlightenedNinetails) && player.perkv4(PerkLib.EnlightenedNinetails) > 0 && player.hasPerk(PerkLib.CorruptedNinetails) && player.perkv4(PerkLib.CorruptedNinetails) > 0 && player.tailType == Tail.FOX && player.tailCount == 9) {
				outputText("\n<b>With your nine tails you suddenly feel something beyond merely two paths of corruption and true enlightenment. A third way, the way of treading a fragile path of balance between other two paths. \n\n(Gained Perk: Nine-tails Kitsune of Balance)</b>\n");
				player.createPerk(PerkLib.NinetailsKitsuneOfBalance, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) == 0 && (player.tailType != Tail.FOX || player.tailCount < 9)) {
				outputText("\n<b>Without your tails, the balance is disturbed and you lose your insights into the third path.</b>\n");
				player.removePerk(PerkLib.NinetailsKitsuneOfBalance);
				needNext = true;
			}

			//Turn to Bicorn
			var CurentColor:String;
			if ((player.horns.type == Horns.BICORN || player.horns.type == Horns.UNICORN) && player.cor > 89 && !player.hasPerk(PerkLib.AvatorOfCorruption)) {
				outputText("\nA sudden wave of pleasure strike you, making you moan");
				if (player.horns.type == Horns.UNICORN) {
					outputText(" as your horn begins to split in two");
					transformations.HornsBicorn.applyEffect(false);
				}
				outputText(".");
				if (!InCollection(player.hairColor, UnicornRace.BicornHairColors)) {
					CurentColor = randomChoice(UnicornRace.BicornHairColors);
					outputText(" You feel a tingling in your hairs as the strands turns "+CurentColor+".");
					player.hairColor = CurentColor;
				}
				if (!InCollection(player.furColor, UnicornRace.BicornFurColors)) {
					CurentColor = randomChoice(UnicornRace.BicornFurColors);
					outputText(" Your fur tingles and you coo in delight as it turns "+CurentColor+".");
					player.furColor = CurentColor;
				}
				if (CoC.instance.transformations.EyesChangeColor(["red"]).isPossible()) {
					outputText(" Meanwhile your eyes shine with malice as they take on a red corrupted tone reflecting the sorry state of your soul.");
					player.eyes.colour = "red";
				}
				if (player.wings.type == Wings.FEATHERED_ALICORN) {
					CoC.instance.transformations.WingsNightmare.applyEffect();
				}
				outputText("\n\n<b>You giggle in delight of your own corruption as you fall from grace into a ");
				if (player.wings.type == Wings.NIGHTMARE) outputText("nightmare");
				else outputText("bicorn");
				outputText(". Mighty magical power start to swell in the twin horns on your forehead, washing away what's left of any purity you may have, and you will gladly use them to despoil and tarnish anything pure or innocent left on Mareth.</b>\n");

				if (player.hasPerk(PerkLib.AvatorOfPurity)) player.removePerk(PerkLib.AvatorOfPurity);
				player.createPerk(PerkLib.AvatorOfCorruption, 0, 0, 0, 0);
				player.createPerk(PerkLib.AuraOfCorruption, 0, 0, 0, 0);
				if(player.hasPerk(PerkLib.AuraOfPurity)) player.removePerk(PerkLib.AuraOfPurity);
				player.cor = 100;

				// TFs from scene for possible Metamorph unlock texts afterwards
				if (player.horns.type == Horns.UNICORN) {
					CoC.instance.transformations.HornsBicorn.applyEffect(false);
				}
				if (player.wings.type == Wings.FEATHERED_ALICORN) {
					CoC.instance.transformations.WingsNightmare.applyEffect(false);
				}
				CoC.instance.transformations.EyesChangeColor(["red"]).applyEffect(false);
				needNext = true;
			}
			//Fixing wings
			if (player.horns.type == Horns.BICORN && player.wings.type == Wings.FEATHERED_ALICORN) {
				CoC.instance.transformations.WingsNightmare.applyEffect();
				needNext = true;
			}
			//Losing horn
			if (player.hasPerk(PerkLib.AvatorOfCorruption) && player.cor > 10 && player.horns.type != Horns.BICORN) {
				outputText("\n\n<b>Without your horns, the magic power they once granted withers and dies, vanishing completely.</b>\n");
				if (!player.perkv1(IMutationsLib.EclipticMindIM) >= 1) player.removePerk(PerkLib.AuraOfCorruption);
				player.removePerk(PerkLib.AvatorOfCorruption);
				needNext = true;
			}

			//Turn to unicorn
			var unicornColorPalette:Array = ["white", "pure white"];
			var unicornHairPalette:Array = ["platinum blonde","silver", "white", "pure white"];
			if ((player.horns.type == Horns.BICORN || player.horns.type == Horns.UNICORN) && player.cor < 11 && !player.hasPerk(PerkLib.AvatorOfPurity)) {
				outputText("\nA sudden wave of serenity pass over you as you realise how pure you have become.");
				if (player.horns.type == Horns.BICORN) {
					outputText(" Your two horns merges into a single one and you can feel the pure unity of your horn restored.");
					player.horns.type = Horns.UNICORN;
				}
				if (!InCollection(player.hairColor, unicornHairPalette)) {
					CurentColor = randomChoice(unicornHairPalette);
					outputText(" You feel a tingling in your hairs as the strands turns "+CurentColor+".");
					player.hairColor = CurentColor;
				}
				if (!InCollection(player.furColor, unicornColorPalette)) {
					CurentColor = randomChoice(unicornColorPalette);
					outputText(" You sigh in relief as your fur turns "+CurentColor+".");
					player.furColor = CurentColor;
				}
				if (CoC.instance.transformations.EyesChangeColor(["blue"]).isPossible()) {
					outputText(" Meanwhile your irises shift toward the sapphire blue as your mind clears off.");
					player.eyes.colour = "blue";
				}
				if (player.wings.type == Wings.NIGHTMARE) {
					outputText(" Your wings also redeem themselves changing into a pair of angelic wings covered with white feathers.");
					player.wings.type = Wings.FEATHERED_ALICORN;
				}
				outputText("\n\n<b>You laugh heartily at your unblemish pure form as you realise you are an ");
				if (player.wings.type == Wings.FEATHERED_ALICORN) outputText("alicorn");
				else outputText("unicorn");
				outputText(" now. Mighty magical power start to swell in the horn on your forehead, cleansing whats left of any corruption you may have, and you will gladly use them to fight off the corruption that plagues mareth.</b>\n");
				if (player.hasPerk(PerkLib.AvatorOfCorruption)) player.removePerk(PerkLib.AvatorOfCorruption);
				player.createPerk(PerkLib.AvatorOfPurity, 0, 0, 0, 0);
				player.createPerk(PerkLib.AuraOfPurity, 0, 0, 0, 0);
				if(player.hasPerk(PerkLib.AuraOfCorruption)) player.removePerk(PerkLib.AuraOfCorruption);
				player.cor = 0;

				// TFs from scene for possible Metamorph unlock texts afterwards
				if (player.horns.type == Horns.BICORN) {
					CoC.instance.transformations.HornsUnicorn.applyEffect(false);
				}
				if (player.wings.type == Wings.NIGHTMARE) {
					CoC.instance.transformations.WingsFeatheredAlicorn.applyEffect(false);
				}
				CoC.instance.transformations.EyesChangeColor(["blue"]).applyEffect(false);
				needNext = true;
			}
			if (player.horns.type == Horns.UNICORN && player.wings.type == Wings.NIGHTMARE) {
				outputText("\nYour wings redeem themselves changing into a pair of angelic wings covered with white feathers.");
				player.wings.type = Wings.FEATHERED_ALICORN;
				CoC.instance.transformations.WingsFeatheredAlicorn.applyEffect(false);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.AvatorOfPurity) && player.cor < 90 && player.horns.type != Horns.UNICORN) {
				outputText("\n<b>Without your horn, the magic power it once granted withers and dies, vanishing completely.</b>\n");
				if (!player.perkv1(IMutationsLib.EclipticMindIM) >= 1) player.removePerk(PerkLib.AuraOfPurity);
				player.removePerk(PerkLib.AvatorOfPurity);
				needNext = true;
			}
			//Switch Aura Based On Alignment
			if ((player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN) && player.cor > 89 && player.perkv1(IMutationsLib.EclipticMindIM) >= 1 && player.hasPerk(PerkLib.AuraOfPurity)) {
				outputText("\nA dramatic change in your alignment has altered your formerly pure aura into one of corruption\n");
				player.removePerk(PerkLib.AuraOfPurity);
				player.createPerk(PerkLib.AuraOfCorruption, 0, 0, 0, 0);
				needNext = true;
			}
			if ((player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN) && player.cor < 20 && player.perkv1(IMutationsLib.EclipticMindIM) >= 1 && player.hasPerk(PerkLib.AuraOfCorruption)) {
				outputText("\nA dramatic change in your alignment has altered your formerly corrupt aura into one of purity\n");
				player.removePerk(PerkLib.AuraOfCorruption);
				player.createPerk(PerkLib.AuraOfPurity, 0, 0, 0, 0);
				needNext = true;
			}
			//Remove Bullshit
			if ((player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN) && (player.hasPerk(PerkLib.AuraOfPurity) || player.hasPerk(PerkLib.AuraOfCorruption)) && !player.perkv1(IMutationsLib.EclipticMindIM) >= 1) {
				outputText("\nNo idea how you got this weird aura about you but whatever the reason why you had it its gone now.\n");
				player.removePerk(PerkLib.AuraOfPurity);
				player.removePerk(PerkLib.AuraOfCorruption);
				needNext = true;
			}
			//Gain venomancy if utherly toxic
			if ((player.isRaceCached(Races.APOPHIS)) && player.cor > 50 && !player.hasPerk(PerkLib.Venomancy)) {
				outputText("\nYour inborn toxicity has reached such a peak that even your spells are now charged with venom. \n\n(<b>Gained Perk: Venomancy</b>)\"");
				player.createPerk(PerkLib.Venomancy, 0, 0, 0, 0);
				needNext = true;
			}
			//Lose venomancy if not toxic
			if (!player.isRaceCached(Races.APOPHIS) && player.cor < 89 && player.hasPerk(PerkLib.Venomancy)) {
				outputText("\nYour mystical powers over poison and toxins have waned. \n\n(<b>Lost Perk: Venomancy</b>)\"");
				player.removePerk(PerkLib.Venomancy);
				needNext = true;
			}
			//Harpy
			if (LowerBody.canLayEggs(player) && player.hasPerk(PerkLib.HarpyWomb)) { //Make eggs big if harpied!
				if (player.hasStatusEffect(StatusEffects.Eggs) && player.statusEffectv2(StatusEffects.Eggs) == 0) {
					player.changeStatusValue(StatusEffects.Eggs, 2, 1);
					outputText("\n<b>A familiar, motherly rumble lets you know that your harpy-like womb is growing your eggs nice and large.</b>\n");
					needNext = true;
				}
			}
			//Pregomania
			if(player.isPregnant() && (player.isHarpy() || player.isGoblinoid() || player.isAlraune()) && !player.statStore.hasBuff("Pregomania")){
				player.statStore.removeBuffs("Impregnate me!!!");
				player.statStore.addBuffObject({"tou.mult":0.20,"lib.mult":0.20}, "Pregomania",{text:"Your motherly instincs gives you increased resiliance and resolve."});
				outputText("\nYou pat your belly in motherly delight instinctively knowing that you have been impregnated. Your body seldom radiates motherly wellbeing making you hardyer in order to protect your beloved children to be.\n");
			}
			if(!player.isPregnant() && (player.isHarpy() || player.isGoblinoid() || player.isAlraune()) && player.statStore.hasBuff("Pregomania")){
				player.statStore.removeBuffs("Pregomania");
				outputText("\nNo longer pregnant, you feel a void in your belly as the need to be impregnated again claw at your mind.\n");
				player.statStore.addBuffObject({"lib.mult":0.50}, "Impregnate me!!!",{text:"You strongly desire to be impregnated."});

			}
			if(SophieFollowerScene.HarpyKids >= 21 && !player.hasPerk(PerkLib.HarpyQueen)){
				outputText("\nOverflowing with motherly pride you count your many grown daughters. There's more than twenty of them roosting all around your camp now." +
						" This is proof of your hard work as a mother as are your wide motherly hips a testament to the many eggs you've hatched." +
						" You are no longer a mere harpy now but a harpy queen in your own right living with her own flock of loyal daughters.\n");
				player.createPerk(PerkLib.HarpyQueen,0,0,0,0);
			}
			if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE) { //All the hourly bee cock checks except the 'seek out the bee girl' check. That's in timeChangeLarge
				if (player.cocks.length > 1) {
					outputText("\nYou feel a stickiness and some stinging from your cocks.  It seems your bee cock has absorbed your new addition, leaving no trace of it.\n");
					while (player.cocks.length > 1) player.removeCock(1, 1);
				}
				if (player.cocks[0].cockLength < 25 || player.cocks[0].cockThickness < 4) {
					outputText("\nYour [cock] quivers for a moment before growing slightly ");
					if (player.cocks[0].cockLength < 25 && player.cocks[0].cockThickness < 4)
						outputText("longer and thicker");
					else outputText(player.cocks[0].cockLength < 25 ? "longer again" : "wider again");
					outputText(", a bit of pain passing through you at the same time.  It looks like your bee cock won’t get any smaller.\n");
					player.cocks[0].cockLength = Math.max(player.cocks[0].cockLength, 25);
					player.cocks[0].cockThickness = Math.max(player.cocks[0].cockThickness, 4);
				}
				if (player.hasPerk(PerkLib.WellAdjusted)) dynStats("lust", 5); //Reduced to 5 with 'Well Adjusted' perk.
				else dynStats("lust", 10); //Always gain 10 lust each hour
				needNext = true;
			}
			if (!player.hasVagina() && player.hasPerk(PerkLib.Diapause)) { //Lose diapause
				outputText("\n<b>With the loss of your womb, you lose your kangaroo-like diapause ability.</b>\n");
				player.removePerk(PerkLib.Diapause);
				needNext = true;
			}
			//tail absorb section
			if (player.lowerBody == LowerBody.NAGA) {
				if (player.tailType > Tail.NONE) {
					outputText("\nYour tail squirms, wriggling against your larger naga tail as the scales part around it, absorbing it.  <b>Your form is completely scaly and smooth from the waist down.</b>\n");
					player.tailType = Tail.NONE;
					needNext = true;
				}
			}
			if (player.lowerBody == LowerBody.MELKIE) {
				if (player.tailType > Tail.NONE) {
					outputText("\nYour tail squirms, wriggling against your larger melkie tail as the fur part around it, absorbing it.  <b>Your form is completely furry and smooth from the waist down.</b>\n");
					player.tailType = Tail.NONE;
					needNext = true;
				}
			}
			if (player.hasPerk(PerkLib.WetPussy) && player.hasVagina()) {
				if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_WET) {
					outputText("\n<b>Your " + player.vaginaDescript(0) + " returns to its normal, wet state.</b>\n");
					player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_WET;
					needNext = true;
				}
			}
			if (player.hasPerk(PerkLib.MaraesGiftButtslut) && player.ass.analWetness < 2) { //Prevent Buttsluts from getting dry backdoors
				outputText("\n<b>Your " + Appearance.assholeDescript(player) + " quickly re-moistens.  It looks like Marae's 'gift' can't be removed.</b>\n");
				player.ass.analWetness = 2;
				needNext = true;
			}
			if (!Holidays.isHalloween() && ZenjiScenes.isLover() && player.statusEffectv4(StatusEffects.ZenjiZList) == 2 && rand(5) < 2) {
				SceneLib.zenjiScene.loverZenjiHalloweenEventEnding();
				needNext = true;
			}
			if (player.pregnancyIncubation <= 0 && player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) { //Fixing Egg Preg Preglocked Glitch
				player.knockUpForce(); //Clear Pregnancy
			}
			if (player.hasStatusEffect(StatusEffects.Uniball) && player.ballSize > 1 && player.hasBalls()) { //Testicles Normalise:
				outputText("\nYou feel a deep sensation of release around your genitals.  You sigh with relief and contentment as your testicles drop downwards and bloom outwards, heat throbbing within them as they split and form a proper ballsack.\n");
				player.removeStatusEffect(StatusEffects.Uniball);
				needNext = true;
			}
			var textHolder:String;
			textHolder = player.fixFemininity();
			if (textHolder != "") {
				outputText(textHolder);
				needNext = true;
			}
			if (player.hasStatusEffect(StatusEffects.LustStickApplied)) { //Lust stick!
				player.addStatusValue(StatusEffects.LustStickApplied, 1, -1); //Decrement!
				if (player.statusEffectv1(StatusEffects.LustStickApplied) <= 0) {
					player.removeStatusEffect(StatusEffects.LustStickApplied);
					outputText("<b>\nYour drugged lipstick fades away, leaving only the faintest residue on your lips.  You'll have to put on more if you want to be able to kiss your foes into submission!</b>\n");
				}
			}
			if (player.hasStatusEffect(StatusEffects.Luststick)) { //Luststic countdown
				player.addStatusValue(StatusEffects.Luststick, 1, -1);
				if (rand(2) == 0 && player.hasCock()) { //50% chance to lust spike
					//Display if haven't displayed
					if (player.flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED] == 0) {
						outputText("\nYour body tingles, practically a slave to the effects of harpy lipstick.  Blood surges to [eachcock], making you groan out loud with forced pleasure.  Unasked-for fantasies assault you, and you spend a few moments fantasizing about fucking feathery women before you come to your senses.\n");
						flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED]++;
						needNext = true;
					}
					player.dynStats("lus", 20, "scale", false);
					if (player.lust > player.maxOverLust()) player.lust = player.maxOverLust();
				}
				if (player.statusEffectv1(StatusEffects.Luststick) <= 0) {
					player.removeStatusEffect(StatusEffects.Luststick);
					dynStats("lib=", flags[kFLAGS.LUSTSTICK_LIBIDO_INITIAL]);
					outputText("\n<b>The lust-increasing effects of harpy lipstick have worn off!\n</b>");
					needNext = true;
				}
			}
			if (player.flags[kFLAGS.LUSTSTICK_RESISTANCE] >= 50 && !player.hasPerk(PerkLib.LuststickAdapted)) { //Luststick resistance unlock
                SceneLib.sophieBimbo.unlockResistance();
                if (player.hasStatusEffect(StatusEffects.Luststick)) player.removeStatusEffect(StatusEffects.Luststick);
				needNext = true;
			}
			if (flags[kFLAGS.DICK_EGG_INCUBATION] > 0) {
				flags[kFLAGS.DICK_EGG_INCUBATION]--;
				trace("DICK BIRTH TIMER: " + flags[kFLAGS.DICK_EGG_INCUBATION]);
				if (flags[kFLAGS.DICK_EGG_INCUBATION] == 1) {
                    SceneLib.masturbation.birthBeeEggsOutYourWang();
                    needNext = true;
				}
			}
			if (player.hasStatusEffect(StatusEffects.ArousalPotion)) {
				player.addStatusValue(StatusEffects.ArousalPotion, 2, -1);
				if (player.statusEffectv2(StatusEffects.ArousalPotion) <= 0) {
					outputText("\n<b>Alraune perfume effect expired.</b>");
					player.removeStatusEffect(StatusEffects.ArousalPotion);
					needNext = true;
				}
			}
			if (player.hasStatusEffect(StatusEffects.Eggchest)) { //Eggs in tits!
				player.addStatusValue(StatusEffects.Eggchest, 1, -1);
				if (player.statusEffectv1(StatusEffects.Eggchest) <= 0) {
					outputText("\n<b>You feel the rounded eggs within your [fullChest] vanishing, absorbed into your body.  </b>");
					player.growTits(player.statusEffectv2(StatusEffects.Eggchest), player.bRows(), true, 2);
					outputText("\n");
					player.removeStatusEffect(StatusEffects.Eggchest);
					needNext = true;
				}
			}
			if (player.hasPerk(PerkLib.SpiderOvipositor) || (player.hasPerk(PerkLib.BeeOvipositor) && !player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) || player.hasPerk(PerkLib.MantisOvipositor) || player.hasPerk(PerkLib.AntOvipositor)) { //Spider, Bee and, Mantis and Ant ovipositor updates
				if (transformations.RemoveOvipositor.isPossible()) { //Remove dat shit!
						transformations.RemoveOvipositor.applyEffect();
				}
				else { //Update stuff!
					var prevEggs:int = player.eggs();
					if (prevEggs < 10) {
						player.addEggs(2);
					}
                    else if (prevEggs < 20 && CoC.instance.model.time.hours % 2 == 0) {
                        player.addEggs(1);
					}
                    else if (CoC.instance.model.time.hours % 4 == 0) {
                        player.addEggs(1);
					}
					if (prevEggs < 10 && player.eggs() >= 10) { //Stage 1 egg message
						if (player.hasPerk(PerkLib.SpiderOvipositor)) {
							outputText("\nYou feel a certain fullness building in your spider-half's abdomen.");
						}
						else {
							outputText("\nYou feel a certain fullness building in your insectile abdomen.  You have some eggs ready... and you feel a strange urge to have them fertilized.");
							if (!player.hasVagina()) outputText("  Wait, how would you even go about that?");
						}
						outputText("  <b>You have enough eggs to lay!</b>\n");
						needNext = true;
					}
					else if (prevEggs < 20 && player.eggs() >= 20) { //Stage 2 egg message
						if (player.hasPerk(PerkLib.SpiderOvipositor)) {
							outputText("\nYour spider body feels like it's stretched taut, and a heavy warmth has spread throughout it.  The sensation of eggs piling up inside you is enough to drive you to distraction.  It would be a good idea to find somewhere to deposit them - but, oh, how great it would feel to get them fertilized by a nice hard cock first!");
							if (!player.hasVagina()) outputText("  Wait, that's not right...");
						}
						else {
							outputText("\nYour abdomen feels like it's stretched taut, and a heavy warmth has spread throughout it.  It swings pendulously with every movement you make, and the sensation of eggs piling up inside you is enough to drive you to distraction.");
						}
						outputText("\n\n<b>Minimum Lust raised!</b>\n");
						needNext = true;
					}
					else if (prevEggs < 40 && player.eggs() >= 40) { //Stage 3 egg message
						if (player.hasPerk(PerkLib.SpiderOvipositor)) {
							outputText("\nYour lower half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...");
						}
						else if (player.hasPerk(PerkLib.MantisOvipositor)) {
							outputText("\nYour mantis half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its sweet, slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...");
						}
						else if (player.hasPerk(PerkLib.AntOvipositor)) {
							outputText("\nYour ant half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...");
						}
						else {
							outputText("\nYour bee half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its sweet, slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...");
						}
						outputText("\n\n<b>Minimum Lust raised!</b>\n");
						player.addCurse("spe", 1, 1);
						needNext = true;
					}
				}
			}
			if (player.hasPerk(PerkLib.Oviposition) || player.hasPerk(PerkLib.BunnyEggs)) { //Oviposition perk for lizard and bunny folks
				if ((player.racialScore(Races.NAGA) + player.racialScore(Races.LIZARD) < 3) && player.hasPerk(PerkLib.Oviposition) && !player.hasPerk(PerkLib.BasiliskWomb)) { //--Lose Oviposition perk if lizard score gets below 3.
					outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost a little bit of reptilian reproductive ability.\n(<b>Perk Lost: Oviposition</b>)\n");
					player.removePerk(PerkLib.Oviposition);
					needNext = true;
				}
				else if (player.racialScore(Races.BUNNY) < 3 && player.hasPerk(PerkLib.BunnyEggs)) { //--Lose Oviposition perk if bunny score gets below 3.
					outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost your ability to spontaneously lay eggs.\n(<b>Perk Lost: Bunny Eggs</b>)\n");
					player.removePerk(PerkLib.BunnyEggs);
					needNext = true;
				}
                else if (player.pregnancyIncubation < 1 && player.hasVagina() && CoC.instance.model.time.hours == 1) { //Otherwise pregger check, once every morning
                    if ((player.totalFertility() > 50 && CoC.instance.model.time.days % 15 == 0) || CoC.instance.model.time.days % 30 == 0) { //every 15 days if high fertility get egg preg
                        outputText("\n<b>Somehow you know that eggs have begun to form inside you. You wonder how long it will be before they start to show?</b>\n");
						player.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS, 1, 1);
						player.createStatusEffect(StatusEffects.Eggs, rand(6), rand(2), (5 + rand(3)), 0); //v1 is type, v2 is size (1 == large) and v3 is quantity
						player.addPerkValue(PerkLib.Oviposition, 1, 1); //Count times eggpregged this way in perk.
						needNext = true;
					}
				}
			}
			if (player.inHeat) { //Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
				if (player.statusEffectv3(StatusEffects.Heat) <= 1 || player.vaginas.length == 0) { //Remove bonus libido from heat
					player.removeStatusEffect(StatusEffects.Heat); //remove heat
					EngineCore.statScreenRefresh();
					outputText("\n<b>Your body calms down, at last getting over your heat.</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.Heat, 3, -1);
			}

			if (player.inRut) { //Rut v1 is bonus cum, v2 is bonus libido, v3 is hours till it's gone
				trace("RUT:" + player.statusEffectv3(StatusEffects.Rut));
				if (player.statusEffectv3(StatusEffects.Rut) <= 1 || player.cockTotal() == 0) { //Remove bonus libido from rut
					player.removeStatusEffect(StatusEffects.Rut); //remove heat
                    EngineCore.statScreenRefresh();
					outputText("\n<b>Your body calms down, at last getting over your rut.</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.Rut, 3, -1);
			}
			if (player.statusEffectv1(StatusEffects.BathedInHotSpring) >= 1) {
				if (player.statusEffectv1(StatusEffects.BathedInHotSpring) == 1) {
					player.removeStatusEffect(StatusEffects.BathedInHotSpring);
					outputText("\n<b>Effect of Hot Spring bath wears off.</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.BathedInHotSpring, 1, -1);
			}
			if (player.statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff1) >= 1) {
				if (player.statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff1) == 1) {
					player.buff("ShiraOfTheEastFoodBuff").remove();
					player.removeStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1);
					outputText("\n<b>Effect of eating in 'Shira of the east' restaurant wears off.</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.ShiraOfTheEastFoodBuff1, 1, -1);
			}
			if (player.statusEffectv1(StatusEffects.RaijuLightningStatus) >= 1) {
				if (player.statusEffectv1(StatusEffects.RaijuLightningStatus) == 1) {
					player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
					outputText("\n<b>Effect of Raiju Lightning wears off.</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.RaijuLightningStatus, 1, -1);
			}
			if (player.statusEffectv1(StatusEffects.SoulGemCrafting) >= 1) player.addStatusValue(StatusEffects.SoulGemCrafting, 1, -1);
			if (player.hasStatusEffect(StatusEffects.LustyTongue)) { //Lusty Tongue Check!
				if (rand(5) == 0) {
					outputText("\nYou keep licking your lips, blushing with the sexual pleasure it brings you.");
					player.dynStats("lus", 2 + rand(15), "scale", false);
					if (player.lust >= player.maxOverLust()) {
						outputText("  Your knees lock from the pleasure, and you fall back in pleasure, twisting and moaning like a whore as you somehow orgasm from your mouth.  When it finishes, you realize your mouth feels even more sensitive than before.");
						player.orgasm();
						player.dynStats("sen", 2);
						player.changeStatusValue(StatusEffects.LustyTongue, 1, player.statusEffectv1(StatusEffects.LustyTongue) + 10); //Tongue orgasming makes it last longer.

					}
					outputText("\n");
					needNext = true;
				}
				player.changeStatusValue(StatusEffects.LustyTongue, 1, player.statusEffectv1(StatusEffects.LustyTongue) - 1); //Decrement
				if (player.statusEffectv1(StatusEffects.LustyTongue) <= 0) {
					player.removeStatusEffect(StatusEffects.LustyTongue);
					outputText("\nYour mouth and tongue return to normal.\n");
					needNext = true;
				}
			}
			if (player.hasStatusEffect(StatusEffects.Bammed1)) {
				if (player.statusEffectv3(StatusEffects.Bammed1) > 0 && (player.statusEffectv1(StatusEffects.Bammed1) == 1 || player.statusEffectv1(StatusEffects.Bammed1) == 2)) {
					player.addStatusValue(StatusEffects.Bammed1, 3, -1);
					if (player.statusEffectv3(StatusEffects.Bammed1) <= 0) {
						if (player.statusEffectv4(StatusEffects.Bammed1) <= 0 && player.statusEffectv2(StatusEffects.Bammed1) < 3) player.removeStatusEffect(StatusEffects.Bammed1);
						outputText("\n<b>Your ability to use melee attacks was restored after Bam effect on it expired!</b>\n");
						needNext = true;
					}
				}
				if (player.statusEffectv4(StatusEffects.Bammed1) > 0 && (player.statusEffectv2(StatusEffects.Bammed1) == 1 || player.statusEffectv2(StatusEffects.Bammed1) == 2)) {
					player.addStatusValue(StatusEffects.Bammed1, 4, -1);
					if (player.statusEffectv4(StatusEffects.Bammed1) <= 0) {
						if (player.statusEffectv3(StatusEffects.Bammed1) <= 0 && player.statusEffectv1(StatusEffects.Bammed1) < 3) player.removeStatusEffect(StatusEffects.Bammed1);
						outputText("\n<b>Your ability to use range attacks was restored after Bam effect on it expired!</b>\n");
						needNext = true;
					}
				}
			}
			if (player.hasStatusEffect(StatusEffects.Bammed2)) {
				if (player.statusEffectv3(StatusEffects.Bammed2) > 0 && (player.statusEffectv1(StatusEffects.Bammed2) == 1 || player.statusEffectv1(StatusEffects.Bammed2) == 2)) {
					player.addStatusValue(StatusEffects.Bammed2, 3, -1);
					if (player.statusEffectv3(StatusEffects.Bammed2) <= 0) {
						if (player.statusEffectv4(StatusEffects.Bammed2) <= 0 && player.statusEffectv2(StatusEffects.Bammed2) < 3) player.removeStatusEffect(StatusEffects.Bammed2);
						outputText("\n<b>Your ability to use physical specials was restored after Bam effect on it expired!</b>\n");
						needNext = true;
					}
				}
				if (player.statusEffectv4(StatusEffects.Bammed2) > 0 && (player.statusEffectv2(StatusEffects.Bammed2) == 1 || player.statusEffectv2(StatusEffects.Bammed2) == 2)) {
					player.addStatusValue(StatusEffects.Bammed2, 4, -1);
					if (player.statusEffectv4(StatusEffects.Bammed2) <= 0) {
						if (player.statusEffectv3(StatusEffects.Bammed2) <= 0 && player.statusEffectv1(StatusEffects.Bammed2) < 3) player.removeStatusEffect(StatusEffects.Bammed2);
						outputText("\n<b>Your ability to use magical specials was restored after Bam effect on it expired!</b>\n");
						needNext = true;
					}
				}
			}
			if (player.statusEffectv2(StatusEffects.Kelt) > 0) player.addStatusValue(StatusEffects.Kelt, 2, -0.15); //Reduce kelt submissiveness by 1 every 5 hours
			//Mino cum update.
            if (SceneLib.mountain.minotaurScene.minoCumUpdate()) {
                needNext = true;
			}
            else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 2 && CoC.instance.model.time.hours % 13 == 0 && flags[kFLAGS.MINOCUM_WARNING_COOLDOWN] == 0) { //Repeated warnings!
                if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2)
					outputText("\n<b>You shiver, feeling a little cold. Maybe you ought to get some more minotaur cum? You just don't feel right without that pleasant buzz in the back of your mind.</b>\n");
				else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3)
					outputText("\n<b>The steady fire of lust within you burns hot, making you shiver and grab at your head. You're STILL in withdrawal after having gone so long without a dose of minotaur love.  You just know you're going to be horny and achy until you get some.</b>\n");
				needNext = true;
			}
			//Decrement mino withdrawal symptoms display cooldown
			//flags[kFLAGS.MINOCUM_WARNING_COOLDOWN] prevents PC getting two of the same notices overnite
			else if (flags[kFLAGS.MINOCUM_WARNING_COOLDOWN] > 0) flags[kFLAGS.MINOCUM_WARNING_COOLDOWN]--;
			if (player.statusEffectv1(StatusEffects.Airweed) >= 1) {
				if (player.statusEffectv1(StatusEffects.Airweed) == 1) {
					player.removeStatusEffect(StatusEffects.Airweed);
					outputText("\n<b>Effect of Airweed wears off.</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.Airweed, 1, -1);
			}
			//Konstantin buffs to equipment
			if (player.hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				if (player.statusEffectv1(StatusEffects.KonstantinArmorPolishing) <= 0) player.removeStatusEffect(StatusEffects.KonstantinArmorPolishing);
				else player.addStatusValue(StatusEffects.KonstantinArmorPolishing, 1, -1);
			}
			if (player.hasStatusEffect(StatusEffects.KonstantinWeaponSharpening)) {
				if (player.statusEffectv1(StatusEffects.KonstantinWeaponSharpening) <= 0) player.removeStatusEffect(StatusEffects.KonstantinWeaponSharpening);
				else player.addStatusValue(StatusEffects.KonstantinWeaponSharpening, 1, -1);
			}
			if (player.hasStatusEffect(StatusEffects.AlchemicalThunderBuff)) player.removeStatusEffect(StatusEffects.AlchemicalThunderBuff);
			if (player.hasPerk(PerkLib.FutaForm)) { //Futa checks
				if (!player.hasCock()) { //(Dick regrowth)
					player.createCock(10, 2.75);
					outputText("\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, 10-inch cock pulses happily.");
					if (player.balls == 0) {
						outputText("  A pair of heavy balls drop into place below it, churning to produce cum.");
						transformations.BallsDuo.applyEffect(false);
						player.ballSize = 3;
					}
					player.dynStats("int", -1, "sen", 5, "lus", 15);
					outputText("</b>\n");
					needNext = true;
				}
				if (player.cocks[0].cockLength < 8) { //(Dick rebiggening)
					outputText("\n<b>As time passes, your cock engorges, flooding with blood and growing until it's at 8 inches long.  You really have no control over your dick.</b>\n");
					player.cocks[0].cockLength = 8;
					if (player.cocks[0].cockThickness < 2) player.cocks[0].cockThickness = 2;
					needNext = true;
				}
				if (player.balls == 0) { //(Balls regrowth)
					outputText("\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath [eachcock] grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>\n");
					transformations.BallsDuo.applyEffect(false);
					player.ballSize = 3;
					needNext = true;
				}
				if (player.breastRows[0].breastRating < 5) { //Tits!
					player.breastRows[0].breastRating = 5;
					if (player.hasPerk(PerkLib.FutaFaculties))
						outputText("\n<b>Your tits get nice and full again.  You'll have lots of fun now that your breasts are back to being big, swollen knockers!</b>\n");
					else outputText("\n<b>Your [breasts] have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n");
					player.dynStats("int", -1, "lus", 15);
					needNext = true;
				}
				if (!player.hasVagina()) { //Vagoo
					player.createVagina();
					if (player.hasPerk(PerkLib.FutaFaculties))
						outputText("\n<b>Your crotch is like, all itchy an' stuff.  Damn!  There's a wet little slit opening up, and it's all tingly!  It feels so good, why would you have ever gotten rid of it?</b>\n");
					else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your [legs] fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n");
					player.dynStats("int", -1, "sen", 10, "lus", 15);
					needNext = true;
				}
			}
			if (player.hasPerk(PerkLib.BimboBody) || player.hasStatusEffect(StatusEffects.BimboChampagne)) { //Bimbo checks
				if (player.breastRows[0].breastRating < 5) { //Tits!
					player.breastRows[0].breastRating = 5;
					if (player.hasPerk(PerkLib.BimboBrains) || player.hasStatusEffect(StatusEffects.BimboChampagne))
						outputText("\n<b>Your boobies like, get all big an' wobbly again!  You'll have lots of fun now that your tits are back to being big, yummy knockers!</b>\n");
					else outputText("\n<b>Your " + player.breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n");
					player.dynStats("int", -1, "lus", 15);
					needNext = true;
				}
				if (!player.hasVagina()) { //Vagoo
					player.createVagina();
					if (player.hasPerk(PerkLib.BimboBrains) || player.hasStatusEffect(StatusEffects.BimboChampagne))
						outputText("\n<b>Your crotch is like, all itchy an' stuff.  Omigawsh!  There's a wet little slit opening up, and it's all tingly!  It feels so good, maybe like, someone could put something inside there!</b>\n");
					else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your [legs] fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n");
					needNext = true;
				}
				if (player.hips.type < 12) {
					if (player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties))
						outputText("\nWhoah!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate on a tittering bimbo.  You giggle when you realize you can't walk any other way.  At least it makes you look, like, super sexy!\n");
					else outputText("\nOh, no!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate for a bimbo.  Once you realize that you can't walk any other way, you sigh heavily, your only consolation the fact that your widened hips can be used to tease more effectively.\n");
					player.addCurse("int", 1, 1);
					player.hips.type = 12;
					needNext = true;
				}
				if (player.butt.type < 12) {
					if (player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties))
						outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  You smile to yourself, imagining how much you wish you had a nice, plump, bimbo-butt again, your hands finding their way to the flesh on their own.  Like, how did they get down there?  You bite your lip when you realize how good your tush feels in your hands, particularly when it starts to get bigger.  Are butts supposed to do that?  Happy pink thoughts wash that concern away - it feels good, and you want a big, sexy butt!  The growth stops eventually, and you pout disconsolately when the lusty warmth's last lingering touches dissipate.  Still, you smile when you move and feel your new booty jiggling along behind you.  This will be fun!\n");
					else outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  Oh, no!  You thought that having a big, bloated bimbo-butt was a thing of the past, but with how it's tingling under your groping fingertips, you have no doubt that you're about to see the second coming of your sexy ass.  Wait, how did your fingers get down there?  You pull your hands away somewhat guiltily as you feel your buttcheeks expanding.  Each time you bounce and shake your new derriere, you moan softly in enjoyment.  Damnit!  You force yourself to stop just as your ass does, but when you set off again, you can feel it bouncing behind you with every step.  At least it'll help you tease your foes a little more effectively...\n");
					player.dynStats("int", -1, "lus", 10);
					player.butt.type = 12;
					needNext = true;
				}
			}
			if (player.hasPerk(PerkLib.BroBody)) { //Bro checks
				player.removeStatusEffect(StatusEffects.Feeder);
				player.removePerk(PerkLib.Feeder);
				if (!player.hasCock()) { //(Dick regrowth)
					player.createCock(10, 2.75);
					outputText("\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, 10-inch cock pulses happily.");

					if (player.balls == 0) {
						outputText("  A pair of heavy balls drop into place below it, churning to produce cum.");
						transformations.BallsDuo.applyEffect(false);
						player.ballSize = 3;
					}
					outputText("</b>\n");
					needNext = true;
				}
				if (player.cocks[0].cockLength < 8) { //(Dick rebiggening)
					outputText("\n<b>As time passes, your cock engorges, flooding with blood and growing until it's at 8 inches long.  ");
					if (player.hasPerk(PerkLib.BroBrains)) outputText("Goddamn, that thing is almost as tough as you!  ");
					outputText("You really have no control over your dick.</b>\n");
					player.cocks[0].cockLength = 8;
					if (player.cocks[0].cockThickness < 2) player.cocks[0].cockThickness = 1.5;
					needNext = true;
				}
				if (player.balls == 0) { //(Balls regrowth)
					outputText("\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath [eachcock] grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>\n");
					transformations.BallsDuo.applyEffect(false);
					player.ballSize = 3;
					needNext = true;
				}
			}

			//QUEST AREA
			//Vala Gathering Quest
			if (player.hasItem(useables.S_SHARD, 15) && ValaScene.ValaFairyQueenQuest == ValaScene.QUEST_STAGE_STARTED) {
				outputText("\n<b>You now have enough scepter shards to repair the fairy queen scepter! Go turn this to Vala in Tel Adre.</b>\n");
				ValaScene.ValaFairyQueenQuest = ValaScene.QUEST_STAGE_ITEM_GATHERED;
				needNext = true;
			}
			if (!player.hasItem(useables.S_SHARD, 15) && ValaScene.ValaFairyQueenQuest == ValaScene.QUEST_STAGE_ITEM_GATHERED) {
				outputText("\n<b>Oops you seem to have forgot that Vala needs those items to repair the royal scepter and parted way with them! Well its fine you can always go beat some more Phouka for extras.</b>\n");
				ValaScene.ValaFairyQueenQuest = ValaScene.QUEST_STAGE_STARTED;
				needNext = true;
			}
			//Other removeCurse cooldowns
			if (flags[kFLAGS.AYANE_CURE_COOLDOWN] > 0) --flags[kFLAGS.AYANE_CURE_COOLDOWN];
			if (flags[kFLAGS.DIANA_CURE_COOLDOWN] > 0) --flags[kFLAGS.DIANA_CURE_COOLDOWN];
			//Luna nursing reset
			if (LunaFollower.Nursed) {
				LunaFollower.NursedCooldown -= 1
				if (LunaFollower.NursedCooldown == 0)
				{
					LunaFollower.Nursed = false;
				}
			}
			//Luna mooning reset
			if (LunaFollower.Sated) {
				LunaFollower.SatedCooldown -= 1
				if (LunaFollower.SatedCooldown == 0)
				{
					LunaFollower.Sated = false;
				}
			}
			if (isNightTime && !camp.IsWaitingResting && !LunaFollower.Sated){
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8 && (flags[kFLAGS.LUNA_JEALOUSY] >= 400 || flags[kFLAGS.LUNA_FOLLOWER] > 6) && player.gender > 0 && player.hasStatusEffect(StatusEffects.LunaWasWarned) && !player.hasStatusEffect(StatusEffects.LunaOff)) {
					LunaFullMoonScene = true;
					return true;
				}
			}
			//Process crops harvest moon
			if (CoC.instance.model.time.hours == 24){
				if (HarvestMoonScenes.harvestmoonstageHH < 7 && HarvestMoonScenes.harvestmoonstageHH > 0) {
					HarvestMoonScenes.harvestmoonstageHH += 1;
				}
				if (HarvestMoonScenes.harvestmoonstageMG < 7 && HarvestMoonScenes.harvestmoonstageMG > 0) {
					HarvestMoonScenes.harvestmoonstageMG += 1;
				}
				if (HarvestMoonScenes.harvestmoonstageSB < 7 && HarvestMoonScenes.harvestmoonstageSB > 0) {
					HarvestMoonScenes.harvestmoonstageSB += 1;
				}
				if (HarvestMoonScenes.harvestmoonstageIW < 7 && HarvestMoonScenes.harvestmoonstageIW > 0) {
					HarvestMoonScenes.harvestmoonstageIW += 1;
				}
				if (HarvestMoonScenes.harvestmoonstageBF < 7 && HarvestMoonScenes.harvestmoonstageBF > 0) {
					HarvestMoonScenes.harvestmoonstageBF += 1;
				}
			}
			//Wrap it up
			return needNext;
		}

		private var LunaFullMoonScene: Boolean = false;

		public function timeChangeLarge():Boolean {
            if (!ingnam.inIngnam) {
                if (rand(4) == 0 && Holidays.isChristmas() && player.gender > 0 && camp.IsSleeping && flags[kFLAGS.XMAS_CHICKEN_YEAR] < date.fullYear) {
					SceneLib.holidays.getAChristmasChicken();
                    return true;
                }
                if (camp.IsSleeping && Holidays.isChristmas() && date.fullYear > flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE]) { //XMAS ELF
					SceneLib.holidays.xmasBitchEncounter(); //Set it to remember the last year encountered
                    return true;
                }
                if (checkedTurkey++ == 0 && (rand(5) == 0 && (CoC.instance.model.time.hours == 18 || CoC.instance.model.time.hours == 19)) && (date.fullYear > flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] || flags[kFLAGS.MORE_TURKEY] > 0) && Holidays.isThanksgiving() && player.gender > 0 && !flags[kFLAGS.IN_INGNAM]) {
					SceneLib.holidays.datTurkeyRumpMeeting(); //TURKEY SURPRISE
                    return true;
                }
				if (checkedHellhound++ == 0 && rand(5) == 0 && !player.isRaceCached(Races.CERBERUS) && player.isHellHound() && player.hasPerk(PerkLib.Hellfire) && camp.IsSleeping && player.hasKeyItem("Marae's Lethicite") >= 0
						&& player.keyItemvX("Marae's Lethicite", 1) > 0 ) { //&& !player.raceCached(Cerberus)
					SceneLib.camp.campUniqueScenes.hellhoundCapture();
					return true;
				}

                if (LunaFullMoonScene){
                    if (camp.IsSleeping)
                        SceneLib.lunaFollower.fullMoonEvent();
                    else
                        SceneLib.lunaFollower.fullMoonEvent(true);
                    LunaFullMoonScene = false;
                    return true;
                }
            }
            if (checkedDream++ == 0 && camp.IsSleeping && camp.CanDream) { //You can only have one dream each night (NEEDS TO BE FIXED)
				camp.CanDream = false;
                if (player.gender > 0 && CoC.instance.model.time.days == 10) { //Day 10 dream - since this can happen only once it takes priority over all other dreams
                    dreams.dayTenDreams();
					return true;
				}
				if (player.hasCock() && player.hasPerk(PerkLib.BeeOvipositor) && (player.eggs() >= 20 && rand(6) == 0)) { //Bee dreams proc
					//happens at first sleep after hitting stage 3 unfertilized
					//To Wong Foo, Thanks for Everything, Julie Newmar
					outputText("\nYou sit atop your favorite flower, enjoying the smell of verdure and the sounds of the forest.  The sun is shining brightly and it feels wonderful on your chitin.  Your wings twitch happily in the soft breeze, and it feels good to be alive and doing the colony's work... the only sour note is your heavy, bloated abdomen, so full of unfertilized eggs that it droops, so full it strains your back and pinches your nerves.  Still, it's too nice a day to let that depress you, and you take up your customary song, humming tunelessly but mellifluously as you wait for passers-by.");

					outputText("\n\nYour [antennae] bob - was that someone?  Peering between the trees from the corner of your eye, you can see the figure of another person, and you intensify your hypnotic buzz, trying to draw it closer.  The figure steps into your clearing and out of the shadow; clad in [armor], " + player.mf("he","she") + " is yourself!  Confused, you stop humming and stare into your own face, and the other you takes the opportunity to open " + player.mf("his","her") + " garments, exposing " + player.mf("his","her") + " [cock]!");

					outputText("\n\nStartled, you slip down from your seat and try to run, but the other you has already crossed the clearing and seizes you by the fuzz on your hefty, swollen abdomen; your leg slips, propelling you face-first to the ground.  " + player.mf("He","She") + " pulls you back toward " + player.mf("his","her") + "self and, grabbing one of your chitinous legs, turns you over.  The other you spreads your fuzzed thighs, revealing your soft, wet pussy, and the sweet smell of honey hits your noses.  " + player.mf("His","Her") + " prick hardens intensely and immediately at the aroma of your pheromone-laden nectar, and " + player.mf("he","she") + " pushes it into you without so much as a word of apology, groaning as " + player.mf("he","she") + " begins to rut you mercilessly.  You can feel the sensations of " + player.mf("his","her") + " burning cock as if it were your own, and your legs wrap around your other self instinctively even as your mind recoils in confusion.");

					outputText("\n\nThe other you grunts and locks up as " + player.mf("his","her") + "... your [cock] begins to spurt inside your honey-drooling cunt, and " + player.mf("he","she") + " falls onto you, bottoming out inside; your vagina likewise clenches and squirts your sweet juices.  As " + player.mf("he","she") + " ejaculates, thrusting weakly, you can feel something shifting in you, filling you with pins and needles... it feels like the warm cum " + player.mf("he","she") + "'s filling you with is permeating your entire groin, working its way back toward your abdomen.  It edges up to your massive buildup of eggs, and your body tightens in a second climax at the thought of having your children fertilized-");

					outputText("\n\nYou snap awake, sitting bolt upright.  What in the name of... your [cocks] is softening rapidly, and as you shift, you can feel your cum sloshing in your [armor].  For fuck's sake.");
					if (player.cumQ() >= 1000) outputText("  It's completely soaked your bedroll, too... you won't be sleeping on this again until you wash it out.  Grumbling, you roll the soggy, white-stained fabric up and stow it.");
					outputText("  The sensation of wetness inside your own clothes torments you as you try to return to sleep, driving up your lust and making you half-hard once again... the rumbling of eggs in your abdomen, as if they're ready to be laid, doesn't help either.");
					player.fertilizeEggs(); //convert eggs to fertilized based on player cum output, reduce lust by 100 and then add 20 lust
					player.orgasm(); //reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
					player.dynStats("lus", 20, "scale", false);
                    EngineCore.doNext(playerMenu);
					//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
					//Hey whoever, maybe you write them? -Z
					return true;
				}
				if (player.hasCock() && player.hasPerk(PerkLib.MantisOvipositor) && (player.eggs() >= 20 && rand(6) == 0)) { //Mantis dreams proc
					outputText("\nIn a moonlit forest, you sit upon a thick tree branch silently above fresh web after you naturaly 'take care' of it owner.  You watch with rising lust as a hapless traveler strolls along below, utterly unaware of the trap set.  Your breath catches as " + player.mf("he","she") + " finally encounters web, flailing against the sticky strands in a futile attempt to free " + player.mf("him","her") + "self.  Once the traveller's struggles slow in fatigue, you descend easily to the forest floor, with few pecise swings of your scythes wrapping " + player.mf("him","her") + " in an elegant makeshift silk cocoon before pulling " + player.mf("him","her") + " up into the canopy.  Cutting " + player.mf("his","her") + " crotch free of your webbing, you open " + player.mf("his","her") + " [armor] and release the ");
					if (player.hasVagina()) outputText(Appearance.vaginaDescript(player,0) + " and ");
					outputText(player.cockDescript(0) + " therein; you lower yourself onto " + player.mf("him","her") + " over and over again, spearing your eager pussy with " + player.mf("him","her") + " prick");
					if (player.hasVagina()) outputText(" while you bend and force your own into her cunt");
					outputText(".  It's not long until you feel ");
					if (player.hasVagina()) outputText("her pussy clenching around you as you orgasm explosively inside, followed by ");
					outputText("the sensation of warm wetness in your own vagina.  Your prisoner groans as " + player.mf("his","her") + " cock twitches and spasms inside you, spraying your insides with seed; warm, delicious, sticky seed for your eggs.  You can feel it drawing closer to your unfertilized clutch, and as the gooey heat pushes toward them, your head swims, and you finally look into your prey's [face]...");

					outputText("\n\nYour eyes flutter open.  What a strange dream... aw, dammit.  You can feel your [armor] rubbing against your crotch, sodden with cum.  ");
					if (player.cumQ() > 1000) outputText("It's all over your bedroll, too...");
					outputText("  Turning over and trying to find a dry spot, you attempt to return to sleep... the wet pressure against your crotch doesn't make it easy, nor do the rumbles in your abdomen, and you're already partway erect by the time you drift off into another erotic dream.  Another traveler passes under you, and you prepare to jump at her; your ovipositor peeks out eagerly and a bead of slime drips from it, running just ahead of the first fertilized egg you'll push into your poor victim...");
					player.fertilizeEggs(); //reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
					player.orgasm();
					player.dynStats("lus", 20, "scale", false);
					EngineCore.doNext(playerMenu);
					return true;
				}
				if (player.hasCock() && player.hasPerk(PerkLib.SpiderOvipositor) && (player.eggs() >= 20 && rand(6) == 0)) { //Drider dreams proc
					outputText("\nIn a moonlit forest, you hang upside down from a thick tree branch suspended by only a string of webbing.  You watch with rising lust as a hapless traveler strolls along below, utterly unaware of the trap you've set.  Your breath catches as " + player.mf("he","she") + " finally encounters your web, flailing against the sticky strands in a futile attempt to free " + player.mf("him","her") + "self.  Once the traveller's struggles slow in fatigue, you descend easily to the forest floor, wrapping " + player.mf("him","her") + " in an elegant silk cocoon before pulling " + player.mf("him","her") + " up into the canopy.  Positioning your catch against the tree's trunk, you sink your fangs through the web and into flesh, feeling " + player.mf("his","her") + " body heat with every drop of venom.  Cutting " + player.mf("his","her") + " crotch free of your webbing, you open " + player.mf("his","her") + " [armor] and release the ");
					if (player.hasVagina()) outputText(Appearance.vaginaDescript(player,0) + " and ");
					outputText(player.cockDescript(0) + " therein; you lower yourself onto " + player.mf("him","her") + " over and over again, spearing your eager pussy with " + player.mf("him","her") + " prick");
					if (player.hasVagina()) outputText(" while you bend and force your own into her cunt");
					outputText(".  It's not long until you feel ");
					if (player.hasVagina()) outputText("her pussy clenching around you as you orgasm explosively inside, followed by ");
					outputText("the sensation of warm wetness in your own vagina.  Your prisoner groans as " + player.mf("his","her") + " cock twitches and spasms inside you, spraying your insides with seed; warm, delicious, sticky seed for your eggs.  You can feel it drawing closer to your unfertilized clutch, and as the gooey heat pushes toward them, your head swims, and you finally look into your prey's [face]...");

					outputText("\n\nYour eyes flutter open.  What a strange dream... aw, dammit.  You can feel your [armor] rubbing against your crotch, sodden with cum.  ");
					if (player.cumQ() > 1000) outputText("It's all over your bedroll, too...");
					outputText("  Turning over and trying to find a dry spot, you attempt to return to sleep... the wet pressure against your crotch doesn't make it easy, nor do the rumbles in your abdomen, and you're already partway erect by the time you drift off into another erotic dream.  Another traveler passes under you, and you prepare to snare her with your web; your ovipositor peeks out eagerly and a bead of slime drips from it, running just ahead of the first fertilized egg you'll push into your poor victim...");
					player.fertilizeEggs(); //reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
					player.orgasm();
					player.dynStats("lus", 20, "scale", false);
					EngineCore.doNext(playerMenu);
					//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
					//Hey whoever, maybe you write them? -Z
					return true;
				}
				var ceraph:int; //Ceraph's dreams - overlaps normal night-time dreams.
				switch (flags[kFLAGS.CERAPH_OWNED_DICKS] + flags[kFLAGS.CERAPH_OWNED_PUSSIES] + flags[kFLAGS.CERAPH_OWNED_TITS]) {
					case  0: ceraph =  0; break; //If you've given her no body parts then Ceraph will not cause any dreams
					case  1: ceraph = 10; break; //Once every 10 days if 1, once every 7 days if 2, once every 5 days if 3
					case  2: ceraph =  7; break;
					case  3: ceraph =  5; break;
					case  4: ceraph =  4; break;
					default: ceraph =  3;
				}
                if (ceraph > 0 && CoC.instance.model.time.days % ceraph == 0) {
                    SceneLib.ceraphScene.ceraphBodyPartDreams();
                    return true;
				}
				if (flags[kFLAGS.DOMINIKA_FOLLOWUP] > 0 && flags[kFLAGS.DOMINIKA_FOLLOWUP] < 4 && flags[kFLAGS.DOMINIKA_COVENANT] < 3) { //Dominika Dream
					outputText("\n<b>Your rest is somewhat troubled with odd dreams...</b>\n");
                    SceneLib.telAdre.dominika.fellatrixDream();
                    return true;
				}
                if (SceneLib.kidAScene.kidAXP() >= 40 && flags[kFLAGS.HAD_KID_A_DREAM] == 0 && player.gender > 0) {
                    SceneLib.kidAScene.kidADreams();
                    flags[kFLAGS.HAD_KID_A_DREAM] = 1;
					return true;
				}
				if (player.viridianChange()) {
					dreams.fuckedUpCockDreamChange();
					return true;
				}
				if (player.isRaceCached(Races.PLANT) && player.hasPerk(PerkLib.SoulSense) && flags[kFLAGS.SOUL_SENSE_WORLD_TREE] < 1) {
					outputText("\nYou find yourself in a forest. You feel a delicate melody fill the air around you, and while it has no discernable sound it somehow resonates with your being. Without even realizing it, you find yourself walking towards the source. Before long, you’re standing before a towering goliath of a tree, much larger than the others around you. As you touch the bark, you hear a soft voice. \"Welcome home\". You bolt awake, and realize it was but a dream.  But somehow, you still feel the song whispering in your mind... <b>Perhaps you could seek out this tree in the waking world?</b>");
					flags[kFLAGS.SOUL_SENSE_WORLD_TREE] = 1;
					EngineCore.doNext(playerMenu);
					return true;
				}
				if (player.hasKeyItem("Jade Talisman") >= 0 && flags[kFLAGS.AURORA_LVL] < 0.1) {
					outputText("\nYou have weird dream tonight. In that dream you’re back in the Hidden Cave, exploring it room after room, smashing to pieces any of the golems or small bat golems you find and looting the treasures. Then you face the dragon-boy in short, but intensive fight, ending with him running away like coward, while still having enough courage to leave some witty remarks.");
					outputText("\n\nMaking sure you not overlooked any valuable items you walk slowly toward stairway leading to first floor when... your gaze stops on one of walls in the room with the stairway. Compared to other nearby walls which are all without any damage or otherwise imperfections you spot on this particular wall something. Something like a crack or...keyhole? Intrigued you start to walk toward it...");
					outputText("\n\nAnd you suddenly wake up. That was really weird. But even weirder is the fact that your holding in your hand that same Jade Talisman you got from your last fight with the weird dragon-boy. Coincidence?");
					if (silly()) outputText(" I think not!");
					flags[kFLAGS.AURORA_LVL] = 0.1;
					EngineCore.doNext(playerMenu);
					return true;
				}
				if (player.lib > (player.libStat.max * 0.5) || player.lust > (player.maxLust() * 0.4)) { //Randomly generated dreams here
					if (dreams.dreamSelect()) return true;
				}
			}
			if (player.statusEffectv1(StatusEffects.SlimeCraving) >= 18 && player.str <= 1) { //Bad end!
                SceneLib.lake.gooGirlScene.slimeBadEnd();
                return true;
			}
			//Pussytail Bad End
			if (player.tailType == Tail.MANTICORE_PUSSYTAIL && player.hasCock() && !debug) {
				SceneLib.camp.campUniqueScenes.badendManticoreOuroboros();
				return true;
			}
			//Bee cocks
			if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE && player.lust >= player.maxOverLust()) {
				if (player.hasItem(consumables.BEEHONY) || player.hasItem(consumables.PURHONY) || player.hasItem(consumables.SPHONEY)) {
					outputText("\nYou can't help it anymore. Thankfully, you have the honey in your pouch so you pull out a vial of honey. You're definitely going to masturbate with honey covering your bee-cock.");
                    doNext(SceneLib.masturbation.masturbateGo);
                    return true;
				}
				outputText("\nYou can’t help it anymore, you need to find the bee girl right now.  You rush off to the forest to find the release that you absolutely must have.  Going on instinct you soon find the bee girl's clearing and her in it.\n\n");
                SceneLib.forest.beeGirlScene.beeSexForCocks(false);
                return true;
			}
			return false;
		}
		//End of Interface Implementation
	}
}
