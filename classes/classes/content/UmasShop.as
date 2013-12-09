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
			outputText("You make your way Uma’s shop.  It is close to Loppe’s house, and from there you’ve seen the humble exterior many times. “Kemono’s Oriental Clinic” is written on a wooden board above the entryway.  “<i>Sugar, you coming?</i>”  Loppe asks, breaking you out of your reverie.  “<i>Come on in!</i>”  Loppe holds the door open to you.\n\n", true);
			
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

			outputText("Loppe bounces up towards the tall equine and they embrace in a friendly hug.  “<i>Hi, mom!</i>”  Uma laughs softly before replying, “<i>Hello my little horsey hopper.  Who is this?</i>”  She asks, looking at you.\n\n");

			outputText("You politely offer Loppe’s mother your name, telling her that you’re a... friend... of Loppe’s.\n\n");

			outputText("Loppe looks at you with disdain, then adds, “<i>Yes, [he]'s a friend alright...</i>”  Loppe clears her throat.  “<i>Mom, I would like to introduce you to [name], my [boyfriend].</i>”\n\n");

			outputText("Uma looks between the two of you with interest.  “<i>[Boyfriend] huh?  So it’s you whom I have to thank for the broken springs in Loppe’s bed?</i>”  Uma says with a smile, offering you a hand.\n\n");

			outputText("You give her a winning smile back and accept it, wondering if you should prepare yourself for a macho-type squeezing match.  Even as you shake her hand, you apologise, telling her it wasn’t your intention to make Loppe’s bed need replacement springs.\n\n");

			outputText("Loppe and Uma look at each other and then they both burst out laughing.  “<i>Oh, sugar... you’re so silly,</i>”  Loppe says.  “<i>[name], I’ve learned a long time ago that Loppe’s beds must be war and waterproof.  So I’ve had her bed custom-made; you could have an army of minotaurs stomp that bed and it wouldn’t even bend.</i>”  Uma says with a grin.\n\n");

			outputText("You give them your best confused expression, realising that Uma and her daughter must have similar tastes in humor; she was evidently joking with you.\n\n");

			outputText("Uma is the first to break the awkwardness.  “<i>Well then... care to give me the details?  How did you two meet?  When did you start fooling around?  Has my daughter worked so hard you had to seek a healer yet?</i>”\n\n");

			outputText("Loppe holds your hand and the two of you begin detailing how you met....");
		}
		
		public function firstVisitPart2():void
		{
			outputText("“<i>I see... that is so like my daughter to do something like that.</i>”  Uma glares mischievously at Loppe.  “<i>Aww mom... cut me some slack!</i>”  Loppe protests, playfully.  You can’t resist laughing softly at the two; it reminds you of people back in Ingnam... albeit they’re joking about subject matter you’d normally not touch back in your world.</i>\n\n", true);

			outputText("Your conversation is interrupted when a cat man enters the clinic.  “<i>Umm... hello?</i>”  He says, shyly as he enters.  Uma turns to you.  “<i>You’ll have to excuse me, but I must get back to work.</i>”  Understanding that Uma is currently working, you politely step back and watch as Uma walks to attend to her client.\n\n");

			outputText("“<i>We should go, sugar.</i>”  Loppe whispers in your ear.  You nod to her, tell Uma that it was nice meeting her, and indicate Loppe should lead you out. You follow the Laquine out of the building, and tell her that her mother is a nice woman. “<i>Yeah, she is nice, she’s just a little... quirky.</i>” Loppe agrees. “<i>And I think she likes you too, sugar; nice work.</i>” She grins, patting you on the shoulder.\n\n");

			outputText("You tell her that you’re glad, but you have other things to do, so you’ll catch her some other time. “<i>Alright, sugar,</i>” Loppe agrees, “<i>see you around.</i>” With that, she turns and walks away back in the direction of her home, leaving you to start heading back to what passes for yours in this world.");

			// Flag the shop visit
			flags[kFLAGS.MET_URMA] = 1;
			
			// Player returns to Camp
			doNext(13);

		}
		
	}

}