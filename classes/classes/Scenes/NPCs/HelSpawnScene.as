package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class HelSpawnScene extends NPCAwareContent {

	public function HelSpawnScene()
	{
	}

//Helia Expansion 4: The Edge of Paradise
//A CoC Multi-Character Expansion
//Savin

//Content Pack: Introduction
//Expanded Variable: HelAffection can now reach 250%. When this occur, At the Edge of Paradise begins. HelAffection is raised as: 10 for sex, 15 for threesomes, 10 for talking/hugging/cuddling.
//New Variable: " + flags[kFLAGS.HELSPAWN_NAME] + ", the name of Hel’s daughter
//New Variable: [HelspawnPersonality], rated 0-100. 
//New Variable: " + championRef() + ", being whatever the fuck Helspawn calls you.
//New Variable: [HelspawnDadddy], recording who, exactly, fathered Hel’s daughter
//New Variable: [HelLove] Yes/No, set by the PC in the beginning.

//const HELSPAWN_NAME:int = 956;
//const HELSPAWN_PERSONALITY:int = 957;
//0 = PC, 1 = Spider, 2 = Mai
//const HELSPAWN_DADDY:int = 958;
//const HELSPAWN_WEAPON:int = 959;
//const HELSPAWN_AGE:int = 960;
//const HELSPAWN_GROWUP_COUNTER:int = 961;
//const HEL_LOVE:int = 962;
//Has Helia had the pale flame event happen?
//const HELIA_KIDS_CHAT:int = 963;
//const HELIA_TALK_SEVEN:int = 964;
//Track Hel getting knocked up by others. 1 = doing it. 2 = talked to PC about it.
//const HEL_NTR_TRACKER:int = 965;
//const HEL_BONUS_POINTS:int = 966;
//const HEL_PREGNANCY_INCUBATION:int = 967;
//0 = no notices. 1 = bulgy. 2 = pretty preg. 3 = gravid.
//const HEL_PREGNANCY_NOTICES:int = 968;
//const HAD_FIRST_HELSPAWN_TALK:int = 969;
//const HELSPAWN_INCEST:int = 970;
//const HEL_TALK_EIGHT:int = 971;
//const HELSPAWN_DISCOVER_BOOZE:int = 972;
//const HELSPAWN_FUCK_INTERRUPTUS:int = 973;
//const SPIDER_BRO_GIFT:int = 974;
//const HAKON_AND_KIRI_VISIT:int = 975;

//In this Expansion, Helia the Salamander, who’s spent much of her life alone until the brave Champion took her into his confidence, enters a stage in her life called The Pale Flame: whether she wants to admit it or not, her body’s ready for children; she’s found the person she truly wants to be with. She asks the Champion to father her child; if that is impossible, but desired (or the PC doesn’t want to be the daddy, but wants Hel to have kids anyway), she will offer to get Mai the Foxgirl to knock her up instead; if it is undesired at all, the PC can ask Hel to go on herbs, suppressing her fertility until the PC's ready. Hel will remain on herbs until the PC decides he’s ready.

//Setting " + championRef() + ":
	//It was really fucking hard to decide what this bitch is supposed to call you. So, here’s the dealio: If you’re a herm AND her mother, she calls you “Mom;” dude and her dad, she calls you “Daddy;” she’ll change between mom and daddy as the PC’s gender changes. If she was fathered by someone OTHER than the PC, she calls the PC by their name. Simple enough?

private function championRef():String {
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) return player.mf("Daddy","Mom");
	else return player.short;
}

override public function helspawnFollower():Boolean {
	return flags[kFLAGS.HELSPAWN_AGE] == 3;
}

override public function helPregnant():Boolean {
	return (kGAMECLASS.helScene.pregnancy.isPregnant);
}

//Hel’s New Appearance Screen: Taking Things Into Account
internal function heliasAppearanceScreen():void {
	clearOutput();
	spriteSelect(68);
	outputText(images.showImage("monster-hel"));
	outputText("Hel the salamander stands seven feet tall, with pale skin and thick, bright-red scales covering her arms and legs, though she has a normal human torso and face.  A fiery tail swishes gaily behind her, blazing with a ");
	if (flags[kFLAGS.HEL_BONUS_POINTS] < 150) outputText("bright orange glow");
	else outputText("bright white glow");
	outputText(" that lets off a pleasant heat, though it never seems to burn you.  Hel is wearing her scale bikini and a leather thong, and using her scimitar as a weapon");
	//if Isabella is cool: 
	if (flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] >= 1) outputText("; she’s got her blue bandanna wrapped around her head, mostly obscured by her fiery hair");
	outputText(".  She has a human face, with bright red eyes, gentle, feminine features and a smattering of pale scales on her cheeks, like freckles.  Hel has long, bright-red hair bound in a pony-tail that hangs down her back.  She has wide-flared hips and a soft, squishy butt.  Her two reptilian legs are visibly adorned with scales and claws, ending in soft, leathery soles.");
	if (flags[kFLAGS.HELSPAWN_NAME] != 0) {
		outputText("  A dark trio of scars run down Hel’s thighs, left by " + flags[kFLAGS.HELSPAWN_NAME] + "’s youthful claws.");
	}
	else {
		switch (kGAMECLASS.helScene.pregnancy.event) {
			case 1: //She's pregnant, but no special text yet
					break;
			case 2: outputText("  Hel's just starting to show a little bulge of pregnancy.");
					break;
			case 3: outputText("  Hel’s belly is starting to look fairly bloated, swelling with her child.");
					break;
			case 4: outputText("  Hel’s belly is positively gravid, full of a little salamander child.");
					break;
			default: //She's not pregnant, check if she's ready for it
					if (flags[kFLAGS.HEL_BONUS_POINTS] >= 150) outputText("  Hel’s long, reptilian tail is currently burning white-hot, signaling her body’s ready for motherhood.");
		}
	}
	outputText("\n\nHel has a pair of big, soft E-cup breasts, each with a 0.5 inch nipple at their tip.");
	outputText("\n\nShe has a warm, wet, and accommodating pussy between her legs.");
	outputText("\n\nHel has a single cock-draining asshole between her buttcheeks, right where it belongs.");
	menu();
	addButton(0,"Next",helFollower.heliaFollowerMenu);
}

//" + flags[kFLAGS.HELSPAWN_NAME] + "’s Appearance Screen
private function helSpawnsAppearanceScreen():void {
	clearOutput();
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("Your ");
	else outputText("Hel’s ");
	outputText("salamander daughter, " + flags[kFLAGS.HELSPAWN_NAME] + ", stands about six-foot-six tall, with pale skin and thick, ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 1) outputText("chitin-black");
	else outputText("bright-red");
	outputText(" scales covering her arms and legs, though she has a normal human face and torso.  A long leathery tail swishes happily behind her, surrounded by a dim fiery aura that emits a pleasant heat, though thankfully it isn’t hot to the touch, seemingly incapable of harming you.  " + flags[kFLAGS.HELSPAWN_NAME] + " is wearing ");
	if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) outputText("a scale bikini, just like her mother’s");
	else outputText("a short skirt, thigh-high boots, and a sky-blue blouse, in stark contrast to her mother’s sluttier attire");
	if (flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] >= 1) outputText(", with a brightly-colored scarf wrapped around her neck");
	outputText(". She has a human face, with ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("golden");
	else if (flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("bright green");
	else outputText("crimson");
	outputText(" eyes, girlish features, and a smattering of pale red scales on her cheeks, like freckles.  Her short, dark-red hair cuts off just below her ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("puppy-dog");
	else outputText("reptilian");
	outputText(" ears, and it’s adorned with a pretty pink bow.  She has surprisingly large hips, and a big, squishy butt behind her.  Her reptilian legs are covered with thick, dark scales, ending in short claws atop soft, leathery soles.");
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " has a pair of perky, palmable C-cup breasts, each with a sensitive half-inch nipple at its tip.");
	
	outputText("\n\nShe has a warm, wet, and accommodating pussy between her legs, mirrored by a tight little asshole between her plush buttcheeks, right where it belongs.");
	menu();
	addButton(0,"Next",helspawnsMainMenu);
}

//Hel Affection Reaches 250 & Salamander is @ Camp
//[Play at night, after PC goes to sleep (with or without anybody)]
public function heliaBonusPointsAward():void {
	flags[kFLAGS.HELIA_KIDS_CHAT] = 1;
	spriteSelect(68);
	outputText("\n<b>That night...</b>\n");
	outputText("Your sleep is disturbed by a gentle tugging on your [armor].  You groggily swat at whatever's nudging at you, groaning about the hour until your eyes finally open wide enough to recognize Helia kneeling over you, a deeply distraught look in her eyes.  \"<i>[name]? [name] wake up, I need to talk to you. Please?</i>\"");
	
	outputText("\n\nYou nod, rubbing the sleep out of your eyes as you stagger up onto your [feet].  You note that Hel's wrapped her old cloak tightly around herself, held closed so that nothing but her face is visible.  You start to ask what's up, but Hel shushes you, saying she needs to talk to you privately.  ");
	//{If Hel's the only one at camp: 
	if (camp.companionsCount() == 1) outputText("You cock an eyebrow, saying that you're already alone, but she shakes her head, saying she needs somewhere private, away from prying eyes.  ");
	outputText("You nod your assent, and let her help you up and lead you away from camp.  You follow Hel through the darkness, stumbling after her until you're hidden away beneath the old ruined wall a stone's throw from the perimeter.  Safely tucked away beneath the shadow of the wall, Hel takes your hands in hers and hesitantly, says, \"<i>Look, I don't... this isn't easy for me, okay?  But I have to tell you something, [name].  And it's important, alright?  To me, anyway. I wouldn't bring it up if I could deal with it myself, honest.  But I can't and... and I'm afraid, [name].</i>\"");
	
	outputText("\n\nYou squeeze Helia's hands and reassure her as best you can, saying she can tell you anything.  She looks away, blushing hotly; beneath her cloak, the radiant fire of her long tail shines brighter, casting a pale glow even through the heavy fabric.  You ask again what's wrong, and with a little coaxing, Hel looks up, her bright crimson eyes staring into yours.");
	
	outputText("\n\n\"<i>I don't just like you, [name] - I mean, I do.  Like you, I mean.  But it's... it's more than that, you know?  Sure, I've said the word, but I say 'love' to a lot of people, a lot of things.  I love your ");
	if (player.hasCock()) outputText(player.multiCockDescriptLight());
	if (player.hasVagina() && player.hasCock()) outputText(" and your [chest] and your [vagina]");
	if (!player.hasCock() && player.hasVagina()) outputText(" [vagina] and [chest]");
	outputText(" and everything else about you.  But... but that doesn't mean anything.  It doesn't.  I say I love minotaur dicks, and centaurs, and those two fox pricks at the bar filling both my holes, and I love beer and fighting and ramming my tail up peoples' assholes.  But that's not real love, right?  Love is - oh, god, I'm making a mess of this.  Again. I keep doing this; it always works out so much better in my head.</i>\"");
	
	outputText("\n\n\"<i>I guess what I'm trying to say is... I love you, [name].  I really, really do.  Not fake, shitty, stupid love; not me saying it in the heat of the moment.  I've been thinking about this for a while, now.  You've been so good to me [name], better than I deserve.  You saved my family, you've given me a place to live, and more kindness than I could ever have imagined when I jumped you in the plains so very long ago.</i>\"");
	
	outputText("\n\n\"<i>That's not what I wanted to tell you, though.  I'd have sat on that for years if I could have, but something's changed.  I've talked to my father, and he says it's normal.  He just... just chuckled and shook his head, gave me this knowing look.  But I'm still afraid, [name].  I can't deal with this on my own, but... but I have to know, before we go any further: do you love me, too?  And please, please don't just say yes because it's what I want to hear.  I promise I won't run off or throw a tantrum if you say no; I liked where we were before I opened my big stupid mouth.  So, what do you say, [name]? Do you love me?</i>\"");
	menu();
	addButton(0,"Yes",yesHeliaILoveYourButtHoleReaming);
	addButton(1,"No",noYouDontLoveHeliaYouMonster);
}

//No
private function noYouDontLoveHeliaYouMonster():void {
	clearOutput();
	spriteSelect(68);
	outputText("As much as you enjoy the sex, as much as you like Hel, you can't say you feel that way towards her.  You grasp her shoulders, telling her as gently as possible how you feel.  She nods slowly as you speak, rubbing at her eyes by the time you're finished.");
	outputText("\n\n\"<i>Well, thanks for being honest, [name].  I... I really do appreciate it.  But, maybe you can still help me with my problem.  I'll understand if not, but still, I have to ask: ");
	//[HelLove to NO]
	flags[kFLAGS.HEL_LOVE] = -1;
	heliaLoveFollowup();
}

//Yes
private function yesHeliaILoveYourButtHoleReaming():void {
	clearOutput();
	spriteSelect(68);
	outputText("Smiling, you tell her yes.  The salamander cries out with joy, jumping into your arms and kissing you, squeezing you so tightly that you feel like you're about to black out by the time she breaks the kiss, stepping back with chest heaving.");
	outputText("\n\n\"<i>Wh-why didn't you tell me before, anyway?</i>\" she asks, nuzzling her cheek into your [chest].  \"<i>Could have saved me all this trouble.</i>\"");
	outputText("\n\nYou shrug, saying that you never really felt like you had the chance until now... and it's a lot cuter when she bumbles through a confession.  Helia gives you a gentle punch on the shoulder, but softens the blow with another series of kisses along your [chest] and neck, holding you close as the two of you revel in the newly-revealed love you share.  After a few minutes, though, Hel steps back and says, \"<i>I love you, [name], with all my heart.  You're the person I want to spend the rest of my life with, if you'll have me.  But I still have to tell you what's wrong. The reason I brought this all up: ");
	//[HelLove to YES]
	flags[kFLAGS.HEL_LOVE] = 1;
	heliaLoveFollowup();
}

//Combine
private function heliaLoveFollowup():void {
	spriteSelect(68);
	outputText("You're not from here, so you probably don't know much about salamanders.  Basically, we're effectively infertile.  I can get filled with gallons of cum day in and day out, and chances are none of it will take inside me.  I've always thought I could slut around as much as I wanted, and I'd never have to worry about the consequences.  But... that's not forever, I guess.  When a salamander girl finds the person she wants to be with forever, ");
	//if PC is female/herm:
	if (player.hasVagina()) outputText("even another woman, it seems, ");
	outputText("we... change.</i>\"");
	
	outputText("\n\nHel reaches up and undoes the clasp on her cloak.  When it falls away, your eyes are drawn immediately to her tail - once burning with a blood-red hellfire, her leathery tail is now surrounded by a pale radiance, shimmering like white gold.  Your eyes widen, but Hel flinches back as you try to approach.  \"<i>It's called the Pale Flame, [name].  Just like it looks.  When a 'mander girl finds the person she wants to be with, our bodies change.  While I'm like this... I'm as fertile as a goblin, and... and I </i>want<i> to be.  I want... I need... a child, [name].  I want to be pumped full of cum until I'm bloated, to bear a little salamander for us to raise and love.  ");
	//If HelLove = No:
	if (flags[kFLAGS.HEL_LOVE] == -1) outputText("Even if you don't love me, you'd love our child, right?  You can fuck me full of kids, or even... even get someone else to, I don't care.  I just </i>need<i> it, [name].  More than anything else in the whole wide world.");
	else {
		outputText("I love you, [name].  I love you so much.  I want to share this with you.  ");
		if (player.hasCock()) outputText("You'll fuck me full of kids, right?  Please?  Give me your seed, [name].  Give it all to me until I'm fucking gravid with your salamander babies.");
		else outputText("Even if you can't fuck me full of babies... you could grow a dick!  There's plenty of things in this god-forsaken world that do that. O-or if you don't want to, I bet I can get one of the fox-girls, or a minotaur, or something.  You know I can find a dick somewhere, just say the word.");
	}
	outputText("  So what do you say, [name]?  Let's have a kid!</i>\"");
	menu();
	if (player.hasCock() && player.cockThatFits(helFollower.heliaCapacity()) >= 0) addButton(0,"Have A Kid",haveAKid);
	else if (player.hasCock()) outputText("  <b>Unfortunately, you're too big to squeeze inside Helia to do the business yourself.  You might need to shrink down some.</b>");
	addButton(1,"Another Dad",getAnotherDad);
	addButton(2,"No Or Later",noKidsHel);
}

//[Have a Kid] (PC has a Dick)
internal function haveAKid():void {
	clearOutput();
	spriteSelect(68);
	kGAMECLASS.helScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_SALAMANDER);
	outputText("You tell Hel that you're in this with her, that you want to give her that child she seems so desperate for.  She beams at you, smiling from eye to eye before leaping into your arms, pressing her lips hard to yours.  You kiss her back, wrapping your arms around her hips to support her as her powerful legs wrap around your waist; you push her up against the ruined wall, hands searching across her taut, hot flesh until you toss her bikini top aside, letting her hefty tits free.  \"<i>Oh god yes,</i>\" she moans as you trail kisses from her lips, down her neck to her stiffening nipple.  \"<i>I want this so much, more than anything.  Give it to me, [name].  Don't hold back!</i>\"  Your fingers sink into her pliant flesh as you suckle on her exposed teat, groping her other tit and soft ass as she moans and squirms in your arms.  Clumsily, Hel's claws brush down your body, peeling off your [armor] until your " + player.cockDescript(0) + " flops into her lap.  She locks her scaled fingers around your manhood, roughly stroking you until you're stiff as diamonds in her grasp.");
	
	outputText("\n\nYou shudder as her fingers work your " + player.cockDescript(0) + ", but don't let up on your end for a second.  You brush and knead Hel's nipple between your teeth, letting your hands drift down to her wide hips and gropable ass, slowly stripping her of her scale bottom and pulling it off her legs.  With your lover bare and naked, you slip down between her legs, letting her hook them over your shoulder to give you a good view of her dripping cunt.  Your tongue laps across her labia, drawing a long, lewd moan from Hel.  She runs her fingers through your [hair], urging you onward; at her lusty moans, you dig in, sucking on her prominent clit and drilling your tongue between her inner folds.  You gasp into her when Hel's lengthy tail wraps around your shoulders, the pale flame soothingly warm on your " + player.skinFurScales() + " as her leathery appendage works its way down to the " + player.cockDescript(0) + " dangling between your [legs].  You groan with sudden need as the tip of her tail brushes your most sensitive flesh, tickling ");
	if (player.balls > 0) outputText("your [balls]");
	else outputText("the base of your prick");
	outputText(" before coiling around the shaft with serpentine dexterity.  Her tail contracts and squeezes, undulating across your " + player.cockDescript(0) + " until it finally massages a thick blob of pre from your " + player.cockHead() + ", dribbling out to stain the wasteland ground.");
	
	outputText("\n\nSuddenly, Helia grabs your shoulders and shoves you down.  You flop onto your back, tail-encased prick standing straight up like a flagpole as Hel straddles your [hips], vigorously fingering herself as her tail lines your cock up with her drooling womanhood.  Your breath catches as your " + player.cockHead() + " brushes her boiling juices, slickening your entry as she slides down your pole.  You grab Hel's flared hips, guiding her in as she envelopes your " + player.cockDescript(0) + " in the roiling inferno inside her.  Her tail unravels from around your throbbing shaft as she descends, tantalizingly slowly; she takes the better part of a minute before her groin is cozily joined to yours, her hungry maw kissing the very base of your lusty prick.");
	
	outputText("\n\nCompletely impaled on you, Hel's chest heaves with lust and need.  She cups one of the massive orbs, squeezing her pert nipples between a pair of crimson fingers as her other hand ");
	if (player.biggestTitSize() <= 2) outputText("supports her, pressing down on your [chest]");
	else outputText("gropes one of your tits, kneading your tender breasts under you squirm underneath her, unable to hold in your pleasured little gasps");
	outputText(".  Slowly, your salamander lover starts to grind her hips on your " + player.cockDescript(0) + ", her muscles contracting and squeezing the rigid shaft inside her with every shift of her hips.  You both moan aloud, half-lost in a miasm of pleasure.  \"<i>God, I wish I could stay like this forever,</i>\"  Hel whispers, just on the edge of hearing.  \"<i>There's no one I'd rather be with, [name].  No one I'd rather have give me the child my body craves.</i>\"");
	
	outputText("\n\nSomething in Hel's voice gives you pause, but before you can think too much into it, she plants her hands firmly on your [chest] and starts to rise, dragging inch after inch of your prick out of her until only the " + player.cockHead() + " is still inside her, smearing her lips with thick, creamy pre.  Then, grinning at you, Hel slams back down, taking you in one brutal thrust that leaves you both moaning; a moment later and she's riding your cock, bouncing on the rigid pole so fast that your combined juices go flying everywhere, drenching the barren earth around you.  Helia fucks you with reckless abandon, her voice edging higher and higher as she cries and moans.  Caressing your [chest], fondling herself, teasing your [asshole] with the tip of her tail, Hel seems to lose all restraint as she takes your cock again and again, devolving to her basest sexual instincts, rutting like an animal until you're sure you'll wake up bruised in the morning.");
	
	outputText("\n\nYou lay back and enjoy the rough fucking for several minutes, eventually taking her hands and holding them fast as she moves, locking your fingers with hers and pulling her down into a long, tongue-filled kiss.  The two of you stay like that for a long while, your breath hot on each others' skin as you wrap your arms around your lover's waist; to your surprise, Hel leans away from you, just long enough to pull off the tie on her ponytail, letting her rich red hair cascade down around you, veiling your faces as she kisses you again.  You run your fingers through her thick locks, breathing in the fiery smell of her, tasting her sweet lips on yours, feeling her innermost depths conforming around your breeding pole.  Holding Hel tight, you roll the pair of you over, landing with your cheek nestled in the cleft of her bosom.  She gasps as you run your tongue across the soft, succulent flesh of her tits, gently thrusting your " + player.cockDescript(0) + " into her.  Settling onto her back, Hel spreads her legs wide for you, letting you slip right in as her heels hook behind your [butt], her hands digging into your back to guide your movements.  Inside of five thrusts and she's moaning like a bitch in heat, writhing beneath you.  She claws at your back, making you wince - and spurt a mess of pre into her eager hole.");
	
	outputText("\n\nYou clench your teeth and start to piston into her, picking up the pace until your every thrust causes the lusty salamander to scream your name to the heavens.  Spurred on by Hel's ecstatic cries and her vice-like grip around your " + player.cockDescript(0) + ", it isn't long before you can feel the mounting pressure of your inevitable release mounting furiously inside your [balls].");
	//If PC has lost Anal Virginity:
	if (player.ass.analLooseness > 0) outputText("\n\nBetween rough thrusts into your lover, you can feel her pale-glowing tail snake itself around your [legs], the slender little tip brushing between the cheeks of your [butt].  You can't help but gasp as it presses into your clenched backdoor, teasing your [asshole] with probing thrusts and flicks across the brim.  Helia grins up at you as your sphincter finally relaxes, letting the first inches slither inside, undulating through your anal passage.  \"<i>I'm going to milk every last fucking drop out of you,</i>\" she whispers huskily, breath hot on your neck. You moan in response as her ever-thickening appendage wriggles into you, penetrating you to the beat of your own " + player.cockDescript(0) + "'s thrusts into your lover's cunt.  Suddenly, a powerful burst of pleasure threatens to overwhelm you, demanding every ounce of your willpower to keep from cumming on the spot.  Hel coos encouragingly as you gasp, thrilled to have found your most sensitive place.  Now that's she's found it, Hel lets her tail go wild in your ass, tip battering against your prostate as the thicker trunk writhes and wiggles through your stretched hole.");
	
	outputText("\n\nYou give Hel a final few thrusts, doing your best to hold your orgasm back until the last minute.  But she never lets up, bucking her hips and squeezing your cock, urging you onwards until with an explosive roar you let loose, shooting your hot load into her hotter depths.  Hel throws her head back and screams, \"<i>GOD YES!  Give it to me, [name].  Don't you dare hold anything back!</i>\"  Indeed, you don't; your prick fires off one sticky wad of potent seed after the other, slathering her womb with cum until it drools out of her well-fucked pussy.  With a final, exhausted gasp, your throbbing prick lets out its last spurt, a final plug of salty spunk to fill her needy hole before you collapse atop your lover, panting into the valley of her cleavage as her arms and legs wrap around you, holding you tight while you deflate inside her.");
	
	outputText("\n\n\"<i>Oh, [name],</i>\" she moans, kissing you, \"<i>");
	if (player.pregnancyIncubation > 0) outputText("We're going to be mothers!");
	else outputText("You're going to be a father... and me a mother!");
	outputText(".</i>\"  You start to reply, when you're suddenly upended, landing back on your back with Helia atop you, fingers brushing along the cock buried twixt her legs.  \"<i>Oh, don't think you're getting away that easy, lover mine... my love.  I've gotta make sure your seed took, and that... that's going to take all night long.</i>\"");
	
	outputText("\n\nYou gulp, and wince as Hel starts to move atop your battered cock - and not for the last time this sleepless night!");
	player.orgasm();
	menu();
	addButton(0,"Next",HaveAHellKidPartII);
	model.time.hours = 6;
	model.time.days++;
}

private function HaveAHellKidPartII():void {
	clearOutput();
	spriteSelect(68);
	outputText("<b>Several Hours Later...</b>\n");
	outputText("With the last ounce of energy in your sixth - or is it seventh? - wind, you deliver a sharp crack across Helia's beet-red backside and roar out as another potent surge of seed rushes into her snow-white hole, still slick with the leavings of your last half-dozen discharges.  You grab her thick hips and slam your " + player.cockDescript(0) + " deep inside her as the last shot fills her womb a little bit fuller, the excess spurting out to wet the cum-stained ground beneath the salamander's knees.");
	
	outputText("\n\nThe sun's out by now, its radiant glow kissing your bare, sweat-slick flesh as you finally come to rest.  You lean back just enough to let your limp cock flop free of Hel's draining cunt, ushering out a deluge of salty seed that pools between her spread legs.  Without your prick to support her, Hel flops aside like a rag doll, chest heaving, still bearing the white marks of an errant orgasm.  She manages to smile up at you even as her fingers idly play across her swollen hole, knuckle-deep into the gallons of cum you've pumped into her over the course of the night.  Giving in to your exhaustion, you slip down beside your beloved, resting your chest on her shoulder.  Her arm wraps around you, holding you close as she plants a tender, loving kiss on your brow.");
	
	outputText("\n\n\"<i>That was... amazing.  God, it's like we were made for each other.  The way you move, the way you fill me and fuck me and caress me.  I'm... so glad I found you, [name].  It seems like a lifetime ago, like I was another person back then.  Maybe I was, but... there's nowhere I'd rather be, nowhere on Mareth or beyond than with you, the one I love.  Oh god, I'm so in love with you, [name].  So very much in love,</i>\" she says, running her fingers through your [hair].  You lean up and kiss her, wrapping your arms around your lover as your lips press against hers, tasting the sweet touch of hers.");
	
	outputText("\n\n\"<i>Oh, shit,</i>\" Hel says, breaking the kiss and staring wide-eyed into the morning sky.");
	
	outputText("\n\n\"<i>What's wrong?</i>\"");
	
	outputText("\n\n\"<i>I-I really am going to be a mother.  I can feel it, [name].  Your seed taking inside me, the dawn of a new life.  I just hope... I hope this wasn't a mistake, [name].</i>\"");
	
	outputText("\n\nYou lift yourself up onto your elbow, staring at your love as her fiery eyes gaze into the void.  \"<i>I thought this was what you wanted, Hel.  You were-</i>\"");
	
	outputText("\n\n\"<i>Yeah, I know.  Forget about it, I'm fine.  Really.  It's just that this happened all so suddenly, you know?  This isn't exactly where I saw myself a year ago.  Not that I'm complaining,</i>\" she adds, turning back to you with another kiss, squeezing your shoulder.  \"<i>I just hope I'm ready, I guess.  Until the Pale Flame took, I'd never really thought about being a mother.  Never really wanted it.  But last night, it was like I was possessed, like I couldn't control myself.  I just... needed you.  And there you were, like always, ready to help.  I love you with all my heart, [name]");
	if (flags[kFLAGS.HEL_LOVE] == 1) outputText(", and I'm so very, very glad you love me back.");
	else outputText(", even if you can't say the same.  And that's alright; it doesn't change my heart, and it never will. I love you");
	outputText(".</i>\"");
	
	outputText("\n\nThe two of you snuggle up for a good long while, letting the edge of your sexual exhaustion subside as you watch the sunrise, content to lie in each others' arms.  After a blissful eternity, though, you both rise and collect the scattered bits of Hel's scale mail and your [armor], laughing and teasing as you redress, exchanging the occasional kiss or caress until the pair of you are clothed, your weapons secured.  Finally, Helia slips into your arms, planting a long kiss upon your lips.  \"<i>I'm glad we're in this together, my love.  I'm going to... to need you during this.</i>\"");
	
	outputText("\n\nYou tell her to rest easy: that you'll be there for her every step of the way.  She smiles ");
	if (player.tallness >= 90) outputText("up ");
	else if (player.tallness <= 72) outputText("down ");
	outputText("at you, holding you tight for a long moment before stepping away, still holding your hands.  \"<i>This is all new to me, [name].  I never pictured myself as a mother, with a mate and a stable, safe home - or as stable and safe as anything these days - but with you by my side, there's nothing I can't take on.</i>\"");
	
	outputText("\n\nYou give your lover one last kiss before taking her back to camp proper, never letting her hand slip from yours all the way.");
	//[Back to Camp menu]
	doNext(camp.returnToCampUseOneHour);
}

private function getAnotherDad():void {
	clearOutput();
	spriteSelect(68);
	//[Another Dad] (PC has no dick)
	if (!player.hasCock()) {
		outputText("You tell Helia you'd love to a share a child with her, but you're not... properly equipped for the endeavor.  \"<i>That's fine!  I can... I can wait, a little.  I-if you want to go grow one, I mean.  If not, then we can find someone with a cock.  ");
		if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText("There's Miko and Mai from the bar.  Mai's said she wanted a kid, but can't take care of one... she'd probably be willing to fuck one into me!  If that's not alright, then... lemme think.  ");
		outputText("Uh, maybe not a minotaur... they always plug more minotaurs, and I don't want a bull coming out of my twat.  Uh, maybe I could track down one of the spider boys from the swamp and jump on </i>his<i> dick.  They're pretty cute, right?  Dunno how that'd affect a child, though.  Maybe he'd end up with like, extra eyes, or chitin?  Still, better than an imp or some shit.  So what do you think?  Wanna grow a dick, or leave the knocking-up to someone else?</i>\"");
		//{Options in next section}
	}
	//[Another Dad] (PC has a dick)
	else {
		outputText("\"<i>W-wha?</i>\" Hel says, cocking an eyebrow.  \"<i>You sure, [name]?  I-if you don't want to be the dad, I guess I understand.  But why?  Am I not... no, nevermind.  I don't want to know.  Okay, uh, we can find someone with a cock.  ");
		if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText("There's Miko and Mai from the bar.  Mai's said she wanted a kid, but can't take care of one... she'd probably be willing to fuck one into me!  If that's not alright, then... lemme think.  ");
		outputText("Uh, maybe not a minotaur... they always plug more minotaurs, and I don't want a bull coming out of my twat.  Uh, maybe I could track down one of the spider boys from the swamp and jump on </i>his<i> dick.  They're pretty cute, right?  Dunno how that'd affect a child, though.  Maybe he'd end up with like, extra eyes, or chitin?  Still, better than an imp or some shit.  So what do you think?</i>\"");
	}
	menu();
	//{If Tel'Adre has been discovered: [Mai]}
	if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) addButton(0,"Mai",maiWouldBeTheBestInseminator);
	//[Spiderboy]
	addButton(1,"Spiderboy",spiderboyWouldBeBestDad);
	//[I will] (If PC has a dick)
	if (player.hasCock() && player.cockThatFits(helFollower.heliaCapacity()) >= 0) addButton(2,"I Will",haveAKid);
	else if (!player.hasCock()) addButton(2,"I Will",growingDicks4Hel);
	addButton(3,"No Or Later",noKidsHel);
}

//Mai
private function maiWouldBeTheBestInseminator():void {
	clearOutput();
	spriteSelect(68);
	outputText("You tell Hel that you think Mai would make a lovely father.  Helia nods her agreement, saying, \"<i>Yeah, I agree.  She's a beauty, and I'm sure our child will be stunning... you wouldn't mind if she visited, right?  I mean, you and I will be raising our kid - and he'll be ours for sure - but I'm sure Mai will want to at least visit her kid.</i>\"");
	outputText("\n\nYou nod, and say that's fine.  Hel beams at you, giving you a peck on the cheek before running back to camp, saying she's going to go track down the foxy sisters as soon as she can.  You suppose the next time you see her, Hel's probably going to be pregnant with the child you'll be helping to raise.");
	kGAMECLASS.helScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_SALAMANDER); //Yes, it's Mai's baby, but that's already tracked separately
	flags[kFLAGS.HEL_NTR_TRACKER] = 1;
	flags[kFLAGS.HELSPAWN_DADDY] = 2;
	doNext(playerMenu);
}
//Spiderboy
private function spiderboyWouldBeBestDad():void {
	clearOutput();
	spriteSelect(68);
	outputText("You tell Helia to go find a spider boy to jump.  She beams at you, and skips off toward the swamp calling, \"<i>Thank you, thank you thank you, [name]!</i>\" over her shoulder as she goes.  You suppose the next time you see her, Hel's probably going to be pregnant with the child you'll be helping to raise.");
	kGAMECLASS.helScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_SALAMANDER); //Yes, it's the spider's baby, but that's already tracked separately
	flags[kFLAGS.HEL_NTR_TRACKER] = 1;
	flags[kFLAGS.HELSPAWN_DADDY] = 1;
	doNext(playerMenu);
}

//I Will (PC ain't got a wang)
private function growingDicks4Hel():void {
	clearOutput();
	spriteSelect(68);
	outputText("You tell Hel to give you a little while, that you'll go find something to grow a cock for her.");
	outputText("\n\n\"<i>Thank you!  Thank you so much, [name].  I really, really wanted for it to be our child. I'll wait, but hurry.  I don't know how much longer I can stand this... this need!</i>\"");
	outputText("\n\nOnce you've finished with Hel, she leaves you with a longing look as you head back to camp.  Eventually, you manage to go back to sleep...");
	//[Resume night]
	doNext(playerMenu);
}

//[No Kids]
private function noKidsHel():void {
	clearOutput();
	spriteSelect(68);
	outputText("You shake you head and say no, you don't want to have children.  Not right now, anyway.  ");
	if (player.hasCock() && player.cockThatFits(helFollower.heliaCapacity()) >= 0) outputText("You couldn't if you wanted to anyway - you're too big to fit.  ");
	outputText("As the words leave your lips, you can see Hel's shoulders slump, a crestfallen look spreading across her face.  \"<i>A-are you sure?  Please, [name], I really, really want a child.  For </i>us<i> to have one.</i>\"");
	outputText("\n\nYou tell her that no, at least for now you aren't interested.  She begs and pleads for several minutes, but you hold your ground.  Finally, she relents.  \"<i>Alright, [name].  I... I'll respect that, I guess.  Dad gave me some herbs, said as long as I take them, I should go back to normal.  If that's what you want, I'll start on them.  Just tell me if - when - you're ready, [name].  I will be.</i>\"");
	
	outputText("\n\nShe leans up and gives you a peck on the cheek before wandering back to camp, leaving you standing alone in the dark with your choices.  Eventually, you manage to go back to sleep...");
	//[Resume night]
	doNext(playerMenu);
}

//Hel Dun Got Knocked Up (Play first time PC goes to Hel's menu after telling her to get knocked up by someone else)
//Proc day after dad choice @ 8AM.
public function helGotKnockedUp():void {
	spriteSelect(68);
	flags[kFLAGS.HEL_NTR_TRACKER] = 2;

	outputText("\n<b>After your decision with Helia last night,</b> you decide to check in on your lusty salamander.  You find her sitting on a rock near her part of camp, knees held close to her chest, seemingly deep in thought.  She gives you a ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("warm ");
	else outputText("wan ");
	outputText("smile as you approach, scooting over to allow you to sit beside her.  She almost seems distant, though she's quick to wrap her tail around your waist, hugging you close against her.");
	outputText("\n\nAfter a few quiet minutes, you finally ask, \"<i>How'd it go?</i>\"");
	outputText("\n\n\"<i>Well... let's just say it worked.  Unless you wanna hear the details?</i>\" she asks conspiratorially.");

	menu();
	//Hel Got Knocked Up by Mai
	if (flags[kFLAGS.HELSPAWN_DADDY] == 2) {
		addButton(0,"Sure",sureHelGimmeMaiDetails);
		addButton(1,"Nope",dontTellMeAboutMai);
	}
	//Hel Got Knocked Up by a Spiderboy
	else if (flags[kFLAGS.HELSPAWN_DADDY] == 1) {
		addButton(0,"Sure",sureHelGimmeSpidahBoyDetails);		
		addButton(1,"Nope",dontTellMeAboutSpiderboy);
	}
}

//Sure
private function sureHelGimmeSpidahBoyDetails():void {
	clearOutput();
	spriteSelect(68);
	outputText("Hel chuckles, shaking her head.  \"<i>So I go to the swamp and just shout out 'Who wants to fuck a baby into this fertile womb, you chitiny bastards,' and sure enough, I got plenty of volunteers.  Whole horde of creepy crawlies came out of the woodwork, but I saw the looks in their eyes: corrupt, all of 'em.  I don't want my kid half way to cumming out his soul before he's had a chance, you know?  So I did my berzerker thing, fought 'em off.  The swamp's getting more and more dangerous every month, I think.  Something in the water maybe, who knows.  Anyway, after I dispatched the crazies, I went deeper, just a little");
	if (followerKiha()) outputText(", toward hotwings' old place");
	outputText(". Took a while, but eventually I just sort of stumbled on this couple of spidergirls, just as cute as could be.  They wander up to me, all cautious, and ask if I was serious about the whole baby thing.  So I say, 'Yeah, sure,' and they get this big, dopey grin, the both of 'em.</i>\"");
	
	outputText("\n\n\"<i>They tell me they're sisters, and they've got a little brother who's looking for his first mate.  But he's terrified of just jumping people to fuck 'em (kind of old fashioned, but hey, what're you gonna do?), and the girls are afraid he'll get dragged off by some demon drider thing and raped to death.  So the girls say if I'm looking to breed, they've got a plan: let me pretend to be all helpless, and they'll sic their brother on me; he gets to feel like the big predator man, and I get fucked full of seed.  Win-win.  So they take me to a clearing, tell me to wait.  Few minutes later, and this little bitty spiderboy wanders out of the jungle - and I mean, his mother must've been a goblin, cuz he's a runty little shit, wrapped up in this silk shift down to his knees when his sisters have their tits hanging out in the wind.  Poor thing's shy as can be, but he blabbers something about tying me up and having his way with me, you know the drill.  So I swoon and drop my sword and get all dramatic and beg him not to hurt me.</i>\"");
	
	outputText("\n\n\"<i>I swear it took him like, half an hour to actually just tie me up properly.  His spinners are spurting like little cocks everywhere, and he's apologizing and trembling all over until I actually have to help the poor kid get me all tied up and gagged.  But then - and this is rich - he wiggles out of his shirt, and oh my god the kid's a fucking tripod.  I mean he puts minotaurs to shame, and how.  Here's this shy kid, never had a girl before, and he's packing a god-damn monster down under");
	//If PC has a giant wang:
	if (player.biggestCockArea() >= 20) outputText(", though still nothing compared to you, lover mine");
	outputText(".  So he's rock-hard now, trembling with excitement; he spreads my legs nice and wide, stroking himself as he lines up and... oops, wrong hole.  That was a surprise, lemme tell you.  Not an </i>unpleasant<i> surprise, mind you, but still.  Just about rips me in half with this giant thing, slides all the way to the hilt and just stops, like he doesn't know what to do.  He just sort of moans and wiggles his hips a little, hugging himself to me and burying his head in my chest.</i>\"");
	
	outputText("\n\n\"<i>Well, what's a girl to do?  I get my hands free pretty easy, and run my fingers through his hair, tell him everything's okay, he's doing great.  Poor kid looks up at me with these huge puppy-dog eyes and asks, 'R-really?' like he's so shocked.  God damn, he was cute.  So I give him a little kiss, help him pull out and line up with the real prize.  Oh, you should have seen his face when he slid home: tongue rolled out, eyes crossed.  He just about came right there, but I clenched down hard, told him he'd have to work for it.  I pull him in tight, just bury his face in my tits and guide his hips, getting him working nice and slow.  But that boy, give him a little urging on and he's a natural... in about five minutes he's got me on all four and humping away, plunging this fucking monster in until I'm screaming and cumming and he is too.  Oh, we made quite the mess, we two.</i>\"");
	
	outputText("\n\n\"<i>So finally he rolls off of me, flops down with his monster cock just about to his chin lying on top of him.  Well, I kind of liked him by then, so I curl up with him for a little cuddle, tell him just how good a breeder he is, what a fine specimen he was, et cetera.  But then the little bastard opens his mouth and, real quiet like, asks if we can go again - and if I'd please bugger him with my tail while I rode his cock.  Oh, well, how can I refuse?  Okay, maybe he didn't </i>ask<i> in so many words, but that's what he </i>wanted<i>, let me tell you.  And that's sure what he got.  Again and again until I'd ridden him senseless.</i>\"");
	outputText("\n\n\"<i>And then his sisters got bored and joined in.</i>\"");
	menu();
	addButton(0,"Next",dontTellMeAboutSpiderboy);
}

//Nah // Combine
private function dontTellMeAboutSpiderboy():void {
	clearOutput();
	spriteSelect(68);
	outputText("\"<i>So, let's just say I came away from that encounter carrying enough cute spiderboy cum to fill a bucket.  If I'm not carrying his child now, then I'm hopeless.  But... you know, I think I can feel it, [name].  I shouldn't be able to, but I can.  Oh, god,</i>\" Hel says, looking pointedly away from you, staring wide-eyed into the morning sky.");
	
	outputText("\n\n\"<i>What's wrong?</i>\"");
	
	outputText("\n\n\"<i>I-I really am going to be a mother.  I can feel it, [name].  The spiderboy's seed taking inside me, the dawn of a new life.  I just hope... I hope this wasn't a mistake, [name].</i>\"");
	
	outputText("\n\nYou put an arm around the mother-to-be's shoulder, saying, \"<i>I thought this was what you wanted, Hel.  You were-</i>\"");
	
	outputText("\n\n\"<i>Yeah, I know.  Forget about it, I'm fine.  Really.  It's just that this happened all so suddenly, you know?  This isn't exactly where I saw myself a year ago.  Not that I'm complaining,</i>\" she adds, turning back to you with a kiss, squeezing you with her tail.  \"<i>I just hope I'm ready, I guess.  Until the Pale Flame took, I'd never really thought about being a mother.  Never really wanted it.  But last night, it was like I was possessed, like I couldn't control myself.  I just... needed you.  Well, maybe not your sperm - not literally, I mean - but it was like my body screaming 'You've found [him], [he]'s the one, this is a keeper!  Time to propagate!' I-I can't help but feel like this wasn't entirely my choice, you know?  Like I was acting on instinct, like an animal, not a person.  But at the same time, if I've made a mistake, then I have you here with me, to help me like you always do.  I love you with all my heart, [name]");
	if (flags[kFLAGS.HEL_LOVE] == 1) outputText(", and I'm so very, very glad you love me back.");
	else outputText(", even if you can't say the same.  And that's alright; it doesn't change my heart, and it never will. I love you.");
	outputText("</i>\"");
	
	outputText("\n\nThe two of you snuggle up for a good long while, content to lie in each others' arms.  \"<i>I'm glad we're in this together, my love.  I'm going to... to need you during this.</i>\"");
	
	outputText("\n\nYou tell her to rest easy: that you'll be there for her every step of the way.  She smiles ");
	if (player.tallness >= 90) outputText("up ");
	else if (player.tallness <= 72) outputText("down ");
	outputText("at you, holding you tight for a long moment before stepping away, still holding your hands.  \"<i>This is all new to me, [name].  I never pictured myself as a mother, with a mate and a stable, safe home - or as stable and safe as anything these days - but with you by my side, there's nothing I can't take on.</i>\"");
	
	outputText("\n\nYou give your lover one last kiss before getting back to your quest.");
	doNext(camp.returnToCampUseOneHour);
}


//Hel Got Knocked Up by Some Random Slut at the Bar, and Nobody Was Really Surprised, All Things Considered. 
private function sureHelGimmeMaiDetails():void {
	clearOutput();
	spriteSelect(68);
	outputText("\"<i>You know, it's not easy for me to get around in Tel'Adre.  I lived my whole life in the middle of shit-all nowhere, the wide-open plains.  But here's a ruined city, packed full of abandoned buildings and thousands of people.  Took half the night to find Miko and Mai's place, this little bungalow-thing near the walls.  I probably got turned around three or four times, nearly gang-raped by this big pack of cats... man, fuck cities.  But anyway, I was lucky that Mai answered the door; she'd just been going to bed, I guess.  Miko was gone, off with some new girlfriend.  Or maybe getting gang-banged by cat people, since that's a thing that happens there apparently.  Who knows.</i>\"");
	outputText("\n\n\"<i>Well, it's kind of awkward to tell a good friend, 'Hey, I want to bear your children. Present your cock, slut!'  At the same time, it's not really fair to just jump her britches and ride her 'til the sun rises without her knowing what's up.  Also, the tail being white's a dead giveaway, unless I fuck her with my cloak on.  So, I take Mai to their kitchen, pour us some wine, ask her how's things, make small talk.  That gets her suspicious, of course, and finally I have to say, 'So, remember the last few weeks, we've been hanging out, and you keep saying how much you want to have kids, but can't find a good man or woman and you don't want to raise your spawn in the city, anyway?  Yeah, so, I kinda want to have kids too and this is really sudden but what do you say, lover girl?  You and me, let's make a baby!'</i>\"");
	outputText("\n\n\"<i>I'm not a diplomat or a bard, but eventually I talk her into it.  She's all nervous by the time I yank her nightgown off, asking all the wrong questions.  'Can I visit?  What do we name her?  What would a salamander-fox look like?  Do you want a boy or a girl or a;' I'm laughing, the I tell her to shut up and fuck me.  Well, by the time I get her panties off, that puppy pecker's nice and swollen, bright red with a thick knot ready to stretch me wide.</i>\"  Hel pauses to lick her lips, staring into the distance.  \"<i>She's raring to go, but I'm going to take it slow, give her a night to remember.  I get down between her legs, running my fingers across that supple flesh of hers, licking her tight little cunt 'til she's drooling on my tongue.  My tail sneaks around and does its thing, gently teasing that precious little spot where the skin meets the fluff of her tail, working its way down to her little pucker.  God, she makes the cutest little gasps when I get inside her, worming my tail into her ass 'til I find the nub of her prostate and get to milking.  Now her cock's standing at attention, and I climb into bed with her, kissing and fondling those big perky tits of hers until I can feel her ready to burst.  I go slow down on her, leaning back on my haunches until I can feel just the tip of her pressing in on my cunt; oh, she's whimpering and whining by then, grabbing my hips to try and bring me down on her, begging me to fuck her brains out, to let her swollen little knot pop its load deep inside me.</i>\"");
	
	outputText("\n\n\"<i>Finally, even I can't stand it anymore, and I drop like the hand of god on her, taking her knot and all in one go.  She came right then and there, screaming loud enough to wake the neighbors - and digging her fingers in enough to leave scratches on my ass.  But she flooded me with cum until it drooled out around her knot.  And knotted we were, let me tell you.  But that's just an excuse to go again, and with my tail right on her prostrate, she was up and at it again in half a minute, moaning as I got to work bouncing on her cock like a... I dunno, a sex bunny.  So on we go for hour after hour until Mai's just about passed out, and we're both covered in sweat and cum and that shitty lube she keeps around.  Shit, we were still at it by the time Miko got back, and suddenly I've got an extra knot tearing up my asshole and another pair of hands to play with my tits while I propped Mai up, head buried in my cleavage.</i>\"");
	
	outputText("\n\n\"<i>Come sunrise, and the three of us are filthy: the twins look like they're made of cum, and I'm gushing it out of every hole.  Eventually I managed to tell Miko what she'd stumbled into, and she insisted on making us a celebratory breakfast.  She got all excited about being an aunt, but Mai was just about passed out by the time I left - just strong enough to pull me down, give me a goodbye kiss, and rest her head on my belly, whispering cute nothings to the baby she spent all night fucking into me.</i>\"");
	menu();
	addButton(0,"Next",dontTellMeAboutMai);
}

//Nah // Combine
private function dontTellMeAboutMai():void {
	clearOutput();
	spriteSelect(68);
	outputText("\"<i>So, let's just say I came away from that encounter carrying enough foxy herm cum to fill a bucket.  If I'm not carrying her child now, then I'm hopeless.  But... you know, I think I can feel it, [name].  I shouldn't be able to, but I can.  Oh, god,</i>\" Hel says, looking pointedly away from you, staring wide-eyed into the morning sky.");
	
	outputText("\n\n\"<i>What's wrong?</i>\"");
	
	outputText("\n\n\"<i>I-I really am going to be a mother.  I can feel it, [name].  Mai's seed taking inside me, the dawn of a new life.  I just hope... I hope this wasn't a mistake, [name].</i>\"");
	
	outputText("\n\nYou put an arm around the mother-to-be's shoulder, saying, \"<i>I thought this was what you wanted, Hel.  You were-</i>\"");
	
	outputText("\n\n\"<i>Yeah, I know.  Forget about it, I'm fine.  Really.  It's just that this happened all so suddenly, you know?  This isn't exactly where I saw myself a year ago.  Not that I'm complaining,</i>\" she adds, turning back to you with a kiss, squeezing you with her tail.  \"<i>I just hope I'm ready, I guess.  Until the Pale Flame took, I'd never really thought about being a mother.  Never really wanted it.  But last night, it was like I was possessed, like I couldn't control myself.  I just... needed you.  Well, maybe not your sperm - not literally, I mean - but it was like my body screaming 'You've found " + player.mf("him","her") + ", " + player.mf("he","she") + "'s the one, this is a keeper!  Time to propagate!'  I-I can't help but feel like this wasn't entirely my choice, you know? Like I was acting on instinct, like an animal, not a person.  But at the same time, if I've made a mistake, then I have you here with me, to help me like you always do.  I love you with all my heart, [name]");
	//if HelLove is Yes:
	if (flags[kFLAGS.HEL_LOVE] == 1) outputText(", and I'm so very, very glad you love me back.");
	else outputText(", even if you can't say the same. And that's alright; it doesn't change my heart, and it never will. I love you.");
	outputText("</i>\"");
	
	outputText("\n\nThe two of you snuggle up for a good long while, content to lie in each others' arms.  \"<i>I'm glad we're in this together, my love. I'm going to... to need you during this.</i>\"");
	
	outputText("\n\nYou tell her to rest easy: that you'll be there for her every step of the way.  She smiles ");
	if (player.tallness >= 90) outputText("up ");
	else if (player.tallness <= 72) outputText("down ");
	outputText("at you, holding you tight for a long moment before stepping away, still holding your hands.  \"<i>This is all new to me, [name].  I never pictured myself as a mother, with a mate and a stable, safe home - or as stable and safe as anything these days - but with you by my side, there's nothing I can't take on.</i>\"");
	
	outputText("\n\nYou give your lover one last kiss before getting back to your quest.");
	doNext(camp.returnToCampUseOneHour);
}


//Helia's Pregnancy
//In addition to the alterations to her appearance screen, given above, the following new scenes and changes occur once Hel's been knocked up.
//Hel's pregnancy should last for ~2 weeks in-game time. Each week, she'll move from bulging to swollen to gravid every 5 days or so, which alters her Appearance slightly, and can change her pregsex scenes.
//Note that, during the pregnancy, Hel's ability to Fight and Wrestle with the PC is removed. She's not willing to let her baby get hurt!

//Hel enters "bulging" state, play at random from camp menu:
//if (flags[kFLAGS.HELIA_PREGNANCY_INCUBATION] < 300 && flags[kFLAGS.HEL_PREGNANCY_NOTICES] == 0) {
public function bulgyCampNotice():void {
	clearOutput();
	spriteSelect(68);
	outputText("As you're walking through camp, your eyes wander over toward Helia, sunning herself on a stone near the edge of camp.  You can just see that her belly's starting to bulge out from under her, and Hel's hands lie protectively over her full womb, absently rubbing the bulge of her stomach.");
	doNext(playerMenu);
}
//Hel enters "swollen" state, play at random from camp menu:
//if (flags[kFLAGS.HELIA_PREGNANCY_INCUBATION] == 200 && flags[kFLAGS.HEL_PREGNANCY_NOTICES] == 1)
public function heliaSwollenNotice():void {
	clearOutput();
	spriteSelect(68);
	outputText("You note that Hel's wandering aimlessly around camp, one hand over her belly as she mumbles to herself.  You could swear she was cursing her now quite swollen belly, but suddenly she gives a girlishly happy cry and waves you over.\n");
	outputText("\n\"<i>Come feel, [name], quick! It's kicking!</i>\"\n");
	outputText("\nYou trot over and press your ear to Hel's big belly, running your hands along her taut skin.  A moment later, and you feel a little push against you, a tiny kick right to the head from the little salamander inside your lover.");
	outputText("\n\n\"<i>Feels like she's gonna kick her way out of there sometimes,</i>\" Hel says, chuckling.  You help her sit down, both of you running your hands along the surface of her belly, responding to the little pushes her child's making.  \"<i>She's going to be a fighter, [name], let me tell you.</i>\"");
	outputText("\n\n\"<i>She?</i>\" you ask, grinning.");
	outputText("\n\n\"<i>Or he.  Whichever... so, which do you want, lover mine?  A big strong boy, or a fiery little girl just like her mom?</i>\"");
//Shouldn't be needed, bet this was originally here to stop duplicate notices:	flags[kFLAGS.HEL_PREGNANCY_INCUBATION]--;
	menu();
	addButton(0,"Boy",youWantABoy);
	addButton(1,"Girl",youWantAGirl);
}

//Boy
private function youWantABoy():void {
	clearOutput();
	spriteSelect(68);
	outputText("\"<i>Is that so? Yeah, I can see it.  ");
	if (player.hasCock() && !player.hasVagina()) outputText("If I were a guy, I'd want a big strong son to hang out with, too.  Take him fishing, teach him how to fight the way you do... you'll make a great dad, my love.  I'm sure you will.");
	else outputText("Would be nice to have a man around here, you know?  I miss hanging around the boys back home, watching 'em strut like peacocks for every passing girl.");
	outputText(" And any son of mine is going to be a real lady killer, mark my words.  We're going to have to fight off whole hordes of goblin sluts, all looking for a piece of our handsome little boy before you know it.</i>\"");
	outputText("\n\nYou share a quiet laugh with your lover before leaving her with a kiss and a final pat on the belly - and feeling the little kick of your spawn reacting to you.");
	doNext(playerMenu);
}

//Girl
private function youWantAGirl():void {
	clearOutput();
	spriteSelect(68);
	outputText("\"<i>Yeah, a girl would be pretty great.  ");
	//if PC is male:
	if (player.hasCock() && !player.hasVagina()) {
		outputText("I dunno if you had any sisters growing up, [name], but let me warn you: a little girl, especially a little salamandress, is going to be a hell of a handful.  But I can just see you when she's all grown up, packing a big old sword and threatening every boy that wants a piece of her: 'Treat her right or you'll have the CHAMPION to deal with.  Rawr.'");
	}
	else outputText("We're going to be a gaggle of tittering girls before you know it, though.  Salamanders grow up so fast, [name]...  I just hope she doesn't turn out like me, you know?  I don't know if I could stomach seeing my little girl becoming a wanton slut like her mom.  I might get jealous, after all...");
	outputText("  Any daughter of ours is going to be a real beauty, mark my words. She'll make a succubus look like a toad before she's out of swaddling.</i>\"");
	
	outputText("\n\nYou share a quiet laugh with your lover before leaving her with a kiss and a final pat on the belly - and feeling the little kick of your spawn reacting to you.");
	doNext(playerMenu);
}

//Hel enters "gravid" state, play at random from camp menu:
//if (flags[kFLAGS.HELIA_PREGNANCY_INCUBATION] == 100)
public function heliaGravidity():void {
	clearOutput();
	spriteSelect(68);
//Shouldn't be needed, bet this was originally here to stop duplicate notices:	flags[kFLAGS.HEL_PREGNANCY_INCUBATION]--;
	outputText("You can't help but notice that Hel's starting to have a hard time getting around, lately - and she's been sticking closer and closer to camp, barely leaving at all the last few days.  Now, she's fussing around her part of camp, trying to beat some spare logs into a crib one-handed.  You can't remember the last time you saw her walking around without a hand on her back to support her gravid belly, the other absently rubbing or poking at it, already playing with the child inside her.");
	
	outputText("\n\n\"<i>Hey, sweetheart,</i>\" Hel says as you wander over, planting a kiss on her cheek.  \"<i>So, it won't be long now, I don't think.  I hope.  If I get any bigger I'm liable to burst.</i>\"");
	
	outputText("\n\nYou chuckle to yourself and hold the wood beams still for Hel, helping her to fit the last few pieces together.");
	
	outputText("\n\n\"<i>Thanks, [name].  God, I feel so fucking useless lately... you know, a shitty little goblin jumped me the other day, and I actually pussied out and waddled the fuck home.  Ugh.  I can't drink, I can't get laid half the time, and whenever I get a chance to fight I get freaked out the baby might get hurt and run home with my tail between my legs.  I am so ready for this to be over,</i>\" she groans, awkwardly sitting down with both hands wrapped over her gut.  You put an arm around her shoulders, pulling Helia close; she smiles prettily and rests her head on your chest, sighing heavily.");
	outputText("\n\nAfter a minute, she looks up at you and asks, \"<i>So, have you thought about a name?</i>\"");
	
	outputText("\n\n\"<i>Hm?</i>\"");
	
	outputText("\n\n\"<i>A name.  For the kid.  I've been thinking pretty hard about it, the last few days.  What do you think about Kyros or Hylas for boy names?  They were brothers in this ancient legend mom used to tell me, a pair of salamander master smiths who sought out the great dragon Perethal and stole from his horde the first steel the world had ever seen, and forged it into a magic sword.  It was so beautiful, the legend went, that Marae herself took it for her own, gave it to the greatest of her champions for generations: once even a descendant of the smiths.  And if we have a girl... I don't really know, yet.  Maybe Syn or Chara.  Dad says I should name her after mother, but that doesn't sit right with me. Dunno why, but I just don't want a ghost's name on my living girl, you know?</i>\"");
	
	outputText("\n\nGently, you ask what her mother's name was.");
	
	outputText("\n\n\"<i>Oh, I never told you? Her name was Tanis, and she was the most beautiful woman in the world.</i>\"");
	
	outputText("\n\nYou give her a moment, but Hel seems to be done talking for now, instead staring off into the distance.  You leave her with a kiss, and get back to your duties.");
	doNext(playerMenu);
}

//Hel Talk 7 (New, play first time PC [Talk]s to Hel once she's at least "swollen")
internal function heliaTalkSeven():void {
	clearOutput();
	spriteSelect(68);
	flags[kFLAGS.HELIA_TALK_SEVEN] = 1;
	outputText("You take Hel with you to a secluded spot at the edge of camp and sit with her, asking how she's doing as you run a hand across her pregnant belly.  She nuzzles against you, wrapping her lengthy tail around your waist as her cheek nestles into the nape of your neck.  \"<i>It's... not like I expected, [name].  Whenever I used to think of being a mother, I always sort of skipped the whole 'carry the little bastards around in your belly' part.  I just feel so... full, I guess?  Like I just ate a horse, and the horse is inviting its friends to come party at night whenever I try to sleep.  Heh, this little firebrand just loves to kick and squirm at night, let me tell you.  Speaking of which-</i>\"  Hel takes your hand in hers and places it over her belly, letting you feel the subtle little movements inside her as your growing child pushes out toward the world.");
	
	outputText("\n\nStill caressing the swell of Hel's stomach, you mention that you'd have expected a salamander to lay an egg - even if she's only carrying a half-salamander.  Hel's chuckles, \"<i>Salamanders ditched the whole egg thing ages ago, I guess.  I mean, we're scaly lizard folk and all, but come on - these aren't just for show, you know,</i>\" she says, cupping her hefty tits, which seem to have grown just a touch larger since she conceived.");
	
	outputText("\n\n\"<i>Getting ready to swell with milk,</i>\" Hel says, proudly patting her bust.  \"<i>Don't worry, lover mine; we salamanders are hard drinkers right out of the womb, but I'll be sure to save plenty for you!</i>\"");
	
	outputText("\n\nA moment of laughing passes before Hel adds, \"<i>But seriously, lover, thanks for checking in on me.  I don't... I can't do this on my own, you know?  I'm trying, but it's hard, and getting harder.  Every night since this started, I've lain up thinking 'Oh god, what if I screw this up?  Wh-what if I say something wrong, or do something that just twists my kid's mind and fucks her up forever?  Or she turns into a bigger whore than I am,' or a million other things I can't stop thinking about.  I just keep worrying that I'm going to be a shit mom.  But you know... with you around, I feel at least a little more confident.  I don't know if I even could have a good impression on our kid, but... I know you will, [name].  You're a strong " + player.mf("man","woman") + "; stronger than I'll ever be.  I just hope a tiny little sliver of your strength - and maybe a healthy dose of your looks - rub off on him.  Or her.  That's all I'd ask for");
	//if PC isn't daddy:
	if (flags[kFLAGS.HELSPAWN_DADDY] != 0) outputText(", even if he's not your get, I can hope, you know?  If he spends enough time around you, maybe he'll take more after you than me");
	outputText(".</i>\"");
	menu();
	addButton(0,"EncourageHer",encouragePregalia);
	addButton(1,"Wellll...",helsLifestyle);
}

//[Encourage Her]
//[Hel's Lifestyle]
//Encourage Her
private function encouragePregalia():void {
	clearOutput();
	spriteSelect(68);
	outputText("You squeeze Hel's shoulder and tell her that she's going to be a great mother, and that her child would do well to learn from a beautiful, powerful warrior like dear old mom.  ");
	if (flags[kFLAGS.HEL_LOVE] == 1) outputText("You love Hel");
	else outputText("Hel's your friend");
	outputText(", and if her child follows in her footsteps, so much the better.  Your lover manages a half-hearted laugh, blushing at your words.  Her tail tip brushes your cheek as its owner cuddles up against you, smiling.  \"<i>Thanks, lover mine.  I just hope I - we - can do right by the kid.  That's all.</i>\"");
	outputText("\n\n\"<i>I know,</i>\" you answer, kissing her.");
	doNext(playerMenu);
}

//Hel's Lifestyle
private function helsLifestyle():void {
	clearOutput();
	spriteSelect(68);
	outputText("Being very serious for a moment, you tell Hel that if she's worried about her terrible choices rubbing off on her kid, maybe she ought to reconsider some of the things she's done: be less of a slut, drink less, be less of a bloodthirsty maniac in battle.  Slowly, Hel nods to the rhythm of your words.  \"<i>Yeah, maybe... maybe I should.  I don't know if I can change though, [name].  I'm not as young as I was - or at least, I don't feel it - and I've been living the way I have been for years.  I don't know if I could just give up the shit I do: the partying and the drinking, the fighting and the fucking.  It's part of who I am, ");
	if (flags[kFLAGS.HEL_LOVE] == 1) outputText("and I hope that's part of why you love me");
	else outputText("even though I know that's probably part of why you can't love me back");
	outputText(".  I'll try and rein it in, but maybe... it'd be better if you were the one who raised my child, [name].  God knows I'm the least qualified person to do it.</i>\"");
	
	outputText("\n\nYou start to answer, but Hel puts a finger to your lips, telling you she needs a little while to think.  You nod, and head back to your work.");
	doNext(playerMenu);
}

//IT'S TIME! (Play the morning of the 15th Day of Helia's pregnancy)
public function heliaBirthtime():void {
	if (prison.inPrison) {
		prison.prisonLetter.letterFromHelia1();
		return;
	}
	clearOutput();
	spriteSelect(68);
	outputText("The morning dawns like any other, though as you're getting dressed, you can't help but notice Hel waddling back from the edge of camp, both hands firmly gripping her positively massive belly.  You walk over just in time to hear her groan, \"<i>Oh fuck me sideways and call me a harpy, this shit sucks.</i>\"  You put an arm around her to steady the sickened salamander, but she barely notices you as she flops down beside her still, nearly grabbing a glass before stopping herself.  \"<i>Fucking shit fuck I am so done with this.  I - oh god,</i>\" she doubles over, squeezing her belly.  \"<i>Ow ow oh god ow.</i>\"");
	
	outputText("\n\nYou ask Hel if she's okay, which earns you a bestial growl and a murderous look.  Her look softens a moment later when she doubles over again, seized by agony.  \"<i>Just about time, [name].  Oh fuck, this hurts something fierce.</i>\"");
	
	outputText("\n\nKneeling beside the salamander, you ask what she needs - what can you do?");
	
	outputText("\n\n\"<i>I-I don't know!</i>\" Hel cries, leaning back against you, her legs spreading.  \"<i>I don't </i>fucking<i> know! Just - aahhhh - hold my hand!</i>\"");
	
	outputText("\n\nYou dutifully hold Helia's hand as water gushes out from between her legs, heralding the birth of ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 1) outputText("your ");
	else outputText("her ");
	outputText("child.  Hel screams and cries, gripping your hand so tight you feel like your bones are about to break in her iron gasp; you try and tell her to push, to remember everything the Midwives of Ingnam would say when a village girl gave birth.  It seems a small comfort to the screaming salamander, but she does as you say, pushing harder and harder until you can see the crown of a little baby's head pushing out of your lover's well-stretched cunt.  Suddenly with a roar that echoes across the wasteland and a mighty push, a squalling baby tumbles out of Hel's birth canal and into your waiting arms.");
	menu();
	addButton(0,"Next",heliaBirthEpilogue);
}

private function heliaBirthEpilogue():void {
	clearOutput();
	spriteSelect(68);
	//It's a girl! 
	//If PC was the father: 
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("A healthy baby salamander gurgles and cries as you wrap her in a towel, looking up at you with a pair of bright golden eyes.  Hel takes your daughter, holding the little bundle of you to herself, cooing and laughing at the new life in her arms.  \"<i>Oh my god, [name], look... it's... it's our baby girl.  And she's got your eyes.  The same look I see in your eyes every day.  Oh, this one's going to grow up big and strong.  Aren't you?</i>\" she laughs, rubbing the baby's cheek.  It makes a high, gay little coo in response, nuzzling against Hel's finger.");
	//If Mai was the father:
	else if (flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("What you hold in your arms isn't <b>quite</b> a salamander, though.  The little girl you've by now got wrapped up in a towel looks mostly like her mother, with a full body of red scales and pale flesh, and a brightly flaming tail; but atop her head, rather than finned reptilian ears are a pair of perky, puppy-dog like ears.  Taking her daughter, Hel laughs, scratching the newborn behind the ears, making it coo and giggle.  \"<i>Oh my god, [name], look... it's... it's our baby girl.  And she's got Mai's ears, holy shit.  Look at that.  Oh, you're going to be adorable when you grow up, aren't you?</i>\" she laughs, rubbing the baby's cheek.  It makes a high, gay little giggle in response, nuzzling against Hel's finger.");
	else outputText("What you hold in your arms isn't <b>quite</b> a salamander, though. The little girl you've got wrapped up in a towel has the same shape as her mothers, a body covered in leather scales and a brightly-flaming tail... but her scales are a midnight black, the same color as a spider's chitin.  The little girl looks up at you with bright red eyes as Hel takes her from you, laughing as she runs her hand across her daughter's dark scales.  \"<i>Well, that's a hell of a thing, isn't it [name]?  A black-scaled salamander... she's beautiful.  Oh you're going to be gorgeous when you grow up, aren't you?</i>\" she laughs, rubbing the baby's cheek.  It makes a high, gay little giggle in response, nuzzling against Hel's finger.");
	//[New Paragraph]
	outputText("\n\nThough still panting from the ordeal, Hel's motherly instincts kick in as her daughter tries to eat her finger, and pulls her scaled top down to reveal the swell of her big, milky breast.  The newborn latches on immediately, sighing happily as it takes its first meal.  A sentiment echoed by her mother, who slumps over onto your shoulder, breathing easy for the first time in the day.  \"<i>That was... gaaah.  But look... look at her.  My god, she's amazing.  So beautiful... she's perfect, [name].  And she's- oh, she's got a hell of a bite.  Ow.</i>\"");
	menu();
	addButton(0,"Next",nameDatHelspawn);
}

//[NEXT]
private function nameDatHelspawn():void {
	clearOutput();
	spriteSelect(68);
	outputText("You and Helia share a laugh, looking down at ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your ");
	else outputText("her ");
	outputText("little girl as she suckles.  After a few happy, blissful minutes though, Hel turns to you with a question:");
	outputText("\n\n\"<i>So... what do we name her, love?  I honestly hadn't put that much thought into girl names.  Kind of expected a boy, I guess, but... it's up to you, [name].  What do you think?</i>\"");
	menu();
	addButton(0,"Next",applyHelspawnName);
	mainView.nameBox.text = "";
	mainView.nameBox.visible = true;
	mainView.nameBox.width = 165;
	mainView.nameBox.x = mainView.mainText.x + 5;
	mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
}
private function applyHelspawnName():void {
	spriteSelect(68);
	//Easter Egg Names Hel WILL NOT ALLOW:
	if (mainView.nameBox.text == "" 
			|| mainView.nameBox.text == "Hellgirl" 
			|| mainView.nameBox.text == "Kid" 
			|| mainView.nameBox.text == "Phoenix" 
			|| mainView.nameBox.text == "Savin" 
			|| mainView.nameBox.text == "Helia" 
			|| mainView.nameBox.text == "Mini-doofus") 
	{
		clearOutput();
		if (mainView.nameBox.text == "") outputText("<b>You must select a name.</b>", false);
		else if (mainView.nameBox.text == "Hellgirl") outputText("\"<i>Hey, that's copyright infringement.  Probably.</i>\"");
		else if (mainView.nameBox.text == "Kid") outputText("\"<i>Wow, what are you, five?</i>\"");
		else if (mainView.nameBox.text == "Phoenix") outputText("\"<i>Oh hell no.  You're not naming my little girl after one of those... things!  Sorry Kiri, but still!</i>\"");
		else if (mainView.nameBox.text == "Savin") outputText("\"<i>That's a boy's name, dumbass.</i>\"");
		else if (mainView.nameBox.text == "Helia") outputText("\"<i>My favorite name!  Except it's kinda taken, love.  Don't want things to get too confusing around here, do you?</i>\"");
		else if (mainView.nameBox.text == "Mini-doofus") outputText("\"<i>Oh yeah, Kiha'll get a laugh out of that.  You ass.</i>\"");
		//[Back to the name field you go!]
		menu();
		mainView.nameBox.x = mainView.mainText.x + 5;
		mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		addButton(0,"Next",applyHelspawnName);
		return;
	}
	flags[kFLAGS.HELSPAWN_NAME] = mainView.nameBox.text;
	mainView.nameBox.visible = false;
	//[Name Field]
	//Easter Egg Names:
	clearOutput();
	if (flags[kFLAGS.HELSPAWN_NAME] == "Helspawn") outputText("\"<i>That's what I was gonna call her!  Except not at all.  God dammit, seriously, [name]?</i>\"\n\n");
	if (flags[kFLAGS.HELSPAWN_NAME] == "Jayne") outputText("\"<i>That sounds like a hero's name... I like it.  A name that demands respect!</i>\"\n\n");
	if (flags[kFLAGS.HELSPAWN_NAME] == "Hesper") outputText("\"<i>Ah, the Evening Star.  She'll be the star of my life, alright...</i>\"\n\n");
	if (flags[kFLAGS.HELSPAWN_NAME] == "Kiri") outputText("\"<i>Aw, that's great, lover.  Sis'll shit her pants when she hears her niece is named after her!  Gonna get confusing, though...</i>\"\n\n");
	if (flags[kFLAGS.HELSPAWN_NAME] == "Mai") outputText("\"<i>Aw, that's great, lover.  Mai'll be honored, I know it.  And it is a great name...</i>\"\n\n");
	if (flags[kFLAGS.HELSPAWN_NAME] == "Tanis") outputText("\<i>I don't... I don't know if I want her to have that name, lover.  It's got a lot of baggage, but... but it does my mother an honor.  More than I could ever give her.</i>\"\n\n");
	//Syn: 
	if (flags[kFLAGS.HELSPAWN_NAME] == "Syn") outputText("\"Awesome.  I was hoping you'd choose that one, lover mine.</i>\"\n\n");
	if (flags[kFLAGS.HELSPAWN_NAME] == "Chara") outputText("\"<i>Awesome.  You liked my ideas, after all!</i>\"\n\n");
	
	outputText("\"<i>So... " + flags[kFLAGS.HELSPAWN_NAME] + " it is.  That's a good name, my love.  A strong name.  ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("Our");
	else outputText("my");
	outputText(" little girl's going to grow up big and strong with a name like that... and with you around to guide her,</i>\" Hel says, kissing your cheek.  \"<i>Why don't you give me a minute to catch my breath and get the little one situated, and let's talk.  Alright?</i>\"");
	
	outputText("\n\nYou nod and help Helia to her feet, still holding " + flags[kFLAGS.HELSPAWN_NAME] + " to her breast.  Your lover gives you a wink before walking bow-legged back toward her part of camp, and the little crib she's built beside her hammock.");
	helSpawnsSetup();
	doNext(camp.returnToCampUseTwoHours);
}

//NOTE: HelSpawn's personality meter & Growing Up
public function helSpawnsSetup():void {
	//HelspawnChaste and HelspawnSlutty are the new Variabls for Helspawn, indicating the ways you can morph her personality, whichever is higher at the end of the Teenage years indicates whether she gets to be a proud, chaste warrior girl fit for Paladinhood or a slutty, filthy whore of a berzerker like mom. 
	//Depending on who her daddy was, she gets a bonus to one or the other stat:
	//>If Mai is the daddy: +10 HelspawnSlutty
	flags[kFLAGS.HELSPAWN_PERSONALITY] = 50;
	if (flags[kFLAGS.HELSPAWN_DADDY] == 2) flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
	//>If Spiderbro is daddy: +10 HelspawnChaste
	if (flags[kFLAGS.HELSPAWN_DADDY] == 1) flags[kFLAGS.HELSPAWN_PERSONALITY] -= 10;
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) {
		//>If Corrupt (66+ Corr) PC is daddy: +10 Helspawn Slutty
		if (player.cor >= 66) flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
		//>If Pure (33> Corr) PC is daddy: +10 Helspawn Chaste
		if (player.cor <= 33) flags[kFLAGS.HELSPAWN_PERSONALITY] -= 10;
	}
	flags[kFLAGS.HELSPAWN_AGE] = 1;
	flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] = 1;
	kGAMECLASS.helScene.pregnancy.knockUpForce(); //Clear Pregnancy
	//>If the two scores tie at the end somehow, Sluttymandergirl prevails!
}

//Hel Talk 8 (Only while HelSpawn is still a baby)
internal function heliaTalkEight():void {
	clearOutput();
	flags[kFLAGS.HEL_TALK_EIGHT] = 1;
	spriteSelect(68);
	outputText("Watching your little daughter crawl around, you and Hel sit down together arm in arm, smiling as the little salamander girl plays with bits and pieces of Hel's gear.");
	outputText("\n\n\"<i>She's growing up so fast... and only getting faster.  By the time I pulled her off my breast the first time, I swear she'd doubled in size.</i>\"  You nod, able to see it clearly yourself.  Your little girl's growing fast... and it's not just a ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("parental ");
	else outputText("care giver's ");
	outputText("pride, either.  She really is growing up faster, many times faster than a human girl.  And, by the sound of things, many times faster than a salamander ought to.  You ask Hel if that's right, and she nods gravely.");
	
	outputText("\n\n\"<i>I don't know what it is about this world, but it's touched me... my daughter... already.  She's growing like a little goblin, and I don't know why.  Could it have been something I drank?  Something I fucked?  I can't... I don't know, [name].  It's probably my fault, but I can't imagine what I did wrong.  She should be taking years to get this big, but look at her...</i>\"");
	
	outputText("\n\nHel's right. Your little girl looks like she's five, maybe six years old already.");
	
	//If Amily is at camp: 
	if (amilyScene.amilyFollower()) outputText("\n\nYou mention how Amily managed to reverse-engineer a goblin's potion to accelerate her childrens' growth.  Hel grimaces, running a hand over her belly.  \"<i>God damn green menaces.  I never - almost never - drank any of their shit.  Succubus milk?  Sure, why not.  Snake oil, bring it on... But goblin potions?  I'm not that stupid, [name].  It couldn't have been...</i>\"");
	
	outputText("\n\nSighing, Hel leans her head on your shoulder, wrapping her tail around your waist.  \"<i>Well, I guess we get even less time to learn how to be parents, huh?  I guess it doesn't matter how it happened - what matters is that ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("our");
	else outputText("my");
	outputText(" little girl's going to be a big girl damn soon.  Let's enjoy it while we can, eh?</i>\"");
	
	outputText("\n\nYou nod to your lover, and the both of you walk over to spend some quality time playing with " + flags[kFLAGS.HELSPAWN_NAME] + ".");
	doNext(camp.returnToCampUseOneHour);
}

//From Hel's menu: [Play with Kid]
internal function playWithYourKid():void {
	clearOutput();
	spriteSelect(68);
	outputText("Picking " + flags[kFLAGS.HELSPAWN_NAME] + " up off the ground, you spin the giggling little girl around, laughing as your ");
	if (flags[kFLAGS.HELSPAWN_DADDY] != 0) outputText("ward ");
	else outputText("daughter ");
	outputText("cries out in surprise and glee.  Soon, you're bouncing her, then down on the ground crawling around with her, playing peek-a-boo and a dozen other games as you and " + flags[kFLAGS.HELSPAWN_NAME] + " laugh and hug.  Helia herself slips down with you before you know it, holding her daughter close as she tries to communicate, teaching the ever-growing girl a few words at a time.");
	
	outputText("\n\n\"<i>Mommy!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " eventually cries, bopping her mother on the nose. Hel laughs, but it turns into a sigh as her daughter reaches down and fiddles with her top, obviously hungry.");
	
	outputText("\n\n\"<i>We've got to wean this one before she bites my tits off,</i>\" Hel groans as " + flags[kFLAGS.HELSPAWN_NAME] + " latches on, starting to suckle.  \"<i>Those teeth came in fast...</i>\"");
	
	outputText("\n\nLaughing, you rustle " + flags[kFLAGS.HELSPAWN_NAME] + "'s fiery hair and leave mother and daughter to finish the meal.");
	doNext(camp.returnToCampUseOneHour);
}

//Event: Helspawn Graduates from Baby to Teenager
//(Play as the PC wakes up)

public function helSpawnGraduation():void {
	clearOutput();
	spriteSelect(68);
	flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] = 1;
	flags[kFLAGS.HELSPAWN_AGE]++;
	outputText("You wake up to a scream, high-pitched and terrified.  You bolt up out of bed, tangling up in your bedroll for a minute before stumbling over to Hel and... " + flags[kFLAGS.HELSPAWN_NAME] + "?");
	outputText("\n\nYou do a double take as you lay eyes on the ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 1) outputText("black");
	else outputText("red");
	outputText("-scaled figure curled up next to Helia; Hel herself is looking wide-eyed down at the drowsy figure on her breast, just barely opening her eyes.  \"<i>Y-you're... you're huge!</i>\" Hel manages to gasp out, pushing herself back and away from her daughter.");
	
	outputText("\n\n\"<i>Mom?</i>\" the girl asks, rubbing her temple.  As she sits up, you can see that she's grown exponentially since you put her to bed the night before: she's nearly six feet tall, her hair hanging down in long, silky locks to her bare behind.  Her figure's filled out, a pair of burgeoning breasts and flared hips showing themselves on her feminine body.  She'd easily match any of the teenage girls in your home town in terms of size and figure, maybe fifteen or sixteen in appearance now.");
	
	outputText("\n\n\"<i>Ugh, what's wrong?</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " groans, looking up at Hel, then to you.  \"<i>" + championRef() + ", why's mom screaming?</i>\"");
	outputText("\n\n\"<i>Oh my god you're a giant!</i>\" Hel babbles, curling her knees up to her chest.  \"<i>Wh-wh-what... what happened to... to my little girl?</i>\"");
	
	outputText("\n\nYou have to admit, the change is sudden and drastic... but the girl's scales, her eyes, they're certainly " + flags[kFLAGS.HELSPAWN_NAME] + "'s.  ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("And the puppy ears, now more wolf-like, are a dead giveaway.  Utterly unique to her.  ");
	outputText("You sit down beside the obviously confused girl and stroke her hair, telling her it's all right, her mother's just startled, that's all.");
	
	outputText("\n\n\"<i>It's just me, mom,</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says, sliding over to sit beside her mother, who's still wide-eyed with shock.  Your girl tries for a few moments to talk to Hel, but seeing that venture prove fruitless - Hel seems utterly insensate, paralyzed by shock - she instead curls back up beside her mother, head rested on Helia's shoulder.  Eventually, warily, Hel reaches out a trembling hand to brush her daughter's cheek.");
	outputText("\n\n\"<i>My god, she's growing so fast... and I don't want to lose her so soon.  I want my baby back.</i>\"");
	
	outputText("\n\nCupping Hel's cheek, you sit beside her, holding your lover tight as her daughter dozes beside her, clearly exhausted after the massive growth spurt she's endured while you were sleeping.");
	
	outputText("\n\nIt looks like you've got a teenager, now.  A wide-eyed, impressionable youth.  You can only hope you make the right choices in raising her now, when it counts...");
	doNext(camp.returnToCampUseOneHour);
}

//Event: Helspawn Discovers Booze
//(Play at random during Teenage Helspawn days)
public function helspawnDiscoversBooze():void {
	clearOutput();
	spriteSelect(68);
	flags[kFLAGS.HELSPAWN_DISCOVER_BOOZE] = 1;
	outputText("As you're moving through camp, you notice Hel's away from her little nook - probably off visiting the family, seeing as her cloak's gone.  You wouldn't have given her part of camp a second look, except for a sudden whiff of brimstone and burning brewery on the wind.  Cocking an eyebrow, you creep over to Hel's still, quiet as ");
	if (player.race() != "cat-boy" && player.race() != "cat-girl") outputText("a cat");
	else outputText("the cat you are");
	outputText(", and poke your head around the iron body of the still.");
	
	outputText("\n\nFlopped down on the ground with her mouth right under the spigot is " + flags[kFLAGS.HELSPAWN_NAME] + ", using her tail to keep the tap open and flowing into her waiting maw as she lazes beneath it.  When you loudly clear your throat, she flails around a moment, letting the tap go as she scrambles to her feet - only to fall drunkenly on her ass.  \"<i>Uh...</i>\" she groans, wiping the booze off her cheeks as she hiccups drunkenly.  \"<i>Hi there, " + championRef() + ".</i>\"");
	menu();
	addButton(1,"Scold Her",scoldHelSpawn);
	addButton(0,"Encourage",encourageHelspawn);
}

//Scold Her
private function scoldHelSpawn():void {
	clearOutput();
	spriteSelect(68);
	outputText("You cross your arms over your chest and ask your little salamander exactly what she thinks she's doing.");
	outputText("\n\n\"<i>Uh, I'm... uh...</i>\" she starts before you pick her up by the scruff of the neck, pulling her away from the still.  She squirms and flails drunkenly in your grasp, but is unable to escape in her condition.  \"<i>P-put me down, " + championRef() + "!</i>\" she squeals, but you only tsk your tongue as you drag her away, dropping her on your bedroll, well away from the booze.");
	outputText("\n\nCrossly, you again ask what she was doing.");
	outputText("\n\n\"<i>I was, uh, just havin' a drink.  Mom drank twice as much as I must've 'fore she left...</i>\"");
	outputText("\n\nAnd just because her mother does something means she should, too?");
	outputText("\n\n\"<i>Wha..</i>\"");
	outputText("\n\nYou sit down beside " + flags[kFLAGS.HELSPAWN_NAME] + " and grab a waterskin, telling her to drink some of this instead - it'll curb the hangover later.  With a look from you, she meekly obeys, sipping at the waterskin as you start to explain that there's no good to come from being a drunkard: that it impairs her decision making, and clouds her mind; like she is now, barely able to think straight after downing gallons.  She's lucky she doesn't die from drinking that much, especially without the tolerances her mother's probably spent years building up.");
	outputText("\n\n\"<i>But I was just...</i>\" she whines, looking up at you plaintively.  You sigh, and put an arm around her shoulder, telling her it's okay.  She just needs to hold off on the booze... she's too young for that.");
	outputText("\n\n\"<i>You'll have plenty of time for things like that later.  For now, stay away from mom's still, alright?</i>\"");
	outputText("\n\n\"<i>Alright, " + championRef() + ",</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says, curling up beside you, head resting on your [chest].");
	//{HelspawnChaste +10}
	flags[kFLAGS.HELSPAWN_PERSONALITY] -= 10;
	doNext(camp.returnToCampUseOneHour);
}
//Encourage Her
private function encourageHelspawn():void {
	clearOutput();
	spriteSelect(68);
	outputText("\"<i>Move over, you,</i>\" you say, sliding down beside your little salamander as you pop the tap open again.  \"<i>Gotta pace yourself, see,</i>\" you add, taking a long draught before closing it off again, savoring the potent taste of Hel's mighty brew.");
	outputText("\n\n\"<i>Wha...?</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " starts to say, before catching on as you drink, inviting her to join you.");
	outputText("\n\n\"<i>The trick is,</i>\" you say, letting your daughter get back under the tap, \"<i>You gotta build up your tolerance.  Your mom's been drinking like a fish for a decade; you can't just dive in and expect to do what she does.  You have to pace yourself.</i>\"");
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " nods slowly, slurping up a cheek-full of beer before you switch out with her again.  While she doesn't have a mouth full of Hel's distillery, you pass her a waterskin, telling her that the more water she drinks, the less shit she'll feel later on.  She drinks eagerly, switching off with you time after time until your entire world seems like a blur and your muscles seem like leaden weights far beyond your control.  You're both utterly shit-faced, giggling and stumbling by the time you manage to pull yourself away from the nearly empty still.");
	outputText("\n\n\"<i>Hey, what gives,</i>\" a voice snaps from somewhere beyond your hazy sight.  It sounds mildly like a cat, though you can't tell why in your state.");
	
	outputText("\n\n\"<i>Uh...</i>\" you groan, slumping over onto your [ass].  " + flags[kFLAGS.HELSPAWN_NAME] + "'s right behind you, collapsing on top of you in a pile of ");
	if (flags[kFLAGS.HELSPAWN_DADDY] != 1) outputText("red ");
	else outputText("black ");
	outputText("scales and the smell of a burning brewery.");
	
	outputText("\n\n\"<i>You two drank the entire fucking thing!</i>\" the voice shrilly shouts as a flaming red figure materializes in front of you.  \"<i>I turn my back for five minutes, and the two of you drink me outta house and home!</i>\"");
	
	outputText("\n\n\"<i>I saved some for ya, mom,</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " groans, retching.");
	
	outputText("\n\n\"<i>Oh. Oh that's just great, [name].  Good job.</i>\"");
	
	outputText("\n\n\"<i>I was just teachin' her howta hold her liquor.</i>\"");
	
	outputText("\n\n\"<i>I am so not cleaning this up,</i>\" Hel grumbles, flopping down beside you and fishing out a flask from her cloak.  \"<i>Well, at least you didn't drink </i>everything<i>.</i>\"");
	//{HelspawnSlutty +10}
	flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
	doNext(camp.returnToCampUseOneHour);
}

//Event: Helspawn Chooses a Fighting Style
//(Play during the day when returning to camp)
public function helSpawnChoosesAFightingStyle():void {
	clearOutput();
	spriteSelect(68);
	outputText("As you make your way back to camp, you begin to hear the sounds of fighting from ahead.  Readying your [weapon], you pick up the pace until your campsite comes into view.  You relax, seeing that it's only " + flags[kFLAGS.HELSPAWN_NAME] + " and her mother.  Helia's standing near the center of camp, ");
	if (camp.companionsCount() > 3) outputText("apparently having cleared out most of your other followers for the moment, ");
	outputText("her sword held at a guard pose between herself and a training dummy. " + flags[kFLAGS.HELSPAWN_NAME] + " stands a few feet behind her mother, watching intently as Hel paces around the dummy, breathing hard.");
	
	outputText("\n\nSuddenly, the towering salamander screams a deafening battlecry and lunges forward, nearly topping the dummy in a mad bull rush before swinging her scimitar in a flurry of crushing blows that send bits of pieces of dummy flying in all directions.  There isn't much left by the time Hel's finally finished with it, slumping over the fallen mannequin as she huffs and puffs, completely out of breath.");
	
	outputText("\n\n\"<i>Okay, let me... Lemme go pick up the, uh, pieces and then you try, sweetie,</i>\" Hel says, picking up the dummy's severed arm.");
	
	outputText("\n\n\"<i>Hi, " + championRef() + ",</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says cheerily as you wander over, inspecting the carnage.  \"<i>Mom's teaching me how to be a berzerker.</i>\"");
	
	outputText("\n\nHel chuckles to herself, \"<i>Yep.  Probably gonna need a new dummy, though.  They, uh, appear to have a low survival rate...  hey, any chance you could float me a loan, lover mine?  Got a friend in town who found a sword just like mine, and I'd love for " + flags[kFLAGS.HELSPAWN_NAME] + " to have it.  Kinda strapped for cash at the moment, though. Dad's place sprung a leak, had to get that fixed.</i>\"");
	
	outputText("\n\nWell.  You suppose you could float Hel a loan and let little " + flags[kFLAGS.HELSPAWN_NAME] + " grow up as a furious salamander berzerker just like dear old mom.  Or, if you have the time, you could instead do her combat training yourself.  You probably can't completely get rid of the 'mander temper, but a few hours in the ring with you would certainly make her less brazenly reckless - something Hel could benefit from, too, if she's willing to stick around.");
	//{If PC has a bow & skill 100+}: 
	if (player.statusEffectv1(StatusEffects.Kelt) >= 100) {
		outputText("\n\nThen again, while the little salamander needs to be able to defend herself, it might be better to give her a more defensive weapon altogether.  The guards of your village called the bow the wise man's weapon, as the archers sat behind the lines or atop high walls, picking off enemies.  While you weren't trained with it back home, you've gotten pretty good with your bow during your time here.  Perhaps it's time to pass on those skills to " + flags[kFLAGS.HELSPAWN_NAME] + ".");
	}
	menu();
	if (player.statusEffectv1(StatusEffects.Kelt) >= 100) addButton(2,"Bow",snipermanders);
	addButton(0,"You Train",swordAndBoardmander);
	addButton(1,"Loan",dasBarbarimander);
	
}

//Archery (Dat Snipermander)
private function snipermanders():void {
	clearOutput();
	spriteSelect(68);
	flags[kFLAGS.HELSPAWN_WEAPON] = "bow";
	outputText("You tell Hel to take a break: you've got this handled. Grabbing your bow and quiver from over your shoulder, you hand them over to ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your");
	else outputText("Hel's");
	outputText(" eager daughter. " + flags[kFLAGS.HELSPAWN_NAME] + " takes them up with surprising reverence, holding them as gingerly as glass.  Grinning, you clasp her shoulder and tell her how to put the quiver on, and get her stance right for shooting.  It takes her a moment to get set up: her scaled, reptilian legs don't naturally stand in the shooting pose you've adopted");
	if (player.lowerBody == LOWER_BODY_TYPE_LIZARD) outputText(", even with your own lizard legs");
	outputText(", and you find yourself having to correct her grip on the haft several times.  But, finally, you get her ready to shoot.");
	
	outputText("\n\nYou slip behind " + flags[kFLAGS.HELSPAWN_NAME] + ", putting your arms on hers as you guide her through nocking an arrow, head resting on her fist, a lone finger outstretched toward the dessicated dummy.");
	
	outputText("\n\nBreathing hard, the young salamander draws back the bowstring, lining up on her target.  She chews on her lower lip, eyes squinting, deep in concentration, wanting to make this first shot count - to make you proud.  She looses the arrow, and gasps as it bolts away with lethal force... and sails across camp, well away from the target.");
	//If Rath is @ camp:
	if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0) outputText("  You hear your old alchemist friend suddenly putting up a ruckus as the sounds of breaking glass echo throughout camp.  " + flags[kFLAGS.HELSPAWN_NAME] + " looks up at you nervously, but you ruffle her fiery hair and tell her to try again. Rath is probably just fine.");
	//else if Valeria/Latexy is at camp: 
	else if (flags[kFLAGS.VALARIA_AT_CAMP] == 1) outputText("  You hear a sudden yelp of pain from across camp. Valeria slithers up to you with an irritated look on her gooey face, pointing an accusing finger at an arrow sticking out of her tit.  \"<i>Dammit, [name], I'm a googirl, not a pin cushion!</i>\"  You wave her off, and tell " + flags[kFLAGS.HELSPAWN_NAME] + " to try again.");
	else if (latexGooFollower()) outputText("  You hear a sudden yelp of pain from across camp.  " + flags[kFLAGS.GOO_NAME] + " slithers up to you with an irritated look on her gooey face, pointing an accusing finger at an arrow sticking out of her tit.  \"<i>Dammit, [name], I'm a googirl, not a pin cushion!</i>\"  You wave her off, and tell " + flags[kFLAGS.HELSPAWN_NAME] + " to try again.");
	
	outputText("\n\n\"<i>I-I dunno, " + championRef() + ",</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " whines, biting her lip as she traces the arrow's path with her eyes.  \"<i>Maybe mom was right. I should just stick to a sword. That's easy....</i>\"");
	
	outputText("\n\nYou sigh and tell her to try again.  She can't expect to be perfect on the first try, after all.  It takes a little convincing, but soon you've got " + flags[kFLAGS.HELSPAWN_NAME] + " back into form and nocking an arrow.  You put your hands on hers, helping the young salamander take aim, drawing down on her straw-stuffed target.  Barely audible over " + flags[kFLAGS.HELSPAWN_NAME] + "'s nervous breathing, you whisper, \"<i>Take it easy.  Relax.... Good.  Take aim... now breathe out.  Exhale and loose.</i>\"");
	
	outputText("\n\nAgain, " + flags[kFLAGS.HELSPAWN_NAME] + " lets an arrow fly - and this one strikes true.  You watch the missile streak across camp, slamming into the training dummy's crotch with deadly force.  It sways, buckles, and falls to pieces.");
	
	outputText("\n\n\"<i>Ouch,</i>\" Hel laughs, sipping on her flask behind you.  \"<i>What'd that poor dummy ever do to you?</i>\"");
	
	outputText("\n\n\"<i>I did it!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " shouts, pumping her fist in the air. Her mother reaches over to ruffle her fiery hair, and you both shower her with congratulations.");

	outputText("\n\nBefore she can get cocky, though, you push the bow back into her hands.  \"<i>Lesson 2, kiddo: one shot is never enough.</i>\"");
	
	outputText("\n\nBy the time " + flags[kFLAGS.HELSPAWN_NAME] + " has her shooting stance back, her mother's already set the dummy back up, ready for round two.  It's several hours long before the three of you quit: time spent drilling " + flags[kFLAGS.HELSPAWN_NAME] + " on stance and aim, even going a round with her and a pair of daggers to remind her that enemies will eventually close in if she's not careful.  She learns quickly, though, and soon she hardly needs your help to plant an arrow in the target's chest.");
	
	outputText("\n\nA few hours like this every night, and ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your ");
	else outputText("Hel's ");
	outputText("daughter will be a warrior worthy of her parent");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("s");
	outputText("."); 
	doNext(camp.returnToCampUseOneHour);
}

//Teach Her {Sword and Boardmander}
private function swordAndBoardmander():void {
	clearOutput();
	spriteSelect(68);
	flags[kFLAGS.HELSPAWN_WEAPON] = "scimitar and shield";
	outputText("You tell Hel to take a break: you've got this handled.  You grab some kindling and string from your supplies, and a few minutes later you've got a pair of small, vaguely sword-like practice weapons pieces together.  Tossing one to the young salamander, you tell her to come get some.");
	
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " gives the blade a few practice swings before grabbing the wooden blade in both hands and charging at you.  You put your guard up, catching her first overhand blow and turning it aside, nearly toppling the girl over.  She rolls with it, spinning out of your guard and trying a strike from the side.  You parry it, catch an opening, and give her a nice wallop on the shoulder.  A real blade would have nearly cut her arm off, but " + flags[kFLAGS.HELSPAWN_NAME] + " merely stumbles back, yelping in pain.");
	
	outputText("\n\n\"<i>Again,</i>\" you say, assuming your fighting stance.");
	
	outputText("\n\nShe lunges, yelling a warcry as she slashes for your throat.  You nimbly dodge aside, letting her tumble through the space you occupied a moment ago, giving her a swat on the ass as she flies by.  She flops to the ground, eating dirt and rubbing her butt.");
	
	outputText("\n\n\"<i>Owwww.  No fair.  Hold still, " + championRef() + "!</i>\"");
	
	outputText("\n\nYou sigh.  \"<i>Again.</i>\"");
	
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " picks herself up and grips her blade.  This time she's a little more cautious, approaching slowly, pausing just out of reach.  You hide a grin and bring your own sword up, the tips of your blades nearly touching.  \"<i>Good.  No need to be reckless, kiddo.  Don't just charge in at the first opportunity; you'll get yourself killed.</i>\"");
	
	outputText("\n\n\"<i>Get " + player.mf("him","her") + ", " + flags[kFLAGS.HELSPAWN_NAME] + "!</i>\" Hel calls from the sidelines, sipping on a mug.  \"<i>Show " + player.mf("him","her") + " what a salamander can do!</i>\"");
	
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("\n\nYour");
	else outputText("\n\nHer");
	outputText(" daughter braces herself, drawing a breath just a second before she launches her attack, giving herself away.  You parry three quick blows, stepping back as " + flags[kFLAGS.HELSPAWN_NAME] + " leaps into another overhand strike.  You dodge, spinning out of the attack and slicing her right across her bare belly.");
	
	outputText("\n\n\"<i>Gah!</i>\" she cries, stumbling to her knees.  \"<i>I-I can't...</i>\"");
	
	outputText("\n\nYou pull " + flags[kFLAGS.HELSPAWN_NAME] + " to her feet and ruffle her hair.  \"<i>C'mon kiddo, don't give up.  Here,</i>\" you say, grabbing a dinner plate and some leather straps from your kit.  In a moment, you've got a rudimentary shield cobbled together.  You fit it over the young salamander's free arm and give her a few pointers on stance.  Nervously, she brings her makeshift shield to bear against you, fidgeting under the heft of it as you make a few slow, easy to parry swings for her to get used to it.  Steadily you pick up the pace, swinging your training sword faster and harder, forcing " + flags[kFLAGS.HELSPAWN_NAME] + " to parry and block, retreating against your onslaught.  You keep it up for a full minute before relenting, letting the kid seize the initiative.  She swings at you, rolling with each parry you make, cleaving into another swing, turning your ripostes aside with her shield and forcing you back.");
	outputText("\n\nYou wince in pain as " + flags[kFLAGS.HELSPAWN_NAME] + " manages to nick you, turning one of your blows aside with her shield and striking through the opening left in your guard.  \"<i>Alright, alright,</i>\" you laugh, rubbing your shoulder.  \"<i>Good job, " + flags[kFLAGS.HELSPAWN_NAME] + ". You're getting the hang of that shield!</i>\"");
	
	outputText("\n\n\"<i>Thanks, " + championRef() + "!</i>\" the little salamander grins, hugging you.");
	
	outputText("\n\n\"<i>Alright, alright,</i>\" Hel says, grabbing the dummy sword from your hand.  \"<i>Now it's time to fight a REAL warrior, " + flags[kFLAGS.HELSPAWN_NAME] + ". Come get some!</i>\"");
	
	outputText("\n\nIt's several hours long before the three of you quit: time spent drilling " + flags[kFLAGS.HELSPAWN_NAME] + " on stance and parrying, trading off with Helia every few rounds to keep ");
	if (flags[kFLAGS.HELSPAWN_DADDY] != 0) outputText("her");
	else outputText("your");
	outputText(" daughter on her toes.  She learns quickly, though, and soon she hardly needs reminding to keep her shield up and stance braced against Helia's overwhelming assaults.");
	
	outputText("\n\nA few hours like this every night, and ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your ");
	else outputText("Hel's ");
	outputText("daughter will be a warrior worthy of her parent");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("s");
	outputText(".");
	//{HelSpawnChaste +10}
	flags[kFLAGS.HELSPAWN_PERSONALITY] -= 10;
	doNext(camp.returnToCampUseOneHour);
}

//Berzerker (Das Barbarimander)
//{if PC has 200 gems}
private function dasBarbarimander():void {
	clearOutput();
	spriteSelect(68);
	flags[kFLAGS.HELSPAWN_WEAPON] = "scimitar";
	if (player.gems >= 200) {
		outputText("You sigh and dig out a handful of gems.  Helia beams at you, planting a quick kiss on your cheek before grabbing " + flags[kFLAGS.HELSPAWN_NAME] + " and the loot.  \"<i>Thanks for the loan, lover mine.  C'mon, sweetie, we're going for a trip to town.</i>\"");
		outputText("\n\n\"<i>Awesome!</i>\" the little 'mander grins, following along after her mother.");
		player.gems -= 200;
	}
	//{if PC is po' as fuck}
	else {
		outputText("\n\nYou turn out your pockets, telling Hel you're about a broke as she is.  The salamander groans, dramatically putting a hand to her brow in mock shame, \"<i>Woe is me, forced to turn tricks in a dark alley to provide for my child!</i>\"");
		outputText("\n\nA moment passes in silence.  \"<i>Bad taste, huh?  Guess I'll just go kick some minotaurs' shit in.  C'mon, sweetie, we're going hunting!</i>\"");
		outputText("\n\n\"<i>Awesome!</i>\" the little 'mander grins, following along after her mother.");
		outputText("\n\nYou can't imagine how that could end badly.");
		//{HelSpawnSlutty +10}
		flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
	}
	doNext(camp.returnToCampUseOneHour);
}
		
//Event: Helspawn's a Little Slut Like Mommy
//{Play at night, while sleeping.}
public function helspawnIsASlut():void {
	if (prison.inPrison) { //No choices for you in prison!
		prison.prisonLetter.noControlOverHelspawn();
		return;
	}
	spriteSelect(68);
	flags[kFLAGS.HELSPAWN_FUCK_INTERRUPTUS] = 1;
	outputText("\nSomething's moving in your camp.");
	
	outputText("\n\nYour eyes flicker open as a scaled foot moves past your face, hushed breathing barely concealing a giggle.  Another foot, this time a shimmering blue-black, moves past.  You ");
	if (player.weaponName != "fists") outputText("clutch your [weapon]");
	else outputText("ball your fists");
	outputText(" as the intruder passes by, ready to defend yourself and your loved ones.  The moment they're out of reach, you roll onto your [feet], looking around for signs of a massed demon attack.  Instead, you see the outline of " + flags[kFLAGS.HELSPAWN_NAME] + " in the dying embers of the fire light, leading what looks like a spider girl by the hand toward her bed.");
	
	outputText("\n\nYou creep closer, trying to get a closer look at what your ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
	else outputText("ward ");
	outputText("is doing.  Well, it doesn't take a genius to figure that out, really, but still, you have to be sure.  You slide right up to them, just out of their lines of sight, as " + flags[kFLAGS.HELSPAWN_NAME] + " turns around, letting the spider-kin unclasp her bra and grab her tits, squeezing the small mounds as " + flags[kFLAGS.HELSPAWN_NAME] + " suppresses a moan, reaching back to slip a hand into the spider's crotch, grabbing her - his dick.");
	
	outputText("\n\nWell then. You suppose you ought to go stop " + flags[kFLAGS.HELSPAWN_NAME] + " from making a whore of herself... but then again, she's old enough to make her own mistakes by now.");
	if (player.cor >= 50) outputText("  And by mistake you clearly mean old enough to get her ass fucked in by a cute little spider trap... you contemplate jumping in on it, but with a sigh figure it's " + flags[kFLAGS.HELSPAWN_NAME] + "'s catch.  Let her enjoy it.");
	menu();
	addButton(0,"Stop Them",helSpawnStopFucking);
	addButton(1,"Do Nothing",helspawnDoNothing);
}

//Do Nothing
private function helspawnDoNothing():void {
	clearOutput();
	spriteSelect(68);
	outputText("You turn around and head back to your bed.  As soon as you're under your blanket, your ears are assaulted with the quiet moans and grunts of pleasure coming from " + flags[kFLAGS.HELSPAWN_NAME] + "'s bed as she and her first little boyfriend get it on.  You can practically hear the tail-pegging from here.  How cute!");
	//{HelspawnSlutty +10}
	flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
	doNext(playerMenu);
}

//Stop Them
private function helSpawnStopFucking():void {
	clearOutput();
	spriteSelect(68);
	outputText("You sigh and step out of the shadows, grabbing the feminine little spider boy by the shoulder and yanking him away from " + flags[kFLAGS.HELSPAWN_NAME] + ".  \"<i>And just what the hell do you two think you're doing?</i>\" you yell, scowling ");
	if (player.tallness >= 90) outputText("up ");
	else if (player.tallness <= 72) outputText("down ");
	outputText("at your ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
	else outputText("ward ");
	outputText(". " + flags[kFLAGS.HELSPAWN_NAME] + " gives a shrill cry of surprise and tumbles away from you, trying to cover herself as best she can; the spider trap squirms in your unrelenting grasp, one set of arms covering his rapidly-wilting erection as the other flails around, trying to get you off of him.  Not happening.");
	
	outputText("\n\n\"<i>You!</i>\" you say, pointing an accusing finger at " + flags[kFLAGS.HELSPAWN_NAME] + ".  \"<i>What the hell, kid?  Who the fuck is this?</i>\"");
	
	outputText("\n\n\"<i>That's, uh.... Alex, meet ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("my dad");
	else outputText("[name]");
	outputText(". " + championRef() + ", Alex.</i>\"");
	
	outputText("\n\n\"<i>H-hi.</i>\" the spider mumbles, his voice high and adorably girly.");
	
	outputText("\n\n\"<i>And you!  You leave my girl alone, you hear me?  Leave.  Her.  ALONE!</i>\"");
	
	outputText("\n\n\"<i>B-but I...</i>\"");
	
	outputText("\n\n\"<i>" + championRef() + "...</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " groans as you grab the spider boy and toss him out of camp, watching with hawk-like eyes as he slinks back to his jungle.  When he's gone, you sigh and walk over to " + flags[kFLAGS.HELSPAWN_NAME] + ", wiping a tear from her cheek.  Putting an arm around her shoulder, you give her a long, long talk about not being a whore.");
	
	outputText("\n\n\"<i>B-but mom...</i>\"");
	
	outputText("\n\n\"<i>That's why you </i>shouldn't<i> be bringing men home.  Or women.  Or anything else, kiddo.");
	//If No Hel Love:
	if (flags[kFLAGS.HEL_LOVE] != 0) outputText("  You don't want to be a whore like your mother, do you?  The girl that everyone's had a ride with.");
	//if HelLove:
	if (flags[kFLAGS.HEL_LOVE] == 1) outputText("  I'm not going to a raise a whore, " + flags[kFLAGS.HELSPAWN_NAME] + ".  Your mother's made mistakes, sure, but...</i>\" you sigh.  \"<i>");
	outputText("  You don't have to be that person, " + flags[kFLAGS.HELSPAWN_NAME] + ".  Don't just give yourself out to the first person that asks, you know?  Save it for someone you really care about.  Trust me, it'll be worth it.</i>\"");
	outputText("\n\nYou spend a bit more time with the chastened, and hopefully now more chaste, salamander girl before putting her to bed.  Stroking her hair, you slip back to your own bunk, hoping she'll take what you've said to heart.");
	//{HelspawnChaste +10}
	flags[kFLAGS.HELSPAWN_PERSONALITY] -= 10;
	doNext(camp.returnToCampUseOneHour);
}

//Capstone Event: Helspawn's All Grown Up
//{Play the morning after Event 3}
public function helspawnAllGrownUp():void {
	clearOutput();
	spriteSelect(68);
	outputText("You wake up the next morning, and soon find your eyes drawn to where " + flags[kFLAGS.HELSPAWN_NAME] + " lies, barely an arm's reach from her mother's hammock, still snoring peacefully.  You sigh wistfully as you get up and get dressed, still thinking of the night before and your girl's little misadventure with the spider.  God, she's grown up fast.  Faster than you could have imagined - or her mother, for that matter.  Helia, too, is still reeling from her daughter's rapid, mutagenic growth.  But there's nothing to be done about that, now, and it seems she's reached what passes for adulthood in this strange world.  She's had the body of a woman for some time now, and it seems the mind and desires of one as well.");
	
	outputText("\n\nA part of you is sad to see her all grown up, and now you know it's time to treat your ");
	
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
	else outputText("ward ");
	outputText("like a woman.  The time to raise her, to shape her development, is over.  You can only hope you've done a good enough job to keep her safe in this hellish world; to give her sound judgment and the abilities she'll need to protect herself in the years and adventures to come.");
	
	outputText("\n\n<b>" + flags[kFLAGS.HELSPAWN_NAME] + " has been added to the Followers menu!</b>");
	flags[kFLAGS.HELSPAWN_AGE] = 3;
	flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] = 0;
	doNext(camp.returnToCampUseOneHour);
}


//Helspawn’s Main Menu @ Camp [Followers Tab]
public function helspawnsMainMenu():void {
	clearOutput();
	outputText("You call " + flags[kFLAGS.HELSPAWN_NAME] + " over to you and she comes running, ");
	if (player.tallness <= 72) outputText("grabbing you off your [feet] and clutching you in a tight hug");
	else outputText("throwing her arms around you and hugging you tightly");
	outputText(".  Laughing despite yourself, you ruffle her fiery hair and ask her if she’s got a minute.");
	
	outputText("\n\n\"<i>Sure, " + championRef() + "!  What’s up?</i>\"");
	menu();
	//Display Options:
	//[Hug]
	addButton(0,"Hug",hugHelspawn);
	//[Talk]
	addButton(1,"Talk",talkToHelspawn);
	//[Spar]
	addButton(2,"Spar",sparHelspawn);
	//[Sex] {?}
	//[Appearance]
	addButton(8,"Appearance",helSpawnsAppearanceScreen);
	addButton(14,"Back",camp.campFollowers);
}

//Hug
private function hugHelspawn():void {
	clearOutput();
	//{if PC is less than 6' tall:}
	if (player.tallness <= 72) {
		outputText("You reach up and pull " + flags[kFLAGS.HELSPAWN_NAME] + " down to your level, wrapping your arms tight around her slender shoulders.  Grinning from ear to ear, the towering girl squeezes you right back, her powerful muscles just about crushing your smaller body.  Her tail slips around your [hips], the warm leather binding you to your beloved ");
		if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
		else outputText("ward ");
		outputText("as she nuzzles up against you.");
		
		outputText("\n\n\"<i>Love you too, " + championRef() + ",</i>\" she laughs, planting a quick kiss on your cheek before letting you go.");
	}
	//{If PC is 6' or taller:}
	else {
		outputText("You grab " + flags[kFLAGS.HELSPAWN_NAME] + " and pull her into a tight hug.  She lets out a girlish giggle as she falls into your arms and squeezes you right back.  Her powerful arms threaten to crush your bigger body, smothering you in affection.  Her tail slips around your [leg], the warm leather binding you to your beloved ");
		if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
		else outputText("ward ");
		outputText(" as she nuzzles into your [chest].");
		
		outputText("\n\n\"<i>Love you too, " + championRef() + ",</i>\" she laughs, planting a quick kiss on your cheek before letting you go.");
	}
	doNext(camp.returnToCampUseOneHour);
}

//Talk
private function talkToHelspawn():void {
	//{Note: Talk 1 displays first and only once, followed by a random selection from the other scenes. Most of Helspawn's talk scenes involve other characters from camp, since after all, it takes a village!}
	clearOutput();
	var temp:int = rand(5);
	//Talk 1
	if (flags[kFLAGS.HAD_FIRST_HELSPAWN_TALK] == 0) {
		flags[kFLAGS.HAD_FIRST_HELSPAWN_TALK]++;
		outputText("You sit down with " + flags[kFLAGS.HELSPAWN_NAME] + ", telling her you need to talk.  Specifically, about her nocturnal misadventures.  She gulps, but you reassure her with a pat on the back, telling her it's all right.  She's a grown woman, now, as frightening as that is - for her and her mother both, it seems.  But she's an adult now, with the needs and cunning and abilities of one.  She can fight, drink, and she can fuck.  She's not a child anymore, even if she'll always be your kid at heart.");
		outputText("\n\nShe smiles.  \"<i>Sorry for bringing my friend home uninvited.  I just... didn't want to upset you. I love you, " + championRef() + ",</i>\" she says, resting her head on your shoulder, tail slipping around your waist.  You smile, holding the young 'mander girl - no, woman - close.  You tell her that you love her too, and that you're worried about her bringing random monsters home.");
		//{if Sluttymander:
		if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) outputText("  Even if she wants to be just like mom, she shouldn't be bringing monsters home.  Some of them may be dangerous, and she's not a warrior quite like you and Helia yet.");
		else outputText("  She should know better than to bring monsters back.  She's not her mother; lust doesn't have to dominate her life like that.");
		
		outputText("\n\nPerhaps you could learn more about this spider boy of hers.  He actually had a name, and seemed to be fairly civil.  Lucky break for her.  Then again, you could tell her to just save herself and stop trying to fuck things altogether.  ");
		if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("Of course, as her father, you could always say it's your duty to keep her happy...");
		else outputText("Of course, as her adoptive father, you could always say that you love her in a different, more intimate way.");
		outputText("  She wouldn't need monsters with you around.");
		menu();
		addButton(0,"Stop Fucking",dontFuckAlex);
		addButton(1,"Her Boyfriend",helSpawnBoyfriend);
		addButton(2,"Incest",incestWithHelspawn);
		//if (silly() && flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) addButton(3, "Both", whyNotBoth, null, null, null, "Why don't we have both?")
	}
	//Talk 2
	//{Kiha must be at camp}
	else if (temp <= 0 && followerKiha()) {
		outputText("\"<i>Oh hey, " + championRef() + "!  You gotta come see what I was making!</i>\"");
		outputText("\n\nShe grabs you by the [armor], pulling you back toward where she had been standing, near the center of camp.  A large cast-iron cauldron’s sitting on your firepit, full of a dark-green substance that’s bubbling along.  Your dusky dragoness lover, Kiha, is sitting on the edge of the pot, apparently immune to the scalding heat, a long wooden ladle grasped between her dexterous claws.  She grins up at you as you and your daughter wander over.  \"<i>Hey, Doofus, come for an early taste?</i>\"");
		outputText("\n\n\"<i>C'mon, " + championRef() + ", try it!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " adds happily.  \"<i>It's aunt Kiha's favorite recipe.</i>\"");
		
		outputText("\n\n\"<i>And it'll be YOUR favorite too, mini-doofus, just you wait,</i>\" the dragoness laughs, her foot making another slow, steady circuit around the pot, stirring the ingredients.  Grinning at you, Kiha lifts her landle up, letting you take it from between her toes.  The powerful reek of whatever it is they’re trying to cook almost overwhelms you when you bring it up to your lips, nearly staggering you.  By Marae, what did Kiha <i>put</i> in this?  Raw ass?");
		//[Oh God EW] [Um, yum?]
		menu();
		addButton(0,"Oh God Ew",ohGodEwKihaAndHelspawnSuckAtCooking);
		addButton(1,"Um, Yum?",umYum);
	}
	//Talk 3
	//{Needs Rath at camp]
	else if (temp <= 1 && player.findStatusEffect(StatusEffects.CampRathazul) >= 0) {
		outputText("\"<i>" + flags[kFLAGS.HELSPAWN_NAME] + "!</i>\" you hear a ragged old voice call, \"<i>Get back here this instant!  I'm not done with you yet!</i>\"");
		
		outputText("\n\n\"<i>Coming!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " calls back as Rathazul shuffles into view, waving around what looks like a tiny hammer.  Whispering, " + flags[kFLAGS.HELSPAWN_NAME] + " says, \"<i>Could you come with me, " + championRef() + "? Rathazul weirds me out.</i>\"");
		
		outputText("\n\nChuckling, you nod and follow " + flags[kFLAGS.HELSPAWN_NAME] + " as she returns to Rath's makeshift laboratory and seats herself on one of his tables.  Grumbling about kids, the old rat proceeds to rap his little hammer on her knee - nearly getting kicked in the face for his trouble - before asking her to hold her breath as he listens to her heartbeat.  She's nearly blue in the face before he nods approvingly and tells her she can go. " + flags[kFLAGS.HELSPAWN_NAME] + " goes running, happy to get away as Rath turns to you, shaking his head.");
		
		outputText("\n\n\"<i>Just checking up on her, [name].  Her meteoric growth is of some concern - and scientific interest, I might add, if I could determine what caused it.  If I could mass-produce it.  ");
		if ((amilyScene.amilyFollower() && !amilyScene.amilyCorrupt())) outputText("Little Amily's solution was makeshift at best, and the children are beyond my reach to study.  Still.  ");
		outputText("Imagine whole legions of children reared and raised in the time it takes a goblin to do the same. We might have a fighting chance for once, with numbers to match the demons.</i>\"");
		
		outputText("\n\n\"<i>But I suppose that's still out of reach, [name].  She's finished growing, and there's no sign of the exact chemical needed to synthesize the compound.  I'll keep checking up on her for health, though perhaps one day I'll find the means to make accelerated growth safe and widespread.  An old man can hope, yes?</i>\"");
		doNext(camp.returnToCampUseOneHour);		
	}
	//Talk 4
	//{Bath Slut w/ DD or HHH must be at camp}
	else if (temp <= 2 && milkSlave() && flags[kFLAGS.MILK_SIZE] > 0) {
		outputText("\"<i>Hey, have you seen " + flags[kFLAGS.MILK_NAME] + " around anywhere, " + championRef() + "?</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " asks, looking around the camp.  \"<i>Mom asked me to milk her, but I haven't seen her around.  She wouldn't have run off, would she?</i>\"");
		if (flags[kFLAGS.MILK_SIZE] == 1) outputText("\n\nYou tell her it'd be more of a wobble, but");
		else outputText("\n\nYou doubt she would have; " + flags[kFLAGS.MILK_NAME] + " seems to have a fancy for you, but");
		outputText(" it wouldn't hurt to check around.  She does tend to wander into the traps around camp from time to time.  Offering " + flags[kFLAGS.HELSPAWN_NAME] + " your hand, you start searching the camp for your missing milk maid.  The two of you make a circuit around camp, checking the traps and behind various rocks and hollows, to no avail.  Finally, as you're starting to get worried about the dusky maid, you happen to look into the steel pool in her part of camp.  Sure enough, you spy " + flags[kFLAGS.MILK_NAME] + " curled up at the bottom of the pool, cuddled up with a ragged blanket to catch a quick nap.");
		outputText("\n\n\"<i>Aww,</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " grins, looking down at the napping " + flags[kFLAGS.MILK_NAME] + ".  \"<i>Guess I can milk her later, then.</i>\"");
		menu();
		addButton(0,"MilkHerLater",	helSpawnSureMilkHerLater);
		addButton(1,"MilkHerNow",helSpawnMilkHerNow);
	}
	//Talk 5
	//{Isabella must be at camp}
	else if (temp <= 3 && isabellaFollower()) {
		outputText("\"<i>Oh hey, " + championRef() + "!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says, suddenly grinning, \"<i>Mom bought me a new guitar in town.  Wanna come listen?</i>\"");
		
		outputText("\n\n\"<i>Sure, kiddo,</i>\" you say, absently wondering how she plays a guitar with those giant claws of hers as she leads you back to her and Helia's part of camp, where she quickly produces a dinged up guitar.  Looks like Hel's been visiting the pawn shop, but hey, " + flags[kFLAGS.HELSPAWN_NAME] + " doesn't seem to mind.  She hops up onto a nearby rock and gives the instrument a few experimental strums, pausing to adjust the tuning or fix a string that snaps a little too easily.  But after a moment of preparation, she's ready.");
		
		outputText("\n\nA soft, melodic tune starts to play as " + flags[kFLAGS.HELSPAWN_NAME] + "'s dexterous fingers dance across the fret, plucking at the strings with some small hesitation.  She's a beginner, but not bad at all; the simple tune is sweet and she plays it with burgeoning proficiency, slowly settling into the rhythm of the piece until you can close your eyes and relax, letting her playing sooth you, carrying your troubles far away.  You barely notice when a high, soft voice adds itself to the guitar, a lilting, haunting soprano that slowly grows in power as the young 'mander's playing intensifies, building toward crescendo.  She's singing, surely, but the words are alien and unknowable; you think, for a moment, that perhaps they're in Helia's native tongue, but when a second voice, powerful and operatic, joins " + flags[kFLAGS.HELSPAWN_NAME] + "'s, you know who's been teaching her.");
		
		outputText("\n\nYou open an eye as Isabella approaches, belting out a misty-eyed verse in her strange language, and you can practically feel her homesickness, her separation from a lifetime of friends and loved ones.  As her arms cross under her enormous breasts, you can't help but think of the mutations she has undergone");
		if (player.race() != "human") outputText(" and you yourself have suffered as well");
		outputText(".  You smile as Isabella seats herself beside " + flags[kFLAGS.HELSPAWN_NAME] + ", joining their voices together for the final chorus that leaves them both shaking as " + flags[kFLAGS.HELSPAWN_NAME] + " strums the last, desperate notes, nearly clawing through the strings in her passion.");
		
		outputText("\"<i>");
		if (!isabellaAccent()) outputText("Sehr gut");
		else outputText("Very good");
		outputText(" little " + flags[kFLAGS.HELSPAWN_NAME] + ",</i>\" Isabella says, pulling the young 'mander into a great big hug that threatens to smother her betwixt the cowgirl's massive bosoms.  Grinning, you congratulate " + flags[kFLAGS.HELSPAWN_NAME] + " on her performance, showering your girl in praise before you depart, leaving her to Isabella's instruction.  As you walk away, you can't help but notice Helia standing a short ways off, rubbing her eyes.");
		
		outputText("\n\nWhen you approach, your lover smiles at you, saying, \"<i>I always wanted to be a bard when I was a little girl.  I'm... I'm glad " + flags[kFLAGS.HELSPAWN_NAME] + "'s getting the chance, at least.</i>\"");
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("Unfortunately, there doesn't seem to be anything in particular to talk about at the moment.  The two of you spend the time in companionable quiet, making smalltalk.");
		doNext(camp.returnToCampUseOneHour);
	}
}

//Boyfriend
private function helSpawnBoyfriend():void {
	clearOutput();
	outputText("\"<i>So tell me about this spider boy.</i>\"");
	outputText("\n\n\"<i>Alex?</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " asks, brightening up.  \"<i>I met him on the way to Tel'Adre.  Mom was stopping to, uh, take care of a few stray witches, and I ended up wandering off...</i>\" she says, launching into the tale of her meeting the effeminate spider boy, and the whirlwind romance that brought them giggling back to camp in the middle of the night.  It's typical teen talk, but then, you're not much older than she seems, now, and you remember the days at home when you could have done the same.  You grin as she recounts her first kiss, and note the bright blush on her cheek.");
	
	outputText("\n\nMaybe she ought to keep seeing this boy after all...");
	doNext(camp.returnToCampUseOneHour);
}


//StopFucking
private function dontFuckAlex():void {
	clearOutput();
	outputText("Stroking " + flags[kFLAGS.HELSPAWN_NAME] + "'s hair, you try to tell her that there's a better way, that she doesn't have to just fuck everything she comes across.  Her mother's that way, sure, but she could do so much better, so much more with herself than giving in to constant lust.");
	//{If Sluttymander:}
	if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) {
		outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " scoffs, shaking her head.  \"<i>But I </i>like<i> mom's way.  I love jilling off, the feeling of my cunt getting stretched and my ass being torn apart by the big toys I buy in town.  That's who I am, " + championRef() + ".  I'm like mom, and I don't think... no, I know I don't want to change.  I love sex, even if you stopped me and Alex from it.  I want to feel a gang of minotaurs raping me, I want to jump on a drider's cock and ride him down.  I want to do the things I heard mom doing, and that's just what I'm going to do. I'm sorry.</i>\"");
		
		outputText("\n\nYou try to say something, but " + flags[kFLAGS.HELSPAWN_NAME] + " steps away, calling back, \"<i>I love you, " + championRef() + ", but I can't be what you want me to be.  I'm going to be a slut like mom, and there's nothing you can do to stop me!  It's who I was born and raised to be.</i>\"");
		
		outputText("\n\nYou may have made a horrible mistake.");
	}
	//{If Chastemander:}
	else {
		outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " nods slowly, taking in your words.  \"<i>I... I know, " + championRef() + ".  I'm sorry I brought Alex home last night.  It won't happen again.  I don't... I love mother, but I don't want to be like her.  A whore.  She's a great woman, but the things she does... they disgust me.</i>\"");
		
		outputText("\n\nShe catches herself and sighs.  \"<i>I shouldn't say that.  I'm sorry, I know she tries.  She loves us, even if she has a strange way of showing it.  I'll do better in the future.  I promise.</i>\"");
	}
	doNext(camp.returnToCampUseOneHour);
}

//Incest / You & Me
private function incestWithHelspawn():void {
	clearOutput();
	outputText("You cup " + flags[kFLAGS.HELSPAWN_NAME] + "'s cheek, turning her to you... only to have her leap you, straddling your [legs] as her powerful arms wrap around your neck.  Her thin lips press hard to yours, slender tongue probing against yours as her svelte body presses against you.  You respond in kind, grabbing her big ass and squeezing, kneading the delicious curves as she starts to grind against you, breath hot and heavy on your " + player.skinFurScales() + ".  \"<i>I said I love you, " + championRef() + ",</i>\" she grins, so close you can practically feel the beat of her heart through her perky breasts.  \"<i>Glad to know you feel the same way.</i>\"");
	
	outputText("\n\nYou grin as the beautiful salamander strokes your cheek, and says, \"<i>You're a hell of a lot better than any femmy spider boy, " + championRef() + ".  I'm a lucky girl to have someone like you to raise me... and to love me.</i>\"");
	
	outputText("\n\nYou kiss her again and send her on her way with a sharp swat on the ass.  She gives it a sexy wiggle as she walks, winking back at you as she saunters off.");
	dynStats("lus", player.sens/10+5, "resisted", false);
	flags[kFLAGS.HELSPAWN_INCEST] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//[Oh God EW]
private function ohGodEwKihaAndHelspawnSuckAtCooking():void {
	clearOutput();
	outputText("You spew the stew onto the ground and grab a nearby waterskin, trying to flush the taste from your mouth.  Kiha and " + flags[kFLAGS.HELSPAWN_NAME] + " look on with horror as you wipe your mouth and begin to try and coherently explain just how god awful whatever that... STUFF... you just put in your mouth was.  Shock turns to anger before you’re halfway through admonishing the pair of scaly redheads.  Kiha scowls at you and snatches the ladle from you.");
	outputText("\n\n\"<i>Oh, what the fuck do you know anyway, you big ass!  It's perfectly fine, isn't it " + flags[kFLAGS.HELSPAWN_NAME] + "?</i>\" she growls, spooning up a mouthful of the stuff before you can stop her.  A heartbeat after she swallows, Kiha goes completely stiff; her eyes growing as wide as saucers as they water.  She collapses backwards, falling onto her back with a muted <i>THUD</i>.");
	
	outputText("\n\n\"<i>K-Kiha?</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " yelps, watching the dragoness collapse into a pile of limp scales and leather.  \"<i>Are you okay?  Is she okay, " + championRef() + "?</i>\"");
	
	outputText("\n\nLooking down at the clearly unconscious dragoness, you pick up the cauldron and dump it out onto the parched earth, watching the wasteland swallow the abominable concoction up - though even it seems hesitant to consume Kiha's cooking, as the cracks in the ground fill with the musky liquid, only slowly draining away into the dirt.");
	outputText("\n\n\"<i>Right,</i>\" you say, washing out the cauldron, \"<i>let me show you how it's really done, kiddo.  Pass me that spoon?</i>\"");
	
	outputText("\n\nYou and " + flags[kFLAGS.HELSPAWN_NAME] + " are soon working away, stirring up your own special blend of your rations and the spices she and Kiha gathered for the first attempt.  Once you've got the basics in, you step back and hand the ladle over, telling the young 'mander to go wild.  Grinning like a kid, she goes to work, mixing in a wild combination of ingredients.  The cauldron's full to bursting by the time she's done, and no sooner does she ladle out the first bowel of it than Kiha sits up, groaning.");
	
	outputText("\n\n\"<i>The fuck happened?</i>\" the dragoness hisses, rubbing her temple.  \"<i>Feel like I got hit with a hammer.</i>\"");
	
	outputText("\n\n\"<i>You, uh, fell off the edge, aunt Kiha.  And spilled all the stew.  Here, we remade it for you!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " lies, presenting \"aunt Kiha\" with a bowl full of an aromatic brown goop, full of carrots and spices floating atop it like boats on a placid lake.  At least it smells better.");
	
	outputText("\n\n\"<i>Hmm?</i>\" Kiha says, snatching the bowl.  \"<i>You didn't muck with this, did you doofus?</i>\" she asks, giving you an accusing glance.");
	
	outputText("\n\n\"<i>Of course not.  Just the way you'd have made it,</i>\" you lie, crossing a pair of fingers behind your back.");
	
	outputText("\n\nKiha gives you an incredulous look, but takes a tentative sip anyway.  Her eyes brighten as she takes a second, and then a third gulp, soon shoveling it in greedily.  \"<i>Told ya, doofus!</i>\" she gloats, putting down the empty bowl.  \"<i>Nothing beats aunt Kiha's special recipe!</i>\"");
	
	outputText("\n\nYou just shake your head and grab a bowl, sitting down with the scaly ladies as you enjoy your lunch, trying to ignore the little shit-eating grin " + flags[kFLAGS.HELSPAWN_NAME] + "'s sporting all the while.");
	player.refillHunger(25);
	doNext(camp.returnToCampUseOneHour);
}
private function umYum():void {
	clearOutput();
	outputText("Um, yum?");
	if (player.hunger > 25)
	{
		outputText("\n\nCringing, you set the offered bowl back down, squeaking out that it's delicious, thank you very much, but you have something to take care of right now; maybe you can have more later.  Kiha rolls her eyes and shoos you off before she and " + flags[kFLAGS.HELSPAWN_NAME] + " spoon out their lunch. \n\nAs you're wandering off looking for somewhere to hurl, ");
		player.refillHunger(5);
	}
	else
	{
		outputText("\n\nCringing, you are about to set the offered bowl back down but you are reminded by your growling stomach. You have no choice but to cover your nose and just gulp down the contents of the stew. ", false)
		player.refillHunger(25);
		outputText("\nYou feel a bit nauseous. That stew surely is strange.", false)
		if (rand(3) == 0)
		{
			//Player vomits. Poor player. Damages hunger by 15-25.
			outputText("\n\nGasp! You feel like you're going to throw up. You get up and rush behind the bushes. You suddenly bend over and spew the contents of your stomach from your mouth onto the ground. It takes a while but you eventually recover and you get up. ", false)
			player.takeDamage(player.maxHP() / 4);
			player.damageHunger(rand(10) + 15);
			dynStats("lib", -10);
			dynStats("lust", -100, "resisted", false);
		}
		outputText("You set the finished bowl down and ")
	}
	outputText("you hear the tell-tale groans and gagging of a pair of scaly ladies who've just realized what kind of abomination they've created.");
	
	outputText("\n\nMaybe you ought to start doing the cooking around here...");
	doNext(camp.returnToCampUseOneHour);
}

//Sure
private function helSpawnSureMilkHerLater():void {
	clearOutput();
	outputText("You chuckle, telling her to let the poor girl sleep.  There'll be plenty of milk later.");
	doNext(camp.returnToCampUseOneHour);
}

//Now
private function helSpawnMilkHerNow():void {
	clearOutput();
	outputText("\"<i>Oh, no.  You're not getting out of your chores that easy, kiddo.  In you go,</i>\" you say, giving her a little push toward the edge of the pool.");
	
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " gives a rebellious huff as she clambers down, slipping down to the bottom and giving " + flags[kFLAGS.MILK_NAME] + " a gentle nudge.  \"<i>C'mon, cutey, wake up.  Time to relieve some pressure.</i>\"");
	
	outputText("\n\nYawning powerfully, " + flags[kFLAGS.MILK_NAME] + " rises to her knees and rubs the sleep from her eyes");
	if (flags[kFLAGS.MILK_SIZE] == 2) outputText(", already working to unfasten her shift");
	outputText(".  \"<i>Suckle?</i>\" she asks, turning her full teats toward " + flags[kFLAGS.HELSPAWN_NAME] + ".");
	
	//If Sluttymander:
	if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) outputText("\n\n\"<i>Wouldn't have it any other way!</i>\" the salamander answers with an eager grin, easing herself into " + flags[kFLAGS.MILK_NAME] + "'s arms and wrapping her lips around one of her prominent teats. " + flags[kFLAGS.MILK_NAME] + " gives a pleasured little shudder as " + flags[kFLAGS.HELSPAWN_NAME] + " starts to suckle like a babe, drinking down the dusky maid's seemingly endless supply of milk.");
	
	//If Chastemander:
	else outputText("\n\n\"<i>Sorry, " + flags[kFLAGS.MILK_NAME] + ", you know I'm not really into that.  Just turn around and sit back, alright?</i>\"  With a sigh, " + flags[kFLAGS.MILK_NAME] + " does as she's asked, leaning back into " + flags[kFLAGS.HELSPAWN_NAME] + "'s arms as the young salamander goes to work, clawed fingers gently caressing her prominent nubs until a white flow springs fort, splashing her knees as the dusky maid gives a little gasp of pleasure.");
	
	outputText("\n\n<i>They seem to get on all right</i>, you think as you watch the pair of them.  It's nice to have someone else around to help keep " + flags[kFLAGS.MILK_NAME] + "'s production under control.  Poor thing just never stops lactating.");
	doNext(camp.returnToCampUseOneHour);
}

//Spar
private function sparHelspawn():void {
	clearOutput();
	outputText("You ask " + flags[kFLAGS.HELSPAWN_NAME] + " if she's up for some battle practice, and she answers with an eager nod as she grabs her weapon.");
	//If Sluttymander: 
	if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) outputText("\n\n\"<i>Ready to get your shit kicked in, old " + player.mf("man","lady") + "?</i>\" she grins, drawing her weapon.");
	else outputText("\n\n\"<i>Just go easy on me, okay?  I'm still new at this...</i>\" she says, stepping back as she draws her weapon.");
	startCombat(new Helspawn());
}




//PC Somehow Loses Despite Being Like Level 20+
// The irony is that you can't even get her till like, Level 20 because dungeon. And she's lower level but then Hel's lower level than HER which makes shit for sense. Fuck logic, get bitches.
internal function loseSparringToDaughter():void {
	//if Sluttymander:
	if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) {
		outputText("As you stumble back, ");
		if (player.lust >= player.maxLust()) outputText("succumbing to your own lusts");
		else outputText("unable to withstand her unending hail of attacks");
		outputText(", " + flags[kFLAGS.HELSPAWN_NAME] + " quickly sweeps your [legs] out from under you, dropping you right on your ass.  You collapse with a grunt, ");
		if (player.weaponName != "fists") outputText("weapon tumbling out of hand");
		else outputText("unable to even clench your fists anymore");
		outputText(", and a moment later " + flags[kFLAGS.HELSPAWN_NAME] + "'s on you, straddling you with her powerful legs, pushing you down into the dirt.");
		
		outputText("\n\n\"<i>Now, what shall I do with you, hmm?</i>\" she teases, licking her lips as she surveys her conquest.  \"<i>Mother always said it's bad form to let someone go with just an asskicking...</i>\"");
		
		outputText("\n\nShe can barely finish the sentence before you both break out snickering.  She gives you a rough punch on the shoulder and rolls off, flopping onto her back beside you.  \"<i>That was fun, " + championRef() + ".  Thanks for spending a little time with me.  No hard feelings?</i>\"");
		outputText("\n\nYou chuckle and stumble to your [feet], pausing to ruffle her hair and collect your gear.");
		outputText("\n\nDamn but they grow up fast.");
	}
	//Else If Chastemander:
	else {
		outputText("As you stumble back, ");
		if (player.lust >= player.maxLust()) outputText("succumbing to your own lusts");
		else outputText("unable to withstand her unending hail of attacks");
		outputText(", " + flags[kFLAGS.HELSPAWN_NAME] + " grabs your arm, catching you before you can fall.  \"<i>Easy there, " + championRef() + ", I got you,</i>\" she says, pulling you into a quick hug.");
		
		outputText("\n\n\"<i>You didn't go easy on me, did you?</i>\" she asks as you regain your balance.  When you shake your head, she beams, smiling from ear to ear. Prancing out of reach, she breaks down into a happy little dance, gloating over her victory over the mighty Champion.  You shake your head and ruffle her hair, reminding her not to get too full of herself.");
		outputText("\n\n\"<i>I wouldn't dream of it, " + championRef() + "!</i>\" she grins, planting a quick kiss on your cheek before you head off to ");
		if (player.HP < 1) outputText("recover from that ass kicking");
		else outputText("dunk your head");
		outputText(".");
	}
	combat.cleanupAfterCombat();
}

//PC kicks Helspawn's shit in, surprising nobody. 
internal function beatUpYourDaughter():void {
	clearOutput();
	//{If Sluttymander loses to lust (you monster)}:
	if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50 && monster.lust >= monster.eMaxLust()) {
		outputText("\"<i>N-no more...</i>\" the slutty little salamander moans, slumping down to the ground, arms wrapping around herself.  \"<i>Fuck, you're sexy... so horny...</i>\" she groans, hands slipping down to her soaked bikini bottom.");
		
		outputText("\n\nShaking your head, you give her a little push, flopping her onto her back.  She just lets out a little whimper and finally tears her panties away, giving her unrestricted access to her sodden box.  \"<i>Hey, d-don't just leave me like this,</i>\" she whines, but to no avail.");
		//If No Incest: 
		if (flags[kFLAGS.HELSPAWN_INCEST] == 0) outputText("  You wash your hands of the defeated slut and head back to camp, leaving her to work through her tension herself.");
		else {
			outputText("  You reach down and give your lovely, lusty daughter a pat on her expansive rear, telling her she'll always look her best with her ass in the air, begging for ");
			if (!player.hasCock()) outputText("sex");
			else outputText("your cock");
			outputText("... and that if she's lucky, you might tend to her when you've cooled off.");
		}
	}
	else {
		outputText(flags[kFLAGS.HELSPAWN_NAME] + " stumbles back, dropping her weapon and waving her arms, \"<i>I give, I give.</i>\"");
		outputText("\n\nWith an approving nod, you lower your [weapon], telling her she did a fine job.  Not many people can stand up to you for as long as she did, after all.  She grins a little, but winces when you try and get close");
		if (monster.HP < 1) outputText(", rubbing her many bruises");
		else outputText(", blushing brightly after your slutty display");
		outputText(".  You chuckle and ruffle her hair, \"<i>C'mon, kiddo, let's get some food in you.</i>\"");
		outputText("\n\n\"<i>Yeah, food,</i>\" she groans, stumbling after you as you both recover from the furious sparring match.");
	}
	combat.cleanupAfterCombat();
}

//BONUS SCENES!
//(Scenes are repeatable; small chance to play one at any given [appropriate] time. All require Adult Minimander.)
//Mai Visits Her Kid
//{Requires Helspawn be Mai's daughter; play when returning to camp:}
public function maiVisitsHerKids():void {
	clearOutput();
	spriteSelect(68);
	outputText("As you head back into camp, you notice Hel and " + flags[kFLAGS.HELSPAWN_NAME] + " are sitting around the cook fire in the center of camp, with your foster daughter balanced precariously on the lap of her own father, Mai the fox-girl.");
	
	outputText("\n\n\"<i>Heyya, lover mine, look who stopped in!</i>\" Hel calls, waving you over until you slip down beside her, a warm, leathery tail quickly wrapping around your waist.");
	
	outputText("\n\n\"<i>Hi, [name],</i>\" Mai says with a demure smile, arms wrapped around " + flags[kFLAGS.HELSPAWN_NAME] + "'s belly, trying to hold the daughter that's near a foot taller than she is.  Finally, laughing, she lets the young salamander go.  " + flags[kFLAGS.HELSPAWN_NAME] + " drops down to sit beside her mother and father, and quickly has both a smooth and scaly hand stroking her hair.");
	//If Chastemander:
	if (flags[kFLAGS.HELSPAWN_PERSONALITY] < 50) outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " happily leans her head against Mai's leg, accepting the affection with her tail swishing gaily behind her, foxy ears twitching as Mai brushes them.");
	else outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " leans back, pulling out a flask and taking a deep swill before passing it to her father, who takes it with a knowing smile and knocks it back like a champ.");
	
	outputText("\n\n\"<i>So what do you think, Mai?</i>\" Hel says, nodding down to her daughter.");
	
	outputText("\n\n\"<i>Yeah, we did good, Hel,</i>\" she says, leaning over to give the salamander a quick kiss.  \"<i>She's a real beauty... and knowing you, she's going to be a hell of a fighter some day.  You should bring her around to Tel'Adre some time.  We could use guards like her.</i>\"");
	
	outputText("\n\n\"<i>A salamander guard? That'll be the day!</i>\" Hel laughs, \"<i>they barely let Pop and Kiri in.  No, you're gonna have to walk it if you wanna see your little girl.</i>\"");
	
	outputText("\n\nMai gives a mock sigh.  \"<i>Well, we could always have another.  One for you, one for me!</i>\" she says, a little more serious this time - and with a less than subtle hint of lust in her voice.");
	
	outputText("\n\n\"<i>Oh, no,</i>\" Hel laughs, giving her lover a playful push, \"<i>this one's enough of a handful, aren't you?</i>\"");
	
	outputText("\n\n\"<i>Heeeeeyyyyyy,</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " whines, crossing her arms with a huff.");
	
	outputText("\n\nHer parents laugh, and Mai drops down to a knee beside her, reaching into a pocket to produce a small box.  \"<i>I know it's not much, but since I can't get out here often enough...</i>\" Mai says, opening it to produce a gold necklace adorned with a small gem clasp.");
	
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " lights up as Mai slips the gold chain around her daughter's neck.  \"<i>Something to remember me by when I'm not around,</i>\" she says with a wink, letting her kid skip off to find a mirror.");
	
	outputText("\n\n\"<i>And you, [name],</i>\" she says, turning to you, \"<i>Thanks for taking care of " + flags[kFLAGS.HELSPAWN_NAME] + ".  I-I mean, I know I was really making her for you and Hel anyway, but still... she's a good kid, and I love her anyway.  Keep her safe, alright?</i>\"");
	
	outputText("\n\nYou promise that you will, and with a quick nod, Mai runs after " + flags[kFLAGS.HELSPAWN_NAME] + " to say goodbye for the day.  As she leaves, Helia grins, holding you tight against her.  \"<i>She's a good girl, [name].  Couldn't have picked a better father for our girl.</i>\"");
	doNext(camp.returnToCampUseOneHour);
}

//Spider Bro's Gift
//{Requires Helspawn be fathered by a spiderbro. Play at morning.}
public function spiderBrosGift():void {
	clearOutput();
	spriteSelect(68);
	flags[kFLAGS.SPIDER_BRO_GIFT] = 1;
	outputText("As you're getting ready to head out for the day, you notice " + flags[kFLAGS.HELSPAWN_NAME] + " prancing around camp with a long, brightly-colored scarf wrapped around her neck, standing painfully in contrast with her midnight-black scales and pale flesh.");
	
	outputText("\n\n\"<i>Whatcha got there, kiddo?</i>\" you ask, walking over to the clearly quite pleased salamander.");
	
	outputText("\n\nShe grins, hugging the scarf to herself.  \"<i>I don't know, I woke up and there it was, right next to me.  I think mom bought it for me");
	//if Isabella: 
	if (isabellaFollower()) outputText(", or aunt Isabella might have knitted me a new one, I don't know");
	outputText(".</i>\"");
	
	outputText("\n\nYou shrug, but as she turns away, you grab the corner of the scarf and feel it.  Spider silk, if ever you've felt it.  A grin spreads across your face as you realize who must have made this.");
	
	outputText("\n\nThen you realize someone just walked into your camp and could have slaughtered you all.  You should probably fix that.");
	doNext(camp.returnToCampUseOneHour);
}



//Hakon and Kiri Come to Visit
//{Play as the PC returns to camp in the evening / late afternoon}
public function hakonAndKiriComeVisit():void {
	clearOutput();
	spriteSelect(68);
	flags[kFLAGS.HAKON_AND_KIRI_VISIT] = 1;
	outputText("As you're returning to camp, you notice Helia running around like a chicken with her head cut off, fussing about damn near everything in her part of the camp");
	if (camp.companionsCount() > 1) outputText(" and everyone else's too, much to their chagrin");
	outputText(". As she's furtively polishing off her giant still, trying to get the dingy old thing to shine, you approach and clear your throat. She gives a sharp yelp and spins around, but seems to relax as she sees it's just you.");
	outputText("\n\n\"<i>H-hey, [name],</i>\" she says nervously.  \"<i>Just in time.  I was about to go looking for you.  Uh, so...</i>\"");
	
	outputText("\n\n\"<i>What's going on?</i>\"");
	
	outputText("\n\n\"<i>Pop and Kiri are coming over, and this place is a wreck!  Like a fuckin' tornado just blew right through.</i>\"");
	
	outputText("\n\n\"<i>That's how it always looks, though,</i>\" you say with a shrug, indicating the field of debris surrounding Hel's hammock, most of which has just been pushed under her cloak.");
	
	outputText("\n\n\"<i>Well yeah, </i>I<i> like living in a dump, but it's my dad and sister, and I don't want them to think I live like a rutting animal, you know?</i>\"");
	
	outputText("\n\nYou consider protesting the point, but soon have a wash rag shoved into your hands before Hel dashes off to fix some other minor flaw in camp.  You sigh, but it never hurts to tidy up a bit anyway.  What you're supposed to do to an open camp with a cloth, though, you have no idea.  Mop the dirt?");
	
	outputText("\n\nIt hardly matters, as a few minutes later, you hear a cry of unabashed glee from the edge of camp, and turn to see " + flags[kFLAGS.HELSPAWN_NAME] + " running up to meet a pair of oncoming figures.  You wave as Hel's father swoops his granddaughter up into a great bear hug, hefting the half-breed 'mander off her feet in his powerful arms.  " + flags[kFLAGS.HELSPAWN_NAME] + " squeals with delight as she's practically carried into camp, until Hakon sets her down and hugs her mother, pulling Hel into a tight hug before she can finish saying hello.");
	
	outputText("\n\n\"<i>Hi, [name],</i>\" Kiri says, fluttering over to plant a peck on your cheek.  \"<i>Long time no see.</i>\"");
	
	outputText("\n\n\"<i>Too right.  Put 'er there, " + player.mf("son","girl") + ",</i>\" Hakon says, extending a hand to you, grinning wide as he lets his daughter and granddaughter go.  You shake the old salamander's hand, nearly wincing as his powerful grip throttles your wrist vigorously, practically walking you back into the heart of the camp.");
	
	outputText("\n\nTurning to " + flags[kFLAGS.HELSPAWN_NAME] + ", Hakon smiles with pride.  \"<i>Gods and demons, girl, you've grown!  What have you two been feeding her, huh?</i>\"");
	
	outputText("\n\n\"<i>And you should see how strong she is!</i>\" Hel grins.  \"<i>Go on, " + flags[kFLAGS.HELSPAWN_NAME] + ", show the old scales what you've got.</i>\"");
	
	outputText("\n\n\"<i>Old scales!?  I'll show you old, you little brat.  Come on, hit me!</i>\" Hakon says, just before " + flags[kFLAGS.HELSPAWN_NAME] + " punches him right in the chest, knocking him right on his ass.  He tumbles back with a grunt, shaking his head with a wry laugh.  \"<i>Ha!  Maybe these scales are getting old after all.  This one's gonna be a hell of a fighter, though.  Should take her hunting with us one of these days.  What do you say, kid?</i>\"");
	
	outputText("\n\n\"<i>Sure!  ");
	if (flags[kFLAGS.HELSPAWN_WEAPON] == "scimitar and shield") outputText(championRef() + "'s been teaching me how to fight.");
	else outputText("Mom's been teaching me how to fight.");
	outputText("  I'm not as good as mom and " + championRef() + " yet, but I'd love to come along.</i>\"");
	
	outputText("\n\n\"<i>That's the spirit.  Now we just have to convince your aunt Kiri to come along.  And ");
	if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your old man");
	else outputText("[name]");
	outputText(", too.</i>\"");
	
	outputText("\n\n\"<i>I-I don't like fighting.  Especially 'hunting.'  Those poor gnolls,</i>\" Kiri says, avoiding her father's gaze.");
	
	outputText("\n\n\"<i>Aww, you're no fun,</i>\" Hel teases, giving the half-harpy a light punch on the shoulder before turning to you.  \"<i>What do you say, lover mine?  Wanna go hunting with your three favorite salamanders some time?</i>\"");
	menu();
	addButton(0,"Sure",goHuntingBitches);
	addButton(1,"Maybe Not",noHuntingBitches);
}

//Sure!
//Eventually needed to get into Helia Expansion 5: The Valley of Fire
//lol like I'll ever actually get there
private function goHuntingBitches():void {
	clearOutput();
	spriteSelect(68);
	outputText("\"<i>Sure,</i>\" you say, quickly earning approving nods from Hakon and Helia.");
	outputText("\n\n\"<i>No mercy for gnolls!  Right, sweetheart?</i>\" Hel shouts, grabbing a mug of ale and lifting it in the air.");
	
	outputText("\n\n\"<i>R-right!</i>\"");
	
	outputText("\n\nWith that settled, you sit down as Hel passes out something that must be akin to dinner for her family - mostly booze and rations - and soon you're enjoying a meal with the rowdy family, laughing at Hel's ribald jokes or Hakon's old war stories.  Eventually, Hakon and Kiri leave, but not before promising to come and get you and the family for their next gnoll hunt.");
	doNext(camp.returnToCampUseOneHour);
}
//Maybe not
private function noHuntingBitches():void {
	clearOutput();
	spriteSelect(68);
	outputText("\"<i>I'll pass,</i>\" you say with a laugh, earning a shrug from the salamanders.");
	outputText("\n\n\"<i>Well, maybe you'll change your mind next time.  Plenty of evil furbags to go around!</i>\" Hel says with a laugh.  \"<i>C'mon, let's find something for the folks to eat, huh?</i>\"");
	
	outputText("\n\nWith that settled, you sit down as Hel passes out something that must be akin to dinner for her family - mostly booze and ration - and soon you're enjoying a meal with the rowdy family, laughing at Hel's ribald jokes or Hakon's old war stories.  Eventually, Hakon and Kiri leave, waving goodbye until the next time they can visit.");
	doNext(camp.returnToCampUseOneHour);
}


}
}
