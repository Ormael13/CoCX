/**
* ...
* @author Canadian Snas
*/
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.UndergarmentLib;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;

	use namespace CoC;

	public class DriderTown extends NPCAwareContent implements SaveableState {
		public static var DriderTownComplete:Boolean;
		public static var SisterBangEnabled:Boolean;
		public static var BelisaKids:Number;
		public static var BelisaPregnancy:Number;
		public static var BelisaKidsEggs:Number;
		public static var BelisaKidsEggs1:Number;
		public static var BelisaKidsEggs2:Number;
		public static var BelisaKidsEggsHatching:Number;
		public static var BelisaKidsEggsHatching1:Number;
		public static var BelisaKidsEggsHatching2:Number;
		public static var LilyKidsPC:Number;
		public static var LilyKidsPCPregnancy:Number;
		public static var LilyKidsPCEggs:Number;
		public static var LilyKidsPCEggs1:Number;
		public static var LilyKidsPCEggs2:Number;
		public static var LilyKidsPCEggsHatching:Number;
		public static var LilyKidsPCEggsHatching1:Number;
		public static var LilyKidsPCEggsHatching2:Number;
		public static var LilyKidsIzma:Number;
		public static var LilyKidsIzmaPregnancy:Number;
		public static var LilyKidsSidone:Number;
		public static var LilyKidsSidonePregnancy:Number;
		public static var TyrantiaMaleKids:Number;
		public static var TyrantiaFemaleKids:Number;
		public static var TyrantiaPregnancy:Number;
		public static var TyrantiaKidsEggs:Number;
		public static var TyrantiaKidsEggs1:Number;
		public static var TyrantiaKidsEggs2:Number;
		public static var TyrantiaKidsEggsHatching:Number;
		public static var TyrantiaKidsEggsHatching1:Number;
		public static var TyrantiaKidsEggsHatching2:Number;

		public function stateObjectName():String {
			return "DriderTown";
		}

		public function resetState():void {
			DriderTownComplete = false;
			SisterBangEnabled = false;
			BelisaKids = 0;
			BelisaPregnancy = 0;
			BelisaKidsEggs = 0;
			BelisaKidsEggs1 = 0;
			BelisaKidsEggs2 = 0;
			BelisaKidsEggsHatching = 0;
			BelisaKidsEggsHatching1 = 0;
			BelisaKidsEggsHatching2 = 0;
			LilyKidsPC = 0;
			LilyKidsPCPregnancy = 0;
			LilyKidsPCEggs = 0;
			LilyKidsPCEggs1 = 0;
			LilyKidsPCEggs2 = 0;
			LilyKidsPCEggsHatching = 0;
			LilyKidsPCEggsHatching1 = 0;
			LilyKidsPCEggsHatching2 = 0;
			LilyKidsIzma = 0;
			LilyKidsIzmaPregnancy = 0;
			LilyKidsSidone = 0;
			LilyKidsSidonePregnancy = 0;
			TyrantiaMaleKids = 0;
			TyrantiaFemaleKids = 0;
			TyrantiaPregnancy = 0;
			TyrantiaKidsEggs = 0;
			TyrantiaKidsEggs1 = 0;
			TyrantiaKidsEggs2 = 0;
			TyrantiaKidsEggsHatching = 0;
			TyrantiaKidsEggsHatching1 = 0;
			TyrantiaKidsEggsHatching2 = 0;
		}

		public function saveToObject():Object {
			return {
				"DriderTownComplete": DriderTownComplete,
				"SisterBangEnabled": SisterBangEnabled,
				"BelisaKids": BelisaKids,
				"BelisaPregnancy": BelisaPregnancy,
				"BelisaKidsEggs": BelisaKidsEggs,
				"BelisaKidsEggs1": BelisaKidsEggs1,
				"BelisaKidsEggs2": BelisaKidsEggs2,
				"BelisaKidsEggsHatching": BelisaKidsEggsHatching,
				"BelisaKidsEggsHatching1": BelisaKidsEggsHatching1,
				"BelisaKidsEggsHatching2": BelisaKidsEggsHatching2,
				"LilyKidsPC": LilyKidsPC,
				"LilyKidsPCPregnancy": LilyKidsPCPregnancy,
				"LilyKidsPCEggs": LilyKidsPCEggs,
				"LilyKidsPCEggs1": LilyKidsPCEggs1,
				"LilyKidsPCEggs2": LilyKidsPCEggs2,
				"LilyKidsPCEggsHatching": LilyKidsPCEggsHatching,
				"LilyKidsPCEggsHatching1": LilyKidsPCEggsHatching1,
				"LilyKidsPCEggsHatching2": LilyKidsPCEggsHatching2,
				"LilyKidsIzma": LilyKidsIzma,
				"LilyKidsIzmaPregnancy": LilyKidsIzmaPregnancy,
				"LilyKidsSidone": LilyKidsSidone,
				"LilyKidsSidonePregnancy": LilyKidsSidonePregnancy,
				"TyrantiaMaleKids": TyrantiaMaleKids,
				"TyrantiaFemaleKids": TyrantiaFemaleKids,
				"TyrantiaPregnancy": TyrantiaPregnancy,
				"TyrantiaKidsEggs": TyrantiaKidsEggs,
				"TyrantiaKidsEggs1": TyrantiaKidsEggs1,
				"TyrantiaKidsEggs2": TyrantiaKidsEggs2,
				"TyrantiaKidsEggsHatching": TyrantiaKidsEggsHatching,
				"TyrantiaKidsEggsHatching1": TyrantiaKidsEggsHatching1,
				"TyrantiaKidsEggsHatching2": TyrantiaKidsEggsHatching2
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				DriderTownComplete = o ["DriderTownComplete"];
				SisterBangEnabled = o ["SisterBangEnabled"];
				BelisaKids = valueOr(o["BelisaKids"], 0);
				BelisaPregnancy = valueOr(o["BelisaPregnancy"], 0);
				BelisaKidsEggs = valueOr(o["BelisaKidsEggs"], 0);
				BelisaKidsEggs1 = valueOr(o["BelisaKidsEggs1"], 0);
				BelisaKidsEggs2 = valueOr(o["BelisaKidsEggs2"], 0);
				BelisaKidsEggsHatching = valueOr(o["BelisaKidsEggsHatching"], 0);
				BelisaKidsEggsHatching1 = valueOr(o["BelisaKidsEggsHatching1"], 0);
				BelisaKidsEggsHatching2 = valueOr(o["BelisaKidsEggsHatching2"], 0);
				LilyKidsPC = o ["LilyKidsPC"];
				LilyKidsPCPregnancy = o ["LilyKidsPCPregnancy"];
				LilyKidsPCEggs = valueOr(o["LilyKidsPCEggs"], 0);
				LilyKidsPCEggs1 = valueOr(o["LilyKidsPCEggs1"], 0);
				LilyKidsPCEggs2 = valueOr(o["LilyKidsPCEggs2"], 0);
				LilyKidsPCEggsHatching = valueOr(o["LilyKidsPCEggsHatching"], 0);
				LilyKidsPCEggsHatching1 = valueOr(o["LilyKidsPCEggsHatching1"], 0);
				LilyKidsPCEggsHatching2 = valueOr(o["LilyKidsPCEggsHatching2"], 0);
				LilyKidsIzma = o ["LilyKidsIzma"];
				LilyKidsIzmaPregnancy = o ["LilyKidsIzmaPregnancy"];
				LilyKidsSidone = o ["LilyKidsSidone"];
				LilyKidsSidonePregnancy = o ["LilyKidsSidonePregnancy"];
				TyrantiaMaleKids = valueOr(o["TyrantiaMaleKids"], 0);
				TyrantiaFemaleKids = valueOr(o["TyrantiaFemaleKids"], 0);
				TyrantiaPregnancy = valueOr(o["TyrantiaPregnancy"], 0);
				TyrantiaKidsEggs = valueOr(o["TyrantiaKidsEggs"], 0);
				TyrantiaKidsEggs1 = valueOr(o["TyrantiaKidsEggs1"], 0);
				TyrantiaKidsEggs2 = valueOr(o["TyrantiaKidsEggs2"], 0);
				TyrantiaKidsEggsHatching = valueOr(o["TyrantiaKidsEggsHatching"], 0);
				TyrantiaKidsEggsHatching1 = valueOr(o["TyrantiaKidsEggsHatching1"], 0);
				TyrantiaKidsEggsHatching2 = valueOr(o["TyrantiaKidsEggsHatching2"], 0);
			} else {
				// loading from old save
				resetState();
			}
		}

		public function DriderTown() {
			Saves.registerSaveableState(this);
		}

public function DriderTownEnter():void {
	clearOutput();
	outputText("The Stone Hutch, Treehouse and Watery Orb have been changed and expanded. The Stone hutch has large swathes of silk hung off it, connecting to poles stuck deep into the ground and creating a large covered pavilion around it. The extension is enclosed with wicker walls lined with stone. The treehouse hasn’t changed much, but there’s a rope bridge connecting the flat roof of Tyrantia’s hutch with the silken treehouse.\n\n");
	outputText("Belisa’s Orb appears at first glance to have been punctured and dragged to shore. The three dwellings are connected by strings of more spider silk, with odd, dangling lamps lighting up the connected houses. Gravel paths have been constructed between the three houses.\n\n");
	if (BelisaKidsEggs > 0 || BelisaKidsEggs1 > 0 || BelisaKidsEggs2 > 0 || TyrantiaKidsEggs > 0 || TyrantiaKidsEggs1 > 0 || TyrantiaKidsEggs2 > 0) outputText("Several egg-sacs are hung inside Tyrantia’s hutch, now a longhouse, and one of the Drider sisters is always on guard by the door.\n\n");
	if (BelisaKids > 0) outputText("Several small Drider-kids wander around their little complex, playing, weaving or play-fighting with the others. Belisa frequently looks over at the smaller Driders, a smile on her face as she watches them play. You currently have "+BelisaKids+" kids milling around.\n\n");
	if ((TyrantiaFemaleKids+TyrantiaMaleKids) > 0) {
		outputText("A small area near the middle of Drider-town has been turned into a meadow. Flowers seem to bloom at random, far faster than normal. Your children with Tyrantia seem to like this spot, gravitating towards it when not doing anything in particular. "+(TyrantiaFemaleKids+TyrantiaMaleKids)+" Uniriders play near or around the meadow. Just getting near this part of camp seems to invigorate your mind, and you feel cleaner of heart than you did before.\n\n");/*
	//if Pure Celess exists
	switch (rand(4)) {
  case 0:
    a // 25% chance
    break;
  case 1:
    b // 25% chance
    break;
  case 2:
    c // 25% chance
    break;
  case 3:
    outputText("Celess, to your surprise, is sitting down with a few of her Unirider half-siblings, brushing each-other’s hair as she explains to them the meaning of their horn, and their unicorn heritage. As she sees you, she smiles, waving at you. Several of your Unirider kids mimic her, with their front legs.\n\n");
    break;
	}*/
	}
	if (LilyKidsPC > 0) outputText("From her treehouse, Lily watches her spider-children at play. Some sit underneath the tree, reading, while others rush around the tree, throwing silk lines at each other.\n\n");
	menu();
	addButton(1, "Sisters", DriderTownSisters);
	//addButton(2, "Children", DriderTownKids);
	//only at night
	if (model.time.hours > 20 && BelisaFollower.BelisaAffectionMeter >= 100 && LilyFollower.LilyAffectionMeter >= 100 && TyrantiaFollower.TyrantiaAffectionMeter >= 100) {//
		if (SisterBangEnabled && player.hasCock()) {//remove later on req. to have cock
			if (player.gender > 0) addButton(3, "Bonding", FamilySex);
			else addButtonDisabled(3, "Bonding", "No bonding for genderless one.");
		}
		addButton(4, "Sleep w/Sisters", SpooderSleep);
	}
	else {
		addButtonDisabled(3, "???", "Req. max affection of all three sisters and only at night (9-11 pm)");
		addButtonDisabled(4, "???", "Req. max affection of all three sisters and only at night (9-11 pm)");
	}
	addButton(14, "Back", camp.campLoversMenu);
}//outputText("\"<i></i>\"\n\n");

public function DriderTownSisters():void {
	outputText("You decide to have a visit with one of your three lovely Driders. The only question is, which one?\n\n");
	menu();
	if (player.statusEffectv3(StatusEffects.CampSparingNpcsTimers5) > 0) addButtonDisabled(1, "Belisa", "Training.")
	else addButton(1, "Belisa", SceneLib.belisa.BelisaMainCampMenu);
	if (player.statusEffectv2(StatusEffects.CampSparingNpcsTimers5) > 0) addButtonDisabled(2, "Lily", "Training.")
	else addButton(2, "Lily", SceneLib.lily.LilyCampFollower);
	if (player.statusEffectv1(StatusEffects.CampSparingNpcsTimers5) > 0) addButtonDisabled(3, "Tyrantia", "Training.")
	else addButton(3, "Tyrantia", SceneLib.tyrantia.TyrantiaAtCamp);
	addButton(14, "Leave", camp.campLoversMenu);
}

public function BelisaBroodmotherMoment():void {
	clearOutput();
	outputText("As you head back into camp, you find Belisa waiting by your "+(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "cabin":"bedroll")+". Her front legs are rubbing together, and she’s twiddling her thumbs, clearly nervous about something.\n\n");
	outputText("You ask Belisa if there’s something wrong, and she snaps out of her reverie, finally noticing you. She walks over, barely using her front legs as they shake nervously.\n\n");
	outputText("\"<i>Well, the thing is…</i>\" She tears up a little, spreading her arms for a hug. You smile, wrapping your arms around your nervous lover. You hear a slight sloshing noise, and she blushes, burying her face in her hands. \"<i>I’m carrying eggs, and they’re yours.</i>\" Reassuring your emotional Drider, you tell her that it’s great news. You put a hand to her belly, asking her when they’ll come.\n\n");
	outputText("\"<i>Well...In a day or so. We’re not like most races, since our eggs aren’t as...intensive to make...Lily knows more about it than me.</i>\" She holds onto you tight. \"<i>But after the eggs are laid, there’s an incubation period. Usually it’s around ten days...And not all eggs are fertilized in each batch, too.</i>\" She nuzzles your [chest], inhaling deeply through her nose. \"<i>Would you mind...Just holding me for a bit?</i>\"\n\n");
	outputText("You nod, wrapping your arms around Belisa’s upper body, holding her close. The expectant broodmother lets out a little sigh. \"<i>Sorry, but...I needed that.</i>\" She walks back to her house, and you watch her, slightly concerned. At least the pregnancy won’t last long.\n\n");
	BelisaPregnancy -= 24;
	doNext(playerMenu);
	advanceMinutes(5);
}
public function BelisaEggLaying():void {
	clearOutput();
	var eggsB:Number = 4 + rand(3);
	outputText("You hear a gasp from around Belisa’s area of camp. You run over, to see your Drider lover squatting over a trough. You notice Tyrantia rushing over, and Belisa leans on her older sister, closing her eyes as her front legs shake.\n\n");
	outputText("\"<i>It’s okay, sis. Just push. Lean on me.</i>\" The much larger Drider folds her legs as Belisa begins to let out a shrill wail.\n\n");
	if (LilyFollower.LilyFollowerState) outputText("The middle sister comes over as fast as she can, positioning herself on the other side of the trough, holding her hands out. Belisa takes Lily’s hands, and the siblings lock eyes.\n\n");
	outputText("As you make your way over, you hear a sloshing sound, and Belisa pants for air as she pulls up her robe, revealing her sopping wet cunt, which shivers rapidly. With a groan, a single white orb widens her quim slightly as it exits, landing softly in the trough. You get to Belisa, and she locks eyes with you, sighing slightly in relief as you take her other side, you and Tyrantia both supporting Belisa as her legs shake.\n\n");
	outputText("Belisa lays "+(eggsB*2)+" eggs, and when she’s done, your Drider-lover slides to the ground. Tyrantia takes the trough, bringing it inside, and you wrap your arms around Belisa, whispering soothing words into her ears.\n\n");
	BelisaPregnancy = 0;
	if (BelisaKidsEggsHatching1 > 0) {
		BelisaKidsEggs2 = eggsB;
		BelisaKidsEggsHatching2 = 120;
	}
	else if (BelisaKidsEggsHatching > 0) {
		BelisaKidsEggs1 = eggsB;
		BelisaKidsEggsHatching1 = 120;
	}
	else {
		BelisaKidsEggs = eggsB;
		BelisaKidsEggsHatching = 120;
	}
	doNext(playerMenu);
	advanceMinutes(15);
}
public function BelisaEggsHatched():void {
	clearOutput();
	outputText("As you return to camp, you see Belisa waiting for you at your "+(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "Cabin":"Bedroll")+", with "+BelisaKidsEggs+" much smaller Driders around her. She beams at you, and brings them over. When your new Drider children realize who you are, they run over to you as fast as they can, covering you in chitinous limbs until Belisa laughs, pulling your children off you.\n\n");
	outputText("Tyrantia comes over, helping Belisa escort the young driders back to her hutch. She gives you a smile and a thumbs-up, before leaving you with Belisa.\n\n");
	outputText("\"<i>...Thank you.</i>\" She says simply, wrapping her arms around you. \"<i>They’re rambunctious…but I wouldn’t expect anything different from your kids.</i>\" You give her a mock-protest, but Belisa laughs, cutting you off with a sweet kiss on the lips. ");
	outputText("\"<i>I know you’re busy…But please come visit them, would you?</i>\" With that, Belisa catches sight of one of your new children rushing out from the hutch, with Tyrantia in hot pursuit. \"<i>Oh, shoot!</i>\" She cries, rushing off to corral your wayward spawn. Drider-town seems to be busier now.\n\n");
	if (BelisaKidsEggsHatching < 2) {
		BelisaKidsEggsHatching = 0;
		BelisaKids += BelisaKidsEggs;
		BelisaKidsEggs = 0;
	}
	if (BelisaKidsEggsHatching1 < 2) {
		BelisaKidsEggsHatching1 = 0;
		BelisaKids += BelisaKidsEggs1;
		BelisaKidsEggs1 = 0;
	}
	if (BelisaKidsEggsHatching2 < 2) {
		BelisaKidsEggsHatching2 = 0;
		BelisaKids += BelisaKidsEggs2;
		BelisaKidsEggs2 = 0;
	}
	doNext(playerMenu);
	advanceMinutes(15);
}

public function LilyEggLayingPC():void {
	clearOutput();
	var eggsL:Number = 3 + rand(4);
	outputText("As you return to camp, you can hear a muffled cry from Lily’s section of camp. You rush over to see your Drider-toy squatting over a silk net.\n\n");
	if (BelisaFollower.BelisaInCamp && TyrantiaFollower.isLover()) outputText("\"<i>Lily’s gonna lay her eggs.</i>\" Tyrantia calls. \"<i>Belisa, I’ve got her, you’ve got the net.</i>\" The two sisters move quickly, positioning her close to the net.\n\n");
	else if (BelisaFollower.BelisaInCamp) outputText("\"<i>You came just in time!</i>\" Belisa calls out. \"<i>She’s going to lay, any minute now!</i>\" She leans Lily against a tree. \"<i>Hold on, sis.</i>\"\n\n");
	else if (TyrantiaFollower.isLover()) outputText("\"<i>Good timing, [name]!</i>\" The giantess says. \"<i>Help me out, wouldya?</i>\" Lily leans on her larger sister, and groans, eyes opening and closing rapidly \"<i>It’s okay, sis. Hold in there.</i>\"\n\n");
	outputText("Lily moans, her hips shaking, and as you get closer, you can tell she’s going through contractions. She closes her eyes, gasping as her pussy gapes, revealing a slick, white orb. She moans, her lips closing, and the orb vanishing.\n\n");
	outputText("\"<i>...[name]…Can you…touch?</i>\" She points down to her cunt, and you nod, getting underneath her spider-half. You begin to pleasure her clit, massaging her pussy lips with your finger. Her pained moans subside, replaced with pleasure, and you’re rewarded with a soft <i>plop</i>, as her first egg lands gently in the net, ejected alongside some sticky femcum.\n\n");
	outputText("Once the first egg is out, the rest follow quickly. One after another, the pale orbs fall from your Drider-lover’s cunt. "+(eggsL*2)+" in total. Once the last one leaves, Lily’s legs begin to shake, and you’re barely able to get out from underneath her before she falls. You make sure Lily’s labored breathing slows, then bring your unhatched offspring to a nursery nook. You leave a kiss on your broodmother’s cheek, before heading back to camp.\n\n");
	LilyKidsPCPregnancy = 0;
	if (LilyKidsPCEggsHatching1 > 0) {
		LilyKidsPCEggs2 = eggsL;
		LilyKidsPCEggsHatching2 = 120;
	}
	else if (BelisaKidsEggsHatching > 0) {
		LilyKidsPCEggs1 = eggsL;
		LilyKidsPCEggsHatching1 = 120;
	}
	else {
		LilyKidsPCEggs = eggsL;
		LilyKidsPCEggsHatching = 120;
	}
	doNext(playerMenu);
	advanceMinutes(5);
}
public function LilyEggsHatchedPC():void {
	clearOutput();
	outputText("As you pass by Lily’s house, you suddenly feel a wet slap against your back. You turn around, to see a little Drider, purple eyes wide, looking up at you. Grinning, you reach down, scooping up the little one before you head over to Lily’s house.\n\n");
	outputText("Inside, you see several tiny little spiderlings running around the place, while Lily tries to calm them down. You laugh, picking one up as it tries to flee. Lily sees you, sighing in relief as she manages to corral your wayward spawn. Finally realizing who you are, one of the Driders climbs you, planting her tiny back half on the top of your head with a proud look on her pale face.\n\n");
	outputText("After a few minutes of play with your newborns, they curl up, closing their eyes. Lily, relieved, pulls them into a nursery nook.\n\n");
	outputText("\"<i>Too bad you missed them hatching…But thank you for the help.</i>\" She kisses you on the cheek, for once not acting like your submissive spider. \"<i>I love you.</i>\"\n\n");
	if (LilyKidsPCEggsHatching < 2) {
		LilyKidsPCEggsHatching = 0;
		LilyKidsPC += LilyKidsPCEggs;
		LilyKidsPCEggs = 0;
	}
	if (LilyKidsPCEggsHatching1 < 2) {
		LilyKidsPCEggsHatching1 = 0;
		LilyKidsPC += LilyKidsPCEggs1;
		LilyKidsPCEggs1 = 0;
	}
	if (LilyKidsPCEggsHatching2 < 2) {
		LilyKidsPCEggsHatching2 = 0;
		LilyKidsPC += LilyKidsPCEggs2;
		LilyKidsPCEggs2 = 0;
	}
	doNext(playerMenu);
	advanceMinutes(5);
}

public function TyrantiaBroodmotherMoment():void {
	clearOutput();
	outputText("You get back to camp, and you see your giantess lover. She stands near your "+(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 ? "cabin":"bedroll")+", and as she sees you, the giantess puts a hand on her slightly swollen belly.\n\n");
	outputText("<i>“Oh...Hey [name].”</i> She fidgets. <i>“Look...There’s something I need to tell you.”</i> She walks towards you, taking your hands and bringing them to her slightly swollen belly. <i>“I’m...My eggs were fertilized. By you.”</i> She blinks, wincing. <i>“Not that I would...You’re the only one I love, [name].”</i> She wraps her arms around you, hugging you close. <i>“Tomorrow, I’ll lay the eggs. Can you be there?”</i> You nod, and Tyrantia exhales, relieved.\n\n");
	outputText("<i>“I love you.”</i> She lets go of you, going back to her hutch. <i>“Even though you made it so I can’t fight for another day.”</i> She rubs the top of your head. <i>“Asshole.”</i> Her smile takes the sting entirely out of those words. You can tell that, despite everything, your Drider giantess is very happy.\n\n");
	TyrantiaPregnancy -= 24;
	doNext(playerMenu);
	advanceMinutes(5);
}
public function TyrantiaEggLaying():void {
	clearOutput();
	outputText("You hear an almost orgasmic moan coming from Tyrantia’s Hutch. You walk over, and inside the longhouse, Tyrantia’s standing over a trough made of wood and silk. The giantess’s cheeks are bright red, and seeing you, she waves you over.\n\n");
	outputText("<i>“The eggs are coming,”</i> she moans, and you ask her if there’s anything you can do. <i>“Just...Take my hand. It’ll be easier if I have something to hold onto.”</i> You nod, taking your giant lover’s hand. You rub her swollen belly, and Tyrantia groans, this time much more pleasurably. You hear a slight plop as a few silvery orbs fall from your Drider-girl’s leaking twat and into the trough. Speeding up your belly rubs, you try to hold Tyrantia steady as more eggs begin to fall, one or two at a time. On the other side of her, you see Lily rush over. Tyrantia wraps a fuzzy arm around Lily, leaning slightly on her younger sister as the eggs drop.\n\n");
	outputText("In a few minutes, it’s over. A dozen translucent orbs fill the trough. Tyrantia shudders, falling to her knees, and both you and Lily can’t hold the giantess up. <i>“I’ll put these in your nursery nook, sister,”</i> Lily soothes. <i>“You did a great job. They look healthy so far.”</i> Lily leaves you two alone, and you put a hand on Tyrantia’s cheek, telling her that she did great.\n\n");
	outputText("<i>“...Not done yet, [name],”</i> she says weakly. <i>“They need to grow, to hatch...to…”</i> Her eyes are closing, and you tell her that she just delivered. That she needs to rest. Tyrantia looks like she wants to protest, but Belisa walks in, putting a hand on Tyrantia’s shoulder.\n\n");
	outputText("<i>“Sister, [name] is right. Egg-laying is tiring. Close your eyes, dear sister. We’ll make sure nothing happens to your little ones.”</i> Belisa and Lily help Tyrantia stagger over to the bed, the giantess flopping face-down into it. Belisa and Lily give you warm smiles, Lily taking Tyrantia’s eggs while Belisa puts a hand on your shoulder.\n\n");
	outputText("<i>“We’ll make sure she rests.”</i> Belisa smiles. <i>“Do what you need to, sweet [name]. We’ll look after her.”</i> You nod, heading back to your part of camp.\n\n");
	TyrantiaPregnancy = 0;
	if (TyrantiaKidsEggsHatching1 > 0) {
		TyrantiaKidsEggs2 = (3 + rand(2));
		TyrantiaKidsEggsHatching2 = 120;
	}
	else if (TyrantiaKidsEggsHatching > 0) {
		TyrantiaKidsEggs1 = (3 + rand(2));
		TyrantiaKidsEggsHatching1 = 120;
	}
	else {
		TyrantiaKidsEggs = (3 + rand(2));
		TyrantiaKidsEggsHatching = 120;
	}
	doNext(playerMenu);
	advanceMinutes(15);
}
public function TyrantiaEggsHatched():void {
    var kidsHatched:int =
        (TyrantiaKidsEggsHatching == 1 ? TyrantiaKidsEggs : 0) +
        (TyrantiaKidsEggsHatching1 == 1 ? TyrantiaKidsEggs1 : 0) +
        (TyrantiaKidsEggsHatching2 == 1 ? TyrantiaKidsEggs2 : 0);
	clearOutput();
	outputText("You hear a worried cry from Dridertown. <i>“[name], [name]! Come quickly!”</i> Belisa runs over to you, taking your hand. <i>“Tyrantia’s in the egg nook right now. Your podlings are hatching!”</i> You follow Belisa’s lead, sprinting as fast as you can to be by Tyrantia’s side. Belisa leads you into the longhouse, then down a crude set of stairs into an underground, cave-like structure lined with little nooks and crannies. In the back, you see tyrantia, nervously standing over three eggs. There much less than before, but before you can ask, the giantess puts a finger over your mouth.\n\n");
	outputText("As you watch, one of the eggs begins to tear, a curved horn piercing it from the inside. Fluids drip from the egg, and a tiny head pokes out, horse-ears waggling. Unlike Tyrantia, this little one has white hair, and a single horn poking out. It pulls its spider legs out, one at a time, but quickly slips. Lunging forward, Tyrantia gently takes the newborn by the Drider-half, picking...her up. Her silk-spinners are covered in some sort of skin, and Tyrantia nods, assuring you that it’s normal for Driders to come out like that. Their spinnerets aren’t quite formed yet.\n\n");
	outputText("She looks at the horn and horse-ears nervously, but you put a hand on your lover’s shoulder, assuring her that as long as they’re not corrupt, it doesn’t matter. A second Drider-baby breaks through their egg, shocking both of you out of your thoughts. This time, you take charge, gently picking your newborn up and holding them in your arms. This one’s a male, and his six eyes look at you, wide-eyed and mouth open. You hold him for a moment, before Tyrantia holds out her hands for her baby boy. You oblige, and as soon as you pass him over, the baby latches onto Tyrantia’s teat, suckling for all he’s worth.\n\n");
	outputText("This Pod had "+TyrantiaKidsEggs+" drider babies. You help Tyrantia carry your newborns over to one of the cubbies built into the wall. She swaddles them in blankets made from Belisa’s silk, and you lay them to rest.\n\n");
	outputText("<i>“They won’t be like this for long,”</i> she says, clearly not liking that fact. <i>“But...They’re so beautiful.”</i> You agree, putting a hand on Tyrantia’s shoulder as you watch your babies go to sleep.\n\n");
	if (TyrantiaFollower.TyrantiaFollowerStage == 6) {
		outputText("You ask her about the rest of the eggs, and Tyrantia shrugs, a somewhat pained expression on her face. <i>“Oh, that’s normal.”</i> She shrugs. <i>“Not all eggs either get fertilized, something goes wrong, or they just got punctured on the way out. Three to Ten seems to be the norm for us. Honestly, I expected less than three...all things considered.”</i> You nod, happy that at least something is normal.\n\n");
		outputText("<i>“...They’ve only got one horn though.”</i> Tyrantia seems nervous. <i>“Did something go wrong?”</i> You assure her that no, nothing went wrong. You tell the nervous mother of your kids that if anything, that’s a great sign.\n\n");
		outputText("<i>“How so?”</i> She seems nervous. <i>“I would’ve thought no horns at all would be best.”</i> You shake your head, telling her that Unicorns are known for their purity. Who knows, if your kids really are part-unicorn, they might have an aura that’s the opposite of Tyrantia’s.\n\n");
		outputText("<i>“What, you mean like some sort of...Purity Aura?”</i> This seems to give her pause. <i>“...I hope you’re right. If you are, maybe I’m...Maybe...”</i> She seems to look at you and change her mind about what she’s saying. <i>“I love you.”</i> She hugs you tight, smiling at the little Uni-riders as they struggle with their swaddlings.\n\n");
		TyrantiaFollower.TyrantiaFollowerStage = 7;
	}
	TyrantiaFemaleKids += 1;
	TyrantiaMaleKids += 1;
	var kid3:Number = rand(2);
	if (kid3 == 0) TyrantiaFemaleKids += 1;
	else TyrantiaMaleKids += 1;
	if (TyrantiaKidsEggsHatching < 2) {
		if (TyrantiaKidsEggs == 4) {
			var kid4a:Number = rand(2);
			if (kid4a == 0) TyrantiaFemaleKids += 1;
			else TyrantiaMaleKids += 1;
		}
		TyrantiaKidsEggsHatching = 0;
		TyrantiaKidsEggs = 0;
	}
	if (TyrantiaKidsEggsHatching1 < 2) {
		if (TyrantiaKidsEggs1 == 4) {
			var kid4b:Number = rand(2);
			if (kid4b == 0) TyrantiaFemaleKids += 1;
			else TyrantiaMaleKids += 1;
		}
		TyrantiaKidsEggsHatching1 = 0;
		TyrantiaKidsEggs1 = 0;
	}
	if (TyrantiaKidsEggsHatching2 < 2) {
		if (TyrantiaKidsEggs2 == 4) {
			var kid4c:Number = rand(2);
			if (kid4c == 0) TyrantiaFemaleKids += 1;
			else TyrantiaMaleKids += 1;
		}
		TyrantiaKidsEggsHatching2 = 0;
		TyrantiaKidsEggs2 = 0;
	}
	doNext(playerMenu);
	advanceMinutes(15);
}

public function SpooderSleep():void {
	clearOutput();
	if (!SisterBangEnabled) {
		outputText("As you head into Dridertown, your eyes are drawn to the main building. You decide to head into the stone hutch, and you find your three Drider lovers winding down and readying themselves for bed. Belisa’s wearing her thin, almost sheer nightgown as she adjusts one of the odd, bioluminescent lamps, Lily’s removing the chains from her four puffy nipples, and Tyrantia’s busy with a massive bedlike structure in the back of the building. She tosses a thin cover over the odd thing, then moves to several lumps that you assume are pillows.\n\n");
		if ((BelisaKids+LilyKidsPC+TyrantiaFemaleKids+TyrantiaMaleKids) > 0) outputText("Several Driders are bustling in and out of various nooks in the building, and you notice that there’s a stone climbing wall to the left, leading underground. One of your Drider kids scuttles up to you, hugging you around the waist for a moment before scuttling off again, happier than before.\n\n");
		outputText("Belisa notices you first, smiling as she waves you over. You look around at the simple, but well-built longhouse, and comment that the three sisters have been busy. “<i>Well, yeah”</i>. Tyrantia finishes fluffing the pillows, joining you and Belisa near the center of the dwelling. “<i>We’re all living here, so...Why wouldn’t we build ourselves a proper longhouse?”</i>\n\n");
		outputText("“<i>Most Drider Tribes traditionally lived in dwellings like this one”</i>. Lily pipes up, rubbing her nipples gently. “<i>They typically were made from wood and silk, but some of the more prolific or stable tribes used stone. Normally, three Driders wouldn’t be able to do all this alone, but we have several advantages over the average historical Drider Tribe”</i>. She looks meaningfully at you, a smile on her face. Lily strides over, putting a hand on your cheek. “<i>What’s on your mind, [name]? Did you want me to...do something?”</i> She presses her breasts into your chest, running a hand along the side of your neck.\n\n");
		outputText("“<i>Hey!”</i> Belisa protests, shoving Lily away from you. “<i>If you’re so into being bossed around, how about you help with the damned silkwork for once?”</i>\n\n");
		outputText("Lily’s six eyes narrow, focusing on her little sister. “<i>Oh please sis, you hardly have the same...hng...Commanding presence that [name] has. Besides, I didn’t think you’d be into that”</i>. She brings one hand to her mouth in mock shock. “<i>How naughty”</i>.\n\n");
		outputText("“<i>Okay, that’s enough”</i>. Tyrantia gets in between her much smaller sisters, putting a hand on each of their foreheads and firmly pushing them back. “<i>Seriously? You two at it again? Besides, if either of you think you’re bringing [name] into the nook right now, and not me, then you’re dreaming”</i>.\n\n");
		outputText("As arousing as it is, having all three Drider ladies begin to argue over you, the look on Lily and Belisa’s face as they turn in towards Tyrantia gives you pause. Wanting to distract them, you blurt out, asking about the giant bed in the back.\n\n");
		outputText("“<i>Oh...that’s simple”</i>. Lily says, waving a hand at you dismissively. “<i>Drider Podlings often sleep together, and despite...Or maybe because...of our longtime separation, we’ve taken to honoring that tradition”</i>. She looks back at the bed, then at you, a lascivious smile forming on her face. “<i>Typically, nights would be split between their mates, and their Podlings, especially in younger relationships or with close siblings...But in some, rare cases, where Podlings shared a mate, the mate would be allowed to sleep with the siblings.”</i>\n\n");
		outputText("Both Belisa and Tyrantia stop, slowly look at Lily, then at each other. “<i>Holy shit, Lily. That’s a great idea!”</i> Tyrantia nods, tapping her back feet against the floor. “<i>I like it!”</i>\n\n");
		outputText("“<i>I-I’m not sure”</i>. Belisa crosses her arms, tapping her middle legs against the ground nervously. “<i>I’d love them to join us...But…”</i> She glares at Lily. “<i>If [name] is joining us in bed, you don’t get to hog them all to yourself.”</i>\n\n");
		outputText("“<i>Yeah, seconded on that.”</i> Tyrantia adds. “<i>If you’re getting lucky in the nest, then we’re all getting some.”</i> She gives you a wink. “<i>Assuming, of course, that [name] feels up to it.”</i>\n\n");
		outputText("Belisa yawns, flicking her wrists. “<i>Well, if you’re going to join us, for tonight, we’re just sleeping, okay?”</i> Tyrantia nods, and Lily pouts, looking at you, but eventually agrees.\n\n");
		SisterBangEnabled = true;
	}
	outputText("You decide to join your three Drider-babes in their nest-bed. Tyrantia lies down first on her back, looking up at you expectantly. You climb onto her, resting your head on her soft breasts. Belisa lies down on your right, taking your hand and resting her head on Tyrantia’s shoulder. She gives you a little kiss, hugging your arm, cuddling close as Tyrantia’s furry arm wraps around her. Belisa’s front legs entwine with Tyrantia’s, and you feel some of the smaller Drider’s legs drape over your [legs]. Belisa seems to like having you there, and she hugs your arm, smiling sleepily.\n\n");
	outputText("\"<i>Hmm...</i>\" Lily takes some more time, but lies down on the opposite side of Tyrantia. You feel Lily’s chitin-covered arm on your stomach, and several of her own spider-legs on your knees. Her soft, ample breasts are pressed up against your [breasts], and she rests her head between your shoulder and Tyrantia’s. The biggest Drider sister then pulls the thin cover over the four of you. It warms up surprisingly quickly, and the combination of ample titflesh as a pillow, the warm, furry arms and legs of your living bed, and the two lovely ladies on either side of you serve to calm your nerves. You close your [eyes], and you can feel all three of the Drider’s heartbeats.\n\n");
	outputText("Belisa’s breathing is the first to slow, leveling out as she nuzzles your shoulder in her sleep, her lips curled upward. Lily’s not far behind, leaving you and Tyrantia the only ones awake. The giant Drider smiles, ruffling your [hair] with one hand.\n\n");
	outputText("\"<i>I got you, [name],</i>\" whispers the giantess, before her five violet eyes close, her giant arms tightening slightly around you and your sleeping companions. Tyrantia’s pillowy breasts are warm, and you quickly fall asleep, safe in the company of your Drider lovers.\n\n");
	camp.cheatSleepUntilMorning();
	outputText("You wake up, your right side feeling awfully light. You open your eyes, and sure enough, Belisa is already awake, knitting something on the other side of the longhouse. Underneath you, Tyrantia snores, and on your left, Lily is curled up still, a smile on her sleeping face.\n\n");
	outputText("You wriggle out from your spider-lover’s embrace, and Belisa smiles, waving you over. You give the smallest of the Drider triplets a kiss on the cheek before dressing and exiting the longhouse. It’s a new day in Mareth, and you feel energized.\n\n");
	doNext(playerMenu);
}

public function FamilySex():void {
	clearOutput();
	outputText("You turn to your three lovely ladies, giving each one a short kiss on the lips. You ask the Drider siblings if they’re up to have a little bit of fun before bedtime.\n\n");
	outputText("Tyrantia grins, looking at you, and then her smaller sisters. “<i>Oh, hell yes!”</i>\n\n");
	outputText("“<i>Any time you want, I’m yours, [master].”</i> Lily pulls on her chain, rubbing her lower lips with one hand.\n\n");
	outputText("Belisa takes a little longer to answer, so you come back to her, rubbing her cheek. You tell the youngest Drider that you want her to have fun too. You drop a hand to her cunt, rubbing the rim of her labia as you stare into her eyes. “<i>mm...Okay.”</i> Belisa agrees, somewhat reluctantly.\n\n");
	menu();
	addButton(1, "Fuck", SpooderBang).disableIf(!player.hasCock(), "Req. a cock!");
	addButton(2, "TriFuckta", TriFuckta).disableIf(player.cockTotal() < 3, "Req. at least 3 cocks.");
	addButton(3, "LesSpood", LesSpood).disableIf(!player.hasVagina(), "Req. a vagina!");
}
public function SpooderBang():void {
	clearOutput();
	outputText("You ask your Drider-ladies if they would kindly disrobe. You turn to Lily, rolling your eyes, and make it an order. Tyrantia grins lecherously, sliding her armor off and letting it clang to the stone floor. Lily chuckles, seeing as she’s already naked, and you walk up to Belisa, who’s front legs are together, rubbing nervously. You smile reassuringly at the more bashful of your lovers, and gently pull her robe up her shoulders, tossing it behind her. ");
	outputText("Her scaled underwear follows, until all three of your spidery women are naked.\n\n"+(!player.upperGarment.isNothing?"Tyrantia and Lily saunter up to you, the giantess taking your [uppergarment], sliding it over your head and chucking it to one side.\n\n":"")+"");
	if (!player.lowerGarment.isNothing) outputText("Lily goes to work on your downstairs, pulling your [lowergarment] down and away.\n\n");
	else outputText("Lily, ever eager, wraps her hands around your [cock], lowering her head to your crotch and wrapping her lips around your tip. She pumps you a few times, then straightens back up, licking her lips.\n\n");
	outputText("“<i>So...Who’s first?”</i> your giantess asks slyly. All three of your spider-lovers look at each other, Lily and Tyrantia giving each other a conspiratorial grin. The larger Driders each take one of Belisa’s arms, bringing her over. Belisa squeaks in protest, but as she gets closer to you, she begins to drool from both her mouth and cunt, her gaze firmly fixed on your [cock].\n\n");
	outputText("“<i>I think our little sister should get the fun first.”</i> Lily says, her voice sweet and loving. Belisa needs no further encouragement, taking the last few steps into your arms. You waste no time, grabbing each of Belisa’s soft asscheeks, kneading her as you rub your [cock] along the folds of her Drider pussy. Belisa whimpers, hips trembling, her nipples hard against your chest. You slowly insert your [cock], pushing her folds aside. Your [cockhead] sinks about halfway in before Belisa herself pushes her hips forward, sinking you balls-deep into her.\n\n");
	outputText("Slowly fucking your bashful lover, you notice Lily and Tyrantia grinning as they move. Tyrantia walks behind you, and her fuzzy arms begin playing with your back end. As you pull out, she slaps your ass, hard. You sink back in, far faster than you intended, getting a high moan from your water-spider.\n\n");
	outputText("Lily grins at you, rubbing Belisa’s sensitive spinnerets. The smaller Drider blushes bright red, eyes wide, but you smile, nibbling her neck as you slowly pick up the pace. Behind you, you can feel smooth, soft skin on your back, and she begins to rub a slimy, warm fluid onto you. You feel a firm nub of flesh jut out, coupled with a groan from Tyrantia. More warmth drips from her onto you, the sugary scent turning you on even more. You remove one hand from Belisa’s fine ass, rubbing her clit. Your Drider’s front legs shake, and she wraps her arms around you, leaning on you to stay upright against this onslaught of pleasure.\n\n");
	outputText("You sink balls-deep into Belisa, and hold onto the Drider-girl’s ass as you pick up the pace, pistoning into her tight, fleshy chasm. Her moans intensify, until she sinks her teeth into your shoulder. You can feel a slight pinch of pain, her aphrodisiac venom kicking in as Belisa finally starts moving her hips in time with yours. Her cries, muffled as they are, are nonetheless arousing. At your back, Tyrantia rubs her pussy on your shoulder, still drooling clear, musky fluids onto you.\n\n");
	outputText("You’re finally on the edge, your balls aching, your cock twitching. Lily smiles sadistically, sticking her finger deep into Belisa’s silk-hole. Your drider lover pulls her fangs out of your shoulder, wailing as she arches her back, her pussy clamping down like a vice. Despite this, you piston in and out a few more times, getting even louder cries. Belisa looks towards the roof, her tongue out and drool leaking from both sides of her mouth. Wanting to prolong the moment, you fight, your knees almost buckling, [cock] spasming inside Belisa’s soaking depths.\n\n");
	outputText("You feel a thick, warm finger at the entrance to your backdoor. Before you can protest, Tyrantia sticks a finger into your asshole, scratching at your prostate. This easily pushes you over the edge, and as Belisa collapses against you, you hold on, spurting your seed into her innermost depths. One spurt after another, you paint Belisa’s womb white. Exhausted, her eyes close, and Belisa’s Drider legs fold inwards.\n\n");
	outputText("Knowing you can’t hold her up, the two larger sisters help you carry Belisa over to the nest-bed. You kiss her forehead, and then turn back to the larger two. “<i>I’m next.”</i> Tyrantia says simply. “<i>If you’re okay with that, lover.”</i> You nod, and Tyrantia gives you a warm smile.\n\n");
	outputText("“<i>Follow our lead please, [master]”</i>, Lily says. “<i>We’ll make you feel so good.”</i> Tyrantia pushes you back into Lily’s embrace. Lily gets her two front legs underneath you, her second pair coming forward and wrapping around your pelvis. She leans you back into her pillowy breasts, making a sort of erotic chair for you. She giggles, licking Tyrantia’s juices off your back and smacking her lips at the flavor.\n\n");
	outputText("“<i>Your throne, [master].”</i> Lily hums, kissing the back of your neck. She massages your calves as Tyrantia looms over the pair of you. She takes her time, spreading her pussy wide, lowering herself onto you until your [cockhead] is rubbing against her folds.\n\n");
	outputText("“<i>Come here, you.”</i> This warm, loving tone of voice still seems weird coming from such an imposing figure, but the affection in it still makes your heart skip a beat. Tyrantia lowers herself onto you, taking your entire length in easily. She leans in, wrapping her warm, fuzzy arms around you and Lily’s upper body, getting a little gasp from your loveseat. This effectively pins you between eight massive, soft pillows of titflesh, while your Drider lovers play with your body.\n\n");
	outputText("Lily’s touch on your [legs] is mischievous, tickling and teasing your inner thighs, rubbing your flanks, and teasingly running a hand along the crack of your ass, prodding your backdoor. Tyrantia moves her hips, slow and steady, keeping eye contact with you the entire time. Her eyes are full of affection, and as she leans down, she whispers to you.\n\n");
	outputText("“<i>Kiss me.”</i> You find no reason to deny her, and you lean your head in, locking lips with your giantess. Like the fuck, this kiss is slow, gentle. Her pussy tightens as you lock lips, and you drop one hand to her crotch, rubbing a finger teasingly along her lips, always stopping right next to her swollen nub. “<i>Always teasing me”</i>, she says, her eyes smouldering. “<i>Naughty lover, you.”</i>\n\n");
	outputText("“<i>Why must you tease my poor big sister?”</i> This a simpering whisper from Lily. She kisses the back of your neck. “<i>All she wants is your love.”</i> Your [cock] stiffens inside her, and Lily teases your neck with her fangs. “<i>Aren’t you going to give her your love?”</i>\n\n");
	outputText("Tyrantia gives you a pout, and you take her clit in three fingers, massaging the sensitive button as you buck your hips. She smiles, her massive palm now on your cheek. You take one of her tits in your hand, pulling her nipple. She hums, slamming herself down onto your shaft, your pelvises mashing together. Tyrantia pulls you into a passionate kiss, her walls tightening on you again. Breathless, moaning through the kiss, inhaling deep and fast, your world shrinks to your cage of titflesh, your passionate spider-lovers, and your heartbeats, your burning flesh.\n\n");
	outputText("Your orgasm takes you by surprise, your [cock] spasming at the same time as her walls. Tyrantia wails into your mouth, ravaging your lips as her bucking keeps pulling her lips from yours, then back in with abandon. Your baby batter spurts into Tyrantia’s womb, and your muscles relax as Tyrantia pulls back, patting her stomach. “<i>Damn...That was…”</i> She smiles, resting her upper half against a wall. “<i>You’re good, love.”</i>\n\n");
	outputText("Lily gently turns you around, and she looks at you expectantly, her eyes lighting up. You shake your head, telling her that she’s been a good little slut so far. You ask her if she wants her reward now, which gets a nod, her Spider-half bobbing from side to side.\n\n");
	outputText("Giving yourself a little time to recover, you tell Lily to make you some rope. Lily squeals with excitement, and you pause for a minute, thinking about what sort of reward Lily deserves. A few minutes later, you have several bundles of silk ropes. You ask Lily if she really just used all her silk for this, and she blushes sheepishly, nodding. Well, she’s got her priorities, you suppose.\n\n");
	outputText("You start with Lily’s arms, like usual. You then bind her front four legs to her undercarriage, then twist the ropes together. Tossing them over a support beam, you pull Lily part way off the ground, so only her back four legs are touching the ground. Finally ready, you give Tyrantia a wink, turning your back and flicking your eyes towards Tyrantia’s Dick, where it sits near the entrance. She grins, nodding, and you turn back to your Drider-toy, who sits there, red-cheeked and wiggling, her pussy lips swollen.\n\n");
	outputText("You take Lily’s front legs in your hands, massaging the chitin, teasing your love-toy further. You get into her face, paddling her breasts back and forth as you stare into her eyes, unblinking. As you distract Lily, Tyrantia moves, surprisingly silent for such a large woman, and takes her Dick in both hands.\n\n");
	outputText("You line your [cock] up, teasing her lower lips. Lily’s breathing gets faster, and you slide your [cock] into her dripping wet pussy. Lily gasps, saliva dripping from her fangs as you pinch two of her quad nipples, twisting them slowly. She wriggles in her bindings, and you pull back, rocking your hips into Lily’s. You reach around, grabbing hold of her firm asscheeks, spreading them wide. Behind Lily, Tyrantia grins, her Dick lining up with Lily’s tight pucker. You rock your hips forward, slapping your pelvis into hers with increasing force. Lily moans, getting into it, slamming her hips into yours.\n\n");
	outputText("Without warning, Tyrantia leans in, the head of her Dick sliding into Lily’s well-fucked asshole. Lily squeals, her tongue lolling out of her mouth. You feel her slick walls close tighter around you. You let go of your Drider-toy’s asscheeks, letting them clap together around the wooden shaft buried into her tight pucker. Tyrantia grins, stepping over Lily’s back and leaning over, whispering into Lily’s ear.\n\n");
	outputText("“<i>Oh, sister, you didn’t think I’d be satisfied with just [name] over there, did you? No. I’m happy we met [name]. "+player.mf("He","She")+" reunited us with our family, and I for one, love getting to know my little subby-sis better.”</i> Tyrantia twists her Dick sharply, getting another little squeal from Lily.\n\n");
	outputText("“<i>[master], my big sis is being...ugh! Mean to me. Mmm...Stop her, please?”</i> You grin wickedly, telling Lily that she’s enjoying herself too much to be complaining. Slowing the tempo down, you tell your love-toy that she’s enjoying these dicks too much.\n\n");
	outputText("“<i>I...am not!”</i> Lily protests, getting another hard slam from behind. Her pussy tightens up on you, almost painfully, and your lower body is splattered with sugary femcum. Lily bites down her orgasmic wail, but she still bucks, her walls sloppily milking your [cock]. You ride out her orgasm, smirking as you rub her black clit with one finger.\n\n");
	outputText("“<i>If you’re not enjoying these dicks, then why’d you just cum, sis?”</i> Tyrantia asks slyly. “<i>And did you just tell your [master] that you don’t like their [cock]?”</i>\n\n");
	outputText("Lily wiggles in her bondage, many eyes wide. “<i>N-no I didn’t!”</i> She bites her lip as Tyrantia pulls her Dick mostly out of her tight backdoor, groaning as the much-stronger Drider begins pushing it back in. “<i>I said I didn’t like your-mmph! Crude imitation of [master]’s glorious-”</i> She notices as you stop. “<i>[Master]...Why did you stop?”</i> She tries to buck her hips, riding you. “<i>Master, I...Why?”</i>\n\n");
	outputText("You tell your toy that she’s lying to you, and that bad girls get punished. Lily begins to panic, and you shush her. You tell her that she’s going to be a good girl. You pull your [cock] halfway out.\n\n");
	outputText("You tell Lily that she’s going to play nice with her big sister. Tyrantia gets the hint, slamming her dick into Lily as far as it’ll go. Lily bucks, trying to get your [cock] deeper into her drenched pussy. Tyrantia slaps Lily’s ass hard with her front leg, sending the flesh jiggling as she begins a slow, deep cycle, pulling her Dick out almost to the tip before plunging it again into Lily’s asshole.\n\n");
	outputText("“<i>Sis, are you enjoying yourself yet?”</i> Tyrantia asks smugly, nibbling at Lily’s shoulder. “<i>N-no!”</i> Lily’s blushing though, and she shivers with each thrust. “<i>Your d-dick isn’t nice at a-all!”</i> Her arms are scrabbling at their bindings, and she looks down at your [cock], her eyes wide.\n\n");
	outputText("You pull at Lily’s chain, getting a tortured groan from your sex-toy. You pull your [cock] slightly out, and Lily bucks her hips, trying to keep you inside her. You remind Lily that bad girls don’t get what they want.\n\n");
	outputText("Tyrantia chuckles, running a leg along the backside of Lily’s spider half. As Tyrantia touches the rim of her spinnerets, Lily shivers, her upper body drooping. “<i>Oh, I think she liked that.”</i> Tyrantia starts to tease Lily’s sensitive spinneret, picking up the pace as she ravages her sister’s pucker.\n\n");
	outputText("“<i>Oh, pl-please st-op it!”</i> Lily squirms even more, her walls closing in on your [cockhead]. She moans, her pussy again gushing femcum. Her tongue is lolling out, and her eyes are rolled back into her head. Despite her protests, Lily’s loving this.\n\n");
	outputText("“<i>Oh, is my little subby-sis cumming again?”</i> Tyrantia says, like talking to a child. “<i>But aw, she doesn’t like my dick?”</i> She twists, getting another gasp. “<i>Liar. You’re loving this. Getting ignored by your [master], dominated by your big, strong sis and all the hard, long cock.”</i> She stops moving, causing Lily to snap out of her reverie. “<i>Do you want more? Do you want your [master]’s cock to start moving, to give you pleasure?”</i>\n\n");
	outputText("You shift your hips, getting a gasp as Lily whips her head back around. You mockingly sympathize with your toy, telling her that she’s been such a trooper...but that she now needs to tell the truth. You tell her that she’s a dirty slut, getting turned on by her sister’s dick. You rub Lily’s femcum into her nose, and that she can’t deny it.\n\n");
	outputText("“<i>Oh...kay.”</i> You slap her breast. Not good enough. “<i>Okay, I came...Just keep going.”</i>\n\n");
	outputText("Tyrantia stops, rubbing her sister’s sensitive spinneret. “<i>Nah. I think I’m insulted.”</i> Lily clenches, trying to stop Tyrantia’s Dick from leaving her.\n\n");
	outputText("“<i>Okay! Okay...I...I want you. I’m sorry.”</i> You rub her clit, and Lily moans, higher than before. “<i>Fuck me, please! I need you inside both my holes, to...Mmph!”</i> Tyrantia slides her Dick in again, and you buck your hips ever so slightly, sinking about an inch deeper into Lily’s needy pussy. “<i>I love your cocks!”</i>\n\n");
	outputText("Tyrantia slaps Lily’s ass, and both you and the submissive Drider mash your pelvises together. You sink balls-deep into Lily, and she squeals, her eyes closed and her mouth wide open. You piston in and out of her slick chasm, finally breaking Lily completely. She bucks her hips, spider-legs shaking and quad-breasts slapping into each other with wild abandon.\n\n");
	outputText("“<i>Fuck yesh! Yes,yes! yesyesyesyesMMPH!”</i> You shut her mouth with a kiss, her bitter venom mixing with her sweet saliva. Your [cock] hardens even more inside her, and you grab hold of her asscheeks, running your tongue all over her mouth. You feel her pussy tighten every time Tyrantia thrusts, keeping in time with your manic pace.\n\n");
	outputText("Lily bucks, pulling her upper body back and away from your kiss, but her upper half hits Tyrantia’s front. The much-larger Drider steps in, pushing Lily back to your kiss and sandwiching the senseless woman between the two of you. Tyrantia groans, her own pussy leaking all over her little sister’s back. Lily howls, thrashing wildly in her bondage. Her folds spasm, and you barely keep the pace up, your [cock] throbbing with your impending orgasm.\n\n");
	outputText("You grunt, unable to hold on any more. Your [cock] spasms, spurting seed straight into Lily’s womb. This sets off your love-toy’s orgasm, and Lily wails, bucking her hips as you paint her womb white. Unable to stand any more, Lily’s eyes roll into her head, and your love-toy faints.\n\n");
	outputText("The largest of your spider lovers holds Lily up, giving you a grin as you pull out of Lily’s love-hole. Your spooge drips from her, and you feel a warm sense of pride. You undo Lily’s bindings, and the two of you drag Lily over to the nest-bed.\n\n");
	outputText("“<i>You know, I still can’t believe this, sometimes.”</i> Tyrantia says softly. “<i>Having them back, y’know?”</i> She wraps an arm around you, gently pulling you into a warm, fuzzy hug. “<i>And I have you to thank for it.”</i> Despite the giantess’s cunt still dripping love-juice, she doesn’t go any further, her cheek rubbing against yours.\n\n");
	outputText("You gently remind Tyrantia that they’re all family now. She seems to like this, the giantess tightening her grip on you, letting out her tk-tk-tk sound. “<i>You sweet thing, you.”</i> The giantess sighs. She looks down at her sisters, out cold, then back at you. Her eyes seem drawn to your [cock], but she’s making an effort to ignore it.\n\n");
	player.sexReward("vaginalFluids","Dick");
	menu();
	addButton(1, "Bed", SpooderBangBedtime);
	addButton(2, "Round2", SpooderBangFight);
}
public function SpooderBangBedtime():void {
	clearOutput();
	outputText("Feeling tired, you close your eyes, hugging back. You tell Tyrantia that as much fun as you’ve had tonight, you could use some sleep. She nods, gently moving her sisters aside. Belisa stirs, turning her upper body as Tyrantia lowers the two of you into the middle of the nest. She grabs your arm, holding it like a teddy bear. You feel your eyelids droop, the familiar softness of Tyrantia’s breasts around your head almost hypnotic. Sleep comes quickly.\n\n");
	camp.cheatSleepUntilMorning();
	outputText("Lily stands over a fire not far from the nest, rubbing her stomach with a smile on her face. A meal’s on the fire, a mixture of nuts, fish and meat with plain-looking biscuits on the side. Your love-toy turns to face you, wearing nothing but an apron, and she smiles, flicking her wooden spoon to one side.\n\n");
	outputText("“<i>Good morning [master]!”</i> She sings. “<i>Breakfast will be ready soon.”</i>  As you stiffen slightly in appreciation of Lily’s outfit, your numb arm informs you that someone’s still holding onto it. You look down, and Belisa opens her eyes, yawning.\n\n");
	outputText("“<i>Hmm...[name], good morning.”</i> She doesn’t let go. “<i>Are you going to leave us again?”</i>\n\n");
	outputText("“<i>Not before breakfast.”</i> Tyrantia rumbles from beneath you. “<i>You’re going to need your energy, champion.”</i> Well, you aren’t getting out of this. You smile lazily, spending a bit of the morning eating breakfast, then bathing in the river with your three Drider lovers. They dote on you the entire time, teasing you and making jokes, but as you dress for the day, they wrap you in one last big spider-hug.\n\n");
	outputText("“<i>Come back soon, [name].”</i> Belisa says sadly. “<i>We miss you when you’re gone.”</i>\n\n");
	outputText("“<i>[master], look after yourself.”</i> Lily adds. “<i>You can’t fuck me senseless if you’re filled with demon-spunk...”</i>\n\n");
	outputText("“<i>Stay strong, champion.”</i> This from Tyrantia, who puts a hand on your shoulder. “<i>We love you.”</i>\n\n");
	outputText("Feeling invigorated, you stride into camp, ready to face a new day!\n\n");
	doNext(playerMenu);
}
public function SpooderBangFight():void {
	clearOutput();
	outputText("You sink a hand to your Drider lover’s still-dripping pussy, and you ask her if she’s really satisfied. The giantess turns her head, blushing. “<i>Honestly, no.”</i> Tyrantia scratches the back of her head. “<i>Look, it’s not you, [name]. The sex is fantastic...But whatever they did to me...I’m always wet and ready. It’s an itch that scratching just...doesn’t cure for long.”</i> You ponder that for a second, and ask the giantess if she’d like another round. “<i>Y-yes.”</i> Tyrantia says. “<i>Let’s leave them asleep, though. I don’t want to wake my sisters.”</i>\n\n");
	outputText("You nod, and the two of you leave the Longhouse. Tyrantia takes your hand, and the two of you, both naked, walk outside. The wind is cool on your [skin], and Tyrantia steps in front, blocking the wind for you. She brings you to the tree where Lily had made her treehouse, and you put one hand on the tree, asking her what she has in mind.\n\n");
	outputText("“<i>Honestly...I don’t know.”</i> Tyrantia says awkwardly. “<i>I...Lie down, please?”</i> You do so, curious, and Tyrantia looms over you, laying her spider-half down entirely. Her upper body rests on top of you, and her four massive breasts press down onto your [breasts] and stomach.\n\n");
	outputText("“<i>Honestly, I just want you here, and I want to take things slow.”</i> Your busty lover rubs her pussy lips against your thigh, and you cop a feel, her engorged lips drooling just at your touch. She returns the favor, taking your sensitive [cock] in her hands. Unlike the last time, she just runs her fingers along your shaft, massaging it. Her tender touch makes you rock hard, but she just continues, her eyes drawn to yours. You sink a finger into her folds, and she inhales, blushing slightly.\n\n");
	outputText("The stars twinkle gently behind your lover’s head, but her violet eyes shine bright. Unlike Belisa’s moans, or Lily’s rough wails, Tyrantia is silent. Despite this, as she lines her slick pussy up, lowering herself onto your rod, she gives you the impression of utter satisfaction, her mouth curling up into a smile and her eyes closing as she shivers in the night wind.\n\n");
	outputText("Tyrantia takes a slow, low pace, wrapping her arms around you and holding her upper body close to yours. Up and down she goes on your [cock], breathing steadily. Despite your tool being used multiple times tonight, the gentler, slower pace doesn’t hurt, her lubricants plenty enough to keep from aggravating your sore mons. She kisses you, and you melt into her embrace, closing your eyes and opening your hands, sinking your fingers into her luscious breasts.\n\n");
	outputText("You feel her slowly tighten on you, but you feel no need to hasten the process. Silently, without much warning, your lover tightens, her pussy walls contracting as she stops moving. Slick juices flow from her, the sweet smell almost intoxicating. Closer than ever to your own orgasm, you pick up the pace ever so slightly. Bringing your hand to the back of Tyrantia’s head, you kiss her with ardor. Suddenly, the pressure you hadn’t even realized was building in your [cock] releases. For the second time tonight, you cum into Tyrantia’s quim, burying yourself in as deep as you can. In response, she sits herself down on top of you, humming to herself as your balls drain, her pussy milking you for all its worth, wicking your baby batter into her depths.\n\n");
	outputText("“<i>Mmm...Slow and steady...Wins my heart.”</i> Your eyes begin to droop, and she picks you up, carrying you back to the longhouse, your [cock] still inside her.\n\n");
	camp.cheatSleepUntilMorning();
	outputText("You come to in the morning, still buried inside Tyrantia, in the nest. She’d thoughtfully pulled the blanket over all four of you, but you notice that you’re not the first to wake.\n\n");
	outputText("Lily stands over a fire not far from the nest, rubbing her stomach with a smile on her face. A meal’s on the fire, a mixture of nuts, fish and meat with plain-looking biscuits on the side. Your love-toy turns to face you, wearing nothing but an apron, and she smiles, flicking her wooden spoon to one side.\n\n");
	outputText("“<i>Good morning [master]!”</i> She sings. “<i>Breakfast will be ready soon.”</i>  As you stiffen slightly in appreciation of Lily’s outfit, your numb arm informs you that someone’s still holding onto it. You look down, and Belisa opens her eyes, yawning.\n\n");
	outputText("“<i>Hmm…[name], good morning.”</i> She doesn’t let go. “<i>Are you going to leave us again?”</i>\n\n");
	outputText("“<i>Not before breakfast.”</i> Tyrantia rumbles from beneath you. “<i>You’re going to need your energy, champion.”</i> Well, you aren’t getting out of this. You smile lazily, spending a bit of the morning eating breakfast, then bathing in the river with your three Drider lovers. They dote on you the entire time, teasing you and making jokes, but as you dress for the day, they wrap you in one last big spider-hug.\n\n");
	outputText("“<i>Come back soon, [name].”</i> Belisa says sadly. “<i>We miss you when you’re gone.”</i>\n\n");
	outputText("“<i>[Master], look after yourself.”</i> Lily adds. “<i>You can’t fuck me senseless if you’re filled with demon-spunk...”</i>\n\n");
	outputText("“<i>Stay strong, champion.”</i> This from Tyrantia, who puts a hand on your shoulder. “<i>We love you.”</i>\n\n");
	outputText("Feeling invigorated, you stride into camp, ready to face a new day!\n\n");
	player.sexReward("vaginalFluids","Dick");
	doNext(playerMenu);
}

public function LesSpood():void {
	clearOutput();
	outputText("You wiggle your hips, showing your [pussy] to your Drider lovers. Taking hold of your [clit], you ask your spider-ladies if they want anything to drink. Your pussy drools lubricant, and Lily licks her lips, sauntering towards you.\n\n");
	outputText("“<i>Oh, I am very thirsty...How kind of you to offer, [master].”</i> Lily lowers herself until her Spider half is resting against the floor, bringing her mouth to your lips. “<i>Oh, such a delightful smell.”</i> She sniffs greedily, then " + (player.hasCock() ? "pushes your [cock] aside and " : "") + " latches onto your lower lips, her fangs scraping your labia as her tongue enters your folds. You arch your back, tightening your thighs around Lily’s head. You rub her scalp, gasping as she begins eating you out in earnest.\n\n");
	outputText("Belisa, seeing this, brings one hand to her own pussy, her front legs shaking slightly. She locks eyes with you, and you nod, motioning her over. Belisa wastes no more time, positioning her spider-body over your legs, where Lily is lapping up your love-juices.\n\n");
	outputText("“<i>Y-you need to drink too.”</i> Belisa says firmly. She lowers herself down over your face, and you lean up, licking her button. Belisa lets out a little eep, quickly resting herself over your face, and you go to town, sinking your [tongue] in as far as it’ll go. Her scent, like cinnamon, fills your nose, and you get a nice, big whiff. Belisa squirms on top of you, her soft triangle muffling most sounds. You slap Belisa’s ass, getting another muffled yelp, but as you wind up again, you feel your own wrists being grabbed by a pair of large hands. You know who this is, and what she wants, and you let your hands be led to a much larger feminine delta, lined with fur.\n\n");
	outputText("“<i>Damn it, Belisa. You just had to take the best spot.”</i> Tyrantia complains, and the quivering folds above you jiggle.\n\n");
	outputText("“<i>You snooze, you lose, sis.”</i> Belisa says smugly, gasping loudly as you nibble her button. “<i>Oh! [Name]!”</i> You sink three fingers into your largest lover, and she lets out a satisfied hum as you jill her off. The four of you sink into an easy rhythm, increasing the pace slowly.\n\n");
	outputText("Belisa is the first to start moaning, and she’s quickly silenced. You hear sloppy kissing sounds, and Tyrantia’s walls tighten around your fingers. Lily picks up the pace, sinking her tongue into your folds, and you tighten around her tongue as it pierces deeper into your needy box. Your fingers, face and belly are slowly moistening with your lover’s emissions.\n\n");
	outputText("“<i>Mmph!”</i> Lily’s wails run through your thighs and into you, and she twists her head. A few seconds later, she takes your button in two fingers, ravaging your box with her tongue. You buck your hips, wrapping a [leg] around Lily’s head.\n\n");
	outputText("Without warning, your mouth is filled with sweet, sticky liquid, and two hard spider-legs land on both sides of your head. Belisa’s high wails barely reach you, but you keep licking, making her buck above you. You close your eyes as a second deluge of femcum drenches your face.\n\n");
	outputText("This scent finally pushes you over the edge. Lily attacks your clit again" + (player.hasCock() ? ", and she finally takes your [cock] in her hand, furiously stroking you in time with her tongue-lashing" : "") + ". Your spider-slut moans as you buck your hips, heart in your throat as you push her face in deeper. Eyes still closed, you coat Lily’s face in a veritable torrent of fem spunk." + (player.hasCock() ? " Your [cock] isn’t left out, and Lily leaves your box alone, wrapping her full lips around your [cockhead] and chugging your salty love milk." : "") + "\n\n");
	outputText("“<i>Good to the last lick, [master].”</i> Lily comments dreamily, then looks down at her own needy quim. Opening one eye, you watch as Belisa is gently moved from your face, and Tyrantia takes her place over your head.\n\n");
	outputText("“<i>Oh, yeah…”</i> Tyrantia moans as your tongue enters her. You move your hands from Tyrantia to Belisa, copping a feel, and she flinches, startled.\n\n");
	outputText("“<i>H-hey, I’m sensitive!”</i> Despite her protests, Tyrantia holds her close as you continue to flick and tease her still-spasming folds. “<i>Oh-oh…”</i> She cries out, and you can see out of the corner of your eye as Lily bends her backwards, right where you can see, and rests her delta over her smaller sister’s face.\n\n");
	outputText("Belisa, forced to lick or not breathe, starts lashing Lily’s sopping box with her tongue. Tyrantia, seeing your pussy unattended, leans down, pushing your [legs] aside and lapping at you.\n\n");
	outputText("The four of you sink into a frantic pace, bringing each other to orgasm countless times. Belisa, unsurprisingly, is the first to drop out, collapsing onto the bed and passing out. Lily and Tyrantia, however, are insatiable, and the three of you keep going all night. As the first rays of sunlight begin to peek through the hutch’s door, you pull your hands away from both your lover’s pussies, to their protest, as Belisa's eyes open.  \n\n");
	outputText("Belisa yawns, stretching her arms. She freezes upon seeing the three of you, and she gives you a glare. <i>“Did you three seriously go all night?!”</i>  \n\n");
	outputText("Tyrantia, her hand still holding Lily’s golden chain, tugs on it, looking at her sister sheepishly. <i>“Uh…We got kidnapped and experimented on by demons?”</i>  \n\n");
	outputText("Belisa puts a hand on her temple. <i>“...I swear, one of these days, that excuse isn’t going to work.”</i> She puts her hands on her hips. <i>“What am I going to do with you three? [name] should be fine, but you two are going to be sluggish as hell today!”</i>  \n\n");
	outputText("Tyrantia and Lily give each other conspiratorial looks, then shuffle, opening the circle in front of her. <i>“Well, I’m still horny”,</i> Tyrantia says. <i>“You could rejoin us.”</i>  \n\n");
	outputText("<i>“HOW ARE YOU STILL HORNY?!?!”</i> Belisa throws her arms up into the air.  \n\n");
	outputText("<i>“I was kidnapped and experimented on by demons.”</i> Both bigger sisters say that in unison.  \n\n");
	outputText("Tyrantia gropes you, grinning at her youngest sister, while Lily, not caring, continues to grind on Tyrantia’s leg. Belisa seems to deflate, at that, losing most of her anger.  \n\n");
	outputText("<i>“...Fuck.”</i>  \n\n");
	outputText("<i>“Yes. A lot of it.”</i> Tyrantia’s grin is still growing, and Belisa’s eyes widen. She bites her lower lip, giving your giantess a six-eyed glower.  \n\n");
	outputText("<i>“...I am not covering your chores today.”</i> She pulls on her robe and scuttles out the door in a huff. Tyrantia, guilty, looks down at Lily. <i>“Okay, we’re done now.”</i> She grabs her younger sister by her back legs, dragging her off you and out into the camp.  \n\n");
	outputText("<i>“Sister, please, no! I don’t want to deal with the lines again!”</i> Lily begs, scrabbling back. <i>“Belisa’s never satisfied! Let me please [name] instead!”</i> Unmoved, Tyrantia rolls her eyes, pulling her sister outside, kicking and screaming. \n\n");
	//not quite finished yet.
	outputText("The four of you sink into a frantic pace, bringing each other to orgasm countless times. Belisa, unsurprisingly, is the first to drop out, collapsing onto the bed and passing out. Lily and Tyrantia, however, are insatiable, and the three of you keep going all night. As the first rays of sunlight begin to peek through the hutch’s door, you pull your hands away from both your lover’s pussies, to their protest. \n"
		+ "\n"
		+ "Belisa yawns, stretching her arms. She freezes upon seeing the three of you, and she gives you a glare. “Did you three seriously go all night?!” \n"
		+ "\n"
		+ "Tyrantia, her hand still holding Lily’s golden chain, tugs on it, looking at her sister sheepishly. “Uh... We got kidnapped and experimented on by demons?” \n"
		+ "\n"
		+ "Belisa puts a hand on her temple. “...I swear, one of these days, that excuse isn’t going to work.” She puts her hands on her hips. “What am I going to do with you three? [name] should be fine, but you two are going to be sluggish as hell today!” \n"
		+ "\n"
		+ "Tyrantia and Lily give each other conspiratorial looks, then shuffle, opening the circle in front of her. “Well, I’m still horny”, Tyrantia says. “You could rejoin us.” \n"
		+ "\n"
		+ "“HOW ARE YOU STILL HORNY?!?!” Belisa throws her arms up into the air. \n"
		+ "\n"
		+ "“I was kidnapped and experimented on by demons.” Both bigger sisters say that in unison. \n"
		+ "\n"
		+ "Tyrantia gropes you, grinning at her youngest sister, while Lily, not caring, continues to grind on Tyrantia’s leg. Belisa seems to deflate, at that, losing most of her anger. \n"
		+ "\n"
		+ "“...Fuck.” \n"
		+ "\n"
		+ "“Yes. A lot of it.” Tyrantia’s grin is still growing, and Belisa’s eyes widen. She bites her lower lip, giving your giantess a six-eyed glower. \n"
		+ "\n"
		+ "“...I am not covering your chores today.” She pulls on her robe and scuttles out the door in a huff. Tyrantia, guilty, looks down at Lily. “Okay, we’re done now.” She grabs her younger sister by her back legs, dragging her off you and out into the camp. \n"
		+ "\n"
		+ "“Sister, please, no! I don’t want to deal with the lines again!” Lily begs, scrabbling back. “Belisa’s never satisfied! Let me please [name] instead!” Unmoved, Tyrantia rolls her eyes, pulling her sister outside, kicking and screaming.");
	player.sexReward("vaginalFluids", "Vaginal");
	doNext(camp.returnToCampUseOneHour);
}
public function TriFuckta():void {
	clearOutput();
	if (player.cockTotal() < 7) sceneHunter.print("You could still use more ;).");
	outputText("You smile, telling your Drider lovers that they need to be nude for the nighttime fun to commence. Belisa sheds her robe, covering her breasts with one hand. Tyrantia shrugs out of her armor, and Lily watches them both, vaguely interested.\n\n");
	outputText("“<i>F-Fair is fair, you need to as well!”</i> Belisa demands, and the other two Driders grin, taking hold of your arms. Playfully holding you, the bigger Driders tease your abs and [breasts] with their front legs while Belisa takes hold of your [armor], sliding it off your frame. Your mouth is taken, first by Lily, then by Tyrantia, the two sisters playfully pushing each-other’s mouth aside to greedily lap up your saliva. One of Tyrantia’s front legs wrap around your waist, and she rests the tip of her limb in the crack of your [ass]. Not to be outdone, Lily takes one hand off your “<i>Restrained”</i> arm, running her hand up your flank, to your [breasts] before rubbing your [ass], chitinous fingers smooth against your [skin].\n\n");
	outputText("Belisa " + (!player.upperGarment.isNothing ? "relieves you of your [uppergarment], pinching" : "pinches") + " your [breasts] playfully as she sneaks between her two, larger sisters to kiss you. She takes one hand, bringing it to the back of your head as she french-kisses you, her tongue and yours almost melting together. As she does so, Lily and Tyrantia shrug, bringing their upper bodies together behind their sisters’ back. Lily and Tyrantia press their breasts together, Lily moaning slightly as they make out.\n\n");
	if (!player.lowerGarment.isNothing)
		outputText("With your [cocks] already tenting your [lowergarment], Belisa has a slightly harder time getting them off you, especially one-handed, forcing her to take each and every one of your shafts in her soft hand, massaging it as she pulls it out from the confines of your [lowergarment].\n\n");
	outputText("With your shafts fully exposed, Lily and Tyrantia stop their make-out sesh, smiles widening. “<i>Oh, I have a simply wonderful idea, big sister.”</i> Lily croons, taking [cock 2] in her hand and playing with the [cockhead 2].\n\n");
	outputText("“<i>And what would that be?”</i> Tyrantia asks, playing along. She takes your [cock 3] in one of her giant hands, running her fingers along it. The two Driders squish in, wrapping an arm each around their little sister.\n\n");
	outputText("“<i>Our mate here is so gifted, don’t you think, little sister?”</i> Lily asks Belisa, and the smallest Drider nods, her gaze fixed on your groin. “<i>Why, I think [he] could satisfy all three of us at once, with those lovely cocks of theirs.”</i> Belisa shyly takes your [cock] in both hands, looking at you, face red. Small shivers run up your spine as the three slowly walk you over to the bed, pushing you back-first onto the nestlike structure.\n\n");
	outputText("“<i>I think [he] could.”</i> Tyrantia says, tugging on your [cock 3]. She takes a half-step in, and you feel her guide your [cock 3] to her pussy lips. You put a hand on Belisa’s shoulder, giving her an encouraging smile. The smallest of the Drider sisters blushes, smiling back as she strokes your [cock] slowly, tenderly.\n\n");
	outputText("“<i>Let me help you with that, little sister”</i>, Lily soothes, gently taking your [cock] and lining it up with Belisa’s inviting hole. Belisa gasps, her upper body shuddering as your [cockhead] sinks into Belisa’s snug lovehole.\n\n");
	outputText("Tyrantia smirks, diddling herself as she rubs your [cockhead 3] against her lower lips. “<i>Alright girls, three...two...one…”</i> At the same time, the triplets sink onto your cocks, the sensation of those three pussies wrapping around you almost too delicious to bear.\n\n");
	outputText("Tyrantia grins, rubbing Belisa’s back as the smallest drider takes your girth. You begin moving your hips, and Belisa bends over, hugging your upper body and resting her head on your chest. You feel her heart beating, and her nervousness. You stroke her head, and she relaxes a little.\n\n");
	//if you have fourth cock
	if (player.cockTotal() >= 4)
		outputText("Lily takes your [cock 4] in one hand, stroking it lovingly. A bit of pre oozes from your tip, and she rubs it on your shaft, leaning down and kissing the tip. Her soft, almost delicate ministrations get more pre, and she licks her lips, gazing hungrily at your [cock 4].\n\n");
	if (player.cockTotal() >= 5)
		outputText("Tyrantia takes your fifth shaft in her calloused palm, her nails scraping the underside of your [cockhead 5].\n\n");
	if (player.cockTotal() >= 6)
		outputText("Lily’s second hand drops to your [cock 6], and she hums a little, tickling your veiny underside. “<i>Hmm…”</i>\n\n");
	if (player.cockTotal() >= 7)
		outputText("Tyrantia looks at your [cock 7], sighing at Lily. “<i>Well, if you’re taking care of three, then I guess I could as well”</i>. She chuckles as your [cock 7] drips pre, and she rubs your [cockhead 7] along her stomach.\n\n");
	if (player.cockTotal() >= 8)
		outputText("The rest of your cocks stand, erect but unattended.\n\n");
	outputText("Your Drider lovers begin picking up the pace slightly, moaning as your cocks rub against their folds. Belisa kisses your neck, her upper body pressed down onto yours. Lily and Tyrantia lean into each other over their smaller sister, giving you a wonderful view of their soft quad breasts pressing together as they suckle and use their teeth to play with each other. Belisa brings her mouth to yours, and you hold the smaller woman, whispering sweet nothings into her ear as she moves her hips, scraping her tender folds along your length.\n\n");
	if (player.cockTotal() > 4) outputText("After a few minutes, you feel two of the hands on your shafts leave. ");
	else if (player.cockTotal() == 4) outputText("After a few minutes, your lone pussyless shaft is abandoned. ");
	outputText("Tyrantia and Lily gently pull Belisa’s upper body off you. Without missing a beat, Lily leans down, running her hands along your neck and face, her many eyes wide as she leans down, scraping her fangs gently along the vulnerable side of your neck, her venom tingling as it leaves her fangs.\n\n");
	if (player.cockTotal() > 4) outputText("After a few minutes, you feel two of the hands on your shafts leave.  Your unattended shafts are taken care of as Belisa’s hands replace Lily’s");
	else if (player.cockTotal() == 4) outputText("After a few minutes, your lone pussyless shaft is abandoned. Belisa’s smooth hands wrap around the shaft Lily’s left behind ");
	if (player.cockTotal() >= 4) outputText(", and ");
	outputText("Belisa moans as her biggest sister takes her lips, forcing them open and nearly smothering the little spider-woman in her cleavage. The pace remains the same, slow and steady, your three Drider lovers in no rush to climax just yet.\n\n");
	outputText("Lily hums, her hips rolling. She pulls her upper body back, to look at your chest, but you pull her chain, getting a loud, low moan from your submissive spider-bitch. You pull her down on top of you, getting a unified moan from all three as you bring your hips up, burying your cocks to the hilt in each of your Drider lovers.\n\n");
	outputText("“<i>Hnng...Even when you’re on the bottom, you…”</i> Lily whispers, and you put a finger on her lips. You reach around, cupping your pet’s palmable asscheek, and you slide a finger into her asscrack. Gasping in anticipation, Lily kisses you again, her sweet-tasting tongue entering your mouth right as you stick a finger into her tight pucker. This makes Lily buck, faster than the other two, and you french her for another few minutes. Your pre oozes from your many cocks, and all three of your Drider-girls are now positively dripping with lust. You pop your finger out of Lily’s asshole, withdrawing from her passionate kiss and making her lick the taste of her own ass off your finger. She reluctantly leans back" + (player.cockTotal() > 3 ? ", switching handjobs with Belisa as she too tries to smother her smaller sister" : "") + ".\n\n");
	outputText("Unlike with Tyrantia though, Belisa grabs Lily’s chain in her teeth, yanking hard and pulling at Lily’s more sensitive nipples. Lily wails, her walls clamping down on you as she bucks her hips faster. Lily cries out as Belisa sinks her fangs into Lily’s shoulder, depositing what you know to be an aphrodisiac venom into her larger sister. This only makes her vaginal walls clamp down on you more, and in an uncharacteristic act of sexual spite, Belisa " + (player.cockTotal() >= 5 ? "lets go of your shaft and " : "") + "brings her hand to Lily’s tender clit, twisting it in time with Lily’s bucking hips.\n\n");
	outputText("Lily cries out, and you feel a flood of pussy juices spill from Lily’s twat. Belisa begins frenching her sister, getting a veritable cacophony of moans and breathy gasps.\n\n");
	outputText("The final of your spider-lovers, scarred and tentative, lets her lower body droop down. She’s careful not to rest her entire weight on you, but you pull her down, creaking your bones slightly. This makes Tyrantia hum happily, letting out the sisters’ “<i>Tk-tk-tk</i>” happy noise as she wraps her big, fuzzy arms around you. You let her face fill your view, and savor each twitch, every movement of her gigantic body as you play with her nipples, paddle her breasts, and move your hips, sending your cocks deep into your Spider lover’s quims.\n\n");
	outputText("Lily, breathing hard, is still milking you for all she’s worth. You can feel yourself building, your cocks twitching, but you groan, desperately holding your impending orgasm back. Holding Tyrantia’s prodigious breasts, you begin to pump your hips with wild abandon. As if sensing your impending orgasm, Belisa and Lily join Tyrantia above you, opening their mouths and gasping with each thrust. The triplets’ breasts are smooshed together in the confined space, and you bring your mouth up, kissing each one in no particular order and mixing all their saliva in your mouth. You can feel all three triplets tighten on your cocks, Belisa closing her eyes, Tyrantia’s tongue lolling out of her mouth, and Lily...Well, she’s still in the throes of her first orgasm, steadily building to her second.\n\n");
	outputText("“<i>I-I-I-[name]!</i>” Belisa wails. “<i>I’m so close. Oh gods, please! Almost...!”</i> Lily shuts her up with her mouth, slipping one of her fingers into Belisa’s asshole like you’d done to her. “<i>MMPH!</i>” Belisa’s pussy spasms, and she bucks uncontrollably, squirting all over your combined lower bodies. “<i>Oh myyyyyy!</i>”\n\n");
	outputText("This pushes you over the edge, and you grunt, mashing your pelvis in towards the three women as fast as you can. Lily and Belisa hold onto each other for dear life, Belisa burying her face into her sister’s cleavage as you and Tyrantia both struggle to be the last to cum.\n\n");
	outputText("“<i>Oh...Fuck...No...I’m gonna...Oh shit...</i>” Tyrantia’s lower voice comes out, and she arches her massive back, sending her jugs jiggling every which way. You and the giantess cum together, hot on the heels of Belisa’s wailing orgasm. Tyrantia spills her love juices all over you and her two sisters, but you barely notice, lost in your own throbbing cocks.\n\n");
	outputText("Belisa squeals as your hot jizz releases deep inside her. You pump load after load of spooge into her needy pussy, which flails on your [cock], milking it for all she’s worth. Belisa herself bucks wildly, her arms around Lily all that’s keeping her upper body from falling completely over.\n\n");
	outputText("“<i>Yeeeeeeeesssssh!”</i> Lily hisses, her own second orgasm unleashed by your wave of spooge. Your [cock 2] pulses, and she impales herself as deep as she can onto you, taking Belisa with her.\n\n");
	outputText("“<i>Fuuuuuuck!”</i> Tyrantia groans, trying to keep her upper body moving, but her pussy walls clamp down on you hard, and she seems to lose the energy to stay up, her spider-legs folding. As you unleash your baby-batter deep into her quim, she wriggles, milking more and more of your hot cum into her innermost depths.\n\n");
	if (player.cockTotal() > 4)
		outputText("Your remaining cocks, forgotten, fire their loads into the air like fireworks, bathing your Drider lover’s backs in warm, sticky fluid.\n\n");
	outputText("As you buck, enslaved to your high, your lovers fall together, their upper bodies draping over you. For a moment, all is calm as the four of you recover from your respective orgasms. You can feel your love juice rolling out of each sister’s pussy, down your shafts, and onto your legs. Satisfied, you let yourself fall limp, breathing heavily, your sensitive shafts still rubbing your lovers’ walls.\n\n");
	outputText("“<i>...Wow…”</i> Belisa breathes, rubbing your [breasts] idly. “<i>[name]...You were...Amazing.”</i>\n\n");
	outputText("“<i>Urrrrgh.”</i> Lily doesn’t appear to be able to form words right now, but the way she’s slowly moving her hips, your [cock 2] still inside her, leaves little doubt.\n\n");
	outputText("“<i>I love all of you.”</i> This from Tyrantia, who’s almost in tears. “<i>Mine. My family.”</i>\n\n");
	outputText("“<i>...Yeah…”</i> Lily’s eyes refocus. “<i>I feel so...warm.”</i>\n\n");
	outputText("“<i>We all do.”</i> Belisa brings her hand to her pussy again, feeling the base of your [cock]. “<i>Who knows? Maybe we’ll have podlings together, too.”</i> She giggles at that. You grin, asking your Drider-lovers to pull out and stand back a bit. They smile, doing so, and you wince as they gently, slowly walk back, letting your [cocks] fall out of them. All three Drider-girls smile, spreading their legs as you inspect your handiwork.\n\n");
	outputText("Lily spreads herself wide with her fingers, letting you see well into her insides. She rubs her little clitty, moaning to try and tempt you again. Your spooge sticks to her pussy, and it starts to spread down her inner thighs. You tell your pet to close her legs and keep your seed inside if she can. Lily smiles, her legs shaking as you order her. “<i>Of course, [master]”</i> she moans, biting her lip.\n\n");
	outputText("Belisa blushes a little, but as you draw closer, she lets you peek. She’s dripping the most of the three, her front legs drenched in your liquid love. You kneel down, rubbing some of it into her chitin, getting an embarrassed moan from the little Drider. You stand back up, kissing her on the cheek and telling her that you’re happy she enjoyed herself. “<i>M-me too. I...Kinda wanted you all to myself, but…”</i> As Tyrantia and Lily give her a glare, she blushes. “<i>B-but I loved this. I love you…”</i> You smile, kissing her forehead, and Belisa shivers as you walk over to the largest of the Drider sisters.\n\n");
	outputText("Tyrantia’s pussy gapes, but very little of your cum trickles out of her. She gasps as you run a finger along her pussy lips, then bring your tongue to her. “<i>H-hey, I just came, [name]!”</i> Your Amazoness shudders, and you wrap your arms around her, nuzzling her belly with your cheek.\n\n");
	outputText("You stagger, and Belisa gasps. Woozy and lightheaded all of a sudden, you let your lovers sit you down and bring you water, which helps a lot. They lie you down into bed, on top of Tyrantia, and the other two lie down on either side of you. Belisa puts a hand on your forehead, and you lie down to sleep with your Drider lovers.\n\n");
	outputText("“<i>We need to do this again sometime.”</i> Tyrantia says happily. “<i>This was a blast.”</i>\n\n");
	outputText("“<i>O-only if you’re feeling okay, [name]!”</i> Belisa says, rubbing your cheek.\n\n");
	outputText("You chuckle, patting Belisa on the head. You assure her that you’re fine, you just lost a lot of fluid, that’s all.\n\n");
	outputText("“<i>Damn right you did.”</i> This from Lily, who latches onto your arm, rubbing her head onto it. Dripping wet and reeking of sex, the four of you drift into a happy, comfortable sleep.\n\n");
	camp.cheatSleepUntilMorning();
	outputText("You come to in the morning, in the nest. You notice that you’re not the first to wake, however.\n\n");
	outputText("Lily stands over a fire not far from the nest, rubbing her stomach with a smile on her face. A meal’s on the fire, a mixture of nuts, fish and meat with plain-looking biscuits on the side. Your love-toy turns to face you, wearing nothing but an apron, and she smiles, flicking her wooden spoon to one side.\n\n");
	outputText("“<i>Good morning [master]!”</i> She sings. “<i>Breakfast will be ready soon.”</i>  As you stiffen slightly in appreciation of Lily’s outfit, your numb arm informs you that someone’s still holding onto it. You look down, and Belisa opens her eyes, yawning.\n\n");
	outputText("“<i>Hmm... [name], good morning.”</i> She doesn’t let go. “<i>Are you going to leave us again?”</i>\n\n");
	outputText("“<i>Not before breakfast.”</i> Tyrantia rumbles from beneath you. “<i>You’re going to need your energy, champion.”</i> Well, you aren’t getting out of this. You smile lazily, spending a bit of the morning eating breakfast, then bathing in the river with your three Drider lovers. They dote on you the entire time, teasing you and making jokes, but as you dress for the day, they wrap you in one last big spider-hug.\n\n");
	outputText("“<i>Come back soon, [name].”</i> Belisa says sadly. “<i>We miss you when you’re gone.”</i>\n\n");
	outputText("“<i>[master], look after yourself.”</i> Lily adds. “<i>You can’t fuck me senseless if you’re filled with demon-spunk...”</i>\n\n");
	outputText("“<i>Stay strong, champion.”</i> This from Tyrantia, who puts a hand on your shoulder. “<i>We love you.”</i>\n\n");
	outputText("Feeling invigorated, you stride into camp, ready to face a new day!\n\n");
	player.sexReward("vaginalFluids","Dick");
	player.sexReward("vaginalFluids","Dick");
	player.sexReward("vaginalFluids","Dick");
	doNext(playerMenu);
}

//disabled to avoid events. Hope it doesn't break anything
/*
private function sleepForAnight():void {
	CoC.instance.timeQ = 9;
	camp.sleepRecovery(true);
	CoC.instance.timeQ = 0;
    menu();
	addButton(0,"Next", camp.sleepWrapper);
}
*/
	}
}
