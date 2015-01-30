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
				outputText(" and take out five gems before handing them to the thief. The thief says, \"Thanks, now scram!\" before letting go of you and saunters off.");
				flags[kFLAGS.THIEF_GEMS] += 5;
				player.gems -= 5;
			}
			statScreenRefresh();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function winAgainstThief():void {
			clearOutput();
			outputText("The thief collapses from his " + (monster.lust >= 100 ? "overwhelming desires": "injuries") + ". You smile in satisfaction as you rummage through his gem pouch. ");
			if (flags[kFLAGS.THIEF_GEMS] > 0) outputText("You are finally happy to have your gems back! ");
			monster.gems += flags[kFLAGS.THIEF_GEMS];
			flags[kFLAGS.THIEF_GEMS] = 0;
			cleanupAfterCombat();
		}
		
	}

}