package classes.Scenes.Places.Boat
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kACHIEVEMENTS;

	public class MaraeScene extends AbstractBoatContent implements TimeAwareInterface {

		public function MaraeScene() {
			CoC.timeAwareClassAdd(this);
		}
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			if (model.time.hours > 23) {
				if (flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] > 0) { //Marae met 2nd time?
					if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) { //If flower hasn't been burned down yet
						if (flags[kFLAGS.FUCK_FLOWER_LEVEL] < 4 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] < 1000) { //Grow flower if it isn't fully grown.
							flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER]++;
						}
					}
				}
				if (flags[kFLAGS.HOLLI_FUCKED_TODAY] == 1) flags[kFLAGS.HOLLI_FUCKED_TODAY] = 0; //Holli Fuck Tracking
			}
			return false;
		}
		
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

public function encounterMarae():void {
	spriteSelect(40);
	outputText(images.showImage("marae-first-encounter"));
	outputText("Like a hidden emerald jewel, a small island appears in the distance.  You wager that you're somewhere near the center of this lake.  How coincidental.   You row closer, eager to get out of the boat and stretch your " + player.legs() + ".  The rowboat grounds itself in the moist earth of the island, coming to a dead stop.   You climb out, noting that this island is little more than a raised mound of earth and grass, with a small tree perched atop its apex.  ", false);
	//Dungeon operational
	if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) {
		//First meeting
		if (flags[kFLAGS.MET_MARAE] <= 0) {
			flags[kFLAGS.MET_MARAE] = 1;
			outputText("You approach the tree and note that its bark is unusually smooth.  Every leaf of the tree is particularly vibrant, bright green with life and color.   You reach out to touch the bark and circle around it, noting a complete lack of knots or discoloration.  As you finish the circle, you are surprised to see the silhouette of a woman growing from the bark.  The transformation stops, exposing the front half a woman from the waist up.   You give a start when she opens her eyes – revealing totally white irises, the only part of her NOT textured with bark.\n\n", false);
			if (player.cor > 66 + player.corruptionTolerance() && flags[kFLAGS.MEANINGLESS_CORRUPTION] <= 0) outputText("The woman bellows, \"<i>Begone demon.  You tread on the precipice of damnation.</i>\"  The tree's eyes flash, and you find yourself rowing back to camp.  The compulsion wears off in time, making you wonder just what that tree-woman was!", false);
			//Explain the dungeon scenario
			else {
				flags[kFLAGS.MARAE_QUEST_START] = 1;
				outputText("\"<i>You seem so surprised by me, Champion.   I suppose that is inevitable.  Your origin is not of Mareth, our land, and few save for the demons remember me,</i>\" says the tree.\n\n", false);
				outputText("You take a step back, amazed to find such a creature, apparently uncorrupted.  ", false);
				if (player.lib + player.cor > 80) outputText("Your eyes can't help but take note of the tree-woman's shapely breasts, and wonder if they feel like tits or wood.  ", false);
				outputText("Feeling a bit confused, you introduce yourself and ask her who she is.\n\n", false);
				outputText("\"<i>Me?</i>\" she asks, \"<i>I am the life-goddess Marae.  I am Mareth, for my roots touch every part of it.   Or I was.  Before THEY came.</i>\"\n\n", false);
				outputText("You suggest, \"<i>The demons?</i>\"\n\n", false);
				outputText("She nods and continues, \"<i>The demons were once a tribe of magic-blessed humans, living in the mountains.  They had everything they could ever want:  peace, love, and the power to change reality.  But they grew dissatisfied, as men often do, and craved more.  They began using their magics to alter their bodies, seeking greater pleasure than ever before.  In time they became obsessed with it.  I let them be, believing their folly to be limited to their own village.   I was wrong.  While I focused on preventing famines and ensuring peace between the other villages, the humans twisted themselves into something else, something demonic.  They gave up their souls, crystallizing it into a magical energy source.    Of course they could not be satisfied with consuming the power of their own souls.  They wanted more.  They always want more.</i>\"\n\n", false);
				outputText("You nod in understanding, paying close attention to the tree-goddess as she explains just how this realm has fallen so far, \"<i>They came pouring out of the mountains in a wave, picking off villages left and right.  I lent many villages my power, but none had the strength to stand alone, and none would band together, resentful of their racial differences as they were.   All were consumed, enslaved, or filled with corruption.   My people were cut off from me, either by their new tainted outlook or by the demons' own machinations.  I was able to hide a few places from the enemy's sight, but I do not know how long it will last.</i>\"\n\n", false);
				outputText("She sighs heavily, and you notice the bark of her nipples stiffening.  Her brow creases with something approximating worry as she continues, \"<i>They know of me.  My power originally kept them far from the shores of the lake, but they seek to corrupt me – to make me like them.   They've used magic and industry to trap the pure rains in the clouds around their mountain, starving me, and in its place they spill their tainted sexual fluids.   For... years now, my furthest reaches have been bathed in their vile cum.   While my power is great, I... I cannot resist forever.  My reach has dwindled to little more than this lake.  Parts of me have already fallen, taking the surrounding life with them.  I do not know how much longer I can endure... even now, the desire to mate with you rises within me.</i>\"\n\n", false);
				outputText("She practically begs, \"<i>Please champion, you must help me.  The demons have a factory at the foot of the mountains.  It produces much of the fluid they use to taint me.  If you could find a way to shut it down, I... all of Mareth, might stand a chance.</i>\"\n\n", false);
				outputText("You nod, understanding.  She commands, \"<i>Now go, there is nothing to be gained by your presence here.  Return if you manage to close that vile place.</i>\"\n\n", false);
				if (player.lib + player.cor > 80) {
					outputText("You could leave, but the desire to feel her breast will not go away.  What do you do?", false);
					simpleChoices("Boob",grabHerBoob,"", null,"", null,"", null,"Leave",camp.returnToCampUseOneHour);
				}
				else doNext(camp.returnToCampUseOneHour);
				return;
			}
			doNext(camp.returnToCampUseOneHour);
		}
		//Second meeting
		else {
			outputText("You approach Marae's tree, watching the goddess flow out of the tree's bark as if it was made of liquid.  Just as before, she appears as the top half of a woman, naked from the waist up, with her back merging into the tree's trunk.\n\n", false);
			if (player.cor > 66 + player.corruptionTolerance() && flags[kFLAGS.MEANINGLESS_CORRUPTION] <= 0) {
				outputText("She bellows in rage, \"<i>I told you, begone!</i>\"\n\nYou turn tail and head back to your boat, knowing you cannot compete with her power directly.", false);
				if (player.level >= 30) outputText("  f course, you could probably try to overthrow her."); 
				doNext(camp.returnToCampUseOneHour);
			}
			else
			{
				//If youve taken her quest already
				if (flags[kFLAGS.MARAE_QUEST_START] >= 1) {
					outputText("Marae reminds you, \"<i>You need to disable the demonic factory!  It's located in the foothills of the mountain.  Please, I do not know how long I can resist.</i>\"", false);
					doNext(camp.returnToCampUseOneHour);
				}
				//If not
				else {
					flags[kFLAGS.MARAE_QUEST_START] = 1;
					outputText("<i>You seem so surprised by me, Champion.   I suppose that is inevitable.  Your origin is not of Mareth, our land, and few save for the demons remember me,</i>\" says the tree.\n\n", false);
					outputText("You take a step back, amazed to find such a creature, apparently uncorrupted.  ", false);
					if (player.lib + player.cor > 80) outputText("Your eyes can't help but take note of the tree-woman's shapely breasts, and wonder if they feel like tits or wood.  ", false);
					outputText("Feeling a bit confused, you introduce yourself and ask her who she is.\n\n", false);
					outputText("\"<i>Me?</i>\" she asks, \"<i>I am the life-goddess Marae.  I am Mareth, for my roots touch every part of it.   Or I was.  Before THEY came.</i>\"\n\n", false);
					outputText("You suggest, \"<i>The demons?</i>\"\n\n", false);
					outputText("She nods and continues, \"<i>The demons were once a tribe of magic-blessed humans, living in the mountains.  They had everything they could ever want:  peace, love, and the power to change reality.  But they grew dissatisfied, as men often do, and craved more.  They began using their magics to alter the bodies, seeking greater pleasure than ever before.  In time they became obsessed with it.  I let them be, believing their folly to be limited to their own village.   I was wrong.  While I focused on preventing famines and ensuring peace between the other villages, the humans twisted themselves into something else, something demonic.  They gave up their souls, crystallizing it into a magical energy source.    Of course they could not be satisfied with consuming the power of their own souls.  They wanted more.  They always want more.</i>\"\n\n", false);
					outputText("You nod in understanding, paying close attention to the tree-god as she explains just how this realm has fallen so far, \"<i>They came pouring out of the mountains in a wave, picking off villages left and right.  I lent many villages my power, but none had the strength to stand alone, and none would band together, resentful of their racial differences as they were.   All were consumed, enslaved, or filled with corruption.   My people were cut off from me, either by their new tainted outlook, or by the demon's own machinations.  I was able to hide a few places from the enemy's sight, but I do not know how long it will last.</i>\"\n\n", false);
					outputText("She sighs heavily, and you notice the bark of her nipples stiffening.  Her brow creases with something approximating worry as she continues, \"<i>They know of me.  My power originally kept them far from the shores of the lake, but they seek to corrupt me – to make me like them.   They've used magic and industry to trap the pure rains in the clouds around their mountain, starving me, and in it's place they spill their tainted sexual fluids.   For... years now, my furthest reaches have been bathed in their vile cum.   While my power is great, I... I cannot resist forever.  My reach has dwindled to little more than this lake.  Parts of me have already fallen, taking the surrounding life with them.  I do not know how much longer I can endure... even now, the desire to mate you rises within me.</i>\"\n\n", false);
					outputText("She practically begs, \"<i>Please champion, you must help me.  The demons have a factory at the foot of the mountains.  It produces much of the fluids they use to taint me.  If you could find a way to shut it down, I... all of Mareth, might stand a chance.</i>\"\n\n", false);
					outputText("You nod, understanding.  She commands, \"<i>Now go, there is nothing to be gained by your presence here.  Return if you manage to close that vile place.</i>\"\n\n", false);
					if (player.lib + player.cor > 80) {
						outputText("You could leave, but the desire to feel her breast will not go away.  What do you do?", false);
						simpleChoices("Boob",grabHerBoob,"", null,"", null,"", null,"Leave",camp.returnToCampUseOneHour);
					}
					else doNext(camp.returnToCampUseOneHour);
				}
			}
		}

	}
	//Dungeon inoperable
	else {
		//Not corrupt
		if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
			outputText("Marae smiles broadly at you, and steps free from her tree.  The lithe plant-goddess gives you a warm hug and a kiss on the cheek.\n\n", false);
			outputText("\"<i>Thank you,</i>\" she says, breaking the hug and turning back to her tree, \"<i>The onslaught has lessened, and I feel more myself already.  Let me thank you for your heroic deeds.</i>\"\n\n", false);
			outputText("She plunges a hand inside the tree and pulls out a small pearl.  \"<i>This is a pearl from the very depths of the lake, infused with my purity.  If you eat it, it will grant you my aid in resisting the lust and corruption of this land.</i>\"\n\n", false);
			outputText("Marae pushes the pearl into your hand, and closes your fingers over it gently.  \"<i>Go now, there is still much to be done.  With luck we will not need each other again,</i>\" commands the goddess as she slips back into her tree.  ", false);
			inventory.takeItem(consumables.P_PEARL, camp.returnToCampUseOneHour);
			flags[kFLAGS.MARAE_QUEST_COMPLETE] = 1;
		}
		//Corrupt!
		else {
			outputText("You approach Marae's tree and note that the bark of the tree is smooth, practically wet looking.  The goddess's form is already exposed, as she leans out from the trunk and blows you a kiss.   Her breasts look as if they've filled out quite a bit since your first meeting, jiggling teasingly with every motion she makes.\n\n", true);
			//First corrupt meeting
			if (flags[kFLAGS.MET_MARAE_CORRUPTED] <= 0) {
				flags[kFLAGS.MET_MARAE_CORRUPTED] = 1;
				outputText("She smiles lewdly and beckons you to come closer.  \"<i>Do you like the new me?  I don't know why I was resisting this in the first place.   You shut down the factory, I could feel it in the ground, and I was so happy.  Then I realized HOW you shut down the factory.  I could feel it seeping into my roots.  I was so afraid, feeling that corruption flow through the ground back to me.   I promised myself I would kill you when you dared to show your face.   But then that warmth started flowing into me, and it just melted my anger and resolve,</i>\" she explains, pushing forwards a bit further out from the trunk.\n\n", false);
				outputText("You watch as a tiny purple bud blooms below her belly button, just above her junction with the tree.  The petals unfurl into a very familiar shape, looking more like a vagina than a flower.  Marae reaches down and brushes her fingers across the outer petals, cooing in delight.   You glance up at her eyes and she's practically beaming – she knew where you were looking.\n\n", false);
				outputText("\"<i>I don't mind, I'd like you to watch,</i>\" she says as she begins to masturbate in earnest.  Nectar begins to drip from the flower while she talks about her corruption, \"<i>I couldn't help it, it was like lust was filling me up until there wasn't room for anything else.   I started groping my tits, feeling them grow heavy while I teased and pinched my nipples.  I must have been like that for nearly an hour.  And when the runoff finally started washing into my lake, mmm, I just had to give myself a hot little honeypot.   It felt so good to give in.  I see why the demons do what they do.  It isn't evil, they just want to share this... this pleasure, with everyone and everything.</i>\"\n\n", false);
				outputText("Spellbound, you watch as she forces more and more fingers into her hungry flower-hole, \"<i>Ever since then, I've just been drinking in more and corruption, and waiting for someone to come here and help fill my hole.  I've played with my flower for what has felt like days on end.  Every time I come harder and harder.  The more I let go the better it is.  Do you know what I did this morning?  I let my branches grow tentacles to fuck my mouth and pussy at the same time.  I came over and over and over, and then I had my roots pull in all the cum they could find to fill my womb with.</i>\"\n\n", false);
				outputText("You gasp at the change she has gone through, getting more than a little turned on yourself.  Thinking that a once chaste goddess has been reduced to a horny slut makes you wonder how you stand any chance of victory.  Marae keeps up her show, \"<i>It's so good.  Come join me in it.  I gave in to the pleasure already.  If you look behind me, you can see what's left of my soul.  I could feel it dripping out through my cunny a little bit each time I came.  After a while it flowed together and started to crystalize.  I think the demons call it lethicite, but I just wish I still had a soul so I could do it all over again.  Come fuck me, I want to watch you go mad while you cum out your soul.</i>\"\n\n", false);
				outputText("It sounds like a very pleasant offer, but it would mean the total abandonment of your reasons for coming here.   You could probably get away if you were to run, she doesn't seem to be nearly as powerful.  Or you could risk trying to steal the lethicite before making your getaway, but it wouldn't be hard for her to catch you that close.", false);
				simpleChoices("Run", runFromPervertedGoddess, "Lethicite", maraeStealLethicite, "Accept", maraeBadEnd, "", null, "", null);
				addButton(3, "FIGHT!", promptFightMarae, encounterMarae);
			}
			//Repeat corrupt meeting
			else {
				outputText("Marae smiles and leans forwards, cupping her breasts in her hands.  Amazingly, she flows out from the tree, standing as a free woman before you.  She massages her G-sized breasts, winking lewdly and pinching her shining purplish nipples, squeezing out droplets of honey-colored sap.  She blows you a kiss while the flower at her groin opens welcomingly.  She moans, \"<i>Reconsider my offer yet, " + player.short + "?  I won't force you, but don't you want to spend eternity in heaven with a living goddess?</i>\"", false);
				//Yes - accept, No- run
				doYesNo(maraeBadEnd, runFromPervertedGoddess);
				addButton(3, "FIGHT!", promptFightMarae, encounterMarae);
			}
		}
	}
}

//Prompts
private function promptFightMarae(cancelFunction:Function):void {
	clearOutput();
	outputText("Are you sure you want to fight Marae? She is the life-goddess of Mareth. This is going to be extremely difficult battle.");
	doYesNo(initiateFightMarae, cancelFunction);
}	

//FIGHT!
public function initiateFightMarae():void {
	clearOutput();
	if (flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] == 2) {
		outputText("Your mind finally made up, she must pay for forcibly giving you her 'gift'.\n\n");
	}
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
		outputText("You ready your " + player.weaponName + " and assume a combat stance! \"<i>Pity. You're dealing with a goddess,</i>\" she coos.");
		outputText("\n\nTentacles come up to keep your boat in place so you can't flee.");
	}
	else {
		outputText("Marae looks at you with a smile. \"<i>Get ready! I won't hold back!</i>\"");
	}
	outputText("\n\nIt's a fight!", false)
	startCombat(new Marae(), true);
}	

//Lose against Marae
public function loseAgainstMarae():void {
	clearOutput();
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
		if (player.HP <= 0) outputText("You collapse, too weak to continue fighting. You know that your journey will be over. ");
		else outputText("Your desire to keep fighting has been slain by your overwhelming lust and you collapse. You know that your journey will be over. ");
		doNext(maraeBadEnd);
	}
	else {
		if (player.HP <= 0) outputText("You collapse, too weak to continue fighting. \"<i>Get some rest, champion,</i>\" Marae says. You finally black out. \n\nBy the time you wake up, you find yourself in your camp.");
		else outputText("Your desire to keep fighting has been slain by your overwhelming lust and you collapse. \"<i>Control your urges and get some rest, champion,</i>\" Marae says. You finally black out from your lust. \n\nBy the time you wake up, you find yourself in your camp.");
		combat.cleanupAfterCombat();
	}
}

public function winAgainstMarae():void {
	clearOutput();
	outputText(images.showImage("marae-defeated"));
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
		outputText("\"<i>NO! How can a mortal defeat me?! That's IMPOSSIBLE!</i>\" Marae yells. You tell her that just because she's a goddess doesn't mean a mortal can't defeat her.", true);
		if (silly())
		{
			outputText("\n\n<b>Did you just punch out Cthulhu? Or in this case, Marae?</b>\n\n", false);
		}
		if (player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0 || player.findPerk(PerkLib.FireLord) >= 0 || player.findPerk(PerkLib.Hellfire) >= 0)
		{
			outputText("You summon your magical fire and finish off Marae for the last time. You can hear her screaming as she's withering and shriveling up. While she's on fire, you turn your attention elsewhere.", false);
		}
		else 
		{
			outputText("You raise your " + player.weaponName + " and finish off Marae at last. The corrupted goddess is no more. All the tentacles shrivel up and die. Afterwards, you turn your attention elsewhere.", false)
		}
		if (!player.hasKeyItem("Marae's Lethicite") >= 0) 
		{
			outputText("\n\nSomething shiny catches your eye. Clearly, this has to be Marae's lethicite!", false)
			outputText("\n<b>(Key Item Gained: Marae's Lethicite!)</b>", false)
			
			player.createKeyItem("Marae's Lethicite", 3, 0, 0, 0);
		}
		outputText("\n\nAfter the death of a corrupted physical goddess, you see something odd. There is a pile of intact shards of bark. They looks large and thick enough to be workable. You give it an experiment punch. ")
		if (player.str < 40) outputText("You scream as your hand hits the chitin. Maybe it's because you're not strong enough? ")
		if (player.str >= 40 && player.str < 70) outputText("In spite of your decent strength, the bark refuses to bend or break. ")
		if (player.str >= 70) outputText("Despite your incredible strength, the bark refuses to bend or break. ")
		outputText("The bark is quite strong. Maybe someone can work this into armor? However, there are tentacles attached, still alive. You're not sure if you want armor that has tentacles in it.");
		outputText("\n<b>(Key Item Gained: Tentacled Bark Plates!)</b>", false)
		player.createKeyItem("Tentacled Bark Plates", 0, 0, 0, 0);
		outputText("\n\nWith the tentacles blocking your boat gone, you get into your boat and sail back to the shore and return to your camp.", false)
		awardAchievement("Godslayer", kACHIEVEMENTS.GENERAL_GODSLAYER, true, true);
		flags[kFLAGS.CORRUPTED_MARAE_KILLED] = 1;
		combat.cleanupAfterCombat();
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		if (monster.HP <= 0) outputText("Marae reels back from the incredible amount of damage you've dealt to her.");
		else outputText("Marae clearly shows signs of her overwhelming arousal and reels back.");
		outputText("\n\n\"<i>You have managed to defeat me, champion,</i>\" Marae says, \"<i>Now for the rewards.</i>\"");
		outputText("\n\nThe deity sheds a layer of bark, one piece at a time. \"<i>Take these and bring them to the alchemist Rathazul; he should be able to make armor for you. With luck, we won't need to meet again. I need a long rest after the battle. Farewell,</i>\" Marae says smilingly.");
		outputText("\n\nYou pick up the bark and examine it thoroughly. It's unusually strong for a bark. You thank Marae for the bark, get on your boat and ferry back to the shore.");
		outputText("\n\n<b>(Key Item Gained: Divine Bark Plates!)</b>");
		player.createKeyItem("Divine Bark Plates", 0, 0, 0, 0);
		awardAchievement("Godslayer", kACHIEVEMENTS.GENERAL_GODSLAYER, true, true);
		flags[kFLAGS.PURE_MARAE_ENDGAME] = 2;
		combat.cleanupAfterCombat();
	}
}	

private function maraeBadEnd():void {
	spriteSelect(40);
	clearOutput();
	outputText(images.showImage("marae-bad-end"));
	if (flags[kFLAGS.MET_MARAE_CORRUPTED] <= 0) outputText("The goddess flows out of the tree, stepping away from it as a living woman, curvy and nude.\n\n", false);
	outputText("She approaches you, her breasts swinging pendulously and dripping sap.   Mesmerized by her swaying mammaries, you watch until she mashes you into them with an enormous hug.  A hand traces down your chest to your groin", false);
	if (player.gender == 0) outputText(" where it pauses in momentary confusion", false);
	outputText(".  She giggles and presses your face into her one of her verdant nipples.  You open your mouth to accept the purplish-green bud, licking and suckling it, encouraging her sweet sap to flow into your hungry mouth.  She gushes fluids and pulls you tightly against her tits, crushing you with soft flesh.\n\n", false);

	outputText("The sap inside you makes your throat and belly tingle warmly, as if you had taken a strong drink.   Her milk-sap flows so quickly that you have to gulp it down to keep up.  Tiny burps escape your mouth every now and then as you work to gulp down the tainted treat.  You feel happy and secure, nestled in the bosom of a lust goddess.  ", false);
	if (player.statusEffectv3(StatusEffects.Marble) > 0) outputText("Any thought or need to drink Marble's milk vanishes from your mind and body.  ", false);
	outputText("Foggy euphoria seems to float into your mind, making it difficult to think of anything but emptying the nipple in front of you.   You feel the last few drops splash on your tongue before unnatural strength breaks the seal, yanking you away and forcing a fresh dripping tit into your lips.\n\n", false);

	if (player.cocks.length == 0) {
		outputText("A building sense of pressure grows in your groin, bulging the flesh of your crotch out.  You ignore it, focusing on suckling more of the sweet fluids from your goddess' breasts.   The warmth in your middle feels like it's dripping down into that new bulge, making it tingle with sensitivity.  You ignore it, and lash your tongue across the slippery nipple in your mouth, being rewarded with another warm blast of syrupy sap.   Your mind fills with an impenetrable haze of lust, overcoming any logic with thoughts of raw sex intermingled with animal desire. You're pulled back again by that unholy strength, fighting to get one last lick on that nipple.  Your " + player.legs() + " and " + player.hipDescript() + " shake with lust, driven mad by sweet desire.  Marae reaches down to cup your groin, and blinds you with intense sensation.  She guides your gaze down to a new appendage that's sprouted from your needy groin – <b>a tentacle dick</b>!  It wavers to and fro, coiling on itself and tasting the air like a snake.\n\n", false);
		player.createCock();
		player.cocks[0].cockLength = 36;
		player.cocks[0].cockThickness = 2;
		player.cocks[0].cockType = CockTypesEnum.TENTACLE;
	}
	else {
		outputText("You drink deeply, suckling her thick syrupy milk with strength born of an instantaneous addiction.  The desire to attain more of her 'milk' overrides any other thoughts, clouding over them like a dense morning fog.  The slick nipples feel like they tense and squirm in your mouth as you draw every last bit of their delicious cargo into your greedy gullet.  You " + player.hipDescript() + " twitch and squirm, throbbing and hard, making your " + player.multiCockDescriptLight() + " bob in the air.   Heedless of your groin's incessant begging, you work the nipple in your mouth as if it was your whole world, trying to pleasure as much as suckle.  You can feel your " + player.multiCockDescriptLight() + " squirming in the air  as if reaching for her.  Wait, squirming!?  You're pulled back from her nipple and given the chance to look down, where ", false);
		if (player.countCocksOfType(CockTypesEnum.TENTACLE) < player.cockTotal()) {
			//Single cawks
			if (player.cocks.length == 1) {
				//Set primary cock flag
				player.cocks[0].cockType = CockTypesEnum.TENTACLE;
			}
			//multi
			if (player.cockTotal() > 1) {
				temp = player.cocks.length;
				//Set cock flags
				while(temp > 0) {
					temp--;
					player.cocks[temp].cockType = CockTypesEnum.TENTACLE;
				}
			}
		}
		outputText("<b>you see your " + player.multiCockDescriptLight() + " waving around, seeking a nearby orifice to fuck!</b>\n\n", false);
	}

	outputText("\"<i>Yum,</i>\" whispers Marae, throwing you against her tree and advancing confidently, \"<i>nothing feels quite as good as burying a squirming tentacle into some hot wet cunt's pussy and asshole.</i>\" She beckons you closer and begins advancing on you.  Your body edges closer of its own volition, as if she has a hook buried in your groin and pulling you away from the tree, towards her needy flower.   When she closes within a few feet, your " + player.multiCockDescript() + " splits into a dozen different appendages, each waving in the air with licentious intent.  Before you can react, they lash forwards, wrapping her arms and legs tightly, hauling her onto two central tendrils.  In seconds, your primary tentacle-dick buries itself up to her cervix, pressing roughly against her internal opening while it squirms like a trapped snake inside her cunt.  The secondary cock-vine manages to penetrate her bum with ease, tingling as lubricant splatters around the rough penetration.\n\n", false);

	outputText("You don't really know what's going on anymore.  You're leaning against a tree while your crotch is forcefully double-teaming both of a goddess' holes.  You're too full of warmth and arousal to do anything about it, so you slump down and enjoy it.  Marae cries and moans like a bitch in heat, clearly enjoying the two wriggling tendrils working her over.  Sap leaks from her nipples, and a few spare tentacles immediately latch on, their tips forming into twisted lips.  You can <b>taste</b> the flavor... with your tentacles.  The fog in your mind thickens, and you squeeze another tentacle into her ass without thinking about it.   One more erupts from the bundle at your crotch, and latches onto the goddess' clit, locking her in a state of near-constant orgasm.   Her orgasms milk your cocks with violent muscle contracts, actually managing to pull the member buried inside her through her cervix and into her womb.  It's too much and you start to cum, blacking out from the intensity of it.\n\n", false);
	outputText("<b>Some time passes...</b>\n\n", false);
	outputText("You're still on the island with Marae impaled on two of the wriggling monstrosities you call your cocks.    You haven't pulled free in days, but why would you?  Your bodies are made for each other, a pile of wriggling fuckmeat with holes that drink your cum like the desert drinks water, and a once-hero who lives to sate his mass of seething tentacles.   The two of you are two halves of the same puzzle, locked together in an endless orgy.  You fondly remember watching the shining liquid that was once your soul drip from the wet folds of her flower-petals, crystallizing into a tiny rock much smaller than Marae's own.", false);
	if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) outputText("\n\nOn the shore, Marble looks out on the lake, wondering what happened to the one whom she loved.", false);
	getGame().gameOver();
}

private function maraeStealLethicite():void {
	spriteSelect(40);
	clearOutput();
	//(SUCCESS)
	if ((player.spe > 35 && (rand(player.spe/3 + 30) > 20)) || (player.spe > 35 && player.findPerk(PerkLib.Evade) >= 0 && rand(3) < 2))
	{
		outputText("You dart to the side, diving into a roll that brings you up behind the tree.  You evade the gauntlet of grabbing tentacles that hang from the branches, snatch the large gem in both arms and run for the beach.  You do not hear the sounds of pursuit, only a disappointed sigh.", false);
		player.createKeyItem("Marae's Lethicite", 3, 0, 0, 0);
		doNext(camp.returnToCampUseOneHour);
	}
	//(FAIL)
	else {
		player.slimeFeed();
		player.orgasm();
		outputText("You dart to the side, diving into a roll that brings you up behind the tree.  You try to slip by the gauntlet of grabbing tentacles, but fail, getting tripped and ensnared in them like a fly in a spider's web.  You are pulled up and lifted to the other side of the tree, where you are slammed against it.  The tentacles pull your arms and legs wide, exposing you totally and locking you into a spread-eagle position.  You cringe as Marae strides around, free from the confines of her tree.\n\n", false);
		outputText("\"<i>Awwww, what a nasty deceitful little " + player.mf("boy", "girl"), false);
		outputText("you are.  You turn me into a steaming hot sex-pot, then have the nerve to come here and try to walk off with my lethicite, all WITHOUT fucking me?  Tsk tsk tsk,</i>\" she scolds, \"<i>I appreciate your ambition, but I can't just let a mortal walk all over me like that.  I'll be taking that,</i>\" she says as she grabs the crystal, and lugs it to the tree underneath you.  She strokes the wood surface lovingly, and a knot dilates until it forms a hole large enough to contain the lethicite.  Marae shoves it inside, and strokes the wood like a pet creature, humming while the bark flows closed, totally concealing the crystal.\n\n", false);
		outputText("\"<i>Now, that should keep it safe from swift little play-toys like yourself.  What you tried was a bold move, and I respect that; initiative is to be rewarded.   So I'll let you go, just like that,</i>\" she says, snapping her fingers for emphasis.\n\n", false);
		outputText("The tentacles lower you to the ground, but do not release you from their tight embrace.\n\n", false);
		outputText("Marae steps closer, playing her fingers softly up your thigh, \"<i>BUT, you'll leave with a little something extra.  A gift from the new goddess of fertile unions...</i>\"\n\n", false);
		//DICK
		if (player.gender == 1 || (player.gender == 3 && rand(2) == 1))
		{
			outputText("She extends a hand expectantly, watching with detached concentration while a tentacle lowers from the tree into her palm.   Hips swaying sexually, she advances, peeling back the tentacle's outer layer.  It opens up to reveal a wet, gummy mouth.  She giggles and bumps the opening against your ", false);
			if (player.cocks.length > 1) outputText("largest ", false);
			outputText(player.cockDescript(0), false);
			outputText("'s tip.  Immediately a powerful suction draws your " + player.cockDescript(0) + " inside the tentacle-maw, burying you up to the base in squirming pleasure.   Marae watches the plant go to work, squeezing teasingly until you orgasm.  It takes mere moments for the gifted tentacle to achieve its goal.  Your cum makes a tasty treat for the plant-beast, and it sucks and sucks until your body feels empty and drained.\n\n", false);
			outputText("\"<i>Oh that simply won't do,</i>\" Marae whispers, cupping your ", false);
			if (player.balls > 0) outputText(player.ballsDescriptLight(), false);
			else {
				if (player.vaginas.length > 0) outputText(player.vaginaDescript(0), false);
				else outputText("crotch", false);
			}
			outputText(", \"<i>You'll be my prized breeder.</i>\"  The sharp point of a fingernail presses against your taint, scratching the skin.  \"<i>Just one tiny change to make,</i>\" exhales the goddess.  Pain explodes at the base of your crotch as it feels like her fingernail impales you, penetrating inches into your flesh.  You thrash in agony as it reaches something sensitive inside you.  You black out from pain and the shock of watching your blood flow down her arm.\n\n", false);
			outputText("You feel warm, enclosed in comfort and pleasure.  Is this heaven?  No, your head is throbbing and your eyes are closed... you open them and discover you're still lying at the base of the tree.  That greedy tentacle is still locked around your " + player.cockDescript(0) + " pinning it in the throes of orgasm.  You watch thick bulges of cum pump up the tentacle, evidence of a truly garguantuan fluid output.  It goes on and on, and you realize the pleasure ought to drive you mad.\n\n", false);
			outputText("Marae steps into your field of view, and pulls the tentacle free.  Your " + player.cockDescript(0) + " twitches pitifully, blasting a few massive loads onto your belly as your orgasm withers and dies from lack of stimulation.\n\n", false);
			outputText("\"<i>Sorry about the pain, I had to tweak your body to make you a true breeder.  You can go now stud.  I expect the monsters ought to worry about you now, or they'll all have dripping twats and swollen bellies,</i>\" apologizes Marae.  She turns away from you, returning to the embrace of her tree's tentacles, sinking into debauchery.  You stagger into your boat and row away, oblivious to the stream to pre-cum dripping from your "+ player.multiCockDescript() +".", false);
			if (player.findPerk(PerkLib.MaraesGiftStud) < 0) {
				outputText("<b>(New Perk Gained: Marae's Gift – Stud)</b>", false);
				player.createPerk(PerkLib.MaraesGiftStud,0,0,0,0);
			}
			doNext(camp.returnToCampUseTwoHours);
		}
		//FEM)
		else {
			outputText("She extends a hand expectantly, watching with detached concentration while a tentacle lowers from the tree into her palm.  A swift slash of her free hand cuts your " + player.armorName + " free, exposing your ", false);
			if (player.gender == 0) {
				outputText("hairless crotch.  She holds the tentacle back a moment and raises her free hand.  It begins to glow and shimmer as she points to your groin.  Warmth explodes in your crotch as a wriggling wet gash opens up - <b>your new vagina</b>.  ", false);
				player.createVagina();
				player.genderCheck();
			}
			else outputText(player.vaginaDescript(0) + ".  ", false);
			outputText("She guides the tentacle forwards, letting it brush your nether-lips.  Without any guidance from its mistress, the bulbous plant-member buries itself inside you, sliding in easily until it's pushing hard against your womb.  A quick blast of fluid sends cramps spasming up your gut, forcing your cervix to dilate.  It wastes no time, flowing into your unprotected womb.  As soon as it reaches the back of your womb, thick bulges begin sliding down the exposed portion of the tentacle.  It stretches you wide, almost painfully so, as they pass through your lips and work up your passage.  They begin exploding in your cunt, one after the other, cum-bombs bursting in your womb, filling you to the brink.  Your belly swells out, giving you the appearance of a pregnant woman.  Finished with its nasty work, the plant-prick pulls free leaving your puffy pussy lips slightly agape.  A small runner of a thick green substance slowly slides out.", false);
			player.cuntChange(20,true,true,false);
			outputText("\n\n", false);
			outputText("Marae winks, \"<i>Sorry about making you look so pregnant my dear, it's a necessary part of the process.  All that sloshing seed is going to flow right into your tender little mortal ovaries, and remake them.  You'll be so fertile just looking at a hard cock could knock you up!</i>\"\n\n", false);
			outputText("She giggles at your expression of horror, \"<i>No, not literally, but it won't take much to make you a mommy, and you'll find the gestation to be quite a bit... shorter.  Now get out of here before I change my mind and lock in an orgasm for the rest of your life.</i>\"\n\n", false);
			outputText("You are dropped from the tree, and with little choice, you waddle to your boat, doing your best to cover up your violated " + player.vaginaDescript(0) + ".", false);
			if (player.findPerk(PerkLib.MaraesGiftFertility) < 0) {
				outputText("<b>(New Perk Gained: Marae's Gift – Fertility)</b>", false);
				player.createPerk(PerkLib.MaraesGiftFertility,0,0,0,0);
			}
			doNext(camp.returnToCampUseOneHour);
		}
	}
}

public function level2MaraeEncounter():void {
	spriteSelect(40);
	flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] = 1;
	clearOutput();
	outputText(images.showImage("marae-second-encounter"));
	outputText("While rowing about the lake", false);
	if (player.str > 70) outputText(" with ease", false);
	outputText(", a familiar island resolves itself in the center of the lake.  There's a familiar tree perched atop it, though the wriggling tentacles' silhouette against the sky are a cruel reminder that this island will no longer be the peaceful haven it once was.  ", false);
	if (player.cor < 33) outputText("Knowing all too well what kinds of horrors await", false);
	else if (player.cor < 66) outputText("Knowing all too well what kinds of sexual escapades lurk ahead", false);
	else outputText("Worried about enjoying the pleasures of the island overmuch", false);
	outputText(", you dip your oars into the water and yank the boat around.  Something \"thunk\"s off the bottom of the boat, making the wood shiver and spurring you to row with renewed vigor.  You churn the water with your frenzied rowing, but the island never seems to get any further away.   Frustrated by the definitive lack of progress, you fearfully peer over the edge of the old boat's hull.  \"<i>Well, that explains it,</i>\" you muse.\n\n", false);

	outputText("Squirming roots are crawling over the boat's underside.  They dig into every crease and crevice, binding the vessel tightly in place.  Just as you start to ponder swimming for the shore, the boat shifts, ", false);
	if (player.spe < 50) outputText("dropping you flat on your ass", false);
	else outputText("nearly dropping you flat on your ass before you catch yourself and sit down", false);
	outputText(".  The old dinghy's cutting through the water with amazing speed, leaving foot-high waves in its wake.  Marae's island grows larger with each passing second, almost taunting you with your inability to get away.   By now the root-like vines have crept over the gunwales, and they wriggle at you, seemingly in warning.  Getting in the water is definitely not a good idea right now.	The bone-chilling scrape of sand on wood grates at your ears.  You've arrived.  There's no point in putting off the inevitable.  You straighten up your " + player.armorName, false);
	if (player.weaponName != "fists") outputText(", adjust your " + player.weaponName + ",", false);
	outputText(" and step out of the boat onto the small, sandy beach that rings the island.  The tentacles that dragged your boat ashore are gone, leaving the well-used vessel in pristine condition, or as close as any such water-craft can be.  Looking up, you behold the monstrous, demonic-tree that sprouts from the island's apex.   It has no leaves, only small, teat-like protrusions that sprout from some of the 'branches', which in truth have more in common with tentacles than plant-life.  The squirming mass of sexual shrubbery stays in constant motion, and its intertwined tentacles occasionally bulge and flex as they spurt thick, jism-like sap over one-another.\n\n", false);

	outputText("You advance on the twisted, arboreal orgy with reluctant determination.  Marae wants you here, and there's no way back without dealing with the sex-intoxicated goddess.  Her long, languid moans make it easy to find her.  The delirious deity's arms are entwined through the roots of her trees while a green-patterned tentacle goes diving into the petal-lined entrance of her sloppy sex.  She cranes her neck back at the sound of your footfalls and asks, \"<i>", false);
	//(FORK HERE BETWEEN STOLE LETHICITE AND LAZY ASSHOLEZ)\"
	//(STOLE)
	if (player.hasKeyItem("Marae's Lethicite") >= 0) {
		outputText("Welcome back, sneak-thief.  What kind of " + player.mf("gentleman","lady") + " is offered sex and then ransacks a god's soul?  Honestly, that right-right theeeeeree-oh yeah right there-is true depravity.</i>", false);
	}
	//(FAIL-STOLE)
	else if (player.findPerk(PerkLib.MaraesGiftStud) >= 0 || player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
		outputText("Hey there " + player.short + ".  I didn't think I'd manage to snag you again so soon.  Are you enjoying my gifts?  I've been feeling kind of lonely without anyone around here to play with.</i>", false);
	}
	//(Left Like a Bitch)
	else {
		outputText("Well, look who came back!  I thought you were too afraid of a good time to come up here and fuck around with little ol' Marae.   I was actually going to let you row away if you were too scared to come here.  No, don't even glance back now, I've changed my mind.</i>", false);
	}
	outputText("\"\n\n", false);

	outputText("Featureless white irises glare at you from the goddess' lust-lidded eyes.  She commands you, \"<i>Come here.  It's time for a ", false);
	if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0 || player.findPerk(PerkLib.MaraesGiftStud) >= 0) outputText("second ", false);
	outputText("dose of Marae's tender affections.</i>\"\n\n", false);
	//Incase something breaks
	doNext(playerMenu);
	//Cant fly?  Stuck for sex! Or fight!
	if (!player.canFly()) {
		outputText("You don't see any escape! If you like, you can attempt to fight her, but really?", false);
		doNext(MaraeIIStageII);
		addButton(3, "FIGHT!", promptFightMarae, level2MaraeEncounter);
	}
	//Can fly?  Choice to run
	else {
		outputText("You don't think she's counted on your wings.  If you tried to fly you could probably get out of the reach of her tentacles in short order.", false);
		menu();
		addButton(0, "Stay", MaraeIIStageII);
		addButton(3, "FIGHT!", promptFightMarae, level2MaraeEncounter);
		addButton(4, "Fly Away", MaraeIIFlyAway);
	}
}

private function MaraeIIStageII():void {
	spriteSelect(40);
	clearOutput();
	outputText(images.showImage("marae-second-encounter-pt-two"));
	flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] = 2;
	//[Girls]
	//Marae grows vine-cawks for DP action
	if (player.gender == 2) {
		outputText("Marae coos with pleasure and allows a nectar-slicked tentacle to slip free of her flower.   Her sweet, corrupted smell filters through the air, like pollen carried on a spring breeze.  The goddess' fingers trace the outline of her budding clit, and you watch, enraptured, as it swells up and turns purple.  A clear ridge forms underneath the tip, delineating the under-side of a newly grown cock-tip.  Marae bats her eyelashes and strokes the newly-formed growth as it fills out, surpassing the length of any mortal man.  The crown is a shiny, almost slick purple color, fading to green the further down the stalk-like shaft it goes.   She climbs to her feet, fingernails tracing the outline of the newly-formed urethral bulge on her shaft as she glides closer to you.\n\n", false);

		outputText("Paralyzed by ", false);
		if (player.lust > 80) outputText("lust", false);
		else if (player.cor > 50) outputText("indecision", false);
		else outputText("worry", false);
		outputText(", you don't manage a single backwards step before the warm bulge is rubbing ", false);
		if (player.tallness > 48) outputText("at your crotch", false);
		else outputText("against your belly", false);
		outputText(", and her sap-drooling teats are crushed into you.  Unbidden, your own " + player.nippleDescript(0) + "s grow hard under your " + player.armorName + ".  Marae glances down knowingly and begins to undo your gear, tossing it aside with almost bored contempt.  The sharp edges of her fingernails trace down your abdomen, circle your belly-button, and then slide wide to caress your " + player.hipDescript() + ".  The unexpected shift makes you gasp and rock against her, trying to get her fingertips between your " + player.legs() + ".  The goddess laughs and whispers, \"<i>No dear, that's a dick's job.</i>\"\n\n", false);

		outputText("Your heart hammers in your chest, flushing your " + player.skinDesc + " with heat from the goddess' presence and perfect, knowing touches.   There's no way you could resist her at this point, even if you wanted to.  Her smooth, flawless hands grab your shoulders and push down with a gentle but firm pressure that brooks no resistance.  Your " + player.legs() + " fold underneath Marae's guidance, allowing you to take a proper, worshipful stance.  A confused, half-formed thought claws its way out of the arousal that's swimming through your brain, but you shake your head in irritation and begin to lick your lips while you gawk at Marae's proud new shaft.\n\n", false);

		outputText("Marae runs her slender fingers through your " + player.hairDescript() + ", pulling your " + player.face() + " closer and closer until you smell the fragrance of her nectar and make out every detail of her impeccably smooth penis.  The goddess commands, \"<i>Worship it as you would worship me.</i>\"  You nod, feeling remarkably obedient as you lean forwards to take her in your mouth.   A bead of moisture rolls down the tip, smearing over your lower lip as you open up to encapsulate the suddenly hermaphroditic goddess' prick.  Her pre is sweet, though it doesn't surprise you considering it's coming from part of a flower.  It reminds you a little of honey, though there is an undercurrent of something else that you can't quite place.\n\n", false);

		outputText("Bobbing back and forth, you begin to fellate the goddess of fertility with unthinking, flawless precision.  Marae's hands continue to toy with your " + player.hairDescript() + ", wrenching it painfully once when you accidentally bump her with your teeth.  You whimper submissively and work harder, and your goddess rewards you by sending a tentacle to your groin.  The rounded tip nuzzles against you through your " + player.armorName + ", but quickly angles itself to slip inside.  It curls around your body, coating you with slippery fluids as it works its way back towards your " + player.vaginaDescript(0) + ".\n\n", false);

		outputText("The tentacle squirts something slippery and warm over your outer lips before arching up to pass inside you.  A half-articulated hum of pleasure escapes through your throat to vibrate Marae's plant-like prick.  She grunts and deposits a fat bead of nectar in your mouth, and trickles of the goddess' vaginal fluids start to slide down her inner thighs.  Marae's hips start to pump into you in time with the tentacle that's worming its way inside your " + player.vaginaDescript(0) + ".", false);
		player.cuntChange(12,true,true,false);
		outputText("  Both are dripping and giving tiny squirts of sweet pleasure that simultaneously dull the mind and reinforce your worship of this sexually-charged deity.\n\n", false);

		outputText("Marae grunts and pulls on ", false);
		if (player.horns > 0) outputText("your horns", false);
		else outputText("your " + player.hairDescript(), false);
		outputText(", shoving her thick clit-cock deep inside your throat.  You reflexively swallow down the bulging fuck-meat and ", false);
		if (player.cor < 33) outputText("struggle to ", false);
		else if (player.cor < 66) outputText("work to ", false);
		else outputText("easily ", false);
		outputText("suppress your gag reflex as her cock grows thick in your mouth and begins to dump its cream down your wanton gullet.  The slippery tentacle goes into overdrive while Marae cums, pumping away at your " + player.vaginaDescript(0) + " with incredibly violent fervor.   Your belly bubbles as it's stuffed full of goddess-cum, and your pussy clamps down hard on its invader while it spurts out its own syrupy load into your womb.   Swooning with lust, you orgasm from the twin violations, squirming on Marae's rod while she packs you with nectar.");
		outputText("\n\nThe goddess pulls back with a satisfied sigh, dragging her length out of your throat and shivering from the sensations of your hot, oral vice on her twitching member.  You look up at her with eyes full of adoration, feeling your gut churn from the quantity of her deposit.  Marae ruffles your hair and pulls the tentacle back with a suddenness that makes you feel empty and void.   You feel a little drowsy and close your eyes while your goddess watches over you.  Everything is perfect...", false);
	}
	//[Dudezillaz]
	//Marae uses a tree-tentacle to 'milk' male PC's.  Oral or Vajayjay? Not sure.
	else if (player.gender == 1) {
		outputText("Marae coos with pleasure and allows a nectar-slicked tentacle to slip free of her flower.   Her sweet, corrupted smell filters through the air, like pollen carried on a spring breeze.  You watch, awestruck while the curvy goddess approaches you, cradling a squirming tree-tentacle in each of her hands.  The one in her right twitches and spurts, dribbling seed over her hand in a surprisingly weak display that seems to invigorate the lusty, tainted deity.\n\n", false);

		outputText("You watch, standing stock-still and paralyzed with ", false);
		if (player.lust > 80) outputText("lust", false);
		else if (player.cor > 50) outputText("indecision", false);
		else outputText("worry", false);
		outputText(".  Marae's advance seems like an inexorable march to your eyes, and before you have a chance to react, she's crushed against you in a full-body hug.  Her tongue digs into your mouth, rooting out your tongue and melting your resistance in an overwhelming, lust-powered assault.  You vision swims for a moment when she releases you and pulls back.  It's hard to focus with the busty, nude image of fertility beckoning you.  It makes " + player.sMultiCockDesc() + " strain to reach her, but she dances back with a knowing smile and says, \"<i>Not yet my eager little subject.  Let me undress you, THEN you can worship me.</i>\"\n\n", false);

		outputText("Vines whip out, sliding under your " + player.armorName + ", undoing clasps, and removing it until you stand naked and exposed to Marae.  She smirks and crooks her finger at you in a 'come hither' gesture.  You lurch forward, as if pulled on an invisible string until you're standing inches away from her, your " + player.cockDescript(0) + " rubbing her belly", false);
		if (player.cockTotal() == 2) outputText(" while your other dangles against her thigh", false);
		else if (player.cockTotal() > 2) outputText(" while your others dangle against her thighs", false);
		outputText(".  The goddess gives you a cruel smile, as if she knows something you don't, and she commands, \"<i>Worship me with your cum, champion.  Submit to your goddess and spend your fertile seed for her.</i>\"\n\n", false);

		outputText("Marae extends her arms, and the twin tentacles crawl forward like snakes as they wriggle down her appendages.  You thrust your crotch forwards, presenting it to the goddess, and only wonder why for a brief second before you toss away the nagging, useless thought.  Why would anything but pleasuring the living goddess before you matter?  Her corruptive aura floats in the air, filling you with the desire to submit to your queen and obey her every whim.  " + player.SMultiCockDesc() + " twitches and starts to drip pre-cum, itching to fulfill your deity's desires.\n\n", false);

		outputText("The tentacle on her right arm convulses, then splits open along four joints.  The tip folds open to reveal a pink, wriggling interior that promises pleasures mortal minds weren't meant to comprehend.  Meanwhile, while you're distracted by the eager plant-hole, the other tentacle slips behind you and climbs up your " + player.leg() + ", leaving a trail of slime in its wake.   It slides between your cheeks and prods at your " + player.assholeDescript() + ".  You jerk forwards in surprise, but Marae pushes your " + player.hipDescript() + " back, allowing it to work its way inside.", false);
		player.buttChange(12,true,true,false);
		outputText("  The open plant-hole dives for your groin while you're distracted, hits your " + player.cockDescript(0) + " and devours it with a greedy sluuuuurp.", false);
		if (player.cockTotal() == 2) outputText("  Another vine that may as well be the first's twin snakes from between the goddess' legs and jumps onto your " + player.cockDescript(1) + ".", false);
		else if (player.cockTotal() > 2) outputText("  More 'open' vines shimmy forth from between Marae's legs and jump up onto your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s.", false);

		outputText("You grunt and pump your hips, shameless as you give in to the squeezing, textured tentacle", false);
		if (player.cockTotal() > 1) outputText("s", false);
		outputText(".  Cum boils out from your ", false);
		if (player.balls == 0) outputText("body", false);
		else outputText("balls", false);
		outputText(", but it's quickly devoured by Marae's tree-based tentacle-beast without a sound.  ", false);
		if (player.cumQ() > 500) {
			outputText("The thick bulges of spooge actually distort the vines", false);
			if (player.cockTotal() > 1) outputText("s", false);
			outputText(", letting you get the barest glimpse of white through the over-stretched tentacle-tube", false);
			if (player.cockTotal() > 1) outputText("s", false);
			outputText(".  ", false);
		}
		outputText("A hot, slippery pressure touches something inside your " + player.assholeDescript() + " and makes you squirt even harder.  Marae's minions have found your prostate!  You grunt and groan, but the orgasm doesn't seem to stop.  The goddess teases, \"<i>What?  You didn't think I'd actually let you cum on me did you?</i>\"\n\n", false);

		outputText("It doesn't matter, you're giving her what she wants.  You cum until your " + player.legs() + " give out and you're sprawled on your back, " + player.sMultiCockDesc() + " being milked of its seed by the slurping, cunt-tentacles.  Every time you start to come down, the one in your backdoor rubs you just right and forces out another load.  Marae steps over your " + player.face() + " and drops down, allowing you to lick the nectar that drips from her sensitive, flower-like folds while you cum.  It's sweet, potent, and refreshing.  It makes it easy to keep cumming but hard to stay awake, and your eyes roll back as you pass out from an overload of pleasure.", false);
	}
	//[Hermz]  Marae grows vinecawks for DP under her flowercunt and sexes.
	else {
		outputText("Marae coos with pleasure and allows a nectar-slicked tentacle to slip free of her flower.   Her sweet, corrupted smell filters through the air, like pollen carried on a spring breeze.  You watch, breathlessly staring as she advances, trailing a single finger around the entrance of her plant-like pussy in a provocative manner.  Amber fluid leaks down her thighs, showing you just how ready for sex she is.   The stickiness of your crotch combined with the tightness of " + player.sMultiCockDesc() + " makes it difficult to focus.  Your body is reacting to Marae in a way that's making it hard to focus or think, and though you know she's incredibly dangerous since her fall from grace, you have a hard time caring.\n\n", false);

		outputText("The goddess closes with deliberately slow, hip-swaying steps that make your " + player.cockDescript(0) + " tremble and leave no doubt that she's the goddess of fertility.  Marae giggles and wraps her arms around you, planting a firm, wet kiss on your lips while she undoes your " + player.armorName + ".  Your gear hits the ground with a dull thump, and then her taut green nipples are pressed against your own", false);
		if (player.hasFuckableNipples()) outputText(", slipping inside your cunt-like nipples with ease.  You moan into her ear at the unexpected penetration and shiver from the tingling shocks of pleasure in your " + player.breastDescript(0) + ".", false);
		else outputText(".", false);
		outputText("  Hammering in your chest, your heart beats fast enough to flush your whole body when your " + player.cockDescript(0) + " manages to slip between Marae's legs.  It doesn't penetrate, merely trapping itself between her fluid-lubed thighs", false);
		if (player.cockTotal() == 2) outputText(" while your other cock rubs over her surface", false);
		else if (player.cockTotal() > 2) outputText(" while your other cocks rubs over her surface", false);
		outputText(".\n\n", false);

		outputText("You swoon, your head buzzing with desire for more of this buzzing goddess' embrace.  The urge to kneel before her and worship her cunt rocks you to the core, blasting away the last of your feeble resistance, but before you can do so, Marae grabs you by the chin and commands, \"<i>No my child.  You can serve me better by breeding.</i>\"  Her fingers pull apart the petals of her flowery fuck-hole while she continues, \"<i>Go ahead, put it inside.  I'll show you how to practice the new faith of Marae.</i>\"\n\n", false);

		outputText("She's easy to push down into the soft grasses of the island, and her legs part to allow you better access.  Your " + player.cockDescript(0) + " doesn't need to be told what to do, and it slips into her waiting wetness as if it was made for her.  ", false);
		if (player.cocks[0].cockThickness > 5 || player.cockArea(0) > 100) outputText("With how big you are, there's no way it should be able to fit, but her body isn't even distorted by your girth.  Perhaps she changed you to fit her?  You pull back and your thickness seems unchanged.  You shake your head to clear the unwelcome thoughts and ram yourself back into her.  Fucking is what's important.  ", false);
		else outputText("She feels perfect.  A velvet vice of hot, slippery wetness clutches tightly around your " + player.cockDescript(0) + ".  It almost feels like it's actually gripping you, cradling your cock in her ambrosia-slicked box.", false);
		if (player.cockTotal() > 1) {
			if (player.cockTotal() > 2) outputText("  Another ", false);
			else outputText("Your other ", false);
			outputText(Appearance.cockNoun(CockTypesEnum.HUMAN) + " prods at her tight pucker, and with a slight adjustment, you're able to line it up.  It's wet!  Inch after inch slides in with incredible ease, violating her slippery butthole until you've completely double-penetrated her.", false);
		}
		outputText("\n\n", false);

		if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) outputText("Sticky wetness glistens between your thighs", false);
		else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("Drops of feminine arousal run down your thighs", false);
		else outputText("Trails of viscous feminine fluid leak from your " + player.vaginaDescript(0), false);
		outputText(", reminding you of your unused femsex.  Marae grunts underneath you, and while at first you assume it's from the penetration, the prodding of two cock-like protrusions at your lusty holes corrects your misguided assumptions.  You pull back and begin to fuck her in earnest, and with each long rock back, you can see she's grown tentacles from underneath her ass, like two prehensile tails.  They push forwards and spear you, arresting your movement while you try to cope with the sudden stretching of two of your orifices.  Warmth radiates from the twin intruders along with a slippery fullness.  They're pumping something inside you that tingles and makes " + player.sMultiCockDesc() + " bounce and drip.", false);
		player.cuntChange(12,true,true,false);
		player.buttChange(12,true,true,false);
		outputText("\n\n", false);

		outputText("Marae laughs and teases, \"<i>If this is how you fuck it's no wonder I haven't met your children yet.  If you're going to be my disciple you need to fuck your partners hard until you're stuffing them with cum.  Then you need to do it again.  Alternatively you should be bouncing on their cock and milking it with your " + player.vaginaDescript(0) + " until your womb is packed so full you can't walk.  Now show me how you'll do it, or I might keep you here until you're properly trained!</i>\"\n\n", false);

		outputText("You happily thrust forwards, ramming your " + player.cockDescript(0) + " into her cunt with such force that a wet slap echoes over the lake and her fluids splatter your abdomen.  ", false);
		if (player.cockTotal() > 1) outputText("Her asshole is squelching and dripping from your " + player.cockDescript(1) + ", actually squirting more lubricant than her pussy from the violent fucking!  ", false);
		outputText("In spite of the obscene amount of pleasure " + player.sMultiCockDesc() + " is getting, you focus on obeying your goddess, and you work the muscles in your " + player.vaginaDescript(0) + " and " + player.assholeDescript() + " to pleasure her tentacles.  Muffled sloshes and spurts reach your ears, and you realize just how successful your efforts are.  Marae's pinching her nipples and arching her back, and a moment later a wave of pleasure hits you upside the head with the force of a hammer-blow.\n\n", false);

		outputText("Cum boils out of your ", false);
		if (player.balls > 0) outputText("rapidly contracting balls", false);
		else outputText("tentacle-squeezed prostate", false);
		outputText(" and erupts into Marae's womb.  Your hips rock forward, grazing her cervix with your " + player.cockHead(0) + " to better fill her uterus.  ", false);
		if (player.cockTotal() > 1) outputText("The " + player.cockDescript(1) + " in her ass spasms and explodes with its brother, glazing her slippery colon with a coating of syrupy spunk.  ", false);
		if (player.cockTotal() > 2) {
			outputText("Neglected but orgasming, ", false);
			if (player.cockTotal() > 3) outputText("the remainder of ", false);
			outputText("your ", false);
			if (player.cockTotal() > 3) outputText(player.multiCockDescriptLight(), false);
			else outputText(player.cockDescript(2), false);
			outputText(" does its best to coat Marae's thighs with whiteness.  ", false);
		}
		outputText("The goop from inside you never seems to end, and you pump Marae's belly up with it until she looks a little pregnant.  ", false);
		if (player.cumQ() < 500) outputText("The orgasm is so much more massive than normal, and you wonder if her magic enhanced it.  ", false);
		if (player.cumQ() > 1000) outputText("She's actually surprised when you keep fountaining more seed into her.  Her nipples start to squirt out the excess seed, but you keep cumming until she's squirted enough to soak herself with your jism.  ", false);
		outputText("The goddess' tentacles never let up during it all, and you have a belly that matches Marae's perfectly.\n\n", false);

		outputText("You slide out and slump over, utterly exhausted by the breeding session.  The goddess pulls her tentacles from your abused openings, marveling at the outflow of plant-spunk while you relax and pass out.  You feel her fold your hands around your belly to cradle the pregnant bulge, and then you're snoring contentedly.\n\n", false);
	}
	//ONWARD TO NUMBER 3
	doNext(MaraePt2RoundIIIPrizes);
}

private function MaraePt2RoundIIIPrizes():void {
	spriteSelect(40);
	clearOutput();
	//[EPILOGUE]
	//[Dudes]
	if (player.gender == 1) {
		outputText("You awaken in the midst of a powerful orgasm.  Jism boils out of " + player.sMultiCockDesc() + ", pumping into the tight, sucking tentacle-hole.  Your eyes open wider, and your head clears while you rock your hips in bliss.  You're hanging upside down, suspended in the tentacle tree!  Marae isn't far from you, and she's busy deep-throating the fattest tentacle you've seen while another pair are working her openings.  She turns to you, aware of your wakefulness, and removes the oral intruder, though it manages to squirt a layer of spunk into her face in defiance.   The goddess smirks and slaps it, scolding it before she speaks, \"<i>", false);
		//(FORK STUD vs NO STUD)
		//(STUD)
		if (player.findPerk(PerkLib.MaraesGiftStud) >= 0) outputText("Well, I see my gift is working out quite well for you, isn't it?  That's excellent.  It was an incomplete gift given by an incomplete goddess, but now that I've gotten my hands on you again, I was able to fix it.  You'll build up cum three times as fast as before, no more waiting for days just to build up a huge load for all the horny girls out there!</i>\"  ", false);
		//(NON STUD)
		else outputText("You might be a little sore.  I did some work to make sure you'll be a perfect breeding stud for me.  No tiny cum-shots for you!  You'll squirt out enough to knock up anyone, and I even touched up your seed so it'll get through most contraceptives.  Aren't I the nicest?</i>\"  ", false);
		//(CONTINUED)
		outputText("Her speech is broken by pauses for her to lick up the goo and swallow it, but still perfectly intelligible.  The entire time she was speaking, you were trapped in orgasm, milked by her tree with unthinking intensity.\n\n", false);

		outputText("Breathless and panting, you give Marae a nod of thanks as her tentacles lower you back towards your equipment.  They plant you on shaky " + player.feet() + " and uncoil slowly, stroking your body as they depart.  They must like you.  You get dressed in a hurry, but neither Marae nor the tree are paying you any attention any more.   The boat isn't far, and as you're climbing into it the goddess calls out her goodbyes, \"<i>Thanks for visiting and giving my tree so much of your sperm!  Once its fruit is ready I might come plant one at your camp!  Bye now, and don't forget to knock up all the prettiest girls!</i>\"\n\n", false);
		if (player.findPerk(PerkLib.MaraesGiftStud) >= 0 && player.findPerk(PerkLib.MaraesGiftProfractory) < 0) {
			outputText("<b>(New Perk Gained: Marae's Gift – Profractory)</b>", false);
			player.createPerk(PerkLib.MaraesGiftProfractory,0,0,0,0);
		}
		else if (player.findPerk(PerkLib.MaraesGiftStud) < 0) {
			outputText("<b>(New Perk Gained: Marae's Gift - Stud)</b>", false);
			player.createPerk(PerkLib.MaraesGiftStud,0,0,0,0);
		}
	}
	//[Chickzillas]
	else if (player.gender == 2) {
		outputText("You awaken in the midst of a powerful orgasm.   Jism is pumping into your clenching birth-canal, and you can feel it worming its way into your over-packed womb.  Your eyes open wider as the pleasure brings you to full wakefulness.  You're hanging upside down, suspended in the tentacle tree!  Marae isn't far from you, and she's busy deep-throating the fattest tentacle you've seen while another pair are working her openings.  She turns to you, aware of your wakefulness, and removes the oral intruder, though it manages to squirt a layer of spunk into her face in defiance.   The goddess smirks and slaps it, scolding it before she speaks, \"<i>", false);
		//(BREEDER)
		if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
			outputText("Well, how do you like being my prize breeder?  Your womb is a thing of beauty.  Trust me, I remade it.  I was actually at a loss as to how to improve it, so I decided to take a peek at your other hole.  It was kind of dry, and I didn't want guys with multiple dicks to have to hump such a dry, uncomfortable asshole.  So now it's nice and wet for them!</i>\"\n\n", false);

			outputText("Your eyes widen in shock.  You gasp, \"<i>You did WHAT!?</i>\"\n\n", false);

			outputText("\"<i>I just made your butt-hole a little more welcoming for all the boys that are going to be fucking you.  I mean, once your cunt is full they need somewhere else to stick it right?  If anything the bee-girls should appreciate this.  I know they're kinky and like to use that side,</i>\" Marae confirms.  ", false);
		}
		//(NOT BREEDER)
		else {
			outputText("You might feel a little sore.  I gave your little womb a makeover to make sure you'll be nice and fertile for all the boys out there.  You're going to serve me so well.  So many died fighting the demons, and you'll be popping out kids from every dick that gets anywhere near your little birth-hole.</i>\"  ", false);
		}
		outputText("The entire time she was speaking, you were trapped in orgasm, fucked by her tree with unthinking intensity.\n\n", false);

		outputText("Breathless and panting, you give Marae a confused nod as her tentacles lower you back towards your equipment.  They plant you on shaky " + player.feet() + " and uncoil slowly, stroking your body as they depart.  They must like you.  You get dressed in a hurry, but neither Marae nor the tree are paying you any attention any more.   The boat isn't far, and as you're climbing into it the goddess calls out her goodbyes, \"<I>Thanks for visiting and letting my little friend try out your pussy!  Once I get it to flower I might swing by and plant one for you at your camp!  Bye now, and don't forget to have lots of babies!</i>\"\n\n", false);

		if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0 && player.findPerk(PerkLib.MaraesGiftButtslut) < 0) {
			outputText("<b>(New Perk Gained: Marae's Gift – Buttslut)</b>", false);
			player.createPerk(PerkLib.MaraesGiftButtslut,0,0,0,0);
			player.ass.analWetness = 2;
		}
		else if (player.findPerk(PerkLib.MaraesGiftFertility) < 0) {
			outputText("<b>(New Perk Gained: Marae's Gift – Fertility)</b>", false);
			player.createPerk(PerkLib.MaraesGiftFertility,0,0,0,0);
		}
	}
	//[HERMS]
	else {
		outputText("You awaken in the midst of a powerful orgasm.  Jism boils out of " + player.sMultiCockDesc() + ", pumping into the tight, sucking tentacle-hole.  Plant-spooge is pumping into your clenching birth-canal, and you can feel it worming its way into your over-packed womb.  Your eyes open wider, and your head clears while you rock your hips in bliss.  You're hanging upside down, suspended in the tentacle tree!  Marae isn't far from you, and she's busy deep-throating the fattest tentacle you've seen while another pair are working her openings.  She turns to you, aware of your wakefulness, and removes the oral intruder, though it manages to squirt a layer of spunk into her face in defiance.   The goddess smirks and slaps it, scolding it before she speaks, \"<i>", false);

		//(HAZ NEITHER)
		if (player.findPerk(PerkLib.MaraesGiftFertility) < 0 && player.findPerk(PerkLib.MaraesGiftStud) < 0) {
			//(RANDOM 1)
			if (rand(2) == 0 && player.findPerk(PerkLib.MaraesGiftFertility) < 0) {
				outputText("You might feel a little sore.  I gave your little womb a makeover to make sure you'll be nice and fertile for all the boys out there.  You're going to serve me so well.  So many died fighting the demons, and you'll be popping out kids from every dick that gets anywhere near your little birth-hole.</i>\"  ", false);
				player.createPerk(PerkLib.MaraesGiftFertility,0,0,0,0);
			}
			//(RANDOM 2)
			else if (player.findPerk(PerkLib.MaraesGiftStud) < 0) {
				outputText("You might be a little sore.  I did some work to make sure you'll be a perfect breeding stud for me.  No tiny cum-shots for you!  You'll squirt out enough to knock up anyone, and I even touched up your seed so it'll get through most contraceptives.  Aren't I the nicest?</i>\"  ", false);
				player.createPerk(PerkLib.MaraesGiftStud,0,0,0,0);
			}
			outputText("The entire time she was speaking, you were trapped in orgasm, milked by her tree with unthinking intensity.\n\n", false);

			outputText("Breathless and panting, you give Marae a nod of thanks as her tentacles lower you back towards your equipment.  They plant you on shaky " + player.feet() + " and uncoil slowly, stroking your body as they depart.  They must like you.  You get dressed in a hurry, but neither Marae nor the tree are paying you any attention any more.   The boat isn't far, and as you're climbing into it the goddess calls out her goodbyes, \"<i>Thanks for visiting and giving my tree so much of your sperm!  Once its fruit is ready I might come plant one at your camp!  Bye now, and don't forget to have lots of sex!</i>\"\n\n", false);
			if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
				outputText("<b>(New Perk Gained: Marae's Gift - Fertility)</b>", false);
			}
			else if (player.findPerk(PerkLib.MaraesGiftStud) >= 0) {
				outputText("<b>New Perk Gained: Marae's Gift - Stud)</b>", false);
			}
		}
		//(HAZ BREEDER)
		else if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
			outputText("I can't believe I didn't think to do this last time!  I mean, I spent so much time making you a great baby-birther that I didn't bother to make you a stud too!  I fixed that this time though – you'll be squirting huge loads that are sure to knock up any of the pretty girls out there.  It'll even punch its way through most birth-controlling herbs.  Aren't I nice?</i>\"  ", false);

			outputText("The entire time she was speaking, you were trapped in orgasm, milked by her tree with unthinking intensity.\n\n", false);

			outputText("Breathless and panting, you give Marae a nod of thanks as her tentacles lower you back towards your equipment.  They plant you on shaky " + player.feet() + " and uncoil slowly, stroking your body as they depart.  They must like you.  You get dressed in a hurry, but neither Marae nor the tree are paying you any attention any more.   The boat isn't far, and as you're climbing into it the goddess calls out her goodbyes, \"<i>Thanks for visiting and giving my tree so much of your sperm!  Once its fruit is ready I might come plant one at your camp!  Bye now, and don't forget to have lots of sex!</i>\"\n\n", false);
			if (player.findPerk(PerkLib.MaraesGiftStud) < 0) {
				player.createPerk(PerkLib.MaraesGiftStud, 0, 0, 0, 0);
				outputText("<b>(New Perk Gained: Marae's Gift - Stud)</b>", false);
			}
		}
		//(HAZ STUD)
		else if (player.findPerk(PerkLib.MaraesGiftStud) >= 0) {
			outputText("I can't believe I didn't think of this last time!  I made you such a great stud that I didn't think to make you just as good at popping out your own kids!  Well I went ahead and fixed that while you were sleeping.  Your womb is nice and fertile, and you'll pop out kids a LOT quicker than before.  We'll be repopulating everything in Mareth in no time!  Just be sure to knock up the girls and let the boys fuck your pussy, okay?</i>\"  ", false);

			outputText("The entire time she was speaking, you were trapped in orgasm, milked by her tree with unthinking intensity.\n\n", false);

			outputText("Breathless and panting, you give Marae a nod of thanks as her tentacles lower you back towards your equipment.  They plant you on shaky " + player.feet() + " and uncoil slowly, stroking your body as they depart.  They must like you.  You get dressed in a hurry, but neither Marae or the tree are paying you any attention any more.   The boat isn't far, and as you're climbing into it the goddess calls out her goodbyes, \"<i>Thanks for visiting and giving my tree so much of your sperm!  Once its fruit is ready I might come plant one at your camp!  Bye now, and don't forget to have lots of sex!</i>\"\n\n", false);
			if (player.findPerk(PerkLib.MaraesGiftFertility) < 0) {
				player.createPerk(PerkLib.MaraesGiftFertility, 0, 0, 0, 0);
				outputText("<b>(New Perk Gained: Marae's Gift - Fertility)</b>", false);
			}
		}
		//Has both perks
		else {
			if (player.findPerk(PerkLib.MaraesGiftStud) >= 0 && player.findPerk(PerkLib.MaraesGiftProfractory) < 0) {
				outputText("<b>(New Perk Gained: Marae's Gift – Profractory)</b>", false);
				player.createPerk(PerkLib.MaraesGiftProfractory,0,0,0,0);
			}
			else if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0 && player.findPerk(PerkLib.MaraesGiftButtslut) < 0) {
				outputText("<b>(New Perk Gained: Marae's Gift – Buttslut)</b>", false);
				player.createPerk(PerkLib.MaraesGiftButtslut,0,0,0,0);
			}
		}
	}
	player.orgasm();
	doNext(camp.returnToCampUseTwoHours);
}

private function MaraeIIFlyAway():void {
	spriteSelect(40);
	clearOutput();
	outputText("You launch into the air and beat your wings, taking to the skies.  The tentacle-tree lashes at you, but comes up short.  You've escaped!  Something large whooshes by, and you glance up to see your boat sailing past you.  She must have hurled it at you!  It lands with a splash near the mooring, somehow surviving the impact.  You dive down and drag it back to the dock before you return to camp.  That was close!", false);
	doNext(camp.returnToCampUseOneHour);
}

//Only procs when you have both perks. Rare.
public function level3MaraeEncounter():void {
	clearOutput();
	outputText("Once again, you approach the island where the corrupted goddess resides and set foot on the island. \"<i>Coming back for more?</i>\" Marae coos.");
	outputText("\n\n(Do you fight Marae or stay with her and abandon your quests? Or you could leave if you want.)");
	menu();
	addButton(0, "Fight Her", promptFightMarae, level3MaraeEncounter, null, null, "Fight Marae the corrupted goddess!");
	addButton(1, "Stay With Her", maraeBadEnd, null, null, null, "Stay with Marae and end your adventures?");
	addButton(4, "Leave", camp.returnToCampUseOneHour);
}

private function grabHerBoob():void {
	clearOutput();
	outputText("You reach forward to cop a feel. The goddess' eyes go wide with fury as a massive branch swings down, catching you in the sternum. It hits you hard enough that you land in your boat and float back a few feet into the water. Nothing to do but leave and hope for another chance at her breasts...");
	player.takeDamage(player.HP - 1);
	doNext(camp.returnToCampUseOneHour);
}

private function runFromPervertedGoddess():void {
	outputText("You turn and run for the boat, leaving the corrupt goddess behind.  High pitched laugher seems to chase you as you row away from the island.", true);
	doNext(camp.returnToCampUseOneHour);
}

public function talkToMaraeAboutMinervaPurification():void {
	spriteSelect(40);
	outputText("As you step into the boat and sail it out into the depths of the lake, you focus on trying to find Marae. She may be Minerva’s best chance of being healed. Thankfully, luck is with you and you soon find yourself pulling ashore at the lushly forested island where the nature goddess dwells. In response to your presence, Marae herself materializes from the vegetation, looking at you in a concerned manner.");

	outputText("\n\n\"<i>You return to my island, champion? What brings you here? Is there something troubling you?</i>\" the deity gently asks you.");

	outputText("\n\nMaking whatever gesture of respect feels most appropriate to you, you explain to her about Minerva and her condition, elaborating that you have come to ask Marae if she can possibly help you to cure her.");

	outputText("\n\nAt this, Marae’s expression falls. \"<i>I am sorry, champion, but I cannot do what you ask.</i>\" When you demand to know why, she quickly explains herself. \"<i>It is not that I am ungrateful or unwilling, it is that I am unable. Though you have stopped the assault on my soul by the demon factory, my powers are still vastly diminished from what they were. I fear I would not be able to help her...</i>\" Marae suddenly trails off, looking thoughtful, then gives you an intent expression. \"<i>Explain to me again, the ruins in which you say your friend has been living?</i>\" she requests.");

	outputText("\n\nPuzzled, you repeat your description, watching with bemusement as Marae’s face lights up. \"<i>I hadn’t dared to hope... a nexus! An untainted nexus, still hidden from the demons! Yes, yes I can help your friend, and you both can help me at the same time!</i>\" she declares joyfully. \"<i>Your friend’s home is a nexus, a place of concentrated holy energies. If I can connect myself to it, I can increase my own powers and help heal her.</i>\" Focusing, she holds her hands only slightly apart from each other as a strange green light begins forming between them. It swells in intensity until you are forced to look away, shielding your eyes. When it fades and you can look back without blinding yourself, you see a gently glowing seed resting between her hands. \"<i>Take this seed, champion, and plant it in the fertile soil at the spring you speak of. Do so and I will be able to help your friend overcome her affliction.</i>\"");

	outputText("\n\nYou thank Marae for her assistance and gently accept the glowing seed. Stowing it safely in your personal belongings, you return to your boat and, from there, to camp.");
	player.createKeyItem("Marae's Seed", 0, 0, 0, 0);
	flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 3;
	flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 2;
	doNext(camp.returnToCampUseOneHour);
}

public function encounterPureMaraeEndgame():void {
	spriteSelect(40);
	clearOutput();
	outputText("As you step into the boat and sail it out into the depths of the lake, you focus on trying to find Marae. After all, you need a good challenge. Thankfully, luck is with you and you soon find yourself pulling ashore at the lushly forested island where the nature goddess dwells. In response to your presence, Marae herself materializes from the vegetation, looking at you in a concerned manner.");
	if (flags[kFLAGS.PURE_MARAE_ENDGAME] == 0) {
		outputText("\n\n\"<i>What brings you here, champion?</i> the deity gently asks you.");
		outputText("\n\nYou let Marae know that you're looking for a challenge.");
		outputText("\n\n\"<i>Very well, I deem you worthy to fight me. If you can manage to defeat me, you shall be rewarded greatly,</i>\" she says.");
	}
	else {
		outputText("\n\n\"<i>Are you ready for the challenge, champion?</i> the deity gently asks you.");
	}
	flags[kFLAGS.PURE_MARAE_ENDGAME] = 1;
	menu();
	addButton(0, "Bring it on!", initiateFightMarae, null, null, null, "Challenge Marae to a fight. This is going to be an extremely HARD boss fight! \n\nRecommended level: 30+");
	addButton(1, "Not yet!", camp.returnToCampUseOneHour);
}

}
}