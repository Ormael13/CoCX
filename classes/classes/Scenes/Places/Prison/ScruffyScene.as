package classes.Scenes.Places.Prison 
{
	import classes.BaseContent;

	public class ScruffyScene extends BaseContent
	{
		
		public function ScruffyScene() 
		{
			
		}
		
		public function scruffyEnterGeneric():void {
			clearOutput();
			outputText("You look up as the door squeaks open and see a skinny imp enter the room with a mop and a bucket.  He's wearing a janitor's scrub top with a nametag that reads \"Scruffy\" but you doubt it originally belonged to him since it is about five sizes too large and he is very noticeably not wearing the matching scrub pants that should go with it. He flatly ignores you as he begins the unenviable task of cleaning your cell, but after a few minutes of lackadaisical cleaning he turns and seems to notice your presence for the first time.");
			outputText("\n\n\"<i>Well, aren't you a tasty little thing?  The Mistress sure knows how to pick em',</i>\" he growls, looking you up and down appraisingly. You notice his not insubstantial cock begin to stir and start to get a sinking feeling.");
			outputText("\n\n\"<i>Anyway, don't ever let me hear you complainin' about her, 'cause she's givin' you a break today sending me in to help clean out this pigsty of a cell that you seem to be content to live in. Seriously, I'll never understand the way you ungrateful little sluts disrespect her.</i>\" As he finishes the sentence he seems to drift off in a cloud of love and reverence, but he soon comes back down to earth and turns his attention back to you.");
			outputText("\n\n\"<i>Speaking of respect and gratitude,</i>\" he says with a lecherous grin, \"<i>I know good meals can be few and far between in this place and I just happen to have some extra food I'd be willing to share with you if you were to show me some, ahem --</i>\" he pauses to lewdly and intricately pantomime giving a blowjob, complete with creating a bulge in one cheek with his tongue, \"<i>respect and gratitude for the great efforts I'm putting into making your cell a little more habitable.</i>\"");
			outputText("\n\nYou consider how you should respond to Scruffy's offer.");
			outputText("\n\nYou could politely refuse (requires 5 of your 92 willpower) or you could angrily reject the offer (requires 15 of your 92 willpower).");
			outputText("\n\nYou could accept Scruffy's charity, or you could really show your gratitude and perform above and beyond what he's asked for.");
			menu();
			addButton(0, "Refuse", refuseScruffy);
			addButton(1, "Accept", acceptScruffy);
			addButton(5, "Reject", rejectScruffy);
			addButton(6, "Perform", performScruffy);
		}
		
		private function refuseScruffy():void {
			
		}
		
		private function acceptScruffy():void {
			clearOutput();
			outputText("Your mind made up, you assume a subservient posture and meeky communicate your acceptance with a mumbled word. ");
			outputText("\n\n(Placeholder)  Scruffy puts on/switches you to an open mouth gag because he doesn't want you biting but removes other bindings, doesn't find your performance good enough and fucks your face. He leaves you telling you to improve your performance, and your body via the item he gives you.");
			outputText("\n\n\"<i>Well, at least you show you understand that you are only here to be used by your betters. Put some effort into it next time and maybe I'll give you a little something extra as well. Be sure to eat what I have given you, though -- it'll help make your body more pleasing to old Scruffy the next time I come around.</i>\"");
			inventory.takeItem(consumables.SUCMILK, camp.returnToCampUseOneHour);
		}
		
		private function rejectScruffy():void {
			clearOutput();
			outputText("An attempt at kindness or not, the offer is humiliating in a way you aren't willing to accept at the moment. Gathering your courage, you unleash a verbal stream of pent up aggression on the scrawny imp janitor, flatly rejecting his deal. ");
			outputText("\n\nBefore you can even begin to react, you see his face turn to a mask of rage as he hammers you over the head with the bucket he was so recently using to clean up your filth. You momentarily black out, and when you come to you realize that he has hogtied you. You also notice that his dick has gone limp and wonder how that bodes for your fortunes. The answer comes quickly enough.");
			outputText("\n\n\"<i>You ungrateful little bitch. Normally I'd teach you a lesson in humility and obedience more directly, but somehow you've managed to kill my mood.</i>\" He punctuates the sentence by delivering a swift kick to your ribs, and then dramatically draws the largest dildo gag you've ever seen from behind his back. \"<i>Well, I suppose this will have to suffice for your reeducation today. Perhaps the next time you see me you'll remember how much better off you would have been with my prick in your mouth instead.</i>\"");
			outputText("\n\nAnd with that he forces the monstrous rubber phallus into your mouth, locks the straps behind your head, grabs his mop and bucket and leaves the room in an exaggerated huff. You manage to take some solace in the fact that you stood up for yourself and avoided servicing the little jizz janitor, but you are unsure if the price was worth it.");
		}
		
		private function performScruffy():void {
			
		}
	}
}