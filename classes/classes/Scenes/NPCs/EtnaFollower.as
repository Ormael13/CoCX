/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class EtnaFollower extends NPCAwareContent
	{
		
		public function EtnaFollower() 
		{}

//flag ETNA_TALKED_ABOUT_HER]: 0 - not know her name, 1 - know her name, 2 - Etna in Yandere mode

public function etnaAffection(changes:Number = 0):Number
{
	flags[kFLAGS.ETNA_AFFECTION] += changes;
	if (flags[kFLAGS.ETNA_AFFECTION] > 100) flags[kFLAGS.ETNA_AFFECTION] = 100;
	return flags[kFLAGS.ETNA_AFFECTION];
}

public function firstEnc():void
{
	clearOutput();
	outputText("You casually take a stroll in the mountains, passing through a tunnel. Weirdly, in the middle of the tunnel you find several unconscious minotaurs. You examine them and discover they all fainted from…sexual exhaustion? Out of nowhere, something scrapes your skin, missing you by a mere inch. You look down to see what looks like a bony spike burrowed in the ground a few feet ahead of you. ");
	outputText("A menacing growl echoes in the tunnel as another spike flies right by you, barely missing your arm this time. Figuring you've been ambushed, you run to the other end to confront your invisible assailant in broad daylight. As soon as you're out, your opponent surges after you. At first glance it looks like a catgirl, however, the shape of her paws and ears hint at being more like a lion’s, ");
	outputText("especially with the large mane around her neck. She could pass for having a human face if not for her malicious cat-like red pupils and sharp canines. The comparison to a cat ends there, due to the pair of large leathery wings that rest on her back.  Where you would have expected a cat tail a scorpion-like chitin covered tail grows. It ends in a bulbous tip crowned with sharp bony spikes, ");
	outputText("akin to those that nearly hit you earlier. She smirks sadistically, dropping down on all fours to point her tail at you.");
	outputText("\n\nYou're under attack by a Manticore!");
	if (flags[kFLAGS.CODEX_ENTRY_MANTICORES] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_MANTICORES] = 1;
		outputText("\n\n<b>New codex entry unlocked: Manticore!</b>")
	}
	startCombat(new Etna());
	doNext(playerMenu);
}

public function repeatEnc():void
{
	clearOutput();
	outputText("You take a stroll in the mountain area when a spike passes a few inches away from your side.\n\n");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
	else outputText("The manticore");
	outputText(" moves out of the shadow of a nearby cave, adopting a predatory stance. \"<i>Why won't you just stay still and get shot like everyone else? Well whatever! I’m gonna ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2) outputText("make you mine whether you like it or not!</i>\"");
	else outputText("take my time toying with you once I've poisoned you into a good fuckpet.</i>\"");
	outputText("\n\nYou're under attack by ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
	else outputText("a manticore");
	outputText(" again!");
	startCombat(new Etna());
	doNext(playerMenu);
}

public function repeatYandereEnc():void
{
	clearOutput();
	outputText("You take a stroll in the area when a spike passes a few inches away from your side.\n\n");
	outputText("Etna surge out of nowhere, adopting a predatory stance. \"<i>Why won't you just stay still and get shot like everyone else? Well whatever! I’m gonna make you mine whether you like it or not!</i>\"\n\n");
	outputText("You're under attack by Etna again!");
	startCombat(new Etna());
	doNext(playerMenu);
}

public function etnaRapesPlayer():void
{
	clearOutput();
	etnaRapesPlayer2();
}
public function etnaRapesPlayer2():void
{
	//Males and Herms
	if (player.hasCock()) {
		outputText("You fall down defeated and the manticore advances towards you with a sadistic glee: \"<i>So that's all? I guess dinner is served, then.</i>\" She kicks you in the face making you roll on your back. You're still seeing stars as you feel her feet brutally stepping on your crotch the touch for some reason arousing you. \"<i>Oh? So someone likes being brutalised, huh? You sure are a complete sicko and that's exactly how I like it.</i>\" Her toe plays with your dick, molesting you through the fabric of your clothes and, against your better judgement, you moan from this, amusing her further. \"<i>Aren't you pathetic? Are you seriously getting off from being stepped on?!</i>\"");
		outputText("She proceeds to sit on your leg and holds your arms to the ground with her powerful paws. She looks terrifying as she towers over you and you can’t help but gulp as she moves her tail towards your body.\n\n");
		outputText("She stings you and you feel all your resistance go away as you don't even have the energy to move. Your penis grows erect as if all of your blood is being concentrated into it. She forcefully strips you and eyes your now painfully erect cock, licking her lips. To your horror, you see her tail tip open into a flower-like shape, except the inside of her ‘flower’ looks like a nightmarish fleshy hole constantly drooling god knows what. She forcefully shoves her tail on your mouth, commanding you to lick it. You try to refuse, but she scratches your chest with her claw, leaving bleeding marks to make her statement.\n\n");
		outputText("You obey, too terrified of her to refuse and she nearly chokes you in the process. Still, the venom in your body is driving you mad with lust and soon you're willingly eating her out, making her coo with pleasure. \"<i>Aah! Are you getting off from being dominated? Or maybe you were born to eat pussy. What kind of trash are you? I bet you’re so horny now, you'd even fuck a pile of poo if there was a hole in it.</i>\"\n\n");
		outputText("Overwhelmed by your lust, you nod to her every word. You only want her to make you cum so you can finally get this massive erection of yours to calm down.\n\n");
		outputText("\"<i>Well, aren't you in luck, you perverted masochist. I will grant you exactly what you want.</i>\" She removes her tail from your mouth leaving you dazed and pulls it over your dick. \"<i>Beg!... Beg me to get you off, you disgusting piece of shit!</i>\"\n\n");
		outputText("Yes! Yes, anything she says, as long as she grant you release. She rewards you by engulfing your entire length inside her tail and soon you feel her walls milking you and sucking you in. You cum almost instantly from this, but she smirks cruelly as she pulls a spike out of her tail and impales your leg with it. You feel a dam break in your manly parts as cum start to flow freely, forcing you into a state of constant orgasm. The sensation is so strong that your eyes roll into the back of your head as your body  spasms from the overload of cum flowing out of your cock. All the while, your tormenter softly sings into your ears as she drinks your cum. ");
		outputText("She impales you as soon as you start going flaccid, keeping you erect and laughing as you beg for her to stop. After an hour of this terrible treatment, you black out.\n\n");
		outputText("You wake up, your groin feeling as though it had been in a fire. After a few hours the pain fades and you're able to stand again. For some weird reason, the manticore didn't steal any of your gems.");
		player.orgasm();
		cleanupAfterCombat();
		return;
	}
	//Females
	else {
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 2) {
			outputText("You fall down to the ground as ");
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("the manticore");
			outputText(" looks at you amused, then utterly disappointed. \"<i>Wait, what? You don't even have a penis? Is this some kind of joke?</i>\"\n\n");
			outputText("You’re a girl, of course you don't have a penis. Does she expect every single woman on Mareth to be a herm or something?\n\n");
			outputText("\"<i>Well that doesn't matter, I’ll still take my tribute.</i>\"\n\n");
		}
		else {
			outputText("You fall to the ground as ");
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("the manticore");
			outputText(" give you a wide grin.\n\n");
			outputText("\"<i>You know how it works already lass. You lose I get to rape you so get to work!</i>\"\n\n");
		}
		outputText("You give her a cold stare and she smirks in response. \"<i>Now that's the kind of attitude a real woman should have! Defiant to the bitter end. I think I will reward you properly for this.</i>\"\n\n");
		outputText("You get the feeling you won't like what she has in store for you. She forcefully pushes you down, back against the ground as she starts kissing you. She's actually good at it and you are so distracted that you barely register when she slowly removes your clothes. She finally breaks the kiss, a strand of saliva still linking your mouth, and you realise that you are completely naked.\n\n");
		outputText("\"<i>As the winner, I get to choose what I’ll do with you... I want you to lick my tail, or rather the inside of my tail. I trust that you are smart enough not to refuse.</i>\" She pulls her tail and its spiked bulb-like tip open before your eyes into a flower-like vagina. She shoves it towards your mouth and, taking the hint, you lick the inside with your tongue, making her moan appreciatively. She go on like this for a minute or two almost choking you in the process. Then her tail gushes something that could be described as girlcum. It leaves a cinnamony aftertaste.\n\n");
		outputText("\"<i>And now for your reward...</i>\"\n\n");
		outputText("She forcefully opens your mouth and pulls her tail over it, letting drops of her potent venom fall in. Soon you're losing control as the aphrodisiac increasingly breaks your resolve...\n\n");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
		else outputText("The manticore");
		outputText(" moves her tail away smirking. \"<i>You look so much better now look at that enchanting face you're making. How about if we get each other off for a while. I bet you're totally in the mood for it.</i>\"\n\n");
		outputText("Unable to maintain control of your rampaging lust anymore, you kiss her seeking her tongue as you grab her cushiony tits and start to grope them. ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
		else outputText("The manticore");
		outputText(" moan in appreciation and return the favor, locking the pair of you in a debased grappling contest. After a while ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
		else outputText("the manticore");
		outputText(" breast starts to leak some milk and you move down to lick the drops as she finger you barely soothing the blazing furnace your pussy turned into. Every single stimulation is driving you completely nuts and the fact her tail repeatedly sting you every now and then does not help your frenzy to die down as your mad pussy drench the ground with fluids.\n\n");
		outputText("The following hours turn into what could only be described as mind blowing sexual debauchery, as the aphrodisiac turns you into a sex-starved beast. You finally pass out from exhaustion after an incalculable amount of orgasms.");
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 2;
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] == 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 3;
		player.orgasm();
		cleanupAfterCombat();
		return;
	}
}

public function etnaRapeIntro():void
{
	clearOutput();
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
	else outputText("The manticore");
	outputText(" is laying on the ground ");
	if (monster.HP < 1)outputText("defeated");
	else outputText("too horny to fight back");
	outputText(". She looks at you with a hopeful expression as she holds her tail with one hand. \"<i>So strong... so powerful! If you would only let me taste you I promise I will make it feel sooooo good.</i>\"\n\n");
	outputText("Do you grant her request?");
	menu();
	if (player.lust >= 33 && player.hasCock()) addButton(0, "Yes (M)", etnaRapeYesM);
	if (player.lust >= 33 && player.hasVagina()) addButton(1, "Yes (F)", etnaRapeYesF);
	addButton(2, "No", etnaRapeNo);
}

public function etnaRapeYesM():void
{
	clearOutput();
	outputText("You proceed to undress with deliberate slowness, presenting your penis to ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
	else outputText("the manticore");
	outputText(", who is almost shaking out of control as she eyes it.\n\n");
	outputText("To tease her, you slap her in the face with your dick, to which she responds like a kitty cat, trying to grab it with both paws. You dick slap her a few times, until she finally grabs your cock with her furry hands, trying to hold it still. She reminds you of one of the house cats back home, when you teased them with a cotton stick. She starts by slowly licking your dick with her tongue, carefully lubricating the entire length. She really does lick like a cat, and the hooks on her tongue drag pleasurably along the skin of your dick. Idly, you wonder if ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
	else outputText("the manticore");
	outputText(" likes milk.\n\n");
	outputText("She cuts your thoughts short as she slides your dick between her large breasts, carefully squishing them together with her paws. You moan at the cat girl’s ministration as she proceeds to pump your dick up and down with her breasts, still licking your tip. Her titfuck feels wonderful and the way she licks your tip is clearly that of an expert whore, heck maybe even succubi aren’t this talented.\n\n");
	outputText("Soon you can’t hold it any longer and paint her entire face with your man milk, to which she answers by methodically licking the cum clean like a cat drinking milk. Her expression and the way she grooms her paws licking them clean of your cum with a sensual \"<i>Nyaaaaaa</i>\" is so cute you idly ponder if she’s more cat than human.\n\n");
	outputText("Having taken your tribute you dismiss her and proceed to head back to camp.");
	etnaAffection(10);
	player.orgasm();
	cleanupAfterCombat();
}

public function etnaRapeYesF():void
{
	clearOutput();
	etnaRapeYesF2();
}
public function etnaRapeYesF2():void
{
	outputText("You slowly remove any impeding equipment as you order the girl to make you feel good, double time! She does so and soon her entire tongue length is fully in your pussy, licking in a way reminiscent of a cat grooming her kitten as you sixtynine her. You moan appreciatively and to reward the slut for her efforts you finger her in return. ");
	if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) outputText("Her tail tip suddenly opens to reveal what looks like a dripping pussy and to drive her even crazier you take it upon yourself to insert your entire fist inside.\n\n");
	else {
		outputText("Her tail pussy blossoms out of her arousal and you insert your entire fist inside to help increase her stimulation. ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
		else outputText("the manticore");
		outputText(" react as expected as her tail clench on your fist and her entire body quake from your double ministration. ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
		else outputText("the manticore");
		outputText(" tail is already gushing fluids everywhere but you decide to take it one step further and increase the tempo as well as her torment.\n\n");
	}
	outputText("Soon ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
	else outputText("the manticore");
	outputText(" is begging for you to stop but you deny her, knowing quite well she would have done to you the same thing had your roles been reversed. She moans what sounds like musical notes as she orgasms one time after another. Soon your own orgasm starts and you both are singing in a perfect chorus of moans.\n\n");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
	else outputText("The manticore");
	outputText(" blacks out from the overstimulation and you proceed to redress and head back to camp satisfied.");
	if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 1;
	if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] == 2) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 3;
	etnaAffection(10);
	player.orgasm();
	cleanupAfterCombat();
}

public function etnaRapeNo():void
{
	clearOutput();
	outputText("You decline and proceed to walk away back to your camp but she holds you back handing over what looks to be a vial. \"<i>Take this. I think you should have it. Be careful. It's quite a strong drink.</i>\"");
	etnaAffection(10);
	cleanupAfterCombat();
}

public function etnaRape3rdWin():void
{
	clearOutput();
	outputText("She falls on the ground eyeing you with surprise. \"<i>Whoa, you're a tough one, aren't you? Each time I try and get you on my dinner plate, you appear on top instead of on the bottom.</i>\" She dusts herself off a little, somewhat amused. \"<i>My name is Etna. I think you ought to know it now since you've defeated me a few times. I must admit that I’m somewhat interested in you now. Anyway you have won yet again and therefore you get to do whatever you want with me. So... what will it be?</i>\"\n\n");
	outputText("Do you rape her?");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 1) flags[kFLAGS.ETNA_TALKED_ABOUT_HER] = 1;
	menu();
	if (player.lust >= 33 && player.hasCock()) addButton(0, "Yes (M)", etnaRapeYesM);
	if (player.lust >= 33 && player.hasVagina()) addButton(1, "Yes (F)", etnaRapeYesF);
	addButton(2, "No", etnaRapeNo);
}

public function etnaReady2Come2Camp():void
{
	clearOutput();
	outputText("Etna falls to the ground defeated yet again her expression of desire and admiration obvious. This time however she swoons on you making her intentions clear.\n\n");
	outputText("\"<i>You're stronger than I am in so many ways, that I can barely hold in my desire... Would you please accept me as your lover? I could join your pride, if you would please allow me to.</i>\"\n\n");
	outputText("Wait did she literally just ask to be part of your harem or something?\n\n");
	outputText("\"<i>It's not something I ask lightly, nya, but my nature forces me to bow down to the strong. You have clearly tamed my wild heart, so will you take me back home as your prize?</i>\"\n\n\n\n");
	menu();
	addButton(0, "Yes", etnaRapesYesCome2Camp);
	addButton(1, "No", etnaRapeNoCamp);
}

private function etnaRapesYesCome2Camp():void
{
	clearOutput();
	flags[kFLAGS.ETNA_FOLLOWER] = 1;
	if (player.hasCock()) {
		outputText("You proceed to undress with deliberate slowness, presenting your penis to Etna, who is almost shaking out of control as she eyes it.\n\n");
		outputText("To tease her, you slap her in the face with your dick, to which she responds like a kitty cat, trying to grab it with both paws. You dick slap her a few times, until she finally grabs your cock with her furry hands, trying to hold it still. She reminds you of one of the house cats back home, when you teased them with a cotton stick. She starts by slowly licking your dick with her tongue, carefully lubricating the entire length. She really does lick like a cat, and the hooks on her tongue drag pleasurably along the skin of your dick. Idly, you wonder if Etna likes milk.\n\n");
		outputText("She cuts your thoughts short as she slides your dick between her large breasts, carefully squishing them together with her paws. You moan at the cat girl’s ministration as she proceeds to pump your dick up and down with her breasts, still licking your tip. Her titfuck feels wonderful and the way she licks your tip is clearly that of an expert whore, heck maybe even succubi aren’t this talented.\n\n");
		outputText("Soon you can’t hold it any longer and paint her entire face with your man milk, to which she answers by methodically licking the cum clean like a cat drinking milk. Her expression and the way she grooms her paws licking them clean of your cum with a sensual \"<i>Nyaaaaaa</i>\" is so cute you idly ponder if she’s more cat than human.\n\n");
		outputText("Having taken your tribute you dismiss her and proceed to head back to camp.");
	}
	if (player.hasVagina()) {
		outputText("You slowly remove any impeding equipment as you order the girl to make you feel good, double time! She does so and soon her entire tongue length is fully in your pussy, licking in a way reminiscent of a cat grooming her kitten. You moan appreciatively and to reward the slut for her efforts you finger her in return. ");
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) outputText("Her tail tip suddenly opens to reveal what looks like a dripping pussy and to drive her even crazier you take it upon yourself to insert your entire fist inside.\n\n");
		else outputText("Her tail pussy blossoms out of her arousal and you insert your entire fist inside to help increase her stimulation.\n\n");
		outputText("Soon Etna is begging for you to stop but you deny her, knowing quite well she would have done to you the same thing had your roles been reversed. She moans what sounds like musical notes as she orgasms one time after another. Soon your own orgasm starts and you both are singing in a perfect chorus of moans.\n\n");
		outputText("Etna blacks out from the overstimulation and you proceed to redress and head back to camp satisfied.");
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] ++;
	}
	etnaAffection(30);
	player.orgasm();
	cleanupAfterCombat();
	doNext(etnaCome2Camp);
}

private function etnaCome2Camp():void
{
	clearOutput();
	outputText("As you enter the camp with the manticore your various friends notice her and jump out of their activities to go to the pair of you.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("Rathazul almost drops a vial of purple liquid on the ground as he notices the manticore. \"<i>Is this what I think it is? Manticore venom is extremely potent. I could use it in alchemical concoctions, nice find! Just make sure to keep her in check...</i>\"\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
		outputText("Jojo notices the manticore right away breaking into a defensive stance and reciting a few of his teachers mantra. \"<i>[name] that thing is a manticore! I seriously hope you know what you're doing. She reeks of serious demonic corruption, so make sure you meditate with me regularly.</i>\"\n\n");
		outputText("You assure Jojo that you will and that Etna won't cause problems.\n\n");
	}
	if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0) outputText("Amily sees the manticore and pulls out her blow pipe. \"<i>A manticore, here?! This is a catastrophe! You need to keep it out of the camp! I bet she’s fully corrupted and will rape anyone given the chance.</i>\" You tell Amily that Etna isn’t dangerous and won't harm anyone, however the mouse remains wary of the manticore, even going as far as staying several meters away from her at all times. Maybe this is some kind of mouse versus cat relation problem, go figure.\n\n");
	if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		outputText("Sophie flies down and lands right in front of Etna. As they glare at each other you get the feeling that they already know each other, and judging by the looks on their faces, neither is happy about the other being there...\n\n");
		outputText("\"<i>Damned cat, figures that you would try stealing [name] from me. You're here only to slake your endless thirst, aren’t you?</i>\"\n\n");
		outputText("Etna replies smirking. \"<i>So what, you milfy bird? It’s not like you need more of [name]’s affection after your hundredth kid! Heck, I'm surprised a slut like you hasn’t already taken a permanent mate or maybe, you just don't consider men as such?</i>\" It takes everything you have to prevent Sophie and Etna from fighting, but you eventually manage to calm them down and force them to make peace. Sophie begrudgingly shakes hands with Etna but you’re quite aware the odds of them becoming friends is quite slim.\n\n");
	}
	outputText("Her examination of your camp done, Etna proceed to make herself comfortable and settle down.\n\n");
	outputText("(<b>Etna has been added to the Lovers menu!</b>)\n\n");
	flags[kFLAGS.ETNA_FOLLOWER] = 2;
	flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] = 0;
	doNext(playerMenu);
}

public function etnaRapeNoCamp():void
{
	clearOutput();
	outputText("While the manticore’s feelings toward you are sincere, this is all too fast for you and you tell her so. \"<i>It's all fine... I’ll keep ambushing you until you finally say yes or I lose interest.</i>\" She jumps off a nearby rock and takes flight. \"<i>I <b>will</b> have your heart one way or another so watch your back out there because you will never know when or where I'll strike next.</i>\"\n\n");
	outputText("You leave, heading back towards your camp. Just what did you get yourself into?");
	etnaAffection(-30);
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 2) flags[kFLAGS.ETNA_TALKED_ABOUT_HER] = 2;
	cleanupAfterCombat();
}

public function etnaRapeYandere():void
{
	clearOutput();
	outputText("Defeated, you barely register as Etna joyfully takes a nearby rock and knocks it against your head making you lose consciousness.\n\n");
	outputText("You wake up in what looks like a dark room underground. The only source of light is a candle on a table in the corner. To your surprise it's filled with various sex toys and drawings and paintings featuring you, this is getting creepier by the second.\n\n");
	outputText("\"<i>Slept well love? I couldn't stand you saying no when your eyes were clearly saying yes so I brought you here in order to help you become more honest with yourself. I know you love me and I will never let you leave me again, <b>we will</b> be together forever. You love me don’t you? <b>DON’T YOU</b>?</i>\"\n\n");
	outputText("You see a pair of red cat pupils glowing in the dark to your right... She’s in there with you and she’s clearly going to give you a run for your money if you don’t escape this deathtrap. You try to stand up and run but to your horror you discover she tied you up to a chair. You’re utterly powerless!\n\n");
	outputText("Etna doesn’t give you any time to think it over, as she proceeds to approach you, holding one of her spikes like a dagger, and impales your legs and arms no less than six times causing blood to splatter on her, but mainly filling you to the brim with aphrodisiac. She then gives you a potion to close your wounds.\n\n");
	outputText("\"<i>Ahhh i'm covered with [name]’s blood! This is such a wonderful feeling, I will never ever wash again!</i>\" She’s giving you a creepy blissful stare as she toss away the spike and pounce on you. \"<i>Be mine [name]!</i>\"\n\n");
	player.tou -= 5;
	statScreenRefresh();
	etnaRapesPlayer();
	if (player.tou >= 30) {
		outputText("Thankfully, you wake up before Etna does and use the spike left on the ground to free yourself. Once done, you proceed to exit the place through a trap door and head back to camp before the love crazed manticore notices you’ve escaped.\n\n");
		player.orgasm();
		cleanupAfterCombat();
		return;
	}
	else etnaRapeYandereBadEnd();
}

public function etnaRapeYandereBadEnd():void
{
	outputText("Too weak to fight or crawl your way out, you stay on the ground at the mercy of Etna. Maybe it isn’t such a bad thing. After all, she clearly loves you and if she is willing to go this far to keep you next to her, there isn’t much you can do about it. Etna will never let you leave the cave ever again and, as such, you give up on your quest in order to live with your somewhat obsessed lover. ");
	if(player.hasStatusEffect(StatusEffects.CampMarble)) outputText("Marble comes looking for you before long, but, instead of freeing you, she decides to help the manticore to hold you there for your own good. ");
	outputText("Your adventure seem to have come to an end but at least you will live the rest of your life showered with love.");
	getGame().gameOver();
}

public function etnaRapeIntro2():void
{
	clearOutput();
	outputText("Etna is laying on the ground ");
	if (monster.HP < 1)outputText("defeated");
	else outputText("too horny to fight back");
	outputText(". She looks at you with a hopeful expression as she holds her tail with one hand. \"<i>So strong... so powerful! If you would only let me taste you I promise I will make it feel sooooo good.</i>\"\n\n");
	outputText("Do you grant her request?");
	menu();
	if (player.lust >= 33 && player.hasCock()) addButton(0, "Yes (M)", etnaRapeYesM);
	if (player.lust >= 33 && player.hasVagina()) addButton(1, "Yes (F)", etnaRapeYesF);
	addButton(2, "No", etnaRapeNo);
}

public function etnaCampMenu():void
{
	clearOutput();
	outputText("As you approach Etna’s rug, she stretches on all fours, giving you a hopeful expression as she notices you’re walking towards her. \"<i>Nya, great day lover. Are you here to have some fun with your pet catgirl? Or do you just want to talk with me? I must admit, my tail is itching, you already know how hungry I am.</i>\" She gives you a naughty expression that tells everything.");
	menu();
	addButton(0, "Appearance", etnaAppearance, null, null, null, "Examine Etna's detailed appearance.");
	addButton(1, "Talk", etnaTalkMenu, null, null, null, "Ask Etna about something.");
	addButton(2, "Sex", etnaSexMenu, null, null, null, "Have some sex with Etna");
	if (flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] > 0) addButtonDisabled(3, "Req. Venom", "You already asked her for a vial today.");
	else addButton(3, "Req. Venom", etnaDailyVenomVial, null, null, null, "Ask Etna for a vial of her venom.");
	addButton(4, "Spar", etnaSparsWithPC, null, null, null, "Ask Etna for a mock battle with sex for the winner.");
	addButton(14, "Back", camp.campLoversMenu);
}

public function etnaAppearance():void
{
	clearOutput();
	outputText("Etna is a manticore. Her flowing, red hair is tied up in a spiky ponytail, which only accentuates her wild appearance. Her red, catlike pupils always spark maliciously like she was planning something and her not-so-innocent cat toothed smirk only serves to make her look all the more the naughtier. Her lion ears are alert to sound, twitching as she hears you approaching. Currently, she is laying down on her carpet in a position quite reminiscent of a classic housecat.\n\n");
	outputText("Her arms and legs end in powerful, feline paws, allowing her to move either on two or four legs. The bluish-black fur on her limbs climbs up to the middle of her thigh and shoulders turning white at the tip and contrasting with her light skin. Funnily, despite their feral appearance her hands armed with claws can hold and manipulate objects like humans hand would including of course a mans pole. Her neck is hidden by a fluffy collar of white fur not unlike that of a lion. ");
	outputText("The comparison to a lion ends there as a pair of large bat like wings that can stretch up to 13 feet wide rest on her shoulders. From her well shaped ass surges a scorpion like tail covered in armor like chitin. At her tail tip is a large bulb covered with venomous spikes from which venom drips of. She can open her tail tip at will which expands into a star shaped tail pussy of accommodating size always ready to devour a man’s tool and constantly drooling with moisture.\n\n");
	outputText("As her nature of a sexual predator would tell, she is endowed with a pair of pert breasts easily reaching E cup and her perfect hourglass shape could make many succubus jealous.\n\n");
	outputText("Her main pussy, funnily enough, is the only thing about her that doesn’t look perpetually ready for sex. She likely doesn't use it often.");
	menu();
	addButton(14, "Back", etnaCampMenu);
}

public function etnaTalkMenu():void
{
	clearOutput();
	outputText("Etna yawn and take on an inquisitive pose\n\n");
	outputText("\"<i>Oh so you just wanted to talk? I was sure you would have something funnier in mind but fair enough. What did you want to talk about?</i>\"");
	menu();
	addButton(0, "Her", etnaTalkHer);
	addButton(1, "Manticores", etnaTalkManticores);
	addButton(14, "Back", etnaCampMenu);
}

public function etnaTalkHer():void
{
	clearOutput();
	outputText("You tell Etna you’d like to know more about herself.\n\n");
	outputText("\"<i>Me? Truthfully, my life isn’t as interesting as yours is. I was born in the mountains. My mother and I never saw eye to eye and, since our species is solitary by default, I left on my own and I've been hunting for studs in the region ever since. My mother isn't as romantic as I am and knowing exactly who my father is, out of the gallons of cums she ingests daily, would be difficult. It’s quite likely that my father is one of those supremely endowed minotaur lords. For all I know, she’d get fucked by anything, as long as it has enough cum to satisfy her. She never cared that much about choosing a prime cut male out of the herd of studs she rapes daily.</i>\"\n\n");
	outputText("You ask her what she means by choosing a prime cut male.\n\n");
	outputText("\"<i>Our natural selection means that most manticores will mate in the true sense with only the strongest males, which is why most of us are on the prowl for our entire lives. The number of men strong enough to defeat a manticore in battle is scarce. As for the demons, they make a good meal and are both well endowed and powerful, but they are way too quick to let themselves get sucked off. The same goes for minotaurs nowadays, which is quite a disappointment. So... any other questions?</i>\"\n\n");
	doNext(etnaTalkMenu);
	cheatTime(1/4);
}

public function etnaTalkManticores():void
{
	clearOutput();
	outputText("Ok so she’s a manticore. Is her species some kind of demonic creation?\n\n");
	outputText("\"<i>Not quite. We've been out on the prowl since the early days of Mareth. While the demons can lay claim to being the kings of the jungle right now, we have always been top sexual predators out there.The fact that we are all born females only makes it more important, as our only way to reproduce is through the males of another race. That, and the fact we are spermivores, makes us better at sex, if not twice as lusty, as the standard succubus. It's not just a matter of reproduction or fun but also a question of survival in our case.</i>\"\n\n");
	outputText("What of the demons did their arrivals impact on the manticores way of life at all?\n\n");
	outputText("\"<i>I see where you're getting at. You wonder if I'm actually as corrupt as the cows out there. Well... in a sense, I suppose I am, after all it’s not like we haven't been banging the demons too. Heck, we’ve been banging them so much that to reward our interest into sucking them off, they pretty much gave us a boon so we could suck them even better. Namely this tail pussy that everyone in my race shares. It is our sign of a deal with them. I,  myself, consider it an improvement, as it allows me to consume twice as much cum as I would with my pretty mouth. Is there anything else you want to know?</i>\"\n\n");
	doNext(etnaTalkMenu);
	cheatTime(1/4);
}

public function etnaSexMenu():void
{
	clearOutput();
	outputText("You ask Etna if she’s ready for some fun and she perk up grinning widely.\n\n");
	outputText("\"<i>What did you had in mind lover?</i>\"");
	menu();
	addButton(0, "LetHerBeInCharge", etnaLetHerBeInCharge);
	if (player.hasVagina()) addButton(1, "BeTopGirl", etnaBeTheTopGirl);
	if (player.hasCock()) addButton(2, "KittyTitFuck", etnaKittyTitFuck);
	if (player.hasCock()) addButton(3, "Pussy Opera", etnaPussyOpera);
	if (player.tailType == 28)  addButton(4, "Share a Drink", etnaShareDrink);
	addButton(14, "Back", etnaCampMenu);
}

public function etnaLetHerBeInCharge():void
{
	clearOutput();
	outputText("You admit that you miss her somewhat dominant attitude at times and ask her if she’s up for some extreme roleplay, pretending to just have lost to the oh so mighty manticore.\n\n");
	etnaRapesPlayer2();
}

public function etnaBeTheTopGirl():void
{
	clearOutput();
	outputText("You growl playfully into her ear, asserting your dominance over her. Her cat-like instincts take over and she rolls over, a mock defeated expression on her face.\n\n");
	etnaRapeYesF2();
}

public function etnaKittyTitFuck():void
{
	clearOutput();
	etnaRapeYesM();
}

public function etnaPussyOpera():void
{
	clearOutput();
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 3) {
		outputText("You ask Etna if she feels like trying something different for once. She look at you inquisitively until you point the somewhat very obvious hole between her legs. To your surprise, she blushes and hides it with both paws. You ask her how she can be shy about using her main pussy, after all, she has been basically fucking you for weeks now.\n\n");
		outputText("\"<i>That's not the same thing at all! While my tail does feel like a pussy, there is a very large difference between feeding and having true sex; pregnancy and well... the other things that are part of it. I'm a virgin and, unlike you, I’ve been saving myself up.</i>\"\n\n");
		outputText("Well... that's something new. You're surprised a crazed nymphomaniac like her could actually be a virgin, let alone shy about having normal sex.\n\n");
		outputText("\"<i>Look, feeding is something that is necessary for us to survive, but just because we feed casually, doesn’t mean we give out our virginities quite so easily. However, I’ve been around you long enough to know what I want… If you will have me, I will offer myself to you earnestly. Still, I don’t feel myself to be ready for kids, so I will wait until I feel I am ready.</i>\"\n\n");
	}
	else {
		outputText("She fawns on you smiling. \"<i>I’m still not sure about kittens, but sure! I wouldn’t mind doing that again.</i>\"\n\n");
	}
	outputText("Etna makes an inviting pose on the ground, displaying her body as she offers herself up to you, keeping her tail in check for once.. You proceed to strip down and join her on the provisory couch. Etna is acting like a shy girl who has never had sex in her life, which is awkward. Still, considering the fact she has only been using her mouth and tail so far, it's to be expected that she would lack experience with her true vagina. You take the lead, slowly teasing her entrance passage with your [cock]. She moans, delighted at your ministration, her pussy moistening almost instantly.\n\n");
	outputText("\"<i>I’m still not sure about kittens, but sure! I wouldn’t mind doing that again.</i>\"\n\n");
	outputText("If she enjoys it that much when you're not even in, you wonder how she will react when your rod fully penetrates her.\n\n");
	outputText("You tease her for a few minute making her moan continually then proceed to insert it entirely making her \"<i>Eeep!</i>\" in surprise. You slowly ease yourself in, until you hear the manticore starting to… sing? She’s literally moaning you a full blown opera as you fuck her. Her sensitivity must be off the charts as her vaginal walls convulse around your cock, gripping it like a vice, almost as if she was constantly orgasming and the way she moans can attest to that. However, you’ve barely gotten started and the short fuse of your partner won’t change anything about it. ");
	outputText("You slowly piston in and out, trying to drive the best notes out of her as she weaves you an orgasmic symphony. Her tail seems to react in tandem with her main hole, considering the constant gushes of fluids onto the ground, which creates a small pool of girlcum underneath it. It thrashes wildly, in accordance to her orgasm, barely missing you several times, despite your best attempts to avoid it.\n\n");
	outputText("You get one final, booming note out of her as you paint her insides white. Her tail jerks once more as Etna is rocked by a final orgasm and girlcum rains down upon the both of you as she shoots upward. Etna slowly crawls away on the ground, looking extremely exhausted. \"<i>That was... something else... I'll take the herb for a few days now... looking forward to that again.</i>\"\n\n");
	outputText("You give her a gentle kiss before leaving to clean yourself and give her a chance to recover.");
	player.orgasm();
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 3) flags[kFLAGS.ETNA_TALKED_ABOUT_HER] = 3;
	doNext(camp.returnToCampUseOneHour);
}

public function etnaShareDrink():void
{
	clearOutput();
	outputText("You casually ask what manticore tails can do beside drinking on cum.\n\n");
	outputText("\"<i>Well... not many things it's not like it’s extremely strong or heavy either but there's a few more... kinky application to it. Care to have a drink?</i>\"\n\n");
	outputText("Now that's something you're very intrigued about and when you see your friend pull out a pair of very large straw out of a bag and get a large barrel filled to the brim with a somewhat milky substance there's little question as to what she has in mind.\n\n");
	outputText("\"<i>Ok hold your tail upward just like this. Yea that’s it. I'll put a straw in yours, you get the one in mine.</i>\"\n\n");
	outputText("You only understand what she meant by having a drink once she pours the barrel into both of your tails. Wow, your tail walls stretches magnificently, filled to the brim with fluid. Taking a taste of it in your pussy, you figure exactly what you're filled with. That’s minotaur cum in it's rawest form, almost fresh from the tap! You smile lustfully as you proceed to drink from your lover’s pussy, just as she does the same with your’s.Unsurprisingly, minotaur cum tastes wonderful and provides you with a spike in energy as your body metabolise it into food.\n\n");
	outputText("The two of you make wet slurping sounds for several minutes, drinking from each other’s pussy. It's a fun bonding experience as you not only taste the minotaur cum, but also a delicious cocktail of Etna’s own pussy juice mixed in with it. It’s likely that she is tasting you as well and from the face she's making you gather that you don't taste half bad. Deciding to add some extra flavor you grab one of her supple breast and tweak it playfully until milks dripple out into your waiting tail. Etna seems to like the idea too and toys with your breast until some milk dribble into her tail. ");
	outputText("After several minutes, the both of you are done and there's no cum left. You lay down next to Etna for a moment, enjoying the afterglow of your shared dinner. That was quite a good meal and seeing as she has several barrel of this which she seems to replenish daily you like the idea of doing this again. You head back to your tent most satisfied.");
	doNext(camp.returnToCampUseOneHour);
}

public function etnaDailyVenomVial():void
{
	clearOutput();
	outputText("You ask her if she wouldn’t mind providing you a bottle of her venom. She pulls her tail over a vial, let it drip for a minute then give you the liquid.\n\n");
	outputText("\"<i>Here. Handle it with care, it takes a lot out of me in order to produce this.</i>\"\n\n");
	flags[kFLAGS.ETNA_DAILY_VENOM_VIAL]++;
	inventory.takeItem(consumables.MANTICV, etnaCampMenu);
	cheatTime(1/4);
}

public function etnaSparsWithPC():void
{
	clearOutput();
	outputText("You ask Etna for a mock battle with sex for the winner. With a confident smile, she agrees.\n\n");
	outputText("\"<i>I have been training since. You better be ready or I will be the one on top.</i>\"");
	startCombat(new Etna());
}

	}

}