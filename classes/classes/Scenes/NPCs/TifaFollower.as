package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
	
public class TifaFollower extends NPCAwareContent
	{
		
		public function TifaFollower() 
		{
		}

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
	addButtonDisabled(3, "Sex", "Soon.");
	addButton(4, "Back", camp.campFollowers);
}

public function tifaMainMenuAppearance():void {
	clearOutput();
	outputText("Tifa is a bee girl. Her flowing, yellow and black, hair is kept short and flat on her head accentuating her tomboyish outlook. Her eyes, like most bees, are solid black though you somehow can always figure where she is looking at. Above her hair rests a pair of antenna which from what you know allows for mental communication with the rest of the hive. ");
	outputText("Not being a full fledged queen yet, she is still capable of moving around.\n\n");
	outputText("Her arms and legs are covered with black armor like chitin. The chitin on her limbs climbs up to the middle of her thighs and shoulders ending with yellow fuzz. A large pair of diaphanous wings rest on her shoulders. From her well-shaped ass protrudes her abdomen covered in armor like chitin. At the tip of said abdomen of course rests her stinger from which venom occasionally drips off.\n\n");
	outputText("Tifa is gifted with a pair of pert breasts easily reaching D cup and her wasp shape, all bugs jokes avoided, would be difficult to beat.\n\n");
	outputText("Her pussy ever drips with a steady flow of honey albeit not as much as the handmaidens.\n\n");
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
	addButtonDisabled(3, "Handmaiden", "Become her handmaiden.");
	addButton(4, "Back", tifaMainMenu);
}
public function tifaMainMenuTalkReturn():void {
	clearOutput();
	outputText("\"<i>Anything Elzzze you want to talk about then?</i>\"\n\n");
	menu();
	addButton(0, "Her", tifaMainMenuTalkHer);
	addButton(1, "Bee life?", tifaMainMenuTalkBeeLife);
	addButton(2, "Relations", tifaMainMenuTalkRelations);
	addButtonDisabled(3, "Handmaiden", "Become her handmaiden.");
	addButton(4, "Back", tifaMainMenu);
}

public function tifaMainMenuTalkHer():void {
	clearOutput();
	outputText("So can she talk about herself, starting with why her sister said she was rebellious?\n\n");
	outputText("\"<i>Thatzzz becauzzze I refuzzze to become a queen. I want to zzzee the world outside of a hive and a constantly pregnant abdomen won’t allow zzzuch a thing. You could zzzay I dezzzerted my functionzzz in the hive. Once I have zzzeen enough I will take my place azzz a queen and form a hive.</i>\"\n\n");
	outputText("So wait she was scorned by the other bees for actually refusing to become a queen?\n\n");
	outputText("\"<i>You could zzzay it’zzz like that, yezzz.</i>\"\n\n");
	if (flags[kFLAGS.TIFA_FOLLOWER] == 6) flags[kFLAGS.TIFA_FOLLOWER]++;
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuTalkBeeLife():void {
	clearOutput();
	outputText("What is the life of a bee actually, is everyone always in agreement with the queen? What of the lesser bees? Are they actually able to make their own choices?\n\n");
	outputText("\"<i>Thatzzz a zzztrange quezzztion [name] I can only guezzz you mean to want to know how beezzz live and how the cazzzte zzzystem workzzz. Well truth izzz everyone in a hive izzz zzzort of linked telepathically to the queen. Do not think of thizzz azzz zzzome form of dictature, the beezzz work becauzzze they want to pleazzze her and becauzzze nothing makezzz them feel more accomplished than ");
	outputText("making their queen proud and happy. Every child lookzzz up to hizzz or her parent and zzzince everyone izzz born from the queen everyone obeyzzz her unquezzztionably. Uzzz princezzz are different. We are bound to one day rule our own hive and for thizzz reazzzon our mind izzzn’t linked to that of the queen. We make our own choicezzz and decizzzion without anyone telling uzzz otherwizzze. ");
	outputText("Zzztill azzz free willed azzz a queen might be, her huge pregnant body doezzz not allow much mobility thuzzz a bee queen never leavezzz itzzz throne room. Lezzzer beezzz have free will like anyone elzzze however their unwavering devotion to their mother the queen izzz enough of a motivation. Even if offered to zzztop working for a few dayzzz mozzzt beezzz would feel horribly guilty for zzzlacking.</i>\"\n\n");
	if (flags[kFLAGS.TIFA_FOLLOWER] == 7) flags[kFLAGS.TIFA_FOLLOWER]++;
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuTalkRelations():void {
	clearOutput();
	outputText("What's the standing of relations between bees and the other races."+(player.phoenixScore() >= 10 ? " You overheard that the sand witches and harpies had very close relationships with the hives.":"")+"\n\n");
	outputText("\"<i>While the hivezzz are open to any alliance that may involve willing incubatorzzz for our eggzzz, outsiderzzz aren’t allowed in the hivezzz proper and are limited to parley with the queen’zzz emizzzary, often a handmaiden. Thizzz helpzzz keep threats to the hive outzzzide, however azzz you might have notizzzed thizzz izzz not a failproof zzzolution and ");
	outputText("zzzometimezzz a corrupted bee hazzz to be put down for the good of everyone.</i>\"\n\nWhat does it take for outsiders to gain entry then?\n\n");
	outputText("\"<i>Outsiderzzz don’t gain entry. They never do. However zzzome bee morphzzz who aren’t affiliated to a hive are zzzometimezzz allowed the gift of bonding. As you may know pure bee honey hazzz powerful tranzzzformative capabilitiezzz and can fully transform even a native marethian into a bee morph. For mozzzt thizzz izzz azzz far azzz it goezzz azzz even thizzz tranzzzformativezzz cannot fully grant you our anatomy. ");
	outputText("However the queen’s royal honey izzz even more potent than the regular unrefined honey azzz it can turn a bee morph into a full fledged bee drone or handmaiden and a child of the queen in blood. Thizzz change alzzzo allowzzz the queen to establish a mental link to the hive with the petitioner. Do underzzztand however that once in the hive you are in it for life both in body and zzzoul. ");
	outputText("Even the mozzzt unruly petitioner will inevitably fall in line due to the mental conditioning impozzzed by the hive mind. Thizzz izzz not brainwashing but the rezzzult izzz about the zzzame. Again mozzzt petitionerzzz are either egging enthuzzziast or malezzz who became zzzo addicted to their bee dickzzz they zzzimply dezzzided to fully embrace the lifezzztyle of a drone.</i>\"\n\n");
	outputText("Well this is nice to know.\n\n");
	if (flags[kFLAGS.TIFA_FOLLOWER] == 8) flags[kFLAGS.TIFA_FOLLOWER]++;
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuTalkBecomeHerHandmaiden():void {
	clearOutput();//"Become her handmaiden" - button name
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	doNext(tifaMainMenuTalkReturn);
}

public function tifaMainMenuSex():void {
	clearOutput();
	outputText("You’re feeling antsy, does the bee have anything on her mind she would like to show you?\n\n");
	outputText("\"<i>Well sure, we could play a bee game or go for something else on your mind, what would it be?</i>\"\n\n");
	menu();
	addButton(0, "Repeat after me", tifaMainMenuTalkHer);
	addButton(1, "Sixty 9", tifaMainMenuTalkBeeLife);
	addButton(2, "Breast Play", tifaMainMenuTalkRelations);
	addButton(4, "Back", tifaMainMenu);
}

public function tifaMainMenuSex1():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	//sex reward
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuSex2():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	//sex reward
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
public function tifaMainMenuSex3():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	//sex reward
	tifaAffection(10);
	doNext(tifaMainMenuTalkReturn);
}
	}
}