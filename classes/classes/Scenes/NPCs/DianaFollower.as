/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class DianaFollower extends NPCAwareContent
	{
		
		public function DianaFollower() 
		{}

public function dianaAffection(changes:Number = 0):Number
{
	flags[kFLAGS.DIANA_AFFECTION] += changes;
	//if (flags[kFLAGS.DIANA_AFFECTION] > 100) flags[kFLAGS.DIANA_AFFECTION] = 100;
	if (flags[kFLAGS.DIANA_AFFECTION] > 10) flags[kFLAGS.DIANA_AFFECTION] = 10;
	return flags[kFLAGS.DIANA_AFFECTION];
}
//0-10 affection - Horse-morph; 10-100 affection - Unicorn; 100 affection - Alicorn
public function repeatLakeEnc():void
{
	clearOutput();
	outputText("As you explore the lake area, you run into a");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8) outputText("n alicorn");
	else if (flags[kFLAGS.DIANA_LVL_UP] >= 2) outputText("n unicorn");
	else outputText(" white furred horse morph");
	outputText(".\n\nAt first she doesn’t notice you, to busy examining a flower. You walk to her to say hi, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled  expression and grabs her staff to defend herself, lunging for a set of preemptive strikes as she begins to attack you.\n\n");
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
public function repeatPlainsEnc():void
{
	
}
public function repeatBattlefieldEnc():void
{
	
}
public function wonOverDiana():void
{
	clearOutput();
	outputText("The horse morph kneels down defeated. Seems you can do whatever you want with her now. So, what will it be?\n\n");
	menu();
	if (player.lust >= 33) addButton(1, "Rape", wonOverDianaSex);
	addButton(0, "Spare", wonOverDianaSpare);
}
public function wonOverDianaSex():void
{
	menu();
	if (player.hasVagina()) addButton(0, "Oral (F)", wonOverDianaOralF);
	if (player.hasCock()) {
		addButton(1, "Oral (M)", wonOverDianaOralM);
		//addButton(2, "Rape", wonOverDianaRape);
	}
	addButton(3, "Back", wonOverDiana);
}
public function wonOverDianaOralF():void
{
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
	player.orgasm();
	cleanupAfterCombat();
}
public function wonOverDianaOralM():void
{
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
		outputText("cock. , before lovingly running her tongue down your shaft as well as planting some loving kisses across it, showering it with her devotion. She eventually moves her mouth back up the length, reaching the head and planting another loving kiss on it.\n\n");
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
		else if (player.cocks[x].cockLength >= 5) outputText("Smirking, you push the rest of your cock into the eager equine mouth, making her moaning happily as the head of your cock slips into her throat. You start throat fucking her, letting your cock ravage the tip of her throat while you both enjoy the feeling, the equine moaning with every thrust");
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
	player.orgasm();
	cleanupAfterCombat();
}
private function object():String {
	var buffer:String = "";
	var temp:int = rand(3);
	if(temp == 0) buffer += "rock";
	else if(temp == 1) buffer += "tree stump";
	else buffer += "lost shield";
	return buffer;
}
public function wonOverDianaRape():void
{
	clearOutput();
	outputText(". Smirking you redress and heads off, finally letting the equine catch her breath.\n\n");
	outputText(". Smirking you redress and heads off, finally letting the equine catch her breath.\n\n");
	outputText(". Smirking you redress and heads off, finally letting the equine catch her breath.\n\n");
	if (flags[kFLAGS.DIANA_LVL_UP] < 2) flags[kFLAGS.DIANA_FOLLOWER] = 3;
	else flags[kFLAGS.DIANA_FOLLOWER] = 4;
	player.orgasm();
	cleanupAfterCombat();
}
public function wonOverDianaSpare():void
{
	clearOutput();
	outputText("You tell the girl you will let her go. You have no business with her.\n\n");
	outputText("At first she looks at you in confusion, then nods before running off in the forest. Maybe next time the two of you could meet on more friendly dispositions.\n\n");
	/*flags[kFLAGS.DIANA_DEFEATS_COUNTER]++;
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.DIANA_LVL_UP] == 0) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 18);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 1;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.DIANA_LVL_UP] == 1) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 24;
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 2;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.DIANA_LVL_UP] == 2) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 30);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 3;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.DIANA_LVL_UP] == 3) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 36;
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 4;
	}
	dianaAffection(5);*/
	cleanupAfterCombat();
	return;
}
public function lostToDiana():void
{
	clearOutput();
	outputText("The horse morph kicks you in the face, knocking you unconscious. When you wake up, you realise she got away with some of your gems. Guess that's not the worst thing that could happen, right?\n\n");
	cleanupAfterCombat();
	return;
}
	}
}