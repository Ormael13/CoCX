package classes
{
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Scenes.Places.TelAdre.UmasShop;

use namespace kGAMECLASS;

	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character implements TimeAwareInterface {
		
		public function Player() {
			//Item things
			itemSlot1 = new ItemSlotClass();
			itemSlot2 = new ItemSlotClass();
			itemSlot3 = new ItemSlotClass();
			itemSlot4 = new ItemSlotClass();
			itemSlot5 = new ItemSlotClass();
			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5];
			CoC.timeAwareClassAdd(this);
		}
		
		private var checkedTurkey:int; //Make sure we test each of these events just once in timeChangeLarge
		private var checkedDream:int;
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean {
			var needNext:Boolean = false;
			checkedTurkey = 0;
			checkedDream = 0;
			if (cumMultiplier > 19999) cumMultiplier = 19999;
			if (ballSize > 400) ballSize = 400;
			if (findPerk(PerkLib.StrongBack) >= 0 && !itemSlot4.unlocked) itemSlot4.unlocked = true;
			if (findPerk(PerkLib.StrongBack2) >= 0 && !itemSlot5.unlocked) itemSlot5.unlocked = true;
			if (flags[kFLAGS.SOCK_COUNTER] > 0) {
				flags[kFLAGS.SOCK_COUNTER]--;
				if (flags[kFLAGS.SOCK_COUNTER] < 0) flags[kFLAGS.SOCK_COUNTER] = 0;
				if (flags[kFLAGS.SOCK_COUNTER] > 24) flags[kFLAGS.SOCK_COUNTER] = 24;
			}
			hoursSinceCum++;
			//Super cumbuilding activate!
			if (findPerk(PerkLib.MaraesGiftProfractory) >= 0) hoursSinceCum += 2;
			if (findPerk(PerkLib.FerasBoonAlpha) >= 0) hoursSinceCum += 2;
			//Normal
			if (findPerk(PerkLib.WellAdjusted) < 0) {
				game.dynStats("lus", lib * 0.04, "resisted", false); //Raise lust
				if (findPerk(PerkLib.Lusty) >= 0) game.dynStats("lus", lib * 0.02, "resisted", false); //Double lust rise if lusty.
			}
			else { //Well adjusted perk
				game.dynStats("lus", lib * 0.02); //Raise lust
				if (findPerk(PerkLib.Lusty) >= 0) game.dynStats("lus", lib * 0.01, "resisted", false); //Double lust rise if lusty.
			}
			if (tailType == TAIL_TYPE_BEE_ABDOMEN || tailType == TAIL_TYPE_SPIDER_ADBOMEN) { //Spider and Bee Sting Recharge
				if (tailRecharge < 5) tailRecharge = 5;
				tailVenom += tailRecharge;
				if (tailVenom > 100) tailVenom = 100;
			}
			if (tailType == TAIL_TYPE_CAT && lowerBody == LOWER_BODY_TYPE_CAT && earType == EARS_CAT) { //Check for gain of cat agility - requires legs, tail, and ears
				if (findPerk(PerkLib.Flexibility) < 0) {
					outputText("\nWhile stretching, you notice that you're much more flexible than you were before.  Perhaps this will make it a bit easier to dodge attacks in battle?\n\n(<b>Gained Perk: Flexibility</b>)\n");
					createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
					needNext = true;
				}
			}
			else if (findPerk(PerkLib.Flexibility) >= 0) { //Remove flexibility perk if not meeting requirements
				outputText("\nYou notice that you aren't as flexible as you were when you had a more feline body.  It'll probably be harder to avoid your enemies' attacks now.\n\n(<b>Lost Perk: Flexibility</b>)\n");
				removePerk(PerkLib.Flexibility);
				needNext = true;
			}
			if (flags[kFLAGS.FOX_BAD_END_WARNING] == 1) {
				if (faceType != FACE_FOX || tailType != TAIL_TYPE_FOX || earType != EARS_FOX || lowerBody != LOWER_BODY_TYPE_FOX || skinType != SKIN_TYPE_FUR) {
					flags[kFLAGS.FOX_BAD_END_WARNING] = 0;
				}
			}
			if (findPerk(PerkLib.EnlightenedNinetails) >= 0 || findPerk(PerkLib.CorruptedNinetails) >= 0) { //Check ninetails perks!
				if (tailType != TAIL_TYPE_FOX || tailVenom < 9) {
					outputText("\n<b>Without your tails, the magic power they once granted withers and dies, vanishing completely.</b>\n");
					removePerk(PerkLib.EnlightenedNinetails);
					removePerk(PerkLib.CorruptedNinetails);
					needNext = true;
				}
			}
			if (lowerBody == LOWER_BODY_TYPE_HARPY && tailType == TAIL_TYPE_HARPY && findPerk(PerkLib.HarpyWomb) >= 0) { //Make eggs big if harpied!
				if (findStatusAffect(StatusAffects.Eggs) >= 0 && statusAffectv2(StatusAffects.Eggs) == 0) {
					changeStatusValue(StatusAffects.Eggs, 2, 1);
					outputText("\n<b>A familiar, motherly rumble lets you know that your harpy-like womb is growing your eggs nice and large.</b>\n");
					needNext = true;
				}
			}
			if (!hasVagina() && findPerk(PerkLib.Diapause) >= 0) { //Lose diapause
				outputText("\n<b>With the loss of your womb, you lose your kangaroo-like diapause ability.</b>\n");
				removePerk(PerkLib.Diapause);
				needNext = true;
			}
			if (lowerBody == LOWER_BODY_TYPE_NAGA) {
				if (tailType > TAIL_TYPE_NONE) {
					outputText("\nYour tail squirms, wriggling against your larger naga tail as the scales part around it, absorbing it.  <b>Your form is completely scaly and smooth from the waist down.</b>\n");
					tailType = TAIL_TYPE_NONE;
					needNext = true;
				}
			}
			if (findPerk(PerkLib.WetPussy) >= 0 && vaginas.length > 0) {
				if (vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) {
					outputText("\n<b>Your " + vaginaDescript(0) + " returns to its normal, wet state.</b>\n");
					vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
					needNext = true;
				}
			}
			if (findPerk(PerkLib.MaraesGiftButtslut) >= 0 && ass.analWetness < 2) { //Prevent Buttsluts from getting dry backdoors
				outputText("\n<b>Your " + game.assholeDescript() + " quickly re-moistens.  It looks like Marae's 'gift' can't be removed.</b>\n");
				ass.analWetness = 2;
				needNext = true;
			}
			if (pregnancyIncubation <= 0 && pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) { //Fixing Egg Preg Preglocked Glitch
				knockUpForce(); //Clear Pregnancy
			}
			if (findStatusAffect(StatusAffects.Uniball) >= 0 && ballSize > 1 && balls > 0) { //Testicles Normalise:
				outputText("\nYou feel a deep sensation of release around your genitals.  You sigh with relief and contentment as your testicles drop downwards and bloom outwards, heat throbbing within them as they split and form a proper ballsack.\n");
				removeStatusAffect(StatusAffects.Uniball);
				needNext = true;
			}		
			if (findPerk(PerkLib.Androgyny) < 0) { //Fix femininity ratings if out of whack!
				var textHolder:String = fixFemininity();
				if (textHolder != "") {
					outputText(textHolder, false);
					needNext = true;
				}
			}
			if (findStatusAffect(StatusAffects.LustStickApplied) >= 0) { //Lust stick!
				addStatusValue(StatusAffects.LustStickApplied, 1, -1); //Decrement!
				if (statusAffectv1(StatusAffects.LustStickApplied) <= 0) {
					removeStatusAffect(StatusAffects.LustStickApplied);
					outputText("<b>\nYour drugged lipstick fades away, leaving only the faintest residue on your lips.  You'll have to put on more if you want to be able to kiss your foes into submission!</b>\n");
				}
			}
			if (findStatusAffect(StatusAffects.Luststick) >= 0) { //Luststic countdown
				addStatusValue(StatusAffects.Luststick, 1, -1);
				if (rand(2) == 0 && hasCock()) { //50% chance to lust spike
					//Display if haven't displayed
					if (flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED] == 0) {
						outputText("\nYour body tingles, practically a slave to the effects of harpy lipstick.  Blood surges to " + game.sMultiCockDesc() + ", making you groan out loud with forced pleasure.  Unasked-for fantasies assault you, and you spend a few moments fantasizing about fucking feathery women before you come to your senses.\n");
						flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED]++;
						needNext = true;
					}
					game.dynStats("lus", .1);
					lust += 20;
					if (lust > 100) lust = 100;
				}
				if (statusAffectv1(StatusAffects.Luststick) <= 0) {
					removeStatusAffect(StatusAffects.Luststick);
					outputText("\n<b>The lust-increasing effects of harpy lipstick have worn off!\n</b>");
					needNext = true;
				}
			}
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285] >= 50 && findPerk(PerkLib.LuststickAdapted) < 0) { //Luststick resistance unlock
				game.sophieBimbo.unlockResistance();
				if (findStatusAffect(StatusAffects.Luststick) >= 0) removeStatusAffect(StatusAffects.Luststick);
				needNext = true;
			}
			if (flags[kFLAGS.DICK_EGG_INCUBATION] > 0) {
				flags[kFLAGS.DICK_EGG_INCUBATION]--;
				trace("DICK BIRTH TIMER: " + flags[kFLAGS.DICK_EGG_INCUBATION]);
				if (flags[kFLAGS.DICK_EGG_INCUBATION] == 1) {
					game.birthBeeEggsOutYourWang();
					needNext = true;
				}
			}
			if (findStatusAffect(StatusAffects.Eggchest) >= 0) { //Eggs in tits!
				addStatusValue(StatusAffects.Eggchest, 1, -1);
				if (statusAffectv1(StatusAffects.Eggchest) <= 0) {
					outputText("\n<b>You feel the rounded eggs within your [fullChest] vanishing, absorbed into your body.  </b>");
					growTits(statusAffectv2(StatusAffects.Eggchest), bRows(), true, 2);
					outputText("\n");	
					removeStatusAffect(StatusAffects.Eggchest);
					needNext = true;
				}
			}
			if (findPerk(PerkLib.SpiderOvipositor) >= 0 || findPerk(PerkLib.BeeOvipositor) >= 0) { //Spider and Bee ovipositor updates
				if (findPerk(PerkLib.SpiderOvipositor) >= 0 && (!isDrider() || tailType != TAIL_TYPE_SPIDER_ADBOMEN)) { //Remove dat shit!
					outputText("\nYour ovipositor (and eggs) vanish since your body has become less spider-like.</b>\n");
					removePerk(PerkLib.SpiderOvipositor);
					needNext = true;
				}
				else if (findPerk(PerkLib.BeeOvipositor) >= 0 && tailType != TAIL_TYPE_BEE_ABDOMEN) { //Remove dat shit!
					outputText("\nYour ovipositor (and eggs) vanish since your body has become less bee-like.</b>\n");
					removePerk(PerkLib.BeeOvipositor);
					needNext = true;
				}
				else { //Update stuff!
					var prevEggs:int = eggs();
					if (prevEggs < 10) {
						addEggs(2);
					}
					else if (prevEggs < 20 && game.model.time.hours % 2 == 0) {
						addEggs(1);
					}
					else if (game.model.time.hours % 4 == 0) {
						addEggs(1);
					}
					if (prevEggs < 10 && eggs() >= 10) { //Stage 1 egg message
						if (findPerk(PerkLib.SpiderOvipositor) >= 0) {
							outputText("\nYou feel a certain fullness building in your spider-half's abdomen.");
						}
						else {
							outputText("\nYou feel a certain fullness building in your insectile abdomen.  You have some eggs ready... and you feel a strange urge to have them fertilized.");
							if (!hasVagina()) outputText("  Wait, how would you even go about that?");
						}
						outputText("  <b>You have enough eggs to lay!</b>\n");
						needNext = true;
					}
					else if (prevEggs < 20 && eggs() >= 20) { //Stage 2 egg message
						if (findPerk(PerkLib.SpiderOvipositor) >= 0) {
							outputText("\nYour spider body feels like it's stretched taut, and a heavy warmth has spread throughout it.  The sensation of eggs piling up inside you is enough to drive you to distraction.  It would be a good idea to find somewhere to deposit them - but, oh, how great it would feel to get them fertilized by a nice hard cock first!");
							if (!hasVagina()) outputText("  Wait, that's not right...");
						}
						else {
							outputText("\nYour abdomen feels like it's stretched taut, and a heavy warmth has spread throughout it.  It swings pendulously with every movement you make, and the sensation of eggs piling up inside you is enough to drive you to distraction.");
						}
						outputText("\n\n<b>Minimum Lust raised!</b>\n");
						needNext = true;
					}
					else if (prevEggs < 40 && eggs() >= 40) { //Stage 3 egg message
						if (findPerk(PerkLib.SpiderOvipositor) >= 0) {
							outputText("\nYour lower half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...\n\n<b>Minimum Lust raised!</b>\n");
						}
						else {
							outputText("\nYour bee half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its sweet, slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...\n");
						}
						game.dynStats("spe", -1);
						needNext = true;
					}
				}
			}
			if (findPerk(PerkLib.Oviposition) >= 0 || findPerk(PerkLib.BunnyEggs) >= 0) { //Oviposition perk for lizard and bunny folks
				if ((nagaScore() + lizardScore() < 3) && findPerk(PerkLib.Oviposition) >= 0 && findPerk(PerkLib.BasiliskWomb) < 0) { //--Lose Oviposition perk if lizard score gets below 3.
					outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost a little bit of reptilian reproductive ability.\n(<b>Perk Lost: Oviposition</b>)\n");
					removePerk(PerkLib.Oviposition);
					needNext = true;
				}
				else if (bunnyScore() < 3 && findPerk(PerkLib.BunnyEggs) >= 0) { //--Lose Oviposition perk if bunny score gets below 3.
					outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost your ability to spontaneously lay eggs.\n(<b>Perk Lost: Bunny Eggs</b>)\n");
					removePerk(PerkLib.BunnyEggs);
					needNext = true;
				}
				else if (pregnancyIncubation < 1 && hasVagina() && game.model.time.hours == 1) { //Otherwise pregger check, once every morning
					if ((totalFertility() > 50 && game.model.time.days % 15 == 0) || game.model.time.days % 30 == 0) { //every 15 days if high fertility get egg preg
						outputText("\n<b>Somehow you know that eggs have begun to form inside you.  You wonder how long it will be before they start to show?</b>\n");
						knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS, 1, 1);
						createStatusAffect(StatusAffects.Eggs, rand(6), rand(2), (5 + rand(3)), 0); //v1 is type, v2 is size (1 == large) and v3 is quantity
						addPerkValue(PerkLib.Oviposition, 1, 1); //Count times eggpregged this way in perk.
						needNext = true;
					}
				}
			}
			if (inHeat) { //Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
				if (statusAffectv3(StatusAffects.Heat) <= 1 || vaginas.length == 0) { //Remove bonus libido from heat
					game.dynStats("lib", -statusAffect(findStatusAffect(StatusAffects.Heat)).value2, "resisted", false, "noBimbo", true);
					removeStatusAffect(StatusAffects.Heat); //remove heat
					if (lib < 1) lib = 1;
					game.statScreenRefresh();
					outputText("\n<b>Your body calms down, at last getting over your heat.</b>\n");
					needNext = true;
				}
				else addStatusValue(StatusAffects.Heat, 3, -1);
			}
			
			if (inRut) { //Rut v1 is bonus cum, v2 is bonus libido, v3 is hours till it's gone
				trace("RUT:" + statusAffectv3(StatusAffects.Rut));
				if (statusAffectv3(StatusAffects.Rut) <= 1 || totalCocks() == 0) { //Remove bonus libido from rut
					game.dynStats("lib", -statusAffectv2(StatusAffects.Rut), "resisted", false, "noBimbo", true);
					removeStatusAffect(StatusAffects.Rut); //remove heat
					if (lib < 10) lib = 10;
					game.statScreenRefresh();
					outputText("\n<b>Your body calms down, at last getting over your rut.</b>\n");
					needNext = true;
				}
				else addStatusValue(StatusAffects.Rut, 3, -1);
			}
			if (findStatusAffect(StatusAffects.LustyTongue) >= 0) { //Lusty Tongue Check!
				if (rand(5) == 0) {
					outputText("\nYou keep licking your lips, blushing with the sexual pleasure it brings you.");
					game.dynStats("lus", 2 + rand(15));
					if (lust >= 100) {
						outputText("  Your knees lock from the pleasure, and you fall back in pleasure, twisting and moaning like a whore as you somehow orgasm from your mouth.  When it finishes, you realize your mouth feels even more sensitive than before.");
						orgasm();
						game.dynStats("sen", 2);
						changeStatusValue(StatusAffects.LustyTongue, 1, statusAffectv1(StatusAffects.LustyTongue) + 10); //Tongue orgasming makes it last longer.
						
					}
					outputText("\n");			
					needNext = true;
				}
				changeStatusValue(StatusAffects.LustyTongue, 1, statusAffectv1(StatusAffects.LustyTongue) - 1); //Decrement
				if (statusAffectv1(StatusAffects.LustyTongue) <= 0) {
					removeStatusAffect(StatusAffects.LustyTongue);
					outputText("\nYour mouth and tongue return to normal.\n");
					needNext = true;
				}
			}
			if (statusAffectv2(StatusAffects.Kelt) > 0) addStatusValue(StatusAffects.Kelt, 2, -0.15); //Reduce kelt submissiveness by 1 every 5 hours
			//Mino cum update.
			if (game.mountain.minotaurScene.minoCumUpdate()) {
				needNext = true;
			}
			else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 2 && game.model.time.hours % 13 == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] == 0) { //Repeated warnings!
				if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2)
					outputText("\n<b>You shiver, feeling a little cold.  Maybe you ought to get some more minotaur cum?  You just don't feel right without that pleasant buzz in the back of your mind.</b>\n");
				else if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3)
					outputText("\n<b>The steady fire of lust within you burns hot, making you shiver and grab at your head.  You're STILL in withdrawal after having gone so long without a dose of minotaur love.  You just know you're going to be horny and achy until you get some.</b>\n");
				needNext = true;
			}
			//Decrement mino withdrawal symptoms display cooldown
			//flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] prevents PC getting two of the same notices overnite
			else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330]--;
			if (findPerk(PerkLib.FutaForm) >= 0) { //Futa checks
				if (!hasCock()) { //(Dick regrowth)
					createCock();
					cocks[0].cockLength = 10;
					cocks[0].cockThickness = 2.75;
					outputText("\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, 10-inch cock pulses happily.");
					if (balls == 0) {
						outputText("  A pair of heavy balls drop into place below it, churning to produce cum.");
						balls = 2;
						ballSize = 3;
					}
					game.dynStats("int", -1, "sen", 5, "lus", 15);
					outputText("</b>\n");
					needNext = true;
				}
				if (cocks[0].cockLength < 8) { //(Dick rebiggening) 
					outputText("\n<b>As time passes, your cock engorges, flooding with blood and growing until it's at 8 inches long.  You really have no control over your dick.</b>\n");
					cocks[0].cockLength = 8;
					if (cocks[0].cockThickness < 2) cocks[0].cockThickness = 2;
					needNext = true;
				}
				if (balls == 0) { //(Balls regrowth)
					outputText("\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath " + game.sMultiCockDesc() + " grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>\n");
					balls = 2;
					ballSize = 3;
					needNext = true;
				}
				if (breastRows[0].breastRating < 5) { //Tits!
					breastRows[0].breastRating = 5;
					if (findPerk(PerkLib.FutaFaculties) >= 0)
						outputText("\n<b>Your tits get nice and full again.  You'll have lots of fun now that your breasts are back to being big, swollen knockers!</b>\n");
					else outputText("\n<b>Your " + game.breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n");
					game.dynStats("int", -1, "lus", 15);
					needNext = true;
				}
				if (!hasVagina()) { //Vagoo
					createVagina();
					if (findPerk(PerkLib.FutaFaculties) >= 0)
						outputText("\n<b>Your crotch is like, all itchy an' stuff.  Damn!  There's a wet little slit opening up, and it's all tingly!  It feels so good, why would you have ever gotten rid of it?</b>\n");
					else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n");
					game.dynStats("int", -1, "sen", 10, "lus", 15);
					needNext = true;
				}
			}
			if (findPerk(PerkLib.BimboBody) >= 0 || findStatusAffect(StatusAffects.BimboChampagne) >= 0) { //Bimbo checks
				if (breastRows[0].breastRating < 5) { //Tits!
					breastRows[0].breastRating = 5;
					if (findPerk(PerkLib.BimboBrains) >= 0 || findStatusAffect(StatusAffects.BimboChampagne) >= 0)
						outputText("\n<b>Your boobies like, get all big an' wobbly again!  You'll have lots of fun now that your tits are back to being big, yummy knockers!</b>\n");
					else outputText("\n<b>Your " + game.breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n");
					game.dynStats("int", -1, "lus", 15);
					needNext = true;
				}
				if (!hasVagina()) { //Vagoo
					createVagina();
					if (findPerk(PerkLib.BimboBrains) >= 0 || findStatusAffect(StatusAffects.BimboChampagne) >= 0)
						outputText("\n<b>Your crotch is like, all itchy an' stuff.  Omigawsh!  There's a wet little slit opening up, and it's all tingly!  It feels so good, maybe like, someone could put something inside there!</b>\n");
					else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n");
					needNext = true;
				}
				if (hipRating < 12) {
					if (findPerk(PerkLib.BimboBrains) >= 0 || findPerk(PerkLib.FutaFaculties) >= 0)
						outputText("\nWhoah!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate on a tittering bimbo.  You giggle when you realize you can't walk any other way.  At least it makes you look, like, super sexy!\n");
					else outputText("\nOh, no!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate for a bimbo.  Once you realize that you can't walk any other way, you sigh heavily, your only consolation the fact that your widened hips can be used to tease more effectively.\n");
					game.dynStats("int", -1);
					hipRating = 12;
					needNext = true;
				}
				if (buttRating < 12) {
					if (findPerk(PerkLib.BimboBrains) >= 0 || findPerk(PerkLib.FutaFaculties) >= 0)
						outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  You smile to yourself, imagining how much you wish you had a nice, plump, bimbo-butt again, your hands finding their way to the flesh on their own.  Like, how did they get down there?  You bite your lip when you realize how good your tush feels in your hands, particularly when it starts to get bigger.  Are butts supposed to do that?  Happy pink thoughts wash that concern away - it feels good, and you want a big, sexy butt!  The growth stops eventually, and you pout disconsolately when the lusty warmth's last lingering touches dissipate.  Still, you smile when you move and feel your new booty jiggling along behind you.  This will be fun!\n");
					else outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  Oh, no!  You thought that having a big, bloated bimbo-butt was a thing of the past, but with how it's tingling under your groping fingertips, you have no doubt that you're about to see the second coming of your sexy ass.  Wait, how did your fingers get down there?  You pull your hands away somewhat guiltily as you feel your buttcheeks expanding.  Each time you bounce and shake your new derriere, you moan softly in enjoyment.  Damnit!  You force yourself to stop just as your ass does, but when you set off again, you can feel it bouncing behind you with every step.  At least it'll help you tease your foes a little more effectively...\n");
					game.dynStats("int", -1, "lus", 10);
					buttRating = 12;
					needNext = true;
				}
			}
			if (findPerk(PerkLib.BroBody) >= 0) { //Bro checks
				removeStatusAffect(StatusAffects.Feeder);
				removePerk(PerkLib.Feeder);
				if (!hasCock()) { //(Dick regrowth) 
					createCock();
					cocks[0].cockLength = 10;
					cocks[0].cockThickness = 2.75;
					outputText("\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, 10-inch cock pulses happily.");
					if (balls == 0) {
						outputText("  A pair of heavy balls drop into place below it, churning to produce cum.");
						balls = 2;
						ballSize = 3;
					}
					outputText("</b>\n");
					needNext = true;
				}
				if (cocks[0].cockLength < 10) { //(Dick rebiggening)
					outputText("\n<b>As time passes, your cock engorges, flooding with blood and growing until it's at 10 inches long.  ");
					if (findPerk(PerkLib.BroBrains) >= 0) outputText("Goddamn, that thing is almost as tough as you!  ");
					outputText("You really have no control over your dick.</b>\n");
					cocks[0].cockLength = 10;
					if (cocks[0].cockThickness < 2) cocks[0].cockThickness = 2;
					needNext = true;
				}
				if (balls == 0) { //(Balls regrowth)
					outputText("\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath " + game.sMultiCockDesc() + " grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>\n");
					balls = 2;
					ballSize = 3;
					needNext = true;
				}
			}
			if (findStatusAffect(StatusAffects.Feeder) >= 0) { //Feeder checks
				if (cor <= 20) { //Go away if pure
					outputText("\nThe desire to breastfeed fades into the background.  It must have been associated with the corruption inside you.\n\n(<b>You have lost the 'Feeder' perk.</b>)\n");
					removeStatusAffect(StatusAffects.Feeder);
					removePerk(PerkLib.Feeder);
					needNext = true;
				}
				else { //Bigga titayz
					if (breastRows[0].breastRating < 5) {
						outputText("\nYour " + game.breastDescript(0) + " start to jiggle and wobble as time passes, seeming to refill with your inexhaustible supply of milk.  It doesn't look like you'll be able to keep them below a DD cup so long as you're so focused on breast-feeding.\n");
						breastRows[0].breastRating = 5;
						needNext = true;
					}
					addStatusValue(StatusAffects.Feeder, 2, 1); //Increase 'time since breastfed'
					//trace("Feeder status: " + player.statusAffectv2(StatusAffects.Feeder) + " (modded " + ((player.statusAffectv2(StatusAffects.Feeder)) - 70) + ")");
					//After 3 days without feeding someone sensitivity jumps.
					if (statusAffectv2(StatusAffects.Feeder) >= 72 && game.model.time.hours == 14) {
						outputText("\n<b>After having gone so long without feeding your milk to someone, you're starting to feel strange.  Every inch of your skin practically thrums with sensitivity, particularly your sore, dripping nipples.</b>\n");
						game.dynStats("sen", 2 + (((statusAffectv2(StatusAffects.Feeder)) - 70) / 20));
						needNext = true;
					}
				}
			}
			if (findStatusAffect(StatusAffects.WormPlugged) >= 0 && flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] == 0) { //Update worm drippy-cooch
				if (hasVagina()) {
					if (rand(5) == 0) {
						flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] = 1;
						outputText("\nA sudden gush of semen-coated worms noisily slurps out of your womb.  It runs down your legs as the worms do their damnedest to escape.  The feeling of so many squiggling forms squirting through your cunt-lips turns you on more than you'd like to admit.  You wonder why they stayed as long as they did, and some part of you worries that their stay may have reduced your capacity to bear children, though in a place like this that might be a blessing.\n");
						game.dynStats("lus", 2 + sens / 10);
						if (fertility > 5) fertility -= (1 + Math.round(fertility / 4));
						addStatusValue(StatusAffects.WormPlugged, 1, -1); //Lower chances
						if (statusAffectv1(StatusAffects.WormPlugged) <= 0) { //Remove if too low
							removeStatusAffect(StatusAffects.WormPlugged);
							knockUpForce(); //Clear worm 'pregnancy'
						}
						needNext = true;
					}
				}
				else { //Non cunts lose worm plugged
					removeStatusAffect(StatusAffects.WormPlugged);
					knockUpForce(); //Clear worm 'pregnancy'
				}
			}				
			if (findStatusAffect(StatusAffects.Milked) >= 0) { //"Milked"
				addStatusValue(StatusAffects.Milked, 1, -1);
				if (statusAffectv1(StatusAffects.Milked) <= 0) {
					outputText("\n<b>Your " + game.nippleDescript(0) + "s are no longer sore from the milking.</b>\n");
					removeStatusAffect(StatusAffects.Milked);
					needNext = true;
				}
			}
			if (findStatusAffect(StatusAffects.Jizzpants) >= 0) {
				outputText("\nYour " + armorName + " squishes wetly with all the semen you unloaded into them, arousing you more and more with every movement.\n");
				game.dynStats("lus", 10 + sens / 5);
				removeStatusAffect(StatusAffects.Jizzpants);
				needNext = true;
			}
			if (findStatusAffect(StatusAffects.Dysfunction) >= 0) {
				if (statusAffectv1(StatusAffects.Dysfunction) <= 1) {
					removeStatusAffect(StatusAffects.Dysfunction);
					outputText("\nYou feel a tingling in your nethers... at last full sensation has returned to your groin.  <b>You can masturbate again!</b>\n");
					needNext = true;
				}
				else addStatusValue(StatusAffects.Dysfunction, 1, -1);
			}
			if (findStatusAffect(StatusAffects.LactationReduction) < 0) { //Lactation reduction
				if (biggestLactation() > 0)	createStatusAffect(StatusAffects.LactationReduction, 0, 0, 0, 0);
			}
			else if (biggestLactation() > 0 && findStatusAffect(StatusAffects.Feeder) < 0 && pregnancyIncubation == 0) {
				addStatusValue(StatusAffects.LactationReduction, 1, 1);
				if (statusAffectv1(StatusAffects.LactationReduction) >= 48) {
					if (findStatusAffect(StatusAffects.LactationReduc0) < 0) {
						createStatusAffect(StatusAffects.LactationReduc0, 0, 0, 0, 0);
						if (biggestLactation() >= 1) outputText("\n<b>Your " + game.nippleDescript(0) + "s feel swollen and bloated, needing to be milked.</b>\n");
						if (biggestLactation() <= 2) createStatusAffect(StatusAffects.LactationReduc1, 0, 0, 0, 0);
						if (biggestLactation() <= 1) createStatusAffect(StatusAffects.LactationReduc2, 0, 0, 0, 0);
						needNext = true;
					}
					boostLactation(-0.5 * breastRows.length / 24);
					if (biggestLactation() <= 2.5 && findStatusAffect(StatusAffects.LactationReduc1) < 0) {
						outputText("\n<b>Your breasts feel lighter as your body's milk production winds down.</b>\n");
						createStatusAffect(StatusAffects.LactationReduc1, 0, 0, 0, 0);
						needNext = true;
					}
					else if (biggestLactation() <= 1.5 && findStatusAffect(StatusAffects.LactationReduc2) < 0) {
						outputText("\n<b>Your body's milk output drops down to what would be considered 'normal' for a pregnant woman.</b>\n");
						createStatusAffect(StatusAffects.LactationReduc2, 0, 0, 0, 0);
						needNext = true;
					}
					if (biggestLactation() < 1 && findStatusAffect(StatusAffects.LactationReduc3) < 0) {
						createStatusAffect(StatusAffects.LactationReduc3, 0, 0, 0, 0);
						outputText("\n<b>Your body no longer produces any milk.</b>\n");
						removeStatusAffect(StatusAffects.LactationReduction);
						needNext = true;
					}
				}
			}
			if (findStatusAffect(StatusAffects.CuntStretched) >= 0) { //Cunt stretching stuff
				addStatusValue(StatusAffects.CuntStretched, 1, 1);
				if (vaginas.length > 0) {
					if (findPerk(PerkLib.FerasBoonWideOpen) < 0) {
						if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE && statusAffectv1(StatusAffects.CuntStretched) >= 200) {
							outputText("\nYour " + game.vaginaDescript(0) + " recovers from your ordeals, tightening up a bit.\n");
							vaginas[0].vaginalLooseness--;
							changeStatusValue(StatusAffects.CuntStretched, 1, 0);
							needNext = true;
						}
						if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING && statusAffectv1(StatusAffects.CuntStretched) >= 100) {
							outputText("\nYour " + game.vaginaDescript(0) + " recovers from your ordeals, tightening up a bit.\n");
							vaginas[0].vaginalLooseness--;
							changeStatusValue(StatusAffects.CuntStretched, 1, 0);
							needNext = true;
						}
						if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE && statusAffectv1(StatusAffects.CuntStretched) >= 70) {
							outputText("\nYour " + game.vaginaDescript(0) + " recovers from your ordeals and becomes tighter.\n");
							vaginas[0].vaginalLooseness--;
							changeStatusValue(StatusAffects.CuntStretched, 1, 0);
							needNext = true;
						}
					}
					if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR && statusAffectv1(StatusAffects.CuntStretched) >= 50) {
						outputText("\nYour " + game.vaginaDescript(0) + " recovers from the brutal stretching it has received and tightens up a little bit, but not much.\n");
						vaginas[0].vaginalLooseness--;
						changeStatusValue(StatusAffects.CuntStretched, 1, 0);
						needNext = true;
					}
				}
			}
			if (findStatusAffect(StatusAffects.ButtStretched) >= 0) { //Butt stretching stuff
				addStatusValue(StatusAffects.ButtStretched, 1, 1);
				if (ass.analLooseness == 2 && statusAffectv1(StatusAffects.ButtStretched) >= 72) {
					outputText("\n<b>Your " + game.assholeDescript() + " recovers from your ordeals, tightening up a bit.</b>\n");
					ass.analLooseness--;
					changeStatusValue(StatusAffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (ass.analLooseness == 3 && statusAffectv1(StatusAffects.ButtStretched) >= 48) {
					outputText("\n<b>Your " + game.assholeDescript() + " recovers from your ordeals, tightening up a bit.</b>\n");
					ass.analLooseness--;
					changeStatusValue(StatusAffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (ass.analLooseness == 4 && statusAffectv1(StatusAffects.ButtStretched) >= 24) {
					outputText("\n<b>Your " + game.assholeDescript() + " recovers from your ordeals and becomes tighter.</b>\n");
					ass.analLooseness--;
					changeStatusValue(StatusAffects.ButtStretched, 1, 0);
					needNext = true;
				}
				if (ass.analLooseness == 5 && statusAffectv1(StatusAffects.ButtStretched) >= 12) {
					outputText("\n<b>Your " + game.assholeDescript() + " recovers from the brutal stretching it has received and tightens up.</b>\n");
					ass.analLooseness--;
					changeStatusValue(StatusAffects.ButtStretched, 1, 0);
					needNext = true;
				}
			}
			if (findPerk(PerkLib.SlimeCore) >= 0) { //Lose slime core perk
				if (vaginalCapacity() < 9000 || skinAdj != "slimy" || skinDesc != "skin" || lowerBody != LOWER_BODY_TYPE_GOO) {
					outputText("\nYour form ripples, as if uncertain at the changes your body is undergoing.  The goo of your flesh cools, its sensitive, responsive membrane thickening into " + skin() + " while bones and muscles knit themselves into a cohesive torso, chest and hips gaining definition.  Translucent ooze clouds and the gushing puddle at your feet melts together, splitting into solid trunks as you regain your legs.  Before long, you can no longer see through your own body and, with an unsteady shiver, you pat yourself down, readjusting to solidity.  A lurching heat in your chest suddenly reminds you of the slime core that used to float inside you.  Gingerly touching your " + game.chestDesc() + ", you can feel a small, second heartbeat under your ribs that gradually seems to be sinking, past your belly. A lurching wave of warmth sparks through you, knocking you off your fresh legs and onto your " + game.buttDescript() + ".  A delicious pressure pulses in your abdomen and you loosen your " + armorName + " as sweat beads down your neck.  You clench your eyes, tongue lolling in your mouth, and the pressure builds and builds until, in ecstatic release, your body arches in an orgasmic release.\n\n");
	
					outputText("\nPanting, you open your eyes and see that, for once, the source of your climax wasn't your loins.  Feeling a warm, wetness on your abs, you investigate and find the small, heart-shaped nucleus that used to be inside your body has somehow managed to pass through your belly button. Exposed to the open air, the crimson organ slowly crystallizes, shrinking and hardening into a tiny ruby.  Rubbing the stone with your thumb, you're surprised to find that you can still feel a pulse within its glittering facets.  You stow the ruby heart, in case you need it again.\n");
					createKeyItem("Ruby Heart", 0, 0, 0, 0); //[Add 'Ruby Heart' to key items. Player regains slime core if returning to goo body]
					removePerk(PerkLib.SlimeCore);
					needNext = true;
				}
			}
			if (hasKeyItem("Ruby Heart") >= 0) { //Regain slime core
				if (findStatusAffect(StatusAffects.SlimeCraving) >= 0 && findPerk(PerkLib.SlimeCore) < 0 && isGoo() && gooScore() >= 4 && vaginalCapacity() >= 9000 && skinAdj == "slimy" && skinDesc == "skin" && lowerBody == LOWER_BODY_TYPE_GOO) {
					outputText("\nAs you adjust to your new, goo-like body, you remember the ruby heart you expelled so long ago.  As you reach to pick it up, it quivers and pulses with a warm, cheerful light.  Your fingers close on it and the nucleus slides through your palm, into your body!\n\n");
					
					outputText("There is a momentary pressure in your chest and a few memories that are not your own flicker before your eyes.  The dizzying sight passes and the slime core settles within your body, imprinted with your personality and experiences.  There is a comforting calmness from your new nucleus and you feel as though, with your new memories, you will be better able to manage your body's fluid requirements.\n");
					//(Reduces Fluid Addiction to a 24 hour intake requirement).
					outputText("(<b>Gained New Perk: Slime Core - Moisture craving builds at a greatly reduced rate.</b>\n)");
					createPerk(PerkLib.SlimeCore, 0, 0, 0, 0);
					removeKeyItem("Ruby Heart");
				}
			}
			if (findStatusAffect(StatusAffects.SlimeCraving) >= 0) { //Slime craving stuff
				if (vaginalCapacity() < 9000 || skinAdj != "slimy" || skinDesc != "skin" || lowerBody != LOWER_BODY_TYPE_GOO) {
					outputText("\n<b>You realize you no longer crave fluids like you once did.</b>\n");
					removeStatusAffect(StatusAffects.SlimeCraving);
					removeStatusAffect(StatusAffects.SlimeCravingFeed);
					needNext = true;
				}
				else { //Slime core reduces fluid need rate
					if (findPerk(PerkLib.SlimeCore) >= 0)
						addStatusValue(StatusAffects.SlimeCraving, 1, 0.5);
					else addStatusValue(StatusAffects.SlimeCraving, 1, 1);
					if (statusAffectv1(StatusAffects.SlimeCraving) >= 18) {
						if (findStatusAffect(StatusAffects.SlimeCravingOutput) < 0) {
							createStatusAffect(StatusAffects.SlimeCravingOutput, 0, 0, 0, 0);
							outputText("\n<b>Your craving for the 'fluids' of others grows strong, and you feel yourself getting weaker and slower with every passing hour.</b>\n");
							needNext = true;
						}
						game.dynStats("str", -0.1,"spe", -0.1, "lus", 2);
						//Keep track of how much has been taken from speed/strength
						addStatusValue(StatusAffects.SlimeCraving, 2, 0.1);
						if (str <= 1) { //Bad end!
							game.lake.gooGirlScene.slimeBadEnd();
							return true;
						}
					}
				}
			}
			if (findStatusAffect(StatusAffects.SlimeCravingFeed) >= 0) { //Slime feeding stuff
				outputText("\n<b>You feel revitalized from your recent intake, but soon you'll need more...</b>\n");
				game.dynStats("str", statusAffectv2(StatusAffects.SlimeCraving) * 0.5, "spe", statusAffectv2(StatusAffects.SlimeCraving)); //Boost speed and restore hp/toughness
				removeStatusAffect(StatusAffects.SlimeCravingFeed); //Remove feed succuss status so it can be reset
				changeStatusValue(StatusAffects.SlimeCraving, 2, 0); //Reset stored hp/toughness values
				needNext = true;
			}
			if (game.model.time.hours == 6 && armorName == "bimbo skirt" && rand(10) == 0) {
				outputText("\n<b>As you wake up, you feel a strange tingling starting in your nipples that extends down into your breasts.  After a minute, the tingling dissipates in a soothing wave.  As you cup your tits, you realize they've gotten larger!</b>");
				growTits(1, bRows(), false, 2);
				game.dynStats("lus", 10);
				needNext = true;
			}
			if (flags[kFLAGS.BIKINI_ARMOR_BONUS] > 0) {
				if (armorName == "lusty maiden's armor") {
					if (game.model.time.hours == 0) flags[kFLAGS.BIKINI_ARMOR_BONUS]--; //Adjust for inflation
					if (flags[kFLAGS.BIKINI_ARMOR_BONUS] < 0) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 0; //Keep in bounds.
					if (flags[kFLAGS.BIKINI_ARMOR_BONUS] > 8) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 8;
				}
				else flags[kFLAGS.BIKINI_ARMOR_BONUS] = 0;
			}
			
			//No better place for these since the code for the event is part of CoC.as or one of its included files
			if (flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] > 0) flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC]--; //Vala post-rape countdown
			if (flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] > 0 && flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] < 500) flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY]++;
			
			if (game.model.time.hours > 23) { //Once per day
				flags[kFLAGS.BROOKE_MET_TODAY] = 0;
				if (game.model.time.days % 2 == 0 && flags[kFLAGS.KAIJU_BAD_END_COUNTER] > 0) {
					flags[kFLAGS.KAIJU_BAD_END_COUNTER]--;
					if (flags[kFLAGS.KAIJU_BAD_END_COUNTER] < 0) flags[kFLAGS.KAIJU_BAD_END_COUNTER] = 0;
				}
				if (flags[kFLAGS.GILDED_JERKED] > 0) flags[kFLAGS.GILDED_JERKED] = 0;
				if (flags[kFLAGS.FED_SCYLLA_TODAY] == 1) flags[kFLAGS.FED_SCYLLA_TODAY] = 0;
				if (flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] != 0) flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] = 0;
				if (flags[kFLAGS.RUBI_PROSTITUTION] > 0) flags[kFLAGS.RUBI_PROFIT] += 2 + rand(4);
				flags[kFLAGS.BENOIT_TALKED_TODAY] = 0;
				game.bazaar.benoit.updateBenoitInventory();
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
				if (game.model.time.days % 7 == 0) flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] = 0; //Clear Whitney's Weekly limit
				if (flags[kFLAGS.USED_MILKER_TODAY] > 0) flags[kFLAGS.USED_MILKER_TODAY] = 0; //Clear 'has fucked milker today'
				if (game.latexGirl.latexGooFollower()) { //Latex goo follower daily updates
					game.latexGirl.gooFluid(-2, false);
					if (game.latexGirl.gooFluid() < 50) game.latexGirl.gooHappiness(-1, false);
					if (game.latexGirl.gooFluid() < 25) game.latexGirl.gooHappiness(-1, false);
					if (game.latexGirl.gooHappiness() < 75) game.latexGirl.gooObedience(-1, false);
					if (game.latexGirl.gooHappiness() >= 90) game.latexGirl.gooObedience(1, false);
				}
				game.farm.farmCorruption.updateFarmCorruption(); //Farm Corruption updating
				if (findStatusAffect(StatusAffects.Contraceptives) >= 0) { // Herbal contraceptives countdown
					if (statusAffectv1(StatusAffects.Contraceptives) == 1) {
						addStatusValue(StatusAffects.Contraceptives, 2, -1);
						if (statusAffectv1(StatusAffects.Contraceptives) < 0) removeStatusAffect(StatusAffects.Contraceptives);
					}
				}
				if (statusAffectv1(StatusAffects.SharkGirl) > 0) addStatusValue(StatusAffects.SharkGirl, 1, -1); //Lower shark girl counter
				if (flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] > 0) {
					switch (flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]) {
						case 1:
							if (!needNext) needNext = game.growHair(0.2);
							else game.growHair(0.2);
							break;
						case 2:
							if (!needNext) needNext = game.growHair(0.5);
							else game.growHair(0.5);
							break;
						case 3:
							if (!needNext) needNext = game.growHair(1.1);
							else game.growHair(1.1);
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
					if (!needNext) needNext = game.growHair(0.1);
					else game.growHair(0.1);
				}
				//Clear dragon breath cooldown!
				if (findStatusAffect(StatusAffects.DragonBreathCooldown) >= 0) removeStatusAffect(StatusAffects.DragonBreathCooldown);
			}
			return needNext;
		}
		
		public function timeChangeLarge():Boolean {
			if (rand(4) == 0 && game.isHolidays() && gender > 0 && game.model.time.hours == 6 && flags[kFLAGS.XMAS_CHICKEN_YEAR] < game.date.fullYear) {
				game.getAChristmasChicken();
				return true;
			}
			if (game.model.time.hours == 1 && game.isHolidays() && game.date.fullYear > flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE]) { //XMAS ELF
				game.xmasBitchEncounter(); //Set it to remember the last year encountered
				return true;
			}
			if (checkedTurkey++ == 0 && (rand(5) == 0 && (game.model.time.hours == 18 || game.model.time.hours == 19)) && (game.date.fullYear > flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] || flags[kFLAGS.MORE_TURKEY] > 0) && game.isThanksgiving() && gender > 0) {
				game.datTurkeyRumpMeeting(); //TURKEY SURPRISE
				return true;
			}
			if (checkedDream++ == 0 && game.model.time.hours == 3) { //You can only have one dream each night
				if (gender > 0 && game.model.time.days == 10) { //Day 10 dream - since this can happen only once it takes priority over all other dreams
					game.dayTenDreams();
					return true;
				}
				if (hasCock() && findPerk(PerkLib.BeeOvipositor) >= 0 && (eggs() >= 20 && rand(6) == 0)) { //Bee dreams proc
					//happens at first sleep after hitting stage 3 unfertilized
					//To Wong Foo, Thanks for Everything, Julie Newmar
					outputText("\nYou sit atop your favorite flower, enjoying the smell of verdure and the sounds of the forest.  The sun is shining brightly and it feels wonderful on your chitin.  Your wings twitch happily in the soft breeze, and it feels good to be alive and doing the colony's work... the only sour note is your heavy, bloated abdomen, so full of unfertilized eggs that it droops, so full it strains your back and pinches your nerves.  Still, it's too nice a day to let that depress you, and you take up your customary song, humming tunelessly but mellifluously as you wait for passers-by.");
					
					outputText("\n\nYour antennae bob - was that someone?  Peering between the trees from the corner of your eye, you can see the figure of another person, and you intensify your hypnotic buzz, trying to draw it closer.  The figure steps into your clearing and out of the shadow; clad in " + armorName + ", " + mf("he","she") + " is yourself!  Confused, you stop humming and stare into your own face, and the other you takes the opportunity to open " + mf("his","her") + " garments, exposing " + mf("his","her") + " [cock]!");
					
					outputText("\n\nStartled, you slip down from your seat and try to run, but the other you has already crossed the clearing and seizes you by the fuzz on your hefty, swollen abdomen; your leg slips, propelling you face-first to the ground.  " + mf("He","She") + " pulls you back toward " + mf("his","her") + "self and, grabbing one of your chitinous legs, turns you over.  The other you spreads your fuzzed thighs, revealing your soft, wet pussy, and the sweet smell of honey hits your noses.  " + mf("His","Her") + " prick hardens intensely and immediately at the aroma of your pheromone-laden nectar, and " + mf("he","she") + " pushes it into you without so much as a word of apology, groaning as " + mf("he","she") + " begins to rut you mercilessly.  You can feel the sensations of " + mf("his","her") + " burning cock as if it were your own, and your legs wrap around your other self instinctively even as your mind recoils in confusion.");
					
					outputText("\n\nThe other you grunts and locks up as " + mf("his","her") + "... your [cock] begins to spurt inside your honey-drooling cunt, and " + mf("he","she") + " falls onto you, bottoming out inside; your vagina likewise clenches and squirts your sweet juices.  As " + mf("he","she") + " ejaculates, thrusting weakly, you can feel something shifting in you, filling you with pins and needles... it feels like the warm cum " + mf("he","she") + "'s filling you with is permeating your entire groin, working its way back toward your abdomen.  It edges up to your massive buildup of eggs, and your body tightens in a second climax at the thought of having your children fertilized-");
					
					outputText("\n\nYou snap awake, sitting bolt upright.  What in the name of... your " + game.multiCockDescriptLight() + " is softening rapidly, and as you shift, you can feel your cum sloshing in your [armor].  For fuck's sake.");
					if (cumQ() >= 1000) outputText("  It's completely soaked your bedroll, too... you won't be sleeping on this again until you wash it out.  Grumbling, you roll the soggy, white-stained fabric up and stow it.");
					outputText("  The sensation of wetness inside your own clothes torments you as you try to return to sleep, driving up your lust and making you half-hard once again... the rumbling of eggs in your abdomen, as if they're ready to be laid, doesn't help either.");
					fertilizeEggs(); //convert eggs to fertilized based on player cum output, reduce lust by 100 and then add 20 lust
					orgasm(); //reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
					game.dynStats("lus", 20);
					game.doNext(1);
					//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
					//Hey whoever, maybe you write them? -Z
					return true;
				}
				if (hasCock() && findPerk(PerkLib.SpiderOvipositor) >= 0 && (eggs() >= 20 && rand(6) == 0)) { //Drider dreams proc
					outputText("\nIn a moonlit forest, you hang upside down from a thick tree branch suspended by only a string of webbing.  You watch with rising lust as a hapless traveler strolls along below, utterly unaware of the trap you've set.  Your breath catches as " + mf("he","she") + " finally encounters your web, flailing against the sticky strands in a futile attempt to free " + mf("him","her") + "self.  Once the traveller's struggles slow in fatigue, you descend easily to the forest floor, wrapping " + mf("him","her") + " in an elegant silk cocoon before pulling " + mf("him","her") + " up into the canopy.  Positioning your catch against the tree's trunk, you sink your fangs through the web and into flesh, feeling " + mf("his","her") + " body heat with every drop of venom.  Cutting " + mf("his","her") + " crotch free of your webbing, you open " + mf("his","her") + " [armor] and release the ");
					if (hasVagina()) outputText(game.vaginaDescript(0) + " and ");
					outputText(game.cockDescript(0) + " therein; you lower yourself onto " + mf("him","her") + " over and over again, spearing your eager pussy with " + mf("him","her") + " prick");
					if (hasVagina()) outputText(" while you bend and force your own into her cunt");
					outputText(".  It's not long until you feel ");
					if (hasVagina()) outputText("her pussy clenching around you as you orgasm explosively inside, followed by ");
					outputText("the sensation of warm wetness in your own vagina.  Your prisoner groans as " + mf("his","her") + " cock twitches and spasms inside you, spraying your insides with seed; warm, delicious, sticky seed for your eggs.  You can feel it drawing closer to your unfertilized clutch, and as the gooey heat pushes toward them, your head swims, and you finally look into your prey's [face]...");
					
					outputText("\n\nYour eyes flutter open.  What a strange dream... aw, dammit.  You can feel your [armor] rubbing against your crotch, sodden with cum.  ");
					if (cumQ() > 1000) outputText("It's all over your bedroll, too...");
					outputText("  Turning over and trying to find a dry spot, you attempt to return to sleep... the wet pressure against your crotch doesn't make it easy, nor do the rumbles in your abdomen, and you're already partway erect by the time you drift off into another erotic dream.  Another traveler passes under you, and you prepare to snare her with your web; your ovipositor peeks out eagerly and a bead of slime drips from it, running just ahead of the first fertilized egg you'll push into your poor victim...");
					fertilizeEggs(); //reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
					orgasm();
					game.dynStats("lus", 20);
					game.doNext(1);
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
				if (ceraph > 0 && game.model.time.days % ceraph == 0) {
					game.ceraphScene.ceraphBodyPartDreams();
					return true;
				}
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] < 4) { //Dominika Dream
					outputText("\n<b>Your rest is somewhat troubled with odd dreams...</b>\n");
					game.telAdre.dominika.fellatrixDream();
					return true;
				}
				if (game.anemoneScene.kidAXP() >= 40 && flags[kFLAGS.HAD_KID_A_DREAM] == 0 && gender > 0) {
					game.anemoneScene.kidADreams();
					flags[kFLAGS.HAD_KID_A_DREAM] = 1;
					return true;
				}
				if (viridianChange()) {
					game.fuckedUpCockDreamChange();
					return true;
				}
				if (lib > 50 || lust > 40) { //Randomly generated dreams here
					if (game.dreamSelect()) return true;
				}
			}
			return false;
		}
		
		//End of Interface Implementation
		protected final function outputText(text:String, clear:Boolean = false):void
		{
			game.outputText(text, clear);
		}
		
		//Autosave
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;

		//Lust vulnerability
		//TODO: Kept for backwards compatibility reasons but should be phased out.
		public var lustVuln:Number = 1;

		//Teasing attributes
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;

		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;

		//Number of times explored for new areas
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		//Player pregnancy variables and functions
		override public function pregnancyUpdate():Boolean {
			return game.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
		}

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlots:Array;

		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _modArmorName:String = "";

		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorPerk.");
		}


		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponValue.");
		}

		public function get modArmorName():String
		{
			if (_modArmorName == null) _modArmorName = "";
			return _modArmorName;
		}

		public function set modArmorName(value:String):void
		{
			if (value == null) value = "";
			_modArmorName = value;
		}

		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			return _armor.name;
		}
		override public function get armorDef():Number {
			var armorDef:Number = _armor.def;
			//Blacksmith history!
			if(armorDef > 0 && findPerk(PerkLib.HistorySmith) >= 0) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			//Skin armor perk
			if(findPerk(PerkLib.ThickSkin) >= 0) {
				armorDef += 2;
				if(skinType > SKIN_TYPE_PLAIN) armorDef += 1;
			}
			//If no skin armor perk scales rock
			else {
				if(skinType == SKIN_TYPE_FUR) armorDef += 1;
				if(skinType == SKIN_TYPE_SCALES) armorDef += 3;
			}
			//'Thick' dermis descriptor adds 1!
			if(skinAdj == "smooth") armorDef += 1;
			//Agility boosts armor ratings!
			if(findPerk(PerkLib.Agility) >= 0) {
				if(armorPerk == "Light") armorDef += Math.round(spe/8);
				else if(armorPerk == "Medium") armorDef += Math.round(spe/13);
			}
			//Berzerking removes armor
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) {
				armorDef = 0;
			}
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.TailWhip) >= 0) {
				armorDef -= kGAMECLASS.monster.statusAffectv1(StatusAffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			return armorDef;
		}
		public function get armorBaseDef():Number {
			return _armor.def;
		}
		override public function get armorPerk():String {
			return _armor.perk;
		}
		override public function get armorValue():Number {
			return _armor.value;
		}
		private var _weapon:Weapon = WeaponLib.FISTS;
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var attack:Number = _weapon.attack;
			if(findPerk(PerkLib.WeaponMastery) >= 0 && weaponPerk == "Large" && str > 60)
				attack *= 2;
			if(findPerk(PerkLib.LightningStrikes) >= 0 && spe >= 60 && weaponPerk != "Large") {
				attack += Math.round((spe - 50) / 3);
			}
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) attack += 30;
			attack += statusAffectv1(StatusAffects.ChargeWeapon);
			return attack;
		}
		public function get weaponBaseAttack():Number {
			return _weapon.attack;
		}
		override public function get weaponPerk():String {
			return _weapon.perk || "";
		}
		override public function get weaponValue():Number {
			return _weapon.value;
		}

		public function get armor():Armor
		{
			return _armor;
		}
		
		public function setArmor(newArmor:Armor):Armor {
			//Returns the old armor, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldArmor:Armor = _armor.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newArmor == null) {
				CoC_Settings.error(short + ".armor is set to null");
				newArmor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			_armor = newArmor.playerEquip(); //The armor can also choose to equip something else - useful for Ceraph's trap armor
			return oldArmor;
		}
		
		/*
		public function set armor(value:Armor):void
		{
			if (value == null){
				CoC_Settings.error(short+".armor is set to null");
				value = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setArmorHiddenField(value:Armor):void
		{
			this._armor = value;
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}

		public function setWeapon(newWeapon:Weapon):Weapon {
			//Returns the old weapon, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeapon:Weapon = _weapon.playerRemove(); //The weapon is responsible for removing any bonuses, perks, etc.
			if (newWeapon == null) {
				CoC_Settings.error(short + ".weapon is set to null");
				newWeapon = WeaponLib.FISTS;
			}
			_weapon = newWeapon.playerEquip(); //The weapon can also choose to equip something else
			return oldWeapon;
		}
		
		/*
		public function set weapon(value:Weapon):void
		{
			if (value == null){
				CoC_Settings.error(short+".weapon is set to null");
				value = WeaponLib.FISTS;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setWeaponHiddenField(value:Weapon):void
		{
			this._weapon = value;
		}

		public function reduceDamage(damage:Number):Number{
			damage = int(damage - rand(tou) - armorDef);
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damage /= 2;
			if (findStatusAffect(StatusAffects.Shielding) >= 0) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Black cat beer = 25% reduction!
			if (statusAffectv1(StatusAffects.BlackCatBeer) > 0)
				damage = Math.round(damage * .75);

			//Take damage you masochist!
			if (findPerk(PerkLib.Masochist) >= 0 && lib >= 60) {
				damage = Math.round(damage * .7);
				game.dynStats("lus", 2);
				//Dont let it round too far down!
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.ImmovableObject) >= 0 && tou >= 75) {
				damage = Math.round(damage * .8);
				if (damage < 1) damage = 1;
			}

			// Uma's Massage bonuses
			var statIndex:int = findStatusAffect(StatusAffects.UmasMassage);
			if (statIndex >= 0) {
				if (statusAffect(statIndex).value1 == UmasShop.MASSAGE_RELAXATION) {
					damage = Math.round(damage * statusAffect(statIndex).value2);
				}
			}

			// Uma's Accupuncture Bonuses
			var modArmorDef:Number = 0;
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) modArmorDef = ((armorDef * UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI) - armorDef);
			if (findPerk(PerkLib.ChiReflowAttack) >= 0) modArmorDef = ((armorDef * UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI) - armorDef);
			damage -= modArmorDef;
			if (damage<0) damage = 0;
			return damage;
		}

		public function takeDamage(damage:Number):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				HP -= damage;
				game.mainView.statsView.showStatDown('hp');
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					game.dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(monster:Monster):int{
			var diff:Number = spe - monster.spe;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
		}

		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
			//SUPAH THIN
			if (thickness < 10)
			{
				//SUPAH BUFF
				if (tone > 90)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75)
					desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50)
					desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25)
					desc += "a lithe body and only a little bit of muscle definition";
				else
					desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25)
			{
				if (tone > 90)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 75)
					desc += "a narrow frame that shows off your muscles";
				else if (tone > 50)
					desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25)
					desc += "a narrow, soft body that still manages to show off a few muscles";
				else
					desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40)
			{
				if (tone > 90)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75)
					desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50)
					desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25)
					desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else
					desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60)
			{
				if (tone > 90)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75)
					desc += "an average-sized frame and great musculature";
				else if (tone > 50)
					desc += "a normal waistline and decently visible muscles";
				else if (tone > 25)
					desc += "an average body and soft, unremarkable flesh";
				else
					desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if (thickness < 75)
			{
				if (tone > 90)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75)
					desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50)
					desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25)
					desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else
					desc += "a soft, plush body with plenty of jiggle";
			}
			else if (thickness < 90)
			{
				if (tone > 90)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75)
					desc += "a burly form and plenty of muscle definition";
				else if (tone > 50)
					desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25)
					desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else
				{
					desc += "a wide, cushiony body";
					if (gender >= 2 || biggestTitSize() > 3 || hipRating > 7 || buttRating > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}

		public function race():String
		{
			//Determine race type:
			var race:String = "human";
			if (lowerBody == 4)
				race = "centaur";
			if (lowerBody == 11)
				race = "pony-kin";
			if (catScore() >= 4)
				race = "cat-" + mf("boy", "girl");
			if (lizardScore() >= 4)
			{
				if (gender == 0)
					race = "lizan";
				else if (gender == 1)
					race = "male lizan";
				else if (gender == 2)
					race = "female lizan";
				else
					race = "hermaphrodite lizan";
			}
			if (dragonScore() >= 4)
			{
				race = "dragon-morph";
				if (faceType == 0)
					race = "dragon-" + mf("man", "girl");
			}
			if (raccoonScore() >= 4)
			{
				race = "raccoon-morph";
				if (balls > 0 && ballSize > 5)
					race = "tanuki-morph";
			}
			if (dogScore() >= 4)
			{
				race = "dog-morph";
				if (faceType == 0)
					race = "dog-" + mf("man", "girl");
			}
			if (foxScore() >= 4)
			{
				if (skinType == 1)
					race = "fox-morph";
				else
					race = "fox-" + mf("morph", "girl");
			}
			if (ferretScore() >= 4)
			{
				if (skinType == 1)
					race = "ferret-morph";
				else
					race = "ferret-" + mf("morph", "girl");
			}
			if (kitsuneScore() >= 4)
			{
				race = "kitsune";
			}
			if (horseScore() >= 3)
			{
				if (lowerBody == 4)
					race = "centaur-morph";
				else
					race = "equine-morph";
			}
			if (mutantScore() >= 5 && race == "human")
				race = "corrupted mutant";
			if (minoScore() >= 4)
				race = "minotaur-morph";
			if (cowScore() > 5)
			{
				race = "cow-";
				race += mf("morph", "girl");
			}
			if (beeScore() >= 5)
				race = "bee-morph";
			if (goblinScore() >= 5)
				race = "goblin";
			if (humanScore() >= 5 && race == "corrupted mutant")
				race = "somewhat human mutant";
			if (demonScore() > 4)
				race = "demon-morph";
			if (sharkScore() >= 3)
				race = "shark-morph";
			if (bunnyScore() >= 4)
				race = "bunny-" + mf("boy", "girl");
			if (harpyScore() >= 4)
			{
				if (gender >= 2)
					race = "harpy";
				else
					race = "avian";
			}
			if (spiderScore() >= 4)
			{
				race = "spider-morph";
				if (mf("no", "yes") == "yes")
					race = "spider-girl";
				if (lowerBody == 16)
					race = "drider";
			}
			if (kangaScore() >= 4)
				race = "kangaroo-morph";
			if (mouseScore() >= 3)
			{
				if (faceType != 16)
					race = "mouse-" + mf("boy", "girl");
				else
					race = "mouse-morph";
			}
			if (lowerBody == 3)
				race = "naga";
			if (lowerBody == 4)
				race = "centaur";

			if (gooScore() >= 3)
			{
				race = "goo-";
				race += mf("boi", "girl");
			}
			return race;
		}

		//determine demon rating
		public function demonScore():Number
		{
			var demonCounter:Number = 0;
			if (hornType == 1 && horns > 0)
				demonCounter++;
			if (hornType == 1 && horns > 4)
				demonCounter++;
			if (tailType == 3)
				demonCounter++;
			if (wingType == 6 || wingType == 7)
				demonCounter++;
			if (skinType == 0 && cor > 50)
				demonCounter++;
			if (faceType == 0 && cor > 50)
				demonCounter++;
			if (lowerBody == 5 || lowerBody == 6)
				demonCounter++;
			if (demonCocks() > 0)
				demonCounter++;
			return demonCounter;
		}

		//Determine Human Rating
		public function humanScore():Number
		{
			var humanCounter:Number = 0;
			if (faceType == 0)
				humanCounter++;
			if (skinType == 0)
				humanCounter++;
			if (horns == 0)
				humanCounter++;
			if (tailType == 0)
				humanCounter++;
			if (wingType == 0)
				humanCounter++;
			if (lowerBody == 0)
				humanCounter++;
			if (normalCocks() == 1 && totalCocks() == 1)
				humanCounter++;
			if (breastRows.length == 1 && skinType == 0)
				humanCounter++;
			return humanCounter;
		}

		//Determine minotaur rating
		public function minoScore():Number
		{
			var minoCounter:Number = 0;
			if (faceType == 3)
				minoCounter++;
			if (earType == 3)
				minoCounter++;
			if (tailType == 4)
				minoCounter++;
			if (hornType == 2)
				minoCounter++;
			if (lowerBody == 1 && minoCounter > 0)
				minoCounter++;
			if (tallness > 80 && minoCounter > 0)
				minoCounter++;
			if (cocks.length > 0 && minoCounter > 0)
			{
				if (horseCocks() > 0)
					minoCounter++;
			}
			if (vaginas.length > 0)
				minoCounter--;
			return minoCounter;
		}

		public function get minotaurScore():Number
		{
			return this.minoScore();
		}

		//Determine cow rating
		public function cowScore():Number
		{
			var minoCounter:Number = 0;
			if (faceType == 0)
				minoCounter++;
			if (faceType == 3)
				minoCounter--;
			if (earType == 3)
				minoCounter++;
			if (tailType == 4)
				minoCounter++;
			if (hornType == 2)
				minoCounter++;
			if (lowerBody == 1 && minoCounter > 0)
				minoCounter++;
			if (tallness >= 73 && minoCounter > 0)
				minoCounter++;
			if (vaginas.length > 0)
				minoCounter++;
			if (biggestTitSize() > 4 && minoCounter > 0)
				minoCounter++;
			if (biggestLactation() > 2 && minoCounter > 0)
				minoCounter++;
			return minoCounter;
		}

		public function sandTrapScore():int
		{
			var counter:int = 0;
			if (findStatusAffect(StatusAffects.BlackNipples) >= 0)
				counter++;
			if (hasVagina() && vaginaType() == 5)
				counter++;
			if (eyeType == 2)
				counter++;
			if (wingType == 12)
				counter++;
			return counter;
		}

		//Determine Bee Rating
		public function beeScore():Number
		{
			var beeCounter:Number = 0;
			if (hairColor == "shiny black")
				beeCounter++;
			if (hairColor == "black and yellow")
				beeCounter += 2;
			if (antennae > 0)
			{
				beeCounter++;
				if (faceType == 0)
					beeCounter++;
			}
			if (lowerBody == 7)
			{
				beeCounter++;
				if (vaginas.length == 1)
					beeCounter++;
			}
			if (tailType == 6)
				beeCounter++;
			if (wingType == 1)
				beeCounter++;
			if (wingType == 2)
				beeCounter++;
			return beeCounter;
		}
		//Determine Ferret Rating!
		public function ferretScore():Number
		{
			var counter:int = 0;
			if (faceType == FACE_FERRET_MASK) counter++;
			if (faceType == FACE_FERRET) counter+=2;
			if (earType == EARS_FERRET) counter++;
			if (tailType == TAIL_TYPE_FERRET) counter++;
			if (lowerBody == LOWER_BODY_FERRET) counter++;
			if (skinType == SKIN_TYPE_FUR && counter > 0) counter++;
			return counter;
		}
		//Determine Dog Rating
		public override function dogScore():Number
		{
			var dogCounter:Number = 0;
			if (faceType == 2)
				dogCounter++;
			if (earType == 2)
				dogCounter++;
			if (tailType == 2)
				dogCounter++;
			if (lowerBody == 2)
				dogCounter++;
			if (dogCocks() > 0)
				dogCounter++;
			if (breastRows.length > 1)
				dogCounter++;
			if (breastRows.length == 3)
				dogCounter++;
			if (breastRows.length > 3)
				dogCounter--;
			//Fur only counts if some canine features are present
			if (skinType == 1 && dogCounter > 0)
				dogCounter++;
			return dogCounter;
		}

		public function mouseScore():Number
		{
			var coonCounter:Number = 0;
			if (earType == 12)
				coonCounter++;
			if (tailType == 16)
				coonCounter++;

			if (faceType == 15)
				coonCounter++;
			if (faceType == 16)
				coonCounter += 2;
			//Fur only counts if some canine features are present
			if (skinType == 1 && coonCounter > 0)
				coonCounter++;

			if (tallness < 55 && coonCounter > 0)
				coonCounter++;
			if (tallness < 45 && coonCounter > 0)
				coonCounter++;
			return coonCounter;
		}

		public function raccoonScore():Number
		{
			var coonCounter:Number = 0;
			if (faceType == 13)
				coonCounter++;
			if (faceType == 14)
				coonCounter += 2;
			if (earType == 11)
				coonCounter++;
			if (tailType == 15)
				coonCounter++;
			if (lowerBody == 19)
				coonCounter++;
			if (coonCounter > 0 && balls > 0)
				coonCounter++;
			//Fur only counts if some canine features are present
			if (skinType == 1 && coonCounter > 0)
				coonCounter++;
			return coonCounter;
		}

		//Determine Fox Rating
		public override function foxScore():Number
		{
			var foxCounter:Number = 0;
			if (faceType == 11)
				foxCounter++;
			if (earType == 9)
				foxCounter++;
			if (tailType == 13)
				foxCounter++;
			if (lowerBody == 17)
				foxCounter++;
			if (dogCocks() > 0 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length > 1 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 3 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 4 && foxCounter > 0)
				foxCounter++;
			//Fur only counts if some canine features are present
			if (skinType == 1 && foxCounter > 0)
				foxCounter++;
			return foxCounter;
		}

		//Determine cat Rating
		public function catScore():Number
		{
			var catCounter:Number = 0;
			if (faceType == 6)
				catCounter++;
			if (earType == 5)
				catCounter++;
			if (tailType == 8)
				catCounter++;
			if (lowerBody == 9)
				catCounter++;
			if (catCocks() > 0)
				catCounter++;
			if (breastRows.length > 1 && catCounter > 0)
				catCounter++;
			if (breastRows.length == 3 && catCounter > 0)
				catCounter++;
			if (breastRows.length > 3)
				catCounter -= 2;
			//Fur only counts if some canine features are present
			if (skinType == 1 && catCounter > 0)
				catCounter++;
			return catCounter;
		}

		//Determine lizard rating
		public function lizardScore():Number
		{
			var lizardCounter:Number = 0;
			if (faceType == 7)
				lizardCounter++;
			if (earType == 6)
				lizardCounter++;
			if (tailType == 9)
				lizardCounter++;
			if (lowerBody == 10)
				lizardCounter++;
			if (lizardCocks() > 0)
				lizardCounter++;
			if (horns > 0 && (hornType == 3 || hornType == 4))
				lizardCounter++;
			if (skinType == 2)
				lizardCounter++;
			return lizardCounter;
		}

		public function spiderScore():Number
		{
			var score:Number = 0;
			if (eyeType == 1)
				score += 2;
			if (faceType == 10)
				score++;
			if (armType == 2)
				score++;
			if (lowerBody == 15 || lowerBody == 16)
				score += 2;
			else if (score > 0)
				score--;
			if (tailType == 5)
				score += 2;
			if (skinType > 0 && score > 0)
				score--;
			return score;
		}

		//Determine Horse Rating
		public function horseScore():Number
		{
			var horseCounter:Number = 0;
			if (faceType == 1)
				horseCounter++;
			if (earType == 1)
				horseCounter++;
			if (tailType == 1)
				horseCounter++;
			if (horseCocks() > 0)
				horseCounter++;
			if (lowerBody == 1 || lowerBody == 4)
				horseCounter++;
			//Fur only counts if some equine features are present
			if (skinType == 1 && horseCounter > 0)
				horseCounter++;
			return horseCounter;
		}

		//Determine kitsune Rating
		public function kitsuneScore():Number
		{
			var kitsuneCounter:int = 0;
			//If the character has fox ears, +1
			if (earType == 9)
				kitsuneCounter++;
			//If the character has a fox tail, +1
			if (tailType == 13)
				kitsuneCounter++;
			//If the character has two or more fox tails, +2
			if (tailType == 13 && tailVenom >= 2)
				kitsuneCounter += 2;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			//If the character's kitsune score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitsuneCounter > 0 && faceType == 0)
				kitsuneCounter++;
			//If the character's kitsune score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitsuneCounter > 0 && (hairColor == "golden blonde" || hairColor == "black" || hairColor == "red" || hairColor == "white" || hairColor == "silver blonde"))
				kitsuneCounter++;
			//If the character's femininity is 40 or higher, +1
			if (kitsuneCounter > 0 && femininity >= 40)
				kitsuneCounter++;
			//If the character has fur, scales, or gooey skin, -1
			if (skinType > 1)
				kitsuneCounter -= 2;
			if (skinType == 1)
				kitsuneCounter--;
			//If the character has abnormal legs, -1
			if (lowerBody != 0)
				kitsuneCounter--;
			//If the character has a nonhuman face, -1
			if (faceType != 0)
				kitsuneCounter--;
			//If the character has ears other than fox ears, -1
			if (earType != 9)
				kitsuneCounter--;
			//If the character has tail(s) other than fox tails, -1
			if (tailType != 13)
				kitsuneCounter--;

			return kitsuneCounter;

		}

		//Determine Horse Rating
		public function dragonScore():Number
		{
			var dragonCounter:Number = 0;
			if (faceType == 12)
				dragonCounter++;
			if (earType == 10)
				dragonCounter++;
			if (tailType == 14)
				dragonCounter++;
			if (tongueType == 3)
				dragonCounter++;
			if (dragonCocks() > 0)
				dragonCounter++;
			if (wingType == 10)
				dragonCounter++;
			if (wingType == 11)
				dragonCounter += 2;
			if (lowerBody == 18)
				dragonCounter++;
			if (skinType == 2 && dragonCounter > 0)
				dragonCounter++;
			return dragonCounter;
		}

		//Goblinscore
		public function goblinScore():Number
		{
			var horseCounter:Number = 0;
			if (earType == 4)
				horseCounter++;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green")
				horseCounter++;
			if (horseCounter > 0)
			{
				if (faceType == 0)
					horseCounter++;
				if (tallness < 48)
					horseCounter++;
				if (hasVagina())
					horseCounter++;
				if (lowerBody == 0)
					horseCounter++;
			}
			return horseCounter;
		}

		//Gooscore
		public function gooScore():Number
		{
			var gooCounter:Number = 0;
			if (hairType == 3)
				gooCounter++;
			if (skinAdj == "slimy")
				gooCounter++;
			if (lowerBody == 8)
				gooCounter++;
			if (vaginalCapacity() > 9000)
				gooCounter++;
			if (findStatusAffect(StatusAffects.SlimeCraving) >= 0)
				gooCounter++;
			return gooCounter;
		}

		//Nagascore
		public function nagaScore():Number
		{
			var nagaCounter:Number = 0;
			if (faceType == 5)
				nagaCounter++;
			if (tongueType == 1)
				nagaCounter++;
			if (nagaCounter > 0 && antennae == 0)
				nagaCounter++;
			if (nagaCounter > 0 && wingType == 0)
				nagaCounter++;
			return nagaCounter;
		}

		//Bunnyscore
		public function bunnyScore():Number
		{
			var bunnyCounter:Number = 0;
			if (faceType == 8)
				bunnyCounter++;
			if (tailType == 10)
				bunnyCounter++;
			if (earType == 7)
				bunnyCounter++;
			if (lowerBody == 12)
				bunnyCounter++;
			//More than 2 balls reduces bunny score
			if (balls > 2 && bunnyCounter > 0)
				bunnyCounter--;
			//Human skin on bunmorph adds
			if (skinType == 0 && bunnyCounter > 1)
				bunnyCounter++;
			//No wings and antennae a plus
			if (bunnyCounter > 0 && antennae == 0)
				bunnyCounter++;
			if (bunnyCounter > 0 && wingType == 0)
				bunnyCounter++;
			return bunnyCounter;
		}

		//Harpyscore
		public function harpyScore():Number
		{
			var harpy:Number = 0;
			if (armType == 1)
				harpy++;
			if (hairType == 1)
				harpy++;
			if (wingType == 9)
				harpy++;
			if (tailType == 11)
				harpy++;
			if (lowerBody == 13)
				harpy++;
			if (harpy >= 2 && faceType == 0)
				harpy++;
			if (harpy >= 2 && (earType == 0 || earType == 4))
				harpy++;
			return harpy;
		}

		//Kangascore
		public function kangaScore():Number
		{
			var kanga:Number = 0;
			if (kangaCocks() > 0)
				kanga++;
			if (earType == 8)
				kanga++;
			if (tailType == 12)
				kanga++;
			if (lowerBody == 14)
				kanga++;
			if (faceType == 9)
				kanga++;
			if (kanga >= 2 && skinType == 1)
				kanga++;
			return kanga;
		}

		//sharkscore
		public function sharkScore():Number
		{
			var sharkCounter:Number = 0;
			if (faceType == 4)
				sharkCounter++;
			if (wingType == 8)
				sharkCounter++;
			if (tailType == 7)
				sharkCounter++;
			return sharkCounter;
		}

		//Determine Mutant Rating
		public function mutantScore():Number
		{
			var mutantCounter:Number = 0;
			if (faceType > 0)
				mutantCounter++;
			if (skinType > 0)
				mutantCounter++;
			if (tailType > 0)
				mutantCounter++;
			if (cockTotal() > 1)
				mutantCounter++;
			if (hasCock() && hasVagina())
				mutantCounter++;
			if (hasFuckableNipples())
				mutantCounter++;
			if (breastRows.length > 1)
				mutantCounter++;
			if (faceType == 1)
			{
				if (skinType == 1)
					mutantCounter--;
				if (tailType == 1)
					mutantCounter--;
			}
			if (faceType == 2)
			{
				if (skinType == 1)
					mutantCounter--;
				if (tailType == 2)
					mutantCounter--;
			}
			return mutantCounter--;
		}

		public function lactationQ():Number
		{
			if (biggestLactation() < 1)
				return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number;
			if (findStatusAffect(StatusAffects.LactationEndurance) < 0)
				createStatusAffect(StatusAffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusAffectv1(StatusAffects.LactationEndurance) * totalBreasts();
			if (statusAffectv1(StatusAffects.LactationReduction) >= 48)
				total = total * 1.5;
			return total;
		}
		
		public function isLactating():Boolean
		{
			if (lactationQ() > 0) return true;
			return false;
		}

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>", false);
				if(spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(display && stretched) {
				//Virgins get different formatting
				if(devirgined) {
					//If no spaces after virgin loss
					if(!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if(spacingsF) outputText("  ");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accomodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>", false);
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>", false);
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(stretched && display) {
				if (spacingsF) outputText("  ");
				buttChangeDisplay();
				if (spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChangeDisplay():void
		{	//Allows the test for stretching and the text output to be separated
			if (ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
			if (ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>", false);
			if (ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
			if (ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
			if (ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>", false);
		}

		public function slimeFeed():void{
			if(findStatusAffect(StatusAffects.SlimeCraving) >= 0) {
				//Reset craving value
				changeStatusValue(StatusAffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(findStatusAffect(StatusAffects.SlimeCravingFeed) < 0) {
					createStatusAffect(StatusAffects.SlimeCravingFeed,0,0,0,0);
				}
			}
			if(findPerk(PerkLib.Diapause) >= 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}

		}

		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;

			//Turn off withdrawal
			//if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			//If in withdrawl, readdiction is potent!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 50;
			if(raw < -50) raw = -50;
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//Recheck to make sure shit didn't break
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;

		}

		public function hasSpells():Boolean
		{
			return spellCount()>0;
		}

		public function spellCount():Number
		{
			return [StatusAffects.KnowsArouse,StatusAffects.KnowsHeal,StatusAffects.KnowsMight,StatusAffects.KnowsCharge,StatusAffects.KnowsBlind,StatusAffects.KnowsWhitefire]
					.filter(function(item:StatusAffectType,index:int,array:Array):Boolean{
						return this.findStatusAffect(item)>=0;},this)
					.length;
		}

		public function hairDescript():String
		{
			return Appearance.hairDescription(this);
		}

		public function shrinkTits(ignore_hyper_happy:Boolean=false):void
		{
			if (flags[kFLAGS.HYPER_HAPPY] && !ignore_hyper_happy)
			{
				return;
			}
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && findPerk(PerkLib.BigTits) < 0) {
						temp++;
						breastRows[0].breastRating--;
					}
					if(breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.", false);
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.", false);
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n", false);
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n", false);
						if(temp3 < breastRows.length - 1) outputText("...and y", false);
						else outputText("Y", false);
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.", false);
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.", false);
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.", false);
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.", false);
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if(breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if(findPerk(PerkLib.BigTits) >= 0 && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if(breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if(breastRows[temp2].breastRating > 3)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if(breastRows[temp2].breastRating > 7)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 9)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 12)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp  /=1.5;
						}
					}

					//Grow!
					trace("Growing breasts by ", temp);
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY])
			{
				//Diminishing returns!
				if(breastRows[0].breastRating > 3) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=1.5;
					else amount/=1.3;
				}
				if(breastRows[0].breastRating > 7) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
				if(breastRows[0].breastRating > 12) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
			}
			/*if(breastRows[0].breastRating > 12) {
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if(growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if(temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth ammout = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.", false);
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.", false);
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.", false);
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.", false);
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tinglng in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .5;
					}
				}
			}
		}

		//Determine minimum lust
		public function minLust():Number
		{
			var min:Number = 0;
			//Bimbo body boosts minimum lust by 40
			if(findStatusAffect(StatusAffects.BimboChampagne) >= 0 || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.BroBody) >= 0 || findPerk(PerkLib.FutaForm) >= 0) {
				if(min > 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 40;
			}
			//Omnibus' Gift
			if(findPerk(PerkLib.OmnibusGift) >= 0) {
				if(min > 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 35;
			}
			//Nymph perk raises to 30
			if(findPerk(PerkLib.Nymphomania) >= 0) {
				if(min >= 40) min += 10;
				else if(min >= 20) min += 15;
				else min += 30;
			}
			//Oh noes anemone!
			if(findStatusAffect(StatusAffects.AnemoneArousal) >= 0) {
				if(min >= 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 30;
			}
			//Hot blooded perk raises min lust!
			if(findPerk(PerkLib.HotBlooded) >= 0) {
				if(min > 0) min += perk(findPerk(PerkLib.HotBlooded)).value1 / 2;
				else min += perk(findPerk(PerkLib.HotBlooded)).value1;
			}
			if(findPerk(PerkLib.LuststickAdapted) > 0) {
				if(min < 50) min += 10;
				else min += 5;
			}
			//Add points for Crimstone
			min += perkv1(PerkLib.PiercedCrimstone);
			min += perkv1(PerkLib.PentUp);
			//Harpy Lipstick status forces minimum lust to be at least 50.
			if(min < 50 && findStatusAffect(StatusAffects.Luststick) >= 0) min = 50;
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168) {
				min += 20;
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += 30;
			}
			//SPOIDAH BOOSTS
			if(eggs() >= 20) {
				min += 10;
				if(eggs() >= 40) min += 10;
			}
			if(min < 30 && armorName == "lusty maiden's armor") min = 30;
			return min;
		}

		public function minotaurAddicted():Boolean {
			return findPerk(PerkLib.MinotaurCumAddict) >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1;
		}
		public function minotaurNeed():Boolean {
			return flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			while(findStatusAffect(StatusAffects.Web) >= 0) {
				spe += statusAffectv1(StatusAffects.Web);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.Web);
			}
			if(findStatusAffect(StatusAffects.Shielding) >= 0) removeStatusAffect(StatusAffects.Shielding);
			if(findStatusAffect(StatusAffects.HolliConstrict) >= 0) removeStatusAffect(StatusAffects.HolliConstrict);
			if(findStatusAffect(StatusAffects.LustStones) >= 0) removeStatusAffect(StatusAffects.LustStones);
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.Sandstorm) >= 0) kGAMECLASS.monster.removeStatusAffect(StatusAffects.Sandstorm);
			if(findStatusAffect(StatusAffects.Sealed) >= 0) {
				removeStatusAffect(StatusAffects.Sealed);
			}
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) {
				removeStatusAffect(StatusAffects.Berzerking);
			}
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.TailWhip) >= 0) {
				kGAMECLASS.monster.removeStatusAffect(StatusAffects.TailWhip);
			}
			if(findStatusAffect(StatusAffects.UBERWEB) >= 0) removeStatusAffect(StatusAffects.UBERWEB);
			if(findStatusAffect(StatusAffects.DriderKiss) >= 0) removeStatusAffect(StatusAffects.DriderKiss);
			if(findStatusAffect(StatusAffects.WebSilence) >= 0) removeStatusAffect(StatusAffects.WebSilence);
			if(findStatusAffect(StatusAffects.GooArmorSilence) >= 0) removeStatusAffect(StatusAffects.GooArmorSilence);
			if(findStatusAffect(StatusAffects.Bound) >= 0) removeStatusAffect(StatusAffects.Bound);
			if(findStatusAffect(StatusAffects.GooArmorBind) >= 0) removeStatusAffect(StatusAffects.GooArmorBind);
			if(findStatusAffect(StatusAffects.Whispered) >= 0) removeStatusAffect(StatusAffects.Whispered);
			if(findStatusAffect(StatusAffects.AkbalSpeed) >= 0) {
				kGAMECLASS.dynStats("spe", statusAffectv1(StatusAffects.AkbalSpeed) * -1);
				removeStatusAffect(StatusAffects.AkbalSpeed);
			}
			if(findStatusAffect(StatusAffects.AmilyVenom) >= 0) {
				kGAMECLASS.dynStats("str", statusAffectv1(StatusAffects.AmilyVenom),"spe", statusAffectv2(StatusAffects.AmilyVenom));
				removeStatusAffect(StatusAffects.AmilyVenom);
			}
			while(findStatusAffect(StatusAffects.Blind) >= 0) {
				removeStatusAffect(StatusAffects.Blind);
			}
			if(findStatusAffect(StatusAffects.SheilaOil) >= 0) {
				removeStatusAffect(StatusAffects.SheilaOil);
			}
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.TwuWuv) >= 0) {
				inte += kGAMECLASS.monster.statusAffectv1(StatusAffects.TwuWuv);
				kGAMECLASS.statScreenRefresh();
				kGAMECLASS.mainView.statsView.showStatUp( 'inte' );
			}
			if(findStatusAffect(StatusAffects.NagaVenom) >= 0) {
				spe += statusAffectv1(StatusAffects.NagaVenom);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				//stats(0,0,statusAffectv1(StatusAffects.NagaVenom),0,0,0,0,0);
				removeStatusAffect(StatusAffects.NagaVenom);
			}
			if(findStatusAffect(StatusAffects.TentacleBind) >= 0) removeStatusAffect(StatusAffects.TentacleBind);
			if(findStatusAffect(StatusAffects.NagaBind) >= 0) removeStatusAffect(StatusAffects.NagaBind);
			if(findStatusAffect(StatusAffects.StoneLust) >= 0) {
				removeStatusAffect(StatusAffects.StoneLust);
			}
			removeStatusAffect(StatusAffects.FirstAttack);
			if(findStatusAffect(StatusAffects.TemporaryHeat) >= 0) removeStatusAffect(StatusAffects.TemporaryHeat);
			if(findStatusAffect(StatusAffects.NoFlee) >= 0) removeStatusAffect(StatusAffects.NoFlee);
			if(findStatusAffect(StatusAffects.Poison) >= 0) removeStatusAffect(StatusAffects.Poison);
			if(findStatusAffect(StatusAffects.IsabellaStunned) >= 0) removeStatusAffect(StatusAffects.IsabellaStunned);
			if(findStatusAffect(StatusAffects.Stunned) >= 0) removeStatusAffect(StatusAffects.Stunned);
			if(findStatusAffect(StatusAffects.Confusion) >= 0) removeStatusAffect(StatusAffects.Confusion);
			if(findStatusAffect(StatusAffects.ThroatPunch) >= 0) removeStatusAffect(StatusAffects.ThroatPunch);
			if(findStatusAffect(StatusAffects.KissOfDeath) >= 0) removeStatusAffect(StatusAffects.KissOfDeath);
			if(findStatusAffect(StatusAffects.AcidSlap) >= 0) removeStatusAffect(StatusAffects.AcidSlap);
			if(findStatusAffect(StatusAffects.GooBind) >= 0) removeStatusAffect(StatusAffects.GooBind);
			if(findStatusAffect(StatusAffects.HarpyBind) >= 0) removeStatusAffect(StatusAffects.HarpyBind);
			if(findStatusAffect(StatusAffects.CalledShot) >= 0) {
				spe += statusAffectv1(StatusAffects.CalledShot);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speDown.visible = false;
				// speUp.visible = true;
				removeStatusAffect(StatusAffects.CalledShot);
			}
			if(findStatusAffect(StatusAffects.DemonSeed) >= 0) {
				removeStatusAffect(StatusAffects.DemonSeed);
			}
			if(findStatusAffect(StatusAffects.ParalyzeVenom) >= 0) {
				str += statusAffect(findStatusAffect(StatusAffects.ParalyzeVenom)).value1;
				spe += statusAffect(findStatusAffect(StatusAffects.ParalyzeVenom)).value2;
				removeStatusAffect(StatusAffects.ParalyzeVenom);
			}
			if(findStatusAffect(StatusAffects.lustvenom) >= 0) {
				removeStatusAffect(StatusAffects.lustvenom);
			}
			if(findStatusAffect(StatusAffects.InfestAttempted) >= 0) {
				removeStatusAffect(StatusAffects.InfestAttempted);
			}
			if(findStatusAffect(StatusAffects.Might) >= 0) {
				kGAMECLASS.dynStats("str", -statusAffectv1(StatusAffects.Might),"tou", -statusAffectv2(StatusAffects.Might));
				removeStatusAffect(StatusAffects.Might);
			}
			if(findStatusAffect(StatusAffects.ChargeWeapon) >= 0) {
				removeStatusAffect(StatusAffects.ChargeWeapon);
			}
			if(findStatusAffect(StatusAffects.Disarmed) >= 0) {
				removeStatusAffect(StatusAffects.Disarmed);
				if (weapon == WeaponLib.FISTS) {
//					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
//					(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon).doEffect(this, false);
					setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
			}
			if(findStatusAffect(StatusAffects.AnemoneVenom) >= 0) {
				str += statusAffectv1(StatusAffects.AnemoneVenom);
				spe += statusAffectv2(StatusAffects.AnemoneVenom);
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);

				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				kGAMECLASS.mainView.statsView.showStatUp( 'str' );
				// speUp.visible = true;
				// strUp.visible = true;
				removeStatusAffect(StatusAffects.AnemoneVenom);
			}
			if(findStatusAffect(StatusAffects.GnollSpear) >= 0) {
				spe += statusAffectv1(StatusAffects.GnollSpear);
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.GnollSpear);
			}
			if(findStatusAffect(StatusAffects.BasiliskCompulsion) >= 0) removeStatusAffect(StatusAffects.BasiliskCompulsion);
			if(findStatusAffect(StatusAffects.BasiliskSlow) >= 0) {
				spe += statusAffectv1(StatusAffects.BasiliskSlow);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.BasiliskSlow);
			}
			while (findStatusAffect(StatusAffects.IzmaBleed) >= 0) removeStatusAffect(StatusAffects.IzmaBleed);
			if (findStatusAffect(StatusAffects.GardenerSapSpeed) >= 0)
			{
				spe += statusAffectv1(StatusAffects.GardenerSapSpeed);
				kGAMECLASS.mainView.statsView.showStatUp('spe');
				removeStatusAffect(StatusAffects.GardenerSapSpeed);
			}
			if (findStatusAffect(StatusAffects.KnockedBack) >= 0) removeStatusAffect(StatusAffects.KnockedBack);
			if (findStatusAffect(StatusAffects.RemovedArmor) >= 0) removeStatusAffect(StatusAffects.KnockedBack);
			if (findStatusAffect(StatusAffects.JCLustLevel) >= 0) removeStatusAffect(StatusAffects.JCLustLevel);
			if (findStatusAffect(StatusAffects.MirroredAttack) >= 0) removeStatusAffect(StatusAffects.MirroredAttack);
			if (findStatusAffect(StatusAffects.Tentagrappled) >= 0) removeStatusAffect(StatusAffects.Tentagrappled);
			if (findStatusAffect(StatusAffects.TentagrappleCooldown) >= 0) removeStatusAffect(StatusAffects.TentagrappleCooldown);
			if (findStatusAffect(StatusAffects.ShowerDotEffect) >= 0) removeStatusAffect(StatusAffects.ShowerDotEffect);
			if (findStatusAffect(StatusAffects.GardenerSapSpeed) >= 0)
			{
				spe += statusAffectv1(StatusAffects.GardenerSapSpeed);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				removeStatusAffect(StatusAffects.GardenerSapSpeed);
			}
			if (findStatusAffect(StatusAffects.VineHealUsed) >= 0) removeStatusAffect(StatusAffects.VineHealUsed);
		}

		public function consumeItem(itype:ItemType, amount:int=1):Boolean
		{
			var consumed:Boolean = false;
			var slot:*;
			while (amount > 0)
			{
				if(!hasItem(itype,1))
				{
					CoC_Settings.error("ERROR: consumeItem in items.as attempting to find an item to remove when the has none.");
					break;
				}
				trace("FINDING A NEW SLOT! (ITEMS LEFT: " + amount + ")");
				slot = getLowestSlot(itype);
				while (slot != undefined && amount > 0 && slot.quantity > 0)
				{
					amount--;
					slot.quantity--;
					if(slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if(slot == undefined) amount = -1

			}
			if(amount == 0) consumed = true;
			return consumed;
		}

		public function getLowestSlot(itype:ItemType):ItemSlotClass
		{
			var minslot:ItemSlotClass = null;
			for each (var slot:ItemSlotClass in itemSlots){
				if (slot.itype == itype){
					if (minslot == null || slot.quantity<minslot.quantity){
						minslot = slot;
					}
				}
			}
			return minslot;
		}
		public function hasItem(itype:ItemType, minQuantity:Number=1):Boolean {
			return itemCount(itype)>=minQuantity;
		}
		public function itemCount(itype:ItemType):int {
			var count:int = 0;
			for each (var itemSlot:ItemSlotClass in itemSlots){
				if (itemSlot.itype == itype) count += itemSlot.quantity;
			}
			return count;
		}

		// 0..5 or -1 if no
		public function roomInExistingStack(itype:ItemType):Number {
			for (var i:int = 0; i<itemSlots.length; i++){
				if(itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 5)
					return i;
			}
			return -1;
		}

		public function itemSlot(idx:int):ItemSlotClass
		{
			return itemSlots[idx];
		}

		// 0..5 or -1 if no
		public function emptySlot():Number {
		    for (var i:int = 0; i<itemSlots.length;i++){
				if (itemSlot(i).isEmpty() && itemSlot(i).unlocked) return i;
			}
			return -1;
		}


		public function destroyItems(itype:ItemType, numOfItemToRemove:Number):Boolean
		{
			for (var slotNum:int = 0; slotNum < itemSlots.length; slotNum += 1)
			{
				if(itemSlot(slotNum).itype == itype)
				{
					while(itemSlot(slotNum).quantity > 0 && numOfItemToRemove > 0)
					{
						itemSlot(slotNum).removeOneItem();
						numOfItemToRemove--;
					}
				}
			}
			return numOfItemToRemove <= 0;
		}

		public function lengthChange(temp2:Number, ncocks:Number):void {

			if (temp2 < 0 && flags[kFLAGS.HYPER_HAPPY])  // Early return for hyper-happy cheat if the call was *supposed* to shrink a cock.
			{
				return;
			}
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(cocks.length == 1) outputText("Your " + cockDescript(0) + " has grown slightly longer.", false);
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your " + multiCockDescriptLight() + " grows slightly longer.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your " + multiCockDescriptLight() + " grow slightly longer.", false);
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " seem to fill up... growing a little bit larger.", false);
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your " + cockDescript(0) + " grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your " + multiCockDescriptLight() + " grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.", false);
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your " + multiCockDescriptLight() + " grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.", false);
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your " + cockDescript(0) + " feels incredibly tight as a few more inches of length seem to pour out from your crotch.", false);
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as one of their number begins to grow inch after inch of length.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly number as " + kGAMECLASS.num2Text(ncocks) + " of them begin to grow inch after inch of added length.", false);
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as inch after inch of length pour out from your groin.", false);
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>", false);
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>", false);
				}
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " is so long it nearly swings to your knee at its full length.</b>", false);
					if(cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " are so long they nearly reach your knees when at full length.</b>", false);
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " would look more at home on a large horse than you.</b>", false);
					if(cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " would look more at home on a large horse than on your body.</b>", false);
					if(gender == 3){
						if(cocks.length == 1) outputText("  You could easily stuff your " + cockDescript(0) + " between your breasts and give yourself the titty-fuck of a lifetime.", false);
						if(cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.", false);
					}
					if(gender == 1){
						if(cocks.length == 1) outputText("  Your " + cockDescript(0) + " is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.", false);
						if(cocks.length > 1) outputText("  Your " + multiCockDescriptLight() + " are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.", false);
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your " + cockDescript(0) + " wasn't enough, the tip of your " + cockDescript(0) + " keeps poking its way into your view every time you get hard.</b>", false);
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your " + multiCockDescriptLight() + " wasn't bad enough, every time you get hard, the tips of your " + multiCockDescriptLight() + " wave before you, obscuring the lower portions of your vision.</b>", false);
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your " + multiCockDescriptLight() + "?", false);
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.", false);
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + multiCockDescriptLight() + " to their hilts, milking you dry.\n\nYou smile at the pleasant thought.", false);
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + cockDescript(0) + " to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.", false);
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your " + multiCockDescriptLight() + " in a year's time.", false);
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
					if(ncocks == 1) outputText("You feel " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " shrinks smaller, flesh vanishing into your groin.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
					if(ncocks == 1) outputText("You feel " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your " + multiCockDescriptLight() + "'s length shrinks and vanishes.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your " + multiCockDescriptLight() + " receeds towards your groin, receding rapidly in length.", false);
					if(ncocks == 1) outputText("A single member of your " + multiCockDescriptLight() + " vanishes into your groin, receding rapidly in length.", false);
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your " + multiCockDescriptLight() + " tingles as " + kGAMECLASS.num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.", false);
				}
			}
		}

		public function killCocks(deadCock:Number):void
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (deadCock < 0) {
				deadCock = cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down
			while (deadCock > 0) {
				//Find shortest cock and prune it
				temp = cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (cocks[temp].cockLength <= cocks[storedCock].cockLength) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				removeCock(storedCock, 1);
				removed++;
				deadCock--;
				if (cocks.length == 0) deadCock = 0;
			}
			//Texts
			if (removed == 1) {
				if (cocks.length == 0) {
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>", false);
					if (findStatusAffect(StatusAffects.Infested) >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one " + cockDescript(0) + ".</b>", false);
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your " + multiCockDescriptLight() + ".</b>", false);
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>", false);
					if (findStatusAffect(StatusAffects.Infested) >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + kGAMECLASS.num2Text(removed) + " cocks disappear into your groin, leaving you with just your " + cockDescript(0) + ".", false);
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + kGAMECLASS.num2Text(removed) + " cocks disappear into your groin, leaving you with " + multiCockDescriptLight() + ".", false);
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusAffect(StatusAffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText("  <b>Your " + sackDescript() + " and " + ballsDescriptLight() + " shrink and disappear, vanishing into your groin.</b>", false);
				balls = 0;
				ballSize = 1;
			}
		}
		public function modCumMultiplier(delta:Number):Number
		{
			trace("modCumMultiplier called with: " + delta);
		
			if (delta == 0) {
				trace( "Whoops! modCumMuliplier called with 0... aborting..." );
				return delta;
			}
			else if (delta > 0) {
				trace("and increasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 1.5
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 0.5
				}
			}

			trace("and modifying by " + delta);
			cumMultiplier += delta;
			return delta;
		}

		public function increaseCock(cockNum:Number, lengthDelta:Number):Number
		{
			var bigCock:Boolean = false;
	
			if (findPerk(PerkLib.BigCock) >= 0)
				bigCock = true;

			return cocks[cockNum].growCock(lengthDelta, bigCock);
		}
		
		public function increaseEachCock(lengthDelta:Number):Number
		{
			var totalGrowth:Number = 0;
			
			for (var i:Number = 0; i < cocks.length; i++) {
				trace( "increaseEachCock at: " + i);
				totalGrowth += increaseCock(i as Number, lengthDelta);
			}
			
			return totalGrowth;
		}
		
		// Attempts to put the player in heat (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if she is already pregnant or is a he.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoHeat(output:Boolean, intensity:int = 1):Boolean {
			if(!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}
			
			//Already in heat, intensify further.
			if (inHeat) {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.", false);
				}
				var temp:Number = findStatusAffect(StatusAffects.Heat);
				statusAffect(temp).value1 += 5 * intensity;
				statusAffect(temp).value2 += 5 * intensity;
				statusAffect(temp).value3 += 48 * intensity;
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>", false);
				}
				createStatusAffect(StatusAffects.Heat, 10 * intensity, 15 * intensity, 48 * intensity, 0);
				game.dynStats("lib", 15 * intensity, "resisted", false, "noBimbo", true);
			}
			return true;
		}
		
		// Attempts to put the player in rut (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if he is a she.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoRut(output:Boolean, intensity:int = 1):Boolean {
			if (!hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			
			//Has rut, intensify it!
			if (inRut) {
				if(output) {
					outputText("\n\nYour " + cockDescript(0) + " throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.", false);
				}
				
				addStatusValue(StatusAffects.Rut, 1, 100 * intensity);
				addStatusValue(StatusAffects.Rut, 2, 5 * intensity);
				addStatusValue(StatusAffects.Rut, 3, 48 * intensity);
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!", false);
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusAffect(StatusAffects.Rut, 150 * intensity, 5 * intensity, 100 * intensity, 0);
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			
			return true;
		}
	}
}
