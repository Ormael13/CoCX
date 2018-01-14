/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class ElectraFollower extends NPCAwareContent
	{
		
		public function ElectraFollower() 
		{}
		
//flag ELECTRA_TALKED_ABOUT_HER]: 0,1 - not know her name, 3 - know her name, 2/4+ - male sex scene variant for knowing or not what pour it all out mean ^^

public function electraAffection(changes:Number = 0):Number
{
	flags[kFLAGS.ELECTRA_AFFECTION] += changes;
	if (flags[kFLAGS.ELECTRA_AFFECTION] > 100) flags[kFLAGS.ELECTRA_AFFECTION] = 100;
	return flags[kFLAGS.ELECTRA_AFFECTION];
}

public function firstEnc():void
{
	clearOutput();
	outputText("As you wander the mountain you hear the sound of echoing thunder through this time around it clearly didn’t come from the sky. You see multiple imps and even a minotaur run away from the spot where the sound was heard. As you go there to see what’s going on you come upon a single girl with animal morph features. She's panting on the ground a hand under her dress.\n\n");
	outputText("\"<i>Ahhhh someone... someone help me get rid of this maddening desire... rape me... fuck me I don’t care how you do it. Gah why are they all fleeing!...come back! Come back so I can get rid of my itches... Come back so we can FUCK!</i>\"\n\n");
	outputText("She suddenly realizes you are there and her eyes glimmers with a hint of barely contained madness. She stands up on her hind leg, still playing with her pussy, and eyes you up with a manic smile on her face as electricity starts to dance in the air around her.\n\n");
	outputText("\"<i>You will be my lightning rod!!!!</i>\"");
	outputText("\n\nYou are under attack by a Raiju!");
	if (flags[kFLAGS.CODEX_ENTRY_RAIJU] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_RAIJU] = 1;
		outputText("\n\n<b>New codex entry unlocked: Raiju!</b>")
	}
	startCombat(new Electra());
	doNext(playerMenu);
}
public function repeatMountainEnc():void
{
	clearOutput();
	outputText("As you wander the mountain you hear the sound of echoing thunder through this time around it clearly didn’t come from the sky. You see multiple imps and even a minotaur run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatPlainsEnc():void
{
	clearOutput();
	outputText("As you wander the plains you hear the sound of echoing thunder through this time around it clearly didn’t come from the sky. You see multiple imps and even a satyr run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatDeepwoodsEnc():void
{
	clearOutput();
	outputText("As you wander the woods you hear the sound of echoing thunder through this time around it clearly didn’t come from the sky. You see multiple imps and even a satyr run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatElectraEnc():void
{
	outputText("As you go there to see what’s going on you come upon ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("the Raiju girl");
	outputText(" again. She's panting on the ground a hand under her dress and masturbating like there is no tomorrow.\n\n");
	outputText("\"<i>Ahhhh someone... someone help me get rid of this maddening desire... rape me... fuck me I don’t care how you do it. Gah why are they all fleeing!...come back! Come back so I can get rid of my itches... Come back so we can FUCK!</i>\"\n\n");
	outputText("Shit! If she sees you now she will definitively attack but just as you are about to leave she suddenly realizes you are there and her eyes glimmers with a hint of barely contained madness. She stands up on her hind leg, still playing with her pussy, and eyes you up with a manic smile on her face as electricity starts to dance in the air around her.\n\n");
	outputText("\"<i>Just who I need for relief!  Now stay still, I will make it short!!!</i>\"");
	outputText("\n\nYou are under attack by ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("a Raiju");
	outputText(" again!");
	startCombat(new Electra());
	doNext(playerMenu);
}
public function ElectraSexPlayer():void
{
	clearOutput();
	outputText("You fall to the ground unable to continue fighting. The girl however seems to be really happy about this.\n\n");
	outputText("\"<i>FINALLY!!!.. FUCKING FINALLY!!! I found someone to discharge my electricity! I felt I was going to go mad!</i>\"\n\n");
	outputText("For all you care she is already mad. The girl moves to you, smiling wide with a lust crazed expression and you can feel electricity gather around her as she touch you and transfers it all into your body, her eyes rolling and her pussy gushing as she finally achieves the true release she so craved.\n\n");
	outputText("You on the other hand fare poorly. She just zapped you with several orgasms worth of accumulated desire and your body is wracked by pleasure as the static makes you cum over and over again in rapid succession. The ground under you swiftly turns into a pool made out of your own fluid as you see white from your overcharged genitals");
	if (player.hasBreasts()) outputText(" and milk gushing nipples");
	outputText(", the electricity setting all your pleasure nerves into overdrive as your sensitivity skyrocket. You barely see her taking her leave as you faint from the pleasure overdose.\n\n");
	outputText("You wake up in a pool of your own fluids. After such mind wracking pleasure, your entire body feels sensitive and aches to be touched from the slowly receding voltage. Something however tells you that indulging yourself would be a bad idea.\n\n");
	if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
		player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
		player.createStatusEffect(StatusEffects.RaijuLightningStatus,25,0,0,0);
	}
	else player.createStatusEffect(StatusEffects.RaijuLightningStatus,25,0,0,0);
	electraAffection(5);
	player.orgasm();
	cleanupAfterCombat();
	return;
}
public function PlayerSexElectra():void
{
	clearOutput();
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) {
		outputText("Electra falls to the ground defeated again.\n\n");
		outputText("\"<i>Gosh you sure do fight well... Can we get to the fucking already?</i>\"\n\n");
	}
	else if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 1 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 2) {
		outputText("The raiju falls to the ground defeated again.\n\n");
		outputText("\"<i>Ah, you’re quite something... My name is Electra by the way. Nice to meet you again, so yea... Can we get to the fucking already?</i>\"\n\n");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] = 3;
	}
	else {
		outputText("As you look over your defeated opponent you swiftly notice that she’s panting with desire just from looking at you.\n\n");
		outputText("\"<i>Please FUCK ME!... I don’t care how you do it just fuck me so I can be free of my lust! It’s been days...</i>\"\n\n");
		outputText("There's something fishy about this, but do you fuck her anyways?");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] = 1;
	}
	menu();
	if (player.lust >= 33) addButton(0, "Yea Sure", ElectraSeXYes);
	addButton(1, "No Way", ElectraSeXNo);
}
public function ElectraSeXYes():void
{
	clearOutput();
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("The raiju");
	outputText(" surprises you by jumping on top of you before you can even finish your sentence.\n\n");
	outputText("\"<i>Lets not waste any time then!</i>\"");
	outputText("She swiftly takes a hold of your clothes and start methodically stripping you. If you weren't any wiser you would think she is actually turning the table on you but actually she is just so excited to finally get laid that she no longer holds any of her inhibitions on.\n\n");
	if (player.hasCock()) ElectraSeXYesM();
	else ElectraSeXYesF();
}
public function ElectraSeXYesM():void
{
	outputText("\"<i>Ahhh gimme that lighting rod please put it in!</i>\"");
	outputText("She begins flaunting her pussy like a target. Well if she wants it that badly you won’t be the one to disappoint her. You grab her hips and slowly but surely pull her down your [cock]. The girl scream in joy as you finally hit the bottom of her pussy and start rocking up and down without you having to ask anything. There's something odd about this.\n\n");
	outputText("\"<i>Ahhhn were plugged! Were plugged! I’m going to pour it all out!!!!</i>\"");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 2 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 4) outputText("Well here you go again... You get ready to get jolted as");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 1 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 3) {
		outputText("Wait what?! Before you can ask what she means by that");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER]++;
	}
	outputText(" you hear a sound not unlike that of electricity in live wires a few second before your entire body is struck by ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("the raiju");
	outputText("’s lightning. The voltage is flowing out of her pussy straight to your dick! You moan as the current sets every one of your pleasure nerves in overdrive causing you to reach orgasm almost instantly if not several time over and pump the raiju with your cum. The girl seems lost in the sensation of her pussy, tongue out and eye rolling, as she gushes around your twitching cock. ");
	outputText("This rapid fire set of orgasms last for a fair minute before the both of you fall on each other and lose consciousness.\n\nYou wake up with the raiju next to you. The ground is still a massive pool of sponge but for some reason you feel satisfied.\n\n");
	outputText("\"<i>Good morning, I was wondering when you would wake up. I must thank you you helped me evacuate all the stockpiled energy I had.</i>\"");
	outputText("She slowly slide of your cock with a satisfied smile. Where's the crazy girl from before?\n\n");
	outputText("\"<i>I have to go but here take this jewel and these gems for your trouble. I hope we see each others again.</i>\"");
	outputText("She hand you over a yellow jewel and a good amount of gems before leaving. As for you, your entire body feels sensitive and aches for touch from the slowly receding voltage. Something however tells you that indulging yourself would be a bad idea.\n\n");
	if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
		player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
		player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
	}
	else player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
	electraAffection(10);
	player.orgasm();
	monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
	inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
}
public function ElectraSeXYesF():void
{
	outputText("Before you can issue a protest, she begins to grind her pussy against your own making you moan. Her nice E sized teats are bouncing as something not unlike static electricity begins to form between you. No wait it totally is electricity! You are immediately zapped, your pussy gushing with fluids and your brain going mushy as your pleasure buzzers are all set alight by the raiju’s electric current. ");
	outputText("She seems to be riding the orgasm of her life as her own pussy juices are melding with yours electricity dancing in the air around you two. You cum and cum again at such a speed you have no idea how you still manage to retain some semblance of consciousness from the mind numbing pleasure in your switch. Both of you finally lose consciousness as the electric flow ebbs your tongues loling out from the intense pleasure.\n\n");
	outputText("You wake up with the raiju next to you. The ground is still a massive pool of girl cum, but for some reason you feel satisfied.\n\n");
	outputText("\"<i>Good morning, I was wondering when you would wake up. I must thank you, you helped me evacuate all the stockpiled energy I had.</i>\"");
	outputText("She slowly part away from your pussy with a satisfied smile. Where's the crazy girl from before?\n\n");
	outputText("\"<i>I have to go but here take this jewel and these gems for your trouble. I hope we see each others again.</i>\"");
	outputText("She hand you over a yellow jewel and a good amount of gems before leaving. As for you, your entire body feels sensitive and aches for touch from the slowly receding voltage. Something however tells you that indulging yourself would be a bad idea.\n\n");
	if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
		player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
		player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
	}
	else player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
	electraAffection(10);
	player.orgasm();
	monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
	inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
}
public function ElectraSeXNo():void
{
	clearOutput();
	outputText("No, you ain't going to give her satisfaction after she tried to rape you. You walk away heading back to your camp barely hearing the echoes of her cries as the crazy girl begs for you to fuck her brains out.\n\n");
	electraAffection(2);
	cleanupAfterCombat();
}
	}
}