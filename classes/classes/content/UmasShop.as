package classes.content 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * Whee!
	 * (No @ tag for coder)
	 * @author Gedan
	 * @author QuietBrowser, ???
	 */
	public class UmasShop extends BaseContent
	{
		public function UmasShop() 
		{
			
		}
		
		/**
		 * First time scene entering le shoppe
		 */
		public function firstVisitPart1():void
		{
			clearOutput();
			
			outputText("You make your way Uma’s shop.  It is close to Loppe’s house");
			
			// Added some shit for variance if the players not (presumably) sexed up Loppe too much in the past.
			if (flags[kFLAGS.LOPPE_TIMES_SEXED] <= 3)
			{
				outputText(" but you've never noticed the quaint storefront before.  ");
			}
			else if (flags[kFLAGS.LOPPE_TIMES_SEXED] <= 8)
			{
				outputText(" and the homely building building has caught your eye once or twice in the past.  ");
			}
			else 
			{
				outputText("and from there you’ve seen the humble exterior many times.  ");
			}
			
			outputText("“Kemono’s Oriental Clinic” is written on a wooden board above the entryway.  “<i>Sugar, you coming?</i>”  Loppe asks, breaking you out of your reverie.  “<i>Come on in!</i>”  Loppe holds the door open to you.\n\n");
			outputText("You follow the laquine inside; the interior is similar to Loppe’s house, including the strange internal hallway, but the waiting room outside is light and airy.  Windows are adorned with multiple elaborate windchimes, which tinkle and clatter softly as a cooling breeze drifts through the house. A huge shelf dominates one wall, covered in - you find yourself double-checking - what look like tiny, miniature versions of trees.  A nondescript statue-fountain stands in one corner, water welling from its tip and flowing gently down its sides to create a calming sound.  In another corner, there is a small garden of colorful, polished stones and soft white sand.  Multiple lushly-cushioned chairs complete the room, obviously a waiting room - a dense bead curtain cordons off a doorway leading deeper inside the building, and Loppe’s mother must clearly lie beyond.\n\n");
			outputText("“<i>Mom, are you busy?!</i>”  Loppe yells.  “<i>Just a second, dear!</i>”  You hear a melodic, feminine voice reply.\n\n");
			outputText("Out of the bead curtains emerges a dog woman; her fur looks ruffled in places and she has a silly smile plastered on her face, her hair seems to be in disarray.  She briefly glances at you and Loppe, and only greets you two with a brief wave and a giggle before going away.  You wonder what could’ve happened beyond those curtains....\n\n");
			outputText("Loppe giggles and gives you an “I told you so” look.\n\n");
			outputText("Before you can think to respond to her, the beads part and a new figure emerges.  She’s one of the many anthropomorphs who inhabit this city, a bipedal humanoid horse with unmistakable human features.  She’s huge, easily seven feet tall, certainly far bigger than the half - horse who brought you here, with full, round breasts and wide womanly hips clearly delineated by the strange dress that she wears, which is a rich blue with a pattern of white snowflakes on it.  She looks "); 
			
			// Assuming Uma is ~7' tall == 84". 6" leeway for the variants or more? PAGING FENOXO!
			if (player.tallness < 78)
			{
				outputText("down at you");
			}
			else if (player.tallness < 90)
			{
				outputText("straight at you");
			}
			else
			{
				outputText("up at you");
			}
			
			outputText(" with a soft expression; her features are maternal and friendly, but there’s a playful twinkle in her eye that makes her look younger than she really is, and for all that she’s clearly a mature woman, she’s still strong and attractive.  Black hair, starting to go gray at the tips, is worn in a long, elegant braid, the end knotted around an elaborate butterfly hairpin, while her fur is a beautiful shade of chestnut brown and her large eyes are a deep brown, almost black.  She casually flicks an equine ear in a manner that reminds you very much of Loppe, and you have a strong feeling that this is Uma, Loppe’s mother.\n\n");

			// Tempted to scene-break here
			
			menu();
			addButton(0, "Next", firstVisitPart2);
		}
		
		public function firstVisitPart2():void
		{
			clearOutput();
			
			outputText("Loppe bounces up towards the tall equine and they embrace in a friendly hug.  “<i>Hi, mom!</i>”  Uma laughs softly before replying, “<i>Hello my little horsey hopper.  Who is this?</i>”  She asks, looking at you.\n\n");
			outputText("You politely offer Loppe’s mother your name, telling her that you’re a... friend... of Loppe’s.\n\n");
			outputText("Loppe looks at you with disdain, then adds, “<i>Yes, [he]'s a friend alright...</i>”  Loppe clears her throat.  “<i>Mom, I would like to introduce you to [name], my [boyfriend].</i>”\n\n");
			
			// Tempted to add in some variance shit here for corrupt/times-sexed stuff, like low corrupt/low sex count.
			// Loppe's revelation about your apparant relationship comes as something of a shock to you, but you try - and fail - to hide the suprise from your face." etc
			outputText("Uma looks between the two of you with interest.  “<i>[Boyfriend] huh?  So it’s you whom I have to thank for the broken springs in Loppe’s bed?</i>”  Uma says with a smile, offering you a hand.\n\n");
			outputText("You give her a winning smile back and accept it, wondering if you should prepare yourself for a macho-type squeezing match.  Even as you shake her hand, you apologise, telling her it wasn’t your intention to make Loppe’s bed need replacement springs.\n\n");
			outputText("Loppe and Uma look at each other and then they both burst out laughing.  “<i>Oh, sugar... you’re so silly,</i>”  Loppe says.  “<i>[name], I’ve learned a long time ago that Loppe’s beds must be war and waterproof.  So I’ve had her bed custom-made; you could have an army of minotaurs stomp that bed and it wouldn’t even bend.</i>”  Uma says with a grin.\n\n");
			outputText("You give them your best confused expression, realising that Uma and her daughter must have similar tastes in humor; she was evidently joking with you.\n\n");
			outputText("Uma is the first to break the awkwardness.  “<i>Well then... care to give me the details?  How did you two meet?  When did you start fooling around?  Has my daughter worked so hard you had to seek a healer yet?</i>”\n\n");
			outputText("Loppe holds your hand and the two of you begin detailing how you met....\n\n");
			
			menu();
			addButton(0, "Next", firstVisitPart3);
			

		}
		
		public function firstVisitPart3():void
		{
			clearOutput();
			
			outputText("“<i>I see... that is so like my daughter to do something like that.</i>”  Uma glares mischievously at Loppe.  “<i>Aww mom... cut me some slack!</i>”  Loppe protests, playfully.  You can’t resist laughing softly at the two; it reminds you of people back in Ingnam... albeit they’re joking about subject matter you’d normally not touch back in your world.</i>\n\n");
			outputText("Your conversation is interrupted when a cat man enters the clinic.  “<i>Umm... hello?</i>”  He says, shyly as he enters.  Uma turns to you.  “<i>You’ll have to excuse me, but I must get back to work.</i>”  Understanding that Uma is currently working, you politely step back and watch as Uma walks to attend to her client.\n\n");
			outputText("“<i>We should go, sugar.</i>”  Loppe whispers in your ear.  You nod to her, tell Uma that it was nice meeting her, and indicate Loppe should lead you out. You follow the Laquine out of the building, and tell her that her mother is a nice woman. “<i>Yeah, she is nice, she’s just a little... quirky.</i>” Loppe agrees. “<i>And I think she likes you too, sugar; nice work.</i>” She grins, patting you on the shoulder.\n\n");
			outputText("You tell her that you’re glad, but you have other things to do, so you’ll catch her some other time. “<i>Alright, sugar,</i>” Loppe agrees, “<i>see you around.</i>” With that, she turns and walks away back in the direction of her home, leaving you to start heading back to what passes for yours in this world.");

			// Flag the shop visit
			flags[kFLAGS.UMA_PC_FOUND_CLINIC] = 1;
			
			// Player returns to Camp
			menu();
			doNext(13);
		}
		
		/**
		 * Repeat visits.
		 * @param returnedTo	Indicates the "entrance" mode. false = came here from an external menu, true = backed out from one of Uma's options
		 */
		public function enterClinic(returnedTo:Boolean = false):void
		{
			clearOutput();
			
			// Hide the stuff that dun make no sense if you're dropping back from a menu inside the clinic
			if (!returnedTo)
			{
				outputText("You decide to pay Uma a visit at the clinic, so you follow the way through the streets to the apparently humble clinic.  Once there, you open the door and enter.\n\n");
				outputText("The interior of Uma’s clinic is as calm and quiet as usual.  There don’t seem to be any customers present at this moment, and you announce your presence by knocking gently on a counter.  The tall horse-woman walks softly out through the beaded curtain, giving you a friendly smile.\n\n");
				outputText("“<i>Why, if it isn’t my little girl’s special someone.  What brings you here, hmm?  Wanted to try my services?  A friendly little chat?  Or...</i>” She saunters confidently over to you and gives you a knowing grin. “<i>I bet my loose-lipped little Loppe has hinted that I’m not currently seeing anybody, hmm?  Is that why you’re here - you wanted to see how the mother measures up to the daughter?</i>”  "); 
			
				if (player.femininity >= 80)
				{
					outputText("You notice her giving you a very approving appraisal at the thought."); 
				}
			}
			else
			{
				outputText("“<i>So then, [name], what can I do you for?”  She flashes you a knowing grin, the innuendo clearly intended.");
			}
			
			menu();
			addButton(0, "Massage", massageMenu);
			addButton(1, "Acupunct.", accupunctureMenu);
			addButton(2, "Talk", talkMenu);
			addButton(3, "Sex", sexMenu);
			addButton(4, "Train Loppe", trainLoppe);
			addButton(9, "Leave", telAdreMenu);
		}
		
		/**
		 * MASSAGEU
		 */
		
		/**
		 * Primary massage intro & selection menu
		 */
 		public function massageMenu():void
		{
			clearOutput();
			
			outputText("You ask if she’d like to have a little business? You could really use one of her famous massage sessions.\n\n");
			outputText("“<i>Of course, dear.  I have a selection of a few types of special massages I can give you, but you’re only able to keep the effects of one of them, can’t risk disturbing your flow of chi, right?</i>”  She says, smiling happily.  “<i>Here’s the list.</i>”  She hands you over a small catalogue with her available massages.\n\n");
			outputText("You study the catalogue, noting the description of each one as you do so...\n\n");
			outputText("“Your libido getting you down?  Find that it’s just too easy for you to get turned on?  This special massage will help make you too relaxed to get horny for a few hours.”  Reads the first one.\n\n");
			outputText("The second one, on the other hand, states, “Want to get into the mood for some special fun, but finding it a challenge?  This special massage will get you primed and ready for some sweet, sweet loving.”\n\n");
			outputText("“Feel good and look better with this special modelling massage; the boys, girls and herms will be drooling over you while it lasts.” Reads the third; you’re not surprised that most of them seem to have some sexual benefit.\n\n");
			outputText("“Muscles sore and aching?  Weary down to your bones?  A nice relaxing massage can alleviate your pain and fatigue, and help you unwind more effectively.” Is how the fourth option describes itself.\n\n");
			outputText("Finally, the last message in the catalogue reads, “Need a little more power?  Going to have a fight on your hands soon?  With the special arts of do-in, we can boost your muscles and let you deliver a real knock-out punch - it doesn’t last forever, so be careful!”\n\n");

			outputText("You contemplate your choices carefully.");
			
			menu();
			addButton(0, "Relief", massageRelief);
			addButton(1, "Lust", massageLust);
			addButton(2, "Modelling", massageModelling);
			addButton(3, "Relaxation", massageRelaxation);
			addButton(4, "Power", massagePower);
			addButton(9, "No Thanks", massageNope);
		}
		
		/**
		 * Player changed mind about MASSAGEU TIEMU
		 */
		public function massageNope():void
		{
			clearOutput();
			
			outputText("You apologise and tell Uma that you’ve changed your mind, you don’t want to get a massage at this moment in time.\n\n");

			outputText("“<i>Very well, dear.</i>”  Uma takes the catalogue back.");
			
			menu();
			addButton(0, "Next", enterClinic, true);
		}
		 
		/**
		 * Player chose "Relief" massage
		 * Adds a 10% reduction to lust gain while active.
		 */
		public static const MASSAGE_RELIEF:int = 0;
		public static const MASSAGE_RELIEF_BONUS:Number = 0.9;
		private static const MASSAGE_RELIEF_BONUS_TEXT:String = "<b>(10% Reduction to all Lust gains whilst active!)</b>";
		public function massageRelief():void
		{
			clearOutput();
			
			outputText("You tell Uma that you’re interested in the lust-relieving massage.\n\n");

			outputText("“<i>Are sure about that honey?  Wouldn’t that make it hard to keep up with my little Loppe?</i>”\n\n");

			outputText("You admit that it may, but you feel you could use it.  Besides, you do spend most of your time out in the wilderness; the people (and you use the term loosely) out there aren’t quite as understanding about sex as Uma’s daughter is.\n\n");

			outputText("“<i>I see... come along then.</i>”  Uma motions for you to follow her.  You nod and promptly do as she asks.");
			
			massageMain(MASSAGE_RELIEF);
		}
		
		/**
		 * Player chose "Lust"
		 * Adds a 10% increase to lust gain while active.
		 */
		public static const MASSAGE_LUST:int = 1;
		public static const MASSAGE_LUST_BONUS:Number = 1.1;
		private static const MASSAGE_LUST_BONUS_TEXT:String = "<b>(10% Increase to all Lust gains whilst active!)</b>";
		public function massageLust():void
		{
			clearOutput();
			
			outputText("You tell Uma that you’re interested in the arousal-inducing massage.\n\n");

			outputText("“<i>Oh... feel like getting some help handling my little Loppe, perhaps?</i>”\n\n");

			outputText("You give her a playful smile and wink and tell her that’s none of her business.  Can she help you?\n\n");

			outputText("Uma gasps in mock hurt.  “<i>Are you doubting my skills, dear?  Of course I can help you!  Follow me.</i>”  Uma motions for you to follow her, and you trail along behind the mare masseur.\n\n");
			
			massageMain(MASSAGE_LUST);
		}
		
		/**
		 * Player chose "Modelling"
		 * Adds a +10 bonus to femininity?
		 */
		public static const MASSAGE_MODELLING:int = 2;
		public static const MASSAGE_MODELLING_BONUS:int = 10;
		private static const MASSAGE_MODELLING_BONUS_TEXT:String = "<b>(+10 Bonus Femininity whilst active!)</b>";
		public function massageModelling():void
		{
			clearOutput();
			
			outputText("You tell Uma that you’re interested in the attractiveness-boosting massage.\n\n");
			
			// Not too sure where "androgynous < female" falls on the official scale~ PAGING FENOXO!
			if (player.femininity <= 60)
			{
				outputText("“<i>I can see why you want this one, you could use a few touches to make you cuter, dear.</i>”\n\n");
			}
			else
			{
				outputText("“<i>Personally I think you’re pretty enough as you are, but a few extra touches can’t hurt, right dear?</i>”\n\n");
			}

			outputText("You thank her for the professional opinion, and indicate she should lead the way.\n\n");
			
			massageMain(MASSAGE_MODELLING);
		}
		
		/**
		 * Player chose "Relaxation"
		 * Add a 10% reduction in damage taken?
		 */
		public static const MASSAGE_RELAXATION:int = 3;
		public static const MASSAGE_RELAXATION_BONUS:Number = 0.9;
		private static const MASSAGE_RELAXATION_BONUS_TEXT:String = "<b>(10% Reduction to all Damage taken whilst active!)</b>";
		public function massageRelaxation(): void
		{
			clearOutput();
			
			outputText("You tell Uma that you’re interested in the relaxing massage.\n\n");
			outputText("“<i>I wonder if Loppe is the reason you’re asking for this kind of massage... either way, sure, let’s do this.</i>”");
			outputText("You tell her that you won’t deny or admit to Loppe being a cause.  However, it’s also pretty rough out in the wilderness, so you could really use the relief.\n\n");
			outputText("“<i>Very well... don’t want you too burned out to deal my little Loppe afterwards.  Follow me.</i>” Uma motions for you to follow her, and you trail after her, looking forward to your treatment.\n\n");

			massageMain(MASSAGE_RELAXATION);
		}
		
		/**
		 * Player chose "Power"
		 * Add a 10% increase to damage inflicted?
		 */
		public static const MASSAGE_POWER:int = 4;
		public static const MASSAGE_POWER_BONUS:Number = 1.1;
		private static const MASSAGE_POWER_BONUS_TEXT:String = "<b>(10% Increase to all Damage inflicted whilst active!)</b>";
		public function massagePower():void 
		{
			clearOutput();
			
			outputText("You tell Uma that you’re interested in the strength-boosting massage.\n\n");

			outputText("“<i>Feel like getting involved in a fight, do you?  Okay, let Uma give you a little help!</i>”  She grins happily.\n\n");

			outputText("You thank her; her massage could mean the difference between life and death for you.\n\n");

			outputText("“<i>Now, now, dear.  There’s no need to be so dramatic... but I’m worried about what do you intend to do?  I have heard, and even seen, some of the dangers that are out there, beyond the walls of this city.  Shouldn’t you just come live with us, instead?  I’d hate to have anything happen to you... and Loppe would be crushed...</i>”\n\n");

			outputText("You tell her that you appreciate your sentiment, and you have no intention of hurting Loppe, but you have a mission and you are sworn to complete it; the demons must fall, and you won’t stop until they have.");

			outputText("“<i>I understand.  In this case, follow me.</i>” Uma motions for you to follow her.  You let her lead the way and follow close behind.");
			
			massageMain(MASSAGE_POWER);
		}
		
		/**
		 * "Joiner" scene for all of the subtypes of massage selection
		 * @param	selectedMassage		int key of the massage type, for later application of benefits.
		 */
		public function massageMain(selectedMassage:int):void
		{
			clearOutput();
			
			outputText("The room is light, but not overwhelmingly bright, with cool breezes gently wafting through, tingling deliciously on your exposed [skin] and setting the chimes hanging from the rafters gently a-tinkle. A number of large potted plants occupy the corners of the room, and there’s even a tiny fountain with stones in it, the tumble of water over rocks creating a strangely soothing melody.  A small brazier produces a sweet, calming smell from incense burning in it.  The pride of the room is a sizable table, made from bamboo; it is covered in a white cloth, and has an upraised headboard with a hole in it that looks like it’s big enough to fit your head through.\n\n");
			outputText("“<i>Before we get started, I’ll have to ask you to hand over a few gems for my services, dear.  Even if you are my little Loppe’s [boyfriend], this is still a business.</i>”\n\n");
			outputText("You tell her that’s alright, fishing in your belongings for the gems that the mare masseur needs for this particular service... which you remember she hasn’t told you yet?\n\n");
			outputText("Uma slaps her forehead.  “<i>Sorry about that, dear.  Usually I charge 100 gems for this kind of service, but since you’re my little horsey-hopper’s [boyfriend], I’ll give you a discount... how about 75 gems instead?</i>”\n\n");

			// Not enough cashmonies to pay for massage
			if (player.gems < 75)
			{
				outputText("You tell her that you don’t have that many gems on you at this point in time.\n\n");
				outputText("Uma sighs and shakes her head.  “<i>Sorry, dear.  But I can treat you in this case.</i>”\n\n");
				outputText("You sigh in turn, and tell her that you accept that; she is a business-woman, after all. You’ll have to come back another day, when you do have the money to pay for it.\n\n");
				outputText("Wishing her well, you calmly let yourself out of the shop and head back to camp.");
				
				menu();
				doNext(13);
				return;
			}
			
			outputText("You tell her that sounds fair, withdrawing the gems and handing them to her.\n\n");
			player.gems -= 75;

			outputText("“<i>Thanks, dear.</i>”  Uma pockets the gems and walks towards the table.  “<i>Okay, I’m gonna have to ask you to strip up and lay down face up on my table.</i>”\n\n");
			outputText("You promptly start stripping yourself off, ");
			
			if (flags[kFLAGS.PC_FETISH] >= 1)
			{
				outputText(" flushing with arousal at the idea, ");
			}
			
			outputText("and move over to lay yourself on the table.  You get yourself comfortable and tell Uma that you’re ready.\n\n");

			menu();
			addButton(0, "Next", massageCommence, selectedMassage);
		}
		
		/**
		 * Extensions to Massage Joiner.
		 * @param	selectedMassage		Massage bonus ID to apply
		 */
		public function massageCommence(selectedMassage:int):void 
		{
			clearOutput();
			
			outputText("“<i>Very well, dear.</i>”  She cracks her knuckles ominously.  “<i>This might hurt a bit, but bear with it.</i>”  She adds, rolling up the sleeves of her kimono.\n\n");
			outputText("You swallow audibly and brace yourself for what’s to come.\n\n");
			outputText("Uma presses her elbow against your chest ");
			
			if (player.biggestTitSize() >= 1)
			{
				outputText("between your [chest] ");
			}
			
			outputText("and pushes hard.  You can’t help but scream at the initial bout of pain.  “<i>Relax dear.  It only hurts for a little while.</i>”  You squirm at the pain but then... it dissipates... you’re pretty sure Uma is pressing on your chest even harder than before, yet the pain is quickly ebbing away...\n\n");
			outputText("Uma chuckles.  “<i>See dear?  Told you it gets better... but I’m afraid it’ll hurt a bit more later... I have other spots to care of.</i>”  She says, removing her elbow and moving away, only to return shortly with a small metal stick with a well rounded tip.  “<i>Get ready, dear.</i>”  You brace yourself for the next part of the treatment...\n\n");
			outputText("The treatment on your front is painful, but at the same time it gets easier and easier to relax as it goes on... and it hurts less and less, until by the time Uma is finished it just doesn’t hurt anymore...\n\n");
			outputText("“<i>Very good, dear.  Now flip over, time to take care of your back.</i>”\n\n");

			// Refactor to say something about nipples against the table?
			outputText("You move to do as she asks; it’s a little awkward adjusting to having your face in the - thankfully cushioned - hole.  You wriggle about to settle yourself comfortably on the table, but you manage to make yourself relaxed, and tell Uma that you’re ready once more.\n\n");
			outputText("You yelp as Uma presses the metal rod " + ((player.tailType > 0) ? "on the base of your tail" : "to your lower back") + ".  “I’m going to have to trace a few spots on your back, dear.  To ensure your flow of chi is not obstructed, so it might hurt again... but be brave.”  You nod as best as you can and brace yourself...\n\n");
			outputText("By the time Uma is finished, your back is sore... as well as your front... the pain on your back seemingly bringing back the pain on your front.\n\n");
			outputText("“<i>It will be a little while, before the flow of chi inside your body stabilizes, dear.  But by the time you’re out of this clinic, you should feel much better.</i>”  Uma explains.\n\n");
			outputText("You thank the mare and get dressed, bidding her farewell before you exit the clinic. Once outside, and true to her words, you feel better... in fact you feel amazing!  It’s no wonder her treatment is expensive, you feel just... amazing!\n\n");
			
			// Apply bonus & back to camp!
			applyMassageBonus(selectedMassage);
			menu();
			doNext(13);
		}
		
		/**
		 * Apply massage bonus.
		 * StatusAffect for all bonuses
		 * StatusAffect Values:
		 * v1 = bonus index
		 * v2 = bonus value
		 * v3 = remaining time
		 * @param	selectedMassage
		 */
		public static const MASSAGE_BONUS_NAME:String = "Uma's Massage";
		public static const MAX_MASSAGE_BONUS_DURATION:int = 24;
		public function applyMassageBonus(selectedMassage:int):void
		{
			if (selectedMassage < 0 || selectedMassage > 4)
			{
				outputText("<b>Invalid massage bonus ID! Welp!</b>");
			}
			else
			{
				var statIndex:int = player.hasStatusAffect(MASSAGE_BONUS_NAME);
				var bonusValue:*;
				
				// Remove the old massage bonus if present
				if (statIndex >= 0)
				{
					player.removeStatusAffect(MASSAGE_BONUS_NAME);
				}
				
				if (selectedMassage == MASSAGE_RELIEF)
				{
					outputText("<b>You feel so relaxed and mellow... you don’t think you’ll be able to get in the mood for sex while you feel this blissed out.</b> " + MASSAGE_RELIEF_BONUS_TEXT);
					bonusValue = MASSAGE_RELIEF_BONUS;					
				}
				else if (selectedMassage == MASSAGE_LUST)
				{
					outputText("<b>You feel so... wired! Your skin tingles with the slightest breeze, your heart races in your chest, and you lick your lips with eager nervousness.  You wanna fuck something so badly!</b> " + MASSAGE_LUST_BONUS_TEXT);
					bonusValue = MASSAGE_LUST_BONUS;
				}
				else if (selectedMassage == MASSAGE_MODELLING)
				{
					outputText("<b>You feel sexier; you don’t know if the massage has actually affected your looks, but you definitely have the confidence to strut your stuff!</b> " + MASSAGE_MODELLING_BONUS_TEXT);
					bonusValue = MASSAGE_MODELLING_BONUS;
				}
				else if (selectedMassage == MASSAGE_RELAXATION)
				{
					outputText("<b>Your aches and pains have vanished, and you feel so relaxed and rested.  That really did the trick in curing what ails you.</b> " + MASSAGE_RELAXATION_BONUS_TEXT);
					bonusValue = MASSAGE_RELAXATION_BONUS;
				}
				else if (selectedMassage == MASSAGE_POWER)
				{
					outputText("<b>Your muscles tingle and burn with energy; you feel like you could knock out a minotaur in one punch!</b> " + MASSAGE_POWER_BONUS_TEXT);
					bonusValue = MASSAGE_POWER_BONUS;
				}
				
				if (bonusValue != undefined)
				{
					player.createStatusAffect(MASSAGE_BONUS_NAME, selectedMassage, bonusValue, MAX_MASSAGE_BONUS_DURATION, 0);
					flags[kFLAGS.UMA_TIMES_MASSAGED]++;
				}
			}
		}
		
		/**
		 * Handle reducing the remaining time that the bonus is active for.
		 * When expired, remove and include a message to the effect.
		 */
		public function updateBonusDuration(hours:int):void
		{
			var statIndex:int = player.hasStatusAffect(MASSAGE_BONUS_NAME);
			
			if (statIndex >= 0)
			{
				player.statusAffects[statIndex].value3 -= hours;
				
				if (player.statusAffects[statIndex].value3 <= 0)
				{
					bonusExpired();
				}
			}
		}
		
		public function bonusExpired():void
		{
			outputText("\n<b>You groan softly as a feeling of increased tension washes over you, no longer as loose as you were before.  It looks like the effects of Uma’s massage have worn off.</b>\n");
			
			player.removeStatusAffect(MASSAGE_BONUS_NAME);
			
			trace("Removed Uma's Massage Bonus");
		}
		
		/**
		 * ACCUPUNCTURO
		 */
		
		/**
		 * Available Accupucture Types
		 */
		// TODO: Actually implement the perk bonuses throughout the codebase.
		public static const NEEDLEWORK_UNDO:int = -1;
		public static const NEEDLEWORK_SPEED:int = 0;
		public static const NEEDLEWORK_LUST:int = 1;
		public static const NEEDLEWORK_DEFENSE:int = 2;
		public static const NEEDLEWORK_MAGIC:int = 3;
		public static const NEEDLEWORK_ATTACK:int = 4;
		
		public static const NEEDLEWORK_SPEED_PERK_NAME:String = "Chi Reflow - Speed";
		public static const NEEDLEWORK_SPEED_PERK_DESC:String = "Uma's Accupuncture Needlework has gifted you with the 'Chi Reflow - Speed' perk. As a result your strength is capped but speed reductions are halved.";
		public static const NEEDLEWORK_SPEED_PERK_SHORT_DESC:String = "Speed reductions are halved but caps strength";
		public static const NEEDLEWORK_SPEED_STRENGTH_CAP:int = 60;
		public static const NEEDLEWORK_SPEED_SPEED_MULTI:Number = 0.5;
		
		public static const NEEDLEWORK_LUST_PERK_NAME:String = "Chi Reflow - Lust";
		public static const NEEDLEWORK_LUST_PERK_DESC:String = "Uma's Accupuncture Needlework has gifted you with the 'Chi Reflow - Lust' perk. As a result your Lust resistance and Tease attack are enhanced, but Libido and Sensetivity gains are increased.";
		public static const NEEDLEWORK_LUST_PERK_SHORT_DESC:String = "Lust resistance and Tease are enhanced, but Libido and Sensetivity gains increased.";
		public static const NEEDLEWORK_LUST_LUST_RESIST:int = 10;
		public static const NEEDLEWORK_LUST_TEASE_MULTI:Number = 10;
		public static const NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI:Number = 1.1;
		public static const NEEDLEWORK_LUST_LIBSENSE_MULTI:Number = 1.1;
		
		public static const NEEDLEWORK_DEFENSE_PERK_NAME:String = "Chi Reflow - Defense";
		public static const NEEDLEWORK_DEFENSE_PERK_DESC:String = "Uma's Accupuncture Needlework has gifted you with the 'Chi Reflow - Defense' perk. As a result your body has gained passive damage resistance and extra health, but speed is capped.";
		public static const NEEDLEWORK_DEFENSE_PERK_SHORT_DESC:String = "Passive damage resistance, but caps speed";
		public static const NEEDLEWORK_DEFENSE_DEFENSE_MULTI:Number = 1.1;
		public static const NEEDLEWORK_DEFENSE_EXTRA_HP:int = 50;
		public static const NEEDLEWORK_DEFENSE_SPEED_CAP:int = 60;
		
		public static const NEEDLEWORK_MAGIC_PERK_NAME:String = "Chi Reflow - Magic";
		public static const NEEDLEWORK_MAGIC_PERK_DESC:String = "Uma's Accupuncture Needlework has gifted you with the 'Chi Reflow - Magic' perk. As a result your spells are now more powerful, but regular attacks are weaker.";
		public static const NEEDLEWORK_MAGIC_PERK_SHORT_DESC:String = "Magic attacks boosted, but regular attacks are weaker.";
		public static const NEEDLEWORK_MAGIC_SPELL_MULTI:Number = 0.25;
		public static const NEEDLEWORK_MAGIC_REGULAR_MULTI:Number = 0.75;
		
		public static const NEEDLEWORK_ATTACK_PERK_NAME:String = "Chi Reflow - Attack";
		public static const NEEDLEWORK_ATTACK_PERK_DESC:String = "Uma's Accupuncture Needlework has fited you with the 'Chi Reflow - Attack' perk. As a result your regular attacks are more powerful, but your damage reduction is decreased.";
		public static const NEEDLEWORK_ATTACK_PERK_SHORT_DESC:String = "Regular attacks boosted, but damage resistance decreased.";
		public static const NEEDLEWORK_ATTACK_REGULAR_MULTI:Number = 1.1;
		public static const NEEDLEWORK_ATTACK_DEFENSE_MULTI:Number = 0.9;
		
		public function needleworkString(needleworkType:int):String
		{
			if (needleworkType == NEEDLEWORK_SPEED)
			{
				return "\"Speed\"";
			}
			else if (needleworkType == NEEDLEWORK_LUST)
			{
				return "\"Lust\"";
			}
			else if (needleworkType == NEEDLEWORK_DEFENSE)
			{
				return "\"Defense\"";
			}
			else if (needleworkType == NEEDLEWORK_MAGIC)
			{
				return "\"Magic\"";
			}
			else if (needleworkType == NEEDLEWORK_ATTACK)
			{
				return "\"Attack\"";
			}
			
			return "<b>Somethin' dun fucked up.  Please insert bugreport!</b> ";
		}
		
		public function listPerkDescription(perkName:String):String
		{
			switch(perkName)
			{
				case NEEDLEWORK_SPEED_PERK_NAME:
					return NEEDLEWORK_SPEED_PERK_SHORT_DESC;
					break;
				case NEEDLEWORK_LUST_PERK_NAME:
					return NEEDLEWORK_LUST_PERK_SHORT_DESC;
					break;
				case NEEDLEWORK_DEFENSE_PERK_NAME:
					return NEEDLEWORK_DEFENSE_PERK_SHORT_DESC;
					break;
				case NEEDLEWORK_MAGIC_PERK_NAME:
					return NEEDLEWORK_MAGIC_PERK_SHORT_DESC;
					break;
				case NEEDLEWORK_ATTACK_PERK_NAME:
					return NEEDLEWORK_ATTACK_PERK_SHORT_DESC;
					break;
				default:
					return "";
					break;
			}
		}
		
		/**
		 * Calculate the current undo cost of the players needlework
		 * @return	calculated cost
		 */
		public function needleworkUndoCost():int
		{
			var baseCost:int = 125;
			
			if (flags[kFLAGS.UMA_TIMES_ACCUPUNCTURE_UNDO] != 0)
			{
				// 25 per undo?
				baseCost += (25 * flags[kFLAGS.UMA_TIMES_ACCUPUNCTURE_UNDO]);
			}
			
			return baseCost;
		}
		
		public function hasNeeleworkPerk():Boolean
		{
			var pName:String = this.getNeedleworkPerkName();
			if (pName != "")
			{
				trace("Player has " + pName);
				return true;
			}
			
			return false;
		}
		
		public function getNeedleworkPerkName():String
		{
			if (player.hasPerk(NEEDLEWORK_SPEED_PERK_NAME) >= 0)
			{
				return NEEDLEWORK_SPEED_PERK_NAME;
			}
			else if (player.hasPerk(NEEDLEWORK_LUST_PERK_NAME) >= 0)
			{
				return NEEDLEWORK_LUST_PERK_NAME;
			}
			else if (player.hasPerk(NEEDLEWORK_DEFENSE_PERK_NAME) >= 0)
			{
				return NEEDLEWORK_DEFENSE_PERK_NAME;
			}
			else if (player.hasPerk(NEEDLEWORK_MAGIC_PERK_NAME) >= 0)
			{
				return NEEDLEWORK_MAGIC_PERK_NAME;
			}
			else if (player.hasPerk(NEEDLEWORK_ATTACK_PERK_NAME) >= 0)
			{
				return NEEDLEWORK_ATTACK_PERK_NAME;
			}
			else
			{
				return "";
			}
		}
		
		/**
		 * Apply a Needlework perk to the player.
		 * I don't want to stuff the stat values themselves into the Perk itself, because then we have to figure out if a player was saved with different bonuses applied to the perk than what we currently have defined.
		 * ie. it makes future balancing of the perks more of a chore. Rather, other code can just reference the static vars we have here using UmasShop.NEEDLEWORK_MAGIC_blah
		 */
		public function applyNeedlework(selectedSession:int):void
		{
			if (selectedSession == NEEDLEWORK_UNDO)
			{
				player.removePerk(this.getNeedleworkPerkName());
				flags[kFLAGS.UMA_TIMES_ACCUPUNCTURE_UNDO]++;
			}
			else if (selectedSession == NEEDLEWORK_SPEED)
			{
				player.createPerk(NEEDLEWORK_SPEED_PERK_NAME, 0, 0, 0, 0, NEEDLEWORK_SPEED_PERK_SHORT_DESC);
				outputText("<b>" + NEEDLEWORK_SPEED_PERK_DESC + "</b>");
			}
			else if (selectedSession == NEEDLEWORK_LUST)
			{
				player.createPerk(NEEDLEWORK_LUST_PERK_NAME, 0, 0, 0, 0, NEEDLEWORK_LUST_PERK_SHORT_DESC);
				outputText("<b>" + NEEDLEWORK_LUST_PERK_DESC + "</b>");
			}
			else if (selectedSession == NEEDLEWORK_DEFENSE)
			{
				player.createPerk(NEEDLEWORK_DEFENSE_PERK_NAME, 0, 0, 0, 0, NEEDLEWORK_DEFENSE_PERK_SHORT_DESC);
				outputText("<b>" + NEEDLEWORK_DEFENSE_PERK_DESC + "</b>");
			}
			else if (selectedSession == NEEDLEWORK_MAGIC)
			{
				player.createPerk(NEEDLEWORK_MAGIC_PERK_NAME, 0, 0, 0, 0, NEEDLEWORK_MAGIC_PERK_SHORT_DESC);
				outputText("<b>" + NEEDLEWORK_MAGIC_PERK_DESC + "</b>");
			}
			else if (selectedSession == NEEDLEWORK_ATTACK)
			{
				player.createPerk(NEEDLEWORK_ATTACK_PERK_NAME, 0, 0, 0, 0, NEEDLEWORK_ATTACK_PERK_SHORT_DESC);
				outputText("<b>" + NEEDLEWORK_ATTACK_PERK_DESC + "</b>");
			}
		}
		 
		/**
		 * Present player with accupuncture details.
		 * Edit Status: FUCK ALL
		 */
		public function accupunctureMenu():void
		{
			clearOutput();
			
			outputText("You tell her that you want to try one of those acupuncture sessions of hers.\n\n");
			outputText("“<i>Are you sure, dear?  While the effects of a Do-in massage will fade eventually, acupuncture is fairly... permanent.  Though I can only give you the effects of one type of needlework at once...</i>”\n\n");
			outputText("You tell her you understand what she’s saying, and thank her for warning you, and ask her what kinds of needlework can she do?  What effects can her \"acupuncture\" have on you?  And how much it's going to cost you.\n\n");
			outputText("“<i>Well, fine.  So long as you’re sure.  Normally, I would just show you a catalogue, but I suppose you’d prefer needlework that can be used for combat, yes?</i>”\n\n");
			outputText("You tell her that would probably be most useful to you, yes.\n\n");

			// This seems a bit akward, I wanna come back and rework it to flow smoothly
			// Also wrap it in a perkfind to check if the player would have to remove before readding
			outputText("“<i>Bear in mind that while they have beneficial effects, due to the disruption they cause within the chi flow inside your body... they’d also cause a penalty.  So here are the types of needlework you’d find helpful.</i>” She takes a deep breath, clearly checks her mental list, and then begins to speak.\n\n");
			outputText("“<i>First of all, if you focus on speed over strength,  I can increase your innate swiftness, making you less vulnerable to attacks or transformations that reduce your speed.  The drawback of this is that the maximum possible strength you can possess is lowered - though, as this prevents your muscles from growing so large they interfere with your speed, I think you’ll agree that it’s an easy sacrifice to make.”</i>  The mare masseur notes.\n\n");
			outputText("“<i>I understand that lust plays an important part in fighting, so I could make you more resistant to the advances of the creatures outside, as well as augment your ability to... well... entice them.  However this comes with a cost, you will constantly need to have sex, or your chi flow will begin to burn up, increasing your sensitivity as well as your libido.</i>”\n\n");
			outputText("“<i>If you are uncertain of your toughness, your ability to resist the damage inflicted upon you by the creatures that prowl the wilderness, I can bolster that.  However, modifying the chi flow in such a manner causes your limbs to lose some of their power; you will be slower, and find it harder to escape from enemies that even your newfound resilience cannot protect you against.</i>”\n\n");
			outputText("“<i>One of my special needleworks favored by mages will redirect chi from your muscles to your mind; your blows will be weaker, but your spells will be far more potent.</i>”\n\n");
			outputText("“<i>Finally, I can use my needles to rearrange your chi flow and optimise your offense; your blows will be far more powerful, but your natural defense will be impaired, making you more vulnerable to strikes by the enemy.</i>”\n\n");

			var sessionCost:int = 125;
			
			// Calculate the cost of a session
			if (this.hasNeeleworkPerk())
			{
				// We're removing so use an increased cost.
				sessionCost = this.needleworkUndoCost();
			}
			
			outputText("The mare tries to remember any other types of needlework that might be useful to you... but ultimately, she can’t think of anything else.  “<i>That’s all you might use, I think...</i>”  She then pauses.  “<i>As for a price, given you’re my little Loppe’s special someone, shall we say " + String(sessionCost) + " gems?  That’s half-price of what I’d usually charge.</i>”\n\n");
						
			
			// Cashmonies time
			if (player.gems < sessionCost)
			{
				outputText("You click your tongue and apologise to Uma, but you don’t have enough gems to pay for your treatment...\n\n");
				outputText("Uma sighs.  “It’s okay, dear.  Just come back when you do, my doors are always open.”  She smiles at you.");
				
				menu();
				doNext(13);
				return;
			}

			outputText("You nod in understanding... now you stop and consider your options, wondering which one you should choose..."); 

			menu();
			
			if (!this.hasNeeleworkPerk())
			{
				addButton(0, "Speed", needleworkSession, NEEDLEWORK_SPEED);
				addButton(1, "Lust", needleworkSession, NEEDLEWORK_LUST);
				addButton(2, "Defense", needleworkSession, NEEDLEWORK_DEFENSE);
				addButton(3, "Magic", needleworkSession, NEEDLEWORK_MAGIC);
				addButton(4, "Attack", needleworkSession, NEEDLEWORK_ATTACK);
			}
			else
			{
				addButton(0, "Undo", needleworkSession, NEEDLEWORK_UNDO);
			}
			
			addButton(9, "Leave", needleworkTurnDown);
		}
		
		/**
		 * Player changes mind about going through with Accupuncture session.
		 * Edit Status: FUCK ALL
		 */
		public function needleworkTurnDown():void
		{
			clearOutput();
			
			outputText("You shake your head and tell Uma that you’d actually rather not get one of her acupuncture treatments at this point in time.\n\n");
			outputText("“<i>Very well, dear.  It’s important that you think this through, they’re not easy to undo.</i>”");
			
			menu();
			
			addButton(0, "Next", enterClinic, true);
		}

		/**
		 * Opening of the Accupuncture session itself. Minor variantion/cost changes
		 * Edit Status: FUCK ALL
		 * @param	selectedSession		Static var indicating the desired outcome based on player selection. See NEEDLEWORK_ vars.
		 */
		public function needleworkSession(selectedSession:int):void
		{
			clearOutput();
			
			// Pay up
			// These could REALLY do with being a little longer. And also not being as akward.
			if (selectedSession == NEEDLEWORK_UNDO)
			{
				outputText("You tell Uma that you’d like her to remove the effects of your last acupuncture session from your body.  Then hand over the gems.\n\n");
				outputText("“<i>Alright, dear,</i>”  Uma replies, pocketing the gems.  “<i>It might take some time, but I think I can help you with that... follow me.</i>”\n\n");
				
				player.gems -= this.needleworkUndoCost();
			}
			else
			{
				outputText("You tell Uma that you would like her to give you the " + this.needleworkString(selectedSession) + " acupuncture session, please. Then hand over the gems.\n\n");
				outputText("“<i>Alright, dear.</i>”  Uma replies, pocketing the gems.  “<i>Let’s go then.</i>”  She motions for you to follow her.");
				
				player.gems -= 125;
			}
			
			menu();
			addButton(0, "Next", doNeedleworkSession, selectedSession);
		}
		
		/**
		 * Actual scene for the accupuncture stuff to happen.
		 * Edit Status: FUCK ALL
		 * @param	selectedSession		Static var indicating the desired outcome based on player selection. See NEEDLEWORK_ vars.
		 */
		public function doNeedleworkSession(selectedSession:int):void
		{
			clearOutput();
			
			outputText("The room is light, but not overwhelmingly bright, with cool breezes gently wafting through, tingling deliciously on your exposed [skin] and setting the chimes hanging from the rafters gently a-tinkle. A number of large potted plants occupy the corners of the room, and there’s even a tiny fountain with stones in it, the tumble of water over rocks creating a strangely soothing melody.  A small brazier produces a sweet, calming smell from incense burning in it.  The pride of the room is a sizable table, made from bamboo; it is covered in a white cloth, and has an upraised headboard with a hole in it that looks like it’s big enough to fit your head through.\n\n");
			outputText("“<i>I want you to strip and lay face down on my table, while I go fetch my needles and some numbing cream.  Unless you’d like me to stick needles in your body without anything to dull the pain?”</i>  Uma asks jokingly.\n\n");
			outputText("You quickly shake your head, and indicate she should go, promising to be properly undressed and ready by the time she gets back.  As the mare heads off to fetch your things, you do as you were instructed; sticking your head in the table’s hole is a little awkward, and makes you feel rather vulnerable... which is natural, given what Uma mentioned about needles.\n\n");
			outputText("It only takes moments before Uma returns with a small cart containing a small container and a vial of what you presume to be the numbing cream.  Out of the cart’s drawer, Uma pulls a pair of gloves which she fits nicely, then opens the small container.  From your current position it’s hard to tell what it contains, but from the clicking sounds you hear, you assume it to be where she keeps her needles.\n\n");
			outputText("“<i>Are you comfortable, dear?  May I start?</i>”  She asks.\n\n");
			outputText("You tell her that you’re as ready as you’ll ever be, so she may as well start.  “<i>Ok, now try to relax.</i>”  She says, gently touching your exposed back and lightly massaging it with her fingers.  The combination of nerves and her touch sends static through your skin.\n\n");
			outputText("“<i>I’ll be applying the cream now.</i>”  She notifies you, slowly pouring the, rather cold, cream on your back and rubbing it all over, ensuring every single spot is covered before she puts the vial away.  You shiver and repress a verbal protest at the chill in her cream.  “<i>It’ll take a few minutes before you’ll start to feel the effects, I want you to tell me when you no longer feel my fingers on your back.</i>”  She then begins a slow circular massage on your back.\n\n");
			outputText("You promise you will, and wait patiently.  Slowly the sensation of her fingers fades away, until at last you aren’t sure if she’s even touching you any more, and you report this to the mare currently planning on sticking you full of needles.\n\n");
			outputText("“<i>Very good.  I'll start the treatment now, you might feel a slight pricking sensation, though it shouldn’t hurt... if at any point it starts hurting, tell me and I’ll do something to ease your pain, alright?</i>”\n\n");

			// Akward wording
			outputText("You tell her that you understand.  True to her words, you do feel the slight pricking sensation of needles been put on your back, some of them are removed shortly after, while others stay in place for a while longer.  Eventually, you feel all needles being taken out of your back and Uma happily declares,  “<i>All done!</i>”\n\n"); 
			outputText("You ask if you can get up now, or do you need to stay where you are so that it has time to settle?  “<i>No, you can get up and get dressed dear.  The needles are out and your chi should be stable enough now... though you won’t feel much of a change until some time has passed.</i>”  She takes off her gloves and scratches her chin.  “<i>I estimate you should start to feel the changes soon; maybe by the time you get back to your home, if not shortly after.</i>”\n\n");
			outputText("You thank her for her work, get yourself up and proceed to dress yourself.  You then politely excuse yourself and start the long journey back to your camp.\n\n");
			
			applyNeedlework(selectedSession);
			
			menu();
			doNext(13);
		}
		
		/**
		 * LIPFLAP COMMENCE.
		 * Most of these will need breaking into multiple pages methinks.
		 */
		public function talkMenu():void
		{
			clearOutput();
			
			outputText("You tell Uma that you’d like to chat; you’re interested in getting to know her better, and who knows, maybe she can help you get to know her daughter better?\n\n");
			outputText("“<i>Sure, what would you like to talk about?</i>”  Uma replies with a smile.");
			
			menu();
			
			addButton(0, "Job", talkJob);
			addButton(1, "Sexuality", talkSexuality);
			addButton(2, "Loppe", talkLoppe);
		}
		
		/**
		 * Talk Job
		 * Edit Status: FUCK ALL
		 */
		public function talkJob():void
		{
			clearOutput();
			
			outputText("You tell her that you’re curious about the work she does and what it can do.\n\n");
			outputText("“<i>My work?</i>”  Uma repeats in a thoughtful tone.  “<i>Well, I’m something of a healer - my specific skills lie in acupuncture and do-in, a form of deep muscle massage.  As for what they can do... In short, my skills allow me to modify a person’s flows of chi - I presume you’ve heard of that?</i>”\n\n");
			outputText("You shake your head, which prompts her to sigh.  “<i>Chi is the energy that permeates one’s body, to put it simply.  Every living thing has a certain flow of chi, and this is what determines your talents, abilities and, some would argue, even fate.  Some talented individuals can actually gather chi from other beings, to some effect, and some, like yours truly, can manipulate the flow of the chi inside someone; although there is a limit to how much I can manipulate it.</i>”  Uma explains.\n\n");
			outputText("So, Uma manipulates the energy inside of people for a living?  But why would anyone want her to do that?  You ask this to the mare, hoping for clarification.\n\n");
			outputText("“<i>Manipulating the chi inside someone can have various beneficial effects, such as improving strength, altering sexual drive, getting rid of pains, alleviating mood swings... basically anything you can imagine has a relationship, no matter how detached, to chi.</i>”\n\n");
			outputText("You nod your head in understanding; that makes sense.  So, what’s the difference between the massages - do-in, she called them? - and acupuncture?  Don’t they both do the same thing?\n\n");
			outputText("Uma smiles and shakes her head.  “<i>No, dear.  Do-in adjusts the flow of chi, such as increasing output in certain areas, or reducing them... imagine this.  Your chi flows like a river, by enlarging or shrinking the stream, the river’s strength will either increase or diminish, correct?  This is what Do-in does, it never cuts the flow of the river, just... adjusts it.</i>”\n\n");
			outputText("You tell her that’s correct, and you understand the analogy. So, how does acupuncture differ in its effects?\n\n");
			outputText("“<i>During acupuncture I pierce key spots in your body with needles; these are much more complicated than Do-in, despite do-in not being simple to begin with.  Basically, using the previous analogy, acupuncture obstructs the flow of the river, so that it can flow elsewhere, or flow differently.  The effects of Do-in are just temporary, which means that given enough time, the river will return to normal, but acupuncture... that is permanent, dear.  Once a new pathway has been made for the flow of chi inside your body, it’s there to stay... though with some work it might just be possible to remove the effects...</i>”  Uma rubs her chin in thought.\n\n");
			outputText("You nod your head thoughtfully, digesting what you have been told.\n\n");
			outputText("“<i>Another key point, is that acupuncture is much more disruptive to the flow of chi than do-in.  Usually, in order to make something better, or different, something else has to change... and not always for the better.  I could make you faster, able to move better, but that would seal some of the chi going into your muscles, which means you would never be as strong as you were meant to be...  though sometimes, depending on what you’re trying to achieve, that could actually benefit you.</i>”  Uma smiles.\n\n");
			outputText("You tell her that you appreciate her taking the time to explain her job to you; maybe at some point in the future you’ll have a need for her special skills, but, right now, you think you’ve taken enough of her time.\n\n");
			outputText("“<i>It’s always pleasure speaking to the [man] that wooed my little Loppe, dear.  Come visit soon, will you?</i>”\n\n");
			outputText("You promise you’ll try, and then head back to camp.");

			menu();
			doNext(13);
		}
		
		/**
		 * Talk Sexuality
		 * Edit Status: FUCK ALL
		 */
		public function talkSexuality():void
		{
			clearOutput();
			
			outputText("You tell her that, if it’s not too personal, you’d like to ask her some questions about her sexuality?\n\n");
			outputText("“<i>Oh, I’m okay with talking about that.  You’re not the first person to ask me about that...</i>” She looks distant for a short while... but then looks at you and smiles.  “<i>So, what do you want to know, exactly?</i>”\n\n");
			outputText("You think for a while, and finally ask why she considers herself a lesbian?  Won’t she have sex with herms too?  Wouldn’t that make her bi?  In fact... what made her think of herself as a lesbian in the first place?\n\n");
			outputText("Uma stops to think for a while then replies,  “<i>Well... I guess it was my studies.  Being an acupuncturist means I have to know a lot about bodies in general... and while I do know all the ins and outs of male anatomy, I’ve always found girls more... beautiful.</i>”  She thinks for a while longer, then shrugs.  “<i>I suppose that’s all I can say about that... I really don’t know why I find girls more attractive... I just do.  And, well... I’m not entirely against having sex with males either, so long as they’re pretty girly to begin with, so maybe you’re right... maybe I’m more bi than lesbian.</i>”\n\n");
			outputText("So, it’s not so much that she’s unattracted to dicks as that she needs a fairly feminine face, and preferably physique as well, to get turned on by someone? You ask, interested.  Uma nods.  “<i>That is correct... I like my partners pretty...</i>”  She laughs lightly.\n\n");
			outputText("You ask if that makes it at all challenging to find partners, when she’s feeling in the mood?\n\n");
			outputText("Uma giggles.  “<i>Not at all.  I find that women in general tend to care more for 'natural medicine' than men... usually when men have chronic back pain, most of them would rather drink some kind of alchemic beverage to make it better, and to be honest it does work well. But the truth is that ingesting too many alchemical ingredients might lead to even more problems later; not to mention the chemical dependency.  Since my pins are a one-time thing, and there’s no dependency, I get many visits from the more health conscious populace.  And let’s just face it, [name].  Women are just that much more concerned about natural medicine than men... especially when it involves a 7 foot horse-woman inserting needles in their bodies.</i>”  Uma giggles once more.\n\n");
			outputText("You ask casually if that implies the few men who do visit tend to be especially likely to be her type?\n\n");
			outputText("Uma thinks for a while.  “<i>To be honest it’s a fifty-fifty chance... usually the men that do show up happen to have been sent here by their wives and girlfriends.  Finding girly men is just very rare... though I do get the occasional client.</i>”\n\n");
			outputText("That makes you think, and you ask how much effort Uma has to put into keeping her little tete-a-tetes discrete? After all, you don’t think too many boyfriends, husbands or fathers would be happy to hear about her seducing their girlfriends, wives or daughters.\n\n");
			
			// ABORT ABORT DOTVERLOAD DETECTED
			outputText("Uma smiles at you mischievously.  “<i>On the contrary, my naive little friend.  This is an oriental clinic, and there are many types of therapy, for various problems... including sex life.  Some of the women I seduce are actually straight, and let’s just say sometimes they need to be reminded of what a good penis can do for them.  And the only way to do that... well... is by making them want one in the first place.  A caress here, a press there, a little lick later... and they are all practically on fire, orgasming time and again... begging me to fuck them... There’s only one little problem though... I don’t have the equipment.</i>”  Uma winks at you.  “<i>Once they leave my clinic, they're satisfied and much hornier than usual.  So the first thing they do is go home to share their pleasure with their husbands.</i>”\n\n");

			outputText("You can’t resist the wry grin as you comment that must do wonders for the reputation of her business.\n\n");
			outputText("Uma nods.  “<i>It does... but as you can see, the clinic is pretty empty most of the time.  It just so happens that we’re really expensive... especially considering our... extra... services.  But don’t worry, [name].  Since you’re my little Loppe’s [boyfriend], I’ll be happy to give you a pretty good discount on our services.”\n\n");
			outputText("You laugh at that, thanking her for her generosity and her time, and then tell her it’s time for you to go.  Uma smiles at you and says, “<i>Come visit me again soon.</i>”\n\n");
			outputText("You promise that you will, and then head out of the quaint little clinic and back to camp.\n\n");

			menu();
			doNext(13);
		}
		
		public function talkLoppe():void
		{
			clearOutput();
			
			outputText("You ask if she’d mind if you wanted to hear some stories about Loppe; what was she like as a little Loppe?  Maybe her mom’s got some embarrassing secrets to share about her, you grin?\n\n");
			outputText("Uma taps her chin, thinking of something to tell you about...\n\n");
			
			// move this shit ~860 lines ^ thattaway
			var loppeTalks:Array = new Array();
			loppeTalks.push(talkLoppeAttitudes);
			loppeTalks.push(talkLoppeCarrotIncident);
			loppeTalks.push(talkLoppePuberty);
			loppeTalks.push(talkLoppesLastGirl);
			loppeTalks.push(talkLoppesFirstBoyfriend);
			loppeTalks.push(talkLoppesDad);
			
			// random call to one of the loppeTalks functors
			loppeTalks[rand(loppeTalks.length)]();
		}
		
		public function talkLoppeJoiner():void
		{
			menu();
			doNext(13);
		}
		
		/**
		 * Random talk scene about Loppe's Attitudes.
		 * Edit Status: 90%
		 */
		public function talkLoppeAttitudes():void
		{
			outputText("“<i>What do you think of Loppe?  How she acts?  Looks?  Behaves?</i>”  Uma asks with a smile.\n\n");
			outputText("You’re not quite sure what Uma’s getting at and tell her as much, but finally declare that you’d probably call her girly.  A little on the tomboyish side, but, given she’s a herm that only seems reasonable; it’s hard to say what gender traits would be best for a person who is functionally both male and female.\n\n");
			outputText("“<i>That's true, but what you probably don’t know is Loppe was a lot more troublesome when she was just a little hopper.  She was a lot more boyish, and if anyone called her a girl she'd happily start an all out brawl at a moments notice.</i>”\n\n");
			outputText("You think it over and note that makes sense; when she was that age, well, she’d hardly have been able to really tell the difference between the genders, and it’s not like she would have had any problems convincing the boys she was one of them, right?\n\n")
			outputText("“<i>Yes, especially since she was flat-chested back then... but she was quite a handful. The eldar would call for me regularly to discuss my little hoppers behaviour. I guess she was kind of a bully, so I had to discipline her many times.</i>”\n\n");
			outputText("You note that’s more of a surprise to you than Loppe being a tomboy; she’s always so sweet and kindly when you’re around her.  You can't deny that she's a little on the horny side, but still, she’s a nice person.\n\n");
			outputText("“<i>That’s because she underwent a very radical change when she finally hit puberty.  Most children get a little rebellious, but not my Loppe, oh no.  If anything she became obedient, almost to a fault. In fact... for a while I thought she was actually sick or worried about something.  But she assured me she was just tired of sitting through my scoldings, and didn’t see a reason to challenge me anymore.  It was kind of cute too, she started asking me all kinds of questions, especially why she had both genders.</i>”\n\n");
			outputText("You note that it must have been a troubling time in her life; you remember going through puberty, and you can’t imagine how hard it must have been to go through the hassles of things like the first period <i>and</i> uncontrollable erections simultaneously.  Though being the mother to a herm in puberty can’t have been a picnic either...\n\n");
			outputText("“<i>It wasn’t, but I enjoyed it either way.  Loppe and I grew a lot closer then.  I guess she just finally got tired of trying to be a boy and decided to embrace her femininity.  She had me teach her how to act as a girl, and for the most part she does fine, but I wouldn’t be surprised if she slips up every once in awhile.</i>”\n\n");
			outputText("Slips up?\n\n");
			outputText("“<i>Sometimes she'll let loose the foulest belches in public, or... </i>readjust<i> herself in public</i>\" says Uma, her hand cupping an imaginary bulge at her crotch.  \"<i>She does things that a lady wouldn’t let herself get caught dead doing when she forgets about her desire to appear lady-like.</i>”\n\n");
			outputText("Well, you can’t say you’ve ever caught her doing anything like that... except for her tendency to wrestle you into bed, or having to nurse a very noticable erection in public, you joke.  You really can’t see Loppe as the type to burp at all, though you admit she’s a bit more a glutton than you would have expected such a dainty-looking lady like her to be.\n\n");
			outputText("“<i>Oh, but she of course you wouldn’t catch her doing any of that, she's extra careful around you... believe me, I’ve seen her when she gets home after a date with you.  She’s at least twice as tired as she usually is, no doubt due to keeping her boyish tendancies in check.</i>”\n\n");
			outputText("You wonder if maybe you should tell her that she doesn’t have to try so hard to impress you; you want to be able to say you like her for who she is, the real her, not some act she forces herself to go through.  You don’t realize you’ve been musing aloud until Uma responds.\n\n");
			outputText("“<i>Dear, that's wouldn't help at all.  She wouldn’t be with you if she thought you would leave her if she was rude, but she owes it to herself to act like a proper lady around you.  So the best you can do is pretend to buy into her act.</i>”\n\n");
			outputText("You sigh quietly and tell Uma you understand, but ask if maybe she could drop a hint to her daughter about trying too hard, hmm?\n\n");
			outputText("“<i>I can do that, but I don’t think it’s going to help.  When she was young I told her she didn’t have push herself so hard, but she insists on doing so anyway.  She can be quite stubborn, you know?</i>”\n\n");
			outputText("You confess that you’ve had that impression from her, yes.  You thank Uma for giving you an insight into her daughter’s history, but tell her it’s time you were on your way.\n\n");
			outputText("“<i>You’re welcome, see you around.</i>”  Uma waves you goodbye as you excuse yourself and return to camp.");

			// Join the exit back up from all the loppeTalks
			talkLoppeJoiner();
		}
		
		/**
		 * Loppe Talk - The Carrot Incident
		 * Edit Status: 20%
		 */
		public function talkLoppeCarrotIncident():void
		{
			outputText("“<i>Tell me, [name].  Did you know rabbits love carrots?</i>”  Uma asks with a smirk.\n\n");
			outputText("You tell her that’s what people say, back in the village you come from.  But, then again, you smirk, they also say that horses love carrots too, and you verbally recount an incident in which a mare broke out of her pen and ate so many carrots from one of the village fields she was heartily sick.  You ask jokingly if Uma shares any favorite dishes with her daughter?\n\n");
			outputText("“<i>Of course I do.  I happen to have a soft spot for carrot cake myself... but that’s not why I asked.  As you know, my daughter is part equine and part leporid, so as you can imagine she loves carrots, right?</i>”\n\n");
			outputText("You nod, proclaiming that it’s a little cliche.  So, why is Uma talking about vegetables?\n\n");
			outputText("Uma grins mischievously at you.  “<i>Did you know my little Loppe loves carrots so, so much... that she tried to have sex with one?</i>”\n\n");
			outputText("...Okay, that’s a story that you feel you need to hear, and you tell this to the dirty old mare who cliams herself to be Loppe’s mother.\n\n");
			outputText("Uma smiles knowingly. “<i>I knew this would pique your interest.  Well... Loppe was in a experimentative mood... and I’m pretty good at hiding my toys, so she couldn’t find anything to sate her curiosity.  That is... until she found a piece of carrot... let’s just say it had a pretty familiar shape... you know what I’m getting at?</i>”\n\n");
			outputText("You can’t resist the wry grin; did she really...?\n\n");
			outputText("Uma nods.  “<i>And I caught her going at it too.  Silly little Loppe, she thought she could hide the facts from her mother...</i>”  Uma shakes her head in mock disapproval.  “<i>She slipped the carrot out of herself as fast as she could manage and pretended she was just having a snack in the tub.  Judging by the look on her face when she took a bite, I could easily see she wasn’t used to taste of carrot with her own... sauce...</i>”  Uma chuckles to herself.\n\n");
			outputText("You ask in disbelief if Uma actually made her daughter eat her own carrot dildo?\n\n");
			outputText("Uma shakes her head.  “<i>No no, of course not.  But back then Loppe wasn’t so open about her sexuality either, and she had to make me buy into her argument.  Of course... I let her get away with it, but I laughed once I was sure she was out of earshot.</i>”  Uma smiles, recalling the event.\n\n");
			outputText("You chuckle and suggest that Loppe probably never used carrots in that fashion again?\n\n");
			outputText("Uma smirks.  “<i>Well... on certain lonely nights I did see a few carrots going missing from our stash...</i>”\n\n");
			outputText("You can’t resist a laugh, and tell Uma that you’re grateful for her sharing such an intimate story about her daughter with you.  Isn’t she a little worried you might tease Loppe about it, though?\n\n");
			outputText("Uma grins mischievously.  “<i>Dear... I’m counting on it.  Maybe she’ll learn to leave my carrots alone so I can actually have a midnight snack for once.  Make sure you tell me how she reacted afterwards, okay?</i>”\n\n");
			outputText("You tell her that you make no promises and then excuse yourself; the chat was lovely, but you have to be moving on now.\n\n");
			outputText("“<i>Okay, see you around [name].</i>” Uma waves you goodbye.");

			// Join the exit back up
			talkLoppeJoiner();
		}
		
		/**
		 * Loppe Talk - Loppe Puberty
		 * Edit Status: FUCK ALL
		 */
		public function talkLoppePuberty():void
		{
			/*
			“By now, you must know about Loppe’s stamina, right?  And that her cum production is also... quite elevated too, no?”  Uma asks, smiling.

You can’t resist a wry grin as you comment that you might be familiar with what Uma is talking about, yes.

“But, did you know this caused her no end of problems when she was younger?”

You blink in surprise; you could have sworn Loppe told you that her “stamina” was the result of that demon’s curse, and you pass this on to Uma.

“Make no mistake, dear.  It was one of the effects of the curse... but little Loppe’s always been a bundle of insatiable energy.”  Uma smiles.

Be that as it may, surely her massive “discharges” owe more to magic than nature, you protest?

“I’m afraid not... or at least not entirely.  When she was younger Loppe often would suffer... accidents... due to her cum production.”

Accidents, you ask?  Then the mental image hits you, and you muse aloud on a sort of combination of accidental erections and the ejaculate-equivalent of poor bladder control.

“Yes, she would spontaneously cum all over her lower garments.  Mind you... it wasn’t an orgasm per se... more like a slowish unstoppable leak.  Other kids used to call her Furutama due to her problems.  But I took care of that.”  Uma chuckles to herself.

You note that must have been a bit on a trial for both Loppe and her mother.  Morbidly curious, you ask how Uma took care of Loppe’s little leaking problem.

“Morning drainings, dear.”

Drainings? You repeat in a puzzled tone of voice.

“Yes.  Before Loppe went out for the day, I would help her relieve the tension in her undeveloped balls.  Nowadays she can handle her heightened production just fine, but back then her balls weren’t that big, so she couldn’t stand her own body’s metabolism.”

You can’t resist chuckling and declaring Loppe must have enjoyed that.

“Not so much, as a matter of fact.  I mean... how would you feel if your mother had to give you a handjob every morning so you wouldn’t soil your pants.  Sure, my little trotting hopper did try to do it herself, but she lacked the technique to fully drain herself... which still resulted in messy underwear. And as if doing it every morning wasn’t enough, she had to do it at night too... or she’d wake up in a messy bed too.”

You cluck your tongue; how did the two of them manage to put up with Loppe’s puberty?

“With lots of patience, love and a helping hand.”  Uma giggles, making a small pumping motion with her hand, as if stroking an invisible cock.

You chuckle at Uma’s sense of humor; she’s so proud to be a dirty old mare, now isn’t she?

(If PC is Feminine){
“Old? Why you... take off your clothes and hop on my table, I’ll show you old!”  Uma replies with indignation.  “I promise you that by the time I’m done with you, you won’t be able to stand on your two feet, [or whatever the term is for you,] then we’ll see who is old!”

}
(else){
“Old? Why you... if you were girly enough to be my type I would show you who’s old!”  Uma replies indignantly.  “I promise you wouldn’t be able to stand on your two feet, [or whatever the term is for you,] then we’d see who is old!”
}

So, she’s not denying she’s a pervert and proud of it?

“Pervert?  Yes, though I fail to see what is so wrong with liking sex.  You only get to live once, dear... might as well as make the best with what you have, no?  But old... never call me old!  If anything I’m still in my prime!  Or you don’t think I’m good-looking enough, by any chance?  Be careful with what you say though, dear.  I don’t mean to threaten you, but I do know all pressure points in body... any body...”  Uma glares at you, waiting for you to utter the right answer.

You tell her that, yes, she’s definitely a real silver fox - or silver mare, or whatever the term is for an attractive older woman is.  Why, you can only hope Loppe takes after her mother when it comes to keeping her looks as she ages.

“Good answer.”  Uma snorts.

So, Uma really thinks dealing with Loppe’s puberty wasn’t so bad, you ask?  If Loppe’s father had stayed, would she have been willing to go through it again with her next daughter?  And would she have been so cheerful if her rabbit lover had given her a bellyful of twins or triplets instead of just one lonely little Loppe kit?

Uma looks distant for a moment, but quickly focuses back on you.  “Dear, when you’ve been through what I have, you learn not to dwell on what could have been... and instead focus on what is and it’s blessings.  I’m very fond of Loppe and I wouldn’t mind if she had brothers or sisters.  Usa-chan might have disappeared, but her parting gift wasn’t so bad, I think.  She left me with a bundle of hope I named Loppe, and I’m thankful for having my little laquine in my life.”

You apologise for sticking your foot in your mouth, and tell Uma you’ve clearly kept her talking long enough. 

“Oh, it’s always a pleasure to talk to my little Loppe’s [boyfriend].”  Uma smiles at you happily.  “Though call me old again and I’ll make your life a living hell.”  She adds, still smiling happily.

You get your things and get ready to leave - before you can bring yourself to go, however, you can’t resist asking; Uma said the other kids in the village where Loppe grew called her “Furutama”. What does that mean?

“It means full balls, dear.”  Uma states matter of factly.

You blink in shock, then stifle a laugh.  Yeah, that sounds like Loppe, alright.  You shake your head with a smile, thank Uma for talking to you, and then head off again.*/

		}
		
		/**
		 * Loppe Talk - Loppe's Last Girlfriend
		 * whoaboy.
		 * Edit Status: SHOOT ME.
		 */
		public function talkLoppesLastGirl():void
		{
			/*
			“Oh, I know what would be a great story...”  Uma smirks at you.  “ How would you like to hear about my little laquine’s first time with a girl?”

You give it a thought, and tell the mare MILF that would be nice; you’re curious about just what Loppe’s dating life was like before you met her.  Oh, she talks a bold game, but you’re not entirely certain she’s being honest with you...

“Very well, please take a sit, it’s a bit of a long story.” Uma suggest, motioning at a nearby chair and taking a seat herself.

You follow her instructions, wondering just what kind of doozy the mare has to share with you this time.

“Back in our old village, there was a prostitute that went by name of Puffy Lips... but we just called her Puff.  Loppe had just blossomed into a beautiful young lady, so it’s no surprise she drew plenty of stares when she walked around the streets-”

Wait, her mother actually named her Puffy Lips?  Seriously? You interject.

Uma chuckles.  “Of course not, dear.  This was just her street name... though her last name was Kuchibiru... which means lips...”

You shake your head, not sure if you want to ask why she’d use such a street name.  You tell the mare to continue; she was saying that Loppe had been blossoming into a pretty young herm who caught the eyes of many in the village?

“Yes.  One day, I had my little Loppe take a request to the local carpenter, which happens to be close to where Puff used to... hunt.”

//Cutout Starts here

Years ago in a village to the east...

Bored.  She was utterly, totally bored... there are good days, and there are slow days... but today wasn’t just a slow day, it was completely, dead.  Not even her regulars came to see her...

Puff had been standing in her usual corner next to the carpenter... the old man, being a fan of her services, didn’t mind having her hang around.  However, apparently he was way too busy to... indulge.  So Puff had been left all alone... and bored... so bored.  It does not do well for a nymphomaniac like her to stand in a corner for so long without a big cock shoved between her legs... or hell... even a fine pussy to lick... One of the perks of being bisexual... anything goes!  She laughed to herself, yes, anything goes indeed... but today... nothing seemed to be going... or is it coming?  The slutty wolfess chuckled to herself at her own joke.  Maybe she should go home and whip out her “old thrusty”.  That’s what she liked to call her carved-wood dildo... 

Loppe hummed to herself as she made the way through the familiar, but seldom visited,  part of town where the local carpenter made his trade.  Mom had warned her to be wary of strangers, since this side of the town was full of people with questionable interests... or so said mom.  Thus far she hadn’t seen a single weird individual.  Most people she passed by seemed to be busy with their own tasks; fishermen carrying buckets of fish to sell on the main street; mailmen busy with deliveries and the occasional street performer buying make-up for their street shows.  Along the way, Loppe stopped by a bakery to eye what tasty delicacies they had to offer.

“Can I help you, dear?”  The cat behind the counter asked.  “Oh, umm, no thanks miss, just browsing, that’s all.”  Loppe smiled.  The elderly cat smiled and replied, “Aren’t you a cute little thing?  If you see anything you’d like, don’t hesitate to call.”  Loppe nodded and continued browsing... until her eyes set upon a, fresh out of the oven, slice of carrot cake.  Being part rabbit and part horse, two species known to love carrots, Loppe’s mouth instantly watered... She eagerly looked into her small purse, but all she had were a few coins... not nearly enough to buy the cake... Loppe sighed, well... best not dwell... maybe when she came home her mother would be willing to reward her with some coins for her service?

With that in mind, Loppe made her way towards the carpenter...

Puff was on the prowl, trained eyes of a master, quickly scanning the crowd for a potential customer... or heck... just a tryst would do.  She was getting so desperate for a quick shagging she might actually work for free... But everyone seemed to be so busy, that no one even turned their heads to look at her... the only one not busy was that young bunny browsing the cake shop...

Puff sighted... yep... old thrusty was going to see some action today...  She was about to turn and head home when a sudden gust of wind hit her right on the face with a stray piece of paper, struggling to remove the offending paper with a growl, she saw it... it was as if Marae herself had answered her pleas... fourteen inches of equine deliciousness, with a pair of heavy, cum churning balls swinging under it... it was enough to make her lick her lips with a wolfish smile... and who was it attached to?  Slowly looking up... what the?... That was the young bunny girl she saw browsing the bakery earlier! The young bunny quick used her hands to push her short robes down and hide her package, looking left and right to see if anyone had spotted her, then sighing with relief... that must have been embarrassing... but luckily... someone did spot her!

Somehow... then and there... Puff just knew she HAD to have that young bunny over for lunch... taking a quick look at her pocket mirror to see if she was presentable enough she cleared her throat and stroke out the sexiest pose she could while leaning against the wall to the carpentry.

When Loppe approached the carpentry, written request in hand, a melodic, feminine voice called,  “Hey, bunny-girl!”

Loppe blinked in surprise, wondering who that was.  “Yes?  Who?” She began, looking around and then realising who was calling to her.  “Oh, Ms. Puff, hello.”  She replied, quietly.  She still wasn’t really sure why her mother and everyone else seemed to call her “Puffy Lips”, or “Puff” for short - though she had to admit, the she-wolf’s lips certainly looked kissable... She licked her own lips nervously; the busty wolfess had been a prominent star in more than a few wet dreams before now.  She felt a distinctive twitch from her nethers and cursed in the privacy of her head, quickly falling into the breathing exercises her mom had helped her develop to help her control little “incidents” like this.  In a meditative fashion she inhaled and exhaled, hoping to quell her erection before it grew to full prominence.

“Hey... are you okay?”  Puff asked, as the girl seemed to be having some trouble with her breathing.

“I-I’m fine.”  Loppe squeaked, unable to look the wolfess in the eye and, indeed, trying to avoid looking at her at all, lest she be drawn to the she-wolf’s gorgeous, big, beautiful, soft, wondrous breasts...

“Aww... don’t be like that.  You can tell Puff all about your problems, dear.  Unless... your problems have something to do with this?”  She opened her own robes, displaying the pair of orbs sitting upon her chest, nipples erect and pointing accusingly at Loppe.

“I-I-I...”  Loppe stammered, the laquine trailing off as her gaze fixated on the massive orbs that transfixed her, like a mouse caught under the eyes of an owl.  One of her more recent dreams came to mind, and unthinkingly her fingers flexed, itching to squeeze and caress those beautiful boobs.

“You know... I was looking at you browsing the bakery earlier... and I couldn’t help but notice what a pretty friend you have...”  The wolfess teased with a smile.  Loppe blinked her eyes in confusion.  “Friend?”  She repeated softly.

The slutty wolfess grins seductively before reaching towards the laquine’s groin and gently feeling her up.  “This friend, I mean.” Loppe squeaks in shock, hardly daring to breathe in her surprise at what’s happening. “You should let him out once in awhile.  It can’t be good for you to keep him cooped up for so long, dear.”  Licking her lips and sucking on her index finger absent-mindedly, Puff adds.  “If you want... I’d be happy to show you why I’m called Puffy Lips.”

Forcefully, Loppe leaps away, blushing like mad.  “I’m sorry, Ms Puff, but I’ve got to deliver an erection - I mean, a request from my mom and then get back home, right away!”  Puff clicked her tongue.  “Oh, surely you can spare a few minutes with little me?  I promise I don’t bite... much.  Plus your friend down there looks like he really needs it.  How about it?  Just pay me a few coins and I’ll give you the time of the day.”  She winks.

“P-pay you? I don’t even have the money to pay for a piece of carrot cake!”  Loppe stammers, taking several steps back, powerful lapine legs already flexing in anticipation of making a dash for the carpentry before things could really get embarrassing.

Shit!  If she didn’t do something quickly, Puff was going to lose that nice horse-cock of a girl and have to resort to old thrusty!  “W-Wait!”  She yelled before the laquine could bolt away.

“W-what?”  Loppe asks, still ready to flee, but too curious - and, despite herself, turned on - to resist.  “Tell you what... today is being really slow... so let’s make a deal. You come with me and let me take a closer look at your friend, and I’ll let you do whatever you want with these.”  She gently lifts her boobs.  “For... F-R-E-E.”  She smiles.

Loppe just stood there, poleaxed... She had the nagging worry that, if she did this, her mother would be so mad with her.  But, at the same time, this was Puffy Lips, the she-wolf who haunted her most erotic dreams.  What to do...

Realizing that Loppe still wasn’t convinced she hurriedly added, “Okay... let’s sweeten the deal... come with me and I’ll even buy you a slice of carrot cake. What do you say?”  Puff looked at her expectantly,  tail wagging worriedly behind her.

A free live reenactment of her wet dreams with a sexy she-wolf, plus free carrot cake!?  Loppe made the only answer she could.  “Okay.  But I absolutely have to do this job for my mom first - she’ll be so mad if I don’t get it done.”  She declared.  Grinning wolfishly Puff replied,  “Fine, go ahead, I’m not going anywhere... but do hurry, hmm?  Also... what’s a cutie like you called?” 

“...Loppe. My name’s Loppe Kemono.”  The laquine answered.  “Good... I’ll remember that.  So hurry along with your task, Loppe, and when you’re done go to my place, over there.”  She points towards a small house a little ways away.  Slowly approaching the laquine, she whispers in her ears.  “I’ll be waiting...”  With that the wolfess sashays away to her home.

Swallowing nervously, heart pounding like a drum, Loppe does her best to not watch Puff go - she’s already hard enough, after all.  Long minutes pass as she tries to quell her raging erection, and then finally she remembers what she’s supposed to be doing and heads to the carpentry store.

Back in her house, Puff goes to the bathroom to freshen up and prepare for the young laquine.  But first... she should add the laquine’s name to her list.  Being a hooker and proud of her trade, she kept a list with the names of all customers she’s serviced in the past... it was sorta like a trophy list... but she marked the people who had been able to pleasure her the most, for future contact.  Well she hoped this girl knows how to use her pony, she really needs more favorites on her list... Humming to herself she quickly retrieved the notebook from the cupboard nearby, and carefully added Loppe’s name to it.  Then closed it and stripped naked, those clothes would only get in the way...

Moments later in Puffy Lips’ house...

Loppe, swallowing nervously, mustered her courage and managed to knock loudly on the she-wolf’s door.  She could hardly believe she was about to do what she was going to do... 

“It’s open.” Loppe hears through the door. Well... here goes...

Loppe swallows hard, at once loving and hating the foot-long cock already beginning to thrust itself into a tattle-tale bulge in her dress, eyes fixed on the scantily clad form of her soon-to-be lover.  She greedily drinks in the sight of the wolfess’ plump, kissable, cock-sucking lips framing her gorgeous face, her beautiful orange eyes hooded in sultry anticipation.  Down her gaze sweeps, over the mighty swell of Puff’s bosom, the great mammary orbs covered in her beautiful coffee-cream fur, past her breeder’s hips and oh-so-fuckable ass to the swollen, greedy, fem-pre-seeping netherlips from which the whore takes her street name.  Loppe’s nose twitches, eagerly drinking in the heady, intoxicating scent of Puff’s arousal until she feels drunk on smell alone.

“See something you like?”  Puff asks, grinning seductively.  “I can tell you want me... that longing gaze of yours... bet you caught a whiff of my scent, no?  Bet that bulge hidden under your clothes is bothering you too, no?  Want to touch me?  Want some S-E-X?  Maybe see why I’m called Puffy Lips?”  Puff teases the young laquine, trying to entice some courage into the nervous Loppe.

Mindlessly, Loppe shrugs off her dress, letting it fall abandoned to the floor.  Cock thrusting before her like a spear, the rabbit-horse herm strides towards the wolfess with an incongruously predatory air.  Her only thought in mind: to bury her shaft into Puff’s waiting hole.

“Oh, is that for me?  Lovely!  I love it!  I want to take it for a test drive right now!”  The wolfess giggles, falling back onto Loppe’s bed and spreading her legs wide to allow the laquine’s throbbing member easy access to her own plump, well-used vagina.

With a mighty spring of her powerful rabbit legs, Loppe pounces bodily upon the wolfess, kissing her so fiercely she might as well be biting her in spirit.  With the clumsiness of the eager virgin, she grinds her cock into Puff’s muff, too impatient and unsure to properly slot herself into place.

Puff, being an experienced lover, takes hold of Loppe’s rock-hard horse-prick and gives it a squeeze, drawing an excited gasp from the eager laquine.  “This looks painful... better do something about it!” Puff teases, aligning the shaft with her own throbbing pussy.

“P-please!” Loppe begs, grinding and thrusting herself into the she-wolf’s hand.  All sanity is gone; all that remains is the need to fuck and breed, to strip herself of her masculine virginity at last.  Puff simply releases the laquine’s member and grins at her.  “No one is stopping you dear... all you gotta do is hit the right spot!”

With a groan, Loppe immediately thrusts herself home, sinking herself to the hilt in one brutal thrust.  “Ow!  Not so rough!”  Puff protests.

“Sorry...”  Loppe moans, shuddering at the strange, new, absolutely wonderful experience of being surrounded by the she-wolf’s warm, wet cunt.

“It’s okay... I’m fine... feeling good?”

“Yesss.” Loppe hisses.

“Good.”  Reaching behind Loppe to gently brush at her equine tail and grab her hips, Puff continues to instruct Loppe on the finer points the female anatomy.  “Now thrust your hips like this... right there,”  She says, gently pulling the young laquine towards her.

The laquine gives herself over to the ministrations of her more experienced lover, anxious to learn how to make this feel even better than it already is, tongue lolling out in bliss.  “This... this is incredible, Puff!” She gasps.

The wolfess giggles.  “Careful Loppe, don’t want to shoot too soon, do you?”

As if speaking the words of prophecy, Loppe cries out, arching her back and rolling her eyes as a familiar-yet-different sensation boils its way up from the depths of her heaving, churning, quaking balls.  A great flood of cum erupts out of her depths, gushing into the wolf’s waiting pussy as the laquine squeals her ecstasy.  Moments later, her load is shot and Loppe slumps over, heaving for breath.  However, her cock remains stiff and erect, and she keeps herself locked into her lover’s pussy, deliberately thrusting inside and doing her best to use her flare like a wolf-herm would use her knot.

“Still hard?  Well I guess that can be expected since you’re young... no problem.  Puff knows how to deal with your kind.”  She gives Loppe a grin that can only be described as... wolfish.

Loppe grins back at her, just as wolfishly, eyes burning with lust.  “You mean it?  I can go again?” 

“Of course you can girl.  You’re not satisfied yet, are you?  I sure ain’t... we can keep going until you’re completely sated.  Not start fucking me.”  Puff begins bucking against Loppe, eager to get her started once more.

Loppe squeals, and then she starts to thrust back and forth herself, eagerly pistoning herself into Puff’s pussy once more.  “So, we get to do this until I’m too tired to cum anymore, right?” She giggles with anticipation.  “Goody!  This is a lot more fun than using my hand... maybe I’ll be done in an hour this time, instead of an hour and a half!”

At this Puff’s ears suddenly perk up as she looks at Loppe, startled.  “Oh... wait... Ah... did I hear you right?  Oh, yes... an hour and a half?”

“Yeah, that’s about normal for me to use up all the cum in my balls.  Horse half gives me balls with lots of room in them, rabbit half lets me make more cum fast.” Loppe grunts, continuing to thrust into the she-wolf even as she talks. 

Puff starts having second thoughts about this arrangement.  “Err... maybe we shouldn’t go at it this long... Ah... it might not be healthy.”

“What? But you promised!” Loppe pleads, eyes widened to make herself more appealing.  “Plus, weren’t you ‘going to fuck me until you ran my balls dry’?”  She quotes the wolfess jokingly.  “I thought you took pride in being a... Yesss... a whore, and never left a customer unsatisfied.”  Loppe continues to tease.

“That sounded like a challenge... okay!  You’re on bunny-girl!”  Puff replies with a grin.

Many orgasms later...

“I... oh, oh Marae’s bounty, I’m cum...” Loppe trails off in a moan as cum explodes from her one last time.  “I...Marae... I’m fuh-finally done...” She groans, sliding bonelessly forward onto her partner, a landing that is well-cushioned by both her lover’s swollen, heaving breasts and the pregnant-looking fluid-filled bulge of her gut. 

Puff’s fur is completely caked with spilled laquine cum; her eyes have since rolled to the back of her head; her well-used pussy is now gaping open and oozing cum out of her bloated belly.  In her current state, all Puff can manage is one last dry heave as her tongue lolls out of her mouth and she closes her eyes, passing out.

“You... That was incredible, Puff.  Thanks.”  The laquine give a peck on the comatose she-wolf’s cheek.  “Sorry, but I really have to get back now.”  She says, redressing herself and making her way home.

As she began heading merrily home, the laquine whistled with glee; she just got laid!  And by the utterly gorgeous Puffy Lips, no less!  Nothing could ruin her day now... at least, not until she took a look at the sun...

“Oh crap!  Mom’s gonna kill me for staying out this late!”  The half-breed wailed, clasping her head in anguish.  She promptly began sprinting home at full speed, desperate to get there as quickly as possible and assuage the full fury of a mother whose daughter is out past her bedtime.

//cutout ends here.

...That, you finally manage to say, was quite a story.  So, was Uma really that mad Loppe was out late?

“Not that much, no.  I grounded her of course... but when I learned what she had done... then I was really mad.  I taught my little girl better than to hang out with Puffy Lips and her kind.  Though I suppose some good came of it... since she stopped having wet dreams about that vulgar wolf bitch.”

Having done it with her for real meant the dreams were no longer interesting? You suggest.

“I don’t really know... perhaps that is what happened, or maybe finding out what happened to Puff is what put her off.  I can’t tell.”

What happened to Puff? You repeat, warily.  So, something happened between them?

“No, nothing happened between then.  Puff wasn’t type of person to take a girlfriend or have anything to do with anyone... she’s always been a free spirit in that regard.  I mean, she wasn’t the only prostitute around, she was just the most notorious one.  Being a nymphomaniac had a hand in that, I suppose... but back to the question at hand.  Several days after Loppe’s little tryst with Puffy Lips I head an interesting bit of gossip from a client.  I heard Puff had joined the local convent.”  Uma grins.

You can only blink at that and flatly ask why; as startling as it probably was the first time around, you would have thought someone like Puff would, after she had recovered, jump at the chance to keep Loppe as her permanent personal fuck-toy.

Uma chuckled to herself.  “Apparently Puff was cured of her nymphomania, so she no longer cared that much about sex.  She became a real upstanding citizen too, doing charity, caring for the orphaned children, basically she became an exemplary nun.  I guess after having sex with my little Loppe was too much for her... serves her right for trying to seduce my little Loppe.”

You can only shake your head and tell her that you find that hard to believe.  After all, you and Loppe are still going out, and you’ve had sex more than once, haven’t you?  But, regardless, you can’t help but feel sorry for Loppe; that must have been a real kick to the ego.

“To be honest, I don’t think she minded it too much... from what I hear Puff still had a tryst or two, even while in the convent... then again this could all be just rumors... I never did have the chance to talk her after the event.  Apparently she left on a mission a few months after joining...”  Taking a deep breath, Uma smiles at you.  “Tell me something, [name].  Does Loppe tire you out?  In sex I mean?”

You admit that Loppe is a handful and a half.  Still, not enough to make you go celibate, certainly.  You ask why Uma is asking?

Uma smiles.  “And that, my dear, is why you’re special.  You’re the first person to actually be able to handle Loppe.  Usually she wears out her partners so much that they need a few days to recover, but she tells me that all you need is a little rest and you’re already good to go.”

You admit it can’t be that hard, surely?  You’re not even from this world, you should be worse at it than the natives like Loppe herself are.

Uma shakes her head lightly.  “I don’t know what it is, dear.  But you’re able to keep up with my little Loppe, while no other person, that we’ve met so far, is.  I suppose that’s also part of the reason she chose to make you her official [boyfriend].  Much to the chagrin of her admirers.”  Uma chuckles.

You can’t resist a wry joke about Loppe having admirers when she’s known to be so untameable in bed.

“You’d be surprised with how much people actually enjoy Loppe’s stamina?  Though anything more than a one night stand with her would surely put them in a coma for a few days.”  Uma chuckles.

You thank Uma for telling you about her daughter’s life and then apologise, as it’s time for you to head back to camp.

“Not a problem, dear.  I hope you will continue to maintain a healthy relationship with my daughter.” Uma chuckles.

You promise her that you’ll try, gather yourself together, and then politely head back to camp.*/

		}
		
		/**
		 * Talk Loppe - Loppe's First Boyfriend
		 * Edit Status: FUCK ALL
		 */
		public function talkLoppesFirstBoyfriend():void
		{
			/*
			“How about I tell you about Loppe’s first boyfriend?”  Uma suggests.

You tell Uma that sounds like an interesting story, and you kindly ask her to proceed.

“Okay.  This happened a while after my little Loppe blossomed into pretty young lady.  She used to go to this art school, where she learned how to dance, and one of her colleagues was a black cat boy by the name of Hyou.  He was very handsome... had green eyes that resembled polished gems, his black fur was always well kept and on top of all that he was nice, someone pleasant to be around.  He was Loppe’s senior and was the first person to greet her when she started attending the school.”

You can’t resist joking that, if you didn’t know about Uma’s tastes in lovers, hearing her talking about him in such glowing praises would make you half expect the reason they broke up to be because Loppe found him fucking her mother one day.

“Don’t be silly, dear.  If you knew him as well as I do, you’d know there is absolutely no way there could ever be anything between us.”

You ask her exactly what she means, feeling she’s talking about more than sexual incompatibilities here.

“If you really want to know, you’ll just have to listen to my story.”  Uma smiles.

You laugh softly and promise to shut up and listen.

“Very well.  He was always surrounded by girls, it’s tough to find someone as good looking and as nice as he was, and initially Loppe wasn’t very close to him at all... that came later, when my little Loppe was having troubles keeping up with the class.  Turns out Loppe had absolutely no talent when it comes to dancing... and since she was so determined to become a good dancer, Hyou offered to tutor her.”

You note with admiration that Loppe must have worked hard; she dances so wonderfully now, you’d hardly believe it was entirely hard work instead of at least a little natural talent for it.

“Back then, there weren’t many people who knew about Loppe’s extra appendage, so they all just assumed she was a girl.  Hyou was the same, but...”

You ask how that could have happened, given the mentions Uma and Loppe have both made of her gender posing... difficulties during puberty.  Did Uma and Loppe end up moving to a new village where they didn’t know about Loppe’s hermaphrodite gender?

“If you know the right people, changing your gender is not so difficult, dear.  People just assumed she paid a visit to the local shaman... She is not ashamed of her gender, but it’s not something you go advertising everywhere you go either...”

Ah, you reply.  So that’s it, you note to yourself; her accidents happened before she grew her boobs and female curves, resulting in them believing she was a boy who changed himself into a girl, rather than having been boy and girl at the same time all along.

“Well, one day while dancing Loppe’s shorts ripped up and exposed her... right in front of Hyou, too.  Needless to say, she was very embarrassed to be in such a predicament.  But Hyou... well... he gallantly helped Loppe to her feet and loaned her a towel so she could head home.”  Uma laughs, reminiscing the event.

You smile and note that’s one odd way to get into a girl’s good books.

“Anyway... Loppe had always admired him and his feline grace while dancing, and after the incident, she was thrilled to know that Hyou hadn’t spoken a single word about Loppe’s gender to her classmates... or anyone else for that matter... in fact... they just became closer.  Hyou continued to tutor Loppe, and slowly she got better and better, until one day Hyou surprised her with a request... do you know what he said?”  Uma asks, clapping her hands together lightly.

He asked her if they could make love?  You suggest.

“No, silly.  He asked her out...”

Well, that’s a surprise, you say; you didn’t think people still took it that slow in Mareth.

“Not everyone is crazy about getting into each other’s pants all the time dear...” Uma scolds you.  “If we did that all the time we wouldn’t have to do anything but sleep with each other all the time, you know?”

You apologise; there’s so many monsters out in the wilderness who do think precisely that way that it’s hard to remember there are still normal people, sometimes.

“It wasn’t always like this... back then we were just simple people trying to live simple lives...”

You admit that, and tell her to continue.

“So they started dating.  And as is normal for a young couple, one day, after they had come back from a nice dinner... he suggested that he wanted to see Loppe naked.”

//Cutout starts here.

“There’s no need to be ashamed Loppe... I’m your boyfriend... and all I want to do is see my beautiful laquine girlfriend in all her glory.  You aren’t going to deny me that, are you?”  He asks hopefully. 

Loppe swallows, hands flush over her crotch in an effort to conceal her swelling erection. ‘Why am I such a sucker for sweet talk?’ She mentally laments.  “I...I don’t want to deny you, Hyou, but... are you sure?  I mean, I haven’t forgotten that you didn’t say anything about it to the others, but there’s a difference actually seeing it up close...” She pleads.

Hyou smiles and closes the distance between them, gently hugging Loppe and pulling her into a tender kiss.  Once they break he whispers in her ear, “I know what you’re hiding in there... and I really want to see it again... won’t you show it to me again?  Please? Purrrrrty please?”

Blushing through her fur, Loppe nods her head. “O-okay.  Just remember, you asked for it.” She warns him weakly.  Taking a few steps back, literal ponytail swishing gently on her rump, she slips out of her shorts, letting them slide down her legs onto the floor, and then lifts her shirt for added measure.  “There.  Can you see it now?”  She asks, trying to be bold, but unable to look the cat in the eye or keep herself from blushing.

“Not quite... but let me help you.”  He boldly reaches forward and gives Loppe’s equine-prick a few strokes, coaxing it into a full blown hard-on.

The rabbit-horse moans softly as it swells to all fourteen inches of mottled pink horse-dick, jutting erect and proud, defiant of its mistress.

“Now, that’s better...” Hyou says, circling Loppe to examine her from every angle.  “Hmm...yes.  Truly beautiful...”  He comment, purring softly.

The bunny-pony blushes and wriggles.  “Y-you know, it’s really weird you telling me that?” She protests in a half-hearted fashion.  “But... If I gotta show you mine, then you gotta show me yours!” She says, trying to sound more confident than she really is.

Hyou chuckles.  “I thought you were never going to ask!”  He slowly strips himself, dancing and prancing as he removes each piece of his garments until, with a flourish, he finally peels off his underwear and carelessly disposes of it, tossing it away.  “And this is my birthday suit.”  He grins.

Loppe’s eyes lock onto his nakedness like a starving wolf onto a bloody steak, greedily drinking in the sight of him, particularly focusing with eagerness on his jutting, spiky-looking cat-dick.

Hyou looks between his erect kitty-prick and Loppe’s own horse-cock, noting the obvious difference in size.  “Well... well... not only are you taller than I am... you’re also bigger in that department too...  I guess it’s to be expected... I am competing with a horse-bunny after all.”  He winks at Loppe.

The aforementioned “horse-bunny” blinks in confusion, then realises that the shaft she’s been staring at is anywhere from one-third to one-half the length of her own, and she claps her hands over her mouth aghast.  “Hyou, I’m sorry, I...”  She begins, half-expecting a rejection because of this fact.

“Sorry for what?”  Hyou interjects.  “I knew what I was getting into when we started dating.  Relax Loppe.  When I said you were beautiful, I meant all of you, even this hefty pony you carry between your legs.”  He grins happily.

Loppe smiles softly.  “You are such a flatterer, you know that?  But, enough with the foreplay - when do we get to the combobulating?” She mock-whines.

“Combobulating?”  Hyou asks in curiosity.  “Where did you hear such a word?  And what does it even mean?”

“From one of my mom’s books - you know, the ones that have blank covers on?  And what do you think it means, given the context I’m using it in?  Now, are you taking me to bed, or am I going to have to push you into bed?”  She laughs, giving a playful growl to underscore that her confidence is up and she’s ready to fuck.

“Only if you can catch me.”  Hyou raspberries Loppe, getting ready to avoid his girlfriend’s lusty advances.

With the best growl she can manage, the horse-dicked rabbit hops through the air to snatch her feline boyfriend, but he jumps away with a laugh.  Gracefully he dances around and around the bedroom, the increasingly frustrated rabbit trying to cut him off.  Finally, with one perfectly timed leap, she slams into him and knocks him over onto the bed with a mutual ‘whoof!’ of startled shock.  Belly to belly they catch their breath, and then Loppe rises back up, completing the pinning maneuver.  “Haha, caught you!”  Loppe taunts, then blinks in surprise; what’s that funny-nice feeling?  Rearing back, she looks down at their two bellies, seeing their mutual erections rubbing their sensitive flesh against each other, a sight which makes her blush.  “S-sorry, Hyou, I didn’t mean to...”  

“Don’t worry about that, I don’t mind.  So... you managed to catch me... what do you intend to do with me now?  Hmm?”  Hyou asks, ears twitching cutely.

She trails off, looking at the smug smirk of the cat beneath her.  “Alright, time for fooling is over; let’s try something from one of my mom’s books.”  With the awkwardness of someone who’s never actually done this before, Loppe pivots in her “seat” in Hyou’s lap, rotating around until she’s facing away from him.  “Okay, let me see... just gotta find your dick... damn it’s hard to do this when your own dick is in the way.” She mutters to herself, wriggling around in an effort to try and line up her waiting pussy with Hyou’s shaft.

Hyou moans as Loppe gyrates her hips.  “That feels good... even if I’m not in yet...”  He begins gyrating his hips as well, rubbing himself against Loppe, which only serves to make Loppe’s task more difficult.

Loppe moans.  “Y-you know, if you want to help, you could try and slot this into the right hole, instead of rubbing it against my pussy - yee!  I think you just rubbed that one through my balls and up along my cock!  Where are you aiming?” She shakes her head strongly, coincidentally flicking her partner in the face with her ears. “Okay, that’s it, stay still - let me handle this.” Loppe  commands. 

Hyou laughs.  “Okay... okay... I’m sorry, couldn’t resist it!  You look so cute when you’re frustrated!  Alright then... I’ll hold still...”  He says, gently guiding the tip of his feline-cock towards Loppe’s drooling pussy.  “There, I’m even helping this time.”

“If I could reach you from this position, I’d kiss you.” Loppe proclaims happily.  Her tail swishes across the cat’s belly with anticipation, while the rest of her holds still, ready to be penetrated.

“Just sit down and I’ll be inside.” 

Loppe needs no further instructions and promptly flops down; luckily for her, the active lifestyle of a rabbit/horse hybrid means she lost her hymen as a result of an awkward leg positioning some time ago.  This doesn’t keep her from squealing in pleasured shock as she envelops her lover’s cock in one go.  She sits there, feeling the strange yet wonderful sensation inside her belly from her partner’s cock, doing her best to squeeze and grip the intruding appendage with her pussy, like feeling it with her hands.

Hyou purrs and moans, hands moving to hold Loppe’s hips steady.  “You know... as good as your pussy feels, unless you start moving nothing’s going to come, right?”

Wordlessly the laquine nods and begins to rise up and down, moaning and hissing as she truly loses her feminine virginity, riding her feline lover clumsily, but enthusiastically.  “This... oh... this feels so good, Hyou!”

The feline moans.  “Yeah... so good...”

Addled as she is by pleasure, Loppe can still hear the reaction.  “Hey, what’s wrong?  Aren’t you enjoying this?  I know I am!”

“No!  I mean yes!  Of course I’m enjoying it... wow this feels great!”  He says, trying to save face.

“Well, you don’t sound too happy... what’s wrong?  You just not like this position?”  Loppe asks, trying to be understanding.

“I’m sorry Loppe... I don’t know what’s gotten into me... it does feel nice, but I’m just not feeling... y’know.  Maybe it is the position... try turning around?”  He suggests.

With a moan as the action stretches her in just the right way, the laquine awkwardly spins around, leaving her pre-dribbling dick and balls slapping against her feline lover and her breasts positioned right in front of his eyes.  “I’ll try not to give you a facial when we really get going, okay?”  She promises.

Hyou’s shaft throbs, dribbling pre within the laquine’s depths.  “Oh yesss...”  Hyou purrs.  “Now that’s a sight I can appreciate... and personally?  I don’t mind if you do give me a facial... but I appreciate the consideration, now get moving girl!”  Hyou says, excitedly.

Excited, Loppe resumes her bouncing, unthinkingly rubbing her cock against her lover’s belly and shivering at the extra friction on its engorged, sensitive surfaces.  “Ah, Hyou, you feel so good inside of me!”  She whimpers.

Hyou moans and groans, eyes glued to Loppe’s bouncing shaft.  “Yeah!  It feels great!  Slap my belly with that big pony of yours!”

“K-kuh!-kinky b-buh-boy!” Loppe groans, reaching out and grabbing his head and pulling him into an embrace, coincidentally planting his face right amongst her breasts even as she continues to grind her cock into his belly.

“Oh babe!  You’re so sexy! I knew I picked a winner when I first saw you... Ah! Almost there!”  He yowls, bucking against Loppe.  “Damn that horse-cock of your!  Bouncing around!  Slapping my belly!  Teasing me!  Ah!  So hot!” 

A distant part of Loppe’s mind catches these words and files them away with suspicion.  The rest of it is too busy melting at the sensations of losing her female virginity.  She continues to eagerly buck and thrust and impale herself, anxious in pushing on to her first “real” climax as a woman.

Hyou yowls one last time and bucks against Loppe, his claws digging on her his as he goes cross-eyed, looking straight at a dollop of pre that seems to have formed on the flared tip of Loppe’s member.  Finally, he relaxes and lets his orgasm overtake him, spewing rope after rope of cum inside Loppe’s eager pussy.

The laquine moans in pleasure at the sudden sensation of being filled... then blinks in surprise as she feels the cat-prick inside her needy pussy going soft.  “What’s wrong?  What happened?” She asks, baffled; she tries to ride the limp dick a little more, but it’s futile.

Panting, but unable to hide the rumbling purr rising from his chest, Hyou sighs.  “S - Sorry Lops.  That was... AMAZING... couldn’t help myself.”

“That’s all well and good, I’m feeling pretty amazing myself, but I’m not done yet!  Come on, get hard again so we can keep going - you can’t be feeling all limp already, not after just one cum!” The frustrated laquine declares.  She continues to rise and fall, “come on, surely you can go for at least half an hour!”

“H - Half an hour!”  Hyou groans, flopping on Loppe’s bed limply.

“That’s normal, isn’t it?  I mean, I can go for three times that long before I’m sated...” Loppe asks, nervously.

Hyou rises his head.  “Normal?  I came once and am already spent... you are kidding right?”  He asks, laughing nervously at the frustrated laquine.

“So what am I going to do?  I haven’t even cum once yet!” She whines.

Sighing, Hyou looks at Loppe’s cock... then back at Loppe... he smiles.  “Tell you what.  Since you let me fill you... and I just can’t get another erection for a while... how about I let you fill me instead?  Would you like that?”

“But... I wanted to be fucked like a girl... besides, you’re a boy, I can’t fuck you with a cock.”  The laquine whimpers.

Figuring it’s pointless to argue with Loppe in her current state, he takes Loppe’s cock in his hands and bends over to give it a lick; a task that proves easy, given his feline flexibility.

Loppe moans and shudders, wriggling with pleasure as a spurt of pre flies from her flared tip to splatter onto her feline lover’s face.

Hyou smiles and takes Loppe’s equine member into his mouth, sucking and slurping on it like a lollipop.

Mouth opening and closing wordlessly like a fish, the laquine’s eyes roll in her head as she is overwhelmed by the delicate touches on her over-sensitised shaft.

Finally, with one last slurp he lets go of Loppe’s cock and, smiling, asks,  “You sure you don’t want to take me instead?”

“I...okay... but, how do I do that?”  The bewildered bunny asks. “You don’t have a pussy, unless you’ve been hiding something from me, and I don’t want to just have you suck and lick on me; that’s no fun for you, then.” She notes.

“Silly girl...”  He remarks.  “Mind getting off me for an instant?”  He asks, innocently.

Confused, the laquine pulls herself off of her lover, allowing his cum-slick cock to wetly slurp its way out of her.  She scoots over to the side of the bed, wondering what he has in mind.

Hyou rolls around on his belly, lifting his tail and presenting his ass to Loppe, then casually reaches back and spreads his cheeks apart, giving Loppe a first-hand view of his, yet unused, little rosebud.  “See?  I got a hole too!”  He grins.

Ordinarily, Loppe would have protested against the idea of fucking anyone, boy or girl or herm, up the ass.  However, ordinarily, Loppe would not have been as horny as she was, and she promptly leaps up behind him, rubbing her long cock between the spread cheeks of his ass.  However, she holds back from actually penetrating.  “Hyou? P...Please?”  Loppe meekly suggests, looking at him with big doe eyes.  “Promise me you’ll take turns at filling my pussy, too?”

Moaning and purring demurely, Hyou replies,  “S - Sure.  Now jam that wonderful pony of yours in!”  He says, overwhelmed with lust.

Licking her lips in anticipation of finally being sated, the young laquine begins slowly pushing her cock against the tightness of her lover’s virginal ass...

Hyou yowls in a mixture of pain and pleasure.  “Mrrrow!  That feels great!  Ha... Loppe, babe!  Your cock feels amazing!”  He bucks back taking in even more of Loppe inside.

“Excited, are we?  Well, just don’t hurt yourself - I’m not exactly teeny-tiny here!” Loppe giggles, too caught up in the sensations of the cat-morph’s hot, tight little anus wrapping itself slowly around her shaft to be suspicious of his reactions.

“Don’t care!  Ah, Marae!  S - Shit... getting hard again!”  

“Well, make sure you get that ready to fuck me with after I get off for the first time!” The laquine boasts, even as she relentlessly pushes herself forward until she finally manages to hilt herself in her partner.  Waiting a few moments to let him accommodate her properly, she starts to thrust in and out; with her half-done state, she’s confident she’ll cum inside of him before he cums again.

One very long, messy, multi-orgasmic bout of sex later...

Hyou purrs, licking at his cum-caked arms, happily.  His belly is distended with the massive amount of laquine-cum sloshing about inside.  “Wow... I have to say Loppe... you’re one of a kind... Best sex ever!”  He sighs, continuing to lick at his arms.  “Sorry for only getting you off on your female half once.  I swear I don’t know what’s wrong with me... but it just felt so good when you started fucking me with that wonderful, big, horse-cock of yours, that I just lost it... sorry.”

“It’s okay, Hyou...” Loppe sighs.  She cradles her stomach, which looks no different than it did when she started, and looks enviously at the engorged midriff of her boyfriend, very visible proof of her masculine potency.  “Still, we’ll try and concentrate more on that part next time, okay?” She asks.

//cutout ends here.

You can’t resist dryly pointing out that maybe it wasn’t so much the girl part of Loppe that Hyou was interested in when he started dating the young dickgirl.  You would not be too surprised if Uma told you that the “next time” never came - or, at least, the version of it that Loppe wanted never came.

“Yes, dear.  I’m afraid that’s true... Hyou is as manly as a harpy, I’m afraid.”  She chuckles.  “Now you see why there would never have been anything between the two of us, huh?”

A gay man and a gay woman; the very opposite of compatibilities.  So, you ask, raising an eyebrow for emphasis; in denial, or just didn’t realise it until that first night?

“He never really fancied any girls before my Loppe, though he was friends with plenty of them, and I know for a fact he used to get plenty of love letters too.  So I would bet on him not knowing it.  Plus it was kinda unexpected, you know?  He was the son of village’s most renowned hunter, a well-known womanizer, I should let you know.”  Uma chuckles.  “I suppose he really didn’t take after his father.”

Same attitude, different sex on the receiving end, you suggest?

“After that night, yes.  He came out to Loppe too... she took it nicely, I think.  They continued to date for a while, though Loppe often had to coax him into using her pussy too... if I remember what my little ears heard right.”  She flicks her ears for emphasis.  “Those coaxings would involve the ravishing of Hyou’s ass via horse-cock.”

You comment you’re surprised Loppe took it so well; for most girls, hearing they “turned a boy gay by having sex with him” would be a major wound to their self-esteem.

“Loppe didn’t turn him gay though... come on... everything about that boy pointed towards this outcome... he was a petite cat boy, who liked dancing and didn’t hang out with guys... preferring instead to hang out with girls, and I mean that as friends, not lovers.  Not many were surprised when he came out... save for a few of the more naive girls.  Plenty of tears were shed... Loppe was fine though, she had a cute boyfriend.  Unfortunately it was not meant to be,”

He found a guy he liked better and broke up with her as a result? You suggest casually.

Uma shakes her head.  “No.  Actually they broke up because he couldn’t keep up with Loppe’s stamina... it was either break up with her or give up dancing... and walking.”

You heave a sigh; a somewhat sad outcome, you must concede, but inevitable, you suppose. A truly bisexual herm and a homosexual male probably weren’t really that comfortable with each other in a relationship anyway.  You note Loppe was probably happy, deep down, to call an end to it.

“To be quite honest, there wasn’t any bitterness in their breaking up.  And they formed a pretty cute couple too, and for a while they were satisfied with each other.  But Loppe unfortunately was wearing the poor boy down, he was the one falling behind in dancing class after that.”  Uma sighs.  “In fact... it was Loppe who suggested they break up.  They carried on as good friends though, with the eventual benefit... and Hyou said he would support Loppe all the way if she found someone she liked and that was able to keep up with her.”

You tell her that turn of events doesn’t surprise you; Loppe’s got a good heart under her breasts.  And quite a fire in her loins, too, but, hey, nobody’s perfect.

Uma laughs.  “That she does, dear... that she does.  But in case you’re curious.  Hyou eventually found another guy, a wandering foreigner, and decided to leave the village with him.  And that was the last time we saw him.  Hope he is ok, wherever he is...”  Uma looks into the distance.

You tell her that you hope so, too, but it’s time for you to leave.

“Very well, dear.  Hope you don’t disappoint... if you ever have to pick between walking and my daughter, I hope you’ll pick my daughter.”  She jokes, chuckling to herself.

You chuckle and tell her that if Loppe hasn’t chased you off despite the fact she’s twice as bad as she ever was, if not worse, then you’re not likely to make that choice against her favor soon.  That said, you take your things and head back to camp.*/

		}
		
		/**
		 * Talk Loppe - Loppe's Dad
		 * Edit Status: FUCK ALL
		 */
		public function talkLoppesDad():void
		{
			/*
			Quietly, and assuring her that you don’t want to offend her, you ask if Uma will tell you about the bunny-herm who fathered Loppe?

The mare’s stare grows distant, as if staring deep into her past, and she sighs.  “Ah, Usagi... I loved her so much, you know, [name]?”

She was special to Uma then, was she, you ask?

Uma nods.  “She was the love of my life... unfortunately, it wasn’t meant to be... she left even before I found out I was pregnant with my little Loppe... still... I enjoyed my time with her... and if we met again, I would love to spend more time with her.”  Uma smiles, though you detect a hint of sadness in her equine features.

You ask who ‘Usagi’ was, as a person?  You know she was a herm bunny-morph and that she fathered Loppe on Uma, but how did she and Uma meet, and take their relationship that far?

Uma smiles and looks to the distance.  “Usa-chan was a wandering warrior, always honorable and true, her skill with a sword was... simply... amazing.  I don’t think there’s a single person alive able to match her.  She lived by the sword, back then, always challenging other warriors to hone her skill and travelling from village to village to find better, stronger, opponents.”  Uma sighs.

“When I met her, she was just passing through our village, and had been suffering from pain in her neck area, she came to me to request my services and... well... it was love at first sight.  After our session, she asked me out of a date and I accepted.  There wasn’t a single night we didn’t go out to make love under the stars, in a hill that we came to call, our hill.  But unfortunately Usa-chan left after those 7 days.  She left me a note apologising for her departure and said that she couldn’t stay... lest she mellow and lose her edge as a warrior.  And that was the last I’ve seen of her.”  Uma sighs again.

So, you’re guessing Uma found out Usagi had left her a little going-away present some time after the rabbit warrior had left, you suggest?

“Yes.  My morning sickness didn’t start until about... 5 days later.  Jolted the sadness right out of me too.  I hadn’t even opened my clinic in those 5 days... and my friends were very worried... Loppe was just what I needed to pick up the pieces of my broken heart.”  She smiles, a motherly smile that makes her look absolutely stunning.

You ask if Uma ever tried to send a message after Usagi, let her know about her fatherhood?

“I did ask the travellers that passed through about news regarding Usa-chan... but rarely there was one that had even met her... Nevertheless I asked everyone that, should they meet Usa-chan, to tell her to return so we could live together as a family... but eventually we had to evacuate the village... so I’m not sure she even got my message, and I couldn’t keep waiting for her...”

You quietly thank Uma for sharing such intimate details of her life, and politely excuse yourself to leave.

“I still love her, you know.”  The mare declares in a conversational tone.  “I miss her so badly and I want her to come back to me; I dabble in dalliances, to fill the void, but I know they’ll never really replace her.”

You turn and look back at her, which Uma evidently takes as justification to continue, for all that she seems to be talking to herself first and foremost.  “Now, I’m not saying I’m not still mad at her for leaving in the first place, and I’ll definitely have to punish her when I get my hands on her,” her grin, at this point, makes you suspect that Usagi might not entirely mind her punishment, “but I swear, if she was to walk through that door and ask, I’d take her back like that.” She snaps her fingers for emphasis.

You can’t resist noting that it sounds like Uma would end up giving Loppe a little sister if Usagi did come back. 

Uma nods thoughtfully at your words.  “A sister or two?  Definitely.  Hey, why not go out on a limb and say five or six little sisters?  I loved being a mom, being pregnant was actually kind of hot, and I’m still young enough to do some serious breeding.”  She pats her belly with a defiant expression.  But then she slumps and sighs longingly.  “But I want my Usagi back first...” She mourns.

You tell her to keep hoping; as strong a warrior as Uma described her to be, you’re sure that the bunny-herm is still out there, somewhere.  You then politely withdraw to give Uma a chance to compose herself, heading back to camp.*/

		}
		
		public function sexMenu():void
		{
			
		}
		
		public function trainLoppe():void
		{
			
		}
		
	}

}