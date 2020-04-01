/**
 * ...
 * @author Ya Boi Guzma
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.display.SpriteDb;
	
	public class ExcelliaFollower extends NPCAwareContent implements TimeAwareInterface
	{
		public var pregnancy:PregnancyStore;
		
		public function ExcelliaFollower() 
		{
			pregnancy = new PregnancyStore(kFLAGS.EXCELLIA_PREGNANCY_TYPE, kFLAGS.EXCELLIA_PREGNANCY_INCUBATION, 0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 420, 320, 210, 150, 60);
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

public function ExcelliaPathChoice():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (followerShouldra()) {
		outputText("When you arrive back at camp you notice the cow-queen Excellia sitting patiently by your bedroll, seemingly waiting for your return. Approaching carefully, she gently opens her eyes and reveals to you that Shouldra is still driving the Queen.\n\n");
		outputText("\"<i>Hey, champ! Good to see ya again! ...Does this mean you managed to defeat Lethice?</i>\"\n\n");
		outputText("She stands up, bringing herself to her full height. She must be over seven feet tall, you realise as she pulls you into a soft, squishy embrace. Her tail gently caresses your butt, and she lets out a moo of happiness. Pulling away, she looks at you.\n\n");
		outputText("\"<i>Well, I guess it's time for me to leave this body~</i>\"\n\n");
		outputText("You look into Shouldra's eyes as she leans forward, lips puckered. Happy to oblige, you kiss her fiercely, golden lipstick sending sensations rushing through your body. Her tongue searches hungrily in your mouth, exploring it's depths with zeal. You feel the odd sensation as Shouldra leaps across the gap, worming her way back into you. Excellia's eyes fade from gold back to a lighter yellow colour, before rolling back in her head and collapsing suddenly to the ground.\n\n");
		outputText("\"<i>Huh... I wondered why she wasn't fighting me. She's still exhausted from being ravaged by the minotaur king... I'm sure she'll wake up in a few hours, though</i>\"\n\n");
	}
	else {
		outputText("When you return, you bring her to your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin and lay her on your bed":"tent and lay her on your bedroll")+" . You're pretty sure she'll come to in a few hours or so.\n\n");
	}
	doNext(ExcelliaPathChoice2);
}
public function ExcelliaPathChoice2():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("For the past few hours you've been sitting "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "in a chair":"inside your tent")+" waiting for the ex-cow queen to wake up. You find yourself dozing off a bit. Just as you're about to close your eyes you hear Excellia stirring. You look over to see the cow sitting up. She looks around somewhat dazed and confused, unsure of where she is. Her yellow eyes fall onto you but they appear glazed over and vaguely aware.\n\n");
	outputText("\"<i>" + player.mf("Lord", "Lady") + "…? My... " + player.mf("Lord", "Lady") + "… Is it time?</i>\"\n\n");
	outputText("Time? Time for what exactly?\n\n");
	outputText("\"<i>To make use of my shameless pussy my " + player.mf("Lord", "Lady") + ". I am always willing and wanting for you… Please don't keep me waiting!</i>\"\n\nThe cow slut gets up on her hands and knees then turns around, lifting up her tail and presenting her large curvaceous ass and dripping womanhood. ");
	outputText("She either thinks you're the Minotaur King or she simply can't think clearly with her cum addicted mind. After spending so long under the effects of minotaur spunk, that seems to be the only thing on her mind at the moment. Looking at the slight jiggle her ass gives with each ragged breath is more than tempting. Though you're not sure if that would be a good idea if you want to help restore her. What will you do?");
	flags[kFLAGS.EXCELLIA_MAN_UP_BEER] = 0;
	flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] = 0;
	flags[kFLAGS.EXCELLIA_LA_BOVA] = 0;
	menu();
	addButton(1, "Fix Her", ExcelliaPathChoiceFixHer);
	addButton(3, "Make Slave", ExcelliaPathChoiceMakeSlave);
}
public function ExcelliaPathChoiceFixHer():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You shake your head, chasing away the thought. While it would probably feel more than amazing to take the ex-cow queen in this manner, it would probably do more harm than good at this given point and you let her know that much by getting up and turning her back around. She looks up at you, confused as to why you didn't take her. You explain to her that she doesn't have to service you. Her confusion seems to deepen.\n\n");
	outputText("\"<i>I… don't understand… You don't want me…?</i>\"\n\n");
	outputText("It's not that you don't want her, it's just that she doesn't have to do it all the time. There is more to life than just slutting. The cow girl shakes her head, obviously upset.\n\n");
	outputText("\"<i>I've been good I swear! P-Please use me! I-</i>\"\n\n");
	outputText("You shush her, telling her to calm down. She isn't a slave to the Minotaur King anymore. She doesn't have to be forced to serve anyone nor does she need to be impaled on mino dick every waking moment of the day. Excellia sits in silence staring at the floor. You're not entirely sure if your words are even reaching her. Maybe in time perhaps. For now you need to get her sleeping arrangements in order. You sigh then grab her hands, urging her to get up.");
	outputText(" She looks up at you hopeful.\n\n\"<i>My " + player.mf("Lord", "Lady") + "? Have you changed your mind?</i>\"\n\n");
	outputText("You tell her that you're going to help her get settled in for the time being then head outside with her. She looks around almost in awe, almost as if she’s barely seen the outside world. You find a good place for her to stay then sit her down as you head off to fetch some supplies for a tent and a bedroll. ");
	outputText("When you return you find the ex-cow queen obediently waiting where you left her. In no time flat, you set up her tent and bedroll, making it as cozy as possible. You tell Excellia that this is where she can sleep from now on. She looks at her tent then back at you, biting her lip nervously.\n\n");
	outputText("\"<i>Does this mean you’ll finally make use of me my " + player.mf("Lord", "Lady") + "?</i>\"\n\n");
	outputText("You explain to her that she doesn’t need to call you that. She also doesn’t need to be used in that manner either. She isn’t a slave to the Minotaur King anymore after all and you’re not like him either nor will you ever be. That’s one point you wish to make very clear with her. She looks at you, crestfallen, having been denied a second time. Instead of saying anything else, she crawls into her tent letting out a pitiful moo. ");
	outputText("Once she’s inside, you let out a shaky sigh. While it was hard enough to resist the curvaceous cowgirl’s advances, you know this is the best for her at the moment. That tainted minotaur cum constantly pumped into her more than likely turned her into a full cow slut but maybe given enough time, you can help bring her back around mentally and physically… in your own way. Some items could help too.\n\n");
	outputText("(<b>Excellia has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.EXCELLIA_RECRUITED] = 3;
	doNext(camp.returnToCampUseFourHours);
}
public function ExcelliaPathChoiceMakeSlave():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("It’s hard to resist a cowslut presenting herself to you begging to be fucked and you’re more willing to oblige.\n\n");
	if (player.hasCock()) {
		outputText("You waste no time "+(player.isNaked() ? "":"stripping off your gear and ")+"stepping up behind the ex-cow queen then grabbing her hips. You grind your [cock] between her large jiggly ass cheeks. Her tail swishes back and forth as she eagerly waits for her treat. She looks back over her shoulder at you, a deep blush present on her face. She pushes back against you every time your rock hard cock rubs against her pussy.\n\n");
		outputText("\"<i>P-Please my " + player.mf("Lord", "Lady") + "! I can't wait any longer. My pussy needs your cock!</i>\"\n\n");
		outputText("You deliver a sharp smack across her ass. You're the one who will decide when she's granted the pleasure of receiving your dick. She whimpers and lets out a needy moan as you continue to fuck her fat cheeks. Her massive milky mammaries slowly leak their euphoric sweet cream onto your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+". The huge soft orbs jiggling freely with every breath their owner takes. ");
		outputText("The bovine slut moos pleadingly for your [cock] inside her. You slide your dick across her entrance, coating yourself in her slick lubricants in preparation. With little warning, you slip your shaft into her, stretching her big pussy lips into a warm embrace. Rearing back, you slam your groin into Excellia's needy cunt, grinning as she sprays fem lube around your [cock]. She lets out a fulfilled moo as you finally penetrate her.\n\n");
		outputText("You pick up the pace, giving her rough, strong thrusts until your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+" is sodden with her juices and thick blobs of your pre-cum. You reach forward and grab her massive milk gushing tits. She groans and moos as you manhandle her chest and milk her. You slam your dick into her depths with increased ferocity until she throws her head back and screams, cumming hard around your dick. ");
		outputText("You thrust your way through it, riding out her powerful contractions and bucking until she’s panting and heaving, and her flow seems to pick up more. You're hardly done with the cum slut. You plow into her harder, sinking your fingers into her squishy cheeks as you pound her soaked cunt. Her lube and femcum helping you to slam in and out of her at pelvis breaking speeds. She moos loudly, but it turns into a muffled yelp when you shove her face into your ");
		outputText("now soaked "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+" and yank on her tail, causing her passage to squeeze like a vice around you. Slick and tight, Excellia’s cow-cunt is the perfect hole for your needy [cock]. You roar and yank her tail one last time, splattering her innermost depths with your hot baby batter until her belly begins to bloat with the sheer amount of cream you’re pumping into her.\n\n");
		outputText("You pull out, jerking off the last of your seed onto her ass and back. You grin as the slutty cow-girl collapses in the pool of spunk, femcum, and milk you’ve made beneath, her exhausted and panting. You roll her onto her back, laughing at her blissed expression. Her eyes are rolled back into her head and her tongue lolls out.\n\n");
		outputText("\"<i>T-Thank you my " + player.mf("Lord", "Lady") + "... I… am always… here to serve you…</i>\"\n\n");
		outputText("You pat your new cum receptacle on the head and tell her that you'll be sure to make great use of her. She lets out a tired moo before drifting off to sleep again. Your grin widens as you think of more ways to use her.\n\n");
	}
	else {
		outputText("You waste no time "+(player.isNaked() ? "":"stripping off your gear and ")+"stepping up to the ex-cow queen then turn her around. You tell her to get to it then lower her head down to your pussy. Excellia lifts her head and begins desperately licking and slurping your pussy. She blows on your clit, causing you to gasp in pleasure. The cow slut licks you until your first orgasm rocks you, drenching her face and mouth with femcum. ");
		outputText("She quickly slurps down your juices, not wasting a single drop.\n\n\"<i>P-Please my Lady… M-More…</i>\"\n\n");
		outputText("Now with such a slutty look on her face, who are you to deny your new fuckpet? She pushes her mouth against your snatch, tightly sealing her mouth around your dripping snatch before diving her tongue back in. You moan and grip her horns tightly, mashing her face further into your pussy. The cow slut is eager to lap every little drop of femcum that spills from you. Her tongue pushes you closer and closer to the edge. ");
		outputText("When she sucks your clit into her mouth, a body rocking orgasm tears through you. Your juices floods her mouth as she greedily gulps it all down. You keep feeding her more of your femcum, your orgasm seemingly lasting an eternity. Excellia rubs her growing belly as it rounds out from the amount she's drinking. Her pussy and milk filled jugs leaks like a running faucet, adding to the growing puddle beneath her.\n\n");
		outputText("With a satisfied sigh, you let go of her and get up. The ex-cow queen slumps down with a dreamy expression on her face.\n\n");
		outputText("\"<i>T-Thank you my Lady… I'm always… willing to serve you…</i>\"\n\n");
		outputText("After that she sinks down then drift off into sleep. You pat the sleeping cow slut on the head. You grin thinking of new ways to use your new fuckpet.\n\n");
	}
	outputText("(<b>Excellia has been added to the Slaves menu!</b>)\n\n");
	flags[kFLAGS.EXCELLIA_RECRUITED] = 2;
	player.orgasm();
	doNext(camp.returnToCampUseFourHours);
}

public function ExcelliaCampMainMenuFixHer():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (pregnancy.isPregnant && pregnancy.incubation == 0) {
		ExcelliaPoopsBabies1();
		pregnancy.knockUpForce(); //Clear Pregnancy
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	switch (pregnancy.event) {
		case 2: outputText("You notice that Excellia seems to have a small swell in her belly. She has been eating more frequently.\n\n");
				break;
		case 3:
		case 4: outputText("The swell in Excellia's belly has grown out into a noticeable bump. You get the distinct feeling that she might be pregnant.\n\n");
				break;
		case 5: outputText("Excellia's baby bump has grown larger. Her huge breasts begin to leak more often due to her increased milk production. She smiles warmly, gently rubbing her hands over her round belly and giggling when she feels the baby kick. She looks over to you with a loving look in her eye.\n\n");
				outputText("\"<i>Not much longer now...</i>\"\n\n");
				break;
		case 6: outputText("Excellia looks about ready to give birth any day now. Her huge breasts now leak steady streams of sweet milk. Her large belly is swollen with her child. You can occasionally see a little movement in her belly as the child inside squirms around. You head on over to her to make sure she's alright. She looks at you with a loving smile.\n\n");
				outputText("\"<i>I'm fine… He or she is getting pretty restless… With such strong kicks too! I suppose it's almost time to come out.</i>\"\n\n");
				outputText("You smile at her then reach over to touch her stomach. She coos when you gently rub her belly. You chuckle when you feel your baby kick from the gentle touches. Already so lively and strong. Given her size, it's probably almost time for her to give birth.\n\n");
				break;
		default:
	}
	ExcelliaCampMainMenuFixHer2();
}
public function ExcelliaCampMainMenuFixHer2():void {
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) {
		outputText("When you approach, the sizable cowgirl turns to you with a warm smile on her face.\n\n");
		outputText("\"<i>Hello, [name]! Something you need?</i>\"\n\n");
	}
	else {
		outputText("When you approach, the ex-cow queen eagerly crawls up to you.\n\n");
		outputText("\"<i>My " + player.mf("Lord", "Lady") + "! Have you finally come to take me? Oh, please say yes!</i>\"\n\n");
	}
	menu();
	addButton(0, "Appearance", ExcelliaCampFixHerAppearance);
	addButton(1, "Herself", ExcelliaCampFixHerHerself);
	addButton(3, "Get Milk", ExcelliaCampFixHerGetMilk);
	addButton(4, "Give Items", ExcelliaCampFixHerGiveItems);
	addButton(7, "Sex", ExcelliaCampFixHerSex);
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) {
		addButton(2, "Talk", ExcelliaCampFixHerTalk);
		if (player.hasPerk(PerkLib.BasicLeadership)) {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButton(5, "Team", excelliaHenchmanOption).hint("Ask Excellia to join you in adventures outside camp.");
			else if (flags[kFLAGS.PLAYER_COMPANION_1] == "Excellia") addButton(5, "Team", excelliaHenchmanOption).hint("Ask Excellia to stay in camp.");
			else addButtonDisabled(5, "Team", "You already have other henchman accompany you. Ask him/her to stay at camp before you talk with Excellia about accompaning you.");
		}
		if (flags[kFLAGS.SLEEP_WITH] != "Excellia") addButton(6, "Sleep With", ExcelliaCampFixHerSleepToggle);
		else addButton(6, "Sleep Alone", ExcelliaCampFixHerSleepToggle);
	}
	else {
		addButtonDisabled(2, "???", "You need Excellia fixed to unlock this option.");
		addButtonDisabled(5, "???", "You need Excellia fixed to unlock this option.");
		addButtonDisabled(6, "???", "You need Excellia fixed to unlock this option.");
	}
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) addButton(14, "Back", camp.campLoversMenu);
	else addButton(14, "Back", camp.campFollowers);
}
public function ExcelliaCampFixHerAppearance():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("Excellia is a 7 feet 2 inches tall "+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1 ? "human female":"cowgirl")+", formerly the cow queen to the Minotaur King. Her smooth skin is light brown in color"+(flags[kFLAGS.EXCELLIA_LA_BOVA] == 2 ? " underneath red fur":"")+". She has a "+(flags[kFLAGS.EXCELLIA_LA_BOVA] == 2 ? "cow like":"human")+" face. Her eyes are yellow. She has a set of pouty lips coated in golden lipstick. She has a pair of "+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1 ? "human shaped":"cow like")+" ears pierced with gold hoop earrings, ");
	outputText("parting her long curly red hair with yellow highlights. A gold jewel encrusted tiara sits on her head. "+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1 ? "A pair of short bovine horns decorated with gold horn rings stick up from her head. They're not as long as minotaur horns but much longer than cow horn. ":"")+"Strapped around her neck is a gold jewel encrusted cowbell. She ");
	if (flags[kFLAGS.EXCELLIA_MAN_UP_BEER] == 4) outputText("has a bevy of pleasantly defined muscles");
	else if (flags[kFLAGS.EXCELLIA_MAN_UP_BEER] > 0) outputText("has some visible musculature");
	else outputText("is very soft and plump with no visible muscles");
	outputText(". A strange tattoo marks her stomach.\n\n");
	if (flags[kFLAGS.EXCELLIA_LA_BOVA] > 0) outputText("Her arms are "+(flags[kFLAGS.EXCELLIA_LA_BOVA] == 2 ? "almost human in shape with thick hoof like fingernails":"human in shape and structure")+". Her oddly jointed bovine legs are covered in red fur. ");
	else outputText("Her arms and legs are both human in shape and structure. ");
	outputText("She wears gold bangles around her wrists and ankles. A tattoo marks her left leg. She has plump thick thighs."+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1 ? "":" A cow tail tipped with red hair and decorated with a gold tail ring swishes above her large ass.")+"\n\n");
	outputText("She has fat milk filled F cup sized breasts. Her nipples are pierced with golden nipple rings.\n\n");
	outputText("Between her legs is a constantly dripping vagina with a 1.5 inch large clit. A small teardrop shaped patch of red hair sits above it.\n\n");
	outputText("She has a somewhat tight anus between her cheeks where it should be.\n\n");
	outputText("When Excellia catches you staring, she giggles a bit as her tail swishes excitedly back and forth"+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1 ? " she giggles then blows a kiss at you":"")+".\n\n");
	menu();
	addButton(14, "Back", ExcelliaCampMainMenuFixHer);
}
public function ExcelliaCampFixHerHerself():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You're curious to know as to what the former cow queen was like before she became the Minotaur King's slave. ");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) {
		outputText("She looks down, visibly upset when you mention it. She lets out a sigh before looking back at you.\n\n");
		outputText("\"<i>I can remember a little bit of who I used to be before becoming a slave to the Minotaur King...</i>\"\n\n");
		outputText("She sits on the ground in front of you. You sit with her as she begins her tale.\n\n");
		outputText("\"<i>Well, I didn't actually come from Mareth for starters. I used to be a highly praised warrior where I came from. I took on any challenge that was thrown my way. Sometimes I went to take on the challenge myself. One day I made the mistake of stumbling upon a portal that led to this world. I didn't know when I crossed through it that I would not be able to return...</i>\"\n\n");
		outputText("So she came from another world just like you and she used to be a warrior too. "+(isabellaFollower() ? "Almost reminds you of another certain cowgirl living with you. ":"")+"You wonder if her cow like features are natural or did she gain those after arriving in Mareth. She shakes her head.\n\n");
		outputText("\"<i>I was actually a human before I came to Mareth. Seeing as I couldn't return to my home, I had to brave this new world to survive. I've traveled all over and defeated many creatures… That is until my travels took me to the mountains. I had heard they were home to Minotaurs. I had originally thought that the supposed brutes would provide a true test to my skills. That was my biggest mistake...</i>\"\n\n");
		outputText("You can assume that her ventures to fight the bovine beasts didn't go accordingly. She shivers then hugs herself as old memories come back to her.\n\n");
		outputText("\"<i>I struck down many of them… and maybe indulged in the spoils of my victories a little too often. I didn't know about the addictive qualities of their spunk. After that it's really hazy… I was taken, used, and abused. I was pretty much their breeding slave to dump all their desires into. Especially when the Minotaur King took a liking to that. I can't tell you how long I was like that. Frankly I really wish I could forget it all...</i>\"\n\n");
		outputText("You can't imagine what that was like for her. To be used and fucked by Minotaurs day in and day out as a mindless cumdump. "+(player.findPerk(PerkLib.MinotaurCumAddict) >= 0 ? "Though thinking about it again, maybe it wouldn't be as bad as you originally thought. ":"")+"The cowgirl gives you a sad smile.\n\n");
		outputText("\"<i>Well, I guess I should count myself lucky that a brave champion like you came along. If you hadn't come in and taken down the Minotaur King and Lethice, I probably would have still been nothing more than a simple minded cum slut to say the least.</i>\"\n\n");
		outputText("She takes your hands into yours, her smile noticeably brightens and tears well up in her eyes.\n\n");
		outputText("\"<i>I don't think I can ever thank you enough for what you've done for me. No matter what happens, I am eternally grateful from the bottom of my heart.</i>\"\n\n");
		outputText("You can't help but smile at hearing the cowgirl's kind words. She pulls you into a near crushing hug to which you gladly return.\n\n");
	}
	else {
		outputText("She looks up at you almost hurt as she swishes her tail back and forth behind her in frustration.\n\n");
		outputText("\"<i>My " + player.mf("Lord", "Lady") + "... That's too hard to remember. I'm just your humble servant to be used. I'm sure who I used to be wasn't too important… r-right?</i>\"\n\n");
		outputText("She smiles up at you, hoping that would be enough of an answer. It's really not but with the way she is now, you doubt that you'll get much out of her.\n\n");
	}
	if (flags[kFLAGS.EXCELLIA_RECRUITED] < 32) flags[kFLAGS.EXCELLIA_RECRUITED]++;
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerTalk():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You just wanna make some small talk with the cowgirl. Excellia seems more than happy to talk. The two of you idly chat about your adventures and conquests across Mareth. After about an hour, you think it's about time to be on your way. You say your goodbyes to Excellia before heading off.\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerGetMilk():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You tell the ex-cow queen that you could really use a drink. She giggles then pushes her huge tits together, causing a small trickle of her sweet, creamy milk to dribble out.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>Oh, [name]... I will gladly share my milk with you. I could use a little relief myself honestly.</i>\"\n\n");
	else outputText("\"<i>Of course my " + player.mf("Lord", "Lady") + "! It would be an honor to quench your thirst.</i>\"\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] < 32) flags[kFLAGS.EXCELLIA_RECRUITED]++;
	menu();
	addButton(1, "Drink", ExcelliaCampFixHerGetMilkDrink);
	addButton(3, "Bottle", ExcelliaCampFixHerGetMilkBottle);
}
public function ExcelliaCampFixHerGetMilkDrink():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("Excellia plops down on the ground in front of you with a smile, beckoning you to come. With a wide grin on your face you seat yourself, noting her nipples are leaking even more. They're too tempting not to play with. You reach up to squeeze her impressive bosom, marveling at how big and round they are. They're perky and show no sign of sagging whatsoever. You lean in to kiss her seeping nipple, sucking the teat in between your lips and expertly rolling and sliding it between them, tickling its tip and savoring her sweet, warm and creamy milk. You use your hand to pinch and tug at her other free nipple.\n\n");
	outputText("The cowgirl blushes and moos as you play with her nipples. You start to suckle in earnest as your other hand reaches down to rub over her slick nether lips and plump clitty. Excellia squirms while you suckle and tease, delighting in the pleasure you are giving her as the delicious sweet milk cascades down your thirsty throat. Her bountiful breasts and the wonderful taste of her milk invigorates you. You don’t think you could ever get tired of the creamy, refreshing beverage. The soft moos that accompanies each suckle and the soft caresses on your body only enhances the whole experience.\n\n");
	outputText("Eventually, your swallowing of the rich, freely flowing creamy milk ceases as you drain her first teat. You still feel a slight pang of thirst and hunger, so you quickly latch onto her other nipple, making the cowgirl squeak in surprise. She moans louder when your fingers slip into her wet snatch, rubbing against her inner walls. The stream of milk trickling into your mouth practically turns into a jet. You sputter as you struggle to gulp down the deluge. Your stomach gurgles as it’s filled with even more of her energizing milk.\n\n");
	outputText("Excellia lets out a loud moo, her pussy clenching around your invading fingers and drenching them in a spray of femcum. The last of her milk bursts into your mouth which you eagerly gulp down. When the flow simmers down to just a trickle, you release her teat letting out a little burp. The cowgirl falls back looking flushed and panting.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>Phew… W-Wow [name]. That was amazing. I do hope that you got your fill!</i>\"\n\n");
	else outputText("\"<i>Oooo… T-Thank you for making use of me my " + player.mf("Lord", "Lady") + ". I hope it was to your liking.</i>\"\n\n");
	outputText("You pat your full stomach telling her that you sure did. You stretch, feeling amazing. Excellia giggles as she gets up and kisses your cheek, happy that you enjoyed her milk. You thank her then head off feeling better than ever.\n\n");
	HPChange((((player.level * 20) + 25) * 2 * (1 + player.newGamePlusMod())), true);
	dynStats("lus", 15);
	fatigue(-200);
	player.refillHunger(100);
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerGetMilkBottle():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You could use a delicious creamy beverage on the go. You pull out a glass bottle then hold it under Excellia's tits. She grabs her nipples then starts milking herself. A steady stream of her milk pours into the bottle until it's filled to the brim. You cork it then stash it away, thanking the cowgirl. <b>You obtained Excellia's Milk.</b>\n\n");
	inventory.takeItem(consumables.EXCMILK, ExcelliaCampMainMenuFixHer);
	cheatTime(1/4);
}
public function ExcelliaCampFixHerGiveItems():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>Hm? You want to give me something [name]?</i>\"\n\n");
	else outputText("\"<i>Oh? Does my " + player.mf("Lord", "Lady") + " have something for me?</i>\"\n\n");
	menu();
	if (flags[kFLAGS.EXCELLIA_MAN_UP_BEER] < 4 && player.hasItem(consumables.MANUP_B)) addButton(0, "ManUpBeer", ExcelliaCampFixHerGiveItemsManUpBeer);
	if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] < 1 && player.hasItem(consumables.HUMMUS_)) addButton(1, "Hummus", ExcelliaCampFixHerGiveItemsHummus);
	if (flags[kFLAGS.EXCELLIA_LA_BOVA] < 2 && player.hasItem(consumables.P_LBOVA)) addButton(2, "PureLaBova", ExcelliaCampFixHerGiveItemsPureLaBova);
	if (flags[kFLAGS.EXCELLIA_RECRUITED] < 33 && player.hasItem(consumables.DEBIMBO)) addButton(4, "DeBimbo", ExcelliaCampFixHerGiveItemsDeBimbo).hint("Up to 3 doses. Giving all 3 will full cure her without need to wait.");
	addButton(14, "Back", ExcelliaCampMainMenuFixHer);
}
public function ExcelliaCampFixHerGiveItemsManUpBeer():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	player.consumeItem(consumables.MANUP_B);
	outputText("You pull out the can then hand it to her, telling her that she might enjoy it. Curious, she looks over the can before gulping it down. Moments after she finishes the beverage, she gasps as her body goes through changes. She looks thicker and her muscles look more pronounced. She flexes her arms, taking in her toned body.\n\n");
	flags[kFLAGS.EXCELLIA_MAN_UP_BEER]++;
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerGiveItemsHummus():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	player.consumeItem(consumables.HUMMUS_);
	outputText("Excellia takes the hummus from you and then eats it. She shudders when it has an immediate effect on her. You notice her horns receding back into her head and her cow like tail shrivels up and falls to the ground. Her cow like ear shrinks and round out, becoming human in shape. She looks over herself in surprise.\n\n");
	outputText("\"<i>W-Whoa… I forgot what it was like… to be human again. This'll take some getting used to…</i>\"\n\n");
	flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK]++;
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerGiveItemsPureLaBova():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	player.consumeItem(consumables.P_LBOVA);
	if (flags[kFLAGS.EXCELLIA_LA_BOVA] == 1) outputText("Excellia takes the purified la bova then gulps it down. She shudders when it has an immediate effect on her. She yelps and clutches her face as it reshapes into that of a cow. Her fingernails become harder and thicker. Patches of red fur grow on her body slowly filling in until she's covered from head to hooves in red fur.\n\n");
	else outputText("Excellia takes the purified la bova then gulps it down. She shudders when it has an immediate effect on her. She groans when her legs reshape into bovine hooves covered in smooth red fur.\n\n");
	flags[kFLAGS.EXCELLIA_LA_BOVA]++;
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerGiveItemsDeBimbo():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	player.consumeItem(consumables.DEBIMBO);
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 23) {
		outputText("You tell the ex-cow queen to close her eyes and open her mouth. She nods in understanding then does what she's told. You bring out the concentrated brew then put it up to her lips. She quickly drinks the brew in mere seconds. Shortly after, her eyes shoot open in shock then she clutches her head. ");
		outputText("She lets out a faint moo as the potion kicks in. When she finally calms down, she looks up at you. You can see her eyes brightened and become clearer. She looks around, fully taking in her surroundings then looks back up at you.\n\n");
		outputText("\"<i>A-Ah… [name]... [name]... I can… finally think straight for once.</i>\"\n\n");
		outputText("She smiles at you with tears streaming down her face. Before you can say anything the cowgirl pulls you into a tight hug, crying into your shoulder.\n\n");
		outputText("\"<i>Thankyouthankyouthankyou! Everything is so clear now! I feel like my old self again!</i>\"\n\n");
		outputText("You wrap your arms around her as she shakes and sobs into your shoulder, more happy than sad. You sit with her for several minutes until she finally pulls away, wiping away her tears.\n\n");
		outputText("\"<i>I can't thank you enough for helping me, [name]. I thought I was going to be a mindless slut forever… I can't believe this is finally happening!</i>\"\n\n");
		outputText("You chuckle, telling Excellia that you're glad to have helped. If there's anything else she needs then you're more than willing to help her. She blushes from your words then a big warm smile appears on her face. She pulls you into a deep heated kiss. Her tongue dances along yours as you embrace each other. You both pull away, panting a bit.\n\n");
		outputText("\"<i>[name] I… You’re truly an amazing " + player.mf("guy", "girl") + ". I'm happy someone like you came to my rescue.</i>\"\n\n");
		outputText("<b>Excellia is now your lover.</b>\n\n");
		flags[kFLAGS.EXCELLIA_RECRUITED] = 33;
	}
	else if (flags[kFLAGS.EXCELLIA_RECRUITED] > 13 && flags[kFLAGS.EXCELLIA_RECRUITED] < 24) {
		outputText("You tell the ex-cow queen to close her eyes and open her mouth. She nods then does what she's told. You bring out the concentrated brew then put it up to her lips. She quickly gulps down the brew in mere seconds. Shortly after, her eyes shoot open in shock then she clutches her head. She lets out a groan as the potion kicks in. ");
		outputText("When she finally calms down, she looks up at you. You can see her eyes brightened but it's still not fully there quite yet. Maybe just a bit more will get her there.\n\n");
		flags[kFLAGS.EXCELLIA_RECRUITED] += 10;
	}
	else {
		outputText("You tell the ex-cow queen to close her eyes and open her mouth. She smiles excitedly then does what she's told. You bring out the concentrated brew then put it up to her lips. She quickly slurps down the brew in mere seconds. Shortly after, her eyes shoot open in shock then she clutches her head. She lets out a pained moo as the potion kicks in. ");
		outputText("When she finally calms down, she looks up at you. There's a spark of clarity in her eyes but it's not fully there yet. Maybe a bit more will get her there.\n\n");
		flags[kFLAGS.EXCELLIA_RECRUITED] += 10;
	}
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerHenchmanOption():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("Excellia perks up at your suggestion. She smirks, giving you a sultry look.");
	outputText("\n\n");
	outputText("\"<i>And what did you have in mind exactly?</i>\"\n\n");
}
public function ExcelliaCampFixHerSex():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("Excellia perks up at your suggestion. She smirks, giving you a sultry look.\n\n");
	outputText("\"<i>And what did you have in mind exactly?</i>\"\n\n");
	menu();
	addButton(0, "Fuck Her", ExcelliaCampFixHerSexFuckHer);
	addButton(1, "Oral Fun", ExcelliaCampFixHerSexOralFun);
	if (player.hasCock()) addButton(2, "SuckleFuck", ExcelliaCampFixHerSexSuckleFuck);
	else addButtonDisabled(2, "SuckleFuck", "Req. Cock.");
	addButton(14, "Back", ExcelliaCampMainMenuFixHer);
}
public function ExcelliaCampFixHerSexFuckHer():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You lead the cowgirl to your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin":"tent")+". You take her inside and lay her back on your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+" making sure she’s comfortable. She looks up at you with a deep blush on her face. "+(player.isNaked() ? "Seeing as you already don’t wear any clothing":"You strip off your gear then")+" you lean over her, taking in her beautiful curves and supple flesh. She loops her arms around your neck and pulls you down into a deep kiss. You kiss her back, slipping your tongue past her lips ");
	outputText("to explore her mouth. "+(player.hasCock() ? "Her aphrodisiac laced lipstick has a profound effect on your body, your [cock] quickly hardening and poking against her thigh":"You're more than excited to have a taste of your sweet cowgirl, your pussy becoming wetter by the second")+". Your hands roam along her body, discovering her most sensitive areas. She moans into your mouth from your light touches. You break the kiss, a small string of saliva connecting your mouths. She pants harder, the needy lust in her eyes becoming more apparent.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>A-Ah please [name]... I want you…</i>\"\n\n");
	else outputText("\"<i>P-Please my " + player.mf("Lord", "Lady") + "... I can’t wait any longer!</i>\"\n\n");
	outputText("Well, you can hardly keep the cowgirl waiting too much longer. You’re eager to get a piece of her too. You pull away from her and reposition yourself.\n\n");
	if (player.hasCock()) {
		outputText("You gently caress her thighs, urging her to spread her legs for you. She complies, opening up her legs revealing her soaked slick snatch. Her plump lips gape slightly as beads of moisture drips down her curvaceous ass. It’s too hard to resist. You press up against her, grinding your [cock] against her wet vulva. She groans and whines, wanting you inside her. You grind your dick"+(player.cockTotal() > 1 ? "s":"")+" against her soaked pussy until "+(player.cockTotal() > 1 ? "they're":"it’s")+" thoroughly coated in her slick juices. ");
		outputText("You press the head against her entrance"+(player.cockTotal() > 1 ? " and tight backdoor":"")+", sinking in a couple inches. You almost gasp and shudder as her warm and slick walls pull you in with relative ease. Her heavenly tunnel"+(player.cockTotal() > 1 ? "s":"")+" squeezes and hugs you tightly drawing you in further until you’re fully hilted inside her. She moos out feeling you deep inside her.\n\n");
		if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>Mmm yes, [name]... I’m all yours...</i>\"\n\n");
		else outputText("\"<i>Oooo my " + player.mf("Lord", "Lady") + " please fuck me! I-I can take it!</i>\"\n\n");
		outputText("You grab her hips then pull back until just the head of your dick"+(player.cockTotal() > 1 ? "s":"")+" is inside her. She’s about to complain when you slam back inside, eliciting a moan from her. You begin a steady pace, thrusting into her silky depths. You can’t help but groan feeling her inner walls hug and massage you in ways you didn’t think possible. The tightness in your lower belly slowly builds as you’re pushed closer to the edge but you do your best to force it back down to prolong this wonderful feeling.\n\n");
		outputText("Excellia wraps her legs around your waist to pull you closer and force you deeper inside her. You grip her hips tighter as you begin fucking her in earnest. She moos out louder feeling your [cock] rubbing against her sensitive walls. The way her huge tits jiggle with each thrust is too much to ignore. You reach up and grab her pillowy breasts. Your fingers sink into the supple flesh as you knead and squeeze her milk filled jugs. Creamy milk leaks from her large teats, dripping down the curve of her perky breasts. You lean down and lap at the sweet cream letting your tongue swipe over her nipples.\n\n");
		outputText("The dual sensation of drinking her milk and pounding away at her pussy "+(player.cockTotal() > 1 ? "and ass ":"")+"becomes too much for the cowgirl. She pulls you up into a tongue filled kiss mooing into your mouth as she cums. Her pussy "+(player.cockTotal() > 1 ? "and ass ":"")+"clamps down on your dick"+(player.cockTotal() > 1 ? "s":"")+" like a vice as a gush of femcum gushes out around your [cock] drenching your crotch. You can’t help but moan out when your orgasm tears through you. ");
		outputText("Your dick"+(player.cockTotal() > 1 ? "s":"")+" twitches and erupts inside the still orgasming cowgirl. Your hot seed fills her utterly as some dribbles back out and drips down into the growing puddle beneath her. Excellia doesn’t let you go until you empty the last of your spunk inside her.\n\n");
		outputText("Spent, you pull out of the panting cowgirl, shivering as you leave her silky confines. She moos lowly when a stream of your cum drools from her well used snatch"+(player.cockTotal() > 1 ? " and ass":"")+". She looks up at you with a tired smile.\n\n");
		if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>Oh [name]... That was just amazing… Oooo, I’m still tingling!</i>\"\n\n");
		else outputText("\"<i>A-Ah thanking you my " + player.mf("Lord", "Lady") + "... You truly are amazing...</i>\"\n\n");
		if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) excelliaPreg();
	}
	else {
		outputText("You smirk as you slip a hand down to her soaked pussy. She lets out a tiny gasp when your fingers roam over her soft vulva. You rub your thumb over her big pleasure button. You can feel it grow and harden from its hood to a full 1.5 inches. You pinch it gently between your fingers, making the cowgirl moo lowly. You smirk slipping one of your digits inside with ease. She shudders, feeling your finger rubbing against her sensitive walls. ");
		outputText("You decide to slip another finger inside her, exploring her innermost depths. She lets out a moan when you brush over her sweet spot. You continue rubbing over it, watching the cowgirl squirm and moan as your skillful digits take advantage of her most sensitive area.\n\n");
		if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>[name] please! K-ah-Keep going!</i>\"\n\n");
		else outputText("\"<i>A-Ah yes! Right there m-my Lady!</i>\"\n\n");
		outputText("Your thumb rubs against her hard button making her squeal in pleasure. Creamy milk leaks from her large teats dripping down the curve of her perky breasts. You lean down and lap at the sweet cream, letting your tongue swipe over her nipples. You gasp in surprise when you feel her reach down and rub her soft fingers against your wet nether lips and pleasure button. You moan when her fingers slip past your slick folds. Her other hand gropes at your [chest] and flickers her fingers over your nipples. ");
		outputText("You lean up and kiss her, letting her lap at the taste of her own milk from your tongue. You moan into each other's mouths as you're both pushed over the edge. Excellia moos loudly as her pussy clenches tightly around your intruding digits, drenching them in femcum. You gasp in pleasure when you cum around the cowgirl's fingers. Her milk streams out, coating the both of you in sweet cream adding to the growing puddle beneath you.\n\n");
		outputText("You're both left panting and gasping as you fall over onto your sides. She giggles, pulling you close into her arms.\n\n");
		if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>[name] please! K-ah-Keep going!</i>\"\n\n");
		else outputText("\"<i>A-Ah yes! Right there m-my Lady!</i>\"\n\n");
	}
	outputText("You can’t help but feel the same way. You lay next to the cowgirl nuzzling into her arms for a rest. After a quick nap, you help her get cleaned up and say your goodbyes to her as you prepare to head back out.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] < 32) flags[kFLAGS.EXCELLIA_RECRUITED]++;
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerSexOralFun():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You smirk at Excellia telling her that you would like a taste of her. She smiles giving you a knowing look.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>Of course you can have a little of this, [name]. That is if you'll let me have a little of you too.</i>\"\n\n");
	else outputText("\"<i>Oh my " + player.mf("Lord", "Lady") + ". You are always welcome to have a taste of me. Can I have a taste of you too?</i>\"\n\n");
	outputText("You lead her to your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin":"tent")+" then head inside. You lay her back on your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+" making sure she's comfortable. "+(player.isNaked() ? "Seeing as you don't wear clothes you shrug then crawl over to the cowgirl":"You shed your gear and place it into a neat pile")+". She pulls you closer, squishing her huge breasts against your [chest] as some of her milk leaks out. ");
	outputText("You lean in to kiss her, your tongue slipping past her lips."+(player.hasCock() ? " You shudder as her lust inducing lipstick starts to take effect, your [cock] rapidly becoming harder by the second.":"")+" She breaks the kiss, lust heavy in her eyes. She's more than ready and so are you.\n\n");
	outputText("You lay back and pull the cowgirl on top of you positioning her to where her glistening pussy lips and large ass sits enticingly in front you and she's facing your groin. You can feel her hot breath on your "+(player.hasCock() ? "cock":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "wet snatch":"")+" making you shudder in anticipation. You're the first one to act when you lean in closer and swipe your tongue over her sweet pussy. Excellia lets out a tiny gasp as your tongue laps at her plump vulva and swirls over her large clitty. Not wanting to be outdone, she leans down then "+(player.hasCock() ? "slurps at the head of your dick":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "laps at your wet pussy":"")+". ");
	outputText("You both find yourselves shivering and moaning under each other's attention. You slip as much of your tongue as you can into her sensitive pussy. "+(player.hasLongTongue() ? "Your long appendage inches into her heavenly snatch brushing against her fleshy wall. ":"")+"She moos out as her walls occasionally squeeze around your invading tongue. You groan feeling her "+(player.hasCock() ? "engulf your [cock] into her warm mouth":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "massage your pussy with her wonderful tongue":"")+". The mounting pressure in your loins becoming more apparent with each passing second.\n\n");
	outputText("Excellia moos as her pussy clenches around your invading tongue then soaks your mouth and face in a blast of her sticky femcum. You're not too far behind her when your orgasm hits. "+(player.hasCock() ? "You thrust up into her mouth shooting rope after rope of your hot cum down her throat":"Y")+(player.gender == 3 ? " and y":"")+(player.hasVagina() ? "our wet pussy squirting out it's juices":"")+".\n\n");
	outputText("You're both left panting as your bodies slowly calm down from the exertion. You untangle yourself from her letting out a content sigh. She giggles then pulls you into a passionate kiss. You can faintly taste yourself on her tongue. She pulls back looking at you with nothing but joy in her eyes.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>Ah… That tongue of yours is devious. I hope you use it on me again VERY soon [name].</i>\"\n\n");
	else outputText("\"<i>Thank you my " + player.mf("Lord", "Lady") + "! I love it when you do that to me!</i>\"\n\n");
	outputText("You wouldn't mind doing it again but it's about time for you to get going. So much to do, so little time. Excellia pouts but nods in understanding. She helps you get cleaned up and prepared to head back out.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] < 32) flags[kFLAGS.EXCELLIA_RECRUITED]++;
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampFixHerSexSuckleFuck():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You're a little thirsty and in the mood for a good time. The cowgirl giggles at your suggestion then takes your hands pulling you inside her tent. "+(player.isNaked() ? "You suppose being nude definitely has its benefits seeings as you don't have to bother taking off pesky clothing":"She helps you strip off your clothing and haphazardly tosses them into a pile nearby")+". You sit in front of Excellia making sure you're comfortable before pulling her down to sit in your lap and straddle your waist.\n\n");
	outputText("You lick your lips as her huge love pillows wobble enticingly in front of you filled with their sweet, creamy, goodness just waiting to be tapped into. She smiles pushing her breasts together, making them look even bigger. A few droplets of her milk slowly leak from her nipple. You can't help but lap up the escaping droplets, shivering the moment the restorative milk hits your tongue. Your [cock] slowly hardens, poking against her thick thighs. She coos, playfully squeezing it between her legs. You groan from the feeling of your dick being trapped between the cowgirl's plush thighs, precum leaking down your length. ");
	outputText("Unconsciously, you wrap your lips around one of her milk dripping teats causing her to let out a small moo. You gently suckle and lap at her teat until a steady stream of her sweet milk pours into your mouth. Her sweet cream invigorates and ebbs away the aches and pains from your adventures.\n\n");
	outputText("Though you would be content to just sit there and gulp down all the milk she can provide, the constant aching in your loins is becoming too much to ignore. You lift her up in your lap, not once releasing her teat from your mouth, and press the head of your dick against her soaked entrance. The cowgirl gasps then lets out a drawn out moo when the head of your dick slips past her folds and sinks into her a few inches. You gently guide her down until her hips finally meets yours. You shiver feeling her warm heavenly walls wrap around you so tightly as if they didn't want to let you go.\n\n");
	outputText("Empowered by her restorative milk, you waste no time pumping into her depths. Excellia pants and moans louder as you fuck and greedily suckle from her. The stream flowing into your mouth gradually increases in intensity as it nearly turns into a river. You do your keep up with the deluge struggling to gulp down the cream just as another takes its place. Her other free breast bounces with each hard thrust dribbling its milk on you and the cowgirl. Upset to see such amazing milk go to waste, you push her huge milky pillows together and stuff both teats into your mouth. At that moment your [cock] brushes against the cowgirl's sensitive walls causing her moo louder then grab the back of your head, mashing your face into her breasts. ");
	outputText("You struggle to breathe as a flood of her milk pours into your mouth. You quickly gulp down as much of it as you can just to avoid suffocating or drowning. She eagerly bounces in your lap riding your dick hard until she's finally pushed over the edge. She moos loudly when her orgasm hits, the combination of your nursing and pounding at her soaking pussy becoming too much. Working on very little air, you quickly pump you hips as you fuck her harder and faster to reach your peak as well. Just as darkness is about to set in, your orgasm tears through you, surging up your dick and blasting the still orgasming cowgirl's depths with your hot seed.\n\n");
	outputText("Just as your consciousness is about to slip, your head is abruptly pulled back, letting the cowgirl's leaking teats pop from your mouth and gulping in some much needed air. You cough and sputter, trying to catch your breath. You can feel a hand stroking the back of your head as you try to regain your bearings.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] > 32) outputText("\"<i>I'm so sorry [name]! It just felt so good and I just couldn't control myself!</i>\"\n\n");
	else outputText("\"<i>Oh my apologies my " + player.mf("Lord", "Lady") + "! I might've gotten a bit carried away...</i>\"\n\n");
	outputText("You cough a bit telling the cowgirl that it's okay. You might've gotten a bit carried away yourself to be honest. You untangle yourself from her taking note of your bulging stomach. It sloshes and groans from the amount of milk you drank. At least you won't be hungry for a while and you feel more refreshed than ever. You kiss Excellia thanking her for such a wonderful meal. She smiles, glad you aren't upset over the near boob suffocation. She helps you get cleaned up as you get ready to head back out.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] < 32) flags[kFLAGS.EXCELLIA_RECRUITED]++;
	if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) excelliaPreg();
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
public function excelliaHenchmanOption():void {
	clearOutput();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		outputText("\"<i>Nyaaaaa we hunting together [name]? This is going to be enjoyable!</i>\"\n\n");
		outputText("Excellia is now following you around.\n\n");
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
		player.createStatusEffect(StatusEffects.CombatFollowerExcellia, strEtna, libEtna, 0, 0);
		flags[kFLAGS.PLAYER_COMPANION_1] = "Excellia";
	}
	else {
		outputText("Excellia is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerExcellia);
		flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(ExcelliaCampMainMenuFixHer2);
	cheatTime(1/12);
}
public function ExcelliaCampFixHerSleepToggle():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if(flags[kFLAGS.SLEEP_WITH] != "Excellia") {
		outputText("You ask Excellia if she wouldn't mind sleeping with you at night. A warm smile appears on her face.\n\n");
		outputText("\"<i>Of course not [name]. I would love to cuddle with you on cold nights.</i>\"\n\n");
		flags[kFLAGS.SLEEP_WITH] = "Excellia";
	}
	else {
		outputText("You tell the cow girl that you would prefer to sleep alone at night. Excellia huffs then pouts.\n\n");
		outputText("\"<i>I guess you don't have to cuddle with me then…</i>\"\n\n");
		flags[kFLAGS.SLEEP_WITH] = "";
	}
	menu();
	addButton(0,"Next", ExcelliaCampMainMenuFixHer);
}
private function sleepWith(arg:String = ""):void {
	flags[kFLAGS.SLEEP_WITH] = arg;
}
public function ExcelliaCampMainMenuMakeSlave():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (pregnancy.isPregnant && pregnancy.incubation == 0) {
		ExcelliaPoopsBabies2();
		pregnancy.knockUpForce(); //Clear Pregnancy
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	switch (pregnancy.event) {
		case 2: outputText("You notice that Excellia seems to have a small swell in her belly. She has been eating more frequently.\n\n");
				break;
		case 3:
		case 4: outputText("The swell in Excellia's belly has grown out into a noticeable bump. You get the distinct feeling that she might be pregnant.\n\n");
				break;
		case 5: outputText("Excellia's baby bump has grown larger. Her huge breasts begin to leak more often due to her increased milk production. She moans as she uses one hand to rub her hands over her round belly and the other to rub against her dripping pussy. She looks over to you with a lust filled gaze obviously wanting your attention.\n\n");
				outputText("\"<i>Mmm it's coming soon...</i>\"\n\n");
				break;
		case 6: outputText("Excellia looks about ready to give birth any day now. Her huge breasts now leak steady streams of sweet milk. Her large belly is swollen with her child. You can occasionally see a little movement in her belly as the child inside squirms around.\n\n");
				outputText("\"<i>Oh my " + player.mf("Lord", "Lady") + " it's coming any day now... Mmm just thinking about pushing out your baby from my slutty hole and being stretched to the fullest gets me so wet!</i>\"\n\n");
				outputText("You grin at her then reach over to touch her stomach. She coos when you rub her belly. The child inside kicks against her belly hard. Already so lively and strong. You lick your lips just thinking about all the things you could possibly do with them when they're old enough. Given her size, it's probably almost time for her to give birth.\n\n");
				break;
		default:
	}
	ExcelliaCampMainMenuMakeSlave2();
}
public function ExcelliaCampMainMenuMakeSlave2():void {
	outputText("You approach your needy cowslut. She perks up then crawls over to you. She kneels in front of you, shivering in anticipation and huge milk jugs dribbling milk.\n\n");
	outputText("\"<i>My " + player.mf("Lord", "Lady") + "! How will you use your lowly cowslut today?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", ExcelliaCampMakeSlaveAppearance);
	addButton(1, "Herself", ExcelliaCampMakeSlaveHerself);
	addButton(2, "Get Milk", ExcelliaCampMakeSlaveSexGetMilk);
	addButton(3, "Give Items", ExcelliaCampMakeSlaveGiveItems);
	addButton(4, "Sex", ExcelliaCampMakeSlaveSex);
	addButton(14, "Back", camp.campSlavesMenu);
}
public function ExcelliaCampMakeSlaveAppearance():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("Excellia is a 7 feet 2 inches tall cowgirl, formerly the cow queen to the Minotaur King. Her smooth skin is light brown in color"+(flags[kFLAGS.EXCELLIA_LA_BOVA] == 2 ? " underneath red fur":"")+". She has a "+(flags[kFLAGS.EXCELLIA_LA_BOVA] == 2 ? "cow like":"human")+" face. Her eyes are yellow. She has a set of pouty lips coated in golden lipstick. She has a pair of cow like pierced with gold hoop earrings parting her long curly red hair with yellow highlights. A gold jewel encrusted tiara sits on her head. ");
	outputText(""+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 3 ? "She has somewhat long demonic horns decorated with golden horn rings sticking up from her head":"A pair of short bovine horns decorated with gold horn rings stick up from her head. They're not as long as minotaur horns but much longer than cow horn")+"."+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 3 ? " A slowly undulating demonic tongue occasionally slips from between her lips. It hangs nearly two feet long when she lets the whole thing slide out.":"")+" Strapped around her neck is a gold jewel encrusted cowbell. She");
	if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 3) outputText("'s noticeable very thick with a muffin top and plush body");
	else if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] > 0) outputText(" appears thick with a noticeable muffin top");
	else outputText(" is very soft and plump with no visible muscles");
	outputText(". A strange tattoo marks her stomach.\n\n");
	if (flags[kFLAGS.EXCELLIA_LA_BOVA] > 0) outputText("Her arms are "+(flags[kFLAGS.EXCELLIA_LA_BOVA] == 2 ? "almost human in shape with thick hoof like fingernails":"human in shape and structure")+". Her oddly jointed bovine legs are covered in red fur. ");
	else outputText("Her arms and legs are both human in shape and structure. ");
	outputText("She wears gold bangles around her wrists and ankles. A tattoo marks her left leg. She has plump thick thighs."+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 3 ? " A pair of tiny bat like wings grows out from her back. They cutely flap behind her but are much too small to allow flight.":"")+" "+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] > 1 ? "A whip like demon tail with a spaded tip":"A cow tail tipped with red hair")+" and decorated with a gold tail ring swishes above her large ass.\n\n");
	outputText("She has fat milk filled ");
	if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] > 1) outputText("H");
	if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1) outputText("G");
	else outputText("F");
	outputText(" cup sized breasts. Her "+(flags[kFLAGS.EXCELLIA_LA_BOVA] > 0 ? "four ":"")+"nipples are pierced with golden nipple rings.\n\n");
	outputText("Between her legs is a constantly dripping vagina with a 1.5 inch large clit. A small teardrop shaped patch of red hair sits above it.\n\n");
	outputText("She has a somewhat tight anus between her cheeks where it should be.\n\n");
	outputText("When Excellia catches you staring, she giggles then lifts up her tail, displaying her somewhat tight ass and wet pussy.\n\n");
	menu();
	addButton(14, "Back", ExcelliaCampMainMenuFixHer);
}
public function ExcelliaCampMakeSlaveHerself():void {
	clearOutput();
	outputText("You ask your dairy cow to tell you more about herself. She hums in thought seemingly thinking of something to tell you before shrugging.\n\n");
	outputText("\"<i>Sorry my " + player.mf("Lord", "Lady") + "... I don’t remember much really. I think maybe I was a warrior or something close to that…</i>\"\n\n");
	outputText("She perks up when a thought comes to mind.\n\n");
	outputText("\"<i>Oh wait! I think I came from another world or something. Yeah, I was a warrior from another world before I came here!</i>\"\n\n");
	outputText("Well, there’s a start at least. Does she remember how she became a slave to the Minotaur King. She scratches her head in thought.\n\n");
	outputText("\"<i>Hmm… I think I wanted to do something with minotaurs… and their yummy, leaking fuck sticks… deep inside me…</i>\"\n\n");
	outputText("She shudders and drools as she thinks about getting fucked repeatedly by dozens of bovine men. You roll your eyes then deliver a hard smack across her big jiggly ass causing her to snap back into reality.\n\n");
	outputText("\"<i>O-Oh sorry my " + player.mf("Lord", "Lady") + ". Um, I really don’t remember much of my time before becoming a slave. Please forgive your useless cumslut.</i>\"\n\n");
	outputText("She kneels at your [legs] with a pitiful look on her face. You roll your eyes and sigh. You suppose that’s all you’re going to get from the ex-cow queen.\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampMakeSlaveSexGetMilk():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You ask your dairy cow to tell you more about herself. She hums in thought seemingly thinking of something to tell you before shrugging.\n\n");
	outputText("\"<i>Sorry my " + player.mf("Lord", "Lady") + "... I don’t remember much really. I think maybe I was a warrior or something close to that…</i>\"\n\n");
	menu();
	addButton(1, "Drink", ExcelliaCampMakeSlaveSexGetMilkDrink);
	addButton(3, "Bottle", ExcelliaCampMakeSlaveSexGetMilkBottle);
}
public function ExcelliaCampMakeSlaveSexGetMilkDrink():void {
	//spriteSelect(SpriteDb.s_electra);
	outputText("Excellia plops down on the ground in front of you with a smile beckoning you to come. With a wide grin on your face you seat yourself, noting her nipples are leaking even more. They're too tempting not to play with. You reach up to squeeze her impressive bosom marveling at how big and round they are. They're perky and show no sign of sagging whatsoever. You lean in to kiss her seeping nipple, sucking the teat in between your lips and expertly rolling and sliding it between them, tickling its tip and savoring her sweet, warm, creamy milk. You use your hand to pinch and tug at her other free nipple.\n\n");
	outputText("The cowgirl blushes and moos as you play with her nipples. You start to suckle in earnest as your other hand reaches down to rub over her slick nether lips and plump clitty. Excellia squirms while you suckle and tease, delighting in the pleasure you are giving as in the delicious sweet milk cascading down your thirsty throat. Her bountiful breasts and the wonderful taste of her milk invigorates you. You don’t think you could ever get tired of the creamy, refreshing beverage. The soft moos that accompanies each suckle and the soft caresses on your body only enhances the whole experience.\n\n");
	outputText("Eventually, your swallowing of the rich, freely flowing, creamy milk ceases as you drain her first teat. You still feel a slight pang of thirst and hunger, so you quickly latch onto her other nipple making the cowgirl squeak in surprise. She moans louder when your fingers slip into her wet snatch rubbing against her inner walls"+(flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 3 ? " her tiny wings frantically flapping behind her":"")+". The stream of milk trickling into your mouth practically turns into a jet. You sputter as you struggle to gulp down the deluge. Your stomach gurgles as its filled with even more of her energizing milk.\n\n");
	outputText("Excellia lets out a loud moo, her pussy clenching around your invading fingers and drenching them in a spray of femcum. The last of her milk bursts into your mouth to which you eagerly gulp down. When the flow simmers down to just a trickle, you release her teat with a little letting out a burp. The cowgirl falls back looking flushed and panting.\n\n");
	outputText("\"<i>Oooo… T-Thank you for making use of my milk " + player.mf("Lord", "Lady") + ". I hope it was to your liking.</i>\"\n\n");
	outputText("You grin and pat your full stomach telling her that you sure did enjoy it. You reach over and give your cum cow's nipple a little pinch causing her to squeak in surprise and a small spray of milk to leak out. You chuckle leaving her to knead and grope at her huge breasts moaning for more from you.\n\n");
	HPChange((((player.level * 20) + 25) * 2 * (1 + player.newGamePlusMod())), true);
	dynStats("lus", 15);
	fatigue(-200);
	player.refillHunger(100);
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampMakeSlaveSexGetMilkBottle():void {
	//spriteSelect(SpriteDb.s_electra);
	outputText("You could use a delicious creamy beverage on the go. You pull out a glass bottle then hold it under Excellia's tits. She grabs her nipples then starts milking herself. A steady stream of her milk pours into the bottle until it's filled to the brim. You cork it then stash it away patting your slutty dairy cow on the head. <b>You obtained Excellia's Milk.</b>\n\n");
	inventory.takeItem(consumables.EXCMILK, ExcelliaCampMainMenuFixHer);
	cheatTime(1/4);
}
public function ExcelliaCampMakeSlaveGiveItems():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("\"<i>Oooo! Do you have something for me, my " + player.mf("Lord", "Lady") + "?</i>\"\n\n");
	menu();
	if (flags[kFLAGS.EXCELLIA_LA_BOVA] < 2 && player.hasItem(consumables.PROBOVA)) addButton(0, "ProBova", ExcelliaCampMakeSlaveGiveItemsProBova);
	if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] < 3 && player.hasItem(consumables.SUCMILK)) addButton(1, "SuccubusMilk", ExcelliaCampMakeSlaveGiveItemsSuccubusMilk);
	addButton(14, "Back", ExcelliaCampMainMenuMakeSlave);
}
public function ExcelliaCampMakeSlaveGiveItemsProBova():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	player.consumeItem(consumables.PROBOVA);
	if (flags[kFLAGS.EXCELLIA_LA_BOVA] == 1) outputText("You force Excellia to take the tainted la bova, forcing her to gulp it down. She moos and shudders when it has an immediate effect on her. She yelps and clutches her face as it reshapes into that of a cow. Her fingernails become harder and thicker. Patches of red fur grow on her body slowly filling in until she's covered from head to hooves in red fur.\n\n");
	else outputText("You force Excellia to take the tainted la bova, making her gulp it down. She moos and shudders when it has an immediate effect on her. She groans when her legs reshape into bovine hooves covered in smooth red fur. Her nipples grow out and multiply, forming into four long teats.\n\n");
	flags[kFLAGS.EXCELLIA_LA_BOVA]++;
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampMakeSlaveGiveItemsSuccubusMilk():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	player.consumeItem(consumables.SUCMILK);
	if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 2) outputText("Excellia eagerly opens her mouth as you pour the demonic milk into her mouth. She nearly squeals with glee as it has an immediate effect on her. Her cow like horns twist and reshape into more demonic looking ones. Tiny bat wings grow out from between her shoulder. A long demonic tongue snakes out of her mouth. She moos loudly as she orgasms, streams of her milk erupts from her breasts and femcum dribbles down between her legs. She pants heavily with lust in her eyes.\n\n");
	else if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1) outputText("Excellia opens her mouth as you pour the demonic milk into her mouth. She lets out a moan as it has an immediate effect on her. Her breasts swell up a cup size, becoming H cups. Her tail thrashes behind her, reshaping into a spaded demon tail. She moos loudly as she orgasms, a spray of femcum pooling under her.\n\n");
	else outputText("Excellia opens her mouth as you pour the demonic milk into her mouth. She lets out a moan as it has an immediate effect on her. Her breasts swell up a cup size, becoming G cups. Her pussy moistens and drools down her thighs.\n\n");
	flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK]++;
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampMakeSlaveSex():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("Excellia nearly squeals with glee when you tell her what you want.\n\n");
	outputText("\"<i>Oh yes! How will you use your loyal cumslut today my " + player.mf("Lord", "Lady") + "?</i>\"\n\n");
	menu();
	addButton(0, "Fuck Her", ExcelliaCampMakeSlaveSexFuckHer);
	addButton(1, "Oral Fun", ExcelliaCampMakeSlaveSexOralFun);
	addButton(2, "MilkyMassage", ExcelliaCampMakeSlaveSexMilkyMassage);
	addButton(14, "Back", ExcelliaCampMainMenuMakeSlave);
}
public function ExcelliaCampMakeSlaveSexFuckHer():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You drag the cowgirl to your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin":"tent")+". You take her inside making it a point to leave the "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "door and window curtains":"flap to your tent")+" open and push her back onto your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+". She looks up at you with an excited grin on her face. "+(player.isNaked() ? "Seeing as you already don’t wear any clothing":"You strip off your gear then")+" you lean over her taking in her delicious curves and supple flesh. She loops her arms around your neck and pulls you down into a deep kiss. You roughly kiss her back slipping your tongue past her lips to ");
	outputText("explore her mouth. "+(player.hasCock() ? "Her aphrodisiac laced lipstick has a profound effect on your body, your [cock] quickly hardening and poking against her thigh":"You're more than excited to have a taste of your delectable cowslut, your pussy becoming wetter by the second")+". Your hands roam along her body discovering her most sensitive areas. She moans into your mouth from your light touches. You break the kiss, a small string of saliva connecting your mouths. She pants harder, the needy lust in her eyes becoming more apparent.\n\n");
	outputText("\"<i>P-Please my " + player.mf("Lord", "Lady") + "... Take me! Use me your loyal slut to your heart's content!</i>\"\n\n");
	outputText("Well, you lick your lips eager to fuck your needy dairy cow. You pull away from her and reposition yourself.\n\n");
	if (player.hasCock()) {
		outputText("You smack her thighs making her spread her legs for you. She complies, opening up her legs, revealing her soaked slick snatch. Her plump lips gape slightly as beads of moisture drips down her curvaceous ass. It’s too hard to resist. You press up against her, grinding your [cock] against her wet vulva. She groans and whines, wanting you inside her. You grind your dick"+(player.cockTotal() > 1 ? "s":"")+" against her soaked pussy until "+(player.cockTotal() > 1 ? "they're":"it’s")+" thoroughly coated in her slick juices. ");
		outputText("With little warning, you slam into her entrance"+(player.cockTotal() > 1 ? " and tight backdoor":"")+", sinking in several inches. You almost gasp and shudder as her warm and slick walls pull you in with relative ease. Her heavenly tunnel"+(player.cockTotal() > 1 ? "s":"")+" squeezes and hugs you tightly drawing you in further until you’re fully hilted inside her. She moos out feeling you deep inside her.\n\n");
		outputText("\"<i>Oooo my " + player.mf("Lord", "Lady") + " please fuck me harder! I like it rough!</i>\"\n\n");
		outputText("You grab her hips then pull back until just the head of your dick"+(player.cockTotal() > 1 ? "s":"")+" is inside her. She’s about to complain when you slam back inside her eliciting a loud moan from her. You begin a fast pace, thrusting into her silky depths. You can’t help but groan feeling her inner walls hug and massage you in ways you didn’t think possible. The tightness in your lower belly slowly builds as you’re pushed closer to the edge but you do your best to force it back down to prolong this wonderful feeling.\n\n");
		outputText("Excellia wraps her legs around your waist to pull you closer and force you deeper inside her. You grip her hips tighter as you begin fucking her in earnest. She moos out louder feeling your [cock] rubbing against her sensitive walls. The way her huge tits jiggle with each thrust is too much to ignore. You reach up and grope her pillowy breasts. Your fingers sink into the supple flesh as you knead and squeeze her milk filled jugs. Creamy milk leaks from her large teats dripping down the curve of her perky breasts. You lean down and lap at the sweet cream then sink your teeth into her sensitive love pillows no doubt leaving a mark.\n\n");
		outputText("The dual sensation of drinking her milk and pounding away at her pussy "+(player.cockTotal() > 1 ? "and ass ":"")+"becomes too much for the cowslut. She pulls you up into a tongue filled kiss mooing into your mouth as she cums. Her pussy "+(player.cockTotal() > 1 ? "and ass ":"")+"clamps down on your dick"+(player.cockTotal() > 1 ? "s":"")+" like a vice as a gush of femcum gushes out around your [cock] drenching your crotch. Your can’t help but moan out when your orgasm tears through you. ");
		outputText("Your dick"+(player.cockTotal() > 1 ? "s":"")+" twitches and erupts inside the still orgasming ex-cow queen. Your hot seed fills her utterly as some dribbles back out and drips down into the growing puddle beneath her. Excellia doesn’t let you go until you empty the last of you spunk inside her.\n\n");
		outputText("Spent, you pull out of the panting cowgirl jerking off your dick"+(player.cockTotal() > 1 ? "s":"")+" and dribbling what little cum you have let onto her chest and stomach. She moos lowly when a stream of your cum drools from her well used snatch"+(player.cockTotal() > 1 ? " and ass":"")+". She looks up at you with a tired smile.\n\n");
		outputText("\"<i>A-Ah thanking you my " + player.mf("Lord", "Lady") + "... I hope my cummy hole was to your liking. I just love it when you feel me up!</i>\"\n\n");
		outputText("You smirk patting your loyal slave on the head telling her she performed adequately. You lay next to the cowgirl as she nuzzles against you for a rest. After a quick nap, you get cleaned up and leave the still sleeping dairy cow as you prepare to head back out.\n\n");
		excelliaPreg();
	}
	else {
		outputText("You grin as you slip a hand down to her soaked pussy. She lets out a tiny gasp when your fingers roam over her soft vulva. You rub your thumb over her big pleasure button. You can feel it grow and harden from its hood to a full 1.5 inches. You pinch it between your fingers making the cowslut moo lowly. You smirk slipping one of your digits inside with ease. She shudders, feeling your finger rubbing against her sensitive walls. ");
		outputText("You decide to slip another finger inside her exploring her innermost depths. She lets out a moan when brush over her sweet spot. You continue rubbing over it watching the cowslut squirm and moan as your skillful digits take advantage of her most sensitive area.\n\n");
		outputText("\"<i>A-Ah yes! Right there m-my Lady! Please give me more!</i>\"\n\n");
		outputText("Your thumb rubs against her hard button making her squeal in pleasure. Creamy milk leaks from her large teats dripping down the curve of her perky breasts. You lean down and lap at the sweet cream sinking your teeth into her love pillow no doubt leaving a mark. You gasp in surprise when you feel her reach down and rub her soft fingers against your wet nether lips and pleasure button. You moan when her fingers slip past your slick folds. Her other hand gropes at your [chest] flickers her fingers over your nipples. ");
		outputText("You lean up and kiss her forcing her to lap the taste of her own milk from your tongue. You moan into each other's mouths as you're both pushed over the edge. Excellia moos loudly as her pussy clenches tightly around your intruding digits drenching them in femcum. You gasp in pleasure when you cum around the dairy cow's fingers. Her milk streams out coating the both of you in sweet cream adding to the growing puddle beneath you.\n\n");
		outputText("You're both left panting and gasping as you fall over onto your sides. She giggles, pulling you into a boob crushing hug.\n\n");
		outputText("\"<i>W-Wow my Lady… That was truly amazing! I'm so happy to serve you!</i>\"\n\n");
		outputText("You smirk, patting your loyal slave on the head, telling her she performed adequately. You lay next to the cowgirl as she nuzzles up next to you for a rest. After a quick nap, you clean up leaving the still sleeping ex-cow queen to as you prepare to head back out.\n\n");
	}
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampMakeSlaveSexOralFun():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You grin at Excellia telling her that you would like a taste of her. She bounces up and down giddy.\n\n");
	outputText("\"<i>Oh yes my " + player.mf("Lord", "Lady") + "! You can have as much of me as you like!</i>\"\n\n");
	outputText("You lead her to your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin":"tent")+" then head inside, making sure to leave the door open. You lay her back on your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed":"bedroll")+" making sure she's comfortable. "+(player.isNaked() ? "Seeing as you don't wear clothes you shrug then crawl over to the cowgirl":"You shed your gear and place it into a neat pile")+". She pulls you closer and squishes her huge breasts against your [chest] as some of her milk leaks out. ");
	outputText("You lean in to kiss her, your tongue slipping past her lips."+(player.hasCock() ? " You shudder as her lust inducing lipstick starts to take effect, your [cock] rapidly becoming harder by the second.":"")+" She breaks the kiss, lust heavy in her eyes. She's more than ready and so are you.\n\n");
	outputText("You lay back and pull the cowgirl on top of you positioning her to where her glistening pussy lips and large ass sits enticingly in front you and she's facing your groin. You can feel her hot breath on your "+(player.hasCock() ? "cock":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "wet snatch":"")+" making you shudder in anticipation. You're the first one to act when you lean in closer and swipe your tongue over her sweet pussy. Excellia lets out a tiny gasp as your tongue laps at her plump vulva and swirls over her large clitty. Not wanting to be outdone, she leans down then "+(player.hasCock() ? "slurps at the head of your dick":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "laps at your wet pussy":"")+". ");
	outputText("You both find yourselves shivering and moaning under each other's attention. You slip as much of your tongue as you can into her sensitive pussy. "+(player.hasLongTongue() ? "Your long appendage inches into her heavenly snatch brushing against her fleshy wall. ":"")+"She moos out as her walls occasionally squeeze around your invading tongue. You groan, feeling her "+(player.hasCock() ? "engulf your [cock] into her warm mouth":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "massage your pussy with her wonderful tongue":"")+". The mounting pressure in your loins becoming more apparent with each passing second.\n\n");
	outputText("Excellia moos as her pussy clenches around your invading tongue then soaks your mouth and face in a blast of her sticky femcum. You're not too far behind her when your orgasm hits. "+(player.hasCock() ? "You thrust up into her mouth, shooting rope after rope of your hot cum down her throat":"Y")+(player.gender == 3 ? " and y":"")+(player.hasVagina() ? "our wet pussy squirting out it's juices":"")+".\n\n");
	outputText("You're both left panting as your bodies slowly calm down from the exertion. You untangle yourself from her letting out a content sigh. She giggles then pulls you into a passionate kiss. You can faintly taste yourself on her tongue. She pulls back looking at you with nothing but joy in her eyes.\n\n");
	outputText("\"<i>Thank you my " + player.mf("Lord", "Lady") + "! I love it when you do that to me! I hope you found me yummy!</i>\"\n\n");
	outputText("You wouldn't mind doing it again but it's about time for you to get going. So much to do, so little time. Excellia pouts but nods in understanding. She helps you get cleaned up and prepared to head back out.\n\n");
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
public function ExcelliaCampMakeSlaveSexMilkyMassage():void {
	//spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("While drinking her restorative milk can energize you and heal your wounds, you wonder if it will have an interesting effect on you if used in a different manner. You formulate an idea before settling on one that seems the most fun. Excellia notices the lusty look in your eyes. She bounces in place, giddy with excitement.\n\n");
	outputText("\"<i>Oh my " + player.mf("Lord", "Lady") + " I know that look. You have something fun in mind.</i>\"\n\n");
	outputText("Indeed you do. You grab a large blanket then drag the cowslut to an open enough area for your plans, explaining to her that you want her to put her hands and milk to very good use. She seems to catch onto what you mean quickly and grins even wider as you place down the blanket. "+(player.isNaked() ? "Seeing as you already don't wear any clothing, you lay down":"You remove your gear and toss it into a nearby pile before laying")+" on the blanket. Excellia comes to your side and sits, eyeing your nude form in reverie.\n\n");
	outputText("\"<i>O-Oh my " + player.mf("Lord", "Lady") + "... You're just so " + player.mf("handsome", "beautiful") + "... So amazing...</i>\"\n\n");
	outputText("You snap your fingers to bring her back to reality. She mutters an apology before returning to the task at hand. Her hands reach out to first touch your [chest]. Her hands lightly roam over your chest before moving along the rest of your body. You let out a sigh of relief feeling her soft hands brush over your [skin]. She gently rubs your tight muscles to loosen them up a bit. While it does feel nice, you urge her to give you more.\n\n");
	outputText("The dairy cow giggles then climbs on top of you to straddle your waist, making a point to grind her wet pussy against your "+(player.hasCock() ? "[cock]":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "moist snatch":"")+". She reaches up to grope and knead her own chest. She rubs over her milk leaking nipples, the sweet cream dribbling between her fingers down onto your stomach. Soon the cream leaking from her teats turn into a steady stream as it pours down onto you and coats your [skin]. You shudder, feeling a strange warmth slowly spreading through your body.\n\n");
	outputText("The dairy cow smiles then leans over you, rubbing the milk into your [skin]. The warmth deepens as she massages you, her touches brushing over your most sensitive areas. You moan when she continues grinding against your "+(player.hasCock() ? "hardened cock":"")+(player.gender == 3 ? " and ":"")+(player.hasVagina() ? "pussy":"")+". Her hands roam over your body as more of her milk pours over you. It feels surprisingly good, your muscles relax and loosen from the milky massage. Excellia moans with you as she continues grinding against you. Her hips grinds against yours more feverishly, her hands desperately rubbing and grabbing at your [skin].\n\n");
	outputText("The combination of the mounting pressure and warmth spreading through your body becomes too much. You moan out loud as an orgasm rips through you. "+(player.hasCock() ? "You cum, painting your stomach and chest with ropes hot seed. ":"")+(player.hasVagina() ? "Your pussy clenches tightly, milking at a phantom cock. ":"")+"The dairy cow moos as she virtually drenches you in femcum and her sweet milk already coating your body.\n\n");
	outputText("You shudder as the pleasure slowly passes. Your body feels more relaxed than ever before. The cowslut moos quietly on top of you, leaning in and giving you a deep kiss. "+(player.hasCock() ? "Your [cock] surges back to hardness as her aphrodisiac laced lips begin to have an effect on you. ":"")+"She climbs off of you, allowing you to get up. You stretch, all the aches and knots in your body are completely gone.\n\n");
	outputText("\"<i>Oh my " + player.mf("Lord", "Lady") + " you look positively stunning! I hope my creamy massage helped!</i>\"\n\n");
	outputText("It certainly did. You might even reward the ex-cow queen later if you're feeling generous enough. She nearly squeals at the promise of a reward, her tail swishing behind her excitedly. You clean and gather your things, telling her that you may be back later. Giving her a pat on the head you turn to go back to your business for the time being\n\n");
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}

public function totalExcelliaChildren():int {
	return flags[kFLAGS.EXCELLIA_FEMALE_KIDS] + flags[kFLAGS.EXCELLIA_MALE_KIDS] + flags[kFLAGS.EXCELLIA_FEMALE_COW_KIDS] + flags[kFLAGS.EXCELLIA_MALE_COW_KIDS]
}
private function excelliaPreg():void {
	if (!pregnancy.isPregnant) {// && rand(100) < (10 + Math.round(player.cumQ() / 100))
		pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_EXCELLIA);
	}
}
private function ExcelliaPoopsBabies1():void {
	//spriteSelect(32);
	clearOutput();
	player.createStatusEffect(StatusEffects.ExcelliaChildbirth, rand(2), 0, 0, 0);
	outputText("You can hear loud mooing coming from nearby. You follow the source of the noise until it leads you to Excellia's tent. You peek inside to find the cowgirl sitting back with her legs splayed wide and a hand on her rounded belly panting heavily. Her breasts practically leak like a running faucet and her vagina is dilated wide as a gush of fluids rushes out, making a mess of her bedroll.\n\n");
	outputText("\"<i>A-Ah [name] thank goodness you're here… The baby is-nhh-coming!</i>\"\n\n");
	outputText("You waste no time heading off to fetch some towels and some water. You return to the cowgirl's side comforting her as she works to expel your soon-to-born child. She groans in pain when a strong contraction rocks through her. You can see the faint outline of your child slowly worming their way down her birth canal. Excellia grips your hand tightly, nearly crushing it as she pushes and breathes.\n\n");
	outputText("A strange thought comes to mind as the cowgirl strains to push the child out but it just might make sense in this world. You work your way out of her crushing grip then slip between her legs. You lean down and give an experimental lick to her spasming pussy lips. The fluid has a bit of a tangy yet sweet taste, not at all unpleasant. She lets out a low moan that slowly turns into a moo. Seemingly having an effect on her, you gently push her legs further apart then lap at her sensitive pussy and suck on her hardened clitty. ");
	outputText("She nearly squeals as pain slowly mixes with pleasure. Your child seems to move faster down her birth canal. Soon enough you can see the head peeking between her lips. She strains as the shoulders stretches her wider but with one final push the child slips out of her into your waiting arms with a gush of fluids.\n\n");
	outputText("You grab a towel and wash off the crying child in your arms. It's a healthy baby ");
	if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1) outputText(""+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "boy":"girl")+"");
	else outputText(""+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "cowboy":"cowgirl")+"");
	outputText("! You smile and cradle the newborn in your arms to calm " + (player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "him":"her") + " down. H" + (player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "is":"er") + " cries slowly quiet down as you soothe " + (player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "him":"her") + ". " + (player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She") + " looks up at you curiously cooing. " + (player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She") + " has your eyes and Excellia's hair color. The tired cowgirl looks at the both of you with a warm smile.\n\n");
	outputText("\"<i>Come on [name]... I want to hold "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "him":"her")+" too…</i>\"\n\n");
	outputText("You bring the newborn to "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "his":"her")+" mother as she scoops "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "him":"her")+" up into her arms. Your "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "son":"daughter")+" is quick to latch onto her teat and starts suckling. Excellia lets out a content motherly sigh, cradling her child in her arms.\n\n");
	outputText("\"<i>"+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She")+" is just so beautiful… Thank you… Thank you so much for this wonderful gift [name].</i>\"\n\n");
	outputText("She brings you closer as she nurses your child. "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She")+" quickly drains the first breast then switches over to the other one. Your "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "son":"daughter")+" nearly grows to the size of a preteen by the time "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She")+" finishes. "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She")+" cuddles into "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "his":"her")+" mother's arms before slowly falling asleep. You help Excellia get comfortable with her child so she can rest too. You stay with her for a while making sure your little family is fine before heading back out.\n\n");
	if (flags[kFLAGS.EXCELLIA_HUMMUS_OR_SUCCUBUS_MILK] == 1) {
		if (player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1) flags[kFLAGS.EXCELLIA_MALE_KIDS]++;
		else flags[kFLAGS.EXCELLIA_FEMALE_KIDS]++;
	}
	else {
		if (player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1) flags[kFLAGS.EXCELLIA_MALE_COW_KIDS]++;
		else flags[kFLAGS.EXCELLIA_FEMALE_COW_KIDS]++;
	}
	player.removeStatusEffect(StatusEffects.ExcelliaChildbirth);
}
private function ExcelliaPoopsBabies2():void {
	//spriteSelect(32);
	clearOutput();
	player.createStatusEffect(StatusEffects.ExcelliaChildbirth, rand(2), 0, 0, 0);
	outputText("You can hear loud mooing coming from nearby. You follow the source of the noise until it leads you to Excellia sitting near your "+(flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "cabin":"tent")+". The cowgirl sits back with her legs splayed wide and a hand on her rounded belly, panting heavily. Her breasts practically leak like a running faucet and her vagina is dilated wide as a gush of fluids rushes out pulling underneath her.\n\n");
	outputText("\"<i>M-My " + player.mf("Lord", "Lady") + " Ah yes the baby is-ah-coming!</i>\"\n\n");
	outputText("You smirk, coming to the cowgirl's side, encouraging her to expel your soon-to-born child. She groans in pain when a strong contraction rocks through her. You can see the faint outline of your child slowly worming their way down her birth canal. Excellia moos as she pushes to help the child along.\n\n");
	outputText("A delicious thought comes to mind as the cowgirl strains to push the child out that you just can't pass up. You slip between her legs then lean down to give an experimental lick to her spasming pussy lips. The fluid has a bit of a tangy yet sweet taste, not at all unpleasant. She lets out a low moan that slowly turns into a moo. Seemingly having an effect on her, you push her legs further apart then lap at her sensitive pussy and suck on her hardened clitty. She nearly squeals as pain slowly mixes with pleasure. Your child seems to move faster down her birth canal. Soon enough you can see the head peeking between her lips. She strains as the shoulders stretches her wider but with one final push the child slips out of her into your waiting arms with a gush of fluids.\n\n");
	outputText("You look over the crying child in your arms. It's a healthy baby cow"+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "boy":"girl")+"!\n\n");
	outputText("\"<i>A-Ah so good… Can I hold "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "him":"her")+" my " + player.mf("Lord", "Lady") + "? Pretty please?</i>\"\n\n");
	outputText("You bring the newborn to "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "his":"her")+" mother as she scoops "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "him":"her")+" up into her arms. Your "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "son":"daughter")+" is quick to latch onto her teat and start aggressively suckling her milk. Excellia lets out a squeal of delight cradling her child in her arms.\n\n");
	outputText("\"<i>"+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She")+" is just a real cutie! We just have to make another! No, no a bunch more! As much as you like my " + player.mf("Lord", "Lady") + ".</i>\"\n\n");
	outputText("You tell her to calm down and focus on nursing your child. "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She")+" quickly drains the first breast then switches over to the other one. Your "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "son":"daughter")+" nearly grows to the size of a preteen by the time "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "he":"she")+" finishes. "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "He":"She")+" cuddles into "+(player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1 ? "his":"her")+" mother's arms before slowly falling asleep. You help Excellia get comfortable with her child so she can rest too. You leave the pair, thinking of the ways you'll have more delightful fun with them very soon.\n\n");
	if (player.statusEffectv1(StatusEffects.ExcelliaChildbirth) == 1) flags[kFLAGS.EXCELLIA_MALE_COW_KIDS]++;
	else flags[kFLAGS.EXCELLIA_FEMALE_COW_KIDS]++;
	player.removeStatusEffect(StatusEffects.ExcelliaChildbirth);
}
	}
}