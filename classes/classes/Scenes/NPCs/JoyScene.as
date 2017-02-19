package classes.Scenes.NPCs 
{
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.*;
	
	/**
	 * Bimbo Jojo by LukaDoc
	 * @author Kitteh6660
	 */
	public class JoyScene extends NPCAwareContent
	{
		
		public function JoyScene() 
		{
			//Pregnancy is handled in JojoScene.as
		}
		
		public function joyTalkCounter():int {
			var temp:int = 0;
			temp += flags[kFLAGS.JOY_TALKED_ABOUT_YOURSELF];
			temp += flags[kFLAGS.JOY_TALKED_ABOUT_HERSELF];
			temp += flags[kFLAGS.JOY_TALKED_ABOUT_OLD_LIFE];
			temp += flags[kFLAGS.JOY_TALKED_ABOUT_DEMONS];
			temp += flags[kFLAGS.JOY_TALKED_ABOUT_BABIES];
			return temp;
		}
		
		public function joySexCounter():int {
			var temp:int = 0;
			temp += flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY];
			temp += flags[kFLAGS.JOJO_ANAL_XP];
			temp += flags[kFLAGS.TIMES_LICKED_JOYS_PUSSY];
			temp += flags[kFLAGS.JOJO_BLOWJOB_XP];
			temp += flags[kFLAGS.TIMES_FROTTED_WITH_JOY];
			temp += flags[kFLAGS.TIMES_GET_BLOWN_BY_JOY];
			temp += flags[kFLAGS.TIMES_GET_LICKED_BY_JOY];
			temp += flags[kFLAGS.JOJO_VAGINAL_CATCH_COUNTER];
			temp += flags[kFLAGS.JOJO_ANAL_CATCH_COUNTER];
			return temp;
		}
		
		private function initializeJoy():void {
			if (player.findStatusEffect(StatusEffects.JojoNightWatch) >= 0) player.removeStatusEffect(StatusEffects.JojoNightWatch);
			flags[kFLAGS.JOY_COCK_SIZE] = 5.5;
			flags[kFLAGS.JOY_BREAST_SIZE] = BREAST_CUP_DD;
			flags[kFLAGS.JOY_VAGINAL_WETNESS] = 3;
			flags[kFLAGS.JOY_INTELLIGENCE] = 20;
		}
		
		public function joyVagCapacity():int {
			var temp:int = 30 + (10 * flags[kFLAGS.JOY_VAGINAL_WETNESS]);
			temp += (2 * flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY]);
			if (temp > 120) temp = 120;
			return temp;
		}
		
		public function joyAnalCapacity():int {
			var temp:int = 30;
			temp += (5 * flags[kFLAGS.JOJO_ANAL_XP]);
			if (temp > 80) temp = 80;
			return temp;
		}
		
		public function joyCockLength():Number {
			return flags[kFLAGS.JOY_COCK_SIZE];
		}
		public function joyCockGirth():Number {
			return 1 + (Math.floor(flags[kFLAGS.JOY_COCK_SIZE]) / 10);
		}
		public function joyCockArea():Number {
			return joyCockLength() * joyCockGirth();
		}
		
		public function joyBallSize():Number {
			if (joyHasCock()) {
				if (flags[kFLAGS.JOY_COCK_SIZE] < 7) return 1;
				else if (flags[kFLAGS.JOY_COCK_SIZE] < 8) return 2;
				else return 3;
			}
			else return 0;
		}
		
		public function joyHasCock():Boolean {
			if (flags[kFLAGS.JOY_COCK_SIZE] > 0) return true;
			else return false;
		}
		public function joyHasCockText(text:String):String {
			if (joyHasCock()) return text;
			else return "";
		}
		
		public function joyBallsDescript():String {
			var text:String = "";
			if (joyBallSize() >= 3) {
				switch(rand(3)) {
					case 0:
						text += "large ";
						break;
					case 1:
						text += "apple-sized ";
						break;
					default:
				}
				
			}
			else if (joyBallSize() == 2) {
				switch(rand(3)) {
					case 0:
						text += "fairly large ";
						break;
					case 1:
						text += "baseball-sized ";
						break;
					default:
				}
			}
			switch(rand(5)) {
				case 0:
					text += "balls";
					break;
				case 1:
					text += "testicles";
					break;
				case 2:
					text += "gonads";
					break;
				case 3:
					text += "nuts";
					break;
				case 4:
					text += (silly() ? "funorbs" : "balls");
					break;
				default:
					text += "balls";
			}
			return text;
		}
		
		public function joyCockDescript():String {
			var text:String = "";
			switch(rand(4)) {
				case 0:
					text += "mouse ";
					break;
				case 1:
					text += "futa ";
					break;
				case 2:
					text += "mammalian ";
					break;
				default:
					text += "";
			}
			switch(rand(6)) {
				case 0:
					text += "cock";
					break;
				case 1:
					text += "prick";
					break;
				case 2:
					text += "penis";
					break;
				case 3:
					text += "dick";
					break;
				case 4:
					text += "member";
					break;
				case 5:
					text += (silly() ? "funstick" : "cock");
					break;
				default:
					text += "cock";
			}
			return text;
		}
		
		public function joyPussyDescript():String {
			var text:String = "";
			if (flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY] <= 0 && rand(2) == 0) text += "virgin ";
			switch(rand(3)) {
				case 0:
					text += "mouse ";
					break;
				case 1:
					text += "pink ";
					break;
				default:
					text += "";
			}
			switch(rand(4)) {
				case 0:
					text += "cunt";
					break;
				case 1:
					text += "pussy";
					break;
				case 2:
					text += "vagina";
					break;
				case 3:
					text += "twat";
					break;
				default:
					text += "vagina";
			}
			return text;
		}
		
		public function joyAssDescript():String {
			var text:String = "";
			if (flags[kFLAGS.JOJO_ANAL_XP] == 0) text += "virgin ";
			else if (flags[kFLAGS.JOJO_ANAL_XP] < 5) text += "tight ";
			else "loose ";
			switch(rand(6)) {
				case 0:
					text += "ass";
					break;
				case 1:
					text += "backdoor";
					break;
				case 2:
					text += "anus";
					break;
				case 3:
					text += "butthole";
					break;
				case 4:
					text += "rump";
					break;
				case 5:
					text += "rear end";
					break;
				default:
					text += "ass";
			}
			return text;
		}
		
		public function joyBreastDescript():String {
			var text:String = "";
			if (flags[kFLAGS.JOY_BREAST_SIZE] >= BREAST_CUP_E && flags[kFLAGS.JOY_BREAST_SIZE] < BREAST_CUP_G) {
				switch(rand(3)) {
					case 0:
						text += "large";
						break;
					case 1:
						text += "big";
						break;
					case 2:
						text += "";
						break;
					default:
						text += "";
				}
			}
			else if (flags[kFLAGS.JOY_BREAST_SIZE] >= BREAST_CUP_G) {
				switch(rand(4)) {
					case 0:
						text += "huge";
						break;
					case 1:
						text += "immense";
						break;
					case 2:
						text += "jiggling";
						break;
					default:
						text += "";
				}
			}
			switch(rand(4)) {
				case 0:
					text += "bosoms";
					break;
				case 1:
					text += "boobs";
					break;
				case 2:
					text += "breasts";
					break;
				case 3:
					text += "love-pillows";
					break;
				default:
					text += "breasts";
			}
			return text;
		}
		
		private function joySitLoc():String {
			if (player.isBiped()) return "lap";
			else if (player.isTaur()) return "back";
			else if (player.isDrider()) return "abdomen";
			else if (player.isNaga()) return "coil";
			else if (player.isGoo()) return "pseudo-lap";
			else return "lap";
		}
		
		public function joyCumQ():int {
			return jojoScene.jojoCumQ();
		}
		
		public function getTotalLitters():int {
			return flags[kFLAGS.JOJO_LITTERS] + flags[kFLAGS.JOY_TWINS_BIRTHED];
		}
		
		private function incrementJoysCockFondness(amount:int):void {
			flags[kFLAGS.JOY_COCK_FONDNESS] += amount;
			if (flags[kFLAGS.JOY_COCK_FONDNESS] > 10) flags[kFLAGS.JOY_COCK_FONDNESS] = 10;
		}
		
		//------------
		// INTRO
		//------------
		//Bimbofy Warning
		public function jojoPromptsAboutThief():void {
			jojoScene.jojoSprite();
			clearOutput();
			outputText("As you return to the camp; Jojo suddenly approaches you, a surprisingly grim look on his face. \"<i>[name], my friend? I believe we have a thief eyeing us as potential victims.</i>\" He suddenly declares, without any attempt at making conversation.");
			outputText("\n\nSurprised, you ask him why would he think that?");
			outputText("\n\n\"<i>I was patrolling around the camp when I saw a stranger going through your stash, he seemed to have taken an interest in a strange bottle you had...</i>\"  He stops to rub at his temple and recall what was written in the label.  \"<i>I think it was called Bimbo Liqueur... anyway, luckily I managed to chase it away and retrieve the stolen bottle, but we should take care, I’m pretty sure they were determined to get their hands on it, and will be back to try again; thieves always do.</i>\"");
			outputText("\n\nYou thank Jojo for the information and tell him you'll think something to catch this thief.");
			outputText("\n\nAt this, Jojo suggests, \"<i>You’re usually busy with your duties... but I could set up a trap... we know what they want, so when our little visitor comes for their prize, I could use this as an opportunity to catch them.</i>\"");
			outputText("\n\nYou stop and think about this... On one hand, catching this thief would be great, since that would mean one less problem to worry about, but Jojo would be risking himself.  Sure... he has battle training... and he did manage to live all by himself in the forest before you arrived... would a petty thief really pose a threat to someone like him?  And why were they targeting the Bimbo Liqueur?  From what you gather its a pretty potent transformative, so who knows what this mysterious visitor could be planning?  On the other hand... sometimes prevention is the better solution... you could just have Jojo keep a close eye on your stash to discourage any further attempts at theft, and this would ensure whoever is targeting the Bimbo Liqueur doesn’t get a chance to try and do any harm.");
			outputText("\n\nWhat do you do?");
			menu();
			addButton(0, "Catch Thief", letsCatchThief);
			addButton(1, "Guard Stash", letsGuardStash);
		}
		
		//Attempt to catch thief, set flag to 2, route to bimbofication the next day.
		private function letsCatchThief():void {
			clearOutput();
			outputText("That sounds like a good plan to be honest, so you tell Jojo that you’re leaving the matter in his hands, though you advise him to be careful.");
			outputText("\"<i>I will be careful, don't worry, my friend. I assure you that everything will be fine.</i>\" Jojo insists. With that, he takes the bottle and leaves, clearly getting ready to lay a trap for the mysterious would-be thief.");
			inventory.removeItemFromStorage(inventory.itemStorageDirectGet(), consumables.BIMBOLQ);
			flags[kFLAGS.JOJO_BIMBO_STATE] = 2;
			flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO] = 0; //Reset timer to 0.
			doNext(playerMenu);
		}
		
		//Stay and guard stash, set flag to 1.
		private function letsGuardStash():void {
			clearOutput();
			outputText("You tell Jojo you’d rather have him just keep a close eye on your stash, it sounds less risky than having him catch the thief.");
			outputText("\n\n\"<i>I’m not afraid of danger; don’t forget that the forest where we met is full of monsters, especially imps and tentacle beasts.  I can defend myself.</i>\" Jojo points out, sounding a little annoyed at being dismissed like this.");
			outputText("\n\nEven so, you’d still rather he didn’t risk himself.  There’s no telling what this thief would do if they got your hands on your Bimbo Liqueur.");
			outputText("\n\n\"<i>What does it even do, anyway?  Why would anyone want it?</i>\" The baffled murine monk asks.");
			outputText("\n\nKnowing the monk, he would surely oppose to you keeping it around... and you really don’t feel like throwing it away... so you tell him it’s just a very rare liquor you happened to find in a stash hidden somewhere.  You’re just saving it for a special occasion, that’s all.");
			outputText("\n\n\"<i>Well, I guess even in these times, rare alcohol is still valuable... very well; if you’re sure it’s best that I leave it to you, I’ll focus on just guarding the camp.</i>\"");
			outputText("\n\nYou thank Jojo for understanding... and for keeping your camp safe.");
			flags[kFLAGS.JOJO_BIMBO_STATE] = 1;
			doNext(playerMenu);
		}
		
		//Bimbofy Me!
		public function jojoGetsBimbofied():void {
			jojoScene.jojoSprite();
			clearOutput();
			outputText("As you return to the camp, you decide to check up on Jojo and see if he had any success in catching the thief.");
			outputText("\n\nYou spot Jojo returning to the camp with a  triumphant smile on his face, though he looks a bit dizzy...");
			outputText("\n\n\"<i>I’m (hic) sorry, [name]... but I couldn’t stop the thief...</i>\" The mouse quietly burps and looks embarrassed, tottering along like someone who’s a bit drunker than is good for them.");
			outputText("\n\nYou tell him to never mind that, but... is he feeling okay?  And what happened exactly?");
			outputText("\n\n\"<i>The thief managed to outwit me - stole the liqueur and almost made off with it. But I managed to beat them, though; I couldn’t catch them, but I could stop them from winning.</i>\"  Jojo hiccups again, eyes glazing and giving you a goofy grin.");
			outputText("\n\nReally?  You ask him how... though judging by his stumbling... and slurring you feel like you know the answer already...");
			outputText("\n\n\"<i>At one point, I managed to grab the bottle off of them... so I drank it myself!</i>\" Jojo gives you a surprisingly girly giggle as he tells you this, then lets out another soft burp.");
			if (player.cor < 60) outputText("\n\nUh oh...");
			else outputText("\n\nNow that should be interesting...");
			outputText("\n\nYou ask him if he’s feeling fine.");
			outputText("\n\n\"<i>Yeah, I feel just fine.</i>\" Jojo says, with another giggle.");
			outputText("\n\nYou ask, once more, if he’s sure he’s feeling fine?");
			outputText("\n\nThe mouse-morph scowls at you, \"<i>I said I’m feeling fine!</i>\" He screams, then winces, one hand flying to his temples.  \"<i>I...I...maybe I’m not so fine after all...</i>\" He moans.");
			doNext(joyEmerges);
		}
		
		//Bimbofy Me! (The DIY version)
		private function jojoGetsBimbofiedByYou():void {
			jojoScene.jojoSprite();
			clearOutput();
			outputText("You ask Jojo how he would feel about beating the thief to the prize.");
			outputText("\n\n\"<i>Oh?  What do you have in mind?</i>\" Jojo asks, with a puzzled voice.");
			outputText("\n\nWhy... the thief won’t have anything to steal if you use the bottle before they can get at it right?  So why don’t the two of you break open this bottle and down it’s contents?  If you recall correctly, Jojo did have a drink or two back in his monastery, right?");
			outputText("\n\nJojo blinks his eyes in bafflement, cocking his head to the side in a quizzical fashion.  \"<i>I... guess that makes sense.  After all, liqueur is for drinking... and, yes, I did indulge in the odd cup now and then, before... well, if you’re offering?</i>\" He gives you a sad smile.");
			outputText("\n\nYou smile and tell him you couldn’t think of anyone better to share your stash with.");
			outputText("\n\nThe monk mouse smiles softly, \"<i>thank you, [name].</i>\"  He says.");
			outputText("\n\nYou tell him to fetch a couple of cups for the two of you.");
			outputText("\n\nThe mouse nods and moves off, returning quickly with two humble-looking, thickly made, well-used clay mugs.  He offers one to you to use.");
			outputText("\n\nTaking one of the mugs and setting it down nearby, you open the bottle and pour yourself a mugful of liqueur, then pour another mugful for Jojo.");
			outputText("\n\nJojo smiles and nods in gratitude, savoring the bouquet of the liqueur.  \"<i>It smells so sweet... I can’t recall any of the wine or ale we made at the monastery smelling like this.</i>\" He notes.");
			outputText("\n\nYou raise your mug and say, \"<i>Cheers!</i>\"  Then clatters your mug against Jojo’s and takes the mug to your lips, pretending to be taking a sip.");
			outputText("\n\nJojo thirstily tips the mug back, chugging it down in several long swallows, licking his lips when he’s done.  \"<i>What an odd flavor; but it’s nice!</i>\" He proclaims enthusiastically.");
			outputText("\n\nWell, no need to hold back.  You pour him another mugful.");
			outputText("\n\nJojo downs this with all the same enthusiasm as the first, letting out a very unmonkly belch after he’s done.  \"<i>Oh, excuse me!</i>\" He apologises, gently placing his fingers over his lips before giggling with embarrassment.  He sounds a lot more feminine than usual... ");
			outputText("\n\nWell, if he likes it so much... he can have your mug too.");
			outputText("\n\nJojo seems to barely restrain himself from snatching it from your hands, eagerly guzzling it down.  \"<i>More, please!  This is yummy!</i>\" He begs you.");
			outputText("\n\nYou keep pouring Jojo mugful after mugful of liqueur, until the bottle is emptied.");
			outputText("\n\nJojo belches loudly, too drunk now to care about manners but giggling in a very feminine manner at the noise he just made.  He holds his mug out for a refill, but you shake your head, pointing out the bottle is empty.  Disbelieving, the monk snatches the bottle from you and holds it over his face, shaking it over his open mouth in hopes of eeking out one last drop.  He whimpers,  \"<i>no more booze?</i>\" in an almost heartbroken tone.");
			outputText("\n\nYou suggest that perhaps he drank a bit too much a bit too fast?");
			outputText("\n\n\"<i>[Name], what are you talking about?  I’m just thirsty, that’s all, and that stuff’s so yummy!</i>\" Jojo protests.");
			outputText("\n\nReally?  You ask inquisitively.  So he’s feeling fine then?");
			outputText("\n\n\"<i>Of course I am!  I...I... whoa, I feel dizzy...</i>\" Jojo trails off, swaying unsteadily back and forth.");
			dynStats("cor", 2);
			doNext(joyEmerges);
		}
		
		//Jojo gets bimbofied! Joy Emerges.
		private function joyEmerges():void {
			spriteSelect(-1);
			clearOutput();
			outputText("Jojo doubles over and groans; you watch helpless as his fur changes from white to platinum blonde. He sprawls on the floor and you can see his lips getting fuller, his eyelashes longer and his chest begins expanding; a tearing sound rips through the air, as Jojo's new pillowy boobs rip his robes apart, perky nipples erect.");
			outputText("\n\nYou see his pants suddenly become much less baggy as his butt, hips and thighs grow; his whole figure shifts towards the feminine and a ripping sound confirms his pants have also torn up somewhere.");
			outputText("\n\nFinally, Jojo stops shaking, breathing deeply, his physique now very much feminized. You can't think of anything else to do but ask if he...er, \"she\" is okay. Jojo looks up at you, a comical expression on his now-feminine features, blinks a few times, and belches loudly, then giggles girlishly. \"<i>Like... I feel super-great, [name]! Whoah, what a trip! I feel, like, all floaty-tingly, ya know?</i>\"");
			if (player.cor <= 33) outputText("\n\nYou can't help but look at Jojo's new body, blushing a bit in arousal at how attractive the former monk has become.");
			else if (player.cor <= 66) outputText("\n\nYou gaze at Jojo's transformed body, she is very attractive; you think you wouldn't mind 'examining' the former monk's body more closely.");
			else outputText("\n\nYou smile a bit, taking in Jojo's new feminine figure; she sure is a lot more attractive now than she was. Maybe you should rip her pants off and see if she has also grown a pussy?");
			outputText("\n\nJojo pays no attention to your scrutiny; she's too busy examining her new bosom. \"<i>Wow, I have, like, really big bouncy boobies!</i>\" She says, squeezing them with a giggle. \"<i>Bouncy-bouncy!</i>\" She laughs, jiggling them in her hands. \"<i>Hello, what's this that feels funny down here?</i>\" She wonders. Then, to your shock, she flips off her torn robe and kicks off her pants without a second thought. For a moment you think that the liqueur has turned Jojo into some sort of shemale; despite his-her feminized features and bountiful breasts, you can see \"she\" still has an average-sized cock and balls in between her legs. But then, as she bends over, you see a newly formed set of pink vulva lips just behind it; the former male mouse has become a herm!");
			outputText("\n\n\"<i>This feels funny...</i>\" Jojo notes. \"<i>Like, funny-haha, not funny-weird. Wait, it does feel funny-weird too, but not in a bad way, ya know?</i>\" Even as she says this, her fingers are starting to tease her new sexual orifice.");
			outputText("\n\nYou nod, enraptured by her arousing display. Then you shake your head and calls out to Jojo.");
			outputText("\n\nThe newly bimbofied mouse-morph stops what she's doing and looks at you, frowning in a vacant sort of way. \"<i>Like, that name really doesn't sound good for a girl. Am I a girl? Well, I've got boobies and a fun hole, so I must be a girl, even if I do still have a fun stick... Like, I really want a better name. A cuter name. What's a good name for a girl that starts with a J...?</i>\" She trails off, visibly thinking about it. You can't help but mutter \"<i>oh, joy</i>\" to yourself at her actions, but her big round ears twitch and she visibly perks up. \"<i>Like, that's the perfect name! Joy! Cause, y'know, I'm so happy now - I just wanna have fun, like, all the time! So call me Joy now.</i>\" She proclaims, smiling proudly.");
			outputText("\n\nYou roll your eyes and ask... Joy... if she's feeling fine or if there's anything you can do to help her?");
			outputText("\n\nJoy giggles. \"<i>I feel, like, super-duper, cutie/sweetie! Right now, I just wanna go and get to know the new me... figure out what I can do with these new bits of mine.</i>\" She jiggles her breasts again. \"<i>Wow, lookit 'em bounce!</i>\" She turns and starts walking over to the stream, blissfully naked except for her bead necklace around her neck. \"<i>But, after I've had some, like, me time, well, then maybe you and the new me can get acquainted, huh, sexy?</i>\" She purrs, shaking her lusciously rounded rump at you, then sashaying off, tail waving luxuriantly from side to side.");
			if (player.cor <= 33) outputText("\n\nYou roll your eyes, oh gods... what should you do now... you rub your temples and figure you should at least fetch some new clothes for her...");
			else if (player.cor <= 66) outputText("\n\nYou wonder if you should go after her or not... well for the meantime you'd best fetch her some new clothes...");
			else outputText("\n\nYou're liking this new Jojo... you make a mental note to get acquainted to the new Jojo as soon as possible... for now though, you'd best fetch her some new clothes...");
			if (silly()) outputText("\n\n<b>(Congratulations! Your Jojo has evolved into Joy. Bust size increased, Lust increased, Intelligence decreased. Joy is trying to learn how to use Sex, but Joy can't learn more than 4 moves. Should Joy forget an old move and learn Sex? Yes! 1...2...3... Poof! Joy forgot Chastity and learned Sex.)</b>");
			else outputText("\n\n<b>(Jojo is now Joy.)</b>");
			flags[kFLAGS.JOJO_BIMBO_STATE] = 3;
			initializeJoy();
			doNext(camp.returnToCampUseOneHour);
		}
		
		//------------
		// FOLLOWER
		//------------
		private function genericMenu(approach:Boolean = false):void {
			if (!approach) {
				clearOutput();
				outputText("\"<i>Do you need, like, anything else?</i>\" Joy asks. Her tail waggles excitedly.");
			}
			menu();
			addButton(0, "Appearance", joysAppearance, null, null, null, "Examine Joy's appearance. She must be so sexy!");
			addButton(1, "Talk", joyTalkMenu, null, null, null, "Talk to Joy and discuss about various topics.");
			addButton(2, "Train", trainWithJoy, null, null, null, "Train with Joy and improve your overall strength");
			addButton(3, "Meditate", meditateWithJoy, null, null, null, "Attempt to meditate with Joy to calm your lusts although you're sure that there's a chance this might backfire.");
			addButton(4, "Sex", initiateSexWithJoy, null, null, null, "Joy is a sexy mouse, why not have some fun with her?");
			addButton(5, "Give Item", giveItemsToJoy, null, null, null, "Give some items to Joy to alter her.");
			addButton(14, "Back", camp.campFollowers);
		}
		
		public function approachCampJoy():void {
			clearOutput();
			jojoScene.jojoSprite();
			if (player.cor <= 33) {
				switch(rand(2)) {
					case 0:
						outputText("You climb the boulder where Joy usually sits, and see her sitting cross legged with her eyes closed. She seems to be deep in meditation, but when you approach a soft snore confirms she's actually asleep. When you step closer however she suddenly shakes her head and opens her eyes groggily looking at you; then she beams at you and says, \"<i>Hey [name]! Did you need something? Or do you want to, like, do something fun; like touching my boobies or "); 
						if (joyHasCock()) {
							if (player.hasCock() && rand(2) == 0) outputText("rubbing our funsticks");
							else outputText("playing with my funstick");
						}
						outputText("?</i>\"");
						break;
					case 1:
						outputText("You climb the boulder where Joy usually sits, but she's nowhere to be seen, so you sit down and wait for a bit. It takes a while and you feel like almost giving up, when something soft bumps on your head; you reach back to feel what it is and end up grasping a soft fuzzy orb; shortly after you hear a soft \"<i>eep!</i>\" and a pair of arms hug you from behind. \"<i>I'm happy to see you too [name]!</i>\"");
						break;
					default:
				}
				outputText("\n\nJoy releases you and walks around as you get up. \"<i>So, like, do you want to play?</i>\"");
			}
			else if (player.cor <= 66) {
				outputText("You climb the boulder where Joy usually sits and see her sitting cross legged with her eyes closed. But she suddenly opens her eyes and looks at you, squinting a bit; then she gets up and approaches you. \"<i>Hey, [name]! I... umm... I see some, like, black icky stuff around you; maybe you should get that looked at? I can help you!</i>\" she says with a big smile. \"<i>Or if you'd like to do this later we can, like, fool around?</i>\" she suggests with a grin, batting her eyes.");
			}
			else { //No Joy sex for you if you're corrupt!
				outputText("You climb the boulder where Joy usually sits, and as soon as you're up Joy is standing, waiting for you. \"<i>[name], I can feel the black icky stuff all over you, you should, like, medi - med... umm... meditate! And get rid of that.</i>\" She strikes a sexy pose and blows you a kiss. \"<i>If you do we can, like, have some fun!</i>\" she says with a smile.");
				outputText("\n\n(Do you meditate?)");
				doYesNo(joyMeditationHighCorruptionLetsGo, joyMeditationHighCorruptionNoThanks);
				return;
			}
			genericMenu(true);
		}
		
		private function joysAppearance():void {
			clearOutput();
			outputText(images.showImage("joy-appearance"));
			outputText("Joy, formerly known as Jojo, stands before you. Her face is curvy and feminine, with puffy lips and long eyelashes. Her eyes are blue and regard you with desire and happiness. She's currently posing and suckling on the tip of her ropy tail as you gaze at her.");
			outputText("\n\nShe's wearing monk robes that barely manage to contain her - " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + "s you estimate - breasts, it seems that at the slightest move those pillowy orbs will burst out from their hiding place; you can even see her perky nipples occasionally poke from under her robes. She's barely managing to hold it closed by using her praying beads as a belt. Looking a bit lower you see a nice handful of ass, with supportive hips that give her a very sexy hourglass figure. She's cut her pants into a pair of tight fitting shorts and walks barefoot on her mousy footpaws.");
			outputText("\n\nHer weapon of choice is an unremarkable wooden staff, although you only see her use it to pose and tease you; running it between her breasts or between her legs and even licking it sometimes... Whenever she gets a reaction from you, she giggles girlishly.");
			if (joyHasCock() && joySexCounter() > 0) outputText("\n\nFrom previous experience you can estimate she has a " + joyCockLength() + " inches long and " + joyCockGirth() + " inches thick dick. It looks surprisingly human, right underneath that, she has a pair of gonads that are about " + joyBallSize() + " " + (joyBallSize() == 1 ? "inch" : "inches") + " in diameter each.");
			outputText("\n\nBetween her legs sits a " + joyPussyDescript() + ". Beads of lubricant occasionally form on her pink nether lips.");
			outputText("\n\nBetween her squeezable jiggly bums she has " + joyAssDescript() + ", where it belong.");
			doNext(genericMenu);
		}
		
		//------------
		// TALK
		//------------
		private function joyTalkMenu():void {
			clearOutput();
			outputText("You tell Joy you'd like to talk to her for a moment.");
			outputText("\n\nThe bimbo mouse gives you a brainlessly happy grin. \"<i>Like, sure, [name]! So, what do you, like, wanna talk about?</i>\" She asks.");
			menu();
			addButton(0, "Yourself", askJoyAboutYourself);
			if (joyTalkCounter() > 0) addButton(1, "Old Life", askJoyAboutOldLife);
			addButton(2, "Demons", askJoyAboutDemons);
			if (flags[kFLAGS.JOY_TWINS_BIRTHED] > 0 || player.isPregnant() || jojoScene.pregnancy.isPregnant) addButton(3, "Babies", askJoyAboutBabies);
			addButton(14, "Back", genericMenu);
		}
		
		private function askJoyAboutYourself():void {
			clearOutput();
			outputText("You decide to ask Joy what she thinks about you.");
			outputText("\n\nJoy blinks and looks at you puzzled. \"<i>What do I, like, think of you? Okay...</i>\" She narrows her eyes, studying you intensely.\n\n");
			//Race check
			switch(player.race) {
				case "human":
					outputText("\"<i>Well, you're a human. I haven't seen one of your kind in, like, many, many years. I think the demons got 'em all, or at least they got most of 'em. They try to round up every human who comes through, like, the portals, too. Still, I think there's some of you still hidden around.</i>\"");
					break;
				case "dog-morph":
				case "dog-man":
				case "dog-woman":
					outputText("\"<i>Well, you're a doggy - woof woof! There used to be a lot of doggies in a city called Tel'Adre somewhere... I dunno what happened to 'em all,</i>\"");
					break;
				case "centaur":
				case "centaur-morph":
					outputText("\"<i>Well, you're a centaur. You look kinda like somebody stuck a human on a horse. How'd that happen, anyway?</i>\"");
					break;
				case "cat-morph":
				case "cat-boy":
				case "cat-girl":
					outputText("\"<i>Well, you're a kitty... What? Did you, like, think it was funny to have a mousie girlfriend when you're a kitty - cat?</i>\"");
					break;
				case "equine-morph":
					outputText("\"<i>Well, you look like a horse. Neigh! I've never, like, seen a horse-morph before.</i>\"");
					break;
				case "fox-morph":
				case "fox-girl":
					outputText("\"<i>Well, you're a fox. I remember there are some foxes in a city called Tel'Adre somewhere.</i>\"");
					break;
				case "goblin":
					outputText("\"<i>Well, you're a goblin... Sort of. Never knew a goblin who wasn't obsessed with trying to fuck everything in sight.");
					if (player.hasCock()) outputText(" Never knew a goblin with, like, a cock of her own, either.");
					if (player.gender == GENDER_FEMALE && !joyHasCock()) outputText(" But I've never, like, heard of a lesbian goblin before.");
					outputText("</i>\"");
					break;
				case "kitsune":
					outputText("\"<i>Well, you look like a kitsune. You look like a fox with lots of tails! There are some kitsunes in the deepwoods. They, like, enjoy playing tricks on you!</i>\"");
					break;
				case "bee-morph":
					outputText("\"<i>Well, you're a buzzy little bee-girl/boy/herm/thingy, aren't you? I'm kind of sad you don't make honey... I always liked honey... But I guess it's better than getting eggs up my butt.</i>\"");
					break;
				case "shark-morph":
					outputText("\"<i>Well, you're a shark. You should be splashing around in the lake; what are you doing on dry land? Always want to be a fish out of water?</i>\"");
					break;
				case "demon-morph":
					outputText("\"<i>Well, to be honest, you look like a demon... And that's terrible! Demons are nasty! People will be scared of you if you look like that.</i>\"");
					break;
				case "siren":
					outputText("\"<i>Well, you look like a beautiful siren. Wanna, like, song to me?</i>\"");
					break;
				default:
					outputText("\"<i>You look like... Well, you look... I don't know what you look like... I've never seen anything like you before, so I guess that make you, like, unique?</i>\"");
			}
			//Gender check
			outputText("\n\nHaving commented on your race, the bimbo next casts her eye over your crotch and your " + player.chestDesc() + ". \"<i>You're a ");
			if (player.gender == GENDER_MALE) {
				outputText(" guy, and I'm, like, super-happy that's what you are - it means I can play with your funstick.");
			}
			else if (player.gender == GENDER_FEMALE) {
				if (joyHasCock()) outputText("girl, with a yummy baby-hole for me to stick my funstick into and fill you full of mousey-cream.");
				else outputText("girl... And that's not a bad thing, but I kinda, like, wish one of us had a funstick; it'd be more fun that way! Oooh! And imagine the fun we could have if we both had funsticks!");
			}
			else if (player.gender == GENDER_HERM) {
				if (joyHasCock()) outputText("herm and I'm sooo happy about it; we can have so much fun!");
				else outputText("herm, with yummy " + player.breastDescript(0) + " and a cute " + player.vaginaDescript() + " for me to lick and a nice " + player.cockDescript() + " for me to suck and rub and fill my fun-holes with; I just love it when you put cream in my hungry-achey little belly.");
			}
			else {
				outputText("...Well, you're not really anything. And it's not really a lot of fun... can't you turn into a boy or a girl?");
			}
			//Corruption and perk check
			outputText("\n\nNext, Joy closes her eyes and focuses on your aura.");
			if (player.cor < 5) { //Pure
				outputText("\n\n\"<i>Your aura's, like, super shiny white - I can't remember seeing anyone as clean and pretty as you!</i>\"");
			}
			else if (player.cor < 33) { //Low corruption
				outputText("\n\n\"<i>You've got some small streaks of icky black stuff on your aura, but it's nothing, like, too major.</i>\"");
			}
			else if (player.cor < 66) { //Medium corruption
				outputText("\n\n\"<i>You know your soul's covered in this icky black gunk? It's really getting out of hand; you need to clean up.</i>\"");
			}
			else { //High corruption
				outputText("\n\n\"<i>Ew! Your aura's, like, totally covered in icky black stuff! You need to wash your soul! I can hardly bear to, like, look at you like this!</i>\"");
			}
			if (player.findPerk(PerkLib.PurityBlessing) >= 0) {
				outputText("\n\n\"<i>There's this shining light in your heart... Makes me feel all warm and fuzzy when I see you. I just wanna hold you close.</i>\"");
			}
			if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
				if (joyHasCock()) outputText("\"<i>There's this funny green light sitting in your belly... It makes my funstick feel all hard and stiff. I just wanna stuff you full of cream and make lots and lots of little mousies with you!</i>\"");
				else outputText("\"<i>There's this funny green light sitting in your belly... It makes me think of babies. Like you're gonna have lots of babies.</i>\"");
			}
			if (player.findPerk(PerkLib.MaraesGiftStud) >= 0) {
				outputText("\"<i>There's this funny green light shining from your " + player.cockDescript() + "... I feel funny just looking at it. My belly starts to get all cramped up, and I wanna have babies. I just wanna make babies with you all day long.</i>\"");
			}
			//Pregnancy check
			if (player.isPregnant()) {
				outputText("\n\nThe mouse suddenly stares at your belly, looking at you very intensely. \"<i>You're, like, gonna have a baby!</i>\" She grins. \"<i>Ooh, let's see what you're gonna have here...</i>\" She closes her eyes and focuses on the aura emanating from your unborn babies. \"<i>It's ");
				switch(player.pregnancyType) {
					case PregnancyStore.PREGNANCY_IMP:
						outputText("Eew! It's imps! Have you been sleeping with demons? That's just gross!</i>\" She gags, sticking her tongue out in disgust.");
						break;
					case PregnancyStore.PREGNANCY_MINOTAUR:
						outputText("a minotaur? Like, why would you want one of those big dumb brutes giving you a baby?</i>\" She wonders.");
						break;
					case PregnancyStore.PREGNANCY_KELT:
						outputText("a centaur? Like, where did you find a centaur to give you a baby?</i>\" She asks, clearly baffled.");
						break;
					case PregnancyStore.PREGNANCY_MOUSE:
						outputText("Aw! It's a lot of little mousies... Something seems kinda funny about them, though.</i>\" She rubs her chin in bemusement.");
						break;
					case PregnancyStore.PREGNANCY_AMILY:
						outputText("Daaw; they're cute little mousies - oh, they'll look just like Amily.</i>\" She claps.");
						break;
					case PregnancyStore.PREGNANCY_JOJO:
						outputText("...</i>\" She suddenly goes silent, then gives an ear-to-ear grin. \"<i>They're my babies! Oh, I'm gonna be a daddy-mommy!\" She cheers");
						break;
					case PregnancyStore.PREGNANCY_MARBLE:
						outputText("a cute little cowgirl; Marble's, like, gonna be so happy to know she's gonna be a dad.</i>\" The former monk smiles.");
						break;
					case PregnancyStore.PREGNANCY_IZMA:
						outputText(" fishy! It's a little sharky from Izma's big old funstick... d’aww, her tail's all curled around her.</i>\" Joy fawns.");
						break;
					case PregnancyStore.PREGNANCY_URTA:
						outputText("a cute little fox; Urta's, like, gonna be a dad.</i>\" The former monk smiles.");
						break;
					case PregnancyStore.PREGNANCY_MINERVA:
						outputText("two little sirens; Minerva's, like, gonna be very happy to have her own daughters. She must be happy for you.</i>\" The former monk smiles.");
						break;
					case PregnancyStore.PREGNANCY_BEHEMOTH:
						outputText("a strange purple creature that looks like the Behemoth. He's, like, pure though. No black, icky stuff.</i>\" Joy fawns.");
						break;
					default:
						outputText("... Umm... aw, I don’t know what it is... </i>\" Joy sighs, disappointed.");
				}
			}
			outputText("\n\nYou're shocked by Joy's through analysis of you; it's a bit shocking actually that despite acting so childish and happy all the time, she's actually quite capable... You take a few moments to overcome your shock and tell Joy that... well... all you were expecting was to hear if she liked you... or anything similar...");
			outputText("\n\nShe giggles. \"<i>Like you? Of course I like you, silly! I just thought you wanted to be reminded of what you were.</i>\"");
			outputText("\n\n\"<i>Umm... thanks?</i>\" you say, still befuddled.");
			outputText("\n\nShe smiles and flops down on the ground. \"<i>I'm tired now. I wanna take a nap.</i>\" She announces, then curls up and closes her eyes, oblivious to the world.");
			outputText("\n\nTo be honest this whole situation is a bit awkward... so you take your leave...");
			flags[kFLAGS.JOY_TALKED_ABOUT_YOURSELF]++;
			doNext(playerMenu);
		}
		
		private function askJoyAboutHerself():void { //For some reason, this talk topic is missing.
			clearOutput();
			outputText("<b>Apparently, the document didn't include this scene.</b>");
			flags[kFLAGS.JOY_TALKED_ABOUT_HERSELF]++;
			doNext(playerMenu);
		}
		
		private function askJoyAboutOldLife():void {
			clearOutput();
			outputText("Thinking back to your previous talk with Joy, you decide to ask her if she misses her old self at all.");
			outputText("\n\nJoy cocks her head to the side in puzzlement. \"<i>Like, why would I miss my old self? I like being Joy. What did I have as Jojo that I don't have now? Plus, I got stuff that Jojo didn't.</i>\"");
			outputText("\n\nYou explain to her that she is so different from Jojo, that you can scarcely believe that both her and Jojo are the same person...");
			outputText("\n\nAt that, Joy scowls. \"<i>Well, let me tell you something, [name]. You don't know Jojo as well as you think you do.</i>\" She snaps, hands on her hips.");
			outputText("\n\nYou're surprised by her reaction, and ask her what does she mean by that?");
			outputText("\n\n\"<i>I'm not some whole other person, you know! I'm, like, Jojo, but I'm Jojo as he always wanted to be - free of the things that kept him back and, like, not scared of the things that he was scared of any more.</i>\" The bimbo mouse replies, simply.");
			outputText("\n\nScared? You ask her what would Jojo be scared off? He never seemed to fear anything, not even demons...");
			outputText("\n\nJoy just looks at you, sadly. \"<i>He was scared of you... And his feelings for you.</i>\" She comments, softly.");
			outputText("\n\nNow you're intrigued, feelings for you? You ask her how is that possible, wasn't Jojo chaste to begin with?");
			outputText("\n\n\"<i>He swore to be, like, chaste because it meant he'd be, like, harder for the demons and the goblins and things to get him that way. Didn't mean he couldn't love, couldn't lust... just meant he, like, couldn't act on how he felt.</i>\"");
			outputText("\n\nBut... why keep all of that for himself then?");
			outputText("\n\n\"<i>Because he was scared. He'd been alone so long, he just couldn't bring himself to admit he cared for you. And you were, like, always off chasing after the demons; what if he told you and, like, you went out one day and never came back? He was too scared of that... So he kept it to himself. When he wanted to just, like, cuddle you and tell you how he felt, or, like, woke up in the night and had to go and wash his pants because he'd jizzed himself having naughty dreams about you, he never told you.</i>\" Joy concludes sadly.");
			outputText("\n\nYou're shocked by this revelation... had you known, you... it would seem Joy is right... you did not know Jojo as well as you did. You apologize to Joy for suspecting she wasn't truly Jojo.");
			outputText("\n\nShe smiles softly. \"<i>I know I'm, like, not as smart as he was, and I'm a lot hornier, so it's not like I can't, like, understand where you're coming from, y'know?  But I am he and he is me, and we both love you.</i>\"");
			outputText("\n\nSatisfied with her answer, you smile at her, then ask if she really has no regrets?");
			outputText("\n\n\"<i>Not a one. I gotta admit, the tits and the pussy were a shock to get used to"); 
			if (!joyHasCock()) outputText(" and then losing my cock and balls was another thing to get used to"); 
			outputText(", but now that I am Joy, I, like, wouldn't change back for the world.</i>\" The bimbo mouse smiles - and in her slightly wistful expression and far-looking gaze, you can see the resemblance to the mouse monk Jojo more clearly than ever before.");
			outputText("\n\nThen you say, \"<i>So, this means you would never go back to the way you were before?</i>\"");
			outputText("\n\nJoy sucks in a deep breath and shivers. \"<i>Weeell... If you, like, really wanted me to go back to being Jojo, or girly Jojo, then I would. But I'm, like, totally clueless how you'd actually change me back. This stuff in my system is, like, really strong; I used to meditate on it, to try and purge it, but I just couldn't ever, like, make it let go of me. I don't know if there's anything that can change me back.</i>\"");
			outputText("\n\nYou lose yourself in your thoughts... on one hand Joy genuinely looks happy as she is... but the truth is that she was forcibly changed... then again Jojo had all those repressed feelings... maybe things are fine just the way they are?");
			outputText("\n\n\"<i>Like, [name]? Are you feeling okay? Your face is all funny-looking.</i>\" The mouse notes.");
			outputText("\n\nYou snap out of your trance and tell Joy you were just thinking, and that you'll see her later.");
			outputText("\n\n\"<i>Like, okay, [name]; see you later; maybe we can have some fun when you come back?</i>\" The bimbo mouse giggles with glee at the thought.");
			outputText("\n\nMaybe you should approach and talk to Joy about changing her back once you have a clear way of doing so...");
			if (flags[kFLAGS.JOY_INTELLIGENCE] < 40) flags[kFLAGS.JOY_INTELLIGENCE]++;
			flags[kFLAGS.JOY_TALKED_ABOUT_OLD_LIFE]++;
			doNext(playerMenu);
		}
		
		private function askJoyAboutDemons():void {
			clearOutput();
			outputText("You ask Joy if she has any tips for fighting the demons?");
			outputText("\n\n\"<i>Um... lemme think...</i>\" The former monk furrows her brow in thought and paces back and forth. \"<i>Well... demons like to go for lust attacks over physical attacks; they, like, would rather you have all your strength so you'll, like, last longer when they fuck you. They're typically either very good at resisting lust or very bad at it... I'd, like, try to always attack 'em physically instead, because they, like, rarely train too hard at doing that.</i>\" She concludes.");
			outputText("\n\nYou tell her that from your experience, demons also have some sort of lust inducing aura, any tips against that?");
			outputText("\n\n\"<i>Uh...</i>\" She mumbles, clearly trying to think of something helpful to say. \"<i>Like, meditating to bring your libido under control is really the only thing I can think of. If, like, you aren't naturally super-horny, then the demons will, y'know, have a harder time getting you so turned on you stop fighting, y'see?</i>\"");
			outputText("\n\nSeems like this is the only way... You thank Joy for the insight and leave her for the moment.");
			flags[kFLAGS.JOY_TALKED_ABOUT_DEMONS]++;
			doNext(playerMenu);
		}
		
		private function askJoyAboutBabies():void {
			clearOutput();
			outputText("You smile and ask Joy how does she feel about being a parent?");
			outputText("\n\nThe mouse purses her lips thoughtfully, then smiles. \"<i>It, like, feels wonderful; I had always kinda wanted to have kids.");
			if (jojoScene.pregnancy.isPregnant) outputText(" I just, like, never once dreamed I'd be the one carrying 'em, y'know?");
			outputText("</i>\"");
			outputText("\n\nEven when she was still Jojo? You ask.");
			outputText("\n\nThe bimbo mouse nods. \"<i>Yep, even then. Being a monk didn't mean I had to swear off all thoughts of ever having a family; I just never did find a girl I liked. And then the demons tore the place apart and, like, I didn't think I'd ever find anyone I could, y'know, make babies with.</i>\" She grins widely. \"<i>But I did, didn't I?</i>\" ");
			if (player.isPregnant() || jojoScene.pregnancy.isPregnant) outputText("She pats " + (jojoScene.pregnancy.isPregnant ? "her" : "your") + " pregnant belly for emphasis.");
			outputText("\n\nYou chuckle, saying yes she did. Then you look at her seriously and tell her that being a parent is a big responsibility, so she can't play around with your kids all the time, specially with Mareth in its current state.");
			outputText("\n\n\"<i>Like, just what sort of girl do you take me for?</i>\" The bimbofied monk asks, looking hurt.");
			outputText("\n\nYou apologize and tell her that you just want to make sure she'll be a good parent. You know she likes to play around, but when it comes down to children she needs to be responsible.");
			outputText("\n\n\"<i>I, like, know that well. I'm gonna be a good " + (player.isPregnant() || flags[kFLAGS.JOY_TWINS_BIRTHED] > 0 ? "daddy-" : "") + "mommy, don't you worry, [name].</i>\" She insists.");
			outputText("\n\nYou smile and tell Joy that's all you were really worried about. You promise to come see her later and turn to leave her.");
			outputText("\n\n\"<i>Like, thanks for dropping by, [name].</i>\" The bimbofied mouse says as you leave.");
			flags[kFLAGS.JOY_TALKED_ABOUT_BABIES]++;
			doNext(playerMenu);
		}
		//------------
		// MEDITATION
		//------------
		private function joyMeditationHighCorruptionLetsGo():void {
			clearOutput();
			outputText("\"<i>Great! Sit down!</i>\" she instructs, happily.\n\n");
			joyMeditationFull(false);
		}
		
		private function joyMeditationHighCorruptionNoThanks():void {
			clearOutput();
			outputText("You tell Joy you don't feel like meditating right now...");
			outputText("\n\n\"<i>Ok, but don't let that icky stuff, like, control you or anything.</i>\" she says, then bites her lip and asks, \"<i>so... wanna touch my boobies? They're all soft and bouncy! And then you can rub my fun hole!</i>\" she giggles.");
			doNext(genericMenu);
		}
		
		private function meditateWithJoy():void {
			clearOutput();
			outputText("You ask Joy if she'd be willing to help you meditate.");
			outputText("\n\nShe grins and nods enthusiastically, then motions for you to sit down.");
			joyMeditationFull(false);
		}
		
		private function joyMeditationFull(clearText:Boolean = true):void {
			if (clearText) clearOutput();
			outputText("Once you've sat down Joy surprises you by sitting on your lap, the sudden movement startles you a bit, but it doesn't feel bad... specially since Joy's bottom is so... comfy...");
			outputText("\n\nShe closes her eyes and instructs you to do the same, and clear your mind of all impure thoughts.");
			//Exgartuan
			if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0 && player.statusEffectv2(StatusEffects.Exgartuan) > 0) {
				outputText("\n\nShe squeaks as a sudden stirring from your " + (player.statusEffectv1(StatusEffects.Exgartuan) == 1 ? "loins" : "breasts") + " knock her off-balance and she falls on her back.");
				outputText("\n\n\"<i>What are you doing!?</i>\" a booming voice demands. \"<i>Why are you sitting there all dressed up when there's perfectly fine piece of mouse ass there " + (player.statusEffectv1(StatusEffects.Exgartuan) == 1 ? "for you to fuck" : "to massage your love-pillows") + "?</i>\"");
				outputText("\n\n\"<i>W-What was that [name]?</i>\" Joy asks, confused as she hears the booming voice.");
				outputText("\n\nWith a sigh you explain to her about how your " + (player.statusEffectv1(StatusEffects.Exgartuan) == 1 ? "cock is" : "breasts are") + " being possessed by a demon.");
				outputText("\n\nExgartuan interrupts you by yelling, \"<i>Hey mouse girl, get down here and rub me down, I'll reward with some " + (player.statusEffectv1(StatusEffects.Exgartuan) == 1 ? "steamy hot cream" : "milk") + " for your service.</i>\"");
				outputText("\n\nJoy smiles and winks at you before saying, \"<i>OK!</i>\"");
				if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) { //Cock Exgartuan
					outputText("She " + player.clothedOrNakedLower("works to expose", "reaches for") + " your " + player.cockDescript() + " and begins gently stroking it.");
				}
				else { //Breasts Exgartuan
					outputText("She " + player.clothedOrNaked("works to remove the top of your [armor] and ", "") + "begins gently fondling your " + player.breastDescript(0) + ".");
				}
				outputText("\n\n\"<i>That's it girl! Rub away!</i>\" Exgartuan praises; while Joy just complies obliviously.");
				outputText("\n\nHowever, suddenly she stops. \"<i>Hey, I didn't say you could stop!</i>\" Exgartuan protests.");
				outputText("\n\nJoy smiles and replies, \"<i>I just, like, forgot to tell you something Mr. " + (player.statusEffectv1(StatusEffects.Exgartuan) == 1 ? "Cock" : "Boobies") + ".</i>\"");
				outputText("\n\n\"<i>What?</i>\" Exgartuan asks.");
				outputText("\n\n\"<i>Begone!</i>\" Joy exclaims, her hands flashing white for an instant and Exgartuan grows silent.");
				outputText("\n\n\"<i>Mr. " + (player.statusEffectv1(StatusEffects.Exgartuan) == 1 ? "Cock" : "Boobies") + " should, like, stay away now... I think... Now where were we? Oh yeah!</i>\" She sets herself back on your lap and tells you to go back to meditating.");
			}
			//Converge here, decision time! Does Joy meditate with you successfully or fail and raise your lust? Chance is 20-50%, depending on Joy's intelligence.
			if (rand(100) < flags[kFLAGS.JOY_INTELLIGENCE] + 20) { //Passed, meditation time!
				outputText("\n\nJoy grows still and you begin to concentrate...");
				//Corruption check
				if (player.cor <= 33) {
					outputText("\n\nAs you meditate, you find you're able to clear your mind of all thought, despite having a sexy mouse girl sitting on your " + joySitLoc() + ". A bright light forms in your mind and you focus your will on it; imagining the lingering darkness being removed by this light.");
				}
				else if (player.cor <= 66) {
					outputText("\n\nAs you meditate, you become a bit restless. Sometimes your mind drifts to perverted thoughts; you almost give in and begin to grope the mouse girl sitting on your " + joySitLoc() + ", but you reel yourself in and mentally scold yourself for considering it. You focus on clearing your mind; eventually you're able to calm yourself and meditate in peace.");
				}
				else {
					outputText("\n\nAs you meditate, you tremble in restlessness. Images of dirty, perverted situations fill your mind every second; all of them involving Joy. What you wouldn't give for a good fuck right now... still you remind yourself of the purpose of this meditation, and slowly you regain control of your thoughts; you're not able to stop your dirty mind from conjuring up more depraved fantasies, but they at least have reduced in intensity as well as a quantity...");
				}
				//Libido check
				if (player.lib <= 33) {
					outputText("\n\nYou remain calm as you continue your meditation, oblivious to the world outside. It's kind of relaxing to be able to clear your mind in such a fashion.");
				}
				else if (player.lib <= 66) {
					outputText("\n\nYou try to remain calm as you continue your meditation, but inevitably your sex drive interferes with your concentration. So many things in this world are directed at sex that you find memories of a few situations you've been through assault your mind. You flush with arousal at the memories, but you force yourself to remain calm and slowly you're able calm down your urges.");
				}
				else {
					if (player.gender > 0) {
						outputText("\n\nYou try to remain calm as you continue your meditation, but your sex drive is so huge your ");
						if (player.hasCock()) outputText(player.cockDescript() + " is already hard ");
						if (player.hasCock() && player.hasVagina()) outputText("and");
						if (player.hasVagina()) outputText(player.vaginaDescript() + " is already moist");
						outputText(". Somehow Joy's not noticing or ignoring your squirming, but you can smell her even if your nose is not that good to begin with... she smells so nice... you can barely suppress your urge to hug her and give her a big wet kiss... then ask her to help you with your... needs... but as you think of doing this to her, you wonder if she's sitting on your " + joySitLoc() + " as some kind of test... she also seems so peaceful sitting atop your " + joySitLoc() + "; it inspires you to regain a bit of control and mentally force your ")
						if (player.hasCock()) outputText(player.cockDescript());
						if (player.hasCock() && player.hasVagina()) outputText("and");
						if (player.hasVagina()) outputText(player.vaginaDescript());
						outputText(" to quiet down and stop interfering with your meditation, and slowly you feel you've managed to calm down your urges a bit.");
					}
					else {
						outputText("\n\nYou try to remain calm as you continue your meditation, but your sex drive is so huge you can barely stay put. Despite not having any sexual organs, you squirm so much under Joy you're surprised she doesn't seem to notice it... speaking of Joy... she smells so nice... you can barely suppress your urge to hug her and give her a big wet kiss... then ask her to help you with your... needs... but as you think of doing this to her, you wonder if she's sitting on your " + joySitLoc() + " as some kind of test... she also seems so peaceful sitting atop your " + joySitLoc() + "; it inspires you to regain a bit of control and mentally force yourself to calm down and focus in your meditation, and slowly you feel you've managed to calm down your urges for a bit.");
					}
				}
				outputText("\n\nYou lose track of time while meditating, until you hear what is unmistakably a soft snore from Joy. You gently poke her belly and she hugs you and say sleepily, \"<i>Five more minutes " + player.mf("daddy", "mommy") + ".</i>\"");
				outputText("\n\nYou gently shake her a bit and tell her to wake up; when it does not work you blow inside her ear softly and she jolts up. \"<i>Huh! What... Oh, I guess I must have, like, fallen asleep or something...</i>\" she says. Then she gets up and stretches.");
				if (flags[kFLAGS.JOJO_LAST_MEDITATION] == model.time.days) {
					outputText("\n\nIt's too soon since you last meditated, so you don't get much benefit from it. Still you feel your urges have calmed down a little, despite Joy's antics.");
					dynStats("lus", -30);
				}
				else {
					outputText("\n\nMeditating seems to have helped, and you feel more in control of yourself, despite Joy's antics.");
					dynStats("lus", -30);
					var cleanse:int = -2; //Corruption reduction - faster at high corruption
					if (player.cor > 80)
						cleanse -= 3;
					else if (player.cor > 60)
						cleanse -= 2;
					else if (player.cor > 40)
						cleanse -= 1;
					dynStats("cor", cleanse - player.countCockSocks("alabaster"));
					if (player.str < 45) dynStats("str", 1); //Str boost to 45
					if (player.tou < 45) dynStats("tou", 1); //Tou boost to 45
					if (player.spe < 75) dynStats("spe", 1); //Speed boost to 75
					if (player.inte < 80) dynStats("int", 1); //Int boost to 80
					if (player.lib > 0) dynStats("lib", -1); //Libido lower to 15
					flags[kFLAGS.JOJO_LAST_MEDITATION] = model.time.days;
					if (flags[kFLAGS.JOY_INTELLIGENCE] < 50) flags[kFLAGS.JOY_INTELLIGENCE]++;
				}
				outputText("\n\nYou thank Joy for her help. She yawns, \"<i>Oh... Uh... Like... Anytime [name]...</i>\" she replies groggily, then begins walking towards the nearby stream, perhaps to spray some water on her face... You get up and go about your business.");
			}
			else { //Epic Fail!
				outputText("\n\nJoy just doesn't seem to be able to settle down; she keeps on squirming, wriggling her firm butt so that it slides tantalizingly across your crotch, bouncing idly in place. \"<i>This is, like, so boooring!</i>\" She complains. \"<i>I wanna have some *fun*, [name]! Come on, let's do something, like, naughty...</i>\" She audibly licks her lips at the thought, her tail looping affectionately around your neck.");
				outputText("\n\nYou squirm a bit yourself.");
				if (player.cor <= 33) outputText("\n\nThe idea of having some *fun* with Joy seems to go against the purpose of meditating in the first place...");
				else if (player.cor <= 66) outputText("\n\nSounds like a nice plan for later, but right now shouldn't you be meditating?");
				else outputText("\n\nNow, you are liking where this is going... however... what about meditating?");
				outputText("\n\nYou ask her what about helping you meditate? Is she giving up? Does she not want to help you out?");
				outputText("\n\n\"<i>D'aaaw, but it's SO BORING!</i>\" She whines. \"<i>Like, I just wanna have some fun - I'm too horny to just sit here and' do nothing. C'mon, [name], help a girl out.</i>\" She pleads, grinding her rear purposefully into your crotch, wriggling from side to side as one hand slips into her pants and starts playing with her own genitals.");
				outputText("\n\n(Do you 'help' Joy?)");
				dynStats("lus", 20 + (player.lib / 5) + (player.cor / 10));
				doYesNo(failedMeditateLetsFuck, failedMeditateNoThanks);
				return;
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function failedMeditateLetsFuck():void {
			clearOutput();
			outputText("You tell her you'll 'help' her out.");
			outputText("\n\n\"<i>Alright! Like, let's fuck!</i>\" She cheers, springing up - and hauling you painfully upright in the process because her tail is still looped around your neck, pulling you over onto your front. \"<i>Like, [name], this is no time to be lying down; we got sex to have.</i>\" She scolds when she turns to see what's happened to you.");
			if (player.lust <= 33) dynStats("lus=", 33);
			joySexMenu();
			removeButton(14);
		}
		
		private function failedMeditateNoThanks():void {
			clearOutput();
			outputText("You decide you're not really in the mood right now and grab a hold of her rump; getting both of you up and pushing her away slightly you tell her you're not in the mood right now.");
			outputText("\n\n\"<i>Awww... Like, that's not fair, [name]. I'm sooo horny...</i>\" She pouts, turning on her most sadly adorable look in an effort to break through your resistance. \"<i>Can't we, y'know, have just a quickie? Please...?</i>\" She begs in a childish manner, hands clasped in prayer before her.");
			outputText("\n\nYou tell her you're really not in the mood now and proceed to leave, despite her oh so adorable puppy face... and sexy body... and nice smell... aww, dammit now you're getting horny too... still you soldier on and leave. ");
			dynStats("lus", 20 + (player.lib / 10) + (player.cor / 10));
			doNext(camp.returnToCampUseOneHour);
		}
		
		//------------
		// TRAINING
		//------------
		private function trainWithJoy():void {
			clearOutput();
			outputText("You ask Joy if she'd be willing to help you train; you could use the workout.");
			if (player.lust >= 70) { //Too horny!
				outputText("\n\nThe bimbofied mouse looks you over, a mischievous expression on her face, and makes a show of sniffing the air. \"<i>My oh my, now if my senses aren't, like, telling me lies, you, my naughty little friend, are, like, way too horny to concentrate on training. Let's have some fun instead...</i>\" She coos, posing flirtatiously and waiting to see your response.");
				doYesNo(screwTrainingLetsFuck, screwTrainingButNoThanks);
				return;
			}
			if (player.fatigue > player.maxFatigue() - 40) { //Too tired!
				outputText("\n\nJoy looks you over and shadly shakes her head. \"<i>Like, sorry, [name], but you're too worn out to train with me. Go and, like, get some sleep; when you're rested up, then we'll train, I promise.</i>\"");
				doNext(playerMenu);
				return;
			}
			outputText("\n\n\"<i>Like, sure thing, [name]?</i>\" The bimbofied monk grins, clapping her hands excitedly. \"<i>So, like, what do you want to train? Your strength? Your toughness? Or your speed?</i>\" She asks.");
			menu();
			addButton(0, "Strength", trainStrength);
			addButton(1, "Toughness", trainToughness);
			addButton(2, "Speed", trainSpeed);
			addButton(4, "Nevermind", genericMenu);
		}
		
		private function trainStrength():void {
			clearOutput();
			outputText("You tell Joy that training your strength sounds good, and ask her how does she intend to help you with that?");
			outputText("\n\n\"<i>Like, lemme think a moment...</i>\" She tells you, tapping her lip thoughtfully. Then she grins. \"<i>Okay; the best way to train your muscles is, like, to lift stuff? So, try lifting me.</i>\" She declares proudly.");
			outputText("\n\nAt first you think she's joking but a second look at her makes it clear that she's serious... well it might be worth a try right? You walk towards her and loops one arm behind her back, the other one hooking behind her legs, and then you sweep her off her feet and lift her onto your arms. Joy is not that heavy to begin with, but you can see how it might be strenuous to lift her about.");
			outputText("\n\n\"<i>Eep! Be gentle, [name]!\" She insists, squirming instinctively in your grip.");
			outputText("\n\nYou smirk at her, telling her this is her idea, so you hope she won't regret this.");
			outputText("\n\n\"<i>Like, don't worry about me. You just took me by surprise.</i>\" The bimbo mouse says, repositioning herself to be more comfortable in yours. \"<i>Okey-dokey, lift away!</i>\" She commands.");
			//Strength check
			if (player.str <= 33) { //Low strength
				outputText("\n\nYou begin lifting her and lowering her like a set of weights, but you quickly grow tired and as you try to push for one more press your arms give out and you end up nearly dropping Joy out of your grasp.");
				outputText("\n\n\"<i>Like, come on, [name]; put your back into it... or are you saying I'm fat?</i>\" She pouts.");
				outputText("\n\nFinally your strength gives and you end up dropping Joy on her butt, thankfully she was fairly close to the ground...");
				outputText("\n\nShe winces and rubs her hiney. \"<i>Like, ouch... We'll need to work on that.</i>\" She declares.");
				outputText("\n\nYou apologize and tell her that you'll be more careful in the future.");
				outputText("\n\n\"<i>That's okay. Go and get some rest now; you, like, need to recover.</i>\" She tells you. Picking herself up off the ground, she stretches with a groan. \"<i>That's, like, what I'm going to do.</i>\" She mutters, and walks away.");
			}
			else if (player.str <= 66) { //Medium strength
				outputText("\n\nYou begin lifting her and lowering her like a set of weights; while awkward at first, once you get used to it, you set upon a steady rhythm; although it doesn't help that Joy squirms once in awhile.");
				outputText("\n\n\"<i>Like, come on, [name]; put your back into it... or are you saying I'm fat?</i>\" She pouts.");
				outputText("\n\nYou do as she tells and speed up slightly, going slightly faster.");
				outputText("\n\n\"<i>Like, that's the way, [name]! Keep going!</i>\" She cheers you on. Her tail slithers around to begin brushing teasingly against your crotch.");
				outputText("\n\nSo that's the way she wants to play huh? You think about giving her one hell of a ride, but you don't think you're strong enough to pull it off, so you slide your hand down to her butt and begin groping her every time you lift her up and down, your thumb moving to tease her little rosebud ever so slightly.");
				outputText("\n\nJoy squeaks in delight. \"<i>Oooh! Good, good, you know how to make training fun!</i>\" She arches her butt to present you with better access.");
				outputText("\n\nYou take this opportunity to drop her on her ass, right on the floor, just hard enough to shock her.");
				outputText("\n\n\"<i>Ouch! Hey, what's the deal?</i>\" She whines.");
				outputText("\n\nYou burst out laughing, saying you're sorry but that was too tempting; besides you were getting tired and her teasing was not helping.");
				outputText("\n\nJoy pouts and gets up, rubbing her butt. \"<i>Well, go and, like, get some rest. You're getting much stronger.</i>\" With that said, she walks away.");
				dynStats("lus", 20);
			}
			else {
				outputText("\n\nYou begin lifting her and lowering her like a set of weights; it's a bit awkward, but quite easy actually; once you get used to it, you set upon a steady rhythm.");
				outputText("\n\n\"<i>Like, come on, [name]; put your back into it... or are you saying I'm fat?</i>\" She pouts.");
				outputText("\n\nYou oblige by speeding up the rhythm.");
				outputText("\n\n\"<i>Like, that's the way, [name]! Keep going!</i>\" She cheers you on. Her tail slithers around to begin brushing teasingly against your crotch.");
				outputText("\n\nSo that's how it is huh? Well, you'll just have to give her a ride to remember. When you next lift her you toss her up in the air and back down on your arms.");
				outputText("\n\n\"<i>Whee!</i>\" Joy squeals in delight, clearly not afraid that you might drop her.");
				outputText("\n\nYou grin and keep it at it, throwing her up higher and higher.");
				outputText("\n\nJoy is happy at first, laughing and whooping, but then the jubilance drains away. \"<i>Like, [name]? I... urp... I think I'm gonna be sick...</i>\" She moans.");
				outputText("\n\nWhen you hear her say that you pick her up the next time she drops and gently sets her down on the floor.");
				outputText("\n\nJoy staggers off, swaying from side to side. \"<i>Like... Thanks. You're really getting, like, good at this. Practice won't hurt, but I'm not sure how much, like, better this can actually make you.</i>\"");
				outputText("\n\nSeeing the dizzy mouse wander off makes you wonder if you might have overdone it... so you ask if she's okay?");
				outputText("\n\n\"<i>I'm, like, fine, [name].</i>\" Joy insist, still sounding kind of woozy.");
				outputText("\n\nNevertheless you go to the bimbo mouse and hook an arm around her waist, gently guiding her towards her tent to lay down and rest.");
				outputText("\n\nShe doesn't protest, but instead leans gratefully against you for support.");
				outputText("\n\nOnce she's laying down on her tent you pat her head and tell her to get well soon, then take your leave.");
				dynStats("lus", 20);
			}
			//Increase strength
			if (player.str <= 33) dynStats("str", 0.5);
			if (player.str <= 66) dynStats("str", 0.5);
			if (player.str < 90) dynStats("str", 0.5);
			dynStats("str", 0.5);
			player.changeFatigue(40);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function trainToughness():void {
			clearOutput();
			outputText("You think on it, and suggest that you would like to try and get tougher.");
			outputText("\n\n\"<i>Okay! Now, like, what is a good way of doing that...</i>\" Joy thinks, rubbing her chin. Then finally perks up as an idea hits her. \"<i>I know it! Like, sex takes a lot of energy. So let's, like, have a lot of sex!</i>\" she suggests, proud to have to come to this conclusion.");
			outputText("\n\nYou have to confess " + (player.cor >= 50 ? "with a very great deal of reluctance " : "") + "that, as attractive as the idea sounds, you're not really sure that would give you a lot of actual improvement in your toughness.");
			outputText("\n\n\"<i>Aww... ok, then... let's do some exercises! I'm, like, sure that if you work out a lot you should become tougher!</i>\" she suggests happily.");
			outputText("\n\nYou have to agree, that sounds much better. So, what exercises does she have in mind?");
			outputText("\n\nJoy thinks for a while before saying, \"<i>I'll, like, give you a body rub meant to strengthen your muscles.</i>\"");
			outputText("\n\nThat makes sense to you, so you tell her that you'd like her to do that. What do you need to do in order to help her?");
			outputText("\n\n\"<i>Just, like, lay back and let me do all the work.</i>\"");
			outputText("\n\nYou nod to her, remove your clothes until you are down to your undergarments, reasoning that this will help her rub your muscles, and then lie down.");
			outputText("\n\n\"<i>Okay, if you're, like, starting to feel tired tell me. It's not good to overdo this.</i>\" Then Joy cracks her knuckles and begins to gently trance her hands over one arm, touching and testing the muscles.");
			outputText("\n\nThen she moves to another, doing the same. After she's done, she licks her lips and begins to do the same to your belly and chest (careful not to hurt your " + player.breastDescript(0) + ").");
			outputText("\n\nYou find yourself relaxing; Joy's nimble fingers are very good at this, easing out the tension and loosening knots in your muscles you weren't even aware that you had.");
			outputText("\n\n\"<i>Okay, let's begin!</i>\" Joy happily declares, leaning over you and pressing her generous bosom against your (own/chest). Joy digs her fingers into your " + player.skinFurScales() + ", not only massaging your body, but also molding the muscles inside.");
			outputText("\n\nYou groan against the stimulus, which is sort of painful-but-not-really, but lay still and try to relax, trusting Joy knows what she's doing.");
			outputText("\n\nJoy seems to be enjoying herself, playing with your muscles as if they were putty, as well as rubbing herself against you in ways you're not sure if they are related to the training at all.");
			if (player.cor <= 33) outputText("\n\nAlthough a part of you is certainly enjoying it, you can't help but feel nervous at quite how Joy is rubbing herself against you.");
			else if (player.cor <= 66) outputText("\n\nYou savor both the massage and the delightfully buxom girl/herm rubbing herself in very intriguing ways against you.");
			else outputText("\n\nYou're starting to wish Joy would forget about the massage and just start fucking you; she's certainly making no bones about the fact she wants sex, the horny little bimbo slut.");
			outputText("\n\n\"<i>Like, move your arms up here,</i>\" she says, taking your wrists and bringing your arms over your head, while 'accidentally' suffocating you on her DD-cup breasts. Then, she continues to massage you, slowly sliding down your body with a grin.");
			outputText("\n\nYou can't help but cock an eyebrow at her, wondering what in the world she's thinking. Still, you're not about to disrupt her; who knows? Maybe this is legitimately part of the exercise.");
			outputText("\n\nYou don't have long to wonder that though... \"<i>Okay, like, this might hurt a bit, but it's necessary.</i>\" Then she digs her fingers on your sides painfully.");
			//Toughness check
			if (player.tou <= 33) {
				outputText("\n\nYou let out a cry of pain as her fingers dig into your flesh, thrashing at the surprising level of torment they are inflicting upon you. You try to tough it out, but you simply cannot stand it; you beg Joy to stop.");
				outputText("\n\nJoy gasps at your reaction and stops immediately. \"<i>Sorry, [name]! I'm, like, so sorry! Do you want me to give you a kiss to make it all better?</i>\"");
				outputText("\n\nYou can't help but manage to smile at that and suggest it would be nice. ");
				if (player.cor > 66) outputText("Though you would like to do something a lot more fun than kissing, personally.");
				outputText("\n\nShe grins and grabs your cheeks gently, then gives you a deep smooch. \"<i>Are you, like, feeling better now?</i>\"");
				outputText("\n\nYou smile and tell her that you are. Now, would she kindly get off you? She's heavy. You tell her.");
				outputText("\n\n\"<i>Are you calling me fat!?</i>\" Joy asks, while getting off you.");
				outputText("\n\nYou make a show of looking like you have to think about the answer to that.");
				outputText("\n\n\"<i>Just kidding! I know you're, like, too nice to say that cutie-pie,</i>\" she giggles.");
				outputText("\n\nWith a smile, you rub her between her ears, redress yourself, thank her for trying and leave.");
				outputText("\n\nShe hugs you from behind and says, \"<i>Don't, like, be discouraged [name]. It really is meant to hurt, but if you, like, withstand the pain, you'll get tougher I promise.</i>\"");
				outputText("\n\nYou promise her you'll keep that in mind.");
				player.takeDamage(30);
			}
			else if (player.tou <= 66) {
				outputText("\n\nYou have to struggle to bite back a yell, but you manage to avoid bucking and thrashing around. It hurts, you can't deny it hurts, but you refuse to give in. Eventually, though, the pain is too much and you beg Joy to stop.");
				outputText("\n\nJoy stops and begins rubbing your sides, as if trying to wipe the pain away. \"<i>I'm, like, so sorry [name]! But you were able to, like, put up with it for a while. You're, like, so brave! Little Joyjoy's thinking about rewarding you,</i>\" she suggests with a smile.");
				outputText("\n\nYou can't help but smile back and ask what she has in mind.");
				outputText("\n\nShe holds your cheeks gently and gives you a big kiss on the lips. \"<i>There. Now you, like, have some incentive to try again.</i>\" She grins, getting off you.");
				outputText("\n\nWith a smirk");
				if (player.cor > 66) outputText(", and privately feeling somewhat ripped off")
				outputText(", you thank her, redress yourself and start heading back to your part of the camp.");
				outputText("\n\nJoy hugs you from behind and says, \"<i>I'm, like, really proud of you [name]. If you keep trying you'll, like, be able to withstand the pain and become even tougher.</i>\" Then she releases you and sashays away.");
				player.takeDamage(20);
			}
			else {
				outputText("\n\nYou grunt softly, but the pain is minimal, incapable of seriously phasing your developed muscles. Quietly you sit there, shrugging off the pinpricks as Joy works your body over.");
				outputText("\n\nJoy stops, panting a bit due to the amount of force she applied to your sides. \"<i>Wow, [name]. You managed to withstand all that. You're, like, so tough! I don't even know if I can do anything to, like, help you improve at this point.</i>\"");
				outputText("\n\nYou thank her for trying to help anyway, and gently push her to signal that you'd like her to get off.");
				outputText("\n\nBut Joy won't have it, she hugs you tightly and says, \"<i>not before your reward!</i>\" Then gives you a deep kiss, all the while rubbing herself against you, even invading your mouth with her tongue to tangle with your own.");
				outputText("\n\nYou wonder for a split-second what brought this on, but dismiss it, simply giving in to the kiss.");
				outputText("\n\nJoy moans into the kiss as you begin kissing her back; she doesn't seem to want to stop any time soon.");
				outputText("\n\nFinding yourself quite excited, you reach down to give Joy's pert ass a very interested squeeze; if she wants to start having sex, well, that'd be a fine way to wrap up this 'training', you think.");
				outputText("\n\nThe usually lusty bimbo mouse, however, surprises you by breaking the kiss and jumping off you, licking her lips with a sultry smile.");
				outputText("\n\nConfused, you ask what's going on; you thought she wanted a little fun.");
				outputText("\n\n\"<i>Oh, [name]. I do want to, like, have fun with you. But, like, I also have to give you a reason to train again. Like, I had so much fun groping and rubbing you all over,</i>\" she confesses with a sheepish grin.");
				outputText("\n\nYou can't help but pout and call her a tease, then playfully flick her on the nose.");
				outputText("\n\nJoy giggles and says, \"<i>Like, come train with me again [name].</i>\" Then she gives you a little peck on the cheek and skips away.");
				outputText("\n\nWatching her go, you redress yourself and then head your seperate ways.");
			}
			//Increase toughness
			if (player.tou <= 33) dynStats("tou", 0.5);
			if (player.tou <= 66) dynStats("tou", 0.5);
			if (player.tou < 90) dynStats("tou", 0.5);
			dynStats("tou", 0.5);
			player.changeFatigue(40);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function trainSpeed():void {
			clearOutput();
			outputText("You tell Joy that you really want to try and hone your speed.");
			outputText("\n\n\"<i>Okay, just let me think...</i>\" Joy says, rubbing her chin in deep thought. Then suddenly she perks up as an idea hits her. \"<i>Wait here, [name]. I'll be back in, like, a second!</i>\" she says dashing off.");
			outputText("\n\nYou wonder what it is that she intends, but wait patiently for her return.");
			outputText("\n\nJoy returns briefly later with a bottle of water and a wooden cup, she hands you the cup and pours water in it until it's about to spill. \"<i>There you go!</i>\" she declares happily, setting the bottle of water aside.");
			outputText("\n\nYou take the cup, understanding dawning. You ask if you're going to have to run a course without spilling the water?");
			outputText("\n\nJoy doesn't bother answering you, she simply hooks her hands around your back and grins up to you. \"<i>Now we dance!</i>\" Then she swings her body taking you with her.");
			outputText("\n\nYou are startled, but hasten to follow, striving to avoid spilling the water as she suddenly pulls you out of balance.");
			if (player.spe <= 33) {
				outputText("\n\nYou try your hardest, but as the surprisingly graceful mouse swings you and dips you and takes you through steps you've only heard of in stories back in Ingnam, it's no surprise that you end up accidentally dropping the entire cup onto the ground underfoot.");
				outputText("\n\nJoy stops to gaze at the cup on the floor. \"<i>Awww... you, like, dropped the whole cup?</i>\" she asks with a pout.");
				outputText("\n\nYou apologise, but point out you were expecting to run with her, not dance with her.");
				outputText("\n\n\"<i>You're, like, supposed to be ready for anything... well we can always try again right?</i>\" she says with a smile.");
				outputText("\n\nYou tell her that's true, and promise her you'll try and be better prepared the next time.");
				outputText("\n\nShe giggles and gives you a little peck on the cheek for encouragement.");
			}
			else if (player.spe <= 66) {
				outputText("\n\nYou try your hardest to avoid spilling things while, at the same time, keeping up with Joy. She's a very graceful thing; you never would have thought of her as a dancer before. Luckily, you're quick and graceful enough to keep up with her without too much difficulty, but the fancier moves mean you still spill at least a third of the water in your cup.");
				outputText("\n\nJoy pants in exhaustion. \"<i>Like, that was fun!</i>\" she declares, then gazes at the cup of water in your hand. She quickly swipes it and drinks all the water inside. \"<i>Thanks! I, like, really needed that!</i>\" she declares.");
				outputText("\n\nFeeling torn between amusement and indignation, you pointed out that Joy was supposed to at least check and see how much water you had spilled before drinking it.");
				outputText("\n\n\"<i>Oh... right...</i>\" she says, rubbing her chin and looking down; that's when she notices some wet patches in the ground. \"<i>Aha! You dropped some water, so you can still improve!</i>\"");
				outputText("\n\nYou concede she has a point. Still, she should at least look and see how much you spilled before just saying that, and you tell her this, playfully poking her pointy nose for emphasis.");
				outputText("\n\n\"<i>Like, all the water in the cup is gone, so I can't really tell...</i>\" she says sheepishly.");
				outputText("\n\nAnd who's fault is that, you smirk at her. Still, she's a good dance partner, so you'll forgive her, you add, ruffling her hair.");
				outputText("\n\nShe leans against your hand and smiles. \"<i>Let's try that again sometime.</i>\"");
				outputText("\n\nYou tell her that you'd like that, then walk away.");
			}
			else {
				outputText("\n\nYou may have been surprised by Joy's choice of training methods, but you surprise yourself with how easily you take to it. Quick and graceful, the two of you dance all around the camp, and no matter what happens, you never spill more than a drop or two of water.");
				outputText("\n\nJoy pants in exhaustion. \"<i>Like, that was fun!</i>\" she declares, then gazes at the cup of water in your hand. She quickly swipes it and drinks all the water inside. \"<i>Thanks! I, like, really needed that!</i>\" she declares.");
				outputText("\n\nFeeling torn between amusement and indignation, you pointed out that Joy was supposed to at least check and see how much water you had spilled before drinking it. \"<i>Oh... right...</i>\" she says, rubbing her chin and looking down; she looks around, but does not see any wet patches on the ground. \"<i>There's no water on the ground, so, like, you did great!</i>\"");
				outputText("\n\nWith wry smile, you tap your foot and ask what she thought of your dancing technique.");
				outputText("\n\n\"<i>Like, you were great, [name]! Little Joyjoy would love to dance with you again,</i>\" she says slowly shaking her waist and moving closer to you.");
				outputText("\n\nYou smile at her, tell her it's a date, then nimbly twirl out of her grip and dance away, looking back over your shoulder to see how she's taking your teasing.");
				outputText("\n\nJoy pouts and looks at you with the best puppy eyes she can manage.");
				outputText("\n\nYou give her a teasing wave of your finger and walk back to camp.");
			}
			//Increase speed
			if (player.spe <= 33) dynStats("spe", 0.5);
			if (player.spe <= 66) dynStats("spe", 0.5);
			if (player.spe < 90) dynStats("spe", 0.5);
			dynStats("spe", 0.5);
			player.changeFatigue(40);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function screwTrainingLetsFuck():void {
			clearOutput();
			outputText("You ARE feeling pretty horny right now... you smile at Joy and tell her having fun sounds good.");
			outputText("\n\nThe mouse grins at you. \"<i>Well, like, what do you wanna do?</i>\" She coos, shaking her ass impatiently.");
			joySexMenu();
		}
		
		private function screwTrainingButNoThanks():void {
			clearOutput();
			outputText("You tell Joy that despite being quite horny, you really don't want to have sex at the moment.");
			outputText("\n\n\"<i>Like, aww, why not?</i>\" The bimbo mouse pouts. \"<i>Oh, well, it's, like, your choice.</i>\" She sniffs, turning her back on you disdainfully.");
			doNext(playerMenu);
		}
		
		//------------
		// GIVE ITEMS
		//------------
		private function giveItemsToJoy():void {
			var hasValidItems:Boolean = false;
			var buttonPos:int = 0;
			clearOutput();
			outputText("Joy jumps and claps her hands in apparent excitement. \"<i>Oh goodie! What is it!?</i>\" she asks excitedly.");
			menu();
			//Scholar's Tea
			if (flags[kFLAGS.JOY_INTELLIGENCE] < 50) {
				if (player.hasItem(consumables.SMART_T)) {
					addButton(buttonPos++, consumables.SMART_T.shortName, giveJoyAScholarsTea);
					hasValidItems = true;
				}
			}
			else outputText("\n\n<b>Joy is already as smart as she's ever going to get.</b>");
			//Incubi Draft
			if (player.hasItem(consumables.INCUBID) || player.hasItem(consumables.P_DRAFT)) {
				if (player.hasItem(consumables.P_DRAFT)) addButton(buttonPos++, consumables.P_DRAFT.shortName, giveJoyAnIncubiDraft, true);
				else addButton(buttonPos++, consumables.INCUBID.shortName, giveJoyAnIncubiDraft, false);
				hasValidItems = true;
			}
			//Succubi Milk
			if (player.hasItem(consumables.SUCMILK) || player.hasItem(consumables.P_S_MLK)) {
				if (player.hasItem(consumables.P_S_MLK)) addButton(buttonPos++, consumables.P_S_MLK.shortName, giveJoyASuccubiMilk, true);
				else addButton(buttonPos++, consumables.SUCMILK.shortName, giveJoyASuccubiMilk, false);
				hasValidItems = true;
			}
			//Pink Egg
			if (flags[kFLAGS.JOY_COCK_FONDNESS] < 10) {
				if (joyHasCock()) {
					if (player.hasItem(consumables.PINKEGG)) {
						addButton(buttonPos++, consumables.PINKEGG.shortName, giveJoyAPinkEgg, false);
						hasValidItems = true;
					}
					if (player.hasItem(consumables.L_PNKEG)) {
						addButton(buttonPos++, consumables.L_PNKEG.shortName, giveJoyAPinkEgg, true);
						hasValidItems = true;
					}
					outputText("\n\nIf you have a pink egg of any size, you could remove Joy's cock although she won't be very happy.");
				}
				else outputText("\n\n<b>Joy doesn't have a penis. There's no need to give her another pink egg.</b>");
			}
			else outputText("\n\n<b>Joy seems to be unwilling to eat any more pink eggs. She seems to like having a penis." + (joyHasCock() ? "" : " That is, if she has one.") + "</b>");
			//Blue Egg
			if (flags[kFLAGS.JOY_EATEN_BLUE_EGG] < 1) {
				if (player.hasItem(consumables.BLUEEGG)) {
					addButton(buttonPos++, consumables.BLUEEGG.shortName, giveJoyABlueEgg, false);
					hasValidItems = true;
				}
				if (player.hasItem(consumables.L_BLUEG)) {
					addButton(buttonPos++, consumables.L_BLUEG.shortName, giveJoyABlueEgg, true);
					hasValidItems = true;
				}
				outputText("\n\nIf you have a blue egg of any size, you could reduce Joy's breast size to minimum.");
			}
			else outputText("\n\n<b>Joy seems to be unwilling to eat another blue egg. She just doesn't like it. Perhaps you can give her Reducto instead?</b>");
			//Lactaid
			if (player.hasItem(consumables.LACTAID)) {
				addButton(buttonPos++, consumables.LACTAID.shortName, giveJoyALactaidYummyMilkTime);
				hasValidItems = true;
			}
			outputText("\n\nIf you have a bottle of Lactaid, you could have Joy produce some yummy milk for you to drink.");
			//Reducto
			if (player.hasItem(consumables.REDUCTO)) {
				addButton(buttonPos++, consumables.REDUCTO.shortName, giveJoyAReducto);
				hasValidItems = true;
			}
			outputText("\n\nIf you have some Reducto, you could shrink Joy's breasts" + joyHasCockText(" and her cock") + ".");
			addButton(14, "Back", genericMenu);
			if (!hasValidItems) {
				outputText("\n\nUnfortunately you actually have nothing that she could use, so you apologize.");
				outputText("\n\nJoy playfully pouts at you, \"<i>Tease!</i>\"");
				doNext(genericMenu);
			}
		}
		
		//Scholar's Tea
		private function giveJoyAScholarsTea():void {
			clearOutput();
			player.consumeItem(consumables.SMART_T, 1);
			outputText("You hold up the small pouch of aromatic herbs and dried leaves and ask if Joy would like to have some tea. The bimbo mouse smiles and nods eagerly, and the two of you soon have a small fire blazing to heat up the water in which the tea is steeped. Joy takes the cup you offer her with surprising grace, closing her eyes and inhaling deeply through her nose. \"<i>That smells, like, so good...</i>\" She murmurs, then she slurps it down with obvious enjoyment. You watch as she drinks every last drop, but other than a curiously furrowed brow, nothing seems to happen. \"<i>My head feels all tingly.</i>\" She notes.");
			outputText("\n\nStill, nothing about her seems to have changed, though... does her gaze look a little sharper? Her eyes a little clearer? Wondering if it's had any effect on her at all, you politely take your leave.");
			if (flags[kFLAGS.JOY_INTELLIGENCE] < 40) flags[kFLAGS.JOY_INTELLIGENCE] += 2;
			else flags[kFLAGS.JOY_INTELLIGENCE]++;
			doNext(genericMenu);
		}
		
		//Incubi Draft
		private function giveJoyAnIncubiDraft(purified:Boolean = false):void {
			clearOutput();
			outputText("You hand Joy " + (purified ? "a purified Incubus Draft" : "an Incubus Draft") + " and tell her you'd like her to drink it.");
			if (!purified) { //She won't accept tainted ones.
				outputText("\n\n\"<i>Ewww! This has, like, that black icky stuff all over it! It's gross!</i>\" she tells pushing the vial back into your hands and making a face. Looks like she'll only accept it if it's purified.");
				doNext(genericMenu);
				return;
			}
			else {
				if (joyHasCock()) { //If Joy has a cock...
					outputText("\n\nShe sniffs it and squints her eyes at it. \"<i>Like, I think this will make my funstick bigger. Are you sure you want that [name]?</i>\"");
				}
				else {
					outputText("\n\nShe sniffs it and squints her eyes at it. \"<i>Like, I think this could help me get my funstick back. Are you sure you want that [name]?\"");
				}
				doYesNo(giveJoyAnIncubiDraftForReal, dontGiveJoyAnIncubiDraft);
			}
		}
		private function giveJoyAnIncubiDraftForReal():void {
			clearOutput();
			player.consumeItem(consumables.P_DRAFT, 1);
			if (joyHasCock()) { //Joy already has cock.
				if (flags[kFLAGS.JOY_COCK_SIZE] >= 8.5) { //Maxed cock size.
					outputText("\"<i>Yay! Big funsticks!</i>\" she exclaims excitedly, before chugging the potion. She moans as her bulge grows bigger, the pulls her shorts down so you can see her hardening shaft. Joy looks at her new member and a frown crosses her face. \"<i>Like, it's too big.</i>\" She grumbles. \"<i>It's nice to have it big, but now it's all ugly; it needs to be smaller.</i>\" As she says this, she continues to stroke it, and you see her hands start to glow, right before her cock begins to shrink. Finally, it stops at where it originally was. \"<i>That's totally better.</i>\" She smiles, continuing to stroke it. You decide to leave her for the moment.");
				}
				else { //Cock size not at maximum.
					outputText("\"<i>Yay! Big funsticks!</i>\" she exclaims excitedly, before chugging the potion. She moans as her bulge grows bigger; then pulls her shorts down so you can see her hardening shaft. Once it's fully hard it grows a bit more, before stopping; curiously her balls also seem to grow a bit larger. Then she starts playing with her, now enlarged, cock; and you decide to leave her to get acquainted with her newly enlarged 'funstick'.");
					flags[kFLAGS.JOY_COCK_SIZE]++; //Grow by 1 inch. This will also make her cock thicker by 0.1 inches and if large enough, her balls will grow with it.
				}
			}
			else { //Joy doesn't have a cock.
				outputText("Joy chugs the potion down, then moans as a bulge begins forming on her crotch. She nearly tears her shorts off and you both watch as an average dick begins growing in her crotch, erect and throbbing. Shortly after a pair of balls contained in a fuzzy sack forms below; then a fuzzy sheath envelops her shaft and a bead of pre forms on her tip.");
				outputText("\n\n\"<i>Hurray! My funstick is back! Even my funorbs are back! Yay!</i>\" she exclaims excitedly before deciding to play with her newly regained appendages. You decide to leave her to get reacquainted with her missing parts.");
				flags[kFLAGS.JOY_COCK_SIZE] = 5.5; //She grows a new cock, 5.5 inches long and 1.5 inches thick.
			}
			doNext(genericMenu);
		}
		private function dontGiveJoyAnIncubiDraft():void {
			clearOutput();
			outputText("You tell her you changed your mind and get your vial back. Joy gives you a disappointed \"<i>Dawww...</i>\"");
			doNext(genericMenu);
		}
		
		//Succubi Milk
		private function giveJoyASuccubiMilk(purified:Boolean = false):void {
			clearOutput();
			outputText("You hand Joy a " + (purified ? "purified Succubi's Milk" : "Succubi's Milk") + " and tell her you'd like her to drink it.");
			if (!purified) { //She won't accept tainted ones.
				outputText("\n\n\"<i>Ewww! This has, like, that black icky stuff all over it! It's gross!</i>\" she tells pushing the vial back into your hands and making a face. Looks like she'll only accept it if it's purified.");
				doNext(genericMenu);
				return;
			}
			else {
				outputText("She sniffs it and squints her eyes at it. \"<i>Like, I don't know what this will do... maybe it'll make me, like, wetter? Are you sure you want that [name]?</i>\"");
				doYesNo(giveJoyASuccubiMilkForReal, dontGiveJoyASuccubiMilk);
			}
		}
		private function giveJoyASuccubiMilkForReal():void {
			clearOutput();
			player.consumeItem(consumables.P_S_MLK, 1);
			outputText("Joy chugs the potion down, then moans as a wet spot begins forming on her shorts. She barely manages to remove it before a huge flood of girlcum escapes her drooling vagina; she squeaks and moans as more and more juices escape her clenching snatch. ");
			if (flags[kFLAGS.JOY_VAGINAL_WETNESS] >= 5) { //Maxed vaginal wetness
				outputText("Once it's over you can see it looks as wet as it can get.");
			}
			else {
				outputText("Once it's over you can see it looks wetter than normal.");
				flags[kFLAGS.JOY_VAGINAL_WETNESS]++;
			}
			if (flags[kFLAGS.JOY_BREAST_SIZE] >= BREAST_CUP_G) { //Jojo has maxed breast size.
				outputText("\n\nHer top seems to grow tight as her generous " + joyBreastDescript() + " grows. Her tightly fitting robe strains to hold the " + joyBreastDescript() + " inside, until it pops and jumps out. Joy massages her newly grown boobies. \"<i>I think this might, like, be too big...</i>\" she begins running her hands all over her boobs, a soft white glow coming off them, and slowly you see her breasts shrinking back to their previous size. \"<i>There! Much better now! Aren't my boobies, like, the cutests?</i>\" she asks happily, bouncing them from side to side in her hands.");
				outputText("\n\nOnce she's done playing with her breasts she turns to you and says, \"<i>That was, like, so good! Do you have more, [name]?</i>\" she asks, then adds, \"<i>you know that if you want to make me wet you don't, like, need any potions for that right, sexy?</i>\" she says seductively. Then begins playing with her wet vagina and breasts; you decide to leave her alone for the moment.");
			}
			else {
				outputText("\n\nHer top seems to grow tight as her generous " + joyBreastDescript() + " grows. Her tightly fitting robe strains to hold the " + joyBreastDescript() + " inside, until it pops and jumps out. Joy massages her newly grown boobies. \"<i>My, boobies! Look at how cute they are!</i>\" she says happily, bouncing them from side to side in her hands.");
				outputText("\n\nOnce she's done playing with her breasts she turns to you and says, \"<i>That was, like, so good! Do you have more, [name]?</i>\" she asks, then adds, \"<i>you know that if you want to make me wet you don't, like, need any potions for that right, sexy?</i>\" she says seductively. \"<i>But I love my new boobies! I'll make sure to thank you properly later,</i>\" she says with a sultry stare; then begins playing with her wet vagina and bigger breasts; you decide to leave her alone for the moment.");
				flags[kFLAGS.JOY_BREAST_SIZE]++;
			}
			doNext(genericMenu);
		}
		private function dontGiveJoyASuccubiMilk():void {
			clearOutput();
			outputText("You tell her you changed your mind and get your vial back. Joy gives you a disappointed \"<i>Dawww...</i>\"");
			doNext(genericMenu);
		}
		
		//Pink Egg
		private function giveJoyAPinkEgg(large:Boolean = false):void {
			clearOutput();
			outputText("You hand Joy a " + (large ? "large pink egg" : "pink egg") + " and tell her you want her to eat it.");
			outputText("The bimbo mouse-herm looks at it and sniffs it. \"<i>Like, I dunno, [name]... I've got this odd feeling that it'll, like, remove my boy parts. I kinda like having them too, y'know; it means there's more fun we can do. Are you, y'know, sure you want me to eat this?</i>\"");
			menu();
			doYesNo(createCallBackFunction(giveJoyAPinkEggForRealYouMonster, large), dontGiveJoyAPinkEggThanksGoodness);
		}
		private function giveJoyAPinkEggForRealYouMonster(large:Boolean = false):void {
			clearOutput();
			if (large) player.consumeItem(consumables.L_PNKEG, 1);
			else player.consumeItem(consumables.PINKEGG, 1);
			outputText("You tell Joy that you do want her to eat it.");
			outputText("\n\n\"<i>Like, okay, here goes...</i>\" She cracks the egg and gulps down the yolk, dropping the shell on the ground and giving out a throaty moan. As you watch, the bulge in her shorts shrinks smaller and smaller, until her crotch is completely flat. As if to confirm your suspicions, Joy pulls down her shorts and starts to feel the pink vagina that is now the only sexual organ present. \"<i>Aw... now I don't have a funstick anymore. I won't ever be able to grow it back, you know.</i>\" She tells you. She then starts to probe the interior of her sex, and you decide to leave her to get acquainted with her new body.");
			flags[kFLAGS.JOY_COCK_SIZE] = 0;
			incrementJoysCockFondness(1);
			if (player.cor < 25) dynStats("cor", 1); //You monster!
			doNext(genericMenu);
		}
		private function dontGiveJoyAPinkEggThanksGoodness():void {
			clearOutput();
			outputText("You decide you'd rather she didn't and tell her so. The bimbo mouse happily gives you the egg back.");
			doNext(genericMenu);
		}
		
		//Blue Egg
		private function giveJoyABlueEgg(large:Boolean = false):void {
			clearOutput();
			if (large) player.consumeItem(consumables.L_BLUEG, 1);
			else player.consumeItem(consumables.BLUEEGG, 1);
			outputText("You hand Joy a " + (large ? "large blue egg" : "blue egg") + " and ask her to eat it for you. She sniffs it experimentally, then cracks it open and sucks the yolk down, shuddering with disgust. \"<i>Blech! That tastes awful!</i>\" She complains, sticking her tongue out for emphasis. Then she shudders, and gives a squeak of shock; and you can see why - her breasts are shrinking! As you watch, her chest completely flattens itself out... then, a few moments later, it starts bubbling out again until her DD-cups are bouncing proudly on her chest once more, straining against her shirt even as her shorts are soaked by feminine fluid. She shivers and gives you a flat look. \"<i>Like, I don't know what you were hoping would happen, but that felt totally nasty. Please don't do it again, kay?</i>\" She asks.");
			outputText("You promise you'll keep it in mind and leave her alone as she thankfully jiggles her newly-restored bosom.");
			flags[kFLAGS.JOY_BREAST_SIZE] = BREAST_CUP_DD;
			flags[kFLAGS.JOY_EATEN_BLUE_EGG]++;
			doNext(genericMenu);
		}
		
		//Lactaid
		private function giveJoyALactaidYummyMilkTime():void {
			clearOutput();
			player.consumeItem(consumables.LACTAID, 1);
			outputText("You hand Joy a vial of Lactaid and tell her you'd like her to drink it.");
			outputText("\n\nJoy opens it and sniffs the fluid inside. ");
			if (flags[kFLAGS.JOY_LACTAID_MILKED_COUNTER] == 0) outputText("\"<i>I've never seen something like this before. Still, if you're sure.</i>\"");
			else outputText("\"<i>You want to drink my milk again? Okay!</i>\" She smiles, absently fondling one breast in anticipation.");
			outputText("\n\nShe raises the vial aloft and then chugs it down, drinking it dry and then idly discarding it. For a few seconds, nothing happens, then ");
			if (flags[kFLAGS.JOY_LACTAID_MILKED_COUNTER] == 0) outputText("she furrows her brow in confusion, worry crossing her features. \"<i>[name]? Like, my boobies feel really funny... all tingly.</i>\"");
			else outputText("she grins widely. \"<i>Oooh, here it comes, all that yummy milk is starting to bubble up inside my little boobies!</i>\"");
			outputText("\n\nYou open her robes and take a closer look and see her nipples hardening; shortly after her boobs erupt into your face, some of her milk leaking into your mouth; Joy squeaks in surprise at the sudden growth and falls on her butt. The taste is sweet and rich, it has a creamy texture and you think you would mind getting another taste... but first you need to check on Joy. She is sitting on the floor with " + (flags[kFLAGS.JOY_BREAST_SIZE] >= 10 ? "HUGE" : "large") + " breasts, at least " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE] + 6) + " you estimate. You ask her if she's alright.");
			if (flags[kFLAGS.JOY_LACTAID_MILKED_COUNTER] == 0) {
				outputText("\"<i>I'm, like, totally fine, [name]... Whoa, my boobies got ");
				if (flags[kFLAGS.JOY_BREAST_SIZE] < 7) outputText("a little");
				else if (flags[kFLAGS.JOY_BREAST_SIZE] < 12) outputText("pretty");
				else outputText("really");
				outputText(" big, didn't they? They feel sort of funny, too.</i>\" She states, and, before you can say anything, squeezes them, causing milk to spurt out of her nipples. \"<i>...Wow! I'm full of milk... I'm a mouse-cow.</i>\" She giggles.");
			}
			else outputText("\"<i>Never better, [name]. Don't you think my boobies look so nice all fat and full with milk?</i>\" She laughs;")
			outputText("; then she pouts. \"<i>But my milky titties are sooo heavy now. I don't think I can get up. [name]? Won't you help me? Please?</i>\" She asks.");
			if (player.cor <= 33) outputText("\n\nWell... she can barely stand as it is, so you agree.");
			else if (player.cor <= 66) outputText("\n\nHer milk tasted really good and you're eager to try more, so you agree.");
			else outputText("\n\nMilking a cow-mouse seems like fun, so you eagerly agree.");
			outputText("\n\n\"<i>Well then, sexy, if you're so eager, what are you waiting for?</i>\" Joy purrs, leaning on her huge breasts with a coy smile on her face, her tail swaying gently behind her with its top curled into a strangely heart-like shape...");
			outputText("\n\nYou approach the first of Joy milky teats and bring your mouth around a leaking nipple; gently you close your mouth around it and give the nipple a little flick with your " + player.tongueDescript() + ", then begin suckling gently, enjoying the rich flavor and texture of Joy's milk.");
			outputText("\n\nThe mouse moans faintly; partly in pleasure, partly from relief. \"<i>Like, that feels sooo good...</i>\" She murmurs to you, or maybe to herself.");
			if (player.cor <= 33) outputText("\n\nYou keep suckling her, just enjoying the delicious milk that pours into your mouth. You feel completely relaxed, it's almost like this world's problems was a far-away memory...");
			else if (player.cor <= 66) outputText("\n\nYou keep suckling from her, the erotism of the act is not lost to you as her delicious milk pours into your mouth, yet... you can't help but relax, rather than get excited at the act of drinking Joy's milk; it almost feels like this world's problems was a far away-memory...");
			else outputText("\n\nYou keep suckling from her, your mouth forming into a smile even as you grow aroused. However, drinking for her like this is so... relaxing... the more you suckle the better you feel, and suddenly the act is not so arousing any more... but it still feels good, almost like this world's problems was a far-away memory...");
			outputText("\n\nYou're so relaxed that you barely feel the breast shrinking... in fact, you don't even feel when her engorged nipple shrinks back to its usual size or stops leaking milk on your mouth.");
			outputText("\n\n\"<i>Like... Don't leave me all lopsided, [name]; I've still got another boobie full of yummy milk for you.</i>\" Joy titters, stroking your cheek in an affectionate manner.");
			outputText("\n\nYou snap out of your trance, a bit embarrassed about forgetting her other delicious, full, milky teat... You release her current nipple and lick our lips, breaking a small strand of saliva that links your mouth to her nipple. Then you gently attach your mouth onto her other nipple and resume your suckling.");
			outputText("\n\nJoy moans again and strokes your cheek once more, then she starts to gently knead her breast in order to help you coax more milk from it.");
			if (player.lib <= 33) outputText("\n\nJoy's strokes are comforting; you feel yourself gently tipping your head towards her strokes, even as you nurse from her. You wish you could feel like this more often...");
			else if (player.lib <= 66) outputText("\n\nJoy's strokes are comforting; for a moment you're able to forget completely about sex. Even if sex does feel good and you like it plenty; right now the feel of Joy's gently strokes as you nurse from her is the best feeling in the world. You wish you could feel like this more often...");
			else outputText("\n\nJoy's strokes are comforting; even though she has a very sexy body, right now she feels almost... motherly... maybe she's a MILF? No... that doesn't matter... all that matter is that right now you're both enjoying yourselves and each other, surprisingly you're both doing so in non-sexual way; which is weird but not unwelcome. You wish you could feel like this more often...");
			outputText("\n\nBetween Joy's soft stroking and her delicious warm milk, it's a wonder you don't fall asleep. Yet, once more, you barely register her shrinking breast, or her shrinking nipple, or even the shrinking flow of milk...");
			outputText("\n\nJoy herself barely seems to notice it; her only reaction is to stop stroking your cheek and instead embrace you, snuggling up to you as best she can, once her bust shrinks enough to allow her to reach you. However, she's also the one who comes to her senses first. \"<i>Aww... All milked out.</i>\" She complains. Then she giggles. \"<i>Oh well, it was, like, super nice to do that with you... heh, [name]? [name]? Wake up, [name] - Joyjoy's got no milk left now, silly.</i>\" She teases you.");
			outputText("\n\nYou snap out of your reverie and release her nipple almost reluctantly. Then you get up and help Joy up as well, closing her robes back for her.");
			outputText("\n\nHer tail waving happily behind her, the " + (joyHasCock() ? "herm" : "female") + " mouse unintentionally poses before you as she examines her breasts to be sure they've returned to their original size. \"<i>Like, we should do that again, sometime.</i>\" She tells you.");
			outputText("\n\nYou're inclined to agree, but right now you feel you should get back to your business, so you wave her goodbye and leave.");
			//Refill hunger, restore HP and fatigue, gain lust
			var refillAmount:int = (flags[kFLAGS.JOY_BREAST_SIZE] + 6) * 5;
			if (refillAmount > (120 - player.hunger)) refillAmount = (120 - player.hunger); //Constrain max weight gain to +2.
			player.refillHunger(refillAmount);
			player.changeFatigue(-40);
			HPChange(50 + player.maxHP() / 5, false);
			dynStats("lus", 20 + (player.lib / 5));
			//Libido reduction
			dynStats("lib", -1);
			if (player.lib > 33) dynStats("lib", -1);
			if (player.lib > 66) dynStats("lib", -1);
			//Corruption reduction
			dynStats("cor", -1);
			if (player.cor > 33) dynStats("cor", -1);
			if (player.cor > 66) dynStats("cor", -1);
			flags[kFLAGS.JOY_LACTAID_MILKED_COUNTER]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Reducto
		private function giveJoyAReducto():void {
			clearOutput();
			outputText("You hand Joy a salve marked as 'Reducto' and tell her that you'd like her to shrink her body parts.");
			outputText("\n\n\"Do you want me to, like, make my boobies smaller?" + joyHasCockText(" Or make my funstick smaller? Is it too big for you?") + "\" Joy asks, teasingly.");
			menu();
			addButton(0, "Breasts", reductoJoysBreasts);
			addButton(1, "Cock", reductoJoysCock);
			addButton(4, "Nevermind", genericMenu);
		}
		private function reductoJoysBreasts():void {
			clearOutput();
			player.consumeItem(consumables.REDUCTO, 1);
			outputText("You tell Joy that she could shrink her breasts.");
			outputText("\n\n\"<i>Okay! But won't you, like, miss me having bigger boobies?</i>\" Joy teases. Then she opens up her robes and applies Reducto all over her breasts and makes a disgusted expression. \"<i>That pasty thing smells, like, awful! And look at my boobies go!</i>\" Joy exclaims.");
			if (flags[kFLAGS.JOY_BREAST_SIZE] < BREAST_CUP_DD) {
				outputText("\n\nNothing happens. \"<i>They're the same size? Why would you want me to, like, get rid of these boobies? They're fun and soft! They'll stay with me!</i>\" Joy teases and giggles.");
				flags[kFLAGS.JOY_BREAST_SIZE] = BREAST_CUP_DD;
			}
			else {
				outputText("\n\nHer breasts begin shrinking until they appear to have lost a couple of breast sizes. \"<i>I feel, like, a bit better! My boobies feel lighter now.</i>\" Joy smiles. Her tail wiggles excitedly.");
				flags[kFLAGS.JOY_BREAST_SIZE]--;
			}
			doNext(genericMenu);
		}
		private function reductoJoysCock():void {
			clearOutput();
			player.consumeItem(consumables.REDUCTO, 1);
			outputText("You tell Joy that she could shrink her cock.");
			outputText("\n\n\"<i>My funstick is, like, too big for you?</i>\" Joy teases. Then she removes her shorts and applies Reducto all over her cock and makes a disgusted expression. \"<i>That pasty thing smells, like, awful! And look at my funstick go!</i>\"");
			if (flags[kFLAGS.JOY_COCK_SIZE] < 5.5) {
				outputText("Nothing seems to happen. \"<i>I'm fine with my funstick. Like, why would you want my funstick to be smaller?</i>\" Joy asks in a teasing manner.");
				flags[kFLAGS.JOY_COCK_SIZE] = 5.5;
			}
			else {
				outputText("Her cock begins to shrink until it has lost an inch. \"<i>My funstick is, like, smaller! Think you can handle my size better?</i>\" Joy asks in a teasing manner.");
				flags[kFLAGS.JOY_COCK_SIZE]--;
			}
			doNext(genericMenu);
		}
		
		//------------
		// SEX SCENES
		//------------
		private function initiateSexWithJoy():void {
			clearOutput();
			if (player.lust < 33) {
				outputText("You consider telling Joy you're up for some fooling around, but truth is you're not really in the mood...");
				outputText("\n\nMaybe you should try again when you're a bit hornier?");
				doNext(genericMenu);
				return;
			}
			outputText("You tell Joy you're in the mood for some fun.");
			outputText("\n\nJoy giggles, her tail curling into a heart-shape behind her head. \"<i>Ooh, is that right, sexy? Well, maybe, if you're lucky, little Joyjoy is in the mood to have some fun with you...</i>\" She purrs, sauntering towards you, hands reaching out to trail meaningfully down your " + player.chestDesc() + ".");
			if (player.lib <= 33) {
				outputText("\n\nYou tell her that if she's not in the mood, you'll just find another way to relieve your... umm... urges.");
				outputText("\n\nJoy gasps in horror. \"<i>No, no! I, like, wanna do it - I wanna do it real bad!</i>\" She pleads, throwing herself into your arms to emphasise her point.");
				outputText("\n\nYou laugh at her reaction and release her... Now what do you feel like doing?");
			}
			else if (player.lib <= 66) {
				outputText("\n\nYou ask her when is she not in the mood?");
				outputText("\n\n\"<i>Like, how could I not want to bang a sexy thing like you?</i>\" She giggles.");
				outputText("\n\nYou laugh at her reply... Now what do you feel like doing?");
			}
			else {
				outputText("\n\nYou tell her that's just mean! You come to her for help and she sends you away?");
				outputText("\n\nThe bimbo mouse blinks at you. \"<i>Like... I thought I was just playing, y'know? I didn't think you'd actually, like, think I wasn't horny myself.</i>\" She confesses.");
				outputText("\n\nYou call her a big chested bully, you were imagining all the good sex you two were going to have... but then she teases you like that? You turn around and put your arm over your eyes, pretending to cry.");
				outputText("\n\n\"<i>Waah! Please, I'm sorry, I didn't mean it!</i>\" She begs, approaching you in an attempt to fix thing.");
				outputText("\n\nYou surprise her by quickly turning around and groping her breasts while kissing her deeply, then jumping away before she can even react. You give her a big smile as you do this.");
				outputText("\n\n\"<i>Like, that's so not funny, [name]!</i>\" She scolds, but she's smiling too hugely in relief to really come off in a serious fashion.");
				outputText("\n\nYou laugh at her reaction... Now what to do?");
			}
			if (player.inRut && player.hasCock()) {
				outputText("\n\nShe stops and sniffs the air. \"<i>That smell... ooh... that's the yummy smell of a red-hot prime stud, ready to breed lots of little mousies in a Joy's hungry belly.</i>\" She titters, licking her lips and staring " + player.clothedOrNakedLower("a hole straight through your [armor]", "directly") + " at your [cock].");
				outputText("\n\nAs horny as you are, you too undress her with your eyes. Imagining her fertile, " + joyPussyDescript() + " just asking for a " + player.cockDescript() + " to pound it full off spunk. "); 
				if (player.clothedOrNakedLower("clothed", "naked") == "clothed" && (player.armor != armors.LTHCARM && player.lowerGarment != UndergarmentLib.NOTHING)) outputText("You feel your " + player.armorDescript() + " strain against your [cock]; your bulge completely visible to Joy.");
				outputText("\n\nJoy licks her lips, and judging by her hungry stare; there's no question she's ready to go, it's just up to you to decide what you do.");
			}
			if (player.inHeat && player.hasVagina() && joyHasCock()) {
				outputText("\n\nShe stops and sniffs the air. \"<i>Mmm... I smell a juicy ripe oven, ready for Joy to be shoving in lots and lots of cream so we can make lots and lots of little baby mousies!</i>\" She cries, clapping her hands in delight, cock visibly straining against her shorts and pre staining their front.");
				outputText("\n\nYou gaze at her shorts and Joy grins, adjusting her shorts to make her bulge even more visible, all the while gazing at you with deep desire and hunger.");
				outputText("\n\nYou grin at Joy's hungry stare, your " + player.vaginaDescript() + " nearly juicing itself in anticipation... Now how do you use Joy to stoke the flames of your lust?");
			}
			joySexMenu();
		}
		
		private function joySexMenu():void {
			menu();
			outputText("\n");
			if (player.hasCock()) {
				//Vaginal penetration
				if (player.cockThatFits(joyVagCapacity()) >= 0) {
					addButton(0, "Vaginal Fuck", penetrateJoysPussy, null, null, null, "Penetrate Joy vaginally with your cock.");
				}
				else {
					if (player.cockTotal() == 1) outputText("\n<b>Your cock is too big to fit in her pussy.</b>");
					else outputText("\n<b>None of your cocks can fit in her pussy.</b>");
				}
				//Anal penetration
				if (player.cockThatFits(joyAnalCapacity()) >= 0) {
					addButton(1, "Anal Fuck", fuckJoyInTheAss, null, null, null, "Take Joy from behind and make sure she gets it good!");
				}
				else {
					if (player.cockTotal() == 1) outputText("\n<b>Your cock is too big to fit in her ass.</b>");
					else outputText("\n<b>None of your cocks can fit in her ass.</b>");
				}
				//Others
				if (joyHasCock()) addButton(4, "Frottage", frotWithJoy, null, null, null, "Do some cock play with Joy.");
				addButton(5, "Get Blown", haveJoySuckYouOff, null, null, null, "Have Joy suck your off and give her a taste of your cum.");
			}
			if (player.hasVagina()) {
				addButton(6, "Get Licked", haveJoyLickYourGinas, null, null, null, "Have Joy lick your pussy.");
				if (joyHasCock()) addButton(7, "Get Penetrated", haveJoyStuffYourPussy, null, null, null, "Have Joy penetrate you vaginally with her cock.");
			}
			addButton(2, "Lick Joy", lickJoysGina, null, null, null, "Get a taste of Joy's pussy but you're sure she has a lot of pussy juice in store for you!");
			if (joyHasCock()) {
				addButton(3, "Blow Joy", suckJoysCock, null, null, null, "Suck Joy's cock and get some taste of her cum!");
				addButton(8, "Get Anal", haveJoyStuffYourButthole, null, null, null, "Have Joy take you from behind and put her cock to a good use.");
			}
			addButton(14, "Back", genericMenu);
		}
		
		private function penetrateJoysPussy():void {
			var x:int = player.cockThatFits(joyVagCapacity());
			clearOutput();
			outputText("You " + player.clothedOrNakedLower("remove your [armor] and ") + "give " + player.cockDescript(x) + " a meaningful stroke, telling Joy you wish to penetrate her pussy.");
			outputText("\n\nJoy wastes no time, she removes her prayer beads and sheds her robe; then she turns her back towards you and bend over, removing her tight shorts and exposing her glistening " + joyPussyDescript() + joyHasCockText(" and hardening " + joyCockDescript()) + ".");
			outputText("\n\nKnowing that she has no patience for foreplay, you don't waste time with any, ");
			if (player.isGoo()) outputText("oozing");
			else if (player.isNaga()) outputText("slithering");
			else outputText("striding");
			outputText(" towards her and pushing her insistently to the ground.");
			outputText("\n\nJoy shakes her bum at you and loops her tail around your waist. \"<i>C'mon [name], I wanna feel that " + player.cockDescript(x) + " deep inside me, like, all the way to my womb.</i>\"");
			outputText("\n\nWell, you always were told it was wrong to keep a lady waiting" + joyHasCockText("...even if it feel odd that this \"lady\" has a cock of her own") + ", and you waste no time in plunging your " + player.cockDescript() + " into her hungry nether-lips.");
			if (flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY] == 0) outputText(" <b>You have taken Joy's virginity!</b>");
			outputText("\n\nJoy moans, and begins rocking herself against you. One of her hands sneaks between her legs to pinch her sensitive clit while the other holds the ground for leverage. \"<i>Ah, [name]. You, like, feel so good inside me. Grab my boobies? Pwetty pwease?</i>\" she asks looking back at you with pleadingly.");
			outputText("\n\nWith a grin, you do as she asks, squeezing the " + joyBreastDescript() + " and feeling their firm yet soft weight in your hands.");
			outputText("\n\nJoy moans and groans as you grope her and pound her mercilessly. Then you hear a moaning squeak and feel Joy's pussy clench, grasping your " + player.cockDescript(x) + " in a vice-like grip " + joyHasCockText("while her own begins spurting cum.") + " \"<i>Ah! Look [name]! You're... Ah.. Like, making the me " + (joyHasCock() ? "cream" : "juice") + " myself... ah!</i>\"");
			outputText("\n\nYou smirk and simply speed up the pace, feeling the throbbing in your " + player.cockDescript(x) + (player.hasVagina() ? " and the envious spasming of your own " + player.vaginaDescript() : "") + " that announces your orgasm is close. Finally, you give a cry and empty yourself into her.");
			if (player.cumQ() >= 1000) {
				outputText("\n\nSome cum backflows and escapes her as you fill her to the brim and beyond. Joy's belly expands until she looks like she's a couple months pregnant; her distending belly, along with her cute squeaks of helpless pleasure only managed to spur you on. One hand wanders towards her belly to feel it as it grows, and you find yourself cumming even harder.");
			}
			else {
				outputText("\n\nHer pussy milks you for all you're worth, even as your jets of cum slow to trickle. One of your hands trails towards her belly and begin rubbing it in a circular motion. You do this until you're finally completely drained.");
			}
			outputText("\n\nJoy gives out, falling into the ground and pulling you down on top of her, as she pants.");
			outputText("\n\nYou collapse on top of the bimbo mouse, trying not to crush her under your weight, too drained to even pull your " + player.cockDescript(x) + " from her cum-slick pussy.");
			outputText("\n\n\"[name]... that was, like, the bestest! Can we go again?</i>\" she asks you lustily, but still panting.");
			outputText("\n\nYou can't help but groan and shake your head; how in the world can she be this horny? You push yourself upright, audibly pulling your cock free - to which Joy whines in dismay, then take her by the arm, telling her that the two of you need to go and get cleaned before starting towards the stream.");
			var chance:int = 20;
			chance += Math.floor(Math.sqrt(player.cumQ()));
			chance += player.virilityQ() * 100;
			if (chance > 100) chance = 100;
			if (rand(100) < chance) jojoScene.pregnancy.knockUp(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_MOUSE);
			player.orgasm();
			dynStats("sens", -1, "cor", -(1 + Math.ceil(player.cor / 20)));
			flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function fuckJoyInTheAss():void {
			var x:int = player.cockThatFits(joyAnalCapacity());
			clearOutput();
			outputText("You " + player.clothedOrNakedLower("strip your [armor] and ") + " give your " + player.cockDescript(x) + " a meaningful stroke; then walk behind Joy to give her butt a little grope, telling her you've been thinking about doing her ass.");
			outputText("\n\nThe bimbo mouse squeaks. \"<i>My butt? You want to stick your funstick up my butt?</i>\" She claps her hands protectively over her tailhole. \"<i>Like, isn't that supposed to go in my little hole in the front? Are you sure you, like, wouldn't rather stick it there?</i>\" She pleads.");
			outputText("\n\nYou gently take her wrist and move her hands out of the way, then hold her waist and pull her towards you whispering in her ear that you REALLY like to stick your " + player.cockDescript(x) + " into her butt. You grind against her in hopes of coaxing her into agreeing with this.");
			outputText("\n\nJoy trembles, but starts to grind back instinctively, her bimbo libido getting the best of her. \"<i>Well... okay. If that's, like, what you really wanna do. Just, promise you'll, like, be gentle with me?</i>\" She blushes, but the wetness staining her shorts " + joyHasCockText("and the tenting erection bulging from there ") + "makes it obvious she's really getting turned on despite herself.");
			outputText("\n\nYou promise her you'll be gentle, and that you'll make sure she's lubed up and ready for the task. Then you step back to allow her to undress.");
			outputText("\n\nWith the unthinking ease of long practice and bimbo brains, Joy is quickly stark naked and standing before you, pussy wet as always" + joyHasCockText(" and her " + joyCockDescript() + " poking out, stiff and ready") + ", simply waiting for you to make the first move.");
			outputText("\n\nYou grab her waist and pull her against you; " + joyHasCockText("you give her " + joyCockDescript() + " a stroke, milking a small bead of pre and then ") + "you reach down to probe the depths of her moist pussy.");
			outputText("\n\nJoy coos in delight at your ministrations, wriggling as you probe her ever-hungry pussy.");
			outputText("\n\nOnce your fingers are sufficiently wet, you extract them from Joy's depths and probe the rosebud between her cheeks, inserting one finger and wiggling it about, then once she's loose enough you insert a second finger.");
			outputText("\n\nJoy squeaks loudly, then lets out a slutty moan as you probe her rear passage" + joyHasCockText(", her " + joyCockDescript() + " jumping when you brush against her prostrate") + ". She bends over to give you better access to her tail-hole, tail reaching out to loop affectionately over your shoulders, prior nervousness forgotten as her bimbo brain concentrates on the imminent prospect of sex.");
			outputText("\n\nYou take this opportunity to push her on her hands and knees and to grind your " + player.cockDescript(x) + " against her pussy, gathering her juices as you massage her rectum. Once you're satisfied with how wet and loose she is, you move into position and begin pushing in.");
			outputText("\n\nJoy's eyes go wide in shock and she tenses up at the sudden intrusion, before she begins to breath, forcibly calming herself down to make further penetration easier for you (and her).");
			outputText("\n\nYou can scarcely believe how good it feels, Joy's innards are velvety and warm and the tight ring of her anus holds your shaft into a vice-like grip; even as she clenches her ass in surprise at your sudden intrusion, you still manage to penetrate her with ease, due to the foreplay. In no time at all you're fully inside her, your cock throbbing in tune with her clenching ass" + joyHasCockText(" as well as her own cock") + ".");
			outputText("\n\nYou give her some time to adjust and ask her if she's ready for this.");
			outputText("\n\n\"<i>I'm, like, so ready for this!</i>\" Joy states, thrusting her rear into your crotch for emphasis. It looks like she's forgotten all about being nervous now that she's actually being buggered.");
			outputText("\n\nYou grin and begin pumping into her. "); 
			if (flags[kFLAGS.JOJO_ANAL_XP] == 0) outputText("<b>Joy has lost her anal virginity.</b> ");
			outputText("Her soft butt cushioning your hips with each slam forward, her wet snatch dripping and spilling her juices. " + (player.balls > 0 ? "Each time you thrust up into her, your balls slap against her pussy teasingly. " : "") + "Intent on making this as pleasurable as possible for both of you; you bend over her and lift one of her fuzzy orbs into your hands, pinching her erect nipple, while you reach down with your other hand to tease her " + joyHasCockText(joyCockDescript() + " and ") + "small clitty.");
			outputText("\n\nJoy moans and squeaks, " + joyHasCockText("her cock throbbing and oozing pre as you keep brushing against her prostate, ") + " clearly getting into this. \"<i>Oh, wow, that's, like, hot! Give it to me, [name]!</i>\" She cries, her tail coiling around your waist.");
			outputText("\n\nSince she's asked so nicely, you decide to give her exactly what she wants. You trust powerfully into her, digging as deep as you can into her furry bums and with a groan of pleasure you unleash a torrent of cum into Joy's inviting backside.");
			outputText("\n\nJoy squeaks loudly in ecstasy, her asshole clenching down like a silk-lined vice as she unthinkingly tries to wring your " + player.cockDescript() + " dry, a flood of juices pouring from her cunt to spatter the ground below" + joyHasCockText("and her own cock spewing cum everywhere, balls jiggling as she mindlessly pumps out shot after shot of spooge") + ", her orgasm undeniable.");
			if (player.cumQ() < 100) {
				outputText("\n\nJoy's clenching ass does not stop you from pumping all you can muster into her.");
			}
			else if (player.cumQ() < 1000) {
				outputText("\n\nJoy's clenching ass milks you for all you're worth, her clenching ass powerful enough to hold your urethra shut, so you end up cumming inside her in jets as her ass loosens enough for you to pour your load down into her.");
			}
			else {
				outputText("\n\nJoy's clenching ass milks you jet by jet, yet your load is so huge that her ass' vice like grip can't hope to contain it. You can feel as you build up glob after glob of cum inside your uretha, before pumping it inside Joy, pushing it through her anal ring and forcing her ass open; you continue doing so even as her belly begins to distend from the amount of cum being poured into her.");
			}
			outputText("\n\nBy the time you're done you feel weak and drained; with a sigh of relief you slump on top of Joy.");
			outputText("\n\nJoy groans softly. \"<i>Like, [name]? You're heavy.</i>\" She comments. \"<i>But the sex is nice... even if I do end up having ass-babies because of it.</i>\" She adds.");
			outputText("\n\nAss-babies? Where does Joy even get these ideas? You chuckle and tell her to stop being silly, there's no way you could get her ass pregnant.");
			outputText("\n\n\"<i>Are you, like, sure of that? You make babies by putting it in a girl's front hole, so why should the rear hole be different? " + (player.cumQ() >= 1000 ? "Like, if you'd dumped all this in my mommy-hole, I'd be pregnant for sure." : "") + "</i>\" The bimbo mouse complains.");
			outputText("\n\nYou sigh and roll over to the side, taking Joy with you and pulling her close against you. You tell her you're pretty sure girls only get pregnant from the front hole.");
			outputText("\n\nThe bimbo mouse sighs and snuggles against you. \"<i>That's good.</i>\" She tells you. \"<i>I wouldn't like having an ass-baby... it'd be all messy.</i>\"");
			outputText("\n\nYou roll your eyes and decide to just enjoy your closeness to Joy for the moment. Eventually though, you decide to get up; so you extract yourself from Joy warm innards and pull away.");
			outputText("\n\nThen you get up and extend a hand to help Joy up as well, that's when you notice that she actually seems to be sleeping...");
			outputText("\n\nYou chuckle and gather your things to go clean up, leaving Joy to rest.");
			player.orgasm();
			dynStats("sens", -1, "cor", -(1 + Math.ceil(player.cor / 20)));
			flags[kFLAGS.JOJO_ANAL_XP]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function lickJoysGina():void {
			clearOutput();
			outputText("You scan Joy with your eyes until you set your gaze between her legs. You tell Joy you were wondering what she tastes like... " + joyHasCockText("then hastily add that you mean her girl-parts, not her boy-parts") + ".");
			outputText("\n\nJoy giggles. \"<i>Well, I guess I can give you, like, a little taste-test.</i>\" She smirks and promptly wriggles out of her clothes right there and then. With a jaunty wriggling of her bum, she saunters over to a convenient spot and seats herself there, legs splayed" + joyHasCockText(" and " + joyCockDescript() + " jutting up, idly stroking her herm member") + ". \"<i>...Come and get it?</i>\" She teases.");
			outputText("\n\nWith a grin you move closer and kneel between her legs, spreading them a bit more for better access. You inhale, taking in Joy's scent and pheromones, feeling the enticing combination burn a path of liquid heat inside you and further arousing you further. With a sigh, you exhale; then proceed to push an exploring finger inside Joy's wet depths.");
			outputText("\n\nJoy squeaks in delight. \"<i>Mmm... little Joyjoy likes that... but little Joyjoy will like your tongue in her much more.</i>\" She grins wickedly down at you" + joyHasCockText(", removing her hand from her cock and coiling her tail around it instead") + ".");
			outputText("\n\nYou smirk and tell Joy that if she wants it, then she should ask nicely. Then you insert another finger and begin slowly pumping them, making Joy even wetter.");
			outputText("\n\n\"<i>Ooh!</i>\" She moans. \"<i>Like, please, [name]; lick my needy little pussy! It's so hooot... like, stick your tongue in there and put the fire out.</i>\" She pleads.");
			outputText("\n\nWell... you were actually looking for a bit of foreplay, but the urgency with which she pleads makes it clear that she's just too aroused to engage in any foreplay. So you pull your fingers out and extend your " + player.tongueDescript() + " to give her pussy a wet lick.");
			outputText("\n\nShe shudders in delight and gives a wordless squeak" + joyHasCockText(", her tail stroking her erect cock with increased pace") + ".");
			outputText("\n\nYou quickly close your mouth around her labia, just in time to receive a sudden serving of deliciously sweet girl-cum; you savour every drop as you drink from Joy, kissing and slurping her lower lips, as well as teasing her little hard clitty with your nose.");
			outputText("\n\nShe wriggles and squeaks, pushing herself forward to grind her cunt against your face" + joyHasCockText(", her balls flopping into your nose at the motion") + ". \"<i>Like, ooh, yeah, that's the stuff, [name]!</i>\"");
			outputText("\n\nYour slurping mouth curls into a smile when you see the effect you're having on the horny bimbo mouse; then you decide to step up the game by plugging your " + player.tongueDescript() + " as far as you can inside Joy's wanton cunt.");
			if (player.tongueType > 0) {
				outputText("\n\n\"<i>Oh! Oh-oh fuck yeah!</i>\" Joy howls with horny glee, as your long undulating tongue slithers inside her warm, wet depths like a snake; licking every little crevice and bump, tasting every cranny and nook of Joy's vagina.");
				outputText("\n\nJoy's vagina tries to grasp at your tongue, but your mobile appendage is easily able to slip and massage her insides.");
			}
			else {
				outputText("\n\nJoy squeaks loudly in delight, bucking in her impromptu chair, as you reach as far as you can inside her, trying to draw in as much of her juices as you can.");
				outputText("\n\nYou pump your tongue, teasing any and every spot you can reach within her depths, massaging her with your tongue.");
			}
			outputText("\n\nThe bimbo mouse thrashes wildly at your stimulation. \"<i>Oh, that's, like, so fucking good!</i>\" She screams. \"<i>I'm gonna... gonna!</i>\" She arches her back" + joyHasCockText(", her tail pumping on her cock like mad,") + " and screams as she cums" + joyHasCockText(", her cock blowing its load all up along her naked belly") + ".");
			outputText("\n\nA veritable flood of juices ejects itself into your hungry maw, and you drink like your life depended on it. Joy's orgasm is messy, and you cup your hands under your chin to catch the spilled femcum.");
			outputText("\n\nJoy gasps and groans as she finishes cumming, slumping down into her seat. She looks at you, still drinking her juices, and manages a weak giggle. \"<i>Like, isn't Joyjoy just too tasty for you?</i>\" She asks.");
			outputText("\n\nYou lick your lips before pulling her into a deep kiss, letting her taste herself.");
			outputText("\n\nShe sinks into the kiss, moaning softly into your mouth and probing insistently between your lips with her tongue. \"<i>Mmm... Not sure if that's me or you I'm, like, tasting, but it totally tastes yummy.</i>\" She declares once she breaks the kiss.");
			outputText("\n\nYou grin at her and lick your lips, heading to the nearest stream to clean up your face.");
			dynStats("lus", 20 + (player.lib / 5) + (player.cor / 10), "cor", -0.5);
			flags[kFLAGS.TIMES_LICKED_JOYS_PUSSY]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function suckJoysCock():void {
			clearOutput();
			outputText("You slowly close in on Joy, making a grab for the bulge in her shorts, carefully sizing it up as it hardens under your touch. Then you grin at Joy and tell her you were wondering what she would taste like.");
			outputText("\n\nThe bimbo mouse herm looks at you, puzzled for the briefest moment, then grins widely. \"<i>Then, like, how's about I give you a taste-test, hmm?</i>\" She coos, ducking forward and giving you a sloppy kiss on the lips. Wriggling out of your grip, she hikes up her robes and pulls down her shorts, letting her " + joyCockDescript() + " hang out freely, already starting to grow erect at your promise. She saunters over to a comfortable spot and sits down. \"<i>Well? Like, whatcha waiting?</i>\"");
			outputText("\n\nIt's hard to believe how lusty this mouse can be... but since she looks so ready you see no reason to hesitate; you slowly lower yourself, examining Joy's " + joyCockDescript() + " as it grows to full mast. An idea hits you, and you decide to play with Joy for a little bit. You spread her legs wider to give you better access and slowly cup her furry sack in one hand, rolling the cum-producing orbs inside round on your palm, while your other hand moves under to tease Joy's slit.");
			outputText("\n\nJoy moans, loudly. \"<i>Like... you're good with your hands... I like that.</i>\" She teases, managing to wink at you before she moans again at the stimulation.");
			outputText("\n\nYou extract your hand from her pussy and offer Joy a juice-slickened finger to suck on, telling her to to make sure your hand is clean before you continue.");
			outputText("\n\nThe bimbo needs no further instructions, immediately latching onto your finger like a baby to a nipple, noisily sucking and slobbering until she's sucked it dry. She makes a show of licking her lips. \"<i>Like... Aren't you supposed to be the one sucking on me?</i>\" She giggles.");
			outputText("\n\nYou flick your wet digit on the tip of Joy's cock and tell her to be patient.");
			outputText("\n\nJoy pouts and wriggles, but says nothing, eagerly waiting for you to begin.");
			outputText("\n\nYou begin to stroke Joy's cock, painfully slowly, just waiting for an opportunity... as well as testing the limits of Joy's patience.");
			outputText("\n\nWhich turns out to not be much. \"<i>Like... I don't want teasing; I want you to suck my cock!</i>\" She whines.");
			outputText("\n\nThe moment a bead of pre shows up atop Joy's cock is the moment you strike.");
			if (player.tongueType > 0) {
				outputText("\n\nYou extend your " + player.tongueDescript() + ", swiping the bead of pre, coiling your tongue around Joy's cock and entering Joy's pussy; all in one fell swoop. You don't even wait for Joy's gasp of surprise before you pull your tongue back and dive forwards to engulf Joy's " + joyCockDescript() + ".");
			}
			else {
				outputText("\n\nYou extend your " + player.tongueDescript() + ", licking the bead of pre clean and guiding Joy's cock inside the warm confines of your mouth.");
			}
			outputText("\n\n\"<i>Oh! [name]!</i>\" Joy yelps, arching her back in delight.");
			outputText("\n\nThis is just the reaction you were hoping for, your mouth curls into a smile even as you get right into your task and begin bobbing on Joy's lap.");
			outputText("\n\nThe mouse herm squirms and moans as you tend to her pulsing cock. \"<i>Yes-yes-yes, oooh, yeah, that's it, like that; that's the way your little Joyjoy likes it!</i>\" She squeaks in delight.");
			outputText("\n\nHeeding Joy's words of encouragement, you up your tempo, trying to make her squeak even louder.");
			outputText("\n\nJoy bucks and writhes, squeaking loud enough for a whole barnful of mice back in Ingnam. \"<i>Ohhh... gonna-gonna-gonna!</i>\" She shudders. \"<i>Here it comes - drink it all!</i>\" She squeals, erupting in an orgasm into your warm, wet, welcoming mouth.");
			outputText("\n\nJoy's cum tastes... unique... you'd call it cheesy... yes, definitely cheesy... almost like cream cheese. It's not unpleasant in the slightest, and you find yourself eagerly drinking all of Joy's load, even squeezing her balls a bit to milk more out of her. ");
			player.refillHunger(Math.floor(joyCumQ() / 25), false);
			outputText("\n\nJoy gasps and heaves, until finally she comes to a stop. \"<i>Wow... Like, your mouth is in-fucking-credible.</i>\" Joy says, then giggles mindlessly at some pun only she can see in what she just said. \"<i>Are you, like, gonna nurse on my cock all day? Or are you gonna, like, let me go? Cause, y'know, if you wanna keep sucking, I'm sure your little Joyjoy can come up with some more mousy cum and fill you until you got a nice big squishy belly.</i>\" She laughs, smirking at the thought.");
			outputText("\n\nA spark of mischief shines in your eyes and you jump to kiss Joy straight on the lips, invading the mouth of the surprised mouse bimbo and feeding her with her own cum; you kiss her deeply, spreading as much cum inside her mouth as can with your " + player.tongueDescript() + ". You break the kiss to look at the panting mouse, nearly breathless from your kiss.");
			outputText("\n\nShe shakes her head rapidly, ears flapping in the air, then gives a loud, deliberate swallow. \"<i>Mmm... I taste yummy, don't I, lover " + player.mf("boy", "girl") + "?</i>\" She giggles.");
			outputText("\n\nYour only reply is to tap her nose and leave with a giggle of your own.");
			dynStats("lus", 20 + (player.lib / 5) + (player.cor / 10), "cor", -0.5);
			flags[kFLAGS.JOJO_BLOWJOB_XP]++;
			incrementJoysCockFondness(1);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function frotWithJoy():void {
			clearOutput();
			outputText(player.clothedOrNakedLower("You begin undressing and tell Joy to do the same.", "You present your naked body and tell Joy to strip naked for you."));
			outputText("\n\nJoy smiles, unwraps her beads from around her waist, and steps easily out of her robe, allowing it to fall to the ground behind her as she bends over to slide off her shorts. Within moments, she is standing naked before you, thanks to the fact she doesn't bother with underpants.");
			outputText("\n\nYou smile at her as you walk towards her, gently laying a hand on breast and looping your arm around her waist to pull her closer.");
			outputText("\n\nJoy smiles with glee and allows herself to be pulled close, tail looping around your "); 
			if (player.isBiped()) outputText("[legs]");
			else if (player.isTaur() || player.isDrider()) outputText("foreleg");
			else if (player.isNaga()) outputText("serpentine tail");
			else if (player.isGoo()) outputText("the mass of goo that makes up your legs");
			outputText(" and sliding up to caress your " + player.assDescript() + ". She leans in close, breasts pushing against yours, and places a hungry kiss at the corner of your mouth. \"<i>Mmm... what do you have, like, in mind?</i>\" She murmurs throatily.");
			outputText("\n\nYou press hard against her, groping her breast as both your " + player.cockDescript() + " and Joy's " + joyCockDescript() + " grow hard with arousal. You tweak her nipple and Joy moans, you seize the opportunity and release her breast, looping your arm around her neck to pull her in for a kiss, mashing her " + joyBreastDescript() + " against your " + player.breastDescript(0) + ". Then break the kiss as you tell her to just enjoy herself and do what feels natural.");
			outputText("\n\nJoy moans and kisses you again, thrusting her tongue hungrily into your mouth and thrusting her hips strongly, grinding her " + joyCockLength() + "-inch cock against your own " + player.cockDescript() + ".");
			outputText("\n\nYou grind against her yourself; beads of pre form on your tips, and as they slide along your shafts, slickening the both of you, you grind harder and harder against Joy, attacking her mouth with your own " + player.tongueDescript() + ".");
			outputText("\n\nJoy starts to buck and thrust; evidently she's so horny and turned on that she can't muster the patience to slip her cock into any available hole, she's content to just grind it against your own in hopes that the friction will let her get off.");
			outputText("\n\nYou do the same, feeling yourself approach the edge quickly. You thrust against her once more and groan into her mouth as you begin cumming, painting both your bellies as well as your chests in hot spunk.");
			outputText("\n\nJoy gasps and moans, eagerly blowing her load with full-body jerks and spasms until, at least, she peters out and her cock flops limply down between her legs, your front and hers painted in her spooge. \"<i>Wow... That's not, like, my favorite way to do things, but it's certainly pretty fun, y'know?</i>\" She comments. Stepping back, she gently brushes off some of the mixed spunk with her finger and slurps it up. \"<i>Mmm. We make a good mix.</i>\" She giggles");
			outputText("\n\nYou " + player.clothedOrNakedLower("gather the discarded pieces of your " + player.armorDescript() + " and ") + "give her ass a good grope before leading the both of you towards the nearest stream to clean up.");
			player.orgasm();
			dynStats("cor", -(0.5 + Math.ceil(player.cor / 30)));
			flags[kFLAGS.TIMES_FROTTED_WITH_JOY]++;
			incrementJoysCockFondness(1);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveJoySuckYouOff():void {
			clearOutput();
			outputText("You gaze at Joy's lips and decide to ask her if she'd be willing to use her mouth to have some fun.");
			outputText("\n\nShe gives you a sultry smile. \"<i>Oh? Like, do you think you can handle me, big " + player.mf("boy", "girl") + "?</i>\" She coos, sucking pointedly on one of her pinky fingers.");
			outputText("\n\nYou decide to tease her a little bit and tell her she's right, you really can't handle her so you'd better find someone else to give you what you want.");
			outputText("\n\nMaybe not your smartest decision, because the horny mousegirl promptly throws herself at you in a flying tackle, bringing you to the ground. \"<i>Oh no you don't! You got cock and, like, I want your cock!</i>\" She cries" + joyHasCockText(", her own " + joyCockDescript() + " bulging in her shorts") + ".");
			outputText("\n\nYou laugh at Joy's reaction and tell her to get off you and undress, you wouldn't want to get her" + player.clothedOrNakedLower(", or your,") + " clothes dirty.");
			outputText("\n\nShe just licks her lips. \"<i>I can wash my own clothes, thank you. As for getting you dirty...</i>\" She leers down at you, gently stroking your crotch. \"<i>That implies I'm gonna spill some spunk...</i>\" She purrs, and then starts tugging down your undergarments.");
			outputText("\n\nThat sounded like a promise... you decide to lean back and relax, telling her to show you just what she can do with those pretty lips of hers.");
			outputText("\n\nJoy needs no encouragement; within moments she has your shaft sticking up into the air, hungrily licking her lips. \"<i>Baby... like, I'm gonna blow your mind...</i>\" She coos. She " + (player.cockTotal() > 1 ? "selects your largest " + player.cockDescript(player.biggestCockIndex()) + " and " : "") + "takes your cock by her hand. \"<i>Mmm... Good enough to eat...</i>\" She promptly opens her mouth and engulfs your cock.");
			//Cock size check goes here
			if (player.cockArea(player.smallestCockIndex()) < 12) {
				outputText("\n\nWithin moments you can feel Joy's nose bump into your crotch, you're barely big enough to reach the back of her throat; still you can't help but moan at the feeling of Joy's slowly undulating tongue, as the warmth of her mouth spreads through your " + player.cockDescript() + ".");
				outputText("\n\nJoy pulls away and smacks her lips, tasting you like a fine wine; then she grins at you. \"<i>Aw, it's so cute... don't worry, I'll take good care of it,</i>\" the bimbofied mouse tells you. Then she dives back into her task, already starting to lick and suckle eagerly.");
			}
			else if (player.cockArea(player.smallestCockIndex()) < 24) {
				outputText("\n\nYou moan as you feel Joy's soft lips forming a seal around your " + player.cockDescript() + "; then you groan in pleasure as Joy all, but slurps your dick in, massaging the underside with her tongue.");
				outputText("\n\nJoy mumbles contentedly around your shaft, but refuses to let go, too intent on enjoying herself now she's latched onto you like a baby onto a nipple.");
			}
			else {
				outputText("\n\nFirst you feel Joy's lips form a seal around your " + player.cockDescript() + ", then you feel her tongue massage you as she slowly slides down your shaft... until you feel her gag as you hit the back of her throat.");
				outputText("\n\nShe pulls up, coughing slightly, and gives you a disappointed pout. \"<i>Aww... it's so big... But don't you worry; little Joyjoy is, like, gonna do her best.</i>\" With that she gamely reattaches herself, stretching her jaws to wrap around your girth and swallowing as much of your length as she can bear, tongue and lips stroking and caressing the sensitive skin.");
			}
			outputText("\n\nYou can't help but begin to buck into Joy's suckling lips; she handles you with such expertise, that you have to wonder if she ever did that before. You look down at her, bobbing and sucking on your " + player.cockDescript() + "; she looks so cute when she works hard like that.");
			outputText("\n\nJoy doesn't give any verbal acknowledgement of your attention, but picks up her pace, audibly slurping and gulping as she works your " + player.cockDescript() + ", tongue sliding forcefully along its under-length and bucked teeth scraping softly, in a way calculated to set your nerves afire.");
			outputText("\n\nYou gasp as Joy speeds up, gently grabbing at her ears and telling her to slow down; if she keeps this up you're gonna blow soon.");
			outputText("\n\n\"<i>Like, that's the whole point.</i>\" She mumbles around your cock. She shakes her head so you let go of her ears, then resumes going just as fast as she was - indeed, she somehow manages to go even faster.");
			outputText("\n\nFine... if that's what she wants, you'll be happy to oblige... with a groan you thrust into her lips and blow yours load, straight into her throat; jet after powerful jet of spunk draining into Joy's hungry mouth.");
			outputText("\n\nJoy lets out a muffled squeak of joy and starts greedily slurping up every last drop of cum that you give her.");
			//ORGASM!
			if (player.cumQ() < 50) {
				outputText("\n\nAll too soon, all the cum you have in you has vanished into her greedy belly, though she continues to nurse at your cock for a while before letting you drop in a disappointed manner. \"<i>All done.</i>\" She proclaims, cheerfully.");
			}
			else if (player.cumQ() < 250) {
				outputText("\n\nShe rides your orgasms expertly, drinking down every last jet of each orgasm until you have spent yourself at last. She daintly lets your " + player.cockDescript() + " go and sits up, smiling as she pats a visibly-full belly. \"<i>Mmm, you make some tasty spunk.</i>\" She tells you, then gently stifles a burp.");
			}
			else if (player.cumQ() < 1000) {
				outputText("\n\nDespite the cascade of sexual fluid that pours into her waiting mouth, she is true to her word; she swallows and swallows like her life depends on it, gut swelling out until she looks pregnant/even more pregnant with all the fluid you've fed her. Her expression as she looks up at you, straining into a sitting position, is very proud, but she says nothing, instead letting her belly speak for itself.");
			}
			else {
				outputText("\n\nIt becomes a battle to see who will triumph; your overcharged sperm-factory, or the insatiably cum-thirsty bimbo mouse. She gags on the veritable waves of jism flooding her mouth, froth forming on her lips as she gurgles, but she gamely struggles to thrust the head of your cock directly into her throat, allowing the cum to just pour on in without her needing to actively swallow. She drinks and drinks until she's wallowing on a hugely distended belly but even you are utterly emptied of cum. You pull your slightly froth-smeared cock from her lips, afraid of suffocating her, and she gasps for air. She looks up at you and manages to actually smile, before belching hugely, the force sending her wobbling back and forth on her massive gut.");
			}
			outputText("\n\nYou smile at Joy and pat her on the head, asking her if she doesn't get sick of eating so much cum.");
			outputText("\n\nShe shakes her head defiantly. \"<i>Nu-uh! Your cum's, like, super-yummy, [name]! I'll drink it and drink it till you got none left to give me.</i>\" She declares proudly.");
			outputText("\n\nUntil you have none? Wouldn't that be bad for her then? You ask jokingly.");
			outputText("\n\nShe pouts. \"<i>Like, why do you always gotta, y'know, take everything I say so literally?</i>\" She whines, tail lashing back and forth in an irritated manner.");
			outputText("\n\nYou ruffle her hair and tell her it's because she looks cute when she's mad.");
			outputText("\n\nShe gives you a wide, goofy smile at that and coos in delight, leaning into your stroking hand.");
			outputText("\n\nYou " + player.clothedOrNakedLower("gather your [armor] and ") + "leave to clean up.");
			player.orgasm();
			dynStats("cor", -(0.5 + Math.ceil(player.cor / 30)));
			flags[kFLAGS.TIMES_GET_BLOWN_BY_JOY]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveJoyLickYourGinas():void {
			clearOutput();
			outputText("You " + player.clothedOrNakedLower("peel off your " + player.armorDescript() + " and then ") + "sit on a nearby rock, spreading your legs and showing Joy's hungry eyes your " + (player.hasCock() ? "hardening " + player.cockDescript() + " and " : "") + "rapidly moistening pussy. Then you ask Joy if she'd like a little taste of your love-hole.");
			outputText("\n\nThe mouse doesn't answer verbally; instead, she springs at you in a pounce that purposefully falls short, leaving her crouched right before your " + player.vaginaDescript() + ". She grins up at you, then gives you a long, wet, slurpy lick up your pussy.");
			outputText("\n\nYou moan, and grin at Joy's eagerness, patting her head; then you tell her that you were actually expecting some foreplay before she started.");
			outputText("\n\n\"<i>Like, why foreplay when we're both ready?</i>\" Joy giggles, tail curling into a heart behind her, then leaning in to lick you again.");
			outputText("\n\nYou consider explaining to her how foreplay can be a fun part of sex, but instead tell her that if she wants to go for the main course, then she'd better make it worth your while.");
			outputText("\n\nJoy doesn't speak to that; she just closes her eyes and starts to lick, pushing her face as close to your " + player.vaginaDescript() + " as she can, tongue ravishing you, sliding across your lips and plunging deeply to scour every nook and cranny she can find and reach.");
			outputText("\n\nYou sigh and relax, letting Joy take care of you; occasionally she bumps into your clit and you can't help but moan, as you reward her with a rush of fluids " + (player.hasCock() ? "and your " + player.cockDescript() + " throbs in sympathetic pleasure" : "") + ".");
			outputText("\n\nJoy doesn't say a word; she just keeps licking and licking, like a man dying of thirst in the desert licking a rock for moisture. She gets so eager to lap up every last drop of femcum you can give her that she begins pushing her pointed muzzle against your nether lips, finally slipping it inside and beginning to fuck you with her face even as she slurps and suckles.");
			outputText("\n\nYou gasp in surprise as Joy's muzzle presses against your " + player.vaginaDescript() + ", then moans as it slips in; you're pleasantly surprised at this development and " + (player.isBiped() ? "loop your legs" : (player.isNaga() ? "coil around Joy's back" : "grab her head to guide her movements.")));
			outputText("\n\nJoy gives a muffled grunt, and instinctively tries to pull her head back, defeating by your guiding grip and her own desire to keep licking, she relaxes and pushes in as deeply as she can go.");
			outputText("\n\nYou grunt in pleasure and press her deeper into your pussy, enjoying the face-fucking you're receiving and encouraging Joy to go on with pleasured moans.");
			outputText("\n\nJoy licks and licks, skillfully tending to every last stretch of your inner cavity. And finally you reward her efforts with a hump and groan as you finally hit your climax, " + (player.averageVaginalWetness() >= 4 ? "squirting juices straight into Joy's muzzle" : "flooding your passage with your sweet juices") + ". " + (player.hasCock() ? "Your " + player.cockDescript() + " throbs and blows its load over Joy's head, to splatter on the floor." : ""));
			outputText("\n\nWith a wetly muffled squeak of delight Joy noisily slurps and gulps and slobbers, sucking up every last droplet of femcum and then wiping you squeaky clean with her tongue. She pulls her face free of your cunt and licks her nose. \"<i>Aw... no more cum for Joyjoy?</i>\"");
			if (player.hasCock()) {
				outputText("\n\nYou pant and smile at Joy, flicking your eyes towards your still erect " + player.cockDescript() + " and telling her she's welcome to taste a bit more of cum if she wants.");
				outputText("\n\nJoy's eyes glitter and she quickly latches onto your " + player.cockDescript() + " like a baby onto a nipple, sucking away thirstily.");
				outputText("\n\nThis triggers another small orgasm from you, and you reward her with a healthy dose spunk.");
				outputText("\n\nJoy sucks it all down without hesitation, licking her lips clean when she's done. \"<i>Now, you're like, totally empty, yeah?</i>\" She smirks with pride.");
			}
			outputText("\n\nYou chuckle and pat her head, saying that's all you can give her for the moment.");
			outputText("\n\n\"<i>Like, aw well. It was sure tasty though.</i>\" Joy declare airly. She then gives out an unladylike burp. \"<i>Excuse me!</i>\" She begs, covering her lips and blushing with embarrassment.");
			outputText("\n\nYou get up and redress yourself, then thank Joy for her service and promise to return to later.");
			outputText("\n\n\"<i>Like, I'll be here when you need me.</i>\" Joy says, idly waving you off.");
			outputText("\n\nYou point to her face and let her know there's still a bit of cum hanging from chin.");
			outputText("\n\nJoy's tongue immediately snakes out and licks it up. \"<i>Better now?</i>\" She teases.");
			outputText("\n\nYou just give her a thumbs up and leave.");
			player.orgasm();
			dynStats("cor", -(0.5 + Math.ceil(player.cor / 20)));
			flags[kFLAGS.TIMES_GET_LICKED_BY_JOY]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveJoyStuffYourPussy():void {
			clearOutput();
			outputText("You " + player.clothedOrNakedLower("begin undressing, ", "put on a show, ") + "making sure to go as slowly as possible in order to put on a show for Joy.");
			outputText("\n\nThe bimbo mouse certainly appreciates the show; her tongue is hanging out and she stares obliviously at your increasingly nude form, so caught up in looking she can't even think about removing her own clothes.");
			outputText("\n\nWhen you're done, you're surprised to see she still has her clothes on, and ask her how does she intend to have sex still fully dressed?");
			outputText("\n\nJoy blinks, shakes her head, and visibly snaps herself to her attention. She doesn't even bother to take her robes off, instead roughly yanking down her shorts, kicking them aside and then taking a flying leap into your arms, seeking to push you over so she can start.");
			outputText("\n\nYou catch her and giggle, then ask her what she plans on doing now?");
			outputText("\n\nJoy just looks at you, clearly baffled. \"<i>Like, I was gonna put my funstick into your pussy?</i>\" She says, sounding a little sheepish, as if she's afraid she's been caught doing something wrong.");
			outputText("\n\nYou tighten your hold against her, crushing " + (player.hasCock() ? "both your erect cocks" : "her erect cock") + " between the two of you; then give her a quick peck on the lips and pulls her down so she lays above you.");
			outputText("\n\nJoy smirks with delight and, unwilling to wait with the foreplay, wriggles so that her cock is hovering at the entrance to your " + player.vaginaDescript() + ". \"<i>Like, are you ready?</i>\" She titters, eager to begin.");
			outputText("\n\nYou loop your legs around her and begin pulling her towards you.");
			outputText("\n\nYou moan as Joy begins pumping inside you, careful not to hurt you; but at the same time making a face of barely contained lust. Slowly she speeds up, until she's thrusting into you in a frantic rhythm, almost as if her life depended on it. You pull her into a kiss and begin groping her " + joyBreastDescript() + ". ");
			player.cuntChange(joyCockLength() * joyCockGirth(), true);
			outputText("\n\n\"<i>Oh, like, like, [name]!</i>\" She cries; and, as suddenly as it started, she ends, her balls squeezing a copious torrent of spunk into your thirsty cunt.");
			player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE); //Chance of player getting pregnant!
			outputText("\n\nHer orgasm triggers your own, and you tweak her nipples as you feel your " + player.vaginaDescript() + " clench and begin drawing in Joy's mouse-spunk all the way into your womb " + (player.hasCock() ? ", your own " + player.cockDescript() + " throbs and spurts jets of cum over your head, to splay on the ground below" : "") + ". Joy's continued spurts of jism feel so good... so good, that when she stops cumming you give a disappointed sigh. Then you reach down between her legs and give her " + joyBallsDescript() + " a squeeze to try and coax more seed out of her.");
			outputText("\n\nJoy moans and obliges with a last few spurts, but soon all that's left is a pitiful trickle that quickly dries up.");
			outputText("\n\nSatisfied for the moment you pull her closer into an embrace and enjoy as your afterglow sets in.");
			outputText("\n\nJoy sighs and snuggles into you, clearly just as content to enjoy the moment as you.");
			outputText("\n\nSadly you feel you must carry on with your duties, so you tell Joy that it's time to get up.");
			outputText("\n\n\"<i>No! Don't wanna!</i>\" Joy yells, wrapping her arms, legs and tail around you defiantly.");
			outputText("\n\nYou gently tug at her cheeks telling her to stop acting like a child!");
			outputText("\n\nJoy squeaks in protest and lets go, rubbing her sore face and visibly sulking.");
			outputText("\n\nYou sigh and get up, extracting yourself from under her; a small trickle of cum leaks from your used fuckhole, and down your legs; looks like you'll need a bath... but first. You help Joy up and pat her head telling her if she promises to be a good girl you two can have more fun later.");
			outputText("\n\n\"<i>Yay!</i>\" Joy perks right up at that, throwing her arms into the air in delight.");
			outputText("\n\nYou giggle at her reaction and gather your discarded clothes. Then take Joy's hand and begin making your way towards the nearest stream.");
			player.orgasm();
			dynStats("sens", 1, "cor", -(1 + Math.ceil(player.cor / 20)));
			flags[kFLAGS.JOJO_VAGINAL_CATCH_COUNTER]++;
			incrementJoysCockFondness(2);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveJoyStuffYourButthole():void {
			var isVirgin:Boolean = (player.ass.analLooseness == 0);
			clearOutput();
			outputText("You " + player.clothedOrNakedLower("take off your [armor] and ") + "show Joy your naked body" + (player.hasCock() || player.hasVagina() ? " and" : "") + (player.hasCock() ? " your hardening " + player.cockDescript() : "") + (player.hasCock() && player.hasVagina() ? " and" : "") + (player.hasVagina() ? " moistening " + player.vaginaDescript() : "") + ". You close in on Joy and gently stroke her cheek, pulling her close for a quick kiss; then taking the opportunity grab at her " + joyCockDescript() + " through her shorts and whisper to her that you would like her up your butt.");
			if (flags[kFLAGS.JOJO_ANAL_CATCH_COUNTER] == 0) {
				outputText("\n\nJoy blushes and shuffles her feet from side to side. \"<i>Up-Up the butt?</i>\" She stammers. \"<i>Like, why would you want it shoved up there?</i>\" She asks, though you can feel her " + joyCockDescript() + " getting hard at the thought.");
				outputText("\n\nYou explain to her that anal stimulation can feel just as good as vaginal sex. " + (player.hasVagina() ? "" : "Besides you don't really have a pussy for her to stick her dick.") + "");
				outputText("\n\n\"<i>But still... what if I hurt you? I couldn't bear it if that happened!</i>\" The bimbo herm protests, shaking her head as she pictures you hurt. \"<i>Plus, wouldn't it be all nasty in there?</i>\"");
				outputText("\n\nYou ask if she's insinuating that you're not clean.");
				outputText("\n\nAt that, she looks startled. \"<i>Like, no! That's not what I meant! I mean, I...</i>\" She trails off, clearly too confused to really know what to say or do anymore.");
				outputText("\n\nYou give her junk a soft stroke and turn around; you walk a bit and bend over slightly, then slap your own butt. Finally you look at her and ask her if she really doesn't want a piece of your ass.");
			}
			outputText("\n\nShe swallows hard, fixated on your " + player.assDescript() + ", " + joyCockDescript() + " hard as you've ever seen it. \"<i>Like, okay, if you're really sure that, y'know, this is what you want...</i>\" She grumbles. \"<i>But I'm not touching that ass until I've, liked, lubed you up good!</i>\" She insists, stamping one little foot for emphasis.");
			outputText("\n\nYou smile and tell her you wouldn't have it any other way.");
			outputText("\n\nStill muttering to herself, the mouse herm stalks over to you, stripping her clothes and dropping them in a heap; then gives your left asscheek a stinging slap. Then, she starts to jerk herself off with one hand, the other diving into her ever-wet cunt. \"<i>Gonna lube you up... Like, gonna stuff you fulla pre... make you nice and stretchy for my cock...</i>\" She murmurs to herself. Then, feeling she has enough sexual fluids on her hands, she reaches out and sticks a finger without warning into your asshole.");
			outputText("\n\nYou yelp at the sudden intrusion and tell her to be gentler. That hurts!");
			outputText("\n\n\"<i>Like, sorry, [name]. Here, is this better?</i>\" The chastened mouse tells you. She removes the finger and instead begins to massage the puckered ring of muscles that are your anus, rubbing and squeezing with her precum-slick hand to get her goo kneaded into the opening and to make your muscles relax.");
			outputText("\n\nYou sigh in pleasure and relief and tell her she can stick her finger in, just not so fast.");
			outputText("\n\nAt that, she removes the hand ladened in precum and instead gently begins to poke one of her femcum-slick fingers into your anus. \"<i>Like that?</i>\" She asks.");
			outputText("\n\nYou moan a bit as she does so and tell her yes, just like that...");
			if (player.hasCock()) outputText("You moan again as she happens to poke your prostate.");
			outputText("\n\nEmboldened, the mouse begins to pump the finger in, then, when she thinks you're stretched out, she adds another finger and continues pumping. \"<i>Like... when can I put my cock in, [name]?</i>\" She pleads.");
			outputText("\n\nYou sigh as you feel you're ready and tell her she can go ahead, but be gentle.");
			outputText("\n\nJoy pulls her fingers out so fast you almost hear a \"<i>pop</i>\" sound, and then she grabs either of your hips, banging her " + joyCockDescript() + " impatiently against your ass. Pulling back just enough to line it up with your " + player.assDescript() + ", she starts to push it home. ");
			player.buttChange(joyCockLength() * joyCockGirth(), true);
			outputText("\n\nYou moan deeply, pushing back against Joy to help her ease herself into your ass. ");
			if (player.hasCock()) outputText("Your " + player.cockDescript() + " throbs in pleasure as she brushes against your prostate. ");
			if (player.hasVagina()) outputText("Your " + player.vaginaDescript() + " nearly juices itself when Joy's balls slap against your moist lips. ");
			if (player.ass.analLooseness <= 2) outputText("\"Ooh! [name] you're, like, so tight back here!" + (isVirgin ? " Like, you must be a virgin!" : "") + "\" Joy squeaks in excitement. ");
			outputText("\n\n\"<i>It feels so warm and good...</i>\" Joy moans in pleasure.");
			outputText("\n\nJoy stops, you can't tell if she's overwhelmed by pleasure or just giving you time to adjust... still, once you feel you're getting used to her girth, you move down on your hands and knees and begin to gently rock yourself against her, urging her to begin doing so herself.");
			outputText("\n\nThe bimbo herm needs little encouragement and is soon frantically pounding away at you. \"<i>Dirty [name]! You want your little Joyjoy to fuck your ass? You so naughty! Joyjoy gonna fuck your ass - don't you just love Joy fucking your ass?</i>\" She squeaks, her tongue running away from her overheated brain.");
			outputText("\n\nYou're inclined to reply, but you don't believe she'll even hear you, as lost in pleasure as she is. You rock back against her, feeling her balls slap against your " + (player.hasVagina() ? player.vaginaDescript() : player.buttDescript()) + " and her cock probe your innards. " + (player.hasCock() ? "Once in a while a spike of pleasure runs through your body as Joy manages to thrust against your prostate, coaxing beads of pre from your " + player.cockDescript() + "." : "") + "");
			outputText("\n\n\"<i>Oh! Ah! [name]! I-I-I!</i>\" Joy trails off into an ecstatic squeaking squeal as she cums, flooding your nether depths with all the spooge she can muster.");
			outputText("\n\nJoy almost seems about to faint onto your back, pressing her " + joyBreastDescript() + " heavily against you, but manages to muster the strength to pull out of you and crawl a foot or so away before collapsing, gasping for breath.");
			outputText("\n\nPanting, you get up and walk towards her, feeling Joy's deposit run down your " + player.buttDescript() + " with each step. Once you reach her, you ask her if she's alright.");
			outputText("\n\n\"<i>I'm, like, fine, [name]. Just wanna catch my breath.</i>\" She gulps in a few deep lungfuls of air and seems totally restored. \"<i>So... Do you think I put enough in you to get you pregnant?</i>\"");
			outputText("\n\nG-Get you pregnant? You burst out laughing, then explain to Joy that the only way she could get you pregnant is " + (player.hasVagina() ? "if she had fucked your pussy" : "if you had a pussy") + ".");
			outputText("\n\nShe just gives you a serious look. \"<i>I was a guy who grew tits and a pussy. You never know. You NEVER know.</i>\" She tells you darkly.");
			outputText("\n\nYou chuckle and tell her that if she DOES get you ass-pregnant, you expect her to take full responsibility.");
			outputText("\n\nShe giggles; \"<i>Oh? Like, how?</i>\" Her tail slithers around to caress your " + player.assDescript() + ".");
			outputText("\n\nYou begin explaining that she'll have to pamper and spoil you, bringing you food in bed, handing out massages, as well as helping you birth and watch the baby when it's born. Finally with a smirk, you tell her that there'll be no sex until the baby is born.");
			outputText("\n\nJoy is smiling all through your explanation, right up until you mention that last part. Then her face falls. \"<i>No sex!</i>\" She blurts, horrified.");
			outputText("\n\nYou nod and look at her, gauging her reaction.");
			outputText("\n\n\"<i>No! Please! Don't cut off the sex! I couldn't stand no more sex!</i>\" Joy begs you.");
			outputText("\n\nYou laugh at Joy's mortified expression and comfort her by hugging her and telling her you would never refuse something as cute as her... but if she really expects to have a shot at your ass again she'd better grab your stuff and help you clean up. Then you release her and make your way towards the stream.");
			outputText("\n\nThe mouse bimbo watches you go. \"<i>Like, [name], that was really mean!</i>\" She whines, then scampers after you.");
			player.orgasm();
			dynStats("sens", 1, "cor", -(1 + Math.ceil(player.cor / 20)));
			flags[kFLAGS.JOJO_ANAL_CATCH_COUNTER]++;
			incrementJoysCockFondness(2);
			doNext(camp.returnToCampUseOneHour);
		}
		
		//------------
		// PREGNANCY
		//------------
		//Joy
		public function joyPregnancyUpdate():Boolean {
			switch(jojoScene.pregnancy.eventTriggered()) {
				case 1:
					outputText("\nJoy has been getting pudgy, sometimes she even looks sick... You ask her if she's been feeling alright lately.");
					outputText("\n\nShe shrugs her shoulders and giggles. \"<i>A little queasy, now and then. Don't worry; it's just a stomach bug.</i>\"");
					return true;
				case 2:
					outputText("\nYou notice that Joy's belly has grown a bit bigger. You suggest that maybe she's pregnant?");
					outputText("\n\nThe mouse bimbo looks puzzled at first, as if she can't comprehend what you're saying, but then understanding dawns and her face lights up. \"<i>I'm gonna have babies?</i>\" She squeaks in excitement.");
					outputText("\n\nYou tell her you think so, unless she's been eating a lot of fatty food lately...");
					outputText("\n\n\"<i>Like, that's not funny, [name].</i>\" She frowns. She then places a hand on her lower abdomen, already sporting a pronounced paunch, and smiles beatifically. \"<i>I'm, like, gonna be a mommy... It's gonna be so wonderful!</i>\" She enthuses.");
					if (flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 70 && !camp.marbleFollower()) {
						outputText("\n\nThen, she starts to hum something, you think it might be a lullaby, and bustles off, starting to gather soft grasses and branches and other things. You think she must be planning on building some kind of nest or nursery.");
					}
					return true;
				case 3:
					outputText("\nJoy's belly has grown too big to keep it inside her robes, so instead she displays it proudly. Her beads hang on her neck now, so there's no risk of it constricting Joy's belly.");
					outputText("\n\nShe spots you looking at her and strikes a pose. \"<i>Like, don't I look sexy like this?</i>\" She giggles, one hand placed on her thrust-out bump for emphasis. \"<i>I'm gonna be, like, a super-cute mommy, and our babies are gonna be so cute 'n' sweet.</i>\"");
					if (flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 70 && !camp.marbleFollower()) {
						outputText("\n\nYou've noticed that Joy has finally set up a crude nursery in an area of your camp that's surrounded by rocks. It's far from elegantly put together, but your children should be safe and comfortable inside of it.");
						flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 70; //Crude. The nursery will be improved as Marble arrives.
					}
					return true;
				case 4:
					outputText("\nJoy's belly is huge now, sometimes you think you see it move a bit as the baby inside kicks it. Joy, however looks tired, it seems carrying her baby around is quite a chore for her.");
					outputText("\n\n\"<i>Like... this is getting sooo hard. I want to be a mommy, but these babies are heavy, and they're starting to kick a lot. [name], make them stop kicking their mommy? Please?</i>\" She pleads with you, fluttering her eyes in an effort to look extra appealing.");
					outputText("\n\nYou gently rub her belly in an attempt to calm down the baby inside, that's when you notice not one set of kicks... but two!");
					outputText("\n\nShe blinks at your expression. ");
					if (flags[kFLAGS.JOJO_LITTERS] == 0) {
						outputText("\"<i>Like, what's wrong? Didn't you know mice usually have 2 to 4 kids in a litter?</i>\"");
						outputText("\n\nSo mice usually have twins huh?");
					}
					else {
						outputText("\"<i>You haven't, like, forgotten I'm usually gonna have twins, right?</i>\"");
						outputText("\n\nAh yes... you'd forgotten about that...");
					}
					outputText(" Your belly rubbing seems to have the intended effect as the babies inside stop their frantic kicking.");
					outputText("\n\nJoy smiles and moans softly. \"<i>Mmm... That feels so nice... And the babies, like, seem to really like it too.</i>\"");
					if (joyHasCock()) outputText(" Her " + joyCockDescript() + " starts to idly creep erect, but you don't know if she really wants to fuck or not; it looks more like just an involuntary response.");
					return true;
				case 5:
					outputText("\nJoy's belly is far bigger than any woman back in the village. It constantly squirms as the mouse babies inside her scurry about, eager to come out; and by the looks of Joy's bloated breasts, it seems she's started lactating.");
					outputText("\n\n\"<i>Like, how much longer is this going to go on?!</i>\" Joy wails when she sees you looking, hands slung under her bulging belly in an effort to cradle it. \"<i>They're heavy and they kick and my boobies are sore from all the milk in 'em! Why won't they come out already?</i>\" She pleads.");
					outputText("\n\nYou chuckle at Joy's impatience and tell her she'll just have to wait a little longer, she should be ready to give birth any time now.");
					outputText("\n\n\"<i>Like, you promise? You wouldn't be a meanie and lie to me about that, would you?</i>\" The bimbo mouse pouts.");
					outputText("\n\nYou pat her belly affectionately and promise her it won't be long; then further comfort her by telling her that if the babies are half as cute as their mother, it'll be worth it.");
					outputText("\n\n\"<i>That's, like, so sweet of you, [name].</i>\" Joy tells you, beaming with pride and seeming to have forgotten her discomfort.");
					return true;
				default:
					return false;
			}
		}
		
		public function joyGivesBirth():void {
			clearOutput();
			outputText("As you stroll through the camp, a pained squeak catches your attention and you look to see Joy holding her belly in apparent pain.");
			outputText("\n\nJoy staggers over to you, clutching her swollen belly and wincing. \"<i>Like, [name]? Can you give me a belly rub? Please? I got this horrible pain in my tummy.</i>\" She whimpers.");
			outputText("\n\nNodding, you guide her to her tent and help her lay down; then you loosen her robes and start gently rubbing her belly. That's when you notice that the babies inside seem strangely agitated, and you feel what could only be a contraction accompanied by a pained squeak; a quick look at Joy's shorts confirms your thoughts as you notice a wet spot has formed. In one smooth motion you grab the rim of Joy's shorts and pull them off Joy.");
			outputText("\n\n\"<i>Like, this really isn't the time for sex, [name].</i>\" Joy complains, though, from the way her tail starts to flick back and forth, you can't honestly say she is entirely unenthusiastic about the idea.");
			outputText("\n\nYou sigh and ask Joy if she has any idea of what's going on...");
			outputText("\n\n\"<i>...I, like, have a terrible tummy-ache and you're, like, pulling my pants off?</i>\" Joy asks. Then she winces and looks ashamed. \"<i>And I think I just peed myself.</i>\" She confesses, terribly embarrassed.");
			outputText("\n\nYou hit your head with the palm of your hand, and state matter of factly that she's gone into labor and the babies are coming.");
			outputText("\n\n\"<i>The babies are coming?! I'm gonna be a mommy?</i>\" She asks eagerly. Then winces. \"<i>Why does it have to hurt like this, though?</i>\" She whines.");
			outputText("\n\nYou tell her to wait for a bit and hurry off to fetch some towels and heat water to help clean the babies once they're born. You return as soon as you can and take Joy's hands in your own, instructing her on how she should breath and push.");
			outputText("\n\nJoy does exactly what you tell her, groaning in pain as she strives to force the infants from her womb, squeezing your hand until both your knuckles turn white.");
			outputText("\n\nYou watch attentively for any sign of the babies, until finally you spot a head. You encourage Joy by telling her what an amazing job she's doing and that one of the babies is almost out; then quickly you release Joy's hand and fetch a bowl of warm water and wet the towel, making sure it's not too hot. Slowly you rub Joy's belly, telling her to stay strong.");
			outputText("\n\n\"<i>I'm trying.</i>\" She puffs. \"<i>But I, like, really want these kids to get outta meee!</i>\" She squeals at yet another contraction. \"<i>Like, how did I end up going through this - I was born a boy!</i>\" She grits her teeth and pushes with all her might.");
			outputText("\n\nYou hold the baby mouse in your hands as Joy's final push finally pushes it out of her birthing canal; it squeaks and cries meekly as you wash it with the warm towel, before wrapping him neatly and placing the small squeaking bundle next to one of Joy's breasts.");
			outputText("\n\nJoy lets out a relieved sigh. \"<i>Aw... ain't you such a cutie? You put mommy through a lot of work to get here, but aren't you just worth it?</i>\" She coos, cuddling the mouselet to her breast and letting it nurse.");
			outputText("\n\nYou watch Joy lovingly cuddling her baby, but a second look at Joy's moving belly signals that her ordeal is not over.");
			outputText("\n\nJoy grunts indignantly. \"<i>Like, what now?</i>\"");
			outputText("\n\nWith a sigh, you mention to Joy that there's still more to come.");
			outputText("\n\n\"<i>Oh yeah, I, like, totally forgot when you put this little cutie in my arms.</i>\" She cuddles her firstborn, then takes a stoic sigh. \"<i>Alright, let's get this other one out of me.</i>\" She says, putting on a determined expression.");
			outputText("\n\nHowever Joy's determination doesn't help much as soon after a pained squeak assaults your ears and you get ready to repeat the process.");
			doNext(joyGivesBirthPart2);
		}
		private function joyGivesBirthPart2():void {
			clearOutput();
			var babyGender1:int = 0;
			var babyGender2:int = 0;
			switch(rand(10)) { //Decide the gender of the first baby.
				case 0:
				case 1:
				case 2:
				case 3:
					babyGender1 = 1; //Male
					break;
				case 4:
				case 5:
				case 6:
				case 7:
					babyGender1 = 2; //Female
					break;
				case 8:
				case 9:
					babyGender1 = 3; //Hermaphrodite
					break;
				default:
					babyGender1 = 3;
			}
			switch(rand(10)) { //Second baby mouse!
				case 0:
				case 1:
				case 2:
				case 3:
					babyGender2 = 1; //Male
					break;
				case 4:
				case 5:
				case 6:
				case 7:
					babyGender2 = 2; //Female
					break;
				case 8:
				case 9:
					babyGender2 = 3; //Hermaphrodite
					break;
				default:
					babyGender2 = 3;
			}
			outputText("Finally, when everything is over, Joy is cradling two babies in her arms, watching them with tired satisfaction as they greedily suckle from her bountiful DD-cup breasts. \"<i>Aren't they just, like, too beautiful?</i>\" She asks you, clearly making a rhetorical comment.");
			outputText("\n\nYou smile and nod in agreement, now taking the time to get a better look at the babies... now you can see that Joy gave birth to a beautiful ");
			//Gender of babies
			if (babyGender1 == babyGender2) { //Are the twins same gender?
				outputText("pair of ");
				switch(babyGender1) {
					case 1:
						outputText("boys");
						break;
					case 2:
						outputText("girls");
						break;
					case 3:
						outputText("herms");
						break;
					default:
						outputText("herms");
				}
			}
			else { //Gender not equal!
				switch(babyGender1) {
					case 1:
						outputText("boy");
						break;
					case 2:
						outputText("girl");
						break;
					case 3:
						outputText("herm");
						break;
					default:
						outputText("herm");
				}
				outputText(" and a ");
				switch(babyGender2) {
					case 1:
						outputText("boy");
						break;
					case 2:
						outputText("girl");
						break;
					case 3:
						outputText("herm");
						break;
					default:
						outputText("herm");
				}
			}
			outputText(". The babies are very cute and you can see that their fur color is the same as their mother's, and when you look at them closely you see a few features that closely remind you of yourself.");
			outputText("\n\nJoy looks up at your own smiling face. \"<i>You know... since these two sweeties are, like, just so cute... let's have some more! Right now!</i>\" She states cheerfully.");
			outputText("\n\nYou gasp in surprise at Joy's enthusiasm; you ask her if she's sure she wants more right now, especially since she said earlier she shouldn't have to go through with this since she was born a boy.");
			outputText("\n\n\"<i>Uh... Well, gee, I guess maybe I wasn't thinking about it.</i>\" She concedes.");
			outputText("\n\nYou chuckle and pat her head, telling her you two can think about this later, right now she should get some rest.");
			outputText("\n\nJoy nods her head, yawns, and falls back, closing her eyes and getting ready to sleep.");
			outputText("\n\nYou take one last look at her and the babies, before taking your leave.");
			flags[kFLAGS.JOY_TWINS_BIRTHED]++;
			if (flags[kFLAGS.JOY_TWINS_BIRTHED] >= 3 && flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] == 0) flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] = 72;
			jojoScene.pregnancy.knockUpForce(); //Clear pregnancy
			doNext(playerMenu);
		}
		
		//Night fuck scene
		public function hornyJoyIsPregnant():void {
			clearOutput();
			outputText("You're about to head into your " + camp.homeDesc() + " to rest after a day of adventuring, when you see Joy approach you.");
			outputText("\n\n\"<i>Like, [name]?</i>\" Joy pleads. \"<i>The babies, like, won't stop kicking in my belly, and I'm sooo horny, too. Can we, like, please have some sex? I don't think I'll ever be able to, y'know, get some sleep if I don't take the edge off and make the babies calm down.</i>\"");
			doYesNo(acceptJoyNightFuck, declineJoyNightFuck)
		}
		
		private function acceptJoyNightFuck():void {
			clearOutput();
			outputText("You tell her since it was you that put the babies inside her, you might as well as help her through it.");
			outputText("\n\n\"<i>Yay!</i>\" She cries, and claps her hands in delight. Then she pauses and rubs her chin thoughtfully. \"<i>Now, like, how do we do this...?</i>\" She murmurs, clearly unsure of how to proceed.");
			outputText("\n\nYou take the initiative and draw her in for a kiss, rubbing her belly with a hand. Then you move behind her and begin pulling her clothes apart, slowly but teasingly undressing her.");
			outputText("\n\n\"<i>Oooh, like, no need to play around with me, sugar.</i>\" She tells you, tail curling into a heart shape and waving in the air. \"<i>I'm, like, totally ready to fuck.</i>\"");
			outputText("\n\nYou smirk at her and continue slowly undressing her.");
			outputText("\n\nThe mouse whines softly. \"<i>Like, that's not fair. Well, if you insist...</i>\" She smirks, then starts to wriggle in your grip, trying to pull free so she can start undressing you.");
			outputText("\n\nNo sooner is her crotch exposed than she pounces upon you" + player.clothedOrNakedLower(", starting to tear away at your [armor] until your " + player.cockDescript() + (player.hasVagina() ? " and " + player.vaginaDescript() + " are" : " is") + " revealed") + ". \"<i>Like, what are you waiting for? Fuck me!</i>\" The rodent-morph bimbo pleads, thrusting her crotch at you for emphasis.");
			outputText("\n\nYou grin and move towards her, pushing her inside your " + camp.homeDesc() + " and over your " + camp.bedDesc() + ". You grope her pillowy breasts and kiss her, slowly humping against her leg as you drive her further into a lust craze.");
			outputText("\n\nIt doesn't look like the mouse needs any further stimulation, though. She grinds her swollen belly " + joyHasCockText("and painfully erect, pre-gushing cock ") + "against your midriff, clumsily trying to slot your " + player.cockDescript() + " into her ravenous pussy.");
			outputText("\n\nFinally satisfied with the foreplay, you align yourself and push your " + player.cockDescript() + " into her warm, inviting depths.");
			outputText("\n\n\"<i>Ooh, yeah, that hits the spot, [name]!</i>\" Joy squeals. \"<i>Fuck me hard; like, show my babies who their " + player.mf("daddy", "daddy-mommy") + " is!</i>\"");
			outputText("\n\nYou intend to do just that; you thrust into her with all the strength you can muster, rocking her and the babies inside with every wet slam of your hips against hers. " + joyHasCockText("Her cock dribbles pre like an open tap, glazing your crotch as well as her belly. ") + "One of you hands strokes her bulging belly, the other gropes her breast, as your rhythms grows more franctic.");
			outputText("\n\nJoy gasps and moans, slamming back against you just as hard and furious, her swollen belly wobbling all over the place as she does - when she pushes hard against you, you can actually feel the babies inside kicking and squirming inside her; she wasn't joking about how active they are after all. She babbles incoherently, urging you on.");
			outputText("\n\nAs you approach your inevitable orgasm an idea hits you, and you withdraw from Joy.");
			outputText("\n\n\"<i>Hey! What gives?</i>\" She complains. When she sees what you're doing, though, she grins, her eyes lighting up. \"<i>Well, this looks fun!</i>\" She grins.");
			outputText("\n\nYou gently grab her butt and lift it off the ground, pressing the tip of your " + player.cockDescript() + " against Joy's rosebud, letting your leaking pre lube her up before you enter her.");
			outputText("\n\nJoy squeaks softly and wriggles, trying to rub her asshole against your cockhead and get herself fully lubed, impatient to let you in so she can finally climax.");
			outputText("\n\nOnce you're satisfied, you press on and enter the warm depths of Joy's tight ass.");
			outputText("\n\nJoy squeaks loudly and starts to piston up and down, her anus squeezing you like a hot, fleshy vice. \"<i>Oh yes-yes-yes! Gonna cum, gonna cum, gonna cuuuum!</i>\" She squeals, thrashing like a fish on a hook. She clenches up and juices rain down from her flexing cunt, splashing onto your midriff" + joyHasCockText(", her cock spraying cum all over your front as she experiences orgasm in her male half") + ".");
			outputText("\n\nJoy's orgasm brings you ever closer to your own, and with a few more violent thrusts you push into her one last time and blow your load, filling her clenching ass with as much cum as you can muster.");
			if (player.cumQ() >= 500) {
				outputText("Joy gasps as your seemingly limitless load fills her to the brim and beyond. Her belly inflates even more than before, making it look like she's holding a litter far bigger than twins; yet you don't stop, you're too far gone to stop now, you continue to fill her even as your cum backflows and begins leaking around your cock.");
			}
			outputText("\n\nJoy pats her belly" + (player.cumQ() ? " newly swollen from your huge influx of spunk" : "") + ", and yawns hugely. \"<i>Like... That really, really hit the spot. An' the babies have settled down, too... I feel so sleepy. Like, thanks, [name].</i>\" She says softly, eyes already half-lidded and starting to sway from side to side.");
			outputText("\n\nYou pull out from the sleeping mouse and gaze at your handiwork; the two of you really made a mess of your " + camp.homeDesc() + " and your " + camp.bedDesc() + " is completely matted with mouse femcum as well as some of your own. You consider tidying the place up a bit, but you're too tired to do any kind of work right now; this little tryst with Joy has left you completely drained, although very satisfied as well...");
			outputText("\n\nYou shrug and lay down beside Joy, gently stroking her belly as you do. Joy reaches out and embraces you, snuggling up and you sigh, letting sleep overtake you.");
			outputText("\n\n\"<i>Love you...</i>\" Joy murmurs sleepily.");
			player.orgasm();
			dynStats("cor", -(1 + Math.ceil(player.cor / 20)));
			flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY]++;
			flags[kFLAGS.JOJO_ANAL_XP]++;
			flags[kFLAGS.JOY_NIGHT_FUCK] = 1;
			doNext(camp.sleepWrapper);
		}
		
		public function wakeUpWithJoyPostFuck():void {
			clearOutput();
			outputText("Your dreaming take a turn to the sexy. In your dreams you're wandering through the fields when you feel your " + player.cockDescript() + " become engorged and throb, upon exposing your shaft you see it is painfully erect, beads of pre forming on the tip and quickly sliding down your shaft. You moan as pleasure fills you, even though you haven't even touched your shaft; despite that it feels like something or someone is giving you a wonderful blowjob...");
			outputText("\n\nYou open your eyes and when you look down, you see Joy...");
			outputText("\n\nThe gravid mouse is lying down while trying to avoid squishing her gravid belly and the precious cargo it contains, tail sweeping playfully from side to side in the air above her shapely rump as she bobs up and down on your erect " + player.cockDescript() + ", softly humming around the obstruction in her mouth. Seeing you awake, she pulls free with an audible pop, smacks her lips and grins at you. \"<i>Like, g'morning, [name]!</i>\" She squeaks happily, then starts to lick and slurp on your prick again without a care in the world.");
			outputText("\n\nYou groan in pleasure as your " + player.cockDescript() + " rewards Joy's service with copious amounts of pre-cum; you feel like you should say something, but you don't think Joy would even listen to you right now, so you decide to wait until she's done.");
			outputText("\n\nJoy stuffs your cock as far into her mouth as she can go - you're amazed at her lack of gag reflex, bobbing her head up and down without a care in the world, tail swishing lazily through the air. She starts to mumble something; you think it might be a refrain of \"<i>come on, baby, gimme yer cum</i>\", but it's hard to understand her with her mouth full.");
			outputText("\n\nYou feel your inevitable orgasm quickly approaching and with a final groan you give Joy just what she wants, a huge load of cum.");
			outputText("\n\nJoy greedily starts to suck as hard as she can, determined to swallow every last drop she can. ");
			if (player.cumQ() < 100) outputText("She succeeds without a slightest hitch");
			else if (player.cumQ() < 1000) outputText("Although her already distended belly swells out even further, she manages to drink it all");
			else outputText("Amazingly, she manages to keep swallowing and swallowing, even though she ends up wallowing on a belly that could pass for a waterbed as the cum distorts her already swollen midriff");
			outputText(". She finally detaches herself, takes a few deep breaths, and then smacks her lips appreciatively. \"<i>Like, you sure know how to feed a girl what she needs.</i>\" She giggles.");
			outputText("\n\nYou can't help but ask what brought this on? Not that you don't appreciate waking up like that, but you're curious.");
			outputText("\n\n\"<i>Like, I'm just being a good momma to be.</i>\" The bimbofied mouse states proudly, ");
			if (player.cumQ() < 100) outputText("getting up.");
			else if (player.cumQ() < 1000) outputText("struggling to get to her feet with her newly enlarged belly.");
			else outputText("wobbling back and forth on her personal waterbed.");
			outputText("\n\nYou ask, \"<i>what do you mean?</i>\"");
			outputText("\n\n\"<i>Well, cum makes the babies grow strong and healthy inside their mommy's tummy. So a mommy-to-be, if she's a good mommy, will drink lots of spooge so her babies are really healthy and strong.</i>\" She explains lightly.");
			outputText("\n\nYou feel like you should talk to Joy about that... so you point out that's not true...");
			outputText("\n\nJoy gives you a sarcastic look. \"<i>Oh, really, so how do you know it's not true?</i>\"");
			outputText("\n\nFrom the looks of it, Joy is not convinced, so you tell her that every other woman in your village - and quite possibly this world - doesn't drink even a single drop of cum and their babies have no problems.");
			outputText("\n\n\"<i>Well, how do you know that, like, their babies wouldn't have been healthier if they had, hmm?</i>\" She sniffs.");
			outputText("\n\nYou sigh... it doesn't look like you can convince Joy... besides is there any harm to letting her think so? You're just too sleepy to argue, so you concede and tell Joy that she has a point.");
			outputText("\n\nJoy suddenly yawns. \"<i>Well, I guess maybe I, like, ate a little too much. I'm gonna go get some more sleepy done.</i>\" She promptly ");
			if (player.cumQ() < 100) outputText("walks away");
			else if (player.cumQ() < 1000) outputText("totters away");
			else outputText("manages to scrabble along on all fours");
			outputText(", heading back to her personal nest.");
			outputText("\n\nGetting a bit more sleep sounds just fine, so you flop down on your " + camp.bedDesc() + " and close your eyes.");
			player.orgasm();
			flags[kFLAGS.JOY_NIGHT_FUCK] = 0;
			doNext(camp.sleepWrapper);
		}
		
		private function declineJoyNightFuck():void {
			clearOutput();
			outputText("You tell Joy you're sorry, but you're just not in the mood right now... she'll have to find another way to relieve herself.");
			outputText("\n\nThe bimbo mouse looks at you, and starts to sniffle, tears beginning to trickle down her cheeks. When she sees you aren't budging, though, she stops and sighs. \"<i>Like, if that's the way it's gotta be.</i>\" That said, she sadly shuffles away, stroking her belly and murmuring to her twins.");
			doNext(camp.sleepWrapper);
		}
		
		//Player
		public function playerGivesBirthToJoyBabies():void {
			var babyGender1:int = 0;
			var babyGender2:int = 0;
			switch(rand(10)) { //Decide the gender of the first baby.
				case 0:
				case 1:
				case 2:
				case 3:
					babyGender1 = 1; //Male
					break;
				case 4:
				case 5:
				case 6:
				case 7:
					babyGender1 = 2; //Female
					break;
				case 8:
				case 9:
					babyGender1 = 3; //Hermaphrodite
					break;
				default:
					babyGender1 = 3;
			}
			switch(rand(10)) { //Second baby mouse!
				case 0:
				case 1:
				case 2:
				case 3:
					babyGender2 = 1; //Male
					break;
				case 4:
				case 5:
				case 6:
				case 7:
					babyGender2 = 2; //Female
					break;
				case 8:
				case 9:
					babyGender2 = 3; //Hermaphrodite
					break;
				default:
					babyGender2 = 3;
			}
			outputText("As you wander through your camp, a heavy cramp hits you in the belly, followed by a rush of fluids that gush from your " + player.vaginaDescript() + ". Figuring it must be time, you yell, calling for Joy.");
			outputText("\n\nThe mouse promptly wanders over. \"<i>Like, [name]? What's up? Why all the shouting? ...And " + player.clothedOrNakedLower("what happened to your [armor] - ") + "did you, like, pee yourself or something?</i>\" She asks, giving you a completely baffled expression.");
			outputText("\n\nYou're in too much pain to explain right now, so you yell at Joy to help you undress, quick! And then to help you into your bed.");
			outputText("\n\n\"<i>Like, what's going on?</i>\" Joy asks, but she, thankfully, instinctively starts doing what you told her to do; within moments she " + player.clothedOrNakedLower("has your [armor] off and ") + "is " + (player.isNaga() ? "slithering" : (player.isGoo() ? "sliding" : "walking")) + " you over to your " + camp.bedDesc() + ", where she helps you down.");
			outputText("\n\nYou groan in pain and hold your belly as another rush of fluids escape you.");
			outputText("\n\n\"<i>Ew! Like, you don't go to the toilet in your bed!</i>\" The mouse bimbo squeaks in disgust.");
			outputText("\n\nIf you weren't in so much pain right now, you swear you would slap her! In a sudden rush of strength you pull her close by her robes and manage to utter, \"<i>t-the babies...</i>\"");
			outputText("\n\n\"<i>The babies! Here! Now! Like, what do I do, what do I do?!</i>\" She squeals, clearly panic-stricken.");
			outputText("\n\nThe pain finally recedes a bit and you manage to grab Joy's hands and instruct her to fetch you a few towels and bring you a bottle of water.");
			outputText("\n\nShe nods her head frantically. \"<i>Right, right, I can do that!</i>\" She squeaks and scurries off. Moments later, she comes racing back with what you asked for, nearly tripping over herself in her haste.");
			outputText("\n\nYou can feel the contractions beginning and your breathing becomes laboured; slowly you extend a hand towards Joy.");
			outputText("\n\nThis, she is, however, smart enough to recognize and she immediately takes hold of it. \"<i>I'm, like, here for you, [name].</i>\"");
			outputText("\n\nYou squeeze her hand as you feel the first of the babies slowly begin it's trek down your birthing canal.");
			outputText("\n\nJoy squeezes right back. \"<i>Like... what am I supposed to do?</i>\" She pleads. \"<i>I can't remember what to do.</i>\"");
			outputText("\n\nYou tell her to look and tell you when she can see the baby's head, groaning as you begin pushing.");
			outputText("\n\nJoy immediately scurries around to position herself in front of your " + player.vaginaDescript() + ". ");
			outputText("\n\nYou push a few more times, until finally Joy cries out, \"<i>I can see the head! What do I do now!?</i>\"");
			outputText("\n\nYou tell Joy to grab a towel and gently help the baby along.");
			outputText("\n\nWith one last groan you push with all your might, finally birthing your new (son/daughter) into the world. Panting, you tell Joy to clean him/her as best as she can and take her to nurse from your breasts.");
			outputText("\n\n\"<i>Okey-dokey.</i>\" Joy says, and you can hear the baby squalling as his/her bimbo herm 'father' rubs him/her clean, the complaints stopping as s/he is placed against your " + player.breastDescript(0) + ", rooting for your " + player.nippleDescript(0) + " and hungrily latching on. \"<i>Right; that's one, now it's time to get the other out.</i>\" Joy says cheerfully, patting your still-distended midriff.");
			outputText("\n\nYou groan upon the realisation your ordeal is not over, then moan as a new contraction hits you. This time however, Joy knows what to do, so things go a whole lot smoother.");
			outputText("\n\nSoon enough, you have two hungry little mouselets, both with your hair color, sucking greedily away at your bosom. Joy crouches over the three of you and watches in awe. \"<i>Aren't they just beautiful?</i>\" She asks, sounding all-too-pleased with herself.");
			outputText("\n\nYou feel like it's finally over and a sense of deep pride and happiness, as well as tiredness, overcome you as you nurse your two mouselets... you can't help but agree once mentions how they are beautiful...");
			outputText("\n\n\"<i>It looks like we've got a ");
			//Gender of babies
			if (babyGender1 == babyGender2) { //Are the twins same gender?
				outputText("pair of ");
				switch(babyGender1) {
					case 1:
						outputText("boys");
						break;
					case 2:
						outputText("girls");
						break;
					case 3:
						outputText("herms");
						break;
					default:
						outputText("herms");
				}
			}
			else { //Gender not equal!
				switch(babyGender1) {
					case 1:
						outputText("boy");
						break;
					case 2:
						outputText("girl");
						break;
					case 3:
						outputText("herm");
						break;
					default:
						outputText("herm");
				}
				outputText(" and a ");
				switch(babyGender2) {
					case 1:
						outputText("boy");
						break;
					case 2:
						outputText("girl");
						break;
					case 3:
						outputText("herm");
						break;
					default:
						outputText("herm");
				}
			}
			outputText(".</i>\" Joy notes. She gently reaches out to stroke the nearest one's ear.");
			outputText("\n\nYou barely register Joy's comment though, the feeling of your breasts being slowly drained of their milk feels so nice, you can't help but fall asleep...");
			player.knockUpForce(); //Clear pregnancy
			player.cuntChange(60, true,true,false);
			if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) player.vaginas[0].vaginalWetness++;
			if (player.gender == 1) player.gender = 3;
			if (player.gender == 0) player.gender = 2;
			player.orgasm();
			dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
			flags[kFLAGS.JOY_TWINS_BIRTHED]++;
			if (flags[kFLAGS.JOY_TWINS_BIRTHED] >= 3 && flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] == 0) flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] = 72;
			incrementJoysCockFondness(4);
			playerGivesBirthToJoyBabiesPart2();
		}
		
		public function playerGivesBirthToJoyBabiesPart2():void {
			outputText("\n\n<b>Some time passes...</b>");
			outputText("\n\n\"<i>Morning, [name]! The babies are sleeping in my tent; I, like, didn't want you to have to worry. They're both, like, fast asleep.</i>\" Joy greets you.");
			outputText("\n\nYou yawn and rub the sleep off your eyes, thanking Joy for her help.");
			outputText("\n\n\"<i>Like, it's nothing.... [name]?</i>\" She asks, softly.");
			outputText("\n\nYou perk up, listening attentively to what Joy has to say.");
			outputText("\n\n\"<i>Don't you think our babies are so cute...? Well, let's make some more then! Right away!</i>\ The bimbo hermaphrodite enthuses.");
			outputText("\n\nYou laugh at Joy's offer; then tell her to give you a break and let you at least recover from this birth before suggesting something like that.");
			outputText("\n\n\"<i>Like, I'm sorry, I guess I just wasn't thinking, huh, [name]?</i>\" Joy replies, clearly abashed.");
			outputText("\n\nUpon seeing that, you give her a hug, ruffling her hair and tell her you'll think about it.");
			outputText("\n\nJoy smiles, leans into the hug, then wanders off, presumably to check on your kids.");
			//Butt increase
			if (player.buttRating < 14 && rand(2) == 0) {
				if (player.buttRating < 10) {
					player.buttRating++;
					outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);				
				}
				//Big butts grow slower!
				else if (player.buttRating < 14 && rand(2) == 0) {
					player.buttRating++;
					outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);
				}
			}
			outputText("\n");
		}
		
		public function joyTakesTheBabiesAway():void {
			clearOutput();
			outputText("You wander back into your camp, but notice something seems to be amiss...");
			if (camp.amilyFollower()) { //Bonus points if Amily is in camp!
				outputText("\n\n\"<i>Like, looking for our babies, [name]?</i>\" Joy asks, appearing at your side.");
				outputText("\n\nOnce you get over the shock of Joy's sudden appearance, you realize that this is exactly what's been amiss... you ask her what happened to the children.");
				outputText("\n\n\"<i>Like, I was talking about them to Amily and we decided it'd be safer for them and us if they, like, went to live with their half-brothers and sisters. You know? The ones that, like, you've had with Amily?</i>\" Joy states cheerfully.");
				outputText("\n\nAt the mention of her name Amily shows up beside Joy. \"<i>Yes, [name]. Keeping them here might not be the best decision; we're bound to come across demons sooner or later, so it's best to keep them away when we do. Besides our children will look after them, so you nor Joy have to worry about them.</i>\"");
				outputText("\n\n\"<i>Plus, they'll, like, always have somebody to play with when they're with each other,</i>\" Joy notes.");
				outputText("\n\n\"<i>And they'll be add to the gene pool of mice,</i>\" Amily adds.");
				outputText("\n\nAfter you hearing both girls, you'll have to agree... it's not like you really had a lot of time to play with your children, since you're usually out adventuring... so you smile at them and say you're okay with this, although you'll miss the little bundles of energy.");
				outputText("\n\n\"<i>Well, in that case...maybe you and I should go and make some more, hmm?</i>\" Joy purrs, leaning up against you and curling her tail into a heart shape for emphasis.");
				outputText("\n\nAmily takes this opportunity to lean against you as well, grinning all the time. \"<i>And I don't want to be left out, we can make more too right?</i>\"");
				outputText("\n\nYou get that Amily's just being playful, but Joy looks serious... so you take a step back and tell them that you'll think about it.");
				outputText("\n\n\"<i>Like, well, don't think about it too hard. I'm ready whenever you are, big " + player.mf("boy", "girl") + ".</i>\" Joy tells you.");
				outputText("\n\nAmily just giggles and walks away.");
			}
			else {
				outputText("\n\n\"<i>Like, looking for the kids, [name]?</i>\" Joy suddenly asks, popping up behind you. Once you get over your shock, she casually continues. \"<i>They're, like, big enough and strong enough to look after themselves now, so I've taken them and moved them, like, out of the camp.</i>\"");
				outputText("\n\nOut of the camp? But they're so small! You ask Joy if she's sure of what she's doing.");
				outputText("\n\n\"<i>Like, I know where it's safe to be out there in the woods. Besides, it's, like, way too dangerous here - you know you've got, like, a big fat glowing target painted on your head by staying here, right?</i>\" The bimbo mouse indignantly defends herself. \"<i>Remember, we Marethians, like, grow up quicker than you humans do, especially since the demons, like, screwed the world up - they're big enough to fend for themselves.</i>\"");
				outputText("\n\nWell Joy does have a point about it not being truly safe here in the camp but...");
				outputText("\n\n\"<i>Believe me, I do go out and check on them... Or is it just that you're lonely without some babies in the camp, hmm?</i>\" She suddenly changes tack, flirtatiously strutting towards you. \"<i>How about you and I, like, make some more, hmm? Right here? Right now?</i>\" She reaches out to stroke a gentle finger down your " + player.faceDesc() + " cheek.");
				outputText("\n\nYou can't help but chuckle at Joy's lewd offer, and you tell her that maybe you can make more later... right now you're just not in the mood.");
				outputText("\n\n\"<i>Okay! But, if you, like, change your mind, you know where to find me.</i>\" Joy coos, then strides away, tail swishing merrily.");
			}
			if (camp.amilyFollower()) flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] = -1; //Doesn't proc again if Amily explained.
			else flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] = 0;
			doNext(playerMenu);
		}
	}

}