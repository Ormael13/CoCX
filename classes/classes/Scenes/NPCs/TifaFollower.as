/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;

public class TifaFollower extends NPCAwareContent
	{

public function tifaAffection(changes:Number = 0):Number {
	flags[kFLAGS.TIFA_AFFECTION] += changes;
	if (flags[kFLAGS.TIFA_AFFECTION] > 100) flags[kFLAGS.TIFA_AFFECTION] = 100;
	return flags[kFLAGS.TIFA_AFFECTION];
}

public function tifaMainMenu():void {
	clearOutput();
	outputText("You walk over and wave to Tifa who is as her usual, busy collecting flowers.\n\n");
	outputText("\"<i>Hey [name] how are you doing? Izzz something on your mind?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", tifaMainMenuAppearance);
	addButton(1, "Talk", tifaMainMenuTalk);
	addButton(3, "Sex", tifaMainMenuSex);
	addButton(4, "Back", camp.campFollowers);
}

public function tifaMainMenuAppearance():void {
	clearOutput();
	outputText("Tifa is a bee girl. Her flowing, yellow and black, hair is kept short and flat on her head accentuating her tomboyish outlook. Her eyes, like most bees, are solid black though you somehow can always figure where she is looking at. Above her hair rests a pair of antenna which from what you know allows for mental communication with the rest of the hive. ");
	if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) outputText("Currently, she is laying down on a small bed of resin the workers made for her, she does not get to move much anymore");
	else outputText("Not being a full fledged queen yet, she is still capable of moving around");
	outputText(".\n\nHer arms and legs are covered with black armor like chitin. The chitin on her limbs climbs up to the middle of her thighs and shoulders ending with yellow fuzz. A large pair of diaphanous wings rest on her shoulders"+(player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)?" though due to her new size she doesn’t use them as much as she did before":"")+". ");
	outputText("From her well-shaped ass protrudes her"+(player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)?" egg lidden":"")+" abdomen covered in armor like chitin. At the tip of said abdomen of course rests her stinger from which venom occasionally drips off.\n\nTifa is gifted with a pair of pert breasts easily reaching "+(player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)?"F":"D")+" cup and her wasp shape, all bugs jokes avoided, would be difficult to beat.\n\n");
	if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) outputText("She’s got one primary pussy on the front and many other slits lining the sides of her abdomen which her drone consorts proceed to regularly fill as to keep the egg production going");
	else outputText("Her pussy ever drips with a steady flow of honey albeit not as much as the handmaidens");
	outputText(".\n\n");
	doNext(tifaMainMenu);
}

public function tifaMainMenuTalk():void {
	clearOutput();
	outputText("You ask her if she would mind having a chat.\n\n");
	outputText("\"<i>Yezzz sure whatzzz the topic you would like to discuzzz?</i>\"\n\n");
	menu();
	addButton(0, "Her", tifaMainMenuTalkHer);
	addButton(1, "Bee life?", tifaMainMenuTalkBeeLife);
	addButton(2, "Relations", tifaMainMenuTalkRelations);
	if (player.gender > 1 && flags[kFLAGS.TIFA_AFFECTION] >= 100 && flags[kFLAGS.TIFA_FOLLOWER] == 9 && player.isRace(Races.BEE, 1, false)) addButton(2, "Handmaiden", tifaMainMenuTalkRelations).hint("Become her handmaiden.");
	else if (flags[kFLAGS.TIFA_FOLLOWER] > 9) addButtonDisabled(3, "Handmaiden", "You're already her handmaiden.");
	else addButtonDisabled(3, "Handmaiden", "Become her handmaiden. (Req. female or herm bee morph and discussed all conversation at least once, also have an affection rating with Tifa of 100)");
	addButton(4, "Back", tifaMainMenu);
}
public function tifaMainMenuTalkReturn():void {
	clearOutput();
	outputText("\"<i>Anything Elzzze you want to talk about then?</i>\"\n\n");
	menu();
	addButton(0, "Her", tifaMainMenuTalkHer);
	addButton(1, "Bee life?", tifaMainMenuTalkBeeLife);
	addButton(2, "Relations", tifaMainMenuTalkRelations);
	if (player.gender > 1 && flags[kFLAGS.TIFA_AFFECTION] >= 100 && flags[kFLAGS.TIFA_FOLLOWER] == 9 && player.isRace(Races.BEE, 1, false)) addButton(2, "Handmaiden", tifaMainMenuTalkBecomeHerHandmaiden).hint("Become her handmaiden.");
	else if (flags[kFLAGS.TIFA_FOLLOWER] > 9) addButtonDisabled(3, "Handmaiden", "You're already her handmaiden.");
	else addButtonDisabled(3, "Handmaiden", "Become her handmaiden. (Req. female or herm bee morph and discussed all conversation at least once, also have an affection rating with Tifa of 100)");
	addButton(4, "Back", tifaMainMenu);
}

public function tifaMainMenuTalkHer():void {
	clearOutput();
	outputText("So can she talk about herself, starting with why her sister said she was rebellious?\n\n");
	outputText("\"<i>Thatzzz becauzzze I refuzzze to become a queen. I want to zzzee the world outside the hive, and a constantly pregnant abdomen won’t allow zzzuch a thing. You could zzzay I dezzzerted my functionzzz in the hive. Once I’ve zzzeen enough, I’ll take my place azzz a queen and form a hive.</i>\"\n\n");
	outputText("So wait, she was scorned by the other bees for actually refusing to become a queen?\n\n");
	outputText("\"<i>You could zzzay it’zzz like that, yezzz.</i>\"\n\n");
	if (flags[kFLAGS.TIFA_FOLLOWER] == 6) flags[kFLAGS.TIFA_FOLLOWER]++;
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuTalkBeeLife():void {
	clearOutput();
	outputText("What is the life of a bee actually, is everyone always in agreement with the queen? What of the lesser bees? Are they actually able to make their own choices?\n\n");
	outputText("\"<i>Thatzzz a zzztrange quezzztion [name] I can only guezzz you mean to want to know how beezzz live and how the cazzzte zzzystem workzzz. Well, truth izzz everyone in a hive izzz zzzort of linked telepathically to the queen. Do not think of thizzz azzz zzzome form of dictature, the beezzz work becauzzze they want to pleazzze her and becauzzze nothing makezzz them feel more accomplished than ");
	outputText("making their queen proud and happy. Every child lookzzz up to hizzz or her parent and zzzince everyone izzz born from the queen everyone obeyzzz her unquezzztionably. Uzzz princezzz are different. We are bound to one day rule our own hive and for thizzz reazzzon our mind izzzn’t linked to that of the queen. We make our own choicezzz and decizzzion without anyone telling uzzz otherwizzze. ");
	outputText("Zzztill azzz free willed azzz a queen might be, her huge pregnant body doezzz not allow much mobility thuzzz a bee queen never leavezzz itzzz throne room. Lezzzer beezzz have free will like anyone elzzze however their unwavering devotion to their mother the queen izzz enough of a motivation. Even if offered to zzztop working for a few dayzzz mozzzt beezzz would feel horribly guilty for zzzlacking.</i>\"\n\n");
	if (flags[kFLAGS.TIFA_FOLLOWER] == 7) flags[kFLAGS.TIFA_FOLLOWER]++;
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuTalkRelations():void {
	clearOutput();
	outputText("What's the standing of relations between bees and the other races."+(player.isRace(Races.PHOENIX, 1, false) ? " You overheard that the sand witches and harpies had very close relationships with the hives.":"")+"\n\n");
	outputText("\"<i>While the hivezzz are open to any alliance that may involve willing incubatorzzz for our eggzzz, outsiderzzz aren’t allowed in the hivezzz proper and are limited to parley with the queen’zzz emizzzary, often a handmaiden. Thizzz helpzzz keep threats to the hive outzzzide, however azzz you might have notizzzed thizzz izzz not a failproof zzzolution and ");
	outputText("zzzometimezzz a corrupted bee hazzz to be put down for the good of everyone.</i>\"\n\nWhat does it take for outsiders to gain entry then?\n\n");
	outputText("\"<i>Outsiderzzz don’t gain entry. They never do. However, zzzome bee morphzzz who aren’t affiliated to a hive are zzzometimezzz allowed the gift of bonding. As you may know pure bee honey hazzz powerful tranzzzformative capabilitiezzz and can fully transform even a native marethian into a bee morph. For mozzzt thizzz izzz azzz far azzz it goezzz azzz even thizzz tranzzzformativezzz cannot fully grant you our anatomy. ");
	outputText("However the queen’s royal honey izzz even more potent than the regular unrefined honey azzz it can turn a bee morph into a full fledged bee drone or handmaiden and a child of the queen in blood. Thizzz change alzzzo allowzzz the queen to establish a mental link to the hive with the petitioner. Do underzzztand however that once in the hive you are in it for life both in body and zzzoul. ");
	outputText("Even the mozzzt unruly petitioner will inevitably fall in line due to the mental conditioning impozzzed by the hive mind. Thizzz izzz not brainwashing but the rezzzult izzz about the zzzame. Again mozzzt petitionerzzz are either egging enthuzzziast or malezzz who became zzzo addicted to their bee dickzzz they zzzimply dezzzided to fully embrace the lifezzztyle of a drone.</i>\"\n\n");
	outputText("Well this is nice to know.\n\n");
	if (flags[kFLAGS.TIFA_FOLLOWER] == 8) flags[kFLAGS.TIFA_FOLLOWER]++;
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuTalkBecomeHerHandmaiden():void {
	clearOutput();
	outputText("You ask Tifa if she would actually like to start her hive for real.\n\n");
	outputText("\"<i>Well I didn’t actually plan to become queen zzzo zzzoon. Heck I would rather continue living however I like. No matter what laying eggzzz muzzzt feel like, I appreciate my freedom more. Alzzzo I’m worried I won’t be able to zzzee you again azzz my brood will likely lock you out for my own zzzafety.</i>\"\n\n");
	outputText("What if you were of her brood to begin with? You would gladly carry her eggs if it’s what is necessary to get her started.\n\n");
	outputText("\"<i>You… you would go thizzz far azzz to bind your mind to mine and become my handmaiden?… Juzzzt for me to accept my role azzz a queen of my people? [name] I… fair enough yezzz I will become your queen. Do you promizzze to faithfully zzzerve me for the rezzzt of your life azzz my bezzzt friend, lover and daughter?</i>\"\n\n");
	outputText("You would of course, otherwise you wouldn't have proposed this in the first place.\n\n");
	outputText("\"<i>You do realizzze the implicationzzz of thizzz right? Onzzze you become a true bee there will be no way back. Tranzzzformation itemzzz won’t give you back your humanity.</i>\"\n\n");
	menu();
	addButton(1, "Yes", tifaMainMenuTalkBecomeHerHandmaidenYes).hint("Become her handmaiden");
	addButton(3, "No", tifaMainMenuTalkBecomeHerHandmaidenNo).hint("Think about it first");
}
public function tifaMainMenuTalkBecomeHerHandmaidenYes():void {
	clearOutput();
	outputText("You’ll definitely accept to be hers for life.\n\n");
	outputText("\"<i>Then… then pleazzze have thizzz… I… I kept thizzz item in cazzze zzzomeday I would need it. Thizzz izzz some of my own royal jelly and it should allow you to become the firzzzt true member of my hive and my mozzzt cherizzzhed handmaiden.</i>\"\n\n");
	outputText("She hands you a small candy like item. The way she’s saying it, it's almost as awkward as a wedding proposal but you already know your answer is a yes. \n\n");
	outputText("You take a deep breath before accepting the candy from your insectoid lover. It is a small, round and shaped like a teardrop, about an inch long and half an inch thick. You put it in your mouth. It is soft and sweet, but has a bit of a sour aftertaste. After a few moments, you feel like your head is spinning, and you lie back down on the flower while Tifa moves over you and gently caresses your face with her chitin covered arms. ");
	outputText("Suddenly your whole body start to ache, then burn. You look down at yourself to see what is happening, only to see a layer of "+(player.chitinColor == "black"?"brown":"black")+" chitin slowly growing across your torso, in the same places as a true bee! Looks like you’re turning into a full bee now.\n\n");
	outputText("Your energy rapidly fades as more of your body changes. You try to steady your breathing while the transformation progresses. It isn’t easy, especially when something fundamental about your pussy changes, and you feel something viscous start to flow out of it. Thankfully, it isn’t gasps of pain that are making it hard to take deep breaths anymore, but gasps of pleasure. ");
	outputText("You can’t wait to feel another part of your body rearrange itself and to experience the rush of new feelings from them. The sensations from your new honeypot in particular are almost overwhelming and every few moments another torrent of honey sprays out.\n\n");
	outputText("Eventually, the transformation ends, and you open your eyes again. Still dizzy you try to stand back up. You look over your body, and find that you have indeed become just like a handmaiden. You push out your lips a bit and find that yes, you now have luscious black lips. Your whole body is now covered in chitin plating, in the same way as a true bees would be. Finally, you check your womanhood and find that it is now secreting honey, not unlike the bee maidens surrounding Tifa. ");
	outputText("You are a bit surprised to find that the honey’s scent doesn’t seem to be affecting you anymore. At least not as strongly as before. Now, however, is the time for you to take on your role as Tifa’s lover and so you ask what happens next.\n\n");
	outputText("\"<i>Now that you are part of my brood I will fill you with my eggzzz so that you can find proper incubatorzzz for them to gezzztate.</i>\"\n\n");
	outputText("Whoa! To your surprise, her abdomen has indeed grown to double its original size while you were changing and so she explains.\n\n");
	outputText("\"<i>I already had ahem... fertilizzzerzzz I took from back home for when the time would be right. However, to truly become a queen I will need to empty my abdomen at leazzzt once. Afterward, my abdomen will only keep expanding up to the sizzze of my mother’zzz so long azzz I keep nourishing it, do not worry about the nourishment, I already zzzent an emizzzary to my zzzizzzter to obtain zzzpare dronezzz.</i>\"\n\n");
	outputText("Tifa lets her ovipositor, which is actually way bigger than that of the handmaiden, out and you get the message. As soon as you lay on top of her belly Tifa promptly takes it upon herself to jam the thing inside your honeypot. You shriek in pleasure from the sudden intruder filling your body. Your legs quickly fail you, thankfully, you're already sitting on Tifa so you don't fall off. You don’t pay much attention though, you’re too busy seeing white from the intense penetration going on between your legs.\n\n");
	outputText("Tifa’s ovipositor soon starts to unload huge amounts of bee eggs deep into your womb, filling you up. You cum at once, this is what you were meant to do. This is what you want to spend your whole life doing. It feels so damn good to be filled up by her, and her satisfaction at the sentiment within your mind only makes it better thanks to the expending hive mind link that you now share with her.\n\n");
	outputText("Another orgasm passes through your body, and you look behind you to see your abdomen filling up with Tifa’s eggs. In fact, when you feel that it is still growing, your body is pushed over the edge in another orgasm.\n\n");
	outputText("It doesn’t take much longer for the process of being filled with your lover’s eggs to finish, and the stinger is retracted from your body. You pant, exhausted from the ordeal. Tifa is tired too, likely because it's her first time. You lean on her a little, still panting and she caresses your hair in response.\n\n");
	outputText("\"<i>Well, we are in thizzz for the better and the worzzze. I love you [name], now and until death do uzzz part.</i>\"\n\n");
	outputText("You do too and you know what you must do next. It's time to head out and find someone to carry these eggs, your abdomen is just this full.\n\n");
	player.antennae.type = Antennae.BEE;
	player.eyes.type = Eyes.BLACK_EYES_SAND_TRAP;
	player.ears.type = Ears.HUMAN;
	player.faceType = Face.HUMAN;
	player.tailType = Tail.BEE_ABDOMEN;
	player.arms.type = Arms.BEE;
	player.lowerBody = LowerBody.BEE;
	player.tongue.type = Tongue.BEE;
	player.wings.type = Wings.BEE_LARGE;
	player.horns.type = Horns.NONE;
	player.horns.count = 0;
	player.rearBody.type = RearBody.BEE_HANDMAIDEN;
	transformations.SkinPatternBeeStripes.applyEffect();
	player.killCocks( -1);
	player.vaginaType(VaginaClass.BEE);
	player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_DROOLING;
	if (!player.hasStatusEffect(StatusEffects.BlackNipples)) player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
	player.createPerk(PerkLib.TransformationImmunityBeeHandmaiden, 0, 0, 0, 0);
	if (!player.hasPerk(PerkLib.BeeOvipositor)) player.createPerk(PerkLib.BeeOvipositor, player.maxEggs, 0, 0, 0);
	else player.setPerkValue(PerkLib.BeeOvipositor, 1, player.maxEggs);
	player.fertilizeEggs();
	dynStats("lus", ((40 + rand(21)) * 0.01 * player.maxLust()), "scale", false);
	if (player.cor >= 50) player.cor -= 50;
	else player.cor = 0;
	player.removeAllRacialMutation();
	outputText("\n\n");
	flags[kFLAGS.TIFA_FOLLOWER]++;
	CoC.instance.mainViewManager.updateCharviewIfNeeded();
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuTalkBecomeHerHandmaidenNo():void {
	clearOutput();
	outputText("You need to think this through. If you do indeed become a bee for life this is something you need to think over.\n\n");
	doNext(tifaMainMenuTalkReturn);
}

public function tifaMainMenuSex():void {
	clearOutput();
	outputText("You’re feeling antsy, does the bee have anything on her mind she would like to show you?\n\n");
	outputText("\"<i>Well sure, we could play a bee game or go for something else on your mind, what would it be?</i>\"\n\n");
	menu();
	if (player.hasVagina() && player.biggestTitSize() > 0) addButton(0, "Repeat after me", tifaMainMenuSexRepeatAfterMe);
	else addButtonDisabled(0, "Repeat after me", "Req. breast and pussy.");
	if (player.gender > 0) {
		addButton(1, "Sixty 9", tifaMainMenuSexSixty9);
		addButton(2, "Breast Play", tifaMainMenuSexBreastPlay);
	}
	else {
		addButtonDisabled(1, "Sixty 9", "Not for genderless ones.");
		addButtonDisabled(2, "Breast Play", "Not for genderless ones.");
	}
	addButton(3, "Sex with the queen", tifaMainMenuSexWithTheQueen)
		.disableIf(!player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden), "Req. <b>bee</b>ing a little more like bees.");
	addButton(4, "Back", tifaMainMenu);
}

public function tifaMainMenuSexRepeatAfterMe():void {
	clearOutput();
	outputText("How about a seance of bonding in her own style. You would like to see her own take on the game bee girls play between their egging mission.\n\n");
	outputText("\"<i>That’zzz a great idea [name]. Pleazzze allow me to show you how beezzz bond together.</i>\"\n\n");
	outputText("She takes the lead, moves a bit to the side and pats the spot next to her. You"+(player.isNaked()?"":" first slip out of your [armor], then")+" sit your [ass] next to her. You sit there a bit nervously and wonder what she plans to do. \"<i>Repeat after me [name] it will be very good.</i>\" ");
	outputText("She intones before giving a soft buzzing giggle and sliping one of her hands into her honey pot, liberally covering it in her private sweetness. You follow suit slipping your fingers to your [vagina] and barely cover them with your own fluids.\n\nShe raises her drenched hand, gives it a playful lick, and moves it down to your moist, [pussy] while you do the same to hers. ");
	outputText("You gasp as her honey covered lower fingers quickly slip inside your [pussy] and start to wriggle around. You try to focus on matching her stimulations. While you can hear her gasp in enjoyment from your ministrations, you can barely keep your mind straight, let alone match her expert movements. Tifa however, goes one step further sending one hand to your chest to cup your [breasts]. ");
	outputText("You follow the movement, putting your hand to her own set as she gently starts tweaking your nipples. You both moan in delight as your nipples go hard from the delicious ministrations, your pussy only feeling even better. Keeping your brain from becoming mush becomes especially difficult when she brings her thumb and index finger to your little pleasure-buzzer.\n\n");
	outputText("Still, you manage to hold on against the sensations and continue to run your fingers through her honey coated lower lips and left breast while hers play with yours. It is actually a pretty fun bonding experience, and you feel closer to Tifa at the end when both of you cum over each others fingers together.\n\n");
	outputText("\"<i>I hope you liked it, [name]</i>\"\n\n");
	outputText("You sure did and would look forward to doing it again in the future.\n\n");
	player.sexReward("vaginalFluids", "Vaginal");
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuSexSixty9():void {
	clearOutput();
	outputText("Well so long as she doesn’t take a penis in her woman hole she is fine with sex right? Must be hard for her not to get off otherwise than by herself.\n\n");
	outputText("\"<i>I can azzzk a handmaiden to play with me but yezzz I’m pretty zzzure it’zzz far from the zzzame thing.</i>\"\n\n");
	outputText("How about the two of you try out something the handmaidens won’t do? You hint at a sixty nine and Tifa blushes right away.\n\n");
	outputText("\"<i>Woa indeed that’zzz zzzomething elzzze, letzzz get to it.</i>\"\n\n");
	outputText(""+(player.isNaked()?"":"You proceed to get out of your gear in order to display your [skin] to her. Tifa is already licking her lips in anticipation. ")+"You gently shove Tifa on her back passing your hand on her honeypot then back to your mouth for a swift taste. Tifa gasps and blushes as you lower your head toward her honey hole to properly lap at it, making her moan in appreciation as you move your back towards her face, ");
	outputText("giving her a visual on your "+(player.hasVagina()?"[pussy]":"")+(player.gender == 3?" and ":"")+(player.hasCock()?"[cock]":"")+".\n\n");
	if (player.gender == 1) outputText("Tifa is swift to grab your juicy member, sliding its length in her mouth. You can feel her long bee tongue wrapping around your cock inside and this makes you all the more happy to lick her cunt.\n\n");
	else if (player.gender == 2) outputText("Tifa is swift to also get to the job of her tongue going inside your pussy like a small tentacle. "+(player.clitLength >= 3?"She swiftly finds your clitoris and wraps her appendage around it, jerking it off from the inside of your pussy just like a cock. ":"")+"You moan in delight your own juices starting to flow out just as well as hers.\n\n");
	else outputText("Tifa is swift to grab your juicy member, sliding its length in her mouth. You can feel her long bee tongue wrapping around your cock inside and this makes you all the more happy to lick her cunt. Your own pussy isn’t left hanging either as she takes it upon herself to jam a few fingers inside.\n\n");
	outputText("You try to keep pace with her but her tongue job proves a supremely difficult technique to match. Her licking is actually so good that mid way you practically jam your genitals in her face trying to "+(player.hasCock()?"pump your dick into her mouth":"ram your pussy onto her tongue")+". Her bee wings are flapping wildly, causing a constant buzzing and not surprisingly this drives you even wilder. ");
	outputText("Thankfully her boiling point appears to be lower than yours and you both cum at once splattering each others mouths with fluids. To Tifa’s honors she drinks it all"+(player.hasCock()?"":" her tongue allowing her to lick your pussy clean with next to no effort")+".\n\n");
	outputText("You both lay in the grass still lost in the afterglow of your licking session, Tifa’s wings and abdomen convulsing periodically. After an hour or two you both redress highly satisfied from the experience.\n\n");
	player.sexReward("vaginalFluids", "Lips");
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuSexBreastPlay():void {
	clearOutput();
	outputText("In your lust riddled haze you can’t help but fawn over Tifa’s stellar body. Her large breasts, soft delicate skin, those plump thighs, and that slick blessing of a honeypot in between her legs. Just thinking about getting an ample helping of her lavish banquet causes you to start drooling, unbeknownst to you.\n\n\"<i>[name], what izzz it your thinking about? You’re drooling. Izzz my body really that entizzzing to you?</i>\" ");
	outputText("Tifa giggles as she wipes away the line of drool from your mouth. Her actions only emphasize that supple body of hers. The way she moves her body to press against yours as she wipes away your drool, her arm squishing her breasts together making them more pronounced, the slight bend in her form, the playful glint in her eyes, and that sweet enrapturing smell of honey protruding from her body is overwhelming your senses. You MUST have her!\n\n");
	outputText("\"<i>Oh~, [name], that look in your eye izzz a bit worryi-</i>\" You cut her off as you grab her arm and pull her in, locking lips with the bee woman and pressing her head into yours so she can’t pull back. At first, the speed and ferocity of your sudden attack startled Tifa, her wings rapidly beating in hopes of pulling away from you but you never let up. Eventually, your kissing prowess melted away her resistance, and now she can’t help but moan as she pushes her body into you, making it clear she wants you. ");
	outputText("You immediately take control of the kiss, your tongue breaking through her lips and dominating her tongue. You’re relentless in your conquest, roving your tongue over every crevice of her mouth while holding her against you."+(pcGotTentaclesForFun()?" Your "+(player.stamenCocks()>0?"vines":"tentacles")+" roaming over every bit of that delicious skin, teasing and tickling every bit of flesh they encounter.":"")+"\n\n");
	outputText("You finally pull back, having finished ravaging her oral cavern and ready to move on to your main conquest. Tifa looks delirious as she reels from your assault, unable to speak as she tries to regain her breath. You’re far from done with her. Licking your lips, that sweet aroma renews its assault on your senses. It seems she enjoyed being played with so roughly, the slutty bitch. Getting another eyeful of her alluring body, an idea pops into your head.\n\n");
	outputText("\"<i>[name], I-</i>\" you quickly silence her with a quick kiss, telling her that you’ll take good care of her. She makes to reply but then stops herself, allowing you to take the lead.\n\nYou softly lay her on the ground, once again reassuring her that she’ll love this and kiss her on the forehead. ");
	outputText(""+(player.isNaked()?"":"You remove your [armor], making sure to give her a show by slowly removing each piece and revealing your tantalizing [skin]. ")+"Her eyes drink in your form with painfully obvious want, her honeypot doing its best to imitate a broken dam as honey pools beneath her. With the obvious sign that she’s ready and her delectable body at your mercy, you set about your work.\n\nYou lock lips with her again, softly this time, your tongues entwining and coiling. Your fingers play down her chest, ");
	outputText("teasing her skin"+(pcGotTentaclesForFun()?" along with your "+(player.stamenCocks()>0?"vines":"tentacles")+" as you set them back to work":"")+". You reach her drooling slit and penetrate her with two fingers. She gasps and pulls you closer, her hips bucking into your fingers. It’s a wonder she could control herself for so long. Nevertheless, you smile at her display of need for you and drive your fingers deeper, hilting them. Her body lurches in a mini-orgasm, and you collect as much honey as you can on your fingers.\n\n");
	outputText("Pulling them free of her greedy muff, you give Tifa a good look at the mess she made. \"<i>W-why did you stop?</i>\" Tifa whines while thrusting her hips, hoping to get you back to pleasuring her. You only laugh and proceed to mount her mashing your chest against her. A final chaste kiss is planted on her lips before you go to work. You lather up her mounds with honey, paying special attention to those glorious peaks of hers. ");
	outputText("Tifa gives you a confused look before arching her back in pleasure as you attack her now incredibly sensitive peaks, the bee’s honey working as you thought. It’s working so well that Tifa is practically screaming as your tongue is dragged over every inch of her breasts, tickling, sucking, licking, and teasing while you devour the delicacy that is her shameless lust.\n\n");
	outputText("The honey has an effect of its own on you, spiking your want for her. Her cries are of the sweetest tune, her movements against your flesh ignites your nerves. All of these feelings at once make you lose yourself to your lust for her, nothing matters apart from her screams of want and desire.\n\n");
	outputText("Your hand shoots down to her leaking lips again, this time three fingers dive in and fuck her pussy, your only desire is to hear her orgasmic cries again. Remorseless in your aim, Tifa is helpless against the wonton onslaught of your skilled digits and she soon convulses in orgasmic rapture, her screams of release echoing off into the distance. Collecting the copious amounts of fluids. ");
	outputText("You slather her breasts again, coating them with her sweet nectar and move to devour it again. Not willing to go a second without hearing her blissful cries, your hand plunges into her depth once more to excavate more of her precious liquid. You think you can hear Tifa begging you for something, but you don’t care what it is. Those aren’t her moans and cries of pleasure, they mean nothing to you.\n\n");
	outputText("Soon she’s reduced to pathetic whimpers and hoarse whispers, her body falling to your reckless assault on her senses. Eventually you can’t ignore your lust and ");
	if (player.hasCock()) outputText("grab your [cock biggest]"+(player.cocks.length > 1?" and [cock biggest2]":"")+" jerking them vehemently"+(pcGotTentaclesForFun()?" while you divert some of your tentacles towards your own needs, penetrating your [ass], teasing your chest"+(player.biggestTitSize()>0?" [breasts]":"")+", and forcing one to fuck your throat while the rest shamelessly play with Tifa’s vulnerable body":"")+".");
	else outputText("plunge your honey coated digits into your [vagina]"+(pcGotTentaclesForFun()?" and divert some of your tentacles towards your needs, plunging them into your [ass], teasing your chest"+(player.biggestTitSize()>0?" [breasts]":"")+", and forcing one to fuck your throat while the rest shamelessly plays with Tifa’s vulnerable body":"")+".");
	outputText("It doesn’t take long for you to reach your peak, ");
	if (player.hasVagina()) outputText("your cunt divulging its lusty payload all over Tifa’s abdomen"+(player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLAVERING?" your cunt squirting its lusty payload all over Tifa’s chest":"")+"");
	if (player.gender == 3) outputText(" and ");
	if (player.hasCock()) {
		outputText("your cock"+(player.cocks.length > 1?"s":"")+" exploding, coating Tifa’s chest and face in a ");
		if (player.cumQ() < 100) outputText("few strings of semen");
		else if (player.cumQ() < 500) outputText("large amount of semen,  her upper body now a mix of brown and white");
		else if (player.cumQ() < 2000) outputText("hefty amount of cum, her upper body mostly coated in your blessing");
		else outputText("massive amount of your baby batter, her upper body no longer recognizable as a result of the copious amount of spooge covering her");
	}
	outputText(".\n\nFinally spent, you collapse down beside her and drift off to sleep, satisfied with your little escapade.");
	if (player.hasCock()) player.sexReward("no", "Dick");
	if (player.hasVagina()) player.sexReward("no", "Vaginal");
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuSexWithTheQueen():void {
	clearOutput();
	outputText("You cheerfully walk over to Tifa’s sizable ovipositor, anticipating with glee what it will be like to be filled by it. Tifa waves in happiness, glad to see you came for more. Ready for your queen to fill you, you lay down comfortably to receive the eggs.\n\n");
	outputText("\"<i>Herezzz your load love, do come back afterwardzzz you know I have plenty.</i>\"\n\n");
	outputText("You don’t get much of a chance to reply anything, as Tifa promptly takes it upon herself to jam the royal tool inside your honeypot. You shriek in pleasure from the sudden intruder filling your body. Your legs quickly fail you, and you topple over, thankfully one of your many bee girlfriends catches you before you hit the floor. You don’t pay much attention though, you’re too busy seeing white from the intense penetration going on between your legs.\n\n");
	outputText("Tifa’s ovipositor soon starts to unload huge amounts of bee eggs deep into your womb, filling you up. You cum at once, this is what you were meant to do. This is what you want to spend your whole life doing. It feels so damn good to be filled up by her, and her satisfaction at the sentiment within your mind only makes it better.\n\n");
	outputText("Another orgasm passes through your body, and you look behind yourself to see your filled up abdomen, feeling how bloated it has become. In fact, when you can feel that it is still growing, your body is pushed over the edge of another orgasm.\n\n");
	outputText("It doesn’t take much longer for the process of being filled with your lover’s eggs to finish, and the stinger is retracted from your body. You pant, exhausted and mushy from the ordeal. It's time to head out now and find someone to carry these.\n\n");
	player.sexReward("no", "Vaginal");
	player.setPerkValue(PerkLib.BeeOvipositor, 1, player.maxEggs); //get the eggs
	player.fertilizeEggs();
	player.trainStat("lib", +1, player.trainStatCap("lib",100));
	player.dynStats("cor", -10);
	doNext(tifaMainMenuTalkReturn);
}
private function pcGotTentaclesForFun():Boolean {
	return player.lowerBody == LowerBody.FLOWER_LILIRAUNE || player.tentacleCocks() > 0 || player.stamenCocks() > 0;
}
	}
}