/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Camp;
import classes.Scenes.NPCs.Lily;
import classes.internals.SaveableState;
	
	use namespace CoC;
	
	public class LilyFollower extends NPCAwareContent implements SaveableState
	{
		public static var LilyHairColor:String;
		public static var LilySkinTone:String;
		public static var LilyPierced:Boolean;

		public function stateObjectName():String {
			return "LilyFollower";
		}

		public function resetState():void {
			LilyHairColor = "";
			LilySkinTone = "";
			LilyPierced = false;
		}

		public function saveToObject():Object {
			return {
				"LilyHairColor": LilyHairColor,
				"LilySkinTone": LilySkinTone,
				"LilyPierced": LilyPierced
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				LilyHairColor = o["LilyHairColor"];
				LilySkinTone = o["LilySkinTone"];
				LilyPierced = o["LilyPierced"];
			} else {
				// loading from old save
				resetState();
			}
		}
		public function LilyFollower() 
		{
			Saves.registerSaveableState(this);
		}

public function lilyEncounter():void {
	spriteSelect(77);
	clearOutput();
	if (flags[kFLAGS.LILY_STATUS] == 1) {
		outputText("Bushwhacking your way through the dense foliage of the swamp, it soon becomes clear that you've wandered into spider territory.  Webbing hangs from trees and the dark, dank air hides ambushes well.  Diligence and wariness pay off, for you become aware of a skittering too near to be simple background noise.\n\n");
		outputText("As far as you're aware, it's unlikely you'll be able to scare your stalker off, and so you simply wait for them to show themselves.  You search with your eyes and, noisily clearing your throat, make it clear you're aware of their presence.  Soft chuckling chimes around you, seeming to originate from several places in the scrub, but nothing appears.  You turn about and call again, raising your [weapon].  A gentle tap on the shoulder answers you, but when you look the vista is equally as desolate as the first time.  And where the hell is that laughing coming from?\n\n");
		outputText("Spinning again, you lose your patience and loudly demand your ambusher present itself.  A soft tug on your ");
		if (player.tailType > Tail.NONE) outputText("tail ");
		else outputText("hair ");
		outputText("pulls you back halfway, but as you open your mouth to yell, the ground gives a quiet thump.  Just barely in your periphery, you see a white apparition with a yawning mouth stretching out to bite, and your reflexes take over, dropping your weight and rolling you away from it.\n\n");
		outputText("\"<i>Clever little pet,</i>\" the phantom spits, resolving into the shape of a drider as your eyes focus and your adrenaline haze clears.  Raising a cupped hand to her ghoulishly grinning mouth, she laughs into it; a minute shivering in the air reveals the taut threads of silk attached to her finger.  The vibrations travel down them, shaking several silk-tied leaves and producing the raspy, laughing audience from before.  \"<i>It'd be so much easier on you if you'd just walked into the trap, sweetness.</i>\"\n\n");
		outputText("You've yet to meet a wild drider that let you walk away without some sadistic display of power, and Lily looks to be no different.");
	}
	else {
		LilyHairColor = randomChoice("red", "orange", "green");
		LilySkinTone = randomChoice("yellow", "purple", "red", "turquoise");
		if (rand(2) == 0) LilyPierced = true;
		outputText("While you explore the swamp, the sun's light withers and fades.  You look up through the mossy trees, but the sky is totally blocked from sight.  It's nearly as purple as twilight here, but you press on, brushing aside old spider-webs as you go.  Faintly, you can hear the sound of skittering legs moving around you, but with the way the damp air muffles everything, it's impossible to tell from which direction.\n\n");
		outputText("You catch a blur of movement to the side, but by the time you turn for a better look, it's gone.  How odd.  Turning your eyes back to your path, you're shocked to see the form of a massive spider-woman in front of you.  She isn't just some humanoid spider-morph - she's a full-fledged drider, with a giant spider's body from the waist down and eight spindly legs supporting her.  Her eyes practically glow bright " + drider.skinTone + " while her venom-soaked lips twist into a cruel, confident smile.\n\n");
		outputText("\"<i>Lily is happy. I found you " + player.mf("master", "mistress") + ",</i>\" croons the drider.\n\n");
		outputText("Her tone makes it quite clear you'll have to run or fight your way out of this!");
		flags[kFLAGS.LILY_STATUS] = 1;
	}
	startCombat(new Lily());
	doNext(playerMenu);
}

	}
}