/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class CeaniScene extends NPCAwareContent
	{
		
		public function CeaniScene() 
		{}

private function bowSkill(diff:Number):Number {
	player.addStatusValue(StatusAffects.Kelt,1,diff);
	if(player.statusAffectv1(StatusAffects.Kelt) >= 100) player.changeStatusValue(StatusAffects.Kelt,1,100);
	return player.statusAffectv1(StatusAffects.Kelt);
}

public function firstmeetingCeani():void
{
	clearOutput();
	outputText("As you wander the beach you suddenly spot a weird fish like creature diving in and out of the wave. At first you mistake it for some kind of local fish until you realise no fish actually has bright pink hairs! Out of nowhere the figure jump out of the water a harpoon at the hand as it throws the weapon at what looks to be a decent sized tuna. You watch in stupor the humanoid chase the Tuna throwing more and more harpoons ");
	outputText("until the fish is finally unable to swim anymore. As you try to ponder what is happening the figure jump out of the water carrying the freshly impaled Tuna. It's a woman... an eleven feet tall monster of a woman with a white underbelly and pitch black glossy skin. You're still looking at her with wide eye when she drop the tuna on the ground with a loud Thump her smiling face with a large whale nose taking notice of you.\n\n");
	outputText("\"<i>Oh... hello I’m Ceani are you from the area I don’t recall seeing you on the beach before.</i>\"\n\n");
	outputText("You're too busy gawking at the huge harpoon still impaled in the tuna to answer the surprisingly gentle orca morph.\n\n");
	outputText("\"<i>Oh that? Its nothing you know. Bet you could learn to do it to with some training if you wanted to.</i>\"\n\n");
	outputText("Really she could teach you how how to use ranged weapon?\n\n");
	outputText("\"<i>Yea sure but I will need a compensation for it because if I’m training you I’m not hunting and I need food to eat.</i>\"\n\n");
	outputText("Her sharp toothed smile tells you she must indeed eat her share of fish daily. You consider her offer for a moment as she leave adding.\n\n");
	outputText("\"<i>If you want some lessons I will be at the beach seeks me out with at least 50 gems.</i>\"\n\n");
	outputText("You head back to camp considering this golden opportunity.\n\n");
	flags[kFLAGS.CEANI_AFFECTION] = 3;
	flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function basicarcherytraining():void
{
	clearOutput();
	player.gems -= 50;
	if (flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 3 && player.statusAffectv1(StatusAffects.Kelt) >= 90) {
		outputText("You seek out Ceani on the beach and ask her if she could resume your training. The both of you head to the training ground. Once there she help you to position yourself properly and throw the javelins. You throw javelins at the targets for a few hours moving to recover your weapon every few shots. ");
		outputText("All the while you have a good show of Ceani sexy oiled skin and JJ cup breast held by her pink bikini. Somehow you manage to ignore the distraction and focus anyway hitting bullseye several time.\n\n");
		outputText("\"<i>You got it, yea just like that, I think this will likely be our last session but before you go I got a special gift for you to commemorate your graduation.</i>\"\n\n");
		outputText("Ceani go to a nearby barrel and pull out a set of harpoon with sea animal design on it.\n\n");
		outputText("\"<i>This is an enchanted weapon and nah it has nothing in particular except the bundle endlessly replenish when emptied. You shouldn't run out of harpoon to throw in battle. People who can properly use these are far and few so I think it's important you have your own set.</i>\"\n\n");
		outputText("Ceani pulls you in, kiss your cheek and walk away swiftly jumping back into the sea. What a thoughtful gift.\n\n");
		flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 4;
		bowSkill(10);
		inventory.takeItem(weaponsrange.SHUNHAR, camp.returnToCampUseTwoHours);
	}
	else if ((flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 2 || flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 3)) {
		outputText("You seek out Ceani on the beach and ask her if she could resume your training. The both of you head to the training ground. Once there she help you to position yourself properly and throw the javelins. You throw javelins at the targets for a few hours moving to recover your weapon every few shots. ");
		outputText("All the while you have a good show of Ceani sexy oiled skin and JJ cup breast held by her pink bikini. She has to regularly remind you to keep the eyes on the target and not on the ‘horizon’.\n\n");
		outputText("\"<i>Your doing well but were far from done you're going to need more training before you can effectively aim at a moving target.</i>\"\n\n");
		outputText("The session ends well, you learned a few tricks but you know all too well you're still far from your teachers skill.\n\n");
		outputText("\"<i>Well you're free to go, I can’t teach you more anyway and there's a barrel of fish by that otter girl fisherwoman just waiting for me. Come back tomorrow for more training.</i>\"\n\n");
		outputText("You head back to camp resolving to visit her again to resume training.\n\n");
		if (flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 2) flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 3;
		flags[kFLAGS.CEANI_DAILY_TRAINING] = 1;
		bowSkill(10);
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("You seek out Ceani on the beach and ask her if she could train you in the use of ranged weapon.\n\n");
		outputText("\"<i>First take these you will need them for the training.</i>\"\n\n");
		outputText("She hands you a pack of javelins. They look of fairly good quality even if they are novices weapons.\n\n");
		outputText("\"<i>I've set up a few targets on the beach we will be practicing there. Now if you don’t have any question let us begin.</i>\"\n\n");
		outputText("The two of you head to the shooting range. Once there she quickly teach you how to position yourself properly and throw the javelins. You throw javelins at the targets for a few hours moving to recover your weapon every few shots. All the while you have a good show of Ceani sexy oiled skin and JJ cup breast held by her pink bikini. She has to regularly remind you to keep the eyes on the target and not on the ‘horizon’.\n\n");
		outputText("\"<i>Your doing well but were barely getting started you're going to need more training before you can effectively aim at a moving target.</i>\"\n\n");
		outputText("The session ends well, you learned a few tricks but you know all too well you're still far from your teachers skill.\n\n");
		outputText("\"<i>Well you're free to go, I can’t teach you more anyway and there's a barrel of fish by that otter girl fisherwoman just waiting for me. Come back tomorrow for more training.</i>\"\n\n");
		outputText("You head back to camp resolving to visit her again to resume training.\n\n");
		flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 2;
		flags[kFLAGS.CEANI_DAILY_TRAINING] = 1;
		if (player.findStatusAffect(StatusAffects.Kelt) < 0) {
			player.createStatusAffect(StatusAffects.Kelt, 10, 0, 0, 0);
		}
		else bowSkill(10);
		inventory.takeItem(weaponsrange.TRJAVEL, camp.returnToCampUseTwoHours);
	}
}

	}
}