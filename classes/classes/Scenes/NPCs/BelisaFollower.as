/**
* ...
* @author ...Canadian Snas
*/
package classes.Scenes.NPCs 
{
import classes.*;
import classes.EventParser;
import classes.Globalflags.kFLAGS;
import classes.internal.SaveableState;

public class BelisaScene extends NPCAwareContent implements TimeAwareInterface implements SaveableState
	{
		public static var BelisaEncounternum:Number;
		public static var BelisaAffectionMeter:Number;
		public static var BelisaInGame:Boolean;
		public static var BelisaFollowerStage:Number;
		public static var BelisaVirgin:Boolean;
		public static var BelisaShopOpen:Boolean;
		public static var BelisaQuestOn:Boolean;
		public static var BelisaQuestComp:Boolean;
		public static var BelisaConfessed:Boolean;
		
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
			BelisaQuestComp = false;
			BelisaConfessed = false;
		}
		
		public function saveToObject():Object {
		return {
			"BelisaEncounternum": BelisaEncounternum,
		 	"BelisaAffectionMeter": BelisaAffectionMeter;
			"BelisaInGame": BelisaInGame;
			"BelisaFollowerStage": BelisaFollowerStage;
			"BelisaVirgin": BelisaVirgin;
			"BelisaQuestOn": BelisaQuestOn;
			"BelisaQuestComp": BelisaQuestComp;
			"BelisaConfessed": BelisaConfessed;
		};
	}
	
		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
			BelisaEncounternum = o["BelisaEncounternum"];
			BelisaAffectionMeter = o["BelisaAffectionMeter"];
			BelisaInGame = o["BelisaInGame"];
			BelisaVirgin = o["BelisaVirgin"];
			BelisaQuestOn= o["BelisaQuestOn"];
			BelisaQuestComp = o["BelisaQuestComp"];
			BelisaConfessed = o["BelisaConfessed"];
			} else {
				// loading from old save
				resetState();
				}
			}
			
			public function BelisaFollower()
			{
			Saves.registerSaveableState(this);
			}
			
`		public function BelisaAffection(changes:Number = 0):Number {
			BelisaAffectionMeter += changes;
			if (BelisaAffectionMeter > 100) BelisaAffectionMeter = 100;
			{
		public function firstEncounter():void {
		clearOutput();
		outputtext("You stride through the swamp. It seems to be quieter than normal. You think you hear the telltale hissing of a Drider, but nothing pops out at you. You check your feet, but there’s no web traps around you. Still, you’re in drider territory, and you put your back to a willow tree, holding your [weapon] ready.\n\n"); 
		outputtext("<i>“No!”<i> A curious brown and white blur flits between the trees, followed closely by several familiar, shiny black carapaces. <i>“Leave me alone!”<i> The voice is high-pitched and panicked. As it comes closer, you’re able to make more of her out. Like the driders, she has eight spider legs. Hers appear longer, but also much thinner. A pale, white fluid leaks from her ovipositor. 
\n\n");
outputtext("<i>“Oh, don’t be like that, precious,”<i> one of the driders replies, still chasing the brown. Her red eyes glow with sadistic glee. <i>“We’re just gonna take you home with us. Won’t it be nice?”<i>\n\n");
outputtext("<i>“Oh, yes”.<i> The second drider is more masculine, with a deeper voice and longer stride. <i>“Stay with us, it will be wonderf-”<i> He gasps. <i>“Don’t let her get to the water!”<i> 
outputtext("She jumps, almost directly over you. As she flies, you can see most of the way up her robe. Unlike her fellow driders, she seems to be wearing undergarments, and she doesn’t notice you until you’ve seen her underwear. She gasps, face turning red, before she hits the water, folding her lower body up and sinking like a rock into the murky water. The last thing you notice before she sinks below your visual range is her hat, inflated like a balloon. Her legs flail, and she vanishes, apparently swimming away under the water.\n\n");
outputtext("The two driders hiss, their toy lost, but they quickly catch sight of you.\n\n");
outputtext("<i>“I’ll find her”,<i> the second one growls, leaving the first. She turns to you with a sadistic grin.\n\n");
You are now fighting a Drider!\n\n");
startCombat(drider);
			}
		public function secondEncounter():void {
		clearoutput();
		outputtext("Your row on the lake is peaceful. For once, the water is calming and still. The wind’s no longer blowing, and the sky above is blue. As you gaze around, something catches your eye.  \n\n"); 
		outputtext("A bobbing, white orb sits on the surface of the water, out of place against the glassy surface. It shines, shedding droplets of water. It also appears to be slowly inflating, starting from the size of your boat and expanding outwards. Do you approach? \n\n"); 
 		menu();
		addButton(1, "Yes", secondEncounterApproach);
		addbutton(2, "No", secondEncounterNo);
		addbutton(3, "Never", secondEncounterNever);
 		}
		
		public function secondEncounterApproach():void {
		clearoutput();
		outputtext("You row closer to the odd orb, your curiosity overcoming your caution. On closer inspection, you realize you’ve seen this material before. This structure appears to be made entirely out of spider silk!  \n\n"); 
		outputtext("It’s still getting bigger, and as you stare, the structure inflates into the front of your boat, nudging it backwards. \n\n"); 
		outputtext("<i>“Eep!”<i> comes a muffled voice from inside the object. You hear a clattering noise from inside, like someone climbing a ladder. The object shudders, and a humanoid figure pokes out from the top. You can only see her upper body, and the silk she wears blends in with the orb. Her brown eyes stare down at you, wide. \n\n");
		outputtext("<i>“What do you want?”<i> She demands, her voice high and wavering. <i>“Wh-what are you doing here?”<i> Despite her demands, her arms shake. She has a dagger in her hand, and it’s pointed straight at you, but the hand holding it shakes. \n\n"); 
		menu();
		addButton(1, "Demons", secondEncounterYesDemons);
 		addbutton(2, "Curiosity", secondEncounterYesCuriosity);
 		addbutton(3, "Fishing", secondEncounterYesFishing);
		addbutton(4, "NoWorries", secondEncounterYesNoWorries):
		}
		
		public function secondEncounterYesDemons():void {
		outputtext("You puff out your chest, exclaiming that you are the champion of Ignam, and you were sent to rid the world of demons and corruption. At your exclamation, her brown eyes narrow. \n\n"); 
		outputtext("<i>“...Many have tried, ‘champion’”.<i> She picks at the left side of her mouth, then catches you looking, hiding her face behind her oversized hat. <i>“If you’re looking for demons, you won’t find any here, so just go away please.”<i>\n\n"); 
		menu();
		addbutton (1, "Leave", secondEncounterLeaveAlone);
		addbutton (2, "Nah", secondEncounterNahFight);
		}
		
		public function secondEncounterYesCuriosity():void {
		outputtext("You tell the girl that you just wanted to know what this giant ball in the lake was. She sighs. <i>“I made this. It’s my home."<i> She pouts a little, crossing her arms. <i>“Now can you please let me be?”<i>\n\n"); 
		menu();
		addbutton (1, "Leave", secondEncounterLeaveAlone);
		addbutton (2, "Nah", secondEncounterNahFight);
		}
		
		public function secondEncounterYesFishing():void {
		outputtext("You tell her that you were just out on the lake to catch some fish. At this, she sighs. The sphere wriggles, and a dead fish, head pierced with some kind of needle, is thrown into your boat. <i>“There, you have a fish.”<i> Her voice quivers, and she points towards the shore. <i>“Now please... just leave me alone.”<i>\n\n"); 
		menu();
		addbutton (1, "Leave", secondEncounterLeaveAlone);
		addbutton (2, "Nah", secondEncounterNahFight);
		}
		
		public function secondEncounterYesNoWorries():void {
		outputtext("You raise your hands, trying to assure her that you mean no harm. Her six eyes soften a little, but she points at the shore, lips quivering. <i>“Look...Just…”<i> She inhales shakily. <i>“Just leave me, please. I don’t know who you are.”<i>\n\n"); 
		menu();
		addbutton (1, "Leave", secondEncounterLeaveAlone);
		addbutton (2, "Nah", secondEncounterNahFight);
		}
		
		public function secondEncounterLeaveAlone():void {
		outputtext("You apologize for startling her, and turn your boat around. You blink, realizing you didn’t even get her name. You turn back and ask loudly what the Drider’s name is. As you row away, you can see the white orb sinking beneath the water’s surface. <i>“Belisa”,<i> you hear on the breeze. You see her eyes, and the ripple on the water as The Drider-No, <i>Belisa,<i> slips underneath the surface of the water, following her home down.\n\n");
		doNext(camp.returnToCampUseOneHour);
		}
		
		public function secondEncounterNahFight():void {
		outputtext("You grin at her, asking what the rush is. Surely just hanging around isn’t such a big deal, right? You barely finish your sentence before a dagger flashes by your face. Eyes wide, she emerges from her silky home. She’s shaking, but as she comes out revealing her Drider bottom half, complete with eight thin, chitin-covered legs legs and a slender, web-slinging thorax, the daggers in her hands are rock-steady, her lips drawn into a frown.  <i>“The Name’s B-Belisa. I don’t want to fight you…But you need to leave me alone!"<i>\n\n");
		startCombat(new Belisa());
		}
		
			public function secondEncounterNo():void {
			clearoutput();
		outputtext("After a few sidelong glances, you row away from the odd object, shrugging to yourself. This boat trip wasn’t productive, but oddities aren’t entirely unwelcome."\n\n");
		doNext(camp.returnToCampUseOneHour);
		}
		
		public function secondEncounterNever():void {
		clearoutput();
		outputtext("You’ve experienced enough of Mareth to leave curious objects alone. You vow to give this object a wide berth in the future."\n\n");
		(BelisaInGame = false)
		doNext(camp.returnToCampUseOneHour);
		}
		
		public function subsequentEncounters():void {
		
		outputtext("You’re walking along the lake shore, and a glimmer of white on the water’s surface catches your eye. You quickly realize that it’s Belisa’s silk orb. You walk over to the water’s edge, trying to catch a glimpse of the odd little Drider girl. \n\n"); 
		outputtext(" The angle of the water makes it awkward, but you’re able to catch a glimpse of her on the bottom of the lake. Catching hold of a small rock, you toss it into the water, watching as it sinks. \n\n"); 
		outputtext("The rock taps Belisa’s shoulder, and the drider-woman flinches, sending bubbles up to the surface of the water. She looks up, seeing you on the shore, and she nods. \n\n"); 
		BelisaAffectionMeter(5);
			if (BelisaAffectionMeter >= 10() {
		outputtext("<i>“H-Hello?”<i> She sees you, and swims slowly to the surface, poking her head up nervously. <i>“Wh-what do you want?”<i>\n\n");
			} 
			
		else if (BelisaAffectionMeter >= 20() {
		outputtext(" The Drider-girl looks up from the bottom of the lake, then swims up to the surface. She stays mostly underwater, but her shoulders are above the lake this time.\n\n"); 
			}
			
		else if (BelisaAffectionMeter >= 30() {
		outputtext(" Belisa, kicks off, ascending quickly to the surface of the water. She seems less nervous around you, and she steps onto the beach, shaking the water out of her hair. Her silken house bobs to the surface, but she doesn't seem to mind. <i>"So, what brings you here, [name]?" \n\n"); 
			}
			
		else if (BelisaAffectionMeter >= 40() {
		outputtext(" Upon seeing you, Belisa's eyes widen slightly, and you can see her spider legs quicken. She smiles up at you, waving with one hand before she kicks off. She breaches the surface with a slight splash, and she quickly walks towards you. <i>"Oh, hey!"<i> She walks up to you, still hiding half her face, but the eyes you can see seem bright. <i>"What brings you to my home?"<i> \n\n");
			}
			
		else if (BelisaAffectionMeter < 40() { 
		outputtext("She doesn't even look up as the rock taps her shoulder. Belisa rises from the water as quickly as she can, bringing her silken home with her to the surface, then practically runs over to where you stand. Eyes widening, she yelps, digging her front four legs into the sand. She barely skids herself to a stop around ten feet or so away. Her back legs are tapping, and the side of her face you can see is practically beaming already, her perky C-cup breasts dripping . It seems Belisa really missed you. She tilts her pale-skinned head to one side, questioning, but willing to wait for you to make the first move. \n\n");
			}
		
		if (BelisaAffectionMeter <=30) and (BelisaShopOpen = false);
		Belisa turns her back on you, holding out a finger. You wait for a few moments as she opens a curtainlike opening on her silky bubble-home, and she comes back with a few small boxes. <i>"I haven't found anyone I can trust in a while."<i> she explains. <i>"But you...seem like a decent person. You may not know what a manaweaver is...But the long and short of it is that I can make some enchanted items with my silk."<i> She blushes slightly, continuing in a chipper voice. <i>"I think, since you're out here as well, you could use my work as well. I can't just give these to you...But I would take gems for them"<i>\n\n");
		(BelisaShopOpen = true);
			}
		menu();
		addbutton (1, "Talk", BelisaTalk);
		addbutton (2, "Hang", BelisaHang);
		addbutton (3, "Shop", BelisaShop);
		}
		
		
		
		public function 
	}

}
