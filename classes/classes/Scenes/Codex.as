package classes.Scenes
{
import classes.*;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;

import coc.view.ButtonDataList;

/**
	 * ...
	 * @author Kitteh6660
	 */
	public class Codex extends BaseContent
	{
		/*Please use the following template whenever appropriate.
			clearOutput();
			headerMain("Race name goes here");
			outputText("<b>Genders:</b> Gender goes here\n");
			outputText("<b>Height:</b> Height goes here\n");
			outputText("<b>Build:</b> Build type\n");
			outputText("<b>Skin tone:</b> Skin tone\n");
			outputText("<b>Hair:</b> Hair type\n");
			outputText("<b>Eye color:</b> Eye colour\n");
			headerSub("Header1");
			outputText("Lorem ipsum dolor sit amet");
			headerSub("Header2");
			outputText("Lorem ipsum dolor sit amet");
			headerSub("Header3");
			outputText("Lorem ipsum dolor sit amet");
			headerSub("Header4");
			outputText("Lorem ipsum dolor sit amet");
			headerSub("Header5");
			outputText("Lorem ipsum dolor sit amet");
			headerSub("Header6");
			outputText("Lorem ipsum dolor sit amet");
		 */

		//Current state
		private var currentPage:String = "";
		private var currentEntry:int = 0;

		//CODEX MODULES & APIs
		public function headerMain(text:String = ""):void {
			outputText("<font size=\"36\" face=\"Georgia\">" + text + "</font>\n\n");
		}
		public function headerSub(text:String = ""):void {
			outputText("\n\n<font size=\"24\" face=\"Georgia\"><b><u>" + text + "</u></b></font>\n");
		}

		public function unlockEntry(flag:int):Boolean {
			for each (var entries:Array in pages)
				for each (var entry:Array in entries)
					if (entry[0] == flag) {
						if (flags[flag]) return false; //return if already unlocked. Not earlier - still want to check that flag is legal.
						outputText("\n\n<b>New codex entry unlocked: " + entry[1] + "!</b>\n");
						flags[flag] = 1;
						checkAchievements();
						return true;
					}
			CoC_Settings.error("Unknown codex entry!");
			return false;
		}

		public function checkUnlocked():Number {
			var num:int = 0;
			for each (var entries:Array in pages)
				for each (var entry:Array in entries)
					if (flags[entry[0]])
						++num;
			return num;
		}

		public function totalEntries():Number {
			var num:int = 0;
			for each (var entries:Array in pages)
				for each (var entry:Array in entries)
					++num;
			return num;
		}

		public function checkAchievements():void {
			var unlocked:int = checkUnlocked();
			if (unlocked >= 20) awardAchievement("Scholar (1)", kACHIEVEMENTS.GENERAL_SCHOLAR);
			if (unlocked >= 30) awardAchievement("Scholar (2)", kACHIEVEMENTS.GENERAL_SCHOLAR_2);
			if (unlocked >= 40) awardAchievement("Scholar (3)", kACHIEVEMENTS.GENERAL_SCHOLAR_3);//aktualnie 40 codex entries exist ingame: 32 races, 3 demon projects, 2 factions, 3 other
		}

		//CODEX MENUS
		public function accessCodexMenu():void {
			clearOutput();
			if (player.hasSpells()) unlockEntry(kFLAGS.CODEX_ENTRY_MAGIC); //need to do it somewhere
			checkAchievements(); //just in case something's broken
			menu();
			currentPage = "";
			currentEntry = 0;
			outputText("You open your codex. Which topic would you like to read?\n\n");
			outputText("Codex entries unlocked: " + checkUnlocked() + "/" + totalEntries());
			var btn:int = 0;
			for (var page:String in pages)
				addButton(btn++, page, openPage, page);
			addButton(14, "Back", playerMenu).hint("Return to main settlement menu.");
		}

		//TODO: too much flags. Maybe migrate to SaveableState?
		public var pages:Object = {
			"Races": [
				[kFLAGS.CODEX_ENTRY_ALRAUNE, "Alraunes", codexEntryAlraune],
				[kFLAGS.CODEX_ENTRY_ANEMONES, "Anemones", codexEntryAnemone],
				[kFLAGS.CODEX_ENTRY_ARACHNES, "Arachnes", codexEntrySpiders],
				[kFLAGS.CODEX_ENTRY_BEHEMOTH, "Behemoth", codexEntryBehemoth],
				[kFLAGS.CODEX_ENTRY_CHESHIRE_CAT, "Cheshire Cat", codexEntryCheshireCat],
				[kFLAGS.CODEX_ENTRY_CHIMERA, "Chimera", codexEntryChimera],
				[kFLAGS.CODEX_ENTRY_COCKATRICES, "Cockatrices", codexEntryCockatrices],
				[kFLAGS.CODEX_ENTRY_DEVIL, "Devil", codexEntryDevil],
				[kFLAGS.CODEX_ENTRY_DISPLACER_BEAST, "Displacers", codexEntryDisplacerBeast],
				[kFLAGS.CODEX_ENTRY_GOOGIRLS, "Goo Girls", codexEntryGooGirls],
				[kFLAGS.CODEX_ENTRY_ECHIDNAS, "Echidnas", codexEntryEchidnas],
				[kFLAGS.CODEX_ENTRY_GIANTBEES, "Giant Bees", codexEntryBees],
				[kFLAGS.CODEX_ENTRY_GOBLINS, "Goblins", codexEntryGoblins],
				[kFLAGS.CODEX_ENTRY_HARPIES, "Harpies", codexEntryHarpies],
				[kFLAGS.CODEX_ENTRY_HELLCATS, "Hellcats", codexEntryHellcats],
				[kFLAGS.CODEX_ENTRY_HELLHOUNDS, "Hellhounds", codexEntryHellhounds],
				[kFLAGS.CODEX_ENTRY_HYDRA, "Hydra", codexEntryHydra],
				[kFLAGS.CODEX_ENTRY_IMPS, "Imps", codexEntryImps],
				[kFLAGS.CODEX_ENTRY_LABOVINES, "LaBovines", codexEntryLaBovines],
				[kFLAGS.CODEX_ENTRY_LIZANS, "Lizans", codexEntryLizans],
				[kFLAGS.CODEX_ENTRY_MANTICORES, "Manticores", codexEntryManticores],
				[kFLAGS.CODEX_ENTRY_MINOTAURS, "Minotaurs", codexEntryMinotaurs],
				[kFLAGS.CODEX_ENTRY_NAGAS, "Nagas", codexEntryNagas],
				[kFLAGS.CODEX_ENTRY_ORCS, "Orcs", codexEntryOrcs],
				[kFLAGS.CODEX_ENTRY_RAIJU, "Raijus", codexEntryRaijus],
				[kFLAGS.CODEX_ENTRY_RHINOS, "Rhinoceros", codexEntryRhinos],
				[kFLAGS.CODEX_ENTRY_SALAMANDERS, "Salamanders", codexEntrySalamanders],
				[kFLAGS.CODEX_ENTRY_SATYRS, "Satyrs", codexEntrySatyrs],
				[kFLAGS.CODEX_ENTRY_SHARKGIRLS, "Shark Girls", codexEntrySharkGirls],
				[kFLAGS.CODEX_ENTRY_SUCCUBUS, "Succubus", codexEntrySuccubus],
				[kFLAGS.CODEX_ENTRY_TROLLS, "Trolls", codexEntryTrolls],
				[kFLAGS.CODEX_ENTRY_ZEBRAS, "Zebras", codexEntryZebras],
			],
			"DemonProjects": [
				[kFLAGS.CODEX_ENTRY_TYRANT, "Tyrant", codexEntryTyrant],
				[kFLAGS.CODEX_ENTRY_FLAMESPREADER, "Flamespreader", codexEntryFlamespreader],
				[kFLAGS.CODEX_ENTRY_NIGHTWALKER, "Nightwalker", codexEntryNightwalker],
			],
			"Factions": [
				[kFLAGS.CODEX_ENTRY_FETISHFOLLOWERS, "Fetish Cult", codexEntryFetish],
				[kFLAGS.CODEX_ENTRY_SANDWITCHES, "Sand Witch", codexEntrySandWitches],
			],
			"Other": [
				[kFLAGS.CODEX_ENTRY_GOLEMS, "Golems", codexEntryGolems],
				[kFLAGS.CODEX_ENTRY_MAGIC, "Magic", codexEntryMagic],
				[kFLAGS.CODEX_ENTRY_IMP_TOME, "Imp Tome", codexEntryImpTome],
			]
		}

		private function openPage(page:String):void {
			menu();
			currentPage = page;

			var buttons:ButtonDataList = new ButtonDataList();
			for (var i:int = 0; i < pages[page].length; ++i) {
				var entry:Array =  pages[page][i]; //Pointer, not a copy!
				buttons.add(currentEntry == i ? "(" + entry[1] + ")" : entry[1], curry(entryWrapper, i, entry[2]))
					.disableIf(!flags[entry[0]], null, null, "???");
			}
			submenu(buttons, accessCodexMenu, currentEntry / 12, false); //maybe sort?
			addButton(14, "Back", accessCodexMenu);
		}

		private function entryWrapper(index:int, fun:Function):void {
			currentEntry = index;
			clearOutput();
			fun();
			openPage(currentPage);
		}

		private function codexEntryAlraune():void {
			headerMain("Alraunes");
			outputText("<b>Genders:</b> Female but as plants they are hermaphrodites\n");
			outputText("<b>Height:</b> 6 to 7 feet tall due to the pitcher size.\n");
			outputText("<b>Body type:</b> Idealised woman\n");
			outputText("<b>Skin tone:</b> In all variants of greens\n");
			outputText("<b>Fur/hair color:</b> Vary between green and pinks.\n");
			outputText("<b>Eye color:</b> Green or purple\n");
			outputText("<b>Notable feature:</b> Floral bath like pitcher\n");
			headerSub("Appearance");
			outputText("Alraunes resemble beautiful women from the waist up, their legs vanishing below the waist in their nectar pool and connecting to the large flower pitcher beneath at the feet level. Their true body no matter the appearance however is the flower pitcher itself. While their pistil is female in appearance and capable of intercourse, the twelve vines mounted with floral stamens hidden beneath the pitcher allows them locomotion.");
			headerSub("Behavior");
			outputText("Alraunes while not aggressive in the normal sense are about as likely to strike casual conversation as to force the 'teachings' of their patron deity on others. They see themselves as evangelists of Marae and are willing to pull their would-be target all the way to their pitcher by force in order to 'spread the love' of their goddess.");
			headerSub("History");
			outputText("The gods each have a creature whom they favor amongst their creations. Amongst plants morphs and dryads none embody Marae teachings as much as the infamous Alraunes. Fertility incarnates, alraunes embody it down to the floral haze of lust that herald their presence. Alraunes only wish to spread the faith of their god the way they do best, by spreading their seed and getting seeded themselves.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryAnemone():void {
			headerMain("Anemones");
			outputText("<b>Genders:</b> Universally hermaphroditic\n");
			outputText("<b>Height:</b> Ranges from 5' to 6', though the body is mildly elastic to cope with water pressure, making determination of an individual's 'natural' height highly subjective.\n");
			outputText("<b>Build:</b> Slender\n");
			outputText("<b>Skin:</b> Varies due to camouflage reflex, but most usually shades of dark blue in their normal habitat.\n");
			outputText("<b>Hair:</b>  Properly speaking, anemones have no body hair, though they have a great number of long tentacles atop their heads that are colloquially referred to as ‘hair’ by those who have seen one; the tentacles are a mixture of greens and purples that become bright when the anemone wants to attract attention but fade when one is dormant or hiding from a predator.\n");
			outputText("<b>Eyes:</b> Opaque light blue\n");
			headerSub("Appearances");
			outputText("Anemones typically have a svelte, feminine body shape with small breasts, usually close to B-cup. A pair of stalks bearing gills originate along the median of their front torso, just below the collarbone, and grow downward along a diagonal. The branches do not move on their own and generally hang down when one stands upright out of water, falling over their breasts. A phallic-looking branch protrudes from their body near the ‘groin’ with a head flanged by diminutive writhing tentacles similar to the longer ones above, and a deep-blue vagina exists underneath with small feelers ringing the entrance. Both types of tentacles frequently make small shifts toward whatever the anemone’s currently interested in unless checked consciously by their bearer.");
			headerSub("History");
			outputText("Anemones are a mutant offshoot of a giant, drab-colored freshwater hydrozoan that has since been pushed to extinction. Anemones are a fairly new species in terms of Mareth’s chronology; only emerging from their non-sentient, non-humanoid precursors after the demon factory had adulterated the lake with chemicals for quite some time.");
			headerSub("Biology");
			outputText("Anemones have an internal construction more similar to jellyfish or their seafaring namesake than the humans they superficially resemble. Lacking a skeletal structure, most of their body is extremely elastic and supported by the autonomous inflation and deflation of thousands of tiny, interlinked bladders within the penultimate layers of the skin. The elasticity and compressibility help to resist the changes of pressure frequently incurred when the anemone transitions between surface and deeper water, and the bladders can be filled with air to no ill effect, allowing one to decrease weight and increase rigidity to remain above water when necessary. The topmost layer of the skin is a tough cuticle that prevents damage to the essential vessels underneath. The anemone’s tentacles share the same structure but with stinging nematocysts interspersed densely in the topmost layer of the skin. These stinging cells fire whenever in contact with any surface, even the anemone’s own, though she is immune to her own venom due to the outer cuticle. The venom injected by the cells retains the paralytic effects of the anemone’s ancestor but has been endowed with an aphrodisiac effect by long exposure to factory runoff. Anemones synthesize venom quickly enough that the larger tentacles cannot run out except in cases of severe lack of nutrition, leading to a downward spiral usually resulting in the death of the individual; venom reserves on the smaller tentacles can be depleted during overuse. The feelers surrounding the vagina are a degenerate form of the tentacles, retaining the venom but lacking the color. The anemone’s nervous system runs through her entire body, with a nexus in the head, roughly in the center of her nerve network. Sensory nerves are at their highest concentration in the face, the genitalia, the breasts, the gills, and the tips of the tentacles. Because the anemone’s elastic body is designed to resist pressure damage, an anemone is unlikely to find being pinned underneath a heavier creature in either mating or combat uncomfortable. However, applying sharp pressure or squeezing suddenly without giving the anemone’s body a chance to distribute the force will cause one to experience something similar to pain and likely provoke a defensive response. The same holds true of any bladed implement used with enough force to penetrate the cuticle.");
			headerSub("Diet");
			outputText("Anemone retain, for the most part, the dietary needs of their ancestors; they require the nutrients found in the bodily fluids of living creatures. The mutations wrought by the demonic corruption of the lake have modified the anemone’s digestive system to extract these nutrients efficiently from said fluids, particularly semen, to which anemones have developed a partiality, at the expense of eliminating their ability to subsist on any other food. Anemones have a high capacity to store nutrients and as such, are always psychologically hungry even if not physically in need of nourishment.");
			headerSub("Reproduction");
			outputText("Anemone reproduction favors warm, damp spaces. Anemones reproduce in a queer admixture of invertebrate and terrestrial modes and could be considered primarily parasitic in nature. Though not interfertile with other races, anemones tend to copulate with any female using the penile branch located at their groin; the haploid gametes released each have the potential to grow into a new anemone and will try to implant in the womb of the recipient. When one is successful, it emits a hormone that causes the other oocytes to die and be absorbed by the host’s body. The implantation follows the normal routine of pregnancy. Anemone are not particular about partners; if two anemone meet in this way and both have enough nutrition to support a pregnancy, they will typically copulate with each other, and the haploid oocyte implanted will be fertilized with additional genetic material inside the recipient’s body, resulting in true diploid sexual reproduction. The resultant offspring of any anemone ‘pregnancy’ will take the shape of a small, non-sentient, shaft, not dissimilar to the penile branch, that will search out nearby liquid if available and slowly begin taking on water to decrease the density of each cell and begin cell division and differentiation pursuant to becoming an adult anemone. The growth begins at the back of the shaft, where a dense nucleus of undiversified cells gathers. If no liquid is available the offspring will often try to parasitize its mother in order to survive on her bodily fluids, first adhering to the skin surface and then using pressure from cellular expansion to force its way through and connect with the circulatory and nervous systems. This process is irreversible; the undifferentiated cells die a preprogrammed death once the conduit is established. If no suitable female partner is available and food supplies abundant, as they are often with shoreline anemones living near male-heavy camps, an anemone can reproduce ‘asexually’ by masturbating herself to orgasm and placing the ejaculate in her own vagina. The success rate of such self-impregnation is fairly low. Anemones typically only do this for one generation; once an offspring emerges and is fully-grown, the anemone will prefer to copulate with it as long as it remains in the area. An anemone regarded as a cute pet or a sex toy by a predominately male community can quickly grow to plague it in this manner.");
			headerSub("Behavior");
			outputText("while they may have a fair bit of natural intelligence, they are very young as a species and by no means world-wise or accustomed to society. They have some talent for language but little exposure to it; most of their sparse language skills come from observing the interactions of others from faraway. Anemone tend to communicate with each other by touch or gesture and will usually default to this with other races, only using words to add emphasis or consciously with races that do not seem to respond to the myriad small cues that anemone recognize in each other's actions. Anemones tend to be slightly mischievous or sadistic, either as result of their corrupt origins or simply because of their inexperience and lack of social mores.");
			outputText("\n\n(Written by Zeikfried)");
		}

		private function codexEntrySpiders():void {
			headerMain("Arachne, Spider-Morphs, and Driders");
			outputText("<b>Genders:</b> Female, Male, and Hermaphrodite\n");
			outputText("<b>Skin:</b> All varieties of spider-kin typically have very pale 'skin' in the places their chitin does not cover. Some rare individuals will be born dark, nearly black-skinned, but in general their human portions are very white.\n");
			outputText("<b>Hair:</b> Typically red, black, orange, or green. Rarely, brown.\n");
			outputText("<b>Eyes:</b> Solid yellow, red, black, or purple with small, black pupil in the middle. All spider-kin have a chance of having either four or six such eyes. Typically the extras are located on the forehead, above the primary pair, and are much smaller.\n");
			outputText("<b>Facial features:</b> Largely human. Spider-kin ALL have long, needle-like retractable canines that can be used for injecting venom or drinking blood. Unlike normal spiders, spider-kin are capable of surviving on an omnivorous diet, but love to dine the 'spider-way' when possible.\n");
			outputText("<b>Legs:</b> All spider-kin save for Driders have humanoid legs and feet. However, unlike humans, spider-kin feet only have a few toes that can be hooked together to grip and climb on webs. Drider lower bodies are entirely spider-like. They have eight spider legs, used for scaling webs or walls, as well as a much larger abdomen than less spider-races.\n");

			headerSub("Body Structures");
			outputText("Arachne and spider-morphs have the most in common with other bipeds. Their hand structure is exactly the same as a human’s, save for the chance of being encased in an exoskeleton. Some spider-kin are born with four arms, though only ‘pure-born’ ones seem to show this trait. All arachne and spider-morphs have an arachnid-like abdomen that grows from their back, just above their butt-cheeks, though it has a tendency to hang low when being ignored. On Driders, the anus and corresponding \"cheeks\" are located just above the beginning of their spider half. Though there is no known reason for this disparity in anal positioning, it does allow Driders to fold their spider segments flat between their many legs and allow themselves to be taken anally in the traditional way.");
			headerSub("Venoms");
			outputText("All spider-kin have aphrodisiac venom. Driders and Arachne both have a paralyzing toxin they can call upon as well.");
			headerSub("Webbings");
			outputText("Spider-kin can spray webbing from their abdomens with a great degree of control, enabling any spider-kin to create either sticky webs or silk-like web-threads. Thankfully for them, the webbing does not adhere to their exoskeletons, enabling any variety of spider-kin to traverse another’s web with ease. Spider-morphs are very careful to avoid touching the webbing with their bare skin, and many Drider and arachne find it quite fun to prank the lesser spider-kin by trapping them in webs.");
			headerSub("History");
			outputText("Spider-kin are a relatively new addition to Mareth. They were originally humans who came through a newly opened portal in the swamp. Unfortunately for those humans, they came into contact with a fairly rare variety of spider that infests that portion of the swamp known as \"red widows\" for their red coloration and poisonous venom. Like all creatures in Mareth, the red widows were changed as the demons claimed power, and their venom became somewhat less deadly, if more transformative. The newly arrived immigrants were bitten, one by one, each time changing more to resemble the spiders of their new homeland. After a few weeks of this, they had become spider-kin. They could not leave through the portal they had entered, and they had already developed strange new cravings. In spite of this, the new spider-kin established a small village around their portal and resolved not to eat other sentient creatures. They even began to trade with other villages, exchanging silk for foodstuffs and metals they could not procure in their swampy home. Before long, a few rogue arachne and Driders tired of this, and split off from their more peaceful brethren. They believed themselves a superior predator, and had no such qualms about eating other thinking beings. Once the demons began their conquest of the swamps, these renegades quickly joined them, wallowing in corruption to become even greater predators. Their more peaceful kin tried to fight, but were utterly defeated. Those who survived scattered throughout the swamp, eking out a far more feral life. Most of these survivors struggle with loneliness as much as their physical and sexual desires. It is recommended that the swamp be avoided by all but the stoutest adventurers for this reason – you never know if the spider you meet is merely lonely, lusty, or hungry. Thankfully prey is plentiful, and it is rare to find one of these spiders so hungry they’d rather eat you than converse or fuck.");
			headerSub("Reproduction");
			outputText("Spider-kin reproduction is a fairly standard affair. A male mates with a female, impregnating her eggs. One to two weeks later the mother will give birth to roughly one dozen eggs, which she will bind up in an egg sack and hang from a tree or cave ceiling. A week after that, immature spider-kin will emerge, ready to hunt. It takes roughly one month for them to reach their adult size and intelligence. Spider-kin are very intelligent and learn languages almost supernaturally quickly. When mixed varieties of spider-kin mate, the offspring are a mix of their mother and father’s type. If, for example, a Drider and arachne were to mate, the resulting brood would be composed of roughly 5-6 arachne and 5-6 Driders, though there can be some variation in the exact amounts.");
			headerSub("Corrupted reproduction");
			outputText("Unfortunately, the rising tide of corruption in the land has affected the ways that spider-kin copulate in more nefarious ways. Those females who have been exposed to high levels of corruption quickly grow large ovipositors from the bottoms of their abdomens, and are capable of laying their corrupted offspring inside the vaginal canals or anuses of their victims. These corrupt spider-kin often drip venom when agitated or aroused, and can poison or arouse with just a kiss. Eggs laid from their tainted ovipositors do absorb personally traits and some modest physical changes from the host-mother, but still hatch entirely as spiders, regardless of the mother’s race. Thankfully, the eggs will induce labor and force themselves from the host mother’s body moments before they are due to hatch. Once laid, the spider-kin young-lings will emerge and skitter off in search of their first meal. \nThough corrupted, these spider-kin aren’t necessarily in league with demons or monstrous in their desires. Simply being exposed to corrupt fluids a few times in short order can have this affect, leaving a mostly pure-hearted spider-girl with a distended, egg-filled ovipositor and the desire to use it. Succubi drafts have also been known to cause this effect in spider-kin, even males.");
			headerSub("Other notes");
			outputText("Spider-kin venom is believed to be a crucial ingredient in the lust drafts and poisons used by the goblins of Mareth, but those weak toxins lose most of their potency after a short time. When injected fresh, it is a great deal more powerful and dangerous than those weak drugs. ");
		}

		private function codexEntryCheshireCat():void {
			headerMain("Cheshire Cats");
			outputText("<b>Genders:</b> Variable\n");
			outputText("<b>Height:</b> 5 to 6 feet tall.\n");
			outputText("<b>Body type:</b> Slender to Average\n");
			outputText("<b>Skin tone:</b> Variable\n");
			outputText("<b>Fur/hair color:</b> Fur and hair color can be of any matchup so long as it's weird and striped.\n");
			outputText("<b>Eye color:</b> The same as most cat morphs\n");
			outputText("<b>Notable feature:</b> A most aggravating grin that never goes out and madness.\n");
			headerSub("Appearance");
			outputText("The cheshire cat is notable for its striped fur ranging from purple to blue and wide grin. It otherwise resembles and can be mistaken for a normal cat morph by the uneducated observer, an error that can cost you dearly. All cheshire cats are living paradoxes in that they exist and do not at the same time, a power that let them be everywhere and nowhere. This ability amongst many things allow them to teleport along with others to different locations on a whim and even deny their own demise. Killing a cheshire cat is thus said to be impossible as the only way it would ever die is if it allowed itself to do so on purpose. Despite all of their powers, cheshire cats are not almighty. They follow a strict code only known to them and to the denizens of wonderland, their world of origin.");
			headerSub("Behavior");
			outputText("Cheshire cats favors forested area where there are plenty of trees to perch themselves up and prey on the gullible. Cheshire cats while not corrupt or innately evil in nature are notorious as pranksters and thus are untrustworthy and hazardous to be around. Their pranks range from stealing items to getting their traveling partners straight into ambushes with the local wildlife.");
			headerSub("History");
			outputText("Not native to Mareth, cheshires have first been reported after portals began appearing across the plane. It is likely the curious cats simply ventured out into Mareth seeking new gullible victims to entertain themselves with and with them various otherworldly products made their way to the markets including the infamous wonderland cakes.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryChimera():void {
			headerMain("Chimeras");
			outputText("<b>Genders:</b> Variable\n");
			outputText("<b>Height:</b> Variable\n");
			outputText("<b>Body type:</b> Variable\n");
			outputText("<b>Skin tone:</b> Variable\n");
			outputText("<b>Fur/hair color:</b> Variable\n");
			outputText("<b>Eye color:</b> Variable\n");
			outputText("<b>Notable feature:</b> No two chimera are the same but all of them are amalgams of multiple creatures.\n");
			headerSub("Appearance");
			outputText("With how common transformative items are on Mareth, it was only a matter of time before some unlucky person began transforming into so many things at the same time, the unnatural result would be a super monster. Chimera are the god Ezekiel's favored beast and the greater one almost always exhibit some traits of the now long extincts dragons.");
			headerSub("Behavior");
			outputText("True chimera bodily instability makes them highly unpredictable as they tend to combine the traits of both prey and predators. A consensus is that if any of the chimera parts belong to a predator it is likely to attack, kill or violently rape its victim. Chimeric body instability has a tendency to drive the monster deeper and deeper into its basest instinct, making most true chimera deadlier and hornier than demons.");
			headerSub("History");
			outputText("Ever since transformatives appeared on Mareth, chimeric abominations roamed the land. It only became even worse when the demons started experimenting and creating even deadlier beasts. True chimera almost always loses to their many conflicting instincts, turning savage and aggressive before long, something demonic corruption only makes worse.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryCockatrices():void {
			headerMain("Cockatrices");
			outputText("<b>Genders:</b> Male, female and hermaphrodite. On average 55% of the cockatrices are male, with 35% being female"
				+" and 10% being natural herms.\n");
			outputText("<b>Height:</b> Cockatrices can grow between 5 foot 7 and 6 foot 8,"
				+" though their long tails and feathered ears tend to make them look larger.\n");
			outputText("<b>Build:</b> Cockatrices tend to have light and athletic builds, with their muscle mass being noticeable particularly"
				+" around the chest and stomach. Similar to harpies females have small busts, while their behinds tends to be small,"
				+" often described as pert or tight. Regardless of gender they have somewhat wider hips, perfect for egg laying.\n");
			outputText("<b>Hair/Feathers:</b> Cockatrices have a layer of feathers coating most of their body, leaving only the belly, tail, forearms"
				+" and calves free of feathers. Their feathers come in several colors, often vibrant or exotic, with lighter coloured accents"
				+" in most cases. Some examples of these combinations are Blue/Turquoise, Orange/Red, Green/Yellow, Purple/Pink, Black/White,"
				+" (Sandy)Blonde/Brown, White/Grey. The scales of a cockatrice’s arms and legs are either black or yellow, while the tail"
				+" matches their feathers. Their ‘hair’ is also made of feathers so often cannot be distinguished as separate.\n");
			outputText("<b>Skin tone:</b> Cockatrice skin tones are unknown. See ‘Hair/Feathers’ for closest info\n");
			outputText("<b>Facial structure:</b> Cockatrices have bird-like faces complete with beaks. Their face is covered in the same feathered"
				+" coat as the rest of them, with longer ones on their ears. Their ears are at the side of their head,"
				+" in a similar shape to elf ears. Their ear tufts are usually longer than the top of their head,"
				+" and usually stand on their own, though some are known to be droopy. Their eyes are a remarkable feature,"
				+" possessing the same petrification skill of basilisks, while taking on a color similar to their lighter feathers."
				+" Their slit pupils can dilate similar to those of a cat, usually when excited.\n");
			headerSub("Appearance");
			outputText("Cockatrices have vibrant feathers covering the majority of their body, with only the belly, forearms, calves and tail being"
				+" devoid of feathers. Their plumage tends to be one dark colour with a lighter shade or similar complementary color accenting"
				+" their appearance. They appear mostly avian, with beaked faces, tufted feathered ears, and vestigial wing feathers at the"
				+" elbow. These vestigial wings aid with jumping and allow some slight control in the air. Some, but not all Cockatrices will"
				+" also have fully functional wings on their backs.");
			outputText("\n\nAround their neck, they have a ruff of lighter feathers which tends to be thicker and fluffier than their body feathers."
				+" It is usually used for the communication of emotion, puffing out and settling straight with their feelings."
				+" They have athletic frames with slight muscle definition, which is evident on their cream scaled underbelly,"
				+" with females and herms having up to D cup breasts at maximum. They usually have slightly wide hips and tight behinds,"
				+" their bodies surprisingly lithe.");
			outputText("\n\nThe upper portions of their arms and legs are also covered with feathers, which then grow into a cuff at the forearms"
				+" and calves, where their scaled reptile arms and legs begin. Usually these scales are black or yellow."
				+" Their hands are tipped with sharp claws, while their digitigrade reptile feet have sharp talons on each of their 3 toes,"
				+" their 4th hind claw being somewhat smaller. Above their rump they have a long,thick reptile tail which is the same color"
				+" as their feathers. Their feathers grow down it from their rear about 4 inches before terminating in a v-shape and their"
				+" scales begin. Their tails are usually close to half their body length.");
			outputText("\n\nA Cockatrice’s genitals are contained within a genital slit when not aroused, making their scaly underbelly seem smooth"
				+" regardless of gender. When aroused, the male’s penis emerges from the slit, usually between 6 and 12 inches long"
				+" and up to 2 inches thick. The Cockatrice’s member is usually a deep purple and similar in structure to that of a reptile.");
			headerSub("Reproduction");
			outputText("Female Cockatrices lay eggs, usually in a clutch of up to 4, once every 3 months. While any male can try to fertilize"
				+" a Cockatrice, and during her time with clutch she will aggressively pursue males so she can breed, they are not the most"
				+" fertile race due to being hybrids.If a male fertilizes them, the eggs grow to the size of large ostrich eggs in the womb."
				+" They remain in the womb for one week before being laid, their eggshells usually a pale powder blue. These eggs hatch after"
				+" 3 days, the ‘chicks’ already developed to the mentality of a 7-year-old, even at this small size. Due to their boundless"
				+" energy they are hard for the mother to keep track of, them only stopping when they collapse for a nap. Over the next month,"
				+" the ‘chicks’ will grow into adults, their minds and bodies developing rapidly, though their energy levels remain similar."
				+" By the time they have fully grown, they will still be very playful and excitable, easily jumping and gliding from rock to"
				+" rock in their mountain homes as they find others to play with.");
			outputText("\n\nIf a female isn’t fertilised, her eggs pass after a few days and are usually eaten. Cockatrice numbers are few enough"
				+" thanks to their hybrid nature, but also because of the difficulty in ensuring a ‘chicks’ safety. Cockatrices are known for"
				+" having prefered partners, and while they are not usually monogamous,"
				+" these prefered partners are the closest thing in cocktrice society to a romantic partner.");
			headerSub("Petrification");
			outputText("While Cockatrice’s share the petrifying gaze of their basilisk father's, they use it very differently."
				+" They do not rely on it as a weapon, their playful and upbeat nature means they use it in very creative ways. They trap their"
				+" lovers with their gaze, often in an intimate way such as during a hug, so that they can play with them longer,"
				+" having sex in many difficult and obscure positions thanks to the paralysis they inflict. The commonest use is so they can"
				+" hold around their partner’s neck in an embrace while wrapping their legs around their waist.  This way they can have full"
				+" control of the pace without having to worry about their partner falling over or being too weak to support them.");
			outputText("\n\n(Written by MissBlackthorne)");
		}

		private function codexEntryDevil():void {
			headerMain("Devils");
			outputText("<b>Genders:</b> Variable\n");
			outputText("<b>Height:</b> 3 to 4 feet tall.\n");
			outputText("<b>Body type:</b> Small and petite in proportion\n");
			outputText("<b>Skin tone:</b> Same as humans and demons\n");
			outputText("<b>Fur/hair color:</b> Fur and hair color ranges from brown, black and white to all shades of red.\n");
			outputText("<b>Eye color:</b> Ember with black sclera or ember with horizontal pupils\n");
			outputText("<b>Notable feature:</b> Unlike most demons their horns are those of a goat. They always have hooves. Their hands no matter their shape are adept and capable at spellcasting.\n");
			headerSub("Appearance");
			outputText("Devils take on the form of the malignant great old one known as Baphomet, almost always sporting goat-like features. Most devil willingly chose to assume a petite compact form which allows them better energy management. Unlike lesser demons, their wings and tails can vary a lot between feathered to bat wings. It is not unheard of for devils to sport a goat tail instead of the more standard spaded tail of demons.");
			headerSub("Behavior");
			outputText("Powerful and composed, devils would epitomise the principles of power and control as well as the pinnacle of demonkind ideals. Unlike normal demons the ideal devil would be capable of rational behavior, ever keeping its lust in check so that it does not interfere with its decision. Though wiser and more rational than demons, a devils is nonetheless corrupt and lack the concept of morality, manipulating and putting down its pawns without a second thoughts once it tires of them. It is important to note that most devils are the results of failed demonic experiments and thus will rarely exhibit all of those traits together, coming up with quirks like body deformity, madness, or uncontrollable lust which is the utter opposite of the devil project goals and thus deemed a failure. Should a perfect devil turn up it would easily rival and perhaps even outstrip the Mareth gods in terms of power.");
			headerSub("History");
			outputText("The first devils were created as an attempt to improve and control the state of demonhood into a better spellcaster variant. Most of those experiments turned up flawed in one way or another, always close to the goal but never perfect with deformed bodies or warped minds destroyed by their own lust and black magic. There are no records of a perfect devil ever created and should one do exist surely it would have revealed itself by now and ensnared Mareth beneath its unholy rulership. Unless of course it lost interest in enslaving other lesser life forms and gave in to its intended original desire for the accumulation of magical powers.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryDisplacerBeast():void {
			headerMain("Displacer Beasts");
			outputText("<b>Genders:</b> Variable\n");
			outputText("<b>Height:</b> 6 to 7 feet tall.\n");
			outputText("<b>Body type:</b> Slim, muscled and athletic\n");
			outputText("<b>Skin tone:</b> Ashen or greyish\n");
			outputText("<b>Fur/hair color:</b> Ash.\n");
			outputText("<b>Eye color:</b> Yellow\n");
			outputText("<b>Notable feature:</b> Four arms and two tentacles with milk suckers.\n");
			headerSub("Appearance");
			outputText("The displacer beast look similar to a cat morph albeit its pointy bat like ears, four arms and twin tentacles equipped with suckers and venom injectors. It is typically ashen black with yellow eyes. Its powerful limbs are covered with fur up to the thigh and elbow and can tear anything to shreds within seconds. ");
			headerSub("Behavior");
			outputText("The displacer beast is a highly aggressive predator who hunts for a very specific source of food, breast milk. Once its victim is unable to defend itself it will latch on its prey’s chest with two tentacles and inject it with its natural drugs akin to lactaid to force milk production. This done, it will feed on its victim’s milk until it runs dry. Displacer beast got their name from their ability to displace themselves. When attacked they can reflexively teleport out of the attack range or direction in order to viciously assault their prey from about any angle or range. Due to their sensitive vision they prefer hanging in dark caves, roaming Mareth only at night. It is said when fed willingly displacer beasts tend to act very much and be about as tame as an overgrown pet cat. For this reason Lacta bovines in need of relief actively seek them out.");
			headerSub("History");
			outputText("The displacer beast origins are pretty much unknown. No god made the claim on their creation through many scholars suspect only the god of transformation and change, Ezekiel, would ever create such a chimeric monster.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryFetish():void {
			headerMain("Followers of the Fetish");
			outputText("<b>Genders:</b> Females are Fetish Cultists and Males are Fetish Zealots. Fetish priestesses are either female, or hermaphrodites.\n");
			outputText("<b>Typical Dress:</b> Followers of the fetish have the ability to shift their clothing to anything they desire, though this is almost exclusively various fetish costumes. They may shift the outfits of those they encounter as well.\n");
			headerSub("Appearances");
			outputText("Followers of the Fetish appear as normal humans. Some have slight demonic traits typical of residents of this world.");
			headerSub("Sexual characteristics");
			outputText("Their genitals and anuses appear fully human, however they can warp them to fit their partners perfectly, no matter how big their partner’s assets are. They also have the power to create items and toys to supplement their sex games, these have very real effects on others. Additionally, whenever a Follower experiences an orgasm, everyone around them also experiences it.");
			headerSub("Social structure");
			outputText("The duties of the Followers are divided based on gender and power. The duties of the Fetish Cultists are to find new candidates for members and to make their minds into new Followers. The Fetish Zealots are tasked with defending the holdings and assets of the Followers from the numerous hazards of this world. Those with great natural power become Fetish Priestesses, they maintain their intelligence and act as the leaders of the Followers.");
			headerSub("Special abilities");
			outputText("Followers are very talented at lust based abilities, and the zealots and Priestesses are trained to use weapons sacred to their order. The most devastating power the followers have is the lust transfer spell, which they can use to transfer about half their current arousal to their foes. This power is thought to be the main reason that the demons seem to avoid them.");
			headerSub("Mentality");
			outputText("Most Followers have lost the capability of higher thought, only able to experience their fetishes and carry out their duties. Priestesses are still able to think at the level of a regular human.");
			headerSub("Corruption");
			outputText("Cultists and zealots do not bear great deals of corruption, they seem to have a sort of divine protection that keeps them from falling prey to the world’s taint. Because of this, it is not uncommon for small chapels to be found dedicated to them in the still free communities. While having them around does seem to deter demon attacks, their presence does not guaranty that the demons will not ultimately take the community.");
			headerSub("History");
			outputText("The original followers where a group of crusaders led by a man named Alexander. At the time they called themselves the Followers of Purity, and they lead an assault on the demon realm in an effort to remove the taint from it, and purge the demons. While they were initially successful at ridding several communities of demons and purifying their residents, they soon attracted the attentions of the demons as a whole. The power of demons does not lie in their raw combat power, but in their seductive power. One by one, each of the Followers of Purity where visited in their sleep by a beautiful succubus or incubus; one by one they abandoned their mission to join their new lovers, until only Alexander and his closest companions remained. The mission would not fail here though, Alexander and his comrades learned to watch their backs, and to never let any of their members sleep alone. Even then, they no longer had the strength they needed to overcome the demon’s holds on this world’s communities, and Alexander feared his crusade would fail. They instead began to search for any force that could stop the demons, they searched the entire world to the best of their abilities. All the while being hunted by the demons at every turn. They say that eventually, they did find what they were looking for… Now new members join the followers every day, strengthening their power with each new member. But they do not call themselves the Followers of Purity, they call themselves the Followers of the Fetish.");
			outputText("\n\n(AUTHOR: The Dark Master) ");
		}

		private function codexEntryBees():void {
			headerMain("Giant Bees");
			outputText("<b>Genders:</b> Almost exclusively Female, save for a few Drones in each hive.\n");
			outputText("<b>Height:</b> The average bee is roughly five feet tall. Drones are typically much shorter, but are rarely seen outside the hive. Warrior Bees can reach seven feet in height, and are fearsome when riled. Queens are by far the largest, at up to thirteen feet in length, though much of a queen’s body-size is dominated by her reproductive systems. Fertile-Caste tend to be of average height, anywhere from five to six feet tall.\n");
			outputText("<b>Hair:</b> Typically black, or black with vertical yellow strands.\n");
			outputText("<b>Eyes:</b> The eyes of Workers, Drones, and Warrior Bees eyes are glossy black orbs, while the Fertile-Caste and Queens can change their eye-color at will, and may even alter the appearance of their pupils and irises at will, to better entrance their targets. Some of the tainted hive-clusters are rumored to have slitted cat-like eyes, but those few who have gotten close enough to see them have never returned.\n");
			headerSub("Appearances");
			outputText("Bees are fairly human-like in appearance, save for their wings and bloated abdomens that extend off the back of their bodies, just above their buttocks. They have small antennae that protrude from their foreheads and large almond-shaped eyes. Bees also have chitinous coverings on their hands, forearms, feet, and lower legs. From a distance the black exoskeleton resembles latex gloves and boots. They rarely if ever wear clothes, though their thighs are covered with downy yellow fuzz. Their skin is unanimously a yellowed but very tan color, with darker black strips near their hips, biceps, thighs, and abdomen. All bees save drones have visible stingers.");
			headerSub("Sexual equipment");
			outputText("Queens have many vaginas along their abdomen, which ends in a large ovipositor. All the other bees save for drones are female, with a single human-like vagina. Fertile-Caste bees also have a retractable ovipositor that is flexible, bulbous, and constantly lubricated. It is located on her abdomen just below her stinger. Drones are the only male bees, and their gender is obvious to anyone who finds them. Though small in stature, their maleness is nearly as big as their torso. Few are ever seen, as without the constant sexual release a Queen can provide, they die.");
			headerSub("Reproduction");
			outputText("Once eggs are suitably incubated they develop, they are ‘birthed’. Usually the entire incubation and birth takes place from a victim’s rectum. Once exposed to open air, the eggs hatch, releasing thousands of regular-looking bees. These bees are the larval form of giant bees, and will gather resources for the hive for the first four to five years of their life. After stockpiling plenty of resources, they will grow dormant, and be sealed into the hive-wall to mature. A year later, an adult giant-bee will emerge.");
			headerSub("Social structure");
			outputText("Bees are divided into castes – the workers maintain the hive, the warriors protect the hive from the incursions of monsters and demons, the Queen produces the eggs, the Drones keep the Queen’s eggs fertilized, and the Fertile Caste bear the Queen’s fertilized eggs into the wilds to find suitable incubators. The bee social structure is rigid in the extreme, and the only bees that enjoy anything resembling leisure time are the Fertile-Caste, though they don’t see the harm in laying their eggs.");
			headerSub("Special attributes");
			outputText("Bees have a venomous stinger that can dispense either a paralyzing toxin, an aphrodisiac, or both. The strength of each toxin varies based on the bee’s caste, and some of the more specialized castes may lack one of the venoms. The exact nature and distribution of the venom between castes is unknown. ");
		}

		private function codexEntryEchidnas():void {
			headerMain("Echidna-Morphs");
			outputText("<b>Genders:</b> Male, Female\n");
			outputText("<b>Height:</b> Short, never exceeding 5'4\", but never under 4'. Males are usually taller.\n");
			outputText("<b>Build:</b> Stout and thick-bodied, females having noticeable hips.\n");
			outputText("<b>Skin:</b> Typically ranging from tan to ebony in color, with the occasional albino.\n");
			outputText("<b>Fur:</b> All echidna-morphs are coated in a thin layer of fur. Fur is almost always varying shades of brown, but the rare albino echidna-morph will have white or very light blonde fur.\n");
			outputText("<b>Hair:</b> Instead of a normal head of hair, echidna-morphs have a full head of quill hair. These quills are typically just a few shades lighter than their fur. Females only have quills on their heads, but males often have them on their backs as well.\n");
			outputText("<b>Ears:</b> Echidna-morph ears are almost identical in appearance to that of Lizan ears. They are small, rounded, and nearly-invisible at first glance. The only difference is, of course, the lack of scales.\n");
			outputText("<b>Arms and Legs:</b> Their arms and legs are almost completely humanoid in appearance, the only differences being that their fingers and toes are tipped with long claws, and the bottoms of the feet being padded.\n");
			outputText("<b>Face:</b> Echidna-morphs have a rather prominent snout. It is long and noticeably thin. Their eyes are rounded and beady, usually brown or black, red for albinos. Sometimes, their tongue flits out from between their lips when they’re not thinking about it. This tongue is always at least a foot in length.\n");
			outputText("<b>Tail:</b> The echidna-morph tail is short and stumpy, barely noticeable at first glance.");
			headerSub("Sexual Characteristics");
			outputText("Males possess an unusual four-headed penis that remains retracted inside a sheath when not aroused. A duo of balls swings under their shaft, as you would expect. Females experience a heat cycle once a month. During this time, some eggs have dropped, and they are capable of being fertilized. If not fertilized by the time the cycle is over, the eggs develop a shell, and are subsequently expelled from the body.  These eggs, if consumed by non-echidna-morphs, can cause echidna-related mutations.");
			headerSub("Diet");
			outputText("Echidna-morphs are the only species in Mareth known to actively consume insects as part of their diet. In fact, they are primarily insectivores, but this does not mean that they cannot enjoy other foods as well.");
			headerSub("Social Structure");
			outputText("Echidna-morphs typically live in small communities that rarely exceed 100 members. They once occupied the forests, but the recent corruption of Mareth’s forests has driven them out. They now mostly live in the plains, where their only problems are the occasional run-ins with gnolls or satyrs. Echidna-morphs also exist as a minority in cities like Tel’Adre.");
			headerSub("Inter-Species Relationship");
			outputText("Most echidna-morphs hate the demons. It’s because of them that their forests were corrupted, and the now-resident tentacle beasts were nonexistent until they came about. Due to the rise of corrupted glades and the increasing population of the tentacle beasts, some echidna morphs ending up succumbing to the corruption of the forests. These corrupted mutants have green fur, with the males having a cluster of four tentacle penises rather than the normal, single four-headed one.");
			outputText("\n\nThe races that echidna-morphs interact the most with are gnolls and satyrs. These interactions are not typically positive ones, however. The over-aggressive gnolls start the occasional turf war, and communities will often have to drive away the occasional drunken satyr.");
		}

		private function codexEntryGoblins():void {
			headerMain("Goblins");
			outputText("<b>Genders:</b> Female\n");
			outputText("<b>Height:</b> 2 to 4 feet tall.\n");
			outputText("<b>Eye colors:</b> Red, Violet, Amber, or Pink\n");
			outputText("<b>Hair colors:</b> Red, Very Light Blonde, Purple, Pink, White, or Black\n");
			outputText("<b>Skin colors:</b> Green, though in rare cases blue or red-tinged.\n");
			outputText("<b>Appendages:</b> Their arms and legs look like a human’s, although they are scaled down to fit the goblin’s smaller frames.\n");
			headerSub("Appearances");
			outputText("Goblins are normally lithe little creatures with somewhat Elvin faces. Their ears are pointed, though their unusual (and very punk rock) haircuts can sometimes hide them. A goblins age can usually be determined by the size of her bust and hips. Very young goblins have relatively small chests and hips, though as they age and give birth, their endowments will grow ludicrous sizes. It is rumored that somewhere there is a goblin Queen who has so many children that she has become immobile. They often dress themselves in tight-fitting leather harnesses to display their chests. A goblin’s crotch will ALWAYS be exposed. They favor piercings in multiple locations, and most have jewelry in their nipples, clit, and both pairs of lips.");
			headerSub("Aging");
			outputText("Goblins do not get 'old' like other races, and do not get lines or wrinkles. They will not die from age alone, though should a goblin be successful enough to immobilize herself, she may die if she does not have family that keeps her fed.");
			headerSub("Sex life");
			outputText("Goblins are ALWAYS horny and ready to copulate. They have large juicy vulva that aches for penetration, and despite their small size can take many of the larger members out there (in moderation). They will always seek to have sex with any willing participant, and in those rare cases where they are too small, they will be sure to take as much cum inside themselves as possible. Thanks to the wide array of psychology altering chemicals in their bodies, goblins get off on the act of giving birth.");
			headerSub("Life cycle");
			outputText("The life of a young goblin is likely to end in the jaws of a Hellhound, impaled on a Minotaur’s dick, or drowned tentacle-cum. Due to the special properties of their wombs (any pregnancy ALWAYS results in a goblin), they are considered worthless to most monsters and demons, and due to their small size, they often end up dying after an encounter with a minotaur or similar creature. Despite the high fatality rate of young goblins, those who survive beyond their first pregnancy will often live a very long time, and will dedicate themselves to birthing their broods (4+ goblins per pregnancy) and perfecting alchemical recipes they can use to 'seduce' more 'fathers'.");
			headerSub("History");
			outputText("Goblins were once the technological leaders of what is now known as the Demon-Realm. When the demons came, they signed a treaty guaranteeing peace and freedom to the goblin people. The peace was a lie. That night, a team of demons tunneled into the goblin’s water supply and began tainting it with ever increasing levels of corruption. Over the next few days, the goblins spent less and less time working, and more and more time fucking.\n");
			outputText("Within a week, their greatest minds were spending all their time eating pussies and developing new aphrodisiacs. Within a month the goblins were permanently turned on by the strongest of drugs and fucking nonstop in the streets of their once-great city. A few did not partake of the tainted water, and locked themselves inside their dwellings for as long as they dared. Some gave in to thirst or loneliness. Others stayed indoors until the demons walked in and easily assumed control. They put the few sane goblins left to work building the machines that run their empire to this day. No one has seen those few survivors since, and most goblins don’t waste time thinking about them.");
			headerSub("Social structure");
			outputText("Goblins live in groups of 100-300, typically lead by an elder female with a direct bloodline to every goblin under her. ");
		}

		private function codexEntryGolems():void {
			headerMain("Golems");
			outputText("Golems have three varieties: “dummies”, “true” and “deviants”. Despite some differences between their types, they all share several basic properties: artificial bodies, extraordinarily high durability (to both physical and magical attacks), an inflexible way of thinking that grants them immunity to mental and magical manipulation, and the need of magical energy for sustenance.");
			headerSub("Dummy Golems");
			outputText("Dummy golems are quite simple constructs, usually made by apprentice and journeyman golemancers. They aren't quite as sturdy or inflexible as true golems, but can still offer a formidable challenge for young, inexperienced adventurers. When encountering these golems, it's recommended to try and deal with their golemancer first, as his defeat will sever the magical feed the golems require; even if you don't immediately notice any potential golemancers, keep alert, as they're likely to sense the fight and join in. \n\nMost golemancers create dummy golems to build the experience necessary to make a true golem, though the dummy golems are still loyal servants capable of assisting with a variety of domestic services or serving as cannon fodder to buy them time to ready up stronger artifices or spells.");
			headerSub("True Golems");
			outputText("When you hear stories about “golems”, they're often speaking of True Golems. Almost common a sight as their dummy cousins, true golems are far stronger, posing a threat to even seasoned adventurers. Although they still require a link to their master's magic, their ‟leash” is far longer, allowing the golem and golemancer to be nowhere near one another, and can even feed off environmental magic in particularly rich atmospheres. A clever golemancer can even take advantage of the golem's powerful intelligence to give it complex commands, allowing it to operate without the need for further interference to handle changes.");
			headerSub("Deviant Golems");
			outputText("Deviant golems are those with a modified core or body, often caused by outside influences, frequently resulting in independent operations without the need of a golemancer's magical link. Common rumors are simply that their masters gave them too much power or sent them to a region too rich in magical energy, overloading and severing their links.")
			outputText("\n\nAside from independence, many deviant golems exhibit bizarre powers and techniques ill-fitting an obedient construct. While no one knows the source of these constructs, it is theorized that some golemancers strayed too far from the code and produced abominations. Whatever the case, their unexpected powers can result in them being a far greater threat to those prepared to fight plain old true golems.");
			outputText("\n\n(Rewritten By: Furrin Gok; Original By: Ormael)");
			//setCodexMenusAfterDisplay();
		}

		private function codexEntryGooGirls():void {
			headerMain("Goo Girls");
			outputText("<b>Genders:</b> Asexual, but appearing female\n");
			headerSub("Body");
			outputText("Goo girls come in a variety of colors, usually coordinated to match the appearance of their surrounding environment. For this reason, blue is the most common color, followed by green or clear, though purple or even red slimes may exist. No matter the color, goo girls are always mostly transparent, their only consistent feature a red nucleus in the center of their mass, usually just behind their breast. It is a coincidence that this nucleus resembles a small, pulsing heart. Their hair is made of semi-solid slime, creating the rough approximation of a style, generally defaulting to a solid, coiffed blob or thick, goopy dreadlocks.");
			headerSub("Senses");
			outputText("Slimes will mimic the appearance of eyes, but they don’t perceive the world around them by colors or light. Rather, they respond to heat and vibration signals in the air or water, which they interpret into shapes. Particularly warm bodies are especially interesting to goo girls.");
			headerSub("Facial features");
			outputText("Goo girls are featureless at birth, but have an insatiable urge to mimic the appearance of those they encounter. Usually, they acquire these faces by sliding over the head of the creature they’re investigating, though sometimes they’ll composite several features they’ve already learned into unique combinations. They favor female appearances because they tend to be softer, which is easier to maintain, and lack facial hair, which frustrates most mimic attempts.");
			headerSub("Build");
			outputText("Body types change as Goo girls absorb bodily fluids. In their base, unfed state, they appear like large amoebae, little more than a blob of goo around a red nucleus/heart. As they increase their protein and lactate consumption, their nucleus increases its ability to maintain larger and larger surface area, producing more goo from the surrounding liquids. In sufficiently large goo girls, humanoid appearance is taken after initial contact with a suitable creature. Because increasing mass becomes exponentially harder as they grow, most goo girls maintain a volume suitable for a 4-5’ statue, though they may be found smaller or larger according to food supplies. Goo girls particularly enjoy the softness, heat, and milk of breasts and will mimic the bust size of their target’s breasts even before touching them.");
			headerSub("Appendages");
			outputText("Due to their shifting states, arms are merely a habitual expression of their tendrils. They lack the strength to pull or push in any great capacity, usually preferring to flow around obstructions. However, they have a great degree of control over the movements and pressure of their hands, fingers, and vaginal cavities, which affords them an unrivaled, delicate touch. They will gladly sculpt additional orifices to compensate multi-genital humanoids. Goo girls rarely form full legs and almost never bother with feet, preferring to let their bodies pool into a puddle beneath them.");
			headerSub("Combat");
			outputText("In combat situations, Goo girls usually revert to semi-solid bludgeoning, turning their hands into bulky, semi-acidic club-shaped appendages. Total body engulfing is another of their favorite tricks, suffocating their victims just enough to weaken them into pliability, their heat sensitivity precise enough to avoid casualties. Fire is highly effective against them, as it dissolves their slimy coating, but it also makes them significantly more acidic, leading to more dangerous counter attacks. Goo girls do not have sexual urges like most humanoids, but love to mimic appearances and behaviors, including suggestive poses, exposing engorged organs, or light masturbations. If they are provided with sufficient demonstrations, a goo girl may ‘succumb’ to lust, and allow the humanoid to explore it instead. If a goo girl is sufficiently threatened, they will eject their heart into the water, leaving an empty shell behind to distract the attacks. These \"empty girls\" persist in their old shape and behavior for upwards of an hour before reverting to sludge, but lack a guiding intellect and are therefore very pliable to guided commands.");
			headerSub("Reproduction");
			outputText("The reproductive cycle of goo girls is a curious thing, more closely resembling cells than animals. They are asexual and can reproduce by simply dividing their heart into a second girl. However, because their nuclei control their ability to adopt shapes, their size, and stores all the memories they’ve acquired, it is rare for goo girls to divide in isolation. Rather, they often congregate with others of their species and engage in what may appear to be a sexual orgy to the less discerning viewer. The semi-permeable nature of their bodies allows goo girls to ‘merge’ with one another, sharing information between their hearts. It is not unheard of for multiple goo girls to occupy the same body for weeks on end as they explore the world around them together, before splitting off, producing a ‘child’ from their merging. Because it is an equal exchange, there are no negative consequences of this sharing, goo girls naturally develop curious and forceful personalities. Larger goo girls require significantly greater humanoid fluids to maintain and expand their shapes, which gives them a 'slutty' reputation amongst non-goo creatures.");
			headerSub("Civilization");
			outputText("Goo girls do not have a formal society, meeting each other happily, sharing their memories, and parting with equal ease. Their relative fearlessness, along with their natural curiosity makes them quite determined, even around larger, stronger humanoids, like minotaurs or centaurs. As expected of a malleable race, goo girls have no sense of personal boundaries and are easily frustrated by the impermeable nature of most humanoids. Slimes who have acquired sufficient memories will often adjust their faces into expressions of petulant pouting when they don’t get their way, acquiring a forceful insistence that borders on aggressiveness. ");
			outputText("\n\nOne of the most challenging parts about understanding goo girls is their method of communication. While they always form mouths, they lack the organs necessary to produce sound. To compensate for the lack of speech, amongst other goo girls, they produce very specific heat signatures. These exothermic pulses serve as a sort of speech, communicating meaning without the necessity of taking the time to merge with one another. Their dogged body exploration may actually be a misunderstanding, explained by the fact that most humanoid creatures cannot self-regulate their body heat and, in situations of excitement, produce additional heat from their genitalia. The goo girls, mistaking this for an invitation to come closer, would be understandably confused and annoyed when the examined creatures respond negatively to slimy pressure that they seemed to be welcoming.");
			headerSub("Special notes");
			outputText("Goo girls are sensitive to heat and vibrations, which makes the act of copulation with non-goo races - though pointless - very enjoyable for them. Sex serves the dual purposes of acquiring shape memories and providing them with the protein-rich fluids they cannot acquire from the fluid around them. Additionally, they require regular exposure to moisture to maintain their bodies. While goo may be found a distance from a large body of water, it is rare and the lack of moisture tends to turn them highly acidic and a great deal more dangerous. Although it is possible to encounter goo girls with multiple hearts, they do not tend to occupy a single body for very long. There are rumors of \"Goo Queens\" who have dozens of hearts inside them, using the combined memories and membrane control to become giant, non-permeable, or even capable of speech, depending on the legend. No Goo Queens have ever been reliably identified or reported to date.");
			outputText("\n\n(Written by: Adjatha) ");
		}

		private function codexEntryHarpies():void {
			headerMain("Harpies");
			outputText("<b>Genders:</b> Exclusively Female\n");
			outputText("<b>Build:</b> The body structure of a harpy is geared towards lean muscle and minimizing weight in order to better maintain an airborne existence. Their bones are hollow, to minimize weight, and the materials they’re made from makes them nearly as strong as a human’s. Most harpies have very small breasts and only very rarely reach a C or D cup. Breast tissue is unnecessary when you do not need to lactate for your children. Hips are one attribute that harpies have in excess. Since they lay large eggs, their hips are very wide to allow the egg to pass more easily.\n");
			outputText("<b>Skin:</b> A harpy’s skin is similar to a human’s in most respects, though aside from her face and the front portion of her torso, a harpy’s body will be entirely covered with feathers to aid in flight.\n");
			outputText("<b>Hair:</b> Instead of hair, a harpy will have long, downy feathers growing from her head. Most often the feathers are brown, but can be white, red, or even blue depending on the harpy’s subspecies.\n");
			outputText("<b>Eyes:</b> Normally a harpy’s eyes are solid yellow save for a black iris. Highly corrupted harpies will sometimes have red eyes instead.\n");
			outputText("<b>Wings:</b> Harpies have two sets of wings – a primary pair that grows from their backs and a secondary pair in place of arms. The secondary pair maintain most of their arm-like structure, all the way down to having elbows and being tipped with hands.\n");
			outputText("<b>Legs:</b> Harpies have thick, powerful thighs – a useful attribute for capturing smaller mates for mid-air coitus. Their feet are tipped with razor-sharp talons that should be avoided at all costs. Many ‘victims’ choose not to resist a harpy’s attentions, in order to protect themselves.\n");
			headerSub("Reproduction");
			outputText("Like goblins, harpies reproductive systems can take almost any variety of sperm and use it to lay an egg of their own race. Unfortunately, they cannot convert demonic sperm or minotaur seed into a harpy, and in the rare instances where one of those species can force a harpy to copulate, the harpy will inevitably have to birth imps or a minotaur. For this reason harpies kill imps on sight and avoid minotaurs.");
			headerSub("Civilization");
			outputText("Harpies have never been civilized. Before the demon-times, they were considered a nuisance to most adults. Most villages filled the ears of their young males with horror stories of winged monsters that ate men. The truth is that during the fertile part of any harpy’s ovulation cycle, that harpy would ambush the first lone male she found, lock his member inside her vagina with her powerful thighs, and then take off to prevent him from escaping. After forcing the male to fertilize her for a day, she would release the exhausted victim. Harpies aren’t stupid and can talk, but they are fantastically lazy when it comes to anything other than seeing to their bodies needs. Since harpies roost on the upper reaches of the mountain, it’s inevitable that they became corrupted quite quickly. Corruption had fairly little effect on the harpies. Sure it boosted their libidos, but that only lead to more frequent masturbation. The most profound effect was a large increase in fertility and massive decrease in gestation time. Now harpies lay their eggs within a few days of insemination and the young are hatch and fully mature with the span of a month. It’s now fairly common to find the harpies prowling for a mate in the plains or hunting food in the mountain’s upper reaches.");
			headerSub("Other Notes");
			outputText("They are fond of wearing a yellow-tinted lip gloss that is made from stolen bee-girl pollen. They’ll often steal it at night when most of the bee-girls are sleeping. The pollen has little effect on the harpies, but has multiple effects on their victims. It can be absorbed through the lips or genitals of a male, and as a potent, delayed aphrodisiac it will torment the man with lust for hours. The lip-gloss also serves as a focus for a small amount of latent, magical talent. When a harpy utters a command, she will focus her magic through her lips, imbuing it with a difficult to resist compulsion. Some harpies have mastered this art, and will sing commands to lure in weak-willed men. ");
		}

		private function codexEntryHellcats():void {
			headerMain("Hellcats");
			outputText("<b>Genders:</b> Always hermaphrodite\n");
			outputText("<b>Height:</b> 5 to 6 feet tall.\n");
			outputText("<b>Body type:</b> Slender to Average\n");
			outputText("<b>Skin tone:</b> Ashen\n");
			outputText("<b>Fur/hair color:</b> Fur and hair color is always midnight black, their fur is constantly ablaze.\n");
			outputText("<b>Eye color:</b> Black sclera with yellow pupils\n");
			outputText("<b>Notable feature:</b> Their tails and hairs are on fire, always burning. Two flames run on the outer corner of their eyes\n");
			headerSub("Appearance");
			outputText("Hellcat witches looks similar to ordinary cat morphs at a first glance but their black fur and hair is literally ablaze. They favor using black robes to coat their bodies when traveling to not alarm their prey too soon.");
			headerSub("Behavior");
			outputText("Hellcats are highly aggressive and will attempt to attack and rape anyone or anything that crosses their paths save for cat morphs which they hunt, capture and sacrifice to their dark god in order to create more of their malevolent kinds. Hellcats are always in heat and rut, thus seek to soothe their burning urges by any means necessary which almost always transfers the condition to others.");
			headerSub("History");
			outputText("Hellcat witches are the faithful zealots of Abraxas, a former fire god of Mareth who became corrupted by the demons becoming a demon himself. Abraxas rewards his followers with dominion over fire and burning urges that never dies out. Since hellcats do not reproduce naturally they have to capture pure cat morphs to corrupt and sacrifice to their fire god which converts them, body and mind into new members of their unholy kind. All hellcats are female hermaphrodites as becomes any cat morph who is sacrificed to Abraxas.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryHellhounds():void {
			headerMain("Hellhounds");
			outputText("<b>Height:</b> 5.5-6 feet when standing\n");
			outputText("<b>Body type:</b> Biped or quadrupedal, it is completely comfortable with either\n");
			outputText("<b>Fur:</b> Thick armor of black fur\n");
			outputText("<b>Eye color:</b> Red, full of corrupt flames\n");
			headerSub("Appearances");
			outputText("A Hellhound looks like a two-headed humanoid with multiple canine characteristics. Its heads are a mix of human and canine features, its hind legs are digit grade with dog like paws on the ends, and its hands are covered in dog like claws. They are powerfully built creatures with quick reflexes as well with unnatural endurance.");
			headerSub("Diet and hunting habits");
			outputText("Hellhounds are predators that typically prey on smaller corrupt creatures like goblins or imps. They typically will try to overpower their prey through force, then rape their victims. After they have finished, they may decide to let their catch go, or they may proceed to devour it. While Hellhounds often will try to attack the first thing that they happen upon, they will almost never eat anything that isn’t a goblin or an imp. Their food is consumed by their flames, and any waste that results is ejected when they breathe fire. This has caused their anus to become vestigial.");
			headerSub("Sexual characteristics");
			outputText("A pair of eight inch long pointed black shafts with a quad of balls underneath that carry the same flames as in their eyes.");
			headerSub("Special abilities");
			outputText("Hellhounds can breathe corrupt flames to hurt their foes and fill them with tainted desire. Hellhounds may also sniff out a foes scent during battle, making it harder for the foe to flee. Hellhounds also have the power to link their minds with a powerful corrupted individual, drawing on that individual’s mind to allow them to think, in exchange for absolute loyalty to their new \"master\". The first power that a Hellhound generally gains from such a link is the power to speak, and the sharper their master’s mind, the greater their own abilities become.");
			headerSub("Mentality");
			outputText("The mind of a Hellhound is like that of a lost horny child when they do not have a master. It is through these mental links that their minds become whole, and cease to be that of semi-conscious beasts.");
			headerSub("Social structure");
			outputText("Feral Hellhounds (those without masters) often gather in packs, but they generally hunt on their own. When interacting with other Hellhounds, competitions for dominance are common. These competitions typically revolve around a test of seduction, with the loser submitting themselves by going down on four legs, and using its two heads to pleasure the dicks of the one that it submitted too. This is one of only two times that the Hellhound will go down on all fours, the other time being when they are out hunting.");
			outputText("\n\n(Written by: TheDarkMaster) ");
		}

		private function codexEntryHydra():void {
			headerMain("Hydra");
			outputText("<b>Genders:</b> Variable\n");
			outputText("<b>Height:</b> Variable\n");
			outputText("<b>Body type:</b> Comely man and woman mounted on the splitting body of a snake divided into multiple head segments.\n");
			outputText("<b>Skin tone:</b> Variable\n");
			outputText("<b>Fur/hair color:</b> Variable\n");
			outputText("<b>Eye color:</b> Variable\n");
			outputText("<b>Notable feature:</b> Hydras have multiple heads which regrow when cut.\n");
			headerSub("Appearance");
			outputText("Hydras resemble Nagas albeit the fact their tails splits apart in segments, each ending with a snake head. Hydras regenerate naturally and can recover from any wounds, making them near impossible to kill. Hydras all invariably got between two and twelve heads and can if needed in the heat of combat cut their own tail in order to sprout new ones.");
			headerSub("Behavior");
			outputText("Hydras are generally non-aggressive beings content with eating vermin such as mice and rats, though due to their massive size ranging from nine to thirty-six feet long and the general lusty state of Mareth, Hydras can become hazardous when horny and even deadly for smaller sentient species to encounter.");
			headerSub("History");
			outputText("Hydras began appearing on Mareth around the same time as Nagas though the firsts Hydras were likely Naga who underwent many changes from transformatives. Nowadays, the Hydra is a rare albeit deadly predator to stumble upon.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryImps():void {
			headerMain("Imps");
			outputText("<b>Genders:</b> Male\n");
			outputText("<b>Height:</b> 2 to 4 feet tall.\n");
			outputText("<b>Build:</b> Spindly\n");
			outputText("<b>Skin tone:</b> Red, orange, or rarely, purple.\n");
			outputText("<b>Hair color:</b> Rusty, red, black, and rarely brown.\n");
			outputText("<b>Eye color:</b> Totally black with glowing red pupils.\n");
			headerSub("Typical dress");
			outputText("Naked save for a ragged loincloth and a collection of small belts and pouches for storage. They seem to have a fondness for wooden sandals as well.");
			headerSub("Weaponry");
			outputText("Clawed hands and feet.");
			headerSub("Notable features");
			outputText("Four inch horns on their foreheads, small spaded tails, and tiny dragon-like wings. They are not particularly intelligent, always seeming to be about as smart as a human teenager.");
			headerSub("Sexual characteristics");
			outputText("A large human-like penis that seems to dwarf the rest of the imp, along with two human sized testes. They do have an asshole comparable to a humans, though it seems to exist more for sport and pleasure than for waste removal. ");
		}

		private function codexEntryImpTome():void {
			headerMain("The tome of Imps");
			outputText("<b>Type:</b> Tome\n");
			outputText("<b>Slot:</b> Shield\n");
			headerSub("Description");
			outputText("This questionable artefact was created by the greater demon Nalcanthet[if (silly): Herma Moira]. The lady was obsessed with and desired for her body to be used and fucked forever by her favorite pets, thus she poured her entire being into this unholy tome wich gained sentience. It is believed each imp entering a pact and living within the tome grants her increasing pleasure. Whoever owns the tome inevitably will be warped into an imp upon which the tome will attempt to claim the soul to birth an anomalous occurrence known as an Arch-Imp from the unholy womb within its page.");
			headerSub("Effects");
			outputText("Gradual transformation to the Imp race\n");
			outputText("Casting Multiplier +100%\n");
			outputText("Increase tease spells potency by 100%\n");
			outputText("These effects are amplified in the hands of a imp\n");
		}

		private function codexEntryLaBovines():void {
			headerMain("Lacta Bovines or Cowgirl");
			outputText("<b>Genders:</b> Female\n");
			outputText("<b>Skin/fur:</b> The skin tone of these creatures is very close to being human; their fur more closely follows the common Minotaur fur colors of brown, black and sometimes white with black spots.\n");
			headerSub("Description");
			outputText("A race of all female bovine-morphs more commonly known as cowgirls. They appear as tall and well-endowed women with numerous bovine characteristics. Generally they have bovine horns, ears, tail, and legs. Some are significantly more animal in appearance then others, having bodies covered in fur and animal-like faces similar to those of the minotaurs. They are relatives of the minotaurs and are similarly resilient and very strong. However, they are unusually sensitive compared to their cousins.");
			headerSub("Behavior");
			outputText("The behavior of a Lacta Bovine varies greatly between each individual. The only major unifying behaviors are their desire to give milk to almost any living creature and a high libido, common to all corrupted creatures. This instinct can become overpowering when they come to like an individual that is not currently nursing them. Even in this case, most are still able to maintain their composure.");
			headerSub("Mentality");
			outputText("Many people may believe that Lacta Bovines are similar to the 'milk sluts' brought about by mind degrading effects of excessive lactation and milkings. This stigma is similarly wrong to the mistaken belief that minotaurs are dumb brutes; Lacta Bovines are just as intelligent as humans are, and they actually have a unique resistance to the mind degrading effects that most other races experience when they are milked excessively. This is believed to be because their bodies are designed to lactate at high levels, but at extreme levels, their minds can still be ruined.");
			headerSub("Special abilities");
			outputText("A lightly corrupted creature with most of the corruption centered in their breast milk. It is addictive to those that drink it repeatedly, eventually making them dependent on the one from whom it was drunk. The milk also strengthens the drinker and helps them to relocate the one who nursed them, though that Lacta Bovine is granted limited powers of control over them. Finally, the breasts of Lacta Bovine are incredibly resilient and able to heal from almost any damage, even being cut off. They are also able to produce an almost limitless supply of milk. The flow may lessen over prolonged milkings, but it doesn’t actually stop. Fortunately for all involved with them, their breasts generally don’t leak milk. Thus, they can produce milk for their entire life without fail.");
			headerSub("Reproduction");
			outputText("Lacta Bovines reproduce by finding a suitable mate and first addicting them to their milk. Once their bodies determine that they are giving milk regularly to a creature they like, they will become fertile and will be able to be impregnated by their partner. Any children that result from this union are almost always new Lacta Bovines, as a secondary effect of milk addiction is that it dilutes down the strength of the drinker’s seed causing their traits to become recessive. However, this is not perfect, and it’s very possible for Lacta Bovines to mate with those who have not been completely diluted down yet. This is where the more human appearing ones originate. A Lacta Bovine pregnancy typically lasts 28 days.");
			headerSub("Reproduction side note, Minotaurs");
			outputText("Minotaurs are a common partner with the more bestial Lacta Bovines, and their seed is so strong that it isn’t uncommon for the first child in such a union to be a minotaur, with the rest being Lacta Bovines. At the same time, such unions are often short-lived, and it is quite possible for a Lacta Bovine to move to a different mate during a pregnancy. ");
		}

		private function codexEntryLizans():void {
			headerMain("Lizans (Lizard-Morphs)");
			outputText("<b>Genders:</b> Male, Female, Hermaphrodite\n");
			outputText("<b>Height:</b> Shorter than Average to Average (5'4\" to 5'11\")\n");
			outputText("<b>Build:</b> Lean and slender\n");
			outputText("<b>Skin:</b> Black, Blue, White, Green, Red, Silver, Purple\n");
			outputText("<b>Hair:</b> None\n");
			outputText("<b>Eye color:</b> Varies\n");
			headerSub("Appearance");
			outputText("Lizans resemble bipedal, humanoid lizards, with expressive reptilian snouts filled with teeth, digitigrade legs with lizard-like claws, no visible ears, no hair, scales covering the entirety of their bodies, and tapered, prehensile tails. Instead of hair, Lizans may have zero, one or two pairs of draconic horns; horns are often regarded in their culture as being marked by destiny.");
			headerSub("Sexual characteristics");
			outputText("Male Lizans naturally have two penises of equal length and girth; these are characterized by their vivid purplish hue and exotically lumpy appearance. As a consequence, the anuses of Lizans are easily comparable in sexual sensitivity and receptiveness to vaginas; because a female Lizan is invariably double-penetrated with even a single male partner, they have evolved to feel just as much pleasure in their anus as in their vagina. Female Lizans typically have smaller breasts; A-cups are the norm in their culture, and few naturally grow above a C-cup. Hermaphrodites have the characteristics of both sexes. This means interspecies relationships with Lizans can be a little awkward; female Lizans often need to invest in toys to stimulate their back passage with when mating with other races, while males and herms can have problems understanding that their partners don’t like anal sex. Many Lizans have a fetish for lactating breasts and/or long hair, because the phenomena is unknown among their kind.");
			headerSub("Corruption");
			outputText("Corruption in Lizans manifests primarily mentally, inducing them towards typically demonic behavior – an erosion of mores, loss of interest in anything besides sex, increasing lack of compassion & empathy, etc. Similarly to the also-oviparous harpies, corrupted Lizans produce eggs more frequently than uncorrupted Lizans, and they also produce much larger clutches. The standard increases to cock and breast size go without saying.");
			headerSub("Diet");
			outputText("Lizans are predominantly carnivorous, though they are omnivorous enough that they can be opportunistic feeders. They traditionally consume their prey raw, in order to cannibalize its juices to hydrate their own bodies – a helpful adaptation in the deserts and hot grasslands where they tend to live.");
			headerSub("Reproduction");
			outputText("Similarly to harpies, Lizans are oviparous; females lay eggs, from which hatch new Lizans – these infants are highly independent and ready to eat meat from when they hatch. As a result, the breasts on a female or herm Lizan are just for show and they do not lactate. Unlike harpies, Lizans actually produce fully-fledged eggs in their womb as part of ovulation – essentially, a pregnant-looking midriff is a sign that a Lizan is now ready to be fertilized, rather than a sign she has been fertilized. If she mates before she goes into labor, then the eggs will remain in the womb for several more days, growing larger as the embryos form inside them, before being laid. The fertilized eggs will be carefully guarded as a \"clutch\", with the mother waiting for the fertilized eggs to hatch. If the \"pregnant\" Lizan doesn’t mate, then the eggs are laid as unfertilized. In this case, the mother traditionally eats them, in order to replenish the depleted nutrients and protein – being offered one of a Lizan’s own eggs to eat is a sign that she finds you very attractive and is interested in mating with you. A Lizan herm or female will typically produce 3 or 4 eggs per clutch, and will produce a clutch every 30 days. Larger clutches aren’t unheard of, especially if the Lizan mates with an extremely virile/potent mate, but typically high fertility manifests in a decrease in the times between laying – normally, this would mean a Lizan grows gravid every 15 days, but in this tainted world it’s possible for a Lizan to make eggs every day. Unfertilized eggs are small, about the size of a chicken’s, while fertilized eggs are considerably larger (think the difference between eggs and large eggs from Ovi Elixir). Like all anthropomorphic Marethian species, Lizans can crossbreed with humans. However, they may be the race most likely to produce mixed bloods (beings that look more like humans with animal traits, such as legs, tails and ears, rather than humanoid animals) instead of pure bloods of one parent's race or the other (usually the anthro's race).");
			headerSub("Culture");
			outputText("There are functionally two different Lizan cultures; that of the desert Lizans, and that of the plains Lizans. Both groups are a contemplative, spiritual culture, offering reverence to the various god-spirits of Mareth that they deem important to their lives, such as their creator-spirit and the spirits of the rain. They typically wear little in the way of clothing; most settle for a loincloth about their nethers, for modesty’s sake, and/or a long hooded cloak to keep the worst of the dust and sun off. Prone to being superstitious, many Lizans adorn themselves with assorted bangles and geegaws, talismans intended to attract good spirits and ward of evil spirits. \"Shamans\" and similar mystics are quite respected in Lizan culture, and it’s often a position held by the natural-born hermaphrodites. Lizans of the desert are quiet and peaceful by nature, wandering the lands alone or in small, family groups, eternally seeking food and drink to sustain them through the day. Family groups rarely cross paths, but when they do, it is a time to celebrate – often, members of the group will trade, in order to found new families of their own, in time. This is not to say that they are pacifists or cannot fight, merely that they prefer to hold peace. Lizans of the plains, on the other hand, are violent and warlike, which they blame on the constant harassment by their ancient enemies, the gnolls. Gathering in large clans of multiple extended family groups, they place emphasis on breeding and on honing war-like skills; hermaphrodites are honored amongst their culture for their ability to impregnate and be impregnated at the same time. Indeed, if there are too many members of one gender in a tribe, members are exhorted to use gender-modifying items so there can be more phalluses to fertilize eggs with or more egg-generating wombs.");
			headerSub("History");
			outputText("The precise history of the Lizans is lost in the mists of time. Oral tradition claims that they were created by a lizard deity who admired the idea the other deities had to uplift the animals of Mareth into humanoid beings, but scorned the idea of uplifting mammals, who he saw as weak and soft. Instead, the spirit chose to uplift the hardy lizards of the plains and the desert.\n");
			outputText("To be honest, there is nothing of real importance to the history of Lizans. They have simply always been there, roaming the hot, dry regions of the world and keeping primarily to themselves. They have little use for other races, and most races have little use for them.");
			headerSub("Current status");
			outputText("Because of their historically dispersed nature, the desert Lizans have not really suffered noticeably at the hands of the demons; they are simply too widespread and nomadic to bother hunting down en masse, not that this prevents demons who have the opportunity to enslave them from doing so. The fact they naturally come with two dicks and a love of anal sex makes them quite appealing. The plains Lizans, though, are functionally extinct as a pure race; except for some emigrees from early on in the invasion, all plains dwelling Lizans are now at least moderately corrupt, and as hermaphroditism has become quite widespread, their numbers are flourishing.");
			headerSub("Inter-species relationship");
			outputText("All uncorrupted Lizans hate demons. Personal reasons for doing so vary widely, but the racial reason is simple; the demons’ preventing of the rain for years and years has caused many deaths among their number and rendered it increasingly hard to survive in the hot, dry regions where they live. The race that desert Lizans most interact with is the cult of the Sand Witches, and the relationship there can be said to be one of love/hate. As noted above, many Lizans find lactating breasts to be a fetish, males and herms appreciate the twin pussies that sand witches possess, and all sexes find the abundance of nutrient-rich fluids that can be sucked from a Sand Witch quite helpful in the dry climates of their home. Sand Witches don’t necessarily mind the attention, and rumors say there are more than a few mixed blood Lizans in the desert as a result, but are fiercely possessive of their milk and fixated on adding new recruits to their cult. As a result, more than one male Lizan has spent at least some time as a lactating shemale as a result of underestimating them. Plains Lizans are defined by their constant war against the gnolls. Lacking individual strength by comparison, they have always depended on numbers to fight back against the hyena-morphs, and thus they have given themselves over to corruption.");
			outputText("\n\n(Written By: Quiet Browser)");
		}

		private function codexEntryMagic():void {
			headerMain("Magic");
			outputText("Magic comes in three varieties, \"white\", \"grey\" and \"black\". Despite what they are called, the names of the magic types do not necessarily associate with any kind of \"moral alignment\". Black magic could be used for good just as easily as white magic could be used for evil. However, most demons prefer black magic, and those who fight them tend to prefer white magic. The primary difference between them is where the magic’s power is drawn from. Black Magic is drawn from the emotions and feelings of the body, while White Magic comes from the thoughts of the mind.");
			headerSub("Black Magic");
			outputText("The power of Black Magic is drawn from emotion and feeling, and thus is most easily able to affect the bodies of others. Demons and monsters often use black magic in order to aid in the rape and corruption of innocents, as arousing a target is one of the first things a disciple of Black Magic learns. Black magic can also change the size and functions of bodily parts in strange ways, but it is incredibly difficult to use on oneself, as it interrupts the flow of power from the body. Most users of Dark Magic only learn to draw their power through their lust, rendering it impossible to use when turned off.");
			headerSub("Grey Magic");
			outputText("It's not so easy to describe what exactly is Grey Magic. What is sure is that it's magic that requires outstanding intelligence to even understand the basic principles of it. Most of its spells are, as one can say, 'grey,' not differentiating between good or bad, pure and corrupted. In most cases, this magic causes almost monumental effects, like attacking huge areas of the battlefield, dealing an unbelievable amount of damage to a single target, or causing other bizarre things, like unnatural transformations even for Mareth standards. The source of this magic is also quite unclear, as it is drawn at the same time from sources used by both White and Black magic, requiring the caster to be neither too horny nor too calm to use them. Some mages even joke, saying that all White and Black magic spells actually came from some of the old grey magic spells after losing much of their former power and becoming too attuned to calm or horny casters. How much truth is in that, only true Grey Archmages could know.");
			headerSub("White Magic");
			outputText("The power of White Magic is drawn from the mind, but is more often called the power of the soul. White Magic is considered \"stronger\" than Black Magic because it can be used to create energy from nothing or heal the body. Users of White Magic can blind their opponent with dazzling lights, burn them with pure white flames, or even magnetically charge weapons and armor to repel each other, making them more resistant to attacks. White Magic requires significant mental discipline and awareness, and becomes impossible to cast if the user is greatly distressed or aroused. ");
		}

		private function codexEntryManticores():void {
			headerMain("Manticores");
			outputText("<b>Genders:</b> Exclusively female\n");
			outputText("<b>Height:</b> 5 to 6 feet tall.\n");
			outputText("<b>Body type:</b> Slender to Average\n");
			outputText("<b>Skin tone:</b> Light\n");
			outputText("<b>Fur/hair color:</b> Fur between midnight black and blue-black. Hair color range a lot depending on the individual between red gold and white as do the mane.\n");
			outputText("<b>Eye color:</b> Red\n");
			outputText("<b>Notable feature:</b> Tailpussy\n");
			headerSub("Appearance");
			outputText("Manticores typically have the chimeric features of a human crossed with a lion, scorpion and bat. Their scorpion tail tip is covered with spikes which can be shot with as much power as an arrow and on demand, removed to be used like a dagger. Those bony spikes are constantly dripping with their poison and they have a habit of impaling their victims with them during sex to make sure the flow of cum doesn't end.");
			headerSub("Behavior");
			outputText("Manticores prefer mountainous areas where they can lie hidden for days in order to ambush their prey. They are notoriously known for singing while milking their victim dry. The reasons for this behavior was never confirmed, but it's assumed they simply feel as much stimulation from their tail as the man feels from his dick. Thus, they sing to express it. Sadistic to the extreme, they delight in the pain and torment of their victims, thus making them natural dominatrixes. However, they show signs of vulnerability when the table is turned, even bowing down to a superior male in a way that is not so different from lions prides and wolf pack hierarchy. Some manticores have actually been seen living happily in civilized areas as consorts to powerful Marethian heroes in the past. Though, anyone strong enough to defeat a manticore in battle should be considered mighty indeed.");
			headerSub("History");
			outputText("The manticore, also called man-eater, is an all female species originally from Mareth, although one could say the current variant could trace its origin to the demonic invasion.\n");
			outputText("Out of all races, they likely struck out the best deal when the demons came, as even back then they were already notorious sexual predators feeding solely from cum. As one could see, despite the small additions to their tail, their succubus like behavior hasn't changed at all since the early days of Mareth. While it is unclear when the manticore’s tails evolved into the nightmarish semen drinking tools they have now, the demons are clearly responsible for it. Their flower-shaped tail pussy can easily milk any penis at a pace of several milliliters per second, making them the worst nightmare of any unlucky male that crosses their path.");
			headerSub("Venom Effects");
			outputText("Their venom is a powerful aphrodisiac which causes the body to grow more sluggish and aroused with each intake. Furthermore it has the property of massively increasing one's cum production for a short time.  If ingested through the mouth, it can be used as a transformative.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryMinotaurs():void {
			headerMain("Minotaurs");
			outputText("<b>Genders:</b> Male\n");
			outputText("<b>Height:</b> 7 to 10 feet tall.\n");
			outputText("<b>Body type:</b> Heavily muscled with a thick coat of shaggy fur.\n");
			outputText("<b>Skin tone:</b> Brown, black, or white with brown spots.\n");
			outputText("<b>Fur/hair color:</b> Matches skin tone. Very rarely straw colored.\n");
			outputText("<b>Eye color:</b> Brown or black.\n");
			outputText("<b>Notable feature:</b> Primarily bovine facial structure with barely noticeable human attributes (mainly eye shape/placement). They tend to have large forward-pointing horns, floppy bull ears, a tufted tail, and hooves where most races have feet.\n");
			headerSub("Typical dress");
			outputText("Minotaurs favor loose fitting skins and loincloths. They tend to avoid anything resembling pants as it can dangerously constrict them when they become aroused. Minotaurs rarely carry any supplies with them, preferring to scavenge or plunder anything they need.");
			headerSub("Weaponry");
			outputText("Fists, horns, and when they can find them, axes.");
			headerSub("Sexual characteristics");
			outputText("A two to three foot long penis with a flared tip. Typically they have two to three bands of thick skin encircling the shaft, spaced evenly along its length. The purpose of this is unknown. Minotaur testicles vary in size depending on how long the minotaur has gone without orgasm. They typically shrink down to the size of baseballs when empty, but can swell as large as basketballs for particularly unlucky cow-men. This is quite painful for them, and is made worse by due to the difficulty they have orgasming without a tight opening to impregnate. It is not uncommon for the loser in a minotaur dual to be brutally sodomized, if only for the winner to relieve his aching pressure. All minotaurs are male, but their seed is so potent as to totally override the mother’s race, resulting in the birth of yet another pure-blood minotaur. Minotaurs bodily fluids are renowned for their magical properties, but great care must be taken to refine them for any proper use.");
			headerSub("Mentality");
			outputText("Most beings think of minotaurs as stupid brutes, but in truth their intelligence rivals that of humans. This misconception is perpetuated by the fact that minotaurs place a much higher priority on their self-reliance, strength, and sexual release than other races, often leading them to ignore social graces in favor of trying to overpower those around them.");
			headerSub("Minitaurs");
			outputText("The bastard runts of the minotaur race, Minitaurs are rare human-sized minotaurs born with straw colored fur and none of the muscular fitness indicative of the rest of the race. Possessing curvy (but breast-less) bodies, they often wind up as cum receptacles for their larger over-bearing cousins. They do not share ‘release’ problem, but tend to have sexual equipment of similar size to normal minotaurs. This makes them a bit disproportional, but much easier for full-minotaurs to catch. They rarely try to escape anyway, due to the addictive and drug-like nature of large doses of minotaur spunk. ");
		}

		private function codexEntryNagas():void {
			headerMain("Nagas");
			outputText("<b>Genders:</b> Male, Female\n");
			outputText("<b>Length:</b> Varies a lot. 10-12 feet is considered as average. There are no noticeable size difference between males and females.\n");
			outputText("<b>Build:</b> Slender\n");
			outputText("<b>Hair:</b> Jet black, other colors are seen as very exotic in societies\n");
			outputText("<b>Eyes:</b> Mostly blue and light brown\n");
			outputText("<b>Skin (body):</b> Tanned to various degrees, as Nagas prefer to live in desert regions.\n");
			outputText("<b>Skin (tail):</b> Anything goes. It is possible to track the origin of any given Naga just by looking at the color of his tail..\n");
			headerSub("Appearance");
			outputText("Normal humans with a snake body from the waist down. They also have a rather long forked tongue (5 usable inches, though they rarely extend it this far) which they flick out every so often to get information on their surroundings.");
			headerSub("Sexual characteristics");
			outputText("Nagas, just like snakes, have no external genitalia. Those remain concealed in a genital slit until needed. Unlike actual snakes and lizards, however, the genital slit is distinct from the anus which is also on the front, as Nagas have no buttocks. Male Nagas usually have two penises ranging from 5 to 10 inches. Nagas a foreign race to Mareth. Only gods can recall of the last time one have ever seen a Naga roaming on these lands.");
			headerSub("Social structure");
			outputText("Most Nagas live in groups of 100-150. Living in such small communities means that everyone is likely to know each other, something that influenced their culture a lot. Nagas communicate using a mixture of soundwaves and ground impulsions. They can still communicate using only one of these methods, but their vocabulary will be limited as a result. They pick up the impulsions through the underside of their tail, which is full of sensitive nerve endings. This also a makes it a major erogenous zone, explaining why Nagas enjoy coiling together while mating. Their particular sense of hearing means they can’t \"hear\" the difference between a human talking and a Naga saying the same thing : they understand both but to answer back, they have to know that difference and they need to learn to speak this way too.");
			headerSub("Culture");
			outputText("The stereotype portrays Nagas as very narcissistic and eccentric, often wearing ornaments made of precious metals and fine fabrics. In reality, Nagas are very modest and are taught that the only valuable things in life are those that can benefit to everyone. Not counting emotional attachment, they usually don’t value what they own. They believe that all Nagas are related in some way and highly respect each other. Nagas rarely come in contact with other sapient species both due to the fact that they live in very inhospitable regions and because of the complex language barrier that refrains them from properly communicating with anyone else.");
			outputText("\n\n(ElAcechador – Author of the desert’s Naga girl.)");
			outputText("\n\n(<b>Fenoxo's Note:</b> Player Nagas still have butt-cheeks and their rectum (damn near killed him!) on the back because Fen likes his girls to have junk in the trunk. And also he doesn’t want to rewrite all the anal scenes.");
		}

		private function codexEntryOrcs():void {
			headerMain("Orcs");
			outputText("<b>Genders:</b> Children are born as boys or girls. It is rare to see an Orc that is both or neither of these, they are very similar to humans in this respect. They do not typically practice gender alteration.\n");
			outputText("<b>Body structure:</b> On average they are taller and wider than humans. It’s been recorded that some Orc men have reached 10 feet tall, though most stop developing at around 7 feet and women are on average a few inches shorter.\n");
			outputText("<b>Facial:</b> Compared to humans, Orc noses are typically smaller and more pressed in. Their ears are pointed without being any longer than a human’s. The only other notable difference is they grow a pair of tusks from their lower gums that grow outward to protrude from the lips and curl upwards, though the direction can change according to breeding.\n");
			outputText("<b>Hair & Eye Coloration:</b> Darker hair colors such as black and brown are the norm for both men and women, although colors such as blond and even bright red have been recorded. It is unclear if blond and red hair are a mutation, however. Eye colors have a very wide range, from silver to dark purples. Among the Orcs, eye colors are considered beautiful. The colors widely vary between individuals, thus making eyes a notable feature in Orcish art, writing, and courtship.\n");
			headerSub("History");
			outputText("Being one of the more peaceful races in history, they are also one of the most secluded. While Orcs are happy to trade and coexist with other races, Orcish settlements tend to keep to themselves. Their focus on diplomacy, as the Orcish cities of old were founded on making peace with its neighbors. There is no recorded incident of a settlement attacking another race simply to expand. Though they avoid conflict, they are far from defenseless. The trained elite of Orcish warriors are feared for their battle prowess. However, when the demons invaded their cities the Orcs fled, scattering their numbers and fragmenting their once formidable power. Though their strength is only a memory now, what collection of small settlements they have are growing in strength and power once again. Currently numerous settlements have been developing separately, using their own dialects and culture alterations. Despite their diversity they all share similar cultural themes provided by their ancestry.");
			headerSub("Sexuality");
			outputText("The average Orc is bisexual except for a select few who don’t have a taste for the other sex. To Orcs gender matters very little, they look to one’s preference or willingness to dominate or submit. Both men and women value honor and dignity but nothing is more arousing than power, most commonly displayed by body strength. Physical combat is extremely stimulating and exciting on a sexual level, and arousal is most potent when the combatants are evenly matched. The common theory is that Orcs release the most pheromones when engaged in combat. For this reason there are few warriors. Those that wish to take on the lifestyle of a warrior must first work past this racial quirk to meet their maximum potential.");
			headerSub("Courtship");
			outputText("Men and women are on equal ground socially. It is equally common to see a female dominate a male as it is to see vise versa. When the dominatrix is in question usually the pair (or party) will decide through a wrestling match or various other forms of physical combat. The most common relationship practiced is two men with one female. The female serves as a means of reproduction while the two men compete with each other over her affections. The only notable difference between Orcish men and women is when weakness is taken into account. It is looked down upon within Orcish culture to breed with a weak female, or letting a weak male breed with a female. Even in their peaceful culture, breeding with partners that increase the chances of weak offspring is looked down upon. There seem to be no moral trappings for a dominate male to take a weaker, submissive male or two for himself, since the possibility of breeding is impossible. Without a potentially weak offspring there is no fear of cultural backlash.");
			outputText("\n\n(By: Donto) ");
		}

		private function codexEntryRaijus():void {
			headerMain("Raijus");
			outputText("<b>Genders:</b> Male, Female\n");
			outputText("<b>Height:</b> 5 to 6 feet tall\n");
			outputText("<b>Build:</b> Slender to Average\n");
			outputText("<b>Skin tone:</b> Light\n");
			outputText("<b>Hair:</b> Fur and hair color is generally the same color as lightning ranging between purple teal and yellow.\n");
			outputText("<b>Eye color:</b> Generally in all shades of greens and teals\n");
			outputText("<b>Notable feature:</b> Lightning shaped hairs\n");
			headerSub("Appearance");
			outputText("The raiju or storm weasel is a species of animal morph especially attuned to lightning, its body is constantly building up electricity. While it is not harmful to the raiju itself this static electricity causes its arousal to constantly increase in proportion to the voltage stored. Unable to achieve orgasm on its own a raiju will seek a partner to discharge its electricity and achieve release. A raiju can cause massive pleasure from a simple touch and its electricity is unstable by nature. Creature who were jolted by a raiju would be well advised to avoid masturbating until the discharge is gone for the electricity build up on pleasure and will only increase as a result of self indulging.");
			headerSub("Behavior");
			outputText("The Raiju prefers to live in mountainous area where they are closer to the sky. Generally hunting alone, a raiju’s presence will cause the wildlife to flee in panic. Raiju feeds from ambient static therefore they do not need to hunt save for a partner to discharge their flux.");
			headerSub("History");
			outputText("Raiju’s are a natural Marethian species. And have been recorded to exist since the appearance of animal morphs. Its unknown which gods created them but it's clear the god of storms had a hand in it.");
			headerSub("Storm jewels");
			outputText("Sometime raiju electricity will somehow coalesce into a crystal known as a storm jewel. A Storm jewel can be used as a potent energy source if well handled but its volatility makes it hazardous to use as it can accidentally dissolve back into lightning and discharge itself on whatever unsuspecting individuals holds it.");
			outputText("\n\n(Written By: Liadri)");
		}

		private function codexEntryRhinos():void {
			headerMain("Rhino-Morphs");
			outputText("<b>Genders:</b> Male, Female\n");
			outputText("<b>Height:</b> 7 feet 6 inches to 8 feet 6 inches\n");
			outputText("<b>Build:</b> Thick/curvy \n");
			outputText("<b>Skin:</b> Pale grey to dark grey\n");
			outputText("<b>Eyes:</b> Brown to black\n");
			outputText("<b>Diet:</b> Omnivores, though still have a penchant for the good old food: leafy plants, branches, shoots, thorny wood bushes, and fruit. \n");
			headerSub("Appearance");
			outputText("A bipedal race of anthropomorphic rhinos, this species is massive, standing approximately eight-foot tall, and are thick to put it mildly. They have roughly humanoid body characteristics, save for their rhino-like face, four-fingered hands and four-toed feet, and the main non-human feature, their rhino-cocks. With their thick pale to dark grey hide, horse-like ears, extended snout with one or two horns protruding out the upper side, this species looks to be ready for war.");
			headerSub("Behavior");
			outputText("Rhino-morphs are a naturally occurring species in Mareth. The rhino-morphs were best known for their dualistic psychological nature. ");
			outputText("\n\nOn one hand, they tend to be gentle giants: some are boisterous and loving creatures who care a bit too much and wear their emotions on their sleeve. Others are more quiet and reserved. Their personalities are as varied as any other race but their default state is one of kindness and community. Even before the fall they were known to adopt members of other species into their crashes and treat them as family because to a rhino that’s what a crash is, their family.");
			outputText("\n\nOn the other hand they can become irrational and exceptionally violent: Many rhinos have never experienced this, but those who have describe it as a switch turning off and their blood burning. Their gentle caring nature is overridden and they go into a targeted rage that usually results in someone or something getting the crap beaten out of them. This change takes an extreme amount of mental and/or physical stress and there are many warning signs so avoiding getting a rhino morph riled up was always easy. There was an old saying in Mareth, \"<i>You mess with the bull, you get the horns. Mess with the rhino and you deserve the horns.</i>\"");
			headerSub("Reproduction");
			outputText("\n\nRhino Morphs were also known for their lifelong, monogamous couplings which caused a firm belief in marriage and family rearing.");
			outputText("\n\nRhino morphs produce one calf at a time. Before the corruption this process took months and was a celebrated occasion. Children were a great and wonderful treasure and it was considered a great honor to have a child with a rhino morph because they were indiscriminate with their love. It didn’t matter if their children were rhinos or not.");
			headerSub("Corruption");
			outputText("Initially the demons learned to fear the rhino morphs. They took in survivors from other villages into their nomadic crashes and protected them with their tough hide and weapon like horns. Yet ultimately their dualistic nature caused them to trust demons that didn’t show themselves to be aggressive. This allowed the demons to walk among them. One thing lead to another and eventually the corruption swept through the crashes like a million birds of prey felling a field of mice petrified with fear.");
			outputText("\n\nDespite the corruption they still form married pairs but they are never monogamous.  Their once great love of their offspring has been completely changed and now they tend to not produce offspring by choice, the males and females have evolved corrupt organs that reduce fertility.");
		}

		private function codexEntrySalamanders():void {
			headerMain("Salamanders");
			outputText("<b>Genders:</b> Males and Females occur naturally, though transformative items leave none too few Salamanders as hermaphrodites or genderless.\n");
			outputText("<b>Body structures:</b> Salamanders stand taller than most humans – usually between 6.5 and 7 feet tall. They have human-like bodies, though their forearms and legs, up to the mid-thigh, are covered in thick, leathery red scales. Their hands and feet have powerful claws that, combined with the natural strength of a Salamander, allows them to easily rend through even some metals. Salamanders also possess a long, prehensile tail that is usually alight with a burning fire.\n");
			outputText("<b>Facial structures:</b> Salamanders have human-like faces, save for the smattering of scales on their cheeks (akin to freckles on a human), and frilled, reptilian ears.\n");
			outputText("<b>Hair & Eye Coloration:</b> Salamanders have red, orange, and rarely, pink hair. Most members of the species have bright red eyes, though some few manifest yellow or grey-blue eyes.\n");
			headerSub("Fire mastery");
			outputText("Salamanders have a natural, elemental mastery over fire. Their tails are a natural source of fire, which they are able to extinguish and re-light at-will; a Salamander’s interior is also described as exceedingly hot, often leaving lovers sweating on contact. They are by and large immune to natural fire, including that of dragon-morphs, though spell-fire’s effect on them is unknown.");
			headerSub("Berserking");
			outputText("Salamanders are notorious for their fiery, impassioned personalities, and this is nowhere more evident than their enraged fighting style. Salamanders throw their heart and souls into combat, letting their rage overcome them until they’re literally half-mad and their bloodthirst seems unquenchable. Even after battle, it is difficult to calm their passions, and most Salamanders prefer – if not need – to engage in visceral activity after combat, usually taking the form of sexual intercourse with friends, loved ones, or defeated enemies.");
			headerSub("Sexuality");
			outputText("Thankfully, the remote nature of Salamander society has prevented the race from being overexposed to demonic influences. Still, even before the demons came, Salamanders were energetically sexual, and were infamous for their enthusiasm for group sex. Salamanders are a notoriously infertile race, however, and their birth rate was dangerously low. This was only exacerbated by the demonic invasion, and most of the remaining Salamander tribes have crumbled to single-digit populations. A Salamander pregnancy takes many months to complete, though they tend to be less encumbered by their pregnancies than human women are.");
			headerSub("History");
			outputText("One of Mareth’s less civilized races, even before the demon invasion, the Salamanders lived in hunter-gatherer tribes in the wide open plains, foothills, and mountains. Though exceedingly violent, the Salamanders destructive tendencies were kept in check by the savage gnolls, and the two races have shared a bond of mutual hatred for centuries. They will attack each other on sight, and their bloody battles have kept both races from posing a serious threat to the civilizations of Mareth before the demons, and to Lethice after their arrival.");
			outputText("\n\n(Written by: Savin) ");
		}

		private function codexEntrySandWitches():void {
			headerMain("Sand Witches");
			outputText("<b>Genders:</b> Exclusively female\n");
			outputText("<b>Height:</b> Sand Witches are typically five to six feet tall.\n");
			outputText("<b>Hair:</b> Always sandy blond.\n");
			outputText("<b>Eyes:</b> The eye color of Sand Witches varies from witch to witch, but is most often brown.\n");
			headerSub("Appearance");
			outputText("Sand Witches normally dress in loose fitting robes and little else. They will sometimes wear well-made sandals, and a belt to carry a few simple supplies. They are all young, either they do not age or have found a way to hide its effects. Because of the coloration of their hair and robes, it is difficult to spot a Sand Witch until she is right next to you.");
			headerSub("Sexual equipment");
			outputText("Sand Witches ALWAYS have four heavily lactating breasts with large prominent nipples. Few creatures can rival their milk production, and those that do wind up captured by the Witches and taken to their remote desert hideout. Somehow all Sand Witches always have multiple vaginas, though most of them only have two. Their methods for procreation and altering the number of vaginas are unknown.");
			headerSub("Reproduction");
			outputText("Pregnant Sand Witches have never been seen. They have either discovered a perfect contraceptive or kept all the pregnant members of their cult in seclusion.");
			headerSub("Social structure");
			outputText("Sand Witches live in remote covens deep in the desert. While the specifics of the living arrangements that far out are unknown, it is known that the covens tend to be comprised of at least 25 members, each lead by a leader with the title of ‘Sand-Mother’. The cults are governed together by a council of the 7 Sand-Mothers with the largest covens.");
			headerSub("Special attributes");
			outputText("Sand Witches are adept users of black AND white magic, and will use the combination to arouse their foes into submission, and then alter them into a form more like their own. They are not necessarily hostile, and will treat any they encounter nicely if they allow the witch to work her magic on them. ");
		}

		private function codexEntrySatyrs():void {
			headerMain("Satyrs");
			outputText("<b>Genders:</b> Males (Females used to exist)\n");
			headerSub("Backstory");
			outputText("Satyrs were originally a dual-gendered race of \"10% furry\" (legs, tail, horns, possibly ears) goats that came in both male and female. In those days, they were called \"Fauns\". The Fauns believe themselves to be, at least metaphorically, the children of one of Marae's pre-demon demigodlings, a hermaphroditic spirit in the form of an anthro goat named Baphomet. This spirit was a god of pleasure, love, fertility, virility and carnality; as a result, the Fauns were very friendly - and very horny - individuals, constantly playing games, dancing, making music, drinking strong drink, and having sex. They were renowned for their bacchanals and orgies.\n");
			outputText("They were also notorious for their mastery of sex-related magic, essentially the Black Magic of Mareth today. There were few races more adept at producing cures for infertility than Fauns.\n");
			headerSub("General behavior");
			outputText("Fauns live their lives to worship their guardian deity, Baphomet. They preach their religion by planting seeds of the fruit they collect; by brewing an aphrodisiac wine to be used in their parties, and by having sex. They would lure passer-bys with the promise of fun and pleasure by the means of a party to celebrate their god, this would often result in massive orgies since the wine in said parties happens to be their special brew of aphrodisiac wine. In their wake they would leave a few very satisfied lucky souls and small mounds of earth, where they planted new seeds to thank the nature for the gift of nourishment and pleasure.\n");
			outputText("Fauns would often be contacted by people who were infertile in hopes of healing whatever prevented them from having children. While it is true that often the Faun magic that would cure them would take the form of sexual contact with a Faun of the opposite sex, this rarely resulted in \"curing\" them by leaving them the mother or father of a baby Faun. Only in the most grievous cases would a Faun offer to serve as a stand-in stud or broodmare for a family in desperate hope for children.\n");
			headerSub("The Corruption");
			outputText("The corruption had a drastic effect on the Fauns' previously peaceful way of life. Because of the sexual openness of Faun culture, they were among the earliest victims of demonic influence; they literally welcomed the corruption into their souls with open arms; and before they knew it, they were being poisoned by sexual contact with the ever-insatiable corrupt legions. The denizens of Mareth owe the sudden spike in imp population to the Fauns. Eventually the females, weakened by repeated births, perished, leaving only the lust-crazed males behind. The corrupted Fauns, now called simply Satyrs, found a way to circumvent the problems that arose from the death of their females. Through the use of potent black magic, they made their seed extremely potent and able to impregnate anything that they happened to fuck, even each other.\n");
			outputText("They have abandoned their former creed of mutual pleasure to be shared amongst the willing, to instead live their lives in pursuit of excess and carnal luxury, just like the demons. When a Satyr is not seeking new mates to impregnate, they are usually drinking and polluting the nearby area with their aphrodisiac wine. They still lure passer-bys with the promise of fun and pleasure, only this time the purpose is solely to lure new victims to become the mothers of more satyrs.\n");
			headerSub("Gestation and birth");
			outputText("Satyr seed is infused with highly corrupt magic that enables them to literally impregnate anything. When confronted with a female or a herm of another race, the Satyr will try to fertilise them in the usual fashion; because of their tainted seed, pregnancy is all but guaranteed, and high fertility may actually result in the birth of multiple satyrs. However, so virile are satyrs that they are actually capable of anally impregnating male and neuter-gendered individuals. The thick ejaculate floods into the subject’s bowels and solidifies into a tough, leathery, egg-like mass. The interior of this egg is hollow and filled with corrupt fluids that serve as an amniotic \"soup\" in which a near identical clone of the Satyr \"father\" is grown. This infantile satyr grows inside the pseudo-womb like a regular infant would in a normal womb, with all of the usual symptoms - distended midriff, strange cravings, increased lust, sensations of movement, etc. When the infant grows large enough, the egg breaks down and the \"mother\" goes into labor, the liquified pseudo-womb serving as lubricant that, combined with the motions of the anal passage, brings the baby satyr into the world.\n");
			outputText("Once exposed to the outer world, the satyr's corrupted body rapidly matures until it attains full reproductive adulthood - puberty. Invariably, it will flatter its mother and offer to leave them \"something to remember him by\", but it retains enough civility to not become violent if they turn down this initial offer. On subsequent meetings, though, the new satyr will strive to incapacitate them and rape them into pregnancy once more.\n");
			headerSub("General behavior (Post-corruption)");
			outputText("Satyrs are now highly anti-social creatures; when two satyrs meet, invariably, the stronger one will dominate and impregnate the weaker one. They still love to feast and to party, but do so in gluttonous, debauched revels. They are notorious as bandits and thieves, stealing anything they can make off with and assaulting travelers for goods and breeding partners. They are often allied with goblins, one of the few races that can stand to be around them as they are now, with the satyr trading its considerable talents as a stud in exchange for food and liquor. The only reason satyrs as a whole have not sold themselves into slavery to the goblins is because, for many, the ever-increasing supply of willing sluts doesn’t outweigh the fact they can’t breed any sons with goblins.");
		}

		private function codexEntrySharkGirls():void {
			headerMain("Shark-Girls & Tigershark-Girls");
			outputText("<b>Genders:</b> Mostly female, though there are males and herms. Due to the nature of their conception, the vast majority of tiger sharks are hermaphrodites.\n");
			outputText("<b>Height:</b> 5-6 feet tall. Tiger sharks are primarily in the 6 foot region.\n");
			outputText("<b>Build:</b> Well-toned and athletic.\n");
			outputText("<b>Skin tone:</b> Grey. Light orange with stripes for tiger sharks.\n");
			outputText("<b>Hair color:</b> Silver and in rare cases, Black.\n");
			outputText("<b>Eye color:</b> Red for both species.\n");
			outputText("<b>Weaponry:</b> Fangs, tail and their bare hands.\n");
			headerSub("Typical dress");
			outputText("Ridiculously skimpy swimwear, which they use to entice victims. Some tigershark girls will wear grass hula skirts when on land to hide their endowments.");
			headerSub("Notable features");
			outputText("Retractable shark teeth, a large fin between their shoulders and a shark tail dangling off of their backsides.");
			headerSub("Sexual characteristics");
			outputText("Despite their slutty nature, shark girls have rather modest endowments in comparison to other such creatures; the majority of them are C-cups, D-cups at most. Though, their hips and buttocks are nice and curvy. Tiger shark girls possess wildly varying bustlines that are larger than their 'sisters', and usually are hyper-endowed with male genitalia.");
			headerSub("History");
			outputText("Before the corruption truly began, the Shark people were a normal fishing community that lived by the lake. They respected and admired marine life so much that they used magic to morph their forms, allowing them to live both under the sea and on dry land. As the demons began to take control, the Shark people retreated into the lake water to avoid the taint. It was only through sheer bad luck that they wound up as they are now; when the factory was constructed, the chemical run-off was funneled into the lake, causing a drastic change to the mindset of the Shark people and making them near-constantly horny. Those who swam too close to the pollutants found their bodies morphed in unexpected ways, becoming what are now known as tiger shark girls. Even if the factory were to be destroyed, it would take generations for the shark girls to fully lose the effects.");
		}

		private function codexEntrySuccubus():void {
			headerMain("Succubus");
			outputText("<b>Genders:</b> Exclusively female.\n");
			outputText("<b>Height:</b> Varies\n");
			outputText("<b>Hair:</b> Varies\n");
			outputText("<b>Eyes:</b> Varies\n");
			headerSub("Appearance");
			outputText("Succubi ALWAYS appear as attractive, and often slutty women, but they will modify the style of their dress to match what would be expected of a human woman in their current situation. In their true form they often have at least one pair of horns that grow larger and longer as they age. Some succubi have secondary and tertiary horn rows that curve back over their skull. Their skin is always flawless and their teeth white. In their true form their skin ranges from blue, to purple, to rarely midnight black.");
			headerSub("Sexual equipment");
			outputText("Succubi have what could be described as ‘the perfect vagina’. While it appears to be tight, it has the ability to stretch far beyond what should be possible for such a small piece of flesh. This ensures that no matter how large or small the succubus partner, they are able to enter her and receive enough friction. The vaginal surface is highly malleable and succubi will often add textured rings or wriggling cilia to their internal walls in order to drive their victims to even greater heights of pleasure.");
			headerSub("Reproduction");
			outputText("Succubi do not reproduce, instead they are created when a mortal woman because so drunk on desire and pleasure that she loses care for anything but her ability to seek pleasure and beauty. The mother succubus will work her victim into a frenzy of desire, until the unsuspecting victim literally cums out her soul and fills the void inside her with corruption. It should be noted that succubi can do this to a male as well, creating an incubus.");
			headerSub("Social structure");
			outputText("Succubi and Incubi occupy the second-lowest ranking of the demonic social structure, just above imps. They are prone to sloth when not ‘hungry’ and are typically never given more power than command over a few imps.");
			headerSub("Special attributes");
			outputText("A Succubus' Milk can be an extraordinarily powerful aphrodisiac when drank straight from the source. If it is stored, the aphrodisiacal properties rapidly diminish while its mutagenic properties rapidly rise. Some more powerful succubi are able to use their milk with black magic in order to work changes on their partners.");
			headerSub("Feeding");
			outputText("Like most demons, Succubi gain power from corrupting others, and require a steady supply of sexual fluids to survive. In rare cases, if a Succubus has been deprived of ‘food’ for too long, she may find herself too weak to seduce a partner, and enter into a less than advantageous agreement in order to get her food. Amazingly, most succubi will hold themselves to such an agreement after 'eating' their fill. ");
		}

		private function codexEntryTrolls():void {
			headerMain("Trolls");
			outputText("<b>Genders:</b> Male, Female.\n");
			outputText("<b>Height:</b> 7’3 - 7’9\". Females generally tend to be slightly shorter.\n");
			outputText("<b>Build:</b> Lithe, athletic, muscular. Most trolls have a more rectangular body shape, including females. It is extremely rare for a female troll to be busty or have an hourglass figure. Female trolls commonly have B cup breasts or smaller as infantile trolls do not need much milk to develop.\n");
			outputText("<b>Skin / Fur:</b> Trolls are normally covered head to toe in remarkably soft hair that camouflages them to their climate.\n");
			outputText("<b>Eye color:</b> Generally green, grey or blue.\n");
			outputText("<b>Notable Features:</b> Most trolls have tusks protruding from their mouth, on average they are 5 - 8 inches long. Females tend to have slightly shorter tusks. Trolls will grow their tusks a few months after birth. Their ears are long and elven-like. Typically, a troll will have a tail to assist them with balance, though this is not always the case.\n");
			headerSub("Appearance");
			outputText("Descendants from Elves from ages ago, the elven subrace \"Trolls\", as they refer themselves to, are a mostly humanoid race. Their hands and feet support only 4 appendages instead of five. Trolls will grow their tusks a few months after birth. Trolls in colder areas have thicker fur and are known to have claws. Similarities can be drawn to orcs due to existing within the same region, notably troll tusks are longer as they’ve honed the ability to use it in combat and tear through meat. Trolls still yield elven-like qualities from their ancestors, namely aesthetically pleasing body shapes and facial features along elven ears. Their elven ears are alert to any noises.");
			headerSub("Reproduction");
			outputText("When a female troll has chosen her mate, the chosen male will become far more receptive to her scent, and when a female troll becomes aroused, so will their mate. Females only carry two eggs, which are receptive to their chosen mate. Once both eggs have been fertilised, the male becomes considerably less fertile, but is still able to ejaculate copious amounts. Excess oxytocin is released as the female’s pheromones will specifically target their mate, tremendously enhancing their virility. This bond unites the trolls for the remainder of their lifetime. When united trolls are separated they quickly become depressed. Similarly to humans, troll reproduction involves a male and a female troll. Eggs are fertilized and trolls give live birth, they will actively care for their young.");
			headerSub("Behavior");
			outputText("Most trolls worship and respect Marae, the goddess that granted them life. There are two main tribes of trolls, jungle trolls and glacial trolls. Jungle trolls are calm and have a tightly packed community, they generally don’t enjoy the presence of outsiders. Glacial trolls are standoffish and shun outsiders.");
			headerSub("History");
			outputText("Trolls were among one of the tribes that Marae lent her power to in order to fend off the demons, but as trolls were mostly a quiet and passive race, they did not use their enhanced strength and intelligence to defeat the imps, fearing they could not take them, even with the assistance of a goddess they hid. Ashamed, trolls have retreated to the jungles to live on their own, the strength of Marae lives on within them, giving them strong resistance to corruption and magic to this day.");
			headerSub("Other Notes");
			outputText("Trolls are exceptionally strong, quick and intelligent. Trolls have the natural ability to regenerate damaged limbs and parts of their body, this can be halted with extreme injury or applications of fire, acid or other volatile elements All female trolls exude a pheromone cloud once matured, the cloud will cause males to become attracted to the female. This cloud affects males of any race, females are unaffected. The cloud is more potent depending on the female’s sex drive. This helps a female troll secure a mate. When a female troll has successfully claimed a mate, the male troll becomes extremely receptive to their female’s pheromones. A male troll’s sex drive is almost completely dependent on their mate. While it is uncommon, a female troll can  subdue multiple mates, this will cause aggression between males.");
			outputText("\n\nEven less common is homosexuality, as a female troll’s pheromones are generally powerful enough to unite two trolls of the opposite gender.");
		}

		private function codexEntryBehemoth():void {
			headerMain("Behemoths");
			outputText("<b>Genders:</b> Male.\n");
			outputText("<b>Height:</b> Typically 8 to 10 feet, but 11 feet is not unheard of.\n");
			outputText("<b>Build:</b> Muscular and athletic\n");
			outputText("<b>Skin tone:</b> Purple\n");
			outputText("<b>Hair color:</b> Usually blonde or black.\n");
			outputText("<b>Eye color:</b> Yellow\n");
			outputText("<b>Notable features:</b> Horns on head, spikes protruding from back and end of tail.\n");
			headerSub("Appearance");
			outputText("Behemoths typically wear little clothing, such as loincloth. The height, horns and spikes all add up to their fearsome appearance that most of the other races don't even dare to approach them.");
			headerSub("Reproduction");
			outputText("Like the satyrs, the behemoth are all-male race. Unlike satyrs, they are incapable of impregnating males. To reproduce, they rely on the females of other races as long as they are pure. Gestation period typically lasts two months, much longer than the typical gestation period in Mareth, and it takes two years for the newborn behemoth to fully mature into an adult.");
			headerSub("Social structure");
			outputText("Behemoths typically live in villages and caves. The leadership of tribes are determined by which is the strongest of all. Once a year, they host \"Feats of Strength\", a contest consisting of several gauntlets and competitions. Among one of them is the \"Cum-Out\" where the objective is for the behemoths to cum as much as they can in a single orgasm.");
		}

		private function codexEntryZebras():void {
			headerMain("Zebra-morphs");
			outputText("<b>Genders:</b> Male, Female\n");
			outputText("<b>Height:</b> 5 feet 5 inches to 6 feet\n");
			outputText("<b>Build:</b> Lean/slender\n");
			outputText("<b>Skin:</b> Zebra pattern\n");
			outputText("<b>Fur:</b> Zebra pattern with mohawk-style mane\n");
			outputText("<b>Eyes:</b> Brown to black\n");
			outputText("<b>Diet:</b> Herbivore, specializes on grass, but herbs and shrubs are part of their diet\n");
			headerSub("Appearance");
			outputText("The head and face is similar to that found on a zebra, though the nose is shorter. The mane looks like mohawk which begin at hairline and extends to middle of back. Legs are digitigrade ending in hooves. Long tail with a tuft of hair at end.Upper body in human (arms, hands, fingers, breasts).");
			headerSub("Reproduction");
			outputText("Typical reproduction. The stallion treats all women with the attention. When a foal is born, the foal is treated with the same rank his mother has.");
			headerSub("Social structure");
			outputText("Zebras are polygamous, one stallion with several mares and young offspring form a harem. Before beginning a harem, males are in bachelor groups, females are in natal harems composed of females only until taken into a stallion's harem.\n");
			outputText("The rank among mares in a harem is the order they were brought into it. When a new mare is brought into the harem, the other members treat her with disdain, making sure she knows her place, the bottom.\n");
			outputText("The acquisition of a new mare to a harem is the stallion impregnation of the mare.\n");
			outputText("Stallions are passive in most instances except in dealing with others trying to take away part or all of the stallion’s harem, or conflicts when trying for a new mare for his harem. Other causes exist, of course.");
			headerSub("Natural enemies");
			outputText("Zebra-morphs show great anxiety when near lion-morphs since millennia have passed where they were the prey to the lion-morphs.");
			outputText("\n\n(Written by: Rycharde) ");
		}

		private function codexEntryTyrant():void {
			headerMain("Project Tyrant");
			outputText("The reconstructive project, created after the original scientist’s death at the PC’s hands. The methods for creating Tyrantia didn’t die with him, and were repurposed to create a heavy, corruption-spreading loyal mount for demon cavalry.");
			headerSub("Logs (Doctor Flatline)");
			outputText("Today we were given the driders from the village near Gargant river: Noteworthy among them was a muscular, large specimen named Tyrantia. In addition to her larger than normal muscle mass and high density, her mind refuses to break like the others, depriving us of her lethicite. It is...rather vexing...But this could be an opportunity in disguise.\n"
				+ "\n"
				+ "She’s been bathed in corruptive influences for three days now, without food or water. She struggles far less, but any form of sexual torture results in the immediate death of the demons or imps doing the deed. She’s well-versed in combat, and the fluids we’ve been using have kept her strength at its peak.\n"
				+ "\n"
				+ "‘Tyrantia’ has been deemed an appropriate candidate for further experimentation into the effects of pseudo-transformational implants, or PTIs. Doctors Aego and Marabate think that her Psyche has been crushed. She does seem more compliant now, will test further after the PTIs are infused.\n"
				+ "\n"
				+ "The Drider has been successfully implanted with an experimental ‘girth’ PTI, without the usual constraints on area selection. Current Hypothesis is that it will increase the size of the subject overall. Edit: Subject is growing, and appears to be enraged, taking swipes at its cage. Further experimentation is warranted.\n"
				+ "\n"
				+ "PTIs are known to be finicky, but we’ve recently developed one that reliably transforms the user into a Bicorn, known for their corrupting influence and strength. However, crossing the two PTIs could prove disastrous. Therefore, subject 247 will be used as a guinea pig. \n"
				+ "Edit: Crossing the PTIs appear to have lessened the impact of the Bicorn PTI. Subject 247 has grown horse ears and a pair of horns, next to the injection site, but nothing else appears to have occurred.  \n"
				+ "\n"
				+ "Normal transformatives appear to have no effect on subject 247. The imp rations we’ve been feeding her has done nothing to curb her growth since PTI-2 was inserted. She has grown three inches over the last month or so, despite being well past the normal growth period for Driders.\n"
				+ "\n"
				+ "Subject 247 attempted her first real escape attempt in months. She disabled the guards with apparent lust abilities, despite the subject having no inclination towards the arcane or perverse arts prior. Twelve Demons killed, forty golems destroyed. A new record, which she appears to be prideful about. In addition, she has grown even larger.\n"
				+ "\n"
				+ "Between the physical augmentations and her own willpower, subject 247 has proven more than once that psychological torture is required to break her. Due to her stubborn nature and immense physical might, more...indirect methods are required. We’re cutting off her access to sexual relief of any kind, and bathed her in lustdraft gas.\n"
				+ "\n"
				+ "It’s been five days since the last log. Pardon the screams in the background. We’ve subdued Subject 247 in the chamber, and run her through the machines at maximum intensity. A few days in the torture ring should subdue her at this point. \n"
				+ "\n"
				+ "Subject 247 is subdued. For the first time since I began this project, I’ve been able to sink my claws into her. Good work, boys, she’s broken. Now we can begin properly. Daily poundings seem to take the life out of her now. Good. Not sure what I’d do otherwise.\n"
				+ "\n"
				+ "Subject 247 finally broke for real, revealing the extent of her Bicorn powers. For the last few months she’s been resisting, but finally the proof of concept is complete. \n"
				+ "\n"
				+ "Subject 247’s corruptive abilities are stronger than a natural-born Bicorn by 137%, and she’s grown. Now standing at 12ft 8 inches, obedient and fully corrupt, Project Screwed Earth is finally ready for phase 2.\n"
				+ "\n"
				+ "Lethicite PTIs are the most potent, but hardest to obtain. We got a new shipment today, including two Lethicite pieces that subject 247 will really enjoy. After all, who wouldn’t want to see their best friends? \n"
				+ "\n"
				+ "Twin Lethicite PTIs have been successfully integrated into 247’s biomass. The results are astounding. She’s grown another inch in the last week. Final steps complete. Project Screwed Earth is ready for a test-run. She has been successfully convinced that we do not know about her increased strength, and guards have been slowly pulled off-duty as she takes her daily fuck and testing like a good girl. \n"
				+ "\n"
				+ "Psychological blocks have been successfully planted into subject 247’s psyche. She does not willingly leave the battlefield for any reason… In theory. \n"
				+ "\n"
				+ "Project successful. The subject has stayed in the Battlefield for a week now, killing any demon or imp unfortunate enough to cross her path. We’ve lost two scouting-imps, but she’s still there.\n"
				+ "\n");
			if (flags[kFLAGS.CODEX_ENTRY_TYRANT] == 2) outputText("Project Screwed Earth has grown over a foot and a half since we last checked in with her. Worrisome, however, is the appearance of one of Mareth’s self-proclaimed ‘champions’. We believe it’s the sacrificial cow from Ignam this year, the same one that destroyed the factory. Project Fucked Earth has not told them of their true reason for existence.\n"
				+ "\n");
			outputText("Reconstructing the project in a new host has yielded...mixed results. Feeding corruption into the average Drider at a similar rate observed in “Project Screwed Earth” has resulted in 98% of Drider subjects turning demon, or going completely feral. However, once turned, these corrupted ones are far easier to work with than observed in ‘Screwed Earth’. The downside, of course, is the reduced intelligence and increased horniness of the subjects.\n"
				+ "\n"
				+ "Project Tyrant has yielded its first fully trained “soldier”. When comparing it to demon infantry, there is no comparison. Project Tyrant is a complete success. Now the only thing left is to dispose of the source material, and tidy up loose ends.\n");
			outputText("\n\n(Written by: CanadianSnas)");


		}
		private function codexEntryFlamespreader():void {
			headerMain("Project Flamespreader");
			outputText("Intended to replace the Imps as the primary airforce for the demonic hordes. When Kiha escaped, they’d already deemed her a successful prototype, and were going to dispose of her anyways.");
			headerSub("Logs (Doctor Streaks)");
			outputText("The local Lizan population has been subdued...along with the dragon they protected. The scaled beast is gone...But her DNA remains. One of the most powerful races in Mareth, finally wiped clean. Some of my superiors believe we should let sleeping dragons lie. However, the Lizans are known to have sexual compatibility with Dragonkind, even producing children occasionally. Picking out an ideal test subject should not be too hard. \n"
				+ "\n"
				+ "Parameters of the test subject should be the following: Subject must be young and fit, a warrior or labourer with a strong body would be ideal. Due to many races, including the Lizans, prioritising their females, using one of their women would be ideal. Crushing their hopes and hopefully gaining a fertile pseudo-dragon. I will go down to the holding pens tomorrow. \n"
				+ "\n"
				+ "Several potential subjects have been vetted. However, one of our security imps was recently killed by one of the Lizans in the pens. We don’t know which of those filthy scales did it, but breaking them shouldn’t be too difficult. \n"
				+ "\n"
				+ "How fortuitous! One of the highlighted potential subjects was in fact our culprit. A young, blossoming lizan female, daughter of a Lizan warrior slain during our takeover, has been taken from the group, bound and handed over to the imps for a night of...Revenge. It won’t break this ‘Kiha’, but it should soften her up for the trials ahead. There was much wailing as we took her, but maybe this will teach them the value of obedience. \n"
				+ "\n"
				+ "Dragon DNA is more complex than we’d anticipated. Lizans are less closely related to those beasts than we thought. Full metamorphosis is unlikely to succeed, but perhaps a more piecemeal process would yield results?\n"
				+ "\n"
				+ "Infusing certain plants with the Dragon DNA seems to stabilise it. Drake’s flower, ironically, seems to have the best compatibility. \n"
				+ "\n"
				+ "First time seeing the subject since we gave her to the imps. We decided to leave her there for a few days. Thankfully, Lizans don’t get pregnant the way most Marethians do. We don’t want her having a clutch before we make her a dragon. Even with their jizz dripping from every hole, the look she gave me was almost thrilling. I may need to come back and visit her after hours. Getting the staff to clean her up. I don’t want imp DNA corrupting my experiment, after all. \n"
				+ "\n"
				+ "We’ve stabilised the Dragon DNA. This Lizan female will be…most fun to experiment with. Introducing the mixture today. \n"
				+ "\n"
				+ "Two hours after application: Her scales have thickened considerably, her maw’s grown.\n");
			outputText("\n\n(Written by: CanadianSnas)");

		}
		private function codexEntryNightwalker():void {
			headerMain("Project Nightwalker");
			outputText("The Project that brought about Diva. Designed as stealth operatives with the capability to tear fortifications apart.");
			headerSub("Logs (Doctor Hemos)");
			outputText("I have been playing with the metamorphic properties of blood for some time now. But for the first time, I think I may be onto something. Certain types of bats...drain blood from their...hm...I need to get someone to do that. It would be so...Beautiful. Alas, the viral properties of the samples I’ve been able to create are weak. I’d need an extremely weak-seeded race to have any hope. Humans would be the ideal. \n"
				+ "\n"
				+ "Progress is slow, as expected. Those dullards at the factory have already kidnapped every potential subject, and ruined them! Humans are a rare commodity! Why would anyone waste them on such a trivial matter?! We have hundreds of obedient sluts, we don’t need more! \n"
				+ "\n"
				+ "My attempts to reach Queen Lethice have gotten limited results. Today I was turned back by that neophyte drider and his toy, but I shall not give up! Progress is halted. The blood-changers I’ve been working on are theoretically ready, but need a weak-seeded body to imprint on. Without test subjects, project Nightwalker is stalled. \n"
				+ "\n"
				+ "Driders cannot fly. This is the premise my latest attempt to reach our magnificent queen hinges on. While scaling the outer wall was the easy part (Mechanics and their gems, heh), I have found myself on top of the castle’s tower with a locked door being my only way down. \n"
				+ "\n"
				+ "Fortune is on my side! Our wonderful queen took a toy of hers up to the tower’s top to have her way with him, and found me there. While shocked, she had the grace to at least listen to my words and project before executing me. Impressed with my tenacity, she told me that she would see to it that I got my test subjects personally! How gracious of her! Unfortunately, these subjects likely won’t be arriving for some time. \n"
				+ "\n"
				+ "Fortune favours me once again! On one of my strolls in the mountains, I stumbled across a sleeping human. While I’m not the strongest Incubus, this human was dazed, confused and asleep. Pouncing on her, I found my test subject, or at least one to tie me over until Lethice gives me my test subjects. She’s a frail-looking thing...But very wordy. Lethice forbid this one ever shut her mouth! \n"
				+ "\n"
				+ "Whoever named this one named her aptly. I haven’t done anything to her yet, but when I asked her to tell me her name, I couldn’t help but laugh. Diva? Seriously?! It’s like they knew she’d be a drama queen! \n"
				+ "\n"
				+ "Introducing my blood-changer to her skin proved to be interesting. It fed off the pigment in her skin, leaving her pasty and pale. I tried to use her for other purposes, but the bitch tried to bite my dick off. I guess it’s only the lower holes for this one...for now, at least. \n"
				+ "\n"
				+ "Ever since the first blood-changer treatment, she’s been uncooperative, not even squealing during our nightly sessions. Most annoying. Introduced the blood-changer through her ass today, so we’ll see what that does. \n"
				+ "\n"
				+ "Her asshole is noticeably tighter, and swollen. More sensitive too, if her reaction tonight was anything to judge by. Not sure what else it did. \n"
				+ "\n"
				+ "I may have made a miscalculation. Today she was showing signs of malnutrition and dehydration. Standard rations proved too much for her, but she seemed to be able to keep down the water. Apparently the blood-changer in her asshole’s spread to her digestive tract. Considering the blood-changer consumes Hemoglobin, I’m not sure what this means for her diet going forward. \n"
				+ "\n"
				+ "More of the blood-changer was given to her today, this time slipped into her water. Judging by the coughing fit, she didn’t like that much. She’s skinnier than before. \n"
				+ "\n"
				+ "Was woken in the middle of the night by the bitch’s howling. Apparently the blood-changer’s spread to her musculature. Stuck a gag in her mouth, reinforced the chains, and fucked her ass a few times just to get her to shut up. Unlike before, her eyes now glow red. Rather formidable looking, to be sure. Even after a couple rounds, she still had fire in her eyes today. \n"
				+ "\n"
				+ "Today I learned that my favourite little test subject has some form of magical power. I found her trying to fly in her cell today. Apparently the skyborn magic I mixed in with the initial batch of blood-changer manifested! Such fascinating progress! \n"
				+ "\n"
				+ "My queen finally came through for me! A half-dozen fully human test subjects were delivered to my lab. More pretties to play with! Some were male, of course, but we dealt with that problem. I want these to be more than just soldiers, after all. \n"
				+ "\n"
				+ "My little Drama Queen has grown little fangs in her mouth! Oh, how I’d hoped this would happen! The blood-changer has had such dramatic effects, but its ability to modify already changed flesh needs to be improved. Ah well, that’s what the others are for, after all. \n"
				+ "\n"
				+ "Four of my test subjects have been implanted with improved versions of my hemoglobin blood-changer. They have already manifested more dramatic changes than my little Drama Queen, in a single dose. \n"
				+ "\n"
				+ "An imp came into my tower today. Claimed to be from some other researcher, pissed that I’d acquired a few humans that he’d wanted. I read the letter, and killed the imp, of course. I have a sneaking suspicion about my creations, and I wanted my Drama Queen to be the first to be able to benefit. Who knows? If she’s a good girl, I might let her have something nice to drink.\n");
			headerSub("Logs (Doctor Grinder)");
			outputText("After a long period of time, I was given clearance to investigate the late Doctor Hemos’s laboratory. What I found was...aggravating, to say the least. Queen Lethice will not be pleased. Apparently, from what I could gather, the disgusting doctor had taken a liking to one of his ‘subjects’, known as Diva, and was using his transformative blood-changer to enact some sort of perverse fantasy of his. Some kind of blood-draining experience? No Judging, I can’t really blame him, but to take so many humans and...Well, what’s done is done. The doctor’s bone-dry corpse was on the floor, and his test subjects scattered throughout his remote lab in various states of dismemberment. \n"
				+ "\n"
				+ "Report Summary: Doctor Hemos: Deceased. All but one subject of his transformative blood-changer found dead in the lab. We suspect one subject has escaped. We’re transferring his research and remaining material to the primary lab for reconstruction and evaluation. \n"
				+ "\n"
				+ "Lab report 1: Subjects exposed to later versions of his blood-changer appear to take on some sort of batlike attributes, including pale skin and fangs. This apparently wasn’t always the case, and was why he needed humans. Subjects apparently can no longer eat normal food, and must subsist on blood. Fluids can be drunk, but food is beyond them. The blood-changer is reproduced in the blood itself, so getting more of it is easy. \n"
				+ "\n"
				+ "Lab report 2: Subjects exposed to multiple doses appear to manifest crude magical abilities, even those that had no arcane talent before. Apparently the late doctor was onto something. \n"
				+ "\n"
				+ "Lab report 3: Near disaster today, averted (barely) with the death of three test subjects and the injuring of two of my guards. Apparently these creatures were not simply wasting away due to lack of nutrition. While there was some of that, their muscle mass was condensing, becoming more compact. \n"
				+ "\n"
				+ "Lab report 4: This blood-changer is contagious, and apparently spreads through bodily fluid. The two injured guards from before are displaying symptoms akin to the test subjects, and are being kept in cells and observed for their own safety. \n"
				+ "\n"
				+ "Lab report 5: My guards are now back on active duty, having confirmed that the blood-changer does not impede mental acuity. In fact, they’re both stronger, and smaller than before. Fascinating! \n"
				+ "\n"
				+ "Lab report 6: Compiling the affected subjects (including my two unfortunate guards), I have deduced the following: Increased mobility and mystic abilities, decreased size and drastically increased strength make this blood-changer extremely useful. My guards have also noticed a drastic shift in their vision, and increased need to shield their eyes from the sun. However, their need to sleep has decreased, and their night vision has been amplified. \n"
				+ "\n"
				+ "As many of Mareth’s races operate during daylight hours, I am submitting this blood-changer to Her Majesty’s review, recommending that she fund a new division of demonic soldiers, based on this blood-changer. These ‘Nightwalkers’ would be stealthy, hard-hitting saboteurs with a variety of abilities. \n"
				+ "\n"
				+ "Project Nightwalker has been confirmed. I’m being lumped in with two other projects, Firespreader and Tyrant, but at least I’m being properly funded and supplied with subjects. Doctors Virgosity and Streaks have their quirks, but their projects, despite my trepidation, are easily as interesting as my own. Their intended purposes even complement each other. With our minds working in concert, I’m certain that our Queen’s grip on Mareth will be cemented. \n"
				+ "\n"
				+ "Recent reports have emerged of a porcelain-skinned woman in a dress hiding in the mountains. Scouting imps have noted red eyes, an odd black dress, and interestingly enough, when she caught one, she bit its neck, draining the imp of blood before tossing it aside. We can surmise that this was the original, this “Drama Queen” spoken about at length in my predecessor’s notes.\n");
			outputText("\n\n(Written by: CanadianSnas)");
		}
	}
}