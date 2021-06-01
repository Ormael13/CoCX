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
import classes.Items.*;
import classes.Scenes.Camp.CampScenes;
import classes.Scenes.Camp.UniqueCampScenes;
import classes.Scenes.Dreams;
import classes.Scenes.Dungeons.DeepCave.ValaScene;
import classes.Scenes.Holidays;
import classes.Scenes.NPCs.CelessScene;
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.NPCs.LunaFollower;
import classes.Scenes.Places.WoodElves;
import classes.Scenes.NPCs.ZenjiScenes;
import classes.Scenes.SceneLib;
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
		private var checkedDream:int;
		private var displayedBeeCock:Boolean;
		private var dreams:Dreams = new Dreams();

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean {
			var needNext:Boolean = false;
			checkedTurkey = 0;
			checkedDream = 0;

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
				dynStats("lus", player.libStat.core.value * 0.04, "scale", false); //Raise lust
				if (player.hasPerk(PerkLib.Lusty)) dynStats("lus", player.libStat.core.value * 0.01, "scale", false); //Double lust rise if lusty.
			}
			else { //Well adjusted perk
				dynStats("lus", player.libStat.core.value * 0.02, "scale", false); //Raise lust
				if (player.hasPerk(PerkLib.Lusty)) dynStats("lus", player.libStat.core.value * 0.005, "scale", false); //Double lust rise if lusty.
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
				if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] < 0) {
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
				if ((flags[kFLAGS.LUNA_FOLLOWER] == 6 || flags[kFLAGS.LUNA_FOLLOWER] == 8 || flags[kFLAGS.LUNA_FOLLOWER] == 10 || flags[kFLAGS.LUNA_FOLLOWER] == 12 || flags[kFLAGS.LUNA_FOLLOWER] == 14 || flags[kFLAGS.LUNA_FOLLOWER] == 16) && flags[kFLAGS.LUNA_JEALOUSY] < 100) flags[kFLAGS.LUNA_FOLLOWER]--;
				if ((flags[kFLAGS.LUNA_FOLLOWER] == 5 || flags[kFLAGS.LUNA_FOLLOWER] == 7 || flags[kFLAGS.LUNA_FOLLOWER] == 9 || flags[kFLAGS.LUNA_FOLLOWER] == 11 || flags[kFLAGS.LUNA_FOLLOWER] == 13 || flags[kFLAGS.LUNA_FOLLOWER] == 15) && flags[kFLAGS.LUNA_JEALOUSY] >= 100 && (CoC.instance.model.time.hours > 6 && CoC.instance.model.time.hours < 23)) SceneLib.lunaFollower.warrningAboutJelously();
			}
			//Zenji loneliness
			if (flags[kFLAGS.ZENJI_PROGRESS] == 11) player.addStatusValue(StatusEffects.ZenjiModificationsList, 1, 1);
			//Tripxi firearms restoration progress
			if (player.statusEffectv3(StatusEffects.TelAdreTripxi) > 0) player.addStatusValue(StatusEffects.TelAdreTripxi, 3, -1);
			//Alter max speed if you have oversized parts. (Realistic mode)
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				var maxSpe:Number;
				//Balls
				var tempSpeedPenalty:Number = 0;
				var lim:int = player.isTaur() ? 9 : 4;
				if (player.ballSize > lim && player.balls > 0) tempSpeedPenalty += Math.round((player.ballSize - lim) / 2);
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
			needNext = hourlyCheckRacialPerks();
			End("PlayerEvents","hourlyCheckRacialPerks");
			if (player.hasStatusEffect(StatusEffects.Feeder)) { //Feeder checks
				if (player.cor <= 20) { //Go away if pure
					outputText("\nThe desire to breastfeed fades into the background.  It must have been associated with the corruption inside you.\n\n(<b>You have lost the 'Feeder' perk.</b>)\n");
					player.removeStatusEffect(StatusEffects.Feeder);
					player.removePerk(PerkLib.Feeder);
					needNext = true;
				}
				else { //Bigga titayz
					if (player.breastRows[0].breastRating < 5) {
						outputText("\nYour " + player.breastDescript(0) + " start to jiggle and wobble as time passes, seeming to refill with your inexhaustible supply of milk.  It doesn't look like you'll be able to keep them below a DD cup so long as you're so focused on breast-feeding.\n");
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
						player.dynStats("lus", 2 + player.effectiveSensitivity() / 10);
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
					outputText("\n<b>Your " + Appearance.nippleDescription(player, 0) + "s are no longer sore from the milking.</b>\n");
					player.removeStatusEffect(StatusEffects.Milked);
					needNext = true;
				}
			}
			if (player.hasStatusEffect(StatusEffects.Jizzpants)) {
				outputText("\nYour [armor] squishes wetly with all the semen you unloaded into them, arousing you more and more with every movement.\n");
				player.dynStats("lus", 10 + player.effectiveSensitivity() / 5);
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
			if (!player.hasStatusEffect(StatusEffects.LactationReduction)) { //Lactation reduction
				if (player.biggestLactation() > 0) player.createStatusEffect(StatusEffects.LactationReduction, 0, 0, 0, 0);
			}
			else if (player.biggestLactation() > 0 && !player.hasStatusEffect(StatusEffects.Feeder) && !player.hasPerk(PerkLib.MilkMaid) && player.pregnancyIncubation == 0) {
				player.addStatusValue(StatusEffects.LactationReduction, 1, 1);
				if (player.statusEffectv1(StatusEffects.LactationReduction) >= 48) {
					if (!player.hasStatusEffect(StatusEffects.LactationReduc0)) {
						player.createStatusEffect(StatusEffects.LactationReduc0, 0, 0, 0, 0);
						if (player.biggestLactation() >= 1) outputText("\n<b>Your " + Appearance.nippleDescription(player, 0) + "s feel swollen and bloated, needing to be milked.</b>\n");
						if (player.biggestLactation() <= 2) player.createStatusEffect(StatusEffects.LactationReduc1, 0, 0, 0, 0);
						if (player.biggestLactation() <= 1) player.createStatusEffect(StatusEffects.LactationReduc2, 0, 0, 0, 0);
						needNext = true;
					}
					player.boostLactation(-0.5 * player.breastRows.length / 24);
					if (player.biggestLactation() <= 2.5 && !player.hasStatusEffect(StatusEffects.LactationReduc1)) {
						outputText("\n<b>Your breasts feel lighter as your body's milk production winds down.</b>\n");
						player.createStatusEffect(StatusEffects.LactationReduc1, 0, 0, 0, 0);
						needNext = true;
					}
					else if (player.biggestLactation() <= 1.5 && !player.hasStatusEffect(StatusEffects.LactationReduc2)) {
						outputText("\n<b>Your body's milk output drops down to what would be considered 'normal' for a pregnant woman.</b>\n");
						player.createStatusEffect(StatusEffects.LactationReduc2, 0, 0, 0, 0);
						needNext = true;
					}
					if (player.biggestLactation() < 1 && !player.hasStatusEffect(StatusEffects.LactationReduc3)) {
						player.createStatusEffect(StatusEffects.LactationReduc3, 0, 0, 0, 0);
						outputText("\n<b>Your body no longer produces any milk.</b>\n");
						player.removeStatusEffect(StatusEffects.LactationReduction);
						needNext = true;
					}
				}
			}
			if (player.hasStatusEffect(StatusEffects.CuntStretched)) { //Cunt stretching stuff
				player.addStatusValue(StatusEffects.CuntStretched, 1, 1);
				if (player.vaginas.length > 0) {
					if (!player.hasPerk(PerkLib.FerasBoonWideOpen)) {
						if (player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE && player.statusEffectv1(StatusEffects.CuntStretched) >= 200) {
							outputText("\nYour " + Appearance.vaginaDescript(player,0) + " recovers from your ordeals, tightening up a bit.\n");
							player.vaginas[0].vaginalLooseness--;
							player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
							needNext = true;
						}
						if (player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING && player.statusEffectv1(StatusEffects.CuntStretched) >= 100) {
							outputText("\nYour " + Appearance.vaginaDescript(player,0) + " recovers from your ordeals, tightening up a bit.\n");
							player.vaginas[0].vaginalLooseness--;
							player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
							needNext = true;
						}
						if (player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE && player.statusEffectv1(StatusEffects.CuntStretched) >= 70) {
							outputText("\nYour " + Appearance.vaginaDescript(player,0) + " recovers from your ordeals and becomes tighter.\n");
							player.vaginas[0].vaginalLooseness--;
							player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
							needNext = true;
						}
					}
					if (player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR && player.statusEffectv1(StatusEffects.CuntStretched) >= 50) {
						outputText("\nYour " + Appearance.vaginaDescript(player,0) + " recovers from the brutal stretching it has received and tightens up a little bit, but not much.\n");
						player.vaginas[0].vaginalLooseness--;
						player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
						needNext = true;
					}
				}
			}
			if (player.hasStatusEffect(StatusEffects.ButtStretched)) { //Butt stretching stuff
				player.addStatusValue(StatusEffects.ButtStretched, 1, 1);
				if (player.ass.analLooseness == 2 && player.statusEffectv1(StatusEffects.ButtStretched) >= 72) {
					outputText("\n<b>Your " + Appearance.assholeDescript(player) + " recovers from your ordeals, tightening up a bit.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (player.ass.analLooseness == 3 && player.statusEffectv1(StatusEffects.ButtStretched) >= 48) {
					outputText("\n<b>Your " + Appearance.assholeDescript(player) + " recovers from your ordeals, tightening up a bit.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (player.ass.analLooseness == 4 && player.statusEffectv1(StatusEffects.ButtStretched) >= 24) {
					outputText("\n<b>Your " + Appearance.assholeDescript(player) + " recovers from your ordeals and becomes tighter.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (player.ass.analLooseness == 5 && player.statusEffectv1(StatusEffects.ButtStretched) >= 12) {
					outputText("\n<b>Your " + Appearance.assholeDescript(player) + " recovers from the brutal stretching it has received and tightens up.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
			}
			if ((player.salamanderScore()>=7 || player.hasStatusEffect(StatusEffects.HinezumiCoat) || player.hellcatScore() >= 10) && !player.hasStatusEffect(StatusEffects.Overheat))
			{
				//Argument 1 is weither pc is in heat stage or not 1 means active
				//Argument 2 is how many day left before player enter heats again typicaly 3;
				//Argument 3 tells if player had sex and satisfied its overheat set to 1 when true;
				outputText("\n\nWoa your body is heating up like crazy. You suddenly realise that due to being a");
				if (player.salamanderScore()>=7) outputText(" salamander");
				else if (player.hellcatScore() >= 10) outputText(" hellcat");
				else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) outputText(" hinezumi");
				outputText(" your body has started overheating with lust. You will have to constantly sate your uncontrollable burning need for sex if only to stay sane long enough not to jump on everything that moves.");
				player.createStatusEffect(StatusEffects.Overheat, 1, 0, 0,0);
				if (player.hasCock() || (player.gender == 3 && rand(2) == 0)) player.goIntoRut(false);
				else if (player.hasVagina()) player.goIntoHeat(false);
				needNext = true;
			}
			if ((player.salamanderScore()<7 && !player.hasStatusEffect(StatusEffects.HinezumiCoat) && player.hellcatScore() < 10) && player.hasStatusEffect(StatusEffects.Overheat))
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
				if (player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != LowerBody.GOO) {
                    outputText("\nYour form ripples, as if uncertain at the changes your body is undergoing.  The goo of your flesh cools, its sensitive, responsive membrane thickening into [skin] while bones and muscles knit themselves into a cohesive torso, chest and hips gaining definition.  Translucent ooze clouds and the gushing puddle at your feet melts together, splitting into solid trunks as you regain your legs.  Before long, you can no longer see through your own body and, with an unsteady shiver, you pat yourself down, readjusting to solidity.  A lurching heat in your chest suddenly reminds you of the slime core that used to float inside you.  Gingerly touching your " + CoC.instance.player.chestDesc() + ", you can feel a small, second heartbeat under your ribs that gradually seems to be sinking, past your belly. A lurching wave of warmth sparks through you, knocking you off your fresh legs and onto your " + Appearance.buttDescription(player) + ".  A delicious pressure pulses in your abdomen and you loosen your [armor] as sweat beads down your neck.  You clench your eyes, tongue lolling in your mouth, and the pressure builds and builds until, in ecstatic release, your body arches in an orgasmic release.\n\n");
                    outputText("\nPanting, you open your eyes and see that, for once, the source of your climax wasn't your loins.  Feeling a warm, wetness on your abs, you investigate and find the small, heart-shaped nucleus that used to be inside your body has somehow managed to pass through your belly button. Exposed to the open air, the crimson organ slowly crystallizes, shrinking and hardening into a tiny ruby.  Rubbing the stone with your thumb, you're surprised to find that you can still feel a pulse within its glittering facets.  You stow the ruby heart, in case you need it again.\n");
					player.createKeyItem("Ruby Heart", 0, 0, 0, 0); //[Add 'Ruby Heart' to key items. Player regains slime core if returning to goo body]
					player.removePerk(PerkLib.SlimeCore);
					needNext = true;
				}
			}
			if (player.hasKeyItem("Ruby Heart") >= 0) { //Regain slime core
				if (player.hasStatusEffect(StatusEffects.SlimeCraving) && !player.hasPerk(PerkLib.SlimeCore) && player.isGoo() && player.gooScore() >= 4 && player.vaginalCapacity() >= 9000 && player.skinAdj == "slimy" && player.skinDesc == "skin" && player.lowerBody == LowerBody.GOO) {
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
				if (player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != LowerBody.GOO) {
					outputText("\nYour form ripples, as if uncertain at the changes your body is undergoing.  The goo of your flesh cools, its sensitive, responsive membrane thickening into [skin] while bones and muscles knit themselves into a cohesive torso, chest and hips gaining definition.  Translucent ooze clouds and the gushing puddle at your feet melts together, splitting into solid trunks as you regain your legs.  Before long, you can no longer see through your own body and, with an unsteady shiver, you pat yourself down, readjusting to solidity.  A lurching heat in your chest suddenly reminds you of the slime core that used to float inside you.  Gingerly touching your " + CoC.instance.player.chestDesc() + ", you can feel a small, second heartbeat under your ribs that gradually seems to be sinking, past your belly. A lurching wave of warmth sparks through you, knocking you off your fresh legs and onto your " + Appearance.buttDescription(player) + ".  A delicious pressure pulses in your abdomen and you loosen your [armor] as sweat beads down your neck.  You clench your eyes, tongue lolling in your mouth, and the pressure builds and builds until, in ecstatic release, your body arches in an orgasmic release.\n\n");
					outputText("\nPanting, you open your eyes and see that, for once, the source of your climax wasn't your loins.  Feeling a warm, wetness on your abs, you investigate and find the small, heart-shaped nucleus that used to be inside your body has somehow managed to pass through your belly button. Exposed to the open air, the crimson organ slowly crystallizes, shrinking and hardening into a tiny ruby.  Rubbing the stone with your thumb, you're surprised to find that you can still feel a pulse within its glittering facets.  You stow the ruby heart, in case you need it again.\n");
					player.createKeyItem("Ruby Orb", 0, 0, 0, 0); //[Add 'Ruby Heart' to key items. Player regains slime core if returning to goo body]
					player.removePerk(PerkLib.DarkSlimeCore);
					needNext = true;
				}
			}
			if (player.hasKeyItem("Ruby Orb") >= 0) { //Regain DARK slime core
				if (player.hasStatusEffect(StatusEffects.SlimeCraving) && !player.hasPerk(PerkLib.DarkSlimeCore) && player.isGoo() && player.gooScore() >= 4 && player.vaginalCapacity() >= 9000 && player.skinAdj == "slimy" && player.skinDesc == "skin" && player.lowerBody == LowerBody.GOO) {
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
				if (player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != LowerBody.GOO) {
					outputText("\n<b>You no longer feel the need to stockpile fluids in your body. Geeze just how much of a slut did this make you?</b>\n");
					player.removeStatusEffect(StatusEffects.SlimeCraving);
					player.removeStatusEffect(StatusEffects.SlimeCravingFeed);
					player.buff("Fluid Growth").remove();
					needNext = true;
				}
				else { //Slime core reduces fluid need rate
					if (player.hasPerk(PerkLib.SlimeCore) || player.hasPerk(PerkLib.DarkSlimeCore))
						player.addStatusValue(StatusEffects.SlimeCraving, 1, 0.5);
					else player.addStatusValue(StatusEffects.SlimeCraving, 1, 1);
					if (player.statusEffectv1(StatusEffects.SlimeCraving) >= 18) {
						if (!player.hasStatusEffect(StatusEffects.SlimeCravingOutput)) { //Protects against this warning appearing multiple times in the output
							player.createStatusEffect(StatusEffects.SlimeCravingOutput, 0, 0, 0, 0);
							outputText("\n<b>Bigger... stronger, each intake of fluid you takes only makes you more starved for the next as you grow in power each time, the need to fuck and feed slowly overwriting any other desire you may have.</b>\n");
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
				player.removeCurse("str",1)
				player.changeStatusValue(StatusEffects.SlimeCraving, 2, 0); //Reset stored hp/toughness values
				needNext = true;
			}
			if (!player.hasPerk(PerkLib.FluidBody) && player.isGoo() && (player.gooScore() >= 11 || player.magmagooScore() >= 13 || player.darkgooScore() >= 13)) {
				outputText("\nWoa your body is so malleable now attacks running through you can't damage you much anymore. This said the feeling of being penetrated by just anything leaves you with mind melting pleasure.\n(<b>Gained New Perk: Fluid Body.</b>\n)");
				player.createPerk(PerkLib.FluidBody, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.hasPerk(PerkLib.FluidBody) && !player.isGoo() && (player.gooScore() < 11 || player.magmagooScore() < 13 || player.darkgooScore() < 13)) {
				outputText("\nYour body no longer being slime enough you worry that weapon will draw blood the next time they strike you as you lose your fluidic nature.\n(<b>Lost Perk: Fluid Body.</b>\n)");
				player.removePerk(PerkLib.FluidBody);
				needNext = true;
			}
			if (player.rearBody.type == RearBody.METAMORPHIC_GOO && player.lowerBody != LowerBody.GOO) {
				outputText("\n<b>Your body becomes way less malleable due to being less slime like.</b>\n");
				player.rearBody.type = RearBody.NONE;
				needNext = true;
			}
			if (!player.hasPerk(PerkLib.MorphicWeaponry) && (player.darkgooScore() >= 17 || player.gooScore() >= 15 || player.magmagooScore() >= 17) && player.buff("Fluid Growth").getValueOfStatBuff("tou.mult") > 50){
				player.createPerk(PerkLib.MorphicWeaponry,0,0,0,0);
				outputText("\nYour body has become so bloated with fluids and so large that you gain the ability to use your excess mass to form any number of additionnal tendrils wich you can use to attack your opponents.\n(<b>Gained New Perk: Morphic Weaponry.</b>\n>\n");
			}
			if (player.hasPerk(PerkLib.MorphicWeaponry) && ((player.darkgooScore() < 17 && player.gooScore() < 15 && player.magmagooScore() < 17) && player.buff("Fluid Growth").getValueOfStatBuff("tou.mult") <= 50)){
				player.removePerk(PerkLib.MorphicWeaponry);
				if((player.darkgooScore() < 17 && player.gooScore() < 15 && player.magmagooScore() < 17)){
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
				player.dynStats("lus", 10);
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
			if (player.werewolfScore() >= 6 && player.hasPerk(PerkLib.LycanthropyDormant)) {
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
			if (player.werewolfScore() < 6 && player.hasPerk(PerkLib.Lycanthropy)) {
				outputText("\nYou feel your animalistic urges go dormant within you as you no longer are the werewolf you once were. <b>Gained Dormant lycanthropy.</b>\n");
				player.createPerk(PerkLib.LycanthropyDormant,0,0,0,0);
				player.statStore.removeBuffs("Lycanthropy");
				player.removePerk(PerkLib.Lycanthropy);
				needNext = true;
			}
			//No better place for these since the code for the event is part of CoC.as or one of its included files
			if (flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] > 0) flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC]--; //Vala post-rape countdown
			if (flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] > 0 && flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] < 500) flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY]++;
			if (CoC.instance.model.time.hours > 23) { //Once per day
				flags[kFLAGS.BROOKE_MET_TODAY] = 0;
                if (CoC.instance.model.time.days % 2 == 0 && flags[kFLAGS.KAIJU_BAD_END_COUNTER] > 0) {
                    flags[kFLAGS.KAIJU_BAD_END_COUNTER]--;
					if (flags[kFLAGS.KAIJU_BAD_END_COUNTER] < 0) flags[kFLAGS.KAIJU_BAD_END_COUNTER] = 0;
				}
				if (flags[kFLAGS.GILDED_JERKED] > 0) flags[kFLAGS.GILDED_JERKED] = 0;
				if (flags[kFLAGS.FED_SCYLLA_TODAY] == 1) flags[kFLAGS.FED_SCYLLA_TODAY] = 0;
				if (flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] != 0) flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] = 0;
				if (flags[kFLAGS.RUBI_PROSTITUTION] > 0) flags[kFLAGS.RUBI_PROFIT] += 2 + rand(4);
				flags[kFLAGS.BENOIT_TALKED_TODAY] = 0;
                SceneLib.bazaar.benoit.updateBenoitInventory();
                flags[kFLAGS.ROGAR_FUCKED_TODAY] = 0;
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285] > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285]--; //Reduce lust-stick resistance building
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] > 0) { //Dominika fellatrix countdown
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155]--;
					if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] < 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] = 0;
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
                if (flags[kFLAGS.USED_MILKER_TODAY] > 0) flags[kFLAGS.USED_MILKER_TODAY] = 0; //Clear 'has fucked milker today'
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
				if (player.hasStatusEffect(StatusEffects.DragonBreathCooldown) && !player.hasPerk(PerkLib.DraconicLungsFinalForm)) player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && !player.hasPerk(PerkLib.DraconicLungs)) player.removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && !player.hasPerk(PerkLib.DraconicLungs)) player.removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && !player.hasPerk(PerkLib.DraconicLungs)) player.removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
				if (player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && !player.hasPerk(PerkLib.DraconicLungs)) player.removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
				//Reset Mara Fruit daily counter
				if (flags[kFLAGS.DAILY_MARA_FRUIT_COUNTER] > 0) flags[kFLAGS.DAILY_MARA_FRUIT_COUNTER] = 0;
				//Alraune flags
				if (flags[kFLAGS.ALRAUNE_DAILY_WATERING] > 0) flags[kFLAGS.ALRAUNE_DAILY_WATERING] = 0;
				if (flags[kFLAGS.ALRAUNE_GROWING] > 0 && flags[kFLAGS.ALRAUNE_GROWING] < 15) flags[kFLAGS.ALRAUNE_GROWING]++;
				//Reset SelfSustain & RepresLust daily counter
				if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] > 0) flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] = 0;
				//Reset Electra Storm Jewel daily limit
				if (flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL] > 0) flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL] = 0;
				//Reset Etna Venom Vial daily limit
				if (flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] > 0) flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] = 0;
				//Reset Ceani Training daily limit
				if (flags[kFLAGS.CEANI_DAILY_TRAINING] > 0) flags[kFLAGS.CEANI_DAILY_TRAINING] = 0;
				//Reset Kindra Training daily limit
				if (flags[kFLAGS.KINDRA_DAILY_TRAINING] > 0) flags[kFLAGS.KINDRA_DAILY_TRAINING] = 0;
				//Reset Chi Chi Training daily limit
				if (flags[kFLAGS.CHI_CHI_DAILY_TRAINING] > 0) flags[kFLAGS.CHI_CHI_DAILY_TRAINING] = 0;
				//Reset Luna Meal CD
				if (flags[kFLAGS.LUNA_MEAL] > 0) flags[kFLAGS.LUNA_MEAL] = 0;
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
				if (!player.hasPerk(PerkLib.JobSoulCultivator) && (player.soulforce < player.maxSoulforce())) {
					player.soulforce += 50;
					if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				}
				if (player.hasPerk(PerkLib.Metamorph) && player.perkv1(PerkLib.Metamorph) < 18) player.addPerkValue(PerkLib.Metamorph, 1, 1)
				//Daily regeneration of mana for non mages
				if (!player.hasPerk(PerkLib.JobSorcerer) && !player.hasPerk(PerkLib.JobElementalConjurer) && (player.mana < player.maxMana())) {
					player.mana += 150;
					if (player.mana > player.maxMana()) player.mana = player.maxMana();
				}
				//Chi Chi healing progress
				if (flags[kFLAGS.CHI_CHI_LVL_UP] < 5 && flags[kFLAGS.CHI_CHI_DAILY_TRAINING] < 1) {
					if (flags[kFLAGS.CHI_CHI_LVL_UP] < 2) flags[kFLAGS.CHI_CHI_LVL_UP] = 2;
					else flags[kFLAGS.CHI_CHI_LVL_UP]++;
				}
				//Excellia fixing counter
				if (flags[kFLAGS.EXCELLIA_RECRUITED] > 2 && flags[kFLAGS.EXCELLIA_RECRUITED] < 30) flags[kFLAGS.EXCELLIA_RECRUITED]++;
				//Alvina timer
				if (SceneLib.dungeons.checkFactoryClear() && flags[kFLAGS.ALVINA_FOLLOWER] < 8) flags[kFLAGS.ALVINA_FOLLOWER]++;
				//Siegweird
				if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 1 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 10) flags[kFLAGS.SIEGWEIRD_FOLLOWER]++;
				if (player.statusEffectv1(StatusEffects.SiegweirdSoup) == 1) player.addStatusValue(StatusEffects.SiegweirdSoup, 1, -1);
				//Mishaps reset
				if (player.hasStatusEffect(StatusEffects.CampLunaMishaps1)) player.removeStatusEffect(StatusEffects.CampLunaMishaps1);
				if (player.hasStatusEffect(StatusEffects.CampLunaMishaps2)) player.removeStatusEffect(StatusEffects.CampLunaMishaps2);
				if (player.hasStatusEffect(StatusEffects.CampLunaMishaps3)) player.removeStatusEffect(StatusEffects.CampLunaMishaps3);
				//Full moon
				flags[kFLAGS.LUNA_MOON_CYCLE]++;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] > 8) flags[kFLAGS.LUNA_MOON_CYCLE] = 1;
				if (player.hasPerk(PerkLib.Lycanthropy)) {
					var changeV:Number = 10 * (player.newGamePlusMod() + 1);
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 5) {
						outputText("<b>\nYou can’t help but notice the moon is almost full as it rises up.  It seems transfixing like it is calling to you.");
						outputText("\n\nYou feel your might increasing as the moon draws closer to fullness.</b>\n");
						player.statStore.replaceBuffObject({ 'str': 10,'tou': 10,'spe': 10}, 'Lycanthropy', { text: 'Lycanthropy'});
						player.setPerkValue(PerkLib.Lycanthropy,1,10);
					}
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 6) {
						outputText("<b>\nWhen the almost-full moon appears it causes your heart to race with excitement.  You hearing seems better than ever.  Every breath brings a rush of smells through your nose that seem much more pronounced than they should.");
						outputText("\n\nYou feel your might increasing as the moon draws closer to fullness.</b>\n");
						player.statStore.replaceBuffObject({ 'str': 20,'tou': 20,'spe': 20}, 'Lycanthropy', { text: 'Lycanthropy'});
						player.setPerkValue(PerkLib.Lycanthropy,1,20);
					}
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 7) {
						outputText("<b>\nYou gaze at the moon and it seems to gaze back into you.   Something is coming and it won’t be long now.   You feel like you are crawling in your skin.  It feels like tear out of your body and be born anew.");
						outputText("\n\nYou feel your might increasing as the moon draws closer to fullness. It's almost time.</b>\n");
						player.statStore.replaceBuffObject({ 'str': 30,'tou': 30,'spe': 30}, 'Lycanthropy', { text: 'Lycanthropy'});
						player.setPerkValue(PerkLib.Lycanthropy,1,30);
					}
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) {
						outputText("<b>\nYou are at the peak of your strength, it's a full moon tonight and you feel yourself burning with maddening desire as you go into " + player.mf("rut your cock hardening and dripping precum at the prospect of impregnating a bitch womb full of your lupine seeds","heat your womb aching for the fresh semen of a virile male.") + "</b>\n.");
						player.statStore.replaceBuffObject({ 'str': 40,'tou': 40,'spe': 40}, 'Lycanthropy', { text: 'Lycanthropy'});
						player.setPerkValue(PerkLib.Lycanthropy,1,40);
						if (player.hasCock() || (player.gender == 3 && rand(2) == 0)) player.goIntoRut(false);
						else if (player.hasVagina()) player.goIntoHeat(false);
					}
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1) {
						outputText("<b>\nThe moon is waning, you are feeling less powerful.</b>\n");
						player.statStore.replaceBuffObject({ 'str': 30,'tou': 30,'spe': 30}, 'Lycanthropy', { text: 'Lycanthropy'});
						player.setPerkValue(PerkLib.Lycanthropy,1,30);
					}
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2) {
						outputText("<b>\nThe moon is waning, you are feeling less powerful.</b>\n");
						player.statStore.replaceBuffObject({ 'str': 20,'tou': 20,'spe': 20}, 'Lycanthropy', { text: 'Lycanthropy'});
						player.setPerkValue(PerkLib.Lycanthropy,1,20);
					}
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3) {
						outputText("<b>\nThe moon is waning, you are feeling less powerful.</b>\n");
						player.statStore.replaceBuffObject({ 'str': 10,'tou': 10,'spe': 10}, 'Lycanthropy', { text: 'Lycanthropy'});
						player.setPerkValue(PerkLib.Lycanthropy,1,10);
					}
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 4) {
						outputText("<b>\nIt's a new moon tonight, you feel somewhat weak.</b>\n");
						player.statStore.replaceBuffObject({ 'str': 0,'tou': 0,'spe': 0}, 'Lycanthropy', { text: 'Lycanthropy'});
						player.setPerkValue(PerkLib.Lycanthropy,1,0);
					}
					needNext = true;
				}
				if (player.hasStatusEffect(StatusEffects.MitziIzmaDaughters)) player.removeStatusEffect(StatusEffects.MitziIzmaDaughters);
				if (player.hasStatusEffect(StatusEffects.ExcelliaJojo)) player.removeStatusEffect(StatusEffects.ExcelliaJojo);
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
					if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) > 4) player.addStatusValue(StatusEffects.AdventureGuildQuests3, 1, -3);
					if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) > 4) player.addStatusValue(StatusEffects.AdventureGuildQuests3, 2, -3);
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
				if (flags[kFLAGS.ZENJI_PROGRESS] == 11) {
					if (player.statusEffectv2(StatusEffects.ZenjiPreparationsList) < 20) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 2, 1);
					if (player.statusEffectv1(StatusEffects.ZenjiModificationsList) > 0) player.addStatusValue(StatusEffects.ZenjiModificationsList, 1, -1);
					if (player.statusEffectv3(StatusEffects.ZenjiZList) > 0) {
						var deduce:Number = player.statusEffectv3(StatusEffects.ZenjiZList);
						player.addStatusValue(StatusEffects.ZenjiZList, 3, -deduce);
					}
					ZenjiScenes.ZenjiFood = false;
				}
				//Kaiba daily buy limit refresh
				if (player.hasStatusEffect(StatusEffects.KaibaDailyLimit)) player.removeStatusEffect(StatusEffects.KaibaDailyLimit);
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
					if (player.hasPerk(PerkLib.EasterBunnyEggBagEvolved)) {
						var changeLib:Number = (player.ballSize*5/100)+1; //Exemple (1*5/100)+1= 1.05 wich is the modifier to libido
						if (player.hasPerk(PerkLib.EasterBunnyEggBagFinalForm)){
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
				if ((player.armor == armors.SCANSC || player.jewelry == jewelries.DMTO || player.jewelry2 == jewelries.DMTO || player.jewelry3 == jewelries.DMTO || player.jewelry4 == jewelries.DMTO) && player.cor < 100) {
					outputText("\nCorruption seethes from your defiled equipment into you.\n");
					player.cor += 5;
				}
			}
			//Easter bunny egg balls Loosing
			if (player.easterbunnyScore() < 10 && player.hasPerk(PerkLib.EasterBunnyBalls) && !player.hasPerk(PerkLib.EasterBunnyEggBag)) {
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
					if (player.hasPerk(PerkLib.VampiricBloodsteamEvolved) && player.statusEffectv2(StatusEffects.VampireThirst) < 1) player.addStatusValue(StatusEffects.VampireThirst, 2, 1);
					else vthirst.modSatiety(-1);
				}
				//Getting chrismas tree
				if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 1) {
					outputText("Around the edge of your camp, you spot some plant-life beginning to sprout.  The barren, wasteland crust is fractured and broken, giving up a leafy green shoot.  It only reaches up to your knee, but the plant looks healthy and young.  Perhaps it will grow larger?  There is a central stem that supports most of the weight, but a dozen branches fork off, supporting a bevy of shiny green leaves. Looks like the seed was able to take root in the barren land after all.\n");
					flags[kFLAGS.CHRISTMAS_TREE_GROWTH_COUNTER] = 0;
					flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 2;
					needNext = true;
				}
				if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 9 && !player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
					campScenes.PCGoblinDaughtersBuilingWorkshop();
					needNext = true;
				}
				if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 9 && player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
					var nails:Number = 0;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) nails += 10 + rand(21);
					var metalpieces:Number = 0;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) metalpieces += 1;
					var mechanism:Number = 0;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) mechanism += 1;
					var energycore:Number = 0;
					if (rand(100) > flags[kFLAGS.PC_GOBLIN_DAUGHTERS]) energycore += 1;
					if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshopSpareParts)) {
						if (nails > 0) player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 1, nails);
						if (metalpieces > 0) player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 2, metalpieces);
						if (mechanism > 0) player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 3, mechanism);
						if (energycore > 0) player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 4, energycore);
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
			if (hungerActive || prison.inPrison) {
				var multiplier:Number = 1.0;
				if (player.hasPerk(PerkLib.Survivalist)) multiplier -= 0.2;
				if (player.hasPerk(PerkLib.Survivalist2)) multiplier -= 0.2;
				if (player.hasPerk(PerkLib.ManticoreCumAddict)) multiplier *= 2;
				if (player.hasPerk(PerkLib.HydraRegeneration)) multiplier *= 2;
				//Hunger drain rate. If above 50, 1.5 per hour. Between 25 and 50, 1 per hour. Below 25, 0.5 per hour.
				//So it takes 100 hours to fully starve from 100/100 to 0/100 hunger. Can be increased to 125 then 166 hours with Survivalist perks.
				if (player.hasStatusEffect(StatusEffects.FastingPill)) player.hunger += 2;
				if (prison.inPrison) {
					if (player.internalChimeraRating() >= 1) {
						player.hunger -= ((4 + player.internalChimeraRating()) * 0.5 * multiplier); //Hunger depletes faster in prison.
					}
					else {
						player.hunger -= (2 * multiplier); //Hunger depletes faster in prison.
					}
				}
				else {
					if (player.internalChimeraRating() >= 1) player.hunger -= (0.5 * player.internalChimeraRating());
					if (player.hunger > 80) player.hunger -= (0.5 * multiplier); //If satiated, depletes at 2 points per hour.
					if (player.hunger > 50) player.hunger -= (0.5 * multiplier);
					if (player.hunger > 25) player.hunger -= (0.5 * multiplier);
					if (player.hunger > 0) player.hunger -= (0.5 * multiplier);
				}
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_GOO_STUFFED) player.hunger = 100; //After Valeria x Goo Girl, you'll never get hungry until you "birth" the goo-girl.
				if (player.hunger < 50 && player.hasPerk(PerkLib.MagicMetabolism)) {
					var manaDrain:Number = 0;
					manaDrain += 50 - player.hunger;
					if (player.mana >= (manaDrain * 5)) {
						player.mana -= (manaDrain * 5);
						player.hunger = 50;
					}
				}
				if (player.hunger <= 0) {
					if (prison.inPrison) {
						if (player.isGargoyle()) {
							fatigue(2);//zmienić potem jak lia coś tu wymyśli
						}
						else {
							SceneLib.prison.changeWill(-1, prison.inPrison);
							fatigue(2);
						}
					}
					else {
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
					}
					player.hunger = 0; //Prevents negative
				}
				else {
					if (prison.inPrison) {
						SceneLib.prison.changeWill((player.esteem / 50) + 1);
					}
				}
				if (player.hunger < 10 && model.time.hours % 4 == 0 && !prison.inPrison) {
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

			//Armor unequip zone
			if (player.armor == armors.CTPALAD && !player.isTaur())
			{
				outputText("Due to your current body shape you are no longer able to wear the centaur armor and thus you drop the over encumbering equipment back into your inventory");
				SceneLib.inventory.takeItem(player.setArmor(armors.NOTHING), playerMenu);
				needNext = true;
			}
			if (player.armor == armors.KBDRESS && !player.isScylla() && !player.isKraken())
			{
				outputText("Due to your current body shape you are no longer able to wear the Kraken black dress and thus you put the over item back into your inventory");
				SceneLib.inventory.takeItem(player.setArmor(armors.NOTHING), playerMenu);
				needNext = true;
			}
			//if (player.armor == armors.SSC && (player.isTaur() || player.lowerBody == LowerBody.NAGA || player.lowerBody == LowerBody.SCYLLA || player.lowerBody == LowerBody.KRAKEN || player.lowerBody == LowerBody.CENTIPEDE || player.lowerBody == LowerBody.GOO || player.lowerBody == LowerBody.MELKIE || player.lowerBody == LowerBody.DRIDER))
			//{
				//outputText("Due to your current body shape you are no longer able to wear the scandalous succubus clothes and thus you drop the over encumbering equipment back into your inventory.");
				//SceneLib.inventory.takeItem(player.setArmor(armors.NOTHING), playerMenu);
				//needNext = true;
			//}
			//Demonic hunger perk
			if (player.demonScore() >= 10 || player.hasPerk(PerkLib.Phylactery)) { //Check for being a demon enough
				if (!player.hasPerk(PerkLib.DemonEnergyThirst)) {
					outputText("\nYou begin fantasising about pussies and cocks foaming at the idea of fucking or getting fucked. It would look like you aquired the demons hunger for sex and can now feed from the orgasms of your partners. \n\n(<b>Gained Perk: Demonic Hunger</b>)\n");
					player.createPerk(PerkLib.DemonEnergyThirst, 0, 0, 0, 0);
					needNext = true;
				}
			}
			//Demonic hunger perk loss
			if (player.demonScore() < 10 && !player.hasPerk(PerkLib.Phylactery)) { //Check for being a demon enough
				if (player.hasPerk(PerkLib.DemonEnergyThirst)) {
					outputText("\nYour mind clears up as becoming less of a demon you also lost the demonic hunger only sex could sate. \n\n(<b>Lost Perk: Demonic Hunger</b>)\n");
					player.removePerk(PerkLib.DemonEnergyThirst);
					needNext = true;
				}
			}
			//Demonic energy thirst
			if (player.hasStatusEffect(StatusEffects.DemonEnergyThirstFeed)) {
				if (player.hunger < player.maxHunger()) player.refillHunger(10, false);
				if (player.HP < player.maxHP()) EngineCore.HPChange(100 + (player.tou*2), true);
				if (player.mana < player.maxMana()) EngineCore.ManaChange(100 + (player.inte*2), true);
				EngineCore.changeFatigue(-(100 + (player.spe*2)));
				outputText("You feel energised and empowered by the energy drained out of the cum of your recent fuck. What a meal!");
				player.removeStatusEffect(StatusEffects.DemonEnergyThirstFeed)
			}
			//Flexibility perk
			if ((player.tailType == Tail.CAT || player.tailType == Tail.MANTICORE_PUSSYTAIL || player.tailType == Tail.BURNING) && (player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LION) && (player.arms.type == Arms.CAT || player.arms.type == Arms.LION || player.arms.type == Arms.DISPLACER)) { //Check for gain of cat agility - requires legs, tail, and arms
				if (!player.hasPerk(PerkLib.Flexibility)) {
					outputText("\nWhile stretching, you notice that you're much more flexible than you were before.  Perhaps this will make it a bit easier to dodge attacks in battle?\n\n(<b>Gained Perk: Flexibility</b>)\n");
					player.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.Flexibility) && player.perkv4(PerkLib.Flexibility) == 0 && !player.hasPerk(PerkLib.CatlikeNimbleness)) { //Remove flexibility perk if not meeting requirements
				outputText("\nYou notice that you aren't as flexible as you were when you had a more feline body.  It'll probably be harder to avoid your enemies' attacks now.\n\n(<b>Lost Perk: Flexibility</b>)\n");
				player.removePerk(PerkLib.Flexibility);
				needNext = true;
			}
			//Ghost-slinger perk
			if (player.poltergeistScore() >= 12 && !player.hasPerk(PerkLib.Ghostslinger)) {
				outputText("\nYour head is suddenly filled with strange otherworldly knowledge. Things you didn't think possible before could become a reality now thanks to your supernatural intellect and abilities. You could even apply these newfound abilities to your equipment.\n\n(<b>Gained Perk: Ghost-slinger</b>)\n\n(<b>Gained Perk: Telekinesis</b>)");
				player.createPerk(PerkLib.Ghostslinger, 0, 0, 0, 0);
				player.createPerk(PerkLib.Telekinesis, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.poltergeistScore() < 12 && player.hasPerk(PerkLib.Ghostslinger)) {// && !player.hasPerk(PerkLib.LizanMarrow)
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
			if (player.ratatoskrScore() >= 12 && !player.hasPerk(PerkLib.KnowledgeIsPower)) {
				outputText("\nBecoming more of a Ratatoskr your memory seems to have grown and as such the ability the analyze and properly catalogue your opponents many weaknesses as well as new fighting skills you gained the Knowledge is Power perk!\n\n(<b>Gained Perk: Knowledge is power</b>)");
				player.createPerk(PerkLib.KnowledgeIsPower, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.ratatoskrScore() < 12 && player.hasPerk(PerkLib.KnowledgeIsPower)) {// && !player.hasPerk(PerkLib.LizanMarrow)
				outputText("\nBecoming less of a Ratatoskr your memory has become hazy, your wits slowing down to that of a standard human.\n\n(<b>Lost Perk: Knowledge is power</b>)");
				player.removePerk(PerkLib.KnowledgeIsPower);
				needNext = true;
			}
			//Improved venom gland
			if (flags[kFLAGS.VENOM_TIMES_USED] >= 50 && !player.hasPerk(PerkLib.ImprovedVenomGland)) {
				outputText("\nYou feel wonderfully healthy. After using your venom so many time your body finally got acclimated to the presence of your venom gland allowing for increased capacity and production. \n\n(<b>Gained Perk: Improved venom gland</b>)\n");
				player.createPerk(PerkLib.ImprovedVenomGland, 0, 0, 0, 0);
			}
			//Kitsune hunger perk
			if (player.kitsuneScore() >= 10) { //Check for being a kitsune enough
				if (!player.hasPerk(PerkLib.KitsuneEnergyThirst)) {
					outputText("\nYou begin fantasizing about pussies and cocks, foaming at the idea of fucking or getting fucked. It looks like you acquired the kitsune's hunger for sex and can now feed off the life force extracted from the orgasms of your partners. \n\n(<b>Gained Perk: Kitsune Hunger</b>)\n");
					player.createPerk(PerkLib.KitsuneEnergyThirst, 0, 0, 0, 0);
					needNext = true;
				}
			}
			//Kitsune hunger perk
			if (player.kitsuneScore() < 10) { //Check for being a kitsune enough
				if (player.hasPerk(PerkLib.KitsuneEnergyThirst)) {
					outputText("\nYour mind clears up as you become less of a kitsune. You also lost the hunger for life force only sex could provide you. \n\n(<b>Lost Perk: Kitsune Hunger</b>)\n");
					player.removePerk(PerkLib.KitsuneEnergyThirst);
					needNext = true;
				}
			}
			/*
			//Insane/corrupted Kitsune warning //No longer in dev. Just didn't work with the theme.
			if (player.hasPerk(PerkLib.DarkenedKitsune) && player.inte/player.intStat.max <= 0.85 && flags[kFLAGS.DARKKITSUNE_WARN_INT] != 1){ //warning at 15 % loss. Considering by the time you get to kitsune tier, you should probably have a decent amount of each, 15% margin should be good.
				SceneLib.darkenedKitsuneScene.splitPersonalityWarning(1)
				flags[kFLAGS.DARKKITSUNE_WARN_INT] = 1;
				needNext = true;
			}
			else if (player.hasPerk(PerkLib.DarkenedKitsune) && player.wis/player.wisStat.max <= 0.85 && flags[kFLAGS.DARKKITSUNE_WARN_WIS] != 1){
				SceneLib.darkenedKitsuneScene.splitPersonalityWarning(2)
				flags[kFLAGS.DARKKITSUNE_WARN_WIS] = 1;
				needNext = true;
			}
			//Insane/corrupted Kitsune random events
			if (player.hasPerk(PerkLib.DarkenedKitsune)) {
				if (rand(5)==0){
				SceneLib.darkenedKitsuneScene.splitPersonalityRandom()
				}
				SceneLib.darkenedKitsuneScene.splitPersonalityStatchange()
				needNext = true;
			}
			//Insane/corrupted Kitsune perk
			if (player.kitsuneScore() >= 9 ){
				if(player.cor >= 50 && !player.hasPerk(PerkLib.DarkenedKitsune)) { //Check for being kitsune enough + high enough corruption
					SceneLib.darkenedKitsuneScene.splitPersonalityFirstEncounter()
					player.createPerk(PerkLib.DarkenedKitsune, 0,0,0,0);
					outputText("<b>Gained Perk: Darkened Kitsune!</b>\n")
					needNext = true;
				}
				else if (player.cor >= 95 && player.hasPerk(PerkLib.DarkenedKitsune) && player.inte/player.intStat.max < 0.75 && player.wis/player.wisStat.max < 0.75 && (rand(4)==0)){ //Bad end roll. Most likely will be tweaked since this is really small case.
						SceneLib.darkenedKitsuneScene.splitPersonalityTakesOver()
						//needNext = true;
				}
				else if (player.cor < 50 && player.hasPerk(PerkLib.DarkenedKitsune)){ //Remove due to low corruption //Why is it triggering DarkKitsune random event here????
					SceneLib.darkenedKitsuneScene.splitPersonalityLost(1)
					player.removePerk(PerkLib.DarkenedKitsune);
					outputText("<b>Lost Perk: Darkened Kitsune!</b>\n")
					flags[kFLAGS.DARKKITSUNE_WARN_INT] = 0;
					flags[kFLAGS.DARKKITSUNE_WARN_WIS] = 0;
					needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.DarkenedKitsune)){// Remove due to not kitsune
				SceneLib.darkenedKitsuneScene.splitPersonalityLost(2)
				player.removePerk(PerkLib.DarkenedKitsune);
				outputText("<b>Lost Perk: Darkened Kitsune!</b>\n")
				flags[kFLAGS.DARKKITSUNE_WARN_INT] = 0;
				flags[kFLAGS.DARKKITSUNE_WARN_WIS] = 0;
				needNext = true;
			}
			*/
			if (player.hasPerk(PerkLib.DarkenedKitsune)){ //Just in case someone else has it, this will remove it. No longer in use. Read above.
				player.removePerk(PerkLib.DarkenedKitsune);
			}
			//Kitsune energy thirst
			if (player.hasStatusEffect(StatusEffects.KitsuneEnergyThirstFeed)) {
				if (player.hunger < player.maxHunger()) {
					player.refillHunger(10, false);
				}
				if (player.HP < player.maxHP()) {
					EngineCore.HPChange(100 + (player.tou*2), true);
				}
				if (player.mana < player.maxMana()) {
					EngineCore.ManaChange(100 + (player.inte*2), true);
				}
				EngineCore.changeFatigue(-(100 + (player.spe*2)));
				if (player.soulforce < player.maxSoulforce()) {
					EngineCore.SoulforceChange(500 + (player.wis*2), true);
				}
				outputText("You feel energised and empowered by the life force drained out of the fluids of your recent blind date. What a meal!");
				player.removeStatusEffect(StatusEffects.KitsuneEnergyThirstFeed)
			}
			//Hydra heads
			if (player.lowerBody != LowerBody.HYDRA && player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
			//Greed Perk
			if (player.raccoonScore() >= 13 && !player.hasPerk(PerkLib.Greedy)) {
				outputText("\nYou are feeling absurdly lucky today so lucky there's no way fortune could turn against you. You nature as a tanuki has improved your ability to generate wealth, wherever there is more gems to make you will find and collect them. \n\n(<b>Gained Perk: Greedy</b>)");
				player.createPerk(PerkLib.Greedy, 0, 0, 0, 0);
				needNext = true;
			}
			//Lizan Regeneration perk
			if ((player.tailType == Tail.LIZARD && player.lowerBody == LowerBody.LIZARD && player.arms.type == Arms.LIZARD) || (!player.hasPerk(PerkLib.LizanRegeneration) && player.hasPerk(PerkLib.LizanMarrow))) { //Check for gain of lizan regeneration - requires legs, arms and tail
				if (!player.hasPerk(PerkLib.LizanRegeneration)) {
					outputText("\nAfter drinking the last drop of reptilium you starts to feel unusual feeling somewhere inside your body.  Like many tiny waves moving inside your veins making you feel so much more refreshed than moment ago.  Remembering about fact that lizans are so much similar to lizards and those usualy posses natural talent to regenerate from even sever injuries you quessing it's could be that.\n\n(<b>Gained Perk: Lizan Regeneration</b>)");
					player.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.tailType != Tail.LIZARD && player.lowerBody != LowerBody.LIZARD && player.arms.type != Arms.LIZARD && player.hasPerk(PerkLib.LizanRegeneration) && player.perkv4(PerkLib.LizanRegeneration) == 0 && !player.hasPerk(PerkLib.LizanMarrow)) { //Remove lizan regeneration perk if not meeting requirements && !player.hasPerk(PerkLib.HydraRegeneration)
				outputText("\nAll of sudden something change inside your body.  You think about a long while, until it dawned on you.  You can't feel that refreshing feeling inside your body anymore meaning for now just human rate of recovery from all kind of injuries.\n\n(<b>Lost Perk: Lizan Regeneration</b>)");
				player.removePerk(PerkLib.LizanRegeneration);
				needNext = true;
			}
			//Lustzerker perk
			if ((player.salamanderScore() >= 9 || player.phoenixScore() >= 10) && (!player.hasPerk(PerkLib.Lustzerker))) { //Check for gain of lustzerker - requires legs, arms and tail
				if (!player.hasPerk(PerkLib.Lustzerker)) {
					outputText("\nAfter drinking the last drop another hip flask of firewater you starts to feel a weird, maybe slightly unpleasant feeling inside your body.  Like many tiny flames cursing inside your veins making you ponder whats just happening with your body.  Remembering about salamanders natural talent to enter a berserk-like state you quess that should be it.\n\n(<b>Gained Perk: Lustzerker</b>)");
					player.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.salamanderScore() < 9 && player.phoenixScore() < 10 && player.hasPerk(PerkLib.Lustzerker) && player.perkv4(PerkLib.Lustzerker) == 0 && !player.hasPerk(PerkLib.SalamanderAdrenalGlands)) { //Remove lustzerker perk if not meeting requirements
				outputText("\nAll of sudden something change inside your body.  You think about a long while, until it dawned on you.  You can't feel that slight warm feeling inside your body anymore meaning for now no more lustzerking.\n\n(<b>Lost Perk: Lustzerker</b>)");
				player.removePerk(PerkLib.Lustzerker);
				needNext = true;
			}
			//Phantom Shooting perk
			if (player.poltergeistScore() >= 12 && !player.hasPerk(PerkLib.PhantomShooting)) {
				outputText("\n");
				if (player.weaponRangePerk == "Throwing" || player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") outputText("With your expanded otherworldly knowledge, a thought comes to mind. You apply your ghostly abilities to your " + player.weaponRangeName + " then "+(player.weaponRangePerk == "Throwing" ? "throw it":"shoot")+" at a nearby rock. You can feel a small piece of yourself leave, but the impact of your weapon all but shatters the rock. Using a bit of your ectoplasm instead of basic ammunition definitely made your " + player.weaponRangeName + " stronger.");
				else outputText("With your expanded otherworldly knowledge, a thought comes to mind. If you used some of your ectoplasm instead of basic ammunition for a firearm or throwing weapon, perhaps your weapons will have more of an impact.");
				outputText("\n\n(<b>Gained Perk: Phantom Shooting</b>)");
				player.createPerk(PerkLib.PhantomShooting, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.poltergeistScore() < 12 && player.hasPerk(PerkLib.PhantomShooting)) {// && !player.hasPerk(PerkLib.LizanMarrow)
				outputText("\nAs you become more corporeal again, the otherworldly knowledge you once held begins to fade along with your ectoplasm. Looks like it's back to using normal ammunition for your firearms and throwing weapons again...\n\n(<b>Lost Perk: Phantom Shooting</b>)");
				player.removePerk(PerkLib.PhantomShooting);
				needNext = true;
			}
			//Recharge tail
			if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTICORE_PUSSYTAIL || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SPIDER_FANGS) { //Spider, Bee, Scorpion, Manticore and Naga Venom Recharge
				if (player.tailRecharge < 5) player.tailRecharge = 5;
				if (player.hasPerk(PerkLib.ImprovedVenomGland)) player.tailRecharge += 5;
				if (player.hasPerk(PerkLib.VenomGlandsEvolved)) player.tailRecharge += 2;
				if (player.hasPerk(PerkLib.VenomGlandsFinalForm)) player.tailRecharge += 8;
				player.tailVenom += player.tailRecharge;
				if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
			}
			//Satyr Sexuality
			if (player.satyrScore() >= 4 && player.balls > 0) {
				if (!player.hasPerk(PerkLib.SatyrSexuality)) {
					outputText("\nYou feel a strange churning sensation in your [balls]. With you looking like a satyr, you have unlocked the potential to impregnate anally!\n\n(<b>Gained Perk: Satyr Sexuality</b>)\n");
					player.createPerk(PerkLib.SatyrSexuality, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.SatyrSexuality)) {
				outputText("\nWith some of your satyr-like traits gone, so does your ability to anally impregnate others.\n\n(<b>Lost Perk: Satyr Sexuality</b>)\n");
				player.removePerk(PerkLib.SatyrSexuality);
				needNext = true;
			}
			//DarkCharm
			if (player.demonScore() >= 6) {
				if (!player.hasPerk(PerkLib.DarkCharm)) {
					outputText("\nYou feel a strange sensation in your body. With you looking like a demon, you have unlocked the potential to use demonic charm attacks!\n\n(<b>Gained Perk: Dark Charm</b>)\n");
					player.createPerk(PerkLib.DarkCharm, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.DarkCharm) && player.perkv4(PerkLib.DarkCharm) == 0 && !player.hasPerk(PerkLib.BlackHeart)) {
				outputText("\nWith some of your demon-like traits gone, so does your ability to use charm attacks.\n\n(<b>Lost Perk: Dark Charm</b>)\n");
				player.removePerk(PerkLib.DarkCharm);
				needNext = true;
			}
			//Jungle’s Wanderer
			if (player.redpandaScore() >= 6) {
				if (!player.hasPerk(PerkLib.JunglesWanderer)) {
					//outputText("\nWhile stretching, you notice that you're much more flexible than you were before.  \n\n(<b>Gained Perk: Jungle’s Wanderer</b>)\n");
					player.createPerk(PerkLib.JunglesWanderer, 0, 0, 0, 0);
					//needNext = true;
				}
			}
			else if (player.hasPerk(PerkLib.JunglesWanderer) && player.redpandaScore() < 6) {
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
			if (player.eyes.type != Eyes.FENRIR && player.hasKeyItem("Gleipnir Collar") >= 0) {
				outputText("\nYou feel an icy chill run through your body as your divine nature reasserts itself over your body. You won't escape your destiny as the Fenrir so easily, it seems.");
				outputText("\n\nYou cry out in pain as your eyes once more freeze over, eventually settling back into their proper form. \"<b>You now have glowing icy eyes.</b>\"\n");
				CoC.instance.mutations.setEyeTypeAndColor(Eyes.FENRIR, "glacial blue");
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
			if (player.hasPerk(PerkLib.WhaleFat) && !player.hasPerk(PerkLib.ColdAffinity)) {
				outputText("\nYou suddenly no longer feel the cold thanks to your whale fat so you guess you finally got acclimated to the icy winds of the glacial rift. \n\n(<b>Gained Perks: Cold Affinity</b>)\n");
				player.createPerk(PerkLib.ColdAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.yetiScore() >= 6 && !player.hasPerk(PerkLib.ColdAffinity)) {
				outputText("\nYou suddenly no longer feel the cold so you guess you finally got acclimated to the icy winds of the glacial rift. You feel at one with the cold. So well that you actually developed icy power of your own.\n\n(<b>Gained Perks: Cold Affinity and Freezing Breath Yeti</b>)\n");
				player.createPerk(PerkLib.ColdAffinity, 0, 0, 0, 0);
				player.createPerk(PerkLib.FreezingBreathYeti, 0, 0, 0, 0);
				needNext = true;
			}
			if ((player.melkieScore() >= 8 || player.frostWyrmScore() >= 10) && !player.hasPerk(PerkLib.ColdAffinity)) {
				outputText("\nYou suddenly no longer feel the cold so you guess you finally got acclimated to the icy winds of the glacial rift. You feel at one with the cold. So well that you actually developed icy power of your own.\n\n(<b>Gained Perks: Cold Affinity</b>)\n");
				player.createPerk(PerkLib.ColdAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.yetiScore() < 6 && player.yukiOnnaScore() < 14 && player.melkieScore() < 8 && player.frostWyrmScore() < 10 && !player.hasPerk(PerkLib.WhaleFat) && player.hasPerk(PerkLib.ColdAffinity)) {
				outputText("\nYou suddenly feel a chill in the air. You guess you somehow no longer resist the cold.\n\n<b>(Lost Perks: Cold Affinity");
				player.removePerk(PerkLib.ColdAffinity);
				if (player.hasPerk(PerkLib.FreezingBreathYeti)){
					outputText(" and Freezing Breath Yeti");
					player.removePerk(PerkLib.FreezingBreathYeti);
				}
				outputText(")</b>\n");
				needNext = true;
			}
			if ((player.sirenScore() >=  10 || player.harpyScore() >=  8 || player.phoenixScore() >=  10 || player.thunderbirdScore() >=  10) && !player.hasPerk(PerkLib.HarpySong)) {
				outputText("\n Your voice sound like magicaly entrancing music to your ears now, it would seem you have gained the infamous magicaly compeling voices common to harpies. <b>Gained Perks: Harpy Song</b>)\n");
				player.createPerk(PerkLib.HarpySong, 0, 0, 0, 0);
				needNext = true;
			}
			//Compelling Aria
			if (player.tongue.type != Tongue.MELKIE && player.hasPerk(PerkLib.MelkieSong) && !player.hasPerk(PerkLib.MelkieLung)) {
				outputText("\n Your voice no longer carries the magical power it used to and thus you are no longer able to use your compelling aria. <b>Lost Perks: Melkie Song</b>)\n");
				player.removePerk(PerkLib.MelkieSong);
				needNext = true;
			}
			if (player.sirenScore() < 10 && player.harpyScore() < 8 && player.phoenixScore() < 10 && player.thunderbirdScore() <  10 && player.hasPerk(PerkLib.HarpySong) && !player.hasPerk(PerkLib.HarpyHollowBones)) {
				outputText("\n Your voice no longer carries the magical power it used to and thus you are no longer able to use your compelling aria. <b>Lost Perks: Harpy Song</b>)\n");
				player.removePerk(PerkLib.HarpySong);
				needNext = true;
			}
			//Icy flesh
			if (!player.hasPerk(PerkLib.IceQueenGown) && player.hasPerk(PerkLib.IcyFlesh) && player.yukiOnnaScore() < 14) {
				outputText("\nYour body slowly comes back to life as if it has been hibernating for a long time. You feel sickly as if dying, hungry as if you'd been starving for weeks and thirstier than if you'd been wandering the desert without drinks for about half as much.\n\n(<b>Lost Perks: "+((player.hasPerk(PerkLib.ColdAffinity) && player.yetiScore() < 6) ? "Cold Affinity, ":"")+"Dead metabolism and Icy flesh</b>)\n");
				if (player.hasPerk(PerkLib.ColdAffinity) && player.yetiScore() < 6) player.removePerk(PerkLib.ColdAffinity);
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
			if (player.kamaitachiScore() >=10 && !player.hasPerk(PerkLib.NaturalHerbalism)){
				outputText("\nGreat knowledges flows throught you mind as you become more Kamaitachi like. " +
						"It dawns on you that you have aquired a natural affinity for medicine and herbalism, " +
						"something your species is famous for, heck you can identify every single plant near your camp by name and species now. " +
						"<b>Gained Perk: Natural Herbalism</b>\n");
				player.createPerk(PerkLib.NaturalHerbalism, 0,0,0,0);
				needNext = true;
			}
			if (player.kamaitachiScore() <10 && player.hasPerk(PerkLib.NaturalHerbalism)){
				outputText("\nNo longer a Kamaitachi, you seem to have lost your knack for herbs and medicines. <b>Lost Perks: Natural Herbalism</b>)\n");
				player.removePerk(PerkLib.NaturalHerbalism);
				needNext = true;
			}
			//Aquatic Affinity
			if (InCollection(player.lowerBody,LowerBody.ORCA,LowerBody.SEADRAGON) && InCollection(player.arms.type,Arms.ORCA,Arms.SEADRAGON) && player.tailType == Tail.ORCA && InCollection(player.ears.type,Ears.ORCA,Ears.ORCA) && !player.hasPerk(PerkLib.AquaticAffinity)) {
				outputText("\nYou suddenly feel an urge to jump into the nearest pool of water as your breath becomes ragged and messy. You swiftly run up to the stream and scream in release as you fill your aching respiratory systems with water. Wait water? You realise you just gained the ability to breath underwater but to make sure you can still breath normal air you go back to the surface. It soon appears you can still breath fresh air. Reassured on your condition you head back to camp.\n");
				if (player.rearBody.type == RearBody.ORCA_BLOWHOLE) outputText("\nIt dawns on you that you didn't breath for a full hour. When you realise this you relax your blowhole and take in some air. Well wow it seems you can now hold in your oxigen for very lengthy period. This will be perfect for underwater explorations.\n");
				outputText("\n(<b>Gained Perk: Aquatic Affinity</b>)\n");
				player.createPerk(PerkLib.AquaticAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			else if ((!InCollection(player.lowerBody,LowerBody.ORCA,LowerBody.SEADRAGON) || !InCollection(player.arms.type,Arms.ORCA,Arms.SEADRAGON) || player.tailType != Tail.ORCA || !InCollection(player.ears.type,Ears.ORCA,Ears.ORCA)) && player.hasPerk(PerkLib.AquaticAffinity)) {
				outputText("\nAs you lose the respiratory organ to breath underwater it also becomes obvious that you will drown if attempting to breath water in. You will need to get items or transform to breath underwater again.\n");
				if (player.rearBody.type == RearBody.ORCA_BLOWHOLE) outputText("\nYou take a deep breath in then out. It seems you can no longer hold your breath like the whales do. It will take some using to.</b>\n");
				outputText("\n<b>(Lost Perk: Aquatic Affinity)</b>\n");
				player.removePerk(PerkLib.AquaticAffinity);
				needNext = true;
			}
			//Fire Affinity
			if ((player.salamanderScore() >= 4 || player.phoenixScore() >= 10 || player.hellcatScore() >= 10 || player.firesnailScore() >= 15 || (player.mouseScore() >= 12 && player.lowerBody == LowerBody.HINEZUMI && player.arms.type == Arms.HINEZUMI && player.tailType == Tail.HINEZUMI)) && !player.hasPerk(PerkLib.FireAffinity)) {
				outputText("\nYou suddenly feels your body temperature rising to ridiculus level. You pant for several minutes until you're finally at ease with your bodily heat. You doubt any more heat is going to make you more uncomfortable then this as you quietly soak in the soothing warmth your body naturally produce. It's like your body is made out of living fire.\n\n(<b>Gained Perk: Fire Affinity</b>)\n");
				player.createPerk(PerkLib.FireAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			else if ((player.salamanderScore() < 4 && player.phoenixScore() < 10 && player.hellcatScore() < 10 && player.firesnailScore() < 15 && player.mouseScore() < 12 && player.lowerBody != LowerBody.HINEZUMI && player.arms.type != Arms.HINEZUMI && player.tailType != Tail.HINEZUMI) && player.hasPerk(PerkLib.FireAffinity)) {
				outputText("\nYou suddenly feel chilly as your bodily temperature drop down to human level. You lost your natural warmth reverting to that of a standard human.\n\n<b>(Lost Perk: Fire Affinity)</b>\n");
				player.removePerk(PerkLib.FireAffinity);
				needNext = true;
			}
			//Lightning Affinity
			if ((player.leviathanScore() >= 20) && !player.hasPerk(PerkLib.LightningAffinity)) {
				outputText("\nYou suddenly feel a rush of electricity run across your skin as your biolight goes crazy! It would seem you gained the ability to generate and control electricity not unlike an electric eel or more specificaly a sea dragon\n");
				outputText("\n(<b>Gained the lightning affinity perk and Electric discharge ability!</b>)\n");
				player.createPerk(PerkLib.LightningAffinity, 0, 0, 0, 0);
				needNext = true;
			}
			if ((player.raijuScore() >= 7 || player.thunderbirdScore() >= 12) && !player.hasPerk(PerkLib.LightningAffinity)) {
				outputText("\nYou suddenly feel a rush of electricity run across your skin as your arousal builds up and begin to masturbate in order to get rid of your creeping desire. However even after achieving orgasm not only are you still aroused but you are even hornier than before! You realise deep down that the only way for you to be freed from this jolting pleasure is to have sex with a partner!\n");
				outputText("\n(<b>Gained the lightning affinity perk, electrified desire perk, Lightning claw perk, Pleasure bolt ability and Orgasmic lightning strike ability!</b>)\n");
				if (player.thunderbirdScore() >= 12) player.createStatusEffect(StatusEffects.IsThunderbird,0,0,0,0);
				if (player.raijuScore() >= 7) {
					player.createStatusEffect(StatusEffects.IsRaiju,0,0,0,0);
					player.createPerk(PerkLib.LightningClaw,0,0,0,0);
				}
				player.createPerk(PerkLib.LightningAffinity, 0, 0, 0, 0);
				player.createPerk(PerkLib.ElectrifiedDesire, 0, 0, 0, 0);
				needNext = true;
			}
			else if (player.raijuScore() < 7 && player.thunderbirdScore() < 12 && player.hasPerk(PerkLib.LightningAffinity) && player.hasStatusEffect(StatusEffects.IsRaiju) && !player.hasStatusEffect(StatusEffects.IsThunderbird)) {
				outputText("\nYour natural electricity production start dropping at a dramatic rate until finally there is no more. You realise you likely aren’t raiju enough to build electricity anymore which, considering you can reach satisfaction again, might not be a bad thing.\n\n<b>(Lost the lightning affinity perk, electrified desire perk, Lightning claw perk, Pleasure bolt ability and Orgasmic lightning strike ability!)</b>\n");
				player.removeStatusEffect(StatusEffects.IsRaiju);
				player.removePerk(PerkLib.LightningAffinity);
				player.removePerk(PerkLib.ElectrifiedDesire);
				player.removePerk(PerkLib.LightningClaw);
				needNext = true;
			}
			else if (player.thunderbirdScore() < 12 && player.hasPerk(PerkLib.LightningAffinity) && player.hasStatusEffect(StatusEffects.IsThunderbird) && !player.hasStatusEffect(StatusEffects.IsRaiju)) {
				outputText("\nYour natural electricity production starts dropping at a dramatic rate until finally there is no more. You realise you likely aren’t thunderbird enough to build electricity anymore which, considering you can reach satisfaction again, might not be a bad thing.\n\n<b>(Lost the lightning affinity perk, electrified desire perk, Lightning claw perk, Pleasure bolt ability and Orgasmic lightning strike ability!)</b>\n");
				player.removeStatusEffect(StatusEffects.IsThunderbird);
				player.removePerk(PerkLib.LightningAffinity);
				player.removePerk(PerkLib.ElectrifiedDesire);
				needNext = true;
			}
			else if (player.leviathanScore() < 20 && player.hasPerk(PerkLib.LightningAffinity) && !player.hasStatusEffect(StatusEffects.IsThunderbird) && !player.hasStatusEffect(StatusEffects.IsRaiju)) {
				outputText("\nYour natural electricity production starts dropping at a dramatic rate until finally there is no more. You realise you likely aren’t a sea dragon enough to build electricity anymore.\n\n<b>(Lost the lightning affinity perk and electric discharge ability!!)</b>\n");
				player.removePerk(PerkLib.LightningAffinity);
				needNext = true;
			}
			if (player.raijuScore() >= 7 && player.hasPerk(PerkLib.LightningAffinity) && !player.hasStatusEffect(StatusEffects.IsRaiju)) {
				player.createStatusEffect(StatusEffects.IsRaiju,0,0,0,0);
			}
			if (player.raijuScore() < 7 && player.hasStatusEffect(StatusEffects.IsThunderbird) && player.hasStatusEffect(StatusEffects.IsRaiju)) {
				player.removeStatusEffect(StatusEffects.IsRaiju);
			}
			if (player.thunderbirdScore() >= 12 && player.hasPerk(PerkLib.LightningAffinity) && !player.hasStatusEffect(StatusEffects.IsThunderbird)) {
				player.createStatusEffect(StatusEffects.IsThunderbird,0,0,0,0);
			}
			if (player.thunderbirdScore() < 12 && player.hasStatusEffect(StatusEffects.IsRaiju) && player.hasStatusEffect(StatusEffects.IsThunderbird)) {
				player.removeStatusEffect(StatusEffects.IsThunderbird);
			}/*
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
				outputText("\nGeeze, with those oversized hands and feet you should just drop your weapon and punch things out cold. Why do you even need a weapon for anyway?\n\n<b>(Lost the Big hand and feet perk!)</b>\n");
				player.createPerk(PerkLib.BigHandAndFeet, 0, 0, 0, 0);
				needNext = true;
			}
			if ((player.lowerBody != LowerBody.YETI || player.arms.type != Arms.YETI) && player.hasPerk(PerkLib.BigHandAndFeet)) {
				outputText("\nYour limbs are now back to their normal size, it might be smart to use a weapon over your bare hands and feet for fighting.\n\n<b>(Lost the Big hand and feet perk!)</b>\n");
				player.removePerk(PerkLib.BigHandAndFeet);
				needNext = true;
			}
			//Levitation wing slot
			if (player.rearBody.type != RearBody.GLACIAL_AURA && player.lowerBody != LowerBody.WENDIGO && player.lowerBody != LowerBody.GAZER && player.wings.type == Wings.LEVITATION) {
				player.wings.type == Wings.NONE;
				player.wings.desc = "non-existant";
			}
			//Wendigo stuff
			if (player.hasStatusEffect(StatusEffects.WendigoPsychosis) && !player.hasPerk(PerkLib.EndlessHunger) && ((flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger <= 0) || (flags[kFLAGS.HUNGER_ENABLED] <= 0 && player.lust >= player.maxLust()))) SceneLib.glacialRift.wendigoScene.becomeWendigo();
			//Gazer perks
			if (player.eyes.type == Eyes.MONOEYE && !player.hasPerk(PerkLib.TrueSeeing)) {
				outputText("\nAs part of acquiring an all seeing eye your sight has improved greatly. It would seem you now possess the innate ability to dismiss illusions and falsehood seeing the world as it truly is. <b>You acquired True Seeing.</b> \n\n(<b>Gained Perk: True seeing</b>)");
				player.createPerk(PerkLib.TrueSeeing, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.eyes.type != Eyes.MONOEYE && player.hasPerk(PerkLib.TrueSeeing)) {
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
				outputText("\nNo text yet. \n\n(<b>Lost Perk: Omnicaster</b>)");
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
			if ((player.eyes.type != Eyes.ELF || player.ears.type != Ears.ELVEN) && player.hasPerk(PerkLib.ElvenSense) && !player.hasPerk(PerkLib.ElvishPeripheralNervSys)) {
				outputText("\nYou feels yourself less aware of your surroundings. Heck your vision seems less keen then it used to be. Most likely because you no longer possess the senses of an elf.\n\n<b>(Lost the Elven Sense perk!)</b>\n");
				player.removePerk(PerkLib.ElvenSense);
				needNext = true;
			}
			//Flawless Body
			if ((player.lowerBody != LowerBody.ELF || player.arms.type != Arms.ELF || !player.hasPlainSkinOnly() || player.skinAdj != "flawless") && player.hasPerk(PerkLib.FlawlessBody)) {
				outputText("\nYour body has becomes less alluring and graceful as part of reverting to a more mundane appearance.\n\n<b>(Lost the Flawless Body perk and the perfect skin!)</b>\n");
				player.removePerk(PerkLib.FlawlessBody);
				player.skin.setBaseOnly({type: Skin.PLAIN, adj:""});
				needNext = true;
			}
			//Ferocity
			if (player.orcScore() < 11 && player.hasPerk(PerkLib.Ferocity) && !player.hasPerk(PerkLib.OrcAdrenalGlandsFinalForm)) {
				outputText("\nYour natural ferocity starts vanishing at a dramatic rate until finally there is no more. You realise you likely aren’t orc enough anymore, considering you felt so invincible with it, which might not be a good thing.\n\n<b>(Lost the Ferocity perk!)</b>\n");
				player.removePerk(PerkLib.Ferocity);
				needNext = true;
			}
			//Acid Spit and Azureflame Breath
			if (player.cavewyrmScore() < 7 && player.hasPerk(PerkLib.AcidSpit) && player.hasPerk(PerkLib.AzureflameBreath)) {// && !player.hasPerk(PerkLib.)
				outputText("\nAs you become less of a cave wyrm your spit and fluids begins to lose their acidic properties until its back to being ordinary drool and fluids. With no acid to ignite it seems you also lost the ability to breath fire.\n\n<b>(Lost the Acid Spit and Azureflame Breath perks!)</b>\n");
				player.removePerk(PerkLib.AcidSpit);
				player.removePerk(PerkLib.AzureflameBreath);
				needNext = true;
			}
			//Titanic Strength
			if ((player.hydraScore() >= 14 || player.oniScore() >= 12 || player.orcaScore() >= 17 || player.scyllaScore() >= 12 || player.frostWyrmScore() >= 10 || player.cyclopScore() >= 12 || player.leviathanScore() >= 20) && player.tallness >= 80 && !player.hasPerk(PerkLib.TitanicStrength)) {
				outputText("\nWhoa, you've grown so big its a sheer miracle you don't damage the landscape while moving. That said, your size now contributes to your strength as well.\n\n<b>(Gained Titanic Strength perk!)</b>\n");
				player.createPerk(PerkLib.TitanicStrength, 0, 0, 0, 0);
				needNext = true;
			}
				if (((player.hydraScore() < 14 && player.oniScore() < 12 && player.orcaScore() < 17 && player.scyllaScore() < 12 && player.frostWyrmScore() < 10 && player.cyclopScore() < 12 && player.leviathanScore() < 20) || player.tallness < 80) && player.hasPerk(PerkLib.TitanicStrength)) {
				if (player.tallness < 80) outputText("\nYou sadly are no longer able to benefit from your size as much as you did before. Probably because you have shrunk to a smaller size.\n\n<b>(Lost the Titanic Strength perk!)</b>\n");
				else outputText("\nYou sadly are no longer able to benefit from your size as much as you did before. Probably because you have transformed again.\n\n<b>(Lost the Titanic Strength perk!)</b>\n");
				player.removePerk(PerkLib.TitanicStrength);
				needNext = true;
			}
			//VerdantMight
			if ((player.plantScore() >= 11 || player.alrauneScore() >= 11) && !player.hasPerk(PerkLib.VerdantMight)) {
				outputText("\nRaw green power flows throught your veins while being a plant hasnt done so much to improve your muscle your general sturdyness more then makes up for it allowing you to use your toughness instead of your strength when delivering blows. \n\n<b>(gained the Verdant Might perk!)</b>\n");
				player.createPerk(PerkLib.VerdantMight,0,0,0,0);
				needNext = true;
			}
			if (player.plantScore() < 11 && player.alrauneScore() < 11 && player.hasPerk(PerkLib.VerdantMight)) {
				outputText("\nBeing less of a plant you loose the ability to add your own sturdyness to your attacks.\n\n<b>(Lost the Verdant Might perk!)</b>\n");
				player.removePerk(PerkLib.VerdantMight);
				needNext = true;
			}
			//Enigma
			if (player.sphinxScore() >= 14 && !player.hasPerk(PerkLib.Enigma)) {
				outputText("\nBeing a sphinx has granted you insight on many things including various secrets to martial combat, guess this is what they mean about using your smarts before your brawn.\n\n<b>(Gained Enigma perk!)</b>\n");
				player.createPerk(PerkLib.Enigma, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.sphinxScore() < 14 && player.hasPerk(PerkLib.Enigma)) {
				outputText("\nAs you no longer possess the insight of a sphinx you no longer have the ability to fully use your smarts to improve your martial prowess.\n\n<b>(Lost the Enigma perk!)</b>\n");
				player.removePerk(PerkLib.Enigma);
				needNext = true;
			}
			//Lacta bovine immunities
			if (player.cowScore() >= 10 && !player.hasPerk(PerkLib.LactaBovineImmunity)) {
				outputText("\nAs you become more of a lacta bovine you become increasingly obsessed with thoughts of horsecocks and cum sloshing balls, namely minotaur balls. While you are aware you naturally became addicted to minotaur cum you also know your nature as a lacta bovine will protect you from most of its harmful effects allowing you to sample the substance to your heart's content without risks.");
				outputText(".\n\n<b>(Gained the Lacta Bovine Immunity perk!)</b>\n");
				player.createPerk(PerkLib.LactaBovineImmunity, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.cowScore() < 10 && player.hasPerk(PerkLib.LactaBovineImmunity)) {
				outputText("\nYour mind clears up as you cease to obsess over minotaur dicks. This is also a sign that you are no longer considered a cow enough to be immune to the addictive effects of minotaur cum.\n\n<b>(Lost the Lacta Bovine Immunity perk!)</b>\n");
				player.removePerk(PerkLib.LactaBovineImmunity);
				needNext = true;
			}
			//Bull Strength
			if ((player.minotaurScore() >= 15 || player.cowScore() >= 15) && !player.hasPerk(PerkLib.BullStrength)) {
				outputText("\nWhoa, you feel tremendous power accumulate in ");
				if (player.minotaurScore() >= 15) outputText("your balls. It fills your body with bovine strength, nourishing your muscles with manly power. They say having big balls makes you stronger... Well its not like you can deny the correlation anymore!");
				if (player.cowScore() >= 15) outputText("your mammaries. It fills your body with bovine strength, nourishing your muscles with milky power. Talk about storing all your might into your jugs!");
				outputText(".\n\n<b>(Gained Bull Strength perk!)</b>\n");
				player.createPerk(PerkLib.BullStrength, 0, 0, 0, 0);
				needNext = true;
			}
			if ((player.minotaurScore() < 15 && player.cowScore() < 15) && player.hasPerk(PerkLib.BullStrength)) {
				outputText("\nYou feel weaker, it looks like you lost the benefit of your bull strength. Probably because you are no longer bovine enough.\n\n<b>(Lost the Bull Strength perk!)</b>\n");
				player.removePerk(PerkLib.BullStrength);
				needNext = true;
			}
			//Soul Sense
			if (player.maxSoulforce() >= 200 && player.hasPerk(PerkLib.SoulApprentice) && !player.hasPerk(PerkLib.SoulSense)) {
				outputText("\nDuring a casual walk around your camp you suddenly notice, or rather feel, something unexpected. Your surrounding blurs for a moment, to be replaced with a forest. You notice a goblin strolling nearby. Suddenly, she stops and slowly looks around, staring directly at you. A moment later, your vision of the forest becomes blurry, eventually fading away to be replaced by your camp and its surroundings. ");
				outputText("You shake your head, trying to figure out what had just happened. The only solution that you find within yourself is something that the soul cultivators you met in He’Xin’Dao mentioned. Another sense that they had developed, which allowed them to perceive distant places or find specific people over long distances. It looks as though you developed it, even without training.\n");
				player.createPerk(PerkLib.SoulSense, 0, 0, 0, 0);
				needNext = true;
			}
			//Hinezumi Coat
			if (player.mouseScore() >= 12 && player.lowerBody == LowerBody.HINEZUMI && player.arms.type == Arms.HINEZUMI && player.tailType == Tail.HINEZUMI && !player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				outputText("\nYour body suddenly coats itself with fire turning incandescent as your lust and body heat spikes up reaching a critical point, this must be the infamous hinezumi coat. You gasp as your lust reaches a critical point. The flare of desire burns in you and you need to vent it one way or another. ");
				outputText("Feeling inspired you try and expel it through kick and punch on a tree and indeed it works the more you discharge your flames the clearer your mind get. Your hinezumi coat finally stable you sigh in relief.\n\n<b>(Gained Hinezumi Coat!)</b>\n");
				player.createStatusEffect(StatusEffects.HinezumiCoat, 1, 0, 0, 0);
				needNext = true;
			}
			if (player.mouseScore() < 12 && (player.lowerBody != LowerBody.HINEZUMI || player.arms.type != Arms.HINEZUMI || player.tailType != Tail.HINEZUMI) && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				outputText("\nFor one reason or another your inner flames suddenly die down leaving you penting but clear of mind. Seems you no longer are hinezumi enough for the coat to maintain itself.\n\n<b>(Lost the Hinezumi Coat!)</b>\n");
				player.removeStatusEffect(StatusEffects.HinezumiCoat);
				needNext = true;
			}
			//Goblinoid blood & Bouncy body & goblin mechs periodical check up
			if ((player.isGoblinoid()) && !player.hasPerk(PerkLib.GoblinoidBlood)) {
				outputText("\nAs you become a goblinoid again you can feel the chemicals pumped in by your gadgets resume working.\n");
				outputText("\n(<b>Gained Perk: Goblinoid blood</b>)\n");
				if (player.hasKeyItem("Drug injectors")){
					player.statStore.replaceBuffObject({'sens':5,'lib.mult':0.25},'DrugInjector',{text:'Drug injectors'})
				}
				if (player.hasKeyItem("Improved Drug injectors")){
					player.statStore.replaceBuffObject({'sens':10,'lib.mult':0.50},'DrugInjector',{text:'Improved Drug injectors'})
				}
				if (player.hasKeyItem("Potent Drug injectors")){
					player.statStore.replaceBuffObject({'sens':15,'lib.mult':0.75},'DrugInjector',{text:'Potent Drug injectors'})
				}
				if (player.hasKeyItem("Power bracer") >= 0) {
					player.statStore.replaceBuffObject({'str.mult':0.50},'Power bracer',{text:'Power bracer'})
				}
				if (player.hasKeyItem("Powboy") >= 0) {
					player.statStore.replaceBuffObject({'str.mult':0.75},'Power bracer',{text:'Powboy'})
				}
				if (player.hasKeyItem("M.G.S. bracer") >= 0) {
					player.statStore.replaceBuffObject({'str.mult':1},'Power bracer',{text:'M.G.S. bracer'})
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
			else if ((!player.isGoblinoid()) && player.hasPerk(PerkLib.BouncyBody) && !player.hasPerk(PerkLib.NaturalPunchingBagFinalForm)) {
				outputText("\nYou're not as cushiony as you used to be. Better avoid getting hit.\n");
				outputText("\n<b>(Lost Perk: Bouncy body)</b>\n");
				player.removePerk(PerkLib.BouncyBody);
				needNext = true;
			}
			if (player.vehiclesName == "Goblin Mech Alpha" && (player.elfScore() >= 11 || player.tallness > 48 || player.tailType != Tail.NONE || player.wings.type != Wings.NONE)) { //Elf OR Taller than 4 ft or having wings/tail
				if (player.elfScore() >= 11) outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
				else outputText("Your current anatomy or size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
				if (player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) player.HP /= 1.2;
				if (player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) player.HP /= 1.35;
				if (player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) player.HP /= 1.5;
				player.HP = Math.round(player.HP);
				player.setVehicle(VehiclesLib.NOTHING);
				inventory.takeItem(vehicles.GOBMALP, null);
				needNext = true;
			}
			if (player.vehiclesName == "Goblin Mech Prime" && (player.elfScore() >= 11 || player.tallness > 48 || player.tailType != Tail.NONE || player.wings.type != Wings.NONE)) { //Elf OR Taller than 4 ft or having wings/tail
				if (player.elfScore() >= 11) outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
				else outputText("Your current anatomy or size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
				if (player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) player.HP /= 1.4;
				if (player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) player.HP /= 1.7;
				if (player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) player.HP /= 2;
				player.HP = Math.round(player.HP);
				player.setVehicle(VehiclesLib.NOTHING);
				inventory.takeItem(vehicles.GOBMPRI, null);
				needNext = true;
			}
			if (player.vehiclesName == "Giant Slayer Mech" && (player.elfScore() >= 11 || player.tallness > 48 || player.tailType != Tail.NONE || player.wings.type != Wings.NONE)) { //Elf OR Taller than 4 ft or having wings/tail
				if (player.elfScore() >= 11) outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
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
			//H class Heaven Tribulation
			//		if (player.level >= 24 && player.hasPerk(PerkLib.SoulApprentice) && !player.hasStatusEffect(StatusEffects.TribulationCountdown) && !player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) {
			//			outputText("\nPLACEHOLDER TEXT 1\n");
			//			player.createStatusEffect(StatusEffects.TribulationCountdown, 25, 0, 0, 0);
			//			needNext = true;
			//		}
			//		if (player.hasStatusEffect(StatusEffects.TribulationCountdown)) {
			//			if (player.statusEffectv1(StatusEffects.TribulationCountdown) <= 1 && !player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) {
			//				player.removeStatusEffect(StatusEffects.TribulationCountdown);
			//				outputText("\nAN ENDURANCE FIGHT STARTS HERE\n");
			//				startCombat(new HclassHeavenTribulation());
			//	needNext = true;
			//			}
			//	else if (player.statusEffectv1(StatusEffects.TribulationCountdown) <= 1 && !player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) {
			//		player.removeStatusEffect(StatusEffects.TribulationCountdown);
			//		outputText("\nYou feel a tingling in your nethers... at last full sensation has returned to your groin.  <b>You can masturbate again!</b>\n");
			//		needNext = true;
			//	}
			//			else player.addStatusValue(StatusEffects.TribulationCountdown, 1, -1);
			//		}
			//Hot Spring
			if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 1 && rand(4) == 0) {
				outputText("\nWhile wandering around the border of your camp, you randomly kick a rock and a stream of water sprays out. Surprised, you touch the water, discovering it to be startlingly hot. An idea comes to your mind. You get a shovel, digging around the fountaining water which soon turns into a small pool. This is the perfect place to build a hot spring. You smile, delighted at the idea of being able to take frequent baths in it! You resolve to get to work as soon as possible.");
				flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS]++;
				needNext = true;
			}
			//Marae corrupted or killed + Zenji
			if (flags[kFLAGS.ZENJI_PROGRESS] == 11 && (flags[kFLAGS.MET_MARAE_CORRUPTED] >= 1 || flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) && !ZenjiScenes.ZenjiMarae) {
				outputText("\nZenji approaches you, \"<i>[name]. I.. I felt someting, not long ago. Someting terrible has happened, I feel it deep within me.</i>\"");
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
				outputText("\nYou suddently feel like your mind is clear of the constant haze of lust and hunger for the first time since you had that tail. Losing it was perhaps for the best.\n");
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
				outputText("\nYou suddently feel like your mind is clear of the constant haze of lust and hunger for the first time since you had these tentacles. Losing them was perhaps for the best.\n");
				player.removePerk(PerkLib.DisplacerMilkAddict);
				needNext = true;
			}
			//Vampire Thirst
			if (player.faceType == Face.VAMPIRE && !player.hasStatusEffect(StatusEffects.VampireThirst)) {
				outputText("\nAn ominous thirst settle in your throat as you begin to hallucinate glasses of blood... how delicious it would feel on your palates. You realise you are salivating and do your best to control yourself. Still you now are clearly dependant on blood.\n");
				player.createStatusEffect(StatusEffects.VampireThirst, 0, 0, 0, 0);
				needNext = true;
			}
			if (player.faceType != Face.VAMPIRE && player.hasStatusEffect(StatusEffects.VampireThirst) && !player.hasPerk(PerkLib.HollowFangs)) {
				outputText("\nAs your fang disappear so do your vampiric urges. You become disgusted with yourself as you realise how much blood you drank.\n");
				player.removeStatusEffect(StatusEffects.VampireThirst);
				needNext = true;
			}
			//Loosing hellcat body parts
			if (player.hellcatScore() >= 10 && flags[kFLAGS.WITCHES_SABBATH] > 1) {
				var hellcatparts:Number = 3;
				if (player.tailType != Tail.BURNING && player.tailType != Tail.TWINKASHA) hellcatparts -= 1;
				if (player.hairType != Hair.BURNING) hellcatparts -= 1;
				if (player.eyes.type != Eyes.INFERNAL) hellcatparts -= 1;
				if (hellcatparts < 3) {
					outputText("\nAs you become less of a hellcat your inner fire entirely dies down, your body reverting to that of a standard feline.\n");
					if (player.tailType == Tail.BURNING || player.tailType == Tail.TWINKASHA) player.tailType = Tail.CAT;
					if (player.hairType == Hair.BURNING) player.hairType = Hair.NORMAL;
					if (player.eyes.type == Eyes.INFERNAL) player.eyes.type = Eyes.CAT_SLITS;
					if (flags[kFLAGS.WITCHES_SABBATH] > 1) flags[kFLAGS.WITCHES_SABBATH] = 1;
					needNext = true;
				}
			}
			//Reset bad end warning
			if (flags[kFLAGS.FOX_BAD_END_WARNING] == 1) {
				if (player.faceType != Face.FOX || player.tailType != Tail.FOX || player.ears.type != Ears.FOX || player.lowerBody != LowerBody.FOX || player.skinType != Skin.FUR) {
					flags[kFLAGS.FOX_BAD_END_WARNING] = 0;
				}
			}
			if (flags[kFLAGS.PIG_BAD_END_WARNING] == 1) {
				if (player.faceType != Face.PIG || player.tailType != Tail.PIG || player.ears.type != Ears.PIG || player.lowerBody != LowerBody.CLOVEN_HOOFED) {
					flags[kFLAGS.PIG_BAD_END_WARNING] = 0;
				}
			}
			if (flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] >= 100 && !player.hasPerk(PerkLib.BasiliskResistance)) {
				if (player.hasPerk(PerkLib.GorgonsEyes)) outputText("\nYou notice that you feel a bit stiff and your skin is a bit harder.  Something clicks in your mind as you finally unlock the potential to protect yourself from the goddamn basilisks! \n\n(<b>Gained Perk: Basilisk Resistance - You are now immune to the basilisk's gaze!</b>)\n");
				else outputText("\nYou notice that you feel a bit stiff and your skin is a bit harder.  Something clicks in your mind as you finally unlock the potential to protect yourself from the goddamn basilisks! \n\n(<b>Gained Perk: Basilisk Resistance - Your maximum speed is permanently decreased but you are now immune to the basilisk's gaze!</b>)\n");
				player.createPerk(PerkLib.BasiliskResistance, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.TIMES_TRANSFORMED] >= 25 && !player.hasPerk(PerkLib.GeneticMemory)) {
				outputText("\nYour body behave weirdly as if all the transformation, which you have undergone started to make it unsure about what it truly is. Sometime you even try to move limbs that are no longer there. Suddenly you realise that no mather how many time you change your body remembers it. Your body developed genetic memory! \n\n(<b>Gained Perk: Genetic Memory</b>)\n");
				player.createPerk(PerkLib.GeneticMemory, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.TIMES_TRANSFORMED] >= 100 && !player.hasPerk(PerkLib.TransformationResistance)) {
				outputText("\nYou feel a strange tingling sensation. It seems as if you've finally adapted to the transformative properties of the food in Mareth and your body has finally built up enough resistance! You suspect that you can still transform but at somewhat diminished rate. \n\n(<b>Gained Perk: Transformation Resistance - Transformative items now have less chance to transform you. In addition, any Bad Ends related to overdose of certain transformative items are now disabled.</b>)\n");
				player.createPerk(PerkLib.TransformationResistance, 0, 0, 0, 0);
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
			var bicornColorPalette:Array = ["black", "midnight black", "midnight"];
			var bicornHairPalette:Array = ["silver","black", "midnight black", "midnight"];
			if ((player.horns.type == Horns.BICORN || player.horns.type == Horns.UNICORN) && player.cor > 89 && !player.hasPerk(PerkLib.AvatorOfCorruption)) {
				outputText("\nA sudden wave of pleasure strike you making you moan");
				if (player.horns.type == Horns.UNICORN) {
					outputText(" as your horn begins to split in two");
					player.horns.type = Horns.BICORN;
					if (player.hasPerk(PerkLib.GeneticMemory) && !player.hasStatusEffect(StatusEffects.UnlockedBicornHorns)) {
						outputText("\n\n<b>Genetic Memory: Bicorn Horns - Memorized!</b>\n\n");
						player.createStatusEffect(StatusEffects.UnlockedBicornHorns, 0, 0, 0, 0);
					}
				}
				if (!InCollection(player.hairColor, bicornHairPalette)) {
					CurentColor = randomChoice(bicornHairPalette);
					outputText(" You feel a tingling in your hairs as the strands turns "+CurentColor+".");
					player.hairColor = CurentColor;
				}
				if (!InCollection(player.coatColor, bicornColorPalette)) {
					CurentColor = randomChoice(bicornColorPalette);
					outputText(" Your fur tingle and you coo in delight as it turn "+CurentColor+".");
					player.coatColor = CurentColor;
				}
				if (player.eyes.colour != "red") {
					outputText(" Meanwhile your eyes shine with malice as they take on a red corrupted tone reflecting the sorry state of your soul.");
					player.eyes.colour = "red";
				}
				if (player.wings.type == Wings.FEATHERED_ALICORN) {
					outputText(" Your wings aren’t spared either all the feather falling off to reveal a membranous demonic pair of bat wings.");
					player.wings.type = Wings.NIGHTMARE;
					if (player.hasPerk(PerkLib.GeneticMemory) && !player.hasStatusEffect(StatusEffects.UnlockedNightmareWings)) {
						outputText("\n\n<b>Genetic Memory: Nightmare Wings - Memorized!</b>\n\n");
						player.createStatusEffect(StatusEffects.UnlockedNightmareWings, 0, 0, 0, 0);
					}
				}
				outputText(" <b>You giggle in delight of your own corruption as you fall from grace into a ");
				if (player.wings.type == Wings.NIGHTMARE) outputText("nightmare");
				else outputText("bicorn");
				outputText(". Mighty magical power start to swell in the twin horns on your forehead, washing away whats left of any purity you may have, and you will gladly use them to despoil and tarnish anything pure or innocent left on mareth.</b>\n");
				if (player.hasPerk(PerkLib.AvatorOfPurity)) player.removePerk(PerkLib.AvatorOfPurity);
				player.createPerk(PerkLib.AvatorOfCorruption, 0, 0, 0, 0);
				player.createPerk(PerkLib.AuraOfCorruption, 0, 0, 0, 0);
				if(player.hasPerk(PerkLib.AuraOfPurity)) player.removePerk(PerkLib.AuraOfPurity);
				player.cor = 100;
				needNext = true;
			}
			//Fixing wings
			if (player.horns.type == Horns.BICORN && player.wings.type == Wings.FEATHERED_ALICORN) {
				outputText("\nYour wings changes as all the feather falling off to reveal a membranous demonic pair of bat wings.\n");
				player.wings.type = Wings.NIGHTMARE;
				if (player.hasPerk(PerkLib.GeneticMemory) && !player.hasStatusEffect(StatusEffects.UnlockedNightmareWings)) {
					outputText("\n\n<b>Genetic Memory: Nightmare Wings - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedNightmareWings, 0, 0, 0, 0);
				}
				needNext = true;
			}
			//Losing horn
			if (player.hasPerk(PerkLib.AvatorOfCorruption) && player.cor > 10 && player.horns.type != Horns.BICORN) {
				outputText("\n<b>Without your horns, the magic power they once granted withers and dies, vanishing completely.</b>\n");
				player.removePerk(PerkLib.AvatorOfCorruption);
				if (!player.hasPerk(PerkLib.EclipticMind))
				{
					player.removePerk(PerkLib.AuraOfCorruption);
				}
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
					if (player.hasPerk(PerkLib.GeneticMemory) && !player.hasStatusEffect(StatusEffects.UnlockedUnicornHorn)) {
						outputText("\n\n<b>Genetic Memory: Unicorn Horn - Memorized!</b>\n\n");
						player.createStatusEffect(StatusEffects.UnlockedUnicornHorn, 0, 0, 0, 0);
					}
				}
				if (!InCollection(player.hairColor, unicornHairPalette)) {
					CurentColor = randomChoice(unicornHairPalette);
					outputText(" You feel a tingling in your hairs as the strands turns "+CurentColor+".");
					player.hairColor = CurentColor;
				}
				if (!InCollection(player.coatColor, unicornColorPalette)) {
					CurentColor = randomChoice(unicornColorPalette);
					outputText(" You sigh in relief as your fur turns "+CurentColor+".");
					player.coatColor = CurentColor;
				}
				if (player.eyes.colour != "blue") {
					outputText(" Meanwhile your irises shift toward the sapphire blue as your mind clears off.");
					player.eyes.colour = "blue";
				}
				if (player.wings.type == Wings.NIGHTMARE) {
					outputText(" Your wings also redeem themselves changing into a pair of angelic wings covered with white feathers.");
					player.wings.type = Wings.FEATHERED_ALICORN;
					if (player.hasPerk(PerkLib.GeneticMemory) && !player.hasStatusEffect(StatusEffects.UnlockedAlicornWings)) {
						outputText("\n\n<b>Genetic Memory: Alicorn Wings - Memorized!</b>\n\n");
						player.createStatusEffect(StatusEffects.UnlockedAlicornWings, 0, 0, 0, 0);
					}
				}
				outputText(" <b>You laugh heartily at your unblemish pure form as you realise you are an ");
				if (player.wings.type == Wings.FEATHERED_ALICORN) outputText("alicorn");
				else outputText("unicorn");
				outputText(" now. Mighty magical power start to swell in the horn on your forehead, cleansing whats left of any corruption you may have, and you will gladly use them to fight off the corruption that plagues mareth.</b>\n");
				if (player.hasPerk(PerkLib.AvatorOfCorruption)) player.removePerk(PerkLib.AvatorOfCorruption);
				player.createPerk(PerkLib.AvatorOfPurity, 0, 0, 0, 0);
				player.createPerk(PerkLib.AuraOfPurity, 0, 0, 0, 0);
				if(player.hasPerk(PerkLib.AuraOfCorruption)) player.removePerk(PerkLib.AuraOfCorruption);
				player.cor = 0;
				needNext = true;
			}
			if (player.horns.type == Horns.UNICORN && player.wings.type == Wings.NIGHTMARE) {
				outputText("\nYour wings redeem themselves changing into a pair of angelic wings covered with white feathers.\n");
				player.wings.type = Wings.FEATHERED_ALICORN;
				if (player.hasPerk(PerkLib.GeneticMemory) && !player.hasStatusEffect(StatusEffects.UnlockedAlicornWings)) {
					outputText("\n\n<b>Genetic Memory: Alicorn Wings - Memorized!</b>\n\n");
					player.createStatusEffect(StatusEffects.UnlockedAlicornWings, 0, 0, 0, 0);
				}
				needNext = true;
			}
			if (player.hasPerk(PerkLib.AvatorOfPurity) && player.cor < 90 && player.horns.type != Horns.UNICORN) {
				outputText("\n<b>Without your horn, the magic power it once granted withers and dies, vanishing completely.</b>\n");
				player.removePerk(PerkLib.AvatorOfPurity);
				if (!player.hasPerk(PerkLib.EclipticMind))
				{
					player.removePerk(PerkLib.AuraOfPurity);
				}
				needNext = true;
			}
			//Switch Aura Based On Alignment
			if ((player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN) && player.cor > 89 && player.hasPerk(PerkLib.EclipticMind) && player.hasPerk(PerkLib.AuraOfPurity)) {
				outputText("\nA dramatic change in your alignment has altered your formerly pure aura into one of corruption\n");
				player.removePerk(PerkLib.AuraOfPurity);
				player.createPerk(PerkLib.AuraOfCorruption, 0, 0, 0, 0);
				needNext = true;
			}
			if ((player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN) && player.cor < 20 && player.hasPerk(PerkLib.EclipticMind) && player.hasPerk(PerkLib.AuraOfCorruption)) {
				outputText("\nA dramatic change in your alignment has altered your formerly corrupt aura into one of purity\n");
				player.removePerk(PerkLib.AuraOfCorruption);
				player.createPerk(PerkLib.AuraOfPurity, 0, 0, 0, 0);
				needNext = true;
			}
			//Remove Bullshit
			if ((player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN) && (player.hasPerk(PerkLib.AuraOfPurity) || player.hasPerk(PerkLib.AuraOfCorruption)) && !player.hasPerk(PerkLib.EclipticMind)) {
				outputText("\nNo idea how you got this weird aura about you but whatever the reason why you had it its gone now.\n");
				player.removePerk(PerkLib.AuraOfPurity);
				player.removePerk(PerkLib.AuraOfCorruption);
				needNext = true;
			}
			//Harpy
			if ((player.lowerBody == LowerBody.HARPY || player.lowerBody == LowerBody.SALAMANDER) && (player.tailType == Tail.HARPY || player.tailType == Tail.THUNDERBIRD || player.tailType == Tail.SALAMANDER) && player.hasPerk(PerkLib.HarpyWomb)) { //Make eggs big if harpied!
				if (player.hasStatusEffect(StatusEffects.Eggs) && player.statusEffectv2(StatusEffects.Eggs) == 0) {
					player.changeStatusValue(StatusEffects.Eggs, 2, 1);
					outputText("\n<b>A familiar, motherly rumble lets you know that your harpy-like womb is growing your eggs nice and large.</b>\n");
					needNext = true;
				}
			}
			//Pregomania
			if(player.isPregnant() && (player.isHarpy() || player.isGoblinoid()) && !player.statStore.hasBuff("Pregomania")){
				player.statStore.removeBuffs("Impregnate me!!!");
				player.statStore.addBuffObject({"tou.mult":0.20,"lib.mult":0.20}, "Pregomania",{text:"Your motherly instincs gives you increased resiliance and resolve."});
				outputText("\nYou pat your belly in motherly delight instinctively knowing that you have been impregnated. Your body seldom radiates motherly wellbeing making you hardyer in order to protect your beloved children to be.\n");
			}
			if(!player.isPregnant() && (player.isHarpy() || player.isGoblinoid()) && player.statStore.hasBuff("Pregomania")){
				player.statStore.removeBuffs("Pregomania");
				outputText("\nNo longuer pregnant you feel a void in your belly as the need to be impregnated again claw at your mind.\n");
				player.statStore.addBuffObject({lib:50}, "Impregnate me!!!",{text:"You strongly desire to be impregnated."});

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
			if (!Holidays.isHalloween() && flags[kFLAGS.ZENJI_PROGRESS] == 11 && player.statusEffectv4(StatusEffects.ZenjiZList) == 2 && rand(5) < 2) {
				SceneLib.zenjiScene.loverZenjiHalloweenEventEnding();
				needNext = true;
			}
			if (player.pregnancyIncubation <= 0 && player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) { //Fixing Egg Preg Preglocked Glitch
				player.knockUpForce(); //Clear Pregnancy
			}
			if (player.hasStatusEffect(StatusEffects.Uniball) && player.ballSize > 1 && player.balls > 0) { //Testicles Normalise:
				outputText("\nYou feel a deep sensation of release around your genitals.  You sigh with relief and contentment as your testicles drop downwards and bloom outwards, heat throbbing within them as they split and form a proper ballsack.\n");
				player.removeStatusEffect(StatusEffects.Uniball);
				needNext = true;
			}
			if (!player.hasPerk(PerkLib.Androgyny)) { //Fix femininity ratings if out of whack!
				var textHolder:String = player.fixFemininity();
				if (textHolder != "") {
					outputText(textHolder);
					needNext = true;
				}
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
					player.dynStats("lus", 20);
					if (player.lust > player.maxLust()) player.lust = player.maxLust();
				}
				if (player.statusEffectv1(StatusEffects.Luststick) <= 0) {
					player.removeStatusEffect(StatusEffects.Luststick);
					dynStats("lib=", flags[kFLAGS.LUSTSTICK_LIBIDO_INITIAL]);
					outputText("\n<b>The lust-increasing effects of harpy lipstick have worn off!\n</b>");
					needNext = true;
				}
			}
			if (player.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285] >= 50 && !player.hasPerk(PerkLib.LuststickAdapted)) { //Luststick resistance unlock
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
			if (player.hasPerk(PerkLib.SpiderOvipositor) || player.hasPerk(PerkLib.BeeOvipositor) || player.hasPerk(PerkLib.MantisOvipositor)) { //Spider, Bee and Mantis ovipositor updates
				if (player.hasPerk(PerkLib.SpiderOvipositor) && (!player.isDrider() || player.tailType != Tail.SPIDER_ADBOMEN)) { //Remove dat shit!
					outputText("\n<b>Your ovipositor (and eggs) vanish since your body has become less spider-like.</b>\n");
					player.removePerk(PerkLib.SpiderOvipositor);
					needNext = true;
				}
				else if (player.hasPerk(PerkLib.BeeOvipositor) && player.tailType != Tail.BEE_ABDOMEN) { //Remove dat shit!
					outputText("\n<b>Your ovipositor (and eggs) vanish since your body has become less bee-like.</b>\n");
					player.removePerk(PerkLib.BeeOvipositor);
					needNext = true;
				}
				else if (player.hasPerk(PerkLib.MantisOvipositor) && player.tailType != Tail.MANTIS_ABDOMEN) { //Remove dat shit!
					outputText("\n<b>Your ovipositor (and eggs) vanish since your body has become less mantis-like.</b>\n");
					player.removePerk(PerkLib.MantisOvipositor);
					needNext = true;
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
						else {
							outputText("\nYour bee half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its sweet, slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...");
						}
						outputText("\n\n<b>Minimum Lust raised!</b>\n");
						player.dynStats("spe", -1);
						needNext = true;
					}
				}
			}
			if (player.hasPerk(PerkLib.Oviposition) || player.hasPerk(PerkLib.BunnyEggs)) { //Oviposition perk for lizard and bunny folks
				if ((player.nagaScore() + player.lizardScore() < 3) && player.hasPerk(PerkLib.Oviposition) && !player.hasPerk(PerkLib.BasiliskWomb)) { //--Lose Oviposition perk if lizard score gets below 3.
					outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost a little bit of reptilian reproductive ability.\n(<b>Perk Lost: Oviposition</b>)\n");
					player.removePerk(PerkLib.Oviposition);
					needNext = true;
				}
				else if (player.bunnyScore() < 3 && player.hasPerk(PerkLib.BunnyEggs)) { //--Lose Oviposition perk if bunny score gets below 3.
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
					if (player.statStore.hasBuff("ShiraOfTheEastFoodBuff") >= 1) {
						var tempStrength:int = player.statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2);
						player.statStore.removeBuffs("ShiraOfTheEastFoodBuff");
					}
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
					player.dynStats("lus", 2 + rand(15));
					if (player.lust >= player.maxLust()) {
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
            else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 2 && CoC.instance.model.time.hours % 13 == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] == 0) { //Repeated warnings!
                if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2)
					outputText("\n<b>You shiver, feeling a little cold. Maybe you ought to get some more minotaur cum? You just don't feel right without that pleasant buzz in the back of your mind.</b>\n");
				else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3)
					outputText("\n<b>The steady fire of lust within you burns hot, making you shiver and grab at your head. You're STILL in withdrawal after having gone so long without a dose of minotaur love.  You just know you're going to be horny and achy until you get some.</b>\n");
				needNext = true;
			}
			//Decrement mino withdrawal symptoms display cooldown
			//flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] prevents PC getting two of the same notices overnite
			else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330]--;
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
					player.createCock();
					player.cocks[0].cockLength = 10;
					player.cocks[0].cockThickness = 2.75;
					outputText("\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, 10-inch cock pulses happily.");
					if (player.balls == 0) {
						outputText("  A pair of heavy balls drop into place below it, churning to produce cum.");
						player.balls = 2;
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
					player.balls = 2;
					player.ballSize = 3;
					needNext = true;
				}
				if (player.breastRows[0].breastRating < 5) { //Tits!
					player.breastRows[0].breastRating = 5;
					if (player.hasPerk(PerkLib.FutaFaculties))
						outputText("\n<b>Your tits get nice and full again.  You'll have lots of fun now that your breasts are back to being big, swollen knockers!</b>\n");
					else outputText("\n<b>Your " + player.breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n");
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
					player.dynStats("int", -1);
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
					player.createCock();
					player.cocks[0].cockLength = 10;
					player.cocks[0].cockThickness = 2.75;
					outputText("\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, 10-inch cock pulses happily.");
					if (player.balls == 0) {
						outputText("  A pair of heavy balls drop into place below it, churning to produce cum.");
						player.balls = 2;
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
					player.balls = 2;
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
			//Elf training reset
			if (WoodElves.hasTrainedToday) {
				WoodElves.hasTrainedTodayCooldown -= 1
				if (WoodElves.hasTrainedTodayCooldown == 0)
				{
					WoodElves.hasTrainedToday = false;
				}
			}
			//Wrap it up
			return needNext;
		}

		private var LunaFullMoonScene: Boolean = false;

		public function timeChangeLarge():Boolean {
            if (rand(4) == 0 && Holidays.isHolidays() && player.gender > 0 && camp.IsSleeping && flags[kFLAGS.XMAS_CHICKEN_YEAR] < CoC.instance.date.fullYear) {
                Holidays.getAChristmasChicken();
                return true;
			}
            if (camp.IsSleeping && Holidays.isHolidays() && CoC.instance.date.fullYear > flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE]) { //XMAS ELF
                Holidays.xmasBitchEncounter(); //Set it to remember the last year encountered
                return true;
			}
            if (checkedTurkey++ == 0 && (rand(5) == 0 && (CoC.instance.model.time.hours == 18 || CoC.instance.model.time.hours == 19)) && (CoC.instance.date.fullYear > flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] || flags[kFLAGS.MORE_TURKEY] > 0) && Holidays.isThanksgiving() && player.gender > 0 && flags[kFLAGS.IN_INGNAM] <= 0) {
                Holidays.datTurkeyRumpMeeting(); //TURKEY SURPRISE
                return true;
			}

			if (LunaFullMoonScene){
				if (camp.IsSleeping)
				{
					SceneLib.lunaFollower.fullMoonEvent();
				}
				else
				{
					SceneLib.lunaFollower.fullMoonEvent(true);
				}
				LunaFullMoonScene = false;
				return true;
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

					outputText("\n\nYour antennae.type bob - was that someone?  Peering between the trees from the corner of your eye, you can see the figure of another person, and you intensify your hypnotic buzz, trying to draw it closer.  The figure steps into your clearing and out of the shadow; clad in [armor], " + player.mf("he","she") + " is yourself!  Confused, you stop humming and stare into your own face, and the other you takes the opportunity to open " + player.mf("his","her") + " garments, exposing " + player.mf("his","her") + " [cock]!");

					outputText("\n\nStartled, you slip down from your seat and try to run, but the other you has already crossed the clearing and seizes you by the fuzz on your hefty, swollen abdomen; your leg slips, propelling you face-first to the ground.  " + player.mf("He","She") + " pulls you back toward " + player.mf("his","her") + "self and, grabbing one of your chitinous legs, turns you over.  The other you spreads your fuzzed thighs, revealing your soft, wet pussy, and the sweet smell of honey hits your noses.  " + player.mf("His","Her") + " prick hardens intensely and immediately at the aroma of your pheromone-laden nectar, and " + player.mf("he","she") + " pushes it into you without so much as a word of apology, groaning as " + player.mf("he","she") + " begins to rut you mercilessly.  You can feel the sensations of " + player.mf("his","her") + " burning cock as if it were your own, and your legs wrap around your other self instinctively even as your mind recoils in confusion.");

					outputText("\n\nThe other you grunts and locks up as " + player.mf("his","her") + "... your [cock] begins to spurt inside your honey-drooling cunt, and " + player.mf("he","she") + " falls onto you, bottoming out inside; your vagina likewise clenches and squirts your sweet juices.  As " + player.mf("he","she") + " ejaculates, thrusting weakly, you can feel something shifting in you, filling you with pins and needles... it feels like the warm cum " + player.mf("he","she") + "'s filling you with is permeating your entire groin, working its way back toward your abdomen.  It edges up to your massive buildup of eggs, and your body tightens in a second climax at the thought of having your children fertilized-");

					outputText("\n\nYou snap awake, sitting bolt upright.  What in the name of... your [cocks] is softening rapidly, and as you shift, you can feel your cum sloshing in your [armor].  For fuck's sake.");
					if (player.cumQ() >= 1000) outputText("  It's completely soaked your bedroll, too... you won't be sleeping on this again until you wash it out.  Grumbling, you roll the soggy, white-stained fabric up and stow it.");
					outputText("  The sensation of wetness inside your own clothes torments you as you try to return to sleep, driving up your lust and making you half-hard once again... the rumbling of eggs in your abdomen, as if they're ready to be laid, doesn't help either.");
					player.fertilizeEggs(); //convert eggs to fertilized based on player cum output, reduce lust by 100 and then add 20 lust
					player.orgasm(); //reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
					player.dynStats("lus", 20);
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
					player.dynStats("lus", 20);
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
					player.dynStats("lus", 20);
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
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] < 4) { //Dominika Dream
					outputText("\n<b>Your rest is somewhat troubled with odd dreams...</b>\n");
                    SceneLib.telAdre.dominika.fellatrixDream();
                    return true;
				}
                if (SceneLib.anemoneScene.kidAXP() >= 40 && flags[kFLAGS.HAD_KID_A_DREAM] == 0 && player.gender > 0) {
                    SceneLib.anemoneScene.kidADreams();
                    flags[kFLAGS.HAD_KID_A_DREAM] = 1;
					return true;
				}
				if (player.viridianChange()) {
					dreams.fuckedUpCockDreamChange();
					return true;
				}
				if (player.plantScore() >= 4 && player.hasPerk(PerkLib.SoulSense) && flags[kFLAGS.SOUL_SENSE_WORLD_TREE] < 1) {
					outputText("\nYou find yourself in a forest. You feel a delicate melody fill the air around you, and while it has no discernable sound it somehow resonates with your being. Without even realizing it, you find yourself walking towards the source. Before long, you’re standing before a towering goliath of a tree, much larger than the others around you. As you touch the bark, you hear a soft voice. “Welcome home”. You bolt awake, and realize it was but a dream.  But somehow, you still feel the song whispering in your mind... <b>Perhaps you could seek out this tree in the waking world?</b>");
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
				if (player.lib > 50 || player.lust > 40) { //Randomly generated dreams here
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
			if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE && player.lust >= player.maxLust()) {
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