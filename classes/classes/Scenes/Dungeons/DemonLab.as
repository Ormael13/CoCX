/**
 * Story Dungeon: The Demon's Laboratory 
 * @author Canadian Snas
 */
package classes.Scenes.Dungeons 
{
import classes.*;
//import classes.BodyParts.LowerBody;
//import classes.BodyParts.Tail;
//import classes.Scenes.UniqueSexScenes;
import classes.GlobalFlags.kFLAGS;
//import classes.GlobalFlags.kACHIEVEMENTS;
//import classes.Items.Consumables.MinotaurBlood;
//import classes.Scenes.SceneLib;
//import classes.display.SpriteDb;
//import classes.internals.SaveableState;

//Things that will need to be put in other files
//Key Card Key Item
//Enemies
//
public class DemonLab extends DungeonAbstractContent// implements SaveableState
	{/*
	public static var MainAreaComplete:Number; //goes up by one for each of the main areas you complete, 1-3 for each ballroom section, 4 for dungeon complete
	public static var SexlessLabState:int; //0 for undiscovered, 1 for sexless helped, 2 when the interaction scene has been seen after, 3 for not helped, 4 for escorted to Tel'Adre
	public static var TyrantLabEntry:int; //0 for undiscovered, 1 for Demon fought, 2 for Demon let go. 
	public static var TyrantLabState:int; //0 for undiscovered, 1 for Demons Not killed, 2 for Demons Killed
	public static var DridersState:int; //0 for unsaved, 1 for rescued, 2 for escorted to Tel'Adre
	public static var EnteredBefore:Boolean; // False for first time entering the dungeon
	public static var TyrantFollower:Boolean; 
	public static var DivaFollower:Boolean;
	public static var KihaFollower:Boolean;
	public static var Followercount:int;
	public static var DragonLabEntry:int; //0 for first time, 1 once you've entered before
	public static var Keycardgot:Boolean;
	public static var PanicRoomState:int; //0 for unopened, 1 for Flamespreaders freed, 2 for empty
	public static var NightwalkerEntry:Boolean;
	public static var NightwalkerLabstate:int; //0 for unopened, 1 for entered, 2 for finished
	public static var TyrantCodec:Boolean; //whether or not you've taken the Codec
	public static var NightCodec:Boolean; //whether or not you've taken the Codec
	public static var FSpreaderCodec:Boolean; //whether or not you've taken the Codec
	public static var WayOutBlocked:Boolean; //true for blocked, false for not
	public static var FSpreaderState:int; //0 for undiscovered, 1 for freed, 2 if they've killed the fuckers in the panic room, 3 for Escorted to Tel'Adre
	
	public function resetState():void {
		MainAreaComplete = 0;
		SexlessLabState = 0;
		TyrantLabEntry = 0;
		TyrantLabState = 0;
		DridersState = 0;
		EnteredBefore = false;
		TyrantFollower = false;
		DivaFollower = false;
		KihaFollower = false;
		Followercount = 0;
		DragonLabEntry = 0;
		Keycardgot = false;
		PanicRoomState = 0;
		NightwalkerEntry = false;
		NightwalkerLabstate = 0;
		TyrantCodec = false;
		NightCodec = false;
		FSpreaderCodec = false;
		WayOutBlocked = false;
		FSpreaderState = 0;
	}
	public function saveToObject():Object {
		return {
			"MainAreaComplete": MainAreaComplete,
			"SexlessLabState": SexlessLabState,
			"TyrantLabEntry": TyrantLabEntry,
			"TyrantLabState": TyrantLabState,
			"DridersState": DridersState,
			"EnteredBefore": EnteredBefore,
			"TyrantFollower": TyrantFollower,
			"DivaFollower": DivaFollower,
			"KihaFollower": KihaFollower,
			"Followercount": Followercount,
			"DragonLabEntry": DragonLabEntry,
			"Keycardgot": Keycardgot,
			"PanicRoomState": PanicRoomState,
			"NightwalkerEntry": NightwalkerEntry,
			"NightwalkerLabstate": NightwalkerLabstate,
			"TyrantCodec": TyrantCodec,
			"NightCodec": NightCodec,
			"FSpreaderCodec": FSpreaderCodec,
			"WayOutBlocked": WayOutBlocked,
			"FSpreaderState": FSpreaderState,
		}
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			SexlessLabState=o ["SexlessLabState"];
			TyrantLabEntry=o ["TyrantLabEntry"];
			TyrantLabState=o ["TyrantLabState"];
			DridersState=o ["DridersState"];
			EnteredBefore=o ["EnteredBefore"];
			TyrantFollower=o ["TyrantFollower"];
			DivaFollower=o ["DivaFollower"];
			KihaFollower=o ["KihaFollower"];
			Followercount=o ["Followercount"];
			DragonLabEntry=o ["DragonLabEntry"];
			Keycardgot=o ["Keycardgot"];
			PanicRoomState=o ["PanicRoomState"];
			NightwalkerEntry=o ["NightwalkerEntry"];
			NightwalkerLabstate=o ["NightwalkerLabstate"];
			TyrantCodec=o ["TyrantCodec"];
			NightCodec=o ["NightCodec"];
			FSpreaderCodec=o ["FSpreaderCodec"];
			MainAreaComplete = o ["MainAreaComplete"];
			WayOutBlocked = o ["WayOutBlocked"];
			FSpreaderState = o ["FSpreaderState"];
		} else {
			// loading from old save
			resetState();
		}
	}
*/
	public function DemonLab() {
		//Saves.registerSaveableState(this);
	}
		/*
		//========================================================
		//Room Code
		//========================================================
		public function EnteringDungeon():void {
		clearOutput();
		if TyrantiaFollower.TyrantiaFollowerStage = 4 {
		outputText("You look at your map, and as you do so, your giantess lover walks towards you, armour on and Dick over one shoulder. “Are you going there?” Tyrantia asks, anger in her gaze. You nod, and she shakes her head. “Then I’m going with you.” Her gaze brooks no dissent, and you nod. She falls in behind you.  \n\n"); 
		//Tyrantia will fight beside you for the Dungeon Crawl
		TyrantFollower = true;
		Followercount(1);
		}
		if flags[kFLAGS.KIHA_FOLLOWER] = 1 {
		outputText("As you head out of camp, you notice a familiar, dusky-skinned dragoness above you. You motion her down, and Kiha gives you a glare. “Idiot.” You protest, but she holds a hand out. “No. If you’re going to the demon’s lab, you’re taking me with you. I’m not arguing.” You sigh. God Damn it, Kiha.  \n\n");
		//Kiha will fight beside you for the dungeon crawl
		KihaFollower = true;
		Followercount(1);
		}
		
		//I don't fucking know how Diva's code works, but an if for that goes here. 
		outputText("You near the mountains, to find a familiar figure waiting for you. “Mine ally. Thou doth approach the lab.” She shudders, looking away. “Thou art foolish…But brave. If thou wishes to defeat the ones encamped there, you will require assistance.” She squares her shoulders. “Fear not! The terror of the night shall aid you!”   \n\n");
		Followercount(1);
		
		if EnteredBefore = false; {
		outputText("The map Zetaz had given you leads up the mountains, not to the top of one, but halfway up. You climb easily, this part of the mountain unmarked, but clearly tamed. Several times you hear the flapping of wings overhead, both harpy, and the leathery flapping of demonic wings. So far, however, no demon seems to notice you as you clamber from rock to rock.  \n\n");
		}
		outputText("As you enter an inconspicuous-seeming cave entrance, the rock is replaced immediately by cold, hard metallic flooring. This cave looked different from the outside! Looking back, you can make out a shimmering, translucent barrier between this odd room and the outside. You poke this barrier, but your finger passes through it. Apparently this odd spell is an illusion only, designed to conceal this...place. The floors, walls and ceiling are all constructed from an odd, almost white metal, and every footstep sends echoes through the place.  \n\n");
		outputText("The only notable features in this room, other than the sterile white orbs floating next to the ceiling and two overturned padded tables, are several sets of shackles along the back wall. Upon closer inspection, you see a drain in the center of the room, and an odd rubber tube and nozzle tucked into the back-right corner. The thought of what fluids must have once stained this floor sends a chill down your spine.  \n\n");
		if EnteredBefore = false; {
		outputText("You hear a muffled voice behind you, and you duck behind one of the overturned tables. Two demons are approaching the hidden lab from the same path you came from! \n\n");
		outputText("“-and she decided that the projects should be sped up. Bah! Lethice doesn’t understand any of what we’re doing here, does she?”  \n\n");
		outputText("“No, but she does understand the value of the factory we lost. We were unacceptably close to removing that pesky-” The first voice stops as the demons step into view. “Well, it matters not. While the factory was valuable, it wasn’t crucial. And frankly, it was a waste.”  \n\n");
		outputText("The first demon is a scrawny, flat-chested incubus with two fourteen-inch demon dongs hanging out of his lab coat. His left arm, instead of a hand, ends in a misshapen lump of flesh, from which several tendrils writhe, as if searching for something. His right arm is normal, almost human except for the obvious signs of corruption.  \n\n");
		outputText("The second is a standard-looking Incubus, taller and bulkier than the first. However, he too has an odd body modification. The right side of his face is noticeably larger than the left, and his eye glows with a sickening purple light, not unlike the eyes of the Driders you’ve met. He wears two blades, one at each hip, with an oddly pink, circular guard.  \n\n");
		outputText("Unlike most demons, this pair seem unusually focused, not carnally obsessed.  \n\n");
			if Followercount = 0; {
				outputText("You hide, watching these two odd, mutated incubi. The smaller one sees the empty chains, shaking his head in disgust. The second sees them, shrugging as the smaller scientist starts to yell about how useless the ‘acquisitions department’ is. As he turns his back to you in disgust, the larger one sniffs, his head swivelling directly toward you.  \n\n");
				outputText("“Maybe not.” He says calmly, drawing his blades. The jig is up. You stand, readying your [weapon]. It’s a fight!  \n\n");
				//fight them, one after the other. 
			}
			if TyrantFollower = true && Followercount < 3 {
		outputText("Your giantess companion, unable to hide like you, simply stands beside the door, and as the two enter the room fully, she grabs the pair of them by their necks, her furry arms bulging as she digs her fingers in. With a sickening pop, the scrawny incubus’s neck is snapped. The larger one grunts, a burst of flame shooting from his palm. Your Drider giantess lets go before her arm is roasted, and the incubus backs up, drawing a thin blade and swinging it to keep your giantess at a distance. It’s a short sword...With a nipple-shaped guard? He produces a second, taking a defensive stance.  \n\n");
		outputText("“The Phalluspear.” He says calmly. “How nice of you to bring it back to its rightful owners.” He slices the air, and a thin cut opens up on Tyrantia’s cheek. “You’ll find the breastblades to be its better.” \n\n");
		outputText("You’re fighting the mutant incubus!\n\n");
		//start mutant incubus fight
			}
			if KihaFollower = true && Followercount < 3 {
				outputText("Kiha leaps up, her nude form clinging to the ceiling. Her bubble-butt sticks out, but the demons don’t look up. She cries out in anger as they pass beneath her. The combative incubus with the twin blades doesn’t even get a chance to cry out before his head is cleaved clean through by your fiery lover’s giant axe.  \n\n");
				outputText("The smaller incubus backs up in fear, his tentacles writhing, expanding. Needles flash on the end of the tendrils, and Kiha backs up as he tries to stab her with them. Droplets of clear fluid fall from the tips, and he grunts, pulling his ‘arms’ back before Kiha can bring her axe down on them.  \n\n");
				outputText("“So, the flamespreader prototype finally returned.” The incubus says cooly, seemingly unafraid. “I didn’t think you’d have the balls to come back here.” You rise from your hiding place, drawing your [weapon] and taking your place beside Kiha.  \n\n");
				outputText("You are now fighting the Incubus scientist! \n\n");
			}
			if DivaFollower = true && Followercount < 3 {
				outputText(" \n\n");
		outputText("Your vampire lover is quick to join you behind the table, and the two demons continue to the door leading deeper into this odd place. Without warning, however, Diva leaps dramatically from behind the table, her bat wings billowing.  \n\n");
		outputText("“Halt, thou soulless freaks! Dost you even comprehend the danger you put yourself in? Face the immortal terror of the night! Di-!” \n\n");
		outputText("You take the opportunity, springing from behind the table. Your [weapon] swiftly lands on the purple-eyed incubus. Her thunder now officially stolen, Diva launches herself forward as the remaining demon, clearly less experienced in combat, flails, desperately putting his hands out as Diva swoops in, sinking her fangs deep into his neck. Your batty lover drinks deeply, dropping the scientist to the floor, a withered husk.  \n\n");
		outputText("“Dost my love have no sense of the dramatic?” Diva chides, but you roll your eyes openly, telling her to get serious. “Oh, but I am. My flair left our foes helpless against you.”  \n\n");
			}
			if Followercount = 3 {
				outputText("The intruding Incubi barely make it into the door before your three ladies set upon them. Taken completely by surprise, the larger one is crushed by Tyrantia. The scientist runs afoul of Kiha, who makes short work of the clearly inexperienced combatant. Diva watches the more violent ladies at work, rolling her shoulders.  \n\n");
		outputText("“Thouest handle themselves well, but we should be saving our power for the fight at hand.”  \n\n");
			}
		EnteredBefore = true;
		}
menu();
        addButton(2, "North", Ballroom1);
        addButton(12,"Leave", LeaveDungeon);
}



public function Ballroom1():void {
		clearOutput();
		outputText("The room opens up into a cavernous hallway. Closest to you sits a large eating area, with an alcove for cooking food. Arcane symbols are etched into the tiled floor, but the scent of meat, gruel and baked goods is...off. Mixed with another, far more familiar Marethian scent. Cages dangle from the ceiling, a bioluminescent glow emanating from them. Rattles occasionally come from said cages.  \n\n"); 
		outputText("Your gaze travels to the middle section, which is an odd mix of seating area and…(If pure) Your stomach churns (If mildly corrupted) You wince slightly (If corrupt) You feel a surge of arousal (split end) at the sight of it. Several cages, each holding a person, their ass sticking out. Bound and gagged, these varied people are in various states of abuse, bodies whipped, beaten and bloodied. \n\n");
		outputText("At the end of the odd place is a wide-open area that appears to have once been a ballroom floor. Now, it seems to serve little purpose to these demons. After all, they prefer to dance...differently.  \n\n");
		outputText("There are doors to the East and West in this section. The eastern door is plain, but made from steel. Evidently it wasn’t part of the original building. The door to the west is similar, but slightly larger, and covered  \n\n");
		if MainAreaComplete < 1 {
		outputText("As you expected from the blaring alarm, most of the demons in this area are already turning towards the entrance, and you...Most. A few weedier looking demons are running the other way, while a few are still humping their toys with abandon, only pulling out at the sound of steel.  Shields are raised, swords drawn, and whips uncoiled with an efficiency you wouldn’t expect from demons. Still, the space between you and them gives you time. Time to realise exactly how many demons there are in this room. \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		if KihaFollower = true{
		outputText("“Idiot, we have a problem. Those runners are going to unleash some shit.” Kiha readies her axe, eyes narrowing at the sight of those cages. “But...So are we.” Kiha lets out a mighty roar, and as the demons advance behind a line of shields, she charges into battle.  \n\n");
		if Followercount < 3{
		outputText("You ready your [weapon], running in behind her. \n\n");
			}
		}
		if TyrantFollower = true {
			outputText("Those...skinny fuckers!” Tyrantia yells. “[name], we have to kill them, they’re the brains behind this...This…” The demons advance, and she brandishes her Dick, ready to charge right through them. “I fucking love you.” With that, she charges, her giant frame scattering demon soldiers like bowling pins.  \n\n"); 
		}
		if DivaFollower = true {
			outputText("“Love, we may have a problem.” Diva says softly. “Dost thou think we can take so many?” You tell her to keep those succubi occupied, and the vampiress nods.  \n\n"); 
		}
		if Followercount = 3{
		outputText("Your ladies leap into action, and you let out a war cry, wading into the assembled demons with as much fury as you can muster.  \n\n");		
		}
		//Start Combat With the DemonLab Guards
		}
		if DridersState = 1 {
		outputText("You can see Mother Oaklee organizing the few members of her tribe remaining. Some are raiding the cafeteria, others are seeing to injuries. As you pass by, a few bow their heads respectfully in your direction. \n\n");	
		}
		if SexlessLabState = 2 {
		outputText("Clad in labcoats, hastily modified kink outfits, or even just a cut-open blanket, the former Sexless sit in a group. While some shiver, either from cold or fear, others look around with hope in their eyes.  \n\n");	
		}
		if FSpreaderState = 2 {
		outputText("The Dragonoids pass around food, clearly used to communal living at this point. Some act out their recent fight, quaffing food and beer as if they'd never been chained. Others are more pensieve, looking down at drinks in their hands. \n\n");
		if KihaFollower = true {
		outputText("Kiha looks at them, a smile on her face for once. She shakes her head, eyeing the boistrous ones. \"Idiots\", she says, just loud enough for you to hear. \"It's  \n\n");
			}
		}
		if MainAreaComplete > 0 {
menu();
addButton(2, "North", Ballroom2);
        addButton(12,"South", EnteringDungeon);
        addButton(6, "West", TyrantCheck);
        addButton(8, "East", ArmouryCheck ;
		}
}

public function Ballroom2():void {
		clearOutput();
		//if commands need to be added inside this text
		outputText("You advance past the remains of the demonic guard, (split end) into what had been the banquet hall...or what would have passed for one, back home. (If the toys are still there) The groans of the beaten and abused fill the hall, and you struggle to keep your eyes off of the naked forms. You shiver, knowing in your heart that if you fail, you could easily end up here yourself.  \n\n"); 
		outputText("The Eastern door, opened by that wave of monstrous beings, (Split End) is now wide open. Each half of the door is adorned with circles, but as you look at the door from different angles, you can see that the circles form a male or female symbol, with the other part appearing or vanishing based on what angle you view it from.  \n\n");
		outputText("The black metal door to the West is covered with etchings of fire, filled in with red acrylic. There’s a black strip on the wall. (If Keycard) To place the keycard on. (If no Keycard) The door is strong, and the hinges are covered. You’ll need to find a way to open the door.  \n\n");
		if MainAreaComplete < 2 {
		outputText("As you make it to the end of this section of the perverse banquet hall, you hear a rumbling sound from the East. The screech of metal catches your attention, and a door to your right buckles, the steel filling with craters. The door slams open, hinges broken, and what you see...There’s something wrong here.  \n\n");
		outputText("In Mareth, hypersexualized people have become the norm to you. Giant cocks, breasts larger than your head, pussies of all shapes and sizes...At this point, you’d thought you’d seen it all.  \n\n");
		outputText("Fifty or so naked androgynous forms pour into the ruined banquet hall. They’re not uniform in height, race or...gender...or at least, what gender they used to be. With rising horror, you realize that these...creatures don’t have genitals. A thin pink gas wafts from the room they came from, and you can make out small pink capsules, crudely attached to some of the bodies. Before you have a chance to ponder this, however, one of them catches sight of you. It lets out a monstrous scream, raising wrinkled hands. Its black nails glint, inch-long living weapons. It charges towards you, and the horde follows, their eyes uniformly blank and glassy. \n\n");
		outputText("A demonic woman’s voice fills the air, seductive and sensuous. “Go, my Incels! Tear the intruder apart!” \n\n");
		//start combat with the Incels
		}
		if MainAreaComplete >= 2 {
		menu();
		addButton(2, "North", Ballroom3);
        addButton(12,"South", Ballroom1);
        addButton(6, "West", FireCheck);
        addButton(8, "East", IncelLab );
		}
}

public function IncelLab():void {
		clearOutput();
		if SexlessLabState = 0 {
		outputText("Several demons are inside the lab, but as they release the few remaining sexless they have left, the freaks turn on their...creators? Captors? Buried under their experiments, the demons cry out for help...but you have no intention of helping them.  \n\n"); 
		outputText("Instead of coming after you, however, the creatures rush over to a locked cabinet. Clawing at the metal with their bare hands, breaking fingers in their haste, the sexless...seem to have something left in their eyes. They’re still...People!  \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		menu();
		addButton (1, "Help", IncelLabHelp);
		addButton (2, "Nope", IncelLabIgnore);
		}
		if SexlessLabState = 1 {
		outputText("You open the door, to see a few of the former sexless, some buck naked, still humping each other, others seem to have recovered themselves, and are trying to put on the demon’s lab coats. A woman with long red hair, covering herself with her hands, sits in a corner, and as you approach, she bares her claws, leaping into your path. Her pussy drips white, a byproduct of the orgy she’d been in, and her green eyes flash with anger and fear.  \n\n");
		outputText("“Who are you?!” She demands. “We’re not going back to the cages. I’ll die first!” \n\n");
		outputText("You explain that you were the one who freed them...and the one who opened that cabinet. “Yeah...I recognize (him/her).” A rather feminine person adds. Looking over, you can see thin hips, a C-cup bust covered with a torn labcoat, and a pale angular face with cold blue eyes. Looking down however, you can tell that she didn’t find a succubus milk first. She’s rather small by Marethian standards, but her five inch human pecker is still ramrod straight.“Back off, Cilly, they’re not our enemy.”  \n\n");
		outputText("You explain that you’re the reason for the alarm, which gets a bunch of cheers from the former prisoners. The redhead looks you up and down, then saunters back to the woman who’d spoken. “...Okay, Mallah.” Mallah wraps her arms around the redhead, getting a moan and a shiver from her, but they both eye you, thinly disguised lust in their gaze. “But what...what do we do now?”  \n\n");
		outputText("“We go to Tel’adre.” A zebra-morph says calmly, his stripes barely noticable. His black fur has gone grey, whether from stress or age, you aren't sure. Unlike the others, he’s somehow managed to get the long, thin claws off his fingers, and he rolls his shoulders, thick slabs of muscle working. “Assuming it’s still there.” You assure the man that the city of the sands still stands, and he gives you a nod. “Well...When we make it there, we’ll need to check in with the city guard. There aren’t that many of us, but...you can’t be too careful about the demons.”  \n\n");
		outputText("The few people who have regained themselves mutter agreement, and he sighs. \"We'll need some time to get ourselves in order...but when we have, we'll head out into the ballroom.\" You nod, leaving the former Sexless to gather themselves. \n\n");
		doNext (Ballroom2);
		
		}
		if SexlessLabState > 1 {
		outputText("The lab that had once held the ghastly “Sexless” project is now a simple room. If it wasn’t for the shackles on the wall, the tables with surgical implements, and the vat of disgusting-looking fluid in the back, it could be just a fancy room. You have to watch your step, as shattered glass covers the floor.  \n\n");
		if SexlessLabState = 3 {
		outputText("Dead bodies, both of Sexless and demons, litter the floor. While some of the sexless were killed by the demons they turned on, most bear claw-marks from their fellows. It seems there wasn’t much left of those…You wince. \n\n");
			}
		}
		menu();
		addButtonDisabled(2, "North", "No Way North");
        addButtonDisabled(12,"South", "No Way South");
        addButton(6, "West", Ballroom2);
        addButtonDisabled(8, "East", "No Way East" );
		}

public function FireCheck():void {
		clearOutput();
		if Keycardgot = false {
		outputText("You stride up to the door, with its odd, glowing bar. You look for a handle, but find none. You push at it, but the steel refuses to yield. \n\n");
		doNext (Ballroom2);
		}
		if Keycardgot = true {
		outputText("The door's flame patterns glow as you approach, and as you place the keycard on the door, it slides aside. \n\n");
		doNext (FSpreaderLab)
		}
}

public function FSpreaderLab():void {
		clearOutput();
		if FSpreaderState = 0 {
		outputText("You open the flame-adorned door, a wave of sudden heat washing over you. You shrug off the increase in temperature, the light from the ballroom behind you giving way to a hot, bubbling red light coursing through the ceiling. You hear a click as you move forward, and you jump back as white-hot fire sears through the place you’d just been. \n\n"); 
		outputText("You cover your eyes with an arm, but even with your eyes half-closed, you can make out a half-dozen forms standing halfway down the narrow corridor. Another few bodies lie on the floor, but the heat-hazed air prevents you from seeing much further. You can make out blurs of motion, the sound of fire and the roars of combat, clashing steel and fangs. Flames course through the hallway behind them, casting dancing shadows through the corridor and the room beyond.  \n\n");
		outputText("“...They’re here.” The smallest form, in the middle, points at you. “Kill the meddler(s). Your younger siblings can finish deleting the...source material.”  \n\n");
		if KihaFollower = true {
		outputText("Your dragoness’s skin pales, and she hefts her axe. “Can you deal with those...things?” You nod, and she crouches. “Then get them, love...I need to stop this.” Evidently Kiha can see something in the dancing flames that you can’t. She leaps over the group in front of you, vanishing into the smoke.  \n\n");
		}
		outputText("Five crimson-scaled beings stand in front of you, not so different from Kiha, actually. Four are female, D-cup breasts and drooling cunts fully exposed. Small demonic horns jut from their foreheads, and their scaled tails are black and red, with a slight spade at the end. They grin at you, reptilian eyes wide with anticipation as they bob from side to side on taloned feet. In their hands are thin steel spears, and as they eye you, undisguised lust in their eyes, they run their fingers up and down the shafts of their weapons, wings spread wide. \n\n");
		outputText("The final draconic being stands a half-foot taller than the next largest dragonoid, barrel-chested and heavily armoured, wielding a sword over eight feet long, he takes a step towards you. Bull-like horns on the top of his head glint in the firelight, and his scent, like burnt semen, washes over you.  \n\n");
		outputText("“Leave it to me, master.” He rumbles. The succubus-dragon things form up around him. It’s a fight! \n\n");
		//Fight the Flamespreader group
		}
		if FSpreaderState > 0 {
		outputText("The smoke has cleared from this large series of rooms. The cages and shackles are now empty, but the entire place still holds heat. Most of the tables, books and other flammables have been reduced to ash, a thin layer of it covering the floor. A few drake’s flowers sit in the only unbroken pots, but they’re thin and warped, violet and black in colour.  \n\n");
		outputText("A single book sits, hardcover singed, but somehow not burnt. It looks like a diary of some kind. Maybe you’ll find some answers in it? \n\n");
		
menu();
addButtonDisabled(2, "North", "No Way North");
        addButtonDisabled(12,"South", "No Way South");
        addButton(8, "East", Ballroom2);
        addButtonDisabled(6, "West", "No Way West" );
	}
}


public function Ballroom3():void {
		clearOutput();
		outputText("This once grand ballroom floor is slathered in cum, blood and various bodily fluids. The stench of old sex hangs in the air. To the east is a single black door, with the same card-swipe mechanism as the other rooms. \n\n");
		if MainAreaComplete < 3{
		outputText("You notice a single blonde Succubus, wings fluttering madly, pulling at a black metal door leading North. She strikes the metal, leaving no indent in the hardened steel.  \n\n");
		outputText("“Hey, assholes, let me in! They tore through the guards, and-!” She whips around, seeing you advance, and the demoness’s eyes widen. Unlike most of her demonic brethren, she wears a simple white skirt and a tight, but not too revealing blouse. Genuine fear is in her eyes, but as you draw near, she holds out her hands.  \n\n");
		//if Marcus wasn't demonised
		outputText(" “Waitwaitwait! Don’t kill me, champion!” She sounds so...human, despite her horns, spade tail and clearly demonic wings, this succubus isn’t trying to seduce you or fight. “I know, if I fight you I’ll lose.” She slowly pulls something out of her top. It’s a clear square of material with a blue gem in the centre. “Let me live, let me go, and I’ll leave this here. It’s a keycard to all the doors in the compound.”  \n\n");
		//if he was 
		outputText("“...You’re the one behind all this?” Her purple skin shudders as she backs away. “...You know I won’t try to harm you, champion. We’ve met before, after all.” She looks back at the end room with disgust. “They’re trying to hide in there. A few eggheads. Too scared to even open the door.” She looks you up and down, a sly grin on her face. “I’ll tell you what. How about a deal? You let me go, and I’ll give you this.” She holds up a clear rectangle with a blue gem in the centre. “This is a keycard to every door in the facility, except for the panic room here. I give you this, you let me be.” \n\n");
		outputText(" \n\n");
		menu();
addButton (1, "LetGo", LetTheBitchGo);
addButton (2, "FuckHer", SloppySuccubus);
addButton (3, "Kill", JustDoItNoBalls);
		}
		if MainAreaComplete > 2{
menu();
addButton(2, "North", CheckThePanicDoor);
        addButton(12,"South", Ballroom2);
        addButtonDisabled(6, "West", "No Way West");
        addButton(8, "East", NightCheck);
		}

}

public function TyrantCheck():void {
		clearOutput();
		outputText("This metal door is unlike the one to the east. While it’s got a window, steel bars across the open parts, it’s nearly a foot thick and over fifteen feet tall. The door has the emblem of a...well...It appears to be a spider with dicks instead of legs.  \n\n"); 
		if Keycardgot = true {
		outputText("You notice a black strip next to the door. The middle of it glows as you approach, and you place your keycard on it. The door swings open, and you walk into a small room, covered floor to ceiling in blackened tile. A single drain sits in the center of the room.  \n\n");
		doNext(TyrantLab1);
		}
		if Keycardgot = false {
		outputText("The door resists all attempts to open it. You head back to the centre of the Ballroom.\n\n");
		doNext(Ballroom1);
		}
		
}

public function TyrantLab1():void {
		clearOutput();
		if TyrantLabEntry = 0 {
		outputText("You quickly see one of the demons who’d run, standing between you and a staircase leading down. A single plaque sits above the stairway, with two words written on it.  \n\n"); 
		outputText("“Project Tyrant.” The lab coat-clad demon says simply. He’s scrawny, with a stained lab coat and crotchless pants that reveal smooth skin, unmarked by any genitals. “Wait there, intruder(s). Or force your way down, it doesn’t matter.”  \n\n");
		
		if TyrantFollower = false {
		menu();
		addButton (1, "Walk", DemonGoPast);
		//addButton (2, "Fight", KillThisFucker);
		}
		if TyrantFollower = true {
		outputText("Your giant spider ally steps forward, her fury obvious. “You...Made more.”  \n\n");
		outputText("“Well, we couldn’t exactly let such a success go unused.” Tyrantia looms over the demon, who seems rather unphased by the massive, armoured tank of a woman in front of him. \n\n");
		outputText("“You made more people into THIS?!” Tyrantia’s horns begin to glow, and she throws her Dick to one side, lashing out. Her fist catches the scrawny demon in the jaw, throwing him back into the wall with bone-bruising force. “Do you have ANY idea what it’s like?” She skitters in, grabbing the demon by the throat. His eyes widen, and he grabs at the hands around his neck. “Spending every day knowing that you could turn, so easily? That you could lose yourself?” She tightens her grip, lifting the luckless being to her level. “You don’t...Of course. You were too weak. You don’t have a soul anymore.” She closes her eyes, rears back, and slams the being into the stone wall back-first, shattering the tile. He falls limp, and she drops him, looking at her now blood-covered hand with a look of shock.  \n\n");
		outputText("“Oh please. None of them turned out like you.” The demon, much to your surprise, stands back up, his bones creaking as he forces his way to his feet. “They came out dumb...Broken. No matter how much more gentle we were.” He laughs, a mocking, grating sound. “You have too much willpower for your own good, Prototype Tyrant! None of those broken fools could survive the process with their minds!” Tyrantia lunges forward again, but the demon’s faster. He pulls a small pistol from within his pocket. Before she can punch, the demon brings it up. The shot’s fired...and he falls over, dead.  \n\n");
		outputText("Tyrantia is silent and still, staring wide-eyed down at the demon scientist, but the stairs ahead shoot down into the mountain, and you can hear the occasional grinding of metal from within. What do you do?  \n\n");
		menu();
		addButton (1, "Comfort", TyrantLabComfort);
		addButton (2, "Wait", TyrantLabWait);
		addButton (2, "Continue", TyrantLabCarryOn);
		}
		}
if TyrantLabEntry > 0 {
outputText("This room is black, your feet making scratching sounds whenever you walk. There are a few tables, covered in various odds and ends. Some notes written in an oddly childlike scrawl, a few remains of lunches, even a few books that don’t seem to be of a pornographic nature. \n\n");
if TyrantLabState = 0 {
TyrantLabState = 1;
}
menu();
if TyrantCodec = false{
addButton(1, "Books", TyrantBookGet);
}
addButtonDisabled(2, "North", "No way North");
addButton(3, "DownStairs", TyrantPrison);
        addButtonDisabled(12,"South", "No way South");
        addButton(6, "West", TyrantLab1);
        addButton(8, "East", Ballroom1);

}
}

public function TyrantPrison():void {
		clearOutput();
		outputText("The lab is dark, but there’s periodic red lamps scattered throughout the place. Once your eyes get used to the dark, it’s not too bad, but the shadows are deep, and the sounds of skittering chitin scratching the stone lend the place an air of menace. The room is about half the size of the ballroom above, but much longer, and thinner, with thick pillars embedded into the wall periodically. Black webbing hangs from the ceiling and the walls, making crackling sounds as air flows through the sticky strands.  \n\n"); 
		if TyrantLabState = 1 {
		outputText("There’s a large, steel door on the far side of the hallway. Light shines through a crack. It’s clearly open, but as you near it, you can hear several voices arguing and yelling. You know instinctively it’s some of the demons who escaped the battle earlier.  \n\n");
		outputText("As you get further into the room, you realise that in between the pillars are smaller rooms...no, cages.  \n\n");
		outputText(" \n\n");
		}
		if DridersState = 0 {
		outputText("Whimpers and whispers fill the corridor as some of them catch sight of you. Most shy away, averting their gaze, while others look at you with fear in their eyes. Unlike the Driders in the swamps, these only have one pair of breasts, if female, and they have less demonic proportions. Their chitin is stained, splattered with...well, you know what. This is a demon’s lab, after all. The scent of stale urine, old sex, and barely noticable, cinamon. Most of the Driders here are female, but a few smaller males are among their number. \n\n");
		outputText("Without exception, these people are malnourished, bound to the wall, arms held up above their heads, spider-legs splayed out and thoraxes chained to the hard stone floor. Red and purple eyes stare back at you from within the dark cages...but you can’t feel the slightest bit creeped out by them. They’re of no threat to you...or anyone. \n\n");
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		}
		if TyrantFollower = true && DridersState = 0 {
		outputText("Your massive companion visibly shudders, shaking with suppressed anger. “I’m going to slaughter them.” Her voice shakes, and your amazoness looks down at you. “No mercy, no surrender, no letting them off after shoving my Dick into them.” You nod. \n\n");	
		}
		if DridersState = 0 && TyrantLabState = 2 {
		outputText("In their cages, the spider-people lie, eyes wide as they follow your every move. Hope, fear, anger, you can feel it all in dozens of gazes.  \n\n"); 	
		}
		if DridersState > 0 {
		outputText("The cage doors, broken and scattered across the room, reflect the light from the scarlet lanterns. Each cage is like an empty hole, a wound yet to heal...You shudder at the reminder of what had happened here. And yet, knowing you were responsible for breaking those chains...It’s enough. \n\n"); 	
		}
menu();
if TyrantCodec = false{
addButton(1, "Books", TyrantBookGet);
}
addButton(2, "North", TyrantLab2);
addButton(3, "UpStairs", TyrantLab1);
        addButtonDisabled(12,"South", "No way South");
        addButtonDisabled (6, "West", "No way West");
        addButtonDisabled(8, "East", "No way East");
}

public function TyrantLab2():void {
		clearOutput();
		outputText("The door slides open without a creak, and you enter into the top of a large, circular room. The top area, where you are, is twenty feet wide, wrapping around a fifty foot circular lab. A wide spiral staircase leads down into the main room.  \n\n");
		if TyrantLabState = 1 {
		outputText("but you immediately notice the cages. Every inch of the outside wall is lined with row after row of cages. Inside each cage is a hulking...You’d be hard pressed to call these things Driders. They’re massive, easily towering over most of Mareth’s residents. \n\n"); 
		if TyrantFollower = true {
		outputText("Even your massive companion takes a step back at the sight. Some of these creatures are nearly as big as her. \n\n");
		}
		outputText("Layered with muscle, blank eyes glowing and fangs dripping, clad in black steel, their breathing is deep, almost uniformly so. As one sees you, it grabs the bars, shoving its head between them and trying to bite you. Its mountainous shoulders stop it from going further, but it doesn’t give up, mindlessly slavering as it thrashes.  \n\n");
		outputText("You tear your gaze from that creature...They’ve made an army of these things. And from the crawling in your [skin], the two horns on their head...each one of these monstrous beings has a corruption aura.  \n\n");
		outputText("Three demons stand in the middle of the lab, with a dozen or so more heavily armoured incubi standing nearby. “We need to go.” One of the warriors says simply, his deep voice carrying. “The intruders tore through the security complement. Take the subjects and leave, that’s what we need to do.”  \n\n");
		outputText("“What about our research?! I don’t expect a meathead like you to understand what we’ve accomplished here, but I would expect you to understand their value!” A succubus in a lab coat wails, pointing at the warrior. “And we don’t have enough trained riders to-”  \n\n");
		outputText("“Then we make do.” A second Incubus chimes in. “Besides...We’re out of time.” The demons look up to see you, and their reaction is immediate. Several of the scientists back up, one pulls a lever on the wall, and a soldier screams into a conical device. “Project Tyrant! Form up!” You back up to the door as the cages all open. A few of the creatures don’t move, but the majority of them follow orders, their blank white eyes focusing on the Incubus’s commands.  \n\n");
		outputText("“I’ll handle this.” The largest of the Incubus Warriors steps up, jumping onto a giant Drider’s back. “Get everyone else out of here.”  \n\n");
		outputText("The giant Driders rush around you...and flee. They run towards the back of the lab, white eyes blank, following orders. You run towards the lab’s centre, where the creatures are massing, but the scientists are already too far away to attack. One massive creature, a single demon atop it, walks your way, against the mindless flow of corrupted flesh. \n\n");
		outputText("Facing you is a creature vaguely resembling a Drider. Easily seventeen feet tall and thirty feet long, the creature turns to face you, six crimson eyes gleaming. Its naked form is built like a tank, masculine, with no genitals to be seen. \n\n");
		outputText("Twin horns poke through the chitin covering its forehead. It breathes heavily, and as it takes a step, the spikes on its legs clank against the stone floor below. Corruption oozes from this creature in a sickening aura. It holds no weapons, but the massive muscles sloping down the creature’s arms leave little doubt that this creature doesn’t need a weapon to crush its foes.  \n\n");
		outputText("On the creature’s back sits a heavily muscled Incubus. His green eyes glare at you, and he shakes his head, pointing a light crossbow at you. \n\n");
		outputText("“Tyrant? Kill!”\n\n");
		outputText("You are now fighting Project Tyrant. \n\n");
		}
		if TyrantLabState = 2 {
		outputText("The lab that had once contained “Project Tyrant” is now empty and still. Some sort of serum sits abandoned in several different vials around the room, and the entire place reeks of antiseptic and blood. Tables adorned with odd, extremely sharp knives litter the middle of the lab, with massive cuffs on the corners. These devices were clearly made to hold down the people they were experimenting on, and the smell of blood intensifies as you near them.  \n\n");
		outputText("On the far side of the room, close to where the demons had fled, you see an ornate desk, made of rare wood and inlaid with gold leaf, thrown to one side. Upon closer inspection, you can see several books, once on the desk, now scattered through the room.  \n\n");
		outputText("A massive pile of rubble blocks what had once been a way out. \n\n");
		}
menu();
if TyrantCodec = false{
addButton(1, "Books", TyrantBookGet);
}
addButtonDisabled (2, "North", "No Way North");
        addButton (12,"South", TyrantPrison);
        addButtonDisabled (6, "West", "No way West");
        addButtonDisabled(8, "East", "No way East");
}
public function CheckThePanicDoor():void {
		clearOutput();
		if FSpreaderState = 0 {
		outputText("You look at the odd interface beside the door. The contraption is well beyond your understanding, but you know some kind of gemstone card unlocks it. Inside, a half-dozen demons of various description cower, guns of various descriptions pointed at the door. The door itself is made of solid black metal, and you see no way in. As you back away from the door, you can hear muffled sighs of relief coming from inside. \n\n"); 
		outputText(" \n\n");
		}
		if FSpreaderState = 1 {
		outputText("You notice a curl of smoke coming from inside the panic room, and you inspect the blackened steel door. The scent of burning flesh comes from within, and through the thick glass, you can see a single demon, standing on a charred, black...something, hopping from foot to foot. Several other blackened, charred lumps litter the panic room, and as you watch, the floor, glowing cherry-red, sends curls of smoke up from the lumps. Said smoke fills the room, sending the last demon into a blind panic. He flies over to a control panel, typing something in. \n\n");
		outputText("The door opens, and he flies out, a waft of smoke following him, obscuring him slightly...not enough to avoid you. As he tries to flee, strangely stiff wings trying to flap, you pounce, dragging him down to the floor. Mere contact with the floor causes him to scream in agony, and you bring your [weapon] down, ending the life of the last demon scientist in the safe room. As you finish the job, you hear laughter from below. Apparently the dragons had a little fun with their fire-breathing, at the demon scientists’ expense. For now, however, the panic room is far too hot (and rank) to enter.  \n\n");
		FSpreaderState = 2;
		}
		if FSpreaderState > 2 && DridersState > 1 && NightwalkerLabstate = 2 {
		outputText("You enter the now cooled Panic room, the heart of this diseased lab complex. \n\n");
		DoNext (PanicRoom);
		}
}

public function PanicRoom():void {
		clearOutput();
		outputText("You enter the panic room, and it’s relatively plain, almost like a small warehouse. Other than the singed demon corpses, the panic room has only two things of interest: A desk and high-tech panel, similar to the ones on the doors before, but far larger. If you had to guess, you think you’ve found the diseased heart of this lab. Maybe you can open the way out! \n\n"); 
		outputText(" \n\n");
		menu();
		addButton (1, "Console", Computer);
		addButtonDisabled (2, "North", "No Way North");
        addButton (12,"South", Ballroom3);
        addButtonDisabled (6, "West", "No way West");
        addButtonDisabled(8, "East", "No way East");
}

public function Computer():void {
		clearOutput();
		outputText("You sit down in front of the mess of buttons and lights. Several parts of the screen are cordoned off, showing several rooms...The Labs. You can see the labs through this device. You almost laugh. No wonder the demons in here were so terrified. \n\n"); 
		outputText("You focus on the rest of the screen...You need to get that fucking door at the entrance unlocked, so you and the others can leave. The screen seems mostly covered with porn or seemingly random symbols, but two things catch your attention. One titled \"Security Folder \", and the other titled \"settings\" \n\n");
menu();
if 
addButton (1, "Security Folder", Readme);
addButton (2, "Control Panel", CntrlAltDenied);
addButton (3, "Caveman", WEHAVETECHNOLOGY);
addButton (4, "Leave", Ballroom3);
}

public function Readme():void {
		clearOutput();
		outputText("Using the odd device by your right hand, you open the folder titled 'Security Protocols'. To your shock, it opens up some kind of...Light Book on the screen. You begin to read...But your eyes quickly begin to glaze over, the dull, long-winded sentences almost putting you to sleep. You recoil from the cursed thing, closing it and returning to the original screen. Was this some kind of magical mental trap?! \n\n"); 
menu();
addButton (1, "Back", Computer);
}

public function CntrlAltDenied():void {
		clearOutput();
		outputText("You open the \"settings\" folder, quickly flicking through the options. Some, like \"Brightness\" confuse you, but upon investigation, it just makes the device glow brighter or softer. Another, \"Sound\" would seem useful, but nothing happens when you adjust it. And what on Mareth is this \"BlueTooth\"? What are these demons into?  \n\n"); 
		outputText("Quickly frustrated, you realise you're getting nowhere with this infernal device! \n\n");
menu();
addButton (1, "Back", Computer);
}

public function WEHAVETECHNOLOGY():void {
		clearOutput();
		outputText("Roaring in fury at this inane device, you grab the screen in your hands, ripping it away from the wall. You quickly realise it's connected to a black, boxlike structure under the desk, and you rip it from the wall, throwing it against a wall and stomping on the sparking pieces for good measure.  \n\n"); 
		outputText("You don't know if that did anything even remotely productive, but damn, it felt good. At least you don't have to clean the bits up after! \n\n");
		WayOutBlocked = false;
		menu();
addButton (1, "Leave", Ballroom3);
}


//====================================
//Fight specific code (after)
//====================================

public function AfterFirstFight():void {
		clearOutput();
		outputText("As you finish dealing with those two Incubi, the door back out slams shut, and you hear a metallic clang as if a bolt has been slammed into place. A piercing sound fills the air, and you instinctively put your hands over your ears. The demons now know you’re here, and they’re trying to stop you from leaving! \n\n"); 
		outputText("Behind you, you hear the flapping of leathery wings. The demons who’d patrolled the skies outside are coming. You can’t break the door out. No choice but to go in! \n\n");
		WayOutBlocked = true;
Donext (EnteringDungeon);
}
public function AfterLabGuardsVictory():void {
		clearOutput();
		outputText("The final guard falls, and you put one hand on the closest wall, leaning on it. You peer around. While several of the demons are holding injuries, others lie still upon the ground. \n\n"); 
		if TyrantFollower = true {
		outputText("Your giant Drider lover walks over to you, not even noticing a struggling, injured Succubus that holds onto her back, desperately trying to use her Lust magic to take her down. She sees you staring, and she blinks, propping her Dick against the wall and scratching at her left fang with one hand.  \n\n");
		outputText("“What? Do I have something on my face or something?” She asks, then seems to notice the weight on her back. “Oh...Well, shit. Guess I missed one.” Tyrantia grabs the luckless she-devil by the leg, and spinning her upper body, she steps back, splattering the creature against the wall head-first. “What now?” She cracks her knuckles. “You lead, I’ll follow.”  \n\n");
		
		}
		if DivaFollower = true {
		outputText("As you catch your breath, you see Diva sampling one of the frontline soldiers. He flails, but Diva’s far stronger than him. She bites, then recoils. “Feh. Thou taste like...Garbage. You’re edible, but...so unappealing.” She brings her fist down onto the demon’s chest, punching right through his lighter armour, then tosses him away like trash. “I am ready to continue when you are.”  \n\n");
		}
		outputText(" \n\n");
		if KihaFollower = true{
			outputText("Your dragoness shakes her head, spreading her wings and swinging her axe down into the closest body. “IS THAT THE BEST YOU COULD DO?!” Kiha roars her anger, fangs flashing. A savage light shines in her eyes, but you can tell, (gods help you) that she’s happy. Happier than you’ve seen her in a long time. You know Kiha will follow when you move.  \n\n");
		}
if MainAreaComplete = 0 {
	MainAreaComplete = 1
	}
	Donext (Ballroom1);
}

public function IncelVictory():void {
		clearOutput();
		outputText("As the last of the disfigured demons hit the ground, you look at their fallen forms. These things that had once been people...They’d fought like a horde of mindless things, not even beasts.  \n\n"); 
		//if Marcus (the guy in the desert) has gone demon
		outputText("Something about one of their faces gives you pause. Upon closer inspection, you recognize the face of this now dead pseudo demon. He kind of looks like the man you’d met in the desert! His build and face are almost identical...You realise what had become of him, and it almost makes you retch. \n\n");
if MainAreaComplete = 1 {
	MainAreaComplete = 2
	}
		
}

public function TyrantLabComfort():void {
		clearOutput();
		outputText("You wordlessly put a hand on one of Tyrantia’s spider-legs. She flinches, but once she realises it’s you, she nods, her arms shaking. You ask her if she’s alright, and she shakes her head. “No time to worry about me, [name].” She strides over, picking up her Dick. “We’ve got other things to deal with here, before we leave.”  \n\n"); 
		TyrantLabEntry = 1;
		doNext(TyrantLab1);
}

public function TyrantLabWait():void {
		clearOutput();
		outputText("You watch the stairs for a few minutes, not acknowledging her loss of control, or the heavy, uneven breathing coming out from her helmet. Eventually, she puts a hand on your shoulder, her fur still on end. “Thanks for the wait. I needed that.” She strides toward the stairs, determination in her gaze.  \n\n"); 
		TyrantLabEntry = 1;
		doNext(TyrantLab1);
}

public function TyrantLabCarryOn():void {
		clearOutput();
		outputText("You give your giantess a few moments, but can’t keep still for long. You lightly slap her leg, just to get the giantess’s attention, and tell her that you need to keep going. You’ve got to focus, and you tell Tyrantia that you need her to have her head in the fight. This seems to strike a cord in her, and she straightens, her five eyes glowing brighter. “Of course. Sorry.” You wave her off, telling her that she didn’t need to apologise. She nods. “Where to now, then?”  \n\n"); 
		TyrantLabEntry = 1;
		doNext(TyrantLab1);
}

public function PrTyrantVictory():void {
		clearOutput();
		outputText("The injured creature that was once a Drider collapses, its legs folding. On its back, the Incubus begins to panic, but the injured Drider-beast grunts, grabbing the demon as he tries to flee. Sinking its massive thumbs deep into the demon’s eyes, the creature blinds the incubus, before throwing him to the ground. The demon’s neck breaks, and you brace yourself as the creature turns towards you, blood dripping from its injuries. \n\n"); 
		outputText("Its eyes focus, and it rushes past you, eight legs skittering. Before you realise what’s going on, the creature’s running towards the cages, where the Driders were kept. You kick yourself into high gear, but as the hulking beast sees the first cage, ripping the bars off without any discernible effort, it stops, tilting its head, leaning into the cage.  \n\n");
		outputText("The captive inside, an old female, pushes herself back against the wall, six eyes wide with fear. The creature that had been a Drider sees the fear, letting out a groaning, confused sound. Tossing the door aside, sending the screech of steel on stone echoing up the corridor, it moves to the next cage, repeating the process. Without exception, the captives avoid its gaze, recoiling in fear.  \n\n");
		outputText("As you watch, astounded, the mutated beast rips the doors off one cage after another. After the first few, it makes no move towards the captives. You go back to the lab, and pick up a keycard and ring of keys from the fallen demon.  \n\n");
		if TyrantFollower = true {
		outputText(" She watches the creature with wide eyes. She drops her Dick, arms shaking. She makes no moves to save her fellow Driders, but instead watches the creature. \n\n");
		}
menu();
addButton (1, "Save", PrTyrantVictorySave);
if TyrantFollower = true {
addButton (2, "T.Soothe", PrTyrantVictoryBeast);
addButton (3, "GiveKey", PrTyrantVictoryTossKey);
	}
}

public function PrTyrantVictorySave():void {
		clearOutput();
		outputText("You take the key, and begin to move to each Drider in the cages. As you unlock the first set of shackles, you look up, to see the massive creature looking you dead in the eyes. It opens its mouth...a hissing sound escapes. It moves its lips, but the sound doesn’t change. Looking deeper, you can see a blackened stump in the creature’s mouth...Where its tongue used to be.  \n\n"); 
		outputText("It nods at you, points at the other cages, dozens of them. It makes a breaking motion with its hands, then points at the chains. You tell the creature that you’ll free them, and it exhales deeply. Slowly, it stalks back to the lab. You look in, to see it staring into a full-length mirror.  \n\n");
		outputText("The elderly Drider in the first cell raises her head, her wrinkled arms shaking as you slip the key in. “Who are you?” Her voice is dry, a bare whisper, but you notice her thorax shaking, her mouth opening to bare brittle fangs, yellowed with age. You tell the elderly Drider that you’re the cause for the alarm, and that the demons on this level have fled.  \n\n");
		outputText("“Truly?” Her arm falls limp as you unclasp the irons, and she struggles to stand. “Then...Help me stand, traveller.” You help the woman to her feet, and she leans her spider carapace against the wall, chest heaving as she inhales to speak.  \n\n");
		outputText("“Free. We are freed. Fear not. Trust the traveller with the key.” She whispers into the wall. The Driders’ whisper travels up the cells, and from that moment on, the looks in the Driders’ eyes are less fearful. A few get their feet, and ask for a key from the ring, to free more of their kin.  \n\n");
		DoNext: (PrTyrantVictoryNext);
}

public function PrTyrantVictoryBeast)():void {
		clearOutput();
		outputText("You tell the creature that it's free. That there’s a way to heal it. It slowly shakes its head. It stalks back to the lab, and you see it staring into a full-length mirror, its entire body shaking. You realise…There’s nothing you can do for it. You take the key, walking over to the cell with a heavy heart. \n\n"); 
		outputText("The elderly woman in the first cell raises her head, her wrinkled arms shaking as you slip the key in. “Who are you?” Her voice is dry, a bare whisper, but you notice her thorax shaking, her mouth opening to bare brittle old fangs.  \n\n");
		outputText("You tell the elderly Drider that you’re the cause for the alarm, and that the demons on this level have fled. “Truly?” Her arm falls limp as you unclasp the irons, and she struggles to stand. “Then...Help me stand, traveller.” You help the woman to her feet, and she leans her spider carapace against the wall, chest heaving as she inhales to speak.  \n\n");
		outputText("“Free. We are freed. Fear not. Trust the traveller with the key.” She whispers into the wall. The Driders’ whisper travels up the cells, and from that moment on, the looks in the Driders’ eyes are less fearful. A few get their feet, and ask for a key from the ring, to free more of their kin.  \n\n");
		DoNext: (PrTyrantVictoryNext);
}

public function PrTyrantVictoryTossKey():void {
		clearOutput();
		outputText("You lightly toss the keys at Tyrantia. Stunned, it hits her in the shoulder, pinging off the steel armour. She catches it, more on instinct, and she looks down at you, stock-still.  \n\n"); 
		outputText("Motioning at the Drider captives, you tell her that you’ve got work to do. There’s a lot of locks to undo, after all. Tyrantia nods, forcing a smile onto her face. It looks pretty scary, but you keep your mouth shut, not wanting to hurt your Giantess lover. \n\n");
		outputText("“You’re right...I’ll get on the locks.” She tosses you one of the keys. “You too, alright?”  You nod, joining your giantess. You enter the cages first, undoing the first shackle before Tyrantia joins you. The elderly woman in the first cell raises her head, her wrinkled arms shaking as you slip the key in.  \n\n");
		outputText("“Who are you?” Her voice is dry, a bare whisper, but you notice her thorax shaking, her mouth opening to bare brittle old fangs. You tell the elderly Drider that you’re the cause for the alarm, and that the demons on this level have fled.  \n\n");
		outputText("“Then who is this, traveller? I can feel the corruption on her.” Tyrantia flinches, turning her head, and you grit your teeth. You tell the old woman that this is a brave warrior, and your companion. You tell her you won’t have her disrespect or hurt your giantess.“...Such fire...There is truth in your words...and yet, her corruption is...deep.”  \n\n");
		outputText("Tyrantia glares at the old woman. “Those fuckers did a lot to me. Do you want freedom, or not?” \n\n");
		outputText("“...I apologise for my...rudeness...Why don’t we let actions speak?” Her arm falls limp as you unclasp the irons, and she struggles to stand. “...Help me stand, traveller.” You help the woman to her feet, and she leans her spider carapace against the wall, chest heaving as she inhales to speak.  \n\n");
		outputText("“Free. We are freed. Fear not. Trust the travellers with the key.” She whispers into the wall. The Driders’ whisper travels up the cells, and from that moment on, the looks in the Driders’ eyes are less fearful. A few get their feet, and ask for a key from the ring, to free more of their kin.  \n\n");
DoNext: (PrTyrantVictoryNext);
}

public function PrTyrantVictoryNext():void {
		clearOutput();
		outputText("As the last of the shackles are thrown off, the remaining Driders begin to take stock of themselves. Gathering around the elder you’d released first, they speak in small, hissing voices. As you approach them, the elder woman steps from between her kin, bowing her head respectfully. You note that the other Driders have covered her with a crude blanket, and she shivers, though whether from age or cold, you can’t tell. \n\n"); 
		outputText("“I cannot thank you enough, traveller. I thought we would all perish in this terrible place.” She draws her hands in, and two of the stronger Driders offer their shoulders to support the frail elder. “But I must ask you...Where are our males? The ones you see here are less than half of our tribe.” You remain silent, but the look on your face is enough. Sobs begin to sound from within the Driders. The cries are weak, but full of emotion.  \n\n");
		outputText("One of the few males remaining raises his voice, walking to the front of the line. “Mother Oaklee”, he says nervously. “Our numbers are few, and we have no warriors. What shall we do? Where shall we go?” \n\n");
		if TyrantFollower = true {
		outputText("As your Giantess hears this, she whips around, prompting a series of startled gasps from the tribe of Driders. She advances, looming over them. “Did I hear you correctly? Is your elder Mother Oaklee of the Manaweavers?”   \n\n");
		outputText("The ancient Drider woman steps forward, shedding her guard. “Yes. You heard correctly.” Despite her age and withered frame, her voice is sharp, distinct. You imagine she was quite the battleaxe in her prime. “Whatever quarrel you may have with me, this is hardly the time or the…” Tyrantia lowers her spider-half to the cold stone floor and bows her head in respect, removing her helmet for the first time since you left camp.  \n\n");
		outputText("“No quarrel at all...Mother.” Tyrantia whispers, placing her spear on the ground. “I never thought I’d see you again.” The Driders’ eyes all go wide, dozens upon dozens of purple eyes glowing in the shadowy half-light. For a few seconds, there’s stunned silence. However, the elder Oaklee breaks it, her withered face lighting up with joy.  \n\n");
		outputText("“Tyrantia...Is that you?” Her joy quickly darkens as she takes in the horns, the horse ears. “...Daughter mine, what have they done to you?” As the shock wears off, several driders put themselves between Tyrantia and the withered elder, shock and fear on their faces. Tyrantia backs up, eyes widening, as they bare their fangs.  \n\n");
		outputText("“Mother, look at her. She’s one of them.” A young male says harshly. “They did to her what they did to the others.” He glares up, arms shaking. “Whoever you used to be...You’ve been changed. Stay back!” The cry is taken up by others, forming a wall between their elder and your giantess.  \n\n");
		menu();
addButton (1, "Intervene", PrTyrantVictoryNextSpeak);
addButton (2, "Silent", PrTyrantVictoryNextSilent);
		}
		if TyrantFollower = false {
		outputText("“Thank you, Traveller.” You introduce yourself, and she nods respectfully. “Thank you, [name]. So long as you live, you are a friend to our tribe.” She bows, and the Drider tribe follows suit. “We will be out in the main hall, until it is safe to leave this wretched place.” \n\n");
		DridersState = 2;
		DoNext: (TyrantLab2);
}
}

public function PrTyrantVictoryNextSpeak():void {
		clearOutput();
		outputText("You break the silence, standing between the Driders and your giantess lover. You loudly declare that Tyrantia is not the same as the ones you both fought together. You remind them that she was one of the people who just freed them all. He opens his mouth, but you loudly declare that the demons never broke her, even after they warped her body. You scoff at the male who started the cry, calling him a broken coward, turning on his rescuers, even his own kin.  \n\n"); 
		outputText("For a few stunned moments, the Driders are silent. The elder pushes through the pack, slapping the instigator on the head. “...Well spoken, traveller.” She steps forward on failing legs, holding her hands up. Tyrantia leans down, and the old woman wraps her twig-thin arms around her neck. “My daughter...How much you’ve grown.” She smiles, letting go and walking back to what remains of her tribe. “Go, Tyrantia. Look after your mate. We will make our way to the desert’s sands. Perhaps there, the demons won’t have as much power.”You mention that there are already people living there, free from the demons. You tell them that life in Tel’adre would be hard, but livable. They have rooms and houses vacant...If they can find the city. \n\n");
		outputText("“Thank you, Traveller.” You introduce yourself, and she nods respectfully. “Thank you, [name]. So long as you live, you are a friend to our tribe.” She bows, and the Drider tribe follows suit. “We will be out in the main hall, until it is safe to leave this wretched place.” \n\n");
		DridersState = 2;
		DoNext: (TyrantLab2);
}

public function PrTyrantVictoryNextSilent():void {
		clearOutput();
		outputText("Wordlessly, you put a hand on Tyrantia’s leg. She looks down at you, and you shake your head. You squeeze the limb tightly, giving her a smile, and she nods down at you.  \n\n"); 
		outputText("“Y’know what, fine. Look after yourselves, you ungrateful shits.” This gets more fear, and she raises her arms suddenly, raising her voice. “Boo!” Several of the Driders recoil, and she scoffs. “Just ignore the fact we saved your asses from ending up like this, or worse. I’ve got better things to do than try and justify my existence to you.” She turns her back on the tribe. “Cmon, [name]...I need to punch something.”  \n\n");
		outputText("“Tyrantia, wait!” The elder woman raises her voice. Your giantess shakes her head, spitting on the ground beside her.  \n\n");
		outputText("“Corrupt I may be, but I haven’t lost myself. [Name] made sure of that.” Tyrantia growls. “I have sisters to find and demons to kill. Goodbye, mother.” She turns her back, walking back into the room where project Tyrant was.  \n\n");
		outputText("The distraught mother turns her gaze to you, unspeakable sorrow in her gaze. “...Look after her, please. I know you have been, but…” You tell the elder that she should look after her tribe for now. You mention Tel’adre, and its wards, and she nods. “Then there we shall go. But first...We must take what we can. We are in no condition to flee.”  \n\n");
		outputText(" \n\n");
		DridersState = 2;
		DoNext: (TyrantLab2);
}

public function FSpreaderVictory():void {
		clearOutput();
		outputText("The last of the dragon women in front of you fall, leaving the male the lone survivor. Covered in wounds, blood pooling at his feet, the barrel-chested man spreads his wings, bloodshot eyes aimed right at you. As you gaze back, his pupils dilate, his arms begin to shake uncontrollably. His sword clatters to the ground, and your foe falls to his knees, staring at his clawed hands with disgust.  \n\n"); 
		outputText("“...What…Was the point?” He looks down at the fallen women beside him…then back at the demon behind him. He coughs, the light fading from his eyes.  \n\n");
		if KihaFollower = true {
		outputText("As the short scientist takes a step back, fear in his eyes, Kiha comes flying in from behind, her axe held over her head. She roars, bringing it down upon the demon scientist’s skull. Her flaming axe cleaves the luckless creature in half, and your dragoness stands. Several horned figures stand behind her, and your eyes widen. You point back at them, and Kiha gives you a small smile. Tears pool in her eyes, and she looks back at them. \n\n");
		outputText("“[name], they weren’t all gone.” You blink, realising the draconic figures aren’t moving towards you. As the smoke clears, you realise that, while they’re clearly dragon-morphs like Kiha, unlike the ones you just fought, they don’t have demonic features.  \n\n");
		outputText("The largest of the draconic beings steps forward, clearing the smoke. He’s a barrel-chested dragon-morph with red scales and black reptilian eyes. He looks at you, blood-dripping claws belying the clear nervousness on his face.  \n\n");
		outputText("“Who are you?” He asks. Kiha, however, leaps at you, arms open wide. She grabs you in a bone-creaking hug, but it only lasts a few seconds before she snaps out of it, realising where she is.  \n\n");
		outputText("“Well… [He/She] is a friend, apparently.” A dry voice sounds from near the back. You watch as a few dozen more dragon-morphs slink out from the smoke. Most are injured, but they stand on their own power. “What’s going on?” An older male steps forward, his red scales faded with bits of grey. The scales around his eyes are sunken, and his left leg shakes. \n\n");
		outputText("Kiha looks back at the elder. “This is [name]. They’re an otherworlder. We came to…Well…We didn’t think anyone would be left.” Kiha’s leaning heavily on you, and you realise there’s tears in her eyes. “[name]...Some of my people are still…”  \n\n");
		outputText("The elder dragon’s eyes widen. “...Kiha, is that you?” He closes his eyes, lowering his head. “Oh young warrior…” He begins laughing merrily, looking back up at you both, his eyes twinkling with merriment. “I knew you were too rambunctious for those filthy demons!” A ragged cheer erupts from the dragon-morphs, and Kiha blushes, looking down and away from you.  \n\n");
		outputText("“I-I hardly think this is the time.” She says, cheeks bright red. “W-we’re not out of the woods yet.” This gets a few wolf-whistles, some guffaws, and a few ragged cheers. “I’m being serious! This place isn’t safe for you.”  \n\n");
		outputText("“We’ve survived for now.” The elder replies darkly. “We’re not quite done. Besides, we can’t let your (Boyfriend/Girlfriend) here have all the fun. Those sex-crazed maniacs gave us this power, it’s high time we used it!”  \n\n");
		}
		if KihaFollower = false {
		outputText("The scientist, realising that his creations are dead, turns tail. Despite your exhaustion, you pick up one of the fallen dragoness’ spears, your [legs] filled with sickening, adrenaline-fueled speed. You run the demon scientist through, and as he falls, you hear wingbeats, leathery and even. You look up, seeing five more draconic beings through the smoke. Dropping the demon, you ready your [weapon] for combat.  \n\n");
		outputText("The largest of the draconic beings steps forward, clearing the smoke. He’s a barrel-chested dragon-morph with red scales and black reptilian eyes. He looks at you, blood-dripping claws belying the clear nervousness on his face.  \n\n");
		outputText("“Who are you?” He asks. You look at him, the nakedness of the draconic being in front of you, and in the stunned silence, he sees the spear, the demon scientist you’ve impaled on it. “I guess it doesn’t matter. You killed that fucker?” You nod, and he turns to a cage beside him, ripping the bars off. “And I’m assuming we have you to thank for the alarms going off. We’ll talk later, once everyone’s free.”  \n\n");
		outputText("You watch as a few dozen more dragon-morphs slink out from the smoke. Most are injured, but they stand on their own power. “What’s going on?” An older male steps forward, his red scales faded with bits of grey. The scales around his eyes are sunken, and his left leg shakes.  \n\n");
		outputText("“We found the reason why the demons were panicking, elder.” The male dragon-morph beside you says. “This is…well…Please introduce yourself.” You shake the elder’s hand, and he bows respectfully. You introduce yourself as a champion from Ignam, and you tell the elder that you came here to destroy the demon’s attempts to make more powerful soldiers.  \n\n");
		outputText("“Then you have freed us. We are indebted to you, otherworlder.” The group of dragonoids nod. “We have been in here a long time, however. Would you know of a safe place? Does such a thing even exist?”  \n\n");
		}
		outputText("You tell the dragonoids about Tel’Adre, the hidden city of the sands. The group pays rapt attention, and the elder claps his hands once you’re finished. “I believe we know enough. If the people of Tel’Adre are as you say, perhaps we can find a place among them.” He pauses. “But first…This place must be cleansed.” The other dragons nod, grim looks on their faces. “These Demons gave us firepower, so I say we give those unholy bastards a baptism. BY FIRE!”  \n\n");
		outputText(" \n\n");
FSpreaderState = 1;
}


//===================================
//Event code outside combat
//===================================

public function LetTheBitchGo():void {
		clearOutput();
		outputText("You slowly nod, telling the fearful demoness to leave the card and go. Keeping your [weapon] on her, she slowly edges around you, hands still raised above her head. The busty demoness takes off the moment she thinks she’s out of your range, leaving the card behind.  \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		MainAreaComplete = 3;
		Keycardgot = true;
menu();
addButton (1, "Next", Ballroom3);
}

public function SloppySuccubus():void {
		clearOutput();
		outputText("You tell the Succubus that you won’t hurt her...If she leaves the keycard. She steps away, and you pocket the item. Relieved, the blonde turns to leave...until you grab her by the wings, pulling her down and slamming the demoness against the floor. Her enormous breasts cushion her fall, and she giggles a little, waving her bubble butt at you. Her skirt is less chaste than you’d thought from before, her panties cut open to reveal her juicy snatch.  \n\n"); 
		outputText("“H-hey, you said you’d let me go!” You remind her that you never said that...You just told her that you wouldn’t hurt her. The succubus’s fear seems to melt, and she gives you a lascivious smile. “Well, now I regret having you make that promise”, she says slyly, her spaded tail .  \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		MainAreaComplete = 3;
		Keycardgot = true;
menu();
addButton (1, "Fuck", SuccFuck);
addButton (2, "Assfuck", SuccAss);
addButton (3, "Scissor", SuccVag);
addButton (4, "Nah", LetTheBitchGo);
}

public function SuccFuck():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
DoNext: (Ballroom3);
}

public function SuccAss():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
DoNext: (Ballroom3);
}

public function SuccVag():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
DoNext: (Ballroom3);
}


public function JustDoItNoBalls():void {
		clearOutput();
		outputText("You take the card from her hands. You tell the succubus that you knew some demon would see reason. \n\n"); 
		outputText("“R-really?” She asks, disbelieving. You give her a disarming smile, putting a hand on her shoulder. You tell her that yes, you know that there are good demons. After all, there’s one trait that all good demons share, that you saw within her. \n\n");
		outputText("The succubus seems relieved at this, letting you guide her towards one of the cages. “Oh? What trait is that?”  \n\n");
		outputText("You take her head in both of your [hands], forcing the demoness to her knees. Coldly, you tell the succubus that the only good demon is a dead demon. She barely gets a squeak out before you wrench her horns, snapping her neck. You let go of the body, adding her to the pile of dead demons littering the floor.  \n\n");
		outputText(" \n\n");
Keycardgot = true;
MainAreaComplete = 3;
menu();
addButton (1, "Next", Ballroom3);
}

public function LeaveDungeon():void {
		clearOutput();
		if ((MainAreaComplete = 3) && (DridersState = 1) && (FSpreaderState = 2) && (WayOutBlocked = false) && (NightwalkerLabstate = 2)) {
		outputText("As you approach the exit to the Lab, you notice the various groups you’ve rescued, all preparing to leave as well.  \n\n"); 
		outputText("“It seems we’re all heading the same way”, Old Miss Oaklee says simply. She looks at the dragons with surprise. “Although I didn’t realise we’d be sharing a path with the dragons.” She gives them a sour look.  \n\n");
		outputText("“We didn’t start this way, Drider.” The eldest dragonoid retorts, exhaling a little bit of flame. “You’re looking at the remains of the Lizan village of Dremfell. The demons are to blame for our current appearance.” \n\n");
		outputText("The two groups grumble a little, but both elders nod respectfully. “So it would seem we share a common goal, enemy and benefactor, in [name], here.” The elderly Drider offers a bony hand, and the old, scaly dragonoid shakes it gently.  \n\n");
		outputText("“Working together would be beneficial to both our peoples.” He replies. “Besides…anybody else who survived this hell with their mind intact deserves my respect.”  \n\n");
		if KihaFollower = true; {
		outputText(" Kiha stomps her foot impatiently, getting a chuckle from her elder. “Kiha, my dear. Impatient as ever. Never fear, we’re just gathering the last of what supplies we can find in this place.” \n\n");
		outputText("“A web can only be woven so fast.” Mother Oaklee chimes in. Kiha looks back at you, giving you a look that can only be described as impotent annoyance.  \n\n");
		}
		if TyrantFollower = true {
		outputText("Your giantess stands at the door, keeping an eye out for any demons who might be returning. One of the few Drider males remaining approaches her, exchanging a few words before he nods, returning to the tribe. He seems confused, but a little happier than before.  \n\n");
		outputText(" \n\n");
		}
		if DivaFollower = true {
		outputText("Your Draculina stands on one of the support beams, watching over the assembled people. “Pulling back from the brink of a fate worse than death, the souls doth rejoice. Changed though they may be, none considereth the miracle they doth witness. A single moment in time though it may be, this deed shall remain with those assembled until the end of their days.” She raises her voice, and the assembled former test subjects fall silent for a moment as her voice rings through the defiled ballroom. “Hail to the breaker of chains! [name], Champion of Mareth!” For a moment, silence… \n\n");
		outputText("“Hail!” Mother Oaklee’s frail voice replies. “Hail to the Chainbreaker!”  \n\n");
		outputText("“Hail!” This from the Draconic elder. He lets loose a gout of flame that nearly reaches Diva’s perch. “Hail to the Chainbreaker!”  \n\n");	
		if SexlessLabState = 2 {
		outputText("Mallah and Cilly stand, the man from Tel’adre joining them as they add their voices to the mix. “Hail to the Chainbreaker!”  \n\n");
		outputText("This roaring applause goes on for a few minutes, but it dies down eventually. You tell everyone that your job isn’t done yet, and that everyone should get ready to go.  \n\n");
		outputText(" \n\n");
			}
		}
		outputText("As the groups you've saved pack up, you sigh. You're going to have a hard time explaining this to the people of Tel'Adre. While you worry about the demons ambushing your slow-moving, large group, any potential enemy you see is scared off with ease. \n\n");
		menu();
		addButton (1, "Next", TelAdreBring);
}
if MainAreaComplete < 4 {
if WayoutBlocked = true {
outputText("You can't budge this steel door, no matter how hard you strike it. Perhaps inside the facility, you'll find a a way to unblock the door? \n\n");	
}
if NightwalkerLabstate < 2 {
outputText("You haven't rid this place of the Nightwalker's influence. You feel you shouldn't let such a dangerous project remain. \n\n");	
}

if FSpreaderState < 2 {
outputText("The Firespreader Project is still untouched. You shudder to think what the demons could do if you leave that intact. \n\n");
}
outputText("You walk back into the Ballroom, intent on seeing this through to the end.\n\n");
DoNext: (TyrantLab1);
}
if MainAreaComplete = 4 {
	outputText("You leave the empty lab behind, wind roaring in your ears as you head back down the mountain to camp. \n\n");
	TyrantFollower = false; 
	KihaFollower = false;
	DivaFollower = false;
	doNext(camp.returnToCampUseOneHour);
}
}
 
public function BadEndExperiment():void {
		clearOutput();
		outputText("You open your eyes, finding yourself stark naked, shackled to a wall in a clean white room filled with arcane instruments, your [arms] and [legs] spread as far apart as they’ll go. You struggle, but all you manage is to rattle your irons.  \n\n"); 
		outputText("“Ah, welcome, ‘champion’.” A single incubus says, looking up from a clipboard. “So nice of you to volunteer. We always need more test subjects.” To your horror, you notice two burly Incubi wheeling in a strange vat filled with brackish fluid. The stench of it is enough to make your eyes water, and the demon sighs. \n\n");
		outputText("“Oh, I know, dreadful stuff, isn’t it?” His voice, dripping with mock sympathy, sends chills down your spine. “Not like this.” He motions to a vial of Lustdraft on the table beside him. Your cheeks flush with arousal, and he chuckles, walking slowly towards you. You struggle, but are unable to stop him as he inspects your cheek, running a finger down your neck, then down to your [chest]. The oddly gentle touch, however, turns to sudden agony, your vision blurring, as he sinks a clawed fingernail into your chest, just below your breast.  \n\n");
		outputText("“Let me be clear, you monumental pain.” The doctor says, his voice hardening. He sticks his face into yours, teeth bared in sudden anger. “That factory was difficult to maintain, but it was the simplest way to flush that insufferable goddess and her last guardians out. So...You’re not leaving here...not as you are.” The Incubus twists his razor-sharp claw, and as he does, twin succubi walk towards you, their gloved hands slathered in a thick, clear gel. You struggle more, but you’re unable to move as the doctor steps back, letting the she-demons slather their gel between your legs. Your endowments heat up at the mere touch, going from pleasantly warm to molten in an instant. You flail, rattling your restraints, but when the succubi step back, you look down. To your horror, there’s nothing between your legs but smooth skin...And your legs are still warming up.  \n\n");
		outputText("“Oh, already feeling it, are we?” The doctor asks mockingly. “No genitals...no release. Enjoy the last moments you have before your mind breaks.”  \n\n");
		outputText("You hold on for what seems like an eternity, trying desperately to ignore the still rising lust in your loins, the desire to...what? Be filled? Fill another? You try to think about what you’d want, but...it slips. You...Don’t know what you want, only that you need to rid yourself of this desire, this...Heat.  \n\n");
		outputText("You fall from the wall, your [legs] buckling. You see the two...Them. They know what you need, what you want! They’d better give it to you! In a haze, what’s left of your mind tries to think, to find a way out...But your body’s already moving, black claws slashing towards those sweet lumps of flesh, the…! Your vision goes black.  \n\n");
		outputText("You wake up in a dark, dingy room, several others sniffing your [legs]. Growling, you whack their faces away. They’re like you, after all. They won’t know how. How to what? You don’t know. Grabbing your head, you roll on the floor, unable to make sense of the swirling pink confusion that is your mind. Eventually, you slump, falling limp. Your head throbs with need...But you can’t remember what you need.  \n\n");
		outputText("Your body, stripped of its mind by the constant lust, becomes one of hundreds, a mindless horde of barely conscious meat. Ignam learns to fear the Sexless, and their master, almost as much as Lethice herself. As for you? What is there even left?  \n\n");
		outputText("GAME OVER\n\n");
		outputText(" \n\n");
		outputText(" \n\n");
//Bad end shit here
}

public function TelAdreBring():void {
		clearOutput();
		outputText("The going is slow, but you lead the large group into the desert. While a few of your number have a run-in with a sandtrap, the few Sand Witches you see keep their distance. \n\n"); 
		outputText("As you near the city of the sand, however, you notice a large commotion within. Bells are ringing, and the gate opens, spilling Tel'Adre's guards out in force. \n\n");
		outputText("You realize that giving Tel'Adre's guard no notice of your arrival may have been a poor decision on your part. \n\n");
		outputText("You hold your hand out, telling everyone to stay there for now. You say that you’re going up to make sure they know what’s going on. The two elders look at each other, nod, and take up positions at your flanks.  \n\n");
		outputText("“We will assist you in that”, mother Oaklee says simply, quickly weaving some silk into an improvised white flag. The draconic elder simply nods, folding his arms behind his back. \n\n");
		if SexlessLabState = 2 {
		outputText("The older zebra-morph from the Sexless lab joins, standing directly behind you. “It’s good to see my hometown again.” He whispers. “I used to be one of the outriders.”  \n\n");	
		}
		outputText("Waving the improvised white flag, you walk until you’re fifty meters or so away from the rest of your group, halfway between Tel’Adre and the large band of refugees. After a few minutes of murmurs, three people break away from the Tel’Adre guard, joining you in front of the city. As they get closer, you recognize two of them.  \n\n");
		//Variables depending on Urta's state with the PC
		outputText("Urta, her halberd in her hands, (default) blinks in surprise (scorned) sneers slightly, setting her jaw, (Lover) grins widely at the sight of you. (If kids) She breaks decorum entirely, walking up to you and giving you a big hug before returning to her more serious role. \n\n");
		outputText("Edryn’s reaction is a little more subdued. She gives you a wink and a ‘shh’ gesture, then tilts her head, looking past you to the collection of people behind you.  \n\n");
		outputText("Between them is a scrawny pig-morph, his skin a waxy, pale pink from head to toe. He wears purple robes trimmed with gold, looking like a politician, or a bookkeeper of some sort. He looks slightly scared, but hides it under a facade of self-importance, puffing his chest and trying to look tough.  \n\n");
		if SexlessLabState = 2 {
		outputText("Edryn sees the man behind you, and she gasps, putting one hand in front of her mouth. “Metaba, is that you?!” She stomps her back foot. “We thought you were DEAD!” She breaks rank, and he walks out in front, giving her a humourless smile. \n\n");
		outputText("“Well, being captured by demons and experimented on…it does cause one to miss a few shifts, captain.” The two exchange grips, much to the annoyance of the councilman present. \n\n");
		outputText("“Captain, that is enough.” He barks. “This man could easily be a demon.” He looks at you, puffing out his chest. “I’m assuming you have some form of explanation for this…mob outside our gates?”  \n\n");
		}
		if SexlessLabState != 2 {
		outputText("The pig-morph steps forward. “My name is Brag Cutlet, of the Tel’Adre council.” You nod, stating your name, and he nods. “So…What exactly is the meaning of this mob outside our city? Do you have an explanation? \n\n");
		
		}
		outputText("You nod, and motion to the elders beside you. You tell the pig-morph of the demonic laboratory, and the horrors you witnessed within. Then you cede the floor to Mother Oaklee, who tells the pig-morph of what befell her people, and what the demons had done to her tribe…no, her children. To your surprise, as the Draconic elder begins to speak, the councilman holds up a hand, scratching his snout with his other. His face is serious, giving nothing away, but he seems to have lost the annoyance in his gaze.  \n\n");
		outputText("“Captains? What do you think?” He squints past you, to the people behind. Evidently, his eyes aren’t the best. \n\n");
		outputText("Urta looks at the people behind you. “...The Driders are malnourished…Very few men among them.” She squints. “...Their clothing is ragtag.” She nods. “The story appears to check out, sir, but more investigation will be needed..”  \n\n");
		outputText("“And what about [name] here?” He looks at you thoughtfully. “Can we trust them with Tel’Adre’s safety?”  \n\n");
		outputText("Edryn nods. “Sir, [name] is an otherworlder who lives out by one of the portals to other worlds. They’ve had to fight to survive, and they have. Demons fear them. (If you have children with her). “I trust them with my life…and they’ve proven themselves to be a good person. As have their children.”  \n\n");
		//Lots of qualifiers in the following text. No idea where to find the qualifiers. 
		outputText("(If you’ve done Urta’s quest) “[name] here literally helped me bring an uncorrupted God back into play. If that isn’t contributing to Tel’Adre’s safety, I don’t know what is.” This from Urta, who gives you a warm smile.  \n\n");
		//(If you’ve had kids with them both)
		outputText(" The pig-morph gives both women a glare. “Ah, so this is the one you’ve both been sleeping with.” The two ladies look at each other, grinning. Brag rolls his eyes.  \n\n");
		
		outputText("“Look, [name]...You know what I’m risking, bringing these people into Tel’Adre. Can you tell me, right now, that the risk is worth it?”  \n\n");
		//if you have ANY kids in Tel'Adre {
		outputText("You remind the councilman that you have children in his city. It’s not like you’re a complete outsider. People you love call this place home, even if you don’t. \n\n");
		//}
		outputText("You tell the reluctant councilman that these refugees have nowhere else to go, and if nothing else, Tel’Adre would benefit greatly from the extra hands, especially ones as strong as the dragonoids. You explain the potential upsides to having pseudo-dragons and silk-producing Driders in the city. You also tell Brag that he has some of the best people working to ensure the safety of Tel’Adre’s streets…unless he doesn’t trust in their abilities.  \n\n");
		outputText("Edryn and Urta look in at Brag, and the pig-man smirks slightly. “You think I’m foolish enough to fall for such an obvious trap?” He chuckles. “You’re good with your words, outlander. I’ll need to get approval for more permanent residence…but I do have the authority to bring them in and get those people food and shelter for now.” He gives you a wry smile. “You’re making a ton of work for me, [name], but if even half of this lot end up pure enough to stay…You’ve done our city a great service, to say nothing of the lives you’ve saved.” He raises his voice, yelling back at the assembled guards.  \n\n");
		outputText("“Alright, you lot! Open the gates and get ready to process these people. We’re going to need clothing, temporary housing and water. Anyone on the processing team, wake them the hell up, and get 'em out here! I want this shit done by the start of the Council session today!”  \n\n");
		outputText("The guards get to work, the gates open, and a ragged cheer comes from several dozen ragged throats. The victims of the Demon’s experiments are being escorted into the city of the sands.  \n\n");
		outputText("Both elders give you a grateful look, thanking you before returning to their people. Urta and Edryn give you a grin, flanking Brag as the three of them head back to the gates to oversee the process.  \n\n");
		if TyrantFollower = true {
		outputText("Your giantess lover squints, looking at you. “[name]…I can barely see anything. There’s…A gate in midair that people are walking through.” You realise that your giantess can’t see the city at all. Her corruption is too high, and the wards can tell. With a heavy heart, you tell Tyrantia that Tel’Adre has wards preventing the corrupt from seeing the city. \n\n");	
		outputText("“...I suppose that’s fair.” She lowers her head. “...At least they’ll be safe in there.” You tell Tyrantia that you’ll talk to that councilman about it. She smiles sadly, watching as the first Drider crosses the threshold…and for her, vanishes.  \n\n");
		
		}
		if KihaFollower = true {
		outputText("One of the dragonoids walks back over, grinning at Kiha. “So, you’re coming to visit, right?” Kiha’s eyes widen, and she blinks twice. “What? You still think you’re that scary?” He chucks your dragoness on the shoulder. “Pretty sure the demons have you beat there.”  \n\n");
		outputText("“Th-they do not have me beat!” Kiha fires back, only for the dragonoid to laugh, flying back to the line. Kiha’s cheeks are reddened, and she looks back at you. “[name], I’m scarier than any demon!” You chuckle, hugging Kiha. She pouts, hugging you back. You assure Kiha that she’s plenty terrifying. \n\n");
		}
		if DivaFollower = true {
		outputText(" \n\n");	
		}
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		MainAreaComplete = 4;
		FSpreaderState = 3;
		DridersState = 2;
		if SexlessLabState = 2 {
		SexlessLabState = 4;	
		}
		TyrantFollower = false; 
	KihaFollower = false;
	DivaFollower = false;
	doNext(camp.returnToCampUseOneHour);
		}
*/}
}