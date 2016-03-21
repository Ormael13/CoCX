//const JACK_FROST_YEAR:int = 645;
//const JACK_FROST_PROGRESS:int = 646;

//Jack Frost and Snow
/*
The Flow:
Meeting Jack
Back in camp
No followers
Rathazul
Izma
Jojo
Pure
Corrupt
[=Pen Ass=]
[=Ride Cock=]
[=Spank and Finger Ass=]
Amily
Pure
[=Fuck Her=]
[=Make out=]
Corrupt
Tainted Ember
Marble (Written by TDM himself)
With Kids
Without kids
Helia
Isabella
Kiha
[=Fuck Her=]
[=Lick Boobs and Finger Pussy=]
Aftermath...

The Flow:
Notice snow in Mountain.
Investigate to meet Jack.
Request he makes it snow over the camp.
Have fun with followers inside the camp.
PC loses a day in this process.
Meeting Jack
*/

package classes.Scenes.Seasonal {
	
	import classes.*;
	import classes.GlobalFlags.*;

	public class XmasJackFrost extends BaseContent
	{
		public function XmasJackFrost() {}
		
		//Takes place when exploring the mountain.
		public function meetJackFrostInTheMountains():void {
			clearOutput();
			outputText("As you explore the mountainous heights, you come across something strange - a great spray of cold, wet, soft, creamy substance.  You realise with a start that it's snow!  You haven't even seen rain since you came to this world.  What's more, looking around shows you other strange drifts of snow; it almost looks like a path of some sort.  Curious, you decide to follow them, see if you can track down what's causing it.");
			
			outputText("\n\nWhile hiking up the mountain you hear a strange masculine voice.  \"<i>Yeah, that should be enough... but this part needs some more!</i>\"  Shortly after you hear the faint, but distinct sound of someone masturbating furiously.");
			
			outputText("\n\nCurious, you slink closer; that doesn't sound like any imp you've encountered so far... as you creep through the rocks, the target of your investigation suddenly lets out an ecstatic howl.  A great wooshing, roaring noise fills the air... which is the last thing you notice before something cold, wet and sticking lands on you in a massive flurry, knocking you to the ground and completely burying you.");
			
			outputText("\n\nIn a panic, you claw your way free of the stuff - more snow, an absent part of you notices - and you find yourself face to face with the person you were investigating... and who you realize is responsible for your predicament.");
			
			outputText("\n\nBefore you, hand around his gigantic cock, sits a man... judging by his size, you'd estimate him to be at least 12 feet tall, his surprisingly human-looking prick seems to be at least 4 feet long and 1 foot thick; a heavy pair of massive balls hang low, under his shaft.  He is completely naked, save for a loincloth that looks barely able to conceal his throbbing length, and atop his head you notice a series of icicles that seem to make up his hair, along with a pointy beard also made of ice.");
			
			outputText("\n\nHe ignores you, too busy stroking himself off to care, when suddenly he lets out another moan and his cock bulges before disgorging another huge flurry of white - you narrowly avoid being struck in the face as it roars past to splatter down the mountain.  It looks like the snow you've been tracking is actually this strange fellow's ejaculate!");
			
			outputText("\n\nIt takes a while for his impressive orgasm to subside, but finally, he lets go of his hard throbbing shaft and moves his icy blue eyes to look at you.  \"<i>Oh, hey there little one, didn't see you sitting there.  Can I help you?</i>\"");
			
			outputText("\n\nYou apologize for interrupting him, wary of disturbing someone so huge, but you thought you had encountered snow and, well, you were curious to find where it was coming from.  It's been so dry since you came to this land; you can't recall seeing snow before.");
			
			outputText("\n\nHe scratches his neck and nods.  \"<i>Indeed, little one, lately there has been no snow... I have no idea why... this world used to be so nice... always covered in white by this time of the year... but it doesn't matter.  If there's no snow, uncle Jack will just have to make some!  Though I didn't expect THIS would be the way I'd be making it snow.</i>\"  He chuckles, giving his shaft a few extra pumps and spraying a bit of snow on the ground.");
			
			outputText("\n\nYou nod your head in unfeigned sympathy and tell him that you can understand why he would miss the snow... considering there hasn't been even a single drop of rain ever since you stepped in this world, it's no wonder it hasn't snowed.");
			
			outputText("\n\nYou sigh longingly.  Back in your own world, there would be much snow everywhere in your home village, and your people would be celebrating.  But it looks like you'll be missing it this year.  Nothing but rocks and dust in your camp.");
			
			outputText("\n\n\"<i>Rock and dust, huh?  Now... that's no way to be spending Winterfest...</i>\"  He shakes his head.  \"<i>If you don't mind, little one, I could help you bring a bit of snowy joy to your camp... if you don't mind telling me where it is.</i>\"  Then he chuckles.  \"<i>And if you don't mind WHERE that snow is going to be cumming from.</i>\"  He laughs at his own joke.");
			
			outputText("\n\nWhat do you say?  Do you take the ice giant's deal and get a day off playing in the snow on your camp?");
			//[Yes] [No]
			menu();
			addButton(0, "Yes", jizzSnowOnMyCampPlease);
			addButton(1, "No", noJizzingInMyCampPlease);
			addButton(2, "Later", noJizzingInMyCampRightNow);
		}

		//[=Later=]
		public function noJizzingInMyCampRightNow():void {
			clearOutput();
			outputText("You thank the giant for his offer, but you'll have to decline for now. Maybe next time.");
			outputText("\n\n\"<i>Pity... well, if you'll excuse me, this mountain ain't snowy enough just yet!</i>\"  He resumes his furious masturbation, spraying another gush of snow on the side of the mountain.");
			
			outputText("\n\nSeeing no reason to linger, you return to your camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		//[=No=]
		public function noJizzingInMyCampPlease():void {
			clearOutput();
			outputText("You thank the giant for his offer, but you'll have to refuse.  You really can't take even one day off your quest.");
			outputText("\n\n\"<i>Pity... well, if you'll excuse me, this mountain ain't snowy enough just yet!</i>\"  He resumes his furious masturbation, spraying another gush of snow on the side of the mountain.");
			
			outputText("\n\nSeeing no reason to linger, you return to your camp.");
			flags[kFLAGS.JACK_FROST_YEAR] = date.fullYear;
			doNext(camp.returnToCampUseOneHour);
		}

		//[=Yes=]
		public function jizzSnowOnMyCampPlease():void {
			clearOutput();
			outputText("You look around, and then find a convenient rock to climb.  From here, you can see your camp, and you indicate to the friendly giant where it is.  \"<i>Alright, I'll make sure to paint it white.</i>\"  He chuckles once more.  \"<i>I have a pretty good aim, I'll have you know, and my friend here can pump it far!</i>\"  He pats his enormous dick.  \"<i>Off you go, then.  And merry Winterfest.</i>\"  He smiles turning to point his gigantic prick at your camp and beginning to masturbate furiously.");

			outputText("\n\nYou thank him for the surprisingly kind gesture, and start to head back down to camp.  Even as you go, you can see the first huge jet of snow arcing its way across the sky...");
			flags[kFLAGS.JACK_FROST_YEAR] = date.fullYear;
			flags[kFLAGS.JACK_FROST_PROGRESS] = 1;
			doNext(camp.returnToCampUseOneHour);
		}

		//Back in camp
		public function processJackFrostEvent():void {
			hideUpDown();
			clearOutput();
			//Each follower PC has adds a block, having no followers just plays the no followers block.
			//Corrupts can forget about their lust for one day to play on the snow.
			if (flags[kFLAGS.JACK_FROST_PROGRESS] == 1) {
				outputText("As you approach your camp, you can see that Jack Frost's efforts are paying off.  A great, constant flurry of snowflakes is gently drifting down, swaying in the wind as it makes its inevitable descent towards the ground.  A layer of snowflakes is quickly building up, growing wider and deeper as more snow is launched from out of the mountains to rain down on your camp. You can't help but enjoy the cool air as the snowflakes fall down languidly onto the ground.  It's so beautiful you almost forget the rather perverted origin of it all.\n\n");
				flags[kFLAGS.JACK_FROST_PROGRESS] = 2;
				menu();
				addButton(0,"Next",processJackFrostEvent);
			}
			//No followers
			else if (camp.companionsCount() == 0) {
				//Only if PC really has NO ONE to be with. aka: ForeverAlone.gif
				outputText("You sigh... this really reminds you of back home... you only wish you had someone to share this feeling with... Well, there is no reason you shouldn't enjoy yourself while it snows, so you set about rolling a big ball of snow to make a snowman out of...");
				//Skip to next day...
				flags[kFLAGS.JACK_FROST_PROGRESS] = 0;
				HPChange(player.maxHP(), false);
				player.changeFatigue(-100);
				doNext(camp.returnToCampUseEightHours);
			}
			//Rathazul
			else if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0 && flags[kFLAGS.JACK_FROST_PROGRESS] == 2) {
				outputText("Rathazul approaches you.  \"<i>[name]?  What is going on?  It hasn't snowed in Mareth for years now.  And why only around the camp?  I wandered out to investigate, but outside there is no snow at all...</i>\" he asks, concerned.");
				
				outputText("\n\nYou tell Rathazul that you met a friendly... er... wizard up in the mountains who wanted to try and bring snow back to Mareth.  You offered to let him cast it out over your camp, so it's basically being flung from the mountains to land here.  But, really, why is he worrying about it?  This is the first time it's happened in years, doesn't he want to enjoy it while it lasts, before it melts away?");
				
				outputText("\n\n\"<i>Maybe you're right... it has been a long time.</i>\"  Rathazul smiles.  \"<i>I think I would like to build a snowmouse.</i>\"");
				
				outputText("\n\nYou ask if he'd like a hand doing that, being as it's been so long since he had a chance to do that?  Rathazul nods.  \"<i>I would love it!  Help me with the base.</i>\"");
				
				outputText("\n\nYou begin gathering snow along with the old rat...");
				menu();
				addButton(0,"Next",processJackFrostEvent);
				flags[kFLAGS.JACK_FROST_PROGRESS] = 3;
				return;
			}
			//Izma
			else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.JACK_FROST_PROGRESS] <= 3) {
				outputText("You wonder where Izma is; as a shark, maybe she doesn't like the cold?  Even as the thought crosses your mind, you note a surprisingly large pile of snow sitting not too far - with a very suspicious striped fin jutting out of it.  You rush over, calling for Izma and asking if she's all right.");
				outputText("\n\nThe mound snow suddenly explodes as Izma pounces you, knocking you on your back and pinning you against the snowy ground.  \"<i>Gotcha!</i>\"  At once she notices who it is she's pounced upon.  \"<i>Hi there, [name].</i>\"");
				outputText("\n\nYou tell her she's a bold one indeed to do something like that to you - isn't she supposed to be your beta?");
				outputText("\n\nThe tigershark laughs.  \"<i>A pretty poor alpha you'd be if you can't have fun like this - I don't know what this cold white stuff is, but it's so neat!</i>\"  She promptly leaps off of you to dive into the snow, rolling around in it like a kid with a laugh.  \"<i>It's cold, but it feels so lovely - slippery and soft and smooth.  I think mom and dad used to talk about stuff like this when I was a kid - they called it 'snow', I think,</i>\" she says, flopping onto her belly in it.");
				
				outputText("\n\nYou're glad she's liking it, you tell her, getting up to brush the snow off you.  You tell her she should enjoy it while it lasts, you reckon it won't last more than a day...");
				outputText("\n\nIzma sighs in disappointment.  \"<i>Guess I'll have to enjoy it while it's here, then,</i>\" she notes, sadly.");
				
				outputText("\n\nNow about that alpha-beta chat, you tell her... \"<i>What about it?</i>\"  You don't reply, simply pouncing her yourself and pinning her to the ground as you run your hands along her shark-tail.  You tell her to never forget her place.  \"<i>Oh?  Is that so?</i>\"  She purrs, wriggling her ass.  \"<i>Why don't you remind me of where my place is, hmm?  Now was that on top of me or under me...?</i>\"  She grins the sharp-toothed grin only a tigershark can grin.");
				
				outputText("\n\nYou'll be glad to demonstrate, you grin back.  \"<i>Oh, really?  So, what do you have in mind, my [name]?</i>\" she asks, feigning ignorance with terrible acting skills.");
				
				outputText("\n\nYou run your hand hands along her body, over the curves of her tits, her supple thighs, her hips and down her legs.   \"<i>Mmm... that feels so good, [name].  Though, if this is supposed to be dominant behavior, it doesn't really feel like it,</i>\" she reports lazily.  Oh really, now?  How about if you do this!  You press a point on her belly with your index finger.  The tigershark yelps in shock, but giggles in the obvious manner of someone who's been tickled.  With a smirk, you tell her that she's not the only one who knows about \"<i>pressure points</i>\".  You menacingly wiggle your fingers at her. \"<i>Ah... I don't suppose I can just say I'm sorry and I was only kidding around?</i>\"  Izma hesitantly suggests.");
				
				outputText("\n\nYou click your tongue, shaking your head.  You tell her that there is no escape from her destiny.  The shark-morph promptly twists around in the snow and tries to dive away from you, forgetting that snow isn't as reactive to such efforts as water would be.  You grab her shark-tail and pull her back. \"<i>No, please, don't!  Anything but that!</i>\"  Izma wails as she is dragged to her inevitable tickling doom.");
				
				outputText("\n\nYou begin tickling her breasts, belly, arms, anywhere your wiggling fingers can touch.  Izma cackles and screeches, tears running down her face even as she pleads for you to stop; evidently, that tough orange and black-striped skin doesn't make her any less vulnerable to a good tickling session.  You don't heed her pleas, continuing to tickle the tiger-shark with abandon.  \"<i>All right, all right, stopit-stopit-stopit, I'm sorry, I'm sorry!</i>\" she cries.  You tell her that if she wishes you to stop all she has to do is admit, you're the alpha and she's the beta...   The tigershark tries, you have to give her points for that, but she can't quite gasp the words out around her laughter.  You tell her that her performance was lacking, so if she'll excuse you... you have more tickling to do.  \"<i>No!  Please, no, I'm sorry, you're the alpha and I'm the beta and I'll never forget it again!</i>\" she cries.  Satisfied, you turn her around, giving her a quick kiss and a tap on her nose.  With a wink you tell her to never forget that again.  \"<i>I promise to always remember that  - I know who's the conqueror in our little relationship.</i>\"  She grins, displaying her shark fangs.  Smiling, you wish her Happy Holidays.  \"<i>Happy... whatever that is. I just hope our next ones aren't so painful,</i>\" she replies, clutching her side for emphasis.");
				
				outputText("\n\nYou promise her that they won't be... if she remembers not to start something she can't finish, tapping the chastened tigershark on the nose for emphasis.");
				addButton(0,"Next",processJackFrostEvent);
				flags[kFLAGS.JACK_FROST_PROGRESS] = 4;
				return;
			}
			//Jojo
			else if ((player.findStatusEffect(StatusEffects.PureCampJojo) >= 0 || getGame().jojoScene.campCorruptJojo()) && flags[kFLAGS.JACK_FROST_PROGRESS] <= 4) {
				//Pure
				if (player.findStatusEffect(StatusEffects.PureCampJojo) >= 0) {
					outputText("Jojo is sitting on his usual rock, one hand out to catch snowflakes with a beatific smile of awe on his face.  \"<i>Look, [name], snow!  I haven't seen snow since I was a very, very small boy.</i>\"  He tells you.");
					
					outputText("\n\nSo is he enjoying it?  You ask.  If so, then it was worth it getting someone to make it snow on your camp.");
					outputText("\n\n\"<i>Yes, I'm enjoying it - it's a wonderful reminder of purer times.</i>\"  The mouse says, still catching flakes and watching them melt in the palms of his hands.");
					
					outputText("\n\nOut of the monk's sight you take a small bit of snow and slowly roll it into a ball.  Then taking your time to place your shot carefully, you swing your arm at full speed, hurling the small ball of snow right at the back of the white-furred monk's head.");
					outputText("\n\nThe snowball explodes as it lands, knocking Jojo right off his perch with a startled squeak.  \"<i>[name], what was that for!?</i>\" he splutters.");
					outputText("\n\nYou can't resist laughing out loud.  You were just testing to see if he had his guard up.");
					
					outputText("\n\nFaster than you would have expected, Jojo stoops down, rolls a snowball and smacks you right in the face with it.  \"<i>Two can play at that game,</i>\" he says, a faint grin playing on his features.");
					
					outputText("\n\nYou calmly wipe the snow off your face and smile evilly at the monk, asking him if he realizes this means war...");
					outputText("\n\n\"<i>Bring it on,</i>\" Jojo states, already bouncing another snowball in his palm.");
					outputText("\n\nLaughter echoes as the two of you exchange snowballs...");
					menu();
					addButton(0,"Next",processJackFrostEvent);
					flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
				}
				//Corrupt
				else {
					outputText("Out in the outskirts of the camp you notice your pet mouse-slut Jojo, casually fucking a small mound of snow like an animal.  You laugh to yourself, now, now... doesn't he know that there are better things to fuck than a pitiful mound of snow on the ground...");
					outputText("\n\nYou casually approach him from behind, stripping off your [armor].  Once behind his heart-shaped ass, you pull on his tail and reach down to grope at his shaft and balls.  Silly slut, you tell him.  This is not how one fucks in the snow... if he doesn't know how to do it right, you'll be happy to demonstrate.");
					//(How should you demonstrate?)
					//[Pen Ass] [Ride Cock] [Spank and Finger Ass]
					menu();
					if (player.hasCock()) addButton(0,"Pen Ass",penetradeCorruptJojoAss);
					if (player.hasVagina()) addButton(1,"Ride Cock",rideCorruptJojoCock);
					addButton(2, "Spank n Finger", spankNFingerCorruptJojoAss);
					addButton(4, "Leave Him", skipCorruptJojo);
				}
				return;
			}
			//Amily
			//less than 5!
			else if (getGame().amilyScene.amilyFollower() && flags[kFLAGS.JACK_FROST_PROGRESS] <= 5) {
				flags[kFLAGS.JACK_FROST_PROGRESS] = 6;
				//Pure
				if (!getGame().amilyScene.amilyCorrupt()) {
					outputText("Amily is warily prowling across the icy surface, occasionally glancing all around as if trying to spot an ambush.  Other times, she suddenly leaps up in a flurry, whirling around in mid-air as something catches her over-large ears.  All in all, it's quite obvious she's scared.");
					outputText("\n\nApproaching her, you ask what's gotten her so worried?");
					outputText("\n\n\"<i>Can't you see all this snow?  There hasn't been snow in Mareth since I was a little baby girl - the demons must have something to do with this!</i>\"  Amily hisses, clearly expecting an attack to come at any moment.");
					outputText("\n\nYou can't help but laugh lightly at Amily's wariness.  There's no need to be this worried.  You're responsible for today's snowing as a matter of fact.");
					
					outputText("\n\n\"<i>...You are?</i>\" she asks in obvious bafflement - her tail actually curls itself into a crude question-mark shape behind her for emphasis.");
					
					outputText("\n\nYou nod.  You met someone who was capable of making it snow up in the mountains, and he was nice enough to offer to make it snow on your camp.  So you accepted it, you thought that everyone deserves a day of fun in the snow, where you can all forget the troubles of the world... at least for a day.");
					
					outputText("\n\nThe mouse smiles and then scampers through the snow to hug you fiercely.  \"<i>Oh, thank you, thank you!  It's so wonderful to see something like this again; it reminds me of what the world was like before the demons ruined everything... and it gives me hope that you'll stop them, too.</i>\" she says, nuzzling you in her affectionate overload.");
					
					outputText("\n\nYou laugh and hug her back, telling Amily to take it easy.  With all the friction the two of you are making, hugging together and nuzzling, you might just end up melting all the snow.  The mouse looks into your eyes. \"<i>Oooh, you little tempter, you,</i>\" she trills, tail looping around your wrist.  \"<i>Maybe I wouldn't mind that...?</i>\" she suggests mischievously.");
					outputText("\n\nYou grin at her then envelop her lips into a kiss... sounds like a plan, you're feeling a bit cold and this would be a nice way to warm you right up...");
					outputText("\n\nIt's not really possible to smirk and kiss at the same time, but your murine lover does her level best to try.  Breaking the kiss with a smile, she tugs you gently towards your " + camp.homeDesc() + ".  \"<i>Come on then, lover-" + player.mf("boy","girl") + ", let's go and get warmed up...</i>\" She coos.  Her hands start to remove your clothes, \"<i>So, what do you have in mind, exactly...?</i>\"");
					//[Penetrate Her] [Make out]
					menu();
					if (player.hasCock()) addButton(0,"Penetrate",penetradePureMouseWaifu);
					addButton(1,"Ride Cock",makeOutWithPureMouseWaifu);
					return;
				}
				//Corrupt
				else {
					outputText("Out in the outskirts where your favorite cum-slut lives, you spot her slowly rubbing the snow over her erect nipples, the cold making her shiver in pleasure.");
					outputText("\n\nYou approach her with a smile, commenting that she seems to be enjoying herself...");
					outputText("\n\nLooking up to you and kneeling obediently as her spaded mouse-tail waves lazily behind her, she smiles.  \"<i>Very much, [master].  I haven't seem snow ever since I was a little baby girl.  So seeing all this snow is such a turn-on for me, [master].</i>\"");
					outputText("\n\nYou laugh, telling her to enjoy it; then maybe, thank you later, since you're responsible for the snow.");
					outputText("\n\nAmily gasps.  \"<i>O - Of course!  I'm [master]'s loyal cum-guzzling mouse-slut.  I'm ready to serve anytime!  Thank you for letting me play in the snow.</i>\"  She grins gratefully at you.");
					outputText("\n\nYou pat her on the head, telling her she's welcome...");
					//(if PC has genitals)
					if (player.gender > 0) {
						outputText("\n\nStopping to scratch your chin in thought... you ask how she would like a cum-cone?");
						outputText("\n\nAmily smiles with glee.  \"<i>Oh, I would love it [master]...</i>\"");
						
						//(if PC has a dick)
						if (player.hasCock()) {
							outputText("\n\nYou strip off your lower garments, exposing your " + player.multiCockDescriptLight() + " to the hungry eyes of your cumslut.  You tell her you would like her to give you a \"<i>hand</i>\", with the extraction process...");
							outputText("\n\nAmily bows respectfully.  \"<i>Right away, [master].</i>\"");
							outputText("\n\nShe promptly takes hold of your [cock] with awe-filled respect, her long, dextrous fingers quickly falling into the familiar rhythym of dancing along your cock to fill you with the most wonderous sensations.  Her spaded tail wiggles idly for several moments, then slithers through the air to brush its feather-like tip against the tip and underside of your shaft");
							if (player.balls > 0) outputText(", even tickling your [balls]");
							else if (player.hasVagina()) outputText(", even tickling your [cunt] for added tantalization");
							outputText(".");
							
							outputText("\n\nFeeling yourself getting close, you pull away from the corrupt mousette and aim yourself at a particularly soft-looking mound of snow.  With a few more pumps you moan and blast your load, soaking the snow in spunk.  You tell Amily there she has it... her cum-cone is ready for the picking.");
							
							outputText("\n\n\"<i>Oh, [master]!  Thank you, thank you, thank you!</i>\"  She claps her hands in delight, moving over to gather a handful of snow and eat it all up.  \"<i>Hmm... delicious and refreshing... thank you, [master].</i>\"  You pat her on her head and redress yourself, moving away...");
						}
						else { //if PC has a vagina
							outputText("\n\nYou strip off your lower garments, exposing your [vagina] to the hungry eyes of your cumslut.  You tell her you would like her to give you a \"<i>hand</i>\", with the extraction process...");
							outputText("\n\nAmily bows respectfully.  \"<i>Right away, [master].</i>\"  She quickly slides through the snow into position, kneeling before you with all the respect of a devout nun at prayer, and begins to run her nimble fingers expertly through your cunt, tickling and fondling your [clit] with her long spade-tipped tail as her fingers probe and slide through your netherlips, sending sparks coursing through your being.");
							outputText("\n\nFeeling yourself getting close, you pull away from the corrupt mousette and stand over a particularly soft-looking mound of snow.  With a few more prods from your questing fingers and a little pinch on your [clit] you moan throatily and let your femcum spill out of your [vagina].  Wave after wave of juices spill, sliding along your [legs] to mat the white snow.  By the time you're done the whole area around you smells of pussy juice and sex... truly a delightful aroma.");
							outputText("\n\n\"<i>Slut!</i>\" you tell, calling Amily to attention, who seemed to be just a little too distracted with the fumes of your recent climax.  \"<i>Y - Yes, [master]?</i>\"  You tell her to eat it all up, and enjoy her juicy cum-cone.");
							outputText("\n\n\"<i>Oh, [master]!  Thank you, thank you, thank you!</i>\"  She claps her hands in delight, moving over to gather a handful of snow and eat it all up.  \"<i>Hmm... sweet and refreshing... thank you, mistress.</i>\"  You pat her on her head and redress yourself, moving away...");
						}
					}
				}
				menu();
				addButton(0,"Next",processJackFrostEvent);
				return;
			}
			//Tainted Ember
			else if (getGame().emberScene.followerEmber() && flags[kFLAGS.JACK_FROST_PROGRESS] <= 6) {
				flags[kFLAGS.JACK_FROST_PROGRESS] = 7;
				outputText("The dragon is wandering your camp in open fascination.  \"<i>What is this weird white stuff?  It's cold and wet... but soft and fluffy, too,</i>\" [ember ey] says, gently catching a snowflake.");
				outputText("\n\nHaving heard [ember eir] question, you approach Ember and tell [ember em] that's just snow.");
				outputText("\n\n\"<i>Snow...?</i>\" [ember Ey] repeats in a curious, blatantly awed voice.  \"<i>...It's so pretty.</i>\" [ember ey] tells you.");
				outputText("\n\nYou ask if this is [ember eir] first time seeing snow.  It always snowed back home around this time of the year.  Why... back when you were a child, you used to play all the time in the snow.");
				
				outputText("\n\n\"<i>So it's for kids,</i>\" Ember notes, sounding kind of depressed - and a little envious, especially given the way she still looks so eagerly at the snow all around you.");
				outputText("\n\nPerhaps... would [ember ey] like to play in the snow with you?");
				outputText("\n\n\"<i>I thought you said this was for little kids?  I'm no baby!</i>\" Ember protests.");
				outputText("\n\nWho said it was just for kids?  You just said you used to play all the time when you were a child, there is no reason why you couldn't play now that you're grown up either... after all, back in your village, even adults played in the snow.  Unless... [ember ey] doesn't like the idea of spending the day playing with you?  That would be a pity, since it's [ember eir] first time seeing snow...");
				outputText("\n\n\"<i>What?  I... ooh, very well.  Teach me how you play with this stuff,</i>\" Ember says, blowing a thin trail of steam out of each nostril.");
				outputText("\n\nYou smile and begin explaining to the dragon all about the games you used to play when it snowed back home.  Ember listens attentively with a gleam in [ember eir] eyes.");
				outputText("\n\nBy the time you're done Ember's tail is waving excitedly behind her.  You ask how she'd feel about a snowball fight?");
				outputText("\n\n\"<i>All right, let's try it!</i>\" [ember ey] agrees, as eager as any kid back in Ingnam.");
				
				outputText("\n\nYou explain to [ember em] the rules and walk a short distance away... then declare the match started!  Ember is pretty good... but being [ember eir] first time doing this, [ember ey] ends up not being able to hit you as many times as you hit [ember em], while you expertly dodge and roll her snowballs.");
				outputText("\n\n\"<i>Damn it, stand still, [name]!  You're slippier than the rabbits I go catching in the mornings!</i>\" the irate dragon complains.");
				
				outputText("\n\nRather than complaining [ember ey] should be focusing on hitting you, otherwise you're going to end up crushing [ember em] in this match!  You tease [ember em], throwing another snowball right on [ember eir] belly.");
				
				outputText("\n\nThe dragon promptly drops to [ember em] knees and starts sweeping together huge armfuls of snow, crushing and melding them together until [ember ey] has made a snowball the size of a small boulder, which [ember ey] promptly hurls at you.");
				
				outputText("\n\nWoah!  The large ball of snow connects squarely with your face, bowling you over and burying you under the snow.  Having the air knocked out of you, you scramble to dig yourself off the snow.");
				
				outputText("\n\nA pair of claw-fingered hands promptly come clawing their way through the snow, grabbing you by the shoulders and pulling you bodily out of the snow.  \"<i>Well?  I think I won that round,</i>\" [ember ey] gloats, a twinkle of delight in [ember eir] eye.");
				
				outputText("\n\nCoughing up some snow, you concede defeat, congratulating Ember on winning [ember eir] first snowball fight... but then, you smirk and tell [ember em] this was all beginner's luck... and next time you'll beat [ember em] for sure.");
				
				outputText("\n\n\"<i>So you say, but the truth is you know you'll never beat me,</i>\" Ember brags.  Then [ember ey] lowers her eyelids and gives you a coy look.  \"<i>And now, for the victor, a prize,</i>\" [ember ey] growls, then swoops in to kiss you passionately.  Several minutes pass before [ember ey] breaks the kiss, a somewhat goofy smile on [ember eir] face.  \"<i>I'm going to go and play in the snow some more.  See you, [name].</i>\"  [ember Ey] giggles, then ambles off.");
				outputText("\n\nYou wave [ember em] away - maybe being beaten isn't so bad.  Your thoughts turn to Ember's passionate kiss...  It certainly is a nice sight, to see [ember em] so happy.  Having it snow on your camp was a great idea after all.");
				menu();
				addButton(0,"Next",processJackFrostEvent);
			}
			//Marble (Written by TDM himself)
			else if (flags[kFLAGS.JACK_FROST_PROGRESS] <= 7 && player.findStatusEffect(StatusEffects.CampMarble) >= 0) {
				flags[kFLAGS.JACK_FROST_PROGRESS] = 8;
				//With Kids
				if (flags[kFLAGS.MARBLE_KIDS] > 0 && flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] >= 100) {
					outputText("You find Marble simply staring into the sky, a look of wonder covering her face.  Dancing around her in excitement ");
					if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("are ");
					else outputText("is ");
					outputText("your kid");
					if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("s");
					outputText(", playing in the snow, blowing the snow, and experimenting with the snow.  Exactly what ");
					if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText("she");
					else outputText("they");
					outputText(" are up to at any given moment is really hard to say, and you're not even sure that the little girl");
					if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("s");
					outputText(" know");
					if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText("s herself.");
					else outputText(" themselves.");
					
					outputText("\n\nMarble lifts up her hand, then takes a step forward as you approach.  It looks like she is about to catch a flake in her hands, only to instead suddenly slip on the frozen ground under her hooves, and fall down onto her backside with a cry of surprise.  \"<i>Oww...</i>\" she grumbles, giving her backside a rub as you come up in front of her.  You tell her to be careful, that stuff can be slippery while extending your hand to help her up.  \"<i>Yeah, thanks sweetie, I noticed.</i>\" she sighs and accepts your hand.");
					
					outputText("\n\n\"<i>" + player.short + ", do you know what this is?</i>\" your lover asks while raising her arms in the air and looking around in amazement once more.  \"<i>How can stuff fall from the sky?</i>\"  You laugh, and say that it's snow, or frozen rain.  The cow-girl looks at you in confusion once more and asks what rain is.  Now it is your turn to be surprised, she has never seen it rain before in her life?  It has never gotten cloudy and water has fallen from the sky?  Marble shakes her head no, \"<i>Sweetie, I'm not sure what a cloud is either.  Every day of my life has always been sunny and warm.  This is something I've never experienced before...</i>\"");
					
					outputText("\n\nYou're left at a loss for words once more, and the two of you turn back to look at your ");
					if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText("child");
					else outputText("children");
					outputText(" playing together once more.  A moment later, Marble puts her hand to her expansive backend again, before suddenly exclaiming again in realization.  \"<i>Sweetie, watch our kid");
					if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("s");
					outputText(" for a moment, I'll be right back!</i>\" and she leaves the camp as quickly as she can, without slipping and falling on her ass again.");

					outputText("\n\nYou certainly don't mind staying behind for now, it is certainly a lot of fun spending time with your kid");
					if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("s");
					outputText(" and just having fun.  Your cow-girl daughters are certainly not lacking in energy in the cold snow, their fur covered legs and built in shoes probably help a lot with this.  ");
					if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("They");
					else outputText("She");
					outputText(" listen");
					if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText("s");
					outputText(" with rapt attention when you explain what snow is, and about all the things you use to do in it back home.  Hands-on demonstrations are also in high demand.");
					
					outputText("\n\nWhen Marble returns, she can't find a single face that isn't showing a huge smile.  That isn't to say that there wasn't more excitement when what she went off to get is revealed; a big sled for the little one");
					if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("s");
					outputText(" to ride on!  Happy cries of joy fill the air for some time, as you and Marble take turns in giving rides on the sled.");
					
					//PC strength check:
					//(>=85)
					if (player.str >= 85) {
						outputText("\n\nIt would seem that your strength has won you more favor with ");
						if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("the girls");
						else outputText("your daughter");
						outputText(" when it comes to giving sled rides, Marble doesn't seem to mind too much though.  Your mate actually decides to join in the riding part after a while!");
					} 
					//(60-84)
					else if (player.str >= 60) {
						outputText("\n\nSoon you and Marble turn the sled rides into a friendly contest, trying to earn the favor of ");
						if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("the girls");
						else outputText("your daughter");
						outputText(" in deciding who gives the best rides.  In the end, a clear winner is never decided, but everyone agrees that it was a lot of fun.");
					}
					//(<=59)
					else {
						outputText("\n\nOf course, Marble's great strength soon shows you that you simply can't compete with her when it comes to giving sled rides.  Instead, you end up joining in with the kids and have fun riding with them as Marble pulls you all around on the snow with a smile on her face.");
					}
					
					outputText("\n\nAfter the sled rides end, you all cuddle up together under the blankets Marble put in the nursery for the kids that seldom get used.  There isn't much else to be said, and everyone just relaxes and enjoys the combined warmth that your bodies bring.");
				}
				//Without kids
				else {
					outputText("You find Marble simply staring into the sky, a look of wonder covering her face.  She lifts up her hand, then takes a step forward as you approach.  It looks like she is about to catch a flake in her hands, only to instead suddenly slip on the frozen ground under her hoofs, and fall down onto her backside with a cry of surprise.  \"<i>Oww...</i>\" she grumbles, giving her backside a rub as you come up in front of her.  You tell her to be careful, that stuff can be slippery while extending your hand to help her up.  \"<i>Yeah, thanks sweetie, I noticed,</i>\" she sighs and accepts your hand.");
					outputText("\n\n\"<i>" + player.short + ", do you know what this is?</i>\" your lover asks while raising her arms in the air and looking around in amazement once more.  \"<i>How can stuff fall from the sky?</i>\"  You laugh, and say that it's snow, or frozen rain.  The cow-girl looks at you in confusion once more and asks what rain is.  Now it is your turn to be surprised, she has never seen it rain before in her life?  It has never gotten cloudy and water has fallen from the sky?  Marble shakes her head no, \"<i>Sweetie, I'm not sure what a cloud is either.  Every day of my life has always been sunny and warm.  This is something I've never experienced before....</i>\"");
					
					outputText("\n\nYou're left at a loss for words once more, and the two of you turn back to look at the snow once more.  You feel Marble gently take a hold of your hand as you two simply watch the flakes fall to the ground.");
					
					//PC height check:
					//(greater than 75 inches)
					if (player.tallness > 75) outputText("\n\nMarble leans against you, and gently asks, \"<i>Sweetie, will you please tell me about the snow and rain?</i>\"");
					//(less than, or equal to 75 inches)
					else outputText("\n\nMarble pulls on you to get you to lean against her, and gently asks, \"<i>Sweetie, will you please tell me about the snow and rain?</i>\"");
					
					outputText("\n\nYou start to speak, slowly at first, but pick up speed as you go.  You tell her about the patter of raindrops on the roof of your home, and about the feel of water droplets falling on your face when running outside.  Of the snow flurries that can fill the air for days, and about the new great white landscapes that they brought.  Finally you tell her about how the land looks and smells refreshed at the end of a rainfall, and the games that you and the other kids use to play in the refreshed land, or in the snow drifts.");
					
					outputText("\n\nYou finish, and silence once again fills the air as you two continue to watch the snow fall.  \"<i>Sweetie?</i>\" Marble suddenly speaks out, \"<i>I want to have kids with you some day.</i>\"  You look at her somewhat surprised, she continues to simply look ahead, continuing, \"<i>I want them to experience those things too, and there is no one else that I'd rather have them with then you.</i>\"  There isn't much else to do but to look back at the falling flakes once more.");
				}
				menu();
				addButton(0,"Next",processJackFrostEvent);
				return;		
			}
			//Helia
			//if she ain't a follower and is a lover, just have her visit.
			else if (flags[kFLAGS.JACK_FROST_PROGRESS] <= 9 && (getGame().helScene.fuckBuddyHel() || getGame().helFollower.followerHel())) {
				
				outputText("\"<i>Hey, champ, what's going on here?</i>\"  Helia calls as she sees you approach.  Gentle trails of steam are wafting from the salamander's body as her own internal heat melts any snow that builds up on her.");
				outputText("\n\nYou greet your salamander lover, telling her you found a way to make it snow on your camp... so you were just planning on having a snow-day play-day on your camp, while it lasts.");
				outputText("\n\n\"<i>What's a snow-day play-day?</i>\"  The firey lizard-girl asks, clearly not understanding the reference; it may not have snowed in the plains even before this accursed drought.");
				
				outputText("\n\nYou explain to her it's just having fun in the snow... something you used to do a lot as a child.  You'd build snowmen, make snow angels, have a snowball fight-");
				
				outputText("\n\n\"<i>Fight? Now you're talking my language!</i>\"  Helia cheers.  The cloud of steam around her gets even denser as she starts melting the snow she's standing in.  You give her a wry glance and point out she can't really participate if she's so hot that the snowballs melt to slush in her hands.");
				
				outputText("\n\nHelia doesn't listen as she hurls a handful of water straight at you, splashing your face with molten snow.  \"<i>Looks like I hit you pretty well there!</i>\"  She laughs uproariously.  Well... if this is how she intends to play... You quickly roll up a ball of snow of your own and toss it at her!  It connects with a hiss as the snowball quickly melts off her body.");
				
				outputText("\n\n\"<i>All right!  Now let's get this party started!</i>\" she cries, doing her best to grab handfuls of melting slush and hurl them at you before they completely dissolve.");
				
				outputText("\n\nYou enjoy your 'battle' with Helia a while longer.  Eventually, you're completely soaked, water dripping off your [armor].  You ask for Helia to stop for a moment, shivering as the cold finally gets to you.");
				
				outputText("\n\nHelia sighs, obviously disappointed, but complies.  \"<i>You know, now that you're so cold, I got the perfect way to warm you up...</i>\"  She smirks, squeezing her sizable dark-skinned breasts to make you perfectly aware of what she's suggesting.");
				outputText("\n\nCold and not willing to keep the salamander-girl waiting, you eagerly strip off your [armor] and pounce towards her...");
				outputText("\n\nYou are rather surprised when Helia fends you off, knocking you into the snow.  She clicks her tongue and waggles her finger at you, her expression highly amused.  \"<i>Sorry, pervy, but I didn't mean sex... not that I would say no to a nice tumble afterwards,</i>\" she leers.");
				outputText("\n\nYou wipe the snow off your face and ask her what she has in mind, if not that?");
				outputText("\n\nWithout words, the fiery lizard-woman shucks off her clothes until she is standing naked in the snow before you, striking a pose that shows off her muscles (and also, by sheer coincidence, her boobs and ass), allowing flakes of snow to fall upon her and sizzle into steam.  \"<i>Why, a good hard wrestle, lover!</i>\"  She grins, and then suddenly she springs at you!");
				//(Speed check)
				if (player.spe/20 + rand(20) > 11) {
					outputText("\n\nYou're surprised by the sudden lunge, but thankfully your well trained reflexes means you quickly duck under the pouncing salamander and watch as she falls face-first into the snow behind you with an audible \"<i>Oof!</i>\"");
					outputText("\n\nShe laughs as she surfaces amidst a spray of slush, whipping her long hair around.  \"<i>That's the way to do it, lover-" + player.mf("boy","girl") + "!</i>\" she crows.");
				}
				else {
					outputText("\n\nYou yelp in surprise as the salamander comes crashing down on you, pinning you to the floor and holding your shoulders.");
					outputText("\n\n\"<i>Look at that; I think I win already,</i>\" she laughs.  Not if you can help it!  You give a sly smirk.");
				}
				outputText("\n\nThe two of you toss and turn, trying to pin each other down on the wet ground, but it's quite a difficult task.  Not only is Helia pretty good at this, but the wet snow also makes her skin and scales become so slippery that she manages to easily escape from your pins and holds.  Of course, this also works to your advantage when you get pinned yourself.");
				outputText("\n\nThat's not to say Helia gives up, insistently diving and scrambling, wrestling with all the sinewy strength her body is capable of mustering.  By the time you've both burnt up your energy, the snow in a meter-wide circle has been melted into slushy mud and the two of you are both steaming in the chill air.  Helia leans against you, your mutual exhaustion grounds for a truce, heaving for air.  \"<i>Now that is what I call a fun little workout, [name],</i>\" she tells you.");
				outputText("\n\nYou wipe some moisture from your brow, nodding agreement.  Yeah, that was pretty fun... you didn't think wrestling could be this fun, nor this sexy, you point out");
				if (player.gender > 0) {
					outputText(", as evidenced by ");
					if (player.hasCock()) outputText("your erect " + player.multiCockDescriptLight());
					if (player.gender == 3) outputText(" and ");
					else if (player.hasVagina()) outputText("your ");
					if (player.hasVagina()) outputText("dripping [vagina]");
				}
				outputText(".");
				
				outputText("\n\n\"<i>Heh, yeah, a nice wrestle in the wet's always been like that for us salamanders,</i>\" Helia laughs.   \"<i>Don't worry, sexy, we'll take care of that in a minute... but first!</i>\"  She suddenly turns and lunges at you, knocking you over and pinning you to the ground, thanks to the advantage of attacking while your guard was off.  Your shocked yelp is promptly smothered as she kisses you fiercely, grinding her sopping-wet gash against your crotch.");
				
				outputText("\n\nYou kiss her back, trying your best to turn the tables on the fiery salamander, rubbing your body against hers with as much enthusiasm as her.  Breaking the kiss shortly, you tell her that was a pretty low move, and call her a cheater.");
				
				outputText("\n\n\"<i>All's fair in love and war, [name], and when you're with a salamander, it's often hard to tell the difference,</i>\" Helia laughs, then promptly cuts off any further attempt at conversation by sticking her tongue in your mouth, her fiery tail coiling around your [hips] to brush its warm tip lustfully over your [ass].");
				
				outputText("\n\nUnwilling to engage in any further conversation, you resolve to simply accept Helia's playful affections.  You grind yourself against her, feeling the fire of your combined lusts heat your bodies.  The snow that falls on top of your grinding bodies ensure that the area around you is always partially obscured by steam.  With your fierce making out, it's no surprise when you feel a familiar feeling build up inside you.");
				
				outputText("\n\nThe salamander suddenly cries out, steaming-hot femcum splashing across your [legs] as she orgasms first, spasming from her position atop you before falling limp with an ecstatic sigh, giving you free reign to do what you want.  Not that you could do anything, yourself, since you suddenly spasm and cries out as your own orgasm overwhelms you.");
				
				//(If PC has a cock)
				if (player.hasCock()) outputText("  A torrent of seed splashes against Helia's taut belly, as [eachCock] throbs and spews its seed while sandwiched between the two of you.");
				//(if PC has a pussy)
				if (player.hasVagina()) outputText("  Your [vagina] quivers and spill your juices with the force of a wave.  Moisture falls on the ground to join in with Helia's own discharge.");
				
				outputText("\n\nAs you finally finish cumming, Helia lifts her head and starts to laugh.  \"<i>Oh, man, not how I'd usually do it, but whoo, what a ride, huh?</i>\" she laughs.  You laugh as well.  It certainly felt good, though this is far from what you're used to.  You have to give Helia's wrestling idea some credit.  Rolling around with her, grinding together was pretty hot - in more ways than one.");
				
				outputText("\n\n\"<i>Oh, were you maybe wanting another turn, lover?</i>\"  Helia insinuates, gently tapping her fingers on your chest.  You make a show of considering her offer, then, with a smile, say that sounds like a reasonable proposal.  You promptly wrap the salamander-girl, into a tight hug, spreading her legs so you can have access to her dripping vagina...");
				flags[kFLAGS.JACK_FROST_PROGRESS] = 10;
				menu();
				addButton(0,"Next",processJackFrostEvent);
				return;
			}
			//Isabella
			else if (getGame().isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.JACK_FROST_PROGRESS] <= 10) {
				outputText("The bovine adventurer Isabella is staring at the snow around her with a sad look on her face, one hand gently raised to catch snowflakes.  She watches them gather in her palm and heaves a huge sigh.  You quietly approach her and ask what's wrong; is she homesick?");
				outputText("\n\n\"<i>");
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("Da, [name], I am,");
				else outputText("Yes, [name], I am,");
				outputText("</i>\" she replies.  ");
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Back home, in mine land, it vould be snowing all over at this time of year, and ve vould be having big vinter festival to celebrate ze ending of old year and coming of new year.  This land, it is so dry and hot...  I had forgotten it, but seeing zis snow makes me remember it and all I have lost by being stuck here.</i>\"  She sighs.");
				else outputText("\"<i>Back home, in my old land, it would be snowing all over at this time of year, and we would be having a big winter festival to celebrate the ending of the old year and the coming of the new one.  This land, it's so dry and hot...  I had forgotten it, but seeing this snow makes me remember it and all I have lost by being stuck here.</i>\"  She sighs.");

				outputText("\n\nYes, you agree.  It does bring back memories.  Though you don't know if you've been in this world quite as long as Isabella has.  You chuckle to yourself.  If you were back in your village, you and your family would be gathering for a big feast, playing in the snow, drinking, laughing... all the jolly good stuff.  Still, at least you're not alone here in Mareth.  You look at Isabella with a smile.");
				
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>So, you are having a celebration at this time of year too?  How coincidental,</i>\" she muses, but then favors you with a friendly smile.  \"<i>But, da, it is good zat ve have found each other and so must not be lonely at zis time of year.</i>\"  Then she sighs, \"<i>I could use a nice hot cup of yochalot, though.</i>\"");
				else outputText("\n\n\"<i>So, you have a celebration at this time of year too?  How coincidental,</i>\" she muses, but then favors you with a friendly smile.  \"<i>But, yeah, it's good that we have found each other and have each other's company at this time of year.</i>\"  Then she sighs, \"<i>I could use a nice hot cup of yochalot, though.</i>\"");
				outputText("\n\nYochalot?  You ask in curiosity.");
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>Da, yochalot.  It is very sweet, tasty treat, made from grinding up special bean seeds.  We add powder to warm milk and it is most yummy, mmm...</i>\"  Isabella makes a show of rubbing her hands over her belly with a delighted smile.  \"<i>I would always have a great big mug of hot yochalot at this time of year, ja?</i>\"");
				else outputText("\n\n\"<i>Yep! Yochalot.  It's a very sweet, tasty treat, made from grinding up special bean seeds.  We add powder to warm milk and it is most yummy, mmm...</i>\"  Isabella makes a show of rubbing her hands over her belly with a delighted smile.  \"<i>I would always have a great big mug of hot yochalot at this time of year.</i>\"");
				outputText("\n\nYochalot... sounds a lot like chocolate...  Still, you'd like to try it sometime.  You tell the cow-girl as much.");
				
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\n\nAt this, she looks crestfallen.  \"<i>I am sorry, mein little sweety, but I am having no yochalot on me - I drank ze last of mine some time ago, and I do not think zey have such thing in this vorld any more.  At least, none that has not been tampered with, like the demons have ruined so many other nice things.</i>\"  She scowls.  \"<i>The only thing I could be offering you is nice, warm milk, fresh from the tap, so to speak.</i>\"  She pats her hefty quad-nippled boobs to make it clear where the milk would come from.");
				else outputText("\n\nAt this, she looks crestfallen.  \"<i>I am sorry, my little sweet, but I don't have any yochalot on me - I drank the last of mine some time ago, and I don't think they have such thing in this world any more.  At least, none that have not been doubtlessly tampered with, like the demons have ruined so many other nice things.</i>\"  She scowls.  \"<i>The only thing I could be offering you is nice, warm milk, fresh from the tap, so to speak.</i>\"  She pats her hefty quad-nippled boobs to make it clear where the milk would come from.");
				
				outputText("\n\nPity, but then again, Isabella's milk is pretty tasty.  You confess you're feeling at least a bit chilly, so, you ask the cow-girl if she wouldn't mind warming you up with some of her sweet-tasting milk?");
				
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\n\nIsabella looks surprised, and then grins mischievously.  \"<i>Okay then, mein sweet,</i>\" she says, calmly exposing her breasts.  \"<i>I vill give you all ze milk you could want,</i>\" she adds, then suddenly lunges for you, grabbing your head and pulling you into a headlock that, not so coincidentally, mashes your face against her naked boobs.  \"<i>Naughty, cheeky [name]!  If you are wanting to drink mein milk, zen you are not needing zis subterfuge to get me in the mood,</i>\" she chortles good-naturedly as she finishes, her homesickness evidently forgotten with the diversion you've presented her.");
				else outputText("\n\nIsabella looks surprised, and then grins mischievously.  \"<i>Okay then, sweet,</i>\" she says, calmly exposing her breasts.  \"<i>I will give you all the milk you could want,</i>\" she adds, then suddenly lunges for you, grabbing your head and pulling you into a headlock that, not so coincidentally, mashes your face against her naked boobs.  \"<i>Naughty, cheeky [name]!  If you want to drink my milk, then you don't need this subterfuge to get me in the mood,</i>\" she chortles good-naturedly as she finishes, her homesickness evidently forgotten with the diversion you've presented her.");

				outputText("\n\nSeeing as you're already so conveniently positioned, you waste no time in opening your mouth and taking her four nipples into your mouth, suckling in earnest, as the cow-girl's tasty milk fills your mouth and belly.  You momentarily stop your nursing to lick a stray drop of milk that has escaped your mouth, smiling to Isabella, you tell her that her milk truly hits the spot.  You can already feel yourself getting warmer.");
				
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\n\nIsabella smiles and cuddles you against her bosom.  \"<i>Be honest; you vere not vanting mein milk, you vere wanting to be cheering me up, da?</i>\" she laughs.  Busted!  You laugh yourself, though your plan seems to have worked pretty well, and you're not complaining about the bellyful of tasty milk you've gotten either.  You burp sheepishly, for emphasis.");
				else outputText("\n\nIsabella smiles and cuddles you against her bosom.  \"<i>Be honest; you weren't wanting my milk, you wanted to cheer me up, huh?</i>\" she laughs.  Busted!  You laugh yourself, though your plan seems to have worked pretty well, and you're not complaining about the bellyful of tasty milk you've gotten either.  You burp sheepishly, for emphasis.");
				
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>You are just ze sweetest little thing, aren't you, [name]?</i>\"  Isabella laughs, her breasts jiggling heavily from the force.  \"<i>Vell, if you are liking mein milk so much, perhaps you should have some more, da?</i>\"  She grins, gently lifting one breast with a free hand to better offer it to you.");
				else outputText("\n\n\"<i>You are just the sweetest little thing, aren't you, [name]?</i>\"  Isabella laughs, her breasts jiggling heavily from the force.  \"<i>Well, if you are liking my milk so much, perhaps you should have some more, yeah?</i>\"  She grins, gently lifting one breast with a free hand to better offer it to you.");
				
				outputText("\n\nSounds like a plan, you tell the cow-girl.  You take the offered tit in your hands and proceed to bury yourself into the pillowy mound, latching onto her nipples and draining them of all its contents as fast as you can without choking.");
				
				if (getGame().isabellaFollowerScene.isabellaAccent()) outputText("\n\nIsabella smiles and releases her arm from around your neck to instead stroke your [hair].  \"<i>Da, zat ist good, [name].  I love to empty zese big boobs of mine, but I am loving you more,</i>\" she says this last-part in a stage whisper, clearly intending for you to hear it.  You decide that for now, you'll just busy yourself with the cow-girl's teats, you can return the feelings later...");
				else outputText("\n\nIsabella smiles and releases her arm from around your neck to instead stroke your [hair].  \"<i>Yeah, that's good, [name].  I love to empty these big boobs of mine, but I think I love you more,</i>\" she says this last-part in a stage whisper, clearly intending for you to hear it.  You decide that for now, you'll just busy yourself with the cow-girl's teats, you can return the feelings later...");
				flags[kFLAGS.JACK_FROST_PROGRESS] = 11;
				menu();
				addButton(0,"Next",processJackFrostEvent);
			}
			//Kiha
			else if (getGame().kihaFollower.followerKiha() && flags[kFLAGS.JACK_FROST_PROGRESS] <= 11) {
				outputText("\"<i>Ah-ah-ahchoo!</i>\"");
				outputText("\n\n\"<i>Bless you,</i>\" you say to Kiha as you approach the dragon-girl.");
				outputText("\n\nKiha sniffles and wipes her nose on her arm when she sees you.  \"<i>[name], what is this weird white stuff?  It's cold and wet and - achoo!</i>\"  She sneezes again, spraying a gout of flame across the camp.  \"<i>And the flakes keep flying up my nose,</i>\" she snuffles.");
				
				outputText("\n\nYou explain to Kiha it's just snow.  You had a friend you met recently help you make it snow in your camp, since it would be snowing around this time of the year, back home.  You thought it would be fun to take a break from adventuring to enjoy the snow... at least for a day.");
				
				outputText("\n\n\"<i>Achoo!</i>\" she sneezes again, sending sparks flying.  \"<i>What could be fun about this cold wet stuff?</i>\" she growls.");
				outputText("\n\nWell, aside from the games, there's also the romantic side... like keeping your loved ones warm.  You close the distance between the two of you and embrace the dragon-girl into a hug, doing your best to keep her warm.");
				
				outputText("\n\n\"<i>W-what are you doing, doofus?</i>\" she demands, blushing - which, coincidentally, makes her grow noticeably warmer in your arms.  You chuckle and tell her you're just helping her stay warm, and by the feel of things, it seems to be working.  You can't have her setting your camp ablaze with her sneezes, so this was absolutely necessary, you tell her, hoping to cull any incoming protests.  However, you don't miss the opportunity to run your hands over her back, down her scaled tail, and over her wonderful buttcheeks.");
				outputText("\n\nShe swallows hard, you can hear the gulping in her throat, but she hugs you back, slowly growing bolder and running her hands across your body in the same manner yours are running across hers.  \"<i>Well, you do have good taste,</i>\" she admits in a hoarse half-whisper, eyes lidded and smouldering.");
				outputText("\n\nSeeing that, you suggest that perhaps the two of you should move somewhere more... private.  You happen to know a way to make her feel even warmer.  She says nothing, looking into your eyes and nodding with a soft smile on her face, obviously trusting you to lead her.");
				outputText("\n\nYou waste no time in leading her away to a snowy clearing nearby.  Once there you look the shivering dragon-girl over, considering your options...");
				//[Fuck her] [Lick Boobs and Finger Pussy]
				flags[kFLAGS.JACK_FROST_PROGRESS] = 12;
				menu();
				if (player.hasCock() && player.cockThatFits(67) >= 0) addButton(0,"Fuck Her",kihaXmasFuck);
				addButton(1,"Finger Her",kihaXmasFingering);
			}
			//Feast time! Just a collection of words on the pleasant day...
			else {
				outputText("This small holiday of yours was much needed.  You feel reinvigorated and even more determined to put an end to this struggle with demons.");
				outputText("\n\nThe only thing left to end this day is a feast.  Though your family is not here to join you, at least you won't be dining alone.");
				//(if One sexable follower)
				if (camp.loversCount() + camp.slavesCount() == 1) {
					outputText("\n\nYou take care of the preparations and cooking, whipping up a delightful meal for you and your companion.  You can tell that you were not the only one needing this break, and judging by the way your companions eyes you as the two of you eat... it seems the day is not over yet...");
				}
				//(if no sexable follower)
				else if (camp.loversCount() + camp.slavesCount() == 0) {
					outputText("\n\nYou take care of the preparations and cooking, whipping up a delightful meal for you and your companion");
					if (camp.companionsCount() > 1) outputText("s");
					outputText(".  You can tell that you were not the only one needing this break... but unfortunately all good things must come to an end, and so you bid your companion");
					if (camp.companionsCount() > 1) outputText("s");
					outputText(" good night and retire for the night.");
				}
				////more than one sexable follower.
				else {
					outputText("You take care of the preparations and cooking, whipping up a delightful meal for you and your companions.  For a moment you look around - this small band you've formed feels enough like a family that you wouldn't mind having more days like this in the future.  You vow to work extra hard to make this a reality.");
					outputText("\n\nThe feast progresses without a hitch.  You cheer, eat and drink together (though you really don't have any appropriate alcohol for the evening).  As the feast progresses, you notice more than one pair of hungry eyes sizing you up... it seems your day is far from over...");
				}
				HPChange(player.maxHP(), false);
				player.hunger = 100;
				player.changeFatigue(-100);
				flags[kFLAGS.JACK_FROST_PROGRESS] = 0;
				doNext(camp.returnToCampUseEightHours);
			}
		}

		//[=Fuck Her=]
		//PC needs to have a cock.
		public function kihaXmasFuck():void {
			clearOutput();
			var x:int = player.cockThatFits(67);
			if (x < 0) x = player.smallestCockIndex();
			outputText("Stripping off your [armor], you tell the dragon-girl that a good workout is all she needs to get nice and warm.  She snorts in dismissal, but the way she's looking at you is a pretty good indication she's willing to try it.  \"<i>So, what do you have in mind?</i>\" she blusters.  You stroke your quickly erecting " + player.multiCockDescriptLight() + " and, smirking, ask her if your intentions aren't obvious?");
			outputText("\n\nShe stalks over, tail swaying sensually behind her, and takes you by the shoulders.  Then, with a mischievous grin, she pushes you into the snow.  \"<i>All right, but you're on the bottom - you can have the cold back this time!</i>\" she smirks, straddling your waist.");
			outputText("\n\nYou laugh and tell her you're fine with that, but she better hurry up, the cold is starting to catch up to you.   The mock-dragon blows a fine trickle of smoke from her nose, reaching down to stroke your shaft.  \"<i>Such a pervert, aren't you?  Here I am all freezing and wet, and all you can think about is fucking me, is that it?  You just want to shove this cock into my wet cunny and ride me until you burst, isn't that right?</i>\"  She growls lustfully, her fingers nimbly caressing and stroking your " + player.cockDescript(x) + " as she speaks.");
			outputText("\n\nWith a wry smile you ask her if she's got a problem with that.  You wouldn't be thinking about her wet pussy all the time if she ever bothered to throw some clothes on... so who's the real perv now?  You or her?");
			outputText("\n\n\"<i>You are, of course... so, I'll just have to punish you for being such a corrupted, demonic pervert...</i>\"  Kiha declares in a teasing voice.  She lifts herself up and positions herself over your cock, gently grinding her damp netherlips against the head but deliberately refusing to sink any further.  \"<i>How do you like that, cunt-hungry demon?  Do you want Kiha to take it all the way?  Do you?</i>\" she croons in a sweet voice.");
			outputText("\n\nImpatient, and starting to feel the cold snow creeping on your back, you ask her if she intends to get started with it, or if you'll have to go up there and get her yourself.  Your hands are already sliding along her thighs to grasp her hips.  \"<i>Oh, love, if you must</i>\" Kiha declares in mock protest, rolling her eyes before suddenly impaling herself to the hilt on your shaft, an action that makes her scream in shocked delight, fiercely clamping her netherlips down around your cock.  You hiss in pleasure as your " + player.cockDescript(x) + " is suddenly wrapped in the warm folds of the dragon-girl.");
			outputText("\n\nNot interested in delaying the act any longer, you grab a firm hold of her hips and begin pistoning in and out of her as well as you can in your current position.  Her moist honeypot feels absolutely wonderful on your shaft, and you can already feel yourself forgetting about the snow on your back.  Moaning, the mock-dragon starts to piston herself up and down, leaning on your chest for support as her hips rise and fall with increasing speed, wings half-flared and tail swishing in delight.");
			outputText("\n\nYou smile at the dragon-girl standing above you, careful to maintain your rhythm in fucking that wonderful pussy of hers.  Kiha smiles back at you, even as she continues to ride you for all she's worth.  You glide your hands over her sides to grasp her shoulders and pull her closer.  The mock-dragon eagerly allows you to pull her into your embrace, mashing her breasts against your [chest] and kissing you passionately.  You return the lip-lock with equal intensity, feeling the familiar pressure of a oncoming orgasm.");
			outputText("\n\n\"<i>I... oh, [name], I'm close!</i>\" Kiha gasps.  You try to reply and tell her so are you, but words fail you.  Instead you moan at her and thrust yourself as far into her as you can, painting her walls white with your seed as you spew rope upon rope towards her ready womb.  The dragoness manages to throw you a lustful smirk.  \"<i>Cumming already, lo-oh oh OH!</i>\"  She screams, arching her back and spewing flames out into the snowy sky above as she cums violently, flooding your crotch with all the lubricants and orgasm-fluids she can produce.");
			outputText("\n\nOnce her orgasm has subsided, the dragon-girl comes crashing down on top of you.  You laugh lightly and ask her what was she saying?  \"<i>...I guess that this snow stuff isn't so bad after all,</i>\" she admits, then sneaks a smooch to try and keep you from laughing at her.  You're happy to return the kiss and lay with her for a while longer, basking the heat of your each other, as well as your afterglow...");
			getGame().kihaFollower.kihaKnockUpAttempt();
			player.orgasm();
			doNext(processJackFrostEvent);
		}
		//[=Lick Boobs and Finger Pussy=]
		//All sexes!
		public function kihaXmasFingering():void {
			clearOutput();
			outputText("You examine Kiha.  A small snowflake lands on one of her nipples and she yelps with a start at the sudden contact.   \"<i>Hey, I asked you to help warm me up, not to stare at me!</i>\" she complains. ");
			outputText("\n\nYou tell her not to worry, you know just the way to warm her all up.  \"<i>Get on with it then,</i>\" she grumbles.  You grab hold of the impatient dragoness's boobs, massaging them gently, and lick the snowflake off her nipple.  Taking it in your mouth to suckle, you nip at her erect nub.  She gasps and moans in equal parts pleasure and shock.  \"<i>W-what?  Oh, that's nice, but, how's that going to help?</i>\"  You unlatch from her breast momentarily to wink at her and tell her to trust you - you know what you're doing.  \"<i>You perv,</i>\" Kiha says, but she's smiling as she does so.");
			outputText("\n\nYou pay no heed to her words, preferring instead to show her what you mean.  One of your hands slowly slides down her body, over her belly, and finally over her labia.  Slowly, you begin massaging her suddenly moist netherlips.  Wordlessly the mock-dragon lets you do so, moaning and hissing softly at the obvious pleasure your actions are bringing to her.  You switch breasts, turning your attention to her other nipple, and with your thumb, you press on her little pleasure buzzer.  With a hiss, Kiha reaches out and takes hold of your cheeks.  \"<i>Mmm, not what I had in mind, but I'll go with it,</i>\" she declares, gently stroking your face.");
			outputText("\n\nYou chuckle, sending vibrations through your mouthful of breast.  \"<i>Less laughing, please, [name] - I'm still cold!</i>\"  She demands through a shiver.  You decide to give in to her insistent demands and plunge your fingers as far as they'll go into her quivering quim.  This elicits a squeal of delighted shock from the fiesty dragon, whose whole body spasms from the surprised pleasure, her clenching slit doing its best to grip your fingers as if they were a cock.");
			outputText("\n\nYou begin pistoning your fingers in and out of the dragon-girl, asking her if she's feeling warmer now.  \"<i>Mmm, y-y-yes,</i>\" Kiha answers, even as her legs start to buckle, making her sway in a rather drunken fashion. \"<i>B-but it'll take more than - ooohhh... than that to warm me up,</i>\" she says, then moans.  She wants more, doesn't she?  Well, you're happy to oblige!  You add a couple more fingers to her love-hole, your other hand joining the first one in caring for her womanly needs by pinching and stroking her little, achingly engorged clit.  She shudders and squeals, her nether-lips squeezing you tightly as fem-cum drenches your hand, the orgasm ripping through her body and causing her to lose control of her legs, sending her crashing into you and knocking you both to the ground.");
			outputText("\n\nYou click your tongue, mocking her for giving in to a little pleasure.  Isn't she supposed to be all strong and mighty?  \"<i>I'll never be defeated,</i>\" right?  \"<i>Shush, love,</i>\" she pants unthinkingly.  You laugh at your scaly lover's reaction, patting her butt gently.  Then, you ask her if she's feeling warmer now?  If she isn't, you'll be happy to warm her up some more, even going so far as to send a questing hand to prod her moist opening.");
			outputText("\n\n\"<i>Well, I suppose you could get me a little hotter... if you can take the heat, my doofus,</i>\" she croons, snuggling tighter against you...");
			dynStats("lus", 20 + player.sens / 20 + player.lib / 20);
			doNext(processJackFrostEvent);
		}

		//[=Fuck Her=]
		//Needs PC with cock that fits.
		public function penetradePureMouseWaifu():void {
			clearOutput();
			var x:int = player.cockThatFits(50);
			if (x < 0) x = player.smallestCockIndex();
			outputText("Stripping down your [armor] and indicating Amily should do the same... you tell her that you were hoping for some good old-fashioned sex between a horny " + player.mf("man","herm") + " and " + player.mf("his","her") + " lovely mousette.  You playfully ask Amily if she has any objections?");
			outputText("\n\n\"<i>Well, it's a little counterproductive to take your clothes off if you want to get warm,</i>\" Amily notes.  Despite her words, she's stripping off without the slightest hesitation.  You reply that just the sight of her getting nude is already making you a little warmer... thrusting your hips so she can see your erect " + player.multiCockDescriptLight() + ".  \"<i>Flattering flirt; you always think with your dick, don't you?</i>\" the mouse laughs.  That's rich; you can see her pussy dripping from here");
			if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) outputText(", not to mention her dick's pretty hard, too");
			outputText(".");
			
			outputText("\n\nSitting down on your bedroll, you open your arms, inviting Amily over.  The mouse promptly approaches");
			if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) outputText(", her own " + getGame().amilyScene.amilyCock() + " jutting out in anticipation");
			outputText(", wriggling into your arms and angling her pussy over your " + player.cockDescript(x) + ".  With the ease of long practice, she slides smoothly down its length, her warm, wet depths greedily inhaling your masculinity.  \"<i>Ah, nothing like a nice hard cock in your cunt to make you feel warmer,</i>\" she coos.");
			
			outputText("\n\nYou simply grin and begin bucking your hips against her, suppressing your moans by kissing her, hugging her tightly against you, holding your bodies flush together.  The mouse hugs you as tightly as she can, smothering you with kisses as her hands roam nimbly across your back, slinking down to squeeze your ass with an obvious hunger to molest you.");
			
			outputText("\n\nYou guide your hands down her sides, towards her behind, taking it into your hands and helping her rise and fall on your shaft.  She breaks the kiss with a loud exclamation.  \"<i>Oh, this feels so good, [name]!  And it's certainly warming... why, I think I'm starting to break a sweat... and I think you are too,</i>\" she grins.");
			
			outputText("\n\nYou ask her to tell you how much she wants this... how much she wants your seed... how much she wants you?  \"<i>I want you!  I want you with everything I have, I want everything you have to give!</i>\" she cries out.  Then she can have all of you... with one last thrust, you bury your shaft deeply into her quivering cunny and blast your liquid lust straight into her waiting womb.  She moans loudly, making no effort to hide her delight at your treatment, and shudders violently in your grip as orgasm rocks her body, flooding your crotch with her rodent fem-cum");
			if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) outputText(" and painting your belly white with futa-spooge");
			outputText(".");
			
			outputText("\n\nYou tell Amily, \"<i>Happy Holidays,</i>\" hugging her in post-coital affection.  \"<i>Happy Holidays, [name]... whatever that is,</i>\" she giggles.  \"<i>But, you know, we might just have a little late Winterfest present brewing after that bit of fun.</i>\"  She bats her eyes at you flirtatiously, patting her cum-stuffed belly.");
			outputText("\n\nYou agree with her and enjoy your closeness a while longer...");
			player.orgasm();
			dynStats("lib", -1);
			doNext(processJackFrostEvent);
		}

		//[=Make out=]
		//For any gender.
		public function makeOutWithPureMouseWaifu():void {
			clearOutput();
			outputText("You strip down your [armor] and suggest Amily should do the same.  \"<i>Well, it's a little counterproductive to take your clothes off if you want to get warm,</i>\" Amily notes.  Despite her words, she's stripping off without the slightest hesitation.  \"<i>So, what's on your mind, lover-" + player.mf("boy","girl") + "?</i>\" she asks.");
			
			outputText("\n\nYou say that with all that's been going on lately, the two of you just haven't been able catch a break... so today, you'd like to just forget about everything and spend some quality time with her... not by having sex... though you don't mind doing it either, but... you'd just like to sit back and enjoy your pretty mousette, mother of your children, properly.  You ask if she's getting what you're saying?");
			
			outputText("\n\nShe smiles at you with joy.  \"<i>If all you want is to stay close to me, then I'd be more than willing to humor you - I had thought that all last remnants of romance had been squeezed out of this world.  I'm going to enjoy this,</i>\"  she promises to.  \"<i>Though... why do we need to be naked to sit and cuddle?</i>\" she asks, clearly baffled.");
			
			outputText("\n\nSilly mouse, you remark with a smirk.  That's the best way to share body heat... you're still a bit cold... and you're willing to bet so is she... you wink.  \"<i>Ah, so that's your game,</i>\" Amily chuckles.  \"<i>Well, I'm game if you are.</i>\"");
			
			outputText("\n\nYou open your arms in a clear invitation for the mousette to sit with you.  ");
			if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) outputText("Smiling sheepishly you  tell her to mind the erection... though you're not actually looking for sex, you can't help with how cute she looks...  \"<i>Flirt.</i>\"  Amily giggles, but otherwise doesn't comment on it.  ");
			outputText("The mouse promptly walks over and sits down just in front of you, her back facing you and giving you a perfect opportunity to hug her.  Not keen on missing such an opportunity, you do so.");
			
			if (player.hasCock()) outputText("\n\n\"<i>You know I can feel your dick poking me in the back, right?</i>\" Amily giggles, wriggling back against your jutting shaft for emphasis.  You chuckle and tell her to lay off your man-parts... this is just a natural reaction.  \"<i>Oh yeah?  Maybe you wanna see my natural reaction to this situation, hmm?</i>\" she croons.  Maybe later... right now you just want to enjoy her like this.");
			
			outputText("\n\nThe mouse sighs softly.  \"<i>You know how I feel about you, [name]?  I feel that Marae herself must have blessed me to have someone like you find me.  For all the ordeals I faced, having you in my life makes up for everything.  Having you here like this, arms wrapped around me, our hearts beating together... I want this moment to last forever,</i>\" she declares quietly.");
			
			outputText("\n\nYou put your nose against her neck, inhaling her scent, a faint grassy smell that is distinctively feminine.  \"<i>Mmm... that feels good.</i>\"  Amily drawls, and then she giggles, \"<i>Actually, it kinda tickles.</i>\"");

			outputText("\n\nYou tell her it feels perfect, and you'll fight hard to ensure you will all have more moments like this in the future...  \"<i>Well, I'll be rooting for you all the way... though, right now, I think I'd rather you just shut up and enjoy the moment,</i>\" she adds.");
			
			outputText("\n\nYou chuckle, even though she's the one that's been chatting your ears off this whole time?  \"<i>Yes, even though I'm the one that's been chatting your ears off,</i>\" Amily replies with a smile.  You suggest that perhaps all you need to do to stop talking is finding something to keep your mouths busy.  \"<i>Oh?  What are you suggesting?</i>\" she asks, her tail gently looping around your midriff.  Your reply is to simply draw her into a kiss...");
			dynStats("lus", 30 + player.sens / 10);
			doNext(processJackFrostEvent);
		}



		//[=Pen Ass=]
		//PC needs a cock.
		public function penetradeCorruptJojoAss():void {
			clearOutput();
			outputText("You roughly pull the mouse slut's tail out of the way, getting a clear look at his accommodating ass.  Your broken slut of a murine monk rises to the tips of his toes in anticipation, already moaning in delight at the thought of your ravaging his ass.  You laugh at him, telling him he has come very far ever since the first time you've violated his bum.   \"<i>Yes [master], thank you [master],</i>\" is all Jojo's corrupted brain can think to say.");
			outputText("\n\nFeeling like you're just wasting your time, you drop your lower garments and begin stroking yourself into an erection.  With a throaty groan, Jojo wiggles his ass, crudely trying to tempt you to start.  You roughly shove your [cock] as far as it'll go on the former monk's ass, sinking a few inches in without any resistance.  Moaning, pre already dribbling from his cock, the fallen mouse bucks eagerly back into you, trying to shove more of your cock up his ass.");
			outputText("\n\nYou slap his ass, commenting on what a slut he is, getting so worked up about having his ass violated... does he really enjoy it that much?  \"<i>Yes, oh, [master], yes I do!</i>\" he vows.  Good, as he should.  You grab hold of his hips and pull them towards you, while thrusting yourself to the hilt into your mouse-slut's once tight ass, giving him a complementary slap on the butt in the process.  Jojo squeals like a sow in heat, thrusting back eagerly to swallow your cock, too horny to care about the pain his actions might cause him.  Without further ado, you begin pistoning yourself in and out of his ass, with nary a hint of worry about the monk's own enjoyment, not that you should considering each time your hips meet with a loud slap his cock pumps out a stream of pre.");
			
			outputText("\n\nJojo voices a loud moaning cry of orgasmic lust, clearly not too far off from his climax.  You silence his lurid cries by thrusting his face into the snow with a particularly strong pump of your cock on his ass.  You tell him to be quiet and take it like the bitch he is.   Jojo moans and sobs in pleasure, wriggling and squirming under you, too caught up in his own lusts to heed you.");
			
			outputText("\n\nFeeling yourself getting close, you redouble your effort at pounding the former monk's ass raw, pistoning in and out with all your might, until with a final thrust, you spill your load deep into the mouse-slut's hungry ass.  With a mighty shriek of joy, the corrupted monk arches his back, his distended, corruption-bloated cock spewing cum");
			if (player.cumQ() >= 700) outputText(" all over his own cum-engorged gut and ");
			outputText("onto the snowy earth underneath him.  He cums and cums until he's exhausted even his prodigious balls, creating a salty quagmire of semi-melted snow and spooge under him that he promptly collapses face-first into.");
			outputText("\n\nLaughing at his reaction, you ask if he has learned how to properly fuck in the snow.  Jojo lifts his face, covered in half-frozen spunk-slush, and nods at you, too tired from his recent fucking to speak.");
			
			outputText("\n\nGood, now he should get his face cleaned up.  You order him to lick himself clean.  Without hesitation, Jojo starts doing exactly what you said, slurping up all of the cum-slush on his face and using his fingers to scrape the rest into his reach.  He then begins licking at his arms and chest, clearly not intending to stop until he has it all.   You nod in satisfaction, telling him to keep at it, you want to see him eat it all up...");
			player.orgasm();
			dynStats("lib", -3, "sen", -1, "cor", 1);
			doNext(processJackFrostEvent);
			flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
		}
		//[=Ride Cock=]
		//PC needs vagina
		public function rideCorruptJojoCock():void {
			clearOutput();
			outputText("With a flourish, you easily discard your [armor].  Then you grab a hold of the mouse-slut's tail and twist it to the side, forcing the former monk to crash into the ground on his back, shaft half-erect and covered in melting snow, pointing upwards like a perverted pole.  You ask him if he can see anything he would like from his current vantage point.");
			outputText("\n\n\"<i>Y-yes [master],</i>\" Jojo meekly declares, unable to take his eyes from your [cunt].  His cock immediately grows to full mast, which you can't help but think is one of his more convenient features since you remade him into this far more enjoyable version of himself.");
			outputText("\n\nYou take his shaft into your hand, stroking it languidly, milking the mouse-slut's thick pre and spreading it along his shaft as you do so.  You ask him what he would like you to do.  \"<i>F-fuck me, [master]!  Fuck me!</i>\"  He cries, moaning as he bucks his cock furiously into your clasping hands.");
			
			outputText("\n\nNow, now... you can't have your slut forgetting his place... so you grab his balls and begin forcefully grasping at it, but rather than pain, the former monk only displays delight at the act; his brain enjoying both the pain and pleasure of the act in equal measure.  \"<i>Fuh-forgive me, [master]!  I was wrong!</i>\" Jojo pleads.");
			
			outputText("\n\nThat's better.  You release him and stand over him, issuing a single order.  If he wants it, you want to hear him ask it, like a proper slut should.  Swallowing audibly, the mouse-slut does his best to calm himself down, but he never stops panting as he begs. \"<i>M - [Master], please... please show this unworthy slut how to fuck in the snow... please, let me cum,</i>\" he says meekly, cock throbbing in anticipation.");
			outputText("\n\nNow that's what you like to hear, and you promptly impale yourself on Jojo's handy shaft, brutally forcing it inch by inch inside you until you have forced him to the ground with your efforts.  Moaning with satisfaction at being stuffed, you begin to roughly rise and fall, pistoning back and forth in order to sate your pleasures.");
			
			outputText("\n\nJojo goes berserk, babbling incoherently as he grabs your hips and begins roughly slamming himself into your [vagina], trying to dig as deep into you as he can, even as his pre leaking shaft lubricates your tunnel.  You try to exert some control over the ex-monk, but eventually decide it's better to just sit back and enjoy the ride - however, you can't resist taunting Jojo over what a depraved little slut he has become, totally incapable of controlling himself. \"<i>S-Sluuut... I'm... sluuuut,</i>\" he utters incoherently between moans.");
			player.cuntChange(20,true,true,false);
			
			outputText("\n\nYou thrust, buck, and heave, enjoying everything there is about mastering this once-pure soul and reducing him to your fuck puppet.  Finally, with an ecstatic howl, you cum, female lubricants gushing onto his burning hot cock");
			if (player.hasCock()) outputText(", your own futa-cock spewing its load, which you deliberately spray in his face for amusement");
			outputText(".  Your orgasm triggers Jojo's own; though he has cum without permission, at least he waited for you to cum first like a good slut should.  Rope after rope of mousy sperm bats your cervix, trying to get past the barrier and into the waiting womb inside, even as Jojo tries his best to fuck you over and over as he spills his load, until he finally slumps into the ground, panting, with his mouth open and his tongue lolling out, eyes glazed over in a pleasured daze.");
			
			outputText("\n\nYou wait until you're sure you dripped the last few drops of femcum from your cunt, then, with a groan, noisily pull yourself off of the mouse's now-limp dick.  Moving so that you are hovering it over Jojo's face, you authoritatively command your slave to clean up all the mouse-spunk he stuffed into your cunt.  The panting mouse-slut breaks out of his trance with a start, and quickly raises to get started and do your bidding, even as drops of your mixed juice and his slutty baby-batter drip on his face.  He drinks the spunk with joy, moaning in enjoyment at the act.");
			
			outputText("\n\nYou just stand and watch as he works, waiting for him to finish cleaning you up so you can get started on your next task...");
			player.orgasm();
			dynStats("lib", -3, "sen", -1, "cor", 1);
			doNext(processJackFrostEvent);
			flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
			//Preggers chance!
			player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
		}

		//[=Spank and Finger Ass=]
		//Available to all.
		public function spankNFingerCorruptJojoAss():void {
			clearOutput();
			outputText("Not bothering to undress, you yank the mouse's ropy tail out of the way with brutal force, to gaze at his white, heart-shaped ass.  Jojo stands on the tips of his toes, moaning at the rough treatment that surely follows.  His ass looks so inviting... so deserving of a good hard smack... you ask the former monk-turned-slut how he would like a good beating on his ass.");
			outputText("\n\n\"<i>M-[master], please, spank me!  I'm such a naughty boy - spank me hard!</i>\" Jojo cries.  You laugh at your wanton slut.  You've never seen a mouse as perverted as this, begging to be spanked and getting off on the idea... well, the slut certainly deserves it... you're pretty sure he has been masturbating without your permission, and you can't have that.");
			outputText("\n\nJojo just wiggles his bare ass, doing his best to make it look as tempting as possible for you.");
			
			outputText("\n\nYou administer an echoing slap on his bubbly butt, causing the cheeks to jiggle as a hand-shaped print appears on his behind.  Jojo moans throatily, spurting a gobbet of pre from his bobbing cock, wiggling his ass in appreciation of the spank.");
			
			outputText("\n\nYou can't resist laughing, pointing out what a parody of a monk he has become.  So perverted, begging for sex, cock and cum.  Why... if his order saw him now, they would surely punish him for this disgrace... and since they're not around anymore... perhaps you should be the one to administer the punishment instead?  \"<i>Oh, yes, [master], please!</i>\" the mouse begs, clearly loving the way you're talking to him in his defiled state.");
			
			outputText("\n\nYou release his tail, letting him drop to his knees, and begin fondling his balls, asking him if he will spill his load for you if you spank him?  If he will further forget about his foolish morals and embrace his inner slut like a good little slave?  \"<i>Yes! Yes!  Oh, yes, [master], I will!</i>\" he cries out in rapture, his tail coiling around your wrist like a whip and tugging it insistently towards his ass.");
			outputText("\n\nSeeing no reason to deny, nor tease the mouse-slut any longer, you begin administering his punishment, each resounding slap rocking the mouse, who is only too happy to moan at the pain.  Slap after slap you chastise him for ever believing he was anything more than your willing slut, and he loves every minute of it.  His once noble goals are now just a faint memory... his only purpose now is to be a fucktoy for you and whomever you appoint, good for nothing more than sex.  The only coherent thoughts that run through the defiled monk's head are fuck, cum and pain; he is so far gone in his corruption, in his new purpose in life that he begs you to spank him more, even as his ass begins glowing with the severe spanks you administer him.");
			outputText("\n\nThe mouse moans and groans lustily with every spank, his cock growing stiffer and harder, pre bubbling out of its tip until it is constantly oozing steadily from his cock.  He's lost in pleasure, existing only to be pushed over the edge into a true orgasm.  Realizing that the slut is bordering the edge of orgasm, you decide to put a finishing touch to his treatment... you shove your fingers into his easily yielding ass, pushing the digits up to the knuckle and pressing on his prostate with a single order: Cum.");
			
			outputText("\n\nWith a gasp and a howl, Jojo does as you command, a fountain of tainted mouse-spooge gushing from his cock, soaking into the snow to create a great slushy puddle.  He cums and he cums until he's totally exhausted his strength, collapsing bonelessly into the puddle he's just created, his tail slipping off of your wrist as he does so.");
			
			outputText("\n\nYou laugh at the mouse-slut's blissed out face of pleasure, feeling like you managed to chip away another part of his broken will.  Before you leave him to pass out on his snowy puddle of mouse-cum you ask him, what is his name?  \"<i>S - Slut...</i>\"  Is the moaning reply.  Satisfied, you decide to leave for the moment.  Maybe you'll get back to him and break him in a little more later...");
			dynStats("lus=", player.maxLust(), "resisted", true);
			flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
			doNext(processJackFrostEvent);
		}

		//[=Skip Jojo=]
		//Available to all.
		public function skipCorruptJojo():void {
			clearOutput();
			outputText("You shake your head and leave Jojo back to fucking the snow mound..");
			flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
			doNext(processJackFrostEvent);
		}
	}
}