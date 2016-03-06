package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Camp.*;
	import classes.Items.*;

	public class SheilaScene extends NPCAwareContent implements TimeAwareInterface {

//const SHEILA_CORRUPTION:int = 760;
//const SHEILA_XP:int = 761
//const SHEILA_PREG:int = 762;
//const SHEILA_JOEYS:int = 763;
//const SHEILA_IMPS:int = 859;
//const SHEILA_DEMON:int = 764;
//const SHEILA_CITE:int = 765;
//const SHEILA_CLOCK:int = 858;

//Cautious around strangers; doesn't want anything much to do with other people. She'll greet you and introduce herself, but if you begin to pry into her business she'll ask you to leave (on first contact). Her people's bodies transfer emotional energy during sex in an osmotic fashion, pulling it from concentrated sources and pushing it to diffuse ones despite the will of the partner. By repeated contact and respecting her space you may befriend her. Or you may refuse to leave from the get-go and she'll try to drive you off forcefully, allowing you to whoop her and sexcrime her.

//Pseudo-code shit:
//flags required: sheila xp, sheila corruption, demon sheila, sheila clock, sheilapreg, joeycount, sheilacite, sheilaforge
//functions to run at 00:00 each day
//	-sheila clock + 1
//		-makes encounter available only once per day in conjunction with functions afterward; allows timing manipulations for her to get mad at PC for a while
//	-if sheilapreg >= 1, sheilapreg + 1
//		-'birth' occurs at sheilapreg >= 4
//	-if sheilaforge > 0 and sheilacite = 3, sheilaforge + 1
//		-blade forging is finished at sheilaforge >= 14 but is turned over to the Covenant as a dangerous item at sheilaforge >= 21

//functions to run before initiating a sheila encounter, in order (by no means mandatory if you have a better way):
//	-if sheilapreg < 0, prevent encounter
//		-no Sheila at all if PC rejects her pregnancy; too bad, so sad (also used as the general 'off' toggle)
//	-if sheila clock < 1, prevent encounter
//	-if sheila clock = 1, set sheila clock = 0
//		-avoids having to run it at the end of every single output; disregard if unfeasible
//	-if sheila corruption >= 100 and demon sheila = 0, set demon sheila = 1
//		-prevents save editors from changing Sheila's corruption without demonifying her and thereby fucking the game
//	-if demon sheila = 1, set sheila xp = 4
//		-prevents save editor from making a situation that bypasses the demon Sheila imp birth notif and thereby not incrementing the imp birth counter
//	-if sheilapreg >= 4 and sheila xp >= -2, search up a birth announcement instead of outputting usual encounter
//	-else, output the encounter that matches her current state

//sheila xp flag quick reference:
//-4 or less: PC has raped Sheila; Sheila's madder than a cat trying to bury shit on a frozen pond and will always attack
//-3: PC has aggravated her; Sheila will attack and normal relationship is off-limits but PC can backdoor into -2
//-2: PC has never raped Sheila but has lost and been raped by her; triggers Sheila's apology
//-1: PC botched the first meeting but ran away or won/lost without rape; Sheila is wary but allows the PC to apologize
//0: first meeting
//1: reconciliation; Sheila will chat with PC and begin opening up to him
//2: acclimation: Sheila talks more and begins to befriend PC
//3: serendipity; Sheila will sex PC and advance to 4 if PC meets her at 20:00
//4 or more: Sheila wubs PC, will chat or sex as PC desires

//sheila corruption flag quick reference (corruption level determines Sheila breast size and triggers some scenes; breast size function is below):
//0 or less: tits are nearly flat, may trigger special scene later if I give a shit (OUTLOOK NOT GOOD)
//30: C-cup; starting value, set at first meeting
//50: DD-cup; general cutoff point between scenes referring to them as perky vs. pillowy
//90: FF-cup; Sheila's lucidity threshold; triggers event where Sheila gives player a last chance to stop corrupting her
//100: G-cup; sets demon sheila = 1 upon reaching 100 for the first time; may be lowered afterward to adjust her breast size without undoing demonification

//sheilacite flag quick reference (tracks Sheila's lethicite):
//-1 or less: Sheila was demonized by something other than the PC; lethicite was lost
//0: Sheila is still mortal; no lethicite has been created yet
//1: PC has inherited Sheila's lethicite but it is still in unrefined form
//2: PC turned Sheila's lethicite into a piercing
//3: PC turned Sheila's lethicite over to the weaponsmith
//4: PC received the Scarred Blade from the weaponsmith and currently has it on his person or in storage
//5: PC received the Scarred Blade from the weaponsmith but lost it and is eligible to find it if corr >= 70
//6: PC didn't claim the blade from the smith or found it again but elected not to take it

//Other flags:
//-demon sheila: if 1, sheila is a demon
//-sheila clock: prevents more than one sheila encounter per day; also prevents encounters for long periods if set to negative by functions
//-sheilapreg: turned on when PC impregs sheila, grows by one each day or if PC passes another check after sex (diapause lol), outputs a birth notif and turns itself back to 0 once it hits 4; also used to disable sheila entirely if set to negative
//-joeycount: counts number of PC's children with Sheila, both for determining her attitude toward pregnancy and for the More Stats page; may be better suited as a status affect
//-sheilaforge: counts up 1 per day once PC has turned Sheila's lethicite over to the T'A weaponsmith, modifies [Weapons] button outputs in that city's menu if sheilacite = 3

		public var pregnancy:PregnancyStore;

		public function SheilaScene()
		{
			pregnancy = new PregnancyStore(kFLAGS.SHEILA_PREGNANCY_TYPE, kFLAGS.SHEILA_PREGNANCY_INCUBATION, 0, 0);
			CoC.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			pregnancy.pregnancyAdvance();
			if (model.time.hours > 23) {
				if (flags[kFLAGS.SHEILA_CLOCK] < 0) flags[kFLAGS.SHEILA_CLOCK]++;
			}
			trace("\nShiela time change: Time is " + model.time.hours + ", incubation: " + pregnancy.incubation);
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

private function sheilaPreg(reducedChance:Boolean = false):void {
	//CHANCE OF PREGGERS, GAO
	if (pregnancy.isPregnant) return;
	var chance:Number = 5;
	chance += player.cumQ() / 66;
	if (chance > 20) chance = 20;
	chance += player.virilityQ() * 100;
	if (chance > 75) chance = 75;
	if (reducedChance) chance /= 3.0;
	if (rand(100) <= chance) 
	pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_SHIELA);
}

public function sheilaCorruption(arg:Number = 0):Number {
	/*if (flags[kFLAGS.SHEILA_CORRUPTION] + arg > 100) flags[kFLAGS.SHEILA_CORRUPTION] = 100;
	else*/ if (flags[kFLAGS.SHEILA_CORRUPTION] + arg < 0) flags[kFLAGS.SHEILA_CORRUPTION] = 0;
	else flags[kFLAGS.SHEILA_CORRUPTION] += arg;
	return flags[kFLAGS.SHEILA_CORRUPTION];
}

//Sheila's cup function!
internal function sheilaCup():String {
	if (flags[kFLAGS.SHEILA_CORRUPTION]  < 10) return "tiny, almost-absent";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 20) return "A-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 30) return "B-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 40) return "C-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 50) return "D-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 60) return "DD-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 70) return "E-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 80) return "EE-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 90) return "front-running";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 100) return "FF-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 110) return "G-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 120) return "GG-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 130) return "H-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 140) return "HH-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 150) return "'Holy Honkin' Hooters!'-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 160) return "I 'want to squeeze them'-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 170) return "II-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 180) return "Jiggle-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 190) return "JJ-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 200) return "K-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 210) return "KK-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 220) return "L-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 230) return "'Ladylove'-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 240) return "M-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 250) return "'Mega Milk'-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 260) return "N-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 270) return "NN-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 280) return "O-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 290) return "'so big it makes you say' OO-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 300) return "P-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 310 && player.cocks.length > 0) return "'would feel great around your' PP-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 310 && player.cocks.length == 0) return "PP-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 320) return "Q-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 330) return "QQ-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 340) return "R-u-serious?-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 350) return "RR-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 360) return "S-rank";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 370) return "'Shooting Star'-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 380) return "T-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 390) return "'damn, those are some big' TT-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 400) return "'bigger than' U-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 410) return "UU-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 420) return "V-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 430) return "'Va-Va-Voom'-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 440) return "'War Head'-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 450) return "World-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 460) return "X-Buster-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 470) return "XXXX-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 480) return "'Yay'-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 490) return "YY-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 500) return "Z-Saber-cup";
	else if (flags[kFLAGS.SHEILA_CORRUPTION] < 510) return "ZZ-cup";
	else return "fuckin' magic";
}

public function sheilaEncounterRouter():void {
	trace("Sheila Encounter:");
	trace("Sheila Corruption: " + Math.round(sheilaCorruption() * 10)/10 + " Sheila Preg: " + flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] + " Sheila XP: " + flags[kFLAGS.SHEILA_XP]);
	//UNFUCK FLAGS
	if (flags[kFLAGS.SHEILA_CLOCK] > 0)
		flags[kFLAGS.SHEILA_CLOCK] = 0
	if (sheilaCorruption() >= 100 && flags[kFLAGS.SHEILA_DEMON] == 0)
		flags[kFLAGS.SHEILA_DEMON] = 1;
	if (flags[kFLAGS.SHEILA_DEMON] == 1)
		flags[kFLAGS.SHEILA_XP] = 4;
	
	//ACTUALLY PICK ENCOUNTER!
	if (flags[kFLAGS.SHEILA_DEMON] == 0) {
		//PREG SHIT
		if (pregnancy.isPregnant && pregnancy.incubation == 0 && flags[kFLAGS.SHEILA_XP] >= -2) {
			if (flags[kFLAGS.SHEILA_JOEYS] == 0) normalSheilaPregNotifNumberOne();
			else normalSheilaPregNotifREPEATEDED();
			return;
		}
		if (flags[kFLAGS.SHEILA_XP] == 0) sheilaFirstEncounter();
		else if (flags[kFLAGS.SHEILA_XP] == -1 ) sheilaApology();
		//XP-2 Sheila's apology (sheila xp = -2 and demon sheila = 0):
		else if (flags[kFLAGS.SHEILA_XP] == -2) sheilaIsSorrySheRapedYou();
		//XP-3 or XP-4 She-mad (Sheila XP <= -3 and demon sheila = 0):
		else if (flags[kFLAGS.SHEILA_XP] == -3 || flags[kFLAGS.SHEILA_XP] == -4) sheilaReallyMad();
		//XP1: Reconciliation encounter (sheila xp = 1 and demon sheila = 0):
		else if (flags[kFLAGS.SHEILA_XP] == 1) sheilaReconcile();
		//XP2: Familiarizing (Sheila XP = 2; or Sheila XP = 3 AND time =/= 20:00 and demon sheila = 0):
		else if (flags[kFLAGS.SHEILA_XP] == 2 || (flags[kFLAGS.SHEILA_XP] == 3 && model.time.hours != 20)) sheilaGettingFamiliar();
		//XP3: Sexy Time (sheila xp = 3 AND time = 20:00 and demon sheila = 0):
		else if (flags[kFLAGS.SHEILA_XP] == 3 && model.time.hours == 20) sheilaXPThreeSexyTime();
		//XP4: Fancy meeting you here (sheila xp >= 4 and demon sheila = 0):
		else if (flags[kFLAGS.SHEILA_XP] == 4) fuckBuddySheilaMeeting();
		else {
			outputText("A BUG HAPPENED.  YOUR SHEILA_XP: " + flags[kFLAGS.SHEILA_XP] + ". <b>Value should be between -3 to 4.</b>");
			doNext(camp.returnToCampUseOneHour);
		}
	}
	//DEMONS!
	else {
		//Post-demon pregnancy notif (demon sheila = 1 and sheilapreg = 4)
		//increment imp children counter?
		if (pregnancy.isPregnant && pregnancy.incubation == 0) demonImpChildren();
		//Demon Sheila encounter (demon sheila = 1 and sheilapreg < 4)
		else demonSheilaEncounter();

	}
}

private function sheilaCorruptionUpdate():void {
	//Always dump 10 points.
	if (player.cor > 90) {
		dynStats("cor", -10);
		sheilaCorruption(10);
	}
	else if (player.cor > sheilaCorruption()) {
		//Big change, dump ten.
		if (player.cor - sheilaCorruption() >= 10) {
			dynStats("cor", -10);
			sheilaCorruption(10);
		}
		else {
			temp = 0;
			//Small change, do as much as possible.
			while(Math.round(player.cor) != Math.round(sheilaCorruption())) {
				player.cor -= 1;
				if (Math.round(player.cor) <= Math.round(sheilaCorruption())) {
				   break;
				}
				else sheilaCorruption(1);
			}
			player.cor = Math.round(player.cor);
			mainView.statsView.showStatDown( 'cor' );
			// corUp.visible = false;
			// corDown.visible = true;
			statScreenRefresh();
		}		
	}
	else if (player.cor < sheilaCorruption()) {
		//Big Change!
		if (sheilaCorruption() - player.cor >= 10) {
			dynStats("cor", 10);
			sheilaCorruption(-10);
		}
		else {
			temp = 0;
			//Small change, do as much as possible.
			while(Math.round(player.cor) != Math.round(sheilaCorruption())) {
				player.cor += 1;
				if (Math.round(player.cor) >= Math.round(sheilaCorruption())) {
				   break;
				}
				else sheilaCorruption(-1);
			}
			player.cor = Math.round(player.cor);
			mainView.statsView.showStatUp( 'cor' );
			// corUp.visible = true;
			// corDown.visible = false;
			statScreenRefresh();
		}
	}
	//Get one for demon Sheila regardless.
	if (flags[kFLAGS.SHEILA_DEMON] == 1) dynStats("cor", 1);
}

//XP0: the first encounter (sheila xp =0 and demon sheila = 0):
private function sheilaFirstEncounter():void {
	clearOutput();
	//set sheila corruption = 30
	flags[kFLAGS.SHEILA_CORRUPTION] = 30;
	outputText("A strange sight meets your eyes and you drop behind some brush to examine it carefully.  It looks like a dog, though all you can see is a pair of furry hindquarters and a stubby tail draped over them.  But as you get closer, it unbends, revealing a decidedly humanoid upper body!  The creature seems to be wearing a white shirt and a dirty brown vest; what looked like a dog's shoulders from afar is actually a small pack carried on its back.  On its head is a dusty slouch hat, which it presently takes off and begins to fan itself with.  With the hat off, you can see a pair of long reddish-brown ears sticking out from its hair, pointing to each side.  As it turns its body to look around it, you can actually make out a shapely pair of breasts.  What you thought were a dog's hindlegs from the rear are actually a pair of auburn, furry digitigrade appendages only passingly resembling a canine's, and bearing feet with elongated metatarsals.  The animalistic legs come up only as far as the thigh; above them you can make out a band of skin between the fur and the very short shorts that it wears to cover the rest of its posterior.  Its hips are a bit wider than its waist, and the stubby tapered tail sticks out of a tear in the fabric, just below a belt holding them up.");
	
	menu();
	//[Look Closer][Stay Hidden]
	addButton(0,"Look Closer",sheila1ndEncLookCloser);
	addButton(1,"Stay Hidden",sheila1stEncStayHidden);
	//spacebar defaults to [Stay Hidden] -NOT POSSIBURU
}

//[XP0 - Stay Hidden]
private function sheila1stEncStayHidden():void {
	clearOutput();
	outputText("You regulate your breathing and hold yourself still to avoid rustling anything softly, waiting for the creature to finish its business and leave.");
	//no change in sheila xp
	doNext(camp.returnToCampUseOneHour);
}

//[XP0 - Look Closer]
private function sheila1ndEncLookCloser():void {
	clearOutput();
	outputText("Your head pokes up a bit to get a better look at the rest of the creature.  It stands flat on its long feet and cranes its head further as well, taking in more of the gently rolling countryside, but then catches you out of the corner of its eye!  With a yelp it pushes itself up on its hindpaws again and calls, in an unmistakably feminine voice, \"<i>Friend or foe?!</i>\"");
	
	outputText("\n\nYou unbend to your full height and answer her challenge, making sure she can see you.  She makes no motion to close the distance, so you take it upon yourself to walk over to her; she doesn't move, but stops you at about ten paces.  \"<i>Far enough!  Let me get a look,</i>\" she shouts.");
	//--Next--
	menu();
	addButton(0,"Next",sheila1ndEncLookCloserPtII);
}

private function sheila1ndEncLookCloserPtII():void {
	clearOutput();
	outputText("You subject yourself to her examination; she seems to take professional interest in the way you hold your [weapon].  ");
	//[(PC weapon = Scarred Blade)]
	if (player.weaponName == "Scarred Blade") outputText("As the blade feels her gaze, it vibrates eagerly toward her, sliding partway out of the oiled scabbard; she stares into the exposed metal transfixed, as if looking into the diary of a past life.  Abruptly, she shakes her head and turns away, and the saber calms down.  ");
	outputText("Meanwhile, you use the opportunity to take your own look at her.  She's about six and a half feet unbent, though her legs are crooked like an animal's and could conceivably push her up to seven if straightened.  Her tapered tail only reaches a little past her hips.  The straight hair on her head is colored like her fur and chopped off at the jawline, and her bangs are tucked behind one of her long ears.  They slip forward whenever she bends her head down, only to be retucked with a free hand when she looks up again.  Her face is rather pretty overall, with an egg or oval shape that tapers at the chin and slight cheekbones, but falls short of true beauty by being a shade too commonplace.  She has a small, even nose, and her eyes are a very light brown - amber, even, depending on the angle of the light.  Looking downwards, you can see her shirt is cut with a v-neck, revealing cleavage from a pair of medium-sized breasts; probably C-cup, though it's hard to say with the vest in the way.  Her body is toned and her skin is somewhat tan, you'd guess she spends a lot of time out of doors.");
	outputText("\n\nFinally satisfied with looking you over, she says, \"<i>She'll be apples.  Sorry to put y'out, but you never know what sort you'll find in the back of nowhere, right?</i>\"");
	//[(libido>=50)
	if (player.lib >= 50) outputText("  Noting you still checking out her body, she smirks and says, \"<i>Enjoying your lookie, then?  Up here, cobber,</i>\" causing you to snap your head up sheepishly.");
	outputText("  You nod at the strange woman and introduce yourself.");
	if (player.short != "Sheila") outputText("  \"<i>" + player.short + ", eh?  My mates just call me Sheila.  Bunch of jokers, the bastards.</i>\"");
	else outputText("  \"<i>You too, eh?  Sheila's what my mates call me for a nickname.  Don't suppose you got yours from a bunch of adolescent-minded wankers, though.</i>\"");
	
	outputText("\n\nStrange to see another person so far from anywhere, and a friendly one at that.  Sheila smiles a tight-lipped smile at you and tells you she felt the same herself.  \"<i>Right dangerous out here, with all the bloody gnolls and belligerent cows about.  Of course they've always been whackers.  I was just hunting a bit of tucker, but it's got clean away.</i>\"  She gestures toward the ground.  Next to her feet is a trap cleverly hidden in the brush, though it looks like her quarry broke the snare.");
	
	outputText("\n\n\"<i>Hard luck,</i>\" you say.");
	
	outputText("\n\nShe nods, frowning in a way that discourages you from dwelling on it.  You proffer some of your own food, but she just stares at you.  \"<i>Nah, mate; never take food from strangers.  But good onya for offering.</i>\"");
	
	outputText("\n\nCurious and eager to change the subject, you ask her where exactly her aforementioned 'mates' are.  She narrows her eyes at the question.  \"<i>Don't expect that's any of your bizzo, eh stickybeak?  No offense, but I don't know you from Marae an' I'm not about to give info to some dipstick demon dag in disguise.");
	//[(high demon score)
	if (player.demonScore() >= 4) outputText("  I mean, take a squizz at yourself.  It's like you're not even trying to hide it; I've seen imps that look more like normal people.");
	outputText("  Forget it.</i>\"  You deny the accusation, but she continues to glare at you.");
	
	outputText("\n\n\"<i>No worries,</i>\" she says, her words at odds with her chilly expression.  \"<i>Just be on your way and we'll forget it happened.</i>\"");
	
	outputText("\n\nYou ask her if you couldn't possibly talk more; it's been a while since you've met someone new.  She looks at you harder, and her posture tenses up slightly.  \"<i>Maybe, but not THIS arvo.  Be a corker and take the hint.  I'm trying to catch lunch, and a girl might think you mean something by making a nuisance of yourself.</i>\"  She seems cranky and disinclined to talk... you could let her be for now or try again.");
	
	//[Talk][Leave]
	menu();
	addButton(0,"Talk",sheila1ndEncLookCloserPtIITalk);
	addButton(1,"Leave",sheila1ndEncLookCloserPtIILeave);

}


//[XP0 - Look Closer - Leave]
private function sheila1ndEncLookCloserPtIILeave():void {
	clearOutput();
	outputText("\"<i>Good onya.  Maybe I'll see you around.</i>\"  With that, you take your leave of the strange woman.");
	//set sheila xp = 1
	flags[kFLAGS.SHEILA_XP] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//[XP0 - Look Closer - Talk]
//set sheila xp = -1
private function sheila1ndEncLookCloserPtIITalk():void {
	clearOutput();
	flags[kFLAGS.SHEILA_XP] = -1;
	outputText("\"<i>Alright, my earbashing mug, have it your own way.  I get mean when I get hungry; don't say I didn't warn ya.</i>\"  With that, Sheila takes a swing at you!  You jerk backwards to avoid the punch but move too slowly, she clips the end of your [face].  What a wind!  If she'd been trying to hit you, that sucker punch would likely have laid you out.  Just as you open your mouth to speak again, she rears back on one leg and kicks you away hard with the other, knocking the air out of you.  You land painfully on your back.");
	player.takeDamage(2);
	outputText("\n\n\"<i>Feel like leaving now?</i>\" she asks, grinning mirthlessly and raising her fists in front of her.  You rub your smarting nose and sit up, looking angrily at her.  She's proven that she's very fast and probably quite strong, though you have no idea how experienced she is at actually fighting - and there's a bit of a regretful look in her eyes, to boot.  Do you turn tail or fight back?");
	
	//[Leave][Fight]
	menu();
	addButton(0,"Fight",sheila1ndEncLookCloserPtIITalkFight);
	addButton(4,"Leave",sheila1ndEncLookCloserPtIITalkLeave);
}

//[XP0 - Look Closer - Talk - Leave]
private function sheila1ndEncLookCloserPtIITalkLeave():void {
	clearOutput();
	outputText("Wordlessly, you get up and back away from the woman... though not without a dirty glance.  She follows you with her eyes until you judge yourself far enough away to turn your back to her.");
	//go to camp
	doNext(camp.returnToCampUseOneHour);
}

//[XP0 - Look Closer - Talk - Fight]
// go to fight
private function sheila1ndEncLookCloserPtIITalkFight():void {
	clearOutput();
	startCombat(new Sheila());
	playerMenu();
}

//XP-1: PC's apology (sheila xp = -1 and demon sheila = 0):
private function sheilaApology():void {
	clearOutput();
	outputText("As you search the plains for god-knows-what, you catch your [leg] on something; a rustling in the brush below you is the only warning you get before a cleverly hidden snare closes on it!");
	outputText("\n\n\"<i>Aha, got you now, you little... oh, it's you.</i>\"");
	
	outputText("\n\nSheila, who was apparently either dozing or lazing about in her cover to have failed to notice you, is peeking head and shoulders out of some tall grass.  She stares at you, nonplussed, as you unfasten the trap.  \"<i>Didn't peg you for an altruist.  But if you're tired of livin' and y'wanna feed me and me mates, I expect there's enough meat on you.</i>\"  She cracks a vicious smile and saunters over cautiously as you return her glare.");
	
	outputText("\n\nStepping aside so she can retrieve her trap, you maintain eye contact with the woman, wary of every movement.  Finally, she sighs and says, \"<i>You got something you wanna get off your chest?  I don't much feel like walking on eggshells around you for the rest of my life.</i>\"");
	
	outputText("\n\nThis is probably about as receptive as you can expect in the circumstances.  Do you say something to her?");
	
	//[Apologize][Slap&Insult][Nothing][Avoid Her]
	//spacebar defaults to [Nothing]
	menu();
	addButton(0,"Apologize",apologySheilaApology);
	addButton(1,"SlapNInsult",apologySheilaSlapSult);
	addButton(2,"Nothing",apologySheilaSayNothing);
	addButton(3,"Avoid Her",apologyAvoidSheila);
}


//[XP-1 - Avoid Her]
private function apologyAvoidSheila():void {
	clearOutput();
	outputText("You shake your head at the leery girl, and tell her you'd be just as happy as she would if you never saw each other again.");
	outputText("\n\n\"<i>Well... I expect I could arrange that if you'll play along,</i>\" she says, ears twitching in irritation.  \"<i>Take care of yourself, mate.</i>\"  She resets the trap and lays down in her spot in the tall grass again, pointedly turning over on her side to show you her back.");
	//set sheilapreg = -1
	flags[kFLAGS.SHEILA_DISABLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//[XP-1 - Apologize]
private function apologySheilaApology():void {
	clearOutput();
	outputText("You scratch your " + player.skinFurScales() + " absently behind an ear, not sure how to broach the topic of reconciliation when you feel like she was the aggressor, but mumble something about being sorry things started off on the wrong foot.");
	
	outputText("\n\nSheila quirks an eyebrow at your apology.  \"<i>Alright,</i>\" she says simply, passing over your reluctance to assign blame for the situation.  \"<i>I guess I can't fault you for being gobsmacked that someone in this land didn't immediately smother you in kisses and spend the day boffing you like a newlywed at your first meeting, but don't take so much for granted.  You can't stay free from the demons by trusting strangers.</i>\"");
	
	outputText("\n\nShe smiles wanly and motions you away from the vicinity of the snare, then resets it and returns to her cover in the long grass.  Before you can address her again, she shoots you a warning glance.  \"<i>I've still got dinner to catch, so don't run your mouth at me right now.  I don't need your jawing to chase off every bit of tucker that comes close.</i>\"");
	
	outputText("\n\nWell... it looks like you're back to square one.");
	
	//set sheila xp = 1
	flags[kFLAGS.SHEILA_XP] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//[XP-1 - Slap'n'sult]
private function apologySheilaSlapSult():void {
	clearOutput();
	outputText("You say nothing as she finishes with the snare and stands back up.");
	outputText("\n\n\"<i>Well?</i>\" she asks, setting her mouth in a hard line and looking straight into your eyes.");
	
	outputText("\n\nBefore she can do more than flinch, you bring your hand up from your side and across her face, sending the sharp crack of a slap rolling across the dry, open landscape.  Several spur-of-the-moment comments about xenophobia and bigotry find their way out in the pause before she recovers the presence of mind to speak.");
	
	outputText("\n\n\"<i>Fuck you, arsehole!</i>\" she counters, breaking in.  \"<i>I'm not about to stand here and take a bollocking from some mullet who rolls up and expects everyone " + player.mf("he","she") + " meets to fall over " + player.mf("his","her") + " charming self like " + player.mf("he","she") + "'s the storybook hero" + player.mf("","ine") + "!  If you want a girl who'll be your soulmate at the word 'hello' you can go look for sloppy seconds from one of those goblin slags!</i>\"");
	
	outputText("\n\nShe raises a fist and takes a swing at you again, but without the element of surprise this time; you lean inside the hook and catch her upper arm harmlessly on the side of your face, then shove her away roughly before she can kick you.  She stumbles backwards, nearly falling over.");
	
	outputText("\n\n\"<i>So that's how it'll be, then!  I'm done trying to talk sense to you, ya clacker!</i>\"  The incensed woman assumes a fighting posture, and you respond in kind.");
	
	//set sheila xp = -3, go to fight
	flags[kFLAGS.SHEILA_XP] = -3;
	startCombat(new Sheila());
}

//[XP-1 - Nothing]
private function apologySheilaSayNothing():void {
	clearOutput();
	outputText("You decide to keep your own counsel for now, folding your arms defensively and frowning.");
	
	outputText("\n\n\"<i>All right; please yourself, ya tosser,</i>\" Sheila says, resetting the trap and backing away from you.  \"<i>Just watch where you're walking.</i>\"");
	
	outputText("\n\nYou grunt and watch her resume her cover in the long grass, then turn about and head back to camp.");
	
	//no change in sheila xp
	doNext(camp.returnToCampUseOneHour);
}

//XP-2 Sheila's apology (sheila xp = -2 and demon sheila = 0):
//Sheila apologizes to PC for taking advantage of him while she was horny
private function sheilaIsSorrySheRapedYou():void {
	clearOutput();
	outputText("You stalk through the plains, hunting for a bite to eat or something to give you an advantage in this harsh land.  A rustle follows you as you move into some tall grass; it takes several minutes before you realize with alarm that it's slightly out of phase with your steps.  You whirl around, only to find... Sheila, staring at you sheepishly.  Has she been following you this whole time?  You watch each other for a few minutes, neither of you making any move but her cheeks glowing brighter red with every word that doesn't pass between you.");
	
	outputText("\n\n\"<i>Er... g'day,</i>\" she begins, finally taking the plunge.  \"<i>Before you say anything, I want to... well, apologize for before...</i>\"  She hesitates, then continues breathlessly.  \"<i>I kind of got caught up in the moment - not that that's an excuse, mind!  But I just wanted to let you know that's not really me and that I'd never... um...</i>\"");
	
	outputText("\n\nShe trails off, reaching across her midriff to rub her elbow and looking away.  \"<i>Anyway, think you could give a gal fair go?</i>\"  She's obviously trying quite hard to be humble but doesn't have much practice.  How do you react?");
	
	menu();
	//[Forgive][Fight][Cast Arouse][Leave Me Alone]
	addButton(0,"Forgive",sheilaIsSorryAndYouForgive);
	addButton(1,"Fight",sheilaPologyFight);
	if (player.findStatusEffect(StatusEffects.KnowsArouse) >= 0) addButton(2,"CastArouse",sheilaPologyCastArouse);
	addButton(3,"LemmeAlone",sheilaIsSorryButLeaveMeAlone);
	

}

//[XP-2 - Leave Me Alone]
private function sheilaIsSorryButLeaveMeAlone():void {
	clearOutput();
	outputText("You shake your head and turn away, dismissing Sheila with a pointed gesture.  \"<i>H-hey!</i>\" the girl calls angrily from behind you.  \"<i>Dammit, I said I was sorry, you bastard!  Screw you!  See if I talk to you again!</i>\"");
	//set sheilapreg = -1
	flags[kFLAGS.SHEILA_DISABLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}
//[XP-2 - Forgive]
private function sheilaIsSorryAndYouForgive():void {
	clearOutput();
	outputText("\"<i>Okay.</i>\"");
	
	outputText("\n\n\"<i>Huh?  Just 'okay'?</i>\" she asks.  \"</i>You don't care?</i>\"  You restrain yourself from shrugging your shoulders openly.  It's not like she looked terrible naked, after all, and it was halfway your doing... but to maintain some degree of verisimilitude, you frown and tell her that you're willing to give her a chance to start over.");
	
	outputText("\n\nShe brightens a bit.  \"<i>Bonzer!  Load off my mind.  Um... hate to be a piker but I have to get my catch back home so... I'll see you later?</i>\"");
	
	outputText("\n\nYou nod and she turns, loping away on her long legs.");
	
	//set sheila xp to 4 if joeycount > 0, else set sheila xp to 1
	if (flags[kFLAGS.SHEILA_JOEYS] > 0) flags[kFLAGS.SHEILA_XP] = 4;
	else flags[kFLAGS.SHEILA_XP] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//[XP-2 - Fight]
private function sheilaPologyFight():void {
	clearOutput();
	outputText("Saying nothing, you raise your [weapon] and take a swing!  Sheila starts a bit and dodges just in time, then with a look of resignation, raises her fists as well.  \"<i>That'll be right, I guess.  For what it's worth, I really am sorry.</i>\"");
	//go to fight, set sheila xp = -3
	flags[kFLAGS.SHEILA_XP] = -3;
	startCombat(new Sheila());
}

//[XP-2 - Cast Arouse]
//requires PC has mastered the spell and has enough fatigue/lust to use it
private function sheilaPologyCastArouse():void {
	clearOutput();
	player.changeFatigue(15,1);
	outputText("You nod at the woman and tell her that you forgive her, even as the gears of revenge turn in the dark corners of your mind.  As she smiles and begins to babble in relief, you focus on her slender body and recite under your breath the first of the formulae that will leave her a gibbering, begging mess.");
	
	outputText("\n\n\"<i>-wanna thank you for not taking it personally.  I mean... it was a rough day, yeah, but I had no idea that it was that close to the surface, that I'd lose control after just a little teasing from you, y'know?</i>\"  You nod again in mock understanding as your eyes move to the woman's crotch and your litany to its second phase.");
	
	outputText("\n\n\"<i>I'm glad there're no hard feelings and... uh,</i>\" Sheila continues.  \"<i>I h-hope that, ah, we c-can...</i>\"  Her knees begin to quiver.  \"<i>... c-can get st-started off on the r-r-right ffff-</i>\"");
	
	outputText("\n\nAs you finish the spell, a small wet spot forms on the front of her shorts.  \"<i>Fffffuck!</i>\" she moans, as her thighs clap together and she slumps down.  \"<i>Oh g-god, what is happening?  I'm so s-sorry!</i>\"");
	
	outputText("\n\nFaking concern, you ask her if she's allright.  She looks up at you sheepishly.  \"<i>I d-don't know!</i>\" she whimpers.  \"<i>Something's wrong with - ah...</i>\"  Sheila blushes brightly.  \"<i>... with my... body.</i>\"");
	
	outputText("\n\nShe flinches as an experimental touch sends another shiver through her.  \"<i>God!  Ah, I'm just suddenly... so horny!</i>\"  The kangaroo girl struggles to her feet.  \"<i>Just have to focus on home and walk, and I'll be... okay.</i>\"");

	outputText("\n\nShe takes one shaking step and you're rewarded by the sight of a fresh bloom of wetness on the crotch of her shorts before she crumbles once more.  \"<i>Fuck!</i>\" the girl yells again, dropping her hand to her pants.  The hand slides into her waistband, beyond her power to stop - all she can do is mouth a soft 'ah-ah-ah'.");
	
	outputText("\n\nYou take a step backwards and turn around, smiling at your reduction of the arrogant woman, but she calls to you from behind.  \"<i>Wait!  Ah-I need your help... please.</i>\"  Forcing a neutral face, you look over your shoulder at her.  \"<i>I can't... ah-afford to get caught like this...</i>\" she continues, \"<i>c-can you - ah!</i>\"");
	
	outputText("\n\n\"<i>Can I what?  What do you want me to do?</i>\" you ask, narrowing your eyes.  Sheila lowers her head, embarrassed, until she's peering out at you from under hair that's fallen over her face.  \"<i>Well?</i>\"");
	
	outputText("\n\n\"<i>Please... let me fuck you!</i>\" she blurts, and then colors bright red.  \"<i>If I can't work this off and a demon finds me, I'm as good as dead!</i>\"");
	
	outputText("\n\nBetter and better.");
	dynStats("lus", (player.lib/5), "resisted", false);
	//[Let Her][Leave]
	menu();
	addButton(0,"Let Her",castArouseAndLetHer);
	addButton(4,"Leave",castArouseAndLeaveSheila);
}

//[XP-2 - Cast Arouse - Leave]
private function castArouseAndLeaveSheila():void {
	clearOutput();
	outputText("You shake your head sadly.  \"<i>I'm sorry, I haven't the time right now.</i>\"");
	
	outputText("\n\nThe panting girl looks horrified.  \"<i>No!  Please, no!  If you leave me alone to get caught, I'm done for!</i>\"");
	
	outputText("\n\n\"<i>You're being melodramatic.  I'm sure it'll be fine.</i>\"");
	
	outputText("\n\nTurning away again, you leave the woman calling after you.  Not a very good way to avoid attention for someone who says she doesn't want to be discovered.");
	
	//set sheila corruption = 100 and demon sheila = 1 and sheilacite = -1, increase PC corruption + 10
	flags[kFLAGS.SHEILA_CORRUPTION] = 100;
	flags[kFLAGS.SHEILA_DEMON] = 1;
	flags[kFLAGS.SHEILA_CITE] = -1;
	dynStats("cor", 10);
	doNext(camp.returnToCampUseOneHour);
}

//[XP-2 - Cast Arouse - Let Her]
private function castArouseAndLetHer():void {
	clearOutput();
	outputText("As soon as you nod, the girl bounds to her feet and jumps you, driving you slightly downward in her ardor.");
	//increase PC corruption +10, output loss scene consonant with player's sex, set sheila xp = 4
	dynStats("cor", 10);
	flags[kFLAGS.SHEILA_XP] = 4;
	//Call appropriate loss router
	menu();
	addButton(0,"Next",sheilaLossRapeRouter);
}

//XP-3 or XP-4 She-mad (Sheila XP <= -3 and demon sheila = 0):
private function sheilaReallyMad():void {
	clearOutput();
	outputText("A rustle in the bush claims your attention, and you turn your head to see Sheila, standing up suddenly.  Her eyes narrow when she recognizes you, and she takes off running!");
	
	outputText("\n\nIt doesn't take long, of course, until she realizes she's forgotten her catch; when you pick the bundle of game up and hold it out to her, Sheila trots guiltily back and stops a few paces in front.");
	
	outputText("\n\n\"<i>I don't want anything to do with you,</i>\" she says, sulking and staring downward.  \"<i>");
	//[(sheila corruption >= 90)
	if (flags[kFLAGS.SHEILA_CORRUPTION] >= 90) outputText("It's so hard to remember myself anymore, and the taint you've put in my body goes crazy when you touch me.  Do you want me to get on my hands and knees?</i>\"  The woman lowers herself to the ground.  \"<i>I beg you.  ");
	outputText("Please, please leave me alone.");
	if (flags[kFLAGS.SHEILA_XP] == -3) outputText("  I know you... you're not as bad as the rest of the monsters out here, so... please.");
	outputText("</i>\"");
	//[Stand][Leave]
	menu();
	addButton(4,"Leave",sheilaReallyMadLeave);
	addButton(0,"Stand",sheilaReallyMadStandGround);
	//spacebar default should be leave
}

//[XP-3 - Leave]
private function sheilaReallyMadLeave():void {
	clearOutput();
	outputText("Huffing, you throw the animals down and turn away.  What a display.");
	//go to camp, reincarnate as something slightly better next life
	doNext(camp.returnToCampUseOneHour);
}

//[XP-3 - Stand]
private function sheilaReallyMadStandGround():void {
	clearOutput();
	//[(normal mode)]
	if (!silly()) {
		outputText("You throw the animals behind you and fold your arms.");
		outputText("\n\nSheila shivers, then speaks.  \"<i>Alright, mate.  If that's the way it has to be.</i>\"  She raises her fists half-heartedly.");
	}
	//(silly mode)
	else {
		outputText("Throwing the bundle to the side dramatically, you call the name of your stand!  Sheila's eyes widen as your body surges with renewed energy, and she jumps back as a ghostly other self materializes next to you.");
		outputText("\n\n\"<i>So... it has to be like this, then?  Alright!</i>\"  Sheila thrusts a fist in the air, eyes glinting, and yells \"<i>Come out!  'Ready, World'!</i>\"  A form flows from her, taking the shape of a slim, dark woman with curly, almost liquid hair, in a loose vest and billowing, long-sleeved tunic.  Sheila jumps at you, and both the woman and her glamorous stand draw back to punch!");
	}
	//go to fight; if silly mode, heal 20 hp and 10 fatigue on PC and set sheila HP = 120%
	startCombat(new Sheila());
	if (silly()) {
		monster.HP *= 1.2;
		player.changeFatigue(-10);
		HPChange(20,false);
	}
}

//XP1: Reconciliation encounter (sheila xp = 1 and demon sheila = 0):
//wherein Sheila actually wipes the sand out of her shorts and talks to the PC
private function sheilaReconcile():void {
	clearOutput();
	outputText("\"<i>Oy, it's you,</i>\" sings out a voice behind you.  \"<i>Back again?</i>\"");
	
	outputText("\n\nYou turn around quickly, panning the horizon for the source.  It doesn't take you long to pick out the head and long ears of Sheila, sitting up above the grass she must have been lying in until now.  A simple wave answers her greeting, but you keep a buttoned lip, remembering the last chilly reception.");
	
	outputText("\n\n\"<i>Heh,</i>\" she says, grinning.  \"<i>You catch on quick, mate.</i>\"  The grass rustles next to her and her hand appears, holding a bundle of several dead rabbits by their tied-together feet.  \"<i>I have plenty of protein donors already, though.  Was just lazing a bit before I decided what to do for grub, and then there you are, standing out like dog's balls.</i>\"  She rubs the back of her head and looks away.  \"<i>Well... care to join me for tea?  I guess I was a wee bit rude before, and it gives me an excuse to cook one of these beasties.  BYOB, of course.</i>\"");
	
	//[Kay]/[Don't Wanna]
	//spacebar default is [Don't Wanna]
	menu();
	addButton(0,"Kay",sheilaReconcileKay);
	addButton(1,"Don't Wanna",sheilaReconcileDunWanna);
}

//[XP1 - Don't Wanna]
private function sheilaReconcileDunWanna():void {
	clearOutput();
	outputText("Raising your hands in a palms-out gesture, you decline.  Sheila colors a bit, misinterpreting your reluctance.  \"<i>Hey, it's not like I'm cracking onto you or anything.  I was just looking for a reason to eat half a rabbit myself, is all.</i>\"");
	
	outputText("\n\nYou quickly formulate some pleasantries to lessen the awkwardness, and assure her that you're just busy; she seems to calm down.  As you turn away and head back to camp, you can hear her mumbling.");
	
	outputText("\n\n\"<i>Guess it's bodgy bikkie again today...</i>\"");
	//no change in sheila xp
	doNext(camp.returnToCampUseOneHour);
}

//[XP1 - Kay]
private function sheilaReconcileKay():void {
	clearOutput();
	outputText("Some fresh meat does sound pretty tempting.  You nod at the woman and she climbs to her feet.  \"<i>Beaut!  Do me the favor and fossick about for some tinder.</i>\"");
	//--Next--
	menu();
	addButton(0,"Next",sheilaReconcileKay2);
}
	
private function sheilaReconcileKay2():void {
	clearOutput();
	outputText("Soon enough you've got a firepit going in a small clearing.  \"<i>Ahh, classic bush theater,</i>\" Sheila says, admiring it.  The woman dextrously spits two liberated and skinned rabbit quarters on a long stick and twirls them over the lapping flame, and soon the air is full of the sizzle and pop of meat juices dripping on the hot stones and the simple tune your cook hums.  You stare at ");
	if (player.lib < 50) outputText("the beckoning hunks of meat");
	else outputText("her rising and falling breasts under the pretext of watching her work");
	outputText(", until she happens to look up and catch your eye.  \"<i>Sorry, no parsley,</i>\" she says, breaking into an obliviously happy smile.  Seems like her temperament preternaturally suits this lifestyle.");

	outputText("\n\nYou're brimming with questions to ask of her handsomely-blossoming personality, but bite your lip.  Food first - your teeth are practically swimming in saliva.  She pulls the spit out of the fire and sticks a clasp knife into the chunks in several places, checking the inside, then passes one to you on a smaller stick.");
	
	outputText("\n\n\"<i>Ah, here,</i>\" she says abruptly, pulling out a biscuit and holding it out to you as well.  You take it with care; it feels slightly slippery to the touch.  \"<i>Fish oil cracker,</i>\" Sheila explains.  \"<i>Made it myself this morning.  Eat nothing but rabbit and you get stonkered with headaches and fat cravings - any lean meat, really.  Most bushrangers find out the hard way.  I'm not cook enough to make it tasty, so get it down first and bog in afterward.</i>\"  She beams a smile as you eye up the unappetizing morsel of dry, fishy bread and swallow it in a single mouthful, then grimace.  Despite the kindly concern evidenced by the gesture, she... definitely wasn't sugar-coating the description.");
	
	outputText("\n\nThe two of you devour the first half of the meat in greedy silence, picking morsels from the bones without remorse; Sheila finishes before you and spits the second half of the rabbit, then begins holding it over the fire as she did the first.  Peering over your nearly-bare rabbit quarter at her, you turn the question you've been shaping in your head over a few times.");
	player.refillHunger(50);
	outputText("\n\n\"<i>So how is it that you and your friends come to live out here by yourselves?</i>\"");
	
	outputText("\n\nShe stops humming and looks absently at the meat for a while, as if deciding whether to answer, and for a moment you despair of ever piercing the veil of her bluffness.");
	
	outputText("\n\n\"<i>You make it sound like it's only the three blokes and yours truly huddled in a cave for warmth,</i>\" she responds, finally.  \"<i>Sorry, I know I've never said otherwise; just a funny thought.  Actually we're part of a little hidden alcove, village-sized, with over fifteen families.  Everyone I've ever met that's like me lives in a similar enclave, led by a political and quasi-religious yobbo");
	//[(pc is kangaroo)
	if (player.race() == "kangaroo-morph") outputText(" - except you, I suppose");
	outputText(".  We trade our goods in prearranged op shops and dead drops but avoid bringing outsiders into our own settlements, even when they're right corkers.</i>\"");
	
	outputText("\n\nYou press her on the last point.  \"<i>Well, what you don't know, you can't reveal when the demons take you, right?</i>\" she answers.  \"<i>I dunno if I should tell you this, but... the other reason has to do with our bodies.</i>\"  She looks over at you, searching your face for something inscrutable; you compose a mask of patient, perfect attention as you chew another mouthful of meat.  \"<i>Y'see, we're very empathetic to and conductive of emotions under certain circumstances - namely, during a shag.</i>\"  She looks away again, into the fire; as you peer closer, she actually appears to be blushing.  \"<i>When we, er... orgasm,</i>\" she resumes, still not meeting your eyes, \"<i>we give or take emotion and feeling from our partner depending on whether they have more or less than us.  For example, it means that horny buggers");
	//[(lib >50)]
	if (player.lib >= 50) outputText(" like yourself - I saw you perving -");
	outputText(" make us a little hornier, and evil buggers make us a bit more evil.  Our bodies tend to change on their own to reflect how tainted we are... which is as much as saying there are a sad lot among us who flirt with demonic energy to up our sizes to suit our egos.  But versus the sexual appetite and limitless rapacity of the demons themselves...?</i>\"");
	
	outputText("\n\n\"<i>We were never prolific, but they tore through us like parchment when they first attacked.  Open-air villages disappeared overnight, leaving only those run by xenophobic, isolationist, stealth nutters.  You've likely met my ex-tribe before if you've met any number of demons; a mug unlucky enough to be caught turns pretty much instantly when he or she climaxes and is flooded with their feelings.</i>\"  She pulls the remaining meat out of the fire and examines it, then hands you half.  At the look in your eyes, she grins.  \"<i>It's not as bad as all that.  Unhappy marriages are almost unheard of, since emotional intensity evens out inside couples.  Bit of a 'build-your-own-soulmate' workshop, right?  Demons are the problem, as always.</i>\"");
	
	//[(if PC has Tel'Adre)]
	if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) {
		outputText("\n\nYou interject here to mention the city you found in the desert.  Sheila grimaces and nods, then answers, \"<i>We got word of that from one of our trading partners near the desert a while back.  Seems like they had a wild blue in a town meeting after finding out and half the younger residents grabbed swag and hiked there, tired of hiding.</i>\"  She chews morosely, anticipating the end to her own story.");
		
		outputText("\n\n\"<i>A few of the kids lobbed in ten months later... they were just courtin' when they left, but they got married in the city; one of the girls was preggers and almost due when a hunting team picked them up.  The Covenant found out about our ability early and there was pressure on the expats to produce new generations and turn them over for 'proper civic education'; pressure in the form of both stick and carrot.  Preferred housing, deferred prosecution for bludging or criminality, you know.  Some of the bachelors even swore there was subtle public censure for those that chose celibacy or isolation - it'd be easy enough to establish that mindset in a town full of hookers where everybody's getting some.</i>\"  Sheila spits some gristle onto the ground emphatically.  \"<i>Dunno what they wanted the babes for, but speculation ran wild among our little community when the story came back.  At least one whacker's theory has it that the Covenant mages themselves wanted a literal dumping ground for their impure thoughts, but more people think they just wanted to raise them true blue, then pair the kids off with hotheaded young knockers who won't stop agitating, both to dob on them and root them into line.  Wherever the truth is, our young sheila didn't want to feel like she handed her joey over to the Covenant schools in exchange for a dole, and her man supported her.  So that mob is more or less no-go for anyone who doesn't want kids or wants to raise them by their own hands.</i>\"");
	}
	outputText("\n\nShe drops her last bone onto the ground between her knees; you're still not halfway through your own second helping, thanks to being absorbed in her story.  \"<i>Sorry, ya bastard,</i>\" she laughs, \"<i>did I spoil your appetite with my sad tale?  You're the yobbo for askin'.</i>\"");
	
	outputText("\n\nA broad smile lets you know she's just joking as she scatters the cooling fire with her spit, stirring and dispersing the ashes.  \"<i>Thanks for the chatter.  Maybe I'll see you again.</i>\"  Picking up her catch, she turns and lopes off.");
	//set sheila xp to 2
	flags[kFLAGS.SHEILA_XP] = 2;
	doNext(camp.returnToCampUseOneHour);
}

//XP2: Familiarizing (Sheila XP = 2; or Sheila XP = 3 AND time =/= 20:00 and demon sheila = 0):
private function sheilaGettingFamiliar():void {
	clearOutput();
	outputText("\"<i>Hey, it's [name].</i>\"");
	
	outputText("\n\nSheila's voice rings out from your right.  You turn and face her; the formerly-reticent woman smiles warmly from her seat in the grass.  \"<i>Ya just missed tucker,</i>\" she opens, \"<i>a pity.</i>\"");
	
	outputText("\n\nThere's no campfire in evidence nearby, a face which makes you raise an eyebrow.  \"<i>Cut lunch,</i>\" Sheila amends.  \"<i>Just some dried meat and fruit on bread.  A real shame you didn't show up sooner, I enjoyed our barbecue pit.</i>\"  Even having just eaten, Sheila's eyes light with appetite.");
	
	outputText("\n\nHer almost-childlike enthusiasm for simple pleasures is infectious, and you find yourself grinning back at her.  She holds a small parcel out to you.  \"<i>I've caught enough game to carry back already, so you can have the snack I was saving; mate's rate.  Lucky, right?  Some days I'm out here sunrise to curfew trying to find enough.</i>\"  Accepting and opening it, you see a few pieces of smoked, salted meat and candied fruits.  \"<i>I know; the presentation sucks,</i>\" she says, \"<i>but give it a burl if you're hungry.</i>\"");
	
	outputText("\n\nYou sit next to her and pick over the offering.  She reclines, enjoying the sun; judging by her demeanor, she seems more far comfortable around you after you abetted her gluttony earlier.  You could probably get away with plying her for info now, if you wanted.");
	//[Come Here Often?][Her People][Curfew?][No Questions][Leave]
	//spavcebar defaults to [Leave]
	menu();
	addButton(0,"Here Often?",sheilaFriendlyComeHereOften);
	addButton(1,"Her People",sheilaFriendlyHerPeoples);
	addButton(2,"Curfew?",sheilaFriendlyCurfew);
	addButton(3,"No Questions",sheilaFriendlyNoQuestions);
	
	addButton(14,"Leave",camp.returnToCampUseOneHour);
}


//[XP2 - No Questions]
private function sheilaFriendlyNoQuestions():void {
	clearOutput();
	outputText("You decide to hold your tongue and simply mimic her pose as best you can, relaxing on the grass.  The sun is hot but its angle not insistent here, thanks to the shelter from a broad tree nearby.  Its soft rays almost reduce you to sleep over the next forty-five minutes before your companion speaks, rousing you.");
	
	outputText("\n\n\"<i>Didn't take ya for a quiet " + player.mf("bloke","sheila") + " when we met, [name]... but I find you peaceful company.</i>\"");
	outputText("\n\nYou raise your head to look, and see Sheila already on her feet, adjusting her catch to sit across her shoulders for easy carrying.");
	
	outputText("\n\n\"<i>You off, then?</i>\" you ask, trying not to sound too obviously like someone just awakened.");

	outputText("\n\n\"<i>Yeah.</i>\"  Sheila turns and departs with her long-legged gait.");
	//set sheila xp to 3
	flags[kFLAGS.SHEILA_XP] = 3;
	doNext(camp.returnToCampUseOneHour);
}

//[XP2 - Come Here Often?]
private function sheilaFriendlyComeHereOften():void {
	clearOutput();
	outputText("You ask her why she enjoys being on the plains so much.");
	outputText("\n\n\"<i>We-ell...</i>\" she begins, at length.  \"<i>Couldn't say I enjoy it specifically.  I just like bein' out from under the thumb of the village captain.  Not that I disagree with his policies, y'know, except the part where he's a bloody iron-handed control freak.  But other areas are basically off-limits to us anymore.</i>\"");
	outputText("\n\n\"<i>Been to the lake once when I was knee-high to a goblin - before the demons ruined it, mind - and it was beautiful.  Can't go there now, what with all the oozing growths and blue monsters pulling people into a watery grave by their dicks.  Worst of all are those cultists.  I had a mate from a village on the other side of the lake, used to trade us fish and farm milk he'd purified, right?  One day I go out to meet up with him at the swap and only his cook's there; when I ask, she tells me - sober as a rock - that some dickhead in a robe was at their boat as they arrived, and up and claims it in the name of his dickhead religion.  So my mate starts swinging, and the guy just clocks them both with... err, well, with a giant rubber donger... and when he wakes up he's buried to the hilt in the freak's brown freckle.  This is with his sheila trussed and watching, mind.</i>\"");
	
	outputText("\n\n\"<i>Neither can get loose at this point, and the freak rides him to the end of the line.</i>\"  Your companion frowns here, and chews her lip in frustration.  \"<i>As soon as he, ahem, cums, his eyes just... empty.  Like, emptier than a nun's nasty; no sign of a brain at all.  When his girl sees this, she forces herself to her feet and plows into the freak at full steam... knocks him right off and brains him on the pier so he passes out.  She managed to cut her lashings on an old splintered post by the dock and bring her man home after that, but he just sits there in his corner now, talking to himself and stroking his old fella with any objects he can get his hands on, calling each one his 'new and ultimate fetish' - wood, leather straps, family pets, whatever.</i>\"");
	outputText("\n\n\"<i>Anyway, it's like that - too dangerous for me.  Most other places are full of demons... or imps, who are as bad in their own right when they get hold of you: soulless, single-minded rapists.  Not to say we never range out that far, but we're not so daft as to send a single girl out alone with a pat on the back and a 'g'day'.</i>\"  She smiles at her own wit.");
	
	outputText("\n\n\"<i>So, the bush it is for most of us.  The gnolls and satyrs, despite being mean as cat's piss, are mostly harmless when you can run and hide, and they usually beat down the rare imp or demon who wanders out of that weird caravan - once they catch it.</i>\"");
	
	outputText("\n\nExplanation concluded, she folds her hands over her stomach and resumes staring at the clouds.  You join her for a while, then get up and depart.");
	//set sheila xp to 3
	flags[kFLAGS.SHEILA_XP] = 3;
	doNext(camp.returnToCampUseOneHour);
}

//[XP2 - Her People]
private function sheilaFriendlyHerPeoples():void {
	clearOutput();
	outputText("You lie down on the grass yourself, balance the parcel on your stomach, and ask about her people.");
	outputText("\n\n\"<i>Single-minded, aren't ya?</i>\" she asks.  Her eyes close as she takes a deep breath with her nose.  \"<i>I've told you the most important things... all the ones you're gonna get, anyway.  If you think I'm gonna say anything at all that you could use to work backward to my village, don't.</i>\"");
	
	outputText("\n\nNot an unexpected response at this point, and you tell her you're not particularly interested in that knowledge.");
	
	outputText("\n\n\"<i>Hmm.  Dunno whether to be relieved or offended at that.</i>\"  She looks over at you just in time to catch the expression of frustration on your face before you can hide it, and then gives you a playful punch in the arm.  \"<i>Ah, I'm just having you on, you mug!  Let's see... you already know we'd pretty much hate you - not personally, just because you're an outsider - so not much to yabber about there.</i>\"");
	
	outputText("\n\nSomething about that strikes you as funny; you ask her how they avoid trouble when one of their fold takes a shine to a member of another village.  She raises herself to her elbows.");
	
	outputText("\n\n\"<i>Well some villages frown on it, yes, but even our most mule-headed captains recognize that we don't need a bunch of inbred dolts and bleeders running around.  Generally the captains just compare both communities to the maximum capacity of their villages and the lovebirds go to the one that can fit a family.  It's a bit rocky for the one uprooted, but... when you become more like your partner every time you have a naughty, it's not long before the mob accepts you as a distaff or spear counterpart.</i>\"");
	
	outputText("\n\n\"<i>It only happens at orgasm, right?  What if one doesn't?</i>\" you ask.");
	
	outputText("\n\n\"<i>... Not really a problem,</i>\" she replies, considering.  \"<i>If one's frigid, the partner will donate some of their... erm, excess ardor.  If they're both frigid, they're already the perfect couple in that sense.  The non-sexual rough spots always even out once they actually get in the nuddy.  Newlyweds are still newlyweds and dongers still dongers, right?  Bound to.</i>\"");
	//[(pc femininity < 35 or whatever it takes to look manly)
	if (player.femininity < 35) outputText("  She looks absently at your crotch.");
	
	outputText("\n\n\"<i>Er,</i>\" you interject.  \"<i>What about same-sex couples?</i>\"");
	
	outputText("\n\nSheila seems taken unawares by the question and a while passes before the reply comes.  \"<i>Doesn't usually happen.  We're pretty clannish and our captains are always whinging on about the need for every young person to bear children and carry on the family line.  But they can be persuaded to look the other way for two blokes or sheilas who're set on it - provided one is willing to use chemicals to jury-rig a fertile coupling.  Grow a pair, as it were.  If neither is, then they get the cold shoulder!</i>\"  Seeing your look of surprise, she elaborates.  \"<i>Not roughly; we're always short of labor.  The captains set them up in a space of their own, away from the hurly-burly of those in the family persuasion.  Hard to just flick on someone you've watched over all their life.  And they're always welcome to change their minds.</i>\"");
	
	//[(lib<50)]
	if (player.lib < 50) {
		outputText("\n\n\"<i>And,</i>\" you persist, \"<i>what if demons find a village with a transferee?</i>\"");
		outputText("\n\n\"<i>Well... by agreement, policy usually has the poor reffo being shoved out the back door with a tucker-bag and matilda at the first sign of trouble.  Most captains keep long, collapsible escape tunnels in each wing that can be pulled down after someone passes through and the end is thin enough for one bloke to dig his way out; sometimes they even make the new family build or clear one themselves.  Be surprised how many kids were started in a half-finished evac tunnel when the big digger put his little digger to work during a break.</i>\"  Sheila beams a shit-eating grin at you after this comment, and you wonder if she numbers herself among them.");
		outputText("\n\n\"<i>Anyway,</i>\" she resumes, sobering up, \"<i>it's no more precarious than anyone else's situation as long as the demons control the skies and poison the world.</i>\"  She climbs to her feet and picks up the bundle of caught game.  \"<i>You're making me wanna check on my mob, [name].  I'll catch you later.</i>\"");
	}
	//(lib >=50)
	else {
		outputText("\n\nSmiling salaciously, you lean in and ask the question that naturally comes to your mind.");
		outputText("\n\n\"<i>So, what if one of your tribe ends up falling for someone outside of it?  Say, you and I...</i>\"");
		outputText("\n\nSheila turns pink.  \"<i>Pig's arse!  Got tickets on yourself, you ninny?</i>\"");
		outputText("\n\nYou pretend to a serious, impartial air.  \"<i>No, I'm only wondering what would happen if you decide you love me.  Will you come live with me after enough orgasms?</i>\"");
		outputText("\n\nThe girl is now beet red.  \"<i>E-even if I liked you, I wouldn't leave my mob short-handed like that.</i>\"");
		outputText("\n\n\"<i>So we just meet up and have fantastic sex in the outdoors");
		if (player.hasCock()) outputText(", and you raise the kids at home?  Or put them with a nanny");
		outputText("?</i>\"");
		
		outputText("\n\n\"<i>Yeah, I suppose that'll work");
		if (player.hasCock()) outputText(", and I'll turn the kids over to");
		outputText(" - no, I mean, ");
		if (!player.hasCock()) outputText("if I decide");
		else outputText("I'm not ready for");
		outputText(" - er... fuck <b>you!</b></i>\"  This last exclamation comes in response to your pealing laughter.  \"<i>Wanker!</i>\"");
		outputText("\n\nShe gets to her feet, lips pressed tight and face flushed with embarrassment, and leaves without another word, the bundle of game animals hanging over her shoulder... but what's said is said.");
		//set sheila xp to 3
	}
	flags[kFLAGS.SHEILA_XP] = 3;
	doNext(camp.returnToCampUseOneHour);
}

//[XP2 - Curfew?]
private function sheilaFriendlyCurfew():void {
	clearOutput();
	outputText("\"<i>Curfew?</i>\"");
	
	outputText("\n\nShe looks over at you, meeting your gaze with her light eyes.  \"<i>Yeah.  Orders from our cap mandate everyone into the hide from dusk to dawn when the imp gangs are in the skies; camouflage up and all underground.  Can't get in or out until it lifts.</i>\"");
	
	outputText("\n\nYou point out that, even if camouflaged, she should be able to find where it is by landmarks.");
	
	outputText("\n\n\"<i>Well, that's so,</i>\" Sheila answers.  \"<i>Except the entrances are always placed in the middle of uniform ground, even if we have to clear it, and the only landmark is when they're open - a team of three watchers pulls a wooden door with mat of sod into place and lashes it there at night, and watches in shifts until sun-up.  They're rotated out of service and filled after a while, too.  I know for a fact that part of the dig crew's picking up stones in a field right now to have it ready in a few years when the grass grows in; the stones are also used to pack old tunnels and rooms as the colony migrates.  Realm magic can only do so much; how do you picture a trackless grassy nothingscape and get to the exact right one?  How do you find the sod mat when you do?  Spare tunnels and vents are always collapsed or packed with dirt and cleared when needed, and also on the internal patrol route.  Can't open any of them with just little old me even if I find one.  So if I get stuck outside it's a long, sleepless night of drinking with the flies.  Plenty of grub... but no fire to cook with or keep me warm unless I want a cloud of dongs to descend upon me.</i>\"  She smiles sadly at the thought.");
	
	outputText("\n\nHer people must be quite adept at tunneling, which is strange considering how she at least appears to be designed to run in big open spaces.");
	
	outputText("\n\n\"<i>Bet your ass!  Moles haven't got anything on us; we could dig right under you and you'd never know it until the invasion popped up under your butt and moved in,</i>\" the girl answers proudly, when you mention it.  \"<i>You're not wrong, though... we love the surface and sun; there's not one person on the dig crew now who's not dreaming of the day he or she gets to rotate off of it and onto hunting or war crew.  Exigencies, you know?  The first shelters were only half-underground when the demons attacked and survived by the grace of whatever gods are left, but we took the hint.</i>\"  Sheila climbs to her feet, and nods at you.  \"<i>Enough for now... I should really get back.  Catch me later and we can talk more, ok?</i>\"");
	
	//set sheila xp to 3
	flags[kFLAGS.SHEILA_XP] = 3;
	doNext(camp.returnToCampUseOneHour);
}

//XP3: Sexy Time (sheila xp = 3 AND time = 20:00 and demon sheila = 0):
public function sheilaXPThreeSexyTime():void {
	clearOutput();
	outputText("You prowl through the twilit grasslands, lazily looking for anything interesting before the bleak, red moon brings on the night and its restrictions.  Nothing much catches your eye, except for a rounded shape cast in silhouette against the horizon.  Initially taking it for a rock, you're surprised when it shivers at the sound of your approach!  It unbends and raises a head, turning toward you and revealing the flushed face of the bush girl, Sheila.  Her eyes quickly change from terror to relief as they settle on you, and she cries out.  \"<i>[name]!  Oh thank god; please help me!</i>\"");
	outputText("\n\n\"<i>What's wrong?</i>\"");
	
	outputText("\n\nSheila clings to you, wrapping her arms around, and answers, \"<i>I... imp... there was an imp.  He snuck up on me and cast that spell they use, and my body just went soft!  I kicked him and ran, but... but he's still following me!  I've seen him...</i>\"");
	
	//[(lib < 50)]
	if (player.lib < 50) outputText("\n\nAn imp?  Really?  Your incredulity must show on your face, because Sheila squeezes harder.  \"<i>Please, [name]!  Don't leave me alone... I don't want to be ruined by an imp just because he got lucky!</i>\"  You idly lay a hand on her head as you consider.");
	//(else lib >=50)
	else {
		outputText("\n\nHer body went crazy?  Really?  You pull her face up with a hand under her chin.  \"<i>Just one spell, and you lost control?</i>\" you ask.  \"<i>Were you thinking about me all day?</i>\"  Sheila's gaze drifts to the side as she stammers.  Bingo.");
		
		outputText("\n\n\"<i>Um... I... didn't have a chance to let off steam last night, like I usually do,</i>\" she answers, blushing deeply.  Good lord, this girl masturbates every night?  Her eyes dart nervously.");
	}
	outputText("\n\n\"<i>Hard luck,</i>\" you say.  Sheila shivers again, hiding her face.");
	
	outputText("\n\n\"<i>Please, mate,</i>\" she begs, \"<i>help me... I can't run all night, and the colony entrance will be closed by now.  If I can't work this off so I can find a place to hide, I'm done for!  If it's not the imp it'll be something else!</i>\"");
	
	outputText("\n\nYou can think of a couple ways an inclined person might help, in fact...");
	
	//[Sex][Guard Duty][Ditch Her]
	menu();
	addButton(0,"Sex",sheilaXPThreeSexyTimeSex);
	addButton(1,"Guard Duty",sheilaXPThreeSexyTimeGuardDuty);
	addButton(2,"Ditch Her",sheilaXPThreeSexyTimeDitchHer);
}

//[XP3 - Ditch Her]
private function sheilaXPThreeSexyTimeDitchHer():void {
	clearOutput();
	outputText("You shake your head, pulling away from the woman and telling her she'll be fine.  \"<i>No!</i>\" she shrieks.  \"<i>You gotta help me!</i>\"");
	
	outputText("\n\nYou don't have to do any such thing.  It's getting darker and you should head home, so you bid the girl farewell and depart, leaving Sheila calling your name - until the sound suddenly cuts off.");
	
	//set sheila corruption = 100 and demon sheila = 1 and sheilacite = -1
	flags[kFLAGS.SHEILA_CORRUPTION] = 100;
	flags[kFLAGS.SHEILA_DEMON] = 1;
	flags[kFLAGS.SHEILA_CITE] = -1;
	doNext(camp.returnToCampUseOneHour);
}

//[XP3 - Sex]
private function sheilaXPThreeSexyTimeSex():void {
	clearOutput();
	outputText("Sheila's eyes widen with your smile, and she pulls back from you.  \"<i>That's, um...</i>\"");
	
	outputText("\n\nThis tease... your wide smile bends into a frown, and you turn away.  The woman makes a soft, whining noise, and appears to decide.");
	
	outputText("\n\n\"<i>Okay,</i>\" she says meekly, catching your hand.  You let her pull you back.  \"<i>What do you... want to do, mate?</i>\"");
	//set sheila xp = 4, display consensual sex choices available to PC
	menu();
	sheilaXP4Sex(false);
	//da choices from after XP3 sex
	
}

//[XP3 - Sex - any sex scene - Let Her Be]
private function sheilaXPThreeSexyTimePostSexLetHerBe():void {
	clearOutput();
	outputText("Pulling away from you, Sheila gathers her clothing and departs, looking satisfied.  The glance she gives you over her shoulder is even a little warmer than before.");
	//i had snoo-snoo!
	flags[kFLAGS.SHEILA_XP] = 4;
	doNext(camp.returnToCampUseOneHour);
}


//[XP3 - Sex - any sex scene - Stay With Her]
private function shielaXPThreeSexyTimePostSexStay():void {
	clearOutput();
	flags[kFLAGS.SHEILA_XP] = 4;
	outputText("You grab her tail, provoking a curious, but not discouraging, look from the woman who was planning to spend the night alone.  \"<i>What is it, [name]?</i>\"");
	
	outputText("\n\n\"<i>Oh... oh Sheila; let me love you 'til the morning comes!</i>\"");
	
	outputText("\n\nSheila blushes.  \"<i>You dork... you know that's not my real name, right?</i>\"  She lowers herself next you, allowing you to slip your hands around her waist.  \"<i>Do you really want to stay up with me?</i>\"  You answer her with a kiss on the cheek, and she sighs, finally relaxing into your arms.  Sheila snuggles up, then turns and kisses you back.  Breaking the connection only at length, she hums to herself.  \"<i>It's strange... how you feel so comfortable,</i>\" she says, and then halfheartedly adds, \"<i>I must have been lonely, right?</i>\"");
	
	outputText("\n\nYou contrive to look hurt, and she laughs lightly - but there's something behind it.  \"<i>Were you?</i>\" you ask.");
	
	outputText("\n\nShe frowns and her expression clouds; even her ears droop.  Several seconds pass awkwardly before she answers you.  \"<i>Yes.  I was.</i>\"  Sheila shakes her head, then wraps her arms around you.  \"<i>I don't want to remember that... let me pretend that we can stay like this, mate.  At least, for a while.</i>\"");
	
	outputText("\n\nYou lie with the woman, stroking her skin as she sighs and hums softly, for almost an hour.  Just when you feel like you should mention arranging a place to sleep and a watch order, Sheila's fingers begin to roam over you.  \"<i>[name]...</i>\" she whispers, \"<i>I'm...</i>\"");
	
	outputText("\n\n\"<i>Horny again?</i>\" you supply helpfully.  Sheila bites her lip, then nods.");
	
	//--Next--
	menu();
	addButton(0,"Next",shielaXPThreeSexyTimePostSexStayII);
}
//fork
private function shielaXPThreeSexyTimePostSexStayII():void {
	clearOutput();
	//(has cockfit 32)
	if (player.hasCock() && player.cockThatFits(32) >= 0) {
		outputText("Her hand slips down to your groin and, overcoming its trepidation, grabs your [cockFit 32] and begins to pump languidly, slowly stimulating blood back into it.  \"<i>I don't know what's come over me,</i>\" she says, giggling.  \"<i>Maybe I'm just greedy, but... I want you again.</i>\"  She pushes you");
		//[(horse)]
		if (player.isTaur()) outputText(" and you playfully roll");
		outputText(" onto your back; Sheila slips her leg over you");
		if (player.isTaur()) outputText("r own");
		outputText(", positioning herself atop your crotch and guiding your tip to her pussy.  It pokes through the labia slightly, welcomed with warm wetness.  \"<i>Is... this ok, [name]?  Can I?</i>\"");
		
		outputText("\n\nYou hold her gaze for half a minute, saying nothing as you wait to see how wanton the woman has become.  She flushes redder, rolling her hips to stimulate herself on your dick as she awaits your answer, but her restraint breaks and she shudders.  \"<i>S-sorry!  I can't wait anymore!</i>\" Sheila cries, sinking onto your cock jerkily and smothering it in her hot insides.  \"<i>Ah-ah-ah!  You feel so good.</i>\"");
		
		outputText("\n\nShe slumps against you and swivels, stirring herself with your tool.  \"<i>[name], you're awful... making me beg for it,</i>\" Sheila says, kissing you");
		//[(not horse)]
		if (!player.isTaur()) outputText(" just above one " + player.nippleDescript(0));
		else outputText(" on the thigh");
		outputText(".  \"<i>I'm gonna have to punish you for it, you dag.</i>\"  Excusing herself thusly, she sits up and begins to slide up and down your [cockFit 32].  ");
		//[(not horse)]
		if (!player.isTaur()) outputText("Your hands squeeze her hips almost of their own volition, helping her slam down with force, and her head rolls back on her neck.  ");
		outputText("Her ");
		//[(sheila corruption < 30)]
		if (flags[kFLAGS.SHEILA_CORRUPTION] < 30) outputText("little breasts rise and fall with increasing frequency atop her ribcage as her pace picks up and her breaths come short and shallow.");
		else if (flags[kFLAGS.SHEILA_CORRUPTION] > 60) outputText("huge tits jiggle magnificently as she rocks, nearly slapping her in the face as she plunges down and then falling back into place with waves of rippling flesh.");
		else outputText("breasts quiver invitingly as she pumps your cock, but before you can think of grabbing one yourself, both of her hands are squeezing and caressing them, drawing sighs from the woman as she toys with her erect nipples.");
		
		outputText("\n\nSheila struggles against her own impulses, trying to make good on her promise to 'punish' you, but it's a losing battle.  Her hips slide back and forth even as she pulls in and out now, shifting angle to aim the tip of your dick against her vaginal walls when she sinks down on it, and her mouth hangs open constantly.  You grit your teeth, trying to endure the sensations as she uses your tool to scratch every one of her itches, but your lover has no such reserve left.  \"<i>No... n-no,</i>\" Sheila moans, \"<i>too soon!  Oh, too soon!</i>\"");
		
		outputText("\n\nGod, this girl really is easy.  Sheila's vagina convulses around your dick, and she falls forward again as most of her body locks up, covering your ");
		//(horse)
		if (player.isTaur()) outputText("barrel");
		else outputText("chest");
		outputText(" in her soft hair - but her hips keep pumping, incredibly.  ");
		//(pc corr >= 90 or > sheila corruption)
		if (player.cor >= 90 || player.cor > flags[kFLAGS.SHEILA_CORRUPTION]) {
			outputText("  The tight, rippling muscles of her pussy clamp down on you, nearly holding your cock in place as she tries to ride you still but only manages to jerk your dick up and down and squeeze pre-cum from it.  \"<i>S-so full,</i>\" Sheila groans, \"<i>did you just get bigger in me?</i>\"  Her lungs inflate as she sucks in her breath, and her hard nipples push into your " + player.skinFurScales() + ".");
		}
		else if (player.cor < flags[kFLAGS.SHEILA_CORRUPTION]) outputText("  Her pussy clamps down around you, the rippling muscles so tight that she wouldn't even be able to pump if it weren't for the hot river of juice you feel around your tool.  \"<i>A-ah,</i>\" Sheila groans, \"<i>you thrust too!  Rail me silly!</i>\"  She tries to push against you with her hands, to return herself to an upright position, but can barely pull her chest apart from you - her nipples just narrowly recede from the surface of your " + player.skinFurScales() + " as her efforts peak.");
		//(else if magically equal but < 90)
		else outputText("  Her pussy squirts and sucks alternately, trying to find purchase on your cock even as her pumping hips deny it; the sensation drives you wild.  \"<i>[name], your old fella is amazing...</i>\"");
		outputText("  Your dick twitches and swells, as if to fulfill her words, and your pelvis rocks into Sheila's as you begin to ejaculate.  \"<i>No... pull out, or you'll get me pregnant,</i>\" she cries, when ");
		//[(single cox)
		if (player.cockTotal() == 1) outputText("your dick twitches inside her");
		//(multicox)
		else outputText("she spies the first bead of pearly semen exiting");
		if (player.cockTotal() == 2) outputText(" your lonely, unused prick");
		if (player.cockTotal() > 2) outputText(" each of your lonely, unused pricks");
		outputText(".");
		
		outputText("\n\n\"<i>You do it!  You're on top!</i>\" you retort, suppressing your climax for a scant few seconds with willpower alone.");
		
		outputText("\n\nSheila attempts to lift her still-spasming pussy off of your shaft, but wracked by her own orgasm, goes tense again.  \"<i>F-fuck it!  Can't!  Come inside me, [name]!</i>\"  At the invitation, your walls break down, and your penis sprays your held-back semen into your lover");
		//[(multi)]
		if (player.cockTotal() > 1) outputText(", to be joined shortly by a messy external eruption that covers her thighs and belly in blotches of gooey white");
		outputText(".");
		//[(big skeet)
		if (player.cumQ() >= 1000) outputText("  It rolls out of you in waves, packing Sheila's cunt until she fills to capacity and the excess is forced out, sliming your own crotch.");
		
		//reduce lust/lib and reset hours since cum; if sheila corruption >= 90 and pc corruption >= 90, redirect to demonization; else continue
		player.orgasm();
		dynStats("lib", -2);
		if (player.cor >= 90 && sheilaCorruption() >= 90) {
			menu();
			addButton(0,"Next",sheilaGoesDemon);
			return;
		}
		
		outputText("\n\nFinally spending yourselves, Sheila slides forward and lets your dick flop free; a warm, wet patch spreads on your stomach as her pussy drools out some of your deposit.  She kisses you repeatedly, fairly glowing with satisfaction, until she exhausts her affection and rolls off of you.  The two of you lie there again, peaceful for the most part - though as she nervously recounts what just happened in her head, her hands keep darting to her midriff.");
		//[(corr < 30)]
		if (player.cor < 30) outputText("\n\n\"<i>Relax,</i>\" you say, capturing one and squeezing it.  She looks over at you, her amber eyes measuring you carefully, and at length rewards you with a smile and a shy nod.");
		//sheilapreg check, reset hours since cum; if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption
		sheilaPreg();
		sheilaCorruptionUpdate();
		/*if (player.cor > sheilaCorruption()) {
			dynStats("cor", -5);
			sheilaCorruption(5);
		}
		else if (player.cor < sheilaCorruption()) {
			dynStats("cor", 5);
			sheilaCorruption(-5);
		}*/
	}
	//(if no cockFit 32 and yes vag)
	else if (player.hasVagina()) {
		outputText("Her hand slips to your groin and, overcoming its trepidation, slides two fingers into your [vagina], stimulating you and forcing hardness back into your [clit].  \"<i>I don't know what's the matter with me,</i>\" Sheila says, nervously.  \"<i>I'm not usually aroused by " + player.mf("hermaphrodites unless they have a donger that'll fit","girls") + ", but you're different.  I wonder what this feeling is...</i>\"");
		
		outputText("\n\n\"<i>Love, of course,</i>\" you answer, smiling smugly despite the pleasure tightening your body.");
		
		outputText("\n\nSheila's hand stops and she looks upset for a moment, as if she were worried that might actually be the case.  \"<i>Do you really think so, mate?</i>\"");
		
		outputText("\n\nIrritated, you pull away from her and sit up, then push the timorous woman onto her back.  \"<i>Don't dwell on it so much.  Be happy you have someone who wants you as well.</i>\"  Spreading her legs, you expose her slight, smooth labia and tickle them with a finger, opening them gently.  Sheila gasps, tensing and relaxing in the waves of sensation, and her pussy begins to drool clear lubricant onto your finger.  \"<i>If you can get into it like this, what's the problem?</i>\"");
		
		outputText("\n\n\"<i>R-right,</i>\" she pants, as she releases another trickle of fluid.  \"<i>Ohh god... fuck me.  I don't care how, just fuck me, please!</i>\"");
		
		outputText("\n\nSmiling, you kiss her softly on the inner thigh, then withdraw your hand.  ");
		//[(horse)]
		if (player.isTaur()) outputText("You turn around and straddle a leg, squatting to bring your [vagina] atop her crotch.  \"<i>Push up,</i>\" you order, and Sheila obeys eagerly, twisting her body to connect her excited pussy with yours.");
		//(else if naga)
		else if (player.isNaga()) outputText("You slide it under her and lift gently; Sheila plays along with a disquieted expression, rolling over and raising her pussy into the air, and you press your own against her butt as your tail slides between her legs.  \"<i>See, you just need to be more... flexible,</i>\" you quip.");
		//(else if not horse and not naga)
		else outputText("You straddle her legs with your own, pressing her pussy into yours; Sheila gasps as the hot flesh connects and you tentatively rock your hips, dragging your lower lips across.");
		
		outputText("\n\n\"<i>Mmmh,</i>\" she moans, smearing her crotch against you.  The woman rubs harder, almost unbalancing you, as she works her body closer to yours.  \"<i>I'd feel better if you could squeeze my breasts, mate... it would make me rapt if you touched them");
		//(sheila corruption > 30)
		if (sheilaCorruption() < 30) outputText(" even though they're small and humble");
		//(else sheila corruption > 60)
		else if (sheilaCorruption() > 60) outputText("; I worry that they're getting too mountainous");
		outputText(".</i>\"  A hand drifts up to her nipple, pinching it as her mouth hangs open.  She rolls it in her palm, then presses the breast against her ribcage, and her shiver of arousal transmits to you through");
		if (player.isNaga()) {
			outputText(" her taut buttcheek");
			outputText(".");
		
			outputText("\n\nYou smile at her insecurity, and slide your hands under her chest to cup her tits.  \"<i>Do you like having your breasts touched?  Does it make you feel womanly?</i>\"  Sheila answers by writhing in your grip, moaning again and pushing her ass against your [vagina].");
		
			outputText("\n\n\"<i>Y-yes,</i>\" she admits, slipping her hands over yours and forcing you to press down as she squeezes your juice-lubed tail between her thighs.");
		
			outputText("\n\nYou intensify your own rocking, scraping your cunt against her flushed cheek.");
		}
		else {
			outputText(" her heated, slippery vagina.");
		
			outputText("\n\n\"<i>Later,</i>\" you reply, mashing your own into it, \"<i>I'll play with them as much as you like.  Do you shiver when I touch them?  Does it make you feel feminine?</i>\"");
			
			outputText("\n\n\"<i>Y-yes,</i>\" she admits, tweaking her nipple again, and her pussy quakes against yours.");
			
			outputText("\n\nYou intensify your own rocking, scraping your cunt against her labia, which are now sucking openly at yours, trying to draw you inside her.");
		}
		outputText("\n\n\"<i>[name],</i>\" Sheila pants, \"<i>I'm gonna come soon if you keep doing that!</i>\"");
		outputText("\n\nIn answer, you thrust even harder against her, crossing her netherlips furiously with your");
		//[(naga) 
		if (player.isNaga()) outputText(" tail, drawing it up the hot opening and coiling it so you can return the warm, lube-slicked length for another pass even as you hump her butt.");
		else outputText(" cunt, grinding her like a sex toy in search of your own climax.");
		outputText("  \"<i>Do it!</i>\" you order, anxious to feel her pussy convulsing against you, anxious to feel your own squeezing her.  \"<i>Come with your lesbian lover!</i>\"");
		
		outputText("\n\nSheila's skin turns ruddy red in embarrassment as her body locks up, and her climax starts.  \"<i>Oh god... oh... I wish you'd kiss me!</i>\"");
		//[(pc corr >= 90 or > sheila corruption)
		if (player.cor >= 90 || player.cor > sheilaCorruption()) {
			outputText("  Her vagina doesn't wait for romance, spasming and opening wide to try to suck you in, pulling at your ");
			if (player.isNaga()) outputText("scales");
			else outputText("pussy");
			outputText(" until you can take no more of the heat and come as well.");
			//[(naga)]
			if (player.isNaga()) outputText("  Her breasts swell in your hands as she sucks in her breath sharply, feeling your pussy drool its juice onto her ass.");
		}
		//(else if PC corr < sheila corruption)
		else if (player.cor < sheilaCorruption()) {
			outputText("  Her vagina doesn't wait for symbolism, dumping a wave of orgasm that splashes almost audibly against you.  Your pussy answers with your own climax, and begins wetting the woman underneath");
			if (player.isNaga()) outputText("; it feels like her breasts are pulling away from you as she tries to push her ass further into your quivering quim");
			outputText(".");
		}
		else {
			outputText("  Her vagina drools and spasms, not interested in gestures so much as release, and coats ");
			if (player.isNaga()) outputText("your tail");
			else outputText("your own");
			outputText(" with a fresh coat of her hot fluids which trigger the expected response from you.");
		}
		//(if cock)
		if (player.hasCock()) {
			outputText("  Your neglected ");
			if (player.cockTotal() == 1) outputText("prick quakes and spurts");
			else outputText("pricks quake and spurt");
			outputText(" weakly, drooling semen that pools on her skin.");
		}
		//[(not horse)
		if (!player.isTaur()) outputText("\n\nLeaning down as your cunt works through your climax and pulling Sheila's head up to yours, you kiss her softly on the lips.  She draws you in with an eagerness mirroring her pussy's, probing your mouth with her little pink tongue, and holds you lip-locked like that until her orgasm ends and she slumps in your arms.  You lower her to the ground as your last strokes fire, then fall beside her.");
		//(else if horse)
		else outputText("\n\nA good kiss sounds nice right now, but not as nice as rubbing your throbbing, hot cunt against your lover's, prolonging your body-shaking orgasm for as long as possible, and you answer her plea with renewed thrusting, provoking a gasp and another quiver from the limp girl.  Your body shivers as your climax intensifies, and it feels like your crotch is on fire as you squeeze and squirt on her.  Finally, spent, you lower yourself to the ground.");
		
		//reduce lust/lib and reset hours since cum; if sheila corruption >= 90 and PC corr >= 90 go to demonization here, else continue
		player.orgasm();
		dynStats("lib", -2);
		if (sheilaCorruption() >= 90 && player.cor >= 90) {
			menu();
			addButton(0,"Next",sheilaGoesDemon);
			return;
		}
		outputText("\n\nSheila cuddles up to you, slipping an arm over your body, and you lie like that for a while before she speaks.  \"<i>[name]... ");
		//(not horse)
		if (!player.isTaur()) outputText("maybe I do love you...</i>\"\n\nYou turn over and look in her eyes and she abandons the thought.  \"<i>Only having you on,</i>\" she says, smiling and caressing your cheek.");
		else {
			outputText("you didn't kiss me.</i>\"\n\nYou turn over and look into her eyes.  \"<i>Of course not,</i>\" you answer.  \"<i>I'm a horse.</i>\"  You grimace and lift  your lips away from your teeth, giving her your best impression of a horse's gummy smile, and she cracks up.");
			outputText("\n\n\"<i>God dammit, stop!</i>\" Sheila gasps, almost crying in laughter as you push your face closer to hers.  You relent and close your mouth, then kiss her on the cheek as she calms down.");
		}
		//if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption
		sheilaCorruptionUpdate();
		/*
		if (player.cor > sheilaCorruption()) {
			dynStats("cor", -5);
			sheilaCorruption(5);
		}
		else if (player.cor < sheilaCorruption()) {
			dynStats("cor", 5);
			sheilaCorruption(-5);
		}*/
	}
	//(else if no cockFit 32 and no vag)
	else {
		outputText("Her hand lowers to her crotch and slides her middle finger into her pussy.  \"<i>I don't know what's wrong with me,</i>\" Sheila says, nervously.  \"<i>I'm not even sure why I get hot when I think of you... you don't have anything I can use.</i>\"");
		
		outputText("\n\nYou smile at the admission");
		if (player.hasCock()) outputText(", stroking your oversized tool despite her dismissal");
		outputText(".  \"<i>But you do?</i>\"");
		
		outputText("\n\nSheila reddens a bit and nods again, still frigging herself.  \"<i>But I feel like an arse, ogling you without reason or sense; like I'm a goblin or something, getting wet for anyone she meets.</i>\"");
		
		outputText("\n\n\"<i>And yet,</i>\" you reply.  Emphasizing your unspoken point, you grab Sheila's hand and pull it out of her crotch, popping the finger into your mouth.  Sheila shivers as you roll it on your tongue, and her pussy drools a drop of lube.  Smiling, you substitute your own hand for hers, penetrating the slick hole.  The woman's free hand quickly goes to yours, but simply rests atop it, caressing you and offering no resistance as you draw your fingers in and out of her.  Her mouth forms the word 'no', but the only sound that comes out is a soft sigh.");
		
		//[(coc, new PG)
		if (player.hasCock()) {
			outputText("\n\nSheila pulls her finger from your mouth as she shifts closer to you, giving you yet more leverage over her vagina.  The hand ");
			//(mans)
			if (!player.isTaur()) outputText("falls into your lap");
			//(horse)
			else outputText("drifts between your legs");
			outputText(", then crawls its way to your [cock].  She begins stroking it, torpidly at first, but with increasing excitement as a drop of pre-cum slides down and wets her palm.  \"<i>What's wrong, goblin girl?</i>\" you ask.  \"<i>Gotta get some sperm no matter what?</i>\"");
		
			outputText("Sheila winces as your probing fingers send a shudder through her.  \"<i>Shut up, you tosser,</i>\" she retorts, yanking on your dick slightly harder in her irritation.");
		}
		//(new PG)
		outputText("\n\nYou work her soaked pussy over, plunging fingers in deep with little regard for anything but hitting nerves, and caressing her small, erect clitoris with your palm as you go.  At every touch, you whisper to her what a naughty girl she is; she responds by flicking her ear at you, but you reverse by blowing and nibbling on the long auricles, sending shivers through her body.  \"<i>Oh, my... seems this wanton woman has sensitive ears, doesn't it?</i>\" you tease, drawing out the syllables to hum into her skin.  Soon Sheila's melting against you, crying out her climax into your shoulder.");
		//[(pc corr >= 90 or > sheila corruption)]
		if (player.cor >= 90 || player.cor > sheilaCorruption()) outputText("  Her vagina heats up, squeezing your fingers so hard that you nearly can't pull out to rub her again, and you have a clear view of her breasts swelling up - arguable proof of your prowess, considering what she told you earlier.  Her people must be terrible at faking orgasm.");
		//(pc corr < sheila corruption)
		else if (player.cor < sheilaCorruption()) outputText("  Her vagina gushes with clear fluid, filling the bowl made by your hand with warmth, and you think you can see her breasts tightening up slightly as her back arches, though it's hard to be sure with how she's shaking.");
		else outputText("  Her pussy quivers around you, and you draw the fingers out and pop them into Sheila's mouth.  The woman sucks on them greedily, and you raise an eyebrow at her.  She blushes again, but it's evidently not the first time she's done the same thing!");
		
		//if sheila corruption >= 90 and PC corruption >= 90, go to demonization, else continue
		if (sheilaCorruption() >= 90 && player.cor >= 90) {
			menu();
			addButton(0,"Next",sheilaGoesDemon);
			return;
		}
		
		//[(cocks)
		if (player.hasCock()) {
			outputText("\n\nYou reclaim your hand and rest it atop Sheila's, forcing the climax-addled woman to stroke again; she gasps apologetically and resumes with jerky, weak motions.  Irritated and almost at your peak, you up the pace, getting your hips into it until you're practically fucking her palm.  You tilt your pelvis toward Sheila, angling your prick at her face as you prepare to blow your load; she recoils slightly at first, but guiltily moves her mouth to your [cockHead], kissing the tip and playing her tongue over the hole.  The tingle of nerves pushes you over the brink, and you grab her head and hold it as you squirt seed past her lips.");
			//[(big skeet)
			if (player.cumQ() > 1000) outputText("  Her mouth fills quickly, and she writhes in your grip, managing to turn her head.  \"<i>Oh god, no way!</i>\" she coughs, spitting up enough semen to coat her chin as your ongoing orgasm spatters against her cheek.");
			//[(mega skeet)
			if (player.cumQ() >= 2000) outputText("  Not satisfied with that alone, you turn her head the other way for your finish, ejaculating on the rest of her face and completing her gooey, white beard as she squirms.");
			//[(multicock)
			if (player.cockTotal() > 1) outputText("  The other strokes not coming from this cock do their part to decorate your lover as well, turning her hair into a slimy mess.");
			outputText("  She escapes from your hand as you spend yourself, leaning away and gagging up seed onto the dry grass.");
		}
		outputText("\n\nThe woman falls weakly backward");
		//(cock.length > 0)
		if (player.hasCock()) outputText(", her face still covered in globby white smears");
		outputText(".  \"<i>Fuck...</i>\" she groans.  \"<i>You're a jerk, [name].");
		//[(cock.length > 0)
		if (player.hasCock()) outputText("  I can't believe you called me a goblin, you arsehole.");
		outputText("</i>\"");
		
		outputText("\n\nYou ");
		//[(cock.length > 0)
		if (player.hasCock()) outputText("can't believe how much she acts like one sometimes... but you ");
		outputText("just laugh and tug her ear; she flicks it and pulls away from you, backhanding you softly in the gut.  \"<i>Knock it off!</i>\"");
		
		outputText("\n\n\"<i>Are you really so worried about it?</i>\" you ask.  No answer comes");
		//[(cock.length > 0)
		if (player.hasCock()) outputText(", even after Sheila finishes wiping her face clean and stares at you");
		outputText(", so you just content yourself with lying next to the woman for a while.");
		
		//reset hours since cum and reduce lust/lib since cum if cock, else add mild lib-based lust damage if no cock; if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption
		if (player.hasCock())
		{
			player.orgasm();
			dynStats("lib", -2);
		}
		else dynStats("lus", player.lib/4);
		sheilaCorruptionUpdate();
		/*
		if (player.cor > sheilaCorruption()) {
			dynStats("cor", -5);
			sheilaCorruption(5);
		}
		else if (player.cor < sheilaCorruption()) {
			dynStats("cor", 5);
			sheilaCorruption(-5);
		}*/
	}
	//end of fucking fork
	outputText("\n\n\"<i>Erm...</i>\" Sheila begins, breaking the renewed silence.  \"<i>We should probably find a place to camp out.  I saw a little cave under a rock outcrop at the border to the mountains as I was running.  Didn't really consider it when I was alone - nowhere to go if I zone out and get cornered - but with two of us to watch in shifts, it'd be perfect.  Will you... stay with me?</i>\"");
	
	outputText("\n\nYou grin, having already made your decision some time ago, but play with her a bit.  \"<i>Maybe I could, maybe I couldn't.  After all, you don't even use your real name around me...</i>\"");
	
	outputText("\n\nSheila colors again.  \"<i>I don't use it around anyone!  O-okay... just for tonight, but promise you won't tease me!  Promise!</i>\"  She looks you in the eye imploringly, then continues.  \"<i>I was named after a famous bloke, so it's a little too silly for me.  But if you want, you can call me... Harriet.</i>\"");
	outputText("\n\nYou nod sagely and get up to dress.  Sheila, or Harriet, does the same, shimmying into her panties and shorts quickly and pulling her top on.  Finished, she drags you off to the night's lodgings anxiously, hat in hand and body language more closely resembling a giddy girl's on her first date than a grizzled, solitary hunter's.");
	//advance time to 6:00, gain 3 hours rest
	player.changeFatigue(-20);
	HPChange(player.maxHP()/2,false);
	if (model.time.hours > 6) model.time.days++;
	model.time.hours = 6;
	statScreenRefresh();
	doNext(playerMenu);
}

//[XP3 - Guard Duty]
private function sheilaXPThreeSexyTimeGuardDuty():void {
	clearOutput();
	outputText("You fold your arms and frown at Sheila, but consent to help.  She brightens, then looks confused when you make no further motion.  \"<i>So...</i>\" she begins, \"<i>what should I do?</i>\"");
	
	outputText("\n\n\"<i>Whatever you think best,</i>\" you answer, turning your back to her.  \"<i>I'll watch out for trouble; </i>you<i> decide how to get out of this.</i>\"");
	
	outputText("\n\nSheila releases you and turns around as well, folding her legs under herself and sitting on her knees to consider.  True to your word, you scan the horizon and sky for anything that could pose a threat");
	//[(PC level >=8)
	if (player.level >= 8) outputText(" - which, you suppose, must include imps even though they're so far beneath you they might as well be underground");
	outputText(".  You stand there for so long that you nearly slip into a daydream, and are only roused by the noise of a leather belt being carefully unfastened.  Focused again, you can hear Sheila's ragged breathing and her thighs rubbing together, then a hand sliding against skin and fabric... seems like she's made her decision.");
	
	//[(lib<40)
	if (player.lib < 40) {
		outputText("\n\nWell, that's none of your concern.  Although you wouldn't really consider these erotic surroundings, the choice does make a certain kind of sense, based on what she's told you.  You continue studiously monitoring the plains, trying to ignore the wet sounds of female masturbation.  The scrapes of cloth intensify as well, as another hand is slipped into something else - the new noises seem to coincide with Sheila's breaths, as each sound is followed by the soft 'haahh' of her exhalation.");
	
		outputText("\n\nThis continues for several minutes, the wet sounds gradually drowning out all the others, increasing in tempo and volume, until suddenly they stop.  \"<i>Nnnn...</i>\" Sheila moans, quietly.  \"<i>Oh god, [name], you're amazing!</i>\"");
		
		outputText("\n\nOk, that's too much.  You turn back; Sheila's seated with shorts pulled down slightly and legs spread, one hand in her crotch and another roughly groping her breast, and is staring over her shoulder at you with an expression of total horror.  \"<i>Did you-</i>\" you begin, only to be cut off as she shakes her head violently.");
		
		outputText("\n\n\"<i>No!</i>\" she yelps, completely failing to regulate her voice and shaking as her fitful orgasm soaks through her panties.  \"<i>O-of course not!</i>\"");
		
		outputText("\n\nQuirking an eyebrow, you turn away again and allow the queer girl to finish and dress; she furtively gets to her feet and buckles her belt, then clears her throat loudly.");
	}
	//(else lib >= 40)
	else {
		outputText("\n\nInteresting choice... you look over your shoulder at her.  Sheila's sitting with her shorts pulled down slightly and legs spread and, as you expected, has slid a hand into her panties.  While you watch, the other one ducks under her shirt, knuckles cresting visibly as she begins to squeeze and knead her breast.  She rubs vigorously, moaning softly whenever she grinds her erect nipple against her palm, and her other elbow jigs in the air as she works two fingers into and out of her pussy.  On one particularly deep plunge, her head rolls back and her eyes open - and she freezes as your gazes meet.");
		
		outputText("\n\nThe two of you stare at each other for a while, Sheila slowly getting redder and redder, until you cough and break the silence.  \"<i>You might be more comfortable if you pulled your panties down a bit,</i>\" you suggest.");
		
		outputText("\n\nThat seems to tear down a dam in the woman; her eyes widen and she nods, sitting up again.  You circle around to her front side, and she bites her lip and looks away guiltily - but still tugs the wet cloth free of her entrance, revealing her smooth labia.  A strand of moisture connects them to the panties briefly, but falls away when she reinserts her fingers, spreading herself and searching out her entrance once more.  \"<i>Is... is this what you meant?</i>\" she asks, shyly.");
		
		outputText("\n\nYou smile approvingly.  \"<i>That looks just about right.  Perfect, almost.  It's only missing one thing.</i>\"  Sheila stares at you without understanding, fingering herself only halfheartedly while she tries to work out your meaning, until you ");
		//[(cock.length > 0)
		if (player.hasCock()) outputText("shift your pelvis forward");
		//(cock.length == 0)
		else outputText("stick out your tongue playfully");
		outputText(".  The girl giggles at that, relaxing and finally letting herself get into the masturbation.");
		
		outputText("\n\n\"<i>You're right, mate,</i>\" she says, with a sigh and a shiver as she begins massaging her breast once more.  \"<i>I'd love to get one of those soon, but my supplier is holding out on me.</i>\"  Sheila colors a bit as she realizes what she just implied, but shakes it off and ups the pace again, arching her back as her fingers search out the best spots inside her.  \"<i>Ahh, ahh, god... gonna come soon, [name]!</i>\"");
		
		outputText("\n\nShe closes her eyes and tightens up, drawing her legs in to hold her hand in place and, sadly, blocking your view of her quaking pussy with a pair of long, auburn-furred feet.  Her body practically folds up as she orgasms, until she's tucked into a fetal position with her face buried in her knees, screaming her joy into her skin, ears twitching wildly.  Sheila exhausts herself after a minute, and uncurls, then dutifully begins re-dressing with a smile, darting glances at you.");
	}
	//merge
	outputText("\n\n\"<i>[name],</i>\" Sheila begins, leaving the thought unfinished.  She puts out a hand, and you absently reach out to shake it, until you notice the glistening wetness at the tips of her fingers.  Sheila looks down, following your gaze, then starts and wipes the liquid hurriedly on her shorts.  \"<i>... can't believe I did that,</i>\" she mumbles.  \"<i>Um, I'll be alright now.  Bye.</i>\"");
	
	outputText("\n\nYou smile and offer to stay with her a bit longer, but Sheila turns beet-red and shakes her head, departing without another word.");
	
	//set sheila xp = 4, small lib-based lust damage if lib < 40, or large if lib >= 40; advance time 1 hr
	flags[kFLAGS.SHEILA_XP] = 4;
	if (player.lib < 40) dynStats("lus", 5);
	else dynStats("lus", 15);
	doNext(camp.returnToCampUseOneHour);
}

//XP4: Fancy meeting you here (sheila xp >= 4 and demon sheila = 0):
private function fuckBuddySheilaMeeting():void {
	clearOutput();
	outputText("\"<i>Hey...</i>\"");
	outputText("\n\nThe soft voice, coming from a shrub, halts your progress.  You peer around it; Sheila is sitting with her hat in her lap, and looking up at you.  She smiles shyly when you make eye contact.  \"<i>Fancy meeting you here,</i>\" she says.");
	outputText("\n\nYou plunk down beside her and ask how it's going.");
	outputText("\n\n\"<i>Good,</i>\" she answers.  \"<i>Finished hunting already, but I was just hanging around in case - ah, I mean I was thinking...</i>\"  She looks guilty for a moment, then comes clean.  \"<i>... I missed you.</i>\"");
	
	outputText("\n\n\"<i>No worries,</i>\" you say, borrowing her expression.  She grins and puts her head against your arm, closing her eyes.");
	
	outputText("\n\nSheila rests like that for a minute before speaking again.  \"<i>So... want to hang out?  Or do something?</i>\"");
	outputText("\n\nYou note that her breasts are " + sheilaCup() + " right now...");
	
	//[Chat][Sex][Just Hang][Maybe Later]
	menu();
	addButton(0,"Chat",fuckBuddySheilaMeetingChat);
	addButton(1,"Sex",sheilaXP4Sex, true);
	addButton(2,"Just Hang",fuckBuddySheilaMeetingJustHangOut);
	addButton(3,"Maybe Later",fuckBuddySheilaMeetingMaybeLater);
	
}

//[XP4 - Maybe Later]
//should be default spacebar choice
private function fuckBuddySheilaMeetingMaybeLater():void {
	clearOutput();
	outputText("You tell her you haven't the time right now, but squeeze her knee as you get up again.");
	
	outputText("\n\n\"<i>Okay,</i>\" she agrees, subdued.  \"<i>Maybe later.</i>\"");
	//wow, it's fucking nothing!
	doNext(camp.returnToCampUseOneHour);
}

//[XP4 - Just Hang]
private function fuckBuddySheilaMeetingJustHangOut():void {
	clearOutput();
	outputText("In answer, you reach down to pinch her butt and then ");
	//[(not horse or drider)
	if (!player.isTaur() && !player.isDrider()) outputText("scoot your own forward");
	else outputText("fold your legs under you");
	outputText(" to lay in the bush's shade.");
	
	outputText("\n\n\"<i>Ratbag...</i>\" she says, without venom.  Sliding down next to you, she presses herself against your side.  \"<i>Wake me up if I fall asleep, okay?  Promise!</i>\"");
	
	outputText("\n\nYou relax, letting your mind wander as cloud patterns drift placidly in and out of your field of vision, until you're stirred to get moving again.  A glance at Sheila confirms that the woman has indeed fallen asleep, trusting you to keep her safe.  You nudge her in the shoulder and she starts.");
	
	outputText("\n\n\"<i>Wh- oh, right,</i>\" she says, blinking.  \"<i>Going already?  Well... I guess I should too.</i>\"");
	
	outputText("\n\nShe stands up and retrieves her catch from under the bush.  \"<i>Thanks for the company.  Sorry to zonk out on you but I haven't been sleeping much; so much work to do at all hours.</i>\"");
	
	outputText("\n\n\"<i>Poor girl,</i>\" you answer.  She smirks and walks off, then turns and blows you a kiss.");
	outputText("\n\n\"<i>Maybe I'll be up for some fun when you catch me next time,</i>\" she declares.  \"<i>Stay safe.</i>\"");
	//minus small lust and corruption
	dynStats("lus", -10, "cor", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[XP4 - Chat]
private function fuckBuddySheilaMeetingChat():void {
	clearOutput();
	outputText("\"<i>Feeling talkative?</i>\" Sheila asks.  \"<i>Have at yer.</i>\"");
	
	outputText("\n\nWhat do you bring up?");
	
	//[Family&Friends][Old Loves][Why Hide?][Live With Me][Kids(only if joeycount > 0)]
	menu();
	addButton(0,"Fam'N Friends",fuckBuddySheilaMeetingChatFamilyAndFriends);
	addButton(1,"Old Loves",fuckBuddySheilaMeetingChatOldLoves);
	addButton(2,"Why Hide?",fuckBuddySheilaMeetingChatWhyHide);
	addButton(3,"LiveWithMe",fuckBuddySheilaMeetingChatLiveWithMe);
	if (flags[kFLAGS.SHEILA_JOEYS] > 0) addButton(4,"Kids", fuckBuddySheilaMeetingChatKids);
}

//[XP4 - Chat - Family&Friends]
private function fuckBuddySheilaMeetingChatFamilyAndFriends():void {
	clearOutput();
	outputText("\"<i>Them?  They're doing fine.</i>\"  Sheila stares at you obtusely, trying to will you into changing the subject; you stare right back.  She sighs.  \"<i>No go, huh?</i>\"");
	
	outputText("\n\n\"<i>It's the least you could do to tell me a bit about them, seeing as we may never meet,</i>\" you remind her, gently.");
	
	outputText("\n\n\"<i>Yeah, yeah.  Well... I dunno, they're pretty normal, I guess.  My dad's a good bloke, puts in his time around the colony like anyone.  He's hardworking as a digger and I always had him pegged as a proud, strong soldier - though I guess that could just be his little girl's eyes.</i>\"  She smiles wanly.  \"<i>I'm a better trapper than he is though; he's too restless.  Scares off the game when you move around so much.</i>\"");
	
	outputText("\n\n\"<i>And your mom?</i>\" you prompt.");
	
	outputText("\n\nSheila frowns.  \"<i>My mum is... kind of a big deal.  She's a nurse, which means she's exempt from regular duty and is only in the reserves.  She takes care of kids in the creche all the time.</i>\"");
	outputText("\n\nThat sounds nice enough... curious that Sheila doesn't seem to think so.");
	
	outputText("\n\n\"<i>Nurses have to help maintain the nursery, mate.  They're encouraged to take chemicals to ensure they're always heavily lactating.  Conventionally, they're also expected to make babies - a nurse that doesn't have children is at the bottom of the social ladder as far as respect goes, so all of them are also on fertility drugs, or having a root at all hours, or both.  Most days the first thing dad did when he got home was take mum into an empty wing for ten minutes... though when the nurseries were full, it was us who'd have to vacate so he could use the main room.</i>\"  Sheila looks at you glumly.  \"<i>I used to be secretly so rapt when he was in the military crew.  He'd come home too tired from training to shag, so I'd actually get to spend uninterrupted time with him, reading him the daily bulletins or washing his clothes in a little basin while he told me stories from his platoon.  On the other duties it was always 'Hattie, run 'round and catch your brothers and sisters, and start the cooking so your mum and I can have some alone time.'</i>\"");
	outputText("\n\nYou crack a smile at that nickname, and Sheila reddens a bit before continuing.  \"<i>Nobody ever calls me that anymore but him.  Anyway, my mum being what she is, our captain thinks a lot of our family.  Most of my sisters are in training under her to follow in her footsteps, never mind how few openings there are... though the older ones are training under their blokes, instead.  Nurses' daughters pair off early, since men like it when a gal wants them all the time - maybe you don't believe me?</i>\"");
	outputText("\n\n\"<i>So you have a lot of siblings around?</i>\" you ask, rolling your eyes.");
	outputText("\n\n\"<i>Probably,</i>\" Sheila answers, laconically.  Only when you fix her with another stare does she bother to explain.  \"<i>It's a nursery, you know?  Mum takes in kids from the whole colony so the oldies can do their jobs without worrying; everyone's your brother.  I'm the eldest of her actual tads, but there's likely one or two in about every year under me.  We sprout pretty fast once we get planted; probably be a fourth generation soon.  One of my sister's kids called me 'old Auntie Sheila' the other day and I nearly kicked him.  Like I'm some maiden spinster.</i>\"");
	
	outputText("\n\nWatching her jaw work angrily, you decide on a change of subject.  \"<i>What about your friends?</i>\"");
	
	outputText("\n\n\"<i>Guess you'd call them work buddies.  I'm the girl in the group, so eventually I got upgraded from 'the sheila' to just 'Sheila'.  Like I said... wankers.  They're mostly blokes who glued themselves to me when they heard who my mum was, probably hoping I'd take after her eventually.  Too bad for them, I always wanted to be like my dad instead.</i>\"  She grins wickedly.");
	
	//[(lib>=50)]
	if (player.lib >= 50) {
		outputText("\n\n\"<i>Oh,</i>\" you say, leaning in conspiratorially, \"<i>not so interested in sex?</i>\"");
		outputText("\n\n\"<i>We need food and shelter, [name].  My job is important.  It's no good to have thirty kids and only one adult on her feet doing work.  I wish my mum got that... it's not that I don't want to find someone, it's that I don't want to be another lazy bludger who sits at home all day with a babe at her breast and her legs open, depending on her man for everything.</i>\"");
		
		outputText("\n\nTrue as that may be, she didn't answer the question; you draw closer, raising an eyebrow.");
		
		outputText("\n\nSheila blushes.  \"<i>I... am as interested as any girl.  Maybe more since it was such a normal, everyday thing in our family.  Dad was always hanging onto mum, like her breasts and hips were where his hands belonged.  My sisters definitely take to it; you wouldn't believe how they act.  Half of them are still wearing their old shirts even though they've started on lactation drugs and their tits have swelled up four sizes.  Or stealing mine when they rip theirs at the seams.</i>\"");
		
		outputText("\n\nThat's a pleasant mental picture, but you know a distraction when you hear it.  \"<i>We're not talking about your sisters...</i>\"");
		
		outputText("\n\nThe woman squirms as you slip a hand around her waist.  \"<i>Dammit, [name]... what do you want me to say?  That I'd spend all bloody day hiding in the tall grass with you if I didn't have work to do?  I'd think that would be obvious by the way I put up with your crap, you bastard.</i>\"");
		
		outputText("\n\nYou nudge up her shirt and tease her side with a finger, smiling quietly; she leans her head against you for a while, closing her eyes as you trace patterns on her skin, but eventually brushes your arm away to pick up her catch.  \"<i>I </i>do<i> have work to do, though.  So you'll just have to perve by yourself for a while.  I'll see you later.</i>\"");
		
		outputText("\n\n\"<i>Okay, see you soon,</i>\" you reply, to her departing back.  \"<i>... Auntie.</i>\"");
		
		outputText("\n\nSheila's neck burns and her ears twitch as she walks away, stiff with irritation.");
	}
	//(else lib <50)
	else {
		outputText("\n\n\"<i>What,</i>\" you say, \"<i>all dudes and no girlfriends?</i>\"");
		
		outputText("\n\nSheila looks morose.  \"<i>Gals my age are still hunting for families and don't want to hang around me - daughter of the sex queen, going to wrap every man around her finger.  The only female friends I have are younger girls I've helped take care of or older aunts.</i>\"  She turns her head away.  \"<i>Not to say I'm popular with most blokes either, since they take it poorly when they find out my reputation is unfounded.  They don't stick around after they suggest my duty lies closer to spending a week in the sack with them and I just look at them like they're funny.  I'm actually pretty proud of my mates; they've all got families of their own now but they didn't let their jealous cookies keep them from talking to me.</i>\"");
		
		outputText("\n\nStrange that Sheila didn't end up with one of them, if they stuck by her.");
		
		outputText("\n\n\"<i>Well, I thought about it... mostly when I got lonely,</i>\" she replies.  \"<i>But they were all drilled in the same values and, in small part or large, all still expected me to turn into my mum.  I didn't feel acceptance or tolerance from them when I talked about myself... only patience.</i>\"  Sheila slips her hand into yours and squeezes.  \"<i>I like you better.</i>\"");
		
		outputText("\n\nShe lets go, then gets to her feet, collecting her catch.  \"<i>I ought to head back... see you soon?</i>\"");
		
		outputText("\n\n\"<i>See you soon,</i>\" you agree.  \"<i>... Hattie.</i>\"");
		
		outputText("\n\nSheila's skin blooms with red and her lips compress to a thin line; she about-faces and walks off without another word.");
	}
	//oh gosh someone dropped a dollar here how lucky
	doNext(camp.returnToCampUseOneHour);
}

//[XP4 - Chat - Old Loves]
private function fuckBuddySheilaMeetingChatOldLoves():void {
	clearOutput();
	outputText("\"<i>[name], I don't want to talk about that,</i>\" Sheila says, \"<i>it leaves a bad taste in my mouth.</i>\"");
	
	outputText("\n\nYou offer to tell her about your own history, as an enticement, but she shakes her head.  \"<i>I don't want to talk about that either!  Look, no matter how cosmopolitan, nobody really wants to hear about the dicks " + player.mf("his","her") + " girl's had growing out of her face.  I mean, how many is the right answer?</i>\"");
	
	outputText("\n\nChanging tack, you point out that Sheila would have inherited some personality from them, thanks to her... situational empathy... so it's only fair if you know a little bit, right?");
	
	outputText("\n\nShe lowers her eyelids at you.  \"<i>That's a boomer of an assumption.  And, it's not like you can do anything special even if you know, mate.  What I am is what I am.  It doesn't really matter anyway, since I'll be getting closer to </i>your<i> personality if... well.</i>\"  Sheila looks at you coquettishly.");
	
	outputText("\n\n\"<i>Does that mean that eventually you </i>will<i> be comfortable talking about it?</i>\" you ask, with a broad smile.");
	
	outputText("\n\nThe woman stifles a laugh.  \"<i>[name], that's not funny.  I... guess I would, though it'll take a while since I feel so strongly.  Deadset, there's not much to know; I promise.  Ask again after we've been together so much we have the same accent - after ten years of happy marriage, maybe.</i>\"");
	
	//[(lib < 50)]
	if (player.lib < 50) {
		outputText("\n\n\"<i>Does that actually happen?  Couples sounding alike?</i>\"  Privately, you can't even imagine understanding, let alone using, half the words she does.");
		
		outputText("\n\n\"<i>It does... my mum used to talk like a rich girl.  Still did, when I was coming up.  But after being with my dad for so long and so... often, they're pretty much the same person now, no matter how much I separate them in my head.  It's not that the words bleed over, just that they stop sounding wrong to you.  I already catch myself thinking of what you might call a thing once in a while and have to correct it before I say it to one of my mates - it might just be because I think you're bonzer, though.</i>\"  Sheila grins toothily, pressing your hand.");
		
		outputText("\n\nLike that... what does 'bonzer' even mean?");
		
		outputText("\n\nThe woman colors a bit and looks down.  \"<i>Er...</i>\" she mumbles, \"<i>it means you're great, [name].  Top shelf.  My favorite " + player.mf("bloke","sheila") + ".</i>\"");
		
		outputText("\n\n\"<i>Oh.  Is that so?</i>\" you ask, facetiously.");
		
		outputText("\n\n\"<i>Don't tease me so much,</i>\" she says, pulling your arm around her.  \"<i>You drive me crazy.</i>\"");
		
		outputText("\n\n\"<i>You'll get used to it.</i>\"");
	}
	//(else lib >=50)
	else {
		outputText("\n\n\"<i>Did you just propose to me?</i>\"");
		
		outputText("\n\nSheila blushes bright red.  \"<i>No.</i>\"");
		
		outputText("\n\n\"<i>Well you should soon, if you want to get started on those ten years.</i>\"");
		
		outputText("\n\nThe woman looks away and folds her arms over her chest");
		//[(sheila corruption >=60)]
		if (player.cor >= 60) outputText(" - though it's probably meant to be a defensive gesture, all it does is push her tits together under her white shirt and frame them in light-brown skin");
		outputText(".  \"<i>[name], you horny whacker, I'm not gonna marry you.  Having to bull my way through a horde of monsters to see you and stand watch in shifts just to sleep together at night may be romantic once, but it's no kind of thing to do every day for the rest of my life.</i>\"");
		
		outputText("\n\nA bit unnerved, you ask if she really means that - if she intends to stop seeing you because your relationship will be a difficult one if the demons aren't defeated.");
		
		outputText("\n\nSheila seems increasingly distraught as she considers that logical conclusion.  \"<i>N-no... I don't wanna!</i>\" she finally blurts childishly, dropping her posture and throwing her arms around you.  \"<i>I don't want to let you go, and I don't want to have to hide in the ground while you're out here in danger; I want to stay with you!  I wish the demons would all just go to hell so I could have a proper life!</i>\"  She remains like that for several minutes, face pressed against you until her sniffling and shaking stop");
		//[(corr < 30)
		if (player.cor < 30) outputText("; you lay a hand on her shoulder reassuringly");
		outputText(".  Eventually she pulls away again, nose slightly red.  \"<i>Sorry, mate; didn't mean to have a tantrum on you.</i>\"");
		
		outputText("\n\n\"<i>Going to stick it out, then?</i>\" you ask, carefully.");
		
		outputText("\n\nSheila frowns unhappily and doesn't answer... but she does play with your hand, articulating the fingers and rubbing it against her warm cheek until it's time for her to go.");
	}
	//you no touch candle!
	doNext(camp.returnToCampUseOneHour);
}

//[XP4 - Chat - Why Hide?]
private function fuckBuddySheilaMeetingChatWhyHide():void {
	clearOutput();
	outputText("Her eyes cloud as she looks at you dubiously.  \"<i>Well, it's like I said before.  If a demon catches one of us, we're done for.  You know, I'm sure, that when a demon manages to get a mug to want pleasure more than anything and turn into a demon as well, they get a free souvenir in the form of those little  crystals that grant them powers.  Imagine how many of those arses would love to find a hundred or so of us in one place, just lacking some stimulation to turn us into a birthday party and a pile of free godlike power trinkets.  That'd be all of them, y'see.</i>\"");
	
	outputText("\n\nYou wave off her glare.  Seems like it'd still be better to have everyone in one place, to watch out for each other instead of shriveling up slowly without support.");
	//(if T'A)
	if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) {
		outputText("  After all, the city in the desert seems to be bustling and bristling with weapons to resist the demons, whatever her feelings may be about it.");
	
		outputText("\n\nSheila snorts dismissively, considers, then speaks again.  \"<i>Suppose so... but one bad apple and the whole lot's spoiled from inside.  Next time you go there, try asking how often they've come close to being homeless because some horny or greedy hoon put himself first and tracked in dirt.  We may be weak enough that you can close down a cave or two, but we breed fast and we'll survive until we're numerous enough to fight.</i>\"  She shakes her head.");
	}
	outputText("\n\n\"<i>It's not like that, anyway; not really.  We keep in touch with the other colonies at the swaps - if a mob needs food, we give them food.  If they need help to beat back the bush for safety or a new colony, we pick up our weapons and go help.  Hiding just makes it easier to keep an eye on our own and keeps down the collateral if... if something does happen.</i>\"");
	
	outputText("\n\nSheila shivers a bit and lifts your arm to place it around her shoulder, then looks gloomily out across the plains.  She doesn't seem to be in the mood to talk anymore.");
	
	//blood on the sand
	doNext(camp.returnToCampUseOneHour);
}

//[XP4 - Chat - Live With Me]
private function fuckBuddySheilaMeetingChatLiveWithMe():void {
	clearOutput();
	outputText("You ask Sheila to move in with you at your camp, and she turns bright red.");
	outputText("\n\n\"<i>Mate, I hardly know you.  I mean... um, I suppose I don't get to use that excuse when I feel what you're feeling if we... uh.  No.  The answer is no.</i>\"");
	
	outputText("\n\nUpon seeing your disappointment, she relents a bit.  \"<i>If it were a different world, one without demons, then maybe; once we'd known each other a while longer.  But here and now?  I can't reconcile leaving my mob behind when we need every cobber available to help guard and feed us.  I do like you... don't let it go to your head, though.</i>\"  She places her hand over yours and kisses you on the cheek.  \"<i>Thank you for asking.</i>\"");
	
	outputText("\n\nSheila gets to her feet and balances her catch on her shoulders, looking wistful.  When you ask about it, however, she just shakes her head and tells you it's nothing, then walks off subdued.  Seems like she really wanted to say 'yes', instead.");
	//ancient Chinese secret, eh?
	doNext(camp.returnToCampUseOneHour);
}

//[XP4 - Chat - Kids] - requires joeycount >= 1
private function fuckBuddySheilaMeetingChatKids():void {
	clearOutput();
	//if joeycount = 1
	if (flags[kFLAGS.SHEILA_JOEYS] == 1) {
		outputText("\"<i>Ah?</i>\" Sheila says, turning toward you sheepishly.");
		
		outputText("\n\n\"<i>I said, 'how's the kid doing?',</i>\" you repeat.");
		
		outputText("\n\n\"<i>I heard you, mate... I was just a little surprised.</i>\"  Sheila wraps her arm around yours.  \"<i>The baby's fine.  Eats well and loves attention.  The other day I stuck my finger into that chubby little hand and it closed around me and wouldn't let go... I sat there for about an hour, just watching and sighing.  Sometimes it feels like I'm turning into one of those mush-headed new moms that always embarrassed me before, though.</i>\"  She looks at you with a half-smile.");
	
		outputText("\n\n\"<i>Strong grip?</i>\" you ask.");
		
		outputText("\n\n\"<i>You really are serious about this, aren't you?</i>\" Sheila mumbles.  You nod, and she continues.  \"<i>You remind me of my dad... once I brought the joey home and told him about us, he was in the nursery to check on it all the time.  He says he wants to meet the man who was able to father such a healthy baby with his little girl - ");
		//[(if PC femininity > androgynous)]
		if (player.femininity > 50) {
			outputText("I don't know how he'll react when he sees a pretty face like yours, though; he doesn't know that I'm-");
			//[(PC is herm, fem)
			if (player.gender >= 2) {
				outputText("</i>\"\n\n\"<i>A lesbian?  Attracted to women?  A clam diver?</i>\"");
			}
			//(else PC is male or unsex)
			else outputText("\n\n\"<i>Into girly boys instead of big, strong, hairy bears?</i>\"");
			outputText(" you guess, teasing her as her blush deepens.");
			outputText("\n\n\"<i>[name], stop it.</i>\"");
		}
		//else if PC masculine or andro, no new PG)
		else {
			outputText("I'm not sure if he intends to shake your hand or punch you, though.</i>\"");
			//[(PC is male or neuter)]
			if (player.gender <= 1) outputText("\n\n\"<i>Sounds... protective.</i>\"");
			else outputText("\n\n\"<i>Think he'd really punch a girl?  He must be very protective,</i>\" you tease.");
			outputText("\n\nSheila sighs.  \"<i>I'm a daddy's girl.  His first child, got all the benefits of his time, and one without kids and a husband of her own to pull her emotions away from him.  I've always just been his baby... maybe longer than I should have, but I was lonely, mate.  We're close.</i>\"");
		}
		//merge gender/sex fork
		outputText("\n\n\"<i>So, is he serious... about meeting?</i>\" you persist carefully.");
		
		outputText("\n\nSheila looks into your eyes, trying to read your expression.  \"<i>Yeah, I think so.  I hope he's not set to bail you up, but... he says he aims to search you out when he gets switched back to the hunting crew.</i>\"");
		
		outputText("\n\n\"<i>Will that be soon, then?</i>\"");
		
		outputText("\n\n\"<i>I dunno, mate,</i>\" she says, shrugging her shoulder against your arm.  \"<i>It all depends on what the colony needs.  If we lose hunters or can't bring in enough food, we pull members of other teams and the reserve in to make up the slack - whoever's rated for the job.  Otherwise it'll be when his rotation comes up, assuming we don't lose soldiers or diggers first.</i>\"");
		
		outputText("\n\n\"<i>Does that happen a lot?</i>\" you probe.  \"<i>Not catching enough game?</i>\"");
		
		outputText("\n\n\"<i>No... not often.  Not all hunters hunt game - most of the new salamander biscuits are just sent out with a flyer and told to pick wild fruits and vegetables.  I get to set traps and take naps instead of trudging around with heavy baskets, digging in the dirt for ten hours, but it's only because we have few enough cobbers who are good at getting meat.  Food purification is also part of the hunting job for those with chemist's training, but the reservists inside the colony help a lot with that.  So you could see him a week from now, or you could live and die and never meet him - it all depends on who the next person that can't do their work anymore is.</i>\"");
		
		outputText("\n\nYou nod, trying to hide your laughter at the mental image of her dad in a pink gardening smock with a spade in hand and two bags of root vegetables on his shoulders.  Sheila looks at your barely-concealed grin, and pokes you in the side.  \"<i>Something funny, mate?</i>\"");
		
		outputText("\n\nShaking your head, you lean against her; the two of you remain like that until she gets up to leave and bids you farewell.");
	}
	//if 1 < joeycount < 10
	else if (flags[kFLAGS.SHEILA_JOEYS] < 10) {
		outputText("\"<i>So how are the kids?</i>\"");
		outputText("\n\nSheila smiles under her downcast eyes.  \"<i>They're fine, love.  Some are getting pretty big.</i>\"");
		outputText("\n\nShe holds her hands eight or ten inches apart.  When your eyebrows register surprise at that, she elaborates.  \"<i>Remember how small they come out, though... only about four inches when they're born.  We tuck them in little pouches to keep them warm and up against the teat.</i>\"");
		
		outputText("\n\nFour inches?  That explains how she keeps her slim figure");
		if (player.lib > 50) outputText(" and tight, hot cunt");
		outputText(" so well...  \"<i>How long does it take them to grow up?</i>\"");
		
		outputText("\n\n\"<i>Well,</i>\" Sheila says, \"<i>I dunno about yours, but two years or so is enough for purebred kids to be up and helping around the colony - they're about three or four feet then.  Just basic stuff, like carrying small bags of food home from the storage for their mum or dad.  Two more years and they're basically adults... not as wise as one, of course, but they start perving and pairing off around then, no matter how much their oldies urge them not to.  Magic of hormones, world's your oyster, and all that.</i>\"");
		
		outputText("\n\nThe implications come to you in a hurry.  \"<i>So... how old are you?  Five?  Ten?</i>\"");
		outputText("\n\nSheila laughs.  \"<i>No, mate; much older than that.  I'm not going to tell you how much, though.</i>\"  Her eyes narrow in mock suspicion, and she smiles broadly.  \"<i>A " + player.mf("gentleman","lady") + " doesn't ask a");
		if (player.gender >= 3) outputText("nother");
		outputText(" lady's age, after all.</i>\"");
		
		//[(lib >=50)
		if (player.lib >= 50) {
			outputText("\n\n\"<i>But I'm no " + player.mf("gentleman","lady") + ",</i>\" you retort, leaning in to tickle her ear with your words.  \"<i>Though, I was only asking because your skin is so smooth and your nipples so perky...</i>\"  You nip at her lobe.  \"<i>And your pussy still squeezes like it's your first time.</i>\"");
			
			outputText("\n\n\"<i>[name]!</i>\" Sheila shrieks, pulling back and slapping you across the face.  \"<i>You nasty root rat!</i>\"");
			
			outputText("\n\nYou grin, rubbing your cheek.  The woman blushes and her ears slump; she looks away and mumbles, \"<i>Sorry... didn't mean to swat you.  You surprised me, that's all.</i>\"");
			
			outputText("\n\n\"<i>Don't kill the messenger,</i>\" you tease, slipping your arm around her waist.  She shivers but doesn't resist, allowing you to play your fingers along her shirt hem until she gets up to leave.");
		}
		//(else lib < 50)
		else {
			outputText("\n\n\"<i>So you could really do that?</i>\" you ask, changing tack.  \"<i>Have your own kid when you're only four?</i>\"");
			outputText("\n\nSheila nods.  \"<i>Most of the captains don't encourage it because there aren't enough hours in the day to learn a trade right and raise your child, but when you're young and horny... those joeys typically get left with the creche, and adopted by one of the nurses.  My mum has one right now, I think.  Heartbreaking for the girl who makes it.</i>\"");
			outputText("\n\n\"<i>Oh... personal experience?</i>\" you ask cautiously, looking at her.");
			outputText("\n\n\"<i>What?  No...</i>\"  Sheila meets your gaze.  \"<i>I just see it too often because of who my mum is.  A poor young thing crying at our door in the small hours, begging to hold her baby just a bit longer, as mum and dad try to console her and get her to go home and sleep so she's not easy prey for some rapist wildlife the next day.  Can't be too careful when you get pregnant like falling downhill.</i>\"  She squeezes your hand and rests her forehead against your shoulder.  \"<i>Yours was my first, mate.</i>\"");
			outputText("\n\nSheila sighs and says nothing more; seems like she's not in the mood to continue.  Eventually she gets up and, with a hug, leaves.");
		}
	}
	//if joeycount >= 10
	else {
		outputText("\"<i>Kids doing all right?</i>\"");
		outputText("\n\nSheila turns a hollow, lined face on you.  \"<i>You tell me, mate.</i>\"  Looking into it, you can clearly see the stress your numerous broodlings have already etched into her skin.  The youth is gone from her; naïvete has been replaced with the mien of an experienced mother, even though her body looks nearly the same.  You bite your lip.");
		outputText("\n\n\"<i>I know; you don't even have to say it,</i>\" Sheila mumbles.  \"<i>I can see it in reflections.  I'm not even pretty anymore.</i>\"");
		outputText("\n\n\"<i>That's-</i>\" you begin, attempting to demur, but she waves your comment off.");
		
		outputText("\n\n\"<i>I'm not fishing, mate... don't worry about it.  I wouldn't trade you or a single one of your kids for all the beauty of the assembled succubus corps.</i>\"  She slips her hand into yours.  \"<i>Not even the little hellion.</i>\"");
		//[(lib < 50)]
		if (player.lib < 50) {
			outputText("\n\n\"<i>Don't you have someone else that can watch them for you?</i>\" you ask.");
			
			outputText("\n\nSheila's eyes harden.  \"<i>Yeah... my mum has volunteered.  A few of my neighbors tried to as well, but my mum quietly chased those off, saying she'd be happy to handle it and keep it in family.</i>\"");
			outputText("\n\n\"<i>So...?</i>\"");
			
			outputText("\n\n\"<i>The kids already spend all day in the nursery listening to her and her crones - just a constant flow of pork about how 'women's work' is in the home and girls like me are wrong to be outside and away from them.  Of course she never says it in so many words, but kids pick up what they see.  I don't want mine going home with her at night to get the private lesson just because I was too lazy to fetch them.  I can hear her now... 'Your mum is all tired out from working at her job and needs to rest before she sees you, so you just come home with me and Nana will take care of you.'  Pig's arse.</i>\"");
			
			outputText("\n\nThat's... eerily bitter.");
			if (player.cor < 40) outputText("  You pat her shoulder carefully and suggest, \"<i>I could watch them for a while.</i>\"");
			
			outputText("\n\n\"<i>God, that'd be nice.  But I can't take them out of the colony until they're ready to train a trade; those are the rules.  Only nurses can, when they need to teach a class basic stuff - up is up, rocks are rocks, that sort - and they get a soldier detail when they go.  I wouldn't want to anyway... nothing on you, but there are only two of us and " + num2Text(flags[kFLAGS.SHEILA_JOEYS]) + " of them.  I wish I could bring you in, though.</i>\"");
			
			outputText("\n\n\"<i>Well... why can't you?</i>\" you ask.  \"<i>I mean, I'd think it's clear by now that I'm not some monster.</i>\"");
			
			outputText("\n\nYour companion looks profoundly unhappy.  \"<i>Don't ask me to explain a policy I hate.  I'd like nothing more than to fall asleep at night in an actual bed with you instead of staying up alone, worrying if you'll be alright");
			//[(silly)]
			if (silly()) {
				outputText(" and clutching the life-sized [name] bodypillow I made");
				outputText(".  But it's not going to happen right now.</i>\"");
				outputText("\n\nThat's too bad.  You slip an arm around her comfortingly, and she snuggles up to you.  \"<i>If you need to sleep a bit,</i>\" you offer, \"<i>I can watch you for an hour.</i>\"");
				outputText("\n\n\"<i>Thanks.  That's good oil.</i>\"  It doesn't take long before she's completely out, drooling on you with abandon; after the promised hour, you gently tap her awake.");
			}
			outputText("\n\nSheila sighs and gets up, nodding to you, and collects her stuff.  \"<i>Love you.  See you soon.</i>\"");
			//corruption down if corr < 40
			if (player.cor < 40) dynStats("cor", -1);
		}
		//(else lib >=50)
		else {
			outputText("\n\n\"<i>I'm still turned on by you,</i>\" you persist with a whisper.  \"<i>I want your body any time, anywhere.  Here, for example.  Or... here.</i>\"  This last comment is accompanied by your hand sliding into her shirt and over a " + sheilaCup() + " breast.  Sheila blushes.");
			
			outputText("\n\n\"<i>[name], trust you to never change.  Do... you really want to make love?</i>\"  Her care-worn eyes look into yours, regaining a bit of their former enthusiasm, and her skin heats up under your fingers.");
			//apply small lib-based lust damage and display [Sex] choices with [Rest For Now] instead of [Back]
			dynStats("lus", player.lib/10+5, "resisted", false);
			sheilaXP4Sex(false);
			addButton(9,"RestForNow",fuckBuddySheilaMeetingChatKidsRest4Now);
			return;
		}
	}
	doNext(camp.returnToCampUseOneHour);
}

//[XP4 - Chat - Kids - joeycount >= 10 - lib >= 50 - Rest For Now]
private function fuckBuddySheilaMeetingChatKidsRest4Now():void {
	clearOutput();
	outputText("\"<i>Always,</i>\" you answer, \"<i>but if you need to relax and sleep for a bit, I'm here for that too.</i>\"  You draw your hand back out, patting her on the cheek.");
	
	outputText("\n\nSheila kisses you on the forehead and then lays her head against your ");
	if (player.isTaur()) outputText("back");
	else outputText("lap");
	outputText(".  \"<i>You're sweet... thank you.  I will take you up on both of those offers - but maybe just the nap this arvo.  Would you wake me up in about an hour?</i>\"");
	
	outputText("\n\nYou nod and she dozes off; her face looks much more placid in sleep.  After an hour you gently nudge her awake, and she picks herself up and leaves you with a hug.  \"<i>Love you, [name].</i>\"");
	//corruption down
	dynStats("cor", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[XP4 - Sex]
private function sheilaXP4Sex(display:Boolean = false):void {
	if (display) {
		clearOutput();
		outputText("You slip an arm around the bushranger and lean in.  \"<i>I was thinking we could have some sex... feel up to it?</i>\"");
		outputText("\n\nSheila fidgets as your fingers begin to rove under her shirt and up her back while you wait for her answer.  \"<i>Horny bastard...</i>\" she mumbles.  \"<i>I figured that was what you'd want.</i>\"");
	
		outputText("\n\n\"<i>So, no?</i>\" you whisper, making sure to brush her long ear with your lips.");
		
		outputText("\n\n\"<i>I didn't say that...</i>\"");
	}
	//[Cock 69][Pussy 69][Vaginal Sex][Masturbate]
	//outputs are below
	//Consensual scenes (normal Sheila's vaginal capacity is 32, for reference):
	//[Consensual - Either 69] - Fenoxo beware, omnibus scene!(req. vag or dix; both buttons direct here but decide the focus)
	menu();
	if (player.gender > 0) {
		if (player.hasCock()) addButton(0,"69WithWang",consensualSheila69,true);
		if (player.hasVagina()) addButton(1,"69WithCooch",consensualSheila69,false);
	}
	//[Consensual - Vaginal Sex] (req. cock <= 32 area):
	if (player.hasCock() && player.cockThatFits(32) >= 0) addButton(2,"Fuck Her",consentacleVagSexForKangarooSlutBitches);
	//da scene
	addButton(3,"Masturbation",sheilaMutualMasturbation);
}


//Consensual scenes (normal Sheila's vaginal capacity is 32, for reference):
//[Consensual - Either 69] - Fenoxo beware, omnibus scene!(req. vag or dix; both buttons direct here but decide the focus)
private function consensualSheila69(cock:Boolean = true):void {
	clearOutput();
	outputText("As you lean into the woman and buzz her ear, her skin flushes.  \"<i>[name], you're incorrigible.  Don't taunt me so much this time, just get into it.</i>\"  Smiling and humming, you sit up and begin unfastening your armor; Sheila takes the opportunity to do the same, and finishes denuding herself before you do.");
	
	outputText("\n\nA raised eyebrow from you greets her exposed flesh.  She turns up a red face in response, staring close-mouthed with quiet embarrassment as she waits for you to finish disrobing.");
	if (cock) {
		if (player.cockThatFits(32) >= 0) {
			outputText("  Though, she smiles openly when you produce your [cockFit 32].");
			outputText("\n\n\"<i>Will you be putting that in me, then?</i>\" Sheila asks, spreading her labia softly in anticipation.  You make no reply, drawing a look of surprise.");
		}
		else {
			//(all big cox > 32)
			outputText("\n\nIncreasingly wide eyes offset her thin, pressed lips as you reveal " + player.sMultiCockDesc() + ", the voluminous flesh swaying softly to the breeze.");
			outputText("\n\n\"<i>[name]... you really do take it too far.  There's no way I can... I mean, the size of it!</i>\"  Even despite a point-blank refusal, Sheila's eyes don't leave your crotch, drinking in the sight of your dick");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" as she rubs her small, smooth labia vigorously.  \"<i>What do you expect me to do with one of those?</i>\"");
		}
	}
	//(vag)
	else {
		outputText("  When you finally drop your bottoms, revealing your wet " + player.vaginaDescript(0) + ", she smiles softly.");
		outputText("\n\n\"<i>Cute little flower...</i>\" Sheila says, playing with her own.  You mimic her, slipping a finger between your labia to stimulate yourself");
		if (player.clitLength > 8) outputText(" and bring your " + player.clitDescript() + " to its erect state.  \"<i>... And quite a stem,</i>\" your lover concludes.  \"<i>You sure that's not a dick?</i>\"");
		else outputText(", producing a slight sigh and a wet finger.  \"<i>And I'm the eager one, right?</i>\" your lover asks, wryly - though her finger is just as wet.");
	}
	
	outputText("\n\nSmiling still, you draw close to Sheila and slip a hand under her butt, coaxing it forward until she's lying down on the grass.  She seems to take your inscrutable silence in stride, kissing you softly, until you spread her thighs.");
	if (cock && player.cockThatFits(32) < 0) outputText("  \"<i>[name], I'm telling you it won't fit!</i>\"");
	else outputText("  \"<i>Not talking, then?  Please yourself.</i>\"");
	outputText("  Her commentary cuts off as you ");
	if (!player.isTaur()) outputText("turn around and hang your ");
	else outputText("straddle her and squat down to dangle your ");
	if (cock) outputText("pre-seeping shaft");
	else outputText("wet pussy");
	outputText(" over her head, waggling it provocatively as you slip your fingers into her.");
	
	outputText("\n\n\"<i>Ah... ah... you could have just told me,</i>\" Sheila gasps, ");
	//[(cox)
	if (cock) {
		outputText("wrapping a hand around your shaft");
		//(big) 
		if (player.cockThatFits(32) < 0) outputText(" and guiding it to bend comfortably against her chest, drooling a trail of pre-cum as she slides it into position");
		outputText(".");
	}
	//(vag)
	else outputText("returning the favor and plunging into your " + player.vaginaDescript(0) + " with her hand.");
	outputText("  She pumps you once, eliciting a trickle of fluid, and then speaks once more.  \"<i>Bring it lower...</i>\"");
	
	outputText("\n\nYou oblige, ");
	if (!player.isTaur()) outputText("flattening your back");
	else outputText("squatting lower");
	outputText(" so your ");
	if (cock) {
		outputText("cock sinks down");
		//[(small cock) 
		if (player.cockThatFits(32) >= 0) outputText(" into her warm, waiting mouth");
		else outputText("; she lets go of it to grab her breasts instead, trying to push them around the sensitive shaft as she runs her tongue up the underside");
		outputText(".");
	}
	else {
		outputText("pussy dangles just over her face; she ");
		if (player.clitLength > 8) outputText("nips and sucks at the tip of your clit, rolling it with her tongue");
		else outputText("parts your labia with her tongue, stroking them gently and tickling your little clitoris");
		outputText(".");
	}
	outputText("  Not to be outdone in creativity, technique, or audacity, you ");
	if (!player.isTaur()) outputText("lean down and bury your own tongue all the way inside Sheila, forcing her labia open with your mouth");
	else outputText("reach as far as you can to bring both hands into play, stroking and pulling Sheila's labia apart with one as you tease her exposed clitoris or slip inside her vagina with the other");
	outputText("; your lover stops licking and you can feel her mouth slip away from your sensitive skin as her head rolls back.");
	
	outputText("\n\n\"<i>Gods, yes!</i>\" she cries.  Her pussy squeezes, trying to wring its invader for semen that won't come.  You let her body spasm and suck at you for a bit before recalling her to her duty with a soft clearing of your throat.  \"<i>Shit!  Sorry, mate... k-keep going!</i>\" Sheila says, ");
	//[(ladyparts)
	if (!cock) {
		outputText("slipping her tongue back into you");
		//[(bigclit)
		if (player.clitLength > 8) outputText(" and stroking your " + player.clitDescript() + " rapidly with one hand");
		outputText(".");
	}
	//(smallcox)
	else if (player.cockThatFits(32) >= 0) outputText("taking you into her mouth once again and licking away a neglected drop of pre-cum.");
	else outputText("stroking your cock with one hand as she pushes an erect nipple against its side to trace a line.");
	
	//[(no horse)
	if (!player.isTaur()) {
		outputText("\n\nHaving ensured that embarrassment, if nothing else, will keep her working away on your orgasm, you prepare to torment Sheila with an all-out siege of her pussy.  Your fingers join your busy mouth, taking up slack by stroking and pulling open the woman's small labia and allowing your lips to begin brushing her clitoris as you tongue-fuck her.  You can feel her shivering along your length as you force her steadily toward her pleasure threshold, which vibrations are transferred unintentionally to you through her ");
		if (cock && player.cockThatFits(32) < 0) outputText("shaking, teasing nipples and heaving chest");
		else outputText("mouth, humming in delight");
		outputText(".");
	}
	//(horse)
	else {
		outputText("\n\nFeeling sure that Sheila will keep working on your sex after your remonstration, you focus on bringing her more sensation than she can possibly endure.  Two fingers of one hand hold her labia open, exposing her vagina to your questing middle digits; the other hand works busily at her clitoris, alternately rolling the petit button with a thumb and dragging it against the flat surface of the palm.  You make sure to collect the moisture oozing from Sheila to keep the nub slippery at all times and work it faster, stroking it up, down, and all over.  The poor woman under you moans and shudders, transferring the vibration to you with her ");
		if (cock && player.cockThatFits(32) < 0) outputText("hard nipples");
		else outputText("throat");
		outputText(".");
	}
	//merge horse with rider
	//[(big cox)
	if (cock && player.cockThatFits(32) < 0) outputText("\n\n\"<i>[name]!  I'm coming!</i>\" Sheila cries.");
	else outputText("\n\n\"<i>Mmmh!  Mm mmnnn!</i>\" Sheila moans, muffled by your body.  The import doesn't hit you until a second later.");
	outputText("  Her vagina convulses, ");
	//(pc corr >= 90 or > sheila corruption
	if (player.cor >= 90 || player.cor > flags[kFLAGS.SHEILA_CORRUPTION]) {
		outputText("trying to pull your ");
		if (!player.isTaur()) outputText("tongue");
		else outputText("fingers");
		outputText(" in ravenously.  You can literally feel her internal muscles rippling and undulating, stroking you as if they could coax out an ejaculation.  Sheila sucks in her breath as she climaxes, filling her chest; you can feel her tits pushing harder and harder against you.");
	}
	//(PC corr < sheila corruption)
	else if (player.cor < flags[kFLAGS.SHEILA_CORRUPTION]) {
		outputText("pushing out a gush of fluid.  For what seems like several minutes, her pussy deluges your ");
		if (!player.isTaur()) outputText("mouth, filling you with her taste.");
		else outputText("hands, completely soaking them in her orgasm.");
		outputText("   Her thighs tense, forcing her pelvis into the air and her cunt toward you as her chest slumps; slowly, you feel the perky nipples pressing into your stomach pull away.");
	}
	//(else if equal but below 90)
	else if (player.cor == flags[kFLAGS.SHEILA_CORRUPTION] && player.cor < 90) {
		outputText("drooling a trickle of fluid and licking at you as she screams her ecstasy into your crotch.");
	}
	outputText("  Sheila jams her face upward, ");
	//[(big cox)
	if (cock && player.cockThatFits(32) < 0) outputText("pressing her lips and tongue to the base of your shaft as she masturbates it vigorously.");
	///(small cox)
	else if (cock) outputText("sinking your [cockHeadFit 32] into the warm recesses of her throat where her muscles caress and coax it.");
	else outputText("penetrating you deeply with her tongue as her hands reach up to stroke your clit furiously.");
	outputText("  Your body gives up under her frenzied assault, laying your crotch onto the woman's face as muscle control abandons you.");
	
	//[(if cock-focus)]
	if (cock) {
		outputText("\n\nStroke after stroke of semen passes down " + player.sMultiCockDesc() + ", ");
		//[(cock fits)
		if (player.cockThatFits(32) >= 0) {
			outputText("pouring out into your lover's waiting throat.  She gags and you can feel the gooey seed oozing back against your [cockHeadFit 32]");
			//[(small cum)
			if (player.cumQ() < 250) outputText("; you withdraw from her, allowing her throat to force your ejaculate back up and over her lips and cheeks with a splutter.");
			//(big cum)
			else if (player.cumQ() < 2000) outputText(", but your relentless orgasm forces it down again, dumping more jism into her throat.  You can feel her hands clawing at your [butt] as you relieve your buildup.");
			//[(mega cum)
			else outputText(".  Soon, her visibly-rounding stomach fills and the tip of your dick is once again washed in backflow; the next spurts force the cum all the way up, and she begins drooling the slimy semen-saliva blend from her mouth and nose, hands all the more frantic in her alarm.");
		}
		//(else doesn't fit)
		else {
			outputText(" squirting onto and between your intertwined bodies to soak your [chest] and neck, and Sheila's softly pumping crotch.");
			//(big skeet)
			if (player.cumQ() > 1000) outputText("  A wellspring of seed, your body continues producing until the fuzz on her thighs and tail is completely matted down with the whiteness drooling between you.");
			//(multicocks)
			if (player.cockTotal() > 1) {
				outputText("  Your other cock");
				if (player.cockTotal() == 2) outputText(" spasms");
				else outputText("s spasm");
				outputText(" as well, adding their own issue to the unholy mess covering the poor woman.");
			}
		}
	}
	//(else if vag-focus)
	else {
		outputText("\n\nYour pussy quakes and latches onto her tongue as your orgasm takes over, caressing the wet muscle.  Sheila waggles and stretches it, trying to score your convulsing insides with the tip even as she torments your sensitized clit in revenge for her own.  Your juices ");
		if (player.wetness() <= 2) outputText("trickle out, and are quickly sucked up by her greedy mouth");
		else if (player.wetness() <= 4) outputText("gush freely, leaving her face slick");
		else outputText("overflow, soaking her hair even as she shuts her eyes tight against the cataract");
		outputText(".  As you climax, you wrap around her head, squeezing so hard that you flatten her ears against her skull.  Her hands latch onto your butt, trying to pull you off, but having already spent herself on her throes of passion, she's no match for yours, still ongoing, and you hold tight until your body relaxes.");
	}
	
	outputText("\n\nSpent, you roll off of Sheila");
	//[(smallcox)
	if (cock && player.cockThatFits(32) >= 0) outputText(", pulling free of her throat.  She immediately turns over as well and forces herself to her hands and knees, then gags and coughs up a large amount of your jism.  When she's dumped enough to clear her passageway, she collapses forward, smearing the mess onto her chest as she spends a few minutes to catch her breath.  Once she's got it, she turns back over and sits up, strands of your slime linking her breasts to the grass.");
	//(else not smallcox)
	else outputText(".  She sits up, wiping sweat and stray fluids away from her eyes.");
	
	
	//if sheila corruption >= 90 and PC corr >= 90, go to demonization, else continue
	if (player.cor >= 90 && sheilaCorruption() >= 90) {
		menu();
		addButton(0,"Next",sheilaGoesDemon);
		return;
	}
	//[(corruption threshold warning if sheila corruption >= 80 and PC corr > sheila corruption and sheila xp =/= 3)
	else if ((player.cor > 90 || player.cor > sheilaCorruption()) && sheilaCorruption() >= 80 && flags[kFLAGS.SHEILA_XP] != 3) {
		sheilaCorruptionUpdate();
		/*if (player.cor > 90 || player.cor > sheilaCorruption()) {
			dynStats("cor", -10);
			sheilaCorruption(10);
		}
		else if (player.cor < sheilaCorruption()) {
			dynStats("cor", 10);
			sheilaCorruption(-10);
		}	*/	
		outputText("\n\n\"<i>Fuck, would you look at how big you're making my tits?  They look like they're ready to fire from my chest at any monster that shows up!</i>\"");
		
		outputText("\n\nYour climax-fogged brain settles on Sheila's breasts, as requested.  They are definitely looking enormous and squeezable, and you reach out a hand to rub one without a thought.  Sheila quivers as you touch her flushed skin, but grabs your wrist.  \"<i>Dammit, [name], stop!  How much fucking taint are you toting, you slut?</i>\"  Having gained your attention, she lets go.  \"<i>I'm sorry for that, but I can't keep being with you if you contaminate me like this!  I have responsibilities and mates counting on me, and already all I can think about is pushing them down and turning them into captive dongs to stuff me whenever I want!</i>\"");
		
		outputText("\n\nEr... well, there's definitely something to be said against tying up her friends and fucking them silly... without sharing them with you, anyway.  Ah, wait, that slippery thought you were trying to hold onto just got away from you again when Sheila's breast heaved in your hand.  Speaking of things to grab hold of and tie up...");
		//minus lust, minus small libido; if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption and slimefeed
		player.orgasm();
		dynStats("lib", -.5);
		player.slimeFeed();
		//[Fondle Her][Listen to Her]
		menu();
		addButton(0,"Listen2Her",sheilaCorruptionWarningListenToHer);
		addButton(1,"Fondle Her",sheilaCorruptionWarningsChooseFondle);
		return;
		//choices go to corruption intercept
	}
	//(else if no corruption warning)
	outputText("\n\n\"<i>Gods damn, [name],</i>\" Sheila coughs, staring at you.  Still slack-muscled from your orgasm, you look over at her.  ");
	if (cock && player.balls > 0) {
		outputText("What you see manages to pull an explosive laugh from you, tired as you are.  Sheila gives you the stink-eye until you've recovered enough to explain the source of your mirth: on her forehead, making a perfect ");
		if (player.balls == 2) outputText("infinity");
		else outputText("double infinity");
		outputText(" shape against the rest of her skin, is an imprint of your " + player.ballsDescriptLight() + ".  The kangaroo girl rolls her eyes at the juvenile display and resumes her harangue.  ");
	}
	outputText("\"<i>You could give a girl a bloody warning before that sort of behavior.  I thought you were going to kill me!</i>\"");
	
	//minus lust, minus small libido; if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption and slimefeed
	player.orgasm();
	dynStats("lib", -.5);
	sheilaCorruptionUpdate();
	/*if (player.cor >= 90 || player.cor > flags[kFLAGS.SHEILA_CORRUPTION]) {
		dynStats("cor", -10);
		sheilaCorruption(10);
	}
	else if (player.cor < flags[kFLAGS.SHEILA_CORRUPTION]) {
		dynStats("cor", 10);
		sheilaCorruption(-10);
	}*/
	player.slimeFeed();
	
	outputText("\n\nShe unruffles for a moment, and then pulls in close beside you.  ");
	//[(sheila xp = 3)
	if (flags[kFLAGS.SHEILA_XP] == 3) {
		outputText("\"<i>[name]... thanks.  Even being covered in your mess is better than being stuck outside all night, too scared to touch myself and too horny to run.</i>\"  Sheila kisses you on the cheek.  \"<i>My sloppy hero, eh?  I'm okay now; I can make it 'til morning when the gate reopens.</i>\"");
		outputText("\n\nWhatever that means... does she plan to spend all night outside, alone and covered in drying sexual fluids?");
		outputText("\n\n\"<i>Er... pretty much, yeah?  It won't be the first time - the staying up all night, I mean.</i>\"  Sheila colors a bit.  \"<i>That's how it goes if I can't make curfew; gotta watch out for myself.  But it'll be okay now that you've... helped, and I can actually focus.</i>\"");
		outputText("\n\nSheila gives you a small hug and starts to pull away; she really intends to stay awake until morning, running and hiding from whatever might come close.  Doesn't sound like much fun.");
		//[Stay With Her][Let Her Be]
		//choices go to XP3 20:00 event
		menu();
		addButton(0,"Let Her Be",sheilaXPThreeSexyTimePostSexLetHerBe);
		addButton(1,"Stay With Her",shielaXPThreeSexyTimePostSexStay);
		return;
	}
	//(else if sheila xp =/= 3)
	else {
		outputText("\"<i>Forget it.  With the way you worked me, I forgive you.  Just be careful, you wanker.</i>\"  Sheila closes her eyes and pulls your arm around her shoulder");
		if (cock && player.cockThatFits(32) >= 0) outputText(", smearing your dangling hand into the mess on her tits");
		outputText(".  The two of you lie like that for a while, until she gets up.  \"<i>I should really go... need to cure my catch.  Not to mention I'll have to clean up before I can even put my damn clothes back on.</i>\"  Sheila picks up her stuff.  \"<i>Hehe... see you soon.</i>\"");
	}
	doNext(camp.returnToCampUseOneHour);
}

//[Consensual - Vaginal Sex] (req. cock <= 32 area):
private function consentacleVagSexForKangarooSlutBitches():void {
	clearOutput();
	var x:int = player.cockThatFits(48);
	if (x < 0) x = player.smallestCockIndex();
	outputText("Sheila doffs her hat and lowers her light eyes shyly as you lean in, then looks up and puts her arms around your neck as you slip your own about her waist.  She blushes a bit, then leans in as well; you quickly capture her lips with a small kiss, then another.  The tiniest murmur escapes as you break away from this second kiss, and then she's diving in again, locking her mouth together with yours and exploring it with her tongue.  You return her passionate kiss with one of your own as your hand drifts up from her waist, under her shirt. It reaches her semi-erect nipple quickly and you begin pinching and rubbing it between your fingers; her mouth quivers on yours as you tease, then eventually breaks away as she tilts her head back and lets out a low moan.  Taking the opportunity to escape from her kisses, you move your mouth down her long neck as your fingers trace the outline of her teat.");
	
	outputText("\n\n\"<i>Ahh, god...</i>\" she sighs, as you continue tickling her neck with your lips.  She breaks her embrace and hurriedly pulls her vest and shirt over her head, revealing her " + sheilaCup() + " breasts; both her nipples are fully erect, sticking up like little 'touch me' signs.  You oblige them and caress her ");
	if (sheilaCorruption() <= 30) outputText("pert");
	else outputText("jiggly");
	outputText(" breasts as she fiddles with your own clothing.  She manages to remove the top of your [armor], exposing your [chest]; she then returns your favor by ");
	if (!player.hasFuckableNipples()) outputText("squeezing and fondling");
	else outputText("plunging two fingers into");
	outputText(" your own " + player.nippleDescript(0) + "s.  You shiver as she paws at the sensitive nubs on your chest, but don't let up your assault, moving your mouth down to tickle one of hers with your teeth and tongue.  Soon she's quaking and twitching beneath your ministrations; rubbing at her crotch with one hand as she half-heartedly tries to tease you back with the other.");
	
	outputText("\n\n\"<i>Please... I can't take any more,</i>\" she whines.  \"<i>Stop pashing on my nips and put it in, mate.</i>\"  The hand at her crotch begins trying to unfasten her belt while the other grabs and fondles her breast; you smirk and complete your own undressing quickly with both hands.  As " + player.sMultiCockDesc() + " emerges, engorged with blood, from your clothing, she switches from undressing back to rubbing, breathing heavily and stroking herself through the fabric as she stares at your ");
	//[(if wangaroo)
	if (player.cocks[player.cockThatFits(32)].cockType == CockTypesEnum.KANGAROO) outputText("tapered, fleshy penis.  \"<i>Wow... you never see those.</i>\"");
	else outputText(player.multiCockDescriptLight() + ".");
	
	outputText("\n\n\"<i>What's wrong?</i>\" you tease.  \"<i>I thought you wanted it in, but your pants are still in the way?</i>\"");
	
	outputText("\n\nHer cheeks blush furiously as she puts both her hands back to work on unfastening her belt; as soon as she loosens it, you reach down and pull her shorts off of her.  A long string of fluid stretches from her smooth pussy as you pull her damp panties away from it; she's wetter than a goblin boarding school on Father's Day!  You rub two fingers along her desperate slit, feeling it twitch under them and leak more lubrication.");
	
	outputText("\n\n\"<i>S-stop teasing me, you drongo!</i>\" she gasps as you stimulate her eager vagina.  \"<i>Just... just fuck me already!</i>\"");
	
	outputText("\n\nYou grin.  ");
	//[(no centaur)
	if (!player.isTaur()) outputText("Taking hold of your " + player.cockDescript(x));
	//(centard)
	else outputText("Attempting to maneuver your " + player.cockDescript(x) + " into position");
	outputText(", you rub the head along her dripping snatch, smearing her fluid over it.  ");
	//[(non-cent)
	if (!player.isTaur()) outputText("Gripping her fuzzy thighs next, you lift her bottom and line");
	//(hoers)
	else outputText("She lifts her bottom and lines");
	outputText(" her slippery passage up with your cock.  \"<i>Here it comes!</i>\" you cry.  With that announcement, you thrust into her, parting her lips with your swollen " + player.cockHead(x) + ".  She moans in relief as you finally enter her, but said relief is short-lived as you begin pumping at her slick vagina.  Gasping weakly, she lies back on the ground; ");
	if (sheilaCorruption() <= 30) outputText("her perky breasts rock back and forth");
	else outputText("her jiggling breasts flatten into perfect domes and undulate on her chest");
	outputText(" as you draw in and out of her warm, moist pussy.");
	
	outputText("\n\nShe rubs and squeezes her breasts vigorously as you thrust, and the sight of her sensitive tit-flesh being shaped and massaged gives an extra impetus to your lust.  ");
	//[(non-cent)]
	if (!player.isTaur()) {
		outputText("You pause briefly, adjusting your angle and leaning down to kiss her deeply once again and help caress her ");
		if (sheilaCorruption() <= 30) outputText("firm");
		else outputText("pillowy");
		outputText(" tits, then resume thrusting from your new position; her nipples now brush against your [chest] as you pump.  ");
	}
	//(if balls/vag)
	if (player.balls > 0 || player.hasVagina()) {
		outputText("Her stubby tail curls inward toward you, rubbing up against your ");
		if (player.balls > 0) outputText("[balls]");
		else outputText(player.vaginaDescript(0));
		outputText(" and tickling you as she writhes in pleasure.  ");
		//(if vag)
		if (player.balls == 0 && player.hasVagina()) outputText("Your cunt twitches and drools a bit of fluid on the furry intruder.  ");
	}
	outputText("You fuck harder, stuffing Sheila with such force that her ");
	if (sheilaCorruption() < 30) outputText("perky, erect nipples trace long arcs against your skin");
	else outputText("jiggly tits nearly slap into her face");
	outputText(".  \"<i>Ohhh,</i>\" she moans, \"<i>YES!</i>\"  At that moment you feel her vagina clamp around your [cockFit 32], wringing it frantically as she reaches her climax.  You continue pumping as best you're able, but you can't stand up to the siege of her spasming pussy for long; ");
	
	//[(pc corr >= 90 or > sheila corruption) 
	if (player.cor >= 90 || player.cor > flags[kFLAGS.SHEILA_CORRUPTION]) {
		outputText("something builds to a painful intensity in your crotch.  It feels like two mind-blowing orgasms arriving together and fighting over which one gets to come out first.  You rise toward climax quickly and then are drawn back in moments of maddening frustration, over and over.  In response you intensify your thrusts even more, sawing in and out of the girl at a pace that would be blistering if the two of you weren't leaking enough pre-cum and pussy juice to put out a brushfire.  Eventually the pleasure overwhelms the strange reticence of your orgasm; you cry out loudly as you peak, and squeeze a tiny trickle of cum into her grasping vagina.");
		//[(multi)
		if (player.cockTotal() > 1 ) {
			outputText("  Your other ");
			if (player.cockTotal() == 2) outputText("dick erupts");
			else outputText("dicks erupt");
			outputText(" as well, festooning her crotch with sticky strings.");
		}
		outputText("  The intense sensation begins to ascend your dick slowly; your body works itself into overdrive and your partner's moans increase sympathetically as it nears the tip.  Finally, it exits your body with an enormous squeeze, alongside a jet of jism.  Sheila gives a complementary gasp as this pulse enters her, and her pussy convulses in a second orgasm, causing her back to arch.  Her breasts seem to jiggle more wildly than before as she thrashes on the ground in the grip of her pleasure.");
	}
	//(PC corruption < sheila corruption)
	else if (player.cor < flags[kFLAGS.SHEILA_CORRUPTION]) {
		outputText("your resistance is condemned to die in failure as Sheila lets out a quavering scream of pleasure and wraps her arms and legs around you, pinning you inside.  Her vagina convulses around your cock powerfully; you could swear you feel yourself stretching longer and longer as her rippling pussy pulls you deeper in.  Just when you think that your dick must be a mile long, her whole body tenses up and her fingernails dig into your back.  Wearing a madwoman's expression, Sheila stares open-mouthed at you as her muscles lock and her pussy quivers out its fitful orgasm; even her ");
		if (sheilaCorruption() < 30) outputText("perky");
		else outputText("pillowy");
		outputText(" breasts seem to be held taut, compressed and motionless.  Suddenly she rams her hips into yours violently and throws her head back, and before you can issue a word of protest, her cunt wrings your " + player.cockDescript(x) + " one last time with almost supernatural heat; your mind clouds over and a wracking orgasm shoots to the base of your spine, echoing back with the first wave of your ejaculation.");
	}
	//(else if equal but below 90)
	else {
		outputText("your orgasm quickly supersedes your control as she wrings you and rubs her nipples against your [chest].  " + player.SMultiCockDesc() + " begins to twitch as it unloads its first squirt of semen into her spasming pussy");
		if (player.cockTotal() > 1) outputText(" or onto her thighs and belly");
		outputText(".");
	}
	
	outputText("\n\n\"<i>Oh god!</i>\" she yells.  \"<i>Pull out, before you get me pregnant!</i>\"  ");
	//[(non-dog cock)
	if (!player.hasKnot(x)) {
		outputText("You oblige shakingly, pulling your " + Appearance.cockNoun(player.cocks[x].cockType) + " out of her clenching pussy with a wet, sucking noise.  A trickle of semen drools from between her lips as you unburden yourself of the rest of your load, squirting it onto her groin");
		//[(big skeet)
		if (player.cumQ() > 500) outputText(", breasts, and face");
		outputText(".");
		//[(Huge skeet)
		if (player.cumQ() >= 1500) outputText("  More and more globs of semen shoot from the end of " + player.sMultiCockDesc() + ", pasting Sheila to the dry grass as you paint her body white.");
	}
	//(dog cock)
	else {
		outputText("You attempt to oblige her, but your swollen knot sticks firmly in her squeezing pussy, locking you into place.  After a few fruitless tugs, you give yourself up to your orgasm with an apology, slumping against her heaving chest and helplessly dumping the rest of your load into the twitching woman. ");
		//[(big skeet)
		if (player.cumQ() >= 1000) {
			outputText("Her belly begins to round as your overproductive gonads push out your massive store of semen");
			//[(huge skeet)
			if (player.cumQ() >= 3000) outputText(", until it's stretched as far as possible and each successive jet forces out squirts of frothy jism from the tight seal her pussy makes around the knot");
			outputText(". ");
		}
		//[(multi)
		if (player.cockTotal() > 2) outputText("Your other cocks erupt as well, soaking her crotch and matting down the fur on her thighs with whiteness. ");
	}
	outputText("Both of your orgasms finish up");
	//(dog-c) 
	if (player.hasKnot(x)) outputText(" and you finally manage to pull out of her");
	outputText("; the two of you lie there breathing raggedly for several minutes.  Sheila breaks the silence first.");
	
	player.orgasm();
	dynStats("lib", -0.5);
	
	//if sheila corruption >= 90 and pc corr >= 90, go to demonization, else continue
	if (player.cor >= 90 && sheilaCorruption() >= 90) {
		menu();
		addButton(0,"Next",sheilaGoesDemon);
		return;
	}
	//[(corruption threshold warning if sheila corruption >= 80 and PC corr > sheila corruption and sheila xp =/= 3)
	else if ((player.cor > 90 || player.cor > sheilaCorruption()) && sheilaCorruption() >= 80 && flags[kFLAGS.SHEILA_XP] != 3) {
		sheilaCorruptionUpdate();
		/*if (player.cor > 90 || player.cor > sheilaCorruption()) {
			dynStats("cor", -10);
			sheilaCorruption(10);
		}
		else if (player.cor < sheilaCorruption()) {
			dynStats("cor", 10);
			sheilaCorruption(-10);
		}*/
		outputText("\n\n\"<i>God dammit [name], look how big my pointers are!</i>\"");
		
		outputText("\n\nYou look.  And look.");
		
		outputText("\n\n\"<i>These have got to be G-cups or something!</i>\" she continues.  \"<i>I look like an ugly freaking cow!  How much taint do you have running in your blood, you root rat?!  Hey... listen to me!</i>\"");
		
		outputText("\n\nYou snap partway out of your post-coital, boob-induced daze.  \"<i>Uh?</i>\"");
		
		outputText("\n\n\"<i>Fucking seriously?  Did you even hear what I just said about my tits?</i>\"");
		
		outputText("\n\n\"<i>Yeah, you're right.  They're... nice.</i>\"");
		
		outputText("\n\nSheila appears to stagger at this, sending a pleasing jiggle through her huge breasts.  You can feel yourself getting ");
		if (player.hasCock()) outputText("hard");
		else outputText("wet");
		outputText(" again as you imagine having the enormous mounds pressed against you, and you slide a hand up her thigh as you lean in for a kiss.  \"<i>No, they're not!</i>\" she yells, turning her head away so your lips find her neck instead.  \"<i>I can hardly do my job as is, and you just make it worse!  Not only do these things get in the way, but I can't stop thinking about pushing you down and riding you all day!  You need to promise me you're going to clean up a bit; I can't keep getting bigger and more uninhibited just to please you!</i>\"");
		
		outputText("\n\nPerhaps there's a kernel of truth buried somewhere in that... heap of heaving, rising, falling, shivering breast-flesh, but... uh, what were you just thinking?");
		//[Listen to Her][Fondle Her]
		//outputs and stat changes for choices are below
		menu();
		addButton(0,"Listen2Her",sheilaCorruptionWarningListenToHer);
		addButton(1,"Fondle Her",sheilaCorruptionWarningsChooseFondle);
		return;
	}
	//(else if no corruption warning)
	outputText("\n\n\"<i>Ahh, you dipstick!</i>\" she gripes.  \"<i>You came in me!</i>\"");
	
	outputText("\n\n\"<i>Sorry,</i>\" you gasp, almost too spent to speak.");
	
	outputText("\n\n\"<i>You better be, mate,</i>\" she teases.  Kissing your cheek gingerly, she murmurs, almost too quietly to hear, \"<i>... you're still the best.</i>\"");
	//[(sheila xp = 3)
	if (flags[kFLAGS.SHEILA_XP] == 3) {
		outputText("  Sheila looks over, thankfulness written on every inch of her brow.  \"<i>[name]... I really appreciate what you did.  I'd rather be knocked up than caught by some nightmare because I was too horny to hide properly until the colony opened - er, not that I want to be knocked up by you, sweet as you are.</i>\"");
		
		outputText("\n\nHuh... so she's planning to hide the rest of the night?");
		outputText("\n\n\"<i>Yeah,</i>\" Sheila answers, when prompted.  \"<i>It's not really so hard, you know, in the dark.  I can just dig a hole or something.</i>\"  She squeezes your hand, then gets up.  This girl actually wants to hide alone in a hole for the entire night...");
		//[Stay With Her][Let Her Be]
		menu();
		addButton(0,"Let Her Be",sheilaXPThreeSexyTimePostSexLetHerBe);
		addButton(1,"Stay With Her",shielaXPThreeSexyTimePostSexStay);
		//choices go to XP3 20:00 event
		return;
	}
	//(else sheila xp =/= 3)
	else {
		outputText("\n\nYou lie in the sun for some time ");
		//[(norm skeet)
		if (player.cumQ() < 500) outputText("as she strokes the " + player.skinFurScales()  + " of your chest");
		else outputText("as she wipes off as much jizz as she can");
		outputText(", then get up and collect your gear.  \"<i>Um... see you later, ok?</i>\" she says.");
		doNext(camp.returnToCampUseOneHour);
	}
	//minus lust, minus small libido, if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption, low chance of sheilapreg +1 if non-dog cock or med-high chance if dog cock
	//sheilaPreg stuff
	sheilaPreg();
	sheilaCorruptionUpdate();
	/*if (player.cor > 90 || player.cor > sheilaCorruption()) {
		dynStats("cor", -10);
		sheilaCorruption(10);
	}
	else if (player.cor < sheilaCorruption()) {
		dynStats("cor", 10);
		sheilaCorruption(-10);
	}*/	
}


//[Consensual - Masturbate] (mutual masturbation for F, M, H, me, and U)
//as the name implies, you'll probably need to replicate masturbation code and have RNG pick an option to use, rerolling until it gets one compatible with PC's equipment - and then store the choice unless you want to C&P 5 different scenes
/*for example:
	-00-24: check for cocks, check cock length if centaur, if either ineligible reroll, else set a variable to{cock}
	-25-49: check for vag, reroll if centaur, else set variable to {vag}
	-50-74: check for nipplecunts; if absent reroll, else set variable to {freaky chest pussy}
	-75-99: check for playersex = U, buttslut perk, or high anal wetness, if centaur body or all absent reroll, else set variable to {asshole}
	-if RNG rerolls 100 times without resolving, halt function and check for eligible parts; if all absent, set variable to {fucking nothing}, else restart
let me know if this is totally heinous or whatever*/

//da scene
private function sheilaMutualMasturbation():void {
	clearOutput();
	var target:String = "";
	var choices:Array = new Array();
	if (player.hasCock()) {
		if ((player.isTaur() && player.tallness * (5/6) < player.cocks[player.longestCock()].cockLength) || player.hasCock()) choices[choices.length] = "cock";
	}
	if (player.hasVagina() && !player.isTaur()) choices[choices.length] = "vagina";
	if (player.hasFuckableNipples()) choices[choices.length] = "nipplecunt";
	if (player.gender == 0 || choices.length == 0) choices[choices.length] = "ass";
	
	if (choices.length == 0) 
	{
		CoC_Settings.error("");
		outputText("ERROR - SHEILA MASTURBATE BROKE, SON");
		doNext(camp.returnToCampUseOneHour);
	}
	target = choices[rand(choices.length)];
	
	outputText("You snatch Sheila's hat and pack, tossing them away, then slide a hand into the girl's shirt, slipping one of her nipples between two fingers as you nibble on her neck, and use the gentle pressure to push her onto her back.  She sighs, moving a hand under her clothes to caress yours.  \"<i>Ah,</i>\" she pants, letting out a soft puff of air, \"<i>what're we gonna do on the grass, [name]");
	if (silly()) outputText("-chan");
	outputText("?</i>\"");
	
	outputText("\n\nYou offer no answer, withdrawing from her shirt and turning your attention to her belt, which you unfasten.  With it out of the way, you unbutton her shorts and pull them down, panties and all, slipping them right off her legs.  Sheila shifts nervously and squeezes her knees together as you tug her paws free of the bottoms and cast the latter aside.  Briefly, you slide your hand into the open space between her thighs to stroke her pussy once, but then you're up again, peeling off her vest and pushing her shirt over her head, getting in a good grope on her breasts as you strip her.  With Sheila in the buff and waiting eagerly, you stand up and shuck your own [armor], dropping it carelessly.");
	
	outputText("\n\n\"<i>Hehe,</i>\" she giggles, admiring your nudity and the reckless way you've undressed her and scattered the garments.  \"<i>Fantastic; there's clothing everywhere.  You want to brush my hair, next?</i>\"");
	
	outputText("\n\nYou lie down next to Sheila");
	//[(horse)
	if (player.isTaur()) outputText(", folding your legs under you,");
	outputText(" and begin ");
	//[(adequate-length cock)
	if (target == "cock") {
		outputText("stroking your [cock], pointing it at her as you smear pre-cum onto your fingers");
	}
	//(non-horse vag)
	else if (target == "cunt") outputText(" sliding your hand to your [vagina], parting your lips with two fingers");
	//(gross-ass nipcunts)
	else if (target == "nipplecunt") outputText("plunging your fingers into one of your awkward, distended nipples");
	//(Unsexed non-centaur only)
	else if (target == "ass" && !player.isTaur()) outputText("licking a finger and teasing your asshole with shallow strokes, gently circling the ring");
	//(centaur who hasn't got shit)
	else outputText("sucking a single digit salaciously, fingerfucking your mouth and coating it with saliva");
	outputText(".  \"<i>Oh... are you going to touch me, or just play with that?</i>\" Sheila asks, grinning.");
	
	outputText("\n\n\"<i>The latter,</i>\" you answer with a sly smile.  A particularly deep pump sends an anticipatory shiver through you as Sheila's smile fades.");
	
	outputText("\n\n\"<i>[name]...</i>\" she begins dubiously.  You cut her off with your other hand, held out, and she warily places hers in it.  Smiling, you lift it to your lips, smothering it in kisses and tracing on it with your wet finger.  Sheila giggles, but with restraint, still unsure about your methods.  Once you've finished playing with her hand, you tuck it between her thighs, cupping it and forcing two of her digits into her pussy.  \"<i>Ah, ah, ahh,</i>\" Sheila gasps, \"<i>what are you doing?</i>\"");

	
	outputText("\n\n\"<i>Making sure you know how to fool around,</i>\" you tease.  \"<i>Use your imagination.</i>\"  Sheila blushes at that, allowing you to sink her fingers into her pussy with increasing vigor.  Just as she starts to moan, you pull your hand away, returning it to duty on your own body.  Her eyes sink, but as you ");
	if (target == "cock") outputText("begin stroking your shaft, drooling pre-cum onto her skin and ");
	//(non-horse vag)
	else if (target == "cunt") outputText("demonstrate by slipping your fingers into your own [vagina] and ");
	outputText("sigh in arousal, she follows your lead and begins rubbing at herself.  You wait, toying with yourself until her face flushes, and then lean in, stealing a kiss.  The girl closes her eyes and moans openly into your mouth as you part her lips with your tongue, and then you pull away, leaving her breathless.  \"<i>Think you can use this to make your own fantasy world?</i>\" you ask.");
	
	outputText("\n\n\"<i>Maybe,</i>\" Sheila answers, \"<i>if you kiss me here... or touch me there...</i>\"  She slips her free hand first to a breast and then her midriff, encouraging you to play along, and you lower your lips to her chest, pressing them down just above the nipple while caressing her stomach.  Your fingers leave little trails of your fluids on her hot skin as you play with her body, and her long neck stretches as she tilts her head back and pushes her chest toward you.  \"<i>Ah... ah... yeah,</i>\" the girl moans rhythmically.");
	
	outputText("\n\n\"<i>So, are you just going to make me do whatever you please?</i>\" you ask, before rolling her firm little nipple on your tongue.  ");
	//[(if using eligible cock)
	if (target == "cock") outputText("You return your hand to your [cock], pumping vigorously to catch up to your lover, spurred onward by the smooth skin she presses into your lips.");
	//(else if nonhorse vag)
	else if (target == "cunt") outputText("You slide your hand between your [legs] again, intent on recovering the march Sheila's stolen on you, and begin rubbing your [clit] vigorously while sighing into her breast.");
	//(else if RNG disgusting nipplecunts)
	else if (target == "nipplecunt") outputText("Your hand returns to your chest, slipping inside the sensitive flesh of your nipple, and you groan into Sheila's as a trickle of moisture falls from your chest.");
	//(else if non-centaur asshole)
	else if (!player.isTaur()) outputText("Your hand reaches back to your [asshole], neglected for too long, and a finger spears your pucker, stroking the nerves inside as you hurry to bring your arousal in line with Sheila's.");
	///(else if fucking nothing)
	else {
		outputText("You wish you had something to play with as you watch your lover writhe under you");
		//[(silly), even just a paperclip].]
		if (silly()) outputText(", even just a paperclip");
		outputText(".");
	}
	
	outputText("\n\nSheila places a hand alongside your head even as she gasps and shoves her fingers deep inside her pussy.  \"<i>[name], as long as you'll touch me like this, I'll be your star; I'll beg on my knees!</i>\"  Her hand moves irregularly now, as her hips jerk and swivel");
	//[(if fucking nothing)
	if (target != "cock" && target != "cunt" && target != "nipplecunt") outputText(", and yours joins her, slipping into her entrance alongside");
	outputText(".  \"<i>Just... say I'm always yours!</i>\"  She turns you toward her face again, locking you in a kiss, and your ");
	//[(if cock)
	if (target == "cock") {
		if (player.cockTotal() == 1) outputText("prick begins");
		else outputText("pricks begin");
		outputText(" to twitch, ejaculating a stroke onto Sheila's midriff and wrist.  The girl groans in your mouth at the new heat, and her body shakes in orgasm.");
	}
	//(vag)
	else if (target == "cunt") {
		outputText("pussy convulses, ");
		if (player.wetness() < 4) outputText("drooling");
		else outputText("squirting");
		outputText(" around your hand.  As your body shakes and your lips rattle against Sheila's, she shivers and her own orgasm begins.");
	}
	//(nipcunts)
	else if (target == "nipplecunt") {
		outputText("nipple constricts around your fingers in climax, oozing lubrication onto your partner.  As the drops from your " + player.breastDescript(0) + " hit her own, Sheila's back arches again and her own orgasm begins.");
	}
	//(jack shit)
	else outputText("fingers are pulled into her vagina by her muscles as her orgasm begins.");
	//[( pc corr >= 90 or > sheila corruption) 
	if (player.cor >= 90 || player.cor > flags[kFLAGS.SHEILA_CORRUPTION]) {
		outputText("\n\nHer lips seem to draw yours in when she comes, until it feels like you've been pressing them into her since time began; her chest rises as she sucks, and you can clearly see her breasts swelling up - it's too much to bear, and you grab one with your free hand and squeeze.  Sheila answers you by sticking her tongue even deeper into your mouth.");
	}
	//(else pc corr < sheila corruption)
	else if (player.cor < flags[kFLAGS.SHEILA_CORRUPTION]) {
		outputText("\n\nThe kiss breaks as the girl loses muscle control, and she leans forward, pressing her forehead into yours and looking up into your eyes with a smile and a  heavy-lidded stare.  She shivers again, and you can feel heat gathering in your face and fogging your brain even as she seems to curl up in your arms.");
	}
	//(else if equal corr but under 90)
	else {
		outputText("She breaks the kiss, drawing her hand from her pussy, and holds your head in front of her; her eyes soften with affection as she shudders.");
		//[(not jack shit)
		if (target == "cunt" || target == "cock" || target == "nipplecunt") outputText("  Emptying your reserves, you allow yourself to fall into her arms, resting your head on her chest.");
	}
	
	//if not fucking nothing, reduce lust and reset hours since cum; if sheila corr = 90 and pc corr >= 90, go to demonization, else continue
	if (target == "cunt" || target == "cock" || target == "nipplecunt") player.orgasm();
	else dynStats("lus", 50);
	if (player.cor >= 90 && sheilaCorruption() >= 90) {
		menu();
		addButton(0,"Next",sheilaGoesDemon);
		return;
	}
	//[(corruption threshold warning if sheila corruption >= 80 and PC corr > sheila corruption and sheila xp =/= 3)
	else if ((player.cor > 90 || player.cor > sheilaCorruption()) && sheilaCorruption() >= 80 && flags[kFLAGS.SHEILA_XP] != 3) {
		sheilaCorruptionUpdate();
		/*if (player.cor > 90 || player.cor > sheilaCorruption()) {
			dynStats("cor", -10);
			sheilaCorruption(10);
		}
		else if (player.cor < sheilaCorruption()) {
			dynStats("cor", 10);
			sheilaCorruption(-10);
		}*/
		outputText("\n\n\"<i>Oh god, my tits!  They look like they belong on some blond bimbo girl!</i>\"");
		
		outputText("\n\nThey certainly do, at that.  You feel like jumping into them and doing this again, but settle for giving one a healthy rub.  Sheila's lower lip quivers with momentary abandon, but she slaps your hand away.");
		
		outputText("\n\n\"<i>Stop it, [name]!  How much demonic energy are you even carrying?</i>\"  Your head lifts from her massive mounds curiously as your hand moves back to them.  In post-climactic bliss, you can't even think why that would be an issue - her words just sing in your head.  \"<i>I said stop!  I'm not your dolly, and you can't make my clothes as tight as you please!  I can't keep sucking corruption out of you and still be able to relate to normal people...</i>\"");

		outputText("\n\nWell... what's so great about normal people?  Normal people have boring normal lives.  One more party shouldn't hurt, should it?  Come on, let's go...");

		//[Listen to Her][Fondle Her]
		menu();
		addButton(0,"Listen2Her",sheilaCorruptionWarningListenToHer);
		addButton(1,"Fondle Her",sheilaCorruptionWarningsChooseFondle);
		//choices go to corruption warning texts
		return;
	}
	//(else no corruption warning triggered)
	else {
		sheilaCorruptionUpdate();
		/*
		if (player.cor > 90 || player.cor > sheilaCorruption()) {
			dynStats("cor", -10);
			sheilaCorruption(10);
		}
		else if (player.cor < sheilaCorruption()) {
			dynStats("cor", 10);
			sheilaCorruption(-10);
		}*/
		outputText("\n\nSheila strokes your " + player.hairDescript() + " as you lie ");
		if (target == "cock") outputText("there, staring at the load you left in her bellybutton");
		else outputText("together");
		outputText(".  \"<i>Oh, I had so much fun, mate.");
		//[(if sex =U and sillymode)
		if (player.gender == 0 && silly()) outputText("  I love you, my Ken doll.");
		outputText("</i>\"");
		//[(if sheila xp = 3)
		if (flags[kFLAGS.SHEILA_XP] == 3) {
			outputText("\n\nShe sighs and slips out from under you.");
			outputText("\n\n\"<i>What's up?</i>\" you ask, sitting up.");
			outputText("\n\n\"<i>Still gotta find a place to hide tonight,</i>\" Sheila replies.  \"<i>Then I can hit the town again in the morning.  I'll remember you the next time I feel like hanky-panky, though.</i>\"  The girl's cheeks color a bit.");
			outputText("\n\nHuh, she's really going to spend the night alone.");
			
			//[Stay With Her][Let Her Go]
			//choices go to XP3 section
			menu();
			addButton(0,"Let Her Be",sheilaXPThreeSexyTimePostSexLetHerBe);
			addButton(1,"Stay With Her",shielaXPThreeSexyTimePostSexStay);
			return;
		}
		else {
			outputText("\n\nShe nuzzles you in the affection borne of climax, until she pulls away and gets up.  \"<i>I wish I could stay and talk, but my civic duty's making me walk,</i>\" Sheila offers apologetically.  She gathers her scattered clothing and, with a little wave, leaves.");
		}
	}
	doNext(camp.returnToCampUseOneHour);
}

//corruption warning texts (redirected from here when Sheila corruption is about to hit 90)
//[Any Corruption Warning - Fondle Her]
private function sheilaCorruptionWarningsChooseFondle():void {
	clearOutput();
	outputText("Fuck it.  You move your hand right to her entrance.  \"<i>Don't be like that...</i>\" you say softly into her neck.  She shivers under your touch as her resistance begins to subside, and you slide two fingers into her gently.  \"<i>No,</i>\" she says quietly, and then, as you slip in, \"<i>NO!</i>\"  Violently coming to herself, she pushes you away and scrambles to her feet.");
	
	outputText("\n\n\"<i>That's it, [name]!  Bloody well listen when I speak!  I can NOT do this again with you while you are like this or I will fall over the edge and never come back!  I need to get myself under control and I don't need you making it harder, so rack off if you don't get that!</i>\"");
	
	outputText("\n\nShe turns her back on you and walks away briskly with her clothes, leaving you ");
	if (player.hasCock()) outputText("erect");
	else if (player.hasVagina()) outputText("wet");
	else outputText("aching");
	outputText(".  Even as she goes, you can still see the edges of her amazing, swaying rack around the sides of her torso.");
	
	outputText("\n\nBitch tease.");
	//set sheila xp to -3 and sheila corruption to 90, PC corr - 10
	flags[kFLAGS.SHEILA_XP] = -3;
	flags[kFLAGS.SHEILA_CORRUPTION] = 90;
	dynStats("cor", -10);
	doNext(camp.returnToCampUseOneHour);
}

//[Any Corruption Warning - Listen to Her]
private function sheilaCorruptionWarningListenToHer():void {
	clearOutput();
	outputText("\"<i>So...</i>\" you answer, your feel frozen in mid-cop, \"<i>what?</i>\"");
	
	outputText("\n\nSheila stares at you for a long minute.  \"<i>[name], I like you more than anyone I've ever known.  I don't want to stop seeing you.  But we can NOT have sex again while you are tainted like this.  Do you understand?  I will not be able to think about anything but rooting, ever, if we do.  I do not want to be some brainless, demonic wombat!</i>\"");
	
	outputText("\n\nShe looks pointedly down at your hand, and you remove it.");
	
	outputText("\n\n\"<i>Thank you,</i>\" she says.  With a peck on your cheek, she stands up and gathers her clothes, then sighs.  \"<i>I know it's not just your fault; it takes two to tango.  I'm going to try to get myself under control for these next couple of weeks.  Please, please do the same.  When I feel like I'm ready, you'll see me again.  I... love you.  Bye.</i>\"");
	//no change in sheila corruption (remains at 80), PC corr -10, set sheila clock = -13
	dynStats("lus", -10);
	flags[kFLAGS.SHEILA_CLOCK] = -4;
	doNext(camp.returnToCampUseOneHour);
}


//normal Sheila combat aftermath quick reference:
//- if Sheila XP >= -1 and PC runs or wins without sexing, set Sheila XP = -1
//- if sheila wins with lust>75, sheila rapes PC; if Sheila XP >= -3, set Sheila xp to -2
//- if PC wins and rapes Sheila, generally set Sheila XP to - 4

//victory rapin' on normal Sheila:
internal function sheilaGotWhomped():void {
	clearOutput();
	outputText("Sheila collapses, ");
	//[(HP)
	if (monster.HP < 1) outputText("completely spread-eagled from her injuries");
	///(lust)
	else outputText("rubbing her thighs together and smearing around the moisture from her pussy");
	outputText(".  As you stand over her, she forces herself to her elbows and tries to scoot away from you, fear written on her face.  \"<i>I'm sorry... please, no...");
	//[(sheila xp > -4)
	if (flags[kFLAGS.SHEILA_XP] > -4) outputText("  I'll forgive you for everything else, but please, not this!");
	outputText("</i>\" she implores.");
	//[(sheila corruption >= 90)
	if (sheilaCorruption() >= 90) outputText("  \"<i>I-if you touch me again... god, I can't even think straight anymore!  Don't do this!</i>\"");
	//(lust >= 30)
	if (player.lust >= 33) outputText("\n\nWill you take advantage of the terrified girl or let her go?");
	else outputText("\n\nYou're not really horny enough to take advantage of her, anyway...");
	
	//[Rape Pussy][Forced Oral][Dildo Time][Let Her Go]
	//Let Her Go is default choice if player hits spacebar or has PC lust < 30/no qualified options
	menu();
	if (player.lust >= 33) {
		if (player.hasCock() && player.cockThatFits(48) >= 0) addButton(0,"Fuck Pussy",rapeSheilasCooter);
		if (player.hasCock()) {
			if ((!player.isTaur() && player.shortestCockLength() <= player.tallness * .35) || (player.isTaur() && player.tallness * 1.2 <= player.shortestCockLength() && player.shortestCockLength() <= player.tallness * 1.55))
			{
				addButton(1,"Forced BJ",forcedSheilaOral,true);
			}
		}
		if (player.hasVagina()) addButton(2,"Forced Lick",forcedSheilaOral,false);
	}
	addButton(14,"Leave",letSheilaGo);
}
//if choosing Let Her Go and sheila xp > -3, set sheila xp = -1, then give xp/gems and Next button to camp
private function letSheilaGo():void {
	if (flags[kFLAGS.SHEILA_XP] >= -3) flags[kFLAGS.SHEILA_XP] = -1;
	combat.cleanupAfterCombat();
}

//[Victory Rapin' - Rape Pussy] - uses cockarea <= 48:
private function rapeSheilasCooter():void {
	clearOutput();
	//set sheila xp = -4
	flags[kFLAGS.SHEILA_XP] = -4;
	var x:int = player.cockThatFits(48);
	
	outputText("You grab the girl by her fuzzy leg; she tries to kick away from you, but you pull her back, pinning her");
	//[(horse)
	if (player.isTaur()) outputText(" by planting your forehooves just above her hips");
	outputText(".  Reaching down, you take the neck of her shirt in your hand, then rip it open, exposing her ");
	//[(sheila corruption < 30)
	if (sheilaCorruption() < 30) outputText("tiny ");
	//sheila corruption > 60)
	else if (sheilaCorruption() > 60) outputText("huge, soft ");
	outputText("breasts, which jiggle from the force.  She tries to cover herself with her arms, but you grab and pull them aside, revealing her chest again.  As you appraise her naked flesh, she looks away, shame coloring her cheek.  Her mouth tightens and her eyes shut as you squeeze her tits roughly, flicking the nipples until they're erect.");
	
	outputText("\n\nSliding down her body a bit, you devote your attention to her waist, unfastening her belt and unbuttoning her dusty shorts.  A triangle of white fabric greets you as you pull the flaps apart, and you tug the bottoms down quickly to expose her panties.  You place one finger at the entrance to her pussy, ");
	//[(monster HP < 1)
	if (monster.HP < 1) outputText("sliding it between her labia and producing a damp spot, then ");
	outputText("dragging the wet fabric around her vulva.");
	
	outputText("\n\nSatisfying yourself as to her readiness, you unfasten your [armor] to extract your [cockFit 48]; the " + player.cockHead(x) + " drips with pre-cum as you pull it loose, and you lay it on her crotch, letting the goo soak the white fabric until you can see her light-brown skin through it.  She squirms under it, bringing up another droplet with her motion, and you place the tip at the entrance to her pussy, pressing eagerly against the fabric.  \"<i>Please...</i>\" she whimpers, \"<i>I'm begging you; don't.</i>\"");
	
	//fuck-fork
	//[(corruption < 50)
	if (player.cor < 50) {
		outputText("\n\nYou frown at the girl.  She still wants to escape, even though her body is eager for this?  You can feel her wet pussy twitching at your " + player.cockHead(x) + ".  Dragging the oozing tip along her soaked panties provokes a shiver and another bloom of fluid from the girl, but she bites her lip and refuses to meet your eye.");
		outputText("\n\n\"<i>Are you serious?</i>\" you ask, thrusting gently to part her labia and push the sodden cloth into her.  You can already see every outline of her pussy though it.");
		
		outputText("\n\n\"<i>Y-yes...</i>\" she moans, \"<i>please don't touch my skin.  Through the fabric is fine, if you must, but please... don't put it inside!</i>\"  What a strange thing to ask... you narrow your eyes at her, but she actually meets your gaze now that you've heard her out.  Honest desperation is all over her flushed face; she's really serious about this!");
		
		outputText("\n\nMan, whatever.  Experimentally, you push in again, testing how far her panties will let you go, and her labia accept you smoothly, rubbing the fabric against your " + player.cockHead(x) + ".  With lips spread open, even her small clitoris can be felt through the cloth, and you take the opportunity to rub at it");
		if (player.isTaur()) outputText(" with your belly");
		outputText(", to be answered with a shy gasp from the girl and the soft, welcoming feeling of her vagina coating your tip with a new layer of moisture.  Covered in warm, slick fluids, the panties feel pretty good against your dick... you could actually get off like this.  \"<i>Move your hips,</i>\" you command hesitantly, \"<i>make this fun for me.</i>\"  Her uncertain eyes light up when she understands that you're accepting her conditions, and she parts her thighs wide to gyrate against you, using the end of your prick to caress her small genitalia through the nearly-transparent panties.");
		
		outputText("\n\n\"<i>Is this... okay?</i>\" Sheila asks, grinding the cloth-covered hole of her vagina against your slit and smearing the drop of pre-cum that issues from it.  You want to say no, to pretend like it's not enough, but the way her tight, clothed vulva is rubbing at the nerve-laden end of your prick is robbing you of your words.  Heat is transmitting to you through the soaked fabric as her body temperature rises; the lewd girl actually begins to grab at her tits and caress herself now that you've granted her a reprieve from whatever it is she was worried about.  Her skin reddens as her body heats up, and she begins to let out soft moans as she pushes harder against your shaft, nearly - but not completely - taking the head inside her pussy.  \"<i>Ah...!  N-no... gonna come!</i>\"  As her labia squeeze your cock hungrily, you feel the same way.");
		
		outputText("\n\nHer knees clasp around you until she remembers her injunction against skin contact and forces them apart again; her hands, which she had reached out to you briefly, are pulled back as her arms fold tightly against her chest, pressing her breasts together.  \"<i>S-sorry!</i>\" she cries, and you feel her drooling through the panties as she spasms.  At your limit as well, you slide your " + player.cockHead(x) + " down to the entrance to her vagina and push it partway in, rubbing the tip against the fabric to work the nerves and cross the last step to your own orgasm.");
		
		outputText("\n\n\"<i>Take it out!</i>\" the girl wails, still shaking with climax.  \"<i>D-don't come in me!</i>\"");
		
		outputText("\n\n\"<i>Shut up,</i>\" you retort, through gritted teeth, \"<i>I gave you what you wanted, now do the same for me!</i>\"  Your [cockFit 48] twitches and your muscles quake as the first stroke of semen erupts; it takes all your effort to hold yourself up and avoid sinking onto your lover while the permeable barrier of her panties collects its toll from your spilling cum, thickening with the goo you pump into the girl.  She reddens as your warm seed squirts through the fabric to invade her body, but makes no further protest.");
		//[(big skeet)
		if (player.cumQ() >= 500) outputText("  Soon you've filled her as fully as the shallow penetration will allow, and the panties begin to press back against your cock, oozing onto you whatever semen the porous dam can't contain.");
		//(mega skeet)
		else if (player.cumQ() >= 1500) outputText("  It sags and bows around the tip of your spear, pulsing with each new stroke as the hemlines leak jizz onto her legs and butt.");
		outputText("  Idly, you imagine what it must look like inside, each squirt having its momentum arrested by the cloth, drooling lazily into her until the next one displaces it a bit further forward, and wonder if it'll be enough to get her pregnant.  You pull away from the girl, leaving her gasping and once again averting her gaze.");
		
		outputText("\n\nShe attempts to stand, holding her midriff and looking at you unhappily.  ");
		//[(big skeet)
		if (player.cumQ() >= 500) outputText("So much cum fills her pussy that it slips out, once again restoring the opacity, though not the dryness, of her panties.  ");
		outputText("You return her gaze, turning your nose up dismissively.  Conscious of her nudity, she pulls up her shorts and buttons her vest to conceal herself as you leave her behind.");
		//end scene, sheilapreg check, reduce lust and libido
		sheilaPreg();
		player.orgasm();
		dynStats("lib", -1);
	}
	else {
		outputText("\n\n\"<i>Why shouldn't I?</i>\"  You back away and slip a hand into her panties, letting the fingertips dangle against her opening; every inch of her flesh is hot with arousal, betraying her words.  Even her pussy lips stroke and caress your fingers gently.  \"<i>The only part of you that doesn't want this is your lying mouth.</i>\"");
		
		outputText("\n\nSheila shivers and tries to speak again, but her head jerks as you crook your fingers abruptly into her, then yank your hand back.  Her panties stretch as you tug, taut against her ass.  \"<i>S-stop!</i>\" she cries.  \"<i>Please!</i>\"");
		
		outputText("\n\n\"<i>No.</i>\"  Tensing your arm, you pull harder, and the sound of ripping fabric fills the space between you as her panties tear in half.  Casting the ruined garment away, you resume your position, jabbing at her vulva with your [cockFit 48]; it drools lubrication over your tip as you nose into it, reinforcing your decision.");
		
		outputText("\n\nThe girl's struggles resume as you finally push in, spurred on by the intimate contact");
		if (player.cockArea(x) > 32) outputText(" and the pain of taking a cock slightly too large for her");
		outputText(", and she actually rears back to scratch at you with her fingernails.  You catch her hand and hold it, and she responds by spitting at you!  \"<i>Fuck you, arsehole!</i>\" Sheila shrieks.  \"<i>Take it out!</i>\"  Reaching down, you slap her in the face.");
		
		outputText("\n\n\"<i>No,</i>\" you repeat, as the shamed girl stares off to the side.  You thrust in all the way, sending a vibration through her body that");
		//[(sheila corruption > 10)
		if (sheilaCorruption() > 10) outputText(" jiggles her breasts and");
		outputText(" clenches her jaw.  A bloom of red colors her cheeks, one brighter than the other from the blow... though she still refuses to look at you.  Doesn't matter; having sex.  You begin to pump her pussy vigorously, the wetness enough to allow quick, smooth thrusts without any warmup.  \"<i>You're a godawful liar,</i>\" you grunt");
		//[(not centaur)
		if (!player.isTaur()) outputText(", leaning down to kiss her long neck and collarbone");
		outputText(".  Sheila quivers again, still looking away, as you continue.  \"<i>I can actually feel you stroking me with your vagina already.  Are you going to come soon?  Will you tell me how much you're hating this when you do, and wrap your legs around me to punish me by holding me inside?</i>\"  The girl's blush deepens, and she bites her lip in embarrassment.  Confidently, you release her hand");
		//[(nothors)
		if (!player.isTaur()) outputText(", transferring yours to her breast while brushing her torn shirt to the side");
		outputText("; without struggling further, she slowly lowers it");
		//[(nothors)
		if (!player.isTaur()) outputText(" to rest atop your own");
		outputText(", confirming your suspicion.  Her eyes close and her chin raises resignedly");
		//[(nothors)
		if (!player.isTaur()) outputText(" as you triumphantly squeeze the flesh in your hand and kiss her under the jaw");
		outputText(".");
		
		outputText("\n\nThe rough fuck won't last much longer; you can feel your orgasm drawing close and the lewd squelches of your lover's pussy suggest you're not alone.  \"<i>Please...</i>\" she whispers, almost unheard.  You lean closer and wait for her to speak again.  \"<i>Please... pull out...</i>\"");
		
		outputText("\n\nAlmost affectionately, you ");
		//[(mans)
		if (!player.isTaur()) outputText("place a hand along her face, tuning it toward you, and kiss her on the lips.");
		else outputText("bend down, lowering your torso until you can caress her cheek.");
		outputText("  \"<i>Of course I won't,</i>\" you answer sweetly.  \"<i>What would be the point?</i>\"  Sheila winces as you hilt yourself, sinking your [cockFit 48] so far into her that your crotch meets hers.  You shudder");
		//[(nonhors)
		if (!player.isTaur()) outputText(" and squeeze her breast");
		outputText(" as your climax arrives and the first of your seed pours into her grasping pussy.  While you fill her, her back arches");
		//[(nonhors) 
		if (!player.isTaur()) outputText(" and she presses your hand uncomfortably");
		outputText(", gasping as her own orgasm begins.  Her knees wrap around your sides, satisfying your predicition, and her vagina");
		//[(pc corr >= 90 or > sheila corruption)
		if (player.cor >= 90 || sheilaCorruption() < player.cor) {
			outputText(" pulls greedily at your [cockFit 48], drinking up your semen as fast as you can squirt it.  She sucks in breath as she climaxes, finally opening her eyes as her head tilts back");
			//[(nonhors)
			if (!player.isTaur()) outputText("; you can almost feel her breast heating up and swelling with blood under your hand, as the nipple pokes into your palm");
			outputText(".");
		}
		//(PC corr < sheila corruption)
		else if (player.cor < sheilaCorruption()) {
			outputText(" floods you with juices, dumping so much around your twitching cock that you feel like you're lowering it into a hot spring.");
			//[(nonhors)
			if (!player.isTaur()) outputText("  She squeezes your hand so hard that you swear you can feel her breast compressing under it as she screams her pleasure.");
		}
		//(else equal but < 90)
		else {
			outputText(" drools eagerly as you mingle your juices with hers, until the fluid begins to thicken with white seed.");
		}
		//[(big skeet)
		if (player.cumQ() >= 500) outputText("  Overabundant as always, your semen quickly fills her to capacity and begins to squirt out around your shaft, staining her thighs.");
		//[(multicock)
		if (player.cockTotal() > 1 ) {
			outputText("  Your other ");
			if (player.cockTotal() == 2) outputText("dick spits");
			else outputText("dicks spit");
			outputText(" as well, leaving trails all over her light-brown skin.");
		}
		outputText("\n\n\"<i>Haha,</i>\" you laugh softly.  \"<i>You wanted this as much as I thought.</i>\"");
		//if sheila corr >= 90 and PC corr > 90, go to demonization scene, else continue
		if (sheilaCorruption() >= 90 && player.cor >= 90) {
			menu();
			addButton(0,"Next",sheilaGoesDemon);
			return;
		}
		outputText("\n\nSheila pulls away from you wordlessly, then buttons her vest to hide her breasts and pulls up her shorts, flinching as the rough fabric touches her unprotected, sensitized crotch.  Once clothed again, she finally looks at you - not with anger, as you expect, but with a pained frown of resigned, familiar disappointment.  Huffing, you re-dress and leave the girl behind.");
		//end scene, sheilapreg check, lose lust and libido, if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption
		//pregcheck
		sheilaPreg();
		player.orgasm();
		dynStats("lib", -1);
		sheilaCorruptionUpdate();
		/*if (player.cor > 90 || player.cor > sheilaCorruption()) {
			dynStats("cor", -10);
			sheilaCorruption(10);
		}
		else if (player.cor < sheilaCorruption()) {
			dynStats("cor", 10);
			sheilaCorruption(-10);
		}*/
	}
	combat.cleanupAfterCombat();
}

//[Victory Rapin' - Forced Oral] - no corruption transfer, but adds some to PC
//it's fine if you make two different buttons for the male and female branches, but both should indicate that this is forced
private function forcedSheilaOral(dick:Boolean = true):void {
	clearOutput();
	//set sheila xp = -4
	flags[kFLAGS.SHEILA_XP] = -4;
	outputText("You lean down and grab the girl by her shirt-front, raising her to her knees; her hands automatically go to yours.");
	
	outputText("\n\n\"<i>Let go!</i>\" she shrieks, trying to pull free of your grip.");
	
	outputText("\n\n\"<i>Now, now; calm yourself,</i>\" you admonish.  Your other hand slips up her shirt, caressing her stomach and searching out her");
	//[(sheila corruption >= 50
	if (sheilaCorruption() >= 50) outputText("soft, pillowy");
	else outputText("small, perky");
	outputText(" breast.  \"<i>You don't want to rip your clothes, do you?  It must be difficult to get nice fabric like this out here in the middle of nowhere.</i>\"");
	
	outputText("\n\nSheila shudders as you squeeze, then gasps sharply when you rub her areola with two fingers.  \"<i>N-no,</i>\" she whimpers, trying to pull away from your hand.");
	
	outputText("\n\n\"<i>Of course you don't,</i>\" you interrupt smoothly, deliberately misinterpreting her answer.  \"<i>Let's just get them out of the way...</i>\"  You withdraw your hand; she looks almost disappointed at its absence as you slip the vest from her shoulders and take a better look at her breasts, ");
	//[(sheila corruption < 20)]
	if (sheilaCorruption() < 20) outputText("little round things that trace gentle curves under her loose shirt.");
	//(else sheila corruption < 50)
	else if (sheilaCorruption() < 50) outputText("healthy mounds that fill out her shirt.");
	else outputText("swollen globes that bulge over her v-neck and strain at the seams of her shirt.");
	outputText("  Smiling at the sight, you grab the garment's hem and pull it up roughly.  Sheila blinks dumbly as you expose her erect nipples to the air, then blushes and covers them with her hands.");
	
	outputText("\n\nStill smiling, you unfasten your [armor] and reveal your crotch.  ");
	//[(cock.length > 0)
	if (dick) outputText(player.SMultiCockDesc() + " flops free, half-erect and swelling steadily with blood as you appraise the woman's body.");
	//(vag present)
	else outputText("Your [vagina] drools slightly, labia parting and [clit] poking up; you imagine what you want to do with it.");
	outputText("  Sheila watches your face as you slip into a fantasy, half-playing with her nipples - but just when you start to get into your daydream, she turns and tries to scramble to her feet!");
	
	//begin encounter forking - Difficulty Level: Hell
	//forced fellatio branch, for cocks sticking out <= arm length
	//[(if not horse and smallest cock length <= 35% of height OR if horse and 120% of height <= smallest cock length <= 155% of height)
	if (dick) {
		outputText("\n\nYou seize the girl by her hair, cutting off her escape and depositing her in front of you once again.  Still holding her tight, you guide her shut mouth to the tip of your [cock shortest].  \"<i>Oral,</i>\" you demand tersely, grabbing your shaft and smearing her lips with the pre-cum you're beginning to drip.  Sheila's eyes close like her mouth and she tries to pull away, but you shake her until she's looking at you again and point at your cock insistently.  \"<i>Oral,</i>\" you repeat, pulling her hair harder.  \"<i>Or we can slip you out of those pants instead, if you prefer...</i>\"");
		
		outputText("\n\nHer mouth opens in either pain or alarm; you take advantage of the accommodation and shove your prick at it, ");
		//[(cock width <= 6")
		if (player.cocks[player.shortestCockIndex()].cockThickness <= 6) {
			outputText("parting her lips to pop neatly between them.  It feels good, but one-sided, and you order Sheila to get to work.");
		}
		else {
			outputText("jabbing at her undersized mouth with your enormous [cockHead shortest].  \"<i>It's too thick!</i>\" she complains, trying to turn away.");
			outputText("\n\n\"<i>So?  Think of something, then!</i>\"  You drag her face along the tip of your penis, smearing her lips and cheeks with pre-cum, and she eventually gives up, taking your shaft in her hands for control and playing her tongue over and down your urethra.  Your shudder comes simultaneously with hers... though hers is more probably from humiliation.");
		}
		outputText("  The reticent woman brings her lips into play, sucking gingerly, ");
		//start length fork, no new PG
		//[(dick length <= 8)
		if (player.cocks[player.shortestCockIndex()].cockLength <= 8) {
			outputText("and the warm embrace of her mouth is welcome stimulation.");
			outputText("\n\n\"<i>G-good,</i>\" you encourage, \"<i>use your tongue more!</i>\"  Sheila obliges, rubbing the breadth of the little pink muscle along the underside of your glans.  One of her hands slides up your body, stroking ");
			if (player.balls > 0) outputText("your [sack]");
			else outputText("the base of your shaft");
			outputText(", and the other hesitantly makes its way to her breasts as she gets into the sex.  The woman tweaks her nipple, softly at first but with mounting passion as her attentions on your dick become more lavish.  Catching this from the corner of your eye, you move ");
			if (!player.isNaga()) outputText("a [foot]");
			else outputText("the tip of your tail");
			outputText(" between her knees to her crotch, rubbing her pussy through her shorts; Sheila hums into your shaft as a wet spot appears on the cloth, and begins grinding her hips against the pressure.  You answer her enthusiasm by taking her head in your hands and stroking the surface of her long, pointed ears affectionately with your thumbs.  She flushes, then sinks down on your cock, rubbing the nerves on the slit with the back of her tongue and pulling you closer to orgasm.");
			
			outputText("\n\n\"<i>So you like having your ears touched?</i>\" you ask, shuddering and stroking them again.");
			
			outputText("\n\nSheila withdraws your dick from her mouth to speak, looking up at you with a shy half-smile - but then freezes.  Her eyes widen and the color drains from her face as she returns to the present.  \"<i>N-no...</i>\" she replies, looking away in shame.  Her hips still and her one hand drops away from her breast; the motion of the other becomes mechanical again, changing from affectionate caresses to simple strokes up and down your shaft with none of the feeling from before.  \"<i>Please, just... finish and let me go.</i>\"");
			
			outputText("\n\nOh, for fuck's sake... and just as it was starting to warm up.  \"<i>Fine!</i>\" you grunt.  Glowering, you tighten your grip, pressing her ears flush against her head; she flinches at the rough contact, but you pull her forward and ram her mouth into your dick, intent on making up the progress you lost from her frigid behavior.  Mashing your pelvis against her, you face-fuck the girl, using her mouth like any wet cunt; it doesn't take long before the soft lips and tongue on your prick tease you to climax, and Sheila begins to panic as your cock twitches");
			if (player.balls > 0) outputText(" and your [balls] tighten up");
			outputText(".  She pushes against you with her hands, trying to get free, but you just hold her against your crotch as you lean over her head.");
		}
		//(else dick length > 8)
		else {
			outputText("but this sort of half-assed attention won't get you off any time before sundown.");
			
			outputText("\n\n\"<i>God,</i>\" you groan, \"<i>you're terrible at this.</i>\"  Sheila's eyes widen with concern and her palms turn toward you in a futile defensive gesture, but too late; ");
			//start width fork, no new PG
			//[(cock width <= 6)
			if (player.cocks[player.shortestCockIndex()].cockThickness <= 6) {
				outputText("you grab her by both ears and force your [cock shortest] down her throat!  You can feel her esophageal muscles rippling around you as she gags and retches, and you pull it out again to be sure she's not going to throw up on your dick.  Nothing seems forthcoming, so you drag her head forward again, once more sliding into the convulsing warmth of her throat.  A groan escapes you as it closes around your crown; her squeezing passageway feels for all the world like a tight cunt, and your eager hips begin to use it as exactly that, pumping in and out of Sheila as she shudders and struggles weakly.");
				outputText("\n\n\"<i>Maybe,</i>\" you grunt, \"<i>you should work on your oral skills if you don't want to get fucked in the pussy.  As long as you stuff the cocks in your mouth before they can get your pants off, it won't matter that you can't fight for shit.</i>\"  Sheila looks at you with wet, resentful eyes, but you simply increase the force of your thrusts, pulling her head forward to have a straighter angle down her throat.  You can feel your climax bubbling as you coat her passage with smears of slippery pre-cum and push your prick into it, working the wet hole - as can she.  When your dick twitches");
				if (player.balls > 0) outputText(" and your [balls] begin to rise");
				outputText(", the woman starts to panic, re-upping her struggle to push away from you.");
			}
			///(else width > 6)
			else {
				outputText("you grab the shaft and stroke once, forcing out a truly impressive dollop of backed-up pre-cum that dribbles onto Sheila's face and into her open maw.  The woman coughs and sputters, drooling the slick fluid from mouth and nose, then tries to scrub it away with the back of her hand; she only succeeds in smearing it into a complete mess.");
				
				outputText("\n\n\"<i>That's a good look for you,</i>\" you taunt, stroking your [cock] vigorously while you hold her in position to receive her painting.  She tries to pull away as the next drop beads and oozes down the trail blazed by the first, but settles for closing her eyes tightly and whimpering when your grip on her ear tightens painfully.");
				outputText("\n\nThe next drop covers more of her face, as does the one after it... you get so engrossed in jerking yourself off and rubbing your tip in Sheila's tightly-shut eyes and along her now-slippery cheeks that your orgasm steals up on you without warning.  Your prick swells");
				if (player.balls > 0) outputText(" and your [balls] draw closer to your body");
				outputText("; still intent on calling this oral sex, you squeeze Sheila's jaw, forcing her mouth open, then push your drooling slit right up to it as the first squirt of white peeks out.");
			}
		}
		//end width fork and length fork
		//begin corruption worms fork
		//(if corr >= 70 and Infest command is unlocked)
		if (player.cor >= 70 && player.statusEffectv1(StatusEffects.Infested) == 5) {
			outputText("\n\nA wicked idea flits through your head, brought on by the squirming annoyances ");
			if (player.balls > 0) outputText("packing your [balls] and driving up your lust in their zeal to multiply");
			else outputText("deep inside your body, trailing sensation along the nerves in your most intimate places and ramping up your production");
			outputText(", and you decide to indulge it.  \"<i>Don't worry about rations for the day,</i>\" you cry out, \"<i>I've got more than enough to feed you!</i>\"  Sheila's resigned expression registers this as little more than masculine braggadocio - all the better for your surprise.  Pulling deep inside yourself, you force out a thick load of wormy jism, depositing it directly into the woman's throat; her body tenses at the texture and she tries again to pull away.  As the writhing mass is pushed down her gullet by yet more arriving after it, she begins to struggle violently, hitting you with tired fists and trying to wrench her head free of your grip, even at the cost of her ears.  Luckily, she lacks the energy to do permanent damage to either you or herself after the fight and the cruel face-fucking, and you pour your infested load into her with abandon.");
			//[(big skeet)
			if (player.cumQ() >= 2500) outputText("  The volume of semen and slimy worms you pack her with is so great that it strains her stomach; you can actually see dozens of the annelids slithering around in a tight ball under the taut skin of her swollen midriff.");
			outputText("  Eventually you finish and pull out, after pushing up every worm you can.  Your ");
			if (player.balls > 0) outputText("[sack]");
			else outputText("body");
			outputText(" actually feels lighter by a noticeable amount - though you can still feel some deep inside you, reminding you that you'll be full again soon.  On that note...");
			
			outputText("\n\nYou lean over to Sheila; her face is already pale and horrified as she holds her gut, feeling the worms inside.  \"<i>Hope you enjoy today's catch,</i>\" you whisper.  \"<i>I'll come see you again when I have some more.</i>\"  Re-donning and refastening your [armor], you leave the woman behind just as she begins to retch violently, dumping worms and cum onto the grass.");
		}
		//(else if corr < 70 or PC cannot use Infest at will)
		else  {
			outputText("\n\n\"<i>Swallow it, bitch!</i>\" you cry, holding Sheila's head against your cock as your ejaculation begins.  Not like she has much choice, with the way you're holding her; she can either swallow or drown in semen.  Your orgasm fills her mouth, forcing its way down her throat");
			//[(big skeet)
			if (player.cumQ() >= 1000) outputText(", and soon you can feel it lapping at the end of your shaft");
			outputText(".");
			//[(mega skeet)
			if (player.cumQ() >= 3000) outputText("  Your body's not done with that, though, and keeps pushing out cum until it spurts around your prick and out Sheila's nose in little squirts.");
			outputText("  Emptying yourself, you pull Sheila's mouth away from your [cock shortest] and drag the slimy member on her chest, smearing her tits with spit and semen and wiping away the last of the mess on her shirt.");
			
			outputText("\n\nYou pull the soiled garment down over Sheila's breasts");
			//[(big+ skeet)
			if (player.cumQ() >= 1000) outputText(", though it's so wet with seed now that you can see them almost as well through it");
			outputText(".  \"<i>This really is a nice fabric.  You should take better care of it.</i>\"  With that parting shot, you leave the queasy-looking woman to digest your load and the humiliation.");
		}
		//end worm fork
		//end forced fellatio branch, reset hours since cum, lower lust and libido, add corruption
		player.orgasm();
		dynStats("lib", -1, "cor", 1);
	}
	else {
		//(else if no qualified cocks)
		//cunnilingus/analingus branch
		outputText("\n\nYou seize the girl by her hair, pulling her back and throwing her to the ground");
		//[(sheila corruption >= 30)
		if (sheilaCorruption() >= 30) outputText("; her breasts jiggle pleasingly as they settle on her chest, filling you with the urge to play with them");
		outputText(".  Straddling her, you lower your [vagOrAss] to her face.  \"<i>Lick,</i>\" you order, rubbing your [butt] on Sheila's nose");
		//[(not horse)
		if (!player.isTaur()) outputText(" as you fondle her tits");
		outputText(".");
		
		outputText("\n\nThe unhappy woman complies, inserting her tongue.  The little pink triangle works your hole only haltingly, stroking past the nerves of the entrance with a jerky, mechanical motion.  It's clear from the feeling that she's just pistoning it in and out, imitating the world's smallest cock.");
		if ((player.hasVagina() && player.vaginalCapacity() >= 100) || (!player.hasVagina() && player.analCapacity() >= 100)) outputText("  She keeps hitting the same spot again, too - she's not even bothering to adjust her angle and touch the rest of your stretched opening.");
		
		outputText("\n\n\"<i>You are awful at this,</i>\" you gripe, sitting heavily on her head.  A muffled complaint comes from under you, but you pay it no mind.  \"<i>No boy parts, tail too stubby to insert... and now no oral skills either.  Seriously, what are you good for except taking the dick and making babies?  Why don't you just stay home with your legs open and hold out a begging bowl?");
		//[(PC has met hellhound master)
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00141] > 0) outputText("  I know a nice boy in the mountains who keeps dogs, and I'm sure he'd love to have a womb like yours for their seed.  By this time tomorrow, you could have a cock in both holes, filling you with hellhound babies since you can't please a person.");
		outputText("</i>\"");
		
		outputText("\n\nYou can feel her face heating up under your [butt] as she flushes with shame; seems like you struck a nerve.  You ");
		//[(no horse)
		if (!player.isTaur()) outputText("pinch her nipple for emphasis, then grind your hips across her face, mauling her nose with your ass.  \"<i>I could fuck a tree and it wouldn't be as wooden as you in the sack");
		//[(PC has found corrupt glade)
		if (player.exploredForest >= 40) outputText(" - in fact, there are quite a few I've seen who look like better lovers than you.  Maybe I should carry you to the forest and tie you to a nice pussy-shaped giant flower to give you lessons");
		outputText(".  ");
		//[(minotaur addiction score =/= 0%)
		if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 0 || player.findPerk(PerkLib.MinotaurCumAddict) >= 0) {
			outputText("Perhaps I'll turn you over to a minotaur; you're bound to get better at using your tongue when you're addicted to their amazing seed.  Would you like that?  The first thing you'd see in the morning would be a huge flared cock, right in front of you, dripping with heavenly precum and waiting for your mouth... or your cunt.  You could be just another minotaur-fucking slut of the plains.  ");
		}
		outputText("Or I could take you home and give you personal training myself, whenever I feel like it, and invite travelers to do the same");
		//[(PC has Izma with cock)
		if (izmaFollower() && flags[kFLAGS.IZMA_NO_COCK] == 0) outputText("; I personally know fifteen inches of fat, orange dick and four heavy balls that'd love to get in at your other end while I ride your face");
		outputText(".</i>\"");
		
		outputText("\n\nYour [vagOrAss] squeezes around Sheila's hesitant tongue, turned on more by the spectacle of selling her body than by any of her poor efforts.  She squirms under you, rubbing her thighs together as you paint the worst pictures of her future you can imagine, and you climax");
		//[(PC has met Lumi or Lynette)
		if (player.findStatusEffect(StatusEffects.HairdresserMeeting) >= 0 || flags[kFLAGS.LUMI_MET] > 0) {
			outputText(" while imagining her turned over to the goblins for experiments, forced to drink potion after potion - most would be dedicated to growing cocks on her or increasing semen production, of course");
		}
		outputText(".  Your hole clenches and drools on her, and the woman's rude tongue retreats from the pressure, leaving you painfully empty.");
		//[(no horse)
		if (!player.isTaur()) outputText("  Even squeezing her breasts viciously can't compel her to reinsert it, though you amuse yourself trying.");
		
		outputText("\n\n\"<i>Worthless,</i>\" you spit, climbing off.  She turns a disconsolate, wet face to you as you redress and leave, but doesn't defend herself.");
		//end lingus branch, reduce lust, lower libido, add corruption
		player.orgasm();
		dynStats("lib", -1, "cor", 1);
	}
	combat.cleanupAfterCombat();
}

//[Dildo Rape] - requires DX Dildo
//set sheila xp = -4
private function sheilaGetsRapedWithADildont():void {
	clearOutput();
	flags[kFLAGS.SHEILA_XP] = -4;
	outputText("Looking down at the woman below you, a cruel idea forms in your head.  You extract the absurd pink goblin dildo from your pack; Sheila's eyes darken as she recognizes the manufacture.  She tries to scoot further away from you, but you grab her leg and turn her over callously, then slide a hand under her and force her ass into the air by lifting her crotch.");
	
	outputText("\n\n\"<i>What are you doing?</i>\" she asks, panicked.  Ignoring her, you unfasten her belt and yank down both her shorts and her panties; as you pull the fabric away from her vulva, she squirms uncomfortably.  \"<i>Stop it, please!</i>\"");
	
	outputText("\n\n\"<i>Why?</i>\" you reply coldly.  Grabbing her tail and yanking it upward, you produce a shriek from the woman at the same time as you jam the dildo into her cunt without warning.");
	
	outputText("\n\n\"<i>Wait!</i>\" Sheila yelps.  \"<i>Take it out!</i>\"  Instead, you give the toy a squeeze, forcing lust-inspiring goblin fluids from the end and into her body.  Swirling it around, you smear the chemicals into the walls of her pussy; soon she's panting greedily, having all but forgotten her desire to escape.  You watch her push herself off the ground with one hand and grope her breast with the other...");
	
	outputText("\n\nSeems the perfect time to pull back out.  You release Sheila and begin to back away - she notices the painful absence immediately.  \"<i>Uh?  Where are you going?  Hey!</i>\"");
	
	outputText("\n\n\"<i>Home,</i>\" you answer, pretending to put the toy away.");
	
	outputText("\n\n\"<i>You can't!  I'll go crazy if you leave me like this, and something else might find me!</i>\" the woman whines, actually crawling backwards on hands and knees to rub her cunt against you.  \"<i>Please, put it back in!  I'm begging you!</i>\"");
	
	outputText("\n\n\"<i>You want it inside you that badly?  No matter what?</i>\"  Caressing her ass, you lift her tail out of the way again; she shivers and nods eagerly at you, eyes unfocused with chemically-imbued desire.  You rub the crown of the fake pink cock against her vulva again, smearing it with her freely-flowing lube, and she grinds her hips, trying to mount it but only pushing it away.");
	
	outputText("\n\n\"<i>Come on!</i>\" she moans.  \"<i>Shove it in already!</i>\"");
	
	outputText("\n\nYou smile, unseen by the shivering woman, and pull your arm back.  Sheila waggles her ass at you enticingly as you pull her tail higher, and you send the pink missile home - right into her pucker.");
	
	outputText("\n\n\"<i>Aaaaahhh!</i>\" she screams, as you force the inches into her in one slow, brutal, anus-stretching marathon.  \"<i>No... no... no!</i>\"  Sheila tries to crawl away from you, but you tighten your grip on her tail and pull her right back, using the leverage to help you hilt the dildo in her rectum.  Tears come to her eyes as you begin to pull it out again, just barely able to free it from the friction with the aid of the lubrication she so generously donated.  Her asshole must be squeezing the dildo quite hard, because when you finally pop the fake glans back out, a spurt of pink fluid follows.  Softly, you tease Sheila's asshole with your toy, waiting for the chemicals to do their work once again; when she shivers, you take it as a sign that the wait is over.  Pressing the tip to her pucker once again, you're actually a little bit surprised when it opens to your gentle pressure, jerkily allowing the length inside.");
	
	outputText("\n\n\"<i>You change your mind a lot, you know that?</i>\"  The woman's skin flushes as you work your dildo, pistoning it in her rectum, and she moans lightly.  It doesn't take long before she's as into it as she was when you had it in her cunt and rams her ass into your hand, helping you fuck her wide-open, stretched hole.");
	
	outputText("\n\n\"<i>G-gonna... gonna cum...</i>\" she groans, rolling her head on her neck and tossing her hair.");
	
	outputText("\n\nYou lean forward until your face is level with her ear, and whisper, \"<i>From anal alone?  You really are a slut!</i>\"  Sheila doesn't even seem to care, pumped with goblin drugs; she raises one hand and places it alongside your face, leaning in to kiss your cheek as she sinks herself on the dildo one last time.");
	
	outputText("\n\n\"<i>Nnnnn,</i>\" she moans, humming into your " + player.skinFurScales() + ".  ");
	//[(PC corr >= 90 and sheila corr >= 90)
	if (player.cor >= 90 || player.cor > sheilaCorruption()) {
		outputText("Your face heats as she kisses you sloppily, and not all of the temperature is from her mouth.  It feels like she's pulling energy right out of you, and you can swear that her breasts are growing.");
	}
	//(else PC corr < sheila corruption)
	else if (player.cor < sheilaCorruption()) {
		outputText("Her lips heat up and your body tingles; you can see her breasts shrinking as she shivers and slobbers on your face - or so it seems from the angle.");
	}
	//(else if magically equal but < 90)
	else outputText("The kiss is wet and indecent as she shudders through her anal orgasm; her lips don't stay in one place, instead tracking drool all over your face.");
	
	outputText("\n\n\"<i>Well done, my little butt-slut,</i>\" you quip, pulling the dildo free of the woman's ass.  A stream of pink faux-jizz slides out in its wake, mingling with the liquid that squirted from her pussy when she came.");
	//(cock)
	if (player.hasCock()) outputText("  \"<i>Perhaps next time you'd like to try a real cock in there?</i>\"  Even exhausted and messed up on goblin drugs, she has the presence of mind to shake her head at that.  You laugh.");
	
	//go to demonization if PC corr >= 90 and sheila corruption >= 90, else continue
	if (player.cor >= 90 && sheilaCorruption() >= 90) {
		menu();
		addButton(0,"Next",sheilaGoesDemon);
		return;
	}
	outputText("\n\nTurning around, you walk away from the woman, holding the used dildo out at an angle to make sure she can see it until you disappear.  Privately, you're also waiting to wash it before you put it away again - or use it on yourself, imagining the scene again in your head.");
	
	//end scene, gain lib-based lust, if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption
	if (player.cor >= 90 || sheilaCorruption() < player.cor) {
		dynStats("cor", -10);
		sheilaCorruption(10);
	}
	else if (player.cor < sheilaCorruption()) {
		dynStats("cor", 10);
		sheilaCorruption(-10);
	}
	dynStats("lus", player.lib/3, "resisted", false);
	combat.cleanupAfterCombat();
}

//loss in combat: 
//- Reminder: non-demon Sheila will kick your ass and leave unless PC has raised her lust to 75+ before losing; only in those cases will she be overcome and actually take advantage of you
//- Sheila can't into rough, brutal sex and focuses on getting off quickly and leaving, so losses only cost 8 hours if she wins by HP; however, if she chooses not to sex the PC, he's stuck with whatever lust gained
//-Sheila doesn't care about gems after a win as much as getting the fuck away from you (or getting off and then getting the fuck away from you in shame)
internal function getBeatUpBySheila():void {
	clearOutput();
	outputText("You slump down before Sheila, breathing heavily; the woman ");
	if (monster.lust < 75) {
		outputText("takes the opportunity to grab her catch and take off running!  Even if you wanted to, you couldn't catch her now... you collapse, head swimming in ");
		if (player.HP < 1) outputText("colorful spots");
		else outputText("fantasies of her, stark naked but for her hat and waiting with her legs open");
		outputText(".");
		//lose 8 hrs if HP < 1 or 1 hr if lust > 99, no gem loss 
		combat.cleanupAfterCombat();
	}
	//(else monster lust >= 75)
	else {
		outputText("stares at you, desire and nerve at war in her face.  Her thighs rub together involuntarily as she tries and fails to will herself away... slowly, she takes a step toward you.");
		outputText("\n\n\"<i>[name]... you're not a demon?</i>\" Sheila asks, with smoldering eyes.");
		
		outputText("\n\nYou shake your head, lost in a fog.  No sooner do you than she jumps you, pressing her body to yours and stealing a long passionate kiss that focuses your thoughts.");
		//[(sheila xp > -4)
		if (flags[kFLAGS.SHEILA_XP] > -4) {
			outputText("\n\n\"<i>Don't hate me for this...</i>\" she whispers.");
			//if sheila xp > -4, set sheila xp = -2, go to loss rape
			flags[kFLAGS.SHEILA_XP] = -2;
		}
		//TO ZE SCENE
		addButton(0,"Next",sheilaLossRapeRouter);
	}
}

private function sheilaLossRapeRouter():void {
	//loss - forced oral (for M,F,H,U)
	//RNG biased against giving this scene to men/herms, but it should still be possible
	//boilerplate face-in-cunt shit
	//if sheila xp >= -3, set sheila xp = -2
	if ((!player.hasCock() || rand(3) == 0)) sheilaForcedOralGeneric();
	//loss scene - cowgirl (for M,H)
	//if sheila xp >= -3, set sheila xp = -2
	else {
		sheilaCowgirlRapesYou();
		return;
	}
}

//loss scene - cowgirl (for M,H)
//if sheila xp >= -3, set sheila xp = -2
private function sheilaCowgirlRapesYou():void {
	clearOutput();
	outputText("Sheila pushes insistently, and you allow her to force you to the ground and then onto your back");
	if (player.isTaur()) outputText("; your hooves stick awkwardly out to one side");
	outputText(".  She blushes furiously and won't meet your eyes, but it doesn't stop her from stripping off her vest and shirt in one smooth motion, revealing her " + sheilaCup() + " chest.  \"<i>T-touch me,</i>\" she demands, \"<i>rub me.</i>\"  Almost as an afterthought, she adds \"<i>... please.</i>\"");
	
	outputText("\n\nYou move your hands to her smooth skin, cupping a ");
	if (sheilaCorruption() < 30) outputText("petit ");
	else if (sheilaCorruption() > 70) outputText("massive ");
	outputText("breast in each, squeezing them softly and rubbing the hard nipples with your thumbs.  Sheila shudders as you amuse yourself with her body, placing her hands atop yours and guiding you to her favorite spots.  You watch her as she moans; your gazes meet as she rolls her head, and she quickly restrains herself and looks away again.  \"<i>Stop staring at me...</i>\"");
	
	outputText("\n\nEager to see anything but your curious face, Sheila pushes your hands away from her breasts and turns to your crotch.  She ");
	if (player.isTaur()) outputText("pulls your legs apart");
	else outputText("unfastens and strips off your [armor]");
	outputText(", revealing your " + player.multiCockDescriptLight() + "; ");
	//[(if no cock fit 32)
	if (player.cockThatFits(32) < 0) {
		outputText("her eyes widen as " + player.sMultiCockDesc() + " bobs free, half-erect monster meat that fills her with frustration.");
		
		outputText("\n\n\"<i>Dammit!</i>\" she cries, punching the dirt.  \"<i>Another wanker with more dick than brain... how do you expect to ever love a woman?</i>\"");
		
		outputText("\n\n\"<i>Problem?</i>\" you ask, innocently.");
		
		outputText("\n\nSheila bites her lip and nods.  \"<i>I could never fit that inside... I can't use it.</i>\"");
		
		outputText("\n\nRather, she means she's not imaginative enough to use it?  Sheila seems to see some of your assumed insult in your eyes, and she sets her jaw.  \"<i>Alright,</i>\" she says ominously, \"<i>challenge accepted.</i>\"  The woman unfastens her belt, stripping off her shorts and panties with the same haste as her top.  Her underwear comes away with ease, sticking hardly a bit - maybe she plans to make up the deficit in her arousal with willpower?  Sheila pushes your back flat against the ground again");
		//[(horse)
		if (player.isTaur()) outputText(", or at least as flat as you can get it");
		outputText(", then sits on your stomach");
		if (player.isTaur()) outputText(", sliding her long legs between yours");
		outputText(".  She scoots forward slowly, and gasps as her pussy comes to rest against your hot, blood-engorged shaft.");
		
		outputText("\n\n\"<i>Ahh... ah.  N-not bad,</i>\" she sighs.  She wraps her thighs lightly around your [cock] and begins to shift up and down, stroking herself.  The space between her legs is nearly the perfect size, and when she squeezes you, you moan as well.  \"<i>So,</i>\" Sheila whispers, shuddering, \"<i>enjoying this, are you?</i>\"");
		
		outputText("\n\nYou pant in agreement as your hips begin to aid the stimulation by thrusting; your ");
		if (player.isTaur()) outputText("forelegs fold over her torso affectionately");
		else outputText("hands search out her breasts, caressing and squeezing");
		outputText(" as her gasps and the picture in your head both intensify.  Sheila grabs one with her own hand, pulling it up to her mouth to smother it in kisses");
		if (!player.isTaur()) outputText("and suck on your fingers");
		outputText(".  \"<i>Oh... [name]...</i>\"");
		
		outputText("\n\nYou grunt a response, too involved in thrusting between her warm, juice-slicked thighs to form sentences.  \"<i>[name]... I-I'm... coming!</i>\" Sheila shrieks.");
		
		//[(sens >=50)
		if (player.sens >= 50) {
			outputText("\n\n\"<i>Come!</i>\" you order, close to your own orgasm as well.  ");
		}
		//(sens < 50)
		else outputText("\n\nWhat?!  You're not even near finishing yet!  ");
		outputText("Sheila shivers and leans back, hair dangling, as her hips buck and her thighs squeeze your shaft.  ");
		//(PC corr >=90 or > sheila corruption)
		if (player.cor >= 90 || sheilaCorruption() < player.cor) {
			outputText("You can feel your prick heating up where her pussy rubs against it... it almost feels like the rest is cooling down at the same time.  The woman atop you arches her back and sucks in her breath sharply, and her tits seem to claim your field of vision, swelling up - though that could just be the angle.");
		}
		else if (player.cor < sheilaCorruption()) outputText("Her orgasm wets your prick, coating it with fluid as she comes.  Sheila wraps herself tighter in your limbs, squeezing her breasts against her chest, and you think you can feel them get a little smaller as your head fuzzes over with her excess emotion.");
		else outputText("Her hips lock up when she comes, leaving you to try and finish yourself as she heats up around your shaft.");
		
		//[(sens >=50)
		if (player.sens >= 50) {
			outputText("\n\nThe warm, smooth, wetness of her thighs is enough to bring out your own climax, and " + player.sMultiCockDesc() + " unburdens itself, forcing globs of semen into the air to rain down on your entwined bodies.  Sheila laughs as you coat her midriff with your mess, and playfully strokes your sensitized [cock] with one hand, sending shivers through you as she helps force your cum up your shaft.");
			//[(mega skeet)
			if (player.cumQ() >= 2000) outputText("  The giggles and the strokes stop long before your orgasm, though; eventually Sheila just lies there, dumbfounded, as you deposit layer after layer of white lattice on her skin.  \"<i>Bloody hell,</i>\" she mumbles vaguely, either stone-sober or drunk from the sight of it.");
			outputText("  Once the rain of semen peters out, she pulls apart from you, slimy and dripping.");
			
			//if PC corr >= 90 and sheila corruption >= 90, go to demonization, else continue
			if (player.cor >= 90 && sheilaCorruption() >= 90) {
				menu();
				addButton(0,"Next",sheilaGoesDemon);
				return;
			}
			
			outputText("\n\n\"<i>Well... what do you think of that, then?</i>\"  Sheila laughs and cleans herself on the grass, then picks up her stuff and leaves you to sleep off the fatigue and defeat.");
			//reset hours since cum, pass 1 hr if lust loss or 8 if HP
			player.orgasm();
			dynStats("sen", 1);
			combat.cleanupAfterCombat();
		}
		//(else sens < 50)
		else {
			outputText("\n\nYou thrust vigorously, trying to push yourself over the edge, but Sheila's orgasm is already winding down - she scoots up and pulls her pussy away from your rubbing, tormenting shaft, leaving you alone in a painful vacuum of sensation.");
			
			//if PC corr >= 90 and sheila corruption >= 90, go to demonization, else continue
			if (player.cor >= 90 && sheilaCorruption() >= 90) {
				menu();
				addButton(0,"Next",sheilaGoesDemon);
				return;
			}
			outputText("\n\n\"<i>What are you doing, mate?  You're gonna make me horny again!</i>\"");
			
			outputText("\n\nShe looks over her shoulder at you, and the drawn expression on your face tells the whole story.  Her eyes glimmer with mischief, and she leans down to you.  \"<i>I told you a donger like that wasn't suitable for loving a woman,</i>\" Sheila says, tracing a circle on your chest.  \"<i>Don't suppose you have anyone to blame but yourself, eh?</i>\"");
			
			outputText("\n\nYour partner parts from you and stands up, redressing as you lie on your back.  She looks at you once more and rubs your [cock] one last time, right below the glans, before taking off with her bounding run.");
			//[(HP loss)
			if (player.HP < 1) outputText("\n\nFatigue and desire contest in your head, but eventually you slip into unconsciousness, tormented by memories of soft, wet skin.");
			//huge sens-based lust damage and lose 8 hrs if HP loss or plus med libido and return to camp if lust loss
			dynStats("sen", 3, "lus", 50+player.lib/10, "resisted", false);
			//end cock don't fit branch
			combat.cleanupAfterCombat();
		}
	}
	//(else if cock fit 32)
	else {
		outputText("as you lean over to catch her expression, you can see her eyes glimmer with desire.  Sheila notices you from her peripheral vision, and her face reddens again.  She turns her back to you.");
		
		outputText("\n\n\"<i>I mean it... look somewhere else!</i>\"");
		outputText("\n\n\"<i>Where shall I look?</i>\" you ask, innocently.");
		
		outputText("\n\nSheila's ears prick up, but she doesn't answer, instead ");
		//[(multicock)]
		if (player.cockTotal() > 1) outputText("separating out and ");
		outputText("stroking your [cockFit 32].  A drop of precum forms, and she touches it with the index finger of her free hand, sending a tingle through you; she pulls the finger away, drawing a string of slick moisture out.  Sheila passes the finger between her breasts, wiping the fluid away on her chest and shivering.  The display is too much for you, and you reach forward, navigating your hands around her waist quietly until you can reach the buckle of her belt.  The girl sighs as you begin to unfasten it, but an errant thought brings her back to reality - she grabs your hands abruptly.");
		
		outputText("\n\n\"<i>What are you doing?</i>\" she yelps, staring at you in shock.  You return the stare unflinchingly, until she gives up and averts her eyes.");
		
		outputText("\n\n\"<i>That's... we're not lovers!</i>\" Sheila stammers.  \"<i>Don't just undress me as you please!</i>\"");
		
		outputText("\n\n\"<i>Sorry,</i>\" you reply, \"<i>were you only getting ready for a swim?  This is what you wanted, right?</i>\"  You begin to move your hands again, undaunted by her meager resistance.");
		
		outputText("\n\n\"<i>What I want...</i>\" Sheila trails off; shaking herself free she stands up, shorts half-unfastened.  \"<i>Fine!  If you're intent on seeing it, then look!</i>\"  She quickly pulls her belt apart and drops her bottoms to the ground, followed more carefully by her underwear.  \"<i>Here!</i>\"");
		
		//[(lib < 25)
		if (player.lib < 25) {
			outputText("\n\nInstead of focusing on her pussy, you continue to stare into her guilty face.  Sheila's lips quaver and her eyes water; she seems almost on the verge of crying as your unceasing scrutiny breaks down her resolve.  \"<i>Please...</i>\" she whimpers unhappily, \"<i>stop staring at me like that.</i>\"");
			outputText("\n\n\"<i>But you're using me just for my dick?</i>\"");
			
			outputText("\n\n\"<i>No, I'm...</i>\" she attempts, frowning, then slumps her shoulders in defeat.  \"<i>You're right.  This is wrong.  I'm sorry.</i>\"  Sheila turns and quietly pulls her shorts back up, fastening her belt, then locates her top and slips it over her breasts.  She picks up the rest of her stuff, looks back at you once, then lopes off.  You watch her go with high energy and mixed feelings - of all things, the image of her pulling the shirt down over her flushed, sweating back sticks in your head, taunting you and keeping your prick hard long after she's gone.");
			//end scene and return to camp, plus some libido, plus lots of lust
			dynStats("lib", 1, "lus", 70);
			combat.cleanupAfterCombat();
			return;
		}
		//(else lib >= 25)
		else {
			outputText("\n\nHer soft, white panties stick to her pussy as she pulls them away, and closer inspection reveals the reason; her cunt is covered with a sheen of her lubrication, declaring its readiness.  The smell wafts to you, and your cock swells with blood, thickening and hardening painfully.");
			outputText("\n\n\"<i>Bastard,</i>\" Sheila whispers under her breath as your body pushes out another drop of precum.  \"<i>You want this... I knew it.</i>\"");
			
			outputText("\n\nYou look up at her face again, smiling coyly.  \"<i>Just an autonomous reaction, I swear.</i>\"");
			
			outputText("\n\nShe frowns and straddles your crotch");
			if (player.isTaur()) outputText(", pushing your legs apart");
			outputText("; looking into your face, her frown evolves into a mischievous grin.  Sheila about-faces, turning her back to you.  \"<i>Blame yourself for this; it's rude to stare,</i>\" she giggles, hovering over your [cockHeadFit 32].  The woman sinks down with an audible sigh, parting her slick, smooth labia with your tip and swallowing your " + num2Text(Math.round(player.cocks[player.cockThatFits(32)].cockLength)) + " inches.  \"<i>Ohh...</i>\" Sheila moans.  She slips a hand down to your crotch to check how much of your prick is left to go, and starts a bit when she realizes she's taken the entire shaft on the first stroke!");
			
			outputText("\n\n\"<i>Guess I wasn't the only one,</i>\" you tease softly.  Sheila's neck turns red, but she only begins to move her hips, saying nothing.  Her snub tail dances in the air as she pumps your cock, beating out a tattoo on your stomach");
			if (!player.isTaur()) outputText(", and your hands go to her waist, fairly pushing her up and slamming her back down in your eagerness");
			outputText(".  She rolls her head as the fuck gets wetter and faster, dangling her hair over her shoulders as her back muscles shift and flex with her strokes; her ears flick whenever she descends and rubs your neck against one of the sweet spots on her vulva.");
			
			outputText("\n\nThe stimulation is too much, and on one of the downthrusts, the tingling nerves at your tip trigger your climax and you ejaculate wordlessly into the distracted woman, who is still busy pumping her soaking pussy, not noticing the extra moisture.  She moans and gasps, rubbing her clitoris with two fingers, and begins to twitch as well, fucking you messily with her increasingly slimy pussy.  ");
			//(PC corr >= 90 or > sheila corruption)
			if (player.cor >= 90 || player.cor > sheilaCorruption()) outputText("You can feel her cum-slick inner walls pulling at you as she begins to orgasm, and your mind clears as you blow your load inside her, wondering when she'll likewise return to sense.");
			//(else PC corr < sheila corruption)
			else if (player.cor < sheilaCorruption()) outputText("Her pussy gushes with her orgasm, pushing out your semen and soaking her inner lips even as she continues riding your cock, and your mind clouds as you think of little except sneaking as much of your cum inside her as possible.");
			//else equal but < 90)
			else outputText("Even as she comes mindlessly something makes you hold in your own moans, wondering how long it will take her to notice her pussy being filled with your egg-hunting sperm.");
			//[(small cum)]
			if (player.cumQ() <= 250) {
				outputText("  Sheila continues moving her hips even as she comes, lost in bliss; on one particularly lofty ascent, your cock flops out, squirting a line of jizz along ");
				if (player.tailType > TAIL_TYPE_NONE) outputText("your tail");
				else outputText("the grass");
				outputText(", and her eyes go wide.");
			}
			//(big cum)
			else {
				outputText("  With how much Sheila is still moving her hips, it's only a matter of time before she notices the mounting pressure in her cunt... on one particularly deep push, she forces out a squirt of white, and her eyes go wide as she pulls off and lets you finish on the grass.");
			}
			
			//if PC corr >= 90 and sheila corruption >= 90, go to demonization, else continue
			if (player.cor >= 90 && sheilaCorruption() >= 90) {
				menu();
				addButton(0,"Next",sheilaGoesDemon);
				return;
			}
			outputText("\n\n\"<i>What the fuck?!</i>\" she yells.  \"<i>How much of your cum did you just shoot in me?</i>\"");
			
			if (player.cumQ() <= 250) outputText("\n\n\"<i>A-all of it...</i>\"");
			else outputText("\n\n\"<i>A little...</i>\"");
			outputText(" you groan.  \"<i>Can't believe you didn't notice...</i>\"");
			
			outputText("\n\n\"<i>Bloody hell...</i>\"  Shaken, the woman climbs off of you, wincing as runnels of your semen slip out of her vagina and trickle from her vulva to roll down her thighs and mat her fur.  \"<i>Oh god, what if I get pregnant?</i>\"");
			
			outputText("\n\nAs she panics and fusses her way back into her clothes, you lie there on the grass, tranquilly slipping into a doze.  Even if she does, what of it?  It was her idea in the first place...");
			
			//reduce lust and lib, reset hrs since cum, lose 8 hrs if HP or 2-3 if lust loss?
			sheilaPreg(true);
			player.orgasm();
			sheilaPreg();
			dynStats("lib", -1);
			combat.cleanupAfterCombat();
		}
	}
	//if not ended prematurely by small cock and lib < 25, PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption
	sheilaCorruptionUpdate();
	/*if (player.cor > sheilaCorruption() || player.cor >= 90) {
		dynStats("cor", -10);
		sheilaCorruption(10);
	}
	else if (sheilaCorruption() > player.cor) {
		dynStats("cor", 10);
		sheilaCorruption(-10);
	}*/
}
	
//loss - forced oral (for M,F,H,U)
//RNG biased against giving this scene to men/herms, but it should still be possible
//boilerplate face-in-cunt shit
//if sheila xp >= -3, set sheila xp = -2
private function sheilaForcedOralGeneric():void {
	clearOutput();
	outputText("Sheila kisses you once more, forcing her tongue into your mouth, and slides a hand into your [armor]; you stare wonderingly into her affectionate, hungry eyes at the sudden change.  It isn't until ");
	if (player.hasCock()) outputText("her hand slips around your [cock]");
	else if (player.hasVagina()) outputText("her fingers slip between your labia");
	else outputText("she rubs your bare crotch for a few seconds");
	outputText(" that her reverie breaks; her face colors and she looks away, averting her gaze in shame.  She draws her hand back out guiltily, then begins to doff her shorts and panties.  \"<i>S-sorry... didn't mean to get familiar.  I'll have this over with quickly.</i>\"");
	
	outputText("\n\n\"<i>That's-</i>\"  Your words are cut off as she suddenly climbs atop you, bringing her pussy to eye level");
	if (player.str < 61) outputText("; her weight bears you slowly to the ground");
	outputText(".  Sheila rubs the smooth slit on your [face], trying to part her labia on you, and shivers a bit when your lips brush hers.");
	
	outputText("\n\n\"<i>Lick...</i>\" she whispers, almost apologetically, \"<i>... please.  Or... or I'll have to hit you again.</i>\"  She sets her face and takes a handful of your hair, twisting it");
	if (player.hairType == 4) outputText(" and flushing as your stingers release their payloads into her palm");
	outputText(".  You obediently stick out your tongue");
	if (player.cor > 60) outputText(", motivated more by whimsy than the meager, almost playful pain,");
	outputText(" and shallowly penetrate Sheila's vagina with it.");
	
	outputText("\n\nThe woman jerks a bit as you enter her, but sighs in relaxation.  \"<i>That's good... come on mate, lick me more.</i>\"  She pushes her cunt against your [face], trying to take your tongue deeper.");
	//[(if d-mon/dragon/naga or other future long tongue)
	if (player.tongueType > TONGUE_HUMAN) {
		outputText("  A sly look crosses your face at her request; she notices it but has no time to dismount before your long tongue shoots into her, stroking the nerves around her entrance as you unspool.  \"<i>Ah-ahhh!</i>\" she moans, \"<i>What the hell... is with your mouth?</i>\"");
		outputText("\n\nPetulantly you stare at her as you work, unable to speak with your tongue unrolled in her cunt.  She blushes under your gaze, then leans forward and wraps her arms around you, brushing the top of your head with her shirt-clad " + sheilaCup() + " breasts.  \"<i>You're r-right, mate... rude to talk with your mouth f-full... aaah!</i>\"  A little firm spot inside of her provokes this last reaction; you experimentally run your tongue over it again, and the woman shudders violently.");
		
		outputText("\n\n\"<i>N-no... what are you t-touching?  That feels so...</i>\"  Sheila's unable to complete a thought as you assault your new find with your oral explorer, and just clings to your head as if it were a family heirloom.  You rub and rub, but she steadfastly refuses to climax; eventually your tongue actually gets tired and sore, yet every time you try to draw it out and rest she pulls your hair again, begging you not to stop, to stroke that spot again, and again.");
		
		outputText("\n\nIt takes almost an hour, but as your eyes start to close autonomously from sheer fatigue and you're contemplating pushing her off and escaping, she finally comes.");
	}
	//(else no long tongue)
	else {
		outputText("\n\nYou use the increased leverage to baste her small, smooth vulva in your saliva, dragging your tongue from the bottom to the top and then scraping the broad side against her little clit as you angle it back down to search out her entrance.  \"<i>Yes...</i>\" Sheila moans, wrapping herself around your head, \"<i>yes!  Oh god, rub my button harder!</i>\"");
		outputText("\n\nSeeing an easy way out of this, you do so; she shivers and convulses on you, battering your nose with her pelvis as you lick the little nub relentlessly.  The woman moans and gasps as you tease and flick, and eventually all her vocalizations run together in one long, unbroken groan.  She continues like that for several minutes, absently thrusting her hips into your face as you tease her clit and slip a finger into her pussy.  \"<i>Ffffffuck!  N-no, ssso soon!  I don't want this to end!</i>\"");
		outputText("\n\nEager to see her orgasm, you slide into her cunt one last time.");
		//merge tongue forks
	}
	outputText("\n\nThe woman's pussy clenches as she finishes, ");
	//[(PC corr >= 90 or > sheila corruption)]
	if (player.cor >= 90 || player.cor > sheilaCorruption()) {
		outputText("strangling your tongue with muscles attempting to lock onto it, trying to pull it in.");
		//[(demon/dragon tongue)
		if (player.tongueType > TONGUE_HUMAN) outputText("  As tired as you are, you simply go along with it, allowing her rippling walls to slowly draw your tip deeper inside until it bumps against her cervix; she shivers and kisses the top of your head as you groggily run your tongue over the entrance to her womb.");
		else outputText("  However, it doesn't get very far; you lazily flop it around inside her as she works through her arousal.");
		outputText("  Sheila groans loudly and your vision fades; through the fog, you can swear you feel her breasts growing larger against your forehead.");
	}
	//(else PC corr < sheila corruption)
	else if (player.cor < sheilaCorruption()) {
		outputText("filling your mouth with her liquid love.  Your lips and throat heat up as you're forced to drink it from the nearness of her pussy; as she bucks her hips weakly into your face, trying to draw out her climax, you increasingly wish that you could return the favor, ");
		if (player.hasCock()) outputText("face-fucking her and blowing a load into her mouth, then holding her jaw shut until she swallows it unhappily.");
		else if (player.hasVagina()) outputText("smearing your gash on her face until you come and drown her in your squirting girl-jizz.");
		else outputText("forcing her to tongue your asshole until you come, writhing and pressing her head into the grass with your [butt].");
	}
	else outputText("and she pets your head affectionately as her walls squeeze your tongue.  \"<i>Oh, mate...</i>\" she whispers lovingly, completely forgetting the struggle that led to your tryst.");
	
	//if both sheila corruption and PC corr >= 90, go to demonization, else continue
	if (player.cor >= 90 && sheilaCorruption() >= 90) {
		menu();
		addButton(0,"Next",sheilaGoesDemon);
		return;
	}
	
	outputText("\n\nSheila twitches her last twitch and pulls apart from you slowly, ");
	//[(str < 61)
	if (player.str < 61) outputText("climbing off and kneeling next to you.");
	else outputText("letting herself down your body until she can put her long legs on the ground once more.");
	outputText("  She looks into your eyes contentedly, rubbing your cheek... but then starts and looks away, guilty once more.  \"<i>Shit...</i>\" she mumbles.  \"<i>I did it again.  Even after I promised myself I wouldn't...</i>\"");
	
	outputText("\n\nBefore you can ask for her meaning, she backs away and slips on her bottoms.  Studiously avoiding further eye contact, Sheila gathers her things and leaves you behind with her long, bounding run; tired from the struggle, you try to turn her words over in your head, but only muddle them further as you slip into a doze.");
	
	//end scene, add fatigue if long tongue, very big lib-based lust gain, gain libido if lust hits 100; if PC corr > sheila corruption then -10 PC corr and +10 sheila corruption, else if PC corr < sheila corruption then +10 PC corr and -10 sheila corruption and slimefeed
	if (player.tongueType > TONGUE_HUMAN) player.changeFatigue(15);
	dynStats("lus", player.lib/3+30, "resisted", false);
	if (player.lust >= player.maxLust()) dynStats("lib", 1);
	sheilaCorruptionUpdate();
	/*
	if (player.cor >= 90 || player.cor > sheilaCorruption()) {
		dynStats("cor", -10);
		sheilaCorruption(10);
	}
	else if (player.cor < sheilaCorruption()) {
		dynStats("cor", 10);
		sheilaCorruption(-10);
	}*/
	combat.cleanupAfterCombat();
}

//Normal preg notif #1 (sheilapreg = 4 and demon sheila = 0 and sheila xp >= -2 and joeycount = 0):
//output at next sheila encounter if conditions are met, suppressing any normal output (this also includes the sheila xp = -2 or -1 apology outputs)
//set sheilapreg = 0
private function normalSheilaPregNotifNumberOne():void {
	pregnancy.knockUpForce(); //Clear Pregnancy
	clearOutput();
	outputText("Traipsing through the grass, you can see Sheila sitting under the shade of a low tree from a long way off.  The reverse is also true, as she waves to you from her seat, beckoning you over.  You make your way to her curiously.");
	outputText("\n\n\"<i>G'day, [name],</i>\" she opens, slightly nervous.  \"<i>I needta tell you something.  Sit down?</i>\"");
	
	outputText("\n\nYou oblige, planting yourself next to her.  She leans affectionately against you, though her nervousness doesn't disappear - if anything, it becomes more acute.");
	if (player.cor < 50) outputText("  A hand placed around her shoulder seems to steady her a bit.");
	
	outputText("\n\n\"<i>Well, y'see,</i>\" she begins, \"<i>I ah... had... your baby.</i>\"");
	
	outputText("\n\nMan, what?!  Your expression speaks volumes, and she launches into a hurried explanation without a word from you.");
	
	outputText("\n\n\"<i>It doesn't take long for us,</i>\" she says, blushing a bit.  \"<i>So you didn't see anything much on me... but I pushed out a little [name] last night.  Baby's nursing well and is fit as a bull.  I left the nipper with the creche for the day when I came out to hunt; one of the wet nurses probably has it in a snuggy pouch right now, waiting for mom to come home.  Should be able to tell the sex in a week after it's grown a bit.  Er... is this gonna be an issue between us, going forward?</i>\"  The woman looks hopefully at you, clearly eager for reassurance.");
	//[Yep, Issue][Nah]
	menu();

	addButton(0,"Yep, Issue",normalSheilaPregNotifNumberOneYepIssue);
	addButton(1,"Nah",normalSheilaPregNotifNumberOneCoolDeal);
	
}

//[Normal Preg Notif #1 - Yep, Issue]
private function normalSheilaPregNotifNumberOneYepIssue():void {
	clearOutput();
	outputText("\"<i>I see,</i>\" Sheila says, nonplussed.  \"<i>I'm sorry you feel that way...  Truth be told, I'm not keen myself on the idea of having a kid, but what's out is out.</i>\"");

	outputText("\n\nShe stands up suddenly and starts walking away.  \"<i>Nice knowing you, mate.  You won't see me again - I'll make sure of that.</i>\"  Within seconds of speaking, she's broken into a fast, bounding run, beyond any hope of catching.");
	//set sheilapreg = -1, and set joeycount + 1 if you plan to track that stat even after Sheila's disabled
	flags[kFLAGS.SHEILA_DISABLED] = 2;
	flags[kFLAGS.SHEILA_JOEYS]++;
	doNext(camp.returnToCampUseOneHour);
}

//[Normal Preg Notif #1 - Nah]
private function normalSheilaPregNotifNumberOneCoolDeal():void {
	clearOutput();
	outputText("Sheila exhales explosively when you gently shake your head, then wraps her arms around you and buries her face in your shoulder.  \"<i>Oh, thank god,</i>\" she says, muffled.  \"<i>Truth be told, I'm not keen yet on the idea of having a joey.  Motherhood feels like something that happens to MY mum.</i>\"  She snuggles closer.  \"<i>But I like holding it.</i>\"");
	
	outputText("\n\nShe releases you; a small wet spot marks the space her face just occupied.  Seeing it, she wipes her tears on the back of her hand.  \"<i>Sorry.  Didn't mean to leak on you.</i>\"");
	
	//[(sheila xp < 0)
	if (flags[kFLAGS.SHEILA_XP] < 0) {
		outputText("\n\nShe sniffs a bit.  \"<i>I didn't really expect warm approbation, y'know?  I mean, we're not the best of friends, so I appreciate it.  Can't really bring you two together to show you how it's doing yet, and I feel all kinds of bad about not having the dad nearby while it's growing up, but... if you want, we can keep in touch and I'll tell you the news.  Do... would you be okay with seeing more of each other?</i>\"");
		outputText("\n\nEarnest eyes turn on you, and you put a hand on the girl's head.  She smiles, taking your answer for granted.  \"<i>Spiffy... you're me mate, now.</i>\"  Sheila cuddles a bit closer, resting her head on your chest and making you wonder just which interpretation of the word she was using.  You sit there for several minutes before she gets up and bids you goodbye with a shy glance.");
	}
	else {
		outputText("\n\nSheila sits for a while, sniffling and rubbing her nose, before she speaks again.  \"<i>Ah... something ya might like.  My captain was always as cross as a frog in a sock that I hadn't contributed more hands to the colony yet, so when I showed up with a joey and told him where it... uh, came from, he decided to extend my time on the hunting crew.  We can see each other for a good while longer before I get shuffled back to digging or soldiering - if you want to, that is.</i>\"  Sheila slips an arm around you possessively.  \"<i>I wasn't sure enough to mention it before, but... if you really fancy me, I reckon I could convince him to extend it for as long as we're together.</i>\"  The woman blushes crimson.  \"<i>... So long as we keep making more.</i>\"");
		
		outputText("\n\nYou slide a finger into her belt and ask if that was an invitation.");
		
		outputText("\n\n\"<i>Randy " + player.mf("bloke","sheila") + ",</i>\" she answers, \"<i>as much fun as that would be, I'm feeling clucky and I need to go check on your baby.  I don't want to be one of those mums that leave their nippers with the help and never see them.</i>\"  She kisses you, and then stands up to walk away - though when she glances over her shoulder at you, it's obvious by the fond look in her eyes she's eager for the next meeting.");
	}
	if (flags[kFLAGS.SHEILA_XP] < 4) flags[kFLAGS.SHEILA_XP] = 4;
	flags[kFLAGS.SHEILA_JOEYS]++;
	doNext(camp.returnToCampUseOneHour);
	//if sheila xp < 4, set sheila xp = 4; increment joeycount + 1
}

//Normal Preg, Subsequent kids (sheilapreg = 4 and demon sheila = 0 and sheila xp >= -2 and joeycount > 0
//set sheilapreg = 0 and increment joeycount +1 now
//if sheila corruption > 80, set sheila corruption = 80
private function normalSheilaPregNotifREPEATEDED():void {
	clearOutput();
	outputText("Sheila is here as you step into the plains, with a grass-wrapped parcel of food open on her lap and her hat sitting upturned next to her, and waves you over.");
	
	outputText("\n\nAs you sit, she proffers the snack, smiling, then closes her eyes.  The woman breathes deeply and regularly as you pick and eat a morsel from her gift.  Just as you wonder if you should wake her, she speaks.  \"<i>[name]...  I, ah... made another addition to your posterity.  Came out ");
	if (rand(10) < 7) outputText("healthy.  It's eating a lot... frankly, it's a little hellraiser with a strong grip, and it cries well, too.</i>\"");
	else outputText("weak... we thought we were going to lose it for a bit.  It wouldn't drink from the nurse unless I was there, so I had to stay up with it all night myself.  Feeling a bit stuffed.</i>\"");
	outputText("  She looks over at you, giving you the benefit of her fatigue-lined eyes.");
	
	outputText("\n\nSheila slips her hand into yours");
	if (player.cor < 40) outputText(", and you give it a squeeze");
	outputText(".  \"<i>I just wanted to tell you about your baby.  Can't stay... have to catch up to quota still.</i>\"  She drags to her feet and turns to go, tail listlessly hanging.  Even her ears are drooping; this girl is tired.");
	
	pregnancy.knockUpForce(); //Clear Pregnancy
	flags[kFLAGS.SHEILA_JOEYS]++;
	if (sheilaCorruption() > 80) flags[kFLAGS.SHEILA_CORRUPTION] = 80;
	menu();
	//[Help(requires >80 speed, centaur >= 5', naga, or big wings and archery)][Walk With Her][Let Her Go]
	if ((player.spe > 80 && player.findPerk(PerkLib.Runner) >= 0) || (player.isTaur()) || player.isNaga() || (player.canFly && player.hasKeyItem("Bow") >= 0))
		addButton(0,"Help",normalSheilaPregNotifREPEATEDEDHelpABitchOut);
	addButton(1,"WalkWithHer",normalSheilaPregNotifREPEATEDEDWalkWithHer);
	addButton(2,"Let Her Go",normalSheilaPregNotifREPEATEDEDLetHerGo);
}

//[Normal Preg Subsequent - Let Her Go]
private function normalSheilaPregNotifREPEATEDEDLetHerGo():void {
	clearOutput();
	outputText("Nothing you can do about that - even if you wanted to watch your baby for her, she's keeping it hidden in a hole in the ground.  You hand her the parcel back");
	if (player.cor < 40) outputText(", imploring her to eat the rest and keep up her strength");
	outputText(".  Sheila smiles weakly and takes it, folding the grass around again.  \"<i>Thanks, [name].  I'll see you soon... ish.</i>\"");
	
	outputText("\n\nShe walks slowly with an uncharacteristic stumble; when she reaches about twenty feet, she turns and begins walking back to you.  You stand up, expecting the other shoe to drop, but she merely nods.");
	
	outputText("\n\n\"<i>Forgot my hat.</i>\"");
	
	outputText("\n\nPicking it up and seating it on her head, she nods curtly and shuffles off again.");
	
	//wow, it's fucking nothing!
	doNext(camp.returnToCampUseOneHour);
}

//[Normal Preg Subsequent - Walk With Her]
private function normalSheilaPregNotifREPEATEDEDWalkWithHer():void {
	clearOutput();
	outputText("You pick up her forgotten hat and rise as well, carefully refolding the grass around Sheila's uneaten lunch and tucking it back into her pack for her.  She takes her hat back from you distantly.");
	
	outputText("\n\n\"<i>Thanks, mate... forget my own head next.</i>\"  She doesn't even put it on, simply holds it in her hand as she plods on.  You ");
	if (!player.isNaga()) outputText("walk");
	else outputText("slither");
	outputText(" next to her, easily keeping pace with the tired woman, and she raises her face to you inquiringly.  \"<i>What's up, [name]?</i>\"");
	
	outputText("\n\n\"<i>Just going to watch your back for a bit.  It's a nice back,</i>\" you retort.");
	
	outputText("\n\nSheila blushes.  \"<i>Kind of you... want to stay until I can get some snares set up and find a good place to hide and lie down?  That'd be ace.</i>\"");
	
	outputText("\n\nThe woman slips her empty hand into yours again, half to lead and half for comfort, and the two of you walk solemnly through the grass for a while as Sheila looks about with heavy-lidded eyes, setting down snares from her pack.");
	
	outputText("\n\n\"<i>Have a squizz over there, mate,</i>\" she says, pointing at a patch of tall weeds.  \"<i>Good cover for me to catch a wink.  This should be okay.</i>\"  She pulls her hand from yours and finally sets her hat atop her head, then shrugs off her pack.  \"<i>I'm gonna get set up now.  Thanks again... see you soon.</i>\"");
	//get slightly lowered corruption and a warm fuzzy
	dynStats("cor", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[Normal Preg Subsequent - Help]
private function normalSheilaPregNotifREPEATEDEDHelpABitchOut():void {
	clearOutput();
	outputText("You pick up her forgotten hat and set it on her head, then fold her lunch back into its grass wrapper and tuck it into her pack.");
	
	outputText("\n\n\"<i>Ah, thanks mate,</i>\" Sheila says.  She looks uncertain for a minute, then comes to a decision and wraps her arms around you, hugging you weakly.");
	
	outputText("\n\n\"<i>Let me help you,</i>\" you insist quietly, into her ear.");
	outputText("\n\nIt twitches in front of your face and the woman pulls away, peering at you with curiosity from under her heavy eyelids.  \"<i>I'm not against it, but... how are you going to?</i>\"");
	
	//[(outputs in order of preference; first, horse and >=5ft)
	if (player.isTaur()) {
		outputText("\n\nYou look into her dull amber eyes for a minute to nerve yourself, and then speak.  \"<i>Climb on.</i>\"");
		
		outputText("\n\nSheila stares muzzily as you jerk a thumb toward your equine half, slowly turning red as your intention penetrates her sleep-deprived psyche.");
		
		outputText("\n\n\"<i>This... uh, are you sure?</i>\" she asks.  Sighing, you lower yourself slightly, to make the leg up a bit easier.  She rests her arm on your back, then bends herself and hops atop you easily, sliding one foot over.  One of her hands grabs at your torso to keep the tired woman from falling right off the other side, and the other joins it once she steadies herself.  She takes her hat off again and hangs it around your neck, then mumbles, \"<i>Okay... I'm ready.</i>\"");
		
		outputText("\n\nYou break into a trot, and Sheila leans her head against you, torpidly flicking her ears as she looks to one side or the other.  Occasionally she pats your side to get your attention, calling out a spot where she'd like to dismount and set up a trap, but for the most part the ride passes in silence.  You make several circuits of the plains, checking snares and adding caught animals to the bundle she slings over your back; once, you arrive at the site of a sprung trap, only to realize by the sound of Sheila's breathing that she's asleep and must have been for some time!  With a tug on her hand, you rouse the woman.");
		
		outputText("\n\n\"<i>Uh!</i>\" she grunts, picking her head up slowly.  A line of drool connects her mouth to your back, and you peer over your shoulder at her for several seconds until she re-registers where she is and her eyes widen.  \"<i>Shit!  Sorry!</i>\"");
		
		outputText("\n\nSheila slips down from you quickly and wipes her mouth, then retrieves her catch.  \"<i>Um... really, I'm sorry,</i>\" she mumbles, fastening it to the bundle.  She rests her hand on your flank for a moment, then begins unloading you.  \"<i>This is more than enough.  Thanks.  I'll be alright now...</i>\"");
		
		outputText("\n\n\"<i>... Now that you've had a nap?</i>\" you supply, finishing her sentence.");
		outputText("\n\nShe flinches.  \"<i>I didn't mean to fall asleep, but you were warm and... I felt safe.</i>\"");
		
		outputText("\n\nWaving off her embarrassment dismissively, you allow Sheila to hug you once more and hang the game animals - and hat - around her shoulders, then leave her to head back.");
	}
	//(else naga)
	else if (player.isNaga()) {
		outputText("\n\n\"<i>Just do what you normally do and I'll think of something.</i>\"");
		
		outputText("\n\nSheila nods slowly and takes your hand, pulling you forward.  You slither alongside the woman for several minutes until she stops suddenly, putting a hand over your mouth before you can ask why.  Following her gaze, you see what caused her to pull up short: two large pheasants sit up cautiously, eyes on Sheila and yourself as they prepare to bolt at the slightest sign of aggression.  The woman next to you is already cursing under her breath at losing the element of surprise.");
		
		outputText("\n\nThis is more than enough surprise for you, though.  Staring down the animals, you begin to glide slowly toward them.  Sheila tries to grab your hand again, but you're already past her, closing in on the birds even as their bodies relax.  You stop around fifteen yards away, and begin undulating your body, shaping patterns even as you hold their eyes with your own.  Your coils shift to circles, then squares, then oozy triangles, over and over, as you compel the prey with your stare.  Unable to stir hand or foot without your permission, the animals come forward as you beckon until they're sitting in front of you.");
		
		outputText("\n\nA touch on your shoulder almost rouses you from your trance.  Sheila, beside you and beside herself with incredulity, speaks in a whisper.  \"<i>That's... it's almost like cheating, mate.</i>\"  You barely resist the urge to answer with a cliché smirk.");
	
		outputText("\n\nThe woman takes the opportunity to secure your 'catch', and the two of you move across the grasslands, quickly meeting her quota and more by working together like this.  \"<i>Well?</i>\" you ask Sheila, once she's loaded down with game.");
		
		outputText("\n\n\"<i>Pretty good for old [name], making circles in the dust,</i>\" she retorts, shoulders hunched under the weight of so many animals.  \"<i>I might even get to sleep in tomorrow with this much.</i>\"  She wraps her arms around you in a hug, then looks in your eyes.");
		
		outputText("\n\nYou quirk an eyebrow at her as she affects tiredness, yawning theatrically.  \"<i>Oh no, [name], what are you doing?  Don't hypnotize me too...</i>\"  Sheila breaks the embrace and sits down, laying your catch and her pack beside her, then turns a hopeful face on you.  \"<i>Not to be cheeky but... care to join me for a nap?</i>\"");
		
		outputText("\n\n\"<i>Oh look,</i>\" you retort, \"<i>yet another woman who wants to sleep with me.</i>\"  She laughs and catches your hand, pulling you down and snuggling up to you; her fatigue catches up to her quickly, and she's soon asleep with a peaceful smile on her face.  You watch her for a while before you, too, fall asleep, lulled by the rays of the sun.");
	}
	//(else wings and archery skill)
	//less QQ, more pew pew
	else if (player.canFly() && player.hasKeyItem("Bow") >= 0) {
		outputText("\n\n\"<i>Just wander around and flush game; point out animals you see.</i>\"");
		
		outputText("\n\nSheila looks a little confused, but glumly nods.  \"<i>Alright, [name]; we'll do it your way.</i>\"  She begins to walk, then turns back when you don't follow.  \"<i>Are you com-</i>\"");
		
		outputText("\n\nHer question cuts off when she sees you, arrow nocked on your bow, beating your wings against the ground and pushing yourself into the air.  Without so much as a how-do-you do, you ascend until you're high in the sky with the sun on your quarter.  Almost imperceptibly, Sheila shrugs below you and resumes walking.");
		
		outputText("\n\nIt's not long before she points toward a small thatch of grass; at the motion of her arm a pheasant takes flight, trying to flee from her.  You pull the bow, carefully aim your shot ahead of the fleeting target, and let the arrow go.  Gravity takes it, making up for your shallow draw, and pins the bird to the ground on the first try, killing it instantly.  Sheila wanders over to claim it.  This continues for several hours, your companion chasing animals from cover and your arrows finding them more often than not.  The misses you do experience give you some insight on how the slight wind plays with the trajectory, and by the time you're too tired to pull anymore, you feel like you might have gotten better.  Slowly, you allow your weary wings to return you to the ground next to your companion, who is laden with game.");
		
		outputText("\n\n\"<i>Wow, [name],</i>\" she says, coyly handing you back your arrows.  \"<i>That was impressive - like having my own guardian angel.  I've got more than enough to take home now, so do you want to... do anything else together?</i>\"");
		
		outputText("\n\nIt takes a minute for your fatigued brain to come around to the fact that she's actually flirting with you!  Dumbly you look back at her, trying to make your exhaustion apparent in your eyes so you won't have to speak.");
		
		outputText("\n\n\"<i>Oh... oh!  Right, sorry.  I wasn't even thinking about that, mate.  It must be hard to fly and shoot at the same time.</i>\"  You nod gratefully, and she wraps her arms around your neck.  \"<i>Offer's on the table if you want it later, though.</i>\"  She kisses you on the lips, then releases you and walks away slowly, swaying her hips and peering over her shoulder for your benefit.  Seems like archery hits her mark?");
		player.changeFatigue(20);
	}
	//(else spd >= 80 and Runner perk)
	else if (player.spe >= 80 && player.findPerk(PerkLib.Runner) >= 0) {
		outputText("\n\n\"<i>Just do what you normally do, and I'll help.</i>\"");
		
		outputText("\n\nSheila looks at you blankly, but takes your hand and begins walking.  Or rather, more like meandering.  Her head turns listlessly as she drags you onward.");
		
		outputText("\n\n\"<i>So what are we looking for?</i>\" you ask.");
		
		outputText("\n\nSheila starts, then mumbles out her answer.  \"<i>Uh.  Whatever's useful - spoor, live animals, fresh kills... a quiet place to curl up and die...</i>\"");
		
		outputText("\n\nNo use in her moping like that; ");
		if (player.lib < 50) outputText("you pinch her ear, provoking an annoyed flick from it.");
		else outputText("you slap her on the ass, grabbing a handful and taking her mind off her own misery.");
		outputText("  \"<i>Dammit, [name]... not now,</i>\" she frowns, pulling away from you.");
		
		outputText("\n\n\"<i>Quit staring at the ground, then.</i>\"");
		
		outputText("\n\nSheila simply grunts at that, but sobers up a bit.  You walk together a bit longer until a rustling in the grass startles you both; a hare breaks from cover and bolts away, and your companion swears an oath at missing quarry so close to hand.");
		
		outputText("\n\n\"<i>Go that way and keep still... lay a trap or something,</i>\" you interrupt, pointing at a perpendicular to the hare's path.");
		
		outputText("\n\nSheila pulls a queer face, but complies, loping off in the indicated direction.  After stretching yourself, you break into an easy ");
		if (!player.isGoo()) outputText("run");
		else outputText("glide");
		outputText(", making a long loop around to the rear of the wary animal, then begin to systematically drive it closer to your partner, who has strung a line to the base of a shrub and is gesturing at you to force the hare into it.");

		outputText("\n\nThe prey, perhaps sensing something amiss, begins to jink away from the line.  To compensate, you put on an extra burst of speed, using your facility at running to draw even with it in a sprint whenever it tries to turn away, and force it back on track.  Just when it crosses the line, Sheila pulls it taut, catching the hare mid-stride and sending it tumbling; you're on it before it can recover, holding it still as your partner draws closer to deliver the killing blow.");
		
		outputText("\n\n\"<i>[name], you're pretty fast,</i>\" she says, warmly.");
		
		outputText("\n\n\"<i>Race you sometime,</i>\" you reply.");
		
		outputText("\n\nSheila shakes her head, then looks at you sidelong from half-closed eyes.  \"<i>Ah... but finishing quickly isn't what matters most.  You need the endurance to keep at it all day.</i>\"  She smiles.");
		
		outputText("\n\n\"<i>I'm ready to train that whenever you are,</i>\" you answer coyly.");
		
		outputText("\n\nYou flush game like this for several hours, bantering with your increasingly-companionable companion between exertions; she seems to lose track of both time and her irritation, evolving from moping and staring at the ground to blushing and staring at you.  Eventually she's caught enough to take back, though, and you have to receive her thanks and bid her farewell.");
	}
	//pass 4 hours and reduce corruption or something, give 3 hrs rest if naga, increase archery skill and increase fatigue by a lot (50-60+) if angel of death
	dynStats("cor", -2);
	if (model.time.hours + 4 < 21) doNext(camp.returnToCampUseFourHours);
	else {
		//(if time after adding 4 hours >= 21:00 or = 0:00, additionally output)
		outputText("\n\n<b>\"<i>Oh, god dammit.</i>\"</b>");
		outputText("\n\nSheila's voice startles you, and you look over at her.  The woman is slumped down on the ground, staring at the horizon, and as you look closer you can see her chest quaking as she chokes back a sob.  \"<i>What's wrong?</i>\" you ask.");
		
		outputText("\n\nShe turns wet eyes on you, at the verge of tears.  \"<i>So stupid of me... I lost track of time and missed curfew... now I can't deliver these, and I can't check on the baby!  I'll have to spend all night outside, keeping myself awake, and then do all this again tomorrow!</i>\"  Her composure is already breaking down in her face.");
		
		//[Stay With Her][To Camp(excluded for PCs with Vapula or Holli)][Welp]
		menu();
		addButton(0,"StayWithHer",normalSheilaPregNotifREPEATEDEDHelpABitchOutANDSTAYDERE);
		if (!(flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) && !vapulaSlave())
			addButton(1,"To Camp",normalSheilaPregNotifREPEATEDEDHelpABitchOutTOCAMP);
		addButton(2,"Welp",normalSheilaPregNotifREPEATEDEDHelpABitchOutANDWELP);
	}
}

//[Normal Preg Subsequent - Help - 21:00 hours - Welp]
private function normalSheilaPregNotifREPEATEDEDHelpABitchOutANDWELP():void {
	clearOutput();
	outputText("\"<i>Welp,</i>\" you say softly.");
	//[(corr <50)
	if (player.cor < 50) outputText("  You set a hand on Sheila's shoulder to steady her a bit as the tears start to fall.");
	outputText("  \"<i>It'll be alright.</i>\"");
	
	outputText("\n\n\"<i>I know,</i>\" sobs the woman, \"<i>but it feels like everything is going sprung at once!</i>\"");
	
	outputText("\n\nTo yourself, you think that that's nonsense... despite the unusual circumstances, she's not the first parent to miss sleep because of a newborn, and she won't be the last.  Aloud, you tell her that she just needs to get it out so she can calm down; the village can surely do without the meat for a night, and the nurses will take care of her baby - after all, it's what they're there for in the first place.  She cries a while longer, but without violence.");
	
	outputText("\n\n\"<I>You're right,</i>\" Sheila sniffles finally, wiping her red eyes.  \"<i>I just... let it get the better of me for a moment.  I'm okay now.  Thanks, mate.</i>\"  She hugs you weakly and picks up her catch.  \"<i>I'll see ya later...</i>\"");
	//suck it up, marine
	doNext(camp.returnToCampUseOneHour);
}


//[Normal Preg Subsequent - Help - 21:00 hours - Stay With Her]
private function normalSheilaPregNotifREPEATEDEDHelpABitchOutANDSTAYDERE():void {
	clearOutput();
	outputText("With a wan smile, you pull the woman to her feet.  She doesn't resist, but continues looking into your face disconsolately.  \"<i>I'm so stonkered I can't even think what to do first...</i>\"");
	
	outputText("\n\n\"<i>Well, first is probably finding us a place to hide,</i>\" you suggest.");
	
	outputText("\n\nSheila nods and looks around for a while, moping.  Suddenly, her eyes widen with wakefulness as the full import of your words hits her.  \"<i>Um... [name], you said... us?</i>\" she asks, flushing.");
	
	outputText("\n\n\"<i>Something cozy,</i>\" you affirm.");
	
	outputText("\n\nSheila smiles a bit at that, but forces her face into a stern expression.  \"<i>Usually I like a thatch of tall grass - you can beat down or dig up the middle and pull the sides in with some string so it looks normal from the air, and you can tear out of there fast if something finds you.  We'll need a big patch for two mugs... like that one,</i>\" she decides, pointing off a ways.");
	
	outputText("\n\nIt doesn't take long to arrange the grass and place yourselves inside, though there's not enough room for both of you to lie down.  Sheila snuggles up to you after you ");
	if (player.isNaga()) outputText("coil");
	else outputText("seat");
	outputText(" yourself, then grabs your arms and pulls them around her waist.");
	
	//forks in order of priority, no new pg at start
	//[(full gooey body)
	if (player.isGoo()) {
		outputText("  She considers for a moment, rubbing away some of the slime you've deposited on her shorts, and pulls free from your slimy skin again.  \"<i>Um... do you... would you be offended if I took my kit off, so it doesn't get ruined?</i>\"");
		if (player.lib >= 40) outputText("  The leer you display is so prurient that she seems on the verge of reconsidering, but you compose yourself and");
		else outputText("  You");
		outputText(" give assent with little more than a broad smile.  Sheila pulls her shirt over her head, revealing her " + sheilaCup() + " breasts, but raises her face to you hesitantly when her hands get to her belt.");
		outputText("\n\nYou roll your eyes skyward.  \"<i>We have kids together.  I've seen it.</i>\"");
		
		outputText("\n\nSheila's blush deepens, but she nods and finishes undressing, pulling down her shorts and panties to expose her smooth pussy, then puts the clothing in a pile.  She turns her back to you and scoots in once more, leaving a tingle that spurs you to hold her closer when her flushed, embarrassed skin touches yours. \"<i>This feels good,</i>\" she says, \"<i>like a warm bath.</i>\"  Sheila giggles nervously as you instinctively pull her naked body deeper into your own.  \"<i>H-hey, [name].  Don't swallow me, mate.</i>\"  You bubble happily as you relax around her, covering most of the exposed skin below her collarbone with a thin layer of yourself.");
		//(apply libido AND sens-based lust damage)
		dynStats("lus", player.lib/5+player.sens/3, "resisted", false);
	}
	//(naga)
	else if (player.isNaga()) {
		outputText("\n\nYou wrap your tail around her as she settles in position, and Sheila wriggles against it.  \"<i>This is... weird,</i>\" she says, \"<i>but not bad.  Kinda like a smooth, firm blanket.  Can you loosen a bit, mate?</i>\"  With an unseen smile, you slacken the loops around her waist and hips");
		if (player.lib >= 40) outputText(" - but tighten the one sliding across her breasts just slightly.  Sheila's neck turns red and her ears twitch as you rub her nipples, and you plant a kiss on her nape");
		outputText(".  \"<i>Ahh,</i>\" she sighs, shifting in your coils.  \"<i>Hold it right there...</i>\"");
		//(apply libido-based lust damage if lib >= 40)
		if (player.lib >= 40) dynStats("lus", player.lib/4, "resisted", false);
	}
	//(horse and >=5ft)
	else if (player.isTaur() && player.tallness >= 60) {
		outputText("\n\nStrapped for space, her long feet still poke a good way out of the grass canopy, and she gets back up, tucking them under her body.  \"<i>Uh... [name], not to be forward but...</i>\"  Her eyes dart toward your broad back, and you sigh and fold your legs as comfortably as you can before nodding.  She giggles and climbs atop you, then spreads herself generally around.");
		
		outputText("\n\n\"<i>You like horses, don't you?</i>\" you ask.");
		
		outputText("\n\n\"<i>I used to love watching the ponies, growing up,</i>\" she answers, nuzzling into your shoulder.  \"<i>I always wanted a little one.</i>\"");
		
		outputText("\n\nThe way she rubs your lower half affectionately is even a little bit endearing");
		if (player.sens >= 40) outputText("... or would be, if you weren't distracted by the nipples poking into you and the thighs squeezing your flank");
		outputText(".");
		//(apply sens-based lust damage if sens >=40)
		if (player.sens >= 40) dynStats("lus", player.sens/4, "resisted", false);
	}
	//(harpy - minimum score for birdlegs at least)
	else if (player.lowerBody == LOWER_BODY_TYPE_HARPY && player.tailType == TAIL_TYPE_HARPY) {
		outputText("\n\nShe shifts in your embrace, pushing up and down and giving you fits.  \"<i>Good lord, woman, what is the matter?</i>\" you ask.");
		
		outputText("\n\n\"<i>Sorry, mate... your feathers are tickling me,</i>\" Sheila protests.");
		
		outputText("\n\nWith barely any room to move, you wouldn't know how to stop them from rustling against her even if you knew where the tickle was, but take your arms from around her.  \"<i>Slide down.</i>\"");
		
		outputText("\n\nShe does so, resting in your downy lap for a moment, but gets up again.  You raise an eyebrow at her, but she just takes off her vest and sets it under her head, then settles, evidently at ease.  This is somewhat irritating; you're basically sitting up straight, with perfect posture.  A bit of an uncomfortable pose to hold for hours on end.");
	}
	//(bees with boots)
	else if (player.lowerBody == LOWER_BODY_TYPE_BEE) {
		outputText("\n\nNo sooner does she get her head down than it's back up again.  You look a question at her.");
		outputText("\n\n\"<i>Your legs are so bloody hard and cold, [name],</i>\" she clarifies brutally, tapping on the chitin digging into her back.");
		outputText("\n\n\"<i>Well, sorry,</i>\" you answer, almost offended.  \"<i>Can't help the way god made me.</i>\"");
		outputText("\n\nSheila frowns unhappily.  \"<i>I know, mate... I'm just in a terrible mood lately.</i>\"  She slips her hand into yours and tries to rest her head on your shoulder.  \"<i>Don't let it diminish me in your eyes... I still think you're the bee's knees.</i>\"");
		outputText("\n\nAs she drifts off to sleep, you're stuck wondering if that was intentional...");
	}
	//(eight-legged freaks)
	else if (player.isDrider()) {
		outputText("\n\nShe shivers against you, even with your arms around her body.  \"<i>Cold?</i>\" you ask.");
		
		outputText("\n\nSheila nods.  You push her upright and get up, unfolding your legs with little click-clack noises.  Your companion seems alternately alarmed and fascinated as you expel long strings of silk from your abdomen, weaving them into a wide, crude sheet on the grass and gathering up the finished sections with your legs.  Once it's almost eight feet long, you shake it out.  It's still slightly clingy, but soft; you sit and drape your bodies with it.  \"<i>For you,</i>\" you announce grandly.");
		
		outputText("\n\n\"<i>[name]... wow,</i>\" she mumbles, snuggling against you and looking over her shoulder.  \"<i>Do you cover all your girlfriends in sticky white strings?</i>\"");
		
		outputText("\n\nYou raise an eyebrow at her assumptions, and Sheila turns her face downward, staring at the ground as her ears twitch furiously in embarrassment.  Resting your head against hers seems to calm her a bit.");
		
		outputText("\n\n\"<i>I'm keeping this,</i>\" Sheila whispers.  And so softly you can barely hear it, adds, \"<i>It's the nicest thing someone's given me lately.</i>\"");
		//(reduce spinneret charge by 1-2 levels)
		player.tailVenom -= 10;
		if (player.tailVenom < 0) player.tailVenom = 1;
	}
	//(else)
	else outputText("\n\n\"<i>Sorry it's not as comfortable as it could be, mate,</i>\" she apologizes.  \"<i>And... thanks.</i>\"");
	
	//merge forks
	outputText("\n\nYou adjust yourself occasionally to keep your ");
	if (!player.isGoo()) outputText("blood");
	else outputText("goo");
	outputText(" flowing, unsure if you'll be able to get to sleep, but Sheila has no such problems.  Within minutes, the woman is out, head nodding forward.  You suppose that means the first watch is yours... it passes slowly, despite the scenery, but eventually you nudge your partner awake when you can stay up no longer.");
	
	outputText("\n\n\"<i>Mmm... lemme sleep for fifteen minutes more, mate,</i>\" she mumbles.");
	
	//(corr <60)
	if (player.cor < 60) outputText("\n\nYou nearly consider it, tired as you are, until you remember that a sleeping person's fifteen minutes are two hours in the waking world and shake her again until she gets up.");
	else {
		outputText("\n\n\"<i>I don't mind,</i>\" you whisper, \"<i>but this imp seems to have an urgent message for you.</i>\"");
		outputText("\n\nSheila's head jerks up instantly, looking around in panic; when no imp appears, she turns, staring daggers at you, and slaps you in the face!  \"<i>That's not funny, arsehole!  Goddammit, I thought my heart was going to jump out of my chest!</i>\"");
		outputText("\n\nYou rub your smarting jaw, glaring back, and tell Sheila that it's her turn to watch.  Well, the adrenaline will keep her up, at least.");
	}
	if (!player.isTaur()) outputText("  She grudgingly repositions, allowing you to rest against her.");
	model.time.days++;
	model.time.hours = 2;
	statScreenRefresh();
	//--Next--
	menu();
	addButton(0,"Next",normalSheilaPregNotifREPEATEDEDHelpABitchOutANDSTAYDERE2);
}

//advance time to 5:00
private function normalSheilaPregNotifREPEATEDEDHelpABitchOutANDSTAYDERE2():void {
	clearOutput();
	model.time.hours = 5;
	statScreenRefresh();
	outputText("Your sleep is fitful, but not totally useless, and you yawn and stir a few hours later when Sheila wakes you");
	if (player.isGoo()) outputText("; she's already dressed and appears to have just been outside");
	outputText(".");
	
	outputText("\n\n\"<i>It's almost dawn,</i>\" she says, \"<i>and we should be safe to go out now.</i>\"  The girl begins untying the grassy cover, rubbing against you in the confined space.");
	if (player.lust < 30) outputText("  You give her a hand, then help her load up.  She gives you a peck on the cheek before she departs.  \"<i>Thanks, love.</i>\"");
	if (player.lust >= 30) {
		outputText("  Part of you is actually sad to see your cozy hovel being disassembled if it means her warm body won't be pressed up against yours anymore, and your hands begin to rove over her as she works.");
		
		outputText("\n\n\"<i>[name], stop,</i>\" she laughs.");
		
		outputText("\n\nYou look up at her and ask if she'd care to put off leaving for a bit.  She looks a little fatigued, but allows herself to be pulled down until she's seated next to you.  \"<i>I'm still stuffed...</i>\" she sighs.  \"<i>I don't think I have it in me right now.</i>\"");
		
		outputText("\n\n\"<i>Well,</i>\" you answer, \"<i>perhaps that's why it's called 'making' love.</i>\"  Sheila doesn't answer, but smiles shyly.");
		
		//end scene if lust <30, else add minor lib-based lust damage and display choices for consensual sex plus [Leave Her Be]
		dynStats("lus", player.lib / 10 + 5, "resisted", false);
		menu();
		sheilaXP4Sex(false);
		addButton(9,"LeaveHerBe",normalSheilaPregNotifREPEATEDEDHelpABitchOutANDSTAYDEREBUTLEAVEHERBE);
	}
	else doNext(camp.returnToCampUseOneHour);
}

//[Normal Preg Subsequent - Help - 21:00 hours - Stay Up With Her - Lust >= 30 - Leave Her Be]
private function normalSheilaPregNotifREPEATEDEDHelpABitchOutANDSTAYDEREBUTLEAVEHERBE():void {
	clearOutput();
	outputText("You relent, allowing the woman to free herself with a peck on your cheek.  She loads up her catch, and then turns to you.  \"<i>Thanks, [name].  Owe you one.</i>\"");
	//This is your Protoshield! I can't take this!
	doNext(camp.returnToCampUseOneHour);
}

//[Normal Preg Subsequent - Help - 21:00 hours - To Camp]
private function normalSheilaPregNotifREPEATEDEDHelpABitchOutTOCAMP():void {
	clearOutput();
	outputText("Wordlessly, you lift the bundle of game animals off of Sheila's shoulders and sling it over your own.  She looks up at you, confused enough to forget about her tears.  \"<i>What're you doing?</i>\"");
	
	outputText("\n\n\"<i>Come with me,</i>\" you answer simply, taking her by the hand.");
	
	outputText("\n\nSheila follows you stumblingly as you pull her along.  \"<i>Where are we going, mate?</i>\"");
	outputText("\n\n\"<i>Home.</i>\"");
	
	outputText("\n\nIn no time at all you're back at your familiar campsite in the wastes; the place is quiet and asleep, so you carefully drop the game animals on the ground next to the fire pit, then plop yourself down as well.");
	outputText("\n\n\"<i>Seems... nice,</i>\" Sheila says quietly, taking a seat, \"<i>but it's exposed - not to mention the big target sign.</i>\"  She looks at the portal, casting an ominous silhouette against the sky.  \"<i>I dunno about this.</i>\"");
	
	//[(if PC has thorn canopy on)
	if (player.findStatusEffect(StatusEffects.DefenseCanopy) >= 0) outputText("\n\nYou shrug off her objections, pointing at the thorns already growing over your point of entry.  Sheila seems duly impressed by the quasi-magical display.");
	//(else if PC has Jojo and Jojo's n.watch is on)
	else if (player.findStatusEffect(StatusEffects.JojoNightWatch) >= 0 || player.findStatusEffect(StatusEffects.PureCampJojo) >= 0) {
		outputText("\n\nYou wave Jojo over, introducing them and explaining that the monk watches the camp at night and you check it during the day.  The small white mouse bows politely to your guest, then seats himself nearby.  \"<i>Hello, Sheila,</i>\" he says.");
	}
	//(else if PC has Kid A and Kid's n.watch is on)
	else if (flags[kFLAGS.ANEMONE_WATCH] > 0) outputText("\n\nYou wave off Sheila's objections, pointing to the large barrel housing your skinny tenant and explaining that she watches the camp at night for you in exchange for a place to stay.  Sheila looks dubious as the tall blue girl shuffles over and sits down, shyly hiding herself behind you.  \"<i>Um... hi,</i>\" the anemone mumbles.");
	//(else if PC has no night watch turned on)
	else {
		outputText("\n\nYou sagely point out that even as such, spending the night trading shifts with someone she knows in a comfortable camp with a bedroll and hot food is infinitely preferable to slapping yourself awake in a dirty hole, hungry and scared.  Sheila nods, tight-lipped.  \"<i>D'you mind if I get second shift, then?</i>\" she asks, apologetically.  \"<i>I feel like you could knock me over with a feather.</i>\"  You shrug.");
	}
	
	outputText("\n\nSoon you've got a small fire lit and Sheila has numbly plucked and spitted some small birds from the catch.  As she twirls them in the flames, she sighs occasionally.  ");
	//[(int >=60)]
	if (player.inte >= 60) outputText("\"<i>The baby will be fine,</i>\" you venture, hazarding a guess.  \"<i>It's what the nurses are there for.</i>\"");
	else outputText("You slip an arm around her, and ask if she's okay.");
	outputText("  She nods mutely and pulls the food out of the fire.");
	//[(if Jojo present)
	if (player.findStatusEffect(StatusEffects.JojoNightWatch) >= 0 || player.findStatusEffect(StatusEffects.PureCampJojo) >= 0) outputText("  She extends one bird to you and another to Jojo.  He raises his hand and shakes his head, but politely.");
	else if (flags[kFLAGS.ANEMONE_WATCH] > 0) outputText("  Sheila offers you one of the birds, then extends another to your odd tenant.  The anemone's mouth tightens and she shakes her head vigorously, blushing a deep blue.");
	outputText("  You eat in silence until the food is gone, and Sheila clears her throat.");
	
	outputText("\n\n\"<i>I need to go before dawn, so I'll get this out in case you're asleep when I do,</i>\" she announces, still looking at the ground.  \"<i>I appreciate the help... now, and from before.  Really, you're a bottler.</i>\"");
	
	//[(if no watch)
	if (player.findStatusEffect(StatusEffects.JojoNightWatch) < 0 || player.findStatusEffect(StatusEffects.PureCampJojo) < 0 || flags[kFLAGS.ANEMONE_WATCH] == 0) outputText("\n\nShe gets to her feet as you grin, then makes her way over to your bedroll.  It doesn't take her long to fall asleep; you amuse yourself watching her toss and turn... and drool on your pillow.");
	//(if watch)
	else {
		outputText("\n\nYou grin and get up, and Sheila tails you to your bed.  ");
		if (flags[kFLAGS.SLEEP_WITH] != 0 && flags[kFLAGS.SLEEP_WITH] != "") outputText("She looks with some distaste at the nearby sleeper, and steps past.  You pick up the bedroll and follow her, reasoning that if she keeps her promise to be gone before dawn, it shouldn't raise any questions.  \"<i>Making friends, I see,</i>\" Sheila mutters... but as you unroll the bed again, her eyes zero in on it like a drowning man's on a raft, and she says nothing else.  ");
		outputText("She lies down first, allowing you to cozy up to her as far as you dare.  Just as you're about to drift off, you feel Sheila take your hand and pull your arm over her body.");
	}
	outputText("\n\nShe's gone in the morning.");
	//if nightwatch, normal night's sleep
	//if no nightwatch, 4 hours sleep and suppress any imp rapes
	//lparchive.org/Deadly-Premonition
	camp.sleepRecovery(false);
	model.time.hours = 7;
	model.time.days++;
	doNext(playerMenu);
}

//demonization Sheila transformation (output when demon sheila = 0 and sheila corruption is about to hit 100 with the PC):
//-mad with desire, Sheila jumps the PC for another round of sex
//-squirts lethicite goo all over his face/cock when she finally orgasms
//no new PG
private function sheilaGoesDemon():void {
	clearOutput();
	outputText("Sheila pulls away from you, showing her back; she remains quiet for a few minutes, shivering occasionally.  By the position of her arm, she's already touching herself again!  Her elbow dances and her head rolls as she works her cunt, but she gives up.  \"<i>Nnnn...</i>\" the woman finally whispers, \"<i>... it's not enough.  I have to have another go.</i>\"  She looks around and settles on you with half-focused, wild eyes, and she stands up and advances on you with obvious intent.");
	
	outputText("\n\nYou're barely upright before Sheila's pressed up against you again; she pushes you back down insistently with strength borne of desire, staring at you.  \"<i>[name], I still can't clear my head... I need to get off again, so I've gotta use your body.  You're okay with it, yeah?</i>\"");
	
	outputText("\n\nBefore you can answer, Sheila jumps on you and wraps her thighs around your face!  Her pussy is already slick with fluids, and she grinds it relentlessly against your lips.  \"<i>Fucking... lick me or something, before I go crazy!  Come on, you're ");
	if (flags[kFLAGS.SHEILA_XP] < -2) outputText("always so bloody eager to fuck me!");
	else outputText("me best mate!");
	outputText("  Help out!</i>\"");

	outputText("\n\nWearily, you stick out your tongue, burying it in her.  Sheila squeals and gasps, then begins pumping her hips, trying to ride your face like a cock.  She leans back, straining your neck and causing her enormous breasts to slide up her torso, then puts her hands against the ground for better leverage to thrust with.  Your own hands come into position around her ass, to support her wild bucking.  Sheila rapes your face for several minutes, battering you with her crotch and soaking you with liquid; it gets into both your nose and mouth, and you can taste her all the way to the back of your throat.  \"<i>Gods,</i>\" she swears, \"<i>why won't it come?!</i>\"");
	
	outputText("\n\nYou can feel her crotch heating up around your tongue; lubrication pours out now, running down your face, but Sheila still bucks harder, frustrated at her lack of climax.  \"<i>Itchy...</i>\" she moans, fucking deliriously.  \"<i>It tickles...</i>\"  She stops supporting herself and begins to scratch at her ears and thighs with her fingers; you lean forward to relieve the strain the huge-breasted woman puts on your neck, resting her back against the ground.  Sheila doesn't seem to notice... she's far too absorbed with staring in confusion as clumps of her fur come off in her hands.  \"<i>What is... my hair... ?</i>\"");

	outputText("\n\nStill thrusting at your face on autopilot, she grabs her ears desperately as if holding them tightly would stop the strange shedding, but when she releases them, her hands are covered in loose, auburn strands.  Startled, she wipes them off on the grass and touches her auricles again... they're completely smooth, and her expression is one of horror.  The fingers go to her thighs next; she curls them into her fur and pulls sharply in disbelief, but the result is the same: a patch of bare skin and a handful of hairs.  \"<i>No... what's happening, mate?</i>\" she whimpers as you sadistically abuse her clitoris, unconcerned with what happens to her.");
	
	outputText("\n\nHer legs tense around your head, suddenly hard as all the muscles in them lock up.  Sheila's head rolls and you can feel her hot hole squeeze as her feet dig into your back; the nails on them begin to lengthen and curve, leaving several shallow gouges while she holds them close, and a small talon emerges from her heel, poking into you uncomfortably.  \"<i>Ah... ah!</i>\" she moans, convulsing to the new growth as your eyebrows knit with the pain and your attention flags.  \"<i>I'm sorry!  I'm so sorry!  I can't help it; please don't be mad!  Don't stop... I need you!</i>\"");
	
	outputText("\n\nThe woman's stubby tail thrashes wildly as she begs, leaving shed fur all over your [chest] and lashing at your hands; you grab the end, trying to restrain it, and can feel it growing a bit longer.  \"<i>My tail... don't pull my tail!</i>\" Sheila pleads, pushing her cunt into you once more.  \"<i>It's driving me starkers!</i>\"  None of it is your doing, however, and the tail continues to grow - until it stops and bulges obscenely.  The end swells in your hand, growing rounded lobes that shift just under the skin as if a creature were inside.  It strains again and Sheila screams in pleasure as the skin tears and her tail splits in two; one half comes away with your hand and the outer skin falls apart, sloughing off with the remainder of the fur.  Tentative exploration reveals two distinct, slender tails.  They sway under her, giving you a glimpse as she resumes pumping at your face; one is the same color as her now-hairless skin but the other is so dark-brown it's almost black - as it peeks at you, the lobes reveal themselves to be a stubby spade.  A little slit on the end drools a dark, oily fluid and it jabs at you, trying to get inside your mouth; you're forced to fend it off with one hand as you lick and suck at the cunt in front of you, trying to turn Sheila to goo in your arms.");
	
	outputText("\n\n\"<i>Oh god... yes... stick it out farther, so I can hit all the good spots!  I'm almost there!</i>\" Sheila says encouragingly, squeezing and massaging her breasts, strange changes already forgotten.  You try, ");
	if (player.tongueType > TONGUE_HUMAN) outputText("extending your oral muscle until it's all the way to the back of her pussy.  ");
	else outputText("but only manage to scrape her entrance; she shudders and seems satisfied with that, judging by what she says next.  ");
	outputText("\"<i>G-gonna come!  Finally gonna come!</i>\"  Her thighs clench and her pussy begins to spasm as her groin knocks against your chin.  A viscous, clingy liquid squirts from her pussy and into your mouth, pooling on your tongue; in your surprise, you release the black tail and it forces into the gap and through your lips, releasing something foul-tasting.  You quickly turn your head and push it away; it forces out the rest on your cheek, a black, slimy mess.  Fantasies of riding her face the same way and filling her mouth flit through your mind as Sheila finishes convulsing, then goes limp and releases you, falling to the ground.  You drool the mess in your mouth into your hand; the thick fluid you felt first is a light lavender, but as the black sludge from her tail suffuses it, it darkens to a deep purple.  The mixture clings together, gelling and then solidifying into an irregular, lustrous stone - a crystal.  It heats up in your hand, and you can feel an arousing power leaking into you.");
	
	outputText("\n\nSheila watches half-interestedly as it hardens but once the substance stops moving, her attention turns to her changed body.  \"<i>Oh... oh, mate... what did you do to me?</i>\" she sighs.  You give her a cursory glance.  Her fur is completely gone and her tail is split; her feet jut with wicked-looking talons instead of straight nails, though the middle one is still slightly larger than the others.  Aside from that, she's the same slender, huge-busted woman you remember.  Well... her skin may be a bit darker, perhaps?");
	
	outputText("\n\n\"<i>You look fine,</i>\" you say dismissively, standing and tucking away your new crystal.  Gathering your things, you turn to leave with your prize.");
	
	outputText("\n\n\"<i>Really?</i>\" she calls after you, eagerly.  \"<i>Will you still make love to me next time we meet?  Because... I could go again anytime, you know?  I don't care about hunting anymore... we could just root all day!  As long as I'm with you!</i>\"  Sheila's voice cuts off abruptly as the magic of the realm brings you out of the plains and back to camp.");
	
	//reduce lust and lib, raise corr slightly, gain key item Sheila's Lethicite, set sheilacite = 1
	player.orgasm();
	dynStats("lib", -1, "cor", 3);
	player.createKeyItem("Sheila's Lethicite",0,0,0,0);
	flags[kFLAGS.SHEILA_CITE] = 1;
	flags[kFLAGS.SHEILA_DEMON] = 1;
	//good place to cut off content if you don't have time to code it all in one go
	if (!getGame().inCombat)
		doNext(camp.returnToCampUseOneHour);
	else combat.cleanupAfterCombat();
}

//Demon Sheila encounter (demon sheila = 1 and sheilapreg < 4)
private function demonSheilaEncounter():void {
	clearOutput();
	outputText("A shadow drops out of a low tree behind you with a rustle.  \"<i>Hey, lover; been a while... how about spending some time with me?</i>\"");
	
	outputText("\n\nAs you turn around, Sheila sashays over to you.  Apart from a little lavender crystal dangling from her long, bare ear and several finger rings, she's naked as a jaybird now, exposing her " + sheilaCup() + " breasts and smooth, dripping snatch for all the world to see.  Two lithe tails, one spaded and one not, rub against her labia in anticipation as she takes a horse stance in front of you to wait on your answer, and her eyes smolder with lust.");
	
	//[Talk][Let Her Fuck(req. lust >=30)][Resist][Run]
	menu();
	addButton(0,"Talk",demonSheilaTalk);
	if (player.lust >= 33) addButton(1,"LetHerFuck",sheilaLetHerFuckYou);
	addButton(2,"Resist",demonSheilaResist);
	//run simply returns to camp and should be the default spacebar option
	addButton(4,"Run",camp.returnToCampUseOneHour);
}

//[Demon Sheila - Resist]
private function demonSheilaResist():void {
	clearOutput();
	outputText("You back away from the demon and raise your [weapon] with a dour glower.  Sheila purses her lips at you, then says, \"<i>Not in the mood, eh mate?  I'm so horny though... I bet I could get you into it.  Let me show you how much I love you...</i>\"  Her ears twitch furiously, belying her intentions as she");
	//[(sheila corruption < 30)
	if (sheilaCorruption() < 30) outputText(" thrusts her black spade forward and smears some of the constantly-oozing fluid from its tip down the length with her hand");
	else outputText(" kneads her breasts seductively, pinching her nipples");
	outputText(".  Your posture softens a bit as she reaches out to you");
	if (sheilaCorruption() < 30) outputText(", tilting her palm to dribble a handful of strong-scented dark oils");
	outputText(", but as she giggles sadistically and starts to approach, you tense up again.  It's pretty clear by the way she swaggers dismissively that she isn't taking the rejection well!");
	//go to fight
	startCombat(new Sheila());
}

//[Demon Sheila - Talk]
private function demonSheilaTalk():void {
	clearOutput();
	outputText("Questions nag at you, and you ask Sheila if she wouldn't mind answering a few of them.  She struts over and ");
	//[(not horse)
	if (!player.isTaur()) outputText("takes your arm in hers, then slips the other hand into your armor");
	//[(horse)
	else outputText("between your legs");
	outputText(" to touch your ");
	if (player.hasCock()) outputText("[cock]");
	else if (player.hasVagina()) outputText("[vagina]");
	else outputText("smooth skin");
	//[(lib <20)
	if (player.lib < 20) outputText(", giggling as your expression petrifies");
	outputText(".  \"<i>Anything for you; I'll just find something to occupy my attention.  What's on your mind, love?</i>\"");
	//plus lust depending on sens
	dynStats("lus", 2+player.sens/5, "resisted", false);
	//[The Change][Her Colony][What Now?][Fuck Off]
	menu();
	addButton(0,"The Change",askDemonSheilaAboutDahChange);
	addButton(1,"Her Colony",askDemonSheilaAboutHerColony);
	addButton(2,"What Now?",talkToDemonSheilaAboutWhatNow);
	addButton(3,"Fuck Off",tellSheilaDemonToFuckOff);
}

//[ Demon Sheila - Talk - Fuck Off]
private function tellSheilaDemonToFuckOff():void {
	clearOutput();
	outputText("\"<i>Oh,</i>\" she says.  \"<i>Don't be like that.  You're my best mate, you know.  My beloved.  I'll never let you go, ever.</i>\"  Her eyes gloss over a bit, ");
	//[(RNG decides if dis bitch crazy, bias toward sane)
	if (rand(10) < 3) {
		outputText("and she blurts, \"<i>I know I can make you understand.  You can't go until you say it back!</i>\"  You pull her hand free and back away from her, but she advances again, trying to grab you!");
		startCombat(new Sheila());
		return;
	}
	else {
		outputText("but she remasters herself with effort.  \"<i>No worries.  I'm sorry to hear you don't have any time for love, my special one.  I'll be here until you do, thinking about you and touching myself.</i>\"  She releases you and steps away, then crudely shoves her spade through her thighs, grabs it, and half-moans as she thrusts her pelvis back and forth, jerking the thick black flesh in her hand.  With a wink, she abruptly releases it, then turns her back and departs.");
		doNext(camp.returnToCampUseOneHour);
	}
	//go to fight if bitch is crazy, else plus lust and return to camp
	dynStats("lus", 10);
}

//[Demon Sheila - Talk - The Change]
private function askDemonSheilaAboutDahChange():void {
	clearOutput();
	//[(if sheilacite >= 1)]
	if (flags[kFLAGS.SHEILA_CITE] >= 1) {
		outputText("Sheila blushes deeply.  \"<i>Silly.  You were there.</i>\"  She looks at you, pupils dancing as she remembers the lovemaking session that led to her current form.  \"<i>I suppose that's not what you're asking, though.</i>\"");
		outputText("\n\n\"<i>How can I say this?  It felt... monumental.  As I came with you, all my cares slipped away.</i>\"  Sheila lowers a hand to her crotch and begins to tease herself");
		if (player.hasCock()) outputText(", and you feel a monument of your own being erected");
		outputText(".  \"<i>Every squeeze of my pussy compressed my focus, too, until my mind was clearer than the juice you made me flow with.  I realized my purpose there, with you.</i>\"");
		outputText("\n\nYou raise an eyebrow at that.  Sheila smiles and explains, \"<i>Strange to say, but the captain was right.  My purpose in life really is to fuck.  When you and I were together, I forgot about all the whining, the unimportant nagging that was dumped on me all my life.  The digging, the worrying, the hiding... it never mattered.  Any of it.  You were what made that clear for me; having you is what I care about.</i>\"  She blows you a kiss.  \"<i>So... we could do something real, if you like.</i>\"");
	}
	//(else if sheilacite <= -1)
	else if (flags[kFLAGS.SHEILA_CITE] <= -1) {
		outputText("Sheila looks wistful.  \"<i>Well... I wish it could have been with you.  But after you left me, I fingered myself so hard that my voice attracted an imp.  Not a gnoll, or a satyr, or even one of those scary fuckin' salamanders that are on fire all the time, but an honest-to-god imp.  Just this ragged little beat-up thing, one step away from dead but still trying to get his old fella in something to fill it with his seed and carry on his line.</i>\"");
		outputText("\n\n\"<i>He was inside me in a blink, thrusting away like it was all that mattered, like his life wasn't worth shit if he couldn't ejaculate in me.  And...</i>\"  She looks at you shyly, and blushes.  \"<i>He was right.  Sex really is all he was good for, all anyone is good for.  As he came and flooded me with that hot spunk, something twigged in me.  I just let go of everything: the worries, the pretense, the effort to be a good, obedient worker.  God, that orgasm!  I sucked him dry!  And the whole time I lay there twitching and squeezing his little whacker, I just cried, and cried, as I realized how wrong I was to ever have cared about any of it.  Fucking is what matters, [name].  It's the real thing.  Even the basest imp knows that.  I could show you...</i>\"");
	}
	//[(additional PG if PC looks masculine or has Bulge Armor perk)
	if (player.femininity < 50) {
		outputText("\n\nThe girl leans in and lowers her voice.  \"<i>I feel most rapt, you know, when a bloke ejaculates in me.  It feels... pure, and right, like he's admitting his purpose in life is to give me babies.  Without pretense or bullshit.  I love it, and if you come inside me, I love you too.</i>\"  Sheila blushes again.  \"<i>That sounds sappy, but... would you like to be loved?</i>\"");
	}
	//plus lust, present choices [Another Question][Let Her Fuck(req lust >=30)][Resist]
	dynStats("lus", 12, "resisted", false);
	menu();
	addButton(0,"Another Q.",demonSheilaTalkAnotherQuestion);
	if (player.lust >= 33) addButton(1,"LetHerFuck",sheilaLetHerFuckYou);
	addButton(2,"Resist",demonSheilaResist);
}

//[ Demon Sheila - Talk - Her Colony]
private function askDemonSheilaAboutHerColony():void {
	clearOutput();
	outputText("\"<i>That place?  Do you wanna go there?</i>\"  Sheila smiles duplicitously, then lifts your chin and steals a kiss before you can pull away.  \"<i>Got no qualms about showing you the way to that nest of prudes, but...</i>\"  Her eyes darken.  \"<i>There's nothing left now.  A shame you didn't insist earlier, they could have stood to learn what a ripper " + player.mf("man","woman") + " is.</i>\"");
	
	outputText("\n\nShe giggles.  \"<i>The first thing I did when I got my new gift was to go home and share it with my loved ones, of course.  It felt incredible, [name]!  When we climaxed and they drank of me, it pulled away all my lust and longing and left me full of happiness and complete oneness.  And every time one drained me dry, I would fill back up again, to pour myself into another.  Thanks to you opening the door, I was able to express my feelings for them like I never could.</i>\"  The girl leans her head against you and closes her eyes.  \"<i>Especially to the captain.</i>\"");
	
	//(corr <30)
	if (player.cor < 30) outputText("\n\nHorrified");
	else outputText("\n\nInterested despite yourself");
	outputText(", you ask what happened to him.  Sheila smiles serenely before answering.  \"<i>Unsurprisingly, his prick was all too eager to fill me with sperm after the countless sermons he preached about it being every woman's duty to expand the clan.  He barely lasted three minutes when I climbed atop him.  Oh, that little squirt was the most satisfying one.  Watching him melt under me drove home how much power I've always had... I wish I could have known when I was just an awkward little girl, sitting through his browbeating lectures on loyalty and servitude.</i>\"");
	outputText("\n\nSheila reaches up to tug at her earring.  \"<i>This is his... the lethicite, I mean.  The remains of his mortality after he devoted himself to my pussy and became a demon.  Small, right?  I nearly laughed when I saw how piddly and meager his soul really was.</i>\"");
	
	outputText("\n\nImagining the number of souls that were ");
	//(corr >=75)
	if (player.cor >= 75) outputText("harvested that day, you sigh wistfully");
	else outputText("stolen that day, you wince");
	outputText(".  Sheila, peeking at you with one eye from under her bangs, interprets your expression correctly.  \"<i>Wondering where the others went, love?</i>\"  She releases her grip on your arm and holds out the hand that's not exploring your [armor], displaying several rings.  \"<i>The rings are my closest.  I kept them for sentimental reasons.  The rest, well... I ate them.</i>\"");
	
	outputText("\n\nAs you stare at her, she opens both eyes and meets your gaze defiantly.  Flashes of lavender dance in her cold irises, inclining you to believe her words.  \"<i>They were delicious, [name].  Every one I consumed made me feel more powerful, bigger, more important, more like a sex goddess.  By the time I got to the colony's inner sanctum, I was knocking people over with a touch.  Weaker blokes were soaking their dacks with precum when they saw in my eyes what I wanted to do to them.  On that note...</i>\"  She looks harder at you, and you can feel a fantasy making its way into your mind, one where ");
	//[(cock)
	if (player.hasCock()) outputText("she ties you down and rides you until she's so full of your spunk that she can push it back out just by pressing on her stomach");
	else outputText("she binds your hands and sits on you, teasing your helpless body with her oozing, throbbing spade until she comes all over you, spraying dark slimy fluid from it");
	outputText(".  You ");
	if (player.cor < 50) outputText("break eye contact, blushing");
	else outputText("stare into her shining eyes, getting hotter and hotter as the vision plays out to the very end");
	outputText(".");
	
	outputText("\n\n\"<i>Did you like my idea, lover?</i>\" she laughs.");
	
	//plus lots of libido-based lust, display choices [Another Question][Let Her Fuck(req lust >=30)][Resist]
	dynStats("lus", player.lib/3+5, "resisted", false);
	menu();
	
	addButton(0,"Another Q.",demonSheilaTalkAnotherQuestion);
	if (player.lust >= 33) addButton(1,"LetHerFuck",sheilaLetHerFuckYou);
	addButton(2,"Resist",demonSheilaResist);
}

//[ Demon Sheila - Talk - What Now?]
private function talkToDemonSheilaAboutWhatNow():void {
	clearOutput();
	//fucking daddy issues
	outputText("\"<i>What will I do now?  What else, my silly love?</i>\"  Sheila looks out over the plains.  \"<i>I'm always hot for you.  We could have a bit of a naughty, and make each other feel good.</i>\"");
	
	outputText("\n\nThe woman leans in confidentially.  \"<i>Since you asked, mate, I'll spell it out... I have a lot more control over my power now.  I can use a little of it when I'm not coming, as long as we're touching... don't even have to use it at all, if I focus.  I could send all of my sensation to you as I finish.  Or I could sip at yours and use it to extend my climax instead, and let you ride the edge as long as we're together.  We could literally spend the day in one long orgasm...</i>\"");
	
	//(lib>=30)
	if (player.lib >= 30) outputText("\n\nYour eyebrows rise.  \"<i>Got your attention, did I?  But,</i>\"");
	else outputText("\n\nYour mouth hardens.  \"<i>You're right,</i>\"");
	outputText(" Sheila says, \"<i>I'm going to save that one for our honeymoon, instead.</i>\"  Her eyes twinkle with infatuation.  \"<i>I could even pull the taint of this land out of your body and use it to make mine more lewd for you, my " + player.mf("knight-champion","great lady") + "...</i>\"");
	
	outputText("\n\nShe raises her hand and takes your chin, bringing your gaze over to meet hers.  As the seconds stretch into minutes, it's unclear whether she's trying to be romantic or if she's taking your measure somehow.  Finally, she speaks.  ");
	//(corr<50)
	if (player.cor < 50) {
		outputText("\"<i>I don't think I will, though, my sooky mate... I'd rather stain you in my colors, even if it costs my body to do it.  Or, would you like me more if my proportions were modest?  You, my confident, courtly " + player.mf("lord","dame") + ", and I, your worshipful, tomboyish " + player.mf("squire","lady-in-waiting") + ", secretly in love with you and game to follow you anywhere and do anything for you to make you acknowledge me and accept ");
		if (player.hasCock()) outputText("my pussy");
		else outputText("the dick I grow for you");
		outputText("?  </i>Anything?<i>");
	}
	else {
		outputText("\"<i>... would you like that?  If my pointers were so big that all I could do was wait for you patiently as your sex-toy, your possession; growing whatever new parts you need to complement yours, relying on you and welcoming you home at the end of the day, inviting you to rest in the bosom you created after we lie together and make our babies... would that gratify you?  Would you love me then?");
	}
	outputText("</i>\"");
	
	outputText("\n\nSheila releases your face and looks forward again.  \"<i>I want you.  I want children with you too, if you'll ");
	if (player.hasCock()) outputText("give them to me");
	else outputText("have them for me");
	outputText(".  I dunno what could be simpler.</i>\"");
	
	outputText("\n\nShe's so fixated on having children now, more so than anyone you've met");
	//[(PC has been propositioned by Amily)]
	if (flags[kFLAGS.AMILY_OFFER_ACCEPTED] > 0) outputText(" save one.  Actually, the two are a bit reminiscent of each other..");
	outputText(".  Yet, any offspring a demon makes will be imps, right?");
	
	outputText("\n\n\"<i>Imps are trustworthy, like dogs,</i>\" she retorts, frowning.  \"<i>Count on them to care about exactly one thing, and they're always honest about it.  Not so with the rest of the pretentious trash dirtying this world, lying with a smile like they know what's best for the others around them.</i>\"  Sheila begins tracing meaningless shapes on your arm.  \"<i>It's what I like about you too, mate");
	if (player.cor < 50) outputText("; even though you hide it, I've seen it lurking");
	outputText(".  Feel like flying your colors for a while?</i>\"");
	
	//plus libido-based lust damage, output choices [Another Question][Let Her Fuck(req lust >=30)][Resist]
	dynStats("lus", player.lib/15, "resisted", false);
	menu();
	addButton(0,"Another Q.",demonSheilaTalkAnotherQuestion);
	if (player.lust >= 33) addButton(1,"LetHerFuck",sheilaLetHerFuckYou);
	addButton(2,"Resist",demonSheilaResist);	
}

//[Demon Sheila - Talk - <any option> - Another Question]
private function demonSheilaTalkAnotherQuestion():void {
	clearOutput();
	//(if lust <=99)
	if (player.lust <= 99) {
		outputText("Sheila reaches farther down, ");
		//(cock)
		if (player.hasCock()) outputText("slipping more of her finger and thumb around your penis");
		else if (player.hasVagina()) outputText("parting your lips more");
		else outputText("rubbing your bare groin");
		outputText(" even as she smiles encouragingly.  \"<i>Sure, mate.  Amuse yourself.  I certainly intend to.</i>\"");
		//plus sens-based lust damage, display talk options again
		dynStats("lus", player.sens/10);
		menu();
		addButton(0,"The Change",askDemonSheilaAboutDahChange);
		addButton(1,"Her Colony",askDemonSheilaAboutHerColony);
		addButton(2,"What Now?",talkToDemonSheilaAboutWhatNow);
		addButton(3,"Fuck Off",tellSheilaDemonToFuckOff);
	}
	//(if lust > 99)
	else {
		outputText("Sheila grins wickedly as you stammer and fumble your words.  \"<i>Nah,</i>\" she answers, using her free hand to turn your head.  \"<i>I think it's time we left talking behind, don't you?</i>\"  As her eyes meet yours, your body quavers dangerously; you've let her stay too close for too long, and she glows with anticipation as she prepares to take what she wants.");
		//output loss scene determined by RNG and player parts
		menu();
		addButton(0,"Next",loseToSheila,true);
	}
}

//[Demon Sheila - Let Her Fuck]
private function sheilaLetHerFuckYou():void {
	clearOutput();
	outputText("The naked flesh pressed against you fills your mind with indulgent daydreams, and Sheila reads them right from your distracted face as if you were a book.  \"<i>That'll be a yes, then?</i>\" she asks, playing the slitted tip of her spade along your fingers.  \"<i>Or are you going to make me use this on myself again?  I get quite lonely, you know.</i>\"");
	
	outputText("\n\nYou shake your head and, opening your posture, allow her to wrap her arm completely around you.  \"<i>Oh, [name].  I knew you loved me.</i>\"  She kisses you passionately, pressing her ");
	if (sheilaCorruption() >= 40) outputText("pillowy ");
	else outputText("pert ");
	outputText("breasts against you.");
	//output loss scene dependent on RNG and player parts/choice
	menu();
	addButton(0,"Next",loseToSheila,true);
}

//Post-demon pregnancy notif (demon sheila = 1 and sheilapreg = 4)
//increment imp children counter?
private function demonImpChildren():void {
	clearOutput();
	outputText("\"<i>[name]!</i>\"  A swishing in the grass behind you is the only prelude you get to a nude Sheila pressing herself against you in a hug, ");
	//(sheila corruption < 40)
	if (sheilaCorruption() < 40) outputText("her perky nipples rubbing into your arm as she snuggles up");
	else outputText("her enormous, pendulous breasts practically parting around you to wrap you up alongside her arms");
	outputText(".");
	
	outputText("\n\n\"<i>Guess what?  I had your baby!  He was the most darling little thing.</i>\"");
	
	outputText("\n\nShe takes your look of surprise as permission to elaborate.  \"<i>Mmm, why the wide eyes, mate?  Our people always pushed them out fast.  Except instead of tucking him into a snuggly against my tits, I tucked him into somewhere a bit... lower.</i>\"  She hugs your arm closer, fairly rubbing her pussy on the back of your hand and leaving a trail of her lube as she slides her own fingers into your [armor].  \"<i>He has his " + player.mf("daddy","other mommy") + "'s cock.");
	//(if no cock)
	if (!player.hasCock()) outputText("  Or, had...</i>\" she finishes with a frown as she reaches your bare groin.  \"<i>Where'd you leave that magnificent old fella?  I was lookin' forward to another go.</i>\"  She pulls her hand out, then leans toward you with a pout.  \"<i>I'm so horny, too...</i>\"");
	//(if cock)
	else {
		outputText("  Still, it's not the same as having you inside me...</i>\"  She squeezes the neck of your [cock] and then pulls her hand away, slipping it between her own legs.  \"<i>I was thinking you could help me make another, and maybe up the population of men worth a damn around here.</i>\"  Reclining, she spreads her thighs, pulling apart her small, smooth labia ");
		//[(sheila corruption <=80)]
		if (sheilaCorruption() <= 80) outputText("with her fingers to make sure the invitation is all the way open");
		//(else)
		else outputText("with her split tail while she cradles her massive tits to make sure you see the open invitation");
		outputText(".  Impatiently, she rubs her stubby, drooling, phallic spade against the hole, accentuating the imagery.  You can feel the blood rushing to your groin as she gives herself shallow, teasing strokes.");
	}
	pregnancy.knockUpForce(); //Clear Pregnancy
	flags[kFLAGS.SHEILA_IMPS]++;
	//plus lust if PC has cock
	if (player.hasCock()) dynStats("lus", 10+player.lib/10, "resisted", false);
	//[Other Sex][Knock Up(cock only)][Leave]
	menu();
	addButton(0,"Other Sex",pregDemonSheilaOtherSex);
	if (player.hasCock()) addButton(1,"Knock Up",pregDemonSheilaKnockUp);
	//leave should be default spacebar option
	addButton(4,"Leave",leavePregDemonSheila);
}

//[Preg Demon Sheila - Leave]
private function leavePregDemonSheila():void {
	clearOutput();
	outputText("You shake your head at her, backing away.  She sulks a bit, then speaks.  \"<i>I guess I'll let you off, since you sexed me up so well before.  Next time, though, you're gonna give me some... satisfaction.</i>\"  She runs a finger teasingly down her chest, giving you half a smile.");
	//(if cock)
	if (player.hasCock()) outputText("  Your refusal doesn't stop her from consummating the affair herself by slipping the oozing spade past her entrance and thrusting vigorously.  \"<i>What?</i>\" she says, shaking you from your distracted stare.  \"<i>I'm always randy now, and you're not going to spend time with me, so... move along.  Maybe someone fun will find me and join in.</i>\"  She throws her head back as her slippery tail makes a particularly deep push, crying her pleasure carelessly to the glaring sun.  The wet schlicks of her self-love follow you until the magic of the realm brings you abruptly back to camp.");
	
	//plus more lust if cock, go to camp
	if (player.hasCock()) dynStats("lus", 10);
	doNext(camp.returnToCampUseOneHour);
}

//[Preg Demon Sheila - Other Sex]
private function pregDemonSheilaOtherSex():void {
	clearOutput();
	outputText("Her eyebrows knit as you propose an alternative.  ");
	//[(if cock)
	if (player.hasCock()) {
		outputText("\"<i>Well now, I think I get a say, don't I?  I was really hoping to have your seed inside me... it's practically worth bottling.</i>\"  She ");
		if (sheilaCorruption() >= 80) outputText("heaves onto her feet, heavy breasts swaying");
		else outputText("nimbly hops to her clawed feet");
		outputText(", and runs her hands distractingly along the curves of her hips.  \"<i>You can do what you like with my body, love... if you can convince me.  Of course, I'll claim the same privilege!</i>\"  Sheila jumps at you, leaving no doubt what kind of 'convincing' she expects to do!");
		startCombat(new Sheila());
	}
	//(if no cock)
	else if (player.hasVagina()){
		outputText("\"<i>Well, that doesn't sound as good as having your amazing self inside me, but I'll take what I can get, love.</i>\"  Sheila snuggles closer to your arm, using one hand to turn your fingers out and slip them between her soft, hot labia, then kisses you on the cheek.  \"<i>So, what do you have in mind?  I'm all yours.</i>\"  She pulls your fingers out and sits down on the grass, spreading her thighs and looking at you expectantly.");
		//go to fight if cock, else plus lust and present victory sex menu
		dynStats("lus", 15);
		beatUpDemonSheila(false);
	} else {
		doNext(camp.returnToCampUseOneHour);
	}
}

//[Preg Demon Sheila - Knock Up]
private function pregDemonSheilaKnockUp():void {
	clearOutput();
	outputText("As she smears the entrance to her snatch with the slippery slime drooling out of her slitted spade, your [cock] hardens painfully.  The eye-fucking she's giving you while teasing her breasts doesn't help matters, and soon you're so erect that you have to expose your shaft just to relieve the pressure.  With the bulk of your dick bobbing free of your [armor], Sheila waggles her eyebrows at you.  \"<i>So... yes?</i>\"");
	//output demon Sheila cock victory sex scene consonant with player's length and suppress gems/xp/item gain
	menu();
	if (player.cockThatFits(56) >= 0) addButton(0,"Next",missionaryForThePurposesOfCreatingImpsWithSheila);
	else addButton(0,"Next",bigDickAndThighs);
}


//Loss scenes - RNG's pick (bias toward norml cocks, but all should be possible if a PC meets multiple reqs):
//some losses auto-increase PC corr and decrease sheila corruption, others have the normal chance dependent on PC corr - please manipulate sheila corruption in increments of 10, to make the breast size changes immediately noticeable
//loss intro (only if coming from a fight, not from a scene that auto-outputs a loss to finish itself)
//[You lower your [weapon], unable to continue the fight.  ]
//thread into chosen scene with no new pg
internal function loseToSheila(consensual:Boolean = false):void {
	clearOutput();
	//Loss - if PC manages to lose by HP somehow (overrides all other losses)
	if (player.HP < 1 && !consensual) {
		outputText("Your erstwhile opponent's eyes glimmer with excitement as you collapse from your injuries, and she runs over to you.  The demon strips off your [armor] eagerly, but you can't stay awake for the fun.  Consciousness slips away and you pass out.");
		//--Next--
		model.time.hours += 8;
		if (model.time.hours > 23) {
			model.time.hours -= 24;
			model.time.days++;
		}
		menu();
		addButton(0,"Next",loseToDemonSheila);
	}
	else {
		var choices:Array = new Array();
		//Loss - normal cocks get rode (for cockarea <= 56)
		if (player.hasCock() && player.cockThatFits(56) >= 0) 
			choices[choices.length] = loseToNormalSheilaAndGetRidden;
		//Loss - tail-spade sounding for fuckhueg cock (for cockarea > 56)
		if (player.hasCock() && player.biggestCockArea() > 56)
			choices[choices.length] = tailSpadeSoundingForFuckHugeDongsWithDemonSheila;
		//Loss - clit-swelling and clit-sounding or clit-anal
		if (player.hasVagina())
			choices[choices.length] = clitSwellingDemonSheilaClitSoundingAnal;
		//Loss - unsexed joke scene
		if (player.gender == 0)
			choices[choices.length] = aintGotNoGenderAndKangarooRaped;
		//RUN DAT SHIT, YO!
		choices[rand(choices.length)]();
	}
}

private function loseToDemonSheila():void {
	clearOutput();
	outputText("Eight hours later, you come to, bruised and sore... and find yourself lying on the ground with your head in Sheila's lap; she's petting your [hair] absently.  \"<i>Awake, are you?</i>\" she grins, looking down at you.  \"<i>Where did you get all those wounds, anyway?  Ya know... you can ask for my help if the wildlife's giving you trouble - we'll just go back to my place and spend all our time in the nuddy.  Our imps can bring us food and drinks.  New playmates, too.  Want to come home with me?</i>\"");

	outputText("\n\nThe fog in your head begins to clear.  Were you really just watched over by a demon?");
	
	outputText("\n\nSheila hems and haws nervously.  \"<i>Well, no one's allowed to use your body unless I let them.  I forbid it.  And... and I get off best when I can see the face you make as you come.  It's so cute.  I'm not just going to boff you while you're asleep.  U-unless you want me to, ah...</i>\"");
	
	outputText("\n\nThe woman nerves herself and her expression hardens as she re-rails her train of thought.  \"<i>No; nevermind that.  If you're going to get into blues all the time, I won't wait for you to ask for my help.  I'll take you with me whether you want it or not.  You're mine, and I can't bear the thought of you trying to tussle with some standover goon and carking it.  Get up.</i>\"");
	
	outputText("\n\nStill shaken, you stand and let Sheila do the same.  She narrows her eyes at you before speaking again.  \"<i>Be more careful, mate.  The idea of my " + player.mf("boy","girl") + " being fucked by trash makes me ill.</i>\"  Saying nothing more, the woman turns and leaves you to walk back to your camp.");
	//suppress the "you'll probably come to in eight hours blah blah" message, subtract gems and add 8 hours, go to camp
	player.orgasm();
	player.HP = player.maxHP();
	player.changeFatigue(-50);
	combat.cleanupAfterCombat();
}

//Loss - normal cocks get rode (for cockarea <= 56)
private function loseToNormalSheilaAndGetRidden():void {
	clearOutput();
	var x:int = player.cockThatFits(56);
	outputText("Sheila pushes you onto the ground");
	if (player.isTaur()) outputText(" and you're forced to put your forelegs down for support as you come to rest on your haunches");
	else outputText(", spreading your legs.  The demon unfastens your [armor] and strips it from your bottoms easily");
	outputText(", exposing your " + player.multiCockDescriptLight() + ".");
	
	outputText("\n\n");
	//[(multi)
	if (player.cockTotal() > 1) outputText("\"<i>All of these look ripper, but... I want this one today,</i>\" she says, selecting your [cockFit 56].  ");
	outputText("She wraps her hand around it and begins pumping up and down, squeezing out a drop of precum that she smears onto her palm.  \"<i>You're so eager,</i>\" Sheila giggles.  \"<i>Are you already about to burst?  That's no good... I wanted to play a bit more.</i>\"");
	
	outputText("\n\nThe demon releases your dick, watching raptly as it bobs and twitches, then scoots up to you and");
	if (player.isTaur()) outputText(", draping your forelegs over her shoulders,");
	outputText(" presses her " + sheilaCup() + " breasts");
	if (sheilaCorruption() < 100) outputText(" against you, dragging her nipples against yours.  ");
	else outputText(" against you so forcefully that they part around your chest.  ");
	outputText("\"<i>Such a " + player.mf("handsome bloke","pretty sheila") + ", with such a nice dong,</i>\" she whispers, \"<i>I'm going to have to take you for a ride.  Try not to come as soon as you get in!</i>\"");
	
	outputText("\n\nSheila grins viciously and sinks down on your [cockFit 56], sliding it into her pussy at a painstaking pace");
	//[(multi)
	if (player.hasCock()) outputText(" and slipping the unused remainder of your manhood between her thighs");
	outputText("; you can feel every new inch of heat as she lowers her body.  The woman moans, gyrating her hips, and " + player.sMultiCockDesc() + " twitches in painful erectness.");
	
	//balls fork
	if (player.balls > 0) {
		outputText("\n\n\"<i>Oh my,</i>\" she says, looking into your rolling eyes.  \"<i>Can't hold it?  Well, if you're going to squirt so soon, mate, let's at least make sure you squirt a lot!</i>\"");
		
		outputText("\n\nBehind the demon, her black, stubby spade dangles ominously above your [sack] and its brown neighbor wraps around it, squeezing and stroking.  A drizzle of dark, oily secretion falls from the end; as it lands, your [balls] begin to heat up painfully.  Your stomach turns as another drop of hot slime drools from your demonic lover onto your tender nuts; it feels like something is inside them, trying to push outwards in all directions.");
		//(not horse)
		if (!player.isTaur()) outputText("  Sheila takes your face in her hands and presses it into her breasts as she reassures you.");
		outputText("\n\n\"<i>Be over soon, my love...</i>\" the demon coos, jerking her tail vigorously to coat your scrotum.");
		
		outputText("\n\nIt's not long before the awful queasiness subsides, though the pressure only becomes evenly distributed; if anything, it's a bit more intense.  Looking below the woman's cunt curiously, you're met with a swollen, red sack that's covered in a dark sheen of oil and nearly twice its former size!");
		
		outputText("\n\n\"<i>Ahaha,</i>\" Sheila laughs, \"<i>got lots of little spermies for my pussy now?</i>\"  Indeed, you feel pent-up just looking at your newly-enlarged [balls]... like if you don't blow your load soon, it's going to start leaking from your pores!  Your [cockFit 56] hardens again, more from desperate necessity than from pure arousal; your demon hums in pleasure as it fills her vagina, and she begins to raise and lower her hips, slapping her ass against your sensitive [sack] and whispering to you.  \"<i>[name]... I'm getting off on just the idea of you flooding me with all that semen.</i>\"");
		
		outputText("\n\nYou groan in agreement as she slides your turgid shaft back into her pussy on a particularly well-angled stroke, dragging the [cockHeadFit 56] against her vaginal wall and forcing out a thick stream of lubricant.  \"<i>God,</i>\" the demon gasps, \"<i>even your prostate is working overtime, mate!  Your precum feels like an ejaculation by itself... I can't wait for you to come any longer!  Give your seed to me, now!</i>\"");
		outputText("\n\nSheila's pussy spasms around you and she looks into your eyes; you feel a wave of compulsion from them, and arousal flows into you from each place your " + player.skin() + " touches her body.  Unable to withstand her orgasm-fueled power, your [balls] pull close to your shaft and you let go of your climax, grabbing her hips and dumping semen into her cunt");
		if (player.cockTotal() > 1) outputText(" and lap");
		outputText(" just like she's dumping feelings into your head.  \"<i>Lover!</i>\" she screams.  \"<i>Pack me with your babies!</i>\"");
		
		outputText("\n\nAs if you could help it at this point... your [cockFit 56] fills her pussy with thick spunk and the pressure begins forcing it into her womb; as Sheila's mouth hangs open in awe, your balls shift upwards again and a second orgasm begins!  You force her down to the base of your cock using your ");
		if (player.isTaur()) outputText("forelegs");
		else outputText("hands");
		outputText(", displacing a glob of cum from her pussy that's soon followed by others as you ejaculate once more.  The jizz is so dense with sperm that it's thick, almost colloidal; it jiggles on her skin, barely sliding downward as your hips ram against hers.  It takes nearly ");
		//(normal skeet)
		if (player.cumQ() < 250) outputText("ten minutes and two");
		//(big skeet)
		else if (player.cumQ() < 1000) outputText("thirty minutes and four");
		else outputText("fifty minutes and eight");
		outputText(" more orgasms, but finally your balls empty of their demonically-induced load and your lover pulls away and stands up.");
		
		outputText("\n\n\"<i>I don't think I've ever felt so full in my life...</i>\" Sheila says, dreamily holding her stomach as an avalanche of cum-clumps rolls slowly out of her cunt.  You fall flat and are already passed out by the time she stops rubbing her midriff, imagining the child she'll mother.  She leans down.  \"<i>Falling asleep after coming... for shame, mate.  I didn't even get to tell you I love you.</i>\"  The demon plants a kiss on your cheek, squeezes your scrotum once more, and walks away, bottom half completely stained white.  Your swollen nuts slowly deflate as you doze, though they don't shrink down quite as far as their original size.");
		//end scene, reduce lust, increment sheilapreg by 1 (in other words, 100% preg chance), increase ball size by ~10% and increase cum multiplier very slightly, reduce sheila corruption by 10 and increase PC corr by 10
		pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_SHIELA);
		player.ballSize++;
		if (player.ballSize < 10) player.ballSize++;
		player.cumMultiplier++;
		player.orgasm();
		dynStats("cor", 10);
		sheilaCorruption(-10);
		if (getGame().inCombat)
			combat.cleanupAfterCombat();
		else doNext(camp.returnToCampUseOneHour);
	}
	//(else if no balls)
	else {
		outputText("\n\n\"<i>Oi, [name],</i>\" Sheila says, pausing now that she's reached the base of your [cockFit 56].  You look up at her, waiting for the other shoe to drop.  \"<i>Where do you suppose your seed comes from?</i>\"");
		outputText("\n\n\"<i>... What?</i>\" you ask.");
		
		outputText("\n\n\"<i>Well.  You have no balls,</i>\" the demon continues, slowly beginning to slide her pussy back up your tool.  \"<i>So... how do you have sperm?  How can you get people pregnant?</i>\"");
		
		outputText("\n\n\"<i>Ughh...</i>\" you groan, as she sinks back down.  \"<i>I don't know... aren't you from here?  I wasn't like this before I came through the portal for the first time.</i>\"  ");
		if (player.isTaur()) outputText("You force her downward with your forelegs to");
		else outputText("You grab her hips and");
		outputText(" help her impale herself on your tool.");
		
		outputText("\n\nThe demon shudders as your [sheath] bumps up against her vulva.  \"<i>Y-yeah, but I never paid attention to growing dongers without balls and that kinda arcane stuff, mate... didn't think I'd end up fucking a strange " + player.race() + " like you until you stuck it in me.  I always wanted to marry a normal bloke like my dad.</i>\"");
		
		outputText("\n\n\"<i>Pardon,</i>\" you interrupt irritably, pushing her back up, \"<i>but </i>you're<i> the one who's sticking it in you.  And if you want to fuck your father so badly, go find him and leave me alone.</i>\"");
		
		outputText("\n\nSheila's eyes twinkle mischievously.  \"<i>I will when I see him, love.  In the meanwhile, you get all the benefits of my misplaced affection.</i>\"  She descends your cock again, shifting her hips to rub you against a different side of her pussy.  \"<i>I notice our little conversation kept you from shooting your wad too early, like a virgin...</i>\"");
		
		//corr fork
		//[(corr < 70)]
		if (player.cor < 70) {
			outputText("\n\nYou stiffen in embarrassment.  Sheila smiles and plants a kiss on your " + player.skinFurScales() + ", then looks at you innocently.  \"<i>Don't be mad, mate.  I just wanted our time together to last.</i>\"");
			outputText("\n\n\"<i>Is that so?</i>\" you reply, beginning to fuck the demon harder to make up the arousal she frittered away.  Sheila moans as you work your [cockFit 56] into her hole vigorously, dragging it against the entrance and smearing your intermingled fluids on her groin.");
			
			outputText("\n\n\"<i>Yesss...</i>\" she hisses, passing air through her teeth as you hit a sweet spot.  \"<i>You're my one and only.</i>\"");
		}
		//(else)
		else {
			outputText("\n\nYou frown as her piquant revelation annoys you further.  \"<i>Like I care about whether you finish, you nuisance,</i>\" you retort, beginning to buck her hips up and down violently.  \"<i>Why don't you shut up so I can blow my load, then roll off and make me a snack while I nap?</i>\"");
			
			outputText("\n\nSheila kneads her breasts as you berate her and batter her cunt.  \"<i>Haha... is that what you want your woman for?  To suck the spunk from your fat dick and then bring you dinner?  I can do that... though I don't promise not to jerk my tail off over your food.  I get mean if I don't come every day.</i>\"");
		}
		//end corr fork
		
		outputText("\n\nThe rough fuck goes on, pushing you back toward your climax, but your demon partner seems to be ahead of you no matter how hard you rail her, looking into your eyes lovingly as you shake her body with your thrusts.");
		
		outputText("\n\n\"<i>You know I don't really care which of us is on top in the relationship, right?</i>\" she says.  \"<i>Stuff like dominance and submissiveness is all shit; it doesn't matter.  I'd gladly do anything you like and be a filthy slave for you as long as I knew you'd never flick me on.</i>\"  Sheila wraps her arms around your chest and uses the leverage to ascend your dick, eyes glassy with excitement.  \"<i>The thing I want is what's best for you, mate... and what's best for you is me, and only me.  A-as soon as you agree to that, I'll stop teasing you and marry you on the spot so we can start our life together!</i>\"");
		
		outputText("\n\nThe demon releases you and allows gravity and your pressure to force her back down once more, and her pussy begins to drool and squirt in orgasm.  \"<i>Ohh... c-coming!  You too!  Finish with me, love!</i>\"  Sheila leans forward and presses her lips against you, half-kissing and half-drooling; a foreign wave of climax passes into you where her skin contacts yours, and you begin to ejaculate with the demon's borrowed sensation.  Your semen pools in her pussy");
		//[(multi)
		if (player.cockTotal() > 1) outputText(" and lap");
		//[(big skeet)
		if (player.cumQ() >= 1000) outputText("; she quickly reaches capacity and pulls off, jerking your messy, slimy [cockFit 56] and letting you squirt the last of your strokes all over her face and chest");
		if (player.cumQ() >= 6000) outputText(".  So much is left that she's practically underwater by the time you're finished; she giggles and bubbles form in the oozing liquid covering her lips");
		outputText(".");
		
		outputText("\n\n\"<i>That was fun,</i>\" Sheila laughs, scooting backward away from you and leaving a trail of white on the grass.  \"<i>I'll see you later... remember what I said, mate.  Sack up and propose to me soon.</i>\"  She laughs at her own joke, then blows you a sloppy kiss and stands up to leave.  Having done most of the actual work, you take the opportunity to keel over and pass out.");
		
		//end scene, reduce lust, normal sheilapreg check, reduce sheila corruption by 10 and increase PC corr by 10]
		player.orgasm();
		dynStats("cor", 10);
		sheilaPreg();
		sheilaCorruption(-10);
		if (getGame().inCombat)
			combat.cleanupAfterCombat();
		else doNext(camp.returnToCampUseOneHour);
	}
}
		
//Loss - tail-spade sounding for fuckhueg cock (for cockarea > 56)
private function tailSpadeSoundingForFuckHugeDongsWithDemonSheila():void {
	clearOutput();
	outputText("The demon opens your [armor] and undresses you, inspecting your crotch.  \"<i>Going a bit overboard, aren't you, [name]?</i>\" she taunts, rubbing your [cock biggest] with her knee.  \"<i>I'm not quite magical enough to take this monster - maybe after a few months of fucking everything I met, I'd be that loose.</i>\"  Sheila giggles at you.");
	
	outputText("\n\nYour prick hardens in response to the stimulation, rising to attention, and she traces a finger up it longingly.  \"<i>Not that I wouldn't like to have this beaut inside me... maybe we can do the next-best thing.</i>\"  She pulls it down until it's parallel to the ground, then turns around and slips the [cockHead biggest] between her thighs, rubbing it against her pussy and mingling her fluid with the precum that oozes out.  \"<i>Nice and slick,</i>\" she confirms, fingering your urethra and sending a shiver through you.");
	
	outputText("\n\nSheila takes a half-step forward and bends over, letting your dick out from between her legs; her brown tail catches it, lassoing the shaft just behind the crown.  The smooth skin feels quite nice, and Sheila looks over her shoulder at you.  \"<i>Enjoying the view?</i>\" she asks, shaking her round ass and swinging your [cock biggest] side to side with it.  Another drop of precum answers her.");
	
	outputText("\n\n\"<i>Hold on tight,</i>\" she warns.  Before you can ask what she means, Sheila raises her black spade to the tip of your dick, smearing its oozing secretions onto your slit.  It burns a lot; all you can do is bite your lip and not call out.  Carefully watching your expression, the demon presses her spade insistently into the exit of your urethra, working it wider and inundating your [cockHead biggest] with her dark oils.  You can feel it nearly penetrating you now - Sheila shivers and squeezes her breasts as the widest part of the spade slips into your hole.  As soon as it passes the ring, she smiles wickedly.  \"<i>Here it comes!</i>\"");
	
	outputText("\n\nHer smooth brown tail tightens its grip as the demon forces her thick spade in and out of your urethra relentlessly, tugging at your cock with the lobes on the anterior, and you almost pass out from the pressure and the heat of her tainted fluids working their way into your shaft from inside.  Veins bulge on the surface as the flesh inflames; the end of your cock begins to swell, compressing her tail as she tries to pump.");
	
	outputText("\n\n\"<i>Fuck, that's so tight... you're squeezing the goo right out of me, mate!</i>\"  Sure enough, as she pulls out you can feel a large stream of fluid irritant sliding down your tool toward the base, spreading its painful warmth and inflating your dick until the entire shaft is several inches thicker and longer than before.  Sheila forces it in again, sending a new wave of sensation down your cock, one without the burning of her oils - it seems as though you've been saturated or your own precum is flooding her out.  Only when Sheila pulls partway out of your tight slit again does another dollop of her oil slide down your cock, reaching further this time before wicking into unaffected skin deep within your body.");
	
	outputText("\n\nThe demon pumps you again and again and the fluid, now running constantly from her spade as her arousal mounts, slowly inches its way deeper and deeper into you, battling with your own pre.  You begin to squirm as it edges closer to your prostate; Sheila, still watching you over her shoulder, grins mischievously as she figures out what's about to happen.  She releases your [cockHead biggest] from her brown tail, holding it in place only with the spade buried in it, then wraps that same tail around its neighbor, jerking off the black shaft vigorously by using your spilled precum for lube.");
	
	outputText("\n\n\"<i>Nnnn,</i>\" she moans, \"<i>c-coming!</i>\"  The woman's cunt drools and her tail twitches and swells; you can literally see the latter thickening progressively as something forces its way past the brown noose and into your urethra, stretching it wide.  As the bulge reaches the point where you can feel her spade lodged, the end of her tail swells and disgorges a stream of hot, thick slime; it agitates inside your cock as it slides down, pushing past precum with its greater density and sinking into you.  You wait with mounting horror as it passes the [sheath] of your cock and enters your body - as if spurred on by your reticence or the closeness of your innermost places, the voracious slime seems to speed up, racing toward your prostate.  In a wave, the foreign substance passes through it, trying to press outward and tickling the organ; in response to the hot stimulation, your body begins dumping cum into your urethra to fight back.");

	outputText("\n\n\"<i>Hahh,</i>\" Sheila laughs, out of breath.  \"<i>I can feel your dick jerking, mate... did my climax find your insides, then?</i>\"  She pulls her spent tail limply from you, letting it hang between her legs, and turns around to watch the fireworks.  The last half of the demon's climax slides down your dick, trying to push its vanguard up against your prostate for as long as possible, but your body eventually wins out; you can feel your own involuntary orgasm forcing hers back toward the open end of your [cock biggest].  The demon grins and slips a hand beneath you, stroking the underside of your prick just behind the glans, and the stimulation pushes you over the edge.  Your nerves fire, sending another load after the first, and a messy multi-shaded fan of fluid is ejected.");
	
	outputText("\n\nSheila's eyes gloss over with desire, and she turns around once more, raising her pussy to your [cockHead biggest].  \"<i>Inside...</i>\" she mumbles, and then more loudly, \"<i>Squirt it inside!</i>\"  She guides your tip to her pussy with both tails now, spreading her labia with two fingers, and the next splat goes into her.  Black and white liquid drools from Sheila's messy cunt as your oversized cock ejaculates into and onto the woman");
	if (player.cockTotal() > 1) outputText("; unguided, the ");
	if (player.cockTotal() == 2) outputText("other twitches and sprays");
	else if (player.cockTotal() > 2) outputText("others twitch and spray");
	if (player.cockTotal() > 1) outputText(" all over, coating her back, you, the grass, and anything ");
	if (player.cockTotal() > 2) outputText("else they happen to point at");
	if (player.cockTotal() == 2) outputText("else it happens to point at");
	outputText(".  Your hips automatically try to push your dick further into her warm hole but only succeed in unbalancing her, forcing the demon onto her hands.  As your climax winds down, your head leans back and your cock slips from her vulva, squirting the last stroke onto her ass.");
	
	outputText("\n\nSheila sighs happily as she stands back up, and two intermingled colors stain her thighs.  \"<i>That was... mmm.  I wonder if it feels the same for you as it does for me, love?</i>\"  She walks up to you and takes your face in her hands; planting a passionate kiss on your lips, then lowers your nerveless form to the ground.  \"<i>Rest for now, [name]... I want to do that again soon.</i>\"");
	
	outputText("\n\nExhausted, you pass out, wondering what sort of permanent changes her fluids are wreaking on your body.");
	//increase only biggest cock size by ~2-3% if possible, increase cum multiplier, reduce lust, increase PC corr by 10 and reduce sheila corruption by 10
	player.cumMultiplier++;
	player.orgasm();
	dynStats("cor", 10);
	sheilaCorruption(-10);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	doNext(camp.returnToCampUseOneHour);
}

//Loss - clit-swelling and clit-sounding or clit-anal
private function clitSwellingDemonSheilaClitSoundingAnal():void {
	clearOutput();
	//(no horse)
	if (!player.isTaur()) outputText("Sheila places her hand in the small of your back and leans in, drawing closer to your face even as she pulls your waist inward.");
	else outputText("Sheila sets her hand atop your withers, pressing down gently as she looks into your eyes.");
	outputText("  \"<i>Why don't you relax, [name]?  Lie down and let me take care of you...</i>\"  Her eyelids lower and her mouth spreads in a sly smile, and for just a moment you lose your nerve, looking into her devilish expression.  \"<i>Don't worry, love,</i>\" she says, straightening her face.  \"<i>I promise you'll enjoy this.</i>\"");
	
	outputText("\n\nBefogged but still reserved, you nonetheless allow Sheila to lower you to the grass and remove your [armor].  She ");
	//[(not horse)
	if (!player.isTaur()) outputText("turns around, then straddles your groin and looks over her shoulder.");
	//(Equus ferus caballus)
	else outputText("circles you until she reaches your rump, then turns around and kneels down herself, looking at you over her shoulder.");
	outputText("  Her black, spaded tail lifts from between her thighs and snakes toward your pussy,");
	//[(if manparts)
	if (player.hasCock()) {
		outputText(" caressing ");
		if (player.balls > 0) outputText("your [balls]");
		else outputText("the underside of your [cock biggest], before");
	}
	outputText(" forcing your lips apart and lingering on your rapidly-swelling " + player.clitDescript() + ".  \"<i>Oh, my.  What's with this ");
	if (player.clitLength <= 6) outputText("lewd little");
	else outputText("grotesque");
	outputText(" thing doing growing from a pretty girl like you?  It's just the perfect size for some fun.</i>\"");
	
	outputText("\n\nYour eyes open in alarm at the same time as her mouth does in pleasure; she jams the slit of her spade onto your button");
	if (player.clitLength > 6) outputText(", taking it several inches deep");
	outputText(".  Your head swims as pleasure from your engulfed clitoris overwhelms you, then toes the line to genuine pain.  The copious demonic fluid backing up inside her tail begins to leak around the tip, coating your clit and drooling onto your labia; your muscles tighten as the heat escalates past comfortable levels, and you begin shifting violently, trying to pull your swollen chick-stick free from the demon's anatomy.  \"<i>Ah, ah, god, [name], stop!  Don't thrash so!  You're teasing me too fast!</i>\"  Sheila's words are lost on you, sunken as you are into a hell of oversensitized skin and constant stimulation.  It feels like the nerves exposed to the torment are even multiplying, as if skin you weren't even feeling before suddenly appears to be immersed into the tainted slime.");
	outputText("\n\nYour eyes roll in temporary shock as her tail squeezes around your " + player.clitDescript() + " tighter and tighter; the siege lifts slightly, allowing you to focus with supreme effort and see that the demon is similarly affected!  Her head sags between her shoulders, even as she places two hands on the ground in front of her to steady herself.  The two tails on her butt whip spastically, squeezing another wave of painful pleasure into your crotch.  Staring, you can only watch as Sheila's thrashing black spade describes a clipped arc, a long, thick rod of flesh growing out of it to join your bodies.");
	
	//[(<=6")
	if (player.clitLength <= 6) outputText("\n\nAwareness comes to you slowly; that flesh is your clitoris, gratuitously mutated by Sheila's fluids!");
	else outputText("Though you're by now accustomed to the sight of your clitoris, more like a cock than a dainty feminine bump, this is something else altogether!  The huge thing poking into her tail is almost twice the thickness of the slim growth you remember and bulges with blood vessels; as you watch it, transfixed, a trickle of Sheila's oily, dark secretion slides down it, then is absorbed into some flesh near your groin, adding another layer of width with a pulse!");
	outputText("  \"<i>Fuck, it's so tight!</i>\" the demon gasps, now resting on her elbows with her chest and face pressed to the grass.  Her tail jerks again, yanking your stalk this way and that and releasing more of her backed-up fluids.  They slide all the way to the bottom of your rod before sinking into your skin.");
	
	outputText("\n\nThe burning has tapered off near the end of your clitoris, now more properly a lever than a button; only the base still tingles with the barely-bearable sensation that you realize to be new growth.  \"<i>Bloody hell, [name],</i>\" Sheila calls, forcing her elbows to straighten under her again.  \"<i>If you get much thicker, you'll split me off another tail.</i>\"  Your mouth only opens dumbly at this.");
	
	//divide scene here by clit size
	//(clit<=6" initially)
	if (player.clitLength <= 6) {
		outputText("\n\nShe sits up on her knees, then turns to face you.  ");
		if (!player.isTaur()) outputText("Taking your face into her hand, she closes your jaw and then leans in to plant a kiss on your chin.");
		else outputText("Her eyes glitter with mirth.");
		outputText("  \"<i>Why the look, mate?  Seems like you're saturated for now, and just in time.  This... is...</i>\"  She pulls her tail up from the end of your clitoris, then slides it back down, slowly.  \"<i>... perfect!</i>\"  As her tight hole swallows your sensitive distaff staff once again, your eyes roll and her head drops, dragging her hair");
		//[(horse)
		if (player.isTaur()) outputText(" through the grass");
		else if (player.biggestTitSize() >= 1) outputText(" between your " + player.allBreastsDescript());
		else outputText(" along your flat chest");
		outputText(".  \"<i>Ffuck, even your girl parts are amazing.</i>\"  Sheila plants kiss after kiss on your ");
		if (!player.isTaur()) outputText("[chest]");
		else outputText(player.buttDescript());
		outputText(" as she shallowly pumps your " + player.clitDescript() + " in and out of her spade.  Your pelvis twitches uselessly; with her tail waving in the air instead of braced against her, controlling the pace of the fuck is beyond you.  \"<i>Naughty sheila,</i>\" she says, squeezing your wiggling hip with a hand.  You think privately that she could just as easily be talking about herself.  \"<i>Am I not going fast enough for you?  Let me speed up.</i>\"");
		
		outputText("\n\nYour demon lover turns around again and, planting her hands once more against the ground, lifts her backside.  Her snubby spade plunges onto your rod with aplomb, going so fast that the lubrication begins to dissipate as quick strokes force fluid out of the tight confines.  Heat overtakes your clit again, not from chemicals but simply from your growing body temperatures and the friction between you.  Soon, you can feel the hot sensation of dry skin-on-skin contact closer to her tip, where the lube has been pushed out completely.  \"<i>God... yes... fuck you, fuck my filthy tail, fuck it raw, rub all my dirty cum out with your freaky clit, penetrate me, show me who's the man!</i>\"  Sheila's voice reaches the pitch of a scream as she finishes her demands.  \"<i>F-fuck!  I'm coming!</i>\"  She slumps forward as ");
		//[(PC corr<50)
		if (player.cor < 50) {
			outputText("her tail quakes and you feel something hot licking at the tip of your clitoris.  The spade pulls back and then sinks down again, and the heat gains several inches; she repeats this twice more until you can feel what must be her cum all the way down to her tail-tip, but as she attempts to pull back again and force her climax past the raw, hot skin at the edge, her tail simply jerks at your clit and she falls weakly onto the ground.");
			
			outputText("\n\n\"<i>N-no... no!  So close!</i>\"  The black stalk thrashes weakly as her body loses muscle control everywhere except the parts responsible for forcing her cum out of it.  She moans piteously and babbles as her tail swells around your clit and engulfs you in her liquid climax, doubling in thickness behind the spade from the mounting fluids.  It's too much for you to watch, this arrogant woman trying to use you to get off but only managing to tease herself while suffusing your clit with her hot fluid, and combined with the temperature, pushes you over the edge you'd been flirting with.  Your " + player.vaginaDescript(0) + " squeezes and squirts, depositing your own orgasm onto the ");
			if (player.wetness() >= 4) outputText("demon's legs");
			else outputText("grass");
			outputText(", and your clit swells even further inside your tormented partner.  Sheila groans, \"<i>Fuck you, [name]...</i>\"");
			
			outputText("\n\nIrritated, she wraps her other frantic tail around the still-straining black one and squeezes, finally managing to get some of her climax past the ring of tight skin at the end; with the fluid forming a bridge, you feel the tension release as a wave of her black, slippery tail-cum forces her slit wide open and gushes out to soak your clit and then your pussy underneath.  \"<i>Ah!  Ah!  Finally!</i>\" she cries, great gouts of agitated slime sliding down your " + player.clitDescript() + " to bubble and lick at your pussy, as if trying to get inside.");
		}
		//(else PC corr>=50)
		else {
			outputText("her tail quakes, then pushes her pussy into yours.  \"<i>God, yes!</i>\"  A spatter of hot fluid hits your " + player.vaginaDescript(0) + " as your demon lover climaxes, and another begins to drool around the tip of your clit, still suspended inside her writhing tail.  The sudden labial heat is too much for you, and you answer her with a climax of your own, ");
			if (player.wetness() >= 4) outputText("drizzling");
			else outputText("copiously soaking");
			outputText(" her pussy with your own girl-jizz.  It feels like the nearness of her own cunt pulls your orgasm into obscene lengths, and you come repeatedly, drooling more fluid onto her wanton pussy as she grinds its lips against yours.  She rubs her breasts as she strokes her convulsing vagina against your own, pinching and pulling them until you swear you can see them lengthen.");
		}
		outputText("\n\nSpent, she leans against you for several minutes, panting, then pushes herself up on wobbly legs.  Gingerly, she tugs her abused tail free of your enormous clit, then winces and puts her hand on her stomach as backed-up fluid oozes heavily from the spade.  \"<i>Ugh, feel like I'm gonna chunder.  Mate, I'll see you later.</i>\"  She turns and departs queasily, leaving a trail of black slime behind her.  As you slip into a doze, you wonder if your slowly dwindling clitoris will have returned to normal by the time you wake up.  For the most part it does, though it maintains at least an inch of the extra length.");
	}
	//(else if clit >6" initially)
	else {
		outputText("\n\nShe pulls her tail free of your clit, watching nervously as the coating of dark oil left behind is absorbed into the skin and it widens another half-inch.  Sheila turns uncertain eyes on you and speaks again.  \"<i>Eh-heh.  Even as a woman, it looks like you're too much of a man for my little hole.</i>\"  She plays with her nipples idly, watching as your breathing causes the abnormally elongated skin to bob in the warm air, then leans down and blows on it with a grin; you squirm, raising a giggle from her.  \"<i>I could just jerk you off like any old cock... would you like that?</i>\"  The demon caresses you with her hand and considers a bit.  \"<i>Ahh, no good.  I'm horny too, after having you inside me.  But this absurd thing... oh, I know.</i>\"");
		
		outputText("\n\nYou stare at Sheila as she turns around");
		//[(horse)
		if (player.isTaur()) outputText(" and rolls onto her back");
		outputText(", then wraps her tails around your thickened clit.  They twist and pull, sending spirals of pleasure along the numerous nerves, and begin gently but insistently tugging you toward her tan butt.  Sheila directs the tip right between her cheeks, and you can feel her using it to rub the ring around her hole.  \"<i>I think this should be about the right size for you, love,</i>\" she teases, spearing herself on your " + player.clitDescript() + ".  Inch after inch slides into her slowly, maddening you with warmth, until ");
		if (player.clitLength <= 12) outputText("all of it is in her bowels and her hot cunt rests against yours");
		else outputText("she's taken as much as she can");
		outputText(".  She half-smiles and half-winces at you.  \"<i>Don't usually take it in this hole, but I wanted to feel your pussy going crazy for me.</i>\"  ");
		if (player.clitLength <= 12) outputText("Her hips shift, dragging her lips across yours and stirring your clit through her asshole even as it squeezes you; your pussy twitches at the stimulation.");
		else {
			outputText("Her tails, one still swollen from being stretched and tormented by your growing clit, slip into you abruptly, bringing their mild burning sensation with them; if you hadn't been saturated with it already, you'd probably pass out.");
			//[(if virgin vagina)
			if (player.hasVirginVagina()) outputText("  \"<i>What's this?</i>\" Sheila teases.  \"<i>Why, your virtue is still intact, little girl!  I wouldn't want anything to happen to it!</i>\"  She pulls her tails out a bit, contenting herself with simply teasing your lips and driving you mad for penetration.");
			outputText("  The demon shifts around your clit, sending a wave through you that makes your lips wrap around the invaders.");
		}
		
		outputText("\n\nSheila places her long-taloned feet against ");
		//(not naga)
		if (!player.isNaga()) outputText("your thighs, spreading your [legs] wide and then hooking them over top to touch ");
		outputText("the ground next to your ass, and uses the leverage to begin pumping your clit out of and into her asshole, caressing your " + player.vaginaDescript(0) + " every time she slides home.  \"<i>I could get used to this, love.  What say I keep you dosed up like this and you become my dildo?  I'll ride you with a different hole every time!</i>\"  Your eyes roll back in your head, at least partially from the irregular pace at which she's stroking your clit.  Sheila grabs her breasts as she slows down drastically once again, mashing them with her hands and sinking onto you an inch at a time.  \"<i>Fuck... I love your junk, [name].  Maybe I should catch a goblin, too, and make her tease my pussy while you fill my ass.</i>\"  She raises back up and ");
		//[(clit>12")
		if (player.clitLength > 12) outputText("pulls her black tail free, dripping with your juice, then ");
		outputText("begins to work her drooling spade along your clit again, smearing her goo along your chunky chick-stick.  You can feel the edges of the stretched hole in her tip working on your skin, opening and closing ever so slightly as her copious tainted lube oozes out.  Your " + player.clitDescript() + " must be completely saturated already, because the slippery goo lingers on the surface instead of wicking into it.  \"<i>Gonna g-get you nice and wet, love...  Ohh,</i>\" Sheila says, affected to distraction by the pleasure of tracing the slick end of her stubby tail along you.");
		
		outputText("\n\nFinally coating you to satisfaction with the oily secretions, Sheila begins pumping again.  The heated friction from before evaporates, replaced with a dull, distributed warmth as she slides her asshole along your clit.  With less resistance, she's able to up the tempo to frantic, scraping along the ground so fast that she begins to tear up the grass.  You bear up as much as you can under the onslaught of pumping and gyrating hips, but eventually the sensation is too much, and your nerves take over as your climax begins.  Your " + player.vaginaDescript(0) + " spasms, drooling onto her ");
		if (player.clitLength <= 12) outputText("pussy; her smooth, small labia greedily lap at the fluid when they touch, brushing against yours and drawing further twitches and squirts.");
		else outputText("teasing tails; they shift from stroking your labia to holding them open, allowing your pussy to squirt as it pleases.");
		outputText("  Suddenly she stops mid-stroke as her asshole quivers, sending shivers up your orgasm-sensitized clitoris.  \"<i>Fffuck!  So soon!  I'm coming too, [name]!</i>\"  Sheila sinks down, burying your " + player.clitDescript() + " into her asshole.");
		//(clit>12")
		if (player.clitLength <= 12) {
			outputText("  Her tails sink into you as she squirms, parting your lips and pushing their way inside.");
			//[output hymen check, but don't remove virgin flag yet]  
			if (player.hasVirginVagina()) outputText("  <b>You've lost your virginity!</b>");
			outputText("  Buried in your pussy, the spade begins drooling its black fluids in greater and greater volume as Sheila is wracked by her orgasm.");
		}
		
		//(PC corr<50)
		if (player.cor < 50) {
			outputText("  The demon's pussy gushes and pours with unnatural levels of fluids, soaking your crotch as a miniature cataract makes its way out of her lower lips.  Sheila spills herself onto you for at least a minute, producing more hot fluid than you thought possible, until she looks utterly dehydrated - even her breasts seem to be smaller and less jiggly.");
		}
		else outputText("  The demon's skin seems to parch as she grinds into you relentlessly, evaporating your fluids so fast that most of them don't even have time to fall.  Her hot flesh lays heavily across your netherlips, prolonging your climax and coaxing out more fem-spray than you thought was in you.  Even your mouth seems to dry as she drinks your essence up.");
		
		outputText("\n\n\"<i>Ahh, [name],</i>\" Sheila says, after a minute to recover.  \"<i>It feels good in my butt.</i>\"  Slowly, she pulls apart from you, letting your clit out of her backdoor at an agonizing pace, and stands up.");
		//[(if clit >12" and virgin vag)
		if (player.clitLength > 12 && player.hasVirginVagina()) {
			outputText("  \"<i>Sorry about your hymen, love, but I just couldn't resist making a sweet little slut like you into my girl.  I hope you'll remember me - I only wish I had a proper donger so I could give you my baby, too.</i>\"");
		}
		outputText("  Even as tired as you are, what you see on the demon girl makes you laugh.  She starts at this, then follows the direction of your gaze; ");
		if (!player.isTaur()) outputText("her tits are covered by grass stains from her frenetic pumping.");
		else outputText("craning around shows her that her asscheeks are completely green and wet with torn grass from slamming into you so violently and repeatedly.");
		outputText("  \"<i>... Oh, god dammit,</i>\" Sheila gripes.  She walks over and forces your face into them with a long, slow shake, then giggles as a joke comes to her.  \"<i>There, [name]; I've stained you with my colors!</i>\"  She plants a long kiss on your grass-smeared forehead, then drops you back to the ground, straightens up, and departs.  Exhausted, you slip into a doze, wondering if you'll be able to fit your swollen clit back into your clothing when you wake or if you'll have to walk back to camp with it sticking out.  It slowly deflates as you sleep, but does retain a bit of additional length.");
	}
	//reduce lust and libido, increase sensitivity, remove virgin vag if PC clit>12", slimefeed if PC clit>12" or PC corr <50, increase clit by 1" before perk mod; if PC corr <50 then +10 corr and -10 sheila corruption, else if PC corr >=50 then -10 corr and +10 sheila corruption
	if (player.clitLength > 12 || player.cor < 50) {
		player.cuntChange(12,false,false,false);
		player.slimeFeed();
	}
	player.clitLength++;
	if (player.findPerk(PerkLib.BigClit) >= 0) player.clitLength += .5;
	if (player.cor < 50) {
		dynStats("cor", 10);
		sheilaCorruption(-10);
	}
	else {
		sheilaCorruption(10);
		dynStats("cor", -10);
	}
	player.orgasm();
	dynStats("lib", -1, "sen", -2);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}
	

//Loss - unsexed joke scene
private function aintGotNoGenderAndKangarooRaped():void {
	clearOutput();
	outputText("Sheila sashays over to you and brazenly sticks her hand in your featureless crotch.  \"<i>It's too bad you've mutilated yourself like this, love... or did you do it just to tease me?  You know, it doesn't bug me that much.</i>\"");
	
	outputText("\n\nYou look your confusion at her.");
	
	outputText("\n\n\"<i>Well,</i>\" she continues, \"<i>it's a little irritating that you and I can't make our kids right now, but it's so easy to fix, yeah?  Once we move in together, I'll just slip a tiny sip of potion into your tucker, and... surprise!  You'll have the cutest little whacker again.  Instant husband.</i>\"");
	
	outputText("\n\n\"<i>Or would you rather be the sheila?  I'd be a bit of a possessive bloke, though; keep you knocked up at home so you couldn't get away from me.</i>\"  Shaking your head at her presumptuousness doesn't seem to interrupt her daydream.  Sheila places her hand on your forehead and looks into your eyes.");
	
	outputText("\n\n\"<i>Hah,</i>\" she says as her irises flare with lavender light, \"<i>you don't have to decide right now.  Just think it over; you could even be both.</i>\"  An odd fantasy washes through your mind as she stares, one of Sheila tucking your penis into your own vagina and pouring vial after vial into you, forcing you to come inside yourself every time a draft pushes you to your peak.  The sadistic quality of the vision she's sending suggests that she's not nearly as laid-back about being unable to play with you right now as she's affecting to be, and you can feel your body heating up as cock after chemically-granted cock sprouts on you and is shoved inside your cunt by your demon captor.  Suddenly, the demon blinks and the fantasy is suspended; she's lowered you to the ground while you were lost in her daydream, and plants a chaste kiss on your lips before pulling away.");
	
	outputText("\n\n\"<i>I'll see you later, [name]... think about me.</i>\"  You slip into a brief, tired doze as her lingering magic guarantees fulfillment of her request.");
	
	//big lib-based lust gain, med lib gain if lust hits 100, pass 1 hour
	dynStats("lus", 20+player.lib/4, "resisted", false);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//Win against demon Sheila
internal function beatUpDemonSheila(output:Boolean = true):void {
	if (output) {
		clearOutput();
		outputText("\"<i>Ahh, you win, mate.  I give up.</i>\"  Sheila slumps to the ground, ");
		if (monster.HP < 1) outputText("and her wounds begin to close with a soft lilac glow.  \"<i>So fuckin' strong.  I don't suppose you've got any sperm for me, do you?  I'd love to have some of your kids...</i>\"  She looks at you beseechingly, gently fingering herself.");
		//(lust)
		else outputText("frigging herself vigorously.  \"<i>Do with me what you will, lover; those were the terms.  Won't you take my body to satisfy yourself, you brute?</i>\"  The audacious woman sticks her tongue out, as if to goad you into treating her roughly.");
	}
	//[(lust < 30)]
	if (player.lust <= 33 && output) {
		outputText("\n\nYou're just not horny enough to consider fucking her right now, though, and she wilts a bit as you turn away.  \"<i>Sorry, I was just having fun... I'll see you soon, then?</i>\" she calls, hopefully.");
		combat.cleanupAfterCombat();
		return;
	}
	if (player.gender == 0){
		combat.cleanupAfterCombat();
		return;
	}
	//if lust high enough, display choices [Missionary][Big Dick+Thighs][Penetration, In Spades][Nipple Kisses][Anal Hate-fuck(req >= 75 corr and monster lust >99 or monster HP < 1 to appear)]
	menu();
	//Win - [Missionary] - for the purpose of procreation
	//requires a cockarea <= 56
	if (player.hasCock() && player.cockThatFits(56) >= 0) addButton(0,"Missionary",missionaryForThePurposesOfCreatingImpsWithSheila);
	//Win - [Anal Hate-fuck] - peg-knocking with optional corr >=80 break-up (for your cock or C. Jojo's)
	//if PC has both a dick and corrupted Jojo, output this scene and choice; else skip this output and go right to appropriate option
	if (player.hasCock() && player.cockThatFits(56) >= 0) addButton(1,"AnalHateFuck",analHateFuck);
	//Win - [Big Dick+Thighs] (usable for dicks with cockarea > 56) (all 10 of them)
	//penis envy, go!
	if (player.hasCock() && player.biggestCockArea() > 56) addButton(2,"UseHerThighs",bigDickAndThighs);
	//Win - [Penetration, in Spades] - for self-loathing vaginas
	if (player.hasVagina()) addButton(3,"Clit-Fuck",winAgainstDemoNSheilaForVaginas);
}

//Win - [Missionary] - for the purpose of procreation
//requires a cockarea <= 56
private function missionaryForThePurposesOfCreatingImpsWithSheila():void {
	clearOutput();
	outputText("You unfasten your [armor] and strip down completely, as Sheila's eyes drink up your bare flesh.  Denuded, you caress your cock with several strokes, producing a drop of precum.");
	
	outputText("\n\n\"<i>Oh my, are you going to force that slimy thing into my little flower?  How awful!</i>\" Sheila shrieks, throwing an arm across her forehead and swooning.  ");
	if (player.cor < 40) outputText("Your ardor subsides a bit at her performance, but seeing your look of contrition, ");
	else outputText("Your scowl hardens at her shameless playacting, and ");
	outputText("she breaks into laughter.  \"<i>I'm just having you on, love.  You know my body's yours for the using.</i>\"");
	
	outputText("\n\nShe tosses her hair out of her face and extends her hand to you.  \"<i>No need to be coy about wanting me, my best mate.</i>\"  When you place your own hand in hers grudgingly, she pulls you forward until you're positioned atop her.  You can feel a gentle pressure on the underside of your [cockFit 56] as one of her slick tails guides it into position.  \"<i>This is where you belong, after all.  Welcome home.</i>\"  She wraps her arms around your ");
	if (!player.isTaur()) outputText("shoulders");
	else outputText("flanks");
	outputText(" and her pupils dance in excitement; for a moment you even lose yourself in her enthusiasm, forgetting her demonhood and seeing only an earnest, adoring girl under you.  \"<i>Now, push!</i>\"");
	
	outputText("\n\nSheila pulls you down gently and a warmth envelops your [cockHeadFit 56] as it nudges past her inflamed labia.  Her command rings in your ears, and coupled with the sensation, it's as much as you can do to slip in at your own pace and enjoy yourself instead of obeying her every word.  Inch by inch you slide yourself into her pussy as she bites her lip impatiently.  \"<i>You're such a tease, [name].  You know how much I want you in me, and you make me wait for it every time.</i>\"  You begin pumping her slowly; her back arches ");
	//(sheila corruption >=40)
	if (sheilaCorruption() >= 40) outputText("and her soft breasts jiggle ");
	outputText("as a twinge of sensation from your thrust provokes a gasp and forces her to reposition herself, to better find it again.  \"<i>That's the spot!  Your dick is the <b>best!</b>  Pound me, you fucking cum-hose!</i>\"");
	
	outputText("\n\nRestraint evaporates as she reaches up and kisses your chest, dancing her lips across your " + player.skinFurScales() + " and leaving a trail of tingling nerves behind.  Your ");
	if (!player.isTaur()) outputText("arms");
	else outputText("forelegs");
	outputText(" wobble and it takes all your focus not to collapse onto the woman and melt into a boneless puddle; there's little left to prevent your twitching hips from granting her request, and you slam your pelvis into hers repeatedly, provoking delighted cries from your shameless partner.  \"<i>Ohh, yes!  Fill me with your baby batter, asshole!</i>\"  Sheila wraps her arms and legs around your back");
	if (player.isTaur()) {
		outputText(", practically lifting herself off of the ground] as she impales her cunt on your [cockFit 56] to prevent you from pulling out.");
	}
	//[(silly)
	if (silly()) outputText("  \"<i>Make me feel like I'm fifteen years old again and playin' with the dog-morphs in the field!</i>\"  Heavens to Betsy!");
	else outputText("  \"<i>This is what you're here for!  Don't spill a single drop!</i>\"");
	outputText("\n\nYou try to resist, but you can already feel your muscles giving up on anything but forcing out your climax, and you fall carefully onto your lover's body, squeezing her ");
	if (sheilaCorruption() < 40) outputText("tight");
	else outputText("soft");
	outputText(" chest against you");
	if (player.isTaur()) outputText(" as you slump forward");
	outputText(".  Your cock ");
	if (player.cockTotal() > 1) {
		outputText(" and its ");
		if (player.cockTotal() == 2) outputText("brother");
		else outputText("brethren");
		outputText(" swell and squirt");
	}
	else outputText("swells and squirts");
	outputText(", pouring your semen into Sheila's ravenous pussy");
	if (player.cockTotal() > 1) outputText(" and coating her crotch with a glaze of white");
	outputText("; her eyes glow and it briefly feels as though her body is sucking the ejaculate right out of you");
	if (player.cumQ() >= 500) outputText(", until she fills up and the rest of your orgasm is drooled out at its own lazy pace");
	outputText(".  She kisses you");
	if (player.isTaur()) outputText("r forelegs");
	outputText(" lovingly and deeply");
	if (player.cockTotal() > 1 || player.cumQ() >= 500) outputText(" as the spare seed dribbles from her crotch");
	outputText(", then breaks away and looks up into your face.");
	
	outputText("\n\n\"<i>[name], you ");
	if (player.cumQ() >= 500 || player.cockTotal() > 1) outputText("spilled some.  I can't have your baby if you're fucking the grass.  And you ");
	outputText("came too soon; I wasn't done.</i>\"");
	
	outputText("\n\nDid this bitch just...  Sheila breaks into a wide grin as your eyes pop out.  \"<i>Kidding, mate!  Stay cool!  ");
	//[(RNG decides if scene ends here, bias toward short scene)
	if (rand(10) <= 6) {
		outputText("I used a bit of power to help you finish.  Don't hate me for it; your orgasm face is just so cute when you're giving up your seed to me.</i>\"  The woman places her hand on her stomach, below her navel.  \"<i>Thank you for this.  I hope it takes, so I can raise a big strong imp to be just as " + player.mf("productive as his father","sexy as his mother") + ".</i>\"  She kisses you softly again, and you roll off with a groan.  \"<i>Your sperm are the best,</i>\" Sheila whispers, \"<i>so come see me again soon.  I'll be wantin' more.</i>\"  Your demon stands up and winks at you, then walks off, tails swishing happily as a trickle of white runs down the brown skin of her naked thigh.");
		//(end scene)
		player.orgasm();
		dynStats("lib", -1);
		sheilaPreg();
		//if short scene, sheilapreg check, reduce PC lust and libido
		if (getGame().inCombat)
			combat.cleanupAfterCombat();
		else doNext(camp.returnToCampUseOneHour);
	}
	//(else if RNG doesn't end scene)
	else {
		outputText("I gave you a little push, because I wanted your semen inside me so bad... but we could keep going, if you like?  Look into my eyes, lover, and see how much I still need you.</i>\"  Spent by climax as you are, you can't really focus elsewhere, and stare dully at the girl under you.  A slow smile spreads across her face, as her eyes glitter and a picture forms in your mind: one of you fucking Sheila over and over, pumping abnormally-enhanced levels of jizz into her pussy every day");
		//(if vag)
		if (player.hasVagina()) outputText(" as her imp spawn take turns doing the same to you from behind");
		else outputText(" as her imp spawn gather around, stroking themselves and occasionally squirting their hot, tainted cum on her body or yours as orgasm takes them");
		outputText(".  ");
		if (player.lib < 40) outputText("Shocked");
		else outputText("Flushing hotly");
		outputText(", you look away and break the connection, but Sheila's smile only widens.");
		
		outputText("\n\n\"<i>Did you see it?  Our future together?</i>\"  The demon reaches up and plays with your hair.  \"<i>Our wonderful family... our children... so full of seed to give, just like their " + player.mf("father","mother") + ".  I can feel you getting hard again inside me - am I exciting you?</i>\"  Her hand drifts down to your mouth, and she brushes your lips gently with her thumb.  \"<i>Why don't you go ahead and do me again?  Show me how you feel, mate; I won't do anything except touch you, so you can take your time.  I'm your obedient, loving wife, here to make you happy.</i>\"  She caresses your cheek one last time and lowers her hand to your chest, tracing a meaningless pattern as she turns expectant eyes on you.");
		
		outputText("\n\nIt's too much.  ");
		if (!player.isTaur()) outputText("You kiss Sheila on the lips, pushing your tongue through to play with hers, as your arms push your spent body into position to thrust again.");
		else outputText("You reach down with a hand and place it alongside Sheila's face; her ear twitches as she looks at you brightly, and for a moment you recapture your earlier impression of her as a sweet, devoted lover.  Your legs struggle to push your equine bulk upwards as you return to a thrusting position, dragging her groin into the air by your erect cock.");
		outputText("  The girl giggles as you slide your dick partway out, pulling some of your deposited jizz with it to dribble ticklishly from her and down her butt to the ground.  \"<i>That feels good... pump me again.  Remind me whose woman I am; remind me what you've left in my pussy!</i>\"  You slide in and out, at your leisure this time, feeling none of the compulsion she used on you before.  Her wet, semen-drooling sex starts to heat up around you, and the slick ease with which you can thrust into it begins to tell on your pace; soon you're sawing into Sheila with the vigor you managed briefly before, under her power.");
		
		outputText("\n\nThe demon groans in approval.  \"<i>So you ended up doing me fast after all... g-god, you know just how I like it!  Keep going!</i>\"  She brings her other hand up and begins tweaking both nipples in excitement.  Her vagina squeezes your cock, making poor purchase at first thanks to the copious fluids inside, but doing better and better as her contractions intensify.  You oblige her by increasing the strength of your own thrusts, fatigue forgotten as you watch the woman quake and writhe in her ecstasy.  \"<i>Ah-ah-ah, gonna finish soon, gonna fin-ish, come on [name], keep it up, hit all the right spots...</i>\"");
		
		outputText("\n\n\"<i>Oh, <b>[name]</b>!  Come with me!</i>\" Sheila screams, as she wraps her body around you again and a foreign wave of arousal washes over you.  ");
		//[(PC corr <50)
		if (player.cor < 50) outputText("Her pussy convulses as she orgasms, and you feel a wave of heat overtaking your [cock biggest], starting at the tip and moving down the shaft.  As it reaches the base, a gush of her fluids breaches the seal her pussy makes around you, forcing your jizz out along with it in a mixed white and clear squirt.  The demon's vagina squeezes and drools for half a minute, pouring her tainted liquid love out against your tightly-held body until your crotch is soaked with her sticky heat and responds with its own.");
		else outputText("Her pussy sucks you in as she climaxes, and you can feel larger and larger waves of precum being pulled from your shaft; it almost feels like she's tugging at your entire being.  It's not long before your cock twitches and begins giving her greedy sex a second helping of your semen.");
		outputText("  She goes limp as her twitching cunt takes over and begins drinking every drop it can get from your dick to replace the goo you pushed out");
		if (player.cumQ() >= 500) outputText("; you nearly manage to fit it all into her this time, with your production still flagging from the last session");
		outputText(".  Muscles weakening again, you lower yourself onto her once more and allow her to stroke your ");
		if (!player.isTaur()) outputText("back");
		else outputText("sides");
		outputText(" as she cools down.");
		
		outputText("\n\n\"<i>That was amazing, [name],</i>\" she says, finally.  A dirty look and a poke in her side answers, irritated as you are that she pressed another orgasm out of you before you were ready.");
		
		outputText("\n\n\"<i>Ahaha,</i>\" Sheila giggles, interpreting the revenge gesture correctly.  \"<i>I lied, sorry.  But, you know, it's so romantic when couples finish together.</i>\"");
		
		outputText("\n\nShe plants a peck on you, placing a hand along your cheek.  \"<i>Congratulations, mate; you can even manage to satisfy a sex demon... do you want to go again?</i>\"  Your eyes widen and you climb off of the woman in a hurry, sliding your cock out of her pussy and trailing a line of white along her leg as she laughs.  Sheila sits up and grabs your hand as you try to turn away, then places it below her navel.");
		
		outputText("\n\n\"<i>This is where our baby will grow, lover.  Thank you for it.  See you soon.</i>\"  Her eyes soften as she releases her grip, then she stands up and departs with tails waving happily.  After a few minutes to regain your strength, you collect your things and leave as well.");
		
		//if long scene, sheilapreg check, reduce lust, reduce libido, slimefeed if corr < 50; if PC corr <50 then +10 corr and -10 sheila corruption, else if PC corr >=50 then -10 corr and +10 sheila corruption
		sheilaPreg();
		player.orgasm();
		dynStats("lib", -1);
		player.slimeFeed();
		if (player.cor < 50) player.slimeFeed();
		if (player.cor < 50) {
			dynStats("cor", 10);
			sheilaCorruption(-10);
		}
		else {
			dynStats("cor", -10);
			sheilaCorruption(10);
		}
		if (getGame().inCombat)
			combat.cleanupAfterCombat();
		else doNext(camp.returnToCampUseOneHour);
	}
}

//Win - [Anal Hate-fuck] - peg-knocking with optional corr >=80 break-up (for your cock or C. Jojo's)
//if PC has both a dick and corrupted Jojo, output this scene and choice; else skip this output and go right to appropriate option
private function analHateFuck():void {
	clearOutput();
	outputText("Fucking bitch, playing with herself like nothing's the matter and you didn't just show her concrete proof of your superiority.  Part of you feels like punishing the insolent woman yourself, pounding her insides and dumping your load without a whit of regard for her own pleasure... but another part is thinking it might be fun to see her completely debased, to hammer home how pathetic she is - something like reducing her to a cock-sleeve for your personal cum-slave.");
	
	//[Tear Her Up][Call Jojo]
	menu();
	addButton(0,"TearHerUp",sheilaAnalHateFuckAGoGo);
	if (jojoScene.campCorruptJojo()) addButton(1,"Call Jojo",analHateFucksWithJojo);
}

//[Demon Victory Sex - Anal Hate-fuck - Tear Her Up]
//with own cock version - for surprise buttsex
private function sheilaAnalHateFuckAGoGo():void {
	clearOutput();
	outputText("Your [cockFit 56] gets hard in your [armor] as you watch her diddle her pussy, but you set your jaw to resist giving her what she wants - a better idea is taking shape in your head.  \"<i>Turn around,</i>\" you demand.");
	
	outputText("\n\nSheila bites her lip and blushes, then turns her back to you, pressing her chest into the ground and waving her ass in the air, twin tails bobbing over her round cheeks and drooling, eager cunt.  \"<i>Heehee, I'm ready for you, mate... look how wet I am!</i>\"  You strip, releasing your " + player.multiCockDescriptLight() + ", and approach.  She hums in anticipation as you rub against her smooth labia, smearing her moisture onto your [cockHeadFit 56].  \"<i>Come on; time to put it in already!  Don't tease me!</i>\"");
	
	outputText("\n\nYour smile widens, unseen, as you silently agree.  ");
	if (!player.isTaur()) outputText("Slipping one hand around your [cockFit 32]");
	else outputText("Straddling her");
	outputText(", you pull your hips back and line the [cockHeadFit 32] up, then thrust - right into her asshole.  Her head raises and her teeth grit as you force the slick tip past her ring.  \"<i>[name], what the fuck?!  That hurts!  Go easy if you're going to use that hole; I'm not good at stretching my body yet!</i>\"");
	
	outputText("\n\n\"<i>No.</i>\"  You ");
	//(not centaur)
	if (!player.isTaur()) outputText("grab her thrashing legs, using them for leverage as you ");
	outputText("force your dick into the angry woman.  \"<i>You talk a good game about how you love being full of cock, but when I shove one in you, you get all bitchy and act like you're not ready; why don't you just shut up and get fucked, slut?</i>\"");
	
	outputText("\n\n\"<i>Ahh!  Stop!  You're going to tear me open!</i>\"  Even her tails flex against you, desperate to force you back out, but the feeling is too amazing to let that happen.  Instead, you push harder.  Sheila's arms collapse, dropping her torso to the grass");
	if (sheilaCorruption() >= 90) outputText("; her enormous, cushiony breasts spread under her as your prick forces her weight heavily onto them");
	outputText(".  She pulls up tufts and pounds the earth impotently with her fists while you sink in as far as you can.  \"<i>Fuck you!  What the fuck is wrong with you, arsehole?!  Let me go, I don't want anything to do with you anymore!</i>\"");
	
	outputText("\n\nMaybe if she'd said that from the start you'd have left her alone.  As it is, you'll never forgive yourself if you don't take advantage of her hot, tight hole after making it so far.  You begin thrusting, rearranging Sheila's intestines with your slick, slimy rod.  As precum is squeezed from you, your strokes get easier and easier, and soon you're fucking her forcefully into the ground, rubbing her face in the dirt as you plunge in and out.  Her tongue lolls, protests forgotten as your wet cock works the sensitive nerves in her butthole.  \"<i>Ah-ah-ah, god damn...</i>\"");
	
	outputText("\n\nYou stop.  Her face takes a minute to register it, but eventually turns toward you.  \"<i>W-what's wrong?  Keep going, mate!</i>\"");
	
	outputText("\n\n\"<i>You told me to stop,</i>\" you answer.  \"<i>Now you want me to go on?  Is there something wrong with your brain?</i>\"");
	
	outputText("\n\n\"<i>[name], stop playing!  I need you to fuck me, not fuck with me!</i>\" Sheila shouts, trying to get her legs under her to continue the sex with just her own hips.");
	
	outputText("\n\n\"<i>I see,</i>\" you answer, shoving into her with force enough that you tip her off-balance and then pausing again.  \"<i>So I can't fuck with you, but you can fuck with me whenever you want?  Is that it, you stupid bitch?  I'm just here to listen to your juvenile fantasies and get hard whenever you want a stiff dicking?</i>\"");
	
	outputText("\n\n\"<i>Ahh, no!  I really do like you!</i>\" Sheila says, panicking.  \"<i>You're my favorite bloke, promise!  Just... keep going!  I need this!</i>\"");
	
	outputText("\n\nWords, words, words.  You start pumping again, teasing her asshole; the woman shifts her hips and rubs against your crotch gratuitously as you do, giving you the benefit of seeing her pleasure so you won't stop thrusting.  \"<i>Decided to finally shut up, I see,</i>\" you taunt.  Sheila says nothing in reply, though her cheeks tingle and flush with shame.  With her mouth finally quiet, you actually manage to get into the fuck, rubbing your dick against her hot insides.  Your head leans back as you feel your orgasm creeping closer, and Sheila notices, staring at you out of the corner of her eye.");
	
	outputText("\n\n\"<i>[name]!  Finish in my pussy, please!  I want to raise your baby!  You're the only one that suits me!</i>\"");
	
	//if corruption >= 80 and PC has worms, present choices 
	if (player.cor >= 80 && player.findStatusEffect(StatusEffects.Infested) >= 0) {
		menu();
		//[No][Worms Suit You], else auto-output text from [No]
		addButton(0,"No",sheilaAnalHateFuckAGoGoNO);
		addButton(1,"WormsSuitYou",sheilaAnalHateFuckAGoGoGETYOUSOMEWORMS);
	}
	else {
		menu();
		//see above
		addButton(0,"Next",sheilaAnalHateFuckAGoGoNO);
	}
}

//[Demon Victory Sex - Anal Hate-fuck - Tear Her Up - No]
private function sheilaAnalHateFuckAGoGoNO():void {
	clearOutput();
	outputText("\"<i>Go to hell.</i>\"  You bury yourself in the demon's ass as your dick begins to spasm.  Her tails writhe as the first trickle sinks into her.  \"<i>What?  Say something, I dare you.</i>\"");
	
	outputText("\n\nLosers don't get to decide how they get fucked.  If she has a problem with that, she can do better.  With surprising grace, she buttons her lip and takes it, allowing you to unburden yourself.  Her hot guts feel heavenly as you smear your slick cum into them, and she even makes small little gasps as you release each new stroke.  Her tight asshole fills quickly, and you feel the semen lapping at the tip of your cock.");
	if (player.cumQ() >= 500) outputText("  Your overproduction floods her insides, and Sheila groans as it begins to leak back out, drooling over her pussy.  \"<i>Hey, you got your wish,</i>\" you tease.  The wanton woman tries to tilt her ass higher, to tip more of your overflow into her cunt, but you laugh and slap her hard on the hip, sending her to one knee again.");
	
	outputText("\n\n\"<i>Fucking... bastard,</i>\" Sheila groans, as you pull your spent [cockFit 56] from her with a sucking noise.  Her tails droop over her abused hole, parting the ");
	if (player.cumQ() < 250) outputText("trickle");
	else if (player.cumQ() < 1000) outputText("stream");
	else outputText("waterfall");
	outputText(" of semen made when her body pushes out some of the foreign substance.");
	
	outputText("\n\n\"<i>Write a poem about your feelings.</i>\"");
	
	//minus lust, minus libido, plus small corruption
	player.orgasm();
	dynStats("lib", -1, "cor", 2);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//[Demon Victory Sex - Anal Hate-fuck - Tear Her Up - Worms Suit You]
private function sheilaAnalHateFuckAGoGoGETYOUSOMEWORMS():void {
	clearOutput();
	outputText("\"<i>Mmm...</i>\" you answer, noncommittally.  Your ");
	if (player.balls > 0) outputText("[balls]");
	else outputText("insides");
	outputText(" squirm, giving you pause, and you pop your [cockFit 56] out.  \"<i>Actually... I don't think I suit you at all.</i>\"");
	
	outputText("\n\n\"<i>You do!  God, you do, mate!  Your donger belongs in my pussy!</i>\"  Sheila rubs her cunt against your wet prick, trying to coax you.");
	
	//(mans)
	if (!player.isTaur()) outputText("\n\nPlacing a hand on");
	else outputText("\n\nSqueezing your thighs around");
	outputText(" your ");
	if (player.balls > 0) outputText("[sack]");
	else outputText("[cockFit 56]");
	outputText(", you can actually feel your pent-up pets, eager to be let out to play.  \"<i>No,</i>\" you say, \"<i>I know what's more your speed.  Trash like you should be cast down into the dirt, and should keep company with the creatures of it.</i>\"  Sheila seems alarmed, but as you slip into her grasping pussy, she forgets her question, grinding her hips into you to milk you dry.  You focus, forcing a wave of slimy annelids down your shaft.  \"<i>Here come your new babies!</i>\"");
	
	outputText("\n\nSheila shivers as your dick erupts, packing her cunt with sperm and parasites.  \"<i>God, yes!  Stuff me!  I'm coming, [name]!  I'll take in all your anger and hate; let it all out!  I'm your bitch!</i>\"  Oh, indeed.  The demon screams, and her pussy begins lapping at your shaft, pulling in more of the tainted mix; your body obliges by sending up another load, filling her so full of slithering infestations that worms begin to poke out from between her labia.  \"<i>Ah!  Ah!  A-uh...</i>\"  Sheila stops moving and clutches her stomach, a blank look pasted across her face as her vagina convulses around you in orgasm.  A particularly large bulge ascends your [cockFit 56], and your slit stretches wide when all of the fattest worms jump ship at once and are drawn into the woman in an unbroken string, rendering you clearheaded.  As you empty yourself and pull free of the squirming, slimy mess in her vagina, your body is left without a single parasite - not a twitch can be felt.");
	
	outputText("\n\nThe demon rolls over slowly and sits up, then looks up at you, head cocked slightly to the side and mouth trying to shape words.  \"<i>W-wuuu...</i>\"  She reaches down and picks up a handful of the wriggling, jizz-soaked worms oozing from her pussy, examines them, and then holds them out to you as an offering.  You shake your head and she drops them negligently, then zeroes in on your drooling, stretched dickhole.  Sheila leans in so close that she's staring into it, then begins to slip a finger down your urethra.  You flinch at the sensation and pull away, and she pouts and reaches for it again.  The proffered worms, meanwhile, actually slither back toward her, smearing jizz and slime on her thighs, migrating to her crotch and then wandering around aimlessly on the bare skin, as if confused by her lack of a penis.  Her leaking spade stretches out to them absently, and some of the wandering worms curiously slip inside, producing another shiver.");
	
	outputText("\n\n\"<i>Mmm...</i>\" she hums, reaching eagerly for your [cockHeadFit 56] with her finger as if getting it inside were the only thing that mattered.  You back up again, and she crawls over and onto you, rubbing her slimy cunt against your [legs].  Her strokes trigger a small orgasm in her, and as her pussy sprays a load of worms onto your " + player.skinFurScales() + " she kisses you affectionately, looking right into your eyes; you're flooded with nebulous mental images of fucking a slender, sickly pale Sheila as both of you are covered and hidden from the sunlight by a massive colony, of her riding you with her slithering, wormy pussy until the semen spitting from your [cockFit 56] leads the parasites within right to your slit, and, most disturbingly, of Sheila stretching your slick urethra wide open and climbing into your penis herself!  Shaking it off, you quickly break contact, pick up your stuff, and depart, leaving the infested woman behind... but the visions don't go away.");
	
	//reduce lust to min and then take 20 libido-based lust damage, lower PC corruption by 10, remove dickworm infestation, set sheilapreg = -2 (yes, -2; in case I want to use Worm Sheila later)
	player.removeStatusEffect(StatusEffects.Infested);
	player.orgasm();
	dynStats("cor", 10);
	dynStats("lus", player.lib/5);
	flags[kFLAGS.SHEILA_DISABLED] = 3;
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//[Demon Victory Sex - Anal Hate-fuck - Call Jojo] - corrupted mouse version:
private function analHateFucksWithJojo():void {
	clearOutput();
	outputText("Watching her sit there and play with herself like nothing's the matter and you didn't just demonstrate her weakness for all the world to see touches a nerve deep inside you.  You scowl and focus your thoughts to call your mousey ex-monk, bent on showing this demon how a proper mendicant should behave.");
	
	outputText("\n\nYour servant eventually comes sprinting across the grasslands toward the beacon of your summons, and falls to his face before you, panting in exhaustion for some while before he can speak.  \"<i>Yes, [master]; how may I please you?</i>\"");
	
	outputText("\n\n\"<i>Slave, today you are going to demonstrate how to </i>properly<i> obey your proven superior.  Your humility and loyalty will be an object lesson to your delinquent partner.</i>\"  Turning your head slightly, you stare daggers at Sheila; she smiles coyly, eyes twinkling with interest at this development.  Oh, she doesn't understand you yet... but she will.  \"<i>Sit down behind her, Jojo.</i>\"");
	
	outputText("\n\nYour little mouse pliantly seats himself on the grass to the rear of Sheila, then scoots forward until his throbbing prick is pressing against her lower back.  The demon shivers in anticipation as the glaze of precum smears along her spine, and you can see her tails wreathing the monk's rod.  His face pinches as she attempts to wring his cock out, but he still checks to make sure he has followed orders.  \"<i>M-[master], is this.. ok?</i>\"");
	
	outputText("\n\n\"<i>Yes, very good.  Now, place your hands on her ass and lift her into position above your dick.</i>\"");
	outputText("\n\nJojo does so, relieved as her tails release his pecker and the woman leans forward to angle her pussy toward him welcomingly, then uses one of his hands to aim himself toward her crotch.  You bend down to Sheila's face, taking her chin in one hand.  \"<i>Now, supplicate yourself to your [master].</i>\"");
	
	outputText("\n\n\"<i>Haha...</i>\"  Sheila composes her expression into one of mock-gravity, and recites, \"<i>Please, [master], may I have your minion's semen in my pussy, to make you a baby?</i>\"  Her eyes are fairly lit at the prospect; it's evident she regards this as no more than a game.");
	
	outputText("\n\n\"<i>No, this will not do,</i>\" you decide, squeezing her face from below until her cheeks bulge.  \"<i>Good slaves exhibit proper humility when making a request.  Jojo, you will fuck this haughty girl's asshole, instead.</i>\"  Her eyes widen as you place your other hand on her shoulder and push down, allowing the mouse's meat to spear her anus.  She struggles under your grip, jerking free from your hand and trying to rise up; you reach back and slap her across the face.");
	
	outputText("\n\n\"<i>You are disgraceful!</i>\" you shout.  Stunned by the sudden violence, Sheila doesn't move; Jojo takes the opportunity presented to start working his prick in her butthole.  Grabbing and twisting one of her long ears, you begin haranguing the demon.  \"<i>Look at yourself; what about you is satisfactory?  Do you call this dirty mop on your head hair?  When's the last time you washed?  You're not even cute; I could throw a stone anywhere and find a face like yours!</i>\"  You release her ear and squeeze her breast callously.  ");
	//[(if sheila corruption <40)]
	if (sheilaCorruption() < 40) outputText("\"<i>What's with these tiny titties?  Could any man possibly be aroused by your bug bites?  I've seen bigger breasts on incubi!</i>\"");
	else outputText("\"<i>These disgusting sacks of fat on your chest... are you under the impression that men like giant stretch marks and nipples that hang to your knees?  Why don't you get in shape, you messy bitch?</i>\"");
	outputText("\n\nPulling on and then releasing her nipple so Sheila winces, you straighten up and rub a [foot] roughly into her cunt.  \"<i>You think you can birth a proper child with hips like these... it is to laugh!  They're barely wider than your waist; I could make a bigger baby inside a malnourished goblin!  Not to mention I might just have to; look at your tiny pussy, little girl!  No cocks this side of the portal would even fit.  There isn't even hair down here!  You know that makes you look like a child, right?  I feel like I should wipe you and put you in a fresh nappy, not fuck you!</i>\"");
	
	outputText("\n\nSheila's cheeks get redder and redder as you dress her down, even as her quivering intensifies thanks to Jojo's exertions.  As you finish, you slap her across the face again, leaving a palm-print in white very briefly until the bloodflow returns.  She averts her eyes, wet with tears, and mumbles, \"<i>S-sorry, mate...</i>\"");
	
	outputText("\n\n\"<i>Sorry isn't the word for what you are.  Why don't you try asking again, without pretending you're anything but a dumpster or acting like it matters which hole you use to warm a cock?</i>\"");
	
	outputText("\n\nHer face fills with defiant bitterness as she digests this last statement, looking at the ground.  \"<i>Please... [master],</i>\" she says, finally, \"<i>will you have your slave come in my unworthy pussy instead?</i>\"  She's still obviously resisting the lesson.");
	
	//present [No][Ruin Them]choices only if corruption >= 80, else output text from [No]
	if (player.cor >= 80) {
		menu();
		addButton(0,"Next",analHateFucksWithJojoNo,true);
		outputText("\n\n<b>You could really ruin them, but you'd probably never see Jojo again.</b>");
		addButton(1,"Ruin Them",jojoRuinsTheAnalHateFuck,true);
	}
	else {
		analHateFucksWithJojoNo(false);
	}
}

//[Demon Victory Sex - Anal Hate-fuck - Call Jojo - No]
private function analHateFucksWithJojoNo(clear:Boolean):void {
	if (clear) clearOutput();
	else outputText("\n\n");
	outputText("\"<i>No.</i>\"");
	
	outputText("\n\nSheila's eyes dim with upset and incomprehension, as you continue.  \"<i>Clearly, you're too stupid to accept your role, even when it's explained to you.  Jojo, pull out.</i>\"  The mouse looks questioningly at you, but obeys, popping his precum-coated prick from Sheila's ass so it juts between her thighs.");
	
	outputText("\n\n\"<i>Y-yes, [master],</i>\" he pants, \"<i>what shall I do now?</i>\"");
	
	outputText("\n\n\"<i>You may finish yourself off, but spill your seed on the ground.  Don't let a drop touch this failure.</i>\"  Jojo nods eagerly, wrapping his tail around his shaft and stroking; soon his dick twitches and his balls tighten as he begins to ejaculate onto the grass.  Sheila watches dumbly as the copious mouse cum collects in a white puddle before her, until the ex-monk finishes and slides out from under her ass.  Grabbing a clump of her auburn hair and yanking it painfully, you hiss in the demon's ear.  \"<i>Maybe if you were worth a damn, I'd let you breed.  As it is, the only thing you're remotely good for is storing a slave's dick until it's ready to come in a real woman.</i>\"  You twist, provoking a shriek, and then jerk her off-balance and forward so she lands face-down in Jojo's mess.  \"<i>Come, Jojo; we're leaving.</i>\"");
	
	outputText("\n\nResponding quickly, Jojo falls into formation beside you as you back away from the debased demon.  As she pushes herself upright, covered in liquid filth, the only glow you can see in her eyes now is one of simmering anger.  Satisfied with ruining her fun, you depart.");
	//lust raised, plus some corruption
	dynStats("lus", player.lib/3, "cor", 2);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//[Demon Victory Sex - Anal Hate-fuck - Call Jojo - Ruin Them]
private function jojoRuinsTheAnalHateFuck(clear:Boolean = true):void {
	if (clear) clearOutput();
	else outputText("\n\n");
	outputText("Your mouth spreads in a sickly smile as you contemplate granting her request anyway.  \"<i>Jojo...</i>\"");
	
	outputText("\n\nHis ears perk up.  \"<i>Yes, [master]?</i>\"");
	
	outputText("\n\n\"<i>You're going to give this worthless woman what she asked for.  Pull out of her ass and fuck her pussy instead.  But, wipe yourself off first.  I want you dry as a bone when you enter her.  If she's ever going to be useful as a womb, she can make her own moisture.</i>\"");
	
	outputText("\n\nJojo raises his eyebrows at that, but quietly pops his oozing prick out and rubs the slimy precum off against the demon's thighs.  Sheila, meanwhile, is busily trying to stimulate her pussy juice; you grab her hand and pull it away.  \"<i>A proper slave won't always have the luxury of a free hand.  Your body will have to learn on its own!</i>\"");
	
	outputText("\n\nThe mouse jams his dry penis into her cunt as if to punctuate your statement, and Sheila winces as it slides home.  \"<i>Ah...!  That's too much, mate!</i>\"  Ignoring her protest, you catch Jojo's eye and nod slightly.  He begins pumping at the tense woman, gritting his teeth at the friction of flesh-on-flesh.  You pull his tail taut, then wrap it tightly around his shaft to stifle his copious pre-cum.");
	
	outputText("\n\n\"<i>Too rough!</i>\" Sheila whines.  \"<i>I'll never get wet if I can't enjoy it a little!</i>\"");
	
	outputText("\n\nYou take her face in your hands, caressing her cheeks.  \"<i>But I'm giving you what you asked for.  Was all that talk about wanting cum in your pussy just so many words?  Can't you get aroused at the idea of being filled with seed, stuffed with babies from a slave's cock, turned into the brood mare you want to be?  Don't you want to feel him giving up to the tightness of your body, hot sperm painting the walls of your pussy as he squirts out his worship for you?  To feel it questing deeper, spreading and filling you with warmth, searching out every nook until it slips into your womb and finds your egg to start a new life?</i>\"");
	
	outputText("\n\nSheila shyly glances away as her mouth works and her face reddens again; Jojo seems to be having an easier time of it, and when you look down you can see her glistening juices along his tool, demonstrating the effect of your words.  As he thrusts harder, she begins sliding up and down of her own volition, shaking and humming.  \"<i>Oh, [name], you're right!  I can feel it!  I'm going to come!</i>\"");
	
	outputText("\n\nLowering yourself, you take hold of your mouse monk's sack at the base; he gives a high-pitched squeak as you squeeze, blocking the escape route for his semen.  You lean in until your mouth is next to the panting demon's ear, blowing and nipping at it as you await her orgasm.  When she begins to twitch and shake, rubbing her cheek against yours affectionately, you pull back and whisper directly to her.");
	
	outputText("\n\n\"<i>I lied.  I'll never let shit like you have a baby while I'm around.</i>\"  Sheila's eyes widen at your dangerously gentle tone as her nerves fire, starting her climax.  \"<i>You are a piece of self-indulgent trash who doesn't deserve to breed.  You spout high-sounding garbage from your mouth, while all the while taking any cock that can still get hard for your ruined body - you'd fuck a dog, as long as he listened to your bullshit.  I don't love you.  I don't know how anyone could.  You would have been better off living in a hole, covered in dirt.  You are... literally... the worst woman I know.</i>\"  Her mouth hangs open and her pussy gushes torrentially, grief preventing her from regulating it into releasing only a bit of her emotion into Jojo; he starts to weep into her back as the wave of Sheila's anguish and arousal hits him, though his cock still spasms out his first useless, empty orgasm in response.");
	
	outputText("\n\nSheila begins to cry now as well, twitching and shivering as her demon body dumps taint and unwanted feeling into your slave.  His balls swell, as does his cock; you can see it thickening as the juices soak and sink into it.  A pair of small points emerge from under Sheila's arms as the corruption forces demonic horns into existence on Jojo's skull, then curl upward and over her shoulders");
	if (sheilaCorruption() >= 90) outputText(", mashing her tits together as they thicken");
	outputText(".  The mouse himself seems to be growing, in fact.  His feet kick and thrash, sprouting dangerous-looking nails as his legs stretch prodigiously.  As his body mass increases, his white-furred skin begins to burst and peel like old rags, revealing new, dark flesh underneath.");
	
	outputText("\n\n\"<i>Ah!</i>\" Sheila shrieks, drawing your attention back.  \"<i>It's pushing against my... my womb!</i>\"  Jojo's cock must be growing in length as well as girth.  Seeing an opportunity, you grab her clitoris between your finger and thumb and rub it sensually, prompting another wave of orgasm from the woman that fills your mind with brief flashes of her despondency and your mouth with bile until you break the contact.  She is literally wishing her father were here to hold her and lend his shoulder to cry on.  A fresh gush of fluid soaks Jojo's cock as Sheila comes again, and her voice becomes a banshee wail as his size increases once more, pushing the tip past her cervix painfully.");
	
	outputText("\n\nUnable to focus any of her body's rampaging demonic energy to open her womb, a surfeit of shock pacifies her and her eyes glaze over; her scream finally drops to nothing as Jojo's penis pokes into places never meant to hold one.  ");
	if (sheilaCorruption() >= 40) outputText("Her breasts tighten up, shedding cup sizes rapidly; t");
	else outputText("T");
	outputText("he ex-monk's testicles swell again, to the size of basketballs, and his sack slips from your grip as the skin on it peels - your hand comes away with nothing more than a crumbling patch.  Finally free to come, Jojo's scrotum jerks upward and veins bulge on his cock as he begins ejaculating.  Sheila's eyes roll back in her head as Jojo dumps his semen directly into her womb, his recently engorged balls producing far more than their normal share.  With nowhere for the cum to go, her stomach stretches far and away past its normal volume, worrying you slightly.  A bump actually forms in Jojo's cock as she fills, and slowly starts to make its way upward; the ex-monk groans and thrashes as it gets stuck at the entrance to Sheila's pussy, which tightens like a vice around his ridiculously-expanded member.  He howls and tries to tilt his head, but only succeeds in jerking Sheila a bit higher on his cock with his new horns.  Reaching down to help, you can actually feel something hard through the erect flesh of his prick, and you gently coax and push it upward with your hands until it slips into the vagina.");
	
	outputText("\n\nHaving ejected this last lump, Jojo relaxes, falling backwards and pulling the swollen woman with him.  You blink in surprise as he stretches out; he's at least eight feet tall now and even makes Sheila look small by comparison.  The latter's face assumes a more normal mien as the reclining monk and the deflating shaft finally pull the head free from her cervix, and her hands dart to her rounded belly.  \"<i>Ohh, god... too much cum...</i>\"  A slow trickle begins to leak out around Jojo's cock from her pushes.  As the oozing slime coats his crotch, he begins panting again, and the flow cuts off as he hardens once more.  Realizing her predicament for the first time, Sheila begins struggling against Jojo's horns, trying to pull her nearly-flat chest free from the bony harness, though there's not enough room to move.  Still, her thrashing must be irritating the former monk; he reaches up with two huge hands to grab and steady her hips, then begins thrusting again, squeezing leisurely splats of semen out of the stuffed pussy.  Sheila's face pinches as the head once again presses up to her cervix, and you peer under the tensing woman at your ex-mouse.  What greets you are not the meek, pliant eyes of your slave, but the hard, covetous eyes of a demon.");
	
	outputText("\n\n\"<i>Well then,</i>\" you announce.  \"<i>I'm pleased to preside over the union of these two in holy matrimony.  I now pronounce you cum and dumpster.</i>\"  Leaning over Sheila, you whisper, \"<i>Maybe, if you're a good enough wife, you might even be able to squeeze out a baby.  You'll have to be obedient and clever to keep your new husband from just pounding you twenty-four hours a day in revenge and never even pulling out...  but even if he doesn't, you'll be okay with that, right?  After all, fucking is what you're meant for.</i>\"");
	
	outputText("\n\nSmiling grimly, you leave the wet sounds of sex behind you, wondering if Jojo will ever come when you call again.");
	
	//set lust to 100, huge corruption gain (like it matters), set sheilapreg to -3 and disable Jojo unless and until new corrupted content is written to reflect changes
	dynStats("lus=", player.maxLust(), "cor", 10, "resisted", false);
	flags[kFLAGS.SHEILA_DISABLED] = 4;
	flags[kFLAGS.JOJO_DEAD_OR_GONE] = 1;
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}
	
//Win - [Big Dick+Thighs] (usable for dicks with cockarea > 56) (all 10 of them)
//penis envy, go!
private function bigDickAndThighs():void {
	clearOutput();
	outputText("As Sheila diddles herself, you ");
	//[(not horse)
	if (!player.isTaur()) {
		outputText("doff your [armor]; the demon's eyebrows climb as you haul out " + player.sMultiCockDesc());
		if (player.cockTotal() > 2) outputText(" one at a time, practically stacking them atop each other");
		outputText(".");
	}
	//(horse)
	else {
		outputText("slowly draw nearer to her, your " + player.multiCockDescriptLight() + " bobbing with each step.");
	}
	outputText("\n\n\"<i>Oh no...</i>\" she says, blushing.  \"<i>[name], you're massive... are you really going to try to put something like that in my poor little pussy?</i>\"");
	
	//corr split
	//[(corr < 40)
	if (player.cor < 40) {
		outputText("\n\nWell... her hole does look a bit lilliputian compared to your towering tool.  \"<i>Where shall I put it, then?</i>\" you reply.");
		outputText("\n\nSheila smiles and rolls over, then spreads her legs apart on all fours.  \"<i>There's something I want to do... it'll feel good for you too, so could you come here, mate?</i>\"  She slips her hand between her thighs but, instead of plunging into her pussy as you expect, gives you a little finger wave from below it.  \"<i>Here; bring it here.</i>\"");
		
		outputText("\n\nCuriously, you ");
		if (!player.isNaga()) outputText("walk");
		else outputText("slither");
		outputText(" toward her and aim underneath her cunt to rub your [cockHead biggest] against her palm, smearing a glob of precum on it.  You can see her shivering wordlessly, sliding her fingers together to play with the hot, clingy fluid, making translucent webbing between them.");
		//[(multi)
		if (player.cockTotal() > 1) {
			if (player.cockTotal() == 2) outputText("  Both");
			else outputText("  All");
			outputText(" of them... slide them here, love,</i>\" the demon insists.  You line the remainder of your manhood up and force it between her thighs as well.");
		}
		outputText("  She takes the tip of your [cock biggest] in her hand and pulls gently, coaxing your forward; you close the distance until " + player.sMultiCockDesc() + " is peeking through her legs and your crotch is pressed against hers.");
		
		outputText("\n\n\"<i>I'm going to borrow a bit of your sensation...</i>\" Sheila announces quietly.  ");
		//[(not horse and not < 5"0)
		if (!player.isTaur() && player.tallness >= 60) outputText("She unbends and kisses you on the cheek, and your face feels a bit fuzzy where her lips touch.  ");
		outputText("\"<i>It'll still be amazing for you, I hope, but... this way I can join in too.</i>\"  The demon gives you a few experimental rubs with her slippery hand; you can barely feel anything.  She, however, seems to be falling over herself; her pussy squirms against you and her knees buckle, leaving her partly draped over your rod.");
		outputText("\n\n\"<i>Ripper... that's really...</i>\"  Your partner blushes and shudders.  \"<i>S-sorry, uh... just wanted to know what you get to feel once.  I'll be good.</i>\"");
		
		outputText("\n\n\"<i>You're a bit of a quick shot, I think,</i>\" you rejoin.  Sheila smiles wickedly");
		if (player.isTaur()) outputText(", unseen");
		outputText(".");
		
		outputText("\n\n\"<i>We'll see who finishes first.</i>\"  Resting herself against your " + player.multiCockDescriptLight() + " for support, she brings her other hand up and touches you; almost the full sensation is there this time, and you sign in happiness.  Sheila begins stroking with the new hand as well as the old, grabbing ");
		if (player.cockTotal() == 1) outputText("your dick with both");
		else outputText("a prick in each");
		outputText(" and angling upward so the precum drools downward and lubes her fingers.");
	}
	//(else corr >= 40)
	else if (player.cor >= 40) {
		outputText("\n\nThe fuck does it matter?  She's a demon.  You set your face and advance, and Sheila turns over with a grimace, raising her ass in the air.  \"<i>Just... go slowly so I can stretch,</i>\" she insists.");
		
		outputText("\n\nPfft.  You angle your [cock biggest] toward her vagina and thrust, heedless of the woman's pleasure.  She tries to focus and spread her pussy open; indeed you can see it widen several inches before you mercilessly slam your [cockHead biggest] into it.  Sheila gasps, then grits her teeth as you batter her entrance, demanding entry but being denied at each push.");
		
		outputText("\n\n\"<i>Useless,</i>\" you gripe.  \"<i>What kind of sex demon can't even open up her pussy?</i>\"");
		
		outputText("\n\n\"<i>Goddamnit, [name]; I'm trying, but it's bloody hard yakka with you touching all my fucking nerves and setting me off,</i>\" she fires back, shaking while you twist and roll your [cockHead biggest] inside her hot, stretched hole, smearing it with slippery precum.  Her tails hang down and wrap around your shaft, trying to hold it still; defiantly, you push and shift your hips harder.  Elbows buckling, Sheila drops to the ground.  Her head hangs in defeat as you smugly torment her vulnerable womanhood.  \"<i>Nnnn... fuck...</i>\"");
		
		outputText("\n\nThe two tails release their grip on your [cock biggest] and arch above it, pushing it suddenly out of alignment so your next thrust slips it between her thighs and bumps it up against her midriff.  The demon's hands dart to it, holding it in place and preventing you from pulling back out.  \"<i>Sorry, mate... can't focus like that...</i>\" she mumbles, looking over her shoulder at you.  \"<i>I'll make it up to you, though... promise.</i>\"  Her fingers search out your pre-bubbling urethra, dancing over it and sending a tingle up your tool.");
		
		//[(multi)
		if (player.cockTotal() > 1) {
			outputText("\n\nYou shudder at her surprising facility, but your mind still latches onto a way to get even more pleasure.  \"<i>Fine,</i>\" you agree, \"<i>but it won't be easy for you.</i>\"  Lining up your other prick");
			if (player.cockTotal() == 2) outputText(", you slide it through her legs between your first cock and her cunt, plowing through her entrance like a furrow; she quakes and you can feel it contracting against your skin.  ");
			else outputText("s, you push them through the woman's legs one by one, smearing warm precum on her thighs as you do; her pussy squeezes against the top of your [cock biggest] as you coat her skin with your fluids.  ");
		}
		else outputText("\n\n");
		outputText("Sheila scoots backward, choking up on monster cock until her ass is pressed against your crotch, and then wraps her hands around and begins to masturbate you, using your drooling fluid and her own wetness for lubrication.");
		
		outputText("\n\nShe seems to get off on it as much as you do; as she strokes, her tongue hangs out slightly and she begins rubbing your " + player.multiCockDescriptLight() + " between her " + sheilaCup() + " breasts, smearing your secretions down her entire torso.  Her skin is hot and feels good, but not as vivid as you'd expect.  The demon's pussy contracts wildly again, despite being at rest against your shaft, and you come to a realization: she's actually siphoning the pleasure from you!");
	}
	//end corr split
	outputText("\n\nThe woman quickly becomes lost in her own little world, searching out the nerves on your prick");
	if (player.cockTotal() > 1) outputText("s");
	outputText(" and teasing each one; you thrust weakly into her hand, helping guide her hands, but your lonely tip wants for stimulation.  As the feeling becomes so acute that you prepare to say something, Sheila uncannily anticipates you and scoots her pussy along your shaft, popping your [cockHead biggest] into her mouth.  Her tongue dabs at your slit, tasting your fluid, and her hands ");
	if (player.cockTotal() > 2) outputText("relinquish your other pricks and ");
	if (player.cockTotal() == 2) outputText("relinquish your other prick and ");
	outputText("focus on squeezing more drops out of you.  She fairly coats her lips with it, rubbing your hole against them before popping the whole [cockHead biggest] back into her mouth.  A moan escapes you just as another one returns from Sheila's throat, transmitted through your [cock biggest].");
	
	outputText("\n\nAs her attentions refocus on your [cockHead biggest], a pang of loss arises from the middle of your " + player.multiCockDescriptLight() + " - and is quickly smothered with her chest.");
	//[(sheila corruption < 50)
	if (sheilaCorruption() < 50) outputText("  Though her modest breasts can't even begin to encompass your girth, Sheila rubs her cleavage along your skin with gusto while she works your tip with her tongue.");
	else if (sheilaCorruption() < 150) outputText("  Her large " + sheilaCup() + " breasts encompass your girth easily, and she pushes the soft, flushed skin together as she slides it up and down your cock.");
	else {
		outputText("  The demon's ridiculously enormous breasts easily cover the entire length of your cock");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" falling between her crotch and her mouth, making her whole body feel like a huge, wet fuckhole");
		if (player.cockTotal() > 1) outputText(" built for " + num2Text(player.cockTotal()) + " pricks");
		outputText(".");
	}
	
	outputText("\n\nAnd yet, all these attentions basically amount to foreplay; you want more, want to finish and cover her face and chest with your load.  You pull your cock free of her mouth and begin to thrust between her slick thighs, wondering if hijacking your emotions makes her want the same thing.  Answering your question, Sheila pulls her sticky fingers away from her chest and lowers them to the ground, resuming her initial pose and squeezing her thighs together tightly.  ");
	//[(sheila corruption >= 150)
	if (sheilaCorruption() >= 150) {
		outputText("Her enormous breasts dangle all the way to the ground, forming a second, softer hole to push into with your swollen prick");
		if (player.cockTotal() > 1) outputText("s");
		outputText(".  ");
	}
	outputText("\"<i>Y-yes,</i>\" she mumbles, \"<i>gonna fuck her... harder...</i>\"");
	
	outputText("\n\nThe apparent answer to your question passes you by as you obliviously force your tool");
	if (player.cockTotal() > 1) outputText("s");
	outputText(" through the vise of her legs; losing yourself further and further to pleasure, you don't even notice when Sheila's hips begin to buck in time with your own, pressing her mons down against your ");
	if (player.cockTotal() > 1) outputText("topmost ");
	outputText("dick.  With an enormous, final thrust, you mash your crotch up against hers and begin to ejaculate.  ");
	if (player.cor < 50) outputText("The sensation seems to reawaken Sheila; she angles her body up to press her pussy close and your embezzled sensation floods back into you - along with an unexpected gift.  You can feel your... no, <i>her</i> demonic pussy convulsing repeatedly, trying to suck up sperm in vain as her own orgasm comes off, and she looks at you with sly eyes.  \"<i>A little reciprocity for my love,</i>\" the woman coos, \"<i>to show you how much I care.</i>\"");
	else outputText("\"<i>Oh god!</i>\" Sheila shrieks.  \"<i>I'm coming!  Jizz is going everywhere!</i>\"  Indeed, as your body releases streams of cum, Sheila directs them by aiming " + player.sMultiCockDesc() + ", covering herself and moaning as her hands press out as much as possible.");
	
	outputText("\n\nFinished, you pull your sensitive, soaked shaft");
	if (player.cockTotal() > 1) outputText("s");
	outputText(" from between her still-squeezing thighs with a shudder; Sheila shudders with you until you finally draw free and break skin contact, then lowers herself carefully to the ground.  The demon turns toward you, exposing a face and chest splattered with your semen.  She stares at your deflating prick");
	if (player.cockTotal() > 1) outputText("s");
	outputText(", looking almost wistful to see ");
	if (player.cockTotal() == 1) outputText("it");
	else outputText("them");
	outputText(" go.");
	
	outputText("\n\n\"<i>If you love cock so much, why don't you grow one?</i>\" you ask.");
	
	outputText("\n\nSheila giggles at that and raises her eyes, meeting your gaze.  \"<i>But it's only yours I love, [name].  I might take it off you as long as you promise ");
	if (!player.hasVagina()) outputText("to grow a nice pussy for me so that ");
	outputText("I can put it in you any time I want.</i>\"  She sticks her tongue out at you, and the seed dripping from her lips oozes onto it.");
	outputText("\n\nShaking your head, you leave her behind.");
	
	//reduce lust, reduce libido, reduce sens, +10 corr and sheila corruption -10 if corr <50 or -10 corr and sheila corruption +10 if corr >= 50
	player.orgasm();
	dynStats("lib", -1, "sen", -1);
	if (player.cor < 50) {
		dynStats("cor", 10);
		sheilaCorruption(-10);
	}
	else {
		dynStats("cor", -10);
		sheilaCorruption(10);
	}
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//Win - [Penetration, in Spades] - for self-loathing vaginas
private function winAgainstDemoNSheilaForVaginas():void {
	clearOutput();
	outputText("You drop onto the woman's lap without hesitation, ");
	if (!player.isTaur()) outputText("mauling her tits roughly with your hands, ");
	outputText("and grind your pussy desperately against her midriff.  She slips two fingers into you obligingly, but you ");
	if (!player.isTaur()) outputText("grab her face, plunging one thumb into the corner of her mouth in your haste, and");
	else outputText("turn your head and");
	outputText(" stare right into her eyes.  Focusing as hard as you can on your fantasy, you try to transmit your desire for something more to the demon by sheer force of will.  A sly smile parts her lips as she stares back - could this actually work?");
	
	outputText("\n\n\"<i>So... you like it when people come inside you, too?</i>\" she says, turning red.  \"<i>I can't give you babies, but if you want my juice all over your womb, I can do that.</i>\"");
	
	outputText("\n\nSuccess!  You can feel something firming up in her lap underneath your [butt], and you ");
	if (!player.isTaur()) {
		outputText("crawl away on your hands");
		//[(tail or naga)
		if (player.tailType > TAIL_TYPE_NONE && player.isNaga()) outputText(" and raise your tail");
	}
	else outputText("clamber to your hooves and bend your forelegs");
	outputText(" to present your eager [vagina].  Sheila sits up and places her hands on your [hips], then slides her pelvis up, teasing your lower lips with something bulbous and warm.  They sting slightly as it smears its slime along them, a not-entirely-pleasant sensation.");
	
	outputText("\n\n\"<i>I'm told this hurts, at first,</i>\" your demon lover says.  \"<i>Sorry.</i>\"");
	
	outputText("\n\nBefore you can utter a word to temporize, she slams her hips into yours, penetrating you neatly with her spade.");
	player.cuntChange(10,true,true,false);
	outputText("  Oh, god, it burns!  You shake violently as your pussy is assaulted by the fluid from Sheila's black tail, waves of pain twisting through it and forcing its walls to clamp down on the invader.  The demon gasps as you squeeze and leans forward onto your back");
	if (sheilaCorruption() > 0) outputText(", squashing her tits into you");
	outputText(".  \"<i>Calm down!</i>\" she barks, grabbing your arms and pulling them toward her.  With hands held behind you like this, you can do little to check her enthusiasm... but Sheila doesn't begin thrusting yet.  \"<i>It'll fade soon, love, and you'll start feeling it,</i>\" she promises, kissing your ");
	if (!player.isTaur()) outputText("neck");
	else outputText("withers");
	outputText(" as her strange, still shaft continues drooling into your pussy.  Your groin heats up in response to the pain, and her words ring hollow.  The burning doesn't seem to be getting any better; you look back over your shoulder at her, fear and hurt evident on your tightened features.  She smiles nervously at you, but the flow of goo doesn't stop.  It feels wetter and slicker in your pussy every second, and soon you can feel the slime begin to seep back out of your [vagina].  Trickle after trickle of fluid escapes you, falling to the ground underneath.");
	
	outputText("\n\n\"<i>Here it comes,</i>\" Sheila assures you.  The trickle intensifies as more of her secretion is pushed from you, and miraculously the pain seems to lessen as it comes out, landing with soft 'pat' sounds.  Your confusion must be written on your face, as Sheila leans in conspiratorially.  \"<i>That's not me doing it anymore, love.  It's you.</i>\"  To demonstrate, she pulls free of you - and the soft sounds of liquid hitting the ground only multiply!  She slides her hand in front of your pussy, cupping you gently, then pulls it away and holds it in front of your face.  It's overflowing with clear, female juices.  \"<i>Look how wet you are, my little whore,</i>\" Sheila says, spreading her fingers and letting the girl-lube trickle between them.  As you process this, she rests herself on your [butt] and slips her black, spaded tail into you again; the passage is easy and marked with none of the discomfort from before, only a pleasant heat that sets your heart racing.");
	
	outputText("\n\n\"<i>I'm going to fuck you now, like the slut you are, and then I'm going to shoot my steaming load in your greedy pussy,</i>\" the girl whispers, then returns her hands to your hips.  \"<i>I only wish I could knock you up and make you my woman.  A fine little piece of ass like you is wasted on the rest of the trash in this rotten world.</i>\"  She pushes in slowly, stirring you around and giving your hole every benefit of a long, teasing stroke.  \"<i>Would you like that?  Being filled with my babies?  I could grow a real cock, you know.</i>\"  Her pseudo-prick swells up, rubbing the entrance of your pussy as the barbs of the spade tug softly at you, and you swear you feel the bulge of veins growing along its length when she makes the next slow push.  \"<i>I could grow it real big, now that you're wetter than a drainage ditch after a monsoon, and keep you full of my come.</i>\"  She leans down and kisses you again, sending a thrill through your hot body.");
	
	outputText("\n\n\"<i>I'd visit you every day and spread you open; you'd drool your puddle on the ground, ready for me, and I'd rub my dong as you played with yourself, putting on a nice show... and then, when I couldn't stand it anymore,</i>\" Sheila whispers, breathlessly, \"<i>I'd climb on top of you, and I'd root you silly... like <b>this!</b></i>\"  The woman slides her hands up to seize your waist and begins reaming you, pounding your cunt with her tail so hard that the patters of fluid change to waves, silent for a second on the in-stroke and then splashing out all at once as the bulbous tip pulls back.  Your tongue lolls from your mouth as you roll your head, and Sheila takes the opportunity to grab a handful of your hair.  \"<i>Does that sound good, bitch?</i>\" she demands, yanking your head back.  \"<i>Do you want to be my sperm dumpster?  Do you want me to force myself into you and fill you with my jizz, day after day, whenever I damn well feel like it?  To come in you and tell you I love you and then leave you until I'm horny again, like a man?  Do you want to birth my babies one after the other, to make a swarm of imps to fill the sky and stain the world with our colors?</i>\"");
	
	outputText("\n\nYour [vagina] convulses in climax at the thought of being so debased - ");
	//[(lib <20)
	if (player.lib < 20) outputText("even as proud as you are, ");
	outputText("there's something appealing about the picture, something powerful in being cherished and used in equal measure.  Sheila screams and releases your hair, digging her fingers into your hips, spraying the inside of your pussy with a thick, oozing heat that spreads out and then dulls as your own pouring juices force her cum out.  Peering between your legs, you can see it falling to the ground; viscous black sludge that bubbles and steams as if it were trying to reach back up to your sex.");
	if (player.cor < 50) {
		outputText("  She pumps and pumps again, forcing more of the muck into your [vagina] even as she calls you the most filthy things she can think of");
		if (sheilaCorruption() > 0) outputText("; her tits wobble violently as she thrusts, and then still as she arches her back and jams her spade all the way in");
		outputText(".  Sheila howls to the sky as she pours her demonic slime into you in one final, solid stream.  You can feel it pushing eagerly through even your copious fluids until it's at the entrance to your womb... and then inside.");
		//[fertility up if not capped; tingle deep within body, instinctively you know you have become blah blah]
		if (player.fertility < 50) {
			outputText("  There is a tingle deep inside you, making you more fertile.");
			player.fertility++;
		}
	}
	else {
		outputText("  She stops pumping, falling against your back and panting as the last of her goo seeps out and is ejected around her shaft by your fountainhead of girl-cum.  You are clearer-headed than before as your orgasm dwindles, though, illogically, you could swear you felt her tits growing against you.");
	}
	outputText("\n\n\"<i>God damn,</i>\" she says, rubbing your [butt] and withdrawing her spade, to produce a splat as your pussy forces out the excess black slime.  \"<i>I love you so much, [name].</i>\"  You both collapse; your [vagina] continues to drool its dark-tinged lube for some time as you lay face-down with Sheila resting atop you, but eventually returns to nearly normal.");
	//[(if not wetness-capped)
	if (player.wetness() < 5) {
		outputText("\n\nYou think you may be a little wetter than before, though.");
		//[wetness level up]]
		player.vaginas[0].vaginalWetness++;
	}
	//slimefeed, reduce lust, reduce libido, +10 corr and sheila corruption -10 if corr <50 or -10 corr and sheila corruption +10 if corr >= 50, also fertility and wetness increases as denoted in the text
	player.slimeFeed();
	player.orgasm();
	dynStats("lib", -1);
	if (player.cor < 50) {
		sheilaCorruption(-10);
		dynStats("cor", 10);
	}
	else {
		sheilaCorruption(10);
		dynStats("cor", -10);
	}
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//Scarred blade
public function badEndScarredBlade():void {
	outputText("You collapse from your injuries and realize what's the scarred blade's going to do. It's GOING FOR YOU! You scream as the saber thrusts towards you.");
	if (silly()) rawOutputText("\n\n[DATA EXPUNGED]");
	if (marbleFollower()) outputText("\n\n\"<i>NOOOOO! Sweetie!</i>\" Marble cries.");
	getGame().inCombat = false;
	flags[kFLAGS.SCARRED_BLADE_STATUS] = 1;
	getGame().gameOver();
}

public function breakScarredBlade():void {
	outputText("The scarred blade falls to the ground, inanimate. You walk over to grab the saber to find out it's still moving faintly. The saber needs to be broken to ensure it poses no further danger and remains usable.\n\n");
	if (player.str >= 85) outputText("You grab the saber by the blade and bend it with all your might. The metal groans and the lethicite cracks. You repeatedly twist the blade until one segment of the saber finally snaps off.");
	else {
		outputText("You grab the saber by the blade and attempt to bend it with all your might. The blade refuses to bend despite your efforts. ");
		if (followerHel()) outputText("You call Helia over. \"<i>Hey, lover! Need any help?</i>\" she asks. You ask her if she can break the scarred blade. \"<i>Yes, lover. Hold the sword out.</i>\" Helia instructs. You hold out the scarred blade, Hel raises her scimitar up and slashes it cleanly through the scarred blade, cutting off the segment of the blade.");
		else if (followerKiha()) outputText("You call Kiha over. \"<i>Yes?</i>\"");
		else if (marbleFollower()) outputText("You call Marble over. \"<i>What is it you need, sweetie?</i>\" she asks. You ask her if she can break the scarred blade. \"<i>Yes, sweetie. I'll get my hammer.</i>\"");
		outputText("You throw the sword towards the tree and it lodges partway into the tree. With the additional leverage, you push and pull the sword to the side repeatedly. The metal groans and the lethicite cracks. After a few minutes of bending, one segment of the saber finally breaks off.");
	}
	outputText("\n\nYou examine the now-broken saber thoroughly to find out that it no longer moves at all. Whatever demonic power inside the scarred blade must be gone now. It looks like the sword is still usable. ");
	combat.cleanupAfterCombat();
	//inventory.takeItem(weapons.B_SCARB, camp.returnToCamp);
}

public function rebellingScarredBlade(wieldAttempt:Boolean = false):void {
	if (!wieldAttempt) outputText("<b>The scratched sword you carry jerks wildly like a bucking horse, and, tilting hilt-downward, slides itself right out of its scabbard.  Before you can pick it up and re-sheathe it, it lashes out at your hand, cutting you and landing with the point out.  Even when you try to circle it and grab the handle, the uncanny saber spins its edge around to fend you off.  Sighing with irritation, you abandon it for now.</b>\n\n");
	else outputText("As soon as you try to wield the sword, it jerks wildly like a bucking horse. You quickly put it back into your pouches before it can do harm to you.");
	if (!wieldAttempt) {
		var dmg:int = 20
		dmg -= player.armorDef;
		if (dmg < 1) dmg = 1;
		HPChange(-dmg, false);
		player.setWeapon(WeaponLib.FISTS);
		flags[kFLAGS.SCARRED_BLADE_STATUS] = 1;
	}
	doNext(playerMenu);
	addButton(1, "Fight", startCombatImmediate, new ScarredBlade, true, null, "Fight the saber and try to break it. This is going to be a risky battle and a loss can mean your demise.");
}
public function findScarredBlade():void {
	outputText("A nearby flash of light on metal catches your eye.  Drawing closer to it, you find the blade you abandoned before sticking point-down in the dirt.  The tainted saber leans toward you, presenting its hilt almost pleadingly.  Take up the sword again?");
	doYesNo(takeScarredBlade, leaveScarredBlade);
}
private function takeScarredBlade():void {
	clearOutput();
	outputText("You grab the bloodthirsty saber and pull it from the ground. ");
	flags[kFLAGS.SCARRED_BLADE_STATUS] = 0;
	inventory.takeItem(weapons.SCARBLD, camp.returnToCampUseOneHour);
}
private function leaveScarredBlade():void {
	clearOutput();
	outputText("You choose not to take the saber, leaving it to rust. ");
	flags[kFLAGS.SCARRED_BLADE_STATUS] = -1;
	doNext(camp.returnToCampUseOneHour);
}

/*Sheila's Lethicite:

[piercing for magicfags]
//add [S. Lethicite] to Rare Menu of any piercing

[blah blah blah Tel'Adre blah blah piercing bodyparts furry shit gems - Rare Menu - S. Lethicite]
You hold out the stone you acquired from Sheila to the artist, and ask if she can use it.

"A Lethite?  Yeah, I can work with that; it's right there on the menu.  You didn't need to bring your own, though."  She considers for a bit.  "Well, it'll save me some material costs... 100 gems instead of 1000.  I'll have to fit and polish it, and the labor's not free.  Still want it?"

[Yes]/[No] (no goes back one screen)


[blah blah blah Tel'Adre blah blah piercing bodyparts furry shit gems - Rare Menu - S. Lethicite - Yes]
//suppress usual Yara output
You can feel an odd, foreign arousal filling you as your skin wicks latent magical energy from your new piercing.  Yara's bewildered eyes meet yours briefly, then seem to gloss over as the magic dissipates, jumping the gap from you to her.  "Th-that looks nice," she says, shaking.  Her thighs clap together hurriedly, though not before a wet spot forms on the front of her pants, and she finishes her appraisal in a hurry.  "Thank you!  Co... co... cum again!"  Blushing, she shoos you out of the store.  <b>It looks like Sheila's gift has amplified your talent for magical emotional manipulation!</b>  You can only imagine how demons will react to the wellspring of tainted energy, though.

(Gained Perk: Pierced: Lethicite)

//subtract 100 gems, add perk, remove Sheila's Lethicite key item, set sheilacite = 2




da perk:
Pierced: Lethicite - Sheila's stolen soul aids your black magic, but demons practically line up behind you now.

da effect:
//improve black magic output by like 15-20% or someshit and increase demon and imp encounter rate by two or three times a normal Lethite piercing effect
//what am I, a fucking dev?
//if using Arouse against either version of Sheila with this perk active, automatically set monster lust = 100 and add to spell effect the output "The residual magic from Sheila's lethicite flares up in you, resonating with the woman as you cast your spell; her eyes widen as her knees buckle and dump her onto the ground, drooling lubrication from her vagina."


Scarred Blade - Blacksmith-made:
//[Craft] button in Weapons option of Tel'Adre if PC has Sheila's Lethicite

The blacksmith turns an appraising eye on you as you approach him without looking at any of the weapons on display.

"What do you want?" he says, with characteristic gruffness.

You pull out the dark purple crystal you received from Sheila and ask if it would be possible to alloy a blade from it.  He doesn't move to take it from your outstretched hand just yet, but you can see a hint of interest in the softening of his features.  "That's a lethicite.  Where'd you get it?" asks the smith.

"Stole it from a demon," you lie.

He considers for a moment more before responding.  "Well done, then."  At that, he takes the crystal gingerly from your hand.  "Never worked with this before.  I promise nothing, but come back in two weeks.  I should have an update for you."
//remove Sheila's Lethicite key item, set sheilacite = 3, start sheilaforge timer, increment once per day at 0:00

//repeat visits to weapons shop while sheilacite = 3
[if sheilaforge < 14]
The weaponsmith looks up from the forge as you enter.  "Oh, it's you.  I'm not done yet."  With a gesture, he dismisses you.  You can only content yourself with looking at the finished products.

//goto normal weapon list


[if 14 <= sheilaforge < 21]
The smith looks up as you enter, and you could swear the already-thin, no-nonsense line of his mouth becomes even tighter.  "It's you.  Come here."

Obligingly, you approach him, though the forge's heat is stifling.  "I finished.  The crystal impregnated the metal easily, but the blade itself... just have a look."  He picks up a tatty scabbard from a pile of half-finished weapons and holds it to you - as he does, you notice for the first time the numerous bandages on his hands.  A bit wary, you unsheathe the blade halfway; it hisses against the oiled leather as you draw it.  The revealed form of the weapon is slim, curved rakishly, and glows with an umbral light against the backdrop of the lit forge, but its broad side is covered in deep lines.

"Damnedest thing.  I couldn't straighten the blade for the life of me - with every hammer blow it would leap, vibrating, from the anvil, and warp somewhere else, adding a new twist for each one I took out.  After a few failures, I settled for a backsword design and channeled the bending toward the flat edge.  That's not the uncanny bit though.  You can see how sharp it is; the edge fairly shaped itself with just a touch of the grinder.  I haven't honed it - didn't need to.  But when I tried to etch a design just above the hilt, it would slide under the stencil, leaving a gouge on the blade."

Closer examination reveals the veracity of his claim: all the numerous scratches and flaws on the blade have their origins right above the tang, from the smith's abortive attempts at decoration.  Yet though several ugly gashes stop just short of the edge, none of them actually break the perfect arc, as if cutting were all the blade cared about.

"Damnedest thing," he repeats, breaking your train of thought.  "Every time the blade slipped, it would twist toward my hands.  It's as if it's alive and eager to find flesh.  Truth be told... I was debating whether to turn it over to the Covenant and tell you the crystal couldn't be used.  But you're here, so take it and go."  Giving you barely enough time to sheathe the blade again, he places a strong hand against your back and all-but-pushes you out to the street.

//gain 1 Scarred Blade, set sheilacite = 4


[if sheilaforge >=21]
The weaponsmith is at the forge.  As you approach, he looks up at you and quickly composes his face into a grimace.

"It's you.  I tried using your crystal.  It took to the metal easily enough but I couldn't get it to keep a... reliable edge.  City officials, ah, picked up the wasted scrap a little bit ago."  He looks away in what you guess is professional regret.  "Sorry."

//set sheilacite = 6


[Scarred Blade]
//tooltip
This saber, made from lethicite-imbued metal, eagerly seeks flesh; it resonates with disdain and delivers deep, jagged wounds as it tries to bury itself in the bodies of others.

//base attack power
~10

//hit effect - deals med-high% armor-piercing damage with a power of (corruption - 70) in addition to normal damage, output (only once if d. attack):
The blade jerks orgasmically as you send it home on [enemy], vibrating and trying to writhe out of your grip to get further inside them!

//if hitting Sheila with it, double all damage after calculation and output this instead of normal output:
The blade clings longingly to the woman, as if it had finally found its way home; when you pull it free with great effort, it leaves a long, tortuous cut in its wake.
//i found the control room!  -Metal Man

if PC has <= 70 corruption with Scarred Blade equipped, output this at end of hour
The scratched sword you carry jerks wildly like a bucking horse, and, tilting hilt-downward, slides itself right out of its scabbard.  Before you can pick it up and re-sheathe it, it lashes out at your hand, cutting you and landing with the point out.  Even when you try to circle it and grab the handle, the uncanny saber spins its edge around to fend you off.  Sighing with irritation, you abandon it for now.

//deal 10 pts damage before armor, unequip Scarred Blade, remove from inventory, set sheilacite = 5
//don't put in Benoit's shop if blade leaves inventory and sheilacite > 4

if sheilacite >= 5 and PC corr > 70, output this at end of hour
A nearby flash of light on metal catches your eye.  Drawing closer to it, you find the blade you abandoned before sticking point-down in the dirt.  The tainted saber leans toward you, presenting its hilt almost pleadingly.  Take up the sword again?

[Yes]/[No] (don't set a spacebar default here)

//if PC says yes, add Scarred Blade to inventory and set sheilacite = 4
//if no, set sheilacite = 6


tutoring Kid A while she wields Scarred Blade
The anemone attempts to draw the bloodthirsty saber at your insistence, but as she pulls it free of the scabbard, it jerks from her hands, lashing across her thigh before clattering noisily to the ground and spinning away.  Her shock grows as thick, clear fluid seeps from the cut, and she covers her mouth with her hands, looking up at you with piteous, wet eyes.  [(if corr <=70)The blade's edge flashes toward you as well, when you try to pick it up.  After a few frustrated attempts, it becomes clear that you'll have to abandon it for now.]
//empty Kidweapon; if corr <=70, set sheilacite = 5, else add Scarred Blade to inventory




to maybe do:


demon Sheila dreams!
- loyal squire/lady-in-waiting anxiously offering you her vag/hidden wanger re: demon Sheila's talk
- worm Sheila dream if sheilapreg = -2
- dream with PC in [Jojo/Sheila]'s place if sheilapreg = -3
(TBD)

XP-4 rape-pregnancy finale
-crying in the bushes
{TBD}

demon Sheila bangin' other wildlife
(TBD)

fuzzify Sheila by giving her a mighty veggie
-mistakes it for normal kangafrootloops when PC shows it to her during some lunch scene
-or else PC can sneak it in with her other forage during lunch
-end up with soft auburn fur all over, except for a large vase-shaped bare patch on her front that encompasses her face, neck, breasts, and navel
-tail gets longer
-be hella shy about being different from all her friends
-also be shy about whipping out her furry vag for sex
-no fuckin' muzzle
-super saiyan 4
(TBD)

demon cunt training!
-if you can fit in demon Sheila's snizz (cockarea <= 56), you can have her drip on your base while you're inside of her, to swell your dick up and stretch her pussy from the inside
(TBD)


something with huge tits
-titjobs are fucking boring
-maybe nipple torture?
-maybe they grow so big that she can only get off with her tails, so you restrain them and fuck with her
(TBD)


hidden bad end from losing to demon via HP 2+ times
gets annoyed, takes you home, ties you up, keeps you "safe"
(TBD)

demon sheila item use - gives confirmation request
lactaid: Sheila starts lactating, feeds player (succubus milk effect)
incubus draft: Sheila won't take it unless the player agrees to give up the quest and live with her; route to neutral bad end
(TBD)

*/
}
}
