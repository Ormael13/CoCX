package classes.Scenes.Places.Boat 
{
	import classes.*;
<<<<<<< HEAD
	import classes.internals.*;
	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class Marae extends Monster
	{
		
		public function tentacleAttack():void {
			
			outputText("You spot barrage of tentacles coming your way! You attempt to dodge your way out ", false);
			if (combatEvade() || combatFlexibility() || combatMisdirect())
			{
				outputText("and you successfully dodge her tentacles thanks to your superior evasion!", false);
			}
			else if (combatMiss())
			{
				outputText("and you successfully dodge her tentacles!", false);
			}
			else
			{
				outputText("but you fail and get hit instead! The feel of the tentacles left your groin slightly warmer. ", false);
				var damage:int = ((str + 100) + rand(50))
				game.dynStats("lust", rand(5) + 5);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
=======
	import classes.GlobalFlags.kFLAGS;

	public class Marae extends AbstractBoatContent implements TimeAwareInterface {

		public function Marae() {
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
	if(player.findStatusAffect(StatusAffects.DungeonShutDown) < 0) {
		//First meeting
		if(player.findStatusAffect(StatusAffects.MetMarae) < 0) {
			player.createStatusAffect(StatusAffects.MetMarae,0,0,0,0);
			outputText("You approach the tree and note that its bark is unusually smooth.  Every leaf of the tree is particularly vibrant, bright green with life and color.   You reach out to touch the bark and circle around it, noting a complete lack of knots or discoloration.  As you finish the circle, you are surprised to see the silhouette of a woman growing from the bark.  The transformation stops, exposing the front half a woman from the waist up.   You give a start when she opens her eyes – revealing totally white irises, the only part of her NOT textured with bark.\n\n", false);
			if(player.cor > 66) outputText("The woman bellows, \"<i>Begone demon.  You tread on the precipice of damnation.</i>\"  The tree's eyes flash, and you find yourself rowing back to camp.  The compulsion wears off in time, making you wonder just what that tree-woman was!", false);
			//Explain the dungeon scenario
			else {
				player.createStatusAffect(StatusAffects.MaraesQuestStart,0,0,0,0);
				outputText("\"<i>You seem so surprised by me, Champion.   I suppose that is inevitable.  Your origin is not of Mareth, our land, and few save for the demons remember me,</i>\" says the tree.\n\n", false);
				outputText("You take a step back, amazed to find such a creature, apparently uncorrupted.  ", false);
				if(player.lib + player.cor > 80) outputText("Your eyes can't help but take note of the tree-woman's shapely breasts, and wonder if they feel like tits or wood.  ", false);
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
					simpleChoices("Boob", grabHerBoob, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
				}
				else doNext(camp.returnToCampUseOneHour);
				return;
			}
			doNext(camp.returnToCampUseOneHour);
		}
		//Second meeting
		else {
			outputText("You approach Marae's tree, watching the goddess flow out of the tree's bark as if it was made of liquid.   Just as before, she appears as the top half of a woman, naked from the waist up, with her back merging into the tree's trunk.\n\n", false);
			if(player.cor > 66) {
				outputText("She bellows in rage, \"<i>I told you, begone!</i>\"\n\nYou turn tail and head back to your boat, knowing you cannot compete with her power directly.", false);
				doNext(camp.returnToCampUseOneHour);
			}
			else
			{
				//If youve taken her quest already
				if(player.findStatusAffect(StatusAffects.MaraesQuestStart) >= 0) {
					outputText("Marae reminds you, \"<i>You need to disable the demon's factory!  It's located in the foothills of the mountain.  Please, I do not know how long I can resist.</i>\"", false);
					doNext(camp.returnToCampUseOneHour);
				}
				//If not
				else {
					player.createStatusAffect(StatusAffects.MaraesQuestStart,0,0,0,0);
					outputText("<i>You seem so surprised by me, Champion.   I suppose that is inevitable.  Your origin is not of Mareth, our land, and few save for the demons remember me,</i>\" says the tree.\n\n", false);
					outputText("You take a step back, amazed to find such a creature, apparently uncorrupted.  ", false);
					if(player.lib + player.cor > 80) outputText("Your eyes can't help but take note of the tree-woman's shapely breasts, and wonder if they feel like tits or wood.  ", false);
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
						simpleChoices("Boob", grabHerBoob, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
					}
					else doNext(camp.returnToCampUseOneHour);
				}
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
			}
			combatRoundOver();
		}
<<<<<<< HEAD
		
		public function tentacleRape():void {
			
			outputText("You spot barrage of tentacles coming your way! The tentacles are coming your way, aiming for your groin! ", false);
			if (combatEvade() || combatFlexibility() || combatMisdirect())
			{
				outputText("You manage to avoid her tentacles thanks to your superior evasion!", false);
			}
			else if (combatMiss())
			{
				outputText("You manage to successfully run from her tentacles! ", false);
=======

	}
	//Dungeon inoperable
	else {
		//Not corrupt
		if(player.findStatusAffect(StatusAffects.FactoryOverload) < 0) {
			outputText("Marae smiles broadly at you, and steps free from her tree.  The lithe plant-goddess gives you a warm hug and a kiss on the cheek.\n\n", false);
			outputText("\"<i>Thank you,</i>\" she says, breaking the hug and turning back to her tree, \"<i>The onslaught has lessened, and I feel more myself already.  Let me thank you for your heroic deeds.</i>\"\n\n", false);
			outputText("She plunges a hand inside the tree and pulls out a small pearl.  \"<i>This is a pearl from the very depths of the lake, infused with my purity.  If you eat it, it will grant you my aid in resisting the lust and corruption of this land.</i>\"\n\n", false);
			outputText("Marae pushes the pearl into your hand, and closes your fingers over it gently.  \"<i>Go now, there is still much to be done.  With luck we will not need each other again,</i>\" commands the goddess as she slips back into her tree.  ", false);
			inventory.takeItem(consumables.P_PEARL, camp.returnToCampUseOneHour);
			player.createStatusAffect(StatusAffects.MaraeComplete,0,0,0,0);
		}
		//Corrupt!
		else {
			outputText("You approach Marae's tree and note that the bark of the tree is smooth, practically wet looking.  The goddess's form is already exposed, as she leans out from the trunk and blows you a kiss.   Her breasts look as if they've filled out quite a bit since your first meeting, jiggling teasingly with every motion she makes.\n\n", true);
			//First corrupt meeting
			if(player.findStatusAffect(StatusAffects.MetCorruptMarae) < 0) {
				player.createStatusAffect(StatusAffects.MetCorruptMarae,0,0,0,0);
				outputText("She smiles lewdly and beckons you to come closer.  \"<i>Do you like the new me?  I don't know why I was resisting this in the first place.   You shut down the factory, I could feel it in the ground, and I was so happy.  Then I realized HOW you shut down the factory.  I could feel it seeping into my roots.  I was so afraid, feeling that corruption flow through the ground back to me.   I promised myself I would kill you when you dared to show your face.   But then that warmth started flowing into me, and it just melted my anger and resolve,</i>\" she explains, pushing forwards a bit further out from the trunk.\n\n", false);
				outputText("You watch as a tiny purple bud blooms below her belly button, just above her junction with the tree.  The petals unfurl into a very familiar shape, looking more like a vagina than a flower.  Marae reaches down and brushes her fingers across the outer petals, cooing in delight.   You glance up at her eyes and she's practically beaming – she knew where you were looking.\n\n", false);
				outputText("\"<i>I don't mind, I'd like you to watch,</i>\" she says as she begins to masturbate in earnest.  Nectar begins to drip from the flower while she talks about her corruption, \"<i>I couldn't help it, it was like lust was filling me up until there wasn't room for anything else.   I started groping my tits, feeling them grow heavy while I teased and pinched my nipples.  I must have been like that for nearly an hour.  And when the runoff finally started washing into my lake, mmm, I just had to give myself a hot little honeypot.   It felt so good to give in.  I see why the demons do what they do.  It isn't evil, they just want to share this... this pleasure, with everyone and everything.</i>\"\n\n", false);
				outputText("Spellbound, you watch as she forces more and more fingers into her hungry flower-hole, \"<i>Ever since then, I've just been drinking in more and corruption, and waiting for someone to come here and help fill my hole.  I've played with my flower for what has felt like days on end.  Every time I come harder and harder.  The more I let go the better it is.  Do you know what I did this morning?  I let my branches grow tentacles to fuck my mouth and pussy at the same time.  I came over and over and over, and then I had my roots pull in all the cum they could find to fill my womb with.</i>\"\n\n", false);
				outputText("You gasp at the change she has gone through, getting more than a little turned on yourself.  Thinking that a once chaste goddess has been reduced to a horny slut makes you wonder how you stand any chance of victory.  Marae keeps up her show, \"<i>It's so good.  Come join me in it.  I gave in to the pleasure already.  If you look behind me, you can see what's left of my soul.  I could feel it dripping out through my cunny a little bit each time I came.  After a while it flowed together and started to crystalize.  I think the demons call it lethicite, but I just wish I still had a soul so I could do it all over again.  Come fuck me, I want to watch you go mad while you cum out your soul.</i>\"\n\n", false);
				outputText("It sounds like a very pleasant offer, but it would mean the total abandonment of your reasons for coming here.   You could probably get away if you were to run, she doesn't seem to be nearly as powerful.  Or you could risk trying to steal the lethicite before making your getaway, but it wouldn't be hard for her to catch you that close.", false);
				simpleChoices("Run", runFromPervertedGoddess, "Lethicite", maraeStealLethicite, "Accept", maraeBadEnd, "", null, "", null);
			}
			//Repeat corrupt meeting
			else {
				outputText("Marae smiles and leans forwards, cupping her breasts in her hands.  Amazingly, she flows out from the tree, standing as a free woman before you.  She massages her G-sized breasts, winking lewdly and pinching her shining purplish nipples, squeezing out droplets of honey-colored sap.  She blows you a kiss while the flower at her groin opens welcomingly.  She moans, \"<i>Reconsider my offer yet, " + player.short + "?  I won't force you, but don't you want to spend eternity in heaven with a living goddess?</i>\"", false);
				//Yes - accept, No- run
				doYesNo(maraeBadEnd, runFromPervertedGoddess);
			}
		}
	}
}

private function grabHerBoob():void {
	clearOutput();
	outputText("You reach forward to cop a feel.  The goddess' eyes go wide with fury as a massive branch swings down, catching you in the sternum.  It hits you hard enough that you land in your boat and float back a few feet into the water.  Nothing to do but leave and hope for another chance at her breasts...");
	player.takeDamage(player.HP - 1);
	doNext(camp.returnToCampUseOneHour);
}

private function runFromPervertedGoddess():void {
	clearOutput();
	outputText("You turn and run for the boat, leaving the corrupt goddess behind.  High pitched laugher seems to chase you as you row away from the island.");
	doNext(camp.returnToCampUseOneHour);
}

private function maraeBadEnd():void {
	spriteSelect(40);
	outputText("", true);
	outputText(images.showImage("marae-bad-end"));
	if(player.findStatusAffect(StatusAffects.MetCorruptMarae) < 0) outputText("The goddess flows out of the tree, stepping away from it as a living woman, curvy and nude.\n\n", false);
	outputText("She approaches you, her breasts swinging pendulously and dripping sap.   Mesmerized by her swaying mammaries, you watch until she mashes you into them with an enormous hug.  A hand traces down your chest to your groin", false);
	if(player.gender == 0) outputText(" where it pauses in momentary confusion", false);
	outputText(".  She giggles and presses your face into her one of her verdant nipples.  You open your mouth to accept the purplish-green bud, licking and suckling it, encouraging her sweet sap to flow into your hungry mouth.  She gushes fluids and pulls you tightly against her tits, crushing you with soft flesh.\n\n", false);

	outputText("The sap inside you makes your throat and belly tingle warmly, as if you had taken a strong drink.   Her milk-sap flows so quickly that you have to gulp it down to keep up.  Tiny burps escape your mouth every now and then as you work to gulp down the tainted treat.  You feel happy and secure, nestled in the bosom of a lust goddess.  ", false);
	if(player.statusAffectv3(StatusAffects.Marble) > 0) outputText("Any thought or need to drink Marble's milk vanishes from your mind and body.  ", false);
	outputText("Foggy euphoria seems to float into your mind, making it difficult to think of anything but emptying the nipple in front of you.   You feel the last few drops splash on your tongue before unnatural strength breaks the seal, yanking you away and forcing a fresh dripping tit into your lips.\n\n", false);

	if(player.cocks.length == 0) {
		outputText("A building sense of pressure grows in your groin, bulging the flesh of your crotch out.  You ignore it, focusing on suckling more of the sweet fluids from your goddess' breasts.   The warmth in your middle feels like it's dripping down into that new bulge, making it tingle with sensitivity.  You ignore it, and lash your tongue across the slippery nipple in your mouth, being rewarded with another warm blast of syrupy sap.   Your mind fills with an impenetrable haze of lust, overcoming any logic with thoughts of raw sex intermingled with animal desire. You're pulled back again by that unholy strength, fighting to get one last lick on that nipple.  Your " + player.legs() + " and " + hipDescript() + " shake with lust, driven mad by sweet desire.  Marae reaches down to cup your groin, and blinds you with intense sensation.  She guides your gaze down to a new appendage that's sprouted from your needy groin – <b>a tentacle dick</b>!  It wavers to and fro, coiling on itself and tasting the air like a snake.\n\n", false);
		player.createCock();
		player.cocks[0].cockLength = 36;
		player.cocks[0].cockThickness = 2;
		player.cocks[0].cockType = CockTypesEnum.TENTACLE;
	}
	else {
		outputText("You drink deeply, suckling her thick syrupy milk with strength born of an instantaneous addiction.  The desire to attain more of her 'milk' overrides any other thoughts, clouding over them like a dense morning fog.  The slick nipples feel like they tense and squirm in your mouth as you draw every last bit of their delicious cargo into your greedy gullet.  You " + hipDescript() + " twitch and squirm, throbbing and hard, making your " + multiCockDescriptLight() + " bob in the air.   Heedless of your groin's incessant begging, you work the nipple in your mouth as if it was your whole world, trying to pleasure as much as suckle.  You can feel your " + multiCockDescriptLight() + " squirming in the air  as if reaching for her.  Wait, squirming!?  You're pulled back from her nipple and given the chance to look down, where ", false);
		if(player.tentacleCocks() < player.cockTotal()) {
			//Single cawks
			if(player.cocks.length == 1) {
				//Set primary cock flag
				player.cocks[0].cockType = CockTypesEnum.TENTACLE;
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
			}
			else
			{
				outputText("You attempt to slap away the tentacles but it's too late! The tentacles tickle your groin and you can feel your [ass] being teased! \"<i>You know you want me! </i>\" Marae giggles. ", false);
				var lustDmg:Number = (20 + rand(player.cor / 10) + rand(player.sens / 5) + rand(player.lib / 10) + rand(10)) * (game.lustPercent() / 100);
				game.dynStats("lust", lustDmg, "resisted", false);
				outputText("(+" + lustDmg + " lust)");
				
			}
			combatRoundOver();
		}
<<<<<<< HEAD
		
		override public function defeated(hpVictory:Boolean):void
		{
			doNext(game.boat.marae.winAgainstMarae);
=======
		outputText("<b>you see your " + multiCockDescriptLight() + " waving around, seeking a nearby orifice to fuck!</b>\n\n", false);
	}

	outputText("\"<i>Yum,</i>\" whispers Marae, throwing you against her tree and advancing confidently, \"<i>nothing feels quite as good as burying a squirming tentacle into some hot wet cunt's pussy and asshole.</i>\" She beckons you closer and begins advancing on you.  Your body edges closer of its own volition, as if she has a hook buried in your groin and pulling you away from the tree, towards her needy flower.   When she closes within a few feet, your " + multiCockDescript() + " splits into a dozen different appendages, each waving in the air with licentious intent.  Before you can react, they lash forwards, wrapping her arms and legs tightly, hauling her onto two central tendrils.  In seconds, your primary tentacle-dick buries itself up to her cervix, pressing roughly against her internal opening while it squirms like a trapped snake inside her cunt.  The secondary cock-vine manages to penetrate her bum with ease, tingling as lubricant splatters around the rough penetration.\n\n", false);

	outputText("You don't really know what's going on anymore.  You're leaning against a tree while your crotch is forcefully double-teaming both of a goddess' holes.  You're too full of warmth and arousal to do anything about it, so you slump down and enjoy it.  Marae cries and moans like a bitch in heat, clearly enjoying the two wriggling tendrils working her over.  Sap leaks from her nipples, and a few spare tentacles immediately latch on, their tips forming into twisted lips.  You can <b>taste</b> the flavor... with your tentacles.  The fog in your mind thickens, and you squeeze another tentacle into her ass without thinking about it.   One more erupts from the bundle at your crotch, and latches onto the goddess' clit, locking her in a state of near-constant orgasm.   Her orgasms milk your cocks with violent muscle contracts, actually managing to pull the member buried inside her through her cervix and into her womb.  It's too much and you start to cum, blacking out from the intensity of it.\n\n", false);
	outputText("<b>Some time passes...</b>\n\n", false);
	outputText("You're still on the island with Marae impaled on two of the wriggling monstrosities you call your cocks.    You haven't pulled free in days, but why would you?  Your bodies are made for each other, a pile of wriggling fuckmeat with holes that drink your cum like the desert drinks water, and a once-hero who lives to sate his mass of seething tentacles.   The two of you are two halves of the same puzzle, locked together in an endless orgy.  You fondly remember watching the shining liquid that was once your soul drip from the wet folds of her flower-petals, crystallizing into a tiny rock much smaller than Marae's own.", false);
	if(player.findStatusAffect(StatusAffects.CampMarble) >= 0) outputText("\n\nOn the shore, Marble looks out on the lake, wondering what happened to the one whom she loved.", false);
	eventParser(5035);
}

private function maraeStealLethicite():void {
	spriteSelect(40);
	outputText("", true);
	//(SUCCESS)
	if((player.spe > 35 && (rand(player.spe/3 + 30) > 20)) || (player.spe > 35 && player.findPerk(PerkLib.Evade) >= 0 && rand(3) < 2))
	{
		outputText("You dart to the side, diving into a roll that brings you up behind the tree.  You evade the gauntlet of grabbing tentacles that hang from the branches, snatch the large gem in both arms and run for the beach.  You do not hear the sounds of pursuit, only a disappointed sigh.", false);
		player.createKeyItem("Marae's Lethicite",0,0,0,0);
		doNext(camp.returnToCampUseOneHour);
	}
	//(FAIL)
	else {
		player.slimeFeed();
		outputText("You dart to the side, diving into a roll that brings you up behind the tree.  You try to slip by the gauntlet of grabbing tentacles, but fail, getting tripped and ensnared in them like a fly in a spider's web.  You are pulled up and lifted to the other side of the tree, where you are slammed against it.  The tentacles pull your arms and legs wide, exposing you totally and locking you into a spread-eagle position.  You cringe as Marae strides around, free from the confines of her tree.\n\n", false);
		outputText("\"<i>Awwww, what a nasty deceitful little ", false);
		if(player.gender <= 1) outputText("boy ", false);
		else outputText("girl ", false);
		outputText("you are.  You turn me into a steaming hot sex-pot, then have the nerve to come here and try to walk off with my lethicite, all WITHOUT fucking me?  Tsk tsk tsk,</i>\" she scolds, \"<i>I appreciate your ambition, but I can't just let a mortal walk all over me like that.  I'll be taking that,</i>\" she says as she grabs the crystal, and lugs it to the tree underneath you.  She strokes the wood surface lovingly, and a knot dilates until it forms a hole large enough to contain the lethicite.  Marae shoves it inside, and strokes the wood like a pet creature, humming while the bark flows closed, totally concealing the crystal.\n\n", false);
		outputText("\"<i>Now, that should keep it safe from swift little play-toys like yourself.  What you tried was a bold move, and I respect that; initiative is to be rewarded.   So I'll let you go, just like that,</i>\" she says, snapping her fingers for emphasis.\n\n", false);
		outputText("The tentacles lower you to the ground, but do not release you from their tight embrace.\n\n", false);
		outputText("Marae steps closer, playing her fingers softly up your thigh, \"<i>BUT, you'll leave with a little something extra.  A gift from the new goddess of fertile unions...</i>\"\n\n", false);
		//DICK
		if(player.gender == 1 || (player.gender == 3 && rand(2) == 1))
		{
			outputText("She extends a hand expectantly, watching with detached concentration while a tentacle lowers from the tree into her palm.   Hips swaying sexually, she advances, peeling back the tentacle's outer layer.  It opens up to reveal a wet, gummy mouth.  She giggles and bumps the opening against your ", false);
			if(player.cocks.length > 1) outputText("largest ", false);
			outputText(cockDescript(0), false);
			outputText("'s tip.  Immediately a powerful suction draws your " + cockDescript(0) + " inside the tentacle-maw, burying you up to the base in squirming pleasure.   Marae watches the plant go to work, squeezing teasingly until you orgasm.  It takes mere moments for the gifted tentacle to achieve its goal.  Your cum makes a tasty treat for the plant-beast, and it sucks and sucks until your body feels empty and drained.\n\n", false);
			outputText("\"<i>Oh that simply won't do,</i>\" Marae whispers, cupping your ", false);
			if(player.balls > 0) outputText(ballsDescriptLight(), false);
			else {
				if(player.vaginas.length > 0) outputText(vaginaDescript(0), false);
				else outputText("crotch", false);
			}
			outputText(", \"<i>You'll be my prized breeder.</i>\"  The sharp point of a fingernail presses against your taint, scratching the skin.  \"<i>Just one tiny change to make,</i>\" exhales the goddess.  Pain explodes at the base of your crotch as it feels like her fingernail impales you, penetrating inches into your flesh.  You thrash in agony as it reaches something sensitive inside you.  You black out from pain and the shock of watching your blood flow down her arm.\n\n", false);
			outputText("You feel warm, enclosed in comfort and pleasure.  Is this heaven?  No, your head is throbbing and your eyes are closed... you open them and discover you're still lying at the base of the tree.  That greedy tentacle is still locked around your " + cockDescript(0) + " pinning it in the throes of orgasm.  You watch thick bulges of cum pump up the tentacle, evidence of a truly garguantuan fluid output.  It goes on and on, and you realize the pleasure ought to drive you mad.\n\n", false);
			outputText("Marae steps into your field of view, and pulls the tentacle free.  Your " + cockDescript(0) + " twitches pitifully, blasting a few massive loads onto your belly as your orgasm withers and dies from lack of stimulation.\n\n", false);
			outputText("\"<i>Sorry about the pain, I had to tweak your body to make you a true breeder.  You can go now stud.  I expect the monsters ought to worry about you now, or they'll all have dripping twats and swollen bellies,</i>\" apologizes Marae.  She turns away from you, returning to the embrace of her tree's tentacles, sinking into debauchery.  You stagger into your boat and row away, oblivious to the stream to pre-cum dripping from your "+multiCockDescript()+".", false);
			player.createPerk(PerkLib.MaraesGiftStud,0,0,0,0);
			doNext(camp.returnToCampUseTwoHours);
		}
		//FEM)
		else {
			outputText("She extends a hand expectantly, watching with detached concentration while a tentacle lowers from the tree into her palm.  A swift slash of her free hand cuts your " + player.armorName + " free, exposing your ", false);
			if(player.gender == 0) {
				outputText("hairless crotch.  She holds the tentacle back a moment and raises her free hand.  It begins to glow and shimmer as she points to your groin.  Warmth explodes in your crotch as a wriggling wet gash opens up - <b>your new vagina</b>.  ", false);
				player.createVagina();
				player.genderCheck();
			}
			else outputText(vaginaDescript(0) + ".  ", false);
			outputText("She guides the tentacle forwards, letting it brush your nether-lips.  Without any guidance from its mistress, the bulbous plant-member buries itself inside you, sliding in easily until it's pushing hard against your womb.  A quick blast of fluid sends cramps spasming up your gut, forcing your cervix to dilate.  It wastes no time, flowing into your unprotected womb.  As soon as it reaches the back of your womb, thick bulges begin sliding down the exposed portion of the tentacle.  It stretches you wide, almost painfully so, as they pass through your lips and work up your passage.  They begin exploding in your cunt, one after the other, cum-bombs bursting in your womb, filling you to the brink.  Your belly swells out, giving you the appearance of a pregnant woman.  Finished with its nasty work, the plant-prick pulls free leaving your puffy pussy lips slightly agape.  A small runner of a thick green substance slowly slides out.", false);
			player.cuntChange(20,true,true,false);
			outputText("\n\n", false);
			outputText("Marae winks, \"<i>Sorry about making you look so pregnant my dear, it's a necessary part of the process.  All that sloshing seed is going to flow right into your tender little mortal ovaries, and remake them.  You'll be so fertile just looking at a hard cock could knock you up!</i>\"\n\n", false);
			outputText("She giggles at your expression of horror, \"<i>No, not literally, but it won't take much to make you a mommy, and you'll find the gestation to be quite a bit... shorter.  Now get out of here before I change my mind and lock in an orgasm for the rest of your life.</i>\"\n\n", false);
			outputText("You are dropped from the tree, and with little choice, you waddle to your boat, doing your best to cover up your violated " + vaginaDescript(0) + ".", false);
			player.createPerk(PerkLib.MaraesGiftFertility,0,0,0,0);
			doNext(camp.returnToCampUseOneHour);
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory) {
				doNext(game.boat.marae.loseAgainstMaraeByHP);
			}
			else {
				doNext(game.boat.marae.loseAgainstMaraeByLust);
			}
		}
		
		public function Marae() 
		{
			this.a = "";
			this.short = "Marae";
			this.imageName = "marae";
			this.long = "This being is known as the goddess of Marae. She is corrupted due to the aftermath of the factory valves being blown up. The \"flower\" below her belly button resembles more of a vagina than a flower. Her G-cup sized breasts jiggle with every motion."
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;
			this.tallness = 10*12;
			this.hipRating = 10;
			this.buttRating = 8;
			this.skinTone = "white";
			this.skinType = 0;
			//this.skinDesc = Appearance.Appearance.DEFAULT_SKIN_DESCS[SKIN_TYPE_FUR];
			this.hairColor = "green";
			this.hairLength = 36;
			initStrTouSpeInte(150, 150, 70, 110);
			initLibSensCor(60, 25, 100);
			this.weaponName = "tentacles";
			this.weaponVerb="slap";
			this.weaponAttack = 40;
			this.weaponPerk = "";
			this.weaponValue = 25;
			this.armorName = "bark";
			this.armorDef = 30;
			this.bonusHP = 4750;
			this.lust = 30;
			this.lustVuln = .02;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 99;
			this.additionalXP = 2500;
			this.drop = NO_DROP;
			this.gems = 1000;
			this.special1 = tentacleAttack;
			this.special2 = tentacleRape;
			this.createPerk(PerkLib.Tank, 0, 0, 0, 0);
			this.createPerk(PerkLib.Tank2, 0, 0, 0, 0);
			checkMonster();
		}
		
	}
<<<<<<< HEAD

}
=======
	doNext(camp.returnToCampUseTwoHours);
}

private function MaraeIIFlyAway():void {
	spriteSelect(40);
	outputText("", true);
	outputText("You launch into the air and beat your wings, taking to the skies.  The tentacle-tree lashes at you, but comes up short.  You've escaped!  Something large whooshes by, and you glance up to see your boat sailing past you.  She must have hurled it at you!  It lands with a splash near the mooring, somehow surviving the impact.  You dive down and drag it back to the dock before you return to camp.  That was close!", false);
	doNext(camp.returnToCampUseOneHour);
}
}
}
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
