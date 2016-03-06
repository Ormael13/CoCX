package classes.Scenes.Places.Ingnam 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	
	public class ThiefScene extends BaseContent
	{
		
		public function ThiefScene() 
		{
		}
		
		public function encounterThief():void {
			clearOutput();
			outputText("You wander the village for Ingnam until you feel something pressing against your shoulder and you look around to see the thief. \"<i>Your money or your life,</i>\" he demands.");
			menu();
			addButton(0, "Fight", startCombatImmediate, new Thief);
			addButton(1, "Give Gems", giveGems);
		}
		
		private function giveGems():void {
			clearOutput();
			outputText("You reach into your gem pouch");
			if (player.gems <= 0) outputText(", only to find it empty and tell the thief that you're poor. \"<i>Damn! Looks like I've picked the wrong person,</i>\" the thief says with a grumbled look. He lets go of you and saunters off.");
			else if (player.gems > 0 && player.gems <= 5) {
				outputText(" and fish into the only gem" + (player.gems == 1 ? "": "s") + " you have and give " + (player.gems == 1 ? "it": "them") + " to the thief. \"<i>That's not much. Fine,</i>\" the thief grumbles and lets you go before he takes your only gem" + (player.gems == 1 ? "": "s") + " and saunters off.");
				flags[kFLAGS.THIEF_GEMS] += player.gems;
				player.gems = 0;
			}
			else {
				outputText(" and take out five gems before handing them to the thief. The thief says, \"<i>Thanks, now scram!</i>\" before letting go of you and saunters off.");
				flags[kFLAGS.THIEF_GEMS] += 5;
				player.gems -= 5;
			}
			statScreenRefresh();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function winAgainstThief():void {
			clearOutput();
			outputText("The thief collapses from his " + (monster.lust >= monster.eMaxLust() ? "overwhelming desires": "injuries") + ". You smile in satisfaction as you rummage through his gem pouch");
			if (flags[kFLAGS.THIEF_GEMS] > 0) outputText(", happily retrieving the gems the thief has taken from you");
			outputText(".");
			monster.gems += flags[kFLAGS.THIEF_GEMS];
			flags[kFLAGS.THIEF_GEMS] = 0;
			menu();
			if (player.lust >= 33 && flags[kFLAGS.SFW_MODE] <= 0) {
				outputText("\n\nYou could punish the thief if you want to. If so, which parts would you use?");
				if (player.hasCock()) {
					if (player.cockThatFits(monster.analCapacity()) >= 0) addButton(0, "Anal Fuck", rapeThiefAnally, null, null, null, "The thief definitely needs to learn a lesson not to mess with you. Buttfuck the thief.");
					else outputText(" <b>Your cock is too big to fit!</b>");
				}
				if (player.hasVagina()) addButton(1, "Get Licked", getLicked, null, null, null, "Punish the thief by having him lick your [vagina].");
				addButton(4, "Leave", combat.cleanupAfterCombat);
				return;
			}
			combat.cleanupAfterCombat();
		}
		
		private function rapeThiefAnally():void {
			var x:int = player.cockThatFits(monster.analCapacity());
			clearOutput();
			outputText("You drag the unconscious thief into one of the alleys and remove his leather pants so he's naked from the waist down. The thief wakes up, realizing what you're doing and says with a whimper, \"<i>Please don't put that in there. I've never had anything in there.</i>\"");
			outputText("\n\nYou " + (player.armor != ArmorLib.NOTHING || player.lowerGarment != UndergarmentLib.NOTHING ? "remove your " + player.armorName + ", " : "") + "get the thief into position and you slowly slide your " + player.cockDescript(x) + " into his rear hole. Despite the thief's protestations, he seems to find pleasure.");
			outputText("\n\n\"<i>Yes, fuck me! Please fuck me!</i>\" The thief yells. That's the only encouragement you need as you thrust back and forth, abusing his ass. You grab his shoulders to get more leverage and you continue to pound with reckless abandon.");
			outputText("\n\nEventually, you can hold back no more and you unload your seed into his depths. The thief achieves orgasm as well, cumming all over the ground before falling on ground, dazed. You slide your " + player.cockDescript(x) + " out with a pop" + player.clothedOrNaked(", redress yourself") + " and leave the ravaged thief to recover.");
			player.orgasm();
			combat.cleanupAfterCombat();
		}
		
		private function getLicked():void {
			clearOutput();
			outputText("You drag the unconscious thief into one of the alleys. The thief wakes up and realize what you're going to do. You " + (player.armor != ArmorLib.NOTHING || player.lowerGarment != UndergarmentLib.NOTHING ? "remove the bottom half of your " + player.armorName + "" : "") + " to reveal your " + player.vaginaDescript() + (player.hasCock() ? " and " + player.cockDescript(): "") + ".");
			outputText("\n\n\"<i>Now lick. I want it licked good!</i>\" you tell the thief. The thief lets out a sigh as he licks your [pussy]. You let out a moan in pleasure while he's tongue-fucking your [pussy].");
			outputText("\n\nEventually, you can hold back no more and your [pussy] spasms, launching femcum");
			if (player.hasCock()) outputText(" while your [cock] fires ropes of jism");
			outputText(" all over his face. Still disoriented, the thief collapses back on the ground. You " + player.clothedOrNaked("redress yourself") + " and make a hasty exit while the thief is recovering from his ordeal.");
			player.orgasm();
			combat.cleanupAfterCombat();
		}
		
	}

}