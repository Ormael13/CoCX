/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.ImpLord;
import classes.Scenes.NPCs.Siegweird;
import classes.display.SpriteDb;

public class SiegweirdFollower extends NPCAwareContent
	{
		
		public function SiegweirdFollower() 
		{}

public function siegweirdFirstEncounter():void
{
	//spriteSelect(SpriteDb.);
	clearOutput();
	outputText("As you are traveling through the blight ridge you notice something, or someone sticking out like a beacon of light amongst the corpses. It is a tall, masculine figure adorned in full plate armor. The being stands faced away from you, bent toward the ground as if in search of something\n\n");
	outputText("He radiates a strong divine aura, it is clear that corruption is the furthest thing you could draw from him. Should you approach him? Unfortunately for you, this choice is not yours to make as the figure turns around to face you. The interior of his helmet is too dim to make out who or what is inside.\n\n");
	outputText("He slowly approaches you, the clang of heavy metal slams against the ground with each heavy footstep. His pace grows slower, nearing a complete halt as he seems to survey you with intensity. Despite his tall stance, there’s an air of uncertainty hovering around him.\n\n");
	outputText("He raises an arm, as if to grab your attention, \"<i>You there. I… Um… I could really use some help, would you be willing to offer some?</i>\"\n\n");
	outputText("He mumbles softly to himself.\n\nHis gaze shifts back to meet yours, speaking before you have a chance to decide if you want to help him or not. \"<i>An imp has stolen my sword… It’s more than an ordinary sword. It is my holy greatsword. I would be indebted to you if you could find it for me… I would go, but…</i>\"\n\n");
	outputText("He shakes his head softly before shifting his attention back to you. He doesn’t say a word, so you take this time to decide if you want to help him or not.\n");
	menu();
	addButton(1, "Help him", siegweirdFirstEncounterHelpHim).hint("Helping him may lead to recrutiment (if all went according to the plan) so that will lock out chance to get Alvina. So think carefully fi you sure you want get him over Alvina.");
	addButton(3, "Do not help him", siegweirdFirstEncounterDoNotHelpHim).hint("Later on PC will be still able meet him and get offer to help.");
}
public function siegweirdFirstEncounterHelpHim():void
{
	//spriteSelect(SpriteDb.);
	clearOutput();
	outputText("You start searching for the imp in question. Minutes pass and suddenly an imp pops seemingly out of nowhere, trying to attack you with the greatsword you were looking for!\n\n");
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 2;
	player.createStatusEffect(StatusEffects.SiegweirdImp,0,0,0,0);
	startCombat(new ImpLord());
}
public function siegweirdFirstEncounterDoNotHelpHim():void
{
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function siegweirdFirstEncounterPostFight():void
{
	outputText("You kick the imp away and take the sword. You can only hope he’s still near where you last saw him.\n\n");
	outputText("You eventually find him not too far from where you first met him. He notices you and quickly approaches, the heavy sound of his geaves smash against the ground until he halts before you.\n\n");
	outputText("\"<i>My sword! Thank you, you have a paladin’s deepest gratitude.</i>\" \n\n He removes his helmet, revealing a purely white ursine face, he appears to be a polar bear. \n\n\"<i>You may call me Siegweird, friend…</i>\" his voice trails off slightly before his eyes regain focus onto you, \"");
	outputText("\"<i>And you are?</i> \n\n You state your name. \n\n\"<i>Wonderful, it is a pleasure to meet you, [name]. Perhaps we could venture together, I’m sure that you are wholly capable of fighting off demons as well.</i>\"");
	cleanupAfterCombat();
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3) siegweirdFirstEncounterPostFightAnotherFight();
	else siegweirdFirstEncounterPostFightJoin();
}
public function siegweirdFirstEncounterPostFightJoin():void
{
	outputText("A paladin?\n\n");
	outputText("He stands proudly, \"<i>Yes, a righteous, holy warrior… I am trained in white magic as well as with this sword. If you’d let me, I’m sure there’s plenty of things we could teach each other.</i>\"\n\n");
	outputText("Would you like to invite Siegweird to your camp? The presence of someone so vibrantly holy and devout will surely become a nuisance to those who are far more inclined toward corruption.\n\n");
	menu();
	addButton(1, "Yes", siegweirdFirstEncounterPostFightJoinYes);
	addButton(3, "No", siegweirdFirstEncounterPostFightJoinNo);
}
public function siegweirdFirstEncounterPostFightJoinYes():void
{
	outputText("You would gladly have someone such as him in your camp.\n\n His face curls into a grin from ear to ear, \“<i>Thank you, [name]. I… I will not disappoint you! Now, lead the way, I will walk alongside you.</i>\”");
	outputText("\n\n You guide Siegweird to your camp, he smiles softly as he surveys the area.\n\n Once he’s found a place he’s content with he quickly builds a fire pit before reaching into his knapsack and pulling out a large cast iron pot.\n\n");
	outputText("He sets everything up before igniting the flame.\n\n\"<i>I got some Soup! Call it a hero's feast, [name]. Feel free to ask me for some if you’re ever hungry.</i>\"");
	outputText("\n\n<b>Siegweird has joined you as a follower.</b>\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 12;
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2.5) {
		flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 4;
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 4;
		doNext(camp.returnToCampUseSixHours);
	}
}
public function siegweirdFirstEncounterPostFightJoinNo():void
{
	outputText("It may not be the best to have such a luminous beacon marching in your camp. Not only does his armor cause a ludicrous amount of noise, his powerful aura will surely illuminate your camp for anyone who wants to corrupt the pure.\n\n");
	outputText("Siegweird nods softly, \"<i>I understand if you do not wish for me to accompany you, I suppose I shall remain here if you need me.</i>\"\n\n");
	outputText("You nod respectfully before heading back to camp.\n\n");
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2.5) doNext(camp.returnToCampUseOneHour);
	else {
		flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 2.5;
		doNext(camp.returnToCampUseSixHours);
	}
}
public function siegweirdFirstEncounterPostFightAnotherFight():void
{
	outputText("The suit of armor notices your demonic outlook as his helmet slowly illuminates with a brilliant golden light. You can see an enraged expression on his face before it’s too bright to see anything within his helmet.\n\n");
	outputText("\"<i>No! Can’t believe I was helped out by a demon! Have I been so blind? Was this all a test? NO! I WILL NOT FAIL! I WILL PURGE YOU AND YOUR CORRUPTION FROM THIS LAND, FIEND!”</i>\"");
	startCombat(new Siegweird());
}
public function siegweirdFirstEncounterPostFightAnotherFightWon():void
{
	outputText("Siegweird stumbles back, falling to his knees, unable to fight any longer. The glowing radiance from his eyes dim as his helm ceases to glow. He keeps himself propped up as he clutches onto his massive sword, head lowered to the ground. A golden, pearly substance cascades from his helmet, pooling on the ground before him before he falls prone on the ground.\n\n");
	outputText("The radiance he once emitted has now faded to the dull luster of his blood-stained armor. \"<i>I was too weak…</i>\" he mumbles, not looking up to face you. \“<i>I cannot do anything… I amount to nothing… Who was I fooling..?</i>\"\n\n");
	outputText("You approach the knight, he’s still mumbling words of self-depreciation, hardly paying any attention to you at this point. \n\n");
	outputText("You pick him up by the helmet, his limp body does not attempt fighting back, he’s utterly defeated. His massive limbs are weighing him down, lifting him is almost a struggle as his entire body desperately clutches onto the force of gravity.\n\n");
	outputText("He looks past you, still mumbling to himself, \"<i> I’m nothing… worthless… Marae was wrong to trust me to carry out their duties.</i>\"\n\n Is this knight going to shut up?\n\n");
	outputText("You tighten your grip around him before twisting his neck with an audible snap. Finally, some peace from his mutterings.You drop his corpse onto the ground, it falls with a heavy clang. What a pity; his body lies there, now utterly lifeless. You collect his holy symbol as proof of his demise. Alvina will be content with your success.\n\n");
	outputText("<b>You obtained Siegweird's holy symbol!</b>\n\n");
	player.createKeyItem("Siegweird's holy symbol", 0, 0, 0, 0);
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 3;
	doNext(camp.returnToCampUseSixHours);
}
public function siegweirdFirstEncounterPostFightAnotherFightLost():void
{
	outputText("Siegweird doesn't hesitate upon defeating you, the last thing you see is his sword rushing for your neck as he finishes you off.\n\n");
	EventParser.gameOver();
}

public function siegweirdRepeatEncounterPostFight():void
{
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3) {
		clearOutput();
		outputText("It takes a while to find Siegweird. For a guy completely covered in full plate, he moves surprisingly fast along the blight ridge.\n\nHe seems to be in search of something… You’re positive the object of his search is someone you’ve gotten to know quite well recently.\n\n");
		outputText("He’s quick to notice you, despite the fact that you haven’t made any attempt to announce your presence.\n\n");
		outputText("\"<i>So, you came back after all... I should've known... You've been working with this witch from the start haven't you?</i>\” He shakes his head, \"<i>The voices in my head tell me ‘run away’, but I will not turn back, lest I go astray. I don't know what she promised you but in the end you will come to regret it, be it by my blade or by some twisted machinations she may have prepared for you.</i>\"\n\n");
		outputText("You’re here for his life and his pendant. You know you’re not leaving without it..\n\n");
		outputText("He raises his greatsword to his gauntlet, running his hand over it, infusing it with holy energy before pointing it toward you.");
		outputText("\"<i>You’re going to have to pry it from my cold, dead hands, fiend.</i>\"\n\n");
		startCombat(new Siegweird());
	}
	else if (flags[kFLAGS.ALVINA_FOLLOWER] > 12) {
		outputText("It may not be the best to have such a luminous beacon marching in your camp. Not only does his armor cause a ludicrous amount of noise, his powerful aura will surely illuminate your camp for anyone who wants to corrupt the pure. Is he really versed well enough in magic to be worth recruitment?\n\n");
		outputText("Before you can weigh your options, he speaks up, \"<i>I would love to spend more time with you, but alas, my quarry vanished from her lair recently. I cannot settle down while evil runs rampant. I must say farewell to you, brave hero, may luck always be on your path. Perhaps one day long from now we will meet again...</i>\"\n\n");
		outputText("He leaves without another word.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("While exploring the Blight Ridge, you find Siegweird. The opening in his helmet is glowing with golden brilliance as he is surrounded by several demon corpses.\n\n");
		outputText("He notices you and the light dims as he approaches you. For a moment you can see his face within the helmet before it becomes too dark to make out even a silhouette.\n\n");
		outputText("\"<i>Good afternoon [name], your company is most welcome. I cannot talk much right now, unless you wanted to invite me to your camp..?</i>\"\n\n");
		menu();
		addButton(1, "Yes", siegweirdFirstEncounterPostFightJoinYes);
		addButton(3, "No", siegweirdFirstEncounterPostFightJoinNo);
	}
}

public function siegweirdMainCampMenu():void
{
	//spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You wave a hearty hello to Siegweird in which he responds with a respectful nod,");
	outputText("\"<i>[name]... Is there something you wanted?</i>\"\n\n");
	menu();
	if (player.statusEffectv1(StatusEffects.SiegweirdSoup) == 1) addButtonDisabled(5, "Soup", "You already ate today bowl of Siegweird’s soup.");
	else addButton(5, "Soup", siegweirdCampSoup);
	if ((player.hasItem(consumables.ICICLE_, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup1) < 1) || (player.hasItem(consumables.CANINEP, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup2) < 1) || (player.hasItem(consumables.BAYRLEA, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup3) < 1) || (player.hasItem(consumables.SALAMFW, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup4) < 1) || 
	(player.hasItem(consumables.LABOVA_, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup5) < 1) || (player.hasItem(consumables.RINGFIG, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup1) < 1) || (player.hasItem(consumables.ALICORN, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup2) < 1) || (player.hasItem(consumables.WOFRUIT, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup3) < 1) || 
	(player.hasItem(consumables.MAGSEED, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup4) < 1) || (player.hasItem(consumables.NOCELIQ, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup5) < 1) || (player.hasItem(consumables.GODMEAD, 1) && player.statusEffectv3(StatusEffects.SiegweirdSoup1) < 1)) addButton(9, "Add an ingredient", siegweirdCampSoup2);
	else addButtonDisabled(9, "Add an ingredient", "Need to have one of those: Icicle, Canine pepper, Bayr leaf, Firemander whisky, La bova, Ringtail fig, Alicornium, Wonder fruit, Magic seed, Nocello or God Mead to be able to improve soup.");
	if (player.hasStatusEffect(StatusEffects.SiegweirdTraining)) addButtonDisabled(10, "Study", "You already completed basic Study.");
	else addButton(10, "Study", siegweirdCampStudy);
	if (player.hasStatusEffect(StatusEffects.SiegweirdTraining) && !player.hasStatusEffect(StatusEffects.SiegweirdTraining2)) addButton(11, "Advanced Study", siegweirdAdvancedCampStudy);
	if (player.hasStatusEffect(StatusEffects.SiegweirdTraining2)) {
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 0 && player.hasItem(useables.DIAMOND, 1) && player.hasItem(useables.S_INGOT, 1) && (player.hasItem(useables.DBAPLAT, 1) || player.hasItem(useables.TBAPLAT, 1))) addButton(11, "Advanced Study", siegweirdAdvancedCampStudy);
		else addButtonDisabled(11, "Advanced Study", "You need to gather a perfect Diamond, Silver ingot and a piece of bark from oldest tree (Marae) before you can progress.");
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 1) {
			if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 10) addButtonDisabled(11, "Advanced Study", "You need to wait until Siegweird ends his work. (It may take around three days)");
			else addButton(11, "Advanced Study", siegweirdAdvancedCampStudy);
		}
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 2) {
			if (player.hasKeyItem("Alvina's Shattered Phylactery") >= 0) addButton(11, "Advanced Study", siegweirdAdvancedCampStudy);
			else addButtonDisabled(11, "Advanced Study", "You need to go kill a certain dangerous devil in Blight Ridge.");
		}
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 3) addButtonDisabled(11, "Advanced Study", "You already completed Advanced Study.");
	}
	addButton(14, "Back", camp.campFollowers);
}

public function siegweirdCampSoup():void
{
	clearOutput();
	if (player.hasStatusEffect(StatusEffects.SiegweirdSoup)) {
		outputText("You politely ask Siegweird if he could give you a bowl.\n\n");
		outputText("\"<i>Sure there's plenty to share and enjoy! Bottoms up, [name], let us never forget or purpose here!</i>\"\n\n");
		outputText("You share the meal with Siegweird, the magical soup replenishing your endurance and healing your wounds.\n\n");
		player.addStatusValue(StatusEffects.SiegweirdSoup, 1, 1);
		player.hunger = player.maxHunger();
		var recoveryV:Number = 0.25;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup1) == 1) recoveryV += 0.05;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup2) == 1) recoveryV += 0.05;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup3) == 1) recoveryV += 0.05;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup4) == 1) recoveryV += 0.05;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup5) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup1) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup2) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup3) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup4) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup5) == 1) recoveryV += 0.05;
		if (player.statusEffectv3(StatusEffects.SiegweirdSoup1) == 1) recoveryV += 0.05;
		HPChange(Math.round(player.maxHP() * recoveryV), true);
		EngineCore.changeFatigue(-(Math.round(player.maxFatigue() * recoveryV)));
		doNext(camp.campFollowers);
		cheatTime2(15);
	}
	else {
		outputText("The smell of Siegwierd’s soup is amazing. He did offer to share it with you, so perhaps now isn’t a bad time?\n\nYou decide to approach him.\n\n");
		outputText("He looks at you with gleams of hope in his eyes, \"<i> [name]! Come here for my famous home cooked soup? More than just a hearty meal, it will help ease off the stress of the day and maybe give you a little edge in combat. I’ll only allow you one servering per day though… I don’t want to go broke making soup every day for myself and everyone else you know.</i>\"\n\n");
		outputText("Is it possible to improve the soup? It smells wonderful already.\n\n");
		outputText("\"<i>I mean, sure if you find some special ingredients across Mareth. I suppose it wouldn't be an issue..?</i>\"\n\n");
		player.createStatusEffect(StatusEffects.SiegweirdSoup, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup1, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup2, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup3, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup4, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup5, 0, 0, 0, 0);
		menu();
		addButton(14, "Back", siegweirdMainCampMenu);
	}
}
public function siegweirdCampSoup2():void
{
	clearOutput();
	outputText("You ask Siegweird if he wouldn’t mind allowing you to add something to his recipe so that the soup could be better.\n\n");
	outputText("Siegweird gives you a suspicious glance before redirecting his attention to the item in your grasp, \"<i>I… Um… Okay… Go ahead, [name]. I don’t really see an issue with that ingredient. </i>\"");
	outputText("You drop it in the soup as Siegweird scratches the back of his head nervously, \"<i>I’m sure the magic within will make the soup a little stronger.</i>\"\n\n");
	if (player.hasItem(consumables.ICICLE_, 1)) {
		player.destroyItems(consumables.ICICLE_, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup1, 1, 1);
	}
	if (player.hasItem(consumables.CANINEP, 1)) {
		player.destroyItems(consumables.CANINEP, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup2, 1, 1);
	}
	if (player.hasItem(consumables.BAYRLEA, 1)) {
		player.destroyItems(consumables.BAYRLEA, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup3, 1, 1);
	}
	if (player.hasItem(consumables.SALAMFW, 1)) {
		player.destroyItems(consumables.SALAMFW, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup4, 1, 1);
	}
	if (player.hasItem(consumables.LABOVA_, 1)) {
		player.destroyItems(consumables.LABOVA_, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup5, 1, 1);
	}
	if (player.hasItem(consumables.RINGFIG, 1)) {
		player.destroyItems(consumables.RINGFIG, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup1, 2, 1);
	}
	if (player.hasItem(consumables.ALICORN, 1)) {
		player.destroyItems(consumables.ALICORN, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup2, 2, 1);
	}
	if (player.hasItem(consumables.WOFRUIT, 1)) {
		player.destroyItems(consumables.WOFRUIT, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup3, 2, 1);
	}
	if (player.hasItem(consumables.MAGSEED, 1)) {
		player.destroyItems(consumables.MAGSEED, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup4, 2, 1);
	}
	if (player.hasItem(consumables.NOCELIQ, 1)) {
		player.destroyItems(consumables.NOCELIQ, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup5, 2, 1);
	}
	if (player.hasItem(consumables.GODMEAD, 1)) {
		player.destroyItems(consumables.GODMEAD, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup1, 3, 1);
	}
	doNext(camp.campFollowers);
	cheatTime2(5);
}

public function siegweirdCampStudy():void
{
	//spriteSelect(SpriteDb.);
	clearOutput();
	outputText("You tell Siegweird you would like to learn more about white magic.\n\n");
	outputText("He looks toward you with hints of worry, \"<i>Yes, right… This is one of the things I can help you with. I’m afraid I’m not the best of teachers, but there are many things I can show you to fight against the demon’s corruptive influences.</i>\"\n\n");
	if (player.cor > 30) {
		outputText("Siegweird eyes you narrowly, \"<i>I’m sorry, [name]... but I cannot teach someone who cannot learn. Please, if you seek to study then you must purge yourself from excess corruption. </i>\"\n\n");
		outputText("You nod your head, you shouldn’t be surprised a paladin can’t teach the impure.")
		doNext(camp.campFollowers);
		cheatTime2(5);
	}
	else {
		outputText("Seigweird eyes you narrowly, \"<i>Yes, you are ready to learn, we shall work together. </i>\"\n\n");
		outputText("He takes a deep breath, \"<i>We will start with the fundamentals. White magic has been practiced for millennia by priests and knights. It’s been mainly used to imbue equipment or regenerate wounds. Keep in mind that white and black magic are two sides of the same coin, while one focuses on presence of mind, the other focuses on the raw power of emotions, not just lust, but the demons harness that emotion to their benefit the most. I personally prefer white magic as I need to always keep a keeness of wit, lest my emotions take control... Anyway, I will now lay down a few pieces of equipment on the ground. I want you to take your time and enchant each of them with magic. This should improve your casting endurance as well as the quality of your enchantments");
		outputText("\n\n");
		outputText("I want you to take your time and enchant each of them with magic. This should improve your casting endurance as well as the quality of your enchantments.</i>\"\n\n");
		if (player.inte > 70 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 6) {
			outputText("A few pieces was a literal joke on the bear’s part, what he displayed was nothing short of his full inventory! You spend the entire day enchanting armor pieces and weapons. It's quite an exhausting task but you eventually finish enchanting the last item. In the end, it wasn’t as exhausting as before and, truth be told, you have tons of energy left! Siegweird takes a look at your work, nodding..\n\n");
			outputText("\"<i>Yes, that should do, you seem to be ready for the next step, however, you should first purge your mind of corruption entirely.</i>\"\n\n");
			player.createStatusEffect(StatusEffects.SiegweirdTraining, 0, 0, 0, 0);
			dynStats("inte", 10, "cor", -3);
			player.fatigue = player.maxFatigue();
			flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 7;
		}
		else if (player.inte > 50 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 5) {
			outputText("A few pieces was a literal joke on the bear’s part, what he displayed was nothing short of his full inventory! You spend the entire day enchanting armor pieces and weapons. It's quite an exhausting task but you eventually finish enchanting the last item. You feel yourself growing better each time you try. Siegweird examines your progress and nods. \n\n");
			outputText("\"<i>Great job so far but you can still improve. Come back again when you are rested, then we can resume the training.</i>\"\n\n");
			dynStats("inte", 7, "cor", -2);
			player.fatigue = player.maxFatigue();
			flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 6;
		}
		else {
			outputText("A few pieces was a literal joke on the bear’s part, what he displayed was nothing short of his full inventory! You spend the entire day enchanting armor pieces and weapons. It's quite an exhausting task and truth be told, you ran out of energy way before you were finished enchanting the last piece of gear.\n\n");
			outputText("\"<i>You are only starting so it's normal that you are exhausted. Come back again when you are rested, then we can resume the training.</i>\"\n\n");
			dynStats("inte", 4, "cor", -1);
			player.fatigue = player.maxFatigue();
			flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 5;
		}
		doNext(camp.returnToCampUseSixHours);
	}
}

public function siegweirdAdvancedCampStudy():void
{
	if (player.hasStatusEffect(StatusEffects.SiegweirdTraining2)) {
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 2) {
			player.removeKeyItem("Alvina's Shattered Phylactery");
			outputText("Siegweird notices that you have the pendant as soon as you come near him, giving you a cheerful smile.\n\n");
			outputText("\"<i>[name]..! You… You did it! Something I know I could never do... You have helped the cause of purity more than you might think. We now have one less threat to deal with, thank you [player]</i>\"\n\n");
			outputText("Siegweird pulls you in for a fierce hug. He retracts before pulling something from his knapsack,");
			outputText("\"<i>Here, this tome is for you. I have mastered the ability in my own way, and now I want you to learn it by your own accord.</i>");
			outputText("<b>You gained a tome of Meteor Shower.</b>\n\n");
			player.addStatusValue(StatusEffects.SiegweirdTraining2, 1, 1);
			inventory.takeItem(consumables.MET_SHO, camp.campFollowers);
			cheatTime2(5);
		}
		else if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 1 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 10) {
			outputText("Siegweird notices your presence and stops hammering on his portable anvil to look at you with a cheerful smile… or at least what you can see through the small hole in his helmet.\n\n");
			outputText("\"<i>Hey hello [name]!I finished your holy symbol, it should empower your white magic ability further. Consider this your graduation gift.</i>\"\n\n");
			outputText("He brings over the fruits of his labor and hands it to you. The holy symbol shines with an inner light that simply cannot be snuffed out. You feel serene and safe with this item on you and thank Siegweird for it.\n\n");
			outputText("\"<i>No need to thank me friend. Say I think I will stay in your camp a little longer. There's enough imps around here to keep me working for weeks! Also I will prepare a curative soup every day, so feel free to come by and take a bowl.</i>\"\n\n");
			outputText("<b>You gained a Holy Symbol. +20% to white spells and white healing magic spellpower.</b>\n\n");
			player.createKeyItem("Holy Symbol", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.SiegweirdTraining2, 1, 1);
			doNext(camp.campFollowers);
			cheatTime2(5);
		}
		else {
			player.destroyItems(useables.DIAMOND, 1);
			player.destroyItems(useables.S_INGOT, 1);
			if (player.hasItem(useables.DBAPLAT, 1)) player.destroyItems(useables.DBAPLAT, 1);
			else player.destroyItems(useables.TBAPLAT, 1);
			outputText("You bring the ingredients to Siegweird, he inspects them carefully before nodding his head,");
			outputText("\"<i>Amazing! This’ll take me about a day to complete... I need you to do a favor for me in the meantime. See, I wasn’t wandering the blight ridges for no reason, I was hunting a very specific demoness.</i>\"\n\n");
			outputText("He sighs softly, \"<i>I was unable to find her during my endeavors... Her name is Alvina, rumored to be the creator of black magic and perhaps even the source of demonic corruption. I don’t know her full story but what I am sure about is that even the other demons whisper her name in hushed tones, so she ought to be fearsome even by their standards. I would request that you find and slay her. Only then would I know you are ready, and I assure you that your efforts will be rewarded.</i>\"\n\n");
			outputText("Seigweird pauses for a moment before inspecting all of the ingredients within his paw before setting it on the ground.\n\n");
			outputText("\"<i>Hmm, this’ll be a little more difficult than I thought… You go ahead, [name]...</i>\"\n\n");
			outputText("His hands begin glowing as he gets to work with making you the holy amulet.\n\n");
			player.addStatusValue(StatusEffects.SiegweirdTraining2, 1, 1);
			doNext(camp.campFollowers);
			cheatTime2(5);
		}
	}
	else {
		if (player.cor > 0) {
			outputText("You ask Siegweird about those extra lessons.\n\n");
			outputText("\"<i>Sorry, such teachings cannot be learned by someone with even a sliver of corruption in their being.</i>\"\n\n");
		}
		else {
			outputText("You ask Siegweird about those extra lessons.\n\n");
			outputText("\"Yes, you look about ready to me, so let’s begin with the facts. To channel white magic to its fullest you will also need a holy symbol. While white magic was created by mortals, its origin lies deeper in the roots of divine magic, this belonging to the gods. ");
			outputText("Making a holy symbol is as easy as carving a cross out of wood however, the material will increase the potency of the item. Marae is among these deities, her bark has the greatest potency, I wish you well in retrieving it from her. You also need to find a silver ingot, the material would serve as the casing. ");
			outputText("Finally, a perfect diamond will be the ornament. You should get going and start looking for these items, they are somewhat rare.</i>\"\n\n");
			player.createStatusEffect(StatusEffects.SiegweirdTraining2, 0, 0, 0, 0);
		}
		doNext(camp.campFollowers);
		cheatTime2(5);
	}
}

	}

}