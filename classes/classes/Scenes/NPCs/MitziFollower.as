/**
 * ...
 * @author Ya Boi Guzma
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.display.SpriteDb;
	
	public class MitziFollower extends NPCAwareContent implements TimeAwareInterface
	{
		public var pregnancy:PregnancyStore;
		
		public function MitziFollower() 
		{
			pregnancy = new PregnancyStore(kFLAGS.MITZI_PREGNANCY_TYPE, kFLAGS.MITZI_PREGNANCY_INCUBATION, 0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 300, 240, 170, 120, 50);
												//Event: 0 (= not pregnant),  1,   2,   3,   4,  5,  6 (< 50)
			EventParser.timeAwareClassAdd(this);
		}
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			pregnancy.pregnancyAdvance();
			return false;
		}
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

public function MitziCampMainMenu():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (pregnancy.isPregnant && pregnancy.incubation == 0) {
		MitziPoopsBabies();
		pregnancy.knockUpForce(); //Clear Pregnancy
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	switch (pregnancy.event) {
		case 2: if (flags[kFLAGS.MITZI_DAUGHTERS] < 4) {
					outputText("You notice Mitzi laying back on a blanket in the shade. She rubs over her slightly rounded belly with a warm smile on her face and giggling to herself. You walk over to check on her.\n\n");
					outputText("\"<i>This just feels amazing, [name]. My dreams of finally forming my very own tribe can finally be realized!</i>\"\n\n");
					outputText("She looks up at you with a joyful grin on her face.\n\n");
					outputText("\"<i>And it's all thanks to you. I can never thank you enough for saving me… but maybe I can find some ways to make it up to you. We'll all try.</i>\"\n\n");
					outputText("She emphasizes by rubbing her belly and giving you a wink. You chuckle, thinking of a bunch of new goblin girls running around camp. You're not sure if that'll be a good thing or a bad thing. Though if they're anything like Mitzi, then it may certainly be… interesting.\n\n");
				}
				else outputText("You spot Mitzi lounging in her usual shaded spot with a few of her daughters. Looking closer, her stomach is notably rounder and her breasts appear fuller. You can tell she's definitely pregnant again. She glances over at you with a knowing smirk, caressing her belly. Your daughters notice you as well and give a friendly wave to you before going back to their discussion.\n\n");
				break;
		case 3:
		case 4: outputText("Mitzi's belly has grown larger. It's clear that she's carrying more than one child. She spends most of the day lounging in the shade and munching on some fresh fruits. Her top struggles to contain her milk filled jugs.\n\n");
				break;
		case 5:
		case 6: outputText("Mitzi lazes by the stream. Her belly looks obscenely swollen with her children. She doesn't wear a top seeing as it can no longer support her hefty milk dribbling breasts. You're sure it won't be too much longer before she gives birth. She shoots you a sly look, slicking out her long tongue and swiping it over her large nipple. She laps at the milk slowly pouring out before slurping it back into her mouth.\n\n");
				break;
		default:
	}
	MitziCampMainMenu2();
}
public function MitziCampMainMenu2():void {
	outputText("\"<i>Hey, [name]! What can I do for you today? Maybe something a little fun?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", mitziAppearance).hint("Examine Mitzi detailed appearance.");
	addButton(1, "Herself", mitziHerself);
	addButton(2, "Camp", mitziCamp);
	if (player.hasPerk(PerkLib.BasicLeadership)) {
		if (flags[kFLAGS.MITZI_DAUGHTERS] >= 6) {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButton(3, "Assist me", mitziHenchmanOption).hint("Ask Mitzi to join you in adventures outside camp.");
			else if (flags[kFLAGS.PLAYER_COMPANION_1] == "Mitzi") addButton(3, "Assist me", mitziHenchmanOption).hint("Ask Mitzi to stay in camp.");
			else addButtonDisabled(3, "Assist me", "You already have other henchman accompany you. Ask him/her to stay at camp before you talk with Mitzi about accompaning you.");
		}
		else addButtonDisabled(3, "Assist me", "She not have enought daughters (6+) to accompaning you.");
	}
	addButton(4, "Sex", mitziSexMenu);
	addButton(14, "Back", camp.campFollowers);
}

public function mitziAppearance():void {
	clearOutput();
	outputText("Mitzi is a 4ft tall dark green skinned goblin. She has long purple hair styled into twin tails and parted by a pair of pointed ears. Her face humanoid in appearance with plump purple lips and sharp teeth. A long purple tongue occasionally peeks out from her lips, easily reaching two feet.  Her eyes are gleaming gold in color. She has human shaped arms and legs with her nails painted purple in color. Her waspish hips sway side to side in a graceful stride, drawing attention to her plush jiggly bottom. She wears a tight leather tube top and thong with gold bangles as clothing, showing off her lean musculature.\n\n");
	outputText("She has large pillowy G cup breasts. Her nipples are purple in color.\n\n");
	outputText("Between her legs is a lubricant drooling amethyst vagina. It has been magically altered to take insertions of any size with no trouble and still keep its tightness. She has a 1 inch plump clit.\n\n");
	outputText("She has a tight anus between her cheeks right where it should be.\n\n");
	outputText("When she notices you staring at her, she smirks and turns to give her ass a smack, making it wobble enticingly.\n\n");
	outputText("\"<i>You can have it whenever you like, [name]...</i>\"\n\n");
	menu();
	addButton(14, "Back", MitziCampMainMenu);
}

public function mitziHerself():void {
	clearOutput();
	outputText("What was she like before she became the incubus drider's cumdump. She hums to herself in thought.\n\n");
	outputText("\"<i>To tell you the truth, I was pretty much like most goblins living in the forest. Constantly competing for territory and any studs that wandered by, of course. It isn't an easy life by far. A lot of wildlife and monsters that would see a lone goblin girl as a quick fuck and potential meal after.</i>\"\n\n");
	outputText("Given her size and and struggling to survive out in the wilderness couldn't have been easy. Surely goblins can pull together and try to make it groups, right? She shakes her head.\n\n");
	outputText("\"<i>Most goblins are in it for themselves really. They're constantly squabbling over who gets to fuck what or just worry about making more babies. To be fair, I was a bit guilty of that too, but it was for a good reason!</i>\"\n\n");
	outputText("Well, from the goblins you've encountered, most of them were only after your seed to have more offspring. Is that pretty much their goal?\n\n");
	outputText("\"<i>Well, for most, yes but some of us really have children to form our own tribes. As you said there are benefits in working together. What’s better than working with your own kids?</i>\"\n\n");
	outputText("A tribe of goblin daughters."+(player.hasStatusEffect(StatusEffects.HairdresserMeeting) ? " Come to think of it, Lynnette's daughters also work with her in her salon to help with customers too.":"")+(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16 ? " Tamani's daughters quickly formed together to form an effective group, greatly increasing their odds out in the wilds.":"")+" Goblins are definitely a force to be reckoned with in greater numbers. That much you understand.\n\n");
	outputText("\"<i>That's why I wanted a tribe of my own so I could have a better shot at life. If I could find that one perfect stud to grant me that wish… That's when… he showed up…</i>\"\n\n");
	outputText("You can only assume she means that incubus drider. Her face shifts to anger.\n\n");
	outputText("\"<i>He promised that he would help me and I would have the biggest and strongest tribe in the forest. Of course that was a damn lie. He tied me up and pumped me full of those strange drugs. I can't say how long I've been like that. Being used everyday like that. I can't deny that it felt amazing at first… but to lose yourself like just didn't feel right. It was like this up until you rescued me. Thank you again by the way…</i>\"\n\n");
	outputText("You tell her that it's fine now. At least she doesn't have to go through that anymore.\n\n");
	outputText("\"<i>Yeah… I doubt I can ever really pay you back for saving me but maaaaybe I can try? Perhaps a little later?</i>\"\n\n");
	outputText("She bats her eyelashes at you innocently. You chuckle, knowing exactly what she wants. Maybe you should take her up on her offer later.\n\n");
	menu();
	addButton(14, "Back", MitziCampMainMenu);
}

public function mitziCamp():void {
	clearOutput();
	outputText("You ask the goblin how she likes living in your camp. She hums in thought while she looks around.\n\n");
	outputText("\"<i>Well I can't deny that it's actually pretty comfortable here.</i>\"\n\n");
	if (player.hasStatusEffect(StatusEffects.CampRathazul) || flags[kFLAGS.EVANGELINE_FOLLOWER] >= 1) outputText("\"<i>Gotta admit those alchemists really know their stuff. I wonder if they can help me with a few potions I wanted to whip up…</i>\"\n\n");
	if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2) outputText("\"<i>You have a bear of a hunk over there. The way he works that hammer and anvil. Those rippling muscles… Mmm… He could be helpful indeed…</i>\"\n\n");
	if (isabellaFollower()) {
		outputText("\"<i>I don't really see cow girls too often but Isabella seems different somehow… Her milk's pretty tasty too. Maybe she'll let me have some more later.</i>\"\n\n");
		outputText("She giggles to herself.\n\n");
	}
	if (followerHel()) {
		outputText("\"<i>That rowdy salamander slut may be a bit of an annoyance but I've dealt with worse honestly. Would not recommend trying to entertain a group of Minotaurs. Get really rough and messy… Still hot though.</i>\"\n\n");
		outputText("She shudders at the thought.\n\n");
	}
	if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1) outputText("\"<i>I'm surprised she hasn’t eaten you yet [name]. I've seen a group of those shark girls tear a Minotaur to shreds before. You must really have her under control.</i>\"\n\n");
	if (player.hasStatusEffect(StatusEffects.CampMarble)) outputText("\"<i>Hmph, that Marble chick almost took my fucking head off when I was still living in the forest with that big ass hammer of hers. I haven't forgotten that…</i>\"\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo)) outputText("\"<i>You have a really cute little mouse boy there. Can't say that I'm into that meditation thing he keeps encouraging me to do.</i>\"\n\n");
	if (amilyScene.amilyFollower()) {
		outputText("\"<i>That Amily girl seems to somewhat know her way around the alchemy table though it's pretty lackluster. Maybe I can help her spice up her poisons a bit. Then the real fun can begin.</i>\"\n\n");
		outputText("She gives you a devious wink.\n\n");
	}
	if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) outputText("\"<i>I have no idea what that weird shock weasel girl is honestly. Though I can see making her a pretty good battery…</i>\"\n\n");
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) {
		outputText("\"<i>I don't like the way that Manticore chick keeps looking at me. She’s always stalking me somewhere, like she's ready to pounce. I don't trust her…</i>\"\n\n");
		outputText("She looks over her shoulder to see Etna peeking out from behind a rock in a pouncing position. She has a smug cat like expression on her face, making Mitzi tense.\n\n");
	}
	//Zenji
	//Aenair
	outputText("She nodded her head in approval then smiles up at you.\n\n");
	outputText("\"<i>Your camp is definitely better than any place I've been. Pretty much like a well rounded community. I love it here, [name]!</i>\"\n\n");
	menu();
	addButton(14, "Back", MitziCampMainMenu);
}

public function mitziHenchmanOption():void {
	clearOutput();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		outputText("Mitzi grins up at you then puts her fingers to mouth, letting out a loud whistle.n\n");
		outputText("\"<i>Lildea! Furxia! Roxy! It's showtime!</i>\"\n\n");
		outputText("Three goblin girls come running over to her. They have short purple hair tied back into ponytails and their soft curves are accentuated by a belt lined with assorted needles strapped across their sizable chests and a pair of black gloves and thigh length stockings. Mitzi changes into the same matter of dress, striking a sexy pose with her three daughters.\n\n");
		var strMitzi:Number = 20;
		var intMitzi:Number = 40;
		var libMitzi:Number = 50;
		strMitzi += 2 * (flags[kFLAGS.MITZI_DAUGHTERS] / 4);
		intMitzi += 4 * (flags[kFLAGS.MITZI_DAUGHTERS] / 4);
		libMitzi += 5 * (flags[kFLAGS.MITZI_DAUGHTERS] / 4);
		strMitzi *= (1 + (0.2 * player.newGamePlusMod()));
		strMitzi = Math.round(strMitzi);
		intMitzi *= (1 + (0.2 * player.newGamePlusMod()));
		intMitzi = Math.round(intMitzi);
		libMitzi *= (1 + (0.2 * player.newGamePlusMod()));
		libMitzi = Math.round(libMitzi);
		player.createStatusEffect(StatusEffects.CombatFollowerMitzi, strMitzi, intMitzi, libMitzi, 0);
		flags[kFLAGS.PLAYER_COMPANION_1] = "Mitzi";
	}
	else {
		outputText("\"<i>Aw.. just when we were having fun… Ah well, you know where to find us if you need anything!</i>\"\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerMitzi);
		flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(MitziCampMainMenu);
	cheatTime(1/12);
}

public function mitziSexMenu():void {
	clearOutput();
	outputText("\"<i>Oh? Finally up for a little bit of fun [name]? I'm down for anything...</i>\"\n\n");
	menu();
	if (player.hasCock()) {
		if (player.hasStatusEffect(StatusEffects.MitziPregnant)) addButtonDisabled(0, "Big Dick Sex", "You need to wait until Mitzi would give a birth.");
		else if (player.biggestCockLength() < 20) addButtonDisabled(0, "Big Dick Sex", "You need 20+ inches cock for this.");
		else addButton(0, "Big Dick Sex", mitziSexBigDickSex);
		if (player.isBiped() && player.str >= 50 && player.tallness >= 60) addButton(1, "Jog Fuck", mitziSexJogFuck);
		else addButtonDisabled(1, "Jog Fuck", "You must be bipedal, 5+ ft. tall and 50+ str for this.");
		addButton(2, "Tit Job", mitziSexTitJob);
		addButton(3, "Fuck Her", mitziSexFuckHer);
	}
	if (player.hasVagina()) addButton(3, "Eaten Out", mitziSexEatenOut);
	addButton(14, "Back", MitziCampMainMenu);
}
public function mitziSexBigDickSex():void {
	clearOutput();
	outputText("You smirk then pick her up, carrying her to your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin":"tent")+". "+(player.isNaked() ? "You stand in front of her letting your [cock] hang free":"You begin to remove your [armor], revealing your [cock]")+". Mitzi eyes your large cock with an almost predatory gaze while licking her lips.\n\n");
	outputText("\"<i>Mmm [name]... You know how much I love big fat cocks. The way they fill me up just right. The bigger the better I always say.</i>\"\n\n");
	outputText("The goblin sheds her clothing, letting her giant tits bounce free from their confinement. She struts up to you then urges you to "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "lay back on the bed":"sit down")+" with your legs wide open. She lightly traces her fingers over your rapidly hardening erection. She coos, feeling it twitch from the barest of touches. With a smirk she wraps both her hands around your [cock]. She’s so small compared to it but she massages ");
	outputText("your monstrous length with practiced ease, making you groan. The goblin leans in then gives the head of your cock a kiss, running her long tongue across the slit. Her tongue works along your length in tandem with her hands, drawing a moan from you. Your precum already begins to leak from your cumslit which Mitzi happily laps up. Just as you were about to let yourself completely indulge in the goblin's wonderful touches, she pulls away. ");
	outputText("She then climbs on top of you. The goblin reaches back and grabs your dick then pulls it closer, rubbing the head of it against her deceivingly small wet slit and clit. She gives you a sultry look.\n\n");
	outputText("\"<i>While most goblin girls can't handle anything this huge, I was specially made for this…</i>\"\n\n");
	outputText("Mitzi lets out a long drawn out moan once she feels the crown of your [cock] starting to stretch out her cooter. You're taken aback, feeling her tight pussy easily mold around your monster length. You resist the urge to immediately blow your load within her warm depths as she steadily sinks, taking in inch after inch of you. Your amazed when her hips finally meets yours. The large bulge of your [cock] protrudes through her belly though she doesn't appear distressed. ");
	outputText("In fact, she appears more prideful than anything as she rubs the outline of it. Whatever magical enhancements she acquired gave her unprecedented levels of elasticity.\n\n");
	outputText("\"<i>Now the fun can really begin…</i>\"\n\n");
	outputText("She lifts herself up,practically climbing up your trunk-like dick before dropping back down. The feel of her wonderfully warm and slick walls wrapped around you has your head swimming. Everytime she moves up and down your length, it sends a pang of electricity through your loins. You unconsciously let out a moan each time your hips meet. She looks you in the eye with a lust filled gaze.\n\n");
	outputText("\"<i>Come on, [name]. No need to hold back with me. I like it rough…</i>\"\n\n");
	outputText("Taking that as the all clear to really let loose, you grab her hips then slam her back down on your [cock]. Mitzi gleeful squeals as you roughly pound into her tight pussy. She reaches up, squeezing and kneading her large tits, moaning louder every time you bottom out inside her. Soon she can't take it any longer. The goblin nearly screams when her orgasm hits, tightly squeezing and milking at your length. Her femcum drenches your dick and [balls] as her orgasm grows ");
	outputText("in intensity but you’re far from done with her. You continue fucking her through her prolonged orgasm, picking up the pace. Mitzi squeals louder as you relentlessly pound into her sensitive depths, pushing her into a second full body orgasm, then a third. After the sixth one her tongue lolls out to the side as she completely loses herself to pleasure. You can no longer hold back your own mounting orgasm. ");
	outputText("Wrapping your arms around her waist, you roughly pump into her several more times before bottoming out and blasting your seed deep inside her waiting, stretched womb. Her eyes roll back as you baste her womb with thick ribbons of your cum, forcing one last small orgasm out of her.\n\n");
	outputText("You're both left panting as the last pleasure filled tremors slowly fade. You lay back with Mitzi who is still impaled on your [cock]. She looks completely blissed out as she drools on your chest. You gently hold her in your grip until she calms down. After several quiet minutes she sits up with a dopey smile on her face.\n\n");
	outputText("\"<i>W-Wow [name]... That was amazing… This is why big cocks are just the best. They fill me up juuust right...</i>\"\n\n");
	outputText("You chuckle, giving the goblin woman a couple pats on the head before slowly pulling her off your dick. She shivers, feeling thick globs of your cum drooling out of her overstuffed cunt. She closes her legs to prevent too much from pouring out.\n\n");
	outputText("\"<i>Mmm… Maybe this will give me a big batch of daughters. What do you think [name]? Wanna see me big and round with milk filled jugs to play with?</i>\"\n\n");
	outputText("She giggles at seeing your flustered expression before helping you clean up. You put your gear on then lean down to exchange a passionate tongue filled kiss with the goblin woman before heading off to continue your business.\n\n");
	mitziPreg();
	player.sexReward("vaginalFluids","Dick");
	doNext(camp.returnToCampUseOneHour);
}
public function mitziSexJogFuck():void {
	clearOutput();
	outputText("You ask her if she's up for a little ride. Mitzi giggles at your suggestion.\n\n");
	outputText("\"<i>I'm up for any ride you give me [name].</i>\"\n\n");
	outputText("You help the goblin strip her clothing then pick her up. The diminutive woman is fairly easy to hold in your grip. She hungrily eyes your [cock], eagerly wanting it inside her. You hold her over your dick, feeling her warm lubricant dripping down onto it then push her down. She bites her lower lip when the tip slips between her moist and parted folds, brushing against her entrance and taking some of her weight for you. She lets out a moan, ");
	outputText("wrapping her legs as far around your [hips] as possible.\n\nYou walk towards the forest, letting the movements work with gravity along with her magical cooter allowing you to effortlessly penetrate her. Those tight purple wet walls clench you tightly as she slides down, rubbing perfectly against your [cock]. With each and every step you take she slides down further, until she sits fully impaled on you, ");
	outputText("grabbing your torso to help support herself. She looks up at you with a sharp toothed grin. You can feel her inner wall muscles massage and squeeze your dick, showing off her masterful pussy control.\n\n");
	outputText("She moans happily, her tongue lapping at your stomach and squishing her large breasts against you.\n\n");
	outputText("\"<i>Oooh [name] go-ah-faster! I REALLY wanna bounce!</i>\"\n\n");
	outputText("You're more than happy to oblige. You break into a run, feeling her lithe curvy form bounce on your [cock], drawing out a cacophony of happy wails and moans from the goblin woman. Her purple nails dig into your skin as she hangs on, clenching and smashing her wobbly tits against you. You run hard, feeling her bounce and wriggle as her cunt and rapid breathing begins squeezing and milking you like never before. ");
	outputText("You’re sure if you could feel like this every time you took a jog, you’d be in great shape.\n\n\"<i>Ooh fuck [name], don't stop! I want you to fill me with your cum like this!</i>\"\n\n");
	outputText("The familiar tightness of a coming orgasm grows in your groin, tightening as you near release. You pick the pace, full out sprinting, letting Mitzi bounce and jiggle as she clings to you, supported entirely by your [cock]. Your [balls] tighten, releasing the seed of your orgasm. The howl of a powerful orgasm fills your ears as your cumming sets the goblin woman off. One of her hands lets go, and starts rubbing her belly while she kisses and licks your belly-button. ");
	outputText("Your enhanced body easily stuffs her full of cream. "+(player.hasStatusEffect(StatusEffects.MitziPregnant) ? "Though with her womb blocked off most of it washes back out":"Rounding her belly out slightly")+" and dripping down your [balls]. The orgasm is so potent that by the time you wind down, she looks heavily pregnant but her vice like grip prevents your cum from squirting out.\n\n");
	outputText("Eventually you grow tired and come to rest in a forest clearing with her. You slump against a tree with her leaning on your chest panting heavily. The combination of the brisk run and orgasm left you more than a little tired. Mitzi sits up, pulling you down into a tired kiss. You return it in kind. She pulls away looking more than a little flushed.\n\n");
	outputText("\"<i>Now that was certainly a fun ride. We should definitely do this again! Perhaps everyday...</i>\"\n\n");
	outputText("You wouldn't mind honestly. For now you could relax a bit before heading back. You let the goblin lay in your lap to rest for a while until you're both ready to head back to camp.\n\n");
	mitziPreg();
	player.sexReward("vaginalFluids","Dick");
	doNext(camp.returnToCampUseOneHour);
}
public function mitziSexTitJob():void {
	clearOutput();
	outputText("Mitzi's large tits look more than delectable. You would probably lose yourself in them if given the chance. She could probably even give a cowgirl a run for her money with that sizable chest. The goblin notices your intense concentration on her breasts. With a sly smirk she pushed them together, making them appear even bigger.\n\n");
	outputText("\"<i>Naughty "+player.mf("boy","girl")+". It's impolite to just stand there and stare at them when you can do so much more…</i>\"\n\n");
	outputText("She hooks a finger on her top then pulls it down, letting her large perky tits bounce free. They jiggle enticingly in front of you. She reaches up and rubs her big purple nipples between her fingers. You can't help but watch as she plays with her own plush breasts. Unconsciously, you reach down, placing your hands on her chest pillows. The wobbly boob flesh barely fits in your hands. You lightly knead and squeeze her breasts, marveling at just how soft and warm they are. ");
	if (player.hasStatusEffect(StatusEffects.MitziPregnant)) outputText("Your hands wander up to her long milk leaking nipples, pinching them between your fingers and squirting out thin streams of goblin cream. ");
	outputText("She coos, enjoying your gentle caresses.\n\n\"<i>Well, aren't you sweet [name]... Buuuut I get the feeling you may want a little something extra.</i>\"\n\n");
	outputText("She eyes your rapidly hardening [cock]. She takes your hands and guides you over to a rock to lean against. Once situated she takes your cock into one hand. ");
	if (player.biggestCockLength() > 20) {
		outputText("She grins, taking in your monstrous length.\n\n");
		outputText("\"<i>Mmm… Just how I like it. Big fat cocks are just the best…</i>\"\n\n");
	}
	else {
		outputText("She pouts, glancing at your size.\n\n");
		outputText("\"<i>If only you were a little bigger… Then I would have shown you some real fun. Ah, well…</i>\"\n\n");
	}
	outputText("She takes your [cock] then stuffs it between her plush green love pillows. Your dick is engulfed in the pleasant soft warmth. She squishes her breasts together, squeezing you tightly then moves up and down your length. It feels almost heavenly between the goblins wonderfully large tits. You lay back, watching as she expertly works your length. Her long purple tongue slips out of her mouth and swirls around the head of your cock each time it peeks ");
	outputText("through her cleavage, teasing your cumslit. You grit your teeth in an effort to hold back your orgasm. You want to prolong this wonderful feeling as long as possible. Your precum leaks from your straining cock in a steadily increasing stream, making the goblin's breasts slicker. Mitzi bites her lip, picking up the pace and pushing you closer to the edge. You choke out a groan as the tightness in your loins coils tighter.\n\n");
	outputText("\"<i>Come on, [name]. Cum for me… Drench me in that nice warm thick baby batter!</i>\"\n\n");
	outputText("Her words of encouragement are all you need to peak. You roughly grab her tits and promptly fuck her slick cleavage before shooting a blast of hot seed between her plush breasts. She quivers and moans, feeling your cum paint her chest and face. ");
	if (player.hasStatusEffect(StatusEffects.MitziPregnant)) outputText("Milk pours from her engorged nipples, adding to the widening puddle beneath you two. ");
	outputText("Dribbles of femcum stream down her legs. The mere feeling of hot seed on her skin pushes her into an orgasm.\n\nOnce you calm down, you pull away from Mitzi. Most of her face and breast are coated in a thick layer of cum. She scoops it out of her eyes then happily slurps it up from fingers.\n\n");
	outputText("\"<i>Mmm… Now that was a tasty treat. I would gladly wallow in a bathtub full of your cum if a could… Hmm, maybe I should try and make it happen.</i>\"\n\n");
	outputText("A crazy idea for sure but knowing her you wouldn't put it past her to try something like that. You offer to help her get cleaned up but she declines, preferring to rub your seed all over her body. You shake your head, laughing and leaving her to it.\n\n");
	player.sexReward("Default","Dick",true,false);
	doNext(camp.returnToCampUseOneHour);
}
public function mitziSexFuckHer():void {
	clearOutput();
	outputText("Mitzi can tell exactly what you want. She turns around, leaning over a rock and spreading her plump legs open and pokes her plush ass up into the air. She pulls her thong to the side, giving you a clear view of her soaked purple pussy. The goblin woman shoots you a sultry look over her shoulder.\n\n");
	outputText("\"<i>You and I both know that you want this, [name]. Why not come and get it?</i>\"\n\n");
	outputText("Well you certainly don't need to be told twice. "+(player.isNaked() ? "Already in the nude you":"You shed your gear, haphazardly tossing it to the ground and")+" begin to fondle your cock as you walk towards the slutty goblin woman. Her large perfectly round cheeks jiggle enticingly in front of you, begging to groped and squeezed. Mitzi moans, rubbing her fingers against her aching slit in anticipation. Bending down, you grab the goblin’s ample hips. She licks her lips seeing your [cock].\n\n");
	outputText("\"<i>Oh yes, please [name]! I need it inside now!</i>\"\n\n");
	outputText("You grab your cock and slap it against the bare flesh of her ass, causing it to wobble. You take your time massaging the eager goblin’s ass with your bare hands before sliding your dick in between her soft cheeks. Mitzi grinds against you as she spreads her moist lips open, coating your [cock] in feminine slick. You slap her ass firmly as you thrust between her cheeks. The goblin squeals in delight when you finally plunge your dick inside her moist depths, pushing her forward somewhat. ");
	outputText("You roughly pound into the goblin woman, maintaining a firm grip on her hips while she moans and squirms. The sound of your groin slapping against her along with your grunts and her loud moaning echoes throughout the area. Mitzi squeezes and kneads her own large breast as she squeals in pleasure.");
	if (player.hasStatusEffect(StatusEffects.MitziPregnant)) outputText(" Milk dribbles from her purple teats, coating her front in goblin cream.");
	outputText("\n\nSoon you can feel yourself coming to a climax, your movements getting faster and faster as you build up to your release. The goblin below you loses herself to the pleasure of your [cock], her eyes rolled upwards and her long purple tongue drooling out of her mouth as you relentlessly pound into her. With a final thrust, your hips lurch forward as you paint her insides with your thick spunk, relishing in the feeling of your ejaculate filling her up to the brim and plugging her entrance. ");
	if (player.hasStatusEffect(StatusEffects.MitziPregnant)) outputText("Unfortunately most of it comes flooding back out with her already being pregnant. ");
	outputText("You slowly release yourself from her tight body, finishing off by covering her curved back and pert rump with the rest of your seed. Mitzi coos in delight, feeling your hot cum on her skin, even reaching back to scoop some into her mouth. She looks over her shoulder at you with a smirk.\n\n");
	outputText("\"<i>Oh, [name]... You certainly know how to treat a lady.</i>\"\n\n");
	outputText("After such an intense steamy session with the goblin woman, you help get her cleaned up. She sighs in relief, leaning against the rock.\n\n");
	outputText("\"<i>Now that was fun. I really needed you know. A daily dose of meat is just what I need to stay healthy after all.</i>\"\n\n");
	outputText("She gives you a wide sharp toothed grin and you playfully push her away before getting ready to head off.\n\n");
	player.sexReward("vaginalFluids","Dick");
	mitziPreg();
	doNext(camp.returnToCampUseOneHour);
}
public function mitziSexEatenOut():void {
	clearOutput();
	outputText("You ask the goblin if she's up for some girly fun "+(player.isNaked() ? "as stand in front of her":"as you strip out of your gear")+", ready for anything. She giggles, placing a hand on her hip.\n\n");
	outputText("\"<i>So you want little ol' Mitzi to show you a good time? Well, just sit back and I'll give you a little something special.</i>\"\n\n");
	outputText("She urges you to sit and spreads your thick thighs a bit. Her feminine scent hits your nose, assuring you that she’s looking forward to it too. The goblin lowers herself down and slides in between your [legs] eyeing your puffy snatch"+(player.gender == 3 ? " and [cock]":"")+". Her big plush breasts squishes against you. As you become more aroused your slightly sticky juice starts to leak out between the parting lips.\n\n");
	outputText("\"<i>[name] you're practically soaked already! Well, don't you worry. I'll take good care of you…</i>\"\n\n");
	outputText("Mitzi's long purple tongue slicks out of her mouth. She leans in further, swiping the prehensile appendage over your wet snatch making you gasp. She greedily licks over your puffy vulva and sensitive pleasure button. She smiles against your quivering labia then opens up, swallowing your clit into her mouth and letting her tongue begin to rove wildly through your channel. ");
	outputText("The goblin places her hands on your thighs for extra leverage as she falls into a rhythm of alternating slurps, licks, and humming over your growing clitty. You moan out from pleasure as the goblin massages your inner walls with her masterful tongue. You bite your lip, feeling the familiar tightness building up inside you.\n\n");
	outputText("You gasp in shock, feeling Mitzi's long tongue poke and prod at your cervix. "+(player.pregnancyIncubation > 0 ? " Though your womb is closed off, you can't help but squeal in pleasure from the feeling.":"")+" The tip of it nudges at the small entrance before managing to slip inside. You choke out a drawn out moan, feeling the long appendage explore the insides. ");
	outputText("The goblin slips a hand down to her own needy pussy, plunging her fingers into slick folds. Sounds of both of your moaning and loud slurping fills the air. You grab the back of her head and mash her face against your snatch. Her tongue lashes wildly against your sensitive walls, making your head spin.\n\n");
	outputText("Soon it becomes too much. Your orgasm hits hard, sending a wave of femcum into the goblin's face and mouth"+(player.gender == 3 ? " while you drench her hair and back in hot jizz":"")+". Your cunny clenches tightly around her long tongue. She shudders as her own orgasm works through her, her fingers deep within her purple snatch. ");
	outputText("You collapse, panting heavily as small jolts of pleasure still course through you. You can feel Mitzi's tongue retract from your pussy. Without warning, the goblin leaps up onto your [chest] and pulls you into a sloppy cummy filled kiss. You can taste yourself on her tongue. She pulls away with a toothy grin on her face.\n\n");
	outputText("\"<i>So how was that [name]? Liked spending some girly time with me?</i>\"\n\n");
	outputText("She gives you a sultry look then licks her lips. That tongue of hers is truly something. The goblin hops off you as you sit up and stretch, letting out a satisfied sigh.\n\n");
	outputText("\"<i>Well that was definitely fun… Maybe can do this again soon, right?</i>\"\n\n");
	outputText("You might just consider it. For now it's back to your daily routine. You gather your gear then say your goodbyes to Mitzi before heading off.\n\n");
	player.sexReward("saliva");
	doNext(camp.returnToCampUseOneHour);
}

private function mitziPreg():void {
	if (!pregnancy.isPregnant && rand(100) < (10 + Math.round(player.cumQ() / 100))) {
		pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_MITZI);
		player.createStatusEffect(StatusEffects.MitziPregnant, 0, 0, 0, 0);
	}
}
private function MitziPoopsBabies():void {
	//spriteSelect(32);
	clearOutput();
	outputText("As you're strolling through camp, you hear a high pitched squeal catch your attention. You look to see Mitzi doubled over holding her belly. She staggers over to you, clutching her swollen belly with a heavy blush on her face.\n\n");
	outputText("\"<i>Ooooo [name]! I-It's time! They're coming!</i>\"\n\n");
	outputText("Wasting no time, you guide the expecting mother to her usual secluded spot and help her lay down. You help her remove what little clothing she wears then start gently rubbing her belly and spread her legs. You notice the babies inside are moving more, eager to leave their confines. Mitzi tenses and moans out loudly when a contraction rocks through body. A gush of liquid pours out from between her leg.\n\n");
	outputText("\"<i>A-Ah yes I can feel them moving!</i>\"\n\n");
	outputText("The goblin is obviously aroused by just being in labor. You can see one of your daughters already moving downward. You waste no time in hurrying off to fetch some towels and heat water to help clean the babies once they’re born. You return as soon as you can and take Mitzi's hands in your own as she breaths and pushes. The goblin moans in pure pleasure as she forces her daughters from her womb, squeezing your hand tightly. You watch for any sign of the babies until finally you spot a head peek out from between her lips. Her moans turn into near incoherent babbling and squeals as the pleasure of giving birth overtakes her.\n\n");
	outputText("\"<i>Yes-ah-yes! M-More it so-ah-good!</i>\"\n\n");
	outputText("With one final push, the very first goblin girl finally pushes her way out of the birthing canal. You manage to catch her just as she emerges. She almost looks like a mini version of her mother. Surprisingly, her hair is "+player.hairColor+" just like yours. She meekly whines and cries in your grasp so you clean her up and bring the newborn goblin up to her mother's breast to nurse.\n\n");
	outputText("\"<i>T-There's plenty-ah-more where she f-from-oooo!</i>\"\n\n");
	outputText("Mitzi barely finishes her sentence when another contraction rolls through her, signaling the sign of the coming child. Soon the head of her next daughter peeks out of her folds before she's pushed out into your waiting hands followed by a gush femcum that paints your face and arms. The same process repeats itself until a total of four goblins are born and you're thoroughly coated in fem slime. ");
	outputText("Your newborn daughters are squabbling at their mother's chest, enthusiastically guzzling down her milk. Mitzi lets out a content sigh as she cradles them in her arms."+(flags[kFLAGS.MITZI_DAUGHTERS] > 3 ? " Some of your older daughters come over to see the commotion, pleasantly surprised to see their new sisters.":"")+"\n\n");
	outputText("\"<i>This is the best feeling [name]. There's just nothing like it... And just look at these cuties! We definitely need to make more after this.</i>\"\n\n");
	outputText("You shake your head, laughing and telling her that you'll worry about that later. For now taking care of the youngest ones are top priority. She gives you a warm smile before turning her attention back to her nursing daughters who are already starting to grow bigger. You make sure the goblin and her daughters are alright then give her a kiss before heading off.\n\n");
	player.removeStatusEffect(StatusEffects.MitziPregnant);
	flags[kFLAGS.MITZI_DAUGHTERS] += 4;
}

public function MitziDaughtersCampMainMenu(first:Boolean = true):void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (first) {
		outputText("You walk over to the small goblin to check on your daughters. You spot your eldest daughters mixing and pouring bubbling vials of strange liquids and ingredients into a large melding pot. The sickly sweet scent wafting in the air makes your head swim a bit and a heat build in your loins. One of them with short cut blue hair and wearing an apron looks up from the project when she notices you.\n\n");
		outputText("\"<i>Careful, "+player.mf("pa","ma")+". This stuff really packs a punch!</i>\"\n\n");
		outputText("One of your other daughters speaks up, sliding up her goggles.\n\n");
		outputText("\"<i>It'll pack even more of a punch with another dose of lust draft. They'll never know what'll hit 'em.</i>\"\n\n");
		outputText("You're curious to know what exactly they're making as you take a few steps back to avoid breathing in the fumes. The tallest of your daughters, wearing nothing but an apron and red hair styled into a mohawk, stands proud over the pot with her hands on her hips.\n\n");
		outputText("\"<i>I'm glad you asked. We're making the best potions and poisons this world has ever seen! None will be able to stand against our-</i>\"\n\n");
		outputText("Her sister with purple hair tied back into a ponytail pushes her to the side, cutting her off.\n\n");
		outputText("\"<i>Mama taught us some simple recipes she used for making poisoned darts and brews when she was looking for a mate. We wanted to improve on the recipes and try to make them stronger for bigger uses. Maybe even help you too.</i>\"\n\n");
		outputText("The idea of carrying some useful potions with you does sound promising. Maybe those poisons will come in handy in a bind too.\n\n");
		outputText("\"<i>We're still working on perfecting them but we'll keep a steady supply of other things that you might find useful in those barrels over there.</i>\"\n\n");
		outputText("She points to a set of barrels sitting nearby. You thank them then continue on your way.\n\n");
		player.createStatusEffect(StatusEffects.MitziDaughtersBarrels,0,0,0,0);
	}
	else {
		outputText("You walk over to the small goblin community to check on your daughters. You spot your eldest daughters mixing and pouring bubbling vials of strange liquids and ingredients into a large melding pot. The sickly sweet scent wafting in the air makes your head swim a bit and a heat build in your loins. One of them with short cut blue hair and wearing an apron looks up from the project when she notices you.\n\n");
		outputText("\"<i>Hey, [name]! What can I do for you today? Maybe something a little fun?</i>\"\n\n");
	}
	menu();
	addButton(0, "Daughters", MitziDaughters);
	if (player.hasStatusEffect(StatusEffects.MitziDaughtersBarrels)) addButton(1, "Barrels", MitziDaughtersBarrels);
	addButton(4, "Back", camp.campFollowers);
}

public function MitziDaughters():void {
	clearOutput();
	outputText("Mitzi and her daughters have called this small corner of camp their home. They expand the size of their homes to accommodate their growing numbers. For the most part they stay out of trouble and lend a hand if needed. At the moment your have "+flags[kFLAGS.MITZI_DAUGHTERS]+" goblin daughters living here.\n\n");
	menu();
	addButton(14, "Back", MitziDaughtersCampMainMenu);
}

public function MitziDaughtersBarrels():void {
	menu();
	if (player.statusEffectv1(StatusEffects.MitziDaughtersBarrels) > 0) addButton(0, "Goblin Ale", MitziDaughtersBarrelsGoblinAle);
	else addButtonDisabled(0, "Goblin Ale", "There is no Goblin Ale in barrels.");
	if (player.statusEffectv2(StatusEffects.MitziDaughtersBarrels) > 0) addButton(1, "Lust Draft", MitziDaughtersBarrelsLustDraft);
	else addButtonDisabled(1, "Lust Draft", "There is no Lust Draft in barrels.");
	if (player.statusEffectv3(StatusEffects.MitziDaughtersBarrels) > 0) addButton(2, "Ovi Elixir", MitziDaughtersBarrelsOviElixir);
	else addButtonDisabled(2, "Ovi Elixir", "There is no Ovi Elixir in barrels.");
	addButton(4, "Back", MitziDaughtersCampMainMenu);
}
public function MitziDaughtersBarrelsGoblinAle():void {
	outputText("\n\n");
	player.addStatusValue(StatusEffects.MitziDaughtersBarrels, 1, -1);
	inventory.takeItem(consumables.GOB_ALE, MitziDaughtersBarrels);
}
public function MitziDaughtersBarrelsLustDraft():void {
	outputText("\n\n");
	player.addStatusValue(StatusEffects.MitziDaughtersBarrels, 2, -1);
	inventory.takeItem(consumables.L_DRAFT, MitziDaughtersBarrels);
}
public function MitziDaughtersBarrelsOviElixir():void {
	outputText("\n\n");
	player.addStatusValue(StatusEffects.MitziDaughtersBarrels, 3, -1);
	inventory.takeItem(consumables.OVIELIX, MitziDaughtersBarrels);
}

public function MitziDaughtersIzmaDaughters():void {
	clearOutput();
	outputText("You hear screams coming from the stream. You look over to see Mitzi and her daughters swimming in the stream, splashing each other. Suddenly Izma jumps out of the water, lifting the big tittied goblin up into the air. The tigershark looks up at her with a mischievous sharp toothed grin. Mitzi gulps nervously.\n\n");
	outputText("\"<i>Y-You wouldn't dare…</i>\"\n\n");
	outputText("Izma's grin widens then she falls back into the water with the goblin still in her arms with a big splash, soaking her daughters as well. Mitzi comes back up to the surface sputtering and wiping the water from her eyes. She shoots a dirty look at the tigershark who swims back over to her own daughters.\n\n");
	outputText("\"<i>You come to our stream, you better be prepared for a little fight.</i>\"\n\n");
	outputText("You can tell Izma isn't looking for a real fight judging by the way she mockingly flicks her tail at the goblin. Mitzi shoots a cocky grin at the shark as her daughters crowd around her.\n\n");
	outputText("\"<i>Hmph. If it's a fight you want then it's a fight you'll get… Let's get 'em girls!</i>\"\n\n");
	outputText("Mitzi and her brood charges at Izma and hers. The fight really devolves into splashing, wet bodies slapping into one another, and boobs to the face. Speaking of which, Izma currently has her face buried within Mitzi's massive cleavage. Though with "+(flags[kFLAGS.IZMA_NO_COCK] == 0 ? "the throbbing erection":"feminine slick dripping down from between her legs")+", she doesn't seem all too bothered by it. Soon both exhausted goblins and shark girls decide to call it a draw for the day. Izma and Mitzi sit on the edge of the stream panting and heaving heavily.\n\n");
	outputText("\"<i>Okay… Maybe we… just call a truce..</i>\"\n\n");
	outputText("Izma laughs shaking her head.\n\n");
	outputText("\"<i>Maybe for today but next time I'll definitely lay it on you.</i>\"\n\n");
	outputText("You chuckle to yourself, having witnessed the scene in its entirety. Maybe Rathazul was right. You do keep weird company… You have to admit it's pretty entertaining though.\n\n");
	player.createStatusEffect(StatusEffects.MitziIzmaDaughters, 0, 0, 0, 0);
	doNext(playerMenu);
}

	}
}