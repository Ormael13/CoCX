/**
 * ...
 * @author Liadri
 * @source https://docs.google.com/document/d/1U0BX1sHGbeh0VA6wsPN83AXNbgP739fIgWQuyyBG9gg/edit#
 */
package classes.Scenes.NPCs{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

public class MidokaScene extends NPCAwareContent implements TimeAwareInterface, SaveableState {

	public var MidokaName:String;
	public var MidokaAge:int;
	public var GrowUpTime:int;
	public var MidokaGuardingCamp:int;	//0 = locked, 1 = not guarding, 2 = guarding;

	public function stateObjectName():String {
		return "MidokaScene";
	}

	public function resetState():void {
		MidokaName = "";
		MidokaAge = 0;
		GrowUpTime = -1;
		MidokaGuardingCamp = 0;
	}

	public function saveToObject():Object {
		return {
			"MidokaName": MidokaName,
			"MidokaAge": MidokaAge,
			"GrowUpTime": GrowUpTime,
			"MidokaGuardingCamp": MidokaGuardingCamp
		};
	}

	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			MidokaName = o["MidokaName"];
			MidokaAge = o["MidokaAge"];
			GrowUpTime = o["GrowUpTime"];
			MidokaGuardingCamp = o["MidokaGuardingCamp"];
		} else resetState();
	}

	public function timeChange():Boolean {
		if (GrowUpTime > 0) GrowUpTime--;
		return false;
	}

	public function timeChangeLarge():Boolean {
		return false;
	}

	// Midoka is Chi Chi’s daughter and will only happen if pc is wedded to her and manages to impregnate her. Midoka differs from her mother in many ways, but has the same
	// burning passion and tsundere tendencies as her, often admonishing her father for his questionable morality every now and then. Midoka can be trained by PC into a
	// proper sparring partner. Although she won’t do any form of sex, she helps reinforce the camp defences and can, unlike her mother operate as a battle mercenary,
	// fiercely protecting her father with an equilibrated amount of stuns and fire damage.

	public function MidokaScene() {
		EventParser.timeAwareClassAdd(this);
		Saves.registerSaveableState(this);
	}

	public function midokaFollower():Boolean {
		return MidokaAge > 0;
	}

	private function championRef():String {
		return player.mf("Daddy","Mommy");
	}

	//[NEXT]
	public function nameMidoka():void {
		outputText("“<i>She needs a name I thought about <b>Midoka</b>, but the choice is yours.</i>”[pg]");
		menu();
		addButton(0,"Next",applyMidokaName);
	}
	private function applyMidokaName():void {
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
			mainView.nameBox.text = "Midoka";
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			addButton(0,"Next",applyMidokaName);
			return;
		}
		MidokaName = mainView.nameBox.text;
		mainView.nameBox.visible = false;
		//[Name Field]
		//Easter Egg Names:
		clearOutput();

		outputText("“<i>Awww aren’t you cute my beautiful [midokaname]?</i>”[pg]");
		outputText("By the time you chose, the baby finally fell asleep. You sincerely hope this one will last longer than most babies you have seen in Mareth, being a parent would be nice for a change.[pg]");
		MidokaAge = 1;
		GrowUpTime = 7*24;

		doNext(camp.returnToCampUseTwoHours);
	}

	public function midokaGrowsUp():void {
		if (MidokaAge == 1) {
			outputText("Your daughter is sitting in her cradle looking at you with a bright smile. She doesn't talk yet and is barely the size of a human baby but when you get close she makes great efforts trying to stand to have a better look at you. You chuckle and proceed to carry her up, giving a kiss or two on her forehead which makes her laugh. Chi Chi smiles at this display of parental affection.[pg]");
			outputText("“<i>She always brightens up when you are in camp. I wish you were there more often for her but duty first right?</i>”[pg]");
		}
		if (MidokaAge == 2) {
			outputText("[midokaname] is currently on the ground playing in the grass away from her cradle. It has been a while since last you visited on your daughter but the moment [midokaname] sees you, he/she surprises you by standing on her own two legs and clobbering up to you for a hug. Aw she grows so fast but thankfully not as fast as the others. You are happy you did get to see your daughter make her first steps.[pg]");
		}
		if (MidokaAge == 3) {
			outputText("[midokaname] is no longer sitting but actually running around. The transition from baby to young child was fast and you admit you won’t miss those moments when she would randomly start crying in the night but you gotta make do with what times Mareth offers you. [midokaname], realising you’re observing her runs straight toward you and jumps for a surprise hug.[pg]");
			outputText("“<i>"+championRef()+"</i>”[pg]");
			outputText("Aw just how fast is your little girl growing? You spend the rest of the afternoon playing games with her. Quality time like this, you know already, won’t last forever.[pg]");
		}
		if (MidokaAge == 4) {
			outputText("[midokaname] is currently punching on a smaller dummy not too far from her mother. Chi Chi did tell you that the Hinezumies were a combative species but you did not expect [midokaname] to be invested into any form of battle training this early, mainly because this is hardly an activity suitable for a child her age. You look at Chi Chi quizzically.[pg]");
			outputText("“<i>Like mother like daughter, I did not ask [midokaname] to undergo any form of training, she just decided to take it on by herself.”[pg]");
		}
		if (MidokaAge == 5) {
			outputText("[midokaname] age 10 texts[pg]");
		}
		if (MidokaAge == 6) {
			outputText("[midokaname] age 16 texts[pg]");
		}
		MidokaAge++
		GrowUpTime = 7*24;
	}

	public function midokaCampDescription():void {
		outputText("\nMidoka is a young Hinezumi of about "+(MidokaAge == 1?"1 month":MidokaAge == 2?"1 year":MidokaAge == 3?"3 years":MidokaAge == 4?"6 years":MidokaAge == 5?"10 years":"15 years")+" old or so, you would give her around this age at least.\n\n");
	}


	//Etna’s daughter Main Menu @ Camp [Followers Tab]
	public function midokaMainMenu():void {
		clearOutput();
		if (GrowUpTime <= 0) {
			midokaGrowsUp();
		}
		else {
			outputText("[midokaname] notices you coming towards her and ");
			if (MidokaAge == 1) outputText("coos at you, waving her arms at you to pick her up.");
			else if (MidokaAge == 2) outputText("sits up, crawlnig to the edge of her basket and waving her arms at you to pick her up.");
			else if (MidokaAge == 3) outputText("stands up, gripping the edge of her basket with one tiny hand and waving the other at you to pick her up.");
			else if (MidokaAge == 4) outputText("calls to you, “<i>"+championRef()+"!</i>”, clambering out of her basket and running over to you.");
			else if (MidokaAge == 5) outputText("waves to you, “<i> Hi "+championRef()+", did you come to watch me train today?</i>”");
			else if (MidokaAge == 6) outputText("waves to you, “<i> Hi "+championRef()+", did you come to train with me today?</i>” while giving you a light jab to the shoulder");
			if (MidokaGuardingCamp == 2) outputText("She is currently guarding the camp at night.");
		}

		menu();
		//Display Options:
		//[Hug]
		//[Talk]
		addButton(0,"Talk",talkToMidoka)
				.disableIf(MidokaAge < 4, "She is too young to hold a conversation yet");
		addButton(1, "Guard Camp", toggleMidokaGuardingCamp)
				.disableIf(MidokaGuardingCamp > 0, "She cannot guard your camp yet, maybe talk to her first.")
				.disableIf(MidokaAge < 5, "She is too young and inexperienced to guard your camp yet");
		if (player.hasPerk(PerkLib.BasicLeadership)) {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButton(12, "Team", midokaHenchmanOption).hint("Ask Midoka to join you in adventures outside camp.")
					.disableIf(MidokaAge < 5, "She is too young and inexperienced to fight as your companion yet");
			else if (flags[kFLAGS.PLAYER_COMPANION_1] == "Midoka") addButton(12, "Team", midokaHenchmanOption).hint("Ask Midoka to stay in camp.");
			else addButtonDisabled(12, "Team", "You already have other henchman accompany you. Ask him/her to stay at camp before you talk with Etna about accompaning you.");
		}
		addButton(14,"Back",camp.campFollowers);
	}

	//Talk
	private function talkToMidoka():void {
		//{Note: Talk 1 displays first and only once, followed by a random selection from the other scenes. Most of Helspawn's talk scenes involve other characters from camp, since after all, it takes a village!}
		clearOutput();
		outputText("So, what did your adorable daughter do today?")
		var temp:int = rand(4);
		if (temp == 0) {
			outputText("“<i></i>”\n");
			doNext(camp.returnToCampUseOneHour);
		} else if (temp == 1) {
			outputText("“<i></i>” talk about guarding camp[pg]]");
			if (MidokaGuardingCamp == 0) MidokaGuardingCamp = 1;
			doNext(camp.returnToCampUseOneHour);
		} else if (temp == 2) {
			outputText("”<i></i>”[pg]")
			doNext(camp.returnToCampUseOneHour);
		} else if (temp == 3) {
			outputText("“” optioned talk[pg]");
			menu();
			addButton(0, "Yes", optYes);
			addButton(1, "No", optNo);

			function optYes():void {
				outputText("yes\n");
				doNext(camp.returnToCampUseOneHour);
			}
			function optNo():void {
				outputText("no\n");
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}

	private function toggleMidokaGuardingCamp():void {
		if (MidokaGuardingCamp == 1) {
			outputText("You ask your adorable daughter if she would help you guard the camp at night.[pg]");
			outputText("“<i>Ok "+championRef()+ " I can help you keep the camp safe!</i>” she exclaims, slamming a fist into her palm.");
			MidokaGuardingCamp = 2;
		} else {
			outputText("You tell your daughter to stop guarding the camp at night.[pg]");
			outputText("“<i>Aww but "+championRef()+ ", I want to help out! But if you say so then okay</i>” she says while walking away somewhat dejectedly.");
			MidokaGuardingCamp = 1;
		}
		doNext(playerMenu);
	}

	public function midokaHenchmanOption():void	//TODO Please elaborate on her Combat texts in \Scenes\Combat\CombatFollowerActions
	{
		clearOutput();
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
			outputText("\"<i>Hey "+championRef()+". Want me to tarry along and beat some sense into some imps? I would be happy to fight alongside you!</i>\"[pg]");
			outputText("Midoka is now following you around.[pg]");
			var strMidoka:Number = 85;
			var meleeAtkMidoka:Number = 28
			strMidoka *= (1 + (0.2 * player.newGamePlusMod()));
			strMidoka = Math.round(strMidoka);
			meleeAtkMidoka += (1 + (int)(meleeAtkMidoka / 5)) * player.newGamePlusMod();
			player.createStatusEffect(StatusEffects.CombatFollowerMidoka, strMidoka, meleeAtkMidoka, 0, 0);
			flags[kFLAGS.PLAYER_COMPANION_1] = "Midoka";
		}
		else {
			outputText("Midoka is no longer following you around.[pg]");
			player.removeStatusEffect(StatusEffects.CombatFollowerMidoka);
			flags[kFLAGS.PLAYER_COMPANION_1] = "";
		}
		doNext(talkToMidoka);
		cheatTime(1/12);
	}
}
}