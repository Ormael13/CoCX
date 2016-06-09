package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kACHIEVEMENTS;

	public class Raphael extends NPCAwareContent implements TimeAwareInterface {

//The event itself:
//Requirement: Player has found Desert storage chest &
//Tel'Adre has been found.
//PC has 5+ gems

//Second requirement:
//- Player has C,D,DD or E breasts, at least girly/ample thighs, no humongous ass, is between 4 and 6 feet and has a bipedal lower body.
//- Player does not have a cock or balls, for now

		public function Raphael() {
			CoC.timeAwareClassAdd(this);
		}
		
		private var checkedRussetRogue:int;
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean {
			checkedRussetRogue = 0; //Make sure we test just once in timeChangeLarge
			if (flags[kFLAGS.RAPHAEL_DRESS_TIMER] > 1 && player.gems >= 5) flags[kFLAGS.RAPHAEL_DRESS_TIMER]--;
			if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] > 1 && player.gems >= 5) flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER]--;
			//Fix 'hangs' - PC is at the bottom of the dress countdown
			if (flags[kFLAGS.RAPHAEL_DRESS_TIMER] == 1 && flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == 0 && RaphaelLikes()) flags[kFLAGS.RAPHAEL_DRESS_TIMER] = 4;
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			if (checkedRussetRogue++ == 0 && model.time.hours == 6 && flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] >= 0 && player.hasKeyItem("Camp - Chest") >= 0 && player.gems >= 5 && player.statusEffectv1(StatusEffects.TelAdre) >= 1 && (flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0)) {
				/*trace("RAPHAEL FINAL COUNTDOWN: " + flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER]);
				trace("RAPHAEL MET: " + flags[kFLAGS.RAPHAEL_MET]);
				trace("RAPHAEL DRESS TIMER: " + flags[kFLAGS.RAPHAEL_DRESS_TIMER]);
				trace("RAPHAEL DISGUSTED: " + flags[kFLAGS.RAPHAEL_DISGUSTED_BY_PC_APPEARANCE]);*/
				if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] <= 0) { //Countdown to finale not currently engaged!
					//If the PC meets his criteria!
					if (RaphaelLikes()) { //Not yet met!  MEETING TIEM!
						if (flags[kFLAGS.RAPHAEL_MET] == 0) {
							outputText("<b>\nSomething unusual happens that morning...</b>\n");
							doNext(meetRaphael);
							return true;
						}
						else { //Already met!
							if (flags[kFLAGS.RAPHAEL_DRESS_TIMER] == 0 && flags[kFLAGS.RAPHAEL_SECOND_DATE] == 0) { //Not given dress yet
								outputText("<b>\nSomething unusual happens that morning...</b>\n");
								doNext(RaphaelDress);
								return true;
							}
							//Dress followup - Call picnic date prologue!
							if (player.armor == armors.R_BDYST && (flags[kFLAGS.RAPHAEL_DRESS_TIMER] > 1 && flags[kFLAGS.RAPHAEL_DRESS_TIMER] <= 4 || flags[kFLAGS.RAPHAEL_DRESS_TIMER] == -1)) {
								outputText("<b>\nSomething unusual happens that morning...</b>\n");
								doNext(RaphaelEncounterIIDressFollowup);
								return true;
							}
						}
					}
					else { //If the PC does not currently meet his criteria
						if (flags[kFLAGS.RAPHAEL_MET] == 0 && rand(10) == 0 && model.time.days >= 15) {
							outputText("<b>\nSomething unusual happens that morning...</b>\n");
							doNext(meetRaphael);
							return true;
						}
						//Dress countdown - if pc isn't wearing it yet, kick out to
						//Finale!
						if (flags[kFLAGS.RAPHAEL_DRESS_TIMER] == 1) {
							flags[kFLAGS.RAPHAEL_DRESS_TIMER] = -1;
							flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 7;
						}
						//PC get ready for the 2nd encounter and hasn't been
						//shot down yet?
						if (player.armor == armors.R_BDYST && flags[kFLAGS.RAPHAEL_DISGUSTED_BY_PC_APPEARANCE] == 0) {
							outputText("<b>\nSomething unusual happens that morning...</b>\n");
							doNext(RaphaelEncounterIIDressFollowup);
							return true;
						}
					}
				}
				else if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == 1) { //FINALE
					outputText("<b>\nSomething unusual happens that morning...</b>\n");
					doNext(quiksilverFawkesEndGame);
					return true;
				}
			}
			return false;
		}
		//End of Interface Implementation

override public function RaphaelLikes():Boolean {
	if (flags[kFLAGS.LOW_STANDARDS_FOR_ALL])		
	{
		if (player.gender == 2 || player.gender == 3)	// you at least need a vagoo for raphael to fuck you. Otherwise the sex scenes will be rather broken.
			return true;
	}
	
	//({If player has no legs, or a centaur body.}
	if (!player.isBiped()) 
		return false;
	//({If player has above E cup breasts} 
	if (player.biggestTitSize() >= 12) return false;
	//({If player has below C cup breasts} 
	if (player.biggestTitSize() < 3) return false;
	//({If player has grown less than girly hips}
	if (player.hipRating < 6) return false;
	//({If player has gotten a massive butt} 
	if (player.buttRating >= 16) return false;
	//({If female player has gotten bigger than 6 feet}
	if (player.tallness > 72) return false;
	//({If female player has gotten smaller than 4 feet}
	if (player.tallness < 48) return false;
	//({If player has grown ANY cock and balls}
	if (player.balls > 0 || player.cockTotal() > 0) return false;
	//(For now: 
	//({If player has lost all gender}
	if (player.gender == 0) return false;
	return true;
}


//If first two requirements are met, than trigger when: 
//Female PC wakes up. 

//{First encounter}
private function meetRaphael():void {
	clearOutput();
	outputText("You stir in your sleep, bothered by a noise. It's the familiar creaking of your camp's storage chest, as if you've just opened it up to fill it with freshly found loot. Groaning, you hog your blankets and twist. Nothing to worry about then. You soon drift back into a pleasant dream about all the spoils you've accumulated over the time here. Life is good.\n\n", false);
	
	outputText("Suddenly, you sit up straight and something occurs to you. If you're sleeping, then who's opening the chest?\n\n", false);

	outputText("You rush out of bed and into camp, concerned for your stash.\n\n", false);

	outputText("\"<i>Hey!</i>\" you call out sleepy as, indeed, a strange red being is rummaging through your belongings. It has its front body in your storage chest, throwing junk about in search of valuables while its bright red tail wags in the air. The moment it notices you, it jumps up and runs off so fast it turns into a red blur. Only at the outskirts of your camp, on top of a small crumbled wall, does it take the time to introduce itself.\n\n", false);
	
	outputText("\"<i>Ha-hah!</i>\" it exclaims boastfully with a sharp, young, dashing voice while standing tall and proud on top of its perch. \"<i>Another daring caper committed by...</i>\"  The being takes the time to strike a pose. \"<i>...the Russet Rogue!</i>\"\n\n", false);

	outputText("You rub your eyes, walk towards the wall and take a curious look up. It appears to be a red fox. He's looking down on you with a triumphant smirk on a tapered snout; most definitely male and masculine. Although not the broadest figure around, his muscles are lean and strong. His contoured torso flares up above narrow hips and gives him a body that has an agile deftness to it. He wears a loose, red-brown jacket and supple deerskin pants, with a red sash across the hip and soft-soled boots below. They do much to complement the vivid color of his fur, which is a vibrant crimson, broken only by the beige fur running down his chest and towards his crotch. Lithe, the only two things that are large about him is the clear bulge in his thin leather pants and the bushy tail that flicks playfully from side to side. The russet rogue takes quite a bit of pleasure from larceny it seems. Judging by his ornate outfit, he does it for the thrill of it. He himself must be well off.", false);
	//Set first meeting complete
	flags[kFLAGS.RAPHAEL_MET] = 1;
	doNext(meetRaphaelPtII);
}

//~~~ Next Page ~~~
private function meetRaphaelPtII():void {
	clearOutput();
	outputText("Suddenly, Raphael's features grow soft and surprised as he looks down upon you. You get the feeling he's eyeing you up and catching a peek at your " + (player.mf("m", "f") == "f" ? "cleavage" : "groin") + ", but you can't be sure.\n\n", false);

	outputText("\"<i>Marae must have cursed me for my audacity, for I am growing blind even at my young age.</i>\" The fox puts his hand to his forehead and pretends to faint. He rights himself just before he hits the ground, however and lands in a kneel before your feet.\n\n", false);
	
	outputText("You can't help but smile a little at the amount of theatrical flourish.\n\n", false);

	outputText("\"<i>Here I thought I had searched the entire camp, found every treasure, pilfered every gem...</i>\" He states while sauntering towards you in a disarming, wide stride. ");
	if (RaphaelLikes()) outputText("\"<i>... but it seems I've overlooked the greatest jewel of all!</i>\" Raphael kneels before you, taking you by the hand and planting a kiss upon it. \"<i>Can you ever forgive me for my blindness, my fair lady?</i>\" He takes your hand in both his paws, while looking deeply into your eyes. His own are a deep emerald green, contrasting sharply with his bright red coat. They are set below a sturdy brow that gives him playful maturity and a rough regal elegance.\n\n", false);
	else outputText("\"<i>My apologies. I didn't notice you! I thought you were a lady but you're not. Can you forgive me for not noticing you, my fair friend?</i>\" He takes your hand in both his paws, while looking deeply into your eyes. His own are a deep emerald green, contrasting sharply with his bright red coat. They are set below a sturdy brow that gives him playful maturity and a rough regal elegance.");
	
	outputText("What do you do?", false);
	//[Talk] [Slap] [Swoon]
	if (RaphaelLikes()) simpleChoices("Talk", RaphaelFirstMeetingTALK, "Slap", RaphaelFirstMeetingSLAP, "Swoon", RaphaelFirstMeetingSWOON, "Rape", null, "", null);
	else simpleChoices("Let Him Go", letRaphaelGoFirstMeeting, "Slap", RaphaelFirstMeetingSLAP, "Rape", (player.lust >= 33 && player.hasCock() && player.cor >= (60 - player.corruptionTolerance())) ? rapeRaphael : null, "", null, "", null);
}

//{When Player chooses Slap/refuse after the first encounter}
private function RaphaelFirstMeetingSLAP():void {
	clearOutput();
	outputText("With an offended scowl you throw a flat palm across his face. You make sure to catch his nose and sharp snout, sending him a clear message.\n\n", false);

	outputText("It takes Raphael completely by surprise. The fox keeps his head in the wake of the blow for a good five seconds in disbelief, but tries once more when he recovers.\n\n", false);

	outputText("\"<i>I can assure you señorita, that I had no intention of tainting your honor.</i>\" He pats your hand.\n\n", false);

	outputText("This time you wrestle your hand from Raphael's hold and throw him the heavier back of your hand, sending him to fall on his back. You're actually getting angry at him. How dare he sneak into your camp" + (RaphaelLikes() ? ", try to rob you and then seduce you" : " and try to rob you") + "! By the time it occurs to you to actually apprehend him, Raphael has already beaten a hasty retreat by hopping back up on the wall.\n\n", false);

	outputText("\"<i>It is clear I was twice the blind fool!</i>\" He proclaims on top the ruined palisade. ");
	if (RaphaelLikes()) outputText("\"<i>You might look like one, but verily, you are not a lady.  I would advise you to gain manners, but sadly, a hag cannot be taught female grace with any greater aptitude than a pig can be taught to dine with silverware. You will remain at best, a very curvy mangirl.</i>\"\n\n", false); 
	//else outputText("\"<i></i>\"");
	
	outputText("Raphael curtsies and tips his hat before making his escape. \"<i>You have my condolences.</i>\"\n\n", false);

	outputText("You resolve to wash your hand. You're sure you've not seen the last of the russet rogue, but it will be time in coming before that happens with the severity of your rejection.", false);
	
	//{Game Removal}
	//No more meetings + endgame in 21 days
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 0;
	flags[kFLAGS.REJECTED_RAPHAEL] = 1;
	doNext(playerMenu);
}

//{When player chooses swoon after the first encounter}
private function RaphaelFirstMeetingSWOON():void {
	clearOutput();
	outputText("You snicker softly, shift your weight on one leg and blush a little. He's quite the charmer; almost good enough to forgive him for robbing you. The attention he showers you with doesn't leave you cold either.\n\n", false);

	outputText("\"<i>Normally I rob opulent merchants and criminals. I have no idea what drew me into your camp. Perhaps destiny willed this fateful meeting?</i>\" He looks up and burrs with a suave accent. \"<i>Then again, I am attracted to extraordinary splendor.</i>\" He gazes at you with an emerald shimmer in his rich green eyes.\n\n", false);

	outputText("Curious, you finally ask him who he really is.\n\n", false);

	outputText("\"<i>Why I am Raphael!</i>\" He lisps affectionately and rises slowly. \"<i>Adventurer extraordinaire, redistributors of misplaced wealth and connoisseur of all things fine in life.</i>\" He strides into camp with the kind of respectful confidence that makes the place his own. He pops open the tightly locked trunk with the mere kick of the boot and places his ill-gotten gains back into your belongings. \"<i>The orphanage will have to wait. Tonight, I will regale the small ones with tales of exceptional beauty instead.</i>\"\n\n", false);

	outputText("A faint, nondescript sound is heard and you instantly pull away from the surreality of your little meeting, to realize others might not be so smitten by the apparently world famous thief. What if others discover him? Your mind races to come up with excuses for your illicit rendezvous, but clearly, you're more worried about Raphael's presence than he is. He merely smiles at the noise, keeps his cool and takes you by the hand. One more time he plants a kiss on top of it by bending through crossed knees.\n\n", false);

	outputText("\"<i>For now, do not worry yourself my shining jewel. The russet rogue never forgets a mark. I will answer all your questions in good stead, but for now, patience. I can already tell a woman like you is deserving of delicacy and finesse, like the blooming rose needs nurturing and time to reveal her innermost beauty.</i>\"\n\n", false);

	outputText("In a blink of an eye, the red fox jumps back up the wall. \"<i>We will meet again!</i>\" He exclaims in a hushed tone, while slinking over to the other side of the wall.\n\n", false);

	outputText("You hold the hand he touched close to your chest.", false);

	dynStats("str", -1,"tou", -1, "spe", 3, "sen", 1, "lus", 25);
	doNext(playerMenu);
}

//{When you choose the [Talk] option in the first encounter}
private function RaphaelFirstMeetingTALK():void {
	clearOutput();

	outputText("You squint your eyes at him, pulling on your arm to wrestle it from his hold. When you remark he stole from you and ask him to return your goods, Raphael simply throws you a vulpine smirk.\n\n", false);

	outputText("\"<i>Mere souvenirs fair blossom, to remind me of your beauty!</i>\" He schmoozes and strides into camp with the kind of confidence that makes him own the place. He pops open the tightly locked trunk with the mere kick of a boot and places his ill-gotten gains back into your belongings. From within the large sack, he pinches a small pouch of your gems and quickly spirits it away. With his lightning quick fingers, you see him place it between his shoulders.\n\n", false);

	outputText("You insist he return all of it, but the Russet Rogue merely smiles as he walks back towards you. \"<i>My, whatever do you mean, pretty señorita? Are you accusing me of being less than forthright?</i>\" He raises his shoulders.\n\n", false);

	outputText("Tiring of his charades, you reach behind his neck to retrieve the pilfered pouch, but when you do, there is none to be found. It's the only place he could have put it, but it's gone and he isn't using his arms! You frown. It's clear that the fox is as good as his reputation. He's hiding the pouch with the skill of a pickpocket. You begin to consider how he does it, but before you do, the fox comments on your body posture.\n\n", false);

	outputText("\"<i>My, aren't we frisky. What happened to foreplay? Shouldn't you be buying me dinner before you ravish me? Breakfast perhaps?</i>\" Raphael clucks. You jump away as you realize you've had your hands all over his body.\n\n", false);

	outputText("\"<i>No, my lady. If you ever want to inspect these particular goods, we will have to meet again!</i>\"  Raphael hops up the same wall, spinning about on one leg. \"<i>Do not worry yourself, my fair flower. The russet rogue never leaves a lady wanting. For now, patience. I can already tell a woman like you is deserving of delicacy and finesse, like the blooming rose needs nurturing and time to present her full glory.</i>\"\n\n", false);

	outputText("In a blink of an eye, the red fox jumps back up the wall. \"<i>We will meet again!</i>\" He exclaims in a hushed tone, while slinking over the wall to land on the other side.\n\n", false);
	
	//{Optional: Raph makes off with 5 gems)
	player.gems -= 5;
	if (player.gems < 0) player.gems = 0;
	statScreenRefresh();
	
	doNext(playerMenu);
}

private function letRaphaelGoFirstMeeting():void {
	clearOutput();
	outputText("You tell him to just let go.\n\n");
	
	outputText("\"<i>Thank you, friend. We may meet again,</i>\" He says. With that, he saunters off into the distance.");
	player.gems -= 5;
	if (player.gems < 0) player.gems = 0;
	statScreenRefresh();
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 0;
	flags[kFLAGS.REJECTED_RAPHAEL] = 0;
	doNext(playerMenu);
}

//Take that, homophobia!
private function rapeRaphael():void {
	clearOutput();
	outputText("That fox must be punished for his deeds. After all, he did try to rob you! You quickly grab him by the wrists and kick his rapier away.");
	if (player.str + rand(30) < 50) { //Fail, Raphael escapes.
		outputText("\n\nRaphael quickly wiggles out of your grip, picks up his rapier and runs away, denying you a chance to rape! Fortunately, he appears to have dropped some gems. You take the gems and pocket them.");
		player.gems += 10 + rand(20);
		statScreenRefresh();
		flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 0;
		flags[kFLAGS.REJECTED_RAPHAEL] = 1; 
		doNext(playerMenu);
		return;
	}
	outputText("\n\nYou pin him under your weight" + player.clothedOrNakedLower(", remove your [armor]", "") + " and quickly yank his pants off, exposing his tight butt-cheeks. \"<i>No! Don't put that in there!</i>\" Raphael cries. It's his loss and he must pay the ultimate price: his virginity.");
	outputText("\n\nRaphael gasps as your [cock] meets the star of his pucker. Despite Raphael yelling at you, you're determined to teach him a lesson. You slide your [cock] right into his butthole, revelling in his virgin tightness. <b>Raphael has lost his anal virginity!</b>");
	outputText("\n\n\"<i>No! Your cock! Get it out of my butt! It's not normal! Sex is supposed to be about one man and one woman!</i>\" Raphael yells. You whisper into his ears and tell him that here in Mareth, anal sex is perfectly normal and it's a common occurrence. He's just too vanilla for his tastes! Time to spice things up.");
	outputText("\n\nYou shove him on the ground, grab him by the legs and push your [cock] as deep as you can. Deeming the depth sufficient, you begin to piston in and out, picking up the speed until you're practically ravaging his ass. The russet rogue yelps in mixed pain and pleasure, his vulpine cock sliding out of its sheath and inflates to full erection. You continue to fuck him like there's no tomorrow.");
	if (player.countCocksOfType(CockTypesEnum.TENTACLE) > 0) outputText("You push your tentacle cock in all the way through. You can feel it snaking its way through his intestines and stomach before finally comes out of his mouth! The fox looks down, unable to speak. You laugh at the poor fox-thief and pull your cock so you're just fucking his anus.");
	outputText("\n\nEventually, you can hold back no more and empty your seed into his bowels. Raphael cums as well, shooting ropes of fox-jizz. With your orgasmic high complete, you pull your cock out of his ass, cum still dripping from his abused butthole. You give him a naughty grin and take his gems and rapier while he's still dazed. To the victor go the spoils after all! ");
	player.gems += 100 + rand(20);
	player.orgasm();
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 0;
	flags[kFLAGS.REJECTED_RAPHAEL] = 1;
	inventory.takeItem(weapons.RRAPIER, rapeRaphaelII);
}
private function rapeRaphaelII():void {
	clearOutput();
	outputText("You clean your [cock]" + player.clothedOrNakedLower(", redress in your [armor]", "") + " and drag Raphael's dazed body to the edge of the camp. Hopefully he'll wake up and never enter your camp again. Serves that fox thief right for trying to rob you!");
	doNext(playerMenu);
}
//{Second encounter.} 
//Again at bedtime
private function RaphaelDress():void {
	clearOutput();
	outputText("A small pebble hits the ground near you, waking you up. When a second one hits, you're sure someone is trying to draw your attention.\n\n", false);

	outputText("Rubbing your eyes, you pull yourself out of bed, wondering what's going on. Sticking your head through the front wall of your " + camp.homeDesc() + ", you take a curious peek outside, but find no one around.\n\n", false);

	outputText("The first thing you do is open your storage chest, to see if the Russet Rogue has robbed you again. This doesn't appear to be the case, and instantly, your eye is drawn to an addition instead of a subtraction from its contents. You seem to have gained a new outfit! Upon a carefully folded fabric of rose red color, a note is left below a gorgeous ruby pendant upon a golden setting and carried by a filigree chain. Curiously, you open the note and read it.\n\n", false);

	outputText("\"<i>I happened across this beautiful ensemble and was instantly reminded of the one thing in Mareth that makes its splendor pale in comparison. Fair trappings, to fit around a beautiful body.\n\n", false);

	outputText("Yours faithfully,\n  - The Russet Rogue\n\n", false);

	outputText("P.S. The clothes are my gift to you. I would delight to see you wear it whenever you desire to meet. Ownership of the ruby however, remains to be seen.</i>\"\n\n", false);

	outputText("You hold the ruby pendant to the light. It must be priceless. Its crimson shimmer is enough to make you forget to ask yourself where Raphael could have gotten it from. You wonder what he means by ownership. It very clearly is in your possession now.\n\n", false);

	outputText("Soon enough you put it down and begin to inspect the equally lustrous garment he left you. You unfold it and marvel at the Bordeaux colored clothes.", false);
	//nxt page
	doNext(RaphaelDressPtII);
}

//~~~ Next Page ~~~
private function RaphaelDressPtII():void {
	clearOutput();
	outputText("It's a one piece suit, combining intricate full-body stockings with a graceful corset and an elegant long sleeve, short top jacket sewn in. You try to slip into the unitard and soon figure out you're supposed to do so in the nude, with the tight outfit serving as underwear and overwear both. Made of the finest silk, the feeling is sensual when your naked body slides into the satin lattice and fills out the pliable lacework with your volume. Pulling on the zipper in the back, you seal yourself in and reign the corset tight. It causes the suit to hug and clutch every curve on you with comfortable snugness, bringing out the rounds and the flow of your body. With the incorporated leather corset pressing into your waist, it also forces you to maintain a dignified, elegant posture. It fits like a literal glove, with rings across each of your fingers to pull down its sleeves and leather padding below the stockings of your feet. You can't help but tug the corset's cords one more time to add upon the tightness and an added feeling of secure comfort. Other than that, the fabric is featherlight and you soon notice how some parts do a better job at covering you up than others.\n\n", false);
	
	outputText("All over your body where the gossamer isn't reinforced with jacket or corset, the density of the delicate velvet web varies. Although the silk hugs across your " + player.vaginaDescript(0) + " and through the crack of your ass as a triple layer that guards against prying eyes, the surface of your hips and legs is clearly seen through the transparent motif of flowers swirling across the lace. The cheeks of your " + player.buttDescript() + " feel equally exposed despite the presence of four sweeping rosebranches stitched across them, but at least the jacket trails past your lower back and partly covers your buttocks with its parted tailflaps.", false);
	//({If player has tail}
	if (player.tailType > TAIL_TYPE_NONE) outputText("  Your tail peeks out through the cut.", false);
	outputText("  You still can't help but feel that anyone standing behind you is given a generous glimpse of your ornate ass, however. The same goes for your " + player.breastDescript(0) + "; cupped, lifted and presented as they are to the outside world by grasping silk. Their ample curve and tender flesh are clearly visible through the red lace. The only thing saving their modesty is the tactical application of a sea of organic patterns across the lower half, with the curl of two roses covering your " + player.nippleDescript(0) + "s. The ensemble comes with a pair of red stiletto high heels, but you're not sure you're ready for them. Wearing them would only perk up your noticeable posterior even more. That your " + player.breastDescript(0) + " contrast above a slender waist is enough for now. Maybe on special occasions.\n\n", false);
	
	outputText("You blush as the wind breezes by, and with the exception of the upper jacket, feel like you're wearing nothing at all. This sensation is only aggravated when you can't help but slip a finger across your inner thigh and feel it glide up effortlessly across the textile. It's like you've only become more sensitive for wearing it. Much to your amazement, the triple layer across your " + player.vaginaDescript(0) + " doesn't provide quite as much protection as you assumed earlier; at least not so much against roving fingers. You find the fabric across your womanhood has a hidden opening to it. Rubbing through it is enough to part the velvet folds and set your finger upon your own. It's not apparent, but anyone aware of this shameful split would have easy access to your depths without even disrobing you. You feel nude.\n\n", false);

	outputText("You stand up straight and look over your body one more time. With this outfit, you could walk into a stately ballroom with as much confidence as you could a seedy burlesque, even though both places would be filled with people turning their heads. At least your blush would match the color of the outfit, while an audience would try to figure out whether you're either a lost duchess or a stray dancer. You're not certain if you want to continue wearing it, although you're sure Raphael would appreciate you for it.  You change back for now - you'll have to decide once you've cleared your head.", false);

	//{Third encounter unlocked}
	//Set 'time to wear dress' countdown.
	flags[kFLAGS.RAPHAEL_DRESS_TIMER] = 7;
	inventory.takeItem(armors.R_BDYST, playerMenu);
}

/*DRESS HERE
Descriptive: A high society bodysuit. It is as easy to mistake it for ballroom apparel as it is for boudoir lingerie. The thin transparent fabric is so light and airy that it makes avoiding blows a second nature.
Optional: 
Multiplies evasion ratings. It has crap armor rating.
~~~*/


private function RaphaelEncounterIIDressFollowup():void {
	//{Encounter two}
	//{Requirement: PC is wearing High society bodysuit. 
	//Sequence: When PC wakes up the next day.})
	flags[kFLAGS.RAPHAEL_SECOND_DATE] = 1;
	//Clear dress countdown.  Its over and done with.
	flags[kFLAGS.RAPHAEL_DRESS_TIMER] = -1;
	clearOutput();
	
	outputText("You awake to the soft patter of footsteps moving away from you. For a second you think nothing of it, but soon awake to the realization you might have been robbed again. When you sit up and notice a weight off your chest, you realize someone has made off with the priceless ruby pendant Raphael gifted you earlier. They swiped it straight off your neck!\n\n", false);

	outputText("You rush out of your " + camp.homeDesc() + ", but when you look around and spot something red lying on the small ruined wall on the outskirts of your camp, you realize that the situation isn't as urgent as you had feared. You begin to understand what the wily fox meant to imply with uncertain ownership of the pendant.\n\n", false);

	outputText("Curious, you amble towards the Russet Rogue. Raphael, this time armed with a picnic basket and a bottle of fine wine, makes a nonchalant impression as he lies leisurely on top of the wall. His tail flicks about playfully, while he swirls a small amount of wine within a crystal glass. At first he looks at the fluid casually and takes a sip, before rolling his head sideways to look down upon you.\n\n", false);

	//({If player still meets the first encounter requirements:} 
	if (RaphaelLikes()) {
		outputText("\"<i>How long ago was it, that you had a decent breakfast, hhhmmm?</i>\" He smirks. \"<i>One that didn't include imp gut and hellhound testicles. A worn out camp like this one is no place for a lady. Let me at least endeavor to give a woman of your caliber a taste of the good life.</i>\"\n\n", false);

		outputText("When you inspect the rest of his body, it's clear that Raphael is still the sly fox. Your ruby pendant hangs from his belt. He has once again stolen it from you after gifting it earlier, like it was some game. When he notices your interest, he flicks his tail over it, causing the necklace to disappear.\n\n", false);

		outputText("\"<i>The temporary price of admission for a moment of wonder.</i>\" He assures you. \"<i>Trust me that it'll be worth it. Join me, and I might even teach you the tricks of the trade. That is, unless you're cunning enough to frisk me for it.</i>\" He smiles playfully.\n\n", false);

		outputText("What do you do?", false);
		flags[kFLAGS.RAPHAEL_DISGUSTED_BY_PC_APPEARANCE] = 0;
		//[Reject] [Frisk] [Date]
		simpleChoices("Reject", RaphaelChooseReject, "Frisk", RaphaelChooseFrisk, "Date", RaphaelSelectDate, "", null, "", null);
	}
	//({If player does not meet the first encounter requirements:}
	else {
		outputText("When he catches sight of you, he spurts out the sip.\n\n", false);

		outputText("\"<i>Mon Dieu!</i>\" he states in shock and stands up on top of his wall.\n\n", false);

		outputText("\"<i>What terrible tragedy! The land has taken its toll on the once so beautiful.</i>\" He looks down on you.\n\n", false);

		//({If player has no legs, or a centaur body.}
		if (player.isNaga() || player.lowerBody == LOWER_BODY_TYPE_GOO || player.isTaur() || player.isDrider()) 
			outputText("\"<i>You're missing half your body!</i>\" He refers to your morphed legs.\n\n", false);
		//({If player has above E cup breasts} 
		if (player.biggestTitSize() >= 7) outputText("\"<i>Your female curves... replaced with such... udders!</i>\" He looks at your bosom. \"<i>No woman could be elegant with such monstrosities up front!</i>\"\n\n", false);
		//({If player has below C cup breasts} 
		if (player.biggestTitSize() < 3) outputText("\"<i>Your female curves... gone!</i>\" He looks at your bosom. \"<i>It's hard to tell you apart from a little girl!</i>\"\n\n", false); 
		//({If player has grown less than girly hips}
		if (player.hipRating < 6) outputText("\"<i>What happened to that fine hourglass shaped figure? Those comely hips?</i>\"\n\n", false);
		//({If player has gotten a massive butt} 
		if (player.buttRating >= 13) outputText("\"<i>Oh... my... Marae! " + player.short + ", look at your butt. It is so big! You look one of those cat guy's girlfriends. Who understands those cat guys? You look like a total prostitute. I mean, your butt. It's just so big. I can't believe it's just so round and so out there! Gross!</i>\"  The fox shakes his head and breaks it down. \"<i>I hate big butts! So vulgar.</i>\"\n\n", false); 
		//({If female player has gotten bigger than 6 feet}
		if (player.tallness > 72) outputText("Raphael rolls his eyes across your giant body and looks intimidated. \"<i>I can forget about remaining unseen when I take someone of your size somewhere!</i>\"\n\n", false);
		//({If female player has gotten smaller than 4 feet}
		if (player.tallness < 48) outputText("Raphael squints like he has trouble seeing you from there, because of your dimunitive size. \"<i>I've dated goblins once... didn't work out.</i>\"\n\n", false); 
		//({If player has grown ANY cock and balls}
		if (player.balls > 0 || player.cockTotal() > 0) outputText("\"<i>What is that bulge below the tight outfit I gave you?</i>\" The fox inspects your groin. \"<i>No, never mind. I don't want to know.</i>\"\n\n", false); 
		//(For now: 
		//({If player has lost all gender}
		if (player.gender == 0) outputText("\"<i>There's... something different about you today. Your smell, it has changed.</i>\"\n\n", false);

		outputText("The fox looks dissapointed. \"<i>Beauty is in the eye of the beholder, but it certainly isn't gracing mine right now.  señorita... or what remains of you, please clean yourself up. Meanwhile, I just remembered: I have a sick mother to take care of. I hope you'll excuse me!</i>\" he mentions before hopping back of the wall and making a hasty retreat.\n\n", false);
				
		outputText("You clench your jaw as he vanishes, more than a bit offended.", false);

		//{Game removal untill the PC complies with the requirements again.})
		doNext(playerMenu);
		flags[kFLAGS.RAPHAEL_DISGUSTED_BY_PC_APPEARANCE] = 1;
		//7 days to fix or done with!
	}
}

//{Choose [Date] after second encounter}
private function RaphaelSelectDate():void {
	clearOutput();
	outputText("You smile bashfully, not expecting this sort of gesture from anyone in Mareth. You hardly care about the pendant and you nod at him.\n\n", false);

	outputText("\"<i>Ha-ha!</i>\" Raphael hops to his feet on top the wall and gloats at you. \"<i>You're sure you're ready for this journey? Because I'm going to show you the time of your life!</i>\" He kneels down on top his wall and extends you his hand on approach.\n\n", false);

	outputText("It almost feels like you're consenting when you reach for his soft, cushioned padded furry paw, after which he pulls you up and helps you over the wall.", false);
	//{Unlocks Picnic}
	doNext(RaphaelPicnic);
}
//{When player chooses [Reject] after second encounter}
private function RaphaelChooseReject():void {
	outputText("",true);
	outputText("You sigh at the fox and shake your head. You're not interested in him or his advances.\n\n", false); 

	outputText("He flicks his tail past his body again and within the blink of an aye, the glass of wine is exchanged for the stolen pendant.\n\n", false);

	outputText("\"<i>The Russet Rogue is no thief, señora.</i>\" He states seriously and tosses the bauble back at your feet. You drop your frown.\n\n", false);

	outputText("\"<i>Such a pity though... the flower who refused to bloom.</i>\" He stands atop his crumbled wall. \"<i>Take my advice fair lady. Life is too short and this world too fleeting, for missed opportunities. Let your hair drop, loosen your guard and enjoy the finer things in life.</i>\" He nods and winks at you. \"<i>You might discover it might not be so bad.</i>\"\n\n", false); 

	outputText("In the two seconds it takes for you to pick up the pouch, you find that the fox has vanished as though he were never there. Amazed, you climb onto the wall and try to figure out where he'd gone that fast. Peeking over the wall confirms your suspicions of him simply letting himself fall off the wall to make an elegant exit. A single shattered glass can be found on the other side, but no trace of the fox.", false);
	//{Game Removal.}
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 14;
	flags[kFLAGS.REJECTED_RAPHAEL] = 1;
	doNext(playerMenu);
}

//{When player chooses [Frisk] after second encounter}
private function RaphaelChooseFrisk():void {
	flags[kFLAGS.FUCK_YOU_GOT_MINE_RAPHAEL] = 0;
	clearOutput();
	outputText("You flash a playful smile and express the desire to get your jewelry back.\n\n", false);

	outputText("Challenged, Raphael hops from his perch and leans against the wall like a misbehaved rascal at your approach. With his back towards the boulders, he has his hands behind his head and one foot up against the stacked cobblestone; braving his body like he's eager for your touch. \"<i>My, whatever are you talking about, señorita? Know something I don't?</i>\"\n\n", false); 

	outputText("Noticing how Raphael leaves more room between his hands and his head than necessary, you reach beind his neck to retrieve the pilfered pendant, but when you do, there is none to be found. It's the only place he could have put it, but it's gone and he isn't using his arms!\n\n", false);
	
	/// Int/Spe Variables ///
	//({Int or Spe below 24 and Cor is not higher than 19} 
	if ((player.inte < 24 && player.spe < 24) && player.cor < 19) {
		outputText("You frown, befuddled and eyeing the body you hold close to yours. He must be a magician, you conclude.\n\n", false); 

		outputText("When you look up again, you realize you have your arms around his neck. His verdant green eyes peer into yours daringly and before the awkward moment has a chance to pass, the russet rogue steals a kiss. Putting the tip of his snout on your lips, he gives you a kiss more passionate and skilled than you thought possible with a sharp muzzle such as his. He discontinues before you have the time to either enjoy it or feel intimidated by it.\n\n", false);

		outputText("\"<i>Forgive me...</i>\" He growls softly with low tone. \"<i>You're just so cute when consternated.</i>\"\n\n", false); 

		outputText("\"<i>But the day is young!</i>\" He proclaims before slipping from your hold and up the wall, extending you his paw. \"<i>Join me! Together we shall paint the forest russet red!</i>\" He winks at you while pulling you up. \"<i>Maybe I could even show you how I do it, huh?</i>\"\n\n", false);
		//{Next scene picnic}
		doNext(RaphaelPicnic);
	}
	//({Int or Spe between 24-36 and Cor is not higher than that}
	else if ((player.inte < 36 && player.spe < 36) && player.cor < 36) {
		outputText("Not outdone through wit, you notice how the fox is moving his tail about. The wileful rogue is using his fifth limb to move the pendant about his body! You quickly reach around and pat him across the back and flanks, but inspecting the tip of his tail leaves the pendant nowhere to be found. By then Raphael is moving his arms and legs to misplace it further. In a game of cat and mouse all through his red fur, you follow the movement from his lower back, to his feet and his thighs. The sly vulpine clearly enjoys leading you on your hunt across his skin and supple deerskin attire, as you graze over taut leather spanned across a contoured, masculine body. Raphael always appears one step ahead. That is, until the trail ends near his crotch.\n\n", false);

		//({If player corruption is below 15} 
		if (player.cor <= 15) outputText("You have the stronge urge to grab hold of the oddly enlarged bulge between his legs and retrieve the necklace from within his pants, but the lewdness of the gesture keeps you from it.\n\n", false);
		//{If player corruption is at or higher than 15} 
		else outputText("With no intention to relent, you grab him by the oddly enlarged bulge in his tight leather pants and squeeze softly, discovering how several of his jewels are harder than others. He hid your gem amongst his own!\n\n", false);

		outputText("\"<i>My, aren't we frisky. What happened to foreplay? Shouldn't you be buying me dinner before you ravish me? Breakfast perhaps?</i>\" Raphael clucks. \"<i>Although frankly.</i>\" He growls softly with low tone. \"<i>I would gladly suffer through a thousand indignities, for a mere touch from one such as you.</i>\"\n\n", false);
		
		outputText("\"<i>But the day is young!</i>\" He proclaims before slipping from your hold and up the wall, extending you his paw. \"<i>Join me! Together we shall paint the forest russet red!</i>\" He winks at you while pulling you up. \"<i>You have skill though. Stick with me and maybe I can teach you.</i>\"\n\n", false);
		//{Next scene picnic}
		doNext(RaphaelPicnic);
	}
	//({Int or Spe are above 35 and Cor is not higher than that}
	else if (player.cor < 35) {
		outputText("Figuring it out easily, you notice how the fox is moving his tail about. The sneaky rogue is using his fifth limb to move the pendant about his body! Deducing the only way he could do that without moving his arms, you reach for the heel of his lifted foot and intercept the string before he can pass it onto his leg.\n\n", false);

		outputText("\"<i>Nice try!</i>\" You comment with a triumphant smile, when you quickly retrieve the necklace and walk away from Raphael before he realizes you've outwitted him. You hug the jewelry tight.\n\n", false);

		outputText("The fox seems like a gracious loser and the young man beams. \"<i>Well played!</i>\" He congratulates you behind your back. \"<i>You show potential. However, I urge you not to grow complacent. There's quite a few tricks that only a true master thief like I possesses. If you'd allow me, I could teach you even more about my craft, graduate you into a whole new way of living. One you never knew existed...</i>\"\n\n", false);
		
		outputText("How do you respond?", false);
		//Reject] [Accept]
		simpleChoices("Reject", friskRejectChoice, "Accept", friskAcceptChoice, "", null, "", null, "", null);
	}
	//{If player's corruption is higher than 19 and higher than Intelligence.}
	else {
		outputText("You don't quite manage to follow where Raphael keeps the pendant, but you're certain it's somewhere on his body and you intend to find out where! With more eagerness than the fox had expected, you paw across his lean body. You slip into his leather clothes and run the hairs of his fur through scraping fingers. It makes Raphael gasp slightly as you trace down his body, eventually discovering that the bulge in front of his tight leather pants has become larger than you noticed it to be earlier!\n\n", false);

		outputText("\"<i>My, such an eager little thing.</i>\" He comments, pleased.\n\n", false);

		outputText("You ask yourself the age old question if he's just happy to see you, but you suspect differently when you reach out for the firm lump and cup it.\n\n", false);

		outputText("What do you do?", false);
		//[Squeeze] [Fondle]
		simpleChoices("Squeeze", friskSqueezeChoice, "Fondle", friskFondleChoice, "", null, "", null, "", null);
	}
}

//[Accept]
private function friskAcceptChoice():void {
	flags[kFLAGS.FUCK_OFF_THEIVING_RAPHAEL] = 1;
	clearOutput();
	outputText("\"<i>Come on then!</i>\" He proclaims before shooting up the wall, extending you his paw. \"<i>Join me! Together we shall paint the forest russet red!</i>\"\n\n", false);

	outputText("You waive his paw and choose to walk around the 8 foot long wall, instead of struggling to climb over it. Raphael flashes a grin of delight when you do. \"<i>I can see I've caught on to a smart one! Stick with me and I could even finish your education. I promise that graduation will be something... special.</i>\"\n\n", false); 
	//{Next scene picnic}
	doNext(RaphaelPicnic);
}

//[reject]
private function friskRejectChoice():void {
	clearOutput();
	outputText("You scoff, cross your arms and reject the offer by telling Raph your answer from across your shoulder, with your back still turned to him aloofly. Pleased with yourself, you add that he's nothing more than a carnie with an accent and that you won't be needing his help.\n\n", false);

	outputText("\"<i>As you say, my desert rose. It is clear that I have no more to teach you then.</i>\"\n\n", false);

	outputText("You startle when you hear the fox bang against your chest. When you turn around, he's once again stealing from you!\n\n", false);

	outputText("\"<i>There's no teaching those of lesser stock a sense of grace and refinement. Those are still decidedly my domain!</i>\" He guffaws with a bag of goods across his back and runs off.\n\n", false);

	outputText("\"<i>Even without a belt on?</i>\" You ask him, holding up the leather strap he wore across his waist a mere minute ago. You took the time to swipe it along with the pendant.\n\n", false);

	outputText("As Raphael bolts, he has a look of surprise on his face. He doesn't last long before his pants drop to his ankles and he falls flat on his face.\n\n", false);

	outputText("He yelps when he loses hold of the bag, which drops to the ground. The fox uses both hands to protect his modesty by holding up his pantaloons, slipping over the spilt gems a few good times and flailing about, before finally making it to the wall with nothing to show for it.\n\n", false);

	outputText("\"<i>I will regain my honor!</i>\" He exclaims while waving his hands in a theatrical flourish, causing his pants to drop once more.\n\n", false);
	
	outputText("You laugh as he blushes, beating a sound retreat. You're sure this won't be the last you'll see of him however.", false);
	//{Game removal}
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 14;
	flags[kFLAGS.REJECTED_RAPHAEL] = 1;
	doNext(playerMenu);

}

//[Fondle]
private function friskFondleChoice():void {
	clearOutput();
	outputText("You gently massage the leathery package. It increases in size until a distinct shape of some length forms above it. When Raphael moves his hips forward appreciatively, you look up, throw him a smile and slip your hand into his pants. He's not wearing any underwear, you notice as you rummage about. Struggling to restrain yourself, you slip past the throbbing meat of his naked cock and dig around his jewels instead, removing the ruby from behind them.\n\n", false);

	outputText("\"<i>Such a good girl you are.</i>\" He smirks lewdly. \"<i>You have a lot of talent in those fingers. A distinct gift. There's a lot I could show a feisty little minx such as you.</i>\"\n\n", false);

	outputText("You deftly remove the sweat stained, fogged up stones and tug them away between your breasts.\n\n", false);

	outputText("\"<i>And I in turn, will have to retrieve those.</i>\" He growls low.\n\n", false);

	outputText("\"<i>But the day is young!</i>\" He proclaims before shooting up the wall and extending you his paw. \"<i>Join me! Together we shall paint the forest russet red!</i>\" He winks at you while pulling you up. \"<i>Stick with me and I could finish your education. I will promise that your graduation will be... everything you hoped for. Like the wild mare is shown what is expected from her, the russet rogue never leaves a lady wanting.</i>\"\n\n", false); 
	dynStats("str", -1,"tou", -1, "spe", 3, "sen", 1, "lus", 25);
	//{Next scene Picnic}
	doNext(RaphaelPicnic);
}

//[Squeeze]
private function friskSqueezeChoice():void {
	clearOutput();
	outputText("Vicious and eager to teach him some humility, you dig into the tender package and squeeze hard enough to drive the sharp edges of your pendant into Raphael's jewels. The fox immediately grabs you by the wrist, but this is one trap he isn't wriggling out of. You drive him to his knees while he lets out a high pitched, muffled squeal replete with a blank, agonized expression on his face.\n\n", false);

	outputText("\"<i>You have some balls stealing from me fox.</i>\" You comment and grin. \"<i>Just checking. Is that too soft or should I squeeze harder?</i>\"\n\n", false);

	outputText("Raphael shakes his head while a tear wells up in his eyes. When you roll his privates into the sharp edges, he finally lets out a cry loud enough to hear from miles away.\n\n", false);

	outputText("You chuckle and look around you to see if anyone heard. When you look back to see him squirming between your fingers however, all you're holding onto is the ruby pendant. Raphael has pulled off an amazing switching trick and has escaped. Instead, he stands on top the wall panting and defiant.\n\n", false);

	outputText("\"<i>I'll be sure to repay the favor.</i>\" He warns you with a high pitched voice while clasping his poor genitals. \"<i>Nobody touches my goods like that and gets away with it.</i>\"\n\n", false);

	outputText("He raises just a single finger to the air and groans painfully. \"<i>We will meet again!</i>\"\n\n", false);

	//{Game removal}
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 14;
	flags[kFLAGS.REJECTED_RAPHAEL] = 1;
	doNext(playerMenu);
}

private function RaphaelPicnic():void {
	clearOutput();
	outputText("As Raphael leads you forward by your hand, you ask him where he's taking you. When he leads you deeper into the forest however, he requests you keep quiet with a wink and a smile. You had nearly forgotten about the dangers of Mareth because of your chaperon's boldness, but are reminded of them as Raphael often holds to perk his ears up as if tracking noises. Something about him makes you feel safe however and your confidence isn't misplaced. Even though you walk ahead for almost an hour, you never seem to stumble upon any imps, goblins or giant bees. Raphael often pauses and then decides to head another way as if sensing their presence ahead. For the first time since you got here, you actually manage to enjoy your surroundings, with the Russet Rogue keeping an eye out for danger. Even seeing a giant tentacle beast lurch by beneath gives no cause for concern, when Raphael hides the two of you up a tree and the creature seems oblivious to your presence.\n\n", false);

	outputText("The trek goes on for another half an hour and just when you're pleasantly spent from your eventful stroll, Raphael reveals the spot he's been leading you towards. In a forest clearing, a lush meadow reveals itself, overgrown with flowers of all kinds. The soft moss in the middle seems like the perfect place for a picnic and the Fox takes out a large blanket and puts down the basket. Walking has given you a healthy appetite and your tummy growls softly at the sight of fresh croissants and lean strips of bacon. You blush and hope that the fox's sharp ears haven't picked up the gentle sound, but that's probably too much to hope for as he smirks at you from the side.\n\n", false);

	outputText("\"<i>Mademoiselle?</i>\" Raphael inquires your readiness. \"<i>Breakfast, is served!</i>\" he exclaims while uncorking a bottle of wine.  He has neatly arranged a series of plates, each filled with small delicacies.\n\n", false);

	outputText("You smile at the flower flanked arrangement. It almost looks far too good to be true, but the smell wafting from the still warm drumsticks is simply too good to pass up on. You sink to your knees and wait patiently for Raphael to join you. The wine babbles warm and softly upon the glass when he pours it, standing at a perfect 90 degree angle from the hips, his tail as a balance and one arm in the back. It gives you a chance to admire him. He's been wagging that tight butt in front of you the entire journey over here, while his silky tail almost appears to trap sunlight within its fine long hairs. From tip to bottom, a white streak runs down his body's underside. You're not sure whether you approve of his clothes. He's a fine dresser and you admire the color and quality of the leather covering his body, but you wonder if he'd look even better without them on. A pelt and clothes both seem like an odd combination, despite being fashionable.\n\n", false);

	outputText("Only when Raphael picks up a piece of bacon and nibbles on it, do you seek to satisfy your own urge by breaking off a piece of baguette and washing the moist bread down with a sip of wine. You're oddly at peace with consuming something of Raphael's. Not only because he partakes just as eagerly, but because spiking the food doesn't seem like his style. Going over the dangers in your mind however, you also quickly realize that this is simply his method of winning you over with charm. Deep down, you're still supposed to be the hero champion this realm needs. It will take more than just wine and pastry to win you over.", false);
	//~~~ Next page ~~~
	doNext(RaphaelPicnicII);
}
private function RaphaelPicnicII():void {
	clearOutput();
	outputText("You clear your throat and look at the fox knowingly. A look only returned to him by a coy smile of innocence, while he pours you another glass. You'll indulge him for now...\n\n", false);

	outputText("Curious and certain he has a great deal of knowledge on Mareth, you begin asking Raphael questions about his craft and his experiences. Soon enough, two distinct subjects come up as possible topics. Then again, the wine goes straight to your head and this seems like the perfect time to enjoy more leisurely activities and simply enjoy yourself.\n\n", false);
	//[Discuss] [Skill] [Flirt]
	simpleChoices("Fencing", RaphaelPicnicSkill, "Thieving", RaphaelPicnicChooseThieving, "Flirt", null, "", null, "", null);
}
private function RaphaelPicnicEnd():void {
	clearOutput();
	outputText("The fox is a thief of more than just gems. The concept of time vanishes around him and before you know it, his antics have entertained you for nearly the entire early morning. Raphael is an amazing time sink. You notice how late it is by way of more light peeking in over the forest's treeline. You should return to the portal. It's not difficult to part with the fox however. Only now do you notice how much more anxious and guarded he has become with the increase in light, frequently looking over his shoulder. When you tell him you should be going, the young man smiles, relieved.\n\n", false);

	outputText("\"<i>Are you sure, señorita? In your presence, I would gladly spend an eternity.</i>\"\n\n", false); 

	outputText("You know he's just keeping up appearances and making you feel welcome, however. When you smile and assure him that you must be getting back, Raphael declares his regret one more time before literally scrambling to get away from the meadow, hastily cleaning up the picnic. He doesn't even bother to put things back in the basket. He just takes the four corners of the blanket and folds it into a bag slung over the shoulder. A bit perturbed, you look after him as he slips into the treeline.\n\n", false);
	
	outputText("However, just before he vanishes, the fox gives you a wink and a bow. \"<i>My Lady, it has been a true delight, and it would be to my great fortune if you'd allow me to see you again.</i>\"\n\n", false); 

	outputText("He seems so hasty that you'd begin to question it, but your doubt is taken away as the fox takes the time to stare patiently at you from the forest's edge. \"<i>How could I resist, when you're dressed and made so gorgeously?</i>\" He smiles, referring to your elegant red suit.\n\n", false); 

	if (flags[kFLAGS.FUCK_OFF_THEIVING_RAPHAEL] == 0)
	{
		outputText("A minute of silence follows and just when it has been long enough to reassure you, he throws you something and slips away and vanishes.\n\n", false);

		outputText("You catch the object: he has returned the priceless ruby pendant. You recollect yourself and head back to camp.", false);
	}
	else
	{
		flags[kFLAGS.FUCK_OFF_THEIVING_RAPHAEL] = 0;
		
		outputText("A minute of silence follows and just when it has been long enough to reassure you, he makes his excuses and sets about heading back to... whatever it is the sly fox spends his days doing.\n\n", false);

		outputText("You recollect yourself and head back to camp.", false);	
	}
	doNext(playerMenu);
}

	//{Player chooses [Skill]}
private function RaphaelPicnicSkill():void {
	clearOutput();
	//{Introduction scene that Plays out only once.}
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] == 0) {
		outputText("You allow yourself to be distracted by the sheer opulence of the picnic. Crystal glasses, fine linen blanket, intricately woven basket... and then the clothes and pendant he put on you. Where does he get these things from? It almost leaves you jealous. While you peer across the arrangement, Raphael even manages to retrieve a small guitar. With his long slender fingers, he picks the snares and fine-tunes it. When the Russet Rogue frowns seriously and occupies himself with the small instrument - cradling in its arms focusing on its tortured plinks - you notice just how dedicated and dashing he is.\n\n", false);
		
		outputText("Whatever else is on display however, your eye is consistently caught by the fox's rapier. Raphael has left it sheathed in a scabbard reinforced with silver upon the hard brown leather. The sword's guard sticks out from the sheath and is fashioned out of fine golden filigree that domes around a red hilt. The weapon makes you curious. It appears so delicate that you can hardly believe it to be serviceable in battle.\n\n", false);

		outputText("When you ask Raphael if such a small weapon ever managed to impress anyone, he snaps one of the snares in shock and draws a long face. \"<i>It is not a thin, flimsy thing!</i>\" He balks in his unique accent and loses his cool for a moment. \"<i>I'll have you know it's perfectly average compared to those of others!</i>\" He defends himself with an excitable hand gesture.\n\n", false);

		outputText("There's a moment of awkward silence as you realize the young man places more pride in his sword than you thought. However, Raphael recollects himself with a smile and chuckles at himself like he's been had by someone who just doesn't understand.\n\n", false);

		outputText("\"<i>No, my lady. This is a man's weapon in every definition of the word.</i>\" He beams and picks it up, pulling the blade from the sheath with a cold iron swish. \"<i>Notice how its long hard length stands tall and fierce upon a sturdy hilt designed for deep thrusts.</i>\"\n\n", false);
		
		outputText("Holding it up, it indeed gleams sensually in the sun. However, Raphael then points it downwards and directly at you, carefully tracing the point across your outfit. You can feel the cool edge glide across. \"<i>Notice the roving tip, how she searches for an opening upon a quivering body's wavering guard.</i>\"\n\n", false);
		
		outputText("When Raphael places the point between your breasts, you cannot help but stare at the steely needle with fascination. Driven by long steel, the sharp tip feels heavy enough to slide into your flesh in a single thrust. The feeling is only stronger for wearing an outfit such as yours, leaving your body so acutely vulnerable against the outside world. You stand corrected; there is something very intimidating about it.\n\n", false);
		
		outputText("\"<i>Could I learn to use it?</i>\" You ask Raphael, who then begins to snicker into his fist and snorts unseemly.\n\n", false);
		
		outputText("When you don't flinch and just stare at him in earnest, the fox looks up with surprise. \"<i>Oh, you are serious about that?</i>\" He remarks and snaps out of it by adopting the coy frown typical of the wileful fox.\n\n", false);

		outputText("When you ask him if he thinks that's weird, the vulpine rogue shakes his head. \"<i>Not at all mademoiselle. In fact, I am of the opinion that every woman of your remarkable beauty should know how to defend herself. Perish the thought of having to relinquish your womanhood to anything other than a true gentleman, or having it ravished by beasts instead. And if you must fight, I cannot think of a weapon more suited for a woman than the rapier. I would be honored to teach you.</i>\"\n\n", false); 

		outputText("\"<i>Shall we?</i>\" He jumps to his feet and extends you an arm.\n\n", false);

		outputText("When you ask him if you shouldn't be wearing armor instead of wafer-thin silk bodystockings, he laughs. \"<i>I assure you. For the Rapier, you are dressed perfectly.</i>\"\n\n", false); 
		//{Leads up to fencing variables}
	}
	//{Below 30 speed. PC chooses [Skill] Must play out at least once}
	if (player.spe < 30 || flags[kFLAGS.RAPHAEL_RAPIER_TRANING] == 0) {
		outputText("The two of you amble over to a mossy field. Raphael is up front and waving about his rapier playfully, grazing the tip through the flora and even slashing at a wasp. You can't seem to spot the insect flying around after he does that.\n\n", false);

		outputText("When you reach the center of the field however, Raphael throws the weapon to the ground with temperament and tells you to prepare.\n\n", false);

		outputText("\"<i>Aren't we going to use the weapon?</i>\" You ask him, causing him to smirk.\n\n", false);

		outputText("\"<i>So eager.</i>\" He snarls exitedly. \"<i>Whatever happened to foreplay?</i>\"\n\n", false);

		outputText("You try to explain that this isn't what you meant, but the fox shakes his head. \"<i>The sword is merely an extension of the rest of our body. The sharp of the edge is meaningless, when the arm that aims it and the feet that drive it suffer from inferior technique. It is... footwork.</i>\"\n\n", false);
		
		outputText("\"<i>Observe!</i>\" He exclaims and motions you to keep your distance. For just a moment, Raphael stands still as though caught in a moment of intense preparation.\n\n", false);

		outputText("The first thing Raphael does is to move his feet. He rapidly taps his boots down upon the moss below while he holds both arms wide in the air like a bird of prey, as though working towards a moment of instant momentum. When that moment comes, the fox turns into a true dervish. He spins about, squats down to pick up the rapier and with the long steel in hand, his swerves become only wider for it. The edge cleaves the air, until he draws it to a standstill and flicks the length around faster than you can follow it. He enacts a series of mock parries and dodges, before extending the long weapon forward with an outstretched hand and a straight spine. With the other arm far back, he adopts a posture of perfect poise.\n\n", false);
		
		outputText("From this position he suddenly retreats wildly, jumps backwards and with a frantic kick through the air, lands gracefully again. From there he strides backwards contemptuously and swishes the sword about in wide elegant arcs, like he's mocking the invisible opponent from whom he just escaped into thinking both maneuvers were perfectly calculated through sheer grace. Concentrating hard and starting another maneuver, the fox then closes his eyes. The mien on his snout relaxes when he holds the chin of his triangular head to his chest and centers his balance, to carry the sword around his body in a series of wide sweeps, swiveling on his right foot exactly three times. He only ends the movement by weaving in an extra flick to the side and then putting the tip to the ground, striking a powerful pose. Raphael then throws the steel back towards his hip, twirls it about his side and passes it underneath his arms in elegant fashion, only to tuck it behind his back. A moment of serenity follows where the blade isn't even used.\n\n", false);

		outputText("With the subtle movement of the fingers on an upraised free hand - to a rhythm known only to the fox - he twirls his unburdened hand across his face while staring at you with a smile that couldn't possibly be any more cocksure. You're relieved. For a moment you thought it had vanished after such a deserving display. He deeply enjoys his little performance, knowing damn well it must be impressive.\n\n", false);

		outputText("All of this before he suddenly falls into the last of his repertoire. Drifting lazily towards one foot, he finishes strongly with another series of powerful pirouettes that take him across the entire field within a mere dozen steps. Raphael himself becomes the center calm in his own whirlwind of cleaving cuts. When he veers back into a straight line again, the sight is glorious. Raphael's beautiful long tail is still caught up in the wake of the spin, while his eager blade is already forging ahead in another direction. The two tips are exactly one moment behind and one moment ahead of anything the fox does, like a trailing red shadow and a blurred iron meridian. Before you, he throws the momentum forward, until only the blade swerves around its own forward axis, while he hops about on excited dancing feet. With a beautifully simple thrust, he then simply pierces the rapier forward in a vigorous straight line. It puts all that strength and passion into an idle plunge away from you, dissipating into the thin air around the softly trembling steel. For a moment, you wish such splendid force and elegant might had been reserved for you instead. Such powerful movements, broken by moments of such form and calm.\n\n", false);

		outputText("Raphael has the energy left to manage a theatrical flourish. He swerves his feet about, moves his hands with temperament to strike a few poses, before he puts a hand on the hip of his one straight leg and raises his sword into the air with victorious bravado. \"<i>Footwork!</i>\" He proclaims.\n\n", false);

		//(If this looked like something like this in your mind, I've done well. I couldn't help but try and describe that in words. Warn me if I overdid it. Could try to cut a few sequences. Maybe just a summary will do with fewer Freudian references to sex.)
		outputText("\"<i>Join me my fine fae, and I will teach you to dance.</i>\" He states while discarding the blade.\n\n", false);

		outputText("\"<i>Dance?</i>\" You mumble with a smile, walking up to him and taking him by his hand.\n\n", false);

		outputText("\"<i>Dance!</i>\" He snarls certain, wrapping his paw around your waist and pulling you close to him.\n\n", false); 

		outputText("Raphael tries to lead you off into a slow tango, but obviously overestimates the amount of nimbleness you own feet possess. You quickly rectify this by tripping over his boots and stepping on his toes. Each time provokes a little yelp from the fox, who soon realizes he has his work cut out for him. Whatever Raphael is, he does not give up easy, and you soon dance the morning away on top of his tortured toes.\n\n", false);
		
		outputText("In the end, you're forced to stop practice at Raphael's urging, barely even developing a sense for rhythm. You're simply not fast enough to keep up with the fox... yet. Meanwhile the poor fox has taken off his boots and has seated himself upon a nearby boulder, where he tries to rub the feeling back into his sensitive feet. You can't help but smile a little at your own bungling and feel sorry for the daunting amount of time and effort Raphael needed to put into you with so little to show for it. With you in hand, the otherwise delicate dancer is slowed down into a broken mess. You are determined to try and get better at it though.\n\n", false); 

		outputText("\"<i>I was very impressed by your earlier show.</i>\" You walk over and reassure him. Raphael looks somewhat discouraged.\n\n", false);

		outputText("\"<i>That was the most beautiful thing I ever saw. Do you really think I could ever master that much elegance and refinement, mister fox?</i>\" You chime appreciatively, running a teasing finger down his neck.\n\n", false);

		outputText("Raphael's smile returns for him. \"<i>Raphael!</i>\" He burrs. \"<i>And for someone like you I'd gladly suffer a dozen broken toes at once!</i>\" He boasts. \"<i>I will teach you grace becoming of your beauty yet!</i>\"\n\n", false);

		outputText("\"<i>Again!</i>\" He stands up and extends you an arm with renewed energy.", false);
		dynStats("str", -1,"tou", -1, "spe", 3, "sen", 1, "lus", 25);
		flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 1;
	}
	//{Fencing practice variables: Speed 30-39 Must play out at least once}
	else if (player.spe < 39 || flags[kFLAGS.RAPHAEL_RAPIER_TRANING] == 1) {
		outputText("In the middle of the mossy field, you grab Raphael by his paw as he offers it. The other you instinctively put around his shoulder, when he does the same around your waist. This forces the both of you to hold each other close. A little closer than what you're normally comfortable with. Raphael doesn't seem to mind when you lean away from him however. He treats it as a game between you.\n\n", false);

		outputText("When you ask him if he's sure that this is part of a dance. He chortles. \"<i>M'lady, it takes two to tango!</i>\"\n\n", false); 

		outputText("\"<i>Vamanos!</i>\" The fox moves his feet about, leading you into dance.\n\n", false); 

		outputText("You concentrate on his movements, looking down at his feet. However, you're quick and agile enough to keep up with him and soon drift off into his rhythm. When you look up, Raphael smiles at you while he leads you across the field. You feel the air pass across your skin, through the thin silk of your exposed outfit, but the two of you are fully clothed nonetheless when you glide across the field like the mingled breath of two lovers upon a spring meadow. It has become his game, now that you're nimble enough to keep up with it.\n\n", false);
		
		outputText("He shifts from many intimidating steps towards you, to pulling your body towards his in fevered paces back. You struggle to keep your distance, tangled within his hold and circling around each other like soaring hawks. You grip his shoulder and hand firmly in an effort to make your resistance known, but Raphael simply growls while sweeping you along in heated exertion. You refuse to give in and eventually, you become a slave to the rhythm instead. Your steps are simply that much more elegant, your performance that much more inspired, when you press your lush body into that of the handsome rogue and tighten your steps, loosening your turns. Before you know it, your body rubs and undulates eagerly against the driving fox, until finally, Raphael sweeps you backward. Missing a winding turn, he throws you around his body and catches you just before you fall to the moss. Leaning in over you, he puts his snout to your ear and warbles something in a language of burbling groans unknown to you.\n\n", false);

		outputText("When he picks you back up, he also appears to have picked up his rapier.  Within the hold of both your hands, a firm hilt is now felt and your swirls are accompanied by the sound of swishing metal. When he leads you off into a mutual sideward step across the marsh, it looks as though the both of you are following the rapier's tip as a united entity.\n\n", false); 

		outputText("However, you dig your heels crudely into the moss and stop Raphael from moving any further.  Worried over the inclusion of the razor-sharp weapon, you object to the lack of safety.\n\n", false); 

		outputText("<i>\"Do not fear ze blade!\"</i> Raphael rolls his voice and holds you close to him, to stare deeply into your eyes.  Because the magic of the moment still lingers, you're paralyzed as he explains. <i>\"Do not fear any blade!\"</i> he reiterates fiercely.  <i>\"To fear the blade is to prepare yourself to get hit by it! Such nonsense will not happen, when you are a fencer like I am, like you will become, señorita! Between us, our skill, we will not mention it!\"</i>\n\n", false);

		outputText("You gasp.  For the first time, Raphael forbids you something with harsh tone.  It's quite the departure.  You hang limply from his grasp, your " + player.breastDescript(0) + " squashed against his chest like dough.\n\n", false);

		outputText("<i>\"We will treat the blade like we do our dancing partners, our lovers - even when they are held by the lowly hands of our enemies.  We will drift around them like summer blossoms,\"</i> he declares.  <i>\"And even should it hit us,\"</i> he burrs, low and soft, \"<i>we will accept its icy kiss as a part of our performance, temper its exacting touch with a hot dash of our blood.  Drop your guard mademoiselle; relax, for you are untouchable in your grace and beauty.\"</i>\n\n", false);

		outputText("When he pushes you away from him, his shove is so unexpected that you barrelroll backwards across the moss. Caught up in the moment, you right yourself admirably however and when you do, you notice how the swish of metal has followed to accompany you.  In the tumble, Raphael has granted you control of his rapier.  You now hold onto his weapon, the hilt still warm.  It is such an empowering feeling that you begin to play with it, dancing and twirling along the moss a few times in an emulation of what Raphael did earlier.  You enjoy how it cleaves the air to your motions.  You're not as good as the fox yet, but it is liberating.  While you still feel nude in the clothes Raphael gave you, you also feel guarded behind the ornate hilt. In your elegant full body stockings and red corset-jacket, you must look dangerous, brazen and graceful to any onlooker.\n\n", false); 

		outputText("Only a minute later do you take the chance to stand still and feel the weapon within your grasp.  The hilt cups your hand and you look down upon the weapon standing away from your body with admiration.  When you run a proud finger along its firm length, you shiver.  You could get used to the idea of being a cheeky lady fencer, free and in control.\n\n", false);

		outputText("<i>\"Magnefique.\"</i> Raphael comments, pleased.  <i>\"You could use some work on how to wield it properly, but only because you weren't born with one in hand like I was.\"</i> He smiles, saunters closer to you and releases the rapier from your intoxicated grip by fondling your fingers.  <i>\"You still need a master to show you how to thrust and parry properly.\"</i>\n\n", false);
		
		dynStats("str", -1,"tou", -1, "spe", 3, "sen", 1, "lus", 25);
		flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 2;
	}
	//{Fencing practice variables: Speed 40-49, Must play out at least once}
	else if (player.spe < 49 || flags[kFLAGS.RAPHAEL_RAPIER_TRANING] == 2) {
		outputText("Impressed by your fancy footwork - fast and accurate - Raphael has granted you the use of his rapier.  You are still unsure of how to wield such a precise instrument, but the fox circles you curiously while he makes you practice lunges.  It frustrates you.  They aren't fierce lunges, nor are they long ones.  You don't even get to sweep across the mossy field as playfully or as dramatically as Raphael makes fencing out to be.  Basically you're stuck in your place, walking a straight line and jabbing it limply at an invisible opponent or twisting your wrist in awkward angles to learn all the different parries.  Raphael has given you strict instructions on how to bear your body, but you have to admit that you pay such things lip service.  You'd much rather be impaling something or slashing off the top of a melon, looking cool while doing it.\n\n", false);

		outputText("<i>\"No, no!\"</i> the fox berates you.  <i>\"All wrong! Merde! It feels like I'm working with an amateur here!\"</i> He waves his hands about in anguish and approaches you for the sixth time this session. <i>\"You'll have all the time you need to teach yourself flourish and fancy at a later date. For now, we perfect the basics! You need to have one unifying stance to fall back on. What's not to understand!?\"</i>\n\n", false);

		outputText("You had it coming.  You instantly realize you misaligned the tip with the straight line of your perfectly parallel body.  Perhaps on purpose; it's actually quite fun to see the fox so passionate about little details.  That he drops his role of incorrigible flatterer to become rightly upset with you is rather exciting too.  He's a good teacher, being patient and attentive when you're sincere in your desire to learn, yet relentless and harsh when you slack, no matter how many excuses you make for yourself.  You can't help but feel a little bad when you disappoint him and waste his time.  It drives you to perform better, to please him and reward him for his efforts.\n\n", false);

		outputText("Raphael grabs you by the arm and pulls it further to the side.  He squeezes your wrist, forcing you to loosen your hold on the weapon.  You are startled by the firm pressure behind the gentle grip. You concentrate on his touch and try your best to attune yourself to his changes, but it only causes you to be overwhelmed moreso when the rogue suddenly pushes his body into yours.  You're instantly reminded of how thin your attire is at certain places, when Raphael shoves his fur and leathery garments into you from behind.  In an attempt to do a comprehensive job at posturing you, he moves his hands all over your body, straightening out your arms, moving your legs further apart and making sure your back is arched right.  He tweaks you like an archer would pull back the string of his bow.\n\n", false);

		outputText("<i>\"And most important of all...\"</i>  Raphael places his face beside yours. You can see his snout in the corner of your eyes.  <i>\"...chest forward.\"</i>  Whereupon he slides his paws from your arms down to your " + player.breastDescript(0) + ".  With more audacity than you expected, Raphael fearlessly cups your bosom, pushing breasts up with the long slender fingers.  You can feel the soft, yet callous cushions of his digits brush through the thin silk top.  He tweaks them, even tugs them forward a little, until the fox is perfectly satisfied you're holding them at the right angle.  <i>\"Hips back...\"</i> he remarks, now driving his fingers downwards.  You shudder when you feel them glide past your lower abs, boldly grabbing you by your " + player.hipDescript() + ".  With gentle pressure, he pulls back on your pelvis until you're forced to stick your " + player.buttDescript() + " backwards, rubbing into his loins.  The silk at back leaves the cheeks exposed and only now you realize again how bare you are back there, peeking out underneath the jacket with naught but thin stockings to cover.  You can quite clearly feel the bulge in his pants ride into your " + player.buttDescript() + ".  Raphael's tail flicks from side to side excitedly, perhaps betraying what the fox himself does not.  He keeps his hold strictly professional and urges you to pay heed to your sword arm.\n\n", false);

		outputText("<i>\"Relish the feel of the blade.\"</i>  He angles your hips back a bit further, until his hot bulge nudges into your perineum.  <i>\"Relax to its weight.  Let it fall easily within your grasp.\"</i>  He holds for a second, before throwing you a rather serious look from the corner of your eye.  \"<i>Can you feel it?</i>\" he asks, blowing an inadvertent, hot breath across your ear.  You roll your eyes back and cave by relaxing.  Instantly, your satin-lined rump parts to swallow the mass he pressed against it.  Raphael's bulge sinks firmly into the crack to throb up against the yawning of both your orifices there.  A meeting of flesh is only withheld by the sensual silk of your panties and the supple deerskin of his pantaloons.\n\n", false); 

		outputText("<i>\"I think you have found the proper posture now.\"</i> he comments austerely, holding you by the " + player.breastDescript(0) + " once more to make sure the angle of your back is correct. You push your rear a bit deeper into the fox's loins without needing to be guided in, enjoying the heat pulsing off the seat upon his manhood and how shamelessly you're grinding into him.  You actually begin to wonder if he himself doesn't notice and you struggle to contain the urge to wiggle around and bring attention to it.\n\n", false);

		outputText("<i>\"Think you can remember how this feels?\"</i> Raphael asks. Your flustered acknowledgement comes out in the form of a soft groan.\n\n", false);

		outputText("Perhaps with a deliberate, firmer brush than necessary, Raphael removes his crotch from your upturned ass and moves backward, seemingly uninterested.  He adopts a serious stare, nods and commands you to practice jabs again, this time holding your stance.  You do so to the letter with a bright blush, never remiss, but always feeling Raphael is getting a good look at your exposed buttocks as you raise them towards him like an offering.  His tail wags to the rhythm of the display, even though the fox stares you down solemnly with crossed arms - ever the harsh taskmaster when it comes to grace.\n\n", false);
		dynStats("str", -1,"tou", -1, "spe", 3, "sen", 2, "lus", 60);
		flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 3;
	}
	//{Warning when you have 50 speed, played through all 3 variables and choose {Skill} at the opening picnic}
	else {
		outputText("Regardless of the picnic's splendor, you are quickly drawn to Raphael's rapier again, having gained real feelings for the weapons during your previous sessions with it.  The fox chuckles.  <i>\"My fair fae; she is a woman of taste.  She knows what she wants.\"</i>\n\n", false);

		outputText("The weapon is lying between you.  You stare at it, Raphael stares at you.\n\n", false);

		outputText("<i>\"Would you like to own it?\"</i> he suddenly asks you.\n\n", false);

		outputText("You look up and smile, cautious about the offer.  You've built up a good rapport with the fox, but there's something mischievous about him, that still makes you playfully hesitant to completely trust him.  You ask him what you'd have to do for it.\n\n", false);

		outputText("<i>\"Spar with me over it.\"</i> The master fencer challenges you to what could only be an impossible fight.  He has taught you everything you know about fencing.\n\n", false);

		outputText("What do you do?", false);
		flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 4;
		awardAchievement("Fencer", kACHIEVEMENTS.GENERAL_FENCER);
		//[Fence] [Discuss]
		simpleChoices("Fence", fenceRaphaelSexily, "Discus", fenceOfferChangeToDiscuss, "", null, "", null, "", null);
		return;
	}
	doNext(RaphaelPicnicEnd);
}

private function fenceOfferChangeToDiscuss():void {
	outputText("You blush, intimidated, and change the subject.\n\n", true);
	//{Leads to conversation intro}
	RaphaelPicnicChooseThieving(false);
}

//{Fence leads to the final sex fencing scenes} 
private function fenceRaphaelSexily():void {
	clearOutput();
	//[sexy fencing finale]
	outputText("It's the most beautiful morning yet out on the mossy field - at least, for fencing.  It is a clouded day with perfect overcast.  The fall of light is dispersed and faded, not harsh enough to blind anyone in any direction.  Instead it falls gently upon the dark-green moss in rays of silver gray, shimmering on shoals of opaque pollen and glittering in drifting morning mists.\n\n", false);

	outputText("The tall, fiery fox stands elegantly in the middle as a vivid, lean apparition around whom the bated fogs part.  Of course, you're not doing so bad either in your classy thin outfit, drifting through it like a crimson spirit.\n\n", false);

	outputText("<i>\"Draw your weapon.\"</i> Raphael smirks and points his weapon's scabbard at you, presenting the hilt.  Suspicious, you ask him if sparring shouldn't involve two swords, but the fox curls up one side of his lips and wags the hilt at you one more time.  You draw it before he changes his mind, pull it from Raphael's hold and use footwork to drift away from him.  You roll the blade around as a warning, playfully swishing it like a snake rattling its tail.  You're no longer inexperienced with it and struggle to understand how Raphael plans on getting it back from you.  The tall and stately man stands by motionless and gracious, however, with a proud smirk and an unworried brow.  He steps forward, challenging you, sash and tail flying in the wind.  <i>\"Your move, mademoiselle.  Sadly, few battles in this world are won by exquisite expositioning alone.\"</i>\n\n", false);

	outputText("Eager to see him sweat, you pass forward as if threatening to hit him.  The fox however, doesn't move a muscle at your bluffs, as though instantly recognizing them as harmless when they stop short of hitting him.  After five tries, you feel you've been made a fool of long enough and you bite your lip to the decision that pricking him once couldn't hurt.  Perhaps just once on the shoulder, to show him you mean business.  When you try, though, the fox finally moves into action.\n\n", false); 

	outputText("Using the still-held sheath of the sword, the russet rogue swipes sideways and taps your attack out of the way.  Carrying through the motion, he then lunges out at you in much the same way, armed with only a blunt leather length.  You parry it just before it hits.  It seems Raphael won't be needing a sword after all.\n\n", false);

	outputText("<i>\"En garde,\"</i> the fox states with confidence, calm playfulness, and certain arrogance.\n\n", false);

	outputText("Once again, you dance with the fox, the both of you circling the other while bodies pass by.  At first you hesitate to strike at him with the sharp metal, but Raphael quickly proves he won't let that happen.  You've gotten good with the rapier; just not good enough to actually hit the master fencer.  No matter how hard you try, the fox simply uses gymnastic feats of avoidance to dodge it, while kicking moss about and dragging furrows through the field with roving feet.  Meanwhile, he uses the scabbard to deflect and parry your blows eloquently, brushing it across your weapon's length to steer it away.  Weaved in with subtle strength and careful cunning, he then taps the metal away with powerful strokes of stiff leather.  It is as though your own fashion doesn't affect him, no match for his strength.  It wears you down, chasing after him, often forcing him into awkward positions below your assault, but never quite managing to strike him properly.\n\n", false); 

	outputText("In the end, Raphael even manages to counterattack.  With more gentle care than you bother to apply, he often puts the leather tip into your ribcage as though scoring a hit.  When you begin to realize you're technically losing, the vulpine scoundrel remains gracious about it.  He simply smiles, pokes you a few more times in the wake of your ebbing frenzy, before he does the impossible.  Turning the scabbard back around, he anticipates one of your thrusts and turns the opening towards the incoming tip.\n\n", false); 

	outputText("With a soft metallic scrape, the sword falls into his sheath and you bump clumsily into his body, while Raphael continues to stand firm and proud.  When he holds your wrist to the scabbard, he has effectively disarmed you.  You can't believe it's over when you get back up, using his body as a support.\n\n", false);
	//~~~ Next Page ~~~
	doNext(fenceRaphaelSexilyPtII);
}

private function fenceRaphaelSexilyPtII():void {
	clearOutput();
	outputText("You're a little embarrassed at how easily the fox outdid you.  When you look up and stare him in the eyes however, Raphael is possessing of fantastic sportsmanship.\n\n", false); 

	outputText("<i>\"My lady,\"</i> the fox states delicately, <i>\"that was truly magnificent.  You are a natural, I can tell.\"</i>\n\n", false); 

	outputText("You stammer and are not so sure of that yourself, but the confidence carried in his voice quiets all self-doubt.  Maybe you were good.  Perhaps you could have beaten him in any other way, but just not yet with his weapon of choice.\n\n", false);

	outputText("<i>\"If your opponent had been any other person than me, then surely they would have succumbed to the sheer ferocity and fidelity of your offence.\"</i>  He nods reassuringly and smiles at you.  <i>\"In fact, I think this might be the last of our lessons; you are now good enough to develop your style without me.  There are no more I can think of...\"</i> He pauses, then the fox turns the leather tip towards you and brushes up against you.  <i>\"...with the exception of perhaps one.\"</i>\n\n", false);

	outputText("You ask him anxiously what that lesson could be.\n\n", false);

	outputText("<i>\"Well, it just so happens that your opponent was indeed none other than I.  And faced with such unfair odds...\"</i> the fox growls, <i>\"... this would be the perfect opportunity to show you what losing is like against such opposition.\"</i>\n\n", false);

	outputText("You look up and ask him what he means, but the fox's friendly smile is ever-present as he taps you with his sheathed sword.  You fall silent when first he gently nudges it into your ribcage like scoring another few hits.  When he brushes it in circles across your left breast however, it sends a shiver down your spine.  From there he drags it slowly down your body, from rib to rib, past your stomach, until he does no less than slide the sheath all the way between your legs.  Raphael has touched you many times before, but now his predatory smile does not change when he lifts the length into the folds of your " + player.vaginaDescript(0) + ".  As he stares you down, you realize this has been the most unambiguous gesture yet.  Looking into his deep, emerald eyes sparkling with crafty cunning, you feel how your very essence is held aloft upon his desires.  The ground moves out from under your feet as the sheath digs deeply into your labia.\n\n", false);

	//{If PC has also reached the intelligence Apex}
	if (flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] == 4) {
		outputText("By now, you've grown wise enough to know of his ways.  You spent enough time sitting with him around the picnic blanket to resist his wiles... when you want to.  You hold your breath as the rogue closes in on you, putting his face close to yours.  He growls softly at you and you moan back at him, but only after allowing yourself to do so.\n\n", false);
	
		outputText("When he moves his lips forward, you place your hands on his shoulders and guide him away from your lips and into your neck instead.  He nibbles on it softly, while you have the opportunity to admire the rest of him: his soft fur, his skilful, patient touches and his fine wardrobe.  The sash falls in over your body while the supple brown and purple leather gives the graceful body moving in over you, a sturdy quality.  Spending time with him has rubbed off on you.  Only now do you appreciate the value of certain baubles that cling to his leathered threads, thinking like a pickpocket.  A brooch that can only be priceless decorates the soft silk sash. You reach and fondle the magnificent ornament hanging off his hips. With a few nimble flicks of your fingers, you manage to get it off.\n\n", false);
	}
	//({Female characters who have also raised Intelligence to 49+} 
	if (player.inte > 49) {
		outputText("Still possessing the fighting spirit of earlier and enough wits to resist him, it seems fitting to stand your ground and you push Raphael away from you.  Surprised, he looks you in the eyes and realizes you're still very much in control of your mind and of the situation.  To take you roughly on the moss instead of sweeping you off your feet would be a thing unbecoming of the refined fox. He needs you to consent, to win the game.\n\n", false);

		outputText("<i>\"I have never met a woman with your skills in the rapier,\"</i> he sighs at you.  <i>\"My lady, I must have you.  It would only be right.\"</i>\n\n", false);

		outputText("<i>\"Oh my, are you soliciting me, mister fox?  Right here in the wilds, crudely upon the moss?\"</i> you tease coyly.  <i>\"Wouldn't that mean I lose the game?\"</i>\n\n", false);

		outputText("<i>\"Some games are meant to be lost.\"</i>  He nuzzles you, putting his snout to your ear.  <i>\"It will be... exquisite. Lose yourself, in my capable hands.\"</i>", false);
		
		outputText("Do you let him?", false);
		//[Yes] [No])
		//yes to sex
		//[No] leads up to the universal rejection scene
		doYesNo(RaphaelPostFenceSex,declinePuttingOutForRogues);
	}
	//Elsewise to smex!
	else doNext(RaphaelPostFenceSex);
}

//{speedsex}
private function RaphaelPostFenceSex():void {
	clearOutput();
	outputText("It's already too late to say no; you open your mouth to receive his agile tongue, accompanied by the slow approach of an inquisitive snout and slow breaths.  An intimate embrace follows as you sink slightly into the maw of his muzzle, to wrestle with his limber tongue.  The angle and pressure of the harsh leather sheath between your flushed lower lips might as well have tipped you into his body as you wrap your arms around his neck.  When Raphael drops the harsh intruder to the ground, his paws begin to roam freely on your body.  You can feel them travel everywhere, these soft hands of a swindler, through the thin silk of your outfit.  When they stop to rest on your " + player.buttDescript() + ", he softly fondles your haunches.  You're already lost when he begins to nibble you softly on the neck, sometimes rearing up and whispering things past your ear in a dialect you still can't understand.\n\n", false);

	outputText("His whiskers feel smooth and soft when passing you by into a position behind you.  You must admit, you like this stance best as he lays his impertinent snout on your shoulder and licks your neck with slow laps.  When he starts to cup your " + player.breastDescript(0) + " with the gentle touch of his vulpine paws, you throw your head into his shoulder, reach up to hold him around your neck and stretch your torso.  It brazenly presents all you have to offer while you arch your spine back, your " + player.breastDescript(0) + " more sensitive to his circling swerves.  When your corset is uncinched and the zipper pulled down enough for the fox to flip the fabric down your tits, the touch of the cushions below his skillful fingers is exquisite.  They have a rough sandy texture - every brush an acute sensation.  Raphael wields it with such finesse however, that they feel like the cat's tongue upon a maiden's skin when he brushes by.  When he pinches your " + player.nippleDescript(0) + " between two such pads and flicks it about briskly enough to barely leave an impression on the edge of madness, you feel as though you just climaxed from them.  You shiver when he runs one of those paws down your crotch.  Mercifully, Raphael does not part the silken opening of your suit. Your " + player.clitDescript() + ", sensitive and erect, is spared his unique ministrations.\n\n", false);

	outputText("What he does do is grab your right leg, at the hollow of your knee, and drag it sideways.  It forces you to stand on one leg with your groin spread.  Luckily, your hold around his neck gives you all the support you need.  There's one other thing giving you support, however; as you look down and gasp, Raphael's vulpine cock is resting in the hollow of your groin, poking through the fly of his pants.  The bright-red, smooth tip stands out between your legs, riding up your womanhood admiringly.  It lacks the mushroom-shaped  crown of human men and, instead, his cock is pointed and tapered, much like the weapons he prefers.  You can also feel a subtle, but noticeable canine bulb at the base throbbing against your sensitive loins.\n\n", false);

	outputText("When Raphael notices your attention, the time seems right for one of his one-liners.  'Do not fear the blade', 'look how the length stands firm upon the hilt', a lecture on the art of parrying, or the like is not forthcoming, however.  The fox says nothing instead and merely smiles knowingly at you from the side, knowing silent action is enough.  With his one remaining free arm, he claws around the silk of your womanhood and does indeed part the subtle opening of your interlapping folds. For a moment you gasp as his hot, slick cock falls freely into the denuded skin of your quaking " + player.vaginaDescript(0) + ".  It shouldn't come as a surprise that he knows of the secret opening in the clothes: he gifted them to you after all, perhaps planning it all along.\n\n", false); 

	outputText("You tremble as Raphael shifts back, angles his cock into the furrow of your womanhood and takes your moist opening in a single inward incursion.  ", false);
	player.cuntChange(12,true);
	outputText("After that he slowly begins to oscillate into you.  You're turned into a wreck as you hold on for dear life, feeling the russet rogue enter you repeatedly.  His paw continues to trace around your body to tease your tits or bother your lovebud.  Your one remaining foot has long since begun to buckle under the repeated bumps against your g-spot.  Raphael does not have an impressive girth, but he uses it well in rapid plunges into your yielding loins.  He often changes his angle, until not an inch of your loosening walls have been deprived of an pleasurable inner invasion, as he brushes into your walls with deep lunges.\n\n", false);

	outputText("Finally, you can bear it no more with his hot breath across your neck.  Your body convulses limply around his upright impalement, the fox still standing tall and firm.  You try to close your leg or slip down his body, but with two firm hands Raphael holds you in climactic embrace like captured prey.  Only after you howl and rock your hips forth to the involuntary rhythm of orgasm does Raphael allow you to drop to the moss. The dew-dappled meadows feel like salvation, but little do you know that it does not end there.\n\n", false);
	
	outputText("With a victorious glint, Raphael rolls you on your back while you're still dazed.  The fox, taking the sash from his hips and tying either end around your knees, brings your legs towards your chest.  He holds them there without any effort on the part of either of you, by putting his chest down on the cloth tied between them and mounting you again, lying on top of you.  More deep thrusts follow, this time deep enough for the tip to titilate even your cervix, while the slender knot at his base parts the sensitive entrance a little wider with every bottoming bump into you.\n\n", false);

	outputText("It is how you spend the rest of that morning, filled a thousands times over and constantly driven past the edge of orgasmic bliss by the master fencer's trained thrusts.  His civilized smile has long since given way to the mean smirk of a sexual victor driving his victim to the edge of madness.", false);
	player.orgasm();
	doNext(postRaphaelCoitus);

}

private function postRaphaelCoitus():void {
	clearOutput();
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00149] = 1;
	outputText("When you wake up on a bed of soft moss, Raphael has disappeared completely.\n\n", false); 

	//({When player had reached the SPE fencing apex}
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] == 4) {
		outputText("The only thing left behind is his rapier, sticking out of the moss.  He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you.\n\n", false);
		//[Weapon: Rapier. Speed, instead of strength, influences the damage rating. Never as strong as the heavier weapons or sword, but works great with speed & evasion, encouraged by the rapier.])
		inventory.takeItem(weapons.RRAPIER, playerMenu);
		if (player.findPerk(PerkLib.RapierTraining) < 0) player.createPerk(PerkLib.RapierTraining,0,0,0,0);
		outputText("(Gained Perk: Rapier Training!)\n\n");
	}
	//({When player has reached the INT Conversation apex} 
	if (flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] == 4) {
		outputText("However, you realize he's left you with more than just pleasant memories of sitting with him around the picnic.  Realizing how skillfully you declined him and how deftly you led him around, you realize you may have mastered his art of keeping another's attention and leading them around with cunning and acting.  This misdirection could have great applications in battle.\n\n", false);
		//Optional Perk: Misdirection. Intelligence adds to the chance to evade. Turns you into a true rogue together with the bodysuit.])
		if (player.findPerk(PerkLib.Misdirection) < 0) player.createPerk(PerkLib.Misdirection,0,0,0,0);
	}
	outputText("You return to camp, having cleaned up the picnic and taking the rations that were left with you.  You can't help but wonder if you'll ever see him again though.\n\n", false);
	//[Removes Raph from the game. 7 days later, the Quicksilver scene plays out.]
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 7;
	//Next button if not taking Rapier
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] != 4) doNext(playerMenu);
}


//~~~


//{Player chooses no to sex}
private function declinePuttingOutForRogues():void {
	clearOutput();
	outputText("<i>\"No.\"</i> You shake your head, dropping the atonal monosyllable as if it were the last note in a musical play.\n\n", false);

	outputText("The horny fox frowns.  It's like raising an invincible shield between you.  He reaches out towards your face and body, but he cannot touch anymore.\n\n", false); 

	outputText("Some of the magic of the moment is still there in the fine young man leaning over your aroused body.  He could still take you right there and right now and you know you'd probably enjoy it too.  However, it would be unseemly.  It would be to rape an equal and to Raphael, that would deprive him too of the dignity he tries so hard to maintain.  You can tell it from his face; the agonized quandary.\n\n", false); 

	outputText("When he gets off your body, you've won.  You've caught Raphael in his own game.  You've led him around.  He'd probably do anything for it, but cannot obtain it.\n\n", false); 

	outputText("<i>\"Fine,\"</i> he mumbles.  He rolls off and sits sulking a few paces away from you.  It's the first time the young man fails to keep a cheerful attitude.\n\n", false);

	outputText("You smile, a bit sorry for the way you broke him, but you try to convince him that he shouldn't mope.  The two of you had fun.  It's getting late and you occupy yourself with cleaning up the picnic.\n\n", false);

	outputText("After a small while, the fox finally speaks.  <i>\"It seems like there isn't anything more I can teach you,\"</i> the fox claims.  <i>\"... I'm proud of you, my greatest student.\"</i>\n\n", false);
	
	outputText("You turn around to smile at him.  However, Raphael has vanished.\n\n", false);

	//({When player had reached the SPE fencing apex}
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] == 4) {
		outputText("The only thing left behind is his rapier, sticking out of the moss. He's bound it with his red sash around the length like a ribbon, like he has now gifted it to you. Perhaps it is his way of congratulating you.\n\n", false);
		//[Weapon: Rapier. Speed, instead of strength, influences the damage rating. Never as strong as the heavier weapons or sword, but works great with speed & evasion, encouraged by the rapier.])
		inventory.takeItem(weapons.RRAPIER, playerMenu);
		player.createPerk(PerkLib.RapierTraining,0,0,0,0);
		outputText("(Gained Perk: Rapier Training!)\n\n");

	}
	//({When player has reached the INT Conversation apex}
	if (flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] == 4) {
		outputText("You realize he's left you with more than just pleasant memories of sitting with him around the picnic, though. Realizing how skillfully you declined him and how deftly you led him around, you realize you may have mastered his art of keeping another's attention and leading them around with cunning and acting. This misdirection could have great applications in battle.\n\n", false);
		//[Optional Perk: Misdirection. Intelligence adds to the chance to evade. Turns you into a true rogue together with the bodysuit.])
		player.createPerk(PerkLib.Misdirection,0,0,0,0);

	}
	
	outputText("You return to camp, having cleaned up the picnic and taking the rations that were left with you.  You can't help but wonder if you'll ever see him again.\n\n", false); 

	//[Removes Raph from the game. 7 days later, the Quicksilver scene plays out.]
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 7;
	flags[kFLAGS.REJECTED_RAPHAEL] = 1;
	//Next button if not looting!
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] != 4) doNext(playerMenu);
}

//{Player chooses [Thieving] while in the picnic}
private function RaphaelPicnicChooseThieving(newl:Boolean = true):void {
	if (newl == true) clearOutput();
	//(Introduction; plays out only once)
	if (flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] == 0) {
		outputText("Faced by the 'world-renowned Russet Rogue' - self proclaimed though he may be - your mind fills itself with questions as you try to come up with topics of conversation.  The flamboyant fox must lead an interesting life; one made only more infamous by superstitious folktale and colorful exaggerations.  You intend to get to the bottom of it however!  You lean slightly forward and ask Raphael if everything they say about rogues is true.\n\n", false);
		
		outputText("<i>\"Certainly not!\"</i>  The fox grins.  <i>\"People often underestimate how tiring proper lovemaking is.  I restrict myself to a mere tryst a day.  No more, often less.  You ladies would be the death of me otherwise.\"</i>\n\n", false);

		outputText("When you ask him what he's doing now, the fox nods at you subtly and swerves his tail about in delight.  <i>\"Other than that, I sold my grandmother out for a good price - I know how to bargain - and I nicked these boots off a perfectly healthy man and their size does not correlate with certain other attributes I possess.  A rogue like me relies on a...\"</i> here he winks, <i>\"...silver tongue and  magic fingers.\"</i>\n\n", false);

		outputText("You smile.  He's pretty cute for a pickpocket.  When he rests himself upon one hip, left hand draped across an upturned knee to show off the gentle slope of his curving torso, the young fox is handsome too in his calm elegance.  He might not be the broadest guy around, but the wide cheeks of his angular face are the same as the rest of his body: elegantly masculine and handsomely shaped.  His narrow waist makes his fine chest and strong hips stand out enticingly.  He's still eyeing you up as though ready to apply that healthy frame upon you, should you let him.  You glimpse once at the strained bulge in his pants while returning the look.  Is he attracted to you?\n\n", false); 

		outputText("<i>\"What else would you like revealed?\"</i> Raphael quips suggestively, smiling.\n\n", false);
		//{Leads to [Thieving] scenes subjects to PC stats.} 
	}
	//{[Thieving], intelligence (Less than 30): Must play out at least once.} 
	if (player.inte < 30 || flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] == 0) {
		outputText("<i>\"How do pickpockets do it?\"</i> you blurt out bashfully; the first thing coming to mind is how it's possible for them to reach into pockets without the victims even sensing it.\n\n", false); 

		outputText("When you pick up a nearby sparerib and nibble upon it, you notice how Raphael isn't partaking.  He merely stares at you, resting on his hip and with both hands on the blanket.  The triangular ears on the sides of his cuneate head perk up like that of a patient predator's.  Raphael's tail flicks about like the tip of a paintbrush, swept by a balmy breeze.  Whenever he raises it, a subtle draft of Raphael's fragrant male musk mingles with the sweet scent of meadow bloom.\n\n", false);

		outputText("You blush when you stare back into those vibrant green eyes, set as they are besides a sharp red nose and with the vivid orange jowls running down below it.  A delicate beige shade colors his lower jaw and runs all the way through across the underside of his body, down his body's neck, chest, stomach, hips and shapely crotch, contrasting sharply with the flawless fire of his crimson coat.  All of it punctuates the brilliant emerald of his deep irises.  They have flecks of jade and shades of dark within them.  They sparkle and shimmer, as though desiring something of you.  It's quite hard to resist.\n\n", false);

		outputText("When you ask him what's the matter, Raphael merely blinks and smiles genuinely.  <i>\"Only now do I notice, just how sexy you are.\"</i> He manages a surprising amount of baritone for a voice as young as his.\n\n", false);

		outputText("You try to crack a smile and disavow it, but you can't seem to move a muscle.  You can't even blink and are trapped helplessly within Raphael's gaze.  His voice has begun to mesmerize you, carrying you off in the ebb and flow of its soft tremor.  As his lips move, you don't even hear what he's saying.  When he lowers his voice, you lean in closer to enjoy the playful whimsy of his accent on the end of every of his sentences.  After a while, the depth of his eyes become your only world, his perfumed musk your only air, the soft bristle of his hairs across your bare breasts the only thing you feel.  When Raphael stops talking, you just focus on his low erotic growls while nestling within his warm fur, to be swept by the swirl of his lush tongue around yours.\n\n", false);
		
		outputText("When you hear Raphael pull on your zipper, you snap out of the daze and find yourself in a precarious position.  Apparently you climbed on top of the fox without realizing it and are in the midst of a passionate kiss.  He's massaging your breast with one soft, furry hand, while using the other on the zipper in an attempt to disrobe you.  You detach yourself with a startled cry, before shimmying awkwardly off his body.  You can't believe you just threw yourself at him!\n\n", false);

		outputText("Raphael himself remains amicable and relents, leaning back on crossed arms and with a pleased smile, as though signifying it was all you.  <i>\"And that is what they call distraction. Notice how you didn't even realize until the last moment I had my hands on your body?\"</i> Raphael states academically.  He lets you recover, but keeps a careful eye on you like a considerate lover.  <i>\"That's how a proper pickpocket operates.\"</i>\n\n", false);

		outputText("You respond with a embarrassed \"<i>uh-huh</i>\" as you turn your back to the fox and shield your breasts. The taste of his saliva is still on your tongue, surprisingly sweet. You would have protested, if you hadn't asked for a demonstration of his skills earlier.\n\n", false);
		dynStats("str", -1,"tou", -1, "int", 3, "sen", 1, "lus", 40);
		flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] = 1;
	}
	//{Picnic Thieving 30-39 Int. Must play out at least once.}
	else if (player.inte < 39 || flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] == 1) {
		outputText("<i>\"Are rogues born to be what they are?\"</i> you ask him curiously.\n\n", false); 

		outputText("The fox, pouring you another glass of wine, laughs.  <i>\"Depends on the rogue.  I myself was definitely born with a gift, a pernicious scamp even as a toddler.  I would steal kisses, woo my aunties, and swipe small baubles before I even learned to walk.\"</i>  The fox smiles glib and leans back.  <i>\"Yes, I'm afraid I was destined for this line of work.  When you think about it, you can no more blame me for stealing and being a ladies' man than you could the sun for rising or a wolf for eating meat or reeking foul. Locking me up would surely be a crime against nature.\"</i>\n\n", false);

		outputText("When you ask him if it is a thing you could learn, he looks at you with piqued interest.  <i>\"Now, the rapier.  That is true skill learned.  Actually being a rogue, however?\"</i>  The fox rubs the white streak across his chin.  <i>\"Can a feel for the theatrical, mastering another's attention and making skillful love to a woman, be learned?  I suppose, with the right student...\"</i>\n\n", false);

		outputText("When you ask him whether it is something he could teach, Raphael grins like he saw it coming.  <i>\"Well, I suppose, but for your lessons in womanly lovemaking I'd need to be there with you two ladies to guide your progress.  Perhaps even involve myself when it is absolutely called for.\"</i>  The fox shrugs coyly.  <i>\"Such are sacrifices I'd be willing to make if you insist though.\"</i>\n\n", false);

		outputText("When you snicker and point out that's not what you meant, Raphael winks.  <i>\"You mean on men like me?  Oh but my jewel of the night's sky, I do not know if I'd have the heart to create such a potent combination of wiles and beauty.  To teach one such as you the art of seduction would be to hand the suns and stars a magnifying glass.  Every man you'd met would be smitten.  You'd be able to seduce your way into the courts of kings and the chambers of emperors, to sunder countries and topple empires.\"</i>\n\n", false);

		outputText("The fox leans forwards, staring deeply into your eyes while waving his russet tail about.  <i>\"Mademoiselle, your beauty alone is more than the world can bear.  Surely, a goddess like you does not need deception to bring mere mortal men like I to their knees.\"</i>  He whispers and growls softly, almost forcing you to lean closer to him in turn.  He has begun to softly drown you in his expressive green eyes and the faint musk drifting off his body.  However, the moment you think about it and realize these things to be a deliberate ploy, you snap out of it.\n\n", false); 

		outputText("<i>\"Moves like the ones you're employing right now?\"</i> you ask the fox cunningly.  Raphael smiles like you caught him, but after flashing you his flawless white teeth through the curl of his lips, simply continues.\n\n", false); 

		outputText("You begin a conversation that hardly matters compared to what you're actually doing.  Something about body language, zones of comfort and distracting others with things they want to see, but it isn't as important as the way you say them.  You have begun to lower your voice as well, drawling it to be a little hoarser, forcing Raphael to lean in closer as well.  The fox, getting off his hip, has positioned himself playfully on hands and knees.\n\n", false);

		outputText("Beneath you, a game of chess has started on the blanket's checkered surface.  The baskets, eating utensils, plates, wine and glasses have become your pieces.  You'd swear that Raphael is cheating in your game of drawing each other's faces closer by creeping towards you with the entirety of his body, but you're hard pressed to find proof as he doesn't appear to make any headway.  The salt and pepper shaker are still the exact same distance away from his knees as they were a minute ago - exactly two spaces - though the shakers themselves have appeared to draw closer to you instead.  You figure it out when you blink and spot him moving the pieces about the board with tail and hands, while distracting you and keeping you oblivious to the fact.  It's a delicate game.  If you'd stop talking right now you could easily point it out to him, but the fox uses his eyes, voice and swishing tail to prevent you from concerning yourself with the nearly unnoticeable.  You wouldn't want to stop the game either; the first one to break the mood loses for a lack of grace and subtlety.\n\n", false);

		outputText("Two can play at the game, however.  Letting out a feminine giggle, putting up a charming smile, you inch backwards and angle your bosom forwards.  You wink at him and present the fox with a clear flash of your cleavage, before taking the sight away again by turning bashfully.  A few surprised, half-erotic coos later, alternated by a meaningful groan, and you're certain you've caught on.  Raphael continues to peer directly into your eyes, but you can almost feel him strain not to look down.  That he accidentally knocks over a bowl of sugar instead of deftly misplacing it, is a telling sign.  Using the fresh baguettes nearby, you begin to build a little fort of fresh bread around you, in an effort to halt him at your gates while leading his attention away from doing just that.\n\n", false);

		outputText("In the end, you're still too caught up in playing the game, instead of winning it however, like Raphael is.  The fun you're having with this game of distraction, has ironically, distracted you too much to see it coming.  Suddenly Raphael has his lips on top of yours, having scaled your walls of dough. Instantly the surreal little game you were caught up in and all the enjoyment you derived from it vanishes, to be replaced with the fox's passionate snout pressed into yours.  It is a climax as you roll out your tongue and entwine it with his, to work off the previous energies into an altogether different game.\n\n", false);
		
		outputText("<i>\"Not bad!\"</i> The fox states as he disconnects.  <i>\"But you're missing the point, señorita.\"</i> he comments, pleased.  <i>\"Although this was fine practice, it is not a game about winning.  It is not a game about foiling the other side, your mark.  This is a game... of togetherness, of both believing you can reach the state you desire, even though your goals may not be alike. It is about illusion. About gliding across fields of forbidding energies and secret desires.\"</i>\n\n", false);

		outputText("When you ask him what he means, Raphael merely winks.  <i>\"You've come this far, I'm sure you'll figure it out. A proper rogue knows it by heart.\"</i>\n\n", false);
		dynStats("str", -1,"tou", -1, "int", 3, "sen", 1, "lus", 40);
		flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] = 2;
	}
	//{Picnic Thieving at 40-49 Int. Must play out at least once.}
	else if (player.inte < 39 || flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] == 2) {
		outputText("<i>\"Are you always this much of a charmer?\"</i> you wonder about Raphael, and how he always manages to keep his cool.\n\n", false);
		outputText("He draws a weary smile, not completely disheartened.  <i>\"It is my natural state of being... though I must confess; it takes effort to stay on top of my game.\"</i>\n\n", false);

		outputText("When you ask him what he does for relaxation, the rogue raises his shoulders.  <i>\"Being less than on the very top of my game.  An audience will never know the difference however.  Working the crowds is vital.\"</i>  When you ask him if that includes you, he merely grins.\n\n", false);

		outputText("You try to imagine Raphael in a more homely situation while reaching for a croissant, but struggle to do so.  Is there any time of day he's actually alone?  Crashing after a long day of hopping up on walls, wooing women and pilfering pouches?  You'd like to think there is, a time where the fox is simply tired somewhere, lying on a green sofa in a dark room on a lazy afternoon, taking care of his own needs instead of what others think about him.  You'd wonder what it would be like to hang around him then.\n\n", false);

		outputText("From the corner of your eye, you see the fox approach again, a familiar, playful glimmer in his eyes.  When he tries to put on airs however and do his little thing, you suddenly realize that your earlier musings have robbed him of all such charm.  He has become too human to take what only can be an act seriously.  With a half eaten croissant sticking out of your mouth in an unflattering way, you look upon his moves with luke-warm appraise.  His methods have become humorous, too strained, when you don't take them seriously.\n\n", false); 

		outputText("Suddenly you realize what he meant with a game of togetherness. There is none when a rogue doesn't manage to engross his mark.  They're all just details now: his fine clothes, sweeping tail, deep eyes and playful smile.  With his voice he forms the sentences, but as he holds his little speech you catch onto a dozen little fibs and half truths to exaggerate your beauty.  They're endearing and you'd almost fall for them, but maintaining a hold on your mind and analyzing it all ethologically leaves it with no hold over you.  You've finally mastered the game, it seems, instead of the other way around.\n\n", false);

		outputText("To humor Raphael, you let him get in close to you, returning his leer with a glazed stare.  This time you're perfectly aware of his desire to taste of your lips - or rather, nip from your croissant - and you simply crawl backwards to let the few remaining inches between you and him persist.  But you can't help but break from your apathetic posture when Raphael puts his paw on a tray of picnic butter and slips.\n\n", false);

		outputText("Suddenly the once-so-dashing and stately young man plummets to the blanket, taking more than a few platters with him on his fall. When the clouds of powdered sugar subside, Raphael has made a fool of himself. His long body lies outstretched on top the ruined arrangement, soiled in smears of butter to which pepper and sugar cling. He's covered in strips of bacon. When he lifts the one across his eyelids up to peer from under it, you hold your hands to your mouth in surprise and struggle not to giggle at him, embarrassing him further.\n\n", false);

		outputText("Raphael however, doesn't get angry at himself.  The young prince of thieves isn't embarrassed and doesn't even try to desperately correct himself.  He simply smiles, rolls slowly onto his back before your eyes and carries through the performance.  He crooks his limbs above his prostrate body, curls his tail between his legs and acts like a young dog who has just made a mess, staring at you from upside down position with well-humoured puppy dog eyes.\n\n", false); 

		outputText("You crack up and laugh openly at his antics.  Suddenly, you don't have as hard a time imagining Raphael relaxing.\n\n", false);
		dynStats("str", -1,"tou", -1, "int", 3, "sen", 1, "lus", 20);
		flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] = 3;
	}
	//{Int Thieving Apex Warning: When the PC's intelligence is at 50 or higher.}
	else {
		outputText("You've gotten used to dealing with the rogue, at least in respects to witty repartee and jousts of flirting.  You disregard the exuberant display of food between you, as you size up your opponent.  His rapier is lying exactly between the two of you, even though steel has not been the weapon you've engaged him with last.\n\n", false);

		outputText("The fox is doing the exact same thing. It seems that the longer you have spent time with him, the broader that fine, sharp, attractive head of his has become.  In the same light, you also notice how there's something different about him today.  He has the same playful smile, but while he lies on his side leaning on a single elbow, he also has a patient, determined look about him.  When he scoops up a bottle of wine and wields it like a phallic symbol pouring you another glass, there's an imposing quality about him that you thought he lost earlier.\n\n", false);

		outputText("<i>\"Ready for another chat, mademoiselle?\"</i> he drawls lusciously.\n\n", false); 

		outputText("You realize that he's preparing for the long haul.  You might not get off quite as easily as earlier, should you decide to flirt with him again.\n\n", false);

		outputText("It occurs to you to change the subject to that of the rapier at his side but you are equally drawn to engaging the fox and satisfying your... curiosity.\n\n", false);
		
		outputText("What do you do?", false);
		flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] = 4;
		//[Fencing] [Flirt]
		//[Fencing] {Leads to Fencing Variables}
		//[Flirt] Leads towards the final Int Sex scene. 
		simpleChoices("Fencing", RaphaelPicnicSkill, "Flirt", thieveryEnding, "", null, "", null, "", null);
		return;
	}
	doNext(playerMenu);
}

//{High Int picnic ending}
private function thieveryEnding():void {
	clearOutput();
	outputText("It's a beautiful morning out on the meadows.  The rising sun shines brightly and casts radiant beams of golden light across the clearing.  Dandelion seeds, flower petals and feathers drift by on a strong, but balmy breeze that falls pleasantly across the skin.  The air currents are dry, and amplify both smells and sounds.  On the foregrounds of this brilliant backdrop, Raphael lies on his side with the sun rising in his back.  The warm gusts and luminescent hue appear to set Raphael on fire.  His radiant fur gleams in the sun and dances in the wind.  The fine long hairs of it turn into delicate golden threads near the ends and run off endlessly into the ambient light.  Perhaps he's the trickster that makes the airborne delight flutter by and the hot sun shine today?  The fox himself however is the perfect picture of belonging, at peace within the setting.  He has the top two buttons of his jacket unfastened, allowing the white fur on his chest to spill out in a manly way, only adding to the display.\n\n", false); 

	outputText("Raphael himself remains silent.  There is no need to move as he looks upon you with a dreamy glaze in his eyes, sideways from his pointed snout.  He's enjoying his sunbath.\n\n", false);
	
	outputText("You break the silence by finally asking him what he wanted to talk about.  When you do, Raphael rises up timelessly slow, like a rousing sungod.  When he puts the sun in his back and loses the orange sheen across his fur, he turns back into the playful red scoundrel.  <i>\"I have never met a woman... quite like you, " + player.short + ",\"</i> he drawls.\n\n", false);

	outputText("Suddenly it appears the entire world rides upon his words towards you.  Not just the fox and the picnic, but the sun, sky and wind too, flow in your direction.  Just before the feeling overwhelms you, you snap out of it and turn your attention towards what the fox is doing.  Like always, he carefully starts to draw closer like some patient predator, brushing across the checkered blanket and past the picnic pieces.  You've grown wise enough to know of his ways and dismantle him.  However, when you look around and realize how much work he's put into arranging this, you don't have the heart to do so.  Perhaps that's what the fox meant by a game of two?\n\n", false); 

	outputText("You make the snap decision to simply indulge him and enjoy yourself.  When the fox is nearly upon you however, you realize how hard it is to do that without losing your mind to his sensual advances.  You go with the flow and seemingly relinquish control, but hold tentatively onto your senses and make sure not to get swept away.  Perhaps within the current, opportunities will present themselves.\n\n", false); 

	outputText("You hold your breath as the rogue closes in on you, putting his face close to yours.  He growls softly at you and you moan back at him, but only after allowing yourself to do so.\n\n", false);

	outputText("When he moves his lips forward you struggle to not meet them and instead, fall gently on your back.  Lying down below him, he concerns himself with the rest of your body first and slides in over you.  You keep a close eye on the fox as he does, letting him know he won't be getting away with any untoward behavior.\n\n", false); 

	outputText("As he kisses you across the leg, the thing you feel most clearly are his whiskers and soft wet nose gliding across your thin silk attire.  He keeps a respectable distance from your groin, skipping past it with a feathery touch.  Instead, his inquisitive snout sniffs past your tummy and " + player.allBreastsDescript() + ".  Meanwhile, you have the opportunity to admire him, his soft fur, his skillful touches and his fine wardrobe.  The sash falls in over your body while the supple brown and red leather gives the graceful body moving in over you a refined quality.  Spending time with him has rubbed off on you.  Only now do you appreciate the value of certain baubles that cling to his leathered threads, thinking like a pickpocket.\n\n", false);

	outputText("A brooch that can only be described as priceless decorates the soft silk sash.  ", false);
	//({When player has not reached the apex of fencing lessons/Optional: and also has less than 60 speed}
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] != 4) outputText("You try to reach for the magnificent ornament hanging off his hips, but as the fox continues to move, you lack the nimbleness to remove it.\n\n", false);
	//({When player has also reached the apex of fencing lessons
	else outputText("You reach and fondle the magnificent ornament hanging off his hips. With a few nimble flicks of your fingers, you manage to get it off.\n\n", false);

	outputText("Realizing you've allowed yourself to be distracted, you refocus.  Raphael has his paws on your breasts and is about to kiss the top of them.  Throwing him off, you sigh, brush his hands away while raising your own towards your head.  Like this, you stretch out your upper body across the moss, and cross your hands to signify helplessness.  It presents your " + player.breastDescript(0) + " even more invitingly, but you've elegantly dispersed his efforts.  To touch them again on such short notice would be to flaw his otherwise refined lovemaking.  Instead, the fox crawls in over you completely on hands and knees and looks you in the eyes.  He realizes you're still very much in the game and to take you roughly on the moss instead of sweeping you off your feet would be a thing unbecoming of the refined fox.  He needs your consent to win the game.\n\n", false);

	outputText("You're enjoying yourself and so is Raphael, for as long as you keep the illusion up he might manage to woo his way into your pants.  He's so fragile right now.  You're almost literally holding the horny fox's desires and pride in the palm of your hand.  You are in complete control.\n\n", false);

	outputText("<i>\"I have never before met a woman of your breathtaking insight.  Of such deep beauty.\"</i>  He sighs at you.  <i>\"My lady, I must have you,\"</i> he burrs.\n\n", false);

	outputText("<i>\"Oh my, are you soliciting me, mister fox? Right here in the wilds, crudely upon the moss?\"</i> you answer coyly.  <i>\"Wouldn't that mean I lose the game?\"</i>\n\n", false);

	outputText("<i>\"Some games are meant to be lost.\"</i>  He nuzzles you, putting his snout to your ear.  <i>\"It will be... exquisite.  Lose yourself, in my capable hands.\"</i>\n\n", false);
	outputText("Do you?", false);
	dynStats("lus", 25);
	//Choose: 
	//[Yes] [No]
	doYesNo(RaphaelThieverySmex,declinePuttingOutForRogues);
	//press [Yes] to smart sex
	//[No] leads up to universal rejection scene
}
//{Player chooses Yes to Int sex}
private function RaphaelThieverySmex():void {
	clearOutput();
	outputText("You need no words.  You place your hand on the back of Raphael's neck and pull his lisping tongue closer to your ears.  After that, you lose yourself to the weight of a man atop you as the fox starts tending to your quivering body.\n\n", false);

	outputText("Finally the fragile tension between you breaks.  Raphael undoes your zipper and roughly pulls your bodysuit down, revealing your " + player.allBreastsDescript() + ". You're stunned; the fine, abrasive texture of his nimble fingers' pads run in eager circles across your sensitive neck, from whence moans have begun to flow. His soft fur brushes across your body as the fox moves downwards.  Gingerly, he puts his maw down on your right breast and suckles once, but in the span of an agonizingly long time.  The " + player.nippleDescript(0) + " is sucked into his toothy mouth, which he puts down on the nub carefully.  The little points scrape by sensually, before your nipple slips through them.\n\n", false); 

	outputText("You gasp when he spreads your legs by placing his in between and parting them. When he fondles you down there, fingers rubbing into your flushed  " + player.vaginaDescript(0) + ", you suddenly feel the wind passing through the hot bare inners of your parted folds.  Raphael has opened the silken opening of your suit. It shouldn't come as a shock.  He gifted them after all, perhaps planning for it all along.  Another surprise follows as you can feel something hot and rigid standing off his body and lying on top of yours. Raphael's vulpine cock is resting in the hollow of your bellybutton, through the fly of his pants.  The bright red, smooth tip rides up your tummy admiringly.  It lacks the mushroom shaped dome that human men have and instead, his cock is pointed and tapered, much like the weapons he prefers.  You can also feel a subtle, but noticeable canine bulb at the base, throbbing against your sensitive loins.\n\n", false);

	outputText("When he finally lowers himself, positioning himself in front of your opening, you've already welcomed it.  In the time it took him, the wind's soft breeze has passed through and licked by your exposed cunt for long enough.  By now you long to get penetrated by something more substantial and indeed your wish is granted.  When you feel the tip of Raphael's foxy cock trail down your furrow, it hits the spot and he takes your moist opening in a single inward incursion.  ", false);
	player.cuntChange(12,true);
	outputText("After that he slowly begins to oscillate into you.  You're turned into a wreck as you hold on for dear life, feeling the russet rogue enter you repeatedly.  His paws grope your tits and pester the " + player.nippleDescript(0) + "s by twirling his abrasive hands around them.  With a knowing look upwards, he has also begun to nibble down on your shoulders with his sharp teeth, giving you little lovebites across your neck that make you gasp.  Your body has long since buckled under his luscious fur thanks to the repeated bumps against your g-spot.  Raphael does not have an impressive girth, but he uses it well in rapid plunges into your yielding loins. He often changes his angle, until not an inch of your loosening walls have been deprived of a pleasurable inner indentation, as he brushes into your walls with deep lunges.\n\n", false);

	outputText("Finally, you can bear it no more.  Your body convulses limply below him, the fox still jamming himself in with consistent rhythm.  You raise your legs and clamp him around his hips as Raphael keeps up the motion, rocking into you like a voracious predator.  Only after you howl and pump your hips to the involuntary rhythm of orgasm does Raphael allow you a breather by sitting up, but his penis is still locked into your " + player.vaginaDescript(0) + ". Little do you guess that it does not end there.\n\n", false);

	outputText("With a victorious glint, the fox takes the sash from his hips and, tying either end around your knees, brings your legs towards your chest. He holds them there without any effort on the part of either of you, by putting his chest down on the cloth tied between them and mounting you again, lying on top of you. More deep thrusts follow, this time deep enough for the tip to titilate even your cervix, while the slender knot at his base parts the sensitive entrance a little wider with every bottoming bump into you.\n\n", false);

	outputText("It is how you spend the rest of that morning, filled a thousands times over and constantly driven past the edge of orgasmic bliss by the master fencer's trained thrusts. His civilized smile has long since given way to the mean smirk of a sexual victor, driving his prey to the edge of madness.", false);

	//~~~ Next page ~~~
	doNext(RaphaelThieverySmexPtII);
}

private function RaphaelThieverySmexPtII():void {
	clearOutput();
	outputText("When you wake up on a bed of soft moss, Raphael has disappeared completely.\n\n", false);

	//({When player had reached the SPE fencing apex} 
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] == 4) {
		outputText("The only thing left behind is his rapier, sticking out of the moss.  He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you.\n\n", false);
		//[Weapon: Rapier. Speed, instead of strength, influences the damage rating. Never as strong as the heavier weapons or sword, but works great with speed & evasion, encouraged by the rapier.])
		inventory.takeItem(weapons.RRAPIER, playerMenu);
		player.createPerk(PerkLib.RapierTraining,0,0,0,0);
		outputText("(Gained Perk: Rapier Training!)\n\n");
	}
	//({When player has reached the INT Conversation apex}
	if (flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING] == 4) {
		outputText("However, you realize he's left you with more than just pleasant memories of sitting with him around the picnic.  Realizing how skillfully you declined him and how deftly you led him around, you realize you may have mastered his art of keeping another's attention and leading them around with cunning and acting.  This misdirection could have great applications in battle.\n\n", false);
		//[Optional Perk: Misdirection. Intelligence adds to the chance to evade. Turns you into a true rogue together with the bodysuit.])
		player.createPerk(PerkLib.Misdirection,0,0,0,0);
		outputText("(Gained Perk: Misdirection!)\n\n");
	}
	outputText("You return to camp, having cleaned up the picnic and taking the rations that were left with you. You can't help but wonder if you'll ever see him again though.", false);

	//[Removes Raphael from game. In 7 days, the quicksilver scene plays out]
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 7;
	//If not taking item, go next.
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] != 4) doNext(playerMenu);
}


//OH SHIT ENDGAME SHIT HERE SONS!
//[Quicksilver scene]
private function quiksilverFawkesEndGame():void {
	clearOutput();
	outputText("You wake up to the sound of an ominous cry in the distance, like that of a howling wolf.  It can only mean trouble and you jump out of bed.\n\n", false);

	outputText("It is an eerily misty morning outside, with banks of fog covering your campsite.  It only makes the second howl more haunting as the danger appears to draw closer to camp.  You stand still and prepare yourself to face this menace, peering into the fog.  When a shadow creeps closer, you prime for combat.  However, its posture suggests it is weary and tired, slumping against a tree. When it struggles forward, it almost comes falling out of the curtaining mist.  It is only then that you notice the redness of its fur and the fineness of its clothes.  It is the fox and russet rogue, Raphael!\n\n", false);

	outputText("<i>\"Please, you must help me!\"</i> he begs of you.  <i>\"They're trying to frame me!  I'm innocent!\"</i>\n\n", false);

	//({If player rejected him earlier}
	if (flags[kFLAGS.REJECTED_RAPHAEL] == 1) {
		outputText("You're immediately confused and you ask him what's going on, but the fox is out of breath.  What's more, a similar howl now calls out from the opposite direction too!  Whatever these sounds are or this fog is, they have the camp surrounded!\n\n", false);
	}
	//({If player had an INT or SPE ending with him earlier}
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00149] == 1) {
		outputText("You're a bit miffed at the fox.  You haven't heard from him for more than a week after he slept with you, and now he only shows up because he's looking for help.  The fox however, is out of breath.  What's more; a similar howl now calls out from the opposite direction too!  Whatever these sounds are or this fog is, they have the camp surrounded!\n\n", false); 
	}
	
	outputText("<i>\"They hound me night and day!  I can't outrun them any longer!\"</i> he wheezes.  <i>\"Please!  You don't know what they'll do to me when they catch me!\"</i>\n\n", false);

	outputText("You don't have the chance to respond before the sounds of snapping branches and rustling leaves near camp.  Raphael jumps up and dives into the barrel you keep in camp for the storage of water, hiding himself and leaving you to face the oncoming threats by yourself.\n\n", false);

	outputText("In the hazy distance, you spot a massive shadow rushing through the mist and it dissapears before you get a good look.  An eerie silence follows and you sharpen your eyes and hearing to the danger.  When you look up, your heart sinks as the massive shape has jumped up and now descends on you from above.  It happens so fast that you barely realize what's going on.  Before you know it, you're sent sliding across the floor with the dark shape on top of you, pinning you down to the ground with its weight.\n\n", false); 

	outputText("<i>\"Smelled of elderberries, huh?\"</i> it snarls.  <i>\"And what was that about my mother?\"</i> When you open your eyes again, you're greeted by a row of razor-sharp white teeth, set in a pitch-black face. Above them, two smoldering yellow eyes stare down on you, infuriated.\n\n", false);

	outputText("<i>\"Hati!\"</i> an identical voice calls out from elsewhere.\n\n", false);

	outputText("Suddenly, the teeth above you vanish and the eyes grow soft and surprised.  <i>\"Oh!\"</i> the shadow exclaims, its expression apologetic and startled.\n\n", false);

	outputText("It removes itself from atop your body.  After having the breath knocked out of you, you take a moment to recover it and finally manage to get back up and meet the two monsters of the mist.", false); 

	//~Next Page~
	doNext(QuiksilverFawkesPtII);
}

private function QuiksilverFawkesPtII():void {
	clearOutput();
	outputText("As expected by their howls, they're a pair of wolves! In fact, they're nearly identical. Twin wolves, then. The only way to tell them apart is by noticing how the one who jumped you carries an apologetic expression, while the other one has a solemn, serious frown.  They walk about on hind legs like drifting shadows.  Their coats are of a beautiful dark-silver tinge that grows black in the darkness and argent in the light.  In these mists, they're both: a flowing quicksilver.  The twins both have large bushy tails.  Maybe not as bushy or large as Raphael's, but the two of them still strongly remind you of the stately fox.  The wolves however, hunch. They are also quite a bit bigger, although it's a fact not immediately apparent.  Low on their feet, they keep their noses closer to the ground.  Their upper bodies are broad and strong, and their claws sharp and hind legs agile.  Unlike the fox, they're also completely nude, although their genitals swing obscured between their stalking legs.  The only thing that covers them is a fine mane of rough, disheveled hair across their backs. They're raw and savage.\n\n", false); 

	outputText("You jump up when one of them nudges his nose into your ass and sniffs you.\n\n", false); 

	outputText("<i>\"Hati,\"</i> the other one comments again.  <i>\"Manners.\"</i> Standing upright with arms crossed instead of his nose to the ground, the wolf strikes an imposing figure.  They're actually quite tall, with their rippling chests proudly presented above toned abs and narrow hips that run smoothly through to their legs.  Despite that, they also have a reliable, trustworthy quality to their predatory features.  Their furs look warm and regal.  The one now looking down on you seems very patient and polite for such a wild creature.\n\n", false); 

	outputText("<i>\"Tel'Adre law enforcement, " + player.mf("sir", "ma'am") + ".  Special Division.  Outer wall Task Force,\"</i> he announces while the other wolf circles camp.  <i>\"I am Frank 'Skoll' Holmes and this is my partner, Joe 'Hati' Watson.  We're the 'Quicksilver' brothers, also known as the 'Boys from Baskerville' by the locals.\"</i>  Skoll achieves this introduction with a soft voice that barks and growls itself through the words. You nod, still a bit taken aback.\n\n", false);

	outputText("<i>\"We're tracking down a fugitive, a red fox.  Urta's orders,\"</i> he explains.  <i>\"Goes by the name of Raphael. Raphael Fagin Soleil. Don't suppose you've seen him?\"</i>  He stares at you with inquisitive yellow eyes beneath broad brows that give him a permanent serious frown.\n\n", false);

	outputText("When you ask him what crimes Raphael has committed, the wolf shakes his head.  <i>\"Debauchery.\"</i>  You raise one eyebrow, surprised that debauchery could be a crime in a place like Mareth.\n\n", false);

	outputText("<i>\"Must have gone on a real romp, that one,\"</i> you quip.\n\n", false);

	outputText("Skoll responds, amused.  <i>\"We need to set standards for ourselves and he crossed them.  It's how we separate ourselves from the demons.  Petty theft, highway robbery, and breaking and entering are counted amongst his other crimes.  Not that their severity should matter to the course of our investigation.\"</i>\n\n", false);

	//({If player removed him earlier}
	if (flags[kFLAGS.REJECTED_RAPHAEL] == 1) outputText("<i>\"I can smell traces of him,\"</i> Hati states, nearing the waterbarrel, <i>\"but it's hard to tell.  There're too many other scents here.\"</i>\n\n", false);
	//Played around/special ending
	else outputText("Hati breaks into the conversation.  <i>\"She must know.  The entire camp reeks of him. She has his scent on her.  I can smell strong trails leading towards a nearby meadow.  A bit stale.  Might have been a while ago.\"</i>  He nears the water barrel.  <i>\"...but it's hard to tell. There's too many other scents here.\"</i>\n\n", false);
	
	outputText("Your heart jumps as Hati manages to discover a pile of Raphael's clothes, near the barrel.  It's irrefutable proof.  Raphael must have put them there to throw the wolves off.  Hati gives you a look of dissapointment.  <i>\"He's nude. They must have slept together.\"</i>", false);
	//({If player is wearing red bodysuit}
	if (player.armorName == "red, high-society bodysuit") outputText("  Suddenly, his eyes and ears perk.  <i>\"Isn't that the stolen clothing of the widow Camembert that she's wearing? You know, before she mysteriously dropped the charges after a nightly visit from the fox? Should we confiscate it anyway?\"</i>", false);
	outputText("\n\n", false);

	outputText("<i>\"Come now, Hati. No need to concern ourselves with that,\"</i> Skoll reproves.  <i>\"I'm sure we can rely on our upstanding citizens not to actively harbor a criminal.\"</i>  He looms in over you.\n\n", false);

	outputText("The knowledge that you're not technically a citizen does nothing to alleviate the most intimidating sensation of the large wolf standing in so close to you.  He smells of the night.  However, when you look him in his eyes, intimidation does not seem to be Skoll's intent.  Instead, he has a compassionate look in his eyes, enriched with years of wisdom.  He's trying to appeal to your moral sense.  <i>\"We know of the fox's ways.  We'd understand if he might have appeared dashing and handsome at first.\"</i>  He leers deeply into your soul.  <i>\"Now, I must ask again. Have you seen him?\"</i>\n\n", false);

	outputText("You glance at your waterbarrel.  Hati is keeping an obsessive watch over the water's surface, like he's already closed in on the fox.\n\n", false); 

	outputText("You could sell Raphael out, or you could cover for him.  What do you do?", false);

	//[Cover] [Sell out] 
	simpleChoices("Cover", coverForRaphael, "Sell Out", betrayRaphael, "", null, "", null, "", null);
}

//{PC chooses to cover for Raphael}
private function coverForRaphael():void {
	clearOutput();
	outputText("You stare back into the wolf's yellow eyes, keep a stiff back and answer him.  <i>\"I'm not seeing him right now.\"</i>\n\n", false);

	//({Player corruption below 30}
	if (player.cor < 30) outputText("You instantly feel bad for lying to the wolf. More so because he doesn't get troubled, disappointed or vexed.  He seems to instantly believe you... or at least, he wants to believe you, even though being a detective probably keeps him cynical.  You'll only be adding to that cynicism if he discovers your lie.\n\n", false);

	outputText("<i>\"Cute answer,\"</i> his partner remarks, taking a break from staring at the water barrel.\n\n", false);
	outputText("Your hair stands upright when he leans back in over the barrel and appears to look down into the water, but you struggle not to slake a sigh of relief when he merely starts drinking from it instead.  A few long laps with his tongue and the wolf is sent cringing and shaking his head at the taste.  <i>\"Even the water tastes of him.\"</i>\n\n", false);

	outputText("<i>\"Hati, enough!\"</i> The wolf in front of you turns his head, throws back his cuneate ears and snarls at his partner.  <i>\"We're not in the habit of throwing around accusations without material proof.\"</i>  His anger starts to decrease. <i>\"Don't help Raphael turn us into the bad guys.\"</i>  Skoll turns back to you with just as much friendly patience as ever.  <i>\"I'm sure she would have told us if she knew anything about that.\"</i>", false);
	//({If cor is below 30}
	if (player.cor < 30) outputText("  You slowly shake your head, tortured by the trusting twinkle in the wolf's soft yellow eyes.", false); 
	outputText("\n\n", false);

	outputText("<i>\"The trail is strongest over towards the meadows.  He might have gone there.\"</i> Hati remarks after circling your camp one more time.\n\n", false);

	outputText("<i>\"I hope you will let us know when you see him again...\"</i>  Skoll nods at you, his feral features pulling away from you.\n\n", false);

	outputText("Skoll picks up Raphael's clothes.  The two brothers then get on all four of their limbs and speed off into the fog.  Fierce, dangerous beasts they are.\n\n", false);
	//~~~ Next page ~~~
	doNext(coverForRaphaelII);
}

private function coverForRaphaelII():void {
	clearOutput();

	outputText("It doesn't take more than a minute for Raphael to make use of the wolves' departure.  Not even bothering to climb out with dignity, he tips the barrel over as he rushes out of the water.  Like a drowned cat, he climbs out coughing and gasping for air on all fours.\n\n", false); 

	outputText("He hasn't lost his ways however.  The first words out of him are as suave and composed as ever.\n\n", false);

	outputText("<i>\"Merci, mademoiselle,\"</i> he wheezes softly.  <i>\"You have whisked me away from the snatches of great injustice, as well as a fair share of humiliation.  Normally I am capable of outrunning them myself, but it seems that faith has blessed me with a guardian angel on the day I find myself less capable.\"</i>\n\n", false); 

	outputText("You're upset towards him for asking you to lie to law enforcement, but Raphael's current state keeps you from being too furious.  He's not so bushy anymore.  His soaked hair falls flat against his body and causes him to lose quite a bit of his imposing physique. Strands of it run across his face. You spend a little time yelling at him, though.\n\n", false);

	outputText("<i>\"No.  It is nothing like that,\"</i> he splutters, in response to one of your rants.  <i>\"We go way back.  The wolves and Urta, they carry out a personal vendatta against me that has no bearing on the law.\"</i>\n\n", false);

	outputText("You spend some time considering the dubiosity of this revelation.\n\n", false);

	outputText("<i>\"Please, señorita.\"</i>  He manages to rise to one knee.  <i>\"Is this the face of a hardened criminal?\"</i>  He looks up and into your eyes with his own brilliant green ones.  He's still a mess, hair disheveled and his features weather-beaten, but he'll dry up again eventually, to be dashing once again.  <i>\"Since when have I treated you anything less than courteously?  A handful of gems, certainly, yes, but do I deserve such police brutality because of that?  Do I deserve to be hunted down in the forests and carried through the streets in chains?  Just because my antics leave the world with a smile?\"</i>\n\n", false);

	outputText("Before you manage to answer him, Raphael rushes back to his usual spot on the small crumbled wall on the outskirts of the camp proper.  Not as quick as previously, tired and weary perhaps, but still quite fast.  He doesn't seem so intimidating without his clothes on.  Knowing shame, unlike the wolves, the young man even covers his privates with a leg bent sideways.\n\n", false);
	
	outputText("<i>\"Mademoiselle, this day, I owe you a great boon.  The russet rogue never forgets a debt.  Visit Tel'Adre after things die down and look for the orphanage.  You will be welcomed like a queen! Ah-ha!\"</i> he exclaims, before hopping down the wall.\n\n", false);

	outputText("You blink as he fades off into the mist and you're left to absorb the morning's events by yourself.  For a minute you're concerned with the wolves, but at least you've managed to keep Raphael as a friend.  Though, you are curious what he means by 'orphanage'.", false);
	//Concludify things
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = -2;
	doNext(playerMenu);
}
//{PC chooses to betray Raphael}
private function betrayRaphael():void {
	clearOutput();
	outputText("<i>\"The barrel,\"</i> you admit, the answer slipping from your lips in face of the wolf.\n\n", false);
	outputText("Skoll, careful not to bare teeth, curls the corners of his lips and smiles at you.  <i>\"Thank you.\"</i>  He whispers a low growl and his eyes sparkle at you.  <i>\"I realize that might have been hard to do, but we will remember.\"</i>  Leaving you with that promise, he joins the other wolf in staring at the waterbarrel.  You feel guilty, but it's compensated by the feeling you might have gained two allies.\n\n", false); 

	outputText("The two twins look at each other, then grin playfully.  One of them leans in over the barrel and puts his head directly over the water's surface, peering down.\n\n", false);

	outputText("Suddenly, Raphael bursts from the water, no doubt in an effort to escape.  The wolves will have none of it.  One of them puts his paw on the head of the resurfaced fox and pushes him back into the water with just as much force.  Meanwhile, the other wolf fetches the lid and slides it onto the drum. Just before they close the barrel shut, they tip it over to discard the water. By now, Raphael is already banging on the wall from the inside, but his cries are muffled and weary.\n\n", false); 

	outputText("<i>\"Tell it to Urta and the judge,\"</i> one of the wolves announces loudly, causing the other to chuckle.  <i>\"You have the right to remain silent. Anything you say will make us hold something against you, not necessarily in the court of law.\"</i> Sullenly, Raphael quiets down inside the sealed barrel.\n\n", false);

	outputText("Effortlessly, one of the wolves lifts the barrel up onto his shoulder.  Before he carries it off, he throws one more look backwards and beams at you. <i>\"Check in with Urta.  She will reimburse you for the barrel, along with rewarding you with the outstanding bounty on our foxy friend.  Visit even later than that and you might even be allowed to enjoy his sentence.\"</i>\n\n", false);

	outputText("The other spends a little longer regarding you, wagging his tail playfully and smiling a friendly smile at you.  He then looks back and sees his brother heading in the wrong way.  <i>\"We're not heading back to Tel'Adre right away?\"</i>  His voice is almost as low as his brother's.\n\n", false);

	outputText("<i>\"We caught him in record time,\"</i> Skoll remarks.  <i>\"I'm sure Urta won't mind it if we keep him for ourselves for just a day.  You know... collect evidence... interrogate the culprit...\"</i>  His voice is carried off by the mist.\n\n", false); 

	outputText("Hati throws you one more amicable glance before turning, getting on all fours, and running off.\n\n", false);

	outputText("You blink as he fades and you're left to reflect on these morning's events by yourself.  For a minute you're concerned for the fox, but the wolves don't seem like the types to harm him... much.  You are curious what they plan to do with him and what his 'sentence' might be, though.", false); 
	flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = -1;
	//1k gems?
	doNext(playerMenu);
}

//Intro
public function orphanageIntro():void {
	clearOutput();
	if (RaphaelLikes()) {
		if (flags[kFLAGS.TIMES_ORPHANAGED_WITH_RAPHAEL] == 0) {
			outputText("You spend some time around Tel'Adre looking for the orphanage Raphael mentioned, but you can't seem to find a building that looks like one.  Instead you resort to asking the locals, but their reactions are weird. Upstanding citizens, friendly and polite, turn away from you at the merest notion of it.  Young men get excited but dare not speak of it, women blush and turn away like you've just solicited them and, strangest of all, most children have never even heard of it.");
			outputText("\n\nEventually, it takes the beggars and the organ grinders, the guards and the muggers, to tell you of its location.  More than that they do not say as they just grin at you, telling you should 'experience' it for yourself.  Well, the guards don't.  They just tell you to keep your nose clean.");
			outputText("\n\nWhat sparse directions you have guide you to what must be one of the biggest buildings in Tel'adre - aside from the mage's tower.  It looks nothing like an orphanage and more like a fortified stronghold in the bad part of town, situated amongst slums and seedy bars.  It has thick stone walls, a massive oak door and ramparts on top, even though it has a distinctly ramshackle appearance to it.  Beams are sticking out everywhere, replete with pulleys and lengths of rope.  Windows are larger than they need to be and look like they can handle the intake of cargo.  It has something of a warehouse feel to it and it may just have been that, retrofitted into a reinforced bulwark.  For a moment you belief you might have had your leg pulled and that 'the orphanage' is something of a running joke within Tel'Adre.  You're reassured however, when you spot half a dozen little heads sticking out of one of the windows, giggling at you.  When you spot them, the children shoot back inside.");
			outputText("\n\nAt least there are orphans here, or at least children.  One teen even bumps in to you with the full of his body, before walking away in a hurry.  You quickly check your pockets to see if you've just been pickpocketed, but all is still there and you begin to suspect he copped a feel.");
			outputText("\n\nWeary, you concentrate on getting the solid wooden door open.  It has no knocker or handles and you're forced to call for attention.");
			outputText("\n\n\"<i>Hello!</i>\" you call out once, twice, thrice.  A head pops out between the ramparts, takes a quick look at you, before it ducks back inside. You've been noted.");
			outputText("\n\nIt takes a minute, but you smile when you hear the massive wooden door being unlocked.  It took effort, but you're happy you've finally found the place after all that commotion.  When the door opens, however, it's like the square passageway into a completely different dimension.  A bright golden light shines out into the dreary alleyway you're standing in, accompanied by a boisterous cacophony.  You can hardly believe your eyes when you peek inside.  There are burlesque girls dancing in lingerie on a massive stage, young women swing from slings high up in the grand hall's lofts, someone is breathing fire, and ribbons of gold flutter through the sky to reflect the flickering flames of a hundred different braziers.  Animal morphs of all kinds are dancing and talking to each other, wearing beautiful silver masks, and from time to time children run through the partygoers with both hors d'oeuvres and wads of cash.  All the while, an orchestra is playing a jaunty tune to set the mood.");
			outputText("\n\nThat's all you manage to see in the brief two seconds Raphael has the door open, slips out and hastily closes it behind him, muffling all sound and sight from within.");
			outputText("\n\n\"<i>Ah, ma cherie. Finally, you have made it,</i>\" Raphael greets you.  You don't have much to say.  You just stand there dumbstruck over what you just saw.");
			outputText("\n\n\"<i>Orphanage?</i>\" you finally manage to utter and blink.");
			
			outputText("\n\nRaphael grins and tries hard to fake a look of innocence with those rich green eyes.  \"<i>Ah yes, that. We were having a children's party.</i>\"");
			
			outputText("\n\n\"<i>Children's party?</i>\" You blink once more.");
			
			outputText("\n\n\"<i>They're the parents you see.  And the dancing girls?  Well, boys grow up so quickly these days.  How am I to refuse them their badly scrawled birthday lists?</i>\"");
			outputText("\n\n\"<i>Parents?</i>\" you stammer.");
			outputText("\n\n\"<i>I mean, prospective parents of course.  And all right, I admit, the dancing girls are advertisement.</i>\"  He rubs his neck like he's being cornered and swings his arm.  \"<i>I'm really eager to give those tykes a good home!</i>\"");
			
			outputText("\n\n\"<i>Master!</i>\" Another male fox with a similar accent as Raphael's pops his head out from between the upper ramparts.  \"<i>We're ready to start the bidding if you are!</i>\"");
			
			outputText("\n\nAs if stung, Raphael's eyes flash open, he grimaces and waves his hands and shakes his head to do everything in his power to dissuade you from drawing the wrong conclusions.  \"<i>Not like that!</i>\"  This is before he throws his servant a mean sneer and tells him to bugger off.  \"<i>Cleese!  Scarlet can handle it!  Let her!</i>\"");
			
			outputText("\n\n\"<i>Care to try again?</i>\"  You smirk and ask him when it's peaceful again, even though you're secretly enjoying seeing him sweat like that.");
			
			outputText("\n\n\"<i>Well, alright. Maybe I haven't been entirely honest with you.</i>\"  He shmoozes, lowering his voice again to its usual hoarse timbre and making calming hand gestures towards you.  He's ever the charmer.  \"<i>With you, I feel like being... completely honest!</i>\"  He flashes his flawless smile, takes you by the hand and manages to sweep in close to you.  \"<i>However, not here on the streets.</i>\"");
			
			outputText("\n\nYou're still waiting for an answer when he grabs a hidden piece of rope inside the wall and holds you tightly around your waist.  For a moment you wonder what's going on, but it becomes clear when he pulls the rope.  With great speed the rope pulls the both of you upwards, and in the blink of an eye you find yourself gently put down on the roof of the orphanage by the swinging arm of a crane.");
			
			//~~~ Page ~~~
			menu();
			addButton(0,"Next",raphaelIntroPageTwo);
			flags[kFLAGS.TIMES_ORPHANAGED_WITH_RAPHAEL]++
		}
		else if (model.time.hours >= 19 && model.time.hours <= 21) {
			//Repeat Approaches
			//Repeat encounter: When the Orphanage is selected between 19:00 and 21:00
			outputText("You walk into the alley to the side of the orphanage and look up expectantly, brushing by shady looking teens who enjoy patting you down, but leaving you and your possessions alone otherwise.  They seem to make a game out of it.  The little staging room is lit and you begin to search for the one rope out of many that will hoist you up there by pulling it.  You stay clear of the other ones, not quite sure what they'd do, but half expecting them to fire a crossbow bolt or drop an anvil on your head.  Anxious, you grab the right one and hold on tight as it pulls you up into the air and swings you towards the correct window.");
			//[One of the three sex / dialogue scenes follows]
			flags[kFLAGS.TIMES_ORPHANAGED_WITH_RAPHAEL]++;
			if (player.spe < 33) {
				outputText("\n\nYou try your best to make an elegant entrance, but the rope gathers such speed that you're almost hurled into the room ungraciously.  Just before you crash into the floorboards, something catches you and slows your flight by spinning you around by the waist.");
				outputText("\"<i>Ho-ho, I've not even begun the night and already I'm snatching the priceless treasure out of thin air.</i>\"  When your eyes focus, Raphael is smiling back at you and leans you backward in his embrace.  His long vulpine snout hovers over you and his green eyes twinkle in the light.  \"<i>I must admit that I was feeling a bit nervous about my chances in the coming night, but now that you're here?</i>\"  He shrugs playfully.  \"<i>I'd say that fallen angels are a blessing.  With you seeing me off for good luck, I can't go wrong!</i>\" he chuckles while setting you down.");
			}
			//~~
			else if (player.spe < 66) {
				outputText("\n\nGetting the hang of it, you sweep up and manage a deft landing in the little rogue's pad by sinking to your knees as you land.  When you look up, you barely manage a fleeting glimpse of Raphael's luscious bare butt before the young man hoists up his pants by candlelight.  Apparently he was just getting dressed.");
				outputText("\n\nHe turns around.  \"<i>Getting better at it my little moth of the night; catching a master thief with his pants down.</i>\" he chuckles as he puts on his leather jacket and buttons it up.  Throwing his lavender scarf around his neck, he turns around all prim and proper.  \"<i>Though let me see what a lowly rogue can do to muster an introduction more becoming of his lady guest.</i>\"");
			}
			//~~
			else {
				outputText("\n\nToday's hoist comes up a little short and manages to land you right on top of the windowsill all quiet like.  The fox has sharp ears however and you can see him wake up from behind the thin paper screen in front of the little bed.  Apparently the fox was still napping in a darker corner of the dimly lit room when you entered.  He lights a candle, casting a powerful black silhouette of himself against the screen and gets up.  You can pretty much see everything, despite it being just the shadow of the young man.  He probably doesn't know.  His broad downy chest is the first thing to rise from above the bedspread.  Standing up, the fox then bends over and fetches clothes from the floor next to him.  He tries to subdue the rather large and inappropriate erection jutting out from his hips, before deciding to hurry up and simply muffle it within the pants he slips on. The quick application of a jacket later, the fox steps out from behind the screen.");
				
				outputText("\n\n\"<i>Here I was just thinking of you...</i>\" he smiles with disheveled fur and staring out of one groggy eye as if he's winking at you, leaning up against the wardrobe in a manner meant to be sultry.");
			}
			outputText("\n\n\"<i>So glad you could come, my eye's thief.  I can't tell you how much I've been looking forward to another one of your visits.</i>\"  The fox hastily tries to rearrange some pillows and tidy a few curtains by walking into the room and brushing them by with hands and tail.  \"<i>I hope you don't mind the mess.  I'm not used to receiving guests here, but for you?</i>\"  He turns towards you and flashes a smile.  \"<i>I'm not sure. It feels like you belong here.</i>\"");
			outputText("\n\n\"<i>If you will?</i>\" Raphael gestures over to the bed with a smirk.  \"<i>For sitting, of course.  I'm afraid I find myself with a lack of chairs.</i>\"");
			outputText("\n\nYou sit down on the rickety bed. It is barely held up by a wooden frame that gives you splinters just looking at it, and a pile of cinderblocks to support the places where it's been broken already.  It's barely big enough for a single person to sleep in and lies cramped under a slanted roof and sheltered by tails of silky curtains, but what it lacks in size, it makes up for with coziness.  It's filled with down and very soft. The dusty green pillows, dark blue silk spreads and the worn brown furniture surrounding it gives it the appearance of a dive, but the arrangement gorges on the candlelight and feels warm and comfortable.  It smells faintly of a fox's male musk.  It's a bit intimidating, but soothing at the same time.  As the skies outside darken, you can imagine wanting to spend time here if you didn't have a portal to guard.");
			outputText("\n\nIn fact, the only thing in the room that keeps you on alert is the young man taking his seat besides you.  He flashes his trademark mien, one that always manages to somehow confuse and make his intentions crystal clear at the same time.  \"<i>So señorita, what brings you to my humble abode?  Do I dare guess what brings a lady of such indiscriminating taste to visit a scoundrel of sordid repute?</i>\"  He leans in closer and brings his lips to yours, glancing at your eyes with his emerald irises.");
			//[Talk] [Sex]
			menu();
			addButton(0,"Talk",talkWithRedFoxLooksOutHesASpy);
			addButton(1,"Sex",raphaelOrphanageSexMenu);
			addButton(4,"Leave",telAdre.telAdreMenu);
			//build a menu here!
		}
		else {
			//When the orphanage is selected on any other time
			outputText("You walk into the alley to the side of the orphanage and look up expectantly, brushing by shady looking teens who enjoy patting you down, but leaving you and your possessions alone otherwise.  They seem to make a game out of it.  It's hard to see if any of the rooms are lit because it's still quite bright outside.  There probably aren't.  Still, you begin to search for the one rope out of many that will hoist you up there by pulling it.  You stay clear of the other ones, not quite sure what they'd do, but half expect them to fire a crossbow bolt or drop an anvil on your head.  Anxious, you grab the right one and hold on tight when you pull it, but oddly enough, nothing happens.  You're sure it's the right one, but something is preventing the system from kicking into gear.  You shake your head and step back in silent admiration.  You're not sure what mechanical marvel is responsible for it, but the orphanage must be decked with all manner of clever contraptions that even manage to factor time into the system.");
			//[nothing happens]
			menu();
			addButton(0,"Back",telAdre.telAdreMenu);
		}
	}
	//PLACEHOLDER UNTIL VIXENS ARE DONE
	else {
		
	}
}

private function raphaelIntroPageTwo():void {
	clearOutput();
	outputText("\"<i>This place isn't really an orphanage, is it?</i>\" you ascertain sagely, still waiting for a reply.");
	outputText("\n\n\"<i>It's what my humble little abode is called by the rest of the city.  I can assure you that it does indeed harbor a majority of the city's orphans, but alas, it has a fair few other functions I must confess.  I had hoped to keep this fact from someone as insightful and perceptive as you, but I should have known better.</i>\"");
	
	outputText("\n\n\"<i>What are they, these other functions?</i>\"");
	
	outputText("\n\n\"<i>It's a public establishment.  It provides homes to treasure seekers, fashion designers, antiquarians and the huddled masses.  I believe the law refers to us as pickpockets, strippers, fences and beggars.</i>\"  He shrugs.  \"<i>Can't say I blame them.  Right now we're having an auction.  You'd be surprised how many of these bored nobles are happy to get acquainted with valuables they'd forgotten about ten years ago.  They think they'll match the ones they still have in their attics... somewhere.</i>\"  He grins.  \"<i>They'll never care to look and in truth, I think they know deep down.  The coming of demons and the ruination of any semblance of a proper economy, it does much to skew people's perception of wealth.  The poor no longer have places to earn any and the rich sit on hoards they can no longer properly spend.  I give them a place that allows them their little indulgences, one that makes them feel wealthy again.  I then spend the proceedings on those that need it. I'm the middle man, the great equalizer.</i>\"  Raphael drifts by and walks further across the roof.");
	
	outputText("\n\nWhen you wonder what made him equalize your possessions, he winks apologetic.  \"<i>I needed to cool my heels outside the city for a while.  I couldn't stay in the orphanage, nor Tel'Adre with the Quicksilvers breathing down my neck.  It would put too many people at risk.</i>\"  He takes you by the hands and fondles them with his thumbs.  \"<i>The beasts and demons carry little wealth and I remain a thief.  You were the only thing out there allowing me to profess my craft and keep me sane.</i>\"  He kneels before you, staring you in your eyes.  \"<i>And then you saved me, my salvation.</i>\"  He kisses your hand once.");
	
	menu();
	addButton(0,"Next",evenMoreRaphaelIntro);
	
}
	
//Raphael's Shit Expanded
private function evenMoreRaphaelIntro():void {
	clearOutput();
	outputText("You drift away from the charming rogue, knowing where he would lead you the moment you let him.  You turn your attention towards the rest of the roof and begin to notice what else there is up here.  Through an unsightly hole in the roof you can still trace the golden glow coming from inside.  The burlesque girls - all of them vixens of a crimson red - flicker on-stage like distant dancing flames.  They're so far down that it's hard to see, but the light bleeding through the floorboards beneath your feet does much to illuminate quite another sight, there on the top of the roof and underneath the darkening sky.");
	outputText("\n\nThere's an entire garden up here.  A great many makeshift arbors, broken flowerbeds and dilapidated lattices, bearing the weight of a vast and verdant display of flora, lush enough to no longer need the support.  There's even a certain kind of humidity here that dampens the air, despite the altitude.  Such coolness and moisture is pleasant out here in a desert city.  Many of these dark-green plants are roses, bearing burgundy buds that couldn't be far removed from bursting into full bloom.");
	
	outputText("\n\n\"<i>It's a little pastime I entertain, this garden of mine.  I've heard a tale that gentlemen are supposed to pursue the nobler arts - gardening being one of them.  Naturally, I couldn't help but tack on and see how I'd do instead.</i>\"");
	
	outputText("\n\nYou cross your arms and smirk when you sense him standing behind you.  \"<i>The woodwork is rotten.</i>\"");
	
	outputText("\n\n\"<i>Ah yes.  But you see, the roses, do they not bloom?</i>\" he lisps with the affectation typical of him, and he lays his fabulously soft paws upon you.  \"<i>In fact, one of them appears to have set in early.</i>\"  He glides them down your spine and kisses you on the neck.  You can count his whiskers and feel his nose.");
	outputText("\n\nYou're suddenly reminded of the red bodysuit Raphael gave you earlier, of the motif of flowers running across your body.  Branches, leaves and thorny swirls, complete in every detail but the flower.");
	
	outputText("\n\n\"<i>I was thinking of this very moment, when I gave you that dress.</i>\"  His paws travel across your skin in the pattern of a sweeping rosebush.  \"<i>You are the blossom my garden lacked.  The most gorgeous flower of them all.</i>\"");
	
	outputText("\n\nWith one firm swerve, he turns you around to face him again.  \"<i>I have but one wonder mademoiselle...</i>\"  The fox smiles, holds you by the waist, and presses his body closer onto yours.  \"<i>What would such a fair beauty be doing in the seedy part of town, other than brightening the day of a lowly rogue?</i>\"  The russet rogue looms in over you with a develish twinkle in his emerald eyes.  His sharp triangular face and pointy ears are turned towards you inquisitively.");
	
	//[Kiss] [Goodbye]
	menu();
	addButton(0,"Next",kissRaphaelFirstTimeOrphanage);
}

private function getTheFuckOutOfDodge():void {
	clearOutput();
	outputText("You politely inform Raphael that you have to go, and though he seems crestfallen, he demurs, \"<i>Very well then, ma chère.  I shall await you in the hours of late evening, in case you change your mind.</i>\"");
	outputText("\n\nWell, that went well.");
	doNext(camp.returnToCampUseOneHour);
}

//RaphSex
//Sex1
private function kissRaphaelFirstTimeOrphanage():void {
	clearOutput();
	outputText("You drift into Raphael as easily as you would into a pillow.  The young thief leans in over you and begins to devour you softly with gentle tongue and nimble hands.  You are all too eager to reciprocate and let him pass through your mouth and across your back.  You try to wrestle him for control over your tangled tongues, but it turns all too quickly into a metaphor for his swordplay.  All your twirls and wriggles are met by sensuous swirls across areas of your tongue you never even knew you had.  Raphael has instantly turned it into an major erogenous zone.  You give up, but once again the fox does not relent.  He keeps lashing your tongue until you're forced to writhe limply to the rhythm.  When you attempt to imagine what would happen, were he to do the same to your already throbbing " + player.clitDescript() + ", your knees shudder.  When Raphael, just faintly, places his paws on the sides of your spine in just the right way, you nearly climax.  You fall into his waiting hand and he catches you by the neck and lower back.  You're enveloped in a soft sea of groping warmness.  His playful growls carry further into your body than they should.");
	outputText("\n\nHe moves you back, further into the garden.  Just before you hit a rose entwined lattice, Raphael takes hold of you and lifts you up, pinning you squarely against it at mid-height.  Slightly startled by the gesture, you spread your arms to find a grip, but discover it to be easy, up against the plants.  The lattice is indeed rotten to the core, and it crumbles at your touch.  The thick, stubborn rosebushes, however, manage to hold your weight.  You quickly find two branches to grasp and your posterior finds a nook to sit upon.  Your legs you wrap around the fox's hips, as the rogue smiles at you with admiration and zeal.");
	outputText("\n\nThere's a brief moment of vulnerability, as he finds an opening into your pants.  As sure as a master thief would find his way into the vault of a city, he quickly opens it.  The thorns at your back do bite while you hang limply between trunk and fox with your privates exposed mid air, but you are soon relieved of your awkward neglect when Raphael tilts his hips and drives deep a much larger implement.  Finally the embrace is whole again as you can feel his pelvis thump in against your netherlips. His bone-hard length has already breached you.");
	player.cuntChange(5,true,true,false);
	
	outputText("\n\nThere's something to be said for his slender and agile size, still clearly felt bottoming inside you.  You're never left waiting for too long.  You quickly settle into the distinctive rhythm, staring Mr. Fox into his eyes with a daring look.  You're willing to suffer the discomfort of the thorns to discover just how good he is now that you're in it for the duration.  You arch your back into the bushes, help to ease him into your passage and feel like the first of Spring's roses held proudly aloft by the gifted gardener.");
	
	outputText("\n\nWhile Raphael might indeed not be the most endowed lover, he is very skilled.  The wicked fox keeps eye contact, often grinning and snarling at you as in an attempt to keep you aware of just what predicament you're in.  He whispers you little words in an indecipherable language, running his paws across your " + player.buttDescript() + " or [hips].  Whatever he does bring to bear, he does well.");
	
	outputText("\n\nYou begin to notice how his smooth tip nudges repeatedly into your cervix, massaging you deep from within.  Then you begin to notice how his pelvic bone and the soft fur on top rubs into your " + player.clitDescript() + " at just the right angle.  The sensations are seperate at first, but Raphael keeps the steady rhythm steady enough to concentrate.  When you finally manage to focus and truly enjoy them both, it's like a subtle spark that grows into a relentless bolt of energy.  The pleasurable pinch at your cervix, always followed by the nod on your clitoris.  It builds.");
	
	outputText("\n\nFinally, you beg of him to stop as the growing crescendo and steady rhythm becomes too much, not by pulling out, but by jamming into you one last time and simply keeping his wonderful cock in the magic spot for long enough to ride the sensation to a climax.");
	player.slimeFeed();
	player.orgasm();
	dynStats("sen", -1);
	menu();
	addButton(0,"Next",followupToFirstTimeOrphanageRaphSex);
}

//After Sex1
private function followupToFirstTimeOrphanageRaphSex():void {
	clearOutput();
	//[ Scene after rose garden sex on top of the orphanage roof ]
	outputText("You wake up startled.  The last thing you remember is a sunset rendezvous with the russet rogue upon a rooftop garden of roses, but when you look around you realize you're lying in a foreign bed.  It's an odd room you find yourself in.  It's a small wooden dive, but warmly decorated and enchanted by the playful flicker of candlelight shadows and the haunting undulation of curtains breezing in the wind.  There are pillows on the large bed, silken bedspreads and a worn rug.  A large wardrobe, a distant vanity, a table full of tools and the small creaky bed cast silhouettes in the darkness.  A single candle on the bedstand beside you provides all the light available and casts long shadows across the rough wooden floorboards.  You don't appear to be trapped, however.  The room has no door, but a large window opening leads out into the night sky.  For a moment you're startled by just how late it already is, but not enough to contain your curiosity.");
	
	outputText("\n\nThere are cracks in the wooden floorboards and you get down on your knees and try to peek through the slits.  You're still in the orphanage, you confirm.  The same strange golden light that escaped momentarily when Raphael opened the front door can be seen on the other side and appears to surround the room like some magic entity.  You can hear music within the light, the faint sound of merry singing, children laughing and the soft hymn of ringing silver permeates it.  By comparison, this space is a sheltered oasis of musty calm and homely austerity.  Judging from the sundry of burglary tools on the nearby table and the easy access, this is some kind of a staging room for a thief's forays into the city, or a quick getaway pad when said forays go wrong.");
	
	outputText("\n\nWhen you feel like you're being watched, you turn towards the open window and see the perfect shadow of a fox lying on the sill.  You smile and ask the shadow what's on the other side, but Raphael shakes his head and steps into the light, the candlelight beating off his red fur.  \"<i>The motliest gathering of thieves, beggars and whores you ever did see.</i>\"  He sighs but at the same time, smiles with a sense of pride.  \"<i>But above all, they are mia famiglia.  My little family; and let none speak ill of it.</i>\"");
	
	outputText("\n\n\"<i>Before you ask.</i>\"  Raphael winks and lays on finger on your lips.  \"<i>Not right now.  I must confess to having brought over women before... but one such as you?</i>\"  His snout moves slowly and deliberately to form the heavily accented words, \"<i>I would need the time to prepare a proper introduction, to properly reflect how impressed I am with having met you.  Also, we're entertaining guests for the foreseeable future.  I wouldn't want your introduction to the group to be eclipsed by the bustle.  Give me a few weeks.</i>\" and the rogue turns around, puts his rapier to his belt and prepares to jump out of the window by squatting on the sill.  Before he does, he throws one last look back across his shoulder.");
	
	outputText("\n\n\"<i>Do you think you can remember which rope I pulled?</i>\" he asks you.  You think you can and Raphael nods.  \"<i>Good.  I wouldn't recommend pulling any other when you want to visit me in the meantime.</i>\" he winks.  \"<i>The russet rogue, he never leaves a lady wanting.  Visit me whenever you see this room lit at dusk, when it's still light enough for you to make your way back to camp afterwards and already dark enough for me to have woken up and prepare to leave for work.</i>\"  He turns his head and upper body around enough for him to look you in the eyes.  \"<i>I would be looking forward to it if you could make it.  Who knows?  Maybe this is your chance to steal into my room for a change and take me by surprise instead, no?</i>\"");
	
	outputText("With a wink, Raphael disappears as he lets himself drop from the window.  You walk after him, to see where he went.  It's quite the way down, but he appears to have vanished.  With your promise in hand, you decide you'd better do the same and head back to the portal by way of a nearby extendable ladder that pops right back up the building the moment you remove your weight.  You take care to memorize what room you came from and confirm which rope it was, cleverly hidden alongside a drainpipe.  You may not have gotten much closer to uncovering the secrets of the orphanage, but at least this won't be the last you see of him.");
	doNext(camp.returnToCampUseOneHour);
}


//Cunnilingus
private function cunnilingusWithRaphael():void {
	clearOutput();
	outputText("Raphael kisses you on the lips for lack of resistance, backs off and then beams like he had an idea.  \"<i>Tonight I'm trying to pull off an especially tough job, so I feel like having sex would throw me off my game, but what is it again I always say about rogues and leaving ladies wanting?</i>\"  He winks, before kissing you on the neck and moving his fingers around and across your back to undo your clothes.  You gasp and start doing the same to him, not adverse to seeing him naked every once in a while.  Undoing the slip-hooks on his jacket, you bare his broad, downy fur chest, while he manages to slip down a now bare back and tries to undo the last of your [armor].  The fox is a good sport when you're already naked, and he allows you to take off his pants.  His bright red fox cock bobs seductively in front of the flawless white fur of his crotch, but it becomes clear that Raphael does not intend to use his fiery rapier this time.  Instead, he lays you down on your back, carefully positioning you with kisses and brushes.  When you're finally down on the bed with legs wide, he lies on his stomach down in front of you and neglects his shaft by smothering it in the silk of the bedspread.  Instead, he slithers forward with his face and throws your inner thighs a few kisses.");
	outputText("\n\n\"<i>This silver tongue of mine...</i>\"  He kisses your [leg].  \"<i>Isn't just for charming...</i>\"  He moves up a little higher.  \"<i>...or forming cheap accents.</i>\"  He rolls his lips up your thigh before pausing and looking you straight in the eye.  \"<i>Let me show you how the red carpet leads to the heavens.</i>\"");
	
	outputText("\n\nWith his paws, Raphael raises up your butt and crotch just a few inches into the air, as if elevating it for a special occasion.  It encourages you to bend your knees and spread your legs, opening yourself up and presenting your womanhood fully.  Lacking all shame and still looking you into the eyes, the fox then does the lewdest thing.  Maintaining eye contact and without blinking, he rolls out his long red tongue and brushes it against your " + player.vaginaDescript(0) + ".  The sensation of the bawdy rough thing lapping up your sensitive gash's gathered dew takes you completely by surprise and you let your head fall back and moan.  It feels like he's worshipping you by lapping through the trembling fruit.  At the very zenith of his lashes, he takes extra time to twirl around your " + player.clitDescript() + " in a vortex of swirling tastebuds.");
	outputText("\n\nHe's good at it.  With every new lap, he sinks a little deeper into your crevasse to partake of the moist delta, parting the trembling lips as he runs through the furrow and ravages your trembling buzzer, sometimes doing all these three things at the same time with the full length of his limber tongue.  It roves, lays along the entire length and falls neatly into place.");
	
	outputText("\n\nAfter five minutes of this, sending you gasping and writhing, you dare to raise your head and look down with a fierce blush.  Raphael is still at it.  He looks up and patiently resumes eye contact, like you're an invitee to the discourse between him and the glistening red, tongue-lashed and dilated femslit before him.  The look he throws you is enough to send you over the edge and you cum hard, ");
	//({Low wetness multiplier})
	if (player.wetness() < 3) outputText("your cunt fluttering");
	//({Medium wetness multiplier}
	else if (player.wetness() < 4) outputText("sending out a small spurt of femcum landing on your belly");
	//({High wetness multiplier}
	else outputText("gushing a torrent of femcum into the air");
	outputText(".  Raphael backs off a bit afterwards, giving you a few more laps of admiration around the throbbing fissure and cleaning you of any spillage. He ends with a tiny kiss, just inside your inner thigh.");
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}

//Second Raphael variable sex scene: Girl on top:
private function girlOnTopOfRedFoxesOhMy():void {
	clearOutput();
	outputText("The fox has not far to go when he tries to kiss you on the lips.  Bold enough to enter the lion's den, you're assertive enough to not only meet his inquisitive snout head on, but take the initiative by climbing onto the Rogue.  You smile at each other as you grab him by his leather jacket and wrestle for a position on top.  There you sit on his lap, take him by his neck and press the kiss.  You can already feel his vulpine phallus rise up below his leather and in between your bodies.  Raphael's being good however and lets you have your fun. Only when you start plucking at his vest does he return the gesture.  Between your nimble hands and his, clothing is quickly shed and you soon find yourself straddled naked on top the fox's equally bare fur.  Raphael gives himself an easy time at it; now that you've gone this far, the fox simply sits back and leans in against the wall of pillows stacked behind him.  He gives you an expectant stare, like he's eager to see what you've got.");
	outputText("\n\nIt's not hard to figure out what that is.  His bright red cock is already erect and standing in attention up against your ass.  You reach down, fetch it and still marvel at how hard, smooth and slick it feels to the touch.  You play with it for a while by stroking it up and down, teasing the fox.  The pointy tip you run between your leg and trace it through the lips of your nethers before rubbing it around your bothered " + player.clitDescript() + ".  You make the young man mewl with pleasure, his cock more sensitive than you expected.");
	outputText("\n\n\"<i>Uno momento, señorita.</i>\"  Raphael purrs, and with a sly smile, takes out what looks like a thin piece of skin.  \"<i>A latex condom.</i>\"  He tells you.  \"<i>I think neither of us would want you bothered by my spawn.  Normally I slip it on unbeknownst to my lovers, but then again, none of them have been as proactive as you have been now.</i>\""); 

	outputText("\n\nYou swipe the condom out of the fox's hand and waste no time applying it.  In fact, you manage to do a good job of giving it a sensual part within your lovemaking, which makes you feel all smart.  Between spread legs and right in front of your " + player.vaginaDescript(0) + ", you lay it in within your hand and slowly roll your fist across his cock; giving him a taste of what is to come.  Raphael gasps softly at the sight as you do it. The condom fogs up instantly around his muzzled red bone.");
	
	outputText("\n\nTriumphant, you finally point his tip towards your furls and drag through, towards the waiting hole of your [vagina].  Gently sitting down upon it, it slides in smoothly. Raphael rewards you by finally participating, softly running his velvet paws across your flanks, neck and fondling your [chest] admiringly.  Finally, a little bashful, you throw your head back, letting Raphael have his way with your body as you concentrate and enjoy riding him.");
	player.cuntChange(5,true,true,false);
	
	outputText("\n\nRaphael's cock is something else. It must be the bone running through it that gives it its firmness.  Instead of stuffing yourself with a nondescript roll of meat, you can clearly feel him penetrating you with his well defined and rock-hard shaft.  With the faintest twitch of the hip, you can change its angle and run it through in an entirely different manner and you eagerly start experimenting with what feels best.  Eventually you settle on jutting your ass backwards and pressing the middlemost of his solid length against the front wall of your [vagina] while the tip bottoms out against the back.  The position does not go unnoticed to Raph, and he trails his paws along your " + player.buttDescript() + ".  You begin to bounce around on top him, jamming him into you more firmly and more securely with every rut in.  Raphael supports you by either grabbing you by the ass or cupping your tits, playing with them with his sandy paws.  He sinks in heavily, smoothly, with every gulp of your tightening cunt accompanied by a little wet slush around his hard manhood.");
	
	outputText("\n\nDesperate for that little bit more, you reach down and start fondeling your " + player.clitDescript() + " too.  Your button brushing in against Raphael's soft white pubes tickles.");
	
	outputText("\n\nLooking him in the eyes again, you slaver on top of the fox.  Raphael simply lays back, lazily fondles your breasts and ass and looks at you to put in the effort around his cock.  Only after minutes of this, almost driving yourself towards the brink, does Raphael suddenly sit up sharply - an anguished snarl on his face - to hold you in a tight embrace and groan conceitedly.  You can feel his cock jerk up and grow an inch in size, before his passion escapes into your womanhood.  Allowing yourself as well, you follow him with a lazy orgasm and join him in his growl, while he squeezes you on your waist.");
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}
//Available side by side to having sex: Dialogue scenes.
private function talkWithRedFoxLooksOutHesASpy():void {
	clearOutput();
	outputText("The rogue is hard to distract and just talk to when he goes after the knots on the back of your dress.  Whatever you want to discuss can surely wait until after you're disrobed.  When you mention demons after trying to bring up the subject, however, Raphael loses the playful glaze in his eyes and turns serious.  Putting the moves on you gets rather awkward when someone mentions a menace motivated by only debauchery.  He tones it down somewhat and instead, focuses on being a good host by meandering through his loft in search of something to drink and two glasses.");
	
	outputText("\n\n\"<i>What about them?</i>\"  He shrugs, \"<i>They don't bother me.  They're not much for material wealth or fancy clothes, are they?</i>\"  He chuckles as he manages to retrieve a wooden goblet and a crystal glass.  \"<i>Unless it concerns golden phalluses or a jeweled nipple piercing.  Then I'd be all over it, although even I would need to consider stealing such 'used' goods.</i>\"");
	
	outputText("\n\nYou jokingly refer him to an incubus and how a man like him should have come to know quite a few succubi on his journeys.  Raphael flashes a guilty little smile on return, some mineral water on hand.  \"<i>Hope you don't mind?  It's better that I not drink alcohol before going on the job.</i>\"  He sits down besides you and pours it, offering you the crystal glass.");
	
	outputText("\n\n\"<i>Like I said, they don't bother me much.  Make no mistake however; like any sane Tel'adrian, I think they're a threat to civilization.</i>\" he starts to explain.  \"<i>No sense of style.  Alors, I too have a reputation for chasing skirt.</i>\"  He smiles coyly while looking over the rim of his glass and tipping it backwards.  \"<i>But I'd like to think that I'm set apart from an incubus, by a sense of refinement.  I'm not quite ready to wander the desert, chasing random strumpets in barely any clothes at all.</i>\"  He finishes his sip.  \"<i>I mean, what a waste of a wardrobe that would be.</i>\"  He sits back, stretches his arms and straightens his fine leather jacket.  \"<i>In fact, I'd like to think that I'm hardly about sex at all!</i>\"  He states.");
	
	outputText("\n\nWhen you ask him what he is about, Raphael's answer is a surprising one.  \"<i>About knowing succubi... yes, I knew quite a few quite intimately.  To say that I learned my skill at charming others from them wouldn't be far from the truth.</i>\"  He trails an idle finger across the rim of his goblet like he's reminiscing.  \"<i>The moment I became any good at remaining unseen, I made my way into the mountains to find one of these succubi.  I was young and curious.  I spied on them.  Let's say their pastime activities were of great interest to a young male.</i>\"  He grins.  \"<i>The moment I became good enough with the rapier to muster the courage, I confronted one.</i>\"  Raphael lets a deliberate pause fall in the discussion, lasting long enough for you to ask what happened next.  The fox gloats. \"<i>Let's just say I learned to realize what I want most from life, and the difference between loose women and dignified ladies.  Sneaking into their lairs makes you either a suicidal fool or a demon slaying hero and luckily, I am neither.  She played me for an idiot, telling me to just submit, lay down my weapon and get rewarded beyond my wildest dreams.  Enticing, true, but luckily, I found out that my desire to compete and win, is greater than my libido.  I recognized it as a game for control and not only did I manage to play along, but I began preying on her desires better than she could mine.  I never did lay down my rapier that night, always convincing her I either needed just one more sordid act to lose my mind to her, or already had.</i>\"  He observes.  \"<i>And the oddest thing happened.  The moment I was winning, I began losing interest in her.  My mind turned instead, to the city bank or some noble's vault, to ponder on how much harder these would be to get into than my lady friend.</i>\"  He chuckles a bit awkward.  \"<i>The following morning, I had gotten all I wanted from her and escaped unharmed.</i>\"");
	
	outputText("\n\nHe looks over to you and frowns, worried.  \"<i>I wouldn't recommend attempting the same though.  My first succubus was a very young one, almost a decade ago.  In my puberty, I would proceed to try and seduce several more - even two incubi - to charm my way out of trouble whilst seeking demon treasure, but as time progressed, I got into serious trouble for it.  The smarter ones, higher up the ranks, outdid me and I can personally attest how demons have a corrupting influence to them.  Simply being around to stalk them was enough to make me careless.  I became addicted to the thrill.  Had I not broken a leg, forcing me to recover in the city and giving me time to reflect and recover, I'm not sure if I would be around today.  I mean, you can only pick the lock on the tiny cage they're using to cart you up the mountain so many times, before they decide to simply fuse it.</i>\"  He smiles.  \"<i>By then, I had learned to appreciate finer things. I have little enduring interest in the corrupt.</i>\"");
	
	outputText("\n\n\"<i>But what I mean to say, is this: I put value in things such as modesty, dignity, decorum and a sense of style.  I don't think that demons do, or at least not in a way that would preserve these virtues.</i>\"  Raphael clears his throat and dips back into metaphors.  \"<i>I'm not about theft.  I'm about getting into hard to reach places.  I don't care what's in the vault.  Whatever it is, it must be valuable to be there, behind all those intricate traps, delicate locks, ornate guards and cultural heritage.  To finesse my way through all of that?</i>\"");
	
	outputText("\n\nRaphael smirks and turns towards you, leans on one paw and gazes into your eyes.  \"<i>I just can't get enough of tweaking knobs, hitting a lock's sweet spot, or getting my fingers in places where they don't belong, amidst all that splendor.</i>\"");
	menu();
	raphaelOrphanageSexMenu();
	addButton(4,"Leave",camp.returnToCampUseOneHour);
}


private function raphaelOrphanageSexMenu():void {
	menu();
	addButton(0,"Cunnilingus",cunnilingusWithRaphael);
	addButton(1,"Ride Him",girlOnTopOfRedFoxesOhMy);
	addButton(4,"Leave",telAdre.telAdreMenu);
}
}
}
