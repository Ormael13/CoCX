/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

	public class EbonLabyrinthScenes extends BaseContent
	{
		
		public function EbonLabyrinthScenes() 
		{}
		
		public function encountersRuletteBossesEL1Hydra():void {
			outputText("The first telltale that something might have gone really wrong is the hissing which seems to come from all around the room. The only warning you get of the impending attack is a sudden move of the shadows as a massive snake head bites the air mere inches from your face. You ready for battle as several huge snakes comes out of the shadow, each connected to a single junction to what appears to be the body of a very tall woman.\n\n");
			/*if (player.isNaga()) {
				outputText("\"<i>Why, would you look at that, how did you little grass snake make it all the way here. Are you perhaps lost?</i>\"\n\n");
				outputText("Sometimes you forget that as a naga your body language allows you to understand snakes of all kinds. You reply to the hydra that you're exploring the labyrinth in search of power and treasures.\n\n");
				outputText("\"<i>Um well there's no treasure I know of in this room but perhaps if you can help me with my arousal problem I’d be willing to give you something close to the first. A hydra scale, nothing short, nothing less. That is of course if becoming like me is of any interest to poor puny you. So how about it?</i>\"\n\n");
				menu();
				addButton(1, "Sex", encountersRuletteBossesEL1HydraSex);
				addButton(2, "Pass", encountersRuletteBossesEL1HydraPass);
				addButton(3, "Fight", encountersRuletteBossesEL1HydraFight);
			}
			else {*/
				outputText("She hisses in perfect coordination with the snakes, her slitted eyes fixating you obsessively, as a drooling gaping slit at the junction between the snakes and her human body tells you exactly what she wants from you. You don't feel you should indulge her however and as such ready to battle.\n\n");
				startCombat(new Hydra(), true);
			//}
		}
		public function encountersRuletteBossesEL1HydraOthers():void {
			outputText("She hisses in perfect coordination with the snakes, her slitted eyes fixating you obsessively, as a drooling gaping slit at the junction between the snakes and her human body tells you exactly what she wants from you. You don't feel you should indulge her however and as such ready to battle.\n\n");
			startCombat(new Hydra(), true);
		}
		public function encountersRuletteBossesEL1HydraSex():void {
			outputText("Clearly no cock in the world aside from those of a giant way bigger then your own size would ever fit her massive cunt. This said you got something way bigger then a cock. Her eyes widen and she drools from all six mouths in anticipation as you coil your tail around a nearby wooden log into a spring shape. You made a fleshy dildo three meters long and at least 20 inch thick just for her.\n\n");
			outputText("Without asking for permission the horny hydra picks up your coiled tail and shove it inside her gaping maw of a cunt using your entire tail length up to the thigh to fuck herself like never before. You take great care not to uncoil your tail until your feel her clamping and drenching you all the way to the shoulder in giantess juices. The hydra, now fully satisfied pulls you out and depose you on the ground.\n\n");
			outputText("\"<i>Oh god, it's been so long since I last touched myself. Here you may have this.</i>\"\n\n");
			outputText("She hands you a large scale easily as big as your hand making it clear that you must eat it to gain its power before waving you off.\n\n");
			outputText("\"<i>Stay safe down here little grass snake, not everyone is friendly and I’d hate to think you could be eaten.</i>\"\n\n");
			inventory.takeItem(consumables.HYDRASC, playerMenu);
		}
		public function encountersRuletteBossesEL1HydraPass():void {
			outputText("You decline politely but say you will think about it. The semi disappointed hydra shrugs and lets you exit the room.\n\n");
			doNext(playerMenu);
		}
		public function encountersRuletteBossesEL1HydraFight():void {
			outputText("Wearing a crown seemingly made of goop, this regal purple woman sits on a pair of stone slabs which serves it as a makeshift throne.\n\n");
			startCombat(new Hydra(), true);
		}
		
		public function encountersRuletteBossesEL1HellSnail():void {
			if (player.hasPerk(PerkLib.FireAffinity) && flags[kFLAGS.HELLFIRE_SNAIL_ENC] == 1) {
				outputText("You turn the corner expecting to run into yet another monster out to badly hurt you but sigh in relief as you run into the fire snail girl instead.\n\n");
				outputText("\"<i>Hey it's you again. Having fun down there?</i>\"\n\n");
				outputText("Well you could say that, in a way, yes you are having fun down there.\n\n");
				outputText("\"<i>So uh I've been getting antsy of late could you help me out with…</i>\"\n\n");
				outputText("You shut her up right away with a smoldering kiss of your own. Burning pleasure running down your spine as she cover you with her blanket like undercarriage. You return her hug by gently imprinting your hands into her generous breasts. ");
				HellfireSnailSex();
				inventory.takeItem(consumables.FSNAILS, playerMenu);
			}
			else {
				outputText("As you turn the corner you run into what appears to be a massive rock blocking the passage. You try to move it but"+(player.tallness < 120 ? " to no avail the thing is as heavy as it looks. Your hand begins to burn up as":"")+" the rock suddenly raise in temperature and you swiftly remove them before being burnt. You are set on your guard as a feminine voice calls out.\n\n");
				outputText("\"<i>Hey who's the pervert molesting my ass!?! This is most unfair! Share back the fun!</i>\"\n\n");
				outputText("The rock now red with heat begins to seethe magma as something not unlike a reddish tail slides out from beneath it. On the other side the torso of a comely humanoid woman appears or you would call it human if not for the red skin, glowing ember eyes, drooling mouth and two antenna poking from the front atop her blazing hair! ");
				outputText("The volcanic snail girl eyes you with the kind of drooly obsessed expression you've only seen on slime girls and her intentions become clear as day, she intends to force herself on you!\n\n");
				if (flags[kFLAGS.HELLFIRE_SNAIL_ENC] < 1) flags[kFLAGS.HELLFIRE_SNAIL_ENC] = 1;
				startCombat(new HellfireSnail(), true);
			}
		}
		
		public function HellfireSnailSex():void {
			outputText("The she snail giggle at your pleasant attention and begin to grind her lubricated pussy against "+(player.hasCock() ? "your burning cock" : "yours")+" in earnest. Blazing goop and other fluids begins to mingle as the two of you make it out the other residents of the labyrinth either oblivious or too scared to interfere with your smoldering mating session. ");
			outputText("This might also be because the both of you spray fire and lava everywhere as part of mating and despite you both being immune to each other the unlooker likely wouldn't. The mating is deliberately slow, gentle and calculated with no single movement wasted as unlike most of Mareth denizen your current partner likes it nice and slow taking her time to make everything count.\n\n");
			outputText("You reach your peak and erupt in orgasm your partner following short mere seconds after");
			if (player.hasCock()) outputText(" as you fill her smoldering lovehole with "+player.race+" seeds");
			if (!player.hasCock()) outputText(" as your girl juice mix with hers");
			outputText(".\n\n\"<i>Uwaaa so long since last I had real sex, most of my partners dies before I even reach the climax. Thank you so much hun for helping me out.</i>\"\n\n");
			outputText("Hey if this can help her be less of a hazard to everyone around her then why not, your glad she appreciates it.\n\n");
			outputText("\"<i>Hey before you go have a vial of this, I don't know if you will find it useful but who knows.</i>\"\n\n");
			outputText("She hands you a vial of her saliva before you head out back in the labyrinth and resume your exploration.\n\n");
			player.orgasm();
		}
	}
}