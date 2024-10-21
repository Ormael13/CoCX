/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Hair;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.OniIncubus;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

use namespace CoC;
	
public class ChiChiFollower extends NPCAwareContent implements TimeAwareInterface, SaveableState
{
	public var ChiChiCorruption:int;	//scale from 0-10	//9+ come to camp
	public var ChiChiFertile:Boolean;
	public var ChiChiKickedOut:Boolean;
	public var ChiChiDefurred:Boolean;
	public var kihaInteractionHappened:Boolean;
	public var jojoInteractionHappened:Boolean;
	public var joyInteractionHappened:Boolean;
	public var ayaneInteractionHappened:Boolean;
	public var ceaniInteractionHappened:Boolean;
	public var lunaInteractionHappened:Boolean;
	public var bimboPatchInteractionHappened:Boolean;
	public var amilyInteractionHappened:Boolean;
	public var heliaInteractionHappened:Boolean;

	public function stateObjectName():String {
		return "ChiChiFollower";
	}

	public function resetState():void {
		ChiChiCorruption = 0;
		ChiChiFertile = false;
		ChiChiKickedOut = false;
		ChiChiDefurred = false;
		kihaInteractionHappened = false;
		jojoInteractionHappened = false;
		joyInteractionHappened = false;
		ayaneInteractionHappened = false;
		ceaniInteractionHappened = false;
		lunaInteractionHappened = false;
		bimboPatchInteractionHappened = false;
		amilyInteractionHappened = false;
		heliaInteractionHappened = false;
	}

	public function saveToObject():Object {
		return {
			"ChiChiCorruption": ChiChiCorruption,
			"ChiChiFertile": ChiChiFertile,
			"ChiChiKickedOut": ChiChiKickedOut,
			"ChiChiDefurred": ChiChiKickedOut,
			"kihaInteractionHappened": kihaInteractionHappened,
			"jojoInteractionHappened": jojoInteractionHappened,
			"joyInteractionHappened": joyInteractionHappened,
			"ayaneInteractionHappened": ayaneInteractionHappened,
			"ceaniInteractionHappened": ceaniInteractionHappened,
			"lunaInteractionHappened": lunaInteractionHappened,
			"bimboPatchInteractionHappened": bimboPatchInteractionHappened,
			"amilyInteractionHappened": amilyInteractionHappened,
			"heliaInteractionHappened": heliaInteractionHappened
		};
	}

	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			ChiChiCorruption = o["ChiChiCorruption"];
			ChiChiFertile = o["ChiChiFertile"];
			ChiChiKickedOut = o["ChiChiKickedOut"];
			ChiChiDefurred = o["ChiChiDefurred"];
			kihaInteractionHappened = o["kihaInteractionHappened"];
			jojoInteractionHappened = o["jojoInteractionHappened"];
			joyInteractionHappened = o["joyInteractionHappened"];
			ayaneInteractionHappened = o["ayaneInteractionHappened"];
			ceaniInteractionHappened = o["ceaniInteractionHappened"];
			lunaInteractionHappened = o["lunaInteractionHappened"];
			bimboPatchInteractionHappened = o["bimboPatchInteractionHappened"];
			amilyInteractionHappened = o["amilyInteractionHappened"];
			heliaInteractionHappened = o["heliaInteractionHappened"];
		} else resetState();
	}

	public var pregnancy:PregnancyStore;

	public function timeChange():Boolean {
		var needNext:Boolean = false;
		pregnancy.pregnancyAdvance();
		if (pregnancy.isPregnant) {
			if (chichiPregUpdate()) needNext = true;
		}
		return needNext;
	}

	public function timeChangeLarge():Boolean {
		if (pregnancy.isPregnant && pregnancy.incubation == 0) {
			chichiGivesBirth();
			pregnancy.knockUpForce(); //Clear Pregnancy
			return true;
		}
		return false;
	}

	public function ChiChiFollower() {
		pregnancy = new PregnancyStore(kFLAGS.CHICHI_PREGNANCY_TYPE, kFLAGS.CHICHI_INCUBATION, 0, 0);
		pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 300, 250, 200, 150, 100, 72, 48);
		EventParser.timeAwareClassAdd(this);
		Saves.registerSaveableState(this);
	}

public function EnterOfTheChiChi():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("You step into the arena once more, but this time your opponent is slightly different. While of small stature like other mice you’ve met in He’Xin’Dao, this mouse morph has pinkish red hair and oriental clothes. She wears a pair of spiked gloves, her fists are clenched slightly at her sides, and she clearly sports a pair of C cup breasts under her clothes. The announcer screams out the participant's names as usual, their enthusiastic introductions is something you’ve grown used to.\n\n");
	outputText("\"<i>In the left corner, coming from another world, [name], Champion of Ingnam! And in the right corner, from a land far away to the east, the martial arts master, Chi Chi of the four winds!</i>\"\n\n");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 0) {
		outputText("You recognize her from the exotic restaraunt here in town. Chi Chi adopts a battle stance as she catches fire, turning into a living inferno.\n\n");
		outputText("\"<i>Today's dishes will be EXTRA spicy. I hope you're used to the heat [name], because I’m about to leave you with fifth-degree burns!!!</i>\"");
	}
	else outputText("Chi Chi, as it’s obviously her name, adopts a battle stance. Her fists, tail and legs suddenly light aflame. You blink in surprise as the heat washes over you. Something tells you this is going to hurt.");
	flags[kFLAGS.CHI_CHI_AFFECTION] = 0;
	flags[kFLAGS.CHI_CHI_LVL_UP] = 1;
	startCombat(new ChiChi());
}

public function WonFirstFight():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("The mouse looks at you in complete disbelief, her shaking voice slowly breaking down as she falls to her knees and coughs blood on the ground.\n\n");
	outputText("\"<i>Is this... my blood... it is... beautiful. I never thought I would see the day when I would finally find...</i>\"\n\n");
	outputText("She smiles as she stands a final time, trying to run toward you to deliver one last punch. But midway, she falls to the ground, still smiling, with an obvious trail of blood on the corner of her mouth. Muttering two last words as her eyes lose their light.\n\n");
	outputText("\"<i>Thank you...</i>\"\n\n");
	outputText("The entire crowd falls silent as the mouse morph hits the sandy arena ground, a small kid starts to cry in background. The medics run to her in a hurry, but scream something about her having died from fatal self-inflicted injuries. You don’t really care however and just pick up her gloves on the ground as a prize for your victory. Surprisingly no-one cheers for you this time, not even the announcer who is normally so talkative. (I sincerely advise that you reload your game without saving unless you are fine with losing access to a lot of important key content.)\n\n");
	flags[kFLAGS.CHI_CHI_FOLLOWER] = 2;
	inventory.takeItem(weapons.MASTGLO, cleanupAfterCombat);
}

public function LostFirstFight():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	if (player.HP < 1) {
		outputText("\"<i>Is that all you’ve got? How dare you even call yourself a champion? You barely know how to fight! You tried but that was <i>not</i> enough. If you intend to call yourself a true warrior, you should seek me out in town. I could teach you...  if you already know the basics. I don’t have time for complete novices.</i>\"\n\n");
		outputText("The mouse girl leaves you half conscious on the arena sand as the medics come to your rescue.\n\n");
	}
	else {
		outputText("Declared the winner, the burning mouse approaches you. She looks angry and it's likely because you forfeited.\n\n");
		outputText("\"<i>I’m disappointed. You pretend to be a champion, yet you seem to consider battles a kid’s game. Do you have any idea what would have happened in a real fight? No demon would back off like this. You seem to have some potential at least, so perhaps someday you should seek me out. I could teach you...  if you already know the basics. I don’t have time for complete novices</i>\"\n\n");
		outputText("The fiery mouse girl leaves you there as she heads out of the ring.\n\n");
	}
	flags[kFLAGS.CHI_CHI_AFFECTION] = 20;
	cleanupAfterCombat();
}

public function WonSecondFight():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Chi Chi looks at you in disbelief, as your last hit propels her brutally into the arena wall, the sheer power of your strike imprinting the mouse's form in the rock.\n\n");
	outputText("Chi Chi falls limp to the ground, barely able to stand as her fire dies out with a puff of smoke. She looks so weak and vulnerable now.\n\n");
	outputText("\"<i>I f..forfeit. You win. P...perhaps I had misjudged you after all. You truly are... hero material.</i>\" She gives a faint fading smile, then falls unconscious to the ground before you, a small scroll falling to her side.\n\n");
	outputText("You have several choices now. You could leave her here to the care of the villagers or you could tend to her yourself. What do you do?\n\n");
	menu();
	addButton(0, "Nurse", WonSecondFightYes);
	addButton(1, "Leave", WonSecondFightNo);
}
public function WonSecondFightNo():void {
	outputText("Likely the proud master would rather have her opponent leave her be than be dishonored any further. You head back toward your camp to rest after this well-earned victory, pocketing the scroll you found on Chi Chi at the same time, as you fail to notice the blood beginning to slowly create a small pool under her.\n\n");
	outputText("A peasant runs to you, stopping you from leaving for a moment.\n\n");
	outputText("\"<i>I’m sorry to tell you this, but your master took a fatal wound to the head. We will bury her in the town graveyard, so if you would like to, you can visit her grave from time to time. Again my most sincere condolences.\"</i>\n\n");
	outputText("You are somewhat shocked to learn that Chi Chi died, did she go all out in this battle to the point it cost her life? You head back to camp trying to figure how such a tragic incident happened in a training session.\n\n");
	flags[kFLAGS.CHI_CHI_FOLLOWER] = 2;
	inventory.takeItem(weapons.MASTGLO, WonSecondFightNo2);
}
public function WonSecondFightNo2():void {
	inventory.takeItem(consumables.SOBLMAN, cleanupAfterCombat);
}
public function WonSecondFightYes():void {
	outputText("Regardless of how harsh she was with you, or the fact she put you in a similar state not so long ago, you decide to help and nurse her out of respect for the teachings and time she gave you.\n\n");
	outputText("Chi Chi has taken a nearly mortal wound to the head that requires immediate bandaging and her abusive use of Overlimit has left her arm and leg bones nearly shattered. It’s unlikely the mouse will fight again for some time, even with her powerful regenerative ability. You start by bandaging her wounds and then you proceed to carry her back to camp, laying her down in your bed. Feeling sleepy after this harsh battle, you lay down to rest next to the mouse. Chi Chi wakes up at this disturbance.\n\n");
	outputText("\"<i>You didn’t have to go this far for me. I was fully aware of the risks, that I would end up injured or worse in the case that I lost. This is the price I’m willing to pay when teaching a student martial arts.</i>\"\n\n");
	outputText("You reply that she’s your sensei and that it’s also the student's duty to look after the master’s well-being. Whether she likes it or not, you will help her recover until she’s ready to go.\n\n");
	outputText("\"<i>A fair answer... however, I’m tired of fighting... I had hoped this one battle would be my last. The lotus monks had a philosophy against the weaponization of martial arts and perhaps they were right. I lost my school and pupils to the demons and swore vengeance upon them, but vengeance breeds hatred and hatred breeds suffering. In the end, I knew I wouldn’t be able to defeat them... that someone else had to deliver justice. Someone like you, [name].</i>\"\n\n");
	outputText("Chi Chi’s face is but a few inches away from yours and for several seconds you look each other in the eye, until she finally takes the initiative, surprising you with a kiss.\n\n");
	outputText("\"<i>My people have a saying... live of battle until the flame dies out and once you find peace and clarity of mind, live from love. You bested me and I have no more need or desire for fighting. However, a new flame is born of our meeting... so...could we...?</i>\"\n\n");
	outputText("You need no more words as you slowly proceed to strip the mouse of her qipao. She gasps, as her bones are clearly still recovering, but doesn’t try to stop you. Her C cup breasts are now displayed to you and you can feel something wet near your leg where her vagina should be. Chi Chi simply waits for you to remove your own clothes, as she is pretty much unable to move.\n\n");
	if (player.hasCock()) {
		outputText("You ");
		if (!player.isNaked()) outputText(" slowly remove your [armor] to");
		outputText(" expose your [cock]. Chi Chi smiles tenderly as she slowly begins to stroke your shaft. Well, she sure seems to recover fast if she can already move her arms however,  despite this, Chi Chi clearly is in pain. Either she is used to it from constant use of Overlimit or she simply put is the biggest sadomasochist ever.\n\n");
		outputText("\"<i>I didn’t get to appreciate it during your training, I hope you will allow me to see what I was missing out on.</i>\"\n\n");
		outputText("You return the feeling by slowly fingering her pussy, her wetness soon coating your fingers. Once both of you are suitably aroused, you begin to align your cock with her mouse pussy. Still remembering Jojo’s vow of chastity, you ask her if this really what she wants.\n\n");
		outputText("\"<i>I’m a monk only by name and trade, not by philosophy. It’s a part of me I’m willing to give up to you... if you would accept to take responsibility.</i>\"\n\n");
		outputText("Of course, you would. You had made up your mind the moment you started nursing her and won’t go back on your choice. Chi Chi sighs in relief as you slowly insert your [cock] into her waiting pussy. She hugs you tight as you gently start to piston in and out of her. Chi Chi seems to enjoy herself and makes it obvious as she kisses you and draws her tongue in. The sex is calm and soothing unlike most of that you have experienced so far with Mareth denizens, ");
		outputText("who tend to prefer different trends or wilder kinks, making this slow and vanilla experience something you cherish. Right now, you take great care not to hurt her, as she has not yet fully recovered from her battle wounds, Chi Chi only breaks the kiss in order to whisper a sweet nothing to you.\n\n");
		outputText("\"<i>When I’m close to you, I feel safe and warm... like a relaxing bath in the hotsprings of my homeland. I hope we can stay like this for a while.</i>\"\n\n");
		outputText("You slowly keep working her hole, the mouse moaning every now and then, panting as her body prepares for climax. You are not so far from yours either as you feel your cock twitching and soon you cum in Chi Chi’s pussy, the mouse reaching her peak at about the same time with a delighted squeak. The two of you bask in the afterglow for a moment and you stay locked with Chi Chi kissing and whispering sweet nothings to you for several minutes. Eventually time runs out and you prepare to leave, but Chi Chi weakly holds your arm.\n\n");
	}
	else {
		outputText("You give her a good view of your [breasts] and [pussy] as you lie down next to her. The mouse weakly moves her arms to hug you, wincing in the act, pushing her breast against yours as she begins to kiss you and seek your tongue. You play with hers for a few minutes, savoring the cinnamony taste of her lips before slowly moving your hand to her breast in order to massage her. Chi Chi gasps through her clenched teeth at first as she clearly hasn’t fully recovered yet, but when you attempt to remove your hand, she stops you right away, her glare enough to make you pause.\n\n");
		outputText("\"<i>Please.. do not let my injuries hinder you... I will be all right... if you are here with me, all will be well.</i>\"\n\n");
		outputText("You comply and resume the slow massaging of her breast, making her moan in delight as you feel her tail entwining with your leg. She weakly moves her hand towards your pussy, eliciting a moan from you as she begins to slowly finger you. Well, she sure seems to recover fast if she can already move her arms however,  despite this, Chi Chi clearly is in pain. Either she is used to it from constant use of Overlimit or she simply put is the biggest sadomasochist ever. You go for her pussy with your other hand and massage her inner folds, both of you pleasuring each other for a while. It is a relaxing experience which allows you to truly connect with her for the first time, as you gently bring each other toward the edge. ");
		outputText("The sex is calm and soothing, unlike most that you have experienced so far with the denizens of Mareth, who tend to prefer different trends or wilder kinks, making this slow and vanilla experience something you cherish, as both of you eventually cum next to each other, Chi Chi tensing then relaxing against you. She is so strong and yet so fragile right now; you take great care not to hurt her further.\n\n ");
	}
	outputText("\"<i>Thank you for staying by my side. I think I am done teaching... it might be a little late to say this but if you would let me stay with you, I want you to know I love...</i>\"\n\n");
	outputText("You cut her short... these feelings are shared. If she wants to have you, then you see no reason to refuse her staying in your camp.\n\n");
	outputText("\"<i>Please take care of my fragile body and heart [name]. I’m not as tough as I look on the inside. I would like you to have my gloves. I will no longer need them now that my long quest is finally over.</i>\"\n\n");
	outputText("She is offering you her gloves, the weapon she has used to defeat so many foes. You carefully remove them from her so not to hurt her as Chi Chi rests her head on your shoulder. You think she is smiling in happiness but it would be difficult for you to see without removing the pair of arms weakly hugging you.\n\n");
	outputText("(<b>Chi Chi has been added to the Lovers menu!</b>)\n\n");
	if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard",1,+1);
	else player.createKeyItem("Radiant shard", 1,0,0,0);
	outputText("\n\n<b>Before fully settling in your camp as if remembering something Chi Chi pulls a shining shard from her inventory and hand it over to you as a gift. You acquired a Radiant shard!</b>");
	flags[kFLAGS.CHI_CHI_SAM_TRAINING] = 3;
	flags[kFLAGS.CHI_CHI_FOLLOWER] = 3;
	flags[kFLAGS.CHI_CHI_LVL_UP] = 1;
	if (player.hasCock()) player.sexReward("vaginalFluids","Dick");
	player.sexReward("vaginalFluids");
	inventory.takeItem(weapons.MASTGLO, WonSecondFightYes2);
}
public function WonSecondFightYes2():void {
	inventory.takeItem(consumables.SOBLMAN, cleanupAfterCombat);
}

public function LostSecondFight():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Chi Chi sighs at your defeated form and jumps out of the ring.\n\n");
	outputText("\"<i>I have nothing more to teach you, though you did fight with courage and valor, you couldn’t defeat me. From now on, you must continue and learn on your own.</i>\"\n\n");
	outputText("You see her leaving, but can’t do much to chase her in your current state. The villagers patch you up and just as you're about to leave for your camp, you find a small scroll on the ground.\n\n");
	flags[kFLAGS.CHI_CHI_FOLLOWER] = 2;
	inventory.takeItem(consumables.SOBLMAN, cleanupAfterCombat);
}

public function WonSparringFight():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Chi Chi bows down, admitting defeat.\n\n");
	outputText("\"<i>Good fight. You aren’t losing your edge, which is good. You will need it to defeat ");
	if (flags[kFLAGS.LETHICE_DEFEATED] < 1) outputText("Lethice");
	else outputText("the remaining greater demons");
	outputText(".</i>\"\n\nYou nod, saying that she did good to. Chi Chi blushes and babbles something akin to a thank you.\n\n");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("She then realises what she is doing and vehemently shakes her head.\n\n");
		outputText("\"<i>It's not like I wanted praise you! Yeah, as if! Even after all this time, your stance is still shaky.. BAAAKA!\"</i>\"\n\n");
		outputText("Chi Chi kicks a rock away in anger and heads back to her training ground.\n\n");
	}
	if (flags[kFLAGS.CHI_CHI_LVL_UP] < 5) {
		flags[kFLAGS.CHI_CHI_DAILY_TRAINING] = 1;
		if (flags[kFLAGS.CHI_CHI_LVL_UP] < 2) flags[kFLAGS.CHI_CHI_LVL_UP] = 2;
		else flags[kFLAGS.CHI_CHI_LVL_UP]++;
	}
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2 && flags[kFLAGS.CHI_CHI_LVL_UP] >= 5) {
		if (flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER] >= 1) flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER]++;
		else flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER] == 9 && flags[kFLAGS.CHI_CHI_LVL_UP] == 5) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 9));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 9), 0, 0);
			flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.CHI_CHI_LVL_UP] = 6;
		}
		if (flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER] == 10 && flags[kFLAGS.CHI_CHI_LVL_UP] == 6) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 10));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 10), 0, 0);
			flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.CHI_CHI_LVL_UP] = 7;
		}
		if (flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER] == 11 && flags[kFLAGS.CHI_CHI_LVL_UP] == 7) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 11));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 11), 0, 0);
			flags[kFLAGS.CHI_CHI_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.CHI_CHI_LVL_UP] = 8;
		}
	}
	cleanupAfterCombat();
}

public function LostSparringFight():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Chi Chi helps you up as you kneel in defeat.\n\n");
	outputText("\"<i>[name] are you ok!? Oh, I knew I shouldn’t have used that move...</i>\"\n\n");
	outputText("You will be all right though you need some rest and more practice.\n\n");
	cleanupAfterCombat();
}

public function MeetingChiChiInHeXinDao():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("You spot Chi Chi meditating by the river. There are various scorched wooden dummies next to her and it’s obvious the monk was practicing her techniques. You barely take two steps towards her before the mouse stands up and looks you straight in the eye.\n\n");
	if (flags[kFLAGS.CHI_CHI_AFFECTION] > 20) {
		outputText("\"<i>I take it you're here to continue our training. Are you ready?</i>\"\n\n");
	}
	else {
		outputText("\"<i>I knew you would be coming. You're here to learn martial arts and it's my duty as a sensei to teach a prospective student.</i>\"\n\n");
		outputText("She sizes you up for a moment.\n\n");
		if (flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] < 16 && !player.hasPerk(PerkLib.Enlightened) && !player.hasPerk(PerkLib.JobMonk)) {
			outputText("\"<i>Sadly, you barely have an understanding of the discipline to begin with. You will need to train with a less experienced master first. I heard a mouse fancying himself a monk wanders the woods, I suggest you seek him out and learn what you can from him first. Once you are done, come back to me.</i>\"\n\n");
			doNext(camp.returnToCampUseOneHour);
            return;
		}
		else {
			outputText("\"<i>I see you’ve had some novice training in the art of the lotus. Not bad but the lotus were pacifists to begin with, what I’m about to teach you is an entirely new discipline, forged in the fire of the demon war. Are you ready?</i>\"\n\n");
			flags[kFLAGS.CHI_CHI_AFFECTION] += 10;
		}
	}
	menu();
	addButton(0, "Yes", TrainingSoulArtsWithChiChi);
	addButton(1, "No", NotReadyForTheTraining);
	addButton(2, "Shop", SoulskilsManualsShop);
	addButton(4, "Leave", SceneLib.hexindao.riverislandVillageStuff);
}

public function MeetingChiChiInHeXinDao2():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Chi Chi cross her arm impatiently.\n\n");
	outputText("\"<i>Anything else I can do for you [name]?</i>\"\n\n");
	menu();
	addButton(0, "Yes", TrainingSoulArtsWithChiChi);
	addButton(1, "No", NotReadyForTheTraining);
	addButton(2, "Shop", SoulskilsManualsShop);
	addButton(4, "Leave", SceneLib.hexindao.riverislandVillageStuff);
}

public function NotReadyForTheTraining():void {
	outputText("You tell her you will come back when you are.\n\n");
	outputText("\"<i>Take your time, there is no shortcut through this.</i>\"\n\n");
	doNext(camp.returnToCampUseOneHour);
}

public function TrainingSoulArtsWithChiChi():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	if (flags[kFLAGS.CHI_CHI_DAILY_TRAINING] < 1) {
		if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 2) {
			outputText("Chi Chi almost seems to be expecting you today, as she simply stands in the middle of the training grounds, arm crossed. You ask her what is the next step of your training.\n\n");
			outputText("\"<i>You have successfully finished all possible tests but the final one. Today, we will see if your training will bear fruit. Your final challenge is to defeat me, your sensei, and prove that you have finally mastered the martial arts. Are you ready?</i>\"\n\n");
			outputText("There is no turning back once you engage her and you know this well. This is a fight you can’t afford to lose, so the question stands. Are you truly ready for it?\n\n");
			menu();
			addButton(0, "No", NotReadyForTheFinalTraining);
			addButton(1, "Yes", VeryReadyForTheFinalTraining);
		}
		else if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 1) {
			outputText("As you head to practice on the dummy, Chi Chi holds you back.\n\n");
			if (flags[kFLAGS.CHI_CHI_AFFECTION] > 60) {
				outputText("You go to see Chi Chi, still a little hesitant to continue this particular lesson.\n\n");
				outputText("\"<i>Good to see you’re back, it’s about time we resume your training.</i>\"\n\n");
			}
			else {
				outputText("\"<i>Not today. You have already mastered the basics. Now, we will delve deeper into the darkest recesses of martial arts. If you want to win a battle, you have to be ready to bleed and suffer for it. The point of this lesson is that while caution is important to avoid unnecessary injuries, it is sometimes better to take an injury than to lose a battle entirely. ");
				outputText("Your opponent uses lust to break your mind and steal your soul, the direct counteragent to lust is pain and rage, pure and simple. If, and only if, you're ready to accept them entirely, can you achieve greater heights of power.</i>\"\n\n");
				outputText("The mouse suddenly strikes at a nearby dummy like lightning. A bloody red aura runs along her body's length as she deals blows that would likely shatter stone and bend the hardest steel. However, as she finishes the target, propelling it toward the ground with such violence that it explodes on impact, you quickly notice the steep price she had to pay to achieve such power. ");
				outputText("Her body is covered with wounds and her arms are limp. She uses what looks like a different ability to heal her wounds, but she clearly looks exhausted.\n\n");
				outputText("\"<i>It’s your turn now... I want you to attack this dummy so hard you will feel your bones crack. Do not stop until the pain is so strong you can no longer fight!</i>\"\n\n");
			}
			outputText("You spend several hours punching the dummy so hard it actually hurts. You feel blood on your fists and legs by the end, however you also feel sturdier as a result, the pain being lighter than the last time.");
			player.HP -= player.maxHP() * 0.5;
			player.trainStat("str", +2, player.trainStatCap("str",75));
			player.trainStat("str", +1, player.trainStatCap("str",100));
			player.trainStat("spe", +2, player.trainStatCap("spe",75));
			player.trainStat("spe", +1, player.trainStatCap("spe",100));
			if (player.str >= 100 && player.spe >= 100) {
				if (!player.hasStatusEffect(StatusEffects.KnowsOverlimit)) {
					outputText(" Chi Chi, noticing that you’re training hard, hands you a scroll.\n\n");
					outputText("\"<i>This is a scroll containing the technique Overlimit. Use it with caution, because if abused, this technique can and WILL kill you.</i>\"\n\n");
					outputText("<b>You learned the martial power Overlimit.</b>\n\n");
					player.createStatusEffect(StatusEffects.KnowsOverlimit, 0, 0, 0, 0);
				}
				flags[kFLAGS.CHI_CHI_SAM_TRAINING] = 2;
				flags[kFLAGS.CHI_CHI_AFFECTION] += 30;
			}
			outputText("\n\n");
			flags[kFLAGS.CHI_CHI_DAILY_TRAINING] = 1;
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			outputText("You're ready to begin your training and tell her as such.\n\n");
			outputText("Chi Chi nods, then proceeds to show you a whole new form of combat, this one much more aggressive than that of the Lotus. Soon you manage to learn a few additional stances, as well as how to control the energy flow in your body to increase the power of an impact. She has you training on the dummies for several hours to increase your stamina. ");
			outputText("As the flow of your movements and energy starts to become automatic, you discover your kicks and punches have become way stronger.");
			if (player.hasPerk(PerkLib.IcyFlesh)) {
				player.trainStat("int", +2, player.trainStatCap("int",75));
				player.trainStat("int", +1, player.trainStatCap("int",100));
			}
			else if (player.hasPerk(PerkLib.HaltedVitals)) {
				player.trainStat("lib", +2, player.trainStatCap("lib",75));
				player.trainStat("lib", +1, player.trainStatCap("lib",100));
			}
			else {
				player.trainStat("tou", +2, player.trainStatCap("tou",75));
				player.trainStat("tou", +1, player.trainStatCap("tou",100));
			}
			if (player.tou >= 100 || (player.hasPerk(PerkLib.IcyFlesh) && player.inte >= 100) || (player.hasPerk(PerkLib.HaltedVitals) && player.lib >= 100)) {
				if (!player.hasPerk(PerkLib.MightyFist)) {
					player.createPerk(PerkLib.MightyFist, 0, 0, 0, 0);
					outputText(" <b>You've gained the Mighty Fist perk.</b>");
				}
				flags[kFLAGS.CHI_CHI_SAM_TRAINING] = 1;
				flags[kFLAGS.CHI_CHI_AFFECTION] += 30;
			}
			outputText("\n\n");
			flags[kFLAGS.CHI_CHI_DAILY_TRAINING] = 1;
			doNext(camp.returnToCampUseFourHours);
		}
	}
	else {
		outputText("Chi Chi respond by the negative.\n\n");
		outputText("\"<i>I meant it as a joke. No not today you are still in a pretty rough shape, pushing training further would compromise your health. Go take a break.</i>\"");
		doNext(MeetingChiChiInHeXinDao2);
	}
}
public function NotReadyForTheFinalTraining():void {
	outputText("You request a temporary reprieve before your final training and Chi Chi nods, letting you go.\n\n");
	doNext(MeetingChiChiInHeXinDao2);
}
public function VeryReadyForTheFinalTraining():void {
	outputText("You are as ready as you can be and will never be more ready than now. It’s time to settle your score with the mouse and you tell her as such.\n\n");
	outputText("\"<i>A proper answer. In which case...</i>\"\n\n");
	outputText("She slams the ground with her closed fist creating a crater the size of a small arena. People go to the border of the makeshift ring, eager to see the pair of you duel. Chi Chi adopts her deadly elemental stance right away.\n\n");
	outputText("\"<i>Prepare yourself!...</i>\"\n\n");
	startCombat(new ChiChi());
}

public function SoulskilsManualsShop():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("\"<i>I’m glad you take your training seriously, [name]. There are various scrolls I can teach you");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) outputText(" but I would need a few spirit stones first");
	outputText(".</i>\"\n\n");
	menu();
	addButton(0, "Ice Fist", SoulskilsManualsShopIceFist);
	addButton(1, "Fire Punch", SoulskilsManualsShopFirePunch);
	addButton(2, "Hurricane Dance", SoulskilsManualsShopHurricaneDance);
	addButton(3, "Earth Stance", SoulskilsManualsShopEarthStance);
	addButton(4, "Punishing Kick", SoulskilsManualsShopPunishingKick);
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 2) addButton(14, "Back", MeetingChiChiInHeXinDao2);
	else addButton(14, "Back", ChiChiCampMainMenu);
}

public function SoulskilsManualsShopIceFist():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("\"<i>This one? Are you sure about that?</i>\"\n\n");
	menu();
	if (player.hasStatusEffect(StatusEffects.KnowsIceFist)) addButtonDisabled(0, "Yes", "You already learned how to use Ice Fist.");
	else addButton(0, "Yes", SoulskilsManualsShopIceFist2);
	addButton(1, "No", SoulskilsManualsShop);
}
public function SoulskilsManualsShopIceFist2():void {
	if (flags[kFLAGS.SPIRIT_STONES] < 5 && flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("\"<i>Sorry [name], but I don’t teach these for free. Get me spirit stones and then I will show you what you want.</i>\"\n\n");
		doNext(SoulskilsManualsShop);
		return;
	}
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 6) outputText("\"<i>Well since we are together I will gladly teach you this technique for free... let me explain so you don’t mock it up and hurt yourself.</i>\"\n\n");
	outputText("Chi Chi nods and begins to give you a full lecture of the technique. Once done, you practice on dummies for a few hours until you finally master it.\n\n");
	outputText("<b>You learned how to use Ice Fist!</b>\n\n");
	if (!player.hasStatusEffect(StatusEffects.KnowsIceFist)) player.createStatusEffect(StatusEffects.KnowsIceFist, 0, 0, 0, 0);
	flags[kFLAGS.SPIRIT_STONES] -= 5;
	doNext(camp.returnToCampUseFourHours);
}

public function SoulskilsManualsShopFirePunch():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("\"<i>This one? Are you sure about that?</i>\"\n\n");
	menu();
	if (player.hasStatusEffect(StatusEffects.KnowsFirePunch)) addButtonDisabled(0, "Yes", "You already learned how to use Fire Punch.");
	else addButton(0, "Yes", SoulskilsManualsShopFirePunch2);
	addButton(1, "No", SoulskilsManualsShop);
}
public function SoulskilsManualsShopFirePunch2():void {
	if (flags[kFLAGS.SPIRIT_STONES] < 5 && flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("\"<i>Sorry [name], but I don’t teach these for free. Get me spirit stones and then I will show you what you want.</i>\"\n\n");
		doNext(SoulskilsManualsShop);
		return;
	}
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 6) outputText("\"<i>Well since we are together I will gladly teach you this technique for free... let me explain so you don’t mock it up and hurt yourself.</i>\"\n\n");
	outputText("Chi Chi nods and begins to give you a full lecture of the technique. Once done, you practice on dummies for a few hours until you finally master it.\n\n");
	outputText("<b>You learned how to use Fire Punch!</b>\n\n");
	if (!player.hasStatusEffect(StatusEffects.KnowsFirePunch)) player.createStatusEffect(StatusEffects.KnowsFirePunch, 0, 0, 0, 0);
	flags[kFLAGS.SPIRIT_STONES] -= 5;
	doNext(camp.returnToCampUseFourHours);
}

public function SoulskilsManualsShopHurricaneDance():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("\"<i>This one? Are you sure about that?</i>\"\n\n");
	menu();
	if (player.hasStatusEffect(StatusEffects.KnowsHurricaneDance)) addButtonDisabled(0, "Yes", "You already learned how to use Hurricane Dance.");
	else addButton(0, "Yes", SoulskilsManualsShopHurricaneDance2);
	addButton(1, "No", SoulskilsManualsShop);
}
public function SoulskilsManualsShopHurricaneDance2():void {
	if (flags[kFLAGS.SPIRIT_STONES] < 5 && flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("\"<i>Sorry [name], but I don’t teach these for free. Get me spirit stones and then I will show you what you want.</i>\"\n\n");
		doNext(SoulskilsManualsShop);
		return;
	}
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 6) outputText("\"<i>Well since we are together I will gladly teach you this technique for free... let me explain so you don’t mock it up and hurt yourself.</i>\"\n\n");
	outputText("Chi Chi nods and begins to give you a full lecture of the technique. Once done, you practice on dummies for a few hours until you finally master it.\n\n");
	outputText("<b>You learned how to use Hurricane Dance!</b>\n\n");
	if (!player.hasStatusEffect(StatusEffects.KnowsHurricaneDance)) player.createStatusEffect(StatusEffects.KnowsHurricaneDance, 0, 0, 0, 0);
	flags[kFLAGS.SPIRIT_STONES] -= 5;
	doNext(camp.returnToCampUseFourHours);
}

public function SoulskilsManualsShopEarthStance():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("\"<i>This one? Are you sure about that?</i>\"\n\n");
	menu();
	if (player.hasStatusEffect(StatusEffects.KnowsEarthStance)) addButtonDisabled(0, "Yes", "You already learned how to use Earth Stance");
	else addButton(0, "Yes", SoulskilsManualsShopEarthStance2);
	addButton(1, "No", SoulskilsManualsShop);
}
public function SoulskilsManualsShopEarthStance2():void {
	if (flags[kFLAGS.SPIRIT_STONES] < 5 && flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("\"<i>Sorry [name], but I don’t teach these for free. Get me spirit stones and then I will show you what you want.</i>\"\n\n");
		doNext(SoulskilsManualsShop);
		return;
	}
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 6) outputText("\"<i>Well since we are together I will gladly teach you this technique for free... let me explain so you don’t mock it up and hurt yourself.</i>\"\n\n");
	outputText("Chi Chi nods and begins to give you a full lecture of the technique. Once done, you practice on dummies for a few hours until you finally master it.\n\n");
	outputText("<b>You learned how to use Earth Stance!</b>\n\n");
	if (!player.hasStatusEffect(StatusEffects.KnowsEarthStance)) player.createStatusEffect(StatusEffects.KnowsEarthStance, 0, 0, 0, 0);
	flags[kFLAGS.SPIRIT_STONES] -= 5;
	doNext(camp.returnToCampUseFourHours);
}

public function SoulskilsManualsShopPunishingKick():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("\"<i>This one? Are you sure about that?</i>\"\n\n");
	menu();
	if (player.hasStatusEffect(StatusEffects.KnowsPunishingKick)) addButtonDisabled(0, "Yes", "You already learned how to use Punishing Kick.");
	else addButton(0, "Yes", SoulskilsManualsShopPunishingKick2);
	addButton(1, "No", SoulskilsManualsShop);
}
public function SoulskilsManualsShopPunishingKick2():void {
	if (flags[kFLAGS.SPIRIT_STONES] < 5 && flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("\"<i>Sorry [name], but I don’t teach these for free. Get me spirit stones and then I will show you what you want.</i>\"\n\n");
		doNext(SoulskilsManualsShop);
		return;
	}
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 6) outputText("\"<i>Well since we are together I will gladly teach you this technique for free... let me explain so you don’t mock it up and hurt yourself.</i>\"\n\n");
	outputText("Chi Chi nods and begins to give you a full lecture of the technique. Once done, you practice on dummies for a few hours until you finally master it.\n\n");
	outputText("<b>You learned how to use Punishing Kick!</b>\n\n");
	if (!player.hasStatusEffect(StatusEffects.KnowsPunishingKick)) player.createStatusEffect(StatusEffects.KnowsPunishingKick, 0, 0, 0, 0);
	flags[kFLAGS.SPIRIT_STONES] -= 5;
	doNext(camp.returnToCampUseFourHours);
}

public function ChiChiCampMainMenu2():void {
	if (!player.hasStatusEffect(StatusEffects.LunaOff) && !player.hasStatusEffect(StatusEffects.LunaWasWarned)) {
		if ((flags[kFLAGS.LUNA_JEALOUSY] > 200 && rand(10) < 4) || (flags[kFLAGS.LUNA_JEALOUSY] > 300 && rand(10) < 8)) mishapsLunaChiChi();
		else ChiChiCampMainMenu();
	}
	else ChiChiCampMainMenu();
}

public function ChiChiCampMainMenu():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	if (rand(4) == 0 && !kihaInteractionHappened && SceneLib.kihaFollower.followerKiha() ) kihaInteraction();
	else if (rand(4) == 0 && !jojoInteractionHappened && player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) jojoInteraction();
	else if (rand(4) == 0 && !joyInteractionHappened && flags[kFLAGS.JOJO_BIMBO_STATE] == 3) joyInteraction();
	else if (rand(4) == 0 && !ayaneInteractionHappened && flags[kFLAGS.AYANE_FOLLOWER] >= 2) ayaneInteraction();
	else if (rand(4) == 0 && !ceaniInteractionHappened && flags[kFLAGS.CEANI_FOLLOWER] > 0) {
		ceaniInteraction();
		return;
	}
	else if (rand(4) == 0 && !lunaInteractionHappened && flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) lunaInteraction();
	else if (rand(4) == 0 && !bimboPatchInteractionHappened && flags[kFLAGS.PATCHOULI_FOLLOWER] >= 6) bimboPatchInteraction();
	else if (rand(4) == 0 && !amilyInteractionHappened && amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) {
		amilyInteraction();
		return;
	}
	else if (rand(4) == 0 && !heliaInteractionHappened && SceneLib.helScene.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) {
		heliaInteraction();
		return;
	}
	else outputText("You go over to Chi Chi who pauses her training to head to you once you are close.\n\n");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) outputText("\"<i>Oh how are you doing, [name]? I just finished a new set of kicks and punches. Did you want us to train together or did you have something else in mind?</i>\" She’s arm crossed waiting on your reply.");
	else outputText("\"<i>So glad to see you [name], you are a sunshine in my life, you know that. So? What did you visit your lovely wife for today?</i>\"");
	if (SceneLib.midokaScene.MidokaAge > 0 && SceneLib.midokaScene.MidokaAge < 4) outputText("\n\n[midokaname] is sleeping in a basket not so far from Chi Chi, such a sweet child.");

	switch (pregnancy.event) {
		case 2:
			outputText("[pg]You notice that Chi-Chi seems to be ill. Of course, you at once go to her and ask her what's wrong, but she only smiles at you and says that it's all right. Your incomprehension must show on your face, since Chi Chi giggles, puts her arms around you and kisses you. \"<i>Silly " + player.mf("boy", "girl") + "... You're going to be a father</i>\"\n\n");
			break;
		case 3:
		case 4: outputText("[pg]Chi-Chi's belly is starting to protrude a little. She's unquestionably pregnant.\n\n");
			break;
		case 5:
		case 6: outputText("[pg]Chi-Chi's belly has gotten very big.\n\n");
			break;
		case 7: outputText("[pg]Chi-Chi's swollen stomach moves on occasion, warranting an unthinking pat from her to calm the restless child within.\n\n");
			break;
		case 8: outputText("[pg]Chi-Chi's bulge frequently wriggles and squirms, though this doesn't seem to bother her. She smiles with glee, the child mustn't have too much longer until it is born.\n\n");
	}
	
	menu();
	addButton(0, "Appearance", chichiAppearance).hint("Examine Chi Chi's detailed appearance.");
	addButton(1, "Talk", chichiTalksMenu);
	addButton(2, "Shop", SoulskilsManualsShop);
	addButton(3, "Spar", chichiSparring)
		.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
	addButton(4, "Sex", chichiSex);
	addButton(14, "Back", camp.campLoversMenu);
}

public function chichiAppearance():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Chi Chi is a hinezumi, a subspecies of mouse morph with fiery affinities. Hair are fiery red, the strands turning pink at the tip the same color as the rest of her fur. Her face is that of a mouse with the characteristic buck teeths and twitching nose and her embery eyes have a serious expression to them which, unlike Jojo" + (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 ? " who is now Joy,":"") + " do warn those she teaches to that she will be merciless.");
	if (ChiChiCorruption >= 90) outputText(" She has grown twin embery horns up her forehead.");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 6) outputText(" That said Chi Chi tends to soften around you thanks to the feelings you both share. She wears the ruby ring you gave her at all time, symbol and reminder of your love.");
	outputText("\n\nHer body is well toned and battle trained from years of martial training. She wears a qipao from her homeland at all time. Chi Chi has the standard mouse morph small frame, albeit her shapely D cup breasts, with a "+(ChiChiCorruption >= 90?"spaded tail":"mouse tail") + " and pawed hands and feet but what makes her special is her natural ability to ignite herself. ");
	outputText("Her leg and arms are constantly covered with flamelike fireballs and her tail glow like smoldering ember its tip ending with a strand of fire."+(ChiChiCorruption >= 90?" Her her fire has blazing trails of purple instead of its usual color palette, showing further signs of her corruption.":"")+" You sometime ponder how come the simple act of touching her does not burn you to death, likely it's because she can control these flames like extension of her body.\n\n");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("She gives you an annoyed glance as she notices that you are examining her.\n\n");
		outputText("\"<i>What are you looking at Baka? I can’t concentrate on my training if you're undressing me with your perverted gaze!</i>\"\n\n");
		outputText("You reply that you weren't.\n\n");
		outputText("\"<i>Yea as if I will believe that.</i>\"\n\n");
	}
	else {
		outputText("Chi Chi amused gives you a coy expression.\n\n");
		outputText("\"<i>You know if you want to disrobe me so badly we could just go to the next step.</i>\"\n\n");
		outputText("You reply that for now you were just having a look.\n\n");
		outputText("\"<i>Your loss [name].</i>\"\n\n");
	}
	menu();
	addButton(14, "Back", ChiChiCampMainMenu);
}

public function chichiTalksMenu():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("\"<i>What did you want to talk about? I need to keep training to maintain shape.</i>\"\n\n");
	menu();
	addButton(0, "M. Arts", chichiTalksMartialArts);
	addButton(1, "F. Students", chichiTalksFormerStudents);
	addButton(2, "Fiery Hair", chichiTalksFieryFairTrouble).disableIf(player.hairType != Hair.BURNING, "You need flaming hair for this topic to be relatable...");
	addButton(3, "Her Fur", talkAboutFur).disableIf(ChiChiDefurred, "She doesn't have fur anymore...");
	addButton(14, "Back", ChiChiCampMainMenu);
	
}
public function chichiTalksMartialArts():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Where and how did she learn to fight?\n\n");
	outputText("\"<i>Ah, that was a long time ago. I was from the very eastern lands from beyond the mountains. Most of what I learned was from a... old creature I met in a cave, hidden behind a waterfall. He had scales green as emeralds yet a body like that of a snake. His eyes were full of wisdom and wisdom he was willing to share, even to a little girl like me... he told me... he told me that one day perhaps the future of Mareth might depend on my ability to teach what he would impart to me. After ten years under his tutelage I founded my own martial arts school and began teaching promising students what he had imparted on me. You were the first pupil I had in ages...</i>\"\n\n");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("She is looking at you with dreamy eyes for a second before shaking her head and resuming punching the nearest dummy.\n\n");
		outputText("\"<i>Gah, do you know how long my best pupils took to learn even half of what you did?! He did it in one day and...</i>\"\n\n");
		outputText("And how does she explain her defeat then?\n\n");
		outputText("\"<i>I let you win! It was just a test of your willpower, you hear me?! ... BAKA!</i>\"\n\n");
		outputText("She resumes furiously kicking at the dummy, her cheeks are bright red in anger. Or perhaps it's something else? You decide not to pry to avoid getting kicked in the face. Truth be told however it’s also to prevent her from harming herself as she still needs to recover from her wounds.\n\n");
	}
	doNext(chichiTalksMenu);
	cheatTime(1/4);
}
public function chichiTalksFormerStudents():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("She said she had former students before. What happened to them?\n\n");
	outputText("Chi Chi hands suddenly tremble and shake... as if she was containing her fury.\n\n");
	outputText("\"<i>Dead... all dead by my hands.</i>\"\n\n");
	outputText("She slams the back of her first into a nearby dummy, which explodes into hundreds of small ash fragments.");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) outputText(" Her hand is bleeding but she pays it no attention, the wounds slowly closing.");
	outputText("\n\n\"<i>I used to be a teacher in a school... those were more peaceful days. I can still remember the blossoming cherry trees and my five students faces. They all worked very hard to learn the techniques... all but one.</i>\"\n\n");
	outputText("A shadow falls on her face and you can feel her anger rising as she gets to the less agreeable part.\n\n");
	outputText("\"<i>A few weeks away from graduation, the demons came in and stormed the village, taking down everyone they could find. But I held strong, fighting in the eye of the storm and slaying the fiends as they came. Unable to reach me, the demons went for my students, corrupting them in order to grow their number... I can still remember their plea as they begged me to save them. But I lost them one by one, too far away to reach them in time... I still hear their screams, this squirrel girl who perished in the fire, that monkey boy who I blew to smithereens to release him from his suffering. ");
	outputText("Each of my own beloved students I had to put down for their own sakes... all of this mess wouldn’t have happened if an idiot I shall not name hadn't opened the town gates to the demons, betraying us all so he could gain power. I fought him and would've killed him if not for the fact the demons covered his escape.</i>\"\n\n");
	outputText("Is she still haunted by the people she killed?\n\n");
	outputText("\"<i>Sometimes... the regret weighs heavily on me. I had been searching for a way to properly end my life. Probably at the hands of a warrior strong enough to kill me, even if by accident. For several years I wandered the roads of Mareth challenging pretending heroes to duels and destroying demons and never finding the defeat I so craved. When you lost to me in the arena, I saw an opportunity and trained you. ");
	outputText("In the end, I was ready to finally die by your hands but you showed mercy on me, denying me death, healing my wounds and my heart when I needed it the most. You showed me that there was still something left in the world for me to accomplish, just as my sensei foretold. For this alone I am in your debt, [name].</i>\"\n\n");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) {
		outputText("She suddenly realizes she’s about to kiss you and stops, before suddenly turning around to kick a dummy in what could have been your crotch.\n\n");
		outputText("\"<i>Baka! I swear, I'd have won if I had tried harder from the start. Also, since you almost shattered all my bones to pieces, you will have to take care of me, ok? And only of me, because I have seen you around the other girls and I’m seriously beginning to think you are a shameless pervert.</i>\"\n\n");
		outputText("Isn’t that because she is jealous of what you could do with the other girls that she is angry?");
		if (player.cor > 33) outputText(" If she wasn’t such a blockhead, you might even show her in for a three-way.");
		outputText("\n\n\"<i>You’re being silly. As if I would ever be interested in a...</i>\"\n\n");
		outputText("Like that night the two of you shared after she regained consciousness perhaps?\n\n");
		outputText("\"<i>That does not count! Arghhh be gone, I got training to do!</i>\"\n\n");
		outputText("She resumes furiously smashing the target, though you wonder if the red on her cheeks is because she is angry or something else altogether. You decide to give her a break before she actually opens her injuries by striking the other dummies or your face with such strength that they also explode.\n\n");
	}
	doNext(chichiTalksMenu);
	cheatTime(1/4);
}
private function chichiTalksFieryFairTrouble():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("Okay seriously you need to know. She's an hinezumi yet her hairs don't just end up with burning tips that set everything on fire… how?[pg]");
	outputText("\"<i>Oh that? It's simple, I just don't let them grow enough that the tips starts to smoke or turn to smoldering embers. My hairs are as hot as yours and would burn on the tip too but if I keep them short enough they simply stop to just being hot and that's it.</i>\"[pg]");
	outputText("Well now. You didn't think her exotic haircut was for more than just looking fancy. That's practical indeed.[pg]");
	doNext(chichiTalksMenu);
	cheatTime(1/4);
}

public function chichiSparring():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("You ask Chi Chi if she would like a friendly spar");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) outputText(" now that she has recovered a little");
	outputText(".\n\n\"<i>Well I don’t see why not. It would be nice to have a battle where I won’t put my life on the line for once.</i>\"");
	outputText("Both of you head to the ring and Chi Chi takes on her fighting pose.\n\n");
	outputText("\"<i>Don’t worry about me, I won’t need to go all out this time.</i>\"");
	startCombat(new ChiChi());
}


	public function ChiChiDrunkSex():void {
		clearOutput();
		spriteSelect(SpriteDb.s_chichi);
		outputText("As you enter the bar you hear a feminine laughter swiftly spotting what seems to be ");
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 1 && flags[kFLAGS.CHI_CHI_AFFECTION] >= 20) outputText("Chi Chi");
		else if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 1 && flags[kFLAGS.CHI_CHI_AFFECTION] < 20) outputText("Chi Chi the waitress from the exotic food restaurant");
		else outputText("a blazing mouse girl");
		outputText(" sitting on one of the stool drinking sake.\n\n");
		outputText("\"<i>Yeah, and after I told it I was the top girl here I punched it in the face, Woooooooo!</i>\"\n\n");
		outputText("The barman sighs, pretending not to notice the drunken mouse, acknowledging her just to pass her another drink. Just as you are about to order something she realises you are there and engages in conversation.\n\n");
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2) outputText("\"<i>Gaaaaah, [name], why do you hang around all those girls. Worse why do you fuck with them and not me?! Its like you are a " + player.mf("go-go boy","cheap whore") + " selling your body to everyone and thish drives me mad! Yeaaa, I’m going to prove them all I’m the top shlut!</i>\"");
		else if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 1) outputText("\"<i>Hey... you’re that so-called champ who lost in the arena?! Well I like you. I like you so much I’d want you as my " + player.mf("boy","girl") + "friend... but waaaah I’m way too shy to tell you that right! Well don’t go tell [name] I like " + player.mf("him","her") + " got it? Yeah, who cares about that! Barman, a round for [name] the best person I've ever met, woooo. Now let’s have sex!</i>\"\n\n");
		else outputText("\"<i>Hey you... yesh you, the tall person over there! Think you can fight?! Well I’m pretty sure nobody in this village hash the guts to anyway. If you show up in the arena, I'sh gonna beat the crap outta you... \"</i> She grins drunkenly, grabbing at your crotch with one hand. \" <i>Now that I think of it...Fightin' and fuckin'... I can beat anyone in both! I'sh Bet you're the kind who fucks every demon you meet. Well, not tonight, letsh bang!</i>\"");
		outputText("Wait, what? You barely have the time to mutter a reply before the red cheeked mousette pushes you on the nearest table and climbs over you. The barman pulls a curtain around your table, he must be used to this.\n\n");
		outputText("\"<i>Yeshh you heard me you big idiot. I’m going to fuck you here and now! So don’t you dare try to run! You'sh wouldn't get far, and that would make...Momma...Mad.</i>\"\n\n");
		outputText("Do you let her?\n\n");
		menu();
		addButton(0, "Let Her", drunksex,true);
		addButton(1, "Refuse", drunksex,false);
		addButton(2, "SpikeDrink", spikeDrink).disableIf(player.corAdjustedDown < 60 || !player.hasItem(consumables.SUCMILK), "Be corrupt and have Succubus Milk");
	}
	private function drunksex(selected:Boolean):void {
		clearOutput();
		if (!selected) {
			outputText("" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 0 ? "Chi Chi" : "The mouse") + " is clearly out of it. Better stop her now before she does something she will regret later. You shove her to the side and run for the exit of the bar. She swears profusely, but falls over when she tries to chase you. Once outside, you duck behind the side of the bar, taking a roundabout way out of He'Din Xiao and back to camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		else {
			outputText("You would have to be an idiot indeed to refuse this free fuck. The drunken mouse girl licks her lips in anticipation, grabbing your clothes and begins to removing them one-by-one. Unsurprisingly, her own clothes barely take a second to remove. She is so close now you can feel her breath on your neck.");
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) {
				outputText(" The mousette introduces herself.\n\n");
				outputText("\"<i>My name’s Chi Chi by the way, but... oh why does it matter? We are about to have a lot of fun.</i>\"");
			} else if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 6) {
				outputText("Chi Chi makes a blissful smile before whispering sweetly to you.[pg]");
				outputText("“<i>I’ve got you exactly just where I want you now, [name]... and I will never let go.</i>”[pg]");
			}
			sceneHunter.selectGender(dickF, vagF);

			//===============================
			function dickF():void {
				outputText(" Chi Chi initiates with a wet but warm kiss, her tongue dancing a tango with yours. While small in stature, she displays an uncommon level of strength rarely seen even among animal morphs. What’s more concerning is that you aren't sure how her burning tail and fur isn't actually setting everything on fire around her, especially you. You inquire on this matter.\n\n");
				outputText("\"<i>That’sh because I’m burning with passion for you big idiot! My flamesh won’t burn anything I wish not to. Or maybe they will. I never recalled how that one inn caught fire. Just you wait, I'll set both of our body aflame with desire. Your cock will be as hot as my embers.</i>\"\n\n");
				outputText("Well it's too late to back down anyway and, even if you did, the drunken megamouse is clearly going to keep you pinned down. Not to make your partner wait anymore, you slowly tease the entrance of her warm canal with your [cock]. If anything, despite being wet you can already feel how hot her oven is from the outside and can’t help but hope you won’t end up burned. Chi Chi however has no such concern and out of impatience starts stroking your dick with her embery tail.\n\n");
				outputText("\"<i>Come on, I know you want to put it in. What are you waiting for dumbassh?! I’m positively burning here.</i>\"\n\n");
				outputText("You're surprised by the direct contact with her fiery tail, even more so by the fact that it didn’t leave your dick with a third degree burn. Deciding to give the hot mouse what she wants, you put it in. Her vagina immediately starts milking you as if it was a thirsty mouth seeking water, and the frantic moving of her hips up down doesn’t help it.\n\n");
				outputText("\"<i>Gah doushe me! Don’t you shee how much I’m burning! Put that fire out with your manwater!</i>\"\n\n");
				outputText("Her pussy starts heating even more, transferring to your shaft rapidly. Your shaft warms, then begins to burn, each movement sending the heat down your legs and into your stomach. It's so hot you can’t think straight anymore, only the cool passage of cum can free you from this heat! You begin to piston in and out of Chi Chi desperate for a cooling release.\n\n");
				outputText("Both desperate for a way to get rid of the heat, the two of you manage to cum together, your jizz filling Chi Chi to the brim before slowly dripping on the ground. Chi Chi sighs in relief, falling limp on the table.\n\n");
				outputText("\"<i>" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 ? "You're the besht [name] you know that? Let'sh do thish again sometimes, I jusht can’t get enough of it." : "You're a good [boyfriend] you know that? Let'sh do thish again sometimes.") + "</i>\"\n\n");
				outputText("Her eyes close, and you breathe a sigh of relief as her breathing slows. Groaning through your own exhaustion, you force yourself up, gently placing her back on the table. You wince, aching groin sending shivers through you, but you stagger up,  leaving the bar. You consider it wise to leave before Chi-Chi wakes up." + (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3 ? " Especially because you're pretty sure she will beat you to death if she discovers the two of you had sex while she was drunk" : "") + ". You exit the bar, and as you leave, the barkeep sighs in relief. He motions to a bouncer, and the two men gingerly wrap Chi-Chi in the curtain and carry her out of the bar. From the extremely worried looks on their faces, Chi-Chi is likely to punch them if she wakes up now.\n\n");
				player.sexReward("vaginalFluids", "Dick");
				chichiPregChance();
				if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) flags[kFLAGS.CHI_CHI_FOLLOWER] = 1;
				doNext(camp.returnToCampUseOneHour);
			}
			function vagF():void {
				outputText("Chi Chi initiates with a wet but warm kiss, her tongue dancing a tango with yours. While small in stature she displays an uncommon level of strength rarely seen even among animal morphs. What’s more concerning is that you aren't sure how come her burning tail and fur isn't actually setting on fire everything around her starting with you. You inquire on this matter.\n\n");
				outputText("\"<i>Thatsh because I’m burning with passion for you, big idiot! My flamesh won’t burn anything I wish not to. Or maybe they will. I never recalled how that one inn caught fire. Just you wait I'll set both of our body aflame with desire. Your pussy will be as hot as my embers.</i>\"\n\n");
				outputText("Well it's too late to back down anyway and, even if you did, the drunken megamouse is clearly going to keep you pinned down. Not to make your partner wait any more, you begin to grind your pussy lips against hers making her gasp in surprise at your initiative.\n\n");
				outputText("\"<i>Oh?! Finally fighting back? Good I love a girl that tries.</i>\"\n\n");
				outputText("Chi Chi begins to grind herself in response, making you both moan. For a drunk she clearly knows what she’s doing. You’re swiftly forced back to reality as your blazing partner accelerates the tempo, causing you to moan in pleasure. There's no way you're going to lose this! You take her mouse ears into your hands and start caressing them. Chi Chi gasps, squirming, her cheeks bright red. You keep it up, scratching her ears, bringing your lips to her neck. She shivers, goosebumps spreading across her nape. You're clearly getting to her. ");
				outputText("The flaming mouse-girl moans, but her tail is still free. It lashes out like a whip and slides between you, aiming for your cunt. Before you can stop it you already have 15 inch of hot mouse tail in your [pussy] and Chi Chi uses it to fuck your brains out. You wriggle, her coiled tail pumping your folds as her heat spreads. Your cunt warms rapidly, heat spreading to your stomach and thighs, but it's not enough. Your cunt is on fire!");
				outputText("only the cool passage of your girl-juices can free you from this heat! She grinds against her own tail bump, but you grit your teeth over the wave of pleasure. This bitch isn't getting her way entirely! You swiftly slide " + (player.tailType > Tail.NONE ? "your tail" : "a pair of fingers") + " into her smoking hot hinezumi cunt. She gasps, and you finger her harder, tweaking her bright-red button.\n\n");
				outputText("Both desperate for a way to get rid of the heat and unable to fully outpace her, the two of you cum at the same time, your girl juices dripping down your cunts, pooling on the table before dripping onto the ground below. Chi Chi sighs in relief, steam rising from her as she falls limp on the table.\n\n");
				outputText("\"<i>" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 ? "You're the besht [name] you know that? Let'sh do thish again sometimes, I jusht can’t get enough of it." : "You're a good [boyfriend] you know that? Let'sh do thish again sometimes.") + "</i>\"\n\n");
				outputText("Her eyes close, and you breathe a sigh of relief as her breathing slows. Groaning through your own exhaustion, you force yourself up, gently placing her back on the table. You wince, aching groin sending shivers through you, but you stagger up,  leaving the bar. You consider it wise to leave before Chi-Chi wakes up." + (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3 ? " Especially because you're pretty sure she will beat you to death if she discovers the two of you had sex while she was drunk" : "") + ". You exit the bar, and as you leave, the barkeep sighs in relief. He motions to a bouncer, and the two men gingerly wrap Chi-Chi in the curtain and carry her out of the bar. From the extremely worried looks on their faces, Chi-Chi is likely to punch them if she wakes up now.\n\n");
				player.sexReward("no", "Vaginal");
				if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) flags[kFLAGS.CHI_CHI_FOLLOWER] = 1;
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}

public function chichiSex():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3) {
		outputText("Chi Chi blushes then gives a categorical \"No\", causing you to ask her why.\n\n");
		outputText("\"<i>Sorry, but I won’t. While the first time was fine, I want our relationship to proceed to the next level before we truly move to that step. And yes, unlike most monks, I can actually marry. Also, you would need to show your strength by defeating an oni first, I ain't going out with a nobody… well, at least not officially.</i>\"\n\n");
		if (flags[kFLAGS.IZUMI_TIMES_GRABBED_THE_HORN] > 0) outputText("Happily, you have already defeated one... and grabbed her horn!");
		else if (flags[kFLAGS.IZUMI_MET] == 1) outputText("Well, not you need to just kick Izumi's ass in any way.");
		else outputText("Now, where could you find one...? Perhaps, somewhere at the top of a mountain?")
		menu();
		addButton(0, "Wedding", chichiSex1)
			.disableIf(flags[kFLAGS.IZUMI_TIMES_GRABBED_THE_HORN] == 0, "Need to beat some oni.")
			.disableIf(!sceneHunter.canMarry(), "You have already married someone else.");
		addButton(4, "Later", chichiSex0);
	}
	else {
		outputText("\"<i>That does not count! Arghhh be gone, I got training to do!</i>\"\n\n");
		menu();
		if (model.time.hours > 18) addButton(0, "Until Dawn", chichiSexUntilDawn);
		else addButtonDisabled(0, "Until dawn", "It's too early for this. Wait till 7 pm.");
		if (player.hasCock()) addButton(1, "Gentle Fuck", chichiSexGentleFuck);
		else addButtonDisabled(1, "Gentle fuck", "Get a dick, bro.");
		if (player.hasVagina()) addButton(2, "HinezumiYuri", chichiSexHinezumiYuri);
		else addButtonDisabled(2, "HinezumiYuri", "Be a pussy or have one, sis.");
		if (ChiChiCorruption >= 9) addButton(3, "Corrupt", corruptSexRouter);
		addButton(4, "Back", ChiChiCampMainMenu);
	}
}
public function chichiSex0():void {
	outputText("You apologize and decide to change the subject.");
	doNext(ChiChiCampMainMenu);
}
public function chichiSex1():void {
	outputText("Well sure. If it will make her happy, you will propose to her.");
	if (player.hasItem(jewelries.ENDGRNG, 1) && SceneLib.templeofdivine.canMarry()) {
		outputText(" You have the ruby ring on you, but is this really the time?\n\n");
		menu();
		addButton(1, "Yes", chichiSex3).hint("Taking this step leads to a fight. Save your game!");
		addButton(3, "Change subject", chichiSex2);
	}
	else {
		outputText(" You ");
		if (!SceneLib.templeofdivine.canMarry()) {
			if (!player.hasItem(jewelries.ENDGRNG, 1)) outputText("also realize to your annoyance that not only are you missing a wedding ring but the two of you will need a holy place to recite your vows, one with a still working altar of Marae and active priestess. Come to think of it her favorite color was red maybe a ruby ring would do.");
			else outputText("realise to your annoyance that the two of you will need a holy place to recite your vows, one with a still working altar of Marae and active priestess likely.");
		}
		else outputText("realize however that to properly propose to her, you would need an engagement ring, preferably a ruby one.");
		outputText("\n\n");
		doNext(chichiSex2);
	}
}
public function chichiSex2():void {
	outputText("You need to prepare better before you do that one leap.\n\n");
	doNext(ChiChiCampMainMenu);
}
public function chichiSex3():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("You suddenly drop to your knees before Chi Chi, who gives you a confused stare as you open a small box containing the ruby ring. This begins in the same way as every love tale. You gather the courage and, to her astonishment, propose right then and there.\n\n");
	outputText("\"<i>A..are you serious???!!! You idiot! Y..you're...really?!\"</i>\"\n\n");
	outputText("Chi Chi is at a loss for words. It takes her an entire minute to come back from the shock of your proposal, but she finally answers in the clearest manner she can.\n\n");
	outputText("\"<i>Yes…I will.</i>\"\n\n");
	player.destroyItems(jewelries.ENDGRNG, 1);
	player.HP = player.maxHP();
	player.lust = 0;
	player.wrath = 0;
	player.fatigue = 0;
	player.mana = player.maxMana();
	player.soulforce = player.maxSoulforce();
	model.time.days += 3;
	doNext(chichiSex4);
}
public function chichiSex4():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("It’s been three days since and now both of you are standing quietly in the temple of the divines. Chi Chi is dressed in a formal wedding dress, which is something people haven’t seen in Mareth for a long time. Both of you are standing by Sapphire which once again has taken the role of priestess for the occasion as you recite your vows");
	if ((camp.followersCount() + camp.loversCount()) > 0) outputText(". All of your friends actually came to attend");
	if (camp.loversCount() > 0) outputText(" which is not so surprising considering some of them are also in your harem");
	outputText(".\n\n\"<i>If anyone objects to this union, may they speak now or stay silent forever!</i>\"\n\n");
	outputText("Just as she finishes this sentence, the door of the building flies open as a thunderous voice rings out over the place.\n\n");
	outputText("\"<i>I do! CHI CHI IS MIIIINE!!!!!</i>\"\n\n");
	outputText("Chi Chi looks at the immense shape at the other side of the chapel who is escorted by a full harem of succubi. It looks like an Oni, at least as far as you can tell, except this is the tallest one you have ever seen. The man is ten feet tall and looks about as beefy as a minotaur! A large dragon tattoo runs over its bare red skinned chest. He doesn't go naked however sporting a pair of pants buckled with a massive golden belt. He doesn't carry any weapons either, but it's obvious his clawed brutish hands and feet are his weapon of choice. Chi Chi recognizes him instantly.\n\n");
	outputText("\"<i>How dare you show your face here, Chon Lao! I thought I had been clear, your advances were as pathetic as your skill at fighting and I am especially NOT interested in a loser who gave his body to the demons in order to achieve the martial powers he never had. Worse, you destroyed the school and the village to satisfy your petty ambitions because you were a complete failure as a student. I should be snapping your neck this very moment! Get out of my sight!</i>\"\n\n");
	outputText("Chon smiles, revealing a pair of yellow fangs only fitting on a monster.\n\n");
	outputText("\"<i>Oh sensei! Do you really think you can stop me from getting what I want in your condition?!!! You’re so badly injured you wouldn’t even be able to struggle, even I can see it!  I will start by beating this idiot to a pulp and then I will rape you again and again until your pussy becomes molded to my dick and no other can fit you right again!</i>\"\n\n");
	outputText("Chi Chi points at the oni with rage.\n\n");
	outputText("\"<i>[name], this bastard is the cause of everything that’s gone wrong in my life, please do something!</i>\"\n\n");
	outputText("You step forward to save your marriage, there's no way you're going to let this huge prick ruin your special day or hers!\n\n");
	flags[kFLAGS.CHI_CHI_FOLLOWER] = 4;
	startCombat(new OniIncubus());
}
public function chichiSex5():void {
	flags[kFLAGS.CHI_CHI_FOLLOWER] = 5;
	clearOutput();
	if (player.hasCock()) {
		outputText("You scream in rage as the monster grabs a terrified Chi Chi and makes his escape. More than disheartened by the failure of your marriage, you realize the man has stolen Chi Chi from you forever as he takes her to some unknown location. You leave, returning to camp heartbroken.\n\n");
		doNext(cleanupAfterCombat);
	}
	else {
		outputText("Chon looks down at your defeated form, smirking with perverse intent as he admires your shape.\n\n");
		outputText("\"<i>Know what, sensei? I thought about it and this slut right here is as sexy as you are, so I think I'll bring you both back home as part of my harem. There's enough cum in these balls for both of you.</i>\"\n\n");
		outputText("<b>Several months later</b>\n\n");
		outputText("You wake up still sitting on master Chon’s cock. You must've blacked out again in the middle of the carnal act and, with a member of his size, it’s hardly a surprise. The master has been so kind to you, filling your pussy with his perfect, worshipable tool. Chi Chi and you are taking turns to satisfy him as well as his many succubus concubines, although, it’s obvious the pair of you are his favorites out of the lot. ");
		outputText("You fondly remember how he broke your silly ideas of rebellion, teaching you the perfect shape of his cock until it molded your pussy so that no other cock would fit, and how you cummed out your soul in accordance with the master’s desire. Once a succubus, it became way easier for you to actually agree to his ways.\n\n");
		outputText("\"<i>Wife… my saké, now!</i>\"\n\n");
		outputText("Ah yes, the master is always drunk… there's nothing to do about it. You slide off from his cock as you get him a cup of saké. He's not exactly the kindest of men, but his rough and violent sexual tastes are just what you and Chi Chi want, ravaging you with drunken brutality. Heck, you couldn’t care less how he fucks you as long as he feeds your devilish demon body enough cum to sate your hunger for sex. Chi Chi and you still do partner up every now and then as lovers, although the Master has been clear that he is to remain your priority. Perhaps Master Chon would allow it more often if the pair of you put on a show for him, ");
		outputText("his favourite harem sluts fucking while he watches until he gives them what they need most. You’re pulled out of your revery by your beloved Master as he picks up the cup of saké and drinks it, then lifts you up and slides your pussy on his magnificent tool. Your cock sleeve cunny reacts accordingly molding snug against his skin as you begin to slide up and down against his length in order to milk his semen, moaning as your spaded tail flails wildly and your wings flap already ecstatic at the experience.\n\n");
		outputText("You forgot what it is to have free will long ago… only Chon-sama’s desires matter to you now.\n\n");
		cleanupAfterCombat();
		EventParser.gameOver();
	}
}
public function chichiSex6():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("You kick Chon Lao on his back and watch as the other people present in the church proceed to beat him and carry him out of town, along with his sinister cohorts. Chi Chi looks at you with pride as the priestess resumes the ceremony. Both of you, of course, say the characteristic <i>‘I do’</i> and you bring Chi Chi back home, ready to consummate your love. The love-struck mouse doesn't have to wait on "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "the bed":"sleeping roll")+" for long as you begin to remove your clothes.\n\n");
	if (player.hasCock()) {
		outputText("Done with the preliminaries Chi Chi sighs in relief as you slowly insert your [cock] inside her waiting pussy. She hugs you tight as you gently start to piston in and out of her. Chi Chi seems to enjoy herself and makes it obvious as she kisses you and draws her tongue in. The sex is calm and soothing, unlike most experiences you had so far with the denizens of Mareth, who tend to prefer different trends or wilder kinks, making this slow and vanilla experience something you cherish. Chi Chi only breaks the kiss in order to whisper sweet words to you.\n\n");
		outputText("\"<i>When I’m close to you, I feel safe and warm… like in a relaxing bath in the hot springs of my homeland. I wish we could stay together like this forever, out of this crazy world’s reach. The only thing that matters here is you and me and it fills me with joy.</i>\"\n\n");
		outputText("You slowly keep working her hole, the mouse moaning every now and then and panting as her body prepares for climax. You are not so far from yours either, as you feel your cock twitching, and soon you cum in Chi Chi’s pussy, the mouse reaching her peak about the same time with a delighted squeak.\n\n");
	}
	else {
		outputText("You give her a good view of your [breasts] and [pussy] as you lie down next to her. The mouse weakly moves her arms to hug you, pushing her breasts against yours, as she begins to kiss you and seek out your tongue. You play with hers for a few minutes, savoring the cinnamony taste of her lips before slowly moving your hand to her breasts in order to massage her. Chi Chi gasps at first as she clearly hasn’t fully recovered yet, but when you attempt to remove your hand she stops you right away.\n\n");
		outputText("\"<i>Please.. continue, I can take more.</i>\"\n\n");
		outputText("You comply and resume, slowly massaging her breast, making her moan in delight as you feel her tail entwining with your leg. She weakly moves her hand towards your pussy, eliciting a moan from you as she begins to slowly finger you. You go for hers with your other hand and massage her inner folds, both of you pleasuring each other for a while. It is a relaxing experience which allows you to truly connect with her as you gently bring each other towards the edge. The sex is calm and soothing unlike most that you have experienced so far with the denizens of Mareth, who tend to prefer different trends or wilder kinks, ");
		outputText("making this slow and vanilla experience something you cherish as both of you eventually cum next to each other, Chi Chi tensing then relaxing against you as your pussies exchange fluids. She is so strong yet so fragile, right now you take great care not to hurt her as she has not yet fully recovered from her battle wounds.\n\n");
	}
	outputText("The two of you bask in the afterglow of your orgasms for a good moment, as you stay locked with Chi Chi kissing and whispering sweet words for several minutes. You want to stay there with her, locked away from the rest of the world for however long you can to savor her lips and silken fiery pink fur. You make love to Chi Chi, both of you exploring each others body until dawn, finally falling asleep from exhaustion in the arms of your lover.\n\n");
	outputText("Waking up in the morning, you realize that to make this wicked world perfect for her and you, you will need to act. Therefore you decide, despite your wish to remain next to her, to resume your duties as champion. Chi Chi, however, stops you from leaving too early.\n\n");
	outputText("\"<i>I have a gift for you. My mother used to twirl it for me when I was a kid. I planned to give it to the love of my life, and I cannot think of anyone more deserving of that title than you. Don’t you ever die on me okay?</i>\"\n\n");
	outputText("She pulls the necklace from her neck and offers it to you. You accept her gift and thank her as you set out to resume your adventure.\n\n");
	player.sexReward("vaginalFluids");
	model.time.days++;
	model.time.hours = 6;
	flags[kFLAGS.CHI_CHI_FOLLOWER] = 6;
	sceneHunter.marry("Chi Chi");
	inventory.takeItem(necklaces.YIYAAMU, cleanupAfterCombat);
}
public function chichiSexUntilDawn():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("You smile proposing for both of you to make sweet love all the night. Chi Chi blushes but also smiles in anticipation, her tail reflecting that mood as both of you head for your "+(flags[kFLAGS.CAMP_BUILT_CABIN] >= 1 ? "cabin":"tent")+".\n\n");
	outputText("\"<i>Are we alone? Just the two of us?</i>\"\n\n");
	outputText("She’s already thrilled but she makes sure "+(flags[kFLAGS.CAMP_BUILT_CABIN] >= 1 ? "that all the windows are covered before checking on the door to be sure ":"")+"nothing interrupts the two of you. Now, to get down to business, as Chi Chi is starting to have difficulty controlling her heat in all the possible ways.\n\n");
	if (player.hasCock()) {
		outputText("The two of you slowly begin to take turns undressing, starting with her qipao, something she purposely makes a show out of, even going so far as to dance for you. You resume playing with her tongue for a few minutes, savoring the cinnamon taste of her lips before slowly moving your hand to her breasts in order to massage her. Chi Chi gasps at first, as she clearly hasn’t fully recovered yet, but when you attempt to remove your hand, she stops you right away. Done with the preliminaries, Chi Chi sighs in relief as you slowly insert your [cock] inside her waiting pussy. ");
		outputText("She hugs you tight, as you gently start to piston in and out of her. Chi Chi seems to enjoy herself and makes it obvious as she kisses you and draws her tongue in. The sex is calm and soothing, unlike most experiences you’ve had so far with the denizens of Mareth, who tend to prefer different trends or wilder kinks,  making this slow and vanilla experience something you cherish. Chi Chi only breaks the kiss in order to whisper a sweet nothing to you.\n\n");
		if (ChiChiCorruption > 90) outputText("“<i>I don’t care about the rest of Mareth right now. The world could be on fire I would still be fucking with you, the here and now is all that matter. So let’s consume ourselves in this blaze of pleasure we started.</i>”[pg]");
		else outputText("\"<i>When I’m close to you, I feel safe and warm… like a relaxing bath in the hot springs of my homeland. I wish we could stay together like this forever, out of this crazy world reach. The only thing that matters here is you and me, and it fills me with joy.</i>\"\n\n");
		outputText("This is something you can agree with, there are few things you can enjoy better than being here with her. You slowly keep working her hole, hitting every single spot. Chi Chi is moaning every now and then, panting in delight as her body prepares for climax, fiercely clinging to yours. You are not so far from yours either as you feel your cock twitching and soon you cum in Chi Chi’s pussy, the mouse reaching her peak about the same time with a cute, delighted squeak.\n\n");
	}
	else {
		outputText("Both of you slowly begin to undress, starting with her qipao, something she purposely makes a show out of, even going so far as to dance for you. You resume playing with her tongue for a few minutes, savoring the cinnamon taste of her lips before slowly moving your hand to her breasts in order to massage her. However, it’s your turn and you break the kiss and step away a distance as you slowly do for her a nice belly dance removing your clothes one by one and throwing them away to her excitement. ");
		outputText("You give her a good view of your [breasts] and [pussy] as you head back to lay down next to her. The mouse slowly moves her arms to hug you pushing her breasts against yours as she begins to kiss you and seek your tongue.");
		if (flags[kFLAGS.CHI_CHI_LVL_UP] < 8) {
			outputText(" Chi Chi gasps at first as she clearly hasn’t fully recovered yet but when you attempt to remove your hand she stops you right away.\n\n");
			outputText("\"<i>Please.. continue I can take more. Do not mind me.</i>\"");
		}
		if (ChiChiCorruption > 90) {
			outputText("You tease her by pulling out and slowing down for a few seconds leaving her in partial denial.[pg]");
			outputText("“<i>Please.. do not stop. I need more, much more… give me all of you.</i>”[pg]");
		}
		outputText("\n\nYou comply and resume by slowly massaging her breasts, making her moan in delight, as you feel her tail entwining on your leg. She moves her hand toward your pussy, eliciting a moan from you as she begins to insert her finger in your [pussy]. You go for hers with your other hand and massage her inner folds, both of you pleasuring each other for a while. Chi Chi’s technique, despite her recent experience to sex, is exemplary. ");
		outputText("You think you might not have been her first time, but, on Mareth such things are commonplace, especially for an adventurer or a warrior and you suspect she somehow refined her skill without losing her virginity by defeating common enemies or simply had a good time with another girl. It is a relaxing experience and Chi Chi only breaks the kiss in order to whisper a sweet nothing to you.\n\n");
		if (ChiChiCorruption > 90) outputText("“<i>I don’t care about the rest of Mareth right now. The world could be on fire I would still be fucking with you, the here and now is all that matter. So let’s consume ourselves in this blaze of pleasure we started.</i>”[pg]");
		else outputText("\"<i>When I’m close to you, I feel safe and warm… like a relaxing bath in the hot springs of my homeland. I wish we could stay together like this forever, out of this crazy world reach. The only thing that matters here is you and me, and it fills me with joy.</i>\"\n\n");
		outputText("Chi Chi and you begin to lose focus on the world around, only able to see each other’s happy face, as both of you eventually cum together. Of course, you resume a few minutes after, but she is so strong yet, so fragile right now. You take great care not to hurt or exhaust her, as she has not yet fully recovered from her battle with you.\n\n");
	}
	outputText("The two of you bask in the afterglow of your orgasms for a good moment as you stay locked with Chi Chi kissing and whispering sweet nothings for several minutes. You make love to Chi Chi like this until dawn, both of you finally falling asleep from exhaustion.\n\n");
	outputText("Waking up in the morning you give Chi Chi a parting kiss and head out to resume your champion duties.\n\n");
	if (player.hasCock()) {
		player.sexReward("vaginalFluids", "Dick");
		chichiPregChance();
	} else player.sexReward("no", "Vaginal");
	model.time.days++;
	model.time.hours = 6;
	doNext(camp.returnToCampUseOneHour);
}
public function chichiSexGentleFuck():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("You would like to have a sweet time with your spouse and tell her so. Chi Chi smiles and begins to undo your clothes as you undo hers, the two of you only interrupting every now and then to kiss each other. Chi Chi clearly has been refining her tail technique, teasing your prick while both of you are hugging. You gently suckle on her neck and then move down to kiss her breasts. Her tail all the while is still teasing you but you're just getting started. You play with her fiery pink hair for a moment and then suckle on her left areola, playing with her nipple. ");
	outputText("Chi Chi is trying to get you off first but you are determined not to lose to her, which is why you double the offensive by tweaking her other nipple.\n\n\"<i>Ahhhh [name] you naughty cheater this just not...Aaaaaaaahnn.. fair.</i>\"\n\n");
	outputText("Well, life can’t always be fair, and this time around she gets wet way before she manages to pull any precum out of you. You slowly push her down, holding her with your hand, as you proceed to insert your [cock] between her waiting folds. Chi Chi giggles at you as she helps your cock in with her tail, guiding it in just the right place. Once you're inside, you slowly fuck the fragile mouse’s delicate body, ever worried of hurting her. Your hands are kept busy, as you use one of them to massage her breast while the other one is holding her tail, as you nib on the tip not ignoring any important spot. ");
	outputText("Chi Chi moans slowly, her eyes sparkling with delight as the two of you make love slowly and passionately, unconcerned by the surrounding mayhem in Mareth. A small spark of happiness in the bleak land that is the current Mareth. Chi Chi’s about to reach her climax moans your name as you do hers and both of you cum, your sperm painting her warm spasming vaginal walls white. Chi Chi stays locked with you, her heaving chest against yours as both of you drift to sleep.\n\n");
	outputText("You wake up later and prepare to re-equip your gear. Chi Chi is still against you, but you almost regretfully break the embrace as she lifts to dress back up.\n\n");
	if (ChiChiCorruption > 90) outputText("“<i>Go fuck some other demon into submission [name]. I will be keeping that bed warm for you when you come back ready for another round.</i>”[pg]");
	else outputText("\"<i>Go save the world, [name]. I will be keeping that bed warm for you when you come back.</i>\"\n\n");
	outputText("She gives you a playful wink as she heads back to her training ground, her tail still swishing in happiness. She’s right, you didn’t get this far in life just to let the demons destroy it. You finish redressing then head back to the fight.\n\n");
	player.sexReward("vaginalFluids","Dick");
	chichiPregChance();
	doNext(camp.returnToCampUseOneHour);
}
public function chichiSexHinezumiYuri():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("You tell your cute mouse you would sure like a taste of her fiery honeypot. Chi Chi blushes but smiles, totally turned on by your lewd suggestion. The two of you head for your "+(flags[kFLAGS.CAMP_BUILT_CABIN] >= 1 ? "cabin":"tent")+" to have some privacy. Chi Chi is trembling in excitement, barely controlling her flames.\n\n");
	outputText("You "+(player.isNaked() ? "":"begin by removing your clothes then ")+"proceed to remove Chi Chi’s clothes, piece by piece, starting with her Qipao. She doesn’t make it easy as her hands are very busy playing with your [chest] arousing you all the more. It doesn’t take you long to get her dress out of the way and begin playing with her supple breasts, making her moan in delight just before you catch her gaping mouth with a surprise kiss. She replies by gently tweaking your [nipples] as you move a hand below and slowly get her panties down, sliding a finger in her soaking wet pussy. ");
	outputText("She gasps through the kiss"+((player.tailType == Tail.MOUSE || player.tailType == Tail.HINEZUMI) ? " as your tail wraps amorously around her left leg":"")+". Chi Chi doesn't let go of your nipples as her hand seeks out your cunt making you gasp in surprise. Fingering is nice and all but you said you wanted to eat her out so you slowly move her over the bed and get to work, nibbling at her pussy as you dive your tongue into her slick folds, making her squeal, as she tries to hold your head in between her thighs. Chi Chi, though unable to actually reach you with her hands, uses her long prehensile tail ");
	outputText("to search for your own pussy, eventually finding your folds and flicking the tip right across your cunny. You moan delighted at her attention and reward her with plenty of licking taking your time to nibble on her clit as well every now and then.\n\n");
	outputText("\"<i>Ahhh, [name], my cunt is going crazy!</i>\"\n\n");
	outputText("The more aroused she gets, the wilder and faster her tail moves, rubbing against your cunt and toying with your clit as you moan in tandem with your fiery partner. "+((player.tailType == Tail.MOUSE || player.tailType == Tail.HINEZUMI) ? "Your tail isn’t left idle long either as your wrap it around her breast set and squeeze making her squeal in delight. ":"")+"Soon, both of you are reaching a mind shattering orgasm, her juices flooding your mouth as you paint her tail and the ground with yours. ");
	outputText("You stay down in her thigh embrace for a few minutes as Chi Chi shares her soothing warmth with you. Still, Chi Chi is not done yet, as she pushes you on your back, straddling you. She starts licking your, still drooling, cunt while shoving hers in your face. Well, here goes round two, you begin eating her off again, moaning as she does exactly the same to you. She only ever pauses to tease you before resuming.\n\n");
	outputText("\"<i>Ahhhh fuuuck yes gosh you taste so good [name]!</i>\"\n\n");
	outputText("You can barely hold it anymore and your twat starts to pulse in anticipation of the oncoming orgasm. Chi Chi"+(player.isRace(Races.MOUSE, 1, false) ? " and you":"")+" make a loud squeak as both of you are painted with each other juices still cross-eyed from the pleasure and taste of each other. You giggle at the reaction, Chi Chi not taking offense to it.\n\n");
	outputText("Eventually, both of you break the pose, clean up, re-dress and head back to your daily activities.\n\n");
	player.sexReward("vaginalFluids");
	doNext(camp.returnToCampUseOneHour);
}

public function mishapsLunaChiChi():void {
	spriteSelect(SpriteDb.s_chichi);
	clearOutput();
	outputText("As you go to visit Chi Chi, you hear her scream. Running over to check what's going on you notice the fire mouse is now a sobbing mess, wet with water. You don’t recall her crying before so this must be serious.\n\n");
	outputText("\"<i>Why why? Why would someone put a bucket right above my bedroll now I’m all wet and my fire will take hours to rise again!</i>\"\n\n");
	outputText("She notices you checking on her and panic.\n\n");
	outputText("\"<i>Eep go away [name]! D..don’t look at me!! The last thing I need is you looking at me right now.</i>\"\n\n");
	outputText("That’s quite a surprise. Does the proud fighter facade drop when she’s wet? Well, regardless you guess you will have to visit her later because there’s no way she’s letting you approach her right now.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampLunaMishaps2)) player.addStatusValue(StatusEffects.CampLunaMishaps2, 4, 1);
	else player.createStatusEffect(StatusEffects.CampLunaMishaps2, 0, 0, 0, 1);
	if (!player.hasStatusEffect(StatusEffects.LunaWasCaugh)) player.createStatusEffect(StatusEffects.LunaWasCaugh, 1, 0, 0, 0);
	else player.addStatusValue(StatusEffects.LunaWasCaugh, 1, 1);
	if (player.statusEffectv1(StatusEffects.LunaWasCaugh) == 3) outputText("<b>That's it, you're sure of it now, it's all Luna's doing!</b>\n\n");
	doNext(playerMenu);
}

	public function spikeDrink():void {
		outputText("While Chi Chi is distracted trying to get you to fuck with her you grab a flask of succubi milk and pour it into her drink. That done you point her glass.[pg]");
		outputText("Before this goes any further she should at least finish her drink...[pg]");
		outputText("Chi Chi jolts up and grabs the glass without further questioning herself.[pg]");
		outputText("“<i>Gosh I almosht forgot that!</i>”[pg]");
		outputText("She swiftly grab the glass of spiked sake and chug it up before pinning you back to the table her body changing slightly as her hip and breast barely expand. Chi Chi moans in confusion at the change but seem to forget right away as her lust lidded eye focus back on you.[pg]");
		outputText("“<i>What are you waiting for you idiot? letsh fuck!</i>”[pg]");
		player.consumeItem(consumables.SUCMILK);
		ChiChiCorruption++;
		doNext(drunksex, true);
	}

	public function corruptionOverflowing():void {
		spriteSelect(SpriteDb.s_chichi);
		clearOutput();
		outputText("As you head back to camp you spot Chi Chi in the far distance heading toward you. There's something off about her though. You only realise what when you spot the twin embery horns up her forehead and the spaded end of her tail, guess the succubi milk you stacked in her drink finally had an effect. If it wasn’t enough of a tell, her fire has blazing trails of purple instead of its usual color palette. She’s corrupted to the brim and looks like she doesn’t even care anymore. You can see her intentions before she even asks but to avoid taking a kick or punch to the face you think you might as well pretend you know nothing and let her explain herself.[pg]");
		outputText("“<i>Hey, you won’t believe what happened to me! Turns out I was kicked out of town for publicly raping people while drunk. What's so wrong about that?! I should be able to get sex from whoever I want whenever I please!");
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] <= 3) outputText(" Regardless I ended up with no place to go and remembered you had a camp in the wasteland so I'm moving in.")
		outputText("</i>[pg]");
		outputText("She moves her hips from side to side, her blazing tail swishing hypnotically behind her as she adds.[pg]");
		outputText("“<i>Since you were this open to fucking with me I thought you would fit the bill better than the imps and goblins as a [boyfriend]. I need someone to keep that smoldering need of mine satisfied and I could not think of anyone else.</i>”[pg]");
		outputText("Well now she’s speaking your language. How about she makes a proper display of her talent to you first.[pg]");
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 3) flags[kFLAGS.CHI_CHI_FOLLOWER] = 4;
		ChiChiKickedOut = true;
		sceneHunter.selectGender(corruptM, corruptF);
	}
	private function corruptSexRouter():void {
		clearOutput();
		outputText("”<i>Since you were this open to fucking with me I thought you would fit the bill better than the imps and goblins as a [boyfriend]. I need someone to keep that smoldering need of mine satisfied and I could not think of anyone else.</i>”[pg]");
		outputText("Well now she’s speaking your language. How about she makes a proper display of her talent to you first.[pg]");
		sceneHunter.selectGender(corruptM, corruptF);
	}
	private function corruptF():void {
		outputText("Chi Chi initiates with a wet but warm kiss her tongue dancing a tango with yours. While small in stature she displays an uncommon level of strength rarely seen even among animal morphs. What’s more concerning is that you aren't sure how come her burning tail and fur isn't actually setting everything on fire around her, starting with you. You inquire on this matter.[pg]");
		outputText("“<i>That’s because I’m burning with passion for you, big idiot! My flames won’t burn anything I wish not to. Just you wait, I'll set bothof our bodies aflame with desire. Your pussy will be as hot as my embers.</i>“[pg]");
		outputText("Well it's too late to back down anyway and, even if you did, the corrupt megamouse is clearly going to keep you pinned down. Not to make your partner wait anymore you begin to grind your pussy lips against hers making her gasp in surprise at your initiative.[pg]");
		outputText("“<i>Oh?! Finally fighting back? Good, I love a girl that tries.</i>”[pg]");
		outputText("Chi Chi begins to grind herself in response, making you both coo. She clearly knows what she’s doing and with her newfound corruption sex is as easy for her as breathing. You’re swiftly forced out back to reality as your blazing partner accelerates the tempo, causing you to moan in pleasure. Well, now there's no way you are going to simply lose this! You get the mouse ears with your hands and start caressing them. Chi Chi has a positive reaction and you are clearly getting to her however that's counting without her hidden weapon. Her burning tail lashes out like a whip and slides between you, aiming for your cunt. Before you can stop it you already have 15 inch of hot mouse tail in your [vagina] and Chi Chi uses it to fuck your brain out. The fuck isn't all that happens it seems her very heat start to spread on to you. Wow, your cunt is indeed as if possessed by some kind of angry efreeti. It's so hot you can’t think straight anymore, only the cool passage of your girl-juices can free you from this heat! Meanwhile she grinds against her own tail bump but you have decided not to let her get off at her own pace. You swiftly slide [if (hasTail = true)your tail tip|a pair of fingers] in the smoking hot hinezumi cunt and retaliate with a flurry of rapid movements of your own.[pg]");
		outputText("Both desperate for a way to get rid of the heat and unable to fully outpace her, the two of you still manage to cum together your girl juices melding together and staining the ground. Chi Chi sighs in relief and exhaustion, falling limp on the ground.[pg]");
		outputText("”<i>You're the best [name], you know that? Let's keep doing this every day! I just can’t get enough of it.</i>”[pg]");
		outputText("You both rest for a while before the pair of you dress back up. You could fuck with the corrupt inferno moussette the whole day long but you got other things to do.[pg]");
		player.sexReward("no", "Vaginal");
		doNext(camp.returnToCampUseOneHour);
	}
	private function corruptM():void {
		outputText("Chi Chi initiates with a wet but warm kiss; Her tongue dancing a tango with yours. While small in stature, she displays an uncommon level of strength rarely seen even among animal morphs. What’s more concerning is that you aren't sure how her burning tail and fur isn't actually setting everything on fire around her, especially you. You inquire on this matter.[pg]");
		outputText("“<i>That’s because I’m burning with passion for you big idiot! My flames won’t burn anything I wish not to. Just you wait, I'll set both of our body aflame with desire. Your cock will be as hot as my embers.</i>“[pg]");
		outputText("Well it's too late to back down anyway and, even if you did, the corrupt megamouse is clearly going to keep you pinned down. Not to make your partner wait anymore, you slowly tease the entrance of her warm canal with your [cock]. If anything, despite being wet you can already feel how hot her oven is from the outside and can’t help but hope you won’t end up burned. Chi Chi however has no such concern and out of impatience starts stroking your dick with her embery tail.[pg]");
		outputText("“<i>Come on, I know you want to put it in. What are you waiting for dumbass?! I’m positively burning here.</i>”[pg]");
		outputText("You're surprised by the direct contact with her fiery tail, even more so by the fact that it didn’t leave your dick with a third degree burn. Deciding to give the hot mouse what she wants, you put it in. Her vagina immediately starts milking you as if it was a thirsty mouth seeking water, and the frantic moving of her hips up and down doesn’t help it.[pg]");
		outputText("“<i>Gah douse me! Don’t you see how much I’m burning! Put that fire out with your man water!</i>”[pg]");
		outputText("Her pussy starts heating even more and before you know it, it actually transfers to you. Wow, your urethra is indeed as if possessed by some kind of angry efreeti. It's so hot you can’t think straight anymore, only the cool passage of cum can free you from this heat! You begin to piston in and out of Chi Chi desperate for a cooling release.[pg]");
		outputText("Both desperate for a way to get rid of the heat, the two of you manage to cum together, your jizz filling Chi Chi to the brim before slowly dripping down. Chi Chi sighs in relief and exhaustion, falling limp on the ground[if (cumhigh) her pussy slowly drooling from the messy bukake you left her with].[pg]");
		outputText("”<i>You're the best [name] you know that? Let's keep doing this everyday, my thirsty cunt just can’t get enough of it.</i>” [pg]");
		outputText("You both rest for a while before the pair of you dress back up. You could fuck with the corrupt inferno moussette the whole day long but you got other things to do.[pg]");
		player.sexReward("vaginalFluids", "Dick");
		doNext(camp.returnToCampUseOneHour);
	}

	public function newLoverComesToCamp():void {	//TODO check for new lovers
		outputText("You’ve barely entered the camp with your new conquest before you hear a raging scream. The sudden cry only has a split second to echo before Chi Chi’s foot literally crashes into your face, her air kick sending you flying a few meters away. As you get up from the ground, brushing off the dirt you ask her what the hell that was for.[pg]");
		outputText("“<i>You jerk! You ignore me entirely for days and suddenly you come home with another person, sharing the intimacy of a long loving couple!  What does OUR love even mean to you? I hate you!</i>”[pg]");
		outputText(", confused, looks at Chi Chi scolding you like the jealous girlfriend she is for your utter lack of fidelity. You apologize and explain yourself to Chi Chi, saying that you will take better care of her from now on, just that she's not alone in your life.[pg]");
		outputText("“<i>You better! I was here before that newcomer, and you, the charmer, you may have found a place in my [boyfriend]’s heart but know this, I WAS HERE FIRST! If you hurt [name] in any way I will beat you, break your bones and throw you down in the stream half alive for the fishes to eat!</i>”[pg]");
		outputText("She moves back to her side of camp to cool down her raging flames. You can still feel her footprint on your face... OUCH that hurt![pg]");
		outputText("[pg]");
	}
	public function kihaInteraction():void {
		outputText("As you walk around camp you're greeted to an unusual sight.[pg]");
		outputText("Kiha happens to be sparring with Chi Chi. While the dragoness definitely has height as an advantage, the mouse definitively outmaneuvers her slow axe attacks in every way, punishing Kiha’s every mistakes. Kiha finally land a blow on the mouse, smashing her off with her tail and sending her flying to a nearby tree before the Hinezumi land on the trunk with her legs and projects herself back into the fray with a punch to the face. You’re about to interject before either gets hurt when they actually break the fight, Chi Chi talking first.[pg]");
		outputText("”<i>Great job Kiha, you’re improving that style of yours. However, you need to use your legs and tail just as much as you do your greataxe. Your body was engineered like a weapon, it only makes sense that you waste none of its potential. Keep at it and you'll be way more likely to kick those demon asses.</i>” [pg]");
		outputText("Oh gods… if Kiha is training with Chi Chi now you will have to be careful around her next time you exchange blows. You may have won your last spar with her but there's no telling how strong she’ll get if she keeps on improving.[pg]");
		if (flags[kFLAGS.KIHA_LVL_UP] < 13) flags[kFLAGS.KIHA_LVL_UP]++;
		kihaInteractionHappened = true;
	}
	public function jojoInteraction():void {
		outputText("As you head back to camp you catch the two monks in the middle of a philosophical debate. Chi Chi keeps repeating perfection is achieved through constant martial training and the honing of one's mind whereas Jojo insists meditation and harmony of the inner self is key to enlightenment. They chatter for a few seconds then both stop as they notice you watching, heading back to their respective training.[pg]");
		jojoInteractionHappened = true;
	}
	public function joyInteraction():void {
		outputText("As you head back to camp you catch Joy and Chi Chi in the middle of a somewhat awkward discussion. Chi Chi keeps repeating that Joy is a dimwit while Joy keeps telling her that self perfection is achieved through sexual release and equilibrium is reached when you have at least six different partners, one for each holes, and members. Chi Chi is about to send Joy flying when she takes notice of you and restrains herself.[pg]");
		joyInteractionHappened = true;
	}
	public function ayaneInteraction():void {
		outputText("You notice Ayane and Chi Chi talking together. Seems to be a discussion about the responsible uses of Ki. While Chi Chi is a martial artist Ayane seems to focus her ki into spellcasting. Is it really going to be the warrior versus wizard argument again? The shrine maiden however has the wisdom not to fully deny the point of view of the hinezumi who seems determined to defend her way of life to the end. They exchange a pair of respectful bows then break out, Ayane heading out to resume her tasks as Chi Chi head toward the training dummies.[pg]");
		ayaneInteractionHappened = true;
	}
	public function ceaniInteraction():void {
		outputText("As you come back to camp you notice the smell of smoke in the distance. When you close in to see what's going on you see Chi Chi apologizing profusely to Ceani who seems stuck between rage and tears next to a barrel of burnt fish.[pg]");
		outputText("“<i>Look I swear all I wanted was to grill a fish for my dinner! I didn’t mean to set fire to the entire barrel!</i>”[pg]");
		outputText("Ceani answer by showing her massive pointy teeth, a sight that would scare just about anyone used to her kind merry going attitude. This is a facet of her you didn’t get to see often.[pg]");
		outputText("“<i>An entire months worth of food, you clumsy idiot! all gone to ashes within seconds! Do you realise how hard it is to accumulate this many fish?! I would switch you over with the barrel I just lost but [name] would not like it. Hope you got a way to compensate me back, this isn't the high sea.</i>”[pg]");
		outputText("You decide to let Chi Chi solve her issues, she’ll likely catch fishes between her training to compensate.[pg]");
		ceaniInteractionHappened = true;
		doNext(playerMenu);
	}
	public function lunaInteraction():void {
		outputText("You spot Luna and Chi Chi working together, Luna is pilling trash and Chi Chi is incinerating it. Luna finally grab the ashes with a container and goes to spread it to the flowers. Now that's what you call teamwork![pg]");
		lunaInteractionHappened = true;
	}
	public function bimboPatchInteraction():void {
		outputText("You hear a commotion in your camp and spot Chi Chi in battle stance fighting off something. Out of nowhere Patchoulie appear behind Chi Chi and grabs her tail, giggling. The mouse’s lightning fast response with a kick that sends the cheshire trickster flying, though she disappears and appears laidback on a tree branch before she get into a collision with a nearby obstacle. Chi Chi look back at you somewhat pissed.[pg]");
		outputText("“<i>Look [name], I can’t exactly stop you from inviting people to the camp but have the decency to tell them to behave, because if that cat girl jumps me  one more time, I swear I will make her head explode.</i>”[pg]");
		outputText("Patchoulie makes one of her most aggravating smile and replies back.[pg]");
		outputText("“<i>You can’t hurt me nya… don’t you know I am everything and nothing, everywhere and nowhere, neither alive nor dead? You can’t exactly end my existence if I have never existed right? Or is it that I have always existed? Even I sometimes forget about that.</i>”[pg]");
		outputText("Chi Chi mutters something about messed up crazed felines before heading back to her training. Not much you can do about Patchoulie, she's bound by rules so abstract it’s difficult to even figure the smallest thing about how she actually functions, even if you tried to kill her she’d likely reply to you that she can only die during teatime on a winter solstice if impaled with a spear made of mistletoe.[pg]");
		bimboPatchInteractionHappened = true;
	}
	public function heliaInteraction():void {
		outputText("As you head to camp you are greeted by an interesting sight. Seems like Chi Chi and Helia are sharing drinks. They both boast about heroics and sing tavern songs out loud. Seems those two won’t be available for a few hours but at least they are getting along.[pg]");
		heliaInteractionHappened = true;
		doNext(playerMenu);
	}
	public function amilyInteraction():void {
		outputText("You spot both Amily and Chi Chi chatting to the side of the camp. They seem to be exchanging information about the various hostile denizens of Mareth as well as survival tricks.");
		amilyInteractionHappened = true;
		doNext(playerMenu);
	}

	public function talkAboutFur():void {
		outputText("You mention the topic of her fur to Chi Chi and she eyes you, intrigued.[pg]");
		outputText("\"<i>What’s with my fur [name] you ain't seriously going to tell me it puts you off when we already got this far in our relationship. Thats…</i>\"[pg]");

		menu();
		addButton(0, "Like it", likeIt);
		addButton(1, "Defur", defur);

		function defur():void {
			outputText("Truth be told you would like to feel some skin every now and then when the two of you share a bed. Beside this is one of your fetishes so if she desires to appeal to it she could take a step forward.[pg]");
			outputText("Chi Chi is obviously torn between her love for you and her principes but decides to humor your fantasies regardless.[pg]");
			outputText("\"<i>Fine wait for me while I go gather the ingredients, you're lucky I thought of this way before you dared to mention it.</i>\"[pg]");
			outputText("She heads to her backpack and retrieves a potion.[pg]");
			outputText("\"<i>I had a skilled alchemist brew this out of Hummus and Fiery saké, it should allow me to take on a more human like form while preserving my normal assets. Tsk… down the hatch.</i>\"[pg]");
			outputText("She chugs the thing down before you can say anything, cutting down any potential protest. Her transformation is swift and efficient as most of the fur covering her torso falls off, stopping at the elbows and the tights. Her face kept that defiant scolding look you know her for but took on a human shape fully. Hell, if she didn't look angry half the time she'd pass for more gorgeous than any girl you ever met in Ingnam. The only telltale sign of her origins are the ember like eyes and the obvious bucktooths in her mouth. She spins for you to get a full glance of her new improved her. Just as you’re about to comment that you love her new appearance, her tail suddenly whips about and ties to your hand, pulling you in her arms.[pg]");
			outputText("\"<i>Like what you saw hun? I hope so because you’re going to try the material first hand now. I’m smoldering hot and ready.</i>\"[pg]");
			outputText("Oh god she's in the mood and her expression clearly tell she won't accept no for an answer.[pg]");
			ChiChiDefurred = true;
			cheatTime(1/4);

			menu();
			if (model.time.hours > 18) addButton(0, "Until Dawn", chichiSexUntilDawn);
			else addButtonDisabled(0, "Until dawn", "It's too early for this. Wait till 7 pm.");
			if (player.hasCock()) addButton(1, "Gentle Fuck", chichiSexGentleFuck);
			else addButtonDisabled(1, "Gentle fuck", "Get a dick, bro.");
			if (player.hasVagina()) addButton(2, "HinezumiYuri", chichiSexHinezumiYuri);
			else addButtonDisabled(2, "HinezumiYuri", "Be a pussy or have one, sis.");
			if (ChiChiCorruption >= 9) addButton(3, "Corrupt", corruptSexRouter);
		}
		function likeIt():void {
			outputText("You were just commenting on her beautiful luster. You’re fine with her staying as she is, no change whatsoever. Chi Chi nods in appreciation.[pg]");
			outputText("\"<i>Well great I prefer it that way too.</i>\"[pg]");
			doNext(chichiTalksMenu);
			cheatTime(1/4);
		}
	}

	private function chichiPregChance():void {
		//Get out if already pregged.
		if (pregnancy.isPregnant) return;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 2) return;
		return;// <- remove this line when midoka is ready to be born			TO-DO Midoka is not complete enough yet to include, also need ChiChi preg update and appearance texts
		//See if any of the scenarios get her preg
		var preg:Boolean = false;
		//1% chance per 500mLs of cum, max 5%
		var score:Number = Math.min(player.cumQ()/500,5);
		score += player.virilityQ() * 200;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 4) score *= 1.5;
		trace("ChiChi Preg Check Virility Score: " + score);
		if((player.cumQ() > (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4? 150 : 250) && score >= rand(100)) || player.hasPerk(PerkLib.PilgrimsBounty)) {
			preg = true;
			trace("ChiChi knocked up!");
		}
		else trace("ChiChi not knocked up!");
		if (preg) {
			pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_MOUSE);
			sceneHunter.print("\n<b>ChiChi is pregnant!</b>");
		}
	}

	public function unplannedPregnancy():void {
		spriteSelect(SpriteDb.s_chichi);
		clearOutput();
		outputText("Chi-Chi walks over to you, a very serious expression in her eyes. She looks frustrated and with due cause, the proud warrior’s belly has inflated to the size of a balloon.[pg]");
		outputText("“<i>Look, [name], I would have been angry had you abused me in my drunken state in the evenings to fuck me, but to think you would steep so low as to impregnate me?! I don’t know if I should pulverize your head or hug you tightly. Regardless, for the sake of OUR child I ask that as of now you assume full responsibility as a father.</i>”[pg]");
		outputText("Does that mean the both of you are a couple now?[pg]");
		outputText("“<i>Of course it does, I just wish you married me first, you moron!</i>”[pg]");
		outputText("She slams her closed fist against your head to make the point clear. Owch! Well this went better than you thought it would, guess the two of you are together for the best and the worst now.[pg]");
		flags[kFLAGS.CHI_CHI_FOLLOWER] = 4;
	}

	public function chichiGivesBirth():void {
		spriteSelect(SpriteDb.s_chichi);
		clearOutput();
		outputText("You hear Chi Chi calling for you and run to her.[pg]");
		outputText("“[name]! You are just in time. I was worried I would give birth to our child without you around.”[pg]");
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 6) outputText("You can’t help but be amazed at the absence of a spiky reply or aggressiveness in her tone. This is likely how she is once she stops pretending she’s not in deep love with you. Makes you ponder what marrying her would be like. ");
		outputText("You hold Chi Chi’s hand as she goes into labor and give her your full moral support through the whole process. The mouse baby finally comes out, inch by inch and to your surprise it is not actually covered in fire. Once outside it begins crying and you swiftly hand your kid over to Chi Chi.[pg]");
		//(Add this part when coding gender if we do more than just female)		//TODO
		//outputText("While you were handling the baby you got to get a close look at its gender, it’s definitely a .[pg]"); //[Boy] [Girl]
		outputText("Chi Chi tenderly nurses the newly born mouse, smiling in clear happiness. That said, Chi Chi looks at you expectantly.[pg]");
		SceneLib.midokaScene.nameMidoka();
	}

	private function chichiPregUpdate():Boolean {
		switch (pregnancy.eventTriggered()) {
			case 2: if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 4) unplannedPregnancy();
				else outputText("\nWhen you come to check on Chi-Chi you notice she’s smiling as she caresses her belly, which bulges notably, but not with any real prominence. “<i>It seems that our exploits have born fruit, [name]</i>”[pg]");
				return true;
		}
		return false; //If there's no update then return false so needNext is not set to true
	}
}
}