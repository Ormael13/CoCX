/**
 * ...
 * @author Ormael, written by Dragon Hearts/Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class DianaFollower extends NPCAwareContent
	{
		
		public function DianaFollower() 
		{}

public function dianaAffection(changes:Number = 0):Number {
	flags[kFLAGS.DIANA_AFFECTION] += changes;
	if (flags[kFLAGS.DIANA_AFFECTION] > 100) flags[kFLAGS.DIANA_AFFECTION] = 100;
	return flags[kFLAGS.DIANA_AFFECTION];
}
//0-10 affection - Horse-morph; 10-100 affection - Unicorn; 100 affection - Alicorn
public function repeatLakeEnc():void {
	clearOutput();
	outputText("As you explore the lake area, you run into ");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8) outputText("Diana");
	else if (flags[kFLAGS.DIANA_LVL_UP] >= 2) outputText("an unicorn");
	else outputText("a white furred horse morph");
	outputText(".\n\nAt first she doesn’t notice you, she’s to busy examining a flower. You walk to her to greet her, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled expression and grabs her staff to defend herself, lunging for a set of preemptive strikes as she begins to attack you.\n\n");
	outputText("\"<i>Eeeeep! Go away, you fiend! ");
	if (flags[kFLAGS.DIANA_FOLLOWER] > 0) outputText("You stained my soul enough as It is I don’t want any more your corruption");
	else outputText("I’m not handing over my virginity to you");
	outputText("!!!!!</i>\"\n\nWell seems you got a fight on your hands.\n\n");
	outputText("You are under attack by a");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8) outputText("n alicorn!");
	else if (flags[kFLAGS.DIANA_LVL_UP] >= 2) outputText("n unicorn!");
	else outputText(" horse morph!");
	startCombat(new Diana());
	doNext(playerMenu);
}
public function repeatPlainsEnc():void {
	clearOutput();
	outputText("As you explore the plains area, you run into ");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8) outputText("Diana");
	else outputText("an unicorn");
	outputText(".\n\nAt first she doesn’t notice you, she’s to busy examining a flower. You walk to her to greet her, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled expression and grabs her staff to defend herself, lunging for a set of preemptive strikes as she begins to attack you.\n\n");
	outputText("\"<i>Eeeeep! Go away, you fiend! ");
	if (flags[kFLAGS.DIANA_FOLLOWER] > 0) outputText("You stained my soul enough as It is I don’t want any more your corruption");
	else outputText("I’m not handing over my virginity to you");
	outputText("!!!!!</i>\"\n\nWell seems you got a fight on your hands.\n\n");
	outputText("You are under attack by a");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8) outputText("n alicorn!");
	else outputText("n unicorn!");
	startCombat(new Diana());
	doNext(playerMenu);
}
public function repeatBattlefieldEnc():void {
	clearOutput();
	outputText("As you explore the outer battlefield area, you run into ");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8) outputText("Diana");
	else outputText("an unicorn");
	outputText(".\n\nAt first she doesn’t notice you, she’s to busy examining a flower. You walk to her to greet her, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled expression and grabs her staff to defend herself, lunging for a set of preemptive strikes as she begins to attack you.\n\n");
	outputText("\"<i>Eeeeep! Go away, you fiend! ");
	if (flags[kFLAGS.DIANA_FOLLOWER] > 0) outputText("You stained my soul enough as It is I don’t want any more your corruption");
	else outputText("I’m not handing over my virginity to you");
	outputText("!!!!!</i>\"\n\nWell seems you got a fight on your hands.\n\n");
	outputText("You are under attack by a");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8) outputText("n alicorn!");
	else outputText("n unicorn!");
	startCombat(new Diana());
	doNext(playerMenu);
}
public function postNameForestEnc():void {
	clearOutput();
	outputText("As you explore the forest area, you run into Diana.\n\n");
	outputText("At first she doesn’t notice you, to busy examining a flower. You walk to her to say hi, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled  expression and grabs her staff to defend herself, but relax as she realise it’s you.\n\n");
	outputText("\"<i>Oh hello [name]! I didn’t expect you. Say while you happen to be there I’m in need of a sparring partner would you mind having a friendly fight with me?</i>\"\n\n");
}
public function postNameForestEncSure():void {
	outputText("Well why not? You could use a warmup yourself.\n\n");
	outputText("\"<i>Thank you [name], chances to improve myself are rare in these lands and I need all the training I can get to reach my goal and dreams.</i>\"\n\n");
	outputText("She grabs her staff and adopt a fighting stance, ready for combat.\n\n");
	outputText("You are fighting Diana!");
	startCombat(new Diana());
	doNext(playerMenu);
}
public function postNameForestEncNotNow():void {
	outputText("You don’t have time for sparring right now but may later. Diana nod to that as you head out back to camp.\n\n");
	doNext(camp.returnToCampUseOneHour);
}

public function wonOverDiana():void {
	clearOutput();
	outputText("The horse morph kneels down defeated. Seems you can do whatever you want with her now. So, what will it be?\n\n");
	menu();
	levelingHerself();
	if (player.lust >= 33) addButton(1, "Rape", wonOverDianaSex);
	addButton(0, "Spare", wonOverDianaSpare);
}
public function wonOverDianaSex():void {
	menu();
	if (player.hasVagina()) addButton(0, "Oral (F)", wonOverDianaOralF);
	if (player.hasCock()) {
		addButton(1, "Oral (M)", wonOverDianaOralM);
		addButton(2, "Rape", wonOverDianaRape);
	}
	addButton(3, "Back", wonOverDiana);
}
public function wonOverDianaOralF():void {
	clearOutput();
	if (player.isBiped()) {
		outputText("You look over the defeated equine, as she lies panting on the ground. Getting an idea you remove your armour, and walk over her until your [pussy] is over the equine’s head. She looks up at you");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText(", hungrily licking her lips");
		else outputText(" nervously");
		outputText(". Smirking you drop to you knees, making sure to pin her arms under your legs, before moving your pussy directly in front of her face.\n\n");
	}
	if (player.isTaur()) {
		outputText("You look over the defeated equine, as she lies panting on the ground. Getting an idea you remove your armour, and trotting over her body, moving the back of your centaur body over her head, so she can see your [pussy]");
		if (player.tailCount > 0) outputText(" behind your [tail]");
		outputText(". She looks up at you");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText(", hungrily licking her lips");
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
	if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) {
		outputText("She doesn’t even need to be told, since as soon as she could reach it she is licking your pussy and sticking her tongue into it, hungry for your sweet honey.\n\n");
	}
	else {
		outputText("The equine struggles, trying to escape. Annoyed you ");
		if (player.isBiped()) outputText("start cruelly twisting her mane, making her whimper in pain, telling her you won’t stop until she starts to see");
		if (player.isTaur()) outputText("start sitting harder on her, painfully squishing her face and making it nearly impossible to breath, and you tell her you won’t stop until she sees");
		if (player.isNaga() || player.isScylla()) {
			outputText("start squeezing her with your ");
			if (player.isNaga()) outputText("tail");
			else outputText("tentacles");
			outputText(" until she can’t breath, she gasps, trying to suck air into her crushed lungs, you tell her you'll loosen your grip once she starts to see");
		}
		outputText(" the wisdom in licking you. She starts to quickly lick your pussy, trying to please you to stop your punishment, which you do.\n\n");
	}
	outputText("You moan happily as her large equine tongue eats your cunt out, you move your hands up to your breasts, grabbing and squeezing them under your hands while your fingers sink into your soft flesh. You moan and pinch your stiff nipples as she licks your pussy, you continuing to pleasure your breasts, helping the equine bring you to an orgasm, which you feel building.");
	outputText(" Eventually it comes, and you moan loudly as you orgasm, spraying your girl juices over the equines face, soaking it and making her have to drink them.\n\n");
	if (player.isBiped() || player.isTaur()) {
		outputText("Satisfied you climb off the equine, and look down at her at her. She is lying on the ground panting again, but this time her face is soaked by your pussy’s juices");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText(", which she eagerly licks off her face");
		outputText(". Smirking, you redress and head off, finally leaving the equine to catch her breath.\n\n");
	}
	if (player.isNaga() || player.isScylla()) {
		outputText("Satisfied, you release the equine from your ");
		if (player.isNaga()) outputText("tail");
		else outputText("tentacles");
		outputText(", letting her slip to the ground panting, her face soaked with your girl cum");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText(", which she eagerly licks off her face");
		outputText(". Smirking you redress and head off, finally leaving the equine to catch her breath.\n\n");
	}
	if (flags[kFLAGS.DIANA_FOLLOWER] < 2) flags[kFLAGS.DIANA_FOLLOWER]++;
	player.sexReward("vaginalFluids");
	cleanupAfterCombat();
}
public function wonOverDianaOralM():void {
	clearOutput();
	var x:int = player.cockThatFits(36, "length");
	if (player.isBiped()) {
		outputText("You walk towards your defeated equine foe who lies panting on the ground, trying to regain her breath. As you stand over her the sight of her panting lips gives you an idea of how to blow off some steam. You part your groin armour, pulling out your [cocks] [dickplural].");
		if (player.hasVagina() && flags[kFLAGS.DIANA_FOLLOWER] == 0) outputText(" Shocking the equine to find out you're actually a hermaphrodite.");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText(" The equine licks her lips eagerly at the sight of your [cockplural].");
		outputText("\n\nYou step over her, standing above her torso while she watches you with ");
		if (flags[kFLAGS.DIANA_FOLLOWER] == 0) outputText("nervous anticipation, unsure what you’re doing.");
		else if (flags[kFLAGS.DIANA_FOLLOWER] == 1) outputText("dreaded anticipation, knowing what is coming next.");
		else outputText("eager anticipation, looking at you with a come hither look.");
		outputText("\n\nSmirking, you grab hold of your already hardening [cock] ");
		if (player.cockTotal() > 1) outputText("from your bunch of [cocks]");
		outputText(", before reaching down and yanking her head up by her mane. Making her ");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText("squeal happily, already eager to suck your cock");
		else outputText("whimper in pain");
		outputText(", as you slap your [cockplural] against her cheek.\n\n");
	}
	if (player.isTaur()) {
		outputText("You trot over to your defeated equine foe as she lays on the ground panting and trying to regain her breath, her panting lips giving you an idea of how to blow off some steam. You walk over her, showing off your semi erect [cocks] [dickplural] that hang between your hind legs.");
		if (player.hasVagina() && flags[kFLAGS.DIANA_FOLLOWER] == 0) outputText(" Shocking the equine to find out you're actually a hermaphrodite.");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText(" The equine licks her lips eagerly at the sight of your [cockplural].");
		outputText("\n\nYou reach down and grab her by the shoulders before dragging her to a nearby " + object() + ","); 
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText("the equine happily letting herself get manhandled while you prop her against a " + object() + "");
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
		outputText(" and pull out your [cocks] [dickplural].");
		if (player.hasVagina() && flags[kFLAGS.DIANA_FOLLOWER] == 0) outputText(" Shocking the equine to find out you're actually a hermaphrodite.");
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) outputText(" The equine licks her lips eagerly at the sight of your [cockplural].");
		outputText("\n\nYou wrap your dexterous ");
		if (player.isNaga()) outputText("naga tail");
		else outputText("scylla tentacles");
		outputText(" tightly around her waist, lifting her off the ground and into the air."); 
		if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) {
			outputText("She gives you a sultry look as she runs her hands lovely along your ");
			if (player.isNaga()) outputText("tail");
			else outputText("tentacles");
			outputText(", before giving you a come hither look.");
		}
		else {
			outputText("She struggles, trying to escape from your ");
			if (player.isNaga()) outputText("tail");
			else outputText("tentacles");
			outputText(" but soon giving up when she sees it’s impossible.");
		}
		outputText(" Smirking, you move her head against your torso, slapping your [cockplural] against her cheek.\n\n");
	}
	//if (player.isAlraune())
	outputText("\"<i>Suck it,</i>\" you order.\n\n");
	if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) {
		outputText("You don’t really even have to tell her, she’s already practically drooling. She quickly grabs your ");
		if (player.cockTotal() > 1) outputText("largest ");
		outputText("cock, before lovingly running her tongue down your shaft as well as planting some loving kisses across it, showering it with her devotion. She eventually moves her mouth back up the length, reaching the head and planting another loving kiss on it.\n\n");
		outputText("Pleased you start pushing your ");
		if (player.cockTotal() > 1) outputText("largest ");
		outputText("[cock] into her eager mouth, ");
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
		if (flags[kFLAGS.DIANA_FOLLOWER] == 0) outputText("disgusted by the thought of serving you, ");
		else outputText("not wanting to serve you again, ");
		outputText(" keeping her mouth shut tight. ");
		if (player.isBiped()) outputText("Irritated, you twist her mane causing her to whimper, you repeat this until she gives in and parts her lips.");
		if (player.isTaur()) outputText("Irritated, you wack her head with one of your hind [feet] making her yelp, you keep doing this until she give in and opens her mouth.");
		if (player.isNaga() || player.isScylla()) {
			outputText("Irritated, you squeeze her very tightly with your ");
			if (player.isNaga()) outputText("tail");
			else outputText("tentacles");
			outputText(", making her gasp, you keep doing this until she gives up and parts her lips.");
		}
		outputText("\n\n.Satisfied you start pushing your ");
		if (player.cockTotal() > 1) outputText("largest ");
		outputText(" [cock] into her now open mouth, ");
		if (player.cocks[x].cockLength >= 15) outputText("forcing your massive dick into her mouth, only stopping short of deepthroating her, her mouth being forced nearly painfully wide to hold your massive girth, while her eyes look fearfully at how much is left to go");
		else if (player.cocks[x].cockLength >= 9) outputText("forcing your large member into her mouth, stopping short of deepthroating her. She casts a worried gaze at how much of your dick is left out of her mouth");
		else if (player.cocks[x].cockLength >= 5) outputText("making her take your near entire length until her mouth is full of your cock");
		else outputText("her mouth easily taking your small member");
		outputText(". You savor the feeling of her hot mouth around your member.\n\n");
		outputText("You start thrusting your hips, causing her to let out a muffled moan as her mouth is raped by your length, causing her to grab hold of your hips trying to control your thrusts, but she can’t. ");
		if (player.cocks[x].cockLength >= 15) outputText("Smirking, you start forcing your entire length in, making her eyes bulge and water as your massive member pushes its way into her throat and all the way down into her stomach, her neck bulging with the shape of your cock. You start thrusting your hips again, fucking her entire throat and stomach while enjoying every second of it, her watering eyes rolling back as her hands fall limply to her side, unable to bear it all");
		else if (player.cocks[x].cockLength >= 9) outputText("Smirking, you start pushing your entire length in, her eyes widening as your cock slips down her throat, not giving her enough time to gag. You begin deepthroating her, letting your length rape nearly her entire throat, while you enjoy the feeling of her throat as she moans and whimpers");
		else if (player.cocks[x].cockLength >= 5) outputText("Smirking, you start pushing the rest of your cock into her mouth, her eyes widen as your cock slips into her throat nearly causing her gag. You begin throat fucking her, letting your cock ravage the top of her throat while you enjoy the feeling of her tight neck around your cock head, as she lets out loud muffled moans");
		else outputText("While you thrust your hips you order her to suck on your dick, which she does, sucking as hard as she can while you thrust into her mouth, you enjoying the feeling");
	}
	outputText(".\n\nYou continue to fuck her face for a good while, enjoying her mouth as much as you can, before you start to feel the coming onslaught of an orgasm, making you speed up your thrusts while she moans as her face is smacked against your [hips] repeatedly, which speeds up the orgasm.");
	if (flags[kFLAGS.DIANA_FOLLOWER] >= 2 && player.cockTotal() > 1) outputText(" Seeing you’re about to cum, she points your other [dickplural] at her, so you’ll cum on her.");
	outputText("\n\n");
	if (flags[kFLAGS.DIANA_FOLLOWER] >= 2) {
		if (player.cumQ() >= 2000) {
			if (player.cocks[x].cockLength >= 15) outputText("You make sure she is taking your entire length before you cum, spraying your massive load directly into her stomach with such force that her stomach bulges, making it swell and bloat with you cum. She moans happily as her belly swells until she looks pregnant, her face totally blissed out");
			else if (player.cocks[x].cockLength >= 5) outputText("You make sure she is taking your entire length before you cum, spraying your massive load right down her throat, she moans happily as her belly visibly swells with your cum, bloating her until she looks pregnant, her face totally blissed out");
			else outputText("You hold your hips against her face as you cum, spraying your massive load inside her mouth making her cheeks bulge with your cum, she does her best to swallow as fast as she can but your load is too large and thick, and it starts squirting out of her nose and mouth, her face totally blissed out");
			if (player.cockTotal() > 1) outputText(" while your other [cockplural] covers her naked body in cum");
			outputText(".");
		}
		else {
			if (player.cocks[x].cockLength >= 15) outputText("You make sure she is taking your entire length before you cum, spraying your load directly into her stomach");
			else if (player.cocks[x].cockLength >= 5) outputText("You make sure she is taking your entire length before you cum, spraying your load right down her throat");
			else outputText("You force your hips against her face as you cum, spraying your load inside her mouth, making sure she swallows it");
			if (player.cockTotal() > 1) outputText(" while your other [cockplural] spray it’s load on her face and body");
			outputText(".");
		}
		outputText("\n\nEventually your orgasm finishes and you pull your [cock] out of her mouth, while she continues sucking on it as it comes out to remove the last of the cum from it. After she finishes she looks up at you with a satisfied cum stained smile that sort of mirrored you own. You help her stand up, and you two part.");
		if (player.cumQ() >= 2000) outputText(" Her walk slightly troubled by how bloated her belly is.");
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
		outputText("\n\nEventually your orgasm finishes and you pull your [cock] out of her mouth, ");
		if (player.isBiped() || player.isNaga()) outputText("as well as release her from your grip, ");
		outputText("letting her sink to the ground where she sits panting with her belly ");
		if (player.cumQ() >= 2000) outputText("bloated with your cum");
		else outputText("full of your cum");
		outputText(". You redress before heading off, leaving behind the equine.");
	}
	if (flags[kFLAGS.DIANA_FOLLOWER] < 2) flags[kFLAGS.DIANA_FOLLOWER]++;
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
	if ((flags[kFLAGS.DIANA_LVL_UP] >= 1 && flags[kFLAGS.DIANA_FOLLOWER] == 3) || (flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_FOLLOWER] == 4))
		return false;
	return true;
}
public function wonOverDianaRape():void {
	clearOutput();
	var x:int = player.cockThatFits(36, "length");
	if (player.isBiped()) {
		outputText("You look over the defeated equine as she lays sprawled across the ground. Her legs are slightly parted, so her pussy catches your eye" + (virginity() ? ", looking untouched or used" : "again") + ". Licking your lips, you start undressing as the equine watches you, worry clear in her eyes" + (player.gender == 3 ? ", her worry only increasing when she sees that you're a hermaphrodite" : "") + ". You walk beside her and push her onto her stomach, ");
		outputText("before grabbing both her hands and forcing them behind her back, she struggles getting what you’re about to do, but you hold her firm and " + (player.cocks.length == 1 ? "grab you're already hardening [cock]" : "grab your already hardening [cockFit 36] from among your bunch of [cocks] cocks") + ".\n\n");
		if (virginity()) {
			outputText("\"<i>NO WAIT, I'm saving my first time for my stallion!</i>\" she whimpers, trying to pull her hands free.\n\n");
			outputText("\"<i>Too bad, you should’ve been more careful. Cause now I’m horny!</i>\" you say, while forcing her arse up into the air, giving you better access to her cunt.\n\n");
			outputText("\"<i>Noo!</i>\" she whimpers, as you place your cock against her virgin cunt, grinding against it to make it wet.\n\n");
		}
		else {
			outputText("\"<i>No, not again!</i>\" she groans, not even bothering to struggle this time and letting herself get manhandled into position, with her arse stuck up into the air.\n\n");
			outputText("\"<i>Well you shouldn’t keep fighting me if you don’t want to end up like this,</i>\" you say, placing your cock against her already wettening cunt.\n\n");
		}
		outputText("Once she feels wet enough you plunge your entire [cock] dick in at once, " + (virginity() ? "making her scream as her virginity is cruelly taken away by you in one stroke" : "making her moan loudly as her pussy is once against filled by your cock") + ". Once she quiets down, you start thrusting your hips, " + (virginity() ? "ignoring her whimpering and enjoying her tight virgin pussy" : "enjoying the tight pussy that you broke in") + ". ");
		outputText("Soon she " + (virginity() ? "stops whimpering and" : "once again") + " starts moaning as you continue to fuck her cunt, encouraging you to thrust harder and making her moan louder.\n\n");
		outputText("You let go of her hands, moving your hands to her hips so you can thrust deeper into her, since she has given up trying to escape. Once you’ve gotten a good rhythm you reach forward and tilt her head up, so you can see her face. She has a whorish expression on her face, her eyes are rolled back while her tongue hangs out of her open mouth.\n\n");
		outputText("\"<i>What a slutty look you have on your face,</i>\" you note, as your hips hammer her cunt, \"<i>" + (virginity() ? "I bet you actually wanted to lose your virginity!?" : "Despite your struggling, you actually like being fucked by me?!") + "</i>\"\n\n");
		outputText("\"<i>Noooo...</i>\" she moans, her pussy tightening.\n\n");
		outputText("You reach around her chest and grabs hold of her tits, squeezing them hard and earning a loud moan from her. You move your fingers to her nipples, where you twist and tug them, making her scream in pleasure and pain, her pussy tightening as a result. You feel that you're going to cum soon.\n\n");
		outputText("\"<i>Going to cum!</i>\" you say, warning her.\n\n");
		outputText("\"<i>NO! Don’t cum inside meeee!</i>\" she moans, panicking, \"<i>I don’t want to get pregnant!</i>\"\n\n");
		outputText("Grunting, you thrust even harder and pinch her nipples hard, making her pussy tighten further and her scream in masochistic pleasure, and just when you are about to cum you pull out, spraying your load across her back and covering it with your cum. Panting, you get dressed, and leave the well fucked mare, to lay there with her arse sticking up into the air.\n\n");
		outputText("You hope she can get up before a imp finds her.\n\n");
	}
	if (player.isScylla()) {
		outputText("You look over the defeated equine as she is sprawled across the ground, wondering what you’ll do to her you wrap your tentacles around her hands before dragging her into the air, making her hang in front of you. She struggles but your strong tentacles holds her hands trapped.\n\n");
		outputText("\"<i>Mmmm, what should I do with you,</i>\" you ask, running your hands down her body, until your hands reach her pussy.\n\n");
		if (virginity()) {
			outputText("\"<i>Don’t touch me there!</i>\" she yells, trying to escape, \"<i>Going to cum!</i>\" you say, warning her.\n\n");
			outputText("\"<i>Oh really?</i>\" you say, while slipping one of your fingers into her unprotected pussy, where you find out to your surprise that she is a virgin. \"<i>How surprising,</i>\" you note, pulling out your [cock] from out between your tentacles, it’s already erect in anticipation.\n\n");
		}
		else {
			outputText("\"<i>No, not again!</i>\" she whines, once again in a similar position.\n\n");
			outputText("\"<i>You really shouldn’t keep fighting me if you don’t want this to happen,</i>\" you say, pulling out your [cock] from out between your tentacles, it’s already erect in anticipation.\n\n");
		}
		outputText("You force her legs open with some other tentacles, parting them as far apart as you can and giving you totally unrestricted access to her pussy. Grinning you line up your cock with her pussy, positioning it right up against her lips.\n\n");
		if (virginity()) {
			if (player.cocks[x].cockLength > 10) {
				outputText("\"<i>No that’s too big! It’ll never fit!!</i>\" she whimpers, trying to escape but ending up only managing to grind herself against your cock, arousing herself and making her moan.\n\n");
				outputText("\"<i>Don’t worry it will,</i>\" you reassure her, grinding your cock against her to make her wet.\n\n");
			}
			else {
				outputText("\"<i>No, I don’t want my first time taken by you!</i>\" she whimpers, trying to escape but ending up only managing to grind herself against your cock, arousing herself and making her moan.\n\n");
				outputText("\"<i>It could be worst, I could be a demon,</i>\" you suggest, grinding your cock against her to make her wet.\n\n");
			}
		}
		else {
			outputText("She moans as your cock touches her, her body seeming to remember getting getting fucked by you before making her pussy already grow moist.\n\n");
			outputText("\"<i>For someone who says she hates this, your body sure seems to like it,</i>\" you taunt, grinding your cock against her to make her wetter.\n\n");
		}
		outputText("She doesn’t respond since she is already moaning as her " + (virginity() ? "virgin pussy is grinded against your cock, growing wetter with every grind until it’s soaked" : "moist pussy is grinded against your cock, it quickly becoming soaked and ready to be fucked again") + ".\n\n");
		if (virginity()) outputText("Adjusting her body you thrust your cock into her, making her whimper as your cock rips apart her hymen, taking her virginity.\n\n");
		else outputText("Adjusting her body you thrust your cock into her, making her moan as her pussy is once again filled with your cock.\n\n");
		outputText("Using your tentacles you start making her ride your cock, " + (virginity() ? "her whimpers soon becoming moans as her pussy is pounded" : "moaning loudly as the familiar cock pounds her pussy once again") + ". ");
		outputText("You increase your tentacles movement, increasing the speed in which she humps you, leaving your hands free to play with her tits, making her gasp as you tug her nipples while your tentacles do all the work, teasing her breasts unmercifully, until eventually you feel the oncoming orgasm, and she must feel it too.\n\n");
		outputText("\"<i>Please, don’t cum inside me!</i>\" she begs, squirming against your tentacles.\n\n");
		outputText("Feeling some pity, just as you're about to cum, you slip her off you, the feeling pushing you over the edge as you cum over her body, covering her fur in you white spunk.\n\n");
		outputText("Satisfied, you dump her own the ground, leaving her there as you redress yourself and move on.\n\n");
	}
	if (player.isNaga()) {
		outputText("You look over the defeated equine as she is sprawled across the ground, wondering what you’ll do to her you wrap your tail around her hands before dragging her into the air, making her hang in front of you. She struggles but your strong tail holds her hands trapped.\n\n");
		outputText("\"<i>Mmmm, what should I do with you,</i>\" you ask, running your hands down her body, until your hands reach her pussy.\n\n");
		if (virginity()) {
			outputText("\"<i>Don’t touch me there!</i>\" she yells, trying to escape, \"<i>Going to cum!</i>\" you say, warning her.\n\n");
			outputText("\"<i>Oh really?</i>\" you say, while slipping one of your fingers into her unprotected pussy, where you find out to your surprise that she is a virgin. \"<i>How surprising,</i>\" you note, pulling out your [cock] from your hidden cavity, it’s already erect in anticipation.\n\n");
		}
		else {
			outputText("\"<i>No, not again!</i>\" she whines, once again in a similar position.\n\n");
			outputText("\"<i>You really shouldn’t keep fighting me if you don’t want this to happen,</i>\" you say, pulling out your [cock] from your hidden cavity, it’s already erect in anticipation.\n\n");
		}
		outputText("You force her legs open, parting them as far apart as you can, giving you unrestricted access to her pussy. Grinning, you line up you cock with her pussy, positioning it right up against her lips.\n\n");
		if (virginity()) {
			if (player.cocks[x].cockLength > 10) {
				outputText("\"<i>No that’s too big! It’ll never fit!!</i>\" she whimpers, trying to escape but ending up only managing to grind herself against your cock, arousing herself and making her moan.\n\n");
				outputText("\"<i>Don’t worry it will,</i>\" you reassure her, grinding your cock against her to make her wet.\n\n");
			}
			else {
				outputText("\"<i>No, I don’t want my first time taken by you!</i>\" she whimpers, trying to escape but ending up only managing to grind herself against your cock, arousing herself and making her moan.\n\n");
				outputText("\"<i>It could be worst, I could be a demon,</i>\" you suggest, grinding your cock against her to make her wet.\n\n");
			}
		}
		else {
			outputText("She moans as your cock touches her, her body seeming to remember getting getting fucked by you before making her pussy already grow moist.\n\n");
			outputText("\"<i>For someone who says she hates this, your body sure seems to like it,</i>\" you taunt, grinding your cock against her to make her wetter.\n\n");
		}
		outputText("She doesn’t respond since she is already moaning as her " + (virginity() ? "virgin pussy is grinded against your cock, growing wetter with every grind until it’s soaked" : "moist pussy is grinded against your cock, it quickly becoming soaked and ready to be fucked again") + ".\n\n");
		if (virginity()) outputText("Adjusting her body you thrust your cock into her, making her whimper as your cock rips apart her hymen, taking her virginity.\n\n");
		else outputText("Adjusting her body you thrust your cock into her, making her moan as her pussy is once again filled with your cock.\n\n");
		outputText("Using your tail you start making her ride your cock, " + (virginity() ? "her whimpers soon becoming moans as her pussy is pounded" : "moaning loudly as the familiar cock pounds her pussy once again") + ". ");
		outputText("You increase your tail movement, increasing the speed in which she humps you, using your hands to play with her tits, making her gasp as you tug her nipples while your tail does all the work, teasing her breasts unmercifully, until eventually you feel the oncoming orgasm, and she must feel it too.\n\n");
		outputText("\"<i>Please, don’t cum inside me!</i>\" she begs, squirming in your tail.\n\n");
		outputText("Feeling some pity, just as you're about to cum, you slip her off you, the feeling pushing you over the edge as you cum over her body, covering her fur in you white spunk.\n\n");
		outputText("Satisfied, you dump her own the ground, leaving her there as you redress yourself and slither off.\n\n");
	}
	if (player.isTaur()) {
		outputText("You grab the fallen equine and drag her off to a nearby " + object() + ", draping her over it. You know exactly what you’re going to do with her. Not even bothering to undress, you climb over her, your cock erect and ready to go.\n\n");
		outputText("Realizing what you’re trying to do, she tries to escape but you squash her under your body, trapping her between you and the " + object() + " until she stops struggling. Once she finally gives up, your adjust your hips, pressing your cock against her sex, before grinding against her so she’ll get wet, making her moan and whimper slightly as your [cock] rubs against her folds.\n\n");
		if (virginity()) {
			outputText("\"<i>Please stop! I’m saving myself!!</i>\" she whimpers, feeling herself get wet under your assault.\n\n");
			outputText("\"<i>Shouldn’t have tried to fight me then,</i>\" you grunt, guessing that she’ll soon be wet enough.\n\n");
		}
		else {
			outputText("\"<i>No not again!!</i>\" she whimpers, feeling herself get wet under your assault.\n\n");
			outputText("\"<i>Admit it, you like it!</i>\" you smirk, guessing that she’ll soon be wet enough.\n\n");
		}
		outputText("Adjusting your hips one more time, you start pressing your cock against her folds, making her whimper again. Grunting, you force your cock into her, making her " + (virginity() ? "whimper as your cock tears her hymen as" : "moan as") + " it fills up her pussy with your meaty rod, sinking in until she’s totally full of your cock. ");
		outputText("Not satisfied with just this, you pull back your hips before plunging them back into her, making her moan loudly as you begin to thrust into her, the wet slapping noise of your hips slapping together filling the area as you rape her pussy, making her moan as your [cock] pounds her pussy, her body shaking with each thrust.\n\n");
		outputText("She shudders at one point, possibly because of an orgasm, making her, already tight, pussy clamp down harder on your cock, earning a grunt from you as you feel yourself grow closer to an orgasm yourself.\n\n");
		outputText("\"<i>Gonna cum,</i>\" you grunt, speeding up your thrusts.\n\n");
		outputText("\"<i>NO! Cum outside!! Outside!!</i>\" she screams, trying to escape again.\n\n");
		outputText("Grunting, and with a huge amount of self control, you pull yourself out of her, spraying your load over her back. Satisfied, you climb off her, leaving her to hang off the " + object() + ", crying softly to herself, while you dress yourself and leave.\n\n");
	}
	//if (player.isAlraune()) x;
	if (flags[kFLAGS.DIANA_LVL_UP] < 3) flags[kFLAGS.DIANA_FOLLOWER] = 3;
	else flags[kFLAGS.DIANA_FOLLOWER] = 4;
	player.sexReward("vaginalFluids");
	cleanupAfterCombat();
}
public function wonOverDianaSpare():void {
	clearOutput();
	if (flags[kFLAGS.DIANA_LVL_UP] == 7 && flags[kFLAGS.DIANA_AFFECTION] == 95) {
		outputText("You tell the girl you will let her go. You have no business with her. The horse morph however decide not to leave right away.\n\n");
		outputText("\"<i>Thank you I may have been to hasty to judge you and I think it’s high time we truly gets aquainted. My name’s Diana I just wanted to let you know because.</i>\"\n\n");
		outputText("Well Diana, that’s one name you ain’t about to forget, still she better be off on her way now. She nods and run off disapearing in the forest.\n\n");
	}
	else {
		outputText("You tell the girl you will let her go. You have no business with her.\n\n");
		outputText("At first she looks at you in confusion, then nods before running off in the forest. Maybe next time the two of you could meet on more friendly dispositions.\n\n");
	}
	cleanupAfterCombat();
	return;
}
public function lostToDiana():void {
	clearOutput();
	outputText("The horse morph kicks you in the face, knocking you unconscious. When you wake up, you realise she got away with some of your gems. Guess that's not the worst thing that could happen, right?\n\n");
	cleanupAfterCombat();
	return;
}
private function levelingHerself():void {
	flags[kFLAGS.DIANA_DEFEATS_COUNTER]++;
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.DIANA_LVL_UP] == 0) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 18);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 1;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.DIANA_LVL_UP] == 1) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 21);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 21);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 2;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.DIANA_LVL_UP] == 2) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 24);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 24);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 3;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.DIANA_LVL_UP] == 3) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 27);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 27);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 4;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.DIANA_LVL_UP] == 4) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 30);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 30);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 5;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.DIANA_LVL_UP] == 5) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 33);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 33);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 6;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 4 && flags[kFLAGS.DIANA_LVL_UP] == 6) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 36);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 36);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 7;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 4 && flags[kFLAGS.DIANA_LVL_UP] == 7) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 39);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 39);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 8;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 5 && flags[kFLAGS.DIANA_LVL_UP] == 8) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 45);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 45);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 9;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 6 && flags[kFLAGS.DIANA_LVL_UP] == 9) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 51);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 51);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 10;
	}
	dianaAffection(5);
}
public function beMyStallion():void {
	clearOutput();
	outputText("Diana once again falls to the ground defeat, falling on her pump behind with a ‘Oof!’ You put away your [weapon], before noticing that the alicorn is looking up at you with a strange expression.\n\n");
	outputText("\"<i>You really defeated me again, huh?</i>\" Diana says, her voice not sounding upset, but strangely happy, \"<i>Not to mention that you have only gotten stronger as we fought.</i>\"\n\n");
	outputText("\"<i>I guess,</i>\" you say, wondering where this is going.\n\n");
	outputText("\"<i>I don’t think I’ll ever meet someone else as strong and powerful as you,</i>\" Diana says, seeming to be embarrassed, as she blushes and draws in the dirt with her fingers, \"<i>You’ve beaten me so many times, but let me keep virginity, allowing me to become an alicorn like I always wanted...</i>\"\n\n");
	outputText("You cross your arms, letting Diana continue talking.\n\n");
	outputText("\"<i>Most others just give up their virginity, not even caring about becoming a unicorn or an alicorn, they just give into their lust, sleeping with anyone they wanted,</i>\" Diana says, her voice sad, \"<i>I always wanted to be an alicorn and find a stallion that could be my partner for life, but I would lose all that if I had sex...</i>\"\n\n");
	outputText("Diana looks up at you, sadness in her eyes.\n\n");
	outputText("\"<i>You know how hard it was?</i>\" Diana whimpers, her face flushed, \"<i>I’m always so horny that it hurt, there were so many times I just wanted to bend over to anything with a dick, just to let it fuck me until I was satisfied? My dreams were always full of me finally having sex, how wonderful it’ll be, but always to wake up in the morning and realize it was all a dream.</i>\"\n\n");
	outputText("You feel sorry for the alicorn, even though she worked herself into such a state, she is clearly getting aroused by even the mere thought of having sex.\n\n");
	outputText("\"<i>Everyone thought I was silly and just said to give up, but thanks to you I’ve finally managed to become an alicorn,</i>\" Diana says, calming down, \"<i>All I need is to find my stallion that I can give myself too, and... well... I...</i>\" Diana starts to stutter, her face turning a deep red, before she squeezes her eyes shut and asks, \"<i>Can you be my stallion, please?</i>\"\n\n");
	outputText("You tilt your head to side, and ask the obvious question, \"<i>Why?</i>\"\n\n");
	outputText("\"<i>Cause, you’re so strong, and I really like that in a mate,</i>\" Diana says, her face as red as tomato, \"<i>I think I’ll be really happy with you too, and the thought of having you father my foals fills me up with such a warm feeling... also I... think I love you too... so please say you’ll be my stallion, I’ll be a good mare and satisfy all your desires, carry all the children you want, so please...</i>\"\n\n");
	if (player.gender == 0 || player.gender == 2) {
		outputText("\"<i>You know I’m not a male right?</i>\" you says, frowning.\n\n");
		outputText("\"<i>I know, I know,</i>\" Diana says, blushing, \"<i>But I have some equinum mixed with some incubus draft that you can use to grow a cock, so if you’ll be my stallion you’ll have to take some... sorry.</i>\"\n\n");
	}
	menu();
	addButton(0, "Yes", breakingInYourMare);
	addButton(1, "No", beMyStallionNo);
}
public function beMyStallionRepeat():void {
	clearOutput();
	outputText("Diana ask with clear hopes in her eyes.\n\n");
	outputText("\"<i>Did you take your time to consider my request? Would you let me be your mare?</i>\"\n\n");
	menu();
	addButton(0, "Yes", breakingInYourMare);
	addButton(1, "No", beMyStallionNo);
}
public function beMyStallionNo():void {
	clearOutput();
	outputText("You apologize to Diana but you can’t, not now not yet. You need some time to consider the option first.\n\n");
	outputText("For a moment she look at you disappointed like she expected something else then finally reply.\n\n");
	outputText("\"<i>It’s all right take your time. Come back to me when you are ready to let me in your life and I will gladly come over.</i>\"\n\n");
	flags[kFLAGS.DIANA_FOLLOWER] = 5;
	cleanupAfterCombat();
	return;
}
public function breakingInYourMare():void {
	clearOutput();
	if (player.gender == 0 || player.gender == 2) {
		outputText("You take the mixture, groaning as you suddenly feel a sizeable cock growing between your legs.\n\n");
		player.createCock(10 + rand(7), 2 + rand(10) / 10);
		player.cocks[1].cockType = CockTypesEnum.HORSE;
	}
	outputText("Diana, in a fit of excitement, suddenly climbs onto her knees and hands before turning around and presenting her rear for you to fuck, moving her tail out of the way of her virgin sex and her equally virgin arsehole, her whole body trembling in excitement.\n\n");
	outputText("\"<i>Thank you!</i>\" Diana says, her voice full of happiness, as she shakes her behind temptingly. \"<i>I’ll be a good mare to you, but please fuck me!! I really can’t take it anymore, I just need your cock in me now!!</i>\" her voice desperate.\n\n");
	outputText("You place your hand on your new equine’s behind, her body quivering at your touch, as you slide across it, feeling the soft cheek under your fingers. Diana moans loudly as you begin to fondle her arse, letting your fingers sink into yielding flesh, her body trembling butt is squeezed and molded by your hands.\n\n");
	outputText("\"<i>Please stop teasing me, and just fuck me!!</i>\" Diana moans.\n\n");
	outputText("\"<i>I thought you said you’re going to be a good mare?</i>\" you tease, giving her arse another hard squeeze, earning a loud moan from Diana, \"<i>A good mare would wait until her stallion is ready.</i>\"\n\n");
	outputText("She shivers at your words, as if your orders somehow gave her pleasure, before nodding her head and waiting for you to eventually fuck her senseless. You move one of your hands off her butt, slipping it down between her legs, moving it across her pussy which is totally soaked while her juices are running down her leg and dripping onto the ground.\n\n");
	outputText("\"<i>Your cunt is so wet from just a bit of light butt touching? You really are a dirty mare,</i>\" you say, gently rubbing your fingers against her sex, earning more moans from her, \"<i>You really want me to fuck you don’t you?</i>\"\n\n");
	outputText("\"<i>Yes! I’ve never wanted anything more than how much I want your cock in me now!!</i>\" she moans, her body still trembling.\n\n");
	if (player.cocks.length == 1) {
		outputText("Smiling, you stop rubbing her and grab hold of your already erect [cock], pressing it against Diana’s sex, her moaning at the mere touch of your cock.\n\n");
		outputText("\"<i>Beg for it,</i>\" you tease, rubbing your cock against her sex, earning a whimper from Diana.\n\n");
		outputText("\"<i>Please fuck me! I want to feel your cock inside me!</i>\" Diana begs, trying to resist moving her body.\n\n");
		outputText("\"<i>Beg for it harder,</i>\" you tease, slightly prodding you cock head against her lips.\n\n");
		outputText("\"<i>I want you to pound me! I want you to break me in and shape my pussy into the shape of your cock!! Fuck me and make me your mare!!</i>\" she screams, her face pained by the desire for your cock.\n\n");
		outputText("\"<i>Good girl,</i>\" you say, before plunging your entire dick into her, earning a surprised gasp from Diana.\n\n");
		outputText("Your cock slips easily into Diana’s soaked pussy, breaking through her hymen and earning a pained whine from Diana as her virginity is finally taken away, tears forming in her eyes.\n\n");
		outputText("\"<i>Are you ok?</i>\" you ask, making sure Diana is ok and stopping your movement.\n\n");
		outputText("\"<i>I’m just... I’m just so happy,</i>\" Diana says, trying to blink away the tears, \"<i>I feared this was another dream, but the pain feels so real, and I’m just so happy I’m able to be joined with you like this, I’m happy that you’ve taken my first time and I’ll treasure this pain forever.</i>\"\n\n");
		outputText("Smiling at Diana’s cute and sweet words, you start to pull your cock out slowly, realizing you should probably make this more special for Diana, and make it more tender and loving. As your cock slips out, Diana makes cute but slightly pained moaning noises, obviously still tender from having her virginity taken. Once your cock is nearly out you thrust back in, as hard but gentle as possible, earning a happy moan from Diana as your cock sinks back into her.\n\n");
		outputText("\"<i>You’re being so gentle...</i>\" Diana moans, looking back at you, her eyes full of her love for you.\n\n");
		outputText("\"<i>Just letting you get used to it,</i>\" you say, beginning your slow thrust into her, letting her pussy grow accustomed to your cock.\n\n");
		outputText("\"<i>Thank you, it feels really good...</i>\" Diana moans again, her body shuddering as you gently fuck her, \"<i>You really are my perfect stallion.</i>\"\n\n");
		outputText("\"<i>Tell me when you’re ready to let me speed up,</i>\" you say, smiling at your cute mare.\n\n");
		outputText("\"<i>You can probably speed up now, the pain is practically gone,</i>\" Diana moans, smiling back at you.\n\n");
		outputText("Smiling, you speed up, beginning to piston your hips and slamming your cock into her tight cunt, earning a scream from Diana as her pussy is finally pounded by your [cock].\n\n");
		outputText("\"<i>You ok?</i>\" you ask, not stopping your thrusting into her.\n\n");
		outputText("\"<i>YEAH!! It just feels so good!</i>\" Diana moans, her body shaking as her insides are pounded, \"<i>Your cock feels so good inside me!! You’re gonna make me cum soon!!</i>\"\n\n");
		outputText("True to her word she cums, screaming into the ground as her pussy tightens and convulses around your cock, as you continue to fuck her, making her scream and moan as you continue to pound her pussy through her orgasm.\n\n");
		outputText("\"<i>NOOOO! IT FEELS TOO GOOD!!! I’M GOING INSANE!!</i>\" Diana screams, her body shaking in pleasure, her face in ecstasy.\n\n");
		outputText("Smirking, you start to savagely thrust into her, earning her loudest scream yet, prolonging her orgasm further and making her pussy tighten so much it nearly hurts, but you continue to thrust into her, pounding her cunt and you reshape it into your personal fuckhole. By the time her orgasm finishes, ");
		outputText("she collapses onto the ground, her backside only supported by your still thrusting cock and your hands. Smirking at your exhausted mare, you grab her by the shoulder and pull her up against your chest, your hips still pumping.\n\n");
		outputText("\"<i>Don’t think this is over till I’m finished,</i>\" you whisper into her ear, making her shiver at your voice, \"<i>I’m going to continue fucking you until I can’t fuck you anymore.</i>\"\n\n");
		outputText("\"<i>Please do,</i>\" Diana whimpers, enjoying being treated like this, \"<i>Unload all your cum into me and make me pregnant with your foals! I’ll only be happy if you fuck me until you’re satisfied...</i>\"\n\n");
		outputText("\"<i>Such a good mare, you deserve a reward...</i>\" you say while moving her head towards yours, kissing her on the lips, earning a surprised squeak from Diana before sinking into your kiss, twisting her body around to wrap her arms around your head in a light hug, ");
		outputText("moaning into your mouth as you still piston into her like a machine. Eventually you break the kiss, Diana looking at you like she is about to burst into tears.\n\n");
		outputText("\"<i>What should I do?</i>\" Diana cries, tears forming in her eyes, \"<i>I’m so happy, it’s all like a dream and I fear at any moment I’ll wake up and you won’t be here with me.</i>\"\n\n");
		outputText("\"<i>Don’t worry you won’t, I promise you,</i>\" you say, kissing away some of her tears, \"<i>I’ll never leave such a cute mare alone for long.</i>\"\n\n");
		outputText("Diana giggles for a second before moaning again, as her your cock continues to fuck her. You can feel yourself growing closer to an orgasm, and any second now you’ll shoot your seed into her, truly claiming her as your mare.\n\n");
		outputText("\"<i>I’m going to cum soon,</i>\" you warn her, earning a pleased moan from her.\n\n");
		outputText("\"<i>Please hurry, I can’t wait!</i>\" Diana begs you, still hugging your head.\n\n");
		outputText("You grunt as you finally cum, ");
		if (player.cumQ() >= 2000) {
			outputText("earning a gasp from Diana as you blast your cum into her womb like a hose, making her belly bulge and swell as you flood her pussy and womb with your thick baby batter. She giggles softly as her belly swells until she looks pregnant, showing that her womb is now well stuffed with your seed, which will soon hopefully spawn a foal in her.\n\n");
			outputText("\"<i>Hehe, it’ll be a miracle if I don’t end up pregnant with this much cum inside me,</i>\" Diana giggles, rubbing her bloated belly, \"<i>I’m sure I’m pregnant now...</i>\"\n\n");
		}
		else {
			outputText("earning a happy moan from Diana as she feels your hot seed filling her pussy, and entering her womb, where hopely it’ll pant itself into her and form the child Diana really wants.\n\n");
			outputText("\"<i>Thank you, I just hope I end up pregnant,</i>\" Diana says, smiling happily, \"<i>Since then this truly be the best day in my life...</i>\"\n\n");
		}
	}
	if (player.cocks.length > 1) {
		outputText("Smiling, you stop rubbing her and grab hold of two of your already erect [cocks], pressing them against Diana’s sex, her moaning at the mere touch of your cocks.\n\n");
		outputText("\"<i>Beg for it,</i>\" you tease, rubbing your cocks against her sex, earning a whimper from Diana.\n\n");
		outputText("\"<i>Please fuck me! I want to feel your cocks inside me!</i>\" Diana begs, trying to resist moving her body.\n\n");
		outputText("\"<i>Beg for it harder,</i>\" you tease, moving one of the cocks against her arsehole, before slightly prodding you cock heads against both her holes.\n\n");
		outputText("\"<i>I want you to pound me! I want you break in my pussy and arse and shape them into the shape of your cocks!! Fuck me and make me your mare!!</i>\" she screams, her face pained by the desire for your cocks.\n\n");
		outputText("\"<i>Good girl,</i>\" you says, before plunging both your dicks into her, earning a surprised gasp from Diana.\n\n");
		outputText("Your cock slips easily into Diana’s soaked pussy, the one in her arse having a bit more trouble but eventually slipping all the way in too, while the one in her pussy breaks through her hymen and earning a pained whine from Diana as both virginities are finally taken away in one thrust, making tears forming in her eyes.\n\n");
		outputText("\"<i>Are you ok?</i>\" you ask, making sure Diana is ok and stopping your movement.\n\n");
		outputText("\"<i>I’m just... I’m just so happy,</i>\" Diana says, trying to blink away the tears, \"<i>I feared this was another dream, but the pain feels so real, and just happy I’m able to be joined with you like this, I’m happy that you’ve taken both my first times at once and I’ll treasure this pain forever.</i>\"\n\n");
		outputText("Smiling at Diana’s cute and sweet words, you start to pull your cocks out slowly, realizing you should probably make this more special for Diana, and make it more tender and loving. As your cocks slip out, Diana makes cute but slightly pained moaning noises, obviously still tender from having her virginities taken. Once your cocks are nearly out you thrust back in, as hard but gentle as possible, earning a happy moan from Diana as your cocks sink back into her.\n\n");
		outputText("\"<i>You’re being so gentle...</i>\" Diana moans, looking back at you, her eyes full of her love for you.\n\n");
		outputText("\"<i>Just letting you get used to it,</i>\" you say, beginning your slow thrust into her, letting her pussy and arse grow accustomed to cocks.\n\n");
		outputText("\"<i>Thank you, it feels really good...</i>\" Diana moans again, her body shuddering as you gently fuck her, \"<i>You really are my perfect stallion.</i>\"\n\n");
		outputText("\"<i>Tell me when you’re ready to let me speed up,</i>\" you say, smiling at your cute mare.\n\n");
		outputText("\"<i>You can probably speed up now, the pain is practically gone now,</i>\" Diana moans, smiling back at you.\n\n");
		outputText("Smiling, you speed up, beginning to piston you hips and slamming your cocks into her tight cunt and arse, earning a scream from Diana as her pussy and butt are finally pounded by your [cocks].\n\n");
		outputText("\"<i>You ok?</i>\" you ask, not stopping your thrusting.\n\n");
		outputText("\"<i>YEAH!! It just feels so good!</i>\" Diana moans, her body shaking as her inside are pounded, \"<i>Your cocks feels so good inside me!! You’re gonna make me cum soon!!</i>\"\n\n");
		outputText("True to her word she cums, screaming into the ground as her pussy and arsehole tighten and convulse around your cock, while you continue to fuck her, making her scream and moan as you continue to pound her pussy and arse through her orgasm.\n\n");
		outputText("\"<i>NOOOO! IT FEELS TOO GOOD!!! I’M GOING INSANE!!</i>\" Diana screams, her body shaking in pleasure, her face in ecstasy.\n\n");
		outputText("Smirking, you start to savagely thrust into her, earning her loudest scream yet, prolonging her orgasm further and making her pussy and arsehole tighten so much it nearly hurts, but you continue to thrust into her, pounding her cunt and butt as you reshape them into your personal fuckholes. ");
		outputText("By the time her orgasm finishes, she has collapsed onto the ground, her backside only supported by your still thrusting cocks and your hands. Smirking at your exhausted mare, you grab her by the shoulder and pull her up against your chest, your hips still pumping.\n\n");
		outputText("\"<i>Don’t think this is over till I’m finished,</i>\" you whisper into her ear, making her shiver at your voice, \"<i>I’m going to continue fucking you until I can’t fuck anymore.</i>\"\n\n");
		outputText("\"<i>Please do,</i>\" Diana whimpers, enjoying being treated like this, \"<i>Unload all your cum into me and make me pregnant with your foals! I’ll only be happy if you fuck me until you’re satisfied...</i>\"\n\n");
		outputText("\"<i>Such a good mare, you deserve a reward...</i>\" you say while moving her head towards yours, kissing her on the lips, earning a surprised squeak from Diana before sinking into your kiss, twisting her body around to wrap her arms around your head in a light hug, moaning into your mouth as you still piston into her like a machine. Eventually you break the kiss, Diana looking at you like she is about to burst into tears.\n\n");
		outputText("\"<i>What should I do?</i>\" Diana cries, tears forming in her eyes, \"<i>I’m so happy, it’s all like a dream and I fear at any moment I’ll wake up and you won’t be here with me.</i>\"\n\n");
		outputText("\"<i>Don’t worry you won’t, I promise you,</i>\" you say, kissing away some of her tears, \"<i>I’ll never leave such a cute mare alone for long.</i>\"\n\n");
		outputText("Diana giggles for a second before moaning again, as your cocks continues to fuck her. You can feel yourself growing closer to an orgasm, and any second now you’ll shoot your seed into her, truly claiming her as your mare.\n\n");
		outputText("\"<i>I’m going to cum soon,</i>\" you warn her, earning a pleased moan from her.\n\n");
		outputText("\"<i>Please hurry, I can’t wait!</i>\" Diana begs you, still hugging your head.\n\n");
		outputText("You grunt as you finally cum, ");
		if (player.cumQ() >= 2000) {
			outputText("earning a gasp from Diana as you blast your cum into her womb and guts like a hose, making her belly bulge and swell massively as you flood her womb and guts with your thick baby batter. She giggles softly as her belly swells until she looks very pregnant, showing that her guts and womb are now well stuffed with your seed, which will soon hopefully spawn a foal in her.\n\n");
			outputText("\"<i>Hehe, it’ll be a miracle if I don’t end up pregnant with this much cum inside me,</i>\" Diana giggles, rubbing her bloated belly, \"<i>You’ve probably even gotten my butt pregnant too with how much cum you pumped into it...</i>\"\n\n");
		}
		else {
			outputText("earning a happy moan from Diana as she feels your hot seed filling her pussy and arse, it entering her womb, where hopely it’ll pant itself into her and form the child Diana really wants.\n\n");
			outputText("\"<i>Thank you, I just hope I end up pregnant,</i>\" Diana says, smiling happily, \"<i>Since then this truly be the best day in my life...</i>\"\n\n");
		}
	}
	outputText("\"<i>Don’t think it’s over my mare,</i>\" you say, your cock" + (player.cocks.length == 1 ? "" : "s") + " still hard inside her, \"<i>I’m not finished yet...</i>\"\n\n");
	outputText("Diana smiles at you, planting a quick kiss on your mouth, \"<i>I can’t wait...</i>\"\n\n");
	outputText("Smirking, you get back to making love to her. Eventually you’re finally satisfied, and the two of you are laying on the ground together, catching your breath, Diana’s head laying on your chest, while also catching her breath" + (player.cumQ() >= 2000 ? "and letting all the cum drain out of her cum stuffed hole" : "") + "" + (player.cocks.length == 1 ? "" : "s") + ".\n\n");
	player.sexReward("vaginalFluids","Dick");
	cleanupAfterCombat();
	doNext(breakingInYourMare2);
}
public function breakingInYourMare2():void {
	clearOutput();
	outputText("After resting a bit. You help your new mare get situated with herself, and then help her gather up her stuff so the two of you can head back to camp.\n\n");
	outputText("After you make sure she has everything she needs, the two of you head back.\n\n");
	outputText("(<b>Diana has been added to the Lovers menu!</b>)\n\n");
	flags[kFLAGS.DIANA_FOLLOWER] = 6;
	doNext(playerMenu);
}

public function mainCampMenu():void {
	clearOutput();
	outputText("You go check on Diana and find her reading a book on medicine. She swiftly acknowledge your presence.\n\n");
	outputText("\"<i>Oh hello [name] did you need anything? If you are injured I can patch you up right away.</i>\"\n\n");
	menu();
	addButton(0, "Appearance", dianaAppearance);
	//1 - Talk
	if (player.HP < player.maxHP()) addButton(3, "Healing", HealingScene);
	else addButtonDisabled(3, "Healing", "You're fully healed already.");
	addButton(4, "Sex", mainSexMenu);
	addButton(14, "Back", camp.campLoversMenu);
}

public function dianaAppearance():void {
	clearOutput();
	outputText("Diana is a white furred 7 foot tall Alicorn with long white hair and a decently toned body covered with unblemish white fur. Her green eyes look at you both wise and gentle. She's currently looking at you while holding a book about medicine and plants.\n\n");
	outputText("Your eyes pretend not to drop to her J cup breast below her neck though if she noticed she did not seem to mind. Her feets as with all horse morphs ends in hooves. You have been hit often enough by these to know not to mess with her. Her tail the same color as as hair is wrapped across her legs right now. You know Diana protected her virginity up to becoming a Alicorn, though now since you are her stallion, she is before anything your girlfriend.\n\n");
	menu();
	addButton(14, "Back", mainCampMenu);
}

public function HealingScene():void {
	clearOutput();
	outputText("You asked Diana if she could heals you, and she said yes. Diana gestures you to come into her arms, which you do, allowing her to hold you against her wonderful body.\n\n");
	outputText("She then starts to move her hands across your body, rubbing sensually against your [skin], making you gasp as you feel a strong tingling feeling from her fingertips, washing away your pain and injuries.\n\n");
	outputText("Diana starts to rub her chest against yours, causing more of the strange feeling as her soft mounds move against your [skin], your gasps soon turning into moans as her fingers move to your intimate area, sparks of pleasure shooting up your spine as across your " + (player.hasCock() ? "" : "wo") + "manhood.\n\n");
	outputText("But soon it is all over, she lets go of you, all your wounds and injuries all healed, although now you feel rather aroused.\n\n");
	dynStats("lus", 33);
	HPChange(player.maxHP(), true);
	EngineCore.changeFatigue( -(Math.round(player.maxFatigue() * 0.5)));
	doNext(camp.returnToCampUseOneHour);
}

public function mainSexMenu():void {
	clearOutput();
	outputText("You ask your mare if she feels about spend some quality time with her ‘stallion’. Diana blush right away.\n\n");
	outputText("\"<i>How would you want us to do it?</i>\"\n\n");
	menu();
	if (player.lust > 33 && player.hasCock()) {
		//addButton(0, "Breeding", SexMenuBreeding);
		if (!player.isTaur()) addButton(1, "Vaginal", SexMenuVaginal);
		if (!player.isTaur()) addButton(2, "Anal", SexMenuAnal);
		if (!player.isTaur()) addButton(3, "Titfuck", SexMenuTitsfuck);
	}
	addButton(14, "Back", mainCampMenu);
}
public function SexMenuBreeding():void {
	clearOutput();
	outputText("When it will be ready.\n\n");
	outputText("\"<i>Please hurry, I can’t wait!</i>\" Diana begs you, still hugging your head.\n\n");
	player.sexReward("vaginalFluids","Dick");
	doNext(camp.returnToCampUseOneHour);
}
public function SexMenuVaginal():void {
	clearOutput();
	var x:int = player.cockThatFits(36, "length");/*
	if (player.isTaur()) outputText("\"<i>Please hurry, I can’t wait!</i>\" Diana begs you, still hugging your head.\n\n");
	else {*/
		outputText("You order Diana to get on all fours. She couldn’t move quicker as she happily gets on all fours, looking back at you with excitement clearly written on her face. You get behind Diana, moving her tail out of the way while she tries to shake her rear enticingly. You place your hand on Diana’s horse sex, earning a happy moan as well as a slight shiver.\n\n");
		outputText("As soon as your hand runs across her lower lips you can already feel her growing dampness. You probably don’t even need to do much foreplay, since Diana gets wet so easily, but your mare deserves the full treatment. You start rubbing against her sex, making her moan as your fingers press and move along her thick lower lips, giving her clit a little flick once they reach the top, sending a bolt of pleasure up Diana’s spine and earning a gasp from her.\n\n");
		outputText("When you pull your fingers away, your fingers are covered in her sticky juices, you show them to Diana, showing her how wet she is already. She moans softly, before taking the offered fingers in her mouth, licking and sucking them, cleaning them with her mouth, while with your other hand, you press a finger into her soaked cunt. She lets out a muffled moan through your fingers as your other fingers begin to thrust into her, causing more juices to spill down her legs.\n\n");
		outputText("Once you deemed her ready, you pull your finger out of her, earning a muffled whimper, maybe she was close. You also remove your fingers from her mouth, which are now covered in her saliva and offer her your other finger to clean, which she does, greedy licking and sucking off her own juices before you also remove it.\n\n");
		outputText("You get your " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "average") + " [cock] ready, which stands erect and aligning it up with her dripping sex. In trying to tempt you into coming in quicker, begins rubbing her hungry pussy against your hard rod, but you remain dominate and wait until she stops, which she soon does, earning a pathetic whimpering noise from her since she only managed to arouse herself further.\n\n");
		outputText("You stay still for a while, giving Diana a moment to reflect on her mistakes, before slamming your cock into her as hard as you can. " + (player.cocks[x].cockLength >= 20 ? "Diana doesn’t even have time to scream as your huge cock spreads her tight pussy as it spears both her pussy and womb, bulging out her belly in your shape, causing her to let out surprised gasp as her body shudders from the sudden orgasm you gave her" : "Diana doesn’t even have time to scream as your cock spears into her pussy and slams against her womb") + ". ");
		outputText("You also hit her with such force that her hands gave out and her face is now in the dirt, where you plan to keep it, as you start pounding her pussy with your " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "average") + " [cock], making her moan loudly into the ground as you force orgasm after orgasm on her.\n\n");
		outputText("You ask her what she thinks of your cock pounding her pussy, but all she can do is moan, a sluttish look on her face, with her eyes rolled up and her tongue hanging out of her mouth as your rub her face against the dirt with your powerful thrusts. You can feel her cunt tighten around your " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "average") + " [cock] with every thrust, " + (player.cocks[x].cockLength >= 25 ? "your [cockhead] slamming against her breasts through her belly, making her moan like a whore every time" : "your [cockhead] slamming against her womb") + ".\n\n");
		outputText("Although soon yourself are feeling the on comings of an orgasm, a powerful building feeling in your cock" + (player.cocks.length == 1 ? "" : "s") + ". As you feel yourself about to cum, you pull out of her, placing your cock between her cheeks before blasting your " + (player.cumQ() >= 2000 ? "massive load all over Diana’s rear, back and head, staining it all white" : "load over Diana’s rear, staining it white") + ".\n\n");
		outputText("\"<i>Did you enjoy my pussy?</i>\" Diana asks, giving you a tired and well fucked look, her body still with her arse in the air and her face in the ground.\n\n");
		outputText("\"<i>Wonderful as always,</i>\" you say, readjusting her clothes.\n\n");
		outputText("\"<i>Although the cum is wasted on my back, maybe next time put it all in the proper place?</i>\" Diana says, gathering up some cum with one of her fingers and sucking it off.\n\n");
		outputText("\"<i>Only if you're a good mare next time,</i>\" you say with a smirk on your face.\n\n");
		outputText("Diana pouts a bit before you both say your goodbyes, you heading off.\n\n");
	//}
	player.sexReward("vaginalFluids","Dick");
	doNext(camp.returnToCampUseOneHour);
}
public function SexMenuAnal():void {
	clearOutput();
	var x:int = player.cockThatFits(36, "length");/*
	if (player.isTaur()) outputText("\"<i>Please hurry, I can’t wait!</i>\" Diana begs you, still hugging your head.\n\n");
	else {*/
		outputText("You order Diana to get on all fours. She couldn’t move quicker as she happily gets on all fours, looking back at you with excitement clearly written on her face. You get behind her, moving her tail aside before pulling apart her fat butt cheeks and revealing her puckered arsehole, making Diana moan happily.\n\n");
		outputText("You suck on one of your fingers, getting it nice and wet for the insertion, before bringing it down and pushing it into her rear, making her let out a little happy moan as your finger surprisingly, or maybe not, easily slips in.\n\n");
		outputText("\"<i>You’re fingers are in my butt!</i>\" Diana moans, looking over her shoulder at you.\n\n");
		outputText("\"<i>Not yet,</i>\" you reply, before suddenly shoving another finger into her, making her gasp in surprise, \"<i>Now they are!</i>\"\n\n");
		outputText("Diana moans loudly as your two fingers stretch open, rub, and thrust into her hot arse, preparing her for what is to come, loosing her up further. Although the finger fucking seems already too much for the alicorn, who front arms have already given up and her face is against the ground, leaving her arse stuck up into the air.\n\n");
		outputText("Seeing this, you bring your spare hand down on her arse, smacking it hard, making her moan and straighten up in surprise.\n\n");
		outputText("\"<i>Hey don’t go enjoying too much,</i>\" you say, your fingers stick playing with her hot hole.\n\n");
		outputText("\"<i>Sorry, but your fingers feel so good!</i>\" she moans, moving a hand down to her pussy, but you slap it away.\n\n");
		outputText("\"<i>None of that either,</i>\" you say, giving her arse another hard smack.\n\n");
		outputText("\"<i>Sorry!</i>\" Diana moans happily, very much enjoying the rough treatment, as her shaking arms only supporting her body with her sheer will not to disappoint you.\n\n");
		outputText("Thinking that she is ready enough, even though you’re kind of curious how many fingers she can take, and you remove your fingers. Diana letting out a sad whimper at the absent of the fingers, although that quickly changes when she feels your " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "average") + " [cock] press against her rear. Wasting no time, and knowing that she is ready, you slam all your cock into her at once, ");
		outputText("earning a loud scream of pleasure from Diana, " + (player.cocks[x].cockLength >= 20 ? "as your cock stretches her tight little rear beyond normal" : "as your cock fills her tight little rear") + ", her eyes rolling back into her head and her face locked a sluttish grin as your cock begins to pound her arse hard " + (player.cocks[x].cockLength >= 20 ? "making her belly bulge out with your size" : "") + ".\n\n");
		outputText("She is barely able to support her upper body any, now down to her elbows as she tries her best to straighten up, but every time your hips smash into her arse, your cock slamming deep inside her, she loses all strength and she is back on her elbows. Eventually she loses all strength what so ever, and falls face first onto the ground, moaning happily.\n\n");
		outputText("\"<i>Naughty girl, told you stay up, didn’t I?</i>\" you playful chide her, making her moan in response.\n\n");
		outputText("\"<i>Sorry, please punish your naughty mare...</i>\" Diana playful responses, giving you a lustful look.\n\n");
		outputText("Deciding to do that, you pull out your cock until on the tip is in, a fearful look appears on Diana’s face, thinking you’re actually going to punish her, but before she can think that long, you slam back into her as hard as possible, making her gasp in pleasure as her whole body shakes with the force" + (player.cocks[x].cockLength >= 20 ? ", her belly distorting in the shape of your cock" : "") + ".\n\n");
		outputText("It must have made her cum too, since now she is lying limp on the ground, her eyes rolled back and her tongue hanging out her mouth as her head lays in the dirt moaning in pleasure.\n\n");
		outputText("It almost made you cum too, and as you the action for a second and third time, you feel you won’t make a fifth one. With a final powerful and mighty thrust, making Diana scream again as she cums, maybe for the fourth time, you cum, ");
		if (player.cumQ() >= 2000) {
			outputText("blasting her intestines with your thick spunk, filling up guts before swelling her stomach with the load, bloating her until she looks pregnant, once you finished your load, you pull out of her, cum spraying out of her open arsehole, making Diana moan loudly as she feels the cum being blasted back out of her guts, until it calms down and she rolls onto her side, panting.\n\n");
			outputText("\"<i>Thank you so much for properly punishing me,</i>\" she giggles, rubbing her well fucked and cum covered arsehole, \"<i>I don’t think I’ll be able to sit down for awhile though. Though please come back soon, otherwise my other hole will get lonely.</i>\"\n\n");
			outputText("After promising you will later, you head back to your adventure, while Diana rests for awhile.\n\n");
		}
		else {
			outputText("spraying her intestines with your thick spunk, before removing your cock out of her, letting some of the cum leak out of her.\n\n");
			outputText("Diana rolls onto her side, panting from exhaustion, before giving you a loving look.\n\n");
			outputText("\"<i>Thank you so much for properly punishing me,</i>\" she giggles, rubbing her well fucked arsehole, \"<i>I don’t think I’ll be able to sit down for awhile though. Though please come back soon, otherwise my other hole will get lonely.</i>\"\n\n");
			outputText("After promising you will later, you head back to your adventure, while Diana rests for awhile.\n\n");
		}
	//}
	player.sexReward("Default","Dick", true,false);
	doNext(camp.returnToCampUseOneHour);
}
public function SexMenuTitsfuck():void {
	clearOutput();
	var x:int = player.cockThatFits(36, "length");
	outputText("You request that Diana give you a titjob.\n\n");
	outputText("\"<i>Of course my stallion, I would love to have your cock buried between my mounds,</i>\" Diana says, smiling happily while eagerly pressing her tits together.\n\n");
	/*if (player.isTaur()) outputText("\"<i>Please hurry, I can’t wait!</i>\" Diana begs you, still hugging your head.\n\n");
	else {*/
		if (player.isAlraune()) outputText("Diana gets on her knees, while your vine cocks move out around her, the largest one moves in front of her.\n\n");
		else {
			outputText("You sit down on a on a nearby " + object() + " while Diana gets on her knees in front of you, before undoing your [armor] and pulling out your erect " + (player.cocks.length == 1 ? "[cock]" : "[cocks]") + "");
			if (player.isNaga()) outputText("from it’s protective snake slit");
			if (player.isScylla()) outputText("out of from between your tentacles");
			outputText(".\n\n");
		}
		outputText("\"<i>My stallion is all ready I see,</i>\" Diana says, smiling.\n\n");
		if (player.isAlraune()) outputText("Diana moves forward slightly, allowing the " + (player.cocks[x].cockLength >= 25 ? "monsterous" : "large") + " vine to sink between her mounds, your cock like vine’s lower shaft disappearing among the soft flesh.\n\n");
		else outputText("Diana then pressing her big breasts against your stomach, your [cock biggest] cock shaft slipping between her cleavage, and you can’t help but out a little grunt of pleasure at the feelings of her soft flesh on your [skin].\n\n");
		outputText("\"<i>Do you like my breasts [name]? I’m so glad, cause I also love your cock so much...</i>\" Diana says starring endearingly at your cock, ");
		if (player.cocks[x].cockLength >= 25) outputText("which most of the monstrous length is laying across her head, making her shower the titanous member with her devotion in kisses and licks");
		else if (player.cocks[x].cockLength >= 15) outputText("which half is right in front of her face, so she gives a loving kiss");
		else outputText("which is sticking out of the middle of her cleavage");
		outputText(".\n\nDiana presses her large tits with her hands " + (player.cocks[x].cockLength >= 25 ? ". She begins to move her body gently up and down, her tits rubbing along your shaft in sync with her movements, earning another pleased grunt from you" : ", her breasts wrapping comfortably around your girth") + ".\n\n");
		outputText("\"<i>You cock is so hot between my breasts!</i>\" Diana compliments, her eyes hot with lust.\n\n");
		outputText("You ask Diana to speed up and she nods, speeding up her movements slightly, " + (player.isAlraune() ? "your other cock vines wrapping around her body, holding her close while others rub against her body, seeking pleasure. You lean your head back and sigh in pleasure, basking in the wonderful titjob" : "her breasts slapping against your chest when they come down") + ".\n\n");
		if (player.isAlraune()) {
			outputText("Want more pleasure, another of your vine cock coils around her neck before finding her mouth, prodding at her mouth. She complies, happily allowing herself to take the [cock] cock in her mouth, letting it fill her. You make her take all of the cock she can without deepthroating her, holding her there as she sucks and licks it like it is the tastiest of treats, her breasts still bouncing up and down the shaft, drool now now dripping on them from her mouth as she also thrusts her head.\n\n");
			outputText("Still wanting to feel more, your tentacles starts to move more, tightening their grip on her as they aggressively rub against her body, while the one in mouth and the one between start to thrust as well, the one in her mouth stopping short of deepthroating her.\n\n");
			outputText("Soon you fill the building pressure in your cock" + (player.cocks.length == 1 ? "" : "s") + ", threatening to burst out and spray your load inside her cock stuffed mouth. You groan, as you feel it coming, building up and up and up, until it comes comes!\n\n");
			outputText("You vines tightening again as if to stop Diana escaping, which she has no such desire, before unleashing their loads. ");
			if (player.cumQ() >= 2000) {
				outputText("Each vine shooting out their load over whatever surface they can, covering her upper body in their hot cum as the vines spray their huge load all over her, her fur almost disappearing under all the cum thick, while the tentacle in her mouth unloads its huge payload down her throat, the vines around her neck bulging as they making sure she takes it all, her belly swelling with the amount of cum you’ve forced in her. ");
				outputText("As your vines finish their discharge, they remove themselves from her body, her sucking in a deep breath of air as one removes itself from her mouth and neck, before gulping down any remains in her mouth and smiling.\n\n");
				outputText("\"<i>So much, my belly is now nice and full of your cum,</i>\" Diana says, rubbing her swollen belly, \"<i>But you turned me into quite the mess, didn’t you? I don’t think I’ll ever be able to wash out the smell of your cum, not that I mind.</i>\"\n\n");
				outputText("\"<i>It suits you,</i>\" you says, cheeky, giving her a playful kiss on the only non cum covered part of forehead.\n\n");
				outputText("\"<i>I’m glad you think it suits me,</i>\" Diana laughs, licking off some of the cum off her arm, \"<i>But I better clean up, see me for some more fun later, my potent stallion.</i>\"\n\n");
				outputText("You nod and head off, while Diana cleans herself up.\n\n");
			}
			else {
				outputText("Each vine shooting out their load over whatever surface they can, covering her in their hot cum, staining her fur with your mark, while the tentacle in her mouth unloads itself down her throat, the vines around her neck making sure she takes it all. As your vines finish their discharge, they remove themselves from her body, her sucking in a deep breath of air as one removes itself from her mouth and neck, before gulping down any remains in her mouth and smiling.\n\n");
				outputText("\"<i>You cum is as tasty as always, I could even go for a second helping,</i>\" Diana says, cheerfully, \"<i>Although maybe after I clean myself up.</i>\"\n\n");
				outputText("\"<i>Maybe later, if you’re a good mare that is,</i>\" you says, giving one her cum covered tits a playful squeeze.\n\n");
				outputText("\"<i>Mmmm, I’ll look forward for it,</i>\" Diana says, planting a kiss on your check.\n\n");
				outputText("You return the kiss, before heading off, you’ve got things to do.\n\n");
			}
		}
		else {
			outputText("Though eventually you want more, and grabbing her horn, " + (player.cocks[x].cockLength >= 15 ? "guides her up onto your cock’s head" : "guides her down onto your cock") + ".\n\n");
			outputText("Still wanting to feel more, you suddenly begin to move your hips slightly, surprising her as the cock slams into the depths of her mouth as well as slam against her tits, earning a happy moan from her. Soon you’re both moving, you thrusting her your hips slightly, while she continues to move her body up and down your cock, while your cock is still buried in her mouth.\n\n");
			outputText("Soon you fill the building pressure in your cock" + (player.cocks.length == 1 ? "" : "s") + ", threatening to burst out and spray your load inside her vine stuffed mouth and her vine covered body. You groan, as you feel it coming, building up and up and up, until it comes comes!\n\n");
			outputText("You pull down on Diana horn, surprising her as she suddenly as to take even more of your cock, but not as surprised as when you suddenly spray her mouth with cum. ");
			if (player.cumQ() >= 2000) {
				outputText("You cum so heavily that her cheeks bulge with the amount, and it happens so suddenly that some of it sprays out of her mouth onto her tits. Seeing the mess you're making, your force Diana to take the rest of your cock, making her moan as it slips into her throat, allowing your to unload your massive load right down her throat, making her belly as you fill her stomach with your thick stuff.\n\n");
				outputText("When you finally finish, you pull her off your cock, allowing her to take a deep breath, as cum leaks out onto her mouth and onto her breast as she pants.\n\n");
				outputText("\"<i>So much, my belly is now nice and full of your cum,</i>\" Diana says, rubbing her swollen belly, \"<i>But you turned me into quite the mess, didn’t you?</i>\"\n\n");
				outputText("\"<i>It suits you,</i>\" you says, cheeky, giving her a playful kiss on the forehead.\n\n");
				outputText("\"<i>I’m glad you think it suits me,</i>\" Diana laughs, licking off some of the cum off her breasts, \"<i>But I better clean up, see me for some more fun later, my potent stallion.</i>\"\n\n");
				outputText("You nod and head off, while Diana cleans herself up.\n\n");
			}
			else {
				outputText("You fill her mouth with your thick juices, which she happily swallows, gulping down every last drop of it. After you finish cumming, you release her horn, allowing her to remove the cock from her mouth, though on the way up she sucks out the last of your cum from your dick.\n\n");
				outputText("\"<i>You cum is as tasty as always, I could even go for a second helping,</i>\" Diana says, smiling as she gulps down the last of the cum in her mouth.\n\n");
				outputText("\"<i>Maybe later, if you’re a good mare,</i>\" you says, giving one her tits a playful tease.\n\n");
				outputText("\"<i>Mmmm, I’ll look forward for it,</i>\" Diana says, planting a kiss on your check.\n\n");
				outputText("You return the kiss, before heading off, you’ve got things to do.\n\n");
			}
		}
	//}
	player.sexReward("Default","Dick", true,false);
	doNext(camp.returnToCampUseOneHour);
}
	}
}