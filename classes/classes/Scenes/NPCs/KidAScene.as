/**
 * Created by aimozg on 02.01.14.
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapon;
import classes.Scenes.Places.Boat.AnemoneScene;
import classes.display.SpriteDb;

public class KidAScene extends BaseContent implements TimeAwareInterface
	{
		public function KidAScene()
		{
			EventParser.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			var needNext:Boolean = false;
			if (flags[kFLAGS.ANEMONE_KID] > 0) {
				//weapon check to avoid errors in scene
				if (flags[kFLAGS.KID_SITTER] == 0 && flags[kFLAGS.MARBLE_KIDS] >= 5 && flags[kFLAGS.ANEMONE_WEAPON_ID] != 0 && model.time.hours > 10 && model.time.hours < 18 && rand(4) == 0) {
					kidABabysitsCows();
					needNext = true;
				}
				if (flags[kFLAGS.KID_SITTER] == 1 && model.time.hours > 10 && model.time.hours < 18 && rand(4) == 0) {
					flags[kFLAGS.KID_SITTER] = 2;
				}
				else if (flags[kFLAGS.KID_SITTER] == 2) flags[kFLAGS.KID_SITTER] = 1;
			}
			if (player.hasStatusEffect(StatusEffects.AnemoneArousal)) {
				if (player.pregnancyIncubation > 1) {
					player.removeStatusEffect(StatusEffects.AnemoneArousal);
					player.buff("AnemoneArousal").remove();
					outputText("\n<b>The nigh-constant arousal forced upon you by the anemone-like creature in your body finally fades.  You stick a finger inside yourself and marvel in wonder - it's gone!  You aren't sure if it slipped out or your body somehow consumed it, but it's nice to have a clearer head.</b>\n");
				}
				else if(!player.hasVagina()) {
					player.removeStatusEffect(StatusEffects.AnemoneArousal);
					player.buff("AnemoneArousal").remove();
					outputText("\n<b>The nigh-constant arousal forced upon you by the anemone-like creature in your body finally fades.  You aren't sure if it was somehow consumed by the removal of your vagina or if it escaped during the process, but it's nice to have a clear head for a change.</b>\n");
				}
				needNext = true;
			}
			return needNext;
		}

		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

		public function kidAXP(diff:Number = 0):Number
		{
			if (diff == 0) return flags[kFLAGS.KID_A_XP];
			flags[kFLAGS.KID_A_XP] += diff;
			if (flags[kFLAGS.KID_A_XP] < 0) flags[kFLAGS.KID_A_XP] = 0;
			if (flags[kFLAGS.KID_A_XP] > 100) flags[kFLAGS.KID_A_XP] = 100;
			return flags[kFLAGS.KID_A_XP];
		}

		public function anemoneKidBirthPtII():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			outputText("You awake and look skyward to the sun for a hint at the time.  What greets you is more of an eclipse; a shape impedes your view.  As your eyes adjust to the light, it resolves into an upside-down blue-eyed, blue-skinned face wreathed with snubby, shoulder-length tentacles of purple and green hue.  The silence continues as you stare into it, until you move to push yourself off the hard ground.  At the first sign of activity, the head disappears into the water barrel with a sloshing sound.  You push yourself to your [feet] and look back toward it; the eyes, now right side-up, peek over the rim bashfully atop a set of blue fingers.");
			outputText("\n\n\"<i>Um... hi,</i>\" you venture.");
			outputText("\n\nThe eyes raise up and a smile appears beneath.  \"<i>Um... hi!</i>\"");
			outputText("\n\nYou cross the few steps over to the barrel and its occupant; the beaming smile persists");
			if (player.tallness > 48) outputText(" even as the face angles up to maintain eye contact");
			outputText(".  Peering into the barrel, you can make out a little, though most of her décolletage is obscured by a pair of gangly knees.  The previously-noted head sits atop a pair of narrow, thin shoulders bearing equally wiry-looking arms.  She raises one hand and gives you a little finger wave.");
			outputText("\n\n\"<i>Excuse me... could you get out of there?</i>\" you ask.  Prompted by her subsequent failure to react, you add, \"<i>I drink out of that.</i>\"");
			outputText("\n\nStill she stays put.  Right, well... you grab the dipper hung on the side of the barrel and mime dipping it - pointing at the container after you do - then tilting it to your lips and taking a deep swallow.  Her eyes light up, and she nods at you eagerly.  Taking the dipper from you, she stands.");
			outputText("\n\nNow exposed above the calf, you can make out more of her details.  The theme of gawky angularity suggested by her bust holds force throughout; though she's about as tall as her race gets, her pair of small tits - they can't be bigger than an A-cup - is nearly concealed by drooping gills almost comically oversized for her chest.  Her torso is slender, while her hips are somewhat more curvy by contrast, sloping out gently below the waist to descend into narrow, long legs and form a general feminine structure, albeit one from underfunded builders.  A blue wiener hangs from her pelvis, dangling in the open space between her thighs.  This girl is skinny, no matter how you look at her.");
			outputText("\n\nAnd... she's plunging the dipper into the barrel around her ankles.  You can hear it scraping the sides and bottom as she swishes it around to fill it up.  Politely and carefully handing it back to you, she resumes her seat and the water level rises slightly to cover her legs.  You stare at the dipper and then at her; she returns your gaze unflinchingly, splashing some liquid on her exposed gills with an idle hand.");
			outputText("\n\nDoes she expect you to drink this?  And does she plan to live in your camp?  Won't it be absurdly toilsome to evict someone from your water barrel without speaking a word of their language or using physical force?  Your mind, unwilling to fathom answers to these questions - which is just as well since they're all variations on 'yes' - latches onto the trivial like a lifeline.  The water level was definitely lower than you left it before your nap.  Maybe she absorbed it through her skin as she grew to adulthood?  This might explain why her hips and thighs are better developed than her chest and 'hair'.");
			outputText("\n\nChanging tack to work your hesitant brain around to the real issue, you address her again; assisted by clumsy pantomime, you ask her if she intends to stay in your barrel forever.  She smiles widely, her eyes lighting up, then makes a show of bowing her head graciously several times.  Oh... she thought it was an invitation.  The wind spills out of your sails and your shoulders slump in the face of her cheerful imperturbability.  Looks like words won't work; you'll have to reach her with your fists.  Do you eject the anemone from your camp?");
			simpleChoices("Keep It", keepAnemoneKid, "Eject", getRidOfAnemone, "", null, "", null, "", null);
			//[yesno]
		}

//[yes, i am allergic to fun. sweep the leg, johnny! get 'em a body bag!]
		private function getRidOfAnemone():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			outputText("Enough of this.  Summoning your backbone, you grasp the anemone's upper arm and pull her to her feet; she's light as a decorative feather and twice as blue once she grasps your intention and her camouflage reflex takes over.  Putting one arm under her, you carry her legs out from underneath and lift her bodily out of the barrel, then set her down on the hard ground.  She turns a teary pout on you, but you look away.  Picking up the nearly-empty container and setting it atop your shoulder, you begin the walk to the stream.  The girl stumbles along behind you, unsteady on her feet.");
			outputText("\n\nUpon reaching your destination, you dump the contents of the anemone's erstwhile apartment into the babbling brook, then point down-current toward the lake and set your jaw.  Glancing at your stony demeanor, the blue girl steps into the water, moistens her gills, and then begins the long trek to her ancestral home.");
			//(set Kidswag to -1)
			flags[kFLAGS.ANEMONE_KID] = -1;
			doNext(playerMenu);
		}

//[no, bonsai anemone is awesome and fuck the haters]
		private function keepAnemoneKid():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			outputText("You frown as you stare into the opaque eyes.  You can't think of any way to get her out of the barrel, short of manhandling her into the wilderness where she'll flourish or expire depending on fate, and you haven't the heart for such endeavors.  Ah... she looks so happy sitting there with her head resting on her hands, too.  Well, worse things could happen - but probably not stranger.");
			outputText("\n\n\"<i>So... what do I call you, then?</i>\" you ask; she looks at you quizzically.  You continue to muse, wondering aloud what you would even name a kid anemone.");
			outputText("\n\n\"<i>Kid... ?</i>\" starts the girl, attempting to duplicate your speech.  You try to clarify, but, seeming not to hear, she continues to sound out the words and get the shape of them.");
			outputText("\n\nWaving your hand, you break in on her thoughts.  Once you're born, you explain, then you get a name; girls become Sarahs or Victorias, while boys become Bonecrushers or Teardrinkers.  She can't just be 'kid'.");
			outputText("\n\n\"<i>Then,</i>\" she rejoins, tilting her head in thought to absorb the conversation she's still several lines behind in, \"<i>Kid... Aeh?</i>\"");
			outputText("\n\n\"<i>Really? 'Kid A'?</i>\"");
			outputText("\n\n\"<i>Sarahs you're born!</i>\"");
			outputText("\n\nYe gods and little fishes, you've taught her how to pun.  You make a mental note to look for another water barrel, preferably sans occupant, and keep it stashed out of sight.  Briefly and halfheartedly you play with the idea of searching this world for species to comprise Kids B through Z, but put it aside.");
			outputText("\n\n(<b>Kid A can be found in your \"Stash\"!</b>)");
			//set Kidswag flag to 1
			flags[kFLAGS.ANEMONE_KID] = 1;
			doNext(playerMenu);
		}


//KID A FOLLOWER STUFF
		public function anemoneBarrelDescription():void {
			if (model.time.hours < 6) //(morning)
				outputText("Kid A is sleeping in her barrel right now.");
			else if (model.time.hours <= 10)
				outputText("Kid A stands next to her barrel, refilling it from one of your waterskins.  A second full skin is slung over her shoulder.  She gives you a grin.\n\n");
			else if (flags[kFLAGS.KID_SITTER] > 1)
				outputText("Kid A is absent from her barrel right now, dragooned into babysitting again.\n\n");
			else if (model.time.hours < 16) //(midday)
				outputText("Kid A is deep in her barrel with the lid on top, hiding from the midday sun.\n\n");
			else if (model.time.hours < 22) //(night hours)
				outputText("Kid A is peeking out of her barrel.  Whenever you make eye contact she breaks into a smile; otherwise she just stares off into the distance, relaxing.\n\n");
			else outputText("Kid A is here, seated demurely on the rim of her barrel and looking somewhat more purple under the red moon.  She glances slyly at you from time to time.\n\n");
		}

//[Barrel] button in [Stash] menu (appears whenever Kidswag flag >= 1)
		public function approachAnemoneBarrel():void
		{
			var item:Function =null;
			var weaponT:String = "Give Weapon";
			var weaponB:Function = giveAnemoneWeapon;
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			outputText("You walk over to the barrel.  ");
			//[(display if hourssinceKiditem >= 16)
			if (flags[kFLAGS.KID_ITEM_FIND_HOURS] != model.time.days) {
				outputText("An item sits next to it, left there by the anemone as a present to you.  Or 'rent', if you choose to think of it that way.  ");
				item = getAnemoneItem;
			}
			//[(if Kid A has been given a weapon)
			if (flags[kFLAGS.ANEMONE_WEAPON_ID] != 0) {
				outputText("She has " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + " sitting next to it.  ");
				//outputText("Kid A pokes her head out and smiles at you.  What do you need from her?");
				weaponT = "Take Weapon";
				weaponB = takeOutOfAnemone;
			}
			//(if babysitting)
			if (flags[kFLAGS.KID_SITTER] > 1) outputText("Kid A is away right now, helping season some of Marble's children.  If you wanted to leave or take an item, she would discover it when she got back.  ");
			else if (kidAXP() < 25) outputText("Kid A sinks below the rim, peering nervously at you.  ");
			else if (kidAXP() < 75) outputText("Kid A pokes her head out and smiles at you.  ");
			else outputText("Kid A leans her head and shoulders out of the barrel and puts her elbows on the rim, staring unabashedly at you as she rests her chin on her hands.  ");
			outputText("What do you need from her?");
			//[(if N.Watch is toggled on)
			if (flags[kFLAGS.ANEMONE_WATCH] > 0) outputText("\n\n<b>Kid A is currently watching for enemies at night.</b>");

			//Tutor, N.Watch, and Evict require the anemone to be present
			menu();
			addButton(0, "Item", item);
			addButton(1, weaponT, weaponB);
			addButton(5, "Leave Anemones", dontTakeAnemones).hint("Please dont take away any anemones you bear.").disableIf(flags[kFLAGS.DONT_TAKE_ANEMONES_PLEZ] == 1, "She has agreed to leave your anemones alone");
			if (flags[kFLAGS.KID_SITTER] <= 1) {
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] != 0 && player.fatigue <= (player.maxOverFatigue() - 25)) addButton(3, "Tutor", tutorAnemoneKid);
				else if (player.fatigue > (player.maxOverFatigue() - 25)) outputText("\n\nYou're too tired to tutor Kid A.");
				addButton(4, "Watch", anemoneWatchToggle);
				addButton(8, "Evict", evictANemone);
				addButton(2, "Sex", kidASex, false)
					.disableIf(player.lust < 33, "You aren't aroused enough to have sex with her right now.")
					.disableIf(!sexPossible(), "You need a vagina or a fitting (60) dick to have sex with her.")
					.disableIf(kidAXP() < 40, "Kid A isn't self-confident enough to have sex with right now...  Perhaps if you could tutor her with a weapon she seems to agree with?")
					.disableIf(!flags[kFLAGS.HAD_KID_A_DREAM] || flags[kFLAGS.ANEMONE_KID] < 2, "", "???");
			}
			addButton(14, "Back", inventory.stash);
		}

//[Item](only appears if hourssinceKiditem flag >= 16)
		private function getAnemoneItem():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			var itype:ItemType;
			outputText("You reach down and pick up her present.  Today, she's left you ");
			if (kidAXP() == 0) itype = consumables.DRYTENT;
			else if (kidAXP() < 50) {
				///[IncubusDraft/SuccubusMilk/ImpFood/MinoBlood/LargeAxe]
				itype = randomChoice(consumables.INCUBID, consumables.SUCMILK, consumables.IMPFOOD, consumables.GOB_ALE, consumables.WETCLTH, consumables.L_DRAFT, consumables.W_FRUIT, consumables.EQUINUM);
			}
			else if (kidAXP() < 75) {
				//White Book/Bee Honey/Ovi Elixir/Shark Tooth/S. Swimwear/Lust Draft/Bimbo Liqueur(same odds as player drop)
				itype = randomChoice(consumables.W__BOOK,consumables.BEEHONY,consumables.OVIELIX,consumables.SHARK_T, armors.S_SWMWR, consumables.L_DRAFT);
				if (rand(100) == 0) itype = consumables.BIMBOLQ;
			}
			else if (kidAXP() < 100) {
				//Mino Blood/Large Axe/Comfortable Clothes/Lust Draft/Lust Dagger/Bro Brew(same odds as player drop)
				itype = randomChoice(consumables.MINOBLO, weapons.L__AXE, armors.C_CLOTH, consumables.L_DRAFT, weapons.L_DAGGR);
				if (rand(100) == 0) itype = consumables.BROBREW;
			}
			else {
				//T.Shark Tooth/Pink Gossamer/Black Gossamer/Reptilum
				var choice:Number = rand(100);
				if (choice == 0) itype = consumables.BROBREW;
				else if (choice == 1) itype = consumables.BIMBOLQ;
				else
					itype = randomChoice(consumables.TSTOOTH, consumables.S_GOSSR,consumables.B_GOSSR,consumables.REPTLUM);
			}
			outputText(itype.longName + ".");
			if (itype == weapons.L__AXE) outputText("  Holy... how did she drag this thing home!?");
			outputText("\n\n");
			inventory.takeItem(itype, playerMenu);
			//(set hourssinceKiditem = 0)
			flags[kFLAGS.KID_ITEM_FIND_HOURS] = model.time.days;
		}

		private function dontTakeAnemones():void {
			clearOutput();
			outputText("You ask the little anemone kid to please leave any Anemones that you bear to term, rather than deal with them like she has been.[pg]");
			outputText("She looks at you quizically for a moment before nodding her head.");
			flags[kFLAGS.DONT_TAKE_ANEMONES_PLEZ] = 1;
			doNext(approachAnemoneBarrel);
		}

//[Give Weapon]
		private function giveAnemoneWeapon(page:int = 1):void {
			var x:int;
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			outputText("What do you want to give her?");
			function giveableToAnemone(item:ItemType):Boolean {
				return item == consumables.W__BOOK || item == consumables.B__BOOK || item == consumables.W_STICK || item is Weapon;
			}
			menu();
			EngineCore.hideUpDown();
			var foundItem:Boolean = false;
			if (page == 1) {
				for (x = 0; x < 10; x++) {
					if (player.itemSlots[x].quantity > 0 && giveableToAnemone(player.itemSlots[x].itype)) {
						addButton(x, player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity, placeInAnemone, x);
						foundItem = true;
					}
				}
				if (inventory.getMaxSlots() > 10) addButton(13, "Next", giveAnemoneWeapon, page + 1);
			}
			if (page == 2) {
				for (x = 10; x < 20; x++) {
					if (player.itemSlots[x].quantity > 0 && giveableToAnemone(player.itemSlots[x].itype)) {
						addButton((x-10), player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity, placeInAnemone, x);
						foundItem = true;
					}
				}
				addButton(12, "Prev", giveAnemoneWeapon, page - 1);
				if (inventory.getMaxSlots() > 20) addButton(13, "Next", giveAnemoneWeapon, page + 1);
			}
			if (page == 3) {
				for (x = 20; x < 30; x++) {
					if (player.itemSlots[x].quantity > 0 && giveableToAnemone(player.itemSlots[x].itype)) {
						addButton((x-20), player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity, placeInAnemone, x);
						foundItem = true;
					}
				}
				addButton(12, "Prev", giveAnemoneWeapon, page - 1);
				if (inventory.getMaxSlots() > 30) addButton(13, "Next", giveAnemoneWeapon, page + 1);
			}
			if (page == 4) {
				for (x = 30; x < 40; x++) {
					if (player.itemSlots[x].quantity > 0 && giveableToAnemone(player.itemSlots[x].itype)) {
						addButton((x-30), player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity, placeInAnemone, x);
						foundItem = true;
					}
				}
				addButton(12, "Prev", giveAnemoneWeapon, page - 1);
				if (inventory.getMaxSlots() > 40) addButton(13, "Next", giveAnemoneWeapon, page + 1);
			}
			if (page == 5) {
				for (x = 40; x < 50; x++) {
					if (player.itemSlots[x].quantity > 0 && giveableToAnemone(player.itemSlots[x].itype)) {
						addButton((x-40), player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity, placeInAnemone, x);
						foundItem = true;
					}
				}
				addButton(12, "Prev", giveAnemoneWeapon, page - 1);
			}
			if (!foundItem) outputText("\n<b>You have no appropriate items to have your offspring hold.</b>");
			addButton(14, "Back", inventory.stash);
		}

		private function placeInAnemone(slot:int):void {
			clearOutput();
			outputText("You leave the item by her barrel.");
			spriteSelect(SpriteDb.s_kida);
			//(set Kidweapon to item name, remove from inventory)
			flags[kFLAGS.ANEMONE_WEAPON_ID] = player.itemSlots[slot].itype.id;
			player.itemSlots[slot].removeOneItem();
			doNext(approachAnemoneBarrel);
		}

//[Take Weapon]
		private function takeOutOfAnemone():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			outputText("You take the item back.  ");
			var itype:ItemType = ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]);
			if (flags[kFLAGS.ANEMONE_WATCH] > 0) {
				outputText("Your anemone daughter will not be able to guard you at night without a weapon.  If you want her to guard, you'll need to give her a new weapon and tell her to watch at night again.  ");
				flags[kFLAGS.ANEMONE_WATCH] = 0;
			}
			inventory.takeItem(itype, playerMenu);
			//(add weapon to inventory, then revert Kidweapon to empty)
			flags[kFLAGS.ANEMONE_WEAPON_ID] = 0;
		}

//[N.Watch]
		private function anemoneWatchToggle():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			//toggles Kid A's night watch; unusuable unless she's armed
			//if Kid A is unarmed when PC tries to turn on, output:
			if (flags[kFLAGS.ANEMONE_WATCH] > 0) {
				outputText("You tell Kid A not to worry about guarding at night.  She nods in your direction.");
				flags[kFLAGS.ANEMONE_WATCH] = 0;
			}
			else {
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] == 0) {
					outputText("You're not really going to set this featherweight against the night barehanded, are you?!  Her hair hasn't even grown out!  You'd better hand her some kind of weapon.");
				}
				else {
					outputText("Kid A smiles and cheers, \"<i>Guard!</i>\"");
					flags[kFLAGS.ANEMONE_WATCH] = 1;
				}
			}
			doNext(approachAnemoneBarrel);
		}

//[Tutor](only appears if Kid A is armed and present)
		private function tutorAnemoneKid():void
		{
			clearOutput();
			//(if lust > 99, output)
			if (player.lust >= player.maxOverLust()) {
				outputText("You're way too horny to focus on any sort of weapon instruction right now, and the anemone can see it in your expression as your gaze wanders over her body; she blushes a deep blue and shrinks into her barrel with a shy glance.");
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			outputText("The anemone obediently climbs out of her barrel, ");
			//[(KidXP < 33)]
			if (kidAXP() < 33) {
				outputText("holding " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + " protectively across her chest.");
			}
			else outputText("taking up an attentive stance with " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + " in her hands.");

			outputText("  You spend some time instructing Kid A in the finer points of the equipment you've provided her with, and then finish up with a practice duel.");

			//duel effects by weapon, output in new PG
			//[Pipe] or [Wizard Staff] or [Eldritch Staff]
			if (InCollection(flags[kFLAGS.ANEMONE_WEAPON_ID], weapons.PIPE.id, weapons.MACE.id, weapons.W_STAFF.id, weapons.E_STAFF.id, weapons.L_STAFF.id)) {
				outputText("\n\nThough she acts like she's not serious and pulls her swings more often than not, the heft of the ");
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.PIPE.id) outputText("pipe");
				else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.MACE.id) outputText("mace");
				else outputText("stick");
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] != weapons.MACE.id) outputText(" is still enough to bruise you a bit.");
				else outputText(" manages to bruise you a lot.");
				HPChange(-5, false);
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.MACE.id) HPChange(-15, false);
				kidAXP(6);
			}
			//(HP - 5, KidXP + 1)
			//[Riding Crop]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.RIDINGC.id) {
				outputText("\n\nShe seems to enjoy smacking you with the riding crop, making sultry eyes at you and pursing her lips whenever she lands a crack on your [butt] or [chest].  So much so, in fact, that her own penis is betraying her arousal, bobbing in time as she swishes the weapon around.  The humiliation ");
				if (player.lib < 50) outputText("is");
				else outputText("isn't");
				outputText(" enough to keep you from thinking dirty thoughts about grabbing her naughty, teasing face and mashing it into your crotch.");
				//(HP - 5, lust +5 if lib>=50, KidXP + 2)
				HPChange(-5, false);
				if (player.lib >= 50) dynStats("lus", 5, "scale", false);
				kidAXP(6);
			}
			//[Lust Dagger]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.L_DAGGR.id) {
				outputText("\n\nThe enchanted dagger is light enough for the anemone to use one-handed, and she makes a good practice of turning aside your mock blows with it while reaching in to stimulate you with her other hand.  For good measure, she nicks you with the blade itself whenever her caress elicits a distracted flush.");
				//(HP -5, lust +10, KidXP + 3)
				HPChange(-5, false);
				dynStats("lus", 10, "scale", false);
				kidAXP(5);
			}
			//[Dagger]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.DAGGER.id) {
				outputText("\n\nThe dagger is light enough for the anemone to use one-handed, and she makes a good practice of turning aside your mock blows with it while reaching in to stimulate you with her other hand.  For good measure, she nicks you with the blade itself whenever her caress elicits a distracted flush.");
				//(HP -5, lust +5, KidXP + 3)
				HPChange(-5, false);
				dynStats("lus", 5, "scale", false);
				kidAXP(5);
			}
			//[Beautiful Sword]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.B_SWORD.id) {
				outputText("\n\nThe sword seems to dance in the air, as though it were the perfect weight and balance for your daughter.  She delivers several playful thrusts at you and though you deflect all but the last, that one slips by your guard.  The girl's eyes widen as the point lunges at your breast, but it delivers barely a scratch before twisting away.");
				outputText("\n\nPerhaps anemones are a bit too corrupt to use the sword effectively?");
				//(HP -1, KidXP - 2)
				HPChange(-1, false);
				kidAXP(-2);
			}
			//[Jeweled Rapier] or [Raphael's Rapier]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.RRAPIER.id ||
					flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.JRAPIER.id) {
				outputText("\n\nThe rapier is light enough for the girl, but it takes a multitude of reminders before she handles the slender blade with the care and style it deserves.  She seems to regard it as little more than a tool for thwacking you in the butt that, coincidentally, has a pointy end.");
				//(no effect, señorita)
			}
			//[Large Axe], [Large Hammer], [Large Claymore], or [Huge Warhammer]
			else if (InCollection(flags[kFLAGS.ANEMONE_WEAPON_ID], weapons.L__AXE.id, weapons.L_HAMMR.id, weapons.WARHAMR.id, weapons.L__AXE.id)) {
				outputText("\n\nShe can barely lift the weapon you've given her, although for a while she does manage to support one end with the ground and tilt it by the haft to ward off your blows with cleverness.  Distracting her by way of a feint, you part her from it and advance with a smile full of playful menace... whereupon she shrieks and pushes you backwards, causing you to trip over the weapon and fall with a crash.");
				//(HP - 5, KidXP - 4)
				kidAXP(-4);
				HPChange(-5, false);
			}
			//[Katana] or [Spellsword]
			else if (InCollection(flags[kFLAGS.ANEMONE_WEAPON_ID], weapons.KATANA.id, weapons.TIDAR.id, weapons.S_BLADE.id, weapons.SCIMITR.id, weapons.B_SCARB.id )) {
				outputText("\n\nThe light sword and the light anemone seem to be a good match, and she actually manages to make several deft moves with it after your instruction.  One is a bit too deft, as she fails to rein in her swing and delivers a long, drawing cut that connects with your [leg].");
				//(HP - 20, KidXP + 2)
				kidAXP(4);
				HPChange(-20, false);
			}
			//[Spear]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.SPEAR.id) {
				outputText("\n\nThe natural length of the spear and the anemone racial mindset to get close and communicate by touch don't mesh well; she chokes up well past halfway on the haft despite your repeated instruction and pokes at you from close range with very little force, the idle end of the weapon waggling through the air behind her.");
				//(HP -5, KidXP - 1)
				kidAXP(-1);
				HPChange(-5, false);
			}
			//[Whip] or [Succubi's Whip]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.WHIP.id ||
					flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.SUCWHIP.id) {
				outputText("\n\nThe whip seems almost like an extension of her hand once she decides its purpose is to tangle things up as opposed to lashing and lacerating flesh.  One of her overzealous swings finds you <i>both</i> tied in its coils; her petite body presses against yours as she colors in embarrassment.  Her distracted struggles to loosen the bonds accomplish little except to rub her sensitive parts along yours.");
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.SUCWHIP.id) outputText("  The demonic enchantment chooses then to activate, and her color deepens as her lust peaks, as does your own.");
				outputText("  You feel a point digging into your groin as her prick hardens and her struggles cease; she begins to moan openly in arousal.  As she relaxes, the coils of the whip finally loosen enough for you to extricate yourself.");
				//(HP -0, lust +10 if normal whip or +20 if succubus, KidXP + 3)
				dynStats("lus", 10, "scale", false);
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.SUCWHIP.id) dynStats("lus", 10, "scale", false);
				kidAXP(6);
			}
			//[Spiked Gauntlets] or [Hooked Gauntlets]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.S_GAUNT.id ||
					flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.H_GAUNT.id) {
				outputText("\n\nThe anemone wears the gauntlets easily and comfortably, but doesn't seem to understand that to attack she needs to ball up her fists and swing them, no matter how many times you tell her.  The most she manages is to deflect a few of your mock lunges by batting them aside with the metal atop her knuckles.");
				//(no tigereffect)
			}
			//[Wingstick]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == consumables.W_STICK.id) {
				outputText("\n\nThe girl stares at the stick, still uncomprehending how you intend her to use it.  One last time, you take the weapon from her and make a throwing motion, then return it.  She looks from it back to you once more, then tosses it at your head.  As it impacts with a clunk and your vision jars, she clutches her stomach in laughter.");
				//(HP - 10, set Kidweapon to empty, KidXP + 1)
				HPChange(-10, false);
				flags[kFLAGS.ANEMONE_WEAPON_ID] = 0;
				kidAXP(5);
			}
			//[Dragonshell Shield]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == shields.DRGNSHL.id) {
				outputText("\n\nYour protégé takes to the shield quite well, hiding behind it like... well, like a portable water barrel.  Even the way she peeks over the top is reminiscent.  She makes effective use of her cover, pushing forward relentlessly and delivering soft headbutts to spread venom to unprotected areas.");
				//(lust + 5, temp str/spd down, KidXP + 5)
				//str/spd loss reverts after clicking Next button
				kidAXP(5);
				dynStats("lus", 10, "scale", false);
			}
			//[White Book]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == consumables.W__BOOK.id) {
				outputText("\n\nPart literacy training and part magic instruction, your progress through the book is painstakingly slow.  After almost an hour of trying to get the anemone to concentrate on the words, she finally manages to cause a small flash of white light on the page in front of her - whereupon she shrieks and drops the book, covering her head with her arms and backing away.");
				//(KidXP - 5)
				kidAXP(-5);
			}
			//[Black Book]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == consumables.B__BOOK.id) {
				outputText("\n\nThe girl sits attentively with you, resting her head against your arm, as you teach her the words needed to evoke the formulae in the book.  When you suggest she try one out, however, she shakes her head with wide eyes.  Insisting, you stand apart from her and fold your arms.  Blushing a deep blue, the anemone resigns herself to focusing on your crotch as she mouths quiet syllables.  After a few moments, you actually feel a small glow of lust where she's staring.  The girl giggles nervously and looks away as you flush and your garments ");
				if (player.hasCock()) outputText("tighten");
				else if (player.hasVagina()) outputText("dampen");
				else outputText("become a hindrance");
				outputText("... though the part between her own legs is still pointed at you.");
				//(lust + 10, KidXP + 2)
				dynStats("lus", 20, "scale", false);
				kidAXP(4);
			}
			//[Scarred Blade]
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.S_BLADE.id) {
				outputText("\n\nThe anemone attempts to draw the bloodthirsty saber at your insistence, but as she pulls it free of the scabbard, it jerks from her hands, lashing across her thigh before clattering noisily to the ground and spinning away.  Her shock grows as thick, clear fluid seeps from the cut, and she covers her mouth with her hands, looking up at you with piteous, wet eyes.");
				//[(if corr <=70)
				//if (player.cor <= 70) outputText("  The blade's edge flashes toward you as well, when you try to pick it up.  After a few frustrated attempts, it becomes clear that you'll have to abandon it for now.");
				//empty Kidweapon, KidXP - 5; if corr <=70, set sheilacite = 5, else add Scarred Blade to inventory)
				flags[kFLAGS.ANEMONE_WEAPON_ID] = 0;
				kidAXP(-5);
				/*if (player.cor <= 70) {
					//9999
					//9999
				}*/
				inventory.takeItem(weapons.SCARBLD, camp.returnToCampUseOneHour);
				kidAXP(-5);
				return;
			}
			//[Flintlock Pistol] (Because guns are awesome.)
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weaponsrange.FLINTLK.id) {
				outputText("\n\nAs if the anemone girl already knows how to use a gun, she easily pulls the trigger and fires rounds of ammunition towards you!  ");
				if (silly()) outputText("Pew pew pew!  ");
				if (player.spe >= 70) {
					outputText("You easily dodge the bullets thanks to your speed!");
				}
				else if (player.spe >= 40 && player.spe < 70) {
					outputText("You try to dodge the bullets that are coming towards you.  You manage to dodge some but unfortunately, you've got hit.  You see yourself bleeding.  You tell her to stop and she obeys.");
					HPChange(-10, false);
				}
				else {
					outputText("You try your best to avoid but you're unable to at all.  Anemone stops firing when she sees that you're bleeding and gives you a sheepish grin.");
					HPChange(-40, false);
				}
				kidAXP(5);
			}
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weaponsrange.LCROSBW.id) {
				outputText("\n\nAs if the anemone girl already knows how to use a crossbow, she easily pulls the lever mechanism and fires a bolt towards you!  She reloads the crossbow and fires again.  ");
				if (player.spe >= 60) {
					outputText("You easily dodge the incoming bolts thanks to your speed!");
				}
				else if (player.spe >= 30 && player.spe < 60) {
					outputText("You try to dodge the bolts that are coming towards you.  You manage to dodge some but unfortunately, you've got hit.  You see yourself bleeding.  You tell her to stop and she obeys.");
					HPChange(-10, false);
				}
				else {
					outputText("You try your best to avoid but you're unable to at all.  Anemone stops firing when she sees that you're bleeding and gives you a sheepish grin.");
					HPChange(-40, false);
				}
				kidAXP(5);
			}
			else if (flags[kFLAGS.ANEMONE_WEAPON_ID] == weapons.FLAIL.id) {
				outputText("\n\nThe girl holds up the flail with no problem and you teach her how to use the weapon.  However, after dozens of swings, she accidentally hits herself with the spiked ball and looks at you with a whimper.  You tell her to stop; maybe this isn't the right weapon for her?");
				HPChange(-10, false);
				kidAXP( -2);
				return;
			}
			//[Any new weapon added without text written for it, or any custom item name set by a save editor]
			else {
				outputText("\n\nFor the life of her, Kid A can't seem to grasp how to use the " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + " you've provided her with.  You have to interrupt the practice for explanations so many times that you don't actually get to do any sparring.");
				//(no effect, but you can just save edit the values you want anyway)
			}
			//if hp = 0 after tutor, override any other result and output new PG:
			if (Math.round(player.HP) <= Math.round(player.minHP())) {
				outputText("\n\nWith a groan, you fall flat on your back and close your eyes.  As if from far away, you hear ");
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] != weapons.S_GAUNT.id &&
						flags[kFLAGS.ANEMONE_WEAPON_ID] != weapons.H_GAUNT.id) outputText("the thump of something hitting the ground and ");
				outputText("the anemone gasp, and then the world slips away from you.");

				outputText("\n\n<b>Eight hours later...</b>");
				outputText("\nYour bleary eyes open to a familiar-looking upside-down blue face.  It takes a minute before your brain can reconstruct the events preceding your lapse in consciousness; as soon as your expression gives a hint of understanding, Kid A sheepishly greets you.");
				outputText("\n\n\"<i>Um... hi.</i>\"");
				//(lose 8 hours, restore HP amount consonant with 8hrs rest)
				doNext(camp.returnToCampUseEightHours);
				player.createStatusEffect(StatusEffects.PostAnemoneBeatdown, 0, 0, 0, 0);
				return;
			}
			//Sex scenes, post dream
			if (flags[kFLAGS.HAD_KID_A_DREAM] > 0 && kidAXP() >= 40 && player.lust >= player.maxOverLust()) {
				if (sexPossible()) kidASex();
				//nothing fits
				//if KidXP >= 40 and lust > 99 after tutor and PC has only huge dicks of area >= 60 or hasn't got shit
				else if (kidAXP() >= 40 && player.lust >= player.maxOverLust()) {
					outputText("\n\nYou collapse onto your back, panting your arousal into the dry air.  Shyly at first but with increasing confidence as you fail to react, the girl slips a hand into your clothes and down to your crotch.  She stops, wide-eyed, as her fingers initially locate ");
					if (player.hasCock()) outputText("something too enormous");
					else outputText("nothing useful");
					outputText(" to relieve your burden with, then resumes the search with a hint of desperation.  Finally and after exhaustive prodding, she withdraws her hand and chews her lip in consternation.");

					outputText("\n\nAppearing to reach a decision, she reaches out and pats you apologetically on the head, then stands up and heads back to her barrel.");
					//no effect on lust, pass 1 hour
					doNext(camp.returnToCampUseOneHour);
				}
			}
			//else if no HP or lust outcome triggered: pass 1 hour, gain 40 xp, increment fatigue by 10
			else {
				if (player.level < 10) player.XP += 30;
				fatigue(25);
				doNext(camp.returnToCampUseOneHour);
			}
		}

		//
		private function sexPossible():Boolean {
			return player.cockThatFits(60) >= 0 || player.hasVagina();
		}

		private function kidASex(cont:Boolean = true):void
		{
			if (!cont) {
				clearOutput();
				outputText("Smiling lustily at Kid A, you run your hand through her hair, inhaling deep breaths as you allow her venom to affect you more and more.  She blushes, but watches eagerly.  Soon, the tingling lust has you overwhelmed...");
			}
			//pseudo-virgin vaginal, one time only
			//if KidXP >= 40 and lust > 99 after tutor and PC has wang of area <36 and Kidswag = 2
			if (flags[kFLAGS.ANEMONE_KID] == 2 && player.hasCock() && player.cockThatFits(36) >= 0) sexVirgin();
			else sceneHunter.selectGender(sexFellatio, sexVaginal, null, null, 1,
				player.cockThatFits(60) >= 0, "Req. a dick fitting 60 area!");
		}

		public function sexVirgin():void {
			var x:int = player.cockThatFits(36);
			if (recalling) clearOutput();
			else outputText("\n\n");
			outputText(images.showImage("anemone-kid-male-vagfuck"));
			outputText("You collapse onto your back, panting your arousal into the dry air.  Shyly at first but with increasing confidence as you fail to react, your daughter slips a hand into your clothes and down to your crotch.  She bites her lip and blushes as her hand reaches the neck of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", then her resolve appears to crystallize as she yanks it free from your [armor]. At first, nothing happens and your erect cock just bobs through the empty air, but then you feel soft fingertips guiding it and a warm, tight squeeze at the end of your dick.  Raising your head in surprise, you see the anemone has mounted you!  She blushes and looks away at the eye contact, but her mouth opens in a sly grin as she begins to shift her hips, sliding your " + cockDescript(x) + " deeper into herself.");


			outputText("\n\nShe flushes and winces as you sink into her, breathing heavily as her pussy stretches and her small cock hardens over you.  Gods, it's so tight; as you look your amazement at her, her eyes twinkle.  She takes in the last of your shaft laboriously and then, relaxing, leans forward and plants a kiss on your chest to answer your unspoken question.  The girl was actually saving her first time for you?  You prop yourself up on your elbow and pull her face into yours, giving her a short kiss; she smiles bashfully and then pulls out of your grip to sit upright with her hands on your stomach.");

			outputText("\n\nBeginning to move her hips, she stirs herself with your " + Appearance.cockNoun(player.cocks[x].cockType) + " as she gyrates, loosening herself slightly; you take the opportunity to pull off the top of your [armor] eagerly and she answers you by pushing her cock down onto your skin with a hand, smearing its tentacled crown around with her movement and spreading venomous heat to your torso even as she moans and the tip drools on your stomach.  After two minutes of this teasing, she grins again and raises up, pulling your cock partway out; you tense and shut your eyes in expectation of what's to come, but she just hovers there.  Curiously, you open your eyes again and look at her - which seems to be what she was waiting for.  At the first sign of your guard dropping, her eyes glint suspiciously and she begins riding you in earnest, plunging up and down your cock with her incredibly tight pussy; your sensation-swamped body carries you away and you begin pushing back against her as she descends, so that your groins meet each other in the air.  She gasps and smiles open-mouthed with her head back, removing the hand still on your stomach to fondle her breasts as she fucks you senseless.  At the nadir of every bounce, the feelers on her cock and vagina rub against your exposed skin, delivering a fresh load of anemone venom that pushes you closer to orgasm by leaps and bounds.");

			outputText("\n\nThe girl herself doesn't seem to be faring much better; her left hand is furiously jerking her cock and her right is squeezing her small breasts as she rides, while her mouth hangs open and she makes tiny grunts of pleasure at each stroke.  Predictably, she twitches and sinks down one last time as her pecker spasms and she cries out.  She pushes her little blue shaft down onto your stomach again and rubs it back and forth as she ejaculates on your [chest]; her clenching pussy meanwhile wrings your dick vigorously, sending a shiver down your spine to spark the venom-induced climax that pours from you.  Your hands grasp her hips as your dick empties into the slender blue girl's womb, spitting semen with a furor enhanced by the continuing dose of aphrodisiac from the vaginal feelers stroking its base as she twitches.");
			//[(big skeet)]
			if (player.cumQ() >= 1000) outputText("  As you pour into her, the sensation of being stuffed with semen sets off a second orgasm in the quivering girl, and her own prick drools weakly onto your stomach");
			if (player.cumQ() >= 2000) outputText("; even a second orgasm from your daughter isn't enough to match one of yours in length.  Your magnificently productive " + Appearance.cockNoun(player.cocks[x].cockType) + " fills her until her belly is inflated so far that she can't contain more, and it begins to breach the seal her pussy makes around you, even as tight as it is, to squirt out in lazy globs as you deposit the last of your spunk");
			if (player.cumQ() >= 1000) outputText(".");
			//[(multi)]
			if (player.cockTotal() > 1) {
				outputText("  The loads from your other shaft");
				if (player.cockTotal() > 2) outputText("s");
				outputText(" ooze down your [legs], directed there by her weight.");
			}
			outputText("\n\nSpent, your blue girl slumps down onto your chest, not even bothering to avoid the puddle of her own spunk or pull your cock out, and is quickly asleep.  Your eyes close as sleep overtakes you as well, though the venom trickling into your chest as she rests her head on it ensures the scene will play over and over in your dreams...");
			//pass 2 hr, remove 100 lust and add 30 base lust before resistance, set Kidswag = 3
			if (!recalling) {
				player.sexReward("vaginalFluids", "Dick");
				dynStats("lus", 30, "scale", false);
				if (flags[kFLAGS.ANEMONE_KID] < 3) flags[kFLAGS.ANEMONE_KID] = 3;
				doNext(camp.returnToCampUseTwoHours);
			} else doNext(recallWakeUp);
		}

		private function sexFellatio():void {
			var x:int = player.cockThatFits(60);
			var y:int = player.findCockNotIn([x]);
			outputText("\n\n");
			outputText(images.showImage("anemone-kid-male-bj"));
			outputText("You collapse onto your back, panting your arousal into the dry air.  Shyly at first but with increasing confidence as you fail to react, your daughter slips a hand into your clothes and down to your crotch.  She bites her lip and blushes as her hand reaches the neck of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", then her resolve appears to crystallize as she yanks it free from your [armor].  A sudden wetness at the end of your dick raises your head in surprise; the mop-topped girl is kneeling over you with the crown in her mouth and, as you make eye contact, turns the deepest shade of blue you've ever seen on her.");

			outputText("\n\nHer embarrassment evidently can't brake her instinct, though, because her mouth continues to work on your " + cockDescript(x) + " even as she casts down her gaze to avoid meeting your own.  As if to conceal herself, her shoulder-length tentacles shift forward to drape over her face, scraping along the end of your dick, right behind the head.  A dose of venom lances through your skin; your eyes roll back and your hips begin to buck gently into her mouth as your reason deserts.");

			//(if multicock, balls, or vag, in order of priority)
			if (y >= 0 || player.hasBalls() || player.hasVagina()) {
				outputText("\n\nYou feel her bashful fingers sneak into your [armor] again, and they quickly locate your ");
				if (y >= 0) outputText(cockDescript(y));
				else if (player.hasBalls()) outputText(sackDescript());
				else if (player.hasVagina()) outputText(vaginaDescript(0));
				//[(if cock or sack)]
				if (y >= 0 || player.hasBalls()) outputText(", pulling it free from your armor as well");
				outputText(".  Her dextrous digits are emboldened as your head lolls in the dirt, staring skyward, and quickly begin to caress their find.");
				//[(cock)
				if (y >= 0) {
					outputText("  Another hand quickly joins the first, stroking the length of your second shaft as it ");
					if (player.cocks[y].cockLength >= 36) outputText("towers over her head");
					else outputText("quivers and twitches into her venomous locks");
					outputText(".  Every time it brushes her hair, another jolt shoots to the base of your spine and both of your cocks force out another glob of precum which is quickly slurped up.");
				}
				//[(sac)
				else if (player.hasBalls()) outputText("  One hand cups below your " + ballsDescript() + " and lifts them up to her chin, where the other, formerly tracing gentle circles along your shaft, grabs a tentacle from her head and begins to tickle.");
				//[(vag)
				else if (player.hasVagina()) {
					outputText("  Her fingers part your labia and reveal your " + clitDescript() + ", ");
					if (player.clitLength >= 6) outputText("working it free as well and allowing her to tease and stroke it, cock-like, with her hands and hair.");
					else outputText("in order to give the sensitive button their attention.");
					outputText("  Her other hand slips into your garments after the first, following it down to your groin and slipping into your pussy to pump back and forth gently.");
				}
			}
			outputText("\n\nHer attentions on your groin reach a peak as ");
			if (player.hasBalls()) outputText("your balls tighten up");
			else outputText("your body tenses");
			outputText("; seeing this, she dives down onto your shaft, forcing the head past the ginger care of lips and tongue into her welcoming throat.  Her hair drapes all around your groin, touching exposed flesh as she shakes her head and undulates her throat to coax out your climax.  Your body reacts before you can, and your hips thrust up into her face as your ejaculate erupts.");
			//[(if multicock or sac)]
			if (player.hasBalls() || y >= 0) {
				outputText("  As her eyes twinkle, the hands on your ");
				if (y >= 0) outputText(cockDescript(y));
				else outputText(sackDescript());
				outputText(" renew their efforts, squeezing out squirts of semen with measured strokes and squeezes.");
			}
			//[(vag)
			else if (player.hasVagina()) {
				outputText("  As her eyes twinkle, a hand plunges all the way into your pussy, and your lonely muscles clamp down reflexively on the invader, attempting to wring her fingers.");
			}
			outputText("  She swallows greedily as you unload into her throat");
			if (y >= 0) outputText(" and onto her hair");
			outputText(", the oral contractions squeezing the head of your penis and setting your body to shivering.");
			//[(big cum)
			if (player.cumQ() >= 500) {
				outputText("  Squirt after huge squirt disappears into the starveling's esophagus, sliding without fail down into her belly, until ");
				if (player.cumQ() < 1000) outputText("your climax is spent.");
				//(mega skeet)
				else outputText("she can hold no more and it begins to drool from her mouth; still she tries her best to swallow more and more, despite the limits of her body.  Obligingly, you grab her head and hold it to you, venom tingling in your fingertips, as the last half of your orgasm empties into her.  With her face mashed into your crotch and escape cut off, the semen has nowhere to go except down the throat, expanding her taut stomach and pushing her skinny butt into the air as she balloons against your legs.  Her eyes widen and look up at you as the pressure increases, and a hum travels down your prick as she attempts to protest.");
			}
			outputText("\n\nFinally, you spend the last of your load and go limp; you feel her throat close around your glans as she pulls away, and a small aftershock squirts from the tip.  She licks this away with relish, ");
			if (player.cumQ() < 1000) outputText("then gets to her feet and returns to her barrel to digest the meal.");
			else outputText("but can barely move from the spot thanks to the incredible distension of her belly.  She manages to drag herself over to the barrel with a great shuffling of arms and legs but cannot by any means get into it, and settles for slumping beside it to occasionally sprinkle water on herself while she deflates.");
			outputText("\n\nAs you wearily raise your head to look at her, she blushes again but doesn't avert her eyes; instead they glint salaciously and she answers you with a small grin.");

			outputText("\n\nYou lay back, spent, and slip from consciousness.");
			//lose 100 lust, pass 2 hr, if Kidswag = 1, set Kidswag = 2
			player.sexReward("vaginalFluids");
			if (flags[kFLAGS.ANEMONE_KID] == 1) flags[kFLAGS.ANEMONE_KID] = 2;
			doNext(camp.returnToCampUseTwoHours);
		}

		private function sexVaginal():void {
			outputText("\n\n");
			outputText(images.showImage("anemone-kid-female-sex"));
			outputText("You collapse onto your back, panting your arousal into the dry air.  Shyly at first but with increasing confidence as you fail to react, your daughter slips a hand into your clothes and down to your crotch.  She stops, vexed, as her fingers find nothing but your " + vaginaDescript(0) + ", then appears to reach a decision and pulls down the bottoms of your [armor].  Gently, she caresses the labia, eliciting a soft moan from you, then looks up nervously at the sound to check your response.  When you continue staring into the empty sky, she pulls away and you feel hands pushing your legs apart.  Even this isn't enough to stir you from your lust-induced haze, nor is the feeling of having your backside lifted by those same hands.  However, when you feel a persistent, wriggling pressure at the entrance to your inflamed pussy, you begin to return to reality.  Lifting your head to look at the anemone, you see her holding your thighs in the air as she attempts to orient herself to you, utmost concentration lining her features.  She succeeds and slides into you, then looks up to check your face again... and drops your body into her lap as she pulls her hands in front of herself defensively at the sudden scrutiny.");

			outputText("\n\nLaughable as her reaction is, the venom now coursing through your " + vaginaDescript(0) + " ensures not a giggle escapes you; your hips begin writhing in her lap, trying to find purchase on the blue girl to better pump her shaft for its seed.");
			//[(if pc is loose)
			if (player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_GAPING) outputText("  You can barely feel her little shaft in your stretched cunt, but the chemical stimulation from the tentacles stroking your insides goes a long way toward making up for that.");
			outputText("  Emboldened, she picks up your legs haltingly, then begins to work herself in and out of your depths.");

			outputText("\n\nWith all the grace of a first-timer, the girl clumsily leans down to kiss you, but falls short and can only plant a smooch on your still-clad [chest].  Still, she continues pumping enthusiastically, worry and shame evaporating from her brow as you moan lustily instead of rebuking her temerity.  Pausing to support you with one hand as she spreads your lips wider with her fingers, she exposes your " + clitDescript() + " to the air.");
			//[(clitsize<6)]
			if (player.clitLength < 6) outputText("  The little button gets rubbed by her probing hand even as she resumes thrusting, accelerating your imminent peaking.");
			else if (player.clitLength < 36) outputText("  The monstrous chick-stick bobs in the air as she pounds you harder; the breeze alone would be enough to arouse you further, but the anemone grabs it and begins jacking the nerve-laden stalk off like a dick, which sends your back into spasms.");
			else outputText("  The incredible length of your clitoris is such that the pace of the fuck slows to a crawl as the anemone puzzles out what to do with it; finally falling back on her racial instinct, she pops it into her mouth and begins to caress the tip gently with her teeth and tongue as her short hair reaches around to tickle the shaft.  Your body flops weakly, too wracked by the sensation from your clit to allow conscious control.");

			outputText("\n\nThough her technique is still nothing to sing praises about, the constant smears of venom coating your pussy with heat do their work industriously, and your orgasm is pried from you by force rather than skill.  Gasping and moaning, you clench down on her rod and your climaxing pussy wrings it for all its worth - which it soon delivers.  She moans in a high-pitched voice as she reclines on her hands and knees, and first one and then a second squirt of cool fluid lands in your overheating cunt.  Her cock continues drooling and trickling her seed even as her elbows fail and she lands on her back.");

			outputText("\n\nYou pull away from her and stagger to your feet, then redress.  Kid A lies on the ground, already asleep from her exertion; you step over her with a grin.");
			//anemone preg chance, slimefeed, reduce lust by 100, if Kidswag = 1 set Kidswag = 2
			AnemoneScene.anemonePreg();
			player.sexReward("cum","Vaginal");
			if (flags[kFLAGS.ANEMONE_KID] == 1) flags[kFLAGS.ANEMONE_KID] = 2;
			doNext(camp.returnToCampUseEightHours);
		}

//[Evict]
		private function evictANemone():void
		{
			clearOutput();
			outputText("Really evict the anemone?");
			spriteSelect(SpriteDb.s_kida);
			//[Yes][No]
			doYesNo(reallyEvictDaAnemone, approachAnemoneBarrel);
		}

//Yes]
		private function reallyEvictDaAnemone():void
		{
			clearOutput();
			spriteSelect(SpriteDb.s_kida);
			outputText("Time to reclaim your barrel.  Gesturing to get her attention, you grab the anemone by her upper arm and lift her to her feet.  She looks at you in confusion, but you set your face and drag her along with you as you make your way to the lake.");
			outputText("\n\nReaching the shore, you push Kid A into the water and point out toward the center of the lake as she falls to her knees in the surf.  She looks absolutely miserable... until a green and purple swirl bobs to the surface next to her.  The new arrival greets your former tenant with cheer, squeezing her waist from behind and eliciting a gasp of surprise.");
			outputText("\n\nKid A turns her head to face the stranger.  \"<i>Um... hi?</i>\" she offers, hesitantly.");
			outputText("\n\n\"<i>Um... hi!</i>\" the other parrots, a grin splitting her face wide open.");
			outputText("\"<i>Um... hi!</i>\" your anemone returns, enthusiastically this time, as she answers the physical contact by tugging one of the newcomer's tentacles.");
			outputText("\n\nThe two girls continue to greet each other in this fashion as their attention shifts away from you, and you wonder exactly what kind of pernicious meme you've inflicted on the anemone community.");
			//set Kidswag to -1, pass 1 hour
			flags[kFLAGS.ANEMONE_KID] = -1;
			doNext(camp.returnToCampUseOneHour);
		}

//dreams: possible once KidXP >= 40; function as visible notice of sex-readiness
//if KidXP drops below threshold for sex due to bad training, no more dreams and no more sex
		public function kidADreams():void
		{
			outputText("\n<b><u>In the middle of the night...</u></b>");
			if (sceneHunter.uniHerms) {
				outputText("\n<i>What will you use in your dreams for some random reason?</i>")
				sceneHunter.selectGender(dickF, vagF);
			}
			else if (player.hasCock() && (!player.hasVagina() || player.femininity < 50)) dickF();
			else vagF();
			//if male:
			function dickF():void {
				outputText(images.showImage("anemone-kid-male-masti"));
				outputText("\nThe church bell chimes overhead as you regard the figure opposite you.  Your family chose this woman and arranged this marriage, true, but it's not fair to say you're not at least a little interested in the svelte, veiled form inhabiting the wedding dress your mother handed down to her.");
				outputText("\n\nThe pastor coughs politely.  \"<i>Well... do you?  Take this woman?</i>\"");

				outputText("\n\nYou nod absently, still staring at your bride.  The pastor repeats his question to her and she nods as well, staring at you in like fashion.");

				outputText("\n\n\"<i>In that case, I pronounce you man and wife.  You may kiss the bride.</i>\"");

				outputText("\n\nYou raise your hands to lift the veil but your bride captures them shyly, tracing little circles on your palms with her gloved thumbs, and begins to pull you down the aisle toward the doors, provoking a giggle from the assembled witnesses.  She drags you eagerly through the archway and through the streets to the little cottage your parents helped you build in preparation for your new life, only stopping outside.  With one hand on her veil and the other in yours, she pulls close and allows you to lift her in your arms; she is amazingly light as she wraps her arms around your neck, nuzzling your chest happily.  You carry your queer spouse through the house and into the bedroom; as you set her carefully on the bed, running your hands along her body, a small bulge begins to form in her crotch, poking up the folds of the white dress.  Clambering atop her to lift the veil unobstructed, she grinds her crotch into yours and begins moaning softly - you can feel your cock hardening as your affectionate stranger pushes her sex into yours, depositing little smears of her precum that seep through your mother's wedding dress into a growing dark spot.  Taking hold of the veil, you hold your breath and raise it...");

				outputText("\n\nA sapphire face looks back at you.  Through opaque eyes she somehow still manages to express more adoration than you've known most of your life.  Placing a hand alongside your ");
				if (player.isTaur()) outputText("thigh");
				else outputText("cheek");
				outputText(", she leans in to kiss you, softly whispering your name over and over.  \"<i>[name]... [name]...</i>\"");

				outputText("\n\nYour eyes snap open suddenly to see the ubiquitous red moon overhead.  A ");
				if (!player.isTaur()) outputText("soft hand strokes your face and a ");
				outputText("slight weight rests against your crotch; as you look down, your anemone is there with her pussy pressed to the erection bulging under your gear, frozen in mid-rub and blushing to the point that you can barely make her out.");

				outputText("\n\n\"<i>Um... hi?</i>\"  She slowly backs away into the night, leaving you to try to sleep with your awakened libido.");
				dynStats("lus", 50 + player.sens / 2, "scale", false);
				doNext(playerMenu);
			}
			//if female:
			function vagF():void {
				outputText(images.showImage("anemone-kid-female-masti"));
				outputText("\nThe elder's son must be behind the schoolhouse again.  You've noticed him going back there several days this week.  Quietly, you slip from behind your desk and exit the little two-room school.  Sure, he might be old enough to be working the fields by now, but that's no excuse to slack off during his final studies.");
				outputText("\n\nAs you draw up to the corner, you can hear his voice raised in soft, girlish gasps.  Peering around carefully, you find him sitting on the ground with his shoulder to the wall, turned away from you; over that shoulder, the little blue head of his cock is clearly visible above his clenched fist.  He continues jerking off, unaware of your presence, and as you look on, you marvel at how much thinner and more feminine this hunched figure compared to the dashing, popular boy from your memory.");
				outputText("\n\n\"<i>[name]!</i>\" he peals suddenly, stroking with vigor at his thoughts of you.  Startled and perhaps a bit flattered, you take a half-step back, and the noise brings his attention around.  In surprise, he half-turns and half-falls to face you, wide opaque eyes looking out of an alarmingly blue face in shock as his little dick twitches and spurts a string of goo toward your lap.");
				outputText("\n\nThe bizarre sight of your classmate turned sapphire wakes you, and you sit up suddenly.  Blinking twice, you look to your left to discover your anemone, weakly stroking her deflating cock and sighing in satisfaction.  As her eyes catch yours, she freezes up; a wet smell draws your attention downward to where a line of semen decorates your thigh.  The blue girl blushes furiously");
				if (player.cor >= 66) outputText(" and, with a sigh, you grab her head and force it down to the mess, compelling her to lick it up.");
				else outputText(" and neither of you says a word as she backs away slowly on her knees.");
				outputText("  Sighing, you turn over and attempt to return to sleep despite the pervading smell of semen.");
				dynStats("lus", 50 + player.sens / 2, "scale", false);
				doNext(playerMenu);
			}
		}

//Kid-and-kid interaction scenes:
//Cows one-time scene(plays the first time Kidswag > 0, Kidweapon is populated, and PC has 5+ delicious well-Marbled steak children)
//set Kidsitter flag = 1; 'unlocks' repeat babysitting, making Kid A unavailable with a 25% chance during daylight hours
		public function kidABabysitsCows():void
		{
			outputText("\n<b>\"<i>Come on, get out of your little hole and help!</i>\"</b>");
			outputText("\n\nThe sound of a voice being raised in frustration turns your head.  Marble is standing in front of your occupied water barrel with several of your rambunctious children in tow, berating the anemone cornered inside.  You advance a few feet and the blue girl turns toward you beseechingly, but Marble starts talking again before you're close enough to say anything.");

			outputText("\n\n\"<i>...no idea why you're so shy and immature,</i>\" the cow-girl continues, no less insistent for her quieter tone.  \"<i>You're almost two feet taller than any of these kids, so why don't you stop acting like one and behave like an adult?  There's work to be done around here and not enough hands to do it!</i>\"");

			outputText("\n\nMarble takes a horse-stance, awaiting an answer; the anemone considers unhappily for several minutes, then climbs out of the barrel.  Satisfied, Marble turns and herds her children off.  Kid A initially plods along in her wake, but after a moment's consideration, returns to the barrel and grabs her " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + " before reluctantly joining the others in the open pasture.");

			outputText("\n\n\"<i>Alright,</i>\" Marble says, as the anemone draws up to her from the rear.  The larger woman turns to face the blue girl.  \"<i>You're going to watch these kids while I sit here and patch some holes in their... why did you bring that to babysit?!</i>\"");

			outputText("\n\nThe anemone holds her armament closer to her chest and points at the cow-girl's ever-present hammer.");

			outputText("\n\n\"<i>That's different!  I need my weapon if some horde of monsters invades my home and accosts me!</i>\" Marble exclaims.  Kid A pauses in thought, glances at the unruly brood, then nods in careful agreement.");

			outputText("\n\nHuffing, Marble seats herself on a flat stone and removes some torn childrens' clothing from a pouch, along with a crude needle and some sinew.  \"<i>Whatever.  Don't bring it next time.</i>\"  She turns to her assembled rabble as the anemone absorbs the implications of 'next time'.");

			outputText("\n\n\"<i>The blue barbarian here will take care of you while I sew up your overalls.  You behave, now.</i>\"  No sooner is the admonition out than one cow kid grabs the anemone by the hand and pulls her away, good behavior clearly the furthest thing from mind.\n");
			flags[kFLAGS.KID_SITTER] = 1;
		}

//Cow repeat
//triggered when PC selects the Kids option in Marble menu while Kid A is babysitting
		public function repeatCowSitting():void
		{
			outputText("Marble looks up from her work and regards you warmly.  \"<i>I appreciate the offer, [name].  I've already got someone on it, but if you want to go help, I'm sure there's something you could do.</i>\"  She gestures in a direction over your shoulder.");

			outputText("\n\nTurning that way, you walk along her line of sight to discover your brood, who are currently tormenting your anemone.  Kid A is trying to keep one from throwing small rocks at another, while a third is following her, tugging on her hand and constantly begging her to read a tattered book aloud.  Seeing the most obvious way to help out the nearly-mute anemone, you intercept this last kid, taking her hand and steering her away.  Kid A manages a glance at you before her attention is pulled back to the hellion with the stones.");

			outputText("\n\nThe picture book is old and, judging by the little canid hero in the faded illustrations, probably belonged to Whitney once before it was graciously donated to your family.  You go through the tale, mustering suspense and amazement where appropriate; judging by the not-quite-shocked reaction from your daughter, she's heard this story several times already.  Nonetheless, she demands you read it again when you finish, and you do so, doubling the emotion you put into the words; your daughter giggles and shrieks when you pretend to be the storybook monster and flip her upside-down, blowing a raspberry on her tummy under the pretext of taking a bite out of her with your 'gnashing fangs'.");

			outputText("\n\nIt's not long before Marble comes to find you.  \"<i>I'm all done with my chores.  Have you been behaving for [name]?</i>\"");

			outputText("\n\n\"<i>Yes, mummy,</i>\" your daughter answers.  \"<i>I let [him] eat me right up.</i>\"  Laughing, Marble leads the little girl off and you make your way back.  Kid A is dragging herself to her water barrel, looking at the ground in a frazzle.  As you pass by, she makes unblinking eye contact for a long time, then eventually acknowledges you with a curt nod.");

			outputText("\n\n\"<i>...Sweetie.</i>\"");
		}


//Sharks (get the fuck in the boat)
//repeatable, trigger possible when visiting 2+ Izma kids
		public function kidAWatchesSharks():void
		{
			clearOutput();
			outputText("As you look over your shark family playing in the shallow stream, a soft, wet footstep sounds behind you.  Kid A is there when you turn around, holding empty waterskins and looking desperately at the running water.");
			//[(KidXP < 40 or Kidweapon is empty)
			if (kidAXP() < 40 || flags[kFLAGS.ANEMONE_WEAPON_ID] == 0) outputText("\n\nThe sharks notice as well and stand up, baring their teeth in wide, unwelcoming smiles.  Kid A whimpers and shuffles behind you, placing her hands on your back and attempting to push you in front of her.  Your shark-daughters watch in amusement as she tries to maneuver close enough to fill her waterskins while still using you as cover.  Awkwardly, she manages to cap them off and then departs as fast as she can.");

			//(else KidXP < 75 and Kidweapon = White Book or Black Book)
			else if (kidAXP() < 40 && (flags[kFLAGS.ANEMONE_WEAPON_ID] == consumables.B__BOOK.id || flags[kFLAGS.ANEMONE_WEAPON_ID] == consumables.W__BOOK.id)) {
				outputText("\n\nThe anemone watches carefully for a bit, then hangs the skins over her shoulders and opens her book.  Focusing on the few words she can understand, she gestures toward the shark family and ");
				if (flags[kFLAGS.ANEMONE_WEAPON_ID] == consumables.W__BOOK.id) outputText("blinds them with a sudden flash of white light");
				else outputText("turns deep blue as the various shark-girls clap their thighs together and look away from one another in embarrassment");
				outputText(".  Before any of them can react, she dives into the water and fills the waterskins, then hightails it away.");
			}
			//(else KidXP < 75)
			else if (kidAXP() < 75) {
				outputText("\n\nThe sharks look up from their play, baring teeth at the anemone.  She steels herself, then holds her " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + " menacingly in front of her as best she can while she steps into the stream and fills her waterskins.  Occasionally one of the shark-girls will feint at the anemone, who accordingly turns the weapon toward the aggressor until she retreats.  Once the skins are filled, Kid A hangs them over her shoulders and backs away, still facing the sharks with her weapon out.");
			}
			//(else)
			else outputText("\n\nThe anemone doesn't hesitate, but bursts into the middle of the shark-girls like a bomb, shrieking and making huge splashes, scattering them in multiple directions.  She quickly scoops up both skins' worth of water and then runs, giggling giddily with the shark-girls dogging her heels until she's halfway back to camp.");
			doNext(camp.returnToCampUseOneHour);
		}


//goblins at night:
//req PC cocks > 0, Kid A watch on, and Tamani daughters encounter unlocked
//repeatable for now, but semi-rare
		public function goblinNightAnemone():void
		{
			outputText("\n<b>That night...</b>");
			outputText("\nA noisy clump of gabbling green in the distance awakens you and attracts your attention.  As it draws closer to your camp, you can make out tufts of shockingly-colored hair atop it, and then distinct shapes.  The blot on the landscape resolves into a glob of goblins, clearly intent on reaching your camp's perimeter.  Your anemone notices as well, and, attempting to fulfill the terms of her lease, picks up her " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + " and moves to intercept them.  You follow at a good distance and tuck yourself behind some cover, already suspecting the identities of the invaders.");

			outputText("\n\nThe goblins slow up and then stop as the anemone plants herself in their way.  The two sides size one another up for a minute, and then the glob parts to reveal its largest member.");

			outputText("\n\n\"<i>Move it, blue bitch,</i>\" she demands.  \"<i>Tammi said to keep watch for a ");
			if (player.tallness > 48) outputText("tall");
			else outputText("short");
			outputText(", " + player.mf("studly", "gorgeous") + " [race]; told us that [he]'d be able to knock us all up like [he] did her, and a few of the little goblin tramps outside the family have seen one in this camp.  We're going to get our babies.</i>\"  Kid A remains silent, but shakes her head uncertainly, holding her equipment closer to her chest.");

			outputText("\n\nThe goblin looks a little surprised.  \"<i>What do you mean, getting in our way?  I'll warn you once; step aside and let us search that camp for baby batter, or I will make you regret it.</i>\"  She considers the anemone irately, then gestures to her entourage and adds, \"<i>I'd have these cunts ride your sad little willy silly to punish you for being such a slag, but we can't get goblins out of you people - only more blue bitches.</i>\"");

			outputText("\n\nThough you can't see Kid A's expression from behind, she's probably steeling her face into as stern a mask as she's capable of, judging by the way she assumes an aggressive stance - albeit one that's still trying to protect her body as much as possible with " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + ".  As the anemone takes a step forward, the goblins all take a step back, except for the leader.  The two are now staring at each other; one looking up, the other down.");

			outputText("\n\n\"<i>Well, we got a blue badass here,</i>\" the goblin says, raising her hands in a gesture of mock wariness.  Before anyone can react, she reaches behind her back and grabs a phial fastened there, throwing it overhand at the anemone with a grunt.  It crashes into Kid A's shoulder and shatters, dousing one gill and the side of her chest in green liquid.  The blue girl glances down at it as the goblin laughs in triumph.");

			outputText("\n\n\"<i>How do you like that, you... you... you don't feel sick?  Like, at all?</i>\"  The goblin spokeswoman is taken briefly aback as the anemone carefully brushes the glass shards from her skin, apparently none the worse for her poisoning.  Kid A looks up again, resuming her staring match with the goblin, and the glob fans out into a wary half-circle behind her, giving the two a wide berth.");

			outputText("\n\n\"<i>Listen, missy,</i>\" the lone goblin continues, visibly shaken.  \"<i>Get out of the way now or... or I'll... f-fuckin' punch your shit!</i>\"  The goblin draws back an obvious haymaker and, when her opponent doesn't move, lets fly right into Kid A, who takes it in the stomach with what is probably wide-eyed curiosity.  The goblin's fist pulls back and her eyes bug out as the anemone's elastic cuticle rebounds into shape; almost in unison, the glob takes another step backward.  Kid A looks up again and the spokesgoblin stammers as she backpedals.");

			outputText("\n\n\"<i>Don't think this is over, you blue freak!</i>\" she shouts, turning away.  \"<i>We'll be back!  Let's go, you greedy bitches.</i>\"  With much grumbling, the glob forms up around her and begins to move off.  Kid A watches them go for a while, then turns back to you, her face the picture of confusion.  You smile gratefully and head back to bed.\n");
		}
	}
}
