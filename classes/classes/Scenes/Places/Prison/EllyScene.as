package classes.Scenes.Places.Prison 
{
	import classes.BaseContent;
	import classes.GlobalFlags.*;
	
	public class EllyScene extends BaseContent
	{
		
		public function EllyScene() 
		{
		}
		
		public function restraintGain():void {
			outputText("Mistress Elly reaches a decision. \"<i>Perhaps having your freedoms a bit more restricted for a while will help you show some respect.</i>\", she says as she adjusts your restraints.");
		}
		
		public function restraintLoss():void {
			outputText("Mistress Elly reaches a decision. \"<i>Perhaps having your freedoms a bit more restricted for a while will help you show some respect.</i>\", she says as she adjusts your restraints.");
		}
		
		public function gainCumBowl():void {
			outputText("\n\nOut of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed, making you wonder if there is any end to her supply. She sets it on the ground and gives you a playful wink before leaving you alone in the cell.");
			inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
		}
		
		public function ellyEnterGeneric():void {
			clearOutput();
			outputText("The door to your cell opens and you look up to see Mistress Elly enter the room swinging her hips with cheerful, seductive purpose. She approaches you and treats you to a mocking pouty face. \"<i>Looking a bit hungry there, slave. Are you ready for your lesson then?</i>\" As if on cue, your stomach rumbles. She reaches out and runs her fingers softly over your chin and jaw. \"<i>All you need to do is politely say that one little sentence for me.</i>\"");
			outputText("\n\nShe lightly tilts your chin and your eyes drift down to see her moist, shapely lips as she mouths the words you are to learn. \"<i>Hello Mistress, how may I serve you today?</i>\" Her thumb grazes across your lower lip and you blush at the rush of excitement the touch sends through your body. A knowing smile crosses her face, but she doesn't press the advantage. Instead she backs off, perhaps to see how you react when not so directly under her overpowering influence.");
			outputText("\n\nYou consider how you should respond to Mistress Elly's order.");
			outputText("\n\nYou could meekly refuse (requires 5 of your " + flags[kFLAGS.PRISON_STAT_WILLPOWER] + " willpower) or you could angrily reject the order (requires " + flags[kFLAGS.PRISON_STAT_WILLPOWER] + " of your 89 willpower).");
			outputText("\n\nYou could give in and accept Mistress Elly's order, or you could really show your acceptance of your position and perform above and beyond what she's asked for. ");
			menu();
			addButton(0, "Refuse", refuseEllyFeeding);
			addButton(1, "Accept", acceptEllyFeeding);
			addButton(5, "Reject", rejectEllyFeeding);
			addButton(6, "Perform", performEllyFeeding);
		}
		
		private function refuseEllyFeeding():void {
			clearOutput();
			outputText("Though you are unwilling to obey your captor in this moment, you don't feel confident enough to confront her right now. Assuming a penitent posture and an apologetic tone, you state your refusal to do as asked, making a point to avoid Mistress Elly's gaze. A moment that feels like an eternity passes as you sit in the shadow of her imposing figure, awaiting her rebuke with growing trepidation.");
			outputText("Your stomach fills with lead as you watch her look of stern dissapointment harden on her face. \"<i>Apology or not, you've disobeyed me. I am glad to see that you have a desire to please me, but desire alone does not earn you the privilege of being fed. But I am not heartless -- quite to the contrary, I think you are coming to understand just how much I want to help you. And so now I'm going to help you embrace your desire to please me by showing you what happens when you do not.</i>\"");
			restraintGain();
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function acceptEllyFeeding():void {
			
		}
		
		private function rejectEllyFeeding():void {
			
		}		
		private function performEllyFeeding():void {
		   /*
		You decide you might as well give your Mistress a show -- it might even be a fun little diversion to play along with her games a bit. And the more you think about it, a good solid meal DOES sound very appealing. You look up and see her waiting expectantly with a sly smirk creeping across her exotic features. Steeling your resolve, you fix her with your best impression of the doe eyed, pliable look you think she hopes to see. A subtle widening of her almond shaped eyes betrays her approval amidst her otherwise static expression, encouraging you to sit up straight with your back lightly arched and say the words in the same lilting voice that she used in demonstration.

"Hello Mistress, how may I serve you today?" To top off the performance, you await her response with a pleasant smile drawn across your face. 

She claps her hands with giddy excitement and closes the distance between you with a triumphant dance. "Oh, what a good little boy you are. SO good!" She reaches down and gives you an exaggerated congratulatory pat on the head, resting her right hand in your short, brown hair. She is standing so close to you that her cock sways hypnotically just inches from your face, semi-erect but fully imposing. You do your best to maintain your composure and suppliant posture, but the sight still makes you blush with embarrassment as she continues to speak.

"It's a special thing when a slave proves me right so early in their training. Oh, I know, you probably think you are just pretending. But are you pretending for my sake, or your own?" Your mind tries to process the question, but to your great frustration the indecent motion of her fleshy rod and its musky, intoxicating scent have you too distracted to think clearly.

"Either way, it doesn't matter: it's a delicious taste of your true nature." Her slender tongue darts over her shapely ruby lips. "Now, say it again." She punctuates the order with a single forceful tap of her spiked boot heel against the floor. The sharp, harsh clack rings in your ears, bringing an unbidden rush of adrenaline to your heart, and you find yourself responding before you have time to think.

"Hello Mistress, how may I serve you today?" You say it with the same fervor as before, but this time the performance comes much more naturally. 

She gives her shaft a relaxed squeeze and several slow anticipatory strokes with her left hand while once again patting your head with her right. "Oh, good boy indeed. You're going to have so much fun learning to please your Mistress." She turns away, the tip of her shaft glancing across your upper lip. As it slides past it leaves behind a sticky residue, filling you with disgust for allowing it to happen.

She walks towards the door and almost as an afterthought tosses a pitiful loaf of bread over her shoulder. "Enjoy your well-earned meal, slave." The satisfaction in her voice is palpable
			*/
		}
		/*
		The door to your cell opens and you realize it must be feeding time as Mistress Elly enters the room with a sense of mischievous purpose. "Hello, slave," she purrs, and punctuates the word with a single forceful tap of her spiked boot heel against the floor. The sharp, harsh clack rings in your ears, bringing an unbidden but now familiar rush of adrenaline to your heart.

"Hello Mistress, how may I serve you today?"

The conditioned response pours from your mouth in the lilting, sycophantic tone that she suggested during your lessons. As it slips through your lips, you blush at the realization that she didn't even ask.

"Good " + player.mf("boy", "girl") + "." You see a brief shudder of ecstasy race through her body, her mouth drifting agape, her eyes rolling into their sockets, and her spade-tipped tail twitching behind her. "Now that you've mastered your first lesson, slave, you can begin to learn the answer to that question."

Though her composure returns, she continues to grin from ear to ear, making no attempt to conceal how pleased she is with herself. "A good slave knows to ask his Mistress what she wants without thinking. A better slave begins answering the question as he asks it. But to do so, a slave needs to understand what his owner wants from him. Some Masters might want to see their slaves pose seductively, or hear them speak words of reverence and praise, or simply have them wait motionless for direction. That's all fine, but I like my slaves to be a bit more... expressive of their love for me."

"Most of my slaves have to learn exactly what that means through trial and error, but you show special promise." She scratches her chin in an intentionally exaggerated gesture of contemplation. "Yes, I can see that you want to become the best slave possible as quickly as you can, so I'm going to make an exception and let you skip that step." She strides across the room to where you sit and looks down at you, trailing her index finger purposefully over your cheek towards your mouth.

				outputText("\"<i>What I want is to see my slave crawl across [his] cell to meet me, kneel at my feet, and wrap [his] ");
				if(this.player.femininity < 35)
				{
					outputText("strong, manly lips");
				}
				else
				{
					if(this.player.femininity < 65)
					{
						outputText("supple, inviting lips");
					}
					else
					{
						outputText("plump, sexy lips");
					}
				}
				outputText(" around my juicy, delicious cock.</i>\" Her fingernail rakes across your lips as she says it and you pull your head away in [if (esteem < 30) \"abashed \"][if (esteem < 50) \"shame\"][if (esteem >= 50) \"anger\"][if (esteem >= 70) \" and indignation\"]. [if (corruptio");

"Oh dear, so modest. Don't worry, baby, you'll get the hang of it. You shudder and blush now, but you'll be shocked by how much fun you'll have once you get started. I'll take it nice and slow, and I'll tell you exactly what to do. You won't have to think, just let your body act."

Her almond shaped eyes narrow as she looks you over in ravenous appraisal, her lithe finger following close behind the path of her eyes. Your nipples tingle as it passes down the middle of your chest and your nice prick stirs as the finger teases its way around your pubic mound. She leans in close and whispers huskily in your ear, "Trust me, it knows what to do. Listen to it, and learn the truth about yourself."

Abruptly, she stands and walks back across the room, affording you a brief moment to collect your thoughts. "Now, slave: start crawling."

You consider how you should respond to Mistress Elly.

You could meekly refuse (requires 5 of your 89 willpower) or you could angrily reject the order (requires 15 of your 89 willpower).

You could give in and accept Mistress Elly's order, or you could really show your acceptance of your position and perform above and beyond what she's asked for. 

		 */

		
		 /*
		Being taught to call her Mistress may have broken your spirit a bit, but not enough to make following this order even remotely easy. Still, having weighed your options, the consequences of upsetting her seem worth avoiding -- even considering what has been asked of you. Despite having rationalized the decision, humiliation burns through your body like wild fire as you lean forward onto your hands and knees and lift your nice, toned ass into the air. Watching intently from across the room, Mistress Elly beckons with two fingers as she sees you begin to move. 

You reach forward with your left hand and lock your eyes on the ground directly below you.
You follow with your right hand and pull your legs forward behind you.
You reach again with your left hand, and notice your fingers wavering.

As you place it down, a shiver runs through your limbs, the stone floor cold against your flesh. As a single bead of sweat forms on your brow, you find yourself painfully aware of every movement your body is making, and time seems to slow to a crawl.

You imagine how you must look: face down, ass up, slinking on all fours, and part of you wants to just stop and curl up in shame. But you remember the demon across the room who is unlikely to tolerate that, as well as your resolution to appease her .

You move your right hand. Your stiffening muscles cause you to wobble as you move and your ample prick slaps against your thigh.

Left hand. You move smoothly until your knee scrapes across a crack. Your eyes swim and the edge of your vision blurs, more from frustration than pain.

Right. Your palms begin to sweat, and you nearly slip as you shift your weight.

Left. Desperately hoping you're almost there, you steal a glance up, and for a moment those leather clad legs seem farther away than when you began.

Right. Your breath becomes shallow and staggered; your pulse thumps in your ears.

Left...Left! You lift your left hand, but quickly set it back down in the same spot, unable to move it forward. Your throat knots in terror at your paralysis; your arms have become quivering leaden masses.

All at once your resolve cracks. Tears form in your eyes, your torso convulses with a powerful sob, and all intelligent thought is blown away in a maelstrom of emotion. Disgrace, impotence, anger, degradation, and hopelessness all mix together and wash away any pretension of self determination you may have been harboring. You soak in it for a moment, but then the sound of an impatient booted toe tapping on the floor penetrates your misery and you realize you have no choice but to find a way to continue. You shake your head to clear away the flotsam, shakily pick yourself off the ground, take a deep breath, and begin again with steady, resigned purpose. While you remain stiff and frigid, you manage to cross the remaining distance without letting your uncertainty overcome you again.

You arrive at her feet, exhale a sigh of resignation, and sit back on your ass with your legs folded on either side of you.

You cannot help but feel small and powerless as she looms over you, shoulders drawn back confidently, hands resting jauntily on her hips, tail swinging playfully between her legs. Although it has only begun to fill with blood, you find yourself having to crane your head to peer around her phallus and find her face. She looks down at you for a few beats, her expression a mixture of expectation, indulgence, and evaluation, then rolls her eyes in amused exasperation at your inaction.

"You've done well so far, dear, and the hardest part is over." You are taken aback -- there is no note of condescension, no mocking undertones, no hint of ulterior motives. Her voice is simply kind, and her face genuinely caring. "Of course, before long you'll enjoy that part too; it gives you a chance to relish how shameful a creature you are." You know her words should upset you, but as you realize you are in a rather shameful position, you actually end up thankful that she pointed it out so gently. Your mind and muscles relax considerably as you are kept docile by her soothing tone and countenance. "But now you get to have some fun. No really, you'll see -- you're going to enjoy this. Begin by taking my shaft in your hands."

Without thinking, you reach up and wrap your left hand around her girth. Even in her half-flaccid state your fingers barely touch your thumb as you tighten your grip. "Both hands, darling." Your right hand follows the left, grabbing closer to the base, and you are amazed to note that there is room enough along her length that a third hand could fit comfortably as well. You are also surprised to find that the flesh of her cock is every bit as soft and silky as the rest of her skin, and the sensation of touching it is actually incredibly pleasant. Holding it this way has pulled the tip down almost level with your nose, and when you look back up for further direction you find it's dark, musky scent invading your nostrils. You begin to feel lightheaded. "Now, put it in your mouth. Just the tip, mind you."

Fireworks of embarrassment explode across your cheeks, but you know you have no choice but to do as you are told. You straighten your back as you reach upwards with your mouth and slide her cock head through your lips, stopping just before the flared crown. "Good " + player.mf("boy", "girl") + ". Now hold it there." You do so, trying your hardest to ignore how enjoyable her skin felt gliding in, how good it still feels pressed between your lips, and how enticing the taste of it is as it gently pins your tongue to the floor of your mouth. There are all the expected earthy, natural flavors, but also something strangely sweet, almost like cinnamon. In the stillness of the moment this cacophony of sensory input throws your already light head into disarray, and it is only when you hear Mistress Elly peep with delight that your realize the tip of your tongue has begun to tentatively flick at the underside of her glans. "Patience, slave, we'll get there," she says, but as she does she pushes forward ever so slightly.

Your lips slacken to accept the motion and the ridge of her head slips through the tight ring of your lips. Once again you attempt to remain still, but once again it''s not long before your tongue begins to act, teasing its way around the lower rim of the intruder. A soft moan escapes her lips, you feel her pulse quicken, and with every beat of her heart she swells, first stretching your lips into a wider 'O' shape, then forcing open your jaw to better accommodate her. Finally it seems to stop growing, but only when the upper ridge her cock is pressing into your palate despite the underside still being pressed firmly against your tongue. Salty precum begins to leak from her tip, and to your dismay it only seems to improve the taste of her flesh.Though you finally manage to suppress your tongue's efforts, it's too late.

"Ah, suddenly shy again? Listen to your body, slave. It knows what you are, and it wants so badly to show you." Her body is now visibly filling with ardor, her ample bosom rising and falling with each deep breath, but her tone remains kind and supportive. "But I know you can overcome your nerves -- you have so much potential just waiting to be released. Now, pleasure the head. In and out, slowly." With little hesitation, you pull back over the ridge and down the slope beyond until your lips are nearly closed around the tip. You consider waiting a moment to rest your jaw, but you guess Mistress Elly wouldn't approve. You push the thought aside, and lean forward to once again fill your mouth.

With each subsequent stroke the knob becomes more slick with your saliva and her salty lubricant. As it does, the sensations of her skin slipping through your lips and over your tongue grow ever more enticing, and the taste of her flesh becomes maddeningly irresistible. It takes all your willpower to remain composed and not lose yourself pumping away at her delectable shaft of meat. Even still, you briefly indulge a lesser urge, moving your hand up to gather some of the growing slickness from the head and spreading  it down the barrel of her cock. You marvel at the feel of her unique skin between your fingers as you give her several deep squeezes. But eventually, you manage to tune out your undesirable enjoyment of the act, delivering short, staccato strokes devoid of the passion growing in the back of your mind.

"You're fighting it again, slave," she sighs as a look of disappointment clouds her previously blissful expression. "I was hoping your very obvious innate enjoyment of sucking dick would drive you to perform well, but clearly you need further encouragement to embrace it. That's okay; I'll just have to take a more hands on approach for the remainder of your lesson." She rests her hand on your head, fixes her violet eyes on yours, and continues in a pedantic voice. "Now, keep your mouth around me, but place your hands behind your back." You do so in a mechanical manner, but can't help but notice that this has forced you to arch your back and present your chest suggestively. "You are not to move your arms from that position until I say so. Is that understood?" Wilting under her demanding gaze, you shift your eyes down to her boots and mumble a sound of compliance around the bulge of flesh that fills your mouth.

"No, slave. Say, 'Yes Mistress, I understand.' " She tilts your head back so that you are once again looking into her eyes. One glance at her face is enough to tell you that she will accept nothing less that total submission on this matter.

"Yesth... Misth... treth... I undahh... thtand." The sloppy sound of your voice sounding out the syllables brings color to your cheeks all over again.

"Much better. Always remember your manners, slave, especially when your mouth is full. Now, feel free to relax and enjoy this, but do pay attention: I expect you to learn your lesson well." She reaches down and gets a firm grip on your ears. Making use of her new handles, she begins to gently pull your face toward her. With meticulous care she pushes her rod into your mouth one millimeter at a time, backing off the moment even the slightest bit of discomfort shows on your face. 

"I told you I would ease you into this, slave, and I keep my promises. Remember that." Indeed, aside from the a slight ache in your jaw due to being stretched so wide, an eternity passes where your entire awareness is consumed by the agonizingly alluring feel of her slick, silky skin slowly invading your mouth. Finally, with barely more than a third of her length inside your mouth, you feel her tip press against the entrance to your throat. She stops pulling, but continues to hold your head in place.

"There's a good " + player.mf("boy", "girl") + ". See? It's not unpleasant at all when you submit and let it happen." Her almond shaped eyes narrow, one eyebrow arches, and the corner of her mouth curls upward. "Quite the opposite, it seems to me. Now, slave, practice breathing." 

You override your reflexive reaction to breathe through your mouth by pressing your lips and tongue tight against her inviting flesh, and inhale deeply through your nostrils. Your senses are flooded with her intoxicating scents, flavors, and textures, and you hold the breath longer than you intend to while involuntarily savoring the illicit rush. You release it, then repeat the act with unexpected zeal, eyes rolling back, lids closing, and mouth salivating. To your extreme shame, you realize that your lips have begun to pucker and squeeze around her girth, and that your tongue is making luxurious undulations against the shaft that pins it down, as if to wring it of its sweet and savory essence.

On the third intake of air, something even more odd happens: what feels like a thick, velvet rope wraps around your torso and rubs you with an upward motion, as if encouraging the action of your diaphragm. As you exhale, it massages back down. The sensation is not at all unpleasant, but distracting curiosity pulls you from your reverie. When the velvety massage again follows your fourth breath, you rotate your head sideways in her grip in order to glance downwards. From the corner of your vision, you see that the rope is actually Mistress Elly's agile tail, reaching forward through her legs to stimulate you.

"Focus, dear. It is important for you to learn this lesson well." You breathe again, and again her tail softly follows the motion with its calming and supportive hug, instantly transforming from a distraction into one more delightfully effective piece of her unrelenting sensory assault. This happens several more times, and soon you are unsure if the tail's relaxing motion is reinforcing your breathing or controlling it as you fall into an aroused trance. "Good " + player.mf("boy", "girl") + "." Taking advantage of your weak and malleable state, she begins to move your head again, all the while continuing to coach your breathing with the comforting movements of her smooth tail. At first she moves you only the smallest bit, and inch out (exhale), and then an inch back in (inhale), then two inches out (exhale), and two inches in (inhale). 

But as you grow accustomed to her rhythm, her inward strokes begin to push further and her outward ones retreat less, while your breaths grow deeper and the dizzying wait between them grows longer. You make an effort to push back your receptive daze, but only manage to reclaim enough of your consciousness to stare down the bridge of your nose at the hypnotic thrusting of her olive skinned rod. In a fleeting lucid moment you note that the shallowest point of her stroke is now the depth where she was previously teaching you to breathe. At the bottom of one stroke you can still see half of her cock, then at the bottom of the next you barely see more than a third.

As she finally bottoms out and your nose presses into her smooth, sweet smelling public mound, a conflagration ignites beneath your thoroughly conquered senses. You find yourself verging on orgasm and your eyes roll skyward, your visage rather obscene thanks to the tight, hairless testicles on your chin and the dramatic bulge in your neck.

A tickle at your groin suggests the source of the lusty spark; somewhere in the build up she must have begun teasing and rubbing at your pecker with the spaded tip of her clever tail. You briefly wonder if you might have resisted, but the damage is done.

She confidently holds her entire length buried within you, and even though stars flash in your eyes and your lungs burn, you hear yourself wasting precious oxygen on a moan -- not of pain, or anguish, or rage, but of pleasure -- begging for more. You make a meager effort to restrain it, but as the long, lewd noise slowly escapes your lips, you shamefully admit to yourself that the situation has escaped your control. The disheartening thought is barely finished, though, when your body grabs you in a riptide of need -- just as your mind was scrambling free of the previous wave's wake.

Mistress Elly echoes your moan with an utterance of her own, the grunt of a master chef tasting a successful new recipe for the first time. With all the tenderness and patience with which she began the process, she slowly draws her dick up and out of your throat, letting you once again savor the sensations of her skin gliding past yours. As the blockage slips past your windpipe her tail once again guides your breathing with its velvet hug, but thanks to the continuing ministrations of the tail's tip you barely notice the rush of air returning to your lungs. Instead you find yourself enthralled by her cock's movement, licking slavishly at the knob as it grinds past, and sucking with such greed that that there is a wet, audible pop as she pulls it through the seal formed by your lips.

She holds your face several inches from her cock head, strands of saliva and precum dripping between her tip and your lips. Several times you feel yourself try to lean forward, but her firm grip stops you. Unhappy with being so denied, your tongue makes a desperate attempt to close the gap on its own, spurred on by her tail's merciless teasing of your sex. Momentarily shocked back to your senses by your wanton behavior, you hope that you can remain more dignified the next time you find yourself in this position.

As if sensing your internal conflict, she asks, "Are you enjoying yourself, dear?" The words drip with sultry bravado. Already slipping back into your lust-induced stupor, you reply "Yes, Mistress" with unabashed sincerity.

"Do you think we're done, or would you like me to teach you more?"

You tremble, silent for a moment as your pride fights desire for your answer. Overwhelmed as you are, though, you fear you already know which is winning...the only question left is whether or not you embrace it.
menu();
addButton(1, "More...", eventParser, 9999);
addButton(2, "More!", eventParser, 9999);
		  */

		/*
		Some far, far away part of you wanted this to be as quick and pastel as possible, but you know exactly what she wants, and right now you want to give it to her more than you ever imagined."More!" you declare in a breathless tone. Elly's eyes flicker with genuine surprise at your desperation, and for a moment you worry you've done something wrong before she merely lifts an eyebrow in gentle reprisal.

"Manners, slave," she chimes through a growing smile, her expression settling into one of amused endearment as she locks on your own pleading gaze. You do not even notice her heel touch the floor, but it draws a soft, familiar tap.

"More please, Mistress!" you answer in earnest, your needy, dampening eyes begging even more than your voice. "I knew there was an eager student hiding inside you. Now, dear, pay attention and you will learn how to properly receive my seed." Before she finishes the sentence, she has pulled your head back onto her cock and her balls are once again pressed against your slimy chin. She holds you there until you are close to blacking out once more, and then begins moving your head in long, sumptuous strokes. With each one she pulls her knob all the way back to the opening of your mouth, giving you a second to worship it with your tongue, then with gentle force feeds you her entire length all over again. As a testament to how well she has prepared you, this treatment is far from the uncomforable experience you would have expected it to be. Aside from mild stretching and a feeling of being overfull, your gullet receives her pounding as if you were made for it.

As you fall back into your previous fugue state, her teasing at your shaft becomes unbearable. You begin to creep your hands back around to the front of your body, intent on giving yourself the release she is denying you. The second your shoulders go slack, though, she delivers a sharp slap to your right cheek, then resumes her fucking with increased vigor. "You haven't... earned... the right... to do that yet... slave." Her voice is like a whip as she delivers the reproach in time with her strokes. You pull your arms back, incapable of any other response, and struggle to endure the torture as her tail redoubles its efforts. 

Soon you feel her grow stiff in your throat, and she erupts with one final, powerful stroke. Her testicles begin to twitch against your chin, and wave after wave of bulges travel though your lips, squeeze past your billowing tongue, and pump their way down your throat to pour straight into your stomach. Before long you are full to bursting and you feel her seed creeping its way back up your esophagus and into the back of your mouth. At this point she smoothly withdraws so that just the tip of her cock remains inside your mouth. Even though the waves begin to abate, she still manages to fill your mouth such that your cheeks balloon with her cum and a steady stream leaks through the ring of your lips locked around her head. "Do not swallow until I tell you to, slave." Then, with your tongue drowning in a sea of her briney load, she fully withdraws and delivers her last few white ropes across your face and into your short, brown hair.

"An admirable effort, dear." she says, as she unceremoniously drops you to the floor. The sudden impact winds you and a good portion of her bounty sprays from your mouth, but you hold tight to what remains. After what you just experienced, you aren't going to upset her by failing to meet her expectations now. And so you lie still, defiled cheek resting in the sticky pool dribbling from the corner of your mouth, arms still held behind your back crushing your chest to the floor, nipples hard and chafing against the cold stone. "You may swallow when I have left the room; consider it a gift for your good behavior at the end. Still, I'm afraid you'll need to perform that way the entire time if you want to earn a meal beyond a simple bowl of soup."
gainCumBowl();
		*/

		public function theMistressComesInForFuckings():void {
			clearOutput();
			outputText("Mistress Elly enters the room to find you writhing on the floor with unmanageable lust and is clearly amused by your pathetic state of afairs. After a moment's thought she comes to a decision and says, \"<i>Beg me to fuck you, and I might take pity on you.</i>\"");
			menu();
			addButton(0, "Beg", begEllyForFucking);
			addButton(1, "Resist", resistEllyFromFucking);
		}
		
		private function begEllyForFucking():void {
			
		}
		
		private function resistEllyFromFucking():void {
			
		}
	}

}