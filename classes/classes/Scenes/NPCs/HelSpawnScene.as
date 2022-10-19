package classes.Scenes.NPCs{
import classes.*;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;

public class HelSpawnScene extends NPCAwareContent {
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
//const HELSPAWN_DAD_EVENT:int = 974;
//const HAKON_AND_KIRI_VISIT:int = 975;

//In this Expansion, Helia the Salamander, who’s spent much of her life alone until the brave Champion took her into his confidence, enters a stage in her life called The Pale Flame: whether she wants to admit it or not, her body’s ready for children; she’s found the person she truly wants to be with. She asks the Champion to father her child; if that is impossible, but desired (or the PC doesn’t want to be the daddy, but wants Hel to have kids anyway), she will offer to get Mai the Foxgirl to knock her up instead; if it is undesired at all, the PC can ask Hel to go on herbs, suppressing her fertility until the PC's ready. Hel will remain on herbs until the PC decides he’s ready.

//Setting " + championRef() + ":
	//It was really fucking hard to decide what this bitch is supposed to call you. So, here’s the dealio: If you’re a herm AND her mother, she calls you \"Mom;\" dude and her dad, she calls you \"Daddy;\" she’ll change between mom and daddy as the PC’s gender changes. If she was fathered by someone OTHER than the PC, she calls the PC by their name. Simple enough?

public static function incestEnabled():Boolean {
	return CoC_Settings.debugBuild; //load incest only for "debug" builds to avoid it popping up on the forum... maybe we should try the full ver too?
}

private function championRef():String {
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) return player.mf("Daddy","Mom");
	else return player.short;
}

override public function helspawnFollower():Boolean {
	return flags[kFLAGS.HELSPAWN_AGE] == 3;
}

override public function helPregnant():Boolean {
	return (helScene.pregnancy.isPregnant);
}

//Hel’s New Appearance Screen: Taking Things Into Account
internal function heliasAppearanceScreen():void {
	clearOutput();
	helScene.helSprite();
	outputText(images.showImage("monster-hel"));
	outputText("Hel the salamander stands seven feet tall, with pale skin and thick, bright-red scales covering her arms and legs, though she has a normal human torso and face.  A fiery tail swishes gaily behind her, blazing with a ");
	if(flags[kFLAGS.HEL_BONUS_POINTS] < 150) outputText("bright orange glow");
	else outputText("bright white glow");
	outputText(" that lets off a pleasant heat, though it never seems to burn you.  Hel is wearing her scale bikini and a leather thong, and using her scimitar as a weapon");
	//if Isabella is cool: 
	if(flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] >= 1) outputText("; she’s got her blue bandanna wrapped around her head, mostly obscured by her fiery hair");
	outputText(".  She has a human face, with bright red eyes, gentle, feminine features and a smattering of pale scales on her cheeks, like freckles.  Hel has long, bright-red hair bound in a pony-tail that hangs down her back.  She has wide-flared hips and a soft, squishy butt.  Her two reptilian legs are visibly adorned with scales and claws, ending in soft, leathery soles.");
	if (flags[kFLAGS.HELSPAWN_NAME] != 0) {
		outputText("  A dark trio of scars run down Hel’s thighs, left by " + flags[kFLAGS.HELSPAWN_NAME] + "’s youthful claws.");
	}
	else {
		switch (helScene.pregnancy.event) {
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

private function eyeColor():String {
	return flags[kFLAGS.HELSPAWN_DADDY] == 0 ? "golden" :
		flags[kFLAGS.HELSPAWN_DADDY] == 2 ? "bright green" :
			"crimson";
}

//" + flags[kFLAGS.HELSPAWN_NAME] + "’s Appearance Screen
private function helSpawnsAppearanceScreen():void {
	clearOutput();
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("Your ");
	else outputText("Hel’s ");
	outputText("salamander daughter, " + flags[kFLAGS.HELSPAWN_NAME] + ", stands about six-foot-six tall, with pale skin and thick, ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 1) outputText("chitin-black");
	else outputText("bright-red");
	outputText(" scales covering her arms and legs, though she has a normal human face and torso.  A long leathery tail swishes happily behind her, surrounded by a dim fiery aura that emits a pleasant heat, though thankfully it isn’t hot to the touch, seemingly incapable of harming you.  " + flags[kFLAGS.HELSPAWN_NAME] + " is wearing ");
	if(flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) outputText("a scale bikini, just like her mother’s");
	else outputText("a short skirt, thigh-high boots, and a sky-blue blouse, in stark contrast to her mother’s sluttier attire");
	if(flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] >= 1) outputText(", with a brightly-colored scarf wrapped around her neck");
	outputText(". She has a human face, with " + eyeColor() + " eyes, girlish features, and a smattering of pale red scales on her cheeks, like freckles.  Her short, dark-red hair cuts off just below her ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("puppy-dog");
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
	if (!recalling) flags[kFLAGS.HELIA_KIDS_CHAT] = 1;
	helScene.helSprite();
	outputText("\n<b>That night...</b>\n");
	outputText("Your sleep is disturbed by a gentle tugging on your [armor].  You groggily swat at whatever's nudging at you, groaning about the hour until your eyes finally open wide enough to recognize Helia kneeling over you, a deeply distraught look in her eyes.  \"<i>[name]? [name] wake up, I need to talk to you. Please?</i>\"");
	
	outputText("\n\nYou nod, rubbing the sleep out of your eyes as you stagger up onto your [feet].  You note that Hel's wrapped her old cloak tightly around herself, held closed so that nothing but her face is visible.  You start to ask what's up, but Hel shushes you, saying she needs to talk to you privately.  ");
	//{If Hel's the only one at camp: 
	if(camp.companionsCount() == 1) outputText("You cock an eyebrow, saying that you're already alone, but she shakes her head, saying she needs somewhere private, away from prying eyes.  ");
	outputText("You nod your assent, and let her help you up and lead you away from camp.  You follow Hel through the darkness, stumbling after her until you're hidden away beneath the old ruined wall a stone's throw from the perimeter.  Safely tucked away beneath the shadow of the wall, Hel takes your hands in hers and hesitantly, says, \"<i>Look, I don't... this isn't easy for me, okay?  But I have to tell you something, [name].  And it's important, alright?  To me, anyway. I wouldn't bring it up if I could deal with it myself, honest.  But I can't and... and I'm afraid, [name].</i>\"");
	
	outputText("\n\nYou squeeze Helia's hands and reassure her as best you can, saying she can tell you anything.  She looks away, blushing hotly; beneath her cloak, the radiant fire of her long tail shines brighter, casting a pale glow even through the heavy fabric.  You ask again what's wrong, and with a little coaxing, Hel looks up, her bright crimson eyes staring into yours.");
	
	outputText("\n\n\"<i>I don't just like you, [name] - I mean, I do.  Like you, I mean.  But it's... it's more than that, you know?  Sure, I've said the word, but I say 'love' to a lot of people, a lot of things.  I love your ");
	if(player.hasCock()) outputText(multiCockDescriptLight());
	if(player.hasVagina() && player.hasCock()) outputText(" and your [chest] and your [vagina]");
	if(!player.hasCock() && player.hasVagina()) outputText(" [vagina] and [chest]");
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
	helScene.helSprite();
	outputText("As much as you enjoy the sex, as much as you like Hel, you can't say you feel that way towards her.  You grasp her shoulders, telling her as gently as possible how you feel.  She nods slowly as you speak, rubbing at her eyes by the time you're finished.");
	outputText("\n\n\"<i>Well, thanks for being honest, [name].  I... I really do appreciate it.  But, maybe you can still help me with my problem.  I'll understand if not, but still, I have to ask: ");
	//[HelLove to NO]
	if (!recalling) flags[kFLAGS.HEL_LOVE] = -1;
	heliaLoveFollowup();
}

//Yes
private function yesHeliaILoveYourButtHoleReaming():void {
	clearOutput();
	helScene.helSprite();
	outputText("Smiling, you tell her yes.  The salamander cries out with joy, jumping into your arms and kissing you, squeezing you so tightly that you feel like you're about to black out by the time she breaks the kiss, stepping back with chest heaving.");
	outputText("\n\n\"<i>Wh-why didn't you tell me before, anyway?</i>\" she asks, nuzzling her cheek into your [chest].  \"<i>Could have saved me all this trouble.</i>\"");
	outputText("\n\nYou shrug, saying that you never really felt like you had the chance until now... and it's a lot cuter when she bumbles through a confession.  Helia gives you a gentle punch on the shoulder, but softens the blow with another series of kisses along your [chest] and neck, holding you close as the two of you revel in the newly-revealed love you share.  After a few minutes, though, Hel steps back and says, \"<i>I love you, [name], with all my heart.  You're the person I want to spend the rest of my life with, if you'll have me.  But I still have to tell you what's wrong. The reason I brought this all up: ");
	//[HelLove to YES]
	if (!recalling) flags[kFLAGS.HEL_LOVE] = 1;
	heliaLoveFollowup();
}

//Combine
private function heliaLoveFollowup():void {
	helScene.helSprite();
	outputText("You're not from here, so you probably don't know much about salamanders.  Basically, we're effectively infertile.  I can get filled with gallons of cum day in and day out, and chances are none of it will take inside me.  I've always thought I could slut around as much as I wanted, and I'd never have to worry about the consequences.  But... that's not forever, I guess.  When a salamander girl finds the person she wants to be with forever, ");
	//if PC is female/herm:
	if(player.hasVagina()) outputText("even another woman, it seems, ");
	outputText("we... change.</i>\"");
	
	outputText("\n\nHel reaches up and undoes the clasp on her cloak.  When it falls away, your eyes are drawn immediately to her tail - once burning with a blood-red hellfire, her leathery tail is now surrounded by a pale radiance, shimmering like white gold.  Your eyes widen, but Hel flinches back as you try to approach.  \"<i>It's called the Pale Flame, [name].  Just like it looks.  When a 'mander girl finds the person she wants to be with, our bodies change.  While I'm like this... I'm as fertile as a goblin, and... and I </i>want<i> to be.  I want... I need... a child, [name].  I want to be pumped full of cum until I'm bloated, to bear a little salamander for us to raise and love.  ");
	//If HelLove = No:
	if(flags[kFLAGS.HEL_LOVE] == -1) outputText("Even if you don't love me, you'd love our child, right?  You can fuck me full of kids, or even... even get someone else to, I don't care.  I just </i>need<i> it, [name].  More than anything else in the whole wide world.");
	else {
		outputText("I love you, [name].  I love you so much.  I want to share this with you.  ");
		if(player.hasCock()) outputText("You'll fuck me full of kids, right?  Please?  Give me your seed, [name].  Give it all to me until I'm fucking gravid with your salamander babies.");
		else outputText("Even if you can't fuck me full of babies... you could grow a dick!  There's plenty of things in this god-forsaken world that do that. O-or if you don't want to, I bet I can get one of the fox-girls, or a minotaur, or something.  You know I can find a dick somewhere, just say the word.");
	}
	outputText("  So what do you say, [name]?  Let's have a kid!</i>\"");
	menu();
	addButton(0,"Have A Kid",haveAKid)
		.disableIf(player.cockThatFits(helFollower.helCapacity()) < 0,
			"Unfortunately, you're too big to squeeze inside Helia to do the business yourself.  You might need to shrink down some.")
		.disableIf(!player.hasCock(), "And how exactly are you going to do this without a dick?!")
		.disableIf(player.isGargoyle(), "You're made of stone. You can't impregnate <b>anyone</b> anymore.");
	addButton(1,"Another Dad",getAnotherDad);
	addButton(2,"No Or Later",noKidsHel);
}

//[Have a Kid] (PC has a Dick)
public function haveAKid():void {
	var x1:int = player.cockThatFits(helFollower.helCapacity()) + 1;
	clearOutput();
	helScene.helSprite();
	if (!recalling) {
		outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
		helScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_SALAMANDER);
	}
	outputText("You tell Hel that you're in this with her, that you want to give her that child she seems so desperate for.  She beams at you, smiling from eye to eye before leaping into your arms, pressing her lips hard to yours.  You kiss her back, wrapping your arms around her hips to support her as her powerful legs wrap around your waist; you push her up against the ruined wall, hands searching across her taut, hot flesh until you toss her bikini top aside, letting her hefty tits free.  \"<i>Oh god yes,</i>\" she moans as you trail kisses from her lips, down her neck to her stiffening nipple.  \"<i>I want this so much, more than anything.  Give it to me, [name].  Don't hold back!</i>\"  Your fingers sink into her pliant flesh as you suckle on her exposed teat, groping her other tit and soft ass as she moans and squirms in your arms.  Clumsily, Hel's claws brush down your body, peeling off your [armor] until your [cock "+x1+"] flops into her lap.  She locks her scaled fingers around your manhood, roughly stroking you until you're stiff as diamonds in her grasp.");
	
	outputText("\n\nYou shudder as her fingers work your [cock "+x1+"], but don't let up on your end for a second.  You brush and knead Hel's nipple between your teeth, letting your hands drift down to her wide hips and gropable ass, slowly stripping her of her scale bottom and pulling it off her legs.  With your lover bare and naked, you slip down between her legs, letting her hook them over your shoulder to give you a good view of her dripping cunt.  Your tongue laps across her labia, drawing a long, lewd moan from Hel.  She runs her fingers through your [hair], urging you onward; at her lusty moans, you dig in, sucking on her prominent clit and drilling your tongue between her inner folds.  You gasp into her when Hel's lengthy tail wraps around your shoulders, the pale flame soothingly warm on your [skin] as her leathery appendage works its way down to the [cock "+x1+"] dangling between your [legs].  You groan with sudden need as the tip of her tail brushes your most sensitive flesh, tickling ");
	if(player.hasBalls()) outputText("your [balls]");
	else outputText("the base of your prick");
	outputText(" before coiling around the shaft with serpentine dexterity.  Her tail contracts and squeezes, undulating across your [cock "+x1+"] until it finally massages a thick blob of pre from your [cockhead], dribbling out to stain the wasteland ground.");
	
	outputText("\n\nSuddenly, Helia grabs your shoulders and shoves you down.  You flop onto your back, tail-encased prick standing straight up like a flagpole as Hel straddles your [hips], vigorously fingering herself as her tail lines your cock up with her drooling womanhood.  Your breath catches as your [cockhead] brushes her boiling juices, slickening your entry as she slides down your pole.  You grab Hel's flared hips, guiding her in as she envelopes your [cock "+x1+"] in the roiling inferno inside her.  Her tail unravels from around your throbbing shaft as she descends, tantalizingly slowly; she takes the better part of a minute before her groin is cozily joined to yours, her hungry maw kissing the very base of your lusty prick.");
	
	outputText("\n\nCompletely impaled on you, Hel's chest heaves with lust and need.  She cups one of the massive orbs, squeezing her pert nipples between a pair of crimson fingers as her other hand ");
	if(player.biggestTitSize() <= 2) outputText("supports her, pressing down on your [chest]");
	else outputText("gropes one of your tits, kneading your tender breasts under you squirm underneath her, unable to hold in your pleasured little gasps");
	outputText(".  Slowly, your salamander lover starts to grind her hips on your [cock "+x1+"], her muscles contracting and squeezing the rigid shaft inside her with every shift of her hips.  You both moan aloud, half-lost in a miasm of pleasure.  \"<i>God, I wish I could stay like this forever,</i>\"  Hel whispers, just on the edge of hearing.  \"<i>There's no one I'd rather be with, [name].  No one I'd rather have give me the child my body craves.</i>\"");
	
	outputText("\n\nSomething in Hel's voice gives you pause, but before you can think too much into it, she plants her hands firmly on your [chest] and starts to rise, dragging inch after inch of your prick out of her until only the [cockhead] is still inside her, smearing her lips with thick, creamy pre.  Then, grinning at you, Hel slams back down, taking you in one brutal thrust that leaves you both moaning; a moment later and she's riding your cock, bouncing on the rigid pole so fast that your combined juices go flying everywhere, drenching the barren earth around you.  Helia fucks you with reckless abandon, her voice edging higher and higher as she cries and moans.  Caressing your [chest], fondling herself, teasing your [asshole] with the tip of her tail, Hel seems to lose all restraint as she takes your cock again and again, devolving to her basest sexual instincts, rutting like an animal until you're sure you'll wake up bruised in the morning.");
	
	outputText("\n\nYou lay back and enjoy the rough fucking for several minutes, eventually taking her hands and holding them fast as she moves, locking your fingers with hers and pulling her down into a long, tongue-filled kiss.  The two of you stay like that for a long while, your breath hot on each others' skin as you wrap your arms around your lover's waist; to your surprise, Hel leans away from you, just long enough to pull off the tie on her ponytail, letting her rich red hair cascade down around you, veiling your faces as she kisses you again.  You run your fingers through her thick locks, breathing in the fiery smell of her, tasting her sweet lips on yours, feeling her innermost depths conforming around your breeding pole.  Holding Hel tight, you roll the pair of you over, landing with your cheek nestled in the cleft of her bosom.  She gasps as you run your tongue across the soft, succulent flesh of her tits, gently thrusting your [cock "+x1+"] into her.  Settling onto her back, Hel spreads her legs wide for you, letting you slip right in as her heels hook behind your [butt], her hands digging into your back to guide your movements.  Inside of five thrusts and she's moaning like a bitch in heat, writhing beneath you.  She claws at your back, making you wince - and spurt a mess of pre into her eager hole.");
	
	outputText("\n\nYou clench your teeth and start to piston into her, picking up the pace until your every thrust causes the lusty salamander to scream your name to the heavens.  Spurred on by Hel's ecstatic cries and her vice-like grip around your [cock "+x1+"], it isn't long before you can feel the mounting pressure of your inevitable release mounting furiously inside your [balls].");
	//If PC has lost Anal Virginity:
	if(player.ass.analLooseness > 0) outputText("\n\nBetween rough thrusts into your lover, you can feel her pale-glowing tail snake itself around your [legs], the slender little tip brushing between the cheeks of your [butt].  You can't help but gasp as it presses into your clenched backdoor, teasing your [asshole] with probing thrusts and flicks across the brim.  Helia grins up at you as your sphincter finally relaxes, letting the first inches slither inside, undulating through your anal passage.  \"<i>I'm going to milk every last fucking drop out of you,</i>\" she whispers huskily, breath hot on your neck. You moan in response as her ever-thickening appendage wriggles into you, penetrating you to the beat of your own [cock "+x1+"]'s thrusts into your lover's cunt.  Suddenly, a powerful burst of pleasure threatens to overwhelm you, demanding every ounce of your willpower to keep from cumming on the spot.  Hel coos encouragingly as you gasp, thrilled to have found your most sensitive place.  Now that's she's found it, Hel lets her tail go wild in your ass, tip battering against your prostate as the thicker trunk writhes and wiggles through your stretched hole.");
	
	outputText("\n\nYou give Hel a final few thrusts, doing your best to hold your orgasm back until the last minute.  But she never lets up, bucking her hips and squeezing your cock, urging you onwards until with an explosive roar you let loose, shooting your hot load into her hotter depths.  Hel throws her head back and screams, \"<i>GOD YES!  Give it to me, [name].  Don't you dare hold anything back!</i>\"  Indeed, you don't; your prick fires off one sticky wad of potent seed after the other, slathering her womb with cum until it drools out of her well-fucked pussy.  With a final, exhausted gasp, your throbbing prick lets out its last spurt, a final plug of salty spunk to fill her needy hole before you collapse atop your lover, panting into the valley of her cleavage as her arms and legs wrap around you, holding you tight while you deflate inside her.");
	
	outputText("\n\n\"<i>Oh, [name],</i>\" she moans, kissing you, \"<i>");
	if(player.pregnancyIncubation > 0) outputText("We're going to be mothers!");
	else outputText("You're going to be a father... and me a mother!");
	outputText(".</i>\"  You start to reply, when you're suddenly upended, landing back on your back with Helia atop you, fingers brushing along the cock buried twixt her legs.  \"<i>Oh, don't think you're getting away that easy, lover mine... my love.  I've gotta make sure your seed took, and that... that's going to take all night long.</i>\"");
	
	outputText("\n\nYou gulp, and wince as Hel starts to move atop your battered cock - and not for the last time this sleepless night!");
	if (!recalling) player.sexReward("vaginalFluids", "Dick");
	doNext(HaveAHellKidPartII);
}

private function HaveAHellKidPartII():void {
	var x1:int = player.cockThatFits(helFollower.helCapacity()) + 1;
	clearOutput();
	if (!recalling) camp.cheatSleepUntilMorning();
	outputText("With the last ounce of energy in your sixth - or is it seventh? - wind, you deliver a sharp crack across Helia's beet-red backside and roar out as another potent surge of seed rushes into her snow-white hole, still slick with the leavings of your last half-dozen discharges.  You grab her thick hips and slam your [cock "+x1+"] deep inside her as the last shot fills her womb a little bit fuller, the excess spurting out to wet the cum-stained ground beneath the salamander's knees.");
	
	outputText("\n\nThe sun's out by now, its radiant glow kissing your bare, sweat-slick flesh as you finally come to rest.  You lean back just enough to let your limp cock flop free of Hel's draining cunt, ushering out a deluge of salty seed that pools between her spread legs.  Without your prick to support her, Hel flops aside like a rag doll, chest heaving, still bearing the white marks of an errant orgasm.  She manages to smile up at you even as her fingers idly play across her swollen hole, knuckle-deep into the gallons of cum you've pumped into her over the course of the night.  Giving in to your exhaustion, you slip down beside your beloved, resting your chest on her shoulder.  Her arm wraps around you, holding you close as she plants a tender, loving kiss on your brow.");
	
	outputText("\n\n\"<i>That was... amazing.  God, it's like we were made for each other.  The way you move, the way you fill me and fuck me and caress me.  I'm... so glad I found you, [name].  It seems like a lifetime ago, like I was another person back then.  Maybe I was, but... there's nowhere I'd rather be, nowhere on Mareth or beyond than with you, the one I love.  Oh god, I'm so in love with you, [name].  So very much in love,</i>\" she says, running her fingers through your [hair].  You lean up and kiss her, wrapping your arms around your lover as your lips press against hers, tasting the sweet touch of hers.");
	
	outputText("\n\n\"<i>Oh, shit,</i>\" Hel says, breaking the kiss and staring wide-eyed into the morning sky.");
	
	outputText("\n\n\"<i>What's wrong?</i>\"");
	
	outputText("\n\n\"<i>I-I really am going to be a mother.  I can feel it, [name].  Your seed taking inside me, the dawn of a new life.  I just hope... I hope this wasn't a mistake, [name].</i>\"");
	
	outputText("\n\nYou lift yourself up onto your elbow, staring at your love as her fiery eyes gaze into the void.  \"<i>I thought this was what you wanted, Hel.  You were-</i>\"");
	
	outputText("\n\n\"<i>Yeah, I know.  Forget about it, I'm fine.  Really.  It's just that this happened all so suddenly, you know?  This isn't exactly where I saw myself a year ago.  Not that I'm complaining,</i>\" she adds, turning back to you with another kiss, squeezing your shoulder.  \"<i>I just hope I'm ready, I guess.  Until the Pale Flame took, I'd never really thought about being a mother.  Never really wanted it.  But last night, it was like I was possessed, like I couldn't control myself.  I just... needed you.  And there you were, like always, ready to help.  I love you with all my heart, [name]");
	if(flags[kFLAGS.HEL_LOVE] == 1) outputText(", and I'm so very, very glad you love me back.");
	else outputText(", even if you can't say the same.  And that's alright; it doesn't change my heart, and it never will. I love you");
	outputText(".</i>\"");
	
	outputText("\n\nThe two of you snuggle up for a good long while, letting the edge of your sexual exhaustion subside as you watch the sunrise, content to lie in each others' arms.  After a blissful eternity, though, you both rise and collect the scattered bits of Hel's scale mail and your [armor], laughing and teasing as you redress, exchanging the occasional kiss or caress until the pair of you are clothed, your weapons secured.  Finally, Helia slips into your arms, planting a long kiss upon your lips.  \"<i>I'm glad we're in this together, my love.  I'm going to... to need you during this.</i>\"");
	
	outputText("\n\nYou tell her to rest easy: that you'll be there for her every step of the way.  She smiles ");
	if(player.tallness >= 90) outputText("up ");
	else if(player.tallness <= 72) outputText("down ");
	outputText("at you, holding you tight for a long moment before stepping away, still holding your hands.  \"<i>This is all new to me, [name].  I never pictured myself as a mother, with a mate and a stable, safe home - or as stable and safe as anything these days - but with you by my side, there's nothing I can't take on.</i>\"");
	
	outputText("\n\nYou give your lover one last kiss before taking her back to camp proper, never letting her hand slip from yours all the way.");
	//[Back to Camp menu]
	doNext(recalling ? recallWakeUp : camp.returnToCampUseOneHour);
}

private function getAnotherDad():void {
	clearOutput();
	helScene.helSprite();
	//[Another Dad] (PC has no dick)
	if(!player.hasCock()) {
		outputText("You tell Helia you'd love to a share a child with her, but you're not... properly equipped for the endeavor.  \"<i>That's fine!  I can... I can wait, a little.  I-if you want to go grow one, I mean.  If not, then we can find someone with a cock.  ");
		if(player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText("There's Miko and Mai from the bar.  Mai's said she wanted a kid, but can't take care of one... she'd probably be willing to fuck one into me!  If that's not alright, then... lemme think.  ");
		outputText("Uh, maybe not a minotaur... they always plug more minotaurs, and I don't want a bull coming out of my twat.  Uh, maybe I could track down one of the spider boys from the swamp and jump on </i>his<i> dick.  They're pretty cute, right?  Dunno how that'd affect a child, though.  Maybe he'd end up with like, extra eyes, or chitin?  Still, better than an imp or some shit.  So what do you think?  Wanna grow a dick, or leave the knocking-up to someone else?</i>\"");
		//{Options in next section}
	}
	//[Another Dad] (PC has a dick)
	else {
		outputText("\"<i>W-wha?</i>\" Hel says, cocking an eyebrow.  \"<i>You sure, [name]?  I-if you don't want to be the dad, I guess I understand.  But why?  Am I not... no, never mind.  I don't want to know.  Okay, uh, we can find someone with a cock.  ");
		if(player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText("There's Miko and Mai from the bar.  Mai's said she wanted a kid, but can't take care of one... she'd probably be willing to fuck one into me!  If that's not alright, then... lemme think.  ");
		outputText("Uh, maybe not a minotaur... they always plug more minotaurs, and I don't want a bull coming out of my twat.  Uh, maybe I could track down one of the spider boys from the swamp and jump on </i>his<i> dick.  They're pretty cute, right?  Dunno how that'd affect a child, though.  Maybe he'd end up with like, extra eyes, or chitin?  Still, better than an imp or some shit.  So what do you think?</i>\"");
	}
	menu();
	//{If Tel'Adre has been discovered: [Mai]}
	if(player.statusEffectv1(StatusEffects.TelAdre) >= 1) addButton(0,"Mai",maiWouldBeTheBestInseminator);
	//[Spiderboy]
	addButton(1,"Spiderboy",spiderboyWouldBeBestDad);
	//[I will] (If PC has a dick)
	if(player.hasCock() && player.cockThatFits(helFollower.helCapacity()) >= 0) addButton(2,"I Will",haveAKid);
	else if(!player.hasCock()) addButton(2,"I Will",growingDicks4Hel);
	addButton(3,"No Or Later",noKidsHel);
}

private var recallTemp:int = 0;

//Mai
private function maiWouldBeTheBestInseminator():void {
	clearOutput();
	helScene.helSprite();
	outputText("You tell Hel that you think Mai would make a lovely father.  Helia nods her agreement, saying, \"<i>Yeah, I agree.  She's a beauty, and I'm sure our child will be stunning... you wouldn't mind if she visited, right?  I mean, you and I will be raising our kid - and he'll be ours for sure - but I'm sure Mai will want to at least visit her kid.</i>\"");
	outputText("\n\nYou nod, and say that's fine.  Hel beams at you, giving you a peck on the cheek before running back to camp, saying she's going to go track down the foxy sisters as soon as she can.  You suppose the next time you see her, Hel's probably going to be pregnant with the child you'll be helping to raise.");
	if (!recalling) {
		helScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_SALAMANDER, true); //Yes, it's Mai's baby, but that's already tracked separately
		flags[kFLAGS.HEL_NTR_TRACKER] = 1;
		flags[kFLAGS.HELSPAWN_DADDY] = 2;
		doNext(playerMenu);
	} else {
		recallTemp = 2;
		doNext(helGotKnockedUp);
	}
}
//Spiderboy
private function spiderboyWouldBeBestDad():void {
	clearOutput();
	helScene.helSprite();
	outputText("You tell Helia to go find a spider boy to jump.  She beams at you, and skips off toward the swamp calling, \"<i>Thank you, thank you thank you, [name]!</i>\" over her shoulder as she goes.  You suppose the next time you see her, Hel's probably going to be pregnant with the child you'll be helping to raise.");
	if (!recalling) {
		helScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_SALAMANDER, true); //Yes, it's the spider's baby, but that's already tracked separately
		flags[kFLAGS.HEL_NTR_TRACKER] = 1;
		flags[kFLAGS.HELSPAWN_DADDY] = 1;
		doNext(playerMenu);
	} else {
		recallTemp = 1;
		doNext(helGotKnockedUp);
	}
}

//I Will (PC ain't got a wang)
private function growingDicks4Hel():void {
	clearOutput();
	helScene.helSprite();
	outputText("You tell Hel to give you a little while, that you'll go find something to grow a cock for her.");
	outputText("\n\n\"<i>Thank you!  Thank you so much, [name].  I really, really wanted for it to be our child. I'll wait, but hurry.  I don't know how much longer I can stand this... this need!</i>\"");
	outputText("\n\nOnce you've finished with Hel, she leaves you with a longing look as you head back to camp.  Eventually, you manage to go back to sleep...");
	//[Resume night]
	doNext(recalling ? recallWakeUp : playerMenu);
}

//[No Kids]
private function noKidsHel():void {
	clearOutput();
	helScene.helSprite();
	outputText("You shake you head and say no, you don't want to have children.  Not right now, anyway.  ");
	if(player.hasCock() && player.cockThatFits(helFollower.helCapacity()) >= 0) outputText("You couldn't if you wanted to anyway - you're too big to fit.  ");
	outputText("As the words leave your lips, you can see Hel's shoulders slump, a crestfallen look spreading across her face.  \"<i>A-are you sure?  Please, [name], I really, really want a child.  For </i>us<i> to have one.</i>\"");
	outputText("\n\nYou tell her that no, at least for now you aren't interested.  She begs and pleads for several minutes, but you hold your ground.  Finally, she relents.  \"<i>Alright, [name].  I... I'll respect that, I guess.  Dad gave me some herbs, said as long as I take them, I should go back to normal.  If that's what you want, I'll start on them.  Just tell me if - when - you're ready, [name].  I will be.</i>\"");
	
	outputText("\n\nShe leans up and gives you a peck on the cheek before wandering back to camp, leaving you standing alone in the dark with your choices.  Eventually, you manage to go back to sleep...");
	//[Resume night]
	doNext(recalling ? recallWakeUp : playerMenu);
}

//Hel Dun Got Knocked Up (Play first time PC goes to Hel's menu after telling her to get knocked up by someone else)
//Proc day after dad choice @ 8AM.
public function helGotKnockedUp():void {
	helScene.helSprite();
	if (!recalling) {
		flags[kFLAGS.HEL_NTR_TRACKER] = 2;
		outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
	}
	outputText("<b>After your decision with Helia last night,</b> you decide to check in on your lusty salamander.  You find her sitting on a rock near her part of camp, knees held close to her chest, seemingly deep in thought.  She gives you a ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 2 || recallTemp == 2) outputText("warm ");
	else outputText("wan ");
	outputText("smile as you approach, scooting over to allow you to sit beside her.  She almost seems distant, though she's quick to wrap her tail around your waist, hugging you close against her.");
	outputText("\n\nAfter a few quiet minutes, you finally ask, \"<i>How'd it go?</i>\"");
	outputText("\n\n\"<i>Well... let's just say it worked.  Unless you wanna hear the details?</i>\" she asks conspiratorially.");
	menu();
	//Hel Got Knocked Up by Mai
	if(flags[kFLAGS.HELSPAWN_DADDY] == 2 || recallTemp == 2) {
		addButton(0,"Sure",sureHelGimmeMaiDetails);
		addButton(1,"Nope",dontTellMeAboutMai);
	}
	//Hel Got Knocked Up by a Spiderboy
	else if(flags[kFLAGS.HELSPAWN_DADDY] == 1 || recallTemp == 1) {
		addButton(0,"Sure",sureHelGimmeSpidahBoyDetails);		
		addButton(1,"Nope",dontTellMeAboutSpiderboy);
	}
	//clear recall stuff
	if (recalling) recallTemp = 0;
}

//Sure
private function sureHelGimmeSpidahBoyDetails():void {
	clearOutput();
	helScene.helSprite();
	outputText("Hel chuckles, shaking her head.  \"<i>So I go to the swamp and just shout out 'Who wants to fuck a baby into this fertile womb, you chitiny bastards,' and sure enough, I got plenty of volunteers.  Whole horde of creepy crawlies came out of the woodwork, but I saw the looks in their eyes: corrupt, all of 'em.  I don't want my kid half way to cumming out his soul before he's had a chance, you know?  So I did my berzerker thing, fought 'em off.  The swamp's getting more and more dangerous every month, I think.  Something in the water maybe, who knows.  Anyway, after I dispatched the crazies, I went deeper, just a little");
	if(followerKiha()) outputText(", toward hotwings' old place");
	outputText(". Took a while, but eventually I just sort of stumbled on this couple of spidergirls, just as cute as could be.  They wander up to me, all cautious, and ask if I was serious about the whole baby thing.  So I say, 'Yeah, sure,' and they get this big, dopey grin, both of 'em.</i>\"");
	
	outputText("\n\n\"<i>They tell me they're sisters, and they've got a little brother who's looking for his first mate.  But he's terrified of just jumping people to fuck 'em (kind of old fashioned, but hey, what're you gonna do?), and the girls are afraid he'll get dragged off by some demon drider thing and raped to death.  So the girls say if I'm looking to breed, they've got a plan: let me pretend to be all helpless, and they'll sic their brother on me; he gets to feel like the big predator man, and I get fucked full of seed.  Win-win.  So they take me to a clearing, tell me to wait.  Few minutes later, and this little bitty spiderboy wanders out of the jungle - and I mean, his mother must've been a goblin, cuz he's a runty little shit, wrapped up in this silk shift down to his knees when his sisters have their tits hanging out in the wind.  Poor thing's shy as can be, but he blabbers something about tying me up and having his way with me, you know the drill.  So I swoon and drop my sword and get all dramatic and beg him not to hurt me.</i>\"");
	
	outputText("\n\n\"<i>I swear it took him like, half an hour to actually just tie me up properly.  His spinners are spurting like little cocks everywhere, and he's apologizing and trembling all over until I actually have to help the poor kid get me all tied up and gagged.  But then - and this is rich - he wiggles out of his shirt, and oh my god the kid's a fucking tripod.  I mean he puts minotaurs to shame, and how.  Here's this shy kid, never had a girl before, and he's packing a god-damn monster down under");
	//If PC has a giant wang:
	if(player.biggestCockArea() >= 20) outputText(", though still nothing compared to you, lover mine");
	outputText(".  So he's rock-hard now, trembling with excitement; he spreads my legs nice and wide, stroking himself as he lines up and... oops, wrong hole.  That was a surprise, lemme tell you.  Not an </i>unpleasant<i> surprise, mind you, but still.  Just about rips me in half with this giant thing, slides all the way to the hilt and just stops, like he doesn't know what to do.  He just sort of moans and wiggles his hips a little, hugging himself to me and burying his head in my chest.</i>\"");
	
	outputText("\n\n\"<i>Well, what's a girl to do?  I get my hands free pretty easy, and run my fingers through his hair, tell him everything's okay, he's doing great.  Poor kid looks up at me with these huge puppy-dog eyes and asks, 'R-really?' like he's so shocked.  God damn, he was cute.  So I give him a little kiss, help him pull out and line up with the real prize.  Oh, you should have seen his face when he slid home: tongue rolled out, eyes crossed.  He just about came right there, but I clenched down hard, told him he'd have to work for it.  I pull him in tight, just bury his face in my tits and guide his hips, getting him working nice and slow.  But that boy, give him a little urging on and he's a natural... in about five minutes he's got me on all four and humping away, plunging this fucking monster in until I'm screaming and cumming and he is too.  Oh, we made quite the mess, we two.</i>\"");
	
	outputText("\n\n\"<i>So finally he rolls off of me, flops down with his monster cock just about to his chin lying on top of him.  Well, I kind of liked him by then, so I curl up with him for a little cuddle, tell him just how good a breeder he is, what a fine specimen he was, et cetera.  But then the little bastard opens his mouth and, real quiet like, asks if we can go again - and if I'd please bugger him with my tail while I rode his cock.  Oh, well, how can I refuse?  Okay, maybe he didn't </i>ask<i> in so many words, but that's what he </i>wanted<i>, let me tell you.  And that's sure what he got.  Again and again until I'd ridden him senseless.</i>\"");
	outputText("\n\n\"<i>And then his sisters got bored and joined in.</i>\"");
	doNext(dontTellMeAboutSpiderboy);
}

//Nah // Combine
private function dontTellMeAboutSpiderboy():void {
	clearOutput();
	helScene.helSprite();
	outputText("\"<i>So, let's just say I came away from that encounter carrying enough cute spiderboy cum to fill a bucket.  If I'm not carrying his child now, then I'm hopeless.  But... you know, I think I can feel it, [name].  I shouldn't be able to, but I can.  Oh, god,</i>\" Hel says, looking pointedly away from you, staring wide-eyed into the morning sky.");
	
	outputText("\n\n\"<i>What's wrong?</i>\"");
	
	outputText("\n\n\"<i>I-I really am going to be a mother.  I can feel it, [name].  The spiderboy's seed taking inside me, the dawn of a new life.  I just hope... I hope this wasn't a mistake, [name].</i>\"");
	
	outputText("\n\nYou put an arm around the mother-to-be's shoulder, saying, \"<i>I thought this was what you wanted, Hel.  You were-</i>\"");
	
	outputText("\n\n\"<i>Yeah, I know.  Forget about it, I'm fine.  Really.  It's just that this happened all so suddenly, you know?  This isn't exactly where I saw myself a year ago.  Not that I'm complaining,</i>\" she adds, turning back to you with a kiss, squeezing you with her tail.  \"<i>I just hope I'm ready, I guess.  Until the Pale Flame took, I'd never really thought about being a mother.  Never really wanted it.  But last night, it was like I was possessed, like I couldn't control myself.  I just... needed you.  Well, maybe not your sperm - not literally, I mean - but it was like my body screaming 'You've found [him], [he]'s the one, this is a keeper!  Time to propagate!' I-I can't help but feel like this wasn't entirely my choice, you know?  Like I was acting on instinct, like an animal, not a person.  But at the same time, if I've made a mistake, then I have you here with me, to help me like you always do.  I love you with all my heart, [name]");
	if(flags[kFLAGS.HEL_LOVE] == 1) outputText(", and I'm so very, very glad you love me back.");
	else outputText(", even if you can't say the same.  And that's alright; it doesn't change my heart, and it never will. I love you.");
	outputText("</i>\"");
	
	outputText("\n\nThe two of you snuggle up for a good long while, content to lie in each others' arms.  \"<i>I'm glad we're in this together, my love.  I'm going to... to need you during this.</i>\"");
	
	outputText("\n\nYou tell her to rest easy: that you'll be there for her every step of the way.  She smiles ");
	if(player.tallness >= 90) outputText("up ");
	else if(player.tallness <= 72) outputText("down ");
	outputText("at you, holding you tight for a long moment before stepping away, still holding your hands.  \"<i>This is all new to me, [name].  I never pictured myself as a mother, with a mate and a stable, safe home - or as stable and safe as anything these days - but with you by my side, there's nothing I can't take on.</i>\"");
	
	outputText("\n\nYou give your lover one last kiss before getting back to your quest.");
	doNext(recalling ? recallWakeUp : camp.returnToCampUseOneHour);
}


//Hel Got Knocked Up by Some Random Slut at the Bar, and Nobody Was Really Surprised, All Things Considered. 
private function sureHelGimmeMaiDetails():void {
	clearOutput();
	helScene.helSprite();
	outputText("\"<i>You know, it's not easy for me to get around in Tel'Adre.  I lived my whole life in the middle of shit-all nowhere, the wide-open plains.  But here's a ruined city, packed full of abandoned buildings and thousands of people.  Took half the night to find Miko and Mai's place, this little bungalow-thing near the walls.  I probably got turned around three or four times, nearly gang-raped by this big pack of cats... man, fuck cities.  But anyway, I was lucky that Mai answered the door; she'd just been going to bed, I guess.  Miko was gone, off with some new girlfriend.  Or maybe getting gang-banged by cat people, since that's a thing that happens there apparently.  Who knows.</i>\"");
	outputText("\n\n\"<i>Well, it's kind of awkward to tell a good friend, 'Hey, I want to bear your children. Present your cock, slut!'  At the same time, it's not really fair to just jump her britches and ride her 'til the sun rises without her knowing what's up.  Also, the tail being white's a dead giveaway, unless I fuck her with my cloak on.  So, I take Mai to their kitchen, pour us some wine, ask her how's things, make small talk.  That gets her suspicious, of course, and finally I have to say, 'So, remember the last few weeks, we've been hanging out, and you keep saying how much you want to have kids, but can't find a good man or woman and you don't want to raise your spawn in the city, anyway?  Yeah, so, I kinda want to have kids too and this is really sudden but what do you say, lover girl?  You and me, let's make a baby!'</i>\"");
	outputText("\n\n\"<i>I'm not a diplomat or a bard, but eventually I talk her into it.  She's all nervous by the time I yank her nightgown off, asking all the wrong questions.  'Can I visit?  What do we name her?  What would a salamander-fox look like?  Do you want a boy or a girl or a;' I'm laughing, the I tell her to shut up and fuck me.  Well, by the time I get her panties off, that puppy pecker's nice and swollen, bright red with a thick knot ready to stretch me wide.</i>\"  Hel pauses to lick her lips, staring into the distance.  \"<i>She's raring to go, but I'm going to take it slow, give her a night to remember.  I get down between her legs, running my fingers across that supple flesh of hers, licking her tight little cunt 'til she's drooling on my tongue.  My tail sneaks around and does its thing, gently teasing that precious little spot where the skin meets the fluff of her tail, working its way down to her little pucker.  God, she makes the cutest little gasps when I get inside her, worming my tail into her ass 'til I find the nub of her prostate and get to milking.  Now her cock's standing at attention, and I climb into bed with her, kissing and fondling those big perky tits of hers until I can feel her ready to burst.  I go slow down on her, leaning back on my haunches until I can feel just the tip of her pressing in on my cunt; oh, she's whimpering and whining by then, grabbing my hips to try and bring me down on her, begging me to fuck her brains out, to let her swollen little knot pop its load deep inside me.</i>\"");
	
	outputText("\n\n\"<i>Finally, even I can't stand it anymore, and I drop like the hand of god on her, taking her knot and all in one go.  She came right then and there, screaming loud enough to wake the neighbors - and digging her fingers in enough to leave scratches on my ass.  But she flooded me with cum until it drooled out around her knot.  And knotted we were, let me tell you.  But that's just an excuse to go again, and with my tail right on her prostrate, she was up and at it again in half a minute, moaning as I got to work bouncing on her cock like a... I dunno, a sex bunny.  So on we go for hour after hour until Mai's just about passed out, and we're both covered in sweat and cum and that shitty lube she keeps around.  Shit, we were still at it by the time Miko got back, and suddenly I've got an extra knot tearing up my asshole and another pair of hands to play with my tits while I propped Mai up, head buried in my cleavage.</i>\"");
	
	outputText("\n\n\"<i>Come sunrise, and the three of us are filthy: the twins look like they're made of cum, and I'm gushing it out of every hole.  Eventually I managed to tell Miko what she'd stumbled into, and she insisted on making us a celebratory breakfast.  She got all excited about being an aunt, but Mai was just about passed out by the time I left - just strong enough to pull me down, give me a goodbye kiss, and rest her head on my belly, whispering cute nothings to the baby she spent all night fucking into me.</i>\"");
	doNext(dontTellMeAboutMai);
}

//Nah // Combine
private function dontTellMeAboutMai():void {
	clearOutput();
	helScene.helSprite();
	outputText("\"<i>So, let's just say I came away from that encounter carrying enough foxy herm cum to fill a bucket.  If I'm not carrying her child now, then I'm hopeless.  But... you know, I think I can feel it, [name].  I shouldn't be able to, but I can.  Oh, god,</i>\" Hel says, looking pointedly away from you, staring wide-eyed into the morning sky.");
	
	outputText("\n\n\"<i>What's wrong?</i>\"");
	
	outputText("\n\n\"<i>I-I really am going to be a mother.  I can feel it, [name].  Mai's seed taking inside me, the dawn of a new life.  I just hope... I hope this wasn't a mistake, [name].</i>\"");
	
	outputText("\n\nYou put an arm around the mother-to-be's shoulder, saying, \"<i>I thought this was what you wanted, Hel.  You were-</i>\"");
	
	outputText("\n\n\"<i>Yeah, I know.  Forget about it, I'm fine.  Really.  It's just that this happened all so suddenly, you know?  This isn't exactly where I saw myself a year ago.  Not that I'm complaining,</i>\" she adds, turning back to you with a kiss, squeezing you with her tail.  \"<i>I just hope I'm ready, I guess.  Until the Pale Flame took, I'd never really thought about being a mother.  Never really wanted it.  But last night, it was like I was possessed, like I couldn't control myself.  I just... needed you.  Well, maybe not your sperm - not literally, I mean - but it was like my body screaming 'You've found " + player.mf("him","her") + ", " + player.mf("he","she") + "'s the one, this is a keeper!  Time to propagate!'  I-I can't help but feel like this wasn't entirely my choice, you know? Like I was acting on instinct, like an animal, not a person.  But at the same time, if I've made a mistake, then I have you here with me, to help me like you always do.  I love you with all my heart, [name]");
	//if HelLove is Yes:
	if(flags[kFLAGS.HEL_LOVE] == 1) outputText(", and I'm so very, very glad you love me back.");
	else outputText(", even if you can't say the same. And that's alright; it doesn't change my heart, and it never will. I love you.");
	outputText("</i>\"");
	
	outputText("\n\nThe two of you snuggle up for a good long while, content to lie in each others' arms.  \"<i>I'm glad we're in this together, my love. I'm going to... to need you during this.</i>\"");
	
	outputText("\n\nYou tell her to rest easy: that you'll be there for her every step of the way.  She smiles ");
	if(player.tallness >= 90) outputText("up ");
	else if(player.tallness <= 72) outputText("down ");
	outputText("at you, holding you tight for a long moment before stepping away, still holding your hands.  \"<i>This is all new to me, [name].  I never pictured myself as a mother, with a mate and a stable, safe home - or as stable and safe as anything these days - but with you by my side, there's nothing I can't take on.</i>\"");
	
	outputText("\n\nYou give your lover one last kiss before getting back to your quest.");
	doNext(recalling ? recallWakeUp : camp.returnToCampUseOneHour);
}


//Helia's Pregnancy
//In addition to the alterations to her appearance screen, given above, the following new scenes and changes occur once Hel's been knocked up.
//Hel's pregnancy should last for ~2 weeks in-game time. Each week, she'll move from bulging to swollen to gravid every 5 days or so, which alters her Appearance slightly, and can change her pregsex scenes.
//Note that, during the pregnancy, Hel's ability to Fight and Wrestle with the PC is removed. She's not willing to let her baby get hurt!

//Hel enters "bulging" state, play at random from camp menu:
//if(flags[kFLAGS.HELIA_PREGNANCY_INCUBATION] < 300 && flags[kFLAGS.HEL_PREGNANCY_NOTICES] == 0) {
public function bulgyCampNotice():void {
	clearOutput();
	helScene.helSprite();
	outputText("As you're walking through camp, your eyes wander over toward Helia, sunning herself on a stone near the edge of camp.  You can just see that her belly's starting to bulge out from under her, and Hel's hands lie protectively over her full womb, absently rubbing the bulge of her stomach.");
	doNext(playerMenu);
}
//Hel enters "swollen" state, play at random from camp menu:
//if(flags[kFLAGS.HELIA_PREGNANCY_INCUBATION] == 200 && flags[kFLAGS.HEL_PREGNANCY_NOTICES] == 1)
public function heliaSwollenNotice():void {
	clearOutput();
	helScene.helSprite();
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
	helScene.helSprite();
	outputText("\"<i>Is that so? Yeah, I can see it.  ");
	if(player.hasCock() && !player.hasVagina()) outputText("If I were a guy, I'd want a big strong son to hang out with, too.  Take him fishing, teach him how to fight the way you do... you'll make a great dad, my love.  I'm sure you will.");
	else outputText("Would be nice to have a man around here, you know?  I miss hanging around the boys back home, watching 'em strut like peacocks for every passing girl.");
	outputText(" And any son of mine is going to be a real lady killer, mark my words.  We're going to have to fight off whole hordes of goblin sluts, all looking for a piece of our handsome little boy before you know it.</i>\"");
	outputText("\n\nYou share a quiet laugh with your lover before leaving her with a kiss and a final pat on the belly - and feeling the little kick of your spawn reacting to you.");
	doNext(playerMenu);
}

//Girl
private function youWantAGirl():void {
	clearOutput();
	helScene.helSprite();
	outputText("\"<i>Yeah, a girl would be pretty great.  ");
	//if PC is male:
	if(player.hasCock() && !player.hasVagina()) {
		outputText("I dunno if you had any sisters growing up, [name], but let me warn you: a little girl, especially a little salamandress, is going to be a hell of a handful.  But I can just see you when she's all grown up, packing a big old sword and threatening every boy that wants a piece of her: 'Treat her right or you'll have the CHAMPION to deal with.  Rawr.'");
	}
	else outputText("We're going to be a gaggle of tittering girls before you know it, though.  Salamanders grow up so fast, [name]...  I just hope she doesn't turn out like me, you know?  I don't know if I could stomach seeing my little girl becoming a wanton slut like her mom.  I might get jealous, after all...");
	outputText("  Any daughter of ours is going to be a real beauty, mark my words. She'll make a succubus look like a toad before she's out of swaddling.</i>\"");
	
	outputText("\n\nYou share a quiet laugh with your lover before leaving her with a kiss and a final pat on the belly - and feeling the little kick of your spawn reacting to you.");
	doNext(playerMenu);
}

//Hel enters "gravid" state, play at random from camp menu:
//if(flags[kFLAGS.HELIA_PREGNANCY_INCUBATION] == 100)
public function heliaGravidity():void {
	clearOutput();
	helScene.helSprite();
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
	helScene.helSprite();
	flags[kFLAGS.HELIA_TALK_SEVEN] = 1;
	outputText("You take Hel with you to a secluded spot at the edge of camp and sit with her, asking how she's doing as you run a hand across her pregnant belly.  She nuzzles against you, wrapping her lengthy tail around your waist as her cheek nestles into the nape of your neck.  \"<i>It's... not like I expected, [name].  Whenever I used to think of being a mother, I always sort of skipped the whole 'carry the little bastards around in your belly' part.  I just feel so... full, I guess?  Like I just ate a horse, and the horse is inviting its friends to come party at night whenever I try to sleep.  Heh, this little firebrand just loves to kick and squirm at night, let me tell you.  Speaking of which-</i>\"  Hel takes your hand in hers and places it over her belly, letting you feel the subtle little movements inside her as your growing child pushes out toward the world.");
	
	outputText("\n\nStill caressing the swell of Hel's stomach, you mention that you'd have expected a salamander to lay an egg - even if she's only carrying a half-salamander.  Hel's chuckles, \"<i>Salamanders ditched the whole egg thing ages ago, I guess.  I mean, we're scaly lizard folk and all, but come on - these aren't just for show, you know,</i>\" she says, cupping her hefty tits, which seem to have grown just a touch larger since she conceived.");
	
	outputText("\n\n\"<i>Getting ready to swell with milk,</i>\" Hel says, proudly patting her bust.  \"<i>Don't worry, lover mine; we salamanders are hard drinkers right out of the womb, but I'll be sure to save plenty for you!</i>\"");
	
	outputText("\n\nA moment of laughing passes before Hel adds, \"<i>But seriously, lover, thanks for checking in on me.  I don't... I can't do this on my own, you know?  I'm trying, but it's hard, and getting harder.  Every night since this started, I've lain up thinking 'Oh god, what if I screw this up?  Wh-what if I say something wrong, or do something that just twists my kid's mind and fucks her up forever?  Or she turns into a bigger whore than I am,' or a million other things I can't stop thinking about.  I just keep worrying that I'm going to be a shit mom.  But you know... with you around, I feel at least a little more confident.  I don't know if I even could have a good impression on our kid, but... I know you will, [name].  You're a strong " + player.mf("man","woman") + "; stronger than I'll ever be.  I just hope a tiny little sliver of your strength - and maybe a healthy dose of your looks - rub off on him.  Or her.  That's all I'd ask for");
	//if PC isn't daddy:
	if(flags[kFLAGS.HELSPAWN_DADDY] != 0) outputText(", even if he's not your get, I can hope, you know?  If he spends enough time around you, maybe he'll take more after you than me");
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
	helScene.helSprite();
	outputText("You squeeze Hel's shoulder and tell her that she's going to be a great mother, and that her child would do well to learn from a beautiful, powerful warrior like dear old mom.  ");
	if(flags[kFLAGS.HEL_LOVE] == 1) outputText("You love Hel");
	else outputText("Hel's your friend");
	outputText(", and if her child follows in her footsteps, so much the better.  Your lover manages a half-hearted laugh, blushing at your words.  Her tail tip brushes your cheek as its owner cuddles up against you, smiling.  \"<i>Thanks, lover mine.  I just hope I - we - can do right by the kid.  That's all.</i>\"");
	outputText("\n\n\"<i>I know,</i>\" you answer, kissing her.");
	doNext(playerMenu);
}

//Hel's Lifestyle
private function helsLifestyle():void {
	clearOutput();
	helScene.helSprite();
	outputText("Being very serious for a moment, you tell Hel that if she's worried about her terrible choices rubbing off on her kid, maybe she ought to reconsider some of the things she's done: be less of a slut, drink less, be less of a bloodthirsty maniac in battle.  Slowly, Hel nods to the rhythm of your words.  \"<i>Yeah, maybe... maybe I should.  I don't know if I can change though, [name].  I'm not as young as I was - or at least, I don't feel it - and I've been living the way I have been for years.  I don't know if I could just give up the shit I do: the partying and the drinking, the fighting and the fucking.  It's part of who I am, ");
	if(flags[kFLAGS.HEL_LOVE] == 1) outputText("and I hope that's part of why you love me");
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
	helScene.helSprite();
	outputText("The morning dawns like any other, though as you're getting dressed, you can't help but notice Hel waddling back from the edge of camp, both hands firmly gripping her positively massive belly.  You walk over just in time to hear her groan, \"<i>Oh fuck me sideways and call me a harpy, this shit sucks.</i>\"  You put an arm around her to steady the sickened salamander, but she barely notices you as she flops down beside her still, nearly grabbing a glass before stopping herself.  \"<i>Fucking shit fuck I am so done with this.  I - oh god,</i>\" she doubles over, squeezing her belly.  \"<i>Ow ow oh god ow.</i>\"");
	
	outputText("\n\nYou ask Hel if she's okay, which earns you a bestial growl and a murderous look.  Her look softens a moment later when she doubles over again, seized by agony.  \"<i>Just about time, [name].  Oh fuck, this hurts something fierce.</i>\"");
	
	outputText("\n\nKneeling beside the salamander, you ask what she needs - what can you do?");
	
	outputText("\n\n\"<i>I-I don't know!</i>\" Hel cries, leaning back against you, her legs spreading.  \"<i>I don't </i>fucking<i> know! Just - aahhhh - hold my hand!</i>\"");
	
	outputText("\n\nYou dutifully hold Helia's hand as water gushes out from between her legs, heralding the birth of ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 1) outputText("your ");
	else outputText("her ");
	outputText("child.  Hel screams and cries, gripping your hand so tight you feel like your bones are about to break in her iron gasp; you try and tell her to push, to remember everything the Midwives of Ingnam would say when a village girl gave birth.  It seems a small comfort to the screaming salamander, but she does as you say, pushing harder and harder until you can see the crown of a little baby's head pushing out of your lover's well-stretched cunt.  Suddenly with a roar that echoes across the wasteland and a mighty push, a squalling baby tumbles out of Hel's birth canal and into your waiting arms.");
	menu();
	addButton(0,"Next",heliaBirthEpilogue);
}

private function heliaBirthEpilogue():void {
	clearOutput();
	helScene.helSprite();
	//It's a girl! 
	//If PC was the father: 
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("A healthy baby salamander gurgles and cries as you wrap her in a towel, looking up at you with a pair of bright golden eyes.  Hel takes your daughter, holding the little bundle of you to herself, cooing and laughing at the new life in her arms.  \"<i>Oh my god, [name], look... it's... it's our baby girl.  And she's got your eyes.  The same look I see in your eyes every day.  Oh, this one's going to grow up big and strong.  Aren't you?</i>\" she laughs, rubbing the baby's cheek.  It makes a high, gay little coo in response, nuzzling against Hel's finger.");
	//If Mai was the father:
	else if(flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("What you hold in your arms isn't <b>quite</b> a salamander, though.  The little girl you've by now got wrapped up in a towel looks mostly like her mother, with a full body of red scales and pale flesh, and a brightly flaming tail; but atop her head, rather than finned reptilian ears are a pair of perky, puppy-dog like ears.  Taking her daughter, Hel laughs, scratching the newborn behind the ears, making it coo and giggle.  \"<i>Oh my god, [name], look... it's... it's our baby girl.  And she's got Mai's ears, holy shit.  Look at that.  Oh, you're going to be adorable when you grow up, aren't you?</i>\" she laughs, rubbing the baby's cheek.  It makes a high, gay little giggle in response, nuzzling against Hel's finger.");
	else outputText("What you hold in your arms isn't <b>quite</b> a salamander, though. The little girl you've got wrapped up in a towel has the same shape as her mothers, a body covered in leather scales and a brightly-flaming tail... but her scales are a midnight black, the same color as a spider's chitin.  The little girl looks up at you with bright red eyes as Hel takes her from you, laughing as she runs her hand across her daughter's dark scales.  \"<i>Well, that's a hell of a thing, isn't it [name]?  A black-scaled salamander... she's beautiful.  Oh you're going to be gorgeous when you grow up, aren't you?</i>\" she laughs, rubbing the baby's cheek.  It makes a high, gay little giggle in response, nuzzling against Hel's finger.");
	//[New Paragraph]
	outputText("\n\nThough still panting from the ordeal, Hel's motherly instincts kick in as her daughter tries to eat her finger, and pulls her scaled top down to reveal the swell of her big, milky breast.  The newborn latches on immediately, sighing happily as it takes its first meal.  A sentiment echoed by her mother, who slumps over onto your shoulder, breathing easy for the first time in the day.  \"<i>That was... gaaah.  But look... look at her.  My god, she's amazing.  So beautiful... she's perfect, [name].  And she's- oh, she's got a hell of a bite.  Ow.</i>\"");
	menu();
	addButton(0,"Next",nameDatHelspawn);
}

//[NEXT]
private function nameDatHelspawn():void {
	clearOutput();
	helScene.helSprite();
	outputText("You and Helia share a laugh, looking down at ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your ");
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
	helScene.helSprite();
	//Easter Egg Names Hel WILL NOT ALLOW:
	if (CoC.instance.testingBlockExiting)
	{
		// We're running under the testing script.
		// Stuff a name in the box and go go go
		mainView.nameBox.text = "Kiderp";
	}
	else if(mainView.nameBox.text == "" 
			|| mainView.nameBox.text == "Hellgirl" 
			|| mainView.nameBox.text == "Kid" 
			|| mainView.nameBox.text == "Phoenix" 
			|| mainView.nameBox.text == "Savin" 
			|| mainView.nameBox.text == "Helia" 
			|| mainView.nameBox.text == "Mini-doofus") 
	{
		clearOutput();
		if(mainView.nameBox.text == "") outputText("<b>You must select a name.</b>");
		else if(mainView.nameBox.text == "Hellgirl") outputText("\"<i>Hey, that's copyright infringement.  Probably.</i>\"");
		else if(mainView.nameBox.text == "Kid") outputText("\"<i>Wow, what are you, five?</i>\"");
		else if(mainView.nameBox.text == "Phoenix") outputText("\"<i>Oh hell no.  You're not naming my little girl after one of those... things!  Sorry Kiri, but still!</i>\"");
		else if(mainView.nameBox.text == "Savin") outputText("\"<i>That's a boy's name, dumbass.</i>\"");
		else if(mainView.nameBox.text == "Helia") outputText("\"<i>My favorite name!  Except it's kinda taken, love.  Don't want things to get too confusing around here, do you?</i>\"");
		else if(mainView.nameBox.text == "Mini-doofus") outputText("\"<i>Oh yeah, Kiha'll get a laugh out of that.  You ass.</i>\"");
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
	if(flags[kFLAGS.HELSPAWN_NAME] == "Helspawn") outputText("\"<i>That's what I was gonna call her!  Except not at all.  God dammit, seriously, [name]?</i>\"\n\n");
	if(flags[kFLAGS.HELSPAWN_NAME] == "Jayne") outputText("\"<i>That sounds like a hero's name... I like it.  A name that demands respect!</i>\"\n\n");
	if(flags[kFLAGS.HELSPAWN_NAME] == "Hesper") outputText("\"<i>Ah, the Evening Star.  She'll be the star of my life, alright...</i>\"\n\n");
	if(flags[kFLAGS.HELSPAWN_NAME] == "Kiri") outputText("\"<i>Aw, that's great, lover.  Sis'll shit her pants when she hears her niece is named after her!  Gonna get confusing, though...</i>\"\n\n");
	if(flags[kFLAGS.HELSPAWN_NAME] == "Mai") outputText("\"<i>Aw, that's great, lover.  Mai'll be honored, I know it.  And it is a great name...</i>\"\n\n");
	if(flags[kFLAGS.HELSPAWN_NAME] == "Tanis") outputText("\"<i>I don't... I don't know if I want her to have that name, lover.  It's got a lot of baggage, but... but it does my mother an honor.  More than I could ever give her.</i>\"\n\n");
	//Syn: 
	if(flags[kFLAGS.HELSPAWN_NAME] == "Syn") outputText("\"Awesome.  I was hoping you'd choose that one, lover mine.</i>\"\n\n");
	if(flags[kFLAGS.HELSPAWN_NAME] == "Chara") outputText("\"<i>Awesome.  You liked my ideas, after all!</i>\"\n\n");
	
	outputText("\"<i>So... " + flags[kFLAGS.HELSPAWN_NAME] + " it is.  That's a good name, my love.  A strong name.  ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("Our");
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
	if(flags[kFLAGS.HELSPAWN_DADDY] == 2) flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
	//>If Spiderbro is daddy: +10 HelspawnChaste
	if(flags[kFLAGS.HELSPAWN_DADDY] == 1) flags[kFLAGS.HELSPAWN_PERSONALITY] -= 10;
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) {
		//>If Corrupt (66+ Corr) PC is daddy: +10 Helspawn Slutty
		if(player.cor >= 66) flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
		//>If Pure (33> Corr) PC is daddy: +10 Helspawn Chaste
		if(player.cor <= 33) flags[kFLAGS.HELSPAWN_PERSONALITY] -= 10;
	}
	flags[kFLAGS.HELSPAWN_AGE] = 1;
	flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] = 1;
	helScene.pregnancy.knockUpForce(); //Clear Pregnancy
	//>If the two scores tie at the end somehow, Sluttymandergirl prevails!
}

//Hel Talk 8 (Only while HelSpawn is still a baby)
internal function heliaTalkEight():void {
	clearOutput();
	flags[kFLAGS.HEL_TALK_EIGHT] = 1;
	helScene.helSprite();
	outputText("Watching your little daughter crawl around, you and Hel sit down together arm in arm, smiling as the little salamander girl plays with bits and pieces of Hel's gear.");
	outputText("\n\n\"<i>She's growing up so fast... and only getting faster.  By the time I pulled her off my breast the first time, I swear she'd doubled in size.</i>\"  You nod, able to see it clearly yourself.  Your little girl's growing fast... and it's not just a ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("parental ");
	else outputText("care giver's ");
	outputText("pride, either.  She really is growing up faster, many times faster than a human girl.  And, by the sound of things, many times faster than a salamander ought to.  You ask Hel if that's right, and she nods gravely.");
	
	outputText("\n\n\"<i>I don't know what it is about this world, but it's touched me... my daughter... already.  She's growing like a little goblin, and I don't know why.  Could it have been something I drank?  Something I fucked?  I can't... I don't know, [name].  It's probably my fault, but I can't imagine what I did wrong.  She should be taking years to get this big, but look at her...</i>\"");
	
	outputText("\n\nHel's right. Your little girl looks like she's five, maybe six years old already.");
	
	//If Amily is at camp: 
	if(amilyScene.amilyFollower()) outputText("\n\nYou mention how Amily managed to reverse-engineer a goblin's potion to accelerate her childrens' growth.  Hel grimaces, running a hand over her belly.  \"<i>God damn green menaces.  I never - almost never - drank any of their shit.  Succubus milk?  Sure, why not.  Snake oil, bring it on... But goblin potions?  I'm not that stupid, [name].  It couldn't have been...</i>\"");
	
	outputText("\n\nSighing, Hel leans her head on your shoulder, wrapping her tail around your waist.  \"<i>Well, I guess we get even less time to learn how to be parents, huh?  I guess it doesn't matter how it happened - what matters is that ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("our");
	else outputText("my");
	outputText(" little girl's going to be a big girl damn soon.  Let's enjoy it while we can, eh?</i>\"");
	
	outputText("\n\nYou nod to your lover, and both of you walk over to spend some quality time playing with " + flags[kFLAGS.HELSPAWN_NAME] + ".");
	doNext(camp.returnToCampUseOneHour);
}

//From Hel's menu: [Play with Kid]
internal function playWithYourKid():void {
	clearOutput();
	helScene.helSprite();
	outputText("Picking " + flags[kFLAGS.HELSPAWN_NAME] + " up off the ground, you spin the giggling little girl around, laughing as your ");
	if(flags[kFLAGS.HELSPAWN_DADDY] != 0) outputText("ward ");
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
	helScene.helSprite();
	flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] = 1;
	flags[kFLAGS.HELSPAWN_AGE]++;
	outputText("You wake up to a scream, high-pitched and terrified.  You bolt up out of bed, tangling up in your bedroll for a minute before stumbling over to Hel and... " + flags[kFLAGS.HELSPAWN_NAME] + "?");
	outputText("\n\nYou do a double take as you lay eyes on the ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 1) outputText("black");
	else outputText("red");
	outputText("-scaled figure curled up next to Helia; Hel herself is looking wide-eyed down at the drowsy figure on her breast, just barely opening her eyes.  \"<i>Y-you're... you're huge!</i>\" Hel manages to gasp out, pushing herself back and away from her daughter.");
	
	outputText("\n\n\"<i>Mom?</i>\" the girl asks, rubbing her temple.  As she sits up, you can see that she's grown exponentially since you put her to bed the night before: she's nearly six feet tall, her hair hanging down in long, silky locks to her bare behind.  Her figure's filled out, a pair of burgeoning breasts and flared hips showing themselves on her feminine body.  She'd easily match any of the teenage girls in your home town in terms of size and figure, maybe fifteen or sixteen in appearance now.");
	
	outputText("\n\n\"<i>Ugh, what's wrong?</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " groans, looking up at Hel, then to you.  \"<i>" + championRef() + ", why's mom screaming?</i>\"");
	outputText("\n\n\"<i>Oh my god you're a giant!</i>\" Hel babbles, curling her knees up to her chest.  \"<i>Wh-wh-what... what happened to... to my little girl?</i>\"");
	
	outputText("\n\nYou have to admit, the change is sudden and drastic... but the girl's scales, her eyes, they're certainly " + flags[kFLAGS.HELSPAWN_NAME] + "'s.  ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("And the puppy ears, now more wolf-like, are a dead giveaway.  Utterly unique to her.  ");
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
	helScene.helSprite();
	flags[kFLAGS.HELSPAWN_DISCOVER_BOOZE] = 1;
	outputText("As you're moving through camp, you notice Hel's away from her little nook - probably off visiting the family, seeing as her cloak's gone.  You wouldn't have given her part of camp a second look, except for a sudden whiff of brimstone and burning brewery on the wind.  Cocking an eyebrow, you creep over to Hel's still, quiet as ");
	if(player.race() != "cat-boy" && player.race() != "cat-girl") outputText("a cat");
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
	helScene.helSprite();
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
	helScene.helSprite();
	outputText("\"<i>Move over, you,</i>\" you say, sliding down beside your little salamander as you pop the tap open again.  \"<i>Gotta pace yourself, see,</i>\" you add, taking a long draught before closing it off again, savoring the potent taste of Hel's mighty brew.");
	outputText("\n\n\"<i>Wha...?</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " starts to say, before catching on as you drink, inviting her to join you.");
	outputText("\n\n\"<i>The trick is,</i>\" you say, letting your daughter get back under the tap, \"<i>You gotta build up your tolerance.  Your mom's been drinking like a fish for a decade; you can't just dive in and expect to do what she does.  You have to pace yourself.</i>\"");
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " nods slowly, slurping up a cheek-full of beer before you switch out with her again.  While she doesn't have a mouth full of Hel's distillery, you pass her a waterskin, telling her that the more water she drinks, the less shit she'll feel later on.  She drinks eagerly, switching off with you time after time until your entire world seems like a blur and your muscles seem like leaden weights far beyond your control.  You're both utterly shit-faced, giggling and stumbling by the time you manage to pull yourself away from the nearly empty still.");
	outputText("\n\n\"<i>Hey, what gives,</i>\" a voice snaps from somewhere beyond your hazy sight.  It sounds mildly like a cat, though you can't tell why in your state.");
	
	outputText("\n\n\"<i>Uh...</i>\" you groan, slumping over onto your [ass].  " + flags[kFLAGS.HELSPAWN_NAME] + "'s right behind you, collapsing on top of you in a pile of ");
	if(flags[kFLAGS.HELSPAWN_DADDY] != 1) outputText("red ");
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
	helScene.helSprite();
	outputText("As you make your way back to camp, you begin to hear the sounds of fighting from ahead.  Readying your [weapon], you pick up the pace until your campsite comes into view.  You relax, seeing that it's only " + flags[kFLAGS.HELSPAWN_NAME] + " and her mother.  Helia's standing near the center of camp, ");
	if(camp.companionsCount() > 3) outputText("apparently having cleared out most of your other followers for the moment, ");
	outputText("her sword held at a guard pose between herself and a training dummy. " + flags[kFLAGS.HELSPAWN_NAME] + " stands a few feet behind her mother, watching intently as Hel paces around the dummy, breathing hard.");
	
	outputText("\n\nSuddenly, the towering salamander screams a deafening battlecry and lunges forward, nearly topping the dummy in a mad bull rush before swinging her scimitar in a flurry of crushing blows that send bits of pieces of dummy flying in all directions.  There isn't much left by the time Hel's finally finished with it, slumping over the fallen mannequin as she huffs and puffs, completely out of breath.");
	
	outputText("\n\n\"<i>Okay, let me... Lemme go pick up the, uh, pieces and then you try, sweetie,</i>\" Hel says, picking up the dummy's severed arm.");
	
	outputText("\n\n\"<i>Hi, " + championRef() + ",</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says cheerily as you wander over, inspecting the carnage.  \"<i>Mom's teaching me how to be a berzerker.</i>\"");
	
	outputText("\n\nHel chuckles to herself, \"<i>Yep.  Probably gonna need a new dummy, though.  They, uh, appear to have a low survival rate...  hey, any chance you could float me a loan, lover mine?  Got a friend in town who found a sword just like mine, and I'd love for " + flags[kFLAGS.HELSPAWN_NAME] + " to have it.  Kinda strapped for cash at the moment, though. Dad's place sprung a leak, had to get that fixed.</i>\"");
	
	outputText("\n\nWell.  You suppose you could float Hel a loan and let little " + flags[kFLAGS.HELSPAWN_NAME] + " grow up as a furious salamander berzerker just like dear old mom.  Or, if you have the time, you could instead do her combat training yourself.  You probably can't completely get rid of the 'mander temper, but a few hours in the ring with you would certainly make her less brazenly reckless - something Hel could benefit from, too, if she's willing to stick around.");
	//{If PC has a bow & skill 100+}: 
	if(player.statusEffectv1(StatusEffects.Kelt) >= 100) {
		outputText("\n\nThen again, while the little salamander needs to be able to defend herself, it might be better to give her a more defensive weapon altogether.  The guards of your village called the bow the wise man's weapon, as the archers sat behind the lines or atop high walls, picking off enemies.  While you weren't trained with it back home, you've gotten pretty good with your bow during your time here.  Perhaps it's time to pass on those skills to " + flags[kFLAGS.HELSPAWN_NAME] + ".");
	}
	menu();
	if(player.statusEffectv1(StatusEffects.Kelt) >= 100) addButton(2,"Bow",snipermanders);
	addButton(0,"You Train",swordAndBoardmander);
	addButton(1,"Loan",dasBarbarimander);
	
}

//Archery (Dat Snipermander)
private function snipermanders():void {
	clearOutput();
	helScene.helSprite();
	flags[kFLAGS.HELSPAWN_WEAPON] = "bow";
	outputText("You tell Hel to take a break: you've got this handled. Grabbing your bow and quiver from over your shoulder, you hand them over to ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your");
	else outputText("Hel's");
	outputText(" eager daughter. " + flags[kFLAGS.HELSPAWN_NAME] + " takes them up with surprising reverence, holding them as gingerly as glass.  Grinning, you clasp her shoulder and tell her how to put the quiver on, and get her stance right for shooting.  It takes her a moment to get set up: her scaled, reptilian legs don't naturally stand in the shooting pose you've adopted");
	if(player.lowerBody == LowerBody.LIZARD) outputText(", even with your own lizard legs");
	outputText(", and you find yourself having to correct her grip on the haft several times.  But, finally, you get her ready to shoot.");
	
	outputText("\n\nYou slip behind " + flags[kFLAGS.HELSPAWN_NAME] + ", putting your arms on hers as you guide her through nocking an arrow, head resting on her fist, a lone finger outstretched toward the dessicated dummy.");
	
	outputText("\n\nBreathing hard, the young salamander draws back the bowstring, lining up on her target.  She chews on her lower lip, eyes squinting, deep in concentration, wanting to make this first shot count - to make you proud.  She looses the arrow, and gasps as it bolts away with lethal force... and sails across camp, well away from the target.");
	//If Rath is @ camp:
	if(player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("  You hear your old alchemist friend suddenly putting up a ruckus as the sounds of breaking glass echo throughout camp.  " + flags[kFLAGS.HELSPAWN_NAME] + " looks up at you nervously, but you ruffle her fiery hair and tell her to try again. Rath is probably just fine.");
	//else if Valeria/Latexy is at camp: 
	else if(flags[kFLAGS.VALERIA_AT_CAMP] == 1) outputText("  You hear a sudden yelp of pain from across camp. Valeria slithers up to you with an irritated look on her gooey face, pointing an accusing finger at an arrow sticking out of her tit.  \"<i>Dammit, [name], I'm a googirl, not a pin cushion!</i>\"  You wave her off, and tell " + flags[kFLAGS.HELSPAWN_NAME] + " to try again.");
	else if(latexGooFollower()) outputText("  You hear a sudden yelp of pain from across camp.  " + flags[kFLAGS.GOO_NAME] + " slithers up to you with an irritated look on her gooey face, pointing an accusing finger at an arrow sticking out of her tit.  \"<i>Dammit, [name], I'm a googirl, not a pin cushion!</i>\"  You wave her off, and tell " + flags[kFLAGS.HELSPAWN_NAME] + " to try again.");
	
	outputText("\n\n\"<i>I-I dunno, " + championRef() + ",</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " whines, biting her lip as she traces the arrow's path with her eyes.  \"<i>Maybe mom was right. I should just stick to a sword. That's easy....</i>\"");
	
	outputText("\n\nYou sigh and tell her to try again.  She can't expect to be perfect on the first try, after all.  It takes a little convincing, but soon you've got " + flags[kFLAGS.HELSPAWN_NAME] + " back into form and nocking an arrow.  You put your hands on hers, helping the young salamander take aim, drawing down on her straw-stuffed target.  Barely audible over " + flags[kFLAGS.HELSPAWN_NAME] + "'s nervous breathing, you whisper, \"<i>Take it easy.  Relax.... Good.  Take aim... now breathe out.  Exhale and loose.</i>\"");
	
	outputText("\n\nAgain, " + flags[kFLAGS.HELSPAWN_NAME] + " lets an arrow fly - and this one strikes true.  You watch the missile streak across camp, slamming into the training dummy's crotch with deadly force.  It sways, buckles, and falls to pieces.");
	
	outputText("\n\n\"<i>Ouch,</i>\" Hel laughs, sipping on her flask behind you.  \"<i>What'd that poor dummy ever do to you?</i>\"");
	
	outputText("\n\n\"<i>I did it!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " shouts, pumping her fist in the air. Her mother reaches over to ruffle her fiery hair, and you both shower her with congratulations.");

	outputText("\n\nBefore she can get cocky, though, you push the bow back into her hands.  \"<i>Lesson 2, kiddo: one shot is never enough.</i>\"");
	
	outputText("\n\nBy the time " + flags[kFLAGS.HELSPAWN_NAME] + " has her shooting stance back, her mother's already set the dummy back up, ready for round two.  It's several hours long before the three of you quit: time spent drilling " + flags[kFLAGS.HELSPAWN_NAME] + " on stance and aim, even going a round with her and a pair of daggers to remind her that enemies will eventually close in if she's not careful.  She learns quickly, though, and soon she hardly needs your help to plant an arrow in the target's chest.");
	
	outputText("\n\nA few hours like this every night, and ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your ");
	else outputText("Hel's ");
	outputText("daughter will be a warrior worthy of her parent");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("s");
	outputText("."); 
	doNext(camp.returnToCampUseOneHour);
}

//Teach Her {Sword and Boardmander}
private function swordAndBoardmander():void {
	clearOutput();
	helScene.helSprite();
	flags[kFLAGS.HELSPAWN_WEAPON] = "scimitar and shield";
	outputText("You tell Hel to take a break: you've got this handled.  You grab some kindling and string from your supplies, and a few minutes later you've got a pair of small, vaguely sword-like practice weapons pieces together.  Tossing one to the young salamander, you tell her to come get some.");
	
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " gives the blade a few practice swings before grabbing the wooden blade in both hands and charging at you.  You put your guard up, catching her first overhand blow and turning it aside, nearly toppling the girl over.  She rolls with it, spinning out of your guard and trying a strike from the side.  You parry it, catch an opening, and give her a nice wallop on the shoulder.  A real blade would have nearly cut her arm off, but " + flags[kFLAGS.HELSPAWN_NAME] + " merely stumbles back, yelping in pain.");
	
	outputText("\n\n\"<i>Again,</i>\" you say, assuming your fighting stance.");
	
	outputText("\n\nShe lunges, yelling a warcry as she slashes for your throat.  You nimbly dodge aside, letting her tumble through the space you occupied a moment ago, giving her a swat on the ass as she flies by.  She flops to the ground, eating dirt and rubbing her butt.");
	
	outputText("\n\n\"<i>Owwww.  No fair.  Hold still, " + championRef() + "!</i>\"");
	
	outputText("\n\nYou sigh.  \"<i>Again.</i>\"");
	
	outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " picks herself up and grips her blade.  This time she's a little more cautious, approaching slowly, pausing just out of reach.  You hide a grin and bring your own sword up, the tips of your blades nearly touching.  \"<i>Good.  No need to be reckless, kiddo.  Don't just charge in at the first opportunity; you'll get yourself killed.</i>\"");
	
	outputText("\n\n\"<i>Get " + player.mf("him","her") + ", " + flags[kFLAGS.HELSPAWN_NAME] + "!</i>\" Hel calls from the sidelines, sipping on a mug.  \"<i>Show " + player.mf("him","her") + " what a salamander can do!</i>\"");
	
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("\n\nYour");
	else outputText("\n\nHer");
	outputText(" daughter braces herself, drawing a breath just a second before she launches her attack, giving herself away.  You parry three quick blows, stepping back as " + flags[kFLAGS.HELSPAWN_NAME] + " leaps into another overhand strike.  You dodge, spinning out of the attack and slicing her right across her bare belly.");
	
	outputText("\n\n\"<i>Gah!</i>\" she cries, stumbling to her knees.  \"<i>I-I can't...</i>\"");
	
	outputText("\n\nYou pull " + flags[kFLAGS.HELSPAWN_NAME] + " to her feet and ruffle her hair.  \"<i>C'mon kiddo, don't give up.  Here,</i>\" you say, grabbing a dinner plate and some leather straps from your kit.  In a moment, you've got a rudimentary shield cobbled together.  You fit it over the young salamander's free arm and give her a few pointers on stance.  Nervously, she brings her makeshift shield to bear against you, fidgeting under the heft of it as you make a few slow, easy to parry swings for her to get used to it.  Steadily you pick up the pace, swinging your training sword faster and harder, forcing " + flags[kFLAGS.HELSPAWN_NAME] + " to parry and block, retreating against your onslaught.  You keep it up for a full minute before relenting, letting the kid seize the initiative.  She swings at you, rolling with each parry you make, cleaving into another swing, turning your ripostes aside with her shield and forcing you back.");
	outputText("\n\nYou wince in pain as " + flags[kFLAGS.HELSPAWN_NAME] + " manages to nick you, turning one of your blows aside with her shield and striking through the opening left in your guard.  \"<i>Alright, alright,</i>\" you laugh, rubbing your shoulder.  \"<i>Good job, " + flags[kFLAGS.HELSPAWN_NAME] + ". You're getting the hang of that shield!</i>\"");
	
	outputText("\n\n\"<i>Thanks, " + championRef() + "!</i>\" the little salamander grins, hugging you.");
	
	outputText("\n\n\"<i>Alright, alright,</i>\" Hel says, grabbing the dummy sword from your hand.  \"<i>Now it's time to fight a REAL warrior, " + flags[kFLAGS.HELSPAWN_NAME] + ". Come get some!</i>\"");
	
	outputText("\n\nIt's several hours long before the three of you quit: time spent drilling " + flags[kFLAGS.HELSPAWN_NAME] + " on stance and parrying, trading off with Helia every few rounds to keep ");
	if(flags[kFLAGS.HELSPAWN_DADDY] != 0) outputText("her");
	else outputText("your");
	outputText(" daughter on her toes.  She learns quickly, though, and soon she hardly needs reminding to keep her shield up and stance braced against Helia's overwhelming assaults.");
	
	outputText("\n\nA few hours like this every night, and ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your ");
	else outputText("Hel's ");
	outputText("daughter will be a warrior worthy of her parent");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("s");
	outputText(".");
	//{HelSpawnChaste +10}
	flags[kFLAGS.HELSPAWN_PERSONALITY] -= 10;
	doNext(camp.returnToCampUseOneHour);
}

//Berzerker (Das Barbarimander)
//{if PC has 200 gems}
private function dasBarbarimander():void {
	clearOutput();
	helScene.helSprite();
	flags[kFLAGS.HELSPAWN_WEAPON] = "scimitar";
	if(player.gems >= 200) {
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
	helScene.helSprite();
	flags[kFLAGS.HELSPAWN_FUCK_INTERRUPTUS] = 1;
	outputText("\nSomething's moving in your camp.");
	
	outputText("\n\nYour eyes flicker open as a scaled foot moves past your face, hushed breathing barely concealing a giggle.  Another foot, this time a shimmering blue-black, moves past.  You ");
	if(player.weaponName != "fists") outputText("clutch your [weapon]");
	else outputText("ball your fists");
	outputText(" as the intruder passes by, ready to defend yourself and your loved ones.  The moment they're out of reach, you roll onto your [feet], looking around for signs of a massed demon attack.  Instead, you see the outline of " + flags[kFLAGS.HELSPAWN_NAME] + " in the dying embers of the fire light, leading what looks like a spider girl by the hand toward her bed.");
	
	outputText("\n\nYou creep closer, trying to get a closer look at what your ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
	else outputText("ward ");
	outputText("is doing.  Well, it doesn't take a genius to figure that out, really, but still, you have to be sure.  You slide right up to them, just out of their lines of sight, as " + flags[kFLAGS.HELSPAWN_NAME] + " turns around, letting the spider-kin unclasp her bra and grab her tits, squeezing the small mounds as " + flags[kFLAGS.HELSPAWN_NAME] + " suppresses a moan, reaching back to slip a hand into the spider's crotch, grabbing her - his dick.");
	
	outputText("\n\nWell then. You suppose you ought to go stop " + flags[kFLAGS.HELSPAWN_NAME] + " from making a whore of herself... but then again, she's old enough to make her own mistakes by now.");
	if(player.cor >= 50) outputText("  And by mistake you clearly mean old enough to get her ass fucked in by a cute little spider trap... you contemplate jumping in on it, but with a sigh figure it's " + flags[kFLAGS.HELSPAWN_NAME] + "'s catch.  Let her enjoy it.");
	menu();
	addButton(0,"Stop Them",helSpawnStopFucking);
	addButton(1,"Do Nothing",helspawnDoNothing);
}

//Do Nothing
private function helspawnDoNothing():void {
	clearOutput();
	helScene.helSprite();
	outputText("You turn around and head back to your bed.  As soon as you're under your blanket, your ears are assaulted with the quiet moans and grunts of pleasure coming from " + flags[kFLAGS.HELSPAWN_NAME] + "'s bed as she and her first little boyfriend get it on.  You can practically hear the tail-pegging from here.  How cute!");
	//{HelspawnSlutty +10}
	flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
	doNext(playerMenu);
}

//Stop Them
private function helSpawnStopFucking():void {
	clearOutput();
	helScene.helSprite();
	outputText("You sigh and step out of the shadows, grabbing the feminine little spider boy by the shoulder and yanking him away from " + flags[kFLAGS.HELSPAWN_NAME] + ".  \"<i>And just what the hell do you two think you're doing?</i>\" you yell, scowling ");
	if(player.tallness >= 90) outputText("up ");
	else if(player.tallness <= 72) outputText("down ");
	outputText("at your ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
	else outputText("ward ");
	outputText(". " + flags[kFLAGS.HELSPAWN_NAME] + " gives a shrill cry of surprise and tumbles away from you, trying to cover herself as best she can; the spider trap squirms in your unrelenting grasp, one set of arms covering his rapidly-wilting erection as the other flails around, trying to get you off of him.  Not happening.");
	
	outputText("\n\n\"<i>You!</i>\" you say, pointing an accusing finger at " + flags[kFLAGS.HELSPAWN_NAME] + ".  \"<i>What the hell, kid?  Who the fuck is this?</i>\"");
	
	outputText("\n\n\"<i>That's, uh.... Alex, meet ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("my dad");
	else outputText("[name]");
	outputText(". " + championRef() + ", Alex.</i>\"");
	
	outputText("\n\n\"<i>H-hi.</i>\" the spider mumbles, his voice high and adorably girly.");
	
	outputText("\n\n\"<i>And you!  You leave my girl alone, you hear me?  Leave.  Her.  ALONE!</i>\"");
	
	outputText("\n\n\"<i>B-but I...</i>\"");
	
	outputText("\n\n\"<i>" + championRef() + "...</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " groans as you grab the spider boy and toss him out of camp, watching with hawk-like eyes as he slinks back to his jungle.  When he's gone, you sigh and walk over to " + flags[kFLAGS.HELSPAWN_NAME] + ", wiping a tear from her cheek.  Putting an arm around her shoulder, you give her a long, long talk about not being a whore.");
	
	outputText("\n\n\"<i>B-but mom...</i>\"");
	
	outputText("\n\n\"<i>That's why you </i>shouldn't<i> be bringing men home.  Or women.  Or anything else, kiddo.");
	//If No Hel Love:
	if(flags[kFLAGS.HEL_LOVE] != 0) outputText("  You don't want to be a whore like your mother, do you?  The girl that everyone's had a ride with.");
	//if HelLove:
	if(flags[kFLAGS.HEL_LOVE] == 1) outputText("  I'm not going to a raise a whore, " + flags[kFLAGS.HELSPAWN_NAME] + ".  Your mother's made mistakes, sure, but...</i>\" you sigh.  \"<i>");
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
	helScene.helSprite();
	outputText("You wake up the next morning, and soon find your eyes drawn to where " + flags[kFLAGS.HELSPAWN_NAME] + " lies, barely an arm's reach from her mother's hammock, still snoring peacefully.  You sigh wistfully as you get up and get dressed, still thinking of the night before and your girl's little misadventure with the spider.  God, she's grown up fast.  Faster than you could have imagined - or her mother, for that matter.  Helia, too, is still reeling from her daughter's rapid, mutagenic growth.  But there's nothing to be done about that, now, and it seems she's reached what passes for adulthood in this strange world.  She's had the body of a woman for some time now, and it seems the mind and desires of one as well.");
	
	outputText("\n\nA part of you is sad to see her all grown up, and now you know it's time to treat your ");
	
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
	else outputText("ward ");
	outputText("like a woman.  The time to raise her, to shape her development, is over.  You can only hope you've done a good enough job to keep her safe in this hellish world; to give her sound judgment and the abilities she'll need to protect herself in the years and adventures to come.");
	
	outputText("\n\n<b>" + flags[kFLAGS.HELSPAWN_NAME] + " has been added to the Followers menu!</b>");
	flags[kFLAGS.HELSPAWN_AGE] = 3;
	flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] = 0;
	flags[kFLAGS.HELSPAWN_DAD_EVENT] = flags[kFLAGS.HELSPAWN_DADDY] == 1 ? 30 :
		flags[kFLAGS.HELSPAWN_DADDY] == 2 ? 20 : 0; //set countdowns for non-PC dad events
	doNext(camp.returnToCampUseOneHour);
}


//Helspawn’s Main Menu @ Camp [Followers Tab]
public function helspawnsMainMenu():void {
	clearOutput();
	outputText("You call " + flags[kFLAGS.HELSPAWN_NAME] + " over to you and she comes running, ");
	if(player.tallness <= 72) outputText("grabbing you off your [feet] and clutching you in a tight hug");
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
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(2,"Spar",sparHelspawn);
	//[Sex]; bipeds only, lust must be high, incest must be flagged active, and player must have a dick.
	if (incestEnabled()) {
		if (flags[kFLAGS.HELSPAWN_INCEST]) addButton(3, "Sex", sexHelspawn)
			.hint("Oh, what is it? Probably some unique button for debug game versions!")
			.disableIf(player.lust < 33, "Not aroused enough.")
			.disableIf(!player.isBiped(), "You have to be biped, sorry.")
			.disableIf(!player.hasCock(), "Req. a cock.");
		else addButtonDisabled(3, "???", "You should talk to her first.")
	}
	//[Appearance]
	addButton(8,"Appearance",helSpawnsAppearanceScreen);
	addButton(14,"Back",camp.campFollowers);
}

//Sex. Now you can finally fuck your daughteru! Savin can go suck a fat cock and cry little bitch tears.
private function sexHelspawn():void {
	clearOutput();
	sceneHunter.print("Forks for Helspawn's personality");
	var x:int = player.biggestCockIndex();
	var y:int = player.biggestCockIndex2();
	var z:int = player.biggestCockIndex3();
	var playerCameBeforeRiding:Boolean = false; //for tracking during sex
	sexStart();

	function sexStart():void {
		//INTRO TEXT
		outputText("You decide that it’s high time you and" + flags[kFLAGS.HELSPAWN_NAME] + " share a little quality time together. As if sensing your intention she gives you an inviting smile, one you feel mirrored in your own" + player.face() + ". \n \n");

		if (player.tallness < 72) {
			outputText("You reach up and take " + flags[kFLAGS.HELSPAWN_NAME] + "'s cheek in your hand. The gentle caress of your fingers causes her to shiver with longing. The young woman stands before you with her ");
			if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("golden");
			else if (flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("bright green");
			else outputText("crimson");
			outputText(" eyes lit up like stars. She stares into your own eyes with all the adoration in the world as she leans in to kiss your lips. ");
		} else if (player.tallness >= 72 && player.tallness < 96) {
			outputText("You stand eye to eye with " + flags[kFLAGS.HELSPAWN_NAME] + " as you frame her face in your hands. She reaches up to tug a stray lock of hair from her face moments before you press your lips against hers. You hold her close as you kiss, and she releases a soft moan as she melts into your arms. ");
		} else if (player.tallness >= 96) {
			outputText("You reach down and wrap little " + flags[kFLAGS.HELSPAWN_NAME] + " up in your arms. She softly moans against your " + player.chestDesc() + " as the two of you hold each other tightly. She then looks up into your " + player.face() + " with eyes bright as stars as she stands on her toes to kiss your lips. ");
		}
		outputText("Once the kiss is over you ask her if she wants to spend a little quality time with you. \n \n");

		outputText(flags[kFLAGS.HELSPAWN_NAME] + " smiles as she answers with a simple, \"I’d like that, " + championRef() + ".\" \n \n");

		outputText("The young lady watches you disrobe. You strip as sensually as your " + player.armorName + " will allow, showing off your form and moving to music only you can hear. You even throw in a few sexy dance moves you saw others do in Ingnam. Your exotic display has " + flags[kFLAGS.HELSPAWN_NAME] + " all a twitter as she shivers with longing. When you’re finally in the buff " + flags[kFLAGS.HELSPAWN_NAME] + "’s eyes drink in your naked form with open hunger. You proudly display " + player.cockDescript() + " as well as your " + player.buttDescript() + " for her viewing pleasure. Then you thrust your " + player.chestDesc() + " forward and flex your biceps for her. She claps in appreciation of your show, squirming as her arousal takes hold. \n \n");

		outputText("Now that it is her turn to strip she stands, tall and proud, and begins to shed her own clothes. \n \n");

		if (flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) {
			outputText(flags[kFLAGS.HELSPAWN_NAME] + " reaches behind her, chest thrust forward while she unsnaps the clasp of her scale bikini top. As she allows said top to fall she reveals her twin knockers with a seductive little shimmy. You can’t help reaching forward and pulling her by the waist, taking a single nipple into your mouth. You suck and nibble on her tit for a moment before she turns away with a giggle. She bends forward seductively and slowly lifts her tail. She begins to slowly slide her scaled bikini bottom off of her very enticing ass. The squishy glorious globes of her ass distort slightly as the garment moves across her skin, soft flesh reforming as the garment slides off. The tight bud of her tailhole is uncovered moments before her glistening sex is revealed. All inches away from your face. The scent of your little girl’s arousal wafts around you, a scent so sweet it makes your mouth water. \n \n");
			outputText("\"Fuck yes, " + championRef() + "\" she groans as you take a moment to rub and tease her holes, both in need of a good long fuck.");
		} else {
			outputText(flags[kFLAGS.HELSPAWN_NAME] + " takes a moment to unbutton her sky blue blouse before sensually pulling it off, a coy smile playing on her lips. The blouse falls to reveal a single fancy white lace bra. She reaches backward and with a simple motion undoes the clasp. She holds the bra, slowly sliding it down to reveal the gentle curve of her bosom. You reach forward, taking her by the waist and tasting her pert nipples, tugging and sucking them with wet lips until she turns away, blushing. She takes a moment to undo her skirt. The clothing falls to reveal the soft mounds of tender flesh upon which she sits every day. She works her hips as she pulls down soft white lace panties, revealing her rear entrance and tender glistening womanhood for your viewing pleasure. The scent of your little girl’s arousal wafts around you, a scent so sweet it makes your mouth water. \n \n");

			outputText("\"Yes, " + championRef() + "\" she gasps as you take a moment to massage her naked bottom, cupping the squishy flesh and spreading it to see her two waiting entrances.");
		}

		outputText("You lean in with every intention of tasting her but she steps away, apparently ignorant of your desire to taste her. It seems great minds think alike, however; she turns to face you and kneels before you as if you were some royal king and she was your humble servant. \n \n");
		doNext(sexOralHelspawn);
	}

	function sexOralHelspawn():void {
		clearOutput();
		//ORAL SEX TEXT

		if (player.hasVagina()) {
			outputText("Helspawn begins by pushing your thighs up and out of her way. She takes one look at your [vagina] and licks her lips before leaning and giving you a gentle teasing lick right next to your moistening lady bits. She teases you for what seems like forever, licking your [skin] and making you shiver and groan. \n \n");
			outputText("Once you’re begging for it she gives your glistening lips a single smooth lick. As her tongue glides across your feminine opening your body begins to heat up. She slurps across your [clit] and rubs her face in your folds, with a beautiful smile. \n \n");
		}

		if (player.balls > 0) {
			outputText(flags[kFLAGS.HELSPAWN_NAME] + " reaches forward and moves [eachCock] out of her way. With her free hand she cups your ");
			if (player.balls == 1) outputText("ball, pulling it up as she plants a wet kiss on your orb. She buries her face in your sac, basking in the scent of your masculine genitalia. Soft wet lips gently tug at your ball, swirling your cum factory around in her mouth and making you grind your sac into her lips.");
			else outputText("balls, pulling them up as she plants a wet kiss on each orb. She buries her face in your sac, basking in the scent of your masculine genitalia. Soft wet lips gently tug at your balls, swirling your cum factories around in her mouth and making you grind your sac into her lips. \n \n");

			outputText("\"<i>Oh... so much bottled up cum.</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says with a soft moan, \"Is all of this just for me, ");
			outputText(championRef());
			outputText("?\" As you answer her with a nod as your " + player.face() + " spreads into a gracious smile. Satisfied with your answer she smiles broadly before leaning in and massaging your ");
			if (player.balls == 1) outputText("ball");
			else outputText("balls")
			outputText(" with that hot, talented tongue of hers. [eachCock] jumps as she gently pulls a single sensitive orb into her hot wet mouth. She orally caresses each one in turn, not leaving your cream filled balls alone until your body is cringing against her lips. Then she gazes up at you, her ");
			if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("golden");
			else if (flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("bright green");
			else outputText("crimson");
			outputText("eyes locking onto you with a smile as her mouth sits poised above [eachCock]. \n \n");
		}

		if (player.cockTotal() < 3) sceneHunter.print("Check failed: cocks up to 3.")
		if (player.cockTotal() == 1) {
			outputText("With her lips spread wide " + flags[kFLAGS.HELSPAWN_NAME] + " drags her tongue across the belly of your " + player.cockDescript(x) + " with exaggerated slowness. Then her tongue lashes at your " + player.cockDescript(x) + " one moment before soft hands pull your dick down so that she may tickle the cum slit with that wonderful tongue of hers. She rubs your " + player.cockDescript(x) + " across her face, happily smearing your leaking precum across her features. Her ecstasy filled eyes drink in your naked form as she works. She is hungry to please you, to make you feel so good you explode in her mouth. \n \n");
			outputText("\"<i>Good girl.</i>\" You sigh, grabbing your " + player.cockDescript(x) + " to rub it against her outstretched tongue. The wet surface combined with the increased heat of her fiery aura causes your " + player.cockDescript(x) + " to jump against her puckered lips as she suck at your " + player.cockDescript(x) + ". Her fiery breath bathes your nethers as she begins to kiss your shaft, each smooch ending in a loud sucking noise. When she reaches your [cockHead] she takes a moment to suck at the cumslit, drinking your pre-cum as if it’s the tastiest meal in the cosmos. \n \n");
		} else if (player.cockTotal() == 2) {
			outputText(flags[kFLAGS.HELSPAWN_NAME] + " takes hold of [eachCock] with a grin. She listens intently as you groan while she presses your two dicks together. She massages your twin shafts and you have to admit it feels heavenly, the way [eachCock] rubs together while wrapped in both of her soft warm palms. As you react to the sensations she drags her tongue up the crevice formed by " + player.cockDescript(x) + " and " + player.cockDescript(x) + " she makes sure to keep them steady even though your body is not. When her soft, hot, perfect thumb smears precum across the head of your " + player.cockDescript(x) + " while tasting your " + player.cockDescript(x) + " with her tongue you almost lose it. \n \n");
			outputText("Instead you groan. \"<i>Good girl.</i>\" while thrusting [eachCock] against her mouth. Her grip tightens and together with her lips she begins to go up and down your shaft, forming a three walled orifice that is both alien and perfect. You begin to tremble again as her lips slather heated spit across the belly of your two cocks while her hands press them together, the three sensations causing your body to thrust as if fucking soft triangle of flesh. After giving you free rein to do as you will she pulls back, licking your tasty precum from her lips.\" \n \n");
		} else if (player.cockTotal() >= 3) {
			outputText(flags[kFLAGS.HELSPAWN_NAME] + " reaches forward and pulls your " + player.cockDescript(x) + " into her lips, suckling the [cockHead]. Then her hands wraps around your " + player.cockDescript(y) + " and your " + player.cockDescript(z) + ". The sight of her pleasing 3 of [eachCock] combined with the sensation of soft hands, tight grips and a wet tongue has you bucking against her. She hums against your " + player.cockDescript(x) + " for a second before she wraps her arms around the base of [eachCock], pulls them together and rubs her soft face in them all. You revel in her dripping tongue, her heated gasps and her vibrating lips as she hums and kisses you a cock at a time. You call out, your voice breaking as you are hit with waves of euphoric delight that cause you to almost lose control. She eases up, allowing you to come back from the brink as she looks up at you with bright eyes. \n \n");
		}

		outputText("\"Oh " + championRef() + ",\" She says with a smile as she takes your " + player.cockDescript(x) + " into her hand, \"<i>I love you so much.</i>\" You say it back, meaning every word. Before you can expand on how much you love " + flags[kFLAGS.HELSPAWN_NAME] + " she opens up and sucks you in so quickly you’d swear her mother was a cock milking machine if you didn’t already know better. \n \n");

		if (player.cockArea(x) <= 27) outputText("You begin to howl as she slides your entire " + player.cockDescript(x) + " into her mouth without hesitation. She bobs for a moment, your " + player.cockDescript(x) + " shining with her saliva as she engulfs you again and again. Then she slides your " + player.cockDescript(x) + " to the front of her divine lips and begins swirling her tongue around your sensitive " + player.cockHead() + " before diving back down. She repeats this torturous practice, enveloping your " + player.cockDescript(x) + " in her hot wet orifice again and again. \n \n");
		else if (player.cockArea(x) < 36 && player.cockArea(x) > 27) outputText("Your " + hipDescript() + " buck as " + flags[kFLAGS.HELSPAWN_NAME] + " takes you into her mouth. When your " + player.cockHead(x) + " reaches the back of her throat she swallows, pulling you into her mouth with a wet slurp and a gulp. It takes every ounce of willpower you have not to fuck her face as she slobbers up and down your length. Slurp, gulp, slurp, gulp and with every swallow your body cringes into her talented throat as it wraps you up and pulls you in dick first. She even buries her face in your groin, inhaling your scent as she swallows your " + player.cockDescript(x) + " whole. \n \n");
		else if (player.cockArea(x) >= 36) outputText("However, she barely gets past your " + player.cockHead() + " before she starts having trouble. Watching her try to stuff your entire length into her mouth turns you on something fierce. You take a hold of her fiery red hair and gently tug her off, a silent command for her to slow down and take her time. After you slow her lips to a speed she’s comfortable with she continues to work you over, unperturbed. Your big " + player.cockDescript(x) + " can’t fully fit inside her mouth but it doesn’t matter, she still has you trembling with need as you appreciate the amount of skill involved in her oral machinations. \n \n");

		if (player.cocks[x].cockType == CockTypesEnum.DOG) outputText("She pulls your " + player.cockDescript(x) + " up and gives your knot a tender kiss. The kiss quickly evolves into loud sucking that has you trembling. She plays with your knot, lashing its sensitive surface with her hot tongue and nibbling at it with wet lips. The combination of her hot breath, her warm hands and her wet tongue has you on edge. \n \n");
		else if (player.cocks[x].cockType == CockTypesEnum.CAT) outputText("She giggles as she twirls the nubs of your cat dick in her hand. Then she drags her gloriously hot tongue against the surface before reversing and swirling her tongue around each barb. She gently pinches the tip, squeezing pre out of your slit and licking the copious liquid from your drooling and spit shined " + player.cockDescript(x) + ". The combination of her hot breath, her warm hands and her wet tongue has you on edge. \n \n");
		else if (player.cocks[x].cockType == CockTypesEnum.HORSE) outputText("She slides a hand across the segments of your " + player.cockDescript(x) + ". Each time she does the odd sensation forces your hips to buck. Then she begins nibbling at them, drooling across the surface of your " + player.cockDescript(x) + " before loudly sucking it back up. She kisses your cum slit and hums as she sucks more pre into her hungry lips. The combination of her hot breath, her warm hands and her wet tongue has you on edge. \n \n");
		else if (player.cocks[x].cockType == CockTypesEnum.TENTACLE) outputText(flags[kFLAGS.HELSPAWN_NAME] + " groans as she works your living pecker over. She traps it like prey and lashes her tongue across its writhing belly. It rewards her with juice which she laps up and sucks from the " + player.cockHead() + ". She growls with it poking around inside her lips, vibrating her mouth as her tongue wrestles with your excited " + player.cockDescript(x) + ". The combination of her hot breath, her warm hands and her wet tongue has you on edge. \n \n");
		else outputText("She takes a moment to explore your " + player.cockDescript(x) + " further. Her convulsion inducing lips drool on your " + player.cockDescript(x) + " before loudly sucking it up. She shines your knob with kisses so sweet each gentle smooch is accompanied a deep sound that vibrates your " + player.chestDesc() + ". Her smooth lips begin to glide across your cock’s surface, leaving no stone unturned and no nook unexplored. Then her wet tongue lashes the belly of your quivering " + player.cockDescript(x) + " over and over again. The combination of her hot breath, warm hands and wet tongue has you on edge. \n \n");

		outputText("She keeps you near climax for a while, easing off to give you a brief respite before surging forward and pushing you back toward the brink. She plays your " + player.cockDescript(x) + " like a musician with her favorite instrument. Every strum of your quivering rod releases a tender note of ecstasy, every breath ends in music. She’s a skilled virtuoso whose every movement produces art in the form of your strained voice. \n \n");

		outputText("It quickly becomes apparent that " + flags[kFLAGS.HELSPAWN_NAME] + " doesn’t mind staying here, like this, with you. You’re tempted to let her, the way she’s sliding up and down your " + player.cockDescript(x) + " is flooding your entire being with sexual euphoria. You have to gather all of your remaining mental strength to tug her off so you won’t unintentionally flood her mouth. \n \n");

		outputText("She remains kneeling after your trembling hands have pulled her away from [eachCock]. She patiently watches as you take deep slow breaths to calm yourself down. Once you’ve mastered your quaking libido you lower yourself to " + flags[kFLAGS.HELSPAWN_NAME] + "’s height and give her a deep kiss. As you snake your tongue into her mouth you push her onto her back. \n \n");

		outputText("\"Yes " + championRef() + ".\" She groans as you nuzzle her neck, sucking the tender flesh and making her grind against your body. You paint a trail of wet kisses down to her pert tits. You stay there a moment, sucking her erect nipples into your mouth whilst your hands massage her waist. She cringes as you tickle and tease her, giggling like a schoolgirl as she begs for your " + player.cockDescript(x) + ". \n \n");

		outputText("But you have other things in mind. Besides, you know after that blow job you’re going to need a few more minutes to settle down. Wanting to enjoy your quality time for as long as possible, you begin to trail a second trail of sweet kisses down her inner thigh. She tenses once she figures out what it is you’re planning on doing. \n \n");

		outputText("" + flags[kFLAGS.HELSPAWN_NAME] + " shudders the moment your drag your tongue across her inner thigh. You kiss the spot and she groans in frustration. You tease her with quiet breaths that shudder and tickle her glistening womanhood. You spread your tongue and slide it across her inner thigh, reveling in the shivering flesh as it tickles your tongue. You constantly come dangerously close to her feminine fruit only to float away, tracing complicated designs onto her inner thigh and soft tummy with your tongue. \n \n");

		outputText("You keep this up until her glistening pussy is practically flooding itself in anticipation of the moment you finally give it a good licking.  \n \n");

		outputText("\"" + championRef() + " please.\" She whines with a sexy edge to her voice when she can take no more. \n \n");

		outputText("So you press her legs back to further spread her glistening lips. Her clitoris is a hard pearl reaching for your lips so you give it a lick. " + flags[kFLAGS.HELSPAWN_NAME] + "’s entire body jerks at the brief contact. You lay flat against the ground as you wrap your lips around that hard pearl and suck it. " + flags[kFLAGS.HELSPAWN_NAME] + "’s body convulses and shivers and you hang on, rolling your neck and enjoying the ride on her thighs. \n \n");

		outputText("You press your lips into her wet sex and massage her nether lips with yours. You growl against it, vibrating her flooding pussy. You pay attention to every gasp, groan and thrilling scream " + flags[kFLAGS.HELSPAWN_NAME] + " releases as you work her over. Then her legs suddenly clasp around your neck, trapping you in this position as she reaches down and smashes your head into her pussy, obviously lost in ecstasy.  \n \n");

		outputText("If that’s how she wants to play... you’re game. \n \n");

		outputText("You redouble your efforts, sucking a hot beverage of lady cum from her tingling gash with the ferocity of a man dying of thirst. You nibble at her clit, you french kiss her nether lips and suddenly she’s gushing a fountain of pale fluid that tastes every bit as sweet as candy. \n \n");

		outputText("Above you " + flags[kFLAGS.HELSPAWN_NAME] + " is screaming like a woman possessed, her body gyrating as if she is mid seizure. She holds you against her squirting pussy with a grip like iron. Your " + player.face() + " is pressed against her hot sex and being showered by her sweet ejaculant. Once the sugary fountain has subsided she releases you and you rise. Her face is suffused with a soft glow of pure elation as she thanks you over and over again with a lazy smile. \n \n");

		outputText("You grin down at her, saying, \"But " + flags[kFLAGS.HELSPAWN_NAME] + "... I’m not done yet.\" \n \n");

		outputText("With that you take a hold of her legs and spin her around. She rolls over and, at your command, rises to her knees. You shove your " + player.face() + " into the squishy mounds of her soft round asscheeks.  \n \n");

		outputText("\"<i>That feels so... Weird.</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says with a giggle, even as she presses her hungry ass against your thrusting tongue. You make a point to loudly slurp and suck her exposed back door, reveling in the pristine condition of the tight opening. With your hands you spread her voluptuous cheeks apart to get a better angle. That’s all it takes for a tortured thrilling scream to fill the air. " + flags[kFLAGS.HELSPAWN_NAME] + " grunts and groans, trembling as you make her ass feel \"weird\". Your hand lands with a smack on her ass and you watch the mound of flesh jiggle with carnal delight. You’re raring to go, [eachCock] rock hard and dangling between your legs as you prepare her tight back door for entry. She begins to shudder against your lips as your oral attention drives her up the wall. \n \n");

		outputText("You begin to alternate, greedily dragging your tongue between her still wet pussy across her swollen taint to kiss her hungry asshole. When you finally rise from her dripping pussy and puckered asshole she looks back at you as if seeing you through a haze of sexual desire.");

		doNext(sexDoggyHelspawn);
	}

	function sexDoggyHelspawn():void {
		clearOutput();
		//DOGGY STYLE TEXT
		outputText("On your knees you place [eachCock] between the soft pliable mounds of " + flags[kFLAGS.HELSPAWN_NAME] + "’s cheeks. You slowly thrust, reveling in the heated sensation caused by slowly moving against her soft cheeks. She groans beneath you and arches her back in obvious invitation. You reach forward and feel her dripping sex, collecting her juices which you allow to drip across [eachCock]. \n \n");
		sceneHunter.selectSingleMulti(singleF, multiF);

		function singleF():void {
			outputText("\"After your " + player.cockDescript() + " is glistening with " + flags[kFLAGS.HELSPAWN_NAME] + "’s sweet ambrosia you aim its leaking head at her drenched vaginal lips, entering her with a groan. \n \n");

			if (player.longestCockLength() <= 8) {
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + " swoons as you slide into her sensitive feminine entrance, pushing into her wet pussy with ease. She grins back at you as she curls her scaly tail around your waist, a gesture you’re sure is a positive one. Her entrance is soaked, slick lady cum from her previous orgasm making sliding through her pulsing tunnel all the more pleasurable. Each stroke sends a tingle through your body as she clenches, squeezing your cock internally as she presses against your slow full length thrusts. \n \n");

				outputText("\"<i>Oh, ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText("!</i>\" She says, looking over her shoulder with a grin, \"<i>Fuck me good.</i>\" \n \n");

				outputText("Not being one to disappoint your little girl you lean forward and press your lips against hers. As her tongue snakes into your mouth you speed up. Soon your thrusts are filling the air with the slapping noise of rapid fucking. She breaks the kiss once the sensations become too much and begins throwing her pussy back against your hard thrusts. Beneath you " + flags[kFLAGS.HELSPAWN_NAME] + " whoops and hollers like she’s on a rollercoaster. Soon her joyful sounds gain a familiar edge to them and you know she’s close. You redouble your efforts, fucking her hard until she screams and her pussy is gushing around your still thrusting " + player.cockDescript() + ".\" \n \n");
			} else if (player.longestCockLength() > 8 && player.longestCockLength() <= 12) {
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + " groans as you press into her sensitive feminine entrance, your " + player.cockHead() + " spreading her nether lips apart as it tunnels deep into her vaginal sleeve. Her pussy is soaked as you submerge your dick in the tight embrace of her quivering sex. You sit there for a moment, allowing " + flags[kFLAGS.HELSPAWN_NAME] + " to appreciate the full length of your " + player.cockDescript() + ". Her tail wraps itself around your waist just as you begin to slide in and out of her drenched pussy. " + flags[kFLAGS.HELSPAWN_NAME] + "’s voices slowly rises as she quickly loses herself in the sensation of your slow, full length thrusts. \n \n");

				outputText("\"<i>Yes ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText(".</i>\" Her voices is a fluttering note of ecstasy, \"<i>Oh... fuck me good.</i>\" \n \n");

				outputText("Not being one to disappoint your little girl you lean forward and press your lips against hers. As you snake your tongue into her mouth you speed up. Each thrusts starts with a hard smack that reverberates through her body at lightning speed until it comes out of her mouth in a soul aching groan that vibrates your tongue. She groans and gasps against your lips, struggling to maintain the oral connection as you fuck her brains out. Soon her lips part from yours as she releases a thrilling note. You can tell from the quivering of her womanhood that she’s close. Her voice comes out in fluttering groans and deep gasps. You redouble your efforts, fucking her harder until she screams as her pussy gushes around your still thrusting " + player.cockDescript() + ".\" \n \n");
			} else if (player.longestCockLength() > 12 && player.longestCockLength() <= 18) {
				outputText(flags[kFLAGS.HELSPAWN_NAME] + " grunts you press into her sensitive feminine entrance. You have to work your " + player.cockHead() + " into her with a gentle rocking motion. It’s slow work but very rewarding as her pussy quivers around your " + player.cockDescript() + " while it massages her insides until they allow it to advance. Once you’ve buried the entirety of your " + player.cockDescript() + " into her vaginal walls " + flags[kFLAGS.HELSPAWN_NAME] + " begins to sing a soft song of shaking moans and shuddering gasps. Her tail wraps around your waist, something you’re sure is to help her control the pace of your thrusts. So you begin to move and her voice begins to ring out, rising and falling in time with your slow, full length thrusts. \n \n");

				outputText("\"Oh... ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText("... I... FUCK ME!\" She screams into the air. \n \n");

				outputText("Not being one to disappoint your little girl you lean in and press your lips against hers. She accepts your tender kiss with a slavish hunger but the moment you begin thrusting harder she drops the kiss, unable to maintain the tender gesture as you fuck her into rapid convulsions. She screams as each hard thrust reaches deep into her feminine sleeve and forces her open. You can tell from the edge in her screams that she’s close. Sure enough soon her shrill voice speaks as her pussy gushes around your still thrusting " + player.cockDescript() + ".\" \n \n");
			} else if (player.longestCockLength() > 18) {
				outputText(flags[kFLAGS.HELSPAWN_NAME] + " tenses as your " + player.cockDescript() + " tunnels into her sensitive vaginal sleeve. It is clear from the way her pussy stretches around your " + player.cockHead() + " that you’re pushing her to the limit. Being as patient as possible you begin the slow work of massaging your " + player.cockDescript() + " into the quivering folds of her tight vagina. The way her vaginal walls squeeze your dick more than makes up for the amount of time it takes to open her up. Once you’ve managed to bury an acceptable amount of your " + player.cockDescript() + " into her pussy you hold, allowing her to get accustomed to the sensation of being filled to the max. \n \n");

				outputText("As you wait for her to adjust to your size her tail hesitates around your waist, possibly to help her control your speed when you start thrusting. You tell her to take slow, deep breaths and once you feel as if she can continue you begin to slide your " + player.cockDescript() + " in and out of her pussy with slow, full length thrusts that make her entire body convulse in pleasure. \n \n");

				outputText("\"Ahh... fuh... FUCK me, ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText("!\" She practically screams. \n \n");

				outputText("Not being one to disappoint your little girl you lean forward and press your lips against hers. She kisses you passionately, your lips moving together as you slowly increase speed. Once you’re at a decent pace she pulls away from the kiss, her body twitching with every downward stroke. Your trunk never reaches her thighs because, despite her slick pussy drenching itself, you’re just too big. You soon fuck her into rapid convulsions, her voice a constant reminder of how good you’re making her feel. You can tell she’s close when her body begins to tremble uncontrollably. Sure enough moments later her pussy clenches and quivers, gushing around your still thrusting " + player.cockDescript() + ".\" \n \n");
			}
			if (player.longestCockLength() < 18) sceneHunter.print("Get a bigger cock~");

			outputText("Once her orgasm has subsided she reaches back and pulls your [face] into hers, kissing you passionately. \n \n");

			if (flags[kFLAGS.HELSPAWN_HADSEX] == 0) {
				//first time only
				outputText("At this point your curiosity peaks as she rubs her ass against you, her soaked vagina squeezing around your embedded " + player.cockDescript() + ". Wouldn’t it be nice to slip into her other hole, to feel its tight embrace wrapped around your cock as your little " + flags[kFLAGS.HELSPAWN_NAME] + " squeezes and groans? If she’s anything like her mother she’ll definitely enjoy it. When you make your proposition you feel the tip of her tail slide down your backside and dip into the crevice of your " + player.buttDescript() + ". \n \n");

				outputText("\"<i>Okay, ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText(",</i>\" she says, still breathless from your recent exertions, \"<i>You can play with mine, but I want to play with yours.</i>\" She says with a grin as she presses the tip of her tail against your " + assholeDescript() + ". You can’t help but verbally note the obvious differences between your " + player.cockDescript() + " and her tail. To which she replies, \"<i>You can set the pace... I’ll just follow your lead. I’ll go as deep as you go and as fast as you go.</i>\"");
			} else {
				//repeatable
				outputText("At this point a thought occurs to you. The first time you and " + flags[kFLAGS.HELSPAWN_NAME] + " shared a little quality time it was at this point that the two of you made your propositions. " + flags[kFLAGS.HELSPAWN_NAME] + " must be having similar thoughts because before you can react or make any offer you feel her tail slip into the crevice of your " + player.buttDescript() + ", just like last time. \n \n");

				outputText("\"You know what I want, ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText(",\" she says with a sly grin.");
			}

			outputText("\n \n <i>(You can let " + flags[kFLAGS.HELSPAWN_NAME] + " peg you with her tail while you fuck her in the ass, or abandon the idea of anal sex and let her ride you instead.)</i>");
			sharedEnd();
		}

		function multiF():void {
			outputText("You take a moment to rub her dripping lady juice onto [eachCock], specifically focusing on your " + player.cockDescript() + " and " + player.cockDescript() + ", getting them nice and lubed up for what you have planned. Sure the blowjob was probably enough but a good parent spares no expense for their little girl. From the looks of things her tight rear has seen more action than her wet vagina, probably due to self tail pegging during masturbation. You simply shake your head at how much like her mother she is as you finish lubing up your cocks. \n \n");

			outputText("With your " + player.cockDescript() + " in hand, you press your " + player.cockHead() + " up against " + flags[kFLAGS.HELSPAWN_NAME] + "’s rear entrance. She swoons as you rub your slick cock against her pristine back entryway, your chest swelling with pride at how good her hygiene is. Then you tighten your grip and enter her, slowly. \n \n");

			if (player.longestCockLength() <= 10)
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + "’s face curls into a big sexy grin as you push into her rear passage. Sliding your " + player.cockDescript() + " into her welcoming tailhole is like pushing into a tight glove that quivers and massages you just right. The heat is sweltering which only serves to further swell your " + player.cockDescript() + ", making you harder and more eager to fuck her in every way she loves. You give a few experimental strokes, making sure she’s used to having your " + player.cockDescript() + " inside her eager tail hole. \n \n");
			else if (player.longestCockLength() > 10 && player.longestCockLength() <= 18)
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + " gasps as your " + player.cockDescript() + " begins to tunnel into her rear passage. It takes a little patience and a little work but thanks to your persistence and the mixture of spit and ladycum you glazed all over your rigid pole you make good time. Rocking your hips you push deeper and deeper until your trunk softly mashes against her upturned squishy cheeks. She groans as you hold yourself inside the tight sweltering embrace of her perfect anal sleeve. Her passage quivers around you, massaging your deeply embedded " + player.cockDescript() + " perfectly as she adjusts to your size. \n \n");
			else if (player.longestCockLength() > 18)
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + " grunts as your " + player.cockHead() + " invades her unaccomodating tailhole. You hear the air leave her mouth in one long sigh, letting you know she’s filled to bursting. You hold yourself steady with just your " + player.cockHead() + " buried inside her quivering anal sleeve, waiting for her to adjust. Once she’s gotten used to the sensation you begin to rock your hips back and forth, gently working your cock deeper into the tight sweltering tunnel that is " + flags[kFLAGS.HELSPAWN_NAME] + "’s gorgeous ass. Once you’ve managed to dip as much of your " + player.cockDescript() + " inside of her as you can she gasps. You simply hold yourself inside her dangerously tight hole, patiently waiting for her insides to adjust. When they do you give her a few experimental strokes, reveling in the heat of her blatant arousal as she makes furious sounds of growling pleasure with your every movement. \n \n");

			outputText("You’re tempted to just fuck her like this but instead you reach around and grab your " + player.cockDescript() + ", especially since you have better plans. \n \n");

			outputText("With your slickened " + player.cockDescript() + " in hand, you take a second to enjoy the view. Your " + player.cockDescript() + " is deep inside " + flags[kFLAGS.HELSPAWN_NAME] + "’s spread cheeks, the meaty cushions parting beautifully. She looks back at you, catching your eye and licking her lips as if she knows exactly what you have planned. With her tail hole stuffed full of your " + player.cockDescript() + " you pull your " + player.cockDescript() + " up and line it up with her dripping vaginal opening. \n \n");

			if (player.cocks[y].cockLength <= 8) outputText("You push forward, penetrating " + flags[kFLAGS.HELSPAWN_NAME] + "’s vaginal opening as your " + player.cockDescript() + " pushes deeper into her anal canal. She squeezes both of your embedded cocks with her internal muscles and looks back at you, eyes bright with desire. She wants you so bad her lip quivers as you effortlessly sink into her wet pussy.");
			else if (player.cocks[y].cockLength > 8 && player.cocks[y].cockLength <= 12) outputText("You push forward, penetrating " + flags[kFLAGS.HELSPAWN_NAME] + "’s vaginal walls as you push deeper into her anal canal. She gasps, looking back at you with " + eyeColor() + " eyes glazed over with lust as you sink into her dripping pussy. \n \n");
			else if (player.cocks[y].cockLength > 12) outputText("You push forward, stretching " + flags[kFLAGS.HELSPAWN_NAME] + "’s vaginal walls apart with your " + player.cockDescript() + ". She trembles as your " + player.cockDescript() + " tunnels into her. She wiggles her bottom, the size of your cock combining with the dual sensation to make her twitch. You simply hold yourself inside of her until you feel she’s able to take the pounding you’re about to give her. \n \n");

			outputText("With your cocks deeply embedded in both of " + flags[kFLAGS.HELSPAWN_NAME] + "’s holes you begin to slide in and out. It is a veritable heaven. Your " + player.cockDescript() + " is inside a tight canal suffused with heat that massages it as it moves in and out of its welcoming embrace. Meanwhile your " + player.cockDescript() + " is embraced by her dripping wet cleft. \n \n");

			outputText("You start out slow, reveling in the mind-blowing sensations of dual penetration as you slide in and out of " + flags[kFLAGS.HELSPAWN_NAME] + " with a huge grin. Her body quivers against you, combining with her sexy voice to tell you this is exactly what she wants. Taking her by the hips you pull, slowly stuffing her full of your " + player.cockDescript() + " and " + player.cockDescript() + " in one long stroke. \n \n");

			outputText("\"<i>Fuck.</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " gasps softly when you begin to pick up the pace, each thrust hitting her harder than the last. First she simply tenses, then she begins to take deep breaths, after that her voice begins to pierce the sky. Then, once you’ve reached top speed, she begins to cum. You can’t help but feel proud of the way she’s able to handle your unchecked passion and you know you’ll soon be flooding both of her holes with plenty evidence of how good of a job she is doing. \n \n");

			outputText(flags[kFLAGS.HELSPAWN_NAME] + " violently trembles as the dual sensations bring her to climax again and again. For countless moments you keep up the pressure, bringing her back to back release as she claws the ground and begs for mercy. The vision of her beautiful trembling, sweat covered body is only exceeded by the feeling of her vaginal and anal walls gripping your " + player.cockDescript() + " and " + player.cockDescript() + " while flooding your trunk with her sweet smelling lady cum. \n \n");

			outputText("You toss your head back as the rushing feeling of imminent ejaculation takes you over. Your thrusts are suddenly harder, your muscles tense and your entire body shudders as [eachCock] bursts, filling both of " + flags[kFLAGS.HELSPAWN_NAME] + "’s holes with your magnificent baby batter. \n \n");

			if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("Daddy");
			else outputText(championRef());
			outputText("! " + flags[kFLAGS.HELSPAWN_NAME] + " cries out and over as your cum starts to pour into her. ");

			if (player.cumQ() < 800)
				outputText("As your orgasm rages on " + flags[kFLAGS.HELSPAWN_NAME] + " twitches in pleasure, inadvertently causing your cocks to pop out. [eachCock] continues to spurt, sending thick ropes of cum splashing into the ground and over " + flags[kFLAGS.HELSPAWN_NAME] + "’s scaled legs. Soon the torrents expelling from [eachCock] reduces to a dribble, leaving a large puddle of hot dick juice rapidly cooling around " + flags[kFLAGS.HELSPAWN_NAME] + "’s knees. \n \n");
			else if (player.cumQ() >= 800)
				outputText("As your orgasm rages on " + flags[kFLAGS.HELSPAWN_NAME] + " twitches in pleasure, inadvertently causing your cocks to pop out. [eachCock] continues to shoot massive loads of hot baby batter. Like waves, each jet of hot cum breaks across " + flags[kFLAGS.HELSPAWN_NAME] + "'s soft ass and scaled legs. After what seems like days your climax begins to diminish, leaving a small lake of hot seed rapidly cooling around " + flags[kFLAGS.HELSPAWN_NAME] + "’s cum splattered form. \n \n");

			outputText("Breathing as if you’ve just run a mile you take a few steps back and take a seat on a nearby rock. As you strive to catch your breath " + flags[kFLAGS.HELSPAWN_NAME] + " rises and follows you with a happy grin. She sits on your lap and wraps her scaly legs around your waist, smearing and dripping your own cum across your crotch and thighs where she settles and trapping your cocks in the soft but messy cleft of her ass. She simply embraces you, her head lying on your shoulder as she listens to you breathe.");
			playerCameBeforeRiding = true;
			sharedEnd();
		}

		function sharedEnd():void {
			menu();
			addButton(0, "Anal", sexAnalHelspawn);
			addButton(1, "Riding", sexRidingHelspawn);
		}
	}

	function sexAnalHelspawn():void {
		clearOutput();

		if (flags[kFLAGS.HELSPAWN_HADSEX] == 0) {
			//first time only
			outputText("You find the idea intriguing. You tell " + flags[kFLAGS.HELSPAWN_NAME] + " that you’d enjoy that as you reach down and begin stroking your " + player.cockDescript() + ". Her tailhole still glistens with your spit from earlier which will make the tight looking anal ring easier to penetrate. You take aim and dip your [cockHead] into her raised and waiting tail hole. The moment you enter her, her powerful tail enters you. \n \n");
		} else {
			//repeatable
			outputText("You answer " + flags[kFLAGS.HELSPAWN_NAME] + "’s offer without words, you simply spread your legs and lean forward, pushing your " + player.cockDescript() + " into her still spit slickened tail hole. The moment you enter her, her powerful tail enters you. \n \n");
		}
		sceneHunter.print("Forks for both butt looseness and main cock size");

		if (player.longestCockLength() <= 10) {
			outputText("As you push smoothly into " + flags[kFLAGS.HELSPAWN_NAME] + "’s tight anal ring her tail slides into you for about the same length. \n \n");

			if (player.ass.analLooseness <= AssClass.LOOSENESS_NORMAL) {
				outputText("Being somewhat of a stranger to taking anal penetration, you slowly begin to fuck " + flags[kFLAGS.HELSPAWN_NAME] + ". Her tail moves through you, causing you to wince and clench, trapping the tail inside the vice-like grip of tight your anal ring. \n \n");

				outputText("\"Uh ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText("...\" " + flags[kFLAGS.HELSPAWN_NAME] + " says with a look over her shoulder, \"<i>You don’t do this often do you?</i>\" You shake your head in affirmation, \"<i>Alright, I’ll just have to give you a lil help then.</i>\" \n \n");

				outputText("With that said she pushes deeper into your " + assholeDescript() + ". The feeling of her tail slipping into your " + assholeDescript() + " is an odd combination of discomfort and pressure. Before you can decide if you like the sensation or not " + flags[kFLAGS.HELSPAWN_NAME] + " begins rocking back and forth, forcing you to take her tail while she milks your " + player.cockDescript() + ". The odd dual sensation are a strangely erotic combination of mind-numbing pleasure and slight discomfort. Your " + player.cockDescript() + " revels in the glory of the tight spit slick hole using it to fuck itself. Meanwhile your [asshole] shudders as if unable to decide whether the sensations it feels are pleasurable or not. Then " + flags[kFLAGS.HELSPAWN_NAME] + " hits something inside you and your hips buck. \n \n");

				outputText("\"<i>Found it!</i>\" She says in triumph. She begins tail pegging your " + player.buttDescript() + " and fucking herself with gusto. Whatever she is hitting inside you has your entire body begging for release, especially when combined with the slapping of your bodies together as her squishy full ass engulfs your " + player.cockDescript() + " again and again. You’re not sure you can hold on much longer. \n \n");
			} else if (AssClass.LOOSENESS_STRETCHED > player.ass.analLooseness && player.ass.analLooseness > AssClass.LOOSENESS_NORMAL) {
				outputText("Being neither a newbie nor a master at taking anal penetration you fuck " + flags[kFLAGS.HELSPAWN_NAME] + " at a moderate pace. Just as she promised she begins sliding her tail into your " + assholeDescript() + ", matching your pace stroke for stroke. Once you feel your backside can take a little more your leisurely thrusts slowly begin to speed up. Her tight asshole flexes and milks your " + player.cockDescript() + " as her tail manipulates your prostate. Once you’ve reached top speed both of your voices begin to rise and fall in time with your thrusts. Your tail filled asshole and asshole filling " + player.cockDescript() + " are pushing you over the edge. Instead of slowing down to prolong the moment you speed up, working towards your climax with sloppy thrusts as her tail pounds your " + player.buttDescript() + ". \n \n");
			} else if (player.ass.analLooseness >= AssClass.LOOSENESS_STRETCHED) {
				outputText("Being somewhat of an expert at taking anal penetration you begin to fuck " + flags[kFLAGS.HELSPAWN_NAME] + " as hard as you can. True to her word her tail begins spreading your " + assholeDescript() + " wide open. The dual sensations of her gloriously tight hole milking your " + player.cockDescript() + " and her rough tail spreading your " + assholeDescript() + " wide are starting to get to you. Throwing caution to the wind you fuck her harder, working towards your climax with sloppy thrusts as her tail pummels your backside. \n \n");
			}
		}
		if (player.longestCockLength() > 10 && player.longestCockLength() <= 18) {
			outputText("As you push into " + flags[kFLAGS.HELSPAWN_NAME] + "’s tight anal ring her tail slides into you for about the same length. She holds her tail at the same angle and depth you hold your " + player.cockDescript() + " inside of her. Your body shudders at the dual sensations of having a tight hole wrapped around your " + player.cockDescript() + " while you yourself are being penetrated. \n \n");

			if (player.ass.analLooseness <= AssClass.LOOSENESS_NORMAL) {
				outputText("You grunt at the feeling of being penetrated so deeply, but " + flags[kFLAGS.HELSPAWN_NAME] + " doesn’t seem to have a problem. Her anal sleeve is warm, tightly clinging to the surface of your " + player.cockDescript() + ". \n \n");

				outputText("When you don’t move she laughs, \"You don’t have a lot of experience in that area, do you ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText("?\" \n \n");

				outputText("You shake your head and ask her what gave you away. \n \n");

				outputText("She smiles at you over her shoulder, \"<i>Well try to relax and remember to breathe.</i>\" She says matter of factly before adding, \"<i>...and try to hold still, I got this.</i>\" \n \n");

				outputText("With that she begins to push back slowly, engulfing your " + player.cockDescript() + " as she pushes her tail deeper into your " + player.buttDescript() + ". Your body jerks and you wonder why anyone would want something this big inside of their " + assholeDescript() + ". As if reading your thoughts " + flags[kFLAGS.HELSPAWN_NAME] + " groans, your " + player.cockDescript() + " is nowhere near the length of the tail she pegs herself with so it’s no wonder she’s enjoying herself. Your " + player.cockDescript() + " feels like it’s fucking a spit slick tunnel of bliss while your " + assholeDescript() + " feels like it’s being forcibly invaded. You do your best to hold still as she fucks herself with your cock while filling your rear entrance. Soon the alien feeling is replaced by an odd combination of discomfort and pressure. You can’t deny that the feeling of her tail sliding through you is somewhat pleasurable. Then her tail hits something that causes your " + player.cockDescript() + " to jump inside her. \n \n");

				outputText("\"<i>Found it!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " exclaims as she begins using your " + player.cockDescript() + " to fuck herself roughly while pegging you with her tail. With every incursion she hits that glorious spot inside you that makes you shiver. You can’t help moving your hips, fucking down into " + flags[kFLAGS.HELSPAWN_NAME] + "’s soft squishy ass even as she roughly pounds yours. The sight of your hard thrusts rippling through her gorgeous ass is one to behold. Combined with the dual sensations you can’t help but feel as though this is going to be over soon. \n \n");
			} else if (AssClass.LOOSENESS_STRETCHED > player.ass.analLooseness && player.ass.analLooseness > AssClass.LOOSENESS_NORMAL) {
				outputText("Being neither a master nor a newbie to taking anal penetration you fuck her at a slow pace. The way she matches your size has you pacing yourself but as soon as you’re used to the depth to which she plunges into your " + assholeDescript() + " you decide it’s time to speed up. Stroke by stroke you thrust faster until you’ve reached full speed. The dual sensations of fucking and being pegged have your body shuddering between thrusts. Beneath you " + flags[kFLAGS.HELSPAWN_NAME] + " is in a state of supreme bliss. The way her tight spit slick tailhole milks your " + player.cockDescript() + " while her tail manipulates your " + assholeDescript() + " has you dangerously close to the edge. \n \n");
			} else if (player.ass.analLooseness >= AssClass.LOOSENESS_STRETCHED) {
				outputText("Being no stranger to taking anal penetration you begin to fuck " + flags[kFLAGS.HELSPAWN_NAME] + " as hard as you can. " + flags[kFLAGS.HELSPAWN_NAME] + " makes good on her promise and begins pumping her tail in and out of your " + assholeDescript() + ". Your voices blend together as you both are filled with the mind-numbing rapture of your rapid coitus. Throwing caution to the wind you fuck her hard, reveling in the feeling of her tail manipulating your prostate while her ass milks your " + player.cockDescript() + ". You know it won’t be long now and you fuck towards your own climax with the fury of an animal. \n \n");
			}
		}
		if (player.longestCockLength() > 18) {
			outputText("When you push into " + flags[kFLAGS.HELSPAWN_NAME] + "’s tight anal ring her tail slides into you for about the same length. You both grunt as you’re entered. Your " + player.cockDescript() + " is nothing to be taken lightly so you allow her to take a second to get used to its length and girth. Meanwhile your body shudders at the dual sensations of having a tight hole wrapped around your " + player.cockDescript() + " while you yourself are being penetrated. \n \n");

			if (player.ass.analLooseness <= AssClass.LOOSENESS_NORMAL) {
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + "’s tail is so deep inside you’re having second thoughts. The way she is trying to push even deeper to match the depth to which you’re penetrating her has you flinching with every movement of her tail. \n \n");

				outputText("\"<i>You gotta relax, ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText("...</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says with a slight grimace. When you fail to follow her advice she arches her back, \"<i>Since you don’t do this often I’ll help you. Just sit back and try to relax, ok?</i>\" \n \n");

				outputText("Before you can answer her tail sends another surge through your body. She begins pushing her round ass back as she pushes her tail into your " + assholeDescript() + ". She moves slowly, allowing you to familiarize yourself with the sensation so that you may relax and enjoy it. You do your best to relax and soon she feels you’re good enough to speed up. Your breath comes out in ragged huffs as your mind is filled with the dual sensations. One is her glorious ass milking your cock with its hot, tight embrace and spit slick entrance. The other is her tail creating a mixed feeling of discomfort and pleasure. Then she hits something inside of you that causes you to cry out.  \n \n");

				outputText("\"<i>Found it!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " exclaims. She begins fucking herself on your " + player.cockDescript() + " while roughly pegging your " + assholeDescript() + ". The sudden change in pace makes you call out as you are assaulted by dual sensations of unbearable pleasure and undeniable fullness. She masterfully manipulates your prostate with every tail thrust while her eager asshole milks your " + player.cockDescript() + ". Soon you’re fucking her as hard as you can and she, despite the way she claws at the ground and screams in ecstasy, manages to peg you just as hard with her tail. As the two of you make messes of each other's rear entrances you know you won’t be able to hold on for long. \n \n");
			} else if (AssClass.LOOSENESS_STRETCHED > player.ass.analLooseness && player.ass.analLooseness > AssClass.LOOSENESS_NORMAL) {
				outputText("Being neither a master nor a newbie you begin taking it easy. Beneath you " + flags[kFLAGS.HELSPAWN_NAME] + " breathes a sigh of relief, you’d guess the two of you to have about the same experience level when it comes to this. The dual sensations of being pegged while her gorgeous ass takes the full length of your " + player.cockDescript() + " soon hit you like twin tidal waves of euphoria. Now that you’re used to the amount of tail being stuffed in your back door you begin to speed up. Thrust by thrust you fuck faster and faster until you’ve reached top speed. The glorious pressure of her tail manipulating your prostate combines with the mind-numbing euphoria of her sexy ass. Soon you’re trembling. You don’t know how much longer you can last. \n \n");

			} else if (player.ass.analLooseness >= AssClass.LOOSENESS_STRETCHED) {
				outputText("You revel in the fullness of the anal cocksleeve beneath you, as " + flags[kFLAGS.HELSPAWN_NAME] + " shivers. When you begin fucking her with hard full length thrusts she barely manages to keep up with your pace. As her tail slides in and out of your " + assholeDescript() + " you spread your legs, allowing it deeper and fucking her harder. The dual sensations are bliss. The way her tight asshole milks your " + player.cockDescript() + " alone would be enough to make you cum. When combined with the way her tail manipulates your swollen prostate from inside your " + player.buttDescript() + " it damn near brings a tear to your eye. As you continue to pound her while being pounded by her you feel your own climax quickly approaching. \n \n");
			}
		}

		if (player.cocks[x].cockType == CockTypesEnum.DOG) outputText("Even lost in passion as you are you’re careful to not shove your " + player.cockDescript() + " in to the knot. Merely banging the sensitive bundle of flesh against her rectal entrance is enough... for now. \n \n");

		if (player.cumQ() < 200) {
			outputText("With a groan you shove your " + player.cockDescript() + " in to the hilt and begin to unload. [eachCock] begins to fire as you tremble against her. " + flags[kFLAGS.HELSPAWN_NAME] + " squeezes your " + player.cockDescript() + " as she presses your prostate, prolonging your orgasm. When you’re done you have to push her eager tail away. When you tug your " + player.cockDescript() + " from her now gaping hole you can’t help but admire the cock cream dripping down her scaly ass cheeks and pooling in wet cunt. \n \n");

			outputText("As you work to catch your breath " + flags[kFLAGS.HELSPAWN_NAME] + " wraps her scaly legs around your waist and holds you close, trapping your " + player.cockDescript() + " in the soft cleft of her ass and laying her head on your shoulder, listening as you breathe. \n \n");
		} else if (200 <= player.cumQ() < 400) {
			outputText("Growling like a animal you shove your " + player.cockDescript() + " in to the hilt just as [eachCock] explodes. You can feel " + flags[kFLAGS.HELSPAWN_NAME] + " squeezing your " + player.cockDescript() + " with well-developed rectal muscles as her tail continues to bang into your prostate. The whole thing only serves to prolong the rapture that is your climax. As you tremble against her, you can feel your own hot jizz escaping her hole and running down your legs. When your orgasm has subsided her tail slips from your backside. When you pull your " + player.cockDescript() + " from her now gaping hole you see your baby batter has made quite the beautiful mess. It’s everywhere: on your legs, on her gorgeous ass, her scaly legs. Strings of cum even connect her thighs and drip from her glistening cunt. \n \n");

			outputText("As you try to catch your breath " + flags[kFLAGS.HELSPAWN_NAME] + " turns to wrap her scaly legs around your waist, trapping your " + player.cockDescript() + " in the soft but sticky cleft of her ass. She holds you close, her head lying on your shoulder as she listens to you breathe. \n \n");

		} else if (400 <= player.cumQ() < 800) {
			outputText("With a chest vibrating howl you shove in to the hilt just as [eachCock] explodes. She milks your spasming " + player.cockDescript() + " as she continues to pound your prostate, making you shake like a maraca as she prolongs the orgasmic sensations streaming through your body. You can feel your own ejaculant escaping from her asshole, the hot heavy cream soaking into your {skin/scales/fur} and sliding down your [legs] to your [feet]. Still trembling, you pull your " + player.cockDescript() + " from her and watch as your trapped baby batter cascades down her body now that you’re no longer plugging her ass. Everything from a few inches above her tail hole to her inner thighs is covered in your creamy white spunk. Strands connect her thighs as she kneels in an impressive puddle, yet still more leaks from her happy asshole. \n \n");

			outputText("As you strive to catch your breath " + flags[kFLAGS.HELSPAWN_NAME] + " rises and wraps her scaly legs around your waist, smearing your own cum across your crotch and thighs where she settles and trapping your cock in the soft but messy cleft of her ass. She simply embraces you, her head lying on your shoulder as she listens to you breathe. \n \n");
		} else if (player.cumQ() >= 800) {
			outputText("Your chest reverberates with a bestial roar as [eachCock] explodes. You cum blasts so forcefully into " + flags[kFLAGS.HELSPAWN_NAME] + "’s anal canal that she jumps in surprise, freeing your " + player.cockDescript() + " from her tight hole and causing you to unload all over her thighs and ass. Meanwhile her tail remains inside of you, still pushing against your prostate as you tremble against her. Your orgasm rages on for an eternity of bliss and soon you are standing in a small lake of your own spunk and, somehow, you’re still cumming. With a chuckle " + flags[kFLAGS.HELSPAWN_NAME] + " rises from the massive torrent still erupting from [eachCock] and kisses you. Her mouth massages your lips as you convulse from the enormity of your orgasm. Her entire lower half is glistening white and dripping as if she just got out of a cum shower. \n \n");

			outputText("She wraps her legs around your waist and holds onto you, dripping and smearing your own cum across your crotch and thighs where she settles, and trapping your " + player.cockDescript() + " in the soft but cum-drenched cleft of her ass as the last dregs of your titanic orgasm spill from [eachCock]. Once you’ve begun trying to catch your breath she simply lays her head against your shoulder and listens to your exhausted breaths. \n \n");
		}
		player.buttChange(40, true);
		player.sexReward("vaginalFluids", "Dick");
		doNext(postSexHelspawn);
	}

	function sexRidingHelspawn():void {
		clearOutput();
		//HELSPAWN RIDING TEXT

		if (playerCameBeforeRiding) {
			//if player already came (ie. player has 2+ cocks and gave DP)

			if (flags[kFLAGS.HELSPAWN_HADSEX] != 1) {
				//first time only
				outputText("With [eachCock] glazed with your seed you keep your little girl wrapped up in your arms. Squeezing her tightly your enjoy the gentle warmth emanating from her. She is so magnificent with her glistening scales and soft skin. The two of you slowly catch your breath in silence, enjoying the simple intimacy of the moment. Once you’ve both mastered your breathing she pulls back to get a good look at you. \n \n");

				outputText("\"<i>Wow, ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText(".</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says with a grin, \"<i>I just... wow. We should spend more quality time with each other. I mean look at me, I’m shaking!</i>\" \n \n");

				outputText("This causes you to chuckle because, for some reason, " + flags[kFLAGS.HELSPAWN_NAME] + " thinks the two of you are finished. You’re so turned on that [eachCock] are still standing on end in spite of the fact that you just came. You tell " + flags[kFLAGS.HELSPAWN_NAME] + " with a grin that your quality time isn’t over yet and watch a gorgeous smile of pure joy break across her face like a pale dawn. \n \n");
			} else {
				//repeatable scene
				outputText("With [eachCock] glazed with your own seed you keep your precious " + flags[kFLAGS.HELSPAWN_NAME] + " wrapped up tightly. Holding her close you revel in the warmth she exudes. She is such a beautiful woman with her glittering scales and sweat soaked skin. Once both of you have caught your breath and she smiles up at you, knowing what’s coming next. \n \n");

				outputText("You kiss her smiling lips, sliding [eachCock] against her as she sits upon your lap. She grinds down into you as she returns the kiss, her hot tongue snaking into your mouth and massaging yours. A moan vibrates your lips as she presses herself into you. She trusts you completely and why shouldn’t she? You are, after all, her ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText(" and she’s your little " + flags[kFLAGS.HELSPAWN_NAME] + ". \n \n");
			}
		} else {
			//if player didn't cum yet (ie. player has 1 cock and opted for riding over pegging)

			outputText("You reach back and pull the tip of " + flags[kFLAGS.HELSPAWN_NAME] + "’s tail away from your [ass]. She smiles like a good sport when you say that there won’t be any anal action today. \n \n");

			outputText("\"<i>Oh well,</i>\" she says with eyes full of mischief, giving your " + player.cockDescript() + " one last squeeze with her sopping wet vaginal walls before reaching back and sliding you out, painstakingly slowly. She turns, her naked form every bit as hypnotic as ever, and pushes you back to take a seat on a nearby rock. It's clear that she has a plan B as she straddles you, sitting just above your crotch and wrapping her scaly legs around your waist. \"<i>...Maybe next time,</i>\" she finishes in a sing song voice. \n \n");

			outputText("She giggles as your " + player.cockDescript() + " nestles between her butt cheeks, and the upperside of it presses against her cunt. " + flags[kFLAGS.HELSPAWN_NAME] + " pulls you into a deep kiss as she starts to grind her hot, moist need against your " + player.cockDescript() + ". For a moment you simply enjoy the sensation of rubbing against her, but before long the need to be inside her again is too much. \n \n");

		}
		sceneHunter.selectSingleMulti(singleF, multiF);

		function singleF():void {
			outputText("Reaching down, you take hold of your " + player.cockDescript() + " and put it back into " + flags[kFLAGS.HELSPAWN_NAME] + "’s salivating sex.  \n \n");

			if (player.longestCockLength() <= 8) {
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + " gasps as your " + player.cockDescript() + " pushes past her post orgasmic nether lips. She sits there with you inside her, squeezing your embedded tool with a look of supreme bliss on her face. She releases a soft moan, as she revels in the feeling of having your " + player.cockDescript() + " so deep inside of her. When she opens her eyes there is a smile on her lips as she looks down at you with all the adoration in the world. You give her a soft peck on the lips, a tender reward for looking so cute.  \n \n");

				outputText("\"<i>Mmmmm...</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says as she grinds around your hard dick, \"<i>...I love it when you’re inside me ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText("; it just feels so good.</i>\" \n \n");

				outputText("You give her another kiss, a silent gesture meant to say you agree. She is bliss wrapped around your " + player.cockDescript() + " and her voice is like sex for your [ears]. She’s so beautiful it hurts. \n \n");

				outputText("She bites her lip and begins bouncing up and down your rigid " + player.cockDescript() + ". Your bodies meet in a symphony of wet claps. Her gorgeous tits begin to undulate in circles as she engulfs your " + player.cockDescript() + " again and again. You marvel at her beautiful body, kissed with glistening sweat as she shrieks and moans. Unable to help yourself you begin thrusting up into her hungry pussy, driving her over the edge until her lady cum is spurting onto your belly and running down your [legs]. \n \n");

			} else if (player.longestCockLength() > 8 && player.longestCockLength() <= 12) {
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + " groans as your " + player.cockDescript() + " pushes past her vaginal lips. She descends slowly, gasping as she wiggles this way and that until your " + player.cockDescript() + " is once again deep inside of her, squeezing your embedded fuck pole as she looks down into your eyes. She silently revels in the elation caused by having your " + player.cockDescript() + " so deep inside of her. Sweat from your previous fuck still glistens across her skin and scales. She’s so sexy you can't help but fill her lips with yours, a groan from your lips vibrating her tongue as you suck it into your mouth. \n \n");

				outputText("When you release her she says, \"<i>");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("Daddy");
				else outputText(championRef());
				outputText("...</i>\" in a sexy voice as she grinds with your rigid cock still inside her slavering vaginal cocksleeve, \"<i>I love you so much ");
				if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daddy");
				else outputText(championRef());
				outputText(". I love having you so deep inside me.</i>\" \n \n");

				outputText("You respond with another kiss as you grind your tool around inside of her before lying back to enjoy your little " + flags[kFLAGS.HELSPAWN_NAME] + ". \n \n");

				outputText("She starts off at a moderate pace, riding you with sharp gasps and deep groans. Her pussy slurps up and down your " + player.cockDescript() + ". Slowly she begins increasing the tempo until she’s riding you so hard your body scoots across the rock you’re sitting on. Soon the wet claps of your bodies meeting ring out across the camp along with your deep groans and her high squeals. Unable to help yourself you begin thrusting upward into her wondrous pussy. As you begin to move she releases a shrill yelp and her pussy begins gushing lady cum that splashes across your stomach and soaks [eachCock], running down your legs. \n \n");

			} else if (player.longestCockLength() > 12) {
				outputText("" + flags[kFLAGS.HELSPAWN_NAME] + " grunts as your " + player.cockDescript() + " pushes past her vaginal lips. Despite your previous incursion she’s still pretty tight. So you have to take it slow and allow her to open back up. She tries to remain motionless as you grab her thighs and begin rock your " + player.cockDescript() + " into her quivering pussy. You can feel every fold as you gently work it open.  \n \n");

				outputText("\"<i>Ah!</i>\" She gasps once you’ve worked as much of your " + player.cockDescript() + " into her as you can. She rolls her hips and sings soft wordless declarations of pleasure as she keeps you inside of her. She looks down at you, her sexy eyes filled with lust as she rolls her hips. You’re deep inside her and she’s smiling. She’s ready. \n \n");

				outputText("She begins riding you slow, breathing deeply as her pussy is stretched wide by your " + player.cockDescript() + ". When she begins to pick up the pace it isn’t long before she is riding your " + player.cockDescript() + " like a champ. Her face is scrunched up as sweat glistens against her brow. Her tits swing in a circle as her pussy slurps up and down your " + player.cockDescript() + ". Then she’s suddenly quivering as her pussy sprays girlcum around your embedded cock. You fuck up into her gushing vagina, reveling in the way it spews her sweet smelling cum everywhere. It’s on your stomach, it’s sliding down your [ass] it’s even running down your [legs]. \n \n");
			}

			outputText("She squeals as you begin pulling her up and down your " + player.cockDescript() + ". You fuck her hard, drilling your erection into her gushing vaginal walls. She cums once, twice, again, once more. She keeps cumming as you grip her soft ass and pound her like there’s no tomorrow. She trembles, screaming and calling out your name to the heavens as you decimate her with unbearable waves of pleasure. \n \n");

			outputText("With girl cum cascading across your form like a waterfall you press yourself against " + flags[kFLAGS.HELSPAWN_NAME] + ". As your cum boils up into your shaft you wrap your arms around her, still fucking the juices out of her. Then your " + player.cockDescript() + " begins shooting into her. You grind your spurting cock into her gushing lady slit. Your voices blend together, harmonizing as you both cum. \n \n");

			if (400 <= player.cumQ() && player.cumQ() < 800) outputText("The volume of your orgasm proves to be too much for " + flags[kFLAGS.HELSPAWN_NAME] + "'s womb, and her belly swells as you cum. Trembling you hold onto her tightly as your " + player.cockDescript() + " continues to shoot load after load inside her, even after it begins to spill out and drip to the ground, creating a glistening puddle of spooge. \n \n");
			else if (player.cumQ() >= 800) outputText("The sheer volume of your climax is far too much for " + flags[kFLAGS.HELSPAWN_NAME] + "’s womb to contain. Her belly swells and her eyes roll back as your " + player.cockDescript() + " blasts massive jets of hot seed inside her. Your cum quickly begins to spill back out, splashing to the ground and creating a small lake of hot baby-batter as you hold onto her tightly, quivering with every spurt. \n \n");
			sharedEnd();
		}

		function multiF():void {
			outputText("Reaching down with both hands you hold up both your cum glazed " + player.cockDescript() + " and your cum dripping " + player.cockDescript() + ". \n \n");

			outputText("Still well lubricated from before with your seed and her girl cum, she slides onto both cocks at once, causing you to shudder in pleasure as her vaginal and anal lips engulf you simultaneously. She begins riding you slowly, wiggling her abdominals as she humps forward and backward. Each advance towards you causes her ass to squeeze your " + player.cockDescript() + " while each retreat causes her drooling pussy to massage your " + player.cockDescript() + ". She continues this for a few strokes before she adjusts her scaled feet. Then, looking down at you with lust filled eyes she begins to bounce. \n \n");

			outputText("It starts out slowly as the dual sensations prove too much for her. She trembles, trying to get you off but being too turned on to ride you like she wants to. So you help her along, getting a good grip of her soft ass cheeks and using your hands to speed her up.  \n \n");

			outputText("That’s all it takes. Without warning, she’s screaming as her pussy sends girl cum violently spurting across your lower body. It cascades down your [ass] and [legs] and soaks the ground with her lusty secretions. The sight alone is hot enough to make you blow but you hold on, wanting to see how many times your two cocks can make " + flags[kFLAGS.HELSPAWN_NAME] + " cum.  \n \n");

			outputText("She screams in agonized pleasure during the whole process. Most of its unintelligible but what you can make out are declarations of love and only makes you want to last longer, to bring her more pleasure. Her beautiful sweat-covered tits twirl in a circle as you make her ride hard. Her body trembles, her voice breaks: she’s coming again.  \n \n");

			outputText("She whimpers as you speed up. You do everything you can to hold on as you bring her to completion again and again, thinking of every cascade of lady cum as a victory. Each time she reaches a climax you almost break but through sheer force of will, you prevail again and again until she’s shrieking like a banshee and your seat is so soaked you feel like you’re about to slide off of it. \n \n");

			outputText("So you let go, howling as each spurt furiously rips through [eachCock] and explodes into your darling " + flags[kFLAGS.HELSPAWN_NAME] + ". \n \n");

			if (400 <= player.cumQ() && player.cumQ() < 800) outputText("As your huge loads of boiling cum shoot from [eachCock] " + flags[kFLAGS.HELSPAWN_NAME] + "’s belly begins to swell. She groans as she is filled up, rubbing her rounding belly with lust filled eyes. You can feel your own ejaculant oozing down your legs as her well-fucked holes fail to keep up with your huge volume of baby batter. Soon she almost looks pregnant. \n \n");
			else if (player.cumQ() >= 800) outputText("As your copious loads of boiling cum blast into both of her holes, " + flags[kFLAGS.HELSPAWN_NAME] + "’s belly expands. Unable to keep up with your immense volume of seed, cum spills out from her ravaged pussy and ass, splashing to the ground between your in an ever-growing puddle. However, you're pumping her full of cum faster than her body can reject it. Soon " + flags[kFLAGS.HELSPAWN_NAME] + " looks dangerously pregnant. \n \n");
			sharedEnd();
		}

		function sharedEnd():void {
			if (player.cumQ() >= 400) outputText("As your climax begins to diminish " + flags[kFLAGS.HELSPAWN_NAME] + " rises, and a cascade of your hot cream comes pouring out, joining the already immense pool of spooge around your [feet] as her cum-stuffed belly deflates.");
			else outputText("As your climax begins to diminish " + flags[kFLAGS.HELSPAWN_NAME] + " rises, and a hot mixture of your cum and her juices runs down her scaly thighs in rivulets.");
			player.sexReward("vaginalFluids", "Dick");
			doNext(postSexHelspawn);
		}
	}

	function postSexHelspawn():void {
		clearOutput();

		if (player.cumQ() >= 400) outputText("Both slick with sweat, cum and lady juices, the two of you collapse on the ground, ignoring the fact that you're lying in a pool of each other's fluids. You're both breathing as though you've just run a marathon. ");
		else outputText("You both collapse on the ground, breathing like you’ve just run a marathon. ");

		outputText("Even so, you can’t help reaching up and pulling " + flags[kFLAGS.HELSPAWN_NAME] + " into your [face]. Sitting up you wrap her up in your arms as you kiss her sexy lips again and again. A gorgeous body made slippery by exertion and ejaculation grinds against you, cum covered genitalia pressing against cum covered genitalia with passionate need. Your hands glide across her sweat drenched skin effortlessly as you reach down to grip her luscious ass. Her hands, meanwhile, are sliding across your [chest] and back. \n \n");

		outputText("After a few breathless moments of mutual groping you are the one to break the kiss but only so that you may kiss her elsewhere. With a grin she leans back, her perky breasts shining with sweat as you bury your face in her neck. You hear her squeal as you lay her back against the mess of ejaculants the two of you have made together.  \n \n");

		outputText("Using your lips you create a trail of soft kisses, each a wet proclamation of love, down her heated body. You begin with her flawless neck, tickling her as you create soft brown marks that stand out against her pale skin. Then you head down to her pert nipples, twirling your [tongue] around each hard stud that serves as a gentle reminder that she is still aroused. You taste her sweat covered form, kissing her trim belly and her soft thighs. You suckle, lick and kiss her legs and thighs until you pull her knees apart, exposing her cum glazed vagina.  \n \n");

		outputText("You look up into her face with a grin and she smiles down at you with a twinkle in her eye. She spreads her legs as her tail presses her body into the air, presenting you with her cum soaked vaginal opening. You just enjoy the sight for a moment, watching as pearly liquid drips down her body to join the cum beneath the two of you. \n \n");

		outputText("Your stomach growls, the meal before you making you hunger, so you dive in. You taste your own masculine seed sweetened with her lady cum. The heavenly combination is a gourmet taste sensation you can't help but love having on your [tongue]. She squeals again as your tongue slides against her vaginal lips and shining clitoris.  \n \n");

		outputText("She pushes you away with a giggle, saying, \"<i>Stop it, " + championRef() + ".</i>\" \n \n");

		outputText("You smile and ask her if you’re doing it wrong, you of course know you’re not. \n \n");

		outputText("\"<i>I'm all tender,</i>\" she says as she rubs her belly shyly. \"<i>It’s too sensitive.</i>\" \n \n");

		outputText("Nodding, you acquiesce to her request and finish by slurping the insanely tasty mixture from her pussy. The taste is mind-blowing and you can’t help but swirl the potent mixture around in your mouth. Then you notice " + flags[kFLAGS.HELSPAWN_NAME] + " noticing you with an amused grin as if she’s about to make a joke at your expense. So, to shut her up before she even has a chance to speak, you kiss her. \n \n");

		outputText("She groans as you share your meal, eagerly pulling you against her and enveloping you in her warmth. She seems to enjoy the taste as much as you do and sucks every drop from your tongue before following through and giving you one last long, hard kiss. \n \n");

		outputText("Starting to feel tired the two of you fall back with a yawn. " + flags[kFLAGS.HELSPAWN_NAME] + " snuggles against you, placing her head on your [chest].  \n \n");

		outputText("\"I love you, " + championRef() + ".\" Your darling " + flags[kFLAGS.HELSPAWN_NAME] + " says as she begins to drift off. \n \n");

		outputText("With a yawn you kiss her forehead and tell her you love her as well. \n \n");

		outputText("The two of you doze softly for a few moments, enjoying each other's company in silence. As she snuggles against your chest you reflect on all the things that brought the two of you together. You recall how Helia woke you up in the middle of the night. You look down at " + flags[kFLAGS.HELSPAWN_NAME] + "’s softly sleeping form and know that there are no regrets to be had concerning the beautiful little girl who calls you \"" + championRef() + "\". \n \n");

		outputText("After a few moments of gazing at her beautiful face you softy extricate yourself from her sleeping arms. She releases a soft moan and rolls over once you’ve freed yourself. Taking her into your arms you carry " + flags[kFLAGS.HELSPAWN_NAME] + " over to your bedroll and place her within its folds. She opens her eyes and gives you a smile before closing them again. \n \n");

		outputText("Returning to the cum strewn site of your recent coitus you find your " + player.armorName + " and pull it on. Your duty as champion beckons. With your " + player.armorName + " on and your " + player.weaponName + " in hand, you give " + flags[kFLAGS.HELSPAWN_NAME] + "’s sleeping brow a quick kiss and rise, leaving her to doze peacefully. \n \n");
		flags[kFLAGS.HELSPAWN_HADSEX] = 1;
		doNext(camp.returnToCampUseOneHour);
	}
}

//Hug
private function hugHelspawn():void {
	clearOutput();
	//{if PC is less than 6' tall:}
	if(player.tallness <= 72) {
		outputText("You reach up and pull " + flags[kFLAGS.HELSPAWN_NAME] + " down to your level, wrapping your arms tight around her slender shoulders.  Grinning from ear to ear, the towering girl squeezes you right back, her powerful muscles just about crushing your smaller body.  Her tail slips around your [hips], the warm leather binding you to your beloved ");
		if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
		else outputText("ward ");
		outputText("as she nuzzles up against you.");
		
		outputText("\n\n\"<i>Love you too, " + championRef() + ",</i>\" she laughs, planting a quick kiss on your cheek before letting you go.");
	}
	//{If PC is 6' or taller:}
	else {
		outputText("You grab " + flags[kFLAGS.HELSPAWN_NAME] + " and pull her into a tight hug.  She lets out a girlish giggle as she falls into your arms and squeezes you right back.  Her powerful arms threaten to crush your bigger body, smothering you in affection.  Her tail slips around your [leg], the warm leather binding you to your beloved ");
		if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("daughter ");
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
	if(flags[kFLAGS.HAD_FIRST_HELSPAWN_TALK] == 0) {
		flags[kFLAGS.HAD_FIRST_HELSPAWN_TALK]++;
		outputText("You sit down with " + flags[kFLAGS.HELSPAWN_NAME] + ", telling her you need to talk.  Specifically, about her nocturnal misadventures.  She gulps, but you reassure her with a pat on the back, telling her it's all right.  She's a grown woman, now, as frightening as that is - for her and her mother both, it seems.  But she's an adult now, with the needs and cunning and abilities of one.  She can fight, drink, and she can fuck.  She's not a child anymore, even if she'll always be your kid at heart.");
		outputText("\n\nShe smiles.  \"<i>Sorry for bringing my friend home uninvited.  I just... didn't want to upset you. I love you, " + championRef() + ",</i>\" she says, resting her head on your shoulder, tail slipping around your waist.  You smile, holding the young 'mander girl - no, woman - close.  You tell her that you love her too, and that you're worried about her bringing random monsters home.");
		//{if Sluttymander:
		if(flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) outputText("  Even if she wants to be just like mom, she shouldn't be bringing monsters home.  Some of them may be dangerous, and she's not a warrior quite like you and Helia yet.");
		else outputText("  She should know better than to bring monsters back.  She's not her mother; lust doesn't have to dominate her life like that.");
		
		outputText("\n\nPerhaps you could learn more about this spider boy of hers.  He actually had a name, and seemed to be fairly civil.  Lucky break for her.  Then again, you could tell her to just save herself and stop trying to fuck things altogether.  ");
		if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("Of course, as her father, you could always say it's your duty to keep her happy...");
		else outputText("Of course, as her adoptive father, you could always say that you love her in a different, more intimate way.");
		outputText("  She wouldn't need monsters with you around.");
		sceneHunter.print("Please note that it is the ONLY chance to enable incest scenes.");
		menu();
		addButton(0,"Stop Fucking",dontFuckAlex);
		addButton(1,"Her Boyfriend",helSpawnBoyfriend);
		addButton(2,"Incest",incestWithHelspawn);
	}
	//Talk 2
	//{Kiha must be at camp}
	else if(temp <= 0 && followerKiha()) {
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
	else if(temp <= 1 && player.hasStatusEffect(StatusEffects.CampRathazul)) {
		outputText("\"<i>" + flags[kFLAGS.HELSPAWN_NAME] + "!</i>\" you hear a ragged old voice call, \"<i>Get back here this instant!  I'm not done with you yet!</i>\"");
		
		outputText("\n\n\"<i>Coming!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " calls back as Rathazul shuffles into view, waving around what looks like a tiny hammer.  Whispering, " + flags[kFLAGS.HELSPAWN_NAME] + " says, \"<i>Could you come with me, " + championRef() + "? Rathazul weirds me out.</i>\"");
		
		outputText("\n\nChuckling, you nod and follow " + flags[kFLAGS.HELSPAWN_NAME] + " as she returns to Rath's makeshift laboratory and seats herself on one of his tables.  Grumbling about kids, the old rat proceeds to rap his little hammer on her knee - nearly getting kicked in the face for his trouble - before asking her to hold her breath as he listens to her heartbeat.  She's nearly blue in the face before he nods approvingly and tells her she can go. " + flags[kFLAGS.HELSPAWN_NAME] + " goes running, happy to get away as Rath turns to you, shaking his head.");
		
		outputText("\n\n\"<i>Just checking up on her, [name].  Her meteoric growth is of some concern - and scientific interest, I might add, if I could determine what caused it.  If I could mass-produce it.  ");
		if((amilyScene.amilyFollower() && !amilyScene.amilyCorrupt())) outputText("Little Amily's solution was makeshift at best, and the children are beyond my reach to study.  Still.  ");
		outputText("Imagine whole legions of children reared and raised in the time it takes a goblin to do the same. We might have a fighting chance for once, with numbers to match the demons.</i>\"");
		
		outputText("\n\n\"<i>But I suppose that's still out of reach, [name].  She's finished growing, and there's no sign of the exact chemical needed to synthesize the compound.  I'll keep checking up on her for health, though perhaps one day I'll find the means to make accelerated growth safe and widespread.  An old man can hope, yes?</i>\"");
		doNext(camp.returnToCampUseOneHour);		
	}
	//Talk 4
	//{Bath Slut w/ DD or HHH must be at camp}
	else if(temp <= 2 && milkSlave() && flags[kFLAGS.MILK_SIZE] > 0) {
		outputText("\"<i>Hey, have you seen " + flags[kFLAGS.MILK_NAME] + " around anywhere, " + championRef() + "?</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " asks, looking around the camp.  \"<i>Mom asked me to milk her, but I haven't seen her around.  She wouldn't have run off, would she?</i>\"");
		if(flags[kFLAGS.MILK_SIZE] == 1) outputText("\n\nYou tell her it'd be more of a wobble, but");
		else outputText("\n\nYou doubt she would have; " + flags[kFLAGS.MILK_NAME] + " seems to have a fancy for you, but");
		outputText(" it wouldn't hurt to check around.  She does tend to wander into the traps around camp from time to time.  Offering " + flags[kFLAGS.HELSPAWN_NAME] + " your hand, you start searching the camp for your missing milk maid.  The two of you make a circuit around camp, checking the traps and behind various rocks and hollows, to no avail.  Finally, as you're starting to get worried about the dusky maid, you happen to look into the steel pool in her part of camp.  Sure enough, you spy " + flags[kFLAGS.MILK_NAME] + " curled up at the bottom of the pool, cuddled up with a ragged blanket to catch a quick nap.");
		outputText("\n\n\"<i>Aww,</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " grins, looking down at the napping " + flags[kFLAGS.MILK_NAME] + ".  \"<i>Guess I can milk her later, then.</i>\"");
		menu();
		addButton(0,"MilkHerLater",	helSpawnSureMilkHerLater);
		addButton(1,"MilkHerNow",helSpawnMilkHerNow);
	}
	//Talk 5
	//{Isabella must be at camp}
	else if(temp <= 3 && isabellaFollower()) {
		outputText("\"<i>Oh hey, " + championRef() + "!</i>\" " + flags[kFLAGS.HELSPAWN_NAME] + " says, suddenly grinning, \"<i>Mom bought me a new guitar in town.  Wanna come listen?</i>\"");
		
		outputText("\n\n\"<i>Sure, kiddo,</i>\" you say, absently wondering how she plays a guitar with those giant claws of hers as she leads you back to her and Helia's part of camp, where she quickly produces a dinged up guitar.  Looks like Hel's been visiting the pawn shop, but hey, " + flags[kFLAGS.HELSPAWN_NAME] + " doesn't seem to mind.  She hops up onto a nearby rock and gives the instrument a few experimental strums, pausing to adjust the tuning or fix a string that snaps a little too easily.  But after a moment of preparation, she's ready.");
		
		outputText("\n\nA soft, melodic tune starts to play as " + flags[kFLAGS.HELSPAWN_NAME] + "'s dexterous fingers dance across the fret, plucking at the strings with some small hesitation.  She's a beginner, but not bad at all; the simple tune is sweet and she plays it with burgeoning proficiency, slowly settling into the rhythm of the piece until you can close your eyes and relax, letting her playing sooth you, carrying your troubles far away.  You barely notice when a high, soft voice adds itself to the guitar, a lilting, haunting soprano that slowly grows in power as the young 'mander's playing intensifies, building toward crescendo.  She's singing, surely, but the words are alien and unknowable; you think, for a moment, that perhaps they're in Helia's native tongue, but when a second voice, powerful and operatic, joins " + flags[kFLAGS.HELSPAWN_NAME] + "'s, you know who's been teaching her.");
		
		outputText("\n\nYou open an eye as Isabella approaches, belting out a misty-eyed verse in her strange language, and you can practically feel her homesickness, her separation from a lifetime of friends and loved ones.  As her arms cross under her enormous breasts, you can't help but think of the mutations she has undergone");
		if(player.race() != "human") outputText(" and you yourself have suffered as well");
		outputText(".  You smile as Isabella seats herself beside " + flags[kFLAGS.HELSPAWN_NAME] + ", joining their voices together for the final chorus that leaves them both shaking as " + flags[kFLAGS.HELSPAWN_NAME] + " strums the last, desperate notes, nearly clawing through the strings in her passion.");
		
		outputText("\"<i>");
		if(!isabellaAccent()) outputText("Sehr gut");
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
	if(flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) {
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
	outputText("You cup " + flags[kFLAGS.HELSPAWN_NAME] + "'s cheek, turning her to you... only to have her leap you, straddling your [legs] as her powerful arms wrap around your neck.  Her thin lips press hard to yours, slender tongue probing against yours as her svelte body presses against you.  You respond in kind, grabbing her big ass and squeezing, kneading the delicious curves as she starts to grind against you, breath hot and heavy on your [skin].  \"<i>I said I love you, " + championRef() + ",</i>\" she grins, so close you can practically feel the beat of her heart through her perky breasts.  \"<i>Glad to know you feel the same way.</i>\"");
	
	outputText("\n\nYou grin as the beautiful salamander strokes your cheek, and says, \"<i>You're a hell of a lot better than any femmy spider boy, " + championRef() + ".  I'm a lucky girl to have someone like you to raise me... and to love me.</i>\"");
	
	outputText("\n\nYou kiss her again and send her on her way with a sharp swat on the ass.  She gives it a sexy wiggle as she walks, winking back at you as she saunters off.");
	dynStats("lus", player.sens/10+5, "scale", false);
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
		outputText("\n\nCringing, you are about to set the offered bowl back down but you are reminded by your growling stomach. You have no choice but to cover your nose and just gulp down the contents of the stew. ");
		player.refillHunger(25);
		outputText("\nYou feel a bit nauseous. That stew surely is strange.");
		if (rand(3) == 0)
		{
			//Player vomits. Poor player. Damages hunger by 15-25.
			outputText("\n\nGasp! You feel like you're going to throw up. You get up and rush behind the bushes. You suddenly bend over and spew the contents of your stomach from your mouth onto the ground. It takes a while but you eventually recover and you get up. ");
			player.takePhysDamage(player.maxHP() / 4);
			player.damageHunger(rand(10) + 15);
			dynStats("lib", -10);
			dynStats("lust", -100, "scale", false);
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
	if(flags[kFLAGS.MILK_SIZE] == 2) outputText(", already working to unfasten her shift");
	outputText(".  \"<i>Suckle?</i>\" she asks, turning her full teats toward " + flags[kFLAGS.HELSPAWN_NAME] + ".");
	
	//If Sluttymander:
	if(flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) outputText("\n\n\"<i>Wouldn't have it any other way!</i>\" the salamander answers with an eager grin, easing herself into " + flags[kFLAGS.MILK_NAME] + "'s arms and wrapping her lips around one of her prominent teats. " + flags[kFLAGS.MILK_NAME] + " gives a pleasured little shudder as " + flags[kFLAGS.HELSPAWN_NAME] + " starts to suckle like a babe, drinking down the dusky maid's seemingly endless supply of milk.");
	
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
	if(flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) outputText("\n\n\"<i>Ready to get your shit kicked in, old " + player.mf("man","lady") + "?</i>\" she grins, drawing her weapon.");
	else outputText("\n\n\"<i>Just go easy on me, okay?  I'm still new at this...</i>\" she says, stepping back as she draws her weapon.");
	startCombat(new Helspawn());
}




//PC Somehow Loses Despite Being Like Level 20+
// The irony is that you can't even get her till like, Level 20 because dungeon. And she's lower level but then Hel's lower level than HER which makes shit for sense. Fuck logic, get bitches.
internal function loseSparringToDaughter():void {
	//if Sluttymander:
	if(flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50) {
		outputText("As you stumble back, ");
		if(player.lust >= player.maxLust()) outputText("succumbing to your own lusts");
		else outputText("unable to withstand her unending hail of attacks");
		outputText(", " + flags[kFLAGS.HELSPAWN_NAME] + " quickly sweeps your [legs] out from under you, dropping you right on your ass.  You collapse with a grunt, ");
		if(player.weaponName != "fists") outputText("weapon tumbling out of hand");
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
		if(player.lust >= player.maxLust()) outputText("succumbing to your own lusts");
		else outputText("unable to withstand her unending hail of attacks");
		outputText(", " + flags[kFLAGS.HELSPAWN_NAME] + " grabs your arm, catching you before you can fall.  \"<i>Easy there, " + championRef() + ", I got you,</i>\" she says, pulling you into a quick hug.");
		
		outputText("\n\n\"<i>You didn't go easy on me, did you?</i>\" she asks as you regain your balance.  When you shake your head, she beams, smiling from ear to ear. Prancing out of reach, she breaks down into a happy little dance, gloating over her victory over the mighty Champion.  You shake your head and ruffle her hair, reminding her not to get too full of herself.");
		outputText("\n\n\"<i>I wouldn't dream of it, " + championRef() + "!</i>\" she grins, planting a quick kiss on your cheek before you head off to ");
		if(player.HP < 1) outputText("recover from that ass kicking");
		else outputText("dunk your head");
		outputText(".");
	}
	cleanupAfterCombat();
}

//PC kicks Helspawn's shit in, surprising nobody. 
internal function beatUpYourDaughter():void {
	clearOutput();
	//{If Sluttymander loses to lust (you monster)}:
	if(flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50 && monster.lust >= monster.maxLust()) {
		outputText("\"<i>N-no more...</i>\" the slutty little salamander moans, slumping down to the ground, arms wrapping around herself.  \"<i>Fuck, you're sexy... so horny...</i>\" she groans, hands slipping down to her soaked bikini bottom.");
		
		outputText("\n\nShaking your head, you give her a little push, flopping her onto her back.  She just lets out a little whimper and finally tears her panties away, giving her unrestricted access to her sodden box.  \"<i>Hey, d-don't just leave me like this,</i>\" she whines, but to no avail.");
		//If No Incest: 
		if(flags[kFLAGS.HELSPAWN_INCEST] == 0) outputText("  You wash your hands of the defeated slut and head back to camp, leaving her to work through her tension herself.");
		else {
			outputText("  You reach down and give your lovely, lusty daughter a pat on her expansive rear, telling her she'll always look her best with her ass in the air, begging for ");
			if(!player.hasCock()) outputText("sex");
			else outputText("your cock");
			outputText("... and that if she's lucky, you might tend to her when you've cooled off.");
		}
	}
	else {
		outputText(flags[kFLAGS.HELSPAWN_NAME] + " stumbles back, dropping her weapon and waving her arms, \"<i>I give, I give.</i>\"");
		outputText("\n\nWith an approving nod, you lower your [weapon], telling her she did a fine job.  Not many people can stand up to you for as long as she did, after all.  She grins a little, but winces when you try and get close");
		if(monster.HP <= monster.minHP()) outputText(", rubbing her many bruises");
		else outputText(", blushing brightly after your slutty display");
		outputText(".  You chuckle and ruffle her hair, \"<i>C'mon, kiddo, let's get some food in you.</i>\"");
		outputText("\n\n\"<i>Yeah, food,</i>\" she groans, stumbling after you as you both recover from the furious sparring match.");
	}
	cleanupAfterCombat();
}

//BONUS SCENES!
//(Scenes are repeatable; small chance to play one at any given [appropriate] time. All require Adult Minimander.)
//Mai Visits Her Kid
//{Requires Helspawn be Mai's daughter; play when returning to camp:}
public function maiVisitsHerKids():void {
	clearOutput();
	helScene.helSprite();
	flags[kFLAGS.HELSPAWN_DAD_EVENT] = 20; //set it to repeat
	outputText("As you head back into camp, you notice Hel and " + flags[kFLAGS.HELSPAWN_NAME] + " are sitting around the cook fire in the center of camp, with your foster daughter balanced precariously on the lap of her own father, Mai the fox-girl.");
	
	outputText("\n\n\"<i>Heyya, lover mine, look who stopped in!</i>\" Hel calls, waving you over until you slip down beside her, a warm, leathery tail quickly wrapping around your waist.");
	
	outputText("\n\n\"<i>Hi, [name],</i>\" Mai says with a demure smile, arms wrapped around " + flags[kFLAGS.HELSPAWN_NAME] + "'s belly, trying to hold the daughter that's near a foot taller than she is.  Finally, laughing, she lets the young salamander go.  " + flags[kFLAGS.HELSPAWN_NAME] + " drops down to sit beside her mother and father, and quickly has both a smooth and scaly hand stroking her hair.");
	//If Chastemander:
	if(flags[kFLAGS.HELSPAWN_PERSONALITY] < 50) outputText("\n\n" + flags[kFLAGS.HELSPAWN_NAME] + " happily leans her head against Mai's leg, accepting the affection with her tail swishing gaily behind her, foxy ears twitching as Mai brushes them.");
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
	helScene.helSprite();
	flags[kFLAGS.HELSPAWN_DAD_EVENT] = -1; //disable the event
	outputText("As you're getting ready to head out for the day, you notice " + flags[kFLAGS.HELSPAWN_NAME] + " prancing around camp with a long, brightly-colored scarf wrapped around her neck, standing painfully in contrast with her midnight-black scales and pale flesh.");
	
	outputText("\n\n\"<i>Whatcha got there, kiddo?</i>\" you ask, walking over to the clearly quite pleased salamander.");
	
	outputText("\n\nShe grins, hugging the scarf to herself.  \"<i>I don't know, I woke up and there it was, right next to me.  I think mom bought it for me");
	//if Isabella: 
	if(isabellaFollower()) outputText(", or aunt Isabella might have knitted me a new one, I don't know");
	outputText(".</i>\"");
	
	outputText("\n\nYou shrug, but as she turns away, you grab the corner of the scarf and feel it.  Spider silk, if ever you've felt it.  A grin spreads across your face as you realize who must have made this.");
	
	outputText("\n\nThen you realize someone just walked into your camp and could have slaughtered you all.  You should probably fix that.");
	doNext(camp.returnToCampUseOneHour);
}



//Hakon and Kiri Come to Visit
//{Play as the PC returns to camp in the evening / late afternoon}
public function hakonAndKiriComeVisit():void {
	clearOutput();
	helScene.helSprite();
	flags[kFLAGS.HAKON_AND_KIRI_VISIT] = 1;
	outputText("As you're returning to camp, you notice Helia running around like a chicken with her head cut off, fussing about damn near everything in her part of the camp");
	if(camp.companionsCount() > 1) outputText(" and everyone else's too, much to their chagrin");
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
	if(flags[kFLAGS.HELSPAWN_WEAPON] == "scimitar and shield") outputText(championRef() + "'s been teaching me how to fight.");
	else outputText("Mom's been teaching me how to fight.");
	outputText("  I'm not as good as mom and " + championRef() + " yet, but I'd love to come along.</i>\"");
	
	outputText("\n\n\"<i>That's the spirit.  Now we just have to convince your aunt Kiri to come along.  And ");
	if(flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("your old man");
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
	helScene.helSprite();
	outputText("\"<i>Sure,</i>\" you say, quickly earning approving nods from Hakon and Helia.");
	outputText("\n\n\"<i>No mercy for gnolls!  Right, sweetheart?</i>\" Hel shouts, grabbing a mug of ale and lifting it in the air.");
	
	outputText("\n\n\"<i>R-right!</i>\"");
	
	outputText("\n\nWith that settled, you sit down as Hel passes out something that must be akin to dinner for her family - mostly booze and rations - and soon you're enjoying a meal with the rowdy family, laughing at Hel's ribald jokes or Hakon's old war stories.  Eventually, Hakon and Kiri leave, but not before promising to come and get you and the family for their next gnoll hunt.");
	doNext(camp.returnToCampUseOneHour);
}
//Maybe not
private function noHuntingBitches():void {
	clearOutput();
	helScene.helSprite();
	outputText("\"<i>I'll pass,</i>\" you say with a laugh, earning a shrug from the salamanders.");
	outputText("\n\n\"<i>Well, maybe you'll change your mind next time.  Plenty of evil furbags to go around!</i>\" Hel says with a laugh.  \"<i>C'mon, let's find something for the folks to eat, huh?</i>\"");
	
	outputText("\n\nWith that settled, you sit down as Hel passes out something that must be akin to dinner for her family - mostly booze and ration - and soon you're enjoying a meal with the rowdy family, laughing at Hel's ribald jokes or Hakon's old war stories.  Eventually, Hakon and Kiri leave, waving goodbye until the next time they can visit.");
	doNext(camp.returnToCampUseOneHour);
}
}
}