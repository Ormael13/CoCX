/**
 * ...
 * @author Ormael, Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class NeisaFollower extends NPCAwareContent
	{
		
		public function NeisaFollower() 
		{}//between 6 and 15 she get her counter go up by 1 each night and if it hit 15 she leave at the morning xD
		//neisa follower flag: 1-3 - first exploring river dungeon, 4 - after first exploring, 5 - left camp due to not paid weekly paycheck (to make her return to camp req. to pay her that mercenary fee with all costs for delay so 10 days of fee not 7 - also her affection should drop to 0/pretty low after leaving camp due to not paid weekly paycheck),
		//6 to 15 - hired and staying in camp (6 to 12 - with PC having not yet paid her weekly paycheck - up to 3 days after deadline stays this way, 13 to 15 - when she's paid in time), 16 - after her affection rise high enough and she move from mercenary to camp member
		public function neisaAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.NEISA_AFFECTION] += changes;
			if (flags[kFLAGS.NEISA_AFFECTION] > 100) flags[kFLAGS.NEISA_AFFECTION] = 100;
			return flags[kFLAGS.NEISA_AFFECTION];
		}
		
		public function firstTimeEnteringRiverDungeon():void {
			clearOutput();
			outputText("As you approach the cave a bunch of heavily armored guards stops you its barely if you can see under that helmet.\n\n");
			outputText("\"<i>Hey you hold there. This cave is dangerous we can’t just let you head in like that you should at least go with someone else where is your partner?</i>\"\n\n");
			outputText("Partner what partner?\n\n");
			outputText("\"<i>Your teammate you moron. This place has claimed more adventurers lives then the wild of Mareth by now and it's obvious no one should go in there alone.</i>\"\n\n");
			outputText("A woman figure in heavy armor step forward out of the lot. You can barely see that she got blue eyes and black hairs under that highly covering helmet visor.\n\n");
			outputText("\"<i>I could accompany you in there providing you give me a proper pay in treasures. and hell It doesn't look like you are getting in otherwise so you might as well deal with it? By the way names Neisa try not to forget it to fast.</i>\"\n\n");
			outputText("You guess having another warrior with you should at least reduce the chance whatever lives in there gets a shot at using your prone body.\n\n");
			player.createStatusEffect(StatusEffects.CombatFollowerNeisa, 0, 0, 0, 0);
			flags[kFLAGS.PLAYER_COMPANION_1] = "Neisa";
			flags[kFLAGS.NEISA_FOLLOWER] = 1;
			//doNext(riverdungeon.enterDungeon);
		}
		/*
		public function firstTimeLeavingRiverDungeon():void {
			outputText("As the pair of you leave the dungeon Neisa waves off, heading back to town.\n\n");
			outputText("\"<i>Nice going along with you [name], this was worth it. I’m going to go and spend this bling on some well earned reward. See you around up there. If you ever need of my services again I will be at the bar.</i>\"\n\n");
			flags[kFLAGS.
			flags[kFLAGS.NEISA_FOLLOWER] = 2;
			outputText("<i>Working together with another person has taught you how to manage and plan with a group of people. <b>Gained Perk: Basic Leadership</b></i>");
			player.createPerk(PerkLib.BasicLeadership,0,0,0,0);
			player.removeStatusEffect(StatusEffects.RiverDungeonA);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function x():void {
			outputText("Partner what partner?\n\n");
			outputText("\"<i></i>\"\n\n");
		}*/
	}
}