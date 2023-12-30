/**
 * Story Dungeon: The Demon's Laboratory
 * @author Canadian Snas
 */
package classes.Scenes.Dungeons {
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Races;
import classes.Saves;
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.internals.SaveableState;

//Things that will need to be put in other files
//Enemies
//
public class Domsdomain extends DungeonAbstractContent implements SaveableState {
    public static var CeraphHumiliation
    public static var CeraphSubby2You
    public static var CeraphAffection
    public static var DomainProfit
    public static var MeilaTrust
    public static var MeilaCeraphSubmissiveness
    public static var EmeraldConfidence
    public static var EmeraldResiliance
    public static var EmeraldFearsCeraph
    public static var SeenDDullahan
    public static var SeenEmerald
    public static var ZetazState
    public static var SeenPotionShop
    public static var
    public static var
    public static var
    public static var

    public function resetState():void {
        
    }

    public function stateObjectName():String {
        return "Domsdomain";
    }

    public function saveToObject():Object {
        return {
            
        }
    }

    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o) {
            
        } else {
            // loading from old save
            resetState();
        }
    }

    public function Domsdomain() {
        Saves.registerSaveableState(this);
    }

    //========================================================
    //Room Code
    //========================================================
    public function EnteringDungeon():void {
        clearOutput();
    
    }

    public function EntertheDomain:void {
        dungeonLoc = DUNGEON_LAB_ENTRANCE;
        clearOutput();
        outputText("The floors, walls and ceiling are all constructed from an odd, almost white metal, and every footstep sends echoes through the place.\n\n");
        outputText("The only notable features in this room, other than the sterile white orbs floating next to the ceiling and two overturned padded tables, are several sets of shackles along the back wall. Upon closer inspection, you see a drain in the center of the room, and an odd rubber tube and nozzle tucked into the back-right corner. The thought of what fluids must have once stained this floor sends a chill down your spine.\n\n");
       
			dungeons.setDungeonButtons(Mainhall1, null, null, null);
            addButton(11, "Leave", LeaveDungeon);
        }
    }


    public function Mainhall1:void {
        clearOutput();
        dungeonLoc = DUNGEON_LAB_BALLROOM_1;
        
        dungeons.setDungeonButtons(MainHallSouth, (EntertheDomain TyrantCheck, null /*ArmouryCheck*/);
    }

    public function MainHallSouth():void {
        dungeonLoc = DUNGEON_LAB_BALLROOM_2;
        clearOutput();

        dungeons.setDungeonButtons(Ballroom3, Mainhall1, FireCheck, SexlessLabState > 0 && MainAreaComplete < 3 ? null : IncelLab);
    }

    //TODO: fix fucking italic font

    public function IncelLab():void {
        dungeonLoc = DUNGEON_LAB_INCEL;
        clearOutput();
        if (SexlessLabState == 0) {
            outputText("Several demons are inside the lab, but as they release the few remaining sexless they have left, the freaks turn on their... creators? Captors? Buried under their experiments, the demons cry out for help... but you have no intention of helping them.\n\n");
            outputText("Instead of coming after you, however, the creatures rush over to a locked cabinet. Clawing at the metal with their bare hands, breaking fingers in their haste, the sexless... seem to have something left in their eyes. They’re still... People!\n\n");
            menu();
            addButton(1, "Help", IncelLabHelp);
            addButton(2, "Nope", IncelLabIgnore);
        } else if (SexlessLabState == 1 && MainAreaComplete >= 3) {
            SexlessLabState = 2;
            outputText("You open the door, to see a few of the former sexless, some buck naked, still humping each other, others seem to have recovered themselves, and are trying to put on the demon’s lab coats. A woman with long red hair, covering herself with her hands, sits in a corner, and as you approach, she bares her claws, leaping into your path. Her pussy drips white, a byproduct of the orgy she’d been in, and her green eyes flash with anger and fear.\n\n");
            outputText("“<i>Who are you?!</i>” She demands. “<i>We’re not going back to the cages. I’ll die first!</i>”\n\n");
            outputText("You explain that you were the one who freed them... and the one who opened that cabinet. “<i>Yeah... I recognize [him].</i>” A rather feminine person adds. Looking over, you can see thin hips, a C-cup bust covered with a torn labcoat, and a pale angular face with cold blue eyes. Looking down however, you can tell that she didn’t find a succubus milk first. She’s rather small by Marethian standards, but her five inch human pecker is still ramrod straight.“<i>Back off, Cilly, they’re not our enemy.</i>”\n\n");
            outputText("You explain that you’re the reason for the alarm, which gets a bunch of cheers from the former prisoners. The redhead looks you up and down, then saunters back to the woman who’d spoken. “<i>... Okay, Mallah.</i>” Mallah wraps her arms around the redhead, getting a moan and a shiver from her, but they both eye you, thinly disguised lust in their gaze. “<i>But what... what do we do now?</i>”\n\n");
            outputText("“<i>We go to Tel’adre.</i>” A zebra-morph says calmly, his stripes barely noticable. His black fur has gone grey, whether from stress or age, you aren't sure. Unlike the others, he’s somehow managed to get the long, thin claws off his fingers, and he rolls his shoulders, thick slabs of muscle working. “<i>Assuming it’s still there.</i>” You assure the man that the city of the sands still stands, and he gives you a nod. “<i>Well... When we make it there, we’ll need to check in with the city guard. There aren’t that many of us, but... you can’t be too careful about the demons.</i>”\n\n");
            outputText("The few people who have regained themselves mutter agreement, and he sighs. \"We'll need some time to get ourselves in order... but when we have, we'll head out into the ballroom.\" You nod, leaving the former Sexless to gather themselves.\n\n");
            doNext(MainHallSouth);
        } else {
            outputText("The lab that had once held the ghastly “Sexless” project is now a simple room. If it wasn’t for the shackles on the wall, the tables with surgical implements, and the vat of disgusting-looking fluid in the back, it could be just a fancy room. You have to watch your step, as shattered glass covers the floor.\n\n");
            if (SexlessLabState == 3) {
                outputText("Dead bodies, both of Sexless and demons, litter the floor. While some of the sexless were killed by the demons they turned on, most bear claw-marks from their fellows. It seems there wasn’t much left of those... You wince.\n\n");
            }
        }
        dungeons.setDungeonButtons(null, null, MainHallSouth, null);
    }

    public function FSpreaderLab():void {
        clearOutput();
		dungeonLoc = DUNGEON_LAB_FSPREADER;
        if (FSpreaderState == 0) {
            outputText("You open the flame-adorned door, a wave of sudden heat washing over you. You shrug off the increase in temperature, the light from the ballroom behind you giving way to a hot, bubbling red light coursing through the ceiling. You hear a click as you move forward, and you jump back as white-hot fire sears through the place you’d just been.\n\n");
            outputText("You cover your eyes with an arm, but even with your eyes half-closed, you can make out a half-dozen forms standing halfway down the narrow corridor. Another few bodies lie on the floor, but the heat-hazed air prevents you from seeing much further. You can make out blurs of motion, the sound of fire and the roars of combat, clashing steel and fangs. Flames course through the hallway behind them, casting dancing shadows through the corridor and the room beyond.\n\n");
            outputText("“<i>... They’re here.</i>” The smallest form, in the middle, points at you. “<i>Kill the meddler(s). Your younger siblings can finish deleting the... source material.</i>”\n\n");
            if (KihaFollower) {
                outputText("Your dragoness’s skin pales, and she hefts her axe. “<i>Can you deal with those... things?</i>” You nod, and she crouches. “<i>Then get them, love... I need to stop this.</i>” Evidently Kiha can see something in the dancing flames that you can’t. She leaps over the group in front of you, vanishing into the smoke.\n\n");
            }
            outputText("Five crimson-scaled beings stand in front of you, not so different from Kiha, actually. Four are female, D-cup breasts and drooling cunts fully exposed. Small demonic horns jut from their foreheads, and their scaled tails are black and red, with a slight spade at the end. They grin at you, reptilian eyes wide with anticipation as they bob from side to side on taloned feet. In their hands are thin steel spears, and as they eye you, undisguised lust in their eyes, they run their fingers up and down the shafts of their weapons, wings spread wide.\n\n");
            outputText("The final draconic being stands a half-foot taller than the next largest dragonoid, barrel-chested and heavily armoured, wielding a sword over eight feet long, he takes a step towards you. Bull-like horns on the top of his head glint in the firelight, and his scent, like burnt semen, washes over you.\n\n");
            outputText("“<i>Leave it to me, master.</i>” He rumbles. The succubus-dragon things form up around him. It’s a fight!\n\n");
            //Fight the Flamespreader group
            startCombat(new DemonDragonGroup()); //this one,right?
            return;
        }
    }

    public function MainHall3():void {
        dungeonLoc = DUNGEON_LAB_BALLROOM_3;
        clearOutput();
        outputText("This once grand ballroom floor is slathered in cum, blood and various bodily fluids. The stench of old sex hangs in the air. To the east is a single black door, with the same card-swipe mechanism as the other rooms.\n\n");
        dungeons.setDungeonButtons(CheckThePanicDoor, MainHallSouth, null, NightwalkerCheck);
    }

    private function NightwalkerCheck():void {
        clearOutput();
        if (hasKeycard()) {
            outputText("You walk to the door. The blackened steel has a single, stylized bat on it, outlined in red. Inlaid white ‘stains’ surround the symbol, and mushroom-like heads jut out from the frame, pointing at the symbol. As you \n"
                + "\n"
                + "The door slides open, and inside is a spiral staircase, leading up.");
            doNext(NightwalkerLab1);
        } else { //Unreachable, right?
            outputText("You see no way to enter the door. Maybe one of the demons around here has something?");
            doNext(Ballroom3);
        }
    }

    public function NightwalkerLab1():void {
        dungeonLoc = DUNGEON_LAB_NIGHTWALKER_1;
        clearOutput();
        if (NightwalkerLabstate == 0) {
            NightwalkerLabstate = 1;
            outputText("A single demon stands between you and the rough-hewn staircase, a pistol in his hand. His labcoat is torn, the pistol in his hand scratched. He opens his mouth as you approach, fangs dripping blood. \n"
                + "\n"
                + "“<i>You’re too late. The bats have already been unleashed.</i>” He raises his pistol, aiming at you. “<i>All that remains is to give my comrades enough time to save our research.</i>”");
            if (DivaFollower) outputText("\n\n“<i>Thou Art a coward</i>”, Diva growls, baring her own fangs. “<i>Thine bloodstream will suffer the drought of your mistakes!</i>”");
            startCombat(new ScientistGunner());
            return;
        }
        outputText("This room is small, barely lit by a single covered torch in a sconce along the back wall. Unlike the room you just came from, the walls, floor and ceiling are rough-hewn, like some poor saps had been forced to dig this place out with pickaxes.");
        dungeons.setDungeonButtons(null, null, Ballroom3, null);
        addButton(5, "UpStairs", NightwalkerStairs);
        if (flags[kFLAGS.CODEX_ENTRY_NIGHTWALKER] == 0) {
            outputText("\n\nThe room has a single table in the back, where a single, thick book sits.");
            addButton(0, "Book", getNightEntry);
        }

        //====================
        function getNightEntry():void {
            camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_NIGHTWALKER);
            doNext(NightwalkerLab1);
        }
    }

    private function NightwalkerStairs():void {
        clearOutput();
        outputText("You climb the stairs, slowly and carefully making your way up. More than one metal grate blocks your path, but you swipe your keycard, making swift work of the security. Finally, at the top, a single wooden door bars your path. You open it, walking into Project Nightwalker.");
        doNext(NightwalkerLab2);
    }

    public function NightwalkerLab2():void {
        dungeonLoc = DUNGEON_LAB_NIGHTWALKER_2;
        clearOutput();
        outputText("The room is almost completely dark, with only a few candles flickering on the walls. The rough-hewn stone makes the entire place look more like a cave than a lab, but a few details give the place away. ");
        if (NightwalkerLabstate == 1) {
            outputText("A few cell doors swing on rusty hinges, recently opened. Five bodies lie about, all but one a demon in a lab coat. The last body is a deathly pale woman, dried blood all over her face. You walk deeper into the haunted place, your footsteps echoing off the walls.\n\n");
            if (DivaFollower) outputText("“<i>Follow me, mine ally</i>”, Diva whispers, taking the lead. “<i>Mine superior vision doth pierce the darkness of this place.</i>” Reluctantly, you let Diva lead you further in... And your heart suddenly leaps into your chest, as a loud, scrape of rust hits your ears from behind. You spin, and what you see sends a shudder down your spine.");
            else outputText("You take one of the candles, slowly making your way past each cell door. You see a slight bit of light ahead of you, and you push forward... But your [leg] hits a chair, the sharp crack of wood on stone echoing up and down the dark hallway. \n"
                + "\n"
                + "The scraping of rust on stone fills your ears, louder than the chair you’d displaced. You whirl, and what you see makes you shudder.");
            outputText("\n\nA single, naked woman, pale as the moon, stands before you. She laughs, a shrill, hateful sound, and you lunge forward. She’s too quick, backing off into the darkness. \n"
                + "“<i>... They... Let the blood go... </i>” Her voice echoes off the walls, the flap of leathery wings obscuring her even more. “<i>But... You’ll do.</i>” \n"
                + "\n"
                + "You’re now fighting Project Nightwalker!");
            startCombat(new ProjectNightwalker());
        } else {
            outputText("Despite its enormous volume, the metallic stench of blood fills the air, with just a hint of decay underneath. While there are a few cells still closed, most have swung wide open. The wall has sconces on them, and you walk carefully around the room, lighting each torch as you move along. With every torch lit, you turn to the centre of the cavern. \n"
                + "\n"
                + "Dozens of devices line the middle of the cave, clearly intended to keep people trapped. Stocks, tables with shackles bolted in, even a few balls and chains. Strangely, each seems to be connected to a series of tubes, dangling from the ceiling and held up by metal struts. Each pipe trails from a device in the centre of the room... A massive metal tank with several arcane-looking devices on top.");
            dungeons.setDungeonButtons(null, null, null, null);
            addButton(0, "Tank", NightwalkerLabTank);
            addButton(7, "Downstairs", NightwalkerLab1);
        }
    }

    public function TyrantCheck():void {
        clearOutput();
        outputText("This metal door is unlike the one to the east. While it’s got a window, steel bars across the open parts, it’s nearly a foot thick and over fifteen feet tall. The door has the emblem of a... well... It appears to be a spider with dicks instead of legs.\n\n");
        if (hasKeycard()) {
            outputText("You notice a black strip next to the door. The middle of it glows as you approach, and you place your keycard on it. The door swings open, and you walk into a small room, covered floor to ceiling in blackened tile. A single drain sits in the center of the room.\n\n");
            doNext(TyrantLab1);
        } else {
            outputText("The door resists all attempts to open it. You head back to the centre of the Ballroom.\n\n");
            doNext(Mainhall1);
        }
    }

    public function TyrantLab1():void {
        clearOutput();
		dungeonLoc = DUNGEON_LAB_TYRANT_1;
       
            addButton(7, "Downstairs", TyrantPrison);
        }

    public function TyrantPrison():void {
        dungeonLoc = DUNGEON_LAB_TYRANT_PRISON;
        clearOutput();
        outputText("The lab is dark, but there’s periodic red lamps scattered throughout the place. Once your eyes get used to the dark, it’s not too bad, but the shadows are deep, and the sounds of skittering chitin scratching the stone lend the place an air of menace. The room is about half the size of the ballroom above, but much longer, and thinner, with thick pillars embedded into the wall periodically. Black webbing hangs from the ceiling and the walls, making crackling sounds as air flows through the sticky strands.\n\n");
        if (TyrantLabState == 1) {
            outputText("There’s a large, steel door on the far side of the hallway. Light shines through a crack. It’s clearly open, but as you near it, you can hear several voices arguing and yelling. You know instinctively it’s some of the demons who escaped the battle earlier.\n\n");
            outputText("As you get further into the room, you realise that in between the pillars are smaller rooms... no, cages.\n\n");
        }
        if (DridersState == 0) {
            outputText("Whimpers and whispers fill the corridor as some of them catch sight of you. Most shy away, averting their gaze, while others look at you with fear in their eyes. Unlike the Driders in the swamps, these only have one pair of breasts, if female, and they have less demonic proportions. Their chitin is stained, splattered with... well, you know what. This is a demon’s lab, after all. The scent of stale urine, old sex, and barely noticable, cinamon. Most of the Driders here are female, but a few smaller males are among their number.\n\n");
            outputText("Without exception, these people are malnourished, bound to the wall, arms held up above their heads, spider-legs splayed out and thoraxes chained to the hard stone floor. Red and purple eyes stare back at you from within the dark cages... but you can’t feel the slightest bit creeped out by them. They’re of no threat to you... or anyone.\n\n");
        }
        if (TyrantFollower && DridersState == 0) {
            outputText("Your massive companion visibly shudders, shaking with suppressed anger. “<i>I’m going to slaughter them.</i>” Her voice shakes, and your amazoness looks down at you. “<i>No mercy, no surrender, no letting them off after shoving my Dick into them.</i>” You nod.\n\n");
        }
        if (DridersState == 0 && TyrantLabState == 2) {
            outputText("In their cages, the spider-people lie, eyes wide as they follow your every move. Hope, fear, anger, you can feel it all in dozens of gazes.\n\n");
        }
        if (DridersState > 0) {
            outputText("The cage doors, broken and scattered across the room, reflect the light from the scarlet lanterns. Each cage is like an empty hole, a wound yet to heal... You shudder at the reminder of what had happened here. And yet, knowing you were responsible for breaking those chains... It’s enough.\n\n");
        }
        dungeons.setDungeonButtons(TyrantLab2, null, null, null);
        addButton(5, "UpStairs", TyrantLab1);
    }

    public function TyrantLab2():void {
        dungeonLoc = DUNGEON_LAB_TYRANT_2;
        clearOutput();
        outputText("The door slides open without a creak, and you enter into the top of a large, circular room. The top area, where you are, is twenty feet wide, wrapping around a fifty foot circular lab. A wide spiral staircase leads down into the main room.\n\n");
        if (TyrantLabState == 1) {
            outputText("But you immediately notice the cages. Every inch of the outside wall is lined with row after row of cages. Inside each cage is a hulking... You’d be hard pressed to call these things Driders. They’re massive, easily towering over most of Mareth’s residents.\n\n");
            if (TyrantFollower) {
                outputText("Even your massive companion takes a step back at the sight. Some of these creatures are nearly as big as her.\n\n");
            }
            outputText("Layered with muscle, blank eyes glowing and fangs dripping, clad in black steel, their breathing is deep, almost uniformly so. As one sees you, it grabs the bars, shoving its head between them and trying to bite you. Its mountainous shoulders stop it from going further, but it doesn’t give up, mindlessly slavering as it thrashes.\n\n");
            outputText("You tear your gaze from that creature... They’ve made an army of these things. And from the crawling in your [skin], the two horns on their head... each one of these monstrous beings has a corruption aura.\n\n");
            outputText("Three demons stand in the middle of the lab, with a dozen or so more heavily armoured incubi standing nearby. “<i>We need to go.</i>” One of the warriors says simply, his deep voice carrying. “<i>The intruders tore through the security complement. Take the subjects and leave, that’s what we need to do.</i>”\n\n");
            outputText("“<i>What about our research?! I don’t expect a meathead like you to understand what we’ve accomplished here, but I would expect you to understand their value!</i>” A succubus in a lab coat wails, pointing at the warrior. “<i>And we don’t have enough trained riders to-</i>”\n\n");
            outputText("“<i>Then we make do.</i>” A second Incubus chimes in. “<i>Besides... We’re out of time.</i>” The demons look up to see you, and their reaction is immediate. Several of the scientists back up, one pulls a lever on the wall, and a soldier screams into a conical device. “<i>Project Tyrant! Form up!</i>” You back up to the door as the cages all open. A few of the creatures don’t move, but the majority of them follow orders, their blank white eyes focusing on the Incubus’s commands.\n\n");
            outputText("“<i>I’ll handle this.</i>” The largest of the Incubus Warriors steps up, jumping onto a giant Drider’s back. “<i>Get everyone else out of here.</i>”\n\n");
            outputText("The giant Driders rush around you... and flee. They run towards the back of the lab, white eyes blank, following orders. You run towards the lab’s centre, where the creatures are massing, but the scientists are already too far away to attack. One massive creature, a single demon atop it, walks your way, against the mindless flow of corrupted flesh.\n\n");
            outputText("Facing you is a creature vaguely resembling a Drider. Easily seventeen feet tall and thirty feet long, the creature turns to face you, six crimson eyes gleaming. Its naked form is built like a tank, masculine, with no genitals to be seen.\n\n");
            outputText("Twin horns poke through the chitin covering its forehead. It breathes heavily, and as it takes a step, the spikes on its legs clank against the stone floor below. Corruption oozes from this creature in a sickening aura. It holds no weapons, but the massive muscles sloping down the creature’s arms leave little doubt that this creature doesn’t need a weapon to crush its foes.\n\n");
            outputText("On the creature’s back sits a heavily muscled Incubus. His green eyes glare at you, and he shakes his head, pointing a light crossbow at you.\n\n");
            outputText("“<i>Tyrant? Kill!</i>”\n\n");
            outputText("You are now fighting Project Tyrant.\n\n");
            startCombat(new ProjectTyrant());
            return;
        }
        if (TyrantLabState == 2) {
            outputText("The lab that had once contained “<i>Project Tyrant</i>” is now empty and still. Some sort of serum sits abandoned in several different vials around the room, and the entire place reeks of antiseptic and blood. Tables adorned with odd, extremely sharp knives litter the middle of the lab, with massive cuffs on the corners. These devices were clearly made to hold down the people they were experimenting on, and the smell of blood intensifies as you near them.\n\n");
            outputText("On the far side of the room, close to where the demons had fled, you see an ornate desk, made of rare wood and inlaid with gold leaf, thrown to one side. Upon closer inspection, you can see several books, once on the desk, now scattered through the room.\n\n");
            outputText("A massive pile of rubble blocks what had once been a way out.\n\n");
        }
        dungeons.setDungeonButtons(null, TyrantPrison, null, null);
    }

    public function PanicRoom():void {

    }
	
	public function VideoLog():void {
		clearOutput();
		outputText("You open the file, and a video begins to play…Dated just a week or so after you entered this realm.\n\n");
		outputText("A single demon, a grin on his face, fills the screen. “<i>Doctor Hemos’ Log…SHE’s coming here! Finally, I’ll be able to showcase my work!</i>” The camera moves, and is left on a table. As the demon walks backwards, you realise that this room is the white, sterile room at the front of the lab. You watch as the scientists file into view on the other side of the room, and wait. Most are still, sterile, but the demon who’d started the video is bursting with excitement. A moment or so later, the distant flapping of leathery wings sounds.\n\n");
		outputText("“<i>My queen.</i>” A gruff, bullish voice sounds. The door opens, and a massive minotaur enters, facing the line of scientists. “<i>Bow.</i>” The line of demons drop to one knee, and he moves forward, brandishing his axe. The minotaur steps out of frame, and two women enter.\n\n");
		outputText("One is a succubus…Her purple hair is woven with black roses, oversized dragon wings folded against her back. Goat horns curl delicately from her head, and she walks slowly, sensually, on heels of bone. Her breasts, shockingly, are slim. She wears black cloth, cut down to nearly nothing…But her black-rimmed eyes are cold, odd, slitted pupils giving an air of dark intellect.\n\n");
		outputText("“<i>Your Majesty, is there anything in particular you wish to see?</i>” The second woman asks. This one is odd, even by demon standards. She has long, sharp bull horns, a horselike face and a red mane running down her body…A body covered in black and white striped scales. Her hair is red…and appears to be made from thin tendrils. Almost like the anemones from the lake. She turns her head towards the camera, and sticks her forked tongue out. Despite the horse-like shape of her face, she has snake-fangs, but the rest of her teeth are sharp. The back of her throat glows red, and she lets out a puff of smoke.\n\n");
		outputText("Her breasts are C-cups, perky, and held in place by a milking machine repurposed as a bra. She wears a lab coat overtop, unbuttoned. Electricity visibly sparks from her body, and she levitates an inch or so off the ground. Her legs are thin, with a bone spike protruding from her knees, and her legs end in razor-sharp talons. She looks at the camera, and her pupils are…odd. They’re perfect ‘X’s, yellow, with a distinct glow.\n\n");
		outputText("The Chimera has four arms, ending with clawed fingers. One holds an inkpot, and two hold a clipboard in front of her. She dips a single claw into the inkpot, jotting down notes with her remaining hand.\n\n");
		outputText("“<i>No, Lucina. I want to know everything about the projects, and their progress.</i>” Lethice’s voice is firm, but very feminine, and she moves with an air of assured confidence. “<i>We’ve put a lot of effort into these labs of yours.</i>”\n\n");
		outputText("“<i>Of course, my queen.</i>” As Lethice and her two retainers walk past, the quivering demon scientist in the back breaks formation, raising his voice.\n\n");
		outputText("“<i>Queen Lethice! Please, if you would?</i>” He takes two steps towards Lethice, but the massive minotaur turns, hefting his axe.\n\n");
		outputText("“<i>You will speak to the queen when she requests your presence, and not a moment before.</i>” The chimeric woman says. Lethice ignores the disturbance, continuing on into the lab.\n\n");
		outputText("“<i>Doctor Hemos, you will behave yourself.</i>” Another demon says, taking the doctor’s hand and pulling him back in line. “<i>Apologies, Doctor Lucina, for my…colleague's outburst.</i>” He shakes his head. “<i>He’s been working in his own lab for quite some time, and doesn’t know how to interact with others.</i>”\n\n");
		outputText("The odd chimeric woman nods, scribbling down more notes. “<i>Very well…His problematic behaviour has been noted, but we’ll deal with that when we’re off the queen’s clock.</i>” She gives a very direct look to the Incubus who’d started the recording. “<i>Be careful in the future, Doctor Hemos. We wouldn’t want anything to happen to you.</i>” She looks down at the camera, frowning. “And what is this device doing on the table?” She picks it up, and the recording stops.\n\n");
		outputText("Lethice was here, and clearly knew what was happening…But who was that chimaera? Those eyes…You’ve seen their like before.\n\n");
		doNext(PanicRoom);
	}
}

