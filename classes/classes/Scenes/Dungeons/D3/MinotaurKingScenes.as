package classes.Scenes.Dungeons.D3
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.StatusEffects;
	import classes.PerkLib;
	import classes.Items.WeaponLib;
	import classes.PregnancyStore;
	import classes.CockTypesEnum;
	
	public class MinotaurKingScenes extends BaseContent
	{
		 
		public function MinotaurKingScenes()
		{
			super();
		}
		
		public function encounterMinotaurKing():void
		{
			clearOutput();
			outputText("The moment you step away from the defeated demon, Lethice’s assembled host parts like some kind of tentacled sea, revealing a path that would lead directly to the Queen of Corruption were it not barred by a form out of nightmares. A minotaur like none you’ve ever seen bars your path - the last obstacle before a face-to-face encounter with the cause of so much discontent.");
			outputText("\n\nEven for one of the bovine beast-men, he’s a giant among giants. His broad shoulders seem ready to scrape the gilding from the cavernous chamber. His crimson-rimmed eyes glare down like a pair of low-burning coals. Stretching from end to end, a cow-girl could barely touch each end of his wide-spread horns. If it weren’t for the three feet of glistening, freshly-fucked maleness jutting from between his legs, he’d look almost regal.");
			outputText("\n\n<i>“You’re strong, Champion, but your quest ends here,”</i> the brute promises. He snorts and extends a hand toward the crowd. <i>“Excellia, my weapon.”</i>");
			outputText("\n\nA vision of curves and ripe sexuality emerges from the curtain of wet and wiggling flesh. She’s at least part cow, with upraised horns and a happily flicking tail - to say nothing of her egregiously supple breasts, still leaking milk from a recent suckle or their own overtly-abundant production. In her hands is a massive axe; it’s too large to be wielded by human hands.");
			if (flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] != 0)
			{
				outputText(" Even Isabella would struggle to wield such a weapon.");
			}
			else if (player.findStatusEffect(StatusEffects.CampMarble) >= 0)
			{
				outputText(" Even Marble would struggle to wield such a weapon");
			}
			else if (getGame().helFollower.followerHel())
			{
				outputText(" Even Helia would struggle to wield such a weapon.");
			}
			outputText(" This poor cow-slut, this ‘Excellia’ can barely to bring it to her lord without tipping forward onto her too-large tits.");
			outputText("\n\nTaking the gleaming metal shaft from his smaller slave, the proud beast stamps the butt-end into the worked stone floor, creating a spiderweb of cracks from brute strength alone.");
			outputText("\n\n<i>“Careful not to damage my property, oh King of the Minotaurs. Remember within whose feast-hall you dwell,”</i> a chilly, yet feminine voice calls.");
			outputText("\n\nEars twitching in irritation, the royal brute inclines his head ever so slightly. <i>“Your property, yes. I’ll not damage your precious floors, but this one... this Champion... " + player.mf("he","she") + " will be mine.”</i> The corners of the minotaur’s lips quirk upward in time with his tremendous erection. <i>“Do not make this more painful than it has to be.”</i>");
			outputText("\n\nYou’ve got a metric fuckton of muscle in between you and the end of this sick, twisted journey. Once more, you’ll have to fight.");
			player.createStatusEffect(StatusEffects.MinotaurKingMusk,0,0,0,0);
			startCombat(new MinotaurKing());
		}
		
		public function theKingIsDeadLongLiveTheKing(hpVictory:Boolean):void
		{
			flags[kFLAGS.MINOTAURKING_DEFEATED] = 1;
			clearOutput();
			outputText("The King’s axe clatters on noisily on the ground. A gasp runs through the corrupt host as one of their mightiest champions drops to his knees, staring at his dick and furiously pumping it with both hands. Nearly insensate with need, he topples over, humping his own hands with so much enthusiasm that he’s lost interest in anything but immediate sexual gratification.");
			outputText("\n\nA slow, quiet clap begins from the rear of the room. <i>“Well done, Champion... quite well done.”</i> The Queen herself is smiling at you, though her eyes are as cold as dark ice on a winter’s eve. <i>“Avail yourself of your prizes. It wouldn’t be sporting to take you on while you’re all worked up. My underling’s loyal retainers might get the wrong idea about my strength.”</i> Her eyes flash dangerously.");
			outputText("\n\nOf course. If she preyed on you while you were still recovering from the minotaur, her subordinates might think her weak or afraid. You have a semi-conscious royal and his cow-slut to use as you will. Or you could just put them out of their misery.");
			if (player.cor <= 33)
			{
				outputText(" The poor things are so corrupted.");
			}
			menu();
			addButton(0,"Kill Them",this.murderhobo);
			var smallCockIdx:int = player.smallestCockIndex();
			if (smallCockIdx != -1)
			{
				addButton(1,"Docking",this.dockucocku,smallCockIdx);
			}
			if (player.hasCock())
			{
				if (player.cockThatFits(200) >= 0) addButton(2,"Buttfuck",this.buttufucku);
				addButton(3,"Titfuck",this.titfuckCowslut);
				addButton(4,"SloppySeconds",this.sloppySeconds);
			}
			if (player.hasVagina())
			{
				addButton(5,"Ride Him",this.mechanicalbullhue);
			}
		}
		
		private function murderhobo():void
		{
			flags[kFLAGS.MINOTAURKING_KILLED] = 1;
			clearOutput();
			outputText("You make it quick, then straighten to stare Lethice in the eye. You’ll purge every single ounce of corruption from this world by any means necessary.");
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		private function dockucocku(cockIdx:int):void
		{
			flags[kFLAGS.MINOTAURKING_FUCKED] = 1;
			clearOutput();
			outputText("With a dick that big and that hard at your disposal... you could do something that some might consider crazy, something with enough erotic potential that it makes your [cocks] even harder than the fuck-scent in the air and the nude, well-endowed figures before you.");
			outputText("\n\nThe wildly flaring tip of the Minotaur King’s dick is neatly adorned with a nice, big cumslit, one that’s spread wide by pre-cum even now. It’s big enough to be a pussy. Bigger than some goblins’ pussies, you bet, and twice as wet looking. The three medial rings that stud the length between sheath and tip would make great grips for your hands, the better to hold onto while you literally fuck the exotic minotaur-dick. You briefly wonder if those extra rings make such cocks even more pleasurable to ride than");
			if (player.countCocksOfType(CockTypesEnum.HORSE) > 0)
			{
				outputText(" a horse-dick like yours");
			}
			else
			{
				outputText(" the average equine prick");
			}
			outputText(", but you discard the thought as irrelevant.");
			outputText("\n\nYou’ll be the one doing the fucking this time.");
			outputText("\n\nYou grab the monarch’s masturbating hands and pull them from your prize, a task made easier by his physical exhaustion. He grumbles weakly, but when your fingers make contact, he abruptly goes quiet, realizing that someone else may do him the favor of bringing him off. Little does he know just what you have planned. His jet-black member is slicker than you would have thought possible, coated with layer upon layer of jism. Your hands feel buttery after the briefest contact, like you’ve dipped them in a vat of grease.");
			outputText("\n\nHis bulging flare and unique anatomy help you to wrangle the rebelliously twitching boner, aiding you in holding still while you line [cock " + cockIdx + "] up with the dribbling slit. His flesh is hot in your hands, and his free-flowing fluids feel like bathing warm oil on your [cockHead " + cockIdx + "]. You tremble, awash in the delirious desire to thrust it home all at once, to impale this massive beast-cock on your smaller length in one massive stroke.");
			outputText("\n\nBut you hold back for now, starting by gently easing your [cockHead " + cockIdx + "] into the welcoming embrace of the Minotaur King’s larger erection. He grunts in discomfort at the sensation, weakly craning his head up to watch you, but after a second he slumps right back down on the ground, moaning. He’s too turned on to care that you’re feeding inch after inch of your penis into his own; he’d accept anything that would get him off at this point. What a slut.");
			outputText("\n\nYou waver momentarily, bathing your [cock " + cockIdx + "]");
			if (player.balls > 0)
			{
				outputText(" and [balls]");
			}
			outputText(" in the steady flow of pre that leaks around your dong, savoring this moment for what it is. You might not get another chance to do something like this once you take down Lethice, and you want it to be memorable. Grinning up at her, you mouth, <i>“You’re next,”</i> and resume feeding the rest of yourself into your cylindrical fucktube.");
			outputText("\n\nThe inside is tight, blessedly tight, but so wet that you could probably slide two of yourself in side-by-side and still manage to enjoy yourself. You squeeze down with your fingers the moment you hilt yourself, cranking the pressure up another notch. The defeated beast-man’s heart is hammering, sending rolling waves of pneumatic pleasure through his cock-pussy, massaging you with his own excitement.");
			outputText("\n\nFeeling generous, or at least turned on enough not to care, you catch some of the drooling pre in your hand and slather it over the hulk’s glistening prong. A beast like this deserves to be rewarded for being so complacent, so you begin to fuck him and stroke him, working him to a simultaneous beat, stimulating his gigantic cock from inside and out. You swear, the sweltering fuck-tube is getting warmer, or at the very least wetter, like your [cock] could just melt into a puddle of ecstatic bliss.");
			outputText("\n\nOr maybe that’s just some of the royal brute’s druggy pre-cum backflowing into your own urethra. It’s hard to tell. You fuck him faster, grunting with the effort, plowing the rigid horse-dick with your own so hard that the cum-slut gapes sloppily when you accidentally pull out. You feed yourself right back in and resume humping, plowing this magnificent-smelling slut for all your worth. He’s so big and so virile, but with your smaller dick inside him, he’s little more than willing whore, desperate to be fucked.");
			outputText("\n\nYou inhale deeply, filling your lungs with his potent pheromones, riddling your body with corrupted arousal as you pass the point of no return. You’re going to blow inside this beast-man’s cock and backfill his balls with a spunky surprise. There’s no avoiding it. Orgasmic pleasure is flooding your mind, demanding your hips slap hard into the blunted tip of your fuck-toy, urging you to impregnate the wet-and-willing orifice you’ve been presented with.");
			if (player.cumQ() <= 500)
			{
				outputText("\n\nYou cum in one moment of pure, beatific release, unloading every drop of spunk directly into the minotaur’s urethra. His face screws up from the feeling of foreign fluids flowing backwards through his body. You can only imagine where your jizz is flowing, what parts of the minotaur’s body is being assaulted by sperm. You hope some made it to his bloated balls.");
			}
			else if (player.cumQ() <= 2500)
			{
				outputText("\n\nImpregnate is a mild term for what you do. You flood the powerful monster’s most masculine places with thick spurts of your virile cream, spending it so deeply in his body that it has nowhere to flow but deep into his form. You swear you even see his balls bulge slightly. Still blissed-out and squirting into him, you heft one of the swollen orbs and feel it twitch an influx of new, fluid weight.");
			}
			else
			{
				outputText("\n\nYou cum like a firehose, spraying a deluge of sticky spunk straight down the minotaur’s cock. His body may have been ready to expel such flows, but never to take one in. He grunts in what you take for discomfort and stares in horror at the bulges of fluid disappearing into his sheath, spreading through his body and collecting in his balls. You can actually see his nuts swelling up with all the pumped-in sperm, absolutely bloated with the fruit of your loins. Hefting one, you feel the extra fluid slosh as you fill it, marvelling at your own virility.");
			}
			if (!player.hasKnot())
			{
				outputText("\n\nSatisfied at last, you pull out with lurid ‘schliiiick’ sound. A few of the assembled demons clap and catcall, but most surprising of all is the monarch’s own roar of bliss, followed shortly after by his powerful hips lifting up off the floor. The well-fucked horse-cock erupts like a long-dormant volcano, spraying jizz from its sloppy, stretched slit until minotaur spunk is raining over the assembled crowd. Many of the demons immediately fall into fucking one another, but you have the good sense to avoid the bulk of it.");
				outputText("\n\nAgain and again, those powerful, shaggy hips lift, and each time, more cow-cream explodes into the air, mixed with something else. Something better. Champion cum. Excellia is revitalized by erotic monsoon and manages to climb on top before he finishes, riding him like the bucking bronco that he is.");
				outputText("\n\nNeither of them will be standing in your way any time soon. Time to deal with Lethice.");
				combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
			}
			else
			{
				menu();
				addButton(0,"Next",this.dockucockuknotu,cockIdx);
			}
		}
		
		private function dockucockuknotu(cockIdx:int):void
		{
			clearOutput();
			outputText("When you try to pull out, there’s a problem: your knot. It inflated while you were cumming, and now that you’ve finished, it has expanded to lock you inside your unusual mate. No matter how you tug or pull, you can’t seem to extricate yourself from the cream-filled cow-man, and worse still, he’s starting to moan and squirm. Getting filled full of your spunk must have been more enjoyable for him than you thought.");
			outputText("\n\nThe Minotaur King is moaning, and his cock is getting still harder in your hands, making it even harder to pull yourself free. Panicked now, you tug in vain, anything to get free before your cum and a wave of bovine beast-cum flows back into you. Your [feet] slip in the puddled juices, and the surging bull’s member pulls you over onto his chest, still joined at the crotch. He catches you, holding you an angle so as not to damage either of your members, and then you feel it: pre-cum mixed with your liquid relief pushing back into your [cock " + cockIdx + "].");
			outputText("\n\nOrgasmic pressure has reversed the liquid flow, and the moment his hips lift from the floor, carrying you with them, the pressure redoubles, turning your urethra into a minotaur cum pipeline. Some of your own is mixed in of course, but you’ve never had the alabaster jism applied to your body so directly. You sag bonelessly into the brute’s grip as he turns you into his personal twinkie");
			if (player.balls == 0)
			{
				outputText(", fat with bull-cream.");
			}
			else
			{
				outputText(". Your [sack] swells larger and larger, complete with the realization that your [balls] are being transformed into spooge-filled balloons.");
			}
			outputText("\n\nYou should be alarmed or worried, but mostly you’re amazed by how good it feels. How great it feels to go limp in his powerful arms. How wonderfully warm and content his narcotic spooge makes your body feel. You drool on his chest, then lick it back up, savoring the salty, sweaty tang of it. Your mouth feels empty without his cock, but then you realize you can suck his nipple until his cock is free.");
			outputText("\n\nMinotaurs are so great. A fuzzy memory of some other desire tries to make itself known, but another buck of your bull’s hips has your head swimming and your body cumming. The pressure of your own ejaculation is nothing next to his of course. You doubt you could squirt anything out ever again. Your insides must be all stretched out with your lord’s love, but that’s fine so long as he uses you again. You can be his dribbly little spunksleeve.");
			getGame().gameOver();
		}
		
		private function buttufucku():void
		{
			var x:int = player.cockThatFits(200);
			flags[kFLAGS.MINOTAURKING_FUCKED] = 1;
			clearOutput();
			outputText("Why fuck the spoiled tart when you’ve got such a virile, muscular specimen at your beck and call? He’s pumping his cock with wild, frenetic strokes, spurting bullet-sized bursts of pre-cum over his musky balls and abdominal fur, but no matter how he tugs or squeezes, he doesn’t seem to be getting any closer to release.");
			outputText("\n\nHow perfect. You shed your [armor], intent on a little relief yourself. Normally a brute like this might take offense to the forceful claiming of his backdoor. Now, when he’s writhing and bleating, begging the demons in the audience to mount him and provide relief? He’ll accept anything you give him, even if it’s a thorough prostate pounding. Your [cocks] swell");
			if (player.cocks.length == 1)
			{
				outputText("s");
			}
			outputText(" at the thought, growing hard and firm, ready to batter through the bull’s clenching ring. This is going to be fun.");
			outputText("\n\nYou kick the minotaur King’s legs apart for better access and sidle in close, one hand idly pumping at " + player.cockDescript() + " while you do your damnedest not to give in to the delicious scent. No matter how pernicious the desire to indulge in his aroma, how wonderful it would be to press your cheek against that pillar of masculinity and lick, you know you have to resist it or you’ll forget all about getting yourself off and taking down Lethice.");
			outputText("\n\nShe’s watching you too. Her hungry, soulless eyes are watching you stroke your cock, watching you line it up with the angry pucker of the minotaur King’s asshole. The corrupt Queen licks her lips when you push forward. You rub your " + player.cockHead(x) + " against her most trusted servant’s entrance, slowly splitting his derriere, reshaping it into a vessel for your pleasure. He’s tight, tighter than you would expect from such a massive creature. His asshole clutches at every inch of cock you feed it, almost like it wants to squeeze you off, to massage you with rapt enthusiasm.");
			outputText("\n\nThe royal minotaur’s pained moo tells quite the different story. His horned visage stares down at you in disbelief, but his cock perceptibly plumps between his fingers, displaying a network of bulging veins all too happy to have you stimulate him from behind. Slapping his ass, you give him more of what his body so unsubtly craves. You thrust");
			if (player.biggestCockLength() >= 24)
			{
				outputText(" until his belly bulges with the clear outline of your " + player.cockDescript(x) + ", displaying just how fully he has been taken to the entire assemblage. You’ve claimed this once noble beast, turned his body into a fuzzy, pleasant-smelling condom for your excessively-large cock.");
			}
			else if (player.biggestCockLength() >= 12)
			{
				outputText(" until you’ve fed his ass the whole of your girthy rod");
				if (player.hasKnot())
				{
					outputText(", knot and all");
				}
				outputText(". A visible bulge presents itself on the once-noble beast’s belly, declaring your dominion over him for all to see. Whatever he was before, he’s your cock-sleeve now.");
			}
			else
			{
				outputText(" until you’ve buried the entirety of your " + player.cockDescript(x) + " inside his snugly squeezing intestines, repurposing his digestive system into your own personal, phallus playground.");
			}
			outputText("\n\nThis really is a first class asshole. It’s elastic enough to take anything you could offer it and strong enough to provide the perfect amount of friction. Whenever that friction flags, you can just slap him on the ass, and he tightens right up. Best of all, his constantly-dribbling pre-spunk inevitably drips down onto your member as you saw it between his buttcheeks, lubricating you with enough of the sticky to stuff to making fucking him an absolute breeze.");
			outputText("\n\nWhat a waste of perfectly good muscle. All this time, this big, slutty minotaur has been free to wander around ramming his cock inside of everyone else when he had a treasure like this packed between his tight, toned buttcheeks. Grabbing hold of his thighs, you snarl and pound his ass harder. Your heartbeat is hammering in your ears. Your dick is hard enough to chisel stone, and you’re having a really hard time seeing anything past the swaying horse-cock a few inches in front of you.");
			outputText("\n\nThe King’s cock stands straight upright, three feet of heavenly member with a flare that seems wider by the second. You delight in drilling into him, humping inward and upward to rub against the edge of his prostate. Whenever you hit it, his dick’s dribbles turn into squirts. Some falls on your [hair] and nose, but you wear it as a badge of honor, proof of just how much you’re making this once-proud minotaur a slave to the anal pleasures you’ve given him.");
			outputText("\n\nHe wriggles and twists, on the edge of a no-doubt impressive orgasm. You’re right there with him too. His ass is a cock heaven");
			if (player.cocks.length > 1)
			{
				outputText(", and the feeling of your other member");
				if (player.cocks.length > 2)
				{
					outputText("s");
				}
				outputText(" slipping and sliding past his quivering balls certainly doesn’t hurt");
			}
			outputText(". If you didn’t have better things to do, or his scent toying with your mind, driving your ardor higher and higher the longer you breath it in, you could savor this for hours. But you’re dizzy with need and in a hurry.");
			outputText("\n\nDeciding to give yourself a little reward, you lean forward and slip your tongue against the pre-soaked surface of the King’s majestic cock, trembling in orgiastic ecstasy as the taste pushes you over the edge.");
			if (player.hasKnot())
			{
				outputText(" Your knot balloons.");
			}
			else if (player.countCocksOfType(CockTypesEnum.HORSE) > 0)
			{
				outputText(" Your flare expands right on cue, matching the one pressing back against your tongue.");
			}
			else
			{
				outputText(" His flare blooms with all the force of a mushroom cloud, nearly pushing your tongue back into your mouth.");
			}
			outputText(" You erupt a split-second before he does, squirting thick ropes of jism into his sucking asshole. Then he goes off, shooting a torrent of spunk twenty feet into the air. Horned goblins dance in the deluge, tongues extended and hands cupped to catch as much as possible.");
			outputText("\n\nSome lands in your mouth while you’re moaning and cumming, hot and fresh, somehow making your orgasm hotter still, juicier than you can truly comprehend.");
			if (player.cumQ() > 2500)
			{
				outputText(" The King’s belly swells");
				if (player.biggestCockLength() >= 18)
				{
					outputText(" even bigger");
				}
				if (player.cumQ() > 5000)
				{
					outputText(", but you’re far from done. You pressurize his entire digestive system. The last few ejaculations backblast out over");
					if (player.balls > 0)
					{
						outputText(" your balls");
					}
					else
					{
						outputText(" your crotch");
					}
					outputText(", creating a sticky, salty puddle on the floor");
				}
				outputText(".");
			}
			outputText("\n\nThe beaten brute squirms and writhes long after you both of you finish cumming, lost in barely understood pleasure. You pull out before his over-eager motions carry you with him, noisily licking his residue from your lips and preparing to get on with your business. The taste might be keeping you hard, but you feel more than sated enough to take on a demon queen.");
			player.orgasm();
			dynStats("lus",10);
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}	
		
		private function mechanicalbullhue():void
		{
			flags[kFLAGS.MINOTAURKING_FUCKED] = 1;
			clearOutput();
			outputText("Well, you’ve been handed a prize bull on a silver platter, why not help yourself to his delectable meat? It’s right there, trembling with need and polished to perfection by his erstwhile lover’s affections. It’d slip right in");
			if (player.averageVaginalLooseness() <= 3)
			{
				outputText(", probably");
			}
			outputText(".");
			if (player.averageVaginalLooseness() == 4)
			{
				outputText(" One of the perks of having experience with well-endowed lovers is not having to second-guess yourself when you come upon a real treat like this one.");
			}
			else if (player.averageVaginalLooseness() < 4)
			{
				outputText(" You’re not the most experienced at handling such well-endowed studs, but even if you’re wrong, nothing beats trying.");
			}
			else
			{
				outputText(" A big thing like that would stretch you so wonderfully. You barely manage to swallow before you start to drool.");
			}
			outputText(" All you have to do is climb on. Excellia doesn’t look like she’d mind.");
			outputText("\n\nAnd the King still smells like sex filtered through an angel’s veil, like endless hours of bareback plowing in a pristine, flowering field. You nose twitches as you approach, and your cunny");
			if (player.wetness() >= 4)
			{
				outputText(" gushes, drenching your thighs");
			}
			else if (player.wetness() >= 3)
			{
				outputText(" drools rivulets of desire down your thighs");
			}
			else
			{
				outputText(" drenches itself anew");
			}
			outputText(". Part of you is tempted to drop to");
			if (!player.isNaga() && !player.isGoo())
			{
				outputText(" your knees");
			}
			else
			{
				outputText(" the ground");
			}
			outputText(" and take him into your mouth, to see if he tastes as good as he smells. You could take him deep into your throat until your nose nestles deep into the curly brush of his pubic hairs, fully immersed in the taste and scent of this bastion of masculinity.");
			outputText("\n\nA taste just won’t do. The empty ache of your throbbing quim won’t abide you wasting your time with senseless oral, not when a ribbed column of pussy-pleasing fuckmeat is this close at hand. Droplets of feminine leakage spatter the monarch’s shaggy fur behind you while you climb into position above the mountainous member. Your lips are so inflamed that you swear you can feel them squishing and sliding against the hard nub of your clit with every shift of your hips.");
			if (player.hasCock())
			{
				outputText(" Your dick");
				if (player.cocks.length > 1)
				{
					outputText("s");
				}
				outputText(" twitch");
				if (player.cocks.length == 1)
				{
					outputText("es");
				}
				outputText(" along with the eager beats of your heart, and in a moment of weakness, you lean down to drag your " + player.cockHead(player.biggestCockIndex()) + " along the Minotaur King’s length. It is but a brief dalliance - foreplay before you put him where he belongs. With a regretful sigh, you stop frotting and line him back up.");
			}
			if (player.averageVaginalLooseness() >= 5)
			{
				outputText("\n\nEasing his tremendous dick into your gaping cunt feels like the most natural thing in the world. All your previous encounters were nothing more than practice to take this bestial rod deep inside yourself. It’s flaring too, imbued with more lust than any mere mortal was meant to handle, swelling to push and stroke against your straining walls as it nestles its way inside of you. It’s perfect. To find such a perfectly-shaped lover so close to your goal... you couldn’t have planned it any better.");
			}
			else if (player.averageVaginalLooseness() >= 1)
			{
				outputText("\n\nThe first attempt to guide the King’s cock into your anxious slit is nearly a failure. The flaring, flat-headed tip spreads you open, but not nearly far enough for it to slide into your honey-coated cavern. Grunting in distress, you give it a little wiggle, slipping the left side of the horse-like cock inside before working in the other. You have to stop, gasping and panting at the raw sensation of it, struggling to come to grips with it before you can continue your delectable descent. Never before have you been so wholly filled with cock, and you’re just now lowering yourself down the rest of the way.");
			}
			else
			{
				outputText("\n\nYour first attempt to force the fleshy totem into your virginal");
				if (!player.hasVirginVagina())
				{
					outputText("-looking");
				}
				outputText(" gates meets with about as much success as one could expect. Despite the almost hilarious mismatch in the sizes of your genitalia, you’re determined to take it all. Holding it in both hands, you press against the flared tip, gyrating your lips against the blunt crown until his pre and your juices are intermingled into a fuck-happy slurry. Then, one of your lips catches on the edge of his beastly flesh, pulled apart with surprising elasticity.");
				outputText("\n\nYou repeat the action on the other side and gasp in delight as your entrance blooms like an exotic flower, opening up to reveal its pink-tinged interior to its mate. Somehow, your [vagina] is opening wider and wider, and it doesn’t hurt in the slightest. Perhaps the bath of royal pre-spunk is loosening it up, or maybe the Minotaur King is blessed with some sort of inherent magic that allows him to claim even the smallest of willing females as his own. Either way, it’s for the best.");
				outputText("\n\nYou go from a needful vacuum of sensuous hunger to more stuffed than a Christmas turkey in all of about five seconds, and you couldn’t be happier. The torment of an empty, unfilled pussy has been replaced with a seductive pleasure that steals your breath and addles your reason. You wish you could somehow be even wetter, even hotter, to wring still greater surges of bliss from your sex.");
			}
			outputText("\n\nThree rings are the next challenge standing between you and total impalement. Equidistant along the Minotaur King’s shaft, those medial rings are small but significant obstacles along your erotic journey. The first actually bumps against your [clit]");
			if (player.hasCock())
			{
				outputText(", stimulating the base of your jutting she-dick");
			}
			outputText(". You reverse direction and slide up, filling the air with the sloppy sound of withdrawing phallus, then drop back down, using the momentum to spread your buttery lips over the first obstruction. Your eyes actually roll back from the raw sensation of it.");
			outputText("\n\nSplashes of warm pre-cum splatter off of your cervix. The big boy likes it.");
			outputText("\n\nIt’s hard to think about much right now. Whether it’s his pheromone-laced scent pushing you into an artificial heat");
			if (player.lust >= 80)
			{
				outputText(" - not that you needed much help -");
			}
			outputText(" or his unbelievably potent fluids addling your mind, you find it hard to care. The heat burning");
			if (Boolean(player.isBiped()) || Boolean(player.isTaur()))
			{
				outputText(" between your legs");
			}
			else
			{
				outputText(" in your loins");
			}
			outputText(" is too demanding, too all consuming to mind one way or the other. Why should it matter anyway? You’re going to bounce on this lordly stud’s prick until your pussy is raw and flooded, bathed in spunk.");
			outputText("\n\nYou hear the quiet pop of another ring entering your pussy. Drizzles of excitement slide out around him, and in between moans, you’re shocked to realize that you nearly came. Your hand winds down to your [clit] to finish the job.");
			outputText("\n\nBelow, the bull king is groaning and grunting. One meaty hand cradles your [butt]");
			if (!player.isTaur())
			{
				outputText(" in its entirety");
			}
			outputText(" while his hips lift to meet your downward strokes. A cylindrical bulge distends your belly. The assembled audience can actually watch the progress of his member into your canal. They can see the head flare wider when your cunt pleases him");
			if (player.tallness <= 50 && player.thickness <= 4)
			{
				outputText(", stretching your skin until it shines");
			}
			outputText(".");
			outputText("\n\nWhen the hand on your [butt] abruptly firms its grip and begins to pull you down, you lose it. Your eyes cross. Your back arches. Girlcum erupts from your pussy, soaking into the sensitive skin of the brute’s sheath just in time for your quivering folds to kiss it. You’ve taken his third ring, slid the whole way down to his base, all without any awareness of it. Like finding a needle in a haystack, picking apart the individual notes of pleasure thrumming through your mind is impossible. It’s like a white wave of bliss that slashes back and forth between your ears, yoked to the tempo of the up-and-down slide of your [vagina].");
			outputText("\n\nYou slap your spasming fingertips down against the beast-man’s sweat-oiled chest, needing the leverage to hold yourself upright. Your muscles aren’t working quite like they should. None of them are, same for the ones listening to your pussy’s siren song. Those are working like a vice, rolling up and down along surprisingly winsome member. Your voice is screaming and gasping, faltering breathlessly when the ecstasy becomes too overwhelming.");
			outputText("\n\nNo respite is given to your beleaguered body. Just as you start to come down, your traitorous nerves wrack you with a whole new orgasmic high");
			if (player.isLactating())
			{
				outputText(", tricking your full nipples into spraying their milk everywhere");
			}
			else
			{
				outputText(", denying you even the chance to climb off");
			}
			outputText(". Your body has given itself over to this hedonistic relief. So long as the minotaur’s hips saw in and out of your soaked delta, you’re going to keep cumming.");
			outputText("\n\nThen you feel it. The swollen crown of the King’s equine phallus palpably expands inside you, arresting your motions. Somehow it doesn’t");
			if (player.pregnancyIncubation != 0)
			{
				outputText(" force its way past your cervix");
			}
			else
			{
				outputText(" tear open your womb");
			}
			outputText(". Your insides stretch like they’re made of rubber");
			if (player.averageVaginalLooseness() >= 5)
			{
				outputText(", which isn’t far from the truth,");
			}
			outputText(" in order to accommodate the swelling intrusion. The beast below roars. You can feel the bass rumble in your bones - and your [clit].");
			if (player.hasCock())
			{
				outputText(" Hell, you can feel it surging through your [cocks], vibrationally expelling the last few unspent drops from your urethra");
				if (player.cocks.length > 1)
				{
					outputText("s");
				}
				outputText(".");
			}
			outputText("\n\nHis cum is unbelievable. It comes out like water from a pipe, only warm and gooey inside you. Your belly expands from the erupting beast-spunk, filling out into an idol of perverse fertility. One of your hands reaches over to cradle it, feeling your increasingly gravid dome swell until the edge of the minotaur’s flare is no longer visible. Torrents of white pour out from your lips. The scent of his alabaster cream is so strong that you feel dizzy - or maybe that’s all the druggy, narcotic-laced bullspunk soaking your insides. Either way, it’s a fantastic rush completely at odds with your spooge-gifted immobility.");
			outputText("\n\nThe Minotaur King’s touches fall away the moment your belly stops inflating. The poor brute has passed out, literally fucked into unconsciousness by your teasing and subsequent ride, and while his cock doesn’t go soft in the slightest, his flare does shrink down, allowing your body to slowly vent a tide of animalistic sperm. Once you are no longer encumbered by your own inflation, you doggedly rise, dragging your [vagina] off the rigid cunt-buster with agonizing slowness.");
			outputText("\n\nYou nearly don’t make it. You’re all dizzy from the minotaur cum and multiple orgasms, and the crossing over three rings and a flare nearly takes you back to the peak. When the fat head finally pops free from your labia, you breathe a ragged sigh of relief and tumble off");
			if (player.isBiped())
			{
				outputText(", [legs] akimbo");
			}
			outputText(". The artificial euphoria this has brought you makes it difficult not to crawl over to the nearest incubus and offer your body up, but you still have to deal with Lethice. Maybe you can make her lick the drippings from your slit after you take her down.");
			outputText("\n\nWith that fantasy firmly in mind, you stand up and fix your [armor]. You can still do this, right?");
			player.orgasm();
			dynStats("lus",5,"resisted",false);
			player.createStatusEffect(StatusEffects.MinotaurKingsTouch,0,0,0,0);
			flags[kFLAGS.MINOTAURKINGS_TOUCH] = 1;
			player.minoCumAddiction(20);
			player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR - 48);
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		private function titfuckCowslut():void
		{
			flags[kFLAGS.MINOTAURKINGSSLUT_FUCKED] = 1;
			clearOutput();
			outputText("Forget that beefcake; there’s a primo slut close at hand with a set of tits that’d be worth damnation to fuck. It’s a good thing Lethice is giving you this chance to sate yourself. You might have had to risk giving them a good fucking even if she didn’t. Pulling [oneCock] out of your [armor], you advance on the fallen slut, feeling momentarily sorry for her.");
			outputText("\n\nExcellia is barely conscious. Her pussy is gaped wide open and still drooling her master’s excess spunk. Her eyes are glassy and a little unfocused. When you climb atop her though, she manages to smile at you and grab hold of her boobs. The touch alone sends her into a moaning fit with her eyes half rolled back and her tongue hanging out. Her tits are <i>sensitive</i>. You aren’t sure if she’s naturally a perfect tit-fuck-slut or if it’s an effect of her master’s druggy cum, but it really doesn’t matter to you.");
			outputText("\n\nThe quivering cow moans once you place your [cock] into her canyon-like cleavage and props her tits up with her elbows, sealing you inside the mountains of mammary flesh. Her fingers nearly disappear into the soft pillows, squeezing jets of uncontrolled milk from her chocolate-brown nipples. Remembering what it did to your fallen foe, you avoid drinking it yourself, letting it cascade back over the bouncy tits and into the oh-so-pleasant crevasse between.");
			outputText("\n\nHer milk isn’t a perfect lubricant, but it slickens her skin enough to let her milky mounds glide across your [cock] almost as well as a sodden pussy. Ever the slut, Excellia moves her enormous tits for you, sliding them back and forth along your length with a gentle but  arousing rhythm. The real delight is in the show this motion provides, jiggling her melons delightfully, allowing you to enjoy the play of light across their gleaming curvature.");
			outputText("\n\nYou twitch in her velvety embrace, and Excellia manages to smile.");
			outputText("\n\nThe slut is loving this even more than you are, no two ways about her. Her full lips are almost always parted by moans. Her face is flushed. Heck, she’s still squirting milk. The flow is stronger when your cock is fully embedded in her chesty embrace, pressing back against the fluid-reservoirs in countersync to her busily kneading hands. A body like this... it’s made to be fucked and used. No wonder the Minotaur King claimed her as a concubine.");
			outputText("\n\nNo more. As of this moment, she’s yours to enjoy. Your’s to climb on board and ride until you’re milked of every drop. When your [cockHead] clears her cleavage, Excellia even remembers to suck it. She doesn’t always. Sometimes her lips are busy releasing a joyous moo or inarticulate screech of bliss, but most of the time, she’s all too happy to wrap her gold-gilt lips around your [cock].");
			outputText("\n\nWait... gold lips? Like the harpies?");
			outputText("\n\nDesire wells up inside you potent and uncompromising. No wonder your opponent was always rock-hard. Your own dick throbs angrily against the pillowy embrace of the cow-slut’s tits. delirious with the need for release and yet craving nothing more than endless breeding by the nearest female. Fuck!");
			outputText("\n\nYou grab hold of one of her horns and pin her head back before she can dose you with any more of her arousing drug. You’re going to win this, and you can’t do that if this slut gets her lips on you again. Pinching one nipple, you cut off the flow of milk and begin to powerfully thrust your way between her sensitive breasts, rudely plowing Excellia’s tits with no considerations for her enjoyment.");
			outputText("\n\nIt doesn’t matter. The moment you start to use her more aggressively, you can actually hear her slutty slit leaking onto the floor behind you. She’s clearly used to being used and abused like this. Maybe she even enjoys it. You pinch a nipple and listen to her scream another moo of delight, then you grab hold of the other and repeat the action. Whenever she seems to be considering going for your cock again, you pinch down on both sides, denying her with nothing more than her body’s own too-raw sensation.");
			outputText("\n\nYou lose track of how many times the eager fuckslut gets her rocks off, but you’re not far yourself. The residual effects of her lipstick are a constantly rising crescendo of erotic energy inside you, to say nothing of the delightful squish of her tits on your [cock]. Howling in delight, you redouble your pace, determined to wring every ounce of pleasure from this slut’s whorish boobs. Her broad, cow-like tongue is hanging out in a blissed-out expression. You wonder if you can paint it white.");
			outputText("\n\nWhen you go off, you slam yourself home and savor the tight, titty-squeeze, squirting thick ropes of jizz at your target.");
			if (player.cumQ() <= 500)
			{
				outputText(" Most fall short, but one daring squirt manages to coat Excellia’s tongue.");
			}
			else if (player.cumQ() <= 1500)
			{
				outputText(" Most manage to fall on Excellia’s tongue, painting it a nearly white save for a few off-color splotches. The rest puddles in the nape of her neck, giving you time to enjoy the cow-print tongue you’ve created.");
			}
			else
			{
				outputText(" Excellia’s tongue never stood a chance. You cover most of it in the first shot alone, pouring much of the rest down her throat. Bits of sperm fleck her cheeks, and a deep puddle forms at the nape of her neck, complete with dribbling tributaries along her collarbones.");
				if (player.cumQ() >= 5000)
				{
					outputText(" And her breasts? They’re basically white save for their peaks.");
				}
			}
			outputText("\n\nRegrettably, you’ve got work to do. You extricate yourself from the cum-and-milk splattered cow-girl and stand up, regarding the awaiting demoness.");
			player.orgasm();
			player.HP = player.maxHP();
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		private function sloppySeconds():void
		{
			flags[kFLAGS.MINOTAURKINGSSLUT_FUCKED] = 1;
			clearOutput();
			var x:int = player.biggestCockIndex() + 1;
			outputText("Why resort to making use of the brutal minotaur when there’s a puddle of wet trollop so close at hand? It’s a good thing that all the spunk leaking from between her legs actually smells");
			if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0)
			{
				outputText(" wonderful");
			}
			else
			{
				outputText(" sort of... nice... sexy even");
			}
			outputText(", or you might have had second thoughts. Her creampied honeypot ought to feel like teflon-treated silk against your [cock " + x + "]. It glitters in the flickering, bedroom light of Lethice’s throne room, beckoning you to plunge inside and see just how good it will feel.");
			outputText("\n\n<i>“Hrmmm, again?”</i> Excellia dreamily coos, lifting her ass up into position. <i>“...yes sir, I’m always rarin’ for a fuck.”</i> She happily sighs and wiggles her ass in your direction, completely unaware that you’re the one advancing toward her ass with a aching cock");
			if (player.balls > 0)
			{
				outputText(" and " + num2Text(player.balls) + " balls full of cum");
			}
			else
			{
				outputText(" and a load of backed-up cum");
			}
			outputText(". You don’t see much point in correcting her, not when she’s presenting so enthusiastically. Grabbing hold of her tail, you yank her into position, positioning your [cockHead " + x + "] just outside the cream-drizzling gates of her cunt.");
			outputText("\n\nExcellia moans, <i>“So gentle, Lord! Please, don’t make me wait!”</i>");
			outputText("\n\nSavagely tugging on her tail, you bury yourself into well-stuffed quim, unable to believe that this passes for gentle in the service of the Minotaur King. Each");
			if (player.balls > 0)
			{
				outputText(" ball");
			}
			else
			{
				outputText(" ass");
			}
			outputText("-slapping impact ripples through the plush cow-slave’s derriere like waves through a pond. She exhales blissful little moos, pushing back against you to the same tempo, ever the faithful cock-milker.");
			if (player.biggestCockLength() < 18)
			{
				outputText(" You don’t think she could possibly confuse your less-impressive erection for her minotaur master’s, but she doesn’t give any sign of caring. Perhaps all the minotaur jism stuffed in her twat has left her beyond caring, or maybe she’s just happy to serve a dick - any dick.");
			}
			else if (player.biggestCockLength() <= 30)
			{
				outputText(" You didn’t think she’d confuse your prick for her master’s, but she’s happily fucking it all the same. It probably stretches her cunt just about as much.");
			}
			else
			{
				outputText(" You don’t think she could possibly confuse your slab of cock for a smaller sample like her minotaur master’s, but she doesn’t show much sign of caring. Perhaps all the minotaur jism stuffed in her twat has left her so inundated with pleasure that worry is beyond her. So long as she’s split with a massive shaft, what’s the difference?");
			}
			outputText(" You can see why the overgrown beast-man keeps her around.");
			outputText("\n\nThe quivering cow-slut’s cunt is fucking magic too. It feels like her muscles are pulling you deeper with every thrust, coaxing your [cock " + x + "] to sprout another inch if only to better fill. Gods, you’re getting harder and harder. She feels so damned good that it’s making your head spin, making it impossible to do anything but grab hold of her ass and squeeze like your life depends on it. In this moment, bereft of anything but the sinful squelches emanating from Excellia’s too-moist muff, you feel like you love her, or at least her pussy.");
			outputText("\n\nFuck, you could love almost anyone right now. If the crowd around you wasn’t composed of soulless abominations, you’d probably love them too. You knead her ass some more, watching it give beneath your fingers. Your digits nearly disappear into the cushy, fuckable asscheeks, and you grunt in approval. It’s hypnotic. You’re still fucking her, of course. You couldn’t stop if you wanted to, but there’s a strange disconnect between your hips and the rest of your awareness, like there’s so much pleasure that you’ve gone with numb it.");
			outputText("\n\nArcs of electric bliss hum and sizzle through your [cock] from second to second, popping in starbursts behind your eyes that make it hard to focus on anything but the swaying ass in front of you. You ravage Excellia on autopilot, groaning in delight as realization finally dawns on you - all the minotaur cum inside of her is affecting you, somehow. And there’s so much of the stuff! Creamy white blobs slop out whenever you pull out or thrust in, but there’s always more inside her to bathe your member, cocooning it in layer after layer of narcotic aphrodisiac.");
			outputText("\n\nPart of you wants to stop, but that part of you is getting smaller with every thrust. This is wonderful, the raw, almost feral feeling of an athletic fuck unbounded by civilization or decency. Excellia’s pussy was designed to glove your [cock " + x + "] perfectly, to match its ravenous thrusting with a sordid massage. Faintly, you hear cheering and the greedy slut begging for more. She wants you to cum inside of her; you can tell. Everything from her body-language to the pitch of her delirious voice is begging you to feed her overactive ovaries their second meal of the hour. Her body is ravenous for cum, even when she’s so stuffed with it that it won’t stop pouring out.");
			outputText("\n\nYou need to get off more than you ever thought possible. Logically, you want this over quickly so that you can fu- face Lethice in all her naked glory. You bet you’ll even get to squeeze her tits at least once before you take her down... Those purple orbs beckon for your fingertips. But then there’s the ecstatic undulations wreathing you in fleshy heaven, caressing your nerves with individualized attention, playing your body like a harp. How could you possibly want this to end? You’ve grown so addicted to this pleasure in such a short time that ever leaving it seems an alien concept to your cunt-obsessed mind. You want to fuck this pussy <i>forever.</i>");
			outputText("\n\nThe light shimmers across Excellia’s sweat-shined ass hypnotically from the hard-fucking you’re giving her. You swat it, just to watch it ripple - and to feel the way Excellia clenches down around you, her voice lilting into an almost musical, blissful moo. It’s fascinating, how her body reacts to your thrusts, the way she seems to wrap her whole self around you. You barely register than you’re panting or that your [cock] is hard enough to cut diamonds.");
			if (player.cocks.length == 2)
			{
				outputText(" Your other penis is enjoying sliding between her perspiring thighs almost as much.");
			}
			else if (player.cocks.length > 2)
			{
				outputText(" Your other penises are enjoying sliding between her perspiring thighs nearly as much.");
			}
			outputText("\n\nIt isn’t desire that brings you off. It’s your body’s simple, biological imperative to breed. No matter how much you may want to endlessly rut against this avatar of fertility, your body eventually reaches the point where the cum it’s churning out is too voluminous to contain any more. The upwelling of your seed triggers blissful contractions inside your body, and like the flipping of a lightswitch, you’re abruptly cumming, spewing your load into this living spooge-sinkhole.");
			outputText("\n\nExcellia moos ear-splittingly loudly, clenching down on you as you climax, sealing your rapidly ejaculating load inside herself.");
			if (player.hasKnot())
			{
				outputText(" There’s not much point in it; your knot does that much and more, trapping your load inside as effectively as the remainder of the Minotaur King’s.");
			}
			outputText(" Your");
			if (Boolean(player.isBiped()) || Boolean(player.isTaur()))
			{
				outputText(" [legs] wobble");
			}
			else
			{
				outputText(" [leg] wobbles");
			}
			outputText(" weakly beneath you, dumping you and your jiggly concubine to the floor mid-orgasm, but it doesn’t slow your ejaculation in the slightest. You feel like you could keep cuming for ever, clenching and releasing, feeding wave after wave into the happily mooing bovine temptress.");
			outputText("\n\n");
			if (Boolean(player.hasKnot()) && player.cumQ() >= 5000)
			{
				outputText(" Excellia’s belly bulges into an exceedingly pregnant state, stuffed with so much of your cum that she looks nine months pregnant and then some. Her belly button pops out just before you finish squirting into her, diluting the bestial brute’s druggy load with the seed of a Champion.");
			}
			else if (player.cumQ() >= 5000 && !player.hasKnot())
			{
				outputText(" Excellia’s muscular control is no match for the sheer virility of your load. The gates of her cunt give out in short order, releasing a flood of Champion-diluted minotaur spunk onto the ground. She whimpers and cries out in ecstasy, driven to the peak again and again by the continuous flooding of her womb with your seed.");
			}
			outputText("\n\nPivoting on your prick, dragging her velvety dicksleeve in a delightful 180 on your length, Excellia crawls atop you, still shaking. Her pussy is still squeezing and clenching down around your [cock " + x + "], keeping your attention focused solely on the itch between your thighs. Your overstimulated crotch has no choice but to climax once more, orgasming to the insatiable mynx’s demands. There’s not much to left to give her, but that doesn’t stop you from writhing in ecstasy, or groping her tits in wild excitement.");
			outputText("\n\nYou aren’t sure how many more times you give it to her, but by the time you finally manage to extract yourself from her wanton lips, the Minotaur King has been dragged into the crowd.");
			outputText("\n\nLethice looks bored, drumming her fingers on the edge of her throne. Time to deal with her.");
			player.orgasm();
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		public function hailToTheKingBaby(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			var mk:MinotaurKing = monster as MinotaurKing;
			if (!hpVictory)
			{
				outputText("Your determination burns away in the fires of your desire, nothing against molten need burning through your brain. How could you ever resist this magnificent beast? His magnificent cock is so big... so hard");
				if (mk.orgasms > 0)
				{
					outputText("... so wet with the juices of his slut");
				}
				outputText(". It fills your vision and your thoughts. It would be so easy to bend over for him, to lift your [butt] up in the air and wiggle it in his direction until the big brute forced himself on you. Gods, he could stuff you so well. It’s be so perfect, him inside you, the head of his gigantic monster-cock clearly outlined on your belly.");
				outputText("\n\n<i>“Are you giving in already?”</i> The minotaur king grabs hold of your head, nearly enveloping your entire skull in the palm of his head. <i>“No matter how well they fight, they all wind up like you. If you could see yourself right now... you’d want to fuck you too.”</i>");
			}
			else
			{
				outputText("You’ve been beaten. Staying upright has become an almost impossible task, and the idea of fighting little more than a pipe dream. Still wobbling in place, you look up in time to see the brute approach, laughing jovially.");
				outputText("\n\n<i>“There we go. Just accept it.”</i> The minotaur king grabs hold of your head, nearly enveloping your entire skull in the palm of his head. <i>“You fought well, for a human, but you don’t need to fight any more.”</i>");
			}
			outputText(" He drags you up against his crotch, smearing his sweat and sex-soaked balls against your face. It feels thick and oily on your cheek but smells like getting fucked bareback until your eyes roll back and your tongue lolls out.");
			outputText("\n\nYou wanted to fight this, you’re sure. You didn’t come here to lean against his comforting warmth and breathe in more of his salt and tang musk. Powerful veins bulge against your forehead, and pre-cum drizzles down into your [hair]. There’s no escape now. No matter what you do or where you go, that scent is going to cling to you. The scent of royal... powerful cock. Girls will drench their panties just from being close to you, and you’ll never be able to think of anything else. The next breath you take is punctuated by a whimpering moan.");
			outputText("\n\nHis cock drags past your temple to your cheek as the King lifts you higher. Your lips brush the edge of his meaty shaft, and your tongue snakes out unbidden. <i>Just a taste</i>, you tell yourself. <i>Just a taste.</i>");
			outputText("\n\nPre-cum, sweat, and skin blend together into an ambrosial feast. Your taste buds are overwhelmed by the flavor. Torrents of red-hot, chemically-assisted pleasure seem to wash your other senses away, leaving you little more than a wiggling tongue and a hungry, empty mouth. How much better would it be to capture the tip? Would you forget the shame of your defeat? Could you live the rest of your life like this, wiggling happily on the end of a royal rod?");
			outputText("\n\nOnly one way to find out.");
			outputText("\n\nYou push back against the hand holding you back, grabbing hold of the oozing cock in both hands to pull the blunted tip to your mouth. Spongy flare brushes your lower lip, glazing in a layer of spunky cockdrool. Rather than lick it off, you leave it there and open wide, letting the lubricating juices do what they were meant to do: help ease a dick into a too-small hole. Just getting the tip inside has your jaw aching and your mouth stretched into an impossibly slutty ‘O,’ but once you get past that, the going gets easier.");
			outputText("\n\n<i>“Atta " + player.mf("boy","girl") + ",”</i> the triumphant beast-man croons. <i>“This is where you belong.”</i>");
			outputText("\n\nYou can hardly disagree. With his cock captive, no pre-cum will be wasted. The freely-spilling droplets have no choice but to slip down the length of your tongue and into your throat, where they can be swallowed. Your head might as well be filled with thick, pink cotton balls at this point, and every swallow, every eager gulp, adds more, blotting out worry and concern. Those anxious thoughts have no room to form, not when your head is so full of cock, literally and figuratively. Just thinking about it makes you want to smile and giggle, but there’s no room for that in a maw increasingly stuffed with phallus.");
			outputText("\n\nWhether you’re leaning forward to slide it deeper or the hand on the back of your head is gently but inexorably force-fucking your face is a matter of debate. With a lascivious lick, you wonder why it can’t be both? It takes two to fuck, after all. You open wider, bathing your tonsils in a fresh spurt of the minotaur’s musky gunk, not even flinching when his cockhead flatters your uvula against your palate.");
			if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.cor >= 66)
			{
				outputText(" You’re long past the point of having a gag reflex and glad for it.");
			}
			else
			{
				outputText(" Miraculously, your gag reflex is completely absent. Maybe it’s too drenched in his heavenly pre to protest?");
			}
			outputText("\n\nFlaring your nostrils, you take in a huge gulp of air, just in time to fortify you before that giant slab of dickmeat blocks your lungs off completely. You tip your head back and lift your ass to straighten your esophagus, the better to accept more of this brute’s gorgeous fuckpipe. It’s just in time too. The moment he senses an opening, he plows right in, distending your throat, packing you full of more cock than you ever imagined possible.");
			outputText("\n\nThe head of the minotaur’s mighty member flares as it travels through your body, pushing against you with painful urgency. It would probably hurt if he wasn’t practically pissing pre-cum directly into your body, hosing the raw parts of your throat down with more of his heavenly goo. Pleasure replaces pain, and tingles of delight radiate upward from everything between your gut and your mouth. When his flaring tip finally breaches the top of your stomach, you nearly cum on the spot.");
			outputText("\n\nNo longer feeling the pressure of his expanding crown is an immense relief and accomplishment you feel bizarrely proud of. Your nose is pressed deep into sticky folds of the minotaur’s sheath, your lips liberally slimed with half-dried pre. The tops of his swollen, excessively virile nuts slap your chin as the brutish monarch roars in pleasure. You close your eyes and hum, perfectly content to sit here and vibrate around his cock until he dumps his prodigious load directly into your hungry belly.");
			outputText("\n\nYou aren’t left waiting long.");
			outputText("\n\nThe minotaur King lurches forward powerfully");
			if (player.biggestTitSize() >= 5)
			{
				outputText(", jiggling your tits wildly");
			}
			else if (player.hasCock())
			{
				outputText(", making your oozing, half-hard prick");
				if (player.cocks.length > 1)
				{
					outputText("s");
				}
				outputText(" flail around comically, sliming the floor");
			}
			else
			{
				outputText(", shaking your whole body with the force of his passion");
			}
			outputText(". His flare somehow grows even fatter, wide enough to be visible through the [skinFurScales] of your belly and hard enough for you to stroke through the intervening flesh.");
			outputText("\n\nHis orgasm rocks your entire world. The first squirt alone fills your stomach to capacity, giving you a nicely-rounded cum paunch. The second stretches your tummy into gravid obscenity. Your eyes roll back, both from lack of oxygen and the super-sized load of druggy, mind-obliterating minotaur spunk. You barely register the feeling of his cannon-like ejaculations pushing you off his spasming member. You definitely don’t remember opening wide and letting him paint your face and hair in a mask of it.");
			outputText("\n\nEverything is too hazy to clearly piece together, just flashes of memories, sensations, and an all-consuming bliss. Excellia’s hands on your [chest], stroking and squeezing, massaging her lord’s copious ejaculation into your [skinFurScales] until you gleam with it. Imps jacking off high above, mixing their tainted spooge in with the pure love of your majestic master. Lethice may have even fucked your ass. Somebody definitely did.");
			menu();
			addButton(0,"Next",this.gurglegurgle);
		}
		
		private function gurglegurgle():void
		{
			clearOutput();
			outputText("You wind up being grateful for that half-forgotten assfucking later, when the minotaur King finally lays claim to your other end. That little bit of extra gape and lubrication is enough to help him lodge his humongous pecker deep into your asshole. Just like with your throat, you find him easier to handle than his size alone would suggest, but that does nothing to diminish the obscene fullness occupying your mind.");
			outputText("\n\nIt’s wonderful. Even when he’s not fucking your ass, he’s rock hard and dribbling, giving you a constant feed of the fluid you’ve fallen in love with. You let him carry you around like that. That’s what you tell yourself, anyway. The big lug would probably pin you in place if you tried to struggle, but you can’t imagine yourself fighting this.");
			outputText("\n\nSo what if you’re a dick-cozy, mounted on a minotaur’s beastly cock like some kind of trophy? Who cares if sometimes you have to lick out the Demon Queen while being reamed from behind? Everything is great. You never worry about anything, and there’s always someone filling you, fucking you full of liquid happiness.");
			outputText("\n\nYou smile and request someone fuck your mouth. It always feels better with one in each end.");
			getGame().gameOver();
		}
		
		private function leavethem():void
		{
			flags[kFLAGS.MINOTAURKING_ALIVE] = 1;
			clearOutput();
			outputText("\n\nYou square yourself off at the demon queen");
			if (player.weapon != WeaponLib.FISTS)
			{
				outputText(", [weapon] in hand");
			}
			else
			{
				outputText(", balled fists raised");
			}
			outputText(" and reject her offer out of hand. <i>“");
			if (player.findPerk(PerkLib.BimboBrains) >= 0)
			{
				outputText("Ummm, like, I’m not </i>that<i> horny. Besides, I can fuck all I want once I take you out, cutie!");
			}
			else if (player.cor >= 66)
			{
				outputText("Oh come on. If you’re going to give me something to fuck, at least make it something worth my time. How about your ass, after I beat you?");
			}
			else if (player.cor <= 20)
			{
				outputText("Why would I debase myself in front of you like that? The pure need no such indulgence.");
			}
			else
			{
				outputText("Not all of us are as enslaved by our desires as you.");
			}
			outputText("”</i>");
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
	}
}
