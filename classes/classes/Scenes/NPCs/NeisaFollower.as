/**
 * ...
 * @author Ormael, Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Dungeons.RiverDungeon;
	
	public class NeisaFollower extends NPCAwareContent
	{
		public var riverdungeon:RiverDungeon = new RiverDungeon();
		
		public function NeisaFollower() 
		{}//between 4 and 13 she get her counter go up by 1 each night and if it hit 13 she leave at the morning xD
		//neisa follower flag: 1 - first exploring river dungeon, 2 - after first exploring, 3 - left camp due to not paid weekly paycheck, 4 to 13 - hired and staying in camp (4 to 10 - with PC having not yet paid her weekly paycheck - up to 3 days after deadline stays this way, 11 to 13 - when she's paid in time), 14 - after her affection rise high enough and she move from mercenary to camp member
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
			doNext(riverdungeon.enterDungeon);
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