//const GATS_ANGEL_GOOD_ENDED:int = 638;
//const GATS_ANGEL_DISABLED:int = 639;
//const GATS_ANGEL_QUEST_BEGAN:int = 640;
//const GATS_ANGEL_TIME_TO_FIND_KEY:int = 641;
/*A Christmas Carol

Entry for the 2012 CoC Contest, \"<i>A Very Milky XMas</i>\".
Starring Gatters Bee, Shamble Sworth and a caribou named Kirbu.
*/
package classes.Scenes.Seasonal {
	
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.PerkLib;
	
	public class XmasSnowAngel extends BaseContent
	{	
		
		public function XmasSnowAngel() {}
		
		public function gatsSpectacularRouter():void {
			if (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] == 0) christmasEncounterAngelJunk();
			else if (player.hasKeyItem("North Star Key") < 0) findTheWindUpKey();
			else giveThatBitchAKeyYo();
		}

		public function christmasEncounterAngelJunk():void {
			clearOutput();
			menu();
			//[Not Christmas]
			//[Explore > High Mountains]
			if (!isHolidays()) {
				outputText("You traipse the high mountainside, a light sprinkle of snow fluttering haphazardly through cold winds.  The sound of your steps begins to form a crunch as the silent white blanket folds over the tops of the nearby peaks, and with your journey to the high mountains appearing fruitless thus far, you consider the possibility of going back to camp.  As snowflakes pervade the air, they'll eventually obscure your sight, leading to a far more dangerous trip both up or down.  Just as you start to turn back, however, a small song echoes from the other side of the peak.  Soft enough to send one to sleep, it barely catches your attention.  Do you decide to investigate?");
				//[Yes][No]
				addButton(0,"Yes",encounterQuoteUnquoteAngel);
				addButton(4,"No",dontExploreGatsChristmasTale);
			}
			//4. Intro
			//[Must Be Christmas Time]
			//[Explore > High Mountains]
			else {
				outputText("You traipse the high mountainside, a light sprinkle of snow fluttering haphazardly through cold winds.  The sound of your steps begins to form a crunch as the silent white blanket folds over the tops of the nearby peaks, and with your journey to the high mountains appearing fruitless thus far, you consider the possibility of going back to camp.  As snowflakes pervade the air, they'll eventually obscure your sight, leading to a far more dangerous trip both up or down.  Just as you start to turn back, however, a small sob echoes from the other side of the peak.  Soft enough to send one to sleep, it barely catches your attention.  Do you decide to investigate?");
				//[Yes][No]
				addButton(0,"Yes",encounterQuoteUnquoteAngel);
				addButton(4,"No",dontExploreGatsChristmasTale);
			}
		}

		public function dontExploreGatsChristmasTale():void {
			clearOutput();
			//i. No
			outputText("In a place like the high mountains, there's no warning to be found if you happen to be confronted by danger.  Deciding not to take your chances, you continue to walk down the path you came, leaving the peaks to head straight back to camp.");
			outputText("\n\nIt's certainly warmer there.");
			//turn dat shit off
			flags[kFLAGS.GATS_ANGEL_DISABLED] = .5;
			doNext(camp.returnToCampUseOneHour);
		}

		//ii. Yes
		public function encounterQuoteUnquoteAngel():void {
			clearOutput();
			if (!isHolidays()) {
				outputText("You haven't found anything as of yet, so you figure you might as well keep going.  Following the quiet tune from above, you trace the spiralling side of the snow-capped behemoth, eventually reaching a small cliff hanging beneath the mountain's peak.  Upon the cliff, a small lake encompasses the area.  Though it remains frozen, a single soldier lies inside, hugged by an icy grave.");
				outputText("\n\nThe source of the song you had heard appears to be coming from a small, elderly woman huddling over the lake.  She holds a small fishing rod piercing through the icy shell of the water, though by the looks of it there aren't even any fish to be found.  Trotting over, you manage to catch her attention.  The old lady pats the soft, snowy ground beneath her, offering a seat by her side.");
				outputText("\n\n\"<i>I have a tale to tell, traveller,</i>\" she coughs.  \"<i>Sit by me, will you?</i>\"");
				outputText("\n\nWith nothing else to do, you figure you might as well hear it out.  Stories may not bring warmth to your body, but your heart might find it comforting during this unnatural winter.  Nodding, you sit down next to the elderly woman, to which she offers you some rock candy.  You decline, mentioning that you had brought your own");
				if (silly()) outputText(" (you didn't.)");
				else outputText(".");
				outputText("  She beams a toothless grin, popping one into her mouth and blowing out a stream of candy-scented smoke.  Suddenly, you're glad you didn't take any.");
				outputText("\n\n\"<i>Once upon a time, upon this very mountain, two lovers had ran to escape the corruption of the world.  A single spirit, more beautiful than any mortal woman, and a man she had created from tin.  Her brave soldier.</i>\"");
				outputText("\n\nLike a wistful tune, her words form vivid images within the ethereal smoke.  A lone giant as tall as the mountains themselves huddles close with her soldier, an average-sized suit of armor.  The foggy image twists and turns like a velvet cloth, telling the story of her soldier's life.  Though they had stayed together, he grew slower and slower each day.  Eventually she carried him in her arms to the peak of a snowy mountain, but by that point he had ceased to move.  She built a grave, and with her divine tears, encased him in the crystalline lake for an eternity.");
				outputText("\n\n\"<i>No one knew where the woman had gone, but they say she visits him once a year, when the lake is covered in a blanket of snow.  Perhaps you'll see her.</i>\"");
				outputText("\n\nHer gummed smile appears once more.  \"<i>Perhaps you'll save them, too.</i>\"");
				outputText("\n\nWith that, she hushes you away to return to her fishing.  With nothing to show for it, you decide to cease your journey up the high mountains, turning tail to head back to camp.  In the back of your head, the tale of the spirit and her soldier stay fresh in your mind.");
			}
			//ii. Yes
			else {
				outputText("You haven't found anything as of yet, so you figure you might as well keep going.  Following the quiet cries from above, you trace the spiralling side of the snow-capped behemoth, eventually reaching a small cliff hanging beneath the mountain's peak.  The sight you're met with manages to take your breath away - and considering the inhabitants of the land around you, that in itself is quite a difficult feat.");
				outputText("\n\nYou had never met a true giant in the land of Mareth, though to be fair you aren't even sure you're meeting one now.  A woman as tall as the mountain itself rests her head upon the side of the cliff, her umber skin adorned with falling snowflakes and her rosy cheeks stained with tears.  Her waterfall of ivory-white hair curls down gracefully onto the soft ground, and a pair of tree-like antlers erupt from the top of her head, colored with red and white stripes.");
				outputText("\n\nYou could swear that a sextet of invisible wings beat slowly behind her, forcing the direction of the wind to change with every movement.  In the span of the warm breath that emits from your cold lips, a single word appears in your mind - one that perfectly defines the sight you have been introduced to.");
				outputText("\n\nGoddess.");
				outputText("\n\nYou take a step forward, though something else seems to have caught your eye in the process. It seems you had missed it earlier - another person?  Though it isn't as lively or as remarkable as the sleeping giantess in front of you.  Regardless, you walk towards it to investigate further.");
				outputText("\n\nThe closer you get, the more you're able to discern the figure of a lone knight covered by the mountain's icy blanket.  The helmet, though obscuring his face, reveals an empty interior.  You'd call it a shell, though the joints of the armor are more practical than protective.  If you could hazard a guess, this knight is more like... a doll? You slowly reach out to touch him, but as you do, the angelic colossus stirs from her slumber.");
				outputText("\n\n\"<i>Who... is there?</i>\"");
				outputText("\n\nYou don't have time to hide, and considering your location you'd be surprised to find effective camouflage in the giant fuck-white background you're currently situated in.  Instead, you wait out the woman's awakening, the divine giant stretching out and appearing taller than the world itself.  She yawns awkwardly, blinking her emerald eyes before focusing them upon you.  With a sense of finality to her morning routine, her unseen wings flap once against the winter winds, blowing you back into the cliffside.  Holy Marae, you're going to be swallowed alive.");
				outputText("\n\n\"<i>Lost child, who might you be?</i>\"");
				outputText("\n\nYou back up against the rocky wall, mostly to get out of the heap of snow building up around the peak.  The giantess seems kind, forgiving");
				if (silly()) outputText(", without a penis");
				outputText(" - a loving aura surrounds the feminine creature and you can't help but feel as if she's here without ill intent.  Stating your name, you question her purpose at the high mountains.");
				outputText("\n\n\"<i>[name], is it?  That's quite pretty.  I don't meet many people with names, and I'll be sure to remember yours.</i>\"");
				outputText("\n\nYou cock an eyebrow, though she doesn't take notice.  Instead, the snow-dusted titaness turns her gaze towards the empty soldier, before a look of pain embraces her visage.  Turning your neck, you ask her about her relationship towards the mechanical man.  She smiles, though it's plain to see how distant it has become.");
				outputText("\n\n\"<i>He's my brave soldier.  Nothing more, and nothing less.  I had created him out of tin, before giving him life, and from the moment he was born, he had loved me from the very bottom of his heart.</i>\"");
				outputText("\n\nThough her presence is otherworldly, you ask if she is a goddess of the land - a deity from above, perhaps, but the woman only shakes her head in response.");
				outputText("\n\n\"<i>Not a god, nor a giant,</i>\" she whispers.  \"<i>The men of your land had called me a spirit, and for the person I once was, it seemed to be the most appropriate title.  Now, however, I am but a fool who wished to know what it was like to toy with fate.</i>\"");
				outputText("\n\nYou'd pat her on the shoulder, but you'd rather not climb any more mountains.  Instead, you offer your condolences, looking towards the silent knight in his time of slumber.  The angelic giant continues her story, the whistling of the snow-speckled wind providing music to her joyless tale.  The magic that had brought her knight to life was more akin to a curse than a miracle, and although she herself could live for an eternity, the knight would move less and less, until eventually he ceased to move at all.  She begins to cry once more, her voice echoing through the mountainside.");
				outputText("\n\n\"<i>I didn't know I was going to fall in love, too.</i>\"");
				outputText("\n\nSilence falls upon you both as you allow the colossus time to collect her thoughts.  Though her eyes sparkle with a divine beauty, they're red with the years spent crying to herself.  In time, she picks herself back up, letting her soft-spoken voice continue her story.  The soldier had given himself a name - North, simply after the direction he was facing during his creation.  And although her kind had no need for names, her soldier had given her one regardless.");
				outputText("\n\nYou ask if there's a way to bring him back to life, to end this eternal suffering they had subjected themselves to.  She smiles weakly, but shakes her head in dismay.");
				outputText("\n\n\"<i>Though the magic that kept him together was strong, the key that wound him up and began his life was the secret to his creation.  It was lost long ago inside the secret grotto he was born in, and by the time we had returned when we needed it most, the mountains had grown over it.  I am far too tall to search them, and far too weak to rip them apart.  Though a stranger might find us every hundred years or so, none return.</i>\"");
				outputText("\n\nYou tell her that you'll try your best to find it, though you admit that even you don't fully believe your words.  She must've heard the same thing thousands of times before, to no avail.  Despite this, her face brightens, her glimmering tears whisked away by the cold winds.");
				outputText("\n\n\"<i>I believe in you.</i>\"");
				outputText("\n\nThe feminine behemoth rests her head upon the cliff once more, but not before waving you goodbye.  You return her gesture with a thumbs up, heading back to camp to prepare for another wintery escapade.");
				flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] = 1;
			}
			flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
			
		//5. Solution
		public function findTheWindUpKey():void {
			clearOutput();
			outputText("Upon reaching the base of the mountain, you set off on your quest for the grief-stricken giantess.  A sunken grotto hidden around the mountain's base, you recall.  In all your treks over this bump in the land, you've never noticed anything even vaguely resembling the little shelter she described.  However, \"sunken\" gives you a vital hint to help begin your quest in the right direction.  You remember a steep valley, flooded and forgotten in its tiny alcove amidst the towering earth.  It takes little time at all until you've worked your way around to the unremarkable crater, pushing your way past the dense growth and through the humid mist surrounding it.");
			outputText("\n\nIn a surprisingly bold move, you strip free of your [armor], not wishing to waste thoughts worrying about wet or ruined articles of clothing.  The majority of your time in this land is spent in the nude as it is, so a skinny dip isn't so out of the ordinary.  A simple dive into the unusually clear waters marks the next branch of your search.  Sunlight sparkles as it draws rays through the crystal-clean pond, highlighting the darker recess underneath an outcropping of jagged rock.  You surface for another gasp of air before embarking on the next leg of your journey.");
			outputText("\n\nAn odd green glow fades in ahead of you, marking the exit from the engulfed tunnel.  Surprisingly cool, fresh air fills your lungs as you emerge onto the stony beach.  Brushing your [hair] clear away from your face, you can hardly believe your eyes as they set upon the cramped cave.  The entire opening is bathed in a dim green light, radiating from glowing rocks and gems embedded into every imaginable surface.  Dotted among them are tiny, slightly brighter specks of red and pink.  You can't help but stare in silent awe at the sight, glancing down at your wet hands to bask in the deep, inviting glow.  This has to be the place.");
			outputText("\n\nRegret is the only thing on your mind once you pull free of the water; it's much colder in here than you had anticipated.  A quick shake and a firm rubbing along your arms staves off the feeling long enough for you to concentrate on the task at hand.  With careful steps of your bare [feet] along the smooth rock, you investigate your surroundings for anything of particular note.  It's only now that you wish you had actually bothered to ask just what this key looked like.  Best not to just assume things when it comes to mysterious, gargantuan titans weeping high in the skies, you note to yourself.");
			outputText("\n\nLuckily for you, there isn't much ground for you to cover.  Your hands slowly pass over the illuminated surfaces, hunting for anything that stands out.  For as inspiring as the illuminated crag and minuscule gems appear, you doubt that any it is what the mountaintop spirit requested of you.  A few moments pass before a slight ledge hanging over your head comes to your attention, shrouded in the dense emerald radiance of the cave.  Looks as though this little hole has at least a little more to it than you anticipated!");
			outputText("\n\nA sturdy grip and a measured tug propels you up the wall, with extra care taken not to brush your bare body against whatever lays on the multicolored wall.  Though there is more to the cave than you initially anticipated, it doesn't amount to much more than an illuminated little dome.");
			//[if (tallness > 60) 
			if (player.tallness > 60) outputText("  You can't even stand straight up below the low-hanging ceiling, forced to carefully tread along on your knees over the slick, hard rock.");
			outputText("  Squinting around the small, deep green grotto, a pedestal in the center calls out to you.  As you approach it, it becomes evident to you why things are so chilly in here; the outcrop is made up of clear ice - and within, the bodies of the many who had found this place before you.  At least that mystery is cleared up.  Atop the frozen prop lies a small, crystal... crank? Upon closer inspection, it actually resembles a - kitty titties, it's a windup key!  Despite the fact that you should've seen this one coming, you surmise that this is the item you've come searching for.");
			outputText("\n\nYou reach over the bitter base to pluck your prize free, again careful that your moistened, exposed body refrain from making contact with the frigid obelisk.  There isn't an ounce of your being that wants to experience ripping any frozen flesh free.  As you grasp and pull free the slick, clear trinket you're taken by surprise as the brilliant glow surrounding you snuffs out, quickly leaving you in silent, black darkness.  Your hands grasp tightly onto your bounty, gently rubbing over its curves with your fingertips as you fruitlessly glance around in search of light.");
			outputText("\n\nOne surprise leads to another when a warm glow breaks free from between your hands.  A swirling of green and red mist is concentrated within the frame of your prize, glowing brightly as they swim endlessly through the key's curves at a variety of velocities.  It's plain to see that this little treasure was the cause for the cave's unnatural brilliance.  You're a little ashamed to rob it of its power source... but not enough to give it a second thought as you crawl back down to the entrance only a few feet away.  The last thing you want is for your magical lantern to dull and leave your naked body blind in this hazard-filled hole.");
			outputText("\n\nYou carefully re-enter the flooded tunnel, unsure how the supposed key will take to water.  It makes little impact as you submerge it, though the glowing light looks lovely on the pitch black tunnel.  The sight reinvigorates you slightly, though the warmer waters are probably more to blame.  Chalking up yet another simple retrieval asked of your person, you surface back outside, eager to get back into your [armor] and return to the high mountains.");
			player.createKeyItem("North Star Key",0,0,0,0);
			doNext(camp.returnToCampUseOneHour);
		}

		//ii. Bringing the Key Back
		//Activates upon returning to the High Mountains after the previous scene, before X amount of hours or X amount of time past Dec 25th (presumably)
		public function giveThatBitchAKeyYo():void {
			clearOutput();
			//if in time!
			if (flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] < 150) {
				outputText("All throughout your perilous climb, you cannot help but ogle at the brilliant little crystal key.  You have a suspicion as to how this innocent little key will help the crying colossus on the peak, but you are not completely sure this is the artifact she required.  But you have a hunch that it is.");
				outputText("\n\nYour trek halts to a standstill as you return to the side of the vast giantess.  Her sadness and longing appears to have overwhelmed her to a degree, putting her to sleep beside the still-inanimate soldier beside her.  You cast another glance at your brilliant relic, hooking a finger through it as you lift it before your face.  Transfixed by the swirling dance of red and green, you begin to weigh the options before you.  The spirit would surely request the key from you so that she may return her love to his former self, you believe.  However, perhaps you deserve a greater reward from this little deed.  You hold all the important cards in this deal after all.  You thoughtlessly swirl the windup key around on your finger, pondering your next move.");
				outputText("\n\nYou could try to fuck around with the spirit or her soldier, but doing either would be a huge dick move...");
				menu();
				//[Give the Key] [Fuck the Soldier] [Fuck the Angel] 
				addButton(0,"Give The Key",goodEndForChristmasMiracleICant);
				addButton(1,"Fuck Soldier",theWorstEndingEverDotJPG);
				addButton(2,"Fuck Spirit",fuckTheAngelBadEnd);
			}
			else {
				//Activates upon returning to the High Mountains after the previous scene, but after X amount of hours or X amount of time past Dec 25th (presumably)
				outputText("All throughout your perilous climb, you cannot help but ogle at the brilliant little crystal key.  You have a suspicion as to how this innocent little key will help the crying colossus on the peak, though you aren't entirely sure this is the artifact she required.  But you have a hunch that it is.");
				outputText("\n\nAs you reach the peak of the mountain, you find the lone giantess still lying on top of the cliff side, a hand stretched out to her mechanical lover. Perhaps you should surprise her when she wakes.");
				outputText("\n\nWalking towards the tin soldier, you take out the cold wind-up key, looking around for a place to stick it inside.  Before you can look any lower, a small, convenient hole lies at the base of his back, between two slices of armor resembling shoulder-blades.  Darn.  You give a grin, placing the object within the hole and turning it ever, ever so slightly.  You want this to work, and you're certain that his titanic lover would want more than anything to see him alive again.");
				outputText("\n\nIt snaps in perfectly.");
				outputText("\n\nHis body begins to whirr and click, pieces moving into place as the soldier - North, was it - starts to power up.  With a final creak of his joints, he begins to stand up, stumbling at first, but ultimately landing upon his feat in triumph.  Squeaking up, he mutters what are probably the first words in a lifetime.");
				outputText("\n\n\"<i>Carol.</i>\"");
				outputText("\n\nYou shy a little wave in return, but he's already gone to ignoring you.  Searching around, he finds the object of his desire - the woman he had waited with for centuries.  His steps are slow and lumbering.  Whether it's the fault of his time spent in the ice or if he had always been this way is unknown, but regardless he crunches through the snow awkwardly and with great caution.  His movements grow more and more excitable - there's no doubt that he recognizes the resting giantess, but... something appears to be off.  You can't quite place it, so you walk towards them to investigate.");
				outputText("\n\nNorth shakes at the woman's resting head, trying with all his strength to wake her from her sleep, but her size just proves the feat to be near impossible to accomplish.  He resorts to pushing, to shoving, to beating at her forehead, but she doesn't move.  It's hit you, but you aren't sure whether or not it's quite hit him yet.");
				outputText("\n\nShe's already dead.");
				outputText("\n\nYou leap over to them, taking North's fists away from her gentle face.  He tries to retaliate, but he gives up in half-stride.");
				outputText("\n\nYou aren't sure how to respond, and the two of you are seated in silence for a long period of time.  His lover's hand remains outstretched, reaching for the place that her soldier had once lay still.  You want to speak, but North only tells you to leave, creaking over to her hand and resting in-between her cold palm.");
				outputText("\n\n\"<i>She didn't know,</i>\" he croaks.  \"<i>She didn't even know that I had always been watching her.</i>\"");
				outputText("\n\nHe wasn't dead. Only waiting, like her.");
				outputText("\n\nThe air remains cold and merciless, and regardless of what you do it would be difficult to stay for much longer.  Turning away, you trot silently back to your camp, wondering how things would've gone - if only you were quicker.");
				//[BAD END, Can no longer see the Old Woman or this series of events]
				flags[kFLAGS.GATS_ANGEL_DISABLED] = 1;
				doNext(camp.returnToCampUseOneHour);
			}
			//player.removeKeyItem("North Star Key");
		}

		//6. Corrupt End #1
		public function theWorstEndingEverDotJPG():void {
			clearOutput();
			//Requirements: Choosing [Fuck the Soldier] at the prompt
			outputText("Still listlessly spinning the windup key around your pointer finger, you gaze back down at the pile of armor buried in the snow.  A strange amount of curiosity surrounds this peculiar set of protection, only mounting the longer you stare at it.  It isn't like you owe anything to the slumbering titan.  Just what could she see in something a mere fraction her size?  Maybe this is some sort of dominating fantasy of hers; you've been around the block enough times to know that not everything is at it appears.  There's no telling just what she has in store for her little creation.  You may actually get to be a hero!");
			outputText("\n\nAnd, hey, if the windup key does fuck all, at least you get a free set of armor out of the deal!");
			outputText("\n\nWith your mind made up and your resolve firm, you set off to rescue the dormant soldier, sliding the key back into your pocket.  White powder flies one way and another as the inanimate prisoner is freed from its snowy confines, once again knowing open air.  You prop the set of armor up against your back, taking great care not to alert its captor of its daring escape.  You drape the arms up over your shoulders and scoop the legs into your arms, employing a generous piggyback ride to aid in your liberation.  You pay the giantess a final glance, a hint of doubt still lingering in confines of your judgment.  You assuage your hesitation with a quick hiking of your cargo, rushing down off the mountain.  The cold mountain wind once again shrouds the slumbering spirit from your peripheral vision, helping ease your conflict.");
			outputText("\n\nYou eventually reach the base of the mountain, free of the seemingly never-ending, blindingly white blizzard.  You take a few minutes to trot over to a clearing, your load lightly bouncing around behind you.  A nearby tree acts as the perfect prop for your friend as you turn in place and gently set down the suit of armor.  Eying over the lifeless pile of scrap, it appears as hollow to you as it did when you first saw it buried in the snow.  Even as you pull the beautiful little windup key back from your pocket, you're hesitant to believe something so simple could spark life back to this creation.");
			outputText("\n\nWith a hand propped over the soldier's shoulder, you guide the key back to a slot in base of the soldier's back and give it a quick turn, filling the air with a pleasant click.  You're taken by surprise as the suit begins to shudder and rattle, backing off of the little miracle to take in the sight.  The armor braces up against the tree, trembling as it slowly rises to its feet.  An ebony haze fills the interior of the once-hollow soldier, light wisps escaping from little cracks and openings as the shuddering soldier fills with what you presume to be life.  The construct finally settles and lifts its hand to its helmet, revealing a pair of minuscule, glowing orbs of gold staring back at you.  North has returned.");
			outputText("\n\n\"<i>Why have you dragged me down from the mountain?</i>\"");
			outputText("\n\nHis pleasant, innocuous tone takes you by surprise.  The soldier glances around lightly as you try to concoct some sort of response.  How does he know what you did?");
			outputText("\n\n\"<i>May I ask as to who you are?</i>\"");
			outputText("\n\n\"<i>Why, I'm the spirit,</i>\" you respond.");
			//[if (corruption > 49)
			if (player.cor > 49) outputText("  It seems like the best response to you for now.  Based on the giantess's sobbing soliloquy, you figure that standing in for the love of the soldier's life will get you straight to the action.");
			else outputText("  Wait, what?  It appears that in your desperation to contain the situation, your lingering doubt was enough to get you blurt out a bold faced lie.  You figure that you may as well roll with it for now.");
			outputText("\n\n\"<i>That can't be right.  Carol was lying beside me up on the mountain.  Then you came and dragged me away,</i>\" North replies, still as casual and calm as before.  Carol... you figure that must be the name of the spirit you left behind.  Without missing a beat, you devise an explanation consisting of dreams, loneliness and immeasurable amounts of time leading to North's obvious hallucinations.  Why would a spirit be so large and leave the two of you lost to a cold and forgotten mountaintop?  As North processes your explanation, you figure it best to just go straight for your coup de grace, insisting on the love between the two of you.");
			outputText("\n\nIt's hard to get a read on just what's going on in that tin-covered head of his.  In a last ditch effort to reign in the situation, you strip free of your [armor], accentuating ");
			if (player.hasCock()) outputText("[eachCock]");
			if (player.gender == 3) outputText(" and ");
			if (player.hasVagina()) outputText("your [vagina]");
			outputText(" to try and convince the confused soldier.  You look North over, figuring the best way to work him under your spell.  It isn't a long search, as you decide that his ");
			//[if (hasCock = true) 
			if (player.hasCock()) outputText("keyhole");
			//[if (hasCock = false) 
			else outputText("windup key");
			outputText(" would make a worthy candidate for your first alluring act of debauchery.");
			outputText("\n\nA playful, sly smile is the only hint you give to the strangely compliant tin man as you slink on around to his back, gracefully resting your fingertips upon his crystal key.");
			outputText("\n\n\"<i>What are you doing?</i>\" he asks, his tone still as polite and reserved as ever.  He doesn't react with much more than a sideways glance as you lurch the sizeable apparatus free of his backside.  ");
			//[if (hasCock = true) 
			if (player.hasCock()) outputText("You slide the key playfully down your wrist, rubbing your [cock] with your free hand.  You aren't entirely sure if he'll even feel a sensation from your penetration, but perhaps it'll at least get him in the mood.  With your manhood at full mast, you gently skirt along the edges of the keyhole.");
			else outputText("A mischievous tongue traces along the smooth, perfect surface of the windup key.  You promptly lower the makeshift toy precariously in front of your [cunt]; if there was ever a time to make a wind up pun or remark as some sort of goofy foreplay, now would be the time.");
			outputText("\n\n\"<i>This isn't right.</i>\"");
			outputText("\n\nNorth backs away from you, breaking the little amount of action you were trying to get started.");
			outputText("\n\n\"<i>You aren't Carol.  I know I'm not delirious,</i>\" he states plainly, staring at his metal hands.  \"<i>I need to go back to my love.  She... she...</i>\"");
			outputText("\n\nThe tin soldier begins to falter, having trouble standing as he paces back towards the mountain.  It's just then when you realize that the black mist making up his form appears to be dissipating.  He appears to be trying to fight it, but more and more of North's essence continues to escape from his metal confines.");
			outputText("\n\n\"<i>I-I need to check on Car... on Carol.  To make... make sure she's,</i>\" North takes one last gasp, his gentle tone finally beginning to crack, \"<i>...that she's not c-crying.</i>\"");
			outputText("\n\nWith one last forlorn outstretched arm, the suit of armor crashes to the ground, extinguished of its occupant.  You stand motionless, not sure how to react.  You glance down at the windup key in your hand.  Did... Was this your fault?");
			outputText("\n\nThere has to be more to it than this key.");
			outputText("\n\nYou slip it back into the armor's lock and give it another twist.  But nothing happens.");
			//[if (corruption > 49) 
			if (player.cor > 49) outputText("  ...Well, that was a waste of time.");
			outputText("\n\nThe key's glowing innards finally disappear, leaving a simple glass key jammed into tin.  It's a sad sight, one that you can't help but stand in silence over.");
			outputText("\n\nAfter a few moments, you decide to don your [armor] once again, leaving the mishap behind as you return to camp.  There's no telling if what you did was ultimately right or wrong in the grand scheme of things, but dwelling over North or Carol isn't going to get you anywhere any time soon.");
			//[if (corruption > 49) 
			if (player.cor > 49) outputText("  More importantly, you have some unsatisfied, pent up lust that you'd like to expend.");
			dynStats("lus", 2+player.lib/10+player.cor/10, "cor", 10, "resisted", false);
			doNext(camp.returnToCampUseOneHour);
			flags[kFLAGS.GATS_ANGEL_DISABLED] = 1;
			player.removeKeyItem("North Star Key");
		}


		//7. Corrupt End #2
		//Requirements: Choosing [Fuck the Angel] at the prompt
		public function fuckTheAngelBadEnd():void {
			clearOutput();
			outputText("The spirit lies comfortably upon the pillowy white ground, laying in wait for the moment she awakes to her mechanical lover.  Unfortunately, you're the one with the key.  The one with the fate of two lovers twirling around your finger.  They're both quite still, frozen upon your decision.  Well!  No need to wait any longer - there's fun to be had this winter, and the sight of that divine giantess is getting you antsy.");
			outputText("\n\nRunning towards the mocha-colored titan, you disturb the side of the mountain peak, causing lumps of snow to fall upon her head.  It's one way to wake her up for sure, as she slowly removes her head from the cliff's edge.");
			outputText("\n\n\"<i>Hnn... ? North, is that you?</i>\"");
			outputText("\n\nWoah, rude.  No, you aren't that mechanical dustbin, and as far as you're concerned the only name she should be pushing through those fat lips is yours.  Her jade eyes focus their gaze upon you, brightening when she realizes that you've brought back the key.  She motions for you to go by North's side with the tip of her finger, but you'd rather not comply.  Instead, you slap the tip of her digit to catch her attention.");
			outputText("\n\nUnderstandably, she doesn't quite know what you're getting up to, cocking the side of her head in confusion.  You dangle the key in front of her, before pretending to snap it in your hands.  The giantess cries out in surprise, reaching out before backing off as soon as you try it again.  She's completely at your mercy, unable to reach out and crush you without risking the safety of her lover's key.");
			outputText("\n\n\"<i>W-w-wait, what's going on?  What are you doing?</i>\"");
			outputText("\n\nHa, as if she doesn't know!  Flaunting those - literally gigantic - tits in front of you, expecting you to bend over and partake in a fetch quest to get her with someone else?  As if that was ever going to turn out for the better!  That metallic moron over there has been out of service for centuries, and you're sure as shit not about to find out how that relationship even works in the first place.  You tell the dumbass divinity about the exhausting, difficult journey that you had partaken on to obtain her lover's key.  The treacherous crystal cave submerged beneath a chilling pool of death.  All in all, a rather distressing adventure for all parties involved.  The titanic spirit stutters a few words of apology, but you shake your head.  You need something more than petty words, you know?  You need compensation.");
			outputText("\n\nCompensation only she can provide.");
			outputText("\n\nInnocent as always, you didn't really expect her to pick up the hint.  Your chocolate-colored goddess seems flustered and confused.  Of course, you are holding her tin soldier up for ransom, so it's only natural she'd respond with bewilderment and stress.  You tut - this isn't going to go anywhere without a push.  Grasping the key tightly with one hand, you tell her to rest her chin upon the cliff, and to open wide.");
			outputText("\n\nThe giantess has no choice but to comply with your odd demands, still unaware of the plans you have in store for her.  Her snow-dusted head rests against the edge of mountain, her cold, mint-like breath causing the vanilla ground to ebb and flow like a tide.  Pursing her lips, she impulsively licks them before opening her maw slowly, allowing her tongue to stretch out upon the ground.  You walk towards it, slowly removing your [armor].  The prospect of fucking someone's tongue seems interesting enough to grab your attention, and it isn't every day you run into a desperate spirit like this.");
			if (player.hasCock()) outputText("\n\nTaking out your junk");
			else outputText("\n\nCaressing your cunt");
			outputText(", you wander your way towards the giant's mouth-muscle, climbing on top of her warm, pink bed. There's gotta be some kinda magic involved - her mint saliva sends tingles through your body, while dragging your ");
			if (player.hasCock()) outputText(player.multiCockDescriptLight());
			else outputText(player.vaginaDescript());
			outputText(" against each bump and curve is beginning to get you hard.  She winces at the taste of your crotch against her tongue, though she's obviously never given oral to something with a heartbeat before.  Well, there's a first time for everything.");
			outputText("\n\nHer mouth is already lubricated with what appears to be chocolatey saliva, a sweet syrup coating your genitals with a cool, arousing fluid.  It's not hard to guess that her tongue might be incredibly sensitive, and every hump against it seems to be getting the giantess unconsciously excitable.  Her eyes begin to flutter and a groan escapes her lips, while you hug against each wave of her warm breath.  The hypersensitivity of her mouth-muscle begins to take control of her movements, the grinding of your ");
			if (player.hasCock()) {
				outputText("member");
				if (player.cockTotal() > 1) outputText("s");
			}
			else outputText(player.vaginaDescript());
			outputText(" along the softness of her maw causing her to twitch and drool uncomfortably.  You're beginning to fuck along her slowly, chuckling at every wince and moan she makes from the taste of your genitals.");
			
			outputText("\n\nOne of the giantess' hands moves slowly towards the top of her head - what could she possibly be planning, you wonder.  Your query is answered almost instantly as the tips of her fingers start to caress the lengths of her striped horns, and her unused hand drifts slowly beneath to pet the increasingly wet problem below.  It didn't take her long to forget that pathetic bin of a man!  If anything, the taste of your ");
			if (player.hasCock()) outputText("cock");
			else outputText("pussy");
			outputText(" seems to have awakened something inside of her.  Each breath of the jiggling giant intensifies, while her heaving breasts press up against the hard mountainside.  You thrust between the curves of her tongue, lapping at her chestnut saliva and caressing each bump and groove.  Her soft, candy-coated lips slowly descend every so often in an attempt to kiss you, to which you respond with slow licks of those luscious love-pillows.  Your titanic lover jerks slightly - she's dipped a finger inside of her slick honeypot, flowing freely to wherever her arousal will take her.  Taking to the tongue-fucking charade quite easily, you wonder if she's allowed her mechanical mate to blow one off on her blushing bronze face before.");
			outputText("\n\nDespite the increasing ecstasy wrought on by your talkbox-twiddling escapade, you snap back from your delirium to take notice of your lover's aroused antics.  The giantess pushes back and forth against another nearby mountain while furiously fingering her tight cunt.  Upon further inspection, a large curiously-shaped rock appears to be lubed up and ramming her from behind, pounding into her ample ass by her command.  Unable to resist any longer, she's taken to pleasuring herself from every angle, entrusting you to take command on her tongue.");
			outputText("\n\nThe grooves of her syrup-coated organ hum against your body, the chocolate-covered taste buds massaging your figure as you grind along them.  The vibrations drooling along your " + player.skinFurScales() + " appear to be coming from the snow-dusted girl herself, a result of her constant moaning from the good plowing she's receiving from behind.  Her fingers dance between her, now focusing on squeezing her cushiony tits together to rub her nipples against the hardness of the cliff's edge, while bending down further to fit more of the lubed-up loverock taking her from below.  In some form of ambrosia-induced harmony, you've allowed yourself to become a part of this incredibly orchestrated scene of scented fucking.");
			outputText("\n\nThe giantess' butt-drilling escalates with her hand ravaging the tight confines of her dripping pussy, attempting to cry words but unwilling to close her mouth on you.  It's amazing, this chance to drag your ");
			if (player.hasCock()) outputText("dick");
			else outputText("vagina");
			outputText(" on a person's tongue to fuck it thoroughly.  You wonder if she's already long forgotten the pile of bolts she was originally trying to save.  A man frozen in time, never to wake up because - whoops!  You're taking care of her needs now.  Maybe you'll invest in a giant goblin-built sex machine, who knows?  Judging by the bitch's aroused whines, she was probably waiting for the chance to strip for the next person to find her up the mountain.  It's about time she let herself go, after all.");
			outputText("\n\nYou grin at the thoughts pervading your mind, unaware of the intense pleasure building up in your junk - the sugary syrup coating the base of her mouth starts to force your [hips] to propel further, to splatter your love inside her.  It's almost automatic, the movement of your [hips] against each rubbery, vibrating protrusion tickling and fondling you while receiving satisfaction in return.  You're going to cum, and there's nothing stopping you now!");
			outputText("\n\nWith a jerk of your hips, you release your ");
			if (player.hasCock()) outputText("hot, white seed");
			else outputText("feminine juices");
			outputText(" all along her starving tongue, your eyes lifting up as you stretch to force as much as you can upon her.  A slick, stubby tendril fits between your [butt], while more of her taste buds rub against you in your squirting ecstasy.  Your ");
			if (player.hasCock()) {
				outputText(player.multiCockDescriptLight());
				if (player.cockTotal() == 1) outputText("throbs");
				else outputText("throb");
			}
			else outputText(player.vaginaDescript() + " throbs");
			outputText(", painting the giantess while she pants and moans, legs almost buckling from her own joy along with the taste of your mess inside of her.  She struggles to remove the makeshift dildo from her ass, resting her cheek against the size of the mountain let your concoction drool out.  Slipping out, you take the opportunity to grind up against her ruby lips, before cumming on her face.  She lets out a weathered smile, before her giant eyes focus once more on the mechanical soldier.");
			//[Next]
			menu();
			addButton(0,"Next",fuckTheAngelBadEndPartII);	
		}
		public function fuckTheAngelBadEndPartII():void {
			clearOutput();
			outputText("It shakes, and - wait, it's shaking?  You walk towards him, still naked from your recent session with his lover.  It appears to be vibrating with a sense of... sadness, you'd guess.  You look inside, but nothing can be found.  Was it really dead, or just unable to move?  It soons stops though, and both you and the giantess stare at the cold figure of the soldier.");
			outputText("\n\nOf course, you kick it over, while it thumps into the snow.  Whatever it was doing before, it's certainly gone now.  You turn back to your new lover, and - oh no.");
			outputText("\n\nShe's sobbing, and it's hardly a light drizzle, either.  Her eyes are filled with a watery melancholy that you haven't quite seen before.  She spits, trying to regain her composure.");
			outputText("\n\n\"<i>He was watching the entire time.</i>\"");
			outputText("\n\nShit, you think.  He could've joined in.  There's no use consoling her now, she's an absolute mess at the sight of her dead mate.  Though she effectively killed the mood, you walk towards her, in hopes for another round.  The angelic woman only glares at you, but the circumstances won't let her be angry for long.");
			outputText("\n\n\"<i>Give me one reason why I should not crush you right now.</i>\"");
			outputText("\n\nNope, she's still angry. It's time to go. Taking your [armor] with you, you make a run down the side of the high mountain, throwing the key off the side of the cliff as you hear the distraught damsel cry into the skies. The mountains tremble in fear, and a snow storm begins to brew.");
			outputText("\n\nThankfully, you're out of that mess and heading for camp. That slut is cold.");
			//[End of event. Possible expansions include finding her as a difficult combat encounter, or raping her while she sleeps.]
			flags[kFLAGS.GATS_ANGEL_DISABLED] = 1;
			player.orgasm();
			dynStats("cor", 10);
			doNext(camp.returnToCampUseOneHour);
		}

		//8. Good End
		public function goodEndForChristmasMiracleICant():void {
			clearOutput();
			//Requirements: Choosing [Give the Key] at the prompt
			//completely fucking tender let's get moe
			outputText("After everything you've heard, the decision seems clear enough.  Holding your prize above your head, you start forward, calling to the gargantuan woman to announce your successes.  Her eyes flutter open at your voice, and she raises her head to regard you.  Seeing the key to her love (both metaphorically and physically), her expression brightens exponentially.  She beams a brilliant and nearly blinding grin, allowing herself hope for the first time in quite a while.  \"<i>[name], did you... could you have...</i>\"");
			outputText("\n\nYou smile back at her even as you move towards her beloved construct, considering your actions to have much more impact than anything you might try to say.  With the giantess looking on, tears still ringing her eyes and hands clenching and unclenching in nervous anticipation, you reach the motionless tin knight.  You kneel to inspect him for hints on how to proceed, but the solution stares you in the face almost immediately: a hole square in the construct's back.");
			outputText("\n\nSmiling wryly at the luck, you ready the fancy-looking wind-up key and gently slide the instrument into the designated receptacle, nodding in satisfaction at the snug fit.  Glancing over your shoulder at the nervous entity behind you, you take a steadying breath and... turn the key.");
			outputText("\n\nClick.");
			outputText("\n\nThe sound, while small, resounds around the mountains in an extended echo, both of you holding your breath and uttering nary a whisper.  A shudder runs through the armor, snow sliding off the cold metal to pile up around it.  The soldier, North, sits up a little straighter, metal creaking against itself as he turns toward you.  The hollow gloom within gives way to a swirling obsidian cloud, and two shimmering dots of gold peer at you from its midst.  North stares at you for a moment, then turns his gaze skyward, meeting the gaze of the colossal girl.");
			outputText("\n\n\"<i>Hello,</i>\" North says softly, his hard exterior belying the gentle and peaceful tone of his voice.  Almost musical, you muse.  \"<i>I know you.  But...</i>\" he transfers his gaze back to you.  \"<i>I don't know you.  What do they call you?</i>\"");
			outputText("\n\nAdmittedly a little off-guard by his forwardness, you offer him a hand to help him rise while introducing yourself.  Surprisingly enough, he weighs much less than you would imagine, and he climbs to his feet easily enough.");
			outputText("\n\n\"<i>... Interesting,</i>\" he replies, tilting his head slightly as he continues to regard you.  You can't be sure, of course, but it seems like he's smiling - or at least as close to smiling as he can get with only eyes and that strange, assumedly magic fog roiling within his helmet.  Moving past you, North walks to the edge of the precipice, standing passively as his creator loomed over him.");
			outputText("\n\nFor many moments, they simply stand silently, until finally, the knight speaks.  \"<i>I'm back,</i>\" he declares lamely.");
			outputText("\n\nBefore either of you can react, one of her enormous hands sweeps down, snatching North up and bringing him to her lips.  Overwhelmed with emotion, the giantess lays kiss after kiss on the poor knight before hugging him to her breast and not letting go for many heartbeats.  Somewhat sheepishly, she replaces North on the outcropping, falling back and fixing her little creation with a hopelessly passionate gaze.  \"<i>Oh, North, my brave, sweet knight,</i>\" she sighs, struggling to keep her voice from cracking with her relief.  \"<i>Thank you so much, hero,</i>\" she continues, directing her appreciation towards you.  \"<i>I had almost given up my singular desire, but you somehow managed... Thank you...</i>\"");
			outputText("\n\nYou begin to retort with some modest response, but a small groan from North drags both your and the giantess's eyes to the knight.  As you watch, despite the magic most certainly injected into his being, the knight's form falters; his eyes dim and nearly wink out, and his movements become more and more sluggish as he struggles against his sudden lethargy.  You hasten to him as quick as you can manage, and the woman falls forward with an awful cry.  However, it seems the key is still firmly attached to his back, and that seemed to be the only thing that could have gone wrong.");
			outputText("\n\nThe giantess casts around desperately for something, anything to prevent her love - her creation - from leaving her again, but only peaks and snow greet her from any direction.  With another anguished scream that reverberates around the range, she scoops both of you up, cupping her hands and raising her knight and his rescuer up to her eyes.  Giant tears threatening to spill down her cheeks, her sobs renewed twice over, she stares helplessly as the light of life fizzles in North's eyes.");
			outputText("\n\nSomething changes in her eyes abruptly, however. Inspiration and determination replace desperation and panic in her visage.  \"<i>[name], quickly, sit North up.  I have no promises, but I have... an idea.</i>\"");
			outputText("\n\nYou doubt anything she does could help the poor, silent knight more than the magic key, but you oblige, pulling him up and facing him squarely to the spirit's face.  With only a moment of hesitation, she leans forward.  Remarkably, her lips almost seem to shift in tint, moving from pinkish blue to, apparently, pure white as she comes.");
			outputText("\n\nShe plants another kiss on her dying knight's visor - instantly, the air around you seemingly densifies, charged with surprising amounts of divine energy.  The pearly coloration of her lips crawls from her onto the metal, cascading down North's body.  The giantess's brow furrows as she concentrates her energy, forcing all of her energy from herself onto and into her love.  Finally, his entire ensemble dyed a magnificent and resonant alabaster, she leans back, eyeing you both with concern.");
			outputText("\n\nSuddenly, impossibly, North moans, shuddering into your hands as you continue to prop him up.  His eyes flare back to life, coiling inky cloud flowing into full form once more.  The giantess, looking as exhausted as she does relieved, sets you and North back down onto the cliff-face, taking extra care to set her revived creation down as gently as possible.");
			outputText("\n\n\"<i>Why am I still here?</i>\" North asks dreamily, disoriented and dazed from the morbid tug-of-war.  He glances down at his gauntlet.  \"<i>And why am I white?</i>\"");
			outputText("\n\nYou would like to know the same, in fact, and you look to the tearful woman in a bid for an explanation.  It's only then that you notice a lack of something you mostly took for granted until this moment: the ever-present swishing of her assumedly invisible wings.  Combining this observation and the sudden hint of haggardness in her features, you begin to put the pieces together.  She smiles wearily, nodding as if reading your thoughts.  \"<i>I fear to admit, you most likely can guess the reason for North's revival,</i>\" she says.  \"<i>Spirits possess a limited grasp of clerical ability, but certainly nothing applicable to poor North... at least, not until you acquired that key.  It's hard to explain, but a bit of... humanity, I suppose, was 'injected' into his body when you turned that key.  I knew this was a one-off chance to begin with - it's been subjected to age for centuries, and most of the magic must have been either relocated or removed.  I had to get more drastic, I'm afraid.  I am happy to say I do not regret my decision, but... well...</i>\"");
			outputText("\n\n\"<i>I am not an spirit anymore.</i>\"");
			outputText("\n\nThere it was; North wheezes in an approximation of a gasp, and you're profoundly reminded of the devotion from creator to creation.  You ask her what the loss entails.");
			outputText("\n\n\"<i>Ah... well, I suppose the most profound result is the loss of immortality,</i>\" she explains.  \"<i>While the key sparked his soul, I simply kept the flame going longer with my own... adding fuel, you could say...</i>\"");
			outputText("\n\nShe meant to go on, but North interrupts her.  \"<i>Wait,</i>\" he demands.  The giantess's train of thought is brought to a halt as she waits for her creation to proceed.  \"<i>You did this for me,</i>\" he begins, pulling himself to his feet.  \"<i>I don't have to know why, though I'm sad you had to.  I love you.</i>\"");
			outputText("\n\nThose three words, mentioned so suddenly, pierce the woman's heart as surely as any arrow, and hot tears finally track down her cheeks - not the bitter tears she barely choked back earlier, however.  She weeps now with one of the most profound expressions of pure joy you've ever experienced.");
			//{turn the page}
			menu();
			addButton(0,"Next",goodEndForChristmasMiracleICantII);
		}

		public function goodEndForChristmasMiracleICantII():void {
			clearOutput();
			outputText("North throws his arms out wide, armor hardly protesting to the sudden movement.  The action gives the giantess pause for a moment, but she swiftly understands the motivation and raises her hand to the beckoning knight.  She crooks her little finger toward North, and he throws himself around it, expressing his feelings in a tight and passionate hug.  The giantess gazes down at her little knight with a loving smile, and they hold the pose for a remarkably long time.");
			outputText("\n\nThe seemingly divine titan worryingly crooks her eye over to you, and in an attempt to shoosh you away, she nods her head towards the mountain's exit, implying that they're going to spend some time to themselves. Of course, there's a chance you can probably stick around for some weird-ass action. Would you prefer to stay behind, or do you excuse them temporarily?");
			menu();
			addButton(0,"Stay",stayForPretendNTRGoodWinjobSex);
			addButton(4,"Leave",goodEndLeaveBeforeSexings);
		}

		//If Leave
		public function goodEndLeaveBeforeSexings():void {
			clearOutput();
			outputText("You get the message, feeling that letting them do their own thing might be for the best.  With a hasty pardon, you promptly turn around and walk a good twenty yards down the mountainside, idly playing in the snow while the two reunited lovebirds do their thing.");
			outputText("\n\nYou hear the sound of a gentle humming in the distance, and you figure that the two lovers might be quite done with their 'honeymoon'.");
			//[Go to Conclusion]
			menu();
			addButton(0,"Next",conclusionOfGiantessGoodEnd);
		}
		//If Stay
		public function stayForPretendNTRGoodWinjobSex():void {
			clearOutput();
			outputText("You prefer to stay here, but the frosty giant has already gone back to her mechanical man, so you hold your explanation and continue to observe.");
			outputText("\n\nFinally, she draws away, North reluctantly releasing his hold on her pinky.  The giant woman unexpectedly groans, running her arms from her chest to what you could only assume to be her waist - you can't exactly see from your current perch, and as you wish to remain as impartial a bystander that you can in this situation, you don't bother inching to the edge of the cliff.");
			outputText("\n\nHer shoulders shift back, and with a little grunt, she... begins to raise herself, by the looks of it!  She shuffles back as her hips rise, lifting her butt above the cliff, and then slamming the soft pillows against the rock.  While it groans in protest, the overhang holds the weight well enough, leaving you and North face-to-face with his lover's titanic undercarriage.");
			outputText("\n\nHoisting herself up with her arms, the giantess peers over herself to get a good look at you, saying, \"<i>Having you back reminds me of so long ago, my big, strong knight.  [name], we had this trick we used to do... it's definitely a bit embarrassing, but since you did so much for us, your presence bothers me not at all.  Come to me, North, just like we used to...</i>\"");
			outputText("\n\nNodding calmly like he is wont to do, North steps forward until he's practically bumping into her anal star, then kneels, adopting a meditative pose.  You look on curiously, then blink your surprise when his armor trembles.  Out of the visor slot of his helmet flows North's ebony essence, drifting from his newly white 'body' straight towards his giant lover.  The gaseous black cloud makes a beeline for her swollen pubic mound.  Aiming only to please, North swirls and curls around the giantess's clitoris, and she nearly knocks her knees together with the pleasure tremors that jolt through her body.");
			outputText("\n\nThat being accomplished, the knight kicks his applications up a notch, breaking away from the throbbing and stimulated button and zooming straight toward the depths of her glistening and inviting folds.  She coos throatily, back arching and tongue lolling, as North penetrates and wriggles further into her pussy.  Blossoms of fog issue from the giantess's mouth with increased frequency as North tunnels deeper and deeper inside her; you idly marvel at how effective the little knight's tactics prove on his enormous lover.");
			outputText("\n\nWith a cry of simple pleasure, the giantess's arms buckle under her and she falls back, tumbling from her perch on the cliff and landing back-first.  Unable to sit idle while North has all the fun, she takes matters in her own hands, cupping a breast in one hand while the other slips down between her legs.  Her moans only intensify once she gets into the squeezing and caressing, scattering snow in all directions as she squirms along the valley, crying her pleasure for all to hear.");
			//LUST GAIN +20: IF 100:
			dynStats("lus", 10+player.lib/10, "resisted", false);
			outputText("\n\n");
			if (player.lust >= player.maxLust()) {
				outputText("Despite yourself, your hands slowly begin crawling into your [armor] in pursuit of your naughty bits.  ");
			}
			outputText("\"<i>Aaaahn, North, you haven't lost your touch,</i>\" the giantess moans, kneading deeply into her chilled titflesh and barraging her already-titillated tunnel with three slender fingers.  Even from your position from on high, you can hear the squelches of her very well-lubricated fingering, and before you know it, the bottom part of your [armor] is off, and you're openly toying with your genitals, spurred on by the passionate internal embrace of the giant woman and her loving creation.");
			outputText("\n\nWithout notice, the sexually belaboured titan howls with newfound fervor.  Her breasts shudder noticeably, her already dusky breast-skin darkening slightly as their churning contents shift in composition.  The giantess's fingers fly from stroking her womanhood to grabbing the other breast, a line of glistening femcum trailing from her fingers and splattering against the mountains.  Efforts redoubled by her two-handed grip, she writhes in absolute orgasmic bliss even as her bosom swells up a bit.");
			outputText("\n\nYou can easily guess what's coming, even before the giantess's frenzied gasps give way to an almost anguished shriek of ecstasy.  Her butt rises off the ground, then slams back down, sending a snowy shockwave out in all directions and doing absolutely marvelous things to the suddenly-oscillating ass-flesh.  Even with the chilly breeze making sure her nipples will stay perpetually rock-stiff, you can see them puff up further and wiggle ominously from your perch.  Sure enough, her internal valves burst open, and twin geysers of milk - white, but a shade darker than what one would expect - spray into the air.");
			//IF LUST 100:
			if (player.lust >= player.maxLust()) {
				outputText("\n\nHer powerful climax nearly shakes the very bluff you're standing on, and the event is enough to force you over the edge");
				if (player.wetness() >= 4 || player.cumQ() >= 1000) outputText(" - figuratively, and literally, as well, as your fluids drip off the edge to add to the rain of sexual fluids the giantess is laying in the midst of");
				outputText(".");
			}
			outputText("\n\nFor many heartbeats she lays panting, basking in the afterglow of her and her lover's first outing in a long, long time.  Eventually, a stirring in the breast-milk coating her and the ground around her rouses her from her peaceful contemplations.  Just as you suspected, North had internally traveled from her vaginal passage to her enormous breasts, and escaped with the boobgasm that followed.  His shadow-essence separates from its milky prison to reform near the giantess's cheek.  She smiles warmly at him, and he hugs her cheek in response.");
			outputText("\n\nWith North in tow, the giantess lifts herself back up onto the cliff, allowing the knight to retreat back into his ashen armor.  He turns towards you, his golden orbs slightly eclipsed in what you can only assume to be his form of a happy expression.  \"<i>Thank you, hero,</i>\" he says, only managing the brief courtesy before he's swept up into his lover's arms and smashed against her cheek once more, in an even bigger and more passionate hug.");
			//IF MASTURBATED: 
			if (player.lust >= player.maxLust()) {
				outputText("\n\nYou take the opportunity to do up your [armor] before either of them notices.");
				player.orgasm();
			}
			//[Next]
			menu();
			addButton(0,"Next",conclusionOfGiantessGoodEnd);
		}

		//[Conclusion]
		public function conclusionOfGiantessGoodEnd():void {
			clearOutput();
			outputText("The air is crisp, and the light powdering of snow floats through the air as if playing an invisible melody.  The warm couple are together.  Lifting her head, the giantess beams at you with a refreshing sense of spirit.");
			outputText("\n\n\"<i>I can't believe anything that has happened to me today... it's all thanks to you.  Thank you for bringing North back to me, and thank you for relighting a fire that had gone out so, so long ago.</i>\"");
			outputText("\n\nYou bow in some sense of obligation, yet the chestnut titaness giggles at your formality.  North automatically returns the gesture, and you all share a moment of laughter.  The mechanical soldier is lifted up by her lover and placed upon her shoulder, his legs dangling off the edge.  You give them a friendly nod and a happy smile before realizing how tired you were after this whole affair.  Telling the two as much, you chuckle victoriously, proud of your exploits and of the potential stories you could tell regarding the reunion of an spirit and her favorite little soldier.");
			outputText("\n\nThey both bid you farewell as you begin to walk off, North waving his arm far above his head and the tanned former spirit politely swaying her hand at the wrist.  With a reciprocated adieu, you turn and stride away.  \"<i>Oh, [name]!</i>\" the giantess calls, and you turn curiously to find her extending the little crystal key to you, clasped between two of her fingers and looking absolutely minuscule by comparison.  She easily reaches you despite the distance gained by your strides, and you receive the device readily.  \"<i>I want you to have this. Merry Christmas, [name].</i>\" You wish her a Merry Christmas in response, though call up blanks when trying to remember her name - It's then you realize that she had never given it in the first place. The spirit stops and laughs before pulling a thumbs up, just as you had done earlier.");
			outputText("\n\n\"<i>It's Carol.</i>\"");
			outputText("\n\nAfter a long pause, you pocket the key, square yourself with Carol and North, returning her hand gesture before giving them a goofy grin that positively sparks in the snow-cushioned landscape.  As you turn to depart once more, you wave over your shoulder, escorted out with the continued giggles and lovey-dovey conversation of the unlikely couple.");
			outputText("\n\nMerry Christmas indeed!");
			//[if you haven't been introduced to christmas via elf or otherwise] 
			if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] == 0) outputText("\n\nYou have no idea what that is.");
			awardAchievement("A Christmas Carol", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_II);
			if (player.findPerk(PerkLib.AChristmasCarol) < 0) {
				player.createPerk(PerkLib.AChristmasCarol, 0, 0, 0, 0);
			}			
			//[end, get The North Star & A Christmas Carol perks]
			//The North Star
			//Witness picnic events with North & Carol at the High Mountain.
			//A Christmas Carol
			//Christmas events are open all year 'round! (some sort of arbitrary limit)
			//merry christmas everyone <3
			flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
	}
}