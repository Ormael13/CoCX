/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ashlands
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armors.LustyMaidensArmor;
import classes.Items.MutationsHelper;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class HellCatScene extends BaseContent
	{
				public var mutations:MutationsHelper = new MutationsHelper();

		public function HellCatScene()
		{
		}

public function HellCatIntro():void {
	spriteSelect(SpriteDb.s_Hellcat_16bit);
	clearOutput();
	outputText("As you explore the crag you run into a strange sight. You spot a hooded figure with a cape walking silently toward you. Only when it’s finally up close does it throw its cape open revealing the ashen naked skin of a human woman inside—or what what might have been a human, if not for the swishing tail of fire, black furry cat legs and pawed hands with sharp claws. The hood now pulled back reveals a somewhat human face with eyes and hair ");
	outputText("of literal fire and feline ears to top it off. Well, guess you have seen everything now, including pyrocatgirls. Speaking of pyro, the intent of the cat girl manifests as a large fireball which she proceeds to throw at you. Barely dodging this surprise assault you steady yourself just in time to see her grin wide as a 10-inch spiked cat cock slides out of the sheath just above her drooling pussy. You ready your [weapon] for a fight!");
	camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_HELLCATS);
	if (flags[kFLAGS.WITCHES_SABBATH] < 1) flags[kFLAGS.WITCHES_SABBATH] = 1;
	startCombat(new HellCat());
}
public function DefeatedHellCat():void {
	clearOutput();
	outputText("The Hellcat falls on her knees, unable to fight further. She’s shaking like an overheating cauldron with the lid shut.\n\n");
	outputText("\"<i>Please... I beg of you... fuck me, rape me, I don’t care, I just want the heat to go!</i>\"\n\n");
	outputText("How amusing, you guessed right, she's completely and literally consumed by her heat. The big question is... should you really indulge her?");
	menu();
	addButton(0, "Back", cleanupAfterCombat);
	if (player.hasCock()) addButton(1, "Pussycat", DefeatedHellCatPussycat);
	if (player.hasVagina()) addButton(2, "Catcock", DefeatedHellCatCatcock);
    LustyMaidensArmor.addTitfuckButton(3);
	SceneLib.uniqueSexScene.pcUSSPreChecksV2(DefeatedHellCat);
}

public function DefeatedHellCatPussycat():void {
	if (player.gender == 3) outputText("You ain’t gonna get any close to that feline penis of hers. " + (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] > 0 ? "If your hunch is good it’s likely even worse than that of the hellhounds. " : "") + "");
	outputText("However her pussy is, for lack of any better word, a hell of a lot more tempting.\n\n");
	outputText("You firmly shove the catgirl down taking hold of her generous breasts for handles as your own cock hardens" + (player.hasSheath() ? " out of its sheath" : "") + " to readiness in anticipation of her. The hellcat doesn’t even struggle, instead taking on the most inviting position she can muster, her wet snatch drooling in anticipation. Unable to wait any further you proceed to slowly insert your rod between her open folds, her pussy attempting ");
	outputText("to wrap around every inch of your length" + (player.cockAdjective.length > 20 ? ", which to your absolute surprise it does. Guess corrupted creatures are all adept at taking impossible lengths and girths in" : "") + ". Now fully in control, you savor the sensation of your [cock] as you proceed to mate with the catgirl. ");
	outputText("God the slut is enjoying herself even more than you are, guess you can’t rape the willing? You would tell her to shut the fuck up if you weren't busy moaning from the hellish ministrations of her pussy around your cock.\n\n");
	outputText("Before a minute has passed you’re already reaching your own orgasm, your [cock] flooding her warm cunt with fresh baby batter. The hellcat only relaxes her rocking hips once you’ve shot all of your ropes inside, purring in contentment. Done with the horny witch, you grab back your gear and head back to camp.");
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}
public function DefeatedHellCatCatcock():void {
	if (silly()) outputText("Oh my gawsh, a true catcock for once! You’ve seen horse, dog, demon, lizard, dragon, and even plant dongs so why is it you could never find a cat one to bone yourself with in the entirety of this porn adventure" + (flags[kFLAGS.AKBAL_SUBMISSION_STATE] != 0 ? " save for Akbal" : "") + "?! ");
	outputText("You gleefully walk out to your prize and shove her on her back to take a look at the 10 inch joystick between her legs. The hellcat looks at you confused.\n\n");
	outputText("\"<i>Nya?? Are you seriously doing this? Next time why not just skip defending yourself and get to it right away?</i>\"\n\n");
	outputText("You squeeze her cock painfully. Who said she had right to talk back? You make it quite clear that you will do with her what you want and only what you want, which swiftly wipes away that coy smirk of hers. Now that positions have been clearly determined, you move over the hellcat in order to slowly align you pussy with that barbed cock of hers. You sigh as her barbs one by one slide past your lips, tickling your walls with devilish pleasure. ");
	outputText("Only once your unwilling partner is fully in do you begin to slide up along the length, savoring the multitude of caresses that go with the movement. You moan loud and high as you grab the catgirl's orbs for support, enjoying yourself as the growing sensation of heat permeates your pussy. The heat travels everywhere in your body until it reaches your brain. ");
	outputText("You are so distracted by the overload of sensations that you forget your partner who, reaching her own orgasm, floods your burning pussy with a welcome load of catjizz. You thought this would end the heat, but it only makes it worse; the hot cum bubbling in your pussy only seems to make the heat in your brain more intense. You need to fuck, you desperately need to fuck!\n\n");
	outputText("The catgirl does not seem to mind as you repetitively ravish her cock. Only when she passes out from exhaustion do you realise her cum is only intensifying the heat. You kick her in frustration before you head back to camp. <b>It would seem you have gone into heat!</b>");
	player.goIntoHeat(false);
	player.sexReward("cum","Vaginal");
	cleanupAfterCombat();
}
public function DefeatedByHellCat():void {
	clearOutput();
	if (flags[kFLAGS.WITCHES_SABBATH] > 3) {
		outputText("The hellcat sighs at you in disapproval as you kneel in defeat.\n\n");
		outputText("\"<i>Seriously sister this whole fight was unnecessary, I was just trying to fix you. Don’t worry It will be over shortly.</i>\"\n\n");
		outputText("On this she resumes incanting her spell. ");
		flags[kFLAGS.WITCHES_SABBATH] += 2;
		WitchesSabbathFourthVisitYeahSure2();
	}
	else {
		outputText("You fall to the ground, unable to fight further and the hellcat’s smile widdens.\n\n");
		outputText("\"<i>How purrfect, I suggest you stay still and not try anything funny. Else I could accidentally torch you alive.</i>\"\n\n");
		outputText("Considering how much fire she packs up, literally and figuratively, you consider it is better indeed to not anger her. " + (player.isNaked() ? "" : "She moves her clawed finger across your gear, stripping you naked so she can better admire what she’s caught. ") + " Her paws trace the shape of your body before moving all the way to your ass, which she grabs firmly. You can already feel the barbs of her cock tickling the entrance to your pucker ");
		outputText("as she begins to insert herself in. You are almost thankful her cock isn’t as big as those of the majority of the corrupted creatures that wander Mareth, but your relief is short lived as she begins to pound your ass in earnest. For some weird reason, the more she pounds you the hotter you get, until you realise with horror what is going on. She’s not just getting off, she is outright transferring her heat to you!\n\n");
		outputText("You begin panting in desire, your breath following the rhythm of her thrusts until she finally explodes, filling your ass with kitty jizz. You let yourself go limp on the ground but the hellcat is far from done with you.\n\n");
		outputText("\"<i>What do you think you’re doing laying down like that? I’m far from done!</i>\"\n\n");
		outputText("She proceeds to straddle your face with her pussy making her intentions clear. Well, since you let your ass be fucked you might as well lick her too? You begin to lick the horny cat girl so as to avoid her wrath, as she rewards you with sounds not unlike purring. Surprisingly, her juices taste similar to cinnamon, which in itself is not that bad. You keep on licking the lusty catgirl herm, trying your darn best to make more of this juice flow out.\n\n");
		outputText("\"<i>Oh my gosh, sooo close... keep going...just keep... Ahhhhn!</i>\"\n\n");
		outputText("Yea, she’s definitely enjoying it, and the way she's slamming her pussy in your mouth while groping her own breast only confirms that. It takes a few extra seconds for her to flood your face with your just reward. That said, she cums so hard she forget to let you breath and make you faint from asphyxia.\n\n");
		outputText("When you come back to, your stuff is exactly where you left it. That said, you feel hot... especially down in your genitals. Thought of fucking and getting fucked harass your minds. ");
		if (player.gender == 1) {
			outputText("<b>It would seem you have gone into rut!</b>");
			player.goIntoRut(false);
		}
		if (player.gender == 2) {
			outputText("<b>It would seem you have gone into heat!</b>");
			player.goIntoHeat(false);
		}
		if (player.gender == 3) {
			outputText("<b>It would seem you have gone into both heat and rut at the same time!</b>");
			player.goIntoRut(false);
			player.goIntoHeat(false);
		}
		player.sexReward("vaginalFluids","Dick");
		cleanupAfterCombat();
	}
}

public function WitchesSabbath():void {
	spriteSelect(SpriteDb.s_Hellcat_16bit);
	clearOutput();
	if (flags[kFLAGS.WITCHES_SABBATH] > 3) {
		if (player.gender == 3) {
			outputText("As you explore the crag you stumble upon a small volcanic cave. Inside, you eavesdrop on the hellcats chanting some dark ritual again, seems they're up for another conversion. As you step toward the ritual for a better look, another hellcat invites you in.\n\n");
			outputText("\"<i>Welcome sister, you came over just in time for the sabbath. We would be overjoyed if you joined us for the initiation ritual.</i>\"\n\n");
			outputText("Of course you will participate; you have been antsy all day and this would likely be a chance to blow some steam. You walk toward the eldritch circle and join with the other hellcats for the spell just in time for the mistress of ceremony to begin.\n\n");
			outputText("\"<i>I welcome you all today for this celebration of the black sabbath. Praise be sisters for today we raise a new woman into the coven.</i>\"\n\n");
			outputText("Unsurprisingly, the chosen petitionner is all but calm and even looks somewhat scared. It will all be better soon however. You wait for your turn as the witches proceed to take part in the ritual by getting a taste of the sacrificed pussy. When it becomes your turn to step forward you dive in eagerly, tasting her dripping juices. ");
			if (flags[kFLAGS.WITCHES_SABBATH] == 4) outputText("Not what you expected actually, some magic must be at work, how else could her cunt taste so sweet? ");
			outputText("The girl, however, does not seem to enjoy it as much, your rough tongue making her wince in mixed pain and pleasure. Just she hang on though, it gets better. The licking done, the leading Hellcat grabs the blessed idol on the altar, aligning it with the petitioner's asshole before she gets to sliding inch after inch of the thing in. The girl begins to pant as the cursed idol bottoms up, fully plugging her ass.\n\n");
			outputText("The base preparations now over, the leading Hellcat begins incanting again. Unsurprisingly you can understand every single arcane word of the incantation.\n\n");
			outputText("\"<i>The petitioner who wishes to enter the covenant now lays down on your altar.</i>\"\n\n");
			outputText("As you all begin chanting the unholy prayer, increasing heat builds up in your sheath and you have high trouble stifling the mewls of pleasure as your spiked dick slide out inch by inch, dripping precum. As the ritual proceeds, you can feel black magic suffuse every bit of your erect cat cock. Last of all the mistress of ceremony's own unholy, barbed cock slide out of her sheath and hardens.\n\n");
			outputText("You almost cry out in pleasure as she inserts herself in the supplicant, every sensation replicated to your own penis. The licking wasn’t only for show, it’s to link your cocks together and now you can feel everything as the leader thrusts inch by inch of her length in the sacrifice's pussy.\n\n");
			outputText("You keep on incanting, your eyes to the sky as thrust after thrust the leader gives the beat, your cock pulsing from the phantom cunt wrapped around your flesh.\n\n");
			outputText("\"<i>Great Lord Abraxas, we offer you this bride. GRANT HER YOUR BLESSING!</i>\"\n\n");
			outputText("The leading hellcat finally reaches her climax, sending you all over the edge as your joined cocks shoot the sacrifice with ropes after ropes of white blessing.\n\n");
			outputText("The ‘sacrifice’ screams as if lost between pleasure and madness as her flesh seems to blur and shift right above her pussy. As the blessing of your dark god concentrates between her thighs, a newly formed sheath melds itself from her raw flesh and a brand new barbed cat cock slowly slides out of it like a wet tongue out of a mouth. Her tail and hairs catch on fire and her tears turn to flames as her newly formed cat prick keeps ");
			outputText("growing and pulsing with the ritual's unholy magics until it reaches its full length at 10 inches or so, twitching one last time before unloading a deluge of cum, splattering the woman's own breasts. The fire finally recedes slightly as her skin seems to smoke, turning about the same color of ash as the fellow hellcats. The ceremony is now over, it’s time for the new sister to rest. ");
			outputText("She is gently escorted to the common by the leader for a rest while you get to wipe off the remaining strand of jizz from your barbed crown on the altar.\n\n");
			outputText("You take time to enjoy a short chat with your fiery sisters before waving goodbye and heading back to camp. There will be more rituals like these at a later time, but for now you got work to do.");
			if (flags[kFLAGS.WITCHES_SABBATH] == 4) flags[kFLAGS.WITCHES_SABBATH]++;
			endEncounter();
		}
		else {
			outputText("As you explore the crag you run into a hooded figure with a cape walking silently toward you, looks to be another hellcat witch. You stride toward her to say hello. She greets you as you get in range.\n\n");
			outputText("\"<i>Great day sister how well are you weathering the warmth?</i>\"\n\n");
			outputText("She then stops as if she smelled something, then looks at your body in confusion.\n\n");
			outputText("\"<i>Hey what happened there?! Ah no worry sister, I’m going to fix this dreadful curse for you.</i>\"\n\n");
			outputText("She’s definitively about to perform magic on you. Do you let her?");
			menu();
			addButton(0, "Yeah Sure", WitchesSabbathFourthVisitYeahSure).hint("Let her cure your body's \"curse\"");
			addButton(1, "No Way", WitchesSabbathFourthVisitNoWay).hint("You don't need the Hellcat's cure");
		}
	}
	else if (flags[kFLAGS.WITCHES_SABBATH] == 3) {
		outputText("As you explore the crag you spot a procession of hellcats heading to the so called ritual cave. It would be unwise not to follow them again, yet you are curious as to what will happen, perhaps you could even stop them? Do you dare fellow them?");
		menu();
		addButton(0, "No", WitchesSabbathThirdVisitNo).hint("After last time? No way you're hanging out with these chicks!");
		addButton(1, "Yes", WitchesSabbathThirdVisitYes).hint("You couldn't figure out enough of how it worked last time.\n\nPerhaps this time you can get a better understanding?");
	}
	else if (flags[kFLAGS.WITCHES_SABBATH] == 2) {
		outputText("As you explore the crag, you stumble upon a small volcanic cave. Inside, you eavesdrop on the circle of hellcats chanting some dark ritual again, except this time you are way closer than before. You manage to see a desecrated altar with a shackled cat morph on it. Whatever they are doing they are clearly up to no good. ");
		outputText("Entranced by this unholy spectacle, you outright forget to hide and one of the chanters spots you right away. At first you consider running away, but instead the catgirl motion you to step forward.\n\n");
		outputText("\"<i>Welcome " + player.mf("broth","sist") + "er, you came over just in time for the sabbath. We would be overjoyed if you joined us for the ritual.</i>\"\n\n");
		outputText("You seem to have two options: either you join in this unholy ritual or you get the hell out of there before the entire coven is on you.");
		menu();
		addButton(0, "Run", WitchesSabbathSecondVisitRun).hint("Hell no I ain't trusting cults");
		addButton(1, "Join", WitchesSabbathSecondVisitJoin).hint("Can't judge a group of mages without knowing what they're doing");
	}
	else {
		outputText("As you explore the crag you stumble upon a small volcanic cave. Inside, you eavesdrop on a circle of hellcats chanting some dark ritual. Seeing as the last time you met one of those girls you got yourself set on fire, you keep a fairly good distance to not get spotted. The fiery catgirls recite some form of incantation, but past some point you fail to understand what is truly going on amidst the sounds of orgasm from the assembly. ");
		outputText("Eventually the ritual ends and they leave the cave heading toward your direction. Wise enough not to take on a whole bunch of them, you run for it before they spot you. Whatever is going here, you plan to find out eventually.");
		flags[kFLAGS.WITCHES_SABBATH]++;
		endEncounter();
	}
}
public function WitchesSabbathSecondVisitRun():void {
	outputText("\n\nWhatever they are doing is likely corrupt in nature and whoever is on the altar will clearly be used in the ritual. You don’t plan on being the next one on that altar so you run away from the feline spellcaster before she gets the time to cast a curse or something of the like. You keep running until you finally reach the safety of your camp.");
	endEncounter();
}
public function WitchesSabbathSecondVisitJoin():void {
	outputText("\n\nWhy not? You happen to have a keen interest in everything magical. There's no way you would miss out on an opportunity to study those feline witches' magical practices up close. The Hellcats let you walk closer to the circle so you can fully see what this is about. The interruption now over, the hellcats resume their unholy chanting and, try as you may, you fail to fully fellow them. Though you do manage to learn a few ");
	outputText("of the spellcasting words they use, this ritual so far escape your grasp.\n\nAs the ritual end is closing in, you finally realise what was off from the beginning. For one, the shackled cat woman does not seem fully aware, as if she had been drugged, for two, unlike the others, she has no obvious male endowment to begin with, and for three, the woman is clearly not an hellcat herself, instead showing the traits of a standard cat morph. ");
	outputText("The Leader, unconcerned, recites the next verse.\n\n\"<i>Qui voluerit ex se intrare pactum et occulte ponit super altare...</i>\"\n\n");
	outputText("At first you think this is about to end in a bloody ritualised sacrifice, but then understand what is about to happen as the ritual leader steps forward, her barbed cock sliding out of her sheath. You can only gawk in arousal and confusion as she grabs the shackled girl by the legs. Now properly stabilized, she goes for the penetration, moaning the rest of the incantation as she proceeds to methodically fuck the ‘sacrifice’.\n\n");
	outputText("What started as a magical ritual turns to something else as everyone else begins to fiercely masturbate and some unnatural lust overtakes you causing you to join them in the act. As the sacrifice reaches her orgasm, the leading witch screams the final verse.\n\n");
	outputText("\"<i>Hostias tibi Domine Abraxas sic. DONA NOBIS BENEDICTIONEM TUAM!</i>\"\n\n");
	outputText("At that moment the hellcats all cum together in a chorus of mewling, covering the sacrifice with ropes of kitty spunk as their barbed futa rods shoot all the way to the altar. The leader, having her cock deeply embedded in the ‘sacrifice’, proceeds to fill her up to the brim in the same way. The ‘sacrifice’ screams as if lost between pleasure and madness as her flesh seems to blur and shift right above her pussy. ");
	outputText("A sheath, which until now was not there, has formed at the base of her crotch and a barbed cat cock slowly slide out of it. Her tail and hairs catches on fire and her tears turn to flames as her newly formed cat prick keeps growing and pulsing with corrupted magic until it reach its full length at 10 inches or so, twitching one last time before unloading a deluge of cum, splattering the woman's own breasts. ");
	outputText("The fire finally recedes slightly as her skin seems to smoke, turning about the same color as ash. The ceremony ends as the woman is properly covered with a drape by the leader and escorted to the side.\n\n");
	outputText("You decide not to prolong your stay any further then this for your own good and safety as the hellcats are busy attending the newly converted woman.");
	flags[kFLAGS.WITCHES_SABBATH]++;
	endEncounter();
}
public function WitchesSabbathThirdVisitNo():void {
	outputText("No way in hell you’re going to be anywhere close to the feline witches while they do their unholy ritual. You get out of here before they even notice you were spying on them.");
	endEncounter();
}
public function WitchesSabbathThirdVisitYes():void {
	outputText("Curiosity triumphs against your better judgement. You need to know what they are doing, and perhaps, once they're done, you will even destroy their ritual site to prevent them from ever using it again.\n\n");
	outputText("You close in and follow them all the way to the cave. Something's not right though. The last time you came there was someone tied up on the altar.\n\n");
	outputText("\"<i>Why hello there little kitty.</i>\"\n\n");
	outputText("You curse and turn to be greeted by a familiar sight. It’s the girl who was used in the previous ritual, except this time around she has burning hairs, ashen skin, a vicious smile and fiery eyes that pierce through your soul like spears, leaving you stunned with fear. For a split second you’re too surprised to do anything, which she uses to slam a blackjack up your head knocking you unconscious.\n\n");
	outputText("You wake up, your mind feeling foggy and slow. You have high difficulties assembling your thoughts, which considering you just took a hit to the head isn’t that surprising. You have vague feelings in your body right now. Just enough to know you are shackled down to some cold surface. People are speaking around you, but in your current state of mind you barely take notice. ");
	outputText("Eventually your mind finally gets to move back into motion and you're fully understand your predicament.\n\n\"<i>I welcome you all today for this celebration of the black sabbath. Praise be sisters for today we raise a new woman into the coven.</i>\"\n\n");
	outputText("What the hell, this was not part of the plan! You pull on your shackles, desperate to get free; however, you are tied well, the Hellcats saw to it. Noticing your sudden combativity, the witches deal with it by forcefully having you chug a bottle of what may well be a powerful sedative. You quickly lose your ability to even lift an arm in an attempt to fight back. As the ritual goes on, the witches takes turn to each give your ");
	if (player.hasCock()) outputText("penis");
	else if (player.hasVagina()) outputText("pussy");
	else outputText("empty crotch");
	outputText(" a single, painful lick from their rough tongue, residual magic making you gasp as the sensitivity of your genitals skyrockets, turning pain to pleasure.");
	if (player.hasVagina()) outputText(" Done with the licking, the leading Hellcat goes one step further and grabs the small idol on the altar, aligning it with your asshole before she gets to sliding inch after inch of the thing in. Your pleasure doubles up as the cursed idol bottoms out, fully plugging your ass.");//Furrin: You left no else fields after this, leading to it being nonsense for males and nulls.
	outputText("\n\nThe preparations now over, the leading Hellcat begins incanting again.");
	if (player.hasVagina()) {
		outputText(" This time, to your horror you can understand everything she says, the idol allowing it to echo as a complete translation within your mind.");
		outputText("\n\n\"<i>The petitioner who wishes to enter the covenant now lays down on your altar...</i>\"\n\n");
	}
	else outputText("\n\nYou still can't understand what she's saying, \"<i>Qui voluerit ex se intrare pactum et occulte ponit super altare...</i>\"\n\n");
	outputText("Oh no! This is just like the last time, except this time around you have the questionable honor of front seats as the mistress of ceremony's unholy, barbed cock slides out of her sheath and hardens. ");
	outputText("Too weak from the " + (player.hasVagina() ? "mind numbing pleasure the unholy dildo induce in your ass" : "drug") + ", you fail to mount any form of resistance. ");
	outputText("Before you get any chance to scream, she’s already pressing the tip of her cock against your " + (player.hasVagina() ? "entrance" : "backdoor") + ", the barbs tickling your " + (player.hasVagina() ? "lips" : "ring") + ". She grins wide as inch after inch of her feline dong slides into your " + (player.hasVagina() ? "folds" : "hole") + ". You can’t help but blank out as she fully bottoms in. ");
	if (!player.hasVagina()) outputText ("With her unholy rod up your butt, you realize you can suddenly understand the chanting, the magic creating a translated echo within you. ")
	outputText("If her going in was enough to leave your mind blank, you are terrified--and somewhat aroused--by the idea of what her pumping in you will leave you like. She does not leave you much time to think it over as she proceed to slide out, her barbs tingling your " + (player.hasVagina() ? "canal" : "hole") + " like no other cock could. ");
	outputText("You moan like a wanton whore as the assembly resume on chanting between the moans of their own pleasures. You're going to cum... you’re definitely going to break and cum. Ignoring your state of mind, the Hellcat goes on with the ritual.\n\n");
	outputText("\"<i>Great Lord Abraxas, we offer you this bride. GRANT HER YOUR BLESSING!</i>\"\n\n");
	outputText("You are already a mewling mess on the verge of orgasm when the leading hellcat finally reaches her climax, the powerful jet of cum in your " + (player.hasVagina() ? "pussy" : "ass") + " sending you over the edge as the rest of the assembly covers you with rope after rope of cat jizz. However, your orgasm does not recede. ");
	outputText("To your dismay, it goes on instead as the cum soaks into your skin while heat and pleasure spread to your entire body all the way to your brain. You are on fire! Literally on fire, yet instead of being incinerated by the temperature spike something else happens.\n\n");
	if (!player.hasVagina()) {
		outputText("At first, the heat concentrates in your loins as your flesh seems to burn with agonizing pleasure, distorting and warping itself until a brand new pussy appears " + (player.hasSheath() ? "right under your sheath" : "") + " ready for a barbed cock.");
		player.createVagina();
	}
	if (!player.hasCock()) {
		outputText("You mewl in pleasure as the flesh between your legs" + (player.hasVagina() ? ", right above your pussy," : "") + " heats up and begins to pulse as something not unlike a sheath forms there. You clench your jaw as something slides out inch after inch and you catch glimpse of your newly formed cat cock ");
		outputText("pulsing with an unholy purple glow as it grows bigger and bigger until it reaches a full 10 inches in length, causing you to orgasm, covering your belly and face with cum.");
		transformations.CockCat(0, 10, 2.5).applyEffect(false);
	}
	if (player.hasCock() && player.catCocks() < player.cockTotal()) {
		outputText("Your cock" + (player.cockTotal() > 1 ? "s" : "") + " begin" + (player.cockTotal() > 1 ? "" : "s") + " to feel strange as the warmth begins to warp " + (player.cockTotal() > 1 ? "them" : "it") + " against your will.");
		if (player.hasSheath()) outputText("The surface of your " + (player.cockTotal() > 1 ? "many lengths" : "entire length") + "");
		else outputText(" Pressure builds around " + (player.cockTotal() > 1 ? "their" : "its") + " base" + (player.cockTotal() > 1 ? "s" : "") + " as a newly formed sheath pulls " + (player.cockTotal() > 1 ? "them" : "it") + " into its fold. Only for " + (player.cockTotal() > 1 ? "them" : "it") + " to surge back as the shape of your " + (player.cockTotal() > 1 ? "many lengths" : "entire length") + "");
		outputText(", barbs forming on " + (player.cockTotal() > 1 ? "their" : "the") + " originally smooth cleft until you are left with what appears to be a" + (player.cockTotal() > 1 ? " set of" : "") + " cat penis" + (player.cockTotal() > 1 ? "es" : "") + ". ");//Furrin: Another catcock < total check, in the middle of a check?
		outputText("It does not end there though as your cock" + (player.cockTotal() > 1 ? "s" : "") + " suddenly pulse" + (player.cockTotal() > 1 ? "" : "s") + " with unholy purple light before gaining several extra inches of flesh as devilish pleasure overcomes your kitty pecker" + (player.cockTotal() > 1 ? "s" : "") + " causing you to orgasm, covering your belly and face with kitty cum.");//Furrin: A code could probably go here to verify cocklength but these lines are already jampacked.
		if (player.cockTotal() > 0 && player.catCocks() < player.cockTotal()) reformallcockstokittycocks();
	}
	outputText("\n\nWarmth then rampages all around your body, altering your shape in many lesser ways until you have something fit for a proper female.");
	if (player.breastRows[0].breastRating < 1) player.breastRows[0].breastRating = 5 + rand(5);
	else player.breastRows[0].breastRating += 5 + rand(5);
	if (player.hips.type < 12 || player.butt.type < 12) {
		if (player.hips.type < 12 && player.butt.type < 12) {
			player.butt.type = 12;
			player.hips.type = 12;
		}
		else if (player.hips.type < 12) player.hips.type = 12;
		else player.butt.type = 12;
	}
	if (player.tone > 0) player.tone = 0;
	player.modFem(100, 100);
	outputText(" The heat is almost gone, it heads for your tail, exploding there in a sheath of flame before spiraling toward your head.");
	outputText(" All of these pleasurable changes are driving you insane with desire to the point that you would try to cry, but just as soon as a tear pearls out of your eye it evaporates as two small flames leaks from their corners instead.");
	outputText(" In a final spectacular explosion your hair is set ablaze, the fire refusing to be put out until it literally replaces it.");
	outputText("\n\n");
	outputText(" Your skin tingles with residual heat as well, progressively and delightfully burning toward a ashen hue.");
	player.skinColor = "ashen";
	player.hairColor = "midnight black";
	player.furColor = "midnight black";
	outputText(" Speaking of fire, you're having some hellishly hot thoughts right now. You really wish you could stick that cock of yours in some cunt or get yourself filled good, and hell, with a body like yours, going into heat likely is going to be a recurring two sided joke. <b>You were altered and transformed into a Hellcat!</b>");

	CoC.instance.transformations.TailBurning.applyEffect(false);
	CoC.instance.transformations.HairBurning.applyEffect(false);
	CoC.instance.transformations.EyesInfernal.applyEffect(false);
	if (rand(2) == 0) player.goIntoRut(false);
	else player.goIntoHeat(false);
	flags[kFLAGS.WITCHES_SABBATH]++;
	CoC.instance.mainViewManager.updateCharviewIfNeeded();
	endEncounter();
}
public function WitchesSabbathFourthVisitYeahSure():void {
	outputText("Whatever she is doing you tell her to go on. She’s only trying to help after all. ");
	WitchesSabbathFourthVisitYeahSure2();
}
public function WitchesSabbathFourthVisitYeahSure2():void {
	outputText("You moan, feeling overwhelming heat build in your nethers as ");
	var playerWasAlreadyHerm:Boolean = false
	if (player.hasCock() && player.catCocks() >= 1) playerWasAlreadyHerm = true;
	if (!player.hasCock() || (player.hasCock() && player.catCocks() == 0)) {
		if (player.hasVagina()) reformallcockstokittycocks2();
		if (!player.hasVagina()) {
			reformallcockstokittycocks2();
			outputText("This, however, is just beginning as the magic now moves beneath the base of your sheath as ");
		}
	}
	if (player.gender == 1) {
		outputText("the skin beneath your dick begins to pull apart into a pair of sensitive lips. You can’t help but draw a furry digit inside, moaning in delight as you begin to finger yourself to orgasm. As the magic settles further in, sparks of pleasure shoot in your mind. Once it creates a waiting womb and ready ovaries, you lose it and squirt, splattering the soil with your juice. ");
		player.createVagina();
	}
	if (player.breastRows[0].breastRating < 1) player.breastRows[0].breastRating = 5 + rand(5);
	else player.breastRows[0].breastRating += 5 + rand(5);
	if (player.hips.type < 12 || player.butt.type < 12) {
		if (player.hips.type < 12 && player.butt.type < 12) {
			player.butt.type = 12;
			player.hips.type = 12;
		}
		else if (player.hips.type < 12) player.hips.type = 12;
		else player.butt.type = 12;
	}
	if (player.tone > 0) player.tone = 0;
	player.modFem(100, 100);
	if (playerWasAlreadyHerm) outputText(" your body begins to change.");
	outputText(" The heat heads for your tail, exploding there in a sheath of flame before spiraling toward your head.");
	outputText(" All of these pleasurable changes are driving you insane with desire to the point you would try to cry, but just as soon as a tear pearls out of your eye, it evaporates as two small flames leak from their corners instead.");
	outputText(" In a final spectacular explosion, your hair is set ablaze, the fire refusing to be put out until it literally replaces it.");
	outputText(" Your skin tingles with residual heat as well, progressively and delightfully burning toward a ashen hue.");
	player.skinColor = "ashen";
	player.hairColor = "midnight black";
	player.furColor = "midnight black";
	outputText(" Speaking of fire, you're having some hellishly hot thoughts right now. You really wish you could stick that cock of yours in some cunt or get yourself filled good.");
	CoC.instance.transformations.TailBurning.applyEffect(false);
	CoC.instance.transformations.EyesInfernal.applyEffect(false);
	CoC.instance.transformations.HairBurning.applyEffect(false);
	if (rand(2) == 0) player.goIntoRut(false);
	else player.goIntoHeat(false);

	outputText("\n\n");
	outputText("The hellcat nods with a satisfied smile.\n\n\"<i>All over now. I don’t know how your body became warped, must have been transformatives. Come and see me if that ever happens again.</i>\"\n\n");
	outputText("She waves off and leaves you there to enjoy your new toys. After a few minute pleasuring yourself in order to kill that raging erection and aching pussy you head back to camp.");
	CoC.instance.mainViewManager.updateCharviewIfNeeded();
	if (flags[kFLAGS.WITCHES_SABBATH] > 5) {
		flags[kFLAGS.WITCHES_SABBATH] -= 2;
		cleanupAfterCombat();
	}
	else endEncounter();
}
public function WitchesSabbathFourthVisitNoWay():void {
	outputText("Who said she could perform a spell on you without your permission? You shove her off, interrupting her casting. She goes from friendly to aggressive in the blink of an eye.\n\n");
	outputText("\"<i>Woa sis what’s your problem?! Well it’s alright I’m going to fix you whether you want it or not!</i>\"\n\n");
	startCombat(new HellCat());
}
public function reformallcockstokittycocks():void {
	for (var i:Number = 0; i < (player.cockTotal()) && player.cocks[i].cockType == CockTypesEnum.CAT; i++) { }
	transformations.CockCat(i, 10, 2.5).applyEffect(false);

	if (player.cockTotal() > 0 && player.catCocks() < player.cockTotal()) reformallcockstokittycocks();
}
public function reformallcockstokittycocks2():void {
	//outputText("You moan, feeling overwhelming heat build in your nethers as ");
	if (!player.hasCock()) {
		outputText("a sheath forms between your legs. You mewl in pleasure as a brand new fat cat cock slowly slide out of your sheath, inch after inch, going erect within seconds and dripping hot drops of precum on the ground. It’s only as it reaches its full 10 inches that the throbbing heat builds into a full blown orgasm, your freshly grown cock splattering the volcanic ground with kitty spunk. ");
		transformations.CockCat(0, 10, 2.5).applyEffect(false);
	}
	else {
		outputText("your cock is wrapped in unholy warmth");
		if (!player.hasSheath()) outputText(", slowly being pulled inside a forming sheath between your legs, only to surge back out");
		outputText(" as it reshape into a whole new form. You mewl in delight as your penis sprouts sensitive barbs, all ready to scratch the walls of a female vagina or, in your case, the palm of or your waiting hands as you begin to fiercely masturbate, your sensitive tool splattering several drop of cum everywhere. ");
		for (var i:Number = 0; i < (player.cockTotal()) && player.cocks[i].cockType == CockTypesEnum.CAT; i++) { }
		transformations.CockCat(i, 10, 2.5).applyEffect(false);
	}
}

	}
}
