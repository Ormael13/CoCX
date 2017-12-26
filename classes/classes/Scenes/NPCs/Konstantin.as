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
				outputText("\"<i>So, you’re one of those brave and mighty explorers wanting to cleanse every bit of demon ichor of Mareth?</i>\" he says, a bit amused. \"<i>You’re quite a rare sight these days. Anyways friend, I have my furnace working, and if you’re what you’re saying, you may require my services.</i>\"\n\n");
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
				outputText("You take the [armor] and hand it to Konstantin. He starts working on it, idly whistling while you patiently sit on the nearby tree stump.\n\n");
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
				outputText("Handing the [weapon] to the bear smith, you hop on the tree stump while he gets to work. Konstantin goes to his anvil, where he examines your weapon and figures how he is going to work with it.\n\n");
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
			outputText("Arriving on the barren land surrounding your camp, you easily spot the purple glow of the portal from afar, and point it to Konstantin. He hurries up to catch you, and soon, you’re next to your tent, helping him to unpack his stuff.  With him are several boxes, enormous even for his size, that have his working tools, as well as the tent he has and probably other personal stuff.\n\n");
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
			addButton(2, "Blacksmithing", KonstantinCraftingMenu);
			//addButton(3, "Sex", KonstantinSexMenu);
			addButton(14, "Leave", camp.campFollowers);
		}
		
		public function KonstantinAppearance():void {
			clearOutput();
			outputText("Konstantin is a 8ft 10in tall bear-morph. He has a thick, soft layer of caramel brown fur covering almost every bit of his body, except on his underbelly, where the brown acquires a sandy coloration. The overall fluffy look of his fur makes you immediately think of a giant teddy bear. He covers himself in a simple, white cotton shirt, and covers his lower body with a working overall. Girding his ursine feet he has two black, sturdy boots. When he’s not working he opts for using an attire which is a bit more relaxed, with a loose, colorful shirt and baggy shorts.\n\n");
			outputText("His face is the one of an anthro bear, with the usual muzzle ending in a big, triangular black nose. Two round, ursine ears are placed at each side of his head. His eyes have an amber coloration, and the gentle look that emanates from them is a bit heartwarming. The short, brown hair at his head is almost indistinguishable from his fur unless you get very close. His arms are fully covered in caramel fur, ending in bear-like hands with black paw pads and short claws that don’t seem to hinder his work in any way.\n\n");
			outputText("Strong muscles lie beneath his chest, still, he has a bit of a belly, due his ursine nature, but not enough to be too noticeable under his fluffy fur. Being in such a good physical condition, it’s no wonder how strong he looks. His hips, albeit boyish, are a bit thicker due to his frame. A small, stubby and furred tail rest over his buttcheecks. He has paw like-legs that are covered in a coat of caramel fur, his feet end in black soles with paw pads. The claws at the end of his toes aren’t a nuisance to find good footwear, thankfully.\n\n");
			outputText("He has a strong, manly chest, with a small, pink nipple on each one of his pecs.\n\n");
			outputText("You’ve noticed that he usually wears a set of white, cotton undies, underneath what is a massive 22 inches package, ready to wreck anyone brave enough to try it out. It has an humanoid shape, albeit black in color and lying in a protective furred sheath instead of a foreskin. Just below, a duo of 5 inches wide nuts hang freely, bouncing as he walks when not covered by his undies.\n\n");
			outputText("Between his nice derriere, Konstantin has a tight-looking anus, right where it belongs.");
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
			outputText("\"<i>Metalworking is a life-time office, [name]. Becoming a successful one takes years as an apprentice and some luck to get on your paws. ");
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
					if (flags[kFLAGS.KONSTANTIN_SERVICES] >= 5) outputText("\"<i>Alternatively, if you want, an undergarment, I could made cloth for a shirt, a bra, a loincloth and even a set of panties. The material necessary for any of them would be less, only 2 strands of silk, but, since the chemical process is the same, I’ll still require the 500 gems.</i>\"\n\n");
				}
				if (player.hasItem(useables.D_SCALE)) {
					outputText("Konstantin carefully examines the dragonscale that you are storing on your pack. \"<i>Dragons in Mareth are a virtually extinct race");
					if (emberScene.followerEmber()) outputText(", well, except for the one with us, so the chances of find one of those are pretty slim");
					outputText(".</i>\"\n\n\"<i>Those things are quite tough, and with enough of them I could make an armor with exceptional defensive properties, and much less heavy than your standard platemail. If you’re not feeling on the mood of using a plate armor, I could get my hands on some magically enhanced linen cloth, and use the scales as reinforcement and decoration, thus creating a strong and comfortable set of robes. Since plate requires a lot of material, and I’d like to buy the cloth for the robes selling the remainder scales, I’ll have to ask you for 5 pieces of dragonscale in both cases.</i>\"\n\n");
					if (flags[kFLAGS.KONSTANTIN_SERVICES] >= 5) outputText("\"<i>If you happened to like a smaller piece, I could assemble and undergarment for you, say, a bra, or a vest for your upper body, and a thong or a loincloth for your lower parts. Since we’re speaking of less cloth, I could do it with only 2 pieces of dragon scale.</i>\"\n\n");
				}
				if (player.hasItem(useables.EBONBLO)) {
					outputText("You bear friend seems genuinely surprised by the strange, black bloom that you plucked not long ago.\n\n");
					outputText("\"<i>Ebonbloom? If memory doesn’t fail me, it’s a flower with metal-like properties that grows in very remote sections of Mareth mountainous system, often found in crevices resting near almost vertical cliffs, or volcanic craters. No surprise that few people have seen one, and even less have gotten them on hand. I’m not an expert, so most of this stuff's properties are mystery for me too. The one thing I know for sure is that it’s quite durable, and very reactive to the right chemicals.</i>\"\n\n");
					outputText("\"<i>Now that you have one sample, I could follow a process of metal casting, and bond the flower petals with a magically enhanced metal. From what I’ve studied, the metal that comes from those strange things has an oily texture, but it’s extremely durable. Another good thing about them Ebonblooms is that they’re quite malleable, so, with sufficient materialI I could grab the petals and laminate them together into a proper cloth, in case of that you’d opted by a robe or something similar.</i>\"\n\n");
					outputText("\"<i>In both cases I would need a good amount of them, say, 8 pieces.</i>\"\n\n");
					if (flags[kFLAGS.KONSTANTIN_SERVICES] >= 5) {
						outputText("\"<i>Now, if you happen to like an undergarment, I could make one for you, say, a vest or a corset for your upper body and a thong or a jock for your lower parts. I can even enhance the properties of the latter ones.</i>\"\n\n");
						outputText("\"<i>This would require a bit less Ebonbloom, maybe 3 pieces for each undergarment.</i>\"\n\n");
					}
				}//WT_BRAN
				if (player.hasItem(useables.DBAPLAT)) {
					outputText("You show him the pieces of glowing-white, thick bark.\n\n");
					outputText("\"<i>Funny thing.</i>\" Konstantin retorts. \"<i>I heard a feminine voice on my head asking me to craft a thing out of this. Voice said that she was Marae, and that she gave it as a reward to a brave warrior or so.</i>\"\n\n");
					outputText("Really?\n\n");
					outputText("\"<i>Yeah. Listen, I usually don’t buy the deities nonsense, but If you’d like, I could do as the voice asked and try to carve an armour out of this thing. It seems sturdy and flexible enough for most battlefields.</i>\"\n\n");
				}
				if (player.hasItem(useables.TBAPLAT)) {
					outputText("You show him the pieces of thick bark with tentacles attached.\n\n");
					outputText("\"<i>The fuck is that?</i>\" Konstantin retorts, a bit creeped out by how some of the tentacles are still moving and wiggling. \"<i>I’ve worked on strange materials before, but that thing seems almost alive on their own. Are you sure that this is safe to be used on an armor?</i>\"\n\n");
					outputText("You proceed to explain him how you managed to get your hand on those bark pieces, and after you clarify a couple of doubts of his about the material’s nature, he takes the bark from you and nods.\n\n");
					outputText("\"<i>Well, I think that I can work with that.</i>\" he answers, giving the lying bark a glance.\n\n");
				}
			}
			else {
				outputText("With a sigh, Konstantin tells you that nothing of you’ve brought him is useful to make a durable outfit, as they either lack the composition or the properties to be properly crafted.\n\n");
				outputText("A bit disappointed, you retrieve you pack, guessing which items you should get this time.\n\n");
			}
			menu();
			if (player.hasItem(useables.GREENGL)) addButton(0, "Gel", KonstantinCraftingGelArmor);
			if (player.hasItem(useables.B_CHITN)) addButton(1, "Chitin", KonstantinCraftingChitinItems);
			if (player.hasItem(useables.T_SSILK) && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] < 1) addButton(2, "SpiderSilk", KonstantinCraftingSpiderSilkItems);
			if (player.hasItem(useables.D_SCALE) && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] < 1) addButton(3, "Dragonscale", KonstantinCraftingDragonscaleItems);
			if (player.hasItem(useables.EBONBLO) && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] < 1) addButton(4, "Ebonbloom", KonstantinCraftingEbonbloomItems);
			if (player.hasItem(useables.DBAPLAT)) addButton(8, "T.Bark Armor", KonstantinCraftingDivineBarkArmor);
			if (player.hasItem(useables.TBAPLAT)) addButton(9, "D.Bark Armor", KonstantinCraftingTentacledBarkArmor);
			//if (player.hasItem(useables.TBAPLAT) && player.hasItem(weapons.W_STAFF)) addButton(10, "Puritas", );
			//if (player.hasItem(useables.DBAPLAT) && player.hasItem(weapons.W_STAFF)) addButton(11, "Depravatio", );
			//if ((player.hasItem(useables.TBAPLAT) && player.hasItem(weapons.PURITAS)) || (player.hasItem(useables.DBAPLAT) && player.hasItem(weapons.DEPRAVA))) addButton(12, "Ascensus", );
			addButton(14, "Back", KonstantinMainCampMenu);
		}//usunąć fragmenty " && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] < 1" jak sie całkiem przeniesie crafting z Ratha do Kona
		
		private function KonstantinCraftingNotEnoughMaterials1():void {
			clearOutput();
			outputText("\"<i>Nah, " + player.mf("man", "girl") + ". I’ll need more of that stuff to start doing something. Five pieces, as I’ve said. If you happen to gather them somehow, look for me and we’ll work something.</i>\"\n\n");
			doNext(KonstantinMainCampMenu);
		}
		private function KonstantinCraftingNotEnoughMaterials2():void {
			clearOutput();
			outputText("\"<i>Nah, " + player.mf("man", "girl") + ". I’ll need more of that stuff to start doing something. Two pieces, as I’ve said. If you happen to gather them somehow, look for me and we’ll work something.</i>\"\n\n");
			doNext(KonstantinMainCampMenu);
		}
		private function KonstantinCraftingNotEnoughMaterials3():void {
			clearOutput();
			outputText("\"<i>Nah, " + player.mf("man", "girl") + ". I’ll need more of that stuff to start doing something. Eight pieces, as I’ve said. If you happen to gather them somehow, look for me and we’ll work something.</i>\"\n\n");
			doNext(KonstantinMainCampMenu);
		}
		private function KonstantinCraftingNotEnoughMaterials4():void {
			clearOutput();
			outputText("\"<i>Nah, " + player.mf("man", "girl") + ". I’ll need more of that stuff to start doing something. Three pieces, as I’ve said. If you happen to gather them somehow, look for me and we’ll work something.</i>\"\n\n");
			doNext(KonstantinMainCampMenu);
		}
		private function KonstantinCraftingGelArmor():void {
			if (player.hasItem(useables.GREENGL, 5)) {
				clearOutput();
				outputText("Konstantin then takes the green gel from your bags and pours it into a large pot of glistening steel. Humming to himself, he proceeds to add some liquids and metal-looking powders, and then closes the pot, after what he puts it inside a small furnace. Even from outside, you manage to hear how the mix boils and bubbles inside the pot.\n\n");
				outputText("After a couple of minutes, during which Konstantin has been busy taking your measurements, the bear-smith takes the pot out of the furnace and after cooling with clean water, he pours the hot fluid into several molds placed on one of his workbenches. The substance solidifies quickly, and once it has become air-temperature, he smoothen the blemishes and turns them into beautiful emerald plates.\n\n");
				outputText("Grabbing a mannequin that he has nearby for armor making purposes, he assembles a chest piece, a set of arm guards, shoulder and leg protections and even a couple of ornaments from the emerald plates. Once he’s finished your bear friend presents to you the brand new set of glistening gel armor.\n\n");
				player.destroyItems(useables.GREENGL, 5);
				if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				inventory.takeItem(armors.GELARMR, KonstantinMainCampMenu);
			}
			else KonstantinCraftingNotEnoughMaterials1();
		}
		private function KonstantinCraftingChitinItems():void {
			if (player.hasItem(useables.B_CHITN, 5)) {
				clearOutput();
				outputText("The bear takes the chitin plates and gets to work on them on one of his bench, tools getting busy cutting smoothing and polishing each piece into a proper plate able to belong to a protective armor. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you so you can examine the finished piece.\n\n");
				outputText("The plates shine and shimmer like black steel.  He has used the yellow chitin to add accents and embroidery to the plates with a level of detail and craftsmanship rarely seen back home. A yellow fur neck lining has been fashioned from hairs found on the pieces.  The armor includes a breastplate, shoulder guards, full arm guards, and knee high boots, as well a pair of cuisses and graves.\n\n");
				player.destroyItems(useables.B_CHITN, 5);
				if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				inventory.takeItem(armors.BEEARMR, KonstantinMainCampMenu);
			}
			else KonstantinCraftingNotEnoughMaterials1();
		}
		private function KonstantinCraftingSpiderSilkItems():void {
			if (player.gems < 500) {
				outputText("  <b>Wait... you don't even have 500 gems.  Damn.</b>");
				doNext(KonstantinMainCampMenu);
				return;
			}
			menu();
			addButton(0, "Armor", KonstantinCraftingSpiderSilkItems2, 1, null, null, armors.SSARMOR.description);
			addButton(1, "Robes", KonstantinCraftingSpiderSilkItems2, 2, null, null, armors.SS_ROBE.description);
			addButton(2, "Indec.R.", KonstantinCraftingSpiderSilkItems2, 3, null, null, armors.INDESSR.description);
			if (flags[kFLAGS.KONSTANTIN_SERVICES] >= 5) {
				addButton(5, "Bra", KonstantinCraftingSpiderSilkItems2, 4, null, null, undergarments.SS_BRA.description);
				addButton(6, "Shirt", KonstantinCraftingSpiderSilkItems2, 5, null, null, undergarments.SSSHIRT.description);
				addButton(7, "Panties", KonstantinCraftingSpiderSilkItems2, 6, null, null, undergarments.SSPANTY.description);
				addButton(8, "Loincloth", KonstantinCraftingSpiderSilkItems2, 7, null, null, undergarments.SS_LOIN.description);
			}
		}
		private function KonstantinCraftingSpiderSilkItems2(spidersilkType:int):void {
			if (spidersilkType == 1 || spidersilkType == 2 || spidersilkType == 3) { //Armor or robes
				if (player.hasItem(useables.T_SSILK, 5)) {
					clearOutput();
					player.destroyItems(useables.T_SSILK, 5);
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = spidersilkType;
				}
				else KonstantinCraftingNotEnoughMaterials1();
			}
			else { //Undergarments
				if (player.hasItem(useables.T_SSILK, 2)) {
					clearOutput();
					player.destroyItems(useables.T_SSILK, 2);
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = spidersilkType;
				}
				else KonstantinCraftingNotEnoughMaterials2();
			}
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] > 0) {
				player.gems -= 500;
				statScreenRefresh();
				var itype:ItemType;
				switch(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275]) {
				case 1: //Armor
				//	outputText(images.showImage("rathazul-craft-silkarmor"));
					outputText("A glittering white suit of armor sits atop a crude armor rack, reflecting the light that plays across its surface beautifully.  You definitely didn't expect anything like this!  It looks nearly identical to a set of light plate mail, though instead of having a cold metal surface, the armor feels slightly spongy, with just a little bit of give in it. The snow-white surface has gold ornaments that, on a closer examination, are actually weaved into the spongy plates.\n\n");
					outputText("Grinning behind you, Konstantin states proudly. \"<i>Look great, don’t they? The armor-making process was quite difficult at start, but at the end I got my hands in a strong armor made of white electrum, and since that metal is quite reactive, I was able to weave the silk into it easily, and due the metal properties, imbibe the silk with the strength and resistance of the metal without losing its flexibility, With the extra gems I bought some gold thread to give the thing a more, you know, knightley appearance.</i>\"\n\n");
					itype = armors.SSARMOR;
					break;
				case 2: //Robes
				//	outputText(images.showImage("rathazul-craft-silkrobes"));
					outputText("Hanging from a small rack is a long, flowing robe. It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric, the pure while of it’s cloth complimented majestically by the golden embroidery.  You run your fingers over the silken garment, feeling the soft material give at your touch.  There's a hood with a golden border embroidered around the edge.  For now, it hangs limply down the back, but it would be easy to pull up in order to shield the wearer's eyes from harsh sunlight or rainy drizzle.  ");
					outputText("The sleeves match the cowl, circled with intricate threads made in gold and laid out in arcane patterns.\n\nKonstantin smiles as you delight yourself looking at the marvelously crafted garment. Once you’re done carefully takes it and hands it to you.\n\n");
					outputText("\"<i>" + player.mf("Man", "Girl") + ", this is quite a piece, isn’t? I struck a good deal with the weaver so I got extra gold embroidery. The cloth is soft, but don't let it fool you. This thing is almost as strong as any armor that I could’ve made, and the magical properties of the weaving will come on handy whenever you’re using spells.</i>\"\n\n");
					itype = armors.SS_ROBE;
					break;
				case 3: //Indec.Robes
				//	outputText(images.showImage("rathazul-craft-silkindecentrobes"));
					outputText("Hanging from a small rack is a long, flowing robe. It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric. Upon closer inspection, you realize that the robe is more of a longcoat, meant to display your chest and groin. You run your fingers over the silken garment, feeling the soft material give at your touch.  There’s a hood around the edge, for now, it hangs limply down the back, but it would be easy to pull up in order to shield the wearer’s eyes from harsh sunlight or rainy drizzle.\n\n");
					outputText("Moving your hands through it, you find a layer of spider silk straps lining the inside, likely to keep the front of the robe open and preventing this from disrupting the balance of the wearer. The straps are so subtle that you doubt you will notice them while wearing the robe.\n\n");
					outputText("Konstantin gingerly takes down the garment and hands it to you. \"<i>This robe can look and feel soft, but I assure you, this thing is made of one of the most durable clothes in Mareth. The strands of silk made it stronger than many armors, and the properties of the material can be useful to aid your spell-casting as well.</i>\"\n\n");
					itype = armors.INDESSR;
					break;
				case 4: //Bra
				//	outputText(images.showImage("rathazul-craft-silkbra"));
					outputText("On a table is a pair of white bra.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.\n\n");
					outputText("Konstantin gingerly takes the garment and hands it to you. \"<i>This bra can look and feel soft, but I assure you, this thing is made of one of the most durable clothes in Mareth. The strands of silk made it quite comfortable as well.</i>\"\n\n");
					itype = undergarments.SS_BRA;
					break;
				case 5: //Shirt
				//	outputText(images.showImage("rathazul-craft-silkshirt"));
					outputText("On a table is a pair of white shirt.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.\n\n");
					outputText("Konstantin gingerly takes the garment and hands it to you. \"<i>This shirt can look and feel soft, but I assure you, this thing is made of one of the most durable clothes in Mareth. The strands of silk made it quite comfortable as well.</i>\"\n\n");
					itype = undergarments.SSSHIRT;
					break;
				case 6: //Panties
				//	outputText(images.showImage("rathazul-craft-silkpanties"));
					outputText("On a table is a pair of white panties.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.\n\n");
					outputText("Konstantin gingerly takes the garment and hands it to you. \"<i>Those panties can look and feel soft, but I assure you, this thing is made of one of the most durable clothes in Mareth. The strands of silk made it quite comfortable as well.</i>\"\n\n");
					itype = undergarments.SSPANTY;
					break;
				case 7: //Loincloth
				//	outputText(images.showImage("rathazul-craft-silkloincloth"));
					outputText("On a table is a white loincloth. It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.\n\n");
					outputText("Konstantin gingerly takes the garment and hands it to you. \"<i>This loincloth can look and feel soft, but I assure you, this thing is made of one of the most durable clothes in Mareth. The strands of silk made it quite comfortable as well.</i>\"\n\n");
					itype = undergarments.SS_LOIN;
					break;
				default:
					outputText("Something bugged! Please report this bug to Ormael/Aimozg/Oxdeception.");
					itype = armors.SS_ROBE;
				}
				if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = 0;
				inventory.takeItem(itype, KonstantinMainCampMenu);
			}
		}
		private function KonstantinCraftingDragonscaleItems():void {
			menu();
			addButton(0, "Armor", KonstantinCraftingDragonscaleItems2, 1, null, null, armors.DSCLARM.description);
			addButton(1, "Robes", KonstantinCraftingDragonscaleItems2, 2, null, null, armors.DSCLROB.description);
			addButton(2, "Indec.R.", KonstantinCraftingDragonscaleItems2, 3, null, null, armors.INDEDSR.description);
			if (flags[kFLAGS.KONSTANTIN_SERVICES] >= 5) {
				addButton(5, "Bra", KonstantinCraftingDragonscaleItems2, 4, null, null, undergarments.DS_BRA.description);
				addButton(6, "Vest", KonstantinCraftingDragonscaleItems2, 5, null, null, undergarments.DS_VEST.description);
				addButton(7, "Thong", KonstantinCraftingDragonscaleItems2, 6, null, null, undergarments.DSTHONG.description);
				addButton(8, "Loincloth", KonstantinCraftingDragonscaleItems2, 7, null, null, undergarments.DS_LOIN.description);
			}
		}
		private function KonstantinCraftingDragonscaleItems2(dragonscaleType:int):void {
			if (dragonscaleType == 1 || dragonscaleType == 2 || dragonscaleType == 3) { //Armor or robes
				if (player.hasItem(useables.D_SCALE, 5)) {
					clearOutput();
					player.destroyItems(useables.D_SCALE, 5);
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = dragonscaleType;
				}
				else KonstantinCraftingNotEnoughMaterials1();
			}
			else { //Undergarments
				if (player.hasItem(useables.D_SCALE, 2)) {
					clearOutput();
					player.destroyItems(useables.D_SCALE, 2);
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = dragonscaleType;
				}
				else KonstantinCraftingNotEnoughMaterials2();
			}
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] > 0) {
				statScreenRefresh();
				var itype:ItemType;
				switch(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275]) {
				case 1: //Armor
				//	outputText(images.showImage("rathazul-craft-silkarmor"));
					outputText("The bear takes the dragon scales and sets up on his workbench for an hour while you wait. You can hear his tools cutting, smoothing and polishing each piece into a proper plate able to belong to a protective armor. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you over, so you can examine the finished piece.\n\n");
					outputText("\"<i>Finished," + player.mf("man", "girl") + "</i>\" he says, smiling warmly. \"<i>Turned out awesome, modesty aside. Come on, take a look.</i>\"\n\n");
					outputText("Once you come to see it, you get the sight of a magnificently crafted plate armor resting over one of the mannequins. It’s made of a set of plates forming a cuirass, a back piece, shoulder and arm protections, as well as a pair of cuisses and greaves. The copper-like coloration of the scales visible among the plates, combined with their characteristic shape, and the gold and brass trim that your bear friend has smithen them with give this set of armor a truly imposing look.\n\n");
					outputText("Testing it, you find that it's much lighter than any other similar plated armor that you’ve used before. This surely come in handy when you require of a bit more of mobility and speed in the heat of the battle. You thank Konstantin, and collect your new armor.\n\n");
					itype = armors.DSCLARM;
					break;
				case 2: //Robes
				//	outputText(images.showImage("rathazul-craft-silkrobes"));
					outputText("The bear takes the dragon scales and sets up on his workbench for an hour while you wait. You can hear his tools cutting, smoothing and polishing each piece into a proper plate able to belong to a protective outfit. Every now and then you manage to hear cloth being cut and a hissing sound, like boiling water poured over a cold surface. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you over, so you can examine the finished piece.\n\n");
					outputText("\"<i>Finished," + player.mf("man", "girl") + "</i>\" he says, smiling warmly. \"<i>Turned out awesome, modesty aside. Come on, take a look.</i>\"\n\n");
					outputText("Once you come to see it, you get the sight of a magnificently crafted set of robes resting over one of the mannequins. They’re made of copper-colored scales as cover, with a brass and gold trim, and a inner cloth made of crimson linen. The scales are and flexible enough to flow with the linen without issue. Runic marks in embroidered gold are placed along the cloth of the neck and back.\n\n");
					itype = armors.DSCLROB;
					break;
				case 3: //Indec.Robes
				//	outputText(images.showImage("rathazul-craft-silkrobes"));
					outputText("The bear takes the scales and works on his bench for an hour while you wait, polishing and sewing the material. Once he has finished, Konstantin calls you over, \"<i>Hey, " + player.mf("man", "girl") + " your piece if finished. I’m sure that you’ll be happy with how it turned. Take a look.</i>\"\n\n");
					outputText("As you retrieve the piece from him, you notice how the robe is red and appears to be textured with scales.  You touch it and feel the particular texture, but on the inside of the cloth, what seems and feels like velvet has taken over the scaly sensation.\n\n");
					outputText("\"<i>The dragon scales gave it a nice texture.</i>\" Konstantin says \"<i>I added some cloth on the inside so it won’t be too rough at touch. Overall, it should be quite comfortable and protective.</i>\"\n\n");
					itype = armors.INDEDSR;
					break;
				case 4: //Bra
				//	outputText(images.showImage("rathazul-craft-dragonscalebra"));
					outputText("The bear takes the scales and works on his bench for an hour while you wait, polishing and sewing the material. Once he has finished, Konstantin calls you over, \"<i>Hey, " + player.mf("man", "girl") + " your piece if finished. I’m sure that you’ll be happy with how it turned. Take a look.</i>\"\n\n");
					outputText("As you retrieve the piece from him, you notice how the bra is copper-colored, and appears to be textured with scales.  You touch it and feel the particular texture, but on the inside of the cloth, what seems and feels like velvet has taken over the scaly sensation.\n\n");
					outputText("\"<i>The dragon scales gave it a nice texture, and I’ve used leathers straps to maintain the flexibility.</i>\" Konstantin says \"<i>I added some cloth on the inside too, so it won’t be too rough at touch. Overall, it should be quite comfortable and protective.</i>\"\n\n");
					itype = undergarments.DS_BRA;
					break;
				case 5: //Vest
				//	outputText(images.showImage("rathazul-craft-dragonscalevest"));
					outputText("The bear takes the scales and works on his bench for an hour while you wait, polishing and sewing the material. Once he has finished, Konstantin calls you over, \"<i>Hey, " + player.mf("man", "girl") + " your piece if finished. I’m sure that you’ll be happy with how it turned. Take a look.</i>\"\n\n");
					outputText("As you retrieve the piece from him, you notice how the vest is copper-colored, and appears to be textured with scales.  You touch it and feel the particular texture, but on the inside of the cloth, what seems and feels like velvet has taken over the scaly sensation.\n\n");
					outputText("\"<i>The dragon scales gave it a nice texture, and I’ve used leathers straps to maintain the flexibility.</i>\" Konstantin says \"<i>I added some cloth on the inside too, so it won’t be too rough at touch. Overall, it should be quite comfortable and protective.</i>\"\n\n");
					itype = undergarments.DS_VEST;
					break;
				case 6: //Thong
				//	outputText(images.showImage("rathazul-craft-dragonscalethong"));
					outputText("The bear takes the scales and works on his bench for an hour while you wait, polishing and sewing the material. Once he has finished, Konstantin calls you over, \"<i>Hey, " + player.mf("man", "girl") + " your piece if finished. I’m sure that you’ll be happy with how it turned. Take a look.</i>\"\n\n");
					outputText("As you retrieve the piece from him, you notice how the thong is copper-colored, and appears to be textured with scales.  You touch it and feel the particular texture, but on the inside of the cloth, what seems and feels like velvet has taken over the scaly sensation.\n\n");
					outputText("\"<i>The dragon scales gave it a nice texture, and I’ve used leathers straps to maintain the flexibility.</i>\" Konstantin says \"<i>I added some cloth on the inside too, so it won’t be too rough at touch. Overall, it should be quite comfortable and protective.</i>\"\n\n");
					itype = undergarments.DSTHONG;
					break;
				case 7: //Loincloth
				//	outputText(images.showImage("rathazul-craft-dragonscaleloincloth"));
					outputText("The bear takes the scales and works on his bench for an hour while you wait, polishing and sewing the material. Once he has finished, Konstantin calls you over, \"<i>Hey, " + player.mf("man", "girl") + " your piece if finished. I’m sure that you’ll be happy with how it turned. Take a look.</i>\"\n\n");
					outputText("As you retrieve the piece from him, you notice how the loincloth is copper-colored, and appears to be textured with scales.  You touch it and feel the particular texture, but on the inside of the cloth, what seems and feels like velvet has taken over the scaly sensation.\n\n");
					outputText("\"<i>The dragon scales gave it a nice texture, and I’ve used leathers straps to maintain the flexibility.</i>\" Konstantin says \"<i>I added some cloth on the inside too, so it won’t be too rough at touch. Overall, it should be quite comfortable and protective.</i>\"\n\n");
					itype = undergarments.DS_LOIN;
					break;
				default:
					outputText("Something bugged! Please report this bug to Ormael/Aimozg/Oxdeception.");
					itype = armors.DSCLROB;
				}
				if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = 0;
				inventory.takeItem(itype, camp.returnToCampUseOneHour);
			}
		}
		private function KonstantinCraftingEbonbloomItems():void {
			menu();
			addButton(0, "Platemail", KonstantinCraftingEbonbloomItems2, 1, null, null, armors.EWPLTMA.description);
			addButton(1, "Jacket", KonstantinCraftingEbonbloomItems2, 2, null, null, armors.EWJACK_.description);
			addButton(2, "Robes", KonstantinCraftingEbonbloomItems2, 3, null, null, armors.EWROBE_.description);
			addButton(3, "Indec.R.", KonstantinCraftingEbonbloomItems2, 4, null, null, armors.INDEEWR.description);
		//	if (player.hasItem(useables.EBONBLO, 10) && player.hasItem(armors.H_GARB_, 1) && player.hasKeyItem("Dark Mage’s Grimoire") >= 0) addButton(4, "H. Garb", KonstantinCraftingEbonbloomItems2, 5, null, null, armors.EHGARB_.description);
			if (flags[kFLAGS.KONSTANTIN_SERVICES] >= 5) {
				addButton(5, "Jock", KonstantinCraftingEbonbloomItems2, 6, null, null, undergarments.EW_JOCK.description);
				addButton(6, "Thong", KonstantinCraftingEbonbloomItems2, 7, null, null, undergarments.EWTHONG.description);
				addButton(7, "Vest", KonstantinCraftingEbonbloomItems2, 8, null, null, undergarments.EWTHONG.description);
				addButton(8, "Corset", KonstantinCraftingEbonbloomItems2, 9, null, null, undergarments.EW_VEST.description);
				addButton(10, "R.Jock", KonstantinCraftingEbonbloomItems2, 10, null, null, undergarments.R_JOCK.description);
				addButton(11, "R.Thong", KonstantinCraftingEbonbloomItems2, 11, null, null, undergarments.R_THONG.description);
			}
		}
		private function KonstantinCraftingEbonbloomItems2(ebonbloomType:int):void {
			if (ebonbloomType == 1 || ebonbloomType == 2 || ebonbloomType == 3) { //Armor or robes
				if (player.hasItem(useables.EBONBLO, 8)) {
					clearOutput();
					player.destroyItems(useables.EBONBLO, 8);
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = ebonbloomType;
				}
				else KonstantinCraftingNotEnoughMaterials3();
			}
			else { //Undergarments
				if (player.hasItem(useables.EBONBLO, 3)) {
					clearOutput();
					player.destroyItems(useables.EBONBLO, 3);
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = ebonbloomType;
				}
				else KonstantinCraftingNotEnoughMaterials4();
			}
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] > 0) {
				statScreenRefresh();
				var itype:ItemType;
				switch(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275]) {
				case 1: //Platemail
				//	outputText(images.showImage("rathazul-craft-ebonweaveheavyarmor"));
					outputText("The bear takes the ebonbloom flowers and sets up on his workbench for an hour while you wait. You can hear his tools cutting, smoothing and polishing each piece into a proper plate able to belong to a protective armor. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you so you can examine the finished piece.\n\n");
					outputText("\"<i>I think you'll be pleased with how the thing turned out.</i>\" The bear says, patting you on the shoulder. \"<i>Go ahead and take a look, " + player.mf("man", "girl") + ".</i>\"\n\n");
					outputText("Laid out on a workbench is a set of platemail. The plates barely reflecting the light. As you approach the workbench, you notice that the surface of the black metal appears to have an oily texture. A sliver trim decorated the edges of each plate. The armor is laid out in two layers: a lower layer made of smooth yet resilient ebonweave cloth, covered by ebonweave plating.  Picking up one of the pieces of platemail, you notice that the plate is thin and the armor itself vary light.\n\n");
					outputText("You spot a discarded knife nearby, probably one of Konstantin less used smithing tools, so you take it and experimentally try to damage the breastplate.  After a few whacks, the knife is blunted but the plate shows no damage.  Not even a dent. It appears that the bear-smith wasn’t exaggerating when he told you about the properties ebonbloom could take. Assembling the full set as if to start putting it on, you realize that as light as the armor is, the armor will restrict your range of movement as much as any normal set of platemail would. You thank Konstantin, and collect your new armor.\n\n");
					itype = armors.EWPLTMA;
					break;
				case 2: //Jacket
				//	outputText(images.showImage("rathazul-craft-ebonweavearmor"));
					outputText("The bear takes the ebonbloom flowers and sets up on his workbench for an hour while you wait. You can hear his tools cutting, smoothing and polishing each piece into a proper plate able to belong to a protective armor. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you so you can examine the finished piece.\n\n");
					outputText("\"<i>I think you'll be pleased with how the thing turned out.</i>\" The bear says, patting you on the shoulder. \"<i>Go ahead and take a look, " + player.mf("man", "girl") + ".</i>\"\n\n");
					outputText("Laid out beside Konstantin’s workbench is a longcoat next to a breastplate. Both items are a greasy dark gray. Nearby, there is a similarly colored shirt and a pair of pants on a small rack. You approach the workbench and notice that the surface of the leather has an oily texture. The long coat has a much more natural texture to it than the breastplate. It’s made of leather-- that much, you’re certain, and yet it doesn’t seem like it should be. Perhaps Konstantin bonded the Ebonbloom into a normal jacket, altering the leather’s properties. ");
					outputText("The breastplate is even stranger. It feels like metal, yet is spongy. It bends slightly under your fingers and fills up when you remove your hand. You spot a knife nearby and take it, experimentally try to cut the breastplate. Nothing happens. Even after a few increasingly vigorous attempts, the plate has no marks. You think this armor will work very well. You thank Konstantin and collect your new armor.\n\n");
					itype = armors.EWJACK_;
					break;
				case 3: //Robes
				//	outputText(images.showImage("rathazul-craft-ebonweaverobes"));
					outputText("The bear takes the ebonbloom flowers and sets up on his workbench for an hour while you wait. You can hear his tools cutting, smoothing and polishing each piece into a proper plate able to belong to a protective armor. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you so you can examine the finished piece.\n\n");
					outputText("\"<i>I think you'll be pleased with how the thing turned out.</i>\" The bear says, patting you on the shoulder. \"<i>Go ahead and take a look, " + player.mf("man", "girl") + ".</i>\"\n\n");
					outputText("Hanging on the rack is a long, flowing robe. The black cloth ripples in the wind, but strangely it shines in the light as metal would. You run your fingers over the dark grey garment, feeling the soft (yet slightly slick) material give at your touch. There’s a hood around the edge. For now, it hangs limply down the back, but it would be easy to pull up in order to shield the wearer’s eyes from harsh sunlight or rainy drizzle. ");
					outputText("Beyond the physical, you can feel magical power flow through this robe. This untapped power should be quite helpful when casting magic. You thank Konstantin and collect your new robe.\n\n");
					itype = armors.EWROBE_;
					break;
				case 4: //Indec.Robes
				//	outputText(images.showImage("rathazul-craft-ebonweaveindecentrobes"));
					outputText("The bear takes the ebonbloom flowers and sets up on his workbench for an hour while you wait. You can hear his tools cutting, smoothing and polishing each piece into a proper plate able to belong to a protective armor. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you so you can examine the finished piece.\n\n");
					outputText("\"<i>I think you'll be pleased with how the thing turned out.</i>\" The bear says, patting you on the shoulder. \"<i>Go ahead and take a look, " + player.mf("man", "girl") + ".</i>\"\n\n");
					outputText("Hanging on the rack is a long, flowing robe. The black cloth ripples in the wind, but strangely it shines in the light as metal would. You run your fingers over the dark grey garment, feeling the soft (yet slightly slick) material give at your touch. There’s a hood around the edge. For now, it hangs limply down the back, but it would be easy to pull up in order to shield the wearer’s eyes from harsh sunlight or rainy drizzle. ");
					outputText("Beyond the physical, you can feel magical power flow through this robe. This untapped power should be quite helpful when casting magic. You thank Konstantin and collect your new robe.\n\n");
					itype = armors.INDEEWR;
					break;
				case 6: //Jock
				//	outputText(images.showImage("rathazul-craft-ebonweavejock"));
					outputText("The bear takes the ebonbloom flowers and works on his bench for an hour while you wait.  Once he has finished, Konstantin is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHanging in one of  Konstantin’s racks is a jock. As you inspect it, you notice the black cloth has an oily sheen. ");
					outputText("You run your hand over the garment and see see that the fabric is smoother than Ingram’s finest cloth. And yet, it has a strange slickness to it unlike any fabric you know of. You also note the jock is also elastic, allowing it to fit your form regardless of how large your assets are. You thank Konstantin and collect your new jock.");
					itype = undergarments.EW_JOCK;
					break;
				case 7: //Thong
				//	outputText(images.showImage("rathazul-craft-ebonweavethong"));
					outputText("The bear takes the ebonbloom flowers and works on his bench for an hour while you wait.  Once he has finished, Konstantin is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHanging in one of  Konstantin’s racks is a thong. As you inspect it, you notice the black cloth has an oily sheen. ");
					outputText("You run your hand over the garment and see see that the fabric is smoother than Ingram’s finest cloth. And yet, it has a strange slickness to it unlike any fabric you know of. You also note the thong is also elastic, allowing it to fit your form regardless of how large your assets are. You thank Konstantin and collect your new thong.");
					itype = undergarments.EWTHONG;
					break;
				case 8: //Vest
				//	outputText(images.showImage("rathazul-craft-ebonweavevest"));
					outputText("The bear takes the ebonbloom flowers and works on his bench for an hour while you wait.  Once he has finished, Konstantin is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHanging in one of  Konstantin’s racks is a vest. As you inspect it, you notice the black cloth has an oily sheen. ");
					outputText("You run your hand over the garment and see see that the fabric is smoother than Ingram’s finest cloth. And yet, it has a strange slickness to it unlike any fabric you know of. You also note the vest is also elastic, allowing it to fit your form regardless of how large your assets are. You thank Konstantin and collect your new vest.");
					itype = undergarments.EW_VEST;
					break;
				case 9: //Corset
				//	outputText(images.showImage("rathazul-craft-ebonweavecorset"));
					outputText("The bear takes the ebonbloom flowers and works on his bench for an hour while you wait.  Once he has finished, Konstantin is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHanging in one of  Konstantin’s racks is a corset. As you inspect it, you notice the black cloth has an oily sheen. ");
					outputText("You run your hand over the garment and see see that the fabric is smoother than Ingram’s finest cloth. And yet, it has a strange slickness to it unlike any fabric you know of. You also note the corset is also elastic, allowing it to fit your form regardless of how large your assets are. You thank Konstantin and collect your new corset.");
					itype = undergarments.EW_CORS;
					break;
				case 10: //Rune Jock
				//	outputText(images.showImage("rathazul-craft-ebonweaverunejock"));
					outputText("The bear takes the ebonbloom flowers and works on his bench for an hour while you wait.  Once he has finished, Konstantin is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHanging in one of  Konstantin’s racks is a jock. As you inspect it, you notice the black cloth has an oily sheen. ");
					outputText("Adorning the cup is a rune seething with black magic.  ");
					if (player.hasStatusEffect(StatusEffects.KnowsArouse)) outputText("You blush, recognizing the rune to represent lust.  ");
					outputText("You run your hand over the garment and see see that the fabric is smoother than Ingram’s finest cloth. And yet, it has a strange slickness to it unlike any fabric you know of. You also note the jock is also elastic, allowing it to fit your form regardless of how large your assets are. You thank Konstantin and collect your new jock.");
					itype = undergarments.R_JOCK;
					break;
				case 11: //Rune Thongs
				//	outputText(images.showImage("rathazul-craft-ebonweaverunethong"));
					outputText("The bear takes the ebonbloom flowers and works on his bench for an hour while you wait.  Once he has finished, Konstantin is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHanging in one of  Konstantin’s racks is a thong. As you inspect it, you notice the black cloth has an oily sheen. ");
					outputText("Adorning the front is a rune seething with black magic.  ");
					if (player.hasStatusEffect(StatusEffects.KnowsArouse)) outputText("You blush, recognizing the rune to represent lust.  ");
					outputText("You run your hand over the garment and see see that the fabric is smoother than Ingram’s finest cloth. And yet, it has a strange slickness to it unlike any fabric you know of. You also note the thong is also elastic, allowing it to fit your form regardless of how large your assets are. You thank Konstantin and collect your new thong.");
					itype = undergarments.R_THONG;
					break;
				default:
					outputText("Something bugged! Please report this bug to Ormael/Aimozg/Oxdeception.");
					itype = armors.EWJACK_;
				}
				if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = 0;
				inventory.takeItem(itype, camp.returnToCampUseOneHour);
			}
		}
		private function KonstantinCraftingDivineBarkArmor():void {
			clearOutput();
			outputText("Taking the pile of bark, he goes to his workbench, and starts turning the odd material into plates and armor pieces. Chemicals bathe the bark as he cuts and sews the softer pieces. From time to time you hear Konstantin curses as he has some troubles cutting the largest pieces into plates. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you so you can examine the finished piece.\n\n");
			outputText("The plates are white like snow. Gold ornates the plates and gives the set a holy and magical appearance. The armor includes a breastplate, pauldrons, full arm guards, and knee-high boots, as well as a set of cuisses and greves. A solid, but easily removable codpiece, covers the place where your nethers go.\n\n");
			outputText("The codpiece bulges a little at the weight of your groin, and, if anything it looks a little lewd.  Konstantin smiles and gives you an half-embarrassed shug.");
			if (player.biggestTitSize() >= 8) outputText(" Your " + biggestBreastSizeDescript() + " barely fit into the breastplate, leaving you displaying a large amount of jiggling cleavage.");
			outputText("\n\nYou thank Konstantin for the armor, especially since it was hard to work with, and return to your duties.");
			player.destroyItems(useables.DBAPLAT, 1);
			if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
			inventory.takeItem(armors.DBARMOR, camp.returnToCampUseOneHour);
		}
		private function KonstantinCraftingTentacledBarkArmor():void {
			clearOutput();
			outputText("Taking the pile of bark, he goes to his workbench, and starts turning the odd material into plates and armor pieces. Chemicals bathe the bark as he cuts and sews the softer pieces. The occasional grabby tentacle is quickly put down by a well placed hammer hit. Surprisingly, the entire process takes less than an hour, and once it’s finished, Konstantin calls you so you can examine the finished piece.\n\n");
			outputText("The plates are white like snow. Green tentacles grow from the shoulderpads. The armor includes a breastplate, pauldrons, full arm guards, and knee-high boots, as well as a set of cuisses and greves. You realize the armor is missing a solid codpiece, a white piece of embroidered silk covering the place where your nethers go.\n\n");
			outputText("\"<i>Huh, that?</i>\" Konstantin say knowingly. \"<i>The tentacles didn’t let me put something solid there no matter how much I smashed them, so I had to settle with that. Hope that you don’t mind.</i>\"\n\n");
			outputText("The silken material does little to hide the bulge of your groin, if anything it looks a little lewd.  Konstantin smiles and gives you an half-embarrassed shug.");
			if (player.biggestTitSize() >= 8) outputText(" Your " + biggestBreastSizeDescript() + " barely fit into the breastplate, leaving you displaying a large amount of jiggling cleavage.");
			outputText("\n\nYou thank Konstantin for the armor, especially since it was hard to work with, and return to your duties.");
			player.destroyItems(useables.TBAPLAT, 1);
			if (flags[kFLAGS.KONSTANTIN_SERVICES] < 5) flags[kFLAGS.KONSTANTIN_SERVICES]++;
			inventory.takeItem(armors.TBARMOR, camp.returnToCampUseOneHour);
		}
		
		public function KonstantinSexMenu():void {
			clearOutput();
			if (flags[kFLAGS.KONSTANTIN_SEX_MENU] == 1) {
				outputText("Konstantin has nothing but a smile when he sees you coming to his place with the prospect of more fun in mind. With a mischievous wink, he strips of his undies, the only pieces of cloth covering his body, so you can ogle at the sight of his naked body, and lies on the bed, rubbing his towering manhood, as if enticing you to come in and choke on it.\n\n");
				outputText("Truly speaking, the mere sight of the flesh mammoth sliding between his fingers, as well as his huge nuts bouncing below make your body ache in need. Not wanting to leave him wanting, you strip off your clothes, and hop to his side on the bed. You make out for a while, enjoying his kisses, caresses and gropes, until none of you can’t stand it anymore, your bodies melting under the carnal desire.\n\n");
				outputText("Now that both of you are hot and ready, the question is, what do you want to do?\n\n");
				dynStats("lus", 33);
			}
			else {
				outputText("While wandering around the camp, you look out for Konstantin. Oddly, seems like he’s not around, as his working place is alone. You’re about to leave when you manage to hear a soft humming from his tent.\n\n");
				outputText("Peeking inside, you manage to see the well hung bear lazily relaxing on his bed. Not working for the moment, he is currently reading. Since he is in the supposedly private space of his own tent, he has forego most clothing, wearing now only a set of undies that does little to hide the bulge between his legs. You almost gasp in surprise as he takes them off too and starts rubbing his meat.\n\n");
				outputText("Then, a familiar voice startles you.\n\n");
				outputText("\"<i>Hey, [name] you aren’t going to say hello?</i>\"\n\n");
				outputText("Frozen in place, you face to look Konstantin, that smiles to you warmly, cock still on hand, not bothered a bit by your intrusion on his tent. Awkwardly, you try to explain yourself, but the stops you.\n\n");
				outputText("\"<i>Don't worry, my friend. Having your company is always nice. Mind seating with me?</i>\" he offers,\n\n");
				outputText("As you’re about to sit, your ursine friend points to you.\n\n");
				outputText("\"<i>Hey, [name]. Better take out those.</i>\" he suggests \"<i>Well feel more fresh that way, and I don’t think that anyone is gonna come in and see us.</i>\"\n\n");
				outputText("Nodding, you remove you clothing and leave it next to his bed, then you hop in and sit beside the naked bear, feeling the warm embrace of his fur on your [skin].\n\n");
				outputText("\"<i>“So, you came here only to hand around naked with me?</i>\" he jokingly remarks.\n\n");
				outputText("Blushing, you admit that you’d like to do what you were seeking, spend a good time with him, if he catches what you mean. He nods and smiles, enveloping you in one of his bear-hugs.\n\n");
				outputText("\"<i>It’s okay, " + player.mf("man", "girl") + ". We always have those urges sooner or later. And, on those times is much more sooner than later. And, with you, I’d be more than happy.</i>\" he assures you. \"<i>So, what’s on your mind?</i>\"\n\n");
				flags[kFLAGS.KONSTANTIN_SEX_MENU] = 1;
				dynStats("lus", 33);
			}
			menu();
			addButton(0, "Give BJ", KonstantinTalkHim);
			addButton(1, "Recive BJ", KonstantinTalkHisWork);
			addButton(2, "69", KonstantinTalkTheCamp);
			addButton(3, "Recive Anal", KonstantinTalkTheCamp);
			addButton(4, "Hot Spring Fuck", KonstantinTalkTheCamp);
			addButton(14, "Back", KonstantinMainCampMenu);
		}
	}
}