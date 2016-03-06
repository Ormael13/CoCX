package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class HelScene extends NPCAwareContent implements TimeAwareInterface {

		public var pregnancy:PregnancyStore;

		public function HelScene()
		{
			pregnancy = new PregnancyStore(kFLAGS.HELIA_PREGNANCY_TYPE, kFLAGS.HEL_PREGNANCY_INCUBATION, 0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 300, 200, 100);
												//Event: 0 (= not pregnant),  1,   2,   3,  4 (< 100)
			CoC.timeAwareClassAdd(this);
		}
		
		private var checkedHeliaIsabellaThreesome:int;
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			checkedHeliaIsabellaThreesome = 0; //Make sure we test just once in timeChangeLarge
			pregnancy.pregnancyAdvance();
			trace("\nHelia time change: Time is " + model.time.hours + ", incubation: " + pregnancy.incubation + ", event: " + pregnancy.event, false);
			if (model.time.hours > 23) {
				if (flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] > 0) flags[kFLAGS.HELSPAWN_GROWUP_COUNTER]++;
				if (flags[kFLAGS.HEL_RAPED_TODAY] == 1) flags[kFLAGS.HEL_RAPED_TODAY] = 0;
			}
			if (model.time.hours == 3 && followerHel() && flags[kFLAGS.SLEEP_WITH] == "Helia" && rand(10) == 0 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
				kGAMECLASS.helFollower.sleepyNightMareHel();
				return true;
			}
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			//Helia's morning surprise!
			if (getGame().model.time.hours == 23 && helFollower.followerHel() && flags[kFLAGS.HEL_BONUS_POINTS] >= 150 && flags[kFLAGS.HELIA_KIDS_CHAT] == 0) {
				helSpawnScene.heliaBonusPointsAward();
				return true;
			}
			if (model.time.hours == 8 && helFollower.followerHel() && flags[kFLAGS.HEL_NTR_TRACKER] == 1 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
				helSpawnScene.helGotKnockedUp();
				return true;
			}
			if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1 && flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] > 0 && helFollower.helAffection() >= 100 &&
				flags[kFLAGS.HELIA_FOLLOWER_DISABLED] == 0 && model.time.hours == 2 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
				helFollower.heliaFollowerIntro();
				return true;   
			}
			if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == -1 && model.time.hours == 6 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
				kGAMECLASS.dungeons.heltower.morningAfterHeliaDungeonAgreements();
				return true;
			}
			//Helspawn night smex!
			if (flags[kFLAGS.HELSPAWN_AGE] == 2 && (model.time.hours == 2 || model.time.hours == 3 || model.time.hours == 4) && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] == 7 && flags[kFLAGS.HELSPAWN_FUCK_INTERRUPTUS] == 0) {
				helSpawnScene.helspawnIsASlut();
				return true;
			}
			//Chance of threesomes!
			if (checkedHeliaIsabellaThreesome++ == 0 && flags[kFLAGS.HEL_FUCKBUDDY] == 1 && getGame().isabellaFollowerScene.isabellaFollower() && model.time.hours == 2 && model.time.days % 11 == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
				trace("ISABELLA/HELL TEST");
				if (flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 0) { //Hell/Izzy threesome intro
					spriteSelect(31);
					followrIzzyxSallyThreesomePretext();
					return true;
				}
				else if (flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 1) { //Propah threesomes here!
					spriteSelect(31);
					isabellaXHelThreeSomeCampStart();
					return true;
				}
			}
			return false;
		}
		//End of Interface Implementation

	override public function followerHel():Boolean {
		if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2) return true;
		//This is a temporary fix
		if (flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 1) return false;
		if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] > 0) return true;
		return false;
	}

	public function fuckBuddyHel():Boolean {
		return (flags[kFLAGS.HEL_FUCKBUDDY] == 1);
	}
//VARS
//const HEL_TALKED_ABOUT_BERSERKING:int = 390;
//const HEL_TALKED_ABOUT_HER:int = 391;
//const HEL_TALKED_ABOUT_ATTACKING_YOU:int = 392;
//const HEL_FUCKBUDDY:int = 393;
//const HEL_FUCK_COUNTER:int = 394;
//const HEL_AFFECTION:int = 395;
//const HEL_TIMES_ENCOUNTERED:int = 396;
//const HEL_ISABELLA_THREESOME_ENABLED:int = 397;
//const HEL_FOXY_FOURSOME_WARNED:int = 417;
//const PC_PROMISED_HEL_MONOGAMY_FUCKS:int = 705;
//const HEL_RAPED_TODAY:int = 706;
//const TIMES_HELIA_DOUBLE_DONGED:int = 786;

//Randomly encountered when EXPLORING the PLAINS.
//REQUIRES FOUGHT GNOLL!

//Introduction – First Encounter
public function encounterAJerkInThePlains():void {
	spriteSelect(68);
	flags[kFLAGS.HEL_TIMES_ENCOUNTERED]++;
	//Mino threesome proc
	if (flags[kFLAGS.HEL_AFFECTION] > 0 && flags[kFLAGS.HEL_AFFECTION] % 5 == 0 && flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 0) {
		helMinotaurThreesome();
		return;
	}
	//Fuckbuddies get alt greating.
	if (fuckBuddyHel()) {
		greetHelAsFuckbuddies();
		return;
	}
	//First time greeting
	if (flags[kFLAGS.HEL_TIMES_ENCOUNTERED] == 1) {
		clearOutput();
		outputText("The tall grass of the plains seems to stretch out infinitely around you, your view broken only by the softly rolling hills.  If you were not skirting the territory of the Gnolls, you could almost call it a peaceful place.  Your guard is up, however, as you walk carefully across the vast grasslands.\n\n", false);
		
		outputText("Suddenly, you hear a piercing cry from over the nearest hill.  Perking up your ears, you can just faintly hear the sound of steel clashing against steel and grunts of effort and pain.  The sounds of a battle!  Well, you're the Champion after all, and damned if that doesn't mean it's your business to find out what's going on.  You steel yourself for battle and, preparing your " + player.weaponName + " for combat, charge up over the hilltop!\n\n", false);
	
		outputText("You arrive just as the battle seems to be winding down, laying eyes on the combatants just as one of them plants her ass in the dirt with an '<i>OOMPH</i>'.  The downed fighter is one of the Gnoll spear-throwers, clutching desperately for one of her remaining javelins in a vain attempt to stave off utter defeat.\n\n", false);
	
		outputText("Standing over her is another woman, vaguely human in appearance, save for the long and fiery tail protruding from her ample backside and the scales that cover her legs, back, and forearms.  With an evil grin, she marches up to her opponent and kicks the Gnoll's last Javelin out of reach, cementing her dominance even as she sheaths her long, curved sword and reaches for the straps of her skimpy bra, ready to take advantage of her conquest.  Suddenly, though, her gaze snaps to the hills, sensing your approach.  Her eyes light up as she casually kicks the defeated Gnoll in the head, knocking her out, and draws her sword once more.  With a feral roar, she charges straight at you!\n\n", false);
	}
	else {
		outputText("You are exploring the grasslands not far from the gnoll camp when you hear a sudden, savage warcry.  You spin around just in time to see the salamander berserker you fought before lunging at you, fire blazing on her tail and sword arcing toward you.  You duck and roll, just avoiding the first assault as you ready your " + player.weaponName + " for battle.\n\n", false);

		outputText("\"<i>Hey there, ace!</i>\" she says, grinning through her teeth as she assumes a battle stance.  \"<i>Who's ready for a re-match!?</i>\"", false);
	}
	if (flags[kFLAGS.CODEX_ENTRY_SALAMANDERS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_SALAMANDERS] = 1;
		outputText("<b>New codex entry unlocked: Salamanders!</b>")
	}
	//FIRST COMBAT – Main Screen
	startCombat(new Hel());
}

//FUCKBUDDY GREETING (edited)
private function greetHelAsFuckbuddies():void {
	spriteSelect(68);
	clearOutput();
	outputText("You make your way out onto the wide open plains.  Soon, you're enjoying a walk into hot, dry expanse, slowly meandering through the tall grasses.  But it isn't long before you hear footfalls quickly approaching.  You prepare for violence, but are pleasantly surprised to see Hel break through the tall grasses, her wide hips swaying seductively as she approaches.\n\n", false);

	outputText("\"<i>Hey there, " + player.short + ",</i>\" she says, quickly wrapping you in a tight hug.  You return it, and spend the next few minutes chatting amicably with your salamander lover.  After a while, though, Hel steps back from your embrace and, giving her ample endowments a little shake, asks, \"<i>So, lover mine, care to blow off some steam?</i>\"", false);
	if (player.lust < 40) {
		player.lust = 40;
		dynStats("lus", 1);
	}
	//(Normal Player Victory sex options display)
	helFuckMenu();
}

//PARTING FUCKBUDDIES (edited)
private function postHelFuckBuddyFollowup():void {
	spriteSelect(68);
	if (followerHel()) {
		camp.returnToCampUseOneHour();
		return;
	}
	if (flags[kFLAGS.HEL_FUCKBUDDY] == 0) {
		camp.returnToCampUseOneHour();
		return;
	}
	clearOutput();
	outputText("You wake up an hour or so later, still snuggled up to Hel, entwined in a post-coitus repose.  You spend a few moments basking in the warmth of her presence, but you know you have duties to attend to.  You give her a peck on the cheek, waking her, and she's quick to escalate your gesture into a long, tongue-entwining kiss.\n\n", false);

	outputText("The two of you redress, teasing and flirting all the while – you give her ample ass a little smack, and she coyly brushes your thighs with her tail – but soon you must part.  Giving Hel another deep kiss, you make your way back to camp as she saunters off into the heart of the plains.", false);
	doNext(camp.returnToCampUseOneHour);
}


//FIRST COMBAT – PLAYER LOSES
internal function loseToSalamander():void {
	spriteSelect(68);
	clearOutput();
	//(If HP loss) 
	if (player.HP < 1) outputText("You collapse on the ground just a few steps away from the unconscious Gnoll, overwhelmed by pain and exhaustion caused by the berzerker's onslaught.", false);
	//(If Lust loss)
	else outputText("Your arousal is too great, and your mind can no longer focus on anything but a desperate need for release.  Your knees buckle and you collapse", false);	
	if (flags[kFLAGS.HEL_TIMES_ENCOUNTERED] == 1) outputText(", lying just a few paces from the defeated Gnoll.\n\nYou look up to see the salamander girl looming over you, slowly removing her bikini, revealing her ample breasts and a shaved cunt already glistening with lubricant.  For the first time, she speaks.  \"<i>All right!</i>\" she exclaims, grinning, \"<i>You're not bad with your " + player.weaponName + ", you know. Damn, but it's hard to find someone worth my time around here,</i>\" she nods to the defeated Gnoll \"<i>... And you're not bad looking, either.  You know, there's nothing better after a fight than a good fuck, huh? Whadda ya say?</i>\"  Taken aback by the reckless berzerker's sudden calm, friendly attitude, you try to open your mouth to answer her, but she quickly plants a scaled heel on your chest.  Getting the idea, you shut up; you don't have much choice here, so you might as well enjoy it.\n\n", false);
	else outputText(".\n\nYou look up to see the salamander girl looming over you, slowly removing her bikini, revealing her ample breasts and a glistening cunt.  \"<i>You're a worthy opponent, you know that?  C'mon, there's no shame in losing,</i>\" she says, offering a hand up.  Shakily, you take it – and she pulls you right into a rough kiss.\n\n\"<i>But, to the victor go the spoils,</i>\" she says, pushing her chest into you.  Well, you might as well enjoy yourself...", false);
	var x:Number = 0;
	if (rand(4) == 0 && player.gender > 0) {
		trace("Peg scene GO!")
		menu();
		addButton(0, "Next", helTailPegging, true);
		return;
	}
	//TO ZE RAPES!
	//Player Loss – Rape – Male =< 85 cockarea
	if (player.hasCock() && (player.gender == 1 || rand(4) < 3) && player.cockThatFits(85) >= 0) {
		x = player.cockThatFits(85);
		outputText("The salamander pulls off your " + player.armorName + " with practiced speed, ", false);
		if (player.gender == 3) outputText("revealing your " + player.vaginaDescript(0) + " and ", false);
		outputText("letting your " + player.cockDescript(x) + " flop free, already hardened and ready for action.  She kneels down, straddling you, and grasps your " + player.cockDescript(x) + " firmly in both of her smoothly scaled, clawed hands.  You're nervous for a moment, eyes flickering to her long, sharp nails.  Seeing the concern in your eye, she laughs amicably.  \"<i>Hey, don't worry, lover.  I wouldn't ruin a perfectly good cock like this...  At least, not without getting a sample first...</i>\" she says, grinning.  For emphasis, she leans down and gives your " + player.cockDescript(x) + " a slow, sensuous lick with her long, forked tongue.\n\n", false);

		outputText("She moans lustily at the taste of cockflesh, and begins to pump your " + player.cockDescript(0) + " with one hand as her other wanders up and begins to caress her heavy tits, grasping one for a moment, then reaching over and tweaking the other's nipple so hard she winces.  She continues the show for a good minute or two, pumping your cock in time with her self-pleasuring.  You're as hard as you'll ever be, and when you manage to tear your gaze away from her luscious tits, you can see trickles of moisture running down her thighs, signaling her own readiness for you.\n\n", false);

		outputText("\"<i>Ready for the best fuck under the sun?</i>\" she asks cockily, lining her cunt up with your cock head.  Before she lowers herself down onto you, however, she quickly grabs your hands and sets them to work on her breasts.  She leans heavily upon your grasp as she sinks down, engulfing the tip of your cock.  The inside of her slick slit feels like it's on fire, burning with need and the flame of her native element both.  You gasp at the sudden explosion of heat around your sensitive cock flesh, only just containing an urgent need to orgasm.\n\n", false);

		outputText("\"<i>Oh, you like the heat, huh?  Does that get you off?  Well, how about some of THIS!</i>\" she laughs, suddenly ramming you inside her, swallowing you to the base of your cock.  You gasp in delight, mind numbed by the half-pain, half-pleasure of the burning sensation around your cock.  Your mouth lolls open, and seeing an opening, your fiery lover brings her burning tail around.  You nearly scream in terror as she shoots the tip of her tail into your mouth, afraid of burning your tongue off, but the flames there seem to have cooled to a manageable heat.  \"<i>Go on, then,</i>\" she goads, sitting still on your cock and wriggling her tail.  \"<i>Suck it!</i>\"\n\n", false);

		outputText("If only to get her working on your cock, you start sucking on her tail like it was her own prick, licking the underside and nibbling on the soft, yielding scales.  Satisfied, she starts to rise on your " + player.cockDescript(x) + ", letting it taste the mercifully cool air of the plains – before thrusting back down upon you, engulfing you in her searing heat.  The two of you continue like this for some time, you busily working her tits and sucking her tail as she fucks your " + player.cockDescript(x) + ", thrilling your mind with the intense disparity between cool air and burning depths.\n\n", false);

		outputText("Finally, you can take no more.  You feel the mounting pressure in your crotch, signaling impending orgasm.  You clamp down hard on her pillowy tits and give a mighty last suck on the tip of her tail as you pump a burst of spunk deep inside her", false);
		if (player.gender == 3) outputText(" and your vag begins to squirt girlcum onto her scaled thighs", false);
		outputText(".  She gasps at the sensation and grabs your hips as another shot goes off inside her.  Panting, she gives you one massive, final thrust and cums herself, squeezing your " + player.cockDescript(x) + " hard inside her and screaming as brutal a scream as any warcry to the heavens.", false);

		outputText("She collapses atop you, panting heavily.  \"<i>That.  Was.  Awesome,</i>\" she laughs, reaching up to give your nipple a pinch as she nestles her head on you.  Your cock begins to deflate inside her as trickles of spooge spill out around your girth, but she doesn't seem intent on leaving any time soon, and you have to admit, the warmth of her against you is more than nice.  The salamander gives you one last grin and withdraws her tail from your lips.  A moment later, she slides it under your head like a pillow, and closes her eyes, exhausted.  Soon, you, too, fall into a peaceful sleep.\n\n", false);
	}
	//Player Loss – Rape – Female
	else if (player.hasVagina()) {
		outputText("\"<i>Hmm, I've always loved a tumble with another woman,</i>\" the salamander admits, stripping your armor off with a speed so quick that you can't help but think she's had plenty of experience.  ", false);
		if (player.gender == 3) outputText("\"<i>Though not exactly a woman, are we?</i>\" she laughs, giving your " + player.cockDescript(x) + " a quick stroke.  ", false);
		outputText("She takes a step forward and kneels down atop your shoulders, pinning your arms to the ground and pushing her cunt toward your face.  \"<i>And I love taking charge even more! Now lick, and I might let you get off, too.</i>\"\n\n", false);

		outputText("Obediently, you lift your face between her legs and give the lips of her drooling cunt an experimental lick.  You recoil suddenly, feeling like your tongue is on fire.  Seemingly as reassurance, the salamander makes an uncharacteristically gentle gesture and runs her scaled fingers through your " + player.hairDescript() + ", her sharp claws only just brushing your scalp.  \"<i>C'mon, c'mon,</i>\" she insists, pushing your face back up toward her.  You steel yourself for another burn, but when you give her another lick, you find her lips cooler the second time.  Without further ado, you begin your ministrations, probing into her welcoming cunt with measured skill.  She gasps with pleasure and again strokes your head encouragingly, even as her other hand drops to your " + player.chestDesc() + " and begins to play with your nipples.\n\n", false);

		outputText("After a few minutes of this, your fiery lover has begun to buck her hips in time with your licks, kisses, and gentle bites.  Her breath is coming more raggedly now, and her hands have both gone to your tits, savaging your nipples in reward for your service.  You can feel her orgasm building, and redouble your efforts, bringing her closer and closer to climax...\n\n", false);

		outputText("\"<i>Oh, hell no!</i>\" she snaps, grasping you by the forehead and pushing your head to the grassland ground.  \"<i>You're not getting off that easily... and I promised I'd get you off too, lover.</i>\"  Her prehensile tail swishes into view over her shoulder, the flames that once coated it mysteriously gone.  She grins at you, and in one swift motion engulfs the tip of her tail in her mouth.  When she releases it, the tip is glistening with moisture.  Then it's gone from view.\n\n", false);

		outputText("You feel a sudden tickle against the lips of your " + player.vaginaDescript(0) + ".  You gasp at the spark of pleasure as her tail slips across your pleasure bud, then begins wriggling past the lips of your cunt.  Your lover smiles down at you and cups her own breasts, freeing you to resume your ministrations.  Every few licks, you're forced to stop and gasp or shudder as her tail works its way into your " + player.vaginaDescript(0) + ", fucking you like a cock and a skilled finger at once, not pistoning in and out, but writhing within your depths like a tentacle.");
		player.cuntChange(20,true,true,false);
		outputText("\n\n", false);

		outputText("All good things must come to an end, however, and soon the salamander's hot cunt contracts around your tongue as she cums, squirting girl-juice all over your face and neck.  You give her a last good tongue-fucking, picking up the pace and bringing her to a screaming, shuddering climax.  The power of her orgasm has a welcome side effect, as her tail begins to thrash wildly within you, battering your cunt and bringing you, too, to a massive, mind-numbing climax", false);
		if (player.hasCock()) outputText(", your cock shooting a massive rope of spunk onto her face as your vag cums from the tailfucking", false);
		outputText(".\n\n", false);

		outputText("Before your mind has settled, your new friend has collapsed on top of you, resting her cheek on your " + player.chestDesc() + ".  Her breath is ragged, not unlike yours, and her eyelids seem suddenly heavy.  Smiling, she slowly withdraws her cum-soaked tail from your " + player.vaginaDescript(0) + " and slips it under your head like a pillow, soft and warm, if not a little moist.  Seeing as she doesn't seem intent on going anywhere, you, too, close your eyes and drift off to a peaceful sleep.", false);
	}
	//Player Loss – Rape – Genderless & Male >85 cockarea
	else {
		//(Genderless) 
		if (player.gender == 0) outputText("\"<i>Hmm, what do we have here,</i>\" the salamander asks, yanking your " + player.armorName + " off to reveal your genderless crotch.  \"<i>Well, that's... Different.  Well, your loss, I suppose...</i>\" she trails off, stepping up and pushing her cunt into your face.  \"<i>Now lick, and maybe I'll think up a way to get you off, too</i>\".\n\n", false);
		//(Cock(s) too big to fit) 
		else if (player.hasCock()) outputText("\"<i>Hot damn.  That's impressive, but even I'm not tough enough to handle that.  But maybe I can still get you off by... other means,</i>\" she says with a wink.\n\n", false);
		
		else outputText("\"<i>Hot damn.  That's impressive, but even I'm not tough enough to handle that.  But maybe I can still get you off by... other means,</i>\" she says with a wink.\n\n", false);

		outputText("Obediently, you lift your face between her legs and give the lips of her drooling cunt an experimental lick.  You recoil suddenly, feeling like your tongue is on fire.  Seemingly as reassurance, the salamander makes an uncharacteristically gentle gesture and runs her scaled fingers through your " + player.hairDescript() + ", her sharp claws only just brushing your scalp.  \"<i>C'mon, c'mon,</i>\" she insists, pushing your face back up toward her.  You steel yourself for another burn, but when you give her another lick, you find her lips to be cooler the second time.  Without further ado, you begin your oral ministrations, probing into her welcoming cunt with measured skill.  She gasps with pleasure and again strokes your head encouragingly, even as her other cups her tits and begins to play with her nipples.\n\n", false);

		outputText("After a few minutes of this, your fiery lover has begun to buck her hips in time with your licks, kisses, and gentle bites.  Her breath is coming more raggedly now, and her hands have both gone to your tits, savaging your nipples in reward for your service.  You can feel her orgasm building, and redouble your efforts, bringing her closer and closer to climax...\n\n", false);

		outputText("\"<i>Oh, hell no!</i>\" she snaps, grasping you by the forehead and pushing your head to the grassland ground.  \"<i>You're not getting off that easily... and I promised I'd get you off too, lover.</i>\"  Her prehensile tail swishes into view over her shoulder, the flames that once coated it mysteriously gone.  She grins at you, and in one swift motion engulfs the tip of her tail in her mouth.  When she releases it, the tip is glistening with moisture.  Then it's gone from view.\n\n", false);

		outputText("You gasp as you feel a sudden pressure against the rim of your " + player.assholeDescript() + ".  Your eyes widen, but your fiery lover only smiles and increases the pressure against your asshole until you force yourself to relax, admitting the tip of her tail into your ass.  Every few licks, you're forced to stop and gasp or shudder as her tail works its way into your " + player.assholeDescript() + ", fucking you like a cock and a skilled finger at once, not pistoning in and out, but writhing within your depths like a tentacle.");
		player.buttChange(20,true,true,false);
		outputText("\n\n", false);

		outputText("All good things must come to an end, however, and soon the salamander's hot cunt contracts around your tongue as she cums, squirting girl-juice all over your face and neck.  You give her a last good tongue-fucking, picking up the pace and bringing her to a screaming, shuddering climax.  The power of her orgasm has a welcome side effect, as her tail begins to thrash wildly within you, battering your ass and bringing you, too, to a massive, mind-numbing climax.\n\n", false);

		outputText("Before your mind has settled, your new friend has collapsed on top of you, resting her cheek on your " + player.chestDesc() + ".  Her breath is ragged, not unlike yours, and her eyelids seem suddenly heavy.  Smiling, she slowly withdraws her tail from your " + player.assholeDescript() + " and slips it under your head like a pillow, soft and warm, if not a little moist.  Seeing as she doesn't seem intent on going anywhere, you, too, close your eyes and drift off to a peaceful sleep.", false);
	}
	player.orgasm();
	dynStats("sen", 1);
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	combat.cleanupAfterCombat();
}


public function beatUpHel():void {
	spriteSelect(68);
	clearOutput();
	//Various intros
	if (monster.HP < 1) outputText("Unable to withstand your onslaught, the salamander collapses to a knee, barely supporting her weight on her sword.", false);
	else outputText("Panting heavily, knees shaking, she collapses onto the ground, heavily leaning upon her sword.", false);	
	outputText("\n\n", false);
	if (player.cor < 85) helDefeatedNormal();
	else helDefeatedCorrupt();
}
private function helDefeatedCorrupt():void {
	spriteSelect(68);
	//[(corruption = high)
	outputText("By the way she's huffing and puffing, you figure you've got a minute or so to take advantage of her while she's vulnerable...  Do you?", false);
	//(Display Options: [Rape her Ass(for wangs)] [Get Rimjob] and [Wait])
	
	menu();
	
	if (player.lust < 33)
	{
		if (player.lust < 33) outputText("\n\nYou aren't turned on enough to fuck her right now.", false);
	}
	else
	{
		if (player.hasCock() && player.cockThatFits(85) >= 0 && player.lust >= 33)
		{
			addButton(0, "Rape Ass", rapingHelsAssMeansYourCorruptCauseAnalIsEvil);
		}
		else if (!player.hasCock() || player.cockThatFits(85) == -1)
		{
			outputText("\n\nYour dick is too big to fuck her anally.", false);
		}
		
		addButton(1, "Get Rimjob", receiveCorruptRimjobsFromHel);
	}
	
	addButton(4, "Wait", createCallBackFunction(helDefeatedNormal, true));
	//(Wait takes you to \"<i>normal</i>\" post-victory, below)
}
//COMBAT – PLAYER WINS w/ LESS THAN 85 CORRUPTION
private function helDefeatedNormal(clear:Boolean = false):void {
	spriteSelect(68);
	if (clear) clearOutput();
	if (flags[kFLAGS.HEL_TIMES_ENCOUNTERED] == 1) {
		outputText("Suddenly, she looks up at you with her fiery eyes and beams, smiling ear to ear.  \"<i>That was fucking AWESOME!</i>\" she shouts, bursting into sudden, hearty laughter.  A moment ago, you were worried for your life, but the sight of the enraged berzerker breaking into laughter can't help but make you grin yourself.\n\n", false);

		outputText("\"<i>Oh, man,</i>\" she says, shaking her head so hard that her long hair whips about her.  \"<i>You have some killer moves, friend.  I know 'taurs that'd go a month without sticking their cocks in anything to kick ass like you do.  Hey, look, sorry I jumped you.  When I get my blood up, I can't help but just swing at anything that moves, you know?</i>\"\n\n", false);

		outputText("She suddenly grins, tossing her sword aside.  \"<i>Speaking of getting some blood up... Hey, to the victor go the spoils, and all that.  What do you say we blow off some steam, huh?  Nothing better after a good fight than a good fuck, you know?</i>\"", false);
	}
	else {
		outputText("Suddenly, she looks up at you with her fiery eyes and beams, smiling ear to ear.  \"<i>Damn, you're good,</i>\" she says, suddenly laughing.  \"<i>I almost had you, though.  Next time, watch your ass or I'm liable to stick this bad boy inside it!</i>\"  She gestures crudely with her tail at this last remark.\n\n", false);
		outputText("\"<i>But, to the victor go the spoils, after all.  What do you say we blow off some steam, huh?  Nothing better after a good fight than a good fuck, you know?</i>\"", false);
	}
	/*if (player.lust < 40) {
		player.lust = 40;
		dynStats("lus", 0.1);
	}*/
	helFuckMenu();
}

private function helFuckMenu(isAmbush:Boolean = false):void {
	spriteSelect(68);
	//Leave appropriate way
	var leave:Function = declineHelSexings;
	if (isAmbush) leave = pussyOutOfHelSexAmbush;
	
	if (player.lust < 33) {
		outputText("\n\n<b>You aren't really up for sex right now.</b>", false);
		simpleChoices("", null, "", null, "", null, "", null, "Leave", leave);
		return;
	}
	var getLicked:Function = null;
	if (player.hasVagina()) {
		getLicked = getLickedByHel;
	}
	var fuckVag:Function = null;
	var fuckAss:Function = null;
	var tailWank:Function = null;
	var dp:Function = null;
	var getBlown:Function = null;
	if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0) {
		outputText("\n\n<b>Helia DLC is required!</b>");
		menu();
		addButton(0, "Get DLC", getGame().aprilFools.DLCPrompt, "Helia DLC", "Get Helia DLC to be able to have sex with Helia! The DLC also comes with an epic amount of content, including Tower of the Phoenix and Goo Armor!", "$4.99", "Find out about Helia DLC!");
		addButton(4, "Leave", declineHelSexings);
		return;
	}
	if (player.hasCock()) {
		if (player.cockThatFits(85) >= 0) {
			fuckVag = beatUpHelAndStealHerWalletFromHerVagina;
			fuckAss = fuckHelsAss;
		}
		else outputText("\n\n<b>You're too big to penetrate the salamander.</b>", false);
		tailWank = helTailWanksYourDickBecauseSheLovesYouDesuDesuHoraHora;
		if (player.cockTotal() > 1 && player.cockThatFits(85) >= 0 && player.cockThatFits2(85) >= 0)
			dp = dpHel;
		getBlown = helBlowsYou;
	}
	var tailFuck:Function = helTailPegging;
	//ALTERNATE BODY BUTTONS
	var bodyText:String = "";
	var bodyButt:Function = null;
	var bodyText2:String = "";
	var bodyButt2:Function = null;
	//Player's Options (Male): [Fuck her Vag] [Fuck her Ass] [Get Blown] [Tail Wank] [DP] [No Thanks]
	//Player's Options (Female): [Get Licked] [Tail Fuck] [No Thanks]
	//Player's Options (Herm): [Fuck her Vag] [Fuck her Ass] [Get Blown] [Get Licked] [Tail Fuck] [DP] [Tail Wank] [No Thanks]
	//Player's Options (Genderless): [Tail Fuck] [No Thanks] (No racial options)
//	Note:: Vaginal/Anal capacity is max 85 cockarea for Male/Herm characters. If their primary cock is too big, go to the second, etc. If all are too large, the male/herm cannot use \"<i>Fuck her Vag/Ass</i>\" options. He may still \"<i>Get Blown,</i>\" or get a \"<i>Tail Fuck.</i>\"	
	
	//Racial Specific Options: [Naga: Coil her Up (69)] [M. Centaur: Mount Her] [F. Centaur: Hanging 69]
	//[Possession]
	if (player.isNaga()) {
		if (player.hasCock() && player.cockThatFits(85) >= 0) {
			bodyButt = nagaCoilsUpHel;
			bodyText = "CoilFuck";
		}
		else {
			bodyText2 = "TailsInButts";
			bodyButt2 = nagaCoilsUpAnalNaga;
		}
	}
	else if (player.isTaur()) {
		if (player.hasCock() && player.cockThatFits(85) >= 0) {
			bodyText = "Mount Her";
			bodyButt = mountHel;
		}
		if (player.hasVagina()) {
			bodyText2 = "Hanging69";
			bodyButt2 = helVaginaTaur69;
		}
	}
	//Possess crams in free spot or overlaps another.
	if (player.findPerk(PerkLib.Incorporeality) >= 0) {
		//Taurs or nagas with both scenes, replace 1!
		if (bodyButt != null && bodyButt2 != null) {
			if (rand(2) == 0) {
				bodyText = "Possess";
				bodyButt = helPossessionShitPoopCock;
			}
			else {
				bodyText2 = "Possess";
				bodyButt2 = helPossessionShitPoopCock;
			}
		}
		//Second button slot is free
		else if (bodyButt2 == null) {
			bodyText2 = "Possess";
			bodyButt2 = helPossessionShitPoopCock;
		}
		//First button slot is free
		else {
			bodyText = "Possess";
			bodyButt = helPossessionShitPoopCock;
		}
	}
	choices("Get Licked",getLicked,"FuckHerVag",fuckVag,"FuckHerAss",fuckAss,"GetTailPegged",tailFuck,"Tail Wank",tailWank,"DoublePen",dp,"Get Blown",getBlown,bodyText,bodyButt,bodyText2,bodyButt2,"Leave",leave);
}

//[b]Player Win – Victory Un-Fuck – No Thanks (Any Gender)
private function declineHelSexings():void {
	spriteSelect(68);
	clearOutput();
	outputText("You thank her for the offer, but politely decline.\n\n", false);

	if (getGame().inCombat) outputText("\"<i>Aw, hell.  You're no fun,</i>\" she pouts, picking up her sword and sheathing it.  \"<i>Well, at least take this,</i>\" she adds, tossing a few gems your way.  You thank her for the gems as she starts walking over the hill towards wherever it is she's going.  ", false);
	outputText("\"<i>Catch you next time, friend – and maybe we can have some fun, then!</i>\" she calls over her shoulder with a wave.\n\n", false);

	outputText("You nod, and return the wave before heading back to your camp.", false);
	helFollower.helAffection(1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//Player Win – Victory Fuck – Fuck her Vag
internal function beatUpHelAndStealHerWalletFromHerVagina():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-vagfuck"));
	var x:Number = player.cockThatFits(helFollower.heliaCapacity());
	outputText("You tell her that, sure, you could blow off some steam.  Still grinning, she tosses off her skimpy scale bikini and flops down on her back, already starting to finger her cunt.  You follow suit, stripping off your " + player.armorName + " and straddling her hips.  She reaches forward and grasps your " + player.cockDescript(x) + " in her scaly, clawed hands, causing you to miss a heartbeat before, smiling, she starts to pump it.  Her other hand continues to finger her cunt, preparing it for your " + player.cockDescript(x) + "'s penetration.  Content to let her lead for the moment, you grasp her wide hips just above where the crimson scales turn to soft flesh, tensing up as she begins to guide you into her slit.\n\n", false);

	outputText("The tip of your cock brushes against the lips of her cunt – it's burning hot, making you recoil a bit in her grasp.  But the salamander doesn't let up, instead guiding your cock head into her burning cunt, and then grasping your " + player.assDescript() + " and pushing you the rest of the way in with one mighty pull!  You gasp as the explosive heat of her innermost depths overwhelms you, numbing your mind to any sensation but her burning cunt and the muscles contracting over your cock, already starting to milk you.\n\n", false);

	outputText("You grip her hips and begin thrusting into her, your tempo guided and measured by her firm grasp on your " + player.assDescript() + ".  As you first pull out, you're hit by an overwhelming coolness – what once seemed like hot, dry air is mercifully cool on your cock as you withdraw.  You're only at the tip, however, when her arms tighten around your ass and start pushing back.  Grinning, you slam into her, eliciting a sudden moan of pleasure from your fiery lover.  You pick up the tempo, thrusting into her hot depths and out again into the cool air, fucking her hard and fast.  She moans and squirms under your assault, eventually releasing your ass to grab her big, soft tits and squeeze her nipples.\n\n", false);

	outputText("You keep it up for a few minutes, fucking her burning cunt while she plays with her tits and moans for you, but you can feel her orgasm starting to come – and you aren't done yet.  She climaxes, her cunt squeezing down on your " + player.cockDescript(x) + " as she cries her pleasure to the high heavens louder than any war cry, mashing her tits together and arching her back like a slut.  The sight of her massive tits pushed tightly together is too good an opportunity to pass up, and you pull out of her and lunge forward, forcefully thrusting your " + player.cockDescript(x) + " between her pillowy breasts even as she cums.\n\n", false);

	outputText("She gasps with the sudden change, but grins wolfishly at you.  Without missing a beat, she takes her tits in hand and starts to work them along the length of your shaft, pumping your " + player.cockDescript(0) + " for all it's worth as her prehensile tail slips into her now vacant cunt, pleasuring her as she titfucks you.  You grab hold of her shoulders and, taken by wild urge, lean down and kiss the salamander.  She returns it, thrusting her tongue into your mouth and redoubling her titfuck.\n\n", false);

	outputText("Finally you cum!  You grit your teeth and pull out of the kiss as you make one last, mighty thrust into her titflesh.  Never stopping, your lover takes your cock into her mouth and starts milking it with her tongue, lips, and hands", false);
	if (player.hasVagina()) outputText(" while releasing her breasts to finger your " + player.vaginaDescript(0), false);
	outputText(".  You run your hands through her hair as you shoot strings of jism again and again into her mouth until her cheeks start to bulge.  When you're through, she makes a loud gulp and licks her lips, grinning at you wide enough that a tiny amount of your cum leaks from her cheeks.\n\n", false);

	outputText("Exhausted, you can't help but collapse into her cleavage, your cheek coming to rest between her soft breasts.  You smile at her, and cup one of them even as she begins to stroke your cheek, smiling.  Your eyes feel heavy, and exhaustion begins to overtake you.  Slowly, you drift off into a peaceful sleep in the embrace of your lover.", false);
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}


//Player Win – Victory Fuck – Fuck her Ass
internal function fuckHelsAss():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-buttfuck"));
	var x:Number = player.cockThatFits(helFollower.heliaAnalCapacity());
	outputText("You tell her that, yes, you want to blow off some steam, and motion for her to get on hands and knees.\n\n", false);

	outputText("\"<i>Oh, I think I know what we both want,</i>\" she says, grinning wolfishly as she strips out of her skimpy bikini and gets down on her hands and knees, turning so that her muscular ass is facing you.  Seductively, she lifts her tail in the air and waggles it in a 'come hither' motion before getting it out of your way, revealing your prize beneath it – her tight little pucker.\n\n", false);

	outputText("You drop to your knees behind the salamander and start to stroke your cock, getting it to full hardness.  In the moment of anticipation, she reaches a hand back and easily slips a finger into her backdoor, sliding it in up to the second knuckle.  \"<i>Don't be shy, lover,</i>\" she says, withdrawing her finger.  \"<i>That's no virgin hole you're looking at, so come on...  Fuck my ass!</i>\"\n\n", false);

	outputText("That's all the encouragement you need.  You line up and thrust in, slowly but surely.  By gods, she's tight as a silken vice, her sphincter gripping down hard upon your cock and making you fight for every inch.  She moans and grunts as your " + player.cockDescript(x) + " forces its way in, biting her lower lip for the final inches until you've bottomed out, your entire length buried inside her asshole.\n\n", false);

	outputText("Just as you're about to pull out, you feel a sudden hot pressure on your shoulders and neck – you look down to find her tail, its flames now dormant, wrapping tightly around you.  \"<i>Oh, yes, yes, yes.  Leave it in there, just a moment.  Let me savor this,</i>\" she moans, smiling to herself as one of her hands begins to grope her tits.  You oblige her, nuzzling against her warm, strong tail for a moment before pulling out until your cock's head is all that's left buried inside her.\n\n", false);

	outputText("You grunt with pleasure as you thrust all the way back inside her ass in one motion.  She screams, not in pain but in pleasure, her tongue lolling from her mouth as her tail constricts tightly around you.  You pull out, and thrust, then again.  You keep this up for a long minute, pounding away at her asshole as she gropes herself and moans lewdly.\n\n", false);

	outputText("\"<i>Oh, yeah, fuck my ass.  Just like that!</i>\"  She clamps down on your cock as her orgasm comes, and you shove yourself all the way in as her girl-cum splatters onto your [legs], spurting from her cunt while her tail threatens to choke you, tightening and heating until you're almost unable to breathe.\n\n", false);

	outputText("That just makes your own orgasm all the better.  You give her a few last seconds of pounding before you roar and explode within her, pumping your cum deep inside her colon, filling her with your seed.\n\n", false);

	outputText("\"<i>Oh.  Oh wow,</i>\" the salamander finally says, grinning from ear to ear as you pull out of her ass.  \"<i>Oh, I love a good ass fucking, and you are...  Damn, but you're good.  Come here, lover.</i>\"  She flops onto her back with arms wide.  You fall into her embrace and kiss her, probing her mouth with your tongue.  Eventually, you pull back and nestle your cheek on her soft breasts, your exhaustion suddenly catching up with you.\n\n", false);

	outputText("She strokes your cheek as you drift off into a nice, peaceful sleep.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Victory Fuck – Get Blown (Male) (edited)
internal function helBlowsYou():void {
	spriteSelect(68);
	var x:Number = player.biggestCockIndex();
	clearOutput();
	outputText(images.showImage("helia-getblown"));
	outputText("You agree to her proposition, and tell her to get on her knees as you draw out your " + player.cockDescript(x) + " and slip out of your " + player.armorName + ".  She grins and drops to her knees, quickly discarding her scaled bikini as you stroke yourself to hardness.  You close the distance between you and the salamander is quick to take your cock into her mouth, lustily sucking it in as she starts to fondle her breasts enticingly.\n\n", false);

	outputText("Her mouth is unnaturally hot, threatening to burn your sensitive " + player.cockDescript(x) + " even as her long, forked tongue eagerly works your shaft over.  After a few blissful seconds, though, she leans back and grabs your ass, forcing you onto your knees as she flops onto her back, pushing your cock between her tits and into her mouth.\n\n", false);

	outputText("She takes her tits in hand and starts to work them along the length of your shaft, pumping your " + player.cockDescript(x) + " for all it's worth as her prehensile tail begins to slip into her vacant cunt, pleasuring herself as she titfucks you.  You take hold of her shoulders and, taken by wild urge, lean down and kiss the salamander.  She returns it, thrusting her tongue into your mouth and redoubling her titfuck.  You continue this for a few minutes, letting her roughly press you between her soft, pillowy breasts as she fucks herself with her tail.  Eventually, though, you feel the mounting pressure of a coming orgasm in your groin, and you thrust yourself into her mouth", false);
	if (player.cocks[x].cockLength >= 6) outputText(", making her deepthroat you", false);
	outputText(" as you cum and fill her mouth with ", false);
	if (player.cumQ() <= 30) outputText("squirts", false);
	else if (player.cumQ() <= 100) outputText("ropes", false);
	else outputText("sprays", false);
	outputText(" of jism.  When you pull out of her, she swallows down all you've given her and sighs, contented.\n\n", false);

	outputText("Exhausted, you collapse onto her soft tits.  Smiling at you, she strokes your cheeks as you drift off into a peaceful sleep.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – DP(Multicock Only) (edited)
internal function dpHel():void {
	spriteSelect(68);
	var x:Number = player.cockThatFits(helFollower.heliaCapacity());
	var y:Number = player.cockThatFits2(helFollower.heliaCapacity());
	clearOutput();
	outputText(images.showImage("helia-doublepenetration"));
	outputText("You tell her that, yes, you want to blow off some steam.  You start to undo your " + player.armorName + ", and quickly her eyes go wide.  \"<i>You've got something extra, don't ya!</i>\" she laughs, looking mighty impressed.  \"<i>Well, I think we can take care of that " + player.cockDescript(y) + ", too. Just sit back and relax, lover!</i>\"\n\n", false);

	outputText("You nod, and sit down on the high grass as your salamander lover strips down and straddles you.  She grabs your " + player.cockDescript(x) + " in her left hand and your " + player.cockDescript(y) + " in her right, and quickly begins to pump them, bringing them to full hardness and even summoning forth a few dollops of pre-cum.  After perhaps a minute of this treatment, you're as hard as you're likely to get, and seeing this, the salamander grins wolfishly.\n\n", false);

	outputText("\"<i>Oh, I think I know what we both want,</i>\" she says, rising up on her knees and positioning your " + player.cockDescript(x) + "'s head at the lips of her cunt, and slipping your " + player.cockDescript(y) + " between her muscular ass cheeks.  You gasp at the feeling of intense heat radiating from her holes, making the wait nearly unbearable.  \"<i>Don't worry, lover,</i>\" she laughs, slowly impaling herself on your twin shafts, \"<i>I won't burn you... yet!</i>\"  Suddenly, she slams down, burying them both up to the hilt.  She screams in ecstasy at the sudden fullness inside her.  Her head rolls back and her tongue lolls out; she's momentarily stunned by her own maneuver, but slowly recovers, and after a few seconds is able to start to rise on your shafts.\n\n", false);

	outputText("\"<i>Gotta admit,</i>\" she says, drawing in a sharp breath as your cocks withdraw to their heads inside her, \"<i>");
	if (flags[kFLAGS.TIMES_HELIA_DOUBLE_DONGED] == 0) outputText("You're my first multi-cock.  Damn, never thought it'd be like THIS!");
	else outputText("You're amazing!  I don't think I'll ever get used to sex like THIS!");
	outputText("</i>\" she says, and slams herself down again.  You both gasp and moan in pleasure, and soon she's practically bounding on your manhoods, milking both your cocks raw in her sweltering hot depths.  You keep this up for a long minute, letting her bounce away on your cocks as she begins to moan lewdly.\n\n", false);

	outputText("\"<i>Oh yeah, fuck my holes.  Just like that!</i>\"  She screams, clamping down on your cocks as her orgasm comes, and wraps her arms around your neck to shove your face into her pillowy cleavage, threatening to suffocate you.\n\n", false);

	outputText("That just makes your own orgasm all the better.  You buck your hips into her a few last times before you roar and explode within her, pumping your cum deep inside her vag and ass, filling her with your seed until your cocks have deflated inside and jism is spilling out around your shafts.  Slowly, she releases your head from her bosom, though you're loathe to leave their lusty depths.  Instead, you push her onto her back and nuzzle against her chest, suddenly exhausted.\n\n", false);

	outputText("\"<i>Hot damn,</i>\" the salamander finally says, grinning from ear to ear as she begins to stroke your cheeks.  \"<i>Oh, damn, two cocks are the fucking BEST.</i>\"  She laughs to herself as you nestle your cheek on her soft breasts, slowly drifting off to a pleasant, peaceful sleep.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	flags[kFLAGS.TIMES_HELIA_DOUBLE_DONGED]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Get Licked (Vagita) (edited)
internal function getLickedByHel():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-getlicked"));
	outputText("You agree to her proposition, and instruct her to get on her knees as you slip out of your " + player.armorName + ", revealing your " + player.vaginaDescript(0) + ".  She grins and kneels before you, quickly discarding her scaled bikini as you grasp her shoulders, pressing your womanhood to her lips.  Her long, forked tongue darts forward, teasing your lips.\n\n", false);

	outputText("The salamander grips your " + player.buttDescript() + " with her smooth, scaly hands as she slips her wonderfully long tongue into your " + player.vaginaDescript(0) + ", flicking and tickling every inch of your sensitive cunt as she forces in inch after inch, until all eight are pushed inside you, driving you wild with lust as she lustily tonguefucks you.  Gripped by building pleasure, you push her onto her back and smash your cunt against her mouth, bucking your hips as she continues her skilled assault, making you shudder and writhe with pleasure.\n\n", false);

	outputText("Even as she licks your " + player.vaginaDescript(0) + ", you feel a sudden pressure on your own back door. Looking over your shoulder, you see the very tip of her tail pressing against your " + player.assholeDescript() + ", seeking to double your pleasure.  You try and relax your sphincter, letting just a few inches into your ass, and even that is enough to make you gasp as her dexterous tip works in conjunction with her long tongue.\n\n", false);
	
	outputText("You can only endure a minute or so of this treatment before you come, screaming your pleasure as you thrust into her face, soaking her with girl cum", false);
	if (player.hasCock()) {
		outputText(" while " + player.sMultiCockDesc() + " shoots its load into her red hair", false);
		if (player.cumQ() >= 500) outputText(", bathing her in streams of jism", false);
	}
	outputText(".  You shudder and gasp as her forked tongue slowly withdraws from your depths, as does her tail, and you can't help but collapse onto her inviting tits as exhaustion overwhelms you.\n\n", false);

	outputText("She gives a little laugh and strokes your cheek as you drift off into a contented, peaceful sleep.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Tail Wank (dix of any size) (edited)
internal function helTailWanksYourDickBecauseSheLovesYouDesuDesuHoraHora():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-tailwank"));
	var x:Number = player.biggestCockIndex();
	outputText("You think for a moment, then saunter up to the hot salamander.  She gasps initially, then grins wolfishly as you tell her to put the large, prehensile tail to good use.  You shift your grip to her shoulders and push her down to her knees; she's quick to start pulling you out of your " + player.armorName + ".  After a moment of fiddling, your " + player.cockDescript(x) + " pops free, already hardening; she wraps her clawed, scaly hands around it and gives a few experimental pumps, but you're quick to remind her that you have a different position in mind.\n\n", false);
	
	outputText("The salamander reclines back, letting her tail slip between her legs and snake its way toward you.  The surface of her tail, once glowing bright-hot, is now little more than red scales; you have momentary second thoughts, but the first touch of its tip against your leg is enough to calm you – she's hot, but not enough to burn you.  Your " + player.cockDescript(x) + " begins to throb with anticipation as the dawdling tailtip makes a slow, sensual trek from the ground to your crotch, lingering and playing along the sensitive skin of your inner thighs and " + player.assDescript() + " before eventually slithering onto your " + player.cockDescript(x) + ".\n\n", false);

	outputText("You shudder and gasp as her tail coils around your " + player.cockDescript(x) + " once, twice, until it has enveloped your length in smoldering scale-flesh.  Desperate for something to cling to, to grasp and fuck, you grab the thick base of her tail, wrapped around your cock, and try to urge her to her duty.  With a coy smile, though, she denies you.\n\n", false);

	outputText("\"<i>C'mon now, friend,</i>\" she says, gently squeezing your cock.  \"<i>Since this is so one-sided, I'll just have to take MY pleasure from tantalizing you.</i>\"\n\n", false);

	outputText("You're ready to curse her out when she gives your cock another squeeze, causing your words to melt into a yelp of pleasure and pain.  She laughs, and starts to wring you in her tail, moving the tip slowly further up your body as her coils constrict your cock, squeezing and milking it until you feel like you're ready to pop.  Slowly, her tail slinks around your neck, wrapping your throat in warmth as she begins to redouble the squeezing and wringing of your poor, abused member, always stopping just as you're about to cum.  Again and again, for what seems like an eternity, she keeps you there, hanging on the edge of bliss and agony, forcing more and more of your seed to be pent up in your aching cock.\n\n", false);

	outputText("Finally, you can take no more.  You scream and buck your hips as the salamander wrings your cock nearly off your body, sending jets of jism onto her bare belly and chest.  As the first ropes of semen leave your " + player.cockDescript(x) + ", though, her tail releases your dick, then seizes tight around your throat, choking you.  Your entire body convulses and heaves against her, thrashing madly as a massive, pent-up orgasm wracks your airless body.\n\n", false);

	outputText("When she releases you, you cannot help but collapse onto her lap.  Only vaguely are you aware as she withdraws her tail from around you.  With a clawed finger, she scrapes a pool of cum from her pillowy breast and slips it into her mouth.  \"<i>Mmm, salty and delicious; just how I like it, lover,</i>\" she laughs, scooping up more of your seed into her hungry mouth.  You, however, drift off to sleep, content and at peace.\n\n", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Tail Pegging (Anal) (edited)
internal function helTailPegging(loss:Boolean = false):void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-tailpeg"));
	if (!loss) outputText("You agree to her proposition and, after a moment of thought, strip out of your " + player.armorName + " and ask her if she could fuck you with that long, prehensile tail.  \"<i>Oh, now that's an idea I can get behind!</i>\"  She laughs at her own wit.  \"<i>Well, go on then.  Get on your hands and knees, and spread those ass cheeks.</i>\"\n\n", false);
	else outputText("\"<i>Get on your hands and knees, and spread those ass cheeks,</i>\" she says.\n\n")
	outputText("You do as she asks, getting on all fours and giving her a good views of your vulnerable " + player.buttDescript() + ".  Looking over your shoulder, you can see her smile wolfishly as she brings her tail to bear, now doused of its previous flames, and gives its tip a little suckle, moistening it up as she straddles your hips to fuck you doggy style.  Her tail slips down from her mouth and winds between her legs like a cock as she lines herself up with your " + player.assholeDescript() + ".\n\n", false);

	outputText("You grit your teeth and clench your fists in preparation for the coming fucking.  Soon, you feel the tip of her tail pressing against your backdoor, looking for entrance.  You do your best to relax yourself, but she only needs a second to force herself inside you, eliciting a gasp of pain and pleasure from you as inches of her tail sink in, widening and stretching your hole.", false);
	player.buttChange(40,true,true,false);
	outputText("\n\n", false);
	
	outputText("Firmly within your depths, she plants her smooth, scaled hands on your " + player.buttDescript() + " and starts to hammer your ass, quickly thrusting her tail in and out.  You gasp and moan like a whore, barely able to support your own weight as she fucks your ass hard and fast, threatening to tear your tender insides up with her rough fucking.\n\n", false);

	outputText("Eventually, you can take no more, and feel your climax coming on.  The salamander, sensing this from the fashion you're wringing her tail, gives your " + player.buttDescript() + " a hard slap and slams in as far as it can go.  You rocket over the edge, screaming and shuddering so hard that you collapse onto the dirt", false);
	if (player.gender > 0) {
		outputText(", with your ", false);
		if (player.hasCock()) {
			outputText("cock", false);
			if (player.hasVagina()) outputText(" and ", false);
		}
		if (player.hasVagina()) outputText("vagina", false);
		outputText(" contracting and squirting all over your lover", false);
	}
	outputText(", writhing in pleasure as her tail slowly withdraws from your " + player.assholeDescript() + ".\n\n", false);

	outputText("Seeing you collapsed in a writhing mess of your own pleasure must evoke some tenderness in the berserker.  A moment later she lifts you up off the ground and nestles your head between her pillowy breasts, stroking your cheek and smiling lovingly at you. Contented, you drift off into a deep, peaceful sleep.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Coil her Up (Wang Naga) (edited)
private function nagaCoilsUpHel():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-nagacoil"));
	var x:Number = player.cockThatFits(85);
	var y:Number = player.cockThatFits2(85);
	outputText("You slither closer to the salamander and tell her that, yeah, you could stand to work off some steam.  She grins at that and closes the distance between you, reaching out to caress your serpentine half.  \"<i>Mmm.  Sexy tail, lover,</i>\" she says, reaching around and giving your " + player.buttDescript() + " a squeeze in her smooth, scaled hands.  \"<i>It'd be a real shame for such beautiful coils to go unused, you know...</i>\" she adds, giving you a little wink.\n\n", false);

	outputText("You get the idea in a hurry, and discard your " + player.armorName + " as she disrobes, giving you a good view of her smooth snatch and her big, soft breasts.  The sight of her nude form causes your " + player.cockDescript(x) + " to quickly slip out of its hidey-hole in your reptilian half; she grabs it and starts to stroke it, bringing it to full hardness as you coil your tail around her feet.  She gasps from the sudden tightness around her belly as you make a full loop around her, binding her arms to her side and pulling her up off the ground with your strong tail.\n\n", false);

	outputText("With your lover now completely at your mercy, you lean back and draw her close, lining her crotch up with your " + player.cockDescript(x), false);
	if (y >= 0) outputText(" and her ass up with your " + player.cockDescript(y), false);
	outputText(".  As you start to lower her onto your shaft", false);
	if (y >= 0) outputText("s", false);
	outputText(", she gasps and squirms, writhing in her inability to control the penetration.  \"<i>Deeper, deeper,</i>\" she begs, kissing your shoulders and neck imploringly.  \"<i>I need you deeper, dammit!  DEEPER!</i>\"\n\n", false);

	outputText("You force her down obligingly, slamming her hips against you and ramming your manhood in her to the hilt; she shrieks in pleasure, shuddering as you bottom out inside her until there is no more cock to stuff her with.  She finally squirms enough to free her arms, and wraps them around your shoulders, drawing you into a deep kiss, driving her long, forked tongue into your mouth.\n\n", false);

	outputText("You reward her by pulling her half way off your cock", false);
	if (y >= 0) outputText("s", false);
	outputText(", and slamming her back down again.  Using your tail, you start to bounce her on your crotch, roughly using her like a helpless sex toy.  She yelps and moans and groans as you pound her, slowing only to grab her breasts and grope them at the apex of a bounce.  The sheer pleasure of the rough pounding you're giving her, combined with your skilled assault on her perky little nipples, soon drives her over the edge.  She arches her back and screams, begging you to fuck her harder and harder as she cums.  You oblige as best you can, slamming her down on your cock", false);
	if (y >= 0) outputText("s", false);
	outputText(" harder than ever until you're afraid you'll tear her insides apart.\n\n", false);

	outputText("You're not quite done yet, though.  As soon as her orgasm subsides, you draw her off your shaft and turn her upside down in your tail's grasp.  You lower her head until it's even with your " + player.cockDescript(x) + ", and her bare cunt is vulnerable before you.  Without encouragement, she takes your shaft into her mouth, using her tits to pump it into her welcoming maw as you set to work on her twat, tongue fucking her while you slip one, two, three fingers into her ass, eliciting a deep moan of pleasure from her with the dual stimulation.\n\n", false);

	outputText("But you can soon feel your orgasm coming as she continues to titfuck you and suck your cock head.  Feeling the impending climax, she quickens her pace to an almost-maddening tempo, but still you hold on... until she slips her long, slender tongue straight into your urethra.  The incredible, piercing sensation sends you over the edge; you buck your hips into her face and cum, hard, shooting thick ropes of jism into her waiting mouth.  She sucks your seed down eagerly as you pump more and more into her mouth, continuing to tongue fuck her and finger her ass until she cums again, screaming and writhing in your tail's firm grasp, spitting drops of your seed to the ground as she dangles.\n\n", false);

	outputText("Exhausted by the ", false);
	if (flags[kFLAGS.HEL_FUCKBUDDY] == 0) outputText("battle and ", false);
	outputText("massive orgasm, you collapse onto your back and release your salamander lover from your grasp.  She crawls up to you and nuzzles into your " + player.chestDesc() + ", wrapping her own tail around you in return.  Soon, you drift off into a calm, peaceful sleep.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}


//Player Win – Coil her Up 69 (anal naga) (edited)
private function nagaCoilsUpAnalNaga():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-nagaanal"));
	outputText("You slither closer to the salamander and tell her that, yeah, you could stand to work off some steam.  She grins at that and closes the distance between you, reaching out to caress your serpentine half.  \"<i>Mmm.  Sexy tail, lover,</i>\" she says, reaching around and giving your " + player.buttDescript() + " a squeeze in her smooth, scaled hands.  \"<i>It'd be a real shame for such beautiful coils to go unused, you know...</i>\" she adds, giving you a little wink.\n\n", false);

	outputText("You get an idea in a hurry, and quickly discard your " + player.armorName + " as she does the same.  She drops to her hands and knees before you, and like a child, snatches at your tail.  Once in hand, she eagerly puts her mouth to it, sucking your tail's tip like a cock.  You shudder at the odd sensation, but when she raises her tail up toward you, you reciprocate the gesture, taking her extinguished tip into your mouth and slathering it with spittle.\n\n", false);

	outputText("Once both your tails are sufficiently lubricated, the salamander crawls behind you, and presses her back tightly to yours.  In an odd show of kindness, she even takes your hands in hers as her tail slithers between the cheeks of your " + player.buttDescript() + ".  You return the favor, soon pressing the tip of your tail to her tight but relaxed asshole as hers begins to slip into your " + player.assholeDescript() + ".  You gasp with the sensation of the hot, writhing tail-cock pushing inside you, fighting every inch to wring sensation out of it even as you push yours deep inside her, hard enough to make her take a sharp breath and knock her knees.", false);
	player.buttChange(40,true,true,false);
	outputText("\n\n", false);
	
	outputText("She continues to force her way into you, wriggling her thickening tail further into your " + player.assholeDescript() + ", stretching it wide as her tail gains in thickness.  Finally, though, she can get no more of herself into you, nor you into her.  \"<i>Ready for a wild ride, lover?</i>\" she asks, twisting her head so that she can plant a tender kiss on your shoulder.  You nod eagerly, and start to bounce.\n\n", false);

	outputText("You rise up on your tail, pulling hers nearly out of you, as she parts from yours.  You both gasp and moan like whores, and doubly so when you slam yourselves back down, stuffing your ass with hot salamander backside as she packs her ass with your tail in turn.  \"<i>Oh, fuck YEAH!</i>\" she screams, gripping your hands and bucking wildly on your tail tip, ramming you into her asshole as you continue to bounce, picking up your own pace to keep time with your lover.\n\n", false);

	outputText("You ram yourself down on her hot tail, pull out till her tip is all that's left, and ram down again, over and over until your ass burns with pleasure and her inner fire, and your lover screams with coming orgasm.  With one last mighty roar, you impale yourself hard upon her tail, taking it inside you until little more than her base remains outside.  You add your voice to hers as a mind-breaking orgasm washes over you like a tidal wave, making you buck and squirm on her tail, forcing yours so deep inside your lover that she can't help but wail in pleasure and pain.\n\n", false);

	outputText("When you come to your senses, you're lying on your back, panting and gasping for breath.  Slowly, you salamander lover drags herself to her feet, only to collapse on top of you a second later.  Seemingly content, she nuzzles into your " + player.chestDesc() + " and strokes your cheek.  No less than exhausted yourself, you soon drift off into a peaceful sleep.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Mount Her (Wangbearing Centaurs of height >= 60</i>\") (edited)
private function mountHel():void {
	spriteSelect(68);
	var x:Number = player.cockThatFits(85);
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	outputText(images.showImage("helia-mount"));
	outputText("You trot up to the salamander and, just as you're about to tell her a few of your fantasies you two could enact, she spills one of her own!  \"<i>Oh, Marae,</i>\" she purrs, reaching out to stroke your blank flank, \"<i>I've always wanted my very own warhorse.  What do you say you let me ride you... and maybe I'll let you ride me?</i>\"\n\n", false);

	outputText("Well, that was unexpected, but hey.  You've heard much weirder things since you came to this world, and damned if you don't find many people around who can appreciate your stately equine half.  You give her a nod, and before you know it, the salamander's swung herself up onto your back and wrapped her arms tight around your human waist, pressing her large, soft breasts into your back.\n\n", false); 

	outputText("\"<i>Giddyup,</i>\" she whispers huskily into your ear, and her scaled, clawed feet give your flanks a little poke.\n\n", false);

	outputText("You start trotting, letting her arms about your hips guide you this way and that across the wide open plains.  All the while, she whispers gentle encouragements into your ear, occasionally stopping to rub her tits tantalizingly into your back or let her dangling tail run across your " + player.cockDescript(x) + ".  Eventually, though, she sets her sights on a lone, leaning tree atop of a distant hill, and directs you toward it.\n\n", false);

	outputText("When you arrive, she slips gracefully from your back and laughs aloud.  \"<i>Oh, that was fun!  Thank you so much, friend.  I've never ridden a horse – a centaur – before you, but I think I could get used to it.  Oh!  Imagine, you and I, valiant adventurer and her trusty warhorse, wading into battle like – Hey, I see that look on your face.  Don't laugh, dammit!</i>\"\n\n", false);

	outputText("You stifle a chuckle, and gently remind her of a certain obligation of hers.  \"<i>Mmm.  Well, fair's fair and all.  You let me ride you, so...</i>\" she says, walking up to you with her wide, muscular hips swaying, tail swishing. \"<i>... I let you ride me.</i>\"  She pulls your face close to hers and gives you a kiss on the lips, slipping in a bit of her long, forked tongue. Soon after sees your " + player.armorName + " discarded on the ground, and her own bikini tossed haphazardly aside.  She kneels, grabbing your hardening " + player.cockDescript(x) + " in her two scaled hands and pumping it to firmness, quickly lubricating it with her tongue as she works, continuing until your cock is a sopping mess beneath your body.\n\n", false);

	outputText("Naked and beautiful, curvy and muscular, the salamander turns underneath you and steps up to the tree.  She plants her feet wide apart and grips the thick, smooth trunk of the tree.  Looking over her shoulder, she gives you a little wink.  \"<i>Don't worry, lover, I'm even stronger than I look.  Go ahead – show me what you've got.</i>\"\n\n", false);

	outputText("You're a little nervous about outright breaking her, but she asked for it.  You trot up and swing your front hooves over her shoulders, resting part of your weight on her as your " + player.cockDescript(x) + " presses urgently against her firm ass cheeks.  She gasps and groans under your weight and at the prodding of your cock, so desperately seeking a hole to fill.  Finally, you slip between her legs and enter her cunt, ramming your full " + num2Text(int(player.cocks[x].cockLength)) + " inches into her sweltering depths.  You gasp and shudder at the intense heat of her inner walls, but your lover can only cry with exaltation as your cock fills her to the hilt.\n\n", false);

	outputText("\"<i>Come on, dammit!</i>\" she snaps over her shoulder, her face sheened with sweat from hoisting part of your centaur weight.  \"<i>Fuck me – fuck me like a gods-damned animal.</i>\"  You oblige, instinct taking over as your hips begin to buck and thrust, ramming your cock in and out of her.  \"<i>That's it!  Yeah, breed me, make me your mare, fill me with horse-spunk.  Don't stop – don't stop.  Gods, don't stop – just keep rutting!</i>\"\n\n", false);

	outputText("You hammer into her, relentless and brutal, fucking her hard enough to break a human girl's hips.  But this woman – she laughs and cries with glee as you rut her like a beast of burden, your horse-half trying to breed her like a prize stallion on the mare she so wants to be.\n\n", false);

	outputText("You fuck and rut and thrust until the salamander lets out a sharp cry, and her steaming inner muscles clamp down like a vice.  You grunt and impale her one last time before your " + player.cockDescript(x) + " explodes within, filling her to the brim with your centaur spunk", false);
	if (player.cumQ() >= 500) outputText(" until it begins to pour out around your cock, pooling between her spread legs", false);
	outputText(".\n\n", false);

	outputText("You stay like that for a good few minutes, your " + player.cockDescript(x) + " rammed to the hilt inside of her as she grips the tree, huffing and puffing and reeling from her orgasm.  Finally, she lowers her rear, letting you dismount her.  You take only a few paces before you collapse on your side, exhausted.  A moment later and you feel the warm body of your salamander lover curl up against your belly, arms wrapped tightly around your flanks.\n\n", false);

	outputText("\"<i>You sure I can't convince you to stick around?  I was serious about needing a warhorse... doubly one that can make me feel like a wild animal being bred...</i>\"  ", false);
	if (player.cor < 50) outputText("Sadly, your duties as Champion prevent you from accepting her offer, even if you wanted to.  You tell her as much, and she sighs heavily.", false);
	else outputText("You can't imagine committing to just one of this world's many eager pussies when so many more will go unfilled, though you fob her off with a more polite excuse.", false);
	outputText("  \"<i>Well, you'll still come back to me, huh?  I might miss my little pony.</i>\"\n\n", false);
	
	outputText("Chuckling, you assure her you'll be back when you can, and soon, you've both drifted off into a contented, restful sleep beneath the lone tree amidst the plains.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Hanging 69 (Vaginataurs of height >= 60</i>\") (edited)
private function helVaginaTaur69():void {
	spriteSelect(68);
	clearOutput();
	outputText("You trot up to the salamander and, just as you're about to tell the salamander a few of your fantasies you two could enact, she spills one of her own!  \"<i>Oh, Marae,</i>\" she purrs, reaching out to stroke your blank flank, \"<i>I've always wanted my very own warhorse.  Tell you what – let me ride you, and I'll give you something oh so special...</i>\"\n\n", false);

	outputText("Well, that was unexpected, but... you've heard much weirder things since you came to this world, and damned if you don't find many people around who can appreciate your stately equine half.  You give her a nod, and before you know it, the salamander's swung herself up onto your back and wrapped her arms tight around your human waist, pressing her large, soft breasts into your back.  \"<i>Giddyup,</i>\" she whispers huskily into your ear, and her scaled, clawed feet give your flanks a little poke.\n\n", false);

	outputText("You start trotting, letting the hands on your withers guide you this way and that across the wide open plains.  All the while, she whispers gentle encouragements into your ear, occasionally stopping to rub her tits tantalizingly into your back, letting her dangling tail flicker across your " + player.vaginaDescript(0) + " and " + player.buttDescript() + ".  Eventually, though, she sets her sights on a patch of particularly tall, green grass, almost up to your ears.  As soon as you arrive, she slips gracefully from your back and laughs aloud.  \"<i>Oh, that was so much fun.  Thank you, friend.  I've never ridden a horse – a centaur – before you, but I think I could get used to it.  Oh!  Imagine, you and I, valiant adventurer and her trusty warhorse, wading into battle like – hey, I see that look on your face.  Don't laugh, dammit!</i>\"\n\n", false);

	outputText("You stifle a chuckle, and gently remind her of a certain obligation of hers.  \"<i>Mmm.  Well, you let me ride you, so I guess it's only fair,</i>\" she says, walking up to you with her wide, muscular hips swaying, tail swishing.  \"<i>... If I tend to my trusty steed.</i>\"  She pulls your face close to hers and gives you a kiss on the lips, slipping in a bit of her long, forked tongue.  She breaks the kiss, and soon after has your " + player.armorName + " discarded on the ground, and her own bikini tossed haphazardly aside, then takes a step back; you can hardly reach out to her before she's vanished in the tall grass!\n\n", false);

	outputText("You're starting to think you've been had by the time she returns, holding a thick coil of knotted grass in her arms.  She silences any protest with another kiss before slipping back to your horse half, then slings a pair of woven grass ropes over your back and ties them closed, working up what looks like a harness hanging underneath you.  You voice your surprise as the salamander slides into the harness, making you support her entire weight as she shifts and adjusts into a comfortable position beneath you.  Looking down, you can hardly see her at all – she's lying opposite you, her legs hanging out of the sling near your arms and her shoulders resting between your rear legs.\n\n", false);

	outputText("After a moment, she settles, and is still.  All you can feel is her hot breath on your underside and the strain of her weight on your back.  It isn't long, however, before the salamander reaches out with one of her clawed, scaled hands, tracing a finger up your sensitive inner thighs and making you shudder with anticipation.  Eventually, it snakes up to your wet, waiting " + player.vaginaDescript(0) + ", brushing a knuckle against your anxious lips.\n\n", false);

	outputText("You're hardly prepared for what comes next.  Without warning, the salamander slams her arm into your cunt, punching hard into your cervix.", false);
	player.cuntChange(50,true,true,false);
	outputText("  You scream and buck, nearly throwing her from her harness.  Laughing maniacally, she forces more of her arm into your unsuspecting depths until she's up past her elbow in centaur cunt.  You gasp and buck and whinny, but anything that serves to dislodge her arm from your " + player.vaginaDescript(0) + " only gives her ample opportunity to jam it right back in.\n\n", false);

	outputText("She hammers your cervix, fist-fucking you like a massive knotted cock.  It takes a minute to reconcile yourself to the enormous penetration, but soon you're shaking your hips and whinnying with pleasure.  ", false);
	if (player.hasCock()) {
		outputText("Now that you're calmer, the salamander takes the opportunity to grasp " + player.oMultiCockDesc() + " with her free hand and guide it into her mouth.  Her forked, reptilian tongue flicks out, running across your girth as more and more of you slips past her thin lips and down her throat", false);
		if (player.shortestCockLength() <= 24) outputText(" , until you're buried to the hilt", false);
		outputText(".  You moan lewdly as she begins to suck in time with her fist-fucking, doubling up on you until your mind is almost numb with pleasure.  ", false);
	}
	outputText("This feels awfully one-sided, but her vulnerable nethers are just out of your reach – but that's not going to stop you.\n\n", false);

	outputText("With a wicked smile, you snatch up the woman's writhing tail and grasp it like a whip, coiling it until only a foot or so extends past your wrist.  Now, you lean down and prod at her with the tail, trying blindly to set its pointed tip into her vacant cunt.  Finally, you find your mark, her tail slipping past her hips and into her slit.  You thrust the tail forward into its owner, eliciting a yelp of pleasure", false);
	if (player.hasCock()) outputText(" from around your encapsulated cock", false);
	outputText(".  Getting a good grip on her hot, red tail, you start to fuck her hard, fast, and perhaps vengefully as she continues to assault your " + player.vaginaDescript(0), false);
	if (player.hasCock()) outputText(" and swelling member", false);
	outputText(".\n\n", false);
	

	outputText("It cannot go on forever.  You soon feel the tell-tale pressure of impending orgasm building behind your " + player.vaginaDescript(0), false);
	if (player.hasCock()) outputText(" and shaft", false);
	outputText(".  And you're not alone: under your intense tail-fucking, the salamander screams her climax, and you feel a gout of girl-cum squirt onto your underside.  You aren't far behind, clamping down on her invading fist as your own orgasm hits, nearly toppling you over with its intensity", false);
	if (player.hasCock()) outputText(" and filling her throat with jism", false);
	outputText(".\n\n", false);

	outputText("It takes a minute for your body to calm down; when it has, your salamander lover slips out from her harness and collapses on the ground, soaked in a mixture of your cum and hers.  Exhausted beyond the efforts of willpower, you drop to the ground beside her and drift off to a restive, bruised sleep.\n\n", false);
	//(reduce lust, reduce HP?, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Possession (Ghost Morphs w/ Possession Power) (ehrdaterd)
private function helPossessionShitPoopCock():void {
	spriteSelect(68);
	clearOutput();
	outputText("Taking advantage of the salamander's open state, you will yourself into incorporeality and glide toward her.  \"<i>Hey!  Wait!  What the fuck are you doing?</i>\" she yells as you approach her in your spectral form.\n\n", false);

	outputText("With a sneer, you answer, \"<i>I'M GOING GHOST!</i>\" and lunge into her.\n\n", false);

	outputText("She lets out a shocked gasp as you stretch your ghostly influence, pouring yourself into the salamander's mind.  She struggles, flailing around helplessly and clawing at her skull, but you are far beyond the reach of fingers.  With a force of will, you suppress her handle on her body, and assume direct control.  You crack your neck and knuckles, getting a quick feel for your new anatomy.  It's hotter than you're used to – much hotter – but that's a fair price for possessing such a smoking body.  You give her large tits a teasing squeeze, feeling a bolt of pleasure run up your chest.  Oh, she's <i>sensitive</i>!  Giving your new, fiery tail a little swish, you start jogging across the plains looking for someone awake to share the fun with.\n\n", false);

	outputText("\"<i>Seriously, what the FUCK!?</i>\" your unwilling host screams, struggling to break your hold on her.  Laughing maniacally, you push her back down into her primal little corner of the brain and keep running, scanning the horizon for some sign of life.  With the salamander struggling to get control back, you're relieved when it doesn't take TOO long to catch sight of a hop-hopping figure bouncing on the plains, her tall bunny-ears flopping gaily about her cute, rounded face.  Smiling wickedly, you dash straight for the bunny-girl!\n\n", false);

	outputText("She sees you approaching, she leaps in terror, whipping her previously-obscured hands off her 14-inch bunny-cock.  However, it seems she recognizes the salamander, and with a look of embarrassment says, \"<i>Uh, hi!  Umm...  Since I'm still in s-season, c-could we...</i>\"  You leap forward and tackle the bunny-girl, pressing your lips tightly to hers as you grab her rock-hard cock in the salamander's clawed hands.  Breaking the kiss, you start stroking the bunny-girl, internally laughing as the salamander finally gives up the ghost, so to speak, seemingly resigned to her fate.  The bunny just looks up at you in a confused stupor, stroking her tiny nipples as you line her up with your salamander's vagina.\n\n", false);

	outputText("\"<i>If you let her cum inside me I will fucking MURDER YOU!</i>\" the salamander's voice growls as you slide down onto the waiting tower of bun-meat, sighing pleasurably as her head slips easily into your slick cunt.  The bunny-girl gasps at the sudden explosion of heat, but you feel her start to leak pre almost immediately, giving you just a bit more lubrication as you slide down her shaft.  You clench your taut thigh muscles around the bunny's hips, wringing her cock as its thick veins rub you in just the right ways.  Finally bottoming out, you feel a pair of heavy rounded orbs against your ass.\n\n", false);

	outputText("Suddenly, in your moment of contentment, you're thrown out of control as the salamander makes a desperate bid to rid you from her mind.  She grabs the bunny-girl's shoulders and starts to bounce, faster than you would have thought possible, ramming herself down on the bunny-shaft until it hurts.  You yelp in pain and try to seize control, but too late!  There's an intense fire in the bunny-girl's eyes, and by the time you push back into proprietorship of your shared mind, the bunny has thrown you onto your back and grabbed your hips.  Grinning lustily, the bunny starts to pound your vag as hard and fast as she can, until her tongue starts to loll from her mouth and you can feel her shaft leaking pre in incredible volume.\n\n", false);

	outputText("Only just able to think through the pleasure and pain of the bunny-rape, you decide to switch things up a bit.  You release your hold on the salamander and slip your ghostly form out of her... and into the bunny girl!  She's so overwhelmed by lust that she barely notices you, much less resists, as you grab the reins.  You cry out with pleasure as you resume pounding the salamander's burning-hot box with your impressive bunny-rod, using her wide hips as leverage to thrust balls-deep inside her.\n\n", false);

	outputText("Now all alone in her mind, she screams out in pleasure, trying to curse you out but only succeeding in yelling to the heavens as she cums, hard, her sopping box clamping down on your shaft like a hot silken vice.  She grabs your shoulders and pulls you down atop her, burying your cute little bunny face into her massive, sweat-slick cleavage as she rides out the orgasm, now bucking her hips into yours as you continue to pound her.\n\n", false);

	outputText("Your eyes go wide as the base of your cock distends, cum now pouring out of it.  You yank your cock out of the hot depths, trying desperately to jerk whatever in the hell is now working its way up your shaft out.\n\n", false);

	outputText("Inside your mind, you hear the bunny-girl stammer, \"<i>Egg egg egg egg... GONNA EGG!</i>\"\n\n", false);

	outputText("Fucking eggs!  Now wracked by a mind-numbing pleasure, you can only watch passively as the salamander throws you onto your back and clamps your bunny-cock between her massive tits.  \"<i>Since you were nice enough not to let this thing cum inside me,</i>\" she says with a grin, flicking your now-distended shaft as she pumps it between her breasts, \"<i>I'll be a good girl and help you get rid of your little problem.</i>\"\n\n", false);

	//(IF PC HAS NIPPLECUNTS:)
	if (player.hasFuckableNipples()) {
		outputText("Well, you can't let her have ALL the fun!  Still leaving the lower half of your body within the bunny-girl, you slip a pair of fingers into one of your hungry nipplecunts.  Grinning, you stretch your nipple-fuckhole out and bend forward, letting your chest-lips kiss the tip of your possessed bunny-cock.  You shudder as you press yourself down upon the bunny rod, taking the first few inches into your " + player.chestDesc() + " even as the salamander continues to titfuck the length of your column.  You settle into a rhythm with the salamander, rising and falling in unison as you coax the eggs out of the bunny and toward your nipplecunts.\n\n", false);

		outputText("Your eyes roll back in your head, your long tongue rolling out of your mouth as you give in utterly to the pleasure.  The first egg crests out of your distended bunny-cock, making you scream with orgasmic pleasure as it launches into your hard-cumming nipplecunt.  The top of your " + player.chestDesc() + " lurches upward with the impact, then again as eggs slam out of you and into your waiting tit-mouth.  Laughing, the reptilian woman yanks the cock out of your tit and squishes it between her own mounds, finishing your orgasm off as she hungrily licks the bunny-spooge out of your chest-holes, letting it pour onto herself as eggs crack against her chest.\n\n", false);
	}

	//(IF NO NIPPLECUNTS:) 
	else {
		outputText("You can only nod your head and buck your hips as she titty-fucks your bun-cock, humping herself up and down your borrowed length.  The eggs are now nearly at the gorged tip of your cock, and as the first one shoots out of you, your mind is utterly shattered by orgasm.  You cry aloud and wildly buck your hips and thrust between the huge tits, trying desperately to push out the remaining load.  Your eyes roll back in your head, your long tongue rolling out of your mouth as you give in utterly to the pleasure.\n\n", false);

		outputText("Eggs begin to shoot out of your cock at full force.  The first takes your partner straight in the face, breaking on her chin and smearing her with its yolky contents.  She only laughs as the slime drools off her face, still pumping your shaft between her tits as the next egg rolls to a stop between your own bunny-tits.  You sigh contentedly as the eggs spurt out of your now-engorged cock, finally coming to a stop and leaving a great pool of cum on the salamander's tits and face.\n\n", false);
	}
	
	outputText("When your orgasm has subsided, you pull yourself out of the poor, cum-drenched bunny girl.  She merely flutters her eyes and waves as you and the salamander stagger off, arm in arm.\n\n", false);

	outputText("\"<i>Fuck you,</i>\" the latter says, laughing.  A big dollop of cum drops from her chin to her tits, splattering right above her hard nipple.  \"<i>Still, that was... one hell of a way to have a three-way.</i>\"\n\n", false);

	outputText("You laugh, and let out a long, contented yawn.  At the salamander's invitation, you find a secluded clearing in the grass not far away, and snuggle up to nap off the post-sex fatigue.", false);
	//(reduce lust, increment Helgate flag by 1)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}


//Player Win – Corrupt Rape – Rape her Ass (wangers and mash) (edited)
private function rapingHelsAssMeansYourCorruptCauseAnalIsEvil():void {
	spriteSelect(68);
	var x:Number = player.cockThatFits(85);
	var y:Number = player.cockThatFits2(85);
	clearOutput();
	
	outputText("Already getting hard in your " + player.armorName + ", you circle around the downed salamander and give her a rough kick in the scaly back.  She yelps and takes a face-plant, leaving her muscular ass and long, hot tail waggling invitingly in the air.  Grinning, you hastily toss your " + player.armorName + " aside and tear her bikini bottom off, revealing the gash of her pussy, as well as your real prize – her tight little pucker, nearly hidden in the shadow of her tail.  As you get ready to claim the spoils of your victory, the still defiant salamander lashes out with that same tail!\n\n", false);
	
	outputText("She's too exhausted, and you're too skilled, for the attack to land.  Instead, you grab her wide hips and lunge forward, ramming your " + player.cockDescript(x) + " into her ass", false);
	if (y >= 0) outputText(", and your " + player.cockDescript(y) + " into her waiting vag, doubling the assault on the helpless berserker", false);
	outputText(" while she's vulnerable.  She screams in surprise, arching her back and squirming in pain.\n\n", false);

	outputText("She's tight as a silken vice!  Her sphincter grips down hard upon your cock, making you fight for every inch, and it's HOT.  You're almost afraid you're going to come away with burns, but you're this far already, and the feeling of such intense heat is incredible.  You continue to force your way into her; she moans and grunts in pain and pleasure over the final inches until you've bottomed out, your entire length buried inside her asshole", false);
	if (y >= 0) outputText(" and vagina", false);
	outputText(".\n\n", false);

	outputText("Just as you're about to pull out for the next thrust, you catch her looking over her shoulders, rage and hatred painted all over her features.  Well, you can't let that stand, can you?  You reach forward and grab a fistful of her hair, yanking her head violently back.  She yelps, and squeezes down magnificently upon your cock", false);
	if (y >= 0) outputText("s", false);
	outputText(", milking you with her taut muscles.  You grin wickedly before pulling out until your cock's head is all that's left buried inside her, and grunt with pleasure as you thrust all the way back inside her in one massive thrust.  She screams again, this time in a mix of pain and pleasure, her tongue lolling from her mouth as her muscles constrict tightly around you.  You pull out, thrust back in, and then repeat again.  You keep this up for a long minute, pounding away at her asshole as she begins to moan like a whore, groping her tit with one hand and ravaging her clit with the other.\n\n", false);
	
	outputText("\"<i>Oh, yeah, fuck my ass! Just like that!</i>\"  She screams, clamping down on your cock as her orgasm comes.  You shove yourself all the way in as her girlcum splatters onto your [legs], spurting from her cunt.  Her cries of rage-turned-ecstasy only make your own orgasm all the better.  You give her a few last seconds of violent pounding before you roar and explode within her, pumping your cum deep inside her ass", false);
	if (y >= 0) outputText(" and vag", false);
	outputText(", filling her with your seed until you're drained dry and deflating inside her.\n\n", false);

	outputText("You yank yourself out of her in one quick pull; she collapses onto her side without you to support her, and shudders when another wave of her protracted orgasm hits her as she absently fingers herself.  The sight turns you on a bit, but you decide to leave her there and head back to camp, though you're sure to snatch her coinpurse before you go.", false);
	//(reduce lust, decrement Helgate flag by 1 to a minimum of 0)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]--;
	//Bump down follower tracking affection too
	helFollower.helAffection(-15);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//Player Win – Corrupt Rape – Get Rimjob (edited)
private function receiveCorruptRimjobsFromHel():void {
	spriteSelect(68);
	clearOutput();
	outputText("The sight of the salamander berserker on her knees stirs the fire in your loins, and in moments you've stripped out of your " + player.armorName + " and advanced upon her.  She looks up at you, gritting her teeth as if preparing to strike – you preempt her with a hard kick in the chest, knocking her on her back, then kneel down and straddle her, pinning her arms down underneath your knees as you bring your " + player.assholeDescript() + " to hover over her face.\n\n", false);

	outputText("She gets the idea in a hurry, and you feel her forked, serpentine tongue dart out and begin exploring your thighs, ass cheeks, and crotch.", false);
	if (player.hasVagina()) outputText("  Her tongue begins to zero in on your " + player.vaginaDescript(0) + ", but you give her a quick penalty swat on the tits.  You've got other plans!", false);
	outputText("\n\n", false);

	outputText("After a few moments of this, her long tongue traces its way along your " + player.buttDescript() + ", causing small shudders of pleasure to rock through you, but she's only just getting to the main event.  You force yourself to relax your sphincter as her tongue flicks once, twice, thrice across your " + player.assholeDescript() + ".  In a heartbeat, she's in!  You gasp as her long, slender tongue flicks and writhes within you, teasing and pleasuring the sensitive muscles of your ass as she works more and more of it in.\n\n", false);

	outputText("Firmly within your depths, she plants her smooth, scaled hands on your " + player.buttDescript() + " and starts to flick her tongue as fast as she can, withdrawing and ramming it back into your ass.  You gasp and moan like a whore", false);
	if (player.biggestTitSize() >= 1) outputText(", groping your tits,", false);
	outputText(" as you buck your hips, smashing your groin into her face, barely able to support your own weight as she fucks your ass hard and fast.\n\n", false);

	outputText("Eventually, you can take no more, and feel your climax coming on.  The salamander, possibly sensing this by the way you wring her tongue, gives your " + player.buttDescript() + " a hard slap and rams in as far as she can go!  You rocket over the edge, screaming and shuddering so hard that you collapse onto the dirt, writhing in pleasure as her tongue slowly withdraws from your " + player.assholeDescript() + ".\n\n", false);

	outputText("Wide-eyed and panting, you struggle to your feet and, sure to grab a few gems from her supine form, stagger back to camp to recover from your fucking.", false);
	//(reduce lust, decrement Helgate flag by 1 to a minimum of 0)
	player.orgasm();
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	flags[kFLAGS.HEL_AFFECTION]--;
	//Bump up follower tracking affection too
	helFollower.helAffection(-15);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(postHelFuckBuddyFollowup);
}

//===========================================================================
//MINOTAUR THREESOME ENCOUNTER & ACHIEVING SALAMANDER FUCKBUDDY STATUS (minotaurs don't live near the plains dogg) (edited)
//===========================================================================
//triggers only after you've incremented the Helgate flag five times with 'consensual' sex (win or lose), but not Corrupt Rape options.
private function helMinotaurThreesome():void {
	spriteSelect(68);
	//Reset the additional talk options
	flags[kFLAGS.HEL_TALKED_ABOUT_BERSERKING] = 0;
	flags[kFLAGS.HEL_TALKED_ABOUT_ATTACKING_YOU] = 0;
	clearOutput();
	outputText(images.showImage("helia-threesome-minotaur"));
	outputText("As you wander the grasslands, you wipe your brow in the hot air, wondering where the normal denizens hereabouts have gotten off to – normally you'd have encountered SOMETHING by now.  Your mind turns faintly toward your salamander friend, if you can call her that after the disjointed encounters you've had, and if the stirring in your loins is any indication, you're fairly sure you kind of miss her.\n\n", false);

	outputText("You continue to walk aimlessly for a few minutes, straying a bit nearer to the mountains than you normally go on the plains.  As you continue to walk, however, you hear a sudden cow-like bellow!  You drop into a combat stance and raise your " + player.weaponName + ", almost sure the roar must be a long-ranging minotaur, but you can see nothing.  You perk your ears, and start to trace the sound as it repeats again, and again.  Your gaze fixes on a nearby hill and you quickly run to its peak, ready to intervene in whatever attack is afoot.\n\n", false);

	outputText("Well, it's a minotaur, all right.  But if there's any attacking going on, it's the poor beastman getting victimized.  You see your salamander, her sword and bikini tossed haphazardly aside, riding the minotaur's bull cock with a fervor, bouncing on his meat-stick and moaning loudly at the fullness he's shoving inside her.\n\n", false);

	outputText("She notices your approach over her shoulder, and stops groping her hefty tits just long enough to wave. \"<i>Hey, lover!  I – gah! – I'd normally swing a sword your way but – oh YEAH! – I'm a bit – come on, you limp-dick bastard!  FUCK ME! – busy at the moment.</i>\"\n\n", false);

	outputText("You can't help but laugh at the absurdity of it.  She grins over her shoulder at you, but stops to gasp as the minotaur between her legs bucks his hips, burying his dick deep in her welcoming cunt.  \"<i>Well, don't just stand there, killer!  ", false);
	if (player.hasCock()) outputText("I've got another hole needs filling!</i>\"", false);
	else outputText("There's enough 'taur to go around, so come on!</i>\"", false);

	///Player's Options:
	//Male/Herm – [Fuck her Ass] [Mino Lick] [Leave]
	if (player.hasCock() && player.cockThatFits(85) >= 0)
		simpleChoices("FuckHerAss", fuckHerAss, "Mino Lick", helMinoThreeSomeLickItsDick, "", null, "", null, "Nope", leaveMinotaurHelThreesome);
	//Female/Genderless – [Mino Lick] [Leave]
	else simpleChoices("", null, "Mino Lick", helMinoThreeSomeLickItsDick, "", null, "", null, "Nope", leaveMinotaurHelThreesome);
}
//[Leave]
private function leaveMinotaurHelThreesome():void {
	spriteSelect(68);
	clearOutput();
	outputText("You shake your head with a deprecating smile, and turn to leave her to her pleasures.", false);
	//(reset Helgate flag to 0)
	flags[kFLAGS.HEL_AFFECTION] = 0;
	doNext(camp.returnToCampUseOneHour);
}

//THREESOME – FUCK HER ASS (wang of area =< 85) (edited)
private function fuckHerAss():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-threesome-minotaur-buttfuck"));
	var x:Number = player.cockThatFits(85);
	if (x < 0) x = 0;
	outputText("Well, damned if you're going to let a chance to fuck her good, hot ass slip by.  You quickly strip out of your " + player.armorName + " and grab your " + player.cockDescript(x) + ", stroking it to hardness as you approach the salamander and her Minotaur.  You drop to your knees behind the salamander and push her tail out of the way (not an easy task as she bounces happily atop the 'taur) to reveal her other hole.  You slip your cockhead in, meeting more than a little resistance, as your lover has trouble relaxing her muscles mid-fuck, but eventually force your way inside her, eliciting a deep, lusty moan from her lips.\n\n", false);

	outputText("You move to put your hands on her hips, but recoil when you feel rough, furred hands already firmly in place there.  \"<i>Heh, sorry lover,</i>\" the salamander says, sheepish.  \"<i>First come, first serve!</i>\"  As if to make it up to you, though, she takes your hands in hers and guides them up to her big E-cups, giving you something to hold on to as she starts to ride the bull's cock even faster, taking your cock in and out of her hot asshole again and again.\n\n", false);

	outputText("Realizing your role here is mostly passive, you buck your hips in time with hers and start to play with her tits, relishing in the dual feeling of a vice-tight ass around your " + player.cockDescript(x) + " and the soft, malleable flesh of the salamander's tits in your hands.  \"<i>Oh, yeah, boys!</i>\" she cries, arching her back and humping wildly.  \"<i>Deeper!  Yeah, come on, deeper!</i>\" she screams, grabbing your hands and slamming down on your cock and the taur's, burying them as deep inside her as they can go, again and again.  \"<i>Just like that!  Fuck my holes, fuck my holes, fuckfuckfuck FUCK ME!</i>\"\n\n", false);
	
	outputText("She screams to the high heavens as she cums, spasming in your grasp, holding your hands tightly as she bucks and bounces on the cocks inside her, soaring to a mind-numbing orgasm.  Her muscles tighten, clamping you hard as you continue to fuck her ass, but the bull can't take it.  He bellows loudly and squeezes the salamander's hips, shooting his load inside her so forcefully that a few streaks squirt back out at him, coating his chest.\n\n", false);

	outputText("The sight of the bull creaming himself sends you over the edge.  You give the salamander's tits a rough squeeze and thrust as far up her ass as your can before you cum, unleashing a torrent of pent-up jism inside her hole.  She gasps at the dual sensations, shuddering in your grasp as your cum and the 'taur's pour into her, filling her until cum streaks down and coats her thighs before pooling under her knees.\n\n", false);

	outputText("After a moment of stillness, the salamander tightens her hold on your hands and rolls off the 'taur, taking you with her so that she's lying on your chest, your cock still buried in her ass.  After taking a minute to recover, the minotaur shakily lurches to his feet and tosses a sack full of gems at his new friend before staggering off.\n\n", false);

	outputText("She bursts out laughing at the sight of the 'taur wandering off with a fistful of his own jism coating his fur.  \"<i>Oh, poor guy,</i>\" she laughs, \"<i>wandered a bit too far from home and ran into me.  Just like someone else I know.</i>\"  To your surprise, she rolls over atop you and plants a long kiss on your lips, eyes closed and tail wagging softly behind her.", false);
	//(reduce PC lust)
	player.orgasm();
	dynStats("sen", -2);
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	//POST THREESOME RESULT
	doNext(postMinoThreesomeDecisionTime);
}


//THREESOME – MINO LICK (Unisex) (edited)
private function helMinoThreeSomeLickItsDick():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-threesome-minotaur-minolick"));
	outputText("Well, you're certainly not going to pass an opportunity like this up.  You shed your " + player.armorName + " in a hurry and step up to the poor minotaur.  You only just hold in a laugh at the glazed, half-conscious look on his face.  Looking him over, you can see a veritable pool of bull-spunk beneath his ass or sticking to the salamander's thighs as she continues to bounce on his shaft, indicating that he's been raped a half-dozen times already.  You almost feel bad for the poor thing, but then again, you half suspect your friend would be in the same shape he's in now had he won.  So, with your " + player.armorName + " off, you kneel down over his bull-like muzzle and force his snout into your " + player.assholeOrPussy() + ".\n\n", false);

	outputText("You have to give him a nasty slap on the cheek before he actually does anything, though.  But when he does, it feels heavenly.  His tongue is large, flat, and VERY wet, licking at your thighs and ass so that you shudder at the strange, not altogether unpleasant, feeling.  Finally, though, he comes to his prize.  You shiver with anticipation as he gives your waiting hole an experimental lick, testing the waters.  An encouraging squeeze between your " + player.hipDescript() + " is enough to set him working.  His massive tongue finally penetrates you, slipping into your waiting, sensitive hole, making you gasp in delight as he slathers your inner walls with his tongue.\n\n", false);

	outputText("Happily, you start to buck your hips on his muzzle, riding his tongue like a heavily-lubed prehensile cock.  You look from the 'taur to the salamander facing you, impaled on the bull's cock like you are on his tongue.  She's gorgeous, you think – bucking wildly on his shaft, her red hair whipping in the breeze as her massive tits bounce in time with her.  You can't stop yourself from reaching across the bull's body and kissing her, full on the lips.  She starts, missing a thrust, but in the blink of an eye is returning the kiss, entwining her reptilian tongue with yours as you begin to fuck the bull in unison, your bucking hips coming into sync.  All too soon, though, you can sense the tension building in the bull, and he begins to bellow into your ", false);
	if (player.hasVagina()) outputText("crotch", false);
	else outputText("ass", false);
	outputText(", announcing his impending orgasm.\n\n", false);

	outputText("\"<i>Bully for you,</i>\" the salamander laughs, hammering at his pelvis with renewed vigor.  \"<i>Give me one last shot of that delicious cream.  Come on, damn you... CUM IN ME!</i>\"\n\n", false);

	outputText("With a mighty bellow, the 'taur slams his hips into hers and comes on demand, pumping her so full of bull-cum that jets of it begin shooting back at him, coating his furry chest with his own jism.  The sight of it's enough to drive you over the edge, and you thrust down on the bull's snout and cry aloud as your own orgasm comes, your " + player.assholeOrPussy() + " clenching down on his tongue, trapping it inside you as your orgasm rocks your body", false);
	if (player.hasCock()) outputText(" while " + player.sMultiCockDesc() + " ejects its load into the mess on the 'taur's chest", false);
	outputText(".\n\n", false);

	outputText("Finally, your orgasm ends, and you roll off the minotaur.  Shakily, he staggers to his hooves, throws a handful of gems onto the prone salamander, and stumbles off to recover.  You look up from your collapsed state, and see your friend wallowing in a thick pool of cum – hers, yours, the 'taurs – panting heavily.  A huge stream of it is pouring from her cunt like a waterfall, a half-dozen backed-up minotaur orgasms unleashed at once.  Seeing you stare, your friend chuckles and stands, walking over to you and cuddling up, her head rested on your chest for just a moment before she leans up and plants a surprisingly tender kiss on your lips.\n\n", false);
	//(reduce lust)
	player.orgasm();
	dynStats("sen", -2);
	flags[kFLAGS.HEL_AFFECTION]++;
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	flags[kFLAGS.HEL_FUCK_COUNTER]++;
	//POST THREESOME RESULT
	doNext(postMinoThreesomeDecisionTime);
}

//AFTER THREESOME SCENE (edited)
private function postMinoThreesomeDecisionTime():void {
	spriteSelect(68);
	clearOutput();
	outputText("When she breaks the kiss, she leans back on her elbows and smiles at you, surprisingly prettily.  For once, you don't feel cripplingly exhausted after meeting her – no fight to tire you out before sex – so perhaps this would be a good time to interview your red-headed warrioress.\n\n", false);

	//Player's Options (All Genders): (Note: Each option disappears after it is selected once)
	//[Berserker Mode] [Her] [Attacking You] [Seconds?][Bug the Fuck Out From This Cuddling Shit]/[Leave]
	//MAKE SURE players need to take the HER option, if nothing else, before progressing the relationship– don't display Seconds or Attacking You until they do! Otherwise, they'll never know her name, which is problematic in the Threesome with Isabella.
	helChatMenu();
}
	
//[I'm Bugging Out]
private function bugOutAfterHelMinoThreesome():void {
	clearOutput();
	spriteSelect(68);
	outputText("On second thought, you'd rather keep it simple for now, even if it means battling back her future advances with force of arms instead of words.  You kiss her once more and give her breasts a squeeze for the road, then wordlessly get up and take your leave.\n\n", false);
	//(reset Helgate to 0)
	flags[kFLAGS.HEL_AFFECTION] = 0;
	doNext(camp.returnToCampUseOneHour);
}

//[Berserker Mode]
private function berserkMode():void {
	spriteSelect(68);
	clearOutput();
	outputText("You take the opportunity to ask about her rather violent, enraged fighting style.\n\n", false);

	outputText("She laughs, a strikingly girlish sound from her.  \"<i>Come on, haven't you ever been so pissed-the-fuck-off that you just want to kill everything?  It's like that.  Every morning when I leave camp, I spend an hour or so thinking about everything I hate – the demons, the gnolls");
	if (flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 0) outputText(", that fat cow Isabella");
	outputText(" – and then I just go off on anything I see.  Hey, don't give me that look, you're the only thing I've ever met out here that's even half-way decent.</i>\"\n\n", false);

	outputText("She kisses you again.\n\n", false);

	outputText("\"<i>... And you're a lot better than half-decent.</i>\"\n\n", false);
	flags[kFLAGS.HEL_TALKED_ABOUT_BERSERKING] = 1;
	helChatMenu();
}

//[Her]
private function askHelAboutHer():void {
	spriteSelect(68);
	clearOutput();
	outputText("You think for a moment, and then ask her about herself.\n\n", false);

	outputText("\"<i>Who, me?</i>\" she asks, seemingly surprised.  \"<i>What... is the wild, anonymous sex not good enough for you?  Besides, you haven't exactly introduced yourself yet, either.</i>\"\n\n", false);

	outputText("You laugh, and extend a hand to her. \"<i>The name's " + player.short + ".  Pleased to meet you.</i>\"\n\n", false);

	outputText("\"<i>I'm Helia.  Or Hel, if you'd like.  And the pleasure's mine, " + player.short + ",</i>\" she says, shaking your hand.\n\n", false);

	outputText("You tell her about your role as the Champion of your village, and how you came to this strange new world.  You keep things as short and concise as possible, but even then it's not quite a glib anecdote.  You bring your tale to a conclusion with your meeting her, here.  Smiling, your lover leans down and kisses you again, softly and gently.\n\n", false);

	outputText("You take a minute to recover, then ask her what her story is.\n\n", false);

	outputText("\"<i>Oh, nothing so grandiose as yours,</i>\" she laughs, nesting her cheek on your " + player.chestDesc() + ".  \"<i>I don't have a sob story; to be honest, the demons haven't affected me all that much.  My parents were hunters, right here on the plains.  Dad died before I was born – got himself torn up by some harpies on a mountain visit.  Mom raised me, taught me how to fight, how to survive out here.  There were others with us, back then.  A dozen or so salamanders.  Every one that died, I was taught, was one more reason to be hateful and angry, to go flying madly into battle and make the enemy suffer – and love every blow, every victory, and even love the defeats.  But it's hard living out here.  The gnolls picked us off one by one when the demons didn't, and monsters came from all over looking for food and treasure on the plains.</i>\"\n\n", false);

	outputText("\"<i>Eventually I was the only one left.  I was pissed off and mad about it, but there it was.  That was maybe a year ago, when the last of my tribe was carted off as a captive by the gnolls.  So I've just been surviving since then.  Killing, stealing, raping.  Then you came along.  First person I've ever met out here who can give as good as they get.</i>\"\n\n", false);

	outputText("She gives you another kiss, and falls silent.", false);
	flags[kFLAGS.HEL_TALKED_ABOUT_HER] = 1;
	//[I'm Bugging Out] changes to [Leave]
	helChatMenu();
}

//[Attacking You]
private function askHelAboutAttackingYou():void {
	spriteSelect(68);
	outputText("",true);
	flags[kFLAGS.HEL_FUCKBUDDY] = 0;
	outputText("Now that you've got the feisty salamander calm for once, you ask her why she's always attacking you.\n\n", false);

	outputText("\"<i>Hey, I don't mean anything by it.  It's just... I can't control myself sometimes.  I've spent so long killing and raping everything out here, that I guess I just don't know how else to operate.  You know I'd never really hurt you, right?  Oh, I tease and play, but you're special.  You're a good " + player.mf("guy","girl") + ".  One of the best, I think.</i>\"\n\n", false);

	outputText("You suppose you could ask her to stop attacking you anyway, though.  One less threat out here couldn't hurt, and maybe – just maybe – you could skip the formalities when you meet and go straight to the really fun part.\n\n", false);
	flags[kFLAGS.HEL_TALKED_ABOUT_ATTACKING_YOU] = 1;
	//[Stop] [Say Nothing]
	simpleChoices("Stop",telHelSTOPATTACKINGMEYOUBITCH,"Say Nothing",helChatMenu,"",null,"",null,"",null);
}

//[Say Nothing]
private function helChatMenu():void {
	spriteSelect(68);
	outputText(images.showImage("helia-interview"));
	if (flags[kFLAGS.HEL_TALKED_ABOUT_HER] == 0)
		simpleChoices("About Her", askHelAboutHer, "", null, "", null, "", null, "Leave", bugOutAfterHelMinoThreesome);
	else {
		var zerk:Function = null;
		var attackin:Function = null;
		if (flags[kFLAGS.HEL_TALKED_ABOUT_ATTACKING_YOU] == 0) attackin = askHelAboutAttackingYou;
		if (flags[kFLAGS.HEL_TALKED_ABOUT_BERSERKING] == 0) zerk = berserkMode;
		choices("", null, "Berserking?", zerk, "Y Attack Me", attackin, "Seconds", askMommaHelForSecondsAfterDinner, "MinosRBad", telHelToGetOffTheMInoCock, "", null, "", null, "", null, "", null, "Leave", leaveHelAfterMinoThreeSomeChat);
	}
}

//[Stop]
private function telHelSTOPATTACKINGMEYOUBITCH():void {
	spriteSelect(68);
	clearOutput();
	outputText("Even knowing she doesn't want to really hurt you, you ask the salamander to stop attacking you anyway.\n\n", false);

	outputText("She sighs, but pushes her face into your neck and takes a deep, strong breath.  When she's satisfied, she leans back and says, \"<i>I've got your scent, now.  If I smell you ahead of time... I'll try not flip my shit on you.  But if you want me clear-headed, you damn well better be ready to try a different kind of sparring when we meet.  All right?</i>\"\n\n", false);

	outputText("You give her cheek a little pat and tell her that's all right.\n\n", false);

	//(unlocks \"<i>Fuckbuddy Greeting</i>\" scene when Hel's encountered, rather than the combat intro from above)
	flags[kFLAGS.HEL_FUCKBUDDY] = 1;
	//(Original options return)
	helChatMenu();
}



//[Seconds?]
private function askMommaHelForSecondsAfterDinner():void {
	spriteSelect(68);
	clearOutput();
	outputText("You reach down and grab the salamander's ample, muscular ass and, grinning, ask her if she's ready for more.\n\n", false);

	outputText("\"<i>Always, lover mine,</i>\" she laughs, giving you a little wink.", false);

	//(Normal sex options appear, scene concludes afterwards)
	if (player.lust < 40) {
		player.lust = 40;
		dynStats("lus", 1);
	}
	helFuckMenu();
}

//[Leave]
private function leaveHelAfterMinoThreeSomeChat():void {
	spriteSelect(68);
	clearOutput();
	outputText("Sadly, you know you have things to tend to, and so you give your salamander lover a quick peck goodbye as you get to your feet and clean off your " + player.armorName + ".  As you're getting ready to head back to camp, however, you feel her powerful arms wrap around your waist, locking you in place as her long, reptilian tongue snakes out to tease your ear.\n\n", false);

	outputText("\"<i>I'll see you soon, lover mine,</i>\" she whispers, planting a kiss on your neck.\n\n", false);

	outputText("You tell her to count on it, and make your way back to camp.", false);
	dynStats("lus", 2);
	doNext(camp.returnToCampUseOneHour);
}
//===================
//THREESOMES AHOY!
//===================

//Isabella x salamander Threesome – Plains Version Intro (edited)
//(Requirements:
//-Player has achieved Fuck Buddy status with the salamander.
//-Player has met Isabella and is [currently] on friendly terms with her
//-Isabella is NOT a follower
//-Play when exploring the Plains.
public function salamanderXIsabellaPlainsIntro():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-isabella-fight"));
	outputText("You make your way onto the vast expanse of Mareth's plainsland and soon find yourself submerged in the tall grass, wading through it like a sea of weeds.  After a few minutes of wandering, you hear what sounds like a surprised, throaty moo in the distance, followed shortly by the crack of steel on steel.  Knowing Isabella makes camp not far from here, you ready your " + player.weaponName + " and make best haste toward the cow-girl's camp.\n\n", false);

	outputText("You burst into Isabella's camp, " + player.weaponName + " raised high.  To your horror, the red-headed cow-girl is standing with her massive tower shield braced, eyeing down Hel the salamander.  The salamander stands with sword in hand, poised to strike!\n\n", false);

	outputText("\"<i>You're going DOWN, you udder-y bitch,</i>\" Hel snarls, making a quick feint with her sword.\n\n", false);

	outputText("Isabella makes a swift dodge – surprisingly nimble for her size – and stomps her hooves threateningly.  \"<i>I vill not let you steal mein milk, uncouth barbarian!</i>\"\n\n", false);

	outputText("\"<i>I don't want your milk, you stupid cow!</i>\" Hel snaps.  \"<i>I want my gods-damn bandanna back!</i>\"\n\n", false);

	outputText("Isabella huffs haughtily, making her massive mammaries quake under her thin blouse.  You look to Isabella's plump rump and sure enough, the cow-girl has tied a bright-blue bow upon her tail.  \"<i>It iz not yours anymore, naughty girl!  Isabella found it, fair und square.</i>\"\n\n", false);

	outputText("Before Isabella can say any more, the salamander leaps into the air and slams her sword down upon the cow-girl's narrowly-interposed shield.  The force of the blow staggers both of them, giving you a moment to intervene before there's bloodshed!", false);
	//(Display Options: [Diplomacy] [Watch] [Leave])
	simpleChoices("Diplomacy", salamanderXIsabellaDiplomacy, "Watch", watchIsabellaAndHelFight, "", null, "", null, "Leave", skipTownOnIsabellaAndHelsFight);
}

//Diplomacy (edited)
private function salamanderXIsabellaDiplomacy():void {
	spriteSelect(68);
	clearOutput();
	//(PC passes a moderate Strength check)
	if (player.str > 60) {
		outputText("The two warrior women recover before you expected and charge at each other, both howling with rage.  All you can do is leap between them and try to hold them apart.  You suffer the brunt of their attacks, but manage to hold them off for the moment until they come down off their combat high enough to recognize you.\n\n", false);

		outputText("\"<i>" + player.short + "!?</i>\" They both blurt at once, surprised by your intervention.", false);
	}
	//(PC fails the Strength check)
	else {
		outputText("The two warrior women recover before you expected and charge at each other, both howling with rage.  All you can do is leap between them and try to hold them apart.  Unfortunately, the two women attacking at once near-instantly overwhelms you; the force of their attacks knocks you to the ground and you find yourself immediately being trampled by hooves and clawed feet.  For a moment, your life flashes before you as Isabella and Hel kick the shit out of you, barely noting your presence as they go at it above you.\n\n", false);

		outputText("To your relief, after a few seconds you hear \"<i>" + player.short + "!</i>\" from both Isabella and Hel.  The two women momentarily stop their squabbling to help you; your head is soon resting upon Isabella's sizable cleavage while Hel ties a long length of plains grass over a cut in your sternum.\n\n", false);
	}
	player.takeDamage(10);
	statScreenRefresh();
	//(Diplomacy Continued)
	doNext(salamanderXIsabellaDiplomacy2);
}

private function salamanderXIsabellaDiplomacy2():void {
	spriteSelect(68);
	clearOutput();
	outputText("Now that you have the two redheads' attention, you insist on knowing what, exactly, is going on here.\n\n", false);

	outputText("Glaring at Isabella, Hel says, \"<i>This... cow... stole my bandanna a few months ago and won't give it back.</i>\"\n\n", false);

	outputText("Isabella makes an indignant huff and turns her nose up at the salamander.  \"<i>Do not listen to zis little liar, " + player.short + ".  I found it in ze hands of ze gnolls, and most certainly did not steal it.</i>\"\n\n", false);

	outputText("\"<i>Hey...  How does she know your name, " + player.short + "?</i>\" Hel asks, crossing her arms over her sizable chest and frowning at you.\n\n", false);

	outputText("The cow-girl's brow furrows.  \"<i>Ja!  I could ask much ze same question.</i>\"\n\n", false);

	outputText("You spend the next few minutes explaining how you met each of the women in turn, receiving suspicious nods from Hel and Isabella.  Once you've explained yourself to the pair of women attempting to intimidate you, you ", false);
	if (player.cor < 50) outputText("fall silent under their considering gazes.", false);
	else outputText("glower balefully at them, as if to challenge either to invite your opinion of their own sexual résumé with an ill-considered comment.", false);
	outputText("\n\n", false);

	outputText("\"<i>Zo,</i>\" Isabella finally says, shifting her gaze from you to the salamander.  \"<i>You two are... lovers, ja?  And here Isabella vas about to thrash you!</i>\"\n\n", false);

	outputText("\"<i>Yeah,</i>\" Hel answers with a little scoff, \"<i>And, I guess if you're " + player.short + "'s friend... you're probably all right.  Although I was winning, you impertinent bitch.</i>\"\n\n", false);

	outputText("A dopey smile spreads across your face as Hel offers Isabella her hand.  Warily, the cow-girl shakes it.  The girls increase the tempo of the handshake competitively until both their pairs of massive tits are jiggling.\n\n", false);

	outputText("\"<i>Oh... und here,</i>\" Isabella says, breaking the ", false);
	if (silly()) outputText("(milk)", false);
	else outputText("hand", false);
	outputText("shake to pull the blue bow from her tail and hand it over to Hel.  With a happy gasp, Hel grabs it and ties it around her forehead – making herself look like some kind of half-naked commando in the process – though it's quickly hidden under her long red hair.\n\n", false);

	outputText("\"<i>Yeah.  You're all right.</i>\" Hel says, finally sheathing her sword.  \"<i>Thanks for giving me my mom's bandana back.</i>\"\n\n", false);

	outputText("\"<i>You are... velcome,</i>\" Isabella says before bidding the two of you goodbye.  You soon follow suit, saying goodbye to the girls and making your way back to camp, proud to have fostered what could well be a friendship between the two.", false);
	//(Return PC to camp, advance time 1 hour)
	//(Increase Isabella's affection)
	isabellaFollowerScene.isabellaAffection(5);
	helFollower.helAffection(5);
	flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Watch (edited)
private function watchIsabellaAndHelFight():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-isabella-fight"));
	outputText("Deciding this isn't really any of your business, you bunker down to watch the two redheads beat the shit out of each other.\n\n", false);

	outputText("As the only 'armed' one, Hel takes the initiative, lunging forward with a rapid flurry of blows that Isabella only just manages to turn aside with her shield.  During the last of these attacks, however, the salamander leaves herself open to a bash that sends her flying across the clearing.  The cow-girl charges over before Hel can react and grabs her by the leg, trying to lift her up.  Before she can, however, Hel kicks up, crashing her foot into the underside of Isabella's massive cleavage.\n\n", false);

	outputText("The cow-girl lets out a pained \"<i>moooo</i>\" as Hel rolls to her feet and recovers her sword.  Isabella staggers back, clutching her teats as a bit of milk stains the front of her shirt, soaking it so that you have a clear view of her puffy quad-nipples.\n\n", false);

	outputText("\"<i>You beetch!</i>\" Isabella snaps, grinding the ground underneath her with her hooves.  \"<i>I vill make you pay for zat, naughty girl!</i>\"\n\n", false);

	outputText("\"<i>Bring it, cow!</i>\" Hel answers, and in the blink of an eye they clash, trading blow for blow and dodge for dodge.  When they're stuck in, it's almost like a beautiful, deadly ballet of swirling steel, whipping tails, and bouncing titflesh.  It's almost sensual, in a way, as the two redheads spin and jab at each other, skin running against skin in a narrow dodge, and sparks fly as Hel's sword crashes against Isabella's shield.\n\n", false);

	outputText("Suddenly, a spear slams into the ground just a few feet away from you, dead center between Hel and Isabella.  Another, and another, whiz through the air.  Before you can blink they sky is full of spears raining down, and you can hear gnolls laughing and cackling as they close in.  You escape, pumping your " + player.legs() + " as hard as you can, though Hel and Isabella are forced to both duck down behind the cow-girl's massive shield, both screaming in rage and fear as the gnolls' attack begins in earnest.\n\n", false);

	outputText("When the missile attack pauses, you can hear Hel yell \"<i>We'll finish this another time, cow!</i>\"\n\n", false);

	outputText("\"<i>Count on it, naughty girl!</i>\" Isabella shouts before the two of them break apart and disappear into the brush to elude the hunting party.", false);

	//(Return PC to camp, advance time 1 hour. 10% chance of Intro Scene playing whenever Isabella or Hel would normally be encountered until PC chooses Leave or Diplomacy in the future)
	doNext(camp.returnToCampUseOneHour);
}

//Leave (edited)
private function skipTownOnIsabellaAndHelsFight():void {
	spriteSelect(68);
	clearOutput();
	outputText("Well, you're sure as hell not going to get involved in this – better to let them duke it out between themselves rather than risk your relationship with either girl.  You head on back to camp, not terribly surprised to hear sharp moos, grunts, and cries for some time in the distance.\n\n", false);
	//(Return PC to camp, advance time 1 hour. Intro scene will not play again.)
	flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] = -1;
	doNext(camp.returnToCampUseOneHour);
}


//Isabella x salamander Threesome – Camp Version Intro (edited)
//(Play at ~02:00 AM, after Isabella arrives at camp. PC must have reached \"<i>Fuck Buddy</i>\" status with Hel)
public function followrIzzyxSallyThreesomePretext():void {
	spriteSelect(68);
	outputText("\n<b>Something odd happens during the night...</b>\n", false);
	outputText("You've only been asleep for a few hours when you hear a sudden and alarming THWACK just outside camp.  You jump to your feet and try to gather your equipment while trying to make sure everything and everyone in camp is present and accounted for.  It only takes you a moment to notice that Isabella is nowhere to be found!\n\n", false);
	
	outputText("You make your way out of the camp, hearing another and another thwack, getting louder as you approach.\n\n", false);

	outputText("You pick up the pace, and soon come to your camp's perimeter.  There, Isabella is standing stark naked save for her shield, facing down an opponent wreathed in darkness but for the long, curved blade he or she wields.\n\n", false);

	outputText("\"<i>" + player.short + "!</i>\" Isabella gasps, relieved to see you approach. \"<i>", false);
	if (isabellaAccent()) outputText("Good, now ve can take ze fight to zis uncouth barbarian!</i>\"\n\n", false);
	else outputText("Good, now we can take the fight to this uncouth barbarian!</i>\"\n\n", false);

	outputText("You raise your " + player.weaponName + " and prepare to fight the shadowy villain... only to see Hel the salamander step forward, staring at you with wide eyes.\n\n", false);

	outputText("\"<i>" + player.short + "!  What the fuck!?</i>\" Hel demands, looking from you to the redheaded cow-girl.\n\n", false);
	
	outputText("Taken off guard, you start to introduce Hel to your companion.  Scowling, Isabella says, ", false);
	if (isabellaAccent()) outputText("\"<i>I know ze little beech, " + player.short + ".</i>\"\n\n", false);
	else outputText("\"<i>I know the little bitch, " + player.short + ".</i>\"\n\n", false);

	outputText("Hel sneers, \"<i>Well, you damn well better, cow.  We've been at this for months.  Now, give me back my mother's bandanna or I am going to shove my clawed foot right up your fat ass!</i>\"\n\n", false);

	outputText("Isabella raises her shield and gives the ground a menacing kick with her hoof as Hel readies her sword for action.  Realizing this could quickly escalate into bloodshed, you quickly interpose yourself between the two redheads before they get the chance to beat the shit out of each other.\n\n", false);

	outputText("\"<i>" + player.short + "!</i>\" they both shout, frustrated at their inability to close the distance with their opponent without going through you.\n\n", false);

	outputText("Now that you have their undivided attention, you demand an explanation that's so sorely lacking.\n\n", false);

	outputText("Glaring at Isabella, Hel says, \"<i>This... cow... stole my bandanna a few months ago and won't give it back.</i>\"\n\n", false);

	outputText("Isabella makes an indignant huff and turns her nose up at the salamander. ", false);
	if (isabellaAccent()) outputText("\"<i>Do not listen to ze little liar, " + player.short + ".  I found it in ze hands of ze gnolls, and most certainly did not steal it.</i>\"\n\n", false);
	else outputText("\"<i>Do not listen to the little liar, " + player.short + ".  I found it in the hands of the gnolls, and most certainly did not steal it.</i>\"\n\n", false);

	outputText("\"<i>Yes you fucking well did!</i>\" Hel snaps, waving her sword around.  \"<i>" + player.short + ", why the hell are you protecting that fat cow, huh?  Lemme at her!</i>\"\n\n", false);

	outputText("You roll your eyes and explain that Isabella is your companion now, and that as much as you like Hel, you can't abide violence coming to your friends.  It takes a couple of minutes to penetrate the salamander's combat-high mind, but when it does, she slowly backs down and lowers her sword.  Cautiously, Isabella lowers her shield to match.\n\n", false);

	if (isabellaAccent()) outputText("\"<i>So,</i>\" Isabella finally says, shifting her gaze from you to the salamander. \"<i>You two are... lovers, ja?  And here I vas about to thrash you!</i>\"\n\n", false);
	else outputText("\"<i>So,</i>\" Isabella finally says, shifting her gaze from you to the salamander. \"<i>You two are... lovers, huh?  And here I was about to thrash you!</i>\"\n\n", false);

	outputText("\"<i>Yeah,</i>\" Hel answers with a little scoff, \"<i>And, I guess if you're " + player.short + "'s friend... you're probably all right.</i>\"\n\n", false);

	outputText("A dopey smile spreads across your face as Hel offers Isabella her hand.  Warily, the cow-girl shakes it.  Competitively, the girls increase the tempo of the handshake until both their pairs of massive tits are jiggling.\n\n", false);

	outputText("\"<i>Oh, here,</i>\" Isabella says, breaking the ", false);
	if (silly()) outputText("(milk)", false);
	else outputText("hand", false);
	outputText("shake to pull the blue bow from her tail and hand it over to Hel.  With a happy gasp, Hel grabs it and ties it around her forehead – making herself look like some kind of half-naked commando in the process – though it's quickly hidden under her long red hair.\n\n", false);

	outputText("\"<i>Yeah.  You're all right.</i>\" Hel says, finally sheathing her sword.  \"<i>Thanks for giving me my mom's bandana back.</i>\"\n\n", false);

	outputText("\"<i>You are... welcome,</i>\" Isabella says as Hel disappears into the night.  Heaving a relieved sigh, you return to the camp proper and try to get some shut-eye before the sun rises.", false);
	flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] = 1;
	doNext(playerMenu);
}

//Isabella x Hel Threesome Scene – Beginning in the Plains (edited)
public function isabellaXHelThreeSomePlainsStart():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-isabella-milkoffer"));
	outputText("While wandering the grasslands, the relative silence of the plains is suddenly broken by a high, throaty moo in the distance.  Momentarily afraid that Isabella and Hel are going to try and rip each other's throat out again, you start running toward the source of the ever-loudening 'moooOOOOOO'.\n\n", false);

	outputText("You burst out of the grass and into Isabella's camp, and are shocked to see Hel sitting on the cow-girl's lap, her hands on Isabella's hefty breasts and one of the her quad-nipples locked in her mouth.  Seeing you approach, Isabella lifts a hand from Hel's hip and gives you a somewhat-abashed wave.\n\n", false);

	outputText("\"<i>" + player.short + "... it is –moo– good to see youuuuu!</i>\"  She trails off into a long, ecstatic moan as Hel continues to suckle from her massive teat, acknowledging your presence only with a little waggle of her tail and a wink.  \"<i>Perhaps you vould like ein drink as vell, no?</i>\" Isabella offers, patting the chocolate-colored tit that Hel is not actively suckling from.\n\n", false);

	outputText("You certainly do feel thirsty, and Isabella's invitation is certainly... enticing, and is made all the more exciting by the busty salamander you'll be sharing a meal with.", false);
	//(Display Options: [Drink] [Leave])
	simpleChoices("Drink", nomOnIzzyTitWithSallyMancer, "", null, "", null, "", null, "Leave", leaveIsabellaSallyBehind);
}
//Isabella x Hel Threesome Scene – Beginning at Camp (edited)
//(Has a 10% chance to play when the player chooses [Sleep] while Isabella is at camp)
public function isabellaXHelThreeSomeCampStart():void {
	spriteSelect(68);
	outputText("\n<b>Something odd happens during the night...</b>\n", false);
	outputText("As you settle in to sleep for the night, you notice that Isabella's wandered off out of the camp.  Mildly concerned for the busty cow-girl's safety, you set out for the camp perimeter.  It doesn't take you long to find her, thanks to a soft, throaty mooing coming from the brush near camp.\n\n", false);

	outputText("You push the scrub aside, revealing the cow-girl sitting on the ground, running a hand through the hair of Hel the salamander, who's currently sitting on the cow-girl's lap, her hands on Isabella's hefty breasts and one of the quad-nipples locked in her mouth.  Seeing you approach, Isabella lifts her hand from Hel's head and gives you a somewhat-abashed wave.\n\n", false);

	outputText("\"<i>" + player.short + "... it is –moo– good to see youuuuu.</i>\"  She trails off into a long, ecstatic moan as Hel continues to suckle from her massive teat, acknowledging your presence only with a little waggle of her tail and a wink.  ", false);
	if (isabellaAccent()) outputText("\"<i>Perhaps you vould like a drink as vell, no?</i>\" Isabella offers, patting the chocolate-colored tit that Hel is not actively suckling from.\n\n", false);
	else outputText("\"<i>Perhaps you would like a drink as well, no?</i>\" Isabella offers, patting the chocolate-colored tit that Hel is not actively suckling from.\n\n", false);

	outputText("You certainly do feel thirsty, and Isabella's invitation is certainly... enticing, and is made all the more exciting by the busty salamander you'll be sharing a meal with.", false);
	//(Display Options: [Drink] [Leave])
	simpleChoices("Drink", nomOnIzzyTitWithSallyMancer, "", null, "", null, "", null, "Leave", playerMenu);
}

//[Leave]
private function leaveIsabellaSallyBehind():void {
	spriteSelect(68);
	clearOutput();
	outputText("You decline the cow-girl's offer, but tell the redheads to have fun without you.  Though a bit disappointed, they both wave as you make your way back to camp.", false);
	if (model.time.hours < 6) doNext(playerMenu);
	else doNext(camp.returnToCampUseOneHour);
}

//[Drink]
private function nomOnIzzyTitWithSallyMancer():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-isabella-drinkmilk"));
	outputText("Well, that's an offer you can't refuse.  The girls' faces both brighten visibly as you say that you could use a drink.  Hel scoots to the side, allowing you to nestle yourself into Isabella's lap beside her.  You're already salivating slightly by the time Isabella hands her teat off to you", false);
	if (player.hasCock()) outputText(", and your " + player.armorName + " is tenting visibly, displaying your excitement as you take her soft, delightfully warm and full breast in hand", false);
	else outputText(", and your nipples stiffen with excitement as you take her soft, delightfully warm and full breast in hand", false);
	outputText(".\n\n", false);

	outputText("Her areolae are massive, some three inches across, though they still seem small in comparison to her mounds.  Each of the four nipples she's presented to you is already starting to bead with little drops of milk, and you can't help but flick your tongue across them, lapping up the droplets and sending a shudder up the cow-girl's spine.  Before she has a chance to recover, you see out of the corner of your eye Hel slipping her tail up into Isabella's skirt, and the cow-girl lets out a sharp, high gasp.\n\n", false);

	outputText("You withhold comment, though, as she's grabbing the back of both your heads and smashing your faces into her milky teats, forcing you and Hel to drink or suffocate.  You open wide, taking the four nipples into your mouth all at once, and are immediately rewarded with a stream of creamy, delicious milk at the first suck.  You have to chug to keep up with the massive flow coming from her breasts, seeming to make no dent in her nigh-endless supply no matter how long you suckle from her.  What you do succeed in doing is causing Isabella to roll her head back and let out an ecstatic moan, smashing your face further into her leaking milk-jug. ", false);
	player.refillHunger(40);
	outputText("\n\nSuddenly, you're rocketing toward the ground!  Isabella lands on her back with a thud and a low moo, soon joined by you and Hel, who is still locked onto Isabella's teat with a ferocious determination.  Panting, the busty shield maiden gasps out, ", false);
	if (isabellaAccent()) outputText("\"<i>I vant you.  I need you.  Both of you.  Here and now.</i>\"\n\n", false);
	else outputText("\"<i>I want you.  I need you.  Both of you.  Here and now.</i>\"\n\n", false);

	outputText("That finally serves to get Hel off of Isabella's tit.  With a smirk that's still drooling breast milk, the salamander says, \"<i>Oooh, a three-way.  Now we're talking!  What do you say, lover?  Want to join in on a little girl-on-girl?</i>\"\n\n", false);
	dynStats("lus", 40);
	player.changeFatigue(-40);
	
	var dick:Function = null;
	var dick2:Number = 0;
	var dick4:Number = 0;
	var vag:Function = null;
	//(If PC is Herm::)
	if (player.hasCock() && player.hasVagina()) {
		outputText("You'll need to decide which of your sex organs to use on the hot redheads.\n\n", false);
		if (player.cockThatFits(85) >= 0) {
			dick = stuffIzzyAndSalamanderWithDicks;
		}
		else outputText("<b>You're too big to fuck them with your man-bits...</b>", false);
		vag = izzySallyThreeSomeVagoozlaz;
	}
	else if (player.hasVagina()) vag = izzySallyThreeSomeVagoozlaz;
	else if (player.hasCock()) {
		if (player.cockThatFits(85) >= 0) {
			dick = stuffIzzyAndSalamanderWithDicks;
		}
		else outputText("<b>You're too big to fuck them with your man-bits...</b>\n\n", false);
	}
	//(If PC is genderless: Unfortunately, you don't have much to contribute...)
	else outputText("Unfortunately, you don't have much to contribute...", false);
	//(Display Appropriate Options: [1 Dick] [2 Dicks] [4 Dicks] [Vagina] [Leave])
	simpleChoices("Dick", dick, "", null, "", null, "Vagina", vag, "Leave", noThreesomeSexWithSallyAndIssyLastMinute);
	//(Dick scenes have a common open, then branch out before a common end between all genders)
}

//LEAVE before sexing or Unsexed PC
private function noThreesomeSexWithSallyAndIssyLastMinute():void {
	spriteSelect(68);
	clearOutput();
	outputText("With a heavy heart, you tell the girls you'll have to pass.  Though they both look disappointed, Hel is quick to whisper huskily, \"<i>Don't you worry, you big ol' cow.  I'll take gooood care of you...</i>\"\n\n", false);

	outputText("With a chuckle, you head on back to camp with a full belly", false);
	if (player.balls > 0) outputText(" and balls bluer than the lake", false);
	outputText(".", false);
	if (model.time.hours < 6) doNext(playerMenu);
	else doNext(camp.returnToCampUseOneHour);
}

//DICK (edited)
private function stuffIzzyAndSalamanderWithDicks():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-isabella-threesome-dick"));
	//Hels pussy
	var x:Number = -1;
	//Iz pussy
	var y:Number = -1;
	//Hels Ass
	var z:Number = -1;
	//Iz Ass
	var zz:Number = -1;
	temp = player.cocks.length;
	while(temp > 0) {
		temp--;
		if (player.cockArea(temp) <= 85) {
			if (x == -1) x = temp;
			else if (y == -1) y = temp;
			else if (z == -1) z = temp;
			else if (zz == -1) {
				zz = temp;
				break;
			}
		}
	}
	outputText("You stand up and start stripping out of your " + player.armorName + ".  " + player.SMultiCockDesc() + " pops free as soon as your crotch is clear, already at full hardness thanks to the sight of Hel crawling atop Isabella, pressing her E-cups into the cow's milky teats and giving her a full kiss on the lips.  You stay back for a moment, watching the kiss, able to catch just a glimpse of Isabella's massive flat tongue entwining with Hel's long, slender one.\n\n", false);

	outputText("The two girls' massive tits are pressed tightly together, creating a barrier between them that forces Hel to keep her back arched.  Giving a brief look over her shoulder at you, she wiggles her flared hips seductively and raises her fiery tail, giving you a clear view of her sopping-wet snatch and the tight ring of her ass between her full cheeks.\n\n", false);

	outputText("That's all the invitation you need.  You drop to your knees behind the two redheads and thrust your " + player.cockDescript(x) + " into Hel's snatch, eliciting a sharp moan from the salamander.  ", false);
	//(IF MULTICOCK and second cock is under 9 inches: 
	if (y >= 0) outputText("Meanwhile, your " + player.cockDescript(y) + " slides easily into Isabella's pussy, making the cow-girl gasp at the sudden and unexpected penetration.  ", false);
	outputText("You grab Hel's hips and push in, reveling in the incredible heat and tightness of her pussy as your " + player.cockDescript(x) + " slides into her until you've bottomed out", false);
	if (y >= 0) outputText(" with your " + player.cockDescript(y) + " similarly coming to a rest inside Isabella's depths; you're able to feel the cow's rapid heartbeat hammering through her, causing her already tight cunt to contract rhythmically around your girth", false);
	outputText(".\n\n", false);

	outputText("Now bottomed out deep inside ", false);
	if (y == -1) outputText("her", false);
	else outputText("them", false);
	outputText(", you begin to rock your hips ever so slightly as you watch the girls play with each other, descending from kissing to heavy petting, grabbing and sucking at each other's tits and running their hands sensually across each other's bodies.  Spurred on by a glance from the salamander, however, you start to pound your hips into her ass, fucking ", false);
	if (y == -1) outputText("her", false);
	else outputText("them", false);
	outputText(" with quick, short strokes that keep ", false);
	if (y == -1) outputText("her", false);
	else outputText("them", false);
	outputText(" filled with as much of your cockmeat as possible.\n\n", false);
	
	//(Player has one cock)
	if (y == -1) {
		outputText("Feeling bad for the thus-far-neglected needs of Isabella, you pull out of Hel with a wet squelch and slap your cock against the cow-girl's pussy. She gasps, looking over the salamander's shoulder at the large member pressing against her slit.\n\n", false);
		//(if PC cock > 9 inches: 
		if (player.cocks[x].cockLength > 9) {
			if (isabellaAccent()) outputText("\"<i>I normally do not play vith such... large... zings, but for you, I vill make an exception.  Give me your cock!</i>\"\n\n", false);
			else outputText("\"<i>I normally don't play with such... clumsy... things, but for you, I'll make an exception.  Give me your cock!</i>\"\n\n", false);
		}
		outputText("Still grasping Hel's hips, you slide into Isabella.  She's tighter than you expected, and you have to fight to push your " + player.cockDescript(x) + " into her despite how wet she is.  When you're half-way buried inside her, you begin to pull out, making her moan as Hel adds a good tit-sucking to the experience.  You slam home again, this time ramming your cock up to the hilt inside her.  Isabella lets out a near-orgasmic MOOOOOO as you start to fuck her in earnest, using Hel's hips for leverage as you pound the cow-girl's box with your " + player.cockDescript(x) + ".\n\n", false);

		outputText("You keep this up for perhaps two minutes before pulling out of the cow-girl and slamming yourself back into the salamander's hot cunny.  Without warning of the coming blow, Hel gasps, spurting a bit of milk all across Isabella's already sweat-soaked chest.  Now freed from the sucking and fucking combination, Isabella squirms underneath Hel, somehow managing to put the pair of them in a 69 position while you continue to fuck the salamander.  Now in the more equitable position, you see Hel's head bob down between Isabella's luscious thighs, and watch the cow-girl's tongue reach out and give Hel a long, wet lick before making its way up the underside of your " + player.cockDescript(x) + ". You shudder at the alien sensation of Isabella's tongue running along your dick, causing you to skip a stroke in fucking Hel.  Giving the cow-girl an encouraging nod, however, you resume in earnest, pounding her as fast and hard as you can.\n\n", false);

		outputText("The few minutes you spend like this seem like an eternity of bliss, but soon both your sweeties are getting antsy.  You withdraw from Hel and give them a chance to switch around, putting Isabella's tight cow cunt under your cock and Hel's face above it.  The salamander gives your shaft an appreciative kiss, grinning as she tastes her own juices still clinging to it, before letting her long tongue reach out and flick across Isabella's little clit.  That leaves the slit open to you, and you waste no time sliding in.  It's easier going this time, and you soon are buried far enough that your crotch is pressed against Hel's nose, making both girls squirm. Taken by a sudden fancy, you lift the cow-girl's furry legs up and rest them against your chest, her hooves wagging over your shoulders and giving you a better angle on her.  You start to thrust against her once more, taking it slower than before, fucking her more gently but more firmly.\n\n", false);

		outputText("The combination of fucking the cow-girl's tight pussy and the occasional long, sensuous lick from Hel serve to drive you closer and closer to orgasm, something that you can feel reciprocated in Isabella's quickening breath and the contractions around your shaft.  Even Hel, given over to the truly incredible oral ministrations of the cow-girl, is gasping and panting with building pleasure.\n\n", false);

		outputText("But you aren't happy just cumming here.  You try your best to hold on to your orgasm as Hel and Isabella lick each other into climax, both of the busty redheads screaming their pleasure as they cum.  Isabella clamps down hard upon your cock, trying to milk it for all she's worth – but you refuse to finish just yet, instead yanking yourself out of her fem-cum soaked box and quickly shouting for the girls to get on their knees.\n\n", false);

		outputText("Though still recovering from their own orgasms, they shakily comply.  With a few quick directions, you have them basically hugging each other, Isabella's massive, milky tits pressed firmly against Hel's own soft E-cups.  You lean down and thrust up, pushing your cock up between the two pairs of breasts.  The girls gasp, amused and excited as you begin your own double tit-fuck, slamming your hips into their breasts hard enough to give them boobquakes as you fuck their tits.\n\n", false);

		outputText("Suddenly grinning at each other, Hel and Isabella both thrust their tongues out at once.  Isabella's massive flat one wraps neatly around the girth of your dick as Hel's lithe-but-long one slips up and down your urethra, tongue-fucking you in return.  That does it in seconds, causing you to scream out in ecstasy and buck your hips wildly.  Your cockhead explodes upon the girls, the first glob smacking Isabella right in the face, and the second smearing into Hel's neck and chin; the rest geysers into the air before landing upon their tits, making them both a sloppy, cum-soaked mess before you're through.", false);
		
		//(Go to Scene End)
	}
	//(Player has 2-3 cocks)
	else if (z == -1 || zz == -1) {
		outputText("Now fucking both girls at once with your super-human twin endowments, you settle into a good solid rut.  The girls squeal and moan under your intense fucking, only stopping in their sweetly feminine vocalizations to kiss or suckle each other.  Just as you've hit your rhythm, though, you're suddenly pushed to the ground as both Isabella and Hel give you a playful kick with their hoofed-or-scaled feet.  They switch positions so that Isabella is fore-most and facing you atop your " + player.cockDescript(x) + " while Hel sits behind her, impaled on your " + player.cockDescript(y), false);
		if (z > -1) outputText(" with your " + player.cockDescript(z) + " even now spearing her tight ass", false);
		outputText(".\n\n", false);

		outputText("Grinning over Isabella's shoulder, Hel grabs the cow-girl's milky udders and takes one of her quad-nipples between her thumbs and forefingers.  \"<i>Isabella, I think our dear " + player.short + " is getting pretty sweaty...</i>\"\n\n", false);

		if (isabellaAccent()) outputText("\"<i>Oh, ja!</i>\" Isabella says, now grinning too.  You're starting to worry, but between the two large women pinning you down and the intense pleasure of having all your cocks ridden at once, you're virtually helpless against whatever's coming.  \"<i>Oh, ja,</i>\" Isabella repeats, \"<i>And I think our Champion needs a bath!</i>\"\n\n", false);
		else outputText("\"<i>Oh, yes!</i>\" Isabella says, now grinning too.  You're starting to worry, but between the two large women pinning you down and the intense pleasure of having all your cocks ridden at once, you're virtually helpless against whatever's coming.  \"<i>Oh, yes,</i>\" Isabella repeats, \"<i>And I think our Champion needs a bath!</i>\"\n\n", false);

		outputText("Before you can even say a word, Hel pinches down on Isabella's puffy nipples, and you're instantly washed by a waterfall of thick, creamy milk pouring from the cow-girls teats, flowing onto you seemingly without end.  You gasp and cough, and soon have your mouth full of breast milk as Hel aims Isabella's milk streams toward your face.  You can't help but laugh under the milk bath, trying desperately to lap up the tremendous quantity of milk flowing onto you.\n\n", false);

		outputText("Meanwhile, your cocks are still being ridden hard by the redheads.  Both of them are thrusting their hips forward in time with the other, keeping up a steady but intense rhythm on ", false);
		if (z == -1) outputText("both", false);
		else outputText("all three", false);
		outputText(" of your cocks in use.  Surprisingly, though, they're the ones who cum first – Isabella lets out a sharp MOOOOO as she contracts down hard upon your " + player.cockDescript(x) + ", overwhelmed by the double sensation, and Hel soon follows suit, increasing her tempo wildly as she brings herself to orgasm.\n\n", false);

		outputText("Their now disparate and intensifying speeds bring you over the edge, and hard.  You throw your head back and cum, shooting out thick ropes of cum into both of their wombs", false);
		if (z > -1) outputText(" and Hel's ass", false);
		outputText(".  You buck your hips into them, forcing your cocks as deep as they'll go as you unleash a second spurt, and a third, until your jism begins to sputter out of the girls' holes, coating their thighs and your hips and legs with your spunk.", false);
		//(Play Scene End)
	}
	//(Player has 4 cocks or more)
	else {
		outputText("Though you're already fucking the girls pretty good, this isn't nearly enough for you.  You lean back until your first two cocks pop out of them and start to realign yourself.  Wide-eyed, both girls watch as you bring four cocks to bear against them.\n\n", false);

		outputText("\"<i>Holy shit, what are you--</i>\"  \"<i>MOOOOO!</i>\"\n\n", false);

		outputText("You ram all four cocks into them, sinking your " + player.cockDescript(x) + " into Hel's ass, your " + player.cockDescript(y) + " into her vag, your " + player.cockDescript(z) + " into Isabella's, and your " + player.cockDescript(zz) + " into her tight asshole.\n\n", false);

		outputText("Both girls scream and moan as you shove your cocks into their holes until your hips are pressed snugly against Hel's spread ass cheeks.  You grab her flared hips and start to slowly rock back, then slam forward again, making them both scream in ecstasy.  Laughing maniacally, you start to pound away at the poor girls, slamming your pricks into them so fast that their tongues are soon lolling out of their agape mouths, eyes rolled up into their heads – almost insensate as you fuck their four holes at once.\n\n", false);

		outputText("Unfortunately, fucking with four cocks at once soon drives you over the edge.  Screaming so loud the ground seems to shake, you unload into them, filling their cunts and asses so full of cum it begins to leak out around your pricks.  Utterly satisfied, you collapse onto your back, panting heavily.", false);
	}
	player.orgasm();
	dynStats("sen", -3);
	//(Scene End)
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	doNext(izzySallyThreeSomeFollowup);
}

private function izzySallyThreeSomeFollowup():void {
	spriteSelect(68);
	clearOutput();
	outputText("Now a sweat-and-cum soaked mess, the girls collapse onto their backs around you.  Sighing contentedly, Isabella rolls over and nuzzles her head on your chest; a moment later sees Hel doing the same, wrapping her warm tail around your " + player.cockDescript(0) + " lovingly.\n\n", false);

	outputText("\"<i>That was amazing.  Seriously,</i>\" the salamander says, still panting from the experience.  \"<i>I mean, holy shit you two.  We... we really need to do this more often.</i>\"\n\n", false);

	if (isabellaAccent()) outputText("\"<i>Mmm, ja,</i>\" Isabella says with a long yawn.  \"<i>Ve must indeed.  But for now, ve must rest.</i>\"\n\n", false);
	else outputText("\"<i>Mmm, yes,</i>\" Isabella says with a long yawn.  \"<i>We must indeed.  But for now, we must rest.</i>\"\n\n", false);

	outputText("\"<i>Yeah.  Resting is... resting is good,</i>\" Hel says, trying and failing to suppress a yawn of her own.  Smiling, you wrap your arms around your two beautiful, busty redheads and let sleep overcome you.", false);
	//(Either return PC to camp or advance to the next day, if in plains or camp, respectively)
	if (model.time.hours < 6) doNext(playerMenu);
	else doNext(camp.returnToCampUseFourHours);
}
//VAGINA (edited)
private function izzySallyThreeSomeVagoozlaz():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-isabella-threesome-vagoo"));
	outputText("You quickly strip out of your " + player.armorName + ", already wet at the sight of the two busty redheads embracing and fondling each other as they await you.  When you're finally rid of interfering fabrics, you drop to your knees and insert yourself between the girls.  With a few carefully considered directions, you get the three of you into something of a triangle shape, with your head nestled between Hel's thighs and Isabella's tongue caressing your " + player.vaginaDescript() + ".\n\n", false);

	outputText("You shudder as the cow-girl's inhumanly wide tongue drags across your sopping box, giving you an experimental lick.  Across from you, you can see Hel slipping a pair of fingers into Isabella's pussy, eliciting a gasping moo from her.  As Isabella gives you another long, slow lick, you decide to get to work on the salamander's snatch.  You spread her thighs and push her tail back, revealing the gaping slit of her carnal canal.\n\n", false);

	outputText("You bury your face into her crotch and slip your tongue inside her, wincing at the intense heat of the fiery salamander's inner walls.  You slide your tongue into her, flicking it across her hot, velvety tunnel in as close to synchronous with Isabella's own ministrations as you can.  You set yourself into a rhythm, flicking and slurping at Hel's fuck-hole twice for every gasp and pleasure-shudder Isabella drags out of you with her massive cow-tongue.\n\n", false);

	//(IF HERM)
	if (player.hasCock()) outputText("As you continue to lick Hel out, you feel a sudden crawling sensation across your belly. Looking down with alarm, you see her armored tail snaking its way across you.  It wraps around " + player.oMultiCockDesc() + ", coiling tightly, though it refuses to move.  Groaning, you try to buck your hips into her coiled tail, but Isabella's grasp on your " + player.hipDescript() + " prevents you from moving more than an inch.  Frustrated, you try to pleasure your tightly-bound cock somehow, but cannot even get your hands around it.  Giving up, you return to licking Hel's cunny, and are immediately rewarded by a hard jerk of your cock.  Now you get it!  You start licking the salamander out with redoubled effort, with a stroke for every lick.\n\n", false);

	outputText("Meanwhile, Isabella has utterly buried herself in your groin.  You knew her tongue granted her immense oral abilities by virtue of its size and shape, but her skill in wielding it is driving you wild.  She's going slowly, but that's only making each long, luscious stroke of her cow-tongue even better, tantalizing you between licks.  Mercifully, she slides a pair of her fingers into your " + player.vaginaDescript() + ", working them into your-now-sopping-wet box between tongue-thrusts.\n\n", false);

	outputText("The combination of the cow-girl's finger-and-tongue fuck", false);
	//(IF HERM: 
	if (player.hasCock()) outputText(" and Hel jerking your " + player.cockDescript(0) + " off", false);
	outputText(" is driving you quickly toward your limit.  You start to tongue-fuck the salamander as hard and fast as you can, sliding as many fingers into her hungry cunt as possible, and even plugging your thumb into her tight little asshole, anything to bring her to orgasm at the same time you cum.\n\n", false);

	outputText("It works like a charm: with a sharp cry, Hel clamps down on your invading fingers and tongue, her vaginal muscles spasming and contracting as the beginnings of orgasm hit her.  You can hear Isabella begin to moo ecstatically behind you, sending immensely-pleasurable vibrations up through your " + player.vaginaDescript() + ".  You let yourself go, sinking into orgasmic bliss as the cow", false);
	if (player.hasCock()) outputText(" and salamander double-team", false);
	outputText(" works to send you over the edge.  You scream into Hel's cunt as you cum, setting off the peak of her own orgasm, and Isabella shrieks in ecstasy as Hel fists her cow-cunt until she, too, cums hard.  You recoil as Hel's femcum squirts onto your face, covering you with her juices, and you're treated to the sight of much the same happening to her and to Isabella as your " + player.vaginaDescript() + " releases its pent-up femspunk, splattering the cow-girl.\n\n", false);

	outputText("Now a sweat-and-cum-soaked mess, the girls collapse onto their backs around you.  Sighing contentedly, Isabella rolls over and nuzzles her head on your chest; a moment later and Hel does the same", false);
	if (player.hasCock()) outputText(", wrapping her warm tail around your " + player.cockDescript(0) + " lovingly", false);
	outputText(".\n\n", false);

	outputText("\"<i>That was amazing.  Seriously,</i>\" the salamander says, still panting from the experience.  \"<i>I mean, holy shit, you two.  We... we really need to do this more often.</i>\"\n\n", false);

	if (isabellaAccent()) outputText("\"<i>Mmm, ja,</i>\" Isabella says with a long yawn.  \"<i>Ve must indeed.  But for now, ve must rest.</i>\"\n\n", false);
	else outputText("\"<i>Mmm, yes,</i>\" Isabella says with a long yawn.  \"<i>We must indeed.  But for now, we must rest.</i>\"\n\n", false);

	outputText("\"<i>Yeah.  Resting is... resting is good,</i>\" Hel says, trying and failing to suppress a yawn of her own.  Smiling, you wrap your arms around your two beautiful, busty redheads and let sleep overcome you.", false);
	//(Either return PC to camp or advance to the next day, if in plains or camp, respectively)
	player.orgasm();
	dynStats("sen", -3);
	//Bump up follower tracking affection too
	isabellaFollowerScene.isabellaAffection(4);
	helFollower.helAffection(5);
	if (model.time.hours < 6) doNext(playerMenu);
	else doNext(camp.returnToCampUseFourHours);
}
//Fox Girls -- First Time Intro
public function heliaPlusFoxyFluffs():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-fox-foursome-intro"));
	if (flags[kFLAGS.HEL_FOXY_FOURSOME_WARNED] == 0) {
		flags[kFLAGS.HEL_FOXY_FOURSOME_WARNED] = 1;
		outputText("You give Hel a wink and ask her to introduce you to her foxy friends.  She lets out a sharp whistle and waves the girls back.  Giggling girlishly, the two fox-girls saunter back with full tankards and lusty smiles.  Hel scoots back, letting one swing drunkenly onto her lap as the other crawls onto you, her hefty breasts pressing against your chest and... hey, wait a goddamn minute!  You look down at the modest, yet rock-hard prick pushing against your belly, its little knot already slightly inflated.  Looks like these herm twins are already ready for action.\n\n", false);
	
		outputText("Hel grins as you notice the sisters' extra hardware.  \"<i>Miko, Mai, meet " + player.short + ",</i>\" she says, running one of her scaled hands along... Miko's?... thighs, eliciting a sensual moan from the fox-girl.  In response, Mai buries her face in your neck, her full lips brushing along your sensitive flesh.  Your skin tingles with delight at her light caresses as her rigid prick presses further into your stomach, leaving a little wet stain on your " + player.armorName + ".\n\n", false);
	
		outputText("\"<i>Mmm, wanna play with Sister and I?</i>\" Mai purrs, nuzzling your neck after a long swig of beer.  Hel and Miko both give you hopeful, expectant looks.  Do you?\n\n", false);
		//(Display Options: [Foursome] [Leave])
		simpleChoices("Foursome", heliasFoxyFourSomeFluffs, "", null, "", null, "", null, "Leave", runAwayFromFoxGirls);
	}
	//(Leave because cocks are a new reveal; should give those grossed out by futa an escape; doesn't appear afterwards to save horny gamers a click)
	//Fox Girls -- Repeat Intro
	else {
		outputText("You give a sharp whistle and wave Miko and Mai back over from the bar.  Grinning, the two fox-herms slide back into the booth with you and Hel.  Mai crawls seductively into your lap, giving you a kiss that smells of alcohol and freely letting her little fox-pecker press into your belly.\n\n", false);

		outputText("Amused, Hel gives Miko's bountiful bosom a playful grope and says, \"<i>My, my, " + player.short + ", looking for a little foxy foursome?  Well, I think that can be arranged, what do you say, girls?</i>\"", false);
		//(NEXT button, to Foursome)
		doNext(heliasFoxyFourSomeFluffs);
	}
}

//Fox Girls -- Leave (Only Available First Time)
private function runAwayFromFoxGirls():void {
	spriteSelect(68);
	clearOutput();
	outputText("You graciously excuse yourself, saying that you forgot something back at camp.  All three girls say \"<i>Awwww</i>\" in unison, but don't make any special effort to keep you from going.  As you head out, you look over your shoulder in time to see Hel give you a little wink as the fox-herms clamber into her lap.  At least someone's getting laid today.\n\n", false);
	doNext(telAdre.barTelAdre);
}

//Foursome Scene Intro (First & Repeat)
private function heliasFoxyFourSomeFluffs():void {
	clearOutput();
	spriteSelect(68);
	outputText("You slip a hand into Mai's loose-fitting tunic, giving her soft D-cups a little squeeze as Hel grabs a room key from the bartender.  You gather up the sexy fox-herms, taking each arm-in-arm, and follow Hel upstairs to the private rooms, getting a unique view of the salamander's barely-clad ass giving a little jiggle with each step.\n\n", false);

	outputText("The four of you slide into your room for the evening, a small affair with a large, plush bed.  The fox-twins waste no time in undressing, revealing their large D-cups, 8-inch red cocks, and glistening loose cunts.  Hel tosses her scale bikini aside, letting her hefty E-cups bounce free, and puts an arm around the twins' lithe, tan shoulders so all three nude bodies are on display together for you.\n\n", false);
	
	//[If Herm]
	if (player.gender == 3) {
		outputText("\"<i>So what parts do you want to use?</i>\" she asks, looking to your mixed endowments.", false);
		//(Display Options: [As Male] [As Female])
		simpleChoices("As Male", foxyFluffsFoursomeAsMale, "As Female", foxyFluffGirlsFuckSex, "", null, "", null, "", null);
	}
	else if (player.gender == 2) doNext(foxyFluffGirlsFuckSex);
	else doNext(foxyFluffsFoursomeAsMale);
}

//Foursome Scene -- As Male
internal function foxyFluffsFoursomeAsMale():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-fox-foursome-male"));
	var x:Number = player.cockThatFits(85);
	if (x < 0) x = player.smallestCockIndex();
	outputText("You strip out of your " + player.armorName + " and grab your " + player.cockDescript(x) + ".  Giggling drunkenly, Miko flops onto her back on the bed and begins to stroke her knotty cock as Helia and Mai get on their knees, Hel burying herself between Miko's spread legs as her sister wraps her soft hands around your " + player.cockDescript(x) + " and guides it into her mouth.  You run your hands through Mai's silver hair as she sucks you off, jerking off the base of your cock and flicking her wet tongue across the head and shaft, her full lips wrapped around your girth in a cute little \"<i>O.</i>\" She carries on for another minute, letting you guide the speed and force of her blowjob with your hands planted on her head.\n\n", false);

	outputText("Now rock-hard and sopping wet, you give Mai a playful push back and tell her to tend to her twin.  With a lewd smile stained with your pre, she switches places with Hel, standing between her sister's spread legs and lining her own doggy cock up with Miko's wet and ready snatch.  Mai presses in, sliding herself up to the knot in her sister; you grin at the looks of rapturous pleasure that quickly spread across the twins' faces as Mai begins to fuck her sister slowly and gently, going easy until you and Hel can get into position.\n\n", false);

	outputText("You move behind Mai, dropping your " + player.cockDescript(x) + " between her soft, full butt cheeks, letting the motion of her incestuous fucking hotdog your shaft.  You wrap your hands around her hips and slide into her, moaning as her silken walls squeeze down on your intruding shaft.  Mai goes languid in your arms, and you quickly take it upon yourself to buck your hips forward, shoving your cock into her and pushing hers into her sister.  You assume control of the pace, moving Mai's hips in concert with your own.  As you push Mai's knot fully into Miko's now gaping cunt, you see a little squirt of pre dribble out of the bottom fox-girl's unused prick.\n\n", false);

	outputText("Seeing her opportunity, Helia crawls into the bed and impales herself on Miko's rigid doggy cock, riding the fox-girl reverse-cowgirl style so that her soft tits are mashed against Mai's smaller bosom.  Wrapping her arms around Mai's shoulders, Hel begins to bounce on Miko's cock, taking the knot in and out of herself with each motion, stretching her cunt wide open.\n\n", false);

	outputText("You lean over Mai's shoulder and give Hel a long, passionate kiss, your tongues entwining as your thrusts and Hel's bouncing come into sync.  Now both penetrated and penetrating, the fox-girls have gone almost limp with overwhelming pleasure, only able to passively submit to you and Helia, trusting you to bring them to orgasm before their minds go utterly numb.\n\n", false);

	outputText("You break the kiss and start to increase your pace.  You begin to ram your cock into Mai's eager pussy, fucking her harder and harder as Hel bounces faster, now unable to get Miko's inflated knot out of her.  So too is Mai's great big knot locked into her sister, keeping her from pulling far out at all.  You begin to draw your hips further from Mai's with each thrust, hitting her with more of your " + player.cockDescript(x) + " with each broad thrust, slamming your crotch into her ass and further knotting her in her twin until both their tongues have rolled from their mouths.\n\n", false); 

	outputText("The twins cum as one, both letting out a wail of pleasure as their knots expand dramatically for an instant.  Foxcream sprays everywhere, filling Hel and Miko's wombs before spurting back out of their cunts and coating the sisters with their own spunk.  With the sudden knotting inside her, Hel throws her head back and screams, riding out her own orgasm.  You manage a few last, desperate thrusts into Mai's spasming channel before you, too, blow your load, dumping thick, hot ropes of jizz into the fox-girl's waiting womb.\n\n", false);

	outputText("You can only shudder and gasp as pleasure overtakes you.  You bury your face into Mai's neck, biting her as the last of your cum explodes deep inside her.  Mai bucks her hips back at you and squeezes your cock, milking you of every last drop until your shaft is utterly spent.  Moaning, you withdraw from inside her, dragging a waterfall of hot white cum out of her as you do so.", false);
	player.orgasm();
	dynStats("sen", -1);
	doNext(foxyFluffOutro);
}
//Foursome Scene -- As Female
internal function foxyFluffGirlsFuckSex():void {
	spriteSelect(68);
	clearOutput();
	outputText(images.showImage("helia-fox-foursome-female"));
	outputText("You strip out of your " + player.armorName + " and playfully push the fox-girls onto the bed and with Hel's help, spread their legs to reveal their rigid cocks.  Nestling yourself between Mai's thighs, you take her cock into your mouth up until the knot parts your lips.  She tastes of musk and sweat and salty pre, sending an electric chill up your spine as the first tasty drops of seed touch your tongue.\n\n", false);

	outputText("You and Hel both fellate the hermaphroditic twins, amused to see the girls holding hands and rolling their heads back at your oral ministrations.  You spend perhaps a minute suckling and licking their doggy cocks, getting them nice and ready for the coming attractions.\n\n", false);

	//[IF NippleCunts:]
	if (player.hasFuckableNipples()) {
		outputText("Now that the girls are nice and wet, you pull them as close together as you can and bring your glistening, moist nipplecunts to bear.  You slip a pair of fingers into each of your " + player.chestDesc() + "'s waiting holes, beckoning the girls to penetrate you.  Though somewhat startled by your alien anatomy, a few encouraging words are enough to get the sisters off their feet and grabbing your shoulders for support.\n\n", false); 

		outputText("They thrust in easily, sliding their twin doggy cocks into your tits until their knots press against your lips.  You shudder at the penetration, feeling the inhuman sensation of the two shafts sliding into your " + player.chestDesc() + ".  As they start to fuck your tits, you feel Hel kneel down behind you, wrapping her scaled arms around your waist and slipping her tail between your legs.  You only have a second to brace for the coming attack before her tail slithers into your " + player.vaginaDescript() + ", forcing its way into your love tunnel until you can feel her sharp tip writhing and prodding against your womb.\n\n", false);

		outputText("You let the girls fuck you raw together, the twins slamming into your tits until they threaten to knot as Hel fucks your pussy with her great big tail.  You nearly cum, but seeing this, all three withdraw from you at once.  You're not done yet!\n\n", false);
	}//[End Nipplecunt]
	
	outputText("The twins pick you and Hel up and toss you onto the bed, falling side by side on your backs.  The twins loom over you, with Mai stroking her knotty cock as it nears your waiting " + player.vaginaDescript() + ".  Seeing Miko flop her cock down on Hel's waiting cunt, you take the salamander by the hand and grit your teeth in anticipation.\n\n", false);

	outputText("Grasping your " + player.hipDescript() + ", Mai slides her doggy cock into you in one slow, languid motion, pushing in until her thick, swollen knot presses against your lips.  You moan as her shaft gently strokes your walls, dribbling enough pre to get you nice and lubricated as she goes.  With her knot against your lips, Mai gives a few quick, forceful strokes into you before withdrawing to the tip, leaving only half an inch of her red cock inside you before slamming home, ramming her knot into you in one mighty thrust.", false);
	player.cuntChange(24,true,true,false);
	outputText("\n\n");

	outputText("You scream in pleasure as your cunt's lips are stretched wide, your tunnel having to expand greatly to accommodate the massive intruder.  Now knotted, Mai is restricted to short, hard thrusts into you, smashing her hips into your groin until your thighs are coated with her free-leaking fem-juice.  As Mai starts to roughly pound you, Hel lets go of your hand and flips Miko onto her back beside you, switching places with her lover and riding her cock.  The salamader lets out a loud yell of pleasure as she grabs the fox-girl's hefty tits and starts to bounce on her knotted cock.\n\n", false);

	outputText("Not wanting to be left behind, you grab Mai and throw her onto the bed, putting you on top with her knot buried all the way inside you.  You grab her soft, firm breasts for support as you start to grind your hips against hers, making the girl moan like a whore as you assault her thick prick.  Mai can only lean over and grab her sister's hand, much as you had taken Hel's.  The twins hold on to each other as you and Hel ride them raw, soon turning the fox-girls into a pair of panting, squirming animals that buck their hips wildly into you, slamming more doggy cock inside you than you ever thought possible.  Grinning at you, Hel slips her tail around your waist, hugging you tightly as the girls come ever closer to orgasm -- and so do you.\n\n", false); 

	outputText("Suddenly, Miko lets out a sharp cry and slams her hips into Hel's.  You can only see the looks on both her face and Hel's as they cum in unison, white fox-spunk dribbling out of the slamander's hot snatch.  \"<i>Gonna... Gonna cum...</i>\" Mai whimpers, giving you only a moment to prepare before she grabs your arms and pulls you down onto her chest, burying your face between her heavy tits.  She jackhammers your now-exposed cunt.  ramming her knot in and out of you until you can't think straight.  You cum, your " + player.vaginaDescript() + " clamping down on her doggy cock.  Waves of explosive pleasure shoot through you, making you spasm in the fox-herm's arms, only barely aware of her shooting her load deep inside you, coating your walls with thick, hot spunk.  You ride out the orgasm buried in Mai's chest, shuddering and gasping as she kisses you over and over, letting her thick knot deflate inside you until her own cum leaks out, staining her smooth thighs and legs.", false);
	player.orgasm();
	dynStats("sen", -1);
	doNext(foxyFluffOutro);
}

//Foursome Scene -- Outro
private function foxyFluffOutro():void {
	spriteSelect(68);
	clearOutput();
	outputText("Now a cum- and sweat-soaked mess, you, Hel, and the twins collapse onto the bed, all panting from the exertion of the foursome.  With their thick knots now deflating back to normal sizes, the girls look rather cute as they wipe their own spunk off their smooth breasts and thighs.  Hel moans contentedly as she fingers a bit of foxcream out of her loose cunt.\n\n", false);

	outputText("With a smile, you open your arms, and the fox-twins snuggle up to rest their heads on your " + player.chestDesc() + ".  Hel, smiling, crawls on top of you, giving you a long and loving kiss.  \"<i>That was wonderful, lovers,</i>\" the salamander whispers, putting her arms around the twins.  They giggle, half-drunk and half-asleep.  Surrounded by three warm, sexy bodies, you soon drift off to sleep.\n\n", false);

	//(~3 hours go by)
	outputText("<b>3 hours later...</b>\n\n", false);

	outputText("You awake to find yourself tucked into the bed, your clothes folded neatly next to you.  It looks like someone cleaned you up and tucked you in after your little orgy.  When you hear a loud snore beside you, you don't even need to guess who it was that took care of you.  You pull up the covers, and of course find Helia curled up beside you, her warm tail acting like a pillow for the two of you.  You smile, give her a long kiss, and collect your things.  You leave the salamander to sleep it off, and head back to camp.", false);
	//Bump up follower tracking affection too
	helFollower.helAffection(5);
	doNext(camp.returnToCampUseFourHours);
}


//Telling Hel to Not Get Hooked on Some Random Dude's Dickjuice (Or, How Hel Learned to Love Monogamy. Kind of.)
//[Mino Cum]
private function telHelToGetOffTheMInoCock():void {
	clearOutput();
	outputText("As you lie in your post-coitus afterglow with your lover, a thought makes its way into your mind: Hel just took a load of minotaur cum up the twat.  That's... that's not good. You tell her as much, adding that ");
	if (player.minotaurAddicted()) outputText("you know firsthand");
	else outputText("you've heard");
	outputText(" that their cum is addictive, and you don't want her to get hooked on the stuff.");
	
	outputText("\n\n\"<i>Hmm?</i>\" she answers, cocking an eyebrow at you.  \"<i>What do you mean 'addictive?'  How the hell is bullspunk addictive; the fuck kinda sense does that make?</i>\"");
	
	outputText("\n\nYou shrug and tell her that's just how it is");
	if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) outputText(", just like how Cowgirls have addictive breastmilk");
	outputText(".");
	
	outputText("\n\n\"<i>Well, shit, [name].  I don't wanna get hooked on minotaur cum, but... now what the fuck am I supposed to do? Those bulls are the best fucks around... present company excluded, of course,</i>\" she adds with a little wink.");
	
	outputText("\n\nYou suppose you could offer to satisfy her needs instead... Or just say to hell with it and keep screwing 'taurs to her hearts' content.");
	
	menu();
	addButton(0,"Its Okay",helCanFuckMinosWhenever);
	addButton(1,"Satisfy Her",satisfyHelSoSheStopsMinoFucking);
}
//[Keep Going]
private function helCanFuckMinosWhenever():void {
	clearOutput();
	outputText("You decide not to deter Hel from her minotaur-raping ways.  Nothing bad could come of your salamander friend fucking a few more 'taurs than she already has, right?  You're sure she can just manage her addiction, or lack thereof, just fine on her own.");
	//(Return to post-threesome menu)
	doNext(helChatMenu);
}

//[Satisfy Her]
private function satisfyHelSoSheStopsMinoFucking():void {
	clearOutput();
	outputText("After a moment of contemplation, you give the salamander a lusty grin and tell her you'll just have to satisfy her tremendous sexual appetite yourself.  She seems taken aback by your offer, blinking hard at you.");
	
	outputText("\n\n\"<i>Well, that's a hell of an offer,</i>\" she laughs, rolling over to straddle your [hips].  \"<i>Careful you don't make a promise you can't keep, lover mine...  We salamanders have incredible libidos.  Would be a shame if you couldn't keep up...</i>\"");
	//{If PC has high libido}
	if (player.lib >= 50) {
		outputText("\n\nYou grab Hel's shoulders and throw her onto the ground, your ");
		if (player.hasCock()) outputText("[cock] stiffening, ready to go again");
		if (player.gender == 3) outputText(" and your ");
		if (player.hasVagina()) outputText("[vagina] already soaked with your lustful secretions");
		if (player.gender == 0) outputText("ass ready to be fucked again");
		outputText(".\n\n\"<i>Well, we're off to a good start!</i>\" Hel laughs, pulling you down into her soft, warm cleavage.  \"<i>Come on then, lover mine - show me what you've got!</i>\"");
	}
	//{PC has low libido}
	else {
		outputText("\n\nYou grimace, but decide it's better to try and keep up with the lusty salamander than risk your friend getting addicted to ");
		if (player.hasCock()) outputText("another dick's ");
		outputText("cum.  You nod, agreeing to pleasure her whenever she needs it.");
		
		outputText("\n\nShe smiles at you, clawed hands clutching tightly to your " + player.skinFurScales() + ". \"<i>Don't worry about a thing, lover mine.  I'll be careful not to hurt you... too much.</i>\"");
	}
	if (player.lust < 33) {
		dynStats("lus", 0.1);
		player.lust = 33;
	}
	//(Display sex options)
	//(Mino Threesome will NEVER proc again)
	flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] = 1;
	flags[kFLAGS.HEL_FUCKBUDDY] = 1;
	helFuckMenu();
}

//Hel Sexual Ambush
//(Proc's once per day when [Exploring] anywhere)
public function helSexualAmbush():void {
	clearOutput();
	outputText("As you make your way around, you hear footfalls rapidly approaching.  Alarmed, you lift your [weapon] and spin - just in time for a blazing salamander to bull-rush you to the ground.  The two of you tumble back, eventually coming to a stop with Hel straddling you, already throwing off her scale bikini and clawing at your [armor] - you can see that her thighs are slick with her juices and her skin is flushed with arousal.");
	
	outputText("\n\n\"<i>Come on, [name],</i>\" she growls, throwing her top aside, letting her big, bouncy breasts free. \"<i>You wanted me not to fuck 'taurs?  Fine... but I NEED you.  NOW!</i>\"");
	dynStats("lus", 10+player.lib/20);
	if (player.lust < 33) player.lust = 33;
	flags[kFLAGS.HEL_RAPED_TODAY] = 1;
	//(Raise PC lust; Display sex options)

	// TODO Fix this?
	// Why is this the only place in the whole game where buttonEvents is directly written to?
//Got rid of this, now handled by passing true:	kGAMECLASS.buttonEvents[9] = pussyOutOfHelSexAmbush;
	helFuckMenu(true);
}

//[Leave] (From Sexual Ambush)
private function pussyOutOfHelSexAmbush():void {
	clearOutput();
	outputText("You push Hel off of you and tell her that you just aren't interested in fucking right now.");
	outputText("\n\n\"<i>What,</i>\" she says, completely deadpan.  \"<i>WHAT!?</i>\"");
	outputText("\n\n\"<i>No sex for you,</i>\" you answer.");
	outputText("\n\n\"<i>I.  But.  What.  You said.  We.  But.... WELL FUCK YOU ANYWAY.</i>\"");
	outputText("\n\nYou shrug and head back to camp as Hel, half-mad with lust, starts masturbating, glaring at your back as you leave.");
	doNext(camp.returnToCampUseOneHour);
	helFollower.helAffection(-20);
}
	}
}
