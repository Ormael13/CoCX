/**
 * ...
 * @author Ormael, written by Dragon Hearts/Liadri, Pregnancy by Canadian Snas
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.internals.SaveableState;

import coc.view.ButtonDataList;

public class NadiaFollower extends NPCAwareContent implements TimeAwareInterface, SaveableState
	{
		public var pregnancy:PregnancyStore;

		public function timeChange():Boolean {
			pregnancy.pregnancyAdvance();
			return false;
		}

		public function timeChangeLarge():Boolean {
			if (pregnancy.isPregnant) {
				switch (pregnancy.eventTriggered()) {
					case 1:
						NadiaPregAnnouncement();
						return true;
					case 2:
						NadiaPreg1();
						return true;
					case 3:
						NadiaPreg2();
						return true;
					case 4:
						NadiaPreg3();
						return true;
				}
				return false;
			}

			if (pregnancy.isPregnant && pregnancy.incubation == 0) {
				NadiaGivesBirth();
				pregnancy.knockUpForce(); //Clear Pregnancy
				return true;
			}
			return false;
		}

		public function NadiaFollower() {
			pregnancy = new PregnancyStore(kFLAGS.NADIA_PREGNANCY_TYPE, kFLAGS.NADIA_INCUBATION,0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER,  240, 175, 125, 50);
			EventParser.timeAwareClassAdd(this);
			Saves.registerSaveableState(this);
		}

		private function NadiaPregChance():void {
			//Get out if already pregged.
			if (pregnancy.isPregnant) return;
			var preg:Boolean = false;
			//1% chance per 100mLs of cum, max 75%
			var score:Number = Math.min(player.cumQ()/100,75);
			score += player.virilityQ() * 200;
			if((player.cumQ() > (score >= rand(100)) || player.hasPerk(PerkLib.PilgrimsBounty))) {
				preg = true;
			}
			if (preg) {
				pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_NADIA);
				sceneHunter.print("\n<b>Nadia is pregnant!</b>");
			}
		}

/*
DIANA_FOLLOWER - status:
    0 - unknown
    1 - intermediate
    2 - "slightly corrupted"
    3 - vag raped, locked
    4 - unused, but probably corrupted too
    5 - wants you
    6 - follower

*/

		public static var NadiaSonsNum:Number;
		public static var NadiaDaughtersNum:Number;
		public static var NadiaHermKidsNum:Number;
		public static var NadiaTotalKidsNum:Number;

		public function stateObjectName():String {
			return "NadiaFollower";
		}

		public function resetState():void {
			NadiaSonsNum = 0;
			NadiaDaughtersNum = 0;
			NadiaHermKidsNum = 0;
			NadiaTotalKidsNum = 0;
		}

		public function saveToObject():Object {
			return {
				"NadiaSonsNum": NadiaSonsNum,
				"NadiaDaughtersNum": NadiaDaughtersNum,
				"NadiaHermKidsNum": NadiaHermKidsNum,
				"NadiaTotalKidsNum": NadiaTotalKidsNum
			}
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				NadiaSonsNum = o["NadiaSonsNum"];
				NadiaDaughtersNum = o["NadiaDaughtersNum"];
				NadiaHermKidsNum = o["NadiaHermKidsNum"];
				NadiaTotalKidsNum = o["NadiaTotalKidsNum"];

			} else {
				// loading from old save
				resetState();
			}
		}

public function defeatedFork():void {
	if (mocking) wonOverNadia();
	else if (flags[kFLAGS.NADIA_FOLLOWER] >= 6)
		wonOverNadiaSpar();
	else if (flags[kFLAGS.NADIA_FOLLOWER] == 5 && (player.hasCock() || !player.blockingBodyTransformations()))
		beMyStallionRepeat();
	else if (flags[kFLAGS.NADIA_FOLLOWER] < 3 && flags[kFLAGS.NADIA_LVL_UP] >= 8 && (player.hasCock() || !player.blockingBodyTransformations()))
		beMyStallion();
	else wonOverNadia();
}

public function repeatEnc():void {
	clearOutput();
	outputText("As you explore the area, you run into ");
	if (flags[kFLAGS.NADIA_LVL_UP] >= 8 && flags[kFLAGS.NADIA_FOLLOWER] != 3) outputText("Nadia");
	else if (flags[kFLAGS.NADIA_LVL_UP] >= 2) outputText("a unicorn");
	else outputText("a white furred horse morph");
	outputText(".\n\nAt first she doesn’t notice you, given how busy she is examining a flower. You walk closer to greet her, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled expression as she grabs her staff to defend herself, lunging for a set of preemptive strikes as she begins to attack you.\n\n");
	outputText("\"<i>Eeeeep! Go away, you fiend! ");
    if (flags[kFLAGS.NADIA_FOLLOWER] == 0)
        outputText("I’m not handing over my virginity to you");
	else if (flags[kFLAGS.NADIA_FOLLOWER] < 3)
        outputText("You stained my soul enough as it is. I don’t want any more of your corruption!");
	else
        outputText("You've already taken my virginity. What else do you want?!");
	outputText("!!!!!</i>\"\n\nYou prepare yourself as it seems you have a fight on your hands.\n\n");
	outputText("You are under attack by a");
	if (flags[kFLAGS.NADIA_LVL_UP] >= 8) outputText("n alicorn!");
	else if (flags[kFLAGS.NADIA_LVL_UP] >= 2) outputText(" unicorn!");
	else outputText(" horse morph!");
	startCombat(new Nadia());
	doNext(playerMenu);
}
public function postNameEnc():void {
	clearOutput();
	outputText("As you explore the area, you run into Nadia.\n\n");
	outputText("At first, she doesn’t notice you, to busy examining a flower. You walk to her to say hi, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled  expression and grabs her staff to defend herself, but relax as she realises it’s you.\n\n");
	outputText("\"<i>Oh hello [name]! I didn’t expect you. Say while you happen to be there, I’m in need of a sparring partner.</i>\". She takes a few steps towards you, spinning her staff with one hand. \"<i>Would you mind having a friendly fight with me?</i>\"\n\n");
	menu();
	addButton(1, "Sure", postNameEncSure);
	addButton(3, "Not Now", postNameEncNotNow);
}
public function postNameEncSure():void {
	outputText("Well why not? You could use a warmup yourself.\n\n");
	outputText("\"<i>Thank you [name], chances to improve myself are rare in these lands and I need all the training I can get to reach my goal and dreams.</i>\"\n\n");
	outputText("She grabs her staff and adopt a fighting stance, ready for combat.\n\n");
	outputText("You are fighting Nadia!");
	startCombat(new Nadia());
	doNext(playerMenu);
}
public function postNameEncNotNow():void {
	outputText("You don’t have time for sparring right now. Nadia looks slightly disappointed, but she nods respectfully as you head out back to camp.\n\n");
	endEncounter();
}

public function wonOverNadia():void {
	if (!mocking) levelingHerself();
	clearOutput();
	if (mocking) outputText("Getting your idea, Nadia winks to you and");
	else outputText("The horse morph")
	outputText(" kneels down defeated. Seems you can do whatever you want with her now. So, what will it be?\n\n");
	menu();
	addButton(1, "Rape", wonOverNadiaSex)
		.disableIf(player.lust < 33, "Not aroused enough.");
	addButton(0, "Spare", mocking ? wonOverNadiaSpar : wonOverNadiaSpare);
}
public function wonOverNadiaSex():void {
	menu();
	if (player.hasVagina()) {
        outputText("\n\nYou can make her lick your vagina.");
        addButton(0, "Oral (F)", wonOverNadiaOralF);
    }
	if (player.hasCock()) {
        outputText("\n\nYou can make her suck you off.");
		addButton(1, "Oral (M)", wonOverNadiaOralM);
        if (flags[kFLAGS.NADIA_FOLLOWER] < 3)
            outputText("\n\nOr you can take her precious virginity she asked you not to take.");
        else
            outputText("\n\nOr you can fuck her pussy again.");
		addButton(2, "Rape", wonOverNadiaRape);
	}
	addButton(3, "Back", wonOverNadia);
}
public function wonOverNadiaOralF():void {
	clearOutput();
	if (player.isBiped()) {
		outputText("You look over the defeated equine, as she lies panting on the ground. Getting an idea you remove your armour, and walk over her until your [pussy] is over the equine’s head. She looks up at you");
		if (flags[kFLAGS.NADIA_FOLLOWER] >= 2) outputText(", hungrily licking her lips");
		else outputText(" nervously");
		outputText(". Smirking you drop to you knees, making sure to pin her arms under your legs, before moving your pussy directly in front of her face.\n\n");
	}
	if (player.isTaur()) {
		outputText("You look over the defeated equine, as she lies panting on the ground. Getting an idea you remove your armour, and trotting over her body, moving the back of your centaur body over her head, so she can see your [pussy]");
		if (player.tailCount > 0) outputText(" behind your [tail]");
		outputText(". She looks up at you");
		if (flags[kFLAGS.NADIA_FOLLOWER] >= 2) outputText(", hungrily licking her lips");
		else outputText(" nervously");
		outputText(". Smirking, you sit down on her face, trapping her between your [pussy] and the ground.\n\n");
	}
	if (player.isNaga() || player.isScylla()) {
		outputText("You look over the defeated equine, as she lies panting on the ground. Getting an idea you remove your armour, and pick up her limp body with your ");
		if (player.isNaga()) outputText("naga tail");
		else outputText("scylla tentacles");
		outputText(", holding her in the air, before wrapping ");
		if (player.isNaga()) outputText("it");
		else outputText("them");
		outputText(" around her body and pulling her close until her face is directly in front your [pussy].\n\n");
	}
	//if (player.isAlraune()) outputText("The horse morph kneels down defeated. Seems you can do whatever you want with her now. So, what will it be?\n\n");
	outputText("\"<i>Lick it,</i>\" you order.\n\n");
	if (flags[kFLAGS.NADIA_FOLLOWER] >= 2) {
		outputText("She doesn’t even need to be told, since as soon as she could reach it she is licking your pussy and sticking her tongue into it, hungry for your sweet honey.\n\n");
	}
	else {
		outputText("The equine struggles, trying to escape. Annoyed you ");
		if (player.isBiped()) outputText("start cruelly twisting her mane, making her whimper in pain, telling her you won’t stop until she starts to see");
		if (player.isTaur()) outputText("start sitting harder on her, painfully squishing her face and making it nearly impossible to breathe. She begins to panic, struggling uselessly, but you tell her you won’t stop until she sees");
		if (player.isNaga() || player.isScylla()) {
			outputText("start squeezing her with your ");
			if (player.isNaga()) outputText("tail");
			else outputText("tentacles");
			outputText(" until she can’t breathe, she gasps, trying to suck air into her crushed lungs, you tell her you'll loosen your grip once she starts to see");
		}
		outputText(" the wisdom in licking you. She starts to quickly lick your pussy, trying to please you to stop your punishment.\n\n");
	}
	outputText("You moan happily as her large equine tongue eats your cunt out, you move your hands up to your breasts, grabbing and squeezing them under your hands while your fingers sink into your soft flesh. You moan and pinch your stiff nipples as she licks your pussy and continues to pleasure your breasts, helping the equine bring you to an orgasm, which you feel building.");
	outputText(" Eventually it comes, and you moan loudly as you orgasm, spraying your girl juices over the equines face, soaking it and making her have to drink them.\n\n");
	if (player.isBiped() || player.isTaur()) {
		outputText("Satisfied you climb off the equine, and look down at her. She is lying on the ground panting again, but this time her face is soaked by your pussy’s juices");
		if (flags[kFLAGS.NADIA_FOLLOWER] >= 2) outputText(", which she eagerly licks off her face");
		outputText(". Smirking, you redress and head off, finally leaving the equine to catch her breath.\n\n");
	}
	if (player.isNaga() || player.isScylla()) {
		outputText("Satisfied, you release the equine from your ");
		if (player.isNaga()) outputText("tail");
		else outputText("tentacles");
		outputText(", letting her slip to the ground panting, her face soaked with your girl cum");
		if (flags[kFLAGS.NADIA_FOLLOWER] >= 2) outputText(", which she eagerly licks off her face");
		outputText(". Smirking you redress and head off, finally leaving the equine to catch her breath.\n\n");
	}
	if (flags[kFLAGS.NADIA_FOLLOWER] < 2) flags[kFLAGS.NADIA_FOLLOWER]++;
	player.sexReward("vaginalFluids");
	cleanupAfterCombat();
}

public function wonOverNadiaOralM(mockForce:int = 0):void {
	clearOutput();
	if (mocking && !mockForce) {
		outputText("Would you like to let her do the job nicely, or force your mare a bit?");
		menu();
		addButton(0,"LetHer",wonOverNadiaOralM, 1);
		addButton(0,"Force",wonOverNadiaOralM, 2);
		return;
	}
	var x:int = player.biggestCockIndex();
	var likesIt:Boolean = mocking ? mockForce == 1 : flags[kFLAGS.NADIA_FOLLOWER] >= 2;
	if (player.isBiped()) {
		outputText("You walk towards your defeated equine foe who lies panting on the ground, trying to regain her breath. As you stand over her the sight of her panting lips gives you an idea of how to blow off some steam. You part your groin armour, pulling out your [cocks].");
		if (player.hasVagina() && flags[kFLAGS.NADIA_FOLLOWER] == 0) outputText(" Shocking the equine to find out you're actually a hermaphrodite.");
		if (likesIt) outputText(" The equine licks her lips eagerly at the sight of your [cockplural].");
		outputText("\n\nYou step over her, standing above her torso while she watches you with ");
		if (flags[kFLAGS.NADIA_FOLLOWER] == 0) outputText("nervous anticipation, unsure what you’re doing.");
		else if (flags[kFLAGS.NADIA_FOLLOWER] == 1) outputText("dreaded anticipation, knowing what is coming next.");
		else outputText("eager anticipation, looking at you with a come hither look.");
		outputText("\n\nSmirking, you grab hold of your already hardening [cock biggest] ");
		if (player.cockTotal() > 1) outputText("from your bunch of [cocks]");
		outputText(", before reaching down and yanking her head up by her mane. Making her ");
		if (likesIt) outputText("squeal happily, already eager to suck your cock");
		else outputText("whimper in pain");
		outputText(", as you slap your [cockplural] against her cheek.\n\n");
	}
	if (player.isTaur()) {
		outputText("You trot over to your defeated equine foe as she lies on the ground panting and trying to regain her breath, her panting lips giving you an idea of how to blow off some steam. You walk over her, showing off your semi erect [cocks] that hang between your hind legs.");
		if (player.hasVagina() && flags[kFLAGS.NADIA_FOLLOWER] == 0) outputText(" Shocking the equine to find out you're actually a hermaphrodite.");
		if (likesIt) outputText(" The equine licks her lips eagerly at the sight of your [cockplural].");
		outputText("\n\nYou reach down and grab her by the shoulders before dragging her to a nearby " + object() + ",");
		if (likesIt) outputText("the equine happily letting herself get manhandled while you prop her against a " + object() + "");
		else outputText("the equine putting up a brief struggle before giving up and letting herself be propped against the " + object() + "");
		outputText(", before you slap your [cockplural] against her cheek.\n\n");
	}
	if (player.isNaga() || player.isScylla()) {
		outputText("You ");
		if (player.isNaga()) outputText("slither");
		else outputText("move");
		outputText(" beside the defeated equine as she pants and tries to regain her breath. With a sly grin, you watch her moving lips and get an idea of how to blow off some steam. You slip into your ");
		if (player.isNaga()) outputText("cavity");
		else outputText("whatever");
		outputText(" and pull out your [cocks].");
		if (player.hasVagina() && flags[kFLAGS.NADIA_FOLLOWER] == 0) outputText(" Shocking the equine to find out you're actually a hermaphrodite.");
		if (likesIt) outputText(" The equine licks her lips eagerly at the sight of your [cockplural].");
		outputText("\n\nYou wrap your dexterous ");
		if (player.isNaga()) outputText("naga tail");
		else outputText("scylla tentacles");
		outputText(" tightly around her waist, lifting her off the ground and into the air.");
		if (likesIt) {
			outputText("She gives you a sultry look as she runs her hands along your ");
			if (player.isNaga()) outputText("tail");
			else outputText("tentacles");
			outputText(", before giving you a come hither look.");
		}
		else {
			outputText("She struggles, trying to escape from your ");
			if (player.isNaga()) outputText("tail");
			else outputText("tentacles");
			outputText(" but soon giving up when she realizes it’s impossible.");
		}
		outputText(" Smirking, you move her head against your torso, slapping your [cockplural] against her cheek.\n\n");
	}
	//if (player.isAlraune())
	outputText("\"<i>Suck it,</i>\" you order.\n\n");
	if (likesIt) {
		outputText("You don’t really even have to tell her, she’s already practically drooling. She quickly grabs your ");
		if (player.cockTotal() > 1) outputText("largest ");
		outputText("cock, before lovingly running her tongue down your shaft as well as planting some loving kisses across it, showering it with her devotion. She eventually moves her mouth back up the length, reaching the head and planting another loving kiss on it.\n\n");
		outputText("Pleased you start pushing your ");
		if (player.cockTotal() > 1) outputText("largest ");
		outputText("[cock biggest] into her eager mouth, ");
		if (player.cocks[x].cockLength >= 15) outputText("she happily takes every inch of your massive member as you force it into her mouth, stopping short of deepthroating her. She doesn’t even care that her mouth is being uncomfortable stretched, she just wants the rest of your cock");
		else if (player.cocks[x].cockLength >= 9) outputText("she happily takes every inch of your large member as you force it into her mouth, stopping short of deepthroating her. She looks hungrily at the rest of your dick she has yet to take");
		else if (player.cocks[x].cockLength >= 5) outputText("she happily takes all of the cock you push into her mouth, which is nearly your entire length until her mouth is full of cock");
		else outputText("she happily takes your small member into her mouth");
		outputText(".\n\nYou start thrusting your hips causing her to let out a happy but muffled moan, loving the feeling of having her mouth fucked by your length. ");
		if (player.cockTotal() > 2) outputText("She reaches out and grabs hold of two more of your dicks, enthusiastically jerking them off. ");
		else if (player.cockTotal() >= 1) outputText("She reaches out and grabs hold of your other cock, enthusiastically jerking it off while her other hand buries itself into her own sex, pleasuring herself. ");
		else outputText("She buries one of her hands into her sex, while the other plays with her breasts, trying to pleasure herself while she enthusiastically blows you. ");
		if (player.cocks[x].cockLength >= 15) outputText("Smirking, you start pushing the rest of your massive cock into her mouth, making her moan loudly as her throat is stuffed with your cock, her neck bulging with its shape as it slips down her throat and into her stomach, both of you reveling in the pleasure, her eyes rolling back into her head in total bliss while her hands continue to work");
		else if (player.cocks[x].cockLength >= 9) outputText("Smirking, you push the rest of your large cock into her mouth, which she eagerly accepts it, trying to move her head forward to take it in quicker. You start deepthroating her, enjoying the feeling of your length sinking in and out of her throat while she moans like a whore");
		else if (player.cocks[x].cockLength >= 5) outputText("Smirking, you push the rest of your cock into the eager equine mouth, making her moan happily as the head of your cock slips into her throat. You start throat fucking her, letting your cock ravage the tip of her throat while you both enjoy the feeling, the equine moaning with every thrust");
		else outputText("As you thrust your hips, you tell her to pleasure you more, which she does, sucking as hard as she can while her tongue licks everything it can reach, savoring the taste of your dick");
	}
	else {
		outputText("The equine tries to move her head away, ");
		if (flags[kFLAGS.NADIA_FOLLOWER] == 0) outputText("disgusted by the thought of serving you, ");
		else outputText("not wanting to serve you again, ");
		outputText(" keeping her mouth shut tight. ");
		if (player.isBiped()) outputText("Irritated, you twist her mane, causing her to whimper in pain. She keeps her lips closed, and you pull again, harder. She looks up at you, fear and anger in her gaze, but gives in and parts her lips.");
		if (player.isTaur()) outputText("Irritated, you whack her head with one of your hind [feet]. She yelps in pain, but stubbornly keeps her mouth closed. You strike her again, then a third time. until she gives in and opens her mouth.");
		if (player.isNaga() || player.isScylla()) {
			outputText("Irritated, you squeeze her very tightly with your ");
			if (player.isNaga()) outputText("tail");
			else outputText("tentacles");
			outputText(", making her gasp, you keep doing this until she gives up and parts her lips.");
		}
		outputText("\n\n.Satisfied you start pushing your ");
		if (player.cockTotal() > 1) outputText("largest ");
		outputText(" [cock biggest] into her now open mouth, ");
		if (player.cocks[x].cockLength >= 15) outputText("forcing your massive dick into her mouth, only stopping short of deepthroating her, her mouth being forced nearly painfully wide to hold your massive girth, while her eyes look fearfully at how much is left to go");
		else if (player.cocks[x].cockLength >= 9) outputText("forcing your large member into her mouth, stopping short of deepthroating her. She casts a worried gaze at how much of your dick is left out of her mouth");
		else if (player.cocks[x].cockLength >= 5) outputText("making her take your near entire length until her mouth is full of your cock");
		else outputText("her mouth easily taking your small member");
		outputText(". You savor the feeling of her hot mouth around your member.\n\n");
		outputText("You start thrusting your hips, causing her to let out a muffled moan as her mouth is raped by your length, causing her to grab hold of your hips. From her muffled cries, as she pushes back against you, it's clear she's trying to control your thrusts, but you're simply too powerful for her. ");
		if (player.cocks[x].cockLength >= 15) outputText("Smirking, you start forcing your entire length in, making her eyes bulge and water as your massive member pushes its way into her throat and all the way down into her stomach, her neck bulging with the shape of your cock. You start thrusting your hips again, fucking her entire throat and stomach while enjoying every second of it, her watering eyes rolling back as her hands fall limply to her side, unable to bear it all");
		else if (player.cocks[x].cockLength >= 9) outputText("Smirking, you start pushing your entire length in, her eyes widening as your cock slips down her throat, not giving her enough time to gag. You begin deepthroating her, letting your length rape nearly her entire throat, while you enjoy the feeling of her throat as she moans and whimpers");
		else if (player.cocks[x].cockLength >= 5) outputText("Smirking, you start pushing the rest of your cock into her mouth, her eyes widen as your cock slips into her throat nearly causing her gag. You begin throat fucking her, letting your cock ravage the top of her throat while you enjoy the feeling of her tight neck around your cock head, as she lets out loud muffled moans");
		else outputText("While you thrust your hips you order her to suck on your dick, which she does, sucking as hard as she can while you thrust into her mouth, enjoying the feeling");
	}
	outputText(".\n\nYou continue to fuck her face for a good while, enjoying her mouth as much as you can, before you start to feel the coming onslaught of an orgasm. You speed up your thrusts, smacking her cheeks with your [hips]. You pump faster, the pressure building in your loins.");
	if (likesIt && player.cockTotal() > 1) outputText(" Seeing you’re about to cum, she points your other [dickplural] at her, so you’ll cum on her.");
	outputText("\n\n");
	if (likesIt) {
		if (player.cumQ() >= 2000) {
			if (player.cocks[x].cockLength >= 15) outputText("You make sure she is taking your entire length before you cum, spraying your massive load directly into her stomach with such force that her stomach bulges, making it swell and bloat with yor cum. She moans happily as her belly swells until she looks pregnant, her face totally blissed out");
			else if (player.cocks[x].cockLength >= 5) outputText("You make sure she is taking your entire length before you cum, spraying your massive load right down her throat. She moans happily as her belly visibly swells with your cum, bloating her until she looks pregnant. her eyes roll back into her head, her horse-face totally blissed out");
			else outputText("You hold your hips against her face as you cum, spraying your massive load inside her mouth making her cheeks bulge with your cum, she does her best to swallow as fast as she can but your load is too large and thick, and it starts squirting out of her nose and mouth, her face totally blissed out");
			if (player.cockTotal() > 1) outputText(" while your other [cockplural] covers her naked body in cum");
			outputText(".");
		}
		else {
			if (player.cocks[x].cockLength >= 15) outputText("You grab the back of her head, slamming her face into your hips. You sink balls-deep into her throat before you cum, spraying your load directly into her stomach");
			else if (player.cocks[x].cockLength >= 5) outputText("You grab the back of her head, slamming her face into your hips. You sink balls-deep into her throat before you cum, spraying your load right down her throat");
			else outputText("You force your hips against her face as you cum, spraying your load inside her mouth, making sure she swallows it");
			if (player.cockTotal() > 1) outputText(" while your other [cockplural] spray its load all over her face and body");
			outputText(".");
		}
		outputText("\n\nEventually your orgasm finishes and you pull your [cock biggest] out of her mouth, while she continues sucking on it as it comes out to remove the last of the cum from it. After she finishes she looks up at you with a satisfied cum stained smile, not unlike the grin on your own face. You help her stand up, and you two part.");
		if (player.cumQ() >= 2000) outputText(" She staggers away, walk slightly troubled by how bloated her belly is.");
	}
	else {
		if (player.cumQ() >= 2000) {
			if (player.cocks[x].cockLength >= 15) outputText("You make sure she is taking your entire length before you cum, spraying your massive load directly into her stomach with such force that her stomach bulges, before making it swell and bloat with you cum. Her eyes widen and water as her belly is swelled until she looks pregnant.");
			else if (player.cocks[x].cockLength >= 5) outputText("You make sure she is taking your entire length before you cum, spraying your massive load right down her throat, her eyes widen and water as her belly visibly swells with your cum, bloating her until she looks pregnant.");
			else outputText("You hold your hips against her face as you cum, spraying your massive load inside her mouth, making her cheeks bulge with your cum, her eyes widen in horror and she tries to swallow as fast as she can but your load is too large and thick, and it starts squirting out of her nose and mouth, making her eyes water.");
		}
		else {
			if (player.cocks[x].cockLength >= 15) outputText("You make sure she is taking your entire length before you cum, spraying your load directly into her stomach.");
			else if (player.cocks[x].cockLength >= 5) outputText("You make sure she is taking your entire length before you cum, spraying your load right down her throat.");
			else outputText("You force your hips against her face as you cum, spraying your load inside her mouth, making sure she swallows it.");
		}
		outputText("\n\nEventually your orgasm finishes and you pull your [cock biggest] out of her mouth, ");
		if (player.isBiped() || player.isNaga()) outputText("releasing her from your grip before ");
		outputText("letting her sink to the ground where she sits panting with her belly ");
		if (player.cumQ() >= 2000) outputText("bloated with your cum");
		else outputText("full of your cum");
		outputText(". You redress before heading off, leaving her splayed out, gasping for air.");
	}
	if (flags[kFLAGS.NADIA_FOLLOWER] < 2) flags[kFLAGS.NADIA_FOLLOWER]++;
	player.sexReward("saliva");
	cleanupAfterCombat();
}
private function object():String {
	var buffer:String = "";
	var temp:int = rand(3);
	if(temp == 0) buffer += "rock";
	else if(temp == 1) buffer += "tree stump";
	else buffer += "fallen tree";
	return buffer;
}

private function virginity():Boolean {
	return !(flags[kFLAGS.NADIA_FOLLOWER] == 3 || mocking);
}
public function wonOverNadiaRape():void {
	clearOutput();
	var x:int = player.biggestCockIndex();
	sceneHunter.print("Fork for taur, scylla, naga bodies.");
	if (player.isBiped()) {
		outputText("You look over the defeated equine as she lays sprawled across the ground. Her legs are slightly parted, so her exposed pussy catches your eye" + (virginity() ? ", looking untouched or used" : "again") + ". Licking your lips, you start undressing as the equine watches you, worry clear in her eyes" + (player.gender == 3 ? ", her worry only increasing when she sees that you're a hermaphrodite" : "") + ". You walk beside her and push her onto her stomach, ");
		outputText("before grabbing both her hands and forcing them behind her back, she struggles, getting what you’re about to do, but you hold her firm and " + (player.cocks.length == 1 ? "grab you're already hardening [cock biggest]" : "grab your already hardening [cockFit 36] from among your bunch of [cocks] cocks") + ".\n\n");
		if (virginity()) {
			outputText("\"<i>NO WAIT, I'm saving my first time for my stallion!</i>\" she whimpers, trying to pull her hands free.\n\n");
			outputText("\"<i>Too bad, you should’ve been more careful. Cause now I’m horny!</i>\" you say, while forcing her arse up into the air, giving you better access to her cunt.\n\n");
			outputText("\"<i>Noo!</i>\" she whimpers, as you place your cock against her virgin cunt, grinding against it to make it wet.\n\n");
		}
		else {
			outputText("\"<i>No, not again!</i>\" she groans, not even bothering to struggle this time and letting herself get manhandled into position, with her arse stuck up into the air.\n\n");
			outputText("\"<i>Well you shouldn’t keep fighting me if you don’t want to end up like this,</i>\" you say, placing your cock against her already wettening cunt.\n\n");
		}
		outputText("Once she feels wet enough, you plunge your entire [cock biggest] dick in at once, " + (virginity() ? "making her scream as her virginity is cruelly taken away by you in one stroke" : "making her moan loudly as her pussy is once against filled by your cock") + ". Once she quiets down, you start thrusting your hips, " + (virginity() ? "ignoring her whimpering and enjoying her tight virgin pussy" : "enjoying the tight pussy that you broke in") + ". ");
		outputText("Soon she " + (virginity() ? "stops whimpering and" : "once again") + " starts moaning as you continue to fuck her cunt, encouraging you to thrust harder and making her moan louder.\n\n");
		outputText("You let go of her hands, moving your hands to her hips so you can thrust deeper into her, since she has given up trying to escape. Once you’ve gotten a good rhythm you reach forward and tilt her head up, so you can see her face. She has a whorish expression on her face, her eyes are rolled back while her tongue hangs out of her open mouth.\n\n");
		outputText("\"<i>What a slutty look you have on your face,</i>\" you note, as your hips hammer her cunt, \"<i>" + (virginity() ? "I bet you actually wanted to lose your virginity!?" : "Despite your struggling, you actually like being fucked by me?!") + "</i>\"\n\n");
		outputText("\"<i>Noooo...</i>\" she moans, her pussy tightening.\n\n");
		outputText("You reach around her chest and grabs hold of her tits, squeezing them hard and earning a loud moan from her. You move your fingers to her nipples, where you twist and tug them, making her scream in pleasure and pain, her pussy tightening as a result. You feel that you're going to cum soon.\n\n");
		outputText("\"<i>Going to cum!</i>\" you say, warning her.\n\n");
		outputText("\"<i>NO! Don’t cum inside meeee!</i>\" she moans, panicking, \"<i>I don’t want to get pregnant!</i>\"\n\n");
		outputText("Grunting, you thrust even harder and pinch her nipples hard, making her pussy tighten further and her scream in masochistic pleasure, and just when you are about to cum, you pull out, spraying your load across her back and covering it with your cum. Panting, you get dressed, and leave the well fucked mare, to lay there with her arse sticking up into the air.\n\n");
		outputText("You hope she can get up before an imp finds her.\n\n");
	}
	if (player.isScylla()) {
		outputText("You look over the defeated equine as she is sprawled across the ground. Wondering what you’ll do to her, you wrap your tentacles around her hands before dragging her into the air, making her hang in front of you. She struggles but your strong tentacles holds her hands trapped.\n\n");
		outputText("\"<i>Mmmm, what should I do with you,</i>\" you ask, running your hands down her body, until your hands reach her pussy.\n\n");
		if (virginity()) {
			outputText("\"<i>Don’t touch me there!</i>\" she yells, trying to escape, \"<i>Going to cum!</i>\" you say, warning her.\n\n");
			outputText("\"<i>Oh really?</i>\" you say, while slipping one of your fingers into her unprotected pussy, where you find out to your surprise that she is a virgin. \"<i>How surprising,</i>\" you note, pulling out your [cock biggest] from out between your tentacles, it’s already erect in anticipation.\n\n");
		}
		else {
			outputText("\"<i>No, not again!</i>\" she whines, once again in a similar position.\n\n");
			outputText("\"<i>You really shouldn’t keep fighting me if you don’t want this to happen,</i>\" you say, pulling out your [cock biggest] from out between your tentacles, it’s already erect in anticipation.\n\n");
		}
		outputText("You force her legs open with some other tentacles, parting them as far apart as you can and giving you totally unrestricted access to her pussy. Grinning you line up your cock with her pussy, positioning it right up against her lips.\n\n");
		if (virginity()) {
			if (player.cocks[x].cockLength > 10) {
				outputText("\"<i>No that’s too big! It’ll never fit!!</i>\" she whimpers, trying to escape but ending up only managing to grind herself against your cock, arousing herself and making her moan.\n\n");
				outputText("\"<i>Don’t worry it will,</i>\" you reassure her, grinding your cock against her to make her wet.\n\n");
			}
			else {
				outputText("\"<i>No, I don’t want my first time taken by you!</i>\" she whimpers, trying to escape but ending up only managing to grind herself against your cock, arousing herself and making her moan.\n\n");
				outputText("\"<i>It could be worse, I could be a demon,</i>\" you suggest, grinding your cock against her exposed lips. With each thrust, she dampens, her button hardening against you.\n\n");
			}
		}
		else {
			outputText("She moans as your cock touches her, her body seeming to remember getting fucked by you before making her pussy already grow moist.\n\n");
			outputText("\"<i>For someone who says she hates this, your body sure seems to like it,</i>\" you taunt, grinding your cock against her to make her wetter.\n\n");
		}
		outputText("She doesn’t respond since she is already moaning as her " + (virginity() ? "virgin pussy is grinded against your cock, growing wetter with every grind until it’s soaked" : "moist pussy is grinded against your cock, quickly becoming soaked and ready to be fucked again") + ".\n\n");
		if (virginity()) outputText("Adjusting her body you thrust your cock into her, making her whimper as your cock rips apart her hymen, taking her virginity.\n\n");
		else outputText("Adjusting her body you thrust your cock into her, making her moan as her pussy is once again filled with your cock.\n\n");
		outputText("Using your tentacles you start making her ride your cock, " + (virginity() ? "her whimpers soon becoming moans as her pussy is pounded" : "moaning loudly as the familiar cock pounds her pussy once again") + ". ");
		outputText("You increase your tentacles' movement, increasing the speed in which she humps you, leaving your hands free to play with her tits, making her gasp as you tug her nipples while your tentacles do all the work, teasing her breasts mercilessly until eventually you feel the oncoming orgasm. She moans, eyes wide, as your cock twitches inside her.\n\n");
		outputText("\"<i>Please, don’t cum inside me!</i>\" she begs, squirming against your tentacles.\n\n");
		outputText("Feeling some pity, just as you're about to cum, you slip her off you, the feeling pushing you over the edge as you cum over her body, covering her fur in your white spunk.\n\n");
		outputText("Satisfied, you dump her own the ground, leaving her there as you redress yourself and move on.\n\n");
	}
	if (player.isNaga()) {
		outputText("You look over the defeated equine as she is sprawled across the ground. Wondering what you’ll do to her, you wrap your tail around her hands before dragging her into the air, making her hang in front of you. She struggles but your strong tail holds her hands trapped.\n\n");
		outputText("\"<i>Mmmm, what should I do with you,</i>\" you ask, running your hands down her shoulders, then down to her hips. She winces, trying to pull away, but you hold on, slowly running your hands across her front until they meet in the middle, just above her blushing pussy lips.\n\n");
		if (virginity()) {
			outputText("\"<i>Don’t touch me there!</i>\" she yells, trying to escape, \"<i>Going to cum!</i>\" you say, warning her.\n\n");
			outputText("\"<i>Oh really?</i>\" you say, while slipping one of your fingers into her unprotected pussy, where you find out to your surprise that she is a virgin. \"<i>How surprising,</i>\" you note, pulling out your [cock biggest] from your hidden cavity, it’s already erect in anticipation.\n\n");
		}
		else {
			outputText("\"<i>No, not again!</i>\" she whines, once again in a similar position.\n\n");
			outputText("\"<i>You really shouldn’t keep fighting me if you don’t want this to happen,</i>\" you say, pulling out your [cock biggest] from your hidden cavity, it’s already erect in anticipation.\n\n");
		}
		outputText("You force her legs open, parting them as far apart as you can, giving you unrestricted access to her pussy. Grinning, you line up your cock with her pussy, positioning it right up against her lips.\n\n");
		if (virginity()) {
			if (player.cocks[x].cockLength > 10) {
				outputText("\"<i>No that’s too big! It’ll never fit!!</i>\" she whimpers, trying to escape but ending up only managing to grind herself against your cock, arousing herself and making her moan.\n\n");
				outputText("\"<i>Don’t worry it will,</i>\" you reassure her, grinding your cock against her to make her wet.\n\n");
			}
			else {
				outputText("\"<i>No, I don’t want my first time taken by you!</i>\" she whimpers, trying to escape but ending up only managing to grind herself against your cock, arousing herself and making her moan.\n\n");
				outputText("\"<i>It could be worse, I could be a demon,</i>\" you suggest, grinding your cock against her to make her wet.\n\n");
			}
		}
		else {
			outputText("She moans as your cock touches her, her body seeming to remember getting fucked by you before making her pussy already grow moist.\n\n");
			outputText("\"<i>For someone who says she hates this, your body sure seems to like it,</i>\" you taunt, grinding your cock against her to make her wetter.\n\n");
		}
		outputText("She doesn’t respond, already moaning as her " + (virginity() ? "virgin pussy is rubbed against your shaft, growing wetter with every stroke until it’s soaked" : "moist pussy is grinded against your cock, quickly becoming soaked and ready to be fucked again") + ".\n\n");
		if (virginity()) outputText("Adjusting her body you thrust your cock into her, making her whimper as your cock rips apart her hymen, taking her virginity.\n\n");
		else outputText("Adjusting her body, you thrust your cock into her, making her moan as her pussy is once again filled with your cock.\n\n");
		outputText("Using your tail you start making her ride your cock, " + (virginity() ? "her whimpers soon becoming moans as her pussy is pounded" : "moaning loudly as the familiar cock pounds her pussy once again") + ". ");
		outputText("You increase your tail movement, increasing the speed in which she humps you, using your hands to play with her tits, making her gasp as you tug her nipples while your tail does all the work, teasing her breasts unmercifully, until eventually you feel the oncoming orgasm, and she must feel it too.\n\n");
		outputText("\"<i>Please, don’t cum inside me!</i>\" she begs, squirming in your tail.\n\n");
		outputText("Feeling some pity, just as you're about to cum, you slip her off you, the feeling pushing you over the edge as you cum over her body, covering her fur in you white spunk.\n\n");
		outputText("Satisfied, you dump her own the ground, leaving her there as you redress yourself and slither off.\n\n");
	}
	if (player.isTaur()) {
		outputText("You grab the fallen equine and drag her off to a nearby " + object() + ", draping her over it. You know exactly what you’re going to do with her. Not even bothering to undress, you climb over her, your cock erect and ready to go.\n\n");
		outputText("Realizing what you’re trying to do, she tries to escape but you squash her under your body, trapping her between you and the " + object() + " until she stops struggling. Once she finally gives up, your adjust your hips, pressing your cock against her sex. You run the length of your shaft across her lips, making her moan and whimper slightly as your [cock biggest] rubs against her folds.\n\n");
		if (virginity()) {
			outputText("\"<i>Please stop! I’m saving myself!!</i>\" she whimpers, feeling herself get wet under your assault.\n\n");
			outputText("\"<i>Shouldn’t have tried to fight me then,</i>\" you grunt, guessing that she’ll soon be wet enough.\n\n");
		}
		else {
			outputText("\"<i>No not again!!</i>\" she whimpers, feeling herself get wet under your assault.\n\n");
			outputText("\"<i>Admit it, you like it!</i>\" you smirk, knowing that she’ll soon be wet enough.\n\n");
		}
		outputText("Adjusting your hips one more time, you start pressing your cock against her folds, making her whimper again. Grunting, you force your cock into her, making her " + (virginity() ? "whimper as your cock tears her hymen as" : "moan as") + " it fills up her pussy with your meaty rod, sinking in until she’s totally full of your cock. ");
		outputText("Not satisfied with just this, you pull back your hips before plunging them back into her, making her moan loudly as you begin to thrust into her, the wet slapping noise of your hips slapping together filling the area as you rape her pussy, making her moan as your [cock biggest] pounds her pussy, her body shaking with each thrust.\n\n");
		outputText("She shudders at one point, possibly because of an orgasm, making her, already tight, pussy clamp down harder on your cock, earning a grunt from you as you feel yourself grow closer to an orgasm yourself.\n\n");
		outputText("\"<i>Gonna cum,</i>\" you grunt, speeding up your thrusts.\n\n");
		outputText("\"<i>NO! Cum outside!! Outside!!</i>\" she screams, trying to escape again.\n\n");
		outputText("Grunting, and with a huge amount of self-control, you pull yourself out of her, spraying your load over her back. Satisfied, you climb off her, leaving her to hang off the " + object() + ", crying softly to herself, while you dress yourself and leave.\n\n");
	}
	if (!mocking) flags[kFLAGS.NADIA_FOLLOWER] = 3;
	player.sexReward("vaginalFluids");
	cleanupAfterCombat();
}
public function wonOverNadiaSpare():void {
	clearOutput();
	if (flags[kFLAGS.NADIA_LVL_UP] == 8 && flags[kFLAGS.NADIA_FOLLOWER] < 3) {
		outputText("You tell the girl you will let her go. You have no business with her. The horse morph however doesn't leave right away.\n\n");
		outputText("\"<i>Thank you. I may have been too hasty to judge you and I think it’s high time we truly get acquainted. I just wanted you to know that my name's Nadia.</i>\"\n\n");
		outputText("Well Nadia, that’s one name you don't plan to forget. Still, she'd better be off on her way now. She nods and runs off disappearing in the forest.\n\n");
	}
	else {
		outputText("You tell the girl you will let her go. You have no business with her.\n\n");
		outputText("At first, she looks at you in confusion, then nods before running off in the forest. Maybe next time the two of you could meet on more friendly dispositions.\n\n");
	}
	cleanupAfterCombat();
}
public function lostToNadia():void {
	clearOutput();
	outputText("The horse morph kicks you in the face, knocking you unconscious. When you wake up, you realise she got away with some of your gems. Guess that's not the worst thing that could happen, right?\n\n");
	cleanupAfterCombat();
}
private function levelingHerself():void {
    if (flags[kFLAGS.NADIA_FOLLOWER] < 3 && flags[kFLAGS.NADIA_LVL_UP] < 8)
	    flags[kFLAGS.NADIA_LVL_UP]++;
}
public function beMyStallion():void {
	clearOutput();
	outputText("Nadia once again falls to the ground defeated, falling on her plump behind with an audible grunt. You put away your [weapon], before noticing that the alicorn is looking up at you with a strange expression.\n\n");
	outputText("\"<i>You really defeated me again, huh?</i>\" Nadia says, her voice not sounding upset, but strangely happy, \"<i>Not to mention that you have only gotten stronger as we fought.</i>\"\n\n");
	outputText("\"<i>I guess,</i>\" you say, wondering where this is going.\n\n");
	outputText("\"<i>I don’t think I’ll ever meet someone else as strong and powerful as you,</i>\" Nadia says, seeming to be embarrassed, as she blushes and draws in the dirt with her fingers, \"<i>You’ve beaten me so many times, but let me keep virginity, allowing me to become an alicorn like I always wanted...</i>\"\n\n");
	outputText("You cross your arms, letting Nadia continue talking.\n\n");
	outputText("\"<i>Most others just give up their virginity, not even caring about becoming a unicorn or an alicorn, they just give into their lust, sleeping with anyone they wanted,</i>\" Nadia says, her voice sad, \"<i>I always wanted to be an alicorn and find a stallion that could be my partner for life, but I would lose all that if I had sex...</i>\"\n\n");
	outputText("Nadia looks up at you, sadness in her eyes.\n\n");
	outputText("\"<i>You know how hard it was?</i>\" Nadia whimpers, her face flushed, \"<i>I’m always so horny that it hurt, there were so many times I just wanted to bend over to anything with a dick, just to let it fuck me until I was satisfied? My dreams were always full of me finally having sex, how wonderful it’ll be, but always to wake up in the morning and realize it was all a dream.</i>\"\n\n");
	outputText("You feel sorry for the alicorn, even though she worked herself into such a state, she is clearly getting aroused by even the mere thought of having sex.\n\n");
	outputText("\"<i>Everyone thought I was silly and just said to give up, but thanks to you, I’ve finally managed to become an alicorn,</i>\" Nadia says, calming down, \"<i>All I need is to find my stallion that I can give myself too, and... well... I...</i>\" Nadia starts to stutter, her face turning a deep red, before she squeezes her eyes shut and asks, \"<i>Can you be my stallion, please?</i>\"\n\n");
	outputText("You tilt your head to side, and ask the obvious question, \"<i>Why?</i>\"\n\n");
	outputText("\"<i>Cause, you’re so strong, and I really like that in a mate,</i>\" Nadia says, her face as red as tomato, \"<i>I think I’ll be really happy with you too, and the thought of having you father my foals fills me up with such a warm feeling... also I... think I love you too... so please say you’ll be my stallion, I’ll be a good mare and satisfy all your desires, carry all the children you want, so please...</i>\"\n\n");
	if (player.gender == 0 || player.gender == 2) {
		outputText("\"<i>You know I’m not a male right?</i>\" you says, frowning.\n\n");
		outputText("\"<i>I know, I know,</i>\" Nadia says, blushing, \"<i>But I have some equinum mixed with some incubus draft that you can use to grow a cock, so if you’ll be my stallion you’ll have to take some... sorry.</i>\"\n\n");
	}
	menu();
	addButton(0, "Yes", breakingInYourMare);
	addButton(1, "No", beMyStallionNo);
}
public function beMyStallionRepeat():void {
	clearOutput();
	outputText("Nadia asks with clear hopes in her eyes.\n\n");
	outputText("\"<i>Did you take your time to consider my request? Would you let me be your mare?</i>\"\n\n");
	menu();
	addButton(0, "Yes", breakingInYourMare);
	addButton(1, "No", beMyStallionNo);
}
public function beMyStallionNo():void {
	clearOutput();
	outputText("You apologize to Nadia but you can’t, not now not yet. You need some time to consider the option first.\n\n");
	outputText("For a moment she looks at you disappointed like she expected something else then finally reply.\n\n");
	outputText("\"<i>It’s all right take your time. Come back to me when you are ready to let me into your life. I can wait. </i>\"\n\n");
	flags[kFLAGS.NADIA_FOLLOWER] = 5;
	cleanupAfterCombat();
}
public function breakingInYourMare():void {
	clearOutput();
	if (!player.hasCock()) {
		outputText("You take the mixture, groaning as you suddenly feel a sizeable cock growing between your legs.\n\n");
		transformations.CockHorse(0, 10 + rand(7), 2 + rand(10) / 10).applyEffect(false);
	}
	outputText("Nadia, in a fit of excitement, suddenly climbs onto her knees and hands before turning around and presenting her rear for you to fuck, moving her tail out of the way of her virgin sex and her equally virgin arsehole, her whole body trembling in excitement.\n\n");
	outputText("\"<i>Thank you!</i>\" Nadia says, her voice full of happiness, as she shakes her behind temptingly. \"<i>I’ll be a good mare to you, but please fuck me!! I really can’t take it anymore, I just need your cock in me now!!</i>\" her voice desperate.\n\n");
	outputText("You place your hand on your new equine’s behind, her body quivering at your touch, as you slide across it, feeling the soft cheek under your fingers. Nadia moans loudly as you begin to fondle her arse, letting your fingers sink into yielding flesh, her body trembling butt is squeezed and molded by your hands.\n\n");
	outputText("\"<i>Please stop teasing me, and just fuck me!!</i>\" Nadia moans.\n\n");
	outputText("You tease, noting that she was supposed to be a good mare from now on. You give her ass another hard squeeze, earning a loud moan from Nadia. She should know a good mare would wait until her stallion is ready.\n\n");
	outputText("She shivers at your words, as if your orders somehow gave her pleasure, before nodding her head and waiting for you to eventually fuck her senseless. You move one of your hands off her butt, slipping it down between her legs, moving it across her pussy which is totally soaked while her juices are running down her leg and dripping onto the ground.\n\n");
	outputText("Her cunt is so wet from just a bit of light butt touching. She knows how dirty of a mare she is beneath your presence. You gently rub your fingers against her sex, earning more moans from her.\n\n");
	outputText("\"<i>Please, I need it! Just... do me already!</i>\" she moans, her body still trembling.\n\n");
	if (player.cocks.length == 1) {
		outputText("Smiling, you stop rubbing her and grab hold of your already erect [cock], pressing it against Nadia’s sex, her moaning at the mere touch of your cock.\n\n");
		outputText("You want her to keep begging, first, letting her know while you rub your cock against her sex, earning a whimper from Nadia.\n\n");
		outputText("\"<i>Please fuck me! I want to feel your cock inside me!</i>\" Nadia begs, trying to resist moving her body.\n\n");
		outputText("She needs to do better than that. You continue, slightly prodding you cock head against her lips.\n\n");
		outputText("\"<i>I want you to pound me! I want you to break me in and shape my pussy into the shape of your cock!! Fuck me and make me your mare!!</i>\" she screams, her face pained by the desire for your cock.\n\n");
		outputText("That's a good girl. You slowly plunge your entire dick into her, earning a surprised gasp from Nadia.\n\n");
		outputText("Your cock slips easily into Nadia’s soaked pussy, stretching her inner walls and earning a pained whine from Nadia as her virginity is finally taken away, tears forming in her eyes.\n\n");
		outputText("You slow down, making sure Nadia is ok before stopping your movement.\n\n");
		outputText("\"<i>I’m just... I’m just so happy,</i>\" Nadia says, trying to blink away the tears, \"<i>I feared this was another dream, but the pain feels so real, and I’m just so happy I’m able to be joined with you like this, I’m happy that you’ve taken my first time and I’ll treasure this pain forever.</i>\"\n\n");
		outputText("Smiling at Nadia’s cute and sweet words, you start to pull your cock out slowly, realizing you should probably make this more special for Nadia, and make it more tender and loving. As your cock slips out, Nadia makes cute but slightly pained moaning noises, obviously still tender from having her virginity taken. Once your cock is nearly out you thrust back in, as hard but gentle as possible, earning a happy moan from Nadia as your cock sinks back into her.\n\n");
		outputText("\"<i>You’re being so gentle...</i>\" Nadia moans, looking back at you, her eyes full of her love for you.\n\n");
		outputText("The least you can do is let her get used to it. You resume your slow thrusts into her, helping her pussy grow accustomed to your cock.\n\n");
		outputText("\"<i>Thank you, it feels really good...</i>\" Nadia moans again, her body shuddering as you gently fuck her, \"<i>You really are my perfect stallion.</i>\"\n\n");
		outputText("You wait for her lead before speeding up, smiling at your cute mare.\n\n");
		outputText("\"<i>Go... go faster. I'm ready, I want more of you... I need more,</i>\" Nadia moans, smiling back at you.\n\n");
		outputText("Smiling, you speed up, beginning to piston your hips and slamming your cock into her tight cunt, earning a scream from Nadia as her pussy is finally pounded by your [cock].\n\n");
		outputText("\"<i>Don't stop! It just feels so good!</i>\" Nadia moans, her body shaking as her insides are pounded, \"<i>Your cock feels so good inside me!! You’re gonna make me cum soon!!</i>\"\n\n");
		outputText("")
		outputText("True to her word she cums, screaming into the ground as her pussy tightens and convulses around your cock, as you continue to fuck her, making her scream and moan as you continue to pound her pussy through her orgasm.\n\n");
		outputText("\"<i>NOOOO! IT FEELS TOO GOOD!!! I’M GOING INSANE!!</i>\" Nadia screams, her body shaking in pleasure, her face in ecstasy.\n\n");
		outputText("Smirking, you start to savagely thrust into her, earning her loudest scream yet, prolonging her orgasm further and making her pussy tighten so much it nearly hurts, but you continue to thrust into her, pounding her cunt and you reshape it into your personal fuckhole. By the time her orgasm finishes, ");
		outputText("she collapses onto the ground, her backside only supported by your still thrusting cock and your hands. Smirking at your exhausted mare, you grab her by the shoulder and pull her up against your chest, your hips still pumping.\n\n");
		outputText("You make it known that she's not done until you're done. She shivers beneath your presence, knowing very well that she's at your complete and utter mercy.\n\n");
		outputText("Nadia whimpers, enjoying the harsh treatment, \"<i>Unload all your cum into me and make me pregnant with your foals! I’ll only be happy if you fuck me until you’re satisfied...</i>\"\n\n");
		outputText("Such a good mare is deserving of a reward. You move her head towards yours, kissing her on the lips, earning a surprised squeak from Nadia before sinking into your kiss, twisting her body around to wrap her arms around your head in a light hug, ");
		outputText("moaning into your mouth as you slam your cock into her. Eventually you break the kiss, Nadia looking at you like she is about to burst into tears.\n\n");
		outputText("\"<i>What should I do?</i>\" Nadia cries, tears forming in her eyes, \"<i>I’m so happy, it’s all like a dream and I fear at any moment I’ll wake up and you won’t be here with me.</i>\"\n\n");
		outputText("You hold onto her tightly, letting her know that you're not going anywhere. Kissing away some of her tears, you affectionately stroke her face as she melts into your embrace.\n\n");
		outputText("Nadia giggles for a second before moaning again, as her your cock continues to fuck her. You can feel yourself growing closer to an orgasm, and any second now you’ll shoot your seed into her, truly claiming her as your mare.\n\n");
		outputText("Your thrusts grow increasingly eager as pressure builds within your loins, nearing the brink of your orgasm.\n\n");
		outputText("\"<i>Please... cum in me. I can’t wait for you anymore!</i>\" Nadia begs, still hugging your head.\n\n");
		outputText("You grunt as you finally cum, ");
		if (player.cumQ() >= 2000) {
			outputText("earning a gasp from Nadia as you blast your cum into her womb like a hose, making her belly bulge and swell as you flood her pussy and womb with your thick baby batter. She giggles softly as her belly swells until she looks pregnant, showing that her womb is now well stuffed with your seed, which will soon hopefully spawn a foal in her.\n\n");
			outputText("\"<i>Hehe, it’ll be a miracle if I don’t end up pregnant with this much cum inside me,</i>\" Nadia giggles, rubbing her bloated belly, \"<i>I’m sure I’m pregnant now...</i>\"\n\n");
		}
		else {
			outputText("earning a happy moan from Nadia as she feels your hot seed filling her pussy, and entering her womb, where hopely it’ll pant itself into her and form the child Nadia really wants.\n\n");
			outputText("\"<i>Thank you, I just hope I end up pregnant,</i>\" Nadia says, smiling happily, \"<i>Since then this truly be the best day in my life...</i>\"\n\n");
		}
	}
	if (player.cocks.length > 1) {
		outputText("Smiling, you stop rubbing her and grab hold of two of your already erect [cocks], pressing them against Nadia’s sex, her moaning at the mere touch of your cocks.\n\n");
		outputText("You want her to keep begging first, letting her know, as you rub your cocks against her sex, earning a whimper from Nadia.\n\n");
		outputText("\"<i>Please fuck me! I want to feel your cocks inside me!</i>\" Nadia begs, trying to resist moving her body.\n\n");
		outputText("She needs to do better than that. You continue, moving one of the cocks against her arsehole, before slightly prodding you cock heads against both her holes.\n\n");
		outputText("\"<i>I want you to pound me! I want you break in my pussy and arse and shape them into the shape of your cocks!! Fuck me and make me your mare!!</i>\" she screams, her face pained by the desire for your cocks.\n\n");
		outputText("That's a good girl. Unceremoniously, you plunge both your dicks into her, earning a surprised gasp from Nadia.\n\n");
		outputText("Your cock slips easily into Nadia’s soaked pussy, the one in her arse having a bit more trouble but eventually slipping all the way in too, while the one in her pussy breaks through her hymen and earning a pained whine from Nadia as both virginities are finally taken away in one thrust, making tears forming in her eyes.\n\n");
		outputText("You slow down, making sure Nadia is ok before stopping your movement.\n\n");
		outputText("\"<i>I’m just... I’m just so happy,</i>\" Nadia says, trying to blink away the tears, \"<i>I feared this was another dream, but the pain feels so real, and just happy I’m able to be joined with you like this, I’m happy that you’ve taken both my first times at once and I’ll treasure this pain forever.</i>\"\n\n");
		outputText("Smiling at Nadia’s cute and sweet words, you start to pull your cocks out slowly, realizing you should probably make this more special for Nadia, and make it more tender and loving. As your cocks slip out, Nadia makes cute but slightly pained moaning noises, obviously still tender from having her virginities taken. Once your cocks are nearly out you thrust back in, as hard but gentle as possible, earning a happy moan from Nadia as your cocks sink back into her.\n\n");
		outputText("\"<i>You’re being so gentle...</i>\" Nadia moans, looking back at you, her eyes full of her love for you.\n\n");
		outputText("The least you can do is let her get used to it. You resume your slow thrusts into her, helping her holes grow accustomed to your girth.\n\n");
		outputText("\"<i>Thank you, it feels really good...</i>\" Nadia moans again, her body shuddering as you gently fuck her, \"<i>You really are my perfect stallion.</i>\"\n\n");
		outputText("You wait for her lead before speeding up, smiling at your cute mare.\n\n");
		outputText("\"<i>Go... go faster. I'm ready, I want more of you... I need more,</i>\" Nadia moans, smiling back at you.\n\n");
		outputText("Smiling, you speed up, beginning to piston your hips and slamming your cocks into her tight cunt and arse, earning a scream from Nadia as her pussy and butt are finally pounded by your [cocks].\n\n");
		outputText("\"<i>Don't stop! It just feels so good!</i>\" Nadia moans, her body shaking as her inside are pounded, \"<i>Your cocks feels so good inside me!! You’re gonna make me cum soon!!</i>\"\n\n");
		outputText("True to her word she cums, screaming into the ground as her pussy and arsehole tighten and convulse around your cock, while you continue to fuck her, making her scream and moan as you continue to pound her pussy and arse through her orgasm.\n\n");
		outputText("\"<i>NOOOO! IT FEELS TOO GOOD!!! I’M GOING INSANE!!</i>\" Nadia screams, her body shaking in pleasure, her face in ecstasy.\n\n");
		outputText("Smirking, you start to savagely thrust into her, earning her loudest scream yet, prolonging her orgasm further and making her pussy and asshole tighten so much it nearly hurts. Even as her grip on your cocks tightens, you continue to thrust into her, pounding her cunt and butt as you reshape them into your personal fuckholes. ");
		outputText("By the time her orgasm finishes, she has collapsed onto the ground, her backside only supported by your still thrusting cocks and hands. Smirking at your exhausted mare, you grab her by the shoulder and pull her up against your chest, your hips still pumping.\n\n");
		outputText("You make it known that she's not done until you're done. She shivers beneath your presence, knowing very well that she's at your complete and utter mercy.\n\n");
		outputText("\"<i>Please do,</i>\" Nadia whimpers, enjoying being treated like this, \"<i>Unload all your cum into me and make me pregnant with your foals! I’ll only be happy if you fuck me until you’re satisfied...</i>\"\n\n");
		outputText("Such a good mare is deserving of a reward. You move her head towards yours, kissing her on the lips, earning a surprised squeak from Nadia before sinking into your kiss, twisting her body around to wrap her arms around your head in a light hug, moaning into your mouth as you still piston into her. Eventually you break the kiss, Nadia looking at you like she is about to burst into tears.\n\n");
		outputText("\"<i>What should I do?</i>\" Nadia cries, tears forming in her eyes, \"<i>I’m so happy, it’s all like a dream and I fear at any moment I’ll wake up and you won’t be here with me.</i>\"\n\n");
		outputText("You hold onto her tightly, letting her know that you're not going anywhere. Kissing away some of her tears, you affectionately stroke her face as she melts into your embrace.\n\n");
		outputText("Nadia giggles for a second before moaning again, as you continue to fuck her. You can feel yourself growing closer to an orgasm, and any second now you’ll shoot your seed into her, truly claiming her as your mare.\n\n");
		outputText("Your thrusts grow increasingly eager as pressure builds within your loins, nearing the brink of your orgasm.\n\n");
		outputText("\"<i>Please... cum in me. I can’t wait for you anymore!</i>\" Nadia begs, still hugging your head.\n\n");
		outputText("You grunt as you finally cum, ");
		if (player.cumQ() >= 2000) {
			outputText("earning a gasp from Nadia, you blast your cum into her womb and guts like a hose, making her belly bulge and swell as you flood her womb and guts with your thick baby batter. She giggles softly as her belly swells until she looks very pregnant, showing that her guts and womb are now well stuffed with your seed.\n\n");
			outputText("\"<i>Hehe, it’ll be a miracle if I don’t end up pregnant with this much cum inside me,</i>\" Nadia giggles, rubbing her bloated belly, \"<i>Even my ass looks like it could pop out a baby...</i>\"\n\n");
		}
		else {
			outputText("earning a happy moan from Nadia as she feels your hot seed filling her holes. Your cock twitches, your baby batter pooling at her cervix and entering her womb. Nadia's pussy spasms, droplets of your spooge trickling down her legs. \n\n");
			outputText("\"<i>Thank you, I just hope I end up pregnant,</i>\" Nadia says, smiling happily, \"<i>That...Would make this just...perfect</i>\"\n\n");
		}
	}
	outputText("You're not done yet. Your cock" + (player.cocks.length == 1 ? "" : "s") + " still hard inside her. You give her a forceful thrust, letting her know that she's still not going anywhere as she reflexively winces softly in response.\n\n");
	outputText("Nadia smiles at you, planting a quick kiss on your mouth, \"<i>I guess I'm kinda happy that you're still going.</i>\"\n\n");
	outputText("Smirking, you get back to making love to her. Eventually you’re finally satisfied, and the two of you lie on the ground together, catching your breath. Nadia’s head rests on your chest, breathing heavily." + (player.cumQ() >= 2000 ? "You can feel her legs shifting, and she groans as your spooge leaks from her overfull pussy." : "") + "" + (player.cocks.length == 1 ? "" : "s") + ".\n\n");
	player.sexReward("vaginalFluids","Dick");
	NadiaPregChance();
	cleanupAfterCombat();
	doNext(breakingInYourMare2);
}
public function breakingInYourMare2():void {
	clearOutput();
	outputText("After resting a bit. You help your new mare clean up, teasing each other a little, and then help her gather up her stuff. The two of you head back to a small camp near the forest, where your new mare packs up her things.\n\n");
	outputText("After you make sure she has everything she needs, the two of you head back to your camp.\n\n");
	outputText("(<b>Nadia has been added to the Lovers menu!</b>)\n\n");
	if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard",1,+1);
	else player.createKeyItem("Radiant shard", 1,0,0,0);
	outputText("\n\n<b>Before fully settling in your camp, as if remembering something, Nadia pulls a shining shard from her inventory and hands it over to you as a gift. You acquired a Radiant shard!</b>");
	flags[kFLAGS.NADIA_FOLLOWER] = 6;
	explorer.stopExploring();
	doNext(playerMenu);
}

public function mainCampMenu():void {
	clearOutput();
	outputText("You go check on Nadia and find her reading a book on medicine. She looks up from her book, her face lighting up as you come near.\n\n");
	outputText("\"<i>Oh hello [name], did you need anything? If you are injured, I can...patch you up.</i>\" She gives you a smile, putting her book down.\n\n");
	menu();
	addButton(0, "Appearance", nadiaAppearance);
	//1 - Talk
	addButton(2, "Spar", nadiaSparsWithPC).hint("Ask Nadia for a mock battle.")
		.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
	if (sceneHunter.mockFights)
		addButton(3, "Mock Fight", mockFightDiana)
				.hint("Spice things up a little - make her fight for her pussy!")
				.disableIf(player.isGenderless(), "Not for genderless!");
	//3 - ??
	if (player.lust > 33) addButton(4, "Sex", mainSexMenu);
	else addButtonDisabled(4, "Sex", "Req. 33+ lust");
	if (player.HP < player.maxOverHP()) addButton(5, "Healing", HealingScene);
	else addButtonDisabled(5, "Healing", "You're fully healed already.");
	if ((player.statStore.hasBuff("Weakened") || player.statStore.hasBuff("Drained") || player.statStore.hasBuff("Damaged")) && flags[kFLAGS.NADIA_CURE_COOLDOWN] <= 0) {
		addButton(6, "C.C.(Base)", CuringCurseScene1).hint("Cure curses that affect stats non-multiplier bonuses.");
		addButton(7, "C.C.(Mult)", CuringCurseScene2).hint("Cure curses that affect stats multiplier bonsues.");
	}
	else if (flags[kFLAGS.NADIA_CURE_COOLDOWN] > 0) {
		addButtonDisabled(6, "C.C.(Base)", "Nadia is not yet ready to cure your curses again.");
		addButtonDisabled(7, "C.C.(Mult)", "Nadia is not yet ready to cure your curses again.");
	}
	else {
		addButtonDisabled(6, "C.C.(Base)", "You don't have any curses to cure. (non-multiplier)");
		addButtonDisabled(7, "C.C.(Mult)", "You don't have any curses to cure. (multiplier)");
	}
	addButton(8, "Uncurse", uncurseItemsMenu).disableIf(player.equippedKnownCursedItems().length == 0 && player.carriedKnownCursedItems().length == 0, "You don't have any cursed items");
	if (player.weaponRange == weaponsrange.SAGITTB) addButton(9, "Uncurse", uncurseItemsMenu2);
	if (BelisaFollower.BelisaQuestOn && !BelisaFollower.BelisaQuestComp) addButton(13, "ToothacheQ", BelisaNadiaTalk);
	addButton(14, "Back", camp.campLoversMenu);
}

public function mockFightDiana():void {
    mocking = true;
    nadiaSparsWithPC();
}

private function uncurseItemsMenu2():void {
	clearOutput();
	outputText("As Nadia proceed with the purification ritual you struggle in pain at first as you feel the cursed weapon in your hand resist the unbinding before release washes over you as your grip opens dropping the malevolent item on the ground. ");
	outputText("Nadia wrap the item in blessed cloth in order to seal its malice before handing you the neutralized cursed item back. Sure you can equip it again anytime but now you know the risks.\n\n");
	player.removeStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow);
	player.createStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow,1,0,0,0);
	if (player.statStore.hasBuff('Sagittarius Curse')) player.buff("Sagittarius Curse").remove();
	if (player.statStore.hasBuff('Sagittarius Focus')) player.buff("Sagittarius Focus").remove();
	player.unequipWeaponRange(false,true);
	inventory.takeItem(weaponsrange.SAGITTB, mainCampMenu);
}
public function uncurseCost(item:IDynamicItem, equipped:Boolean):int {
	var cost:int = 250 * (1 + item.rarity);
	if (equipped) cost *= 2;
	return cost;
}
public function uncurseItemsMenu():void {
	clearOutput();
	outputText("Uncurse which item?");
	var buttons:ButtonDataList = new ButtonDataList();
	var cost:int;
	for each (var slot:ItemSlotClass in player.carriedKnownCursedItems()) {
		cost = uncurseCost(slot.itype as IDynamicItem, false);
		buttons.add(slot.itype.shortName, curry(uncurseItem, slot))
				.hint("Lift the curse from "+slot.itype.longName+" ("+cost+" gems)")
				.disableIf(player.gems < cost, "Not enough gems ("+cost+")")
	}
	for each (var item:ItemType in player.equippedKnownCursedItems()) {
		cost = uncurseCost(item as IDynamicItem, true);
		buttons.add(item.shortName, curry(uncurseEquippedItem,item))
				.hint("Lift the curse from "+item.longName+" ("+cost+" gems)")
				.disableIf(player.gems < cost, "Not enough gems ("+cost+")")
	}
	submenu(buttons, mainCampMenu, 0, false);
}
public function uncurseItem(slot:ItemSlotClass):void {
	clearOutput();
	var newItem:ItemType = (slot.itype as IDynamicItem).uncursedCopy();
	outputText("The curse is lifted from "+slot.itype.longName);
	slot.setItemAndQty(newItem, slot.quantity);
	doNext(mainCampMenu);
}
public function uncurseEquippedItem(item:ItemType):void {
	clearOutput();
	var newItem:ItemType = (item as IDynamicItem).uncursedCopy();
	player.replaceEquipment(item as Equipable, newItem as Equipable);
	outputText("The curse is lifted from "+newItem.longName+". You can unequip it now.");
	doNext(mainCampMenu);
}

public function nadiaAppearance():void {
	clearOutput();
	outputText("Nadia is a 7-foot-tall Alicorn with long white hair. Her body is well-muscled, and covered with soft, white fur. Her green eyes look at you, wisdom in her gaze. She's currently looking at you curiously, one of her large herbology books in her hands.\n\n");
	outputText("Your eyes dip to her J cup breasts. You quickly look back up at her eyes, but if she noticed, she doesn't seem to care. Her legs, as with all horse morphs ends in hooves. Bound in iron, like the horseshoes back home, you know that those can be lethal weapons in a pinch. Her snow-white tail sits across her legs right now, strands of white hair covering her most intimate parts. You know Nadia protected her virginity up to becoming an Alicorn, though now since you are her stallion, she is before anything your girlfriend.\n\n");
	menu();
	addButton(14, "Back", mainCampMenu);
}

public function nadiaSparsWithPC():void {
	clearOutput();
	outputText("You ask Nadia to spar with you.\n\n");
	outputText("\"<i>You know I'm not a good fighter. I prefer to stay back and heal...</i>\" she complains, but seeing the look on your face, she shakes herself, putting her book down. She grabs her staff and adopts a fighting stance, ready for combat.");
	startCombat(new Nadia());
}
public function wonOverNadiaSpar():void {
	clearOutput();
	outputText("\"<i>I need get stronger if you're going to keep at this,</i>\" she mumbles under her breath.\n\n");
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
        if (flags[kFLAGS.NADIA_LVL_UP] < 15)
            flags[kFLAGS.NADIA_LVL_UP]++;
        if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2))
            player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, ((player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 8)+3));
		else
            player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, ((player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 8)+3));
	}
	cleanupAfterCombat();
}
public function lostToNadiaSpar():void {
	clearOutput();
	outputText("Nadia kicks you in the face, knocking you unconscious. When you wake up, you realise she seems never to change. Always finishing the fight with a kick, even during a friendly spar. You rub the knot of bruised [skin] where her hoof had landed. Hopefully she'll stop doing that...\n\n");
	cleanupAfterCombat();
}

public function HealingScene():void {
	clearOutput();
	outputText("You asked Nadia if she could tend to your injuries, and she perks up, rubbing her hands together. \"<i>Of course I can, but you need to let me see all of you.</i>\" You remove your clothing, and when you look back, she's looking up and down your body. Nadia gives you a reassuring smile, spreading her arms wide as if for a hug. You raise one eyebrow, but comply, allowing her to hold you against her wonderful body.\n\n");
	outputText("She then starts to move her hands across your body, rubbing sensually against your [skin], making you gasp as you feel a strong tingling feeling from her fingertips. Sparks of magic play across your [skin] as she leans in, arms rubbing your [hips]. You suspect she just wants some skinship, but her magic's still potent, washing away your pain and injuries.\n\n");
	outputText("Nadia starts to rub her chest against yours, causing more of the strange tingling as her soft mounds move against your [skin], your gasps soon turning into moans as her fingers move up your inner thigh, sparks of pleasure shooting up your spine as she runs her fingertips across your " + (player.hasCock() ? "" : "wo") + "manhood.\n\n");
	outputText("The sparks of magic intensify, becoming almost painful. You grimace, but she hushes you, soft touch on your body countering the pain. Soon enough, it's all over. Nadia lets go, stepping back. All your wounds and injuries have closed up, as if they never existed. You're healed, but now you feel rather aroused.\n\n");
	dynStats("lus", 33, "scale", false);
	if (player.hasStatusEffect(StatusEffects.CombatWounds)) player.removeStatusEffect(StatusEffects.CombatWounds);
	HPChange(player.maxOverHP(), true);
	EngineCore.changeFatigue( -(Math.round(player.maxFatigue() * 0.5)));
	doNext(mainCampMenu);
	advanceMinutes(45);
}

public function CuringCurseScene1():void {	//value related curses removal
	clearOutput();
	flags[kFLAGS.NADIA_CURE_COOLDOWN] = 2;
	outputText("You ask Nadia if she could remove the curses ailing you. \"<i>Curses are a bit harder, but I can do that. I need access to your whole body though.</i>\" You remove your clothing, and when you look back, she's looking up and down your body. Nadia gives you a reassuring smile, spreading her arms wide as if for a hug. You raise one eyebrow, but comply, allowing her to hold you against her wonderful body.\n\n");
	outputText("She then starts to move her hands across your body, rubbing sensually against your [skin], making you gasp as you feel a strong tingling feeling from her fingertips, washing away your curses.\n\n");
	outputText("Nadia gives you a wicked little smile, rubbing her chest against yours. Her magic flares, causing more of the strange, shocking sensation as her soft mounds move against your [skin], your gasps soon turning into moans as her fingers move from your hips to your groin, sparks of pleasure shooting up your spine as she caresses your " + (player.hasCock() ? "" : "wo") + "manhood.\n\n");
	outputText("The sparks of magic intensify, becoming almost painful. You grimace, but she hushes you, soft touch on your body countering the pain. Soon enough, it's all over. Nadia lets go, stepping back. Your curses have lessened, although now you feel rather aroused.\n\n");
	dynStats("lus", 50, "scale", false);
	for each (var stat:String in ["str","spe","tou","int","wis","lib","sens"]) {
		player.removeCurse(stat, 20,1);
		player.removeCurse(stat, 20,2);
		player.removeCurse(stat, 20,3);
	}
	doNext(mainCampMenu);
	advanceMinutes(15);
}
public function CuringCurseScene2():void {	//bonus multi related curses removal
	clearOutput();
	flags[kFLAGS.NADIA_CURE_COOLDOWN] = 2;
	outputText("You ask Nadia if she could cure your curses, and she nods. Nadia gestures you to come into her arms, which you do, allowing her to hold you against her wonderful body.\n\n");
	outputText("She then starts to move her hands across your body, rubbing sensually against your [skin], making you gasp as you feel a strong tingling feeling from her fingertips, washing away your curses.\n\n");
	outputText("Nadia starts to rub her chest against yours, causing more of the strange, shocking sensation as her soft mounds move against your [skin], your gasps soon turning into moans as her fingers move from your hips to your groin, sparks of pleasure shooting up your spine as she caresses your " + (player.hasCock() ? "" : "wo") + "manhood.\n\n");
	outputText("The sparks of magic intensify, becoming almost painful. You grimace, but she hushes you, soft touch on your body countering the pain. Soon enough, it's all over. Nadia lets go, stepping back. Your curses have lessened, although now you feel rather aroused.\n\n");
	dynStats("lus", 50, "scale", false);
	for each (var stat:String in ["str","spe","tou","int","wis","lib","sens"]) {
		if (stat != "sens")
		{
			player.removeCurse(stat+".mult", 0.20,1);
			player.removeCurse(stat+".mult", 0.20,2);
			player.removeCurse(stat+".mult", 0.20,3);
		}
	}
	doNext(mainCampMenu);
	advanceMinutes(30);
}

public function mainSexMenu():void {
	clearOutput();
	outputText("You ask your mare how she'd feel about spending some quality time with her ‘stallion’. Nadia's eyes widen, and her pure white cheeks flush red. One of her hooves taps the ground, and she seems to lose her breath for a moment.\n\n");
	outputText("\"<i>How would you want us to do it?</i>\"\n\n");
	menu();
	if (player.hasCock()) {
        //addButton(0, "Breeding", SexMenuBreeding);
        if (player.cockThatFits(36, "length") >= 0) addButton(1, "Vaginal", SexMenuVaginal);
        else addButtonDisabled(1, "Vaginal", "You're Too Big!");
        if (player.cockThatFits(36, "length") >= 0) addButton(2, "Anal", SexMenuAnal);
        else addButtonDisabled(2, "Anal", "You're Too Big!");
        if (player.cockThatFits(36, "length") >= 0 || player.findCockWithType(CockTypesEnum.TENTACLE, 1, -1, -1)) addButton(3, "Titfuck", SexMenuTitsfuck);
        else addButtonDisabled(3, "Titfuck", "You're Too Big!");
	}
	else {
		//addButtonDisabled(0, "Breeding", "Not for Dickless!");
		addButtonDisabled(1, "Vaginal", "Not for Dickless!");
		addButtonDisabled(2, "Anal", "Not for Dickless!");
		addButtonDisabled(3, "Titfuck", "Not for Dickless!");
	}
	addButton(14, "Back", mainCampMenu);
}

//unused method
/*
public function SexMenuBreeding():void {
	clearOutput();
	outputText("When it will be ready.\n\n");
	outputText("\"<i>Please hurry, I can’t wait!</i>\" Nadia begs you, still hugging your head.\n\n");
	player.sexReward("vaginalFluids","Dick");
	endEncounter();
}
*/

public function SexMenuVaginal():void {
	clearOutput();
	var x:int = player.cockThatFits(36, "length");/*
	if (player.isTaur()) outputText("\"<i>Please hurry, I can’t wait!</i>\" Nadia begs you, still hugging your head.\n\n");
	else {*/
		outputText("You order Nadia to get on all fours. She happily gets on all fours, looking back at you with excitement clearly written on her face. You get behind Nadia, moving her tail out-of-the-way while she tries to shake her rear enticingly. You place your hand on Nadia’s thick lower lips, earning a happy whimper as well as a slight shiver.\n\n");
		outputText("As soon as your hand runs across her lower lips you can already feel her growing dampness. You probably don’t even need to do much foreplay, since Nadia gets wet so easily, but your mare deserves the full treatment. You start rubbing against her sex, making her moan as your fingers press and move along her thick lower lips, giving her clit a little flick once they reach the top, sending a bolt of pleasure up Nadia’s spine and earning a gasp from her.\n\n");
		outputText("When you pull your fingers away, your fingers are covered in her sticky juices, you show them to Nadia, showing her how wet she is already. She moans softly, before taking the offered fingers in her mouth, licking and sucking them, cleaning them with her mouth, while with your other hand, you press a finger into her soaked cunt. She lets out a muffled moan through your fingers as your other fingers begin to thrust into her, causing more juices to spill down her legs.\n\n");
		outputText("Once you deemed her ready, you pull your finger out of her, earning a muffled whimper, maybe she was close. You also remove your fingers from her mouth, which are now covered in her saliva and offer her your other finger to clean, which she does, greedy licking and sucking off her own juices before you also remove it.\n\n");
		outputText("You get your " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "average") + " [cock] ready, which stands erect and aligning it up with her dripping sex. In trying to tempt you into coming in quicker, begins rubbing her hungry pussy against your hard rod, but you remain dominant, pulling back until she stops, which she soon does, letting out a pathetic whimpering noise. You know she's turned herself on further. \n\n");
		outputText("You stay still for a while, giving Nadia a moment to reflect on her mistakes, before slamming your cock into her as hard as you can. " + (player.cocks[x].cockLength >= 20 ? "Nadia doesn’t even have time to scream as your huge cock spreads her tight pussy as it spears both her pussy and womb, bulging out her belly in your shape, causing her to let out surprised gasp as her body shudders from the sudden orgasm you gave her" : "Nadia doesn’t even have time to scream as your cock spears into her pussy and slams against her womb") + ". ");
		outputText("You hit her with such force that her elbows buckle, pitching her forward. her face is now in the dirt, where you plan to keep it, as you start pounding her pussy with your " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "average") + " [cock], making her moan loudly into the ground as you force orgasm after orgasm on her.\n\n");
		outputText("You ask her what she thinks of your cock pounding her pussy, but all she can do is moan, a sluttish look on her face, with her eyes rolled up and her tongue hanging out of her mouth as your rub her face against the dirt with your powerful thrusts. You can feel her cunt tighten around your " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "average") + " [cock] with every thrust, " + (player.cocks[x].cockLength >= 25 ? "your [cockhead] slamming against her breasts through her belly, making her moan like a whore every time" : "your [cockhead] slamming against her womb") + ".\n\n");
		outputText("Although soon you feel your orgasm rising, a powerful building feeling in your cock" + (player.cocks.length == 1 ? "" : "s") + ". As you feel yourself about to cum, you pull out of her, placing your cock between her cheeks before blasting your " + (player.cumQ() >= 2000 ? "massive load all over Nadia’s rear, back and head, staining it all white" : "load over Nadia’s rear, staining it white") + ".\n\n");
		outputText("\"<i>Did you enjoy my pussy?</i>\" Nadia asks, giving you a tired and well fucked look, her body still with her arse in the air and her face in the ground.\n\n");
		outputText("\"<i>Wonderful as always,</i>\" you say, readjusting her clothes.\n\n");
		outputText("\"<i>Although the cum is wasted on my back, maybe next time put it all in the proper place?</i>\" Nadia says, gathering up some cum with one of her fingers and sucking it off.\n\n");
		outputText("\"<i>Only if you're a good mare next time,</i>\" you say with a smirk on your face.\n\n");
		outputText("Nadia pouts a bit before you both say your goodbyes, and then you head off.\n\n");
	//}
	NadiaPregChance();
	player.sexReward("vaginalFluids","Dick");
	endEncounter();
}
public function SexMenuAnal():void {
	clearOutput();
	var x:int = player.cockThatFits(36, "length");/*
	if (player.isTaur()) outputText("\"<i>Please hurry, I can’t wait!</i>\" Nadia begs you, still hugging your head.\n\n");
	else {*/
		outputText("You order Nadia to get on all fours. She happily gets on her hands and knees, looking back at you with excitement clearly written on her face. You get behind her, moving her tail aside before pulling apart her fat butt cheeks and revealing her puckered asshole.\n\n");
		outputText("You suck on one of your fingers, getting it nice and wet, before bringing it down and pushing it into her rear, making her let out a little happy moan as your finger surprisingly, or maybe not, easily slips in.\n\n");
		outputText("\"<i>Your fingers are in my butt!</i>\" Nadia moans, looking over her shoulder at you.\n\n");
		outputText("\"<i>Not yet,</i>\" you reply, before suddenly shoving another finger into her, making her gasp in surprise, \"<i>Now they are!</i>\"\n\n");
		outputText("Nadia moans loudly as your two fingers stretch open, rub, and thrust into her hot ass, loosening her up further. Although the finger fucking seems already too much for the alicorn, whose front arms have already folded. Her face falls to the ground, leaving her inviting ass stuck up into the air.\n\n");
		outputText("Seeing this, you bring your spare hand down on her thick asscheek, smacking it hard, making her moan and straighten up in surprise.\n\n");
		outputText("\"<i>Hey don’t go enjoying too much,</i>\" you say, your fingers stick playing with her hot hole.\n\n");
		outputText("\"<i>Sorry, but your fingers feel so good!</i>\" she moans, moving a hand down to her pussy, but you slap it away.\n\n");
		outputText("\"<i>None of that either,</i>\" you say, giving her arse another hard smack.\n\n");
		outputText("\"<i>Sorry!</i>\" Nadia moans happily, very much enjoying the rough treatment. Her body trembles, barely able to keep herself from collapsing. \n\n");
		outputText("Thinking that she is ready enough, even though you’re kind of curious how many fingers she can take, you remove your fingers. Nadia lets out a sad whimper at the absence of your fingers, although that quickly changes when she feels your " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "average") + " [cock] press against her rear. Wasting no time, and knowing that she is ready, you slam all your cock into her at once, ");
		outputText("earning you a loud scream of pleasure from Nadia, " + (player.cocks[x].cockLength >= 20 ? "as your cock stretches her tight little rear beyond normal" : "as your cock fills her tight little rear") + ", her eyes rolling back into her head and her face locked a sluttish grin as your cock begins to pound her arse hard " + (player.cocks[x].cockLength >= 20 ? "making her belly bulge out with your size" : "") + ".\n\n");
		outputText("She is barely able to support her upper body as she tries her best to straighten up, but every time your hips smash into her arse, your cock slamming deep inside her, she loses all strength and she is back on her elbows. Eventually she loses all strength whatsoever, and falls face first onto the ground, moaning happily.\n\n");
		outputText("\"<i>Naughty girl, told you stay up, didn’t I?</i>\" you playful chide her, making her moan in response.\n\n");
		outputText("\"<i>Sorry, please punish your naughty mare...</i>\" Nadia simpers, giving you a lust-filled smile.\n\n");
		outputText("Deciding to do just that, you pull out your cock until only the tip is inside her. A fearful look appears on Nadia’s face, thinking you’re actually going to punish her, but before she can think that long, you slam back into her as hard as possible, making her gasp in pleasure as her whole body shakes with the force" + (player.cocks[x].cockLength >= 20 ? ", her belly distorting in the shape of your cock" : "") + ".\n\n");
		outputText("It must have made her cum too, since now she is lying limp on the ground, her eyes rolled back and her tongue hanging out her mouth as her head lays in the dirt moaning in pleasure.\n\n");
		outputText("It almost made you cum too, and as you slam your length back in, you feel you won’t last long. With a final powerful and mighty thrust, making Nadia scream again as she cums, maybe for the fourth time, you cum, ");
		if (player.cumQ() >= 2000) {
			outputText("blasting her intestines with your thick spunk, filling up her guts before swelling her stomach with the load, bloating her until she looks pregnant, once you finished your load, you pull out of her, cum spraying out of her open arsehole, making Nadia moan loudly as she feels the cum being blasted back out of her guts, until it calms down and she rolls onto her side, panting.\n\n");
			outputText("\"<i>Thank you so much for properly punishing me,</i>\" she giggles, rubbing her well fucked and cum covered arsehole, \"<i>I don’t think I’ll be able to sit down for a while though. Please come back soon, otherwise my other hole will get lonely.</i>\"\n\n");
			outputText("After promising you will later, you head back to your adventure, while Nadia rests for a while.\n\n");
		}
		else {
			outputText("spraying her intestines with your thick spunk, before removing your cock with a wet sound. Some of your spooge follows, trickling from her now gaping asshole. \n\n");
			outputText("Nadia rolls onto her side, panting from exhaustion, before giving you a loving look.\n\n");
			outputText("\"<i>Thank you so much for properly punishing me,</i>\" she giggles, rubbing her well fucked arsehole, \"<i>I don’t think I’ll be able to sit down for a while though. Though please come back soon, otherwise my other hole will get lonely.</i>\"\n\n");
			outputText("After promising you will later, you head back to your adventure, while Nadia rests for a while.\n\n");
		}
	//}
	player.sexReward("no", "Dick");
	NadiaPregChance();
	endEncounter();
}
public function SexMenuTitsfuck():void {
	clearOutput();
	var x:int = player.cockThatFits(36, "length");
    var tentacock:int = player.cocks.length > 1 ? player.findCockWithType(CockTypesEnum.TENTACLE, 1, -1, -1) : -1;
    if (x == tentacock)
        tentacock = player.findCockWithType(CockTypesEnum.TENTACLE, 2, -1, -1);
	outputText("You request that Nadia give you a titjob.\n\n");
	outputText("\"<i>Of course my stallion, I would love to have your cock buried between my mounds,</i>\" Nadia says, smiling happily while eagerly pressing her tits together.\n\n");
	/*if (player.isTaur()) outputText("\"<i>Please hurry, I can’t wait!</i>\" Nadia begs you, still hugging your head.\n\n");
	else {*/
		if (tentacock >= 0) outputText("Nadia gets on her knees, while your vine cocks move out around her, the largest one moves in front of her.\n\n");
		else {
			outputText("You sit down on a nearby " + object() + " while Nadia gets on her knees in front of you, before undoing your [armor] and pulling out your erect " + (player.cocks.length == 1 ? "[cock]" : "[cocks]") + "");
			if (player.isNaga()) outputText("from your protective snake slit");
			if (player.isScylla()) outputText("out of from between your tentacles");
			outputText(".\n\n");
		}
		outputText("\"<i>My stallion is all ready I see,</i>\" Nadia says, smiling.\n\n");
		if (tentacock >= 0) outputText("Nadia moves forward slightly, allowing the " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "large") + " vine to sink between her mounds, your cock like vine’s lower shaft disappearing among the soft flesh.\n\n");
		else outputText("Nadia then presses her big breasts against your stomach, your [cock biggest] cock shaft slipping between her cleavage. You can’t help but out a little grunt of pleasure at the feelings of her soft flesh on your [skin].\n\n");
		outputText("\"<i>Do you like my breasts [name]? I’m so glad...</i>\" Nadia says staring endearingly at your cock, ");
		if (player.cocks[x].cockLength >= 25) outputText("which most of the monstrous length is laying across her head, making her shower the titanous member with her devotion in kisses and licks");
		else if (player.cocks[x].cockLength >= 15) outputText("which half is right in front of her face, so she gives a loving kiss");
		else outputText("which is sticking out of the middle of her cleavage");
		outputText(".\n\nNadia presses her large tits with her hands " + (player.cocks[x].cockLength >= 25 ? ". She begins to move her body gently up and down, her tits rubbing along your shaft in sync with her movements, earning another pleased grunt from you" : ", her breasts wrapping comfortably around your girth") + ".\n\n");
		outputText("\"<i>You cock is so hot between my breasts!</i>\" Nadia compliments, her eyes hot with lust.\n\n");
		outputText("You ask Nadia to speed up and she nods, speeding up her movements slightly, " + (tentacock >= 0 ? "your other cock vines wrapping around her body, holding her close while others rub against her body, seeking pleasure. You lean your head back and sigh in pleasure, basking in the wonderful titjob" : "her breasts slapping against your chest when they come down") + ".\n\n");
		if (tentacock >= 0) {
			outputText("Want more pleasure, another vine cock coils around her neck before finding her mouth, prodding at her mouth. She complies, happily allowing herself to take the [cock] cock in her mouth, letting it fill her. You make her take all of the cock she can without deepthroating her, holding her there as she sucks and licks it like it is the tastiest of treats, her breasts still bouncing up and down the shaft, drool now dripping on them from her mouth as she also thrusts her head.\n\n");
			outputText("Still wanting to feel more, your tentacles starts to move more, tightening their grip on her as they aggressively rub against her body, while the one in mouth and the one between start to thrust as well, the one in her mouth stopping short of deepthroating her.\n\n");
			outputText("Soon you fill the building pressure in your cock" + (tentacock >= 0 ? "" : "s") + ", threatening to burst out and spray your load inside her cock stuffed mouth. You groan, as you feel it coming, building up and up and up, until it comes!\n\n");
			outputText("You vines tightening again as if to stop Nadia escaping, which she has no such desire, before unleashing their loads. ");
			if (player.cumQ() >= 2000) {
				outputText("Each vine shooting out their load over whatever surface they can, covering her upper body in their hot cum as the vines spray their huge load all over her, her fur almost disappearing under all the cum thick, while the tentacle in her mouth unloads its huge payload down her throat, the vines around her neck bulging as they're making sure she takes it all, her belly swelling with the amount of cum you’ve forced in her. ");
				outputText("As your vines finish their discharge, they remove themselves from her body, her sucking in a deep breath of air as one removes itself from her mouth and neck, before gulping down any remains in her mouth and smiling.\n\n");
				outputText("\"<i>So much, my belly is now nice and full of your cum,</i>\" Nadia says, rubbing her swollen belly, \"<i>But you turned me into quite the mess, didn’t you? I don’t think I’ll ever be able to wash out the smell of your cum, not that I mind.</i>\"\n\n");
				outputText("\"<i>It suits you,</i>\" you say cheekily, giving her a playful kiss on the only non cum covered part of forehead.\n\n");
				outputText("\"<i>I’m glad you think it suits me,</i>\" Nadia laughs, licking off some of the cum off her arm, \"<i>But I better clean up, see me for some more fun later, my potent stallion.</i>\"\n\n");
				outputText("You nod and head off, while Nadia cleans herself up.\n\n");
			}
			else {
				outputText("Each vine shooting out their load over whatever surface they can, covering her in their hot cum, staining her fur with your mark, while the tentacle in her mouth unloads itself down her throat, the vines around her neck making sure she takes it all. As your vines finish their discharge, they remove themselves from her body, her sucking in a deep breath of air as one removes itself from her mouth and neck, before gulping down any remains in her mouth and smiling.\n\n");
				outputText("\"<i>You cum is as tasty as always, I could even go for a second helping,</i>\" Nadia says, cheerfully, \"<i>Although maybe after I clean myself up.</i>\"\n\n");
				outputText("\"<i>Maybe later, if you’re a good mare that is,</i>\" you says, giving one her cum covered tits a playful squeeze.\n\n");
				outputText("\"<i>Mmmm, I’ll look forward for it,</i>\" Nadia says, planting a kiss on your check.\n\n");
				outputText("You return the kiss, before heading off, you’ve got things to do.\n\n");
			}
		}
		else {
			outputText("Though your lover is blissed out, eyes glazed over with pleasure, but you're not satisfied yet. Grabbing her horn, " + (player.cocks[x].cockLength >= 15 ? "guide her up onto your cock’s head" : "guide her down onto your cock") + ".\n\n");
			outputText("Still wanting to feel more, you suddenly begin to move your hips slightly, surprising her as the cock slams into the depths of her mouth. Your hips slam into her cheeks, and she moans, sending vibrations down your shaft. Soon, you’re both moving, you thrust her your hips slightly, while she continues to move her body up and down your cock.\n\n");
			outputText("Soon you fill the building pressure in your cock" + (player.cocks.length == 1 ? "" : "s") + ", threatening to burst out and spray your load inside her vine stuffed mouth and her vine covered body. You groan, as you feel it coming, building up and up and up, until it comes!\n\n");
			outputText("You pull down on Nadia horn, surprising her as she suddenly as to take even more of your cock, but not as surprised as when you suddenly spray her mouth with cum. ");
			if (player.cumQ() >= 2000) {
				outputText("You cum so heavily that her cheeks bulge with the amount, and it happens so suddenly that some of it sprays out of her mouth onto her tits. Seeing the mess you're making, your force Nadia to take the rest of your cock, making her moan as it slips into her throat, allowing you to unload your massive load right down her throat, making her belly bulge as you fill her stomach with your thick stuff.\n\n");
				outputText("When you finally finish, you pull her off your cock, allowing her to take a deep breath, as cum leaks out onto her mouth and onto her breast as she pants.\n\n");
				outputText("\"<i>So much, my belly is now nice and full of your cum,</i>\" Nadia says, rubbing her swollen belly, \"<i>But you turned me into quite the mess, didn’t you?</i>\"\n\n");
				outputText("\"<i>It suits you,</i>\" you says, cheeky, giving her a playful kiss on the forehead.\n\n");
				outputText("\"<i>I’m glad you think it suits me,</i>\" Nadia laughs, licking off some of the cum off her breasts, \"<i>But I better clean up, see me for some more fun later, my potent stallion.</i>\"\n\n");
				outputText("You nod and head off, while Nadia cleans herself up.\n\n");
			}
			else {
				outputText("You fill her mouth with your thick juices, which she happily swallows, gulping down every last drop of it. After you finish cumming, you release her horn, allowing her to remove the cock from her mouth, though on the way up she sucks out the last of your cum from your dick.\n\n");
				outputText("\"<i>Your cum is as tasty as always, I could even go for a second helping,</i>\" Nadia says, smiling as she gulps down the last of the cum in her mouth.\n\n");
				outputText("\"<i>Maybe later, if you’re a good mare,</i>\" you says, giving one her tits a playful tease.\n\n");
				outputText("\"<i>Mmmm, I’ll look forward for it,</i>\" Nadia says, planting a kiss on your check.\n\n");
				outputText("You return the kiss, before heading off, you’ve got things to do.\n\n");
			}
		}
	//}
	player.sexReward("no", "Dick");
	endEncounter();
}

private function BelisaNadiaTalk():void {
	clearOutput();
	outputText("You decide to ask your resident Unicorn about healing cursed injuries, since she’s been able to cure such maladies in the past.\n\n");
	outputText("\"<i>Hmm…Perhaps. Maybe if you describe the injury, I can get a better sense of what I’m dealing with?</i>\" You describe the problem, and Nadia gives you an odd look. \"<i>One would need to have both a potent healing ability and curse removal, otherwise it would just come back. I have dealt with such injuries before…Demons sometimes use those kinds of things on people they can’t quite finish off.</i>\" Nadia seems genuinely saddened by Belisa’s plight. \"<i>You care about this person, don’t you?</i>\"\n\n");
	outputText("You nod, and she claps her hands together. \"<i>Well, what are we waiting for?</i>\" You give Nadia a surprised look, and she rolls her eyes, grabbing a bag. \"<i>No time like the present, is there, my Stallion? Lead me to the patient, please.</i>\"\n\n");
	outputText("You bring Nadia to the lake, and she slows, a small smile on her face. \"<i>Ah…I missed being able to stroll safely around here.</i>\" She follows as you walk over to the beach, looking down for Belisa’s silky bubble. You find it, and look around for a rock. Nadia watches you, confused, and you give your Unicorn a wink, tossing the rock down. Belisa looks up and sees you, and Nadia, still oblivious, gasps as your shy Drider friend pops her head up. ");
	outputText("Stunned by Belisa’s appearance, she sees the silky bubble rise a moment later, breaching the water like a whale.\n\n");
	outputText("Nadia’s eyes are like dinner plates. \"<i>Wait…She’s a…Drider and…What is that thing? Is it a giant egg?</i>\"\n\n");
	outputText("Belisa blinks. \"<i>A Unicorn?! You know a surviving Unicorn?!</i>\" She looks at you, a little annoyed. \"<i>...But you led her right to me.</i>\"\n\n");
	outputText("Holding out your hands, you assure Nadia that yes, this is the friend you told her about, with the cursed injury. You tell her that Belisa’s survived as long as she has by hiding in her silky bubble, which she can live mostly underwater in. You assure Belisa that Nadia is here to help her, and she’s cured curses before.\n\n");
	outputText("Belisa averts her gaze, cheeks red. \"<i>...Sorry I doubted you…I just…Wish you had warned me you were bringing someone.</i>\"\n\n");
	outputText("Nadia walks up to Belisa, slowly, and puts a hand on the shy woman’s shoulder. \"<i>Don’t worry, sweetheart. [Name] told me about your injury.</i>\" She looks back at you. \"<i>Do you want to take this inside? I’m sure it’ll be more comfortable.</i>\" Belisa nods, and the two women enter Belisa’s silky bubble. \"<i>Wait here please, my stallion.</i>\" Nadia calls back to you. \"<i>This should take a half-hour or so.</i>\"\n\n");
	outputText("You sit down, and Belisa’s home begins to sink beneath the waves.\n\n");
	outputText("Nearly an hour later, Belisa’s home bobs to the surface, and Nadia walks up onto the beach, a smile on her face. You ask her how it went, and she nods once.\n\n");
	outputText("\"<i>Your friend is going to be just fine. She’s going to be very sore in the mouth for a few days, but the curse is gone, and her fang has been regrown.</i>\" Nadia sighs. \"<i>Please take me back to camp, my stallion…That curse was quite draining on me. Whoever did it wasn’t skilled at all, but had a lot of power behind them.</i>\" You half-carry your mare back to camp, and she’s out cold once she hits her bed. You make a mental note to thank Nadia sometime soon.\n\n");
	BelisaFollower.BelisaQuestComp = true;
	endEncounter();
}
	public function NadiaPregAnnouncement():void {
		outputText("Your mare is waiting for you back at camp, with a smile on her face, nearly jumping from joy. Her eyes gleam as she sees you, and she nearly skips over, her J-cup breasts bouncing with each step. She breaks into a run, and you brace yourself as Nadia tackles you, Smothering you in her massive mammaries. \n\n");
		outputText("\"<i>Oh, my stallion, you wonderful, wonderful lover!</i>\" She gives you a big smack on the lips. You look at her, confused, then the penny drops. You bring a hand to her belly, and she nods, her horn glowing, and her eyes flashing with excitement. \n\n");
		outputText("\"<i>I’m pregnant</i>\", she says simply, cheeks red, and a huge grin on her face. \"<i>You’re going to be a father, [name].</i>\" She puts a hand on her stomach.  \n\n");
		outputText("You congratulate Nadia, knowing that this has been what she wanted for a long time. She cuddles you for a minute or so, before letting you go. You excuse yourself, going about your day…but you can feel Nadia’s eyes on your back as you go about your work around camp.  \n\n");
		outputText(" \n\n");
		doNext(playerMenu);
	}

	public function NadiaPreg1():void {
		outputText("Nadia’s stomach is noticeably larger than before, but barely. She pats her stomach occasionally, a huge, dopey smile on her face. You notice that she keeps a small bag of oats on her hip. She sees you looking, and gives you a smile.  \n\n");
		outputText(" \n\n");
		doNext(playerMenu);
	}

	public function NadiaPreg2():void {
		outputText("Nadia’s belly hasn’t grown much more, but she’s moving slower than before. Occasionally, you can see her wince, and she seems to rub her pregnant belly more than usual.\n\n");
		doNext(playerMenu);
	}

	public function NadiaPreg3():void {
		outputText("Nadia’s stomach is distended, and it’s clear to anyone with eyes that she’s heavily pregnant. You notice her stomach jerk, getting a startled cry from Nadia. Rushing over, you ask her if she’s alright, and your unicorn lover sighs. \"<i>I’ll be fine…But your kid is kicking hard, my stallion.</i>\" She guides your hand to her belly, and you can feel a sudden impact. Nadia groans, and you gently rub her stomach, trying to ease her pain a little. Before long, the kicks subside, and she leans into you.  \n\n");
		outputText("\"<i>Thank you for that.</i>\" She whispers, all but falling asleep on you. You help her over to her bed, and she sighs, lying down.  \n\n");
		doNext(playerMenu);
	}

	public function NadiaGivesBirth():void {
		outputText("You hear a choking cry from Nadia’s part of camp, and you rush over, seeing your unicorn lover, doubled over, with a small pool of clear fluid at her hooved feet.  \n\n");
		outputText("\"<i>O-oh, [name]!</i>\" Nadia cries, reaching a hand out to you. You run over, catching her before she loses her balance entirely. \"<i>T-the baby’s coming!</i>\"  \n\n");
		outputText("You tell her that you kind of guessed that, and she grits her teeth, grunting as a contraction hits. \"<i>Sm-smartass.</i>\" She grunts, and points to her bedroll. \"<i>Lay me down there, please.</i>\"  \n\n");
		outputText("You half-drag, half-carry Nadia over to her bedroll, and as she groans, you grab a towel, gently spreading your unicorn lover’s legs. Nadia covers herself with her tail, but you gently take it, pushing it out of your way. \n\n");
		outputText("\"<i>S-sorry…Force of habit.</i>\" Nadia grunts. You shake your head slightly, telling her not to worry. Just focus on the birth. She whinneys as a contraction hits, and you position yourself between Nadia’s legs, ready to receive your newborn foal.  \n\n");
		outputText("It takes about a half hour before you can see a head, crowning. Nadia gasps in pain as the horn passes through, and you take her hand, telling her to breathe. Slowly, Nadia pushes, and you take the newborn Unicorn into your arms. \n\n");
		switch (rand(3)) {
			case 0:
				outputText("It's a boy, and as he looks into your eyes, he stares, horn glowing ever so slightly. He coughs, taking in his first breath, and you sigh happily, swaddling your boy. \n\n");
				NadiaTotalKidsNum += 1;
				NadiaSonsNum += 1;
				break;
			case 1:
				// 25% chance
				outputText("It's a little girl. She opens her eyes, then quickly closes them again, burbling. She inhales deeply, then begins to cry loudly. You rock her, wrapping her up, and she turns her head, trying to put something between her eyes and the light. \n\n");
				NadiaTotalKidsNum += 1;
				NadiaDaughtersNum += 1;
				break;
			case 2:
				outputText("You notice that your newborn Unicorn is a hermaphrodite, with both male and female genitals. You swaddle them in cloth, and they look around curiously, their eyes wandering. You hold their head, and they look at you curiously, before breaking out into an innocent smile. \n\n");
				NadiaHermKidsNum +=1;
				NadiaTotalKidsNum += 1;
		}
		outputText("Nadia’s barely conscious, but she holds her arms out for them, bringing your newborn to her sizable bosom to feed. You stay with Nadia and the baby for another hour, just to make sure they’re both alright, before excusing yourself.  \n\n");

		doNext(playerMenu);
	}

	}
}