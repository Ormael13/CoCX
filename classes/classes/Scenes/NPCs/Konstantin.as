/**
 * ...
 * @author Coalsack
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	
	public class Konstantin extends NPCAwareContent
	{
		
		public function Konstantin() 
		{
			
		}
		/*
		Konstantin flags:
		KONSTANTIN_FOLLOWER: 1 - Meet at forest, 2 - Came to camp
		KONSTANTIN_SERVICES: 1/2 - reached before he join the camp
		*/
		private function buildedAnythingInCamp():Boolean {
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10 || flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2 || flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1 || flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 || flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4 || flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2)
				return true;
			return false;
		}
		public function meetKonstantinAtForest():void {
			clearOutput();
			if (flags[kFLAGS.KONSTANTIN_FOLLOWER] == 1) {
				outputText("Wandering again in the forest, you happen unto Konstantin working on his furnace. He smiles warmly and greets you, after which you both chat a bit about your recent adventures and how things have been going for him.\n\n");
				outputText("While you’re chatting, you ask him if he can help you with your stuff. You don’t find a good smith often, even less given Mareth’s current situation.\n\n");
				outputText("\"<i>Sure, [name], again, I can polish your armor and fix any weakened or broken pieces. If you happen to have several pieces of a solid item that can be assembled into a protective armor, I can do it for you. Lastly, I can sharpen your weapons to make sure that they cut and pierce through almost everything.</i>\"\n\n");
				outputText("\"<i>The price for any of those services remains the same, 25 gems.</i>\"\n\n");
				outputText("Sounds like a good offer. What will you do?\n\n");
			}
			else {
				outputText("Wandering between trees while avoiding annoying roots that would make you trip, you stumble upon a clearing, and after spotting a tree trunk, you sit on it to rest. Looking around, you manage to see a scattered set of sharp tools near you, nearby is something that looks like a huge furnace. Before you can figure what they’re about, you’re jumped by a mountainous figure that comes and yelps.\n\n");
				outputText("\"<i>Whoa</i>\" the stranger says, \"<i>Don’t worry " + player.mf("man","girl") + ". I mean no harm.</i>\"\n\n");
				outputText("Looking again at who said that, you realize that what looked like a boulder coming over you is actually a bear-morph, almost nine feet tall, dressed in an overall with a white shirt and a set of boots. He has brown fur covering his body, and a gentle but slightly worried look on his ursine face.\n\n");
				outputText("Quickly, you reassure him explaining that you were only startled to face him all of a sudden, and that you were just resting on the clearing. A bit puzzled about him and his equipment, you question him about what he was doing with that stuff.\n\n");
				outputText("\"<i>Ah, that. Well, you’ll see " + player.mf("boy","girl") + ". After a couple of hours in the forge, tools can get overheated, so I have to get some water to cool them.</i>\" He explains, pointing to a barrel filled of water that wasn’t here before. \"<i>If you haven’t caught up with me yet, friend, I happen to be an smith. Probably one of the last ones in this cursed land.</i>\"\n\n");
				outputText("Certainly is pretty difficult to find a good smith in those places.");
				if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText(" The only ones that you know are in Tel’Adre, and albeit decent, their products aren’t exactly outstanding.");
				outputText("\n\n\"<i>Oh, right, " + player.mf("man","girl") + ", forgot my manners. Name’s Konstantin, and what’s yours?</i>\" extending his hand to you.\n\n");
				outputText("Accepting his handshake, you tell him your name, and vaguely tell what you are and how you happened to stumble on the clearing.\n\n");
				outputText("\"<i>So, you’re one of those brave and mighty explorers wanting to cleanse every bit of demon ichor of Mareth?</i>\" he says, a bit amused. \"<i>You’re quite a rare sight these days. anyways friend, I have my furnace working, and if you’re what you’re saying, you may require my services.</i>\"\n\n");
				outputText("Interesting. Having a smith checking your equipment periodically doesn’t sounds bad. You question him about  kind of things he can do.\n\n");
				outputText("\"<i>For starters, I can polish your armor and fix any weakened or broken pieces. If you happen to have several pieces of a solid item that can be assembled into a protective armor, I can do it for you. Lastly, I can sharpen your weapons to make sure that they cut and pierce through almost everything.</i>\"\n\n");
				outputText("\"<i>The price for any of those services is the same. Say, 25 gems?</i>\"\n\n");
				outputText("Sounds like a good offer. What will you do?\n\n");
				flags[kFLAGS.KONSTANTIN_FOLLOWER] = 1;
				flags[kFLAGS.KONSTANTIN_SERVICES] = 0;
			}
			menu();
			addButton(0, "Armor", meetKonstantinAtForestArmor);
			addButton(1, "Weapon", meetKonstantinAtForestWeapon);
			addButton(2, "Nothing", meetKonstantinAtForestNothing);
		}
		public function meetKonstantinAtForestArmor():void {
			clearOutput();
			if (player.gems >= 25) {
				player.gems -= 25;
				outputText("You take the [armor] and hand it to Konstantine. He starts working on it, idly whistling while you patiently sit on the nearby tree stump.\n\n");
				outputText("Applying the best of his smithing skills to the [armor], he starts tossing away the parts of it that are too damaged due to the blows that it has received or too weakened for the continued use, replacing them with brand new pieces of the same material. He also strengthens the inner structure of each piece and fixes them so they don’t leave a bit of your body unprotected.\n\n");
				outputText("Once he’s finished, your [armor] looks clean, beautiful and as good as if it was brand new.");
				if (player.hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) player.removeStatusEffect(StatusEffects.KonstantinArmorPolishing);
				player.createStatusEffect(StatusEffects.KonstantinArmorPolishing, 73, 10, 0, 0);
				if (flags[kFLAGS.KONSTANTIN_SERVICES] < 2) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				if (flags[kFLAGS.KONSTANTIN_SERVICES] == 2) {
					meetKonstantinAtForest2();
					return;
				}
				else outputText(" Thanking him for services, you take the armor and bid farewell to the smiling bear.\n\n\n\n");
			}
			else outputText("\"<i>It’s okay, " + player.mf("man","girl") + ". Gems can be tough to get sometimes. If you feel like using my services, you can find me in this clearing.</i>\"\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		public function meetKonstantinAtForestWeapon():void {
			clearOutput();
			if (player.gems >= 25) {
				player.gems -= 25;
				outputText("Handing the [weapon] to the bear smith, you hop on the tree stump while he gets to work. Konstantine goes to his anvil, where he examines your weapon and figures how he is going to work with it.\n\n");
				outputText("Later, you start hearing the sound of metal on metal caused by the bear’s tool, accompanied by a song that he’s humming to pass the time. Once he’s done with the anvil, he turns to sharpening and polishing your [weapon].\n\n");
				outputText("A short time later, he finally returns it to you. The [weapon] looks gleaming and brand new, and sharp enough that you think that it could cut rock.");
				if (player.hasStatusEffect(StatusEffects.KonstantinWeaponSharpening)) player.removeStatusEffect(StatusEffects.KonstantinWeaponSharpening);
				player.createStatusEffect(StatusEffects.KonstantinWeaponSharpening, 73, 10, 0, 0);
				if (flags[kFLAGS.KONSTANTIN_SERVICES] < 2) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				if (flags[kFLAGS.KONSTANTIN_SERVICES] == 2) {
					meetKonstantinAtForest2();
					return;
				}
				else outputText(" After giving thanks to the friendly ursine, you return to your camp.\n\n");
			}
			else outputText("\"<i>It’s okay, " + player.mf("man","girl") + ". Gems can be tough to get sometimes. If you feel like using my services, you can find me in this clearing.</i>\"\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		public function meetKonstantinAtForestNothing():void {
			clearOutput();
			outputText("Not having needed anything from his services at the moment, you thank the bear for his offer.\n\n");
			outputText("\"<i>Okay, " + player.mf("man","girl") + ". Was a pleasure to meet you, still, stop by again soon if you happen to need a good smith.</i>\"\n\n");
			outputText("Assuring him that you’ll do so, you bid him farewell and proceed to return to your camp.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		public function meetKonstantinAtForest2():void {
			outputText("As you take your stuff from Konstantin, you’re questioned by the bear-smith.\n\n");
			outputText("\"<i>Huh, [name], did you say that you were a Champion, or a warrior of some kind, seeking to save Mareth, right?</i>\"\n\n");
			outputText("You answer him that more or less, that was what you had on mind when you arrived to this place.\n\n");
			outputText("\"<i>And how are things going? Do you have a place to stay?</i>\"\n\n");
			outputText("Well, you had thought better ways of start your adventure than awaking drugged by a random imp, but overall, things have been okay. Also, albeit modest");
			if (buildedAnythingInCamp()) outputText(" at start, you have a camp where you sleep and prepare for your daily tasks");
			outputText(".\n\n\"<i>Oh. Then, I was wondering if...</i>\" The big bear hesitates for a second, and then sighs \"<i>The truth is, [name] that I’ve barely had any clients recently. You’re the first one coming in many, many days. To make things worse, no matter how tough I may look, I really don’t like the idea of being alone.</i>\"\n\n");
			outputText("You look at him attentively, guessing where he’s trying to go.\n\n");
			outputText("\"<i>So, I thought that maybe you would be okay if, well, I moved with you, since you won’t need to walk to the clearing each time that you needed me, and I could get a new place where work, one that maybe isn’t so fucking lonely.</i>\"\n\n");
			outputText("Seems like Konstantin is asking if you like to have him on your camp. What will you say?\n\n");
			menu();
			addButton(0, "No", meetKonstantinAtForest2No);
			addButton(1, "Yes", meetKonstantinAtForest2Yes);
		}
		public function meetKonstantinAtForest2No():void {
			outputText("\"<i>Right. Truth be told, we’ve barely met two times.</i>\" Konstantin says, sighing a bit. \"<i>These times you can’t put your trust in someone so easily, huh? At least I hope that we can see each other again.</i>\"\n\n");
			outputText("With that, you bid each other farewell, and you return to your camp while he resumes his work.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		public function meetKonstantinAtForest2Yes():void {
			outputText("\"<i>Really? Damn, I’m so fucking happy</i>\" Konstantin says, wrapping you in a literal bear-hug. \"<i>I’ll make sure that you don’t regret it [name]. And even better, since we’re on your place we’ll have time to meet each other better. So on top of not spending the rest of my life alone in the woods, now I’ll have a new friend.</i>\"\n\n");
			outputText("That’s certainly true, and having someone like Konstantin as your friend will probably be a fun thing. After a while, he starts packing his personal stuff and working tools, as well as his furnace. The process takes a couple of hours since he has to go to his hut on the woods to retrieve more things and the biggest furnace has to be dismantled before being packed.\n\n");
			outputText("Once he’s finished, both of you are walking back to your camp carrying several boxes containing his things, whilst idly chit-chatting.\n\n");
			meetKonstantinAtForest2YesPart2();
		}
		public function meetKonstantinAtForest2YesPart2():void {
			clearOutput();
			outputText("Arriving on the barren land surrounding your camp, you easily spot the purple glow of the portal from afar, and point it to Konstantine. He hurries up to catch you, and soon, you’re next to your tent, helping him to unpack his stuff.  With him are several boxes, enormous even for his size, that have his working tools, as well as the tent he has and probably other personal stuff.\n\n");
			outputText("\"<i>So, this is the place?</i>\" he asks, panting from the exertion of having to carry most of the stuff.\n\n");
			outputText("\"<i>Yes, it is.</i>\" you reply, also tired, even while you had much less to carry.\n\n");
			outputText("\"<i>Good</i>\" he says, nodding approvingly \"<i>A bit far from everything, but given this land’s average company, that’s quite a good thing.</i>\"\n\n");
			outputText("After recovering your breath, you offer to help him get his tent and smithing tools on their place, so he points you to the largest box. With a bit of difficulty, you put the frame and main cloth of the tent on a side of the camp.\n\n");
			outputText("Seems like he thought ahead, and brought a large tent, thrice as wide as yours, and twice as big, no doubt to fit his large frame with ease. The outsides are covered in furs and pelts, held by sturdy pieces of wood Since you’re helping him to set it, you manage to see its insides. While it contains no luxuries, it’s well furnished and has a homey feel, having a large bed wrapped in red linen, a small kitchen where a teapot fumes, and lacquered boxes with tools, books and clothing. Some small statues carved in wood ornate the area, some serving as lamps.\n\n");
			outputText("Once the tent is done, you rush to a secluded side of the camp, where the smoke of the ovens won’t bother anyone, and close enough to the stream. There, Konstantin handily re-assembles his oven and puts his anvil on place, as well as the rest of the working stuff.\n\n");
			outputText("(<b>Konstantin has been added to the Followers menu!</b>)\n\n");
			flags[kFLAGS.KONSTANTIN_FOLLOWER] = 2;
			doNext(camp.returnToCampUseTwoHours);
		}
		
		public function KonstantinMainCampMenu():void {
			clearOutput();
			outputText("It's possible Coalsack will wirte some short text for this menu.\n\n");
			menu();
			addButton(0, "Appearance", KonstantinAppearance);
			addButton(1, "Talk", KonstantinTalkMenu);
			addButton(2, "Crafting", KonstantinCraftingMenu);
			addButton(14, "Leave", camp.campFollowers);
		}
		
		public function KonstantinAppearance():void {
			clearOutput();
			outputText("Konstantin is a 8ft 10in tall bear-morph. He has a thick, soft layer of caramel brown fur covering almost every bit of his body, except on his underbelly, where the brown acquires a sandy coloration. The overall fluffy look of his fur makes you immediately think of a giant teddy bear. He covers himself in a simple, white cotton shirt, and covers his lower body with a working overall. Girding his ursine feet he has two black, sturdy boots. When he’s not working he opts for using an attire which is a bit more relaxed, with a loose, colorful shirt and baggy shorts.\n\n");
			outputText("His face is the one of an anthro bear, with the usual muzzle ending in a big, triangular black nose. Two round, ursine ears are placed at each side of his head. His eyes have an amber coloration, and the gentle look that emanates from them is a bit heartwarming. The short, brown hair at his head is almost indistinguishable from his fur unless you get very close. His arms are fully covered in caramel fur, ending in bear-like hands with black paw pads and short claws that don’t seem to hinder his work in any way.\n\n");
			outputText("Strong muscles lie beneath his chest, still, he has a bit of a belly, due his ursine nature, but not enough to be too noticeable under his fluffy fur. Being in such a good physical condition, it’s no wonder how strong he looks. His hips, albeit boyish, are a bit thicker due to his frame. A small, stubby and furred tail rest over his buttcheecks. He has paw like-legs that are covered in a coat of caramel fur, his feet end in black soles with paw pads. The claws at the end of his toes aren’t a nuisance to find good footwear, thankfully.\n\n");
			outputText("He has a strong, manly chest, with a small, pink nipple on each one of his pecs.\n\n");
			outputText("You’ve noticed that he usually wears a set of white, cotton undies, underneath what is a massive 22 inches package, ready to wreck anyone brave enough to try it out. It has an humanoid shape, albeit black in color and lying in a protective furred sheath instead of a foreskin. Just below, a duo of 5 inches wide nuts hang freely, bouncing as he walks when not covered by his undies.\n\n");
			outputText("Between his nice derriere, Konstantine has a tight-looking anus, right where it belongs.");
			doNext(KonstantinMainCampMenu);
		}
		
		public function KonstantinTalkMenu():void {
			clearOutput();
			menu();
			addButton(0, "Him", KonstantinTalkHim);
			addButton(1, "His Work", KonstantinTalkHisWork);
			addButton(2, "The camp", KonstantinTalkTheCamp);
			addButton(14, "Back", KonstantinMainCampMenu);
		}
		public function KonstantinTalkHim():void {
			clearOutput();
			outputText("Curious about your ursine friend past, you ask him what he used to do before the two of you met.\n\n");
			outputText("\"<i>Me? I fear that it’s nothing too outstanding, my friend.</i>\" he remarks. \"<i>Most of my childhood was with my parents, as usual, in one of the villages near the lake. The townsfolk either worked fishing on the lake or chopping wood, but of course, as in every town, a couple of skilled hands would always come in handy doing more artisan-related stuff.</i>\"\n\n");
			outputText("\"<i>My father worked as a metalsmith, as well as my grandfather, and so on, thus was natural that I followed their steps. What neither of us expected was how well I grew into it. You see, when the family has a line of artisans, sooner or later a kid wants to break the line. My case was the exact opposite. Melting, casting, sharpening, polishing, every bit of the metalwork process puzzled me. ");
			outputText("Everyone on my family was amazed by how fast I was learning, because when I was given the initials, around 9 or so, it only took me a year or so to understand the basics of iron casting. Turning this iron and other materials into useful things was an entirely different matter, so I took a bit more time with that, but in the end, I was learning faster than most at my age.</i>\"\n\n");
			outputText("\"<i>Then, as you may know at this point, like almost everywhere else in Mareth, the horned bastards came down from the mountains. Most of the largest towns were razed and corrupted in a question of weeks, but since our village was quite small, that bought us enough time to find a decent refuge, away from the woods.</i>\"\n\n");
			outputText("\"<i>Many villagers escaped unscathed too, but since the fear to the demons patrolling the forest was too big, many of them moved to the desert, here some said that a big free city was still standing, or to the frozen forests to the Rift, where the cold, and a kind of unnatural but harmless force was keeping those freaks away.</i>\"\n\n");
			outputText("\"<i>Me and my parents settled on a peaceful clearing and set up a refuge. During almost a decade we lived there, in our small hut, afar from all the demon crap. Life was almost as easy and peaceful as it always had been, so much that sometimes we saw the corrupted menace as something so distance. When you live in a pure section of the woods, with no other neighbor than the forest creatures and the occasional friendly survivor, it’s hard to think different.</i>\"\n\n");
			outputText("\"<i>Years passed, and more or less when I was 25, my parents health starter deteriorating, until they eventually passed away some months later. They went in peace, with dignity and above all happy, and that was enough for me. Which affected me the most back then, was suddenly being truly alone for the first time of my life. ");
			outputText("Wanting to divert my mind from the loneliness feeling, I focuses on improved my smithing skill, so I spent the next couple years practicing. Every now and then a customer passed through the forest me and requested my services, and then one day, one of them kept coming with more regularity...but I bet that you know what happened after that.</i>\"\n\n");
			outputText("With a smirk, you answer that you do. Thanking him for his conversation, you return to your taks.\n\n");
			doNext(KonstantinTalkMenu);
		}
		public function KonstantinTalkHisWork():void {
			clearOutput();
			outputText("\"<i>The usual, forging new weapons to sell, sharpening blades and axes that lost their edge, making tools, fitting armors. The defense and protection is a life-or-death thing on Mareth, and my stuff is more often than not which separates people to meet an unfortunate end at the hands of a demon or a minotaur.</i>\"\n\n");
			if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow" || player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle") outputText("\"<i>Recently, I’ve come in contact with some old fools from...how in hell’s name that place called, JaChinDau? that told me how to make strong materials for their ranged weapons. Those are all the rage there, since they allow a weaker fighter to defeat a stronger one, as long as he has some focus on his hands. I’ve learned about how sharpen arrows and javelins, and make this hollow metal balls that those ‘gun’ things makes use of.</i>\"\n\n");
			if (flags[kFLAGS.KONSTANTIN_SERVICES] >= 3) outputText("\"<i>Also, since you’ve brought me some quite weird stuff to work with, I had to remove the dust from some old manuals about how handle magical and non-metal materials, and how turn them on solid plates and pieces of armor.</i>\"\n\n");
			outputText("Curious, you ask him how hard was reaching his level of skill in smithing, and if he’s happy with his current situation.\n\n");
			outputText("\"<i>Metalworking is a life-time office, {player name}. Becoming a successful one takes years as an apprentice and some luck to get on your paws. ");
			if (player.hasPerk(PerkLib.HistorySmith) >= 0 || player.hasPerk(PerkLib.PastLifeSmith) >= 0) outputText("You have to agree with him on this, as your years working as the smith apprentice taught you. ");
			outputText("Once you’ve got the essentials, you have to find a place and a good clientele. You gave me a place in the camp, and you ");
			if (camp.companionsCount() >= 2) outputText("and the others ");
			outputText("make decent customer");
			if (camp.companionsCount() >= 2) outputText("s");
			if (player.statusEffectv1(StatusEffects.TelAdre) >= 1 || flags[kFLAGS.BAZAAR_ENTERED] > 0) {
				outputText(". Hell, even some of those guys from ");
				if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText("Tel’Adre");
				if (player.statusEffectv1(StatusEffects.TelAdre) >= 1 && flags[kFLAGS.BAZAAR_ENTERED] > 0) outputText(" and ");
				if (flags[kFLAGS.BAZAAR_ENTERED] > 0) outputText("that weird Bazaar");
			outputText(" come frequently, since their smiths don’t sharpen their weapons as good as me. So, for all that, you have my gratitude, my services, and above all, my friendship");
			}
			outputText(".</i>\"\n\nThanking him for his conversation, you leave Konstantin to his own things.\n\n");
			doNext(KonstantinTalkMenu);
		}
		public function KonstantinTalkTheCamp():void {
			clearOutput();
			outputText("\"<i>About the camp, huh, well...</i>\"\n\n");
			if (!buildedAnythingInCamp()) {
				outputText("\"<i>this is a...nice place. A bit lone and far from everything, but the isolated aura can be pleasant sometimes. The bonfire is nice, and though eerie, the portal glow has some use as a mild light.\n\n");
				outputText("Living in a tent is better than I thought, but I’m a bit nervous when working, wary of that a spark could set aflame everything.</i>\"\n\n");
			}
			else {
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) outputText("\"<i>That cabin of yours makes a good reference point for the rest of the camp. Honestly, I’m tempted to make one for myself. Still, my tent is nice enough, but if we’re having to stay here, a more permanent settlement wouldn’t hurt.</i>\"\n\n");
				if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100) {
					outputText("\"<i>Seems like those pesky imps will have a harder time getting us in our sleep. I’ll miss the chance of smashing the skull of one or two, but I’d rather have you");
					if (camp.companionsCount() >= 2) outputText(" and the others safe");
					outputText(".</i>\"\n\n");
				}
				else if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 && flags[kFLAGS.CAMP_WALL_SKULLS] >= 15) outputText("\"<i>Only a fool of an imp would get near our camp, given the skull-themed decoration on the wall. I bet than even the incubus and succubus are cowed of coming near. Everything feels safer with them sheltering us.</i>\"\n\n");
				if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) outputText("\"<i>Given the amount of stuff that is found outside, i was a rather wise choice to get a place for holding all of it. If we’re lucky and, in a couple of years, rain returns as normal, this barren land will become a lush prairie, and we could make our own crops around the camp, and obviously, a place to store our harvest will come on handy.</i>\"\n\n");
				if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4) {
					outputText("\"<i>Nothing as fresh water cleansing your body, huh?");
					if (milkSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) outputText(" Surely beats that weird milk-bath.");
					if (player.hasCock()) outputText(" Though I’ve seen you getting a peek or two at me, not that I mind, perv " + player.mf("guy","girl") + ". If you’re so eager, we could meet alone...");
					outputText("</i>\"\n\n");
				}
				if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) outputText("\"<i>And there is this place where we can spend our excess energy. Quite good, since it also keep us in shape if someday if someday the demons get too cocky and intend to storm our camp.</i>\"\n\n");
				outputText("\"<i>So all in all, I think that this is a great places. Good company, no demons in the proximity, and a great potential for the years to come.</i>\"\n\n");
			}
			doNext(KonstantinTalkMenu);
		}
		
		public function KonstantinCraftingMenu():void {
			clearOutput();
			outputText("Seeing how Konstantin is working with armor and plating pieces, you happen to ask him if he could assemble some of the materials that you’ve found during your travels in Mareth into something useful to wear and protect yourself.\n\n");
			if (player.hasItem(useables.GREENGL) || player.hasItem(useables.B_CHITN) || player.hasItem(useables.T_SSILK)) {
				if (player.hasItem(useables.GREENGL)) {
					outputText("He looks over you bag’s contents, noticing a glimpse of the gel-like substance on it.\n\n");
					outputText("\"<i>Hmm, seems like you’ve got a sample of those strange goo creatures that dwell around the lake these days. While they’re not in my exact area of expertise, I’ve found that those goo remains can become solid is exposed to the right chemicals under a particular temperature, probably due some innate property of the creatures that it comes from. Solid enough to make up for a pretty resilient armor, and flexible enough to deflect blows. If you wish, I can turn them into a protective armor for you, though I’ll require a larger amount, something like, five samples.</i>\"\n\n");
				}
				if (player.hasItem(useables.B_CHITN)) {
					outputText("Catching a glimpse of the piece of black chitin among your stuff, Konstantin remarks: ");
					outputText("\"<i>That’s some carapace that probably fell off from those creepy bee creatures from the forest. Strong, flexible and durable, it won’t be hard for me to make a decent armor from those things. If you’re interested, ring me five, and I’ll make you one.</i>\"\n\n");
				}
				if (player.hasItem(useables.T_SSILK)) {
					outputText("\"<i>How in the demon’s name you managed to get a piece of this silk? So far, it’s only produced by those disgusting, spider-like creatures from a mucky swamp quite far from there. That means, that either you beat the crap out of one of those fuckers, or you found a lost strand of this thing somewhere. Either way congratulations, as this is a very rare material. In fact, I can make a great piece of armor with it, but since i’ll have to buy some chemicals to make the thing sturdy without losing its flexible and soft properties, the price is gonna be a little higher this time.</i>\"\n\n");
					outputText("\"<i>Taking a different approach, I could give it some basic plating, and then weaving the silk thread into a set of magical robes. but this would require some aid from a tailor and a caster, which also is gonna increase the price. In both cases, I’ll require 500 gems, and a total of 5 pieces of silk to make enough thread.</i>\"\n\n");
				}/*
				if (player.hasItem(useables.D_SCALE)) {
					outputText("\"<i>So all in all, I think that this is a great places.</i>\"\n\n");
					outputText("Seeing how Konstantin is working with armor and plating pieces.\n\n");
				}*///EBONBLO		WT_BRAN		TBAPLAT		DBAPLAT
			}
			else {
				outputText("With a sigh, Konstantin tells you that nothing of you’ve brought him is useful to make a durable outfit, as they either lack the composition or the properties to be properly crafted.\n\n");
				outputText("A bit disappointed, you retrieve you pack, guessing which items you should get this time.\n\n");
			}
			menu();
			if (player.hasItem(useables.GREENGL)) addButton(0, "Gel", KonstantinCraftingGelArmor);
			if (player.hasItem(useables.B_CHITN)) addButton(1, "Chitin", KonstantinCraftingChitinArmor);
			//if (player.hasItem(useables.T_SSILK)) addButton(2, "S.Silk", KonstantinTalkTheCamp);
			//if (player.hasItem(useables.D_SCALE)) addButton(3, "The camp", KonstantinTalkTheCamp);
			addButton(14, "Back", KonstantinMainCampMenu);
		}
		
		public function KonstantinCraftingNotEnoughMaterials():void {
			clearOutput();
			outputText("\"<i>Nah, " + player.mf("man","girl") + ". I’ll need more of that stuff to start doing something. Five pieces, as I’ve said. If you happen to gather them somehow, look for me and we’ll work something.</i>\"\n\n");
		}
		public function KonstantinCraftingGelArmor():void {
			if (player.hasItem(useables.GREENGL, 5)) {
				clearOutput();
				outputText("Konstantin then takes the green gel from your bags and pours it into a large pot of glistening steel. Humming to himself, he proceeds to add some liquids and metal-looking powders, and then closes the pot, after what he puts it inside a small furnace. Even from outside, you manage to hear how the mix boils and bubbles inside the pot.\n\n");
				outputText("After a couple of minutes, during which Konstantin has been busy taking your measurements, the bear-smith takes the pot out of the furnace and after cooling with clean water, he pours the hot fluid into several molds placed on one of his workbenches. The substance solidifies quickly, and once it has become air-temperature, he smoothen the blemishes and turns them into beautiful emerald plates.\n\n");
				outputText("Grabbing a mannequin that he has nearby for armor making purposes, he assembles a chest piece, a set of arm guards, shoulder and leg protections and even a couple of ornaments from the emerald plates. Once he’s finished your bear friend presents to you the brand new set of glistening gel armor.\n\n");
				player.destroyItems(useables.GREENGL, 5);
				//if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				inventory.takeItem(armors.GELARMR, KonstantinMainCampMenu);
			}
			else KonstantinCraftingNotEnoughMaterials();
		}
		public function KonstantinCraftingChitinArmor():void {
			if (player.hasItem(useables.B_CHITN, 5)) {
				clearOutput();
				outputText("The bear takes the chitin plates and gets to work on them on one of his bench, tools getting busy cutting smoothing and polishing each piece into a proper plate able to belong to a protective armor. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantine calls you so you can examine the finished piece.\n\n");
				outputText("The plates shine and shimmer like black steel.  He has used the yellow chitin to add accents and embroidery to the plates with a level of detail and craftsmanship rarely seen back home. A yellow fur neck lining has been fashioned from hairs found on the pieces.  The armor includes a breastplate, shoulder guards, full arm guards, and knee high boots, as well a pair of cuisses and graves.\n\n");
				player.destroyItems(useables.B_CHITN, 5);
				//if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				inventory.takeItem(armors.BEEARMR, KonstantinMainCampMenu);
			}
			else KonstantinCraftingNotEnoughMaterials();
		}
	}
}