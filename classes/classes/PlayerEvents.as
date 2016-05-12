package classes {
	
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	
	public class PlayerEvents extends BaseContent implements TimeAwareInterface {
		//Handles all timeChange events for the player. Needed because player is not unique.
		
		public function PlayerEvents():void {
			CoC.timeAwareClassAdd(this);
		}
		
		private var checkedTurkey:int; //Make sure we test each of these events just once in timeChangeLarge
		private var checkedDream:int;
		private var displayedBeeCock:Boolean;
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean {
			var needNext:Boolean = false;
			checkedTurkey = 0;
			checkedDream = 0;
			
			if (player.cumMultiplier > 19999) player.cumMultiplier = 19999;
			if (player.ballSize > 400) player.ballSize = 400;
			var maxSlots:int = inventory.getMaxSlots();
			player.itemSlot4.unlocked = maxSlots >= 4;
			player.itemSlot5.unlocked = maxSlots >= 5;
			player.itemSlot6.unlocked = maxSlots >= 6;
			player.itemSlot7.unlocked = maxSlots >= 7;
			player.itemSlot8.unlocked = maxSlots >= 8;
			player.itemSlot9.unlocked = maxSlots >= 9;
			player.itemSlot10.unlocked = maxSlots >= 10;
			if (flags[kFLAGS.SOCK_COUNTER] > 0) {
				flags[kFLAGS.SOCK_COUNTER]--;
				if (flags[kFLAGS.SOCK_COUNTER] < 0) flags[kFLAGS.SOCK_COUNTER] = 0;
				if (flags[kFLAGS.SOCK_COUNTER] > 24) flags[kFLAGS.SOCK_COUNTER] = 24;
			}
			if (flags[kFLAGS.HUNGER_ENABLED] <= 0 || (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger >= 10)) { //If you're starving, your cum won't build up over time.
				player.hoursSinceCum++;
				//Super cumbuilding activate!
				if (player.findPerk(PerkLib.MaraesGiftProfractory) >= 0) player.hoursSinceCum += 2;
				if (player.findPerk(PerkLib.FerasBoonAlpha) >= 0) player.hoursSinceCum += 2;
			}
			//Normal
			if (player.findPerk(PerkLib.WellAdjusted) < 0) {
				dynStats("lus", player.lib * 0.04, "resisted", false); //Raise lust
				if (player.findPerk(PerkLib.Lusty) >= 0) dynStats("lus", player.lib * 0.02, "resisted", false); //Double lust rise if lusty.
			}
			else { //Well adjusted perk
				dynStats("lus", player.lib * 0.02, "resisted", false); //Raise lust
				if (player.findPerk(PerkLib.Lusty) >= 0) dynStats("lus", player.lib * 0.01, "resisted", false); //Double lust rise if lusty.
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
			if (player.armor == armors.DBARMOR)
			{
				dynStats("cor", -0.1);
			}
			//Hunger! No effect if hunger is disabled, even if your hunger is at 0/100.
			if (flags[kFLAGS.HUNGER_ENABLED] > 0 || prison.inPrison) {
				var multiplier:Number = 1.0
				if (player.findPerk(PerkLib.Survivalist) >= 0) multiplier -= 0.2;
				if (player.findPerk(PerkLib.Survivalist2) >= 0) multiplier -= 0.2;
				//Hunger drain rate. If above 50, 1.5 per hour. Between 25 and 50, 1 per hour. Below 25, 0.5 per hour.
				//So it takes 100 hours to fully starve from 100/100 to 0/100 hunger. Can be increased to 125 then 166 hours with Survivalist perks.
				if (prison.inPrison) {
					player.hunger -= (2 * multiplier); //Hunger depletes faster in prison.
				}
				else {
					if (player.hunger > 80) player.hunger -= (0.5 * multiplier); //If satiated, depletes at 2 points per hour.
					if (player.hunger > 50) player.hunger -= (0.5 * multiplier);
					if (player.hunger > 25) player.hunger -= (0.5 * multiplier);
					if (player.hunger > 0) player.hunger -= (0.5 * multiplier);
				}
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_GOO_STUFFED) player.hunger = 100; //After Valeria x Goo Girl, you'll never get hungry until you "birth" the goo-girl.
				if (player.hunger <= 0)
				{
					if (prison.inPrison) {
						kGAMECLASS.prison.changeWill(-1, prison.inPrison);
						player.changeFatigue(2);
					}
					else {
						//Lose HP and makes fatigue go up. Lose body weight and muscles.
						if (player.thickness < 25) {
							player.takeDamage(player.maxHP() / 25);
							player.changeFatigue(2);
							dynStats("str", -0.5);
							dynStats("tou", -0.5);
						}
						else if ((model.time.hours + 2) % 4 == 0) { //Lose thickness 2x as fast.
							player.modThickness(1, 1);
							player.modTone(1, 1);
						}
					}
					player.hunger = 0; //Prevents negative
				}
				else {
					kGAMECLASS.prison.changeWill((player.esteem / 50) + 1);
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
			if (kGAMECLASS.valeria.valeriaFluidsEnabled()) {
				if (flags[kFLAGS.VALERIA_FLUIDS] > 0) {
					flags[kFLAGS.VALERIA_FLUIDS]--;
				}
				else if (player.armor == armors.GOOARMR) {
					dynStats("lus", 2 + (player.lib / 10), "resisted", false);
					needNext = true;
				}
				if (flags[kFLAGS.VALERIA_FLUIDS] > 100) flags[kFLAGS.VALERIA_FLUIDS] = 100;
			}
			//Recharge tail
			if (player.tailType == TAIL_TYPE_BEE_ABDOMEN || player.tailType == TAIL_TYPE_SPIDER_ADBOMEN || player.tailType == TAIL_TYPE_SCORPION) { //Spider and Bee Sting Recharge
				if (player.tailRecharge < 5) player.tailRecharge = 5;
				player.tailVenom += player.tailRecharge;
				if (player.tailVenom > 100) player.tailVenom = 100;
			}
			//Flexibility perk
			if (player.tailType == TAIL_TYPE_CAT && player.lowerBody == LOWER_BODY_TYPE_CAT && player.earType == EARS_CAT) { //Check for gain of cat agility - requires legs, tail, and ears
				if (player.findPerk(PerkLib.Flexibility) < 0) {
					outputText("\nWhile stretching, you notice that you're much more flexible than you were before.  Perhaps this will make it a bit easier to dodge attacks in battle?\n\n(<b>Gained Perk: Flexibility</b>)\n");
					player.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.findPerk(PerkLib.Flexibility) >= 0 && player.perkv4(PerkLib.Flexibility) == 0) { //Remove flexibility perk if not meeting requirements
				outputText("\nYou notice that you aren't as flexible as you were when you had a more feline body.  It'll probably be harder to avoid your enemies' attacks now.\n\n(<b>Lost Perk: Flexibility</b>)\n");
				player.removePerk(PerkLib.Flexibility);
				needNext = true;
			}
			//Lustzerker perk
			if (player.tailType == TAIL_TYPE_SALAMANDER && player.lowerBody == LOWER_BODY_TYPE_SALAMANDER && player.armType == ARM_TYPE_SALAMANDER) { //Check for gain of lustzerker - requires legs, arms and tail
				if (player.findPerk(PerkLib.Lustzerker) < 0) {
					outputText("\nAfter drinking to the last drop another hip flask of firewater you starts to feel weird maybe slight unpleasant feeling inside your body.  Like many tiny flames cursing inside your veins making you ponder what just happening with your body.  Remembering about salamanders natural talent to enter berserk-like state you quessing it's could be that.\n\n(<b>Gained Perk: Lustzerker</b>)");
					player.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.findPerk(PerkLib.Lustzerker) >= 0 && player.perkv4(PerkLib.Lustzerker) == 0) { //Remove lustzerker perk if not meeting requirements
				outputText("\nAll of sudden something change inside your body.  You think about a long while, until it dawned on you.  You can't feel that slight warm feeling inside your body anymore meaning for now no more lustzerking.\n\n(<b>Lost Perk: Lustzerker</b>)");
				player.removePerk(PerkLib.Lustzerker);
				needNext = true;
			}
			//Satyr Sexuality
			if (player.satyrScore() >= 4 && player.balls > 0) {
				if (player.findPerk(PerkLib.SatyrSexuality) < 0) {
					outputText("\nYou feel a strange churning sensation in your [balls]. With you looking like a satyr, you have unlocked the potential to impregnate anally!\n\n(<b>Gained Perk: Satyr Sexuality</b>)\n");
					player.createPerk(PerkLib.SatyrSexuality, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (player.findPerk(PerkLib.SatyrSexuality) >= 0 && player.perkv4(PerkLib.SatyrSexuality) == 0) { 
				outputText("\nWith some of your satyr-like traits gone, so does your ability to anally impregnate others.\n\n(<b>Lost Perk: Satyr Sexuality</b>)\n");
				player.removePerk(PerkLib.SatyrSexuality);
				needNext = true;
			}
			//Reset bad end warning
			if (flags[kFLAGS.FOX_BAD_END_WARNING] == 1) {
				if (player.faceType != FACE_FOX || player.tailType != TAIL_TYPE_FOX || player.earType != EARS_FOX || player.lowerBody != LOWER_BODY_TYPE_FOX || player.skinType != SKIN_TYPE_FUR) {
					flags[kFLAGS.FOX_BAD_END_WARNING] = 0;
				}
			}
			/*if (flags[kFLAGS.PIG_BAD_END_WARNING] == 1) {
				if (player.faceType != FACE_PIG || player.tailType != TAIL_TYPE_PIG || player.earType != EARS_PIG || player.lowerBody != LOWER_BODY_TYPE_CLOVEN_HOOFED) {
					flags[kFLAGS.PIG_BAD_END_WARNING] = 0;
				}
			}*/
			if (flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] >= 100 && player.findPerk(PerkLib.BasiliskResistance) < 0) {
				outputText("\nYou notice that you feel a bit stiff and your skin is a bit harder.  Something clicks in your mind as you finally unlock the potential to protect yourself from the goddamn basilisks! \n\n(<b>Gained Perk: Basilisk Resistance - Your maximum speed is permanently decreased but you are now immune to the basilisk's gaze!</b>)\n");
				player.createPerk(PerkLib.BasiliskResistance, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.TIMES_TRANSFORMED] >= 100 && player.findPerk(PerkLib.TransformationResistance) < 0) {
				outputText("\nYou feel a strange tingling sensation. It seems as if you've finally adapted to the transformative properties of the food in Mareth and your body has finally built up enough resistance! You suspect that you can still transform but at somewhat diminished rate. \n\n(<b>Gained Perk: Transformation Resistance - Transformative items now have less chance to transform you. In addition, any Bad Ends related to overdose of certain transformative items are now disabled.</b>)\n");
				player.createPerk(PerkLib.TransformationResistance, 0, 0, 0, 0);
			}
			if ((player.findPerk(PerkLib.EnlightenedNinetails) >= 0 && player.perkv4(PerkLib.EnlightenedNinetails) == 0) || (player.findPerk(PerkLib.CorruptedNinetails) >= 0 && player.perkv4(PerkLib.CorruptedNinetails) == 0)) { //Check ninetails perks!
				if (player.tailType != TAIL_TYPE_FOX || player.tailVenom < 9) {
					outputText("\n<b>Without your tails, the magic power they once granted withers and dies, vanishing completely.</b>\n");
					if (player.perkv4(PerkLib.EnlightenedNinetails) == 0) player.removePerk(PerkLib.EnlightenedNinetails);
					if (player.perkv4(PerkLib.CorruptedNinetails) == 0) player.removePerk(PerkLib.CorruptedNinetails);
					needNext = true;
				}
			}
			if (player.lowerBody == LOWER_BODY_TYPE_HARPY && player.tailType == TAIL_TYPE_HARPY && player.findPerk(PerkLib.HarpyWomb) >= 0) { //Make eggs big if harpied!
				if (player.findStatusEffect(StatusEffects.Eggs) >= 0 && player.statusEffectv2(StatusEffects.Eggs) == 0) {
					player.changeStatusValue(StatusEffects.Eggs, 2, 1);
					outputText("\n<b>A familiar, motherly rumble lets you know that your harpy-like womb is growing your eggs nice and large.</b>\n");
					needNext = true;
				}
			}
			if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE) { //All the hourly bee cock checks except the 'seek out the bee girl' check. That's in timeChangeLarge
				if (player.cocks.length > 1) {
					outputText("\nYou feel a stickiness and some stinging from your cocks.  It seems your bee cock has absorbed your new addition, leaving no trace of it.\n");
					while (player.cocks.length > 1) player.removeCock(1, 1);
				}
				if (player.cocks[0].cockLength < 25 || player.cocks[0].cockThickness < 4) {
					outputText("\nYour " + player.cockDescript(0) + " quivers for a moment before growing slightly ");
					if (player.cocks[0].cockLength < 25 && player.cocks[0].cockThickness < 4)
						outputText("longer and thicker");
					else outputText(player.cocks[0].cockLength < 25 ? "longer again" : "wider again");
					outputText(", a bit of pain passing through you at the same time.  It looks like your bee cock won’t get any smaller.\n");
					player.cocks[0].cockLength = Math.max(player.cocks[0].cockLength, 25);
					player.cocks[0].cockThickness = Math.max(player.cocks[0].cockThickness, 4);
				}
				if (player.findPerk(PerkLib.WellAdjusted) >= 0) dynStats("lust", 5); //Reduced to 5 with 'Well Adjusted' perk.
				else dynStats("lust", 10); //Always gain 10 lust each hour
				needNext = true;
			}
			if (!player.hasVagina() && player.findPerk(PerkLib.Diapause) >= 0) { //Lose diapause
				outputText("\n<b>With the loss of your womb, you lose your kangaroo-like diapause ability.</b>\n");
				player.removePerk(PerkLib.Diapause);
				needNext = true;
			}
			if (player.lowerBody == LOWER_BODY_TYPE_NAGA) {
				if (player.tailType > TAIL_TYPE_NONE) {
					outputText("\nYour tail squirms, wriggling against your larger naga tail as the scales part around it, absorbing it.  <b>Your form is completely scaly and smooth from the waist down.</b>\n");
					player.tailType = TAIL_TYPE_NONE;
					needNext = true;
				}
			}
			if (player.findPerk(PerkLib.WetPussy) >= 0 && player.hasVagina()) {
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) {
					outputText("\n<b>Your " + player.vaginaDescript(0) + " returns to its normal, wet state.</b>\n");
					player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
					needNext = true;
				}
			}
			if (player.findPerk(PerkLib.MaraesGiftButtslut) >= 0 && player.ass.analWetness < 2) { //Prevent Buttsluts from getting dry backdoors
				outputText("\n<b>Your " + player.assholeDescript() + " quickly re-moistens.  It looks like Marae's 'gift' can't be removed.</b>\n");
				player.ass.analWetness = 2;
				needNext = true;
			}
			if (player.pregnancyIncubation <= 0 && player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) { //Fixing Egg Preg Preglocked Glitch
				player.knockUpForce(); //Clear Pregnancy
			}
			if (player.findStatusEffect(StatusEffects.Uniball) >= 0 && player.ballSize > 1 && player.balls > 0) { //Testicles Normalise:
				outputText("\nYou feel a deep sensation of release around your genitals.  You sigh with relief and contentment as your testicles drop downwards and bloom outwards, heat throbbing within them as they split and form a proper ballsack.\n");
				player.removeStatusEffect(StatusEffects.Uniball);
				needNext = true;
			}		
			if (player.findPerk(PerkLib.Androgyny) < 0) { //Fix femininity ratings if out of whack!
				var textHolder:String = player.fixFemininity();
				if (textHolder != "") {
					outputText(textHolder, false);
					needNext = true;
				}
			}
			if (player.findStatusEffect(StatusEffects.LustStickApplied) >= 0) { //Lust stick!
				player.addStatusValue(StatusEffects.LustStickApplied, 1, -1); //Decrement!
				if (player.statusEffectv1(StatusEffects.LustStickApplied) <= 0) {
					player.removeStatusEffect(StatusEffects.LustStickApplied);
					outputText("<b>\nYour drugged lipstick fades away, leaving only the faintest residue on your lips.  You'll have to put on more if you want to be able to kiss your foes into submission!</b>\n");
				}
			}
			if (player.findStatusEffect(StatusEffects.Luststick) >= 0) { //Luststic countdown
				player.addStatusValue(StatusEffects.Luststick, 1, -1);
				if (rand(2) == 0 && player.hasCock()) { //50% chance to lust spike
					//Display if haven't displayed
					if (player.flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED] == 0) {
						outputText("\nYour body tingles, practically a slave to the effects of harpy lipstick.  Blood surges to " + player.sMultiCockDesc() + ", making you groan out loud with forced pleasure.  Unasked-for fantasies assault you, and you spend a few moments fantasizing about fucking feathery women before you come to your senses.\n");
						flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED]++;
						needNext = true;
					}
					getGame().dynStats("lus", 20);
					if (player.lust > player.maxLust()) player.lust = player.maxLust();
				}
				if (player.statusEffectv1(StatusEffects.Luststick) <= 0) {
					player.removeStatusEffect(StatusEffects.Luststick);
					dynStats("lib=", flags[kFLAGS.LUSTSTICK_LIBIDO_INITIAL]);
					outputText("\n<b>The lust-increasing effects of harpy lipstick have worn off!\n</b>");
					needNext = true;
				}
			}
			if (player.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285] >= 50 && player.findPerk(PerkLib.LuststickAdapted) < 0) { //Luststick resistance unlock
				getGame().sophieBimbo.unlockResistance();
				if (player.findStatusEffect(StatusEffects.Luststick) >= 0) player.removeStatusEffect(StatusEffects.Luststick);
				needNext = true;
			}
			if (flags[kFLAGS.DICK_EGG_INCUBATION] > 0) {
				flags[kFLAGS.DICK_EGG_INCUBATION]--;
				trace("DICK BIRTH TIMER: " + flags[kFLAGS.DICK_EGG_INCUBATION]);
				if (flags[kFLAGS.DICK_EGG_INCUBATION] == 1) {
					getGame().masturbation.birthBeeEggsOutYourWang();
					needNext = true;
				}
			}
			if (player.findStatusEffect(StatusEffects.Eggchest) >= 0) { //Eggs in tits!
				player.addStatusValue(StatusEffects.Eggchest, 1, -1);
				if (player.statusEffectv1(StatusEffects.Eggchest) <= 0) {
					outputText("\n<b>You feel the rounded eggs within your [fullChest] vanishing, absorbed into your body.  </b>");
					player.growTits(player.statusEffectv2(StatusEffects.Eggchest), player.bRows(), true, 2);
					outputText("\n");	
					player.removeStatusEffect(StatusEffects.Eggchest);
					needNext = true;
				}
			}
			if (player.findPerk(PerkLib.SpiderOvipositor) >= 0 || player.findPerk(PerkLib.BeeOvipositor) >= 0) { //Spider and Bee ovipositor updates
				if (player.findPerk(PerkLib.SpiderOvipositor) >= 0 && (!player.isDrider() || player.tailType != TAIL_TYPE_SPIDER_ADBOMEN)) { //Remove dat shit!
					outputText("\n<b>Your ovipositor (and eggs) vanish since your body has become less spider-like.</b>\n");
					player.removePerk(PerkLib.SpiderOvipositor);
					needNext = true;
				}
				else if (player.findPerk(PerkLib.BeeOvipositor) >= 0 && player.tailType != TAIL_TYPE_BEE_ABDOMEN) { //Remove dat shit!
					outputText("\n<b>Your ovipositor (and eggs) vanish since your body has become less bee-like.</b>\n");
					player.removePerk(PerkLib.BeeOvipositor);
					needNext = true;
				}
				else { //Update stuff!
					var prevEggs:int = player.eggs();
					if (prevEggs < 10) {
						player.addEggs(2);
					}
					else if (prevEggs < 20 && getGame().model.time.hours % 2 == 0) {
						player.addEggs(1);
					}
					else if (getGame().model.time.hours % 4 == 0) {
						player.addEggs(1);
					}
					if (prevEggs < 10 && player.eggs() >= 10) { //Stage 1 egg message
						if (player.findPerk(PerkLib.SpiderOvipositor) >= 0) {
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
						if (player.findPerk(PerkLib.SpiderOvipositor) >= 0) {
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
						if (player.findPerk(PerkLib.SpiderOvipositor) >= 0) {
							outputText("\nYour lower half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...\n\n<b>Minimum Lust raised!</b>\n");
						}
						else {
							outputText("\nYour bee half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its sweet, slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...\n");
						}
						getGame().dynStats("spe", -1);
						needNext = true;
					}
				}
			}
			if (player.findPerk(PerkLib.Oviposition) >= 0 || player.findPerk(PerkLib.BunnyEggs) >= 0) { //Oviposition perk for lizard and bunny folks
				if ((player.nagaScore() + player.lizardScore() < 3) && player.findPerk(PerkLib.Oviposition) >= 0 && player.findPerk(PerkLib.BasiliskWomb) < 0) { //--Lose Oviposition perk if lizard score gets below 3.
					outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost a little bit of reptilian reproductive ability.\n(<b>Perk Lost: Oviposition</b>)\n");
					player.removePerk(PerkLib.Oviposition);
					needNext = true;
				}
				else if (player.bunnyScore() < 3 && player.findPerk(PerkLib.BunnyEggs) >= 0) { //--Lose Oviposition perk if bunny score gets below 3.
					outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost your ability to spontaneously lay eggs.\n(<b>Perk Lost: Bunny Eggs</b>)\n");
					player.removePerk(PerkLib.BunnyEggs);
					needNext = true;
				}
				else if (player.pregnancyIncubation < 1 && player.hasVagina() && getGame().model.time.hours == 1) { //Otherwise pregger check, once every morning
					if ((player.totalFertility() > 50 && getGame().model.time.days % 15 == 0) || getGame().model.time.days % 30 == 0) { //every 15 days if high fertility get egg preg
						outputText("\n<b>Somehow you know that eggs have begun to form inside you.  You wonder how long it will be before they start to show?</b>\n");
						player.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS, 1, 1);
						player.createStatusEffect(StatusEffects.Eggs, rand(6), rand(2), (5 + rand(3)), 0); //v1 is type, v2 is size (1 == large) and v3 is quantity
						player.addPerkValue(PerkLib.Oviposition, 1, 1); //Count times eggpregged this way in perk.
						needNext = true;
					}
				}
			}
			if (player.inHeat) { //Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
				if (player.statusEffectv3(StatusEffects.Heat) <= 1 || player.vaginas.length == 0) { //Remove bonus libido from heat
					getGame().dynStats("lib", -player.statusEffect(player.findStatusEffect(StatusEffects.Heat)).value2, "resisted", false, "noBimbo", true);
					player.removeStatusEffect(StatusEffects.Heat); //remove heat
					if (player.lib < 1) player.lib = 1;
					getGame().statScreenRefresh();
					outputText("\n<b>Your body calms down, at last getting over your heat.</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.Heat, 3, -1);
			}
			
			if (player.inRut) { //Rut v1 is bonus cum, v2 is bonus libido, v3 is hours till it's gone
				trace("RUT:" + player.statusEffectv3(StatusEffects.Rut));
				if (player.statusEffectv3(StatusEffects.Rut) <= 1 || player.totalCocks() == 0) { //Remove bonus libido from rut
					getGame().dynStats("lib", -player.statusEffectv2(StatusEffects.Rut), "resisted", false, "noBimbo", true);
					player.removeStatusEffect(StatusEffects.Rut); //remove heat
					if (player.lib < 10) player.lib = 10;
					getGame().statScreenRefresh();
					outputText("\n<b>Your body calms down, at last getting over your rut.</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.Rut, 3, -1);
			}
			if (player.findStatusEffect(StatusEffects.LustyTongue) >= 0) { //Lusty Tongue Check!
				if (rand(5) == 0) {
					outputText("\nYou keep licking your lips, blushing with the sexual pleasure it brings you.");
					getGame().dynStats("lus", 2 + rand(15));
					if (player.lust >= player.maxLust()) {
						outputText("  Your knees lock from the pleasure, and you fall back in pleasure, twisting and moaning like a whore as you somehow orgasm from your mouth.  When it finishes, you realize your mouth feels even more sensitive than before.");
						player.orgasm();
						getGame().dynStats("sen", 2);
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
			if (player.statusEffectv2(StatusEffects.Kelt) > 0) player.addStatusValue(StatusEffects.Kelt, 2, -0.15); //Reduce kelt submissiveness by 1 every 5 hours
			//Mino cum update.
			if (getGame().mountain.minotaurScene.minoCumUpdate()) {
				needNext = true;
			}
			else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 2 && getGame().model.time.hours % 13 == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] == 0) { //Repeated warnings!
				if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2)
					outputText("\n<b>You shiver, feeling a little cold.  Maybe you ought to get some more minotaur cum?  You just don't feel right without that pleasant buzz in the back of your mind.</b>\n");
				else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3)
					outputText("\n<b>The steady fire of lust within you burns hot, making you shiver and grab at your head.  You're STILL in withdrawal after having gone so long without a dose of minotaur love.  You just know you're going to be horny and achy until you get some.</b>\n");
				needNext = true;
			}
			//Decrement mino withdrawal symptoms display cooldown
			//flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] prevents PC getting two of the same notices overnite
			else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330]--;
			if (player.findPerk(PerkLib.FutaForm) >= 0) { //Futa checks
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
					getGame().dynStats("int", -1, "sen", 5, "lus", 15);
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
					outputText("\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath " + player.sMultiCockDesc() + " grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>\n");
					player.balls = 2;
					player.ballSize = 3;
					needNext = true;
				}
				if (player.breastRows[0].breastRating < 5) { //Tits!
					player.breastRows[0].breastRating = 5;
					if (player.findPerk(PerkLib.FutaFaculties) >= 0)
						outputText("\n<b>Your tits get nice and full again.  You'll have lots of fun now that your breasts are back to being big, swollen knockers!</b>\n");
					else outputText("\n<b>Your " + player.breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n");
					getGame().dynStats("int", -1, "lus", 15);
					needNext = true;
				}
				if (!player.hasVagina()) { //Vagoo
					player.createVagina();
					if (player.findPerk(PerkLib.FutaFaculties) >= 0)
						outputText("\n<b>Your crotch is like, all itchy an' stuff.  Damn!  There's a wet little slit opening up, and it's all tingly!  It feels so good, why would you have ever gotten rid of it?</b>\n");
					else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + player.legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n");
					getGame().dynStats("int", -1, "sen", 10, "lus", 15);
					needNext = true;
				}
			}
			if (player.findPerk(PerkLib.BimboBody) >= 0 || player.findStatusEffect(StatusEffects.BimboChampagne) >= 0) { //Bimbo checks
				if (player.breastRows[0].breastRating < 5) { //Tits!
					player.breastRows[0].breastRating = 5;
					if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.findStatusEffect(StatusEffects.BimboChampagne) >= 0)
						outputText("\n<b>Your boobies like, get all big an' wobbly again!  You'll have lots of fun now that your tits are back to being big, yummy knockers!</b>\n");
					else outputText("\n<b>Your " + player.breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n");
					getGame().dynStats("int", -1, "lus", 15);
					needNext = true;
				}
				if (!player.hasVagina()) { //Vagoo
					player.createVagina();
					if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.findStatusEffect(StatusEffects.BimboChampagne) >= 0)
						outputText("\n<b>Your crotch is like, all itchy an' stuff.  Omigawsh!  There's a wet little slit opening up, and it's all tingly!  It feels so good, maybe like, someone could put something inside there!</b>\n");
					else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + player.legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n");
					needNext = true;
				}
				if (player.hipRating < 12) {
					if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0)
						outputText("\nWhoah!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate on a tittering bimbo.  You giggle when you realize you can't walk any other way.  At least it makes you look, like, super sexy!\n");
					else outputText("\nOh, no!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate for a bimbo.  Once you realize that you can't walk any other way, you sigh heavily, your only consolation the fact that your widened hips can be used to tease more effectively.\n");
					getGame().dynStats("int", -1);
					player.hipRating = 12;
					needNext = true;
				}
				if (player.buttRating < 12) {
					if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0)
						outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  You smile to yourself, imagining how much you wish you had a nice, plump, bimbo-butt again, your hands finding their way to the flesh on their own.  Like, how did they get down there?  You bite your lip when you realize how good your tush feels in your hands, particularly when it starts to get bigger.  Are butts supposed to do that?  Happy pink thoughts wash that concern away - it feels good, and you want a big, sexy butt!  The growth stops eventually, and you pout disconsolately when the lusty warmth's last lingering touches dissipate.  Still, you smile when you move and feel your new booty jiggling along behind you.  This will be fun!\n");
					else outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  Oh, no!  You thought that having a big, bloated bimbo-butt was a thing of the past, but with how it's tingling under your groping fingertips, you have no doubt that you're about to see the second coming of your sexy ass.  Wait, how did your fingers get down there?  You pull your hands away somewhat guiltily as you feel your buttcheeks expanding.  Each time you bounce and shake your new derriere, you moan softly in enjoyment.  Damnit!  You force yourself to stop just as your ass does, but when you set off again, you can feel it bouncing behind you with every step.  At least it'll help you tease your foes a little more effectively...\n");
					getGame().dynStats("int", -1, "lus", 10);
					player.buttRating = 12;
					needNext = true;
				}
			}
			if (player.findPerk(PerkLib.BroBody) >= 0) { //Bro checks
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
					if (player.findPerk(PerkLib.BroBrains) >= 0) outputText("Goddamn, that thing is almost as tough as you!  ");
					outputText("You really have no control over your dick.</b>\n");
					player.cocks[0].cockLength = 8;
					if (player.cocks[0].cockThickness < 2) player.cocks[0].cockThickness = 1.5;
					needNext = true;
				}
				if (player.balls == 0) { //(Balls regrowth)
					outputText("\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath " + player.sMultiCockDesc() + " grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>\n");
					player.balls = 2;
					player.ballSize = 3;
					needNext = true;
				}
			}
			if (player.findStatusEffect(StatusEffects.Feeder) >= 0) { //Feeder checks
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
					if (player.statusEffectv2(StatusEffects.Feeder) >= 72 && getGame().model.time.hours == 14) {
						outputText("\n<b>After having gone so long without feeding your milk to someone, you're starting to feel strange.  Every inch of your skin practically thrums with sensitivity, particularly your sore, dripping nipples.</b>\n");
						getGame().dynStats("sen", 2 + (((player.statusEffectv2(StatusEffects.Feeder)) - 70) / 20));
						needNext = true;
					}
				}
			}
			if (player.findStatusEffect(StatusEffects.WormPlugged) >= 0 && flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] == 0) { //Update worm drippy-cooch
				if (player.hasVagina()) {
					if (rand(5) == 0) {
						flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] = 1;
						outputText("\nA sudden gush of semen-coated worms noisily slurps out of your womb.  It runs down your legs as the worms do their damnedest to escape.  The feeling of so many squiggling forms squirting through your cunt-lips turns you on more than you'd like to admit.  You wonder why they stayed as long as they did, and some part of you worries that their stay may have reduced your capacity to bear children, though in a place like this that might be a blessing.\n");
						getGame().dynStats("lus", 2 + player.sens / 10);
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
			if (player.findStatusEffect(StatusEffects.Milked) >= 0) { //"Milked"
				player.addStatusValue(StatusEffects.Milked, 1, -1);
				if (player.statusEffectv1(StatusEffects.Milked) <= 0) {
					outputText("\n<b>Your " + player.nippleDescript(0) + "s are no longer sore from the milking.</b>\n");
					player.removeStatusEffect(StatusEffects.Milked);
					needNext = true;
				}
			}
			if (player.findStatusEffect(StatusEffects.Jizzpants) >= 0) {
				outputText("\nYour " + player.armorName + " squishes wetly with all the semen you unloaded into them, arousing you more and more with every movement.\n");
				getGame().dynStats("lus", 10 + player.sens / 5);
				player.removeStatusEffect(StatusEffects.Jizzpants);
				needNext = true;
			}
			if (player.findStatusEffect(StatusEffects.Dysfunction) >= 0) {
				if (player.statusEffectv1(StatusEffects.Dysfunction) <= 1) {
					player.removeStatusEffect(StatusEffects.Dysfunction);
					outputText("\nYou feel a tingling in your nethers... at last full sensation has returned to your groin.  <b>You can masturbate again!</b>\n");
					needNext = true;
				}
				else player.addStatusValue(StatusEffects.Dysfunction, 1, -1);
			}
			if (player.findStatusEffect(StatusEffects.LactationReduction) < 0) { //Lactation reduction
				if (player.biggestLactation() > 0) player.createStatusEffect(StatusEffects.LactationReduction, 0, 0, 0, 0);
			}
			else if (player.biggestLactation() > 0 && player.findStatusEffect(StatusEffects.Feeder) < 0 && player.findPerk(PerkLib.MilkMaid) < 0 && player.pregnancyIncubation == 0) {
				player.addStatusValue(StatusEffects.LactationReduction, 1, 1);
				if (player.statusEffectv1(StatusEffects.LactationReduction) >= 48) {
					if (player.findStatusEffect(StatusEffects.LactationReduc0) < 0) {
						player.createStatusEffect(StatusEffects.LactationReduc0, 0, 0, 0, 0);
						if (player.biggestLactation() >= 1) outputText("\n<b>Your " + player.nippleDescript(0) + "s feel swollen and bloated, needing to be milked.</b>\n");
						if (player.biggestLactation() <= 2) player.createStatusEffect(StatusEffects.LactationReduc1, 0, 0, 0, 0);
						if (player.biggestLactation() <= 1) player.createStatusEffect(StatusEffects.LactationReduc2, 0, 0, 0, 0);
						needNext = true;
					}
					player.boostLactation(-0.5 * player.breastRows.length / 24);
					if (player.biggestLactation() <= 2.5 && player.findStatusEffect(StatusEffects.LactationReduc1) < 0) {
						outputText("\n<b>Your breasts feel lighter as your body's milk production winds down.</b>\n");
						player.createStatusEffect(StatusEffects.LactationReduc1, 0, 0, 0, 0);
						needNext = true;
					}
					else if (player.biggestLactation() <= 1.5 && player.findStatusEffect(StatusEffects.LactationReduc2) < 0) {
						outputText("\n<b>Your body's milk output drops down to what would be considered 'normal' for a pregnant woman.</b>\n");
						player.createStatusEffect(StatusEffects.LactationReduc2, 0, 0, 0, 0);
						needNext = true;
					}
					if (player.biggestLactation() < 1 && player.findStatusEffect(StatusEffects.LactationReduc3) < 0) {
						player.createStatusEffect(StatusEffects.LactationReduc3, 0, 0, 0, 0);
						outputText("\n<b>Your body no longer produces any milk.</b>\n");
						player.removeStatusEffect(StatusEffects.LactationReduction);
						needNext = true;
					}
				}
			}
			if (player.findStatusEffect(StatusEffects.CuntStretched) >= 0) { //Cunt stretching stuff
				player.addStatusValue(StatusEffects.CuntStretched, 1, 1);
				if (player.vaginas.length > 0) {
					if (player.findPerk(PerkLib.FerasBoonWideOpen) < 0) {
						if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE && player.statusEffectv1(StatusEffects.CuntStretched) >= 200) {
							outputText("\nYour " + player.vaginaDescript(0) + " recovers from your ordeals, tightening up a bit.\n");
							player.vaginas[0].vaginalLooseness--;
							player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
							needNext = true;
						}
						if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING && player.statusEffectv1(StatusEffects.CuntStretched) >= 100) {
							outputText("\nYour " + player.vaginaDescript(0) + " recovers from your ordeals, tightening up a bit.\n");
							player.vaginas[0].vaginalLooseness--;
							player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
							needNext = true;
						}
						if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE && player.statusEffectv1(StatusEffects.CuntStretched) >= 70) {
							outputText("\nYour " + player.vaginaDescript(0) + " recovers from your ordeals and becomes tighter.\n");
							player.vaginas[0].vaginalLooseness--;
							player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
							needNext = true;
						}
					}
					if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR && player.statusEffectv1(StatusEffects.CuntStretched) >= 50) {
						outputText("\nYour " + player.vaginaDescript(0) + " recovers from the brutal stretching it has received and tightens up a little bit, but not much.\n");
						player.vaginas[0].vaginalLooseness--;
						player.changeStatusValue(StatusEffects.CuntStretched, 1, 0);
						needNext = true;
					}
				}
			}
			if (player.findStatusEffect(StatusEffects.ButtStretched) >= 0) { //Butt stretching stuff
				player.addStatusValue(StatusEffects.ButtStretched, 1, 1);
				if (player.ass.analLooseness == 2 && player.statusEffectv1(StatusEffects.ButtStretched) >= 72) {
					outputText("\n<b>Your " + player.assholeDescript() + " recovers from your ordeals, tightening up a bit.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (player.ass.analLooseness == 3 && player.statusEffectv1(StatusEffects.ButtStretched) >= 48) {
					outputText("\n<b>Your " + player.assholeDescript() + " recovers from your ordeals, tightening up a bit.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (player.ass.analLooseness == 4 && player.statusEffectv1(StatusEffects.ButtStretched) >= 24) {
					outputText("\n<b>Your " + player.assholeDescript() + " recovers from your ordeals and becomes tighter.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (player.ass.analLooseness == 5 && player.statusEffectv1(StatusEffects.ButtStretched) >= 12) {
					outputText("\n<b>Your " + player.assholeDescript() + " recovers from the brutal stretching it has received and tightens up.</b>\n");
					player.ass.analLooseness--;
					player.changeStatusValue(StatusEffects.ButtStretched, 1, 0);
					needNext = true;
				}
			}
			if (player.findPerk(PerkLib.SlimeCore) >= 0) { //Lose slime core perk
				if (player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != LOWER_BODY_TYPE_GOO) {
					outputText("\nYour form ripples, as if uncertain at the changes your body is undergoing.  The goo of your flesh cools, its sensitive, responsive membrane thickening into " + player.skin() + " while bones and muscles knit themselves into a cohesive torso, chest and hips gaining definition.  Translucent ooze clouds and the gushing puddle at your feet melts together, splitting into solid trunks as you regain your legs.  Before long, you can no longer see through your own body and, with an unsteady shiver, you pat yourself down, readjusting to solidity.  A lurching heat in your chest suddenly reminds you of the slime core that used to float inside you.  Gingerly touching your " + player.chestDesc() + ", you can feel a small, second heartbeat under your ribs that gradually seems to be sinking, past your belly. A lurching wave of warmth sparks through you, knocking you off your fresh legs and onto your " + player.buttDescript() + ".  A delicious pressure pulses in your abdomen and you loosen your " + player.armorName + " as sweat beads down your neck.  You clench your eyes, tongue lolling in your mouth, and the pressure builds and builds until, in ecstatic release, your body arches in an orgasmic release.\n\n");
	
					outputText("\nPanting, you open your eyes and see that, for once, the source of your climax wasn't your loins.  Feeling a warm, wetness on your abs, you investigate and find the small, heart-shaped nucleus that used to be inside your body has somehow managed to pass through your belly button. Exposed to the open air, the crimson organ slowly crystallizes, shrinking and hardening into a tiny ruby.  Rubbing the stone with your thumb, you're surprised to find that you can still feel a pulse within its glittering facets.  You stow the ruby heart, in case you need it again.\n");
					player.createKeyItem("Ruby Heart", 0, 0, 0, 0); //[Add 'Ruby Heart' to key items. Player regains slime core if returning to goo body]
					player.removePerk(PerkLib.SlimeCore);
					needNext = true;
				}
			}
			if (player.hasKeyItem("Ruby Heart") >= 0) { //Regain slime core
				if (player.findStatusEffect(StatusEffects.SlimeCraving) >= 0 && player.findPerk(PerkLib.SlimeCore) < 0 && player.isGoo() && player.gooScore() >= 4 && player.vaginalCapacity() >= 9000 && player.skinAdj == "slimy" && player.skinDesc == "skin" && player.lowerBody == LOWER_BODY_TYPE_GOO) {
					outputText("\nAs you adjust to your new, goo-like body, you remember the ruby heart you expelled so long ago.  As you reach to pick it up, it quivers and pulses with a warm, cheerful light.  Your fingers close on it and the nucleus slides through your palm, into your body!\n\n");
					
					outputText("There is a momentary pressure in your chest and a few memories that are not your own flicker before your eyes.  The dizzying sight passes and the slime core settles within your body, imprinted with your personality and experiences.  There is a comforting calmness from your new nucleus and you feel as though, with your new memories, you will be better able to manage your body's fluid requirements.\n");
					//(Reduces Fluid Addiction to a 24 hour intake requirement).
					outputText("(<b>Gained New Perk: Slime Core - Moisture craving builds at a greatly reduced rate.</b>\n)");
					player.createPerk(PerkLib.SlimeCore, 0, 0, 0, 0);
					player.removeKeyItem("Ruby Heart");
					needNext = true;
				}
			}
			if (player.findStatusEffect(StatusEffects.SlimeCraving) >= 0) { //Slime craving stuff
				if (player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != LOWER_BODY_TYPE_GOO) {
					outputText("\n<b>You realize you no longer crave fluids like you once did.</b>\n");
					player.removeStatusEffect(StatusEffects.SlimeCraving);
					player.removeStatusEffect(StatusEffects.SlimeCravingFeed);
					needNext = true;
				}
				else { //Slime core reduces fluid need rate
					if (player.findPerk(PerkLib.SlimeCore) >= 0)
						player.addStatusValue(StatusEffects.SlimeCraving, 1, 0.5);
					else player.addStatusValue(StatusEffects.SlimeCraving, 1, 1);
					if (player.statusEffectv1(StatusEffects.SlimeCraving) >= 18) {
						if (player.findStatusEffect(StatusEffects.SlimeCravingOutput) < 0) { //Protects against this warning appearing multiple times in the output
							player.createStatusEffect(StatusEffects.SlimeCravingOutput, 0, 0, 0, 0);
							outputText("\n<b>Your craving for the 'fluids' of others grows strong, and you feel yourself getting weaker and slower with every passing hour.</b>\n");
							needNext = true;
						}
						if (player.spe > 1) player.addStatusValue(StatusEffects.SlimeCraving, 3, 0.1); //Keep track of how much has been taken from speed
						getGame().dynStats("str", -0.1,"spe", -0.1, "lus", 2);
						player.addStatusValue(StatusEffects.SlimeCraving, 2, 0.1); //Keep track of how much has been taken from strength
					}
				}
			}
			if (player.findStatusEffect(StatusEffects.SlimeCravingFeed) >= 0) { //Slime feeding stuff
				outputText("\n<b>You feel revitalized from your recent intake, but soon you'll need more...</b>\n");
				getGame().dynStats("str", player.statusEffectv2(StatusEffects.SlimeCraving) * 0.5, "spe", player.statusEffectv3(StatusEffects.SlimeCraving)); //Boost speed and restore half the player's lost strength
				player.removeStatusEffect(StatusEffects.SlimeCravingFeed); //Remove feed succuss status so it can be reset
				player.changeStatusValue(StatusEffects.SlimeCraving, 2, 0); //Reset stored hp/toughness values
				needNext = true;
			}
			if (player.findStatusEffect(StatusEffects.Fullness) >= 0) {
				player.addStatusValue(StatusEffects.Fullness, 1, -1);
				if (player.statusEffectv1(StatusEffects.Fullness) <= 0) player.removeStatusEffect(StatusEffects.Fullness);
			}
			if (player.findStatusEffect(StatusEffects.AndysSmoke) >= 0) {
				player.addStatusValue(StatusEffects.AndysSmoke, 1, -1);
				if (player.statusEffectv1(StatusEffects.AndysSmoke) <= 0) {
					outputText("\n<b>The change in your mental prowess confirms that the effects of Nepenthe must have worn off.</b>\n");
					var tempSpe:int = player.statusEffectv2(StatusEffects.AndysSmoke);
					var tempInt:int = player.statusEffectv3(StatusEffects.AndysSmoke);
					player.removeStatusEffect(StatusEffects.AndysSmoke);
					dynStats("spe", -tempSpe); //Properly revert speed and intelligence.
					dynStats("inte", -tempInt);
					needNext = true;
				}
			}
			if (getGame().model.time.hours == 6 && player.armorName == "bimbo skirt" && rand(10) == 0 && player.biggestTitSize() < 12) {
				outputText("\n<b>As you wake up, you feel a strange tingling starting in your nipples that extends down into your breasts.  After a minute, the tingling dissipates in a soothing wave.  As you cup your tits, you realize they've gotten larger!</b>");
				player.growTits(1, player.bRows(), false, 2);
				getGame().dynStats("lus", 10);
				needNext = true;
			}
			if (flags[kFLAGS.BIKINI_ARMOR_BONUS] > 0) {
				if (player.armorName == "lusty maiden's armor") {
					if (getGame().model.time.hours == 0) flags[kFLAGS.BIKINI_ARMOR_BONUS]--; //Adjust for inflation
					if (flags[kFLAGS.BIKINI_ARMOR_BONUS] < 0) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 0; //Keep in bounds.
					if (flags[kFLAGS.BIKINI_ARMOR_BONUS] > 8) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 8;
				}
				else flags[kFLAGS.BIKINI_ARMOR_BONUS] = 0;
			}
			
			//No better place for these since the code for the event is part of CoC.as or one of its included files
			if (flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] > 0) flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC]--; //Vala post-rape countdown
			if (flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] > 0 && flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] < 500) flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY]++;
			
			if (getGame().model.time.hours > 23) { //Once per day
				flags[kFLAGS.BROOKE_MET_TODAY] = 0;
				if (getGame().model.time.days % 2 == 0 && flags[kFLAGS.KAIJU_BAD_END_COUNTER] > 0) {
					flags[kFLAGS.KAIJU_BAD_END_COUNTER]--;
					if (flags[kFLAGS.KAIJU_BAD_END_COUNTER] < 0) flags[kFLAGS.KAIJU_BAD_END_COUNTER] = 0;
				}
				if (flags[kFLAGS.GILDED_JERKED] > 0) flags[kFLAGS.GILDED_JERKED] = 0;
				if (flags[kFLAGS.FED_SCYLLA_TODAY] == 1) flags[kFLAGS.FED_SCYLLA_TODAY] = 0;
				if (flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] != 0) flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] = 0;
				if (flags[kFLAGS.RUBI_PROSTITUTION] > 0) flags[kFLAGS.RUBI_PROFIT] += 2 + rand(4);
				flags[kFLAGS.BENOIT_TALKED_TODAY] = 0;
				getGame().bazaar.benoit.updateBenoitInventory();
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
				if (getGame().model.time.days % 7 == 0) flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] = 0; //Clear Whitney's Weekly limit
				if (flags[kFLAGS.USED_MILKER_TODAY] > 0) flags[kFLAGS.USED_MILKER_TODAY] = 0; //Clear 'has fucked milker today'
				if (getGame().latexGirl.latexGooFollower()) { //Latex goo follower daily updates
					getGame().latexGirl.gooFluid(-2, false);
					if (getGame().latexGirl.gooFluid() < 50) getGame().latexGirl.gooHappiness(-1, false);
					if (getGame().latexGirl.gooFluid() < 25) getGame().latexGirl.gooHappiness(-1, false);
					if (getGame().latexGirl.gooHappiness() < 75) getGame().latexGirl.gooObedience(-1, false);
					if (getGame().latexGirl.gooHappiness() >= 90) getGame().latexGirl.gooObedience(1, false);
				}
				getGame().farm.farmCorruption.updateFarmCorruption(); //Farm Corruption updating
				if (player.findStatusEffect(StatusEffects.Contraceptives) >= 0) { // Herbal contraceptives countdown
					if (player.statusEffectv1(StatusEffects.Contraceptives) == 1) {
						player.addStatusValue(StatusEffects.Contraceptives, 2, -1);
						if (player.statusEffectv1(StatusEffects.Contraceptives) < 0) player.removeStatusEffect(StatusEffects.Contraceptives);
					}
				}
				if (player.statusEffectv1(StatusEffects.SharkGirl) > 0) player.addStatusValue(StatusEffects.SharkGirl, 1, -1); //Lower shark girl counter
				if (flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] > 0) {
					switch (flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]) {
						case 1:
							if (!needNext) needNext = player.growHair(0.2);
							else player.growHair(0.2);
							break;
						case 2:
							if (!needNext) needNext = player.growHair(0.5);
							else player.growHair(0.5);
							break;
						case 3:
							if (!needNext) needNext = player.growHair(1.1);
							else player.growHair(1.1);
						default:
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
					if (!needNext) needNext = player.growHair(0.1);
					else player.growHair(0.1);
					if (player.beardLength > 0 && player.beardLength < 12) player.growBeard(0.02);
				}
				//Clear dragon breath cooldown!
				if (player.findStatusEffect(StatusEffects.DragonBreathCooldown) >= 0) player.removeStatusEffect(StatusEffects.DragonBreathCooldown);
			}
			if (flags[kFLAGS.WEATHER_CHANGE_COOLDOWN] > 0) {
				flags[kFLAGS.WEATHER_CHANGE_COOLDOWN]--;
			}
			return needNext;
		}
		
		public function timeChangeLarge():Boolean {
			if (rand(4) == 0 && isHolidays() && player.gender > 0 && getGame().model.time.hours == 6 && flags[kFLAGS.XMAS_CHICKEN_YEAR] < getGame().date.fullYear) {
				getGame().xmas.xmasMisc.getAChristmasChicken();
				return true;
			}
			if (getGame().model.time.hours == 1 && isHolidays() && getGame().date.fullYear > flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE]) { //XMAS ELF
				getGame().xmas.xmasElf.xmasBitchEncounter(); //Set it to remember the last year encountered
				return true;
			}
			if (checkedTurkey++ == 0 && (rand(5) == 0 && (getGame().model.time.hours == 18 || getGame().model.time.hours == 19)) && (getGame().date.fullYear > flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] || flags[kFLAGS.MORE_TURKEY] > 0) && isThanksgiving() && player.gender > 0 && flags[kFLAGS.IN_INGNAM] <= 0) {
				getGame().thanksgiving.datTurkeyRumpMeeting(); //TURKEY SURPRISE
				return true;
			}
			if (checkedDream++ == 0 && getGame().model.time.hours == 3) { //You can only have one dream each night
				if (player.gender > 0 && getGame().model.time.days == 10) { //Day 10 dream - since this can happen only once it takes priority over all other dreams
					getGame().dreams.dayTenDreams();
					return true;
				}
				if (player.hasCock() && player.findPerk(PerkLib.BeeOvipositor) >= 0 && (player.eggs() >= 20 && rand(6) == 0)) { //Bee dreams proc
					//happens at first sleep after hitting stage 3 unfertilized
					//To Wong Foo, Thanks for Everything, Julie Newmar
					outputText("\nYou sit atop your favorite flower, enjoying the smell of verdure and the sounds of the forest.  The sun is shining brightly and it feels wonderful on your chitin.  Your wings twitch happily in the soft breeze, and it feels good to be alive and doing the colony's work... the only sour note is your heavy, bloated abdomen, so full of unfertilized eggs that it droops, so full it strains your back and pinches your nerves.  Still, it's too nice a day to let that depress you, and you take up your customary song, humming tunelessly but mellifluously as you wait for passers-by.");
					
					outputText("\n\nYour antennae bob - was that someone?  Peering between the trees from the corner of your eye, you can see the figure of another person, and you intensify your hypnotic buzz, trying to draw it closer.  The figure steps into your clearing and out of the shadow; clad in " + player.armorName + ", " + player.mf("he","she") + " is yourself!  Confused, you stop humming and stare into your own face, and the other you takes the opportunity to open " + player.mf("his","her") + " garments, exposing " + player.mf("his","her") + " [cock]!");
					
					outputText("\n\nStartled, you slip down from your seat and try to run, but the other you has already crossed the clearing and seizes you by the fuzz on your hefty, swollen abdomen; your leg slips, propelling you face-first to the ground.  " + player.mf("He","She") + " pulls you back toward " + player.mf("his","her") + "self and, grabbing one of your chitinous legs, turns you over.  The other you spreads your fuzzed thighs, revealing your soft, wet pussy, and the sweet smell of honey hits your noses.  " + player.mf("His","Her") + " prick hardens intensely and immediately at the aroma of your pheromone-laden nectar, and " + player.mf("he","she") + " pushes it into you without so much as a word of apology, groaning as " + player.mf("he","she") + " begins to rut you mercilessly.  You can feel the sensations of " + player.mf("his","her") + " burning cock as if it were your own, and your legs wrap around your other self instinctively even as your mind recoils in confusion.");
					
					outputText("\n\nThe other you grunts and locks up as " + player.mf("his","her") + "... your [cock] begins to spurt inside your honey-drooling cunt, and " + player.mf("he","she") + " falls onto you, bottoming out inside; your vagina likewise clenches and squirts your sweet juices.  As " + player.mf("he","she") + " ejaculates, thrusting weakly, you can feel something shifting in you, filling you with pins and needles... it feels like the warm cum " + player.mf("he","she") + "'s filling you with is permeating your entire groin, working its way back toward your abdomen.  It edges up to your massive buildup of eggs, and your body tightens in a second climax at the thought of having your children fertilized-");
					
					outputText("\n\nYou snap awake, sitting bolt upright.  What in the name of... your " + player.multiCockDescriptLight() + " is softening rapidly, and as you shift, you can feel your cum sloshing in your [armor].  For fuck's sake.");
					if (player.cumQ() >= 1000) outputText("  It's completely soaked your bedroll, too... you won't be sleeping on this again until you wash it out.  Grumbling, you roll the soggy, white-stained fabric up and stow it.");
					outputText("  The sensation of wetness inside your own clothes torments you as you try to return to sleep, driving up your lust and making you half-hard once again... the rumbling of eggs in your abdomen, as if they're ready to be laid, doesn't help either.");
					player.fertilizeEggs(); //convert eggs to fertilized based on player cum output, reduce lust by 100 and then add 20 lust
					player.orgasm(); //reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
					getGame().dynStats("lus", 20);
					getGame().doNext(playerMenu);
					//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
					//Hey whoever, maybe you write them? -Z
					return true;
				}
				if (player.hasCock() && player.findPerk(PerkLib.SpiderOvipositor) >= 0 && (player.eggs() >= 20 && rand(6) == 0)) { //Drider dreams proc
					outputText("\nIn a moonlit forest, you hang upside down from a thick tree branch suspended by only a string of webbing.  You watch with rising lust as a hapless traveler strolls along below, utterly unaware of the trap you've set.  Your breath catches as " + player.mf("he","she") + " finally encounters your web, flailing against the sticky strands in a futile attempt to free " + player.mf("him","her") + "self.  Once the traveller's struggles slow in fatigue, you descend easily to the forest floor, wrapping " + player.mf("him","her") + " in an elegant silk cocoon before pulling " + player.mf("him","her") + " up into the canopy.  Positioning your catch against the tree's trunk, you sink your fangs through the web and into flesh, feeling " + player.mf("his","her") + " body heat with every drop of venom.  Cutting " + player.mf("his","her") + " crotch free of your webbing, you open " + player.mf("his","her") + " [armor] and release the ");
					if (player.hasVagina()) outputText(player.vaginaDescript(0) + " and ");
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
					getGame().dynStats("lus", 20);
					getGame().doNext(playerMenu);
					//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
					//Hey whoever, maybe you write them? -Z
					return true;
				}
				var ceraph:int; //Ceraph's dreams - overlaps normal night-time dreams.
				switch (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220]) {
					case  0: ceraph =  0; break; //If you've given her no body parts then Ceraph will not cause any dreams
					case  1: ceraph = 10; break; //Once every 10 days if 1, once every 7 days if 2, once every 5 days if 3
					case  2: ceraph =  7; break;
					case  3: ceraph =  5; break;
					case  4: ceraph =  4; break;
					default: ceraph =  3;
				}
				if (ceraph > 0 && getGame().model.time.days % ceraph == 0) {
					getGame().ceraphScene.ceraphBodyPartDreams();
					return true;
				}
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] < 4) { //Dominika Dream
					outputText("\n<b>Your rest is somewhat troubled with odd dreams...</b>\n");
					getGame().telAdre.dominika.fellatrixDream();
					return true;
				}
				if (getGame().anemoneScene.kidAXP() >= 40 && flags[kFLAGS.HAD_KID_A_DREAM] == 0 && player.gender > 0) {
					getGame().anemoneScene.kidADreams();
					flags[kFLAGS.HAD_KID_A_DREAM] = 1;
					return true;
				}
				if (player.viridianChange()) {
					getGame().dreams.fuckedUpCockDreamChange();
					return true;
				}
				if (player.lib > 50 || player.lust > 40) { //Randomly generated dreams here
					if (getGame().dreams.dreamSelect()) return true;
				}
			}
			if (player.statusEffectv1(StatusEffects.SlimeCraving) >= 18 && player.str <= 1) { //Bad end!
				getGame().lake.gooGirlScene.slimeBadEnd();
				return true;
			}
			//Bee cocks
			if (player.hasCock() && player.cocks[0].cockType == CockTypesEnum.BEE && player.lust >= player.maxLust()) {
				if (player.hasItem(consumables.BEEHONY) || player.hasItem(consumables.PURHONY) || player.hasItem(consumables.SPHONEY)) {
					outputText("\nYou can't help it anymore. Thankfully, you have the honey in your pouch so you pull out a vial of honey. You're definitely going to masturbate with honey covering your bee-cock.");
					doNext(getGame().masturbation.masturbateGo);
					return true;
				}
				outputText("\nYou can’t help it anymore, you need to find the bee girl right now.  You rush off to the forest to find the release that you absolutely must have.  Going on instinct you soon find the bee girl's clearing and her in it.\n\n");
				getGame().forest.beeGirlScene.beeSexForCocks(false);
				return true;
			}
			//Rigidly enforce cock size caps
			if (player.hasCock()) {
				for (var i:int = 0; i < player.cocks.length; i++) {
					if (player.cocks[i].cockLength > 499.9) player.cocks[i].cockLength = 499.9;
					if (player.cocks[i].cockThickness > 99.9) player.cocks[i].cockThickness = 99.9;
				}
			}
			//Randomly change weather post-game
			if (flags[kFLAGS.GAME_END] > 0 && flags[kFLAGS.WEATHER_CHANGE_COOLDOWN] <= 0) {
				var randomWeather:int = rand(100);
				flags[kFLAGS.WEATHER_CHANGE_COOLDOWN] = 6 + rand(48);
				if (randomWeather < 40) { //Clear
					flags[kFLAGS.CURRENT_WEATHER] = 0;
				}
				else if (randomWeather >= 40 && randomWeather < 60) { //A few clouds
					flags[kFLAGS.CURRENT_WEATHER] = 1;
				}
				else if (randomWeather >= 60 && randomWeather < 80) { //Cloudy
					flags[kFLAGS.CURRENT_WEATHER] = 2;
				}
				else if (randomWeather >= 80 && randomWeather < 96) { //Rainy
					flags[kFLAGS.CURRENT_WEATHER] = 3;
					flags[kFLAGS.WEATHER_CHANGE_COOLDOWN] /= 2;
				}
				else if (randomWeather >= 96) { //Thunderstorm
					flags[kFLAGS.CURRENT_WEATHER] = 4;
					flags[kFLAGS.WEATHER_CHANGE_COOLDOWN] /= 3;
				}
			}
			return false;
		}
		//End of Interface Implementation
	}
}
