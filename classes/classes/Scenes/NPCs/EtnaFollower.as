/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.HighMountains.MinotaurMob;
import classes.Scenes.Monsters.Manticore;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

public class EtnaFollower extends NPCAwareContent implements TimeAwareInterface, SaveableState
{

	public static var EtnaHunting:Boolean;
	public static var EtnaInfidelity:int;	//0 = not yet happened, 1 = pc accept, 2 = pc reject, 3 = pc feeds her
	public static var EtnaFertile:Boolean;
	public static var EtnaJumpedToday:Boolean;

	public function stateObjectName():String {
		return "EtnaFollower";
	}

	public function resetState():void {
		EtnaHunting = false;
		EtnaInfidelity = 0;
		EtnaFertile = false;
		EtnaJumpedToday = false;
	}

	public function saveToObject():Object {
		return {
			"EtnaHunting": EtnaHunting,
			"EtnaInfidelity": EtnaInfidelity,
			"EtnaFertile": EtnaFertile,
			"EtnaJumpedToday": EtnaJumpedToday
		};
	}

	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			EtnaHunting = o["EtnaHunting"];
			EtnaInfidelity = o["EtnaInfidelity"];
			EtnaFertile = o["EtnaFertile"];
			EtnaJumpedToday = o["EtnaJumpedToday"];
		} else resetState();
	}

	public var pregnancy:PregnancyStore;

	public function timeChange():Boolean {
		var needNext:Boolean = false;
		if (model.time.hours == 6) EtnaJumpedToday = false;
		pregnancy.pregnancyAdvance();
		if (pregnancy.isPregnant && etnaPregUpdate()) needNext = true;
		if (EtnaHunting && (player.hasCock() || player.hasKeyItem("Demonic Strap-On") > 0)) {
			outputText("\n<b>Having learned that you can produce cum again Etna stopped hunting!</b>\n");
			EtnaHunting = false;
			needNext = true;
		}
		return needNext;
	}

	public function timeChangeLarge():Boolean {
		if (pregnancy.isPregnant && pregnancy.incubation == 0) {
			etnaGivesBirth();
			pregnancy.knockUpForce(); //Clear Pregnancy
			return true;
		}
		if (!EtnaJumpedToday && flags[kFLAGS.SLEEP_WITH] != "Etna" && EtnaInfidelity == 3 && rand(5) == 0) {
			etnaJumpsPCinCamp();
			return true;
		}
		return false;
	}

	public function EtnaFollower()
	{
		pregnancy = new PregnancyStore(kFLAGS.ETNA_PREGNANCY_TYPE, kFLAGS.ETNA_INCUBATION, 0, 0);
		pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 280, 220, 160, 60);
		EventParser.timeAwareClassAdd(this);
		Saves.registerSaveableState(this);
	}

//flag ETNA_TALKED_ABOUT_HER: 0 - not know her name, 1 - know her name, 2 - Etna in Yandere mode, 3 - pussy opera first time scene variant seen

public function etnaAffection(changes:Number = 0):Number
{
	flags[kFLAGS.ETNA_AFFECTION] += changes;
	if (flags[kFLAGS.ETNA_AFFECTION] > 100) flags[kFLAGS.ETNA_AFFECTION] = 100;
	return flags[kFLAGS.ETNA_AFFECTION];
}

public function firstEnc():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("You casually take a stroll in the mountains, passing through a tunnel. Weirdly, in the middle of the tunnel you find several unconscious minotaurs. You examine them and discover they all fainted from... sexual exhaustion? Out of nowhere, something scrapes your skin, missing you by a mere inch. You look down to see what looks like a bony spike burrowed in the ground a few feet ahead of you. A menacing growl echoes in the tunnel as another spike flies right by you, barely missing your arm this time. Figuring you've been ambushed, you run to the other end to confront your invisible assailant in broad daylight. ");
	outputText("As soon as you're out, your opponent surges after you. At first glance it looks like a catgirl, however, the shape of her paws and ears hint at being more like a lion’s, especially with the large mane around her neck. She could pass for having a human face if not for her malicious red, cat-like eyes and sharp canines. The comparison to a cat ends there, due to the pair of large leathery wings that rest on her back. Where you would have expected a cat tail, a scorpion-like chitin covered tail grows. It ends in a bulbous tip crowned with sharp bony spikes, akin to those that nearly hit you earlier. She smirks sadistically, dropping down on all fours to point her tail at you.");
	outputText("\n\nYou're under attack by a Manticore!");
	camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_MANTICORES);
	startCombat(new Etna());
	doNext(playerMenu);
}

public function repeatEnc():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	if (player.isRace(Races.MANTICORE, 1, false)) {
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) {
			outputText("You take a stroll in the mountain area when a spike passes a few inches away from your side.\n\n");
			outputText("Etna moves out of the shadow of a nearby cave, adopting a combat stance. Seems you actually threaded on her hunting grounds. She makes a playful growl before calling to you.\n\n");
			outputText("\"<i>Well hello there, [name]. Seems you stepped in my territory yet again. As rival huntresses, it is only proper that we fight for who’s going to rape who dont you think?\"</i>\"\n\n");
			outputText("Well, now, if she wants to show she’s the top female around, let her come. You’re going to use her pretty mouth as your personal ride today.\n\n");
			outputText("\"<i>Oh I have doubts about that. Hope you’re good at licking [name], because your going bottom!</i>\"\n\n");
			outputText("Guess there's no avoiding it, you're catfighting with Etna again!");
		}
		else {
			outputText("You take a stroll in the mountain area when a spike passes a few inches away from your side.\n\n");
			outputText("The manticore moves out of the shadow of a nearby cave, adopting a combat stance. Seems you actually threaded on her hunting grounds and she’s about to defend it.\n\n");
			outputText("\"<i>Hey you, this is my turf! All the bulls and other cumpumps in the surrounding few hundred miles are mine! Go hunt somewhere else.</i>\"\n\n");
			outputText("Like hell, you would, you hunt wherever you please and minotaurs are prime cut meals only fit for the tail of the strong. There's more than enough studs for the two of you here.\n\n");
			outputText("\"<i>Then we fight for dominance. Hope you’re good at licking cub, because your going bottom!</i>\"\n\n");
			outputText("Guess there's no avoiding it, you're under attack by a manticore again!");
		}
		if (player.hasStatusEffect(StatusEffects.WildManticore)) startCombat(new Manticore());
		else startCombat(new Etna());
		doNext(playerMenu);
	}
	else {
		outputText("You take a stroll in the mountain area when a spike passes a few inches away from your side.\n\n");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("The manticore");
		outputText(" moves out of the shadow of a nearby cave, adopting a predatory stance.\n\n");
		outputText("\"<i>Why won't you just stay still and get shot like everyone else? Well whatever! I’m gonna take my time toying with you once I've poisoned you into a good fuckpet.</i>\"");
		outputText("\n\nYou're under attack by ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("a manticore");
		outputText(" again!");
		if (player.hasStatusEffect(StatusEffects.WildManticore)) startCombat(new Manticore());
		else startCombat(new Etna());
		doNext(playerMenu);
	}
}

public function repeatYandereEnc():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("You take a stroll in the area when a spike passes a few inches away from your side.\n\n");
	outputText("Etna surges out of nowhere, adopting a predatory stance. \"<i>Why won't you just stay still and get shot like everyone else? Well whatever! I’m gonna make you mine whether you like it or not! You can’t run away from love forever [name]!</i>\"\n\n");
	outputText("You're under attack by Etna again!");
	startCombat(new Etna());
	doNext(playerMenu);
}

public function etnaRapesPlayer():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	etnaRapesPlayer2();
}
public function etnaRapesPlayer2():void
{
	if (sceneHunter.uniHerms && player.isHerm()) {
		sceneHunter.selectLossMenu([
				[0, "LetHer", dickF, "Req. a cock", player.hasCock()],
				[1, "Hide", vagF, "Req. a vagina", player.hasVagina()],
			],
			"Though you're obviously getting fucked, you can try to hide your cock from her view. Will you?\n\n"
		);
	} else if (player.hasCock()) dickF();
	else vagF();
	//Males and Herms
	function dickF():void {
		outputText("You fall down, defeated, and the manticore advances towards you with sadistic glee:\n\n\"<i>So that's all? I guess dinner is served, then. You can resist me all you want, it'll only be funnier when you break.</i>\"\n\nShe kicks you in the face making you roll on your back. You're still seeing stars as you feel her feet brutally stepping on your crotch the touch, for some reason, arousing you.\n\n");
		outputText("\"<i>Oh? So someone likes being brutalized, huh? You sure are a complete sicko and that's exactly how I like it.</i>\"\n\nHer toe plays with your [cock], molesting you through the fabric of your clothes and, against your better judgment, you moan from this, amusing her further.\n\n\"<i>Aren't you pathetic? Are you seriously getting off from being stepped on?!</i>\"\n\n");
		outputText("She proceeds to sit on your legs and holds your arms to the ground with her powerful paws. She looks terrifying as she towers over you and you can’t help but gulp as she moves her tail towards your body. She stings you and you feel all your resistance go away as you don't even have the energy to move. However your [cock] grows erect as if all of your blood is being concentrated into it.  She forcefully strips you and eyes your now painfully erect cock, licking her lips. To your horror, you see her tail tip open into a flower-like shape, except the inside of her ‘flower’ looks like a nightmarish fleshy hole constantly drooling god knows what. ");
		outputText("She forcefully shoves her tail on your mouth, commanding you to lick it. You try to refuse, but she scratches your chest with her claw, leaving bleeding marks to make her statement.\n\nYou obey, too terrified of her to refuse and she nearly chokes you in the process. Still, the venom in your body is driving you mad with lust and soon you're willingly eating her out, making her coo with pleasure.\n\n\"<i>Aah! Are you getting off from being dominated? Or maybe you were born to eat pussy. What kind of trash are you? I bet you’re so horny now, you'd even fuck a pile of shit if there was a hole in it.</i>\"\n\n");
		outputText("Overwhelmed by your lust, you nod to her every word. You only want her to make you cum so you can finally get this massive erection of yours to calm down.\n\n");
		outputText("\"<i>Well, aren't you in luck, you perverted masochist. I will grant you exactly what you want.</i>\" She removes her tail from your mouth leaving you dazed and pulls it over your dick. \"<i>Beg!... Beg me to get you off, you disgusting piece of shit!</i>\"\n\n");
		outputText("Yes! Yes, anything she says, as long as she grants you release. She rewards you by engulfing your entire length inside her tail and soon you feel her walls milking you and sucking you in. You cum almost instantly from this, but she smirks cruelly as she pulls a spike out of her tail and impales your leg with it. You feel a dam break in your manly parts as cum starts to flow freely, forcing you into a state of constant orgasm. The sensation is so strong that your eyes roll into the back of your head as your body spasms from the overload of cum flowing out of your [cock]. All the while, your tormenter softly sings into your ears as she drinks your cum. She impales you as soon as you start going flaccid, keeping you erect and laughing as you beg for her to stop. ");
		if (player.cumQ() >= 3000) {
			outputText("Despite the insane load of cum your balls can produce ");
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
			else outputText("the manticore");
			outputText(" simply does not seem to inflate. Considering the fact she can rape an entire party of minotaurs dry you imagine she could drink a pool worth of it and still be thirsty! Though the happy expression on her face tells you she is having an excellent meal. ");
		}
		outputText("After an hour of this terrible treatment, you black out.\n\n");
		outputText("You wake up, your groin feeling as though it had been set on fire. After a few hours, the pain fades and you're able to stand again. Checking on your crotch you realize your balls are churning abnormally fast. The manticore’s venom clearly increased your cum productivity. For some weird reason, the manticore didn't steal any of your gems.");
		if (player.cumQ() < 500) player.cumMultiplier += 6;
		if (player.cumQ() < 2000) player.cumMultiplier += 4;
		if (player.cumQ() < 10000) player.cumMultiplier += 2;
		if (player.cor < 75) dynStats("cor", 25);
		if (player.hasStatusEffect(StatusEffects.WildManticore)) player.removeStatusEffect(StatusEffects.WildManticore);
		player.sexReward("vaginalFluids","Dick");
		cleanupAfterCombatTFEvent();
	}
	//Females
	function vagF():void {
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 2) {
			outputText("You fall down to the ground as ");
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
			else outputText("the manticore");
			outputText(" looks at you amused, then utterly disappointed. \"<i>Wait, what? You don't even have a penis? Is this some kind of joke?</i>\"\n\n");
			outputText("You’re a girl, of course you don't have a penis. Does she expect every single woman on Mareth to be a herm or something?");
			if (silly()) outputText(" Well again the crazy god who created this dimension sure had a futa furry fetish.");
			outputText("\n\n");
			outputText("\"<i>Well that doesn't matter, I’ll still take my tribute.</i>\"\n\n");
		}
		else {
			outputText("You fall to the ground as ");
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
			else outputText("the manticore");
			outputText(" gives you a wide grin.\n\n");
			outputText("\"<i>You know how it works already lass. You lose I get to rape you so get to work!</i>\"\n\n");
		}
		outputText("You give her a cold stare and she smirks in response.\n\n\"<i>Now that's the kind of attitude a real woman should have! Defiant to the bitter end. I think I will reward you properly for this.</i>\"\n\n");
		outputText("You get the feeling you won't like what she has in store for you. She forcefully pushes you down, back against the ground as she starts kissing you. She's actually good at it and you are so distracted that you barely register that she is slowly removing your clothes. She finally breaks the kiss, a strand of saliva still linking your mouth, and you realize that you are completely naked.\n\n");
		outputText("\"<i>As the winner, I get to choose what I’ll do with you... I want you to lick my tail, or rather the inside of my tail. I trust that you are smart enough not to refuse.</i>\"\n\nShe pulls her tail and its spiked bulb-like tip open before your eyes into a flower-like vagina. She shoves it towards your mouth and, taking the hint, you lick the inside with your tongue, making her moan appreciatively. She goes on like this for a minute or two almost choking you in the process. Then her tail gushes something that could be described as girlcum. It leaves a cinnamony aftertaste.\n\n");
		outputText("\"<i>And now for your reward...</i>\"\n\n");
		outputText("She forcefully opens your mouth and pulls her tail over it, letting drops of her potent venom fall in. Soon you're losing control as the aphrodisiac increasingly breaks your resolve and your body begins to change.\n\n");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("The manticore");
		outputText(" moves her tail away smirking.\n\n\"<i>You look so much better now, look at that enchanting face you're making. How about if we get each other off for a while. I bet you're totally in the mood for it.</i>\"\n\n");
		outputText("Unable to maintain control of your rampaging lust anymore, you kiss her seeking her tongue as you grab her cushiony tits and start to grope them. ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("The manticore");
		outputText(" moans in appreciation and return the favor, locking the pair of you in a debased grappling contest. After a while ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("the manticore");
		outputText("'s breasts start to leak some milk and you move down to lick the drops as she fingers you, barely soothing the blazing furnace your pussy turned into. Every single stimulation is driving you completely nuts, and the fact her tail repeatedly stings you every now and then does not help your frenzy to die down as your mad [pussy] drenches the ground with fluids. ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("the manticore");
		outputText(" is hardly satisfied however and shoves her tail pussy on your mouth which only causes you to start licking inside. Soon ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("the manticore");
		outputText(" achieves her own orgasm, splattering your face with her tail juices.\n\n");
		outputText("The following hours turn into what could only be described as mind-blowing sexual debauchery, as the aphrodisiac turns you into a sex-starved beast. You finally pass out from exhaustion after an incalculable amount of orgasms.");
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 2;
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] == 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 3;
		if (player.hasStatusEffect(StatusEffects.WildManticore)) player.removeStatusEffect(StatusEffects.WildManticore);
		player.sexReward("vaginalFluids");
		cleanupAfterCombat();
	}
}

public function etnaRapeIntro():void
{
	clearOutput();
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("The manticore");
	outputText(" is laying on the ground ");
	if (monster.HP < 1)outputText("defeated");
	else outputText("too horny to fight back");
	outputText(". She looks at you with a hopeful expression as she holds her tail with one hand.\n\n\"<i>So strong... so powerful! If you would only let me taste you, I promise I will make it feel sooooo good.</i>\"\n\n");
	if (player.lust < 33) {
		outputText("Sadly, you're not aroused enough to fullfill her wish.");
		doNext(etnaRapeNo);
		return;
	}
	outputText("Do you grant her request?");
	menu();
	addButton(0, "Yes (M)", etnaRapeYesM).disableIf(!player.hasCock(), "Req. a cock!");
	addButton(1, "Yes (F)", etnaRapeYesF).disableIf(!player.hasVagina(), "Req. a vagina!");
	addButton(2, "Fill her up!", EtnaFillHerUp).disableIf(!player.isAlraune(), "Req. to be an alraune.");
	addButton(4, "No", etnaRapeNo);
}

public function etnaRapeYesM():void
{
	clearOutput();
	outputText("You proceed to undress with deliberate slowness, presenting your penis to ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("the manticore");
	outputText(", who is almost shaking out of control as she eyes it.\n\n");
	outputText("To tease her, you slap her in the face with your [cock], to which she responds like a kitty cat, trying to grab it with both paws. You dick slap her a few times, until she finally grabs your [cock] with her furry hands, trying to hold it still. She reminds you of one of the house cats back home, when you teased them with a cotton stick. She starts by slowly licking your [cock] with her tongue, carefully lubricating the entire length. She really does lick like a cat, and the hooks on her tongue drag pleasurably along the skin of your [cock]. Idly, you wonder if ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("the manticore");
	outputText(" likes milk, as that would fit with the whole cat aspect. She cuts your thoughts short as she slides your [cock] between her large breasts, carefully squishing them together with her paws. You moan at the cat girl’s ministration as she proceeds to pump your [cock] up and down with her breasts, still licking your tip. Her titfuck feels wonderful and the way she licks your tip is clearly that of an expert whore, ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText(" the manticore");
	outputText("seems to go into a frenzy as a drop of precum drools down your [cock] right on to her tongue. She starts to pump faster in an effort to force the cum out.\n\n");
	outputText("\"<i>Nyaaaaa yes, that’s it! Give it all to me.</i>\"\n\n");
	outputText("Accidentally, in her excitement, her tail slap against your flank injecting your side with a dash of her lewd venom but this only get your penis to swell even more. Whatever is coming out is gonna be one hell of a mess. Soon you can’t hold it any longer and paint her entire face with your man milk, to which she answers by methodically licking the cum clean like a cat drinking milk. Her expression and the way she grooms her paws licking them clean of your cum with a sensual \"<i>Nyaaaaaa</i>\" is so cute you idly ponder if she’s more cat than human.\n\n");
	outputText("Having taken your tribute you dismiss her and proceed to head back to camp.");
	if (player.cumQ() < 500) player.cumMultiplier += 6;
	if (player.cumQ() < 2000) player.cumMultiplier += 4;
	if (player.cumQ() < 10000) player.cumMultiplier += 2;
	if (player.hasStatusEffect(StatusEffects.WildManticore)) player.removeStatusEffect(StatusEffects.WildManticore);
	else etnaAffection(10);
	player.sexReward("vaginalFluids","Dick");
	cleanupAfterCombat();
}

public function etnaRapeYesF():void
{
	clearOutput();
	etnaRapeYesF2();
	etnaAffection(10);
	cleanupAfterCombat();
}
public function etnaRapeYesF2():void
{
	outputText("You slowly remove any impeding equipment as you order the girl to make you feel good, double time! She does so and soon her entire tongue length is fully in your [pussy], licking in a way reminiscent of a cat grooming her kitten as you sixty-nine her. You moan appreciatively and to reward the slut for her efforts you finger her in return. ");
	if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) outputText("Her tail tip suddenly opens to reveal what looks like a dripping pussy and to drive her even crazier you take it upon yourself to insert your entire fist inside. ");
	else {
		outputText("Her tail pussy blossoms out of her arousal and you insert your entire fist inside to help increase her stimulation. ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("the manticore");
		outputText(" reacts as expected as her tail clenches on your fist and her entire body quakes from your double ministration. ");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
		else outputText("the manticore");
		outputText(" tail is already gushing fluids everywhere but you decide to take it one step further and increase the tempo as well as her torment by grabbing one of her whorish tits and suckling on the tip. ");
	}
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("The manticore");
	outputText(" wails as both of you are being covered with her tail juice and that only serves to arouse you more. Unsatisfied with that alone you pick up a spike that fell off earlier.\n\n");
	outputText("\"<i>Y..you wouldn’t dare! This is completely sick!</i>\"\n\n");
	outputText("Oh, really? Well, she’s in for a surprise as you give ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("the manticore");
	outputText(" a direct taste of her own poison. Soon ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("the manticore");
	outputText(" is begging for you to stop but you deny her, knowing quite well she would have done to you the same thing had your roles been reversed. She moans what sounds like musical notes as she orgasms one time after another. Soon your own orgasm starts and you both are singing in a perfect chorus of moans ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("the manticore");
	outputText(" leading the tempo. She cums twice as much as you do and that’s without mentioning she cums from both holes. ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("The manticore");
	outputText(" blacks out from the overstimulation caused by both her venom and the intense double penetration you’re giving her. It would seem she isn’t as good a victim as she is a rapist. You proceed to re-dress and head back to camp highly satisfied.");
	if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 1;
	if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] == 2) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 3;
	if (player.hasStatusEffect(StatusEffects.WildManticore)) player.removeStatusEffect(StatusEffects.WildManticore);
	else etnaAffection(10);
	player.sexReward("vaginalFluids");
}

public function EtnaFillHerUp():void
{
	clearOutput();
	if (!player.isLiliraune()) sceneHunter.print("More for Liliraunes!");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("This manticore");
	outputText(" is always ready to take a stamen in, isn't she? Guess today you will give the happy kitten a treat." +
			"You tease her as you close in ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("\"<i>Hey Etna</i>");
	else outputText("\"<i>Hey kitty</i>");
	outputText("<i> you're always hungry for more ain't you?</i>\"\n\n");
	if(player.isLiliraune())
		outputText("Your other half chuckles, \"<i>Oh of course she is, she's always hungry for more. She's been hunting minotaurs for their cocks all day long.</i>");
	if(player.isLiliraune()) {
		outputText("\"<i>Well </i>");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("\"<i>Etna</i>");
		else outputText("\"<i>kitty</i>");
		outputText("<i> how about we gave you exactly what you want so badly.</i>\"\n\n");
	} else {
		outputText("\"<i>Well </i>");
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("\"<i>Etna</i>");
		else outputText("\"<i>kitty</i>");
		outputText("<i> how about I give you exactly what you want so badly.</i>\"\n\n");
	}
	outputText("She perks up at the mere mention, her tails dripping with pussy drool. " +
			"You pull her closer without much struggling and align your many stamens as she tucks her tail between her legs and holds the tip with her forepaws," +
			" the flower-like bulb petals blossoming out in anticipation heck It not only looks like a flower it also smells like one… It’s so inviting…\n\n" +
			"Flowers are plant pussy and cocks to begin with");
	if(player.isAlraune())outputText(", so aren't you, in theory, bathing in a giant sexual organ? The thought only arouses you all the more");
	outputText(". Focusing your mind back to the fun, you coil and twist all of your vines together merging them into a single thick composite stamen about as twelve time ticker then each of your individual members." +
			"The rubbing of your many vines against one another is a delightful feeling and it only gets better as you dive into ");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.WildManticore)) outputText("Etna");
	else outputText("the manticore");
	outputText(" welcoming folds pistoning in and out.\n\n" +
			"She mewls in delight as your massive composite member begins to slither all the way down her hole." +
			" Her tail feeling a member inside instinctively milks and squeezes your omnicocks, instincts kicking in, as the delirious manticore begs for you to keep going.\n\n")
	if(player.isLiliraune()) {
		outputText("You groan between panting commenting out on this situation. \"<i>Geeze, Ahhn!... I knew she was a slut but this is beyond ridiculous. This tail ain't a pussy, it's a living vacuum! Oh, fuck, keep going girl!</i>\"\n\n" +
				"Your twin adds up. \"<i>OHHHH...You do realize this hole is just a glorified mouth? Might as well say she's giving us the ultimate blowjob.</i>\"\n\n" +
				"Annoyed, you reply to her, \"<i>Sister I really don't care what that hole is, I'm filling this tail until she gets pregnant! And if it doesn't I'll just fill it again. So close to cumming now!</i>\"\n\n");
	}
	outputText("The sensation of your stamens sliding against one another is amplified as the manticore’s tail juice lubricates the space between them." +
			" This hole is made for milking semen and as you pump inside, your many vines are gently coaxed to orgasm by the walls fleshy feelers.\n\n" +
			"You ");
	if(player.isLiliraune()) outputText("and your twin both ");
	outputText("scream");
	if(player.isLiliraune()) outputText("s ");
	outputText(" your release");
	if(player.isLiliraune()) outputText("s groping each other boobs with both hands firmly and nectar runs down your tits,");
	outputText(" as your rubbing members explode all at the same time flooding the pussy tail with enough cum to impregnate twice as many women as you got stamens, " +
			"the bulge of your fluids running like big fleshy lumps down her tail directly to what is likely her belly.\n\n" +
			"Patting her belly in contentment the manticore falls down on the ground curling for a quick catnap. With both parties satisfied, you head back to camp");
	if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 1;
	if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] == 2) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] = 3;
	if (player.hasStatusEffect(StatusEffects.WildManticore)) player.removeStatusEffect(StatusEffects.WildManticore);
	else etnaAffection(10);
	player.sexReward("vaginalFluids","Dick");
	cleanupAfterCombat();
}

public function etnaRapeNo():void
{
	clearOutput();
	outputText("You decline and proceed to walk away back to your camp but she holds you back, handing over what looks to be a vial. \"<i>Take this. I think you should have it. Be careful. It's quite a strong drink.</i>\"");
	if (player.hasStatusEffect(StatusEffects.WildManticore)) player.removeStatusEffect(StatusEffects.WildManticore);
	else etnaAffection(10);
	cleanupAfterCombat();
}

public function etnaRape3rdWin():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("She falls on the ground, eyeing you with surprise and incredulity.\n\n\"<i>Whoa, you're a tough one, aren’t you? Each time I try and get you on my dinner plate, you appear on top instead of on the bottom.</i>\"\n\nShe dusts herself off a little, somewhat amused yet it’s obvious her pride took a hit.\n\n\"<i>My name is Etna. I think you ought to know it now since you've defeated me a few times. I must admit that I’m somewhat interested in you now. Anyway, you have won yet again and therefore you get to do whatever you want with me. So... what will it be?</i>\"\n\n");
	outputText("Do you rape her?");
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 1) flags[kFLAGS.ETNA_TALKED_ABOUT_HER] = 1;
	menu();
	if (player.lust >= 33 && player.hasCock()) addButton(0, "Yes (M)", etnaRapeYesM);
	if (player.lust >= 33 && player.hasVagina()) addButton(1, "Yes (F)", etnaRapeYesF);
	addButton(2, "No", etnaRapeNo);
}

public function etnaReady2Come2Camp():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("Etna falls to the ground defeated yet again her expression of desire and admiration obvious. This time, however, she swoons on you making her intentions clear.\n\n");
	outputText("\"<i>You're stronger than I am in so many ways, that I can barely hold in my desire... Would you please accept me as your lover? I could join your pride, if you would please allow me to.</i>\"\n\n");
	outputText("Wait did she literally just ask to be part of your harem or something?\n\n");
	outputText("\"<i>It's not something I ask lightly, nya, but my nature forces me to bow down to the strong. You have clearly tamed my wild heart, so will you take me back home as your prize?</i>\"\n\n\n\n");
	menu();
	if (EtnaInfidelity == 2) addButton(0, "Yes", etnaRapesYesCome2Camp).disableIf(player.cumQ() < 2000, "You dont have enough cum to satisfy her.");
	else addButton(0, "Yes", etnaRapesYesCome2Camp);
	addButton(1, "No", etnaRapeNoCamp);
}

private function etnaRapesYesCome2Camp():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
    outputText("The girl clearly seems to be in love and after doing it so many times with her, you can’t deny having similar feelings towards the manticore. You express to her your accord to which she responds by kissing you passionately as you both begin to undress.\n\n");
	if (EtnaInfidelity == 2) EtnaInfidelity = 3;
	else flags[kFLAGS.ETNA_FOLLOWER] = 1;
	if (player.hasCock()) {
		outputText("You proceed to undress with deliberate slowness, presenting your penis to Etna, who is almost shaking out of control as she eyes it.\n\n");
		outputText("To tease her, you slap her in the face with your dick, to which she responds like a kitty cat, trying to grab it with both paws. You dick slap her a few times, until she finally grabs your cock with her furry hands, trying to hold it still. She reminds you of one of the house cats back home, when you teased them with a cotton stick. She starts by slowly licking your dick with her tongue, carefully lubricating the entire length. She really does lick like a cat, and the hooks on her tongue drag pleasurably along the skin of your dick. Idly, you wonder if Etna likes milk.\n\n");
		outputText("She cuts your thoughts short as she slides your dick between her large breasts, carefully squishing them together with her paws. You moan at the cat girl’s ministration as she proceeds to pump your dick up and down with her breasts, still licking your tip. Her titfuck feels wonderful and the way she licks your tip is clearly that of an expert whore, heck maybe even succubi aren’t this talented.\n\n");
		outputText("Soon you can’t hold it any longer and paint her entire face with your man milk, to which she answers by methodically licking the cum clean like a cat drinking milk. Her expression and the way she grooms her paws licking them clean of your cum with a sensual \"<i>Nyaaaaaa</i>\" is so cute you idly ponder if she’s more cat than human.\n\n");
		outputText("Having taken your tribute you dismiss her and proceed to head back to camp.");
	}
	else if (player.hasVagina()) {
		outputText("You slowly remove any impeding equipment as you order the girl to make you feel good, double time! She does so and soon her entire tongue length is fully in your pussy, licking in a way reminiscent of a cat grooming her kitten. You moan appreciatively and to reward the slut for her efforts you finger her in return. ");
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) outputText("Her tail tip suddenly opens to reveal what looks like a dripping pussy and to drive her even crazier you take it upon yourself to insert your entire fist inside.\n\n");
		else outputText("Her tail pussy blossoms out of her arousal and you insert your entire fist inside to help increase her stimulation.\n\n");
		outputText("Soon Etna is begging for you to stop but you deny her, knowing quite well she would have done to you the same thing had your roles been reversed. She moans what sounds like musical notes as she orgasms one time after another. Soon your own orgasm starts and you both are singing in a perfect chorus of moans.\n\n");
		outputText("Etna blacks out from the overstimulation and you proceed to redress and head back to camp satisfied.");
		if (flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] < 1) flags[kFLAGS.ETNA_FEMALE_WIN_PUSSYTAIL_PLAY] ++;
	}
	etnaAffection(30);
	player.sexReward("vaginalFluids");
	cleanupAfterCombat();
	doNext(etnaCome2Camp);
}

private function etnaCome2Camp():void
{
	clearOutput();
	outputText("As you enter the camp with the manticore your various friends notice her and jump out of their activities to go to the pair of you.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("Rathazul almost drops a vial of purple liquid on the ground as he notices the manticore. \"<i>Is this what I think it is? Manticore venom is extremely potent. I could use it in alchemical concoctions, nice find! Just make sure to keep her in check...</i>\"\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
		outputText("Jojo notices the manticore right away breaking into a defensive stance and reciting a few of his teacher’s mantra. \"<i>[name] that thing is a manticore! I seriously hope you know what you're doing. She reeks of serious demonic corruption, so make sure you meditate with me regularly.</i>\"\n\n");
		outputText("You assure Jojo that you will and that Etna won't cause problems.\n\n");
	}
	if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0) outputText("Amily sees the manticore and pulls out her blowpipe.\n\n\"<i>A manticore, HERE?! This is a catastrophe! You need to keep it out of the camp! I bet she’s fully corrupted and will rape anyone given the chance.</i>\"\n\nYou tell Amily that Etna isn’t dangerous and won't harm anyone, however, the mouse remains wary of the manticore, even going as far as staying several meters away from her at all times. Maybe this is some kind of mouse versus cat relation problem, go figure.\n\n");
	if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		outputText("Sophie flies down and lands right in front of Etna. As they glare at each other you get the feeling that they already know each other, and judging by the looks on their faces, neither is happy about the other being there...\n\n");
		outputText("\"<i>Damned cat, figures that you would try stealing [name] from me. You're here only to sate your endless thirst, aren’t you?</i>\"\n\n");
		outputText("Etna replies smirking. \"<i>So what, you milfy bird? It’s not like you need more of [name]’s affection after your hundredth kid! Heck, I'm surprised a slut like you hasn’t already taken a permanent mate or maybe, you just don't consider men as such?</i>\"\n\nIt takes everything you have to prevent Sophie and Etna from fighting, but you eventually manage to calm them down and force them to make peace. Sophie begrudgingly shakes hands with Etna but you’re quite aware the odds of them becoming friends is quite slim.\n\n");
	}
	outputText("Her examination of your camp done, Etna proceeds to make herself comfortable and settle down.\n\n");
	if (flags[kFLAGS.ETNA_FOLLOWER] < 2) {
		outputText("\n\n<b>Before settling in, as if remembering something, Etna pulls a shining shard from her inventory and hand it over to you as a gift. You acquired a Radiant shard!</b>");
		if (player.hasKeyItem("Radiant shard") >= 0){
			player.addKeyValue("Radiant shard",1,+1);
		}
		else player.createKeyItem("Radiant shard", 1,0,0,0);
		flags[kFLAGS.ETNA_FOLLOWER] = 2;
	}
	outputText("(<b>Etna has been added to the Lovers menu!</b>)\n\n");
	flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] = 0;
	doNext(playerMenu);
}

public function etnaRapeNoCamp():void
{
	clearOutput();
	outputText("While the manticore’s feelings toward you are sincere, this is all too fast for you and you tell her so.\n\n\"<i>It's all fine... I’ll keep ambushing you until you finally say yes or I lose interest.</i>\"\n\nShe jumps off a nearby rock and takes flight. Giving you one last quick glance.\n\n");
	outputText("\"<i>I <b>will</b> have your heart one way or another so watch your back out there because you will never know when or where I'll strike next.</i>\"\n\nYou leave, heading back towards your camp. Just what did you get yourself into?");
	etnaAffection(-30);
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 2) flags[kFLAGS.ETNA_TALKED_ABOUT_HER] = 2;
	cleanupAfterCombat();
}

public function etnaRapeYandere():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("Defeated, you barely register as Etna joyfully takes a nearby rock and knocks it against your head making you lose consciousness.\n\n");
	outputText("You wake up in what looks like a dark room underground. The only source of light is a candle on a table in the corner. To your surprise, it's filled with various sex toys and the cave-like walls are covered with drawings and paintings depicting you. This is getting creepier by the second. A voice you know all too well starts speaking to you at first in hushed tone then hysterical notes.\n\n");
	outputText("\"<i>Slept well love? I couldn't stand you saying no when your eyes were clearly saying yes so I brought you here in order to help you become more honest with yourself. I know you love me and I will never let you leave me again, <b>we will</b> be together forever. You love me, don’t you? <b>DON’T YOU</b>?</i>\"\n\n");
	outputText("You see a pair of red cat eyes glowing in the dark to your right... It is obviously Etna. She’s in there with you and she’s clearly going to give you a run for your gems if you don’t escape this deathtrap. You try to stand up and run but to your horror you discover she tied you up to a chair. You’re utterly powerless! Etna resume speaking.\n\n");
	outputText("\"<i>You led me on and on, having sex with me, repeatedly turning me on");
	if (EtnaInfidelity == 2) outputText(" and even going so far as to confess your undying love for me");
	outputText(". Yet... In the end you denied me or should I say us.. Like if our story had never existed. You hurt me [name]... You have no idea how much your words hurted me it was like my whole world was falling apart.  To cement back our bond as lovers I will share with you all the pain you inflicted on my heart so that your heart can understand it too.</i>\"\n\n");
	outputText("Wait, share what?! Etna doesn’t give you any time to contemplate the things she will do to you as she proceeds to walk out of the shadows, holding one of her spikes like a dagger. It’s dripping with venom and you have an excellent idea of what she plans to do with it.\n\n");
	outputText("\"<i>You and I are going to play a game [name]. See these flowers on the table there. For each petal I pull and count as you loving me I’m going to stab you once and for each that I pull and count as hating me I’m going to stab you twice! So let us begin, you love me...</i>\"\n\n");
	outputText("Etna impales your leg with her spike and this causes some of your blood to splatter on the ground, you start by screaming in pain then tormented pleasure due to aphrodisiac contained in the spike. Etna, however, is barely getting started!\n\n");
	outputText("\"<i>You hate me...</i>\"\n\n");
	outputText("This time she impales you in both legs! This cruel little game plays for a full hour as blood flies everywhere… painting the floor, the walls, and even Etna herself. Every time you think you are about to run out fluids to spill Etna pulls out a healing pill and force-feeds it to you, closing your wounds and repeating this sick cycle of pain and pleasure anew. Etna keeps on wounding you until she reaches the final petal.\n\n");
	outputText("\"<i>You love me! See that?! Even the roses said so. <b>YOU LOVE ME!!!</b></i>\"\n\n");
	outputText("She laughs, her fur and skin painted red with your blood. You are too afraid to reply to her that the simple act of pulling petals from flowers doesn’t mean anything in your relationship with her.\n\n");
	outputText("\"<i>Ahhh [name]’s blood! Look at me, I’m entirely covered with your fluids, isn’t that a true show of my unwavering affection?! This is such a wonderful feeling, I would never ever wash again just so to preserve it forever!</i>\"\n\n");
	outputText("She’s giving you a blissful stare as she tosses away the spike and pounces on you, her tail already open and drooling ");
	if (player.hasCock()) outputText("as she prepares to feast");
	else outputText("at the mere thought of finally having sex with you");
	outputText(".\n\n\"<i>You are mine [name] whether you like it or not! I’ve been unable to think of anything but you for days and it is obvious that we were made for each other's body. No one else can douse the fire burning in me like you do!</i>\"\n\n");
	if (!recalling) {
		player.addCurse("tou", 5, 2);
		statScreenRefresh();
		etnaRapesPlayer();
		if (player.tou >= 30) {
			outputText("Thankfully, you wake up before Etna does and use the spike left on the ground to unbind yourself. Once done, you proceed to exit the place through a trap door and head back to camp before the love-crazed manticore notices you’ve escaped.\n\n");
			if (player.hasCock()) player.sexReward("no", "Dick");
			player.sexReward("vaginalFluids");
			cleanupAfterCombat();
		} else etnaRapeYandereBadEnd();
	} else doNext(recallWakeUp);
}

public function etnaRapeYandereBadEnd():void
{
	outputText("You wake up before Etna does and see a spike you could use to break free but you are too weak to fight or crawl your way to it. Therefore you stay on the ground, at the mercy of Etna. Maybe it isn’t such a bad thing. After all, she clearly loves you and if she is willing to go this far to keep you next to her, there isn’t much you can do about it. Etna will never let you leave the cave ever again and, as such, you give up on your quest in order to live with your somewhat obsessed lover. ");
	if(player.hasStatusEffect(StatusEffects.CampMarble)) outputText("Marble comes looking for you before long, but, instead of freeing you, she decides to help the manticore hold you there for your own good. ");
	outputText("Your adventure seems to have come to an end but at least you will live the rest of your life showered with love.");
	EventParser.gameOver();
}

public function etnaRapeIntro2():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("Etna is laying on the ground ");
	if (monster.HP < 1)outputText("defeated");
	else outputText("too horny to fight back");
	outputText(". She looks at you with a hopeful expression as she holds her tail with one hand. \"<i>So strong... so powerful! If you would only let me taste you I promise I will make it feel sooooo good.</i>\"\n\n");
	outputText("Do you grant her request?");
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.ETNA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 5 && flags[kFLAGS.ETNA_LVL_UP] < 1) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 1;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 6 && flags[kFLAGS.ETNA_LVL_UP] == 1) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 6));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 6));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 2;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 7 && flags[kFLAGS.ETNA_LVL_UP] == 2) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 7));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 7));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 3;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 8 && flags[kFLAGS.ETNA_LVL_UP] == 3) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 8));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 8));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 4;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 9 && flags[kFLAGS.ETNA_LVL_UP] == 4) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 9));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 9));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 5;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 10 && flags[kFLAGS.ETNA_LVL_UP] == 5) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 10));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 10));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 6;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 11 && flags[kFLAGS.ETNA_LVL_UP] == 6) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 11));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 11));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 7;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 12 && flags[kFLAGS.ETNA_LVL_UP] == 7) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 12));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 12));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 8;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 13 && flags[kFLAGS.ETNA_LVL_UP] == 8) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 13));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 13));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 9;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 14 && flags[kFLAGS.ETNA_LVL_UP] == 9) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 14));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 14));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 10;
		}
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] == 15 && flags[kFLAGS.ETNA_LVL_UP] == 10) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 4, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 15));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 15));
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 11;
		}
	}
	menu();
	if (player.lust >= 33 && player.hasCock()) addButton(0, "Yes (M)", etnaRapeYesM);
	if (player.lust >= 33 && player.hasVagina()) addButton(1, "Yes (F)", etnaRapeYesF);
	addButton(2, "No", etnaRapeNo);
}

public function etnaCampMenu2():void {
	if (!player.hasStatusEffect(StatusEffects.LunaOff) && !player.hasStatusEffect(StatusEffects.LunaWasWarned)) {
		if ((flags[kFLAGS.LUNA_JEALOUSY] > 200 && rand(10) < 4) || (flags[kFLAGS.LUNA_JEALOUSY] > 300 && rand(10) < 8)) mishapsLunaEtna();
		else etnaCampMenu();
	}
	else etnaCampMenu();
}

public function etnaCampMenu():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	if ((EtnaInfidelity == 1 || EtnaInfidelity == 3 ) && !EtnaFertile) {
		etnaAfterInfidelity();
		return;
	}
	if (pregnancy.isPregnant && etnaPregApproach()) {}
	else outputText("As you approach Etna’s rug, she stretches on all fours, giving you a hopeful expression as she notices you’re walking towards her.");
	outputText("\n\n\"<i>Nya, great day lover. Are you here to have some fun with your pet catgirl? Or do you just want to talk to me? I must admit, my tail is itching, you already know how hungry I am.</i>\"\n\nShe gives you a naughty expression that tells everything. Obviously, a manticore is always ready.");
	menu();
	addButton(0, "Appearance", etnaAppearance).hint("Examine Etna's detailed appearance.");
	addButton(1, "Talk", etnaTalkMenu).hint("Ask Etna about something.");
	addButton(2, "Sex", etnaSexMenu).hint("Have some sex with Etna");
	if (flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] > 0) addButtonDisabled(3, "Req. Venom", "You already asked her for a vial today.");
	else addButton(3, "Req. Venom", etnaDailyVenomVial).hint("Ask Etna for a vial of her venom.");
	addButton(4, "Spar", etnaSparsWithPC).hint("Ask Etna for a mock battle with sex for the winner.")
		.disableIf(flags[kFLAGS.PLAYER_COMPANION_1] == "Etna", "You can't fight against her as long she's in your team.")
		.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
	if (player.hasPerk(PerkLib.BasicLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButton(5, "Team", etnaHenchmanOption).hint("Ask Etna to join you in adventures outside camp.");
		else if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna") addButton(5, "Team", etnaHenchmanOption).hint("Ask Etna to stay in camp.");
		else addButtonDisabled(5, "Team", "You already have other henchman accompany you. Ask him/her to stay at camp before you talk with Etna about accompaning you.");
	}
	else addButtonDisabled(5, "Team", "You need to have at least Basic Leadership to form a team.");
	if (flags[kFLAGS.ETNA_FOLLOWER] < 3) addButton(6, "Marriage", etnaMarriage)
		.disableIf(player.isGenderless(), "Come on, you're genderless!")
		.disableIf(flags[kFLAGS.MICHIKO_TALK_MARRIAGE] == 0, "You don't even know if it's possible in Mareth. Try talking to random people in random river towns... maybe you'll find out?");
	if (flags[kFLAGS.SLEEP_WITH] != "Etna") addButton(7, "Sleep With", etnaSleepToggle).hint("Spend your nights with Etna.");
	else addButton(7, "Sleep Alone", etnaSleepToggle).hint("Stop sleeping with Etna.");

	addButton(14, "Back", camp.campLoversMenu);
}

public function etnaAppearance():void
{
	clearOutput();
	outputText("Etna is a manticore. Her flowing, red hair is tied up in a spiky ponytail, which only accentuates her wild appearance. Her red, cat-like eyes are always sparkling maliciously like she was planning something and her not-so-innocent cat toothed smirk only serves to make her look all the more naughty. Her lion ears are alert to sound, twitching as she hears you approaching. Currently, she is laying down on her carpet in a position quite reminiscent of a classic housecat.\n\n");
	outputText("Her arms and legs end in powerful, feline paws, allowing her to move either on two or four legs. The bluish-black fur on her limbs climbs up to the middle of her thighs and shoulders turning white at the tip and contrasting with her light skin. Funnily, despite their feral appearance her hands armed with claws can hold and manipulate objects like human hands would, including, of course, a man’s pole. Her neck is hidden by a fluffy collar of white fur, not unlike that of a lion. ");
	outputText("The comparison to a lion ends there, as a pair of large bat-like wings that can stretch up to 13 feet wide rest on her shoulders. From her well-shaped ass surges a scorpion-like tail covered in armor like chitin. At her tail tip is a large bulb covered with venomous spikes from which venom drips off. She can open her tail tip at will which expands into a star-shaped tail pussy of accommodating size that’s always ready to devour a man’s tool and is constantly drooling with moisture.\n\n");
	outputText("As her nature of a sexual predator would tell, she is endowed with a pair of pert breasts easily reaching E cup and her perfect hourglass shape could make many succubi jealous.\n\n");
	outputText("Her main pussy, funnily enough, is the only thing about her that doesn’t look perpetually ready for sex. She likely doesn't use it often.");
	if (pregnancy.isPregnant){
		switch (pregnancy.event) {
			case 1: outputText("\nShe’s smiling as she caresses her belly, which bulges slightly.");
				break;
			case 2: outputText("\nHer belly is definitely swollen now, forming a round bump which likely means she’s pregnant with a cub.");
				break;
			case 3: outputText("\nHer belly is definitely bigger than before which likely means she’s pregnant with a cub.");
				break;
			case 4: outputText("\nHer belly has swollen up to the point that she looks nine months pregnant, and will give birth very soon.");
				break;
		}
	}
	menu();
	addButton(14, "Back", etnaCampMenu);
}

public function etnaTalkMenu():void
{
	clearOutput();
	outputText("Etna yawns and takes on an inquisitive pose.\n\n");
	outputText("\"<i>Oh, so you just wanted to talk? I was sure you would have something funnier in mind but fair enough. What did you want to talk about?</i>\"");
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
	outputText("Ok, so she’s a manticore. Is her species some kind of demonic creation?\n\n");
	outputText("\"<i>Not quite. We've been out on the prowl since the early days of Mareth. While the demons can lay claim to being the kings of the jungle right now, we have always been top sexual predators out there. The fact that we are all born females only makes it more important, as our only way to reproduce is through the males of another race. That, and the fact we are spermivores, makes us better at sex, if not twice as lusty, as the standard succubus. It's not just a matter of reproduction or fun but also a question of survival in our case.</i>\"\n\n");
	outputText("What of the demons, did their arrival impact on the manticores way of life at all?\n\n");
	outputText("\"<i>I see where you're getting at. You wonder if I'm actually as corrupt as the cows out there. Well... in a sense, I suppose I am, after all, it’s not like we haven't been banging the demons too. Heck, we’ve been banging them so much that to reward our interest into sucking them off, they pretty much gave us a boon so we could suck them even better. Namely this tail pussy that everyone in my race shares. It is our sign of a deal with them. I,  myself, consider it an improvement, as it allows me to consume twice as much cum as I would with my pretty mouth. Is there anything else you want to know?</i>\"\n\n");
	doNext(etnaTalkMenu);
	cheatTime(1/4);
}

public function etnaMarriage():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("You want to propose to Etna, your love with her is true however you take the time to question yourself. You ");//outputText("");
	if (!player.hasItem(jewelries.ENDGRNG, 1)) {
		outputText("realize however that to properly propose to her, you would need an engagement ring, preferably a ruby one.");
		doNext(etnaCampMenu);
	}
	else if (!SceneLib.templeofdivine.canMarry()) {
		if (!player.hasItem(jewelries.ENDGRNG, 1)) outputText("realize however that to properly propose to her, you would need an engagement ring, preferably a ruby one also ");
		outputText("realise to your annoyance that the two of you will need a holy place to recite your vows, one with a still working altar of Marae and active priestess likely.");
		doNext(etnaCampMenu);
	}
	else {
		outputText("have the ruby ring on you, but is this really the time?\n\n");
		menu();
		addButton(1, "Yes", etnaMarriageYes).hint("Taking this step leads to a fight. Save your game!");
		addButton(3, "No", etnaMarriageNo);
	}
}
public function etnaMarriageNo():void
{
	outputText("Such a thing as a wedding is no triviality, even in messed up land like Mareth. You need to thoroughly think this through first.");
	doNext(etnaCampMenu);
}
public function etnaMarriageYes():void
{
	outputText("You drop down on one knee before Etna as she gives you a troubled stare before you open a small box containing the ruby ring. This begins in the same way as every Love Tale as you gather the courage and propose under her astonished expression.\n\n");
	if (!sceneHunter.canMarry()) {
		outputText("Etna slowly shakes her head as she pushes the ring away, \"<i>Sorry [name]... You’ve already sworn your heart to someone else… You can still feed me, but I don’t feel right taking the role of your spouse when someone has already claimed your heart.</i>\"\n\n");
		outputText("You nod your head sadly. While her rejection stings, her words carry merit and it’s not right to betray the trust of "+flags[kFLAGS.MARRIAGE_FLAG]+".\n\n");
		doNext(etnaCampMenu);
	}
	else {
		outputText("\"<i>F..for me? [name], out of everyone else you’ve chosen me?! Yes...yes, my answer is YES! I will be your favored wife forever and ever.</i>\"\n\n");
		player.destroyItems(jewelries.ENDGRNG, 1);
		player.HP = player.maxHP();
		player.lust = 0;
		player.wrath = 0;
		player.fatigue = 0;
		player.mana = player.maxMana();
		player.soulforce = player.maxSoulforce();
		model.time.days += 3;
		doNext(etnaMarriageYes2);
	}
}
public function etnaMarriageYes2():void
{
	clearOutput();
	outputText("It’s been three days since and now both of you are standing quietly in the chapel of Marae. Etna is dressed in a formal wedding dress, which is something people hadn't seen in Mareth for a long time. Both of you are standing by Sapphire who once again has taken the role of priestess for the occasion as you recite your vows");
	if (camp.loversCount() > 0 || camp.followersCount() > 0) outputText(". All of your friends came to attend");
	if (camp.loversCount() > 0) outputText(" which is not so surprising considering the strength of your relationship with them");
	outputText(".\n\n");
	outputText("\"<i>If anyone objects to this union, may they speak now or stay silent forever!</i>\"\n\n");
	outputText("Just as she finishes her sentence, the door of the building flies open as a thunderous voice rings out over the place.\n\n");
	outputText("\"<i>FUCK THAT BITCH! IT’S REVENGE TIME BOYS!!!!!</i>\"\n\n");
	outputText("At the door stands, not one, not two but a full herd of enraged minotaurs! They are all staring at Etna with angry glares.\n\n");
	outputText("\"<i>You damn slut! You have been raping us for years but this time around we will be victorious, bring you back to the village and tie you to our totem so we can take turns raping your twin cunts!</i>\"\n\n");
	outputText("Etna laughs, looking at them like they’re joking.\n\n");
	outputText("\"<i>Boys, don’t you know it’s not rape when it's consensual? Hey [name] I don’t know about you but they are interrupting the wedding. It’d be nice if you could dispose of them.</i>\"\n\n");
	outputText("You step forward to save your marriage, there's no way you're going to let these huge pricks ruin your special day or hers!\n\n");
	flags[kFLAGS.ETNA_FOLLOWER] = 3;
	startCombat(new MinotaurMob());
	spriteSelect(SpriteDb.s_minotaurSons);
	doNext(playerMenu);
}
public function etnaMarriageYes3():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("\"<i>[name]!</i>\" Etna cries in shock, kneeling over you, \"<i>No… are you…</i>\" Her words are interrupted by the gang of minotaurs stampeding toward her.\n\n");
	outputText("Etna sighs mournfully before taking flight, escaping through a window as the minotaurs chase after her. Seems your wedding is canceled at least for today but at least you can try again in a week.\n\n");
	flags[kFLAGS.ETNA_FOLLOWER] = 2;
	cleanupAfterCombat();
}
public function etnaMarriageYes4():void
{
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("The herd runs out of the chapel, screaming like terrified cattle before your might. Etna shrugs before returning to position in order for the ceremony to resume.\n\n");
	outputText("\"<i>I could have flown away like I always do but honestly it would've ruined the mood and the wedding. Thank you for solving that.</i>\"\n\n");
	outputText("The two of you voice out your vows again under the eyes of the somewhat confused priestess.\n\n");
	outputText("Sapphire speaks up, \"<i>Etna, do you wish to take [name] as your spouse, now and forever?</i>\"\n\n");
	outputText("Etna nods, tears welling up in her eyes as she stares deeply into yours, \"<i>I do.</i>\"\n\n");
	outputText("\"<i>[name],</i>\" Sapphire speaks, \"<i>Do you wish to take Etna as your spouse, now and forever?</i>\"\n\n");
	outputText("Your mind is set, you know deep within your being that there is nobody else you’d rather spend eternity with.\n\n");
	outputText("\"<i>I do.</i>\" You state.\n\n");
	outputText("Tears begin streaming down Etna’s face as Sapphire speaks up, \"<i>By the power vested in me, I now pronounce you soulmates.</i>\"\n\n");
	outputText("Etna wraps her svelte arms around you as you wrap yours around her waist. She pulls you in  for a loving kiss, locking your lips with hers. If only the moment could last an eternity, but before you know it, Etna pulls away, staring back at you with beams of hope in her eyes.\n\n");
	outputText("\"<i>I love you, [name]... I want you to never forget that.</i>\"\n\n");
	outputText("You smile back at her, letting her know that you love her as well.\n\n");
	outputText("You spend a moment celebrating the marriage until night falls and it is time to return back to camp. You bring Etna home and ready yourself to consummate your love with the manticore.\n\n");
	if (player.hasCock()) etnaPussyOpera2();
	else etnaRapeYesF2();
	outputText("\n\nEtna, still entangled with you, kisses you.\n\n");
	outputText("\"<i>You know [name], I took the time to actually make you a wedding gift. I would like to give you this weapon that was tempered using some of my venom and bone spikes by a blacksmith. Please accept this gift.</i>\"\n\n");
	model.time.days++;
	model.time.hours = 6;
	flags[kFLAGS.ETNA_FOLLOWER] = 4;
	sceneHunter.marry("Etna");
	inventory.takeItem(weapons.VENCLAW, cleanupAfterCombat);
}

public function etnaHenchmanOption():void
{
	clearOutput();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		outputText("\"<i>Nyaaaaa we hunting together [name]? This is going to be enjoyable!</i>\"\n\n");
		outputText("Etna is now following you around.\n\n");
		var strEtna:Number = 100;
		var libEtna:Number = 170;
		if (flags[kFLAGS.ETNA_LVL_UP] >= 1) {
			strEtna += 10 * flags[kFLAGS.ETNA_LVL_UP];
			libEtna += 20 * flags[kFLAGS.ETNA_LVL_UP];
		}
		strEtna *= (1 + (0.2 * player.newGamePlusMod()));
		strEtna = Math.round(strEtna);
		libEtna *= (1 + (0.2 * player.newGamePlusMod()));
		libEtna = Math.round(libEtna);
		player.createStatusEffect(StatusEffects.CombatFollowerEtna, strEtna, libEtna, 0, 0);
		flags[kFLAGS.PLAYER_COMPANION_1] = "Etna";
	}
	else {
		outputText("Etna is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerEtna);
		flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(etnaCampMenu);
	cheatTime(1/12);
}

public function etnaSexMenu():void
{
	clearOutput();
	outputText("You ask Etna if she’s ready for some fun and she perks up grinning widely.\n\n");
	outputText("\"<i>What did you have in mind lover? You already know I am always up for it.</i>\"");
	menu();
	addButton(0, "LetHerBeInCharge", etnaLetHerBeInCharge);
	addButton(1, "BeTopGirl", etnaBeTheTopGirl).disableIf(!player.hasVagina(), "Req. a vagina!");
	addButton(2, "KittyTitFuck", etnaKittyTitFuck).disableIf(!player.hasCock(), "Req. a cock!");
	addButton(3, "Pussy Opera", etnaPussyOpera).disableIf(!player.hasCock(), "Req. a cock!");
	addButton(4, "Share a Drink", etnaShareDrink).disableIf(player.tailType != Tail.MANTICORE_PUSSYTAIL, "Req. to have a manticore pussytail.");
	addButton(5, "Fill her up", EtnaFillHerUp).disableIf(!player.isAlraune(), "Req. to be an alraune.");
	addButton(6, "TailExplor", tailExploration)
		.hint("Play with her tail using your goo body!", "Tail Exploration")
		.disableIf(!player.isGoo(), "Req. goo body.");
	addButton(14, "Back", etnaCampMenu);
}

public function etnaLetHerBeInCharge():void
{
	clearOutput();
	outputText("You admit that you miss her somewhat dominant attitude at times and ask her if she’s up for some extreme roleplay, pretending to have just lost to the oh so mighty manticore.\n\n");
	etnaRapesPlayer2();
}

public function etnaBeTheTopGirl():void
{
	clearOutput();
	outputText("You growl playfully into her ear, asserting your dominance over her. Her cat-like instincts take over and she rolls over, a mock defeated expression on her face.\n\n");
	etnaRapeYesF2();
	etnaAffection(10);
	cleanupAfterCombat();
}

public function etnaKittyTitFuck():void
{
	clearOutput();
	etnaRapeYesM();
}

public function etnaPussyOpera():void
{
	clearOutput();
	etnaPussyOpera2();
	doNext(camp.returnToCampUseOneHour);
}
public function etnaPussyOpera2():void
{
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 3) {
		outputText("You ask Etna if she feels like trying something different for once. She looks at you inquisitively until you point the somewhat very obvious hole between her legs. To your surprise, she blushes and hides it with both paws. You ask her how she can be shy about using her main pussy, after all, she has been basically fucking you for weeks now.\n\n");
		outputText("\"<i>That's not the same thing at all! While my tail does feel like a pussy, there is a very large difference between feeding and having true sex; pregnancy and well... the other things that are part of it. I'm a virgin and, unlike you, I’ve been saving myself up.</i>\"\n\n");
		outputText("Well... that's something new. You're surprised a crazed nymphomaniac like her could actually be a virgin, let alone shy about having normal sex.\n\n");
		outputText("\"<i>Look, feeding is something that is necessary for us to survive, but just because we feed casually, doesn’t mean we give out our virginities quite so easily. However, I’ve been around you long enough to know what I want… If you have me, I will offer myself to you earnestly. Still, I don’t feel myself to be ready for kids, so I will wait until I feel I am ready.</i>\"\n\n");
	}
	else {
		outputText("She fawns on you smiling. \"<i>I’m still not sure about kittens, but sure! I wouldn’t mind doing that again..</i>\"\n\n");
	}
	outputText("Etna makes an inviting pose on the ground, displaying her body as she offers herself up to you, keeping her tail in check for once.. You proceed to strip down and join her on the provisory couch. Etna is acting like a shy girl who has never had sex in her life, which is awkward. Still, considering the fact she has only been using her mouth and tail so far, it's to be expected that she would lack experience with her true vagina. You take the lead, slowly teasing her entrance passage with your [cock]. She moans, delighted at your ministration, her pussy moistening almost instantly.\n\n");
	outputText("\"<i>P..please be gentle...I’m... very sensitive down there.</i>\"\n\n");
	outputText("If she enjoys it that much when you're not even in, you wonder how she will react when your rod fully penetrates her.\n\n");
	outputText("You tease her for a few minutes making her moan continually then proceed to insert it entirely, making her \"<i>Eeep!</i>\" in surprise. You slowly ease yourself in, until you hear the manticore starting to... sing? She’s literally moaning you a full-blown opera as you fuck her. Her sensitivity must be off the charts as her vaginal walls convulse around your cock, gripping it like a vice, almost as if she was constantly orgasming and the way she moans can attest to that. However, you’ve barely gotten started and the short fuse of your partner won’t change anything about it. ");
	outputText("You slowly piston in and out, trying to drive the best notes out of her as she weaves you an orgasmic symphony. Her tail seems to react in tandem with her main hole, considering the constant gushes of fluids onto the ground, which creates a small pool of girlcum underneath it. It thrashes wildly, in accordance to her orgasm, barely missing you several times, despite your best attempts to avoid it.\n\n");
	outputText("You get one final, booming note out of her as you paint her insides white. Her tail jerks once more as Etna is rocked by a final orgasm and girlcum rains down upon both of you as she shoots upward. Etna slowly crawls away on the ground, looking extremely exhausted.\n\n");
	outputText("\"<i>That was... something else... "+(!EtnaFertile?"I'll take the herb for a few days now... ":"")+"looking forward to that again.</i>\"\n\n");
	outputText("You give her a gentle kiss before leaving to clean yourself and give her a chance to recover.");
	if (player.cumQ() < 500) player.cumMultiplier += 6;
	if (player.cumQ() < 2000) player.cumMultiplier += 4;
	if (player.cumQ() < 10000) player.cumMultiplier += 2;
	player.sexReward("vaginalFluids","Dick");
	etnaKnockupAttempt();
	if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 3) flags[kFLAGS.ETNA_TALKED_ABOUT_HER] = 3;
}

public function etnaShareDrink():void
{
	clearOutput();
	outputText("You casually ask what manticore tails can do besides drinking on cum.\n\n");
	outputText("\"<i>Well... not many things. It's not like it’s extremely strong or heavy either but there's a few more... kinky application to it. Care to have a drink?</i>\"\n\n");
	outputText("Now that's something you're very intrigued about and when you see your friend pull out a pair of very large straws out of a bag and get a large barrel filled to the brim with a somewhat milky substance there's little question as to what she has in mind.\n\n");
	outputText("\"<i>Ok hold your tail upward just like this. Yea that’s it. I'll put a straw in yours, you get the one in mine.</i>\"\n\n");
	outputText("You only understand what she meant by having a drink once she pours the barrel into both of your tails. Wow, your tail walls stretch magnificently, filled to the brim with fluid. Taking a taste of it in your pussy, you figure exactly what you're filled with.  That’s minotaur cum in its rawest form, almost fresh from the tap! You smile lustfully as you proceed to drink from your lover’s pussy, just as she does the same with yours. Unsurprisingly, minotaur cum tastes wonderful and provides you with a spike in energy as your body metabolizes it into food.\n\n");
	outputText("The two of you make wet slurping sounds for several minutes, drinking from each other’s pussy. It's a fun bonding experience as you not only taste the minotaur cum, but also a delicious cocktail of Etna’s own pussy juice mixed in with it. It’s likely that she is tasting you as well and from the face she's making you gather that you don't taste half bad. Deciding to add some extra flavor you grab one of her supple breasts and tweak it playfully until milk dribbles out into your waiting tail. Etna seems to like the idea too and toys with your breasts until some milk dribbles into her tail. You make a lewd smile and gently lick Etna’s tail insides making her gasp. ");
	outputText("Etna smirks and reciprocates passing her rough cat tongue on your tail pussy lips. Having a tail pussy is a one of a kind feeling as you both feed and feel indecent pleasure from it. It would be hard for you to give up on that body part. You resume drinking both ways, orgasming at the same time as your tail pussy bottoms up and goes empty. Etna thankfully, however, has extra barrels and gives you both a refill");
	if (player.hasVagina()) outputText(" the [pussy] between your legs wets the ground as a new cargo of cum fills your tail cavity");
	outputText(".\n\nAfter several minutes, both of you are done and there's no cum left. You lay down next to Etna for a moment, enjoying the afterglow of your shared dinner. That was quite a good meal and seeing as she has several barrels of this which she seems to replenish daily you like the idea of doing this again. You head back to your tent most satisfied.");
	doNext(camp.returnToCampUseOneHour);
	player.sexReward("cum");
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

public function mishapsLunaEtna():void {
	clearOutput();
	outputText("You go check on Etna but find her sleeping in broad daylight. She acknowledges you for a second only.\n\n");
	outputText("\"<i>Yawn... Sorry [name] since I found those weird herbs next to my carpet I just feel so drowsy. We will talk again later okay?</i>\"\n\n");
	outputText("Well, guess you will come back later then, but herbs? Now that you look at them these herbs indeed look like catnip. You remove them from Etna direct environment for now. Still who would actually do this kind of prank?\n\n");
	if (player.hasStatusEffect(StatusEffects.CampLunaMishaps2)) player.addStatusValue(StatusEffects.CampLunaMishaps2, 1, 1);
	else player.createStatusEffect(StatusEffects.CampLunaMishaps2, 1, 0, 0, 0);
	if (!player.hasStatusEffect(StatusEffects.LunaWasCaugh)) player.createStatusEffect(StatusEffects.LunaWasCaugh, 1, 0, 0, 0);
	else player.addStatusValue(StatusEffects.LunaWasCaugh, 1, 1);
	if (player.statusEffectv1(StatusEffects.LunaWasCaugh) == 3) outputText("<b>That's it, you're sure of it now, it's all Luna's doing!</b>\n\n");
	doNext(playerMenu);
}



private function tailExploration():void {
	clearOutput();
	outputText("Your eyes zero in on Etna's tail pussy. This thing is so juicy and filled with fluids it constantly drools. You lick your lips in anticipation, Etna giving you a worried look. \n"
		+ "\n"
		+ "“<i>Hey, uh... why are you eyeing my tail like that?</i>”\n"
		+ "\n"
		+ "You reply with a gooey perverted smile of your own before sloshing over to her and flowing straight into her tail. Etna screams in confusion and fear but this quickly turns to moans as you pour inside.\n"
		+ "\n"
		+ "“<i>Eeeeep, stop! You’re breaking me, I swear I’m going to break!</i>”\n"
		+ "\n"
		+ "Pint by pint you flood her cunt until you are all in, the manticore begging for you to stop. Midway you hear something hit the ground next to you but heck you don’t care, this cunt is a treasure trove. Every single crevice of her tail wall is dripping with girl fluids and you can even taste the residual cum of her few past meals. Etna/The manticore’s tail is twitching as you violate her insides like no other cock could. Her screams are so loud you can hear her moans of ecstasy from inside. Deciding to go to the depth of the matter you finally reach the end of her tail at the base of her ass which might as well be connected to her stomach and unsurprisingly it is. Since you aren't interested into a digestive acid bath you lick clean the rest of her tail walls with your body, making sure to remove any remnant of cum, and begin to flood out. As you finish oozing on the ground you hear a confused moan and turn over. Etna is on the ground, eyes crossed from the mind-blowing sex you performed inside her tailcunt. Eh?! You hope you didn’t break her, this must be quite the experience, one you would sure love to do again.\n");
	player.sexReward("vaginalFluids");
	doNext(camp.returnToCampUseOneHour);
}

public function etnaSleepToggle():void {
	clearOutput();
	if (flags[kFLAGS.SLEEP_WITH] != "Etna") {
		outputText("“<i>Nyaaaa I thought you would never ask. Sure I will gladly sleep with you [name]. " +(player.hasCock()? "Just don’t be surprised if I feel thirsty in the morning.":"")+ "</i>”");
		flags[kFLAGS.SLEEP_WITH] = "Etna";
	} else {
		outputText("“<i>Oh, well if you dont want to sleep with me anymore, I understand [name]. </i> she says sulkily with her tail hanging low.");
		flags[kFLAGS.SLEEP_WITH] = "";
	}
	doNext(etnaCampMenu);
}

public function sleepWithEtna():void {
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("Etna is already waiting for you on the couch and warmly wraps her paws around you as she snuggles up to you. Her fur is warm and silky adding to your comfort like a nice blanket. ");
	if (player.hasCock()) outputText("She gently unwinds and plugs her tail to [onecock] penis making you gasp in pleasure as she slowly begins to massage you. Well, you won’t have to be afraid of any wet dream soiling the bed with Etna around. ");
	outputText("You slowly doze off to her slow loving heartbeat.[pg]");
	outputText("“<i>Good night love. Rest easy, you are with me and I won’t let anything happen to you. I will guard your dreams for you.</i>”[pg]");
	if (player.hasCock()) {
		player.sexReward("vaginalFluids", "Dick");
	}
	doNext(camp.sleepWrapper, 1.2);
}

public function etnaInfidelityEncounter():void {
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("As you wander in the hills area you spot a few unconscious minotaurs snoring on the floor. You thought having her as your girlfriend would’ve helped her condition but it seems Etna is still busy screwing everything she can when you're not at camp. You find her not far away, busy raping what’s left of a minotaur.[pg]");
	outputText("“<i>Fill my tail, you brutish idiot! Don’t you see I’m hungry!</i>”[pg]");
	outputText("The poor bull man’s face is caught between orgasm and pain and you imagine all too well he is forcibly being milked of more than he could possibly carry. You approach Etna, planning on asking her an explanation as to her complete infidelity she quickly acknowledges your presence, looking worried.[pg]");
	outputText("“<i>Uh, oh… [name] it's not what you think! I was hungry and I… well you see all these walking reservoirs around here and...</i>”[pg]");
	menu();
	addButton(0, "Accept", acceptInfidelity);
	addButton(1, "Break off", breakOffInfidelity);
	addButtonIfTrue(2, "Satisfy her", satisfyHerInfidelity, "You dont have enough cum to satisfy her", player.cumQ() >= 2000);

	function acceptInfidelity():void {
		clearOutput();
		outputText("It’s ok, you understand you can’t satisfy this crazy hunger of hers all on your own. Heck, she would be the death of you.[pg]");
		outputText("“<i>T...Thanks [name] I will try to make it up to you one way or another!</i>”[pg]");
		outputText("That said you leave Etna to her lunch heading back to camp just in time to see the minotaur explode in her tail again.[pg]");
		EtnaInfidelity = 1;
		doNext(camp.returnToCampUseOneHour);
	}
	function breakOffInfidelity():void {
		clearOutput();
		outputText("You just can’t stand knowing Etna has been cheating all this time with countless partners and tell her not to bother coming back to camp as your relationship is over. Etna seems like she’s about to break in tears but your position is final.[pg]");
		outputText("“<i>Nooo! [name] please do not abandon me I wouldn’t be able to stand it!</i>”[pg]");
		outputText("She keeps begging and crying but your decision is final. You leave the heartbroken manticore behind as you head back to camp. Her last words carry in the wind like a sharp knife giving you the chills.[pg]");
		outputText("“<i>You CANNOT deny our love! I will force you to acknowledge it and stalk you to the end of the world if I have to! [name] you are MINE just as I am yours, our bonds are unbreakable!</i>”[pg]");
		EtnaInfidelity = 2;
		etnaAffection(-60);
		if (flags[kFLAGS.SLEEP_WITH] == "Etna") flags[kFLAGS.SLEEP_WITH] = "";
		if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] > 2) flags[kFLAGS.ETNA_TALKED_ABOUT_HER] = 2;
		doNext(camp.returnToCampUseOneHour);
	}
	function satisfyHerInfidelity():void {
		clearOutput();
		outputText("You mention to the manticore that if she was so hungry all she had to do was to tell you about it. You have enough cum within you to knock up an army of women if need be.[pg]");
		outputText("“<i>You.. you’re kidding you had this much yet you never let me know? Fine, fine my days of infidelity are over but I expect you to fulfill your end of the bargain, lover.</i>”[pg]");
		outputText("On these words, she knocks the minotaur she was raping unconscious and heads back to camp adding.[pg]");
		outputText("“<i>I will expect my daily share once you’re home.</i>”[pg]");
		outputText("You really hope you didn't get in over your head.[pg]");
		EtnaInfidelity = 3;
		doNext(camp.returnToCampUseOneHour);
	}
}
public function etnaInfidelityEncounterRepeat():void {
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("As you wander in the high mountain/mountain area you spot a few unconscious minotaurs snoring on the floor. You thought having her as your girlfriend would’ve helped her condition but it seems Etna is still busy screwing everything she can when you're not at camp. You find her not far away, busy raping what’s left of a minotaur.[pg]");
	outputText("“<i>Fill my tail, you brutish idiot! Don’t you see I’m hungry!</i>”[pg]");
	outputText("The poor bull man’s face is caught between orgasm and pain and you imagine all too well he is forcibly being milked of more than he could possibly carry. You approach Etna, planning on asking her an explanation as to her complete infidelity she quickly acknowledges your presence, looking worried.[pg]");
	outputText("“<i>Uh, hello… [name]. I was hungry and I… well you see all these walking reservoirs around here and...</i>”[pg]");

	menu();
	addButton(0, "Next", camp.returnToCampUseOneHour);
	addButtonIfTrue(1, "Satisfy her", satisfyHerInfidelity, "You dont have enough cum to satisfy her", player.cumQ() >= 2000);

	function satisfyHerInfidelity():void {
		clearOutput();
		outputText("You mention to the manticore that if she was so hungry all she had to do was to tell you about it. You have enough cum within you to knock up an army of women if need be.[pg]");
		outputText("“<i>You.. you’re kidding you had this much yet you never let me know? Fine, fine my days of infidelity are over but I expect you to fulfill your end of the bargain, lover.</i>”[pg]");
		outputText("On these words, she knocks the minotaur she was raping unconscious and heads back to camp adding.[pg]");
		outputText("“<i>I will expect my daily share once you’re home.</i>”[pg]");
		outputText("You really hope you didn't get in over your head.[pg]");
		EtnaInfidelity = 3;
		doNext(camp.returnToCampUseOneHour);
	}
}

private function etnaJumpsPCinCamp():void {
	clearOutput();
	outputText("Etna pounces on you as you enter your camp, she's obviously very hungry.[pg]");
	outputText("“<i>[name] I’m starved! Give me some food now!</i>”[pg]");
	EtnaJumpedToday = true;
	if (!player.hasCock() && player.hasKeyItem("Demonic Strap-On") <= 0) {
		outputText("Etna walks to you and she looks really angry.[pg]");
		outputText("“<i>Look our deal is that you will feed me the cum I need to survive and there is no way you can with this equipment. Either grow back a dick or find some other way to do it. I don't care how, you need to provide me cum.</i>”[pg]");
		outputText("Etna flies out of camp likely looking for a meal.[pg]");
		outputText("“<i>Until you can fulfill your promise I will be hunting outside and only coming back by night time. You know what to do!</i>”[pg]");
		outputText("Maybe you do need a dick to satisfy her?");
		EtnaHunting = true;
		doNext(playerMenu);
		return;
	}
	menu();
	addButton(1, "LetHerBeInCharge", etnaLetHerBeInCharge);
	addButton(2, "KittyTitFuck", etnaKittyTitFuck).disableIf(!player.hasCock(), "Req. a cock!");
	addButton(3, "Pussy Opera", etnaPussyOpera).disableIf(!player.hasCock(), "Req. a cock!");
	addButton(6, "Share a Drink", etnaShareDrink).disableIf(player.tailType != Tail.MANTICORE_PUSSYTAIL, "Req. to have a manticore pussytail.");
	addButton(7, "Fill her up", EtnaFillHerUp).disableIf(!player.isAlraune(), "Req. to be an alraune.");
	addButton(8, "TailExplor", tailExploration)
			.hint("Play with her tail using your goo body!", "Tail Exploration")
			.disableIf(!player.isGoo(), "Req. goo body.");
}

private function etnaAfterInfidelity():void {
	clearOutput();
	spriteSelect(SpriteDb.s_etna);
	outputText("Etna notices you approaching and moves to you right away.[pg]");
	outputText("“<i>Hey, uh, about the minotaurs…, sorry you had to witness that, it's just the way I am I can’t hold myself back.</i>”[pg]");
	outputText("You understand all too well."+(EtnaInfidelity == 1? "":"Considering the insane appetite she has, it would be impossible even for ten men to satisfy her entirely.")+"[pg]");
	outputText("“<i>Say, I’ve been thinking about this and I’m quite sure now that it’s only you that I want. So if you would accept me, I would like to grant you something all the others won’t get……</i>”[pg]");
	outputText("Well, can she go ahead and spill it out, you don’t have all day.[pg]");
	outputText("“<i>I would like us to…</i>”[pg]");
	outputText("She’s visibly shaking in embarrassment and you're starting to ponder what she's trying to say. Waiting for her to speak up is getting increasingly annoying.[pg]");
	outputText("“<i>I WOULD LIKE US TO HAVE CHILDREN!!! That's right… I said it… children! I don’t want you to think that just because I eat all of these cocks it means you aren’t the ONE male in my life anymore!</i>”[pg]");
	outputText("Well, that's a surprise, but then again she did say she would make it up to you. Well, if she’s ready to be a mother then you don’t mind. You tell her that whenever she will be pregnant you will be there for her, then head back to your things still considering the ramification of this decision.[pg]");
	outputText("<b>Etna is off her contraceptive herbs</b>");
	EtnaFertile = true;
	doNext(camp.returnToCampUseOneHour);
}

public function etnaKnockupAttempt():void {
	if (pregnancy.isPregnant || !EtnaFertile && EtnaDaughterScene.EtnaDaughterAge > 0) return;
	if (rand(8) == 0 || player.cumQ() > rand(3000) || player.virilityQ() >= 0.7) {
		pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_ETNA);
		if (flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS]) outputText("\n<b>Etna is pregnant!</b>");
	}
}

private function etnaPregUpdate():Boolean {
	switch (pregnancy.eventTriggered()) {
		case 2: //
			outputText("\nWhen you come to check on Etna you notice she’s smiling as she caresses her belly, which bulges notably, but not with any real prominence. \n");
			return true;
		case 3:
			outputText("\nEtna's belly is definitely swollen now, forming a round bump which likely means she’s pregnant with a cub.\n");
			return true;
		case 4:
			outputText("\nWhen you come to check on Etna you notice she’s smiling as she caresses her belly. Furthermore, it’s bigger than before which likely means she’s pregnant with a cub. Still, the future mother walks to you with a delighted smile. [pg]" +
					"“<i>I know when you're near me, as our daughter gets more agitated inside.  I’m sure she loves you already. So how are you doing today [name], have you come to check on the baby?</i>” \n");
			return true;
		case 5:
			outputText("\nYou'd say Etna is going to give birth soon, she has swollen up to the point that she looks nine months pregnant. She has taken to resting frequently, and any form of labor easily leaves her winded. Despite this she often seems to disappear and when confronted she replies with a tone of exasperation \"<i>I couldn't help it, I had to find something to eat.</i>\"\n");
			return true;
	}
	return false; //If there's no update then return false so needNext is not set to true
}
private function etnaPregApproach():Boolean {
	switch (pregnancy.event) {
		case 1: //
			outputText("\nWhen you come to check on Etna you notice she’s smiling as she caresses her belly, which bulges notably, but not with any real prominence. \n");
			return true;
		case 2:
			outputText("\nEtna's belly is definitely swollen now, forming a round bump which likely means she’s pregnant with a cub.\n");
			return true;
		case 3:
			outputText("\nWhen you come to check on Etna you notice she’s smiling as she caresses her belly. Furthermore, it’s bigger than before which likely means she’s pregnant with a cub. Still, the future mother walks to you with a delighted smile. [pg]" +
					"“<i>I know when you're near me, as our daughter gets more agitated inside.  I’m sure she loves you already. So how are you doing today [name], have you come to check on the baby?</i>” \n");
			return true;
		case 4:
			outputText("\nYou'd say Etna is going to give birth soon, she has swollen up to the point that she looks nine months pregnant. She has taken to resting frequently, and any form of labor easily leaves her winded. Despite this she often seems to disappear and when confronted she replies with a tone of exasperation \"<i>I couldn't help it, I had to find something to eat.</i>\"\n");
			return true;
	}
	return  false;
}

private function etnaGivesBirth():void {
	spriteSelect(SpriteDb.s_etna);
	clearOutput();
	outputText("Etna comes to you this night giving you those big eyes as she announces.[pg]");
	outputText("“<i>I’m about to give birth! I’m about to give birth to our daughter!</i>”[pg]");
	outputText("Well, wow, now that you're in the heart of things you can’t back out of your promise. You help the soon to be mother lay down as she starts singing again. Her pussy must be extremely sensitive right now and the birth isn’t helping. She starts pushing with a gleeful expression on her face as the baby stretches her hole wide and begins its way down it. Soon a human-like baby with the features of a cat, bat, and scorpion is out.[pg]");
	outputText("“<i>P...please let me hold our child… I want to see her.</i>”[pg]");
	outputText("You let her hold the crying baby against herself. She soothes your newborn girl by singing a melodious lullaby as she does it so well. It could come as strange to see the normally somewhat ferocious or lusty manticore act like a normal, if not, caring mother. You can’t help but be smitten at the picture. ");
	outputText("She eventually comes to a realization.[pg]");
	SceneLib.etnaDaughterScene.nameEtnaDaughter();
}

public function etnaTotalKids():int {
	return EtnaDaughterScene.EtnaDaughterAge > 0 ? 1 : 0;
}

	}
}
