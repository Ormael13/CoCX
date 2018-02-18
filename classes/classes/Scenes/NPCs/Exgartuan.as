package classes.Scenes.NPCs{
import classes.*;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;

public class Exgartuan extends NPCAwareContent implements TimeAwareInterface {

//EXGARTUAN STATUS
//v1 - Location - 1 = dick, 2 = tits
//v2 - Sleep counter - 0 = awake, positive numbers = hours of sleep
//const EXGARTUAN_TIGHTPANTS_MASTURBATE_COUNT:int = 413;
//const BOOBGARTUAN_SURPRISE_COUNT:int = 414;

/*function exgartuanMasturbate():void {
	
*/
//Dick(s)
//Tits
//Big ol' booties?
//Clits?

//Demonic fountain in desert
//300 xp

//1/40 chance of encountering fountain. It does not appear while possessed.
//When drank from, rewards 300 xp, a sizable random growth, and either boosts minimum lust by 5 or gives demonic possession.  

/*Possession details:
-Changes body part once a week (if possible)
-Dick
**Increases lust if not paid attention to (masturbation w/special scene)
***Goes to 'sleep' for 4-5 hours after being played with.
**More susceptible to female enemies - +lust every round.
**Taunts male foes, reducing their lust
**bulge-displaying armor shift
--\"Hours since cum\" raises at 3x rate.
**Removes worm infections
**Uses magic on goblins to make their cunts stretchier.
**Fetish Cultists gain lust every round from dick magic
**Sandwitches are interrupted when they ask if they can cast a spell on you.
**Turns it into a demon-dick.
**Forces you to try to rape bee girls


-Tits
--Randomly stops and starts lactating in various amounts
--Taunts your male foes, randomly increasing their lust.
--Random chance of raising your lust against any enemy.
--Smacktalks the shit out of bee-girls.
--Uses magic on succubi to make their tits bigger and decrease their speed.
--Forces minotaur titfucking scene.
--Kelt titfucking?
--New Breast-focused masturbation scene
--Random lust increases when time passes, combined with more growth.
*/

		public function Exgartuan() {
			EventParser.timeAwareClassAdd(this);
		}
		
		private var checkedExgartuan:int;
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean {
			var needNext:Boolean = false;
			checkedExgartuan = 0; //Make sure we test just once in timeChangeLarge
			if (player.hasStatusEffect(StatusEffects.Exgartuan)) { //Update Exgartuan stuff
				trace("EXGARTUAN V1: " + player.statusEffectv1(StatusEffects.Exgartuan) + " V2: " + player.statusEffectv2(StatusEffects.Exgartuan));
				if (player.statusEffectv1(StatusEffects.Exgartuan) == 1 && (!player.hasCock() || player.cockArea(0) < 100)) { //If too small dick, remove him
					outputText("\n<b>You suddenly feel the urge to urinate, and stop over by some bushes.  It takes wayyyy longer than normal, and once you've finished, you realize you're alone with yourself for the first time in a long time.  Perhaps you got too small for Exgartuan to handle?</b>\n");
					awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, false, true);
					player.removeStatusEffect(StatusEffects.Exgartuan);
					needNext = true;
				}
				else if (player.statusEffectv1(StatusEffects.Exgartuan) == 2 && player.biggestTitSize() < 12) { //Tit removal
					outputText("\n<b>Black milk dribbles from your " + Appearance.nippleDescription(player, 0) + ".  It immediately dissipates into the air, leaving you feeling alone.  It looks like you became too small for Exgartuan!\n</b>");
					player.removeStatusEffect(StatusEffects.Exgartuan);
					needNext = true;
				}		
				else {
					if (player.statusEffectv2(StatusEffects.Exgartuan) > 0) { //if sleeping, decrement sleep timer.
						player.addStatusValue(StatusEffects.Exgartuan, 2, -1);
						if (player.statusEffectv2(StatusEffects.Exgartuan) == 0) { //The demon awakens!
							outputText("\n<b>");
							exgartuanBored();
							outputText("</b>\n");
							needNext = true;
						}
					}
					else { //If not sleeping, stuff happens!
						if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) { //Dude stuff
							if (player.hasStatusEffect(StatusEffects.Infested)) {
								outputText("\n<b>");
								exgartuanWormCure();
								outputText("</b>\n");
								needNext = true;
							}
							else if (rand(10) == 0 && player.armor.supportsBulge) {
							/* Old way of doing it.
							(armorName == "sexy black chitin armor-plating" ||
							armorName == "glistening gel-armor plates" || 
							player.armorName == "leather armor segments" || 
							player.armorName == "comfortable clothes" || 
							player.armorName == "bondage patient clothes" || 
							player.armorName == "crotch-revealing clothes" || 
							player.armorName == "cute servant's clothes" || 
							player.armorName == "maid's clothes" || 
							player.armorName == "servant's clothes" || 
							player.armorName == "maid's clothes" || 
							player.armorName == "practically indecent steel armor" || 
							player.armorName == "red, high-society bodysuit" || 
							player.armorName == "spider-silk armor" || 
							player.armorName == "slutty swimwear" || 
							player.armorName == "full-body chainmail" || 
							player.armorName == "revealing chainmail bikini" || 
							player.armorName == "full platemail" || 
							player.armorName == "scale-mail armor" || 
							player.armorName == "black leather armor surrounded by voluminous robes" || 
							player.armorName == "rubber fetish clothes" || 
							player.armorName == "green adventurer's clothes" || 
							player.armorName == "white shirt and overalls")) {
							*/
								outputText("\n<b>");
								exgartuanArmorShift();
								outputText("</b>\n");	
								needNext = true;
							}
							else dynStats("lus", 1 + rand(2));
						}
						if (player.statusEffectv1(StatusEffects.Exgartuan) == 2 && player.biggestTitSize() >= 12) { //Chick stuff
							if (model.time.hours % 9 == 0) { //Only once every 9 hours or so.
								if (rand(3) == 0) { //lactation messing with!
									outputText("\n<b>");
									exgartuanLactationAdjustment();
									outputText("</b>\n");	
									needNext = true;
								}
								else if (rand(3) == 0) {
									outputText("\n<b>");
									if (rand(2) == 0)
										outputText("You feel warm and tingly, good all over.  Wait a second, your hands are playing with your " + player.breastDescript(0) + ".  You yank your hands away, but it only makes Exgartuan laugh with demonic pleasure!");
									else {
										outputText("Your hands knead and caress your " + player.breastDescript(0) + ", eagerly touching every inch of soft flesh.  You gasp when you realize what you're doing and pull them away");
										if (player.cor < 50) outputText(", angry at yourself for falling prey to the demon's directions");
										outputText(".");
										dynStats("lus", 5 + player.sens / 10);
									}
									outputText("</b>\n");
									needNext = true;
								}
								else dynStats("lus", 1 + rand(2));
							}
						}
					}
				}
			}
			return needNext;
		}
		
		public function timeChangeLarge():Boolean {
			if (checkedExgartuan++ == 0 && player.hasStatusEffect(StatusEffects.Exgartuan) && player.statusEffectv2(StatusEffects.Exgartuan) == 0 && model.time.hours == 4) {
				//Exgartuan must be present, must be awake and it must be night time
				if (player.hasCock() && player.statusEffectv1(StatusEffects.Exgartuan) == 1 && rand(3) == 0 && player.hoursSinceCum >= 24) { //Exgartuan night time surprise!
					outputText("\n");
					exgartuanSleepSurprise();
					return true;
				}
				if (player.statusEffectv1(StatusEffects.Exgartuan) == 2 && rand(3) == 0) { //Boobgartuan night time surprise!
					outputText("\n");
					boobGartuanSURPRISE();
					return true;
				}
			}
			return false;
		}
		//End of Interface Implementation

public function fountainEncounter():void {
	clearOutput();
	outputText("While roaming the shifting sands of the desert, you begin to feel a change in the air.  The bone-dry atmosphere shifts, becoming more and more humid as you press on.  At last you crest a dune and discover the source of the moisture – a huge onyx fountain, spraying crystal clear water into the air.  The center of the fountain is a magnificent sculpture of two entwined demonic forms, nude and over-proportioned to the extreme.  The water is spraying out from some rather... unconventional places.  You blush, feeling a bit parched, but wary of the fountain's nature.\n\n");
	outputText("You come closer and discover a placard.  It reads, \"Fountain of Endowment\".  Well, clearly it's supposed to enhance something, but at what cost?\n\n");
	outputText("Do you drink from the fountain?");
	//[Yes] [No]
	doYesNo(drinkFountainEndowment,camp.returnToCampUseOneHour);
}

private function drinkFountainEndowment():void {
	clearOutput();
	var changed:Boolean = false;
	player.slimeFeed();
	outputText("You cup your hands and bring the clear water to your lips, taking a long drink.  It's cool and refreshing, going down quite easily.  Weird.  You thought it would make you feel different somehow.");
	//+300 xp):
	if(rand(5) == 0) {
		outputText("\n\nA sense of... wisdom and clear-headedness emerges, making you feel far more sure of yourself.");
		player.XP += 200;
		changed = true;
	}
	if(!player.hasStatusEffect(StatusEffects.Exgartuan) && !changed && rand(2) == 0) {
		var choices:Number = 0;
		if(player.cockTotal() > 0) {
			if(player.cockArea(0) >= 100) choices++;
		}
		if(player.biggestTitSize() >= 12) choices++;
		//Can you be infested?
		if(choices > 0) 
		{
			if(choices > 1) {
				//Randomly pick one
				if(rand(2) == 0) exgartuanInfestDick();
				else exgartuanInfestTits();
			}
			if(choices == 1) {
				//If tits are big enough it must be them
				if(player.biggestTitSize() >= 12) exgartuanInfestTits();
				//If not then the dick was eligable.
				else exgartuanInfestDick();
			}
			changed = true;
		}		
	}
	//(+Big Tits)
	if(rand(3) == 0 && player.biggestTitSize() > 1) {
		outputText("\n\nYour [allbreasts] balloon, each growing about four bra-sizes larger... they feel so... jiggly and sensitive.  Even your nipples seem to grow with them!  Your [armor] feels tighter than ever!");
		player.nippleLength += .3;
		var i:int = player.breastRows.length;
		while(i > 0) {
			i--;
			player.breastRows[i].breastRating += 4;
		}
		changed = true;
	}
	//(+Big dick)
	if(rand(3) == 0 && player.cockTotal() > 0) {
		outputText("\n\nYour [cocks] feels tighter inside your [armor], even when flaccid.  You shudder and realize you've probably gained more than a few inches in total length, and who knows how your thickness has changed.");
		i = player.cocks.length;
		while(i > 0) {
			i--;
			player.cocks[i].cockLength += 3;
			player.cocks[i].cockThickness += .3;
		}
		changed = true;
	}
	//(+Big Clit)
	if(rand(4) == 0 && player.hasVagina()) {
		outputText("\n\nYour " + clitDescript() + " plumps up, visibly parting your lips even when you aren't turned on.  It probably ");
		player.clitLength += 2;
		if(player.clitLength < 6) outputText("gets as big as a cock");
		else outputText("gets bigger than most cocks");
		outputText(" now!");
		changed = true;
	}
	doNext(camp.returnToCampUseOneHour);
}
private function exgartuanInfestDick():void {
	spriteSelect(15);
	//(+Demon dick possession – not demoncocked)
	if(player.cocks[0].cockType != CockTypesEnum.DEMON) {
		outputText("\n\nYour [cock] puffs up, getting longer and harder, but also distorting as bumps and nodules sprout all along its surface.  The coloration darkens, turning a very dark purple as a ring of bigger nodules grow out around the head.  You now have a much larger and far more corrupted dick!   It dribbles pre-cum and twitches about as if sniffing the air, feeling very warm and sensitive.");
		outputText("\n\nA voice suddenly splits the air, demanding, \"<i>Satiate me mortal, or I'll make you find someone who will!</i>\"");
		outputText("\n\nWhat the hell was that?  You look around, but cannot find the source of the voice.  It speaks again, \"<i>Down here.  What are you, deaf!?</i>\"");
		outputText("\n\nYou look down, and find your demonic cock pointing directly at you, and shaking with... indignation?  The ground hits your " + buttDescript() + " hard as you fall backwards, too surprised to maintain your footing.  Is your dick talking to you?");
		outputText("\n\n\"<i>Yes I am.  You should consider yourself lucky – you're now the host of the great demon Exgartuan, and you'd best please me every few hours, or I'll make sure your body finds someone to relieve my building pressure.  But I think you'll do fine.  Come now, I can see a wonderful camp in your mind that we can paint white,</i>\" it suggests.");
		outputText("\n\nWell now... this was certainly unexpected.  Perhaps there's a way to be rid of this thing?");
		dynStats("lib", 5, "lus", 10, "cor", 10);
		player.cocks[0].cockType = CockTypesEnum.DEMON;
		player.cocks[0].cockLength += 1;
		player.cocks[0].cockThickness += .5;
	}
	//(+Demon dick possession – not demondicked)
	else {
		outputText("\n\nYour [cock] puffs up, growing even larger as it absorbs the fountain's essence.  It dribbles pre-cum and twitches about as if sniffing the air, feeling very warm and sensitive.");
		outputText("\n\nA voice suddenly splits the air, demanding, \"<i>Satiate me mortal, or I'll make you find someone who will!</i>\"");
		outputText("\n\nWhat the hell was that?  You look around, but cannot find the source of the voice.  It speaks again, \"<i>Down here.  What are you, deaf!?</i>\"");
		outputText("\n\nYou look down, and find your demonic cock pointing directly at you, and shaking with... indignation?  The ground hits your " + buttDescript() + " hard as you fall backwards, too surprised to maintain your footing.  Is your dick talking to you?");
		outputText("\n\n\"<i>Yes I am.  You should consider yourself lucky – you're now the host of the great demon Exgartuan, and you'd best please me every few hours, or I'll make sure your body finds someone to relieve my building pressure.  But I think you'll do fine.  Come now, I can see a wonderful camp in your mind that we can paint white,</i>\" it suggests.");
		outputText("\n\nWell now... this was certainly unexpected.  Perhaps there's a way to be rid of this thing?");
		player.cocks[0].cockLength += 1;
		player.cocks[0].cockThickness += .5;
	}
	player.createStatusEffect(StatusEffects.Exgartuan,1,0,0,0);
}
private function exgartuanInfestTits():void {
	outputText("\n\nYour [allbreasts] jiggle as they grow MUCH larger, turning into obscene mounds that shake with every motion of your body.  All your " + nippleDescript(0) + "s puff up with them, gaining volume to match their new, larger homes.  They feel hot and ache to be touched.");
	var i:int = player.breastRows.length;
	while(i > 0) {
		i--;
		player.breastRows[i].breastRating += 7;
	}
	outputText("\n\nA voice suddenly splits the air, demanding, \"<i>Touch me mortal, or be stained!</i>\"");
	outputText("\n\nYou look about in confusion, trying to locate the source of the voice.");
	outputText("\n\n\"<i>Oh for fuck's sake.  Look down.  Further... further... yes, right there on your chest.  BEHOLD!  The great archdemon, Exgartuan - inhabitor of excess!  I've taken up residence in your dainty bosom, and you had best work hard to keep me pleased, or I shall stain your clothes and soak you with my mighty milk!</i>\"");
	outputText("\n\nThe ground hits your " + buttDescript() + " hard as you fall backwards, too surprised to maintain your footing.  Are your breasts really talking to you?");
	outputText("\n\n\"<i>Yes I am,</i>\" mutters Exgartuan, spurting a trickle of milk from your " + nippleDescript(0) + "s for emphasis, \"<i>and you had better take me back to that lovely camp I can see in your memories and give me a nice long massage.</i>\"");
	outputText("\n\nWell now... this was certainly unexpected.  Perhaps there's a way to be rid of this thing?");
	player.createStatusEffect(StatusEffects.Exgartuan,2,0,0,0);
}




//[Masturbate while he's awake in dick]
public function exgartuanMasturbation():void {
	clearOutput();
	if(player.statusEffectv1(StatusEffects.Exgartuan) == 1) {
		spriteSelect(15);
		//Early prep
		if(player.cor < 15) outputText("You sheepishly find some rocks to hide in, where you remove your clothes.  Exgartuan loudly grumbles, \"<i>Quit fucking around and hiding.  I WANT someone to walk in on this!</i>\"\n\nDisgusting...\n\n");
		if(player.cor >= 15 && player.cor < 30) outputText("You make sure you are alone and strip naked.  Exgartuan mutters, \"<i>Why did you wait until you were alone?  Wouldn't it be fun to have a succubus wander in on us?</i>\"\n\n");
		if(player.cor >= 30 && player.cor < 60) outputText("You happily remove your [armor], eager to pleasure yourself.  Your possessed [cock] throbbs happily.\n\n");
		if(player.cor >= 60 && player.cor < 80) outputText("You strip naked in an exaggerated fashion, hoping someone might be watching.  The demon-possessed member at your groin pulses happily, flooding you with lust in reward for your attitude.\n\n");
		if(player.cor >= 80) outputText("You strip naked, fondling your naughty bits as you do so and casting seductive looks around, hoping someone or something is nearby to fuck you.  Your possessed member wiggles happily, flooding your body with feelings of lust and desire in reward.  Maybe it can call in a demonic companion for you?\n\n");
		//Low corruption characters
		if(player.cor < 33) {
			outputText("Too tired to resist the demon in your dick any longer, you grab it with both hands, lifting up the hefty dick with both hands as it floods with blood, swollen and purple.  Your whole body flushes, reacting to the strong feelings this... demon forces through you.  It makes your whole body blush with shame, but you force yourself to continue taking care of this abomination.  It really does feel good – you can see how some of the denizens of this land would fall to such sensation.  But you're made of sterner stuff!  At least that's what you assure yourself as your hands continue to lovingly caress the source of your pleasure.\n\n");
			outputText("You sigh, squeezing out thick globs of pre-cum as you fondle the nodule-ringed crown of your [cock], twitching happily against your hands.  Oh gods it feels too good to be true.  Happy coos of pleasure escape your mouth as you try to endure your lewd actions.  You struggle against your possessed loins as they guide your fingertips over the most sensitive places, temporarily stealing away control of your limbs.");
			if(player.tentacleCocks() > 0 || player.stamenCocks() > 0) outputText("  A tentacle-cock curls up, tightening around the base like an organic cock-ring.  It makes each of the corrupt nodules grow bigger, harder, and even more sensitive.");
			
			outputText("\n\nThe demon's voice teases you, \"<i>Such a pure champion, rolling in the dirt and moaning like a whore.  Do you really think you're saving anyone like that?  You can't even keep your own hands off your tainted dick!</i>\"\n\n");
			
			outputText("\"<i>No, it's not like that!</i>\" you yell, while pumping away, reveling in the feeling of your hands sliding up and down your pre-cum-soaked shaft.  Tiny moans interrupt your denial, punctuating it with short sharp moans of pleasure.\n\n");
			
			outputText("\"<i>Oh, you're already giving in to me?  I can feel the cum boiling in your ");
			if(player.balls > 0) outputText(ballsDescriptLight());
			else outputText("loins");
			outputText(", just aching to squirt out.  Relax and enjoy the feelings.  The more you accept it, the better it will feel.  Just give in and cum, I want to watch it splatter your face,</i>\" taunts your demon-dick.\n\n");
			
			outputText("There's no use fighting, it feels too good.  Your tongue hangs out of your mouth as you break under the assault, caving in to your physical needs.  The tip of your [cock] flares wide, pumping thick globules of seed through your urethra while your lower body squirms and writhes happily.  Your shame bubbles and splatters up into your face, painting it in thick gobs of goopy whiteness.  You wonder if the demon is right as some gets on your tongue, forcing you to sample a taste.  Somehow, you like it?  You moan in confusion – you shouldn't be enjoying this, but your body doesn't relent until it's given you a thorough coating.\n\n");
			
			outputText("Now sated, Exgartuan deflates, not even bothering to taunt you while you try to clean up the goop now splattered over your upper body.");
		}
		//Medium corruption characters
		else if(player.cor < 66) {
			outputText("Unable to handle the artificial lust the demon living in your crotch forces upon you, you grab hold of the monster with both hands, shivering at how good it feels.  Nothing should ever feel this good, but while it does, you may as well enjoy it, right?  Your body reddens as you really start to enjoy the feelings, as your hands caress every nodule-covered inch of your [cock].  On one hand, you can't believe the pleasure you're feeling, but on the other you feel like you should be doing more to resist it.  Oh well, too late now...\n\n");
			outputText("You squeeze out a few thick dollops of pre-cum, slicking the [cock] with the copious slippery stuff it drools out.  It never put out quite this much before, perhaps the demon Exgartuan is responsible.  You gasp when your hands squeeze the lubricated shaft between them, tightly jacking up and down, heedless of your desires and acting as slaves to the demon's needs.  You're feeling more and more like a passenger in your own body, but you really don't mind.  It's so easy to just relax and enjoy the hotness welling up inside you.\n\n");
			outputText("The demon speaks up, teasing you, \"<i>Already caving in to my corruption slut?  Are you truly so happy to let a demon control your body so lewdly?  Shouldn't you at least try to pretend not to be pleased by acting like such a wanton whore?</i>\"\n\n");
	
			outputText("His words ring true, but in your heart of hearts you know you're no slave to his corruption.  It's just that right now it feels so good; you love the sensation of both hands sliding up and down your cock, stroking and fondling each sensitive nub.  The flow of pre-cum thickens, practically pooling on your belly while your slippery fingers ");
			if(player.biggestTitSize() >= 5) outputText("shove the bloated demon between your [allbreasts], surrounding it in a home of jiggling flesh.  The wet demon-pre soaks into the skin of your tits, lubricating the passage as you mash them around, vigorously tit-fucking the source of your unholy desires.");
			else outputText("work the shaft relentlessly, drawing out more and more of the demon's pre-seed until your forearms and upper thighs are coated in the stuff, shining darkly.");
			outputText("  You pant and moan, forced to feel such wonderfully obscene sensations.\n\n");
			outputText("\"<i>You should look at yourself, panting and moaning like a rutting animal.  I wonder, are you still a champion  or a slave to the things I'm doing to you?  You look like a sex slave, but are you truly addicted to the feeling of squirting thick demonic jism?  Such a slutty champion you've become, [name],</i>\" taunts Exgartuan.  Part of you wants to object, to shout down his suggestions, but every time you open your mouth the only sound to escape is a wanton moan.\n\n");
			outputText("Your orgasm spreads through the demon like a wave.  You briefly wonder if it's the demon causing this to feel so good, or your own corrupt desires.  The thoughts are scattered by the feeling of a fat gob of spooge splattering over your [face].  You blink your eyes clear in time to see the fat, pulsating tip of your [cock] hovering in front of your face.  Your urethra spreads wide, launching another spurt and splattering it into your " + hairDescript() + ".\n\n");
			outputText("\"<i>Oh, if only your elders could see you now, soaking yourself in cum after submitting to a demon's will.  Ooooh, that feels good,</i>\" mutters your possessed prick as it continues to paint you, the hot eruptions tapering off into a steady trickle of whiteness, running down your [allbreasts].  You lie back, humiliated, but smiling happily at how RELIEVED you are after creating such a massive eruption.\n\n");
			
			outputText("Temporarily sated, Exgartuan deflates, not even bothering to taunt you while you try to clean up the goop now splattered over your upper body.");
		}
		//high corruption characters
		else {
			outputText("Happily giving in to the desires of your inner demon, you grab hold of your [cock] with both hands, feeling its heavy mass slowly expanding inside your tight grip. It pulsates with dark powers and corrupted lusts, tingling pleasantly as it grows to its full, erect size.  You pet it gently, soothing the demon inside with expert touches that fill the both of you with explosions of pure delight.  Each of the hundreds of nodules covering its surface grow erect in a wave, filling up as you become more and more turned on.\n\n");
			outputText("Exgartuan, never content to sit idly by, pipes up, \"<i>Ah yeah, just a little to the left OK?  I'm so glad I wound up in you.  I never would've thought a 'champion' would give such great cock massages.  I really outdid myself with you.  We should stay together like this forever.  Just think of all the wonderful things you could use me to do to your foes...</i>\"\n\n");
			outputText("He's so right too.  You could keep making him bigger until it's hard to move and he drags on the ground, but you're sure his demon-magics would entice plenty of corrupted sluts, and haze the minds of any uncorrupted person enough to bring them under the spell of your [cock].  Gosh it makes you hot!  Just thinking about having a harem of goblin girls massaging your mighty member while another grinds her eager gash against your tip... you NEED to make this happen.  Perhaps you could breed an army of the little sluts, to bear you around on a litter and squeeze out cum anytime you have the barest hint of lust.\n\n");
			outputText("Your [cock] seems quite taken with the idea, spurting hot globules of pre-cum until it's glazed itself in a coating of slick wetness.  Both of your hands rub along the surface, soaking themselves in the copious demon-goo, working it entirely of their own volition.  You manage to control your hips at least, and put them to work thrusting up, increasing the stimulation further, and spurring your [cock] to drizzle even more of its corrupt fluid.  It feels too good to try to resist, and there really isn't any reason to, is there?\n\n");
			outputText("\"<i>That's the ticket, [name], you're sooo good at this.  Now go ahead and let it out.  I want to paint your face with seed and watch it drip off.  You'll let me do that right?  Who am I kidding, I feel so good you'll let me do whatever I want, won't you slut?</i>\"\n\n");
			outputText("Oh gods he's right, you're going to let him aim at you and splatter you with waves of demonic jizz.  The worst part is, you can feel a large part of you looking forward to it.  You wonder what has happened to you as you give in, oblivious to the feeling of ");
			if(player.biggestTitSize() >= 5) outputText("your hands smashing your [allbreasts] around the [cock] and vigorously titfucking it.");
			else outputText("your hands repositioning your [cock] so it lays against your chest.");
			outputText("  Without a second thought you lean down to lick and suckle the head, performing auto-fellatio on the demon-dick sprouting from your groin.  You struggle to keep up with the flood of pre-cum, but you know you don't have long to wait...\n\n");
			outputText("You explode, filling your mouth with the tangy seed of your demonic submission.  Why did you ever think to resist such pleasure?  White hot release radiates out from your groin, making your body numb and happy as wave after wave of demon-spunk pours down your throat and spatters your face.  Such unholy pleasures, truly you deserve to enjoy them after what you've been through, right?  You wallow in a growing lake of syrupy submission, happy to be host to such a fun demon.\n\n");
			outputText("Temporarily sated, Exgartuan deflates, not even bothering to taunt you while you try to clean up the goop now splattered over your upper body.");
		}
		player.orgasm();
		dynStats("lib", .25, "cor", 1);
	}
	//TITURBATION
	else if(player.statusEffectv1(StatusEffects.Exgartuan) == 2) {
		if(player.cor < 50) {
			outputText("You shrug off your top, preparing to give into the demon's demands.  'At least I'll get to enjoy it too,' you muse, as you finish stripping the offending material from your torso.  You look down over your [allbreasts], and they don't look particularly evil.  Yet you know that within those wonderful mounds of breast-flesh lurks a great force of corruption, and worse yet, you know you're giving it exactly what it wants.\n\n");
		}
		//(ALT 1st PG)
		else {
			outputText("You shrug off your top eagerly, ready to cooperate with the demon inside your [allbreasts] and enjoy a relaxing tit-massage.  You slide the offending material to the side and marvel at the wondrously large orbs on your chest.  Truly any place that can give you such wonderful endowments can't be evil.  You lean back, enjoying the warmth in the air as it flows over every extra-sensitive inch of your mounds, more than ready to get started.\n\n");
		}
		outputText("Both hands rise unbidden and begin to caress your " + breastDescript(0) + ".  They slide over every sensitive inch of ");
		if(player.hasFur() == Skin.FUR) outputText("furry-covered flesh");
		else if(player.hasScales() == Skin.SCALES) outputText("soft scaley flesh");
		else if(player.hasGooSkin()) outputText("gooey surface");
		else outputText("flesh");
		outputText(", pausing to gently squeeze and caress any particularly sensitive spots.  Soft sighs escape your lips from the self-imposed pleasure-assault.  Your body relaxes totally, slouching down against a rock while you continue to happily play with your [allbreasts].  The entire time your hands never touch one of your " + nippleDescript(0) + "s, merely circling them from time to time, making you arch your back in need.\n\n");
		outputText("A voice taunts, \"<i>Oh, does my champion tit-massager need a little nipple-play?  And to think I thought I was the one needing to get off.  Go ahead then, submit to your desires and play with your nipples.  Wallow in the pleasure that I can give you and remember who your true master is!</i>\"\n\n");
		outputText("At last, fingers wrap themselves about your " + nippleDescript(0) + "s, squeezing them gently and forcing happy gasps from your mouth.  ");
		if(player.hasVagina()) {
			outputText("Juice");
			if(player.cockTotal() > 0) outputText(" and pre-cum");
			outputText(" soaks your groin");
		}
		else if(player.cockTotal() > 0) outputText("pre-cum soaks your groin");
		else outputText("Warmth radiates through your body");
		outputText(" as you're more and more turned on by the feelings coming from your chest.  Fingertips ");
		if(player.nippleLength < 2) outputText("pinch together and pull, and it's too much for you.");
		else outputText("stroke your enlongated nipples, occasionally pinching them gently as you jerk them off.  It's far too much sensation for you.");
		outputText(" You shake and wriggle, overcome with a strange type of pleasure unlike a 'normal' orgasm.  The boobgasm does feel wonderful, but it does nothing for the aching lust that has built up in your crotch.  Perhaps you'll need to satisfy that as well.\n\n");
		//(lust + 15)
		dynStats("sen", .25, "lus", 15, "cor", 1);
		if(player.biggestLactation() > 1) outputText("As you calm down you realize your " + nippleDescript(0) + "s are dribbling streams of milk, and judging from the pools of whiteness in the soil, you turned into quite the little milk-sprinkler.  ");
		outputText("You blush and redress, noting that Exgartuan seems to be silent and sleeping...  maybe you'll get a little peace now?");
	}
	player.changeStatusValue(StatusEffects.Exgartuan,2,(12 + rand(7)));
	doNext(camp.returnToCampUseOneHour);
}


//(NOT PLAYED WITH RECENTLY: +LUST MESSAGE)
public function exgartuanBored():void {
	var select:Number = 0;
	if(player.statusEffectv1(StatusEffects.Exgartuan) == 1 && player.cockArea(0) >= 100) {
		select = rand(9);
		if(select == 0) {
			outputText("A muffled voice pipes up, \"<i>Hey!  You forgetting about me?  Fucking champions think they're so good, but you're ignoring your best body part!  Can't you feel all that cum boiling ");
			if(player.balls == 0) outputText("inside?");
			else outputText("in your [balls]?");
			outputText("  Well you'd better relieve me soon or I'll make sure your body finds someone who does!</i>\"");
		}
		else if(select == 1) {
			outputText("A tiny voice mutters, \"<i>How can you live with so few orgasms?  We need some quality time, [name].  You've got a LOT of tension building up...</i>\"");
		}
		else if(select == 2) {
			outputText("You feel a stirring inside your [armor] as it rubs against the material.  A muffled voice says, \"<i>Hey!  Don't forget me!  I need some air!</i>\"");
		}
		else if(select == 3) {
			outputText("\"<i>Hey!  WHATTHEFUCK ARE YOU DOING!?  I'll tell you what you're doing: NOT TAKING CARE OF YOUR DICK.  Get on it, or I'll make sure something gets on you!</i>\" Exgartuan orders.  What a prick.");
		}
		else if(select == 4) outputText("You feel your [cock] slowly expand and contract, air escaping its urethra and tickling your nether regions.  Did... did your dick just sigh?  Your demon is growing impatient.");
		else if(select == 5) outputText("Your [armor] suddenly bulges, a stifled voice picking up along with it, \"<i>There has to be a hole out there for me to fuck.  A mouth, a cunt... stop slacking off and get on it!</i>\"");
		else if(select == 6) {
			outputText("It's getting harder to concentrate... Exgartuan is ");
			if(player.balls > 0) outputText("teasing your ballsack");
			//[if vagina, no balls]
			else if(player.hasVagina()) outputText("poking your labia");
			else outputText("stroking your perineum");
			outputText(", \"<i>Come on, champion. You know you can't go on ignoring me much longer.</i>\"");
		}
		else if(select == 7) {
			outputText("Your possessed prick shuffles from side to side, \"<i>Have you just FORGOT how a dick works or something? I'll help remind you; step one: GIVE IT SOME AIR.</i>\"");
		}
		else if(select == 8) {
			outputText("Your [cock] has started rubbing against your thighs as a familiar voice chimes in, \"<i>I've got a hot, steaming batch of cum ");
			if(player.balls > 0) outputText("boiling in your [balls].");
			else outputText("cooking deep within you.");
			outputText("  Find me somewhere to deliver it or I'll be shoving it down your throat, champion!</i>\"");
		}
	}
	else if(player.statusEffectv1(StatusEffects.Exgartuan) == 2 && player.biggestTitSize() >= 12) {
		select = rand(8);
		switch(select) {
			case 0:
			 	outputText("You feel an ominous jiggling in your " + breastDescript(0) + " as the demon inside you stirs back to wakefulness.  The sound of a yawn being muffled by your [armor] confirms it.");
				break;
			case 1:
				outputText("After a few hours of peace, Exgartuan begins to stir.  You can feel a desire to be touched building within your [allbreasts].  What a needy demon.");
				break;
			case 2:
				outputText("Exgartuan wakes, making your [allbreasts] wobble pleasantly.  The need to have them groped and fondled slowly grows with the demoness's wakefulness.  She barks out, \"<i>Oi, bitch!  Touch your titties!</i>\"\n\nYou sigh.");
				break;
			case 3:
				outputText("Suddenly your " + chestDesc() + " feel as if they trying to force their way off your chest.  The strange motions are accompanied by some loud moaning, as if they are stretching awake.  Looks like the delightful peace and quiet has ended.");
				break;
			case 4:
				outputText("Your arms suddenly hug against your " + chestDesc() + " of their own accord, the squeeze filling you with a hint of warmth.  The demoness is awake and filling you with longing to be touched and teased.");
				break;
			case 5:
				outputText("Your " + chestDesc() + " fidget ominously, a muffled female voice piping up, \"<i>No cloth, metal, latex, or gel can protect you from me, champion.  Give in and caress these cans!</i>\"");
				break;
			case 6:
				outputText("The silent alone time you've been enjoying is coming to an end as the demoness dwelling within your bosom shifts in your [armor].  She wastes no time in stuffing you full of chest-focused temptations.");
				break;
			case 7:
				outputText("A menacing jiggle emanates from your bosom as they begin to speak, \"<i>Someone out there must be looking for a home to nestle their cock or some sweet milk to quench their gullet, champion.  Stop wasting their time and get on it.</i>\"");
				break;
		}
	}
}


public function exgartuanCombatUpdate():Boolean {
	//Monsters not effected by Exgartuan's stuff
	if(monster.short == "tentacle beast" || monster.short == "worms" || monster.short == "demons") return false;
	//VARS
	var select:Number = 0;
	if(player.statusEffectv1(StatusEffects.Exgartuan) == 1) {
		//[USE MAGIC TO MAKE GOBLINS COOCHIES STRETCHIER!]
		if(monster.short == "goblin" && rand(3) == 0) {
			outputText("A strangely harmonic voice chants gibberish, rising in volume and pitch.  It's coming from your groin!  The goblin girl giggles and squeals, \"<i>Stop that!  It's using magic on my coo-chiieeeeeee!!!</i>\"");
			//(+20 or 10% of cocksize, whichever is greater to vag capacity
			monster.addStatusValue(StatusEffects.BonusVCapacity,1, player.cockArea(0) * .1);
			monster.lust += 10;
			return true;
		}
		//[FETISH CULTISTS TURNED ON BY DEMON-COCK]
		else if(monster.short == "fetish cultist") {
			select = rand(3);
			switch(select) {
				case 0:
					outputText("The fetish cultist's eyes fixate on your groin, never seeming to leave as combat continues.  Exgartuan seems to have quite the effect on her, judging by the growing scent of feminine arousal in the air.");
					break;
				case 1:
					outputText("Openly touching herself, the fetish cultist's gaze never leaves your crotch, locked onto the outline of Exgartuan in your [armor].  What a slut.");
					break;
				case 2:
					outputText("The fetish cultist seems fixated by the twitching lump that resides in your groin, following it back and forth as you tease her, swiveling your hips.  Damnit why is this bitch even wasting time fighting?  She definitely wants to play with Exgartuan...");
					break;
			}
			monster.lust += 10;
			return true;
		}
		//(+Lust in combat) for girls
		else if(monster.hasVagina()) {
			select = rand(10);
			switch(select) {
				case 0:
					outputText("Thoughts of " + monster.a + monster.short + ", wrapping " + monster.mf("him","her") + "self around your throbbing demonic member consume you, flooding your body with lust.");
					if(player.cor < 50) outputText("  You glance down at the sensitive bulge in your [armor] and sigh.  Damned demons.");
					break;
				case 1:
					outputText("Desire courses through your veins, growing stronger as you watch " + monster.a + monster.short + "'s form.  You somehow realize the desire is artificial, but it doesn't make you want to mount " + monster.mf("him","her") + " any less...");
					break;
				case 2:
					outputText("Warmth spreads throughout your body as visions of yourself mounting " + monster.a + monster.short + " over and over flutter through your mind.  You might have to make them a reality...");
					if(player.cor < 50) outputText("  That's terrible!  It's all that demon's fault!");
					break;
				case 3:
					outputText("You really want to end this fight and bend " + monster.a + monster.short + " over... Why is this taking so long, your [cock] does NOT want to wait!");
					if(player.cor < 50) outputText("  You snap back to reality and curse yourself for falling to the demon's desires.");
					break;
				case 4:
					outputText("This fight has gone on long enough; all you really want is to shove your [cock] into the " + monster.a + monster.short + "'s... Wait, what? Your possessed pecker is getting the better of you.");
					break;
				case 5:
					outputText("For a moment, you find it hard to concentrate, visions of impaling the " + monster.a + monster.short + " with your [cock] etching their way into your mind.  Curse this horny demon!");
					break;
				case 6:
					outputText("Pleasure begins to radiate through your being, suddenly.  You snap back to your senses in time to see your hands stroking the bulge in your [armor], answering to the whims of an unholy force.");
					break;
				case 7:
					outputText("Maybe it would be best to just lay down your arms and strip off your [armor]. Just give yourself up to the " + monster.a + monster.short + " and let fate decide. Surely, " + monster.pronoun1 + " would return the gesture by embracing your [cock] and... Augh!  The demon is again toying with your judgment.");
					break;
				case 8:
					outputText("Tight loving assholes and gaping vaginas, slick long red tongues and breasts like fine china.  Succubi and the hot sexings they bring, these are a few of your favorite things!  ...Wait, what?  Was that musing your own?  And why are you absently stroking your [cock]?");
					break;
				case 9:
					outputText("It's becoming increasingly difficult to see this battle to its end when your mutinous mushroom is increasingly stiffening with each passing moment.  Exgartuan's weight is bad enough to your poise without extending it away from you.  What a jerk.");
					break;
			}
			dynStats("lus", 4+rand(5));
			return true;
		}
		//(Taunts Male Foes -enemy lust)
		else if(monster.cockTotal() > 0) {
			select = rand(8);
			switch(select) {
				case 0:
					outputText("Without any control over it, your hands undo your [armor] and reveal your [cock].  Somehow it launches into a tirade all its own, \"<i>You call that a cock?  Seriously?  And do the girls actually like that?  I can't imagine why.  That's right bub, keep wilting, you've got nothing on me!</i>\"");
					break;
				case 1:
					outputText("Heedless of your orders, both hands undo your gear, displaying your possessed member to " + monster.a + monster.short + ".  A disembodied voice taunts, \"<i>You really can't compete with me.  Seriously.  Take a good long look.  I'm the fucking business.  Why don't you tuck that pathetic excuse for a cock between your legs and chuck down some succubi milk until you're a girl?  You'd be better off.</i>\"");
					break;
				case 2:
					outputText("Your [cock] squirms around, pushing your [armor] out of the way.  Exgartuan barks, \"<i>Why are you bothering my host, fool?  Can't you see my magnificence?  You're nothing compared to me.  Go wank in shame and get out of our way.  We have cunts to fill.</i>\"");
					break;
				case 3:
					outputText("The waist of your [armor] expands as your [cock] flies skyward fully erect, \"<i>Tremble in fear, peon! My " + num2Text(player.cocks[0].cockLength) + " inches of might shame that feeble nub between your legs.  We've no time for your slack-jawed awe; go home and be a family man.</i>\"");
					break;
				case 4:
					outputText("Disobeying your will, your hands promptly undo your [armor], your [cock] springing forth and flaring its urethra menacingly at the " + monster.a + monster.short + ", \"<i>You have a dick not even a mother could love.  Has that thing ever graced another living being's flesh?  Run back to your lonely hovel full of unattainable fantasies, and leave the real action to the pros.</i>\"");
					break;
				case 5:
					outputText("Suddenly, your [armor] pitches an impossible tent, the colossal bulge pointing directly at the " + monster.a + monster.short + ".  You can only wince in discomfort as the back of your outfit pushes against you while a muffled voice taunts, \"<i>How can something so insignificant remain so ANNOYING?  Your mere presence dulls the obvious radiance before you. DROP DEAD!</i>\"");
					break;
				case 6:
					outputText("Your [armor] unexpectedly opens itself of its own accord, prompting your [cock] to extend into the open air, \"<i>All the chemicals, potions, and morsels in existence can't help that infinitesimal tool you possess.  The orifices of this world deserve better!  All you are accomplishing this day is their disappointment in delaying the inevitable.</i>\"");
					break;
				case 7:
					outputText("All of a sudden, your [armor] splays open, your [cock] quickly slithering up and around your back, stopping uncomfortably close to your face while pointing at your opponent, \"<i>Look at this pitiful cretin, [name].  We could be out spreading hot dickings to the wanting cunts of the land.  But, no!  This " + monster.a + monster.short + " desires eradication.  Well, champion...oblige him.</i>\"");
					break;
			}
			monster.lust -= 5 + rand(10);
			return true;
		}
	}
	//Exgartuan in tittays!
	else if(player.statusEffectv1(StatusEffects.Exgartuan) == 2) {
		if(monster.cockTotal() > 0) {
			select = rand(8);
			switch(select) {
				case 0:
					outputText("A flirty female voice with a rumbling undertone of demonic corruption teases, \"<i>Why fight us?  Just sit back and watch the giant breasts jiggle.  Maybe if you're good we'll let you slide in between our wonderful mammaries.  Isn't that nice?</i>\"");
					break;
				case 1:
					outputText("Your breasts wobble of their own accord, and " + monster.a + monster.short + " watches spellbound as they do so.  You silently thank Exgartuan for the help – maybe this fight will be easy.");
					break;
				case 2:
					outputText("A girlish voice calls out to " + monster.a + monster.short + ", \"<i>Hey cutey pie!  Why not just give up and submit, and maybe we'll let you play with our wondrous breasts.  Wouldn't that be nice?</i>\"");
					break;
				case 3:
					outputText("Your " + chestDesc() + " begin to playfully bounce up and down, making it difficult for you to focus on your fight.  You aren't too worried, however, as the " + monster.a + monster.short + " seems to be hypnotized by the movement.");
					break;
				case 4:
					outputText("A sultry woman's voice teases the " + monster.a + monster.short + ", \"<i>There's no need for hostilities, is there?  Merely lay down your arms and come help fondle these marvels of creation.</i>\"  Your " + chestDesc() + " shimmy for emphasis.");
					break;
				case 5:
					outputText("An alluring female voice perks up from seemingly nowhere, \"<i>We all know that you just want to nestle your head between these ferocious funbags.  No need to fight for them, just ask nicely!</i>\"");
					break;
				case 6:
					outputText("You feel a moistness forming on your chest as a womanly voice takes shape, \"<i>Come now, " + monster.short + ".  Surely this fight has made you thirsty.  I wouldn't want to let all of this delicious breastmilk go to waste after all...</i>\"  Oh, gods...");
					break;
			}
			//+Enemy lust
			monster.lust += monster.lib/10 + 5;
			return true;
		}
		else if(rand(3) == 0) {
			select = rand(3);
			switch(select) {
				case 0:
					outputText("A brief fantasy of " + monster.a + monster.short + " brutally squeezing and caressing your chest fills your mind.  You break free of the twisted daydream and pull your hands away from your " + breastDescript(0) + ".  Damnit you're in combat!  There's no time for such foolishness!");
					break;
				case 1:
					outputText("A blush colors your cheeks as warm pleasure spreads through your chest.  You spare a downward glance and nearly shriek when you see both hands busy massaging your massive mounds.  You don't have time for this!  You pull your hands away in a huff.");
					break;
				case 2:
					outputText("A moan escapes your lips as mental images of having your breasts touched and licks leap into your mind unbidden.  You force them aside to focus on the situation you're in.");
					break;
				case 3:
					outputText("Your battle stance is interrupted as your fingers decide they would rather begin groping your tits.  Your bewitched bosom is getting to be a nuisance.  You retract your hands with a huff, anxious to end this battle.");
					break;
			}
			//(+lust! Possible + enemy lust)
			dynStats("lus", 2+player.sens/10);
			if(rand(3) == 0) monster.lust += 5 + monster.lib/10;
			return true;
		}
	}
	return false;
}

//(ARMOR CHANGE)
public function exgartuanArmorShift():void {
	var changed:Boolean = false;
	if(player.armor == armors.BEEARMR) {
		outputText("The silken loin-cloth of your chitin armor cinches up, tightening against your groin until it displays the prominent bulge of your demon-possessed dick clearly.");
		player.modArmorName = "crotch-hugging sexy black chitin armor-plating";
		changed = true;
	}
	else if(player.armor == armors.GELARMR) {
		outputText("The green gel-plate protecting your groin thins and presses tightly against you, molding around your [cock] in an incredibly lewd way.");
		player.modArmorName = "crotch-hugging glistening gel-armor plates";
		changed = true;
	}
	else if(player.armor == armors.LEATHRA) {
		outputText("Your leather armor shifts, pressing tightly against your upper [legs] and molding itself around your [cock] to prominently display it.");
		player.modArmorName = "crotch-hugging leather armor segments";
		changed = true;
	}
	else if(player.armor == armors.INDECST){
		outputText("The chainmail bikini of your indecent steel armor rearranges and bends its interlocking rings to best shape itself around your [cock], leaving very little else to the imagination.");
		player.modArmorName = "crotch-hugging practically indecent steel armor";
		changed = true;
	}
	else if(player.armor == armors.R_BDYST){
		outputText("The thin, transparent material of your red bodysuit begins to firmly press against your groin, perfectly shaping to your [cock] and every last one of its nubs and nodules.");
		player.modArmorName = "crotch-hugging red, high-society bodysuit";
		changed = true;
	}
	else if(player.armor == armors.SSARMOR){
		outputText("The fine silk that makes up your armor suddenly undoes itself around your crotch, exposing your [cock] to the open air. The thin strands in the air begin to re-weave themselves around your enormous member, forming a prominent new addition to your protection.");
		player.modArmorName = "crotch-hugging spider-silk armor";
		changed = true;
	}
	else if(player.armor == armors.S_SWMWR){
		outputText("The miniscule piece of swimwear that doubles as a tent to your [cock] begins to grow and encapsulate it, molding itself perfectly to your manhood.");
		player.modArmorName = "crotch-hugging slutty swimwear";
		changed = true;
	}
	else if(player.armor == armors.FULLCHN){
		outputText("You\'re taken by surprise as the binds of your chainmail begin to flatten and rearrange themselves, doing their best to match the curves of your [cock] and make its presence known.");
		player.modArmorName = "crotch-hugging full-body chainmail";
		changed = true;
	}
	else if(player.armor == armors.CHBIKNI){
		outputText("Your chainmail bikini rearranges and bends its interlocking rings to best shape itself around your [cock], leaving very little else to the imagination.");
		player.modArmorName = "crotch-hugging revealing chainmail bikini";
		changed = true;
	}
	else if(player.armor == armors.FULLPLT){
		outputText("You begin to clench your fists as your steel platemail heats up around your [legs] and crotch. Slowly it begins to press itself against your [cock] and match its every feature.");
		player.modArmorName = "crotch-hugging full platemail";
		changed = true;
	}
	else if(player.armor == armors.SCALEML){
		outputText("The steel scales that make up your armor begin to flap wildly around your crotch. They bend and shift as they attempt to match the profile of your [cock].");
		player.modArmorName = "crotch-hugging scale-mail armor";
		changed = true;
	}
	else if(player.armor == armors.LTHRROB){
		outputText("Your leather armor shifts, pressing tightly against your upper [legs] and molding itself around your [cock] to prominently display it through your robes.");
		player.modArmorName = "crotch-hugging black leather armor surrounded by voluminous robes";
		changed = true;
	}
	else if(player.armor == armors.RBBRCLT){
		outputText("You begin to feel your rubber outfit compressing itself against your upper [legs] and [cock], eliminating any pockets of air or wrinkles that may have existed before.");
		player.modArmorName = "crotch-hugging rubber fetish clothes";
		changed = true;
	}
	else if(player.armor == armors.ADVCLTH){
		outputText("The layer beneath your tunic begins to compress against your [cock], highlighting every curve and nodule while lifting your package to be clearly visible beneath your outer layers.");
		player.modArmorName = "crotch-hugging green adventurer's clothes";
		changed = true;
	}
	else if(player.armor == armors.OVERALL){
		outputText("The denim of your overalls begins to press tightly against your [cock], molding itself around your member and its every facet.");
		player.modArmorName = "crotch-hugging white shirt and overalls";
		changed = true;
	}
	else if(player.armor == armors.C_CLOTH) {
		outputText("Your clothing shifts, tightening up about your crotch until every curve and nodule of your [cock] is visible through the fabric.");
		player.modArmorName = "crotch-hugging clothes";
		changed = true;
	}
	if(player.armor == armors.DBARMOR || player.armor == armors.TBARMOR) {
		outputText("The silken loin-cloth of your magical bark armor cinches up, tightening against your groin until it displays the prominent bulge of your demon-possessed dick clearly.");
		player.modArmorName = "crotch-hugging " + player.armor.name;
		changed = true;
	}
	if(player.cor < 33) outputText("  You cringe and blush bright crimson, raging against the demon inside you and wishing he would stop tormenting you!");
	else if(player.cor < 66) outputText("  You cringe a bit at the exhibitionist outfit you're forced to wear, but spend a little time admiring just how well the changes show off your package... Maybe Exgartuan isn't all bad?");
	else outputText("  You pivot your hips forwards, doing your best to show off your sensational package with every step.  Oh, very nice, you'll have to thank Exgartuan later...");
	if(changed) {
		//(Add perk \"Bulge Armor\" - bonus to male crotch reveal tease!) - check armor equip function – all names are hashed out in old armor names already
		if(player.findPerk(PerkLib.BulgeArmor) < 0) player.createPerk(PerkLib.BulgeArmor,0,0,0,0);
	}
}

//(FORCE OUT ANY WORM INFECTION)
public function exgartuanWormCure():void {
	outputText("Your ");
	if(player.balls > 0) outputText(ballsDescriptLight());
	else outputText("groin");
	outputText(" begins to grow warm... no, hot.  You feel it moving and squirming with discomfort as the worms inside you wriggle about, agitated by something.  The heat intensifies and you watch in a mixture of shock and horror as they start crawling out your urethra, sliding down to the ground on a river of thick seminal fluid.  You double over in pain as something stretches you wide, and you feel the main worm pushing itself through your [cock], desperate to escape.  It crests the tip, wiggling and stuck for a moment as it struggles to pull free.  At last it pops out and drops to the ground, crawling away.  Exgartuan roars, \"<i>AND STAY OUT!</i>\"");
	outputText("\n\nYou guess there was only enough room for one or the other...");
	player.removeStatusEffect(StatusEffects.Infested);
}

public function exgartuanLactationAdjustment():void {
	var boobs:Number = 0;
	//(Lactating Already)
	if(player.biggestLactation() > 1) {
		//(Increase)
		if(rand(2) == 0 || player.hasStatusEffect(StatusEffects.Feeder)) {
			outputText("Your nipples grow warm and sensitive, then start dripping milk into your [armor].  Exgartuan appears to be having some fun with you again...");
			player.boostLactation(player.breastRows.length);
		}
		//(Stops) 
		else {
			outputText("Your " + nippleDescript(0) + "s tighten up.  What's that demon up to?  Realization dawns on you when you realize your [allbreasts] no longer feel so 'full'.  Your lactation has stopped!");
			boobs = player.breastRows.length;
			while(boobs > 0) {
				boobs--;
				player.breastRows[boobs].lactationMultiplier = 0;
			}
		}
	}
	//(Not lactating)
	else {
		//(START)
		if(rand(2) == 0) {
			outputText("Your chest feels cold.  You touch your [armor] experimentally and discover a few drops of milk have leaked from your " + nippleDescript(0) + "s!  The demon has made you start lactating!");
			player.boostLactation(player.breastRows.length);
		}
		//Nipple stuff
		else {
			//(Bigger Nipples!)
			if(rand(2) == 0) {
				outputText("The inner surface of your [armor] arouses you as it rubs against your " + nippleDescript(0) + "s.  You think about it and realize they've never been like this before.  A quick check reveals each nipple has grown about a half inch longer.  Damn demons.");
				player.nippleLength += .5;
			}
			//(SHORTER NIPPLES!)  
			else if(player.nippleLength > .5) {
				outputText("As time passes you realize something feels different about your chest.  A quick glance confirms your suspicious – your nipples have somehow been shortened by about half an inch.  You've no doubt Exgartuan is responsible.");
				player.nippleLength -= .5;
			}
		}
	}
}
	


//[BEEGIRL RAEP]
public function exgartuanBeeRape():void {
	spriteSelect(6);
	clearOutput();
	outputText("You grin and embrace the demon's idea as if it were your own.  Maybe it's time the bee-girl had her own lesson in fluid insemination...\n\n");
	outputText("Walking forward with a bit of supernaturally-induced swagger, you close the remaining distance with your trembling victim, oblivious to the fact that your [armor] are rapidly disengaging themselves from your body and dropping to the forest floor.  She weakly protests, exposing her stinger, but the threat is clearly futile.  There's no way she'd touch you or your magnificent [cock] with such an inferior organ.\n\n");
	outputText("The smooth carapace covering her arms is a little slippery, but you manage to get a tight grip around her wrists and pin them over her head.  Holding them together, you grab one of the many forest vines and begin winding it around her hands, easily sidestepping the awkward jabs she makes at you with her poison-tipped appendage as her arms are bound tighter and tighter above her head.  The bulging abdomen hanging from her backside wriggles as you handle it, pulling it back and forcing it over the flower, out of the way.  A few more vines make sure it's strapped down and no longer a threat.\n\n");
	outputText("\"<i>You sure know your knots!   Speaking of knots, I got an idea...</i>\" exclaims the demon inside your [cock].  You wonder at what the demon could have in mind this time as you finish spreading the bee-bitch's legs in preparation.  The scent wafting out from her genitals is unreal, making you simultaneously hungry and incredibly horny.  You pull up the ginormous flanged tip with both hands and rub it over her honey-slicked crotch, mixing your demonic pre-seed with her honey as you smear it all over her downy inner thighs.\n\n");
	outputText("\"<i>No, please, it'll never fit!</i>\" she cries, trying to squirm against your bindings.\n\n");
	outputText("\"<i>Shut up and take it,</i>\" you and Exgartuan say in unison, enjoying a rather pleasant tingle that seems to spread through your tip with every rub against her.  Her lips slowly start to spread, glistening with honey as you slowly push them further and further apart, obscenely stretching them beyond any rational limit.  'Is this the true power of this demon?' you wonder as the poor bee-girl is stretched beyond her wildest imaginings.\n\n");
	outputText("Her insectile pussy feels unimaginably tight, but still you press onward, eventually managing to hump your bump-ringed cock-tip through her permanently widened entrance.  You keep up the assault, sliding inch after inch of your impressive girth into the egg-laying slut's passage, taking sick pleasure in watching as every detail of your cock's surface becomes visible on her belly.  Satisfied for now, you begin sawing in and out, relishing the pleasure-filled squeals your victim blurts out in time with your thrusts.  You feel almost as if you're playing her like an instrument, forcing it in further to raise the pitch and drawing it back out to hear the 'note'.\n\n");
	outputText("The bee-girl's abused body is becoming more and more limp with every brutal penetration, relaxing further and further to take in more of your [cock] as the rape continues.  You hear something splatter against the ground and look around her ass to see what's going on.  The cunt's ovipositor is hanging out and dripping with more of her sweet fluids!  She's really getting off on being a yellow and black cock-sleeve.  The limp tube spasms and stretches as a number of large lumps start working their way down the tunnel, released by her unintentional orgasms.\n\n");
	outputText("It does not take long for the feeling of being in such a tight hole to push you beyond any point of endurance, and the obscene squelching mixed with high pitched moans doesn't help any.  You feel your orgasm building, flooding your groin with heat.  You press your body tightly against hers, forcing as much of yourself as possible inside her as you go off the deep end.  Wave after wave of spunk pumps into the bee, squeezing out an equal amount of eggs from her ovipositor.  Wet plops greet your ears in time with each spurt of seed you push into her.  Apparently, the eggs go in the very hole you're now abusing.\n\n");
	outputText("You pull out with a satisfied grunt, enjoying the wet 'schlick' sound your [cock] makes as it pulls free of the bee-girl's once-tight hole.  Where once there was a honey-coated slit now resides a gaping monster, drooling a gooey mixture of slime and your tainted demonic seed.  Well, maybe her queen will have an easier time packing her full of eggs.\n\n");
	outputText("You redress, whistling happily as you prepare to leave.  Your victim is practically unconscious, still shaking from the intense experience and leaking eggs and honey from the organ on her backside.  Do you cut her down or leave her bound up for the locals to enjoy?");
	player.orgasm();
	dynStats("lib", 1, "cor", 2);
	simpleChoices("Leave Her", leaveBeePostRape, "Free Her", freeBeePostRape, "", null, "", null, "", null);
}

//[Free Her] (negates some corruption gain)
private function freeBeePostRape():void {
	clearOutput();
	outputText("You take pity on the slut and untie her.  Hopefully she'll recover before something worse finds her.  You'd hate to let a tentacle-beast get your sloppy seconds.");
	doNext(camp.returnToCampUseOneHour);
	dynStats("cor", -1);
}

//[Leave Her]
private function leaveBeePostRape():void {
	clearOutput();
	outputText("You smile cruelly and give her glittering vulva a gentle smack before you walk away, leaving her tied up there.  Maybe some lonely imps will find a use for her...");
	doNext(camp.returnToCampUseOneHour);
	dynStats("cor", .5);
}

private function exgartuanSleepSurprise():void {
	spriteSelect(15);
	//Low corruption
	if(player.cor <= 20 && player.findPerk(PerkLib.BulgeArmor) >= 0) {
		outputText("A light breeze skims across your face, slowly fading away what little sleep you had managed to enjoy.  As your eyes slowly open and adjust, you begin to faintly make out the red moon sitting high in the sky through the fabric of your " + camp.homeDesc() + ".  What little light there is comes from the faint remnants of your campfire, down to just embers by this point.  You slowly roll your head to look towards the warmth only to find the entrance to your " + camp.homeDesc() + " still wide open.  A slight grimace forms as you begin to stretch awake, only to interrupt yourself upon the realization that you are still wearing your [armor].  A quick yet groggy glance also reveals that you've also managed to fall asleep on top of your " + camp.bedDesc() + " rather than nestled cozily inside it.\n\n");
		
		outputText("You glide your hands up past your forehead and through your " + hairDescript() + " as you sit up, indulging in a relaxing, deep breath.  Seeing as how you don't appear to have transmogrified or been roughed up in any discernible fashion, your best guess is that you fell asleep while unraveling your " + camp.bedDesc() + ".  Too tired to further debate this with yourself, you begin to strip naked while thoughts of returning to blissful slumber ease any lingering worries.");
		//[if armorname IS NOT EQUAL TO \"<i>
		if(player.armorName != "crotch-hugging slutty swimwear" && player.armorName != "crotch-hugging revealing chainmail bikini") outputText("  You remove your [armor] piece by piece, leaving only the magically-altered centerpiece that your favorite demon ever so generously \"<i>gifted</i>\" to you.\n\n");
		//[else]
		else outputText("  You glare at your [armor], its altered state so graciously bestowed upon you by the ever-thoughtful demon that resides in your crotch.\n\n");
		
		outputText("After listlessly staring at your forced exhibitionism for a few seconds, your sleep anxiety wins over.  You bend over to begin taking off the article... only to find that it refuses to budge.  It acts as if it were adhered to your skin, resisting any actions to undo it from your groin.  After fidgeting with it for a few seconds, you let out an exasperated groan.  You're certainly in no mood to struggle with it nor who's responsible any further, reaching over and pulling up your covers.  One more sigh escapes your lips as you gaze upon the unsightly bulge before resting back on your pillow and closing your eyes.\n\n");
		
		//[new page. If lust <75, raise to 75]
		doNext(exgartuanBulgeTortureII);
		return;
	}
	else {
		outputText("Something interrupts your relatively peaceful sleep midway through the night.  Once pleasant dreams shift and morph to nightmares in a heartbeat!  You're gagging, choking even, and no matter how you twist and struggle you can't breathe!   Spikes of terror jump-start your heart and propel you back to wakefulness at breakneck speed.  Your eyes snap open and you try to sit up, but pain lances through your groin and throat, holding you in position.  Completely panicked, you look as far down as your restricted vision will allow and recoil in horror.  The bulging, veiny mass of your [cock] is lodged deep in your throat, arching and twitching hard enough to slide itself in and out with gentle half-strokes.\n\n");
		
		outputText("With your diaphragm spasming wildly, you strain to pull in a single breath.  It doesn't work, and  the suction only makes your demon-infested dick bigger and thicker inside the constricting rings of your throat.  The taste is thick on your tongue, and the pleasure rises in equal parts with your panic until black rims the edge of your vision.  Your back arches with your body's struggles, and the rear of your airway opens enough for you to inhale a lungful of air through your nostrils.  The knowledge that you aren't going to suffocate on your own swollen cock-meat washes away the panic, leaving only the pleasure of the forced fellatio in its wake.\n\n");
		
		outputText("A voice thrums in your head, \"<i>");
		//Split based on how often done
		if(flags[kFLAGS.TIMES_AUTOFELLATIOED_EXGARTUAN] == 0) {
			outputText("This is how you fucking please a dick!  If you aren't going to take care of our needs, then I will!  Every night if I have to!");
		}
		else if(flags[kFLAGS.TIMES_AUTOFELLATIOED_EXGARTUAN] < 2) {
			outputText("Oh come on, remember how hard you came last time?  Why don't you stroke the shaft with your hands and I'll see if I can pump more into your belly.");
		}
		else if(flags[kFLAGS.TIMES_AUTOFELLATIOED_EXGARTUAN] < 10) {
			outputText("How many times have we done this now?  It's probably past time you got used to sucking yourself off at night and quit making a fuss about it.  Now that you're awake, let's put that tongue to use and get to stroking.  I feel a big finish coming!");
		}
		else {
			outputText("Wakey wakey sleepyhead.  You know the routine.  Go ahead, ");
			if(player.biggestTitSize() > 1) outputText("wrap your tits around me and squeeze");
			else outputText("wrap your arms around me and stroke");
			outputText(".  We're so horny aren't we, my needy little champion?");
		}
		outputText("</i>\"\n\n");
	
		//(LOWCOR: 
		if(player.cor < 33) {
			outputText("You grab hold of the perverse prick with both hands, not to stroke it, but to try and pry the invader from your oral cavity by force.  The surface is slick with sweat and pre-cum, and your hands slide inexorably towards the ");
			if(!player.hasSheath()) outputText("base");
			else outputText("sheath");
			outputText(" instead of pulling it free.  Your eyes cross from the feelings coming off your traitorous, possessed flesh after the accidental caress.  Both hands start to pump away, autonomously jacking the swollen demon-shaft into your mouth");
			if(player.biggestTitSize() >= 2) outputText(" and bouncing your [allbreasts] around it");
			outputText(".  Moans of pleasure vibrate the [cockhead] lodged in your throat while bubbles of wetness begin to slide down the lower half of your esophagus into your gullet.\n\n");
		}
		else {
			//MED+ COR, NOT DONE A LOT:
			if(flags[kFLAGS.TIMES_AUTOFELLATIOED_EXGARTUAN] < 5) {
				outputText("You grab hold of your over-sized, demon-infested organ with both hands, resigned to this fate.  Even if you managed to stop Exgartuan now, he would just start all over again once you'd fallen asleep.  The pre-slicked, veiny surface slides through your fingers, outputting a cacophony of pleasure through your nervous system.  Your eyes cross from the feeling, and you actually cry moans of need into your own [cockhead].  It vibrates pleasantly, dumping a few loads of pre-cum into your gullet while ");
				if(player.biggestTitSize() >= 2) outputText("you squeeze your tits around your [cock] with your biceps");
				else outputText("you squeeze and caress your " + cockDescript(0));
				outputText(".  With both hands beginning to stroke faster and faster, you give yourself over to the corrupted lust that's burning in your veins.\n\n");
			}
			//(MED+COR, DONE A LOT:
			else {
				outputText("You grab hold of the swollen flesh with both hands and start to stroke it, reveling at the feel of your palms sliding along the veiny, pre-cum slicked flesh.  You gurgle happily, your moans of pleasure vibrating the [cockhead] in your esophagus.  The swollen cock-tip dumps globules of pre-cum down your stretched throat, directly into your hungry gullet.  With both eyes crossed and your hands absorbed in fondling your member, you quickly forget your irritation at being woken up in such a way.  You get to cum SO HARD when you're fucking yourself like this!");
				if(player.biggestTitSize() >= 2) {
					outputText("  Your biceps squeeze around your [allbreasts], mashing them into your [cock] and adding to the pleasure.");
					if(player.hasFuckableNipples() && player.biggestLactation() > 1) outputText("  Milk and lubricants ");
					else if(player.hasFuckableNipples()) outputText("  Lubricants ");
					else if(player.biggestLactation() > 1) outputText("  Milk ");
					if(player.hasFuckableNipples() || player.hasFuckableNipples()) {
						outputText(" from your " + nippleDescript(0) + " puddle in the bouncing cleavage and turn your chest into a slip-n'-slide for dicks.");
					}
				}
				outputText("\n\n");
			}
		}
		//(Herms ahoy!)
		if(player.gender == 3) {
			//(no balls)
			if(player.balls == 0) {
				outputText("The ");
				if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_WET) outputText("puffy");
				else if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_DROOLING) outputText("glistening");
				else outputText("dripping");
				outputText(" skin of your outer lips is engorged and ready, but there's no pleasure to be had for your greedy gash.  Cool night air washes over the exposed ");
				if(player.hasScales()) outputText("scales");
				else outputText("skin");
				outputText(" surrounding your sex, teasing you with the barest hint of sensation while your ignorant hands maul your [cock] at Exgartuan's behest.  If only you had taken care of yourself earlier, you might have had the control to slip a digit into your " + vaginaDescript(0));
				if(player.clitLength > 3) outputText(" or stroke your " + clitDescript());
				outputText(" to fully satisfy ALL of yourself.");
				outputText("\n\n");
			}
			//(Herms + Balls)
			else {
				outputText("The ");
				if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_WET) outputText("puffy");
				else if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_DROOLING) outputText("glistening");
				else outputText("dripping");
				outputText(" skin of your outer lips is engorged and ready, but with your hands so focused on your [cock], there's little for your " + vaginaDescript(0) + " to feel.  The closest it gets to pleasure is the sensation of your " + sackDescript() + " slapping against it with the steady rhythm of your masturbation.  If only you had taken care of yourself earlier!  You might have had enough control over your rebellious tool to let a hand attend to your OTHER needs.\n\n");
			}
		}
		outputText("Spit foams around the tumescent intruder's girth, bubbling from the uncontrollable pistoning of Exgartuan's wrath at your [face].  The taut, bulging flesh of your own member is rammed so deeply into your own throat that you can feel the pre dripping into your stomach, but you want more.  ");
		if(player.cor < 33) outputText("The desire shocks you with the sheer... wrongness of it, but you cannot deny the pleasure of drilling your own slobbering mouth.");
		else if(player.cor < 66) outputText("The desire sinks its hooks into the lust-addled flesh of your brain and drags you deeper into lust.  You can't deny the pleasure of drilling your own slobbering mouth.");
		else outputText("The desire rushes through your blood as you imagine how you must look, sprawled out, eyes rolled back, and cock drilling at your own slobbering mouth.");
		outputText("  Liquid-hot pressure slides over the underside of your [cock], licking wetly at the pulsating, need-filled demon-prick.  Your rogue tongue's attentions have the desired effect, and the cries of your pleasure are muffled by your own thick flesh and its rapidly distending urethra.\n\n");
		
		outputText("If someone were watching");
		if(monk >= 5 && !player.hasStatusEffect(StatusEffects.NoJojo) && flags[kFLAGS.JOJO_DEAD_OR_GONE] == 0) outputText(", and judging by Jojo's high pitched whines, he certainly is,");
		outputText(" they'd see dick-flesh bulging with a heavy load as it's pumped into your lips.  The fully-inflated cum-tube distends your mouth, stretching your jaw painfully, and dumps its creamy cargo into its willing receptacle.  Your belly burbles as it adjusts to the ");
		var cumQ:Number = player.cumQ();
		if(cumQ < 50) outputText("surprisingly light");
		else if(cumQ < 150) outputText("sticky");
		else if(cumQ < 300) outputText("large, thick");
		else if(cumQ < 800) outputText("long, thick blast of your");
		else outputText("immensely voluminous");
		outputText(" deposit.  Quiet, barely audible squishes hang in the air around you as your gut is ");
		if(cumQ < 500) outputText("pumped into");
		else outputText("pumped full");
		outputText(" with obscene, liquid sloshing.  Your " + hipDescript() + " and " + assDescript() + " rise off the ground with your back as your muscles lock");
		if(player.balls > 0) outputText(" and your [balls] pull tight against your groin from the effort");
		outputText(".");
		cumQ = player.cumQ();
		if(cumQ > 500) {
			outputText("  A gradual curve quickly rises on your belly");
			if(cumQ > 1500) outputText(", but it doesn't stop there.  It keeps growing until you look full and pregnant.");
			else outputText(".");
			if(cumQ > 2500) outputText("  Back-pressure blasts your [cock] free from your imprisoning oral cavity along with a fountain of seed while you weakly try to cough out enough spooge to breathe.");
		}
		outputText("\n\n");
		
		if(monk >= 5 && !player.hasStatusEffect(StatusEffects.NoJojo) && flags[kFLAGS.JOJO_DEAD_OR_GONE] == 0) {
			outputText("The splatter of mouse-cum erupting in the wood reaches your ears, bringing a wistful smile to your face.  That slutty mouse is such a peeping tom!  ");
		}
		outputText("Your eyes slowly roll back down while Exgartuan deflates, leaving a trail of pleased, white submission ");
		if(player.biggestTitSize() < 1) outputText("over your chest");
		else outputText("between your tits");
		outputText(" and across your belly as he retreats.  The thrill of orgasm is still fresh in your mind, but exhaustion quickly replaces it.  You resolve to clean up the mess in the morning as your eyelids flutter closed.  The smell of sex hangs off your dozing form like a cloud, keeping your dreams from straying too far from your cock...");
		//[-100 lust, then +10 lust immediately, +1 libido to 60, then +.5 libido to 80, then +.25 libido.  +1 sensitivity.  +1 corruption]
		player.orgasm();
		dynStats("sen", 1, "cor", 1);
		if(player.lib < 60) dynStats("lib", 1);
		else if(player.lib < 80) dynStats("lib", .5);
		else dynStats("lib", .25);
		dynStats("lus", 10);
		flags[kFLAGS.TIMES_AUTOFELLATIOED_EXGARTUAN]++;
		player.slimeFeed();
	}
	player.changeStatusValue(StatusEffects.Exgartuan,2,25);
	doNext(playerMenu);
}
private function exgartuanBulgeTortureII():void {
	clearOutput();
	outputText("After what feels like only a few minutes, you begin to feel as if you were sizzling beneath your sheets.  After a few half-hearted tosses and turns, inhibited by your bulging lower half, you surrender and throw off your covers.  At this point, you are almost wide awake, too focused on your increased breathing and uncomfortable temperature.  A few more moments slip by before you realize what's going on, alerted by your involuntary reach for your cock to find any sort of relief: you're getting horny.  As to how it's happening, you aren't entirely clear yet.  But it certainly isn't new to you nor is it strange for this to be happening in a place as strange as Mareth.  For all you know, this could be some natural occurrence brought in by the weather or a nearby tree or something.  Like pollen... except you want to have sex instead of suffer from congestion.\n\n");
	
	outputText("You again reach for ");
	if(player.armorName != "crotch-hugging slutty swimwear" && player.armorName != "crotch-hugging revealing chainmail bikini")
		outputText("your last remaining piece of " + player.armorName);
	//[else]
	else outputText("your " + player.armorName);
	outputText(" to find it still firmly attached to your midsection.  What's more, as you begin to feel around it, you find to your surprise that ");
	//[if armorname IS EQUAL TO \"<i>crotch-hugging full platemail</i>\" OR \"<i>crotch-hugging scale-mail armor</i>\"]
	if(player.armorName == "crotch-hugging full platemail" || player.armorName == "crotch-hugging scale-mail armor") outputText("your [armor] feels as if it's become incredibly stiff, refusing to neither budge your package or impart any sense of feeling or vibration to what lies underneath.");
	//[if armorname IS EQUAL TO \"<i>crotch-hugging practically indecent steel armor</i>\" OR \"<i>crotch-hugging full-body chainmail</i>\" OR \"<i>crotch-hugging revealing chainmail bikini</i>\"]
	if(player.armorName == "crotch-hugging practically indecent steel armor" || player.armorName == "crotch-hugging full-body chainmail" || player.armorName == "crotch-hugging revealing chainmail bikini") outputText("your [armor] feels as if it's become incredibly dense, refusing to neither budge your package or impart any sense of feeling or vibration to what lies underneath.  What's worse, the links that make up your armor have narrowed and sealed shut.");
	else outputText("your [armor] feels as if it were made from 6</i>\" thick steel, refusing to neither budge your package or impart any sense of feeling or vibration to what lies underneath.  You continue to run your hands across it, having trouble believing that the material has become so incredibly dense and rigid despite its appearance.");
	outputText("  A little more pushing, pulling, knocking, groping, and stroking confirms what you feared: your [cock] has been cordoned off from you");
	if(player.balls > 0 || player.hasVagina()) outputText(" along with anything else unlucky enough to reside within");
	outputText(".\n\n");
	
	outputText("Damnable demon.  He doesn't even have the decency to taunt you- or even acknowledge your presence.  You bang your fists against your blighted dick, still unable to register any contact through the tightly-fitted obstruction (and secretly relieved you didn't injure yourself.)  You flop back down onto your back, determined to find some other way to satiate your lust.  Invigorated with their new mission, your hands begin to scour the remaining surface of your body, willing fingertips gently brushing your skin in search of a target.");
	//[if one row of breasts]
	if(player.biggestTitSize() >= 2 && player.bRows() == 1) outputText("  Your quest begins squarely on your pair of " + chestDesc() + ", your mitts feverishly groping and tugging away in the hope of finding any sanctuary from your encroaching lust.  Unable to extract any meaningful solace from your magnificent mounds, your sights set on your " + nippleDescript(0) + "s.");
	//[if ≥2 rows of breasts]
	else if(player.biggestTitSize() >= 2) outputText("  The [allbreasts] lined down your chest should serve a proper conquest.  Your palms set off to work at once, manhandling as much titflesh as they can satisfy at once.  They dart from one row to the next, inside to out, anything to relieve your libido.  You don't appear to be settling down any, however, so you draw your focus on your top row of " + nippleDescript(0) + "s.");
	else outputText("  With little else to turn to, your " + nippleDescript(0) + "s are your only guiding light to hopefully bringing you the peace you crave.");
	//[if nipplecunts]
	if(player.hasFuckableNipples()) outputText("  You waste little time in pushing four fingers into each gaping teat, anxious for any sort of pleasure.  You tickle and tease, push and pull, anything you can think to release you from this torment.");
	else outputText("  A little tapping, tickling, and teasing is about all the effort you can seem to muster.");
	outputText("  Too preoccupied with whatever's going on down below, you can't seem to focus enough to get the job done right.  Your peer down your body at your [cock], still flaccid and on lockdown.  The most you can respond is with another deep sigh, retreating your attention to the canvas up above you.  You figure the best course of action from here is to just try and make it until morning when you can find some help.  Confessing shame to some third party seems a much better alternative to going any more rounds with this nonsense.  Your fists clench and you take some deep breaths, prepared to ride out the remainder of the night with your sanity intact.\n\n");
	
	//[new page. lust raises to 100]
	dynStats("lus=", player.maxLust());
	doNext(exgartuanBulgeTortureIII);
}
private function exgartuanBulgeTortureIII():void {
	clearOutput();
	outputText("Fueled by pure spite and just a hint of loathing, you begin to regain some sort of composure through controlled breathing and what little concentration you can manage.  A few minutes of counting stitches in the top of your " + camp.homeDesc() + " is all you accomplish, however; your once dormant limp [cock] is showing a sign of life. Your eyes widen as you feel your possessed pole stiffen up, pressing hard against your [armor] as it grows out along with your dick, still impossibly clinging to its every facet.  It stops after only gaining a few inches, but not before driving the fight right back out of you.  Thread-counting is the last thing in your head as you quickly sit right back up, instinctually grasping for your cock.  But the situation refuses to change; your [armor] is just as exceedingly resilient as it was before.\n\n");
	
	outputText("Your desire only increasing, you begin desperately clawing at the edges of your [armor].  Your stuck skin only grows red from your efforts, eschewing even the notion that it might break free.  Your breathing begins to draw to a panicked pace as you stop and try to form some coherent thought.  The best your lust-addled brain can come up with is to try moving your " + hipDescript() + ", and see if you can make any contact with your imprisoned penis.  Grinding, thrusting... anything you can think of to just make the slightest bit of contact.  However, your only accomplishment is in putting your [legs] to sleep.  A tingling sensation works it way down your lower half, followed by numbness.  But before you can start adding that to your frustrations, a glint of something catches your eye- a single bead of pre-cum resting on the tip of your slightly hard [cock], around an inch in diameter if you had to guess.");
	//[if armorname IS EQUAL TO \"<i>crotch-hugging full platemail</i>\" OR \"<i>crotch-hugging scale-mail armor</i>\"]
	if(player.armorName == "crotch-hugging full platemail" || player.armorName == "crotch-hugging scale-mail") outputText("  As you stare in bewilderment, you can't even begin to fathom how it possibly seeped through the steel of your solid " + player.armorName);
	//[if armorname IS EQUAL TO \"<i>crotch-hugging practically indecent steel armor</i>\" OR \"<i>crotch-hugging full-body chainmail</i>\" OR \"<i>crotch-hugging revealing chainmail bikini</i>\"]
	else if(player.armorName == "crotch-hugging practically indecent steel armor" || player.armorName == "crotch-hugging full-body chainmail" || player.armorName == "crotch-hugging revealing chainmail bikini") outputText("  Your fixation on the drop draws to question just how it managed its way through the sealed chains of your " + player.armorName);
	else outputText("  A strange feeling of betrayal casts over as you begin to question how the liquid worked its way through the material when none of your struggles have registered even the slightest sensation.");
	outputText("  You run your thumb and forefinger through it, skeptical of your eyes' discovery.  All it takes is that familiar touch followed by that telltale aroma to further break down what last defenses your brain was mounting against your all-consuming avidity.\n\n");
	
	outputText("Eyes re-widened, teeth clenched, you grasp for where the glans of your [cock] would be, letting out an anguished groan.  You slam your vision shut in frustration, whirling your body around to begin slamming the unflinching codpiece repeatedly into your " + camp.bedDesc() + ".  Over and over again, the concrete mass just refuses to budge.  Shaking adds on to your list of symptoms brought on by your maddening lust.  Your arms and legs simply unable to maintain your inconsequential thrusting, your body goes limp leaving your midsection held awkwardly in the air by the bane of your existence.  At this point, your breathing has reached a fevered rate while your entire body is moist from sweat.  Running out of options your disoriented wits can work out, your frenzied gaze darts out at the opening of your " + camp.homeDesc() + " that you neglected to shut earlier.  Desperate to find anything you can use, you begin dragging yourself out of the " + camp.homeDesc() + " towards the smoldering embers that remain of your campfire, your solid [armor] grinding uselessly away beneath you.  It becomes harder to make out where you're going as your vision begins to cloud and shake, your nervous trembling having made its way to your eyes.  It seems to require every fiber of your being with each pull and tug you make, your [legs] growing more ineffective as they become more numb and slick.\n\n");
	
	outputText("You find the first bit of relief all night when you take your first swing outside.  The crisp night air is cool compared to inside your " + camp.homeDesc() + ".  But the comfort is quickly forgotten as you stop to try and calm your nerves, the shaking and breathing making your struggle all the more difficult.  You unfortunately fail to accomplish little more than further aggravation, so you continue your desperate trek in search of something... anything... that you can use.  Unable to see straight or anything more than blurs at this point, you accidentally throw a hand into the remains of your campfire, snuffing out what little light it had to offer, leaving only the faint blue glean of the portal to intermingle with the blood-red glow of the moon overhead.  You recoil your hand in agony, a long, pained, frustrated moan escaping through your gnashing teeth.  Tears welling in your eyes, you can only make out pale blue and red blobs all around you. You muster the last of your strength to push yourself onto your back, your body too uncomfortable to continue pressing down on your confined cock.\n\n");
	
	outputText("Your frantic breathing seems to be competing with your pounding heartbeat, acting as if it were emanating from within your skull.  Your hands cling to the dirt and scant pieces of grass below you, unable to stop shaking or heed any of your commands.  Your already obscured vision begins to darken, more and more of the vague blobs fading into darkness.  Your [legs] continue their numb strike against you while helping your [feet] dig helplessly into the ground.  ...You've run out of ideas, left with an insatiable hunger for sex, a body that refuses to do little more than convulse, and a mound of misfortune where your crotch resides.\n\n");
	
	outputText("However, just before you can give up the ghost, the aforementioned mound begins stirring yet again.  A belabored moan is all you can muster, begging for this torment to cease.  Suddenly, the chill air makes contact below your waistline.  You try to raise your head to make sure you haven't gone even more insane, your tense muscles able to lift it enough to see that your [armor] has started to split down the middle.  You dig your hands deeper into the ground in an attempt to make sure you haven't started hallucinating, too.  But as the cool air hits your newly exposed skin, any lingering doubts begin to fade away, replaced by mounting awe.  As your outfit continues to crack open, a heady musk hits you like a ton of bricks, furthering your deranged desire.  The rupture continues straight down the middle of your garb, uncovering the base of your cock to the elements and filling it with a newfound life as it begins to pulsate.  Your [cock] resembles a butterfly emerging from a cocoon, complete with a layer of pre coating its every facet.  Rational thought struggles to reside in your paralyzed state, awestruck as your rod breaks free from its cell and reaches for the sky.  Liquid strands cling helplessly or fall back down to earth as it swells to full size- maybe even a little bigger.");
	//[if cocks ==2]
	if(player.cockTotal() == 2) outputText("  Your " + cockDescript(1) + " remains flaccid beside this bronze adonis, as if sapped of all its life.");
	//[if cocks ≥3]
	else if(player.cockTotal() > 2) outputText("  Your extra cocks remain flaccid beside this bronze adonis, as if sapped of all their life.");
	outputText("  Through the blurry, trembling mess that is your vision, you can make out the mighty titan, its figure silhouetted against the blood-red moon behind it.  After what feels like forever, your majestic manhood slowly descends from its great heights towards you, pulsating in time with your frenzied heartbeat.  As if it were a god descending from heaven to bless a mortal, the [cock] stops right above your gaze, its urethra slowly widening, continuing to spill pre-cum all over your plagued form.\n\n");

	outputText("A lifetime seems to have passed by in that dead stare.  You manage to catch your breath, your shuddering body calming as it prepares for salvation.");
	//[if first occurrence of scene]
	if(flags[kFLAGS.EXGARTUAN_TIGHTPANTS_MASTURBATE_COUNT] == 0) outputText("  No words are exchanged; no thoughts dare to cross your mind. The only sound is that of your heart, its rhythm acting as prelude for the action you desperately covet.  Mixed emotions of guilt, fright, awe, and satisfaction claw at you.");
	//[if occurrence ≥2]
	else if(flags[kFLAGS.EXGARTUAN_TIGHTPANTS_MASTURBATE_COUNT] < 6) outputText("  \"<i>Your will cannot even begin to compare to my might, my helpless little champion. You really shouldn't continue acting as if you're above temptation; I'd hate to see what would happen.</i>\"");
	//[if occurrence ≥6]
	else if(flags[kFLAGS.EXGARTUAN_TIGHTPANTS_MASTURBATE_COUNT] >= 6 && flags[kFLAGS.EXGARTUAN_TIGHTPANTS_MASTURBATE_COUNT] < 10) outputText("  \"<i>You know, I never thought I would enjoy even the mere thought of celibacy-not even for a moment.  But watching such an <b>honest</b> champion break down to a quivering pile of helplessness is worth it when the attention I receive afterward is so... thorough.</i>\"");
	//[if occurrence ≥10]
	else if(flags[kFLAGS.EXGARTUAN_TIGHTPANTS_MASTURBATE_COUNT] >= 10 && flags[kFLAGS.EXGARTUAN_TIGHTPANTS_MASTURBATE_COUNT] < 12)outputText("\"<i>I can keep this up much longer than you can, [armor].  As much as I enjoy watching you struggle to maintain some form of morality and moderation, I would much rather be exploring the world and its many orifices.  Some day you'll leave that fantasy realm you keep running to and join me in the real world.</i>\"");
	//[if occurrence ≥12]
	else outputText("\"<i>Oh, it's that time again, I see.  Sorry, I was still thinking about how much I enjoyed myself the <b>last</b> occasion you tried to forget about me!  Well, let's not waste any more time; you know the routine.</i>\"");
	outputText("\n\n");
	outputText("Exgartuan.\n\n");
	
	outputText("The self-proclaimed \"<i>Devil of Dickings</i>\" is finally through teasing you.  Before you can begin to think about how to respond- as if you could- something triggers in your mind.  Like a sprinter at the sound of the starting pistol, you leap forward onto him, your arms excitedly grasping all over the [cock].  They work their way around each of his nodules and nubs that they can find, yearning to satisfy the demon by any means necessary.  Not to be outdone, your tongue furiously traverses his sensitive skin, making its way to his glans.");
	//[if breasts present]
	if(player.biggestTitSize() > 1) outputText("  Your " + chestDesc() + " work just as hard, smothering Exgartuan in all of their jiggly glory.");
	outputText("  From base to tip, you leave no skin, vein, bump, or glan untraced; all the while covering yourself in the devil's endless demonic drizzle.  Unearthly pleasure responds to your every effort, preparing you to move on to the climax.  You lighten your full embrace, firmly grasping the [cock] with both hands, and commence working his entire shaft.  You try to maintain some semblance of pace, but in your dazed, wanton state you quickly ratchet up your speed.");
	//[if scrotum present]
	if(player.balls > 0) outputText("  Your [balls] churn with mighty force, roiling in anticipation.");
	outputText("\n\n");

	outputText("Your breath ceases as your ");
	//[if cumQ()<50]
	if(player.cumQ() < 50) outputText("modest");
	//[if cumQ()<150]
	else if(player.cumQ() < 150) outputText("sizably sticky");
	//[if cumQ()<300]
	else if(player.cumQ() < 300) outputText("mighty thick");
	//[if cumQ()<800]
	else if(player.cumQ() < 800) outputText("immensely voluminous");
	//[else]
	else outputText("monumental");
	outputText(" load works its way up the demon.  However, moments before your eruption, Exgartuan pulls free from your clutches, spreading his urethra wide as he again faces you.  Before you can even put on a puzzled expression, ");
	//[cumQ()<500]
	if(player.cumQ() < 500) outputText("a blast of thick demonic jizz");
	//[else]
	else outputText("a colossal wave of heavy demonic jizz");
	outputText(" hits you square in the face.  The surprising force of the blow sends you reeling, your hands clearing from the mighty demon as he points skyward, showering everything around you in black, warm ejaculate.  You care little, however, being too busy convulsing and indulging on every ounce of pleasure radiating through it.  It doesn't take long for you to black out, drawing an end to your excruciating experience.\n\n");
	//[new page. lust resets to 0. corruption raises by 2. player gains ailment \"<i>Jizzpants</i>\"]
	player.orgasm();
	player.createStatusEffect(StatusEffects.Jizzpants, 1, 0, 0, 0);
	dynStats("cor", 2);
	doNext(exgartuanBulgeTortureIV);
}

private function exgartuanBulgeTortureIV():void {
	clearOutput();
	outputText("You wake the next morning, nestled inside your " + camp.bedDesc() + ".  Realizing where you are, a relaxing feeling of easiness washes over you.  You throw off your cover to greet the day, only becoming confused as it peels off your sticky skin.  You glance down at your waist, still wearing ");
	//[if armorname IS NOT EQUAL TO \"<i>crotch-hugging slutty swimwear</i>\" OR \"<i>crotch-hugging revealing chainmail bikini</i>\"]
	if(player.armorName != "crotch-hugging slutty swimwear" && player.armorName != "crotch-hugging revealing chainmail bikini")
		outputText("your " + player.armorName);
	else
		outputText("the single piece of your " + player.armorName);
	outputText(".  As you rise to your feet, a few streams of cum run down your [legs].");
	//[If any followers]
	if(camp.hasCompanions()) outputText("  For a moment, you consider asking someone outside if they remember anything from last night.  But you decide it's better to just keep it to yourself, afraid of what you might find out.");
	//[else]
	else outputText("  You glance around at your " + camp.homeDesc() + ", searching for anything that may clue you in on what transpired last night.  After a few moments, however, you decide it better to just move on with your day.");
	outputText("  You pay one more glance to Exgartuan, the [cock] comfortably resting away in your outfit.\n\n");
	outputText("Damn demons.");
	player.changeStatusValue(StatusEffects.Exgartuan,2,25);
	doNext(playerMenu);
}

//Exgartuan in breasts
//≥48 hours since Boobgartuan masturbation scene. 
//Random chance for occurrence once requirement met.
//Player going to sleep, duh
//3:00AM

private function boobGartuanSURPRISE():void {
	spriteSelect(15);
	//[if occurrence ==0]
	if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] == 0) {
		outputText("The sound of little snickering voices wakes you from your slumber.  A couple of imps are chattering to one another, one of which has his hand under his loincloth, making a night of it.  You think to move, but find both of your arms sprawled and padlocked to the wall behind you, your naked body dangling helplessly against it.  A quick glimpse around reveals your cobblestone dwelling: a small dank, dimly lit room with no windows and a few knick knacks and perverted toys spread haphazardly against the walls.  Offset towards the middle of the room lies an ordinary wooden table, some gold coins, jugs, and a leather pouch of some sort sit atop it.  Before you can get a good look at it, one of the imps snaps to attention, hitting the... preoccupied one in the chest, \"<i>Look alive, idiot!  The " + player.mf("chump","skank") + "'s wakin' up.  Git' the boss!</i>\" The second imp's hand flies free from his crotch, scattering some semen to the air.  He responds with a slack-jawed nod, proceeding to bang twice on the large wooden door beside him.  After a moment's pause, you can make out the sound of wood hitting stone mixed with bare footsteps.\n\n");
		outputText("The door barges open, a four foot tall imp standing in its place.  He's holding a large cane in the air, presumably what he used to throw the door open.  His other hand is behind his back, hiding something from your view.  The miniature monster is a little more chiseled than his foppish brethren, sporting a large eye patch covering the left side of his face and what looks like a short pair of tiger skin overalls instead of the standard loincloth.  Evidently, the imp must think very highly of himself.\n\n");
		
		outputText("\"<i>[name]!</i>\" he shouts snidely, a sneer working its way across his face, \"<i>How long has it been?</i>\"\n\n");
		outputText("\"<i>");
		if(player.cor < 33) outputText("Not long enough, Nemus, I'm afraid!");
		else if(player.cor < 66) outputText("Too long, honestly.  You've grown slow over the years, Nemus,");
		else outputText("I was worried you'd forgotten about me, Nemus.  You never write,");
		outputText("</i>\" you reply, throwing back his sarcastic expression.\n\n");
		
		outputText("The imp snickers to himself, beginning to draw in closer towards you.  There's a bit of a limp to his step, granting an explanation to the cane.  Along the way, the imp extends his walking stick beneath the table, hooking it on a little stepstool and dragging it out in front of you.  Even with the leverage, his eyes only meet your lower lip.  \"<i>Three long years, [name].  Three years... to take back what's rightfully mine.</i>\"\n\n");
		
		outputText("Nemus slowly peers towards the table, staring at the leather pouch.  You catch a glint off of its special contents.  \"<i>I never would have guessed that you'd have delivered the idol straight to me after all this time!</i>\" The grin widens on the imp's face as he begins to pull his concealed hand from behind his back, \"<i>It'll go wonderfully with my own.</i>\" He slowly unfurls his fingers, revealing the large golden idol: a stiff statue bearing a resemblance to that of Incan relics, only it of course sports a massive vertical erection.  A perfect duplicate of the one you previously owned.\n\n");

		outputText("\"<i>Finally, with both idols I can finally unlock Ecsepoan's tomb... and claim his ancient power.</i>\" Nemus clenches the idol in his palm, his snide expression growing more deranged, \"<i>This world will grovel at my feet, as it has always meant to be.</i>\"\n\n");
		
		outputText("Your face remains calm, a hint of superiority still swimming through it, \"<i>Will it really be that simple, Nemus? We both know there's more to that tomb than...</i>\"\n\n");
		
		outputText("Your warning turns to moaning as the imp's hands quickly latch onto your " + chestDesc() + ", discarding the walking stick and golden idol to the hard floor.  \"<i>I don't need any of your words of wisdom, [name],</i>\" Nemus teases, his eyes meeting yours while he continues to caress your breasts, \"<i>You are little more than my trophy now.  Hardly a position befitting of giving advice, wouldn't you agree?</i>\" You start to tilt your head back as his grubby mitts continue to grope your massive mammaries.  The fiend slowly moves in on you, his unkempt nails teasing your sensitive [skin].  You begin to feel the rough fabric of his overalls brushing up against you, brought on by his stiffening member.  Nemus continues to draw closer to you.\n\n");

		outputText("Suddenly, the pleasure vanishes from your face, your now determined gaze locked onto the little wretch.  Before he has a chance to respond, your forehead viciously slams into his own, knocking the lust right out of him as he staggers off of the stepstool and falls to the ground.  The spectating imps recoil in fear by your outburst, trembling even further once your unwavering leer redirects to them.  You plant your feet on the stepstool for leverage and clench your hands into fists.  With seemingly little effort you flex them forward, shattering your shackles.  The imps' eyes are as large as saucepans after witnessing your tremendous feat.  A thought works its way through the paralyzing fear into the second imp, causing him to slap some sense into his friend, \"<i>Sound th' alarm, idiot!</i>\"\n\n");
		
		outputText("The first imp nods, his eyes still stricken with fear.  As he dashes for the odd contraption in the corner of the cell, you lunge for a leather whip resting against the wall beside you.  His feeble arm stops short of what looks like a trumpet mouthpiece in the wall, caught by your weapon.  In the blink of an eye, you yank the imp up into the air towards you, drop the whip in order to orient your fist towards him, and fire it into his ugly mug.  For a split second, you can make out his head attempting to wrap itself around your hand as it distorts from the sheer force of the blow.  The imp sails backwards head over heels careening into his friend, knocking the two of them out.\n\n");
		
		outputText("Pleased with your work, you rub your knuckles a little before wandering over to the table and scooping up the leather pouch.  It fits as well as it always has once you sling it around your body.  You turn and approach Nemus, the little bastard trying to scowl at you in between lingering spasms and clenching his head.  \"<i>");
		if(player.cor < 33) outputText("I always wondered where you kept this.");
		else if(player.cor < 66) outputText("This is one delivery that you'll just have to return to sender, I'm afraid.");
		else outputText("You scheme about as well as you fuck, Nemus.");
		outputText("</i>\" you tease, bending down to scoop up the second idol and place it firmly in your leather pouch.  You quickly gesture goodbye to Nemus before bolting for the door.\n\n");
	}
	else {
		boobgartuanSurprise3();
		return;
	}
	//[new page]
	doNext(boobgartuanSurprise2);
}

private function boobgartuanSurprise2():void {
	spriteSelect(15);
	clearOutput();
	if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] == 0) {
		outputText("There's no time to be deciding on which cardinal direction to walk in once you exit the room; your efforts have garnered some unwanted attention.  The sound of blaring horns can be heard overhead, far off imp squeaks and squabbles slowly growing louder.  You haul ass in the opposite direction to the east and pull yourself down the next corner on your left, following what sounds like a rough thunderstorm outside.  Your effortless strides along the slick cobblestone ground come to a screeching halt soon after.  It would appear you've made it to a small dining hall, littered with debris and discarded weaponry.  Directly across the room from you lies the door to the courtyard, your last stop on the train to freedom.  But there's an imp in the way.\n\n");
		
		outputText("However, this is no ordinary imp; if it was, you would have already pummeled the shit out of it.  Blocking the egress stands Teensy, an obviously ironic nickname for the seven foot tall, incredibly muscular, armor-plated behemoth.  Sporting armored padding along his extremities and head, this freak rocks an enormous ironclad chin, the resulting underbite dwarfing his otherwise miniscule head and beady eyes.  Other than the aforementioned armor running along his arms, knees and head, the brute is completely naked, his gigantic ballsack swaying in the breeze.  The lout is poised in the frame, legs bent and arms spread like a defensive lineman, denying you precious freedom.\n\n");
		
		outputText("\"<i>");
		if(player.cor < 33) outputText("Hey, Teensy, remember me?</i>\"");
		//[if corruption ≥30 & <70]
		else if(player.cor < 66) outputText("I see you haven't gotten any prettier since last time we met, Teensy.</i>\"");
		//[if corruption ≥70]
		else outputText("Timed to get fucked, stud,</i>\"");
		outputText(" you jest.  The mongrel merely snarls at you and tenses up, your attempt at coy negotiations deflecting off of his dull cranium.  The commotion behind you begins to grow louder; there isn't much more time until the cavalry arrives.  You begin quickly scanning the room, searching for anything you can use against the lummox.  Up above him, you spy several sizable barrels.  They appear ancient and low maintenance, judging by the rickety-looking wood and leaking liquid.\n\n");
		
		outputText("The imps round the bend behind you, leaving little more time to formulate your plan.  You scoop up a haggard looking broadsword sitting against the wall, grasping it by its guard with both hands.  You begin spinning in place like a rookie discus thrower, the sword orbiting around you with its dull blade facing out.  With the firm planting of your [leg] you release your grasp on the sword and send it soaring, your " + chestDesc() + " very nearly throwing you off your balance as they continue their circular trajectory.\n\n");
		
		outputText("The monster imp raises his arm-guards to project his maw, bracing for a blow that never comes.  Instead, the massive sword plows into the barrel overhead, drenching the goon and surrounding area in red wine.  You're left with no time to celebrate, though, as the encroaching imps have made it to your position.  You dash towards Teensy as the buffoon stumbles around in place, going into a dive feet-first and sailing right underneath him thanks to the wine-slicked floor.  ");
		//[if corruption <30]
		if(player.cor < 33) outputText("Your " + chestDesc() + " brush against the imp's enormous scrotum, causing him to eventually tumble over from the sensation, blocking the impeding entourage of imps behind you.");
		//[if corruption ≥30 & <70]
		else if(player.cor < 66) outputText("As you coast under the beast, you take the opportunity to slap around his crown jewels, playing them as if they were a novelty pair of bongos.  The sensation causes him to tumble over, blocking the impeding entourage of imps behind you.");
		else outputText("A devilish smile cracks across your face as you coast under the lummox, delivering a quick peck of a kiss on his hanging ballsack.  The sensation causes him to tumble over in confusion, blocking the impeding entourage of imps behind you.");
		outputText("\n\n");
		
		outputText("A crack of lightning greets your arrival as you step out into the ferocious thunderstorm, rain soaking your naked form.  A football field's length of muddy courtyard sits between you and the outer wall of the imp fortress.  Just as you're about to get going again, the sound of a door banging open on the roof behind you meets your ear.  \"<i>Get your shit, together, you blithering idiots!</i>\"\n\n");
		
		outputText("Nemus is up there barking orders and waving his cane around, his free hand still clutching his wound.  \"<i>I want this " + player.mf("asshole","slut") + " DEAD! DO WHATEVER IT TAKES!</i>\" The burning rage in his eyes sets his comrades into motion.  They leap for the cannons, preparing a final desperate assault against you.  You take this bout of organization as your cue to skedaddle, resuming your bountiful stride towards the exit.  Luckily, the little imps are about as good with their aim as they are at keeping you restrained, the downpour doing little to aid in their quest.  Projectiles destroy everything around you, splinters, dirt, and mud scattering every which way.  You deftly dodge from side to side, easily outmaneuvering everything heading your way.\n\n");
		
		outputText("A couple of imps stationed at the gate throw a wrench into your works, however.  With some triumphant howling, one of them up above manages to kick over a nearby lever, causing the massive entryway to begin slamming shut.  Even at your amazing clip, there's no way you'd make it in time.  You instead focus your sights on a charging imp ahead of you, brandishing a large hammer.  As you close in on him, you begin formulating your next strategy of superhuman might.  But before you even get to step two, a cannonball whizzes by your head and collides with his weapon, ricocheting off of it and into a support beam for what looks like a small stable.  The little roof tumbles forward, providing a slanted route to freedom.  You can't help but smirk at your fortune, tackling over the confused imp ahead of you in your mad dash.\n\n");

		outputText("A jump, a climb, and a showy flip later and you've arrived atop the imps' last line of defense, one more leap away from escape.  You turn back one last time and ");
		//[if corruption <30]
		if(player.cor < 33) outputText("wave goodbye to Nemus");
		//[if corruption ≥30 & <70]
		else if(player.cor < 66) outputText("blow a kiss to Nemus");
		//[if corruption ≥70]
		else outputText("flip Nemus a mighty bird");
		outputText(", making out his silhouette in the distance through the storm, hopping around angrily.  With your work done, you bound off of the wall, set to clear the tiny moat that circles around the fort.  Time seems to slow as you soar in the air away from the imp fortress.\n\n");
		
		outputText("You feel a sudden heft in your chest.  You peer down to see that your " + chestDesc() + " appear to be swelling rapidly!  What's much worse, however, is that their [skin] is turning to rough stone before your eyes!  Fear sets in quickly as your majestic leap quickly loses its momentum.  You desperately reach out for land, but it seems as those the closest handhold is only getting farther and farther away from you.  It becomes difficult to keep grasping out towards the ledge as your chest-mounted stone weights drag you down into the murky water below.  All you can make out below you is unending darkness, the faint glimmer from strikes of lightning above only becoming more distant as you sink deeper into the abyss.  Your outstretched hand is the last thing you see before you are completely enveloped in darkness.  Your bountiful bosoms, easily thrice the size of you by this point, continue their tugging at your chest, feeling as though they are dragging the life out of in the process.\n\n");
		
		outputText("For a moment, you can swear you felt them rumbling... taunting you...");
		//[end of occurrence ==0]
	}
	doNext(boobgartuanSurprise3);
}
//[new page.  occurrence ≥1 starts here]
private function boobgartuanSurprise3():void {
	clearOutput();
	//[if occurrence ==0]
	if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] == 0) {
		outputText("The moon greets your wide-eyed gaze, bathing you in its dim crimson glow.  Seeing as you don't appear to have drowned, it looks as though you just had a dream... or perhaps a nightmare.  Judging by the stupid things you said, you decide to go with nightmare.  You don't even know a \"<i>Nemus</i>\"... you think.  Anyway, y");
	}
	//[else]
	else {
		outputText("A light tickle on your chin pulls you from your shut-eye, the familiar blood-red moon greeting your groggy gaze.  Y");
	}
	outputText("ou've woken up outdoors it seems, though it's hard to make out where exactly you are as it's pitch black and your vision has only just started to adjust to the darkness.  You aren't exactly surprised to find that you're completely naked, however; it feels as if this is your natural state of dress these days.  Unsure as to your whereabouts or safety, you deem it wise to wait and let your pale red surroundings come into some sort of focus before venturing forth.\n\n");
	
	outputText("A few tense minutes later, you realize just where you are: a small clearing north of camp.  You get up off the ground and begin to peer around, spying what you believe to be the familiar glow of your campfire way off in the distance.  One more cursory glance at your surroundings is all it takes before you elect to head on back, anxious to get back to your bed.  However, as you take your first step, your body is thrust to the ground.  The right side of your head smacks into the soft earth below, hard enough to throw off your equilibrium.  You quickly try and regain your footing, pouring equal amounts of effort into listening to your surroundings as you are in trying to stay upright.  The world shortly ends its shift to one side, leaving your eyes and ears on full alert as they hunt for your aggressor.  You take a gentle step forward, your heightened guard trying to distinguish anything in the dark rustling wood around you.  You begin to ask aloud if anyone is there, but before a syllable can escape your mouth, you tumble down to the ground in the opposite direction.\n\n");
	
	outputText("Thankfully you were more prepared this time, your reflexes heightened enough to keep you from slamming your noggin yet again.  You also felt just where the shove originated from: your " + chestDesc() + ".  ");
	//[if occurrence ==0]
	if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] == 0) outputText("As you sit up and begin to piece the puzzle together, you're interrupted by a familiar voice, \"<i>You have time to fuck everyone in Mareth silly, but can't be bothered to spend an instant of it with these magnificent mounds?</i>\" You feel your " + chestDesc() + " jiggle as Exgartuan speaks, only to have them yank you forward, planting your face back in the ground.  \"<i>I'll just have to make sure you'll never forget again.</i>\"");
	//[if occurrence ≥1]
	else if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] < 4) {
		outputText("It's Exgartuan again; you haven't fondled her in a while.  \"<i>Rarin' for another round, eh, champion?</i>\" your " + chestDesc() + " ask you, jiggling furiously for emphasis, \"<i>I had hoped the previous lesson");
		//[if occurrence ≥2]
		if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] >= 2) outputText("s");
		outputText(" would have sunk in, but I guess you need to retake the course.</i>\" Before you can formulate a response, your massive mammaries force your face to the ground yet again.  \"<i>The school of hard knocks is in session.</i>\"");
	}
	//if occurrence ≥4
	else if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] < 8) outputText("</i>\"ARE YOU DENSE, CHAMPION?</i>\" Exgartuan shouts, your mammoth melons bouncing furiously on her every word, \"<i>I will knock you SENSELESS until I clear some space in that vapid cesspool between your ears!</i>\" You want to try and calm her down, but your " + chestDesc() + " promptly launch your face square into the dirt.  \"<i>Don't go on thinking for another SECOND that you can ignore ME!</i>\"");
	//[if occurrence ≥8]
	else outputText("Before another thought can cross your mind, your " + chestDesc() + " fly up and smack you in the gob! \"<i>[name], it's that time again,</i>\" the eager demoness teases you.  You think she's grown to enjoy the torture she puts you through.  \"<i>If you insist on going day in and day out without spending quality time with these tits, then I'll just insist on instructing you otherwise.</i>\" Your beautiful bosom launches forward, throwing your mug right back in the dirt.");
	outputText("  You lift your head enough to shake any clinging ground free, but stop shy of going any higher and giving the demoness another shot at tossing you around.  Grass becomes your anchor as your hands bind themselves to whatever they can.");
	if(player.cor < 50) outputText("  Exgartuan's tormenting has gone on long enough tonight.");
	else outputText("  You love foreplay just as much as any other creature, but this is getting ridiculous.");
	outputText("\n\n");
	
	//[if occurrence ==0]
	if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] == 0) outputText("\"<i>Don't think you can overpower me like those puny imps that infest your dreams, champion.</i>\"");
	//[if occurrence ≥1]
	else if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] < 4)outputText("\"<i>We haven't even started the curriculum yet, champion.</i>\"");
	//[occurrence ≥4]
	else if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] < 8)outputText("\"<i>HOW can you forget to caress these cans!?  Tease these teats!?</i>\"");
	//[if occurrence ≥8]
	else outputText("\"<i>Did you find anything to grab onto this time besides weeds? It doesn't look like you have.</i>\"");
	outputText("  You make out a slight warmth radiating through your chest, followed by your " + chestDesc() + " pulling you up into the air!  Your weak bonds to the earth either slip free or unroot, leaving you at the mercy of your possessed pillows.  Not long after you return to your feet does your chest remount its attack, flinging you with ease from side to side while Exgartuan laughs at you.  By the third time you tumble towards the terrain, you finally decide to lock your arms around your mutinous milk cans, your fingers clamping down as hard as they can into your [skin].  Your powerful puppies flow over your death grip, the pressure becoming pleasure, your struggle dissolving into confusion.  The demoness pushes and shakes against your hold as your footing keeps up to compensate.  It seems as though her desire to be fondled is stronger than her desire to fight, your turbulent tatas' harsh movements slowly becoming much more smooth and relaxed.\n\n");
	
	//[if occurrence ==0]
	if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] == 0) outputText("\"<i>Well, I suppose you've had enough, champion,</i>\" Exgartuan yields, building lust betraying her usual taunting behavior, \"<i>Now why don't we move on to what we both want, hm?</i>\"");
	//[if occurrence ≥1]
	else if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] < 4) outputText("\"<i>Ready for your final, eh, [name]?</i>\" Exgartuan teases, a faint lustful waver in her voice contrasting against her dominating demeanor, \"<i>Let's make this one to remember.</i>\"");
	//[if occurrence ≥4]
	else if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] < 8) outputText("\"<i>Do you think you'll remember now!</i>\" Exgartuan shouts exasperatedly, your breasts pushing against your grasp one final time, \"<i>Now stop wasting my time and get to the only thing you're halfway decent at.</i>\"");
	//[if occurrence ≥8]
	else outputText("\"<i>I suppose that ends tonight's opening act,</i>\" Exgartuan goads, her voice as domineering as ever, \"<i>I know you're dying to get on to the grand finale.</i>\"");
	outputText("  Your solid hold around your " + chestDesc() + " slowly loosens, your tits perking up as they prepare for their much craved attention.  ");
	//[if corruption <50]
	if(player.cor < 50) outputText("Though the mounting need to manhandle your mounds is slowly growing, you at least have the wherewithal to brush the mess of dirt and grass off your body before you begin.  You may be slowly succumbing to the evil corruption radiating from your dainty dumplings, but there's no reason you have to look the part, too.  A smooth rock at the edge of the clearing serves as your backrest once you relocate; you would like to at least try to keep from wallowing around in the earth any more tonight.  Even in the dark of the night, you can make out your " + chestDesc() + ", defying gravity as they anxiously await your touch, their perky pomp silently degrading your resolve.");
	//[else]
	else outputText("The thrashing now having ended, you gaze longingly at your majestic mountains.  You're able to at least hold off long enough from groping them to relocate to a smooth rock at the edge of the clearing; they're much easier to handle when you're upright after all.  You quickly brush off any dirt from them, having no regard for anything on the rest of your body.  All you care about right now is tending to your craving to cosset your cha-chas.");
	outputText("\n\n");

	outputText("As your hands rise to get to work, you feel your control over them slip away.  The demoness has rolled into the driver's seat as she tends to do.  ");
	//[if corruption <50]
	if(player.cor < 50) outputText("It is becoming increasingly clear to you that she evidently just cannot seem to sit idly by when you actually do decide to pay her heed.");
	//[else]
	else outputText("You're glad to sit back and bask in the expert manhandling that only she can deliver you.");
	outputText("  Your hands waste no time, caressing every square inch of your flesh.  They gently brush with the softest of grace; they squeeze with the exceptional skill of any expert masseur.  Any particularly sensitive spots get extra attention, eliciting soft moans from you as they only emanate more warmth throughout your body.  You feel as if you're melting into your supporting rock, the pleasure only mounting as your absent gaze goes skyward.");
	//[if cock or vagina present]
	if(player.gender > 0) {
		outputText("  Your " + hipDescript() + " begin grinding together, moist with ");
		//[if cock >0]
		if(player.hasCock() && !player.hasVagina()) outputText("pre-cum");
		//[if vagina >0]
		if(player.hasVagina() && !player.hasCock()) outputText("juice");
		//[if cock >0, vagina >0]
		if(player.hasCock() && player.hasVagina()) outputText("an aromatic cocktail of pre and juice");
		outputText(" as your tit massage begins to excite your nether regions.");
	}
	outputText("  The demoness continues her work, though never touching your nipples; the closest she draws your hands is around your areolas.  The circling is no less irritating as when you haven't neglected her, your back arching in need yet again.\n\n");
	
	outputText("Your gargantuan glands tremble as they begin to speak, \"<i>As always, you long for this just as I do.  It only begs the question as to how you could even think to ignore me.</i>\" You can feel your breasts plump up, seeming to be the demoness' not so subtle gesture of superiority, \"<i>Well, go ahead, champion.  Satiate your lust.</i>\"  Your hands hover over your " + nippleDescript(0) + "s as if waiting for you to take control.");
	//[if corruption <50]
	if(player.cor < 50) outputText("  At this point you are too far gone to resist.");
	//[else]
	else outputText("  You wiggle your fingers in anxious anticipation.");
	outputText("  You finally bear down and grasp onto... nothing?  <b>Your nipples are nowhere to be found!</b>  The passion is beginning to flatline as you confusedly grope around your " + chestDesc() + ".  \"<i>What's wrong, champion?</i>\" Exgartuan asks knowingly, \"<i>Is this too hard for you?</i>\" The tips of your fingers comb around your areolas until you discover an inward bend in your [skin] where your nipples should be.  Apparently, Exgartuan isn't through having fun with you; the blasted seductress managed to suck your teats inward!  Before you can fathom just how she pulled it off without your knowledge, your humble howitzers start to tingle.  You feel an anxious quiver work its way up your spine before a familiar need begins to course through your being: the need to be milked!");
	//[if corruption <50]
	if(player.cor < 50) outputText("  Brought on artificially or not, you cannot deny it; you would probably be cursing the wretched demoness if you were not already preoccupied contending with your mounting passion and desire.");
	outputText("  As you paw uselessly at the firm seal, you begin to feel moisture seeping out.");
	//[if not lactating]
	if(player.biggestLactation() < 1 || player.lactationQ() == 0) outputText("  <b>Your " + chestDesc() + " have started to lactate profusely.</b>");
	//[if lacationmultipler <4]
	else if(player.biggestLactation() < 4) outputText("  <b>Your breasts are only mounting up their lactation to new heights.</b>");
	if(player.biggestLactation() < 4) player.boostLactation(3);
	outputText("  But with your nipples in their inverted state, release is a hard sought dream, resulting in your tits slowly expanding as they fill with breastmilk.\n\n");
	
	outputText("Even with the aid of what little manages to seep out, Exgartuan's firm grip is too strong for even a single finger to slip through.  Your breathing begins to increase in pace as your hands resort to anxiously orbiting around the surface of your shaking spheres.  The light strokes elicit a deep sigh from you, but your fervor to nudge your nubs remains your priority.  The absentminded stroking quickly ceases, your hands smothering the former site of your nipples.  Your growing guavas jiggle as the demoness laughs at you, \"<i>");
	//[if occurrence ==0]
	if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] == 0) outputText("Perhaps instead of dreaming of being fucked by imps and raiding tombs, you'll remember to take care of these luscious love muffins.");
	//[if occurrence ≥1]
	else if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] < 4) outputText("I guess you're ready to graduate.  Just don't forget what you've learned here today.");
	//[if occurrence ≥4]
	else if(flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT] < 8) outputText("Never again forget that these tantalizing tits are the most important things in your life, champion.  Or I'll make sure that you remember again.");
	//[if occurrence ≥8]
	else outputText("Well, this has been fun, [name].  I look forward to beating you senseless and enjoying the wonderful makeup massage should you forget to see to my means yet again.");
	outputText("</i>\"\n\n");
	
	outputText("Your " + chestDesc() + " begin to rumble and quake, filling you with a mix of anxiety, dread, and passion.  One moment later, an enormous force bursts forth against your hands; your nipples have popped back out, soaking and ready to - wait a second...");
	//[if nipplesPerBreast >1]
	if(player.averageNipplesPerBreast() > 1) {
		outputText("  Where once you had multiple nipples, there now rests one on each breast");
		//[if nippleLength <4]
		if(player.nippleLength < 4) {
			outputText(", each swollen to at least four inches in length and around 3 inches in diameter!");
		}
		else outputText(".");
	}
	//[if nipplesPerBreast <1 AND nippleLength <4]
	else {
		if(player.nippleLength < 4) {
			outputText("  Your nipples have become much larger than before, each having swollen to at least four inches in length and around 3 inches in diameter!");
		}
		else outputText("  Your nipples are much thicker than you remember, increasing to at least 3 inches in diameter.");
	}
	outputText("  You pay the alterations little mind, though.  Your bewitched bosom has grown at least an entire cup size and is dribbling milk all over you");
	//[if cock or vagina present]
	if(player.gender > 0) {
		outputText(", mixing in with the ");
		//[if cock >0]
		if(player.gender == 1) outputText("pre");
		//[if vagina >0]
		else if(player.gender == 2) outputText("fem-spunk");
		else outputText("liquids");
		outputText(" already coating your " + hipDescript() + ".");
	}
	//else
	else outputText(".");
	outputText("  This champion wants to tug these melons dry.\n\n");
	
	outputText("Your hands go to work on your nips, a tug here, a stroke there, your fingers exploring the ins and outs of your titantic teats.  You punch in just a scant number of moments before your faucets reach their crescendo, your hands holding on for all their worth as milk sprays out everywhere, your " + chestDesc() + " writhing with each squirt.  It's hard to make out just how much or how far your cream has gone in the dark, but judging by what seemed like an eon of excitement, you're confident that you've made your mark.  You know that Exgartuan has fallen into her slumber when your otherwise perky pompoms succumb to the laws of gravity and return to their original state, soreness seeping in after a night of tossing, tugging and teasing.");
	//[if corruption <50]
	if(player.cor < 50) outputText("  A heavy sigh escapes your lips as you feel the artificial pressure subside, replaced with the slight increase of lust all the excitement brought on.  You'll have to tend to that when you're nice and rested.  Unfortunately, your mighty milk fountain has drenched you and the surrounding countryside, turning dirt to mud and your desire to come out of this somewhat clean becoming a futile fantasy.  You scoop up what little pride you can find and wander back to camp, a trail of milk forming behind you.");
	//[else]
	else outputText("  Your fingertips continue to sweep across your [skin], seemingly in denial that the exciting night has drawn to a close.  You peer up at the ever-present moon, its crimson hue as foreboding as the day you first arrived in Mareth.  You stew on the prospect of apologizing to the demoness for your forgetfulness.  Though, be it for your pride or hers, you decide it better to just shelf the idea.  All Exgartuan cares about is attention and fucking, better to not go and try to turn her into a conversationalist.  Best to just tend to her every so often if you actually do care.  Once you've taken care of your own lust anyway.  You shake some sense back into your head, sending some dirt flying.  The \"<i>breast show on earth</i>\" left you soaked, your milk turning the dirt to mud around you.  You figure it best to worry about it once you're at camp.  You begin the trek back, a little smile growing on your face once you see the trail of milk you're leaving behind in your wake.");
	//[corruption +2, lust +5] 
	dynStats("lus", 5, "cor", 2);
	flags[kFLAGS.BOOBGARTUAN_SURPRISE_COUNT]++;
	player.changeStatusValue(StatusEffects.Exgartuan,2,25);
	doNext(playerMenu);
}

//Requirements:
//Exgartuan in cock
//Naga lower half
//~50%(maybe less?) to replace normal Exgartuan masturbation scene
public function exgartuanNagaStoleMyMasturbation():void {
	spriteSelect(15);
	clearOutput();
	//[if corruption <15]
	if(player.cor < 15) outputText("You sheepishly find some rocks to hide in, where you remove your clothes.  \"Keeping me all to yourself, slut? Hide as much as you want, it'll never keep me down,\" Exgartuan gloats.\n\n");
	
	outputText("Irritating... ");
	//[if corruption ≥15 & <30]
	if(player.cor <= 25) outputText("You make sure you are alone and strip naked.  Exgartuan chides, \"Yes, champion, wallow around in the shadows.  Keep pretending you can continue to hide my brilliance from the world.\"");
	//[if corruption ≥30 & <60]
	else if(player.cor <= 50) outputText("You happily remove your [armor], eager to pleasure yourself.  Your possessed cock pulses happily as you remove the last article.");
	//[if corruption ≥60 & <80]
	else if(player.cor <= 75) outputText("You strip naked in an exaggerated fashion, hoping someone might be watching.  Exgartuan begins flooding you with lust in response to your willing inclination.");
	//[if corruption ≥80]
	else outputText("You strip naked, fondling your naughty bits as you do so and casting seductive looks around, hoping someone or something is nearby to fuck you.  Your demonic dong throbs happily from within you, anxious to move on with the festivities.");
	outputText("\n\n");
	
	//[if corruption <33]
	if(player.cor < 33) {
		outputText("Having grown weary of the demon's constant taunts, you finally decide to give in to his forced temptations.  May as well get this over with now rather than letting it get out of hand.  As satisfying as it feels to manhandle your man meat, your corrupt passenger always manages to make it feel wrong once you've regained your senses.  Your pondering quickly begins to dissolve once you feel your [cock] slowly stretch its way out from your slithery slit");
		//[if cocks == 2]
		if(player.cockTotal() == 2) outputText(", your remaining tool hiding away inside you, uninvited.");
		//[if cocks ≥ 3]
		else if(player.cockTotal() >= 3) outputText(", your remaining poles hiding away inside you, uninvited.");
		else outputText(".");
		outputText("  Just how the hell does Exgartuan manage to-\"<i>No time for your feeble mind to try and comprehend my power, champion,\" your rod interrupts, \"I wouldn't want you to hurt yourself BEFORE I get the chance to.\"  Now you REALLY want to get this over with and move on.  With a dejected sigh and a preparatory stretch of your shoulders, you reach down to do the dirty deed.\n\n");
		
		outputText("Well, you had planned on it.  Your arms have frozen in place above your unholy pecker.  \"I have no need for your inexperienced fumbling today, my needy little slut.  Sit back and tremble as I rock your world.\"\n\n");
	}
	//[if corruption ≥33 & <66]
	if(player.cor > 33 && player.cor < 66) {
		outputText("  You shouldn't be looking forward to this, should you?");
		outputText("  You haven't even quite figured out just how much of the pleasure one of these sessions garners is actually genuine.  But that doesn't make it any less savory.  \"What's wrong, [name],\" your perverse pecker chimes in, obviously reacting to your internal conflict, \"Having any second thoughts?  You aren't suddenly feeling as if you're above the fun I have on tap, are you?\"\n\n");
	
		outputText("No, wait, it's pretty fucking clear you love the fucking; it's the fucking demon that you fucking can't tolerate.  You think.  Fuck.  You shake your head to try and clear your thoughts, focusing on what you came over here to do.  Your erect [cock] has already made its way out of your slithery slit");
		//[if cocks == 2]
		if(player.cockTotal() == 2) outputText(", your remaining tool still hiding away inside you, uninvited.");
		//[if cocks ≥ 3]
		else if(player.cockTotal() > 2) outputText(", your remaining poles still hiding away inside you, uninvited.");
		else outputText(".  You lean down to embrace the demon and your arms are frozen in place before you can even touch him.  Of course.  \"Are you hungry, champion?\" Exgartuan mocks, shaking slightly to further dig in the knife, \"And to think you're so eager to jump in and have some fun.  But I have something else planned today.\"\n\n");
	}
	//[else]
	else {
		outputText("All right, no more fooling around; you've been looking forward to this all your life.  Like you say every time you get to bump elbows with this divine deity of dicks, no use wasting any more time with idle fantasies; you've got the real thing right on you.  Or inside of you, as you begin coaxing the demon out of your serpent-like slit, slowly rubbing him up to full size.  \"Oh yea, right under my head.  That feels great,\" Exgartuan never seems to get enough of you.  But when he feels so goddamn good, how can you resist?");
		//[if cocks == 2]
		if(player.cockTotal() == 2) outputText("  Speaking of resisting, it appears your second tool has been forced to stay in the shed.");
		//[if cocks ≥ 3]
		else if(player.cockTotal() >= 3) outputText("  Speaking of resisting, it appears your remaining tools have been forced to stay in the shed.");
		outputText("  Your [cock] makes good on its end of the bargain by pumping out its own never-ending supply of lubricant, making your master massage all the more slick and smooth along its surface.  You lay off for a moment to admire your work, your demonic dong throbbing happily now that its full of blood and as tall and thick as a tree.  The corrupt warmth and comfort flowing through your body pleases you to no end.\n\n");
		
		outputText("\"[name], am I ever glad I wound up with you,\" the engorged demon praises you through a surprisingly pleased tone, \"An eternity together fueled by your cock massages would be too short.  I have something I've been meaning to try today, though.  A slut such as yourself should get a kick out of it.\"  You take the compliment, interested in just what your partner in crime has in mind as you lean back and enjoy the show.\n\n");
	}
	outputText("A sudden tumble to your backside is first on the agenda as your long tail whips around in front of you.  The demon has commandeered your body from waist down to the tip of your lengthy, strong snake body.  You can only sink into the role as a spectator, watching the end of your tail practically kissing the opening of your [cock], smothering itself in the demon's reservoir of pre-cum.");
	//[if corruption <50]
	if(player.cor < 50) outputText("  In a move that you could only describe as appallingly spiteful, your urethra gapes open as wide as it can, inviting your tail to coat itself even further.  You make out a low, menacing laugh needling its way through your mind, its owner clear.  A few agonizing moments of gasps through clenched teeth and your hind end emerges with a moist pop.  Of course your corrupted nerves react in only pleasure from the perverse showing; you fear for the day when you can't make the distinction.");
	outputText("  The possessed shaft works down all of your underside that it can reach, cooperating with your borrowed body to coat both parties as evenly as they can.\n\n");
	
	//[If int > 9]
	if(player.inte > 9) outputText("You aren't stupid; you can hazard more than just a guess as to what's about to happen.");
	//[else]
	else outputText("You may be stupid, but it's incredibly clear what's going on here.");
	outputText("  Exgartuan ends what little foreplay there is, coiling around your titanic shaft with your wet tail.");
	//[if cockLength(0) ≥ .5*tallness]
	if(player.cocks[0].cockLength >= player.tallness * .5) outputText("  There's not quite enough of you to fully envelop the horny monument, however.  Its head pokes out of the top of the scaley volcano, continuing to spew its not-quite-so-molten lava.");
	//[else]
	else outputText("  As impressive as Exgartuan's mighty length is in these lands, your tail is plenty capable of completely enveloping the titan in its scaley embrace.");
	outputText("  The pressure on display here is tremendous.  The demon's vice-like grip is, like his many feats, teetering on the edge of expertise and insanity: you can't begin to comprehend how a squeeze this strong hasn't tripped the line from pleasure to pain.  You can only perceive your upper body's joints as forming right angles, tensing up from the gratifying duress.\n\n");
	
	outputText("Your dastardly dick moves on to phase two of its evil plan: stroking.  It's slow at first; you can feel each little nub react as each slick coil passes over them, the sensation just as maddeningly satisfying as everything else.  You feel as if your midsection is being stretched when your tail lifts as high as it can, exposing the base of your sinister shaft to the elements.  The roller coaster's been nothing but anticipation.  You enjoy just the mounting pleasure of the journey as it makes the first ascension.  Now you're hanging hundreds of feet in the air, your ride inching closer to the precipice.  You can see everything that you're in for laying ahead of you, but you can never perceive how it'll actually play out in action.  All you can do is dig your nails into your harness and- great goblins' ghosts!  The demon's already gone to work, your tail bottoming out on you one instant and teasing only your head the next.  The sound of scales smacking a wide surface area fills the air.  You would begin to wonder how the repeated blows to your groin haven't resulted in injury, but your mind is enthralled by the feel of your super-sized shaft's stimulation.  Even if you weren't orgasmicly paralyzed, you know better than to try and make sense of the dealings of your possessed pecker.\n\n");
	
	outputText("Self stimulation should never feel this good.  This doesn't even seem like masturbation.  All you've been able to contribute to this action are clenched fists, various sounds, and shuffling expressions.  ");
	//[if corruption <33]
	if(player.cor < 33) outputText("\"<i>You can't measure up to treatment of this magnitude, champion,\" Exgarutan insults you, his voice trembling as the slick massage persists, \"But don't think that I'm giving you permission to slack off.  A slut like you can go on dreaming; one day maybe you'll have the perseverance to get close.\"");
	//[if corruption ≥33 & <66]
	else if(player.cor < 66) outputText("Your corrupt cock begins to speak up, the demon's unrelenting motions refusing to ease off, \"You're loving every bit of this champion.  There isn't a hint of uncertainty lingering in your senses.  If only you were this accepting all the time.\"");
	//[else]
	else outputText("\"<i>Isn't this great, [name]? With both of our sexual expertise combined, we'll own this land in no time, and enjoy the fuck out of any downtime.\"");
	outputText("  You're at your wits' end, the demon's words triggering your release.  You can feel a ");
	//[if cumQ()<50]
	if(player.cumQ() < 50) outputText("modest");
	//[if cumQ()<150]
	else if(player.cumQ() < 150) outputText("sizably sticky");
	//[if cumQ()<300]
	else if(player.cumQ() < 300) outputText("mighty thick");
	//[if cumQ()<800]
	else if(player.cumQ() < 800) outputText("immensely voluminous");
	//[else]
	else outputText("monumental");
	outputText(" load working its way up your [cock]... and stop.  You sit up in an involuntary attempt to release the pressure, only to be met by your coiled-up shaft bending to greet your face, its urethra spread wide open...\n\n");

	outputText("Having coated your face and upper torso in a demonic jism assault, Exgartuan returns to your serpent's slit.  His grasp on your tail lifts, leaving you to undo the tangled mess he left behind.  But you're too busy laying back decompressing.  No thoughts, no musings, no questions, no doubts... nothing is going on in your cum-soaked head.  What is there to say?");
	player.changeStatusValue(StatusEffects.Exgartuan,2,(16 + rand(7)));
	player.orgasm();
	dynStats("lib", .25);
	doNext(camp.returnToCampUseOneHour);
}
}
}
