package classes.Scenes.Quests{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Plains.GnollSpearThrower;
	import classes.Scenes.NPCs.NPCAwareContent;
	import classes.Scenes.Quests.UrtaQuest.*;

	public class UrtaQuest extends NPCAwareContent
	{

		public function UrtaQuest()
		{
		}



	/**
 * Urta's Quest
 * @Author:
 */

// 	import classes.*
// import flash.events.MouseEvent;
// 	import classes.*

//const URTA_MET_HEL:int = 710;
//const URTA_QUEST_STATUS:int = 711;
//const URTA_FUCKED_HEL:int = 712;
//const SUCCUBI_MILKED_GNOLL_PRINCESS:int = 713;
//const URTA_TAKEN_BY_GNOLLS:int = 714;
//const URTA_BECOMES_SNAKE_SLAVE:int = 715;
//const URTA_GOBLIN_SLAVE:int = 716
//const URTA_TENTACLE_RAPED:int = 717;
//const URTA_TENTACLE_GAPED:int = 718;
//const URTA_IS_VULQUINE_MENACE:int = 719;
//const URTA_RAPED_MINO_LORD:int = 720;
//const URTA_MINO_AND_SUCCUBI_SLAVE:int = 721;
//const EDRYN_BIRF_COUNTDOWN:int = 722;

//You play as Urta, which copies everyone about you into this new variable. Very clumsy.
//TODO: Figure out this whole thing. You play as Urta but the whole quest saves you state into this variable and swaps back and forth
//whenever you "leave" the quest
public var urtaQItems1:ItemSlotClass = new ItemSlotClass();
public var urtaQItems2:ItemSlotClass = new ItemSlotClass();
public var urtaQItems3:ItemSlotClass = new ItemSlotClass();
public var urtaQItems4:ItemSlotClass = new ItemSlotClass();
public var urtaQItems5:ItemSlotClass = new ItemSlotClass();
public var urtaQItems6:ItemSlotClass = new ItemSlotClass();
public var urtaQItems7:ItemSlotClass = new ItemSlotClass();
public var urtaQItems8:ItemSlotClass = new ItemSlotClass();
public var urtaQItems9:ItemSlotClass = new ItemSlotClass();
public var urtaQItems10:ItemSlotClass = new ItemSlotClass();

public function urtaBusy():Boolean {
	return (telAdre.edryn.pregnancy.type == PregnancyStore.PREGNANCY_TAOTH || flags[kFLAGS.URTA_QUEST_STATUS] == -1);
}
public function isUrta():Boolean {
	if (flags[kFLAGS.URTA_QUEST_STATUS] > 0 && flags[kFLAGS.URTA_QUEST_STATUS] < 1) {
		if (player.short == "Urta") {
			if (player.hasCock()) {
				if (player.cocks[0].cockLength == 20 && player.cocks[0].cockThickness == 3) {
					if (player.hasVagina()) {
						if (player.breastRows[0].breastRating == 7) return true;
					}
				}
			}
		}
	}
	return false;
}


//Revelations Talk(C)*
//Requires Lover Urta
public function talkWithUrtaAboutFamFam():void {
	clearOutput();
	outputText("Urta recoils at the topic, but then visibly steels herself, nodding her head.  \"<i>All right... they're really not very pleasant topics, but you and I...  I owe you a lot, " + player.short + ".  You're the most special person in my life.  So, I guess I can tell you what my so-called family was like.</i>\"  She looks down at the table, staring miserably at her latest drink.  \"<i>Obviously, I didn't hatch from a stone egg or something like that, but I never really had a family.  My mother died when I was just a baby and my father hated my guts because of it.</i>\"");

	outputText("\n\nThe vixen sighs sadly, shaking her head as unpleasant memories come flooding back.  \"<i>I have the dubious honor of being one of the very first herms to be born in Tel'adre.  Oh, there were supposedly herms born before the demons, but I've never met or heard of any.  So, when I come into the world, all fluffy and new, a baby girl with a little baby fox-dick between my legs, my parents absolutely freaked.  They thought I was some kind of monster, or that I was a punishment for their sins, or something like that.  The old woman was so horrified at what she'd given birth to that, barely a month after I was born, she managed to sneak off and hang herself.</i>\"  Urta laughs bitterly at that, unable to look at you.");

	outputText("\n\n\"<i>For two gems, the old man probably would have dumped me in an orphanage... but he never did.  I don't know why... and, a lot of nights before I met you, I wish he hadn't even let me live... but he raised me himself.  Always blamed me for mom's death, though, and never hid the fact he resented that I lived when she died.</i>\"  Urta is trying to be strong and keep her voice neutral and disinterested, but it's obvious that there is old pain in her voice and tears fighting to escape her eyes.");

	outputText("\n\n\"<i>So, when I grew up, I was the freak, the unloved, the loner and the loser.  Dad tried to hide that I was a herm as much as possible, and I went along with it because... well, what better did I know?  It was just how I was brought up, I didn't know why I had to keep away from the other kids, but I did.  It kept them ignorant, but they thought I was antisocial and a weirdo.  Then puberty hit...</i>\"  She blushes.  \"<i>I found myself growing until I was bigger than any of the boys, and the hormones hit me like wildfire in the brush.  That's when my secret came out, given that it was the age when we all started trying to pair up, and I became even more of a freak than before.  Things got worse at home; as I started growing older, I started resenting the old man for how he treated me.  The final straw came one day when he burst in on me.  I was pent up and horny and alone and... well...</i>\"  Urta trails off, blushing madly as she makes a familiar stroking-jerking action in the air with one half-closed hand.");

	outputText("\n\n\"<i>The next thing I know, I'm seeing stars, and my ears are full of noise.  The old man is screaming and cursing and spitting, telling me that I'm not his daughter, I never was his daughter, I never will be his daughter, and to get out of his house.</i>\"  She makes a show of shrugging indifferently.  \"<i>I came to consciousness in the alley behind our house, my clothes piled up on top of me, bruised, an eye blacked and my nose bleeding.  I gathered up the clothes I could and staggered away into the growing dusk.  I haven't been back there since.</i>\"   She stops there; shame and fear practically waft from her body and drip from her words, making it quite obvious that even to this day, she's still afraid of her so-called father.");

	outputText("\n\n\"<i>How did I survive?</i>\"  She suddenly says, clearly eager to change the topic.  \"<i>Even back then, it wasn't so hard to live on your own.  To be honest, I'd already been learning how to fight back against bullies from when my secret came out, so having to punch it out with drunks and vagrants and scumbags wasn't that big of a stretch.</i>\"  She suddenly blows on her knuckles and rubs them on her chest.  \"<i>I happen to be the best bare-hands fighter in the whole city,</i>\" she declares, trying to sound proud of the accomplishment.");

	outputText("\n\nShe furrows her brows in thought.  \"<i>I guess I can skip the day to day stuff; you don't need to hear that.  But the biggest thing that happened to me during that time was the day I became the mixed up mess of a herm that I am now.</i>\"  At your query, she sighs softly.  \"<i>I mentioned that I was born with a vulpine penis and not an equine one, didn't I?  Matter of fact, I was born without testes, too, looking more like a girl who'd drunk incubus draft than anything.  At that time, the grey market was starting to run, and I had my heart set on becoming all girl.  I... 'acquired' money through this means and that, and I bought what it was that I wanted: a bottle of pink elixir.</i>\"");

	outputText("\n\nAt your curiosity, she explains, \"<i>I don't know if you've ever heard of something called Ovi Elixir, but the eggs it produces can have all sorts of magical effects, depending on the color.  The potion I'm talking about is... well, it's basically just the yolks of pink eggs all blended together.  Doesn't taste very nice, but it's proven and reliable.  Until I had it...</i>\"  She trails off mournfully.");

	outputText("\n\nRealizing where her story must be going, you quietly finish the thought for her, \"<i>It changed your penis from a fox's into a horse's?</i>\"  Urta nods, sorrow on her face.  \"<i>That's right.  Pretty much doubled in length and girth, changed species, and then gave me balls the size of apples.  All that in one slug of potion - I barely took half the bottle before it did that to me.  I wasn't game enough to finish it after that, I'll tell you.</i>\"  She shakes her head in dismay.  \"<i>I brought it up in the courts, but the Covenant sent a mage to investigate and she proved it was the genuine, unadulterated article.  Nothing wrong with it... which meant whatever caused it to freak out, it was something about me.  So I haven't dared try anything else ever since - I'm enough of a freak as it is.</i>\"  She tries to sound indifferent to it, but you can hear the crack in her voice and see the tear defiantly slide down the end of her nose to drip onto the table.");

	outputText("\n\n\"<i>I... can't really remember now why I wanted to join the Watch.  I guess I was just so sick of always fighting for a bed and a meal, so tired of looking over my shoulder, that even being in the Watch sounded better.  Recruitment was easy; showed a scout that I was able to whup ass with the best of them in exchange for free meals and board, and they were willing to take me.  Mmm... I've still got a soft spot for that chunky mixed meat 'n' gravy pie they serve in the mess...</i>\"  She licks her lips, obviously caught up in her memories of the last time she enjoyed that particular delicacy.  Then her face falls as yet more painful memories dredge themselves up.  \"<i>That was when I found out just how much of a loser I was.  At a time when it was well known any herm could father or bear a child, I was getting a medical as a new recruit.  They found some anomalies, and they told me that all the signs were there that I was infertile.  I was shooting nothing but blanks, and my womb was as barren as the heart of the desert itself.</i>\"");

	outputText("\n\nShe sighs a final time, then smiles sadly at you.  \"<i>Sorry, " + player.short + ", I'm rambling, aren't I?  I just wanted to let you know the truth about me, and why I am... me.</i>\"  She falls into an uneasy silence, awaiting your reaction to her revelations.");

	flags[kFLAGS.URTA_QUEST_STATUS] = .5;
	//Insert PC options here
	//[Comfort Her] [Yeesh][Who Cares]
	menu();
	addButton(0,"Comfort Her",comfortUrtaAfterFamFamTalk);
	addButton(1,"Yeesh",yeeshUrtaAfterFamFamTalk);
	addButton(2,"Who Cares",whoCaresUrtaAfterFamFamTalk);
}

//Comfort Her(C)*
private function comfortUrtaAfterFamFamTalk():void {
	clearOutput();
	outputText("You lean over the table and take Urta's hands in your own.  Her downy fur ruffles as you give her a comforting squeeze, the tension oozing from her body at your touch.  Urta sniffles a little and wipes her moistened cheek on her shoulder, muttering, \"<i>Oh, " + player.short + ", you're too good for me.</i>\"  She pulls back and gives you a knowing smile.  \"<i>You don't have to worry, really.  You turned this down on her luck lush into a happy woman.</i>\"");

	outputText("\n\nUrta pauses then gives you a wry smile as her voice turns husky.  \"<i>Or should I say you've made me a happy herm?  A VERY happy herm.</i>\"  A cylindrical distension begins to rise up her dress.  The sheer fabric strains, but contains it for now.  The tip of the distortion disappears into the foxy fox's ample bust.  You can see the flare peaking out of that simple valley, already oozing slightly.  Urta follows your gaze down and smirks.  \"<i>You know, I used to hate having this happen,</i>\" she says as she stands up and stretches, showing the bulge off to you and anyone else lucky enough to glance in her direction.  Sliding into your arms, the vixen plants a ");
	if (urta.urtaDrunk()) outputText("boozy ");
	outputText("kiss on your lips as she hugs you tight - tight enough that you feel every vein through the concealing silk of her outfit.  \"<i>I'm a lucky girl.</i>\"");

	outputText("\n\nYou return the hug with every fiber of your being, holding her tight.  Nuzzling at your neck, Urta lets her head come to rest on your shoulder.  Her eyes slowly close as she says, \"<i>Just... hold me, " + player.short + ".</I>\"  As if you were going to do anything else!  You cradle the abused vixen for as long as she needs, which turns out to be long enough for her throbbing erection to actually recede, forgotten for the time being.");
	outputText("\n\n\"<i>Thanks, " + player.short + ",</i>\" Urta says as she pulls back, giving your hand a gentle squeeze, \"<i>I didn't know how badly I needed that.</i>\"  She sits back down and explains, \"<i>I'll be fine now, I think.  Thanks again.</i>\"");

	outputText("\n\nNodding, you give the girl a smile as you stand up to depart.  Her eyes twinkle happily as she watches you go.");
	urta.urtaLove(5);
	flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] += 3;
	doNext(camp.returnToCampUseOneHour);
}

//Yeesh(C)*
private function yeeshUrtaAfterFamFamTalk():void {
	clearOutput();
	outputText("You loudly exhale, \"<i>Yeesh,</i>\" with a bemused expression.");
	outputText("\n\nUrta's tail raises up behind her, bristling and bushy.  She indignantly declares, \"<i>Well fuck you, " + player.short + "!  I just bared the scars of my youth to you, and all you can do is respond with this callous bullshit?</i>\"");
	outputText("\n\nYou casually stand and stretch.  Then, as the angry fox watches, you circle the table to come up beside her.  You roughly take hold of her tits with one arm, lifting her out of her seat and into your unavoidable embrace.  Your other hand presses down on the silky black fabric between her legs, finding the bulgy, sensitive sheath and drooping equine length you were looking for.  Urta leans back and whispers an \"<i>Oooooh</i>\" of pleasure, barely noting when her burgeoning length manages to raise the hem of her dress up over her hips, exposing her cock and balls to anyone lucky enough to glance in your direction.");
	outputText("\n\n\"<i>I don't care about your sad-sack tragic history, Urta, and you shouldn't either.  You're the captain of the city guard.  You've got a nice, tight cunt, and let's not forget you being hung like a horse.  Now, are you going to get over your bullshit, or do I have to make you bust a nut in front of everyone, over and over, until you forget about this nonsense?</i>\" you ask, feeling her begin to throb in your capable grip.");

	outputText("\n\nUrta mumbles, \"<i>You're an asshole, you know that?</i>\"  Her tip engorges, widening as it exudes a streamer of pre.  The slimy liquid hangs precipitously in the air as its owner reaches up to cradle your head.  \"<i>But you're MY sexy asshole.</i>\"  Her hips begin to rock back and forth, and the first droplet of liquid lust falls squarely in Urta's glass.  Stiffening into your palm, her oily black nipples rise to the occasion, forming twin tents in the obscuring material.  The gauzy silk clings tight to them, leaving little to the imagination.  You can see every bit of their pebbly texture with ease.");

	outputText("\n\nYou let her go before she can get any farther - you spent enough time listening to her blather, and you can always come back later for a quick fuck with the horny bitch.  Urta pants as she slumps down into her seat, inquiring, \"<i>Are you sure you don't wanna finish what you started?</i>\"");
	outputText("\n\nYou answer with a negative declaration.  You have things to do, but you hope she learned not to be such a sad sack - she's awesome, and she should act like it.");
	outputText("\n\nUrta nods slowly and throws back a swig from her drink.  \"<i>I will.</i>\"");
	outputText("\n\nGood bitch...");
	urta.urtaLove(1);
	flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] += 1;
	doNext(camp.returnToCampUseOneHour);
}

//Who Cares(C)*
private function whoCaresUrtaAfterFamFamTalk():void {
	clearOutput();
	outputText("\"<i>Who cares?</i>\" you ask, without a hint of compassion.");
	outputText("\n\nUrta stiffens, tail rising up behind her, gone bushy with anger.  \"<i>WHAT?</I>\"");
	outputText("\n\nYou rise to leave and  glance over your shoulder at her.  \"<i>I don't care about your tragic history.  I really don't, and I doubt anyone else would either.</i>\"");
	outputText("\n\nUrta growls, \"<i>You asked!</i>\"");
	outputText("\n\nYou tell her that you asked about her parents, not a summary of every misfortune to ever befall her.  Then, you leave, sending a barmaid her way with a drink.  The whiny cunt will likely need it to get over her bruised pride.  You doubt it will stop her from jumping your bones the next time you visit.  Her libido's too high for her to resist.");
	urta.urtaLove(-10);
	flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] -= 5;
	if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] < 1) flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Infertility Discussion(C)*
//Requires PC have discussed family with her previously.
public function infertilityQuestions():void {
	clearOutput();
	outputText("You ask her about her infertility - specifically, how someone could be infertile AND unable to use transformative items without adverse effects.  Urta stirs her drink before shrugging noncommittally.");
	outputText("\n\n\"<i>I don't know. Hell,  I've never even heard of anyone having a reaction like mine before,</i>\" Urta says.  \"<i>Sure, there's plenty of folks who react poorly, but in those cases, nothing happens.  On the flipside, I've heard of folks completely changing species from a single uncooked canine pepper.  There's even a few foxtaurs prowling around - centaurs that got into foxberries with unexpected results.  None of those are anything like me - nobody takes one thing and has a wildly different and opposite reaction.  And being infertile? I don't think anyone younger than fifty besides me is infertile in this whole gods'-damned city.</i>\"");
	outputText("\n\nHow can that be?");
	outputText("\n\nSeeing your look, Urta sighs, \"<i>I really don't know.  A crazy birth defect?  A curse?  The doctors I spoke with told me that my body doesn't seem to fully accept my penis, and it's causing an imbalance through my whole system.  I suppose it might be to blame for my sex drive... but I haven't heard any complaints from you.</i>\"  She gives you a conspiratorial wink.");
	outputText("\n\nWell, ");
	if (player.cor < 33) outputText("you have nothing to complain about there.  Your sexual romps with Urta are always a delight.");
	else if (player.cor < 66) outputText("she's definitely a handful in the sack, you've got to give her that.");
	else outputText("she's a willing fuck, so no complaints there.  Now if she would just get on with it - if you wanted to flirt, you would've instigated it.");
	outputText("\n\nThe prick-vixen catches herself wandering off topic and forcibly drags herself back to the discussion.  \"<i>Anyway, they couldn't do anything for me.  They don't know how to fix me, and that's that.  I'm an infertile, horse-cock endowed herm bitch.</i>\"  She smirks ruefully, \"<i>All of that has made me what I am today - A fierce brawler, a citizen, a captain, and the luckiest herm this side of Lake Marae.  After all, I have you for a lover.</i>\" The gray-furred vulpine girl taps her chin in thought, \"<i>I still wonder if the mages of the Covenant could find anything with their magic, though.  Still, they've enough to worry about with maintaining the wards to keep the demons out.</i>\"");
	outputText("\n\nMaybe they could help.  Urta has to have some kind of connections she can lean on as guard captain, doesn't she?  You say as much.");

	outputText("\n\n\"<i>I suppose it wouldn't hurt to try, huh?</i>\" Urta asks.  A mischievous grin spreads across her face, and she says, \"<i>You want me to be fertile that badly, don't you?  Are you wanting to suck down a load of spunk so virile you can smell it?  Or do you want my pussy so ready for babies that a single drop of cum will have my belly round and my tits leaking?</i>\"  She shudders.  \"<i>Damn, that's a nice thought...  Do you really think I should look into it?</i>\"");
	outputText("\n\n(<b>Encouraging her to visit the Covenant will begin a segment where you play as Urta for a time, and saving will be disabled.  It is recommended you decline and save first if you have not saved in some time.</b>)");
	//Hardcore mode warning!
	if (flags[kFLAGS.HARDCORE_MODE] >= 1) outputText("\n\n<b>Because you're playing in Hardcore Mode, you have to be sure if you're prepared. If you fail the quest, Urta is gone for good and you won't be able to reload.</b>");
	menu();
	addButton(0,"Look Into It",startUrtaQuest);
	addButton(1,"Maybe Later",camp.returnToCampUseOneHour);
}

private function resetToPC():void {
	player = player2;
	player.itemSlot1 = urtaQItems1;
	player.itemSlot2 = urtaQItems2;
	player.itemSlot3 = urtaQItems3;
	player.itemSlot4 = urtaQItems4;
	player.itemSlot5 = urtaQItems5;
	player.itemSlot6 = urtaQItems6;
	player.itemSlot7 = urtaQItems7;
	player.itemSlot8 = urtaQItems8;
	player.itemSlot9 = urtaQItems9;
	player.itemSlot10 = urtaQItems10;
	model.player = player;

	// See called method comment.
	player.fixFuckingCockTypesEnum();
}


//Urta Appearance Screen(C)*
public function startUrtaQuest():void {
	showStats();
	clearOutput();
	trace("Cloning PC's items")
	// *SERIALIZE* out the players current Player object + items
	urtaQItems1 = player.itemSlot1;
	urtaQItems2 = player.itemSlot2;
	urtaQItems3 = player.itemSlot3;
	urtaQItems4 = player.itemSlot4;
	urtaQItems5 = player.itemSlot5;
	urtaQItems6 = player.itemSlot6;
	urtaQItems7 = player.itemSlot7;
	urtaQItems8 = player.itemSlot8;
	urtaQItems9 = player.itemSlot9;
	urtaQItems10 = player.itemSlot10;
	player.itemSlot1 = new ItemSlotClass();
	player.itemSlot2 = new ItemSlotClass();
	player.itemSlot3 = new ItemSlotClass();
	player.itemSlot4 = new ItemSlotClass();
	player.itemSlot5 = new ItemSlotClass();
	player.itemSlot6 = new ItemSlotClass();
	player.itemSlot7 = new ItemSlotClass();
	player.itemSlot8 = new ItemSlotClass();
	player.itemSlot9 = new ItemSlotClass();
	player.itemSlot10 = new ItemSlotClass();
	player2 = player;

	player = new Player();
	model.player = player;
	player.short = "Urta";
	player.tallness = 71;
	player.hairColor = "gray";
	player.hairLength = 12;
	player.skinType = SKIN_TYPE_FUR;
	player.skinAdj = "silky";
	player.skinDesc = "fur";
	player.createBreastRow();
	player.breastRows[0].breastRating = 7;
	player.nippleLength = .75;
	player.skinTone = "black";
	player.lowerBody = LOWER_BODY_TYPE_FOX;
	player.legCount = 2;
	player.earType = EARS_FOX;
	player.faceType = FACE_FOX;
	player.tailType = TAIL_TYPE_FOX;
	player.tailVenom = 1;
	player.createCock();
	player.cocks[0].cockType = CockTypesEnum.HORSE;
	player.cocks[0].cockLength = 20;
	player.cocks[0].cockThickness = 3;
	player.balls = 2;
	player.ballSize = 4;
	player.cumMultiplier = 80;
	player.thickness = 30;
	player.tone = 50;
	player.femininity = 90;
	player.hipRating = 12;
	player.buttRating = 12;
	player.ass.analLooseness = 2;
	player.createStatusEffect(StatusEffects.BonusVCapacity,58,0,0,0);
	player.createVagina();
	player.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
	player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
	player.clitLength = 1;
	player.str = 75;
	player.tou = 80;
	player.spe = 90;
	player.inte = 55;
	player.lib = 70;
	player.sens = 50;
	player.cor = 30;
	player.lust = 55;
	player.hunger = 100;
	player.gems = 183;
	player.level = 15;
	player.teaseLevel = 4;
	//Apply new game plus modifier.
	player.level += (player.newGamePlusMod() * 30);
	player.str += (player.newGamePlusMod() * 25);
	player.tou += (player.newGamePlusMod() * 25);
	player.spe += (player.newGamePlusMod() * 25);
	player.inte += (player.newGamePlusMod() * 25);
	player.HP = player.maxHP();
	player.fatigue = 0;

	//PERKS
	player.createPerk(PerkLib.Resistance,0,0,0,0);
	player.createPerk(PerkLib.Agility,0,0,0,0);
	player.createPerk(PerkLib.WeaponMastery,0,0,0,0);
	player.createPerk(PerkLib.Acclimation,0,0,0,0);
	player.createPerk(PerkLib.Nymphomania,0,0,0,0);
	player.createPerk(PerkLib.Precision,0,0,0,0);
	player.createPerk(PerkLib.Seduction,0,0,0,0);
	player.createPerk(PerkLib.Evade,0,0,0,0);
	player.createPerk(PerkLib.Tactician,0,0,0,0);
	player.createPerk(PerkLib.LungingAttacks,0,0,0,0);
	player.createPerk(PerkLib.ImmovableObject,0,0,0,0);
	player.createPerk(PerkLib.BrutalBlows,0,0,0,0);
	player.createPerk(PerkLib.Brawler,0,0,0,0);
	player.createPerk(PerkLib.Berzerker,0,0,0,0);
	player.createPerk(PerkLib.Tank,0,0,0,0);
	player.createPerk(PerkLib.HistoryFighter,0,0,0,0);

	//GEAR!
	player.setWeapon(weapons.URTAHLB);
	player.setArmor(armors.URTALTA);
//	player.weapon = weapons.URTAHLB;
//	player.armor = armors.URTALTA;
	
	//DISPLAY SOME SHIT YO
	clearOutput();
	flags[kFLAGS.URTA_QUEST_STATUS] = .75;
	outputText("<b>You are Urta, a hermaphroditic fox-morph.</b>");
	outputText("\n\nYou have a vulpine face, fox-like ears atop your head, a bushy fox's tail on your ass, and paw-footed fox-like legs.  Your eyes are a rich green and your lips are a glossy black.");

	outputText("\n\nYou are covered in fur; the dominant color is gray, but there is also black (covering your upper arms from shoulders to elbows, tipping your tail and forming toe-exposing 'kneesocks' on your legs) and even a smallish patch of white that covers your lips and descends down your chest through the valley of your cleavage, ending just above your belly button.  Your hair is cropped short, save for a forelock that can fall into your eyes, and though it's a light gray, there's more than a few locks of solid black that stripe through it.");

	outputText("\n\nOn your chest sit a pair of volleyball-sized tits, capable of filling a DD-cup bra, each one capped with a perky, coal-black nipple.");
	outputText("\n\nBetween your legs are your mixed sexes; a slick and accommodating pussy well-trained with sex toys, and a monstrous prick fit to give the average stallion an inferiority complex.  The arm-like equine cock, 20 inches long and three inches thick, rests above balls that, at over three inches thick, are easily the size of apples.");

	outputText("\n\nYou are currently garbed for work in your usual stud-reinforced leather jerkin, though you go without suitable groin protection due to your cock interfering with efforts to wear normal pants.  An armored leather skirt provides a decent stand to protect your lower body, though as you erect, your maleness has a habit of lifting it out of the way and leaving you vulnerable.  When you desire modesty, you wrap your cock against your leg with your tail.  You are also carrying your favorite halberd; it's not fancy looking, but it's strong, sharp, and well-maintained.  The weaponsmith does good work.");

	menu();
	addButton(0,"Next",towerOfTheCovanant);
}

//The Tower of the Covenant(C)*
private function towerOfTheCovanant():void {
	clearOutput();
	outputText("You get up to leave the table, nervously wrapping your tail down your leg, even though " + player2.short + " helped you overcome that timid habit long ago.  You tell " + player2.mf("him","her") + " that " + player2.mf("he","she") + " can't follow.  To bring " + player2.mf("him","her") + " into the tower would require countless tests for what should only take a few brief moments if you go alone.  Secretly, you wish " + player2.mf("he","she") + " could come with you and hold you tight, to comfort you through this nerve wracking ordeal.  Lifting your chin, you marshal your courage and walk out, wiggling your bottom in " + player2.short + "'s direction to remind " + player2.mf("him","her") + " what " + player2.mf("he","she") + "'ll be claiming tonight if a solution can be found.");

	outputText("\n\nThe door to the Wet Bitch closes behind you with a dull thunk, shutting you off from the warm atmosphere and intoxicating scents you've come to love over your long patronage.  Instead of dwelling on the emotions tying your guts into knots, you focus on putting one furred foot in front of the other.  The crowds of Tel'Adre's most inhabited district are as thick as ever, and they only get worse as you set off towards the temple.  Twice, you almost get trampled by centaurs rushing to their errands.  They have the good sense to apologize with \"<i>Sorry, Urta!</i>\", but they really ought to be more careful.");

	outputText("\n\nA wolf, barely of mating age, bumps into you, trying to reach for your gem pouch with surprisingly skilled fingers.  You growl as you seize his wrist and wrestle him into a wall, slamming him into the old sandstone bricks with enough force to set loose an avalanche of dust that tickles at your nose.  The little pup's eyes are as wide as dinner-plates, terrified beyond measure.  You let him loose with a warning, telling him that he had better be glad he was caught by an off-duty watch-woman and not someone less savory.  He nods and scampers off as soon as he realizes you're done with him, vanishing into the crowds in seconds.  He'll probably go right back to his law-breaking, but maybe, just maybe, the encounter will make him rethink his chosen profession.");

	outputText("\n\nBefore you know it, the great tower is looming over you, casting you in a shade cool enough to make you shiver.  Your fur poofs out a little to deal with the abrupt temperature change, and you glance at the guards posted on either side.  A powerful, white-furred wolf-woman is posted on the right side, clutching an intricately engraved, glowing weapon.  To your left, there's an albino mouse, barely half the size of her companion but outfitted with dozens of smaller blades and a pair of deadly scimitars.  Both have taut muscles visible through their fur, the result of intense training with their weapons of choice.  Their eyes regard you, and upon recognizing you, they relax slightly.");

	outputText("\n\n\"<i>Urta, the Covenant did not send for you,</i>\" announces the wolf with an edge of warning.  \"<i>What brings you here?</i>\" the mouse finishes.");

	outputText("\n\nYou explain that you'd like one of them to re-examine you, not just for signs of taint but other oddities.  After some discussion with a friend, you realized that there must be something abnormal about your body, and you'd like to make sure it isn't something that would interfere with your duties.");

	outputText("\n\nThe two guards exchange looks, but eventually, they turn back to you and say, \"<i>Proceed.</i>\"");

	outputText("\n\nWhew!  You really didn't want to have to fully explain the reasons for your inquiry, particularly not to those two!  They're as fearsome as they come, and if the rumors you've heard are true, they're even wilder fighters than they are lovers.  You pull open the gates and step inside to the tower's interior, noting that while the air remains cool, it is practically aglow with magical lights, giving the whole place a vibrant appearance.");

	outputText("\n\nA burly centaur trots up to you.  \"<i>Urta, come with me.  Snow sent that you needed to see a Diviner, and Gul is free to see you in his chamber.</i>\"  Gul, huh?  He's the same one that tested you for any form of taint, back when you got promoted to captain.  He was an old wolf then, with terrible vision and a frame already hunched by age.   Gul was kind enough to be discreet about your 'addition', saving you a great deal of embarrassment.  Honestly, you're glad it will be him you'll deal with this time.");

	outputText("\n\nThe centaur coughs, \"<i>Here, Urta,</i>\" stirring you from your thoughts.  It seems you've reached Gul's chamber already.  There's nothing to do but go on in...");

	//[NEXT]
	menu();
	addButton(0,"Next",towerOfTheCovenantII);
}

private function towerOfTheCovenantII():void {
	clearOutput();
	outputText("You step inside the dimly lit chamber and close the door behind you.  Opposite, Gul's frail form rocks in a chair nearly as ancient as he is.  His body is shrouded with voluminous robes that conceal much of his frail body from you, but it is his head that catches your attention.  Milky, sightless orbs stare back at you.  The reason for the lack of lighting becomes clear in that moment - Gul has gone completely, utterly blind since your last meeting.");

	outputText("\n\n\"<i>Ah, Urta; it has been some time since you visited me,</i>\" the old wolf calls to you, his voice somewhat thinner with age, but still friendly and warm.  His ears twitch as you move, letting you know that while his sight is gone, he still has his hearing.");

	outputText("\n\nYou smile, happy he remembers you, but curious just how much he can tell without his sight...  Will he be able to help you?  You walk up and give him a quick hug, thankful for his previous assistance and hopeful that his talents will again prove useful.  Without preamble, you explain why you came here, leaving nothing out.  Your cheeks burn with the shame of it all, but you soldier on through it.  Gul's wisdom was a blessing to you when you met him, and you're certain that he'll do what's right.");

	outputText("\n\nThe elderly mage nods his head, scratching his chin in thought.  \"<i>Yes, now that you bring this up to me, it does seem unusual that your transformation would affect your fertility so negatively.  It's especially strange given how unnatural your transformation was in the first place.  Your suspicions make sense to me... with your permission, I will try a spirit probe - no matter what is behind it, such a probe should be able to detect the cause.</i>\"  He chuckles softly.  \"<i>Do not worry, young vixen; my mundane sight is gone, but I can still see with my mind's eyeless vision.</i>\"");

	outputText("\n\nWorry nags at you.  You've spent so long keeping everything private about yourself that allowing someone so deeply inside...  Well, it unsettles you.  Still, this is too important - you've got to know why it is that your body is so strange!  Not just for you, but for " + player2.short + ", too.  The hope that someday you might be able to be a mother (or father!) gives you the strength to nod your head and give your assent.  \"<i>Thank you, Gul.  I will do whatever it takes to help you in your search.</i>\"");

	outputText("\n\nThe wolf nods.  \"<i>Very well, Urta.  Please, kneel before me,</i>\" he asks.  Once you have seated yourself as he requested, he reaches over, joints cracking quietly at the motion, and places his hands at your temples, fingers splayed out over your face.  Sightless eyes closed, he begins to chant in a soft, sing-song tone.  An eerie wind begins to whistle quietly through the chamber, sending a chill racing up and down your spine as Gul's voice quickens in tempo.  Small objects shake and twitch throughout the chamber - trinkets lifting off of sheer surfaces, pages of books flapping back and forth in the ethereal maelstrom.  Gul suddenly lets out a shrill cry, snatching his hands from your face as if it were made of burning coals, the wind snuffing out in a heartbeat.");

	outputText("\n\nYou recoil, unsure of what just happened, but every hair on your body is standing up on end.  An unreasoning terror claws at you from within.  You can barely stifle the scream that rises up unbidden, but you hold it in and turn your attention back to Gul.  The poor mage is beyond upset by whatever he found within you.  Has some horrifying demon been lurking in your body all this time?  Was your mother right?  ...Maybe you should have followed her.  You cast your eyes down and begin to cry without knowing entirely why.");

	outputText("\n\n\"<i>Incredible... I would never have believed it.  Taoth lives!</i>\"  Gul whispers reverently, staring at you with those milky-white eyes of his.");

	outputText("\n\nWhat?  You look up at him, blinking the tears away.  You wipe at your face with your hands, dabbing away the excess moisture as you come to grips with his declaration.  Taoth?  Wasn't he one of the gods the demons hunted and killed at the start of the war?   You don't remember which one he was, but you do know that you can't possibly be some god.  You put your hand on Gul's and say, \"<i>Gul, that can't possibily be true.  I'm no god.</i>\"");

	outputText("\n\n\"<i>Have you never heard of Taoth the Trickster?  The father of foxes?  He is the patron of your race and may have had a hand in the kitsunes as well, an ever-shifting, ever-scheming spirit who delights in mischief and chaos,</i>\" Gul tells you.  \"<i>And no, you are not Taoth, but his essence - his 'ghost', for lack of a better term - is sleeping inside you.  You are the host of a reincarnating god,</i>\" the old mystic concludes.");

	outputText("\n\nA reincarnated god!?  In YOU!?  What... the... fuck?!?  However, when you stop to think about it, it almost makes too much sense - your resistance to demonic magics, the way transformative items backfired on you, the unusual prominence of your male half, even your infertility.  They're all things that would hint at an outcome like this... but if there's a god inside you, wouldn't you have known?  Wouldn't it have done something to make you or the world aware of its presence?  You turn to Gul and ask him just that, wary of his answer.");

	outputText("\n\n\"<i>The essence is buried deeply and, frankly, our usual probes are aimed at detecting corruption in general, not foreign spirits in particular.  As for why it hasn't made itself obvious before now... all my efforts indicate that it is still dormant within you, slumbering and unaware of the world, reacting to external pressures as a sleeper might scratch at a biting flea.</i>\"  The wolf replies.  \"<i>Besides, in hindsight, your gender and your unusual reaction to a feminizing tonic do seem a fair clue as to his presence,</i>\" he adds.");

	outputText("\n\n\"<i>What should I do?</i>\" you cry, not really sure how to handle all of this.  You had suspected a curse or a demon, not a reborn GOD.   You still can't really wrap your head around this.  You repeat, \"<i>Gul, what do I do about this?  Can you... take it out?  Is there something I can do?</i>\"");

	outputText("\n\nGul furrows his brow, tugging fiercely at his beard in thought.  \"<i>I... am not sure.  There's not much I can truly say about gods of any nature...  I would suggest the most effective way to be free of Taoth's spirit is to awaken him and ask him to leave your body.</i>\"");

	outputText("\n\n\"<i>How?</i>\" you ask, wringing your hands.  \"<i>How would I wake him?  I would think with all that I've been through, he'd be up already!</i>\"");

	outputText("\n\nGul's expression doesn't change and he shakes his head.   \"<i>I am uncertain, myself.  With the loss of Taoth's priests, the only thing I can think to suggest is to seek out a shrine of Taoth - the very last one, where Taoth himself fell against the demons, would probably be best.  There, you should be able to call upon Taoth and wake him.  Once woken, I am certain he would be willing to barter with you for his freedom; given your position, I can hardly imagine him finding you to be an attractive host.  He would want to be free, unburdened by sharing a form.</i>\"");

	outputText("\n\nOh... you'll have to go out, to the outside, and find Taoth's shrine.  \"<i>How would I find his shrine?</i>\" you ask Gul, uncertain as to how to even start.  \"<i>Could my lover, " + player2.short + ", come along?  I... I don't want to do this alone.</i>\"  You desperately want " + player2.mf("his","her") + " company and skills at surviving outside the walls for this.");

	outputText("\n\nGul sighs and shakes his head sadly, eyes closed.  \"<i>I am sorry, but it is best to go on your own.  Only by undertaking such a quest alone can you muster the metaphysical pressure to coax the god within you to wakefulness, and only by being alone can you properly focus your mind as to communicate with him.  I know the prospect is frightening... but only by fighting on despite the fear can you hope to prove yourself and rouse him to speak with you.</i>\"  He gives you a pleading look.  \"<i>Please, Urta, you must try; we are growing increasingly strained - the shields will not hold us forever.  Taoth was a master of illusion and misdirection; at the very least, his powers could prolong the time we have left.  We need you to try and bring him back.</i>\"");

	outputText("\n\nYou nod, and ask, \"<i>Can I take a night to be with " + player2.short + " before I go?  In case I don't or can't come back?</i>\"");

	outputText("\n\nThe old wolf nods, a sad smile on his face.  \"<i>I should be exhorting you to do it as quickly as you can, for the Covenant needs all the help it can get, but...  Take what comfort you need from your lover, first.</i>\"  He gives a wistful smile.  \"<i>I remember when I was younger, too... but, you need a way to find the shrine, correct?  That will not be easy...  Look upon the third shelf from the top, over there,</i>\" he proclaims, pointing.  \"<i>There should be a pendant depicting a fox's head carved from crystal.  It is the only remaining regalia of a Taothian high priest; its glow should enable you to find the shrine you seek.</i>\"");

	outputText("\n\nSearching through his shelves, you find the pendant exactly where it's supposed to be, right next to other arcane trinkets whose use eludes you.  This place is a treasure trove of magical knowledge.  Seeing it firsthand brings a measure of comfort to you, as surely Gul and his companions are well equipped to keep this place safe, in spite of his warning statements.  You put it on reverently, and look up at Gul with an immensely thankful expression plastered across your face.  \"<i>Thank you again, Gul, for giving me hope when I had none.  I'll make you and the rest of the Covenant proud.  I promise.</i>\"");

	outputText("\n\nGul gives you a weary smile.  \"<i>I know you will, Urta.  But if you'll excuse me... these old bones need their rest, and an interim captain for the guard must be chosen.</i>\"  He settles back in his chair and closes his eyes, swiftly drifting off to sleep, indicating you should show yourself out.");

	outputText("\n\nYou give him a kiss on the nose and head for the door, equal parts excited and terrified by the opportunity you've been given.  Now, before you leave on your search you should visit " + player2.short + ".  You could tell " + player2.mf("him","her") + " everything, or you could simply spend an evening with " + player2.mf("him","her") + " without letting " + player2.mf("him","her") + " know the danger you're about to get into.  Though, Gul did urge you to make haste, maybe it would be best for everyone if you embarked sooner and returned to " + player2.short + " healthy.");
	//[?Get a Drink][Visit Truth] [Visit] [Embark]
	menu();

	// The description of the getHelBangedAsUrta scene seems to specify that it should only be available to players
	// at fuckbuddy status with Firebutt.
	if (flags[kFLAGS.HEL_FUCKBUDDY] > 0)
	{
		addButton(0, "Stop4ADrink", getHelBangedAsUrta);
	}

	addButton(1,"Visit",visitPCPreUrtaQuest,false);
	addButton(2,"Visit Truth",visitPCPreUrtaQuest,true);
	addButton(3,"Embark",runIntoAGoblin);
}

//Savin Contriboots to UrtaQuest: Get Wrekt by Hel, Miko, and Mai. (Or, Needs More Foursomes)
//{Before embarking on the Quest for Getting a God out of My Dick, add a [Get a Drink] option before leaving Tel'Adre. Must be Fuckbuddies with Hel.}
private function getHelBangedAsUrta():void {
	clearOutput();
	outputText("Before you head out, you decide to grab some liquid fortitude at your favorite watering hole. You make your way down to the Wet Bitch, squinting as your eyes adjust to the deep shadows of Tel'Adre's seediest - and sexiest - bar. You slip in, grabbing a stool at the bar; when your drink comes, you toss your gear aside like a physical weight off your shoulders, sighing heavily as you bring the hefty stein up to your lips. The cool beer goes down quickly, washing away your worries about the upcoming quest, and the recent revelations you've been given. Your mind wanders to " + player2.short + ", wondering if " + player2.mf("he","she") + "'s set you on the right course...");

	outputText("\n\nA hard shove shocks you out of your reverie. You yelp as someone falls right on you, spilling a whole platter full of drinks right on your lap! Your own drink goes falling to the floor as a head falls flat in your crotch, her cheek brushing against your thick equine prick through the now-soaked fabric of your uniform. The young woman that's fallen right into your lap cries out, stuttering out apologies as she tries to stand - only to slip on spilt drinks and fall on her ass, legs spread wide under her too-short skirt, revealing the tight slit of a hairless little cunt... and a sizable prick above it. Seeing your fellow hermaprodite's exposed genitalia brings a sudden and unwelcome hardness to your own hidden cock. You quickly close your legs and try to wrap it up in your tail, but with your clothes utterly soaked, the mottled shaft is plain for anyone to see.");

	outputText("\n\n\"<i>Oh my gods! I-I'm so sorry, miss,</i>\" the girl whines, closing her legs as soon as she sees what she's showing. She's just as soaked as you, it seems, her white shirt now completely transparent, giving you a good look at her perky tits and small, stiff nipples. What's more, though, is the pair of perky ears atop her otherwise human head: they're just like yours - two silvery fox ears! A tail curls in behind her, retreating between her legs in fear as she tries to stand, but she only falls again, her high heels unable to gain traction in the puddle of beer she's sitting in.");

	outputText("\n\nDoing your best to shield your prominent prick, you pull the girl to her feet, rewarded with a stream of embarrassed thanks from the drenched fox-girl. \"<i>I'm so sorry! I wasn't paying attention, and... and... Oh, gods, please forgive me! I'm so sorry!</i>\"");

	outputText("\n\nThere's not much point in being angry with the poor girl. You give her a pat on the shoulder and tell her it's fine... you didn't really like this uniform anyway. It was getting a bit... tight. She visibly brightens as you speak your forgiveness, but just as you turn to make your escape, the girl says, \"<i>Uh, i-if you're not busy, miss, can I, um, buy you a drink? J-just to replace the one I spilled!</i>\"");

	outputText("\n\n\"<i>Oh, what the hell. Why not?</i>\" you say, grabbing a towel from the bar tender, Nancy, to dry yourself off with.");

	outputText("\n\nThe soaked, embarrassed fox-girl gets another platter of drinks from the spider woman and leads you over to her table. \"<i>I'm Mai, by the way,</i>\" she says, taking you to a table in the far corner where another fox-girl and a third, half-naked redhead sit.  The second fox (Mai's twin, you guess; they're strikingly similar) is wrapped up in a bright red tail connected to the redhead. \"<i>This is Miko, and our... friend... Helia.</i>\"");

	outputText("\n\nThe scaley redhead grins up at you, extending a clawed hand for a rough, energetic shake. \"<i>Wow, you found a real cutie, huh, Mai?</i>\"");

	outputText("\n\nMai blushes a bright scarlet, causing her sister and the redhead to burst out laughing. \"<i>Oh, hey wait! I recognize you!</i>\" Helia says with a snap of her fingers. \"<i>" + player2.short + "'s mentioned you! You're Urta, right? Captain of the Guard Urta?</i>\"");

	outputText("\n\nShe knows " + player2.short + "? You quickly nod as your mind quickly reaches its inevitable conclusions. Well, you suppose you can't judge... you haven't exactly been monogamous, either, after all. It isn't fair to expect that from " + player2.mf("him","her") + ", is it?  Still, you shift awkwardly in your seat, nursing your new drink as the scaly warrior girl starts recounting the fights she and " + player2.short + " used to have");
	if (flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] > 0) outputText(", and even how they worked together to bring down an evil sorceress and save her father. Your heart swells with pride as she recounts " + player2.short + " doing so a noble thing, and for a moment you know you made the right pick in a lover..");
	outputText(".  You sit and listen for a long few minutes, sipping at the beer until the liquid courage starts to work its wonders, giving you a little tingle... and helping to open you up, too.  Soon, you're drawn into the conversation, joking and teasing with the other girls as if you'd been friends for ages.");

	outputText("\n\nEventually, though, a particularly lewd joke from the salamander causes your old \"<i>friend</i>\" to remind you of your quest, hitting the underside of the table with an audible THUMP! that shocks the others. They look at you with questioning eyes.... It's time to either hit the road or get some much-needed relief, because this boner isn't going anywhere without your help.");
	dynStats("lus", 20, "resisted", false);
	flags[kFLAGS.URTA_MET_HEL] = 1;
	//[Head Out] [Get \"<i>Help</i>\"]
	menu();
	addButton(0,"Head Out",leaveB4HelFucksUrta);
	addButton(1,"Get \"Help\"",fuckHelAndKitsunesAsUrta);
}

//Head Out
private function leaveB4HelFucksUrta():void {
	clearOutput();
	outputText("As quickly as you can, you blather out some excuse and grab your gear, trying to cover your huge erection as you run toward the door, blurting an awkward thanks over your shoulder for the drink...");
	outputText("\n\n\"<i>Uh, bye!</i>\" Mai calls out, waving. \"<i>See you again some time?</i>\"");
	//{Continue with UrtaQuest}
	outputText("\n\nDo you embark now, visit " + player2.short + ", or visit " + player2.mf("him","her") + " and tell everything?");
	//[Visit] [Visit Truth][Embark]
	menu();
	addButton(1,"Visit",visitPCPreUrtaQuest,false);
	addButton(2,"Visit Truth",visitPCPreUrtaQuest,true);
	addButton(3,"Embark",runIntoAGoblin);
}

//Get \"<i>Help</i>\"
private function fuckHelAndKitsunesAsUrta():void {
	clearOutput();
	outputText("You decide to stick around.  The redhead, at least, is a friend of " + player2.short + ", and the way the three are talking, they all seem... loose.  Maybe they can offer you the release you now need.  They're responsible for this, after all, you reason as you lustily say \"<i>I've got a little friend under the table who wants to say hello.  Maybe you girls can help him get some release, hmm? I promise, I'll be real good to you, too.</i>\"  The fox-girls look to Helia, little tents perking up under their skirts.  The salamander licks her lips and grins, motioning for you to follow her.");

	outputText("\n\nThe next thing you know, your back is slamming against the wall of an upstairs room, your powerful thighs locked around the salamander's waist, lips pressed firmly to hers.  Your wet shirt hangs open, the buttons nearly ripped off to expose your bare breasts, which press tightly against the redhead's slightly larger rack.  The fox-girls follow right behind, tossing their skirts and shifts aside to reveal perky C-cups and groins each sporting eight inches of knotty cock, already hard and dribbling precum eagerly as they work to free you from your straining skirt.  Your fat horsecock finally comes free, popping out from under your hem and sliding up between you and Hel's tits, becoming instantly enveloped in soft warmth.");

	outputText("\n\nWith lusty grins, the twins drop to their knees and let their tongues go to work, bathing the thick black base of your stallion prick in wet kisses, dragging their tongues up and down your length with enthusiastic speed, lapping at your mottled shaft.  The salamander, meanwhile, presses you firmly against the wall and cups her huge rack, moving it and yours up and down your rod together, titfucking you with yourself.  You moan, head rolling back as the four tits run along the top half of your prick, leaving the bottom to be tended by the fox-twins.  They're skilled with their tongues, you manage to think as little shocks of pleasure shiver up your prick to the beat of the fast licks and gentle suckles on your base.  Soon, you're panting heavily, your chest heaving with pleasured gasps as the triple attack continues, slowly moving inexorably downward, tongues and breasts moving along your equine endowment.");

	outputText("\n\nToo soon, though, the salamander releases your cock from her mammaries' embrace, letting you slide back as she joins the sisters on her knees, lifting up your cock to get a good look at the hefty sack swinging twixt your legs.  You can't hold back a little gasp as the salamander's long lizard tongue flicks across your taut package, sending shivers of ecstasy all through your body.  Before you can recover from even that first lick, though, the twins pounce in after their friend, each slurping up one of your apple-sized nuts in her mouth, rolling the heavy orbs around in their mouths like sweet candy, sucking and nibbling at your tenderest flesh.  Shuddering with unbridled delight, you rest a hand on each fox-girl's head, urging them on with your groans and moans of pleasure.");

	outputText("\n\nThe three girls look up at you, their eyes dim with lust as they service your prick: two velvety-wet mouths worshipping your cum-laden balls as a slender, dexterous salamander tongue wraps around the dark base of your balls, slathering your nads with spit and sloppy kisses.  In moments, your entire sack is a wet, dripping mess, the need clenching inside it almost painful, begging for release.  You take your cock back between your bountiful bosom, desperately titfucking yourself to alleviate the pressure inside you, but now that your balls are under attack, you're instantly greeted with a thick flow of precum that paints your chest white.  Thick globs of your plentiful, impotent seed drip down from your heaving chest, splattering onto the faces of the three girls servicing your scrotum.  They all giggle and grin, even more so when you abandon your efforts, instead brushing their cheeks, wiping your mess off and into their eager mouths.");

	outputText("\n\n\"<i>Mmm, so good,</i>\" one of the fox-twins moans around your sack.");

	outputText("\n\n\"<i>There's so much,</i>\" the other adds.");

	outputText("\n\nYou're nearly trembling now, so much pent up need roiling in your sack, demanding release.  Just as you near the edge, spurred closer and closer to orgasm by the three dutiful, worshipping mouths tending to your balls, all sensation around them suddenly stops.  You let out a low, pathetic whine, your knees wobbling and cock spurting enough pre to pool at your feet; the girls back off, standing and grabbing you by the shoulders.  With a yelp, you're thrown onto the bed, landing fuck-pole up as Helia leaps onto you, straddling your flared hips, her hot box just inches from your flared head.");

	outputText("\n\n\"<i>Don't worry,</i>\" the salamander says, grinning wickedly down at you as the fox-twins crawl into bed beside you, their knotty cocks pressing into your thighs, smearing you with their own pre.  \"<i>We'll still help you get off, but you've got to help us needy girls, too. You wanna help us cum too, right?</i>\"");

	outputText("\n\nYou nod eagerly, desperate to cum, to blow your thick load all over the three girls, to paint them milk-white with your seed.  You let yourself be pushed up, one of the fox-twins - Miko, you think - crawling underneath you.  Her added height is just enough to push the first inches of your rod into Hel's cunt, her clawed fingers spreading her wide enough to take your massive girth.");

	outputText("\n\n\"<i>Oooooh yeah, that's a good cock,</i>\" she laughs, reaching down to stroke your rock-hard member.");
	//If PC has a cock:
	if (player2.hasCock()) {
		outputText("  \"<i>I've got a better one ");
		if (helFollower.followerHel()) outputText("at home");
		else outputText("at my beck and call");
		outputText(", you know...  But we've got that in common, don't we?  Mmm, maybe we can share it some day?  A horny girl like you'd just love that, woudn't you? Getting to worship " + player2.mf("his","her") + " cock beside me while my tail fills your ass so full you scream....</i>");
	}

	outputText("\n\nAs the slutty salamander talks, she starts sliding down your rod, slowly bending her knees as inch after inch of your knee-knocking pecker enter her fiery depths.  You cringe as the intense heat of her cunt overwhelms you, the fiery lizard's native element channeled through her sex to give you a hot lava-bath of a pussy to fuck.  But even as your prick fills her, you feel a pointed pressure on your pucker: the fox-girl underneath you is pushing for entrance.  You try to relax yourself, allowing the tip of her knotty canid cock to slide into your ass; as it does so, her sister positions herself behind Hel, grabbing the salamander's hips for support as her cock pushes your spit-slicked sack aside, revealing the damp entrance to your feminine hole.");

	outputText("\n\nYou cry out, throwing your head back with a pleasured scream as the sisters push into you in unison, their long doggy cocks spreading your vaginal and anal walls wide.  They each push a few inches in, just enough to tease you before withdrawing. When their hips start moving, thrusting a pair of cocks in and out of your holes as one, your mouth becomes locked in a silent ring of pleasure, a muted cry of ecstasy frozen on your lips - until your mouth is filled by a thick piece of salamander tail!  Helia chuckles as her tip probes into your mouth, teasing your tonsils and the depths of your throat.  You gag for a split second before your cock-sucking instincts kick in, and you slurp up her tail like a thick scaly prick, lavishing it with the same tongue bathing as you received mere minutes ago.");

	outputText("\n\n\"<i>There's a good girl... good girl...</i>\" Hel moans, stroking your hair.  Finally, she's lowered herself enough that your massive wang is practically hilted inside her, and it feels like there's room to spare - gods, how much cock can she take!?  Before you can question her spacious cunt, though, her muscles go to work, squeezing down around your thick prick as she rolls her hips, slowly fucking you, her measured movements a stark contrast to the short hammer-bursts thundering into your ass and twat as the twins pick up the pace.  You suckle on the fiery redhead's tail, able to do little more than passively accept the two cocks reaming you as the salamander claims your cock, slowly increasing her tempo to nearly match the twins.");

	outputText("\n\nJust as she does, though, Helia leans down right on top of you, pressing her massive breasts to yours, giving you a long lick that tastes of your spent seed.  Her hands reach back, though, spreading her cheeks so that the girl fucking your cunt has a clear shot to the salamander's unused hole, quickly applying her impressive oral skills toward rimming the redheaded warrior.  Her vaginal muscles are soon spasming wildly around your prick, driven wild by the skilled tongue tending to her other hole.  The added pleasure, combined with the now-frenetic pace the fox-girls are keeping, only serves to finally give you the release you've so desperately needed since this romp began: with a cry muffled by your mouthful of tail-cock, you cum, the first thick burst of foxy-horsespunk blasting into Helia's eager cunt.  She lets out a scream of her own as another load fires into her, and soon you can feel the cocks inside you tensing, your own muscular spasms bringing them closer and closer until you feel the first waves of fox-cream smearing your rectal walls, then filling your womb, pumping into you until there's white seed leaking out around the thick knots now buried inside you, combining with your own potent runoff to smear the bed with cum.");

	outputText("\n\nYou finally come down from your orgasmic high minutes later, surrounded by enough excess fox-cum to fill a tub.  With a little help from the salamander, now walking bow-legged, you pull yourself into the bed so that Miko and Mai can deflate their thick knots inside you, lying to either side as your horsecock dribbles the last of its blank seed.  Hel, meanwhile, comes to sit at the head of the bed, letting you rest your head in her well-abused lap, bits of your own spunk sticking to your hair - but it's worth it to feel the warmth emanating from her fiery crotch, to feel her long, clawed fingers lovingly stroking your hair until your drift off into a restful sleep, a lovely fox in either arm, and a fearsome salamander kissing you goodnight.");

	outputText("\n\nYou wake alone, and as the sun rises, you realize it's time to leave the city on your quest...");
	flags[kFLAGS.URTA_FUCKED_HEL] = 1;
	player.orgasm();
	model.time.days++;
	//Advance to next day, jump to leaving text
	//{Resume UrtaQUEST!}
	menu();
	addButton(0,"Next",runIntoAGoblin);
}

//Last Rendezvous with PC - Intro + Sex Menu(C)*
private function visitPCPreUrtaQuest(truth:Boolean):void {
	clearOutput();
	outputText("You set out for " + player2.short + "'s camp, known to you thanks to the amazing efforts of your scouts.  Behind you, the tower slowly shrinks, less imposing now that you've finished that step on your journey.   Ahead lies uncertainty and struggle.  You know you'll likely wind up fighting the corrupted denizens of the lost regions of Mareth in your travels, and it's likely at least a demon or two will get in your way.  Still, as you exit the city gates, you give your home a forlorn gaze.  At least there's one bright patch ahead - your lover's camp.");
	outputText("\n\nThe sun has set by the time you get there, but the darkness conceals your movements thanks to your natural fur color.  ");
	if (player.findStatusEffect(StatusEffects.JojoNightWatch) >= 0 && player.findStatusEffect(StatusEffects.PureCampJojo) >= 0)
		outputText("You easily sneak past a mouse monk.  He's looking towards the sky mostly, perhaps watching for imps.  ");
	if (flags[kFLAGS.ANEMONE_WATCH] > 0 && flags[kFLAGS.ANEMONE_KID] > 0)
		outputText("A confused-looking anemone with a " + ItemType.lookupItem(flags[kFLAGS.ANEMONE_WEAPON_ID]).longName + " nearly sees you, but you duck around a rock and escape her notice.  ");
	if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.HOLLI_DEFENSE_ON] > 0)
		outputText("A dangling tentacle nearly hits you in the dark.  You roll aside at the last moment, looking up to see dozens of the things idly dangling around.  When did this camp get such a corrupt tree in it?  You suppose it must have its uses in defending against foes from the sky...  ");
	if (camp.companionsCount() > 2) outputText("There are a number of people in the camp, but you avoid them as you head towards " + player2.short + "'s bunk.  ");
	outputText("The camp looks pretty nice actually.  Living out here must have given " + player2.mf("him","her") + " plenty of time to improve it.");
	outputText("\n\n" + player2.short + " is slumbering fitfully on " + player2.mf("his","her") + " blanket.  " + player2.mf("He","She") + " looks so cute, sleeping like this.  It's amazing how " + player2.mf("he","she") + " has the courage to stay out here, day after day, month after month, guarding this portal to keep " + player2.mf("his","her") + " village safe");
	if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) outputText(", no matter why " + player2.mf("he","she") + " was sent here");
	outputText(".  You gently press on " + player2.mf("his","her") + " shoulder and shake " + player2.mf("him","her") + " awake, holding your index finger across " + player2.mf("his","her") + " lips to shush " + player2.mf("him","her") + " to silence.  " + player2.mf("His","Her") + " eyes snap open, worried until " + player2.mf("he","she") + " recognizes you.  \"<i>What are you doing here?</i>\" " + player2.mf("he","she") + " asks in a whisper.");

	//{TELL HIM ZE TRUFF}
	if (truth)
	{
		outputText("\n\nYou sit down across from " + player2.mf("him","her") + ", helping " + player2.mf("him","her") + " up to a sitting position as you explain.  " + player2.mf("His","Her") + " eyes widen as " + player2.mf("he","she") + " takes in the news, clearly disbelieving your explanation at first.  " + player2.mf("He","She") + " listens all the same, gradually coming to accept your explanation for truth.  When you tell " + player2.mf("him","her") + " you have to leave, alone, to continue your journey, ");
		if (player2.cor < 33) outputText(player2.mf("he","she") + " argues that " + player2.mf("he","she") + " should come anyway.  You tell " + player2.mf("him","her") + " no, firmly, even though it breaks your heart.");
		else if (player2.cor < 66) outputText(player2.mf("he","she") + " nods understandingly, not surprised that you have to handle this quest alone.  The two of you are alike in that way - each with their own burden to bear.");
		else outputText(player2.mf("he","she") + " nods dismissively, trusting you to handle it alone you suppose.  " + player2.short + " always was hard like that, even though " + player2.mf("he","she") + " clearly likes you.");
		outputText("  You hold on to " + player2.mf("him","her") + ", for comfort, dreading the long day ahead.  " + player2.mf("He","She") + " pats your back comfortingly as you cry, and when you break from the hug, " + player2.mf("he","she") + "'s looking at you expectantly.");
		if (flags[kFLAGS.SLEEP_WITH] != "" && flags[kFLAGS.SLEEP_WITH] != 0) outputText("  " + player2.short + " suggests the two of you move off, so as not to wake " + flags[kFLAGS.SLEEP_WITH] + " in the night.");
	}
	//{LIE}
	else {
		outputText("\n\nYou sit down across from " + player2.mf("him","her") + ", helping " + player2.mf("him","her") + " up to a sitting position as you tell " + player2.mf("him","her") + " that you just wanted to sneak away for a little while, to be with " + player2.mf("him","her") + " as proper lovers, for the night.  " + player2.short + " smiles a little at that, looking up at you expectantly.  Since you came all this way, you must have something in mind for how you plan to stay the night with " + player2.mf("him","her") + ".");
		if (flags[kFLAGS.SLEEP_WITH] != "" && flags[kFLAGS.SLEEP_WITH] != 0) outputText("  " + player2.short + " suggests the two of you move off, so as not to wake " + flags[kFLAGS.SLEEP_WITH] + " in the night.");
	}
	//[SEX OPTIONS GO HURRRR]
	//Snuggle, put cock in cocked PC ass, ride PC cock vaginally, Fuck Girlvag with yer dick, maybe a sixtynine?
	var buttonFuckVagText:String = "Fuck" + player2.mf("His","Her") + "Vag"
	menu();
	addButton(0,"Cuddle",snuggleWithUrta, truth);
	//Put Urta dick in girl PC's vag(C)*
	if (player2.hasVagina())
		addButton(1, buttonFuckVagText, putUrtasWangInPCsCunt, truth);
	//Put a PC dick in Urta's vag(C)*
	if (player2.cockThatFits(urta.urtaCapacity()) >= 0)
		addButton(2,"Ride Dick",putAPCDickInUrtaCoochies, truth);
	//Put Urta dick in the PC's asshole [Cocked PCs](C)*
	if (player2.hasCock())
		addButton(3,"Fuck Ass",urtaPutsHerDickInPCsWithDicks, truth);
	//PC blows Urta(C)*
	addButton(4,"Get BJ",pcBlowsUrtasDong, truth);
}

//Last Rendezvous with PC - Sex(C)*
//Put Urta dick in the PC's asshole [Cocked PCs](C)*
private function urtaPutsHerDickInPCsWithDicks(truth:Boolean):void {
	clearOutput();
	outputText("You push " + player2.short + " down onto the ground, glad that " + player2.mf("he","she") + "'s not wearing " + player2.mf("his","her") + " gear right now.  Unfortunately, you've still got to get out of yours, an action made all the more difficult by the heat welling up in your groin.  Your rebellious cock is already half-stiff, lifting the hem of your armored skirt away from your thighs.  Fingers scrabbling, you struggle with your chestpiece's bindings.  Your nipples stiffen, scraping against the inside of it while you fight to remove it.  You straddle " + player2.short + "'s waist to hold " + player2.mf("him","her") + " down while you work the bothersome, restraining material free, practically grinding your semi-rigid dick against " + player2.mf("his","hers") + " in excitement.  " + player2.mf("His","Her") + " hands begin aiding you in your task, allowing your tightly compressed breasts to finally, happily breathe.   They jiggle as they flop free, and to your delight, " + player2.short + "'s eyes lock on them.");
	outputText("\n\nGrabbing hold of " + player2.mf("his","her") + " head, you pull " + player2.short + "'s lips to one of your puckered nipples.  " + player2.mf("He","She") + " swallows it immediately, grabbing hold of your tits to squeeze and fondle them, openly enjoying the fruits of your womanly shape.  Tingles of electric enjoyment fire from your unrestrained areola when " + player2.mf("he","she") + " squeezes down on the other with " + player2.mf("his","her") + " fingers, expertly twisting the little nub around to give you the maximum pleasure.  In no time flat, you're humping " + player2.mf("his","her") + " " + player2.cockDescript(player2.biggestCockIndex()) + " openly, letting " + player2.mf("him","her") + " guide your motions with deft, controlling touches to your onyx nipples.  Your pre-cum bubbles out unhindered, the thick gobs swaying and splattering on " + player2.mf("his","her") + " belly and rigid tool, quickly lubricating the phallic embrace into a sticky, hot mess.");
	outputText("\n\n" + player2.short + " releases your tender tits after a few particularly sloppy thrusts.  You can feel " + player2.mf("his","her") + " " + player2.cockDescript(player2.biggestCockIndex()) + " releasing some of its own pre-cum onto your cock's thick spooge-vein, and " + player2.mf("his","her") + " hands fall to grab at the blanket below, unintentionally clenching at the waves of pleasure you're giving " + player2.mf("him","her") + ".  You bend now, onto all fours");
	if (player2.tallness < 60) outputText(" and let your tits hang over " + player2.mf("his","her") + " " + player2.face());
	else if (player2.tallness < 76) outputText(" and let your tits swing between you");
	else if (player2.tallness < 84) outputText(" and let your tits smash into " + player2.mf("his","her"));
	else outputText(" and let your tits sway over " + player2.mf("his","her") + " belly");
	outputText(", giving " + player2.mf("him","her") + " something to enjoy while you begin to shift position, dragging your dick down " + player2.mf("his","her") + " length");
	if (player2.hasVagina()) outputText(", past " + player2.mf("his","her") + " pussy,");
	outputText(" and towards the prize you've been wanting since you got here - " + player2.mf("his","her") + " asshole.");
	outputText("\n\nYou glance up at " + player2.mf("his","her") + " face when your oozing, fat cock-tip presses into " + player2.mf("his","her") + " sphincter, looking for assent.  " + player2.mf("He","She") + " gives it a moment later, moaning and rubbing " + player2.mf("his","her") + " butt back into you, butthole clenching and relaxing a little more with every contact.");
	if (player2.analCapacity() > 70) outputText("  Thankfully, " + player2.mf("he","she") + "'s nice and stretched from all the butt-fucking " + player2.mf("he","she") + "'s had to take, and you easily pop inside.  It feels so good that your flare grows wider, pulling you deeper into that welcoming, tight anal heat.");
	else if (player2.analCapacity() > 50) outputText("  Thankfully, " + player2.mf("he","she") + "'s got plenty of give in " + player2.mf("his","her") + " back-door, and you pop inside after applying a little more pressure.  It feels so good that your flare grows wider, slowing your descent into that tight, anal heat.");
	else outputText("  Unfortunately, there's not much give in " + player2.mf("his","her") + " back-door, and you have to sit there smearing pre over it, again and again, each time pushing a little harder.  After what feels like the fiftieth try, you finally pop your fat flare into " + player2.mf("his","her") + " rectum, the tight anal heat causing you to flare from the force of " + player2.mf("his","her") + " pressure.  Slowly, you push inch after throbbing inch of your swollen, stallion-like erection into " + player2.mf("his","her") + " asshole.");
	if (player2.ass.analLooseness == 0) {
		outputText("  <b>You've taken " + player2.mf("his","her") + " anal virginity!</b>");
		player2.ass.analLooseness = 1;
	}
	outputText("  " + player2.short + " writhes as " + player2.mf("he","she") + " takes you, " + player2.mf("his","her") + " hips lifting slightly off the ground to make sure you grind into " + player2.mf("his","her") + " prostate.  A long strand of clear excitement oozes from " + player2.mf("his","her") + " tip");
	if (player2.cockTotal() > 1) outputText("s");
	outputText(", thick, viscous, and clinging to the drying mess you left behind.");

	outputText("\n\nGrabbing hold of you by the scruff of your neck, " + player2.short + " pulls you down into a kiss.  You passionately french " + player2.mf("him","her") + " and try your hardest to time your thrusts to each plunging slurp your tongue makes into " + player2.mf("his","her") + " oral cavity.  Together, you make love, mouth to mouth and cock to ass.  " + player2.mf("His","Her") + " dark pucker wrings at your horse-cock, the tight muscles at " + player2.mf("his","her") + " entrance seizing every time your sheath tickles up against them.  Groaning into " + player2.mf("his","her") + " mouth, you lose whatever control you had and let your equine dong take over, helpless to resist your overpowering lust.  You pound " + player2.mf("his","her") + " clenching anus hard and fast, breaking the kiss as you moan, forgetting how to do anything but hold your body in position and drive your thighs back and forth, back and forth-and-back-forth, faster and faster.");

	outputText("\n\nYour balls begin to tingle with warmth in that familiar way that they do just before you cum, rising slightly involuntarily as your sack starts to pull tight and release.  Your cock flexes inside your lover's asshole hard enough to squeeze a spurt of dick-juice onto " + player2.mf("his","her") + " chest, and with an exultant moan, you declare, \"<i>I'm gonna...  CUUUUUUM!</i>\"  " + player2.short + " answers you with a moan of " + player2.mf("his","her") + " own, digging " + player2.mf("his","her") + " hands into your swaying, unrestrained tits as " + player2.mf("he","she") + " releases.");

	outputText("\n\nYou ram your turgid mass in until your sheath is smashed flat against your abdominals, almost painfully.  Below, your taut sack expands slightly before shrinking, pumping hot pleasure through your abdomen and down your rapidly dilating urethra.  You can feel it dilate the base of your cock, stopped up for a second by " + player2.short + "'s sphincter, and then it pushes through, widening " + player2.mf("his","her") + " butthole in the process.  Your flare feels as wide as one of Aunt Nancy's plates back at the bar, immobilizingly thick and pulsing with every hammering heartbeat that pounds through it.  You release some of your pent-up, achingly hot seed into " + player2.mf("his","her") + " butt with a cry of joy.  Wriggling down against " + player2.mf("him","her") + ", you squeeze " + player2.mf("his","her") + " pulsing erection");
	if (player2.cockTotal() > 1) outputText("s");
	outputText(" between your bodies, " + player2.mf("his","her") + " liquid love exploding all over your cock-locked forms.  Each time you cum, a fresh-squeezed spurt of semen splatters into your tits, " + player2.mf("his","her") + " prostate violently being milked by the heady flows of vixen-spunk you force inside " + player2.mf("his","her") + " rectum.");
	if (player2.hasVagina()) outputText("  You don't notice the female fluids that drip from " + player2.mf("his","her") + " sodden slit - they soak into your big balls, already forgotten.");
	outputText("\n\n" + player2.short + " kisses you, or at least tries to - " + player2.mf("his","her") + " body wiggles " + player2.mf("him","her") + " away with every blissful spurt that " + player2.mf("he","she") + " makes");
	if (player2.cumQ() >= 500) {
		outputText(", made worse by the sheer volume of spunk " + player2.mf("his","her") + " cock");
		if (player2.cockTotal() > 1) outputText("s exude");
		else outputText(" exudes");
	}
	outputText(".  Wonderfully, " + player2.mf("his","her") + " belly begins to round out from your seemingly endless flow of animal jizz.  Without meaning to, you imagine " + player2.mf("him","her") + " as your uber-pregnant, belly-dragging brood-mare, cum drooling from every packed hole and " + player2.mf("his","her") + " body drenched in excess.  The thought sets off another explosive orgasm, even before the first has finished.  Your climax is so powerful that your balls feel like they're being squeezed in a vice.  " + player2.short + "'s asshole fountains cum around the edges of your potent phallus as it's filled beyond capacity.  " + player2.mf("His","Her") + " belly rounds just as you imagined it, and you begin to piston your hips while your eyes roll back, unseeing.  You don't care, you're drooling all over your spunked up broodmare and giving " + player2.mf("him","her") + " another load of kits, even if it is in " + player2.mf("his","her") + " ass!");

	outputText("\n\nEven after your orgasm ends and your strength gives out, you keep working your massive, monstrous dong into " + player2.short + "'s ass with weak little strokes.  " + player2.mf("He","She") + " makes a pained, plaintive moan, just loud enough for you to hear.  That distressed keen is all it takes to shake you out of your fuck-hungry rut, and you immediately pull out, panting and placing a compassionate hand on " + player2.short + "'s face.  " + player2.mf("He","She") + " sighs with relief as a river of your alabaster goo escapes the well-stretched confines of " + player2.mf("his","her") + " over-inseminated anus.  It soaks the blanket utterly");
	if (player2.cumQ() >= 500) {
		outputText(", mixing with " + player2.mf("his","her") + " own ");
		if (player2.cumQ() < 1000) outputText("puddly");
		else if (player2.cumQ() < 2500) outputText("small lake-sized");
		else outputText("massive, lake-sized");
		outputText(" mess - only now do you realize just how much your lover could produce!  The");
	}
	else outputText(", but the");
	outputText(" semen-inundated fabric quickly begins to dry as the parched, wasteland dirt reclaims the moisture.");
	outputText("\n\n" + player2.short + " pulls you down for another kiss, and you lose yourself to it, never going completely soft - as if you could in " + player2.mf("his","her") + " presence.  You close your eyes and let sleep claim you, cuddled together, basking in the heady smell of your combined pleasure.");
	player.orgasm();
	dynStats("sen", -2);
	menu();
	//To morning after fuck departure
	addButton(0,"Next",morningAfterCampVisitEmbark, truth);
}

//PC blows Urta(C)*
private function pcBlowsUrtasDong(truth:Boolean):void {
	clearOutput();
	outputText("You ogle your lover's naked form, admiring " + player2.mf("his","her") + " beauty.  When your eyes fixate upon " + player2.mf("his","her") + " sweet kissing lips... mmm, you'd really like to feel those wrapped around your aching dick...  Mustering your courage, you embrace your partner, and gently but insistently push " + player2.mf("him","her") + " to the ground.  Leaning over to " + player2.mf("his","her") + " ear, you say, in a stage whisper, \"<i>You have such a pretty mouth, and my cock's aching so bad... will you kiss it better?</i>\"  You blush, as much from the corniness of your line as from embarrassment at what you're asking " + player2.mf("him","her") + " to do.");

	outputText("\n\n" + player2.short + " is surprised at your request, but smiles and nods, gently giving your lips a little peck.  A small promise of what's to come.  Feeling emboldened by " + player2.mf("his","her") + " willingness, you grab " + player2.mf("his","her") + " shoulder and pull " + player2.mf("him","her") + " deeper into a kiss, eager to savor the lips that will soon be wrapping themselves around your dick, tongue flicking through them to brush up against your lover's tongue.  While you're  preoccupied with " + player2.mf("his","her") + " mouth, " + player2.short + "'s hands roam your body, seeking the straps holding your leather armor together, peeling off the layers of protection in order to get to your naked body.  You moan appreciatively into the kiss when " + player2.mf("he","she") + " gives your furry breasts an appreciative grope.  \"<i>Mmm, you have wonderful hands, " + player2.short + "; I love it when you touch me like this...</i>\" you croon, and then you kiss " + player2.mf("him","her") + " again to show your appreciation.");

	outputText("\n\nAs wonderful as this feels, however, this isn't what you had in mind, something you become aware of when you feel your cock pushing against your lover's belly.  Your dick bobs up and down before you, the unflared head slightly expanding and then curling back in as arousal builds.  You break away from your lover and give " + player2.mf("him","her") + " a somewhat sheepish smile.  \"<i>Looks like he's eager for your kiss,</i>\" you giggle nervously, trying to lighten the mood by referring to your penis as if it was its own entity... though the depressing thought occurs to you that, with how often it tends to think for you, there's more than a little truth in that idea.");

	outputText("\n\n" + player2.short + " smiles mischievously at you and rolls you over, pinning you on your back while " + player2.mf("he","she") + " eyes your equine-prick.  It stands like a perverted mast, throbbing, aching for a little touch.  \"<i>Well?  Go on, he's not going to bite,</i>\" you suggest, rubbing your thighs together in anticipation of what's coming next.  You want this so badly, but it's hard to get over a lifetime of issues when it comes to your dick.");

	outputText("\n\n" + player2.mf("He","She") + " finally grasps your rock-hard shaft, pumping it lightly.  You moan appreciatively and buck your hips as " + player2.short + " slowly milks you for your pre.  \"<i>W-what are you trying to do?  Stroke me until I blow before you can wrap your lips around it?  Is it - am <b>I</b> -  too big for you to handle, " + player2.short + "?</i>\"  You do your best to make your tone light and playful when you say this.  " + player2.short + " pinches your flared head and gives it a little twist, stimulating your tip sharply.  You squeal in shock, \"<i>" + player2.short + ", not so rough!  I'm not that kinky of a girl!</i>\"  You complain.  " + player2.short + " gives you a smug look, pointing at your shaft and the ample proof of your enjoyment of that little act - your cock is leaking pre like an open tap.  You blush and try to mumble that it's not your fault that happens.");

	outputText("\n\nDollops of pre gather on your tip, and soon begin to overflow, sliding down along your shaft and your lover's hand.  Seeing this " + player2.mf("he","she") + " licks " + player2.mf("his","her") + " lips and slowly approaches your tip, kissing it and licking the pre gathered there.  You moan appreciatively, and give " + player2.mf("him","her") + " a coy smile.  \"<i>Mmm, you're a nice kisser... but let's see some real kissing, shall we?  Give him a little tongue, " + player2.short + ",</i>\" you tease.");

	outputText("\n\n" + player2.mf("He","She") + " does as you ask, licking your throbbing pole clean of pre, then finally taking your engorged tip in, sucking on it like a straw. You groan in pleasure and wriggle your hips as your lover's caressing lips and tongue send sparks of pleasure surging through your nervous system, your dick revelling in what " + player2.mf("he","she") + "'s doing to it.  \"<i>More, please, more!</i>\"");

	outputText("\n\n" + player2.short + " bobs on your shaft, taking it as deep into " + player2.mf("his","her") + " throat as " + player2.mf("he","she") + " can, sucking and slurping obscenely with every move, one hand sliding down to caress your balls, rolling them around in " + player2.mf("his","her") + " palm; " + player2.mf("his","her") + " other moving along your furry belly, reaching for your breasts.  You growl lustily in your throat; your legs twitch with the desire to wrap themselves around " + player2.mf("his","her") + " head and force " + player2.mf("him","her") + " to go all the way down to your balls, but you restrain yourself.  You want to make this special, and that means letting " + player2.mf("him","her") + " have as much control as possible.  \"<i>You have such a sweet mouth, " + player2.short + "... but I think the two of us want some more sugar.</i>\"  Almost as if to punctuate your statement, you moan as your balls clench, squeezing a generous dollop of precum into your lover's mouth.");

	outputText("\n\n" + player2.short + "'s hand leaves your balls and slides behind them, probing your moist honeypot and fingerfucking you slowly. You wriggle and buck in your seat, unconsciously thrusting your dick forward as you react to this unexpected but delightful turn of events.  As if to tease you, " + player2.short + " suddenly stops, removing " + player2.mf("his","her") + " fingers from your dripping pussy and " + player2.mf("his","her") + " mouth from your leaking cock.  \"<i>I'm not done yet!</i>\"  You whimper - you're so close to cumming now, you can feel your balls churning as they stretch themselves with a new load, your dick on fire with the need to release.  Your protests are silenced when you're presented with " + player2.mf("his","her") + " slick fingers, covered in fox honey.");

	outputText("\n\nOh, so that's how " + player2.mf("he","she") + " wants to play it, eh?  Well, you're not afraid of this game.  With your most flirtatious look, you gently take " + player2.mf("his","her") + " hand and lift it to your mouth, slowly and lovingly licking your sweet juices from your lover's fingers, painstakingly lapping each one up and down before you suck them through your puckered lips.  With a muffled chorus of slutty moans you suck, nibble, and nip at the fingers, staring into " + player2.mf("his","her") + " eyes through your own hooded gaze, making it clear you're enjoying every moment of this.");

	outputText("\n\nRemoving " + player2.mf("his","her") + ", now clean, hand from your lips with a <b>POP</b>, " + player2.short + " smiles wryly at you as " + player2.mf("he","she") + " grabs your legs and lifts them over your shoulders.  \"<i>Now what are you-</i>\"  You start to say, curious about what your lover has in mind.  " + player2.mf("He","She") + " silences you by shoving " + player2.mf("his","her") + " fingers down your pussy once again. You blink in surprise, but are too pleased at what's happening now to care much, enthusiastically bucking your hips to meet " + player2.mf("his","her") + " probing fingers, then whimpering in disappointment when they are removed again.");

	outputText("\n\nYou're presented with " + player2.mf("his","her") + " slick fingers once more.  \"<i>Heh, do you get off on seeing me suck your fingers, " + player2.short + "?</i>\"  You're sincerely curious, but eagerly accept them all the same, sucking them clean a second time. You smack your lips as the fingers are extracted from your mouth once more.  You impatiently wriggle and squirm in your seat, \"<i>" + player2.short + ", I'm going mad here - let me cum, please?  Pretty please?</i>\"   " + player2.short + " traces a finger along your shaft, down your balls, along your slit, and gently moves to prod your tight little rosebud.  \"<i>W-what are you up to now?<i>\"  You ask, at once scared and excited to see what " + player2.mf("he","she") + " has in mind.");

	outputText("\n\n" + player2.mf("His","Her") + " only reply is to shove " + player2.mf("his","her") + " slick finger into you, roughly stimulating your prostate.  You vent a throaty howl of equal parts shock, disapproval and ecstasy.  The prostate milking proves to be more than your poor, over-hyped cock can take.  Your balls squeeze themselves up into your crotch as pleasure burns through your stallionhood like hard liquor burns down your gullet, climaxing in a veritable eruption of foxy herm seed that explodes dramatically from your dessert-plate-sized flare, jetting straight at your chest and impacting with enough force to splatter your surroundings.  The bubbling torrent of spunk rains down in a heady, musky, kinky deluge that drenches your face and tits alike.  Unthinkingly, you open your mouth and loll out your tongue, gulping down mouthful after mouthful of your own spooge until finally your balls empty themselves.");

	outputText("\n\n" + player2.short + " releases you, letting your legs flop on the floor nervelessly.  " + player2.mf("He","She") + " pats your thigh and glances at you questioningly.  \"<i>Did fox enjoy her bath?</i>\"  " + player2.mf("He","She") + " asks with a chuckle, rubbing your belly.");

	outputText("\n\n\"<i>I can think of better ways to have a bath,<i>\" you answer primly... then realize your treacherous leg is kicking with pleasure at the belly rub, and you have to concentrate hard to force it to stop.  \"<i>Besides, I thought I was supposed to be giving you a feeding, not myself a bath?</i>\"  You laugh.  " + player2.short + " looks pensive for a moment, but ultimately, " + player2.mf("he","she") + " just shrugs and redoubles " + player2.mf("his","her") + " effort, rubbing your belly even harder to get you to kick your leg a bit more.  \"<i>S-stop that!</i>\"  You blurt, trying to keep the fact that this does feel good out of your voice even as you wriggle at the ticklish sensation.  Of course, maybe a belly-rub on top of a decent bellyful of cum isn't such a good idea; you feel queasy for a moment, then can't hold back a loud burp.  This shocks your mischievous lover into loosening " + player2.mf("his","her") + " grip, and you promptly seize advantage of that; you surge forward and swiftly overpower " + player2.mf("him","her") + ", wrestling " + player2.mf("him","her") + " to the floor and then giving " + player2.mf("him","her") + " a wet, sloppy, deep-throating, tongue-filled kiss.  You noisily make out with your lover for a couple of minutes, then let " + player2.mf("him","her") + " go.  \"<i>See what bad " + player2.mf("boys","girl") + " get?<i>\"  You chuckle.  " + player2.short + " just grins innocently at you.");

	outputText("\n\nYou yawn loudly, feeling tired now.  You promptly make yourself comfortable lying on " + player2.short + "'s belly, and kiss " + player2.mf("him","her") + " on the nose.  \"<i>Night, " + player2.short + "; sleep well.</i>\"  You say, then close your eyes and allow yourself to drift off to sleep, happily using " + player2.mf("him","her") + " as a full-body pillow.");
	player.orgasm();
	dynStats("sen", -2);
	menu();
	addButton(0,"Next",morningAfterCampVisitEmbark, truth);
}

//Put a PC dick in Urta's vag(C)*
private function putAPCDickInUrtaCoochies(truth:Boolean):void {
	clearOutput();
	var x:int = player2.cockThatFits(urta.urtaCapacity());
	outputText("You push " + player2.short + " down onto the ground, glad that " + player2.mf("he","she") + "'s not wearing " + player2.mf("his","her") + " gear right now.  Unfortunately, you've still got to get out of yours, an action made all that more difficult by the heat welling up in your groin.  Your rebellious cock is already half-stiff, lifting the hem of your armored skirt away from your thighs.  Fingers scrabbling, you struggle with your chestpiece's bindings.  Your nipples stiffen, scraping against the inside of it while you fight with to remove it.  You straddle " + player2.short + "'s waist to hold " + player2.mf("him","her") + " down while you work the bothersome, restraining material free, practically grinding your semi-rigid dick against " + player2.mf("his","hers") + " in excitement.  " + player2.mf("His","Her") + " hands begin aiding you in your task, allowing your tightly compressed breasts to finally, happily breathe.");

	outputText("\n\nYour cock throbs in tune with your heartbeat, each pulsation causing a thick gobbet of anticipatory precum to splat wetly onto your lover's belly, but you aren't in the mood to indulge it this time.  If you're risking the possibility of never returning to your lover's arms again, then you want to remind yourself yet again of the first man ");
	if (player2.gender == 3) outputText("...well, close enough... ");
	outputText("to ever fuck you like a woman.  Grabbing " + player2.mf("his","her") + " face, you pull " + player2.mf("him","her") + " into a deep, passionate kiss, unthinkingly grinding your dripping cock and steadily-wettening gash into " + player2.mf("his","her") + " belly and rubbing your own pebbly onyx nipples against " + player2.mf("his","her") + " nipples.  " + player2.mf("His","Her") + " own " + player2.cockDescript(x) + " begins to drool precum");
	if (player2.hasVagina()) outputText(", " + player2.mf("his","her") + " cunt dripping wetly onto the ground from the stimulus");
	outputText(", the fluid rolling down its length to puddle with yours on " + player2.mf("his","her") + " belly and filling your writhing, passionate embrace with hot, sticky sweetness.");

	outputText("\n\nBut this isn't all you intend to settle for, and you break the kiss with some reluctance, a glistening streamer tentatively linking your lips together.  You growl in your throat and nuzzle your cheek against your lover's, before you rise up and take a step back.");

	//{If PC is Centaur or Drider:}
	if (player2.isTaur() || player2.isDrider()) {
		outputText("\n\nYou carefully kneel down on all fours, moving your tail out of the way and giving a flirty wiggle of your ass to entice your ");
		if (!player2.isDrider()) outputText("quadrapedal");
		else outputText("octapedal");
		outputText(" partner to mount you - encouragement " + player2.mf("he","she") + " doesn't really need that much of.  Forelegs draping themselves over your shoulders, there is a little awkwardness as the two of you try to position " + player2.mf("his","her") + " cock inside of you, but it doesn't take that much experimentation before it slides inside you.");

		outputText("\n\nYou can't resist moaning like a slut as the pleasure of being filled by " + player.mf("his","her") + " dick washes through you like a flood of honey-sweet warmth; while you've tried to fill your empty nights with too many toys to be virgin-tight by any means, being filled by the first cock to ever penetrate you for real is still too overwhelming.  Your toy-trained cunt eagerly clamps down on the intruder, squeezing " + player2.mf("his","her") + " dick until you hear your partner moan with pain-tinted pleasure at being held so tight by your love-tunnel.");

		outputText("\n\nYou loosen up the bare minimum, and " + player2.mf("he","she") + " takes that as encouragement to start bucking back and forth, slowly pulling " + player2.mf("his","her") + " cock out of your sopping-wet tunnel and then, just when it's aching to be filled again, forcefully shoving back into you, making your balls and tits bounce and jiggle with each stroke.  Instinctively, your well-trained netherlips ripple and squeeze around the fuckstick currently pistoning in and out of you; knowing that he can't see you in this position, you make no secret of the husky moans and eager whimpers " + player2.mf("his","her") + " machinations are wringing from you.  You feel like such a whore, carrying on on this fashion... but, Marae's sweet tits, it turns you on so!  Your cock bobs up and down from your motions and the weight of your lover slapping into you, its head flaring wider and wider in arousal as precum drips in a steady splat-splat-splat onto the ground.  Awkwardly supporting yourself on just three limbs, you start trying to jerk yourself off whilst your tauric lover fucks you senseless, smearing your own fluids up and down the sensitive skin of your shaft in sloppy wet strokes.  This is certainly a whole new experience compared to fucking Edryn.");

		outputText("\n\nAs you and your lover fuck each other, your mind begins to drift down vistas most pleasant.  In your mind's eye, you see yourself with your fertility restored; your breasts swollen to voluptuous orbs heavy with nourishing milk, flowing eagerly into the hungry mouths of suckling kits, your belly swollen into a beautiful gravid roundness with a new litter of children.  You can feel your babies kicking and moving inside of you, wriggling in that way they do, the thought of which has always made you feel all warm and fuzzy inside.  " + player2.short + " is there, holding you gently in " + player2.mf("his","her") + " arms, smiling proudly as " + player2.mf("he","she") + " runs " + player2.mf("his","her") + " hands over the fullness of your belly, the two of you already anticipating the next litter " + player2.mf("he","she") + " will be filling you with...");

		outputText("\n\nCaught up in your vision, you can't resist calling out to your lover in rapture; \"<i>Fuck me full, " + player2.short + "!  Fill me with your kits!</i>\"");

		outputText("\n\nYour balls begin to tingle with warmth in that familiar way that they do just before you cum, rising slightly involuntarily as your sack starts to pull tight and release.  Your cock flexes, bulging in your fingers as the climax builds up within the cumvein and stretches it out, and with an exultant moan, you declare, \"<i>I'm gonna...  CUUUUUUM!</i>\"  " + player2.short + " answers you with a moan of " + player2.mf("his","her") + " own, ramming with increasing speed and force into your cunt.");

		outputText("\n\nYour equine cock-head flares wider and wider as that oh-so-familiar feeling of hot pleasure begins pumping its way up from your swaying balls and along your fat dick, your heart hammering inside your chest and your flare seeming to pulse with every beat of your heart.  Thick, hot, salty jizz spurts and sprays in load after load from your cock, gushing onto the earth below you and rapidly saturating it, leaving you kneeling over an ever-growing puddle of sex-scented mud.  As you arch your back and thrust out your dick, your cunt tightens, anchoring " + player2.short + " inside of you and giving " + player2.mf("him","her") + " no choice but to cum in turn");
		if (player2.hasVagina()) outputText(", " + player2.mf("his","her") + " female jizz spattering unnoticed onto the ground behind the pair of you");
		outputText(".");

		//PC Cum=Normal or lower:
		if (player2.cumQ() < 500) outputText("\n\n" + player2.mf("He","She") + " sprays " + player2.mf("his","her") + " hot jizz into your milking cunt and you greedily swallow it all, netherlips flexing eagerly in an attempt to coax even more from " + player2.mf("him","her") + ".  While you can feel that delicious cum slurping around inside of you, your mind is still fixated on the image of your womb filled full and ripe and so you find yourself distantly disappointed that this is all " + player2.mf("he","she") + " can manage.");

		//PC Cum=High:
		else if (player2.cumQ() < 1000) outputText("\n\nYou moan and whimper with glee as wave after wave of spooge surges into your burning cunt and is sucked up into your aching womb, stretching it into a blatant little bulge of a belly by the time " + player2.mf("he","she") + " has shot " + player2.mf("his","her") + " load.  Your free hand caresses the filled flesh, feeling it squish and churn, and while the skin is delightfully sensitive, you want <i>more</i>...");

		//(PC Cum=VeryHigh:
		else if (player2.cumQ() < 2500) outputText("\n\nYou let out a howl of joy as your lover's inhuman load begins inflating your womb like a balloon... bigger, bigger, bigger, you want to be bigger!  Oh, yes, yes - you can feel your belly growing round and full and heavy with the sloshing cum your " + player2.short + " is stuffing into your womb; by the time " + player2.mf("he","she") + " has stopped, you look and feel like a full-term mother.  Your belly hangs down barely inches off of the ground, swaying gently to and fro with your motions.");

		//(PC Cum=Extreme:
		else outputText("\n\nYou let out a high-pitched scream of pleasure as the veritable fountain of cum you call your " + player2.mf("boy","girl") + "friend stretches your womb to impossible depths with " + player2.mf("his","her") + " inhuman loads of jizz.  Your belly grows and grows and grows, and it seems to show no sign of stopping; the skin is stretched so tight, the fur pulled into a glossy tautness by your distended womb, that even the merest whisper of wind sends sparks of pleasure crashing through your mind.  You grow inexorably tighter, fuller, and heavier, until the pleasure of being stuffed so overwhelmingly full starts to become slightly painful and fear begins to dilute your belly-lust: is " + player2.mf("he","she") + " ever going to <b>stop</b>?  Thankfully, at last, it ends.  Cum spurts noisily out around the impromptu plug of " + player2.mf("his","her") + " dick, but without the added pressure of " + player2.mf("his","her") + " torrential climax adding to it, even that small mercy feels so good that you'd collapse if you weren't already on the ground.  Your womb has grown so distended that you are no longer kneeling but laying atop it, feeling the seething ocean of " + player2.short + "'s seed churning inside you as you try to regain some semblance of coherent thought.");

		outputText("\n\nYour lover delicately supports " + player2.mf("him","her") + "self atop you for a while longer to catch " + player2.mf("his","her") + " strength back, then carefully extracts " + player2.mf("him","her") + "self from you.  Your muscles are so limp that you find yourself ");
		if (player2.cumQ() < 1000) outputText("falling face-first into the jizz-mud");
		else outputText("not even bothering trying to move your swollen bulk");
		outputText(", and you smile dopily up at " + player2.mf("him","her") + ", love shining in your eyes.  Carefully, " + player2.mf("he","she") + " positions " + player2.mf("him","her") + "self beside you and strokes your face before closing " + player2.mf("his","her") + " eyes, making it quite clear " + player2.mf("he","she") + " intends to go to sleep right here.  You see no point in fighting the inevitable and instead give yourself over to slumber - wouldn't be the first time you woke up in dried cum-mud, after all...");
	}
	//Else:
	else {
		outputText("\n\nTurning yourself around so that your lover can admire your ass - you croon with enjoyment when " + player2.mf("he","she") + " sneaks this opportunity to give it a lustful squeeze, rolling the firm, well-fleshed muscle of each cheek around in the palm of " + player2.mf("his","her") + " hand - you hold yourself there long enough to playfully brush your tail across " + player2.mf("his","her") + " face before slowly lowering yourself down, painstakingly impaling yourself on " + player2.mf("his","her") + " cock.  You can't resist moaning like a slut as the pleasure of being filled by " + player2.mf("his","her") + " dick washes through you like a flood of honey-sweet warmth; while you've tried to fill your empty nights with too many toys to be virgin-tight by any means, being filled by the first cock to ever penetrate you for real is still too overwhelming.  Your toy-trained cunt eagerly clamps down on the intruder, squeezing " + player2.mf("his","her") + " dick until you hear your partner moan with pain-tinted pleasure at being held so tight by your love-tunnel.");

		outputText("\n\nYou throw " + player2.mf("him","her") + " a smile over your shoulder and start to bounce up and down in " + player2.mf("his","her") + " lap, squeezing and rippling your netherlips around the delicious fuck-stick inside of them as you gyrate, making husky moans of lust to further entice and arouse your partner.  You grind your ass into " + player2.short + "'s crotch, trying your best to ignore your persistent cock as it slaps wetly into your tits and drools precum all over your nipples - you want to focus on your cunt.  You moan in surprise and pleasure as " + player2.short + " suddenly reaches around to your front, " + player2.mf("his","her") + " skilled hands playing with the pebble-like nubs of your black nipples.  Each touch, stroke, and tweak sending sparks of pleasure racing down to your crotch.  " + player2.mf("He","She") + " begins to fondle and stroke your full, furry breasts, and you croon in pleasure at the attention; you've always been rather proud of them, even if they aren't as big as Edryn's.  For all that " + player2.mf("he","she") + " seems not to care about your dick, you still can't help but feel surprised when one hand closes on your shaft, teasingly stroking the increasingly slick and unbearably sensitive horse-meat up and down in time with " + player2.mf("his","her") + " thrusts into your greedy cunt.");

		outputText("\n\nAs you and your lover fuck each other, your mind begins to drift down vistas most pleasant.  In your mind's eye, you see yourself with your fertility restored; your breasts swollen to voluptuous orbs heavy with nourishing milk, flowing eagerly into the hungry mouths of suckling kits, your belly swollen into a beautiful gravid roundness with a new litter of children.  You can feel your babies kicking and moving inside of you, wriggling in that way they do, the thought of which has always made you feel all warm and fuzzy inside.  " + player2.short + " is there, holding you gently in " + player2.mf("his","her") + " arms, smiling proudly as " + player2.mf("he","she") + " runs " + player2.mf("his","her") + " hands over the fullness of your belly, the two of you already anticipating the next litter " + player2.mf("he","she") + " will be filling you with...");

		outputText("\n\nCaught up in your vision, you can't resist calling out to your lover in rapture; \"<i>Fuck me full, " + player2.short + "!  Fill me with your kits!</i>\"");

		outputText("\n\nYour balls begin to tingle with warmth in that familiar way that they do just before you cum, rising slightly involuntarily as your sack starts to pull tight and release.  Your cock flexes, bulging in " + player2.short + "'s fingers as the climax builds up within the cumvein and stretches it out.  With an exultant moan, you declare, \"<i>I'm gonna...  CUUUUUUM!</i>\"  " + player2.short + " answers you with a moan of " + player2.mf("his","her") + " own, ramming with increasing speed and force into your cunt.");

		outputText("\n\nYour equine cock-head just flares wider and wider as that oh-so-familiar feeling of hot pleasure begins pumping its way up from your swaying balls and along your fat dick, your heart hammering inside your chest and your flare seeming to pulse with every beat.  Thick, hot, salty jizz spurts and sprays in load after load from your cock, rising up into the air and then falling back onto you, completely plastering your tits and belly in your own spunk, smearing your face with it and forcing you to lick it up.  As you arch your back and thrust up your dick, your cunt tightens, anchoring " + player2.short + " inside of you and giving " + player2.mf("him","her") + " no choice but to cum in turn");
		if (player2.hasVagina()) outputText(", " + player2.mf("his","her") + " female jizz spattering unnoticed onto the ground beneath the pair of you");
		outputText(".");

		//(PC Cum=Normal or lower:
		if (player2.cumQ() < 500) outputText("\n\n" + player2.mf("He","She") + " sprays " + player2.mf("his","her") + " hot jizz into your milking cunt and you greedily swallow it all, netherlips flexing eagerly in an attempt to coax even more from " + player2.mf("him","her") + "; while you can feel that delicious cum slurping around inside of you, your mind is still fixated on the image of your womb filled full and ripe and so you find yourself distantly disappointed that this is all " + player2.mf("he","she") + " can manage.");

		//(PC Cum=High:
		else if (player2.cumQ() < 1000) outputText("\n\nYou moan and whimper with glee as wave after wave of spooge surges into your burning cunt and is sucked up into your aching womb, stretching it into a blatant little bulge of a belly by the time " + player2.mf("he","she") + " has shot " + player2.mf("his","her") + " load.  Your hands caress the filled flesh, feeling it squish and churn, and while the skin is delightfully sensitive, you want <i>more</i>...");

		//(PC Cum=VeryHigh:)
		else if (player2.cumQ() < 2500) outputText("\n\nYou let out a howl of joy as your lover's inhuman load begins inflating your womb like a balloon... bigger, bigger, bigger, you want to be bigger!  Oh, yes, yes - you can feel your belly growing round and full and heavy with the sloshing cum your " + player2.short + " is stuffing into your womb; by the time " + player2.mf("he","she") + " has stopped, you look and feel like a full-term mother.  Your belly weighs you down with its solid, fluid-filled mass, swaying gently to and fro with your motions.");

		//(PC Cum=Extreme:
		else outputText("\n\nYou let out a high-pitched scream of pleasure as the veritable fountain of cum you call your " + player2.mf("boyfriend","girlfriend") + " stretches your womb to impossible depths with " + player2.mf("his","her") + " inhuman loads of jizz.  Your belly grows and grows and grows, and it seems to show no sign of stopping; the skin is stretched so tight, the fur pulled into a glossy tautness by your distended womb, that even the merest whisper of wind sends sparks of pleasure crashing through your mind.  You grow inexorably tighter, fuller, heavier, until the pleasure of being stuffed so overwhelmingly full starts to become slightly painful and fear begins to dilute your belly-lust... is " + player2.mf("he","she") + " ever going to <b>stop</b>?  Thankfully, at last, it ends. Cum spurts noisily out around the impromptu plug of " + player2.mf("his","her") + " dick, but without the added pressure of " + player2.mf("his","her") + " torrential climax adding to it even that small mercy feels so heavenly that your muscles lose what little strength they had left. Unbalanced by the churning mass of spunk in your womb you slowly topple onto your side, some distant part of your mind grateful that " + player2.short + " is quick enough to ease your graceless change of position so that you don't bash your head on a rock. You smile in contentment as your hand languidly explores the large expanse of your inflated belly. Your womb is so distended that, if you had a twin sister, she could probably just about fit inside your newly stretched cavern... well, if she curled up like a baby, anyway.");

		outputText("\n\nWith a sigh, your " + player2.short + " gently ruffles your hair, but makes no attempt at trying to shift you.  You welcome " + player2.mf("his","her") + " lethargic contentment; with how limp your muscles are after a good fucking");
		if (player2.cumQ() >= 1000) outputText(" not to mention the weight of your overstuffed belly");
		outputText(" you don't really feel inclined to move, either.  Instead, you yawn loudly, make yourself comfortable upon your lover's stomach, and allow yourself to drift off to sleep - already, you can hear the quiet breathing of " + player2.short + " as " + player2.mf("he","she") + " does the same thing.");
	}
	player.orgasm();
	dynStats("sen", -2);
	menu();
	addButton(0,"Next",morningAfterCampVisitEmbark, truth);
}

//Put Urta dick in girl PC's vag(C)* (Tweaked to support maleherms. Also hermaphrodite PC now cums!)
private function putUrtasWangInPCsCunt(truth:Boolean):void {
	clearOutput();
	outputText("You push " + player2.short + " down on " + player2.mf("his","her") + " back, a task made all the more difficult by your growing arousal.  Thankfully, " + player2.mf("he","she") + "'s not wearing " + player2.mf("his","her") + " usual " + player2.armorName + ".  Instead, " + player2.mf("his","her") + " form is bared to your probing fingertips, pliant and exposed.  You cannot help but dip a finger into " + player2.mf("his","her") + " moist delta, parting the oozing veil to enjoy the view of " + player2.mf("his","her") + " ");
	if (player.vaginaType() != 5) outputText("pink, ");
	outputText("pulsing interior.  The sight is exciting in the extreme, immediately sending your heartbeat through the roof.  Your tremendous horse-cock is immediately stiffened by your ardor, along with your coal-black nipples, and your armor-plated skirt begins to rise, as if by magic.");

	outputText("\n\n" + player2.short + " giggles at the tenting garment, playfully reaching under to caress the sensitive bottom of your swelling bulge.  Fresh length quickly surges out of your sheath in response, popping your tip past the hem in a second to hang there, pulsing, stiff, and slowly winking your urethra at your lover's face.  Your nipples grow so hard that they're almost painful, and they scrape against the interior of your leather breastplate irritatingly.  Struggling with the straps, you do your best to undo the offending armor, but it just... won't... come... free!   Damnit!");

	outputText("\n\nYou twist around and grab at the straps holding your gear together with hands shaking so hard they fumble off of them more often than not.  " + player2.short + " laughs again at your mistake, gently cupping your smooth nutsack in " + player2.mf("his","her") + " hand.  Your mammoth balls are so large that they hang partway off " + player2.mf("his","her") + " palm on either side, but " + player2.mf("he","she") + " doesn't seem to mind.  In fact, " + player2.mf("he","she") + " begins to roll them back and forth luxuriously.  Your tip flares slightly as it releases a slippery deposit onto ");
	if (player2.pregnancyIncubation > 0 && player.pregnancyIncubation < 150) outputText("the curve of " + player2.mf("his","her") + " pregnant belly");
	else if (player2.tone >= 65) outputText("" + player2.mf("his","her") + " toned abdomen");
	else if (player2.tone < 30) outputText("" + player2.mf("his","her") + " soft, forgiving middle");
	else outputText("" + player2.mf("his","her") + " belly");
	outputText(".  The attentions drive your attempts to dislodge the offending garments from your lusty frame to new levels.  Metal rivets slowly give before finally snapping apart to free your left shoulder.  Your left nipple tingles with pleasant, palpable relief, and you turn to the other side, intent on ripping it off, so that you can be with your lover, skin to skin.");

	outputText("\n\n" + player2.short + " gently rests " + player2.mf("his","her") + " finger across your nose and lips, commanding, \"<i>Hold on a second.</i>\"  You look at " + player2.mf("him","her") + " and pant, your tongue dangling freely, dripping with frothy saliva as you try to contain yourself.  Your erection, painfully hard, twitches when " + player2.mf("he","she") + " finally stops teasing it, already missing the pleasant touches.  Thankfully, " + player2.mf("he","she") + " begins to remove your armor for you, smoothly undoing one strap at a time.   You sigh in exquisite relief when your chest bounces free, released from the binding leather bondage.  " + player2.short + " tosses the armor aside before rounding back to your skirt.  A quick twist of the clasps, and it joins the rest of the ensemble, leaving you naked and exposed.");

	outputText("\n\n\"<i>Was that what you wanted?</i>\" " + player2.mf("he","she") + " asks.  You shut " + player2.mf("him","her") + " up by kissing " + player2.mf("him","her") + ", mashing your tits into " + player2.mf("his","her") + " chest so hard that they bulge out obscenely, pressed down painfully.  Your tongue twines with " + player2.short + "'s, twisting into a double helix of lusty licks and slippery, oral caresses.  Pleasantly, your monstrous equine dong is dripping pre all over " + player2.mf("his","her") + " middle, right up onto the bottom of " + player2.mf("his","her") + " chest.  " + player2.mf("He","She") + " has to force you back up off " + player2.mf("him","her") + " with both hands, just to be able to talk.  Breathily, " + player2.mf("he","she") + " whispers, \"<i>I hope you didn't come all this way just to make out all night.</i>\"");

	outputText("\n\nYou answer with a feral, lusty snarl ");
	//{fork centaurs/nagas/goo here}
	//{centaur}
	if (player2.isTaur())
	{
		outputText("and climb off the 'taur-" + player2.mf("man","woman") + ".  " + player2.mf("He","She") + " smirks up at you, until you bid " + player2.mf("him","her") + " to rise, telling " + player2.mf("him","her") + " that you plan to mount " + player2.mf("him","her") + " like the fertile filly " + player2.mf("he","her") + " is. Reluctantly, " + player2.short + " clatters up onto " + player2.mf("his","her") + " hooves.");
		if (player2.tailType > TAIL_TYPE_NONE) outputText("  You stroke " + player2.mf("his","her") + " tail as you shift it aside");
		else outputText("  You stroke " + player2.mf("his","her") + " swollen sex as you admire it");
		outputText(", making sure you've got the perfect view of " + player2.mf("his","her") + " lube-slimed horse-cunt.  Unbidden, your cock thickens, disgorging a potent trail of animal-pre down its underside in anticipation.");
		if (player2.wetness() >= 4) outputText("  Fuck, " + player2.mf("he","she") + "'s wetter than Edryn!  Just look at those heavy trails of slick moisture as they run down " + player2.mf("his","her") + " rump and hindlegs.");
		else if (player2.wetness() >= 2) outputText("  Fuck, " + player2.mf("he","she") + "'s as wet as Edryn!  Beads of moisture are forming on " + player2.mf("his","her") + " clit, ready to drop to the ground.");
		else outputText("  Fuck, " + player2.mf("he","she") + "'s almost as wet as Edryn!  Just getting a sniff of " + player2.mf("his","her") + " horny horse-snatch has your head swimming!");
		outputText("  You give it a lick and shudder, taking in a few deep lungfuls of " + player2.mf("his","her") + " scent.");
		if (player2.tallness >= 84) outputText("  Before you know what you're doing, you've pulled " + player2.mf("his","her") + " back to a rock and climbed atop it, bringing your cock level with that heavenly hole.");
		else outputText("  Before you know what you're doing, you've raised yourself up to your full height, bringing your cock level with that heavenly hole.");
	}
	//{goo}
	else if (player2.isGoo()) {
		outputText("and roll the gooey woman so " + player2.mf("he","she") + "'s face down.  " + player2.mf("He","She") + " holds " + player2.mf("him","her") + "self up off the dry dirt with " + player2.mf("his","her") + " palms, sweet, slimy bottom upraised above " + player2.mf("his","her") + " goopy undercarriage.  Amazingly, there's a slight parting in the mass of slime, right between where " + player2.mf("his","her") + " legs would be, if " + player2.mf("he","she") + " had them.  A narrow, barely visible divide can be spotted inside, capped with the telltale bulge of " + player2.mf("his","her") + " ");
		if (player2.clitLength < .5) outputText("tiny ");
		else if (player2.clitLength >= 2.5) outputText("massive ");
		outputText("button.  You nuzzle up to that slick slime-cunt, sniffing at " + player2.mf("his","her") + " super-wet snatch, taking the pheromones as deeply inside yourself as possible.  " + player2.mf("His","Her") + " femininity is so strong that it makes your head spin and your dick ache.  Glancing down as you lick the moisture from your muzzle, you see the rigid, over-engorged veins standing out in harsh relief on your equine tool.  Your legs seem to move on their own, lining you up with the moisture-laden slit just inches away.");
	}
	//{nagas}
	else if (player2.isNaga()) {
		outputText("and roll the snake-woman over so " + player2.mf("he","she") + "'s prostrate on the ground, barely holding " + player2.mf("him","her") + " front half up with " + player2.mf("his","her") + " arms.  " + player2.mf("His","Her") + " loins are flat on the ground, undulating slightly as " + player2.mf("he","she") + " grinds " + player2.mf("his","her") + " moist clit against it for sensation.  Your lover's anatomy poses a problem for your choice of positions, but then, inspiration strikes.  You come up under the hind part of " + player2.mf("his","her") + " snake-tail, and hoisting it up, you support half over your shoulder.  As expected, " + player2.mf("he","she") + " has all the flexibility of the serpent " + player2.mf("he","she") + " so resembles, and " + player2.mf("his","her") + " tail bends down just far enough for " + player2.mf("his","her") + " cunt to hang a mere inch above your rigid tool, right where " + player2.mf("his","her") + " body changes from snake to person.");
		if (player2.wetness() >= 3) outputText("  " + player2.mf("His","Her") + " moisture drizzles from that wanton slit, basting you with " + player2.mf("his","her") + " fragrant femininity, and you have a hard time not taking " + player2.mf("him","her") + " here and now.");
		outputText("  The tail you're holding up coils in, sliding around your arm and middle, wrapping you up in snakey snugness.  With impeccable control, " + player2.mf("he","she") + " squeezes a little bit, bringing " + player2.mf("his","her") + " cunt close enough to breathe foggy moisture on your equine tool.");
	}
	//{biped}
	else {
		outputText("and roll " + player2.mf("him","her") + " over on " + player2.mf("his","her") + " hands and knees, lifting that sweet butt up in the air where you can admire it.  You kneel behind " + player2.mf("his","her") + " and, pressing your nose into " + player2.mf("his","her") + " fragrant quim, you extend your tongue, letting the smooth oral muscle taste " + player2.mf("his","her") + " juices and tease at " + player2.mf("his","her") + " engorging clit.  " + player2.short + " moans and presses back into you, crying out like a true bitch in heat, one in need of a thorough rutting.  The thought hits your cock like a lightning bolt, and it fills out to painful proportions, every vein and bulge standing out in stark relief, thumping obscenely to the tune of your insatiable lust.  You moan into " + player2.mf("his","her") + " lovely-tasting snatch, gulping down ");
		if (player2.wetness() < 3) outputText("every drop of nectar that " + player2.mf("he","she") + " gives up");
		else if (player2.wetness() < 4) outputText("the copious drops of nectar " + player2.mf("he","she") + " gives up");
		else if (player2.wetness() < 5) outputText("the drizzling moisture that oozes from " + player2.mf("his","her") + " twat");
		else outputText("the rivers of girl-lube that run unimpeded from " + player2.mf("his","her") + " sopping twat");
		outputText(".  You sniff in great lungfuls of " + player2.mf("his","her") + ", your head swimming with need, and before you know it, you've risen behind " + player2.mf("him","her") + ", your oozing flare just inches from that delectable opening.");
	}

	outputText("\n\nGrabbing hold of " + player2.short + " by " + player2.mf("his","her") + " waist, you level your phallus up against " + player2.mf("his","her") + " lips and press forward, hard.  " + player2.mf("His","Her") + " velvet curtains part slowly under your relentless pressure, a hanging veil of lubricants sheathing your head as it batters its way inside " + player2.mf("him","her") + " in pliant depths.  " + player2.mf("He","She") + " fits you like a glove, a soft, squishy, velvet-lined glove that squeezes back against you oh-so-perfectly.  You groan in delight, but " + player2.mf("he","she") + "'s only taken a few inches - there's at least fifteen more, throbbing bigger in excitement.  " + player2.short + " grunts out loud, pushing back against you, stretching " + player2.mf("him","her") + "self around you to take a little bit more.  " + player2.mf("His","Her") + " lips cling to your girth, welcoming ever greater lengths of your iron shaft into the swelteringly pleasant embrace of " + player2.mf("his","her") + " needy hole.  When your medial ring catches " + player2.mf("his","her") + " clit, " + player2.mf("he","she") + " moans, shaking " + player2.mf("his","her") + " asscheeks at you.");

	outputText("\n\nYou smack " + player2.short + " on the ass, and " + player2.mf("he","she") + " wiggles again, this time slower, and more sensually.  " + player2.mf("His","Her") + " cunt feels sinfully tight around you");
	if (player2.vaginalCapacity() >= 200) outputText(", though you know " + player2.mf("he","she") + " can handle cocks with Edryn's ease");
	outputText(".  It's a wonderful sensation, and you push the rest of the way in with one, hard thrust.  Your sheath is pushed back against you, releasing an extra inch of horse-cock into your partners willing, lube-dripping pussy.  The oversensitive horseflesh bombards you with a wave of fresh feelings so strong that your legs nearly fold under you.  You dig your hands into " + player2.short + "'s haunches for support and hang on for dear life, instinctively plowing " + player2.mf("his","her") + " [vagina] like your life depended on it.");

	outputText("\n\nMoaning, " + player2.mf("he","she") + " looks over " + player2.mf("his","her") + " shoulder and whispers, \"<i>Do it!  I can-can't take much more!</i>\"");

	outputText("\n\nYou oblige your lover's request (as if you had any other option) and hammer your oozing dick deep into " + player2.short + "'s puffy vagina so hard that your tip butts up against " + player2.mf("his","her") + " cervix, bowing it in towards " + player2.mf("his","her") + " unprotected womb.  " + player2.mf("He","She") + " squeezes down like a vice, wringing your cock with juicy, slippery walls.  You moan with " + player2.mf("him","her") + ", balls tensing, lifting slightly in your sack as they ready your juicy load.  Climactic bliss erupts from within and your flare nearly doubles in size, locking itself in the honeyed heaven it so loves to nestle itself into.  Bubbling heat builds inside until you feel as if your body is about to light aflame, and then, in a dizzying rush, you release the first sticky deposit into your lover's womb.  " + player2.mf("He","She") + " moans, wiggling happily as some slips into " + player2.mf("his","her") + " womb, while the rest begins to flood every nook and cranny of " + player2.mf("his","her") + " violated tunnel.");

	outputText("\n\nAgain and again, you fire sticky white loads deep into " + player2.short + "'s body, anchored tightly by the flaring horse-cock you used to hate, but have come to accept with " + player2.short + "'s help.  " + player2.mf("He","She") + " taught you that you could be loved, and as you thoroughly seed " + player2.mf("his","her") + " womb a teardrop of moisture beads at the corner of your eye.  " + player2.mf("He","She") + " loves you, cock and all, and there's nothing you'd rather be doing than spending the night with " + player2.mf("him","her") + ".  " + player2.mf("His","Her") + " belly rounds slightly");
	if (player2.pregnancyIncubation > 0 && player2.pregnancyIncubation < 150) outputText(" (more than it already is)");
	outputText(" from your prodigious deposit.  The illusion of knocking " + player2.mf("him","her") + " up takes hold of you, and your orgasm redoubles, fresh waves of horse-cum pouring out of you unceasingly.  " + player2.short + " moans, rubbing " + player2.mf("him","her") + " taut");
	if (player2.pregnancyIncubation > 0 && player2.pregnancyIncubation < 150) outputText(" pregnant");
	outputText(" dome, until at last you finally spend the last of your spunk.");

	//Hermaphrodite cums!
	if (player2.hasCock()) {
		outputText("\n\nYour lover suddenly achieves orgasm at last.  ")
		if (player2.cumQ() < 50) outputText("Ropes of seed shoot from " + player2.mf("his", "her") + " prick.  After a few shots of cum, " + player2.mf("his", "her") + " cock stops leaking at once.")
		else if (player2.cumQ() < 250) outputText("Thick ropes of seed shoot from " + player2.mf("his", "her") + " prick.  " + player2.mf("He", "She") + " definitely made a bit of mess. ")
		else if (player2.cumQ() < 1000) outputText("Thick ropes of seed shoot from " + player2.mf("his", "her") + " prick.  This continues for a while and eventually, " + player2.mf("he", "she") + " stops after " + player2.mf("he", "she") + " made a large puddle of cum.")
		else if (player2.cumQ() < 2500) outputText("Torrents of cum blast from " + player2.mf("his", "her") + " prick.  This continues for a while and eventually, " + player2.mf("he", "she") + " stops after " + player2.mf("he", "she") + " made a large puddle of cum.")
		else outputText("Torrents of cum blast from " + player2.mf("his", "her") + " prick.  This continues for a few minutes and eventually, " + player2.mf("he", "she") + " stops after " + player2.mf("he", "she") + " made a huge puddle of cum.")
	}
	outputText("\n\nYou lay down on " + player2.mf("his","her") + " back, exhausted, and " + player2.mf("he","she") + " rolls onto " + player2.mf("his","her") + " side, taking you with " + player2.mf("his","her") + ".  Snuggled together, genitals still locked and dripping, the two of your doze off together, whispering sweet nothings into the still, night air.");
	//Slimefeed!   Virgin removal + stretching silently
	player2.slimeFeed();
	if (player2.vaginas[0].virgin) {
		player2.vaginas[0].virgin = false;
		outputText("\n\n<b>You took " + player2.short + "'s virginity!</b>");
	}
	player.orgasm();
	dynStats("sen", -2);
	menu();
	addButton(0,"Next",morningAfterCampVisitEmbark, truth);
}

//Snuggle(C)*
private function snuggleWithUrta(truth:Boolean):void {
	clearOutput();
	outputText("You think it over and decide that, for once, you'd like to focus more on love and less on lust.  \"<i>Well... I'd really just like to have a snuggle with you, " + player2.short + " - if that's alright?</i>\"  You ask quietly, tail instinctively wagging in an effort to be endearing.  Your lover nods " + player2.mf("his","her") + " head and answers in the positive, opening " + player2.mf("his","her") + " arms for further effect.  You waste no time and eagerly sidle into " + player2.mf("his","her") + " arms.");
	//[If PC Centaur or Drider:
	if (player2.isTaur() || player2.isDrider()) {
		outputText("  It's rather awkward, thanks to " + player2.mf("his","her") + " clunky ");
		if (player2.isTaur()) outputText("centaur");
		else outputText("drider");
		outputText(" body, but you manage to press up against " + player2.mf("his","her") + " ");
		if (player2.isTaur()) outputText("forehoofs");
		else outputText("first two pairs of spidery limbs");
		outputText(".");
	}
	//[if PC Naga:]
	else if (player2.isNaga()) outputText("  " + player2.mf("His","Her") + " serpentine coils loop snugly around your waist, curling around your legs and holding you gently in place.");
	//[if PC Goo:
	else if (player.isGoo()) outputText("  " + player2.mf("His","Her") + " soft, squishy goo-body eagerly accepts you, the gelatinous mass of " + player2.mf("his","her") + " lower torso reaching out to softly envelop you in its cool, wet embrace.");
	//[Else:
	else outputText("  Knees to knees, it takes you a few moments to figure out how to properly position your legs, but you eventually manage it.");

	outputText("\n\nProperly positioned, you tuck your vulpine face into your lover's neck, softly inhaling " + player2.mf("his","her") + " scent, listening to the beating of " + player2.mf("his","her") + " heart, basking in the warmth of " + player2.mf("his","her") + " body and simply savoring being so close to the person you love.  Of course, being here like this, breasts pressed to your lover's chest, is all your traitorous horse-cock needs to show itself, wetly sliding from your sheath and poking eagerly into your lover's side.  You giggle nervously and blush, unable to help the flush of shame that slides through your heart, for all that " + player2.short + " has assured you that " + player2.mf("he","she") + " loves you despite your dick.");

	outputText("\n\nYour lover simply smiles at you, and gives your cock a ");
	if (player2.cor < 33) outputText("playful pat");
	else if (player2.cor < 66) outputText("gentle stroke");
	else outputText("lascivious caress");
	outputText(" before pulling you tighter into " + player2.mf("his","her") + " embrace.  Eager to forget your embarrassment, you focus on holding " + player2.mf("him","her") + " tight and close.  Your prick slowly slides back into its sheath from the lack of stimulus as you focus on how safe and content you feel to be here, being held like this.");

	outputText("\n\nTo your own surprise, you find your eyes growing heavier and heavier.  But you don't want to let your " + player2.short + " go yet... besides, may as well start searching from here in the morning, right?  So, you and " + player2.short + " carefully lay yourselves back down and quietly drift off to sleep, still holding fast to each other as you do.  The last sounds you hear for the night are your lover breathing, accompanied by the beating of " + player2.mf("his","her") + " heart, and you idly hope that " + player2.mf("he","she") + " can hear the same sounds from you...");
	dynStats("lus", 14);
	menu();
	addButton(0,"Next",morningAfterCampVisitEmbark, truth);
}
//Embark(C)*
private function morningAfterCampVisitEmbark(truth:Boolean):void {
	clearOutput();
	model.time.days++;
	statScreenRefresh();
	outputText("Sadly, morning comes, and your time with " + player2.short + " comes to an end.  You push " + player2.mf("his", "her") + " shoulder gently to rouse " + player2.mf("him", "her") + ", smiling at " + player2.mf("him", "her") + " when " + player2.mf("he", "she") + " wakes.  You kiss " + player2.mf("him", "her") + " on the lips before rolling out from under the blanket.  The two of you eat a quiet breakfast together, simply enjoying each other's company.  ");

	if (truth)
	{
		outputText("" + player2.mf("He", "She") + " asks again about coming with you, but you tell " + player2.mf("him", "her") + " Gul's instructions were quite specific.  You'll need to tackle this alone.  The rest of breakfast passes in uncomfortable silence, broken when you rise to leave.");
	}

	outputText("\n\nYou embrace " + player2.short + ", kissing " + player2.mf("him", "her") + " on the lips");

	if (truth)
	{
		outputText(" before you promise, \"<i> I'll come back to you, stronger and ready for kids, I promise.</i>\"\n\n");
	}
	else
	{
		outputText(".  ");
	}

	outputText(player2.short + " nods, and you leave " + player2.mf("him","her") + " behind.  You keep glancing over your shoulder as you leave, praying silently to any god who'll listen that you return safely to your lover.");

	menu();
	addButton(0,"Next",runIntoAGoblin,true);
}


//Goblin Encounter(C)*
//Intro(C)*
public function runIntoAGoblin(camped:Boolean = false):void {
	clearOutput();
	if (camped) {
		outputText("Holding the pendant in front of you, you set off in a random direction from the camp, hoping it will give you some kind of sign.  A couple times, you could swear it flickered with an inner light, but the passing luminance could just be a reflection of the omnipresent sun.  You wipe the sweat from your brow and turn around, a little confused as to how you should progress.");
	}
	else {
		outputText("You set out for Taoth's Temple - or grave, your only clue to its location being the pendant clasped tightly in your hand.  Behind you, the tower slowly shrinks, less imposing now that you've finished that step on your journey.   Ahead lies uncertainty and struggle.  You know you'll likely wind up fighting the corrupted denizens of the lost regions of Mareth in your travels, and it's likely at least a demon or two will get in your way.  Still, as you exit the city gates, you give your home a forlorn gaze.  Things are about to get a lot tougher.  You wish " + player2.short + " could be standing here with you, but this is a challenge you must face alone.");
		outputText("\n\nHolding the pendant in front of you, you set off in a random direction from the city, hoping it will give you some kind of sign.  A couple times, you could swear it flickered with an inner light, but the passing luminance could just be a reflection of the omnipresent sun.  You wipe the sweat from your brow and turn around, a little confused as to how you should progress.");
	}
	outputText("\n\n\"<i>Hey there lady-stud!  You look like you could use a hot cunt to fertilize a few times!</i>\" a reedy, high-pitched goblin voice calls.  Shit, one of those guttersluts.  They're almost as bad as demons.  Worst of all, you know they'll play to your basest, most well-concealed fetishes.  Just the idea of having one of them split on your cock, slowly ballooning with seed and loving it...  well, if you're being honest with yourself, it makes you stiffen a little.  You turn around to face the curvy little preg-hungry whore, and as soon as you see her, you realize she's not going to go away until she's had a ride on your dick or been subdued.");
	outputText("\n\n<b>It's a fight!</b>");
	startCombat(new GoblinBroodmother());// TODO extract to Monsters.GoblinBroodMother class
}


//Urta Wins(C)*
public function winFuckAGoblinBroodmotherAsUrta():void {
	clearOutput();
	outputText("You greedily eye the ");
	if (monster.HP < 1) outputText("submissive");
	else outputText("feverishly masturbating");
	outputText(" form of your opponent and can't resist licking your black lips in anticipation - any guilt about fucking someone besides " + player2.short + " that might make it through the haze of lust consuming you is quickly extinguished by your conviction that " + player2.mf("he","she") + " would understand.  Your growing tower of fuck-meat is already lifting the hem of your armored skirt, making it even easier to grab its lower edge and flip it up out of the way as you advance towards your assailant, eager to see what you can do about blowing off some steam...");

	outputText("\n\nThe saffron-skinned slut sees your advance and has the audacity to smirk at you.  \"<i>If you wanted to be on top, sexy, all you had to do was say so,</i>\" she giggles.  Without further ado she flops onto her bountiful ass, her jiggling booty easily absorbing the impact, and then lays back, doing her best to smirk at you as she lewdly spreads her netherlips with her fingers, letting you fully admire her elastic cunt.");

	outputText("\n\nYou smirk back, but don't deign it worth the effort to inform her that you have no interest in fucking her nasty, stretched out sluthole.  No, you have your eyes fixed on a different prize... a set of breasts that make Edryn look like she hasn't even hit puberty yet.  You sashay over, each sway of your hips waving your dick from side to side and attracting the goblin's eager eyes; she stares at it as if hypnotised.  With a smirk, you kneel down on the ground at the goblin's feet and begin to stroke her stretched, freakishly elastic labia with your fingers, leaning in and getting a whiff of her musky depths... mmm; not as if you particularly need it, but that's just what it takes to really get your cock growing.");

	outputText("\n\n\"<i>Hmm... that feels nice, but quit teasing me and let me catch a ride on that big pony of yours,</i>\" the goblin MILF says, licking her lips and beginning to pant.");

	outputText("\n\nYou push your hardening horse-cock against her muff, probing her wet slit.  \"<i>Atta girl!</i>\"  The goblin moans.  You smile mischievously, getting a perfect idea of what to do next in order to piss off the goblin slut.  You quickly pull away and straddle her, pressing her generous tits together and shoving your equine-prick between them, fucking them slowly as you smirk at the goblin whore.");

	outputText("\n\n\"<i>H-Hey!  You can't tease me and... and... hmm... that smells kinda nice,</i>\" she comments, eyes fixated on your pumping dick.  She licks her lips demurely, trying to bring your shaft closer so she can suck on it.  You smirk at her wanton eagerness and teasingly begin to slide yourself deeper into the canyon of her mighty cleavage, bringing the as-yet unflared tip almost close enough for her to kiss before pulling it back out again, sliding it through her increasingly pre-slicked boobs.");

	outputText("\n\n\"<i>Hey!  Come on, it's not nice to tease and not gimme any of that tasty dick of yours.  I wanna drink!</i>\"  The goblin teases, intent on getting you to give her a taste.  You just shake your head, grinning, getting off as much on your teasing her as on the feel of her warm, slick, soft breasts surrounding your dick.  Not pleased with your teasing, the goblin MILF stretches her limbs and grabs at your balls, rolling them in her hands.  \"<i>C'mon, foxy!  Bust those nuts already!</i>\"  She pants with barely contained lust.");

	outputText("\n\nYou moan at the sudden pressure on your swollen nuts, the head of your cock already starting to flare out.  You don't have the luxury of teasing any longer; instead, on your next thrust, you butt the cock-tip squarely into the goblin's slutty mouth (she's wearing bright pink lipstick, you notice somehow), trying to forcibly stuff it inside before it flares too wide for her to fit.");

	outputText("\n\nThe goblin slut eagerly opens her mouth, accepting your thrusting shaft into her mouth and sucking sharply as you push past her pink lips, moaning appreciatively at the taste of your shaft and redoubling her efforts at massaging your balls.  Her head bobs with your thrusts, trying to get you deeper and deeper, an idea you find hard to resist.  Your flare grows larger and rounder with each thrust, until it swells so big that you no longer have any hope of pulling it out of the goblin's stretched jaws - if it pains her to have her mouth so full, she doesn't show it.  All the while, she fondles and squeezes and massages your balls like a maestro playing an instrument...");

	outputText("\n\n\"<i>Oh, gods... c-cumming!</i>\"  You squeal, bucking your hips forward as your balls tighten and clench up into your crotch, your cunt soaking the goblin's fingers and legs with female juices as the familiar fire blazes a trail up your arm-length dick and erupts into your slut's mouth.  Plugged as it is, she has no choice but to swallow, and swallow, and swallow; you can feel her belly starting to distend from the sheer volume of your load as you force-feed it to her.");

	outputText("\n\nOnce you're done, she pulls away from your shaft, gasping for breath.  She licks her lips, a goofy smile on her face.  \"<i>That sure hit the spot!  How about filling my muff next?  I need to make myself a new batch of daughters!</i>\"  The goblin grins, licking her pink lips.");

	outputText("\n\nYou chuckle and lift yourself up off of your victim, swaying a little unsteadily and letting your skirt fall back over your cock.  \"<i>Not a lot of point getting me to cram your cunt, then; I'm sterile.</i>\"");

	outputText("\n\nThe goblin stares up at you dumbly.  \"<i>...what?</i>\"  She asks in a flat, disbelieving tone.");

	outputText("\n\n\"<i>I shoot nothing but blanks and nobody can fix that.</i>\"  You taunt the goblin, deliberately not mentioning that there is a cure and that's what you're after; you want to make kits with " + player2.short + ", not more green sluts.  You turn and start walking away as the goblin stares after you, dumbfounded.  \"<i>You- you - bitch!  You - </i>\" A loud belch cuts into her ranting, but by the time she's recovered, you're too far away to hear any more.");

	outputText("\n\nStupid goblin.  This whole fight was pointless.  Now that she's defeated, you focus on following the trinket again; you've got to find that shrine.");
	player.orgasm();
	menu();
	addButton(0,"Next",nagaPleaseNagaStoleMyDick);
}

//Urta Loses(C)*
public function urtaLosesToGoblin():void {
	clearOutput();
	//Urta bad end, written by Kinathis... Buckle up for the worst writing you have ever seen!....Okay lets do this! Raaaaa!!! o-o What did i get myself into...
    //Loss by lust intro(C)*
	if (player.lust >= player.maxLust()) {
		outputText("Your aching body buckles under the goblin's lusty assault.  As if the constant flow of precum that soaks your skirt isn't enough, your raw desire for the goblin's curvy little body explodes from you.  The iron-hard pole of animalistic breeding meat throbs powerfully as it stands tall against your otherwise feminine body, lifting your protective skirt and making it gather up around your waist.  Unable to stop yourself, your hands grab hold of the aching, arm-sized length of horseflesh as you sink to your knees.  Without missing a beat, your hands stroke and squeeze your fat equine endowment with feverish need.  Almost instantly, your over-productive organ soaks your squeezing hands in streams of thick, musky pre; clear, sticky rivulets that drip all the way down to your aching, pulsating balls.  Your huge, sterile, stallion-nuts swell and bloat with their massive load.  The poor things ache to be unleashed inside your assailant's cum-craving womb.");
		outputText("\n\nGiggling impishly, the pregnancy-obsessed seductress sashays her way over to you.  The voluptuous woman looks at your masturbating form for a moment, admiring your well endowed body before making her move.  Shoving you down, she pulls your face into her bountiful bosom, nearly suffocating you in sweet, soft titflesh as she grinds her curvy little body against you.  \"<i>Ohhh... look at that big beast you have there.  You're going to love feeling my tight little puss wraped around your stallion-cock, aren't you?  Just look at those huge balls - I think I found myself a keeper.  Now, don't you worry about anything, dear.  Just lay back and let me milk all the sperm from those big, round cum-dispensers of yours,</i>\" the kid-crazy woman says before she pulls a few red vials from her bags and forces them against your lips, massaging your throat to make sure you swallow every drop.");
		outputText("\n\nYou were pretty horny before, but after these doses there's only one thought you're capable of processing: the searing desire to rut and breed.  As soon as that bubbling concoction hits your stomach a throaty groan tears itself from your dark lips.  The chemical aphrodisiac surges right to your brain and over-aroused equine erection.  Your already iron-hard horseflesh seems to swell even bigger from your newfound arousal; the bloated, blunt crown belching forth a thick, musky bolt of sticky pre all up the dominant goblin's back.  Feeling your hot, thick juice shoot across her flesh only seems to make her more hungry for you.  If you can pump out pre-cum like that, just what kind of flood are you going to make when you really cum?");

		outputText("\n\nBiting her lip, the busty little wench looks you up and down before grinning.  She's clearly thinking up something devious, but you're too wrapped up in your own aching, burning need to rut and breed to stop her.  Reaching into her bag once more, she retrieves a few colored glass vials, pops the cork, and pours their contents into your panting mouth, making you drink them.  \"<i> That's it... drink up like a good little husband should, and get ready to spunk your beautiful wife's hot, tight cunt and give her all the horny girls you can,</i>\" she says, giggling in excitement.  The curvy, cock-hungry beauty has no idea that she's not going to get babies of any kind from your sterile seed.");
	}
	//connect to goblin dom]
    //Loss by physical intro(c)*
	else {
		outputText("Beaten and broken, you collapse to the ground, humiliation flooding through you from the shame of your pathetic defeat.  How could the captain of the guard lose to such a weak, horny little slut?  Groaning at your bruises, you try to stand and fight once more in an attempt to regain some measure of dignity.  Unfortunately for you, your baby-craving enemy doesn't give you a chance to recover.  Pouncing on you with devilish intent, the goblin woman shoves you down, sitting on top of your ample chest.  She pins your weakened body down and smothers your face between her huge, soft love pillows.  The mere feeling of being pressed against such a tender, round and full bust calls your cursed cock to attention.  Your rebellious stallion-hood tents your leather skirt and shows the cock-hungry woman just how well-hung you are...");

		outputText("\n\nThe brusty, yellow-skinned woman reaches into the pouches on her belts and pulls out several vials filled with a roiling red liquid.  The others look to be filled with a murky fluid, like a liquid fog but clearly made for something more than merely inducing lust.  Prying your mouth open, she grins and pours the contents of two red vials inside.  Closing your mouth, she massages your throat even as you struggle futilely against the reflex to swallow.  \"<i>That's it, drink down all that nice lust-juice of mine.  I could smell the cock on you the moment I laid eyes on ya.  I just know you've got a big one hiding down there, and I'm going to get me some of that hot horsecock.  Now, be a good girl and give me all the nice creamy cum in those big balls of yours,</i>\" she says before licking her lips.");

		outputText("\n\nOpening your mouth, you intend to bite back with a rebellious retort, but the only sounds that come from your lips are the lusty moans and pants of your drug-induced arousal.  The combination of the potent potion, soft, supple, curvy flesh pressing against you, and a willing hungry cunt just begging for your cock is too much.  With a thunk, the thick, armored leather falls around your waist as the aching length of your arm-like stallion frees itself from the confining 'stables' that housed it.  The bloated, blunt crown belches forth a musky bolt of sticky pre all up the dominant goblin's back.  Feeling your hot, viscous juice shoot across her flesh only seems to make her more hungry for you.  If you can pump out precum like that, just what kind of flood are you going to make when you really cum?  \"<i> Ohhhh...I hit the jackpot with you...  I'm not going to let any of those loose, green whores get at such a fabulous stud like you.</i>\"");

		outputText("\n\nBiting her lip, the busty little wench looks you up and down before grinning.  She's clearly thinking up something devious, but you're too wrapped up in your own aching, burning need to rut and breed to stop her.  Reaching into her bag once more, she retrieves a few colored glass vials, pops the corks, and begins, pouring the contents into your panting mouth, forcing you to drink them.  \"<i>That's it... drink up like a good husband, and get ready to spunk your beautiful wife's hot little cunt and give her all the horny little girls you can!</i>\" she says before giggling in excitement.  The curvy, cock-hungry beauty has no idea that she's not going to get babies of any kind from your sterile seed.");
	}
	//[goblin dom?](c)
	outputText("\n\nLicking her lips in anticipation, the victorious yellow slut takes her prize.  Pushing you down a little more, she turns away from you, locking her sights on the aching spear between your legs.  The goblin leans towards your massive shaft and plants a firm, hungry kiss right on the blunt tip.  The cock-craving, plump, almost bimbo-like lips press against your hot, hard flesh like a gentle pair of pillows.  Her flexible tongue snakes out from between those puffy lips to lick a thick dollop of pre from your sterile tower of equine pleasure.  The long green organ licks all over the flare of your crown, its eager yellow owner more than happy to pleasure and worship the colossal cum cannon of her future 'husband.'  \"<i> Mmmm, I'm going to make you scream and cum so hard.  You're never going to want another pussy as long as I'm around.  Just be a good husband and fuck me pregnant every day,</i>\" she says in between licks.");

	outputText("\n\nDespite your loss at the hands of... 'your' goblin, you can't... don't want to fight.  With each passing second, the pleasure and drugs mix with the impassioned words the goblin utters, filling your mind, wearing away any resistance you have left.  Laying back against the ground, you let your tongue loll free from your lips, and you release a breathy moan into the air.  The sweet, soft feeling of those massive, milky mammaries surrounding your dick only makes the tender worship feel even better for you.");

	outputText("\n\nGasping and groaning under the gold-skinned woman's expert skills, you can do little but pant while she displays her complete, masterful knowledge of oral pleasure.  Eagerly licking every thick dollop of murky lube off your equine endowments, your lover joins you in pleasure, taking sweet delight in paying tribute to such a well endowed herm like yourself.  Leaning back and looking at you, your... beloved... grins at you, the fire of burning arousal smoldering in her bright red eyes.  \"<i> Are you ready, darling?  Are you ready to be a good lover and stuff my nice, tight pussy with your big, bad stallion here?</i>\" she asks, giving your bloated member a squeeze to emphasize her lusty words.  You look up at the voluptuous, sulfur-skinned beauty as she pleasures your aching length with misty eyes.");

	outputText("\n\nYour drug-hazed mind fills with her words and is easily overwhelmed with thoughts of your sexy wife bucking and riding your massive, mustang manhood.  Just the fantasy of her screaming in ecstasy as you stuff her womb, impregnating your darling love, forces another inch of your dick inside her and bloats your balls even more.  \"<i>S-stop teasing me, honey.  I want to feel your perfect pussy so badly,</i>\" you say as your hands slide over her curvy hips and perfectly round ass.  You can't help but feel lucky to have a beautiful wife like her.  You're so drugged up with the goblin's special brew that the idea that something might be wrong about this never enters your mind; all you can think of is how you want to plow your lover's cunt and breed her womb full of slutty daughters.");

	outputText("\n\nGiggling at your submission to her mind-altering cocktail, the happy, horny slut crawls over you, giving you a long, deep tongue-filled kiss.  Her golden hands grope and squeeze your tits while her silky, soft feet caress and stroke your aching pillar of horseflesh.  The lusty goblin pinches your coal-black nipples, each already as hard as the mineral itself, ripping a cry of pain and pleasure from your body.  Everything she does just drives you wild with need for your sexy wife.  Reaching into her pouches, she grabs another colored vial.  Popping the cork, she empties it into her own mouth before kissing you again, letting the tangy, mind numbing juice run into your eager maw.  Swallowing down every drop, you go so far as to slip your tongue into her mouth to lick up every bit you can get.");

	outputText("\n\nPulling back with a wet smack, your lover grins and giggles as she slowly jacks you off with her feet.  \"<i>Ohhhh, what a good husband you are, so eager to show your wife how much you love her and want to screw her womb full of babies.  I think I'm going to keep you around permanently,</i>\" she says before giving you one last peck on the lips.  Shifting her position, the beautiful, saffron-skinned goblin stands over your swollen, cunt-conquering cock.  Her soft, soaking snatch has turned a tender golden color from how hot and engorged she is.  In your drug addled mind, you can't think of a more perfect hole then hers.  Looking back at you, her eyes catch yours, sparkling with delight as she slides her hands over her curvaceous body.  She spanks her round rump and slips down even lower.  Unable and unwilling to look away, you watch with baited breath as your smoking-hot wife teases and rubs the broad, flat tip of your bloated prick against her dripping entrance, slathering her needy flower in your musky pre.  With a lick of her lips, she digs her delicate fingers into her hot little box and spreads her tight, slippery lips wide as she slowly slides her squeezing, fleshy walls around you.");

	outputText("\n\nLetting out a long drawn out moan of spine tingling pleasure, your darling wife slips down lower and lower over your proud, throbbing steed.  Bucking your hips up, you can't help but join her in moaning at the sensation of that hot, tight cunt wrapping around your girthy cunt-stretcher.  How lucky you are to have such a tight, rubbery snatch to pleasure you!  Your beautiful wife's perfect pussy isn't going to be getting loose anytime soon, either.  Reaching up, you grab her hips and pull your lover down your fat length.  The horny slut lets loose a scream of pure pleasure as you pack her box full of throbbing virility.  The sudden penetration surprises the matronly goblin and makes her squeeze down like a silken vice around you, her slippery, cum-hungry walls working and milking every inch of your aching horseflesh.  Rolling her wide, motherly hips back and forth, your beloved wife takes inch after inch of your stallion with expert ease, feeling deliciously slippery and almost virginally tight round you.  With a wife like this, you dare say you could fuck this hot, sexy little thing forever.");

	outputText("\n\nDespite her obvious experience, the feeling of being so full and rubbing her round ass against your flared furry hips is almost too much for your lover.  The full length of your distended, arm-like horsecock fills her small, squeezing snatch perfectly, fitting like a glove around the beastly member as if they were made for each other.  Not even moving, just feeling that great, bitch-taming spear buried right to the hilt and pumping her pussy full of slick, musky pre nearly brings your sweet bride to orgasm.  \"<i> Ffffffuuuck...  I'm d-definitely keeping you all to myself...  By Marae's sweet tits, you feel good in there.  Uuunnn.... now be a g-good husband and spunk my womb full of your g-glorious seed,</i>\" she demands as she grinds her hips and ass against yours.  The golden-skinned slut reaches down and, taking hold of your massive, bloated sack in her small hands, gently massages the backed-up nuts as her hot little cunt squeezes down around you.");

	outputText("\n\nThe desire and compulsion to fuck your perfect little lover full of babies drives you wild.  Unable to hold yourself back, you reach up and push your wife to the ground, pinning her under your body.  Despite intending to ride you and make you hers, the eye crossing pleasure of being fucked into the dirt by such a deliciously pleasurable prick is just too good for her to pass up.  \"<i>Y-Yessssss... f-fuck your wife's perfect pussy!  Plow me, screw me, and do me proud; give me all your slutty little babies like the good husband you are.</i>\"  The words from your 'wife' fill your mind, dominating your thoughts with desire.  The rampant need to fuck and rut her hot little body builds inside you until she screams your name and milks every last drop of horsey spunk from your bloated balls.");

	outputText("\n\nGripping her shoulders hard, you lean over her smaller form and finally start to pull and thrust into your love, ramming your iron-hard beast through her pussy into her hungry womb.  Grunting hard, you buck and ram your hips against her soft, plush ass, massive balls swinging back and forth like a pair of wrecking balls as you wreck this slut's cunt, ruining it for any other dick.  Grunting and groaning in mind numbing pleasure, you batter your sweet wife's body and stretch her tender, squeezing snatch around you like a glove of quivering velvet.  Reaching down, you slide your hands under the massive pillow-like breasts of your saffron-skinned lover and squeeze hard.  Slipping your fingers around and gripping her hard, engorged nipples like a pair of milky handholds, such huge teats could easily feed dozens of hungry little goblins.");

	outputText("\n\nGetting right into it, you lose what's left of your rational thoughts in the act of rampant sex.  The only desire in your drugged out, horny and hypnotized mind is to fuck and breed your beautiful goblin wife pregnant over and over.  The fact that your sterile seed won't do anything but bloat her belly with useless spooge never crosses your mind.  Gritting your teeth, you feverishly pound your arm-like stallion cock into her hot, green depths.  Burning arousal fills both your bodies, forcing you closer and closer to your first massive orgasm.  Letting out a shriek of pleasure, your lovely wife beats you to it.  Consumed with eye-crossing ecstasy, she claws at the ground as her stretched cunt clenches around you so tightly you can't pull out even an inch to make another thrust.  With your massive, musky member locked firmly within the vice-like grip of your beloved's welcoming body she lets out a pained groan of ever growing desire, and you discover that you don't have any need to move.  The sweltering, slippery goblin pussy spasming around you gives you all the sensual stimulation you need to finally reach your earth-shattering orgasm.");

	outputText("\n\nGrinding your hips against the sweet softness of your lover's ripe, round rump, you nearly scream yourself, letting out a strangled cry as you get lost in the nirvana of her sweet, perfect body.  Your massive, bloated balls clench and lurch powerfully as you let loose a backed up flood of horsey-fox cream.  Blasting gout after gout of thick, useless spunk into her quivering form, you quickly bloat her belly under your unstopping flow of sperm.  With each clench of your mighty testicles, you pack ever more baby batter into the eager slut's lusty womb, ballooning her stomach until she looks pregnant with at least a dozen little green bitches.  Beneath you, your darling little wife looks more like a mind-broken fucktoy, totally lost in the endless pleasure of getting spunked so full and having such a perfect cock-mare as her personal inseminator.");

	outputText("\n\nEven though your bodies finally start to calm down, the cum hungry matron is not nearly done with you. Bucking her wide hips against you, she shoves you back, fully intending to ride you this time and wring every last drop from those over-productive balls of yours.");

	player.orgasm();
	//[next]
	menu();
	addButton(0,"Next",loseToGoblinsPartIIAsUrta);
}

private function loseToGoblinsPartIIAsUrta():void {
	clearOutput();
	outputText("<b>Hours, and many orgasms later...</b>");
	outputText("\nSitting there before your pouting angry wife, you watch as she paces back and forth in front of you.  After having learned of your sterility, she was none too pleased with you.  She's clearly disappointed that her virile stud was shooting blanks and all that thick, creamy cum was just for show.  \"<i>So let me get this straight; you're completely sterile, but you know where you have to go to get your virility back,</i>\" she mutters as she looks at you, hands on her wide, childbearing hips, great globs of spent horse-spunk still dripping from between her legs.");
	outputText("\n\nNodding your head, you can't help but feel shame that you can't get your beautiful wife pregnant and give her all the daughters she wants.  \"<i>I think so. Getting this... curse lifted from me will give me my fertility and virility back,</i>\" you say, not remembering too much about it, but you know for sure where to go. The thought of getting back your precious virility and finally knocking up your sexy little gobby is too tempting; you have to get your quest completed!");

	outputText("\n\nGrumbling in annoyance, the goldenrod goblin pouts and thinks.  It would be such a bother to go on this quest with you.  On the other hand, if it were completed, she would have an eager, willing and very virile stud to call her own, and you DO make for a very pleasurable lover.  Plus, with you already being completely enthralled by her hypnosis, you would be more than happy to never leave her side and stay as her private breeding bull.  Sighing to herself, your angel of a lover resigns herself to your quest, figuring that it's worth it to get you fertile.  \"<i>All right, get up.  You and me are going to complete this quest of yours.  You better be a good, grateful husband and stay with me when it's over.  I expect you to fuck me pregnant well over a dozen times to make up for this!</i>\" she declares before grabbing another vial of that potent love-drug from her pouches and popping the cork.  \"<i>Now, come here and get your medicine,</i>\" the buttercup goblin says sweetly while she crooks a finger at you and pours the contents of her vial into her own mouth.  More than eager to make out with your dear, sweet bride again, you jump clean off the ground and nearly pounce on her.  Grabbing up the curvaceous woman in your arms, you kiss her hard and passionately, happily drinking up your tangy, sweet drink as she kisses you back.");

	outputText("\n\nWhen you finally let go of her, the goblin is blushing wildly, clearly not intending to get so wrapped up in making out with you.  \"<i>W-well... let's get moving shall we, but first...</i>\" Pulling a collar out from one of her pouches, she clasps it around your neck and tugs on the attached leash to lead you along.");
	//[Next]
	menu();
	addButton(0,"Next",loseToGoblinsPartIIIAsUrta);
}

private function loseToGoblinsPartIIIAsUrta():void {
	clearOutput();
	outputText("<b>Several days later...</b>");

	outputText("\nIt had been a hard journey, fighting your way through nagas, gnolls, tentacle monsters, minotaurs and even demons.  Each fight was harder than the last, but with enough motivation from your faithful, darling wife, you achieve your much desired goal.  After each lusty battle, the short, curvaceous woman helped relieve your pressure, and after each passionate session with her, you just grew more in love with your busty, goblin wife.  Each time she seemed to scream and writhe atop your insatiable prick more than she did the time before.  Your after sex make out sessions grew more heated and passionate, as if the lovely, saffron-skinned woman couldn't get enough from you.  Each day she seemed to grow more annoyed yet more tender and needy toward you.");

	outputText("\n\nAfter the many fights, many fucks, and lusty nights, it was done.  Your quest to rid yourself of the trickster spirit was completed.  The spirit took hold of you so that you could make him a new body.  He told you to breed, to fuck a new body into your darling for him, and she was more than happy to be the recipient of your newly empowered seed.  The sex had been hard, rough, and full of nothing but the need to breed.  The god's new form had grown fast - it grew within your beloved's belly in a matter of moments before being birthed.  To your surprise, the god-child grew in its chosen form, spindly and fox-like in appearance, merely telling you the deed was done before leaving on its business.");

	outputText("\n\nWith the god gone, it's just you and your goblin lover.  The golden-skinned woman already grins in anticipation of what's to come.  Without waiting a minute, she grabs you and yanks you away from this creepy place, leading you to a more secluded area before pulling you into a deep, tongue filled kiss.  \"<i>I've waited so long for this - get out of those clothes right now.  I can't wait to make a big batch of daughters with you,</i>\" she says before unbuckling the belts holding back her massive breasts.  The huge I-Cup orbs spill forth like a mass of yellow Jell-O.  \"<i>Get over here and fuck your perfect, fertile little wife full of slutty little goblins right now!</i>\" she demands as she presses her curvy body against yours.  Just thinking of plowing and knocking up your wife's hot, sodden cunt is enough to bring you to full attention, your newly invigorated stallion more than ready to fill her belly with more daughters than she could ever want...");

	//[next]
	menu();
	addButton(0,"Next",loseToGoblinsPartIVAsUrta);
}


private function loseToGoblinsPartIVAsUrta():void {
	clearOutput();
	outputText("<b>Several hours later...</b>");
	outputText("\nSweaty, plastered in cum, and laying in a puddle of spent horsy-foxy seed, you hold onto the curvy spunk-stuffed body of your voluptuous, goblin wife.  The saffron-skinned woman lets out soft pleasured coos as she clings to you.  The poor stuffed girl completely fucked herself out after the seemingly endless sexfest. In the heat of your passionate romp, your lover starts another round of slow, sensuous cock worship, slowly stroking and licking every inch of your musky stallion and huge, breeder balls.  The soaking-wet girl sucks and stimulates your aching, well-fucked stallion-prick. Your fat bloated beast stays sandwiched between her mountainous mammaries until you cum for what very well could have been the fifth or sixth time.  Even after so many messy, sperm-squirting orgasms, you still unleash a veritable torrent of spunk so thick it paints your lover's body pure white with your new virility.  With her so drenched in sweat and cum it's hard to see the goblin underneath, but you know your faithful, loving wife doesn't mind.  In fact, it seems that getting drenched in your spunk just turns her on even more.");

	outputText("\n\nWiping a great, thick glob from her face, your buttercup goblin snuggles her cum-stuffed belly against yours before smiling at you, her hands sliding around you before planting a kiss on your lips.  \"<i>Mmmm... I love you, my wonderful virile stud,</i>\" she purrs to you before reaching down to fondle your rising mustang once again.  Despite her dubious intentions and having brainwashed you, it seems you found the love and acceptance you always wanted.  No doubt you will be the father of a great many daughters in the months to come.   If only you could remember your old lover's name...");
	flags[kFLAGS.URTA_GOBLIN_SLAVE] = 1;
	menu();
	addButton(0,"Next",urtaGameOver);
}

private function urtaGameOver():void {
	clearOutput();
	outputText("<b>Urta has been lost to her fate...  Meanwhile, back at camp...</b>");
	getGame().inCombat = false;
	flags[kFLAGS.URTA_QUEST_STATUS] = -1;
	model.time.days++;
	resetToPC();
	model.time.hours = 6;
	statScreenRefresh();
	doNext(camp.returnToCampUseOneHour);
}


//Urta's Attacks
//Can she use any magic at all?  I doubt it!
//I'll be assuming there is no real limit to how many specials she can have. No need to go overboard anyways.
//Normal attacks would be using normal text!  No need to custom these.
//Tease

//Having custom tease Attacks would be awesome!  So just putting this here as a possibility.
//By the way, how many variations would be good?

//Special Attacks

//Some attacks being dependant upon her having the Halberd and some not using it at all would make sense, since she can be disarmed.
//For now these are just ideas, once approved they'd need to be fleshed out.
//PC could perhaps use some of these with proper training, maybe Urta would teach them some moves?

//1-2 round stun, 1-2 round blind, throat punch (2-3 round silence?)
//Side Winder: 70% damage + stun chance
//Vault: 250% damage vs stunned
//Combo: 3x attack, guaranteed hit vs blind
//Dirt Kick: Blind 1-3 rounds
//Metabolize: Convert HP into fatigue
//Second Wind: Regain 50% HP and lose 50 lust.  Once per fight.

public function urtaSpecials():void {
//Gone	menuLoc = 3;
	if (getGame().inCombat && player.findStatusEffect(StatusEffects.Sealed) >= 0 && player.statusEffectv2(StatusEffects.Sealed) == 5) {
		clearOutput();
		outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
		monster.doAI();
		return;
	}
	menu();
	addButton(0, "Combo", urtaComboAttack, null, null, null, "Make a three-hit combo.  Each attack has an extra 33% chance to miss, unless the target is blind. \n\nFatigue cost: 25");
	addButton(1, "Vault", urtaVaultAttack, null, null, null, "Make a vaulting attack for an extra 25% damage.  Automatically crits stunned foes. \n\nFatigue cost: 20");
	addButton(2, "Sidewinder", urtaSidewinder, null, null, null, "An attack that hits for reduced damage but has a high chance of stunning. \n\nFatigue cost: 10");
	addButton(3, "Dirt Kick", urtaDirtKick, null, null, null, "Attempt to blind your foe with a spray of kicked dirt. \n\nFatigue cost: 5");
	addButton(4, "Metabolize", urtaMetabolize, null, null, null, "Convert 10% of your maximum HP into fatigue.");
	addButton(5, "SecondWind", urtaSecondWind, null, null, null, "Regain 50% of your HP, 50 fatigue, and reduce lust by 50 once per fight.", "Second Wind");
	addButton(14, "Back", combat.combatMenu, false);
}

private function urtaMetabolize():void {
	clearOutput();
	var damage:int = player.takeDamage(Math.round(player.maxHP()/10));
	outputText("You work your body as hard as you can, restoring your fatigue at the cost of health. (" + damage + ")\nRestored 20 fatigue!\n\n");
	player.changeFatigue(-20);
	monster.doAI();
}

private function urtaSecondWind():void {
	clearOutput();
	if (monster.findStatusEffect(StatusEffects.UrtaSecondWinded) >= 0) {
		outputText("You've already pushed yourself as hard as you can!");
//Gone		menuLoc = 3;
//		doNext(getGame().combatMenu);
		menu();
		addButton(0, "Next", combat.combatMenu, false);
		return;
	}
	monster.createStatusEffect(StatusEffects.UrtaSecondWinded,0,0,0,0);
	HPChange(Math.round(player.maxHP()/2),false);
	player.changeFatigue(-50);
	dynStats("lus", -50);
	outputText("Closing your eyes for a moment, you focus all of your willpower on pushing yourself to your absolute limits, forcing your lusts down and drawing on reserves of energy you didn't know you had!\n\n");
	monster.doAI();
}

//Combo: 3x attack, higher miss chance, guaranteed hit vs blind
private function urtaComboAttack():void {
	if (player.findStatusEffect(StatusEffects.Attacks) < 0) {
		clearOutput();
		if (player.fatigue + 25 > player.maxFatigue()) {
			outputText("You are too fatigued to use that attack!");
//Gone			menuLoc = 3;
//			doNext(getGame().combatMenu);
			menu();
			addButton(0, "Next", combat.combatMenu, false);
			return;
		}
		player.changeFatigue(25);
	}
	if (player.findStatusEffect(StatusEffects.Attacks) < 0)
		player.createStatusEffect(StatusEffects.Attacks,3,0,0,0);
	else {
		player.addStatusValue(StatusEffects.Attacks,1,-1);
		trace("DECREMENDED ATTACKS");
		if (player.statusEffectv1(StatusEffects.Attacks) <= 1) {
			trace("REMOVED ATTACKS");
			player.removeStatusEffect(StatusEffects.Attacks);
		}
	}
	//Blind
	if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
		outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
	}
	var damage:Number;
	//Determine if dodged!
	if (monster.findStatusEffect(StatusEffects.Blind) < 0 && (rand(3) == 0 || (player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4) +80)) > 80))) {
		if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
		if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
		if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
		outputText("\n", false);
		if (player.findStatusEffect(StatusEffects.Attacks) >= 0) {
			urtaComboAttack();
			return;
		}
		else {
			outputText("\n", false);
			monster.doAI();
			return;
		}
	}
	//Determine damage
	/*Determine damage - str modified by enemy toughness!
	if (player.hasPerk("Double Attack") >= 0 && player.str <= 60) {
		if (player.weaponName == "deadly spear") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou));
		else if (player.weaponName == "jeweled rapier") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou));
		else if (player.weaponName == "katana") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou + monster.armorDef - 5));
		else damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou + monster.armorDef));
	}*/
	//Basic damage stuff
	damage = player.str;
	//Weapon addition!
	damage += player.weaponAttack;
	//Determine if critical hit!
	var crit:Boolean = false;
	if (rand(100) <= 4 || (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50 && (player.inte - 50)/5 > rand(100))) {
		crit = true;
		damage *= 2;
	}
	//Start figuring enemy damage resistance
	var reduction:Number = rand(monster.tou);
	//Add in enemy armor if needed
	if (player.weaponName != "jeweled rapier" && player.weaponName != "deadly spear") {
		reduction += monster.armorDef;
		//Remove half armor for lunging strikes
		if (player.findPerk(PerkLib.LungingAttacks) >= 0)
			reduction -= monster.armorDef/2;
	}
	//Take 5 off enemy armor for katana
	if (player.weaponName == "katana") {
		//Knock off 5
		if (monster.armorDef >= 5) reduction -= 5;
		//Less than 5 armor?  TAKE IT ALL!
		else reduction -= monster.armorDef;
	}
	//Apply AND DONE!
	damage -= reduction;
	//Damage post processing!
	//Thunderous Strikes
	if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80)
		damage *= 1.2;
	//One final round
	damage = Math.round(damage);

	if (damage > 0) {
		if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
		damage = combat.doDamage(damage);
	}
	if (damage <= 0) {
		damage = 0;
		outputText("Your attacks are deflected or blocked by " + monster.a + monster.short + ".", false);
	}
	else {
		outputText("You hit " + monster.a + monster.short + "! (" + damage + ")", false);
		if (crit) outputText(" <b>*CRIT*</b>");
	}
	if (player.findPerk(PerkLib.BrutalBlows) >= 0 && player.str > 75) {
		if (monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage " + monster.a + monster.short + "'s defenses!");
		if (monster.armorDef - 10 > 0) monster.armorDef -= 10;
		else monster.armorDef = 0;
	}
	outputText("\n", false);
	//Kick back to main if no damage occured!
	if (monster.HP >= 1 && monster.lust <= 99) {
		if (player.findStatusEffect(StatusEffects.Attacks) >= 0) {
			trace("MORE ATTACK");
			urtaComboAttack();
			return;
		}
		trace("DONE ATTACK");
		outputText("\n", false);
		monster.doAI();
	}
	else {
		if (monster.HP <= 0) doNext(combat.endHpVictory);
		else doNext(combat.endLustVictory);
	}
}

//Dirt Kick
private function urtaDirtKick():void {
	clearOutput();
	if (player.fatigue + 5 > player.maxFatigue()) {
		outputText("You are too fatigued to use that ability!");
//Gone		menuLoc = 3;
//		doNext(getGame().combatMenu);
		menu();
		addButton(0, "Next", combat.combatMenu, false);
		return;
	}
	player.changeFatigue(5);
	//Blind
	if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
		outputText("You attempt to dirt kick, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
	}
	else outputText("Spinning about, you drag your footpaw through the dirt, kicking a wave of debris towards " + monster.a + monster.short + "!  ");
	//Dodged!
	if (rand(20) + 1 + monster.spe/20 > 15 + player.spe/20) {
		outputText(monster.mf("He","She") + " manages to shield " + monster.mf("his","her") + " eyes.  Damn!\n\n");
		monster.doAI();
		return;
	}
	else if (monster.findStatusEffect(StatusEffects.Blind) >= 0) {
		outputText(monster.mf("He","She") + "'s already blinded.  What a waste.\n\n");
	}
	else {
		outputText(monster.mf("He","She") + "'s blinded!\n\n");
		monster.createStatusEffect(StatusEffects.Blind,2 + rand(3),0,0,0);
	}
	monster.doAI();
}

//SideWinder: 70% damage + stun chance
private function urtaSidewinder():void {
	clearOutput();
	if (player.fatigue + 10 > player.maxFatigue()) {
		outputText("You are too fatigued to use that attack!");
//Gone		menuLoc = 3;
//		doNext(getGame().combatMenu);
		menu();
		addButton(0, "Next", combat.combatMenu, false);
		return;
	}
	player.changeFatigue(10);
	//Blind
	if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
		outputText("You attempt to hit with a vicious blow to the side, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
	}
	else outputText("You make a wide swing to the side, hoping to stun your foe!  ");
	var damage:Number;
	//Determine if dodged!
	if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4) +80)) > 80)) {
		if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
		if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
		if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
		outputText("\n\n", false);
		monster.doAI();
		return;
	}
	//Determine damage
	/*Determine damage - str modified by enemy toughness!
	if (player.hasPerk("Double Attack") >= 0 && player.str <= 60) {
		if (player.weaponName == "deadly spear") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou));
		else if (player.weaponName == "jeweled rapier") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou));
		else if (player.weaponName == "katana") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou + monster.armorDef - 5));
		else damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou + monster.armorDef));
	}*/
	//Basic damage stuff
	damage = player.str;
	//Weapon addition!
	damage += player.weaponAttack;
	//70% crappier than normal attack.
	damage *= .7;
	//Determine if critical hit!
	var crit:Boolean = false;
	if (rand(100) <= 4 || (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50 && (player.inte - 50)/5 > rand(100))) {
		crit = true;
		damage *= 1.75;
	}
	//Start figuring enemy damage resistance
	var reduction:Number = rand(monster.tou);
	//Add in enemy armor if needed
	if (player.weaponName != "jeweled rapier" && player.weaponName != "deadly spear") {
		reduction += monster.armorDef;
		//Remove half armor for lunging strikes
		if (player.findPerk(PerkLib.LungingAttacks) >= 0)
			reduction -= monster.armorDef/2;
	}
	//Take 5 off enemy armor for katana
	if (player.weaponName == "katana") {
		//Knock off 5
		if (monster.armorDef >= 5) reduction -= 5;
		//Less than 5 armor?  TAKE IT ALL!
		else reduction -= monster.armorDef;
	}
	//Apply AND DONE!
	damage -= reduction;
	//Damage post processing!
	//Thunderous Strikes
	if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80)
		damage *= 1.2;
	//One final round
	damage = Math.round(damage);

	if (damage > 0) {
		if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
		damage = combat.doDamage(damage);
	}
	if (damage <= 0) {
		damage = 0;
		outputText("Your attacks are deflected or blocked by " + monster.a + monster.short + ".", false);
	}
	else {
		outputText("You hit " + monster.a + monster.short + "! (" + damage + ")", false);
		if (crit) outputText(" <b>*CRIT*</b>");
	}
	if (player.findPerk(PerkLib.BrutalBlows) >= 0 && player.str > 75) {
		if (monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage " + monster.a + monster.short + "'s defenses!");
		if (monster.armorDef - 10 > 0) monster.armorDef -= 10;
		else monster.armorDef = 0;
	}
	if (monster.findStatusEffect(StatusEffects.Stunned) < 0 && monster.findPerk(PerkLib.Resolute) < 0 && damage > 0) {
		if (monster.tou/10 + rand(20) + 1 < 20) {
			outputText("\n<b>" + monster.capitalA + monster.short + " is stunned!</b>");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}
	}
	else if (monster.findPerk(PerkLib.Resolute) >= 0) {
		outputText("\nWhile it should have some chance of stunning, your foe seems far too resolute to be affected by such an ailment.");
	}
	outputText("\n", false);
	//Kick back to main if no damage occured!
	if (monster.HP >= 1 && monster.lust <= 99) {
		if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
			combat.attack();
			return;
		}
		outputText("\n", false);
		monster.doAI();
	}
	else {
		if (monster.HP <= 0) doNext(combat.endHpVictory);
		else doNext(combat.endLustVictory);
	}
}


//Vault: Use the halberd to support her weight and deliver a high power kick to the enemy, deals 15% more damage. If the enemy is stunned, auto-critical. This is like the move she uses during the fight against the wolf in that scene at Tel'Adre.
private function urtaVaultAttack():void {
	clearOutput();
	if (player.fatigue + 20 > player.maxFatigue()) {
		outputText("You are too fatigued to use that attack!");
//Gone		menuLoc = 3;
//		doNext(getGame().combatMenu);
		menu();
		addButton(0, "Next", combat.combatMenu, false);
		return;
	}
	player.changeFatigue(20);
	if (player.findStatusEffect(StatusEffects.Sealed) >= 0 && player.statusEffectv2(StatusEffects.Sealed) == 0) {
		outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  The seals have made normal attack impossible!  Maybe you could try something else?\n\n", false);
		monster.doAI();
		return;
	}
	//Blind
	if (player.findStatusEffect(StatusEffects.Blind) >= 0) {
		outputText("You attempt to make a high, vaulting attack, but as blinded as you are right now, you doubt you'll have much luck!  ", false);
	}
	else outputText("You leap into the air, intent on slamming your " + player.weaponName + " into your foe!  ");
	var damage:Number;
	//Determine if dodged!
	if ((player.findStatusEffect(StatusEffects.Blind) >= 0 && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4) +80)) > 80)) {
		if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
		if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
		if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
		outputText("\n", false);
		if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
			combat.attack();
			return;
		}
		else outputText("\n", false);
		monster.doAI();
		return;
	}
	//Determine damage
	/*Determine damage - str modified by enemy toughness!
	if (player.hasPerk("Double Attack") >= 0 && player.str <= 60) {
		if (player.weaponName == "deadly spear") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou));
		else if (player.weaponName == "jeweled rapier") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou));
		else if (player.weaponName == "katana") damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou + monster.armorDef - 5));
		else damage = int((player.str + player.weaponAttack) - Math.random()*(monster.tou + monster.armorDef));
	}*/
	//Basic damage stuff
	damage = player.str;
	//Weapon addition!
	damage += player.weaponAttack;
	//25% better than normal attack.
	damage *= 1.25;
	//Determine if critical hit!
	var crit:Boolean = false;
	if (monster.findStatusEffect(StatusEffects.Stunned) >= 0 || rand(100) <= 4 || (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50 && (player.inte - 50)/5 > rand(100))) {
		crit = true;
		damage *= 2;
	}
	//Start figuring enemy damage resistance
	var reduction:Number = rand(monster.tou);
	//Add in enemy armor if needed
	if (player.weaponName != "jeweled rapier" && player.weaponName != "deadly spear") {
		reduction += monster.armorDef;
		//Remove half armor for lunging strikes
		if (player.findPerk(PerkLib.LungingAttacks) >= 0)
			reduction -= monster.armorDef/2;
	}
	//Take 5 off enemy armor for katana
	if (player.weaponName == "katana") {
		//Knock off 5
		if (monster.armorDef >= 5) reduction -= 5;
		//Less than 5 armor?  TAKE IT ALL!
		else reduction -= monster.armorDef;
	}
	//Apply AND DONE!
	damage -= reduction;
	//Damage post processing!
	//Thunderous Strikes
	if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80)
		damage *= 1.2;
	//One final round
	damage = Math.round(damage);

	if (damage > 0) {
		if (player.findPerk(PerkLib.HistoryFighter) >= 0) damage *= 1.1;
		damage = combat.doDamage(damage);
	}
	if (damage <= 0) {
		damage = 0;
		outputText("Your attacks are deflected or blocked by " + monster.a + monster.short + ".", false);
	}
	else {
		outputText("You hit " + monster.a + monster.short + "! (" + damage + ")", false);
		if (crit) outputText(" <b>*CRIT*</b>");
	}
	if (player.findPerk(PerkLib.BrutalBlows) >= 0 && player.str > 75) {
		if (monster.armorDef > 0) outputText("\nYour hits are so brutal that you damage " + monster.a + monster.short + "'s defenses!");
		if (monster.armorDef - 10 > 0) monster.armorDef -= 10;
		else monster.armorDef = 0;
	}
	outputText("\n", false);
	//Kick back to main if no damage occured!
	if (monster.HP >= 1 && monster.lust <= 99) {
		if (player.findStatusEffect(StatusEffects.FirstAttack) >= 0) {
			combat.attack();
			return;
		}
		outputText("\n", false);
		monster.doAI();
	}
	else {
		if (monster.HP <= 0) doNext(combat.endHpVictory);
		else doNext(combat.endLustVictory);
	}
}



//Male Naga Encounter
//Has a hypno lust raising attack.
//Immune to tease, focuses on eyes so much that he doesn't notice poses.
public function nagaPleaseNagaStoleMyDick():void {
	clearOutput();
	//Encounter Intro
	outputText("You pick your way through the forest, intent on following the vague directions the talisman gives you... sheesh, this is like the children's game of hotter-colder you used to see the other kids playing when you were a little kit.  You push irritably through a dense cluster of brush; the damn thing would lead you off the beaten path, now wouldn't it?");

	outputText("\n\nWhile making your way past a particularly resistant bush you suddenly step on something leathery.  A masculine voice yells and you feel movement under your foot; whatever you just stepped on suddenly whips out from under you with enough strength to pull you off balance, making you fall on your ass with a loud \"<i>whuf!</i>\" of shock.");

	outputText("\n\n\"<i>How dare you!  Worthlesss whelp... how dare you ssstep on my tail!</i>\"  Hisses the naga, angrily, glaring at you.  You wince apologetically.  \"<i>Oh, I'm sorry sir, I couldn't see you in all these bushes and things - I was just trying to get through,</i>\" you tell him, hoping to avoid a confrontation.  After all, the fact that he hasn't jumped at you to try and rape you means he's probably not that corrupt.  Then again, that doesn't necessarily mean he's not an asshole, either...");

	outputText("\n\nHe take a glance at you, and smiles evilly as soon as he realizes you're a woman.  \"<i>Oh, sssuch a pretty foxy lady... it hasss been so long since I had a female keep me company... I'll forgive you for your transgression if you become my concubine.</i>\"");

	outputText("\n\n\"<i>Uh... that's flattering and all, Mr...?</i>\"");

	outputText("\n\n\"<i>Sssiriusss...</i>\"  The naga hisses, still ogling your face and tits - and, thankfully, managing to miss your less than female horse-dick, somehow.");

	outputText("\n\n\"<i>Sirius.  But I'm already with someone, quite happy with " + player2.mf("him","her") + ", and not looking for anyone else.  Besides, I'm only passing through and I have places to go yet,</i>\" you say, trying to be polite but firm; you'd be less than flattered by the attention even if you didn't have a painful history of guys asking you out, then changing their minds upon seeing your stallion-king-sized manhood.");

	outputText("\n\n\"<i>You invade my territory... ssstep on my tail... and have the gall to tell me you're not going to make up for it!</i>\"  He hisses ominously.  \"<i>Hey, it was an acci-</i>\"  \"<i>Worthlesss female!  You are mine!</i>\"  He charges at you!");

	outputText("\n\n<b>It's a fight!</b>");
	kGAMECLASS.combat.clearStatuses(false);
	startCombat(new Sirius());
}

//Tease*

//Poison Bite*

//Poison Spit*
//Blinds for 3 turns.

//Urta Wins*
public function urtaBeatsUpSiriusRadio():void {
	//Beaten via Lust:
	if (monster.lust >= 99) outputText("The naga's hands begin pumping his erect prick as his eyes grow hazier and hazier, the lids slowly sliding shut across them.  He arches his back and lets a cry of defiance and pleasure as he explosively splurts cum onto the ground at your feet, then quietly collapses onto his own coils, murmuring softly.  You wait, but it looks like he's fallen asleep... sheesh.");
	//Beaten via HP:
	else outputText("Your latest blow lands with a crunch on his jaw and he collapses bodily onto the ground at your feet, clearly out cold.");

	outputText("\n\nYou take a deep breath, cursing your rotten luck for running into this guy.  You consider just leaving him there at the mercy of whatever creature happens to find him next, but on the other hand, perhaps you could make use of the naga to relieve your own lust... he's out cold now, so you wouldn't have to worry about his hypnotic gaze.");

	//[Rape][Leave]
	menu();
	addButton(0,"Fuck Him",urtaWinFucksSirius);
	addButton(1,"Leave",leaveSiriusBehind);
}

//[=Leave=]
private function leaveSiriusBehind():void {
	clearOutput();
	outputText("You decide that he's just not worth your time and leave to continue your journey.");
	menu();
	addButton(0,"Next",gnollAlphaBitchIntro);
}

//[=Rape=]
private function urtaWinFucksSirius():void {
	clearOutput();
	outputText("You carefully remove your clothes and place them aside, then start to examine the naga's body, looking to see the possibilities for getting off.  Not particularly liking the idea of using his tailtip as a dildo, and given that he's unconscious you can hardly expect him to give you oral, you instead make your way to his groin.  There, his penis is retracted inside a strangely vaginal-like slit.  Great.  Is there anything you can actually do with this jerk?");

	outputText("\n\nYou scratch your head in thought, not realizing the tail slowly circling your legs.  Maybe you should just jerk off on the jerk and get going...  \"<i>Gotcha!</i>\"  Sirius screams, springing up and tightly wrapping your body in his coils.  You shriek in surprise, instinctively dropping your halberd to try and prise off the steely loops of scaly muscle wrapping themselves around your limbs and torso, but your attempts are in vain.");

	outputText("\n\nHe grasps the sides of your head and looks you straight into your eyes.  \"<i>You're mine now.  Listen to my voice... feel my voice... obey my voice... let my voice caresss you... let my eyes take you.</i>\"  You struggle and buck, trying to fight your way out of the coils and to remove your head from his hands, but it's so hard... his eyes are captivating, like they're reaching into the depths of your soul... no!  Fight it, Urta - you have to fight it!");

	outputText("\n\nThe naga laughs at your struggle.  \"<i>Sssuch a feisty one... I do love women like you.</i>\"  He leers at you.  \"<i>Ssstruggle my dear.  The more you ssstrugle the hotter you will get.  Ssso unbearably hot... like you're in heat.  Fuck, cock, cum and heat.  Can you feel my wordsss?  Of course you can.</i>\"  He smiles at you, his tongue caressing the fur on your cheek.");

	outputText("\n\nYou struggle to resist, but you have to confess to yourself that he's right; the harder you try to deny his words, the deeper they resonate within you.  Your loins are on fire... oh, you want to fuck this handsome snake-man so much; you need his cock filling your cunt, quenching the flames burning inside your steaming wet pussy, you want his sweet mouth wrapped around your flare and drinking the cum from your throbbing, overstuffed balls...  You stop trying to fight his coils off and instead hug his handsome face to your furry breasts, grinding your pebbly nipples on his cheeks so he can feel how ready you are to fuck.");

	outputText("\n\nHe extracts himself from your breasts laughing.  \"<i>Yesss, come to me, foxy.  Let me just loosen up so I can get to your presciousss treasure.</i>\"  You feel his coils slowly loosen and hump him experimentally, bumping against soft, yielding flesh.  \"<i>W-What is thisss?</i>\"  He says in confusion, loosening enough to look downwards and notice your hefty package.  He nearly jumps out of his skin, falling on his back and releasing you completely.  \"<i>W-What the hell are you!?  When did thisss get there!?</i>\"  He asks, bewildered, pointing at your erect horse-prick.");

	outputText("\n\nYou sashay towards your lover, hips waving from side to side, swaying your cock before him.  \"<i>I'm just a girl with a little extra, sexy; don't worry, we don't bite... unless you want us to...</i>\"  You flirtatiously lick your lips for emphasis, letting him see a gleaming tooth.");

	outputText("\n\nHe crawls on his back, trying to get away from you.  \"<i>W-What are you doing?  Get away!  I command you!  Look into my eyes and stop this instant!</i>\"  He yells in desperation.");

	outputText("\n\nYou feel a pang of curiosity at why your sexy snake is asking you to stop, but he's obviously just teasing you.  You lunge at him and grab hold of him as tightly as you can, pressing his head firmly into your breasts.  Your free hand slides sensuously down his hip to play with the groinal slit and you can't resist a girlish giggle.  \"<i>Why are you so worked up, baby?  Sure, I'm a girl with a dick, but you're a guy with a pussy.</i>\"");

	outputText("\n\nHe tries to protest, but your breasts effectively muffle him.  After much struggling, he finally manages to extract himself from your furry mounds, gasping for air.  \"<i>That's not a pussy!  By Marae, I'm all man!  That's where I keep my cock, so don't even think abo - URK!</i>\"  You silence him by pulling him back into your cleavage.  \"<i>Now, now, lover, time to be quiet.  Just let your sexy dickgirl handle that sweet, tight pussy of yours.</i>\"  You chastise your lover, even as you slip a finger inside his pussy to see what it's like... ooh, so tight and slick!  You really wanna stuff him full now!");

	outputText("\n\nYou wriggle around, trying to line your parts up properly whilst keeping your shy lover properly muffled and contained in your arms, but finally you're able to start pressing your cock into his tight little boy-pussy.  The snake man tenses up in your grasp, gasps and screams, half in pleasure and half in pain at your sudden penetration, his tight slit not able to fit a cock that size.  \"<i>Ooh, a virgin, are we?  Don't worry, lover; my balls make a lot of lube.  I'll stretch you out, so just hang in there,</i>\" you assure him. You push and grind, humping eagerly; you've got to stretch him out so you can really fit inside of him... by Marae's bountiful breasts, he's so tight!");

	outputText("\n\n\"<i>Getitout, getitout, getit- AH!</i>\"  He yells.");

	outputText("\n\n\"<i>Oh, stop whining, it'll feel good any time if you'll just loosen up!</i>\"  You snap.  Honestly, this is what he wanted, isn't it?  Though you have to admit, as you continue to fuck him as hard as his tight little slit will let you, he's not getting any looser.  Indeed, he seems to be getting tighter and shallower with every thrust of your hips!  Also... \"<i>Hey, what's that poking against my dick?</i>\"  You ask him.");

	outputText("\n\n\"<i>W-What do you think!?  ARGH!</i>\"  He asks, trying to show some sarcasm as you continue plumbing his tight little slit.  You pull your flaring cock out of his slit and watch with a little smirk on your face as a strange, purple-colored bumpy dick suddenly shoots out, dripping with a mixture of your pre and his.  \"<i>Aw... now I can't fuck that hole any more.</i>\"");

	outputText("\n\nSirius breathes a sigh of relief.  \"<i>Thank Marae it'sss over.</i>\"  He lets his tongue loll out the side of his mouth.");

	outputText("\n\n\"<i>Not quite, sexy... if I can't use that hole, I'll just have to use this one instead.</i>\"  You purr, tapping him playfully on the cheek and running a thumb across his lips to let him know which hole you're talking about.");

	outputText("\n\n\"<i>What do you mean?</i>\"  He asks, panting.");

	outputText("\n\n\"<i>Say ahh, sexy...</i>\"  You purr, already lining your cock up with his mouth... oh, you hope your flare isn't too big for him to fit it in!");

	outputText("\n\n\"<i>What are y- GAH!</i>\"  You immediately thrust your cock into the naga's open mouth, pushing with all your strength... oh!  He's stretchy!  You find, to your delighted amazement, that his throat just seems to open up to accept you, easily enveloping your cock until he's hilted you and his nose is buried in the fur at the base of your belly, his chin bumping into your balls.");

	outputText("\n\nSirius struggles at first, grasping at your hips, but he doesn't make a move to stop you... not that it would have helped anyway.  You're determined to get your release by any means necessary.  You thrust your cock back and forth, sliding it down the warm, wet depths of his throat.  \"<i>Oh, you are such a good cock-sucker, lover.</i>\"  You tell him, moaning again as his throat ripples around your shaft, globs of precum surging into his waiting belly.");

	outputText("\n\n\"<i>Mmmmf!</i>\" Is all that you can hear coming out of Sirius' mouth.  You feel small droplets of wetness against your tail, and when you look back, you notice his cock is spewing gobs of pre-cum with almost as much intensity as your own equine-dong.  \"<i>Oh-ho...  my sexy little snake loves his throat being stuffed full of cock, doesn't he?  But I wouldn't expect anything less from such a - sexy!  Sexy!  <b>Snake!</b></i>\"  You thrust your cock into his mouth with each word for emphasis, then let out a howl as your balls clench up and that delicious warmth floods through your prick, liquid love-cream gushing into the naga's thirsty belly in spurt after glorious splurt.");

	outputText("\n\nSirius gurgles as you flood his throat with your spunk; it's amazing how he hasn't choked on your cock despite the fact that you never quit humping his face... no doubt that's due to his natural elasticity... something you've come to appreciate very much!  You moan and grunt as you finally finish your climax, then slowly pull your cock out of your lover's mouth, splattering the naga's face with one final gobbet of cum.");

	outputText("\n\nYou shake your head, feeling kind of dizzy, but good... also, still kind of horny.  Wow, he looks really cute with his face splashed with semen... and his belly starting to bulge from the load you shot down his throat...  That's so... hot...  Your cock starts to harden up again, anticipating your intentions.  Funny... you vaguely remember needing to do something... something besides fucking this sexy snake here.  Eh, it can wait; round two, coming up!");

	outputText("\n\nSirius coughs pathetically, spitting a small gob of seed in the process.  Then he licks his lips and looks up, only to meet your hungry stare.  \"<i>Why are you looking at me like that?  No... oh nononononono... Wa - GH!</i>\"  You cram his mouth full again, already humping his face as if your life depends on it... mmm, his throat feels so good wrapped around your cock...");
	dynStats("lus=", player.maxLust(), "resisted", false);
	//Next Page button to trigger scene finish
	menu();
	addButton(0,"Next",fuckSiriusRadioII);
}
private function fuckSiriusRadioII():void {
	clearOutput();
	outputText("\"<i>Oof... ugh... just... just one more... yeah!</i>\"  You gasp, moan, and shudder as your cock explodes yet again in your lover's mouth.  The snake-man is sprawled on the ground, supporting a belly like a centauress full-term with twins, and doesn't stir as you finally go limp and pull out of his mouth, drooling cum all over his face.");

	outputText("\n\n\"<i>Ugh... I'm totally spent.  Sheesh, how long were we fucking?  I can't remember the last time I was that horny... come to think of it, why were we fucking?  I've got " + player2.short + " waiting for me back home - why was I getting a blowjob from some random stranger?</i>\"  You wonder; your head feels kind of fuzzy, but now it's clearing up.  You shake it, trying to get your thoughts straight.  You must have really been pent up, though; just look at the evidence.  Trying to be polite, you address the naga.");

	outputText("\n\n\"<i>You know, I thought you were a real jerk, but... if you were willing to help me get all this tension out of me, you mustn't be such a bad guy after all.  I wish I could remember how or why you offered to give me head, though...</i>\"");

	outputText("\n\nThe only response you get is a snore and a gurgling wet belch; he's out cold.  You can't resist chuckling to yourself; he might have been nicer than you thought, but he's no " + player2.short + ".  He just can't keep up with you.  You give the sleeping naga an affectionate pat on the cheek as a thank you, wipe the resultant cum-smear off of your hand onto the grass, get redressed, and leave.");

	outputText("\n\nAs you walk away, following the pendant once again, you hope that " + player2.short + " will understand why you fucked a stranger like that... maybe if you promise to give " + player2.mf("him","her") + " oral with as much enthusiasm as that naga gave you, " + player2.mf("he","she") + "'ll be more understanding?  Mmm... you kind of hope " + player2.mf("he","she") + " agrees, actually; you can already taste " + player2.mf("him","her") + " on your tongue...");
	player.orgasm();
	menu();
	addButton(0,"Next",gnollAlphaBitchIntro);
}

//Urta Loses*
public function urtaLosesToSirriusSnakeRadio():void {
	clearOutput();
	flags[kFLAGS.URTA_BECOMES_SNAKE_SLAVE] = 1;
	//Loss by HP:
	if (player.HP < 1) outputText("You cry out in pain as the bruises and buffets you've taken overwhelm you.  You struggle to stay upright, but to no avail; your injured body has reached its limits and you collapse, helpless and at the mercy of your assailant.");
	//Loss by Lust:
	else outputText("With a hollow moan of anguish, you cast aside your halberd and fall to your knees, tears stinging your eyes as you desperately jerk and maul at your huge horse-prick.  The cursed thing has betrayed you again, and now you're too addled by lust and need to defend yourself from whatever this naga has in store for you.");

	outputText("\n\nSirius examines your prone form.  \"<i>Wait a moment... what the hell isss that!?  I thought you were a woman!</i>\"  He yells, pointing at your horse-cock.  \"<i>I am!  I just have something extra, that's all!</i>\"  You protest.  It's bad enough he beat you, does he have to rub your stallionhood in your face like everyone else?");

	outputText("\n\nHe takes another glance at you, examining your curves.  \"<i>Come here.</i>\"  He wraps you in his coils, holding you tightly and then licks your cheek with his bi-parted tongue.  \"<i>Definitely tastesss female... I sssuppose you are girl enough, then,</i>\" he remarks.");

	outputText("\n\n\"<i>Gee, thanks,</i>\" you retort sarcastically; like that really makes up for the insult... not to mention, he's going to rape you!");

	outputText("\n\n\"<i>Now then, my pretty vixen.  I'm willing to look past this rather prominent fault of yoursss and make you mine, what do you say, hmm?</i>\"  \"<i>I'm already spoken for, creep, and I wouldn't want you if you were the last guy on Mareth!</i>\"  You spit, thrashing around in an effort to escape his coils.");

	outputText("\n\nHe grabs the sides of your head, holding your eyes open as he gazes deeply into them.  \"<i>Now, now... don't be like that, my prettiest.  Don't you remember how horny you were when you first set eyes on me?  All those yearsss ago?  How you vowed to live your life by my ssside?  As my lover?</i>\"  What nonsense is he talking about?  You've never met him before now!  Though... you have to admit, you do feel horny, your cock dripping precum and your gash already growing wet.");

	outputText("\n\n\"<i>You're resilient... that isss lovely.  I do ssso love ssstrong women.  I love breaking them and teaching them their placesss in thisss world.</i>\"  He glares at your eyes with even more intensity.  \"<i>Do not worry thisss little head of yoursss with trivial thingsss.  Instead focus on your lust, how horny you are, how hot you are, how much you want release.  Tell me, do you want cock?  Do you want a nice, big cock between your legsss?  Quenching your lust?</i>\"");

	outputText("\n\nYou bite your lip to repress a moan at the heat wafting through you.  He's right.  You do want a cock between your legs, or a nice wet pussy around  your own cock - you want sex sooo badly... but this asshole's not getting to fuck you!  No way!");

	outputText("\n\n\"<i>Ssso, how about I help you with your need?  What do you think of me, huh?</i>\"  \"<i>You're an ugly belly-dragging freak with stupid eyes who should just crawl back under a rock!</i>\"  You spit at him... oh, you want a cock in your cunt so badly, but you'll die before you let this asshole have you.");

	outputText("\n\nHe chuckles.  \"<i>My dear, I think you don't understand the situation.  You sssee... you don't realize how much you need cock... you don't just need it.  You want it, you desire it, you wish for cock, you're desperate for some dick.  Isn't that right?</i>\"  You swallow hard as the sheer burning need floods through you.  \"<i>It's true, dammit, it's true; I need a cock in me, and I need it now!</i>\"  You pant desperately, gasping in air to try and cool yourself down.");

	outputText("\n\n\"<i>Yesss... why, it wouldn't be wrong to say that you live for cock, right now, would it?</i>\"  \"<i>Yes... yes, you're right, I do live for cock,</i>\" you growl, still panting and wriggling in unrelenting lust.  \"<i>Yesss... and did you know that I have cock?  A hard cock just aching to get inside you?</i>\"");

	outputText("\n\nYou moan in desperation, wetness dripping between your legs from your mismatched sexes.  If he's got cock, then you have to have it - you don't care who he is anymore!  \"<i>Gimme that cock!  I fucking need it!</i>\" you scream.");

	outputText("\n\n\"<i>Of course you do... and since you live for cock, and I have cock, it wouldn't be wrong to say that you live for me right?  Since you love cock so much... you must love me too, don't you agree?  Do you see your mistake now?</i>\"");

	outputText("\n\nAs his words sink into your ears, realization comes... he is right.  He was right all along.  How could you be so stupid?  How could you seriously believe you didn't love him - that you hated him?  \"<i>I'm so sorry, Sirius - you're so wise, your words are true.  I do love you - I do live for you,</i>\" you vow to your beloved naga.");

	outputText("\n\n\"<i>More than cock?</i>\" he asks tentatively.  \"<i>Of course I love you more than cock... besides, you have all the cock I will ever need, so how can I not love you more than cock?</i>\" you ask, puzzled by the question.");

	outputText("\n\nHe chuckles at your words.  \"<i>Yesss, you are right.  Sssorry for my confusion.  As an apology, you may request anything you want from me.</i>\"  \"<i>You don't need to apologise to me, you silly, sexy snake, you,</i>\" you reply with a smile.  \"<i>You shouldn't be so confused about my love for you... but, if you really want to apologise to me... will you fuck me?  My pussy's sooo hot and wet and empty; it aches for you.  Please, ravage your silly fox with your glorious cock,</i>\" you beg him.");

	outputText("\n\n\"<i>Of course my dearest, just relax and let me give you all the cock you want.  And while I do that... I want you to look deeply into my eyesss and see how much I love you... how much you need me... how my cock feels ssso good inside you, that nothing besides your love for me and my cock mattersss.  I want you to sssee and know that I love you most of all... and that all you are... all of you, even with your faultsss, belongs to me... and in exchange I will give you cock... enslave you with my dick,  and you will be happy... because you love me... and my cock is bliss.</i>\"");

	outputText("\n\n\"<i>Yes, yes, oh, yes... Sirius, I will do anything you say; I love you so much, and I love your cock so much... oh, it's all true, you and it are all that matter to me,</i>\" you reply, rapturously gazing into the infinite yellow pools that are your beloved's eyes.");

	outputText("\n\n\"<i>Good.  Then ssstrip,</i>\" he orders, slacking his coils to allow you movement.  Unthinkingly, you start pulling your clothes up over your head, never breaking your gazing into his beautiful eyes, then cast them aside before allowing yourself to go limp and be supported in his strong coils.");

	outputText("\n\nSirius wastes no time, positioning you at an angle in his wonderful coils and easily finding your slit behind your balls.  Then he penetrates you and you cry out in bliss, never blinking or breaking your gaze.  Oh, yes!  Yes, yes - he's such a wonderful lover, so masterful, so strong... his cock fills you so well, brings you such pleasure!  So good... something so good could only come from " + player2.short + "!  Wait a moment?  " + player2.short + "?  That sounds wrong!  You meant Sirius!  Your love!");

	outputText("\n\nSirius suddenly stops.  \"<i>What's the problem, my dear?  Sssomething happen?  I felt your mind wander a moment ago...</i>\"  He wonders.  \"<i>It's nothing, my love, just a stray thought... don't know where it came from...</i>\"  You admit, honestly baffled.  \"<i>Ah, of course.  You're so cute my pretty fox... ssso airheaded to let your mind drift during our lovemaking... tell you what.  Let's play a game, yesss?</i>\"");

	outputText("\n\n\"<i>Okay, my love - and thank you for being so understanding.</i>\"  You reply, nodding your head in agreement.  A game sounds fun.");

	outputText("\n\n\"<i>I will fuck you, and every time I penetrate you, you will scream how much you love me, and love me more.  Focusss on that feeling, and when you cum... you will lose yourself in bliss... my bliss... and your will shall be drained and replaced with devotion for me, for my cock, for my cum.  And when you feel yourself fill with my cum, you will surrender to me.  And I will become your one true master.  How does that sound?</i>\"");

	outputText("\n\n\"<i>Sounds fun, but what about you?  Those rules are bit one-sided towards you, don't you think?</i>\"  You say with a playful tone, smiling smugly at catching your lover out like this.");

	outputText("\n\n\"<i>Isn't that the way you like it, dear?  Me being in complete control?  Besidesss, it's a fair trade... and the rulesss are fair, too.</i>\"  He smiles.  \"<i>I will give you cock, and you will give me your freedom.  What could be more fair than that?  Especially for you who needs and loves cock so much.</i>\"");

	outputText("\n\n\"<i>I love you more, you know... but, yes, cock is good.  All right, I accept your rules.</i>\"");

	outputText("\n\n\"<i>Excellent!</i>\"  He replies joyfully.  You do love seeing him happy.  Sirius resumes his fucking, pumping into you with renewed vigor.  You can't help but scream your love for him with each pump, feeling yourself nearing the edge of orgasm.  By Marae, how you love this wonderful snake-man that's come into your life.  You dare say that your chest could explode with your love.  And your pussy... it won't take long for it to explode with your bliss.  That wonderful cock of his... Sirius' cock, fucking you so deliciously full... touching you in all the right places... it's a dream come true.");

	outputText("\n\nWith a groan, Sirius tightens his hold on you, hugging you tightly and bringing those deep pools of gold that have completely mesmerized you with their beauty ever closer.  For an instant you feel everything go blank, pleasure, pain, everything.  Your mind goes completely blank... as if in shock... but when you feel the liquid love filling your womb you know it... you brought Sirius, your one true love, to orgasm.  A cock... a delightful cock, belonging to your love is filling you with the seed you crave so much... and before you know it, you realize you're also cumming, spraying Sirius' belly with your fox-jism and milking his cock for more of his cum, and you surrender.  You surrender to bliss... you surrender to love.");

	outputText("\n\nSirius pants above you, smiling possessively at you.  \"<i>Oh, you are just so wonderful, Sirius... I love you so much,</i>\" you say as you kiss him.  The naga's smile widens.  \"<i>I love you too, especially this wonderful pussy of yours... and my cock loves you too.</i>\"  \"<i>Well, your cock better love me, because I'm going to milk it dry every. Single. Chance. I. Get.</i>\"  You tell him, staring adoringly into his eyes and tapping him emphatically on the chest with your finger with each word.   \"<i>Of course you will - you love cock.</i>\"  You nod your head.  \"<i>Yes, that's right - I love you and I love cock.</i>\"");

	outputText("\n\nHe pulls out of you, letting his cum leak from your used love-hole.  \"<i>Tell me how much you love me,</i>\" he says, smiling.  \"<i>I love you so much that if my love was cum I would drown the world in it, Sirius.  And I love your cock almost as much,</i>\" you reply, beaming blissfully at him.");

	outputText("\n\nHe chuckles and taps you on the nose.  \"<i>My dear foxy... aren't you forgetting sssomething?</i>\"  You blink and look at him, your puzzlement obvious on your face.  \"<i>Remember our little trade?  My cock for everything that you are?</i>\"  \"<i>Yes, I remember that,</i>\" you reply.  \"<i>So how should you be referring to me?</i>\"  You furrow your brow in confusion. \"<i>Something like my love?  Dearest?</i>\"  You suggest.  He chuckles,  \"<i>That too, but you're missing the point.</i>\"  You stare into his eyes, confused and looking for answers that you are sure will come to you if you merely look long enough.  Finally, blissfully, realisation dawns; you gave up your freedom for his love, so that means he is your master.  \"<i>Master, I love you so much, your cock is so wonderful, and I'm so happy to have you - who needs freedom when they can have you?</i>\"");

	outputText("\n\nHe chuckles.  \"<i>Yesss, I told you it wasss a fair trade... your freedom for my cock, because?</i>\"  He asks, waiting for your answer.   \"<i>I love cock!</i>\"  You scream in your joy at answering the question right.");

	outputText("\n\nSirius claps at your declaration.  It feels good to be praised by your master and one true love.  \"<i>Come now, my love ssslave.  Let's go home.</i>\"  \"<i>I just love the way you call me ssslave,</i>\" you giggle, trying to imitate his hissing accent, even as you try to retrieve your clothes and weapon. Sirius takes notice and quickly interrupts you.  \"<i>Leave that trash there.  You don't need it anymore.  Besidesss you look much better naked.</i>\"  You blush at his flattering.  \"<i>You too, master.</i>\"  You reply.");

	outputText("\n\nYou dutifully follow your master... as happy as you could be.");

	menu();
	addButton(0,"Next",siriusSatelliteRadioOwnsYouII);
}

private function siriusSatelliteRadioOwnsYouII():void {
	clearOutput();
	outputText("You yawn loudly as you wake up, stretching yourself to get the cricks out of your joints.  Your bed is a little cramped, but then, the cave you live under doesn't have much room.  It's quite comfy, really.  You hop out of bed and reach for the apron that always hangs next to it; your master has assigned chores for you to do.  He's already up and about, as always, but that just makes it easier for you to make his bed and then start cleaning.");

	outputText("\n\nAs you work, you start idly thinking about your beloved master, the one who gives you the cock you so need to sate the ever-present itching in your pussy, your one and all, your everything.  You giggle at that thought.  Oh, where would you be without your wonderful Sirius?  He took you in as an orphan kit, abandoned for your unshapely deformity.  He raised you, taught you everything you needed to know in order to serve him... and when he revealed that he cared for you despite your cock?  Mmm... you're so lucky to have such a generous, understanding, virile man to fuck you full of naga-seed.  If there's one regret in your dedication to worshipping his magnificent cock, it's that you never seem to become pregnant; you so want to lay his eggs and give him children - the world needs more of his bloodline in it.  You giggle to yourself as you try to envision what a beautiful little hybrid of fox-morph and naga might look like.");

	outputText("\n\nCleaning done, you start the fire and begin to reheat the meal for today's breakfast.  You look around eagerly, but master Sirius isn't back yet, and you can't resist whimpering in dismay.  You get so lonely when you're here all by yourself... plus, what if he gets into trouble out there?  He taught you to fight so that you could protect him from the lesser creatures - you should be out there with him!");

	outputText("\n\nStop that, you admonish yourself.  Master is master; he's always in control.  You just need to take your mind off of this matter.  Hmm... While master does forbid it, you could always lay in his bed and relish the scent of him...  The temptation is too strong, and you quickly scurry over and curl up in the sheets, eagerly inhaling his wondrous scent.  As you do so, your mind drifts against your will to less happy thoughts.  The nightmares, always the nightmares... about a town you never knew... though, somehow, the name Tel'Adre keeps coming to you...  Worse than that are the visions of a life you never had as a watch captain, facing hardship after hardship... and that one " + player2.mf("guy","girl") + ", " + player2.short + ".  Worst of all about the nightmares is that you can never seem to meet your master in them.  That's why they scare you so; you dread a world where he doesn't exist.  Thankfully he is always willing to help you forget with his hypnotherapy.");

	outputText("\n\nYou sit up and carefully hang your apron on the side of the bed, then lay back down on your back, beginning to fondle your long horse-cock.  Mmm... while you hate the nightmares, you love the excuse they give you for hypnotherapy.  It's such a wonderful experience.  Those beautiful pools of yellow, filling your entire world... first, it feels like you're sinking in a lake of gold... but you never drown.  Instead, the lake turns into a snake... it coils around you, like the master sometimes does, and then it bites you, filling you with gold.  Then the snake fucks you... but it never feels as good as when it's your master fucking you.");

	outputText("\n\nYou squeak in shock as familiar coils suddenly wrap themselves around you.  \"<i>Urta... what did I tell you about laying on my bed?</i>\" he asks, not angrily, but playfully.  You knew you might be punished for this transgression... but your master is so nice that even punishment feels good... and lately you've come to actually enjoy it a lot.  \"<i>I'm never supposed to lay on your bed, unless you're fucking me.</i>\"  You reply cheerfully.  Sirius smiles.  \"<i>Correct.  And what isss the punishment for that?</i>\"");

	outputText("\n\n\"<i>It means master will fuck me, but I cannot cum from my cock until master says so.</i>\"  You answer.  He pats your head lovingly.  \"<i>Good girl.  And when you are allowed to cum, what ssshould you do?</i>\"  You furrow your brows as if in thought, teasingly sucking on a finger.  \"<i>I should masturbate until I cum all over the nice tarp that master gave me.</i>\"  You declare proudly.  Your master beams at you.  \"<i>Correct!  As a reward, I will fuck you now!</i>\"  You squeal in delight as Sirius ties that pretty ribbon of his around the base of your cock, binding it tight enough to serve as a cock ring, before flipping you over and driving his divine cock forcefully into your sopping-wet gash... uhhh... that's how you like it!");

	outputText("\n\nAs he begins to pound in and out of you, your balls and tits jiggling from the impact, you smile with glee.  After he cums inside of you, it'll be time for breakfast, and then maybe master will let you cum... or maybe he'll make you wait until the next day like that other time?  You feel yourself getting even more turned on at the thought.  You've never been happier.");

	//{Bad End and all its effects applied here.}
	menu();
	addButton(0,"Next",urtaGameOver);
}

//Gnoll Alpha Encounter*
private function gnollAlphaBitchIntro():void {
	clearOutput();
	//Intro*
	outputText("The last two fights were wearying, but you still feel pretty good. Perhaps best of all, as your last defeated challenger fades into the distance, you become aware of the pendant glowing fairly brightly.  You must be headed in the right direction!  Setting off at a trot, you pick up your pace, covering great distance in the blink of an eye, eyes never leaving the rapidly approaching horizon.  Focus is key to travel in the uninhabited sections of Mareth, as you well know, but it also allows you to move with swiftness surpassing the fastest animal.");

	outputText("\n\nThe terrain gives way to flat dirt with tall grasses, a vast savanna stretching away as far as your eyes can see.  You move through it heedlessly, drunk on the idea that you can find the temple on the same day that you set out!");

	outputText("\n\nHow wrong you are.  A spear smacks into the ground, the tip exploding into some sticky, restraining substance by your foot.  A high pitched war-cry chases the missile, barely giving you the warning you need to avoid the onrushing gnoll!  This one doesn't quite look like what you'd expect from their race, but she's moving too fast to really dwell on it.");
	outputText("\n\n<b>It's a fight!</b>");
	kGAMECLASS.combat.clearStatuses(false);
	startCombat(new GnollSpearThrower());
	monster.bonusHP = 350;
	monster.short = "alpha gnoll";
	monster.HP = monster.eMaxHP(); // TODO extract to AlphaGnoll class
	monster.long = "The gnoll standing before you is obviously an alpha among her kind; she has to be over seven feet tall and rippling with muscle, not that this stops her from having a curvy form, squeezable ass and full E-cup boobs.  The remnants of what must have once been a gorgeous and expensive silken dress are draped across her figure, torn off at the knees and hanging by only a single shoulder, arms bare and exposed.  A heavy necklace of gold is wrapped around her neck, while bracelets of more of the same adorn her arms, and piercings of gold stud her ears.  She carries a mighty-looking spear in her hands, which she brandishes at you menacingly, and a basket of throwing javelins is strapped to her back.";
	doNext(playerMenu);
}

//Fight*
//Use attack descriptions/effects from Gnoll Spearthrower
//Hey QB, Savin wants to make this bitch a non-furry waifu later. That okay?
///You mean if Urta rapes her? I got no complains about it, but why non-furry? I'd personally suggest it should be okay whether you drug her with milk or not... or is the milk-drugging going to be automatic? -QB

//Urta Wins*
//Standard Win Rape Fuck*
public function winRapeHyenaPrincess():void {
	clearOutput();
	outputText("Laughing at the Amazonian princess, you unbuckle your skirt, not even bothering to shed your armor.  Sure, your hard onyx nipples are digging into the inner lining of your leather breastplate, but it's just another pleasant sensation feeding your arousal.  In the back of your mind, you hope " + player2.short + " won't mind this indiscretion - you can't afford to go wandering around unsated in a place like this.  If a succubus found you all alone and turned on, you might actually fall for her tricks, resistant as you are.  You pray that " + player2.mf("he","she") + "'ll understand.");

	outputText("\n\nYour guilt temporarily assuaged, you round on your prize, letting her see the sheer girth of your rising horse-cock, the mottled pink and black flesh thickening and filling until it gleams in the sunlight.  The gnoll gasps while her bright-pink girl-cock sprouts from her clitoral hood, nearly matching you in size and length.  \"<i>It's soo... big!</i>\" she says, almost reverently");
	if (monster.HP < 1) outputText(".  In spite of her wounded state, she seems to be quite excited by the situation");
	outputText(".");

	outputText("\n\nPrancing up confidently, you smear your dick across her nose, distracting her with your potent, equine scent while you pull a spear from her backpack.  You pull her wrists together behind her back and smack the spear into her hands.  It bursts into a sticky mess, shrouding her hands and restraining them together.  The gnoll starts to struggle, but you easily push her over, rolling her over unmercifully.");

	outputText("\n\n\"<i>Look, I SAW how you were looking at my dick.  Don't pretend you don't want this.  I just need a little guarantee you aren't gonna turn the tables,</i>\" you say almost apologetically.");

	outputText("\n\nThe gnoll looks back over her shoulders and stills her motions.  \"<i>O-okay...</i>\"");

	outputText("\n\nThat's more like it.  You grab two more spears and snap one down on each of her ankles.  Each functions as you would expect, adhering the cute, big-tittied gnoll princess to the ground.  You made sure her legs were suitably spread - what good would tying her down be if you couldn't plow that pretty, pink pussy!  Even now, you can see it spreading, blooming ever so slightly so that you can see the hint of her inner folds.");

	outputText("\n\n\"<i>Are you getting turned on by this?</i>\" you ask her with your dick nice and stiff, just begging to be plugged into her fur-rimmed snatch.");

	outputText("\n\n\"<i>N-n-no!  I'm a princess!  I'd never love being debased like this!</i>\" she cries, dragging her stiff nipples through the dirt.  You grab hold of the sticky bindings around her wrists and yank her up, arching her back so that her perky nipples are on display.  She fucking loves it!  You fondle one of those soft, savanna tits while you repeat your question.  It's actually hard to get it all out over the moaning, mewling little bitch noises she makes.  You have to wonder if this is what you sound like every time Edryn gives you a sniff of her cunt...");

	outputText("\n\n\"<i>Okay! Fine!  It's... exciting!  I've never been beaten by anyone, and it's... it's making my pussy wet!  Even my clitty is tingling, okay?  Just... go on and do me then!</i>\" she admits.  Her admission startles you out of your horse-cunt reminiscences - you knew it!  You rub your burgeoning flare up against her tight, little honeypot and push forward, barely dipping the beginning of your length into that moist passage.  Then, you hit an obstruction... a barrier - she's a virgin!");

	outputText("\n\nFucking a virgin is oddly enticing...  a lascivious grin spreads across your pouty black lips, and without another thought, you plunge forward, your dick thickening with unbridled lust.  You claim the gnoll utterly and completely, destroying her hymen with a smooth, authoritative pussy-plowing.  She screeches in pain at first, but by the time you're butting up against her virginal womb, her expression has begun to change.  The gnoll pants, \"<i>It hurts... it hurts... but in a good way!  Why does the pain feel good?</i>\"");

	outputText("\n\nYou tweak one of her nipples and answer, \"<i>You're a masochistic little slut, huh?  I guess all you gnolls are, but you savanna cunts are too busy jamming your cunts up your bitch-boys' assholes to learn, huh?</i>\"  You smirk as you rock your hips, supporting the gnoll with your groping fingertips.  She's forced to rely on you completely.  If you let her go, she'd fall face first in the dirt, and if she wants to get off, she's got to be a good little bitch for you.");

	outputText("\n\nIgnoring her clit, you shove a finger in her mouth, and to your delight, she dutifully sucks on your digit, submitting completely to your whims.  You have no doubt that if you asked her to ride around on your dick all day, on display to anyone you met, she'd agree, just so that you'd keep fucking her.  She squeals and cums, splattering your dick with syrupy gnoll-cum so copious it drips down your balls. Spurred on by this, you begin to truly pound at her twat.  Your balls quake in excitement with each sheath-grinding thrust.  Your unused cunt trembles.  Your dick begins to flare.  You throw back your head and with a feral cry, you cum.");

	outputText("\n\nThe gnoll looks back, still shaking from her own ecstasy.  Her eyes are wide, her mouth formed into a wordless 'O' of pleasure.  Inside her, you release a torrent of spooge, sealed inside her virginal opening by the swollen tip of your obscene monster-cock.  For once, you're grateful to have such an unusual dick, as it allows you to admire the gnoll's belly as it rounds beneath her.  Pump after pump of salty horse-sperm deposits itself into the masochistic, furry slut.  You smile as the cum-dump fills with liquid ardor, belly jiggling wildly as your final few thrusts deposit the last of your spoogy load.");

	outputText("\n\nThe gnoll's eyes cross as you slide her off your spent shaft, and a fountain of cum erupts from her twat, sliding down the length of her bitch-cock towards the dirt.  With your lust sated and your dick slowly drooping downward, you feel a little ashamed of what you did.  You deflowered this poor girl, and worse, you loved every second of it.  Picking a nearby thistle bloom, you tuck it into her hair.  Then, before you grab your skirt and leave, you give her unresisting mouth a slow smooch.  \"<i>I'm sorry,</i>\" you whisper as you depart, cutting her free of her bonds.");

	outputText("\n\nThe only answer you get is a blissful, \"<i>Oooohhhhhh...</i>\"");
	player.orgasm();
	menu();
	addButton(0,"Next",urtaNightSleep);
}

//[Succubus Milk] (Or, how we CAN have nice things with a little persistence!)
public function useSuccubiMilkOnGnollPrincesses():void {
	clearOutput();
	flags[kFLAGS.SUCCUBI_MILKED_GNOLL_PRINCESS] = 1;
	outputText("As you wonder what to do with the defeated furry bitch, you manage to suppress your lusty urges long enough to pull the single milk-white vial off your belt, one of the most common illegal imports you've had to bust in all your years in the Tel'Adre Guard: Succubi's Milk.  Part of you shivers at what you're about to do, but another part of you is very... very excited.  Knowing full well what this potent concoction does to the body, you decide you'd like a plumper, juicier pair of tits to play with when you fuck her.  Pinning the slut down with your foot-pad, you pop the cork.  The smell immediately assaults your senses, sending a shudder up your spine.  Grinning, you hold it up to your nose and give it a long, drawn-out sniff, savoring the nearly alcoholic odor.  The gnoll's breath catches in her throat. She desperately tries to scramble away, but you catch her by the snout, yanking her up into a sitting position.");

	outputText("\n\n\"<i>Let me go, bitch,</i>\" the gnoll alpha growls around your fist, her words muffled until you finally let her snout go - only to fill it with milk.  She gags and tries to spit it out, but you hold her mouth shut, forcing her to suck it all down or drown in the milk.  By the time she's finished the bottle, her body is already changing: you can see a thin trickle of femcum sloshing down her furry thighs, her already-hefty breasts straining at the fabric of her dress until it tears, letting her tits grow freely under the compulsion of the magical milk.  And grow they do!  The gnoll's bosom fills out nicely, expanding a whole cup size until her tits press against your own.  As her bosom finishes growing, the thick layer of fur on them begins to fall off, revealing the darkly tanned skin underneath - and a pair of midnight black nipples, stiffening at your teasing touch.  Hair falls off all over her body, leaving a bare, flat stomach, smooth arms down to the elbows, and silky, nude thighs to her knees, leaving her with no fur except for enough to simulate a pair of fuck-me boots and long gloves.  Between her now bare thighs sits her thick clit-cock, stiff and ready thanks to the potent elixir.  Her butt gets the same treatment as her rack, filling out until it tears at her dress, revealing a brand new gropable butt for you to savor. Finally, her muzzle disappears with her fur, retracting into her face until nothing of it remains but a human-like nose and a pair of black-painted lips, agape in horror at what you've done.");

	outputText("\n\n\"<i>M-my body!</i>\" the gnoll cries, her eyes wide as her hands shakily move across her transformed form, fingers hesitant to touch the bronze flesh now on display.  You can't help but grin, licking your lips as she touches the thick orbs of her F-cup breasts; she gasps when she feels her new bubble-butt, plush enough for her to sink her fingers into her soft, yielding flesh.  \"<i>You bitch!  What did you DO to me!?</i>\"");

	outputText("\n\nGrinning, though somewhat surprised yourself by the extent of the transformation, you answer, \"<i>I just thought I'd get a nicer set of ass and tits for my trouble... Don't pretend you wouldn't have used that shit on me, given the chance.</i>\" You step forward, looming over the dazed gnoll, your heavy cock stirring as you take in her newly curvaceous form. For the briefest second, you even envy her - so mutable, so readily changed that a single draught would do <i>that</i> to her... You shudder, eager for the day when you, too, can be molded into perfection....");

	outputText("\n\nYou shake the thought aside, trying to concentrate on the present, on the libidinous urges stiffening your cock inside your armor.  The bitch would have raped you half to death, even if she couldn't poison you with the milk bottle.  Time to show her what she gets for messing with the Captain of the Guard: the Rod of Justice.  \"<i>You don't fuck with the law, bitch,</i>\" you growl, freeing the beast, \"<i>or the law fucks back.</i>\"");

	outputText("\n\nThe gnoll tries desperately to scramble away, but you grab her by the hair and yank her back, throwing her onto her back so her bouncy new tits face you, just far enough apart for you to slide your horsecock right between them.  Wringing her long, dark hair, you command her to get started.  \"<i>No! I'm a princess!</i>\" she cries out, still trying to struggle despite her battle-weary - and, feeling her stiff girl-cock pressing into your backside, turned on - state.  \"<i>You can't do this to me! My mother will-</i>\"");

	outputText("\n\nYou give her a swat across the face, turning your attention to a more vulnerable target: her two dusky teats.  You pinch her nipples between your thumbs and forefingers, forcing a yelp from the gnoll as you ravage her bosom, roughly twisting and teasing the prominent nubs.  Finally, the warrior bitch seems to stop resisting, too busy whining and panting at your touches.  By way of reward, you slow down, changing to gentle caresses and even a long, slow lick across one of her tits, sending a shudder all through her body - she's sensitive!  \"<i>O-okay, okay, fine! But I've never done anything so... debasing... before.</i>\"");

	outputText("\n\nAww, she's blushing. The gnoll's cheeks flush a vibrant red as she lies back, cupping her hefty bosom in her clawed hands, pressing the warm, fleshy orbs around your member.  You draw in a long, steady breath as the gnoll starts to work her big breasts along your length, drawing the soft, smooth flesh languidly up your cock until the thick, flared head is enveloped between her two huge mounds, just long enough to deposit the first thick glob of pre on her chest.");

	outputText("\n\n\"<i>Oh, spirits, there's so much!</i>\" the subby little slut whines as your creamy offering smears between her boobs, adding a little sticky lubricant to the titfuck.  Another thick glob rolls out of your flare, this time splattering onto her neck before running off on either side.  \"<i>H-how do you make so much!?</i>\"");

	outputText("\n\nAnnoyed, you give one of her hefty jugs a slap and buck your hips forward, mashing your head into her mouth.  The gnoll snaps her black-painted lips closed, resisting you until another boob-smack makes her yelp with pain, giving your meaty cock entrance to her oral embrace.  Your captive slut gags around your girth as you push the first inches into her mouth, desperately shaking her head, trying to dislodge you.  A few moments of stiff resistance breaks her down, though, and soon you feel her coarse tongue lapping at your sensitive underside, her throat contracting hard around your flared head.  You can't be sure if she's got experience or just natural cocksucking instincts, but either way, the girl's soon sucking your cock like a wanton slut, swallowing every drop of pre her tits massage out of you with lusty abandon.");

	outputText("\n\nAs you enjoy the oral-enhanced titwank you've earned, you slowly sink down on your haunches, letting the gnoll's thick clit press into your supple buttcheeks, spreading them until it pushes against the dark, tight ring of your own backdoor.  With the electric shivers of pleasure coursing through your body from the tip of your cock, it's almost impossible to relax yourself, but eventually your sphincter gives, letting the tip of her huge clitcock in.  \"<i>Ah-ahhhhh,</i>\" the slut whines, arching her back as her over-sensitive organ is enveloped in your tight anal passage.");

	outputText("\n\nIt takes a minute to fully slide down her shaft, but by the time you've got her hilted inside you, the gnoll is trembling with ecstatic pleasure, her chest heaving around your own prick as the pleasure of her anal penetration ravages her.  Gods, she IS sensitive!  \"<i>G-gonna... gonna...</i>\" she cries, just in time for you to nearly be thrown off her as her body starts to convulse, juices spraying freely from her gnollish cunt into your backdoor, making you shudder with the sudden wet sensation deep in your rectum.");

	outputText("\n\nWith a shudder, you roll off the orgasming gnoll, flopping onto your back and watching with a chuckle as she writhes, your sudden withdrawal only sending her further into the throes of bliss.  You let yourself catch your breath, but your own urges haven't been sated yet, and precum is still rolling down your shaft, making you as much of a sticky mess as the warrior's chest.  After a moment of consideration, you grab the panting gnoll and roll her onto her hands and knees, hiking her plush new bubble butt up into the air for you to get a good look at.  She whines pathetically, rewarded with a sharp spank as your hefty horsemeat flops down between her soft cheeks.  Your start to knead her soft flesh, frigging your slender fingers into her pliant backside, delighting in your work; she's so soft, so squishy, you could lose yourself in this ass... but first you need to seize it.  You work your pre-slicked shaft through her butt for a few preparatory strokes, giving the reeling warrior time to brace herself before your wide flare presses into her backdoor, resisted by a powerfully clenched sphincter.");

	outputText("\n\n\"<i>N-no! Not there! It's... I don't want my first time to be THAT!</i>\"");

	outputText("\n\nHer first time? She's a... virgin?");

	outputText("\n\nWell, as they say, she'll still TECHNICALLY be one after you're done with her!  You give her ass another harsh slap, making the gnoll squeal as you force your giant wang into her asshole.  She's incredibly tight, and her anal muscles desperately try to repel your advance.  But you persist, lavishing the slut with thick dollops of pre that help speed and ease your entry, lubricating her anus until after a few minutes of short, jackhammering thrusts she's as wet and sloppy as ");
	if (flags[kFLAGS.URTA_FUCKED_HEL] == 1) outputText("that salamander slut's cunt");
	else outputText("a mino-cum addicted whore's sodden cunt");
	outputText(".  As you start to pick up the pace, bucking your hips into the thick cushion of her rump, the gnoll princess starts mewling pathetically, panting and moaning like a little slut.");

	outputText("\n\n\"<i>You're just a little buttslut, aren't you?</i>\" you laugh, giving her a particularly rough push that makes the whorish gnoll arch her back, moaning lewdly.");

	outputText("\n\n\"<i>Nooooo,</i>\" she whines, trying desperately not to wiggle her backside enticingly, certainly not lustily pushing back on your cock, trying to get as much of you into her as possible.  \"<i>I-I'm not that kind of girl!</i>\"");

	outputText("\n\nYou give her a slap on the rump.  \"<i>Don't lie.  This is your first time, but look at you, moaning like a bitch in heat...  You were just made for this, weren't you - to be a cum hungry little buttslut for me?  You ARE that kind of girl; ADMIT it,</i>\" you demand, spanking her again.");

	outputText("\n\n\"<i>I AM NOT!</i>\" she shouts, doing very little to disguise the ever-increasing flow of juices and femcum from between her loins; she shudders as your ring of prepuce pushes against her dark hole, your entire prick stuffed snugly into her ass.");

	outputText("\n\n\"<i>Admit it, or I'll just leave this here, stretching you nice and wide... no orgasms for girls who won't admit what they are!</i>\"");

	outputText("\n\nYou swat her ass again, but leave your huge horsecock perfectly still inside her, just on the edge of orgasm yourself.  You shudder as her heavy breathing reverberates through her body, her voice silent.");

	outputText("\n\n\"<i>I-I won't,</i>\" she whines.");

	outputText("\n\n\"<i>You will!</i>\" you say, giving her ass another hard THWACK.");

	outputText("\n\n\"<i>Nooooooo... just, please fuck me.... I need to cum.  I HAVE to!</i>\"");

	outputText("\n\n\"<i>ADMIT IT!</i>\"");

	outputText("\n\n\"<i>I-I'm a whore!  I'm a filthy little buttslut and I want your cum stuffed up my ass!  PleasepleasePLEASE fuck me!</i>\"");

	outputText("\n\nYou laugh, digging your fingers into the girl's plump backside before you give her another fast flurry of fucks, hammering your horsecock into her until she screams in pleasure and you can feel your balls swelling with imminent orgasm.  You throw your head back and scream a roar of feral might, cum gushing out of your cock and into the gnoll's bowels in powerful bursts, the first ones alone thick and potent enough to bloat her belly, filling her with foxy spunk.  For once, you're grateful to have such an unusual dick, as it allows you to admire the gnoll's belly as it rounds beneath her.  Pump after pump of salty horse-sperm deposits itself into the masochistic bronze-skinned warrior-slut.  You smile as the cum-dump fills with liquid ardor, belly jiggling wildly as your final few thrusts deposit the last of your spoogy load.");

	outputText("\n\nThe gnoll's eyes cross as you slide her off your spent shaft, and a fountain of cum erupts from her ass, sliding down the length of her bitch-cock towards the dirt.  With your lust sated and your dick slowly drooping downward, you feel a little ashamed of what you did.  You deflowered this poor girl's asshole, and worse, you loved every second of it.  Picking a nearby thistle bloom, you tuck it into her hair.  Then, before you grab your skirt and leave, you give her unresisting lips a slow smooch.  \"<i>I'm sorry,</i>\" you whisper as you depart, leaving her wallowing in a sea of seed.  The only answer you get is a blissful, \"<i>Oooohhhhhh...</i>\"");

	player.orgasm();
	menu();
	addButton(0,"Next",urtaNightSleep);
}


//Urta Loses*
//Lose Via Lust (Bonus Scene in Intro!)* ✓
public function loseToGnollPrincessAndGetGangBanged():void {
	clearOutput();
	flags[kFLAGS.URTA_TAKEN_BY_GNOLLS] = 1;
	if (player.lust >= player.maxLust()) {
		outputText("Sinking to your knees, utterly overwhelmed by lust, you gaze up the clit-cocked amazon, licking your chops. She responds by disdainfully pushing you down with one of her soft, padded paws.  \"<i>Did you really think you could trespass in my mother's territory and go unpunished?</i>\"");

		outputText("\n\n\"<i>I didn't know!</i>\" you whimper, \"<i>Honest!  I just had to-ooooohhhh...</i>\"");

		outputText("\n\nA pleasant, cushiony warmth envelops your turgid member, velvet pads curling around your equine length to squeeze it with remarkable dexterity.  The sensation easily derails your train of thought, leaving it a smoldering wreck at the bottom of a gulch.  Instead, you lift your hips against the lithe woman's limber footpaw to try and grind against it.  She withdraws the foot as fast as you can arch your body, denying you any extra sensation.  The gnoll tuts and withdraws her digits from around your throbbing maleness, \"<i>Look, you little bitch, I've never seen a girl with a cock like that, and I wanna watch you cum so hard you black out.  BUT, if you aren't going to lie there like a good little bitch, I'll knock your ass out, tie you up, and do it while you're unconscious so you don't even get to feel it.  Then, when you wake up, I'll rape your fucking urethra until you think your cock's gonna split in half.  Don't... fuck... with... me...</i>\"");

		outputText("\n\nThe look in her eyes...  She means it!  She means every word of it!  Whoever this gnoll is, she doesn't seem to handle disobedience well.  You master your lusts enough to force your hips back down; you'll have to endure it silently and obediently if you want to take care of the desire roiling in your balls, even if it means holding still while she strokes you off with her feet.");

		outputText("\n\n\"<i>Atta girl,</i>\" the hyena-girl coos, \"<i>Obedience comes so easily to peasants, doesn't it?  Look at you, lying flat on your back, tail thrashing between your legs, and loving every minute of having your cock rubbed by a royal paw.</i>\"  She presses down a little harder, her heel digging into you ever-so-slightly.  A second later, she lets up, allowing your horse-cock to perk back up.  Her toes wrap around each side, and she begins to slide up and down, slowly dragging her paws up and down your length. Pleasure blooms from every caress, every rough squeeze, and every tantalizing, full-length toe-drag.");

		outputText("\n\nYou pant, fixing your lusty eyes on your foe's cruel visage.  She smirks down and asks, \"<i>Enjoying the little bit of foot love?</i>\"  You shyly nod, blushing under your fur, thankful it conceals the worst of your embarrassment.  \"<i>Did it just get harder?</i>\" she ponders, \"<i>Yes, I think it did.  I knew it!  You're as bad as the boys back home.  As soon as someone touches your cock, you just roll over and submit.</i>\"  She giggles, \"<i>Of course, that's after we've trained them to cum from getting butt-fucked alone.</i>\"");

		outputText("\n\nA huge bead of pre-cum rolls out of your distended cum-slit, hanging from your flare for a moment.  The amazonian gnoll scoops it up with her biggest toe, smearing the puffy, pre-lubed paw-pad along your length.  It is... exquisite.  White hot blooms of pleasure go off in your brain from that simple, slow touch.  You squirt more, thick enough to make a rope this time, all over your belly.  The gnoll pulls off your erection long enough to run her pads through it and then wraps them around you in an imitation of a fist, only able to encompass half of your equine endowment's diameter in a sloppy foot-job.  You whine, begging for more.  If only you could lift your hips or grind against her!  \"<i>Please,</i>\" you beg, your pride forgotten in the face of the gnoll's dominating feet.");

		outputText("\n\n\"<i>No,</i>\" replies the hyena with cruelty in her voice.  She presses down hard and begins to slide her foot from just below your flare down towards your sheath.  You grunt and nearly thrust when she bounces past your medial ring.  It's so hard not to!  You need to hold back though!  You need to hold back so she'll let you cum!  Her toes dig into your sheath, twisting the sensitive folds of genital flesh around.  Then they crawl down onto your cum-bloated balls, rolling them from pad to pad, gently squeezing them and sometimes just holding them against the large pads on the bottoms of her feet as they gradually swell.");

		outputText("\n\nHer growling, over-confident voice teases, \"<i>How's that feel, peasant?  Answer now and answer truthfully!  Do you feel blessed to have been graced by the feet of royalty?  Is this not the best, most pleasurable experience your mismatched centaur-cock has ever had the joy of experiencing?</i>\"");

		outputText("\n\nYou stifle a whorish moan and answer without thinking, \"<i>Yes, gods, yes! I love your feet, Miss Gnoll!</i>\"  You didn't even pause to think.  Right now, it feels like your entire world is focused in on your horse-cock and the supple caresses of the hyena dominatrix.  You don't care how it stacks up to your past sexual exploits - it feels goddamn good, so goddamned good that you can't think of anything aside from obeying her so that she'll continue.");

		outputText("\n\n\"<i>I knew it!</i>\" the spotted alpha-girl exclaims in joy, \"<i>You're going to make a good pet.  I hope my mother lets me keep you!</i>\"");

		outputText("\n\nWha?  She continues to touch you, teasing apart your protests with bursts of simmering pleasure.  Your bloated horse-penis has begun to twitch and pulse under her attentions, clenching involuntary towards the edge of orgasm before relaxing, her caresses just a hair too slow to set you off on the orgasm you crave.  \"<i>Good girl,</i>\" the young amazonian whispers, \"<i>Come on, you can cum from this, can't you?  My pads are starting to get dry...</i>\"  The soft fur and softer foot-cushions smother you with warm affection, gripping and slipping faster and faster.  She twitches a toe back and forth just below your dripping flare in a spot that's so wonderfully tender and tingly that you it makes your balls convulse.");

		outputText("\n\nYour dick arches up on its own as more and more blood rushes into it, rhythmically clenching hidden muscles in ways that milky dollops of pre ooze out of your tip one after another.  \"<i>Cum,</i>\" the savanna princess commands, and this time you obey without thinking.  Your nipples pucker, hard as diamonds, and your cunt spasms around a phantom intruder, glazing the backside of your balls with tangy girl-cum.  That same taut sack, swollen and stretched by your aching balls, gradually diminishes in size, passing its cargo into your urethra, which stretches wide, bulging out into the plump pads. The gnoll curls a toe in front of your spurting slit, turning the long ropes you've begun to spray into high-pressure squirts of thick semen.  It soaks her foot-fur, your belly, your tits, your face, and your aggressor's lower body.  You cum and cum, releasing seemingly endless torrents of alabaster spooge to your foe's controlling toes, your body growing weaker and more exhausted with each passing burst of jism.");

		outputText("\n\nThe gnoll's voice praises you again, \"<i>Good girl.</i>\"  Not minding how sinfully sticky you've become, you pass into a exhausted yet pleasant slumber, so deep you don't even feel yourself being moved.");
		player.orgasm();
	}
	//Lose Via HP✓
	else {
		outputText("Flopping down to the ground, you struggle to rise.  You're badly hurt, and your muscles barely move at this point.  With a pain-wracked spasm, you roll onto your back, unable to even rise to your knees.  The gnoll smirks and proclaims, \"<i>You'll probably make a good slave once we've broken you in.</i>\"");
		outputText("\n\nBroken you in?  No!  You protest with gasping breaths, \"<i>Please... I'm just... passing through...</i>\"");
		outputText("\n\nThe gnoll lifts her spear.  \"<i>Not any more.</i>\"");
		outputText("\n\nIt comes down, and everything goes black...");
	}
	//[To Loss Epilogue]
	menu();
	addButton(0,"Next",loseToGnollAsUrtaEpilogue);
}

//[To Loss Epilogue]'
private function loseToGnollAsUrtaEpilogue():void {
	clearOutput();
	//Loss Epilogue✓
	//[HP]
	if (player.HP < 1) outputText("Ouch... what happened to you?  You blink a few times, ignoring the buzzing throb of pain that rises up like a dormant monster in the back of your head.");
	//[Lust]
	else outputText("Oh, gods... what happened to you?  You blink a few times, ignoring the gentle throb coming from your well-used member.");
	outputText("  There's a constant, loud thrum of many voices talking all at once that makes it hard to think, and when you finally come to focus in the dim lighting, you can see why.  There are dozens, if not hundreds, of gnolls here, assembled in the faint light of some kind of feast hall, most of them male.");

	outputText("\n\nRecoiling in terror, you try to turn, scrambling madly at your restraints.  The shock of being tied down only spurs you to struggle harder, and you madly twist and writhe against the leather bands binding you to the wall.");

	outputText("\n\n\"<i>Ah... my prize awakens,</i>\" remarks a rich, female voice, steeped in arrogance and pride, \"<i>");
	if (player.HP < 1) outputText("I hope I wasn't too rough on you");
	else outputText("I hope you enjoyed the journey here");
	outputText(".</i>\"");

	outputText("\n\nThe gnoll!  The one that captured you!  She's standing below you, watching you with a smirk that shows off her feral-looking canines.  The realization that you won't be able to wriggle free any time soon comes to you, and with hundreds of eyes now locked on your nude form, you doubt you'd be able to run far.  Worst of all, your traitorous prick seems to be reacting to the crowd of mostly naked males with excitement.  The sheath and base have both begun to engorge themselves with lust, slowly lifting the tip skyward.  Worse, your sweaty balls are starting to stick to your rapidly moistening femininity somewhat uncomfortably.");

	outputText("\n\n\"<i>I knew you'd take to being a slave.  Now, you may not have wanted this, but you've got to admit, there's no way you're getting out of here.  So, if you'll play nice, I'll cut you down and make sure that the coming orgy is at least somewhat pleasant.</i>\"");

	outputText("\n\nYou take a long look around the assembled gnolls.  Most of the girls already have a smaller, male gnoll bouncing in each of their laps, happily spurting leaking pre-cum, but more than half of the assembled creatures are unclaimed, feminine-looking guys!  Each has a small, hard penis, and some of them are stroking them in your direction.  It brings a potent flush to your cheeks, making you glad it's hidden under your gray fur.  Well, there's not much you can do but resign to your situation.  Your cock gets a little harder at that admission...  You can always try and get away once they wear themselves out...");

	outputText("\n\nYou nod your head.");

	outputText("\"<i>Good girl,</i>\" she says encouragingly.  ");
	if (player.HP >= 1) outputText("You shudder at the memory of your meeting, leaking a little more lubricant.  ");
	outputText("As if by magic, a knife appears in the gnoll princess' hand, and she swiftly lays into the bindings holding your feet.  With your feet free, you can flex your legs a little.  They ache from being immobile so long.  Just how long were you hanging there, anyway?  The gnoll princess - it bears to reason she can only be a princess, considering how she is dressed compared to the rest of the gnolls here - rises up on her paws to reach the leather around your arm.  Quickly, she slashes through both restraints.  There's a moment of panic when you begin to fall; you can't possibly catch yourself on your weakened legs.  The princess secures you easily as she discards the knife.  \"<i>Did you think I'd let my favorite piece of property get damaged?</i>\"");

	outputText("\n\n\"<i>Thanks,</i>\" you say, blushing harder.  Your new 'owner' (at least until you escape, you remind yourself) sets you down on a simple bench at her table before seating herself next to you.  \"<i>I told you I'd make it enjoyable if you came along nicely.  Here, have some of this; it's going to make the orgy a lot more fun for all of us,</i>\" she says while handing you a corked off water-skin.  You hesitantly pop the top and give it a sniff.  It smells like alcohol - very, very strong alcohol - with something else added.  \"<i>Drink it,</i>\" your makeshift mistress commands, lifting the bottom of it.");

	outputText("\n\nBurning fire fills your mouth, though it's not much worse than the swill Aunt Nancy serves for cheap in the Wet Bitch.  You swallow the first mouthful without complaint, but the princess lifts the skin higher, releasing a never-ending torrent of intoxicating liquor down your throat.  You gulp it down with gusto.  Sure, it's being forced on you, but honestly, a good stiff drink is just what you need.  The heat boils in your belly, but the flow continues.  Your vision narrows into a tunnel from lack of oxygen, but you've done chugging contests before.  The skin can't hold that much more, right?  Your whole world condenses down to rhythmic gulping and swallowing.  It's hard to stay upright, but a nearby male puts his arm around you to hold you upright as you finish.");

	outputText("\n\nWhen liquor is washing down your cheeks, the skin is removed and placed atop a small pile with two others.  You hiccup and glare at the girlish boy that dared to grab you, telling him that you're a grown woman who can take care of herself!  It comes out a little bit slurred, and you nearly tumble into your new owner in the process.");

	outputText("\n\nYour mistress gropes your tits, flicking your stiffening nipples.  \"<i>You're the first slave I've ever seen finish more than one skin!  How do you feel?</i>\" she asks with a sultry purr.  Your head is buzzing and her hands feel fantastic on your breasts.  Even your nipples have started to tingle with pleasant, erotic intensity.  Your erection, which had dwindled during the chugging, suddenly returns with a vengeance, slamming into the bottom of the table hard enough to make you wince.  Plates and utensils rattle noisily, and a number of drinks are spilled from mugs and glasses, staining their girlish owners' fur with booze.");

	outputText("\n\nThe closest femboys let out dismayed cries, but a word from the princess silences them, \"<i>Hush my little boy-pets, I'll give you a turn at this one in a moment.  I'm just getting her in the mood, aren't I pet?</i>\"  The gnoll squeezes your sheath affectionately, soft pads on her fingertips caressing every fold.");

	outputText("\n\n\"<i>Yes!</i>\" you gush, smearing pre all over the underside of the polished wood.  She feels so good, and the seat is growing damp under your bottom, soaked by your rapidly-moistening cunt.  You begin to pant and grind your hips back and forth, feeling positively aroused, unquestionably hungry for cock.  The idea of escape is growing unquestionably less appetizing; all these sexy little studs and their stiffies would fit perfectly in your holes, and their tight, round bottoms would make lovely sheaths for your dick.  Your sexual cravings kick into overdrive, and as the alcohol melts away your inhibitions, you accept that you're going to be leaving this room bow-legged, if you ever want to leave at all.");

	outputText("\n\nThe gnoll princess giggles and lifts you up on to your feet, leaving you to sway drunkenly in place.  \"<i>Each one of you can cum in her holes, but only once!</i>\" she shouts, \"<i>You have been eating lots of celery and pineapple, right boys?  I want my lube to taste good.</i>\"");

	outputText("\n\nBefore a single, \"<i>Yes, Ma'am,</i>\" cuts the air, a dozen grabbing paws are taking hold of you and pushing you over the table.  Your tits press down on the smooth wood, displacing a bowl and spoon, while a plate is caught under your left nipple.   Jutting up against your nose, a four-inch, black gnoll-prick grows excitedly.  Reacting without thought, you open wide, grab it with your tongue, and pull it inside your mouth.  \"<i>Mmmmm,</i>\" you hum, lapping at the small phallus excitedly.  It tastes nice, if a little bit salty, and it quickly begins to ooze sweet pre-cum on your tongue.  You suck in a little, just enough to make it a little harder, and look up at your fellow slave through bleary eyes, winking while you fellate him.");

	outputText("\n\nA tiny, brief burst of pain from your unprepared asshole startles you from your phallic mouth-worshipping.  The miniscule girth is nothing compared to some of your toys back home, and once he's plugged your butt, his tip bumps into your prostate, helping to turn the startled discomfort into yielding pleasure.  Your member is hanging off the edge of the table, bouncing slightly each time the girlish gnoll-boy pounds your pucker and leaking a thin trail of fuck-slime toward the floor.  You're going to cum soon, but your pussy... your sopping, squirting little pussy needs some love!  It craves sperm so badly that you can feel your inner walls twitching and rubbing against each other, desperately trying to squeeze jizz from a nonexistent cock.");

	outputText("\n\nThe rest of the herd of slave-boys jostles and jockeys for position, and before you know it, two cocks have been placed in your hands.  You jerk on them encouragingly, squeezing each of the five-inch boners with gusto.  The extra dicks do nothing for your hungry, quivering gash.  It needs something - anything - inside it!  Some of the gnolls are trying to get to it, but the big, butt-fucking male refuses to move.  He's too enamored with your tight anal walls to even consider moving.");

	outputText("\n\nJust when you've given up on getting yours, the smallest of the slaves wiggles through the crowd and lays down on the table next to you, right under one of the pricks you're busy stroking.  Pre-cum is oozing from all four cocks now, and some of it even drips on the new arrival, but he doesn't seem to care.  You suppose taking giant clits up the ass day in and day out would make him a little less picky about sexual preferences...  Oh, what's this!?  You spot his large dick out of the corner of your of vision.   This short gnoll has the biggest dick out of any of them!");

	outputText("\n\nHe sees your eyes widen in shock and flashes a cocky grin, then shifts his hips closer.  You get the idea, arching your back to raise yourself a little bit, which causes the cock in your ass to dig into you a little bit harder.  The extra height is all he needs to slip his slim form in under your abs.  His fur is silky-soft, and just a little longer than yours.  He doesn't move completely underneath you, but he's got his hips down there, just far enough for his cock to arc up under your balls and let his sizeable tip rub over your puffy black nether-lips.");

	outputText("\n\nYou meet his eyes and whimper needily.  His dick, his cum, whatever - you've got to have it inside you!  You want your pussy to bathe in his cum, drown in it, and let it wash over every sensitive fold while he fucks you!  The gnoll's smile spreads.  He moves just a little, enough to slide the first few inches into your ready twat.  Slamming your hips down, you force the rest of him inside you, taking his cock whether he wants you to or not.  Your own erection, utterly dwarfing those of your lovers, disgorges thick streams of pre, so massive that many of the slaves whisper, \"<i>Cumming already?</i>\" to each other.  The pretty little fem-boy hugs against your shoulders, moaning as his brother's cock drips on his face.");

	outputText("\n\nFive gnolls are using your body.  The one in your mouth is pulsing fitfully, his cute little balls bouncing on your nose.  Your hands are both dripping hot, bestial pre-cum as you pump the slick little shafts.  They aren't as close to cumming, but you can feel them getting harder with every quick motion.  You hope they don't though, preferring that they make deliveries inside you.  Down low, the gnoll in your ass is also on the edge, unable to withstand the tightness of your tight ring and hot insides.  Your cunt is FINALLY getting what you need, a warm, juicy dick slapping into your lips, rubbing your balls back and forth between your bodies as they dangle down.  Sometimes, they get squeezed a little painfully, particularly when the big-dicked fem-boy gets excited, but each time it happens the stream of fuck-juice spurting out of your massive horse-cock thickens, hosing down the gnoll below and the floor.");

	outputText("\n\nThe room is spinning around you, so you close your eyes and focus on other sensations, smiling around a thin penis when a sixth gnoll climbs on your chest.  He folds your jiggling breasts around his petite erection, completely enveloping himself in breast-flesh.  Your silken fur tickles at his skin when he starts to slide it in and out, but your cleavage's valley soon becomes wet with his copious drippings, slick and moist with gnoll-pre.  Your body bounces around, a helpless passenger in an orgy of gnoll lust, doped up on alcohol and aphrodisiac until the only thing that matters to you is the pressure in each of your holes and the sweet cream they leak.");

	outputText("\n\n\"<i>Let her have it, boys.  Can't you see she's gone into heat?</i>\" your mistress says.");
	outputText("\n\nOn cue, you feel a sudden, sticky wetness beginning to flood your rectum.  The butt-fucking gnoll pushes his sheath right up against your cheeks, burying himself as deep as he can into the sodden fuck-hole, and he continues to pump more juice into you, his cute little balls bouncing against your voluptuous backside.  Squirt after squirt of his seed erupts inside you, jostling the hot, slick mass around in your butt.  The pressure on your prostate grows, enhanced by the sloppy anal fuck.  You moan into the dick in your mouth and cum, even as the vibrations of your pleasure vocalizations vibrate that member to orgasm.");

	outputText("\n\nHuge, alabaster ejaculations stream from your untouched member, splattering in the clear puddle and spraying down the gnoll's knees with your spent semen.  You barely note the departure of the gnoll behind you until his cum trickles from your butthole and onto the dick plugging your cunt (as well as your trembling nutsack).  Oh gods, there's cum in your twat!  You're getting cum in your cunt!  Your orgasm redoubles, spurred on by an insatiable desire to devour sperm with your womb.  Spooge trickles onto your tongue while your eyes roll back.  You swallow instinctively, moaning whorishly into the jizz-pumping penis in between gulps.  It feels so good that once his orgasm stops, you suck harder on him, trying to squeeze a little more cum from him.");

	outputText("\n\nYour climaxing cunt-walls wring the lucky, big-dicked gnoll-boy relentlessly, milking him with muscular contractions so powerful that they make your abdominal muscles burn from the effort.  He looks at you plaintively, panting, and as soon as his brother pulls out of your sucking noise-hole, he pulls you into a kiss, ignoring the salty taste on your lips for a moment of comfort as he gives in to bliss.  His tremendous (but still smaller than your own) tool erupts, and as soon as the sperm touches your cervix, your body locks in infinite, exquisite ecstasy.  He virtually rapes your unresponsive mouth-hole with his tongue, orally licking and plunging into your opening repeatedly while his cock disgorges a thick, dripping load into your squeezing, sucking little whore-cunt.");

	outputText("\n\nHe breaks the kiss, and you begin to scream out your pleasure in a stream of unintelligible gibberish broken up by the occasional 'fuck', 'cunt', and 'cum'.  The smell of your own fragrant animal-spunk mixed with the gnolls' salty deposits drives you wild, made worse by the withdraw of seed-spurting cock that was so recently trying to inseminate your cunt.  You aren't pregnant - you NEED to be pregnant.  It isn't a thought, it's a fact told to you by your heat-mad body.  It doesn't matter that you're incapable of getting pregnant - your body DEMANDS more cum for your cunt, and you're incapable of denying it.");

	outputText("\n\nThe small gnoll, now spent, crawls away from you.  Thankfully, another takes his place, immediately slotting into your snatch without pause.  Likewise, your empty asshole is almost immediately filled with a fresh cock, though this one is only three or four inches long, not even able to rub your prostate.  Still, it swirls the spunk inside your butt around pleasantly, and just thinking about all that cum makes your pussy squirt on its new fucktoy, just before it begins to milk it too.");

	outputText("\n\nA shadow looms over you, and your well-glazed mouth is pried open, just in time to accept a little, pony-like horsecock.  As it pushes towards the back of your throat, your lips discover it's capped by a small knot.  You allow it inside and begin to tickle the sensitive bulge with your tongue, glad that your orgasm has wound down to the point where your own swollen horse-meat has stopped erupting so violently.  Your cum is puddled up half a foot deep at the highest point, slowly spreading over the floor.");

	outputText("\n\nSeeing your disheveled, orgasm-addled state, the two cocks in your fists begin to fill, getting bigger, tiny sacks brushing your hands.  They explode without warning, the veins pushing into your palms as they spray their liquid love over your breasts, adding a fresh layer of wasted spooge.  A litany of squirts splatters you, yet the spermy fusilade quickly dies down as their balls empty.  You let go of them, disappointed by their waning virility.  Another pair steps in, and once again, you're smothered in cocks.");

	outputText("\n\nSucking deep on the knot, you hum into the odd, dog-horse dong, feeling the flare widen in time with the thickening dog-knot.  A splatter of jism ricochets off your chin, painting your neck white.  A white spot blooms on your lighter-colored chest-fur, spreading down your tits as they become more and more soaked, cum drooling out each end of your cleavage.  The gnoll straddling your chest is cumming, his hands squeeze your nipples tightly, shooting arcs of pleasure through your tender buds.   You shake, ecstatic to be used so thoroughly, focusing your muscles on milking that cock in your pussy for the next load.");

	outputText("\n\nYou fucking love this!  Your head is swimming, your body is lost to pleasure, and you're getting so much cum!  The fem-boy above gets off, but like clockwork, he's replaced by another slave.  One of them starts to climax in one of your orifices, but you're too doped up to even recognize where it is.  Sperm is soaking you from head to toe, gnoll boys are rubbing their nuts on you, and you're getting thoroughly glazed.  It's so... so... warm...");

	outputText("\n\nConscious thought ceases completely.  Pleasure, orgasm, and getting more jizz for your womb become your only concerns.");
	player.orgasm();
	dynStats("lib", 20, "sen", 100, "cor", 20);
	//[Next]
	menu();
	addButton(0,"Next",loseToGnollAsUrtaEpilogueBAM);
}

private function loseToGnollAsUrtaEpilogueBAM():void {
	clearOutput();
	outputText("Ouch!  Something smacks your face, and it fucking hurts!  You look up, seeing a strong, spotted paw pulling away, trailing a web of spooge in its wake.");

	outputText("\n\n\"<i>Wake up bitch, it's my turn!</i>\" shouts your Mistress, pushing a horny boy away from you.  She sits down next to you, and the assembled, horny little studs retreat.  At some point the crowd must have grown, because you don't remember any of the slaves from her retinue - the gnolls surrounding you now are all different males.  Your belly has a thick cum-paunch, made from a combination of the sperm packed into your womb and anus.  You belch, tasting of alcohol and spunk, a taste you relish.  Cum has matted your fur to your body all over, turning it slick and off-white, and rivulets drip off you everywhere.  Even your tail appears smooth and soaked.");

	outputText("\n\nMistress does not give you time to dwell on your current state.  She simply picks you up in those strong arms of hers, and sets you on her lap.  Gods above, she's big - maybe bigger than you!  Her gigantic clit sinks slowly into your cum-packed pussy, and as it penetrates deeper, poking straight through your unresisting cervix, the cum that's been pressurized inside you vents, right through some channel in her obscene female organ.  The gnoll princess moans lasciviously, spanking your butt hard enough to make the caked-on jizz splatter everywhere.");

	outputText("\n\n\"<i>You're the first girl I've met that can take me!</i>\" she screams in pleasure, pushing you the rest of the way down until your cum-dripping labia are rubbing her clean, slick ones.  She nips at your neck, hard enough to draw a trickle of blood as she revels in the sensation.  \"<i>This is the best way to get pregnant - letting the boys fill up a cum-dump and then draining the choicest sperm straight into me.</i>\"  Her hand cracks on your ass again, setting off a rain of spoogy drippings.");

	outputText("\n\nIt feels so good... but she's taking your cum!  You bawl, \"<i>Don't take my cum!  I need it!  I need it!</i>\" even as you grind into her lap, wiggling your lubricated butt against her.");

	outputText("\n\nYour mistress looks over her shoulder towards her mother, up on the throne, \"<i>-the fuck is wrong with this bitch?  The heat should have ended by now!  There's NO WAY she's not pregnant!</i>\"");

	outputText("\n\n\"<i>I... I'm b-barren,</i>\" you bawl, already missing all the lovely jism that kept your womb so wonderfully pressurized, so full and ready, like you needed it to be.");

	outputText("\n\nThe Gnoll Queen, high up and distant, laughs, \"<i>Have fun, daughter.  I'm sure she'll be a hit with the worthless, little males.</i>\"");

	outputText("\n\nYour mistress snarls and lifts you up, letting that slick female fuck-stick - thicker in the middle than on either end - stretch you wonderfully.  The entire, bright-pink length is sheathed in a condom of alabaster goo.  Then, she drops you and grabs your tits, tweaking your poor, soaked and abused nipples.   Your inner walls want to ripple, to squeeze and caress it, but they're so utterly exhausted, so spent after milking out all that gnoll-boy cum.  You just can't compel them to move...  All you can do is slide down, get picked up, and get dropped again.  The cum slowly drains from you, your paunch diminishing, only to grow heavy against your back.");

	outputText("\n\nThe princess's new, gravid middle saddens you.  She whispers, \"<i>Don't worry, slave, I'll let you milk the slaves every hour you're awake, provided you're a good girl, okay?</i>\"");

	outputText("\n\nYou nod as your Mistress's hands wrap themselves around your cock.  \"<i>I love having a girl like you for a slave...  You can be my barren little brood-mare cum-tank, storing up all my boys' cum until it's time for me to get pregnant again.</i>\"  She squeezes affectionately, and begins to stroke you, purring with delight when your pre oozes over her fingers.  \"<i>Such a messy little girl, with a nice, supple cunt for me to fuck.</i>\"");

	outputText("\n\nThe gnoll princess begins to bounce up and down, sending you bouncing higher and higher, sliding on that cum-slick, pulsing girl-pole.  Her hands stand busy on your cock, one stroking and teasing, circling just under your flare.  The other caresses your balls, and even though they've been emptied a dozen times, they clench tightly at her touch.  She fucks you faster and faster, and you moan like a good whore, a perfect little cum-pet, trying to make her get off so that she'll let you go get packed with fresh semen again.");

	outputText("\n\nIt works - the gnoll's sensitive, giant girl-dick can't take such stimulation for long, and she begins to cry, \"<i>Ungh!  Goddamn... you're... goo-Oh!  Oh yes!  YES!</i>\" moments before exploding in an orgasm of her own.  She squeezes your dick and balls with brutal strength while her pole quivers inside you, and you cum with her, firing jizz into the fapping fem-boys.  One of them is unlucky enough to take a hit square in the face.  Sperm dribbles down his chin and explodes over his chest.  You hit him again and again, until he's painted and panting, still masturbating while he licks his chops.");

	outputText("\n\nYour queen slumps back, carrying you with her, and you dribble a few last, wasted squirts over your shoulders onto her nice, fat tits.  She nips your ear and whispers, \"<i>Good girl,</i>\" again, gently lifting you off her while she recovers.  Her whole body twitches as you're withdrawn, her clit huge and over-sensitive still, but once you're off, she rises, only breathing a little heavily.  Her once-taut belly shows the cum-bulge better than your own, and you look on with undisguised envy as the mob closes in around you once more.");

	outputText("\n\nYou smile when your holes are filled again - you'll get that yummy gnoll-cum inside you soon.");
	menu();
	addButton(0,"Next",urtaGameOver);
}

//The First Night Sleep*
public function urtaNightSleep():void {
	clearOutput();
	outputText("The sun is low in the sky by the time you finish your third encounter of the day.  It's time to find shelter.  The temple will have to wait until tomorrow.  You travel quite a distance, far enough that the gnoll's tribe should have trouble finding you if they search.  You pull out your blanket, making your camp in a concealing depression close to the edge of a forest.  There's no one to take an evening's watch for you, so you'll have to rely on concealment to get by.");

	outputText("\n\nAs you settle down for a night's sleep, you consider your armor.  It's starting to chafe a little.  Wearing it to bed would be uncomfortable, likely giving you a restless sleep, but it might also give you a fighting chance if something comes after you.  Do you want to sleep naked and rest better at some risk, or do you want to sleep in your armor, safer, but tossing and turning?");

	menu();
	addButton(0,"SleepNaked",urtaSleepsNaked);
	addButton(1,"Wear Armor",urtaSleepsArmored);
}

//Armor Sleep*
private function urtaSleepsArmored():void {
	clearOutput();
	model.time.days++;
	outputText("You go to sleep wearing your armor.  It turns out to have been a good idea when you're woken by tentacles probing at your chest-plate, seeking to undo the numerous straps holding it in place.  You roll to the side and easily squeeze out of the slippery tendrils.  Your hand falls on your halberd with practiced ease, hefting its reassuring weight in your hands as you spring up off your paws.");
	outputText("\n\nThe tentacles wave about wildly, and the shambling mound begins to retreat.  \"<i>Fuck this!</i>\" it shouts, \"<i>I just wanted a snack!</i>\"");
	outputText("\n\nWhat?!  That gigantic tentacle beast didn't try to fight you?  You suppose it's used to easier prey at this time of night and didn't want to expend the effort on a fight.  How fortunate for you.");

	outputText("\n\nIt takes a while to get back to sleep, but when you do, you sleep comfortably, knowing your armor will protect you.");
	outputText("\n\nA quick and messy fap in the morning takes care of the tension that built up overnight.  The ground happily drinks away the evidence of your lust.");
	//{Recover less HP/fatigue or something}
	HPChange(.5 * player.maxHP(),false);
	player.changeFatigue(-50);
	player.orgasm();
	menu();
	addButton(0,"Next",introSuccubiAndMinotaur);
}
//Sleep Naked - Nocturnal Tentacle Beast Fuck*
private function urtaSleepsNaked():void {
	//NOT PLANNED AS A FIGHT
	clearOutput();
	outputText("You bed down for the night, languidly removing your armor and stretching in the pale moonlight.  The cool air feels wonderful on your skin, particularly after being bound up in that restricting armor all day.  You yawn and wrap yourself up in a blanket, swifly falling asleep in the soft grasses at the edges of the plains, comforted by the gentle hooting of the owls in the woods to the west.");
	HPChange(player.maxHP(),false);
	player.changeFatigue(-100);
	dynStats("lus", 10);
	menu();
	addButton(0,"Next",urtaGetsTentaRaped);
}

//[Next]
private function urtaGetsTentaRaped():void {
	clearOutput();
	outputText("In your dreams, you're dancing with " + player2.short + " at your favorite bar, the bounty of your newly restored genitals bulging between your bodies.  You feel yourself growing warm at the closeness of your lover's body, already aroused and ready for another coupling.  Inhaling deeply, you savor the scent of mixed lust - sweet, so sweet. It makes you a little dizzy to be honest, and you stumble, letting " + player2.short + " catch you.  Mmmm, so warm.  A tongue enters your mouth, dripping more sweet scent onto your palette.  You swallow involuntarily, compulsively, as that oral organ penetrates so deeply into your throat.");
	outputText("\n\nWait...  " + player2.short + " doesn't smell (or taste) like that.  You're still fucking horny, though!  Waking, you stretch and go to yawn, but all that escapes your mouth is a muffled, \"<i>Mmmph!</i>\"");
	outputText("\n\nYou go to full alert in an instant.  Looming above, a wriggling monstrosity has eclipsed the moon.  Hundreds of wiggly tentacles coil and move around each other, creating a show of scintillating illumination from the moonlight that can squeeze through the cracks.  There's three dozen of them poised above with bulbous, purple tips that drip clear, sweet sap.  A few lack the tip, instead having pulsing mouths, capped with obscene, smiling black lips; plump, soft, and glossy.  Your blanket is gone.  The creature must have removed it.  With the tentacle leaking down your throat, you can't really get a good look around, but you can feel your dick on your tummy, obscenely rigid and leaking onto your breasts.  It doesn't seem like the beast has come after the rest of you yet...  You can still get free!");

	outputText("\n\nReaching up, you grab hold of the slippery shaft, finding it remarkably hard to get a grip on.  At first, it simply pumps through your fingers, turning your struggles into a handjob, but you bring your willpower to bear and squeeze down harder, immobilizing the corrupted plant-cock.  It must hurt, because as soon as you get a grip, the creature reacts violently.  Two tendrils spear down at you, each capped with a glittering, silver needle.  They stab into your chest, lightning quick.  There was no way you could have reacted - you had barely begun to release the mouth-humping pseudo-dick, and they had already struck.");

	outputText("\n\nIt hurts of course, but not very much.  Even though you've got needles inches deep in your breasts, it's more of a warm, gradually heating tingle of pleasant sensation than anything to concern yourself with.  The injecting tendrils wiggle above, waving back and forth, their surfaces contracting, moving small bulges down their length.  When a bulge reaches your chest, a surge of pleasure runs through your growing nipples.  Your head feels kind of floaty...  Your... thoughts... are... are... slow...");

	outputText("\n\nSmiling, you begin to suckle on the green tool, swallowing it a little deeper.  It's still drizzling out something that makes your belly tingle, but it's so deep inside you that you can no longer taste the honeyed sweetness.  You can smell the scent in the back of your nose though.  It makes your dick begin to bounce on your belly, an impatient, horny stallion that's far too eager for sex.  If you could vocalize your sluggish, slurried thoughts, you'd giggle at the mental picture.  Instead, you smile around the dick and swallow.");

	outputText("\n\nWhite bubbles begin to bead atop your onyx tit-tips, flowing faster and faster with each pulse of those busy little injectors.  You're lactating so much!  Milk begins to trickle down the sides of your breasts, warm, wet, and creamy as it puddles in the grass beneath you.  You try to arch your back into them.  More milk!  Your body is oddly unresponsive to your attempts, and simply lies there, limp.");

	outputText("\n\nSeeing your relaxed state and vacant, hooded eyes, the creature slowly moves into action.  The piercing needles pop out, seamless, unbroken breast-flesh healing closed at their exit.  Not a single drop of blood escapes, so perfect is their work.  At the same time, three of the mouthy tentacles lower from the perverted foliage.   The first two hungry mouths settle on your nipples, black mouths joined to ebony nipples.  Your nipples immediately let out huge flows of milk.  You couldn't hold the lactic bounty in even if you tried.  The suction, and those soft, smooth, silken lips squeeze at your squirting tips so perfectly.  They begin to shine with a combination of sweet saliva and your cream milk, glossy and reflective in the dim night.");

	outputText("\n\nThat leaves one more mouth that you've already forgotten about.  It has not forgotten you.  The plump puckers press on your oozing, bouncing flare, allowing the slippery proof of your artificial lusts to coat their entirety.  They continue to kiss at your tip, sliding, slipping, and squeezing at it from time to time.  Sometimes they open up enough for you to feel those sinful lips curling around the edge of your flare, just enough suction present to draw out a thicker flow of your precum.  Your eager tip is released a moment later, and paralyzed as you are, you cannot thrust to put yourself inside that hole, much as you may want.");

	outputText("\n\nThe vine seems to content itself with teasing your column of equine fuck-meat.  It moves around to the underside, patting its plump cock-pillows to your sensitive underbulge, smearing it with your dripping need for good measure.  You're whining now, looking up the mass of writhing sexual vines, begging for release with your eyes.");

	outputText("\n\nInstead, the mouth-tendril continues to just barely fellate your swollen, bouncing dong.  A half-dozen cock-tentacles descend towards you.  They swivel this way and that, like blind, sightless snakes sensing for prey.  Then, one by one, they part towards their chosen targets.  One circles your balls and squeezes tight, almost painfully, before stuffing itself into your sopping pussy.  Another, dripping its own lubricants, pushes into your asshole.  Your muscles are so relaxed from taking in so many of the creature's drugs that there's virtually no resistance for the anal invader.  It simply slithers on in, dripping tainted fluids in its path.");

	outputText("\n\nThe rest curl into whatever crevasse they can manage - your armpits, thighs, even the soft valley between your tits.  All are violated by the tentacle creature's lusty, hungry desires.  With your wits slowed, you lack even the sense to continue to beg.  You simply lie there as it lifts you up, into itself, into the hundreds of wavy vines.  They caress you all over, dragging their lengths in and out of your clingy interior, smoothing the passage for even greater ease of fucking.  The bubbly pre has your body releasing obscene squelches with each pleasant, fulfilling push.");

	outputText("\n\nThose lewd sounds grow worse when more tentacles begin to assault your entrances.  The first place to fall is your vagina, now so wet and slippery that you're barely enjoying it.  It's actually kind of nice to feel the two tentacles twining around each other inside you, curling into a double-helix of hot, raw sexual energy.  It feels nice and full, perfectly stretching you.  Two more pose above you.  How... pretty...  One goes straight up your ass, pushing in as the other pushes out.  They frot inside you like two horny lovers, rubbing their rubbery vine-flesh against one another with little care for how they batter your walls or press on your anal g-spot.  The remaining tentacle weaves itself into the double-cunt-fucking helix, transforming it into a braid of solid vine-cock, the three bulbous heads stretching your slackened muscles to their limit.");

	outputText("\n\nA bright orange, pulsating penis appears above your loins, capped with a ridged red head.  It drizzles glowing green slime over your poor, taut cunt, which is stretched so strongly that you feel like you're about to tear.  As soon as the illuminated goo spreads over your lips, it brings with it a palpable sensation of relief.  You still feel the wonderful, tight friction as you're filled, but as the tentacle's juices smear deeper, your cunt becomes more and more elastic - still tight, but more able to accommodate such extreme insertions without losing tightness.");

	outputText("\n\nYour sore, aching nipples are suddenly freed from the sucking tightness that's been milking them for the last five minutes.  The black buds are definitely swollen, nearly twice as engorged as you've ever seen them, and so sensitive that the night air is like gentle fingertips stroking your areolae.  You go to grab them, and amazingly, your sluggish arms lift.  Whatever immobilizing agent was in your body, it's wearing off, and your ditzy, dazed thought processes are beginning to speed towards normal.  You cradle your tender nipples, sucking a particularly potent bulge down the mouth-tentacle, and eagerly await your orgasm.");

	outputText("\n\nFrom the sensations washing through your body, you'd think that you would have cum by now.  It's like your threshold for pleasure has been raised far beyond the natural.  The pleasure has you rocking your hips against the numerous dicks as they ravage your holes.  You're so close... you just need a little bit more.  The huge orange tentacle catches your eye - it's at least as big as a dozen of the others, and you've no doubt that pulling it into your twat and letting your cunt gorge on its magical juices would get you off like a rocket.  Of course, while you get the feeling that the green goop would prevent it from perma-gaping, there's no way something like that won't have a permanent effect.  Do you ride the little tentacles to orgasm, or take the giant orange one inside it, and let it baste your twat with pussy-elasticizing fluids?");
	//[Tentacles] [Big Orange]
	menu();
	addButton(0,"Tentacles",urtaFinishesWithTentacles);
	addButton(1,"Big Orange",urtaFinishesWithBigOrange);
}

//Big Orange Tentacle Finisher*
private function urtaFinishesWithBigOrange():void {
	clearOutput();
	outputText("Greedy for more, you stretch up to the giant, fat prick and grab hold.  As soon as you do, all the other tentacles quiver, shaking slightly.  The entire surface is already slick and well lubricated, and as soon as you begin to touch it, glowing green drops as big as teacups begin to drip from the massive, dilated cum-hole.  You marvel at the sheer, absurd size of the thing as you guide it down to your waiting nethers.  The three braided vine-cocks withdraw without your intervention to make room for this virile monstrosity.  Your black-lipped sex folds closed once empty, though it does drip with some of the milky plant-seed that already leaked inside you.");
	outputText("\n\nYou pant in anticipation as you draw the distended dong right up to your entrance, the head easily as big as your unstretched lips.  An electric tingle radiates through your vulva at first contact, and the bulbous tendril shivers with it, caught up in the same erotic energy as your eager pussy.  An explosion of warmth goes off against your nether-lips, spreading them with liquid weight, green goo slowly inundating your passage as it exits your chosen dildo.  You caress the top of the glans, then circle below, just under the top, to that wonderfully sensitive spot.  The answering flow is so thick that most of it splatters into your fur, but you still intake a full blast of it into your quim.");

	outputText("\n\nWhile you fondle the big boy, your ass is still getting drilled.  The tentacles smush up on your prostate over and over, making you drip nearly as much as your floral mate.  The lips that have teased your cock all this time sluggishly shift position, pressing back against your tip and slowly opening.  With sloth-like slowness, those soft lips encircle the fat, flat head of your horse-dick.  As the tight seal drifts down your length, you get your first taste of the mouth's interior.  The whole of the tentacle seems hollow and lubricated with some internal moisture.  Most interestingly of all, the walls are covered with wiggly little cilia, thousands of them.  Your over-aroused member is caressed and tickled from sheath to tip, buttoned up in the moist confines of the tentacle while its plump and juicy lips are smacking against your balls.");

	outputText("\n\nYou can't take it any more!  You shove one hand into your cunt and pull the lip to the side, stretching yourself to your limit.  Incredibly, you can pull and pull.  Your tunnel dilates easily, spreading wide.  You can actually feel the cold breeze making the spunk-residue inside you tickle and evaporate.  The tentacle takes over at this point and slams forward, smacking itself into the half open entrance.  It's too big and too blunt to get in, not like this.  You let go of the lusty phallus now that it's gotten the idea, grunting with each ablative, slimy impact.  Then, you take hold of the other side of your pussy and pull it wide, fully opening yourself to this tentacle-creatures massive fuck-staff.");

	outputText("\n\nIt nudges in, the first half of its bloated tip actually nestling into the plush entrance before it encounters resistance.  The red-hued monster-dick bulges down its length, then sprays a huge wave of its gunk into your twat.  It fills you so full that it actually stretches your uterus into a plainly-pregnant state.  If your friends in Tel'Adre saw you now, they'd think you were about to give birth!  It actually feels... good, pumping bigger and bigger.  You stretch wider and wider, and the tip slowly slides home, pressuring your womb until you look more pregnant than a centaur mare with twins.");

	outputText("\n\nThe beast backs off after that, letting his (and it can only be his, with a dick like that!) luminous pre-jizz drain from your elastic twat.  Your snatch quickly closes, easily returning to its normal, pre-stretched state.  You tug it, experimentally, and marvel at how painlessly you can pull on it.  It has just as much resistance as before, so you're still kind of tight, but it's like your pussy has no upper limit!");

	outputText("\n\nBefore you can finish your thought process, the beast asserts its dominance once again, and presses through your violated veils.  The whole head pushes past your entrance smoothly and slowly, setting off miniature orgasms inside you.  You can actually feel your hips shift wider, thankfully painlessly, as it distorts your body, the head visible on your taut midriff as it pushes up against the underside of your tits.  At that point, even your enhanced flexibility hits its limit, but it's enough.  You're pregnant with a monster-cock, filled beyond sane capacity.  Is this what goblins feel like when they fuck a centaur or minotaur?  You rub your hand over your midriff, feeling it pulsing inside you.");

	outputText("\n\nWithout warning, it rears back, leaving you mostly empty, body snapping back to tightness.  Then, it spears you, right up to your tits.  You cry out in ecstasy, squeezing two nearby tentacles for support.  They spurt and cum from the rough treatment spattering your fur.  The immense weight of that mammoth tool rocks your body to and fro, pounding you mercilessly, pushing you back and forth through the swarming tendrils.");

	outputText("\n\nTwo mouths drop back onto your sore breasts and begin to suckle your abused nipples.  Even though your milk has long been exhausted, they try, holding on to your shaking, super-fucked body.  The aphrodisiacs inside you morph the pain and pleasure into a syrup of ecstasy for your brain to drown in, and as the swollen beast inside begins to erupt, you climax.   The cilia girding your maleness go crazy, which causes your jism to wrench free of your body with such force that your [hips] pop from your straining muscles and your horse-cock feels like it's about to explode.  The interior floods with your dick-milk, traveling away through the vine in fat bulges.  Again and again you pulse, filling the vine with the same orgasmic squelching that the other tentacle uses to fill your ruined hole.  All around you, the assembled penises spray their hot loads.  Seedy spunk slops onto your tits, into your pits, over your elbows, onto your knees, and drenches your feet.  Your whole body is a dripping, jizz-drenched wreck.  Your cunny is spasming, clenching, and sucking.  Your womb is inflating, nearly as big as the rest of you.   You scream as the tentacle withdraws from your mouth, suddenly muffled when it splatters you with a fat deposit of alabaster cream.");

	outputText("\n\nYou black out from the onslaught of pleasure - it's too much for your mere mortal brain to handle, and your mind shuts down.  It doesn't stop you from dreaming of sex for hours more, or from waking up a dripping wreck in the morning, soaked with vine-sperm and drained dry.  Amazingly, your vagina (and hips) have closed back up.  Guiltily, you press your digits into your vagina.  It hugs them tightly, and you sigh in relief.  You look down to pull them out, and realize you've fisted yourself up to your elbow.  Shit.  This won't be easy to explain to " + player2.short + ", but maybe " + player2.mf("he","she") + " will like having someone who can combine tightness and an accommodating capacity.");
	flags[kFLAGS.URTA_TENTACLE_GAPED] = 1;
	flags[kFLAGS.URTA_TENTACLE_RAPED] = 1;
	player.orgasm();
	dynStats("lib", 1, "sen", 2);
	menu();
	addButton(0,"Next",introSuccubiAndMinotaur);
}

//Choose Regular Tentacles*
private function urtaFinishesWithTentacles():void {
	clearOutput();
	outputText("Sighing, you pinch your nipples as your ride the dozens of tentacles, letting them completely envelop your body.  The lips that have teased your cock all this time sluggishly shift position, pressing back against your tip and slowly opening.  With sloth-like slowness, those soft lips encircle the fat, flat head of your horse-dick.  As the tight seal drifts down your length, you get your first taste of the mouth's interior.  The whole of the tentacle seems hollow and lubricated with some internal moisture.  Most interestingly of all, the walls are covered with wiggly little cilia, thousands of them.  Your over-aroused member is caressed and tickled from sheath to tip, buttoned up in the moist confines of the tentacle while it's plump and juicy lips are smacking against your balls.");

	outputText("\n\nYou tug two mouths back onto your sore breasts and press them onto your abused nipples.  They suck at once, even though your milk has long been exhausted.  The aphrodisiacs inside you morph the pain and pleasure into a syrup of ecstasy for your brain to drown in, and as tentacle after tentacle begins to erupt, you climax.   The cilia girding your maleness go crazy, which causes your jism to wrench free of your body with such force that your [hips] pop from your straining muscles and your horse-cock feels about to explode.  The interior floods with your dick-milk, traveling away through the vine in fat bulges.  Again and again you pulse, filling the vine with the same orgasmic squelching that the other tentacles use to fill your holes.  Seedy spunk slops onto your tits, into your pits, over your elbows, onto your knees, and drenches your feet.  Your whole body is a dripping, jizz-drenched wreck.  Your cunny is spasming, clenching, and sucking.  You scream as the tentacle withdraws from your mouth, suddenly muffled when it splatters you with a fat deposit of alabaster cream.");
	outputText("\n\nYou black out from the onslaught of pleasure - it's too much for your mere mortal brain to handle, and your mind shuts down.  It doesn't stop you from dreaming of sex for hours more, or from waking up a dripping wreck in the morning, soaked with vine-sperm and drained dry.");
	flags[kFLAGS.URTA_TENTACLE_RAPED] = 1;
	player.orgasm();
	dynStats("lib", 1, "sen", 1);
	menu();
	addButton(0,"Next",introSuccubiAndMinotaur);
}

//Mino & Succubi Intro*
private function introSuccubiAndMinotaur():void {
	clearOutput();
	outputText("After getting and departing your makeshift camp, the pendant begins to glow again.  It flickers dully, then goes dark.  Damn!  You turn and change direction, and thankfully, the light returns.  You can see forest ahead, and you advance, your path lit by the strengthening glow of Gul's magical amulet.");
	outputText("\n\nIn seconds, you're advancing through the dim forest, ignoring the gnarled oaks on either side, pendant in one hand, halberd in the other.  Each time the light dims, you change direction until the glow is restored.  Progress is slow, and twice you have to adjust your course to avoid tentacle beasts or worse, but you're confident that Taoth's old shrine is close by.  The air itself changes as you plunge deeper into the dark woods, becoming sinister and sickly sweet, thick with the cloying odor of corrupted plantlife and sexual juices.  Dick-shaped tentacles dangle from some of the trees.  Sometimes, they even grab at you, but you skillfully strike, severing them every time.");
	outputText("\n\nPushing through some bushes, you finally make it to a clearing, empty save for a monolithic stone structure and hedges of writhing tentacles.  Some of the tentacles have purple penis-tips, some sucking mouths, and others familiar flat tips.  You chop through the corrupt weeds without a second thought, too focused on what must be done to let them tempt you with their honeyed embrace.  Besides, you saw enough of that last night.  Your lusts are sated and controlled for a change.");

	outputText("\n\nOnce you've cleared a safe path to the doors, you wipe the sweat from your brow and advance, until a silken word titillates your ears, bringing you up short.");

	outputText("\n\n\"<i>Stop,</i>\" whispers the gauzy, lust-inflected voice of what can only be a succubus.  \"<i>Didn't anyone tell you that this place is home to demons?</i>\"");

	outputText("\n\nYou turn around to see the succubus walking out from around the side of the building, slick with tentacle juices.  She daintily dabs plant-seed from the corner of her mouth with a pinky while a hulking mass of muscle, horn, and aggression follows obediently behind her, secured by a chain attached to a leather collar around its neck.  It looks like a minotaur, but much, much bigger.  This isn't good!");

	outputText("\n\n\"<i>We don't abide trespassers, do we, pet?</i>\"  she coos.");

	outputText("\n\nA derisive snort answers, \"<i>Nope.</i>\"");
	outputText("\n\nThe succubus, reaches under the sperm-slathered loincloth the minotaur wears and collects a handful of old spunk, shuddering with delight as she consumes it.   \"<i>Do me a favor and subdue this one, would you?  If you do, I'll allow you to cum once in each of her holes, and maybe even in my backdoor.  Would you like that, Fido?</i>\"");

	outputText("\n\nThe minotaur groans, obviously pent up, and perhaps even enjoying being talked down to.  \"<i>Yes, Mistress.</i>\"");

	outputText("\n\n\"<i>Sic 'em, boy!</i>\" she screeches, dropping the chain.");

	outputText("\n\nThe minotaur lord thunders towards you, picking up the loose chain to use a weapon.  It's a fight!");

	//{start fight}
	kGAMECLASS.combat.clearStatuses(false);
	startCombat(new MinotaurLord());
}


//Minotaur Lord(C)*
//Attacks*
//Entangle*

//Cum Press*
//Requires PC be entangled by his whip first

//Drink Milk*
//Restores Mino's health, but raises his lust.
//Can only be used 3 times.

//Disarm Special attack*

//Mino Pre-Tease*"


//Urta submits to the minotaur - Alternate Loss via wait or cock press*
public function urtaSubmitsToMinotaurBadEnd():void {
	clearOutput();
	outputText("You mouth opens, drooling with hunger that you know only the sexy beast across from you can sate.");
	if (monster.findStatusEffect(StatusEffects.MinotaurEntangled) >= 0) outputText("   Seeing the fire in your eyes change from a determined glare to a lusty look, the minotaur pulls you over, carefully unwinding the chain from around you, so as not to damage you.");
	outputText("  Your once foe removes his loincloth to fully expose the mammoth between his legs, three feet long and nearly twice as girthy as your own.  You're so dazed by his imposing manhood, that you totally miss him flinging his loincloth at you.  It smacks wetly into your face, smothering you in his syrupy spooge.");
	outputText("\n\nFlopping down on your ass, tail swishing happily, you lap at the moist interior of the minotaur lord's only garment.  His constantly drooling cock has utterly soaked the fabric with his pre-cum.  It tastes and smells so strong, and you just can't get enough, humming happily as your tongue draws dollop after dollop into your greedy maw.  Your body shudders with each swallow, and your cock pulses below, rigid and fitfully flaring reflexively.");

	outputText("\n\n\"<i>Look at her, already cum drunk, and you haven't even fucked her yet, have you, pet?</i>\" a voice teases.  You don't care - you got what you want! Tangy, salty... mmmm... such nice cum.  You've licked most of the excess off by now, and you start sucking bunches of it into your mouth, anything to harvest the rest.  You need MORE.  It fills you with giggly, unreasonable glee - just what you want right now.");

	outputText("\n\n\"<i>May I have her, Mistress?</i>\" a gruff voice asks, fearfully.");

	outputText("\n\nA fairer, melodious tone answers, \"<i>Fido, how many times have I told you?  You are Fido, not 'I'.  You are not to use that word!</i>\"");

	outputText("\n\n\"<i>Fido is sorry,</i>\" Fido grumbles apologetically.");

	outputText("\n\nThe succubus pulls the cum-stained rag off your head, making you blink at the return of the harsh light.  Your fur is matted to you by the sticky, wasted pre-cum, already starting to dry.  You look up, open mouthed and hungry, holding your arms in front of you like a begging dog.  More!  You want more!");

	outputText("\n\n\"<i>She seems quite taken with you, Fido.  Yes, I suppose you can have her,</i>\" the demon declares.  She pats one of the minotaur's balls before he can move away.  \"<i>Just make sure there's enough left in this cumsack for me, okay?  I need my five-o-clock feeding.</i>\"");

	outputText("\n\nThe minotaur nods, tilting its large horns down deferentially.  Its mistress strains up to pat it affectionately on its bullish brow, and then, without another word, she prances off, carefree, towards the tentacles.  She throws herself into them with gusto, vanishing with a muffled moan of ecstasy.  The 'hedge' begins to move in a writing frenzy, dozens upon dozens of tendrils undulating and squirming over each other in their haste to play with their queen.");

	outputText("\n\nWith her gone, there's no competition for more cum!  'Fido' smiles down at you, a surprisingly benevolent expression for such a gigantic beast-man.  \"<i>You are hungry then?  I will feed you plenty.  You will make good slave for Mistress and I.  Come on, drink,</i>\" he commands, holding the cock-column in an easy, one-handed grip and waggling above you, spattering your body with his pre.  \"<i>We must get you in the mood.</i>\"");

	outputText("\n\nThe way that tantalizing scent and taste is fuzzing your brain, you think you're already in the mood.  Gleefully, you open your mouth and launch yourself upward, pressing your face into his downward-pointing flare.  At first, you're tempted to just cram your mouth into his cum-slit and jerk him off into your mouth, but a small part of your brain that still functions remembers that simple masturbation isn't enough to make a minotaur blow his load.  He needs something tight wrapped around it.  Still, a few 'drops' of pre the size of apples splatter into your open mouth, giving you the liquid courage you need for your next move.");

	outputText("\n\nYou open as wide as you can to try to suck him off, but it isn't enough.  The edges of his gigantic flare catch on your lips, and though they bow backward a little from the force of the attempt, they don't let you pop him inside.  A fresh spurt of his druggy jizz washes down your spunk-slicked esophagus, making your own horse-cock tingle pleasantly, so strongly that it spurts out streamers of wasted fox-cum.  Numb from your ruined, hands-free orgasm, you open wider, your jaw creaking, and press up.  This time, the minotaur's titanic girth slips into your mouth, sliding down your lubricated oral cavity with surprising ease once it gets inside.");

	outputText("\n\nThe minotaur roars, \"<i>That's more like it!  I'll have you broken-in in no time!</i>\"  He grabs you by the head and pushes you forward.  He's so... so strong!  You couldn't stop or slow him even if you wanted.  Like a passenger in your own body, you helplessly feel his cock forcing its way down your throat, thickening in pleasure as it plows its way into your gut.  You swear you feel the fat tip pop out the bottom of your esophagus, hanging freely in the top of your stomach.");

	outputText("\n\nIt starts to get warm.  Not just warm, but HOT.  You don't even notice that you can't breathe through that fat cock.  It has your throat sealed with its immense girth and the three even fatter rings that split up the middle, but it feels fine.  If anything, it feels good.  Gods, you're full!  You put your hands to your belly, and you feel it swelling, slowly rounding.  Bulges of cum distend your jaw, nearly breaking it before they rush down your ruined throat and into your gut.  Your vision swims, going double, pink-rimmed at the edges, and you're sure you'd fall down if your neck wasn't joined to this wonderful pleasure-tube.");

	outputText("\n\nIdly, your hands grope at your expanding middle, wondering just how full you're going to get.  He's such a big, big boy, and so virile!  You close your eyes and drift off, cradling your sperm-engorged abdomen in your hand.");

	//[Next]
	menu();
	addButton(0,"Next",submissiveMinoUrtaBadEndPtII);
}
private function submissiveMinoUrtaBadEndPtII():void {
	clearOutput();
	outputText("You wake up feeling so blissfully bloated and utterly full.  Memories of your encounter with the minotaur come streaming back.  You submitted to the beast, and it felt... it felt goood.  Your cunny clenches at the memory, and your rigid, oozing pole pulses needily below.  You burp, tasting the salty leavings in the back of your throat for the first time.  That was good!  Gradually, you become aware of a gentle forward and back motion, making your distended gut slosh and your tits sway pendulously.");

	outputText("\n\nYou look back and shiver excitedly.  While you were passed out, the minotaur lord must have changed positions and put his cock in your cunt!  With that knowledge, your heavily drugged brain gradually becomes aware of the exquisite ecstasy shooting through your stretched-out vagina.  You can feel him inside your womb, his fat head having long since pushed past whatever resistance your cervix could have offered.  The knowledge that this beast is utterly ruining your quim, demolishing your ability to take pleasure from any lesser lover, wars with the pleasure it brings.  Ultimately, your drug-dazed consciousness settles on wanting more.");

	outputText("\n\nGroping at your tits, you kneed your tender nipples eagerly, whorishly even.  The minotaur  easily holds you with a hand around your middle.  He seems to realize your wakeful state, and he swiftly forces his free thumb into your mouth, giving you a sweaty, furry pacifier to keep your noisy little mouth-hole busy.  With so much cum inside you, you lack the capacity to do anything but suck.  The offending digit is salty, just like a dick, and you fellate it as if was the source of your next meal, moaning into the minotaur's knuckle.");

	outputText("\n\n\"<i>Good bitch,</i>\" his deep voice rumbles, settling over your dopey form like a blanket.  \"<i>You're a natural born slut, aren't ya?</i>\"  You nod vigorously, mouth still occupied by the hefty thumb plugging it.  In an addled haze, you lash your tongue across his pheromone-soaked palm.  The scent is made all the stronger by the way you have to breathe - entirely through your sensitive, vulpine nose.  Why, if you had your wits about you, you'd probably realize that your keen senses are working against you here.  Instead, you dutifully suckle the beast's greasy digit, wiggling your hips lasciviously over the bliss-radiating boner.  Your gaping nether-lips are inflamed with passion and oozing out frequent beads of lust.  Your cock is only semi-hard and flopping about with each thrust you receive, sometimes smacking into the minotaur's balls with concussive, wet thwacks.  Your nipples are pebbly buttons, so hard they could have been smelted in Yvonne's forge.  All told, you're a horny, cum-drooling wreck, and that doesn't even begin to describe the lewd display going on south of your neck.");

	outputText("\n\nFuck, you can still taste his spent spooge clinging to your lips, so thick it may as well be a salt and creme geletin.  Spit froths at the edges of your mouth as the bloated dick inside you begins to pick up its pace.  Your legs go utterly limp, and you can feel your hips widening, permanently stretching into an obscene, brood-motherly expanse that's sure to give you an awkward, swaying gait.  You cum without any warning, explosively launching a rope of your meaningless fox and horse jizz into the puddle you've already made.  Again and again, you flood your own puddle with even more masculine secretions, diluted by the barest dribbles of your feminine fluid.  When it's over, you barely feel the usual satisfaction orgasm provides.  A burning need for more has replaced it, and as you rub your dick-stretched tummy, you know just what it'll take to sate it.");

	outputText("\n\nThe minotaur moans when you manage to lift your hindpaws up against his sack, mobilizing every ounce of self-control with one task in mind - squeezing the spunk out of those virile orbs so that you can taste it in your womb.  Maybe the giant hunk is even fertile enough to load you down with a few minotaur babies!  Gently, you kneed his heavy orbs while you're bounced to and fro, sucking and fucking, licking and creaming.  Your head feels like it's swimming in beast-cum, but you want to be drowning in it.  You want your mind so slathered in mino-jizz that it runs out your ears.  The balls quake underfoot, and their owner slams you down all the way to his hilt, a dong-shaped outline visibly distending your womb through your already swollen stomach.");

	outputText("\n\nThere's a titanic shifting of flesh along with a palpable widening of the flare within you.  It's so thick that it knots you more effectively than any dog could ever hope for, anchoring itself within your uterus just in time for the thick bulges of jism to stretch you wider as they travel down the beast's obscenely large urethra and past your poor, ruined cervix.  The gushing fluid splatters through your womb in a wave, rushing down each fallopian tube and plugging them tight.  An instant later, your birthing chamber is filled equally as well, and the excess squirts out around your lord and master's giant cock in pressurized jets.");

	outputText("\n\n\"<i>Too... goddamn... tight!!!</i>\" he howls, just prior to releasing a second blast of virile seed.  This time, your womb is already filled to capacity, and every ounce of baby-batter that's pumped inside you is answered by an equal amount spraying out of your cock-split twat.  You howl with him, though yours is lower and weaker, a half-hearted effort by a person so steeped in relaxing drug-spunk that orgasm is a trickling trail of white that doesn't even pulse - it just drools in heavy spatters to fall in the puddle below.  Rivers of unused jism too voluminous to fit inside you run down your tiny, barely spasming horse-cock in a white tide, enhancing the appearance of your own orgasm.  The rest of the backwash soaks the source of this wonderful drug from the waist down, slicking his fur white.");

	outputText("\n\nYou dimly entertain ideas of licking him clean while you slide face first into the accumulated sex-mud.  The puddle froths and bubbles from your struggles to rise, until eventually, a strong hand grabs you by the scruff of the neck and hauls you out bodily.");

	outputText("\n\n\"<i>Your first taste, huh?  Get used to it.</i>\"");

	outputText("\n\nThe minotaur tosses you back into the puddle, making sure you land on your side at the shallow edge.  Gasping for breath, you inhale more and more of that wonderful aroma, dreamingly sighing as more of it drips from your well-used gash.  The entrance to your vagina is permanently stretched, gaped wide just like 'Fido' would want it.  You dip your lips to drink of his bounty, crying a single tear when the word '" + player2.short + "' comes to mind and hoping you'll forget.");
	player.orgasm();

	//[Next]
	menu();
	addButton(0,"Next",submissiveMinoUrtaBadEndPtIII);
}

private function submissiveMinoUrtaBadEndPtIII():void {
	clearOutput();
	outputText("Naked save for the silver spiked colar around your throat, you dutifully follow your master and mistress.  Your cock bobs in front of you, tumescent and ready, but so long denied that you've grown accustomed to the ever-present lust your superiors incite in you.  One thing you can't get used to is the craving for Fido's cum.  You did learn his name is actually Krott, but to say such aloud would earn you a rather unpleasant whipping from your Mistress, and not the kind that leaves you smiling.  Regardless, your head is nauseatingly clear right now, and you'd do anything just to crawl under his loincloth and slurp down the tiniest fraction of his ballsack's bounty.");

	outputText("\n\nYou begin to walk closer and closer behind him, sniffing at his swaying, pre-soaked balls.  Just one lick...");

	outputText("\n\n\"<i>Stop, we're here,</i>\" your mistress commands, raising her hand in warning.");

	outputText("\n\nYou shake your head to clear it and look around to see just where 'here' is.  It's a village, a small one.  It doesn't look like one of the demons', at least not by the way Mistress is furrowing her brow, but neither is it one you learned of in your old life, the life before you learned your place in this world.  One by one, sheep-morphs peep their heads out of their doors and windows, looking to see just what fresh horror has visited their town.  Mistress smiles and relaxes at this - these people are incapable of harming her.");

	outputText("\n\nHer harmonious voice proclaims, \"<i>Good people, would any of you like to be slaves?</i>\"");

	outputText("\n\nSilence answers her.");

	outputText("\n\n\"<i>Very well then, but please reconsider.  See how happy my other slaves are performing even the lewdest acts of debauchery!  Watch them, and see what true bliss is!</i>\"");

	outputText("\n\nMistress pinches one of Fido's nipples cruelly, twisting it so hard it draws a pained moo from his mouth.  Of course, Fido loves pain-play, or else his cock wouldn't be fountaining semi-clear pre-cum, and he certainly wouldn't be jerking his hips like that.  She spins him around to face you and lets go, swatting his ass to spur him in your direction.  Squealing in excitement, you feel your cunt gushing similar amounts of lubricant.  You've been so much <b>wetter</b> ever since Mistress has started rewarding you by nursing you, though she seemed a little surprised when it made your cock bigger as well.");

	outputText("\n\nYou easily fist yourself as Fido clops over, first with one hand, then the other, and then, fueled by your newly discovered exhibitionism fetish, you pull your gaped lips even wider, putting the entirety of your birth canal on display to the simple farm-folk.  Inside, your equally stretched cervix clenches hungrily.  If only your master would hurry up!  A gasp goes up from the crowd when your horse-cock swells larger, smacking into the ground below, and you turn to look at them, each in turn, shouting, \"<i>Would any of you like to come fuck my whorish vixen-cunt?  Mistress will give you a nice fat cock, so you can stretch me even wider!  I'll be your obedient sperm-addicted cum-junkie too, just like I am for Maste-ERP!</i>\"");

	outputText("\n\nYour master plunges in with a powerful stroke, impaling you until his sheath is rubbing on yours and his sweaty fur is greasing your bubbly, squeezable rump.  He flexes his legs to rise up to his full height, and you're carried along with him, suspended on the iron-hard length of his dick.  Getting fucked by Fido stopped hurting by your second or third time with him.  Now, the only pain mounting him gives you is the incredible anticipation you're forced to endure while you await your next fix.  His pre-cum is already bubbling today, slicking your inner walls with warm, mind-fogging excitement.  You giggle, laying back against his chest, reaching down to grab your tremendous boner in both hands and pull it up too, right between your tits.  The flare smacks into the side of your face, whetting your fur as you call, \"<i>Come on, don't any of you want to ride this perfect, fat cock!?  Or do I need to suck all my cum down like the addict that I am?</i>\"");

	outputText("\n\nMistress's tail spears into your ass, rubbing on the walls of your prostate for encouragement.  \"<i>That's it pets, keep at it,</i>\" she whispers into your ear, her breath tickling with the sinful promises only a succubus can embed into her very exhalations.  You moan, sucking your tip into your mouth immediately and drinking deeply of your own essence.  Fido grabs you by the ass and begins to lift and drop you, over and over, setting you bouncing on his tool, fellating yourself, and titfucking your equine dong all at once.");

	outputText("\n\nFido is twitching inside you already, and watching the blushing faces of the villagers, your own meat begins to thicken with budding need.  When you see a woman groping her tit, it nearly sends you over the edge.  This is the life...");

	outputText("\n\n<b>Some Time Later</b>");

	outputText("\n\nYou return to the temple with your Mistress and Master, followed by a trail of a half dozen sheep-slaves.  They're every bit as meek as you'd expect, and their milk is delightful.  Unfortunately, you find yourself needing to drink from Fido and Mistress more often to make the nightmares go away.  It's easier to forget.");
	//{Bad end or Urta removed from game as appropriate}
	flags[kFLAGS.URTA_MINO_AND_SUCCUBI_SLAVE] = 1;
	menu();
	addButton(0,"Next",urtaGameOver);
}

//Urta Win Rapes Minotaur*
public function winRapeAMinoLordAsUrta():void {
	clearOutput();
	outputText("Exulting in your victory, you quickly undress, barely paying heed to the ");
	if (monster.lust >= monster.eMaxLust()) outputText("lusty");
	else outputText("pained");

	outputText(" moos coming from your defeated foe.  Thankfully, the straps on your armor don't give you much trouble today, and you're able to slip out of your gear in short order.  That's a pleasant blessing given how hard your horse-cock was getting just prior to being granted freedom from your weighty, armored skirt.  There's something to be said for felling your foes and standing over them, naked, victorious, and ready to ravage their anuses.");
	outputText("\n\nYou give the succubus a warning glare and shout, \"<i>This cow's ass is mine, bitch.  Once I bust a load in him, you're next!</i>\"");

	outputText("\n\n\"<i>Wear yourself out all you like,</i>\" the succubus taunts, drinking milk from a glass she's holding with her demonic tail.  \"<i>I always was something of a voyeur, and after all, dinner is best served with a show.</i>\"");

	outputText("\n\nWhatever.  You circle around her butch pet and lift his tail, observing the eager sloshing of his overfull gonads.  This cunt must not milk him very often.  It's a shame you don't intend to either - minotaur cum is dangerous stuff, and you're going to make sure you get off without getting hooked on that sinfully delicious... fragrant... yummy... stuff.  You shake your head to clear out the insidious thoughts and heft your own weighty cock in hand.  It may not be as massive as the minotaur's, but it's more than big enough to make him walk bow-legged for a week.");

	outputText("\n\nYou lift the beast-man's well-muscled ass up in the air and line your equine fuck-meat up with his winking asshole.  From the looks of it, the horny submissive hasn't taken anything up there.  He's still clenched super tight, and the puckered ring shows no signs of stretching.  You cast a malicious gaze towards the succubus (who's now stroking her palm across her oozing gash) and press your wobbling, quickly filling animal dong into the furry butt-cleavage.  The tight entrance refuses to admit your flare in spite of your insistent anal advances!");

	outputText("\n\nScowling, you glance towards the Succubus, who's taken to pinching a nipple so as to refill her emptied glass.  Of course, she's also got three fingers knuckle-deep in her gaping succubi-snatch.  Looking at the enticing entrance, you can't help but feel that your cock would feel better inside her, but to go there now would be to give her exactly what she wants, and you'd likely wind up on a chain as well.");

	outputText("\n\nYou do the only thing you can think to do - you begin to jerk yourself off, right into the minotaur lord's asshole.  At first, the only thing that changes is the increasing rigidity of your tumescent dong.  However, as you fantasize about blowing that dark star into a glossy fuck-furrow, a familiar, warm fluid begins to leak from your tip.  You do your best to smear it all over the muscle-bound sphincter, pausing to press against it from time to time and check its give.  After one particularly potent smear of your lubricating juices, you find his entrance dilating, and your massive beast-cock pops inside, half the flare at a time.");

	outputText("\n\n\"<i>Mooo!</i>\" the minotaur, 'Fido,' exclaims in dismay.  You snicker and smack his ass while you burrow your cock deeper.  He's a submissive fuck-pet anyway, if he didn't want to get fucked in the ass, he shouldn't have pranced around on a succubi's leash and dropped like a sack of bricks when you looked at him.  You get as far as your medial ring before hitting something inside him.  Something rounded and soft, with just a little bit of give.  When you push on it, a liquid weight shifts and pushes back.  Is that his prostate?  It's huge!");

	outputText("\n\nYou pat the small of his back while glancing at his mistress. \"<i>Fido, I'm going to make you cum harder than your mistress ever could.</i>");

	outputText("\n\nThe tainted milk-slut frowns, but does not slow her masturbation.  Even now, her spaded tail continues to feed itself into her asshole, and her fingers have not stopped their relentless teases.  She's an expert at teasing her body.  The spreading blush leaves no doubt about that.");

	outputText("\n\nYou resume your steady push, easily compressing the bull's soft internal organ with your blunt cock-hammer.  He shifts slightly, but holds still when you grab his tail for leverage and push harder.  His prostate bows under the pressure.  Then, when it's almost painful to keep thrusting, it gives, letting you ram four inches inside in seconds.  He pants, his voice high-pitched.  You can definitely feel his asshole clenching from that, and what's more, you can hear a torrent of fluid spraying from his cock-tip.");

	outputText("\n\n\"<i>Ride that bull, girl,</i>\" the succubus cheers, surprisingly encouragingly.  You glance her way to see why, and are greeted by a view of a virtual waterfall of lubricant, gushing from between her thighs.  She's on the very cusp of orgasm, holding herself back for the eventual climax to this show.");

	outputText("\n\nThe puddle that reaches your toes is clear, a signal that the muscle-bound subbie below hasn't actually cum yet.  Grunting, you force yourself the rest of the way in.  His behind is tight and strong, squeezing down from you on all sides, and his overinflated prostate is like a snug hand cradling the sensitive underside of your horse-dong and its proud, prominent cum-vein.  Once your sheath is kissing up on his tender anus, you scratch the minotaur's back affectionately, feeling a little friendly now that your cock is getting squeezed by his instinctive clenches.  You've no doubt that you could probably sit like this and just let him squeeze you until you both blew loads big enough to flood a Tel'Adrian side-street.");

	outputText("\n\nYou decide to hurry up the action, less the corrupt slut on the other side of the pet bull get any ideas.  Dragging your hips back, you pop your tip past his prostate and then thrust into it again.  This time, it compresses a little more easily, giving into your anal abuse with ease.  You're able to complete a nice, slow stroke without too much fuss, so you pick up the pace a little more.  This time, you hit his prostate hard enough to make him gush again, and you begin to bounce your hips to and fro long before his squirt has finished.  His hot little asshole is making your cock shiver with warm twinges of bliss.  You fuck him harder and harder, going hog wild on this big, submissive bull.  He's moaning loudly, for all the clearing to hear, and his mistress joins him, clearly enjoying his debasement.");

	outputText("\n\nYou wrench the minotaur lord's tail around your sheath and squeeze it tight, causing the rest of your length to swell a little bigger, a little tighter, and a little more sensitive inside him.  It's enough to send you careening over the edge, and you pull back far enough to let the first blast wash over his prostate, pounding it with a salty load as big as most men's entire orgasm.  With your target marked, you resume your thrusting, angling down to better stab at the offending organ while you cream the minotaur's asshole, alternatively stuffing his passage and milking him dry with the same back-and-forth motions.");

	outputText("\n\n\"<i>Cumming, Mistress!</i>\" he bellows, looking over his shoulder at you with his tongue hanging out.  It seems he's rather taken with you, and if the noisy ejaculatory noises erupting from his cock are any indication, his dick loves you too, even though you didn't touch it.  You seem to recall that minotaurs have difficulty cumming without something tight on their dicks.  Perhaps a little pegging is all they need to settle them down.  Pounding him a few last times to let your balls finish draining, you sigh in satisfaction.  This bitch-boy is one tight fuck!");

	outputText("\n\nWhen you pull out, the three-inch wide gape and river of horse-cum draining out of his ass makes him look a little less tight.  Well, you hope the succubus didn't have any plans for his ass - it'll likely never forget your dick.");

	outputText("\n\nThe minotaur lord collapses into a puddle of his own spunk, reaching a fat finger to probe at his oozing anus.  It seems he liked it a lot.");

	outputText("\n\nYou hurriedly re-dress and turn to the succubus, who has finished masturbating, and you get your first real chance to properly inspect her...");
	flags[kFLAGS.URTA_RAPED_MINO_LORD] = 1;
	//[End combat, queue post encounter]
	player.orgasm();
	menu();
	addButton(0,"Next",beatMinoLordOnToSuccubi);
}

//Urta Loses Minotaur
public function urtaLosesToMinotaurRoughVersion():void {
	clearOutput();
	outputText("You collapse to your knees, too ");
	if (player.HP < 1) outputText("battered and bruised");
	else outputText("weak from lust");
	outputText(" to continue fighting.  The hulking bull-man snorts as he approaches you, ");
	if (monster.lust < 70) outputText("barely deigning to give your far smaller cock a contemptuous look, ");
	outputText("before he reaches down to grab you.  From somewhere deep inside of you, you manage to draw up one last dredge of resistance, and you promptly snap your teeth shut on his hairy arm.  A tiny part of you feels ashamed at reverting to such primitive behavior, but practicality trumps sentiment on this occasion.  He growls angrily and shakes his arm, trying to send you flying, but fails; you just bite him harder and harder with each shake, until the thick, coppery tang of blood floods your tongue... and makes your belly reel and roil, causing you to feel sicker than that time you tried to eat three bowls of canine pepper salsa with extra peppers in a single sitting (you were drunk then, in your defense).  You try to fight it off, but you can't escape, and instead you let go of your assailant's arm, the motion hurling you to the ground, where you retch and gag... how could you have forgotten that minotaur blood can transform other people into minotaurs?  Or your own adverse reaction to transformation items?");

	outputText("\n\nThe minotaur doesn't seem to mind the blood dripping down his form as he advances on you, cuffing the side of your head for your impertinence.  His strike is strong enough to send stars careening through your field of view, dazing you badly enough that you momentarily forget where you are.  You would tumble to the ground from your failing balance if it wasn't for the strong, shaggy hand grabbing hold of you by the shoulder.");

	outputText("\n\nThe minotaur's gravelly voice rolls through your ears.  \"<i>Bite here and you die, cunt.</i>\"  Then, his sweaty fingers are in your mouth, prying your jaw open.  A thick, musky scent assaults your sensitive vulpine nose, so potent that it sets your head spinning for a whole other set of reasons.  Still tasting his blood and sweat on your tongue, the fat digit exits your maw, immediately replaced by a gigantic, jaw-stretching bulk.  It's so fat and swollen that for a second, you don't think the minotaur will be able to cram it in.  You're proven wrong when he grabs your hair and twists your head back without care for the pain it causes you, opening your throat and further straining your jaw against the blunt tip.  It pops in a second later, pulsating hotly in your mouth, heavy veins bloating and thrumming against your tongue with each powerful beat of the beast's immense heart.");

	outputText("\n\nHe savagely yanks you upward, not even bothering to thrust his hips forwards, so assured of his dominance that he'd rather use your throat like a toy than mate with your mouth.  The immense minotaur member brushes the back of your throat and arcs downward slightly.  It snakes through your poor esophagus without care, the gigantic head distorting your defeated throat with its bestial shape.  You gurgle, spit frothing around the minotaur-cock when the first ring of prepuce slides into your gullet.  The second stretches your lips back, and you look on the third with dread.  Behind it all, the minotaur has taken to rubbing his sack, smearing the sweat he worked up during the fight all over, and letting out pleased little 'moo's each time his cock slips a little deeper.");

	outputText("\n\nHis dick lets out a messy spurt of druggy pre-seed that hits your somewhat-empty belly with concussive force, actually distending your midriff for a split-second and releasing an audible burble.  The beast-man snorts, \"<i>Nice throat for a bitch.  Most can't take it.</i>\"  He keeps lifting you while he talks, and soon that third ring is sliding across your slick tongue.  Dick-drippings splatter wetly into your gut with each passing second, at least providing a pleasant numbness to dull away the pain in your aching noggin, sore throat, and upset belly.  You never thought you'd be thankful to be taking gigantic loads of minotaur pre-cum inside, but right now, you'll take what relief you can get.  He pulls you up the rest of the way, your jaw stretched painfully, muscles so sore you worry they'll ache for weeks, and his balls come to rest against your tits while his sheath bunches up over your nose.");

	outputText("\n\nThe big bull holds you against him, filling you with his scent, his meat, and his dripping love-juices.  Then, after a moment of him simply enjoying your tight noise-hole, he pulls you off, until his tightly-compressed flare is about to pop free of your well-abused throat.  He yanks you up his length, plunging his entire length back into your neck-pussy, ruthlessly beginning to fuck you like an old toy.  He's so rough that you feel like he's going to tear you apart and toss you aside, a toy fit for a single use that should then be discarded.  Looking him in the eye though, all you see is excitement, and you have to admit, your body is responding to his pheromones and fluids in a powerful way.");

	outputText("\n\nYour member rose up a few moments ago, slapping audibly into your belly, smearing a trickle of your impotent seed over the powerful bull's bigger, infinitely more virile sack.   He laughs cruelly as he savagely fucks you, moaning in excitement.  In and out, his flare and prepuce scrapes your throat raw.  It would be unbearable if it wasn't for his sloppy pre dripping over everything, shrouding you in slick, wet aphrodisiac. Your head is buzzing from the drug-aided feel of submitting to such a powerful male and something else... something primal that's been building inside you this whole time.  You don't have long to ponder it, as the massive dick swells larger inside you, reaching toward an unavoidable peak thanks to your throats clinging, squeezing tightness - exactly what this bull wanted.");

	outputText("\n\nA loud, deep, bellowing moo echoes through the clearing, and he cums, swelling thicker, wide enough to make your jaw creak, painfully.  Your eyes water as you gulp and swallow, grateful for the pain-numbing properties of his thick ejaculate.  You fill with warmth, and after a moment, you realize swallowing isn't really doing you any good - he's so deep that his dick has turned into a tummy inseminating spooge-dispenser, carrying the voluminous waves of jizz down into your stomach whether you want it or not.  He cums like a firehose, rounding your belly, absolutely flooding you with potent seed.  Your eyes wildly roll, your body suddenly dealing with a massive influx of lust-increasing aphrodisiacs and unable to release for some reason.  Your dick feels good leaking everywhere... but you need something more.");

	outputText("\n\nPushing you off, the minotaur lord, 'Fido', dumps a few last spurts of semen onto your prone, lust-wracked body, marking you with his sticky gunk.   He sighs with relief, his balls noticeably smaller, but still clearly packing quite a few more plus-sized loads.   \"<i>Good foreplay,</i>\" he chuckles, slapping your snout a few times with his still semi-rigid tool for good measure.");

	outputText("\n\nYou don't hear him, though; all you can hear is the gurgling of your belly, and the thunderous beating of your heart.  Warmth, strange and strong and pure, begins to emanate from your distended guts, suffusing you with the most delicious sensation.  You... you can't really describe it; you just feel sooo good...  You close your eyes, arch your back and moan as the warmth spreads through your limbs, writhing in your veins, itching under your skin. Your loins burn; cock pulsing and throbbing, balls clenching and losing, cunt flexing and squeezing.  You claw at the air with fingers that seem to throb, as if your nails are being pulled on, gritting your jaw so hard your teeth grind and clack against each other.  You feel constrained, as if something's holding you down, and you wriggle and thrash, clawing at yourself until, with sounds that a distant part of you registers as leather tearing and steel parting, blessed release washes over you.  You fall to your knees and stretch, feeling the warmth slowly dissipate and leaving you feel refreshed and renewed.  Slowly, you open your eyes and push yourself upright.");

	outputText("\n\nThe minotaur is staring at you in shock, and you quickly realize why; standing up, you're now easily two feet taller than he is.  Though your proportions have perversely remained feminine and supple, you can <i>feel</i> the strength coursing through your muscles, the raw might in each flex of your sinews.  Your proud bosom has swollen the equivalent of several cup-sizes, and your once comparatively humble cock has stretched and swollen into a monstrous equine shaft easily comparable to your assailant's - in fact, you dimly realize that you now have <i>two</i> such cocks throbbing before you, dripping orange-sized beads of precum from their flared tips, fuelled by balls the size of basketballs - indeed, a weight at your groin makes it apparent you're now carrying around a second pair of balls to feed your second dick.  You flex your fingers, knife-like claws glinting in the light, and grin hungrily, feeling your tongue flick against an array of primeval fangs.  Your mind burns with a single drive, consumed by a hunger that demands satiation.");

	outputText("\n\n\"<i>Urta wants to <b>FUCK</b>!</i>\" you roar before grinning and approaching your first victim.  The minotaur looks up at you; standing his ground against you, he swings his heavy chains at you, intent on reining you in for his mistress.  Unfortunately for the brutish lord, your newly transformed self is far stronger than he is.  All it takes to disarm your enemy is a quick grab and a fierce tug.  Your hand grips the chain rightly as you rip the powerful minotaur forward, the relatively large beastman admirably unwilling to let his weapon go, a futile effort about your new form.  Under your ferocious strength, you pull him down and force him to his knees.  With a sinister grin you speak, taunting the formerly dominant lord with his own words, \"<i> Bite here and you die...</i>\"  Thrusting your wide hips forward, you slap 'Fido' across the face with your mammoth horse-cock, a thick hot dollop of pre-cum splatting wetly against him and soaking his face in your musky juice.");
	outputText("\n\nGrabbing hold of his face, you pry his mouth open before stuffing his gob full of throbbing horse-meat.  Flashing a cruel, predatory grin, you brush your knife-like claws against his face to ensure he acts like a good boy and sucks you off.  Taking hold of a fistful of his fur, you shove the fat aching length of your pre-soaked shaft into his mouth and throat, forcing the minotaur to blow you just as he made you.  With a shiver of pleasure, you don't wait a moment to indulge yourself, forcing more and more of your throbbing mass down his throat, the sheer thickness of your new endowments bulging his already thick neck.  Tensing your dense, powerful muscles you thrust forward, feverishly fucking the bullman's face with one of your twin spears, the other spitting and drooling great globs of vicious pre down his back.");

	outputText("\n\nFrom her perch atop a fallen pillar, the succu-cow watches with a strange mix of desire to play with such a fearsome creature, concern that your furious power would overwhelm her, and curiosity as to why you transformed so strangely.  You lick your lips as you look her up and down, your mind filling the perverse fantasies of how you're going to rut and breed that curvy bitch.  The primal instinct to sate yourself with that voluptuous cow-girl body of hers drives your lust higher and higher, your hips bucking and facefucking the unfortunate recipient of your hunger.");

	outputText("\n\nGritting your teeth and growing, you can't hold out for much longer, the sweet pressure building and building inside your titanic balls until the skin is tight over the big bloated orbs.  With just a few more brutal thrusts, your lust filled mind reels and fills with the ecstasy of your earth-shaking orgasm.  The massive cum-tanks between your legs clench and shift as they discharge their geyser-like streams of spunk into and onto your beaten, cock-sucking victim.  Under such a mighty, thirst-quenching flow, the minotaur lord's muscled gut quickly starts to round out, and more and more musky dick-milk is crammed into his belly.  Without such a accomodating vessel to fill, your second spewing stallion-prick blows its load all over his matted fur.  The potent streams even arch onto the cold, stone floor and quickly pool around your feet.  You continue to pump even more creamy gouts of sterile seed into your sticky cum drenched victim without pause.");

	outputText("\n\nFor well over a few minutes you continue to cum with the fallen minotaur.   Roughly pulling your still-spurting column from the beastman's mouth, you grab hold of your twin dicks and pump them hard, masterbating to soak him in your alabaster spunk.  Finally, the tremendous orgasm ends, the fallen lord painted completely white with your seed, his once-muscular stomach completely rounded by the sheer amount of sperm you stuffed him with.");

	outputText("\n\nLicking your chops with hunger, you look up at the succubus you had been watching, your sexual appetite still not satisfied.  Letting out a growl, you lock your eyes on the succu-cow.  \"<i>Urta wants to <b>BREED</b>!</i>\" you howl before stepping toward your next target.");
	player.orgasm();
	dynStats("lib", 50, "sen", 50);
	flags[kFLAGS.URTA_IS_VULQUINE_MENACE] = 1;
	menu();
	addButton(0,"Next",urtaSheHulkPartII);
}

private function urtaSheHulkPartII():void {
	clearOutput();
	outputText("<i>\"My my, aren't you an interesting creature... wouldn't you be interested in becoming my pet?  You would be above that sorry excuse of a brute and get all the cock and milk you could ever want,</i>\"  she smiles seductively at you, getting up from her seated position.  \"<i>I want to take a look at that fascinating body of yours.  Wouldn't submitting be better than fighting?  You'll get to taste this perfect body of mine,</i>\" she says, shifting into a seductive pose, showing off the wide, voluptuous curves of her body.  Unfortunately for her, her words go right over your head; the only thoughts in your mind are how you're going to fuck and breed this curvy whore into a perfect little cocksleeve.");
	outputText("\n\nPulling her whip up, the succubus snaps it like a lion tamer, grinning as you recoil from a strike on your cheek.  You growl and lunge at your prey, disregarding her whips as nothing more than weak little bug bites against your brutal new form.  The sneaky demon is fast, however, quickly jumping out of the way as you barrel into the pillar she had been sitting on.  You recover quickly - too quickly for her.  Reaching up, you grab ahold of the succubus' soft, womanly leg and pull her back down.  Your curvaceous prey lands right on your belly, letting out a groan of dismay, her face planted right onto one of the flat, pre-soaked flares that crown your cocks.  The poor demon's face is completely caked in your new pheromone-packed fluids, more powerful than even that of the minotaur lord.  The much desired demon proves unable to even fight against the scent and taste that floods her nose and mouth.");
	outputText("\n\nPulling her down off you, you're about to just pin her to the ground and claim your prize when she rises up on her hooves and approaches you, face wet with your smelly juices and a fierce blush on her face. She licks her lips clean of your syrupy, druggy lube.  The potent pre-spunk seems to have gone right to her head.  Her empty, vacant eyes make it clear she's dipped into a lusty stupor.  \"<i>Ohhhh... gimme more of that sweet stuff,</i>\" she begs, grabbing hold of one of your dicks, eagerly licking and sucking at its hot, throbbing flesh.  Under the sudden sensual attention, your towering spire of equine endowment lurches and spits a great, glob of thick, oily pre forth, the goopy gout landing right in the cock-hungry bitch's open mouth.  The sight of her happily gulping down your slippery offering as if it was the sweetest honey is too much for your lust-driven mind.  With a snarl of hunger, you lunge forward and grab the needy bitch, pushing her to the ground and grinding your two proud pricks against her body.");
	outputText("\n\nNot wanting to wait a moment more, you grip her thick thighs and spread them wide.  Pinning her to the ground, you align your aching stallions with her slippery snatch and waiting anus.  Your 'victim' looks up at you with lust glazed eyes, about to speak.  You interrupt by suddenly plunging into her accommodating body.  The horny demon bleats with pleasure and pain, wriggling around you as you spear both of your tremendous, bitch-taming lengths into her hot, hungery form.  You grip her hard and plunge yourself full-force into your 'lover', stretching her holes wide around your great, girthy members.  Ramming yourself home into the demon cow, you slide yourself balls deep into her well used body.");
	outputText("\n\nIn some small part of your newly feral mind, you laugh at how stretched the succubus' body is, at how many times she must have taken her pet's massive bull-cock.  Grunting and growling down at your cock-stuffed bitch, you roughly grab one of her jiggling teats, creamy streams of milk jetting from her four hard nipples.  You tighten your grip even more, gritting your teeth as you buck harder and faster into the woman's welcoming body. With each brutal thrust, her ample flesh wobbles, her body bouncing and shaking enticingly.  Blind to the rest of the world, you don't bother to notice the sounds coming from behind you.  The fallen, raped minotaur lord groans as his cum-caked body starts to change under the effects of your new seed.  The beastman's body convulses, his body shuddering as it shrinks, molding itself into a more feminine looking form, its dark fur turning grey.");

	outputText("\n\nNot paying any kind of attention to the transformation behind you, you continue to violate the willing and ever-so-eager woman beneath you.  You thrust harder and faster, growling and grunting with insatiable lust.  With each brutal buck, your four massive balls slam against her body, jostling her with the might of your huge cum-tanks.  You get closer and closer to your next climactic finish, every instinct screaming to cream this demon's body and stuff her utterly, to drench her writhing form in your transformative cum.  Your bloated nuts are already prepared to completely fill every nook and cranny in this whore's body with the shreer amount of your seed.");
	outputText("\n\nFaster and faster, harder and harder, you ram your hips against hers, screwing the cow-slut more totally than any fuck she's ever felt.  Her screams of mind-bending ecstasy fill the air, her eyes empty, her hands roaming over her own body, squeezing her massive, milky mammaries before running over the bulge in her belly, her womb already filled with what must be a gallon of narcotic pre-cum.  She's drenched in sweat, her curvaceous body glossy from her lusty passions, thighs and ample ass caked in her own arousal and your vicious offerings.  Finally, you tighten your grip on her and howl in pleasure, your humongous quads lurching and clenching powerfully as they unleash the tidal wave that is your climax.  The twin cum-hoses that run the length of your brutal battering rams bulge with the sheer quantity of seed flowing through them.  The first thick shot squeezes into her body just as she cries out in orgasmic delight, her stomach swelling as her womb and guts are packed full of frothy spunk.");
	outputText("\n\nMore and more of your sterile seed fills her body, each pussy packing pulse forcing liters of jizz into her cavernous body and making her belly bloat, rounded out into a massive cum-baby.  Even with her body already so full, you don't stop - you can't stop.  Thick gouts of cum squirt from the squeezing connection between cock and cunt, your sperm filled spunk injecting itself deeper and deeper inside her ass and body until it gushes forth from her mouth in thick, creamy gushes.  With her body filled to bursting, you finally pull your still erupting cocks from her body, mind compelled to finish off the woman properly.  Taking both cum-cannons in hand, you pump them hard, squeezing out pasty ropes, each milky burst splattering across her body until her purple form has been painted ivory.");
	outputText("\n\nFinally, after what feels like the longest orgasm you've ever felt, it finally ends, your lover's body filled to bursting and soaked to the bone in your sperm, the drug filled spunk seeping into every pore and cell of her body.  It replaces that nasty addiction to minotaur seed with a craving for your own.  As you sit to rest for a moment, you realize you already want more.  You want to fuck another willing (or unwilling) body with your potent seed.  Your primal mind is taken from its fantasies when the succubus suddenly convulses, transforming before your very eyes into a far more dangerous form.  From how drenched she is, you can't tell precisely what's becoming of her, her body seeming more vulpine in appearance with every passing second, while her hips and breasts stay the same.  A new addition grows on her body, sprouting from between her loins.  A great, bitch-taming, equine cock sprouts from between her legs along with a pair of huge balls, swelling to the size of cantaloupes.");
	outputText("\n\nBy the time it's over, you realize the demon has become a miniature version of yourself...  The only difference besides size is that a long, thin spaded tail protrudes from her lower back.  Despite this, your feral mind cares little for the implications of such a transformation, hungering only for food and another good, hard fuck.  Turning your attention to the minotaur from before, you find that he too has transformed, a good couple feet smaller then he was before.  He is now a she, albeit with a huge stallion-prick jutting from between <b>HER</b> voluptuous hips.  Like the demon, this body looks to be a smaller version of yours, the difference on this one being a pair of horns growing from her sticky, spunk-soaked head.");
	outputText("\n\nShaking off any higher inquiries, you set your gaze upon the two herms, your pricks aching to be sheathed within their tight, warm bodies.  As if sensing your hunger, the two perk up, eagerly coming to your side to worship your cocks and balls with their tongues, anxious to get at the hyper-addictive sperm within your already swelling sack.  Somewhere deep in the recesses of your mind, a tiny voice cries out at the terrible fate you have met.");
	player.orgasm();
	dynStats("lib", 50, "sen", 50);
	menu();
	addButton(0,"Next",urtaGameOver);
}


//Post-Encounter*
public function beatMinoLordOnToSuccubi():void {
	clearOutput();
	outputText("The succubus claps slowly as she gets up from her perch on a ruined column.  \"<i>I'm impressed.</i>\"  She says, stepping in the light as she walks towards you.  You gasp, this succubus looks like a cow!");
	outputText("\n\nShe is tall, standing at about seven feet high, and her hugely voluptuous form makes you blush.  She has breasts three times the size of her head, tipped with a cluster of four obscene, teat-like nipples, each one leaking milk down her huge mounds.   Her hips flare out into an exaggerated hourglass shape, and a long tail tipped with a fleshy spade waves across her spankable butt.  A small cowbell is tied at the base of the spade with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks cow-like ears to either side whilst sashaying from side to side on her demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her right eye.");

	outputText("\n\nIn her hands, you spot a leather whip, and you idly wonder if this is what she's been using to domesticate that brute of a minotaur she calls a pet.");

	outputText("\n\n\"<i>What's the problem, dear?  Am I that alluring that you can't help but ogle?</i>\"  She makes a pose, blowing you a lecherous kiss.");

	outputText("\n\n\"<i>Hardly,</i>\" you retort, \"<i>I just didn't realize demonification worked on dairy cows.</i>\"");

	outputText("\n\nThe succubus scowls for an instant, but quickly collects herself and says, \"<i>My... my... if you aren't a capable fighter.  I never thought Fido, my pet, could be beaten.  Impressive.</i>\"  She sashays as she circles you, looking you over.  \"<i>Quite an eyeful too... tell me foxy, wouldn't you be interested in becoming my pet as well?  You would be above that sorry excuse of a brute and get all the cock and milk you could ever want.</i>\"  She smiles seductively at you.");

	outputText("\n\n\"<i>Not a chance,</i>\" you retort.  \"<i>Now move aside.</i>\"");

	//{If Urta raped Fido:}
	if (flags[kFLAGS.URTA_RAPED_MINO_LORD] > 0) {
		outputText("\n\n\"<i>Why so reluctant my dear?  You didn't seem to mind when you were fucking my pet earlier, so why refuse now?</i>\"  She sucks on a finger tantalisingly.");

		outputText("\n\nYou laugh your bitterest laugh.  \"<i>Him?  Only because I was desperately horny - I wouldn't fuck him with the end of this halberd otherwise, and the same goes for you.</i>\"");
	}
	outputText("\n\n\"<i>We'll see how your tune changes when you're licking my heels and begging for a drop of my milk!</i>\"  She snaps her whip angrily.");

	outputText("\n\n<b>It's a fight!</b>");
	kGAMECLASS.combat.clearStatuses(false);
	player.setWeapon(weapons.URTAHLB);
	//player.weapon = weapons.URTAHLB;
	startCombat(new MilkySuccubus(),true);
}


//Attacks

//Aphrodisiac Milk Spray*

//Tick Message:
public function milkyUrtaTic():void {
	outputText("Your body heats up with the effects of the succubus-cow milk...  ");
	if (player.lust < 50) outputText("Thankfully it hasn't become too distracting yet.");
	else if (player.lust < 75) outputText("You don't know how much longer you'll be able to withstand the effects of the milk.");
	else outputText("Those orbs full of milky goodness are starting to look more attractive by the minute... if you don't finish this quickly you might end up giving up!");
	outputText("\n\n");
	player.addStatusValue(StatusEffects.MilkyUrta,1,-1);
	if (player.statusEffectv1(StatusEffects.MilkyUrta) <= 0) player.removeStatusEffect(StatusEffects.MilkyUrta);
	dynStats("lus", 10);
}

//Drink Bottle of Mino Cum*

//magic-Enhanced Seduce

//Urta Wins*
public function urtaBeatsUpCowcubi():void {
	clearOutput();
	//HP:
	if (monster.HP < 1) {
		outputText("The succubus trips and falls on her face, dropping her whip at your feet.  You quickly take her whip and use it to bind her hands behind her back.");
		outputText("\n\n\"<i>Oh, bondage... now you're getting me worked up,</i>\" she laughs and looks up at you seductively.");
		outputText("\n\n\"<i>Breathing gets you worked up,</i>\" is your flatly intoned reply.");
	}
	//Lust:
	else {
		outputText("The succubus drops her whip and begins masturbating furiously, jilling her dripping cunt with abandon.  You quickly run towards her, planting your foot on her back and sending her tumbling on her face, then you use her whip to bind her hands behind her back.");
		outputText("\n\n\"<i>Oh, come on!  I wasn't even going to attack you!  I just want to cum... unless... does this means you'll be wanting to have some fun?</i>\" she asks with a seductive smile.");
		outputText("\n\n\"<i>Maybe I do... though whether I want fun with you is another matter,</i>\" you reply, doing your best to be cryptic.");
	}

	outputText("\n\nYou take a deep breath of relief at taking out both the succubus-cow and her pet minotaur... which proves to be a mistake, since the air is saturated with pheromones from the cow's milk and minotaur's cum.  You can't help but groan as you feel your loins burn with desire.  Demon or not, the woman kneeling before you is extraordinarily attractive; those huge full breasts - you've never seen a woman that busty before - and that gloriously squeezable ass...  If she keeps a minotaur as a fucktoy, then surely she has to be loose enough to take even your king-sized cock; the waterfall of lubricant drooling out of her cunt seems to whisper to you, begging you to fill her full of your cum.");

	outputText("\n\nIt's risky, but... surely one fuck can't hurt?  You do want to be faithful to " + player2.short + ", you do, but " + player2.mf("he","she") + "'s not here, is " + player2.mf("he","she") + "?  Still, you're sure you can be strong and leave it, you do have the willpower... oh, but the temptation...");
	dynStats("lus", 40, "resisted", false);
	//[Leave] [Fuck]
	menu();
	addButton(0,"Fuck",fuckTheCowCubi);
	addButton(1,"Leave",leaveTheCowCubi);
}

//[=Leave=]
private function leaveTheCowCubi():void {
	clearOutput();
	outputText("Your fingers tighten on the shaft of your halberd and suddenly you bring it whipping around, the blunt end slamming into the side of the succubus-cow's head.  As her eyes roll up in her head and she collapses unconscious onto the ground, you spit to the side.  \"<i>Be glad I didn't use the sharp end, monster.</i>\"  With that, you continue on into the depths of the shrine... oh, if only " + player2.short + " was here; you'd happily fuck " + player2.mf("him","her") + " senseless right now...  Still, it's something to look forward to once you're done inside.");
	menu();
	addButton(0,"Go Inside",enteringTaothsShrine);
}

//[=Rape=]
private function fuckTheCowCubi():void {
	clearOutput();
	outputText("\"<i>Come on girl, strip down so I can see what you're hiding under that leather skirt of yours.  Besides, we both know you want me, I can see that tent,</i>\" she laughs, licking her lips seductively.");

	outputText("\n\nHating yourself even as you crave what's coming, you undo the straps and pull your armor off of your body, casting it to the ground, allowing the third arm of your stallionhood to rise up before you in a tower of equine fuck-flesh, drooling precum down its long length.");

	outputText("\n\n\"<i>Hmm... not as big as I'd hoped.  I mean, Fido is certainly much bigger, and I have no doubt his cum is much tastier... still, I guess we have to work with what we have, since you knocked my pet out cold,</i>\" she states matter-of-factly, clearly not impressed with what she sees.");

	outputText("\n\nRage thunders through your veins, almost drowning out your lust and quenching your self-loathing at your inability to control yourself.  Bad enough that you're about to fuck a demon, but that she reckons your oversized cock is too small?  Who does she think she is?!");

	outputText("\n\n\"<i>What's the matter, girl?  Cat got your tongue?  Or maybe you just forgot what goes where?  Don't know how to use that little pony of yours?</i>\" she teases you, smiling smugly.");

	outputText("\n\n\"<i>Oh, I know how to use it,</i>\" you retort, mind flashing back to Edryn - size queen she may be, but she appreciates skill in her partners, too.  \"<i>Question is, what makes you think you're worthy of getting it, you stretched-out excuse for a whore?  You want to ruin yourself on monsters - don't complain when decent folk aren't big enough for you!</i>\"");

	outputText("\n\n\"<i>Oh, geez... now you're getting me all embarrassed... just so you know, flattery will get you everywhere, honey.</i>\"  She smiles and bats her eyes at you.  \"<i>But I'm not gonna lie, it would take at least a dozen of you to satisfy me, so why don't we get this over with quickly, and I can go look for a worthy fuck?</i>\"");

	outputText("\n\nYou are seething in anger now, that cow says one more thing and you'll stuff her mouth so full of horse-cock that you'll dislodge her jaw.  \"<i>Say...  just one more thing and I swear...</i>\" you growl at her.");

	outputText("\n\n\"<i>You'll wha - GRLP!</i>\"");

	outputText("\n\nTrue to your word, you promptly grab the demon's horns and ram your flaring cock brutally into her mouth, slamming it through her teeth and into the back of her throat before forcefully trying to stuff it down her throat.  Once you get the angle right, though, the resistance fades away and she slurps it down like a noodle; you guess she must be a mino-cum addict.  She's so used to deepthroating her pet's monstrous member that yours is no problem for her to gulp down.  Good.  As roughly as possible, using her horns to get a proper grip, you start mercilessly pistoning yourself in and out of her stretched throat, the bulge of your dick visible through her neck.");

	outputText("\n\n\"<i>How do you like that, huh?</i>\"  You spit.  \"<i>You like dick in your mouth?  This what you wanted, filth?  You're a stretched out little cocksucker, aren't you?  Gobbling dicks is all you're good for, isn't that right?</i>\"  She smiles around your cock and nods, clearly enjoying the rough treatment.");

	outputText("\n\nA queasy feeling settles in the base of your belly at her attitude, but you're in too deep to get out now.  No pun intended.  Still, if she likes it rough, why not keep giving it to her that way?  Besides, you're still pissed at her.  You slam yourself as deep into her throat as you possibly can, banging her face into your belly as hard as you can without hurting yourself, your balls audibly slapping into her chin with each thrust.  You can feel her inhumanly trained throat rippling and squeezing your dick, the slick, hot depths teasing and tantalizing as they strive to milk you of your cum.  You're torn on whether or not to give in so you can get this over with, or hold out just to piss the little slut off.");

	outputText("\n\nThe succubus doesn't give you much of a choice, however.  Her throat muscles grip your shaft tightly and her long, broad, demonic tongue wraps around your cock like a sinuous snake, poking inside your sheath and even teasing your balls with quick little licks.  You moan and growl, thrusting deep into her throat; by the gods, it feels like she's trying to suck your balls out your dick!  You're not sure how much longer you can hold out...");

	outputText("\n\nThe sound of a jingling bell makes itself known to you, and before you can check what is making the noise you feel something shove itself into your pussy.  You let out a startled yip of surprise, your walls instinctively clenching down on the intruder, which is long and thin and supple.   It has to be the demon's tail; you can feel it wiggling around inside of you, stroking with expert attention to your most sensitive parts, playing with your little nub, even as her tongue coils and strokes and her throat grips and milks... oh gods...  You throw back your head in a lupine howl as you explode into the demon slut's anxiously hungry gullet.");

	outputText("\n\nThe succubus-cow squeals with delight as she begins drinking down your cum with gusto, not spilling a single drop or stopping to breathe.  You moan, whimper, and pant as you unload gush after gush into her eager belly, until finally even your overstretched balls are empty.  With a groan you pull yourself wetly out of her still-sucking mouth, the succubus's tongue ensuring it's glistening clean as it finally clears her lips.  You find yourself swaying unsteadily on your feet, your legs numbed from the power of your orgasm.");

	outputText("\n\nThe succubus licks her lips, savouring your taste.  \"<i>Not bad... not as good as Fido's though.  Size is not even a competition, but it was pretty good.  You do have some skill with that little pony of yours, but you should work on your stamina; if you're already unsteady after just cumming once, you have little value as a fucktoy.</i>\"");

	outputText("\n\n\"<i>I can't believe I'm hearing this!</i>\" you blurt.  \"<i>You miserable cunt... oh, it's on now, bitch!</i>\" you spit.  Before she can react, you swing your fist around in a mighty right hook, putting all your weight behind it as you do, using the skills picked up from years spent brawling on the streets.  She goes down with that one hit, leaving her ass-up in the air as she sprawls on her giant tits, milk oozing into a puddle in the ground from her weight on them.  You're presented with her gushing cunt and, furiously, you jerk yourself half-erect and then plunge roughly into her cunt, brutally humping away at her ass.");

	outputText("\n\nThe succubus-cow groans as she gets her senses back.  \"<i>That's more like it!</i>\" she says, pushing against your thrusts.  \"<i>Come on girl, show me that you're better than my pet mino and I might just respect you a little,</i>\" she moans, laughing at you.");

	outputText("What does it take to get through to this monster?  Wounded pride fills your mind and you determine that if she wants it, you'll give it!  Grabbing her tail for extra leverage, you start to rut and thrust with all the force you can muster, plunging in with brutal strokes that even Edryn would kick you off for trying on her.  Yet the demonic cowgirl screams at you to push harder, fiercer.  You bring one hand whistling through the air to land a stinging slap to her over-stuffed ass, the soft flesh visibly jiggling from the impact.");

	outputText("\n\n\"<i>Yeah!  Hit me more, you bitch!  Spank me!</i>\" she screams in delight.  You grimace in disgust, but keep on slapping her and thrusting her, trying to get the two into a proper rhythm.  Soon as you empty your balls, you're going to really settle this matter...");

	outputText("\n\n\"<i>Yes, fuck me more!  Show me what a naughty little thing you are!  Then come engorge yourself on my breasts.  Drink my milk!</i>\"");

	outputText("\n\n...Not a chance, you think to yourself.  But, from that familiar warmth burning in your dick and the clenching of your balls, things are about to finish, one way or another... You cry out as you cum for the second time, flooding the demon's loose cunt with your jizz.  \"<i>Ahh!  Fox milk!  Give me all your seed!  Make me pop a new litter of imps!</i>\" she screams, her cunt quivering with an orgasm of her own, milking your shaft as well as it can after being ruined by her pet minotaur.");

	outputText("\n\nYou empty the bulk of your cum into the demonic slut, then pull out, spraying her ass and legs with the last few spurts of jizz.  \"<i>Hah!  Is that it?</i>\"  The demon crows, but gets no further; you grab your halberd and bring it crashing down, blunt-end first, into the back of her skull, leaving her unconscious.");
	player.orgasm();
	outputText("\n\nYou look at her, sprawled there, and your face falls, shame burning in your belly.  What kind of woman are you?  Bad enough to sleep around on your lover, but with a demon?  Are you really that incapable of controlling yourself?  Feeling miserable, trying to justify your actions and vowing that Taoth will be removed from you if it's the last thing you do, you pull your clothes back on and start heading into the shrine, anxious to be free of him at last.");
	menu();
	addButton(0,"Move On",enteringTaothsShrine);
}

//Urta Loses*
public function urtaLosesToCowCubi():void {
	clearOutput();
	outputText("Sinking to your knees, ");
	if (player.HP < 1) outputText("you struggle futilely to rise.  Your arms are shaking and bloody.  It's just too hard.  Your muscles just won't respond, and you fall flat on your face, unable to get up.  The succubus laughs at your plight, and places both her hands on your head.  You struggle, but you're too wounded to wiggle free.  Her magic begins to pulse through your brain, thrumming erotically through your consciousness.  Your heart begins to beat faster and faster, blood rushing to your extremities.  You moan, rigidly, exquisitely hard, your member rising through the soft moss below.  You might have been resistant to her magic at a distance, but nothing could protect you from this.  You NEED to fuck.");
	else outputText("you start pulling at your [armor], struggling with every strap and piece of restraining, constricting leather.  Your lust-clouded mind can barely focus to work your fumbling fingers against the snaps and straps.  In your haste, with balancing forgotten, you tumble onto your face, smearing your dick exquisitely between your fallen form and a patch of soft moss.  You mewl pitifully in protest.  You need to fuck!");
	outputText("\n\nThe succubus laughs cruelly, her throaty voice bursting with contemptuous mirth.  \"<i>Such a pretty little foxy...</i>\"  She kneels in front of you, meeting your lusty, vacant gaze as you slowly grind your hips in the dirt, smearing your pre beneath you like some kind of wanton, heat-addled animal.  \"<i>You have so much potential as a pet - a knock-out body, nice tits that have just enough bounce... not too saggy either... and that cock.  I always wanted a real dog for a pet.  Yes, yes, you're a fox,</i>\" she says, stroking your nose affectionately.  You lick her finger into your mouth, pleading with her to undress you and take you in the only way you can think to.  \"<i>You're still my little bitch, aren't you?</i>\"");

	outputText("\n\nMaybe for now... just untill you let off some pressure.  You nod enthusiastically, her finger popping out of your slobbery maw, trailing a single strand of frothy vixen-spit.  The succubus doesn't seem to mind.  She wipes her messy digit off on your ear, smoothing back the fur as she does so.  \"<i>You probably think you'll get out of this somehow, but you're wrong.  The kind of pleasure I can offer is... addicting.</i>\"");

	outputText("\n\nHefting the expansive mass of her chest, the demoness hefts her teats up to her mouth, sampling the bounty within.  Of course, with four swollen nipples dangling and dripping, she's far more successful in wetting her skin to a healthy shine than actually devouring her lactic cargo.  \"<i>Mmmmm, so good.  A shame my milk won't affect me like it will you.</i>\"  She releases her ponderous tit, and it sways down, smacking into the other, setting off a waterfall of alabaster cream.  Some of it spatters off your head, but the vast majority winds up on the surrounding plant life. She wastes no time, and immediately begins to unlatch your coverings.  \"<i>Can't have my bitch's genitals covered now, can I?</i>\" she whispers sultrily, punctuating each word with the removal of a buckle, snap, or strap.");

	outputText("\n\nWhen the last bit of protective armor is removed, dainty fingers hook under your unresisting arms, helping you up on to your feet.  Bits of dirt and grass are stuck into your fur in places, and your poor cock has patches of slimy moss glued to it with your pre-cum.  All in all, you're a horny mess.  Without the gear restricting you, you're able to grab hold of your thick, equine fuck-tool and jerk yourself, smearing the mossy, muddy mess around over the mottled length, marring the patterned flesh with green-tinged slime.   It feels too good to care.  You're too aroused, too deliciously, throbbingly wet to worry about the dirt. You feel compelled to reach behind your throbbing nutsack and jam two fingers into your oozing snatch, feeling the hot wetness pooling inside that engorged, velvety passage.  If this is what being a dirty whore is like... you could get used to it.");

	outputText("\n\n\"<i>Oh, no no no no...   This won't do at all!</i>\"  The succubus pulls your greedy little paws away from your genitals, leaving you dripping, muddy, and reeking in need of sex.  She wraps her arms around you, pulling you into a hug, nestling your panting mouth into her enormous, soft cleavage.  Any other time, you'd be happy to be buried in such expansive titflesh, but right now, you're too horny to wait.  Your unquenchable ardor won't permit you not to fuck for another moment!");

	outputText("\n\nRebelliously, you grab hold of the demon's massively flared hips and twitch your backside back, dipping your messy, dripping dick down.  The fat, swollen head smears across the succubus's plush mound, and without delay, you plunge inside, pistoning the fat flare past her juicy gates without warning.  The succubus gasps, high pitched and unquestionably pleased, her tunnel accepting your musky horse-dick without any complaint, the plush wet walls comfortably caressing it with slow back and forth squeezes that seem to drain the strength from your very soul.");

	outputText("\n\n\"<i>I told you that you'd get addicted to me,</i>\" she titters, pulling you out of her pillow-like cleavage by the scruff your neck.  \"<i>Now, I'll have to teach you restraint another day.  For now, why not just enjoy what I can do to your dick and have a snack?</i>\"  Her hand pulls your head into one of those gigantic, milky pillows, planting your open lips around the circumference of a vast, many-tipped nipple.  Four fat teats bounce on your tongue, immediately filling up in response to your warm breath and wet tongue, licking curiously.  Trickles of sweet milk hit your tongue in short order, turning into a tide of creamy, pleasant fluid almost immediately.");

	outputText("\n\nThe taste of the succubus's lactic treat is unlike anything you've ever had before.  It tingles on your tongue, making it buzz with pleasant, almost manic strength, and best of all, as you swallow, you feel the invigorating nectar go to work on your entire body.  You drink deeply of the sex-demon's essence, pawing at her tit with both hands.  Her teats grow fatter and fatter on your tongue, each a thick, sensitive milk-spout that seems perfectly responsive to your growing thirst.  In short order, they've swollen fat enough to bulge your cheeks slightly, reaching all the way back to your throat, spurting milk so fast that all you have to do is hold onto the tit for dear life and relax your throat.  Your gut tingles with milk, midriff slightly swollen against the milky, soulless sex-monster's middle.");

	outputText("\n\nInside her flexible twat, your dick loses itself to the pleasure.  It's so hard and rigid, as thick and engorged as it's ever been, flaring wildly while the silken walls stroke it up and down, over and over.  It's as if her pussy has a hand around you, jerking you off with her inner, velvet-soft walls, constantly drizzling bubbly, tingly lube all over your shaft.  Her pussy is like a honeyed, clutching cock-heaven, one you never want to leave.  You're sure that if you weren't so obsessed with drinking down her milk, you'd be cumming already, splattering jizz into that rippling, ecstasy-inducing fuck-hole, but for now, you're content to ride along, drinking and sagging against her plush, milk-filled tits, your dick drooling while it experiences bliss like you've never known before.");

	outputText("\n\nThose beautiful, plump, tasty little milk-spouts suddenly retract, back to perky, three-quarter-inch nubs.  You're yanked back of her mammoth udder by a cruel yank on your hair and immediately placed onto the other jiggling mound.  Four fresh teats swell into your unresisting maw while the other side dribbles a few last trickles, and then you're drinking again, suckling the succubus's sensuous lactation down with gusto.  Sharp, manicured nails play through your hair while the quad milk injection does its job, filling you with vitality");
	if (player.HP < player.maxHP()) outputText(" and healing your wounds");
	outputText(".  Your own nipples have long since become fully engorged, taut black tit-caps, pebbly and sensitive.  They drag up and down the fat bottoms of the demoness's swollen underbust with every swallow and gasping breath you take.");

	outputText("\n\n\"<i>Drink long and drink deep,</i>\" her voice coos in your ear, accompanied by a comforting caress of your poor, swollen nutsack.  It feels utterly tight, straining to contain the sloshing cum-factories within.  As you drink, your back begins to arch uncomfortably.  You're being pushed away by your stuffed, wobbly gut.  It's begun to slosh with every swallow, but you've never felt better.  A steady, placid buzz has settled over your awareness, and you feel totally compelled to <i>drink long and drink deep</i>.  No problem!  You love this milk.  You'll just drink for a few more hours and then fight her off - after you cum.");

	outputText("\n\nThe succubus fingers your tailhole aggressively and without warning, plunging her narrow digit into your delicate pucker with a firm, confident stroke.  It brushes right up against your sensitive anal g-spot, making your dick lurch inside its snuggly, demonic home.  Pre-cum and girlish lubricants gush out the clinging lips of your succubus lover's pulsating snatch, her prominent labia fluttering in excitement at the discharge.");

	outputText("\n\n\"<i>Don't cum yet,</i>\" she commands, tickling your balls with her pinky while she works your squeezing, convulsing asshole, milking your prostate for even more slippery pre.  \"<i>You can't cum without my permission pet, never again.</i>\"");

	outputText("\n\nYou whine around her tit.  <i>Drink deep.</i>  Swallowing another burbling mouthful of milk, you whimper around her slowly emptying, cow-like teats.  Your bloated, flaring horsecock bounces wildly, your body convulsing in bliss.  Then, just when you feel like you're about to pop, the growing pleasure plateaus, drawing off.  No!  You were about to cum!  <i>Don't cum yet.</i>  Your desire for release goes to war with the compulsions racing through your brain. Orgasm is so close, but you <i>just can't</i>.  The succubus's commands are rattling around your head as you suckle harder and harder, venting your frustration with more of her soothing, energizing milk.   Maybe you can just drink until it makes you feel so good that you can forget all about the achy, needing throbbing that's rippling through your balls.");
	outputText("\n\nThe succubus growls and yanks your head back, \"<i>Not so hard, slut.  If you want more milk, you'll need to beg for it.  Besides, if I give you any more, that paunch won't be going away anytime soon, and the last thing I want to have is a fat lazy slut sitting around my glorious home.</i>\"  She pushes you to the ground, your swollen mare-meat pulling out of her cunt with a wet 'SCHLUCK', long streamers of girlish juice and pre hanging between you in a web.  Your dong slaps into your chest hard enough to nearly knock your breath away.  Jiggling around it, your tits bounce over the super-hard, over-stuffed dick.  It looks nearly a half inch thicker than normal, and a little longer as well.  The flare is fully exposed, gigantic and engorged as if you're in mid-orgasm.  You whimper, immediately titfucking yourself.  <i>Don't cum.</i>  It feels so good, if only you could release!");

	outputText("\n\nA shadow falls across your face.  Up above, an unbelievably posh, robust butt has appeared.  Dripping female juices splatter across your nose, mouth, cheeks, and chin.  Flaring wildly, your nose inhales the delicious scent while your tongue laps your face as clean as it can get in the onslaught.  There's a slightly familiar flavor mixed in with the succubus's yummy cunt-juices - your own pre-cum.   Her gushing gash descends onto you without warning, the plump asscheeks smothering your ears on either side.  Dripping ladyspunk wreaths your muzzle, and the silky walls tickle at your nose, smothering you in demon-scent.  You begin to lick immediately, thrusting your tongue out hungrily.  Maybe if you get her off a few times, she'll let you finally blow your load?");

	outputText("\n\nGrabbing her ass in both hands, you pull her slit against you even harder, not even caring that her gloriously plump thighs have fully encased your awareness, leaving you nothing but the dusky folds of her pussy and musky scent for company.  She's so tasty, almost as tasty as her milk!  You rub your hands over her expansive ass, squeezing each cheek in turn.  Her pussy grows wetter as you worship her ass with your hands, and you begin to knead them more aggressively, desiring more of her slippery moisture to drink down.  A slender spade presses down against your sensitive, stretched sheath, barely able to contain the towering column of lust that it's failing to contain.   Slowly, the succubus's tail begins to vibrate, languidly lashing itself back and forth across your super-sensitive organ.  Without warning, it smacks the blunt head, impacting hard enough to send a shudder of pain and pleasure through the poor tool.");

	outputText("\n\nNose deep in pussy, you're helpless to do anything but worship that glorious, corrupted cunt while a tail forcefully fondles your equine tool, sometimes nicely stroking it, other times cruelly teasing it.  You moan into the sopping-wet box, rubbing your snout lovingly around her interior, feeling the walls squeeze down on you affectionately.  The succubus begins to moan so loudly you can hear it through the muffling mass of her jiggly ass and expansive thighs.  Her tail twines affectionately around your balls, looping tightly around where your sack joins your loins, pulling them a little further away from your body and stretching the tender skin even harder.  Her spaded tail-tip rubs across your taint, then arches up, spearing into your pussy without warning.");

	outputText("\n\nYou cry out, ripples of pleasure sending you into ecstatic fits, body twisting to and fro with wild abandon.  Her spade fills out, going from a flat shape to a bulbous, cylindrical mass, and it starts to fuck your cunt, slowly sliding in and out, still vibrating as it assaults your cunt.  You cry out, screaming into the demon-girl's honeyed hole, sliding your tongue over her pulsating, hot little clit.  The deep, rippling walls squeeze down on you hard enough to push you out of her twat, and a wave of fem-spunk bursts across your face, soaking your mouth, neck, and hair with her musky, girlish leavings.");

	outputText("\n\nThe thick flesh of your mistress's posterior clamps down around your head, her vibrating tail pistoning recklessly through your own vagina as she cums, spraying you down with wave after wave of lube.  \"<i>Ffffuuuuuuck, yes! Worship my ass, you horny little herm-bitch!</i>\"  <i>Worship her ass...</i>  You pull her spasming cunt back down onto your face and drag your tongue across her puffy labia, letting her spray her juicy sex-juice straight down your throat as you lick back across her taint and over her anal star.  <i>Worship her ass.</i>  You shudder, not really wanting to, but your tongue slithers up her asshole all the same, feeling the spasms from her pussy all the way through her anal walls.  You pull out and run your tongue over the wrinkled dark entrance.  She creams harder, slopping waves of girl-jizz down your chin.");

	outputText("\n\n\"<i>Oooooohhhhh yes!  Yes!  Yes-yes-yesyesyes!  C-cum!  Cum with me, slut!  Squirt out every drop!</i>\" she screams ecstatically, doubling over to aim the blunt flare into her unresisting, moaning mouth-hole.  Her plump lips open wide, but the rubbery, flared tip thickens even wider, bigger than ever before, fat enough that the best your mistress can do is kiss your cock-tip while your balls quake and prepare to disgorge their heavy load. <i>Cum.</i>  You obey.");

	outputText("\n\nClenching so hard it hurts, you arch your back and finally, blessedly release, ejaculating a wave of white straight down the succubus's mouth.  Your long-delayed orgasm is so intense and potent that sperm runs in rivers from her nostrils, dripping back onto your shaft.  The rigid bulge of your urethra stands out in stark relief against the rest of your mottled horse phallus, stretched by the quantity of spunk traveling through it like an over pressurized hose, veins prominent and pulsing with every beat of your overwhelmed heart.  It feels so good...  Your eyes roll back, and you scream into the tainted tart's pucker, which only causes her to gurgle with happiness around your flexing erection.  Each convulsive spurt distends your poor urethra worse than the one before, and your balls gradually begin to shrink, sloshing audibly as they empty and allow the taut, reflective skin of your sack to wrinkle and relax.");

	outputText("\n\nAfter a few mouth-bulging swallows, the cow-like demoness gives up on drinking it down and presses her breasts around your cum-spraying fuck-hose.  The warm, pillowy softness is like a salve of ecstasy for your erupting dong, urging it on to climax again and again.  <i>Squirt out every drop.</i>  You're helpless against her, you realize as you continue to have orgasms on top of orgasms.  Your new mistress's cleavage immediately slicks with whiteness, dripping from her spotted tits, churning and bubbling with the fruits of your submission.  You heave and gasp into her breasts like a rutting beast, blasting out thicker and thicker ropes until suddenly, you run dry, the torrent transformed into a gentle drip.");

	outputText("\n\n\"<i>Good girl,</i>\" your exhausted mistress whispers, rising from you.  You struggle to go after her, to put your tongue back in her ass where it belongs. She giggles, patting your still-twitching boner with her tail.  \"<i>You can stop worshipping my ass now, bitch.  You're hooked on my milk, body and soul.  The cow-girls in this world have NOTHING on me,</i>\" she says, emphatically crushing her mammoth, sperm-soaked beauties together.  \"<i>My milk is more addictive, and far more empowering than theirs.  From now on, you live to please me.  Obeying me is better than sex, and being allowed to serve me is all you want in life.  Admit it, and I might even tell you what a good girl you've been.</i>\"");

	outputText("\n\nYou nod and tell her just how much you want this.  " + player2.short + " was wonderful, but obeying this woman's commands is DIVINE.  You see stars just from following her commands, giggling drunkenly from the sex and ecstasy of your obedience.  Crawling to hug against her slippery, sex-soaked leg, you proclaim your love and obedience again and again, begging her to let you suckle her breasts again, even though your belly still jiggles with your last 'snack'.");

	outputText("\n\n\"<i>Oh, you are such a good bitch!  Now, I know why you're here, so why don't we get you inside, and corrupt that filthy, nasty spirit inside of you into obedience alongside you.</i>\"  Her hand tenderly scratches behind your ear as she coos, \"<i>Such a very good girl you are...</i>\"");
	outputText("\n\nShuddering with pleasure, your eyes cross as you pad after her, thighs rubbing your squishy, soaked nether-lips together.");
	//[END]
	menu();
	addButton(0,"Next",urtaGameOver);
}

//The Old Shrine*
private function enteringTaothsShrine():void {
	clearOutput();
	outputText("You advance cautiously into the shrine's interior, wary of ambush by other demonic residents.  The interior of the shrine proves that there was battle here, easily before you were born.  Corpses reduced to yellowing bones by the passage of the time are scattered everywhere, discarded or broken weapons and mangled armor showing how hard the fighting must have been to hold this sacred place.  Most of the corpses are quite clearly those of your people, with vulpine skulls, bestial leg-bones and the distinctive vertebrae bones showing what must have been beautiful fluffy tails in life.  Other skeletons, however, are surprisingly human-like, though they invariably bear the bones of at least one and sometimes more tails - you finally figure out that they must have been kitsunes in life.  You spare a moment to contemplate the old theory that your two races are related, but then dismiss it; you're not here for science, you're here to make contact with the \"<i>god-ghost</i>\" haunting your body.");

	outputText("\n\nYou continue to explore the shrine, but there is little worth talking about to be found.  Skeletons of fallen defenders - and a depressingly small number of demonic assailants - rags, rubble, ruins and dust greet you.  Finally, however, you find yourself in what has to have been the main chapel of the shrine.");

	outputText("\n\nA huge statue dominates the room; if this is life size, then the god you seek to communicate with was big enough that he could have supported you on the palm of his open hand.  The figure is quite distorted looking; fundamentally a fox-morph, with vulpine head, ears and tail, but the body is unnaturally lean and emaciated, faux-skin stretched tight over unusually small, compact bones that make his head look oversized and out of proportion, thin limbs easily twice as long as they should be.");

	outputText("\n\nYou wonder how it is that you're supposed to actually get into contact with Taoth; you don't recall the magi at the Covenant actually telling you anything about that.  Nothing ventured, nothing gained; you walk up until you are standing before the statue and then seat yourself by kneeling, paws pressed up against your bum, tail swishing quietly across the dusty floor, balls and cock purposefully flopped out before you.  You close your eyes and try to concentrate, mentally beseeching the deity to stir and answer you.");

	outputText("\n\n\"<i>You...</i>\"");

	outputText("\n\nA shiver ripples up your spine, hackles instinctively growing erect as a sepulchral voice whispers directly into your mind.");

	outputText("\n\n\"<i>I wake...</i>\"");
	//Next Page, go to Dead Gods Dreaming
	menu();
	addButton(0,"Next",deadGodsDreaming);
}

//Dead Gods Dreaming*
private function deadGodsDreaming():void {
	clearOutput();
	outputText("Your eyes spring open and you stare in dumbfounded shock at the statue as it starts to move, joints flexing with the awful sound of stone grating on stone.  Carved eyelids open to reveal flames of myriad colors, ever-shifting before your eyes.  \"<i>Welcome, vessel.  It is time that we spoke.</i>\"");

	outputText("\n\n\"<i>You really are... Taoth?</i>\"  You reply, wary of being tricked.");

	outputText("\n\n\"<i>I am.  Two decades ago, our enemies managed to pierce the veils of my myriad tricks and trap me here, in this shrine.  Confronted and with no way out, the demons thought they could end me, as they have some of my brothers and sisters,</i>\"  the spirit notes.  Now that you've gotten over the shock of it actually talking to you, it's more disconcerting than awe-inspiring.  The surprisingly animate features of its statue convey a slyness and a frankly less than serious nature, while its unearthly voice seems barely concerned by the state it finds itself in.  \"<i>Naturally, I could not allow myself to be destroyed.  I sent my faithful - my beautiful servants - to stem the tide.</i>\"  It seems genuinely penitent about this, though from the way it describes its followers, it viewed them more as objects than people.  \"<i>They bought me the time to sever my life force from my mortal vessel.  As my honor guard fell, I fled, flinging my essence out in search of a fresh form, even as my body petrified behind me.</i>\"");

	outputText("\n\n\"<i>You chose MY form,</i>\" you declare, fighting hard to avoid snarling at it, \"<i>Why?</i>\"  You demand passionately, unable to resist learning why it chose you.");

	outputText("\n\nThe statue shrugs its shoulders.  \"<i>You had the fortune to be conceived at the moment of my defeat, or near to it.  The new body of an infant, freshly joined with soul, is surprisingly welcoming to external spirits.  Weakened as I was, I did not have time to be picky.  It was die, or try to pull off one last trick.</i>\"");

	outputText("\n\nRage boils through you, thundering inside your mind like the beating of war-drums, red suffusing your vision at the utter indifference this being is displaying.  He ruined your life, before you were even born!  How <b>dare</b> he not feel even the slightest bit guilty for doing so!?");

	outputText("\n\n\"<i>It is true that I caused you much grief through my presence, but do remember that if it wasn't for me and the hardships I caused, you would not have been molded into the strong woman you are - Captain of the City Watch, beloved of " + player2.short + ".</i>\"  The statue folds its arms, eyes blazing in a way that suggests irritation, and you feel a pang of instinctive fear at the unspoken threat.");

	outputText("\n\n\"<i>If you try anything to hurt " + player2.mf("him","her") + ", I swear I'll make sure you go to whatever pit awaits dead gods,</i>\" you hiss at him, clenching your fists so tightly you feel your nails bite into your palms.  One of your ears twitches when your better sense reminds you that this deity is still inside you, and you lack even the slightest amount of magical power.");

	outputText("\n\nThe statue laughs, \"<i>Brave.  I like that, but you are foolish to threaten a being beyond your comprehension.  Ones like you are always the most fun.</i>\"  It shakes his head and madly titters, \"<i>Let me get back to the matter at hand...  I know why you're here and I agree with it, so let us not spend time idly threatening one another.</i>\"");

	outputText("\n\n\"<i>You want to cooperate?</i>\" you question, eyes narrowed in suspicion.");

	outputText("\n\n\"<i>Of course!</i>\" the statue replies, looking offended.  \"<i>I can hardly get into the kind of mischief I'd like to as a passenger in a watch-woman.  I owe Lethice a few tricks, and having to cohabitate a body doesn't exactly make it easy to get revenge.</i>\"");

	outputText("\n\nWell, this is turning out suspiciously easy...  \"<i>So, I want you gone, you want to get gone, how do we make it happen?</i>\" you bluntly retort.");

	outputText("\n\n\"<i>Well... it's not quite that simple,</i>\" he lamely explains.  \"<i>I can't just walk out and wander around, not without a corporeal form.  As amusing as it would be to haunt the little people of this world, to do so would be to diminish myself.  No, you must create me a new body, one which I can shape into the perfect vessel,</i>\" he commands.");

	outputText("\n\nYou blink in confusion, which causes him to sigh in exasperation.  \"<i>You must mate - breed.   There must be a coupling, and I shall be the result.  It will be the result we both crave.  I shall have a fresh form with which to visit chaos on our foes, and you shall have a fertile womb to rival a goblin and a cock so virile that minotaurs will be jealous.  Perhaps I may even gift you with a boon for your efforts, but whatever the case, a child must be conceived.</i>\"");

	outputText("\n\nYou do give the matter some thought, but, really, what choice do you have?  The Covenant wants this god to assist them, and you've dreamed of the ability to have kids ever since you fell in love with " + player2.short + ".  You slowly nod your head and voice your agreement to the god's terms.");

	outputText("\n\nThe statue smirks triumphantly at you, and then its eyes suddenly explode in a great wave of many-colored fire that washes over you, forcing you to close your eyes, leaving you reeling as they stab through you...");

	outputText("\n\nThen you awake with a start, still kneeling before the unmoving statue.  Was it all a dream?  You don't know...  Your head is throbbing like mad, and you can't think clearly.  But even as the pain dims, you become aware of another, more pressing matter.  Lust.  That familiar yearning burns inside your arm-length prick like a raging inferno, the tower of equine fuckmeat thrusting boldly before you and steadily gushing precum onto the ground.  Naked, hungry NEED screams and claws and gibbers behind your eyes... " + player2.short + ", you must have " + player2.short + "!");

	outputText("\n\nAbsently licking drool from your lips, you stagger upright and, using your halberd for support, start loping home from the shrine.  In your wake you leave a slug-like trail of sexual lubricants, too focused on finding and fucking your lover to care about the glistening slime caking your dick and plastering your inner thighs.");
	dynStats("lus=", player.maxLust(), "resisted", false);
	//Revert to PC control and change page to Urta Arrives At Camp
	menu();
	addButton(0,"Next",urtaArrivesAtCampForFukks);
	resetToPC();
}
//Urta Arrives at Camp
private function urtaArrivesAtCampForFukks():void {
	clearOutput();
	outputText("<b><u>Meanwhile, back at camp...</u></b>");
	outputText("\n\nAs you are getting ready to set out for another day in Mareth, you find yourself surprised with an unusual encounter at the very boundaries of your camp.  It's Urta!  She's come back at last... and boy, she's a mess; her eyes roll wildly in her head, until she sees you and fixes on you like a starving fox on a fat hen; her cock thrusts wildly before her, precum bubbling over its tip and splatting wetly into the dust before her, femcum drooling out of her gash like water and plastering her legs with shiny wetness.  The fox breaks into a run until she skids to a halt in front of you, panting with lust and exertion.");

	outputText("\n\n\"<i>Hi, " + player.short + "...</i>\" she manages to pant out.  Looking at the state of her, you take a wild guess and suggest she spoke to her 'guest'.  \"<i>Yeah... Taoth's promised to get out of me, but, first, we need to give him a new host body... well, <b>I</b> need to give him a new body.</i>\"  Urta still has control enough to look sheepish, despite the fact her body is blatantly screaming for release.  \"<i>I-I'd rather do it with you, but ");
	//if genderless:
	if (player.gender == 0) outputText("seeing as how you can't make babies");
	else outputText("if you'd rather not");
	outputText(", I can always go and use Edryn...</i>\"");

	outputText("\n\n\"<i>What do we do, " + player2.short + "?</i>\" she pants, practically whimpering.  \"<i>We need to choose fast... I can't hold.... hold back much longer!</i>\"");

	outputText("\n\nWell, this is quite the surprise!  You have no idea who 'Taoth' is, but you can only guess that it's some kind of spirit or demon or something.  She seems to have been put into some kind of wild rut and heat, determined to produce a baby to release this... thing from inside of her.  Do you");
	if (player.gender > 0) outputText(" fuck the horny fox and help her out of her predicament, or");
	outputText(" send her to Tel'Adre to find a suitable partner, like Edryn?");
	/*if (player.hasCock()) {
		if (player.cockThatFits(urtaCapacity()) < 0) outputText("  A shame you're too big to fit inside her.");
	}*/
	//Genderless PCs auto-select the Edryn option, KnockUrta requires PC has penis, KnockMe requires PC has vagina
	menu();
	//[KnockUrta] [KnockMe] [Edryn]
	if (player.hasCock()) addButton(0,"KnockUrta",knockUpUrtaWithGodChild);
	if (player.hasVagina()) addButton(1,"KnockMe",getKnockedUpWithGodChild);
	addButton(2,"Edryn",urtaAndEdrynGodChild);

}
//PC Knocks Up Urta with God Child*
private function knockUpUrtaWithGodChild():void {
	clearOutput();
	var x:int = player.cockThatFits(urta.urtaCapacity());
	if (x < 0) x = player.smallestCockIndex();
	outputText("Well, this problem seems like it can solved the same way you've dealt with most of Urta's issues - with the judicious application of sperm.  You strip out of your [armor], which causes the lust-crazed vixen's eyes to bulge in appreciation, her mouth beginning to drool nearly as much as her genitals.  She whimpers needily, \"<i>Now?  Can we do it now?</i>\"  One after another, she takes trembling steps towards you, each movement a shuffling half-step, as if she's afraid you'll run away.  Feverish sweat drips from her forehead, and her ears are constantly twitching this way and that.");
	outputText("\n\nYou admit to her that you'll fuck her and fill her, whatever it takes to help her through this.");
	outputText("\n\nAt first, the gray-furred fox smiles gratefully, like someone finding water after a day without, but then, it twists into a manic, depraved grin, full of teeth and slavering saliva.  She doubles over like she's in pain, her legs pulled tight to her heaving breasts.  Uncoiling like a spring, the fertility-crazed vixen launches herself toward you, a ball of flying, sexual fury.  She slams into your [chest], hurling you over to the ground, kissing you with lip-bruising force, her tongue forcing its way into your mouth, slapping at your tongue, lapping at every crevice of your oral opening.");

	outputText("\n\nYou feel wetness dripping in the middle of your [fullChest] and over [eachCock], the twin streams of sex-lube just pouring out of Urta like water from a broken dam.  Her green eyes pin you under their overly intense weight, searching you.  She holds herself like that, grinding her fat, flared cockhead along your middle, smearing her plush vulva and sweaty nutsack against");
	if (player.cockTotal() == 1) outputText(" your own");
	else outputText(" [oneCock]");
	outputText(".  The nub of her clit is a diamond-hard button that drags across your sensitive " + player.skin() + ", aggressively smashed into your genitals.  Still, somehow, she seems to be holding back, probing you with some last vestige of sanity for your consent.");

	outputText("\n\nSighing, you figure you may as well lie back and enjoy it, and you push your tongue back against hers, letting her set the fevered, frenzied pace but along for the ride regardless.  She picks up on the change in your attitude and shifts, a soft-fingered grip snaring [oneCock] and lifting it up, pressing it into the slick wetness between her thighs.  You gasp, muffled by her overwhelmingly intense french-kiss, the fox-girl's puffy black lips smothering your own in warm, wet affection.  Likewise, the onyx opening of her vagina yields against your " + player.cockDescript(x) + ", clinging tightly around your girth as they swallow the first few inches of you.  Already, you can feel her inner walls massaging your tender erection towards orgasm.  They squeeze and tug on your " + player.cockHead(x) + " powerfully while small squirts of fox-lube drizzle down to your [sheath].  The fox drives herself the rest of the way down onto you.  Her hips hit yours with a loud smack, splattering her moisture down your [legs].");

	outputText("\n\nFinally, Urta breaks the kiss, panting for air as she begins to buck and rock atop you.  Your " + player.cockDescript(x) + " shivers against the squeezing pressures the frenzied fox is forcing upon you, and already you can feel yourself trickling and leaking into her sodden vice.  Both of your bodies have become absolutely drenched in sticky, musky horse-pre");
	if (player.cockTotal() > 1) outputText(", the mess made worse by your multiple-cocked virility.  There's so much that the clear juices roll off you to either side, puddling in your blankets below");
	outputText(".  Her nipples dig into yours");
	if (player.hasFuckableNipples()) {
		outputText(", kissing into the ");
		if (player.lactationQ() > 50) outputText("milky, ");
		outputText("wet holes on your tits, drawing fresh gasps of delight from your overwhelmed brain");
	}
	else outputText(", shooting tingling excitement through your nubs as you grind against each other");
	outputText(".  Urta's artless humping would be cringeworthy if she weren't so incredibly wet or overly tight.");
	outputText("\n\nThe confused girl begins to moan, howl even, yipping wildly as she bottoms out again and again, slathering your loins in her honeyed, female syrup.  She shudders, lost to lust, and the clingy, clenching hole gives a tremendous squeeze around your " + player.cockDescript(x) + ".  Urta babbles, \"<i>So good... so good...</i>\" over and over, her eyes rolling wildly.  You grab hold of her cushiony, furry behind like a drowning man holding on to a life raft while the pleasure mounts within you, seeming to bubble out of your very balls.  \"<i>Cumcumcumcum!</i>\" the vixen chants, milking you desperately.  You do just that, squirting out a nice, thick load for the her greedy pussy to drink down.  The runny girl-cum that's oozing over your ");
	if (player.balls > 0) outputText("[sack]");
	else outputText("taint");
	outputText(" tints off-white from your liquid, squirting out of her tunnel faster than ever when she climaxes with you");
	if (player.cumQ() > 1000) outputText(", belly rounded with wobbly, womb-packing spunk");
	outputText(".");
	outputText("\n\nYou come down from your orgasmic high, slumping back into the messy mud below.  It's beginning to dry and harden already, the moisture being wicked away by the parched earth.  You'd get up, but Urta isn't done!  She begins bouncing again, her spasming inner walls rippling expertly around you as she rides you rough and dirty, keeping you so hard that it hurts, even after such a potent orgasm.");

	outputText("\n\n\"<i>Mmmm, not done yet, are you, love?  I'm still horny!</i>\" Urta proudly declares, even while her dick is drooling a thin flow of leftover cum across your chest, slapping against your middle again and again with her bounces.  An invigorating tingle tickles through your [balls], and you realize you've only just begun to fertilize her...");

	outputText("\n\nUrta rides you through at least three more orgasms, though you soon lose count, conscious only of the increasingly urgent motions she makes atop you.  Eventually, even the sex can't keep your beleaguered body awake, and you slump into unconsciousness, your only company the 'squish-squish-squish' of your joined genitals.");
	player.orgasm();
	dynStats("sen", -2);
	menu();
	addButton(0,"Next",postFuckUrtaUp);
}
//Post-Sex Epilogue*
private function postFuckUrtaUp():void {
	clearOutput();
	outputText("When you wake, any queries you might have about Urta's \"<i>quest</i>\" having worked are instantly answered.  The snoring vixen beside you already looks very pregnant; it's a good thing that she went to bed naked, because you don't want to think about how she would have swollen up like she has whilst still in her leather jerkin.  The bulge wobbles slightly as she inhales and exhales and you wonder how you're going to wake her up.");

	outputText("\n\nThankfully, Urta spares you the trouble, waking up with a moan.  \"<i>Oh... I feel so full,</i>\" she grumbles, struggling to get up under the weight of her belly.  When she realizes what's holding her down, she stops, staring at it in dumbfounded awe.  \"<i>" + player.short + ", is this really...?</i>\"  When you nod, she shakes her head in disbelief.   \"<i>Incredible... it really is real.  Oh, " + player.short + ", I just... I just don't have the words to tell you how I feel about this.</i>\"");
	outputText("\n\nYou ask her what she's going to do now.  Urta looks thoughtful.  \"<i>Well... the Covenant would want me to stay with them and give birth to Taoth amongst them.  So, I guess, from here, I'll be going to them.</i>\"  She looks at her belly quietly, and you have a feeling she'd be looking at her feet instead if she could still see them.  \"<i>..." + player.short + "?  I don't suppose you would come with me?   Please?  I know you're dedicated to guarding this portal, but it would really mean a lot to me if I could have you at my side for however long this pregnancy is going to last.</i>\"");
	outputText("\n\nYou give the matter some thought, and decide that the risk is worth it");
	if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) outputText(" - besides, given you know that you're nothing but a sacrifice the demons are too lazy to collect, it's not like they'll really send an invasion through");
	outputText(".  Urta's joyous expression makes it quite clear that you chose the right choice.  The two of you gather your things, dress Urta in her clothes as best you can (adding a blanket for extra protection and modesty), ");
	if (camp.followersCount() >= 2) outputText("leave instructions to your fellow camp-dwellers to look after the place, ");
	outputText("and set off into the wasteland in the direction of Tel'Adre.  Urta needs to stop and rest on several occasions, weighed down by her sudden and highly advanced pregnancy, but she soldiers on without complaint, taking whatever support you give to her.  You can feel the strange god-child kicking incessantly inside her belly as you walk together.");

	outputText("\n\nBefore you know it, the two of you are being waved through the gates.  Edryn boggles at the sight of her friend swollen up with pregnancy, but doesn't protest as you assist Urta in clambering up onto the centauress' back. Together, the two of you manage to haul the unnaturally gravid fox to the Covenant's tower.  Countless guards have to be addressed at each step of the journey, but eventually, you're both brought to a comfortable chamber and allowed to rest... when the mages aren't busily probing Urta with magic, that is.  Urta has you stay by her side the entire time, and you do your best to continue supporting her, not leaving even when she falls asleep on your shoulder, completely tuckered out.  You snuggle up against her once the mages finally agree to let you snooze with her, under the vigilant eyes of your guards.  Rest comes surprisingly easy, despite the tensions of your present situation, and you drift off wondering how long it will take Urta to give birth.");
	menu();
	addButton(0,"Next",preggedUrtaWithGodChildEpilogue);
	model.time.days++;
	model.time.hours = 7;
}

//Pregged Urta With God-child epilogue:*
private function preggedUrtaWithGodChildEpilogue():void {
	clearOutput();
	outputText("You wake to cries of pain, emanating from the swollen vixen next to you as she clutches your shoulders desperately from the pangs of labor.  Loudly, you yell, \"<i>It's coming!</i>\" which launches the room into a flurry of activity.  Urta's water breaks, gushing from out from under her balls and soaking the floor ahead of her with the clear, amniotic fluids.  One contraction after another begins to hit her, causing her no small amount of pain as her body begins to prepare for the coming birth.");

	outputText("\n\nUnfortunately for Urta, even with the labor's rapid onset, it takes its sweet time getting there.  For nearly five hours, you're kept waiting, clenching Urta's hand for support whenever the pain becomes too much for her to bear.  The time passes with agonizing slowness, though the room fills with more and more of the wizards as Urta's labor drags on.  Soft blankets and pillows are gathered, to protect the child when it exits her body, and thankfully, you begin to feel it moving through the drum-tight skin of her belly, travelling down her canal as her body compels her to push, to squeeze as hard as possible.  Then, with a tremendous, sucking, wrenching cry of pleasure, it slips free.");

	outputText("\n\nSlick with birthing fluids, a ball of fur, skin, and bones rolls out onto gathered blankets.  Urta's eyes flutter and droop as exhaustion tries to claim her, but she pulls herself up on her forearms to squint at it, wondering just how the god came out.  To you, it looks little and messy, like any other newborn.  It strikes you as odd that you feel no fatherly affection for the creature.");

	outputText("\n\nThe ball unfolds itself, one spindly leg at a time, each covered in a short layer of fuzz.  The limbs seem too tiny, too frail, even for a creature new to this world.  A hand disengages itself from the rest of the mass, stringing the clear birthing fluids behind it, revealing an equally frail-looking arm.  You can see its head now, fox-like, with a long vulpine muzzle and large, luminous eyes.  The newborn rises on its newly revealed limbs and stretches, standing almost five feet tall when fully unfolded.");

	outputText("\n\n<i>I live.</i>");

	outputText("\n\nThe voice isn't spoken aloud but inside you, inside your head.  A glance to Urta reveals that she heard it too.  The creature - Taoth, you correct yourself, cocks its head toward Urta, giving her thigh a familiar pat.  Her pregnancy-gaped vagina slowly closes at the touch, the damage of its passing instantly mended.");

	outputText("\n\n<i>Thank you, Urta-mother.</i>  The mental voice speaks again, unmatched by the newborn's vocal cords.  It steps over Urta confidently, the long, loping stride seeming... almost unnatural in the way that the limbs seem to sway and dance.  A moment of panic surges through you - what if he hurts her?!  You start to move, to interpose yourself between it (him?), but Urta puts a reassuring hand to your chest, flicking her emerald eyes towards you, begging you not to interfere.  You step away, reluctantly");
	if (player.cor > 66) outputText(", what do you care, anyway?");
	else outputText(".");
	outputText("\n\n<i>I shall uphold my end of the bargain, Urta-mother.</i>  A tiny hand presses against your foxy lover's middle, glowing amber in the dim lighting of the birthing chamber.  Urta whimpers, knees quaking, as if undergoing great pain.  <i>Relax, Urta-mother.  I have undone the damage caused by my presence, and bestowed a gift as well.  No longer shall you suffer on, infertile.  Your fertility and virility are now YOURS to command.  Pregnant or father, the choice is yours and yours alone.</i>  Urta looks nervously around the room, flicking her eyes between the assembled, awestruck wizards and wise-men.");

	outputText("\n\n<i>None but you and " + player.short + "-father have heard this.  Be well, Urta-mother, and should we meet again, do not expect my deals to be so favorable.</i>");

	outputText("\n\nUrta nods down at the child-god, now standing almost five-foot six.  He gives a wry smile and a mocking bow, then turns, confidently loping down a hallway.  The room erupts into chaos, the mages chasing after him, trailing at his heels.  It seems Taoth can take care of himself, and for now, you've got a newly fertile lover.");

	outputText("\n\nThe fox-girl drags you into a huge hug, kissing you passionately.  She whispers, \"<i>Thank you so much for getting me started on this road, " + player2.short + ".  I'm so exhausted now, but come see me at the Wet Bitch later, and maybe... maybe we could see about starting a family.  I mean, maybe there's hope after all?  A dead god was reincarnated!</i>\"");

	outputText("\n\nYou help her leave the tower, arm in arm, saying goodbye to her only after she's tucked tightly into her bed at home, to rest.  Urta gives you a teary kiss before you leave with a little swagger in your step.  You wonder if Taoth will help the Covenant, or if they've bitten off more than they can chew?  Either way, it seems there's a potent new ally on the field.");
	flags[kFLAGS.URTA_QUEST_STATUS] = 1;
	getGame().inCombat = false;
	doNext(camp.returnToCampUseOneHour);
}

//Urta Knocks Up PC with God Child
private function getKnockedUpWithGodChild():void {
	clearOutput();
	outputText("Smiling coyly, you remove your [armor] and crawl into your bed, beckoning for the lust-crazed fox to follow.  You trust her, and you're more than willing to let her put a nice little bun in your");
	if (player.isPregnant() && player.pregnancyIncubation < 150) outputText(" already filled");
	outputText(" oven.  Her green eyes bulge obscenely at the sight of your naked flesh, locked tight to every curve of your shape.  The vixen takes one shuffling step after another.  It's clear from her crazed panting and trembling fingertips that she's trying to keep herself from jumping you with limited success.  She's like an addict eyeing a cornucopia stuffed with her favorite drugs, knowing that she must take it slow but helpless against her desire to gluttonously gorge.");

	outputText("\n\nYou toss a little fuel on the fire by spreading your legs");
	if (player.balls > 0) outputText(" and lifting your balls");
	outputText(", exposing your puffy lips, and spreading them wide to expose your ");
	if (player.vaginaType() != 5) outputText("pink, ");
	else outputText("dusky, ");
	outputText("glistening interior.  Urta whines, high pitched and keening, and she doubles over, pumping her cock with both hands, unashamedly masturbating at the sight of your exposed, vulnerable womanhood.  She grunts, swinging her hips lewdly back and forth, actually fucking her hands now, mouth open and panting, \"<i>Gonna... gonna fuck ya!  Fullofbabies!</i>\"");

	outputText("\n\nThe rutting prick-vixen thrusts so hard that the momentum carries her closer, and in her almost drunken haste, she tumbles head over heels.  With a ");
	if (player.wetness() >= 4) outputText("wet ");
	outputText("squish, she lands nose-deep in your vagina, immediately licking at it and tickling you with her smooth, slippery tongue.  \"<i>Mmmmm,</i>\" she purrs as she suckles your [clit].  Inching upward, the dripping wet fox-girl licks higher and higher, her tongue smearing across the " + player.skinFurScales() + " that covers your ");
	if (player.pregnancyIncubation > 0 && player.pregnancyIncubation < 150) outputText("rounded ");
	outputText("belly.  Urta's rigid onyx nipples tickle your [legs] as they drag upward, each immensely erect and engorged, just a little pebbly in texture.  She reaches your [chest], kissing up the ");
	if (player.biggestTitSize() > 1) outputText("soft curve");
	else outputText("flat muscles");
	outputText(" until she hits your [nipple].  ");
	if (player.hasFuckableNipples()) outputText("Her tongue plunges inside, savoring the feminine lubricants");
	else outputText("Her tongue plays across the surface, the heat of her breath shooting tingles up your spine");
	outputText(".  The further she climbs, the further up your [legs] you can feel her stallion-cock rising, a trail of clear pre-cum in its wake.");

	outputText("\n\nShe peaks up at you from below as she climbs, snarling, \"<i>I'm gonna fuck you so hard your cunt's going to turn into a mold of my dick, useless for anyone but ME!</i>\"  Her pupils are dilated crazily, and you have to wonder if she even realizes what she's saying at this point.  You put your hands on her cheeks, and pulling her up so that you can feel her blunt tip pressing deliciously upon your mound, you gently kiss her.  Urta's passion has her feverish.  You can feel the heat through her ebony lips as they press against your own.  She sags into you, distracted from her inescapable lust long enough to enjoy a tender moment with you.  You grab her butt and squeeze after a moment - she may be distracted, but her tongue and heat have spawned a similar level of need... of heat within you.");

	outputText("\n\nUrta blinks, the craziness returning in a snap, and without any warning, she grabs your shoulders, levering every ounce of her strength into violently penetrating you.  There's an audible, squishing-wet sound as her fat flare rams down your canal, scraping every sensitive bundle of nerves along the way.  It batters you wildly, stretching you ");
	if (player.vaginalCapacity() < 60) outputText("a little painfully");
	else outputText("deliciously");
	outputText(".  Her hands roam over the rest of your body with unrestrained ardor, groping and squeezing, pulling and tweaking.   Meanwhile, her hips smack against your own, smushing her sheath up against your puffy lips, her steamy sex dripping girl-lube down the back of her balls into a thick puddle on your blanket.  SLAP!  The sweaty nutsack slaps loud enough to be heard all over as Urta crudely fucks you, humping you artlessly, her hips beating out a confused, staccato rhythm.");
	player.cuntChange(60,true,true,false);

	outputText("\n\nYou hold on to her waist for support, teeth clacking against each other with each bone-jarring, cunt-filling rut.  Urta's gone absolutely wild!  Her copious, ever-dripping pre is pouring out of your abused, cock-gaped slit, unimpeded by the girthy horse-cock that enters and exits, so fast it might as well be a blur.  Helpless under the onslaught, you moan");
	if (player.hasCock()) {
		outputText(", your own forgotten length");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" laying on your stomach, bouncing fitfully but ultimately ignored.");
	}
	else outputText(", the slippery wetness of your [vagina] and the sheer hardness of your [clit] overwhelming.");
	outputText("  This feels better than it really ought to, perhaps in part thanks to your partner's copious fluids and supernaturally warm, feverish dick.");

	outputText("\n\n\"<i>Tight cunt!  Gonna... gonna... no, I gotta... gotta fill it up!</i>\" she cries, arching her back, tits jiggling over top of you as she climaxes.  Her sodden twat explodes over the back of her balls, splattering wetness in a five foot cone behind her.  At the same time, that slick sack begins to twitch again and again.  It feels like it's vibrating against your [butt], actually shuddering as liquid weight shifts and moves, pumping through the cock-bitch's interior.  Her sheath peels back a little further, and the gigantic equine length inside you distorts slightly, the fat shaft stretching your lips even wider as a huge wad of cum travels through the turgid horse-cock.");

	outputText("\n\nThere's an audible gurgle from inside you, and you feel the sticky, slippery spooge spreading through every nook and cranny of your [vagina], some even dripping into your womb.  Urta howls, yipping into the air as she crams herself even further inside you, butting her fat, flaring cockhead right up against your cervix.  The next cum-wave hits you with such pressure that most of it floods directly into your uterus, shooting straight through your slightly-dilated cervix without too much resistance.  You can feel it sloshing around, the heavy weight of the fox's liquid love filling you fuller and fuller, while the frothy, wasted sperm drips out of your wide-spread fuckhole.  Again and again, her orgasm inseminates your womb, seemingly without limit, rounding your belly with the slightest bump.  As the pressure builds, more and more of her baby batter slops out your entrance onto ");
	if (player.balls > 0) outputText("both sets of");
	else outputText("her");
	outputText(" balls, slathering them with slick spunk.");

	var ballWorship:Array = [];
	if ((amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2) && jojoScene.campCorruptJojo()) ballWorship[ballWorship.length] = 0;
	if ((amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 2) || jojoScene.campCorruptJojo()) ballWorship[ballWorship.length] = 1;
	if (sophieBimbo.bimboSophie()) ballWorship[ballWorship.length] = 2;
	if (helFollower.followerHel()) ballWorship[ballWorship.length] = 3;
	if (latexGirl.latexGooFollower()) ballWorship[ballWorship.length] = 4;
	if (flags[kFLAGS.VALARIA_AT_CAMP] == 1) ballWorship[ballWorship.length] = 5;
	var choice:int;
	if (ballWorship.length > 0) choice = ballWorship[rand(ballWorship.length)];
	else choice = -1;

	//{Both mouse pets}
	if (choice == 0) {
		outputText("\n\nUrta gasps when a pair of tongues find their way around her balls.  Looking back, she sees a pair of visages you'd recognize anywhere; the mousy head of your twin pets, Jojo and Amily.  The smooth mouse-tongues hungrily devour Urta's excess seed, accompanied by pleased giggles when the weighty orbs twitch with barely restrained pleasure.  Again and again, the mouth muscles smear themselves over every messy, slime-soaked fold, leaving nothing by a polished veneer of mouse-spit in their wake.  The sounds of masturbation accompany the ball-worship, leaving you no doubt about your pets' current states.  They love it, and when Urta turns back to you with a smile, you realize she doesn't mind either.");
	}
	//{If Jojo/Amily pet}
	else if (choice == 1) {
		outputText("\n\nUrta gasps when a tongue finds its way around her balls.  Looking back, she sees a visage you'd recognize anywhere; the mousy head of your pet, ");
		if (jojoScene.campCorruptJojo()) outputText("Jojo");
		else outputText("Amily");
		outputText(".  The smooth mouse-tongue hungrily devours Urta's excess seed, accompanied by pleased giggles when the weighty orbs twitch with barely restrained pleasure.  Again and again, the mouth muscle smears itself over every messy, slime-soaked fold, leaving nothing but a polished veneer of mouse-spit in its wake.  The sounds of masturbation accompany the ball-worship, leaving you no doubt about your pet's current state.  They love it, and when Urta turns back to you with a smile, you realize she doesn't mind either.");
	}
	//{Bimbo Sophie ball worship here}
	else if (choice == 2) {
		outputText("\n\nUrta gasps when gold gilt lips find their way onto her steaming, cum-drenched ball-sack.  Looking back, she can see the slutty bimbo harpy servicing her nuts, her plump puckers wrapped around one of the prodigious, cum-bloated testes.  \"<i>Mmmmmmm,</i>\" she coos around the fat gonad, sloppily kissing and licking, her tongue sliding through every crevice of the folded, sex-stained skin.  In no time flat, the big bootied bird bitch has polished away the slime and replaced it with a shining veneer of gold gloss overlaid in clear saliva.  Sophie giggles when Urta's dick begins to twitch inside you, rigid and ready for more.  The bimbo seems thrilled to polish the fox-girl's big, bouncy balls, and when Urta turns back to you with a blissful smile on her face, you realize she's enjoying it too.");
	}
	else if (choice == 3) {
		outputText("\n\nUrta gasps when a slithering tongue winds its way around her balls.  Looking back, she sees a scaley visage you'd recognize anywhere - the salamander berserker, Hel.   Hel chuckles around the black, slime-slicked folds in her mouth.  \"<i>Didja thfwink joo could, mmmm, get thwis fwox all to yerself, " + player2.short + "?</i>\" she says through the mouthful of vixensack.   The salamander-slut releases the musky black skin from her oral grip and continues, \"<i>You know I'm always up to get dirty with you and your friends, lover mine.</i>\"  She returns her attentions to the cum-bloated orbs before her, licking every bit of mixed cum from Urta's sack, replacing the thick sludge with a veneer of shining spit.");
		if (player.balls > 0) outputText("  She does the same to your own [balls], even giving your [asshole] a happy, sloppy kiss before returning to polishing the supple, skin-shrouded spheres just ahead.");
		outputText("  Helia seems thrilled to be egging you both on to new heights of pleasure, and when Urta turns back to you with a blissful smile on her face, you realize she's enjoying it too.");
	}
	//{Latexy}
	else if (choice == 4) {
		outputText("\n\nUrta gasps when a slithering tongue winds its way around her balls.  Looking back, she sees an inky black visage you'd recognize anywhere - your pet latex-girl, " + flags[kFLAGS.GOO_NAME] + ".  The still-rutting fox-futa seems a little put off by your ebony-skinned slave's dusky visage, but as more and more slippery latex bathes her balls, Urta's confusion softens into pleased acceptance.  Her thick, cum-bloated balls are getting some much-needed TLC, and she's clearly too turned on to care.  " + flags[kFLAGS.GOO_NAME] + " smoothly sucks one into her mouth, devouring the messy proof of your lover's virility from every inch of the vulpine gal's ball-shroud.   When Urta's nut pops out, it's solid black, encased in wonderful, constricting latex.  She repeats the action on the other side so as to fully clean the fox, and then she turns to you, applying the same treatment to every messy spot below your waist.  Of course, she keeps returning to the blissful, fuck-crazed fox's balls, thickening the plump latex bindings around them at every turn.");
	}
	//{Valeria}
	else if (choice == 5) outputText("\n\nUrta gasps when moist pressure suddenly envelops her balls.  Looking back, she sees a puddle of blue goo you'd recognize anywhere - your friendly, armored goo-girl, Valeria.  The slimy seductress seems to have left her armor behind for now, opting to condense herself into a moist ball of slime with only her breasts, shoulders, and head coming out of the top of it.  Each of her ponderous, growing tits is far larger than normal, nearly as big as a beachball and capped with plump mouths in place of nipples that can only be described as gifted 'cock-sucking lips'.  Each of those mouths is pressed next to the other, tit to tit, and together, they've pulled Urta's sack into their gelatinous, slippering interior.  The skin that restrains Urta's tortured balls slides through the semipermeable membrane between them.  Her gonads are floating inside the warm, cushiony blue mass while the lips kiss all over her sheath, taint, and loins, even inserting slobbering slippery tongues into her cunt.  Meanwhile, the accumulated sex-slime that coated Urta's testicular endowments has begun to lift away, absorbed into the goo-girl for sustenance.  She seems thrilled to have found such an erotic situation to plunge herself into, and judging by the blissful expression your foxy lover's face, she's enjoying it just as much.");
	//{If no ball licking}
	else {
		outputText("\n\nSmiling, Urta continues to slowly hump you.  Inside, her horse-cock has begun to soften, allowing much of her bounty to slide out, but her motions don't slow.  She kisses you all over - on your lips, your [chest], your shoulders, and even the nape of your neck.  You groan, more turned on than ever, tilting your head back and allowing her to ply your sensitive flesh with kisses.  Inside you, the spent equine dong has begun to stiffen anew, the soaked balls shuddering with every slap against your [butt] as she makes ready for round two.  You're nearly as ready as she is.");
	}
	//{CONTINUE HERE}
	outputText("\n\nPulling out, Urta swats your [butt], lingering just long enough to give it a familiar squeeze.  She commands, \"<i>Ass up in the air, I'm going to take you like an animal!</i>\"  Holding it one-handed, the furry hermaphrodite slaps her equine phallus against you, encouraging you to roll over.  You're horny as hell, your [vagina] hanging open in the shape of the recently departed animal dong, and you willingly assume the position, [butt] up in the air");
	if (player.tailType > TAIL_TYPE_NONE) outputText(", though getting your tail angled right to allow her entrance is a bit of a challenge");
	else if (player.isTaur()) outputText(", though getting down on your hands and forelegs is a bit challenging for you");
	else outputText(", [face] buried in your blankets soaked with Urta's musky fluid");
	outputText(".");
	outputText("\n\nFrom behind, the hot, familiar head of your lover's member pierces your womanly view.  It slides through your slick, cum-soaked passage with ease, butting right up against your cervix as it bottoms out again.  Urta kneads the " + player.skinFurScales() + " on your [butt], happily beginning to hump you all over again.  The wet squishes are much louder, wetter, and noisier than ever before.  Voraciously, the fox-girl pounds you, a brutal, wet fuck that sends leftover cum, pre and girlish lube splattering everywhere.  Your blankets, if they weren't already, are now ruined, soaked in an inch-deep puddle of sex.");

	outputText("\n\nWhen her massive shaft bottoms out again, it scrapes across your g-spot in just the right way, and the fireworks going off in your [vagina] push you so far past the point of orgasm that your muscles seize.  ");
	if (player.wetness() >= 5) outputText("Lady-spunk showers out of your spasming twat, glazing Urta's bouncy ballsack with your lusty liquid.");
	else if (player.wetness() >= 3) outputText("Lady-spunk drools out of your spasming twat in thick streams, glazing Urta's bouncy ballsack with your liquid lust.");
	else if (player.wetness() >= 1) outputText("Lady-spunk drips from your spasming twat in steady trickles, glazing Urta's bouncy ballsack with your liquid lust.");
	outputText("  The hungry mouth between her legs wastes no time in cleaning them.");
	outputText("  Again and again, muscular contractions wiggle through your canal, wringing Urta's swollen staff of impregnation, milking it for more, even though your womb is STILL slightly distended from her last deposit.");
	outputText("\n\n\"<i>You're gonna be so pregnant, " + player.short + "!</i>\" she cries, smacking her hand across your [butt] hard enough to feel the ripple through your middle.  \"<i>You're going to be the mother of a god, and then... then I'll knock you up with kits!  We'll have so many babies, " + player.short + "...</i>\"  Her hand caresses your rump as she rambles, plowing your wet pussy again and again.  \"<i>You're so hot, lover...  Mmmm, your tight little box already knows my dick doesn't it?  I think it's gonna... ooooohhhh...  I'm gonna cum again!</i>\"");

	outputText("\n\nSlamming herself into you hard enough to drag your face across the ground, she utterly assaults your backside, a woman gone wild, drunk on sex, lust, and pussy.  Her dick thickens with lust and cums again, spraying you down with her thick, sticky, virile semen.  It's so potent that it feels like it's painting you with jellied spunk, every bit of your reproductive system stopped up with soon-to-be-baby.  A few squirts roll out over your [clit], dripping down below, but the bulk pumps directly into your womb with belly-rounding force.  You climax again, an orgasm on top of an orgasm, and your shuddering [legs] give out, causing you to slide off Urta's member and fall on your side.");

	outputText("\n\nShe pumps her slick shaft with both her fists, hosing you down with seed as she empties the last of her lust atop you.  You blink, white webs of animal jizz plastering your face, and you fall back into the puddle, cradling your stretched-out tummy.  Below, your [vagina] is gaped in a nice round shape, with a distended slot for your lover's bulgy cum-vein to slide inside, tickled on all sides by velvet slickness.  You doubt it'll stay like that, but the thought brings a pleasant tingle to your orgasm-wrecked consciousness as you begin to slumber, cooing when the familiar warmth enters you once more.");

	outputText("\n\n\"<i>Sweet dreams,</i>\" a breathy voice whispers in your ear, just before it begins to kiss you again...");
	//[Next]
	menu();
	addButton(0,"Next",getKnockedUpUrtaEpilogue);
}

//Post-Sex Epilogue*
private function getKnockedUpUrtaEpilogue():void {
	clearOutput();
	outputText("When you wake, you're ");
	if (player.pregnancyIncubation > 0 && player.pregnancyIncubation < 150) outputText("much more ");
	outputText("pregnant ");
	if (player.pregnancyIncubation > 0 && player.pregnancyIncubation < 150) outputText("than before");
	else outputText("- very pregnant");
	outputText(".  Whatever Urta just put inside you, it's developing fast.  Fast enough to give you a wobbling gait and a straining midriff.  You give the snoring fox a prod.  Her only reaction is to swat at your finger with her fluffy tail and roll over snoring, so this time, you jab her hard, in the butt-cheek.  She yelps, sitting upright immediately.");
	outputText("\n\n\"<i>What was that for - oooh gods...  did I - are you...  We need to get you to the Covenant!</i>\" she stutters on her way to a decision.  You nod - you've no idea what this thing is going to do to your body before it comes out, but having a magically gifted organization tending to your welfare will be a start.  You'll just have to hope the demons don't make a move on the portal in your absence.");
	outputText("\n\nUrta begins belting on her gear, and you do the same - well, what still fits anyway.  For added protection, your well-endowed lover shrouds you in a blanket, and taking your hand, she begins to lead you toward Tel'Adre.  A few times you have to rest, tired and aching, feeling like your [feet] have swollen up.  Urta is always there with a kind word and a nervous smile, looping her arm under your own for support.  The journey is uneventful, save for the incessant kicking in your middle.");
	outputText("\n\nBefore you know it, you're being waved through the gates.  Urta puts you up on Edryn's back, and together the two of them haul you to the Covenant's tower.  Countless guards have to be addressed at each step of the journey, but eventually, you're brought to a comfortable chamber and allowed to rest... when the mages aren't probing you with magic that is.  Urta stays by your side the entire time, never leaving, not even when she falls asleep on your shoulder, completely tuckered out.  You snuggle up against her and snooze with her, under the vigilant eyes of your guards.  If you weren't so hormonal and tired, you might have had a hard time falling asleep.  Instead, rest comes easily.");
	//[Next]
	menu();
	addButton(0,"Next",getKnockedUpByUrtaEpilogueII);
	model.time.days++;
	model.time.hours = 7;
}
//Urta & Pregged PC  With God-child epilogue:
private function getKnockedUpByUrtaEpilogueII():void {
	clearOutput();
	outputText("You wake to pangs of labor, an unmistakable, forceful pushing emanating from within you.  Loudly, you yell, \"<i>It's coming!</i>\" which launches the room into a flurry of activity.  Your water breaks, gushing from your [vagina] and soaking the floor ahead of you with the clear, amniotic fluids.  One contraction after another begins to hit you, causing you no small amount of pain as your cervix dilates, preparing to disgorge the new life within you.");

	outputText("\n\nUnfortunately for you, even with your labor's rapid onset, it takes its sweet time getting there.  For nearly five hours, you're kept waiting, clenching Urta's hand for support whenever the pain becomes too much.  The time passes with agonizing slowness, though the room fills with more and more of the wizards as your labor drags on.  Soft blankets and pillows are gathered, to protect the child when it exits your body, and thankfully, you begin to feel it moving, travelling down your canal as your body compels you to push, to squeeze as hard as you've ever tried.  Then, with a tremendous, sucking, wrenching changing of pleasure, it slips free.");
	player.cuntChange(40,true,true,false);

	outputText("\n\nSlick with birthing fluids, a ball of fur, skin, and bones rolls out onto gathered blankets.  Exhaustion tries to claim you, but you pull yourself up on your forearms and squint at it, wondering just what everybody is so excited about - it looks little and messy, like any other newborn.  It strikes you as odd that you feel no motherly affection for the little bundle.");

	outputText("\n\nThe ball unfolds itself, one spindly leg at a time, each covered in a short layer of fuzz.  The limbs seem too tiny, too frail, even for a creature new to this world.  A hand disengages itself from the rest of the mass, stringing the clear birthing fluids behind it, revealing an equally frail-looking arm.  You can see its head now, fox-like, with a long vulpine muzzle and large, luminous eyes.  The newborn rises on its newly revealed limbs and stretches, standing almost five feet tall when fully unfolded.");

	outputText("\n\n<i>I live.</i>");

	outputText("\n\nThe voice isn't spoken aloud but inside you, inside your head.  A glance to Urta reveals that she heard it too.  The creature - Taoth, you correct yourself, cocks its head toward Urta, giving your thigh a familiar pat.");
	if (player.pregnancyIncubation > 0 && player.pregnancyIncubation < 150) outputText("  Somehow, you're still just as pregnant with something as you were before.");
	outputText("  You're filled with vigor at the touch, the stress of the birth fading immediately.  Even your poor, tortured vagina tingles, the pain fading.  You can feel the pregnant gape receding, as if the birth never happened.");

	outputText("\n\n<i>Thank you, Urta-father.</i>  The mental voice speaks again, unmatched by the newborn's vocal cords.  It approaches Urta confidently, with long, loping steps, seeming... almost unnatural in the way that the limbs seem to sway and dance.  Just a few steps away from Urta, a moment of panic surges through you - what if he hurts her?!  You start to rise, to interpose yourself between them, but Urta puts a reassuring hand to your chest, flicking her emerald eyes towards you, begging you not to interfere.  You lay back down, reluctantly");
	if (player.cor >= 66) outputText(", what do you care, anyway?");
	else outputText(".");
	outputText("\n\n<i>I shall uphold my end of the bargain, Urta-father.</i>  A tiny hand presses against your foxy lover's middle, glowing amber in the dim lighting of the birthing chamber.  Urta whimpers, knees wobbling, as if undergoing great pain.  \"<i>Relax, Urta-father.  I have undone the damage caused by my presence, and bestowed a gift as well.  No longer shall you suffer on, infertile.  Your fertility and virility are now YOURS to command.  Pregnant or father, the choice is yours and yours alone.</i>\"  Urta looks nervously around the room, flicking her eyes between the assembled, awestruck wizards and wise-men.");

	outputText("\n\n<i>None but you and " + player.short + "-mother have heard this.  Be well, Urta-father, and should we meet again, do not expect my deals to be so favorable.</i>");

	outputText("\n\nUrta nods down at the child-god, now standing almost five-foot six.  He gives a wry smile and a mocking bow, then turns, confidently loping down a hallway.  The room erupts into chaos, the mages chasing after him, trailing at his heels.  It seems Taoth can take care of himself, and for now, you've got a newly fertile lover.");

	outputText("\n\nThe fox-girl drags you into a huge hug, kissing you passionately.  She whispers, \"<i>Thank you so much for getting me started on this road, " + player.short + ".  I bet you're exhausted now, but come see me at the Wet Bitch later, and maybe... maybe we could see about starting a family.  I mean, maybe there's hope after all?  A dead god was reincarnated!</i>\"");

	outputText("\n\nShe helps leave the tower, arm in arm, saying her goodbye only after she's tucked you in to take a rest.  Urta gives you a teary kiss and trots back towards the city with a swagger in her step.  You wonder if Taoth will help the Covenant, or if they've bitten off more than they can chew?  Either way, it seems there's a potent new ally on the field.");
	flags[kFLAGS.URTA_QUEST_STATUS] = 1;
	getGame().inCombat = false;
	doNext(camp.returnToCampUseOneHour);
}

//Urta Goes to Knock Up Edryn with God Child*
private function urtaAndEdrynGodChild():void {
	clearOutput();
	outputText("Urta shudders from head to toe, barely able to restrain herself around you.  \"<i>Oooooh... uh... okay, then.  I'll come back... when... when it's time, okay?</i>\" she titters, almost drunkenly, already prancing off towards the desert.  The lusty vixen looks over her shoulder at you as she jogs off, a trail of lubricant spattering in her wake, her tongue lolling wildly as her eye-humps you.  After a long moment, she looks away, perhaps unable to bear gazing on you any longer.  You hope everything turns out okay...");
	//[Urta and Edryn disabled until birth event]
	flags[kFLAGS.URTA_FERTILE]        = telAdre.edryn.pregnancy.type;       //Use these two flags to store the pregnancy that Taoth is overriding.
	flags[kFLAGS.URTA_PREG_EVERYBODY] = telAdre.edryn.pregnancy.incubation; //Since they can't be in use prior to Taoth being born this is fine.
	telAdre.edryn.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_TAOTH, 24);
	getGame().inCombat = false;
	doNext(camp.returnToCampUseOneHour);
}



//Urta & Edryn God-child epilogue:*
public function urtaAndEdrynGodChildEpilogue():void {
	outputText("\nA fast-moving figure appears in the distance, kicking up a cloud of dust and sand behind it.  Before you know it, the blur skids to a stop in your camp - it's Urta!  She's decked out in full battle gear, armored leather, halberd, and all.");

	outputText("\n\n\"<i>Hey... " + player.short + "... damn...</i>\" she says, doubling over with her hands on her knees, \"<i>Just gotta catch... my breath...</i>\"  She huffs and puffs, tongue flaring as she pants to recover.  What's the hurry?  Did something happen with that 'Taoth' spirit she was rambling about the other day?  You put your hand on her shoulder and let her lean against you.");
	outputText("\n\nUrta turns her green eyes your way and smiles.  \"<i>Thanks, love.</i>\"  Her happiness at seeing you is short-lived, overpowered almost immediately by some pressing urgency.  \"<i>Come on, we have to go back to the city!  I came to get you - Taoth's going to be born!  We need to go now - a living god is about to be born!</i>\"  She grabs your hand and tugs, starting to drag you along in her haste.");

	outputText("\n\nYou pull free of her grip and move along with her.  If Urta had a god inside her... well, damn...  That's a little much to take in right now.  She's right though, this isn't something you want to miss!");
	outputText("\n\nTel'Adre's gates loom ahead before long, and you're lead deep into the city, to the tower where Edryn is in labor...");
	menu();
	addButton(0,"Next",urtaAndEdrynGodChildEpilogueII);
}

//[Next]
private function urtaAndEdrynGodChildEpilogueII():void {
	clearOutput();
	outputText("As the double doors open, you hear a painful moan from the ");
	//{pre-pregnant }

	outputText("horse-girl.");
	if (kGAMECLASS.telAdre.edryn.pregnancy.isPregnant) outputText("  Just how did she get pregnant again when she was already knocked up?  ...Magic, maybe.");
	outputText("  Urta leads you around a bend, squeezing your hand for comfort.  \"<i>Thank you for everything, " + player.short + ", most of all being so understanding.</i>\"  The gray-furred fox pushes past the sixth pair of guards you've seen since entering the tower, just inside to see Edryn splayed on the floor, groaning and heaving, her ");
	if (kGAMECLASS.telAdre.edryn.pregnancy.isPregnant) outputText("massively ");
	outputText("pregnant flanks rippling with muscular contractions.   Something is bulging against her nether-lips, stretching the massive horse-cunt wider and wider with each passing moment.");

	outputText("\n\nSlick with birthing fluids, a ball of fur, skin, and bones rolls out onto a mat placed there a moment before by a nearby centaur.  You squint at it, wondering just what everybody is so excited about - it looks little and messy, like any other newborn.");

	outputText("\n\nThe ball unfolds itself, one spindly leg at a time, each covered in a short layer of fuzz.  The limbs seem too tiny, too frail, even for a creature new to this world.  A hand disengages itself from the rest of the mass, stringing the clear birthing fluids behind it, revealing an equally frail-looking arm.  You can see its head now, fox-like, with a long vulpine muzzle and large, luminous eyes.  The newborn rises on it's newly revealed limbs and stretches, standing almost five feet tall when fully unfolded.");

	outputText("\n\n<i>I live.</i>");

	outputText("\n\nThe voice isn't spoken aloud but inside, inside your head.  A glance to Urta reveals that she heard it too.  The creature - Taoth, you correct yourself, cocks its head toward Urta, giving Edryn's ass a familiar pat.");
	if (kGAMECLASS.telAdre.edryn.pregnancy.isPregnant) outputText("  The centaur guardswoman is still just as pregnant with your offspring as before.  Your child is unharmed by whatever just transpired.");
	outputText("  Edryn's eyes immediately close, sinking into a deep, restful sleep.");
	outputText("\n\n<i>Thank you, Urta-father.</i>  The mental voice speaks again, unmatched by the newborn's vocal cords.  It strides confidently forward, with long, loping steps, seeming... almost unnatural in the way that the limbs seem to sway and dance.  Just a few steps away from Urta, a moment of panic surges through you - what if he hurts her?!  You start to interpose yourself between them, but Urta puts a reassuring hand to your chest, flicking her emerald eyes towards you, begging you not to interfere.  You step back, reluctantly");
	if (player.cor > 66) outputText(", what do you care, anyway?");
	else outputText(".");
	outputText("\n\n<i>I shall uphold my end of the bargain, Urta-father.</i>  A tiny hand presses against your foxy lover's middle, glowing amber in the dim lighting of the birthing chamber.  Urta whimpers, knees wobbling, as if undergoing great pain.  <i>Relax, Urta-father.  I have undone the damage caused by my presence, and bestowed a gift as well.  No longer shall you suffer on, infertile.  Your fertility and virility are now YOURS to command.  Mother or father, the choice is yours and yours alone.</i>  Urta looks nervously around the room, flicking her eyes between the assembled, awestruck wizards and wise-men.");
	outputText("\n\n<i>None but you, your love, and Edryn-mother have heard this.  Be well, Urta-father, and should we meet again, do not expect my deals to be so favorable.</i>");

	outputText("\n\nUrta nods down at the child-god, now standing almost five-foot six.  He gives a wry smile and a mocking bow, then turns, confidently loping down a hallway.  The room erupts into chaos, the mages chasing after him, trailing at his heels.  It seems Taoth can take care of himself, for now, you've got a newly fertile lover.");
	outputText("\n\nThe fox drags you into a huge hug, kissing you passionately.  She whispers, \"<i>Thank you so much for getting me started on this road, " + player.short + ".  I'm exhausted after tending to Edryn and the run to get you, but come see me at the Wet Bitch later, and maybe... maybe we could see about starting a family.  I mean, maybe there's hope after all?  A dead god was reincarnated!</i>\"");
	outputText("\n\nYou leave the tower arm in arm, saying your goodbye when Urta stops at her place to rest.  She gives you a teary kiss and sends you on your way with a swagger in your step.  You wonder if Taoth will help the Covenant, or if they've bitten off more than they can chew?  Either way, it seems there's a potent new ally on the field.");
	//set completed tags!
	flags[kFLAGS.URTA_QUEST_STATUS] = 1;
	getGame().inCombat = false;
	doNext(camp.returnToCampUseOneHour);
}
}
}
