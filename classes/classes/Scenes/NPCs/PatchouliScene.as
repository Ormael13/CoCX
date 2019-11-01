/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumables.HairDye;
import classes.Scenes.Areas.Beach.DemonPackBeach;
import classes.Scenes.Areas.Bog.LizanRogue;
import classes.Scenes.Areas.Forest.AkbalScene;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Areas.HighMountains.Phoenix;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Areas.Swamp.CorruptedDrider;
import classes.Scenes.Camp.Jabberwocky;
import classes.display.SpriteDb;

import coc.view.ButtonDataList;

public class PatchouliScene extends NPCAwareContent {

	public function PatchouliScene() {}

	/*
	Patchou flags:
	PATCHOULI_FOLLOWER:
	1 - Meet and not taken offer,
	2 - Meet and taken offer,
	3 - Bad Ended,
	4 - Meet / taken offer / forgiven,
	5 - Tied up in camp,
	6/7 - Bimbofied
	*/
	private const MET:int        = 1;
	private const OFFERTAKEN:int = 2;
	private const BADENDED:int   = 3;
	private const FORGIVEN:int   = 4;
	private const TIEDINCAMP:int = 5;
	private const BIMBO:int      = 6;
	private const MATE:int       = 7;

	private var _allVisited:Boolean = false;

	private function visitedAllAreas():Boolean {
		if (_allVisited) {
			return _allVisited;
		}
		else {
			_allVisited = player.exploredMountain > 0 && flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0 &&
			              flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 &&/* flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD] > 0 &&
						  flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0 && flags[kFLAGS.DISCOVERED_CAVES] > 0 &&*/
			              flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] > 0 && flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] > 0 &&
			              flags[kFLAGS.DISCOVERED_BEACH] > 0 && flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] > 0 &&
			              flags[kFLAGS.BOG_EXPLORED] > 0 && player.hasStatusEffect(StatusEffects.ExploredDeepwoods);
		}
		return _allVisited;

	}

	public function meetThePatchouli():void {
		spriteSelect(SpriteDb.s_patchouli_male);
		clearOutput();
		var follower:* = flags[kFLAGS.PATCHOULI_FOLLOWER];
		if (follower < 1) {
			outputText("As you explore the forest, you spot a particularly weird cat person sleeping in a tree. Weird isn’t exactly the proper term here, as its fur color simply seems out of this world; either he dyed them or he was born with green fur and pink stripes. While at first you thought he was a girl due to his lean features, long hair and somewhat feminine face, the absence of breasts and the somewhat male, albeit girlish and young voice of the cat tells you otherwise. You approach him and ask him who he is. He stretches, looks at you and gives you an impossibly wide grin.\n\n");
			outputText("\"<i>Nyaaaaaaaaaaaa...Oh, hello traveler? Are you perhaps lost? My job is to guide people across this land to new destinations. Would you like a tour? My name’s Trusty Patchouli, by the way.</i>\"\n\n");
			outputText("The way he says this, with that constant smile, is somewhat disturbing, but now that you think of it ");
			if (visitedAllAreas()) {
				outputText(", you’re pretty sure you saw each and every location on Mareth, so you ponder where he could lead you.");
			} else {
				outputText(", you could use a guide across Mareth.");
			}
			flags[kFLAGS.PATCHOULI_FOLLOWER] = MET;
			menu();
			addButton(0, "Accept", patchouliExploreLuckyWheel).hint("Let him lead you to new places.");
			addButton(1, "Decline", camp.returnToCampUseOneHour);
		}
		else if (follower == MET || follower == FORGIVEN) {
			outputText("As you explore the forest you come over Patchouli the cat again. Hes lazily resting on a nearby tree branch. The moment he notice you, he gives you his most unsettling smile before engaging the conversation.\n\n");
			outputText("\"<i>Hello again, are you looking for a guide to new destinations? I can show you the way anytime so long as you ask.</i>\"\n\n");
			if (follower == FORGIVEN) {
				outputText("Will you really trust him? You already knows he might be leading you into a trap again.\n\n");
			}
			menu();
			addButton(0, "Yes", patchouliExploreLuckyWheel).hint("Let him lead you to new places.");
			addButton(1, "No", camp.returnToCampUseOneHour);
		}
		else {
			outputText("You spot Patchouli resting lazily on a nearby branch. He notices you, opens his eyes and starts to use his usual line just as you grab him and shove him on the ground, holding him by the neck.\n\n");
			outputText("\"<i>Uh...oh crap... Hello traveler, nice to meet you! Do you have business with me???</i>\"\n\n");
			outputText("You tell him he knows who you are and quite well. You can almost see sweat pearling on his face. He’s positively squirming while looking for an escape route.\n\n");
			outputText("\"<i>Uh... yeah, I’m pretty sure we didn’t... Ok, yes, fine, I did it. But there’s no need to get angry, yes? You're still alive and well. Please, forgive me, I sometimes have these urges to... eh, you know. Hehehe...please, let me... go?</i>\"\n\n");
			menu();
			addButton(0, "Forgive", patchouliForgiveHim);
			addButton(1, "Rape", patchouliRapeHim);
			addButton(2, "Kill Him", patchouliKillHim);
			if (silly()) addButton(3, "Finish Him", patchouliKillHim, true);
		}

		function patchouliForgiveHim():void {
			spriteSelect(SpriteDb.s_patchouli_male);
			clearOutput();
			outputText("You sigh and decide to forgive the cat for what he has done.\n\n");
			outputText("\"<i>Thank you! Thank you! Don’t worry, I will never trick anyone again!</i>\"\n\n");
			outputText("He vanishes into thin air and with his characteristic smirk and you simply head back to camp.");
			flags[kFLAGS.PATCHOULI_FOLLOWER] = FORGIVEN;
			doNext(camp.returnToCampUseOneHour);
		}

		function patchouliRapeHim():void {
			spriteSelect(SpriteDb.s_patchouli_male);
			clearOutput();
			outputText("You got plans for this insolent cat. Let’s see how long he smiles once you're violating that ");
			if (player.hasVagina()) {
				outputText("tiny dick");
			} else {
				outputText("firm little ass");
			}
			outputText(" of his.\n\n");
			if (player.hasVagina()) {
				outputText("You force the catboy on his back and yank his shorts away, revealing his cute tiny barbed cock.\n\n");
				outputText("\"<i>Uh, I’m sure we can sort that out in a different way! I can lead you to treasure, riches, a minotaur... wait, forget I ever said anything about the minotaur!</i>\"\n\n");
				outputText("You won’t need a minotaur for now, as you got exactly what you want right here! You don’t give him the chance to teleport away as you grab him by the neck and take hold of his cock with your other hand. Patchouli starts to mewl with anguished pleasure as you stroke his cat cock with your hand. You thought that by now, he would have teleported, but you suspect he's secretly a complete sub and loves getting punished for his mischief, not that you care about his kinks. ");
				outputText("What you care about is punishing that cock of his and getting your revenge. You spit on his cat cock and lube it properly before aligning your cunt with it. Patchouli screeches when you forcefully impale yourself on his dick and begin to pump for his boy milk. His barbs caress your walls in just the perfect way.\n\n");
				outputText("\"<i>Please.. not so rough, my cock hurts!</i>\"\n\n");
				outputText("He could at least pretend he likes it, you’re already are very kind, granting him the right to even get raped in the first place instead of straight out killing him. Soon, you find yourself on the verge of orgasm. Patchouli finally loses control of his cat cock as it twitches, filling you with kitty jizz and causing your orgasm shortly after.\n\n");
				outputText("You keep milking the prankster for a few hours until he is passed out. Then bring him back to your camp and tie him to a tree.\n\n");
				if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(30);
				if (player.jiangshiScore() >= 20 && player.statusEffectv1(StatusEffects.EnergyDependent) < 45) player.EnergyDependentRestore();
			} else {
				var x:int = player.cockThatFits(36, "length");
				outputText("You force the catboy on his back and yank his shorts away, revealing his girly ass and his cute pucker. Patchouli gulps as your [cock] hardens, already aware of what is about to happen.\n\n");
				outputText("\"<i>Uh I’m sure we can sort that out in a different way! I can lead you to treasure, riches, a minotaur... wait, forget I ever said anything about the minotaur!</i>\"\n\n");
				outputText("You don’t give him the chance to teleport away as you grab him by the neck and force your [cock] in.\n\n");
				if (player.cocks[x].cockLength >= 20) {
					outputText("\"<i>Eeeeep you're tearing me apart! Please stop, I’m telling you that you're tearing my ass apart!</i>\"\n\n");
					outputText("What a liar, you're all too aware that this jerk’s ability to play with dimensional travel allows him to send most of your cock into some other dimension. As a matter of fact, his stomach isn't even bulging from your insertion, but his pucker sure looks like it's stretched to its limit. ");
				}
				outputText("You begin to fuck his butt thoroughly in order to teach the little boyslut a lesson his ass won’t forget. His anus begins to contract and pulse around your dick like a vagina and who knows, maybe he somehow connected it to a cunt somewhere across the multiverse. Before long the sensation of Patchouli’s asscunt proves too much for you and you fill it full of your jizz. Patchouli seems to get off from his tormented ass, his cat cock pulsing as he reaches orgasm, splattering the grass below him with cum. He sighs in relief as you pull your [cock] out of his ass, then teases you.\n\n");
				outputText("\"<i>Some poor girl in that village must be pregnant by now, you should be ashamed, you know?</i>\"\n\n");
				outputText("This little asshole has pranked you long enough. You knock him unconscious and bring him back to camp, making sure to tie him to a nearby tree");
				if (camp.getCampPopulation() >=
				    2) {
					outputText(". Leaving one of your friends to watch over him at all time");
				}
				outputText(".\n\n");
			}
			player.orgasm();
			flags[kFLAGS.PATCHOULI_FOLLOWER] = TIEDINCAMP;
			doNext(camp.returnToCampUseOneHour);
		}

		function patchouliKillHim(silly:Boolean = false):void {
			spriteSelect(SpriteDb.s_patchouli_male);
			clearOutput();
			if (silly) {
				outputText("You toss the cat into the air and start by punching its chest to increase his altitude, then kick his balls. You chain this with a hundred kicks, tossing him even higher into the air as you charge an energy ball and fire it at the feline. As the cat is disintegrated, a disembodied voice growls out <b>“FATALITY!”</b> in the background. You strike a vicious pose… And are immediately mortified of whatever came over to you.\n\n");
				outputText("You have no idea how you did that... must’ve been the anger. You decide to never speak, or even think, of this ever again and head back to camp.");
			} else {
				outputText("No way are you going to forgive him for this. You proceed to snap his neck, leaving him lifeless on the ground. Oddly enough, the jerk is still smiling, even in death.\n\n");
				outputText("You head back to camp, most disturbed by this.");
			}
			flags[kFLAGS.PATCHOULI_FOLLOWER] = BADENDED;
			doNext(camp.returnToCampUseOneHour);
		}
	}

	private function patchouliExploreLuckyWheel():void {
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] < 2 || flags[kFLAGS.PATCHOULI_FOLLOWER] == FORGIVEN) {
			flags[kFLAGS.PATCHOULI_FOLLOWER] = OFFERTAKEN;
		}

		clearOutput();
		outputText("The cat jumps down from the tree and walks ahead of you, showing you the way. Strangely, the landscape seems to change absurdly fast around you as you follow him until ");
		//outer battlefield 5
		// 5
		if (player.exploredMountain < 1) {
			outputText("you end up in a somewhat mountainy area.\n\n");
			outputText("<b>Discovered Mountain!</b>\n\n");
			player.explored++;
			player.exploredMountain = 1;
			outputText("As you turn a corner you end up looking at the back of a somewhat tall man with the features of a bull. You’re about to sneak away when Patchouli shouts.\n\n");
			outputText("\"<i>Hey fatty, look! There’s an idiot right over here for you to fuck! Have fun!</i>\"\n\n");
			outputText("You see Patchouli vanishing with a mischievous laugh as the bull man turns and sees you, his monstrously thick shaft hardening as he walks toward you. He obviously intends to beat and rape you.");
			startCombat(new Minotaur());
		}
		// 7
		else if (!player.hasStatusEffect(StatusEffects.ExploredDeepwoods)) {
			outputText("you end up in a darker and more sinister part of the forest.\n\n");
			outputText("<b>Discovered Deepwood!</b>\n\n");
			player.createStatusEffect(StatusEffects.ExploredDeepwoods, 0, 0, 0, 0);
			outputText("As you are about to question your guide, the cat suddenly jumps onto a branch and yells before vanishing.\n\n");
			outputText("\"<i>Hey, Akbal! You have trespassers!</i>\"\n\n");
			outputText("You see a large panther surge out of a bush, and the way it looks at you is anything but friendly!");
			(new AkbalScene).supahAkabalEdition();
		}
		// 9
		else if (flags[kFLAGS.TIMES_EXPLORED_PLAINS] < 1) {
			outputText("you end up in a flat grassland with hills popping up every now and then.\n\n");
			outputText("<b>Discovered the plains!</b>\n\n");
			flags[kFLAGS.TIMES_EXPLORED_PLAINS] = 1;
			player.explored++;
			outputText("As you take in the beauty of the landscape, you suddenly realise the cat is no longer ahead of you. Furthermore, there are many passed out gnolls on the ground before you. You hear Patchouli laughter in the distance as a distinct shape rises amongst the defeated hyena warriors bodies, moving toward you. It’s a woman, partially covered with red scales, with reptilian arms, legs and tail. Speaking of which, her tail is actually on fire! She screams a warcry and charges at you, scimitar at the ready.\n\n");
			startCombat(new Hel());
		}
		// 13
		else if (flags[kFLAGS.TIMES_EXPLORED_SWAMP] < 1) {
			outputText("you end up in a somewhat swampy area full of mosquitos.\n\n");
			outputText("<b>Discovered the swamp!</b>\n\n");
			flags[kFLAGS.TIMES_EXPLORED_SWAMP] = 1;
			player.explored++;
			outputText("You start to notice spider webs around you and when you’re about to ask Patchouli about it,  you notice that your feet just got stuck in a web, unable to move. The cat simply keeps moving forward and disappears into the fog, as multiple creepy eyes open in the mist above you.\n\n");
			outputText("\"<i>Ahahaha seems I caught something, perhaps a new vessel for my broods. I will thoroughly enjoy toying with you.</i>\"\n\n");
			outputText("A creature with the torso of a woman and the lower body of a spider moves down along the web towards you, and, by the look of her monstruous cock, you’re pretty sure she plans to rape you!");
			startCombat(new CorruptedDrider());
		}
		// 15
		else if (flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] < 1) {
			outputText("you end up in a somewhat mountainous area with caves and high cliffs.\n\n");
			outputText("<b>Discovered high mountain!</b>\n\n");
			flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] = 1;
			outputText("You’re about to question him about this location, when you hear a low pitch growl coming from a nearby cave. Patchouli turns toward you, grinning as he vanishes into thin air, yelling.\n\n");
			outputText("\"<i>The dinner is served, big cat. Enjoy your meal!</i>\"\n\n");
			outputText("Suddenly, a spike misses your shoulder by an inch. You see something walk out of the cave with a sadistic grin. It looks like another cat person, a girl this time, with the features of a lion, but her scorpion like tail and large bat wings tell you she’s much, much worse than a lion.");
			startCombat(new Etna());
		}
		//blight ridge 21
		// 23
		else if (flags[kFLAGS.BOG_EXPLORED] < 1) {
			outputText("you end up in a bog.\n\n");
			outputText("<b>Discovered the bog!</b>\n\n");
			flags[kFLAGS.BOG_EXPLORED] = 1;
			outputText("The area has something eerie and sinister about it, but as you’re about to tell such to your guide, you suddenly realise that the cat actually left a while ago and that you’ve been walking alone! Furthermore, the warning signs around you aren’t any good either. You suddenly dodge an attack surging out of nowhere. It’s a lizan and by the look of it, he’s trying to mug you.\n\n");
			startCombat(new LizanRogue());
		}
		// 25
		else if (flags[kFLAGS.DISCOVERED_BEACH] < 1) {
			outputText("you end up on sand, hearing seagulls all around you. There's even crashing waves of water nearby.\n\n");
			outputText("<b>Discovered Beach, Ocean and Deep Sea!</b>\n\n");
			flags[kFLAGS.DISCOVERED_BEACH] = 1;
			outputText("The moment your gaze turn back to your guide you realise Patchoul");
			if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 6) {
				outputText("e");
			} else {
				outputText("i");
			}
			outputText(" is no longer there. Instead your gaze go eye to eye with that of a demon dressed like a pirate.\n\n");
			outputText("\"<i>Yarr we found some nice piece of ass here matey!! Lets claim that booty!</i>\"\n\n");
			outputText("You can hear the cat chuckle in the distance as you engage with a full crew of demonic pirates!");
			startCombat(new DemonPackBeach());
		}
		//caves 30 (leave with displacer beast i suppose xD)
		// 25
		else if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] < 1) {
			outputText("the temperature drops drastically. You see snow falling all around you and realise that you are now in some kind of inhospitable icy wasteland.\n\n");
			outputText("<b>Discovered glacial rift!</b>\n\n");
			flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] = 1;
			player.explored++;
			outputText("You decide that you’ve had enough and prepare to tell your guide that you're leaving, when Patchouli yells into the far distance.\n\n");
			outputText("\"<i>Hey, big idiot! There’s a puny bug for you to squish right here! ");
			if (player.hasCock()) {
				outputText("He");
			} else {
				outputText("She");
			}
			outputText(" said that your momma is ugly and that you were born a defect!</i>\"\n\n");
			outputText("The cat turns over to you, grinning wide as you hear the ground quake - something is coming, and it's huge! Before you have any time to punish the cat, he vanishes, still laughing as the frame of a man the size of a building breaks out of the blizzard, looking straight at you with furious eyes.");
			startCombat(new FrostGiant());
		}
		// 25
		else if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] < 1) {
			outputText("you end up in a somewhat hot area. You can see lava rivers every now and then across the ashen land.\n\n");
			outputText("<b>Discovered Volcanic area!</b>\n\n");
			flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] = 1;
			player.explored++;
			outputText("Just as you consider leaving this unfriendly land, the cat shouts something and what looks to be a harpy mixed up with a fiery lizard flies from a cliff toward the both of you. You see the damned cat disappearing, just before the battle starts.\n\n");
			startCombat(new Phoenix());
		}
		else {
			if (flags[kFLAGS.PATCHOULI_AND_WONDERLAND] != 1) {
				outputText("you end up in an exceedingly colorful version of the forest. Things here look weirder than usual, but not in a sexual way, rather it’s like the painting of a mad artist.\n\n");
				outputText("\"<i>Well wow, out of all locations I didn’t expect us to end up in here... just... just pick up a fruit or two and I will escort you out.</i>\"\n\n");
				outputText("The cat seems uneasy, but you don’t care. You spot a weird set of whisker fruits in a nearby tree and proceed to pack them up before leaving this strange place. You had the weird feeling something was watching you while you were leaving, but this must be your imagination.\n\n");
				inventory.takeItem(consumables.WOFRUIT, camp.returnToCampUseOneHour);
				if (flags[kFLAGS.PATCHOULI_AND_WONDERLAND] < 1) flags[kFLAGS.PATCHOULI_AND_WONDERLAND] = 1;
			}
			else {
				outputText("you end up in an exceedingly colorful version of the forest again. Patchouli is positively terrified, and begs you to leave.\n\n");
				outputText("\"<i>We need to leave this place in a hurry, it could be here any minute!</i>\"\n\n");
				menu();
				addButton(0, "Leave", patchouliExploreWonderlandLeave);
				addButton(1, "Stay", patchouliExploreWonderlandStay);
			}

			function patchouliExploreWonderlandLeave():void {
				outputText("You decide it's best to return to camp.\n\n");
				doNext(camp.returnToCampUseOneHour);
			}

			function patchouliExploreWonderlandStay():void {
				outputText("You decide to stay regardless of the cat’s thoughts on the matter and hear a roar somewhere in the forest. Patchouli whimpers in terror and tries to hide.\n\n");
				outputText("\"<i>It’s too late, were both dead. Jabberwocky is here!!!</i>\"\n\n");
				outputText("Just as he says this, a massive shape splits the nearby trees wide to pass. It looks like a dragon with pink scales, bat wings and funnily enough two large buck teeth, similar to a rabbit. The overgrown dragon-rabbit thing suddenly speaks.\n\n");
				outputText("\"<i>You were told never to come back, cat! You will pay for your insolence, along with this outsider.</i>\"\n\n");
				outputText("The rabbit dragon breathes a stream of fire to the sky and charges.\n\n");
				startCombat(new Jabberwocky());
			}
		}
	}


	public function patchouleMainCampMenu():void {
		clearOutput();
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == TIEDINCAMP) {
			spriteSelect(SpriteDb.s_patchouli_male);
			outputText("You approach the tied up cat wary of possible hidden tricks.\n\n");
			outputText("\"<i>Hello again... felt like visiting your prisoner for a chat? You know I could do soooo many things If I was not tied up to the tree.</i>\"\n\n");
			menu();
			addButton(0, "Appearance", patchouleAppearance);
			addButton(1, "Talk", patchouleTalkMenu);
			if (player.hasItem(consumables.BIMBOLQ)) {
				addButton(2, "Bimbo Liquer", patchouleBimbofication);
			} else {
				addButtonDisabled(2, "???").hint("You need Bimbo Liquer for this option.");
			}
			addButton(14, "Back", camp.campSlavesMenu);
		} else {
			spriteSelect(SpriteDb.s_patchouli_bimbo);
			outputText("You check on Patchoulie. The bimbo catgirl is lazily resting on a tree branch, smiling unsettlingly as you approach her.\n\n");
			outputText("\"<i>Felt like havin fun, [name]? Else I can get us to " + (visitedAllAreas()? "my place anytime" : "a new place") + ".</i>\"\n\n");
			menu();
			addButton(0, "Appearance", patchouleAppearance);
			addButton(1, "Talk", patchouleTalkMenu);
			addButton(2, "Give Item", patchouleGiveItem);
			addButton(3, "Sex Her", patchouleSexHer);
			addButton(5, "Yes", patchouliExploreLuckyWheel).hint("Let her lead you to new places.");
			addButton(14, "Back", camp.campSlavesMenu);
		}
	}

	private function patchouleBimbofication():void {
		spriteSelect(SpriteDb.s_patchouli_male);
		clearOutput();
		player.destroyItems(consumables.BIMBOLQ, 1);
		outputText("You tell your prisoner he will soon be free to go so long as he drinks the weird bottle you are holding.\n\n");
		outputText("Patchouli eyes you, then the bottle, then just shrugs and opens his cute little mouth as if to say ‘get to it’. The poor bastard has absolutely no idea of what is in that concoction, does he? Well it'll only be twice as fun once he realises it.\n\n");
		outputText("You pour the bottle in his mouth, making sure he drinks it all and wait patiently in order to watch the result.\n\n");
		outputText("\"<i>Ugh what was in that bottle? I feel so... happy?</i>\"\n\n");
		outputText("Patchouli moans as his cock shrinks and disappears entirely in a newly forming slit, his male parts turning into a vagina. His chest swells from flat to DD cup in no time as his already effeminate cat face and voice tone changes into a straight forward female. His hairs lengthen as their original orange color turns to a shiny platinum blonde with purple streaks, guess these weren't just stylist dye coloring after all.\n\n");
		outputText("Patchouli now actually looks just as he, from your perspective, was always meant to be, a girl. She giggles for a few seconds for no real reason at all and you can’t help but ponder if the liquor didn’t just make her even more crazy.\n\n");
		outputText("\"<i>Hey cutie, untie me!</i>\"\n\n");
		outputText("Well now that she says it you're unsure this is a bright idea but fair is fair, and you promised. You untie the still wide grinning Patchouli.\n\n");
		outputText("Her reaction is immediate, swift and somewhat unexpected. She disappears and reappears right above you, making you fall over. Before you know it, the cat woman is sitting on your chest, grinning widely again and you are almost afraid of what will happen next. Not in a million years did you imagine she would turn the tables.\n\n");
		outputText("\"<i>Nyaaaaaa~, I’m in heat [name] and you know exactly what this means. I’m crazy for you, so let's fuck till you go crazy too!</i>\"\n\n");
		outputText("What in hell?! You though giving him the liquor would turn him into a compliant nymphomaniac, not into a insane cat in heat.\n\n");
		outputText("\"<i>Oh but that's where you're wrong [name], I never was sane to begin with. Everyone from my homeland is mad one way or another and if I may be honest I’m one of the craziest. Now I’m not only crazy, I’m literally crazy for you so lets go mad together!</i>\"\n\n");
		flags[kFLAGS.PATCHOULI_FOLLOWER]      = BIMBO;
		flags[kFLAGS.PATCHOULI_GIRL_OR_MORPH] = 0;
		flags[kFLAGS.PATCHOULI_CUP_SIZE]      = 5;
		flags[kFLAGS.PATCHOULI_HAIR_COLOR]    = "blonde";
		flags[kFLAGS.PATCHOULI_COCK]          = 0;
		flags[kFLAGS.PATCHOULI_COCK_TYPE]     = "human";
		if (player.hasVagina()) {
			patchouleGirlOnGirl();
		} else {
			patchouleVaginal();
		}
	}

	private function patchouleAppearance():void {
		clearOutput();
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == TIEDINCAMP) {
			spriteSelect(SpriteDb.s_patchouli_male);
			outputText("Patchouli looks like your typical cat morph. However, the color of his fur is clearly unnatural. Striped black on a background of purple, Patchouli’s fur clearly does not belong on any normal cat. His fur is hardly the only thing ‘unnatural’ about him, as he almost smiles constantly, not just once in awhile, with the most unsettling grin he can muster. You would believe him to be up to some crazy mischief ");
			outputText("if somehow tying him up to a tree did not hold him from teleporting away. Go figure, why doesn’t he? It's likely some fucked up rule of his world. His green cat eyes have been observing you the whole time with interest, his tail twitching every now and then with the infinite patience of someone up to no good.\n\n");
			outputText("\"<i>Nya, having a good view [name]? Feel free to admire me all you like I love being looked at.</i>\"\n\n");
			outputText("You move your gaze away before it gets any more awkward than it already is.\n\n");
		}
		else {
			spriteSelect(SpriteDb.s_patchouli_bimbo);
			outputText("Patchoulie ");
			if (flags[kFLAGS.PATCHOULI_GIRL_OR_MORPH] == 1) {
				outputText("used to look like the typical cat morph but uses of transformatives allowed you to alter her into the perfect figure of a cat girl, with a human face and only a partially covered body. Regardless of her demi human look, Patchoulie’s tongue, eyes and abnormally long canine clearly still belong on a cat. The transformatives so far sparred her paws, ears and tail, not that you would ever get rid of them anyway");
			} else {
				outputText("look like your typical cat morph");
			}
			outputText(". However the color of her fur is clearly unnatural. Striped black on a background of purple, Patchoulie’s fur clearly does not belong on any normal cat. Her hair which used to be of the same messed up color as her fur are now divided between strands of platinum " + flags[kFLAGS.PATCHOULI_HAIR_COLOR] + " and purple, like someone whos head would feature on a deck of cards. ");
			outputText("Her fur is hardly the only thing ‘unnatural’ about her as she almosts smile constantly, not just once in awhile, with the most unsettlingly lewd grin she can muster. Patchoulie’s latest joy of late is to make you as emotionally uncomfortable and guilty as she can before sex. She’s currently laid back on a tree branch, her green cat eyes observing you with interest, her tail twitching every now and then with the infinite patience of someone up to no good.\n\n");
			outputText("\"<i>Nya, having a good view [name]? Feel free to admire me all you like I reaaaaally love being looked at. Especially when it's by you. Oh you are such an irredeemable pervert.</i>\"\n\n");
			outputText("Gosh the worst is she’s bloody right. You indeed have been having short glances at her " + Appearance.breastCup(flags[kFLAGS.PATCHOULI_CUP_SIZE]) + " breasts and constantly dripping pussy");
			if (flags[kFLAGS.PATCHOULI_COCK] > 0) {
				outputText(", what of her " + flags[kFLAGS.PATCHOULI_COCK] + " inch " + flags[kFLAGS.PATCHOULI_COCK_TYPE] + " cock");
			}
			outputText("!\n\nKnowing fully what your thinking about, she offers you her most lecherous grin and you move your gaze away in response before it gets any more awkward than it already is.\n\n");
		}
		doNext(patchouleMainCampMenu);
	}

	private function patchouleTalkMenu():void {
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == TIEDINCAMP) spriteSelect(SpriteDb.s_patchouli_male);
		else spriteSelect(SpriteDb.s_patchouli_bimbo);
		clearOutput();
		outputText("You tell Patchouli you have a few questions "+(tiedUp?"he":"she"));
		var tiedUp:Boolean = flags[kFLAGS.PATCHOULI_FOLLOWER] == TIEDINCAMP;
		outputText(" should answer.\n\n");
		outputText("\"<i>Aw nya, wasting your time on such trifles");
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 6) outputText(" when we could be having sex");
		outputText(". What could I know that you do not... fine I’ll answer whatever you want me to.</i>\"\n\n");
		menu();
		addButton(0, "Trick People?", patchouleTalkMenuTrickPeople);
		addButton(1, "Who is "+(tiedUp?"he":"she")+"?", patchouleTalkMenuWhoIsSHe);
		addButton(14, "Back", patchouleMainCampMenu);
	}

	private function patchouleTalkMenuTrickPeople():void {
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == TIEDINCAMP) spriteSelect(SpriteDb.s_patchouli_male);
		else spriteSelect(SpriteDb.s_patchouli_bimbo);
		var tiedUp:Boolean = flags[kFLAGS.PATCHOULI_FOLLOWER] == TIEDINCAMP;
		clearOutput();
		outputText("Seriously, what is with "+(tiedUp?"him":"her"));
		outputText(" and tricking people? That's disgusting! Is "+(tiedUp?"he":"she"));
		outputText(" some kind of psycho who gets off from people getting raped?\n\n");
		outputText("\"<i>Getting off? Rape? Nasty? What a weird set of terms you're saying there. As far as I care it's your fault for being so gullible as I, Patchoul"+(tiedUp?"i":"e"));
		outputText(", am merely a prankster devoid of all worldly wants, but still here to playfully remind the unwary that no matter where they go nowhere in the world is truly safe.</i>\"\n\n");
		outputText("So wait, "+(tiedUp?"he":"she"));
		outputText(" thinks it's perfectly okay to lure people into rape traps?\n\n");
		outputText("\"<i>Of course, [name]. It's all fun and games, at least for me.</i>\"\n\n");
		doNext(patchouleTalkMenu);
		cheatTime(1 / 4);
	}

	private function patchouleTalkMenuWhoIsSHe():void {
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == TIEDINCAMP) spriteSelect(SpriteDb.s_patchouli_male);
		else spriteSelect(SpriteDb.s_patchouli_bimbo);
		var tiedUp:Boolean = flags[kFLAGS.PATCHOULI_FOLLOWER] == TIEDINCAMP;
		clearOutput();
		outputText("Just what is " + (tiedUp ? "he" : "she") + " really? You don’t know of cat morph with teleportation ability.\n\n");
		outputText("\"<i>Me nya? I am everything and nothing, everywhere and nowhere. Nya to describe what I am is to also describe what I am not. Through for people like you the simple answer is a cheshire cat.</i>\"\n\n");
		outputText("How can " + (tiedUp ? "he" : "she") + " be and not be at the same time that makes no senses.\n\n");
		outputText("\"<i>I’m from a different world with a different mindset. One where simple rules such as your so called “physics” and “logic” do not apply. A mad dimension where such things are commonplace and the norm. How very amusing of you to question whether I make sense or not when the very stability of this dimension you call Mareth in itself makes so little sense. People fucking everywhere, mad mages trading their souls for power, animals talking and breeding, food that transforms you, people being jealous, hurting and stealing from each other? None of this makes sense, you know, yet you're here questioning a cat about the logics of ");
		outputText((tiedUp ? "his" : "her") + " action? I say you're the crazy one. Know this... by the time your so called quest is over you will be even crazier then me");
		if (tiedUp) outputText(". It’s like that rope and tree, why do you think I didn’t go elsewhere yet? It's because I don’t have a cheese on me to break free. I'm not bound by the same rules and reality, yet I’m bound all the same. You and I come from different worlds, [name]");
		outputText(".</i>\"\n\nCome again? Is the cat actually calling you crazy? The cheshire teasingly replies with a wide smile.\n\n");
		outputText("\"<i>To you what I say may make no sense, but things such as common sense are alien to me for common sense itself is based on logic. You can access that world too if you try... everyone has the potential to visit it from the depth of their mind, to touch it, if even for a second. A world different from this one, so close yet so far, but again, for someone like me distances holds little meaning. Maybe if you ask me nicely I will bring you to its gates sometimes.</i>\"\n\n");
		if (tiedUp) outputText("Of course you would have to untie him first and that ain't happening anytime soon.\n\n");
		doNext(patchouleTalkMenu);
		cheatTime(1 / 4);
	}

	private function patchouleSexHer():void {
		menu();
		if (player.hasVagina()) {
			addButton(0, "Girl On Girl", patchouleGirlOnGirl);
			if (flags[kFLAGS.PATCHOULI_COCK] > 0) addButton(1, "TakeVaginal", patchouleTakeVaginal);
		}
		if (player.hasCock()) {
			addButton(2, "Vaginal", patchouleVaginal);
			addButton(3, "Anal", patchouleAnal);
		}
		if(player.isGenderless()){
			addButton(14, "Back", patchouleMainCampMenu);
		}
	}

	private function patchouleGirlOnGirl():void {
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == MATE) clearOutput();
		outputText("While you were thinking this through, Patchouli’s paws got to work");
		if (!player.isNaked()) outputText(" removing your [armor]");
		outputText(". With your arms pinned to the ground by her hindpaws, you are unable to struggle as her paw like hands playfully insert a finger inside your slit. You moan in surprise as the cheshire amorously nuzzles your neck and slides her digit in and out of your [pussy].\n\n");
		outputText("\"<i>Nyaaaa... I’m totally in heat for you [name] so let me take good care of you.</i>\"\n\n");
		outputText("In heat. huh? Well she sure did put you in the mood as, lost in the moment, you grab her mouth and start exchanging kisses with her as she keeps fingering you. Her tail caresses your inner thigh and you almost cum on your own, however in your delirium you begin playing with your partner as well. Patchoulie rewards you with a set of happy mewls as your finger gets drenched with her pussy juice.\n\n");
		outputText("\"<i>NYYAAAAAAaaa!!! Don’t stop! Please don’t stop... so close!</i>\"\n\n");
		outputText("Gosh, she really must’ve been starving for attention. She gives you free access to her cunt and you don’t disappoint. Getting your hand further inside and tweaking her bitch button, you do all in your power to make her reach a wonderland of bliss! The two of you begin to lose track as you lose yourself to the pleasure countless times. You vaguely remember her wide smile as the both of you reached orgasm just before you lost consciousness.\n\n");
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == MATE) {
			outputText("\"<i>Nyaaa... Always a pleasure to breed with you, [name]. Ask me whenever you are in the mood again, I’m looking forward to it.</i>\"\n\n");
		}
		else {
			outputText("\"<i>Nyaaaa... Know what, [name]? As of today let’s be mates, nya. Come over to me whenever you're in the mood or in heat, I’ll always be ready for you waiting up that branch.</i>\"\n\n");
			flags[kFLAGS.PATCHOULI_FOLLOWER] = MATE;
		}
		player.orgasm();
		doNext(camp.returnToCampUseOneHour);
	}

	private function patchouleVaginal():void {
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == MATE) clearOutput();
		outputText("While you were thinking this through, Patchouli’s paws got to work");
		if (!player.isNaked()) outputText(" removing your [armor]");
		outputText(". You were about to protest when her naughty paw suddenly got ahold of your [cock].\n\n");
		outputText("\"<i>Nyaaaaaa ");
		if (player.catCocks() > 0) {
			outputText("barbs are the bestest");
		} else {
			outputText("no barb on this one but I don’t care");
		}
		outputText("! Let me have a taste of that cock.</i>\"\n\n");
		outputText("She starts sliding her paw on your cock playfully like she’s playing with a toy. You’re stunned, both by her audacity and the pleasure from your member as the cat starts to forcibly masturbate you. You moan in confusion, not sure whether you or she is in control anymore as she wraps her mouth around your dick, making sure not to bite it off. Wow, if she's going to go so far you won’t have any way to hold back. You groan as your cock fills the cat ");
		if (flags[kFLAGS.PATCHOULI_GIRL_OR_MORPH] == 0) {
			outputText("morph");
		} else {
			outputText("girl");
		}
		outputText("’s throat full of jizz, the cheshire purring as she drinks every drop of it. However your partner is hardly sated.\n\n");
		outputText("\"<i>Nyaaaaa~ It’s my turn to feel good mate. So go ahead and punish my hole... hard.</i>\"\n\n");
		outputText("Wait what? You barely get the chance to catch your breath before the cat slut takes hold of your cock again, this time guiding it straight to her vagina. She purrs softly as your [cock] slides in and then you're already gone for a new round. The cheshire cat ");
		if (flags[kFLAGS.PATCHOULI_GIRL_OR_MORPH] == 0) {
			outputText("morph");
		} else {
			outputText("girl");
		}
		outputText(" mewls and moans as she milks you with her pussy. The fact she's a bimbo also somehow helps her skill despite having been a male not so long before. She lets her purple fur slide against your [skin] and you grope her ass as she joyfully bounces up and down along your cock length. You cum in her cunt as she howls a final “NYYAAAAAAA” skyward her tail straight like an iron bar. After this ordeal the both of you finally doze off to sleep.\n\n");
		outputText("When you wake up Patchoulie is resting on all four next to you in a seductive pose, still holding that unsettling smile that is her signature as she plays with one of the hair braid she likely got made while you were sleeping. You ought to admit, this new girl’s hair cut fits her well.\n\n");
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == MATE) {
			outputText("\"<i>Nyaaa... Always a pleasure to breed with you, [name]. Ask me whenever you are in the mood again, I’m looking forward to it.</i>\"\n\n");
		}
		else {
			outputText("\"<i>Nyaaaa... Know what, [name]? As of today let’s be mates, nya. Come over to me whenever you're in the mood or in heat, I’ll always be ready for you waiting up that branch.</i>\"\n\n");
			flags[kFLAGS.PATCHOULI_FOLLOWER] = MATE;
		}
		player.orgasm();
		doNext(camp.returnToCampUseOneHour);
	}

	private function patchouleTakeVaginal():void {
		outputText("You got plans for the cat today. You really need to use her to relieve your cunt, and her " +
		           flags[kFLAGS.PATCHOULI_COCK_TYPE] +
		           " cock is exactly what you need right now. You push her on her back, revealing her " +
		           flags[kFLAGS.PATCHOULI_COCK_TYPE] + " cock.\n\n");
		outputText("\"<i>Nyaa~ want to breed already? Yea sure use me however you want!</i>\"\n\n");
		outputText("You got exactly what you want right here! You don’t give her the chance to give another snide reply as you grab her by the breast and take hold of her cock with your other hand. Patchouli starts to mewl with delighted pleasure as you stroke her " +
		           flags[kFLAGS.PATCHOULI_COCK_TYPE] +
		           " cock with your hand. You always suspected her to be a complete sub that loves getting punished for her mischief, guess you were right. ");
		outputText(" You spit on her " + flags[kFLAGS.PATCHOULI_COCK_TYPE] +
		           " cock and lube it properly before aligning your [pussy] with it. Patchouli screams out a loud \"<i>NYYAAAAA!!!!!</i>\" when you swiftly impale yourself on her dick and begin to pump for her herm milk.");
		if (flags[kFLAGS.PATCHOULI_COCK_TYPE] ==
		    "feline") {
			outputText(" Her barbs caress your walls in just the perfect way.");
		}
		player.cuntChange(flags[kFLAGS.PATCHOULI_COCK], true, true, false);
		outputText("\n\n\"<i>Please.. Nyaaaaa!!! Rougher... Faster!</i>\"\n\n");
		outputText("She's obviously liking it, which only bolsters your lust. Soon, you find yourself on the verge of orgasm. Patchoulie finally loses control of her cock as it twitches, filling you with kitty jizz and causing your own orgasm shortly after.\n\n");
		outputText("Unsated, you keep milking the prankster for a few hours until you both pass out.\n\n");
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(30);
		if (player.jiangshiScore() >= 20 && player.statusEffectv1(StatusEffects.EnergyDependent) < 45) player.EnergyDependentRestore();
		player.orgasm();
		doNext(camp.returnToCampUseOneHour);
	}

	private function patchouleAnal():void {
		var x:int = player.cockThatFits(36, "length");
		outputText("You force the cat on her back and yank her shorts away, revealing her fuck ready ass and cute pussy. Patchoulie purrs as your [cock] hardens, already aware of what is about to happen.\n\n");
		outputText("\"<i>Nyaaaa~, c'mon [name] stop teasing me. You already know I want it, so please put it in!</i>\"\n\n");
		outputText("Well you sure are going to give her what she wants as you grab her by the thigh and force your [cock] in.\n\n");
		if (player.cocks[x].cockLength >= 20) {
			outputText("\"<i>Nyaaaaaa oooooooh my!!!! It's soooo huuuge I’m going to break!!!</i>\"\n\n");
			outputText("What a liar, you're all too aware that this sluts ability to play with dimensional travel allows her to send most of your cock into some other dimension. As a matter of fact, her stomach isn't even bulging from your insertion, but her pucker sure looks like it's stretched to its limit and the best of it all is that she clearly enjoy it. ");
		}
		outputText("You begin to fuck her butt thoroughly in order to teach the little slut a lesson her ass won’t forget. Her anus begins to contract and pulse around your dick like a vagina and who knows, maybe she somehow connected it to a cunt somewhere across the multiverse. Heck it might even be hers! Before long the sensation of Patchoulie’s asscunt proves too much for you and you fill it full of your jizz. Patchoulie seems to get off from her tormented ass, her pussy");
		if (flags[kFLAGS.PATCHOULI_COCK] > 0) {
			outputText(" and " + flags[kFLAGS.PATCHOULI_COCK_TYPE] + " cock");
		}
		outputText(" pulsing as she reaches orgasm, splattering the grass below her with cum. Seems she did connect your cock to her cunt, what a greedy girl. She sighs in relief as you pull your [cock] out of her ass, her cunt still dripping semen, then teases you.\n\n");
		outputText("\"<i>Nya.. ya know... you're quite a dirty ");
		if (player.hasVagina()) {
			outputText("herm");
		} else {
			outputText("boy");
		}
		outputText(". However I don’t mind it, It's exactly how I want my mate to be, completely perverted.</i>\"\n\n");
		outputText("Well considering the cum still dripping from her cunt you guess the word mate applies as no matter how you sex her, she manages to get your dick in the right spot anyway.\n\n");
		player.orgasm();
		doNext(camp.returnToCampUseOneHour);
	}

	private function patchouleGiveItem():void {
		var buttons:ButtonDataList = new ButtonDataList();

		function itemButton(item:ItemType, disable:Boolean = false):void {
			buttons.add(item.shortName, curry(giveItem, item)).disableIf(!player.hasItem(item) || disable)
		}

		itemButton(consumables.P_DRAFT, flags[kFLAGS.PATCHOULI_COCK] >= 20);
		itemButton(consumables.W_FRUIT);
		itemButton(consumables.P_S_MLK, flags[kFLAGS.PATCHOULI_CUP_SIZE] >= 29);
		itemButton(consumables.PINKEGG, flags[kFLAGS.PATCHOULI_COCK] <= 0);
		itemButton(consumables.REDUCTO, (flags[kFLAGS.PATCHOULI_CUP_SIZE] <= 5 || flags[kFLAGS.PATCHOULI_COCK] <= 6));
		buttons.add("Hair Dye", giveHairDye);
		submenu(buttons, patchouleMainCampMenu);

		function giveItem(item:ItemType):void {
			clearOutput();
			player.destroyItems(item, 1);
			switch (item) {
				case consumables.P_DRAFT:
					outputText("You consider Patchoulie and decide she could use a shaving. You show her the bottle and ask her to drink it.\n\n");
					outputText("\"<i>Nyaaaa, yea sure why not. It smells good anyway.</i>\"\n\n");
					outputText("You smile wide as the bimbo cheshire drinks the bottle. The effects are immediate and visible as she moans a loud mewl");
					if (flags[kFLAGS.PATCHOULI_COCK] < 6) {
						flags[kFLAGS.PATCHOULI_COCK] = 6;
						outputText(" a small bulge forms at the base of her crotch. Patchoulie grows a brand new cock");
					}
					else {
						flags[kFLAGS.PATCHOULI_COCK] += 2;
						outputText(". Her shaft pulses with pleasure until it reaches a nice " +
						           flags[kFLAGS.PATCHOULI_COCK] + " inch");
					}
					outputText(". She grabs it and start to fiercely masturbate as she turn over smiling wide and then pounces on you to make her intentions clear.\n\n");
					outputText("\"<i>Nyaa well what you looking at, you lecher? Lets fuck already!</i>\"\n\n");
					patchouleSexHer();
					break;
				case consumables.W_FRUIT:
					outputText("You consider Patchoulie and decide her cock really would be better if it was a cat cock instead of a human one. You show her the fruit and ask her to eat it.\n\n");
					outputText("\"<i>Nyaaaa, yea sure why not. It smells good anyway.</i>\"\n\n");
					outputText("You smile wide as the bimbo cheshire eats the fruit. The effects are immediate and visible as she moans a loud mewl. Her cock bulges and changes shape as it covers with barbs, turning into a cat cock. She grabs it and start to fiercely masturbate as she turn over smiling wide and then pounces on you to make her intentions clear.\n\n");
					outputText("\"<i>Nyaa well what you looking at, you lecher? Lets fuck already!</i>\"\n\n");
					flags[kFLAGS.PATCHOULI_COCK_TYPE] = "feline";
					patchouleSexHer();
					break;
				case consumables.P_S_MLK:
					if (flags[kFLAGS.PATCHOULI_GIRL_OR_MORPH] == 1) {
						outputText("You consider Patchoulie and decide she could use a bigger pair of breasts. You show her the bottle and ask her to drink it.\n\n");
						outputText("\"<i>Nyaaaa yea sure why not. It smells good anyway and I love milk.</i>\"\n\n");
						flags[kFLAGS.PATCHOULI_CUP_SIZE] += 2;
						outputText("You smile wide as the bimbo cheshire drinks the bottle. The effects are immediate and visible as she closes her eyes and moans a loud mewl her breast expending up to " +
						           Appearance.breastCup(flags[kFLAGS.PATCHOULI_CUP_SIZE]) +
						           ". She licks her lips in delight then look back at you.\n\n");
						outputText("\"<i>Nyaa well what you looking at, you lecher? Lets fuck already!</i>\"\n\n");
					}
					else {
						outputText("You consider Patchoulie and decide she could use a shaving. You show her the bottle and ask her to drink it.\n\n");
						outputText("\"<i>Nyaaaa yea sure why not. It smells good anyway.</i>\"\n\n");
						outputText("You smile wide as the bimbo cheshire drinks the bottle. The effects are immediate and visible as she moans a loud mewl the fur on her face and torso falling apart to reveal the sexy skin beneath. Her face changes too to something closer to a human. She has the every trait of sexy catgirl now through her wide, unsettling smile still remains albeit not devoid of a lewd nuance. You guess that’s a trait all cheshire cats share.\n\n");
						outputText("\"<i>Nyaa well what you looking at, you lecher? Lets fuck!</i>\"\n\n");
						flags[kFLAGS.PATCHOULI_GIRL_OR_MORPH] = 1;
					}
					patchouleSexHer();
					break;
				case consumables.PINKEGG:
					outputText("You consider Patchoulie and decide she no longer needs a cock. You show her the egg and ask her to eat it.\n\n");
					outputText("\"<i>Nyaaaa yea sure why not. It smells good anyway.</i>\"\n\n");
					outputText("You smile wide as the bimbo cheshire eat the egg. The effects are immediate and visible as she moans a loud mewl, her cock spontaneously orgasming and spewing cum everywhere as it shrinks inch by inch into nothingness until she has none. Patchoulie can’t help herself and starts fingering her wet pussy trying to prolong her orgasm then pounces on you making her intentions clear.\n\n");
					outputText("\"<i>Nyaa well what you looking at, you lecher? Lets fuck!</i>\"\n\n");
					flags[kFLAGS.PATCHOULI_COCK]      = 0;
					flags[kFLAGS.PATCHOULI_COCK_TYPE] = "human";
					patchouleSexHer();
					break;
				case consumables.REDUCTO:
					outputText("What body part would you like to shrink?\n\n");
					menu();
					if (flags[kFLAGS.PATCHOULI_COCK] > 6) addButton(0, "Cock", applyReducto);
					if (flags[kFLAGS.PATCHOULI_CUP_SIZE] > 5) addButton(1, "Boobs", applyReducto, false);
					break;
			}

			function applyReducto(cock:Boolean = true):void {
				if (cock) {
					flags[kFLAGS.PATCHOULI_COCK] -= 2;
					outputText("You apply the paste and Patchoulie mewls as her cock shrink by 2 inches, spewing a fountain of cum in the process.\n\n");
				} else {
					flags[kFLAGS.PATCHOULI_CUP_SIZE] -= 2;
					outputText("You apply the paste and Patchoulie mewls as her breast shrink to " +
					           Appearance.breastCup(flags[kFLAGS.PATCHOULI_CUP_SIZE]) +
					           " size, spewing a fountain of milk in the process.\n\n");
				}
				doNext(camp.returnToCampUseOneHour);
			}
		}

		function giveHairDye():void {
			var buttons:ButtonDataList = new ButtonDataList();
			var current:String         = flags[kFLAGS.PATCHOULI_HAIR_COLOR];
			var dyes:Vector.<HairDye>  = new <HairDye>[
				consumables.AUBURND, consumables.BLACK_D, consumables.BLOND_D, consumables.BLUEDYE,
				consumables.BROWN_D, consumables.GRAYDYE, consumables.GREEN_D, consumables.ORANGDY,
				consumables.PINKDYE, consumables.PURPDYE, consumables.RAINDYE, consumables.WHITEDY,
				consumables.RUSSDYE
			];
			for each(var dye:HairDye in dyes) {
				var name:String   = dye.shortName.replace(" Dye", "");
				var colour:String = name.toLowerCase();
				buttons.add(name, curry(applyDye, dye, colour)).disableIf(colour == current || !player.hasItem(dye));
			}
			submenu(buttons, patchouleGiveItem);

			function applyDye(dye:HairDye, colour:String):void {
				clearOutput();
				player.destroyItems(dye, 1);
				flags[kFLAGS.PATCHOULI_HAIR_COLOR] = colour;
				outputText("You ask Patchoulie to coat her hair with the bottle and she complies. Her hair turning to " +
				           colour + ".\n\n");
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}


}
}