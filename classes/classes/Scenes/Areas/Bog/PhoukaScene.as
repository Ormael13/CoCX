/**
 * Created by K.Quesom 11.06.14
 */
package classes.Scenes.Areas.Bog
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class PhoukaScene extends BaseContent implements TimeAwareInterface {

		internal static var phoukaForm:int = 0; //This keeps track of the form of the phouka across different scenes and through combat
		internal static const PHOUKA_FORM_FAERIE:int = 0;
		internal static const PHOUKA_FORM_BUNNY:int = 1;
		internal static const PHOUKA_FORM_GOAT:int = 2;
		internal static const PHOUKA_FORM_HORSE:int = 3;

		public function PhoukaScene() 
		{
			CoC.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			if (player.statusEffectv1(StatusEffects.PhoukaWhiskeyAffect) > 0) {
				player.addStatusValue(StatusEffects.PhoukaWhiskeyAffect, 1, -1); //Count down hours until player is not drunk
				if (player.statusEffectv1(StatusEffects.PhoukaWhiskeyAffect) <= 0) {
					kGAMECLASS.consumables.P_WHSKY.phoukaWhiskeyExpires(player);
					return true;
				}
			}
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation
		
		public function phoukaNameText(known:String, unknown:String):String
		{ //Helper function, For any text that depends on whether or not the player knows what to call a phouka
			return (flags[kFLAGS.PHOUKA_LORE] == 0 ? unknown : known);
		}

		public function phoukaName():String
		{ //Helper function, Handles the most use of phoukaNameText
			return phoukaNameText("phouka", "faerie creature");
		}

		public function phoukaEncounter():void
		{ //General entry point for everything except halloween special encounter
			phoukaForm = PHOUKA_FORM_FAERIE; //Reset to faerie form at the start of any encounter
			var choiceChance:int = 0;
			if (flags[kFLAGS.PHOUKA_ENCOUNTER_STATUS] == 0) { //Guarantee first Phouka encounter is with faerie fire
				flags[kFLAGS.TREACLE_MINE_YEAR_DONE] = date.fullYear - 1; //If you've never encountered phoukas before then we can safely set all this stuff here
				flags[kFLAGS.BIRTHS_PHOUKA] = 0;
				flags[kFLAGS.BIRTHS_FAERIE] = 0;
			}
			else if ((date.month > 4) && (date.month < 11))
				choiceChance = rand(7); //All through the late summer and autumn they might be masturbating on berries
			else choiceChance = rand(6);
			if (choiceChance < 2)
				phoukaFaerieFire();
			else if (choiceChance < 5)
				phoukaStuck();
			else phoukaMasturbating();
		}

		protected function phoukaFaerieFire():void
		{ //In old Irish legends the Phouka are responsible for Will-o’-the-wisps. In the deep woods it’s Kitsune, but in the bog it’s a Phouka
			clearOutput();
			outputText("As you’re wading through the bog a flickering light off in the distance catches your eye.  ");
			if (flags[kFLAGS.PHOUKA_ENCOUNTER_STATUS] != 0) {
				outputText("You recall your last encounter with one of these 'lanterns' out here in the bog.\n\nPerhaps it would be best to leave this faerie fire alone.");
			}
			else { //Special text for the first encounter
				outputText("It seems to be moving around in one of the dense parts of the bog, where the canopy of dead trees and creeping vines create shadows as deep as twilight even at noon.\n\nYou can't make out a figure holding the light, but you decide to follow.  Spurred on by the thought that it may be someone else like yourself, or perhaps some agent of the demons, you keep trying to catch up with the light up ahead.  This trip into the bog is about to pay off.");
				if (player.hasKeyItem("Traveler's Guide") >= 0) {
					outputText("\n\nSuddenly a warning from that Traveler's Guide pops into your head.  Flickering lights in the swamps and bogs are just swamp gas, it said, unless they're something much worse.  Well meaning travelers who follow them are lucky to escape unharmed.\n\nPerhaps it would be best to leave this faerie fire alone.");
				}
			}
			menu();
			if (flags[kFLAGS.PHOUKA_ENCOUNTER_STATUS] != 0 || player.hasKeyItem("Traveler's Guide") >= 0) addButton(4, "Leave", phoukaFaerieFireLeave);
			addButton(0, "Follow", phoukaStuck);
		}

		protected function phoukaFaerieFireLeave():void
		{
			if (flags[kFLAGS.PHOUKA_ENCOUNTER_STATUS] == 0)
			outputText("\n\nYou decide it's best not to mess with weird floating lights out in the bog and return to your camp.")
			else outputText("\n\nAt the moment you don't feel the need to meet one of those " + phoukaNameText("phouka", "creatures") + " again.");
			doNext(camp.returnToCampUseOneHour);  //Return to camp, 1 hour used
		}

		protected function phoukaStuck():void
		{
			clearOutput();
			var hasAlcohol:Boolean = player.hasItem(consumables.P_WHSKY, 1);
			outputText("You follow some firmer ground into one of the many copses of dead trees.  The bog is quiet and still here.  Up ahead you see something glint in the hollow of a dead tree, but before you can investigate the firm ground beneath your feet liquefies and you begin to sink.\n\nYou try to leap to another muddy lump of exposed ground, but even before you land it has gone soft as well.  You are soon encased in mud almost to your waist.\n\nThat's when you feel something slick and warm dart past you in the muck.  Wherever it goes it drags a thick net behind it.  Your ");
			if (player.isNaga()) outputText("tail is");
			else outputText("legs are");
			outputText(" soon tangled in a solid web of intertwined roots.  Once you are bound in place, a large black eel launches itself free of the muck and lands in a nearby puddle.\n\nYour attacker seems to melt, then reforms, becoming a five inch tall " + phoukaName() + ".  His skin and wings are coal black, and his eyes are green and shiny like those of a cat.  He isn't wearing any clothes, and a fully erect cock almost an inch long juts out of his groin.  Apart from that and a lack of breasts, his body looks feminine, much like the faeries of the woods.\n\nThe " + phoukaName() + " leers at you, clearly deciding what he wants to do next.");
			if (hasAlcohol) outputText("\n\nYou suspect that if you offer up that whiskey in your pack the " + phoukaName() + " probably won’t try to rape you.");
			if (flags[kFLAGS.PHOUKA_ENCOUNTER_STATUS] == 0) flags[kFLAGS.PHOUKA_ENCOUNTER_STATUS] = 1;

			menu();
			if (hasAlcohol) addButton(0, "Offer Drink", phoukaStuckOfferWhiskey);
			addButton(1, "Talk", phoukaTalk);
			addButton(2, "Fight", phoukaStartFight);
		}

		protected function phoukaStuckOfferWhiskey():void
		{
			clearOutput();
			outputText("You pull out the bottle and ask the " + phoukaName() + " if he might be interested in a drink.  He looks at the bottle and says <i>“Well we both know where ya picked that up, hmmm?”</i>  Then he smiles and adds <i>“Course that’s some other phouka’s problem if he let ye beat him.”</i>");
			if (flags[kFLAGS.PHOUKA_LORE] == 0) flags[kFLAGS.PHOUKA_LORE] = 1; //Now you know what to call them
			player.consumeItem(consumables.P_WHSKY, 1);
			outputText("\n\nThe phouka zips over to a nearby tree and collects a pair of leather drinking cups while you pry the cork out of the bottle.  As he returns his form shifts and grows, becoming a bunny-morph.  You guess in faerie form these phouka are lightweights - that or they just can’t physically take in enough booze for their liking.  He takes the bottle and pours some of the clear amber liquid into the cups, offering one to you.");
			phoukaForm = PHOUKA_FORM_BUNNY;

			if ((player.pregnancyIncubation == 0) && (player.buttPregnancyIncubation == 0)) {
				menu();
				addButton(1, "Drink", phoukaDrinkAccept);
			}
			else phoukaDrinkWhilePregnant(true);
		}

		protected function phoukaMasturbating():void
		{ //Old Irish folklore again - Phoukas were supposed to be responsible for the berries rotting away at the end of the year
			clearOutput();
			outputText("You are wandering through the bog when you hear the unmistakable sound of someone fapping like there's no tomorrow.  You sneak up on the small group of shrubs expecting to find an imp who has finally been overcome by his own lust.  Instead it's a " + phoukaNameText("phouka", "small black faerie") + " you see madly jerking off.  He grunts and strains but seems unable to finish.  With an annoyed look he dives for the bush, grabbing some small ripe berries from a branch.  The " + phoukaName() + " rubs the berries on his cock until it drips with blue and black fruit juices.  He tosses the remains of the fruits to the ground and goes back to wanking.\n\nAfter another minute or so he finally thrusts his hips forward in mid-air and begins squirting streams of thick grey cum all over the bushes.  He produces far more cum than he should be able to for a creature his size.  He aims the last several streams directly onto the berries for some reason.  By the time he's done the bush looks like it's covered in a layer of off-white frosting.\n\nThe " + phoukaName() + " gives a satisfied <i>“Ha!”</i> and flies off.  Glancing at the bush you decide you won't be making any preserves from the fruits in the bog and turn back toward camp.");
			doNext(camp.returnToCampUseOneHour);  //Return to camp, 1 hour used
		}

		protected function phoukaStartFight():void
		{
			outputText("\n\nYou can’t move your lower half, but you roll your shoulders and stare the little monster down.  He’s not taking you without a fight.");
			startCombat(new Phouka(phoukaName()));
		}

		protected function phoukaStartFightSilenced():void
		{
			startCombat(new Phouka(phoukaName()));
			player.createStatusEffect(StatusEffects.WebSilence, 0, 0, 0, 0);
		}

		protected function phoukaTalk():void
		{
			clearOutput();
			outputText("You ask the " + phoukaName());
			if (player.level < 10)
				outputText(" if perhaps there's some way he could release you.")
			else outputText(" if he really wants a taste of what you're going to give him.");

			if (player.cor + rand(125) <= 110) { //Players with 0% corruption have a 12% chance that the Phouka is willing to talk, players with 100% corruption have a 92% chance
				//The phouka is not in the mood for talk, start the fight gagged as punishment for trying to talk
				outputText("  You open your mouth to say something more to the ");
				if (player.cor < 34)
					outputText("vile little monster")
				else if (player.cor < 67)
					outputText("perverted " + phoukaName())
				else outputText("fuckable little " + phoukaName());
				outputText(" but he must not feel like listening.  He launches a ball of black mud at your face, sealing your mouth with sticky and [if (corruption <= 50)ewww -][if (corruption > 50)mmmm -] salty muck.");
				startCombat(new Phouka(phoukaName()));
				player.createStatusEffect(StatusEffects.WebSilence, 0, 0, 0, 0);
			}
			else { //The phouka would rather talk
				outputText("\n\nThe " + phoukaName());
				switch (player.level < 10 ? rand(8) : rand(12)) { //Low level characters don't get the chance to be offered whiskey
					case 0:
					case 1:
					case 2:
					case 3:
					case 4:
					case 5:
					case 6: //Offers you a chance to submit, which leads to the various defeat sex scenes
						outputText(" considers for a moment and then says, <i>“You can't get away from me right now, so why don't you enjoy it?  Otherwise, maybe I bring in some of my friends an we all have at ya.”</i> The confidence in the " + phoukaName() + "'s gaze suggests he isn't bluffing.  He slowly circles you, hovering a few feet out of reach.  His eyes seem to be drinking in every detail of your body in a way that [if (corruption < 50)makes shivers run down your spine][if (corruption >= 50)makes your heart beat faster].\n\nThe " + phoukaName() + " continues, ");
						if (player.hasVagina())
							outputText("<i>“Maybe yer inta bunnies, hrm?  Big bunny with a nice hard cock and strong legs, I can do that fer ya.  Fill that tight little muff o' yers up with a big load o' spunk!”\n\n“Or maybe ");
						else
							outputText("<i>“");
						outputText("I could change inta a goat for ya.  That suit yer fancy?  Is it a fond dream o' yers to let a goat blow its load in yer cornhole?");
						if (player.hasVagina()) 
							outputText("\n\nOh, there's one more ye might like.  Ever rode a stallion?  Ever wondered what it'd be like ta pack what a horse has between its legs inta what you've got tween yers?  Just say the word missy an' I'll change inta a stallion an split ye wide open.”</i>");
						else
							outputText("  If it ain't then tough shite, cause that's what I want.”</i>");
						menu();
						phoukaSexAddStandardMenuChoices();
						addButton(4, "Fight", phoukaStartFight);
						break;
					case 7:
					case 8: //Decides he doesn't want you
						outputText(" takes a long look at you.  Finally he grins and tells you <i>“You know what?  You're not quite what I was lookin for.  Us phooka got varied tastes, ya know.”</i>  Then the phouka lazily flies off, whistling some strange tune to himself.\n\nYou wriggle against your bonds and after a few minutes you are free once more.  You decide that's enough excitement for now and head back to camp.");
						if (flags[kFLAGS.PHOUKA_LORE] == 0) flags[kFLAGS.PHOUKA_LORE] = 1; //Now you know what to call them
						doNext(camp.returnToCampUseOneHour);  //Return to camp, 1 hour used
						break;
					default: //(9, 10 or 11) Offers to share some whiskey
						outputText(" buzzes around in a wide circle and finally comes to a stop near a broken tree.  He lands and reaches into a hollow, pulling out a glass bottle larger than he is.\n\nThe " + phoukaName() + " has some trouble with the stopper and once again seems to melt in front of your eyes.  He grows and changes into the form of a large, black furred bunny, nearly four feet tall that has a very human face and hands.  The bunny yanks the stopper free and pulls some leather drinking cups from the same hollow.  Finally the " + phoukaName() + " looks back at you, holding up the bottle.\n\n<i>“I could beat you, of course.  But it looks like it might be a long fight, and I don’t feel like starting one of those without drinkin more whiskey.”</i> The " + phoukaName() + " spreads his large bunny feet wide to give himself more support while he tips the cup back.  He hacks and coughs, but after the drink, he grins at you a little less lustily. <i>“Great stuff, this.  We phouka make it right here in the bog.  Best water, best peat, best everything for making phouka whiskey.”</i>");
						if (flags[kFLAGS.PHOUKA_LORE] == 0) flags[kFLAGS.PHOUKA_LORE] = 1; //Now you know what to call them
						phoukaForm = PHOUKA_FORM_BUNNY;
						if ((player.pregnancyIncubation == 0) && (player.buttPregnancyIncubation == 0)) {
							outputText("  He pours some of the clear amber liquid into the other cup and offers it to you.");
							menu();
							addButton(0, "Refuse", phoukaDrinkRefuse);
							addButton(1, "Drink", phoukaDrinkAccept);
						}
						else phoukaDrinkWhilePregnant(false);
				} //End of Switch
			}
		}

		protected function phoukaDrinkWhilePregnant(playerOfferedTheBooze:Boolean):void
		{
			if ((player.pregnancyIncubation <= 100) || (player.buttPregnancyIncubation <= 100)) { //Pregnancy is obvious to the phouka
				outputText("\n\n<i>“Here”</i> he says, offering you a full cup of whiskey, <i>“give that baby what it needs.  You want 'em to grow up strong don't ya?”</i>");
			}
			var acceptable:int = consumables.P_WHSKY.phoukaWhiskeyAcceptable(player);
			if (acceptable < 0) {
				outputText("\n\nYou think about the unborn child" + (acceptable <= -3 ? "ren" : "") + " you're carrying.");
				if (acceptable == -4) outputText("  One of them seems to crave the whiskey, but the other is a more normal child.");
				outputText("  Sure, some of the elders around the village said a beer or some light cider was all right for a woman heavy with child, but you doubt that whiskey would be acceptable.  You politely refuse the drink, hoping the phouka won't be offended.");
			}
			else {
				outputText("\n\nYou put one hand on your belly, about to refuse the drink.  Then you realize that yes, this is exactly what your ");
				if (acceptable <= 2)
					outputText("baby needs.  Some light kicks inside your " + (acceptable == 2 ? "distended colon" : "womb") + " suggest that your child knows");
				else
					outputText("babies need.  Some light kicks inside your womb and your distended colon suggest that your children know");
				outputText(" what's up for grabs.  <i>“Go on and have some already. I try not to drink alone.  Always end up fucked by an imp or a drider or something that way.”</i>");
			}
			menu();
			addButton(0, "Refuse", (playerOfferedTheBooze ? phoukaDrinkRefuseAfterOffer : phoukaDrinkRefuse));
			if (acceptable) addButton(1, "Drink", phoukaDrinkAccept);
		}

		protected function phoukaDrinkAccept():void
		{ //In every path that leads here the character learns the creature is called a phouka, so no phoukaName() calls needed
			clearOutput();
			outputText("You accept the cup and give it a careful sniff.  Who knows what the phouka put in this stuff?  The smell reminds you of some scents from the old general store back home.  You try some and find it remarkably smooth for something supposedly cooked up from bog water and peat.  The black bunny gives you a crooked smile and settles down next to you, pouring out some more of the powerful spirits.\n\nBy the time you and the phouka have drunk half the bottle, both of you are feeling a lot better.");
			player.slimeFeed();
			switch (consumables.P_WHSKY.phoukaWhiskeyDrink(player)) {
				case 0: //Player isn't pregnant
					dynStats("lus", rand(5) + 1, "cor", rand(2) + 1); //Minor lust and corruption gains (since you aren’t drinking it all yourself). These gains are permanent
					break;
				case 1: //Child is a phouka or satyr, loves alcohol
					outputText("A warm feeling in your belly lets you know your passenger enjoyed the meal as well.");
					break;
				case 2: //Child is a faerie but will become a phouka with this drink
					outputText("At first, you feel your baby struggle against the whiskey, then it seems to grow content and enjoy it.");
					break;
				case 3: //Child is a faerie, hates phouka whiskey
					outputText("You feel queasy and want to throw up.  There's a pain in your belly and you realize the baby you're carrying didn't like that at all.");
			}
			flags[kFLAGS.PREGNANCY_CORRUPTION]++; //Faerie or phouka babies become more corrupted, no effect if the player is not pregnant or on other types of babies
			consumables.P_WHSKY.phoukaWhiskeyAddStatus(player);
			if (player.tou < 30) {
				outputText("\n\nYou quickly end up drunk and begin a rambling story about your adventures.  The phooka is a good listener, though he asks for lots of detail whenever you bring up sex or potential sex of any kind.  You realize you're in real trouble, turned on and watching the phouka stroking his cock, which is still hard despite the alcohol he's been downing.  He notices your interest and says <i>“Now that you're relaxed, let's go for the main course.  I'll make sure you'll remember it even once you're sober.”</i>");

				menu();
				phoukaSexAddStandardMenuChoices();
			}
			if (player.tou < 70) {
				outputText("  It looks like the phouka is holding his liquor about as well as you are.");
			}
			else {
				outputText("  It seems you can handle your liquor better than the phouka.");
			}
			outputText("  Soon both of you start to share stories about your adventures in Mareth.");
			phoukaDrinkTalk(false);
		}

		protected function phoukaDrinkRefuse():void
		{ //In every path that leads here the character learns the creature is called a phouka, so no phoukaName() calls needed
			clearOutput();
			if ((player.pregnancyIncubation == 0) && (player.buttPregnancyIncubation == 0) && (player.pregnancyIncubation <= 100)) { //Pregnancy is obvious to the phouka
				outputText("The rabbit morph sits down heavily on the wet ground and sips his booze.  <i>“Don't want to fuck, don't want to drink.  What gives?  Live a little and let me have fun with your pregnant pussy.  I’ll get ya off, and it’s not like I can knock you up again.  Course, that'd be fun too.”</i>");
				menu();
				phoukaSexAddStandardMenuChoices();
				addButton(0, "Leave", phoukaDrinkRefusePregnantLeave);
			}
			else { //Less obvious pregnancy or player not pregnant
				outputText("<i>“You damn prude.  That does it! I don't have to sit around listening to this.  I try to be friendly like some people say ya should instead of just raping ya.  What's it get me, huh?”</i>");
				if ((player.lust > 66) || ((player.cor > 50) && (player.lust > 33))) {
					outputText("\n\nYou begin to extract yourself from the bog.  As you do you feel the net of roots and vines rubbing against your body.  A little sex with this shapeshifter to tide you over might just hit the spot.");
					menu();
					phoukaSexAddStandardMenuChoices();
				}
				else menu();
				addButton(0, "Leave", phoukaDrinkRefuseLeave);
			}
		}

		protected function phoukaDrinkRefuseLeave():void
		{ //In every path that leads here the character learns the creature is called a phouka, so no phoukaName() calls needed
			clearOutput();
			outputText("You extract yourself from the mud and get out of the bog before the phouka changes its mind.");
			doNext(camp.returnToCampUseOneHour);  //Return to camp, 1 hour used
		}

		protected function phoukaDrinkRefusePregnantLeave():void
		{ //In every path that leads here the character learns the creature is called a phouka, so no phoukaName() calls needed
			clearOutput();
			outputText("<i>“Ah fuck.  You're a killjoy.  Don't you know the best time to get porked is when you've already got a bun in the oven?”</i>\n\nThe black bunny waves you away dismissively. <i>“Fine, yeah, go home.  I hope the little bastard hurts when it pops out.  I would have stretched you out but good.”</i>");
			doNext(camp.returnToCampUseOneHour);  //Return to camp, 1 hour used
		}

		protected function phoukaDrinkRefuseAfterOffer():void
		{
			clearOutput();
			outputText("The phouka looks disappointed but downs one of the cups and says <i>“How come chicks that’re knocked up are always such stick in the muds?”</i> He starts to sip the second cup, looks over at you and chuckles. <i>“I guess in yer case you’ve got a good excuse - ye are stuck in the mud!”</i> The phouka keeps drinking and it isn’t long before he starts to reminisce.");
			phoukaDrinkTalk(true);
		}

		protected function phoukaDrinkTalk(playerNotDrinking:Boolean):void
		{
			if (flags[kFLAGS.PHOUKA_LORE] == 1) {
				flags[kFLAGS.PHOUKA_LORE]++;
				outputText("\n\nFrom the stories he tells you learn the phouka were once faeries from the forest, but once they changed into phouka they found the bog was much more to their liking.  They spend a lot of time fucking and trying lots of different potions and herbs in an attempt to improve their recipes for various kinds of alcohol.  Faeries have their traditional faerie dew, but it's too sweet for the phouka.  They prefer whiskey, though they brew a number of different concoctions.\n\nHe keeps calling the faeries his cum slut cousins and several stories revolve around one or more phouka getting faeries utterly drunk before taking advantage of them.  He says it's a shame the faeries don't fall for 'stealth booze' anymore.");
			}
			else if (flags[kFLAGS.PHOUKA_LORE] == 2) {
				flags[kFLAGS.PHOUKA_LORE]++;
				outputText("\n\nThis phouka seems to be something of a brewer, at least when he's not trapping and raping victims.  He tells you about harvesting some kind of white vegetable bulbs that grow in the bog and how they're always on the lookout for lumps of clay and chunks of bog iron to make parts for their stills.  Apparently the mucky peat from the bog burns nicely once it's dry, so there's no shortage of fuel.\n\nHe tells you the hardest part is finding wood to make the barrels to age the whiskey in.  Those 'bitchy butterflies' in the forest don't like it when the phouka cut down trees.");
			}
			else if (flags[kFLAGS.PHOUKA_LORE] == 3) {
				flags[kFLAGS.PHOUKA_LORE] += 1;
				outputText("\n\nOnce you're feeling warm and cozy despite the dampness of the bog this phouka starts to tell you more about his faerie cousins.  You already know the phouka like nothing more than to rape forest faeries if they can get them alone, but this one goes into more detail.\n\nHe tells you that faeries are supposed to be born out of special flowers after a 'magicy sparkly fucken ritual'. <i>“When the demons came they didn't like that faeries was so pure an chaste that they didn't even fuck to make babies.”</i> His face breaks into a wide smile as he says <i>“Turns out faeries always had all the right parts for carrying babies, just no men to knock 'em up.”</i>\n\n<i>“Anyways, best thing that ever happened was one of those demons used its brains for more than screwing for a while.  I don't know what perverted recipe it came up with, but they used that to made a few of us better.  We tried to share the joys of cock with those stuck up bitches an all they wanted was to 'cure' us.”</i> The bunny-morph spits that last word out like a curse. <i>“Anyway, we learned how ta get our own back.  When we find 'em alone, we catch those pint size pretties, we put 'em in a cage, an' we get ‘em blind drunk with whiskey.  Then we feed 'em rizza root 'til they're our size.  An' last we pump cum inside 'em until they've got a belly like an apple.  It's a sight to see, I tell ya.”</i>");
			}
			else if (flags[kFLAGS.PHOUKA_LORE] == 4) {
				//More can come later, right now we don’t increment here //flags[kFLAGS.PHOUKA_LORE] += 1;
				outputText("\n\nYou ask the phouka what they do to breed.  Does one phouka shapeshift into a woman so she can carry a child?\n\nThe phouka laughs, but you sense it's not an entirely happy laugh. <i>“That don't quite work, not that we haven't tried.”</i> He reclines a bit more and takes another sip before continuing. <i>“We've tried all sorts o' potions and such.  No dice.  Two phouka just can't make a baby.  The closest we ever got was when one o' the phouka spent three days poopin' out those little colored eggs.  Handy for some things, but no baby.  Nah, the only way we make more phouka is by trappin' an' raping faeries.  That's why we're so good at it!  An' I think some o' them get to like it.  Even when we knock 'em up they might get away an' purify themselves with faerie dew or that super sweet honey before the baby gets out.”</i> He absentmindedly strokes his cock a few times and says <i>“Maybe I have a couple o' daughters out there in the woods.  Ya never know.”</i>");
			}
            var playerIsInebriated:Boolean = (playerNotDrinking == false) && (player.tou < 70);
			if (playerIsInebriated) {
				outputText("\n\nWhen the bottle runs out the bunny stands up, nearly falls down again and looks at you with his eyes crossing. <i>“Okay, this is good.  This is like the parties in the olden days.  You stay here, I'll go find sumore booze an' maybe sum buddies o' mine too.  Great booze, great party.  That's ther way!”</i> Then the bunny melts away, the swirling mess of black fur slowly contracting and reforming itself as a little black faerie again.  He waves and takes off on a dangerous looking spiraling course through the trees.\n\nAs the fuzziness from the whiskey begins to fade you realize [if (corruption <= 66)it probably isn't the best idea to stick around][if (corruption > 66)that you could get away if you want to].  If your new drinking buddy really does bring back some friends you'll probably experience the kind of 'party' that will make your jaw click when you talk and leave all your holes sore for a week.");
				menu();
				addButton(0, "Leave", phoukaDrinkLeave);
			}
			else {
				if (playerNotDrinking)
					outputText("\n\nThe stories continue and the phouka gets progressively more and more drunk. Finally he topples over, utterly drunk.");
				else
					outputText("\n\nAs you drink another cup of whiskey the phouka topples over, utterly drunk. You've been feeling the effects but your drinking buddy is done.");
				outputText("  He lets out a little giggle and begins to shrink. Tendrils of black smoke rise from the bunny morph’s black fur as he shrinks back to the size and shape of a faerie.");
				phoukaForm = PHOUKA_FORM_FAERIE;
				if (player.lust < 33)
					outputText("  It looks like he needs a nap and you take that as your cue to get out of here.");
				else {
					outputText("\n\nYou look at the sleeping phouka");
					if (player.hasCock())
						outputText(", [eachCock] beginning to swell" + (player.hasVagina() ? " and your [vagina] starting to moisten" : "") + ".")
					else if (player.hasVagina())
						outputText(", your [vagina] starting to moisten.")
					else outputText("and you feel your sphincter twitch as your brain thinks about what you could do with this phouka now."); //Genderless
				}
				menu();
				addButton(0, "Leave", phoukaDrinkLeave);
				if (player.lust >= 33) {
					addButton(1, "Ride Faerie", phoukaSexFaerieNonCombat); //Works for all
					if (player.hasCock()) addButton(2, "Fuck Faerie", phoukaSexFaerieFemaleNonCombat); //Male or Herm Only
				}
			}
		}

		protected function phoukaDrinkLeave():void
		{
			if (player.lust < 33)
				outputText("\n\nIf you were a bit hornier");
			else
				outputText("\n\nIf you wanted");
			outputText(" you could take advantage of the phouka’s predicament, but right now you’d rather go and check on the portal.  Thanks to the whiskey, the water soaking your [legs] doesn't matter to you quite so much as you slog back towards camp.");
			doNext(camp.returnToCampUseOneHour);  //Return to camp, 1 hour used
		}

		public function phoukaHalloween():void
		{
			flags[kFLAGS.TREACLE_MINE_YEAR_DONE] = date.fullYear;
			clearOutput();
			outputText("Once again you find yourself wading through the cold, wet mire of the bog.  You are, as usual, keeping your eyes open for any of the bog's varied inhabitants, but it's your ears that lead you to them.  Scraping noises.  Loud enough they can't be far off and regular enough that they can't be natural.  You ready yourself, your mind imagining all sorts of causes for the noise.  No one in this world would bother burying a body, would they?  Perhaps a witch is scraping the inside of her cauldron?  Wait, why would you even think that?  Must be the time of year.\n\nYou sneak up on the source of the sound, a large mound of solid land poking up from the bog, almost like an island.  A few twisted trees still cling to life here.  What you find is a surprise.  In a small clearing are half a dozen phouka.  One is buzzing around in faerie form and is wearing a small white cap.  The others have taken the form of goat-morphs and are carefully clearing dirt away from something.  The one in faerie form spots you and stands up, motioning for you to come over.\n\n<i>“Hey there!  Good timing on yer part.  We were just about to stab fer the treacle.  Looks like a big load of it, so we'll never get it all in the barrels.”</i> You look over and see two kegs, each about half the size of your water barrels back at camp.  Since these phouka seem friendly (and don't seem to want to rape you right now) you decide to take a closer look.\n\nThey have excavated a small patch of soil, about 2 feet on a side.  Only a foot down there's a seamless black membrane.  You've never seen anything like it before, so you ask what they're doing.  The phouka with the white cap responds <i>“You've never seen treacle mining before? How de you think we get all the sugar?”</i>\n\nSince you still look confused he continues. <i>“Treacle builds up underground, leaks inta big bubbles like this from tree roots.  The bubbles build up a skin of hard black treacle te protect the white treacle.”</i> He gestures at the black substance beneath the soil.\n\nOne of the goat-morph phouka stands and comes over. <i>“Okay boss, it's all cleaned off.”</i> The phouka you've been talking to buzzes over to the hole and checks it over. <i>“Yes, yes. Ye done good work, it's spotless.  Is the pump ready?”</i> Another of the goat-morphs nods, holding up a kind of bellows with two hoses sticking out of it. <i>“Perfect! Right, two barrels o' treacle comin right up.”</i>\n\nHe turns back to you and adds <i>“Pumping treacle can be exhausting, so if ye give us a hand we'll let you eat some of the leftovers.  Unless I missed my guess there's so much down there we'll all be able te eat our fill.”</i>");

			if (player.gender == 2) {
				outputText("\n\nOne of the goat-morph phouka turns to the white cap and says <i>“Women aren't supposed to pump treacle.”</i> The white capped phouka growls and turns around, smacking the goat-morph with his cap. <i>“I got the cap, I'm the boss round here!  I say she can pump, so pump she can!”</i> The boss pulls his cap back on and the goat-morph quickly backs off.");
			}

			outputText("\n\nThe white hat phouka pulls out a wickedly sharp little knife and uses it to cut a long slit in the black membrane.  It sags a little bit and a thick off-white syrup begins to seep through the slit.  One of the goat-morphs feeds the tube into the slit and the one with the bellows feeds the other tube into one of the barrels.  The phouka begin pumping away and you hear the wet plorping noises of treacle landing in the bottom of the barrel.  The clearing is filled with a sugary smell and you start to wonder what treacle tastes like.\n\nThe bellows gets passed from phouka to phouka and eventually to your hands.  ");
			if (player.str < 40) {
				outputText("You find it very difficult to operate and have to squeeze it with your thighs, but you manage to pump a respectable amount before passing it on.");
			}
			else if (player.str < 80) {
				outputText("You find that treacle pumping is as hard as the phouka said, but you keep at it.  With what you pumped you must be as strong as they are.");
			}
			else {
				outputText("You don't know why they said this was difficult.  You have no problem pumping the treacle; in fact they have to stop you partway through to change barrels.");
			}
			outputText("\n\nAfter most of the phouka take another turn pumping the barrels are finally full and one of the goat-morphs hammers a cork into both of them. <i>“Ready for that taste o' treacle?”</i> asks the leader, offering you the end of the hose and a small cup.");

			if (player.inte > 80) outputText("\n\nYou're about to accept when you notice how a few of the phouka in the back are looking at you.  It's a look you recognize from merchants who used to stop in Ingnam to sell their wares.  The 'a sucker born every minute' look.  You realize none of the phouka have so much as tasted any treacle and you start to wonder what this sugary substance really is.");
			menu();
			addButton(0, "Taste", phoukaHalloweenTreacleEater);
			if (player.inte > 80) addButton(4, "Leave", phoukaHalloweenLeave);
		}

		protected function phoukaHalloweenLeave():void
		{
			outputText("\n\nFeeling you're better off not finding out you excuse yourself, telling them they can enjoy the treacle amongst themselves.  As you walk away you just catch the boss telling the others <i>“Watch out fer that one, " + player.mf("He","She") + "'s a smart one.”</i>");
			doNext(camp.returnToCampUseOneHour);  //Return to camp, 1 hour used
		}

		protected function phoukaHalloweenTreacleEater():void
		{
			clearOutput();
			outputText("You take the cup and squeeze the bellows.  Then you tip a bit of the fluid into your mouth and are rewarded with a thick and sweet substance that is also mildly sticky.  After rolling it around your mouth you swallow. <i>“Well, looks like [he] likes it.”</i> says the boss.  You drink a little more.  As you do you notice a subtle aftertaste that you have difficulty placing.  It's hard to make out through all that sugar. \n\n<i>“You want some more?”</i> asks the boss. <i>“After all, it's always a pleasure to share our treacle with a newcomer.”</i> You try another cup, hoping to work out what that other taste is.  You feel like you should be able to place it.  After you swallow this batch you notice the grins of the phouka around you.  It finally hits you - that other taste is phouka spunk.  The phouka see the look on your face and start rolling on the ground laughing.\n\n<i>“Treacle Mining!  And [he] bought it!“</i>\n\n<i>“Oh, ho, 'Pumping treacle can be exhausting'.  Oh, boss yer a killer!“</i>\n\n<i>“Boss, you've done it again, yer the master o' the long con, no one can argue that.”</i>\n\nYes, indeed, you've been pranked but good by the little winged bastards.  Only a bit of smeared mud hid the fact that the words 'wank tank' were carved into the small barrels.  As you storm off towards your camp you hear the leader call out <i>“If ye ever want to taste treacle again I've got some for ye.  Just ask and I'll put it in yer mouth, instead of yer [if (hasVagina = true)cunt][if (hasVagina = false)ass].  Or if you want we can bury it in another barrel and cover it with tarpaper for ya.”</i> Their laughter rings in your ears until after you leave the bog.");
			doNext(camp.returnToCampUseOneHour);  //Return to camp, 1 hour used
		}

		protected function phoukaLeaveOnLustWin(newScreen:Boolean = true):void
		{
			if (newScreen) clearOutput();
			else outputText("\n\n");
			outputText("The lusty " + phoukaName() + " continues to pound his cock into the earth as you prepare to go, oblivious to your presence.");
			kGAMECLASS.combat.clearStatuses(false);
			kGAMECLASS.combat.awardPlayer(); //This will provide loot and return to camp, 1 hour used
		}

		internal function phoukaPlayerWins(hpVictory:Boolean):void
		{
			clearOutput();
			if (hpVictory) { //You win by physical damage, the phouka cheats and runs
				outputText("The seriously injured " + phoukaName() + " stumbles backward, but before you can strike again it twists and stretches in mid-air, dropping to the ground in the form of a long black eel.  You're pretty sure you hear the eel curse at you as it dives into the mire and sinks out of view.\n\nWith your attacker gone you struggle and strain to get yourself free of the thick mass of roots and muck around your [legs].  Your lower half is soaked and you decide to head home.");
				kGAMECLASS.combat.clearStatuses(false);
				kGAMECLASS.combat.awardPlayer();  //This will provide loot and return to camp, 1 hour used
			}
			else { //You win by lust and have the chance to fuck the phouka if you’re horny
				outputText("The " + phoukaName() + " collapses to the ground and begins to jab his cock into the peat.");
				if (phoukaForm != PHOUKA_FORM_FAERIE){
					outputText("  As you watch, wisps of black smoke start to rise from him and his body starts to shrink.  In moments the ");
					if (phoukaForm == PHOUKA_FORM_BUNNY)
						outputText("bunny morph");
					else if (phoukaForm == PHOUKA_FORM_GOAT)
						outputText("goat morph");
					else if (phoukaForm == PHOUKA_FORM_HORSE)
						outputText("stallion");
					outputText(" has shrunk back down to the size and shape of a " + phoukaNameText("phouka", "faerie") + ".");
					phoukaForm = PHOUKA_FORM_FAERIE;
				}
				if (player.lust < 33 || flags[kFLAGS.SFW_MODE] > 0) {
					outputText("  The threat dealt with you scoop, dig and finally extract yourself from the mire.  Your lower half is soaked and you long to sit in front of the fire at your camp.  Hefting your supplies you turn back the way you came.");
					phoukaLeaveOnLustWin(false);
				}
				else {
					outputText("  While he's busy, you extract yourself from the muck, and once you're free, you look over at the lusty " + phoukaName());
					if (player.cor < 34)
						outputText(".  You could sate yourself just to be sure you're not distracted on the way home.");
					else if (player.cor < 67)
						outputText(".  You could take advantage of the situation to slake your lust.");
					else outputText(".  It would be so easy to rape this perverted faerie, how can you resist?");
					menu();
					addButton(0, "Leave", phoukaLeaveOnLustWin);
					addButton(1, "Anal Ride", phoukaSexFaeriePostCombat); //Works for all
					if (player.hasCock()) addButton(2, "Fuck Faerie", phoukaSexFaerieFemalePostCombat); //Male or Herm Only
				}
			}
		}  

		public function phoukaPregBirth():void
		{
			outputText("\n<b>You feel something give way inside your belly...</b>\n\n");
			if (player.vaginas.length == 0) {
				outputText("There's a painful pressure in your groin... then you nearly black out and feel your crotch pull apart.  At first you assume it's some kind of hernia, then you realize you have a vagina once more.\n\n");
				player.createVagina();
				player.genderCheck();
			}
			if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 6) { //You’ve been drinking like a fish, haven’t you?
				outputText("Your belly begins to deflate and a stream of nearly black sludge oozes from your vagina.  You lay on the ground and wait, wondering how this birth will go.  As your belly gets flatter and flatter you begin to wonder where the baby is.\n\nThen you feel it - something is stuck inside you.  You begin to push and realize it's not stuck - it doesn't want to come out, and it's holding on to your cervix!  Your body, on the other hand, does want it out and keeps going through contraction after contraction to rid you of this little, freeloading bastard.  The black molasses makes your birth canal sticky, helping to hold the baby in place.  You soon lose track of time as the contractions keep coming.  After several minutes you are beginning to wonder if you'll ever be free of this child when you feel a tingling in your clit.\n\nDespite the pain, or perhaps because of it, your body is headed for an orgasm!  At first you try to fight it, but you soon realize there’s no point.  You’re still in enough pain that you can do nothing but lie there and wait.  Finally you cum and you feel a wash of girl-cum drip from your gaping hole.[if (hasCock = true) At the same time [eachCock] fires numerous strands of cum, coating you and the ground around you.]  Luckily all the girl-cum you produced also fills your pussy and starts to dilute the thick black molasses inside you.  After many more contractions, you feel the baby shift inside you and it finally pops free, landing on the ground between your thighs.\n\nThe " + phoukaName() + " seems to be almost full grown at birth.  He spins round and stares at you, as if it's your fault he had to leave the comfort of your womb.  Before you recover enough to do much, he spreads his wings, shakes the sludge away and flies off toward the bog.\n\nYou lay on the ground, utterly exhausted by the ordeal.  You can feel a slight burning sensation inside your pussy and a throbbing from your womb.  You’re sure that carrying that nasty looking black sludge around inside you has affected your ability to produce children.");
				player.fertility -= 18; //At low fertility the PC just gained up to 3 fertility due to standard post-pregnancy code. So -18 is really more like -10.
				if (player.fertility < 5) player.fertility = 5;
				player.changeFatigue(75);
				flags[kFLAGS.BIRTHS_PHOUKA]++;
				player.orgasm();
			}
			else if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 0) {
				outputText("Your belly begins to deflate and a stream of thick grey sugary sludge dribbles from your vagina.  You lay on the ground and wait, wondering how this birth will go.  As your belly gets flatter and flatter you begin to wonder where the baby is.\n\nThen you feel it - something is stuck inside you.  You begin to push and realize it's not stuck - it doesn't want to come out and it's holding on to your cervix!  Your body, on the other hand, does want it out and keeps going through contraction after contraction to rid you of this little freeloading bastard.  After several minutes you are beginning to wonder if you'll ever be free of this child, when it suddenly shifts inside you and pops free, landing on the ground between your thighs.\n\nThe " + phoukaName() + " seems to be almost full grown at birth.  He spins round and stares at you, as if it's your fault he had to leave the comfort of your womb.  Before you recover enough to do much, he spreads his wings, shakes the sludge away and flies off toward the bog.\n\nYou lay on the ground, exhausted by the ordeal and wondering if carrying that nasty looking sludge around inside you has affected your ability to produce children.");
				player.fertility -= 8; //At low fertility the PC just gained up to 3 fertility due to standard post-pregnancy code. So - 8 is really more like -5.
				if (player.fertility < 5) player.fertility = 5;
				player.changeFatigue(50);
				flags[kFLAGS.BIRTHS_PHOUKA]++;
			}
			else {
				outputText("Your belly begins to deflate and a stream of sweet smelling sugary water rushes from your vagina.  You lay on the ground and wait, hoping this birth will be relatively painless.  You only have to give one little push and you feel a tiny shape slide gently down your birth canal.  Before you're ready for it you expel a little faerie onto the ground between your legs.\n\nThe full grown faerie looks up at you and smiles.  She shakes her little pink faerie wings out until they're dry, then does a little circuit around you, looking you over.  She zips up to your face and gives you a kiss on the cheek before backing away.\n\nThe faerie girl starts to fly higher and higher, waving to you as she goes.  Finally she turns and zips off towards the forest to meet her sisters.");
				player.changeFatigue(5);
				flags[kFLAGS.BIRTHS_FAERIE]++;
			}
		}

		public function phoukaPregUpdate():Boolean
		{ //Belly size doesn't change, instead you get updates on what's going on
			if (player.pregnancyIncubation == 170) { //Stage 1:
				if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 0)
					outputText("\nYour belly still feels solid and heavy.  Whatever is growing inside doesn't want you to move around very much.  You might as well sit around at camp until you force it out.\n");
				else outputText("\nYour belly still feels solid and heavy, but for some reason you feel energized and want to enjoy life.  You could really go for a stroll through the forest.\n");
				return true;
			}
			if (player.pregnancyIncubation == 140) { //Stage 2:
				if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 0)
					outputText("\nYour belly feels a bit softer now.  Every once in a while you feel something tiny bump against the inside of your womb.\n");
				else outputText("\nYour belly feels a bit softer now.  Every once in a while you feel a fluttering against the wall of your womb, almost as if something is flying around in there.\n");
				return true;
			}
			if (player.pregnancyIncubation == 100) { //Stage 3:
				outputText("\nYour belly feels like it's full of liquid, more like a normal pregnancy. ");
				if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 0)
					outputText("\nThat part is more comfortable for you. Too bad you feel like that liquid is stale and tainted.");
				else outputText("\nIt's much more comfortable for you. Whenever you rub your belly you feel so full of life and vitality.");
				outputText(" You've noticed that this pregnancy doesn't seem to be affecting your breasts. It's as if the child inside you has no use for your milk.\n");
				return true;
			}
			if (player.pregnancyIncubation == 60) { //Stage 4:
				if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 6)
					outputText("\nWhatever unclean spawn is inside you hasn't grown very much. Your belly is still packed with tainted fluid and you find it difficult to keep food down.  You constantly experience urges to drink alcohol, the stronger the better.\n");
				else if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 0)
					outputText("\nWhatever unclean spawn is inside you hasn't grown very much. Your belly is still packed with fluid, though it somehow feels less saturated and perhaps a little less tainted.\n");
				else outputText("\nWhatever kind of life is inside you hasn't grown very much. Your belly is still packed with fluid, though it somehow feels less saturated.\n");
				return true;
			}
			if (player.pregnancyIncubation == 36) { //Stage 5:
				outputText("\nEven though your belly remains the same size you somehow feel that your pregnancy is drawing to a close. ");
				if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 6)
					outputText("Despite the small size of your belly you spend most of your time feeling deeply ill and you can't wait to force this thing out.  You can feel a constant dull pain from your womb and ovaries, probably the result of the tainted fluid inside you.  Only drinking alcohol settles your stomach.\n");
				else if (flags[kFLAGS.PREGNANCY_CORRUPTION] > 0)
					outputText("Despite the relatively small size of your belly, you spend most of your time feeling mildly ill and you can't wait to force this thing out.\n");
				else outputText("Despite being pregnant you still don't feel restricted or slowed in any way.  It's as if the tiny life inside is living in harmony with you.\n");
				return true;
			}
			return false;
		}

		protected function phoukaSexAddStandardMenuChoices():void
		{ //This happens several times so it's broken out here in case additional options get added later
			if (player.hasVagina()) {
				addButton(1, "Bunny", phoukaSexBunnyChoice);
				addButton(2, "Horse", phoukaSexHorseChoice);
			}
			addButton(3, "Goat", phoukaSexGoatChoice);
		}

		internal function phoukaSexBunny(postCombat:Boolean, lustLoss:Boolean):void
		{ //Player must have a vagina for bunny-morph sex
			clearOutput();
			if (postCombat) {
				outputText("As you collapse the " + phoukaName());
				if (phoukaForm == PHOUKA_FORM_BUNNY)
					outputText(" hops over and stands in front of you");
				else
					outputText(" begins to shapeshift in front of you.  He changes into various forms, looks you over and finally changes into a black furred bunny-morph");
				outputText(".  You watch as the bunny's erection stiffens, your ");
				if (lustLoss)
					outputText("mind so overcome with lust you can't");
				else outputText("body too bruised to");
				outputText(" resist any further.");
			}
			else {
				if (player.cor <= 50) {
					outputText("It might not be the wisest move, but you decide to let the " + phoukaName() + " have his way with you.  You tell him you would prefer a little bunny loving and the " + phoukaName() + " grins from ear to ear. <i>“Comin' right up,”</i> he says");
					if (phoukaForm != PHOUKA_FORM_BUNNY) outputText(", and morphs into a rabbit");
					outputText(".  Hopefully he'll be gentle with a willing partner.");
				}
				else {
					outputText("You can't think of any good reason to refuse a roll in the hay (or the mire) with this " + phoukaName() + ".  You tell him that you want to feel his big bunny cock deep inside you.  The " + phoukaName() + " grins as you begin seductively stripping off you armor.");
					if (phoukaForm != PHOUKA_FORM_BUNNY) outputText("  He goes through a short series of warm up exercises and then transforms himself into the rabbit you desire.");
				}
			}
			phoukaForm = PHOUKA_FORM_BUNNY;
			outputText("\n\nThe bunny advances on you and says <i>“I can't wait to blow my load inside that nice pussy of yours.”</i> His paws split apart into fingers in a way you are sure would be excruciating for a real rabbit.  The bunny slides his hands over your belly while his nose sniffs at the back of your neck. [if (isPregnant = true)<i>“They say pregnant girls love ta fuck.  You ready for some meat?”</i>][if (isPregnant = false)His fingers begin to tease your [clit] as he asks you <i>“Ready for some meat?”</i>]");
			if ((player.lust > 80) || (player.cor > 50))
				outputText(" You can only moan in response.  The thought of this rabbit stuffing you has your [vagina] leaking already.");
			else
				outputText(" You are powerless to stop the bunny-morph as he undoes the last few straps holding your [armor] in place.");
			outputText("\n\nThe bunny's large feet take up position on either side of your [if (isNaga = true)tail][if (isNaga = false)rump] and you feel the tip of his cock brush against your cunt.  The bunny whispers <i>“[if (isPregnant = true)Time te feed the baby][if (isPregnant = false)Maybe today I'll leave ye a present].”</i>\n\nThe " + phoukaName() + " [if (isNaga = true)bends you over backwards, exposing your slit.  He][if (isTaur = true)strokes your flanks with his paws.  Next he] begins to grind his cock [if (isNaga = true)against your exposed underbelly][if (isNaga = false)between your legs], sliding it against your [clit] each time.  Shivers run up your spine as his fur tickles your [if (isNaga = true)scales from the top to the tip of your tail][if (isNaga = false)legs, back, butt and thighs].  When the bunny-morph is good and ready, he lines up and jams his pole into your moist pussy.  ");
			if (player.hasVirginVagina())
				outputText("You scream as the " + phoukaName() + "'s cock tears your hymen apart.  He stops thrusting and says <i>“A virgin? Here? Good goddess, missy, ya should have told me.”</i> In a lower tone he adds <i>“so I could have enjoyed it more.”</i> Your whole vagina burns as every fold is stretched and widened by the passage of the rabbit's cock.");
			else if (postCombat && (player.vaginas[0].vaginalLooseness < 2))
				outputText("You nearly pass out from the pain as the " + phoukaName() + "'s cock lengthens and thickens inside you.");
			else if (!postCombat || (player.cor > 50))
				outputText("Even as the invader lengthens and thickens you push back against it. <i>“Good girl. Good little fuck slut,”</i> whispers the " + phoukaName());
			player.cuntChange(50, true);
			outputText("\n\nThe bunny starts to use his powerful legs to thrust into you again and again with short, hard strokes.  You are pressed down into the muck and the bog fills with the noise of mud being slapped out of the way by your body.  You aren't sure how much more you can take when the bunny finally drives his cock into you right to the root.  You feel his overstuffed balls tightening as they slap against [if (isNaga = true)the base of your tail][if (isNaga = false)the flesh of your inner thighs].");
			phoukaSexPregnate(postCombat);
		}

		protected function phoukaSexBunnyChoice():void
		{
			phoukaSexBunny(false, false);
		}

		internal function phoukaSexGoat(postCombat:Boolean, lustLoss:Boolean):void
		{ //Player does not have a vagina or has chosen anal
			clearOutput();
			if (postCombat) {
				if (lustLoss)
					outputText("Panting with need, you begin to strip off your [armor].  The " + phoukaName() + " watches the show with an evil smile.");
				else
					outputText("Your body falls to the ground, too weak to fight back against the " + phoukaName() + " any longer.");
				if (phoukaForm != PHOUKA_FORM_GOAT) outputText("  As you lay there, the " + phoukaName() + "'s body stretches and morphs until it takes the form of a large, black furred goat-morph.");
			}
			else {
				outputText("You tell the " + phoukaName() + " you're willing to let him take your ass in his goat form.  He smiles and lands near you.  His body warps into the form of a black furred goat morph.  ");
				if (player.cor <= 50)
					outputText("You steel yourself for an asspounding while you remove your [armor].");
				else outputText("Then you put on a show, taking your clothes off piece by piece.  You strip off your final undergarment, bend over and wink your asshole at the goat.");
			}
			phoukaForm = PHOUKA_FORM_GOAT;
			if (player.hasVagina())
				outputText("\n\n<i>“Aw missy, why’d ye have te be so cruel? Ye’ve got that sexy cunt there just beggin’ fer a cock,”</i> says the goat, wrapping his front legs around your [if (isTaur = true)flanks][if (isTaur = false)upper body]. When you stare at him he laughs and adds <i>“I’ll give yer ass a good poundin if that’s what ye want - don’t worry about that. I just don’t know why ye don’t want me in here.”</i> His smooth hoof slides up and down your slit before he gets down to business.\n\n");
			else
				outputText("\n\n<i>“I can't wait to plunder that [butt] of yours.”</i> says the goat, wrapping his front legs around your [if (isTaur = true)flanks][if (isTaur = false)upper body].\n\n");
			if (postCombat)
				outputText("He mounts you immediately, giving you no chance to adjust to his invading cock.  The goat-morph's first powerful thrust drives your face into the muck as his tries to force his narrow cockhead into your ass.");
			else
				outputText("The goat rubs his cockhead against your pucker, spreading a thick layer of pre over your hole before slowly pressing home his cock.  His first few thrusts are gentle enough that you have the chance to spread your ass and get used to this invader.");
			outputText("  Disturbingly you feel his front 'hooves' split into hard little fingers that he wraps around your [if (isTaur = true)belly][if (isTaur = false)[chest]] to hold onto you even tighter.\n\n");
			if (postCombat)
				outputText("The " + phoukaName() + " shows no interest in you except as a receptacle for his cum.  After stabbing his hips at you several times you feel the full length of his cock penetrate your pucker.");
			else
				outputText("Once your [butt] has adjusted, the goat morph begins to thrust more quickly.  You are surprised when you feel his balls slapping against your [if (isNaga = true)tail][if (isNaga = false)inner thighs] - he can't already be in that deep, can he?");
			outputText("  Once the goat's cock is inside, he stops moving and tenses up.  You feel his cock growing larger and larger until you fear your abused anus is going to split apart.");
			player.buttChange(45, true);
			outputText("\n\nWith his cock expanded to full size and buried inside you, the goat begins rocking back and forth. <i>“How do ye like it?”</i> the " + phoukaName() + " bleats in your ear as he tries to force yet more of his cock inside you.  [if (corruption <= 50)You can't answer the goat, the pain of being split open is too great][if (corruption > 50)You pant with excitement from being dominated by this filthy shapeshifting goat].  The " + phoukaName() + " tenses once more, and this time you feel a thick deposit of semen being squirted into your violated ass.  ");
			if (postCombat)
				outputText("The goat-morph waits only a few seconds before unceremoniously yanking his deflating cock from your ass.");
			else
				outputText("Realizing that you haven't yet cum, the goat morph continues to rock in and out of your ass.  The air fills with the sucking and slurping noises of the goat's seed alternately being sucked deeper or forced out of your ass.  Finally you reach your limit and cum[if (hasCock = true), your own cock turning the mud white beneath you].");
			dynStats("cor", rand(1) + (postCombat ? 1 : 3)); //Extra two corruption for being enough of a pervert to want to fuck the phouka
			player.orgasm();				
			if (postCombat) outputText("  While you're recovering the goat-morph reaches into your gem pouch and takes a handful.");
			outputText("\n\nThe goat morph begins to dissolve and reform.  Soon you're looking at a tiny faerie that buzzes up in front of your face.  He says <i>“[if (hasVagina = true)Well I enjoyed that, and it looks like you did too.  Next time I catch ya I really want te try yer cunt.  Can’t wait te see yer belly all swollen up with my seed.][if (hasVagina = false)Do us both a favor - eat some eggs or drink some milk before ye come back.  Since you like being my bitch so much ye might as well have the right parts for it.]”</i> With that the " + phoukaName() + " buzzes up into the canopy and out of sight.");
			if (postCombat) {
				outputText("\n\nYou work to pull your [if (isNaga = true)tail][if (isNaga = false)legs] free from the cool muck before you get chilled to the bone.");
				combat.cleanupAfterCombat();
			}
			else {
				outputText("\n\nYou collect your clothes and scramble to get out of the bog before anything else finds you.");
				doNext(camp.returnToCampUseOneHour); //Return to camp, 1 hour used
			}
		}

		protected function phoukaSexGoatChoice():void
		{
			phoukaSexGoat(false, false);
		}

		internal function phoukaSexHorse(postCombat:Boolean, lustLoss:Boolean):void
		{ //Player has a vagina
			clearOutput();
			if (postCombat) {
				outputText("As you collapse the " + phoukaName());
				if (phoukaForm == PHOUKA_FORM_HORSE)
					outputText(" circles you in a slow trot, his top half shaping into a centaur form before finally stopping directly in front of you.");
				else
					outputText(" begins to shapeshift in front of you.  It grows and grows, finally taking the form of a massive, black, centaur stallion with an equally massive prick.");
			}
			else { //Phouka can’t be a horse if the player is choosing this. Must be either a faerie or a bunny.
				if (player.cor <= 50)
					outputText("Perhaps this land is finally starting to get to you.  You tell the " + phoukaName() + " you want him to fuck you with a great big horse cock.  The " + phoukaName() + "'s eyes light up. <i>“Sure thing missy”</i> he says, and his form stretches into that of a huge, black furred, centaur stallion.  You hope he'll be gentle with a willing partner.");
				else
					outputText("The more you think about it the more you decide you could use a real fucking.  You smile at the " + phoukaName() + ", telling him you want the biggest cock he can muster.  The " + phoukaName() + "morphs into the form you expected, that of a black, centaur stallion [if (tallness <= 96)taller than you are][if (tallness > 96)that's about your height].  Maybe that tree trunk between his legs can scratch your itch.");
			}
			phoukaForm = PHOUKA_FORM_HORSE;
			outputText("  On closer inspection the centaur is a bit unusual.  For a start, he has shiny green eyes.  Parts of his flanks look like thin wings pressed against its sides.  His nose is a little shorter and his face a lot more human than you would have expected.  He sees you looking him over and says <i>[if (isTaur = true)“I've been waitin for this.  A nice big mare to fuck the daylights out of][if (isTaur = false)“Yer gonna be sorry ye weren't born with four legs and a cunt you could lose an arm in, princess].”</i>\n\n");
			if (!postCombat || lustLoss)
				outputText("Considering the fire in your vagina that's crying out to be quenched, you don't care how big this horse's cock is.  You just need something to fill you NOW.");
			else
				outputText("You're hardly in any condition to refuse.  This stallion is going to pound you with that meatstick no matter what you do[if (corruption <= 50), so you steel yourself for what is to come][if (corruption > 50).  The thought of being wrecked by such an enormous staff has your cunt dripping girl-cum already.]");
			outputText("\n\nThe stallion advances on you, drinking in your scent with his nostrils.  His cock is already rubbing against the underside of his belly, matting his fur with pre.  You can only hope enough runs over that flat cockhead to give you a chance of taking it.  ");
			if (player.isTaur())
				outputText("He walks up behind you and mounts you.  You feel his front legs rubbing against your flanks and have to admit to yourself that this feels right.  The " + phoukaName() + "'s equine cock was built to force its way inside a mare[if (vagCapacity < 40), but it has difficulty with your tight cuntlips.  The stallion has to try twice more before his cock slides into place between your labia][if (vagCapacity >= 40) and it does just that].");
			else {
				if (player.isNaga())
					outputText("He walks in front of you, turns your way and then simply walks over you, forcing your upper body to bend backward over your tail.  Thankfully your snake-like spine means bending into a 'U' shape isn't that uncomfortable.");
				else
					outputText("He walks up behind you and then simply walks right over top of you, his chest knocking you to the ground.  You find yourself on all fours with a massive cockhead grinding against your ass.");
				outputText("  You hear the " + phoukaName() + " say <i>“Now line me up with yer cunt lass, or I'll lay down on top of ya and have a nap.”</i> Not wanting to be crushed under that kind of bulk, you reach [if (isNaga = true)up][if (isNaga = false)behind you] and grab his member.  You place his cock at the entrance to your [vagina] and the stallion steps forward.  [if (vagCapacity < 50)His cock bends and then snaps free of your cunt, slapping against his belly. <i>“Again! And do it right this time!”</i> he shouts.  You line it up once more and press against it with your hands so it has nowhere to go but in.]");
			}
			outputText("  You're convinced you're going to be split in half by this monster horse cock.\n\n");
			if (player.hasVirginVagina())
				outputText("You scream as the " + phoukaName() + "'s cock tears your hymen apart.  He stops mid-thrust and asks <i>“A virgin? Here? Good goddess missy ya should have told me.”</i> In a lower tone he adds <i>“so I could have enjoyed it more.”</i> Your whole vagina burns as every fold is stretched and widened by the passage of the " + phoukaName() + "'s huge horse cock.  You think he's delighted to have taken a woman from virgin to gaping in just one thrust.  ");
			else if ((postCombat) && (player.vaginas[0].vaginalLooseness < 3))
				outputText("You nearly pass out from the pain as the " + phoukaName() + "'s cock drives deeper and deeper inside you.  With such a wide head forcing its way in, you're sure the stretching will be permanent.  ");
			else if (!postCombat || (player.cor > 50))
				outputText("Even as the invader thrusts deeper you push back against it. <i>“Good girl, ya love horse cock, don't ya?”</i> whispers the " + phoukaName() + ".  ");
			player.cuntChange(80, true);
			outputText("\n\n[if (isPregnant = true)You feel the head smack against your cervix, but with a child already inside your womb, there's no way for it to go any deeper.  The horse morph bears down on you in a futile attempt to force more of his length inside.][if (isPregnant = false)His cock finds your cervix and the horse morph pushes forward with his powerful hind legs.  You black out, you can't tell for how long, but when you awaken you can feel his cockhead and several inches of his thick shaft pulsing inside your womb.  Every time his heart beats you feel it along the veins that are being squeezed by your violated cervix.  He stops moving and sighs <i>“That's what I needed girly.”</i>]\n\n");
			if ((player.lust > 80) || (player.cor > 50))
				outputText("You pant and moan, waiting for the inevitable flood from his cantaloupe-sized nuts.  You're ready to get off just from the feeling of being so stuffed, so violated.");
			else {
				outputText("You whimper in pain, hoping the " + phoukaName() + " will soon be done with you.  ");
				if (player.isTaur())
					outputText("You feel so stretched and full.  What worries you is that the pain is giving way to pleasure.  Some base instinct of your centaur body is telling you that as a mare you were meant to be filled like this.  Your cunt was built for cocks like this so you could carry lots of little centaur foals.");
				else
					outputText("You're so stretched that your blood flow is being cut off and you can't feel [if (isNaga = true)the end of your tail][if (isNaga = false)your legs] anymore.");
			}
			outputText("  You feel those cum-stuffed balls twitch once, twice, three times.  The pressure must be building in the " + phoukaName() + "'s prostate.  He groans <i>“[if (isPregnant = true)Time te feed the baby.][if (isPregnant = false)Maybe today I'll leave ye a present.]”</i>  When he cums it's not a series of ripples moving up his urethra, it's a single long blast of stallion seed.");
			phoukaSexPregnate(postCombat);
		}

		protected function phoukaSexHorseChoice():void
		{
			phoukaSexHorse(false, false);
		}

		protected function phoukaSexFaerie(postCombat:Boolean):void
		{
			clearOutput();
			outputText("The faerie doesn't look like he's in any condition to refuse your orders.  You grab him by his tiny pointed ears to get his attention.  The " + phoukaName() + " looks startled.  A firm, commanding voice should be all you need to get what you want.  You let him know that you're in charge right now and you've decided you want to feel his cock inside your [vagOrAss].  The " + phoukaName() + " looks both surprised and worried. <i>“I... I don't know if I have the control right now,”</i> he sputters.  He concentrates for a moment, his form goes fuzzy, but then he snaps back.  You rub his cock and ask if he can manage just one change. <i>“Errr - maybe?”</i> As you stroke his inch long pecker, he furrows his brow and sure enough you see it begin to grow.  Then it deflates like a balloon.\n\nHe brushes your hand away. <i>“Just gimme a sec,”</i> he says, now determined to grow his cock.  You're beginning to wonder if that vein on his forehead is going to pop when suddenly his cock expands to be over a foot long.  Just as suddenly, it shrinks again and his balls expand.  Then, they shrink but his hips expands.  It's painful to look at.\n\nAfter another few moments all his parts stabilize and you're left looking at a much larger " + phoukaName() + ", about four and a half feet tall, with cock and balls both only slightly larger than those of a normal human. <i>“Huh”</i> he says, looking himself over, <i>“well that's new.  Didn't know I could do that.”</i> He tugs on his cock and fondles his balls, then declares, <i>“Yup, everything's workin,”</i> and smiles at you.\n\n");
			if (player.isTaur())
				outputText("You know you can’t really keep control of him.  Once he’s behind your rear legs he’ll be able to do whatever he wants.  Before he realizes that, you spin round and flick your tail at him.  He grins and slides his fingers over your rump.  You let your belly settle against the thick mire of the bog and your partner gently slides his cock inside you.  He must know a thing or two about centaurs thanks to being able to take the form of a stallion.  His fingers start to massage some sensitive areas on the insides of your rear thighs.  Then he starts to nibble at the base of your tail with his teeth.  You can’t help but moan and he takes that as a sign to pick up the pace.  Soon enough his human-sized cock is slamming in and out of your ");
			else
				outputText("Not wanting him to think he's an equal partner in all this, you shove him onto his back and [if (isNaga = true)coil your tail over][if (isNaga = false)straddle] your full sized faerie lover while you strip off the last of your armor.  You can feel his hot and hard cock rubbing against your [if (isNaga = true)scales][if (isNaga = false)ass].  Maybe this isn't getting through to him.  Oh well, you're primed for a good fuck anyway.  He's already leaked enough pre for lubrication so you guide his dick to your waiting [vagOrAss].\n\nThe " + phoukaName() + " thrusts upward, trying to spear you from the ground.  'No more of that' you think, planting one hand on his belly.  You lower yourself slowly onto the oversized faerie's cock, hoping to get more out of this than him.  Now that you're holding him down you set the pace.  You also control the angle of his cock, making sure it hits all the high notes inside your ");
			if (player.hasVagina()) {
				outputText("[vagina].");
				player.cuntChange(20, true);
				outputText("\n\nYou're getting closer and closer to cumming when you feel the " + phoukaName() + "'s cock twitch inside you.  The bastard is already there!");
				phoukaSexPregnate(true);
			}
			else {
				outputText("[butt].");
				player.buttChange(20, true);
				outputText("\n\nYou're loving the feeling of this faerie's cock sliding around inside your asshole.  In fact you're loving it so much that you're surprised when he thrusts upward and you feel his prick jerking and twitching.  Your colon starts to stretch as the " + phoukaName() + " pumps gallon after gallon into your accomodating asshole.  Your gut expands slightly, making you look slightly pregnant.  ");
				if (player.isTaur())
					outputText("You sigh in frustration as the " + phoukaName() + " pulls free from your ass, obviously about to leave.  He notices your condition and thinks better of it. <i>“Just gimme a sec.  I’ll get ye off,”</i> he says. <i>“After all, I do want ye to come back fer more.”</i>\n\nHe starts jacking himself off, whispering something to himself under his breath.  When his cock looks nice and hard he grabs your flanks and drives the full length back inside you.  As he pistons into your rectum, you feel that denied orgasm building and at last you cum.");
				else
					outputText("Not yet satisfied, you wait for the flood to stop, then begin to really ride your man-sized faerie.\n\nYou don't give him the chance to go soft.  Your [if (isNaga = true)tail][if (isNaga = false)legs] feel rubbery and your muscles are burning when you finally cum.");
				if (player.hasCock()) outputText("  [EachCock] fires several blasts of cum into the bog [if (isTaur = true)beneath you][if (isTaur = false)and all over your faerie partner].");
				outputText("\n\nYour sphincter clenches on the intruder, either trying to force it out or draw more in, even you can't say which.  You let out a sigh and put a hand on your belly, still heavy with a thick cum slurry.\n\nYou're just about to [if (isTaur = true)stand up when your partner thrusts forward][if (isTaur = false)roll off your spent partner when he thrusts upward] violently with his hips.  Caught off guard you try to steady yourself, only to feel his hands [if (isTaur = true)grip your flanks][if (isTaur = false)wrap around your waist].  The " + phoukaName() + " cums a second time, blasting another load of cum deep into your bowels.  Your stomach muscles are no match for this wave of spooge and [if (isTaur = true)you feel your heavy belly sink deeper into the bog][if (isTaur = false)you topple forward], stuffed with enough cum for anyone to assume you're pregnant with twins.  More than that you can feel each of the one-way valves in your gut give way, one after another, until a fountain of thick sugary sperm bubbles into your stomach.  If the " + phoukaName() + " had made one more deposit you probably would have tasted it.\n\nYour partner pushes on you, [if (isTaur = true)pulling his spent member from your rectum.  ][if (isTaur = false)rolling you off of him, wheezing, <i>“Air, air!”</i> ]He shrinks back to his normal size and recovers faster than you.  Before he leaves, he takes the time to pat your belly. <i>“Awful waste lad.  Go swallow an egg, a pink one.  That or suck down some o’ that succubi milk.  Then you come back here and I'll give you a real party.”</i>");
				dynStats("cor", rand(1) + 3); //Extra two corruption for being enough of a pervert to want to fuck the phouka
				if (postCombat) {
					kGAMECLASS.combat.clearStatuses(false);
					kGAMECLASS.combat.awardPlayer(); //This will provide loot and return to camp, 1 hour used
				}
				else doNext(camp.returnToCampUseOneHour); //Return to camp, 1 hour used
			}
		}
		
		protected function phoukaSexFaerieNonCombat():void
		{
			phoukaSexFaerie(false);
		}

		protected function phoukaSexFaeriePostCombat():void
		{
			phoukaSexFaerie(true);
		}

		protected function phoukaSexFaerieFemale(postCombat:Boolean):void
		{
			outputText("\n\nThe faerie doesn't look like he's in any condition to refuse your orders.  You grab him by his tiny pointed ears to get his attention.  The " + phoukaName() + " looks startled.  A firm, commanding voice should be all you need to get what you want.  You let him know that you're in charge right now and you're going to do unto others.  He looks confused, then realizes you intend to fuck him.  You ask if he can change shape into a woman, like the faeries in the forest.\n\n<i>“Yeah, I guess.  None of us phouka like doin’ that 'cause round here somebody always tries to fuck ya if ya got a cunt.”</i>");
			if (flags[kFLAGS.PHOUKA_LORE] == 0) flags[kFLAGS.PHOUKA_LORE] = 1; //Now you know what to call them
			outputText(" You point out to him that you are about to fuck him, cunt or no.  The phouka tries to backpedal but realizes he's not getting away from you.\n\n<i>“Okay, okay, just gimme a sec.”</i> He concentrates and you see his inch long cock begin to shrink.  Soon you've got a black skinned, black winged and black haired little faerie girl who wouldn't look too out of place in the forest.\n\n'He' looks a little uncomfortable so you ask him what's wrong. <i>“Ahem - it's ah, easier fer us to turn inta girls than the other way round.  I'll be like this fer hours, trying to hide out an' keep from gettin raped.”</i> Well isn't that too bad.  [if (corruption <= 50)Maybe some time as a woman will teach him a lesson][if (corruption > 50)You hope the little rapist gets fucked for hours on end.  It's what he deserves and you are certainly going to do your part].\n\nYou tell him you want more.  You want the most feminine faerie 'he' can be.  The phouka stares at you, but he knows he's beaten.  He closes his eyes and soon his breasts begin to swell up.  Both together couldn't fill a thimble, but on such a tiny body you would say they're B cups.\n\nWhen the phouka speaks again his rough voice has changed to the high pitched, melodious voice of a faerie as well. <i>“Okay, there.”</i> He sucks in his breath and his eyes go wide. <i>“HEY! I didn't wanna change my voice.  Oh crap... I'm rape bait!”</i> He’s right - by now anyone who met this phouka would see him as a very attractive and desirable faerie woman.  You [if (corruption <= 50)suppress][if (corruption > 50)let out] a snicker at her predicament and begin to rub your finger along her tiny cunt.  The phouka tilts her head back, losing herself in the sensation. <i>“Oh, p-please.  I can't take much more of that.  Please - I'm so sensitive as a girl.”</i> You feel fluids flood her pussy and you get the faerie to the edge of an orgasm.  Then you stop, holding her legs apart, and look into her lusty green eyes.\n\n<i>“Please let me cum, please sir!”</i> You ask how she intends to take your cock when her pussy is so small.  The faerie twists in your arms, trying desperately to rub her pussy against something and find release. <i>“Okay. Fine! I... I hope this works.”</i> Her eyes roll back in her head and her body begins to expand.  You lose your grip as her thighs balloon but it seems the phouka is concentrating so hard that she doesn't even notice her momentary freedom.  Her arms, legs, head and torso all stretch out and snap back at different times.  It's painful to watch, but she isn’t crying out in pain. She seems all right when she finally stops changing.\n\nWhen it’s over she's about four and a half feet tall and looks quite human overall.  Her features are delicate");
			if ((flags[kFLAGS.FREED_VALA] == 1) || (flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) || (flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON] > 0) || (flags[kFLAGS.INVESTIGATED_VALA_AFTER_ZETAZ_DEFEATED] > 0)) //If any of these is true you've had some contact with Vala
				outputText(" and she reminds you quite a bit of Vala, though Vala's chest is far larger.");
			else
				outputText(", but she still looks more human than most of the people you've met in Mareth.");
			outputText("\n\nThe most important thing to you right now is her sopping wet pussy, which looks most inviting.  While she lies there recovering you press your [cock biggest] against her hole.  Her eyes flutter open as you [if (isTaur = true)line your stallion prick up and push.  She slides along the ground on her back but then, to your surprise, she grabs your pole with her hands and presses the head against her muff, helping you impale her][if (isTaur = false)wrap your hands around her tiny waist and push]. <i>“Oh fuck - sooo big!”</i> she moans as you force open her pussy.  The walls of her vagina spasm around your cock and you realize she's already cumming.  Taking advantage, you rest most of your weight on your cock and slide several more inches inside.\n\n[if (isTaur = true)To your surprise the horny faerie girl’s][if (isTaur = false)The horny faerie wraps her twitching legs around you.  To your surprise her] orgasm just doesn't end.  Instead her whole body, inside and out, continues to spasm.  Your only proof it's an orgasm and not some kind of seizure is that she keeps moaning and screaming <i>“MORE!”</i>, <i>“YES!”</i> and sometimes <i>“FILL ME!”</i>\n\nThe constant squeezing and sucking of her elastic cunt feels as good as anything a succubus could do and soon enough you feel a familiar warmth in your [balls].  'Fill me' she begs you in an exhausted whisper.  You're only too happy to oblige this faerie fuckslut.  ");
			if (player.biggestCockLength() < 8)
				outputText("You push the last inch of your " + int(player.biggestCockLength()) + " prick into the moaning slut.");
			else if (player.biggestCockLength() < 15)
				outputText("You feed the last inch of your " + int(player.biggestCockLength()) + " cock into her.  Your cockhead bumps against her cervix and the slut beneath you begs for more.");
			else {
				outputText("You drive as much of your cock as you can into the little faerie slut, but there's just too much meat for her to take in.");
				if (player.cor <= 50)
					outputText("  It still feels amazing and you give her even more pleasure by rubbing your cockhead against her cervix.");
				else
					outputText("\n\n'Not good enough!' you think, pulling back for another attempt.  Using your massive erection as a battering ram you smash your cockhead against her cervix again and again.  The faerie screams, though you can't tell if that's from pleasure or pain.  Finally, on the fifth attempt, you feel the gateway to her womb give way.  With all your strength you [if (isTaur = true)push, driving her down into the mire.  She goes limp ][if (isTaur = false)pull on her waist.  She goes limp in your arms ]but your cock forces its way into her womb.");
			}
			outputText("\n\nAs you fill her with spurt after spurt of cum, you wonder if it's possible for her to get pregnant.  [if (corruption > 50)Of course, that's her problem now.  ][if (cumNormal = true)You feel your seed pooling around the head of your cock.][if (cumMedium = true)You feel your seed pooling around the head of your cock and running back along her tight channel.][if (cumHigh = true)You feel her innards stretching even more to accommodate your load.  The sight of her belly going from flat to slightly rounded makes you smile.][if (cumVeryHigh = true)Regardless, it's such a relief to empty your [balls].  The faerie girl inflates each time you inject her with another load.  Her once flat belly is now a rounded dome, like she's carrying a child.][if (cumExtreme = true)Regardless, it's such a relief to empty your [balls].  The faerie girl inflates each time you inject her with another load.  Her belly button pops out and her once flat belly now appears to be home to triplets.]\n\nThe phouka whimpers beneath you, still experiencing that single, long orgasm.  As you extract your cock, you wonder [if (corruption <= 50)what that must feel like][if (corruption > 50)how you could experience that for yourself].  [if (cumVeryHigh = true)A fountain of cum gushes out of her pussy, tinting the waters of the bog.  ][if (cumExtreme = true)A river of cum bursts from her snatch, tinting the waters of the bog.  ]Her orgasm finally over the phouka puts a hand on her belly. <i>“Ohhh, that felt so good.  I almost miss bein’ a lass.”</i> She tries to stand, but fails miserably. <i>“Shit - you might even be able to get me pregnant.  If I get knocked up I'm gonna be like this fer days!”</i> She looks over to you. <i>“Please help me - the others will rape me 'til I go nuts!”</i>\n\n");
			if (player.cor <= 33)
				outputText("You certainly don't want a phouka to learn where your campsite is.  You help her into the bushes and tell her she just needs to hide out for a few days.");
			else if (player.cor <= 66)
				outputText("You laugh and remind her that's what she's wanted to do to you.");
			else
				outputText("Why shouldn't the other phouka get the chance to enjoy her?  Before she can fully recover you grab some tree limbs and vines.  You pin her to the ground and use them to tie her up tight.  With her arms and legs lashed together and her ass in the air she's an inviting target.");
			outputText("  Satisfied, you march back to camp.");
			dynStats("cor", rand(1) + 3); //Extra two corruption for being enough of a pervert to want to fuck the phouka
			if (postCombat) {
				kGAMECLASS.combat.clearStatuses(false);
				kGAMECLASS.combat.awardPlayer();  //This will provide loot and return to camp, 1 hour used
			}
			else doNext(camp.returnToCampUseOneHour); //Return to camp, 1 hour used
		}

		protected function phoukaSexFaerieFemaleNonCombat():void
		{
			phoukaSexFaerieFemale(false);
		}

		protected function phoukaSexFaerieFemalePostCombat():void
		{
			phoukaSexFaerieFemale(true);
		}
		
		protected function phoukaSexPregnate(postCombat:Boolean):void
		{ //Whether by horse, bunny or (male) faerie sex it all ends up here if the PC has a vagina
			if (player.isPregnant()) {
				if (phoukaForm == PHOUKA_FORM_HORSE)
					outputText("\n\nYou just feel constant pressure against your sealed cervix.  The " + phoukaName() + "’s balls shows no signs of slowing down and the pressure continues to build.  Finally your vagina expands enough to allow an ocean of cum to jet out of you.");
				else
					outputText("\n\nGallons of warm cum blast against your cervix and then spray back out of your snatch.");
				if (player.cor > 50)
					outputText("  The feeling of all that seed flowing into you and then out of you again finally brings you to your own orgasm.[if (hasCock = true)  [EachCock] fires long strands of cum into the bog water beneath you.]");
				else
					outputText("  As the thick grey cum leaks from your cunt you finally give in and get yourself off.  There's no way you could have made it back to camp feeling like that.");
				if (phoukaForm == PHOUKA_FORM_FAERIE) outputText("\n\nNow that you've got your fill you [if (isTaur = true)pull away from][if (isTaur = false)roll off] your faerie lover.  He shrinks back to his normal size and launches himself into the air.  You're too tired to stop him from buzzing into the bushes and you quickly lose track of him.");
				phoukaSexPregnateEnd(postCombat);
				return;
			}
			if (phoukaForm == PHOUKA_FORM_HORSE)
				outputText("\n\nYou just feel constant pressure building inside your belly.  In moments you look nine months pregnant.  An unwholesome feeling of saccharine sweetness seems to permeate your whole body.  Your teeth feel like they're rotting from the root out.  The " + phoukaName() + " shows no signs of slowing down and the pressure continues to build.  Finally your womb can hold no more and the stallion seed leaks back out of your violated cervix.\n\nThe winded horse morph [if (isTaur = true)rubs the side of his head against your mane and asks you, <i>“Are ye ready to be my breeding mare? 'Cause I stuffed yer twat with enough seed fer a dozen babies.”</i>][if (isTaur = false)says, <i>“Well slut, I hope ye liked the feel of a real stallion cock.”</i> Then he whispers, <i>“The big question is how fertile is that spacious womb o' yours?”</i>]"); //Horse
			else
				outputText("\n\nGallons of warm cum force past your cervix and into your womb.  You start to feel sick to your stomach, like you've eaten way too much candy.  Your belly begins to expand and you feel the " + phoukaName() + "'s fingers running across the tightening flesh.  As your belly button pops out he laughs and asks you, <i>“What do ya think my chances are, slut?  How fertile is that big womb o' yours?”</i>");
			player.knockUp(PregnancyStore.PREGNANCY_FAERIE, PregnancyStore.INCUBATION_FAERIE);
			if (phoukaForm == PHOUKA_FORM_FAERIE) {
				outputText(" The " + phoukaName() + " may have cum, but his cock is still rock solid.  You ignore his comments and start rocking your hips faster, determined to get more enjoyment out of him than this. <i>“Yes missy, yes. That's right - cum fer me an drop an egg or two.”</i>\n\nYou can feel the cum sloshing around inside your womb, you can feel the sweet taste in the back of your throat, but you need more!  Finally you close your eyes and your whole body shudders as you cum.[if (hasCock = true)  [EachCock] fires long strands of cum into the bog and all over your faerie partner.]\n\nYour [vagina] goes to work milking the " + phoukaName() + "'s prick and you hear a moan of pleasure from the little monster.  You feel even greater pressure building inside your womb.  The clenching of your love tunnel has driven him over the edge and the " + phoukaName() + " is cumming again.  You try to [if (isTaur = true)pull away from][if (isTaur = false)lift yourself off] him, but another of your own orgasms hits.  When it’s over, you're left with a distended belly that wouldn't look out of place on a woman giving birth.  You roll onto your side and the enlarged faerie slides out of your box.  You hope most of that mess will leak out.  Instead you see only a few dribbles of thick grey cum ooze out of your pussy.");				
			}
			if ((!postCombat) || (player.cor > 50)) {
				if (phoukaForm == PHOUKA_FORM_HORSE)
					outputText(" The " + phoukaName() + " certainly got off, but you're still horny.  Despite the pain you begin working your body forward and back along his cock.  Your nerves have gone dull so you can't even feel most of his cock.  Luckily your cervix is still tight, so you can feel him there.\n\nThe " + phoukaName() + " stands still and begins to laugh. <i>“That's right, prove yer a slut fer stallions like me.  Cum for me bitch.”</i> Your belly wobbles obscenely as you move, the skin stretched tight and your belly button rubbing against the mud.  Finally your entire vagina, from lips to cervix, clenches down on his wonderful shaft.  You want nothing more than for this moment to continue, to be filled completely by this super-sized, fuckhole destroying horse-cock.[if (hasCock = true)  At the same time [eachCock] releases the cum that has been building up in your [balls].  The mud beneath you become warm and white.]");
				else { //BUNNY
					outputText(" Thankfully, the " + phoukaName() + " begins to rub his fingers against your clit.  Your orgasm causes your whole vagina to ripple as your body tries to draw even more sperm inside your belly.  [if (hasCock = true)[EachCock] fires long strands of cum uselessly into the bog.  ]");
					if (postCombat)
						outputText("The bastard " + phoukaName() + " laughs as you cum. <i>“Yeah, get nice and comfy while my seed takes root.  You lasses always love bein’ bred.”</i>");
					else outputText("Perhaps he's being a considerate lover or perhaps he just wants to better his chances of knocking you up.");
				}
			}
			else {
				if (phoukaForm == PHOUKA_FORM_HORSE)
					outputText(" You feel the " + phoukaName() + " lift one of his front legs [if (isNaga = true)and place it against your soft underbelly][if (isNaga = false)between your thighs].  You doubt a real horse's leg could bend that way, but the cursed shapeshifter manages it with ease.  He starts rubbing the smooth surface of his hoof against your clit until you can take no more.  Still impaled on his meaty mast, you can't even fight back.");
				else
					outputText(" To add insult to injury the " + phoukaName() + " starts to rub his fingers against your clit, forcing you to have an orgasm against your will.");
				outputText("  As he gets you off your abused cunt muscles try in vain to pull even more cum into your womb.  [if (hasCock = true)[EachCock] fires long strands of cum into the bog, wasting your seed in the lifeless waters.  ]You try to hold back tears that are half pain, half embarrassment at being so completely dominated by this perverted faerie.");
			}
			if (phoukaForm == PHOUKA_FORM_FAERIE)
				outputText("\n\nThe " + phoukaName() + "'s whole body deflates along with his cock.  You're too tired to stop him as he");
			else if (phoukaForm == PHOUKA_FORM_HORSE)
				outputText("\n\nThe black furred horse steps back, yanking his member out of your devastated cunt and transforms into a faerie.  He");
			else if (phoukaForm == PHOUKA_FORM_BUNNY)
				outputText("\n\nThe black furred bunny pulls out of you and shifts into the form of a faerie.  He");
			else
				outputText("\n\nHe");
			if (postCombat) outputText(" rummages around in your gem pouch and then");
			outputText(" takes to the air and hovers nearby as if waiting for something.\n\n");
			if (player.isPregnant()) {
				var isFirstTime:Boolean = (flags[kFLAGS.BIRTHS_PHOUKA] == 0) && (flags[kFLAGS.BIRTHS_FAERIE] == 0);
				flags[kFLAGS.PREGNANCY_CORRUPTION] = 2; //Start off with a corrupt little phouka. It will take three drinks of pure honey to turn it into a faerie
				outputText("You're about to lift yourself up when you feel " + (isFirstTime ? "an unusual" : "a familiar") + " sensation inside your belly.  All that cum is hardening!  You can feel it set, almost like mortar left out in the sun!  You stand and some clear water drains out, your belly shrinking in size to that of a watermelon.  Whatever's left inside your belly is solid, like you're carrying a smooth ball of wood inside you.\n\nYou run a hand over your belly.  Thankfully it isn't any heavier than a normal pregnancy, nor does it hurt at all.\n\n<i>“Yes!”</i> shouts the " + phoukaName() + ". <i>“I'm gonna be a daddy!  Thanks fer letting me fill ya up girl, there’s plenty o’ space in there fer the little guy.  I gotta tell all the other phouka about ya");
				if (flags[kFLAGS.PHOUKA_LORE] == 0) flags[kFLAGS.PHOUKA_LORE] = 1; //Now you know what to call them
				if (!postCombat || (player.cor > 50)) outputText(", yer a real prize slut");
				outputText(".”</i> The phouka gains more altitude and flies off deeper into the bog, whistling happily to himself.  ");
				if (isFirstTime)
					outputText("You have to wonder how long this pregnancy will last. If this were a human child people would judge you to be at least four months along.");
				else outputText("At least you know what to expect from this form of pregnancy now.");
			}
			else outputText("When you pull yourself up your belly begins to deflate and leak its gooey grey payload into the mud.  The " + phoukaName() + " says <i>“Ah well, there's always next time,”</i> and buzzes away to some other part of the bog.");
			phoukaSexPregnateEnd(postCombat);
		}
		
		protected function phoukaSexPregnateEnd(postCombat:Boolean):void
		{ //Everything after the sex. Handles awards, gem loss and text for player leaving the bog
			player.orgasm();
			dynStats("cor", rand(1) + (postCombat && (phoukaForm != PHOUKA_FORM_FAERIE) ? 1 : 3)); //Extra two corruption for being enough of a pervert to want to fuck the phouka
			if (phoukaForm == PHOUKA_FORM_FAERIE) { //In this case postCombat means you need an award because you must have won to get faerie sex
					outputText("\n\nSatisfied for now you begin to put your clothes back on.  Maybe that " + phoukaName() + " will learn, maybe not.");
					if (player.cor > 50) outputText("  But either way you plan to return and give all of them that lesson.");
					if (postCombat) {
						kGAMECLASS.combat.clearStatuses(false);
						kGAMECLASS.combat.awardPlayer();  //This will provide loot and return to camp, 1 hour used
					}
					else doNext(camp.returnToCampUseOneHour); //Return to camp, 1 hour used
			}
			else {
				if (postCombat && player.gems > 0) outputText("  While you're recovering the " + phoukaName() + " reaches into your gem pouch and takes a handful.");
				outputText("\n\nNow that it's finished with you the " + phoukaName() + " shrinks back down into a small black faerie and buzzes off to some other part of the bog.");
				outputText("\n\nYou ");
				if (phoukaForm == PHOUKA_FORM_HORSE && !player.isTaur()) outputText("wait for the throbbing pain in your pelvis to subside.  Then you ");
				if (postCombat) {
					outputText("pull your [if (isNaga = true)tail][if (isNaga = false)legs] free from the cool muck before you get chilled to the bone.");
					combat.cleanupAfterCombat();
				}
				else {
					outputText("collect your clothes and begin the long march out of the bog.  ");
					doNext(camp.returnToCampUseOneHour); //Return to camp, 1 hour used
				}
				if (player.cor <= 50)
					outputText("As you trudge back to camp you have to wonder - why did you decide to visit the bog again?");
				else if (phoukaForm == PHOUKA_FORM_HORSE && player.isTaur())
					outputText("  It was quite the ride and you find yourself looking forward to your next trip into the bog.");
				else outputText("Not what you expected, but at least you got off.");
			}			
		}

	}
}
