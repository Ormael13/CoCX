/*
 LICENSE
 
This license grants Fenoxo, creator of this game usage of the works of
Dxasmodeus in this product. Dxasmodeus grants Fenoxo and the coders assigned by him to this project permission to alter the text to conform with current and new game functions, only. Dxasmodeus retains exclusive rights to alter or change the core contents of the events and no other developer may alter, change or use the events without permission from dxasmodeus. Fenoxo agrees to include Dxasmodeus' name in the credits with indications to the specific contribution made to the licensor. This license must appear
either at the beginning or the end of the primary file in the source code and cannot be deleted by a third party. This license is also retroactive to include all versions of the game code including events created by dxasmodeus.

DECLARATION OF OWNERSHIP

The following events are the creative works of dxasmodeus and are covered under this license.

Tentacle Plant Event
Giacomo the Travelling Merchant
All item events relating to purchases from Giacomo the Travelling Merchant
worm colony Infestation Events

Tentacle Plant Event and Giacomo sub-events are copyright 2010 by Dxasmodeus.
worm colony Events are copyright 2011 by dxasmodeus.

THIRD PARTY USAGE

As Fenoxo has made his game code open source, this license DOES NOT transfer to a third party developer. The events created by Dxasmodeus may not be used in whole or in part without permission and license from Dxasmodeus. Dxasmodeus reserves the sole and exclusive right to grant third party licenses of copyrighted scenarios.

For further information and license requests, Dxasmodeus may be contacted through private message at the Futanari Palace. http://www.futanaripalace.com/forum.php. */

package classes.Scenes.Explore {
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.MerchantMenu;
import classes.Scenes.Camp.Garden;
import classes.Scenes.Crafting;
import classes.Scenes.Holidays;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class Giacomo extends BaseContent implements TimeAwareInterface {

		public function Giacomo() {
			EventParser.timeAwareClassAdd(this);
		}
		
		private var checkedSuccubi:int;
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			checkedSuccubi = 0; //Make sure we test just once in timeChangeLarge
			if (model.time.hours > 23) {
				if (flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER] > 0) flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER] -= 0.5; //Reduce bad-end for cerulean herms number
			}
			return false;
		}
		
		public function timeChangeLarge():Boolean {
			if (checkedSuccubi++ == 0 && camp.IsSleeping && player.hasStatusEffect(StatusEffects.SuccubiNight) && (player.hasCock() || player.gender == 0)) { //Call secksins!
				if (player.hasStatusEffect(StatusEffects.RepeatSuccubi)) {
                    if (SceneLib.vapula.vapulaSlave() && player.hasCock() && flags[kFLAGS.VAPULA_THREESOMES] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) //VapulaSurprise
                        SceneLib.vapula.vapulaAssistsCeruleanSuccubus();
                    else nightSuccubiRepeat(); //Normal night succubi shit
				}
				else {
					nightSuccubiFirstTime();
					player.createStatusEffect(StatusEffects.RepeatSuccubi, 0, 0, 0, 0);
				}
				//Lower count if multiples stacked up.
				if (player.statusEffectv1(StatusEffects.SuccubiNight) > 1)
					player.addStatusValue(StatusEffects.SuccubiNight, 1, -1);
				else player.removeStatusEffect(StatusEffects.SuccubiNight);
				return true;
			}
			return false;
		}
		//End of Interface Implementation

		public function giacomoEncounter():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (flags[kFLAGS.GIACOMO_MET] == 0) {
				firstEncounter();
			}
			else if (!player.hasStatusEffect(StatusEffects.WormOffer) && player.hasStatusEffect(StatusEffects.Infested)) { //If infested && no worm offer yet
				outputText("Upon walking up to Giacomo's wagon, he turns to look at you and cocks an eyebrow in curiosity and mild amusement.\n\n");
				outputText("\"<i>Been playing with creatures best left alone, I see</i>,\" he chuckles.  \"<i>Infestations of any kind are annoying, yet your plight is quite challenging given the magnitude of corrupt creatures around here.  It is not the first time I have seen one infested with THOSE worms.</i>\"\n\n");
				outputText("You ask how he knows of your change and the merchant giggles heartily.\n\n");
				outputText("\"<i>Do not look at me as if I am a mystic,</i>\" Giacomo heckles lightly.  \"<i>Your crotch is squirming.</i>\"\n\n");
				outputText("Looking down, you realize how right he is and attempt to cover yourself in embarrassment.\n\n");
				outputText("\"<i>Fear not!</i>\" the purveyor jingles.  \"<i>I have something that will cure you of those little bastards.  Of course, there is also a chance that it will purge your system in general.  This potion is not cheap.  I will trade it for 175 gems.</i>\"\n\n");
				player.createStatusEffect(StatusEffects.WormOffer, 0, 0, 0, 0);
				if (player.gems < 175) { //Broke as a joke
					outputText("You realize you don't have enough gems for such a pricey potion, but perhaps there is something else in his inventory you can buy.");
				}
				else { //Can afford
					outputText("Do you purchase his cure?");
					//Remove/No
					doYesNo(wormRemoval, giacomoEncounter);
					return;
				}
			}
			else { //Normal greeting
				outputText("You spy the merchant Giacomo in the distance.  He makes a beeline for you, setting up his shop in moments.  ");
				outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you. What are you interested in?");
			}
			menu();
			addButton(0, "Potions", potionMenu);
			addButton(1, "Books", bookMenu);
			addButton(2, "Erotica", eroticaMenu);
			addButton(3, "Misc", miscMenu);
			addButton(4, "Trade", tradeMenu);
			if (player.hasStatusEffect(StatusEffects.WormOffer) && player.hasStatusEffect(StatusEffects.Infested)) addButton(5, "Worm Cure", wormRemovalOffer);
			addButton(14, "Leave", explorer.done);
			statScreenRefresh();
		}
		
		private function firstEncounter():void {
			outputText("As you travel, you see another person on the road.  He is tethered to a small cart that is overloaded with a hodgepodge of items.  He is dressed in a very garish manner, having a broad, multicolored hat, brocaded coat and large, striped pantaloons.  His appearance is almost comical and contrasts with his severe and hawkish facial features.  The man sees you, smiles and stops his cart.\n");
			outputText("\"<i>Greetings, traveler! My name is Giacomo.  I am, as you can see, a humble purveyor of items, curios and other accoutrements.  While I am not in a position to show you my full wares as my shop is packed on this push-cart, I do offer some small trinkets for travelers I meet.</i>\"\n\n");
			outputText("The merchant looks at you sharply and cracks a wide, toothy smile you find... unnerving.  The merchant twists his way around to access a sack he has around his back.  After a moment, he swings the sack from his back to have better access to its contents.  Inquisitively, the merchant turns back to you.\n");
			outputText("\"<i>So stranger, be you interested in some drafts to aid you in your travels, some quick pamphlets to warn you of dangers on journeys or...</i>\"\n\n");
			outputText("Giacomo pauses and turns his head in both directions in a mocking gesture of paranoid observation.  His little bit of theatrics does make you wonder what he is about to offer.\n");
			outputText("\"<i>...maybe you would be interested in some items that enhance the pleasures of the flesh?  Hmmm?</i>\"\n\n");
			outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you.  What are you interested in?");
			flags[kFLAGS.GIACOMO_MET] = 1;
		}
		
		private function tradeMenu():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			menu();
			var merchantMenu:MerchantMenu = new MerchantMenu();
			merchantMenu.playerCanSell = true;
			merchantMenu.playerSellFactor = merchantMenu.greedCheck() ? 0.8 : 0.4;
			merchantMenu.addItem(consumables.MANUP_B, 15);
			merchantMenu.addItem(consumables.VITAL_T, 15);
			merchantMenu.addItem(consumables.SMART_T, 15);
			merchantMenu.addItem(consumables.CERUL_P, 75);
			merchantMenu.addLineBreak();
			merchantMenu.addItem(consumables.SAPILL_);
			merchantMenu.addItem(consumables.MAPILL_).disableIf(player.level < 24, "Req. lvl 24+", true);
			merchantMenu.addItem(consumables.BAPILL_).disableIf(player.level < 42, "Req. lvl 42+", true);
			merchantMenu.addItem(useables.CONDOM, 10);
			merchantMenu.addLineBreak();
			merchantMenu.addItem(consumables.W__BOOK, 100);
			merchantMenu.addItem(consumables.G__BOOK, 500);
			merchantMenu.addItem(consumables.B__BOOK, 100);
			merchantMenu.addItem(consumables.RMANUSC, 125);
			merchantMenu.addItem(weaponsrange.E_TOME_, 1000);
			merchantMenu.addItem(consumables.CRIMS_J, 125);
			merchantMenu.show(giacomoEncounter);
		}
	
		private function potionMenu():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Which potion or tincture will you examine?");
			menu();
			addButton(0, "ManUp B.", pitchManUpBeer);
			addButton(1, "Vitality T.", pitchVitailtyTincture);
			addButton(2, "Scholars T.", pitchScholarsTea);
			if (player.gender != 2 || player.gender != 0) addButton(3, "Cerulean P.", pitchCeruleanPotion);
			addButton(11, consumables.SAPILL_.shortName, itemBuy2, consumables.SAPILL_);
			if (player.level >= 24) addButton(12, consumables.MAPILL_.shortName, itemBuy2, consumables.MAPILL_);
			else addButtonDisabled(12, "???", "Req. lvl 24+");
			if (player.level >= 42) addButton(13, consumables.BAPILL_.shortName, itemBuy2, consumables.BAPILL_);
			else addButtonDisabled(13, "???", "Req. lvl 42+");
			addButton(14, "Back", giacomoEncounter);
			statScreenRefresh();
		}
		
		private function bookMenu():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Which book are you interested in perusing?");
			menu();
			addButton(0, "Dangerous Plants", pitchDangerousPlantsBook);
			addButton(1, "Traveler's Guide", pitchTravellersGuide);
			addButton(2, "Hentai Comic", pitchHentaiComic);
			if (flags[kFLAGS.COTTON_UNUSUAL_YOGA_BOOK_TRACKER] > 0) addButton(3, "Yoga Guide", pitchYogaGuide);
			addButton(4, "E. Tome", pitchElementalistsTome).hint("Elementalist’s Tome");
			addButton(5, "White Book", pitchWhiteBook);
			addButton(6, "Black Book", pitchBlackBook);
			addButton(7, "Grey Book", pitchGreyBook);
			addButton(8, "Red Manuscript", pitchRedManuscript);
			addButton(9, "Crimson Jade", pitchCrimsonJade);
			addButton(10, "TelAdreMagI2", pitchTelAdreMagazineIssue2).hint("Tel'Adre Magazine Issue 2");
			addButton(11, "TelAdreMagI5", pitchTelAdreMagazineIssue5).hint("Tel'Adre Magazine Issue 5");
			addButton(12, "TelAdreMagI8", pitchTelAdreMagazineIssue8).hint("Tel'Adre Magazine Issue 8");
			addButton(13, "TelAdreMagI10", pitchTelAdreMagazineIssue10).hint("Tel'Adre Magazine Issue 10");
			addButton(14, "Back", giacomoEncounter);
			statScreenRefresh();
		}
		
		private function eroticaMenu():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you.  What are you interested in?");
			menu();
			addButton(0, "Dildo", pitchDildo);
			if (player.hasVagina()) addButton(1, "Stim-Belt", pitchSelfStimulationBelt);
			if (player.hasVagina()) addButton(2, "AN Stim-Belt", pitchAllNaturalSelfStimulationBelt);
			if (player.hasCock()) addButton(3, "Onahole", pitchOnahole);
			if (player.hasCock()) addButton(4, "D Onahole", pitchDeluxeOnahole);
			if (player.hasCock() && player.hasVagina()) addButton(5, "Dual Belt", pitchDualStimulationBelt);
			if (player.hasCock() && player.hasVagina()) addButton(6, "AN Onahole", pitchAllNaturalOnahole);
			addButton(7, "Condom", pitchCondom);
			addButton(10, "S.C.N.", pitchSilverCrossNecklace).hint("Silver cross necklace");
			addButton(14, "Back", giacomoEncounter);
			statScreenRefresh();
		}
		
		private function miscMenu():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			menu();
			if (Garden.IngrediantBagSlot01Cap == 0) addButton(6, "Herb Bag (LLowG)", pitchLLHerbsBag).hint("Herbs Bag (Lowest Grade)");
			if (Garden.IngrediantBagSlot07Cap == 0) {
				if (player.farmingLevel >= 5) addButton(7, "Herb Bag (LowG)", pitchLHerbsBag).hint("Herbs Bag (Low Grade)");
				else addButtonDisabled(7, "Herb Bag (LowG)", "Herbs Bag (Low Grade) Req. lvl 5 in Farming.");
			}
			if (Garden.PotionsBagSlot01Cap == 0) addButton(8, "Pot Bag (LowG)", pitchPotionsBag).hint("Potion Bag (Lowest Grade)");
			if (player.hasKeyItem("Tarnished Ore Bag (Lowest grade)") >= 0) addButton(10, "Ore Bag (LowG)", pitchOreBag).hint("Ore Bag (Lowest Grade)");
			if (Holidays.nieveHoliday()) {
				if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 0) addButton(11, "Mysterious Seed", pitchMysteriousSeed);
				if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 5) addButton(12, "Decorations", pitchDecorations);
			}
			addButton(13, "Torch", pitchTorch);
			addButton(14, "Back", giacomoEncounter);
			statScreenRefresh();
		}
		
		private function pitchManUpBeer():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up the item and says, \"<i>Ahh so you're interested into this beverage eh? It is rumored to help weight lifters grow bigger muscles. Only a handful of gems!  Yes " + player.mf("sir", "madam") + ", this is liquid gold for pilgrim and adventurer alike.  Interested?  It is <b>15 gems</b></i>.\"  ");
			doYesNo(buyManUpBeer, potionMenu);
		}
		
		private function buyManUpBeer():void {
			spriteSelect(SpriteDb.s_giacomo);
			if (player.gems < 15) {
				clearOutput();
				outputText("\n\nGiacomo sighs, indicating you need " + String(15 - player.gems) + " more gems to purchase this item.");
				doNext(potionMenu);
			}
			else {
				player.gems -= 15;
				inventory.takeItem(consumables.MANUP_B, potionMenu);
			}
		}
		
		private function pitchVitailtyTincture():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up the item and says, \"<i>Ah, yes!  The quintessential elixir for all travelers, this little bottle of distilled livelihood will aid you in restoring your energy on your journey and, should you be hurt or injured, will aid the body's ability to heal itself.  Yes " + player.mf("sir", "madam") + ", this is liquid gold for pilgrim and adventurer alike.  Interested?  It is <b>15 gems</b></i>.\"  ");
			doYesNo(buyVitailtyTincture, potionMenu);
		}
		
		private function buyVitailtyTincture():void {
			spriteSelect(SpriteDb.s_giacomo);
			if (player.gems < 15) {
				clearOutput();
				outputText("\n\nGiacomo sighs, indicating you need " + String(15 - player.gems) + " more gems to purchase this item.");
				doNext(potionMenu);
			}
			else {
				player.gems -= 15;
				inventory.takeItem(consumables.VITAL_T, potionMenu);
			}
		}
		
		private function pitchScholarsTea():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up a pouch of dried, fragrant leaves and begins his spiel, \"<i>Have you ever wondered how scholars and other smart folk keep up such a mental effort for so long?  They make a tea out of this fine mixture of quality plants and herbs.  Nothing but the best, this mysterious mixture of herbs in its Orange Pekoe base makes anyone, short of a lummox, as brainy as the finest minds of the land.  All you do is steep the leaves in some water and drink up!  Hot or cold, straight or sweetened with honey, your mind will run circles around itself once it has this for fuel.  Buy it now and I will throw in the strainer for free!  Interested?  Only <b>15 gems</b>!</i>\"  ");
			doYesNo(buyScholarsTea, potionMenu);
		}

		private function buyScholarsTea():void {
			spriteSelect(SpriteDb.s_giacomo);
			if (player.gems < 15) {
				clearOutput();
				outputText("\n\nGiacomo sighs, indicating you need " + String(15 - player.gems) + " more gems to purchase this item.  ");
				doNext(potionMenu);
			}
			else {
				player.gems -= 15;
				inventory.takeItem(consumables.SMART_T, potionMenu);
			}
		}
		
		private function pitchCeruleanPotion():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo makes his comical over-the-shoulder search and holds up a sky-blue bottle.  He grins widely as he begins his pitch, \"<i>My friend, you truly have a discerning eye.  Even the most successful of men seek to attract more women for pleasure and status.  This, my friend, will attract the most discerning and aroused of women.  Women attracted by this fine unction will NEVER say no.  I GUARANTEE that she will want pleasure every time you demand pleasure!  A bit of a caution to you, brother.  Some say this works TOO well.  If you aren't man enough to handle the women this urn draws to you, you'd best say so now and I will offer something more to your liking.  However, if you have the heart for it, I can sell you this little gem for <b>75 gems</b></i>!\"  ");
			doYesNo(buyCeruleanPotion, potionMenu);
		}
		
		private function buyCeruleanPotion():void {
			spriteSelect(SpriteDb.s_giacomo);
			if (player.gems < 75) {
				clearOutput();
				outputText("\n\nGiacomo sighs, indicating you need " + String(75 - player.gems) + " more gems to purchase this item.");
				doNext(potionMenu);
			}
			else {
				inventory.takeItem(consumables.CERUL_P, potionMenu);
				player.gems -= 75;
			}
		}
		
		private function itemBuy2(itype:ItemType):void {
			clearOutput();
			outputText("\"<i>Interested? It’s yours for only " + itype.value + " gems.</i>\"");
			if(player.gems < itype.value) {
				outputText("\n\nYou count out your gems and realize it's beyond your price range.");
				doNext(potionMenu);
				return;
			}
			else outputText("\n\nDo you buy it?\n\n");
			doYesNo(curry(debitWeapon2,itype), potionMenu);
		}
		
		private function debitWeapon2(itype:ItemType):void {
			player.gems -= itype.value;
			statScreenRefresh();
			inventory.takeItem(itype, potionMenu);
		}
		
		public function pitchCondom():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up the packet and says, \"<i>Ah, yes! This is a condom. Just slip it on any cocks and have it penetrate any holes. It's guaranteed to prevent the spread of STDs and it will help to prevent pregnancy. I must warn you that it does not completely prevent pregnancy. Rarely, it will fail. However, it will work most of the time. So, <b>ten gems</b>. What do you say?</i>\"");
			doYesNo(buyCondom, eroticaMenu);
		}
		
		public function buyCondom():void {
			spriteSelect(SpriteDb.s_giacomo);
			if (player.gems < 10)
			{
				clearOutput();
				outputText("\n\nGiacomo sighs, indicating you need " + String(10 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
			}
			else
			{
				player.gems -= 10;
				inventory.takeItem(useables.CONDOM, eroticaMenu);
			}
		}
		
		public function pitchSilverCrossNecklace():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("The trader smiles wide as you look at the strange jewelry on his table.\n\n");
			outputText("\"<i>Oh this? This necklace is magical. Tell me friend, do you believe in eternal love? This necklace can lead you to it, all for the modest sum of 400 gems.</i>\"\n\n");
			outputText("This sounds AND looks like a scam but do you buy it anyway?");
			doYesNo(buySilverCrossNecklace, eroticaMenu);
		}
		
		public function buySilverCrossNecklace():void {
			spriteSelect(SpriteDb.s_giacomo);
			if (player.gems < 400)
			{
				clearOutput();
				outputText("\n\nGiacomo sighs, indicating you need " + String(400 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
			}
			else
			{
				player.gems -= 400;
				inventory.takeItem(necklaces.SILCNEC, eroticaMenu);
			}
		}
		
		private function pitchDangerousPlantsBook():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Dangerous Plants") >= 0) {
				outputText("<b>You already own the book 'Dangerous Plants'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Giacomo proudly holds up a small text.  The cover is plain and unadorned with artwork.  \"<i>According to the scholars,</i>\" Giacomo begins, \"<i>knowledge is power.  It is one of the few things that scholars say that I agree with.  You cannot survive in today's world without knowing something of it.  Beasts and men are not your only problems.  This book specializes in the dangerous plants of the realm.  There exists flora the likes of which will chew you up and spit you out faster than any pack of wolves or gang of thieves.  For the small price of 10 gems, you can benefit from this fine book on the nastiest blossoms in existence.  Care to broaden your learning?</i>\"");
			doYesNo(buyDangerousPlantsBook, bookMenu);
		}
		
		private function buyDangerousPlantsBook():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 10) {
				outputText("Giacomo sighs, indicating you need " + String(10 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this book.  Obviously written by well-informed, but women-starved men, the narrative drearily states the various types of poisonous and carnivorous plants in the world.  One entry that really grabs you is the chapter on 'Violation Plants'.  The chapter drones on about an entire classification of specially bred plants whose purpose is to torture or feed off a human being without permanently injuring and killing them.  Most of these plants attempt to try breeding with humans and are insensitive to the intricacies of human reproduction to be of any value, save giving the person no end of hell.  These plants range from massive shambling horrors to small plant-animal hybrids that attach themselves to people.  As you finish the book, you cannot help but shiver at the many unnatural types of plants out there and wonder what sick bastard created such monstrosities. ");
				doNext(bookMenu);
				player.gems -= 10;
				player.createKeyItem("Dangerous Plants", 0, 0, 0, 0);
			}
		}
		
		private function pitchTravellersGuide():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Traveler's Guide") >= 0) {
				outputText("<b>You already own the book 'Traveler's Guide'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Giacomo holds up a humble pamphlet.  \"<i>While you may not find value in this as a seasoned traveler,</i>\", Giacomo opens, \"<i>you never know what you may learn from this handy, dandy information packet!  Geared to the novice, this piece of work emphasizes the necessary items and some good rules of thumb for going out into the world.  You may not need it, but you may know someone who does.  Why waste your time when the answers could be in this handy pamphlet!  I will offer the super-cheap price of 1 gem!</i>\"");
			doYesNo(buyTravellersGuide, bookMenu);
		}
		
		private function buyTravellersGuide():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 1) {
				outputText("\n\nGiacomo sighs, indicating you need 1 gem to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("The crazy merchant said you might not need this and he was right.  Written at a simple level, this was obviously intended for a city-dweller who never left the confines of their walls.  Littered with childish illustrations and silly phrases, the book is informative in the sense that it does tell a person what they need and what to do, but naively downplays the dangers of the forest and from bandits.  Were it not so cheap, you would be pissed at the merchant.  However, he is right in the fact that giving this to some idiot ignorant of the dangers of the road saves time from having to answer a bunch of stupid questions.");
				doNext(bookMenu);
				player.gems -= 1;
				player.createKeyItem("Traveler's Guide", 0, 0, 0, 0);
			}
		}
		
		private function pitchHentaiComic():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Hentai Comic") >= 0)
			{
				outputText("<b>You already own a Hentai Comic!</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Giacomo takes out a colorfully written magazine from his bag.  The cover contains well-drawn, overly-endowed women in sexual poses.  \"<i>Perhaps your taste in reading is a bit more primal, my good " + player.mfn("man", "lady", "...err, whatever you are") + "</i>,\" says Giacomo.  \"<i>Taken from the lands far to the east, this is a tawdry tale of a group of ladies seeking out endless pleasures.  With a half a dozen pictures on every page to illustrate their peccadilloes, you will have your passions inflamed and wish to join these fantasy vixens in their adventures!  Collectable and in high demand, and even if this is not to your tastes, you can easily turn a profit on it!  Care to adventure into the realm of fantasy?  It's only 10 gems and I am doing YOU a favor for such a price.</i>\"");
			doYesNo(buyHentaiComic, bookMenu);
		}
		
		private function buyHentaiComic():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 10) {
				outputText("\n\nGiacomo sighs, indicating you need " + String(10 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You peruse the erotic book.  The story is one of a group of sisters who are all impossibly heavy-chested and equally horny getting into constant misadventures trying to satisfy their lust.  While the comic was entertaining and erotic to the highest degree, you cannot help but laugh at how over-the-top the story and all of the characters are.  Were the world as it was in the book, nothing would get done as humanity would be fucking like jackrabbits in heat for the rest of their lives.  While certainly a tempting proposition, everyone gets worn out sometime.  You place the book in your sack, well entertained and with a head filled with wilder perversions than what you woke up with this morning.");
				doNext(bookMenu);
				player.gems -= 10;
				dynStats("lib", 2, "lus", 20);
				player.createKeyItem("Hentai Comic", 0, 0, 0, 0);
			}
		}
		
		private function pitchYogaGuide():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up the book with a small degree of reverence.  The cover is leather, with the lettering stitched in by hand.  \"<i>This, my friend,</i>\" begins Giacomo, \"<i>is a strange book indeed.  I traded for it in the east, where they practice a form of exercise known as yoga.  This volume in particular deals with those of, shall we say, unusual body shapes.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your horizons?</i>\"");
			doYesNo(buyYogaGuide, bookMenu);
		}
		
		private function buyYogaGuide():void {
			clearOutput();
			if (player.hasKeyItem("Yoga Guide") >= 0) {
				outputText("<b>You already own a yoga guide!</b>");
			}
			else if (player.gems < 100) {
				outputText("You cannot afford a yoga guide!");
			}
			else {
				outputText("You exchange 100 gems for the tome.  Now you can finally enjoy a workout with Cotton!");
				player.createKeyItem("Yoga Guide", 0, 0, 0, 0);
				player.gems -= 100;
			}
			doNext(bookMenu);
		}
		
		private function pitchTelAdreMagazineIssue2():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Tel'Adre Magazine Issue 2") >= 0) {
				outputText("<b>You already own the magazine 'Tel'Adre Magazine Issue 2'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Giacomo holds up the magazine with a small degree of reverence.  \"<i>This, my friend,</i>\" begins Giacomo, \"<i>is a 2nd issue of Tel'Adre Magazine.  It dive into matters of distilling moonshine and mixing dyes... I mean, refining alchemical ingredients and medicine-crafting.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your alchemic horizons?</i>\"");
			doYesNo(buyTelAdreMagazineIssue2, bookMenu);
		}
		
		private function buyTelAdreMagazineIssue2():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Giacomo sighs, indicating you need " + String(100 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this magazine.  Obviously written by well-informed, would help you in producing stinky goo... and sometimes, alchemical products. ");
				doNext(bookMenu);
				player.gems -= 100;
				player.createKeyItem("Tel'Adre Magazine Issue 2", 0, 0, 0, 0);
			}
		}
		
		private function pitchTelAdreMagazineIssue5():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Tel'Adre Magazine Issue 5") >= 0) {
				outputText("<b>You already own the magazine 'Tel'Adre Magazine Issue 5'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Giacomo holds up the magazine with a small degree of reverence.  \"<i>This, my friend,</i>\" begins Giacomo, \"<i>is a 5th issue of Tel'Adre Magazine.  It dive into matters of so called fifth finger or green thumb.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your herbalism horizons?</i>\"");
			doYesNo(buyTelAdreMagazineIssue5, bookMenu);
		}
		
		private function buyTelAdreMagazineIssue5():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Giacomo sighs, indicating you need " + String(100 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this magazine.  Obviously written by well-informed, would help you in herb cultivation. ");
				doNext(bookMenu);
				player.gems -= 100;
				player.createKeyItem("Tel'Adre Magazine Issue 5", 0, 0, 0, 0);
			}
		}
		
		private function pitchTelAdreMagazineIssue8():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Tel'Adre Magazine Issue 8") >= 0) {
				outputText("<b>You already own the magazine 'Tel'Adre Magazine Issue 8'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Giacomo holds up the magazine with a small degree of reverence.  \"<i>This, my friend,</i>\" begins Giacomo, \"<i>is a 8th issue of Tel'Adre Magazine.  It dive into matters of so benefits of having all ten fingers... err well sometimes just eight to hold your farming tools.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your farming horizons?</i>\"");
			doYesNo(buyTelAdreMagazineIssue8, bookMenu);
		}
		
		private function buyTelAdreMagazineIssue8():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Giacomo sighs, indicating you need " + String(100 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this magazine.  Obviously written by well-informed, would help you in.... not cutting any of your fingers when you try to use farming tools. ");
				doNext(bookMenu);
				player.gems -= 100;
				player.createKeyItem("Tel'Adre Magazine Issue 8", 0, 0, 0, 0);
			}
		}
		
		private function pitchTelAdreMagazineIssue10():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Tel'Adre Magazine Issue 10") >= 0) {
				outputText("<b>You already own the magazine 'Tel'Adre Magazine Issue 10'.</b>");
				doNext(bookMenu);
				return;
			}
			outputText("Giacomo holds up the magazine with a small degree of reverence.  \"<i>This, my friend,</i>\" begins Giacomo, \"<i>is a 10th issue of Tel'Adre Magazine.  It dive into matters of so benefits of having all ten fingers... like to hold your pickaxe.  Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat.  Care to broaden your mining horizons?</i>\"");
			doYesNo(buyTelAdreMagazineIssue10, bookMenu);
		}
		
		private function buyTelAdreMagazineIssue10():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Giacomo sighs, indicating you need " + String(100 - player.gems) + " more gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("You consider yourself fortunate to be quite literate in this day and age.  It certainly comes in handy with this magazine.  Obviously written by well-informed, would help you in diggin the hole.... err mining to your heart content. ");
				doNext(bookMenu);
				player.gems -= 100;
				player.createKeyItem("Tel'Adre Magazine Issue 10", 0, 0, 0, 0);
			}
		}
		
		private function pitchLLHerbsBag():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("\"<i>I see you keep herbs between your other stuff. Why not you buy this one bag that is much better to keep them in one place? Only 300 gems and i assure you not gonna find such good offer anywhere else...</i>\"");
			doYesNo(buyLLHerbsBag, miscMenu);
		}
		
		private function buyLLHerbsBag():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 300) {
				outputText("\n\nGiacomo sighs, indicating you need 300 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("\n\nYou decided to buy the bag. <b>You acquired Herbs Bag (Lowest grade).</b>");
				player.gems -= 300;
				player.createKeyItem("Herbs Bag (Lowest grade)", 0, 0, 0, 0);
				Garden.IngrediantBagSlot01Cap = 5;
				Garden.IngrediantBagSlot02Cap = 5;
				Garden.IngrediantBagSlot03Cap = 5;
				Garden.IngrediantBagSlot04Cap = 5;
				Garden.IngrediantBagSlot05Cap = 5;
				Garden.IngrediantBagSlot06Cap = 5;
				doNext(miscMenu);
			}
		}
		
		private function pitchLHerbsBag():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("\"<i>I see you keep herbs between your other stuff. Why not you buy this one bag that is much better then the one you already have to keep them in one place? Only 500 gems and i assure you not gonna find such good offer anywhere else...</i>\"");
			doYesNo(buyLHerbsBag, miscMenu);
		}
		
		private function buyLHerbsBag():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 500) {
				outputText("\n\nGiacomo sighs, indicating you need 400 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("\n\nYou decided to buy the bag. <b>You acquired Herbs Bag (Low grade).</b>");
				player.gems -= 500;
				player.removeKeyItem("Herbs Bag (Lowest grade)");
				player.createKeyItem("Herbs Bag (Low grade)", 0, 0, 0, 0);
				Garden.IngrediantBagSlot01Cap = 10;
				Garden.IngrediantBagSlot02Cap = 10;
				Garden.IngrediantBagSlot03Cap = 10;
				Garden.IngrediantBagSlot04Cap = 10;
				Garden.IngrediantBagSlot05Cap = 10;
				Garden.IngrediantBagSlot06Cap = 10;
				Garden.IngrediantBagSlot07Cap = 10;
				Garden.IngrediantBagSlot08Cap = 10;
				doNext(miscMenu);
			}
		}
		
		private function pitchPotionsBag():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("\"<i>I see you keep potions between your other stuff. Why not you buy this one bag that is much better to organize them? Only 300 gems and i assure you not gonna find such good offer anywhere else...</i>\"");
			doYesNo(buyPotionsBag, miscMenu);
		}
		
		private function buyPotionsBag():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 300) {
				outputText("\n\nGiacomo sighs, indicating you need 300 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("\n\nYou decided to buy the bag. <b>You acquired Potion Bag (Lowest grade).</b>");
				player.gems -= 300;
				player.createKeyItem("Potion Bag (Lowest grade)", 0, 0, 0, 0);
				Garden.PotionsBagSlot01Cap = 5;
				Garden.PotionsBagSlot02Cap = 5;
				Garden.PotionsBagSlot03Cap = 5;
				Garden.PotionsBagSlot04Cap = 5;
				Garden.PotionsBagSlot05Cap = 5;
				Garden.PotionsBagSlot06Cap = 5;
				doNext(miscMenu);
			}
		}
		
		private function pitchOreBag():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("\"<i>I see you have some pretty tarnished bag to store ores. Why not you buy this new one bag that is much better even if it's not better grade than the one you have now? Only 600 gems and i even gonna take your current bag. I assure you not gonna find such good offer anywhere else...</i>\"");
			doYesNo(buyOreBag, miscMenu);
		}
		
		private function buyOreBag():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 600) {
				outputText("\n\nGiacomo sighs, indicating you need 600 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("\n\nYou decided to buy the bag. It looking much better the one you had and checking inside it appears to have bit more space. As part of the deal you hand over current one to Giacomo. <b>You acquired Ore Bag (Lowest grade).</b>");
				player.gems -= 600;
				player.removeKeyItem("Tarnished Ore Bag (Lowest grade)");
				player.createKeyItem("Ore Bag (Lowest grade)", 0, 0, 0, 0);
				Crafting.BagSlot01Cap = 10;
				Crafting.BagSlot02Cap = 10;
				Crafting.BagSlot03Cap = 10;
				Crafting.BagSlot04Cap = 10;
				Crafting.BagSlot06Cap = 10;
				Crafting.BagSlot07Cap = 10;
				doNext(miscMenu);
			}
		}
		
		private function pitchMysteriousSeed():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("\"<i>Ah, that. That's just a seed I acquired from someone on my travels. They said planting it will result in something truly extraordinary to happen but I haven't really had the time to get around to it. Perhaps it'll be better suited for someone with more time on their hands? Maybe for let's say… 30 gems?</i>\"");
			doYesNo(buyMysteriousSeed, miscMenu);
		}
		
		private function buyMysteriousSeed():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 30) {
				outputText("\n\nGiacomo sighs, indicating you need 30 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("\n\nYou decided to buy the seed. It’s actually fairly large and light brown in color. Other than that it just looks like an ordinary seed. Maybe you'll plant it later to see what it'll grow into. <b>You acquired the Mysterious Seed.</b>");
				player.gems -= 30;
				flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 1;
				player.createKeyItem("Mysterious Seed", 0, 0, 0, 0);
				doNext(miscMenu);
			}
		}
		
		private function pitchDecorations():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("\"<i>Ah, yes! I make sure to keep these in stock for the season! Though not many people around here really buy these anymore… I can sell these to you for a decent price. Let's say about 100 gems?</i>\"");
			doYesNo(buyDecorations, miscMenu);
		}
		
		private function buyDecorations():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("\n\nGiacomo sighs, indicating you need 100 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("\n\nYou decided to buy the seed. It’s actually fairly large and light brown in color. Other than that it just looks like an ordinary seed. Maybe you'll plant it later to see what it'll grow intoYou buy the package filled with holiday decorations. Inside are shiny, colorful ornaments, garland, and lights. You can't help but think this will be perfect for decorating the tree back at camp. <b>You acquired Holiday Decorations.</b>");
				player.gems -= 100;
				flags[kFLAGS.CHRISTMAS_TREE_LEVEL] = 7;
				player.createKeyItem("Decorations", 0, 0, 0, 0);
				doNext(miscMenu);
			}
		}
		
		private function pitchTorch():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Torch") > 0) {
				outputText("<b>Trying to cope with that pyromania? You already have a torch!</b>");
				doNext(miscMenu);
				return;
			}
			outputText("Giacomo shrugs.  \"<i>You may think this item to be unnecessary but it’s in the kit of any smart adventurers wishing to explore nowadays, who knows it might even save your life. Only 100 gems, I recommend it, really.</i>\"");
			doYesNo(buyTorch, miscMenu);
		}
		
		private function buyTorch():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("\n\nGiacomo sighs, indicating you need 100 gems to purchase this item.");
				doNext(miscMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over hundred gems and in exchange gives you a torch.");
				player.gems -= 100;
				player.createKeyItem("Torch", 0, 0, 0, 0);
				doNext(miscMenu);
			}
		}
		
		private function pitchWhiteBook():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up a white book.  \"<i>While you may not find value in this as a simple book,</i>\", Giacomo opens, \"<i>you never know what you may learn from it!  Maybe even some useful spell!  I will offer the super-cheap price of 100 gems!</i>\"");
			doYesNo(buyWhiteBook, bookMenu);
		}
		
		private function buyWhiteBook():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Giacomo sighs, indicating you need 100 gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over a hundred gems and in exchange gives you a white book.");
				player.gems -= 100;
				inventory.takeItem(consumables.W__BOOK, bookMenu);
			}
		}
		
		private function pitchGreyBook():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up a grey book.  \"<i>While you may not find value in this as a simple book,</i>\", Giacomo opens, \"<i>you never know what you may learn from it!  Maybe even some useful spell!  I will offer the super-cheap price of 500 gems!</i>\"");
			doYesNo(buyGreyBook, bookMenu);
		}
		
		private function buyGreyBook():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 500) {
				outputText("Giacomo sighs, indicating you need 500 gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over five hundred gems and in exchange gives you a grey book.");
				player.gems -= 500;
				inventory.takeItem(consumables.G__BOOK, bookMenu);
			}
		}
		
		private function pitchBlackBook():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up a black book.  \"<i>While you may not find value in this as a simple book,</i>\", Giacomo opens, \"<i>you never know what you may learn from it!  Maybe even some useful spell!  I will offer the super-cheap price of 100 gems!</i>\"");
			doYesNo(buyBlackBook, bookMenu);
		}
		
		private function buyBlackBook():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 100) {
				outputText("Giacomo sighs, indicating you need 100 gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over a hundred gems and in exchange gives you a black book.");
				player.gems -= 100;
				inventory.takeItem(consumables.B__BOOK, bookMenu);
			}
		}
		
		private function pitchRedManuscript():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up a red manuscript.  \"<i>While you may not find value in this as a simple manuscript,</i>\", Giacomo opens, \"<i>you never know what you may learn from it!  Maybe even some useful spell!  I will offer the super-cheap price of 125 gems!</i>\"");
			doYesNo(buyRedManuscript, bookMenu);
		}
		
		private function buyRedManuscript():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 125) {
				outputText("Giacomo sighs, indicating you need 125 gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over a one hundred twenty five gems and in exchange gives you a red manuscript.");
				player.gems -= 125;
				inventory.takeItem(consumables.RMANUSC, bookMenu);
			}
		}
		
		private function pitchCrimsonJade():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up a crimson jade.  \"<i>While you may not find value in this as a simple jade,</i>\", Giacomo waves, \"<i>you never know what you may learn from it!  Maybe even some useful soulskill!  I will offer the super-cheap price of 125 gems!</i>\"");
			doYesNo(buyCrimsonJade, bookMenu);
		}
		
		private function buyCrimsonJade():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 125) {
				outputText("Giacomo sighs, indicating you need 125 gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over a one hundred twenty five gems and in exchange gives you a Crimson Jade.");
				player.gems -= 125;
				inventory.takeItem(consumables.CRIMS_J, bookMenu);
			}
		}
		
		private function pitchElementalistsTome():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Giacomo holds up an Elementalist’s Tome.  \"<i>While you may not find value in this as a simple tome,</i>\", Giacomo opens, \"<i>you never know what you may learn from it!  I will offer the super-cheap price of 1,000 gems!</i>\"");
			doYesNo(buyElementalistsTome, bookMenu);
		}
		
		private function buyElementalistsTome():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 1000) {
				outputText("Giacomo sighs, indicating you need 1,000 gems to purchase this item.");
				doNext(bookMenu);
			}
			else {
				outputText("The crazy merchant nods satisfied when you hand him over thousand gems and in exchange gives you an Elementalist’s Tome.");
				player.gems -= 1000;
				inventory.takeItem(weaponsrange.E_TOME_, bookMenu);
			}
		}
		
		private function pitchDildo():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Dildo") >= 0) {
				outputText("<b>You already own a Dildo!</b>");
				doNext(eroticaMenu);
				return;
			}
			outputText("Giacomo takes out a slender tube roughly over half a foot in length.  \"<i>Since you seek pleasure, this is as simple and effective as it gets.  This dildo is a healthy seven inches long and is suitable for most women and even adventurous men.  Pick a hole, stick it in and work it to your heart's content or your partner's pleasure.  The single-piece construction makes it solid, sturdy and straightforward.  For 20 gems, you can take matters into your own hands.  How about it?</i>\"");
			doYesNo(buyDildo, eroticaMenu);
		}

		private function buyDildo():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 20) {
				outputText("\n\nGiacomo sighs, indicating you need " + String(20 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
			}
			else {
				outputText("After making the payment, Giacomo hands you the Dildo");
				doNext(eroticaMenu);
				player.gems -= 20;
				player.createKeyItem("Dildo", 0, 0, 0, 0);
			}
		}
		
		private function pitchSelfStimulationBelt():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Self-Stimulation Belt") >= 0) {
				outputText("<b>You already own a Self-Stimulation Belt!</b>");
				doNext(eroticaMenu);
				return;
			}
			outputText("Giacomo holds up what appears to be a chastity belt.  However, this device has a dildo attached to the inside.  There is a small gearbox on the outside and a wind-up key is tethered to it.  The crazed merchant holds the contraption up and begins his liturgy.  \"<i>Ah! Someone who both appreciates pleasure AND the wonders of artifice.  This naughty little piece of jewelry is designed to pleasure any woman all at the push of a button!  All you do is take this key, wind up the gear box...</i>\"  Giacomo takes the key and inserts it into the box and winds it like a watch.  He then points to a switch.  \"<i>...you then press this button and enjoy yourself!</i>\"  Giacomo flips the switch and the dildo vibrates rapidly.  The distinct hum from the toy and the whirring of gears stirs your imagination.  Giacomo pipes up, breaking your train of thought.  \"<i>This belt is not cheap, but it is most certainly worth the investment of 30 gems!</i>\"");
			doYesNo(buySelfStimulationBelt, eroticaMenu);
		}
		
		private function buySelfStimulationBelt():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 30) {
				outputText("\n\nGiacomo sighs, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
				return;
			}
			outputText("After making the payment, Giacomo hands you the Self-Stimulation Belt");
			player.createKeyItem("Self-Stimulation Belt", 0, 0, 0, 0);
			doNext(eroticaMenu);
			player.gems -= 30;
		}
		
		private function pitchAllNaturalSelfStimulationBelt():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("All-Natural Self-Stimulation Belt") >= 0) {
				outputText("<b>You already own an All-Natural Self-Stimulation Belt!</b>");
				doNext(eroticaMenu);
				return;
			}
			outputText("The merchant places his bag on the ground.  He reaches into one of his purses and pulls out a pair of gloves.  After putting them on, he reaches into his bag and pulls out what appears to be a chastity belt.  The device has a clearly organic look to it.  In the center of the front cover is a nodule.  You have heard of similar devices.  They normally have a dildo attached to them to pleasure women.  ");
			outputText("\"<i>This device is quite intriguing,</i>\" Giacomo begins, \"<i>This pleasure engine is NOT for the faint-of-heart.  Being constructed of materials from the workshops of biomechanical artificers, this device outperforms its mechanical cousin in every way.  Guaranteed to last longer than you do, this machine will give you as many mind-shattering orgasms as you can handle.  Unlike the mechanical belt, you do not need to wind it up.  It soaks up the power of the sun itself in an amazing feat of engineering.  Four hours a day is all it needs!  Keep in mind that if there is no sun for a couple of days, it will not work without a full day's sunshine.  You may wonder why I am wearing gloves.  Well, that is because of the pads on the belt.</i>\"  Giacomo points to a couple of small, amber pads on the belt.  \"<i>They are sensitive to human touch and activate the belt.  This is all yours for 40 gems and you get the gloves for free!  Again, this device offers ultimate pleasure.  If you can't handle it, I will not be offended if you turn it down.</i>\"");
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte > 39) {
				outputText("\n\nThe nodule and the base of the stimulator look vaguely like some of the things you have seen in the Dangerous Plant book.  You wonder if there is not something devious about this item.  Giacomo is also sweating.  It is too cool for that, this time of year.");
			}
			else {
				if (player.inte > 29) {
					outputText("\n\nYou notice a change in Giacomo's attitude.  He REALLY wants to sell you this sex toy.  Something this exotic should cost much more than what he is offering.");
				}
			}
			outputText("\n\nDo you buy the All-Natural Self-Stimulation Belt?");
			doYesNo(buyAllNaturalSelfStimulationBelt, eroticaMenu);
		}
		
		private function buyAllNaturalSelfStimulationBelt():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 40) {
				outputText("\n\nGiacomo sighs, indicating you need " + String(40 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
				return;
			}
			outputText("After making the payment, Giacomo hands you the All-Natural Self-Stimulation Belt");
			player.createKeyItem("All-Natural Self-Stimulation Belt", 0, 0, 0, 0);
			doNext(eroticaMenu);
			player.gems -= 40;
		}

		private function pitchOnahole():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Plain Onahole") >= 0) {
				outputText("<b>You already own a Plain Onahole!</b>");
				doNext(eroticaMenu);
				return;
			}
			outputText("Giacomo takes out a pink cylinder from his bag.  It appears to be sealed at one end and the cap is topped with a piece of rubber that has a vertical slit.  \"<i>Friend</i>,\" Giacomo starts, \"<i>when you do not want to go through all of the shit to bag a woman, this is the thing for you.  It never says no, it never bitches and it never takes everything you own in a divorce.  All you do is get hard, slip your cock in the slit, work it at your pace and unload.  Simple is as simple does.  Take the top off for easy clean up and there you go!  As you can see it is portable and is much safer than risking some social disease from an errant barmaid.  I have plenty of these in stock and I can let it go for 20 gems.  What say you?</i>\"");
			doYesNo(buyOnahole, eroticaMenu);
		}
		
		private function buyOnahole():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 20) {
				outputText("\n\nGiacomo sighs, indicating you need " + String(20 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
				return;
			}
			outputText("After making the payment, Giacomo hands you the Plain Onahole");
			player.createKeyItem("Plain Onahole", 0, 0, 0, 0);
			doNext(eroticaMenu);
			player.gems -= 20;
		}

		private function pitchDeluxeOnahole():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Deluxe Onahole") >= 0) {
				outputText("<b>You already own a Deluxe Onahole!</b>");
				doNext(eroticaMenu);
				return;
			}
			outputText("Giacomo holds up a weirdly shaped lump of rubber.  One end is shaped and contoured like a woman's genitalia while the rest stretches out to almost a foot long.  \"<i>This thing right here is excellent!  While a standard onahole will get you off, this has the look and feel of the real thing!  As you can see, the outside orifice looks just like a woman's privates and,</i>\" Giacomo pauses to open the inside for you to view.  You see the inner folds and curves that are typical to the inside of a woman's womb, \"<i>as you can see, great care has been taken to make the inside feel as much like a real pussy as possible.  You hammer your cock with this thing a few times and you may never want the real thing again!  If nothing else, it won't whine about you running out the door first thing in the morning.  50 gems is more than reasonable for all of the satisfaction this will bring.</i>\"");
			doYesNo(buyDeluxeOnahole, eroticaMenu);
		}
		
		private function buyDeluxeOnahole():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 50) {
				outputText("\n\nGiacomo sighs, indicating you need " + String(50 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
				return;
			}
			outputText("After making the payment, Giacomo hands you the Deluxe Onahole");
			player.createKeyItem("Deluxe Onahole", 0, 0, 0, 0);
			doNext(eroticaMenu);
			player.gems -= 50;
		}
		
		private function pitchAllNaturalOnahole():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("All-Natural Onahole") >= 0) {
				outputText("<b>You already own an All-Natural Onahole!</b>");
				doNext(eroticaMenu);
				return;
			}
			outputText("Giacomo reaches into his bag and pulls out what looks like an oblong coconut.  It is roughly seven inches in diameter.  There is a distinctive opening in one end that is just large enough for an erect penis.  Inside the opening you see what looks like two pink cushions.  There are multiple symmetrical depressions surrounding the outside hole of the thing.  Giacomo's smile fades and he takes on a much more serious attitude befitting his aquiline face.  \"<i>Miss,</i>\" Giacomo states, \"<i>without sounding too bold, it is no secret that members of the third gender are capable of sexual feats that force the other two genders into jealous fits.  Having bigger cocks than men, cumming more than an elephant and a pussy with the strength and coordination of a human hand, regular toys do not last long for you folk.  Hence, this little beasty.  I will tell you straightaway, only the third sex ");
			outputText("can handle this toy.  The other two genders simply do not have the stamina for it.  This thing is all-natural, meaning that it powers itself and is made with the Artificers' organic methods.  It will cease functioning if it is not used or you fail to give the opening a few drops of this fluid once every three days.</i>\"  Giacomo pauses to hold up a small bottle.  He places the bottle down and continues his sales pitch, \"<i>If you plan on not using this thing regularly, do not buy it.  These items are very rare and this one will probably be the only one you'll ever see.  Normally I pitch my products like crazy.  However, with this I do not need to.  This thing DOES work too well, and you WILL cum, period.  It will work you until you do not want it to work anymore.  It will not stop until IT decides to stop.  However, for the extreme needs of a lovely example of the dual-sex, it may be the very thing you need.  Again, this is for the ultimate hardcore pleasure seeker amongst the ultimate hardcore.  It costs a humble 150 gems, but for superhuman thrills, who can put a price tag on that?</i>");
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte > 35) {
				outputText("\n\nWhile skillfully avoiding Giacomo's suspicion, you correctly surmise that the toy is not a toy at all.  It is the outer shell for a hybrid animal-plant.  The creature is very much alive.  While the technical name for this beast is in the usual unpronounceable scholastic gibberish, the common nickname for this is the \"All-Day Sucker\".  It gets its name due to the fact that its diet consists of high nutrient fluids, especially semen.  It was used both as a torture device and as a pleasure pet of the snobbish elite because it would clamp down upon the member of a person and not release until it has stimulated the person enough to ejaculate sufficiently to feed.  However, the All-Day Sucker swells up like fleas and ticks do, thus requiring hours of stimulation to have its fill.  There was something else about these things, but you cannot remember exactly what it was.");
				if (player.inte > 65) {
					outputText("After a moment, you remember what it was you read.  Unlike many simple beasts, this creature has a male and a female gender.  The creature itself is similar to a tubeworm.  While the males are considered reasonably \"safe\", the females have a nasty habit of injecting its young inside the sex organs of the person using the thing, leaving the hapless person to convulse in endless, painful orgasms as the beasties wriggle around their insides until they are ready for birth.  The process takes about a week and recorded victims normally make full recoveries after a period of blindingly painful orgasms as they shoot out the young.  It is not a surprise to have people's hearts give out at the endless stimulation from the young.  The recovery time is quite long due to the stress on the body such overwhelming stimulus would generate.  Some ultra-extreme pleasure seekers actively look for these things just for this experience.\n\nHowever, the problem is there is NO WAY to tell if this is male or female by looking at it.");
				}
			}
			doYesNo(buyAllNaturalOnahole, eroticaMenu);
		}
		
		private function buyAllNaturalOnahole():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 150) {
				outputText("\n\nGiacomo sighs, indicating you need " + String(150 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
				return;
			}
			outputText("After making the payment, Giacomo hands you the All-Natural Onahole");
			player.createKeyItem("All-Natural Onahole", 0, 0, 0, 0);
			doNext(eroticaMenu);
			player.gems -= 150;
		}
		
		private function pitchDualStimulationBelt():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.hasKeyItem("Dual Belt") >= 0) {
				outputText("<b>You already own a Dual Belt!</b>");
				doNext(eroticaMenu);
				return;
			}
			outputText("Giacomo smiles widely as you look through his wares seeing a strange looking device sitting there.  \"<i>Ahh, I see you have spotted our latest piece of equipment.  Members of the third gender had a hard time finding enough pleasure to suit their special needs.  With this little device, you will never have to worry about satisfying your needs ever again.</i>\"  He grins widely at you.  \"<i>The deluxe dual belt will have you shaking in the throes of orgasm hours after a simple stim belt would leave you dry.  You will cum in this thing, and it will leave you running back to it anytime you need sexual gratification.  Everything else may as well be sandpaper on your skin.  Simply flick this switch here on the side to start it up and send yourself to heaven.  And you can have it for the low price of 50 gems.</i>\"  He smiles again at you.  \"<i>So, shall I hand it over to you?</i>\" he asks.");
			doYesNo(buyDualStimulationBelt, eroticaMenu);
		}
		
		private function buyDualStimulationBelt():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			if (player.gems < 50) {
				outputText("\n\nGiacomo sighs, indicating you need " + String(50 - player.gems) + " more gems to purchase this item.");
				doNext(eroticaMenu);
				return;
			}
			else {
				outputText("You are a bit dubious at the pleasure it could offer you, but it would be better than being raped by the creatures constantly... maybe to even work out some excess lusts... hesitantly, you reach into your bag and grab 50 gems, handing it to him.  He greedily snatches it from your palm and hands you with the belt with a smile.  \"<i>I promise you won't be disappointed.</i>\"  He counts the gems and waves goodbye.\n\n(<b>Dual Belt acquired!</b>)");
				player.createKeyItem("Dual Belt", 0, 0, 0, 0);
				player.gems -= 50;
			}
			doNext(eroticaMenu);
		}
		
		private function wormRemoval():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("You toss the gems at the merchant, who calmly hands you the bottle. Gulping down the liquid, your guts light up as if you swallowed fire. Pain overwhelms your body and you drop to your knees convulsing. You curse the merchant for poisoning you, yet you can only choke out gibberish through your groans. The pain quickly focuses from your stomach to your crotch as the worms inside you are clearly NOT happy with what you have done. You fall onto your back as the thrashing overwhelms you. With an unexpected climax, every worm in your body fights to escape your gonads. The fat worm that resided deep in your sex lazily pushes itself out last.\n\n");
			outputText("Upon seeing the fat worm, Giacomo displays a freakish celerity by jumping off his cart, grabbing an empty container and collecting the fat worm. Regaining your senses, you look at him with inquisitive shock at what he just did.\n\n");
			outputText("\"<i>You have to realize that I AM a merchant, after all.</i>\", he calmly replies. \"<i>Hell for you is heaven for someone else. This bugger will easily fetch 10,000 gems to some noble looking for a quick buzz. Don't WE know better!</i>\"\n\n");
			outputText("The merchant puts away his prize and comes back to help you up. \"<i>Here.</i>\", he says as he shoves a couple of bottles into your hand. \"<i>This is on the house. You probably need it after the shock of getting those things out.</i>\"\n\n");
			//Add 1 tincture of vitality to inventory
			//Infestation purged. Hit Points reduced to 10% of MAX. Corruption -20.
			if (player.HP > int(player.maxHP() * .15))
				player.HP = int(player.maxHP() * .15);
			//Maybe add a random chance of losing a random transformation with a smaller chance of losing ALL transformations except gender changes. This will probably be a bitch to implement.
			player.removeStatusEffect(StatusEffects.Infested);
			player.buff("Infested").remove();
			dynStats("lus", -99, "cor", -4);
			player.gems -= 175;
			inventory.takeItem(consumables.VITAL_T, explorer.done);
		}
		
		private function wormRemovalOffer():void {
			spriteSelect(SpriteDb.s_giacomo);
			outputText("\n\n\"<i>Been playing with creatures best left alone, I see</i>\", he chuckles, \"<i>Infestations of any kind are annoying, yet your plight is quite challenging given the magnitude of corrupt creatures around here. It is not the first time I have seen one infested with THOSE worms.</i>\"\n\n");
			outputText("You ask how he knows of your change and the merchant giggles heartily.\n\n");
			outputText("\"<i>Do not look at me as if I am a mystic.</i>\", Giacomo heckles lightly. \"<i>Your crotch is squirming.</i>\"\n\n");
			outputText("Looking down, you realize how right he is and attempt to cover yourself in embarrassment.\n\n");
			outputText("\"<i>Fear not!</i>\", the purveyor jingles. \"<i>I have something that will cure you of those little bastards. Of course, there is also a chance that it will purge your system in general. This potion is not cheap. I will trade it for 175 gems.</i>\"\n\n");
			//Broke as a joke
			if (player.gems < 175)
			{
				outputText("You realize you don't have enough gems for such a pricey potion, but perhaps there is something else in his inventory you can buy.");
				doNext(giacomoEncounter);
			}
			//Can afford
			else
			{
				outputText("Do you purchase his cure?");
				//Remove/No
				doYesNo(wormRemoval, giacomoEncounter);
			}
		}
		
		private function nightSuccubiFirstTime():void {
			spriteSelect(SpriteDb.s_cerulean_succubus);
			outputText("\nAs you sleep, your rest becomes increasingly disturbed.  You feel a great weight on top of you and you find it difficult to breathe.  Stirred to consciousness, your eyes are greeted by an enormous pair of blue tinged breasts.  The nipples are quite long and thick and are surrounded by large, round areola.  A deep, feminine voice breaks the silence.  \"<i>I was wondering if you would wake up.</i>\"  You turn your head to the voice to see the visage of a sharp-featured, attractive woman.  The woman grins mischievously and speaks again.  \"<i>I was hoping that idiot, Giacomo, did not dilute the 'potion' again.</i>\"  Your campfire reflects off the woman's face and her beauty contains some sharply contrasting features.  The pupils of her eyes are slit like a cat's.  As she grins, she bares her teeth, which contain two pairs of long and short fangs.  This woman is clearly NOT human!  In shock, you attempt to get up, only prompting the woman to prove her inhuman nature by grabbing your shoulders and pinning you to the ground.  You see that each finger on her hand also contains a fourth joint, further proving her status.  Before you can speak a word, the woman begins mocking your fear and places her face in front of yours.  Her face is almost certainly demonic in nature.\n\n");
			if (player.gender == 0) {
				outputText("She quickly moves down to your crotch... only to discover no organs down there.\n\n");
				outputText("*record scratch*\n\n");
				outputText("\"<i>Wait a fucking minute,</i>\" the Succubus says, \"<i>Where's your dick?!</i>\"\n\n");
				outputText("As you state your genderless nature, the succubus hops off and from nowhere pulls out a large folder marked \"<i>Corruption of Champions-Script</i>\" and begins thumbing through the pages.  After finding the page she is looking for, she reads it and looks off into the distance in disgust.\n\n");
				outputText("\"<i>Hey Fenoxo and Dxasmodeus!!!!!!</i>\" the Succubus crows, \"<i>The goddamn script says that I should be milking someone's DICK!!!  Man, futa, herm, I don't give a shit.  YOUR OWN FUCKING SCRIPT SAYS I SHOULD BE MOUNTING AND MILKING A COCK!!!!  THIS IS A SEX GAME!!!!!!  THAT MEANS FUCKING!  WHAT THE HELL AM I SUPPOSED TO FUCK???!!!</i>\"\n\n");
				outputText("The Succubus looks at you with utter contempt, \"<i>THIS motherfucker doesn't have a DAMN thing!  What am I supposed to do?!  I can't exactly order a fucking Happy Meal!!!!!</i>\"\n\n");
				outputText("Throwing the script down in an utter rage, the tantrum continues, \"<i>Goddammit!  I can't believe this shit!  HEY!!!!!  INTERN!!!!  Bring me my robe, aspirins and cancer sticks!!!!</i>\"\n\n");
				outputText("The Succubus walks a few paces away where a plain-dressed woman with a clipboard hands the Succubus a pack of cigarettes and a small bottle of aspirin.  She takes a fistful of the painkillers and immediately lights up a smoke.  The Succubus takes a couple of drags off the cig and rubs her temples.\n\n");
				outputText("\"<i>You two are killing me!</i>\" she groans in clear frustration, \"<i>I come to work for you perverts based off the promise of MORE perverts to feed from and you do THIS to me!  I can't work like this!</i>\"\n\n");
				outputText("The plain woman hands the Succubus a robe, which she crudely puts on as she storms off into the night.\n\n");
				outputText("\"<i>I will discuss this horseshit with my agent,</i>\" the Succubus continues bitching, \"<i>THIS was NOT in my contract.</i>\"\n\n");
				outputText("The Succubus stops, turns and points to you in derision.  \"<i>And YOU!  You no-cock, no-cunt having pissant!  Take your ass back to the lab before they find out you escaped!!!!!</i>\"\n\n");
				outputText("The Succubus resumes her stormy exit.  You look at the bottle of Cerulean Potion and wonder if it REALLY had some psychotropics in it.  What the hell just happened?!");
				flags[kFLAGS.CERULEAN_POTION_NEUTER_ATTEMPTED] = 1;
				doNext(playerMenu);
				return;
			}
			sceneHunter.selectGender(dickF, null, null, hermF);

			//==========================================================================================================

			function dickF():void {
				outputText("\"<i>Awwww!  Did my blue skin and pointy teeth scare you?</i>\" she says in a childish voice.  \"<i>Believe me stud, if I wanted to harm you, I would not have let you wake up at all.  I am here because you have 'called' me.</i>\"  She teases you with the empty blue bottle you bought from the merchant.  \"<i>My essence is in this bottle.  Any man who drinks this, I am compelled to return the pleasure by drinking his.</i>\"  The demon woman reaches her skinny hand down to your crotch where you see you have become fiercely erect.  The demon gently strokes your cock until you begin oozing generous amounts of your own natural lubricants.  The demon takes one of her massive breasts and teases you with her fat nipples.  \"<i>Open your mouth,</i>\" she demands.  \"<i>Take me into your mouth as I will soon take you into mine.</i>\"\n\n");
				sharedEnd(false);
			}
			function hermF():void {
				flags[kFLAGS.CERULEAN_HERM_TIMES_USED]++;
				outputText("\nIt is obvious that you have been confronted by a succubus.  As the fire illuminates your captor, her grin widens broadly.\n\n");
				outputText("\"<i>Well, well, well!</i>\" the Succubus jingles.  \"<i>What have we here?!  A little girl with a big cock!</i>\"\n\n");
				outputText("As the Succubus looks down at your [cock], you have quickly achieved one of the healthiest erections you have ever had.  The succubus quickly poises her hairy hole over your member and allows her weight to force your dick into her womb.  The demoness rests her weight in her lap as she allows you to fully penetrate her.  Her womb is hot and wet and her muscles have your prick in one of the strongest grips imaginable.  Even if you went totally limp, withdrawal would be an impossibility.  Wincing at the sudden crushing force of her vaginal muscles, the succubus giggles inhumanly.\n\n");
				outputText("\"<i>Quit whimpering,</i>\" the Succubus orders.  \"<i>I hope the rumors about you futas are true.  I need a good, fiery load of cum to get me going.  I haven't had one in a while and as much as I LOVE men, they can only feed me so much.</i>\"\n\n");
				outputText("You quickly try to struggle, but find the Succubus to be utterly dominating.  She wraps her arms around your back and entwines her lean legs around your hips.  The Succubus playfully licks your lips and grins.\n\n");
				outputText("\"<i>You are getting your dick milked,</i>\" the Succubus says flatly, \"<i>Accept it.  Trust me, when I am done, you will want more of me, anyway.</i>\"\n\n");
				outputText("As the Succubus finishes her ultimatum, you feel churning vaginal contractions stroking your massive cock.  Heavy, powerful, coordinated undulations work your dick as surely as the best handjob.  You quickly moan in shock and pleasure at such rough treatment.");
				sharedEnd(true);
			}
			function sharedEnd(herm:Boolean):void {
				dynStats("lus", 35, "scale", false);
				doNext(ceruleanSuccubusEncounterPart2, herm);
			}
		}
		
		private function ceruleanSuccubusEncounterPart2(herm:Boolean):void {
			clearOutput();
			spriteSelect(SpriteDb.s_cerulean_succubus);
			if (!herm) {
				outputText("Your natural instincts immediately take over and you open your mouth and allow her nipple inside.  Immediately, your mouth has a mind of its own as you press your head firmly into her breast and begin suckling the unnaturally long teat like a starving baby.  The demon-woman laughs in satisfaction.  \"<i>To think, that you believed me to do you harm!</i>\" she taunts.  \"<i>Drink, little man.  Feed your lust as you will soon feed mine.</i>\"  Immediately, you feel her milk flood your mouth.  Its taste immediately reminds you of the potion you got from Giacomo.  You realize the potion was not a potion at all, but this demon's breast milk!  Concerned only for your blind libido, the suction of your mouth coaxes torrents of the devil's fluid into your mouth and down your throat.  She continues teasing your cock only enough to maintain your erection.  In time, your stomach signals that you are full and you break the seal from her tit, making a loud 'pop'.  She briefly hoses you down with milk, soaking you.\n\n");
				outputText("The demon has a satisfied look on her face.  \"<i>Did I taste good?  Was I wholesome and fulfilling?</i>\" she asks.  \"<i>Since you have fed from my life-milk, it is only fair that I do the same.  To be fair, 'yes', I am as fierce as I look and I will leave you sore and insensible.  However, I do so to pleasure you and feed myself.  Accept it and be happy.</i>\"  She gives you another inhumanly toothy grin and kisses you deeply.  A small pang of fear still shoots through you as you feel the sharpness of her teeth.  She breaks away from your lips and sighs in excitement.  \"<i>Now, I FEED!</i>\" she utters jubilantly.");
			}
			else {
				outputText("\"<i>See,</i>\" the Succubus says triumphantly, \"<i>You are already enjoying it.  You don't even have to hump.  My cunt does all the work.  Try THAT with a human woman.  Good fucking luck.  Half of them don't even know how to keep a prick hard once it's inside them and then they bitch because THEY didn't cum.</i>\"\n\n");
				outputText("The fierce milking continues for several minutes until you reflexively buck your hips as your inner organs fill with the white, milky life-water the demoness demands in order to slake her thirst.  Quick to take notice of your muscular reaction, the succubus snickers.\n\n");
				outputText("\"<i>Ready to burst, are you?</i>\" the Succubus playfully challenges.  \"<i>Well, then.  No reason for you to hold back.</i>\"");
			}
			dynStats("tou", .3, "lib", .5, "sen", .5, "lus", 5, "cor", 1);
			doNext(ceruleanSuccubusEncounterPart3, herm);
		}

		private function ceruleanSuccubusEncounterPart3(herm:Boolean):void {
			clearOutput();
			spriteSelect(SpriteDb.s_cerulean_succubus);
			if (!herm) {
				outputText("Rotating herself into a 69 position, she seizes your throbbing member and effortlessly begins deep throating.  Her thighs wrap around your head and confront you with her surprisingly hairy pussy.  Her clitoris is long and erect, begging for attention and the smell of her pheromones enslaves you.  You bury your face into her furry mound, ignoring your normal revulsion to such an unshaved state and begin eating her as well as any woman you have ever pleased.  The demon takes your cock out of her mouth to cry in delight.  \"<i>YES, LITTLE MAN!</i>\" she screams.  \"<i>LICK ME!  TEASE ME!  LOVE MY WOMB WITH YOUR TONGUE!</i>\"  She responds by clamping her mouth around the head of your penis and sucking smartly.  A sharp pain in your ass signals the entry of her bony fingers working their way to your inner manhood.  Finding the root of your sex easily, she mashes down to force you to cum.\n\n");
				outputText("Finding it impossible to resist such pleasure, you immediately begin cumming.  Glob after glob, stream after stream of your semen shoots into the woman's mouth.  Her timed sucking ensures that she swallows each drop as you launch it into her.  While you have been proud of the ability to cum in a woman for over a minute, you are wracked with both pain and pleasure as your ejaculations continue for almost ten.  Once you have spent your last, the demon releases your penis to bear down on your face with her thighs and unloads a massive squirting orgasm.  Your face is soaked with pussy juice as you see her cunt spasm from the force of her pleasure.  The sight of her rhythmic muscles is hypnotic.  She then promptly removes her finger from your ass.");
			}
			else {
				outputText("The Succubus rears up and pins your shoulders firmly to the ground.  The speed of her vaginal contractions becomes impossibly fast.  As you look down at the Succubus' crotch, you can clearly see her contractions working your penis despite the massive growth of fur between your legs.  The pressure deep behind your cock is crushing.  With one last spasmodic push, you release a thick, superhuman gout of semen deep in the Succubus' cunt.  She lets out an inhuman howl of pleasure as her womb clamps down upon you like a vise.  She literally squeezes each stream and drop of cum out of you.\n\n");
				outputText("After a couple of minutes, you feel your dick weaken and begin going limp.  Satisfied, you feel the Succubus' grip on your prick release and you quickly fall out of her womb.  Much to your surprise, despite the massive load you released, not a single drop of cum falls out or is left on your prick.  The Succubus begins rubbing herself all over, clearly in post-orgasmic ecstasy from absorbing your fluids.  After a couple of chain-orgasms, the Succubus sits down next to the empty jar.\n\n");
				outputText("She places the mouth of the jar next to one of her fat nipples and begins milking her tit into the jar, filling it back up with her fluids.  She places the jar next to you and stands up.\n\n");
				outputText("\"<i>It has been a long time since I soaked up a load that good,</i>\" she says, \"<i>Anytime you want more of that, just drink my milk again.  It's only fair.  I take your milk, you take mine.</i>\"\n\n");
				outputText("She smiles and flies off, leaving you with a fresh bottle of \"Cerulean Potion\".  As pleasing as the experience was, it has left you thoroughly exhausted.");
					//[Mechanics: Corruption increase same as male counterpart. No hit point recover for that night. When fatigue model is implemented, no fatigue recovery and add 25 points]
			}
			fatigue(20);
			player.orgasm();
			dynStats("lib", .5);
			doNext(ceruleanSuccubusEncounterPart4, herm);
		}
		
		private function ceruleanSuccubusEncounterPart4(herm:Boolean):void {
			spriteSelect(SpriteDb.s_cerulean_succubus);
			if (!herm) {
				clearOutput();
				outputText("She stands up and helps you to your feet.  While dazed, ");
				if (player.tallness < 80)
					outputText("you see that she towers over you.  She must stand well over seven feet in height.  ");
				if (player.tallness >= 80 && player.tallness < 90)
					outputText("you see she is about as tall as you - around seven feet in height.  ");
				if (player.tallness >= 90)
					outputText("you see she's definitely shorter than you, only about seven feet tall.  ");
				outputText("She braces you against a tree and picks up the empty potion bottle.  Grabbing the tit you ignored during the unholy tryst, she pokes her nipple into the bottle and squeezes for about a minute.  Satisfied, she corks the bottle and hands it to you.  She begins licking her nectar off your face.  \"<i>You have pleased me, little man,</i>\" she coos.  \"<i>It is a rare thing indeed for one of my meals to pleasure me so.  If you ever desire for me again, all you need is to drink my milk.  I will appear forthwith to let you suckle me and I will suckle you! We will feed each other and grow stronger for the effort!</i>\"  ");
				outputText("She gives a giggle and disappears before your eyes.  At that moment the fatigue from the massive fucking you received catches up with you and you pass out in a slump.");
				dynStats("str", .5,"lus", 4);
			}
			inventory.takeItem(consumables.CERUL_P, playerMenu);
		}

		private function nightSuccubiRepeat():void {
			spriteSelect(SpriteDb.s_cerulean_succubus);
			if(player.gender == 0) {
				if(flags[kFLAGS.CERULEAN_POTION_NEUTER_ATTEMPTED] == 0) {
					outputText("\nAs you sleep, your rest becomes increasingly disturbed. You feel a great weight on top of you and you find it difficult to breathe. Stirred to consciousness, your eyes are greeted by an enormous pair of blue-tinged breasts. The nipples are quite long and thick and are surrounded by large, round areola. A deep, feminine voice breaks the silence, \"<i>I was wondering if you would wake up.</i>\" You turn your head to the voice to see the visage of a sharp featured, attractive woman. The woman grins mischievously and speaks again, \"<i>I was hoping that idiot, Giacomo, did not dilute the 'potion' again.</i>\" Your campfire reflects off the woman's face and her beauty contains some sharply contrasting features. The pupils of her eyes are slit like a cat's. As she grins, she bares her teeth, which contain two pairs of long and short fangs. This woman is clearly NOT human! In shock, you attempt to get up, only prompting the woman to prove her inhuman nature by grabbing your shoulders and pinning you to the ground. You see that each finger on her hand also contains a fourth joint, further proving her status. Before you can speak a word, the woman begins mocking your fear and places her face in front of yours. Her face is almost certainly demonic in nature.\n\n");
					outputText("She quickly moves down to your crotch...only to discover no organs down there.\n\n");
					outputText("*record scratch*\n\n");
					outputText("\"<i>Wait a fucking minute.</i>\", the Succubus says, \"<i>Where's your dick?!</i>\"\n\n");
					outputText("As you state your genderless nature, the succubus hops off and from nowhere pulls out a large folder marked \"<i>Corruption of Champions-Script</i>\" and begins thumbing through the pages. After finding the page she is looking for, she reads it and looks off into the distance in disgust.\n\n");
					outputText("\"<i>Hey Fenoxo and Dxasmodeus!!!!!!</i>\", the Succubus crows, \"<i>The goddamn script says that I should be milking someone's DICK!!! Man, futa, herm, I don't give a shit. YOUR OWN FUCKING SCRIPT SAYS I SHOULD BE MOUNTING AND MILKING A COCK!!!! THIS IS A SEX GAME!!!!!! THAT MEANS FUCKING! WHAT THE HELL AM I SUPPOSED TO FUCK???!!!</i>\"\n\n");
					outputText("The Succubus looks at you with utter contempt, \"<i>THIS motherfucker doesn't have a DAMN thing! What am I supposed to do?! I can't exactly order a fucking Happy Meal!!!!!</i>\"\n\n");
					outputText("Throwing the script down in an utter rage, the tantrum continues, \"<i>Goddammit! I can't believe this shit! HEY!!!!! INTERN!!!! Bring me my robe, aspirins and cancer sticks!!!!</i>\"\n\n");
					outputText("The Succubus walks a few paces away where a plain-dressed woman with a clipboard hands the Succubus a pack of cigarettes and a small bottle of aspirin. She takes a fistful of the painkillers and immediately lights up a smoke. The Succubus takes a couple of drags off the cig and rubs her temples.\n\n");
					outputText("\"<i>You two are killing me!</i>\", she groans in clear frustration, \"<i>I come to work for you perverts based off the promise of MORE perverts to feed from and you do THIS to me! I can't work like this!</i>\"\n\n");
					outputText("The plain woman hands the Succubus a robe, which she crudely puts on as she storms off into the night.\n\n");
					outputText("\"<i>I will discuss this horseshit with my agent.</i>\", the Succubus continues bitching, \"<i>THIS was NOT in my contract.</i>\"\n\n");
					outputText("The Succubus stops, turns and points to you in derision. \"<i>And YOU! You no-cock, no-cunt having pissant! Take your ass back to the lab before they find out you escaped!!!!!</i>\"\n\n");
					outputText("The Succubus resumes her stormy exit. You look at the bottle of Cerulean Potion and wonder if it REALLY had some psychotropics in it. What the hell just happened?!");
					flags[kFLAGS.CERULEAN_POTION_NEUTER_ATTEMPTED] = 1;
				}
				//REPEAT
				else {
					outputText("\nAs you begin to relax, you hear footsteps behind you, expecting the unholy interloper and pray for a better... and more understanding... encounter.\n\n");
					outputText("You turn around, hoping for an exciting encounter only to find a rather short, plain-faced woman with horned-rim glasses and a purple dress on. She appears to be holding a stack of papers in her hand.\n\n");
					outputText("\"<i>Ahem.</i>\", the woman says meekly, \"<i>I hate to bother you, but I was sent by the CoC writers and staff to hand you this.</i>\"\n\n");
					outputText("Scratching your head, you inquire what the document is. The woman smiles shyly and hands it to you.\n\n");
					outputText("\"<i>This is the script and production notes for Corruption of Champions,</i>\" she says with a small bit of pride, \"<i>Apparently, you need to read the highlighted sections. They are important.</i>\"\n\n");
					outputText("You take the script, scratching your head at the surreal nature of the moment. You thumb through the pages, finding virtually every aspect of your life and encounters written as if foreseen by great mystics. The accuracy is nothing short of horrifying. You find a highlighted section that appears to be what the woman is referring to. The note is terse and outright blunt.\n\n");
					outputText("\"<i>GENDER NEUTRAL CHARACTERS ARE BUTT-MONKEYS. IF THE ENCOUNTER INVOLVES SEX, EXPECT SOMETHING FUCKED UP TO HAPPEN INSTEAD. ACTORS WHO PLAY NEUTER CHARACTERS SHOULD EXPECT TO PLAY ONLY FOR LULZ</i>.\"\n\n");
					outputText("The shock is overwhelming. The script basically says that you will never catch a break. As this reality drapes about you, the script disappears and you hear a cacophony of mocking laughter in all directions. The woman is nowhere to be found.\n\n");
					outputText("As the cacophony fades, you only hear one facetiously toned word,\n\n");
					outputText("\"<i><b>Problem?</b></i>\"");
				}
				doNext(playerMenu);
				return;
			}

			sceneHunter.selectGender(dickF, null, null, hermF);

			function dickF():void {
				sceneHunter.selectPureCor(["Succumb", pureF, "Let her have her way with you"],
													["Aggressive", corF, "Fuck the succubus like the slut she is"], 66);
				//=======================================
				function pureF():void {
					outputText("\nAgainst your better judgment, you've again partaken of the cerulean elixir and fallen asleep. You are quickly awakened by a thick nipple being thrust into your mouth and torrents of breast milk gushing down your throat as the succubus returns to have her way with you. Looking up, your eyes meet hers as a hungry manipulative grin stretches across her blue face. Unable to control your lust, your prick jumps to attention, which prompts the demoness to ");
					if(player.isTaur()) outputText(" crouch between your legs and impale herself on your [cock] with a wet sound caused by her well-lubricated vulva. Y");
					else outputText(" open her womb and quickly consume your [cock]. She embraces you, entrapping your head in her cleavage as y");
					outputText("ou quickly feel her superhuman vaginal muscles work and stroke your [cock] better than any human woman or pair of hands could ever hope to accomplish. You are helpless as your unholy embrace milks both of you in an infernal symphony of debauchery. The familiar cramp of an impending ejaculation grips you and your twitching signals the succubus of your approaching climax.\n\n");
					if(player.isTaur()) outputText("Pushing on your forelegs, she engulfs even more of your " + cockDescript(0));
					else outputText("Almost crushing your pelvis, she wraps her legs around your body");
					outputText(" and her muscles churn mercilessly demanding that you release your 'milk' as freely as she has released hers into you. Stimulated beyond any human ability to maintain control, you bear down and release a milky flood of your own inside the succubus. Moaning in ecstasy, she ");
					if(player.isTaur()) outputText("arches under your belly as you feel your [cock] bending pleasurably inside her, and");
					else outputText("releases you from her grip, allowing you to finally breathe deeply, and leans back, arching high to reveal your joined genitals in the moonlight. You visibly see");
					outputText(" her contractions milking your [cock] as fiercely as a maid milks a cow! Another torrent of cum pushes its way out of your body and you let out a moan of pleasure and exhaustion.\n\n");
					outputText("As you are passing out, you feel a deep kiss upon your lips from the succubus. \"You taste better each time we join. Call upon me soon, lest I take what I want from you anyway,\", says the lustful creature.\n\n");
					outputText("Fatigue takes you and you collapse into a deep sleep.  ");
					sharedEnd();
				}

				function corF():void {
					outputText("\nKnowing the succubus will come, you do not even bother trying to sleep. Instead, you prepare a little surprise for her. You briefly jerk off and start edging yourself, preparing a massive batch to unload inside her. Hopefully, she will be the one to get more than she bargained for.\n\n");
					outputText("The succubus comes, as you predicted. Despite her obvious strength and size difference to you, you grab her and push her down to the ground and immediately push your angry cock into her hairy hole. The succubus, surprised and enthralled, laughs at your aggression.\n\n");
					outputText("\"<i>I thought I was the hungry one.</i>\", she chuckles. \"I am all yours, little man. FEED ME!\"\n\n");
					outputText("You begin bucking your ");
					if(player.isTaur()) outputText("flanks");
					else outputText("hips");
					outputText(" in the all-too-familiar rhythm, hammering away at the succubus' cunt. Impressed with your initiative, she chooses to remain submissive as you work up an impressive load of spunk. Trying with all of your might, you continue to hold off your orgasm, painfully, as you continue stimulating your inhuman lover.\n\n");
					outputText("However, she senses your control and immediately brings her own muscles into the little love game. With one good squeeze, she breaks down any control and resistance you have. Sensing you are about to explode, she ");
					if(player.isTaur()) outputText("pushes on your forelegs, impaling herself even deeper on your " + cockDescript(0));
					else outputText("wraps her legs around your hips and bears down");
					outputText(". You feel the head of your prick push past the dilated opening in her cervix, which immediately contracts around your head. Your penis is literally trapped and caught in her womb!\n\n");
					outputText("Groaning loudly, long muscle spasms release the painfully stored semen into the deepest parts of the succubus. The sensation of your hot cum so deep inside her body triggers her peak. ");
					
					if(player.isTaur()) outputText("She moans inhumanly, and reflexively digs her claws into your forelegs. Searing with lust, the pain means little to you as you only feel the sensation of your body forcing your fluids out of your body and into hers. You press your [cock] into her");
					else outputText("She embraces you, moaning inhumanly, and reflexively digs her claws into your back. Searing with lust, the pain means little to you as you only feel the sensation of your body forcing your fluids out of your body and into hers. You slam your pelvis into hers");
					outputText(", as if to force yourself to cum harder than you already are capable of, prompting an equally pleasurable reaction from her.\n\n");
					outputText("For the first time since you have had your 'visits', the succubus appears winded. Without another word, her muscles release your manhood, which she quickly licks clean of your intermingled juices.  She tongues your face in lustful approval and flies away. You quickly fall asleep, utterly spent.  ");
					sharedEnd();
				}
			}

			function hermF():void {
				//Bad End-Cerulean Succubus Futa/herm
				//[Conditions: Corruption >50. Drink 10 Cerulean potions over the course of 20 Days. (Other stipulations as required that prevent interference with other events-to be determined)]
				if(flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER] > 10 && player.cor > 50 && !player.hasPerk(PerkLib.Soulless) && !player.blockingBodyTransformations()) {
					outputText("\nAs the Succubus mounts you, an uncontrollable urge takes over your mind and body. Without any thought, you quickly thrust one of her nipples in your mouth and begin suckling wildly like a newborn child. The Succubus cries in shock and pleasure as you begin feeding from her and quickly begins her ritualistic milking of your dong. The warm milk passes into your mouth and down your throat, where it settles peacefully in your stomach. The sensation of fulfillment from her tits is only eclipsed by the massive load of semen you feel cramping your prostate.");
					//[ (Herm-Dickgirl variant only)
					if(player.hasBalls()) outputText("  Even your nuts are unbearably sore.");
					outputText("  As the milk begins to dry out of the Succubus' tit, you release it from your control and launch an impossible load of cum into the succubus. The demoness releases her hold of your cock and hops off your crotch and jumps to place her mouth over your erupting penis. Reflexively grabbing her head, you push your cock as deep as you can in her mouth and for minutes, pump stream after stream of hot lust into her gullet. After the last load leaves your dong, you pass out.\n\n");
					outputText("After a short time, you wake up sore from head to toe. The Succubus is sitting next to you with an utterly satisfied look on her face.\n\n");
					outputText("\"<i>Well, this was unexpected.</i>\", she says, \"<i>I did not expect you to change. Normally, men are susceptible to my milk, but apparently it works on herms, too.</i>\"\n\n");
					outputText("As you stand, you feel awkward as your body does not feel right. You look at the Succubus and she no longer appears as large as she once was. Quick to realize a problem, you look at your reflection in a small bucket at your campsite. Other than your own unique facial features, you see ANOTHER Cerulean Succubus looking back at you! You ARE a Cerulean Succubus!");
					//[(if the player has a large number of transformations)
					if(player.racialScore(Races.HORSE, false) + player.racialScore(Races.DOG, false) + player.racialScore(Races.NAGA, false) + player.racialScore(Races.GOBLIN, false) + player.racialScore(Races.SHARK, false) + player.racialScore(Races.MINOTAUR, false) + player.racialScore(Races.COW, false) > 5) outputText("  All of the other corruptions and changes to your body have faded away as your new form has taken shape.");
					outputText("  As the reality soaks in, you feel a sharp pain in your stomach and your cock. You NEED to feed. Cum, milk, it doesn't matter. Likewise, your dick is hard and you need to cum. Despite your need, you cannot bring yourself to masturbate. You want ANOTHER'S attention.\n\n");
					outputText("Without further acknowledgement, you take up your on your demonic wings to find your first \"meal\". The Succubus left behind simply giggles as she sees another of her kind take up the night in search for more meals and pleasure.");
					outputText("At first you scour the land looking for a plaything to suck the fluids out of but to your disappointment discover that it’s all imp or goblin in the region. Thirsty for sex you sate yourself on the closest greenskin but it's about the cheapest meal you can get. Even as you retrieve and eat the skank pathetic soul you yearn for more. It dawns on you that the portal to your homeworld still exists and that inevitably new champions will be thrown in, pure humans you can enslave and use for your own gains. You could always hook up with an incubus but what could ever replace the sweet taste of a harem trained for your own needs and tastes?"+(flags[kFLAGS.LETHICE_DEFEATED] <= 0?" Heck that bitch demon queen hoards all the Lethicite in the realm to herself. You could probably claim it as your own by taking her down.":"")+"\n\n");
					outputText("With new resolve you resume your unholy quest to take this world by storm and make it your playground!\n\n");
					if (player.hasCock()) player.lowerBody = LowerBody.DEMONIC_CLAWS;
					else {
						if (rand(2) == 0) player.lowerBody = LowerBody.DEMONIC_CLAWS;
						else {
							if (rand(2) == 0) player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
							else player.lowerBody = LowerBody.DEMONIC_GRACEFUL_FEET;
						}
					}
					player.legCount = 2;
					player.skin.setBaseOnly({type:Skin.PLAIN, color1:"blue", pattern: Skin.PATTERN_DEMONIC_PLEASURE_RUNE});
					transformations.TailDemonic.applyEffect(false);
					transformations.HairHuman.applyEffect(false);
					transformations.FaceDemon.applyEffect(false);
					transformations.EyesDemon.applyEffect(false);
					transformations.ArmsDemon.applyEffect(false);
					transformations.TongueDemonic.applyEffect(false);
					transformations.EarsElfin.applyEffect(false);
					transformations.HornsDemonic.applyEffect(false);
					transformations.AntennaeNone.applyEffect(false);
					transformations.GillsNone.applyEffect(false);
					transformations.WingsDemonicLarge.applyEffect(false);
					transformations.RearBodyNone.applyEffect(false);
					if (player.hasCock()) transformations.CockDemon().applyEffect(false);
					if (player.hasVagina()) transformations.VaginaDemonic().applyEffect(false);
					outputText("\n<b>Gained Perk: Soulless!</b> "+PerkLib.Soulless.desc());
					player.createPerk(PerkLib.Soulless, 0, 0, 0, 0);
					player.npcsThatLeaveSoullessPC();
					sharedEnd();
				}
				else {
					flags[kFLAGS.CERULEAN_HERM_TIMES_USED]++;
					flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER]++;
					outputText("\nAs you begin to relax from a long day of adventuring, the succubus returns and lands squarely in your lap, just missing your throbbing erection. The succubus growls in arousal as she thrusts one of her fat nipples into your mouth. Reflexively, you begin suckling the teat with neither shame nor restraint. Milk floods into your mouth as you sense the weight of the succubus descend upon your cock. The familiar warmth and snugness of her cunt greet your hungry prick as her muscles begin the savory churning to coax your body into producing the 'milk' she needs to sate her own hunger. Your eyes roll back into your head as the torrent of milk pouring down your throat increases the sensitivity in all of your organs, compelling your hips to reflexively buck to press your dick deeper.\n\n");
					outputText("The Succubus restrains you without missing a stroke or disrupting your breastfeeding as the pangs of orgasmic pleasure swell up at the base of your cock. You wrap your arms forcefully around the succubus as you bear down upon your crotch, releasing the painfully stockpiled load of lust into the demoness' cunt for her own sustenance. The succubus lets out an inhuman howl of pleasure as her own orgasm begins to crush your cock, draining every last drop out of you.\n\n");
					outputText("Your consciousness begins to fade as the orgasm subsides. The succubus pops her tit out of your mouth and squeezes more of her essence into the empty bottle. She licks your lips and flies away just in time for you to pass out.  ");
					//Clear out any queue'ed events if bad-end
					//coming.  PC has to dig his own grave.
					if(flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER] > 10) player.removeStatusEffect(StatusEffects.SuccubiNight);
					fatigue(20);
					player.cumMultiplier++;
					sharedEnd();
				}
			}

			function sharedEnd():void {
				outputText("\n");
				player.orgasm();
				dynStats("str", rand(2), "tou", rand(2), "spe", rand(2), "int", rand(2), "cor", 1);
				inventory.takeItem(consumables.CERUL_P, playerMenu);
			}
		}
	}
}