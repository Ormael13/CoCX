/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs{
import classes.*;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

public class EtnaDaughterScene extends NPCAwareContent implements TimeAwareInterface, SaveableState {

	public static var EtnaDaughterName:String;
	public static var EtnaDaughterIncestEnabled:Boolean;
	public static var EtnaDaughterAge:int;	//0 = not born, 1 = child, 2 = adult
	public static var EtnaDaughterGuardingCamp:int;	//0 = locked, 1 = not guarding, 2 = guarding;
	private var checkedEtnaDaughter:int;

	public function stateObjectName():String {
		return "EtnaDaughterScene";
	}

	public function resetState():void {
		EtnaDaughterName = "";
		EtnaDaughterIncestEnabled = false;
		EtnaDaughterAge = 0;
		EtnaDaughterGuardingCamp = 0;
		checkedEtnaDaughter = 0;
	}

	public function saveToObject():Object {
		return {
			"EtnaDaughterName": EtnaDaughterName,
			"EtnaDaughterIncestEnabled": EtnaDaughterIncestEnabled,
			"EtnaDaughterAge": EtnaDaughterAge,
			"EtnaDaughterGuardingCamp": EtnaDaughterGuardingCamp
		};
	}

	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			EtnaDaughterName = o["EtnaDaughterName"];
			EtnaDaughterIncestEnabled = o["EtnaDaughterIncestEnabled"];
			EtnaDaughterAge = o["EtnaDaughterAge"];
			EtnaDaughterGuardingCamp = o["EtnaDaughterGuardingCamp"];
		} else resetState();
	}

	public function timeChange():Boolean {
		checkedEtnaDaughter = 0;
		return false;
	}

	public function timeChangeLarge():Boolean {
		if (checkedEtnaDaughter++ == 0 && model.time.hours == 6 && etnaDaughterFollower() && incestEnabled() && EtnaDaughterIncestEnabled && player.hasCock() && (model.time.days % 2 == 0 )) {
			spriteSelect(SpriteDb.s_isabella);
			etnaDaughterNightlyMilkings();
			return true;
		}
		return false;
	}

	public function EtnaDaughterScene() {
		EventParser.timeAwareClassAdd(this);
		Saves.registerSaveableState(this);
	}

	public function etnaDaughterFollower():Boolean {
		return EtnaDaughterAge > 0;
	}

	public static function incestEnabled():Boolean {
		return CoC_Settings.debugBuild; //load incest only for "debug" builds to avoid it popping up on the forum... maybe we should try the full ver too?
	}

	private function championRef():String {
		return player.mf("Daddy","Mom");
	}

//[NEXT]
public function nameEtnaDaughter():void {
	spriteSelect(SpriteDb.s_etna);
	outputText("“<i>What will we name her? I didn’t have time to think of a suitable name it all happened so fast… as my mate I think the decision goes to you [name]</i>” [pg]");
	menu();
	addButton(0,"Next",applyEtnaDaughterName);
	mainView.nameBox.text = "";
	mainView.nameBox.visible = true;
	mainView.nameBox.width = 165;
	mainView.nameBox.x = mainView.mainText.x + 5;
	mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
}
private function applyEtnaDaughterName():void {
	//Easter Egg Names Hel WILL NOT ALLOW:
	if (CoC.instance.testingBlockExiting)
	{
		// We're running under the testing script.
		// Stuff a name in the box and go go go
		mainView.nameBox.text = "Kiderp";
	}
	else if(mainView.nameBox.text == "")
	{
		clearOutput();
		if(mainView.nameBox.text == "") outputText("“<i>Please give her a name [name].</i>”");
		//[Back to the name field you go!]
		menu();
		mainView.nameBox.x = mainView.mainText.x + 5;
		mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		addButton(0,"Next",applyEtnaDaughterName);
		return;
	}
	EtnaDaughterName = mainView.nameBox.text;
	mainView.nameBox.visible = false;
	//[Name Field]
	//Easter Egg Names:
	clearOutput();
	
	outputText("“<i>[etnakidname] is such a wonderful name! I’m sure she will live up to you with it! What do you think [etnakidname]?</i>”[pg]");
	outputText("Your daughter is too busy sleeping to listen at the moment, but by the way you see her ears twitching, you're sure she likes it. The three of you doze off to sleep together. When you wake up you're holding a manticore of tender years against you, she has [haircolor] hair, the same as you, and the face of her mother.[pg]");
	outputText("“<i>"+championRef()+"? Good morning!</i>”[pg]");
	outputText("Well, that's a disappointment, you expected this phase to last longer but you guess you will have to make do. Still, she didn’t fully mature overnight which, considering Mareth’s ridiculous time skips, is a small miracle in its own. Maybe you will get to enjoy the joys of being a parent a bit longer?[pg]");
	EtnaDaughterAge = 1;

	doNext(camp.returnToCampUseTwoHours);
}

public function etnaDaughterCampDescription():void {
	outputText("\nYou see [etnakidname] playing around the camp, chasing butterflies as she pounces from one rock to another. For a child who belongs to a species of succubus-like cum thirsty creatures, she is surprisingly innocent. It feels so good to be a parent and you hope these days last forever.\n\n");
}


//Etna’s daughter Main Menu @ Camp [Followers Tab]
public function etnaDaughterMainMenu():void {
	clearOutput();
	outputText("[etnakidname] notices you coming towards her and pounces on you, smiling widely as she jumps into your arms.[pg]");
	outputText("\"<i>" + championRef() + "!</i>\"[pg]");
	if (EtnaDaughterGuardingCamp == 2) outputText("She is currently guarding the camp at night.");

	menu();
	//Display Options:
	//[Hug]
	//[Talk]
	addButton(0,"Talk",talkToEtnaDaughter);
	addButtonIfTrue(1, "Guard Camp", toggleEtnaDaughterGuardingCamp, "She cannot guard your camp yet, maybe talk to her first.", EtnaDaughterGuardingCamp > 0);
	if (incestEnabled()) {
		//[Sex]; bipeds only, lust must be high, incest must be flagged active, and player must have a dick.
		if (EtnaDaughterIncestEnabled) {
			addButton(3, "Play: Carry", playWithEtnaDaughter)
					.disableIf(player.lust < 33, "Not aroused enough.")
					.disableIf(!player.isBiped(), "You have to be biped, sorry.")
					.disableIf(!player.hasCock(), "Req. a cock.");
		}
		else addButtonDisabled(3, "???", "You should talk to her first.")
		addButton(4, "Incest", incestWithEtnaDaughterToggle).hint("Toggle incestuous event with "+EtnaDaughterName, "Incest "+(EtnaDaughterIncestEnabled?"Enabled":"Disabled"));
	}
	addButton(14,"Back",camp.campFollowers);
}

//Talk
private function talkToEtnaDaughter():void {
	//{Note: Talk 1 displays first and only once, followed by a random selection from the other scenes. Most of Helspawn's talk scenes involve other characters from camp, since after all, it takes a village!}
	clearOutput();
	outputText("So, what did your adorable daughter do today?")
	var temp:int = rand((incestEnabled() && EtnaDaughterIncestEnabled)?5:4);
	if (temp == 0) {
		outputText("“<i>I caught a butterfly "+championRef()+", look!</i>”[pg]" +
				"She opens her paws and indeed a butterfly flies out as she laughs cheerfully. Considering the nature of the other games she sometimes gets involved in this is a welcome sight.\n");
		doNext(camp.returnToCampUseOneHour);
	} else if (temp == 1) {
		outputText("“<i>I went playing by the stream, the fish are so boring. However, an ugly little man in red came by. I milked him dry just like mama told me!</i>”[pg]" +
				"Perhaps you should keep watch over her but since Etna doesn't seem to be worried you could also just let her have her fun.\n");
		if (EtnaDaughterGuardingCamp == 0) EtnaDaughterGuardingCamp = 1;
		doNext(camp.returnToCampUseOneHour);
	} else if (temp == 2) {
		outputText("”<i>I made a friend! Look here she is!</i>”[pg]" +
				"[etnakidname] pulls a somewhat very traumatized, tied up goblin from a hiding spot around the camp.[pg]" +
				"“<i>Hey, slutty say hello to "+championRef()+"!</i>”[pg]" +
				"The goblin looks at you with pleading eyes then adds “<i>Someone kill me please...</i>” as [etnakidname] shoves her back in the hole where she stashes her toys.")
		doNext(camp.returnToCampUseOneHour);
	} else if (temp == 3) {
		outputText("“<i>I caught a fish by the lake!</i>”[pg]" +
				"She goes to her stash and comes back with a shark girl, still tied up in a fillet, bondage-style. Furthermore, she is clearly high on manticore lust venom, trying to pleasure herself but unable to reach her cunt with her hands.[pg]" +
				"“<i>Can I keep it?</i>”[pg]");
		menu();
		addButton(0, "Yes", keepFishy);
		addButton(1, "No", freeFishy);

		function keepFishy():void {
			outputText("Sure but she has to take care of it so it does not starve or leave smelly stuff around the camp.[pg]");
			outputText("“Don’t worry "+championRef()+", I can handle it!”\n");
			doNext(camp.returnToCampUseOneHour);
		}
		function freeFishy():void {
			outputText("Of course not! You tell her to release this wild animal back into the water before it hurts itself. She pouts for a moment but opens her wings to fly, carrying her prize back to the water.");
			doNext(camp.returnToCampUseOneHour);
		}
	} else if (temp == 4) {
		outputText("“<i>I haven’t found anything fun to do around camp today. Can you play with me "+championRef()+"?</i>”");
		doYesNo(playWithEtnaDaughter, etnaDaughterMainMenu);
	}
}

private function toggleEtnaDaughterGuardingCamp():void {
	if (EtnaDaughterGuardingCamp == 1) {
		outputText("You ask your adorable daughter if she would help you guard the camp at night.[pg]");
		outputText("“<i>Ok "+championRef()+ " I can help you keep the baddies away, and I can play with them too!</i>” she shouts gleefully before running off to play at the edge of camp.");
		EtnaDaughterGuardingCamp = 2;
	} else {
		outputText("You tell your daughter to stop guarding the camp at night.[pg]");
		outputText("“<i>Aww but "+championRef()+ ", Its so FUN! But if you say so then okay</i>” she says while walking away somewhat dejectedly.");
		EtnaDaughterGuardingCamp = 1;
	}
	doNext(playerMenu);
}

//Incest
private function incestWithEtnaDaughterToggle():void {
	clearOutput();
	if (!EtnaDaughterIncestEnabled) {
		outputText("You cup [etnakidname]'s cheek, turning her to you... only to have her leap you, straddling your [legs] as her powerful arms wrap around your neck.  Her thin lips press hard to yours, tongue probing against yours as her body presses against you.  " +
				"You respond in kind, grabbing her big ass and squeezing, kneading the delicious curves as she starts to grind against you, breath hot and heavy on your [skin].  \"<i>I said I love you, " + championRef() + ",</i>\" she grins, as her tail slips between your legs and grinds againstyour crotch.  \"<i>Glad to know you feel the same way.</i>\"");
		outputText("\n\nYou kiss her again and send her on her way with a sharp swat on the ass.  She gives it a sexy wiggle as she walks, winking back at you as she saunters off, het tail drooling behind her.");
		dynStats("lus", player.sens/10+5, "scale", false);
	} else {
		outputText("Your daughter leaps on you, straddling your [legs] as her powerful arms wrap around your neck, her tail immediately seeking out your crotch, but you untangle yourself from her, taking her by the shoulders and tell her to not do this anymore.[pg]");
		outputText("\"<i>But why " + championRef() + "?</i>\" she asks with a frown. You tell her to just stop. She pouts, but nods and walk off to the edge of camp.");
	}
	EtnaDaughterIncestEnabled = !EtnaDaughterIncestEnabled;
	doNext(camp.returnToCampUseOneHour);
}

private function playWithEtnaDaughter():void {
	clearOutput();
	outputText("You think about what you will do with your daughter today when you hear a growl that sounds like her stomach.[pg]");
	outputText("“<i>"+championRef()+", I’m hungry please carry me!</i>”[pg]");
	outputText("Of course she is. You can see her tail twitch with hunger and you effortlessly figure out what your little cub wants.[pg]");
	outputText("You [if (hasarmor)remove your [armor] and ]pick up [etnakidname] and position her on your back for a piggyback ride.[pg]");
	outputText("“<i>Yay I’m going for a ride!</i>”[pg]");
	outputText("She laughs cheerfully as you move around with her on piggyback. She is swift to move her tail pussy to your [cock] making you moan as you walk around. You can feel [etnakidname]’s drool fall on your shoulders as she begins to tease your [cock] with her juvenile, yet already masterful tail-pussy, trying to get her daily share of milk. " +
			"Her devilish tail-cunt even at this age already pulses with the characteristic suction power of her race, pleasing your [cock] in all the ways it can to force the milk out. " +
			"You reward your daughter by strolling around as she keeps milking your manhood. You are happy to finally let out your man milk, letting your daughter get a healthy share of semen. [etnakidname] keeps gripping you all the while her arms around your neck tighten as she moans and reaches orgasm from her tail. " +
			"This is only the beginning however and you resume the game with a galop making [etnakidname] laugh happily as she doubles the milking cadence, cheerfully drinking as you ejaculate every fifteen seconds.[pg]");
	outputText("You finally dispose of your still drooling daughter on the ground. She left a large moist spot on your back where her true pussy was but purrs in happiness as she rolls on the grass like a kitten. Awwww, she looks so cute.[pg]");
	player.sexReward("vaginalFluids", "Dick");
	doNext(camp.returnToCampUseOneHour);
}

public function etnaDaughterNightlyMilkings():void {
	clearOutput();
	outputText("You were having a very wet dream, so wet you moaned in your sleep imagining yourself fucking with some lewd creature only to wake up on an orgasm. You are quite surprised to find [etnakidname]’s [if (islactating)mouth and paw on your [breasts] and ]tail on your [cock]. She realizes you're awake and unplugs, caught in the act.[pg]");
	outputText("“<i>Good morning "+championRef()+"! Please don’t mind me I’m just... taking breakfast...</i>”[pg]");
	outputText("Well, you guess you can’t refuse her that. You tell her she better finish her breakfast before it goes stale. [etnakidname] smiles wide and resumes [if (islactation)suckling on your breast ]as her tail immediately restarts its pleasurable massage on your [cock].[pg]");
	outputText("“<i>Mmmmm "+championRef()+"’s milk is the best!</i>”[pg]");
	outputText("You moan with the pleasure of multiple consecutive orgasms as your [cock] shoots a steady flow of cum, [etnakidname]’s tail bulging with the passage of her favored food as she makes a very contented face. You hug your daughter with love as she vacuums your cum out. After a while she purrs in contentment and unplugs her tail, leaving your [cock] clean of any fluid.[pg]");
	outputText("“<i>Thanks, "+championRef()+" I’m full.</i>”[pg]");
	outputText("Gods above, if your daughter can take several orgasms worth of cum in her tail, it's no wonder her adult mother needs at least a herd of minotaurs to be sated.[pg]");
}
}
}