/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.display.SpriteDb;

	public class WerefoxScene extends BaseContent
	{
		
		public function WerefoxScene() 
		{}

public function werefoxFemaleInnerDesertEncounter():void {
	flags[kFLAGS.WEREFOX_EXTRAS] = 1;
	werefoxInnerDesertEncounter();
}
public function werefoxMaleInnerDesertEncounter():void {
	flags[kFLAGS.WEREFOX_EXTRAS] = 2;
	werefoxInnerDesertEncounter();
}
public function werefoxInnerDesertEncounter():void {
	var isFemale:Boolean = false;
	if (flags[kFLAGS.WEREFOX_EXTRAS] == 1) isFemale = true;
	outputText("As you explore the sleeping land of Mareth, you begin to feel as if something was stalking you, a presence just out of your line of sight.");
	if (player.hasDarkVision()) outputText("Your night-adapted eyes allow you to quickly notice a white-furred "+(isFemale?"fe":"")+"male figure skulking towards you, the shadows doing a decent job at concealing "+(isFemale?"her":"him")+"...But not from you. "+(isFemale?"Sh":"H")+"e pounces at you, but you saw "+(isFemale?"her":"him")+" coming. You easily dodge "+(isFemale?"her":"his")+" attack, readying for battle.");
	else outputText("Out of nowhere a fur-covered figure hits you from the side, bringing you down to the ground. You quickly shove it off, you manage to shove "+(isFemale?"her":"him")+" back, and you see your assailant clearly for the first time. "+(isFemale?"Sh":"H")+"e appears to be a fox "+(isFemale?"girl":"boy")+" of some sort.");
	outputText(""+(isFemale?"Sh":"H")+"e growls at you as "+(isFemale?"sh":"h")+"e circles your position, claws and fangs out in a menacing display as "+(isFemale?"sh":"h")+"e looks for an opening. This "+(isFemale?"Sh":"H")+"e-fox seems intent on fighting you.");
	startCombat(new Werefox());
}
public function werefoxFemaleOuterDeepDesertEncounter():void {
	flags[kFLAGS.WEREFOX_EXTRAS] = 3;
	werefoxOuterDeepDesertEncounter();
}
public function werefoxMaleOuterDeepDesertEncounter():void {
	flags[kFLAGS.WEREFOX_EXTRAS] = 4;
	werefoxOuterDeepDesertEncounter();
}
public function werefoxOuterDeepDesertEncounter():void {
	var isFemale:Boolean = false;
	if (flags[kFLAGS.WEREFOX_EXTRAS] == 3) isFemale = true;
	outputText("As you explore the sleeping land of Mareth, you begin to feel as if something was stalking you, a presence just out of your line of sight.");
	if (player.hasDarkVision()) outputText("Your night-adapted eyes allow you to quickly notice a white-furred "+(isFemale?"fe":"")+"male figure skulking towards you, the shadows doing a decent job at concealing "+(isFemale?"her":"him")+"...But not from you. "+(isFemale?"Sh":"H")+"e pounces at you, but you saw "+(isFemale?"her":"him")+" coming. You easily dodge "+(isFemale?"her":"his")+" attack, readying for battle.");
	else outputText("Out of nowhere a shadowy pounce on you and it’s barely if you manage to shove "+(isFemale?"her":"him")+" back after overcoming the surprise attack. You focus your vision on your opponent and determine it to be a fox "+(isFemale?"girl":"boy")+" of some sort.");
	outputText(""+(isFemale?"Sh":"H")+"e growls at you as "+(isFemale?"sh":"h")+"e circles your position, claws and fangs out in a menacing display as "+(isFemale?"sh":"h")+"e looks for an opening. This "+(isFemale?"Sh":"H")+"e-fox seems intent on fighting you.");
	startCombat(new Werefox());
}
public function lostToWerefox():void {
	clearOutput();
	//spriteSelect(SpriteDb.s_DarkElf);
	outputText("As you hit the ground, the werefox approaches you with a vicious smile.\n\n");
	outputText("\"<i>It's your lucky night, intruder. My elders aren't around at the moment, so I have you all to myself. Sweet dreams...</i>\" [monster He] laughs and, without warning, knocks you out.\n\n");
	outputText("You awaken a few minutes later and assess the damage. ");
	var stolen:Number = 7 + rand(14);
	if (flags[kFLAGS.SPIRIT_STONES] > 0) {
		if (flags[kFLAGS.SPIRIT_STONES] < stolen) stolen = flags[kFLAGS.SPIRIT_STONES];
		flags[kFLAGS.SPIRIT_STONES] -= stolen;
		outputText("Your spirit stones pouch seems suspiciously light. Checking inside you note the [monster he]-fox took "+stolen+" spirit stones. Angry and poorer up you drag your sorry self back to camp.\n\n");
	}
	else {
		if (player.gems > 0) {
			stolen *= 20;
			if (player.gems < stolen) stolen = player.gems;
			player.gems -= stolen;
			outputText("Your gems pouch seems suspiciously light. Checking inside you note the [monster he]-fox took "+stolen+" gems. Angry and poorer up you drag your sorry self back to camp.\n\n");
		}
		else {
			outputText("There are marks drawn all over your face! It take about thirty minutes to completely scrub off in the nearby oasis. You could swear you heard some mirthful snickering among the trees while you were cleaning yourself off. Then you drag your sorry self back to camp.\n\n");
			dynStats("lus", -(player.maxLust() * 0.2), "scale", false);
		}
	}
	cleanupAfterCombat();
}
public function wonWithWerefox():void {
	clearOutput();
	//spriteSelect(SpriteDb.s_DarkElf);
	outputText("The werefox falls to the ground, thoroughly defeated. It snarls defiantly at you, but you know this is a facade and that if you wanted to have your way with [monster him], all you need to do is push [monster him] on [monster his] back and get to work. ");
	outputText("Suddenly, [monster he] throws a runed scroll at you. As it flies towards you, it forms a small dome forms around you, trapping you inside. When the dome fades away, there is no sign of werefox.\n\n");
	cleanupAfterCombat();
}

public function werefoxEncounter():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	outputText("\n\n");
	startCombat(new Werefox());
}

	}

}