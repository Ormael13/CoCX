package classes.Scenes.Places.TelAdre {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class Niamh extends TelAdreAbstractContent implements TimeAwareInterface {
//const MET_NIAMH:int = 446;
//const GOT_NIAMH_BEER:int = 447;
//const TALKED_NIAMH:int = 448;
//-1 = bazaar moved in, 0 = nothing, 1 = trigger time, otherwise time till trigger
//const NIAMH_MOVED_OUT_COUNTER:int = 449;
//0 = normal, 1 = corrupt, 2 = bimbo
//const NIAMH_STATUS:int = 450;
//const NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER:int = 451;
//const TIMES_NIAMH_BAZAAR_MET:int = 452;

		public function Niamh()
		{
			CoC.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			var needNext:Boolean = false;
			if (flags[kFLAGS.NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER] > 1) flags[kFLAGS.NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER]--;
			if (flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER] > 1) flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER]--;
			if (player.findStatusEffect(StatusEffects.BimboChampagne) >= 0) {
				player.addStatusValue(StatusEffects.BimboChampagne,1,-1);
				if (player.statusEffectv1(StatusEffects.BimboChampagne) <= 0) {
					removeBimboChampagne();
					needNext = true;
				}
			}
			if (player.statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				player.addStatusValue(StatusEffects.BlackCatBeer,1,-1);
				if (player.statusEffectv1(StatusEffects.BlackCatBeer) <= 0) {
					blackCatBeerExpires();
					needNext = true;
				}
			}
			return needNext;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

public function telAdreNiamh():void {
	if (flags[kFLAGS.MET_NIAMH] == 0) {
		outputText("\n\nAt a table near the back of the bar sits one of the many curious sights Tel'Adre has to offer: a white-haired, ebony-skinned woman, sporting twitching feline ears and tail.  The curious-looking and mostly human girl sports a pair of form-fitting white leggings and a matching top hat. An unbuttoned leaf-green waistcoat hangs slack around her slender hips, and it doesn't take you long to see the reason for the lack of closure: her ");
		if (model.time.hours <= 8) outputText("massive N-cup breasts, spilling over the table");
		else if (model.time.hours <= 9) outputText("huge M-cup breasts, taking up much of the table");
		else if (model.time.hours <= 10) outputText("great L-cup breasts, advancing far onto the table");
		else if (model.time.hours <= 11) outputText("heavy K-cup breasts, lying on the table for support");
		else if (model.time.hours <= 12) outputText("hefty J-cup breasts, resting comfortably on the table");
		else if (model.time.hours <= 13) outputText("weighty I-cup breasts, dangling to lie on the table");
		else if (model.time.hours <= 14) outputText("squeezable H-cup breasts, settling burdensomely on her chest");
		else outputText("moderately manageable G-cups, trembling with every breath she takes");
		outputText(".  Smooth, touchable skin covers her chest, face, hands and presumably the rest of her; it seems her animalistic accoutrements stop at kitty ears and tail. She takes a deep swig of her drink, following it up with a cute little burp.");
	}
	//This scene only plays if the PC has either Talked to Niamh or has gotten at least 1 mug of Black Cat Beer from her.
	else {
		outputText("\n\nNiamh is seated at her usual place near the back of the bar, ");
		if (model.time.hours <= 8) outputText("her titanic N-cup 'kegs' resting against the thankfully sturdy table in front of her.  Her teats are engorged with the beer she's cursed to carry, and the stuff dribbles out whenever she shifts.");
		else if (model.time.hours <= 14) {
			outputText("her ");
			if (model.time.hours <= 9) outputText("M-cup");
			else if (model.time.hours <= 10) outputText("L-cup");
			else if (model.time.hours <= 11) outputText("K-cup");
			else if (model.time.hours <= 12) outputText("J-cup");
			else if (model.time.hours <= 13) outputText("I-cup");
			else outputText("H-cup");
			outputText(" brew-burdened breasts have clearly gotten smaller as the day dragged on, although they're still uncomfortably sizeable and swollen.");
		}
		else outputText("her G-cup beer-filled boobs far smaller than their morning volume, though still impressive in stature.  You can follow the progress she's made throughout the day by the beer stains running along the wooden surface, trailing from all the way off the table and ending where her boobs now lie.");
	}
}

//Approach:
public function approachNiamh():void {
	clearOutput();

	outputText(images.showImage("niamh-approach-in-bar"));
	if (rand(5) == 0 && flags[kFLAGS.MET_NIAMH] > 0 && (player.hasItem(consumables.BIMBOLQ) || player.hasItem(consumables.SUCMILK)))
	{
		corruptOrBimboNiamhIntro();
		return;
	}
	//(If player has Talked to Niamh or gotten 1+ mugs of Black Cat Beer, replace with the following:
	if (flags[kFLAGS.MET_NIAMH] > 0) outputText("Niamh gives you a friendly, but professional, smile as you draw near.  She smiles and shakes her head knowingly as your gaze inevitably falls to her chest, obviously as full of booze as ever.  Small puddles of alcoholic fluid slowly accumulate from the steady drip of her swollen nipples.  \"<i>Well, hello, consumer - yes, up here - hello, consumer.  Did ye want to try more o' me Black Cat Beer?  Just remember the rules; two bits a glass, treat me gentle, and no sneakin' a drink from 'the tap'.</i>\"");
	else outputText("You approach the burdened woman, hailing her politely.  Her ears twitch at the sound, and she sends a crooked smile your way.  \"<i>What can I do ya for?</i>\" she asks somewhat tiredly, the lilt of her words hinting at an accent.  \"<i>Up for a bit o' the brew, perhaps?</i>\"  Your question regarding why she's peddling alcohol dies in your throat as your gaze inevitably drops to her dusky-toned bosom.  As you watch, a small droplet of cloudy golden liquid forms at her engorged teat and splashes into the growing puddle under the nipple.  From the array of top-bearing beer mugs placed within reaching distance on the ground, you begin to put the pieces together.  Is she actually... lactating beer?  You glance back up at her; she smirks knowingly, casually resting her forearms against her expansive breast-flesh and using them to push together and amplify the already-incredible cleavage.  She takes a deep breath, then chants in a singsong voice, \"<i>Black cat beer, two bits a glass.  Get it quick, for it's goin' fast.  Just treat me gentle, or you're in for a slap, and no, you can't have it 'straight from the tap'.</i>\"  After a couple moments, you shrug, figuring stranger things have happened in Mareth.");

	var beer:Function = null;
	if (player.gems >= 2)
		beer = getANiamhBeer;
	else outputText("\n\n<b>You're too poor for beer.</b>");
	//[Talk] [Get Beer] [Leave]
	simpleChoices("Talk", talkToNiamh, "Get Beer", beer, "", null, "", null, "Leave", leaveNiamh);
}

//[Get Beer]
public function getANiamhBeer():void {
	clearOutput();
	outputText(images.showImage("niamh-get-beer"));
	outputText("\"<i>That'll be two gems,</i>\" she replies.  You hand over the payment, which she holds up to the light and scrutinizes thoroughly.  Satisfied, she drops the things into a sack at her waist.  \"<i>Sorry,</i>\" she mutters. \"<i>I do want to get this damned beer out o' me, but this is still my primary livelihood; I canno' afford to be cheated.  Anyway, here's your mug - you can keep that f'r another two gems; I get 'em cheap.  Go ahead and fill it up, but keep in mind what you're tweakin', right?</i>\"");
	//Feeder
	if (player.findPerk(PerkLib.Feeder) >= 0) outputText("  You understand exactly what she's going through; the weight of a huge pair of breasts, the sensitivity as they engorge with fluids, the near-maddening sensation of the contents sloshing around underneath your straining skin...");
	//(Player has G-cups or bigger;
	else if (player.biggestTitSize() >= 15)
	{
		if (player.lactationQ() == 0)
			outputText("  Not terribly surprising; you know your tits are sensitive, and you don't even make milk in them.");
		else
			outputText("  You can easily imagine just how much trouble she must have, especially given the bulk of her tits are fluid.");
	}
	else if (player.lactationQ() > 0)
		outputText("  You know just how distracting it is to have your tits full of fluid waiting to get out.");

	//([if first time]
	if (flags[kFLAGS.GOT_NIAMH_BEER] == 0)
		outputText("\n\nYou briefly deliberate how you should go about the 'milking' process.  Should you focus on one nipple, or both...?  Deciding on both - most likely easier on the girl that way - you take the proffered mug and prepare to tap the... kegs.");
	else
		outputText("\n\nYou recall how pleased she was last time, when you handled both nipples, so you decide to stick to that. Taking the offered mug from her, you prepare for the extraction.");
	outputText("  Gingerly, as if you're handling fine china, you heft one of her prodigious mammaries and position a teat above your flagon. With gentle nipple-squeezing motions from base to tip, you quickly get a steady stream of booze flowing. She rewards your skilled manipulations with a throaty groan, and little ripples begin flitting across her boob-flesh as she begins trembling in barely-suppressed arousal.");
	outputText("\n\nThe girl's hands clamp to her seat as she tries her hardest to disguise her pleasure... unsuccessfully.  Filling your mug around halfway, you push the nipple to the side and move to the other.  The cat-girl's expression gradually changes from excited to nearly orgasmic as the teasing goes on.  The stream of beer easily begins again, and your cup fills surprisingly fast.  You release her tit and cap the mug, to prevent spilling. You now have a mug of Black Cat Beer.  ");
	if (flags[kFLAGS.MET_NIAMH] > 0)
		outputText("Niamh ");
	else
		outputText("the cat-girl ");
	outputText("sighs in relief, biting her lower lip slightly.");
	//General Ending
	outputText("\n\nYou think her breasts may have decreased in size somewhat, but with how massive they are it's hard to tell.  She blushes, trying her hardest to conceal the grinding against her chair.  \"<i>Faith, you're good with yer hands,</i>\" she veritably purrs.  \"<i>Will ye be drinkin' it here or takin' the mug t'go?</i>\"");
	player.gems -= 2;
	statScreenRefresh();
	//[Here][To Go]
	var togo:Function =null;
	if (player.gems >= 2) togo = blackCatBeerToGo;
	else outputText("\n\n<b>You're too poor to buy the mug.</b>");
	flags[kFLAGS.GOT_NIAMH_BEER]++;
	simpleChoices("Here", drinkNiamhsBeerInTelAdre, "To Go", togo, "", null, "", null, "", null);
}

//[Here]
private function drinkNiamhsBeerInTelAdre():void {
	clearOutput();
	if (player.lactationQ() >= 300 && player.biggestTitSize() >= 5 && rand(2) == 0 && flags[kFLAGS.MET_NIAMH] > 0) {
		outputText("\"<i>Skoal!</i>\" you cheer as you down the delicious mug of booze.  The incredibly potent beverage warms you down to your chest and beyond.  The heat of the alcohol trails like fire down into your gut and warms your genitals, causing you to feel more aroused.  The buzz of the beverage makes you light headed, as if thinking had become a little more difficult.");
		outputText("\n\nYou start to stumble as your sense of balance shifts and you realize the heat in your body is expanding outwards.  Looking down you see it isn't the heat that's expanding, but your own bountiful tits.  Each of your [fullChest] have gained two full cup sizes, and within seconds they've gained even more.  Beneath your clothes your areola darken in color and you can feel each nipple throbbing with the need to expel its milky contents.");
		outputText("\n\n\"<i>Oh me, ma darlin'.</i>\"  Niamh comments, \"<i>Those beauties o' yours look to be burstin' out o' ye...</i>\"  Your [armor] falls open as your enlargening breasts swell too large to be contained.  Each of your nipples fatten up and begin squirting a liquid that looks unusual.");
		outputText("\n\nYou lean back against the bar as the weight on your chest grows ever heavier.  You gasp for air as the growth arouses you even further.  You feel a hand on your wrist and Niamh pulls you around behind the bar.  She grabs a shot glass and holds it up to one of your sensitive nipples, collecting the beverage before sniffing it.");
		// Description depends on Holiday.
		// New Years
		if (isHolidays() && date.date >= 31) {
			outputText("\n\n\"<i>Cor, well ah'll be.  Sweetie, you be leaking Champagne.</i>\"  She gives your other nipple a tweak to fill a second shot glass.  The same clear liquid pours out, and the little champagne bubbles tickle your nipples to new heights of sensitivity, causing your ");
			if (player.hasVagina()) outputText("pussy to wetten");
			if (player.gender == 3) outputText(" and ");
			if (player.hasCock()) outputText("[eachCock] to stiffen");
			outputText(".  \"<i>Ye know, I got's an idea.  How's about ye stick by me for the next hour.  I'm sure ye must be diein' to drain those big'uns of yours.  We might as well sell your champagne ta the patrons.  Whaddaya say Lassie?</i>\"");
			//[SELL YOUR BOOZE]  [LEAVE]
		}
		// Saint Patrick's
		else if (date.date == 17 && date.month == 2) {
			outputText("\n\nNiamh smiles.  The liquid in the shot glass is rich and dark, and you can't help but notice the foam that coats both the top of it and your nipples.  \"<i>Now this lass would be what I call a great lager.</i>\"  Niamh downs the shot quickly.  \"<i>Ah, that really hits the spot.  Wish I could squirt me a good mug o' that every so often.</i>\"  With a cat like grin she smiles at you before suggesting, \"<i>Tell you what sweetie.  We prop you and those big titties o' yours here on the bar and milk that beautiful rich lager out o' you for the next hour.  Make you a fair bit o' gems and alleviate that aweful swellin'.  What ye say sweetie?</i>\"");
			//[SELL YOUR BOOZE]  [LEAVE]
		}
		// Christmas
		else if (isHolidays()) {
			outputText("\n\nThe off color indicates it isn't milk filling the shot glass, but you aren't sure what it is.  Niamh darts her tongue into it and grins.  \"<i>Ooooh.  Mmmmm.  Egg nog.  So delicious.</i>\"  She slurps the whole shot glass backs and then blinks.  \"<i>Whoah.  An' rather strong shtuff to boot!</i>\"  She wraps an arm around your shoulders.  \"<i>Lass, I bet those puppies of yours are gonna be squirting that holiday joy for awhile.  Hows about ye let me prop ye up onna bar here and sell that liquid cheer of yours?  I bet it won't take long to drain them considering how delicious ye are.  Make you a fair bit o' gems too!</i>\"");
			//[SELL YOUR BOOZE]  [LEAVE]
		}
		// Valentine's
		else if (isValentine()) {
			outputText("\n\nThe aroma is distinct and Niamh comments, \"<i>My, that's quite a delectable white wine you're leakin' there lass.</i>\"  She pulls on another nipple to drain a bit more from you.  \"<i>Mmmmm, and the other is a good red.</i>\"  She grins.  \"<i>I bet there are a bunch o' couples in town that'd pay good gems for what you've got sloshin' around inside those babies there.</i>\"  She cuddles up close to you.  \"<i>What you say sweetie?  Gimme an hour o' your time?  See if the bar goers can drain you dry?  Ah'll make it worth ye worth.</i>\"  She winks.");
			//[SELL YOUR BOOZE]  [LEAVE]
		}
		// Non-Holiday, Generic
		else {
			outputText("\n\n\"<i>Well lass, it looks like those big ole titties o' yours are takin' a cue from me.  Sorry 'bout that.  Musta been the beer.</i>\"  She gives your other nipple a tweak to fill a second shot glass.  \"<i>Yup, definitely the beer.  You're lactatin' some delicious booze now, jus' like me.  Dinnae worry.  Ah seen it happen before.  Usually don't last long.  But seein' as how you're leaking some good beer there, what's you say to selling some o' it?  Afterall, I can't 'ave ye givin' the stuff away fo' free while I'm chargin' for it, right?</i>\"");
			//[SELL YOUR BOOZE]  [LEAVE]
		}
		simpleChoices("SellYourBooze", sellYourBooze, "", null, "", null, "", null, "Leave", leaveWithBeerTits);
		return;
	}
	outputText("You yell \"<i>Skoal!</i>\" and upend the mug into your mouth, drinking greedily.  The warmth of the booze quickly follows the liquid itself - potent stuff, this is.");
	//PC is affected by Black Cat Beer item effects
	blackCatBeerEffects(player,false,true);
	//both output
	if (model.time.hours <= 15) outputText("\n\n\"<i>Thanks for the business, " + player.mfn("laddie","lassie","customer") + "!  Remember, Niamh sells her Black Cat Beer every day from 8 until 4.</i>\"  You nod your head in thanks and step away from the table.");
	//16:00 ending
	else {
		outputText("\n\nThanks to your efforts, ");
		if (flags[kFLAGS.MET_NIAMH] == 0) outputText("the cat girl's");
		else outputText("Niamh's");
		outputText(" breasts have had the last of their beer squeezed from them.  She sighs in relief, caressing her shrunken breasts; while still hovering at around G-cup size, they're much smaller than they are when the day starts for her.  \"<i>Me thanks for the business; ye got the last mug for today.  Still, I'll be here tomorrow, full as ever.</i>\" She sighs softly.  \"<i>I regret to say that Niamh's Black Cat Beer doesn't look to be going out of business anytime soon.</i>\"  She stands and gathers her coat, slipping her arms into the sleeves.  The nimble girl draws the garment across her buxom chest, buttoning the slightly strained buttons with deceptive ease.  Dressed properly, she starts away, a bag full of gems bouncing against her swaying hips. You watch her go, staring at her back until she walks out the door.");
	}
	flags[kFLAGS.MET_NIAMH]++;
	doNext(camp.returnToCampUseOneHour);
}

//[To Go]
private function blackCatBeerToGo():void {
	clearOutput();
	outputText("\"<i>That'll be two more gems, then,</i>\" the girl says.  \"<i>Though, if your hands get any more skillful I might have to pay you to take it,</i>\" she flirts.  You pass over two more gems, and she gratefully bags them and beams you a smile.");
	player.gems -= 2;
	statScreenRefresh();
	//both output
	if (model.time.hours <= 15) outputText("\n\n\"<i>Thanks for the business, " + player.mfn("laddie","lassie","customer") + "!  Remember, Niamh sells her Black Cat Beer every day from 8 until 4.</i>\"  You nod your head in thanks and step away from the table.");
	//16:00 ending
	else {
		outputText("\n\nThanks to your efforts, ");
		if (flags[kFLAGS.MET_NIAMH] == 0) outputText("the cat girl's");
		else outputText("Niamh's");
		outputText(" breasts have had the last of their beer squeezed from them.  She sighs in relief, caressing her shrunken breasts; while still hovering at around G-cup size, they're much smaller than they are when the day starts for her.  \"<i>Me thanks for the business; ye got the last mug for today.  Still, I'll be here tomorrow, full as ever.</i>\" She sighs softly.  \"<i>I regret to say that Niamh's Black Cat Beer doesn't look to be going out of business anytime soon.</i>\"  She stands and gathers her coat, slipping her arms into the sleeves.  The nimble girl draws the garment across her buxom chest, buttoning the slightly strained buttons with deceptive ease.  Dressed properly, she starts away, a bag full of gems bouncing against her swaying hips. You watch her go, staring at her back until she walks out the door.");
	}
	outputText("\n\n");
	flags[kFLAGS.MET_NIAMH]++;
	//PC gains 1x BCB
	inventory.takeItem(consumables.BC_BEER, telAdre.barTelAdre);
}

//Talk
private function talkToNiamh():void {
	clearOutput();
	//(first time only)
	if (flags[kFLAGS.TALKED_NIAMH] == 0) {
		outputText("You ask the cat-girl to tell you about her past.");
		outputText("\n\n\"<i>The name's Niamh - like the cat noise, eh?  Nya-m? - that's who I am.  I used to be a normal lass... then I stumbled through the portals to this blasted world.  Made the mistake of pickin' up some whiskered fruit an' giving them a samplin'... grew these blasted cat-parts!  So I avoided that lake like th' plague fer a while... ended up in a desert.  Don't know how that happened.  Now, I'm completely lost, and the thirst is killing me - but then, I hear singing.  I charge desperately across a dune, and what do I find?  Some gal sitting in the sand, four big ol' tits hanging out, and guzzling away at a glass of beer - whenever she's empty, she just squirts some more out of her nipples.</i>\"");
		outputText("\n\nShe shrugs, which does impressive things to her cleavage, then notices your downward glance and taunts you with her laugh, which only causes her huge breasts to jiggle all the more.  \"<i>Aye, just like what I got here.  So, anyway, I beg her to share a drink with me, and she kindly agrees.  I'm so thirsty, and the beer's so good, that, well, I stay there drinking for a good long while...</i>\"");
		outputText("\n\nShe trails off, then shakes her head sadly, \"<i>I don't really know what happened next; I figure we must have gotten so drunk together that I asked her to cast the same sort of spell on me.  All I know is, I woke up with a killer headache, and monster tits swollen with beer - and the witch o' the sands is gone.  I somehow managed to lug myself around long enough to find... this city.  That nice fox ");
		if (model.time.hours < 15) outputText("who usually sits over yonder ");
		outputText("helped me in and set me up here so I can... lighten me load.  That bulk's basically all brew; I milk it out all the time, but I just keep making more of th' stuff... I don't know any way to stop.</i>\"  She shakes her head and sighs.  \"<i>Ironically, it's kept a roof over my head since I got here.  Folks are happy to pay for Niamh's Black Cat Beer.  So, did you want some, or are you done here?</i>\" she asks.");
		flags[kFLAGS.MET_NIAMH]++;
		flags[kFLAGS.TALKED_NIAMH]++;
	}
	//(repeated)
	else {
		if (player.isTaur()) outputText("You clop up and stand awkwardly");
		else outputText("You pull up a chair and sit");
		if (rand(2) == 0) outputText(" next to Niamh, and she smiles wearily in response.  A conversation is struck up - meaningless small talk at first, but gradually shifting to... more intimate topics.  Finally, you can't help but ask how she feels when getting 'milked'.  Her cheeks darken and she looks away from you, shaking her head embarrassedly.  \"<i>It's... it's nothin',</i>\" she smiles ruefully, then huffs a resigned sigh.  \"<i>Well, y'can probably see right through that...  It feels fantastic,</i>\" she admits.  \"<i>Way better than it should, no matter how much it happens.  Th' damned witch's spell most likely has somethin' to do with the sensitivity.  Some customers order as many drinks as they can carry just to watch me squirm.  A few have even gotten me to... well, you know,</i>\" she concludes lamely, averting her eyes in shame.  Many moments slip by before she speaks again.  \"<i>...It DOES feel really good,</i>\" she says again, turning back to you with a mischievous glint in her eye. \"<i>I bet some Black Cat Beer sounds mighty good t'you right about now?</i>\"");
		else {
			//(alternative repeated, 50% chance of either)
			outputText(" next to Niamh, and she smiles wearily in response.  A conversation is struck up - meaningless small talk at first, but gradually shifting to... more intimate topics.  You can't help but ask how heavy her hefty chest is.  To your surprise, she actually chuckles.  \"<i>Depends on how well the sales are goin', of course, but typically, they're quite the haul in the mornin',</i>\" she answers, running a hand across a sloshy boob as if to accentuate her point.  \"<i>They're not too bad near the end o' the day, but during the night... let's just say I've taken to sleeping on me side,</i>\" she admits, and you get the picture.  You nearly begin drooling at the mental image of Niamh slowly smothered by her steadily growing beer-tits.  The girl notices your distraction and slyly says, \"<i>Speaking o' which, would ye like a taste o' Black Cat Beer?</i>\"");
		}
	}
	//[Beer] [Leave]
	var beer:Function =null;
	if (player.gems >= 2)
		beer = getANiamhBeer;
	simpleChoices("Beer", beer, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
}
//Leave
private function leaveNiamh():void {
	clearOutput();
	outputText("You decide that you don't really want to talk to this strange cat-girl and, as politely as possible, excuse yourself.");
	//Player returns to Wet Bitch menu
	doNext(telAdre.barTelAdre);
}

//Black Cat Beer
//is affected by Black Cat Beer item effects
public function blackCatBeerEffects(player:Player,clearScreen:Boolean = true,newLine:Boolean = false):void {
	if (clearScreen) clearOutput();
	if (newLine) outputText("\n\n");
	outputText("Uncapping the mug, you swill the stuff down in a single swig, gasping as it burns a fiery trail into your belly.  It's rich and sweet, and damn, but it's strong stuff!");
	outputText("\n\nA wonderful warmth fills your body, making your pain fade away.  However, it also makes your crotch tingle - combined with the relaxation imparted already, you feel <b>very</b> turned-on.  A beautiful, warm, fuzzy sensation follows and fills your head, like your brain is being wrapped in cotton wool.  You don't feel quite as smart as before, but that's all right, it feels so nice...");
	outputText("\n\nYour balance suddenly feels off-kilter and you stumble, narrowly avoiding falling.  You just can't move as fast as you could, not with your head feeling so full of fluff and fuzz; your body prickles and tingles with the warmth once your head feels full, the sensation concentrating around your erogenous zones.  You just feel so fluffy... you want to hold somebody and share your warmth with them, too; it's just so wonderful.");
	//Regain 40 to 60 lost health, increase lust by 10 to 20 points, decrease Intelligence and Speed by 5, increase Libido by 5//
	HPChange(40 + rand(21),false);
	var lib:Number = 0;
	if (player.findStatusEffect(StatusEffects.BlackCatBeer) >= 0) {
		if (100 - player.lib >= 10) lib = 10;
		else lib = 100 - player.lib;
		player.addStatusValue(StatusEffects.BlackCatBeer,1,4);
		player.addStatusValue(StatusEffects.BlackCatBeer,2,lib);
		outputText("\n\nDamn, it's even better with every extra drink!");
		dynStats("spe", -1, "int", -1, "lib", lib, "lus", 30+rand(player.lib/4));
	}
	else {
		if (100 - player.lib >= 10) lib = 10;
		else lib = 100 - player.lib;
		player.createStatusEffect(StatusEffects.BlackCatBeer,8,lib,0,0);
		dynStats("spe", -5, "int", -5, "lib", lib, "lus", 20+rand(player.lib/4));
	}
	player.slimeFeed();
}

//Black Cat Beer Wears Off: This message is displayed eight hours after the last drink.
public function blackCatBeerExpires():void {
	dynStats("spe", 4.5, "int", 4.5, "lib", (-1 * player.statusEffectv2(StatusEffects.BlackCatBeer)));
	player.removeStatusEffect(StatusEffects.BlackCatBeer);
	outputText("\n<b>The warm, fuzzy feeling finally dissipates, leaving you thinking clearer, focusing better, and less horny.  It was nice while it lasted, but it's also good to be back to normal.  Still, a part of you kind of wants another beer.</b>\n");
}

private function giveNiamphBimboLiquer():void
{
	taintNiamh(true);
}

private function giveNiamphSuccubiMilk():void
{
	taintNiamh(false);
}

//Corruption Option
//20% chance of Nyam using this as her opening if PC has >= 90 corruption and either item in inventory
//[corruption chance encounter]
private function corruptOrBimboNiamhIntro():void {
	clearOutput();
	outputText("\"<i>Heya, favored customer,</i>\" the busty kitty greets as you approach.  \"<i>I have a favor to ask!  My drink's empty, and I get bored of me own brew,</i>\" Niamh explains.  \"<i>Would ya mind fetchin' me somethin', or are ye gonna force me to sample me own goods once more?</i>\"");

	outputText("\n\nYou pause, contemplating your options.  While you know of many drinks The Wet Bitch sells, most of them... aren't exactly fit for human - or feline - consumption, in your opinion.  You're stricken with a particularly naughty thought.  Perhaps you could fetch something... ");
	if (player.hasItem(consumables.BIMBOLQ))
		outputText("'bubbly' for her, in the form of the Bimbo Liqueur you got from the imp lord, or ");
	outputText("maybe even a Succubus Milk?  You'll have to consider your options.  On the other hand, of course, something that corruptive would probably mutate her booze-filled boobs, most likely forcing her out of Tel'Adre altogether... and may fall back on your own head, to boot.  What do you do?");

	//[Bimbo][Succubus][Maybe Later] (spacebar should select 'Maybe Later' as long as it's a repeatable

	outputText("\n\n(Editors Note: Succubi Milk Option Currently in beta)\n\n\n");
	
	menu();
	if (player.hasItem(consumables.BIMBOLQ)) addButton(0, "Bimbo", giveNiamphBimboLiquer);
	if (player.hasItem(consumables.SUCMILK)) addButton(1, "S.Milk", giveNiamphSuccubiMilk);
	addButton(4, "Back", maybeLaterNiamh);
}
//[Maybe Later]
public function maybeLaterNiamh():void {
	clearOutput();
	outputText("You chuckle nervously and shake your head, citing your ignorance of all things alcoholic.  Niamh sighs resignedly, reaching forward and grabbing one of her elongated nipples.  With practiced ease, she fills her flagon and takes a deep swig of it.  \"<i>Can't blame me for wantin' a change of pace,</i>\" she mutters.  \"<i>Now, would ye like your own glass of Black Cat Beer, or are ya gonna keep starin' at me tits?</i>\"");
	var beer:Function =null;
	if (player.gems >= 2) beer = getANiamhBeer;
	else outputText("\n\n<b>You're too poor for beer.</b>");
	//[Talk] [Get Beer] [Leave]
	simpleChoices("Talk", talkToNiamh, "Get Beer", beer, "", null, "", null, "Leave", leaveNiamh);
}

//[Succubus Milk] or [Bimbo Liqueur]
public function taintNiamh(bimbo:Boolean = false):void {
	clearOutput();
	outputText("You grab Niamh's glass and one more and head off, making sure to turn a corner before commandeering an empty table.  Plunking the mugs down in front of you, you mutter to yourself as she moves away.");
	//[if sucmilk]
	if (!bimbo) {
		player.consumeItem(consumables.SUCMILK);
		outputText("\n\nYou uncork your bottle of Succubus Milk and pour half into each mug, loving the way the thick, creamy fluid flows.  With each containing a good amount of the stuff, you scoop them up and start towards Niamh.  Her expression brightens when she notices your approach, and she giggles when she regards the two glasses of milk in your hands.  \"<i>Are ye making fun of me?</i>\" she remarks coyly, patting one of her beer-filled boobs gently.  \"<i>Ah well, I haven't had a good glass o' milk in too long... this is milk, yeah?</i>\"");
		outputText("\n\nNiamh reaches for a mug, but you draw it away from her questing hand, instead sinking it into her considerable expanse of cleavage.  A devious grin flits across your features as she subsequently shivers from the cold glass between her fluid-filled bosom.  \"<i>Wh-why you...</i>\" she gasps, quickly snatching the drink and rubbing warmth back into her goosebumped flesh.  \"<i>You scoundrel...</i>\"");
		outputText("\n\nYou respond by raising your glass in toast, and she grudgingly complies.  Your mugs clink together, and she wastes no time in downing the creamy milk.  You raise your own drink to your lips and pretend to sip, not wanting anything to do with what's about to happen.  \"<i>Went down smooth,</i>\" she comments, licking her lips.  \"<i>Say, there... mind if I have a swig o' yours, too?</i>\"  You readily hand the flagon over, marveling at how fast she chugs it.  Niamh gives a happy little burp, and you scoot back a bit in anticipation.");
	}
	//[if bimbo liqueur]
	else {
		player.consumeItem(consumables.BIMBOLQ);
		outputText("\n\nYou pop the seal of your bottle of Bimbo Liqueur, recoiling at the cloying, spiced scent that paints visions of a slutty slave-girl's slightly spread folds.  With a grimace, you pour the potent stuff evenly into the glasses.  Hefting the mugs, you rise and start towards Niamh.");
		outputText("\n\nHer expression brightens when she notices your approach, and she giggles when she regards the quarter-full mugs of liqueur.  \"<i>What, that's it?</i>\" she quips curiously.  \"<i>This stuff had better pack some punch, " + player.mf("lad","lass") + ".</i>\"  You assure her that it will knock her socks off.");
		outputText("\n\nNiamh reaches for a mug, but you draw it away from her questing hand, instead sinking it into her considerable expanse of cleavage.  A devious grin flits across your features as she subsequently shivers from the cold glass between her fluid-filled bosom.  \"<i>Wh-why you...</i>\" she gasps, quickly snatching the drink and rubbing warmth back into her goosebumped flesh.  \"<i>You scoundrel...</i>\"");
		outputText("\n\nYou respond by raising your glass in toast, and she grudgingly complies.  Your mugs clink together, and she wastes no time in downing the cloudy liqueur.  You raise your own drink to your lips and pretend to sip, not wanting anything to do with what's about to happen.  \"<i>Burned pretty good,</i>\" she comments, licking her lips.  \"<i>Say, there...mind if I have a swig o' yours, too?</i>\"  You readily hand the flagon over, marveling at how fast she chugs it.  Niamh gives a happy little burp, and you scoot back a bit in anticipation.");
	}
	//[if succubus milk]
	if (!bimbo) {
		outputText("\n\nAfter several moments, a small groan escapes her lips, her slender hand flying under the table to press against her suddenly gurgling belly.  She looks up at you, horrified, and you only offer a shrug in response.  The increasingly panicked catgirl tries to rise, toppling her table and sweeping aside her empty flagons.  With a surprised cry, she loses her balance and falls onto her cushiony butt, her gigantic boob-barrels flopping onto her lap.  She tries to speak, but can only moan as a shudder runs through her.  Her hand is the first thing to be affected.  Her ebony skin slowly shifts to a blue tone, and she grunts as two nubs poke through her white bob-cut; the fur of her tail recedes, replaced with glimmering blue skin.  The tip of the appendage shivers and changes as well, going from rounded to spade-tipped.");
		outputText("\n\nNiamh abruptly cries out in ecstasy as her libido levels skyrocket and begins to knead her tits fervishly.  You can tell she's getting off on the near-electric thrill of their sensitivity.  Equal parts aroused and amused, you're torn between the desire to watch and the need to make yourself scarce before the Watchmen show up to find you at the scene of a 'demonification'.  As the newly-azure girl raises a teat to her mouth and suckles herself, the other hand dropping to her sopping, needy loins, you decide in favor of discretion and pull yourself away from the spectacle, making sure to back up in mock-horror.  Curiously, as Niamh drinks her own 'lactation', the golden coloration of the brew dribbling out around her lips darkens.  From beer to ale, you muse.  As you exit the door of the tavern, four members of the town guard slip into your place; you make sure to give them the benefit of your confused, terrified acting.");
		outputText("\n\nA crowd of spectators follows as they cart her out, allowing you to slip into the group and watch the proceedings.  Poor Niamh is thrown out of the city unceremoniously, her corrupted bosom spewing ale onto the hot desert sand.  Writhing with a combination of fury and lust, the newly-minted devil's familiar screams profanities and threats between moans, not even bothering to move from her face-down position.  You get one last look at her before the doors close, shutting her out of the desert city completely.  You linger around the city until you figure she'd have moved away from the gate, then make your own way out.");
		flags[kFLAGS.NIAMH_STATUS] = 1;
		dynStats("cor", 5);
	}
	//[if bimbo liquor]
	else {
		outputText("\n\nMoments pass by, and you begin to wonder if the bottle's label wasn't so much fancification... until she burps again, following the sound with a surprisingly bubbly giggle.  Niamh pauses, shaking her head vigorously, as if trying to clear out cobwebs from her skull.  \"<i>Now why'd I go and do that?</i>\" she mutters.  \"<i>What'd ya put in th- oooooh...</i>\"  She raises both arms and presses her boobs together, wincing as sudden arousal washes over her, then moans again, fingers digging into her fluid-filled cleavage.  Niamh's eyes widen as the beer inside churns, then she yelps in delight as the flesh shivers as though the contents had begun to... bubble?  Indeed, her sumptuous bosom bounces gaily as its contents struggle against the skin.  The confused catgirl starts to giggle again as the insidious liqueur takes hold, stroking her cursed chest with increasingly passionate motions.  She does stop momentarily when her hair begins to lengthen, her bob growing into a waist-length ivory shock.");
		outputText("\n\nBefore she can even recover from that surprise, her chalky coiffure darkens, streaks of platinum-blonde beginning at the scalp.  A little gasp issues from her bloating lips, and her eyelids droop slightly, as if weighed down by her collapsing mind.  Not long after, a rumbling from her seat draws her increasingly short-lived attention under her, and she pushes away hair and boob alike to get a clear view.  As you both watch, the flesh of her hips trembles, then puffs out to engulf the narrow armrests.  With a surprised cry, she staggers to her feet, then tumbles over her still-roiling tits.  The friction of her heavy bosom against the table topples it right along with her.  Niamh's rapidly increasing weight - plus the chair, firmly stuck to her butt - presses against the gurgling orbs, loosening a ground-shaking - and crotch-moistening, in the catgirl's case - blast of bubbly liqueur... champagne, you realize.  Delicious-looking champagne.");
		outputText("\n\nOnly the sight of her still-swelling butt, pants tearing and hips swaying in blatant disregard of the chair stuck to her, prevents you from sampling the stuff.  Better to let bimbofied dogs lie, you figure.  The straining armrests finally splinter from the pressure, embedding a few wooden shards into her partially bared booty.  \"<i>Cripes!</i>\" she exclaims, trying to turn herself enough to reach the stinging slivers, \"<i>How did, like, me... big... wobbly... butt...</i>\"  She trails off, a blush of arousal flying across her features as she regards her new-and-improved posterior.  Ignoring her still-'lactating' nipples, she presses a hand deeply into her double-wide ass, cooing as it sinks into the blubbery bubble-butt.  Still applying considerable pleasure, she slides her hand down to her thickened thigh - causing the cheek to flop up and jiggle all about.");
		outputText("\n\nThe enamored catgirl's attentions inevitably shift to her unattended lady-bits, and she promptly begins rubbing her still-clothed groin.  \"<i>Fai... Fae... Omigosh, this feels good!</i>\" the increasingly-ditzy Niamh moans.  The catgirl's cries quicken, and you can fairly easily assume what that implies.  Fighting against the urge to give her some 'assistance', you decide instead to duck out, unwilling to be nearby when the inevitable Watch response happens.  As you slip out the door, four guardsmen slip in; you make sure to give them the benefit of a confused, scandalized expression.  Commotion and the sounds of upending furniture ring out from inside the bar, and after a few minutes, a struggling Niamh is carried out by three of the four.");
		outputText("\n\nA crowd of spectators follow, allowing you to slip into the group and watch the proceedings.  A very confused Niamh is placed, firmly but surprisingly gently, outside of the bounds of the city.  A guard explains to her that, after that display and the transformative effects forced upon the poor watchman who was the subject of her... motherly affections... she and her bosom-brew can't be allowed in Tel'Adre.  She nods, her face curiously blank of any emotion... except maybe lust.  As the gates are closing, you hear her call, \"<i>Hey, can I masturbate now, pretty-please?</i>\" and then, with a slam, she's gone.  You linger around the city until you figure she'd have moved away from the gate, then make your own way out.");
		flags[kFLAGS.NIAMH_STATUS] = 2;
	}
	flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER] = 25;
	dynStats("cor", 10);
	doNext(camp.returnToCampUseOneHour);
}

//24 hours later, random encounter on the Plains
public function niamhPostTelAdreMoveOut():void {
	//Move her into the bazaar
	flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER] = -1;
	clearOutput();
	outputText("Upon one of your routine searches, you're given pause as a half-coherent mess of a song comes tumbling across the grasses.  You move toward the cacophony of sound, fairly confident in what you will find.  Indeed, stumbling and shambling towards you comes a ");
	if (flags[kFLAGS.NIAMH_STATUS] == 1)
		outputText("demonic-looking");
	else
		outputText("hourglass-shaped");
	outputText(" Niamh, and it's obvious she's completely hammered.  ");
	if (flags[kFLAGS.NIAMH_STATUS] == 1)
		outputText("\"<i>W'hey there " + player.mf("boyo","big girl") + ", wanna...g'forrra goooo-gfh...time?</i>\"");
	else
		outputText("\"<i>W'heeeey, honey!  I never thought I'd see yaaaagain!</i>\"");
	outputText(" she slurs, struggling to stay upright between her impaired motor skills and her absolutely overfilled chest.  \"<i>Aaah've been drinkin' me 'shtash',</i>\" she explains, noticing your gaze.  \"<i>Canno' leddit go'tuh waste!</i>\" You nod your agreement, sneaking a glance behind her to observe the twin trails of ");
	if (flags[kFLAGS.NIAMH_STATUS] == 1)
		outputText("dark");
	else
		outputText("light");
	outputText(" fluid she's leaving behind.");
	outputText("\n\n\"<i>Wha's yer name, by th' way?</i>\" she suddenly inquires, sobering just a bit.  You decide there's no harm in formally introducing yourself.  \"<i>[name], eh?  Weeeeeird name,</i>\" she comments.");
	outputText("\n\n\"<i>Anywaays, wanna gulp?</i>\" she asks, her inhibitions obviously shed by the mixture of your meddling and her drunkenness.  A fair question, and one that sets you back on your heels a bit - do you want a drink of this corrupted cat-girl's new brew?");
	simpleChoices("Yes", niamhCorruptedMobileSnackDrinkTime, "", null, "", null, "", null, "Leave", niamhCorruptMobileSnackTurnDown);
}

//[no]
private function niamhCorruptMobileSnackTurnDown():void {
	clearOutput();
	outputText("You turn her down, fabricating a little tale about how you just got done drinking a delicious beverage, and you couldn't possibly have anything more.  She nods sagely, pauses, and loudly belches.  Even in her soused state, she retains some semblance of manners, so she chuckles nervously while moving a hand to her lips.  \"<i>Sorry 'bout tha'...</i>\" she mutters, slinking off.  You have a feeling you'll see her again.");
	doNext(camp.returnToCampUseOneHour);
}
//[yup]
private function niamhCorruptedMobileSnackDrinkTime():void {
	clearOutput();
	outputText("Of course you do!  You went through the trouble of getting her boobs to their current condition; drinking from the tap is exactly what you had in mind.  A smile brightens Niamh's features, and she plops down heavily on the ground, waving you over to sit next to her.  ");
	//[bimbo version]
	if (flags[kFLAGS.NIAMH_STATUS] == 2) {
		outputText("She does her best to jiggle her huge champagne-laden tits.  \"<i>Like, come 'n' get it!</i>\" she beckons.  \"<i>It's all bubbly and tickly and yummy.</i>\"  She giggles, belches hugely, then demurely puts her fingers across her mouth.  \"<i>Like, sorry; my tummy's all full of bubbles too.</i>\"  She giggles again; looks like that bimbo liqueur really down-shifted her mental gear.  But, hell, that's all right; she's only of any importance for what's in those gorgeous great boobs of her, not her brain.  You confidently stride over to her and sit down, positioning yourself where you can most easily access her breasts.");
		outputText("\n\nShe gives you an empty-headed smile and starts to purr, tail lazily swishing back and forth in anticipation.  You reach out and take hold of one weighty mammary, making her moan throatily; pale frothy liquor immediately starts to seep from it, and you waste no time in taking the nipple between your lips.  Mmm... the taste is like nothing you have ever tried before; sweet and sugary and rich... kinda gooey, actually.  It froths and fizzes madly in your mouth, tickling as you swallow and making you repress a giggle of delight.");
		outputText("\n\n\"<i>Yummy, isn't it?</i>\" Niamh purrs.  \"<i>Like, drink up; I gots lots more where that came from!</i>\"  She giggles, trying to push her breast forward; with how big it is, she can't really reach around to force you into it like she'd like.");
		outputText("\n\nStill, refusing such a delicious drink is not something a true connoisseur does; you nuzzle eagerly into her swollen breast.  A little too hard, in hindsight; the pressure makes the vast quantity of champagne inside come spurting into your mouth, filling you up with sweet richness and forcing you to chug it down to avoid choking.  Once you get the rhythm right, though, it's much easier; you hardly need to suckle, just keep squeezing jet after glorious jet down your thirsty gullet.");
		outputText("\n\n...This stuff is, like, way too freaking good!  Er?  Did you really just think that?  Come to think of it, it's getting harder to think, like, about anything... but izzat really so bad?  What do you need to think about, other than this sweet, sweet booze?");
		bimboChampagne(player,false,false);
		outputText("\n\nGiggling happily around your boozy boob of love, you start to scrape your crotch against the ground and rub your bouncy big boobs against Niamh's; that feels just sooo good!  Niamh is meowing and purring and occasionally burping; she, like, really likes you sucking on her... that's good, since you like sucking on her too.  You move one of your hands down between her legs... ooh, she's, like, not wearing any panties... what a naughty, naughty kitty-girl! You grin into her boob and, still sucking, start to play with her little pleasure button and her wet, sticky girly bits.");
		outputText("\n\nNiamh yowls and shudders, her pussy-parts squeezing around your fingers, and then, all of a sudden, she clenches up and lets go.  Girly-goo drizzles into your hand, getting you all sticky, and her big boobies suddenly start spurting... uh, whatsit, sham-pain?  From her big ol' nipples.  The other breast starts spraying the grass, which is a waste of good bubbly brew, but you get more than your fair share since her other breast is gushing into your mouth and you swallow and gulp and slurp as fast as you can.  But, in the end, you just can't keep up and you, like, have to let go.  Have to.");
		outputText("\n\nFinally, Niamh's boobgasm comes to an end and she falls back on her big jiggly butt.  \"<i>Like, that feels so much better than when I put my big ol' boob in my own mouth...  Hey, [name]... you, like, okay?</i>\" she asks.  She half-crawls over to you, then giggles.  \"<i>You, like, got a big sloshy belly on you now, [name]!  You look so funny with this giant gutty-gut.</i>\"");
		outputText("\n\nYou giggle back, pinned down by the weight of your inflated belly, which you can see swaying above you.  You give it a gentle push and watch it jiggle like a great big jelly, which makes you laugh, then give out a great big burp as all the bubbles tickling inside you come out.  Niamh laughs at that, then burps even louder than you did.");
		outputText("\n\nWith a lot of giggling, some straining and a few curses, the two of you manage to help each other stagger upright.  Your head is full of pink soft fluffy clouds, but you manage to think to ask the catgirl why she's out here and where she plans on going.");
		outputText("\n\n\"<i>I, like, remember those mean guards back in the desert saying there's a camp or something full of people who like fun above all else out here in the plains.  I'm gonna, like, find it and set myself up there,</i>\" Niamh tells you.  She hugs you, squeezing you into her breasts and making champagne spurt onto the dusty grass.  \"<i>Like, look me up if you're ever there, okay?</i>\" she tells you, then starts merrily slouching off on her way, singing happy songs as she goes.");
		outputText("\n\nHiccuping softly, you wave her goodbye and then head back to camp.  You idly wonder how long it's going to take to work off this booze-belly.");
	}
	else {
		//[corrupted kitty version]
		outputText("\n\nAt her beckoning, you close the gap between her huge leaky tits and yourself, kneeling before her and clasping one of the long nipples gently, near-reverently.  You slowly raise it to your lips, lapping up some of the drizzling ale with long, teasing strokes of your tongue.  By the satisfied moans and periodic tremblings, you can tell Niamh's enjoying the treatment.  After a few more licks, you open wide and begin suckling on the oversized nub.");
		outputText("\n\nBefore you can react, the azure catgirl screams in savage delight and leaps forward, knocking you backwards and landing boobs-first on top of you.  The weight of her enormous bosom presses against you, forcing a huge gush of her dark beer down your throat.  You struggle briefly, trying to shift Niamh to the side and escape this sopping-wet marshmallow hell.  Strangely enough, your body hardly responds to your mental call, limbs twitching lamely.  Before you know it, you find your thought process beginning to shut down.  Even the most basic of calculations and thoughts come to you as slowly as a third-trimester goblin slugging through tit-high swamp mud.  You blink.  And blink again.  The third time, your eyes refuse to open; in your current state, you have no way to fight against the lethargy, and you drift off.");
		outputText("\n\nA cold breeze gently floats by, caressing your cheek as it passes.  Deliberately, you awaken and sit up, stretching the sleep from your still-heavy limbs.  For a moment, you nearly panic, but you quickly gather your wits.  Of course you know where you are; your sights were set on this for years, and you're finally close to accomplishing your goal.");
		outputText("\n\nYou take a moment to get your bearings.  You're close now, actually - only a small climb to reach the summit.  For days you've been toiling over this, scaling the grandest and most majestic mountain in all of Mareth.  Coming more fully to alertness, you draw a deep breath, basking in the crisp and chilly air of the mountainside.  Enough dawdling on the overhang; the night's over and it's climbing time.");
		outputText("\n\nGathering your gear, you set off, picking your way along the narrow and winding trail.  Uplifted by the spirit of adventure, you sing a little traveling song as you go, romping toward the summit at a very respectable pace.  Eventually, however, as if the heavens themselves catch onto your aspirations, the wind picks up.  There's little you can do but continue to plod forward despite increasingly violent gusts.  More than once you're forced to come to a complete halt, driven to a standstill by nature's fury.");
		outputText("\n\nStill, you press on, determined to reach the summit today, and damn the weather!  You can almost see it now - the areola of the majestic nipple capping the mountain is in view.  Sadly, your determination lasts just about as long as your footing.  A single misplaced footstep unbalances you enough to send you careening off the sheer cliff-path.  You're falling... falling...");
		outputText("\n\nFalling?");
		outputText("\n\nYou wake with a start, swiftly rolling to your feet and trying to shake the lingering cobwebs out of your head.  You quickly spot Niamh, still kneeling and fixing you with a wry smirk.  \"<i>I got a bit overzealous with the nursing, I suppose,</i>\" she mutters, as close to an apology that you'll probably get from her.  \"<i>After ya went under, ya kept clawing at my tits for a bit, so I had to hop off.  Kept myself busy while you were asleep, at least.</i>\"");
		outputText("\n\nGlancing around, you can't help but agree, judging by the lake of ale surrounding you both.  Luckily, her self-entertainment seems to have shrunk her normally-gigantic tits to a more manageable size, and with your assistance, she's soon back on her feet.  \"<i>I heard there was a form of refuge for... well, differently-blessed lassies like meself,</i>\" she says, somewhat drily, patting the top of her huge azure bosom for emphasis.  \"<i>I'm heading there.  Maybe I'll find you there eventually, hey?</i>\"");
		outputText("\n\nShe gives you a little punch in the shoulder, shooting you a wink and walking away.  \"<i>Don't think I forgot about how I got like this,  " + player.mf("boy","gal") + ", ,</i>\" she yells over her shoulder, stopping you in your tracks as you turn to leave.  Several moments pass before she finally turns around and resumes her departure.");
		outputText("\n\nJust before you move out of earshot, a last word from Niamh floats to your ears.  You can't be sure, but... did she say... \"<i>Thanks?</i>\"");
		blackCatBeerEffects(player,false,true);
		//[end encounter]*/
	}
	doNext(camp.returnToCampUseOneHour);
}
public function bimboChampagne(player:Player,clearScreen:Boolean,intro:Boolean):void {
	if (clearScreen) clearOutput();
	if (intro) {
		if ((player.findPerk(PerkLib.FutaFaculties) >= 0 && player.findPerk(PerkLib.FutaForm) >= 0) || (player.findPerk(PerkLib.BimboBody) >= 0 && player.findPerk(PerkLib.BimboBrains) >= 0)) {
			outputText("You could've swore the stuff worked when you saw Niamh do it to others, but for some reason, it had, like, no effect on you. How weird!");
		}
		else if (player.findStatusEffect(StatusEffects.BimboChampagne) < 0) outputText("You uncork the bottle and breathe in the fizzy, spicy aroma of the sparkling liquor.  Breathing deeply, you open your mouth and begin pouring the ever-effervescent fluid inside.  It's sweet and slightly gooey, and the feel of it sliding down your throat is intensely... awesome?  Like, totally!");
		else outputText("You find yourself falling even further into the dense bimbo mindset.  You do feel, like, super-good and all, though!\n\nMoaning lewdly, you begin to sway your hips from side to side, putting on a show for anyone who might manage to see you.   You just feel so... sexy.  Too sexy to hide it.  Your body aches to show itself and feel the gaze of someone, anyone upon it.  Mmmm, it makes you so wet!  You sink your fingers into your sloppy cunt with a groan of satisfaction.  Somehow, you feel like you could fuck anyone right now!");
	}
	if (player.findStatusEffect(StatusEffects.BimboChampagne) >= 0) {
		player.addStatusValue(StatusEffects.BimboChampagne,1,4);
		dynStats("spe", -2, "lib", 1, "lus", 10);
	}
	else {
		player.createStatusEffect(StatusEffects.BimboChampagne,8,0,0,0);
		//(Player has breasts smaller than DD-cup:
		if (player.breastRows[0].breastRating < 5) {
			outputText("\n\nYou feel this, like, totally sweet tingling in your boobies... And then your [armor] gets, like, tighter; wow, it seems like Niamh's booze is making your boobies grow!  That's so awesome!  You giggle and gulp down as much as you can... Aw; your boobies are <b>kinda</b> big now, but, like, you wanted great big bouncy sloshy boobies like Niamh has.  That'd be so hot!");
			player.changeStatusValue(StatusEffects.BimboChampagne,2,5-player.biggestTitSize());
			player.breastRows[0].breastRating = 5;
		}
		//(Player does not have vagina:
		if (!player.hasVagina()) {
			player.createVagina();
			player.genderCheck();
			outputText("\n\nYou can feel ");
			if (player.hasCock()) outputText("the flesh under your cock[if (hasBalls = true)  and behind your [balls]]");
			else outputText("the blank expanse of flesh that is your crotch");
			outputText(" start to tingle and squirm... mmm... that feels nice!  There's a sensation you, like, can't describe, and then your crotch feels all wet... but in a good, sticky sorta way.  Oh, wow!  <b>You've, like, just grown a new virgin pussy!</b>  Awesome!");
			player.changeStatusValue(StatusEffects.BimboChampagne,3,1);
		}
		//(player ass smaller than bimbo:
		if (player.buttRating < 12) {
			outputText("\n\nYour butt jiggles deliciously - it feels like the bubbles from the drink are pushing out your plump rump, filling it like bagged sparkling wine!  Your bubbly booty swells and inflates until it feels as airy as your head.  Like, this is soooo plush!");
			player.changeStatusValue(StatusEffects.BimboChampagne,4,12-player.buttRating);
			player.buttRating = 12;
			if (player.hipRating < 10) player.hipRating = 10;
		}
		player.genderCheck();
		dynStats("spe", -10, "lib", 1, "lus", 25);
	}
}

public function removeBimboChampagne():void {
	outputText("\n<b>Whoah!  Your head is clearing up, and you feel like you can think clearly for the first time in forever.  Niamh sure is packing some potent stuff!  You shake the cobwebs out of your head, glad to once again be less dense than a goblin with a basilisk boyfriend.</b>");
	dynStats("spe", 10, "lib", -1);
	if (player.statusEffectv2(StatusEffects.BimboChampagne) > 0) {
		player.breastRows[0].breastRating -= player.statusEffectv2(StatusEffects.BimboChampagne);
		outputText("  As the trecherous brew fades, your [chest] loses some of its... bimboliciousness.  Your back feels so much lighter without the extra weight dragging down on it.");
	}
	if (player.statusEffectv3(StatusEffects.BimboChampagne) > 0) {
		outputText("  At the same time, your [vagina] slowly seals itself up, disappearing as quickly as it came.  Goodbye womanhood.");
		player.removeVagina();
	}
	if (player.statusEffectv4(StatusEffects.BimboChampagne) > 0) {
		player.buttRating -= player.statusEffectv4(StatusEffects.BimboChampagne);
		outputText("  Of course, the added junk in your trunk fades too, leaving you back to having a [butt].");
	}
	player.removeStatusEffect(StatusEffects.BimboChampagne);
	player.genderCheck();
	outputText("\n");
}

public function bazaarNiamh():void {
	clearOutput();
	//Bimbo Niamh:
	if (flags[kFLAGS.NIAMH_STATUS] == 2) {
		if (flags[kFLAGS.TIMES_NIAMH_BAZAAR_MET] == 0) {
			outputText("As you enter the bazaar, you hear a familiar voice calls out to you. \"<i>Hey!  [name]!  Over here!  Like, it's me!</i>\"");
			outputText("You follow the sound and find Niamh seated in a corner of the bazaar.  She is totally naked save for a small strip of cloth around her loins; her huge breasts lie exposed for all the world to admire.  She's surrounded by a small entourage of assorted beings; some are either hoping to earn a drink or else are simply here to ogle the massively buxom catgirl, others have evidently already drunk their fill, given their swollen bellies, feminine forms and platinum blonde coloration.  She grins as you approach.");
			outputText("\"<i>Like, I was just roaming the plains, trying to, like, figure out where I was gonna go, and I found this place.  Isn't it, like, so neat here?</i>\"  She has apparently already forgotten that this was her destination all along!  \"<i>All these cool people who know how to have a totally good time!  Not like that dump in the desert, fulla buzzkills.  Yeah, I'm gonna, like, party all night and day here, [name].</i>\" She giggles yet again.  \"<i>But you're still, like, my number one customer.  So... you, like, wanna do something?</i>\" she asks.");
		}
		//[Bizarre Bazaar, repeat encounter]
		else {
			//Bimbo:
			//(General notification: The sounds of voices raised in song and girlish laughter makes it obvious where Niamh is holding her perpetual party.)
			outputText("Surrounded by blonde-haired, horny women, herms and traps, many of them sporting stomachs swollen with Niamh's copious champagne lactation, the bimbo catgirl enthusiastically waves you over.  \"<i>[name]!  Like, what can I do you for?</i>\" she giggles.");
		}
	}
	//Corrupt:
	else {
		//(General notification:
		outputText("Given the pile of snoozing bodies, you can probably hazard a guess as to where Niamh decided to set up shop.");
		//(Approach:
		outputText("Pushing your way past the drugged, sloshing, and fitful sleepers, you approach the encircled cat girl.  You catch her eye, and she waves you over.  \"<i>Welcome to me corner,</i>\" she snickers, glancing around at all of her victims.  \"<i>I don't suppose ya want a drink o' the brew?</i>\"  So saying, she lays her hands atop her ponderous bosom, leaning forward and smiling wickedly.");
	}
	flags[kFLAGS.TIMES_NIAMH_BAZAAR_MET]++;
	//[Bizarre Bazaar, beer purchase, bimbo and corrupted version]
	var drink:Function =null;
	if (player.gems >= 2)
		drink = bazaardNiamhDrink;
	else outputText("\n\n<b>You're too poor to get a drink.</b>");
	var fuck:Function =null;
	if (player.hasCock())
		fuck = bazaarSex;
	simpleChoices("Get A Drink", drink, "Tit-Fuck", fuck, "", null, "", null, "Back", getGame().bazaar.enterTheBazaar);
}

//[bimbo/corrupted beer drink texts]
private function bazaardNiamhDrink():void {
	clearOutput();
	player.gems -= 2;
	outputText("Approaching the fallen-from-grace (yet completely content) catgirl, you toss her a couple gems and request a glass of the house drink.");
	//Bimbo:
	if (flags[kFLAGS.NIAMH_STATUS] == 2) {
		outputText("\n\nThe dark-skinned blonde giggles, snatching up the gems and jingling them in the palm of her hand. \"<i>Like, that's totally cool with me, but you're gonna have to serve yourself, y'know?</i>\" she jiggles her mountainous mammaries, the alcoholic beverage softly, yet audibly, sloshing inside them.  \"<i>I'm a wee bit too big to be, like, serving you.</i>\"  Sure enough, when she stretches her arms to demonstrate, her hands can't even reach her nipples anymore.  She titters, which makes the random drunkards around her giggle in amusement.");
		outputText("\n\nYou approach her leaking teats, casually swatting aside a giggling, totally plastered imp with long, lady-like locks of strawberry blonde, curly hair wreathing his (her?) features.  You contemplate if you want to just milk some into a bottle for later consumption, or have a drink here and now.");
		simpleChoices("Drink", drinkFromZeTap, "Bottle", getBimboChampFromNiamh, "", null, "", null, "", null);
	}
	//Corrupt
	else {
		outputText("Succubus milk Niamh Not implemented yet");
		doNext(camp.returnToCampUseOneHour);
	}
}
//{If player drinks from the tap:}
private function drinkFromZeTap():void {
	clearOutput();
	outputText("Your eyes lock onto her large, ever-dribbling nipples, the froth of spilt champagne caked on the table supporting her mammoth breasts, and you know you just have to have it from the source.  You push your way forward and seat yourself on a plush cushion that, from its many tears and suspicious-smelling stains, has seen better days, then grasp the huge boob in front of you, making the ditzy catgirl yowl in anticipation of pleasure.");
	outputText("\n\nThe wonderful taste explodes into your mouth as her well-trained teat gushes forth its precious elixir.  Delightfully fizzy, the frothy fluid is a rich, sugary-sweet delicacy, with a strangely gooey texture that just makes it all the yummier to swallow.  You gulp and slurp and suckle, dimly aware that somebody else has taken advantage of Niamh's free nipple.  A strange tingling feeling sweeps through your body; like pins and needles, only wonderfully pleasurable, so much so that you can feel your mind starting to dim.  Desperate for greater pleasure you suck harder and harder, gorging yourself on as much fluid as you can get, as fast as you can make it pour into your mouth - everything seems to fade away into nothing except the wonderful taste of this fizzy booze and your insatiable thirst for more of it.  You just keep drinking and drinking and, like, it just feels better and better - you find your mind totally shutting down...");

	outputText("\n\nYou snap back to your senses with a jolt, finding yourself flat on your back and gazing up at the sky.  \"<i>Like, are you alright, [name]?</i>\" Niamh asks, amused.  \"<i>My fizzy titties, like, really hit some people harder than they can, y'know, deal with.  You okay?</i>\"");

	outputText("\n\nYou push yourself upright and assure the pretty catgirl that you feel, like, super-duper wonderful!  You punctuate this declaration with a burp as the sudden motion makes all the yummy bubbles in your belly dance, and then you giggle at how naughty that was.");
	bimboChampagne(player,false,false);
	doNext(camp.returnToCampUseOneHour);
}

//grabbing Bim Cham in a to-go box
private function getBimboChampFromNiamh():void {
	clearOutput();
	outputText("You explain your need for a bottle of her champagne; the ditzy kitty takes several moments to register your words, then nods idly.  \"<i>Works fer me!</i>\" she responds, reaching behind her and rummaging in a large burlap bag.  She produces a flask from the sack's depths, unscrewing the cap and attempting to line it up with a nipple.  Try as she might, she just can't quite reach all the way, and with an airy giggle, she passes it to you instead.");
	outputText("\n\nWith a resigned sigh, you accept the flask and kneel, flicking both nipples experimentally.  Pressing her elbows against her boobs, Niamh moans, the combination of your stimulation and her pressure beginning a steady trickle of delicious-looking champagne.  The mere smell of the stuff makes you feel a bit dumber!");
	outputText("\n\nPushing that slightly scary thought to the side, you lean in, firmly grasping one stiff nipple and forcing it to the mouth of your container.  Ignoring her increasingly loud and frequent groans, you dutifully milk the bubbly into the flask, stopper it up, and rise.  Niamh tries to follow you, too aroused by the milking to resist her carnal urges, but you easily push her to the side, her ponderous melons throwing her off balance.");
	outputText("\n\nShe lands into a big pile of similarly blonde and giggling girls who waste no time in swarming her.  You chuckle and shake your head.  Perhaps you'll come back later.\n\n");
	//bimbo champagne aqua-aired
	inventory.takeItem(consumables.BIMBOCH, camp.returnToCampUseOneHour);
}

//[Bazaar sex]
private function bazaarSex():void {
	var x:Number = player.biggestCockIndex();
	var y:Number = x + 1;
	clearOutput();
	if (flags[kFLAGS.NIAMH_STATUS] == 2)
	{
		//Bimbo:Fuck a Bimbo Catgirl and Suck Dem Boozetits Like You Got a Pair (Or at least a dick; gotta have one of them)
		outputText("As you approach the bimbofied cat-girl, your eyes wander lustily toward her huge, beer-lactating tits.  Seeing you stare, she giggles and shakes her chest enticingly, letting the huge, liquid-filled mounds wobble.  \"<i>Like, like what you see, [name]?</i>\" she purrs, her long black tail wagging excitedly behind her.");
		outputText("\n\nYou grab the horny bimbo by the arm and lead her off to an empty tent that she identifies as her own.  As soon as the flaps close, the cat-girl undoes her loincloth, letting the fabric flutter to the ground and exposing her nude body in all its glory.  Her massive tits sway heavily, a little trickle of beer leaking from her nipples as she cups the massive mounds.  With a gentle push, you knock Niamh onto the bed, spreading her legs to get a good look at her eager, wanton lips, glistening in the dim light.");
		outputText("\n\nYou plant your hands firmly on her thighs, leaning in to give the pussy an experimental lick.  She giggles again, reaching down to rub her prominent little clit above your intruding tongue.  \"<i>Like, that feels awesome, babe.  Can you do it again?  Pretty please?</i>\"  Well, you can hardly resist such a polite request, and quickly bury your face between her thighs, slurping along the length of her slit.  \"<i>A-aaaah!</i>\" Niamh moans.  \"<i>Feels good, [name]!</i>\"");
		outputText("\n\nYou tell her it'll feel even better in a second, and pull your tongue away from her to grab your half-erect [cock " + y + "].  Shifting around a bit, you thrust it between her boozy boobs.  She yelps in surprise as you grab her tits and push them together around your prick, forming a big, all-enveloping sheath for you to thrust into.  Niamh mewls helplessly as you give yourself a titty-fuck at her expense, ramming your hips into the bottoms of her mounds and sending quakes through her overly-fluid, bubbly flesh.");
		outputText("\n\nYou pinch the cat-slut's big nipples together, grinning as a trickle of booze leaks out.  Giving her quivering tits a rough slap, you jam both nips between the cat-girl's lips, giving her such a mouthful of booze that her cheeks swell.  She squirms under your assault, but you keep her teats firmly in her mouth, filling Niamh with more and more booze until your can see her eyes start swimming and her body begin to go languid, relaxing into your firm grip as you flood her already-addled mind with alcohol.");
		outputText("\n\nAfter several minutes of tit-fucking your brainless beer-girl, you feel an orgasm welling up inside your [balls].  You pick up the pace, hammering your hips into her tits as hard as you can until she cries out, fizz leaking down her chin, and soon mixing with the first thick streams of your ejaculate. You roar and cum, giving the bimbo a creamy pearl necklace as it jets out from between her thick tits.");
		outputText("\n\nGiggling drunkenly, the girl slurps up the little extras that stain her chin and cheeks, her long cat-tongue flicking bits of spooge around mindlessly as you wind down, now just dribbling a little lake between her breasts.");
		outputText("\n\n\"<i>Thash was - HIC - shuper shexy, [name],</i>\" the drunken keg-girl giggles, staggering to her feet and stumbling toward the Bazaar.  \"<i>Like, we shud do thish again shoon!</i>\" she adds, prancing out with her new pearl necklace on full display.");
		player.orgasm();
		dynStats("int", -.5, "sen", -2);
	}
	else if (flags[kFLAGS.NIAMH_STATUS] == 1)	// Succubi Milk
	{
		outputText("\n\nSuccubi Milk Niamph not implemnted yet.");
	}
	doNext(camp.returnToCampUseOneHour);
}


//[Meet Sean with bimbo champagne in inventory]
//five bimbo champagne required, takes 24 hours to proc and 500 gems to do.
public function seanBimboBrewing():void {
	clearOutput();
	outputText("The uncharacteristically gentlemanly incubus raises his eyebrow as you produce an armful of filled flasks and drop them onto his mostly-empty table.  \"<i>I assume you'd like me to do something special with these,</i>\" he quips, somewhat dryly.");
	outputText("\n\nYou smirk and explain to him the nature of the contents of the containers, as well as the nature of your visit.");
	outputText("\n\nHe picks up one of the flasks and screws off the cap, leaning forward and wafting the drink to his nostrils.  \"<i>Not as potent as the real stuff,</i>\" he confirms, recapping the thing and setting it next to the others.  \"<i>I can do it,</i>\" he decides, \"<i>but it will take a good amount of time and a good amount of effort.  Five hundred gems and I'll have it done by tomorrow.</i>\"");
	var yep:Function = null;
	//[Yep][Nope]
	if (player.gems < 500) outputText("<b>\n\nYou're too poor to get Sean to make you bimbo liqueur.</b>");
	else yep = yeahSeanLetsBimbooze;
	simpleChoices("Yep", yep, "", null, "", null, "", null, "Back", getGame().dungeons.deepcave.incubusShop);
}

//yeah I got this
public function yeahSeanLetsBimbooze():void {
	clearOutput();
	outputText("\"<i>Perfect!</i>\" he says, moving forward to gather up the flasks.  \"<i>You can go, now.  This is a delicate process, and any mistakes may lead to an outbreak of large-breasted and dim-witted fauna.</i>\"  He pauses, gauging your expression.  \"<i>... Which is <b>not</b> a good thing,</i>\" he adds.  Almost as an afterthought, he extends his hand toward the table, saying, \"<i>I'd like the payment now, if you'd please.</i>\"  You separate out the appropriate number of gems for the demon.  He snatches it up and idly throws it behind him, where you hear a clunk and tinkle as it strikes something and rolls a bit.");
	outputText("\n\n\"<i>Now shoo, I must do work!</i>\" he scolds, ushering you out of the cave.  \"<i>Come back tomorrow!</i>\"  Satisfied, you leave his shop.");
	doNext(playerMenu);
	player.gems -= 500;
	player.consumeItem(consumables.BIMBOCH);
	player.consumeItem(consumables.BIMBOCH);
	player.consumeItem(consumables.BIMBOCH);
	player.consumeItem(consumables.BIMBOCH);
	player.consumeItem(consumables.BIMBOCH);
	statScreenRefresh();
	flags[kFLAGS.NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER] = 25;
}
//back to camp
//remove 5 bimbo champagnes from inventory and also 500 gems
//set some kinda sorta flag to allow the 00:00 function to trigger the next scene

//24 hours later
public function getBimboozeFromSean():void {
	clearOutput();
	outputText("Sean turns as you enter, managing a thin smile as he regards you.  \"<i>Excellent timing, I have just finished this!</i>\"");
	outputText("He scoops a familiar-looking bottle from a tabletop, passing it off to you.  \"<i>Be somewhat careful with this,</i>\" he warns as you take it.  \"<i>The original's deleterious effect on the mind has been duplicated, I assure you.</i>\"\n\n");
	outputText("You drop the vial into a pouch on your person.\n\n");
	//bimbo liqueur aqcquired
	flags[kFLAGS.NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER] = 0;
	inventory.takeItem(consumables.BIMBOLQ, getGame().dungeons.deepcave.incubusShop);
}

// [LEAVE]
private function leaveWithBeerTits():void {
	clearOutput();
	outputText("The offer is tempting but right now you'd much rather deal with your boozy boobs privately.  You take off while trying to keep your [armor] modestly in place over your tits but it's difficult.  Your nipples constantly leak and drip a trail of alcohol all the way back to camp.  Thankfully by the time you arrive the effects seem to have mostly worn off.  Your nipples return to dripping milk, but although they've shrunk back down a bit they don't quite shrink all the way, leaving you with somewhat larger endowments than you had before.");
	player.growTits(2, player.bRows(), false, 2);
	doNext(camp.returnToCampUseOneHour);
}

// [SELL YOUR BOOZE]
// Non-holidays have small payout of gems proportional to lactation.  Boob rating increases by 1.
// Holidays have larger payout of gems proportional to lactation.  Boob rating increases by 2.
private function sellYourBooze():void {
	clearOutput();
	player.gems += 2;
	temp = Math.round(player.lactationQ() / 100);
	if (temp > 40) temp = 40 + rand(3);
	player.gems += temp;
	player.gems = Math.round(player.gems);
	statScreenRefresh();
	//If player has only two breasts.
	if (player.bRows() == 1) outputText("With a chipper giggle Niamh pulls you closer to the bar.  With both hands she helps you heft your tits up and on to the counter.");
	//If player has four or six breasts.
	else outputText("Niamh giggles as you try to move your breasts closer to the bar to be milked by the patrons, but it's obvious only the top pair of your tits can easily rest on the counter top.  \"<i>Lassie, it might be unconventional, but givin' the circumstance mayhaps it'd be best if ye laid down on the bar.</i>\"");
	outputText("\n\nIt isn't long before patrons start lining up for mugs of your particular brand of booze.  They tug on your nipples, teasing the beverage from your teats.  Each drunken tug however encourages your libido, arousing you further.");
	if (player.hasVagina()) outputText("  You feel your excitement dripping down the inside of your thighs as your pussy wettens.");
	dynStats("lus", 10 + player.sens/5, "resisted", false);
	//[If player has cocks]
	if (player.hasCock()) outputText("  You start to feel sympathetic sensations in [eachCock] as the hands and paws of the bar goers milk your nipples.  With their fingers sliding over your sensitive nubs you can easily imagine them sliding up and down your cock");
	if (player.cockTotal() > 1) outputText("s");
	outputText(".");
	//If lust is low
	if (player.lust < 50 || player.gender == 0) {
		player.growTits(2, player.bRows(), false, 2);
		outputText("\n\nYou feel flushed from the sensations, but finally you run dry.  Your breasts have shrunk back down, but they still feel a little larger than they were earlier.  As little droplets of milk instead of booze return to dripping from your nipples, Niamh hands you your cut of the gems you earned from the sales.");
		//[LEAVE]
		doNext(camp.returnToCampUseOneHour);
	}
	//If lust is high
	else {
		outputText("\n\nYou're not sure how much more you can give before it becomes impossible to ignore your raging hormones.");
		outputText("\n\nNiamh notices your condition, as does several other patrons in the bar.  ");
		if (player.hasVagina()) outputText("You can feel your labia dripping with need.  ");
		if (player.hasCock()) {
			outputText("pre-cum drizzles down your " + player.multiCockDescriptLight() + " as the need to fuck a pussy grows stronger.  A few wandering hands reveals some apparent interest amongst the folks in the bar in seeing your genitals as active as your nipples.");
		}
		//[FUCK THE BAR] [LEAVE]
		simpleChoices("Fuck Bar", barBeerOrgyTits, "", null, "", null, "", null, "Leave", leaveWithBeerTits);
	}
}

//Bar Fuck if character's Lust and/or corruption is high enough
//===============
//First Paragraph
//===============
private function barBeerOrgyTits():void {
	clearOutput();
	//If [player has pussy]
	if (player.hasVagina()) outputText("The drooling of your [vagina] gets worse as the constant \"tapping of your kegs\" drives your sense of self-restraint to its limits.  The hands of various drunks start moving more aggressively over your breasts, eventually winding their way down between your thighs.");
	//IF [player has cock/s]
	if (player.hasCock()) {
		outputText("[EachCock] grows to its full length.  You try to keep ");
		if (player.cockTotal() == 1) outputText("it");
		else outputText("them");
		outputText(" discreet but it's impossible.  You try to push ");
		if (player.cockTotal() == 1) outputText("it");
		else outputText("them");
		outputText(" down or aside, but other pairs of hands begin stroking you.");
	}
	outputText("\n\nNiamh purrs, \"<i>O' deary lass, you look fit to pop.</i>\"  She pokes your bloated boob, \"<i>An' I don't mean ye booze balloons here.</i>\"  She leans over, plopping her fat tits down on top of your own, and gives you a huge wet kiss on your lips.  A round of cheers go up through the bar as she shoves her tongue inside your mouth.  Smiling as she pulls back she cheekily announces, \"<i>C'mon folks!  What say we tap this keg the right way?</i>\"");
	//IF [player has huge ass]
	if (player.buttRating >= 20) outputText("  She slaps your ass to emphasize her meaning, and the action sends jiggling waves through each immense cheek.");

	outputText("\n\nA few more hollers go up from the crowd that's drunk themselves silly on the booze from your tits.  Hands and paws begin grabbing your limbs and tits and carry you aloft.  ");
	if (player.biggestTitSize() >= 20) outputText("Your giant boobs are large enough to temporarily hang off the sides of your body as you're carried.");
	outputText("  Your [butt] hits the table first as the crowd puts you down.  Some patrons begin sucking on your nipples directly.");
	// [IF player has four or more giant tits, but not hugely pregnant]
	if ((player.pregnancyIncubation == 0 || player.pregnancyIncubation > 100) && player.bRows() > 1) outputText("  You are essentially a pile of " + boozeBoobsType() + " filled tits.");
	// [IF player is hugely pregnant with four or more tits]
	else if (player.bRows() > 1) outputText("  You are essentially a giant pregnant belly surrounded by your [chest] on the table, helpless to the sexual advances of the bar goers and you can't get enough of it.");

	//===============
	//Third Paragraph
	//===============
	//IF player has pussy and Urta is in the bar and sex with her is unlocked.
	if (model.time.hours < 15 && flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] > 0 && player.hasVagina()) {
		outputText("\n\nA pair of familiar paws grab your ankles and spread your legs wide.  Your labia practically spurt out girl cum in anticipation of what's about to happen.  \"<i>Oh, looks like someone's overly eager.</i>\"  You struggle to look over the mounds of your own tits to see who's standing between your legs.  The familiar sight of an oversized horse-cock waving in the air catches your attention shortly before the grinning smile of Urta comes into view.  \"<i>My, aren't you going to get reamed, lover.</i>\"  No sooner than she says that does the flared head of her cock plunges with a wet squish between your nether lips.  You feel her stretching your entrance apart as her massive horse meat bores into your body.  Blissful screams of pleasure are heard and it isn't until the head of Urta's cock breaks into your womb that you realize it's you that's screaming in ecstasy.");
		if (player.pregnancyIncubation == 0) outputText("  Some folks give yelps and cheers when they see the bulge that repeatedly forms in your abdomen each time Urta thrusts herself inside you.");
		player.cuntChange(60,true,true,false);
	}
	//ELSE IF player has pussy and Urta is not in the bar.
	else if (player.hasVagina()) {
		outputText("\n\nHands grip your legs and spread you apart while slathering your thighs with your own pussy juices until every square inch of your lower body is slick and slippery.  A pair of dog morphs clamor for position between your thighs.");
		//IF [player has less than a gaping pussy]
		if (player.vaginalCapacity() < 60) outputText("  One is sporting a cock that is obviously too massive for your pussy, and eventually backs down so that the other one, despite still being on the large size, can take the honor of fucking your cunt silly.");
		//ELSE IF [player has a gaping pussy or bigger]
		else outputText("  They're both sporting large canine cocks, but one is particularly massive while the other would likely be a loose fit for a pussy as naturally stretched out as yours.  The largest one wins out and positions himself to give your overly wide fuck hole a much needed stretching.");
		outputText("\n\nThe bulbous cock presses in between your sopping labia, forcing your entrance apart and penetrating you until it manages to bottom out inside.  Your impromptu lover's thighs press against your own with only the knot of his manhood remaining outside your pussy.  You squeal out loud as he thrusts in and out, each time burying himself down to the fat knot.  Your cervix feels like it'll snap at any moment.");
	}

	/*================
	Fourth Paragraph
	================*/
	outputText("\n\nNiamh crawls up and on to the table, moving to position her hips over your head while leaning over the rest of your torso.  It's obvious that she either removed her undergarments, or wasn't wearing any in the first place.  Her bare pussy is now hovering just inches from your face.");
	// IF [Player has a large pregnancy]
	if (player.pregnancyIncubation > 0 && player.pregnancyIncubation < 100) outputText("  \"<i>Oi!  Careful folks, this babe could blow at any time!</i>\"  Niamh pats your belly with chiding affection.");
	// IF [Player has a single cock]
	if (player.cockTotal() == 1) outputText("\n\n\"<i>Mmmmm, now that be what me wants.</i>\"  Niamh settles down, pressing her womanhood over your mouth.  Through some lustful instinct your tongue begins licking her folds, seeking for an entrance into the busty cat girl's depths.  Her own rough tongue begins slurping up the sides of your erection.");
	// ELSE IF [Player has multiple cocks]
	else if (player.cockTotal() > 1) outputText("\n\n\"<i>Ooooh, how delightful.  Ye come overly equipped dontcha?</i>\"  Niamh grabs a handful of your cock meat as she settles her hips down to smother your face with her vaginal folds.  Her labia slip between your lips and you find yourself tonguing her cunt in search of her entrance.  With your cocks in her hands she begins glomping down on one of your shafts with her own mouth, eagerly sucking you off while giving you a hand job at the same time.  Excessive amounts of your pre-cum serve as the perfect lubricant for her hands as they stroke you off.  \"<i>Mmmmm,</i>\"  Niamh purrs, \"<i>I hope your cum is as good as your " + boozeBoobsType() + ".</i>\"");
	//IF [Player has 2+ inch clit]
	if (player.clitLength >= 2) outputText("\n\nThe sensations in your groin become more pleasurably irresistible as you feel something wet and tight slip around your clit.  Amongst the ruckus of voices in the bar you can make out the distinctive yelps of a fairy that call out in time with the sensations of whatever is sliding up and down your pussy's nub.");

	//===============
	//Fifth Paragraph
	//===============
	outputText("\n\nYour nipples squirt relentlessly while the crowd thickens around you.  Each customer tries to suck off mouthfuls of your delectable " + boozeBoobsType() + ".  Niamh allows her own breasts to rest on top of you, pushed out to the sides so that others may slurp up the beer leaking from her tender nipples as well.  The two of you become a mass of tit flesh spraying alcohol into the waiting mouths of customers.");
	// IF[Character has fuckable nipples]
	if (player.hasFuckableNipples()) outputText("  Eventually some of the randier drunks start whipping out their cocks, and begin pressing the heads against the openings of your nipples.  Within moments you feel your booze bloated breasts being fucked silly by " + num2Text(player.totalNipples()) + " hard cocks.  Each thrust causes " + boozeBoobsType() + " to spill out around their shafts.");
	// ELSE[Character doesn't have fuckable nipples]
	else outputText("  Some of the hornier customers start shoving cocks of all shapes and sizes into the moist wet cleavages formed by yours and Niamh's breasts.");

	//===============
	//Sixth Paragraph
	//===============
	outputText("\n\nAltogether the bar fucks you silly.  Your " + boozeBoobsType() + " filled tits jiggle with the relentless sex.  Orgasms run down your spine; quaking your flesh in pleasure as you cum.  Niamh's sweet pussy soaks your face with her own orgasms while others in the bar fill your canyons of cleavage with jizz.");
	//IF [Player has fuckable nipples]
	if (player.hasFuckableNipples()) outputText("  The cocks filling your nipples start pumping hot sperm into your breasts, mixing with your " + boozeBoobsType() + " and causing every nerve ending in your nipples to tingle.  Some of them ejaculate so much that it feels as if your breasts are swelling even larger, almost to the point of bursting before the cum spills out.");
	//IF [Player has cocks]
	if (player.cockTotal() > 0) {
		outputText("  You feel as if your body is exploding everywhere.  Niamh gags momentarily as her mouth fills with your seed, and you realize your cock");
		if (player.cockTotal() > 1) outputText("s have");
		else outputText(" has");
		outputText(" begun spurting ");
		if (player.cockTotal() == 1) outputText("its ");
		else outputText("their ");
		outputText("jizz.  Niamh swallows it down her throat but not without some of it getting plastered across her face.");
		//IF [character is pregnant]
		if (player.pregnancyIncubation > 0 && player.pregnancyIncubation < 200) outputText("  Globs of cum splatter across your gravid belly.");
	}

	//================
	//Ending Paragraph
	//================================================
	//Varies based on body type and characters present
	//================================================
	// IF [Edryn and Urta are present in the bar and free sex with both is unlocked and character is a herm]
	if (player.statusEffectv1(StatusEffects.Edryn) >= 5 && player.gender == 3 && model.time.hours == 14 && flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] > 0) {
		outputText("\n\nYou're so dizzy on pleasure that you barely notice it when you're lifted off the table and carried through the bar again.  You can hardly feel your feet and legs when the crowd stands you up, and with a weak lifting of your head you see the reason for the sudden change of position.  Right in front of you is Edryn's womanly hindquarters with her black cunt lips jiggling back and forth, dripping her girly horse juices from their sopping wet folds.  You don't even have to do anything as several hands angle [eachCock] and guide you forwards.");
		// IF [player has a single cock]
		if (player.cockTotal() == 1) outputText("  Edryn moans out loud in ecstasy as your [cock] fills her up.");
		// If [player has multiple cocks]
		else if (player.cockTotal() > 1) outputText("  The heads of your cocks press in between Edryn's labia causing her to cry out, \"<i>Oh gawd!  How many dicks are y-you f-f-fucking meeee with???</i>\"  Edryn's orgasm cuts her voice off and every muscle in her cunt contracts around your " + player.multiCockDescriptLight() + ".");
		outputText("\n\nAs Edryn's cunt literally sucks you in deeper you feel Urta move up behind you.  As her horse-cock pokes against your pussy lips you realize just before the first thrust what is about to happen.  Tel'Adre's finest guard rams her massive member inside you, making you the center of a fuck sandwich.");
		// IF[player is pregnant]
		if (player.pregnancyIncubation > 0 && player.pregnancyIncubation < 200) outputText("  Your pregnant belly presses up against Edryn's ass as both Urta's cock and Edryn's pussy keeps you pinned in place between them.");
		// IF[player is not pregnant]
		else outputText("  Urta's cock and Edryn's pussy pin you in place between them, and as Urta fucks you deeper her cock head forces your belly to bulge outwards until it presses against Edryn's ass.");

		outputText("\n\nBetween Edryn's horse-cunt and Urta's horse-cock you effectively become their living fucktoy.  Your body shakes and shimmies back and forth as the two of them grind you between their sexes.  Your breasts spray " + boozeBoobsType() + " everywhere, slapping against Edryn's ass in the process.");
		//IF [player has four huge tits]
		if (player.bRows() == 2) outputText("  Your second row of tits get thrust out to either side every time Urta's torso presses your own against Edryn.");
		//IF [player has six giant breasts]
		else if (player.bRows() == 3) outputText("  Your lowest row of tits slap against all three of your thighs as the love making becomes more brutal.");
		//IF [player has large balls]
		if (player.balls > 0 && player.ballSize > 14) outputText("  Your hanging testicles bounce around between everyone's legs.");
		//IF [player has giant ass]
		if (player.buttRating >= 22) outputText("  The fat of your ass cheeks jiggles and quakes even as Urta practically stuffs her hips into your crack.  \"<i>Damn, you've got a bigger ass than Edryn,</i>\" she chides as she spanks you.  \"<i>Hey!</i>\"  Edryn calls out with a false tone of hurt pride.");

		outputText("\n\nThe two of them fuck you senseless while the rest of the bar watches and cheers.  You start cumming without control which only eggs the two of them on to even rougher thrusts and grinds.  Long after the " + boozeBoobsType() + " stops leaking from your nipples and is replaced with your normal flow of milk, the two of them continue to fuck you hard enough to make your heavy tits shake and bounce for the crowd's enjoyment.");

		outputText("\n\nFinally Edryn calls out in pleasure, presumably from a particularly strong orgasm, and raises her hindquarters as high as she can.  As Urta finally reaches her own climax and thrusts upwards your body is held aloft solely by the sexes, with your legs dangling above the floor of the bar.");

		outputText("\n\nUrta's cock feels as if it'll tear your torso apart as cum surges through it before finally erupting with a messy torrent inside your womb.  You can hardly breathe as a jet of her spunk gushes against the underside of your diaphragm.  Your belly swells and swells until it presses against Edryn's ass.  You feel as if it'll burst at any second, and hoops and hollars go up from the crowd.  A few particularly intense bar goers are actually egging Urta on, calling for her to burst you.  Heavy amounts of jizz spill out from both yours and Edryn's cunt as Urta and you cum your collective brains out.  Stretch marks appear on the sides of your belly, but the pleasure of getting filled beyond capacity while gushing your own seed into the hot gash of Edryn's cunt paralyzes your higher brain functions from allowing you to do anything to stop the orgiastic sex.  A little bit of pain ripples through your sides, and right before you think you're gonna to meet your end in a belly explosion of cum your eyes roll back and everything goes black.");
		outputText("\n\nThe next thing you're aware of is feeling an intense pressure in your gut.  As your vision returns you weakly make out the desert outside Tel'Adre passing you by.  As your senses return you realize you're riding on Edryn's back and Urta is sitting behind you.  \"<i>Hellooooo...</i>\"  A very drunk Urta whispers in your ear.  \"<i>Looks like you're awake.</i>\"  She reaches around and pats your bloated belly.  \"<i>You really took a lot.  We sort of felt we overdid it, so we decided to give you a lift back to your camp.</i>\"  Urta's cum is still spilling out of your crotch, soaking Edryn's sides.  Edryn's own hindquarters are leaking from the many loads you gave her.");
		// IF [Player is pregnant but not with eggs] You pat your pregnant belly and silently hope Urta's ocean of cum hasn't drowned the child, if that's even possible.
		outputText("\n\nThe two of them drop you off along with your clothes and gear back at camp.  Each of them winks and blows you a kiss as they travel back to Tel'Adre.  Your breasts are leaking milk again, and they appear to have grown permanently larger.");
		player.growTits(2, player.bRows(), false, 2);
	}
	// IF [Urta but not Edryn is present in the bar and sex with her is unlocked and character has pussy]
	else if (player.hasVagina() && model.time.hours < 15 && flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] > 0) {
		outputText("\n\nYou hear passionate cries of lustful need from Urta as her horse-cock reams you with greater ferocity.  Her orgasm nearly knocks her off her feet as her shaft swells wider, stretching you apart as the cum surges up through it.");
		// IF [player is not pregnant]
		if (player.pregnancyIncubation == 0) outputText("  The eruption of cum from her horsecock out does every other ejaculating dick in the room.  Your belly button pops outward as your stomach swells from the surging torrent of sperm pumping directly into your womb.  The hands of strangers grab your legs to keep you pinned in place while Urta struggles to keep her gushing cock inside your cunt despite the building pressure.  A couple voices call out, \"<i>She's gonna pop!  Is she gonna pop?  I think she is!</i>\"  Niamh is forced to sit up higher as your cum bloated belly pushes up against her.  Urta looks as if she's having a seizure from the sheer effort of unloading herself into you.  You scream out loud from the ecstasy of swelling but your cries of pleasure are lost within Niamh's pussy folds, urging her to come again.  Her girl cum squirts down your throat, making your belly feel all the more tight and fit to burst.");
		// ELSE IF [player is pregnant]
		else outputText("  Urta feels as if she's going to tear you apart as the surging torrent of her horse cum shoots through the shaft of her cock.  She pulls it out just in time to plaster your abused pussy and the underside of your pregnant belly with her seed.  Ropes of cum spray across your thighs, belly, the undersides of your tits, and all over Niamh's chest and face.  \"<i>Oi!  Oh yes!</i>\"  Niamh calls out happily as Urta drowns the two of you in sperm.  Squirts of pussy juice pour down your throat and Niamh climaxes just from the sensation of being coated in Urta's hot jizz.");

		outputText("\n\nOrgasm after orgasm keeps you dizzy and drunk while you gush " + boozeBoobsType() + " and take in cum.  The bar patrons finally wear themselves out with fucking your oversexed body.  Niamh crawls off of your face and back down to the floor.  She pauses to catch her breath and regain her sense of balance, leaning on the table and resting her breasts on your face.  You've barely regained your own senses when Urta tries to help you up.");
		//IF [Player has four or more breasts]
		if (player.bRows() > 1) outputText("  Your rows of breasts shift around as your posture changes, making squelching sounds as they slide around.");
		//If [player not pregnant]
		if (player.pregnancyIncubation == 0) outputText("  Urta's small ocean of sperm streams out from your pussy like a river down your legs as you try to stand.");

		outputText("\n\nWhen you're finally on your feet all the cum covering your body and filling your cleavage begins dripping down and pooling around your feet.  Milk is dripping from your nipples, signaling that the effects of Niamh's beer have finally worn off.  \"<i>Oi lass, I think ye be needin' a dip in a river.  Pity ye in a desert eh?</i>\"  She grins.  Still half drunk off booze and sex you haphazardly gather your things.  Urta graciously helps you out of the bar and through the streets of Tel'Adre until you've gathered your senses enough to find your way back to camp.  Your breasts ache from the pleasant ordeal, each one feeling fuller and larger than it was before this all began.");
		player.growTits(2, player.bRows(), false, 2);
	}
	//=====
	//Generic ending if the first two don't trigger
	else {
		outputText("\n\nFor what seems like forever your body is used as a cum dump and fuck toy.");
		// IF [player has pussy]
		if (player.hasVagina()) outputText("  The giant knot of the dog morph finally breaks its way inside causing your pussy to become overstretched.  The pleasurable torture only gets worse as he begins unloading a river of his cum inside you.  It begins squirting out around his cock and soaks both of your thighs in the process.");
		player.cuntChange(60,true,true,false);

		outputText("  Niamh finally has her fill and dismounts you, but no sooner has her pussy left your face than a determined cock belonging to some sort of cat morph fills your mouth.  Your eyes bug out as it thrusts down your throat.");
		// If [player has pussy]
		if (player.hasVagina()) outputText("  You gag on it at the same time a new cock fills your cunt, ready to renew the thrusting that's been causing your tits to bounce all over the place.");

		//IF [player has single cock small-med cock]
		if (player.cockTotal() == 1 && player.cockArea(0) < 75) outputText("\n\nA cat girl with six C-cup breasts jumps up onto the table and mounts you.  She grabs your cock and proceeds to shove it up between the folds of her tight pussy.");
		//OR IF [player has single huge cock]
		else if (player.cockTotal() == 1) outputText("\n\nA cow girl with six large tits and quad nipples crawls with difficulty up and onto the table, carefully positioning her bare bovine cunt above your massive member, and proceeds to thrust her ridiculously wide hips down around it.");
		// FOR BOTH COCK SIZES -
		if (player.cockTotal() == 1) outputText("  Your cock remains tightly embedded inside the girl.  She bounces up and down causing her six tits to shake for the crowd's enjoyment.  You're so hard that even if she tried to dismount the head of your cock would have grown too thick to allow it to slide out of her pussy's entrance.  You can't hold back and a surging sensation rushes through you, blasting your hot seed up inside the wildly busty girl.  You hear cries from the crowd \"<i>Knock her up!  Knock her up! Knock her up!</i>\"  You hear cheers when they see your cum leaking out of her.");

		//If [player has multiple cocks]
		else if (player.cockTotal() > 1) outputText("\n\nIt isn't long before mouths and pussies take their turns as the female inclined customers of the bar mount your shafts, eager to get loads of your man seed to erupt inside of them.  Girls and herms of every shape and breed take turns sucking the cum out of you.  You can't hold back and within minutes you're blasting sperm into various pussies all at once.  As soon as one pussy is removed another takes its place.  You start hearing chanting from the crowd \"<i>Knock them up!  Knock them up! Knock them up!</i>\"  The crowd cheers various hoorays whenever they see your cum suddenly erupt from one of the various cunts your cocks are stuffed in.");

		outputText("\n\nThe smell of sex fills your nostrils.  The hot seed of the crowd fills your throat and covers your body.  Even after your breasts start lactating regular milk the fucking continues.  Only after every patron in the bar has managed to cum their brains out through use of your flesh do things settle down.  You're out of breath, out of strength, and out of booze or milk to give.");

		outputText("\n\nNiamh helps you struggle to your feet, leaving behind a silhouette of your body in the various fluids that cover the table.  She gives you a loooong kiss before helping you get cleaned up.  Your breasts, although lactating normally now, seemed to have gained some extra bulk.  Niamh purrs, \"<i>Perhaps you'd better lay off my beer for a while.  Wouldn't want this to become a regular occurrence, right?</i>\"  she winks at you.");

		outputText("\n\nAs you leave the bar you look around.  Every cock hangs low looking satisfied.");

		// IF [player has one cock]
		if (player.cockTotal() == 1) outputText("  The six titted girl smiles at you, patting her belly while your cum runs down the inside of her thighs.  You only now wonder about how fertile she might be.");
		// IF [player has multiple cocks]
		else if (player.cockTotal() > 1) outputText("  Various girls around the room are patting their bellies and giving you sultry looks while your cum continues to drip from their pussies.  You passively wonder if any of them might indeed be hauling around some larger pregnant bellies in a few days, but you try to push those thoughts from your head.  At the moment they seem happy.");
		// IF [player has pussy]
		if (player.hasVagina()) {
			outputText("  You walk slightly bow legged out of the bar.  Cum is still dripping from your snatch and will likely continue to do so for a while.");
			//IF [player is not pregnant]
			if (player.pregnancyType == 0) outputText("  You can't help but wonder how virile those dog morphs might have been as their cum and the cum of other customers sloshes around inside your uterus.");
			temp = rand(6);
			switch(temp) {
				case 0:
					player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR);
					break;
				case 1:
					player.knockUp(PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.INCUBATION_MOUSE);
					break;
				case 2:
					player.knockUp(PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.INCUBATION_MOUSE); //I'm betting this was meant to be dog morph chance
					break;
				default:
					player.knockUp(PregnancyStore.PREGNANCY_CENTAUR, PregnancyStore.INCUBATION_CENTAUR);
					break;
			}
		}
		player.growTits(2, player.bRows(), false, 2);
	}
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}


private function boozeBoobsType():String {
	// New Years
	if (isHolidays() && date.date >= 31) return "champagne";
	// Saint Patrick's
	else if (date.date == 17 && date.month == 2) return "Saint Patrick's Day lagar";
	// Christmas
	else if (isHolidays()) return "egg nog";
	// Valentine's
	else if (date.date == 14 && date.month == 1) return "wine";
	// Non-Holiday, Generic
	else return "beer";
}
}
}