/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

	public class TyrantiaFollower extends NPCAwareContent
	{
		
		public function TyrantiaFollower() 
		{
		}
/*
public function tyraniaAffection(changes:Number = 0):Number {
	flags[kFLAGS.DIANA_AFFECTION] += changes; - use savable stat tracker tyraniaAffection not flag? / same for her lover status? / what else set as non flags aside flag for lvl_up and defeat_counter?
	if (flags[kFLAGS.DIANA_AFFECTION] > 100) flags[kFLAGS.DIANA_AFFECTION] = 100;
	return flags[kFLAGS.DIANA_AFFECTION];
}
*/
public function firstEncounter():void {
	clearOutput();
	outputText("You decide to visit the ruined battlefield. The great, ruined land is much quieter than normal, and you take the opportunity to look around more than usual. Iron pipes, remains of arcane-looking devices, and bodies...Lots of bodies. This place reminds you of ghost stories from Ignam: Two gods fighting in a God’s battleground, equally matched. They kill each other, and all the spirits of their dead followers remain to settle the score.\n\n");
	outputText("A harsh laugh rings through the air, coupled with the screech of shattering stone.Instinctively, you crouch behind the remains of a shattered wall. Do you investigate?");
	menu();
	addButton(1, "Yes", firstEncounterYes);
	addButton(3, "No", firstEncounterNo);
}
public function firstEncounterYes():void {
	clearOutput();
	outputText("You decide to peek over the wall, and what you see is strange, even for Mareth. What appears to be a spider-mech holding a dick-bladed spear is tearing a group of golems apart. The smaller stone constructs rush the spider-mech, but their arms bounce off the juggernaut’s armor. Upon closer inspection, the spider-mech’s humanoid front is covered with two pairs of giant metal tits, complete with embossed nipples.\n\n");
	outputText("Almost absently, two of its metal legs sink into two downed golems, metal blades cracking the stone with shocking ease. A stone flies past your hiding spot, and you flinch. The rubble under your feet grinds, and as the final golem falls, its head snapped clean off by the giant spider...Woman? She growls, in a low voice.\n\n");
	outputText("\"<i>Okay, Tyrantia, stop playing around with your food. Find that demon cunt who’s been summoning them.</i>\" As she turns towards you, you see the first indication of organic life under all that steel. She wears a half-helm, and her fangs gleam in the sunlight. ");
	outputText("Five purple eyes shine under the helm, wary and alert. Twin horns poke out from holes in her helmet, black as night. She’s clearly heard you move, but as she looks back and forth, she doesn’t seem to know where you are yet.\n\n");
	menu();
	addButton(1, "Hide", firstEncounterYesHide);
	addButton(3, "No Hiding", firstEncounterYesNoHiding);
}
public function firstEncounterYesHide():void {
	clearOutput();
	outputText("\"<i>Who’s there?</i>\" She demands, brandishing her Dick from side to side. \"<i>I know you’re here, summoner. Come on out, or I’ll smash more of your toys...then you.</i>\" She sniffs the air, and walks the opposite direction from where you’re hiding. You breathe a sigh of relief, but as you do, you hear the scuttling of arachnid footsteps. Your hiding place, the section of wall, is ripped from the ground, tossed to one side.\n\n");
	outputText("\"<i>So...Who are you?</i>\" Her voice is low, for a woman, but she’s clearly a female...Then again, Mareth has taught you the foolishness of such assumptions.\n\n");
	menu();
	addButton(1, "Fight", firstEncounterYesHideFight);
	addButton(3, "Surrender", firstEncounterYesHideSurrender);
}
public function firstEncounterYesHideFight():void {
	clearOutput();
	outputText("You ready your [weapon], and she sighs. \"<i>Really?</i>\" she shakes her head. \"<i>Fine. Let’s rumble.</i>\"\n\n");
	startCombat(new Tyrantia());
	doNext(playerMenu);
}
public function firstEncounterYesHideSurrender():void {
	clearOutput();
	outputText("You raise your hands, explaining that you don’t want a fight, and that you weren’t the one controlling the golems.\n\n");
	outputText("\"<i>A likely story. You act as if I haven’t fought your kind of cowardly builder-types before.</i>\" She folds her arms, lowering her spear…\n\n");
	outputText("and dodges to one side as another golem comes hurtling through the space her upper body had been in before. She grabs it before it can hit you, spinning the hundreds of pounds of stone like a toy before slamming it into the ground, where it shatters.\n\n");
	outputText("She looks at the golem leg in her hands, looks at you, looks back at the leg...then shrugs. \"<i>Okay, fair enough. Stupid thing wanted to hit you too.</i>\" A demon incubus claws his way out of the ruins, but the spider-giant turns, whipping the golem’s arm at the creature. It crushes the luckless demon’s skull, and she turns back to you, completely unphased.\n\n");
	outputText("\"<i>So...who are you?</i>\" You tell her your name, that you’re a champion from Ignam, and that you’re no fan of demons either. \"<i>No Kiddin’? Well shit. Name’s Tyrantia. Sorry. I’m a bit busy right now, so why don’t you come back another time, and we’ll get a fresh start, okay?</i>\"\n\n");
	//some affection gains here?
	doNext(camp.returnToCampUseOneHour);
}
public function firstEncounterYesNoHiding():void {
	clearOutput();
	outputText("You pop out and hold your hand out. You yell at her to freeze. Surprisingly, she stops in her tracks, tilting her head and staring at you curiously. \"<i>Why?</i>\"\n\n");
	menu();
	addButton(1, "Dunno", firstEncounterYesNoHidingDunno);
	addButton(2, "T. Police", firstEncounterYesNoHidingTPolice);
	addButton(3, "Fight", firstEncounterYesNoHidingFight);
}
public function firstEncounterYesNoHidingDunno():void {
	clearOutput();
	outputText("You shrug, not really knowing why you’d do that. She looks at you, dumbfounded, for a second, before bursting into uproarious laughter. A bit of black energy pulses around her, making your cheeks flush, but the laughter dies down quickly. \"<i>Y’know, for a little "+player.mf("guy","gal")+", you have some balls.</i>\" ");
	outputText("You tell her that you’re [name], a Champion from Ignam, but she wheels about. A single demon crawls out from underneath a pillar and she turns, running after him. \"<i>Hey, I’ll talk to you another time!</i>\"\n\n");
	//some affection gains here?
	doNext(camp.returnToCampUseOneHour);
}
public function firstEncounterYesNoHidingTPolice():void {
	clearOutput();
	outputText("You declare yourself captain of the titty police. You insist that explosives are illegal and that she turn herself in for having two sets of bomb-ass titties. She drops her Phallus-spear in surprise, looks down at her massive quad breasts, then proceeds to wipe a single tear out of her one non-functioning eye before mustering up a chuckle.\n\n");
	outputText("\"<i>Heh. Heh.</i>\" Her tittering starts slow as it builds into full-on hysterics.\n\n");
	outputText("With the absurdity of the situation, even in a land like Mareth, this is the most amusement you have had in awhile; you can not help but join in. You fall to your knees, laughing so hard your breath escapes from you. As a demon frantically scrambles out from a pillar, throwing itself skyward and away, the two of you laugh even harder, the sight of a seasoned Demon warrior pissing himself as he flees a novel one even for you. She speaks up.\n\n");
	outputText("\"<i>Y’know, you cost me a bounty, shorty.</i>\" She reaches down, ruffling your [hair], \"<i>But I’m not even mad. That was fucking hilarious. I’m Tyrantia, but who are you?</i>\"\n\n");
	outputText("You tell her that you’re [name], a champion from Ignam, and her five functioning eyes light up. \"<i>Oh?</i>\" She gives you a slap on the back. \"<i>Well, you’ve gotta show me what you can do sometime.</i>\" She sobers up a bit. ");
	outputText("\"<i>But not today. I need to find me another demon to fight, and you, "+player.mf("mister","miss")+" ‘titty police’ should find someone else to arrest</i>\" She picks up her spear, giving you a sarcastic salute before striding away.\n\n");
	//+5% affection gains here
	doNext(camp.returnToCampUseOneHour);
}
public function firstEncounterYesNoHidingFight():void {
	clearOutput();
	outputText("You declare that you came here to find a worthy fight. She blinks, looking down at you in surprise. Behind her, a scrawny-looking demon incubus claws his way out from underneath a ruined pillar, taking to the sky. The spider-woman facepalms, inhaling deeply through her nose.\n\n");
	outputText("\"<i>You just cost me a bounty. I hope you’re ready to pay me back.</i>\" You ready your weapon, and she shakes her head. \"<i>Fine. Have it your way, then. I am Tyrantia, little one.</i>\"\n\n");
	startCombat(new Tyrantia());
	doNext(playerMenu);
}
public function firstEncounterNo():void {
	clearOutput();
	outputText("You decide that anyone having fun in this kind of horrid landscape might not be someone you want to meet. Camp is sounding very good right now, and you sneak away while the sounds of grinding stone echo behind you. ");
	doNext(camp.returnToCampUseOneHour);
}
	}
}