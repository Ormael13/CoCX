package classes.content 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * Whee!
	 * @author Gedan
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
		public static const NEEDLEWORK_LUST_TEASE_MULTI:Number = 1.1;
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
		public static const NEEDLEWORK_MAGIC_SPELL_MULTI:Number = 1.25;
		public static const NEEDLEWORK_MAGIC_REGULAR_MULTI:Number = 0.75;
		
		public static const NEEDLEWORK_ATTACK_PERK_NAME:String = "Chi Reflow - Attack";
		public static const NEEDLEWORK_ATTACK_PERK_DESC:String = "Uma's Accupuncture Needlework has fited you with the 'Chi Reflow - Attack' perk. As a result your regular attacks are more powerful, but your damage reduction is decreased.";
		public static const NEEDLEWORK_ATTACK_PERK_SHORT_DESC:String = "Regular attacks boosted, but damage resistance decreased.";
		public static const NEEDLEWORK_ATTACK_REGULAR_MULTI:Number = 1.25;
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
			if (this.getNeedleworkPerkName() != "")
			{
				return true;
			}
			
			return false;
		}
		
		public function getNeedleworkPerkName():String
		{
			if (player.hasPerk(NEEDLEWORK_SPEED_PERK_NAME))
			{
				return NEEDLEWORK_SPEED_PERK_NAME;
			}
			else if (player.hasPerk(NEEDLEWORK_LUST_PERK_NAME))
			{
				return NEEDLEWORK_LUST_PERK_NAME;
			}
			else if (player.hasPerk(NEEDLEWORK_DEFENSE_PERK_NAME))
			{
				return NEEDLEWORK_DEFENSE_PERK_NAME;
			}
			else if (player.hasPerk(NEEDLEWORK_MAGIC_PERK_NAME))
			{
				return NEEDLEWORK_MAGIC_PERK_NAME;
			}
			else if (player.hasPerk(NEEDLEWORK_ATTACK_PERK_NAME))
			{
				return NEEDLEWORK_ATTACK_PERK_NAME;
			}
			else
			{
				return "";
			}
		}
		
		/**
		 * Apply a Needlework perk to the player
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
		 
		public function accupunctureMenu():void
		{
			clearOutput();
			
			outputText("You tell her that you want to try one of those acupuncture sessions of hers.\n\n");

			outputText("“<i>Are you sure, dear?  While the effects of a Do-in massage will fade eventually, acupuncture is fairly... permanent.  Though I can only give you the effects of one type of needlework at once...</i>”\n\n");

			outputText("You tell her you understand what she’s saying, and thank her for warning you.  So, what kinds of needlework can she do?  What effects can her \"acupuncture\" have on you?  ...Also, how much will it cost?");

			outputText("“<i>Well, fine.  So long as you’re sure.  Normally, I would just show you a catalogue, but I suppose you’d prefer needlework that can be used for combat, yes?</i>”\n\n");

			outputText("You tell her that would probably be most useful to you, yes.\n\n");

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
		
		public function needleworkTurnDown():void
		{
			clearOutput();
			
			ouputText("You shake your head and tell Uma that you’d actually rather not get one of her acupuncture treatments at this point in time.\n\n");
			
			outputText("“<i>Very well, dear.  It’s important that you think this through, they’re not easy to undo.</i>”");
			
			menu();
			
			doNext(0, "Next", enterClinic, true);
		}

		public function needleworkSession(selectedSession:int):void
		{
			clearOutput();
			
			// Pay up		
			if (selectedSession == NEEDLES_UNDO)
			{
				outputText("You tell Uma that you’d like her to remove the effects of your last acupuncture session from your body.  Then hand over the gems.\n\n");
				
				outputText("“<i>Alright, dear,</i>”  Uma replies, pocketing the gems.  “<i>It might take some time, but I think I can help you with that... follow me.</i>”\n\n");
				
				player.gems -= this.needleworkUndoCost();
			}
			else
			{
				outputText("You tell her you would like her to give you the " + this.needleworkString(selectedSession) + " acupuncture session, please. Then hand over the gems.\n\n");
				
				outputText("“<i>Alright, dear.</i>”  Uma replies, pocketing the gems.  “<i>Let’s go then.</i>”  She motions for you to follow her.");
				
				player.gems -= 125;
			}
			
			menu();
			addButton(0, "Next", doNeedleworkSession, selectedSession);
		}
		
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

			outputText("You tell her that you understand.  True to her words, you do feel the slight pricking sensation of needles been put on your back, some of them are removed shortly after, while others stay in place for a while longer.  Eventually, you feel all needles being taken out of your back and Uma happily declares,  “<i>All done!</i>”\n\n"); 

			outputText("You ask if you can get up now, or do you need to stay where you are so that it has time to settle?  “<i>No, you can get up and get dressed dear.  The needles are out and your chi should be stable enough now... though you won’t feel much of a change until some time has passed.</i>”  She takes off her gloves and scratches her chin.  “<i>I estimate you should start to feel the changes soon; maybe by the time you get back to your home, if not shortly after.</i>”\n\n");

			ouputText("You thank her for her work, get yourself up and proceed to dress yourself.  You then politely excuse yourself and start the long journey back to your camp.");
			
			applyNeedlework(selectedSession);
			
			menu();
			doNext(13);
		}
		
		public function talkMenu():void
		{
			
		}
		
		public function sexMenu():void
		{
			
		}
		
		public function trainLoppe():void
		{
			
		}
		
	}

}