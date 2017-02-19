package classes.Scenes.Places.TelAdre 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Scenes.NPCs.Urta;

	public class KatherineThreesome extends TelAdreAbstractContent
	{

		public function KatherineThreesome() {}

		public function get edryn():Edryn { return telAdre.edryn; }

		public function get katherine():Katherine { return telAdre.katherine; }

		public function get urta():Urta { return kGAMECLASS.urta; }

		/*
		Contains the following scenes:
			circlejerk					Not available if Kath has no cock, Works for all except genderless characters
			threeSixtyNine
			roastYou					Not available if Kath has no cock
			spitroastKath				Works for all except genderless characters
			pinAndFuck					Not available if Kath has no cock					Kath is sober, Urta is drunk
			watch																			Kath is sober, Urta is drunk
			kathLicksOutUrta																Kath is drunk, Urta is sober
			knothole					Not available if Kath has no cock					Kath is drunk, Urta is sober
			sandwich					Not available if Kath has no cock					Kath is drunk, Urta is sober
			orgy																			Both Kath and Urta are drunk
			doubleStuffKath																	Both Kath and Urta are drunk
			doublePenetrateKath																Both Kath and Urta are drunk
			fistKathAndVala
			doubleStuffVala				Not available if Kath has no cock
			eatOutVala					Not available if Kath has no cock
		*/

		public function circlejerk():void { //Not available if Kath has no cock
			clearOutput();
			outputText("There’s no reason to not have some fun with the two of them... plus you don’t think you’d be able resist the allure of joining two of your favourite girls in their bonding.  Stripping off your " + player.armorName + " you step behind the two girls and embrace Urta into a hug, hands wandering her body to loosen the straps of her armor.\n\n");
			outputText("Urta seems to jump at your touch.  “<i>" + player.short + "?  What are you doing, you naughty [boy]?</i>”  She giggles.  Kath looks at you and smirks, “<i>Couldn’t resist getting into this, huh, " + player.short + "?  Well, why not?  After all, we’re technically a </i>ménage à trois</i>, aren’t we?</i>”\n\n");
			outputText("You give both girls a winning smile and tell them that you’ll be joining in on their fun shortly, but first you have to take care of a problem... Urta here is a bit overdressed... and come to think of it, so is Kath.\n\n");
			outputText("Smirking, the cat begins to remove her shirt, pulling it off and casting it aside.  “<i>How big of a mess are we going to make with just a circlejerk?</i>”\n\n");
			outputText("“<i>Kitty, you got no idea who you’re talking about, do you?</i>” Urta says, letting the cat’s dick go to help you remove her clothes and armor as well.\n\n");
			outputText("As soon as Urta’s top is off her, you move your hands to grope at her soft orbs, pinching and twisting her nipples, then pulling her head against your " + (player.hasBreasts() ? player.breastDescript(0) : "chest") + ", and finally giving her perky fox-ear a gentle bite");
			var race:String = player.race(); //Looks like the best way to be sure you have sharp teeth
			var race3:String = race.substr(0, 3); //Tests for cat, dog, fox
			var race6:String = race.substr(0, 6); //Tests for dragon, drider, ferret, spider
			if (race3 == "cat" || race3 == "dog" || race3 == "fox" || race6 == "dragon" || race6 == "drider" || race6 == "ferret" || race6 == "spider" || race == "naga" || race == "kitsune" || race == "demon-morph" || race == "shark-morph" || race.search("lizan") > -1)
				outputText(", careful not to hurt her with your sharp teeth");
			outputText(".\n\nUrta giggles.  “<i>Frisky [boy]... mmm, you always did know how to get me ready, didn’t you?</i>” she asks, tail wagging softly behind her, indirectly patting you with its soft, fluffy mass.  Through all this her hand remains firmly attached to Kath’s dick, and she begins to gently slide it up and down, stroking with the ease of someone who has a lot of practice on their own dick.\n\n");
			outputText("Urta’s fluffy tail patting you down is enough to get you in the mood");
			if (player.hasCock()) outputText("; [eachCock] erects, nice and ready for what’s to come");
			else if (player.hasVagina()) outputText("; your pussy is drenched with your juices, some of it dripping on Urta’s tail");
			outputText(".");
			outputText(" Feeling it’s time to join them, you circle around and sit in front of them.  Smiling at both girls, you gently reach out and grip Urta’s cock in your hands, making sure to stroke her sensually over her entire length and smear her pre all over her flared tip.  You look at Kath, smiling seductively, teasing her with your eyes.\n\n");
			outputText("“<i>Is that a challenge, " + player.short + "?  That you can get vixxy here to cum before she gets me to cum, hmm?</i>” Kath asks, grinning and showing needle-like teeth.  “<i>Well, since you went and got so obligingly naked for us, I’m gonna make this a little more challenging...</i>”  She reaches out, her fingers ");
			if (player.hasCock())
				outputText("wrapping around your cock" + (player.hasVagina() ? " and " : ""));
			if (player.hasVagina()) outputText("gently teasing around your cunt");
			outputText(".  “<i>Winner is whoever cums last?</i>” she jokes.\n\n");
			outputText("“<i>Sounds fine by me, kitty,</i>” Urta says, her breathing already harsh with lustful anticipation.  You join in on the fun, saying that sounds all right for you... then ask the girls what you get after you win?\n\n");
			outputText("The words “<i>what do you want?</i>” pour from both girls simultaneously, each pair of lips curled into its own distinctive half-lustful, half-teasing smile.  They look at each other in surprise at speaking in unison like that, and then manage to give a small, but friendly, smile to each other.  Hmm... there is so much you could ask for... but for now you tell them you just want them to get along, and maybe later... a double service is in order?\n\n");
			outputText("“<i>First, you gotta win,</i>” Kath grins, Urta nodding her head in agreement.  “<i>And if we win... hmm... what will you do, vixxy?</i>”\n\n");
			outputText("“<i>I don’t know... I’ve never thought about it,</i>” Urta admits.\n\n");
			outputText("“<i>Well, I know what I want to do to [him]...</i>” Kath laughs, leering at you, but she doesn’t continue; evidently, she wants to unsettle you by letting your mind fill in the blanks.  Well, you won’t have to worry about that if you just focus on winning!  With that in mind, you redouble your efforts, doing your best to stroke Urta in all the sensitive spots you’ve come to know, ever since you started fooling around with her.\n\n");
			outputText("The vixen yelps in shock, trailing off into a throaty moan of pleasure, but shakes her head, eager to win as well.  Her hand promptly starts sliding up and down Katherine’s prick, but her lack of familiarity with the " + katherine.cockType("canine shape, especially the swelling knot at its base,", "feline shape and the swelling knot at its base") + " means it’s not as effective as it might have been.  Still, she struggles admirably, fingers flexing and caressing even as her palm glides up and down, stroking and teasing " + katherine.cockType("the canine-cocked cat", "Kath's shaft and knot") + ".\n\n");
			outputText("You moan yourself as Kath starts struggling through her pleasure haze, not willing to be beaten without a fight.");
			if (player.hasCock()) outputText("   Her hand teases your [cock] with the soft pads on the tips of her fingers; every once in awhile, she reaches up to collect a dollop of pre and smear it along your shaft, making it easier for her to tease you into defeat.");
			if (player.hasVagina()) outputText("   Her " + (player.hasCock() ? "other " : "") + "hand teases your labia by gently circling it, the fur tickling your entrance so deliciously, you can’t help but buck against her wandering finger, trying to capture it within your moist walls.");
			outputText("\n\nThe three of you moan, groan, growl, yowl and buck in a chorus of sounds that leaves no doubt about what is taking place within the watch’s safe-house.  For a moment you let the pleasure of the moment overtake you... here you are, pleasuring and being pleasured by two sexy herms... they look so beautiful, moaning in pleasure at your mutual ministrations, naked and exposed, their differences bare before your eyes... as well as their similarities... but that is enough musing for now; you have a contest to win.\n\n");
			outputText("You reach down to fondle Urta’s balls, rubbing and caressing the heavy orbs in your palms, then with a smirk, you extend your middle finger... and suddenly plunge it into Urta’s opening.  The fox lets out a very wolf-like howl of equal parts shock and pleasure at your bold action, her walls eagerly clamping down on the intruding digit and trying to suck you further inside.  “<i>T-that’s cheating, " + player.short + "!</i>” she whimpers.\n\n");
			outputText("Smiling, you retort that what wouldn’t be fair is stroking only her cock, when she clearly has a sweet, tight honeypot just yearning for some attention.  With that said you wiggle your finger inside her, feeling her walls contract and grasp at your intruding digit.  Wriggling in her seat, femcum now beginning to ooze forth to join the puddle of pre already spreading out from around her balls, she shifts to better face Katherine, her free hand spearing through the space between them and schlicking its way wetly into the kitty-cat’s cunt.  The cat yowls in pleasured shock, and unthinkingly removes her hands from your " + player.genderText("cock", "cunt", "cock and cunt") + ", apparently so she can brace herself on the floor with greater ease.\n\n");
			outputText("No longer held down by Kath, a devilish plan forms on your mind, and you quickly put it into motion.  Releasing Urta’s cock and pulling your finger out of her pussy, you quickly " + (katherine.hasBalls() ? "reach for Kath’s balls to give them a fondle," : "slide the slick digit into Katherine's ass, rubbing her prostate") + " while your femcum-slick hand grabs Urta’s cock, giving it a squeeze and a pump.  Both girls gasp and you brace for the oncoming onslaught.\n\n");
			outputText("Kath cums first; whether because Urta is that good or because she’s just that inexperienced with being masturbated, you can’t say.  She arches her back and lets out a very feline shriek of ecstasy, her body quaking as her feminine orgasm pours onto the floor under her, wetting her ass with her sexual leavings, while gouts of cum spray from her " + katherine.cockMultiple("", "twin ") + katherine.cockType("pointy-tipped", "barbed") + " prick" + katherine.cockMultiple("", "s") + ".\n\n");
			outputText("Urta, meanwhile, manages to hold it a little longer, but even as the first few splatters of Kath’s kitten-cum land on her black-nippled breasts, the vulpine herm is launching her own assault, great gobbets of jizz belching from her cock-head, spraying right across Kath’s face and breasts and oozing down to paint her stomach.  Meanwhile, Kath ");
			var kathCumQ:int = katherine.cumQ();
			if (kathCumQ < 500)
				outputText("stains Urta’s two-toned breasts with her creamy silver jizz");
			else if (kathCumQ < 1500)
				outputText("soaks Urta from the waist up with her prodigious orgasm");
			else outputText("utterly covers her from head to toe with her massive eruption of spooge");
			outputText(", yowling in pleasure and uncaring of the fact she’s getting Urta’s salty spunk in her mouth.  By sheer coincidence, the bulk of their orgasms land on each other, rather than on you.\n\n");
			outputText("Laughing, you grin at the cum covered beauties in front of you, thankful to have come out of this little show of theirs fairly unscathed.  Gloating and puffing your chest, you proudly declare yourself the winner of this little contest.\n\n");
			outputText("“<i>You cheated, " + player.short + "!</i>” Urta complains.\n\n");
			outputText("“<i>Yeah, what she said!</i>” Kath agrees.\n\n");
			outputText("Cheated!?  Feigning hurt, you tell them you would never do something like that!  Especially not when it involves a special prize, such as their undivided attention as they focus on YOUR orgasm... speaking of which...  you will be taking your prize right now if they don’t mind.  Getting up and stepping up towards Urta and Kath you raise a brow as if questioning when they intend to get started.\n\n");
			outputText("They look at each other, look at you, then look at each other again and grin.  “<i>Alright... if you insist...</i>” they say, their tones ringing with blatantly false innocence, before they suddenly get on all fours, slinking towards you.  Uh oh... you barely have time to turn tail and run before you see a pair of blurs, one " + katherine.catGirl("of pale flesh and " + katherine.hairColor + "hair", "black") + " and the other " + katherine.catGirl("gray", "of gray fur") + ", jump right at you; with a scream you’re dragged to the ground in a frenzy of cum-slickened limbs, touched, caressed, and kissed.  You moan as a pair of lips close on your own, so overwhelmed you are that you can’t tell who it is until a canine tongue intrudes upon your mouth.  You kiss Urta back with abandon; moments later she breaks the kiss, only for her lips to be replaced with Kath’s as she kisses and humps you.\n\nYou feel the cum soaking their bodies rubbing off on your own, their breasts massaging your " + (player.hasBreasts() ? player.breastDescript(0) : "chest") + ".  For a moment you feel utter bliss, and then ");
			if (player.hasCock() && player.hasVagina()) { //Herm
				outputText("you're overcome.  Your pussy and hips lock up and you dribble femcum as Urta and Kath's efforts pay off.  You feel hot liquid rushing up from your " + (player.balls > 0 ? "balls" : "prostate") + ", then an explosion...\n\n");
			}
			else if (player.hasVagina()) { //Female
				outputText("you're overcome.  Your pussy and hips lock up and you dribble femcum as Urta and Kath's efforts pay off.\n\n");
			}
			else { //Male
				outputText("an explosion...\n\n");
			}
			if (player.hasCock()) { //Male or herm
				if (player.cumQ() < 500)
					outputText("Rope upon rope of hot, white jism erupts from your [cocks] arching through the air to fall back on the three of you.  Adding another small layer of white to your entwined bodies.  Urta and Kath both look at you with wanton eyes, and you know this isn’t finished yet...");
				else if (player.cumQ() < 1500)
					outputText("A fountain of cum sprays into the air, raining down upon you and your lovers.  Your [cocks] twich against the lovely ladies, rubbing you all over.  With a groan you force one last spray out of your cock.  You see the white rope of cum arch and fall, heading towards your face only to be stopped by Kath’s head as she kisses you once more; the rope splattering against the back of her head, only to be licked off by Urta, who eyes you with hunger still...");
				else outputText("A veritable eruption soars forth from your [cocks] spurting so far up, you fear you might end up painting the ceiling; a continuous rope of white spunk falls over you and your lovers, further contributing to the mess and hosing their bodies down with your own orgasm.  You can’t help but look up in bliss, moaning as the girls take turn licking your body and face, until finally, one last spray falls on your chin, only to be licked off by a pair of tongues, who proceed to fight for the last in a kiss, each trying to one-up the other and catch the last drop of cum.  You don’t know who wins... but moments later, they look at you with hunger in their eyes... even after all this, they are not sated yet...");
			}
			outputText("The two morphic herms moan and growl lustily, eagerly rubbing their stiff, mismatched dicks across your stomach, your " + (player.hasBreasts() ? player.breastDescript(0) : "chest") + ", your [hips]");
			if (player.hasCock()) outputText(" and especially against your " + player.cockDescript());
			outputText("; pressed up against you like they are, you can feel their cocks pulsing, their balls swelling...\n\n");
			outputText("Urta cums first, giving a lusty howl as she paints you white with her thick, sloppy fox-seed, her apple-sized balls drawing up into her crotch as she does her best to squeeze a nice, big, wet orgasm over you.  Kath throws back her head with a feral yowl as she follows suit, ");
			if (kathCumQ < 500)
				outputText("her contribution lost amidst the cascade of Urta’s fox-jizz");
			else if (kathCumQ < 1500)
				outputText("her load just as big as Urta’s, ensuring you are utterly soaked in mis-dicked herm spunk");
			else outputText("her huge balls dredging up a load so massive it washes Urta’s cum right off your body");
			outputText(".  With twin moans of tired relief, the two girls flop, none-too-gently, onto your cum-soaked body, splattering jizz everywhere and instinctively snuggling against you, one face cuddling into either crook of your neck.\n\n");
			outputText("You hug the girls close, enjoying your shared afterglow.  Panting as you fight to remain awake.  Looking down, you see the sleeping visage of both Urta and Kath, snuggled tightly against you, and you smile.  Well... it doesn’t seem like you’re going anywhere... so might as well as let go and join them...");
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(false);
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] += 2;
			urta.urtaLove(1);
			if (flags[kFLAGS.KATHERINE_UNLOCKED] != 3) {
				if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
				doNext(camp.returnToCampUseOneHour); //An additional scene plays afterward if Kath is still being trained by Urta
			}
		}
	
		public function threeSixtyNine():void {
			clearOutput();
			if (katherine.isAt(Katherine.KLOC_BAR) || katherine.isAt(Katherine.KLOC_BAR_DRUNK))
				outputText("You drag the " + (katherine.hasCock() ? "eager herms" : "lusty pair") + " to one of the backrooms.  Urta locks the door");
			else outputText("Urta grabs Kath from behind");
			outputText(" and gets to work exposing every inch of Kath’s body.  You put on a little show of taking off your clothes, which both Kath and Urta appreciate.\n\n");
			outputText("Once the three of you are naked Kath drops to her knees and sucks Urta’s cock into her mouth.  Urta gives her a pat on the head and starts to scratch Kath’s ears which causes Kath to start teasing the tip with her rough tongue - if Urta’s reaction is anything to go by.\n\n");
			outputText("Urta allows herself to sink to the ground, Kath taking her cock deeper and deeper as she descends.  You move closer and ask Urta if she plans to ‘thank’ Kath.  She gives you a wolfish grin and twists around until she’s lying in the opposite direction.  She grabs ");
			if (katherine.hasCock())
				outputText(katherine.cockMultiple("Katherine’s cock", "the lower of Katherine’s cocks") + " and rolls her tongue around its head.\n\n");
			else outputText("Katherine's hips and buries her tongue in that wet pussy.\n\n");
			outputText("Kath moans and tries to thrust her hips forward but Urta holds her back.  " + (katherine.hasCock() ? "While she continues to toy with Kath’s cock Urta uses her other hand to slip a couple of fingers into Kath’s pussy.  Not to be outdone Kath returns the favor" : "While her tongue explores the depths of Kath's love tunnel Urta rubs her nose against Kath's clit.  Not to be outdone Kath jams her fingers into Urta's slick cunt") + ".  In no time it’s like they’re locked in combat - each trying to force the other to lose control" + (katherine.hasCock() ? "; trying to push their shaft deep down the other’s throat" : "") + ".\n\n");
			outputText("Of course it would be rude of you not to offer some ‘encouragement’.  You get behind Katherine and motion to Urta so she knows what you’re up to.  She grins");
			if (katherine.hasCock())
				outputText(katherine.cockMultiple(" and sucks on Kath’s prick", ", switches to Kath’s other cock and sucks on it"));
			else outputText(" and traps Kath's clit between her thumbs, forcing it to stand proud so she can suck on it");
			outputText(" like it’s a lollipop.  While Kath is distracted you come from behind and force your shaft between her thighs.  Urta " + (katherine.hasCock() ? "uses her hand to guide" : "pulls her tongue out at the last second, guiding") + " you into Kath’s quim and you feel the cat " + katherine.catGirl("girl", "morph") + " stiffen up.\n\n");
			outputText("You start to enjoy the feeling of filling Kath while watching her suck on Urta’s shaft.  Kath’s grip on the base of Urta’s shaft starts to weaken and with every thrust her lips go further and further down until she’s able to lick Urta’s balls.\n\n");
			outputText("Looking over Kath’s shoulder you can see that Urta has thrown her head back to moan.  That’s a little inconsiderate given what Katherine is doing for her.  You pull out, swap sides, and before Urta realizes what’s going on you push your cock between her thighs and plunge into her depths.  Urta lets out a little “<i>Ah!</i>” and goes back to licking Kath’s " + (katherine.hasCock() ? "cockhead" : "pussy") + ".\n\n");
			outputText("With your shaft inside Urta you get to watch and feel the lust overcome her.  The combination of your cock and Kath’s delightful tongue soon drive Urta over the edge and she ");
			if (katherine.hasCock())
				outputText(katherine.cockMultiple("sucks down Kath’s entire cock in one fluid motion", "surprises you by gobbling both of Kath’s shafts") + ".\n\n");
			else outputText("starts slurping and sucking on Kath's pussy like she's dying of thirst.\n\n");
			outputText("With all the stimulation Urta is the first to cum, her dick exploding into Kath’s throat.  Kath holds it deep inside and you see her stomach swell with Urta’s spooge.");
			if (katherine.pregSize() > 0) outputText(" Even her pregnancy is eclipsed by the volume of cum Urta pumps out.");
			outputText("\n\nThe feeling of being filled must have been enough to push her over the edge because Kath ");
			if (katherine.hasCock())
				outputText("thrusts forward, nearly driving her knot" + katherine.cockMultiple(" past Urta’s lips.  It", "s past Urta’s lips.  With two shafts to carry the load it") + " doesn’t take long before Urta’s belly starts to round as well.  The two herms start to look like a yin and yang symbol, but");
			else outputText("locks her legs around Urta's head.  A vacant, pleased expression crosses Kath's face as she tongues Urta's balls, coaxing out every last drop.  Now");
			outputText(" after that display you’re desperate to add your contribution.\n\n");
			var canImpregUrta:Boolean = (flags[kFLAGS.URTA_FERTILE] == 1) && (!urta.pregnancy.isPregnant);
			var doKath:Boolean;
			if (katherine.fertile && (katherine.pregSize() == 0)) {
				if (canImpregUrta) doKath = (rand(2) == 0);
				else doKath = true;
			}
			else {
				if (canImpregUrta) doKath = false;
				else doKath = (rand(2) == 0);
			}
			if (doKath) outputText("You pull out and switch back to Kath.  She’s so relaxed and so wet that your cock slides back inside easily.  You only need to give her a few strokes before you feel her tunnel clenching as Katherine starts into a second orgasm.  ");
			outputText("You bury yourself to the root and give " + (doKath ? "Kath" : "Urta") + " all you’ve got, filling her with your seed.  ");
			if (player.cumQ() < 1500) {
				if (!doKath && !katherine.hasCock())
					outputText("Urta's flat belly swells to match Kath's.  Your girls start to look like a yin and yang symbol, but your cum went where it counts.");
				else outputText("It’s barely noticeable compared with the load " + (doKath ? "Urta" : "Kath") + " pumped into her belly, but your cum went where it counts.");
			}
			else outputText("Your overpowered " + (player.balls > 0 ? "balls produce" : "prostate produces") + " jet after boiling jet of cum.  ");
			if (doKath || katherine.hasCock()) outputText("You feel a bit of resistance - after all there’s little space left for " + (doKath ? "Katherine" : "Urta") + "’s belly to expand.  ");
			outputText("Most of your load ends up shooting back out of " + (doKath ? "Kath" : "Urta") + "’s pussy, covering you, her and the floor with a massive puddle of sperm.");
			outputText("  You give " + (doKath ? "Kath" : "Urta") + "’s belly a little pat and she moans appreciatively.\n\n");
			outputText("You pull free and roll away.  It’s not that you want to, but you’ve got things to attend to.  " + (katherine.hasCock() ? "The two herms" : "Kath and Urta") + " separate and lie back on the floor exhausted.  As you pass them, heading for the door, you notice they’re holding hands.  It’s actually quite a romantic scene.");
			if (!doKath) urta.knockUpUrtaChance();
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(false);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			urta.urtaLove(1);
			if (flags[kFLAGS.KATHERINE_UNLOCKED] != 3)
				if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		public function roastYou():void { //Not available if Kath has no cock
			clearOutput();
			if (katherine.isAt(Katherine.KLOC_BAR) || katherine.isAt(Katherine.KLOC_BAR_DRUNK))
				outputText("You lead the horny herms toward one of the bar’s backrooms.  You get inside and lock the door but as you turn around Urta jumps you from behind, twisting your arm and pulling you to the floor.  Kath laughs and starts helping Urta as she removes your clothes.\n\n“<i>You’re too slow today " + player.short + ".  I’m horny as anything and I can tell from her scent that Katherine is dying for a good fuck too.  Just relax and we’ll take really good care of you.</i>”");
			else {
				outputText("You start to move towards the door.  It’s not that you don’t want to help Kath, but you really ought to get back to camp.  You think Urta is still distracted by Kath, who is now running her fingers along her sides seductively.\n\n");
				outputText("Urta spies you edging toward the door and decides to demonstrate the voice of authority to both of you.  “<i>Katherine, " + player.short + "!  Hold it right there!</i>” she shouts, causing both you and Kath to pause.  Then Urta launches herself your way.  You manage to dodge clear, but Urta slams bodily into the door, blocking it.  She grins like a fox that just woke up inside the henhouse.\n\n");
				outputText("“<i>OK, Kath - subdue the perpetrator.</i>”  You look around just in time to get pounced by Kath.  She’s horny too and isn’t pulling her punches.  “<i>Ha ha, yeah, she’s really getting good at catching her prey,</i>” says Urta, standing over the two of you.\n\n");
				outputText("Urta grabs your arms while Kath gets to work removing your clothes.  You’re so close you can see the precum oozing from the tip of Urta’s cock and wetting the lower part of her shirt.  Urta whispers “<i>You come in here, you get us both warmed up and then you try to sneak out?</i>”\n\n");
				outputText("Katherine chimes in with “<i>Yeah, what gives?</i>”  Urta looks you in the eye and says “<i>This is our turn.  I’m going to feed you this monster and Kath is going to fuck ");
				if (!player.hasVagina())
					outputText("your ass");
				else outputText(katherine.cockMultiple("your pussy", "both your pussy and your ass"));
				outputText(".  May Marae help your innards.</i>”");
			}
			outputText("\n\nYou’re not in a position to argue.  Once you’re naked Urta sits on top of you and ");
			if (player.biggestTitRow() > BREAST_CUP_DD)
				outputText("massages the sides of your breasts");
			else if (player.balls > 0)
				outputText("massages your nutsack");
			else if (player.hasVagina())
				outputText("runs her finger up and down your slit");
			else outputText("plays with your asshole");
			outputText(", warming you up.  Soon you see the last of Kath’s clothes hit the wall in front of you and the head");
			if (katherine.cockNumber > 1) 
				outputText("s of her cocks press firmly against " + (player.hasVagina() ? "both your holes" : "your ass"));
			else outputText(" of her cock presses firmly against your " + (player.hasVagina() ? "cunt" : "ass"));
			outputText(".\n\nKath pushes your legs apart with her knees and starts to force ");
			if (katherine.cockNumber == 1)
				outputText("her " + katherine.cockLength + " inch " + katherine.cockType("doggy dick", "cat cock") + " into your " + (player.hasVagina() ? "pussy" : "rectum"));
			else if (player.hasVagina())
				outputText("her twin " + katherine.cockType() + " shafts into your body");
			else outputText("her " + katherine.cockType() + "  cocks into your body, caring little that your ass wasn’t built to take her twin " + katherine.cockLength + " inch shafts");
			outputText(".  Kath gets a firm grip on your hips and starts to rock gently, slowly opening you up.  From her purring you know she’s enjoying every second.\n\n");
			outputText("Now that Kath has you in hand Urta stands and starts to strip, teasing both you and Kath as she exposes herself.  Even when she’s naked she continues, stroking her cock with one hand and lifting her balls out of the way with the other to give you and Katherine a good look at her soaking wet twat.\n\n");
			outputText("Kath pushes a little deeper before pulling you off the floor and onto your hands and knees.  “<i>Don’t be a tease Urta, give " + player.mf("him", "her") + " all you’ve got!</i>”  Urta gives you a grin, grips her cock tightly near the base and pulls her fingers up its length slowly, forcing out a hefty supply of pre.  She gets to her knees in front of you and smears the pre up and down the length of her shaft.\n\n");
			outputText("She moves close enough and gestures toward her glistening horsecock.  “<i>Salted enough for your tastes?</i>” she asks.  By now Kath’s " + katherine.cockMultiple("shaft has done its work", "twin shafts have done their work") + " and you’re too horny to resist.  You wrap your mouth around Urta’s spooge cannon and suck on it like a hot, meaty saltlick.\n\n");
			outputText("“<i>Oh yeah, that’s a good " + player.mf("boy", "girl") + "!</i>” Urta shouts, loud enough for " + (katherine.isAt(Katherine.KLOC_BAR) || katherine.isAt(Katherine.KLOC_BAR_DRUNK) ? "anyone at the bar" : "people on the street") + " to hear.  The two herms start to work in tandem - Kath pulling out as Urta shoves her cock deeper and then Urta pulling back far enough for you to tongue the tip of her cock while Kath sinks in up to her knot" + katherine.cockMultiple("", "s") + ".\n\n");
			outputText("They keep up this pace until you decide to push some of Urta’s buttons.  Reaching up blind your hand finds her balls and you begin to rub her sperm filled sack.  Urta shudders, reverses herself and thrusts forward at the same time as Kath.  All of a sudden you’ve got a foot of horsecock down your throat and Katherine’s " + katherine.cockType() + katherine.cockMultiple(" shlong", " meatsticks") + " buried knot deep in");
			if (!player.hasVagina())
				outputText(" your ass");
			else if (katherine.cockNumber > 1)
				outputText(" both your other holes");
			else outputText("side your cunt");
			outputText(".\n\nAfter that it’s a wild ride.  Kath and Urta start hammering in and out, concentrating on cumming.  You get used as a living cocksleeve and you enjoy it.  Urta’s monster cock is so wide and thrusts in and out so quickly that it overwhelms your gag reflex, your throat deciding that it’s normal to be packed full of salami.  Down below, Kath’s ");
			var wasButtStretched:Boolean = false;
			if (katherine.cockNumber > 1) {
				if (player.hasVagina()) {
					wasButtStretched = player.buttChange(katherine.cockArea(), false);
					outputText("knots seat themselves inside both your pussy and ass");
				}
				else {
					wasButtStretched = player.buttChange(2 * katherine.cockArea(), false);
					outputText("twin knots hammer against your sphincter.  At last it gives out and opens wide, allowing first one, then the other inside.  They puff up to full size, stretching your tortured ass " + (wasButtStretched ? "even wider" : "to its limit"));
				}
				outputText(", sealing you up");
			}
			else {
				if (player.hasVagina())
					outputText("knot slides inside your pussy and expands to full size just as nature intended, sealing up your pussy");
				else {
					wasButtStretched = player.buttChange(katherine.cockArea(), false);
					outputText("knot squeezes past your sphincter and pops into your rectum.  It quickly expands to full size, sealing up your colon");
				}
			}
			outputText(" for her coming deposit" + (player.hasVagina() && !player.isPregnant() ? " and ensuring your uterus will be awash with her seed" : "") + ".\n\n");
			if (player.hasVagina()) if (player.cuntChange(katherine.cockArea(), true)) outputText("\n\n");
			if (wasButtStretched) {
				player.buttChangeDisplay();
				outputText("\n\n");
			}
			outputText("A little twitch in Urta’s balls tells you she’s ready to fire.  As encouragement you find her pussy by feel and twist her clit between your fingers.  Urta grabs your head in both hands and yanks, pressing your " + (urta.pregnancy.isPregnant ? "forehead against her swollen belly" : "face against her groin") + ".  The first load creates such a bulge in Urta’s cock that it actually forces your jaws open even wider.  With her cock so far down your throat all her cum shoots straight into your stomach, bloating you until you look " + (player.isPregnant() ? "like you’re a few months further along than you are" : "several months pregnant") + ".\n\n");
			outputText("Urta falls back on the floor, letting you cough up some cum and take a few breaths.  “<i>Whew!</i>” she says, wiping her brow, “<i>that was great.  Looks like we really stuffed you.</i>”  Then her eyes shift upward and she says “<i>Oh. I guess I really stuffed you.  Kath hasn’t cum yet.</i>”\n\n");
			outputText("Kath rocks her knot" + katherine.cockMultiple("", "s") + " back and forth and whines.  Urta grins like a wolf and says “<i>You can do it Kath.  " + player.short + " asked for it, now give it to " + player.mf("him", "her") + ".</i>”  Urta stands on wobbly legs and moves out of sight.  You’re still so full and out of breath that you can’t do anything to stop her, even if you wanted.\n\n");
			outputText("You hear a surprised “<i>Oh</i>” from Katherine.  Then Urta’s voice, low and sexy, “<i>");
			if (katherine.ballSize > 0)
				outputText("These balls of yours are so nice and full");
			else outputText("Mmmm, your prostate is just so hot and swollen");
			outputText(".  So much cum, don’t you want to let it all go?</i>”\n\n");
			outputText("Kath whispers, “<i>Please help me,</i>” so quietly that you can barely hear her.\n\n");
			switch (player.gender) {
				case  0: //Genderless
					outputText("“<i>Yes, of course I’ll help you,</i>” says Urta.  You don’t know what she’s doing back there, but you can hear Katherine’s breaths getting faster and sharper.  “<i>Kath, I’m going to keep milking your prostate until you pump every drop inside " + player.short + "’s ass to remind " + player.mf("him", "her") + " how much fun genitals can be.</i>”\n\n");
					outputText("Kath’s " + katherine.catGirl("nails", "claws") + " dig into your hips and you feel jet after jet of cum filling your colon.  Combined with the load Urta pumped into your belly it bloats you enough to make you feel green.  Yet at the same time the pulsing cock" + katherine.cockMultiple("", "s") + " buried in your ass finally grant you release and you cum and cum, your featureless crotch tingling with pleasure.");
					break;
				case  2: //Female
					outputText("You feel Urta’s hand between your legs.  She takes hold of your clit, just as you did to her.  “<i>Yes, of course I’ll help you,</i>” says Urta, gently rolling your clit between her fingers.  “<i>You just need a little something - like " + player.short + "’s wonderful pussy " + katherine.cockMultiple("squeezing your cock", "and tight little bum squeezing your cocks") + " as she cums.</i>”\n\n");
					outputText("Urta’s playful fingers quickly cause you to cum and, as Urta predicted, your orgasm triggers Kath’s.  " + (player.hasCock() ? "Your own cock sprays the floor uselessly while Katherine" : "With one last mighty heave she") + " buries her cock" + katherine.cockMultiple("", "s") + " just a tiny bit deeper.  Then the flood begins.  Already stuffed with Urta’s load your belly expands even further.  Your " + (player.isPregnant() ? "birth canal" : "womb") + katherine.cockMultiple(" throbs", " and colon throb") + " painfully in protest but with Kath’s knot" + katherine.cockMultiple("", "s") + " mercilessly blocking the exit" + katherine.cockMultiple(" it has", "s they have") + " no choice but to take every drop.");
					break;
				default: //Male or Herm
					outputText("Urta’s fingers wrap around your cock.  Ignored until now it jumps at the attention.  “<i>Yes, of course I’ll help you,</i>” says Urta, softly stroking your member.  “<i>You just need a little something - like " + player.short + "’s tight little bum squeezing your cock" + katherine.cockMultiple("", "s") + " as he cums.</i>”\n\n");
					outputText("Urta’s playful fingers slide up and down your shaft.  You were already on edge and the added pleasure soon causes your " + (player.ballSize > 0 ? "balls" : "prostate") + " to tighten, spraying your load across the floor uselessly.  As Urta predicted, your orgasm triggers Kath’s.  With one last mighty heave she buries her prick" + katherine.cockMultiple("", "s") + " just a tiny bit deeper.  Then the flood begins.  Already stuffed with Urta’s load your belly expands even further.  Your colon throbs painfully, but with Kath’s knot" + katherine.cockMultiple("", "s") + " mercilessly blocking the exit it has no choice but to take every drop.");
			}
			outputText("\n\nKath collapses on top of you, spent.  Urta twists you around enough to give you and Kath each a kiss.  “<i>Thanks " + player.short + ", that’s exactly what I needed.</i>”\n\n");
			outputText("“<i>Me too,</i>” purrs Kath as she snuggles up against your back for a nap.  You stick around long enough for " + katherine.cockMultiple("Katherine’s knot", "Kath’s knots") + " to slide out, then you’re on your way - leaving Kath and Urta to take care of each other.");
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(false);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			urta.urtaLove(1);
			if (flags[kFLAGS.KATHERINE_UNLOCKED] != 3)
				if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		public function spitroastKath():void { //Works for all except genderless characters
			clearOutput();
			var atBar:Boolean = katherine.isAt(Katherine.KLOC_BAR) || katherine.isAt(Katherine.KLOC_BAR_DRUNK);
			if (atBar)
				outputText("You lead the " + (katherine.hasCock() ? "horny herms" : "lusty pair") + " toward one of the bar’s backrooms.  You get inside, lock the door and when you turn around you see that Urta has grabbed Kath from behind to make sure she couldn’t jump you.");
			else
				outputText("Urta grabs Kath from behind, locking her arms so she can’t advance on you.");
			outputText("  Never one to look a gift horse in the mouth you start to play with Kath’s nipples " + katherine.clothesChoice("through her " + (atBar ? "blouse" : "uniform"), "through the thin fabric of her bodysuit", "through her top", "through her silken robe", "by reaching inside her tube top", "by reaching inside that sexy nurse’s outfit") + ".  Kath's " + (katherine.breasts.lactating() ? "teats start leaking cream, her " : "") + "knees soon buckle and Urta has to go from holding her back to holding her up.\n\n");
			outputText("Even though you’re only playing with Katherine’s nipples you hear both your girls start to moan.  It seems that Kath’s fine ass is grinding against Urta’s horsecock.  Your fox has probably already started to leak.  When you begin stripping Kath’s clothes off Urta is eager to help and the two of you bare the " + katherine.catGirl("cat girl", "feline") + " in record time.\n\n");
			outputText("You put Kath back in the same position as before and Urta ");
			if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] <= 15) { //They’ve had little or no sex together sober
				outputText("looks uncomfortable, trying to keep her cock from rubbing against Kath’s ass or pussy.  You give her a smile and place her shaft against Kath’s opening.  Kath lets out a very happy purr and tries to angle her pussy for better access.  Urta gives in, closes her eyes and allows Kath to sink down the length of her shaft");
			}
			else if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] <= 31) { //They’ve had sex a lot
				outputText("allows her cock to slide against Kath’s pussy lips.  With an encouraging nod from you Urta slips it inside and Kath squirms in her arms, trying to pull herself down onto Urta’s massive member");
			}
			else { //They’re lovers
				outputText("gives you a big smile as she pulls Kath down onto her shaft, impaling her.  Kath twists around and gives Urta a kiss before looking back to you expectantly.  A giant sized horsecock between her folds just isn’t enough for Kath these days - she wants you both");
			}
			outputText(".\n\nSince Kath isn’t going anywhere Urta grabs her " + katherine.catGirl("smooth", "fuzzy") + " hips and controls the pace.  Kath starts playing with her own nipples, giving you a show.  In return you tease them both by slowly stripping off your gear.  When you’re completely naked you start to rub Kath’s ears and use them to gently pull her head lower and lower until ");
			if (player.isTaur())
				outputText("her back is horizontal.  You carefully step over her, closing the distance with Urta until you feel your submissive pussy cat " + (player.hasCock() ? "swallow the tip of your cock" : "latch onto your cunt like a remora") + ".  You pull Urta in for a kiss and think to yourself that this is how a centaur was meant to fuck");
			else
				outputText("her mouth is lined up with your " + (player.hasCock() ? "cock" : "pussy") + ".  Your submissive pussy cat doesn’t need any instruction to " + (player.hasCock() ? "swallow the tip of your cock" : "slam her tongue into the depths of your pussy"));
			outputText(".\n\nUrta thrusts and drives Katherine’s ");
			if (player.hasCock())
				outputText("lips down your shaft. " + (player.longestCock() >= 12 ? " Despite your length" : ""));
			else
				outputText("face into your groin. ");
			outputText(" Kath takes it without complaint and her rough tongue does wonders for your mood and " + (player.hasCock() ? "member" : "your moist cunt") + ".\n\n");
			outputText("Urta really gets into it - she places your hands on her breasts and starts to fuck Kath as though it’s life or death.  " + (player.isTaur() ? "You’re not used to having a lover in front of you anymore and the added stimulation" : "The rocking motion along with Katherine’s eager tongue") + " brings your climax more quickly than you thought possible.\n\n");
			if (!player.hasCock())
				outputText("Kath laps at your pussy, drinking your juices as fast as you can produce them.  Every time you think your orgasm is over she draws the whole length of her tongue over your clit and gives you another.  She only stops when your legs give out and you collapse" + (player.isTaur() ? ", falling to the side to avoid crushing her" : " on top of her"));
			else {
				outputText("You pull Urta towards you so that Kath takes your whole length.  ");
				if (player.cumQ() < 500)
					outputText("After a few good squirts you feel like you need a nap to recover.  Kath thanks you by wrapping her skilled tongue halfway around your shaft and licking up every drop");
				else if (player.cumQ() < 1500)
					outputText("You deliver squirt after squirt of hot cum down Kath’s gullet.  She drinks every drop like a good kitty and you wish you could see the look on her face as she cleans up your cock with that skilled tongue of hers");
				else if (player.cumQ() < 3000)
					outputText("The firehose of cum you shoot down Kath’s throat would be too much for any normal person to swallow.  Good thing your cockhead is closer to her stomach than to her lips.  You feel backpressure, but Kath’s stomach is no match for your magically enhanced " + (player.ballSize > 0 ? "balls" : "prostate") + ".  When it’s over Kath has to gulp down quite a bit of cum that bubbled back up her throat");
				else
					outputText("The torrent of cum that you blast down Kath’s throat is so powerful that you feel panicked scrabbling from beneath you.  It’s too late, the only way it can go is in.  You " + (player.isTaur() ? "feel Kath’s ass and back press up against your belly and you realize" : "watch her belly stretch and stretch until") + " she’s so full her belly is resting against the floorboards.  When it’s over Kath has to gulp down quite a bit of cum that bubbled back up her throat");
			}
			outputText(".\n\nWhen you recover you rub Kath’s thigh appreciatively but your display only drives Urta to fuck her even harder.  Between you Kath’s tail flicks back and forth, so you grab it and start massaging it near the base.  Kath pushes back against Urta and you see Urta’s eyes roll back.  ");
			if (katherine.hasCock()) outputText("A hot spray of cum lands on and around your " + (player.isTaur() ? "rear " : "") + (player.isNaga() ? "tail" : "feet") + ".  ");
			outputText("Kath just came and if you had to guess her clenching pussy sent Urta over the edge.\n\n");
			if (!player.hasCock() || player.cumQ() < 3000)
				outputText("Sure enough you " + (player.isTaur() ? "feel Kath’s ass and back press against your belly and you realize" : "watch her belly stretch and stretch until") + " she’s so full her belly is resting against the floorboards");
			else
				outputText("It would be difficult enough for Kath to take Urta’s load but her belly already holds several buckets of your cum.  There’s no escape and you " + (player.isTaur() ? "feel" : "see") + " her belly expand even further.  Urta pulls back on Kath’s hips hard enough to leave marks, driven by a deep urge to breed Katherine’s velvet pussy.  When her strength fails her Urta falls back and a thick stream of semen erupts from Kath’s cunt");
			outputText(".\n\nUrta pants like she’s just run a marathon and Kath" + (player.hasCock() ? ", her mouth still occupied by your shaft," : "") + " just moans contentedly.  You’re quite happy yourself and sit down with them for a minute to rest.\n\n");
			outputText("Urta doesn’t say anything but she laces her fingers with yours and rests your entwined hands on top of Kath’s bulging belly.  Kath puts her arms around you both and you soon hear snoring from your exhausted friend.  Urta offers to stay with Kath and clean up the mess so you leave her to it.  You’d love to stay but duty calls.");
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(false);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			urta.urtaLove(1);
			if (flags[kFLAGS.KATHERINE_UNLOCKED] != 3)
				if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		public function pinAndFuck():void { //Kath is sober, Urta is drunk //Not available if Kath has no cock
			clearOutput();
			outputText("When you get to Urta’s table she pulls you both in for a hug and takes the opportunity to bury her head between Katherine’s breasts" + (player.hasBreasts() ? " and then between yours" : "") +".  Not wanting to fuck your herms at the table you get Urta’s attention by tugging on her ear and motion at one of the vacant backrooms.  The drunken fox herm gets up and wanders toward the door, her arms around you both.  It’s not for support but so that she can grope all your favorite bits.  On Urta’s other side you can see Kath smiling as Urta massages the base of her tail.\n\n");
			outputText("Once the three of you get inside the room together Urta gets aggressive.  She shoves both you and Kath against the wall and starts trying to pull your clothes off.  As she concentrates on " + katherine.clothesChoice("unbuttoning Kath’s blouse", "sliding her hands inside Kath’s bodysuit", "unlacing Kath’s dress", "pulling the robe off Kath’s shoulders", "slipping the stretchy tube top over Kath’s head", "reaching inside the nurse’s top to grope Kath’s breasts") + " you decide that today Urta won’t be setting the pace.\n\n");
			outputText("You sweep her legs out from under her and she falls sideways into your arms.  Twisting her around you push Urta to the floor facedown and ");
			if (player.isTaur())
				outputText("rest your belly on top of");
			else outputText((player.isNaga() ? "quickly coil your tail over" : "kneel atop"));
			outputText(" her prone form.  She growls playfully and squirms, trying to get herself free from your grapple.  You look behind you and see that Kath has been quick to strip off her clothes.  Her throbbing cock" + katherine.cockMultiple(" stands", "s stand") + " proud in the cool air.\n\n");
			outputText("You lift Urta’s skirt and tell Kath that her captain needs some help.  She claps her hands together gleefully as you pull aside Urta’s panties.  From beneath you Urta shouts, “<i>No!  It’s my turn.  Present pussy, damn it.</i>”  She shudders as Kath’s cockhead" + katherine.cockMultiple(" brushes against her pussy, which is", "s brush against her slit and her tight sphincter.  Kath reaches under Urta, scoops a little pre from the tip of her dripping horsecock and smears it over Urta’s asshole.  Urta’s cunt needs no such attention, it’s") + " already glistening.\n\n");
			outputText("Kath gently turns your head and gives you a kiss before sheathing herself inside her captain.  Urta groans as her body is invaded" + katherine.cockMultiple(" by Kath’s " + katherine.cockType("canine", "unusual feline") + " member", ", not once but twice") + ".  You tweak Katherine’s nipples and tell her that Urta needs a rough ride.  Urta pants and looks up but she doesn’t disagree.  Kath’s fingers wrap around Urta’s waist and she starts to fuck her like a wild stallion.  Some thrusts are hard enough that Urta moves along the floor.\n\n");
			outputText("Before Kath can cum Urta grunts, tenses and a gushing sound tells you she’s just flooded her panties with a massive load of cum.  It seems you were right about prescribing a good dose of hard fucking, Urta must have needed that.  After her orgasm she’s unable to move, let alone escape, so you get up and encourage Kath, telling her to fill this fox slut");
			if (urta.pregnancy.isPregnant && urta.pregnancy.type != PregnancyStore.PREGNANCY_BEE_EGGS && urta.pregnancy.type != PregnancyStore.PREGNANCY_DRIDER_EGGS)
				outputText(".  She’s already carrying a baby in that big belly of hers, so Kath must know how much Urta loves cum.  Urta pats her belly and says, “<i>Maybe there’s room for one more");
			else
				outputText(" - she needs a womb full of seed.  Urta laughs and says “<i>" + (flags[kFLAGS.URTA_FERTILE] > 0 ? "Yeah, fill me up, maybe you’ll get to be a daddy" : "Oh please fill me up.  It’s so good"));
			outputText(".</i>”  Katherine doesn’t take long to give Urta what she wants.  Kath’s knot" + katherine.cockMultiple(" swells up and with one last hard thrust she forces it inside Urta’s abused pussy", "s swell up and with one last hard thrust she forces them inside Urta’s stretched holes") + ".\n\n");
			outputText("It looks so fucking good as Urta’s belly grows " + (urta.pregnancy.isPregnant ? "even larger than before, her pregnancy eclipsed by" : "larger and larger, trying to hold back" ) + " the ocean of cum inside her.  Urta’s whole lower body and her skirt are soaked with her own cum and now an equally large load is sloshing around inside her.  Her " + (katherine.hasBalls() ? "balls drained" : "prostate empty") + ", Kath collapses on top of Urta and gives her a hug.\n\n");
			outputText("You stroke your fingers up and down ");
			if (player.hasCock())
				outputText("your cock");
			else if (player.hasVagina())
				outputText("your slit");
			else
				outputText("the barren flesh between your legs");
			outputText(", looking over your partners.  The sight of Katherine drilling Urta has you ever so horny" + (player.hasCock() && player.hasVagina() ? ", you just have to figure out what you’re going to do about it.  Both your lovers are spent and happy, so it’s a toss up as to which one should receive your attention." : " and it’s time for you to take your fill."));
			katherine.katherineAndUrtaHadSex(true);
			katherine.orgasm();
			urta.urtaLove(1);
			if (player.hasCock()) {
				simpleChoices("Stuff Kath", pinAndFuckStuffKath, "Mount Urta", pinAndFuckMountUrta, "", null, "", null, "", null);
			}
			else doNext(pinAndFuckMountUrta);
		}

		private function pinAndFuckMountUrta():void { //Plays for anyone without a cock and for herms who select this option
			clearOutput();
			outputText("You roll Kath and Urta over so you can get access to Urta’s equine cock.  It’s a little soft but a couple of strokes along its cum slicked length start to change that.  Urta opens her eyes and tries to focus on you but you’re already " + (player.hasVagina() ? "sliding your pussy against her shaft" : "rubbing her horsecock against your anus") + ".  Underneath you both Kath lets out a happy “<i>Oh!</i>”  You’re guessing Urta’s muscles are clamping down on Kath’s cock" + katherine.cockMultiple("", "s") + ".\n\n");

			outputText("As you sink onto Urta’s cock ");
			if (!player.hasVagina())
				outputText("you enjoy the sensation of your colon stretching and straightening to take Urta’s enormous girth and length.  You feel a pulse of hot pre soaking into your deepest depths.");
			else {
				outputText("and it grinds against your cervix you ");
				if (player.isPregnant()) {
					if (player.pregnancyType == PregnancyStore.PREGNANCY_GOO_STUFFED)
						outputText("stroke your goo stuffed belly and hope your passenger enjoys the ride.");
					else if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA) //Carrying Urta’s baby
						outputText("put a hand on your belly and think about the child she’s already planted in your belly.");
					else if (flags[kFLAGS.URTA_FERTILE] > 0)
						outputText("think about the baby inside your belly.  When it’s born you really need to do this again so Urta can knock you up.");
					else
						outputText("think about the baby inside your belly and wish there was some way she could have fathered it.");
				}
				else if (player.findStatusEffect(StatusEffects.Contraceptives) >= 0)
					outputText("think about your empty womb.  Wouldn’t it feel good if Urta’s cum could impregnate you as nature intended?");
				else if (flags[kFLAGS.URTA_FERTILE] > 0)
					outputText("start to fantasize.  The masses of cum Urta produces stand a good chance of seeding you.");
				else
					outputText("lose yourself in the sensation.  You hope her big dick can fill every crevice of your pussy.");
				outputText("  You pause and feel just above your pussy where Urta’s girth stretches your flesh into a bulge."); 
			}
			outputText("  Urta starts to moan; now that her oversensitive dick is buried in your " + (player.hasVagina() ? "pussy" : "rectum") + " she’s really getting into it.  You flex the muscles of your " + (player.hasVagina() ? "vagina" : "ass") + " to please her more.  Kath helps out by reaching around Urta and playing with her nipples while you massage her balls and tell her you want to be filled.\n\n");

			outputText("Urta’s legs lock around you and she tries to force her horsecock even deeper.  You feel a bulge moving along the underside and when the hot cum erupts inside you");
			if (!player.hasVagina())
				outputText(", filling your colon like a balloon,");
			else if (player.pregnancyType == PregnancyStore.PREGNANCY_GOO_STUFFED)
				outputText("it forces its way inside your womb.  You hope the goo in you enjoys the bath.  As more of Urta’s seed fills your pussy");
			else if (player.isPregnant())
				outputText(", spattering against your cervix,");
			else
				outputText("it forces its way inside your womb.  The feeling is exquisite as your belly expands outward into a pregnant looking dome.  As more of Urta’s seed fills your pussy");
			outputText(" you kiss her and give in to your long overdue orgasm.");

			outputText("\n\nUrta puts one hand on your stretched stomach and places your hand on her own bloated belly.  She just smiles contentedly, her cock buried in your pussy and Katherine’s dick" + katherine.cockMultiple(" knotted inside her pussy", "s knotted inside her pussy and ass") + ".  She doesn’t seem to have a care in the world.  Then Kath rocks her hips.  Urta looks over her shoulder and you both see that Kath has a determined look in her eyes.\n\n");

			outputText("“<i>Again?</i>” says Urta, “<i>No, no, I can’t do it again!  I’ve already cum twice.</i>”\n\n");

			outputText("Kath laughs and continues to gently fuck Urta.  You pull off Urta’s cock and wait for her massive load to finish gushing from your " + (player.hasVagina() ? "pussy" : "ass") + " before putting on your clothes.  Before you leave you give Urta a kiss and squeeze her belly a little.  Her only reply is to moan.  You tell Kath to take good care of Urta and then leave.  You know that if you stay much longer their display will get you excited enough that you’d stay around all afternoon and unfortunately you’ve got things you need to do.\n\n");
			player.orgasm();
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 8 + rand(2);
			if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		private function pinAndFuckStuffKath():void { //Plays for any males and for herms who select this option
			clearOutput();
			outputText("When Kath flopped on top of Urta her legs spread apart and gave you a great view of " + (player.cocks.length > 1 ? "three" : "two") + " things.  Her" + katherine.cockMultiple("", " lower") + " knot, hot and hard, buried in Urta’s pussy" + katherine.cockMultiple(" and her dripping slit", ", her dripping slit and her supple sphincter, both") + " waiting for your cock.  " + (player.cocks.length > 1 ? "They look" : "It looks") + " so wet, so empty.  Neither Katherine nor Urta notice as you " + (player.isNaga() ? "slither" : "step") + " around them, position yourself behind Kath, line up your dick" + (player.cocks.length > 1 ? "s and feed them" : " and feed it") + " into Kath's body.\n\n");
			outputText("Kath may be tired but she’s still in the mood.  She clenches her pussy " + (player.cocks.length > 1 ? "and ass around your cocks" : "around your cock") + " and lets out a low moan.  You ");
			if (player.cor < 25)
				outputText("hold your cock" + (player.cocks.length > 1 ? "s" : "") + " still for a moment, letting Kath adjust her hips so she’s in a more comfortable position.  You massage the base of her tail which draws even more moans of pleasure from Kath.  When you finally start to thrust again Kath weakly tries to push her hips back toward you and her pussy " + (player.cocks.length > 1 ? "and ass do their" : "does its") + " best to pull you in deeper.");
			else if (player.cor < 75)
				outputText("start to fuck her slowly and gently but quickly build to thrusting hard and fast as your base instincts take over.  It doesn’t seem to matter to Kath, she moans and purrs happily as long as your cock" + (player.cocks.length > 1 ? "s are filling her holes." : " is filling her pussy."));
			else
				outputText("just start pounding in and out.  Kath tends to like it rough and right now you don’t really care if she enjoys it or not.");
			outputText("\n\nUnderneath both of you Urta tries to look over her shoulder to see why Kath’s cock" + katherine.cockMultiple(" is", "s are") + " rocking back and forth inside her overstuffed belly.  Kath gives her a kiss and says “<i>You like feeling " + player.short + " through me?</i>”  Urta’s eyes roll back as she realizes she’s trapped and in for a fucking by proxy.\n\n");
			outputText("Having just watched your girlfriends fuck it’s no surprise that you don’t last very long.  Your " + (player.balls > 0 ? "balls ache to add their" : "prostate aches to add its") + " contribution to Katherine’s hot pussy" + (player.cocks.length > 1 ? " and inviting ass" : "") + ".  You grab Kath’s waist and bury yourself inside as that now familiar feeling races from your " + (player.balls > 0 ? "balls, through your" : "") + " prostate and runs along your cock.\n\n");
			outputText("Your cock" + (player.cocks.length > 1 ? "s erupt inside Kath" : " erupts inside Kath"));
			if (player.cumQ() < 500)
				outputText(", your load soaking into her " + (player.cocks.length > 1 ? "pussy and ass" : "waiting pussy") + ".  Katherine just purrs and rolls slightly so she can kiss you.");
			else if (player.cumQ() < 1500)
				outputText("and you feel " + (player.cocks.length > 1 ? "little lakes of cum forming around the tips of your cocks" : "a little lake of cum forming around the tip of your cock") + ".  Her belly swells just a bit and Kath puts her hand on it, a smile on her lips.");
			else if (player.cumQ() < 3000) {
				outputText("and her body is pushed away from Urta by the sheer volume of cum you’re filling her with.  Kath gasps and uses one hand to steady herself while the other clutches her expanding belly.  ");
				if (katherine.pregSize() > 0)
					outputText("It must be particularly painful since her womb is closed for business.");
				else
					outputText("She starts to look a little pregnant as her womb " + (player.cocks.length > 1 ? " and colon" : "") + " fill with your seed.");
			}
			else {
				outputText("with such force that she has the wind is knocked out of her. ");
				if (katherine.pregSize() == 0)
					outputText("Even from behind her you can see her womb expanding, filling out as if she were eight months pregnant.");
				if (katherine.pregSize() > 0) {
					outputText("Without an empty womb to take the load from ");
					if (player.cocks.length > 1)
						outputText("your lower shaft Kath’s vagina quickly reaches its limit and you feel all your cum running down your other cock" + (player.cocks.length > 2 ? "s, blasting all over the room." : " stuffing her colon with cum."));
					else 
						outputText("your supercharged " + (player.balls > 0 ? "balls" : "prostate") + " you quickly fill her cunt to its limit, the rest of your seed blasting back against your groin.");
				}
				outputText("  The bulge in Kath’s belly is large enough to lift her off Urta, though not enough to release Katherine’s knot" + katherine.cockMultiple("", "s") + ".  Now that Kath is almost sitting upright above Urta she turns and kisses you.");
			}
			outputText("\n\nAt the bottom of the pile you hear Urta say “<i>Oh - " + katherine.cockMultiple("its", "they’re") + " getting bigger again!</i>”\n\n");
			outputText("A quick check with your fingers tells you she’s right, Kath’s knot" + katherine.cockMultiple(" has", "s have") + " returned to full strength, binding the two herms together.\n\n");
			outputText("You pull out of Kath and give her a pat on the back.  You tell Urta that there are two ways to shrink " + katherine.cockMultiple("that knot", "those knots") + " and it’s up to them to decide which to use.  Kath looks tired, but her tail wags back and forth.  Urta just groans and says, “<i>I can’t, I’m so full.</i>”\n\n");

			outputText("You lock the door on the way out, " + (flags[kFLAGS.KATHERINE_URTA_AFFECTION] >= 31 ? "knowing that with those two the sex option will eventually win out." : "hoping your sated girlfriends will bond over this."));
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		public function watch(urtaIsDrunk:Boolean):void { //Kath is sober (or drunk), Urta is drunk
			clearOutput();
			outputText("By the time you reach Urta’s table she’s downed the last of her beverage.  She stands up and gives both of you big hugs.  You feel her horsecock grind against you and you see Kath looking self-conscious after her hug from Urta.\n\n");
			watchMainBody(urtaIsDrunk);
		}

		public function watchNoIntro(urtaIsDrunk:Boolean):void { //Kath is sober (or drunk), Urta is drunk
			clearOutput();
			watchMainBody(urtaIsDrunk);
		}
	
		private function watchMainBody(urtaIsDrunk:Boolean):void { //Kath is sober, Urta is drunk
			outputText("The three of you quickly commandeer one of the back rooms.  Urta is " + (urtaIsDrunk ? "a little unsteady" : "pretty horny") + " so she sits down on a spare chair in the corner and yanks off her clothes.  You kiss Kath and concentrate on getting her naked, giving Urta a show as you " + katherine.clothesChoice("first remove her blouse and then slip off her skirt", "peel the sheer bodysuit off her lithe form", "unlace her dress and slide it off her sexy body", "undo her robe and pull it from her shoulders", "pull the tube top over her head and then " + katherine.clothesLowerChoice("peel off her tight shorts", "slip off her skirt", "", "", ""), "unbutton her tight blouse, slip off her skirt and finally pluck the cute white hat from her head") + ".  Urta’s interest is obvious from her panting and the throbbing of her horsecock.\n\n");
			outputText("Kath poses for Urta and asks, “<i>Like what you see?</i>”\n\n");
			outputText("Urta strokes her cock, smearing some pre along the shaft and says, “<i>Come over and find out!</i>”  It looks like Urta’s in the mood to put on a show so you give Kath a gentle push toward the fox.  As soon as she comes within arm’s reach Urta grabs her and pulls Katherine into her lap.\n\n");
			outputText("After a short and one sided grappling match Urta has Kath’s arms locked behind her body.  She turns Kath to face you, then pulls the cat " + katherine.catGirl("girl", "morph") + " backwards, downwards and onto her lap.  Urta’s cock now juts out from between Kath’s legs, rubbing against ");
			if (katherine.hasCock())
				outputText("the underside of Kath’s own " + katherine.cockMultiple("", "lower ") + "cock.\n\n");
			else outputText("Kath's dripping slit.\n\n");
			outputText("Kath’s a little surprised, but she recovers quickly and calls out to you, “<i>Please save me " + player.mf("mister", "miss") + ", this crazy fox is trying to have her way with me.</i>”  You decide to ‘help’ by giving Kath’s nipples a little tweak.  You laugh and sit down on another chair, thinking that this looks like it’s going to be fun.\n\n");
			outputText("Urta moans and lifts Kath high enough to plant her cockhead against Kath’s pussy.  “<i>You were asking for this all through our last shift,</i>” she growls in Kath’s ear.  Urta roughly yanks Kath back again, this time impaling her on Urta’s massive shaft.  Urta closes her eyes and starts talking to herself as she lifts Kath’s hips up and down.  “<i>Always flicking your thin black tail at me,</i>” she says, “<i>giving me that big toothy smile when you hand in your paperwork" + (flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 20 ? ", then ‘I’ll see you at the bar’, and that cute little wave goodbye" : "") + ".  Admit it - you’ve been gagging for a nice fat cock.</i>”\n\n");
			outputText("Kath just bites her lip as Urta’s jackhammering forces her hole open wider and wider.  At last the pain in her face eases up and she gives you a grin before saying, “<i>Maybe.</i>”\n\n");
			outputText("“<i>Not maybe!</i>” bellows Urta.  “<i>You’re the sexiest little kitty in the Watch and you spend all day teasing me.  Don’t give me maybe.</i>”\n\n");
			outputText("Kath has started to fuck back and she pulls Urta’s hands away from her hips.  With her cat-like flexibility she manages to turn around and face Urta while still grinding atop her cock.  “<i>Okay,</i>” she says, teasingly, “<i>maybe a lot.</i>”  She takes Urta’s hands and places them against " + (katherine.breasts.cupSize > BREAST_CUP_DD ? "the sides of " : "") + "her " + katherine.breasts.adj() + " breasts.\n\n");
			outputText("Urta looks like she’s getting close to blowing her load.  She pants “<i>Does that turn you on?  Getting your captain all hot and bothered?</i>”\n\n");
			outputText("Kath reaches between her legs and you realize she’s rolling Urta’s balls between her fingers.  “<i>Maybe,</i>” she replies again, infuriating Urta, who bites the back of Kath’s neck.  A few more deep thrusts and Urta’s hands go to Kath’s shoulders so she can pull Kath’s whole body down once more.  Her head tips back and bangs the wall.  At the same time Kath puts a hand against her belly and purrs as you watch it bulge with Urta’s copious seed.\n\n");
			outputText("Once Urta is finished Kath gives Urta a poke and says, “<i>Aren’t you going to help me?  I still haven’t got off, you know.</i>”\n\n");
			outputText("Urta raises her head just long enough to grin at Kath and say, “<i>Maybe,</i>” in a mocking tone.\n\n");
			if (katherine.hasCock()) {
				outputText("Kath looks your way and rubs one of her hard cocks but you point out that Urta just offered to help.  Katherine needs no further encouragement.  She stands up, depositing a river of cum on Urta’s lap.  Urta is too tired to resist much, so Katherine picks her up and drapes her over the chair.\n\n");
				outputText("Urta looks up at you just in time to feel Kath slip her " + katherine.cockType() + " shaft" + katherine.cockMultiple(" into her pussy", "s into her cunt and rectum") + ".\n\n");
			}
			else {
				outputText("Kath looks your way and runs one of her fingers over her breasts but you point out that Urta just offered to help.  Katherine needs no further encouragement.  She plants her feet and starts to roll her hips, grinding her clit against Urta's still hard horsecock.\n\n");
				outputText("Urta's head rolls forward again and she rubs Katherine's bloated belly.  “<i>Wasting your time kitty,</i>” she says mockingly.\n\n");
			}
			outputText("Kath is already close to cumming but she tries to hold back by taking it slow.  She whispers, “<i>You want it too.  I know cause every time I give you a smile or wiggle my bum you smile back");
			if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 20)
			outputText(" and the tip of your tail does that little wiggle you don’t think anyone notices.  And you rush through all your paperwork once you know I’ll be at the bar because you love staring at my body" + (flags[kFLAGS.KATHERINE_URTA_DATE] == Katherine.KDATE_LITTLE ? " and you’re hoping like crazy " + player.short + " will be here so we can fuck all through the night" : ""));
			outputText(".</i>”\n\nUrta gives you a smirk and says, “<i>Maybe,</i>” once more.  Kath doesn’t like getting a dose of her own medicine, so she grabs ");
			if (katherine.hasCock()) {
				outputText("the chair and pushes hard.  Urta lets out a surprised “<i>Ah!</i>” as Kath’s " + katherine.cockMultiple("knot forces its", "twin knots force their") + " way inside.  Then Kath pushes on the chair, yanking " + katherine.cockMultiple("it", "them") + " back out.  It doesn’t take long for the knot-fucking to drive Kath over the edge and she slams home one more time.  Urta’s body lifts off the chair as her belly stretches from the heavy load Kath’s pumping into her " + (urta.pregnancy.isPregnant ? "pussy" : "uterus") + katherine.cockMultiple("", "and colon") + ".\n\n");
			}
			else {
				outputText("Urta's balls and strokes them gently with her sharp " + katherine.catGirl("nails", "claws") + ".  “<i>You don't understand, foxy - I'm not done, so you're not done.  It's impolite to leave a girl wanting.  So you think about all those times I've wiggled my ass at you or 'accidentally' let my towel slip.  You've got me here and now, so no excuses, no whiskey dick.  I came here to get fucked.</i>”\n\n");
				outputText("Urta moans, but you can tell Kath's words and her clenching pussy have worked their magic.  Urta reaches up with shakey hands and gropes Kath's breasts, pulling the stuffed kitty against her.\n\n");
				outputText("“<i>That's more like it!</i>” cries Kath.  “<i>Now make me pay for being a little tease!</i>”\n\n");
				outputText("Urta shudders and her hands move back to Kath's hips.  “<i>Oh, fuck!  You're not gonna be able to walk after this.</i>”\n\n");
				outputText("“<i>Promises, promises,</i>” Kath says in a dreamy voice.  She holds her already filled belly and lets Urta do most of the work.  Then Katherine's legs give out, leaving her totally at Urta's mercy as the fox jackhammers her cunt.  You watch Kath cum half a dozen times in a row, her body held in place only by the rock-hard flagpole inside her belly.  With one last burst of energy Urta rams home and you see her balls shrink and pull upward, driving every last drop into Kath's cum crammed belly.\n\n");
			}
			outputText("You " + (player.gender == GENDER_NONE ? "rub your featureless groin unhappily, wishing you could have been part of this.  Then you" : "") + "give each of your tired lovers a kiss and tell them to look after each other.  That earns a guilty look from Urta who says, “<i>We can have any kind of sex you want next time " + player.short + " - or maybe you want to stick around and have your fill?</i>”\n\n");
			outputText("Much as you’d like to you have to check on the portal once more, so you just tell them you’re going to take them up on that offer, probably sooner rather than later.");
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(true);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			dynStats("lus", 20 + player.lib / 20);
			if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		public function kathLicksOutUrta():void { //Kath is drunk, Urta is sober
			clearOutput();
			outputText("Kath begins to twitch and pant as Urta plays with her ears, which leads her to start stroking Urta's tail.  Pretty soon a deep 'thunk' from beneath the table lets you know how much Urta appreciates the attention.  There's no need to get involved, so you smile at Urta and lean back.  You can have fun with either of them later and right now you're content to watch and see what develops as the " + (katherine.hasCock() ? "herms" : "girls") + " get more and more aroused.\n\n");
			outputText("The show gets underway when Urta lets go long enough to shift in her seat.  Apparently her cock was getting stiff enough to make her position uncomfortable.  Kath blinks out of her slightly dazed state and gives you an evil grin.  Before Urta can notice or react Kath ducks under the table and Urta's eyes go wide.  Her hands snap to her chair, holding her steady as you hear sounds of wet fabric sliding from below.\n\n");
			outputText("\"<i>Oh - oh yeah - that's a good kitty, you want to take care of my cock?</i>\" moans Urta, throwing her head back.\n\n");
			outputText("From under the table you hear Kath's reply, \"<i>Mmmmm, nope!</i>\" and then a snicker.  A thin black tail whips back and forth in front of you, brushing against your waist.  Urta wraps her fingers more tightly around the edge of her chair and bites her lip.  Whatever Kath's doing it's certainly making Urta feel good.\n\n");
			outputText("You lean down to see for yourself.  Kath is ignoring Urta's cock completely.  She's pulled Urta's panties down and her face is buried in Urta's snatch.  Urta's horsecock is still covered and is straining against the underside of the table.  You sit back up and meet Urta's eyes, now filled with lust, and ask her innocently where all her cum will go when she climaxes.\n\n");
			outputText("Urta shakes her head and tries to clear the lusty haze long enough to do something about it.  She fumbles with a condom, but drops the packet on the ground as Katherine does something naughty.  In an embarrassed whisper Urta tells her, \"<i>Just... just put a condom on me.  Please Kath.  I'll spray everywhere.</i>\"\n\n");
			outputText("The only reply from beneath the table is a long, low, \"<i>Mmmmmmmm</i>\".  Urta's jaw snaps shut and her eyes cross.  She gives up all thoughts of stopping Kath and instead her hands move to her lap, quite obviously pulling the sexy kitten's head against her groin.\n\n");
			outputText("Urta lasts longer than you expected, but she can't resist Kath's silver tongue forever.  She gasps and you hear a wet splattering noise from the table.  It goes on and on as Urta's balls release her pent up load.  Most of the bar is looking her way but Urta doesn't notice.  She convulses again and again as Kath's tongue tries to reach even deeper.  At last it ends and, to the sound of her sperm dripping onto the floor, Urta mumbles, \"<i>lovely.</i>\"\n\n");
			outputText("Kath snakes back up from under the table, her whole head wet with spunk.  She works quickly to clean herself up using her tongue and some napkins, then looks at Urta.  \"<i>Awww, I think I broke her,</i>\" she giggles drunkenly.  Say, " + katherine.playerText() + ", you wanna have some fun while one-shot here recovers?\n\n");
			outputText("\"<i>No fair,</i>\" Urta mutters weakly.\n\n");
			dynStats("lus", 20 + player.lib / 20);
			katherine.katherineAndUrtaHadSex(true);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			urta.drainedByKath = true;
			doNext(katherine.katherineSex);
		}

		public function knothole():void { //Kath is drunk, Urta is sober //Not available if Kath has no cock
			clearOutput();
			outputText("Urta scratches behind Kath’s ear and suggests slipping into one of the back rooms.  As soon as you get her inside Kath strips off her clothes and tackles Urta.  Urta is unprepared, but her combat experience is more than enough to deal with Kath when she’s drunk.  Urta laughs and easily gains control of the horny " + katherine.catGirl("cat girl", "feline") + ".  Katherine starts to struggle, so Urta sweeps her legs out from under her, presses Kath to the floor and asks if she’s going to be good.\n\n");
			outputText("Kath mutters, “<i>Yes,</i>” but keeps trying to get loose.\n\n");
			outputText("Urta just sighs and looks up at you with an expression that asks ‘will she ever learn?’  She twists Kath’s arms behind her back, but that doesn’t stop her struggling either.  Then Urta snickers to herself.  She hauls Kath along the floor toward a large knothole.  “<i>Gonna cooperate?</i>” she asks the struggling cat " + katherine.catGirl("girl", "morph") + ".\n\n");
			outputText("“<i>No!  Gonna fuck you,</i>” says Kath.\n\n");
			outputText("Urta slides her a little further forward, gets one hand free and uses it to angle Katherine’s " + katherine.cockMultiple("", "lower ") + "cock into the hole.  Kath is so surprised at suddenly having an opening around " + katherine.cockMultiple("her prick", "one of her pricks") + " that she stops struggling for a second.  Urta uses the opportunity to spread Kath’s legs and sink the rest of her length into the hole.\n\n");
			outputText("“<i>Not fair,</i>” mumbles Kath, trying and failing to get up.\n\n");
			outputText("“<i>You should start behaving,</i>” says Urta.  She sits on top of Kath’s ass, causing her tail to brush against Kath’s.  Kath squirms, but you can see between her legs and that knot is starting to swell.\n\n");
			outputText("Kath’s eyes go wide.  “<i>You wouldn’t!</i>”\n\n");
			outputText("“<i>Wouldn’t what?</i>” asks Urta in her most innocent tone.\n\n");
			outputText("“<i>Please don’t let me knot!</i>” says Kath, trying to buck hard enough to throw the fox off of her.\n\n");
			outputText("Urta reaches down and rubs " + (katherine.hasBalls() ? "Kath’s balls" : "the base of Kath’s cock") + ".  “<i>I think it’s a bit late to ask me that,</i>” Urta replies.  Kath groans and thumps her fist against the ground.  With the cat " + katherine.catGirl("girl", "morph") + " trapped Urta stands up and takes your hand.  She leads you to the corner opposite the door, where Kath can watch the two of you.\n\n");
			outputText("Urta grins evilly at the captive kitty and then starts to undress herself and you slowly and seductively.  As her fingers slide down your naked back she whispers, “<i>How about we share? There’s enough pussy for both of us.</i>”\n\n");
			outputText("She swings around, her heavy horsecock free to bob side to side in the open air.  She walks behind Kath and inserts a few fingers into Kath’s pussy.  Kath sighs and her tail flicks from side to side.  After a moment Urta pulls her fingers free and licks them.  “<i>Mmmm, you sure taste ready.  So do you want to cum today?</i>”\n\n");
			outputText("“<i>Yes.  Yes, please,</i>” begs Kath, spreading her legs wider than anyone but a cat " + katherine.catGirl("girl", "morph") + " could manage.  Urta strokes her horsecock a few times, building up a heavy coating of precum, then presses it against Kath’s dripping cunt.  She pushes it in slowly, only an inch at a time, driving Kath wild.\n\n");
			outputText("You can see the lust developing in Urta’s eyes.  The feeling of Kath’s tight passage is going to make her cum sooner rather than later, so you decide it’s time you got involved.  All you have to do is ");
			if (player.isTaur())
				outputText("stand over");
			else outputText(player.isNaga() ? "slither in front of" : "kneel in front of");
			outputText(" Kath and present ");
			if (player.cocks.length > 0)
				outputText((player.cocks.length > 1 ? "one of your cocks" : "your cock") + ".  Kath sucks on the tip eagerly,");
			else outputText("your pussy. Kath presses her face to your crotch,");
			outputText(" her rough tongue caressing you.\n\n");
			outputText("You start to scratch Kath’s sensitive ears and she goes wild.  She grabs your hips and pulls herself closer, " + (player.cocks.length > 0 ? "her teeth locked around the base of your cock" : "like her tongue is trying to reach your cervix") + ".\n\n");
			outputText("Urta is panting hard and she’s speeding up her strokes.  Every time she buries herself inside Katherine’s pussy " + (player.cocks.length > 0 ? "your cock goes a bit further down Kath’s throat" : "the tongue in yours descends a bit deeper") + ".  Then Urta’s hips stop and she throws back her head as she cums deep inside her mate.  You have to straighten up as Kath’s body is raised off the floor by her expanding belly.\n\n");
			outputText("Urta collapses against Kath’s back and hugs her weakly, her fingers tweaking Kath’s nipples.  Kath’s hungry tongue only stops for a moment.  Her muscles tense up and you suspect the cellar below is getting a thick coating of Kath’s semen.  Then the drunken pussy redoubles her efforts to make you cum.\n\n");
			outputText("You’re already close thanks to the scene before you, so you just rub Kath’s ears a little more forcefully and let it happen.  Kath isn’t surprised by the amount you cum" + (player.cocks.length > 0 ? ", swallowing it all eagerly, despite her swollen belly" : " and laps eagerly at your pussy, sucking up every drop") + ".  When you finish she pulls back and looks up at you, grinning from ear to ear.\n\n");
			outputText("You all lie there in a tangle, spent and happy.  Urta is the first to recover, gently turning Katherine’s head around so she can give her a long kiss.  She smiles at you and says “<i>Thanks again for introducing the two of us " + player.short + ".  Now how about you get back to your camp and I take care of this trapped kitty, hmmm?</i>”\n\n");
			outputText("You get dressed, watching the two herms snuggle together.  With Urta stroking Kath’s heavy belly like that you have to wonder if your horny fox is already thinking about a round two.  If she is you know Katherine isn’t about to complain.\n\n");
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(true);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			urta.urtaLove(1);
			if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		public function sandwich():void { //Kath is drunk, Urta is sober //Not available if Kath has no cock
			clearOutput();
			outputText("Urta scratches behind Kath’s ear and suggests slipping into one of the back rooms.  As soon as you close the door behind you Kath jumps into Urta’s arms and gives her a long kiss.\n\n");
			outputText("When they come up for air Urta says, “<i>Just a minute Kath, let me get ready,</i>” in a playful tone, trying to push Kath away long enough to get her clothes off.  Kath locks lips with Urta again while her fingers work on the laces of Urta’s clothes.\n\n");
			outputText("When Urta is mostly naked Kath gets behind her and puts her cock" + katherine.cockMultiple("", "s") + " between Urta’s thighs.  Taken by surprise Urta closes her legs.  Kath grabs Urta’s hips and purrs in her ear as she starts to slide her member" + katherine.cockMultiple("", "s") + " in and out.  You see them start to glisten with Urta’s juices and when Kath next pulls back she winks at you.  Her " + katherine.cockMultiple("", "upper cock pressing against Urta’s ass and her lower ") + "cock " + (katherine.cockNumber == 1 && urta.pregnancy.isPregnant ? "pressing against Urta’s ass" : "slipping between the folds of Urta’s dripping snatch") + ".  Urta’s jaw quivers and she holds her breath, waiting for her fucking to begin.\n\n");
			outputText("You put your hands on Urta’s shoulders, pushing her back towards Katherine.  When Kath sinks her shaft" + katherine.cockMultiple("", "s") + " into Urta you comment that they’re really getting along well.  You’re glad to see there isn’t much friction between them.\n\n");
			outputText("“<i>How could there be when she’s cumming buckets?</i>” asks Kath, her cock" + katherine.cockMultiple("", "s") + " bottoming out inside Urta.  “<i>Now how about you give her something to do?</i>”");
			if (player.hasCock())
				simpleChoices("Mount Urta", sandwichGetFucked, "Get Licked", (player.isTaur() ? sandwichMaleCentaurLicked : sandwichGetLicked), "", null, "", null, "", null);
			else doNext(sandwichGetFucked);
		}

		private function sandwichGetFucked():void {
			outputText("\n\nYou look down at Urta’s horse cock.  It bounces with each move Katherine makes - almost like it’s trying to hypnotize you.  Urta moans, “<i>Oh please!</i>” and you see no reason to deny her.  You ");
			if (player.isTaur())
				outputText("turn around and flick your tail at her");
			else outputText(player.isNaga() ? "slide across the floor, tensing your tail so as to bring your [vagOrAss] level with her flared shaft" : "turn around and bend over, presenting your ass");
			outputText(".  Urta, already horny thanks to Kath’s ministrations, wastes no time.\n\n");
			outputText("You feel her hands latch onto your " + (player.isTaur() ? "flanks" : "hips") + " and her meaty cock presses against your [vagOrAss].  You moan and try to open yourself for this invader, but Urta is in a hurry.  Her fingers dig into your sides and she reels you in, relentlessly feeding you inch after inch of her prick.  When she bottoms out you hear a deep sigh.  It must feel amazing to be both completely filled and completely filling someone at the same time.\n\n");
			outputText("Kath doesn’t wait for you or Urta to adjust." + (katherine.cockLength > 14 ? "  You can actually feel a little bump just above Urta’s cock every time Kath thrusts inside her." : "") + "  She pounds Urta, picking up the pace, and you know it can’t be long before Katherine knots.\n\n");
			outputText("Urta must also know Kath is close as she gets to work on your [vagOrAss], but she’s not quick enough.  You hear a strangled ‘meyowr’ from Kath and you feel Urta’s belly ");
			if (katherine.cumQ() <= 1500)
				outputText("grow warm as it fills with Katherine's seed.  Urta stops for just a moment, sighing contentedly, before she once again grips your " + (player.isTaur() ? "flanks" : "hips"));
			else
				outputText("expanding against " + (player.isTaur() ? "your rump" : "the small of your back") + ".  The air is forced from Urta’s lungs and you get pushed to the ground as both your lovers collapse against you.\n\nYou smile to yourself and flex " + (player.hasVagina() ? "the muscles in your pussy" : "your sphincter") + ", milking Urta’s cock.  She may be packed with Kath’s sperm but Urta is still Urta.  She responds by gripping your " + (player.isTaur() ? "flanks" : "hips") + " once more");
			outputText(".\n\nDespite her cum-stuffed belly she starts fucking you at a blistering pace, determined to fill you as she has been filled.  The feeling is exquisite and when you look " + (player.isNaga() ? "down" : "back") + " you see that Kath has taken Urta’s balls in hand.  She grins at you and starts massaging them while she whispers encouragement in Urta’s ear.\n\n");
			outputText("At last you feel the delightful blast of cum inside you.  Urta pulls your body against hers and floods you with her hot, sticky juices.  Your stomach muscles give out, unable to contain the load Urta pumps inside you.  Her throbbing cock brings you release and you cum, joining your lovers in ecstasy." + (player.hasCock() ? "  Your own cock contributes to the mess by spraying the floorboards with your wasted seed." : ""));
			sandwichCommonEnd(); //Play the common end
		}

		private function sandwichGetLicked():void {
			outputText("\n\nYou massage Urta’s shoulders and ask if she could help you out.  She’s not sure what you mean until you apply a little pressure, gently angling her head toward your " + (player.hasCock() ? "cock" : "pussy") + ".  Once she gets the idea Urta quickly gets down on all fours.  You have to smile to yourself as Urta " + (player.hasCock() ? "licks your cock and sucks out some pre" : "digs in") + ".  She puts her hands on your hips so that Katherine’s thrusts don’t " + (player.hasCock() ? "impale her" : "force her face into your pussy") + ".\n\n");
			outputText("It’s hard to just stand there.  Before you Kath is lost in pleasure, drunkenly slamming ");
			if (katherine.cockNumber > 1)
				outputText("both her cocks into Urta’s willing holes");
			else outputText("her cock into Urta’s willing " + (urta.pregnancy.isPregnant ? "ass" : "pussy"));
			outputText(".  Every time she thrusts her rack jiggles delightfully.  At the same time Urta’s expert tongue is " + (player.hasCock() ? "sliding around your cockhead" : "busy teasing your folds") + ", nudging you towards an orgasm.\n\n");
			outputText("With a powerful thrust Kath manages to force her partially inflated knot" + katherine.cockMultiple("", "s") + " inside Urta.  Urta gasps, but more importantly she also loses her grip on your hips.  Kath is so lost in pleasure she doesn’t even notice.  She pulls back and you hear her knot" + katherine.cockMultiple("", "s") + " pop out.  Then she rams " + katherine.cockMultiple("it", "them") + " back in.  Urta is driven forward and " + (player.hasCock() ? "she ends up taking your entire cock down her throat in one stroke" : "her face gets mashed into your pussy") + ".\n\n");
			outputText("It’s the pleading look Urta gives you that sends you over the edge.  That and " + (player.hasCock() ? "the feeling of her whole throat clamping down on your member" : "her nose tickling your clit while her tongue probes your depths.  You cum hard, soaking her face with fem-cum") + ".\n\n");
			if (player.hasCock()) {
				if (player.cumQ() < 500) {
					outputText("You pump a small, hot load of cream down Urta’s throat.  The thick, warm cum must have hit the spot because Urta hums contentedly as the last few spurts dribble into her stomach.\n\n");
					outputText("Urta doesn’t have a chance to recover");
				}
				else if (player.cumQ() < 1500) {
					outputText("You pump shot after shot down Urta’s throat.  With each blast you fire you feel her innards stretch more and more.  By the time your " + (player.balls > 0 ? "balls are" : "prostate is") + " empty there’s a distinct warmth and wetness in her throat.  Thank goodness she has no gag reflex.\n\n");
					outputText("Urta doesn’t have a chance to recover");
				}
				else if (player.cumQ() < 3000) {
					outputText("Urta tenses up as you release a fountain of cum into her stomach.\n\n");
					outputText("It doesn’t take long before you feel her belly expanding under pressure, making her look three months pregnant, four months, five!  Stuffed like a turkey Urta can do nothing but wait as you expand her stomach and belly beyond their normal limits.\n\n");
					outputText("Urta doesn’t have a chance to get used to the huge load you pumped into her");
				}
				else {
					outputText("When you release your load your cock expands in girth under the pressure.  You knock the wind out of Urta as you explode inside her throat.  A long stream of cum sprays directly into her stomach.\n\n");
					outputText("The tidal wave of cum inside Urta forces you to take a step back and your cock, despite its stiffness, buckles in the face of the pressure inside Urta.  The pain, combined with the pressure from within your shaft and without, forces you to take another step back and your cock springs out of Urta’s mouth.  While she coughs up the last portion of your contribution your cock continues erupting, coating Urta and even the front of Kath with a tremendous geyser of semen.\n\n");
					outputText("Urta doesn’t have a chance to get used to the huge load you pumped into her");
				}
			}
			outputText(" before Kath slams forward once again and knots her.  You see Kath’s tail go rigid and you know Urta is about to receive another contribution.  You get a front row seat as Kath’s hyperactive " + (katherine.hasBalls() ? "balls start" : "prostate starts") + " to fill the foxy herm.\n\n");
			if (urta.pregnancy.isPregnant) {
				if (katherine.cockNumber > 1)
					outputText("You watch as a bump forms beneath Urta’s belly.  Her cervix must be blocking Kath’s semen, so it’s pooling at the top of Urta’s birth canal with enough pressure to leave stretch marks on Urta’s skin.  That will probably serve Urta well when the baby is born, but at the moment she’s clutching the bump wordlessly and taking in shallow breaths.\n\n");
				outputText("The cock Katherine has planted in Urta’s ass " + katherine.cockMultiple("must be pumping in a torrent of cum", "faces no such restriction") + ".  Urta’s belly gets bigger and bigger as her womb and organs are forced forward by the mass of cum bubbling through her colon.\n\n");
				if (katherine.cockNumber > 1)
					outputText("Suddenly Kath lets out a surprised “<i>Ahhh!</i>” and the hard bulge just above Urta’s cock shrinks quickly while her belly gets even rounder.  “<i>Oh, oh it went backwards.</i>” says Kath, her eyes taking on a glazed look.\n\n");
				outputText("Kath collapses as her " + (katherine.hasBalls() ? "balls channel their" : "prostate channels its") + " last few squirts into Urta’s ass.  " + katherine.cockMultiple("", "Urta has gone from clutching the bulge to rubbing her sides.") + "  When it’s over Katherine");
			}
			else {
				outputText(katherine.cockMultiple("Sure enough Katherine’s cock starts to release its torrent of cum inside Urta and her", "Sure enough, the twin shafts inside Urta release a torrent of cum and her") + " belly bulges larger and larger with every squirt.  You have to smile at the look on their faces - Kath focusing intently each time her " + (katherine.hasBalls() ? "balls contract" : "prostate clenches") + " and a moment later Urta’s eyes bulging as her belly gets ever rounder.\n\n");
				outputText("Finally Kath runs out of juice and collapses backward.  She");
			}
			outputText(" puts a hand on Urta’s belly and moves her belly button back and forth as if she’s playing with a nipple.\n\n");
			outputText("Urta pants, having still not got off.  Kath notices and gives you a wink.  You start rolling Urta’s nipples between your fingers and at the same moment Katherine shifts one hand to Urta’s cock and the other to Urta’s clit.  The stimulation, the fullness, something makes Urta snap and your foxy lover explodes.  She can’t move, but you watch her balls retract almost all the way inside her and the stream of cum she fires reaches the opposite wall.");
			sandwichCommonEnd(); //Play the common end
		}

		private function sandwichMaleCentaurLicked():void {
			outputText("\n\nYou massage Urta’s shoulders and ask if she could help you out.  She’s not sure what you mean until you apply a little pressure.  Once she gets the idea Urta quickly gets down on all fours.  You give her a big smile and carefully walk over her.\n\n");

			outputText("You wind up in an unusual, but very pleasant situation.  Beneath you Urta is greedily slurping at your cock.  Katherine, who is lodged in Urta’s ");
			if (katherine.cockNumber > 1)
				outputText("ass and pussy");
			else outputText(urta.pregnancy.isPregnant ? "ass" : "pussy");
			outputText(", is in just the right position to give you a kiss.  Since your hands are free you embrace her, enjoying the feeling of her breasts rubbing against you while your other partner pleasures your shaft.\n\n");
			outputText("Kath pulls herself free and gives you a wink.  Then she shoves forward, catching Urta by surprise and ramming your cock down Urta’s gullet.  When Urta pulls back Kath grabs her hips and pulls the fox back onto her own cock" + katherine.cockMultiple("", "s") + ".  Urta barely has time to suck in another breath before the drunken pussycat drives her back onto your meatstick.\n\n");
			outputText("You know Urta can’t be that uncomfortable - if she just lowered her head she wouldn’t have to swallow you when Kath shoves her forward.  That and the fox tail that’s wagging between your front legs tells you your favourite fox herm has surrendered herself to being used as a living sex toy.\n\n");
			outputText("Kath really starts to pant and her hips start to jackhammer into Urta.  Looking down you get a front row seat as Kath slams her knot" + katherine.cockMultiple("", "s") + " in and out of Urta’s abused hole" + katherine.cockMultiple("", "s") + ".  Then the knots stay in and Kath’s upper body seems to liquify in your arms, an exultant expression on her face.  Urta, still pinned between the two of you, lets out a happy gurgle as her belly is filled with Katherine’s seed and you hear spraying and splashing as her horse cock blows its load all over the floor.\n\n");
			outputText("Since Kath and Urta are now solidly joined you take hold of the exhausted cat " + katherine.catGirl("girl", "morph") + "’s hips and work her forwards and backwards.  You find it easy to drag Urta back and forth.  Presumably her bloated belly is sliding across the floor on a thick layer of cum.\n\n");
			outputText("Urta slides her tongue around inside her mouth, trying her best to help you cum.  For her part Kath locks her hands around the back of your head and weakly pulls your face down into her breasts.  At last you feel that familiar tensing in your " + (player.balls > 0 ? "sac" : "prostate") + " and you push as far forward as you can.  Urta’s tongue darts out of her mouth and she’s just able to lick " + (player.balls > 0 ? "your balls" : "the base of your cock") + ".\n\n");
			outputText("All four of your knees go weak as your body devotes all of its energy to filling this foxy lady.  ");
			if (player.cumQ() < 500)
				outputText("You pump a small, hot load of cream down Urta’s throat.  The thick, warm cum must have hit the spot because Urta hums contentedly as the last few spurts dribble into her stomach.");
			else if (player.cumQ() < 1500)
				outputText("You pump shot after shot down Urta’s throat.  With each blast you fire you feel her innards stretch more and more.   By the time your " + (player.balls > 0 ? "balls are" : "prostate is") + " empty there’s a distinct warmth and wetness in her throat.  Thank goodness she has no gag reflex.");
			else if (player.cumQ() < 3000) {
				outputText("Urta tenses up as you release a fountain of cum into her stomach.\n\n");
				outputText("It doesn’t take long before you feel her belly expanding under pressure, making her look three months pregnant, four months, five!  There’s serious backpressure, as the cum in her other hole" + katherine.cockMultiple("", "s") + " has nowhere to go.  Stuffed like a turkey Urta can do nothing but wait as you expand her stomach and belly beyond their normal limits.");
			}
			else {
				outputText("When you release your load your cock expands in girth under the pressure.  You knock the wind out of Urta as you explode inside her throat.  A long stream of cum sprays directly into her stomach" + (katherine.cockNumber > 1 || urta.pregnancy.isPregnant ? ", seemingly racing to meet the deposit Kath left in Urta’s colon" : "") + ".  Urta’s hands and feet scrabble across the floor, trying to find some escape.  Kath’s deposit" + katherine.cockMultiple(" has", "s have") + " nowhere to go so when Urta’s body finally reaches its limit it’s your cock that has to give.\n\n");
				outputText("The tidal wave of cum inside Urta forces you to take a step back and your cock, despite its stiffness, buckles in the face of the pressure inside Urta.  The pain, combined with the pressure from within your shaft and without, forces you to take another step back and your cock springs out of Urta’s mouth.  While she coughs up the last portion of your contribution your cock continues erupting, coating your belly, Urta and even the front of Kath with a tremendous geyser of semen.");
			}
			sandwichCommonEnd(); //Play the common end
		}

		private function sandwichCommonEnd():void {
			outputText("\n\nYou pull yourself free from your knotted lovers and take in the scene.  The two herms are panting happily.  Urta is stuffed like she’s nine months along and Kath’s tail is flicking from side to side.  Occasionally it lands in a puddle of spunk and flicks a glob of spooge across the room.  It’s going to take a while to clean up, but you have people to see and places to be.\n\n");
			outputText("To ‘make up’ for skipping out on the cleaning you decide to give them a little treat.  " + (flags[kFLAGS.URTA_FERTILE] == 1 && !urta.pregnancy.isPregnant ? "First you pat Urta’s belly and ask if she’s trying to get herself knocked up.  She just mumbles something incoherent.  Then you" : "You") + " get behind Kath and rub the base of the drunken kitty’s tail.  She purrs appreciatively.  You reach further down and start playing with ");
			if (katherine.ballSize > 0)
				outputText("her recently drained balls");
			else outputText("the base of her " + katherine.cockMultiple("", "lower ") + "cock");
			outputText(".\n\n");
			outputText("“<i>You’ve got to show the Captain here that you’ve got endurance,</i>” you tell her.\n\n");
			outputText("Kath moans and says, “<i>I just - I’m still knotted.  I can’t.</i>”\n\n");
			outputText("You give her a kiss and say, “<i>Don’t be a quitter.</i>”\n\n");
			outputText("Urta looks up, realizing what you’re trying to do.  “<i>No, no!  I’m still full.  I can’t.</i>”\n\n");
			outputText("You keep rubbing Kath with one hand but you move your other to tease Urta’s clit.  You tell Urta that deep down she knows she can take it.  She tries to fight back, but with her stomach stuffed and Kath already knotted she can’t escape.\n\n");
			outputText("You kiss Kath again and ask her, “<i>Don’t you want to see how big you can make her?</i>”  Despite having just cum you see the drunken lust reignite in Kath’s eyes.  She digs her claws into Urta’s hips and starts gently rocking her shaft in and out.\n\n");
			outputText("Urta clutches her belly and moans, “<i>Oh no,</i>” but you think she’s starting to get into it.  Before you get too turned on you leave your lovers to it." + (flags[kFLAGS.KATHERINE_URTA_AFFECTION] >= 31 ? "  They really need some more time together and you’re sure this qualifies as a ‘bonding experience’." : ""));
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(true);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			urta.urtaLove(1);
			if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		public function orgy():void { //Both Kath and Urta are drunk
			clearOutput();
			outputText("Your attempt to draw them off into one of the backrooms comes too late.  Urta kisses Kath and Kath responds by undoing Urta’s belt.  Her massive schlong smacks the underside of the table on its way to freedom.  The deep wooden ‘knock’ silences most of the bar and everyone looks your way to see what’s going on.\n\n");
			outputText("Urta is so drunk that she doesn’t care that her prick is standing erect and waving free in the open air.  Kath cares even less about what people think and slowly draws her hand down Urta’s cock, from the tip to the root.  Urta shudders under the attention and quickly undoes " + katherine.clothesLowerChoice("Kath’s blouse", "Kath’s blouse", "the upper part of Kath’s bodysuit", "the laces on Kath’s dress", "the front of Kath’s robe") + ", freeing her " + katherine.breasts.adj() + " breasts.\n\n");
			outputText("Urta’s next move is to grab you by the hand and twist your arm, drawing you over to the seat next to the one she and Kath are sharing.  For her part, Kath slides off the rest of her outfit and then starts eagerly groping your ");
			if (player.hasCock())
				outputText("crotch");
			else outputText(player.hasBreasts() ? "breasts" : "ass");
			outputText(".\n\nUrta pulls on your hand again, places it against her moist vagina and growls, “<i>I want you - I want both of you,</i>” before sucking hard on one of Kath’s nipples.\n\n");
			outputText("Kath lets out a sigh and wraps her tail around your leg.  “<i>Yeah, lets give ‘em something to talk about.</i>”\n\n");
			outputText("Urta lifts her head, looks around and realizes how many people are staring at the developing threesome.  For a moment it looks like she’s going to bolt, but then Kath lets out a seductive growl and starts stroking Urta’s shaft once again.  Urta closes her eyes and gives in to this public display of lust and drunkenness.\n\n");
			outputText("All around you there’s the sound of buckles being loosened, laces being undone and fabric sliding off flesh, fur and scale.  There were quite a few patrons around when this started and all but a few are keen to watch - at least.\n\n");
			var valaHere:Boolean = flags[kFLAGS.FREED_VALA] > 0 && model.time.hours >= 12 && model.time.hours <= 21;
			if (valaHere) {
				outputText("You spot Vala, still carrying a tray of drinks from before this started.  Normally she’s fast enough to keep out of this sort of thing, but when she sees you, Kath and Urta together her jaw drops.  Someone bumps into her and she flitters closer, placing the tray on the table. ");
				if (flags[kFLAGS.KATHERINE_VALA_TIMES_SEX] > 0)
					outputText("You smile, knowing Vala has nothing against something harmless like an orgy.\n\n");
				else {
					outputText("You smile weakly, wondering how to explain all this, but Vala just puts down that tray and moves in close.\n\n");
					outputText("“<i>Hi " + player.short + ",</i>” she says cheerfully, “<i>I see you brought a friend.  Did you save her too?</i>”\n\n");
					outputText("Kath stops kissing Urta for a second and says, “<i>Uh... kinda, yeah,</i>” before Urta pulls her back into the kiss.\n\n");
					outputText("“<i>That sure sounds like my hero,</i>” says Vala, grinning ear to ear.  “<i>Oh, I’m Vala,</i>” she adds, extending a hand which Kath shakes, looking surprised.\n\n");
					outputText("You tell Vala that this is Katherine.  You hear a muffled “<i>Hi</i>” from the locked lips of your two " + (katherine.hasCock() ? "herms" : "lovers") + ".\n\n");
				}
			}
			outputText("After that things get out of hand.  You lose track of both time and people.  Certainly you, Katherine" + (valaHere ? ", Urta and Vala" : " and Urta") + " tend to be at the center of things, but there’s a mess of other people involved.  You’re sure some extras participants came in from the street.  Over an hour later you find yourself lying in a pool of slowly cooling spunk.\n\n");
			if (player.hasVagina())
				outputText("You, Kath" + (valaHere ? ", Urta and Vala" : " and Urta") + " all");
			else
				outputText("Kath" + (valaHere ? ", Urta and Vala all" : " and Urta both"));
			outputText(" sport huge, cum-stuffed bellies - as do so many others.\n\n");
			outputText("Too tired to move, you go through some of the highlights in your mind: A huge minotaur in bondage straps eagerly sucking on a bunny morph’s cock, swallowing her entire load");
			if (valaHere)
				outputText("... Vala surprising Kath by " + (katherine.hasCock() ? "settling on top of her " + katherine.cockAdj() + "shaft and then taking it, knot and all, inside her tiny body" : "diving between her thighs and sucking on Kath's clit while pushing her whole hand inside Kath's dripping twat"));
			outputText("... A heavily pregnant drider fisting a centaur and at the same time forcing her eggs into an eager looking canine-morph... a tiny little spider girl, no more than 4’4\" tall, taking three huge horse-morphs in a row, her chitin creaking as her belly expands far past her normal limits... a woman who looked demonic, lost in ecstasy, sucking on a pair of dog cocks and jerking them off onto herself while riding Urta’s monster prick... and of course the moment when Katherine ");
			if (player.hasCock())
				outputText("deepthroated your cock");
			else outputText(player.hasVagina() ? "licked you out" : "fisted your ass");
			outputText(" while she was bent over the table and getting fucked from behind by Urta.\n\n");
			if (valaHere) {
				outputText("Vala manages to pull herself free from the sticky floor.  Her wings flap wetly, splattering gobs of cum across the bar.  She gives you a kiss and turns to inspect Katherine and Urta.  “<i>You sure know how to start a party,</i>” she says, pressing on her belly to force out some of the cum.\n\n");
				outputText("She looks around the bar at all the collapsed bodies and says, “<i>This is gonna take a long time to clean up, but boy oh boy was it ever worth it.</i>”  She gives each of you a kiss and then wobbles toward the cupboard with the cleaning supplies.\n\n");
				outputText("Kath mumbles, “<i>Worth it,</i>” at the floor, then seems to pass out.\n\n");
				katherine.katherineAndValaHadSex();
			}
			outputText("Using one of the room’s columns as support Urta pulls herself upright and surveys the damage.  “<i>I’m going to have to sort this out.  Oh yeah, this was worth it, but now I’m going to need to sweep it all under the rug.  Yeesh.</i>”\n\n");
			outputText("She tosses a spermy bit of your clothing to you and says, “<i>You should get out of here " + player.short + ".  Don’t you worry, I’ll take care of this.</i>”  Poking Katherine with her foot, she adds, “<i>Besides, Kath needs a bit more education on the subject of Watch paperwork.</i>”\n\n");
			outputText("“<i>Aw - not paperwork,</i>” groans Kath as you wave and escape out the door.");
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(true);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 10 + rand(2);
			urta.urtaLove(1);
			if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseTwoHours);
		}


		public function doubleStuffKath():void { //Both Kath and Urta are drunk
			clearOutput();
			outputText("You ask your two " + (katherine.hasCock() ? "herms" : "lovers") + " if they want to go somewhere more private.\n\n");
			var urtaHasHouse:Boolean = player.hasKeyItem("Spare Key to Urta's House") >= 0;
			outputText("Urta " + katherine.clothesLowerChoice("runs her hand up Kath’s thigh", "slides her hand under Kath’s skirt", "rubs the " + (katherine.hasCock() ? katherine.cockAdj() + "bulge in the " : "") + "crotch of Kath’s bodysuit", "slides her hand under Kath’s dress", "slides her hand between the folds of Kath’s robe") + " and says, “<i>That’s a good idea.  My " + (urtaHasHouse ? "old " : " ") + "apartment’s close enough.</i>”\n\n");
			flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT;
			outputText("It’s an interesting walk.  Both Urta and Kath need your support and both are horny.  They’re constantly groping and kissing you or each other.  When you get to Urta’s " + (urtaHasHouse ? "old " : " ") + "apartment the two " + (katherine.hasCock() ? "herms" : "girls") + " don’t even make it to the bed.  They crash to the floor and start tearing each other’s clothes off while you close the door.\n\n");
			outputText("“<i>You want to see us fuck?  Is that it?</i>” Kath asks.\n\n");
			outputText("Urta strokes Katherine’s " + (katherine.hasCock() ? "cock" : "tail") + " and says, “<i>Yeah, [he] loves " + (katherine.hasCock() ? "herms so much" : "it when we fuck") + ", let’s give [him] a show!</i>”\n\n");
			outputText("Urta lifts Kath’s leg and presses the flat face of her cock against Kath’s dripping pussy.  Kath distracts her by squeezing Urta’s breasts, then " + (katherine.hasCock() ? "presses her own cock against" : "slides her finger over") + " Urta’s sex.\n\n");
			outputText("You’re barely out of your clothes by the time your two vixens slam their hips against each other.  It’s like a small thunderclap" + (katherine.hasCock() ? ".  Both of them look down at where their respective cocks disappear into each other’s bodies" : " and they both seem well pleased with the result") + ".\n\n");
			outputText("Kath starts to laugh.  “<i>" + (katherine.hasCock() ? "No room left for you" : "Too slow" + player.short) + ",</i>” she says, “<i>but I bet we can still make you feel good.</i>”\n\n");
			outputText("Urta licks her lips and says, “<i>Oh yeah, we’re gonna make you feel so good.</i>”  She reaches out for your hand and pulls you closer.  She mumbles “<i>If I’m fucking your girl’s pussy this is the least I can do.</i>”  Her tongue licks the " + (player.hasCock() ? "tip of your cock before she takes it into her mouth" : "length of your pussy before she sucks on your clit") + ".\n\n");
			outputText("Urta’s alcohol consumption must have loosened her up.  She sucks " + (player.hasCock() ? "your cock right down her throat, barely gagging at all" : "and rolls her tongue over your clit like a possessed woman") + ".  Kath looks " + (player.hasCock() ? "impressed as Urta deepthroats you" : "a little envious, despite the horse cock that's filling her") + ".  When Urta finally pulls back for some air Kath gleefully shouts, “<i>My turn!</i>” and " + (player.hasCock() ? "takes your whole length in one gulp" : "dives in, her rough tongue attacking your clit as she tries to one-up her captain") + ".\n\n");
			outputText("“<i>Show off,</i>” says Urta.  She tweaks Katherine’s nipples, causing a low moan that vibrates " + (player.hasCock() ? "your dick" : "through your pussy") + " in a pleasing way.  Soon Kath " + (player.hasCock() ? "has to release" : "has to release") + " you and coughs as she sucks in a new breath.\n\n");
			outputText("Before she can " + (player.hasCock() ? "swallow your meat" : "go down on you") + " again Urta grabs your " + (player.hasCock() ? "pole and directs it between her own lips" : "hips and presses her face against your groin") + ".  “<i>Hey! I wasn’t finished,</i>” says Kath.  She starts to " + (katherine.hasCock() ? "thrust her " + katherine.cockType() + " member into Urta’s hole" : "rock her hips, her hand rolling Urta's balls between her fingers") + ".  Urta’s eyes close and she lets Kath" + (katherine.hasCock() ? "’s thrusts rock" : "do as she likes with") + " her body, " + (player.hasCock() ? "sliding her throat up and down your shaft" : "her tongue burrowing deep inside you") + ".\n\n");
			outputText("You were horny before these insatiable " + (katherine.hasCock() ? "herms" : "sluts") + " started fighting over your " + (player.hasCock() ? "cock" : "cunt") + " and the feeling brings you to your knees.  By the time Urta lets go Kath is ready.  In a single stroke her nose starts rubbing against your belly and you look down to witness her slight smile and horny gaze as her rough tongue starts doing unspeakable things " + (player.hasCock() ? "to your cock" : "deep inside your sex") + ".  Meanwhile Urta is " + (katherine.hasCock() ? "providing the same ‘service’ Kath did," : "") + " hammering her cock into Kath’s cunt like it owes her money.\n\n");
			if (katherine.hasCock())
				outputText("You hear an “<i>Oh!</i>” from Urta and the long thrusts are reduced to much shorter strokes.  It seems Kath, in all the excitement, has knotted your foxy friend.  Kath doesn’t sound very sincere when she giggles and says, “<i>I am <b>so</b> sorry.</i>”  Urta just grunts and tries to force more of her equine shaft inside Kath.  They both cum and you get to watch as their bellies fill.  The two herms are forced apart by their bulges and have to take a moment to recover from their orgasms.  They both rub their bellies, obviously content with the situation.\n\n");
			else outputText("You hear an “<i>Oh!</i>” from Urta and she plants her equine shaft as deep as she can inside Kath's pussy.  Kath's eyes glaze over as Urta grunts and holds Kath in place while her seed flows, filling Katherine's belly 'til it takes the shape of a " + katherine.catGirl("", "fuzzy ") + " watermelon.  The two girls are forced apart by Kath's new bulge and have to take a moment to recover from their orgasms.\n\n");
			outputText("Kath regains her strength first and forces herself up onto her elbows.  She smiles at you and simply opens her mouth.  You smile back, " + (player.hasCock() ? "feed her your cock" : "press your crotch against her face") + " and relax, enjoying the slower pace" + (player.hasCock() ? ", the texture of Kath’s tongue and the inside of her throat" : " and the texture of Kath’s tongue") + ".\n\n");
			outputText("Your two lovers trade you" + (player.hasCock() ? "r cock" : "") + " back and forth a few times until you feel that you’re about to cum.  ");
			if (!player.hasCock()) {
				outputText("There's no reason to fight it, you let go and femcum dribbles down " + (player.isNaga() ? "the scales of your tail" : "your legs") + " and washes over both Kath and Urta.  Your muscles give out and you collapse on the floor next to your panting, sweating lovers.");
			}
			else if (player.cockTotal() > 1) {
				outputText("You put a hand behind each of their heads and pull them both towards your groin.  Kath and Urta hungrily gobble your cocks until their cheeks are pressed together.  That’s when you let loose.  They both feel the first stream hit their throat and the sight of two pairs of eyes looking up at you ensures you’ll provide them both with a good-sized helping.\n\n");
				if (player.cumQ() < 500) {
					outputText("They both swallow your additional contribution easily." + (katherine.hasCock() ? "  It’s nothing compared to the amount they pumped into each other’s pussies." : ""));
					if (player.cockTotal() > 2) outputText("  Your other cock" + (player.cockTotal() > 3 ? "s" : "") + " produce a few squirts which coat both Kath and Urta’s bodies.");
					outputText("  As you pull out they give each other a tired hug and giggle drunkenly " + (katherine.hasCock() ? "as they compare their swollen bellies" : "as Urta rubs Kath's swollen belly proudly") + ".");
				}
				else if (player.cumQ() < 1500) {
					if (katherine.hasCock())
						outputText("Both your lovers have a little difficulty taking your deposit.  Each already has a full tummy thanks to the other’s efforts.  They gulp it all down but afterwards they cradle their full bellies and rub their sides, trying to reduce the pressure."); 
					else outputText("Urta swallows your load with ease; Kath, her tummy already brimming thanks to Urta's efforts, has more trouble.  They gulp it all down but afterwards Kath cradles her overstuffed belly and Urta massages her sides, trying to reduce the pressure.");
					if (player.cockTotal() > 2) outputText("  You realize that your free cock" + (player.cockTotal() > 3 ? "s" : "") + " fired their streams all over the room, adding to the mess Urta will have to clean up later.");
					outputText("  Urta looks at you, then Kath and back at you and just laughs at where her lust has taken her.");
				}
				else {
					if (katherine.hasCock())
						outputText("Urta’s gut starts to expand under the added pressure from your contribution.  Kath’s does too, but without a knot in the way quite a bit of Urta’s cum starts to leak out.  Urta makes a worried “<i>Mmph</i>” noise, but you’re too involved in filling them to stop.  She leans back and her stomach grows enough to develop some stretch marks.");
					else outputText("Urta’s gut starts to expand, your deposit soon rounding her belly just as much as Kath's.  Kath’s belly swells a little too, but under the added pressure quite a bit of Urta’s cum starts to leak out.");
					if (player.cockTotal() > 2) outputText("  Your other cock" + (player.cockTotal() > 3 ? "s" : "") + " release a torrent of cum, coating Kath, Urta, the floor and a few of the walls.  Though it’s messy you’re sure both your lovers are happy that at least some of your sperm didn’t wind up inside them.");
					outputText("\n\nWhen it’s over you pull your cocks free and Kath giggles at Urta’s faux pregnancy.  “<i>Too full,</i>” Urta croaks." + (katherine.hasCock() ? "  Kath rubs Urta’s larger belly and then flicks her finger against it, watching the waves ripple across Urta’s skin" : "\n\nKath's jaw drops and she point at her own, even larger, belly.  “<i>You do <b>not</b> get to complain,</i>” she says, pressing her hand none too gently against Urta's stomach") + ".  “<i>Oh - not fair!</i>” cries Urta, clutching her overstuffed gut.");
				}
			}
			else { //Just one cock
				if (rand(2) == 0) { //Urta takes it
					outputText("Urta had just swallowed you again, the ride down her throat setting you off.  You grip the back of her head and your " + (player.balls > 0 ? "balls start" : "prostate starts") + " pumping.  Her eyes go wide but she accepts her fate, trying to swallow your load as fast as you can produce it.\n\n");
					outputText("Kath realizes what’s happened" + (player.balls > 0 ? " and rubs your balls" : ", quicky inserts her finger into your ass and starts milking your prostate") + ", trying to coax an even bigger load out of " + (player.balls > 0 ? "them" : "it") + ".  ");
					if (player.cumQ() < 500)
						outputText("Urta swallows all of it easily.  Your contribution does nothing to " + (katherine.hasCock() ? "her expanded" : "expand her") + " abdomen, but she rubs your leg and smiles contentedly.");
					else if (player.cumQ() < 1500)
						outputText("Urta has a little difficulty taking your deposit" + (katherine.hasCock() ? " since her belly is already filled with Kath’s seed" : "") + ".  She gulps it all down but rubs her sides afterward, trying to reduce the pressure.");
					else {
						outputText("Urta’s gut starts to expand " + (katherine.hasCock() ? "under the added" : "thanks to the") + " pressure from your contribution.  She makes a worried “<i>Mmph</i>” noise, but you’re busy right now.  She leans back and her stomach grows enough to develop some stretch marks.");
						outputText("When it’s over you pull your cock free and Kath giggles at Urta’s faux pregnancy.  “<i>Too full,</i>” Urta croaks.  Kath rubs Urta’s " + (katherine.hasCock() ? "larger " : "") + "belly and then flicks her finger against it, watching the waves ripple across Urta’s skin.  “<i>Oh - not fair!</i>” cries Urta, clutching her overstuffed gut.");
					}
				}
				else { //Kath takes it
					outputText("Kath’s licking and humming set you off, so you grip the back of her head.  Your " + (player.balls > 0 ? "balls start" : "prostate starts") + " pumping.  Her eyes go wide but she accepts her fate, trying to swallow your load as fast as you can produce it.\n\n");
					outputText("Urta realizes what’s happened" + (player.balls > 0 ? " and rubs your balls" : ", quicky inserts her finger into your ass and starts milking your prostate") + ", trying to coax an even bigger load out of " + (player.balls > 0 ? "them" : "it") + ".  ");
					if (player.cumQ() < 500)
						outputText("Kath swallows all of it easily.  Your contribution does nothing to her expanded abdomen, but she rubs your leg and smiles contentedly.");
					else if (player.cumQ() < 1500)
						outputText("Kath has a little difficulty taking your deposit since her belly is already filled with Urta’s seed.  She gulps it all down but rubs her sides afterward, trying to reduce the pressure.");
					else {
						outputText("Kath’s gut starts to expand under the added pressure from your contribution.  She makes a worried “<i>Mmph</i>” noise, but you’re busy right now.  She leans back and her stomach grows enough to develop some stretch marks.  You start to see Urta’s load being forced back out, despite the fact Urta’s huge cock hasn’t started to shrink yet.");
						outputText("When it’s over you pull your cock free and Urta starts to rub Katherine’s " + (katherine.hasCock() ? "larger " : "") + "belly.  Kath lies back on the floor and moans, her tail lazily moving from side to side.");
					}
				}
			}
			if (katherine.hasCock()) {
				outputText("\n\nYou’re now spent, but the sight of these two cum-stuffed herms knotted together gives you an idea.  You reach down and start rubbing the back end of Kath’s swollen knot.  “<i>Hey.  No no no - please!  If you do that I’ll - Oh! - We’ll be tied for hours.</i>”  You smile and tell her that’s the plan.\n\n");
				outputText("Urta wriggles, trying to pull away from Kath, but you’re too fast.  You feel Kath’s knot engorge again, sealing Kath to her mate.  You give them each a kiss and tell them it’s time they got to know each other better.  Then you pull on your clothes and head back to camp, feeling you’ve already accomplished quite a bit today.\n\n");
			}
			else {
				outputText("\n\nYou’re now spent and unfortunately you have to get back to camp.  You give both Kath and Urta a kiss and wrap Kath's arms around Urta and Urta's arms around Kath.  The girls sigh and snuggle together");
				if (player.cor < 33)
					outputText(", giving you a warm feeling in the bottom of your heart.");
				else outputText(player.cor < 66 ? ".  Despite having just cum you feel a little twitch from your cock." : ".  It's sickly sweet, but who cares as long as they keep fucking like that.");
			}
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(true);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			urta.urtaLove(1);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function doublePenetrateKath():void { //Both Kath and Urta are drunk
			clearOutput();
			outputText("You ask your two " + (katherine.hasCock() ? "herms" : "sluts") + " if it’s time to commandeer one of the back rooms.\n\n");
			outputText("Urta " + katherine.clothesLowerChoice("runs her hand up Kath’s thigh", "slides her hand under Kath’s skirt", "rubs the " + (katherine.hasCock() ? katherine.cockAdj() + "bulge in the " : "") + "crotch of Kath’s bodysuit", "slides her hand under Kath’s dress", "slides her hand between the folds of Kath’s robe") + " and gives you a wolfish smile.\n\n");
			outputText("You have to help them both to one of the backrooms and you can feel the eyes of many of the bar’s patrons on your back.  As soon as the door is closed and barred Urta presses Kath against the wall and starts giving her tongue.\n\n");
			outputText("You watch the show, your cock beginning to strain against the confines of your clothes" + (player.hasVagina() ? " as your pussy begins to wet them" : "") + ".  Katherine starts to tug at Urta’s clothes and despite her drunkenness she does a good job of removing them.\n\n");
			outputText("Urta rips off the last few bits of her own clothing and then starts on Kath’s garments.  She looks over at you and says, “<i>Better hurry up " + player.short + ".  I don’t think you want to get left out of this.</i>”  Just as she says the final word she pulls off the last of Kath’s clothes and cups both Kath’s " + katherine.breasts.adj() + " breasts in her hands.\n\n");
			outputText("Kath lets out a happy moan as her ");
			if (katherine.hasCock())
				outputText(katherine.cockMultiple("cock, now in the open air, rises until it’s", "twin cocks, now in the open air, rise until they’re") + " poking Urta’s belly.\n\n");
			else outputText("breasts are manhandled.  You watch as " + (katherine.breasts.lactating() ? "cream runs down her front and" : "some of her") + " femcum dribbles down her thigh.\n\n");
			if (katherine.hasCock())
				outputText("Urta twists " + katherine.cockMultiple("it", "them") + " out of the way, causing Kath to let out a little squeak.  She tells Kath, “<i>Oh, not today cutie.  Today I’m gonna use this.</i>”  Urta props the tip of her huge horsecock against Kath’s clit.  Kath looks down between her breasts and then over at you.\n\n");
			else outputText("Urta props the tip of her huge horsecock against Kath’s clit and tells her, “<i>No teasing today kitty.  Today I am gonna use this monster on you.</i>”  Kath looks down between her breasts and then over at you.\n\n");
			outputText("By now you’ve undressed and you’re getting hard watching Urta manhandle your pretty kitty.  It would be something to see her massive horsecock buried in Katherine’s tight little snatch.  You decide to give them a ‘helping hand’ by giving Urta’s ass a good hard smack when she’s not looking.\n\n");
			outputText("Urta jerks forward in surprise and then they both let out a little yelp.  Kath’s up on tiptoes with her mouth wide open.  Urta looks over her shoulder like she’s about to complain, but then her brain finally registers the hot, tight passage her cock has just sunk into.  The anger disappears from her face and she puts her hands on Katherine’s shoulders.\n\n");
			outputText("“<i>I’m so full,</i>” is all Kath can say.\n\n");
			outputText("“<i>Not yet you aren’t,</i>” replies Urta.  She pushes down on Kath’s shoulders and forces another few inches inside.\n\n");
			outputText("Katherine’s tongue lolls out of her mouth as her cunt stretches wider.  When Urta starts to pull back Kath looks at you lustily and asks, “<i>What about you, " + katherine.playerText() +"?</i>”\n\n");
			outputText("You pull the joined " + (katherine.hasCock() ? "herms" : "lovers") + " away from the wall and tell Kath you’re here to give her support.  She looks a bit confused, so you step behind her and spread her cheeks with your hands.\n\n");
			outputText("“<i>Oh, I see,</i>” she pants.\n\n");
			outputText("When Urta pushes forward again you press your cock against Kath’s asshole.  You brace your legs, and as Urta fills Kath from the front your cock begins to fill her behind.  Kath hugs Urta and lets out a deep, long purr of satisfaction.\n\n");
			outputText("Inside her, through your cock, you can feel the large hot intrusion that could only be Urta’s equine member.  You thrust a bit deeper.  The strained membranes between Urta’s cock and yours allow you to feel the bumps of the veins on her cock.  When you both stop you can feel Urta’s pulse.\n\n");
			outputText("Kath is only along for the ride as you and Urta build a rhythm together.  Sometimes she withdraws as you enter, sometimes you both push your cocks in at the same time - all the way to the root.  When you both withdraw you can feel Katherine’s belly pulling inwards from the sudden suction.\n\n");
			outputText("The wet squishing, slapping, dripping, purring, and moaning makes it sound like you’re using Kath as an obscene orchestra, an instrument built for two.  She clearly doesn’t care.  With two cocks in her she cums quickly, her ");
			if (katherine.hasCock())
				outputText("cock" + katherine.cockMultiple("", "s") + " matting Urta’s furry belly and coating the floor beneath you.\n\n");
			else outputText("pussy releasing a flood of girl cum that " + katherine.catGirl("wets her skin", "mats her fur") + " all the way to her feet and soaks into the floor beneath you.\n\n");
			outputText("You’re getting close to cumming yourself when you feel Katherine’s sphincter beginning to clasp around your cock a second time.  Kath’s hips are trapped but they try to move nonetheless, ");
			if (katherine.hasCock())
				outputText("uselessly humping as her dick" + katherine.cockMultiple(" sprays", "s spray") + " her seed against Urta once again.\n\n");
			else outputText("weakly grinding against Urta's cock as her body begs for more.\n\n");
			outputText("Now it’s your turn.  You tighten your grip on Kath’s hips and jam your prick all the way in.  You hear a whimpered “<i>Yes</i>” from Kath before your " + (player.balls > 0 ? "balls start to empty their" : "prostate starts to empty its") + " contents.  ");
			if (player.cumQ() < 500)
				outputText("You pump several rapid-fire shots into Kath’s colon.  The thick, warm cum lubes up her innards.  Kath’s tail wags, both showing you her pleasure and massaging the base of your cock.");
			else if (player.cumQ() < 1500) {
				outputText("You pump several streams of cum into Kath’s rectum.  With each shot you fire you feel her innards stretch more and more.  By the time your " + (player.balls > 0 ? "balls are" : "prostate is") + " empty you can’t feel the insides of her colon anymore, just an inner sea of your cum.");
				outputText("Looking over her shoulder you can see that Kath’s belly has ballooned slightly.  Kath looks back at you and smiles.");
			}
			else if (player.cumQ() < 3000) {
				outputText("Kath wheezes as you release a fountain of cum into her bowels.\n\n");
				outputText("It doesn’t take long before you feel her belly expanding under pressure, making her look three months pregnant, four months, five!  She lets out a deep, contented moan as your last deposit stretches her waist out another inch and turns her belly button into an outie.");
			}
			else {
				outputText("You knock the wind out of Kath as your cock explodes inside her anus.  This is not some lightweight supply of sperm, just enough to ensure reproduction.  No, this is a magic fueled tidal wave of cum and it has nowhere to go but in.  Kath’s hands try to pry yours off her hips, but your whole body has locked up, seized with the effort of forcing out such an unnatural volume of cum.\n\n");
				outputText("Her hands get weaker and you can feel the skin of her hips stretching out as her body tries to provide her belly with more.  As the last of your cum is forced inside her she looks positively pregnant.  ");
				if (player.cor < 25)
					outputText("You hope you aren’t doing any permanent damage with such a big load.");
				else if (player.cor < 75)
					outputText("You hope Kath is enjoying this as much as you are.");
				else outputText("Secretly you try to force even more sperm from your " + (player.balls > 0 ? "heavy balls" : "monstrous prostate") + ".  You want to see just how far you can stretch out your cat " + katherine.catGirl("girl", "morph") + "’s belly.  Even more, you want to see if you can get her addicted to the feeling of being overfilled.");
				outputText("\n\nKath whimpers at being so completely filled, but her tail is wagging.  You’re pretty sure she’s enjoying herself - and if not, well she can’t do anything about it anyway.");
			}
			outputText("\n\nUrta stops moving for a second and takes Katherine’s chin in her hand.  “<i>I see " + player.short + " has already cum.  You like it when [he] cums inside you?</i>”  She puts a hand against Kath’s belly and rubs it.  “<i>You like all that warm spunk inside you?</i>”\n\n");
			outputText("Kath nods her head slowly.  It’s almost like she’s under Urta’s spell.\n\n");
			outputText("“<i>Don’t worry, cutie.  I’m really close to giving you a big present of my own.</i>”  Urta doesn’t wait for any kind of response.  She just grabs Kath’s hips and starts to ram deeper, harder and faster than before.  Inside Kath you can feel your cum sloshing around, probably frothing as Urta does whatever it takes to blow her load.\n\n");
			outputText("Kath has already cum twice and been filled once.  You have to hold her shoulders to keep her from falling over.  Urta just keeps on fucking like Kath is a big feline onahole.  You can see it in Urta’s eyes - she’s so horny and so drunk that nothing but cumming matters right now.\n\n");
			outputText("At last Urta plants her cock as deep as possible.  You’re sure the tip must be " + (katherine.pregSize() > 0 ? "pressed against Kath’s cervix" : "inside Kath’s womb") + ".  Urta tilts her head back and cries out.  You can feel the heat from her balls and inside Kath your cock can sense the increasing pressure.\n\n");
			outputText("Luckily for Kath, Urta is off balance.  She falls back towards the floor, her vice-like grip on Kath’s hips dragging her down with Urta.  Your cock gets pulled free and your load begins to spill from Katherine’s ass at the same time Urta begins to inject her own.\n\n");
			if (player.cumQ() < 500)
				outputText("You see dribbles of your sperm leak down Kath’s legs while Urta’s much larger deposit forces its way into Kath’s cunt.  It doesn’t take long before " + (katherine.pregSize() > 0 ? "the puddle of spunk below them starts to grow" : "Kath looks like she’s with child") + ".\n\n");
			else if (player.cumQ() < 1500)
				outputText("With each contraction of Urta’s balls a stream of your cum gushes from Kath’s gaping asshole.  Everything you forced in is now forced back out as Urta’s load fills Katherine’s " + (katherine.pregSize() > 0 ? "vagina and then begins to squirt onto the ground below" : "womb, stretching her belly a little more than you did and making it look like Kath’s ready to deliver") + ".\n\n");
			else if (player.cumQ() < 3000)
				outputText("A fountain of cum bursts from Kath’s gaping asshole.  Everything you forced in is now forced back out as Urta’s load fills Katherine’s " + (katherine.pregSize() > 0 ? "vagina and then begins to squirt onto the ground below.  Soon the whole floor is coated in cum.  Some yours, some Kath’s, some Urta’s and all slick" : "womb, making it look like she’s ready to deliver twins") + ".\n\n");
			else {
				outputText("Your cum erupts from Katherine’s ass like a geyser.  You’re a little bit proud, both of the amount you produced and the fact your favorite kitty managed to hold it all.  But Urta’s balls aren’t waiting.  They pump their own contribution deep inside Kath’s pussy, keeping her belly fully inflated.\n\n");
				outputText((katherine.pregSize() > 0 ? "The load soon" : "When her belly is big enough to hold a centaur filly the load") + " starts to leak out, coating the whole floor in cum.  Some yours, some Kath’s, some Urta’s and all slick.\n\n");
			}
			katherine.katherineAndUrtaHadSex(true);
			outputText("Urta and Kath both start giggling and Urta starts patting Kath’s belly.  When she sees that you’re still standing Urta traps your feet with her legs and pulls you down into the sticky pile.\n\n");
			if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 1) { //First time they’ve ever had sex together
				outputText("“<i>Wow!</i>” they both say at the same time.  Then they look at each other and laugh like they’ve gone crazy.\n\n");
				outputText("Urta kisses you and says, “<i>I don’t know if I should have... but that was fun.</i>”\n\n");
				outputText("“<i>Fun and filling,</i>” says Kath, and they both have another round of drunken giggling.  You take turns rubbing their ears while Kath’s belly deflates.  You make sure to whisper that you might like to do this again sometime.  Both girls are far too tired to argue.");
			}
			else if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] < 11) {
				outputText("Urta gives you a big wet kiss and says, “<i>You must really like seeing me fill your friend." + (flags[kFLAGS.URTA_FERTILE] == 1 ? "  Better be careful, I might just knock her up." : "") + "</i>”\n\n");
				outputText("Rather than answering her you give them both a little scratch behind the ears and then collect your clothes.  You leave your lovers in a puddle of their own spunk, telling them to ‘get to know each other better’.");
			}
			else if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] < 32) { //Willing to have sober sex
				outputText("Kath hugs Urta and then you.  She says, “<i>Don’t worry.  Once we feel better we’ll clean this place up.  Oh, and thanks again for getting me to fuck your foxy girlfriend.</i>”\n\n");
				outputText("“<i>Mmmm yes.  I’m always ready to cum inside a hot kitty like you,</i>” says Urta.  “<i>You know " + player.short + ", you don’t <b>have</b> to get us wasted.  Kath and I are always willing to fuck.</i>”\n\n");
				outputText("You get a dreamy “<i>Yeah</i>” from Kath before she curls up in Urta’s arms and falls asleep.");
			}
			else { //Lovers
				outputText("Urta hugs both of you against her body and kisses each of you in turn.  “<i>You two... what would I do without you?  I can still remember the days when I just sat in the bar drinking.  Now I’m spoilt for choice.</i>”\n\n");
				outputText("Kath sniffs and says, “<i>Yeah, before you found me I never got any love.  Now I have to take breaks cause my pussy gets sore.</i>”  She snuggles up to you and Urta and you’re pretty sure she falls asleep right away, secure in the arms of her lovers.");
			}
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndUrtaHadSex(true);
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY]++;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 2 + rand(2);
			urta.urtaLove(1);
			if (model.time.hours >= 13) flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_URTAS_APT; //Katherine.timeChange will sort out whether Kath actually stays with Urta
			doNext(camp.returnToCampUseOneHour);
		}

		public function doubleStuffVala():void { //Not available if Kath has no cock
			valaCommonStart();
			outputText("When Katherine finally rips off her bra you push her back onto an old table that’s sitting in the corner.  Before she has a chance to react you spin Vala around and place her on top of Kath’s thighs, her pussy close enough to feel the heat from Kath’s shaft" + katherine.cockMultiple("", "s") + ".  The two of them look at each other" + (flags[kFLAGS.KATHERINE_VALA_AFFECTION] >= 8 ? " with lust and try to pull closer together so they can mate" : ", uncertain - but too turned on to turn back") + ".\n\n");
			outputText("You pull apart Vala’s folds, giving her pleasure and Kath a good look.  With your other hand you stroke Kath’s " + katherine.cockType() + " cock" + katherine.cockMultiple("", "s") + " and feel Vala wiggle her hips, trying to impale herself.  It’s what you want so you grip Kath’s cock" + katherine.cockMultiple(" tightly and guide it", "s tightly, forcing the tips together, and guide them") + " into Vala’s passage.  Both girls moan as the head" + katherine.cockMultiple(" sinks", "s sink") + " in.  Then you put your hands on Vala’s ass and push her forward.  You know from experience how elastic she can be and sure enough " + katherine.cockMultiple("Kath’s cock buries itself", "both Kath’s cocks bury themselves") + " to the hilt.\n\n");
			outputText("Vala’s head lolls back and you give her another kiss as your hands pull apart her asscheeks.  You certainly don’t intend to miss out on this.  You press your ");
			if (player.cocks.length == 1)
				outputText("cock against Vala’s sphincter and slowly push it inside.");
			else if (player.cocks.length == 2)
				outputText("twin cocks against Vala’s ass.  Her well trained sphincter relaxes completely and you get both of them inside.");
			else if (player.cocks.length == 3)
				outputText("triple cocks against Vala’s ass.  Her well trained sphincter relaxes completely and you manage to get all of them inside.");
			else
				outputText("three largest cocks against Vala’s ass.  Her well trained sphincter relaxes completely and you manage to get all three of them inside.");
			outputText("  It feels wonderful, especially since you can feel " + katherine.cockMultiple("Kath’s shaft", "both of Kath’s shafts") + " through Vala’s thin inner walls.\n\n");
			outputText("Katherine has been holding back despite her lust, waiting for you to get your cock" + (player.cocks.length > 1 ? "s" : "") + " in place.  Now she attacks Vala’s pussy in a frenzy.  Vala’s velvety innards tug and squeeze your cock" + (player.cocks.length > 1 ? "s" : "") + " in such a wonderful way that you start thrusting as well.\n\n");
			outputText("Between you and Kath Vala has turned into a rag doll.  Her ecstatic screams are the only proof that she loves this as much as either of you.  In fact she cums first.  Her ass starts to milk your shaft" + (player.cocks.length > 1 ? "s" : "") + " and you can see from the blissful expression on Kath that Vala’s pussy is giving her the same treat.\n\n");
			outputText("You grab Vala’s slender hips and yank her down onto your cock" + (player.cocks.length > 1 ? "s" : "") + ".  Kath’s hands slap down on top of yours and she does exactly the same thing.  Inside you feel Kath’s knot" + katherine.cockMultiple("", "s") + " inflate to full size just as the first streams of cum jet down your cock" + (player.cocks.length > 1 ? "s" : "") + ".\n\n");
			if (player.cumQ() < 1500) {
				outputText("Your " + (player.balls > 0 ? "balls have" : "prostate has") + " to work much harder than usual to force your cum past Katherine’s engorged knot" + katherine.cockMultiple("", "s") + ".  It’s somewhat painful, but after a while you can feel a small pool of your seed forming in Vala’s colon.\n\n");
				outputText("Her belly stretches out" + (katherine.cumQ() > player.cumQ()  ? " - more from Kath’s contribution than yours.  It's" : " - it's") + " incredible that Vala can hold so much.  Even on a normal woman that belly would suggest a baby on the way but on Vala it’s massive.\n\n");
			}
			else {
				outputText("Despite Katherine’s engorged knot" + katherine.cockMultiple("", "s") + " your " + (player.balls > 0 ? "balls are" : "prostate is") + " more than up to the task of filling Vala’s rear.  You have to fight against backpressure as Kath’s " + (katherine.hasBalls() ? "balls fight" : "prostate fights") + " you for the right to fill the faerie waitress.\n\n");
				outputText("You could say that both of you win and Vala loses.  Her belly stretches more than you thought possible.  By the end she looks like she’s carrying a centaur filly.\n\n");
			}
			outputText("“<i>Oh yes,</i>” Vala says weakly, “<i>it feels so good.</i>”  She rests her hand on her wobbling belly and rubs her protruding belly button.  “<i>I feel so close to both of you,</i>” she says, looking dreamily over her shoulder.\n\n");
			valaCommonPostSex(katherine.hasCock());
			outputText("She’s right, of course.  You get dressed and only pause before leaving to take a mental picture of Vala cuddling against Katherine, belly still swollen, your cum dripping from her ass.");
			player.orgasm();
			katherine.orgasm();
			katherine.katherineAndValaHadSex();
			flags[kFLAGS.VALA_TIMES_CONSENSUAL_SEX]++;
			doNext(camp.returnToCampUseOneHour);
		}

		public function eatOutVala():void { //Not available if Kath has no cock
			valaCommonStart();
			outputText("You pull Vala into your arms and then walk her backwards, toward Kath.  Vala doesn’t notice what you’re doing and Kath backs up into a wall.  You keep moving and press Vala against Kath.  Neither of them have anywhere to go and you feel the tip" + katherine.cockMultiple(" of Kath’s cock", "s of Kath’s cocks") + " poking out from between Vala’s legs.\n\n");
			outputText("Perfect!  You give each of them a kiss and then grab Vala’s ass with both hands, lifting her off the ground and spreading her cheeks as far apart as you can manage.  You tell Kath to line her " + katherine.cockMultiple("", "twin ") + katherine.cockType() + " member" + katherine.cockMultiple("", "s") + " up with Vala’s ass but it’s Vala who reacts first.  With the speed and agility you’d expect from a faerie she takes Kath’s cock" + katherine.cockMultiple(", spreads some pre over the shaft and lines it", "s, spreads some pre over the shafts and and lines them") + " up with her butt.\n\n");
			outputText("You lower her and Vala sighs as Kath’s rod" + katherine.cockMultiple(" rams", "s ram") + " home.  You take Katherine’s hands and place them on Vala’s tiny waist, telling Kath to give her a good hard fucking, Vala can take it.\n\n");
			outputText("Vala squirms and locks her legs behind Kath.  She starts to beg, “<i>Yes, fill me, use me!  Give me all you’ve got!</i>”  You wait for them to develop a rhythm and then you bend down, sinking your tongue into Vala’s empty pussy.  She cries out as you lap up her sweet nectar.\n\n");
			outputText("When Vala starts to cum you back off, letting her body twist and turn under the effects of her orgasm.  You stand and take Katherine by the shoulders, leading her toward a table.  She’s concentrating so hard on fucking Vala that she just goes along with whatever you want.\n\n");
			outputText("They reach the table and you push them forward.  If you didn’t know how tough Vala is you’d worry that Kath was going to crush her.  Instead you hear moans from beneath the cat " + katherine.catGirl("girl", "morph") + " as Vala continues to cum.\n\n");
			outputText("But it’s not Vala you’re interested in.  Instead you stick your tongue into Kath’s pussy, which has been ignored until now.  You find it ripe, her juices dripping out and trailing down her thighs.  Kath is ready for harvest and you’re happy to oblige.\n\n");
			outputText("As you run your tongue across her clit you feel a surge of heat in the knot" + katherine.cockMultiple("", "s") + " just above your head.  Kath slams into Vala and her " + (katherine.hasBalls() ? "balls go" : "prostate goes") + " to work, injecting a salty filling into Vala’s ass.  Both of them are lifted away from the table as Vala’s belly grows larger and larger.\n\n");
			outputText("The first to recover is Vala, who says, “<i>that feels so good.</i>”  She rests her hand on her wobbling belly and rubs her protruding belly button.");
			valaCommonPostSex(katherine.hasCock());
			outputText("Kath flips over so that she’s lying on her back with Vala sitting upright on top of her.  Vala smiles at you and mouths, “<i>thank you,</i>” before collapsing herself, causing an “<i>Oof</i>” from Katherine.  You leave your lovers to it and step out into the bar, only remembering at the last second to wipe their fluids from your chin.");
			dynStats("lus", 10 + player.lib / 20);
			katherine.orgasm();
			katherine.katherineAndValaHadSex();
			flags[kFLAGS.VALA_TIMES_CONSENSUAL_SEX]++;
			doNext(camp.returnToCampUseOneHour);
		}

		public function fistKathAndVala():void {
			valaCommonStart();
			outputText("You tell Vala to sit down and give you a second.  She pulls out a stool that looks like it has seen better days and sits down, her legs spread wide and her fingers on her nipples to keep the juices flowing.\n\n");
			outputText("Next you deal with the horny kitty.  You get behind Kath and wrap your arms around her naked body, teasing her nipples and putting on a show.  Vala lets out an appreciative, “<i>Mmmm, yeah,</i>” as she watches you bring Kath's lust to the boil.  When Kath melts into your arms, giving up any hope of control, you drag her to another battered chair and plop her down.\n\n");
			outputText("You grab Vala's seat and drag both it and the lightweight faerie closer, so that she and Kath are sitting side by side.  In their state proximity is enough; the two girls lean in and lock lips.  You wait for them to become distracted by their dueling tongues, then you simultaneously slide your fingers between their hot, wet labia.  Slowly, gently, you slip in more and more fingers on each hand, managing to get everything but your thumbs in before their heads pull apart.\n\n");
			outputText("“<i>" + player.short + "?</i>” Vala asks, “<i>aren't you going to... to... oh!</i>”  You never learn what she was trying to say.  Your talented fingers keep her busy until Kath decides she's tired of waiting.  She grabs Vala's head and pulls her in for another kiss.\n\n");
			outputText("Vala gets back to kissing but her hands find Katherine's tail.  It's been flicking back and forth, sometimes coiling itself around Vala's waist, but now the faerie starts using her delicate fingers to tease the tip.  Kath groans and " + (katherine.hasCock() ? "her ignored manhood jiggles in time with her heartbeat" : "her whole body shakes from the unexpected stimulation") + ".\n\n");
			outputText("Since Vala isn't playing fair Kath slides her hands across the faerie's sensitive nipples, then reaches around Vala and begins to massage the muscles near the roots of her wings.\n\n");
			outputText("With both girls doing all they can to drive the other mad their pussies are becoming totally drenched.  You think they're loose enough, so you bend your fingers and thumbs and push your palm inside each of them.  Their flesh yields just enough and when the girls break their kiss again they look down to see you've worked your hands in up to your wrists.\n\n");
			outputText("“<i>Gently,</i>” begs Kath, but you're having none of it.  You know what these girls like and you twist your fists back and forth within them, your knuckles sliding past their sensitive nerves.  They stop arguing and throw back their heads.  Only Kath's death grip around Vala prevents them both from falling off their chairs.\n\n");
			outputText("Vala releases Kath's tail and hugs her back, lost in ecstasy.  You get quite a show as Kath and Vala play with each other's bodies, but you concentrate most on the feelings from the digits you've crammed inside them.\n\n");
			outputText("You map out their favorite spots and wait until you belive they're both on the edge of cumming.  Then you hit all the good spots one after the other and are rewarded as two pussies clamp down on your fists.  The girls jerk and shake as one orgasm after another slams through their bodies.");
			if (katherine.hasCock())
				outputText("  Kath's cock" + katherine.cockMultiple("", "s") + ", which you've ignored this whole time, " + katherine.cockMultiple("springs to life and blasts", "spring to life and blast") + " you and the surrounding area with a hefty load of spooge.");
			outputText("\n\nAfter some gasping and panting both girls find the power of speech and thank you profusely for the ride you just took them on.");
			outputText("Vala gets a mischevious gleam in her eye.  ");
			valaCommonPostSex(false);
			outputText("After you extract your hands and clean yourself off you notice Kath has pulled Vala into her lap and is just holding her.  Vala smiles at you like all is right with the world and you give each of them a kiss before leaving.");
			dynStats("lus", 10 + player.lib / 20);
			katherine.orgasm();
			katherine.katherineAndValaHadSex();
			flags[kFLAGS.VALA_TIMES_CONSENSUAL_SEX]++;
			doNext(camp.returnToCampUseOneHour);
		}

		private function valaCommonStart():void {
			clearOutput();
			outputText("You put your arms around both of them and cop a feel.  From Kath you get a pleased purr and from Vala a contented sigh.  You tell them both that you’ve got an idea and lead them toward the back of the bar.\n\n");
			outputText("As soon as you lock the door you decide to concentrate on Vala.  Pinching her nipples and kissing her deeply gets her in the mood awfully quickly.  Looks like she wasn’t just bored but horny too.\n\n");
			outputText("You turn, expecting " + (flags[kFLAGS.KATHERINE_VALA_AFFECTION] > 5 ? "Kath to have readied herself.  Sure enough" : "to have to convince Kath of what you want.  Instead") + " you find her part way through stripping her clothes off.");
			if (katherine.hasCock()) outputText("  Her cock" + katherine.cockMultiple(" is hard enough that it's", "s are hard enough that they're") + " jutting out horizontally.");
			outputText("\n\n");
		}

		private function valaCommonPostSex(theyWereFucking:Boolean):void { //This bit happens in all three Vala sex scenes
			if (flags[kFLAGS.KATHERINE_VALA_TIMES_SEX] == 0) {
				outputText("She looks back at Kath and says, “<i>Oh - I’m Vala, by the way.</i>”\n\n");
				outputText("Kath’s jaw drops and she stammers, “<i>Hi, I’m Kath, Katherine.  I’m sorry, I don’t usually do stuff like this.</i>”\n\n");
				if (theyWereFucking) {
					outputText("Vala giggles and puts Kath’s hand on her belly before replying, “<i>You mean like knotting a girl and filling her belly with your seed without even knowing her name?</i>”\n\n");
					outputText("Kath looks totally embarrassed until Vala reaches down and rubs the base of Kath's knot" + katherine.cockMultiple("", "s") + ".  ");
				}
				outputText("She gives Kath a kiss and says, “<i>I don’t do this kind of thing either.  Lets just keep this our little secret, huh?</i>”");
			}
			else {
				outputText("She gives you and then Kath kisses in turn " + (theyWereFucking ? "before patting her massive belly and saying" : "and says") + ", “<i>This was a lot of fun and I hope it isn’t a one time kind of thing." + (theyWereFucking ? "  I love feeling full like this." : "") + "</i>”");
			}
			outputText("\n\nKath sighs and rubs Vala’s " + (theyWereFucking ? "belly" : "chest") + ".  She’s so relaxed that she looks half-asleep.  “<i>Mmmm - " + katherine.playerText() + (theyWereFucking ? "... I think we’re going to be here together for a while.  Maybe" : "... maybe") + " you should get going and check up on that portal of yours.  We’ll deal with the mess.</i>”\n\n");
		}

	}
	
}