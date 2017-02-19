package classes.Scenes.Seasonal {

	import classes.*;
	import classes.GlobalFlags.*;

	//const VALENTINES_EVENT_YEAR:int = 736;
	
	public class Valentines extends BaseContent 
	{
		public function Valentines() {}
		
		public function isItValentine():Boolean {
			return ((date.date >= 13 && date.date <= 15 && date.month == 1) || flags[kFLAGS.ITS_EVERY_DAY] > 0);
		}

		/*First of all, a few notes:
		- The scene should probably trigger automatically for people who have met Scylla enough times or been on her addiction meeting at least once, depending on which flags would make it easier for you, and should proc sometime from sometime before the normal hours for the addiction meeting to sometime after; let's say 16-20, upon entering the Wet Bitch or Tel'Adre at all, depending on what you think is better here. Probably the Wet Bitch.
		- Because the scene is Scylla-based, while it should require that you've only met Scylla and not necessarily meet her requirements anymoar, it'd still only be available for players who once had a 12+ inches cock. So, I guess the perks related to the event would best be somewhat weak, or you could do away with them at all, though in that case stat modifications should be present or even enhanced.
		- In short, the event has 7 possible outcomes, 3 possible gain-able perks, and might require an item and gender or just a cock present for some of the outcomes. 
		- The event should probably be available for a few days around the Valentines as usual, and sorry for the delay on it.
		- Most of the scenes are, unfortunately, not centaur-proof at all.
		- To go with Pastie, I've set it up so the player must have female parts or one of the game's more regular \"<i>alcohols</i>\". I guess she's the most messed up of the trio.

		Possible Perks to Gain:
		- One Track Mind : Player gains additional cum production or multiplier and their capacities increase.
		- Sensual Lover : Increases the effectiveness of teasing and gives a small Lust Resistance boost.
		- Pure and Loving : increases corruption resistance and lust resistance more than Sensual Lover, and/or maybe improves affection gains for NPCs if possible.

		Perk Descriptions:

		[One Track Mind] You're a dirty person. The highest you'd think of another is that they make you horny, and maybe \"<i>I'd tap that like there's no tomorrow.</i>\" There are no higher feelings for you in intimacy or sexual relations; you dabble in these purely to get off and not really caring about your partners. Even on a special days where love is celebrated, you can't muster affection other than in the form of an orgasm.
		As a super-sexual being, your cum production and capacities are slightly increased.

		[Sensual Lover] Intimacy is about making yourself and the other person feel good. You know that, and you resist neither falling in love nor having a one-night stand if someone is to your tastes. On a day that celebrates love, you're certainly wanted by many, but whose do you intend to be? Just tantalize others with how alluring and pleasant you are, or maybe more?
		Your sensuality makes it easy to arouse others and allows you to resist a bit of temptation yourself.
		Your Lust Resistance slightly increases, and you're better at teasing.

		[Pure and Loving] This day was about celebrating love, and although to each person love can mean something a bit different and some people need to open their eyes to the fact it exists, you've proven numerous times that being a romantic is not hopeless, and you certainly feel the spirit of the new Mareth holiday. Your strong heart is less likely to be purged of feelings, and people will love you more, too.

		THE EVENT ITSELF!*/



		public function crazyVDayShenanigansByVenithil():void {
			clearOutput();
			flags[kFLAGS.VALENTINES_EVENT_YEAR] = date.fullYear;
			outputText("Moving through the streets of Tel'Adre, you turn your steps towards the Wet Bitch, only to find that there's some odd event going on nearby.  Deciding the town is a safe enough place to let yourself be led astray by curiosity, you decide to investigate a bit closer.");
			
			outputText("\n\nNext to the tavern, there's a stall that's filled with flowers and many heart-shaped things; there's cards, chocolates, boxes of sweets, clothes with hearts sewn into them, mascots with the same, and even a sculpture of a heart and two lockets.  You'd say this was a shopping booth of sorts, but then, you're surprised by the sight of a goblin nearby, looking at you and waving.");
			
			outputText("\n\nYou come closer.  At first, you'd only recognize Abylon because she's more or less the only goblin one can really see in Tel'Adre, but only by coming closer are you sure it's really her.  She seems oddly annoyed by her situation, and you sure can see why.  She's not clad in her usual leather plates; in its place, she has a nice, pink and red dress, with white gloves, frills, and a small belt around her waist, complete with a heart-shaped beltbuckle, accentuating her petite curves.  She appears to flush a bit as she notices you eyeing her up.  \"<i>W...what?  The fat cow told us to do this and Can't-Hold-Her-Drink was all for it, can you imagine?  I just... just tagged along.  In any case, as you can see, it's a disaster.  So much red and pink and whatnot.  I was surprised anybody was even interested.</i>\"");
			
			outputText("\n\nRaising an eyebrow, you can easily understand why Abylon would be displeased with this kind of atmosphere, but at the same time you can't resist asking what, as a matter of fact, is going on here.");
			
			outputText("\n\nAbby just points to the stall, explaining.  \"<i>Suck-a-lot claimed that there'd be some sort of a celebration regarding lovey-dovey stuff where she's from sometime around today.  She decided to make it known and popular here in Tel'Adre and try to get'em to celebrate said holiday as well.  Hence this little farce.  Me and Pastie are helping her, and surprisingly some people were even interested.</i>\"");
			
			
			outputText("\n\nYou nod to Abby and decide to come closer to the stall.  Pastie, surprisingly sober for once, and only slightly displeased by that fact, it seems, is dancing over the table, also dressed in frilly clothes, apparently meant to act as some sort of cupid, only with fairy wings instead of feathery ones.  You hear the voice of someone pleasantly surprised before you look up to see Scylla smiling at you.  Unlike Abby and Pastie, she kept most of her habit intact, but today, she has forgone her coif and veil, leaving her hair completely exposed, though made up in a way to cover her little horns along with the small embroidery she decided to add.  She has a pink flower in her hair, and also in the space in-between her voluminous chest-mounds, giving you an excuse to glance at it for a moment, and flower-like frills added to the sleeves of her over-filled habit.");
			outputText("\n\n\"<i>[name]!  I had hoped to see you here today! It's certainly a very nice occasion, you know.  You see, where I come from, it's a holiday to celebrate love in all its forms- both for couples and the freshly love-struck.  I'm hoping, with a little help from our humble demonstration, the people of Mareth will adopt it, in time...</i>\" she says, her voice still buoyant with optimism, but a hint of worry in her voice.  It's probably not going exactly as well as she had hoped.  \"<i>Well, in your case, I'm sure you'd have a reason to celebrate it.  Certainly, a brave, valiant " + player.mf("man","woman") + " like you would have quite a few people interested in them, and maybe someone you'd see as a special person as well!</i>\"  You guess you can see her logic.  After all, it's because you've beaten the Omnibus that she's here in the first place.  You can't say that the random people in Tel'Adre treat you unpleasantly, so maybe you're more popular here than you would've guessed.");
			
			//Corruption 0-33 :
			if (player.cor <= 33) outputText("\n\nIt is a rather pleasant thought, that not only a few someones, but a wider public in general appreciates what you've done.");
			//Corruption 34-66 :
			else if (player.cor < 66) outputText("\n\nYou certainly deserve the recognition, and maybe some of the benefits that could've come with it as well.");
			//Corruption 67-100 :
			else outputText("\n\nNow that's a thought.  Perhaps there'd be more people in this town willing to help you slake your lusts more often than you thought this place would allow.  A bunch of lovestruck hero-worshippers dedicated to your pleasure sounds great.");
			
			outputText("\n\nLifting a finger to her plump lips, Scylla seems to be considering something.  \"<i>Perhaps you would like to participate in one of our events?  Some of these things are for sale, but mostly I tried to organize these things so that anyone interested can get something, and with the games anyone can get absolutely anything as long as they try a little.  Although... it seems like we've managed to prepare too much, as it turns out now...</i>\" Scylla says with a saddened expression, Pastie flying over to perch onto her shoulder and looking at you helpfully before whispering something to the nun.  \"<i>Ah, yes!  Maybe if you helped, if you'd be so kind.  You see, it's hard to bring the attention of many people when there's only three of us, even if I tried to pick up a popular location, so maybe you could go with Abby and spread the word to all the love-birds that there's a celebration!  What do you say, [name]?  Could you help us?</i>\"");
			
			//I've considered making it so that the truly corrupt characters can't really participate, but that might be seen as unfair. You could either apply these or give the \"<i>moderate</i>\" corruption text and choice to everyone.
			//Corruption 86-100 : You consider for a moment, but the answer is as clear as day and night. With a look of contempt and maybe a hint of pity, you tell Scylla that things like love are illusions the weak rely on, useless to you, and intimacy is simply a more polite word for fucking and taking your pleasure from whom you'd want to get it. You don't care much for her stupid excuse for celebration.
			//With that, you turn around and go back into the streets of Tel'Adre
			//[end event]
			//Corruption 16-85 : 
			outputText("\n\nWell, you do have more important things to do, and in the world of Mareth, where the corruption is dominant and there's definitely way more sex than romance, such a mission may be doomed to fail anyways, but it is something to consider.  All in all, it comes down to whether you think you have the time for this and whether it even seems worth it.");
			awardAchievement("Valentine", kACHIEVEMENTS.HOLIDAY_VALENTINE);
			//[Help them][Leave]
			menu();
			addButton(0,"Help Them",helpValentinesDay);
			addButton(1,"Leave",leaveValentinesDayForever);	
		}

		//[Help them] :
		public function helpValentinesDay():void {
			clearOutput();
			outputText("Deciding to try and improve the overall appreciation of romance and love in possibly the last pure city of Mareth, you smile to Scylla and tell her she can count on you.  Her happy expression makes you forget any doubts you might've had before.");
			menu();
			addButton(0,"Next",helpValentinesDayII);
		}

		//[Leave] :
		public function leaveValentinesDayForever():void {
			clearOutput();
			outputText("Ultimately, this is not worth your time.  You wish Scylla good luck, but tell her you won't help her make the holiday more popular in Tel'Adre, as you have other things to do.  Her expression turns sad and she nods in understanding as you turn away and go back into the streets of Tel'Adre.");
			doNext(camp.returnToCampUseOneHour);
		}

		//[next]
		public function helpValentinesDayII():void {
			clearOutput();
			outputText("Deciding to help Scylla out, you take Abylon and head out.  Travelling around the city, splitting up occasionally to cover more ground, the two of you spread the word.  Even the little goblin, who is still wearing her displeasure with more enthusiasm than her lace, seems content with your companionship in this little quest.   You put a few posters around the city, but mostly tell people directly about the event, convincing them to come and participate.  You bustle about, dropping the good message into the gym first, and then, visiting the shopkeepers.");
			
			outputText("\n\nAs you approach the pawn shop, you're nearly certain someone is observing you.  You turn about to catch the peeping tom, but find no one.  From the corner of your eye, you spot a cat's long, black tail flashing from a nearby alley but just like that, it's gone.  Perhaps you just imagined it.");
			
			outputText("\n\nYou find Oswald in front of his shop this time around, and tell him of Scylla organizing the celebration in the name of romance and love.  He seems a bit confused.  \"<i>Well, this seems pointless... it's not even going to bring her any profit.  Anyway, I may go and see if I have the time.</i>\"");
			
			outputText("\n\nVictoria seems far less resistant to the idea.  \"<i>Scylla?  Clad all the way in a black habit, but with so many curves she might as well be hiding other people under it?  Plump ruby lips, tall as all the remaining mice-people in the world combined?  Yeah, I remember her.</i>\"");
			
			outputText("\n\nYou explain to her the idea behind the celebration.  \"<i>Oh, so that's the reason she came here asking for materials and even buying some clothes straight away... she only told me I'd see in a couple of days.  Well, sure, that sounds like it might be quite profitable if something like that ever became a commonly celebrated holiday in Tel'Adre... but I guess it's against the spirit of it to think that way.  First and foremost, it warms the heart to think someone even thinks that way these days.  I'll come and tell my friends.</i>\"");
			
			outputText("\n\nYvonne faintly blushes at hearing about the celebration.  \"<i>W-well, I don't know,</i>\" she says, fanning herself more quickly.  \"<i>There's business and everything, and I'm not sure if... well, that's just not profitable, I think...</i>\"  You nod and prepare to leave, as you hear her mumble.  \"<i>I'll probably have the time, though...</i>\"");
			
			outputText("\n\nYara is way more openly enthusiastic about the idea.  \"<i>Hey, that sounds kinda familiar.  In any case, it's a good idea, I think.  People here mostly just care about the fucking, it'd seem.  Anyone knows even the fucking is a bit better with some feelings thrown into it.  Well... anyone NORMAL should know that.  Sure, I'll come and tell any of today's clients.</i>\"");
			
			outputText("\n\nAfter visiting the bakery and the weapon shop, that makes for all the people you can think of other than those in the Wet Bitch, who would know anyway. After another run around the Tel'Adre with Abby, who oddly seems to be holding back on showing her slightly improved mood, you return to the front of Scylla's stall. There are certainly way more people around the place now.");
			
			outputText("\n\nThrough the small crowd, you even see an oddly familiar flash of black and gray vulpine fur.");
			//([Fuckbuddy or Heartbroken Urta])
			//if (!urtaLove()) outputText("\n\nThe bearer of it seems to just come here to look uncomfortably but, perhaps, longingly at the stall for a few moments, before practically leaping back into the Wet Bitch.");
			//else outputText("\n\nYou see a flash of said fur as the person with said characteristic moves away from the stall, clearly carrying a confection or two and some other pink, red, or heart-shaped things into the Wet Bitch.");
			
			//[next]
			menu();
			addButton(0,"Next",helpValentinesDayIII);
		}

		public function helpValentinesDayIII():void {
			clearOutput();
			outputText("You spend the rest of the evening participating in holiday games and showing people around the stall, listening to Scylla giving a talk or two about love and the celebration of it.  All in all, the little popularization of the holiday turned out to be a moderate success, but a success after all thanks to the joint effort of the four of you.");
			
			outputText("\n\nThat being said, the sun is slowly setting and the people begin to leave for their homes.  You reckon you may be a bit tired soon, and have to return to camp at some point, but at the same time, you could allow yourself to wander around with one of the girls instead.");
			
			outputText("\n\nHow do you want to spend the rest of your evening?");
			//[GoHome][Scylla][Abby][Pastie]
			menu();
			addButton(0,"Scylla",goVisitScyllaVday);
			addButton(1,"Abby",goVisitAbbyVday);
			if (player.cockThatFits(28) >= 0 || player.hasVagina()) addButton(2,"Pastie",goVisitPastyVDay);
			addButton(4,"Leave",goHomeFromVDay);
		}

		//([Go home])
		public function goHomeFromVDay():void {
			clearOutput();
			outputText("You decide your work here is done, and bid the three girls goodbye.  Scylla in particular seems grateful for your help, locking you in a smooshy hug for a few seconds before letting you go, and again expressing her gratitude for your help.  Well, that last gratitude almost made it worth it, though on the other hand, you find yourself a bit aroused by it...");
			//With no other things to do, you go back to camp to rest.
			//{Small Lust Increase, return to camp, go to sleep}
			dynStats("lus", 10);
			doNext(camp.returnToCampUseTwoHours);
		}

		//([Scylla])
		public function goVisitScyllaVday():void {
			clearOutput();
			outputText("You say your goodbyes to Abby and Pastie, before asking Scylla if she'd mind you accompanying her when she packs the remaining few things and maybe afterwards.  The nun blushes, playing with a lock of her hair as she answers.  \"<i>My dear [name], you are of course aware that the reason for me even trying to make this celebration more popular is so that people would spend it with ones they love.  As much as I'd appreciate your company, are you sure you'd want to be spending this day with a nun that is already so indebted to you?</i>\"");
			
			outputText("\n\nYou tell her you're more than willing to spend more time with her, and help her pack the things that did not get given away, won or sold in the celebration.  After that, she covers the stall and smiles at you. \"<i>I'll be taking these things home tomorrow. How about we just go for a walk now?</i>\"");
			menu();
			addButton(0,"Next",goVisitScyllaVdayII);
		}

		//SCYLLA EVENT
		public function goVisitScyllaVdayII():void {
			clearOutput();
			outputText("Scylla takes you for a longer walk throught the now barely illuminated streets of Tel'Adre, clearly a bit giddy and in a good mood after today's events.  \"<i>Thank you, [name].  Once again, I think I am in your debt.  These are certainly hard times for this world, and many people certainly try to cope by indulging themselves while throwing away the emotional and spiritual sides of things... it's understandable, but it's wrong.  People shouldn't forget how much comfort and happiness one can find in another person, especially through strong emotions and attachments like romantic or familial love,</i>\" she says as you walk through the sunset-illuminated alleys, smiling at you gently, a small rosy blush at her cheeks.  \"<i>The way myself, and I'm sure a few lucky others, find in those like you,</i>\" she says in a whisper that's still easily heard in the near-empty streets of Tel'Adre.");
			
			outputText("\n\nYou simply listen to her but also blush at the last line, thanking her for her appreciation of your person. She gives a small laugh at that.  \"<i>Well, certainly, we've had our troubles with my... new way of eating, and I'm sure you didn't always feel like I really appreciated you or treated you with dignity... I'm sorry about that, but I really feel like I depended on you a lot and I know you're a great person,</i>\" she continues, her smile widening and blush slightly deepening with every sentence.  \"<i>You're more special than the others who've helped me, having always recognized my problems and solutions to them first.  You've saved me from a certain fall to the demon's corruption...  And you taste really good, too,</i>\" she says, licking her ruby lips before absent-mindedly noticing what she just said, flushing a deep red.  \"<i>Well, in any case, thanks to your help, this wasn't as much of a strain as I thought.  I feel like I might've really done some things to make this world a slightly better place, and I've certainly seen you do so.  That warms my heart and makes the time spent here worth it,</i>\" she explains, resting a hand on your shoulder before showing you a turn.  \"<i>We could climb that tower there and watch the sunset,</i>\" she says, before explaining, \"<i>I'm certain we're both known enough around the place that the guards won't protest much, after all, it's just watching a sunset.  What do you think, dear?</i>\"  Her soft body bounces a bit under the habit as she stops, her flush receding to the pleasant, rosy color from before, but remaining clearly visible on her alabaster skin.");
			//[next]
			menu();
			addButton(0,"Next",goVisitScyllaVdayIII);
		}

		public function goVisitScyllaVdayIII():void {
			clearOutput();
			outputText("Indeed, once the guards recognize Scylla and one of them whispers something about you to the other, getting through the tower to the walls of the town isn't much of a challenge at all.  You two climb the stairs of the tower, Scylla's large breasts bouncing tantalizingly in her habit as she holds your hand moving up and up.");
			
			outputText("\n\nFinally, you come out another door, and you're somewhat blinded by suddenly facing the setting sun.  Scylla doesn't seem to mind, however, as she takes a few steps forward, sits down on the stony wall of the city and pats the spot next to her, motioning for you to join her.");
			outputText("\n\nWhen you do, she hooks an arm around yours, obviously pressing your hand and forearm against her overwhelming breasts, the soft, slightly liquid-like, smooshy feeling quickly encompassing almost all of your hand.  You certainly don't complain as you bring your body closer to Scylla's warm one.  \"<i>It's a very nice sunset, certainly.  Views like this one make the effort worth it, I think, even if the place would be better with a lot more green...</i>\"  She sighs.  \"<i>In any case, you're probably working hard to make Mareth a better place, and you're on the right track, I'm sure.  Spending time with you and seeing you develop also makes a day a good one, you know.</i>\"");
			outputText("\n\nYou ponder on how you should respond... it seems Scylla got a bit touchy-feely with you on this holiday, and while it certainly feels nice, the very presence of her over-eroticized body is a temptation in and of itself to take advantage of this closeness...");
			
			//What will you do?
			menu();
			//[Cuddle] [Make out] [Feed her]
			addButton(0,"Cuddle",cuddleWithScyllaVDay);
			addButton(1,"Make Out",makeOutWithScyllaVDay);
			addButton(2,"Feed Her",feedScyllaVDay);
		}

		//Cuddle]
		//{This option doesn't require any sexual endowments whatsoever}
		public function cuddleWithScyllaVDay():void {
			clearOutput();
			outputText("Realizing this can be quite a special moment, you gently slide a hand through Scylla's hair, guiding her by the head and towards your own [face].  Slowly, you place a kiss on her soft, ruby lips, allowing your tongue to slip inside and touch hers, which thrashes in her mouth for a moment before wrapping around yours, with Scylla first somewhat whimpering, then almost purring at the contact as the two of you kiss one another.  Her hand also meets the back of your head, pulling you more strongly into the kiss, her lips gently puffing up and encompassing yours with their warmth as your tongues coil around one another, a trickle of mixed saliva escaping your mouths and marking Scylla's habit with wetness.  Rather than break the kiss, Scylla gently decreases the pressure and, very slowly, starts to pull away, her lips first still keeping in light, tantalizing touch with your own before parting.  You start inhaling deeper, the flower in Scylla's hair still giving her a gentle fragrance, her own feminine scent nicely blending with it.  You thank Scylla for the kiss, which causes her to blush, and she answers right back.  \"<i>Thank you too, my dear angel.  For everything.  Saving me, and showing me both the good, pleasant things and the things I needed for survival... a kiss is the least I can give you, I guess.</i>\"");
			
			outputText("\n\nWith a smile, you cuddle up more against Scylla, sharing the bodily warmth between the two of you and snaking an arm around her waist.  \"<i>My, my.  I'm surely being treated appropriately for the occasion.  It's a bit embarassing...</i>\" she whispers, but leans her head towards you and you feel both her warmth and her gentle fragrance.");
			
			outputText("\n\nThe two of you spend some time cuddled up like that, watching the sun set.  Scylla's soft curves, especially her breasts, are overwhelming; you don't even have the willpower to resist copping a few feels, and initially, it's hard to stay still, aroused as you are.");
			//[if (hasVagina = true)]
			if (player.hasVagina()) outputText("  Your [vagina] is starting to get moist, making a small mess in your underclothes.");
			//[if (hasCock = true)]
			if (player.hasCock()) outputText("  You realize it'd probably be a done deal if you didn't resist the pull of your hardening cock towards one of Scylla's orifices, but you decide to spare her any temptations and endure yourself.");
			outputText("  In time, your ignited lust slowly changes to constant arousal, and Scylla just sitting there, watching the sun with a beautiful smile on her face, clearly content to just have someone in her arms on this evening is helping you control yourself a lot better.");
			outputText("\n\nHer eyes sparkle a bit as the sun's last rays of light loom over the horizon, and by that time your wants have changed into a pleasant, calm passion and relaxation in the soft arms of the nun, her breast smooshed against your hand and even your own [fullChest], the warmth almost making you think you could simply fall asleep right there.  However, a couple of minutes after the sun has completely crossed the horizon, Scylla rouses you and moves up to her feet herself, helping you get up before planting a hand on the cheek of your [face] and sharing one last, tender kiss with you.  \"<i>Thank you for helping out and spending time with me today, [name].  I will not forget this, and I do appreciate everything you've done to make this day special.  I hope every day turns out great and full of love for you.</i>\" She says, putting a hand on your shoulder and leading you down the stairs.");
			
			
			outputText("\n\nLater, when you move through the desert around Tel'Adre towards your own camp, looking back at Scylla waving towards you, you're somehow glad things turned out that way, and feel more determined than ever to not only defeat the demons, but also spread the good will and positive feelings through any world you may call your own.");
			
			outputText("\n\n(<b>You have gained the Pure and Loving perk!</b>");
			player.createPerk(PerkLib.PureAndLoving,0,0,0,0);
			doNext(camp.returnToCampUseTwoHours);
		}

		//[Make out]
		public function makeOutWithScyllaVDay():void {
			clearOutput();
			//{This option requires a member of essentially any size}
			outputText("Before long, the silkiness, warmth, and absolutely astounding curves of Scylla's body, not to mention the sight of her beautiful, full ruby lips, reflecting the light of the setting sun a bit, become a bit too much for you to resist.  You raise a bit, placing one of your hands against Scylla's way-beyond-prominent breast, feeling her start a bit as she turns to you, before you push your own lips against hers.  You hear a small gasp escape her, though you could never guess which pair of lips let it out.  You slip a tongue inside her mouth and she quickly yields, half-sighing as she gently slumps against you, your hand sinking further into her flesh as you can swear the lipple on the breast you're fondling starts sucking on her habit, seeking your fingers.");
			
			outputText("\n\nYou're not content to part with her yet, though, and your tongues start dancing alongside one another.  Scylla wraps her hands around you and pulls you into a close, intimate embrace, your body being encompassed by her enormous cleavage.  Your hand is now more forcefully pressed against her chest along with your forearm, and you feel a stirring in your groin at the sensation.  Certainly, Scylla's shyness has evaporated somewhere as she sucks on your tongue forcefully with her own wrapped around it, all the while forcefully pressing you close to her magnificent body.");
			
			//[pg]
			outputText("\n\nAfter a longer while, Scylla's tongue unwraps from yours and, with a moist slurp, she swallows your mixed drool as your lips break their touch.  You both pant heavily, and ");
			//[if (cocks = 1)
			if (player.cockTotal() == 1) outputText("your [cock] is completely hard and stiff, forming a bulge in your clothing");
			else if (player.cockTotal() > 1) outputText("[eachCock] is by now completely hard, eager to be touched and wanting to be caressed by the nun you're kissing");
			outputText(".");
			
			outputText("\n\nScylla, of course, notices and presses her hand against your bulge.  \"<i>It seems... we've gone a little too far in... celebrating...</i>\" she says, blushing heavily, but leaning in to kiss at your neck, sucking so strongly by sheer instinct that she'll probably leave a hickey. The fragrant flower in her hair bobs next to you before she moves towards your cheek, and back to your lips, need driving her deeper.  Eager to comply, you open your lips, while the two of you tug at the stretchy velvet of her habit.  The modest drape is pulled down and away from her over-stimulated, hungry tit-lips.");
			outputText("\n\nSuccessfully bearing her prodigious chest, you're rewarded with the pale luminescence of Scylla's smooth, alabaster skin; her huge, yielding breasts; and her glistening, ruby nipples that curl at the ends into coy smiles.");
			
			outputText("\n\nThe two of you break your kiss and you both realize she probably could use a smooch or two on her other lips.  \"<i>Please, help yourself... go right... ahead...</i>\" Scylla says, gently tugging you towards her breasts as she does so, and you comply eagerly, rubbing your cheeks against her sating breast and eager, suckling lips.  At first, you just smooch the ruby, drop-shaped nipple, but as it insistently tries to deepen the kiss and reengage into it, you comply, letting your tongue run along the lip before plunging in for a wet, milky kiss as Scylla releases a small yelp changing into a moan of increasing passion, her fingers wrapping around the back of your head and pressing you closer to her enormous breast, slowly putting more pressure onto you, forcing you to make out with her eager lipple.  The tasty, creamy milk starts to generously flow into your mouth after a while, and you drink it contentedly, your other hand traveling to Scylla's other breast, lifting it up and appreciating its weight, softness, and luxurious satin feel.  You brush your fingertips against her tit, causing her to shudder and sending her breasts into jiggles, increasing the flow into your mouth as Scylla continues to release mewls and moans of pleasure, some of them quiet, some more energetic. \"<i>Yesss, [name]... now, please, the other one, too!</i>\"");
			
			//[pg]
			outputText("\n\nNot being one to refuse a lady, you break the kiss with her right lipple even though it sucks aggressively on your tongue, almost as if trying to force it to stay, and instead plunge a finger into her right boob-lip, letting it suck on it happily and sloppily as you make out with Scylla's other boob.  The nun shivers and shudders, trying to control her pleasure, but only partially succeeding. \"<i>..Oh... oh gods...</i>\" she lets slip, pulling you more closely into her body.");
			
			outputText("\n\nYou're eager to try to steal the first orgasm from the chaste nun without giving in to your own lust too quickly, but the way she's starting to squirm against your painful hardness makes it difficult for you to remain noble.  The sheer volume of the absurdly-endowed woman's cleavage starts to overwhelm you, leaving you gasping short and hot breaths.  As usual - for the tainted nun, anyway - your suckling and nursing has stimulated Scylla's body, her curves swelling to overcompensate for her burgeoning hunger.  Your presence, to say nothing of your own arousal, has left her a bit too eager to get you off as well...");	
			//[next]
			menu();
			addButton(0,"Next",makeOutWithScyllaVDayII);
		}


		public function makeOutWithScyllaVDayII():void {
			clearOutput();
			outputText("Bending at her waist, Scylla kisses you on the forehead as she pulls your body upwards, into the squishy, half-liquid embrace of her mountainous cleavage, and you're at home, encompassed by the warmth and softness.  Her hands fiddle around your waist, disposing of the lower parts of your [armor] quickly as she handles your erection with care, but enthusiasm, stroking you as you drip your precum onto her palms.  It's impossible for either of you to resist anymore and you push forward through the near-literal valley of her cleavage, snuggling up to Scylla and kissing her on the lips.  Her hand, continuously stroking, directs your [cockHead] against the satin skin of her heaving boob, and you shudder at the sensation, being dragged across it, soon, you realize, about to end up wrapped in her breast again, sucked at until you cum.");
			
			outputText("\n\nYou eagerly make out with her, trying to give as you're about to get, while kneading her breast flesh with your own hands, and soon, you arrive at your destination, the crown of your member pressed against her steamy, drooling breast-lips, moistened by her milk as it slurps audibly, first teasingly, but then, drawing you inside.  Your hips buck slightly and you're pushed inside her more quickly than she was prepared for.  Scylla's entire body shudders, you realize, in orgasm, going a bit slack in your arms.  However, her titflesh never stops to contract around you, the milk-laden folds lapping at your member, pulling you deeper inside and seeking to milk you dry.  You're way too turned on and Scylla suddenly recovering to moan into your mouth and press herself closer against you is the last straw when you give in to her breasts' hunger.");
			
			outputText("\n\nYou fire off inside Scylla's tit, and the remaining lip draws in air eagerly as the two of them suck, one at the air, the other at your [cock]. You shudder in Scylla's embrace as you unload your offering into her.");
			//[if (cumMedium = true)
			if (player.cumQ() < 500) outputText("  It's easy to lose yourself into the feeling of Scylla's breast drawing from you, and you realize you're cumming longer and harder than you should, but soon, the ravenous breast sucks you dry, continuing to milk you aggressively for more.  You moan into Scylla's lips, and she pats your head, shuddering as she seems to slowly get off again too from being fed directly....");
			//[if (cumHigh = true) 
			else if (player.cumQ() < 1500) outputText("  Scylla's a blessed cum-milker and she doesn't fail this time, either.  Your orgasm and cum output are tremendous, more and more being pulled out of your [cock] and [balls] as Scylla releases a guttural sound, gently inflating her boobs further from draining you and orgasming on her own, milk flowing down her breasts and saliva down her neck as she gives in to the sensations.  Her breast, despite being sated, continues to suckle at you even after your orgasm, almost as if wondering if it could draw out more.  You snuggle up to Scylla, making out with her upper lips, her hands roam over your body in a comforting, pleasant fashion...");
			//[if (cumVeryHigh = true) 
			else {
				outputText("  Scylla's tit thirsts for your cum and you can't afford to let it down. Your orgasm causes you to black out for a moment as you flood her breast with wave after wave of cum, so much that you risk being pulled away from her lips if not for her possessively hanging on to you as she trembles in an intense orgasm, her thirst being sated and pleasure spreading through her body, more and more being pulled out of your [cock] and [balls] as Scylla's body and breasts continue to balloon out, her tits easing out slowly on their draining of you.  Cum and milk flow down her breasts as her body gives in to the sensations.  Her breast, despite being sated, continues to suckle at you even after your orgasm, almost as if wondering if it could draw out more.  You enjoy the sensation of Scylla's liquid-filled body under you for a while.");
			}
			outputText("\n\nYou finally lift yourself off Scylla after your orgasm, and she looks at you with warmth.  \"<i>That surprised me...</i>\" she claims.  \"<i>Not in a way that I'd mind, though...</i>\" she says, her smile widening as she blows you a kiss.  \"<i>This is certainly one way to celebrate love, and I must say I'm glad you gave me your proof of celebration...</i>\" she says with a blush, but quickly adds.  \"<i>Neither of us should give into desire so easily, though. Today, however, is special, so we should be easy on ourselves and let it slide...</i>\"");
			
			outputText("\n\nAn hour or so later and quite a bit after sunset, you return to your camp, satisfied and pleased with how you celebrated this holiday...");
			
			// Only add the perk if the player doesn't already have it.
			if (player.findPerk(PerkLib.SensualLover) < 0)
			{
				outputText("\n\n(<b>You have gained the Sensual Lover perk!</b>)");
				player.createPerk(PerkLib.SensualLover,0,0,0,0);
			}
			
			doNext(camp.returnToCampUseTwoHours);
		}

		//[Feed Her!]
		public function feedScyllaVDay():void {
			//{This option requires a member of Scylla's usual requirements}
			clearOutput();
			//{The PC titfucks Scylla again, and then gets her to suck them off, resulting in two quick orgasm and a big nice load of food for Scylla. How far can you fall to get off? On such a nice day, too!}
			outputText("You feed Scylla what feels like a gallon of jizz!");
			player.orgasm();
			outputText("\n\n(<b>You have gained the One Track Mind perk.</b>");
			player.createPerk(PerkLib.OneTrackMind,0,0,0,0);
			doNext(camp.returnToCampUseTwoHours);
		}


		//([Abby] 
		public function goVisitAbbyVday():void {
			clearOutput();
			outputText("You wave to Scylla and Pastie as you try to catch up with Abylon, who's already picking up the pace and, by the looks of it, trying to remove her dress.  \"<i>Well, sup.  I'll be going home and changing myself into my usual clothes, if you don't mind.  This entire celebration thingy just shows your people's issues,</i>\" she says, though she doesn't seem entirely untouched by the mood of it...");
			outputText("\n\nDeciding to risk it, you ask her if she'd like some company. Abylon turns to you, completely stunned.");
			menu();
			addButton(0,"Next",goVisitAbby);
		}

		//ABYLON EVENT
		public function goVisitAbby():void {
			clearOutput();
			outputText("\"<i>You... you're kidding, right?  That fatty's words messing with yah head?  I always figured you were somewhat less... messed up in the head than Suck-a-Lot and Always-Drunk.  Was I wrong?</i>\"");
			
			outputText("\n\nYou smile and tell her that if she wasn't wrong, that'd make it obvious you'd like to hang out with her rather than them, and if she was wrong, she'll just have to judge it for herself.");
			
			outputText("\n\n\"<i>Makes sense, I guess?</i>\" she answers, nodding. \"<i>But, seriously, keep a lil' bit of distance, and don't shove anything pink or red in my face.  Seriously, I'm all weird after that little love talk...</i>\"");
			
			outputText("\n\nYou nod and muse that as a goblin, she's not probably used to the notion.  \"<i>Damn right I ain't!  My crazy bitch of a momma would trade three of me for a four inch dick!  All she cares about is thick cum in her slut-box.  The guys I meet come to me 'cause they figure I'll let 'em blow their load inside me an practically cream my brains out 'cause of it,</i>\" she answers, somewhat defensively, and you wonder about musing if they were right, but decide against it. You do note, however, that this seems like she's not opposed to the notion, more like she was never faced with anybody loving her or anyone she'd come to love.  \"<i>Well... uhhh, look, it's all fine and all, the pinkies, reds, hearts and everything.  I just don't get it, all right?  It doesn't work that way, out there in Mareth.  They fuck you and claim you, or dump you in the dirt, or fuck you again and you possibly die, or fuck you and eat you.  That's how things work.  Cuddling up with someone after sex and whispering sweet nothings? Dates?  Gifts?  Weddin' someone?  Dat kinda shit?  Now, that's what's kinky and unusual here.</i>\"  She nods semi-sagely, and you can't help but think she has a point.");
			
			outputText("\n\nAfter a while of walking in silence, she finally breaks it. \"<i>Soo, uhh, what's the story with you and Sister Cow-boobs?  You two came 'ere from the same world or somethin'?</i>\" she asks.");
			
			outputText("\n\nYou explain to her that while you've known Scylla for longer than she has, probably, it's a pretty recent acquaintance.  You managed to free her, amongst other slaves, from a demonic factory and found her in Tel'Adre.  The two of you have... \"<i>helped</i>\" one another in a few ways after that, and been rather friendly since.  You blush a bit, remembering what the \"<i>helping</i>\" has sometimes brought.");
			
			outputText("\n\n\"<i>Ahhh, I see.  " + player.mf("He","She") + ", the hero, saving a nun from the evil clutches of the demonic overlord!  She says thank you through growin' monstrous curves and providing extra sloppy blowjobs!  Dat right?</i>\"  You giggle a bit at that interpretation, and say it's not really all that far from the truth, although it is cheapening things... as is her previous interpretation of \"<i>Marethian kinkyness</i>\" cheapening love somewhat.  Abby brings a hand to her lips.  \"<i>Well, she does, at least, LOOK like she could do some... stuff... to a cock.</i>\"  She says, blushing, before you detour that train of thought with a question on how she's gotten herself here.");
			
			outputText("\n\n\"<i>Well, I am the daughter of one of the firstborn corrupt gravidophiliac goblin-sluts of this world, Tamani! As a goblin, I should probably look up to the sluttiness of my mom while hating her guts for stealin' all that cock, but I simply hate her guts, since she's a selfish whore,</i>\" she explains.  \"<i>Same can be applied to most goblins, I guess.  Chasing after cum and pregnancy more than any real satisfaction, day after day,</i>\" she nods to herself.  \"<i>I knew something was wrong about it and have managed to fight off the urges somewhat, escaping \"<i>mommy's</i>\" clutches and moving away from the forest.  Saw a few things, even a farm, though there was a mean-looking guy there, so I stayed away.  I've met a few hunter and scout guys, though.  Nice boys.  Understood me and offered some... relief to these sick urges.  Done my best to avoid changing into an incubator permanently.</i>\" she says, though the amount of plumpness to her butt and her not completely flat chest may point out she's gotten herself pregnant once... or thrice. You don't push the issue.");
			outputText("\n\n\"<i>And a girl.  Really nice one, that.  With a cock, of course, I ain't much for that carpet munchin' shit, like most goblins.  A hermaphrodite, people would say.  Still, she called herself a girl, makes sense with the boobs, what else would she call herself?  She showed me my way here.  I guess she saw I'm less crazy than your everyday goblin.  I shagged her and a few guys, but... haven't seen her in a while.  Anyway, I...</i>\" she goes silent for a moment, looking at you, and then the ground.  She seems to try and weigh her words, or even consider saying them. \"<i>... something was a bit wrong about all that.  I mean, sure, getting cock was fun, but... I might've been just like every goblin, just seeing a bit past the get pregnant race and seeking mostly the sexual satisfaction. If that's true, I'm just remotely better than my cumwhore of a mother, so... when a nun invited me to that shitty meeting after seeing me drink my doubts away, I said, what the hell.  You know the rest.</i>\"");
			outputText("\n\nYou nod and tell her that, certainly, she seems less crazy and way more reasonable than any goblin you know of so far.  \"<i>Uhh, thanks. It's... nice to hear you say that.</i>\"");

			outputText("\n\nAbylon suddenly deeply flushes and turns to face you.  \"<i>You know, [name], I'm not dumb.  I know where this is going.  Uhhh, it's certainly rare to see a dashing hero play the nice guy with a goblin, I guess I didn't expect that, but, essentially... getting me worked up with nun blowjobs and stories of getting here... you're lookin' to get a little wet ain't you?  Just... be honest, I know better.  And I could actually use that.  Haven't gotten any in a while and I guess that whole talk and, well... you... got me a bit horny.</i>\"");
			
			outputText("\n\nYou smile at Abylon coyly and tell her that there's certainly no shame in getting off with someone on the day that's supposed to celebrate love, but you'd like to do it a little better than her \"<i>guys</i>\" before did, and get her off without dumping her in an alley afterwards.");
			
			outputText("\n\nShe nods and picks up the pace, and you soon arrive at a rather small, but not bad-looking shack nearby the city's walls.  Abylon invites you in, and you ask her if it's her house.  \"<i>Well... yeah?  I mean... I gotta live somewhere!  Suck-a-lot actually helped me with it, and... Uhh, you see, goblins can have other skills than just suckin' dick and taking creampies.  I'm a bit fit, I know a bit of alchemy, so put the two together, do some making, do some delivery, do a mix of both... I've made a small living.</i>\"");
			
			outputText("\n\nNodding, you go in and make yourself at home, before Abylon tugs at your hand and seemingly continues to remove her dress, showing herself to you naked, in all of her small, couple of feet tall \"<i>glory</i>\". \"<i>W-well, time for you to show what you're made of, champ,</i>\" she says, bending around a small table, wiggling her posh bottom at you with a look of certain hunger and restlessness to her eyes.");
			menu();
			if (player.hasCock()) {
				var x:int = player.cockThatFits(46);
				//([If ([cocksmallest] < 46 cockArea) 
				if (player.cockArea(x) < 46) {
					outputText("\n\nYou could certainly go for a dip into that goblin cunt, but, there's also the option of forgoing your pleasure on this special day and using other means to show her a good time.");
					//<You can both pleasure and fuck her>
					addButton(1,"Fuck Her",fuckAbbyVDay);
				}
				//[If ([cocksmallest] > 46 cockArea)
				else {
					outputText("\n\nThe small look of fright in her eyes when she sees how well-endowed you are tells you she'd be unable to really accommodate that.  Still, the option of pleasuring her in other ways remains.");
				}
			}
			//[if (hasVagina = false)
			else if (player.hasVagina()) outputText("\"<i>Well, that's unexpected. I have certain doubts about you showing me such a good time,</i>\" she says.  You tell her you don't actually require a cock at all to do this, and she seems surprised.");
			addButton(0,"PleasureHer",pleasureAbbyVDay);
			
		}

		//{FUCK HER}
		public function fuckAbbyVDay():void {
			clearOutput();
			var x:int = player.cockThatFits(46);
			if (x < 0) x = player.smallestCockIndex();
			outputText("Figuring that the goblin girl's felt so out of place amid a celebration of love, you might as well show her a little affection the only way she's likely to understand.  Pulling aside your [armor] enough to let [eachCock] spring free, you step up behind the bent-over girl and rest your hands on her thick thighs.  The emerald girl's breath quickens as the heat of your manhood presses between the jiggling globes of her ass cheeks and a whimper escapes her throat before she realizes it.  Coughing, in an attempt to cover the moment of weakness, she turns her head to the side to give you a disapproving eye.  “What is this, romance?  Just jam it in, already!” she commands, gruffly.  Her face is flushed a deeper forest hue, pink irises twinkling in the dim light of her spartan home.");
			
			outputText("\n\nUnintimidated, you take just a moment longer to tease the girl.  With the two of you, alone, in this intimate setting, you're given a chance to appreciate the goblin on her own merits.  Unlike most goblins, she doesn't  appear to be using hair dye - her vibrant red hue looks natural and matches the small tuft of silky red hair at the top of her jade pussy.  The three-foot braid hanging from her scalp is both thick and lustrous, suggesting that she may have channeled some of her kind's cock-hungry energy into an obsession with hair care.  Even her home is curiously devoid of the sexual aids you'd expect in a goblin's residence. She does have her kind's affinity for potions and leather, but most of the vials look more like antidotes than poisons and the leather plates she's cured are clearly more to protect the body than accentuate any sexuality.  Considering the rest of her race, she must be something of a paladin among them - showing a degree of self-restraint almost unheard of by the common goblin.");
			
			outputText("\n\nBut, at the end of the day, she's still wet and waiting - her plump rump wiggling against the throbbing thickness resting between her cheeks.  With a crooked smile, you draw back and brace yourself at the goblin paladin's moist lips.  She's no virgin, but the way she blushes and bites her lower lip in anticipation strikes you as positively demure.  Digging your fingers into her yielding hips, you slowly drag the girl onto your [cock], the tip slipping into her viridian folds with lubricated ease.  The proud woman lets out a shuddering moan as you fill the oft-neglected slit with your pulsing girth, her inner walls clenching around you as tight as a lover's embrace.  Resting her chin on the table she's bent over, Abylon closes her eyes, a smile flickering over her face as her hands restlessly toy with her long braid.");
			
			outputText("\n\nTaking your time, you slowly feed inch after inch into your quivering companion, her body remarkably accommodating for one who normally avoids sex.  Her mother's legacy, you suppose.  When you finally bottom out inside of her, Abby picks her legs up and hooks her feet around your waist.  With her flat, unremarkable chest laying atop the small table, she begins to rock back and forth, dragging every fold of her pussy across your " + player.cockDescript(x) + ".  You match her motions, thrusting slowly at first, before gradually speeding up. Her tight interior suckles at the rod spearing her while the table beneath her rocks back and forth at the rising tempo.  Shifting one palm from her hip to the distended swell of her belly, you use your other hand to gather up a few feet of her hair and coil it around your arm, pulling her head back just enough to let you see the gathering ecstasy flushing her olive cheeks.");
			
			outputText("\n\nUnable to hold back any further, you pick up your pace, from tender strokes to urgent thrusts, pounding into the goblin paladin with deep, hard motions.  The force of your efforts sends the table toppling to its side, Abylon suspended in the air by her legs tightly wrapped around your back, your hand on her muscled abdomen, and her burnished crimson braid wrapped around your arm.  Clinging to your " + player.cockDescript(x) + " with single-minded bliss, the goblin girl doesn't even seem to notice the ruckus your love-making is causing.  Impassioned loins united by mutual delight, the cavalier rides her champion until the cold tickle of your climax rushes down your spine and through your core.  With a cry of joy, Abylon tightens the grip of her athletic legs on your [hips] and hugs you close as the first spurt of your cum lances into her belly.  Succumbing to her racial needs, the gallant orgasms from the touch of your seed, her tongue hanging from the side of her mouth as her eyes roll up in her head.  You fill her with your hot loads until the spunk gushes out of her quivering pussy and she weakly mutters a word of thanks to Scylla that you suspect she hadn't meant to say aloud.");
			
			outputText("\n\nSated, you disentangle yourself from the clinging girl and lay her into her bed, with a kiss on her sweat-slick forehead.  She absently strokes between her legs, feeling the oozing jizz dribbling out of her stuffed snatch.  Maybe, for her, this is the meaning of the holiday: not just a casual fuck, but taking the time to really savor the body of someone who's important to you.  Even if it isn't love, in the strictest sense, being close to the people who impact your life is reason enough to find joy in your days.  You wish the little paladin a good night and, blowing out her candles, you take your leave.");
			
			if (player.findPerk(PerkLib.SensualLover) < 0)
			{
				outputText("\n\n(<b>You've received the Sensual Lover Perk!</b>)");
				player.createPerk(PerkLib.SensualLover,0,0,0,0);
			}
			
			player.orgasm();
			dynStats("sen", -3);
			doNext(camp.returnToCampUseTwoHours);
		}

		//{PLEASURE HER}
		//{This option doesn't require any sexual endowments whatsoever}
		public function pleasureAbbyVDay():void {
			clearOutput();
			outputText("Quite willing to comply in her desires in ways probably no one else has before, you approach Abylon from behind, wrapping your arms around her waist as you run them along her body.  She's certainly sensitive, shuddering and sighing a bit as your fingers take a dip down her abdomen and towards her female hole.  It spreads eagerly for them, and Abby sighs again.  \"<i>What's wrong?  Well, it's nice that you're preparing me, but...</i>\" you start moving your fingers faster and playing with her clit, as you kiss her neck as well, and she mewls, melting in your arms.  Her vagina is getting increasingly wetter, and you pleasure her skillfully, the little goblin writhing in your arms.  \"<i>Hah... like this... could make me cum, you dumbass!  What, you're suddenly in suck-a-lot's camp?  Where's my... UGHHH!</i>\"  That last sound makes it seem that she's lying a bit, and you prove it by starting to plunge your way about her cunt, stroking both her clit and her insides with your fingers.  She seems to resist continuously but it's definitely not easy on her...  So, rather than continue teasing, you pull away a bit, and she sighs, \"<i>Finally, let's get started,</i>\" before she feels you breathe out onto her wet goblin pussy.  \"<i>Wh...whawhat? You've got issues, come on, you can't eat me out nooaaaghghhH!</i>\"");
			
			outputText("\n\nYour fingers pumping into her and your tongue teasing her exposed labia and clit is too much for the goblin, and she shudders in her orgasm as you eagerly drink of her.  Slowly, you pull your hand away and push your lips in place of it, starting to lick and tongue-fuck the poor girl before she has a chance to come out of her high.");
			
			outputText("\n\nHer pussy gives way and drips onto your [face] and in your mouth richly, and she makes constant mewling sounds.  \"<i>C-come on!  Stop teasing me god damn it!  Are you an iii-aahhh-diot?  I'm go-oh-ohna kick ya out, ya know!?</i>\"  You don't intend to desist, and you flick her clit with your fingers again, causing her to push her bottom right into your face.  That gives you an idea, as you run your tongue from her pussy, and then, over her crack and soft buttocks, pleasuring her other hole when you're at it.  She starts panting and moaning.  \"<i>G-goblins don't use that hole!  We don't!  Don't get any crazy ideas you dumb f-fuck!</i>\" she says when you run your tongue back all the way to where it came, teasing both of her holes.  You massage her soft rump while you're at it, and by now, you're pretty sure she's rather sensitive all over, especially where her curves are developing...");
			
			outputText("\n\nAfter a while of doing this, you're pretty sure Abylon starts approaching her second orgasm, and you intent to fill her as much as you can for the occasion.");
			//([Naga tongue]
			if (player.tongueType == TONGUE_SNAKE) outputText("  Your fingers make it into her pussy alongside your tongue, and the prehensile thing, longer and more flexible than a human's, ravages the insides of her pussy, tasting everywhere as Abby shakes in her orgasm.  Her pussy eagerly tries to milk both your fingers and your tongue, clenching and gripping at them as it drips her pussy juices all over your face.  Abby screams out in a loud, uninhibited orgasm at last, expressing her ecstasy.");
			//([Demon/Dragon Tongue]
			else if (player.hasLongTongue()) outputText("  Abylon shakes in excitement, pleasure, and fear as you extend your inhuman tongue to reach deep into the recesses of her pussy.  She cannot hold out a moment longer, her cunt gripping your inhuman muscle tightly, the hole and muscles inside quivering as you can taster her orgasmic juices with every single point of your tongue.  She screams, shudders and moans, tongue lolling out from the intense pleasure as you force your own tongue to roll around inside her and stretch her in multiple ways. Only you holding her stops Abylon from slumping forward, it seems...");
			//([Human tongue]
			else outputText("  Hooking your fingers at the front and back of her cunny, you plunge your tongue in and wiggle it eagerly.  Abby clamps down on all three invaders and loudly moans out, screaming to her content at last, as your face is flooded with pussy juice.");
			
			outputText("\n\nAfter a while, Abby comes down from her orgasm and you're holding her in your arms for the duration of it.  \"<i>Dammnnn... it's still twitching.  I don't know if I can...</i>\"  You shush her, telling her you intended to do that and that returning the favor is unneccessary, before kissing her on the lips and wishing her the best of luck on this new holiday, and advising that perhaps she shouldn't give up on finding that special someone...");
			
			outputText("\n\nAbylon blushes the whole time, for once not finding the words to retort or insult you in any way, as you pat her on the head, making your way out.  \"<i>Th...thanks,</i>\" she says in a stuttering voice, before you close the door behind yourself and leave for your camp.");
			
			outputText("\n\nAll in all, you're pleased that perhaps you've managed to show a goblin that real affection does exist... not to mention get somebody off twice on a new Mareth holiday!");
			
			outputText("\n\n(<b>You've received the Pure and Loving Perk!</b>)");
			player.createPerk(PerkLib.PureAndLoving,0,0,0,0);
			dynStats("lus", 80);
			doNext(camp.returnToCampUseTwoHours);
		}

		//([Pastie])
		public function goVisitPastyVDay():void {
			clearOutput();
			outputText("You lean over the table Pastie is no longer dancing, but rather laying, on, and, conspiratorially, ask her if she'd like to go and get something to drink.");
			outputText("\n\n\"<i>Well, I wouldn't mind it, but actually getting it probably won't happen... everything's more or less closed,</i>\" she responds, livening up a little at the mention of drinking.  \"<i>Although, if you do have something with you, I wouldn't mind...</i>\"");
			
			//Check inventory for Goblin Ale, Black Cat Beer, Bimbo Champagne; failing this, check if PC has female genitalia.
			//[BCBeer] [BimboCham][GoblinAle][vagina]
			if (player.hasItem(consumables.BIMBOCH) || player.hasItem(consumables.BC_BEER) || player.hasItem(consumables.GOB_ALE) || player.hasVagina()) {
				menu();
				if (player.hasItem(consumables.BIMBOCH)) addButton(0,"BimboCham",pastieValentineIntro,consumables.BIMBOCH.id);
				if (player.hasItem(consumables.BC_BEER)) addButton(1,"B.Cat Beer ",pastieValentineIntro,consumables.BC_BEER.id);
				if (player.hasItem(consumables.GOB_ALE)) addButton(2,"Gob. Ale",pastieValentineIntro,consumables.GOB_ALE.id);
				if (player.hasVagina()) addButton(3,"Pussy",pastieValentineIntro,"vag");
			}
			else {
				outputText("\n\nYou tell Pastie that, regrettably, you only have what she sees.  She nods and says, \"<i>Too bad.  I think I'll better get going, then.  It's been somewhat fun, and I finally get a chance to go to sleep sober and wake up without a hangover.");
				doNext(camp.returnToCampUseTwoHours);
			}
		}

		public function pastieValentineIntro(choice:String = ""):void {
			clearOutput();
			if (choice == "vag") {
				outputText("You tell Pastie that indeed, she could get her fix, as you have something you're sure every fairy likes to drink not far away... between your legs.  \"<i>T-that's an... unusual drink proposition...  Umm, and I'm more susceptible to girls than most fairies, so... Ohhh, who am I kidding, that sounds pretty good right now.</i>\"");
				outputText("\n\nFollowing you into a back alley, you prepare to get yourself naked and let the fairy get her fix.");
				//((Move straight to pussy scene)) )
				menu();
				addButton(0,"Next",goForAPushayDivePasty);
			}
			//({Any other drink}. 
			else {
				var itype:ItemType = ItemType.lookupItem(choice);
				player.consumeItem(itype,1);
				outputText("You present the drink to Pastie and she flashes you a grin as she flies up and away, leading you into an alley.  \"<i>Well, lemme at it!  A drink sure as hell sounds good right now and none of this seems like it'd be really bad.</i>\"");
				doNext(curry(valentineDrinkPastie,itype));
			}
		}

		//PASTIE EVENT
		public function valentineDrinkPastie(itype:ItemType):void {
			clearOutput();
			outputText("One you're away from any prying eyes, Pastie turns to you and rubs her little fairy hands together, apparently barely able to hold her enthusiasm to finally get a bit drunk.  You're afraid it may not end at one drink, either, and for a moment, wonder about whether this is all right or not...");
			//Corruption 0-20] 
			if (player.cor < 33) outputText("  It probably isn't.");
			//[Corruption 21-75]
			else if (player.cor < 75) outputText("  You guess as long as she's fine afterwards, it should be okay.");
			//[Corruption 76-100]
			else outputText("  As long as she's in the mood to drink more than just the alcohol afterwards, you don't really care.");
			
			outputText("\n\n\"<i>Now, now!  Gimme, gimme!</i>\"  Well, apparently, the choice is out of your hands anyways.  You uncork the bottle and point the opening at Pastie, who is quick to dive into it, drinking her fill and causing you to spill some all over her body.  It's a bit fun to watch, to be honest, as a little fairy tries to drink out of a bottle larger than her.");
			
			outputText("\n\nWith a burp, Pastie removes herself from the bottle's tip and rubs her belly.  \"<i>Tasteeeehhh!!!</i>\"");
			
			valentineDayGetPastieDrink(itype);
		}

		public function valentineDayGetPastieDrink(itype:ItemType):void {
			//{Black Cat Beer}
			if (itype == consumables.BC_BEER) {
				outputText("\n\nPastie suddenly starts running her hands along her body, licking her lips as she does so. \"<i>Odd... Imma bit of a horny drunk, yah know, but thish ish... overkill...</i>\"  The little fairy-drunkard complains as she reaches between her legs and starts fingering herself, while rubbing a nipple.  \"<i>Daaaamnnnn, I'm sooo horny! I need more... to, uhhh, to driiink!</i>\"");
				outputText("\n\nWell, that was an expected effect, to be honest.  You guess you could also comply with her request, and horny as she is, she'd probably degrade herself with whatever sex bits you want her to... although, too big of a member can definitely be a problem for her.");
				//[RubDick][PussyDive]
				//{Rub Dick option is present if a character has a member underneath 28 cock area. Pussy Dive is obviously present if a character has a pussy of any kind.}
			}
			//{Bimbo Champagne}
			else if (itype == consumables.BIMBOCH) {
				outputText("\n\nPastie giggles as her body starts to slowly show the effects of the liquid she just drank.  \"<i>Hihihi... I feel kinda funny,</i>\" she says, and you start to see the changes the champagne is starting to have on her body.  Her hair starts turning blonde, and her position in mid-air changes somewhat... almost as if she was imitating standing on \"<i>fuck-me</i>\" pumps, and, slowly, her little cupid dress stretches, as you become aware that her body is starting to become curvier, especially in the chest area.  \"<i>Hahaha... it's, like, I'm hitting three puberties at once!  Ummm... pu... puber, ah, nevermind.  Look, look!  It's gonna rip!</i>\" The seams in the little dress indeed pop, exposing a significant amount of the little girl's cleavage, now very significant.  True, compared to your body size her breasts are still nothing, but on her little body they're very prominent.  She even seems to have trouble flying from the added mass!  Her hips gained the slightest bit of curve, too, and Pastie's hair is now completely blonde.");
				outputText("\n\n\"<i>Uhh, like... baby, you know, the usual drink gets me hot, and this one is as special as my new titties!  Would you mind helping me out?</i>\"");
				
				outputText("\n\nYou wonder if the sluttification has passed to everywhere on her body... there's a good chance a small member that's normally impossible for her entire body to fit may actually slip inside her now.  And you doubt she'd turn away a chance to get some cum or pussy juice, too.");
				
				//[Fuck][RubDick][PussyDive]
				//{Fuck is only present if a character has a cock under 8 cock area, Rub Dick option is present if a character has a member underneath 28 cock area. Pussy Dive is obviously present if a character has a pussy of any kind.}
			}
			//{Goblin Ale}
			else if (itype == consumables.GOB_ALE) {
				outputText("\n\n\"<i>Huuuh? Feels weird!</i>\" Pastie says, as she runs her hands over her body, and then slips a finger into her little pussy... four fingers... her hand, and then, reaches halfway up to her elbow before she cannot bend any more in her drunken state.  \"<i>Thissh... got me more horny than usual, and I feel so... stretchy, hehehe!</i>\"");
				
				outputText("\n\nHer body's still totally diminutive, but you guess someone with a small enough endowment might actually be able to take advantage of her now.  You doubt she'd refuse a little cum or pussy juice, either.");
				//[Fuck][RubDick][PussyDive]
				//{Fuck is only present if a character has a cock under 8 cock area, Rub Dick option is present if a character has a member underneath 28 cock area. Pussy Dive is obviously present if a character has a pussy of any kind.}
			}
			menu();
			if (player.cockThatFits(8) >= 0) addButton(0,"Fuck",fuckPastieForVDay);
			if (player.hasCock()) addButton(1,"RubOnDick",rubPastieOnYourWangDawg);
			if (player.hasVagina()) addButton(2,"Go In Pussy",goForAPushayDivePasty);
		}


		//[Fuck]
		public function fuckPastieForVDay():void {
			clearOutput();
			var x:int =  player.smallestCockIndex();
			outputText("With a semi-sadistic grin, you watch Pastie saunter towards you, clearly allured by the scent of your genitals.  You stroke your " + player.cockDescript(x) + ", quickly bringing it to an erection, imagining how tight even this little thing will feel inside Pastie's small, but now unnaturaly stretchable body.");
			
			outputText("\n\nBeing able to resist no longer, you grab her little bum and direct her towards your cock, not really hearing whether she's cheering, complaining, or asking you to stop; honestly, you could care less when you press your " + player.cockDescript(x) + " against the entrance to her diminutive vagina and start pushing.");
			outputText("\n\nAfter a while of fruitless pressing against her little legs, bum, and clit, Pastie finally gives way. Even your " + player.cockHead(x) + " is enough to stretch her already, but there's not much else to do now other than pushing it in deeper.");
			
			outputText("\n\nThe tightness of Pastie's confines is amazing, even as her body balloons out to more than twice its usual thickness, stretching and quivering around you, trying to either accommodate your " + player.cockDescript(x) + " or push it out completely.  It almost borders on painful, but also feels like a divine cum milking machine meant to draw your seed out of you.  You gently press Pastie down and pull her up your erection, essentially using her body as a masturbation aid, moaning all the while...");
			
			outputText("\n\nThat tight snatch is definitely made to make your cock spurt, and it won't be long, but for now you're enjoying the confines and twitches of a body stretched to beyond its limits only so it could accommodate your cock and cum, licking your lips at the thought.  Yes, you'll definitely give that little fairy bitch a good \"<i>shot</i>\".");
			
			outputText("\n\nNot really caring about whether it's premature or whether she's already fucked out of her mind, you groan and dump the contents of your [balls] into Pastie's overstretched body, feeling her incredible tightness first block it, then give way, then start pulsing and tugging on you as you fill her.");
			
			//if (cumNormal = true)
			if (player.cumQ() < 250) outputText("  Even your pretty average load is probably a massive amount for Pastie to take inside herself, and you can see it bloating her even further than your cock would do on its own as you slowly start to pull her off it.  Pastie moans and thrashes as you do, but soon, she's off, and your load drips from her pussy and onto the ground.  She seems slightly out of it.");
			//[if (cumMedium = true)
			else if (player.cumQ() < 500) outputText("  Your cumshots are normally pretty big, but for Pastie, it's like a flood.  Her tight confines prompt you to shoot out even more, milking you and tugging on your dick as you pump load after load into her little body.  Pastie screams out, moans, thrashes and pants as she's bloated further and further, ballooning out from the sheer amount of cum and starting to slide off your dick, but you keep her there until she starts twitching, her tongue lolling and her apparently losing consciousness.  Afterwards, you pull her off her dick, and your load drips from her pussy and onto the ground, her little body more like a ball now. She's more or less unconscious...");
			//[if (cumHigh = true)
			else if (player.cumQ() < 1000) outputText("  Pastie yells out at the first wave of your cum, and her tongue lolls out as you fill her up.  Her pussy clearly isn't meant to take that much and soon, she's little more than a balloon of your sperm, filled to the brim and beyond, sliding off your cock and onto the ground.  You tug on your member a few times to add a cum shower onto the effect, wondering how she'll react, before noticing she's unconscious.  Damn, that pussy clenches TIGHT and milks well.");
			//[if (cumVeryHigh = true)
			else if (player.cumQ() < 2000) outputText("  Pastie yells out at the first wave of your cum, and her tongue lolls out as you fill her up.  Her pussy tugs at you and you comply, filling her up to the brim, making her into a balloon of your cum rather than a little fairy, stretching her body to its absolute limits only gained thanks to her stretchable cunt.  She clearly isn't meant to take that much and yet, you pump equally big loads into her.  Pastie can't keep being on your cock with that pressure and is shot out, rolling onto the ground a few meters away as the rest of your load splashes onto the ground.  You look at her, and notice she's unconscious.");
			//[if (cumExtreme = true)
			else {
				outputText("  Pastie's mind apparently breaks from the first two ropes of your cum, pumping her full and stretching her as she whimpers, yells, her eyes rolling up to show her whites.  She's drooling by the time you've stretched her to her limits, becoming a sphere rather than a humanoid, filled to the brim with your cum, and that's just a small part of it.  The pressure is already too much for her supreme-milking, extra stretchy but even more extra tight pussy and she pops off your cock.  Your load follows her and splashes all over the place, shooting her further, onto the nearby wall that is already painted with ropes of your cum.  You do the same to the rest of the wall and the ground in front of you, tugging at your member as you almost lose sight of the fairy in the sea of white.  When you fish her out, she's unconscious.");
			}
			outputText("\n\nHaving gotten off so well, you pat the little fairy on the head and leave her on a nearby windowsill so no animal will harm her when she sleeps - and so nobody steps on her by accident.  She's out of it, but given that she's made such a good cumdump, she deserves a little safety in return.");
			
			outputText("\n\nYou grin and lick your lips as you return to camp.");
			
			outputText("\n\n(<b>You have gained the One Track Mind perk!</b>)");
			player.createPerk(PerkLib.OneTrackMind,0,0,0,0);
			player.orgasm();
			dynStats("sen", -2);
			doNext(camp.returnToCampUseTwoHours);
		}

		//[RubDick]
		public function rubPastieOnYourWangDawg():void {
			clearOutput();
			//Pastie rubs her entire body against the PC's dick, allowing them to cum quicker and give her a cum bath. Too much cum causes her to go ahegao, scream \"<i>itsh a sheeeaaa of driiinkshhh!</i>\", and forces the PC to fish her out of the cum before she drowns.
			//Pastie Valentine option
			//(Just a thought, but the size requirement for this scene should be removed, as it works with just about any size dick)
			//[Rub on Dick]
			outputText("You watch Pastie with some amusement as she tries to saunter over towards you, swishing her skirt in a sassy strut. Her diminutive form notwithstanding, the allure of her movements are somewhat sabotaged by the lush's lack of coordination.  Though slight enough to be unnoticeable by anyone else, the small fairy seems to be drawn by your scent, her uncertain flight tracing a dizzying path toward you.  Somehow, she manages to trip over herself in mid-air, her delicate crystal heels flying wide as she kicks out with a yelp.  Flapping her gossamer wings wildly as she spins downward, the sprite lets out a frustrated \"<i>ack!</i>\" and faceplants into your groin. Making the best of the situation, she wriggles onto her side and puts on her best 'come hither' look.");
			
			outputText("\n\nShaking your head with a smile, you gently pick the drunken fairy up and loosen your [armor], allowing your [cock biggest] to breathe free. She giggles in glee at the sight, wriggling to try to get free, but you keep her firmly in hand for the moment, instead stroking yourself to full erection.  \"<i>Aw, come on, ya tease,</i>\" she whines, sulking as she watches your shaft swell.  Once you're satisfied with your own firmness, you transfer Pastie to your dominate hand and take a moment to appreciate her body. The small blond is actually quite buxom, with curves that'd be the envy of any goblin, though writ small.  Her addiction to milk has apparently spurred mammary development in the pixie far beyond the normal proportions of her kind, while her drinking has put a fair amount of weight in her hips and rump.  With careful fingertips, you pull the dress from her slender shoulders and leave the fairy bare and hiccupping.");
			
			outputText("\n\nWith a grin, you bring the hand holding Pastie to the base of your [cock biggest] and wrap your fingers around the shaft, pinning the girl to your throbbing pole.  With slow, steady motions, you lift her up and down in long strokes, rubbing her warm soft body along your shaft.  She protests, drunkenly, insisting that she's more than capable of handling you without the help, but you raise her to the crest of your cockhead and press your thumb against the back of her head, pushing the noisy sylph's open mouth against your urethra just as a dollop of pre-cum bubbles out.  Catching the drug-like spunk full-on, she sputters, swallowing and blinking away the miniature facial you've given her.  The effects are immediate, the alcohol-lubricated fairy instantly pliant to your renewed caresses.  You can finally appreciate why she's in addiction counseling: a single drop was enough to leave her reeling - and of pre no less!  She's even more sensitive than most of her race, which would explain why she dulls the sensations with liquor.");
			
			outputText("\n\nFlushed and panting, Pastie gives up trying to control your pace and goes along with it, wrapping her arms and legs around your [cock biggest] as best she can.  Grinding her petite pussy against the bumps and swells of your engorged length, you're delighted to find that the little lush's cunny is drooling a seemingly endless stream of warm, clear fem-cum.  The lubrication saturates your rod in no time and your pumping grip quickly coats the fairy in her own honey, leaving her glistening as if freshly oiled.  You pull her once more to the sensitive tip of your cockhead, though this time she leans in of her own volition, kissing your peak with ditzy relish, even going so far as to slip her tiny, wet tongue into your urethra.  Satisfied with the renewed, crystal flow gushing from between her legs, you rub her along your shaft with even harder strokes, feeling every curve of her wriggling form.");
			
			outputText("\n\nPolishing your mast with the amorous drunk has been fun, but you think you've teased her enough. Raising the tempo of your fey massage, you can feel your release building up just behind your [cock biggest] in a heavy pressure that floods your loins with urgency.  Gritting your teeth, you wrap your other hand around the first and bounce her faster and faster along your meat.  Eager caresses become frantic friction as Pastie feels your flesh swelling against her.");
			if (player.balls > 0) outputText("  Your [balls] lurch, " + player.skin() + " contracting as liquid passion rises within you.");
			outputText("  Your [ass] clenches in anticipation, heralding your climax, so you slide the fairy up your shaft, pulling free from the grip of her arms and legs, holding the confused girl directly in front of your " + player.multiCockDescriptLight() + " while loosing your grasp to bear her entire, curvaceous form to the open air.  With a shuddering gasp, you erupt your intoxicating cream directly into the fey girl, your orgasm");
			//low cum production:
			if (player.cumQ() < 250) outputText(" easily drenching the tiny fairy, in plump pearls up and down her naked flesh.");
			else if (player.cumQ() < 750) outputText(" leaving her and the arm you're holding her in dripping with a sticky alabaster lacquer.");
			//high cum production:
			else outputText(" almost blasting her right out of your hand in the torrent of white that spills forth from your mighty member.");
			outputText("  The spunk-plastered pixie shudders in your palm, overwhelmed by the spoo drenching her.  She masturbates, feverishly, climaxing in seconds and then again a moment later.  You watch her for a few minutes, the batter-basted bimbo jilling herself silly from the heightened sensitivity your spoo shower has given her.");
			
			outputText("\n\nHaving gotten yourself off, and with the sprite showing no sign of slowing down in her insensible self-love, you pat the little fairy on the head and leave her on a nearby windowsill.  Eventually, you reason, she'll run out of steam and be so exhausted from the effort that she'll likely pass out.  You wouldn't want a stray animal—or footfall!—to harm the tanked girl while she sleeps.  She's too out of it to appreciate the compliment, but you thank her all the same for being such a wonderful cum-canvas.");
			
			outputText("\n\nYou grin and whistle a spritely tune as you return to camp.");
			// (You have gained the One Track Mind perk!)
			outputText("\n\n(<b>You have gained the One Track Mind perk!</b>)");
			player.createPerk(PerkLib.OneTrackMind,0,0,0,0);
			player.orgasm();
			dynStats("sen", -2);
			doNext(camp.returnToCampUseTwoHours);
		}

		//[Pussy Dive]
		public function goForAPushayDivePasty():void {
			clearOutput();
			outputText("With a grin and a lick of your lips, you shed your [armor] and spread your legs for the happily drunk fairy, showing her prize: your [vagina] and the [clit] that accompanies it.  It doesn't take Pastie even a few moments to fly towards you and then aim for that [vagina] in a small slalom in the air.  The lips of your gash feel the touch of little hands and feet, and you shudder in anticipation.  Pastie takes long licks all over your vagina and rubs her entire little body around, before finally starting to slip one or another of her limbs experimentally into your [vagina].  It feels amazing to have such a pretty little thing moving around in there, and soon, your [clit] is shown some love as well as Pastie rubs herself all over it before stuffing her face into your wet pussy.");
			
			outputText("\n\nYou raise a hand to your [chest], moaning out loud, ");
			if (player.hasCock()) outputText("your other hand moving downwards to tug on [oneCock], ");
			outputText("anticipating the incoming wriggling inside your pussy and an orgasm you'll have with an entire fairy buried inside you.");
			
			outputText("\n\nPastie doesn't disappoint and is soon pushing herself all the way to her hips inside you to get as good of a taste as she can. It does feel amazing when her little hands press against your inner walls, spreading you wide, and your [vagina] starts quivering and clenching around her in anticipation.");
			//[if (hascock = true)
			if (player.hasCock()) outputText("  All the while, you continue to jerk off [eachCock], preparing yourself for an orgasm on both sides.");
			outputText("  She finally takes a full dive inside, and you moan out in pleasure, feeling her little body roll and explore in there, her tongue tasting every bit of fluid she can from what's moisturizing your inner passage.");
			
			outputText("\n\nAfter a while, you're moaning out loud, rapidly approaching orgasm, when Pastie, struggling against the clenching and unclenching walls of your [vagina], manages to get her head and hands out of you.  She kisses and wraps her hand around your [clit], stimulating you further as you scream out, her lower body still penetrating you and wiggling around.");
			
			outputText("\n\nYou can take this no more and you shudder in an orgasm, painting Pastie's little body with more of your femcum.  She giggles at the sudden intensity of your contractions, and starts trying to slip out slowly.");
			//[if (hascock = true)]
			if (player.hasCock()) outputText("  At the same time, your cock deposits its own load onto the ground as your hermaphrodite genitals achieve a simultaneous orgasm.");
			//[if (isSquirter = true)
			if (player.wetness() >= 4) outputText("  She doesn't have much to say in the matter when your female ejaculation truly shoots in, though, sending her rolling out of your [vagina] and onto the ground.");
			
			outputText("\n\nPastie giggles as she flies onto the nearby wall, heavily, completely soaked in your secretions.  As you look to her, she answers.  \"<i>I'm fine!  It's all okay.  Justtt.... too much to drink.  Feels gooood, though, hehe!  We should try that again.</i>\"  You nod and smile at her, gently wiping her with a finger and letting her taste your pussy juice off it before going back to camp.");
			
			outputText("\n\nTrue, this might not have been the most romantic sex act, but it was certainly enjoyable for the two of you.");
			
			if (player.findPerk(PerkLib.SensualLover) < 0)
			{
				outputText("\n\n(<b>You have gained the Sensual Lover perk!</b>)");
				player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
			}
			
			player.orgasm();
			dynStats("sen", -2);
			doNext(camp.returnToCampUseTwoHours);
		}
	}
}

/*END!



1) Hanging out with Scylla's Addiction Group. Requirements :
A) Meeting Scylla's Addiction Group (Scylla, Abylon, Patsie) before.
B) One has to have a cock to play with Scylla or Abylon, but not neccessarily Patsie. One has to bring either Black Cat Beer, Bimbo Champagne, or Goblin Ale to play with Patsie.
C) The player meets Scylla's Addiction Group and they hang out as Scylla goes about establishing the holiday in Tel'Adre.
D) Once this is over, player can choose to stay and spend more time with Patsie, Scylla, or Abylon, or leave.
E) Staying with Patsie requires one of the alcoholic items. If the player has none, re-direct to Abylon, Scylla, or Leave.
F) The encounter can grant one of three PerkLib. Scylla allows all perks, Patsie allows the Tainted or Corrupted perk, and Abylon allows the Pure or Tainted perk.
G) Picking Scylla leads to walking around Tel'Adre before watching sunset on the walls. The PC and Scylla are allowed to do this due to their reputation.
G1) The player staying with Scylla can choose to : 
- Cuddle and watch, leads to next day or loss of a few hours. Gives the Pure and Loving perk, plus stat modifications (lowers Corruption and Libido, raises Lust)
- Make out with all of Scylla's nipples. (Heightens Sensitivity, Toughness and Lust, lowers Libido, gives the Sensual Lover perk)
- Feed Scylla (Lowers Lust, increases Corruption and Libido, gives the One Track Mind perk)

G2) Player going with Abylon gets to learn a bit more about her and later can help with her Sex Addiction. They can finally fuck Abylon or help her masturbate.
- Fucking Abylon (tenderly) gives the Sensual Lover perk
- Masturbating Abylon gives the Pure and Loving perk
G3) Players going with Patsie get her drunk, and if it's Goblin Ale, they may gain a goblin transformation and unlock the penetration of her.
- If they have a vagina, they can allow Patsie to go there. Unlocks the Sensual Lover perk.
- If they have a cock  of a very low area (up to 9 I guess), they can penetrate Pastie if she drunk the Goblin Ale. This unlocks the One Track Mind perk.






And in Scylla's Cuddle scene, you just share a simple kiss before cuddling. In the makeout scene, you first kiss all of her lips before she notices you're sporting a boner, then she slowly rubs one out of you as you keep making out with her lips, until you're finally on your back as she coaxes you almost to the point of cumming and then sticking you in her appropriate lipple, having you cum.

*/
