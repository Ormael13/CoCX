package classes.Scenes.Places.TelAdre{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponLib;

public class Library extends TelAdreAbstractContent implements TimeAwareInterface {
	public function timeChange():Boolean {
		if (flags[kFLAGS.MALI_BLADE_STATUS] > 1) --flags[kFLAGS.MALI_BLADE_STATUS];
		return false;
	}

	public function timeChangeLarge():Boolean {
		return false;
	}

	public function Library() {
		EventParser.timeAwareClassAdd(this);
	}

	private static function quinnHere():Boolean {
		return model.time.hours >= 6 && model.time.hours <= 17;
	}

//[Mage's Tower]
public function visitZeMagesTower():void {
	if (flags[kFLAGS.TIMES_BEEN_TO_LIBRARY] == 0) firstTowerVisit();
	else towerFollowUpVisits();
	menu();
	addButton(0,"Study",studyInTA);
	if (quinnHere()) {
		addButton(1,"You Okay?",youOkayBuddy);
		if(flags[kFLAGS.DOMINIKA_COVENANT] > 0) { //nothing but the quest, sadly
			if (flags[kFLAGS.MALI_BLADE_STATUS] == 0 || flags[kFLAGS.MALI_BLADE_STATUS] == 1)
				addButton(2, "Mali", talkToMali);
			else if (flags[kFLAGS.MALI_BLADE_STATUS] > 1)
				addButtonDisabled(2, "Mali", "She's not here yer. Check on her later, when she's done with catching the sorceress.");
			//Nothing after the quest, sadly
		}
		addButton(5, "A.Staff", buyStarterStaff, weapons.A_STAFF).hint("Buy Amethyst Staff.");
		addButton(6, "R.Staff", buyStarterStaff, weapons.R_STAFF).hint("Buy Ruby Staff.");
		addButton(7, "S.Staff", buyStarterStaff, weapons.S_STAFF).hint("Buy Sapphire Staff.");
		addButton(8, "T.Staff", buyStarterStaff, weapons.T_STAFF).hint("Buy Topaz Staff.");
		if (player.gems >= 240) {
			outputText("\n\n<b>You can buy different magic staves crafted by the Covenant.</b>");
			if (silly()) outputText("\n<b>Sorry, the diamond staff is out of stock.</b>");
		} else {
			for (var i:int = 5; i <= 8; ++i)
				button(i).disable("Not enough gems (240)!");
		}
		if (player.gems >= 100) {
			addButton(10, "R.B.Tome", buyRestrainedTome, 100, weaponsrange.RB_TOME).hint("Buy Restrained Black Tome.");
			addButton(12, "R.W.Tome", buyRestrainedTome, 100, weaponsrange.RW_TOME).hint("Buy Restrained White Tome.");
		}
		if (player.gems >= 200) addButton(11, "R.G.Tome", buyRestrainedTome, 200, weaponsrange.RG_TOME).hint("Buy Restrained Grey Tome.");
	}
	//13 or 9? - diamond staff ^^
	flags[kFLAGS.TIMES_BEEN_TO_LIBRARY]++;
	addButton(14,"Back",telAdre.telAdreMenu);
}

private function buyStarterStaff(type:ItemType):void {
	clearOutput();
	player.gems -= 240;
	statScreenRefresh();
	outputText("You pay 240 gems and Quinn hands over the chosen basic elemental staff to you.");
	inventory.takeItem(type, telAdre.telAdreMenu);
}
private function buyRestrainedTome(cost:Number, type:ItemType):void {
	clearOutput();
	player.gems -= cost;
	statScreenRefresh();
	outputText("You pay "+cost+" gems and Quinn hands over the chosen restrained tome to you.");
	inventory.takeItem(type, telAdre.telAdreMenu);
}

//(first visit)
private function firstTowerVisit():void {
	clearOutput();
	outputText("You make your way to the largest fixture of the city, the impressive tower in the center.  The large spire could easily hold everyone you know ten times over and still have room to spare.  It is far too large for a city with Tel'adre's population – but then, you reflect, so is Tel'adre itself.");
	
	outputText("\n\nThe front entryway appears to be fairly heavily guarded, and the two elites at the entryway turn you aside, directing you towards a different entrance - a public library.  Following the directions, you quickly come upon a different face of the tower.  You might have expected some epic pair of double doors, ten times your height, barely opening with a dramatic creak as you push them out of your way.  Instead you see a polite little entryway with hinges so well maintained they shine.  No frowning gargoyle door knockers, simply a small knob and a keyhole, as though it was someone's apartment.");
	
	outputText("\n\nA single room takes up the entirety of the space on the first floor.  Staircases up and down can be seen on opposing ends, but the majority of the room is furnished with simple seats and tables.  Scrolls and books litter the surfaces, likely pulled from a series of shelves set under the curving staircase.  There does not seem to be a connection between this library and the actual core of the tower.");
	
	if (quinnHere()) { //Don't want to meet Quinn if he's not supposed to be there
		outputText("  A single man carefully turns through the pages of one book");
		commonQuinnTroduction();
	}
	else {
		outputText("\n\nThere doesn't appear to be anyone here, so there's nothing stopping you from reading some of the books and scrolls left out on the tables.  Looking up and down the staircases reveals two locked doors, so it's unlikely you could do anything else here.");
		flags[kFLAGS.TIMES_BEEN_TO_LIBRARY] = -2; //This will be incremented to -1 by the visitZeMagesTower function after we return
	}
}

private function towerFollowUpVisits():void {
	clearOutput();
	if (flags[kFLAGS.TIMES_BEEN_TO_LIBRARY] == -1) { //Return visits before you meet Quinn. Either you meet him or you continue to go to the library at night like some bibliophile vampire
		if(quinnHere()) {
			outputText("You return to the mage's tower.  Entering the main room, you're surprised to see a man carefully turning the pages of one of the tomes");
			commonQuinnTroduction();
		}
		else {
			outputText("As before, there's no one here.  At least there's no lack of reading material.  Looking up and down the staircases reveals two locked doors, so it's unlikely you could do anything but study here.");
			flags[kFLAGS.TIMES_BEEN_TO_LIBRARY] = -2; //This will be incremented to -1 by the visitZeMagesTower function after we return
		}
		return;
	}
	
	//(follow-up visits, 6:00 – 17:00)
	if(quinnHere()) {
		outputText("You return to the mage's tower.  Entering the main room, Quinn is carefully inspecting the pages of a book.  The room looks slightly more organized from when you last saw it, but it looks as though Quinn will be working on it for some time.");
		outputText("\n\nHe notices you've arrived and quirks an eyebrow.  \"<i>Yes?</i>\" he asks wearily, \"<i>Is there something I can assist you with?</i>\"");
		//If the player has encountered Asa Mali they may ask for Mali.  Otherwise they can either leave, ask to study, or ask Quinn if he is okay.
		//[Mali] [You OK?][Study]
	}
	//(follow-up visits, 18:00-20:00)
	else {
		outputText("You return to the mage's tower.  Entering the main room, Quinn is nowhere to be seen.  The room looks slightly cleaner from when you saw it last, but at the rate he's going it seems like it will be some time before it's finished.");
		
		outputText("\n\nYou could probably read some of the books here if you wanted to, without Quinn around to tell you no.  Looking up and down the staircases reveals two locked doors, so it's unlikely you could do anything else here.");
		//The player can Study now, but due to the rest of the building being locked there are no other options. This is intended to serve as an alternative to Dominika's magic training, for players such as centaurs and naga, or players that hate blowjobs.
	}
}

private function commonQuinnTroduction():void {
	outputText(", though he does not seem to be reading it.  Stacks of books sit next to him.  As you close the door, he glances up at you.");
	
	outputText("\n\n\"<i>I'm sorry,</i>\" he says with a voice so weary you're surprised he doesn't fall over face-first upon exerting himself by speaking, \"<i>The library is not presently open to visitors, due to defacement and...</i>\"  He pauses, looking at a book next to him covered in an off-white crust.  \"<i>Vandalism.</i>\"  His eyes look twice as tired as his voice sounds, darkened to the point they almost seem bruised.  Pale – no, pallid - and lean to the point where you think you can see his cheekbones.  You're not convinced that this man has all of his health.  \"<i>I'm afraid there is no present estimate as to when we will re-open, as unfortunately no other members of the Covenant are presently able to devote the time to inspect and record the extent of the damages.</i>\"");
	
	outputText("\n\nHis dress seems at odds with his features.  Whether vanity or pride drives him to wear it, he adorns himself in a tailored suit.  The coat rests on the chair behind him, but the waistcoat is fully buttoned and the chain of a pocketwatch can be seen.  Despite this attention to detail his short hair – an odd lifeless and cold blue – is dishevelled enough that it likely has never seen a comb.  \"<i>I presume that you are not here on a social visit,</i>\" he continues, walking around the table and approaching you, \"<i>Given that we have a very limited interaction with the populace these days.  Goodness, I doubt you even know who I am.  No longer recognized on the street, not thanked for my tireless work.</i>\"  He shakes his head, looking over your shoulder into the town and crossing his arms.  \"<i>The sun rises and falls and each time they forget more of those who work themselves to the bone to keep them safe.</i>\"  You're not entirely sure what warranted this monologue, but he turns back to you.  \"<i>I likely met you as a babe, you know.  Took it upon myself to ensure that the names of every citizen would be written down, to mark that they had been here should they ever pass on.  But you likely extend no such courtesy to me.  A shame.  Quinn,</i>\" he continues, offering his name despite you never asking, \"<i>Thaddeus Quinn, the Monolith of Bone.  Ah, but it is too long since I was known by such a title.  The walls of Barrow exist only in memory and tomes now.</i>\"");

	outputText("\n\nHe looks not much older than you.  You're not sure how to feel about him continually pining for the past.");
	
	outputText("\n\n\"<i>But that is of little matter now,</i>\" Quinn concludes, folding his hands together.  \"<i>If you do not have any business with me or any members of the Covenant, I shall have to ask you to depart.  We are not a free range tower.</i>\"");

	//If the player has encountered Asa Mali they may ask for Mali. Otherwise they can either leave, ask to study, or ask Quinn if he is OK.
	//Met Asa Mali? flag 175
}

//[Study]
private function studyInTA():void {
	clearOutput();
	//[Study, 6:00-17:00]
	if(quinnHere()) {
		outputText("You ask Quinn if you can use the library to study and learn.");
		outputText("\n\n\"<i>I'm afraid that I may have not made myself clear earlier, the library is not presently open,</i>\" Quinn sighs, rubbing his forehead.  \"<i>This means that it is closed, which is the opposite state of open.  While it is in this state its services are unavailable to the general public.  The general public in this particular instance are also the ones directly responsible for the necessity of it closing, leading to further hesitation in the Covenant's willingness to hasten the opening.  Your interest is noted, filed, and considered, but will be regarded as a data point and not the quote unquote voice of the people.</i>\"");
		outputText("\n\nQuinn pauses for a few more moments, looking you in the eye thoughtfully before finishing with \"<i>That means no, in case we're unclear.</i>\"");
		menu();
		addButton(4,"Back",telAdre.telAdreMenu);
	}
	//[Study, 18:00-20:00]
	else {
		if (flags[kFLAGS.TIMES_BEEN_TO_LIBRARY] == -1) {
			outputText("Looking around you decide to spend some time reading");
		}
		else {
			outputText("Without Quinn to hassle you and request your absence from the presences, you have some time to read");
		}
		outputText(" through some of the literature collected by the Covenant.");
		if(rand(3) == 0) {
			//magic)
			outputText("\n\nSelecting a book at chance from the mess across the tables, you are delighted to find that it is a tome about magic.  Though the language used is archaic at first you slowly find yourself getting the grasp of it and understanding more of the theory put down in the text.  You find yourself thinking about how to apply the things you're reading about to your own abilities, and figuring out how to better utilize magic yourself.  In short, you experience the condition known as \"learning\", and feel smarter for it.");
			dynStats("int", 3+rand(4));
			player.trainStat("int", +1, player.trainStatCap("int",75));
			player.KnowledgeBonus("int",2);
			statScreenRefresh();
			//[Required int, effect]
			var spells:Array = [
				[20, StatusEffects.KnowsWhitefire],
				[20, StatusEffects.KnowsIceSpike],
				[25, StatusEffects.KnowsLightningBolt],
				[25, StatusEffects.KnowsDarknessShard],
				[30, StatusEffects.KnowsCharge],
				[30, StatusEffects.KnowsArouse],
				[35, StatusEffects.KnowsChargeR],
				[35, StatusEffects.KnowsRegenerate],
				[40, StatusEffects.KnowsChargeA],
				[40, StatusEffects.KnowsMight],
				[45, StatusEffects.KnowsHeal],
				[45, StatusEffects.KnowsBlink],
				[50, StatusEffects.KnowsBlind],
				[50, StatusEffects.KnowsArcticGale],
				[55, StatusEffects.KnowsPyreBurst],
				[55, StatusEffects.KnowsDuskWave],
				[60, StatusEffects.KnowsChainLighting],
				[60, StatusEffects.KnowsWaveOfEcstasy],
				[65, StatusEffects.KnowsBlizzard],
				[70, StatusEffects.KnowsMentalShield],
				[75, StatusEffects.KnowsCure],
			];
			for each (var spell:Array in spells) {
				if (player.inte >= spell[0] && !player.hasStatusEffect(spell[1])) {
					player.createStatusEffect(spell[1], 0, 0, 0, 0);
					outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: " + (spell[1] as StatusEffectType).id.substr(6) + "</b>"); //substring to remove "Knows "
					break;
				}
			}
		}
		//OR (player is bimbo/bimbro/whatever) 
		else if((player.lib > 75 || player.cor > 75 || player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties) || player.hasPerk(PerkLib.BroBrains)) && rand(2) == 0) outputText("\n\nYou pick up a book from a table randomly and open it up.  Incredibly disappointed, you soon realize that there are no pictures of people fucking at all.  Reading sucks.  You eventually toss the book aside and resolve to go do something more fun.");
		//OR (history) 
		else outputText("\n\nSelecting a book randomly from the scattered tomes, you find a historical text documenting life in Mareth.  It's dreadfully dull, and though you do your best to learn what you can the dry work is putting you to sleep.  Eventually you close the book and accept that you're not going to be learning anything tonight.");
		menu();
		addButton(0,"Next",camp.returnToCampUseOneHour);
	}
}

//[You OK?]
private function youOkayBuddy():void {
	clearOutput();
	outputText("A bit perturbed by Quinn's countenance and apparent exhaustion you can't help but inquire as to his well-being.");
	
	outputText("\n\n\"<i>The sycophants that clutter this town thought it would be amusing to fornicate wildly and rapidly within the library with no regard for where their filth would wind up or what would be damaged in the process.  So no, I am not particularly well.</i>\"  He answers the question with a slight sarcastic bend in his voice that you don't feel as though there was any real need for.  \"<i>It will take months to go through every tome and list the damages and details.  Updating the index, cross-referencing between existing damages, re-evaluating the justifications of placing it on the shelf... it's enough to slab a man.</i>\"  Quinn looks back at the library behind him and shakes his head in disappointment.");
	
	outputText("\n\nYou clarify that you were more referring to the fact that he is pale as fuck.");
	
	outputText("\n\nQuinn scoffs in return, running a hand up through his hair (and only further disorganizing it).  \"<i>As a member of the Covenant it is my duty – nay, privilege – to look over this city and protect it from the harm the outside world will do.  However, unlike many of my colleagues, I have chosen to take actual responsibilities in the management of this town – and this library.  This makes holing up in one of the tower's rooms and spending my days meditating to maintain the town's defences... untenable.</i>\"  The weary man dusts off the front of his waistcoat with no small amount of pride.  \"<i>Thus, I have taken into my possession a small item which will allow my fellow magisters to siphon from my magical ability and direct it to such a noble purpose.  Should I need to call upon my full capabilities I shall simply remove this object from my person, and the vim and vigor that I am proud to maintain shall spring back and rejuvenate me.</i>\"  He chuckles lightly, rubbing his cheekbones.  \"<i>Until then, I am proud to wear the so-called scars of my station.  Would that everyone had such selflessness.</i>\"");

	outputText("\n\nFinally getting the exposition you were looking for (and then some) you thank him for the information and resolve to talk to him as little as possible in the future.");
	doNext(camp.returnToCampUseOneHour);
}

//[Mali]
private function talkToMali():void {
	clearOutput();
	if(flags[kFLAGS.TIMES_VISITED_MALI] == 0) {
		outputText("You mention to Quinn that you're looking to speak with Mali.  \"<i>Ah, Asa Mali, our very own Alissyn del Aliana.</i>\"  Quinn chuckles and rubs his chin.  You think you're talking about the same person.  \"<i>How mysterious that she of all people should have a visitor.  Am I setting up a forbidden tryst?  A secret rendezvous?  Or perhaps, given the nature of her work, something far more... ominous.</i>\"  He looms curiously, but you clear your throat and ask if she's in.  Disappointed, he sighs and gestures up the stairs.  \"<i>Yes, our sylvan sorceress is not that much of a socialite.</i>\"");
		
		outputText("\n\nTurning on his heel he ascends and unlocks a hidden, secure-looking door to the second floor, beckoning you to follow him.  The staircase loops around the wall of the tower, and you pass many closed doors as you make your way up.  Strange and unfamiliar sounds come from more than a few of them, but Quinn seems to ignore them completely.  Apparently they're to be expected from the tower.  Finally, after climbing higher than any other building in the town (but yet with a great deal more to go), he turns and raps sharply on a wooden door.");
		
		outputText("\n\nIt takes a few moments for anything to respond, but eventually the knob turns and the door opens. Behind it a harried but smiling Mali stands, raising her eyebrows curiously.  \"<i>Yes?</i>\" she asks, \"<i>What is it, Quinn?</i>\"");
		outputText("\n\n\"<i>You have a visitor, dear,</i>\" Quinn says, gesturing to you.  \"<i>Please do remember that you have a shift later and it would be unwise to tire yourself out.</i>\"");
		
		outputText("\n\nMali closes her eyes for a moment and breathes in, but she's still smiling when she opens them.  \"<i>I will Quinn, thank you.</i>\"  She turns to you and steps out of the doorway.  \"<i>Please then, come in.</i>\"  As soon as you're out of the way she closes the door, walking briskly back to her desk.  Mali's room is cluttered with items whose nature is unclear to you, alien in their design and intent.  They seem magical, which if you think about it makes a hell of a lot of sense, given her job.  \"<i>It's [name], yes?</i>\" she smiles.  \"<i>It's been a little bit since we talked, I'm glad to see you showed up.</i>\"  The sorceress adjusts the moss scarf over her chest, sitting upright and folding her hands together.  \"<i>Let me formally introduce myself.  I am Inquisitor Asa Mali, officiator of security in Tel'adre.  I work closely with the city guard and serve as arbiter when determining punishment for crimes in the city.  In addition, I work personally to resolve situations that may arise in which the city guard is for whatever reason not capable of contributing normally.</i>\"");
		
		outputText("\n\nShe leans back, rubbing her split lips together for a moment in thought.  \"<i>I approached you about one such situation earlier,</i>\" she continues.  \"<i>The cabalist Dominika.  Typically I would not be investing in the aid of citizens to resolve this matter, but I am afraid I initially misjudged what would be required for the case.  This sorceress is...</i>\" Mali glances away for a moment, thinking of the words.  Her hand idly moves down to a key on her desk, rolling it between her fingers.  \"<i>Clever,</i>\" she finally settled on, \"<i>More than I initially gave her credit for, at least.  I'm not entirely sure of her intentions, but I do not believe they will serve the city well.</i>\"");
		
		outputText("\n\nOh, is that all? You know her intentions.  You open your mouth to explain them, but find yourself unable to enunciate the idea.  The image of curving smug lips barely appears in the back of your mind.  Frustrated you rub your forehead, trying and failing to give word to what you're experiencing.  \"<i>Yes, precisely,</i>\" Mali interrupts you, \"<i>I have been able to clearly denote who has encountered her given your symptoms.  The issue is that recounting them proves fruitless.  Suffice it to say that this Dominika has effectively veiled herself away from attempts to locate or expose her.</i>\"");
		
		outputText("\n\nMali stands, walking around to the front of her desk and sitting upon it.  Despite describing the problems she faces a confident smile is upon her face.  \"<i>But I have encountered this magic before,</i>\" she explains.  \"<i>And I know how to stop it.</i>\"");
		
		outputText("\n\nThe investigator steps forward and rests her hands on your shoulders, smiling.  \"<i>Thank you very much for coming to me.  This is already more than most are capable of.</i>\"  Her eyes meet yours.  They're strange and alien, wide and bright, but not unpleasant.  \"<i>If you've met her before, she'll be willing to see you again.  I need you to continue to visit her.  To earn her trust.  What I need is an object she had placed power into,</i>\" she explains, \"<i>Something that she has inspired by her magic.  If you endear yourself to her, I am certain that she will offer such an object to you in time.</i>\"  She squeezes your shoulders, then claps her hands together.");
		
		outputText("\n\n\"<i>Ah!</i>\" she exclaims, \"<i>But I am being such a poor hostess. Let me get you some tea.</i>\"");
		
		outputText("\n\nMali does not talk business for the rest of the visit, instead sharing tea with you and making small talk about life in Tel'adre.  It is polite and pleasant, and quite relaxing.  Eventually you excuse yourself, needing to return to the camp.  Descending back down the long staircase you scare off a crow resting on one of the tower's windowsills.");
		//[Mali] is added permanently to the tower's menu during the day.
		doNext(camp.returnToCampUseOneHour);
	}	
	//[[Mali], player has spellblade]
	else if((player.weaponName == "inscribed spellblade" || player.hasItem(weapons.S_BLADE)) && flags[kFLAGS.MALI_BLADE_STATUS] == 0) {
		outputText("You tell Quinn you're here to see Mali.  He seems intrigued by the wrapped blade you're carrying, but doesn't ask any questions.  Unlocking the second floor as usual, he escorts you to Mali's quarters.");
		outputText("\n\n\"<i>What's that?</i>\" Mali asks, curious when you pull out the inscribed spellblade.  You place it down on the desk and explain that you got it from... from...  Mali's eyes light up at your strained inability to explain.  \"<i>Yes!</i>\" she says excitedly, reaching over the desk and grabbing your cheeks.  She plants a quick and enthusiastic kiss on your lips in thanks, looking back down at the sword and running her hands over it.");
		
		outputText("\n\n\"<i>Yes, yes,</i>\" she says as she inspects it, \"<i>This is definitely... yes, I can sense her, now that I know.  I can feel the magic she poured into this.  Aaah!</i>\"  Bursting with excitement she can't help but ball her hands and shake them a little, hopping from one foot to the other.  \"<i>Yes, we can do it!  We can protect the city!</i>\"  Mali quickly steps around the table and pulls you into a large hug, her breasts squishing against your chest.  \"<i>Thank you so much,</i>\" she smiles, \"<i>You've done what no one else could.  I know it might not seem like much, but most people forget I've even asked about her.  You didn't just remember, you...</i>\"  She hugs you again, before excitedly running back around the desk and lifting up the sword, looking closer at it.");
		
		outputText("\n\n\"<i>I'm going to use this to track her,</i>\" she explains, \"<i>Then gather up some guards and find out just what she's up to.</i>\"  The grin on her face doesn't seem to be going anywhere.");
		outputText("\n\n\"<i>Please, come back soon. We'll try to catch her as fast as we can.</i>\"");
		if (player.weapon == weapons.S_BLADE) player.setWeapon(WeaponLib.FISTS);
		else player.consumeItem(weapons.S_BLADE);
		flags[kFLAGS.MALI_BLADE_STATUS] = 24 * 2;
		flags[kFLAGS.DOMINIKA_COVENANT] = 3; //stop Dominika encounters!
		//SH: I don't like unfinished shit. So here, take a blade.
		doNext(camp.returnToCampUseOneHour);
	}
	//[[Mali], spellblade done]
	else if (flags[kFLAGS.MALI_BLADE_STATUS] == 1) {
		outputText("You tell Quinn you're here to see Mali.  He rolls his eyes but doesn't say anything, unlocking the second floor and leading you up once more."
			+ "n\n"
			+ "The same moment when Mali notices you entering the room, she runs to you and hugs you, smiling brightly."
			+ "\n\n"
			+ "\"<i>We've done it! It wasn't easy, but my boys took care of her... I must thank you for helping us. The city was in an imminent danger, while that woman was here..</i>\""
			+ "\n\n"
			+ "The memory of Dominika's black lips still has not vanished completely, but you feel much better now - and now you know for sure that she was manipulating you. Looking at Mali, you ask her about the sword - if they don't need it anymore, perhaps you could take it back or something? Mali shrugs a little awkwardly, then leads you to the other side of the room."
			+ "\n\n"
			+ "\"<i>It's... not so easy. While we tried to figure out the nature of her magic, the original blade was damaged so badly that it couldn't be used anymore. But I've still found a way how to deal with it and not leave you without a proper reward. Our mages helped a lot - even Quinn took some small part in it. Here, take this.</i>\""
			+ "\n\n"
			+ "She passes you a tightly-wrapped package - not big enough for a sword, and somehow even smaller than a regular dagger! While she watches with curiosity, you unwrap the 'gift' - it looks like a... sword handle. Its form resembles that of the lost spellblade, but has a small crystal at its hilt. Before you take the modified handle, Mali stops you."
			+ "\n\n"
			+ "\"<i>Careful, don't point it at yourself! It's still a weapon. We called it after one ancient mage who used a magic sword - Tidarion. Well, it may not be as effective if you're affected by the corruption... but I'm sure it's not the case with you, right?</i>\""
			+ "\n\n"
			+ "The moment you take a handle in your hand, you see why she was so worried - a blade made of pure light, starts growing from it. After it reaches the size of a longsword, a white flame envelops it. Well... looks pretty useful. You thank Mali for the reward and leave.");
		// Yes, it's a blunt reference to DA:I. No, you can't prevent me from inserting it.
		// Also, my ending is shit. Please rewrite or improve or something - SH.
		flags[kFLAGS.MALI_BLADE_STATUS] = -1;
		inventory.takeItem(weapons.TIDAR, camp.returnToCampUseOneHour);
	}
	//[[Mali], player does not have spellblade]
	else {
		outputText("You tell Quinn you're here to see Mali.  He rolls his eyes but doesn't say anything, unlocking the second floor and leading you up once more.");
		
		outputText("\n\n\"<i>Ah, how are you?</i>\" Mali smiles at your visit, putting a tome aside.  You don't yet have anything that can help her locate Dominika, but the company is nice.  She puts on some tea and the two of you make small talk.  Mali's laugh is bright, tinkling lightly when you bring it out.  Eventually the time comes to leave.  She thanks you for the visit.");
		
		outputText("\n\n\"<i>Remember,</i>\" she says on the way out, \"<i>Anything you can get from Dominika that holds some aspect of her power will help.</i>\"");
		doNext(camp.returnToCampUseOneHour);
	}
	flags[kFLAGS.TIMES_VISITED_MALI]++;
}
	}
}