/**
* ...
* @author Canadian Snas
*/
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.UndergarmentLib;
import classes.Scenes.Areas.Swamp.CorruptedDrider;
import classes.Scenes.NPCs.DriderTown;
import classes.Scenes.NPCs.LilyFollower;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;
import classes.internals.Utils;

public class BelisaFollower extends NPCAwareContent implements TimeAwareInterface, SaveableState
{
	public static var BelisaEncounternum:Number;
	public static var BelisaAffectionMeter:Number;
	public static var BelisaInGame:Boolean;
	public static var BelisaFollowerStage:Number;
	public static var BelisaVirgin:Boolean;
	public static var BelisaShopOpen:Boolean;
	public static var BelisaQuestOn:Boolean;
	public static var BelisaRalthTalked:Boolean;
	public static var BelisaQuestComp:Boolean;
	public static var BelisaConfessed:Boolean;
	public static var BelisaToldTyrantia:Boolean;
	public static var BelisaInCamp:Boolean;
	
	public function stateObjectName():String {
		return "BelisaFollower";
	}
	
	public function resetState():void {
		BelisaEncounternum = 0;
	 	BelisaAffectionMeter = 0;
		BelisaInGame = true;
		BelisaFollowerStage = 0;
		BelisaVirgin = true;
		BelisaShopOpen = false;
		BelisaQuestOn = false;
		BelisaRalthTalked = false;
		BelisaQuestComp = false;
		BelisaConfessed = false;
		BelisaToldTyrantia = false;
		BelisaInCamp = false
	}
	
	public function saveToObject():Object {
		return {
			"BelisaEncounternum": BelisaEncounternum,
			"BelisaAffectionMeter": BelisaAffectionMeter,
			"BelisaInGame": BelisaInGame,
			"BelisaFollowerStage": BelisaFollowerStage,
			"BelisaVirgin": BelisaVirgin,
			"BelisaShopOpen": BelisaShopOpen,
			"BelisaQuestOn": BelisaQuestOn,
			"BelisaRalthTalked":BelisaRalthTalked,
			"BelisaQuestComp": BelisaQuestComp,
			"BelisaConfessed": BelisaConfessed,
			"BelisaToldTyrantia": BelisaToldTyrantia,
			"BelisaInCamp": BelisaInCamp
		};
	}
	
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			BelisaEncounternum = o["BelisaEncounternum"];
			BelisaAffectionMeter = o["BelisaAffectionMeter"];
			BelisaInGame = o["BelisaInGame"];
			BelisaFollowerStage= o["BelisaFollowerStage"];
			BelisaVirgin = o["BelisaVirgin"];
			BelisaShopOpen = o ["BelisaShopOpen"];
			BelisaQuestOn= o["BelisaQuestOn"];
			BelisaRalthTalked= o["BelisaRalthTalked"];
			BelisaQuestComp = o["BelisaQuestComp"];
			BelisaConfessed = o["BelisaConfessed"];
			BelisaToldTyrantia = o["BelisaToldTyrantia"];
			BelisaInCamp = o["BelisaInCamp"];
		} else {
			// loading from old save
			resetState();
		}
	}
	
	public function BelisaFollower()
	{
		Saves.registerSaveableState(this);
	}
	
	public function BelisaAffection(changes:Number = 0):Number {
		BelisaAffectionMeter += changes;
		if (BelisaAffectionMeter > 100) BelisaAffectionMeter = 100;
		if (BelisaAffectionMeter < 0) BelisaAffectionMeter = 0;
		return BelisaAffectionMeter;
	}
	
	public function firstEncounter():void {
		clearOutput();
		outputText("You stride through the swamp. It seems to be quieter than normal. You think you hear the telltale hissing of a Drider, but nothing pops out at you. You check your feet, but there’s no web traps around you. Still, you’re in drider territory, and you put your back to a willow tree, holding your [weapon] ready.\n\n");
		outputText("<i>\"No!\"</i> A curious brown and white blur flits between the trees, followed closely by several familiar, shiny black carapaces. <i>\"Leave me alone!\"</i> The voice is high-pitched and panicked. As it comes closer, you’re able to make more of her out. Like the driders, she has eight spider legs. Hers appear longer, but also much thinner. A pale, white fluid leaks from her ovipositor.\n\n");
		outputText("<i>\"Oh, don’t be like that, precious,\"</i> one of the driders replies, still chasing the brown. Her red eyes glow with sadistic glee. <i>\"We’re just gonna take you home with us. Won’t it be nice?\"</i>\n\n");
		outputText("<i>\"Oh, yes.\"</i> The second drider is more masculine, with a deeper voice and longer stride. <i>\"Stay with us, it will be wonderf-\"</i> He gasps. <i>\"Don’t let her get to the water!\"</i>\n\n");
		outputText("She jumps, almost directly over you. As she flies, you can see most of the way up her robe. Unlike her fellow driders, she seems to be wearing undergarments, and she doesn’t notice you until you’ve seen her underwear. She gasps, face turning red, before she hits the water, folding her lower body up and sinking like a rock into the murky water. The last thing you notice before she sinks below your visual range is her hat, inflated like a balloon. Her legs flail, and she vanishes, apparently swimming away under the water.\n\n");
		outputText("The two driders hiss, their toy lost, but they quickly catch sight of you.\n\n");
		outputText("<i>\"I’ll find her,\"</i> the second one growls, leaving the first. She turns to you with a sadistic grin.\n\n");
		outputText("You are now fighting a Drider!\n\n");
		BelisaEncounternum = 1;
		startCombat(new CorruptedDrider());
	}
		
	public function secondEncounter():void {
		clearOutput();
		outputText("Your row on the lake is peaceful. For once, the water is calming and still. The wind’s no longer blowing, and the sky above is blue. As you gaze around, something catches your eye.\n\n");
		outputText("A bobbing, white orb sits on the surface of the water, out of place against the glassy surface. It shines, shedding droplets of water. It also appears to be slowly inflating, starting from the size of your boat and expanding outwards. Do you approach?\n\n");
 		menu();
		addButton(1, "Yes", secondEncounterApproach);
		addButton(2, "No", secondEncounterNo);
		addButton(3, "Never", secondEncounterNever);
 	}
	
	public function secondEncounterApproach():void {
		clearOutput();
		outputText("You row closer to the odd orb, your curiosity overcoming your caution. On closer inspection, you realize you’ve seen this material before. This structure appears to be made entirely out of spider silk!\n\n");
		outputText("It’s still getting bigger, and as you stare, the structure inflates into the front of your boat, nudging it backwards.\n\n");
		outputText("<i>\"Eep!\"</i> comes a muffled voice from inside the object. You hear a clattering noise from inside, like someone climbing a ladder. The object shudders, and a humanoid figure pokes out from the top. You can only see her upper body, and the silk she wears blends in with the orb. Her brown eyes stare down at you, wide.\n\n");
		outputText("<i>\"What do you want?\"</i> She demands, her voice high and wavering. <i>\"Wh-what are you doing here?\"</i> Despite her demands, her arms shake. She has a dagger in her hand, and it’s pointed straight at you, but the hand holding it shakes.\n\n");
		BelisaEncounternum = 2;
		menu();
		addButton(1, "Demons", secondEncounterYesDemons);
 		addButton(2, "Curiosity", secondEncounterYesCuriosity);
 		addButton(3, "Fishing", secondEncounterYesFishing);
		addButton(4, "NoWorries", secondEncounterYesNoWorries);
	}
	
	public function secondEncounterYesDemons():void {
		outputText("You puff out your chest, exclaiming that you are the champion of Ignam, and you were sent to rid the world of demons and corruption. At your exclamation, her brown eyes narrow.\n\n");
		outputText("<i>\"...Many have tried, ‘champion’.\"</i> She picks at the left side of her mouth, then catches you looking, hiding her face behind her oversized hat. <i>\"If you’re looking for demons, you won’t find any here, so just go away please.\"</i>\n\n");
		menu();
		addButton(1, "Leave", secondEncounterLeaveAlone);
		addButton(2, "Nah", secondEncounterNahFight);
	}
	
	public function secondEncounterYesCuriosity():void {
		outputText("You tell the girl that you just wanted to know what this giant ball in the lake was. She sighs. <i>\"I made this. It’s my home.\"</i> She pouts a little, crossing her arms. <i>\"Now can you please let me be?\"</i>\n\n");
		menu();
		addButton(1, "Leave", secondEncounterLeaveAlone);
		addButton(2, "Nah", secondEncounterNahFight);
	}
	
	public function secondEncounterYesFishing():void {
		outputText("You tell her that you were just out on the lake to catch some fish. At this, she sighs. The sphere wriggles, and a dead fish, head pierced with some kind of needle, is thrown into your boat. <i>\"There, you have a fish.\"</i> Her voice quivers, and she points towards the shore. <i>\"Now please... just leave me alone.\"</i>\n\n");
		inventory.takeItem(consumables.FREFISH, secondEncounterYesFishing2);
	}
	private function secondEncounterYesFishing2():void {
		outputText("\n\n");
		menu();
		addButton(1, "Leave", secondEncounterLeaveAlone);
		addButton(2, "Nah", secondEncounterNahFight);
	}
	
	public function secondEncounterYesNoWorries():void {
		outputText("You raise your hands, trying to assure her that you mean no harm. Her six eyes soften a little, but she points at the shore, lips quivering. <i>\"Look...Just…\"</i> She inhales shakily. <i>\"Just leave me, please. I don’t know who you are.\"</i>\n\n");
		menu();
		addButton(1, "Leave", secondEncounterLeaveAlone);
		addButton(2, "Nah", secondEncounterNahFight);
	}
	
	public function secondEncounterLeaveAlone():void {
		outputText("You apologize for startling her, and turn your boat around. You blink, realizing you didn’t even get her name. You turn back and ask loudly what the Drider’s name is. As you row away, you can see the white orb sinking beneath the water’s surface. <i>\"Belisa\",</i> you hear on the breeze. You see her eyes, and the ripple on the water as The Drider-No, <i>Belisa,</i> slips underneath the surface of the water, following her home down.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	
	public function secondEncounterNahFight():void {
		outputText("You grin at her, asking what the rush is. Surely just hanging around isn’t such a big deal, right? You barely finish your sentence before a dagger flashes by your face. Eyes wide, she emerges from her silky home. She’s shaking, but as she comes out revealing her Drider bottom half, complete with eight thin, chitin-covered legs legs and a slender, web-slinging thorax, the daggers in her hands are rock-steady, her lips drawn into a frown.  <i>\"The Name’s B-Belisa. I don’t want to fight you…But you need to leave me alone!\"</i>\n\n");
		startCombat(new Belisa());
	}
	
	public function postFightOptionsWhitefireWait():void {
		clearOutput();
		outputText("\"<i>Wait...You’re...Pure. I…</i>\" She looks at you awkwardly, wringing her hands. \"<i>Uh...Sorry?</i>\"  Her cheeks flush, and she turns her head to face somewhere else. You lower your [weapon], as she appears to be no further threat. You ask her why she attacked you, and she looks back at you, her cheeks bright red. ");
		outputText("\"<i>W-well, I...It’s a dangerous world, and you wouldn’t leave me alone!</i>\" She puffs out her cheeks. \"<i>When a girl asks you to leave her home, generally you leave!</i>\" You ask her if this is her home, and she closes her eyes, breathing deeply. \"<i>Well, where else would I live?</i>\"\n\n");
		BelisaEncounternum = 4;
		cleanupAfterCombat();
	}
	
	public function secondEncounterNo():void {
		clearOutput();
		outputText("After a few sidelong glances, you row away from the odd object, shrugging to yourself. This boat trip wasn’t productive, but oddities aren’t entirely unwelcome.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	
	public function secondEncounterNever():void {
		clearOutput();
		outputText("You’ve experienced enough of Mareth to leave curious objects alone. You vow to give this object a wide berth in the future.\n\n");
		BelisaInGame = false;
		doNext(camp.returnToCampUseOneHour);
	}
	
	public function subsequentEncounters():void {
		clearOutput();
		outputText("You’re walking along the lake shore, and a glimmer of white on the water’s surface catches your eye. You quickly realize that it’s Belisa’s silk orb. You walk over to the water’s edge, trying to catch a glimpse of the odd little Drider girl.\n\n");
		outputText(" The angle of the water makes it awkward, but you’re able to catch a glimpse of her on the bottom of the lake. Catching hold of a small rock, you toss it into the water, watching as it sinks.\n\n");
		outputText("The rock taps Belisa’s shoulder, and the drider-woman flinches, sending bubbles up to the surface of the water. She looks up, seeing you on the shore, and she nods.\n\n");
		if (BelisaAffectionMeter < 40) {
			outputText("<i>\"H-Hello?\"</i> She sees you, and swims slowly to the surface, poking her head up nervously. <i>\"Wh-what do you want?\"</i>");
			BelisaAffection(5);
		}
		if (BelisaAffectionMeter >= 10 && BelisaAffectionMeter > 20) { 
		outputText(" The Drider-girl looks up from the bottom of the lake, then swims up to the surface. She stays mostly underwater, but her shoulders are above the lake this time."); 
		}
		else if (BelisaAffectionMeter >= 20 && BelisaAffectionMeter > 30) {
		outputText(" Belisa, kicks off, ascending quickly to the surface of the water. She seems less nervous around you, and she steps onto the beach, shaking the water out of her hair. Her silken house bobs to the surface, but she doesn't seem to mind. <i>\"So, what brings you here, [name]?\"</i>");
		}
		else if (BelisaAffectionMeter >= 30 && BelisaAffectionMeter > 40) { 
		outputText(" Upon seeing you, Belisa's eyes widen slightly, and you can see her spider legs quicken. She smiles up at you, waving with one hand before she kicks off. She breaches the surface with a slight splash, and she quickly walks towards you. <i>\"Oh, hey!\"</i> She walks up to you, still hiding half her face, but the eyes you can see seem bright. <i>\"What brings you to my home?\"</i>");
		}
		else if (BelisaAffectionMeter >= 40 && BelisaAffectionMeter > 50) {
		outputText("She doesn't even look up as the rock taps her shoulder. Belisa rises from the water as quickly as she can, bringing her silken home with her to the surface, then practically runs over to where you stand. Eyes widening, she yelps, digging her front four legs into the sand. She barely skids herself to a stop around ten feet or so away. Her back legs are tapping, and the side of her face you can see is practically beaming already, her perky C-cup breasts dripping wet from the lake . It seems Belisa really missed you. She tilts her pale-skinned head to one side, questioning, but willing to wait for you to make the first move.");
		}
		if (BelisaAffectionMeter < 30 && !BelisaShopOpen) {
			outputText("\n\nBelisa turns her back on you, holding out a finger. You wait for a few moments as she opens a curtainlike opening on her silky bubble-home, and she comes back with a few small boxes. <i>\"I haven't found anyone I can trust in a while.\"</i> she explains. <i>\"But you...seem like a decent person. You may not know what a manaweaver is...But the long and short of it is that I can make some enchanted items with my silk.\"</i> She blushes slightly, continuing in a chipper voice. <i>\"I think, since you're out here as well, you could use my work as well. I can't just give these to you...But I would take gems for them.\"</i>\n\n");
			BelisaShopOpen = true;
		}
		menu();
		addButton(0, "Appearance", BelisaAppearance);
		addButton(1, "Talk", BelisaTalk);
		addButton(2, "Hang", BelisaHang);
		if (BelisaShopOpen) addButton(3, "Shop", BelisaShop);
		addButton(4, "Sex", BelisaSex);
	}
	
	public function Encounterback():void {
		clearOutput();
		outputText("<i>\"Well, what is it you want then?\"</i>\n\n");
		menu();
		addButton(0, "Appearance", BelisaAppearance);
		addButton(1, "Talk", BelisaTalk);
		addButton(2, "Hang", BelisaHang);
		if (BelisaShopOpen) addButton(3, "Shop", BelisaShop);
		addButton(4, "Sex", BelisaSex);
	}
	
	public function BelisaTalk():void {
		clearOutput();
		outputText("<i>\"You...Just want to...talk?\"</i> She looks at you, confused, as if the thought hadn’t even occurred to her. <i>\"You...Don’t want to…?\"</i> She rolls her eyes, making a ‘jerk-off’ motion with one hand. You tell her that you have no intention of approaching her sexually right now, and she relaxes a little, smiling. <i>\"Okay then...What do you want to talk about?\"</i>\n\n");
		menu();
		addButton(1, "Yourself", BelisaTalkYou);
		if (BelisaAffectionMeter >= 15) addButton(2, "Home", BelisaTalkHome);
		else addButtonDisabled(2, "???", "Req. 15+ affection.");
		addButton(3, "Her", BelisaTalkHer);
		if (BelisaAffectionMeter >= 50 && !BelisaQuestComp) addButton(6, "Injuries", BelisaTalkInjuries);
		else if (BelisaQuestComp) addButtonDisabled(6, "Injuries", "You've already solved her tooth problem!");
		else  addButtonDisabled(6, "???", "Req. 50+ affection.");
		if (!BelisaInCamp && BelisaQuestComp && BelisaAffectionMeter >= 80 && player.statusEffectv1(StatusEffects.TelAdre) >= 1 && flags[kFLAGS.HEXINDAO_UNLOCKED] >= 1 && player.hasStatusEffect(StatusEffects.MetWhitney) && player.statusEffectv1(StatusEffects.MetWhitney) > 1) addButton(7, "ComeW/Me", BelisaComeCamp);
		else if (BelisaInCamp) addButtonDisabled(7,"ComeW/Me", "She's already at your camp!");
		else addButtonDisabled(7, "???", "Req. 80+ affection, healing her tooth injury and finding: Farm, Tel'Adre, He'Xin'Dao.");
		if (BelisaInCamp && BelisaConfessed && BelisaAffectionMeter >= 80) {
			if (flags[kFLAGS.SLEEP_WITH] != "Belisa") addButton(12, "Sleep With", BelisaSleepToggle);
			else addButton(12, "Sleep Alone", BelisaSleepToggle);
		}
		if (BelisaInCamp) addButton(14, "Back", BelisaMainCampMenu);
		else addButton(14, "Back", Encounterback);
	}
	
	public function BelisaTalkYou():void {
		clearOutput();
		outputText("<i>\"Oh? You want to talk about yourself?\"</i> Belisa brings a hand to her mouth, a smirk on her face. <i>\"How very arrogant.\"</i> You raise one eyebrow, and she chuckles, the smirk fading from her face. <i>\"I’m kidding, [name]. I’d love to hear about your adventures.\"</i> You talk about the various demons you’ve faced, Zetaz and the portal, and even some stories from your childhood in Ignam. Belisa is a great listener. She laughs when you tell a joke, or when the story turns serious, asks questions, and listens with rapt attention when you talk about the other people you’ve met along your travels.\n\n");
		if (TyrantiaFollower.TyrantiaFollowerStage > 0 && !TyrantiaFollower.TyraniaIsRemovedFromThewGame && !BelisaToldTyrantia) {
			outputText("You talk about the battlefield, and about a giant Drider you met there. Belisa leans forward, her eyes wide. <i>\"Wait...You said a giant Drider? Was she corrupted?\"</i> You tell her, reluctantly, that yes, the Drider giantess oozes corruption from her very being. Despite this, she seemed to be a decent person, and never tried anything with you. This gets Belisa’s interest, and she looks down. <i>\"...What is her name, did you get it?\"</i>\n\n");
			menu();
			addButton(1, "Yes", BelisaTalkAbsisters);
			addButton(2, "No", BelisaTalkYouEnd);
		}
		else {
			outputText("After some time talking with your Drider friend, you excuse yourself. You still need to keep watch over the portal. Belisa gives you an odd smile, smoothing her robe as she stands. \"<i>Come back when you have some more stories, Champion.</i>\"\n\n");
			if (BelisaInCamp) {
				eachMinuteCount(15);
				doNext(BelisaTalk);
			}
			else doNext(camp.returnToCampUseOneHour);
		}
	}
	public function BelisaTalkAbsisters(): void {
		outputText("You tell her Tyrantia’s name, and the youthful Drider in front of you freezes in place, her human eyes wide and her arms frozen in midair. <i>\"Did...Did you say...Tyrantia?\"</i> She looks on the verge of tears, and you instinctively put a hand on the desolate spider-girl’s shoulder.\n\n"); 
		outputText("<i>\"...I didn’t tell you, [name], but...I have...had two pod-mates. Most races refer to them as ‘siblings’. In my case, I had two sisters. One named Lily...and the other…\"</i> She looks at you with tears in her eyes. <i>\"Her name’s Tyrantia. Both my sisters were captured by demons...and you’re telling me that she’s alive?\"</i> You nod, and she jumps at you, hugging your upper body with surprising strength.\n\n"); 
		outputText("<i>\"...Thank you, [name]. If she’s as corrupt as you say...then perhaps it’s best I keep my distance for now...But knowing she’s alive brings joy to my heart. Thank you.\"</i> You excuse yourself, extracting yourself from Belisa’s embrace and heading back to camp. You can feel her eyes on your back as you walk away.\n\n"); 
		BelisaToldTyrantia = true;
		BelisaAffection(10);
		doNext(camp.returnToCampUseOneHour);
	}
	public function BelisaTalkYouEnd():void {
		clearOutput();
		outputText("You tell Belisa that you didn’t catch her name, and that her speed, strength and corruption makes her a dangerous foe, even for you. She nods in understanding, but there’s a clear look of disappointment on her face. <i>\"Thank you for sharing your experiences with me.\"</i> You politely excuse yourself, heading back to camp.\n\n");
		BelisaAffection(5);
		doNext(camp.returnToCampUseOneHour);
	}
	
	public function BelisaTalkHome():void {
		clearOutput();
		outputText("<i>\"...Well, I lived in a Drider colony not far from the deepwoods.\"</i> Belisa begins, fidgeting with her needles. She begins to work on another robe. <i>\"Mother was grooming me to be our town’s manaweaver...but then the demons came.\"</i> She looks at you, and you give her an odd look. <i>\"Oh...You meant...My house?\"</i> Her face brightens a bit. <i>\"Well...Before they came, Driders could come in different types. The type of the parents didn’t really matter, but certain spider-types are better at certain things than others.\"</i> She realizes she’s gotten off track, and blushes, looking down at her weaving.\n\n");
		outputText("<i>\"Aaaaaanyways, my silk’s slightly different from most Drider’s. It’s lighter, stronger, and when submerged in water, it can do some really cool things. Momma Oaklee taught me how to keep it waterproof while weaving, and how to do other things with it. So, when I needed a safe place to hide...I made one underwater!\"</i>\n\n");
		BelisaAffection(5);
		if (BelisaInCamp) {
			eachMinuteCount(15);
			doNext(BelisaTalk);
		}
		else doNext(camp.returnToCampUseOneHour);
	}
	
	public function BelisaTalkHer():void {
		clearOutput();
		outputText("<i>\"You want to learn about...Me?\"</i> Her back legs skitter about, and she seems to have trouble meeting your gaze. <i>\"That depends...What do you want to know?\"</i>\n\n");
		menu();
		addButton(0, "NoHerm?", BelisaTalkHerNoherm);
		addButton(1, "WhySkittish", BelisaTalkHerSkittish);
		if (BelisaAffectionMeter >= 50 && !BelisaQuestComp) addButton(2, "Injuries", BelisaTalkInjuries);
		else if (BelisaQuestComp) addButtonDisabled(2, "Injuries", "You've already solved her tooth problem!");
		else addButtonDisabled(2, "???", "Req. 50+ affection.");
		if (BelisaAffectionMeter >= 50) addButton(3, "Family", BelisaTalkHerFamily);
		else addButtonDisabled(3, "???", "Req. 50+ affection.");
		addButton(4, "Back", BelisaTalk);
	}
	public function BelisaTalkHerFamily():void {
		clearOutput();
		outputText("Her eyes narrow, and Belisa looks away from you. <i>\"...If you’re asking about my family before the demons came...that’s a subject I’ve been avoiding for some time.\"</i> She sighs. \"<i>I suppose I can tell you. It’s not like you can do much with the information anyways.</i>\" Belisa rests her spider-half on the ground, looking down at the dirt in front of her.\n\n");
		outputText("\"<i>I had two pod-mates. Most races of Mareth refer to them as ‘Siblings’, or ‘Sisters’.</i>\" She fidgets nervously. \"<i>When the demons first started to conquer, my tribe stayed neutral. Our elders assumed that, like many other conflicts, this was just other races being stupid. They thought that our people staying out of the conflict was the best chance we had…</i>\" She shivers.\n\n");
		outputText("\"<i>They were wrong. The demons, once they’d hit our closest trading partners, immediately attacked our village. They came from all sides, releasing thick mists and magics designed to ensnare us, to turn our own bodies against us…</i>\" She hugs herself. ");
		outputText("\"<i>Lily, our huntress, the middle of my podmates, she and Tyrantia, the largest of us…Our fiercest warrior…They carved a path through them. They made a gap in their ranks, and…A few of us escaped. We scattered, leading them away…But when I got to the place we were supposed to meet up…I was the only one.</i>\"\n\n");
		outputText("Belisa looks up at you, sighing. \"<i>Thank you for listening…It’s not something I like to revisit…But sometimes I don’t really have a choice.</i>\"\n\n");
		BelisaAffection(5);
		if (LilyFollower.LilyTalked > 0) {
			outputText("Lily…You recognize that name! A drider named Lily, an archer and huntress? She fits the description perfectly! Do you tell her about your discovery?\n\n");
			menu();
			addButton(1, "Don't", BelisaTalkHerFamilyDont).hint("Don’t tell her");
			addButton(3, "Do", BelisaTalkHerFamilyDo).hint("Tell her");
		}
		else {
			eachMinuteCount(15);
			doNext(BelisaTalk);
		}
	}
	public function BelisaTalkHerFamilyDo():void {
		outputText("You clear your throat, and you look Belisa in the eyes. Seeing your seriousness, Belisa looks down and away as you tell her about Lily. \"<i>...If what you say is true…Then my sister is alive!</i>\" She stands. \"<i>If you can convince her to join you…Maybe…</i>\" She looks at you, hope in her eyes. \"<i>I hope to see her someday.</i>\"\n\n");
		BelisaAffection(10);
		eachMinuteCount(15);
		doNext(BelisaTalk);
	}
	public function BelisaTalkHerFamilyDont():void {
		outputText("You put a hand on Belisa’s shoulder, saying that you can change the topic if she wants. Belisa nods. \"<i>Something lighter, perhaps?</i>\"\n\n");
		eachMinuteCount(15);
		doNext(BelisaTalk);
	}
	public function BelisaTalkHerNoherm():void {
		clearOutput();
		outputText("She gives you a level glare. <i>\"No, I’m not a herm. Herms weren’t even a thing really until the demons...came…\"</i> She looks down at the water. <i>\"...I’m sorry, but can you leave please? It’s a touchy subject, and I…\"</i>\n\n");
		menu();
		addButton(1, "Comfort", BelisaTalkHerNohermComfort);
		addButton(2, "Leave", BelisaTalkHerNohermLeave);
	}
	public function BelisaTalkHerNohermComfort():void {
		clearOutput();
		if (BelisaAffectionMeter < 15) {
			outputText("She pushes you back, now a bit more annoyed than before. <i>\"Look...I’m trying to be nice, but you brought up a touchy subject. So please, before I lose...My composure…\"</i> You turn and walk away, but you hear her crying as you leave, little <i>\"Tk-tk-tk\"</i> noises occasionally coming with the sobs.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		else {
			outputText("You wrap your arms all the way around Belisa’s upper body, and she leans into you slightly. She returns the embrace for a second. <i>\"Sorry about that.\"</i> She wipes the tears from her face. <i>\"It’s been a while, but...Sometimes they still make me sad, just talking about those disgusting things that used to be my people.\"</i> She gently pulls back from your embrace. <i>\"Can we talk about something else?\"</i>\n\n");
			doNext(BelisaTalk);
		}
	}
	public function BelisaTalkHerNohermLeave():void {
		clearOutput();
		outputText("You apologize to the Drider-girl, and she nods, acknowledging your apology. You turn and walk away, but you hear her crying as you leave, little <i>\"Tk-tk-tk\"</i> noises occasionally coming with the sobs.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	public function BelisaTalkHerSkittish():void {
		clearOutput();
		outputText("You ask your Drider friend why she’s so nervous around people, which gets you a tilted head, and a six-eyed eyeroll that lasts a few seconds before Belisa decides to respond.\n\n"); 
		outputText("<i>“Well, I’m sure that the always-present demon hordes have nothing to do with that,”</i> Belisa responds sarcastically. <i>“Or the constant deluge of corrupt filth they seem to spread wherever they go.”</i> She pauses in mock-thought. <i>“Could it be that every single Drider I’ve met since they came seems to have a penis, tits bigger than my head, and a seemingly infinite desire to tie me down and rape me? No, that couldn’t be it, could it?”</i>\n\n");
		outputText("You almost laugh at the dripping sarcasm, raising your hands and telling her that you get the point.\n\n");
		outputText("<i>“I mean…Really, [name]. My best defense is people like that not knowing where I am…so it’s kind of obvious…Right?”</i> You sigh, telling her that she’s made her point. <i>“Look…If I’ve learned anything on my own out here, it’s that I can’t really trust that the normal-looking person I see in the distance won’t try and turn me into some kind of fuck-toy…No matter how lonely that really is.”</i>\n\n");
		outputText("It seems you’ve touched a nerve. You apologize for your words, and Belisa smirks a little, putting a hand over your mouth. <i>“It’s okay, [name]. Honestly, it was a little funny.”</i>\n\n");
		outputText("You head back to camp, a little embarrassed about that rather boneheaded question.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	public function BelisaTalkInjuries():void {
		clearOutput();
		if (BelisaFollowerStage == 1) {
			outputText("You sit down on a nearby log, asking your Drider friend if she remembers the promise you made. She sighs, shaking her head, her back four legs twitching nervously. \"<i>If you couldn’t find anything…Then It’s alright.</i>\" Belisa says sadly. \"<i>It hurts, but it’s not like I haven’t had the time to-</i>\" You stand, taking her soft cheeks in your palms, and you tell her to stop that moping. Starting with the good news, you tell Belisa that you have a mixture that may cure her of the curse, and heal her tooth.\n\n");
			outputText("Belisa’s warm eyes light up, and she forgets to hide her face, letting you see the injury. Then she winces, covering back up, diverting her gaze. \"<i>May?</i>\" You tell her that the alchemist you spoke to told you how a stronger succubus may have thought of this form of removal. You tell her that the treatment also…won’t be pleasant. The wound needs to be covered in the solution for a while, and it will hurt.\n\n");
			outputText("\"<i>Whatever it takes, it’ll be worth it.</i>\" Belisa’s eyes shine with determination. She looks back at her spinnerets, and she leans back, taking a few strands and weaving them tightly. Her hands glow, and Belisa squints as the silk begins to take shape. You ask what she’s doing, and Belisa shakes her head.\n\n");
			outputText("A few minutes later, she looks up. \"<i>Sorry, but I had an idea.</i>\" She holds out an odd silk contraption. \"<i>You said the mixture needed time, right? So I made a catch for it. Since the curse is on my upper teeth, we can store the mixture in my silk, put that on, then you tie it off, leaving the solution time to work.</i>\" You admit, you’re impressed. It’s a rather ingenious way to deliver the mixture. \"<i>No matter what, we’re doing this…I want you to promise me.</i>\" You nod.\n\n");
			outputText("Belisa and you get to work. You pour the silvery-red mixture into her silken device, and Belisa steels herself, gulping audibly as you move around, taking the two silk threads and ready to tie them off. She takes a deep breath, bringing the silk and potion to her injured teeth. Even before you can tie the strands off, Belisa bucks, nearly headbutting you as she instinctively tries to shake the silky skein off.\n\n");
			outputText("\"<i>MMPH!</i>\" She can’t talk through the mask, but as you finish tying it off, Belisa’s muffled cries are already starting. You rush around to her front, taking her hands in yours. She looks at you, trying to pull away, but you hold firm, pulling her in. You trap her head against your [chest], gently shushing Belisa. She calms down, her wails giving way to muffled moans of pain as small wisps of smoke rise from her mouth. ");
			outputText("Unsure what to expect, you assume that it’s part of the curse leaving, keeping your hold on Belisa’s tender jaw. You guide her down to the ground, and she follows, trying (and failing) not to cry, her tears slowly sliding down both cheeks. Unable to do anything to ease her suffering, you cradle her head in your arms, making sure she knows that you’re there.\n\n");
			outputText("An hour passes, and your Drider’s nearly passed out, eyes glazed over and jaw slightly swollen. The smoke coming from her jaw has slowed, barely visible in the daylight, but it’s still coming out with each exhale. Now that she isn’t struggling, you feel yourself starting to slip, eyes closing when you’re not focused. You lean against the wall, still cradling her head, and…\n\n");
			outputText("You wake up, a silvery liquid dripping onto your [legs]. You sit bolt upright, and as you do, Belisa opens her eyes. Immediately, her eyes widen, and she leans away from you, spitting Ralthazul’s mixture onto her floor with muffled sounds of absolute disgust. Shaken into action, you take the silken strands wrapping around her head, breaking them with one swift movement of your hands. Belisa dry-heaves, then sticks her head outside, the sounds of retching obvious in your ears. You hear a slight <i>splash</i>, and she comes back inside, without the silken mask.\n\n");
			outputText("\"<i>Good Gods, that was disgusting.</i>\" Belisa complains, her voice pained. \"<i>Like…teeth and cherries, blended in the jaws of a sharkgirl, swallowed, then passed through a still.</i>\" You laugh, telling Belisa that she has no idea how close she just came to what it was. This gets you a nauseous face from Belisa…and you gasp, a smile growing on your face. \"<i>What?</i>\" Belisa asks, then blinks, remembering why she’d put that disgusting mixture in her mouth to begin with. \"<i>Oh, RIGHT!</i>\" She runs outside, and you follow her as she leans over the lake, examining her face in the glassy surface.\n\n");
			outputText("\"<i>You…Did it…</i>\" Belisa touches her once-injured tooth with one finger, then opens her mouth further, running a finger along each of her teeth. \"<i>[name]…</i>\" She lets out a gleeful cheer, running at you full speed. She bowls you over by accident, and you both fall, her humanoid upper body landing on top of you, her face inches apart from yours.\n\n");
			outputText("\"<i>I…I…</i>\" Belisa blushes, scrabbling to get off you. \"<i>I’m so sorry! I just…I got so excited! I…really…!</i>\" She hides her face behind her sunhat, and you chuckle, standing back up. You tell Belisa that it’s okay. You understand her being excited…but…You take the brim of her sunhat, gently lifting it off her head. Belisa blushes, but as you put a hand on her chin, she lets you guide her chin, turning it back towards you.\n\n");
			outputText("You tell Belisa that she doesn’t need to hide her pretty face anymore. This gets more of a blush, but she seems to take this to heart. You stay with her for a little while longer, but eventually excuse yourself. You tell Belisa that you need to head back to camp. She seems a little saddened, but she nods. \"<i>I will never forget what you’ve done for me today. Never.</i>\" Belisa waves as you leave. \"<i>Stay safe!</i>\"\n\n");
			BelisaFollowerStage = 2;
			BelisaQuestComp = true;
			doNext(camp.returnToCampUseOneHour);
		}
		else {
			outputText("You ask her about her other fang, and why she hides it from you. Belisa instinctively turns away, but you continue talking. You tell her that  it doesn’t make her any less of a person. That you care about her, and want to see if you can help. Slowly, surely, Belisa turns around, facing towards you. She slowly pulls back her lip to reveal the right side of her mouth. Several teeth are broken, cracks along the enamel, but worst of all is the fang. She’s hidden it under a layer of silk bandages, but as she pulls it back, you can’t help but wince. ");
			outputText("Belisa’s fang is all but torn out of her mouth, and poison that would normally go into the tooth is instead dripping. Belisa dabs at the wound with her silk bandage, but as you get closer, she turns away, quickly replacing the bandage and turning back to you as if nothing’s wrong.\n\n");
			menu();
			addButton(1, "Comfort", BelisaTalkInjuriesComfort);
			addButton(2, "Heal", BelisaTalkInjuriesHeal);
			addButton(3, "Ew", BelisaTalkInjuriesEw);
		}
	}
	
	public function BelisaTalkInjuriesComfort():void {
		clearOutput();
		outputText("You tell her that you had no idea how bad it was. <i>\"Yeah, I know. That was kind of the point.\"</i> She sighs. <i>\"But now you know…\"</i>\n\n"); 
		outputText("You ask her what happened, how she’d managed to injure herself so badly. <i>\"Demons\"</i>, she spits. <i>\"Demons thought it would be funny to make the little Drider bite metal, then stomp on her jaw.\"</i> She closes her eyes. <i>\"And now...I can’t even bite my food properly.\"</i>\n\n"); 
		outputText("You put a hand on her shoulder and pull her into you. You tell Belisa that even though she has trouble with food, she should never worry about finding the good, even now. You tell her about her accomplishments, and how tough she is, living on her own in these times. Your words put a small smile on the little Drider’s face, but she turns away. You excuse yourself and walk back to camp, but at the back of your mind, a question rises. Could you help her?\n\n"); 
		BelisaAffection(5);
		doNext(camp.returnToCampUseOneHour);
	}
	public function BelisaTalkInjuriesHeal():void {
		clearOutput();
		outputText("You put your hands on Belisa’s cheeks. You pinch them slightly, smooshing her soft cheeks, and you tell Belisa that if it matters that much to her, you’ll help. She begins to tear up, her lips quivering, and you lean in, resting your forehead against hers. You tell her that you can’t promise anything, but that you know some people who may be able to help. You ask her what happened, and she whimpers, barely moving her mouth as she buries her face into your [breasts].\n\n");
		outputText("<i>\"Demons...They attacked my village\"</i>, she whispers this, her arms wrapped tightly around your torso. <i>\"They took my sisters, corrupted my people...I ran, like my sisters told me to, but...some of them found me. They caught me, took my head and…\"</i> She begins to cry. <i>\"They took a sheet of metal, made me bite down on it, then threw my face into a stone!\"</i> She nuzzles your shoulder, trying to wipe her tears away. <i>\"I got them with some whitefire...but…There was a succubus with them. She cursed me, took my mouth in her hands and made sure it wouldn’t heal.\"</i>\n\n");
		outputText("You take her cheeks in your hands, looking into the drider’s eyes. You promise her that you’ll do what you can to make her smile whole again. <i>\"Okay...I’ll be waiting here for you.\"</i>\n\n");
		outputText("You think to yourself, who could help you figure this out?\n\n");
		outputText("The old alchemist is an obvious choice.\n\n");
		if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) outputText("Ayane can heal curses. She'd be more than willing to help if she could.\n\n");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 6 && !player.hasStatusEffect(StatusEffects.DianaOff)) outputText("Diana should be able to heal such a curse. You make a note to ask her.\n\n");
		BelisaAffection(5);
		BelisaQuestOn = true;
		doNext(camp.returnToCampUseOneHour);
	}
	public function BelisaTalkInjuriesEw():void {
		clearOutput();
		outputText("You say nothing, but turn away quickly. Belisa closes her mouth, nervous. <i>\"I-i’m sorry.\"</i> She sounds crestfallen at your reaction. You make small talk, then leave, but Belisa seems very saddened by your reaction.\n\n");
		BelisaAffection(-20);
		doNext(camp.returnToCampUseOneHour);
	}
	
	public function BelisaSleepToggle():void {
		//spriteSelect(SpriteDb.s_electra);
		clearOutput();
		if(flags[kFLAGS.SLEEP_WITH] != "Belisa") {
			outputText("You ask Belisa if there’s room on her hammock for you. She looks at you, slowly realizing what you’re asking.\n\n");
			outputText("\"<i>You want to sleep with me? Like...Overnight? Not just sex, but...</i>\" You nod, and Belisa grins from ear to ear. \"<i>Of course there is, [name]. I’d love to have you with me.</i>\"\n\n");
			flags[kFLAGS.SLEEP_WITH] = "Belisa";
		}
		else {
			outputText("You tell Belisa that you feel like sleeping on your own tonight. She winces a little, but nods.\n\n");
			flags[kFLAGS.SLEEP_WITH] = "";
		}
		menu();
		addButton(0,"Next", BelisaTalk);
	}
	private function sleepWith(arg:String = ""):void {
		flags[kFLAGS.SLEEP_WITH] = arg;
	}
	
	public function BelisaHang():void {
		clearOutput();
		if (BelisaAffectionMeter < 20) {
			outputText("<i>\"You...\"</i> The Drider sinks back under the water, leaving nothing but her mouth, looking up at you, above the surface. <i>\"No. I don't think that's a good idea.\"</i> She points away, back where you came from. <i>\"Please leave me alone now\"</i>\n\n");
			outputText("Not wanting to aggravate the odd, aquatic Drider any further, you take your leave, heading back towards camp.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}	
		else {
			outputText("<i>\"You just want to...hang out?\"</i> Belisa seems taken aback by this, but she smiles slightly. <i>\"I...wouldn't be opposed to spending some time with you. What are you thinking of doing?\"</i>\n\n");
			menu();
			addButton(1, "Spar", BelisaHangSpar);
			addButton(2, "Fish", BelisaHangFish);
			addButton(3, "Weaving", BelisaHangWeave);
			addButton(6, "Magic", BelisaHangMagic);
			addButton(7, "House", BelisaHangHouse);
			addButton(8, "Back", Encounterback);
		}
	}
	
	public function BelisaHangSpar():void {
		clearOutput();
		if (BelisaAffectionMeter < 30) {
			outputText ("<i>\"You want to fight...ME?!\"</i> she seems rather angry...and afraid. <i>\"Was this just your way of getting me to lower my guard? To be able to fight me, 'for fun' or 'for training', and weaken me so I can't run?\"</i> without listening to your denials, she immediately sinks to the bottom of the lake.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		else {
			outputText("You ask Belisa if she feels ready to fight a demon. The little Drider looks at you, and shakes her head. <i>\"I don’t really like fighting, [name]. So…\"</i> You tell her that running and hiding won’t save her forever.\n\n");
			outputText("Belisa sighs, and looks at you with an uncomfortable look on her face. <i>\"...You want to fight me?\"</i> You tell her that it would be a spar, not a real fight, but yes. You tell her that you want her to be ready to defend herself, if she ever needed to. Belisa nods, joining you on land.\n\n");
			outputText("<i>\"...Okay, just...Be gentle with me, please?\"</i> You tell her that you’ll try, but training can’t be weakened. She pulls two knives from her robes, her body beginning to shine with a white light. <i>\"Very well then, [name]. If you want to, I will\".</i>\n\n");
			player.createStatusEffect(StatusEffects.SparingBelisa,0,0,0,0);
			startCombat(new Belisa);
			doNext(playerMenu);
		}
	}
	public function BelisaHangSparWon(hpVictory:Boolean):void {
		clearOutput();
		if (hpVictory) {
			outputText("Injured, the spider-girl falls, her spindly legs folding underneath her. <i>\"Ow…\"</i> She cradles one arm, trying to focus on the healing magic, but the light isn’t even enough to make her robes see-through. <i>\"No...I can’t be out yet, I…\"</i> She looks up as you approach, her six eyes wide with fear.");
			outputText(" <i>\"...s-stay back!\"</i> She brandishes her dagger with her good arm, trying to keep it between her and you. She bites her lower lip, one fang barely sticking out beyond it. She trembles, almost dropping the knife.");
			if (player.hasStatusEffect(StatusEffects.SparingBelisa)) {
				outputText("\n\nYou remind the spider-girl that you were just sparring. That this was a practice, not the real thing. <i>\"O-oh...Right.\"</i> She lets out a little <i>\"Tk-Tk-Tk-Tk.\"</i>");
				outputText(" You offer her a hand up, and she takes it. Despite her spider-half’s size, she’s surprisingly light, and you pull too hard. She skitters forward, and her top half careens into you. She instinctively wraps her arms around you, blushing as she lets go.");
			}
		}
		else {
			outputText("<i>\"...Demon…\"</i> She tries to cast another fireball at you, but the magic fizzles. <i>\"...No. I can’t…\"</i> Despite her words, one of her hands drops to the point where her spider body meets her womanly upper half. Pushing aside the sopping wet front of her silk robe, she cries out, clearly sensitive. <i>\"I…\"</i>");
			if (player.hasStatusEffect(StatusEffects.SparingBelisa)) {
				outputText("\n\nYou ask her if she’s okay, and she pouts up at you, sheepishly stuffing her fingers into her dripping pussy. <i>\"No, I’m not. You...You’re fighting like a demon, [name], and it’s not fair!\"</i> You remind her that many demons fight this way, and that her white magic won’t always protect her.");
				outputText(" <i>\"I know...And now I can’t cast for the rest of the day\"</i> She looks up at you, somewhat annoyed, but also giving you a nice view of her drooling cunt. When she sees you looking, she blushes, putting a hand over her honeypot to block your view. ");
			}
			if (BelisaInCamp) {
				outputText("She looks up at you, still blushing, her gaze dropping to your nethers. <i>\"W-well, if you’re going to get me all riled up, the least you could do is help me deal with it after.\"</i>");
				BelisaSexPostSpar();
			}
		}
		cleanupAfterCombat();
		//lvl up stuff if flag sert to npc's training
	}
	
	public function BelisaHangFish():void {
		clearOutput();
		outputText("<i>\"Oh, is that all?\"</i> Belisa pops down under the water, then into her silk orb. \"A-ha!\" She comes out with two odd, hooked spears. <i>\"If you want to fish with me, I’ll teach you how we Driders do it!\"</i>\n\n");
		if (player.hasGills() || player.hasPerk(PerkLib.AffinityUndine)) {
			if (player.hasPerk(PerkLib.AffinityUndine)) outputText("  She brings an odd bunch of silk down with her, and you look at it curiously. She drapes it over your head, and you push it away, taking in a deep breath. She gives you a thumbs-up, and doesn’t give you the air-bag again.\n\n");
			else outputText(" She brings an odd bunch of silk down with her, and you look at it curiously. She drapes it over your head, and you breathe in a lungful of fresh air. You point at your gills, and she nods, taking a breath herself. She gives you a thumbs-up, and doesn’t give you the air-bag again.\n\n");
		}
		else outputText(" You dive down, deep into the lake with Belisa. Eventually, you begin to run low on air, and...she keeps going down! You turn back, but Belisa grabs your foot, pulling you down to her. The spider-girl produces an odd, silky bag, draping it over your head. You struggle at first, but you quickly realize that the bag’s...full of breathable air? She takes it off your head, and giggles, sending bubbles back up to the surface of the water.\n\n");
		outputText("You spend an hour under the water with Belisa, and she swims with you. You catch a few fish, but you can’t hold a candle to the water-spider. Her eight lower limbs move precisely, and she swims circles around you. You miss your spear throw a few times, and when you do, she gives you a bright laugh, swimming over to your spear and bringing it back to you. It’s odd, but a lot of fun, just throwing spears and swimming deep under the lake. Eventually, you point back to the surface. Belisa’s bright smile shrinks a little, but she nods, guiding you back to her silky orb.\n\n");
		outputText("<i>\"I forgot how nice it was to have a fishing partner\"</i>, she says simply, taking your hand as you leave the water together. <i>\"Come back soon, okay?\"</i> She looks into your eyes, then pulls her hand away. <i>\"It gets lonely out here.\"</i> You smile to yourself as Belisa dives back into the water, and head back to camp.\n\n");
		inventory.takeItem(consumables.FREFISH, camp.returnToCampUseOneHour);
	}
	
	public function BelisaHangMagic():void {
		clearOutput();
		outputText("<i>“Oh, you want to learn the mystic arts?”</i> She gives you a smile. <i>“Well, I’m not the most accomplished mage, but...If it’ll help you, then I can help you along the path.”</i>\n\n"); 
		outputText("You sit down with Belisa, and she begins to cover the basics of magic with you. Since she doesn’t know that much, she focuses on healing magic, guiding you through bone-knitting, magical stitching, and other healing techniques. An hour passes, and at the end of it, she stands, stretching her spider legs.\n\n");
		outputText("<i>“It’s best to learn in small doses.”</i> She says simply. <i>“I can’t risk either of us burning out, all things considered.”</i> You thank Belisa for her time, and she smiles happily. <i>“Oh, you’re welcome. It’s…nice to practice magic again like this.”</i>\n\n");
		BelisaAffection(5);
		dynStats("int", 1);
		player.trainStat("int", 1, 80);
		if(!player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
			player.createStatusEffect(StatusEffects.KnowsWhitefire,0,0,0,0);
			outputText("<b>New White Magic Spell Learned: Whitefire</b>");
		}
		else if(!player.hasStatusEffect(StatusEffects.KnowsHeal)) {
			player.createStatusEffect(StatusEffects.KnowsHeal,0,0,0,0);
			outputText("<b>New White Magic Spell Learned: Heal</b>");
		}
		else if(!player.hasStatusEffect(StatusEffects.KnowsBlind)) {
			player.createStatusEffect(StatusEffects.KnowsBlind,0,0,0,0);
			outputText("<b>New White Magic Spell Learned: Blind</b>");
		}
		doNext(camp.returnToCampUseOneHour);
	}

	public function BelisaHangWeave():void {
		clearOutput();
		outputText("<i>\"Well...Wait...You want to learn weaving?\"</i> She looks at you in disbelief. You shrug, telling her that’s what you said. <i>\"Okay!\"</i> Her smile brightens,\n\n");
		if (!BelisaQuestComp) outputText("for once showing her broken fang.\n\n");
		outputText("<i>\"If you want to learn some basic threads, I can teach you.\"</i>\n\n");
		outputText("You spend an hour with the Drider, learning the basics of weaving spider-silk into a rope. Your efforts are...well, crappy, but she seems to approve. <i>\"Well, you’re better than…\"</i> She looks down at her lap. <i>\"Never mind. You’re doing well, [name]. I think that’s enough for today, though. I need some time alone.\"</i>\n\n");
		BelisaAffection(5);
		doNext(camp.returnToCampUseOneHour);
	}
	
	public function BelisaHangHouse():void {
		clearOutput();
		outputText("<i>\"Oh, you’re wondering about the house?\"</i> Belisa seems surprised you’re taking an interest in her dwelling. <i>\"I made it from a bit of...Well, no...A lot of silk, some spongy wood from the swamp, and bits and pieces here and there.\"</i> She motions to you, and you follow her onto her vessel-home.\n\n");
		outputText("The inside is surprisingly warm and cozy, wooden floor clearly insulated from the water underneath. Instead of a bed, a hammock hangs from the ceiling, easily large enough to fit Belisa twice over. To one side, various knitting and weaving materials sit in corkboard boxes, and a desk, clearly modified to fit a Drider, is tucked away in one corner.\n\n");
		outputText("<i>\"Oh! And here’s the fun part!\"</i> Belisa taps one of the wooden panels, then pulls a hatch open. There’s water underneath, clearly opening to the rest of the lake. Belisa grins, grabbing a spool with rope attached to it. She turns the spool, and…nothing happens. She keeps turning it, and you begin to feel a slight pressure increase in your [ears]. Curious, you open the hatch, only to see the bottom of the lake, far closer than it had been before.\n\n");
		outputText("<i>\"Cool, right?!\"</i> Belisa asks, a huge smile on the half of her face she’ll let you see. <i>\"My silk has an odd effect on the water. No matter how deep we go, we’ll have breathable air for a long time. I don’t know how it works, but…It lasts for over a day if I don’t do anything strenuous.\"</i> Now you understand how your Drider friend’s been able to remain hidden for so long.\n\n");
		outputText("For a while, you sit in Belisa’s odd, but surprisingly cozy home, chatting with your Drider friend. Eventually, you tell her that you need to leave. Belisa nods, and brings the silk bubble back to the surface. As you step out onto the shore, you realize it’s been nearly an hour. You excuse yourself, and Belisa waves as you leave.\n\n");
		BelisaAffection(5);
		doNext(camp.returnToCampUseOneHour);
	}
	
	public function BelisaHangBack():void {
		clearOutput();
		doNext(Encounterback);
	}
	
	private function BelisaShop():void {
		clearOutput();
		outputText("<i>\"Oh...You want to buy something?\"</i> Belisa blinks her two large eyes, somewhat surprised. <i>\"I-I mean, sure. I’m not sure what you want, but…I have some things for sale, if you want them.\"</i> The little Drider-girl runs to her silk orb, and comes back with a number of boxes attached to her Drider half. <i>\"I have silk for sale. It’s raw, but someone could make it into armor for you...I also have...Underwear.\"</i> ");
		outputText("She blushes a little at that. <i>\"There's also these bands I've been working on and enchanting. They really could be useful to an adventurer like you!\"</i>\n\n");
		menu();
		//addButton(0, "Bands", BuyHolyBands);
		addButton(1, useables.T_SSILK.shortName, belisaBuy, useables.T_SSILK, 300);
		addButton(2, undergarments.DRI_PANTY.shortName, belisaBuy, undergarments.DRI_PANTY, 2100);
		addButton(3, undergarments.DRI_BRA.shortName, belisaBuy, undergarments.DRI_BRA, 1800);
		addButton(5, armors.DWSROBE.shortName, belisaBuy, armors.DWSROBE, 13200);
		addButton(6, armors.DWARMOR.shortName, belisaBuy, armors.DWARMOR, 2160);
		if (BelisaInCamp) addButton(14, "Back", BelisaMainCampMenu);
		else addButton(14, "Nevermind", Encounterback);
	}
	public function BuyHolyBands():void {
		clearOutput();
		outputText("You ask the petite Drider about the holy energy you feel coming off of the leftmost box. \"O-oh!\" She seems happy you asked about that.\n\n");
		outputText("\"Those are bands, made from my silk, and imbued with holy magic! I made the enchantments myself, and I’ve been able to produce a few different effects!\" She bobs up and down on her Drider legs, and her eyes sparkle with holy light. \"I hope you like them!\n\n");
		menu();
		//addButton(0, "Crimson", BuyCrimsonBand);
		//addButton(1, "Pink",BuyPinkBand);
		//addButton(2, "Yellow",BuyYellowBand);
		//addButton(3, "Turqouise", BuyTurquoiseBand);
		//addButton(4, "Crossed", BuyCrossedBand);
		//addButton(5, "R.Blue", BuyBlueBand);
		addButton(14, "Back", BelisaShop);
	}
	public function BuyCrimsonBand():void {
		clearOutput();
		outputText("\"Oh, this one’s nice!\" Belisa smiles, taking the band out and showing it to you. \"It’s woven with a fortification enchantment. While you’re wearing it, you’ll take less damage from physical sources, like swords or bows...But it will reduce your mystical capacity when worn\".\n\n");
	}
	public function BuyPinkBand():void {
		clearOutput();
		outputText("\"You have a good eye, [name], this one’s my favorite. It protects you from dark magics a little, but its main purpose is reducing lust magic’s effects in particular. If you’re having issues with demon mages, this should be on the top of your shopping list!\"\n\n");
	}
	public function BuyYellowBand():void {
		clearOutput();
		outputText("\"When you need a bit of extra speed, this little guy’s the best!\" Belisa bobs up and down, showing off her left arm, where one of her yellow bands rests snug against the flesh. \"For every band like this you have, it’ll make your muscles faster, your strikes swifter, and your runs shorter!\"\n\n");
	}
	public function BuyTurqouiseBand():void {
		clearOutput();
		outputText("\"Oh, this little fella is great in a pinch!\" Belisa slides it on, and almost immediately a bubble of energy forms around her. \"The first hit you take, no matter what, is negated by this beauty...Only problem is that it's a hard magic to play around with, and forming two bubbles in the same space...It doesn’t end well\". She perks back up. \"But wearing one of these babies can still be very useful!\"\n\n");
	}
	public function BuyCrossedBand():void {
		clearOutput();
		outputText("\"This one is really useful if you find yourself against a tricky opponent\". Belisa smiles. \"It’s a little bit of smart magic I cooked up. Once I attune it to you, it’ll be constantly working to nudge your body back towards an unimpeded state. Basically, it works as a stabilizer for your body and mind\".\n\n");
	}
	public function BuyBlueBand():void {
		clearOutput();
		outputText("\"Oh, this one is my favorite one to dye. Getting the blues right can be annoying, but so satisfying to…\" She trails off, then coughs, realizing she’s getting off-topic. \"This one’s a magic-dampener. It can’t be attuned to take Soulforce as fuel, but it reduces the power of incoming elemental and magic-based attacks\". She smiles at you. \"If you’re needing protection from magic, this can help a lot\".\n\n");
	}
	public function belisaBuy(itype:ItemType, cost:Number):void {
		clearOutput();
		outputText("You gesture at " + itype.longName + ".\n\n");
		outputText("\"<i>Oh, this one? It costs " + cost + " gems.</i>\"");
		if (player.gems < cost) {
			outputText("\n<b>You don't have enough gems...</b>");
			doNext(BelisaShop);
			return;
		}
		doYesNo(Utils.curry(belisaBuy1,itype,cost), BelisaShop);
	}
	public function belisaBuy1(itype:ItemType, cost:Number):void {
		clearOutput();
		if (itype == useables.T_SSILK) outputText("<i>\"Oh, you want raw silk?\"</i> She looks mildly disappointed, but pulls out a few spools from one of her boxes. <i>\"You know we Driders were the best weavers on Mareth, right?\"</i> She sighs, clearly not very pleased with selling her silk raw. <i>\"Okay, that’s 300 gems.\"</i>\n\n");
		player.gems -= cost;
		statScreenRefresh();
		inventory.takeItem(itype, BelisaShop);
	}
	
	public function BelisaComeCamp():void {
		clearOutput();
		outputText("You tell Belisa that Mareth is a dangerous place. She looks at you as if you’re an idiot, hand on her hip. <i>\"Yes, I do know that.\"</i>\n\n");
		outputText("You say to her that you’ve come across several places in your travels that the pure (or at least the not completely corrupt) at heart congregate. You ask Belisa why she hasn’t gone to Tel’adre, or He’Xin’Dao. A weaver and healer would be more than welcome in either place. Belisa looks at the ground, then back at you, a single tear sliding down her face.\n\n");
		outputText("<i>\"...Because those places...Are targets.\"</i> She sighs, sitting down on the lake’s shore. You sit beside her, and she smiles slightly as you come closer. <i>\"You’re assuming I never did go elsewhere, [name]...I did.\"</i> You put a hand on the closest spider leg to you, giving her a reassuring smile. <i>\"...There was a goblin-run city not far from the battlefield. You know where that is.\"</i> You nod, and she continues. <i>\"As you said, a weaver and healer was more than welcome. I made a few friends, since the Goblins and Driders always were allies...But...They came again.\"</i>\n\n");
		outputText("Belisa bites her lower lip, forcing back her tears. <i>\"I knew there was something in the water. I tried to warn the council, the people, but...By the time I’d figured it out, it was too late. I was able to cure my own corruption, but...Everyone else was gone again.\"</i> She winces. <i>\"Every time I see a goblin now, it’s...Like seeing a mockery of the friends I made.\"</i>\n\n");
		outputText("You scoot closer, sitting up and putting your hands on your Drider friend’s shoulders. She gives you a little smile, her repaired fang gleaming almost as bright as her eyes. <i>\"Thank you for listening, [name]. It’s been a long time since I had anyone I could talk to about this.\"</i>\n\n");
		outputText("You tell Belisa that you’re just happy she’s finally getting it off her chest. As you’re saying that, however, an idea hits you. You ask Belisa if she’d be okay with a smaller group, or a hamlet, rather than a full-blown city. Not as big of a target, but still with people she could talk to, rely on and help.\n\n");
		outputText("<i>\"W-well, I…\"</i> The drider-girl looks at you, somewhat flustered, her pale, squishy cheeks now bright red. <i>\"I...Suppose that wouldn’t be out of the question, but I wouldn’t know where to find such a place. I’d need it to be near water, away from demon hot-zones, and far away from the swamps, since I can’t go back there…\"</i> She rambles on for a bit, pacing back and forth on the beach, until you stand up, putting your hands on her shoulders. <i>\"Sorry...I went on for a bit there.\"</i> Belisa stares, wide-eyed, at you. <i>\"Why are you asking all of these questions?\"</i>\n\n");
		outputText("You tell her that you know a few locations that would fit her requirements. You mention Whitney’s farm, the people there. She winces at the notion.\n\n");
		outputText("<i>\"Yeah, I’ve been there. No thank you. That horse-man makes my chitin itch.\"</i> You press on, describing a few other locations you know about, all of which are shot down in short order. You mention that there’s one more place you know of. You begin to describe your camp, some of the people you’ve gathered on your travels, and the defenses, if any, you’ve put up to deter the demons from coming after it. You explain the river running nearby, the portal, and how her orb-house could just pull right up and dock.\n\n");
		outputText("<i>\"Oh?\"</i> She seems somewhat interested, and Belisa scratches the back of her head. <i>\"You...Seem to know this place rather well. What’s it called?\"</i>\n\n");
		outputText("You tell her that the place you’re describing doesn’t have a name, not really, but ever since you came to this world, you’ve been calling it home.\n\n");
		outputText("<i>\"D-did you just ask me to come live with you?!\"</i> Belisa’s face turns bright red, and she turns around, hiding herself from your view. You gently walk around, to see her, and she covers her face with her hands. Her face is bright red, from scalp to chin, and she’s shaking a bit.\n\n");
		outputText("With a low, calm voice, you tell Belisa that yes. You just asked her to come live with you. You reassure her that you weren’t asking to sleep with her, or anything of the sort...Not unless she wanted it. At that, she slowly begins to bring her hands down. She won’t meet your eyes, but the spider-girl’s at least looking in your general direction. You remind Belisa of how strong you are, and you reassure her that everyone at your camp is a survivor. Belisa looks at you, her eyes shining with tears, and something seems to break in her. She rushes at you, arms outstretched, and you stand firm as she runs full-speed into your arms.\n\n");
		outputText("<i>\"Y-you mean it, [name]?\"</i> She whispers, and you hug her tighter, telling her that you meant every word. That Mareth is a tough world, and that nobody, especially someone like her, should face it alone.\n\n");
		outputText("Belisa buries her face into your [chest], and you know that you’ve convinced her. <i>\"Okay. If you want me with you...I’ll follow you to your camp.\"</i>\n\n");
		outputText("You spend the next hour wrestling with the huge ball of silk that Belisa calls a home, folding it down until it’s flat(ish) on the water. Belisa produces a pair of oars, and begins to row. You take one oar, and the spider-girl smiles, a sunny beam from ear to ear.\n\n");
		outputText("The two of you row Belisa’s silky home through the lake, down the river, and down towards your camp, and it takes most of the rest of the day. Belisa hums a tune, lost in her own thoughts, and you look at her, a smile on your face as you row. As you get closer, Belisa’s arms tire, and she begins to fall behind. You take the oar wordlessly, and the Drider-girl chitters a bit.\n\n");
		outputText("<i>\"S-sorry, but…\"</i> You tell her not to be sorry, that you’re almost home. <i>\"...Home?\"</i> You turn a bend in the river, and Belisa and you can finally see your camp, as it is from the water. The Drider’s eyes shine in the red light of the setting sun, and you can see her repaired fang as her jaw drops. <i>\"It’s…Amazing\"</i> She looks at you, the little smile on your face, and she blushes, turning away. <i>\"What? I’ve been living on my own, [name].\"</i> She pouts a little, and you chuckle, wrapping your arm around Belisa’s shoulder. The ball of silk slows, and you take her chin in a hand, gently turning her head to face you. Her eyes, shining in the orange-red sunset, seem so tender, almost delicate.\n\n");
		menu();
		addButton(1, "Set up", BelisaSetUp);
		addButton(3, "Kiss", BelisaSmooch);
	}
	
	public function BelisaSmooch():void {
		clearOutput();
		outputText("You lean in, kissing Belisa on the lips. She flinches, but after a second or so, she wraps her arms around you, her full lips locking with yours as if it’s the most natural thing in the world. You feel one of her front legs on the small of your back, and she pulls you in, her C-cup breasts a pillow against your [chest]. Her tongue is long, and your saliva mixes with hers, a surprisingly sweet taste. You stroke her long, ebony hair, pulling back from the kiss. <i>\"I…\"</i> Belisa begins to talk, but shuts her mouth, her heart clearly beating quickly. <i>\"...You…!\"</i>\n\n");
		outputText("You tell Belisa that you’re glad you’ll get to see more of her, and she nods, her blush somehow spreading to her neck as she brushes the hair from her eyes. <i>\"I’m...Very happy I met you.\"</i> That seems to be the understatement of the year, but you let it go. Clearly your Drider-girl has little experience with this. She’s already going through a lot, and you decide to leave it for now. Besides, Belisa needs to anchor her house!\n\n");
		menu();
		addButton(1, "Set up", BelisaSetUp);
	}

	public function BelisaSetUp():void {
		clearOutput();
		outputText("You tell Belisa that she’ll need to set up her house before nightfall...Unless she’d rather sleep in your "+(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "Cabin":"Tent")+" tonight. She blinks once, twice, then the Drider launches herself off the silky house-boat and into the water, screaming in embarrassment. You decide to leave her to it, laughing to yourself as you walk off and onto dry land.\n\n");
		outputText("<b>Belisa has joined you as a lover.</b>\n\n");
		BelisaFollowerStage = 3;
		BelisaInCamp = true;
		doNext(camp.returnToCampUseOneHour);
		model.time.hours = 21;
	}

	public function BelisaMainCampMenu():void {
		clearOutput();
		outputText("You decide to go see your bashful Drider, Belisa. As you get near, you ");
		var visit:Number = rand(3);
		switch (visit) {
			case 0:
				outputText("notice that Belisa is nowhere to be seen. You walk to her home, and as you expected, you can see a “Fishing” sign on her door. You go to the river, and easily catch sight of Belisa underwater. You toss a rock down, and she looks up and sees you, swimming to the surface as fast as she can.");
				break;
			case 1:
				outputText("notice that Belisa is relaxing just outside her home, needles busy at work. As you approach, she puts the needles and silkwork down, giving you a smile.");
				break;
			case 2:
				outputText("can hear a faint humming from inside her home, golden light spilling through the silk. The light and sound flares, then stops, seemingly at random. You knock on the door, and you can hear a faint <i>\"Coming!\"</i> From inside. Belisa comes over to the door, opening it for you. Inside, one of her silk bands sits on her desk, a few arcane-looking tools holding it in place.");
				break;
			default:
				outputText("notice that Belisa is relaxing just outside her home, needles busy at work. As you approach, she puts the needles and silkwork down, giving you a smile.");
		}
		outputText("<i>\"Oh, hello!\"</i> Belisa says brightly, her lower-half bobbing slightly. <i>\"What’s brought you over here?\"</i>");
		if (BelisaConfessed) outputText("<i>\"...Anything I can help you with?\"</i> When she thinks you aren’t looking, she takes a glance down, beads of drool forming on her fangs.");
		outputText("\n\n");
		menu();
		addButton(0, "Appearance", BelisaAppearance);
		addButton(1, "Talk", BelisaTalk);
		addButton(2, "Hang", BelisaHang);
		addButton(3, "Shop", BelisaShop);
		addButton(4, "Sex", BelisaSex);
		if (DriderTown.DriderTownComplete) addButton(13, "Back", SceneLib.dridertown.DriderTownEnter).hint("Return to main DriderTown menu.");
		addButton(14, "Leave", camp.campLoversMenu);
	}
	
	public function BelisaAppearance():void {
		clearOutput();
		outputText("Belisa, at first glance, appears to be an odd cross between a spider-morph and a drider. She only has two humanlike eyes, with light brown pupils. Her face is mostly humanoid, save for a thin ridge of chitin that adorns her brow like a crown. Long, straight black hair runs down her back, almost touching her Drider back half. The top of her head is shielded from the sun by a large, glistening sun hat that you can only assume was woven from her own silk. Her skin is pale, almost white, and her full lips draw into a natural pout.\n\n");
		if (BelisaQuestComp) outputText("As she sees you looking at her face, she smiles, revealing her restored teeth and glimmering fangs. She blushes, but doesn’t seem to mind the attention.\n\n");
		else outputText("One of her thin fangs sticks out over her lower lip, but she’s deliberately hidden the other from view. When you look at where that fang would be, she cringes, tilting her head so her sunhat hides her face from view.\n\n");
		outputText("Unlike every drider you’ve ever seen, she only has two C-cup breasts, and she’s covered herself with a thin, opaque robe made from spider silk. Underneath, you can see she’s wearing a bra made out of scales, though from what, you have no idea. Her robe trails down and covers her naughty bits, and when it looks like it’s about to reveal her dark-brown pussy lips, she brings a hand down. You get a peek at some white silk panties before she covers back up.\n\n");
		outputText("She has the eight legs of a drider, but her exoskeleton is chocolate-brown, with splotches of blue along the sides that look remarkably like raindrops. Her legs are thinner and longer than most other driders, and you can see faded lighter-brown marks along several of her legs, likely where the chitin was broken in the past. Her abdomen is slender and streamlined, smaller than you’d expect, but it flexes periodically.\n\n");
		outputText("Her arms are covered in the same brown chitin, up to the forearm, at which point it smoothly transitions into smooth, pale skin. Her fingernails are the same color as her chitin, but otherwise her arms are smooth as silk, and her hands are extremely soft.\n\n");
		outputText("She wears a saddle-like silk backpack, filled with odds and ends. A pair of knitting needles sits on her wrists, and a half-finished spider silk robe hangs over her back. When she catches you looking at her work, she blushes.\n\n");
		if (BelisaInCamp) doNext(BelisaMainCampMenu);
		else doNext(Encounterback);
	}
	
	public function BelisaSexPostSpar():void {
		menu();
		if (player.hasCock()) {
			addButton(1, "Fuck", BelisaFuck);
			addButton(2, "Anal", BelisaAnal);
			//addButton(3, "Silkjob", BelisaSilkjob);
		}
		if (player.hasVagina()) {
			//addButton(5, "69", BelisaFunnyNumber);
			addButton(6, "Dildo Fun", BelisaDildo);
		}
		addButton(14, "Back", cleanupAfterCombat);
	}
	public function BelisaSex():void {
		clearOutput();
		if (BelisaAffectionMeter >= 80 && BelisaConfessed) {
			outputText("Belisa sways slightly, her Spider legs weakening for a moment before she composes herself. <i>\"Y-you mean like…right now?\"</i> Belisa’s cheeks are red, but her eyes are half-lidded as she bites her lip, giving you a once-over. She then looks around nervously, seeing if anyone else is around.\n\n");
			outputText("You tell her that if she’d prefer, you can take this…inside, but yes. You tell her that you want to make love to her. You look at her front legs, turned inwards, shivering slightly. Raising one eyebrow, smirking slightly, you ask her if she doesn’t want you right now.\n\n");
			outputText("<i>\"I-I never said that!\"</i> Belisa lets out a little eep, covering her mouth, her blush deepening. She turns herself around, walking towards her silky home. She reaches it, turning her head around as she parts the silk and opens the door. \"J-just…Come inside, okay?\"\n\n");
			outputText("You follow, then close behind her, you put a hand on one of her soft C-cups, kneading the flesh through the thin robe she wears. You ask her what she means by that, a teasing smile on your face, and to your surprise, she pokes your [chest], wrapping her other arm around your neck.\n\n");
			outputText("<i>\"What do you think I mean?\"</i> Belisa whispers into your ear, gently pulling you through the door and into her home. Closing her door behind you, Belisa’s front legs spread wide, and she gives you a happy smile. Now in her home, she seems much more confident than before. You step in, slipping your arms around her waist, and Belisa lets out her <i>\"tk-tk-tk-tk\"</i> noise. Her magic flows into her robe, rendering the garment nearly invisible. Eagerly, you slide your fingers underneath the sheer silk fabric, sliding it up and over Belisa’s head. As soon as she’s free from the garment, she takes it from your hand, tossing it to one side.\n\n");
			outputText("Taking hold of her palmable globes, you bring your lips to her nipple, sucking heavily. Belisa lets out a breathy gasp, but returns the favor, leaning in and running the tips of her fangs along your vulnerable neck as she hastily undresses you.\n\n");
			outputText("Belisa, now fully naked, presses her upper half against your [chest], picking at your hair with one hand. <i>\"Well…Now we’re alone,\"</i> she whispers to you, eyes smoldering. <i>\"How do you want me?\"</i>\n\n");
			menu();
			if (player.gender == 0) {
				outputText("Belisa looks down hungrily between your legs, to see that there's nothing down there. She stares for a moment, utterly baffled at your lack of genitalia, before crossing her arms over her breasts, giving you an odd cross between a pout and a glare. <i>\"That's not fair!\"</i> She declares. <i>\"You got me all ready to go...and...You don't even...?!\"</i> Belisa opens the door, pointing for you to leave. <i>\"You are THE WORST!\"</i>\n\n");
			}
			else {
				if (player.hasCock()) {
					addButton(1, "Fuck", BelisaFuck);
					addButton(2, "Anal", BelisaAnal);
					//addButton(3, "Silkjob", BelisaSilkjob);
				}
				if (player.hasVagina()) {
					//addButton(5, "69", BelisaFunnyNumber);
					addButton(6, "Dildo Fun", BelisaDildo);
				}
			}
			addButton(14, "Back", BelisaMainCampMenu);
		}
		else {
			if (BelisaAffectionMeter < 20) outputText("<i>\"I knew you were a pervert! Get away from me!\"</i> Belisa draws her knives, but she looks scared, as if she doesn’t really want to fight. You decide to not aggravate the slender Drider further, backing away from her and heading on your way.\n\n");
			else if (BelisaAffectionMeter < 40) outputText("<i>\"...Look…I know the world’s gone to horny hell, but I haven’t yet.\"</i> Belisa says tightly. <i>\"I don’t want to sound…rude…but I don’t really want to…Sleep with just anyone.\"</i> Not sure whether to be insulted or impressed, you leave Belisa alone, heading back to camp.\n\n");
			else if (BelisaAffectionMeter < 60) outputText("Belisa stares at you for a moment, her blush getting redder. <i>\"...No.\"</i> She shakes herself, slapping her cheeks. <i>\"It’s not that I don’t trust you…But…\"</i> She winces. <i>\"Just…I can’t, okay?\"</i>\n\nYou apologize, and Belisa nods, accepting your apology. She heads back inside, and you back away, leaving her in peace to do…whatever she’s doing now.\n\n");
			else if (BelisaAffectionMeter < 80) outputText("Belisa blushes, turning her head away from you shyly. <i>\"...[name], I can’t right now, okay?\"</i> She heads back into her home, and you can hear some rustling inside. You can hear a small gasp, and a wet <i>schluck</i>. Is...Is Belisa...?\n\n");
			else if (BelisaAffectionMeter >= 80) outputText("Your shy Drider looks you up and down, a small bit of drool dripping from the corner of her mouth. She snaps out of it, then immediately turns her head. <i>\"Nope! Nope nope nope nope! Nope!\"</i> She sprints as fast as she can, launching herself face-first into the water. Judging from her reaction…she wants to…? But…Something’s in the way? You’re not sure whether to be amused or insulted by her reaction.\n\n");
			if (BelisaInCamp) doNext(BelisaMainCampMenu);
			else doNext(camp.returnToCampUseOneHour);
		}
	}

	public function BelisaFuck():void {
		clearOutput();
		outputText("You ask your cute Drider-girl if she’d like you in her womb again.\n\n");
		outputText("Belisa’s face lights up, and she nods wordlessly. Her cheeks are bright red, but the smile on her face makes it clear she’s more used to the idea than before. <i>\"I…Was hoping you’d come back for more…\"</i>\n\n");
		outputText("You tell her that you want her. You want her love,and that nothing on Mareth would stop you from coming back to your spider-girl.\n\n");
		outputText("<i>\"Oh...My.\"</i> Belisa shudders a bit at that, back legs tapping rapidly on the floor. <i>\"That...Just made me…\"</i> You take her hand, and she leads you up into her hammock-bed. As soon as you clamber in, she pounces on you, her eight legs quivering with excitement. Her fingers scrabble at your [armor], and you return the favor, slipping your arms into her robe and sliding it off her.\n\n");
		outputText("Belisa runs her fangs along your shoulder, the needle-tips giving you goosebumps. You shudder as she brings both her hands to your cheeks, her soft palms cool against your flushed face. With a sweet smile, Belisa leans in, her hazelnut eyes shining. She leans into you, her hardening nipples like pinpricks against the lush softness that is her upper body. She takes your [cock] in one hand, eyes all but glowing as she rubs your [cockhead], slowly guiding it to her dark-lipped pussy.\n\n");
		outputText("You sink into her, your [cockhead] catching on a few folds before slipping past, her tight chasm clamping down as you bottom out. Belisa moans into your shoulder, kissing the vulnerable side of your neck as you begin to pull back. As you slowly slide back out, Belisa shivers, front legs wrapping around your waist as she presses her soft titflesh against your [chest]. You open your mouth as she gyrates her hips, your [cockhead] barely inside her entrance, and she brings her hips slowly down, rubbing you against every side of her depths.\n\n");
		outputText("<i>\"A-aghn…\"</i> Belisa moans, closing her eyes. <i>\"[name]...\"</i> You take the back of her head in one hand, taking her open mouth and ravishing it with your [tongue]. Your Drider tightens as soon as your lips lock, and you bring your hips up, burying yourself into her. Her surprised moan reverberating through your mouth and teeth, you bring one hand to her stomach, guiding her back up and off your [cock]. You warn Belisa that you’re going to speed up, and she nods fiercely, licking your lips and pulling her head back just enough for you to see the hungry look in her eyes.\n\n");
		outputText("You pop your hips up, sliding home, and Belisa slams her hips down a split second later. It doesn’t take long for your normally shy Drider lover to spasm, her pussy tightening as liquid shoots down your length, out of her and onto the hammock. Belisa wails in delight, eyes glazing over, and you take the opportunity, grabbing her forearms and rolling, turning Belisa upside down. Now on top, you bear down, sinking deep into her innermost depths.\n\n");
		outputText("<i>\"Yesssss-tk-tk!\"</i> Belisa moans, two of her back legs rubbing the outside of your leg. <i>\"Breed me!\"</i> Not one to let such a cry go unanswered, you grin, bearing down on her and pistoning in and out of that wet love-tunnel. Her arms pinned down by yours, Belisa moans with each thrust, trying to sink you as deep as possible. Your uneven thrusts start rocking the hammock, and Belisa seems to get off even more to that, the dizzying, wild swinging making you feel different parts of her with every thrust.\n\n");
		outputText("Close to your limit, your [cock] twitching, you grunt, trying to hold on, to prolong this wild, swinging ride. Seeing your attempts, Belisa rolls, placing the two of you side by side. Taking your head in one hand, Belisa rubs your hip with her other hand, gasping as you poke her womb.\n\n");
		outputText("<i>\"Oh, [name]...Cum…ahn…for me.\"</i> She rubs your asscheek with her free hand, then locks lips for a moment, licking your saliva off her lips. <i>\"I know…oh…you want to…\"</i>\n\n");
		outputText("Suddenly, she tightens up, arching her back away from you. Her breasts shiver with the movement, and she wails, gushing femcum past your aching, throbbing shaft and drenching the hammock. Her second orgasm sets off yours, your throbbing cock unable to hold back any longer. You grab Belisa’s head, pulling her in for a rough, sudden kiss. Her muffled wails echo in your skull, but all you can feel is the blessed draining, the warmth as your cum races down your shaft, spreading down into Belisa’s waiting womb.\n\n");
		outputText("<i>\"Mmm! Mmmm! Mmmm!!!\"</i> Belisa moans into you with each thrust as you slow down, each thrust bringing a new spurt of seed for her to take. Exhausted, you don’t bother pulling out, letting your rapidly deflating [cock] stay where it belongs. Belisa isn’t complaining either, pulling her lips back from yours only to give you an exhausted, spunk-drunk grin.\n\n");
		outputText("<i>\"mmm…Mine.\"</i> Belisa whispers, finally closing her eyes. Her labored breathing slows, and you realize that she’s falling asleep with her legs still around you…But you don’t mind. For the life of you, you can’t think of anything better to do than cuddle with your Drider-girl.\n\n");
		player.sexReward("vaginalFluids","Dick");
		var rng:Number = (Math.random() * 3 + 1);
		if (rng == 1) doNext(curry(BelisaAfterSex1, true));
		else doNext(BelisaAfterSex2);
	}
	
	public function BelisaAnal():void {
		clearOutput();
		outputText("You tell Belisa that you want to make love to her. The Drider-girl blushes, wrapping her arms around your waist and gently pulling you in towards her. You let her slide your [armor] off");
		if (player.upperGarment != UndergarmentLib.NOTHING) outputText("and she slides her soft fingers underneath your [uppergarment]. With a rustle and a smile, your [uppergarment] is tossed back down to the floor below");
		outputText(".\n\n");
		if (player.lowerGarment != UndergarmentLib.NOTHING) outputText("Belisa licks her lips as she slides your [lowergarment] aside, wrapping both hands around your [cock].\n\n");
		else outputText("With your [cock] exposed, Belisa wastes no time, wrapping both hands around your shaft.\n\n");
		outputText("Her slippery palms are warm, nails barely touching your [cock] as she gives you an amateurish handjob. While not unpleasant, her hands around your tool isn’t what you had in mind.\n\n");
		outputText("You grasp her shoulders, pulling Belisa into a kiss. After a few seconds, you tell her that she did a fine job warming you up, but you had something else in mind. Rubbing one of her Drider legs, you tell Belisa that you want to try something different, if she’s up for some fun.\"Okay, [name],\" Belisa breathes, her cooter already leaking dollops of pre. \"What is it?\n\n");
		outputText("You poke her clit teasingly, and you scootch away, keeping one hand on her shoulder as you maneuver yourself. You slide one foot underneath her, mounting her sideways on the bed. As she tries to turn her upper body, you slap her ass, asking her to trust you. Belisa subsides, but is clearly confused.\n\n");
		outputText("You pull out your [cock], laying its hardness in between Belisa’s slappable asscheeks. You begin to move, poking your prick through her cheeks. You slowly begin hotdogging her, reaching around to grab her C-cup breasts for leverage. Belisa bites her lip, remaining silent as you play with her mounds, rubbing your [cock] along the crack of her ass.\n\n");
		outputText("Dropping your hand to her box, you sink a finger into her wet cooter, taking the moisture onto your hand and bringing it back to your [cock]. Once you’ve slathered your shaft in her juices, you take a bit to your nose, inhaling the musky scent for good measure and ensuring your [cock] is rock hard.\n\n");
		outputText("Belisa lets out a squeak as you prod her puckered backdoor, and you wrap your arms around her waist, nibbling on the sensitive side of her neck as you sink your [cockhead] into her asshole.\n\n");
		outputText("Belisa’s ass is tight, and she yelps at the intense sensation. She squirms, but as you stop moving, she puts a hand on your leg, grabbing the sheets with the other. \"[name], keep going if you want.\" Her voice is high, shaking, and you tighten your grip on her midriff, gyrating your hips from side to side as you inch your way deeper into Belisa’s overwhelmingly tight ass. Little by little, you push your way in. Belisa’s moans get higher with every little bit you put in, until she’s fairly squeaking as you bottom out inside her.\n\n");
		outputText("You bring your mouth to your Drider lover’s ear, asking her if she’s in pain. She nods, but adds a breathy <i>\"It’s okay, I...Don’t mind it.\"</i> Encouraged by this, you begin inching your way back out of Belisa’s asshole. She breathes heavily, her sphincter contracting with your every move, but as you bring a hand to her damp cooter, you feel her own hand in the way, stroking her nub. Sinking a single finger in to sample her pussy juices, you bring them to her nose.\n\n");
		outputText("You ask Belisa if she’s enjoying this, letting her smell the musky sweetness of her own leavings. <i>\"Yes...I am.\"</i> Her cheeks heat up, and you nibble her neck, your teeth scraping the sensitive skin. You warn Belisa that you’re going to pick up the pace, and she shudders beneath you, her upper body shivering with anticipation.\n\n");
		outputText("You slide back down her insanely tight backdoor, getting a muffled yelp from your Drider lover. Slowly but surely, you pick up the pace, and you can feel her ass loosening slightly with each thrust. Your [cock] drips pre, lubricating her passage further.\n\n");
		outputText("<i>\"[name], could you...grab my breast? Please?\"</i> You comply, palming one of her soft breasts and massaging the soft skin around her nipple. The reaction is immediate, and Belisa begins to let out a moan of pleasure, backing her hips into you. At first, she only does a little, but as you take her rock-hard nipple and pull, her bucking intensifies, matching your thrusts.\n\n");
		outputText("<i>\"Oh...This is…\"</i> In between gasps and heavy breaths, Belisa’s trying to talk. You drop your free hand to her pussy, diddling her twat with abandon. The Drider-girl abandons all attempts at talking, letting out a wail as her pussy gushes femcum onto your fingers. Her spider legs flail, sending the hammock-bed lashing about. This finally pushes you over the edge, your [cock] pulsing with your lust. You try to hold back, to keep pounding Belisa’s slick asshole, but to no avail. You cry out, her asshole milking your [cock] as you spurt a thick, white load into Belisa’s backdoor. Another load follows, then another, and you begin to feel the pressure against your [cockhead] as Belisa’s asshole fills up with your spooge.\n\n");
		outputText("Still coming, you pull out, jerking yourself off as you spurt your remaining load onto Belisa’s back, your pure-white load sticking to her back and pale asscheeks. Belisa sags, breathing heavily. her asshole contracts, but her opening is agape, leaking your load onto her Spider lower body. You let your lover recover, and Belisa turns her head towards you, her eyes unfocused and a blissful smile on her face.\n\n");
		player.sexReward("Default", "Default",true,false);
		doNext(BelisaAfterSex1);
	}
	
	public function BelisaSilkjob():void {
		clearOutput();
		outputText("\n\n");
	}
	
	public function BelisaFunnyNumber():void {
		clearOutput();
		outputText("\n\n");
	}
	
	public function BelisaDildo():void {
		clearOutput();
		if (player.hasCock()) outputText("<i>\"Not to be...rude, [name], but...wouldn’t you rather use...your…?\"</i> She gently nudges your [cock]. You shake your head, and she looks at you, shrugging her shoulders.\n\n");
		outputText("<i>\"Honestly...I want kids.\"</i> She admits. <i>\"I know it won't happen like this, but… It still feels good.\"</i> You give your bashful lover a reassuring smile, kissing her on the cheek. You assure her that you'll have lots of time...For now, you just want to enjoy her. Belisa blushes, a small smile forming on her face. <i>\"Okay, [name]. Let's enjoy what we have.\"</i>\n\n");
		outputText("You shake your head, taking the lead. You lean in, locking lips with your spidery lover. She closes her large eyes, cheeks flushing red. You take that as a good sign, rubbing a hand up her girly hips, past her C-cup breasts. You tickle her neck, then bring that hand up to her cheek. Belisa’s eyes open, and she shudders, goosebumps forming where you touched her.\n\n");
		outputText("You look deep into Belisa’s eyes, rubbing her cheek with one hand. She pulls back from the kiss, chittering nervously. <i>\"I-is it always like this? If we’re…?\"</i> You ask her if she’s enjoying the moment, and she nods once.\n\n");
		outputText("You slowly move your other hand down, past her stomach, down to her hairless pussy. Still with one hand on her cheek, you rub her rock-hard clit with one finger. Belisa bites her lip, trying to hold her voice back, but as you bring more fingers in, playfully teasing her lips, sinking a fingernail into her, only to pull it back, you notice that your fingers are becoming slick. You tweak her clit, and Belisa moans, hips moving slightly. You smile, telling her not to hold her voice back,that it’s okay to let it out.\n\n");
		outputText("After a few minutes of teasing your Drider lover, you stop, her slick passage quivering. <i>\"Why did you...Stop?\"</i> Belisa asks, worried. <i>\"D-Did I-?\"</i> You assure her that nothing’s wrong, that she’s just nice and slick, and so she’s ready.\n\n");
		outputText("Getting out of the Hammock for a second, you walk over to your bag, giving your lover a full view of your [ass]. Belisa blushes, but as you take a look over your shoulder, you notice that she’s watching, and she’s not just drooling from her cunt. Going to your bag, you take your deluxe dildo out, letting your [hips] sway as you rejoin your lover in her hammock. She seems to realize it’s purpose immediately, and as you insert one end into your [pussy], she slides in, grabbing it with both hands and guiding it to her own hole. She gasps as it enters, and you give her a wicked little smile, grabbing her tight little ass with one hand as you buck your hips, burying the toy into both of you with one motion.\n\n");
		outputText("Breathless, chest heaving at this sudden fullness and pleasure, Belisa’s wide eyes and open mouth make the perfect target. You pull her into you, pulling your hips back as you lock lips, closing your eyes as you force the dildo deep into your own pussy.\n\n");
		outputText("<i>\"O-oh…My…\"</i> Belisa shivers, and you can feel her spasm, shaking the Dildo lodged in your pussies and sending shivers of pleasure up your spine. Taking her hands, entwining her fingers with yours, you lean in, bending Belisa’s humanoid upper body over her spidery lower half. Now lovingly pinned, Belisa moans softly as you rest your [breasts] on hers, pushing past your combined chests to cover her mouth with yours.\n\n");
		outputText("Pressing her hands into the hammock, you move your hips, clenching your pussy walls as tight as you can, pulling the dildo out of Belisa’s body, bit by little bit. Belisa moans, and you feel her surge up, burying the toy to the hilt in both of you again. The sudden motion, coupled with the surge of pleasure in your folds, forces you down, your weight pressing on Belisa. With a giggle, she gyrates her hips, moaning into your mouth. You sink into a slow, steady rhythm, your toy sending shocks of pleasure down your spine with each thrust.\n\n");
		outputText("Letting go of Belisa’s hands, you bring one hand to her cheek, cupping it in the palm of your hand. She smiles, gasping as you mash your hips together, and she brings her head up, latching onto your sensitive nipple and sucking on it, her two fangs indenting, but not piercing your [skin]. With her other hand, Belisa reaches down, tickling your inner thigh before she taps the Dildo teasingly with one finger. Belisa rubs your clit with one finger, poking, prodding and teasing your sensitive nub.\n\n");
		if (player.hasCock()) outputText("She brings her hand to your [cock]. <i>\"I wish this were in here…But it’s nice to see…even without it in me, you still…\"</i> She pumps your tool, her soft, slippery hand working your shaft. <i>\"Want to cum for me.\"</i>\n\n");
		outputText("Your back arches, and you feel Belisa pull you back down, her spider-legs holding you against her as she renews her attack on your cunt, ramming her hips into yours. You flick her dark-brown button, and as she moans, you take it with three fingers.\n\n");
		outputText("<i>\"[name]!\"</i> Belisa wails, her lower-half bucking, almost throwing you off. \"<i>[name], don’t stop!\"</i> Her spider-legs tighten around you, one chitin-covered limb running down the crack of your [ass]. You take one of her C-cups in your palm, slamming the dildo linking you and your Drider-lover home. Belisa wails even louder, closing her eyes. You feel the quivering of Belisa’s pussy, your lover spraying your [legs] and stomach with sticky, clear fluids.\n\n");
		outputText("Her orgasm, shaking the dildo inside you, brings you agonizingly close. Grinding your hips against hers, you bear down on Belisa, your well-fucked Drider’s eyes slightly crossing. <i>\"O-oh…Fuck me…I’m so…Please…!\"</i>\n\n");
		outputText("The spider leg in your asscrack tilts, and you feel a warm, but hard tip against the puckered entrance to your backdoor. As you lean in, tongues entwining, the cinnamon-taste of her saliva filling your mouth, you gasp, allowing Belisa to slowly sink her leg into your [ass]. She begins to move her limb inside you, in time with the Dildo.\n\n");
		outputText("The double penetration pushes you over the edge, your walls clamping down on the dildo. Your femcum trickles down the dildo, soaking your Drider-lover’s pelvis.\n\n");
		if (player.hasCock()) outputText("Belisa’s hand on your [cock] doesn’t stop, and as you come, spraying her stomach with your spooge, she aims it towards her chest, spreading your baby batter onto her breasts and stomach.\n\n");
		outputText(" Belisa’s spider-legs pull you back down, slathering your mixed juices onto your upper body, your breathy wail stopped by her loving lips.\n\n");
		outputText(" Now extremely sensitive, you shudder, forcing your shaking [legs] to work, pulling yourself up and off your shared toy. A rush of cool air seems to fill your now-empty cooter, making you shiver. Belisa, eyes closed and breathing still fast, lets the dildo hang from her love-canal as your bashful lover tries to catch her breath.\n\n");
		outputText("<i>\"W-wow…\"</i> Belisa moans, her folds finally letting go of the toy inside her. The dildo flops to the floor of her house, neither of you caring right now. <i>\"Th-that was…As good as last time.\"</i> Lying on top of her, your own pussy still dripping your love-juice, you’d be inclined to agree. <i>\"I mean…I had no idea sex would feel this good.\"</i> Your Drider lover kisses you on the cheek, chest heaving and eyes shining. <i>\"Thank you.\"</i> She wraps her arms around you, and you hug back, more than content to relax in the afterglow. Before you even realize it, your eyes are closing.\n\n");
		if (player.hasPerk(PerkLib.ElectrifiedDesire) || player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) player.orgasmRaijuStyle();
		else player.orgasm();
		doNext(BelisaAfterSex1);
	}
	
	public function BelisaAndTyrantia():void {
		clearOutput();
		outputText("You wake up to find a familiar figure standing over you. Her five working eyes and dick-shaped weapon give away who it is instantly. Tyrantia waves nervously as you get up. \"<i>Uh...Hey [name], Question...Where did that massive pile of silk on the water come from?</i>\" You tell Tyrantia that there’s a new member of the camp, a Drider. You tell Tyrantia that she’s way smaller than her, and Tyrantia grins a bit, flexing one massive bicep.\n\n");
		outputText("\"<i>Well, duh! Most Driders are pipsqueaks compared to me.</i>\" She looks down, nervous. \"<i>...Look, I know that my people aren’t pure anymore. I know that...Whoever you brought in is someone you can trust.</i>\" She inhales shakily. \"<i>I want to introduce myself, but...I’m not exactly cuddly, even to my kind.</i>\"\n\n");
		outputText("You tell Tyrantia that she’s very cuddly, and she blushes, scratching the back of her head. \"<i>You know what I mean, [name]. You gonna help me or not?</i>\"\n\n");
		outputText("Telling Tyrantia that it’s no big deal, and that you’d be happy to, if it makes things easier for her, you take the lead, going to the water’s edge. It’s still fairly early in the morning, but Belisa’s already up, working on a silk handkerchief.\n\n");
		outputText("\"<i>Oh, hey [name],</i>\" Belisa says, putting down her weaving. \"<i>What brings you to my home?</i>\" You explain to Belisa that someone special from the camp has come down to see her. You inform Belisa that she’s a little sensitive about herself, and that she asked you to come down to introduce her. Belisa stands, her back feet tapping the floor of her dwelling happily, and she smiles at you.\n\n");
		outputText("\"<i>Oh, how delightful!</i>\" She exclaims. \"<i>Is this person outside now? What’s their name?</i>\" You lead Belisa out of her dwelling, into the sun. You tell her that yes, they’re right here, and that you’d let your friend tell Belisa her name herself…\n\n");
		outputText("The two sisters stare at each other, shocked into silence by the sudden, unexplained appearance of the other. You somewhat smugly tell Belisa that you feel that introductions won’t really be necessary, though.\n\n");
		outputText("\"<i>...Tyrantia?!</i>\" Belisa almost tears up, slowly walking towards the much larger Drider. Tyrantia, for her part, is stunned into silence, falling to her knees in shock. Belisa walks up to her much larger sister, reaching up and removing the helmet from Tyrantia’s head.\n\n");
		outputText("\"<i>...Bicorn horns?</i>\" She puts a hand on her massive sister, eyes widening in shock. \"<i>Horse...Ears?</i>\" Tyrantia tries to pull back, but Belisa takes Tyrantia’s cheeks in her hands, her eyes wide. \"<i>Sister...It is you.</i>\" She pulls Tyrantia’s head into her chest, and the massive Drider begins to shake, wrapping her arms around her much smaller sister. \"<i>What did those bastards do to you?</i>\"\n\n");
		outputText("\"<i>...I don’t know.</i>\" The bigger Drider shakes, trying not to cry. \"<i>But...You weren’t caught, were you?</i>\" The giantess smiles slightly. \"<i>You always were the best of us, Belisa...And they didn’t get you.</i>\" She stands back up, towering over her sister. \"<i>So...I guess it was worth it, in the end.</i>\"\n\n");
		outputText("\"<i>Thank you, [name],</i>\" Belisa says to you, and Tyrantia shakes her head. \"<i>For reuniting me with my sister.</i>\"\n\n");
		outputText("\"<i>...Not gonna lie, I’m a bit pissed you didn’t tell me earlier.</i>\" Tyrantia adds, but she ruffles Belisa’s hair. \"<i>Like...You brought my little sis home, and…</i>\" She gives you a glare, but the way she holds her little sister takes most of the sting out of her eyes. \"<i>Did you fuck my sister?</i>\"\n\n");
		outputText("Belisa blushes at that, struggling in Tyrantia’s arms. \"<i>No! No we didn’t-why would you even-!</i>\"\n\n");
		outputText("You shake your head, telling Tyrantia that not everyone on Mareth is a fuck-monster. The big woman laughs at that, shrugging.\n\n");
		outputText("\"<i>Well, let’s move our stuff so we’re closer together.</i>\" The giant Drider says. \"<i>We’ve got a lot to talk about, lil sis. A lot of catching up to do.</i>\" Tyrantia lets out a little hum, head bobbing from side to side. \"<i>This means the world to me, [name], come by my hutch when we’re done, okay?</i>\"\n\n");
		BelisaEncounternum = 5;
		doNext(playerMenu);
	}
	
	public function BelisaConfession():void {
		clearOutput();
		outputText("You wake up to the sounds of struggle in your camp. Suddenly awake, you rush out of your "+(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "cabin":"tent")+", [weapon] drawn. The sounds of struggle seem to be coming from Belisa’s watery home, and you move quickly, rushing towards the sounds. When you see the cause, however, you stop in your tracks. Tyrantia is holding Belisa over her head, one arm holding her by three of her spider legs, and the other holding her upper body in place, her face smooshed into Tyrantia’s considerable bosom. Belisa struggles, but the giant Drider doesn’t really even need to try to keep her there as she walks towards the center of the camp. <i>\"Sister, no! Bad! Stop this at once, and put me down!\"</i> Belisa’s spider-half flails, kicking Tyrantia in the back, to no discernible effect.\n\n");
		outputText("<i>\"No. Not until you deal with your issues.\"</i> Tyrantia seems to be enjoying herself a bit much, clearly her much-smaller sister’s anger is something she’s dealt with before. <i>\"I’m taking you to-\"</i> Tyrantia sees you, her violet eyes lighting up. <i>\"I’m taking you to somewhere very close, and I promise you, it’s not where [name] sleeps.\"</i> She gives you a wink, adjusting her grip on Belisa’s Drider midsection, pinning three of her legs to her body.\n\n");
		outputText("<i>\"Oh, yeah right!\"</i> Belisa fires back. <i>\"I told you that in confidence, damn you!\"</i> She sinks her face deeper into Tyrantia’s top pair of breasts.\n\n");
		outputText("<i>\"And I told you that you won’t get what you want unless you go out and tell them!\"</i> Tyrantia stops right in front of you. <i>\"We’re here, sis...Stop biting my tit!\"</i> Belisa spits, whipping her head around as Tyrantia unceremoniously drops Belisa in front of you. <i>\"My idiot sister here has something she wants to tell you.\"</i> The giantess mumbles to herself, noting the gash on her bare tit. She rolls her eyes. Belisa gets her feet under her, and stands as Tyrantia turns and walks away. <i>\"You’ll thank me later, Belisa!\"</i> The much smaller Drider spits webbing at Tyrantia, who laughs, flipping Belisa off as she walks away.\n\n");
		outputText("Belisa turns toward you, finally realizing you’re right there. <i>\"I...um…\"</i> She refuses to meet your eyes, shivering at your gaze. <i>\"How much of that did you hear?\"</i> Not even waiting for a reaction, she brings her hands to her beet-red face, blushing furiously. <i>\"I...Tyrantia...What…?!\"</i> She begins skittering in a circle, hiding her face with her sunhat and fanning herself. <i>\"Why? Why, why, why would she do this? I’m not ready!\"</i>\n\n");
		menu();
		addButton(1, "SpeakUp", BelisaConfessSpeak);
		addButton(2, "Wait", BelisaConfessSilent);
	}
	public function BelisaConfessSpeak():void {
		clearOutput();
		outputText("You ask Belisa what’s wrong. Her skittering doesn’t slow down, and you step in, gently grabbing her wrists. She stops cold, letting out a little eep noise, turning her head away from you again.\n\n");
		outputText("<i>\"Nothing,\"</i> she whispers. <i>\"Nothing’s wrong, [name].\"</i> You can’t help but question this, and you ask the Drider-woman what’s bothering her, then. You ask her what she wanted to tell you.\n\n");
		outputText("<i>\"I didn’t want to tell you...But Tyrantia’s always been pushy.\"</i> She inhales shakily. <i>\"You’ve been really nice, [name]...and you even reunited me with my dear sister, who loves you...So...I didn’t want to say anything.\"</i>\n\n");
		outputText("You tell Belisa that she can tell you, that whatever it is, it can’t be that bad. You let go of her wrists, and cup her chin with one hand. Belisa smiles at the gesture, closing her eyes and rubbing her cheek into your palm.\n\n");
		outputText("<i>\"The truth is...I like you. I like you a lot, [name].\"</i> Belisa’s front legs rub together nervously, and she hugs herself, jaw quivering. <i>\"You’ve been really good to me, and...I don’t want to lose you.\"</i> She looks you in the eye, her repaired fang gleaming. <i>\"Thanks to you, I can smile again...In more ways than one...and…\"</i> She bobs from side to side, clearly nervous. <i>\"I ran from everything...I was able to stop them from...taking me.\"</i> She blushes, bringing her arms to her sides. <i>\"...I was...Hoping that you’d be my first...and that…\"</i> She wraps her arms around you, resting her forehead against yours. <i>\"I want you. Here, in this home you’ve made. I want you to...love me.\"</i> She’s clearly anxious about asking. How do you respond?\n\n");
		menu();
		addButton(1, "Yes", BelisaFirstTime);
		addButton(2, "No", BelisaRejected);
	}
	public function BelisaConfessSilent():void {
		clearOutput();
		outputText("With some amusement, you watch as Belisa skitters in circles, trying (and failing spectacularly) to hide her embarrassment. After getting a bit dizzy, her head bobbing to and fro, Belisa stalks over to a nearby tree, leaning on it for support. You watch her breathe heavily, a small smile on your [face]. She hides her face again with her sun hat, her little <i>\"Tk-tk-tk\"s</i> nervous and sporadic.\n\n");
		outputText("<i>\"Don’t look at me!\"</i> Belisa wails, hiding her face by smooshing it into a tree. <i>\"It’s not funny!\"</i> This finally cracks you up, and you start to snicker at the sight of this spider-girl, head buried in a tree, trying to hide. <i>\"[name]! Stop laughing!\"</i> This, of course, makes you laugh more. Finally more annoyed than anxious, Belisa turns toward you, her eyes wide and her lips drawn into a frown. Her fangs chitter against her bottom teeth, and she folds her arms, pouting at you.\n\n");
		outputText("After a little more laughter at the Drider-girl’s expense, you sober up, sitting down at the base of the tree. You pat the ground beside you for your Drider-friend, and she sits down, her back half still fidgeting like mad. You take one of her smooth, tender hands, and you apologize for laughing. You tell her that she’s cute when she’s so flustered, which of course, makes her blush again.\n\n");
		outputText("<i>\"I-you...Stop doing that. Stop making me…\"</i> She fidgets again, one hand at her waist, and you tilt your head, curious. You ask her what’s going on with her, and if she’s not enjoying it at your camp.\n\n");
		outputText("<i>\"N-no! That’s not it! That’s not it at all!\"</i> Belisa looks down at the grass. <i>\"...I missed this, I really did. The people here are kind, and seem strong as well. You weren’t kidding when you told me that your camp was a good place. I’ve settled in, and...I love it here.\"</i> She fidgets, her eyes now up towards the tree’s canopy. <i>\"[name], you’ve given me so much. My smile back, a home...even my big sister...When she ISN’T BEING A NOSY GOO-WEBBER!\"</i> She yells this at Tyrantia’s hut, then immediately tries to rein it in. <i>\"Sorry...But...This means a lot to me, and I’ve been…thinking about it for a while.\"</i>\n\n");
		outputText("You ask the Drider what she means by ‘this’.\n\n");
		outputText("<i>\"I...I want you to know...that I think about you. A lot.\"</i> She brings her front two legs together, her robe shaking a little. <i>\"Sometimes, when I shouldn’t be...When I’m working, or fishing...A part of me wishes you were there with me.\"</i>\n\n");
		outputText("At this point, you already know what she’s going to say, but you smile encouragingly, scooting a bit closer to her and running a hand along her Spider-half’s back. You ask her if there’s any...other times she finds herself thinking of you. Belisa’s pale cheeks turn bright red, and she closes her eyes. She nods, unable to look you in the eyes.\n\n");
		outputText("<i>\"D-do you feel the same way about me, [name]? Because...If you do...Then I…\"</i> She seems to find her courage, looking at you with eyes full of hope...and a bit of lust. <i>\"I want you, [name]. I want you to...lie with me, and hold me, and…\"</i> Her hand drops to her pussy, and she grunts, crossing her front legs in front of her. <i>\"...and you know what else.\"</i>\n\n");
		menu();
		addButton(1, "Yes", BelisaFirstTime);
		addButton(2, "No", BelisaRejected);
	}
	public function BelisaFirstTime():void {
		clearOutput();
		outputText("You smile, bringing your lips to Belisa’s. You run a hand through her jet-black hair, her saliva sweet on your tongue and her fangs cool against your open lips. You pull back, and you feel her gentle hand on the back of your head, pulling you back in. The spider-girl presses herself against your [chest], her silk robes the only thing stopping you from seeing her rock-hard nipples. She finally lets your head go, and you pull back, almost gasping for air. She takes a step back, out of your arms, her spider legs all leaving and tapping the ground seemingly at random.\n\n");
		outputText("<i>\"D-does that mean yes?\"</i> Belisa asks nervously. You nod once, getting a girlish squeal from the inexperienced Spider-girl. She brings her hands to her cheeks, holding them there, and you step in, wrapping one arm around her slender waist. Belisa blushes as you sneak a hand under her robe, rubbing the small of her back as she shivers, letting out little <i>tk-tk-tk-tk</i> noises.\n\n");
		outputText("<i>\"Uh...As much as I want this...You...Can we take this somewhere a bit more private?\"</i> You nod, and she takes your hand, walking off towards her little silk home. You gamely let her lead you in, and you smile, closing the silk and wood door-curtain behind you. Belisa wastes no time, pulling at two spools of silk ropes. To your astoundment, she pulls, revealing a thick silk-cotton sheet. She ties the ropes to the other side of the silky orb, and tosses a few fluffy objects up into the newly erected...Bed? Second Floor? It takes her only a few seconds, and she smiles at you. <i>\"W-well?\"</i> She shrugs her shoulders, trying to emphasise her cleavage, and she flicks her wrist, lighting her robe up and revealing that she’s not currently wearing anything under it.\n\n");
		outputText("Belisa’s womanly upper body is effectively bare, and you take it all in. Her dusky nipples are pert, and as she fidgets, her breasts bounce pleasantly. Her hourglass figure is less pronounced than some women across Mareth, but right above the spot where her smooth, pale skin gives way to warm-brown chitin, her blushing pussy is on clear display. Her gash is small, but already drooling little orbs of moisture. Belisa lets you get a nice, long look, but eventually the magic fades. Her cheeks are bright red, and she’s beginning to drool from her fanged mouth as well as she stares at your [breasts]. You realize that Belisa is entirely too horny to focus on White Magic right now, and the thought arouses you more than you thought it would.\n\n");
		BelisaConfessed = true;
		menu();
		addButton(1, "TakeCharge", BelisaFTTakeCharge);
		addButton(2, "Gentle", BelisaFTGentle);
	}
	public function BelisaRejected():void {
		clearOutput();
		outputText("You shake your head silently. Belisa looks down, fidgeting. You tell Belisa that you’re still trying to figure out what’s going on in Mareth, that you don’t want to pursue a relationship. You tell the Drider-girl that you don’t feel that way about her right now.\n\n");
		outputText("<i>\"O-oh...I guess I shouldn’t be that surprised.\"</i> Her eyes are wide, shining as if with unshed tears. <i>\"...If you...Need anything silk-wise, or...A band…\"</i> She hiccups, and turns her back on you. <i>\"I’ll be...Around.\"</i> Belisa runs back to her silk home before you can say anything else, and you watch as she closes the door behind her. Tyrantia sees this, looks up at you with some anger in her gaze, and goes into her own hutch.\n\n");
		BelisaAffection(-30);
		doNext(playerMenu);
	}
	public function BelisaFTTakeCharge():void {
		clearOutput();
		outputText("You smile a bit at your hopeless Drider lover, gently taking a hold of her robe, gently admonishing her. Belisa wraps her arms around you, making her little <i>\"tk-tk-tk\"</i> noise as you take the hem of her robe and pull it up and over her head. Struck by a mischievous thought, you pull the garment most of the way over her head, leaving enough to keep her blind. You wrap your arms around Belisa, keeping the garment over her eyes as you bring your lips to hers, forcing the Drider-girl’s mouth open with your [tongue] and ravaging her mouth. The response is immediate. Belisa moans into your mouth, grabbing the back of your head with one hand, and your waist with the other. Her C-cup breasts, unbound, smoosh into your [chest], the smooth, soft flesh a stark contrast to her rock-hard nipples.\n\n");
		outputText("You pull on one, getting a little gasp from Belisa, and as she flinches at the unfamiliar sensation, you drop your other hand down to her dripping wet gash. You sink a single finger into her, and as you do, her front two spider legs quiver, barely keeping her up. Pulling your head back from your passionate kiss, breathing heavily, you notice that your Drider lover already has her tongue out, her spinnerets in back twitching wildly. Belisa’s eyes are wide, and she blinks, getting a hold of herself now that you’ve stopped.\n\n");
		outputText("<i>\"Wh-why did you…?\"</i> Belisa sees that you’re still clothed, and she gasps, realizing that she hasn’t been undressing you. Blushing like mad, Belisa begins to return the favor, slowly stripping you of your [armor]. You remove the rest of your garments, tossing them carelessly to the side as you return to your lover’s embrace. Somehow, the two of you make it up the little rope hand and foot-holds to Belisa’s bed-hammock, and she lies down beside you. Belisa’s eyes drop to your genitals, her fangs dripping little bits of moisture. She shifts, making the bed move slightly as she drips with moisture.\n\n");
		outputText("<i>\"So...How do you want me…[name]?\"</i> Now that you’re here in her bed, Belisa seems more relaxed.\n\n");
		BelisaFTEnding();
	}
	public function BelisaFTGentle():void {
		clearOutput();
		outputText("Deciding to ease into things, you take a hold of her now opaque again robe, pulling it over her head slowly, tossing it to one side. Belisa blushes, embarrassed, but returns the favor, stripping you down and tossing your [armor] away. Now both naked, you slide one hand around her waist, laying your lips onto her belly as you slowly, sensually run your hands from her hips, up to her C-cup breasts, flicking her dusky nipple with one finger before bringing your hand back to the curve of her bubble-butt. As you work with your hands, Belisa tries to copy your movements, her soft fingers barely touching your [skin]. You make a trail of kisses up Belisa’s front, from her belly to her neck, reveling in the shivers you get from your inexperienced lover.\n\n");
		outputText("You lock lips with Belisa, tasting her sweet saliva, nicking her fangs with your [tongue] and tasting the vaguely bitter taste of her venom on the tip. As she kisses back, her hand on your [ass], you drop a finger to her quivering pussy, gently sliding a digit into her, tickling the inside rim of her lips. Belisa gasps, her folds dampening rapidly. You pull your hand back, showing her the clear, sticky fluid on your fingertips.\n\n");
		outputText("The two of you continue to kiss, caress and cuddle your way up to the hammock/bed, and once you lie down on the soft, slightly slippery thing, Belisa lies next to you, her spider legs splayed out and her human half enticingly right next to you, her soft, squeezable breasts under your chin.\n\n");
		outputText("<i>\"Mmm…\"</i> Belisa’s voice is high, and she guides your hand to her cunt. <i>\"You...Know what I want, right?\"</i> She runs a finger down your cheek, rubbing her folds against your leg. <i>\"Please, [name]. I want you to be my first.\"</i>\n\n");
		BelisaFTEnding();
	}
	public function BelisaFTEnding():void {
		if (player.gender == 0) {
			clearOutput();
			outputText("Belisa looks down hungrily between your legs, to see that there's nothing down there. She stares for a moment, utterly baffled at your lack of genitalia, before crossing her arms over her breasts, giving you an odd cross between a pout and a glare. <i>\"That's not fair!\"</i> She declares. <i>\"You got me all ready to go...and...You don't even...?!\"</i> Belisa opens the door, pointing for you to leave. <i>\"You are THE WORST!\"</i>\n\n");
			BelisaAffection(-10);
			doNext(playerMenu);
		}
		else {
			menu();
			if (player.hasCock()) addButton(1, "VirgFuck", BelisaVirginMFuck);
			if (player.hasVagina()) addButton(2, "LesSpood", BelisaVirginLesbian);
		}
	}
	public function BelisaVirginMFuck():void {
		clearOutput();
		outputText("You lean in, giving your Drider a peck on the cheek. She giggles as you take her shoulder, using it to help you keep your balance as you straddle her upper body. Now on her back, Belisa looks up into your eyes as you rub your [cockhead] along her entrance, teasing her folds. Belisa winces, but nods, and you slide about a half-inch inside her.\n\n");
		outputText("<i>\"It feels good,\"</i> she says, wincing again as you push a little further in. <i>\"Just go slow, please?\"</i> Belisa wriggles under you as you slowly, gently push your [cockhead] a few inches into her, the folds of her virgin pussy twitching, unused to the stimulation. Despite your gentleness, a bit of blood trickles from belisa’s quim. You watch her close her eyes and bite her lower lip, shaking slightly as she tries to capture every moment of her fleeting ‘first time’.\n\n");
		outputText("<b>YOU HAVE TAKEN BELISA’S VIRGINITY</b>\n\n");
		BelisaVirgin = false;
		outputText("Her groans of distress slowly give way to higher, more pleasurable sounds, and you kiss her on the mouth, drinking in the taste of her saliva, the quivering of her lips as she begins to move herself. For a time, you let her set the pace, her shallow breathing and gasps as you move ever so slightly, keeping you rock-hard within her. Slowly, but surely, as she begins to get more used to the feeling of your [cock] inside her, Belisa begins to pick up the pace.\n\n");
		outputText("You respond, moving your hips in time with Belisa’s, her tight folds wrapping like a soft vice around your girth. As well-lubricated as she is, your [cockhead] slides through her channel easily, making Belisa gasp every time you bottom out inside her.\n\n");
		outputText("You notice that her front legs, in the air, flex slightly every time you bottom out. You grab the middle of her chitin-covered appendages, using them for leverage as you slam your pelvis down into your Drider lover. Belisa’s tongue flops out of her mouth, and she lets out a moan.\n\n");
		outputText("<i>\"Yessss-tk-tk-tk! [Name], don’t stop!\"</i> You comply, pounding Belisa for all you’re worth as she wails, lost in the pleasure. <i>\"Nnh, Yes, Nnh, Yes!\"</i> You feel her pussy clamp down even harder on you. Belisa surges up, grabbing your shoulders and pulling you into a sloppy, passionate kiss as you continue to pound her pussy. Her chitin-covered arms dig into your back as she holds you close.\n\n");
		outputText("You can tell your Drider lover is right on the edge, her pussy walls flexing and her abdomen almost throwing you off of her as she convulses. You bring one hand down to her pussy, and as you bottom out, you let go of her legs, lay yourself across her upper body, and take her clit in two fingers, rolling them along the sensitive nub.\n\n");
		outputText("<i>\"YEEESSS!\"</i> She hisses, and the Drider’s walls clamp down hard, almost painfully on your shaft. You are doused in a veritable hose of sweet femcum, the clear fluid drenching the bed underneath you. You’re on the edge, but not quite there yourself, your [cock] aching for release. Now that she’s come, the Drider beneath you is extremely sensitive. Belisa’s screams of pleasure get even louder, and she wraps her front legs around you.\n\n");
		outputText("<i>\"Nh, [name]...Are you...gonna cum?\"</i> Belisa runs a hand along your back, and you can feel four more of her Drider legs wrap gently around you. <i>\"Please...cum for me?\"</i> You grab her hair along the back of her head, pulling her up to you and ravaging her mouth again. The moans, her soft breasts against you, and her kisses finally push you over the edge. You pull your head back, struggling to hold your orgasm.\n\n");
		outputText("<i>\"Cumming,\"</i> you warn, slamming your [cock] down to its base and grabbing your Drider-lover’s palmable ass cheeks.\n\n");
		outputText("<i>\"Me too!\"</i> Belisa cries out. You howl, your [cock] convulsing as you feel your balls pumping, spurting your seed into the Drider’s innermost parts. This sets off her own second orgasm, and the poor woman wraps all her legs around you, all but trapping you in place as you buck. Your orgasm lasts seemingly forever as you spurt load after load into her innermost depths.\n\n");
		outputText("When it finally ends, you collapse, your cheek resting on Belisa’s left breast. You feel the familiar, sticky warmth of your own cum dripping down your [leg], and you want to look down, to see Belisa’s pussy, dripping with your cum...But for the life of you, you can’t move.\n\n");
		outputText("Wrapped up in Belisa’s ten-limbed embrace, exhausted from your lovemaking, you slip into a comfortable, happy sleep.\n\n");
		outputText("You wake up to a familiar <i>\"Tk-tk-tk-tk\"</i> sound in your ear. You manage to open one eye, to see Belisa’s happy face beaming at you. You’re still inside her, your [cock] nice and warm in her slippery, now sticky love canal.\n\n");
		outputText("<i>\"You came inside,\"</i> Belisa says happily. <i>\"...I love you.\"</i> You stir, sliding your [cock] out of Belisa’s womb with a slight pop. This gets a full-body shudder from your Drider lover. You reposition yourself so that your head is level with Belisa’s, and she gives you a little giggle, kissing your nose.\n\n");
		outputText("You ask Belisa if she’s ready to be a mother, and she pats her belly, slightly swollen with your seed. She hugs you, her eyes shining.\n\n");
		outputText("<i>\"Honestly...I don’t know,\"</i> she admits breathily. <i>\"...But...If I was going to be a broodmother...I’d want them to be yours.\"</i> She blushes, seemingly embarrassed by that declaration. You smile, putting your palms on her cheeks. You tell her that if that’s what she wants, then you would be happy to make her dreams come true. You tell Belisa that there’s no need to be worried. That she can trust you, that you’ll be there for her.\n\n");
		outputText("<i>\"Aw...Thank you.\"</i> Belisa’s still a bit bashful, but she seems to appreciate the gesture. <i>\"I...Hate to ask something of you so soon...But can you do something for me, love?\"</i>\n\n");
		outputText("You ask her what it is. Belisa leans in, kisses you on the cheek, then whispers in your ear. <i>\"I want...To cuddle. Like, just...Lie here with me, hold me close. Can you do that?\"</i> Still tired from your lovemaking, you don’t respond, you just rest your head on her cheek, sighing tiredly as you drift off to sleep in each other’s arms.\n\n");
		BelisaAffection(10);
		DriderTown.BelisaPregnancy = 72;
		player.sexReward("vaginalFluids","Dick");
		doNext(BelisaAfterSex1);
	}
	public function BelisaVirginLesbian():void {
		clearOutput();
		outputText("Belisa looks down at your [pussy], somewhat confused. <i>\"I…I don’t know how this works…between girls.\"</i> She seems to be at a loss, and you chuckle, telling her that you do. You ask her to let you lead, and she nods, giving you a warm smile.\n\n");
		if (player.hasCock()) outputText("<i>\"Not to be...rude, [name], but...wouldn’t you rather use...your…?\"</i> She gently nudges your [cock]. You shake your head, and she looks at you, confused.\n\n");
		outputText("<i>\"Honestly...I never thought I’d be...doing it like this.\"</i> She admits. <i>\"I’ve never done this, so…\"</i> You give your bashful lover a reassuring smile, kissing her on the cheek. You assure her that you’ll be happy to teach her, which gets you a pouty look. <i>\"Please don’t remind me how much other experience you have.\"</i>\n\n");
		outputText("You shake your head, taking the lead. You lean in, locking lips with your spidery lover. She closes her large eyes, cheeks flushing red. You take that as a good sign, rubbing a hand up her girly hips, past her C-cup breasts. You tickle her neck, then bring that hand up to her cheek. Belisa’s eyes open, and she shudders, goosebumps forming where you touched her.\n\n");
		outputText("You look deep into Belisa’s eyes, rubbing her cheek with one hand. She pulls back from the kiss, chittering nervously. <i>\"I-is it always like this? If we’re…?\"</i> You ask her if she’s enjoying the moment, and she nods once.\n\n");
		outputText("You slowly move your other hand down, past her stomach, down to her hairless pussy. Still with one hand on her cheek, you rub her rock-hard clit with one finger. Belisa bites her lip, trying to hold her voice back, but as you bring more fingers in, playfully teasing her lips, sinking a fingernail into her, only to pull it back, you notice that your fingers are becoming slick. You tweak her clit, and Belisa moans, hips moving slightly. You smile, telling her not to hold her voice back,that it’s okay to let it out.\n\n");
		outputText("After a few minutes of teasing your Drider lover, you stop, her slick passage quivering. <i>\"Why did you...Stop?\"</i> Belisa asks, worried. <i>\"D-Did I-?\"</i> You assure her that nothing’s wrong, that she’s just nice and slick, and so she’s ready. You tell your little Drider girl that you don’t want her first time to hurt, after all.\n\n");
		outputText("Getting out of the Hammock for a second, you walk over to your bag, giving your lover a full view of your [ass]. Belisa blushes, but as you take a look over your shoulder, you notice that she’s watching, and she’s not just drooling from her cunt. Going to your bag, you take your deluxe dildo out, letting your [hips] sway as you rejoin your new lover in her hammock. She seems to realize it’s purpose immediately, and as you insert one end into your [pussy], she slides in, grabbing it with both hands and guiding it to her own hole. She gasps as it enters, and you give her a wicked little smile, grabbing her tight little ass with one hand as you buck your hips, burying the toy into both of you with one motion.\n\n");
		outputText("<b>YOU HAVE TAKEN BELISA’S VIRGINITY</b>\n\n");
		BelisaVirgin = false;
		outputText("Breathless, chest heaving at this sudden, new pleasure, Belisa’s wide eyes and open mouth make the perfect target. You pull her into you, pulling your hips back as you lock lips, closing your eyes as you force the dildo deep into your own pussy.\n\n");
		outputText("\"O-oh…My…\" Belisa shivers, and you can feel her spasm, shaking the Dildo lodged in your pussies and sending shivers of pleasure up your spine. Taking her hands, entwining her fingers with yours, you lean in, bending Belisa’s humanoid upper body over her spidery lower half. Now lovingly pinned, Belisa moans softly as you rest your [breasts] on hers, pushing past your combined chests to cover her mouth with yours.\n\n");
		outputText("Pressing her hands into the hammock, you move your hips, clenching your pussy walls as tight as you can, pulling the dildo out of Belisa’s body, bit by little bit. Belisa moans, and you feel her surge up, burying the toy to the hilt in both of you again. The sudden motion, coupled with the surge of pleasure in your folds, forces you down, your weight pressing on Belisa. With a giggle, she gyrates her hips, moaning into your mouth. You sink into a slow, steady rhythm, your toy sending shocks of pleasure down your spine with each thrust.\n\n");
		outputText("Letting go of Belisa’s hands, you bring one hand to her cheek, cupping it in the palm of your hand. She smiles, gasping as you mash your hips together, and she brings her head up, latching onto your sensitive nipple and sucking on it, her two fangs indenting, but not piercing your [skin]. With her other hand, Belisa reaches down, tickling your inner thigh before she taps the Dildo teasingly with one finger. Belisa rubs your clit with one finger, poking, prodding and teasing your sensitive nub.\n\n");
		if (player.hasCock()) outputText("She brings her hand to your [cock]. <i>\"I wish this were in here…But it’s nice to see…even without it in me, you still…\"</i> She pumps your tool, her soft, slippery hand working your shaft. <i>\"Want to cum for me.\"</i>\n\n");
		outputText("Your back arches, and you feel Belisa pull you back down, her spider-legs holding you against her as she renews her attack on your cunt, ramming her hips into yours. You flick her dark-brown button, and as she moans, you take it with three fingers.\n\n");
		outputText("<i>\"[name]!\"</i> Belisa wails, her lower-half bucking, almost throwing you off. <i>\"[name], don’t stop!\"</i> Her spider-legs tighten around you, one chitin-covered limb running down the crack of your [ass]. You take one of her C-cups in your palm, slamming the dildo linking you and your Drider-lover home. Belisa wails even louder, closing her eyes. You feel the quivering of Belisa’s pussy, your lover spraying your [legs] and stomach with sticky, clear fluids.\n\n");
		outputText("Her orgasm, shaking the dildo inside you, brings you agonizingly close. Grinding your hips against hers, you bear down on Belisa, your well-fucked Drider’s eyes slightly crossing. <i>\"O-oh…Fuck me…I’m so…Please…!\"</i>\n\n");
		outputText("The spider leg in your asscrack tilts, and you feel a warm, but hard tip against the puckered entrance to your backdoor. As you lean in, tongues entwining, the cinnamon-taste of her saliva filling your mouth, you gasp, allowing Belisa to slowly sink her leg into your [ass]. She begins to move her limb inside you, in time with the Dildo.\n\n");
		outputText("The double penetration pushes you over the edge, your walls clamping down on the dildo. Your femcum trickles down the dildo, soaking your Drider-lover’s pelvis.\n\n");
		if (player.hasCock()) outputText("Belisa’s hand on your [cock] doesn’t stop, and as you come, spraying her stomach with your spooge, she aims it towards her chest, spreading your baby batter onto her breasts and stomach.\n\n");
		outputText(" Belisa’s spider-legs pull you back down, slathering your mixed juices onto your upper body, your breathy wail stopped by her loving lips.\n\n");
		outputText(" Now extremely sensitive, you shudder, forcing your shaking [legs] to work, pulling yourself up and off your shared toy. A rush of cool air seems to fill your now-empty cooter, making you shiver. Belisa, eyes closed and breathing still fast, lets the dildo hang from her love-canal as your inexperienced lover tries to catch her breath.\n\n");
		outputText("<i>\"W-wow…\"</i> Belisa moans, her folds finally letting go of the toy inside her. The dildo flops to the floor of her house, neither of you caring right now. <i>\"Th-that was…Amazing.\"</i> Lying on top of her, your own pussy still dripping your love-juice, you’d be inclined to agree. <i>\"I mean…I had no idea sex would feel this good.\"</i> Your Drider lover kisses you on the cheek, chest heaving and eyes shining. <i>\"Thank you.\"</i> She wraps her arms around you, and you hug back, more than content to relax in the afterglow. Before you even realize it, your eyes are closing.\n\n");
		if (player.hasPerk(PerkLib.ElectrifiedDesire) || player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) player.orgasmRaijuStyle();
		else player.orgasm();
		doNext(BelisaAfterSex1);
	}

	public function BelisaAfterSex1(preg:Boolean = false):void {
		clearOutput();
		outputText("You wake up in the hammock, with Belisa’s face close to yours. She’s clearly awake, but she’s stock still, watching your eyes. You blink, asking Belisa if she was watching you sleep. This gets a blush, but she seems to be getting used to having you close to her. <i>\"Well…I couldn’t exactly do much else. You were asleep, and…You’re sleeping on a few of my legs.\"</i>\n\n");
		outputText("Now that you’re awake, you realize that, while your hips aren’t mashed together anymore, your body still rests on three of her chitin-covered spider legs. You reach out, tickling the end of one, which gets an involuntary giggle from Belisa.\n\n");
		outputText("<i>\"H-hey, stop that, I’m ticklish!\"</i> You give her a grin, then realize that you’ve been napping for quite some time. Gently, you remove yourself from Belisa’s cot, freeing your Drider lover. She twitches, trying to get some feeling back into her legs.\n\n");
		outputText("<i>\"I’m guessing you have to go now?\"</i> You give her a nod. You tell her that you have work you need to do. Belisa, still naked, body glistening with sweat and your combined love juices, looks you in the eyes, biting her lip. <i>\"Look…I know you’re capable…But stay safe.\"</i> Belisa notices you looking at her, and she sighs, covering her C-cups with one arm. \"You may be capable, powerful and all that…But…You’re still one person. Just…Come back to me.\"\n\n");
		outputText("You give Belisa a chaste kiss on the cheek, and as you get dressed, you tell Belisa that you’ll always return. No demon’s going to get the best of you. She shakes her head, but doesn’t say anything. You dress and come back, ruffling her long, black hair roughly. <i>\"Headpats for luck!\"</i> You yell, stopping just short of giving Belisa a noogie.\n\n");
		outputText("<i>\"H-hey!\"</i> She yells, and you laugh, tossing the door open and leaving back to camp. Belisa sticks her head out the door, then looks down, realizing she’s naked…and she almost joined you outside. <i>\"Eep!\"</i> She slams the door shut, and you head back to camp.\n\n");
		if (preg && DriderTown.BelisaPregnancy == 0 && rand(100) < chanceToFail()) DriderTown.BelisaPregnancy = 72;
		if (CoC.instance.inCombat) cleanupAfterCombat();
		doNext(camp.returnToCampUseOneHour);
	}
	public function BelisaAfterSex2():void {
		clearOutput();
		outputText("You wake, as usual, to find Belisa watching your sleeping face with interest, and as you open your eyes, she giggles, tapping your nose with one finger.\n\n");
		outputText("<i>\"Hello Sleepyhead,\"</i> Belisa says, singsong. <i>\"I was hoping you’d wake up soon.\"</i> You smile, taking her cheek with one hand. You ask her if she enjoyed herself, and Belisa chuckles, pointing around. Looking, you see mixtures of your love juices. Some on the floor, on the walls…Even some on the ceiling, dripping down towards Belisa’s face. She follows your gaze, looks up, and catches the falling droplet of your cum, licking her lips.\n\n");
		outputText("<i>\"You were amazing,\"</i> Belisa says happily. <i>\"...I love you.\"</i> You stir, sliding your [cock] out of Belisa’s womb with a slight pop. This gets a full-body shudder from your Drider lover. You reposition yourself so that your head is level with Belisa’s, and she gives you a little giggle, kissing your nose.\n\n");
		outputText("You ask Belisa if she’s ready to be a mother, and she pats her belly, slightly swollen with your seed. She hugs you, her eyes shining.\n\n");
		outputText("<i>\"Well...I mean, I wouldn’t mind at all. They’re yours, and more of you is a good thing.\"</i> She blushes, seemingly embarrassed by that declaration. You smile, putting your palms on her cheeks. You remind Belisa that they’d also be half her, which makes her smile.\n\n");
		outputText("You cuddle in the afterglow with your Drider lover, but after a while, you gently pull yourself from her arms.\n\n");
		outputText("<i>\"You’ve got to go, huh?\"</i> Belisa asks, somewhat saddened. <i>\"Come back soon, [name].\"</i>\n\n");
		if (DriderTown.BelisaPregnancy == 0 && rand(100) < chanceToFail()) DriderTown.BelisaPregnancy = 72;
		if (CoC.instance.inCombat) cleanupAfterCombat();
		doNext(camp.returnToCampUseOneHour);
	}
	
	private function chanceToFail():Number {
		var chance:Number = 10;
		chance += Math.min(player.cumQ() / 25,40);
		chance += Math.min(player.virilityQ() * 100, 50);
		return chance;
	}

	public function timeChange():Boolean {
		/*if (pregnancy.isPregnant) {
			pregnancy.pregnancyAdvance();
			if (pregnancy.incubation == 0) {
				BelisaEggLyaing();
				pregnancy.knockUpForce(); //Clear Pregnancy
				return true;
			}
		}*/
		return false;
	}

	public function timeChangeLarge():Boolean {
		return false;
	}
	}
}