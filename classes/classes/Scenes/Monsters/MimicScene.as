//Mimic, one of the classic encounters from Unnamed Text Game, now modified to be up to modern standards, with new fight.
package classes.Scenes.Monsters 
{
	import classes.BaseContent;
	import classes.PerkLib;
	import classes.GlobalFlags.*;
	import classes.Scenes.Monsters.Mimic;
	
	public class MimicScene extends BaseContent
	{
		public var mimicAppearance:int;
		
		public function MimicScene() {}
			
		public function mimicTentacleStart(loc:int = 0):void {
			clearOutput();
			//Random appearance :D
			mimicAppearance = rand(4);
			//lead in based on where the event occurs
			//desert = 1, mountain = 2, forest = anything else, 
			if (loc == 1) outputText("The wind howls through the tall pillars of rock that thrust out of the sand on both sides ", true);
			else if (loc == 2) outputText("Thunder rumbles overhead ", true);
			else if (loc == 3) outputText("The peaceful sounds of nature are everywhere ", true);
			outputText("as you explore deeper into this strange land. The relative monotony of your journey is interrupted as you see ", false);
			//1 = giant rock, 2 = giant boob, 3 = giant dick, everything else = a treasure chest
			if (mimicAppearance == 1) outputText("a huge block of grey stone covered in bizarre runes and symbols ", false);
			else if (mimicAppearance == 2) outputText("what can only be described as an enormous, disembodied… boob ", false);
			else if (mimicAppearance == 3) outputText("what is unmistakably an enormous, flaccid penis, complete with gigantic balls, ", false);
			else outputText("a large wooden box with a hinged lid and tarnished brass fittings ", false);
			outputText("nestled in a shady alcove.\n\n",false);
			//Check if you're smart enough to even think about it
			if (rand(18) + (player.inte / 2) < 15) {
				outputText("You are entranced by the sight of ", false);
				if (mimicAppearance == 1) outputText("a magic rock", false);
				else if (mimicAppearance == 2) outputText("a giant boob", false);
				else if (mimicAppearance == 3) outputText("a huge penis", false);
				else outputText("what is clearly a treasure chest", false);
				outputText(". Ignoring the sad remnants of your better judgment, you walk over. ", false);
				doNext(mimicTentacle1); //call mimicTentacle1()
			}
			else {
				if (mimicAppearance == 1) outputText("While a magic rock ", false);
				else if (mimicAppearance == 2) outputText("While a giant boob ", false);
				else if (mimicAppearance == 3) outputText("While a huge penis ", false);
				else outputText("While what is clearly a treasure chest ", false);
				outputText("certainly warrants further investigation, you aren’t absolutely sure that this is the best idea. Do you choose to investigate? ", false);
				doYesNo(mimicTentacle1, camp.returnToCampUseOneHour); //call mimicTentacle1() or return to main screen
			}	
		}

		public function mimicTentacle1():void
		{
			outputText("You approach within a few feet of the ", true);
			if (mimicAppearance == 1) outputText("stone ", false);
			else if (mimicAppearance == 2) outputText("huge tit ", false);
			else if (mimicAppearance == 3) outputText("giant dick ", false);
			else outputText("chest ", false);
			//d100 roll (0-99) + inte/3 vs 75
			if (rand(100) + Math.floor(player.inte / 1.5) >= 80) {
				//another d100 roll + inte/3 vs only 50 this time
				if (rand(player.inte) + Math.floor(player.inte / 3) >= 50 + player.newGamePlusMod() * 10) {
					//find a cool item!
					outputText("and begin to reach towards it. However, just as you begin to move your hand, the… thing gives a strange shudder and emits a bizarre, snorting sound. You quickly realize that not only is this some kind of creature, but you have somehow come upon it while it sleeps! As you begin to slowly back away, you notice a ", false);
					var itemRoll:int = rand(4);
					if (itemRoll == 0) outputText("glinting silver vial ",false);
					if (itemRoll == 1) outputText("small sack ", false);
					if (itemRoll == 2) outputText("large glass bottle ", false);
					if (itemRoll == 3) outputText("small clay jar ", false);
					outputText("in a pile of rubbish off to one side of the alcove. Careful not to disturb the… whatever it is, you grab the ", false);
					if (itemRoll == 0) outputText("vial ",false);
					if (itemRoll == 1) outputText("sack ", false);
					if (itemRoll == 2) outputText("bottle ", false);
					if (itemRoll == 3) outputText("jar ", false);
					outputText("and leave the monster to its slumber. ", false);
					if (itemRoll == 0) inventory.takeItem(consumables.PPHILTR, camp.returnToCampUseOneHour); //find purity philter
					if (itemRoll == 1) findSomeGems(); //find bag o gems
					if (itemRoll == 2) inventory.takeItem(consumables.NUMBOIL, camp.returnToCampUseOneHour); //find numbing oil
					if (itemRoll == 3) inventory.takeItem(consumables.HUMMUS_, camp.returnToCampUseOneHour); //find Hummanus
					return;
				} 
				else { //you just escape, no fancy item!
					outputText("and slowly reach towards it with one hand. As your fingers hover within inches of touching it, you feel a sudden sense of danger, and leap back just as dozens of tentacles sprout from the thing's surface. The strange creature lunges for you again, but you have already escaped its reach and, to your great relief, it appears to be immobile. ", false);
					doNext(camp.returnToCampUseOneHour); //main screen
					return;
				}
			}
			else { //if you're dumb or fail, FIGHT!
				outputText("and slowly reach out to touch it with one hand. You get a sense that something is terribly wrong when you realize that your hand is stuck fast to the ", false);
				if (mimicAppearance == 1) outputText("stone's surface! ", false);
				else if (mimicAppearance == 2) outputText("enormous boob's skin! ", false);
				else if (mimicAppearance == 3) outputText("enormous cock's skin! ", false);
				else outputText("box's surface! ", false);
				outputText("As you struggle to pull your hand free, the monster, for that is clearly what it is, opens its beady little eyes and stares at you hungrily. ", false);
				outputText("\n\n", false);
				//It grabs you!
				if (mimicAppearance == 1) outputText("An enormous maw opens in front of you, lined with huge rocky teeth. Dozens of tentacles shoot out of the things gaping mouth, and you scream with terror as they begin to drag you into its rocky gullet. ", false);
				else if (mimicAppearance == 2) outputText("The enormous nipple opens wide to reveal a lamprey like mouth lined with hundreds of tiny pointy teeth and thin, whippy tongues shoot out and splatter milky saliva everywhere as they flail back and forth. Dozens of tentacles sprout from its quivering bulk and wrap around your limbs and waist, lifting you into the air. ", false);
				else if (mimicAppearance == 3) outputText("The monstrous cock rears up like a snake and a emits a horrible hissing garble as what would be its urethral opening splits open to reveal row after row of tiny, pointy teeth. Thin, whippy tongues shoot out and splatter gooey cum-spit everywhere as they flail back and forth. Dozens of tentacles sprout from its shaft and wrap around your limbs and waist, lifting you into the air. ", false);
				else outputText("The lid of the chest opens to reveal a giant mouth, filled with hundreds of tiny pointy teeth and a huge slavering tongue that lashes about wildly. Dozens of tentacles shoot out of the thing's gaping jaws, and you scream with terror as they begin to drag you into its gullet. ", false);
				outputText("\n\nYou shake and break free from the tentacles. It's a fight!");
				//Start the FIGHT!
				startCombat(new Mimic(mimicAppearance));
			}
			doNext(camp.returnToCampUseOneHour); //Failsafe
		}

		//If you lose to Mimic.
		public function mimicTentacle2():void
		{
			var tempSize:Number = Math.round((player.averageNippleLength() + player.cocks[0].cockLength / 2) * 100) / 100;
			var nippleCockDescript:String = player.nippleDescript(0);
			//If its a box or a rock, it swallows you whole!
			if (mimicAppearance != 2 && mimicAppearance != 3) outputText("\n\nWith you collapsing from being unable to put up any further fight, you are unable to prevent yourself from being dragged into the thing’s enormous maw. You are pulled deeper and deeper into the monster’s surprisingly vast innards, and the light streaming in through its jaws grows more and more faint, until with a final <i>*snap*</i>, the light is cut off completely. Surrounded by total darkness and gripped by what must be hundreds of tentacles, you let loose an involuntary moan of terror as the finality of your fate sinks home. ", false);
			outputText("You feel hundreds of tiny tendrils begin gently stroking and teasing your whole body. They seem to seek out every erogenous zone you have with unnatural precision. In a matter of minutes, you are quaking with arousal, ", true);
			//no parts!
			if (player.gender == 0)
			{
				outputText("but your crotch remains smooth and featureless. You sense that the creature is becoming angry with your genderless state, ", false);
				//nipplecocks?
				if (player.breastRows[0].nippleCocks)
				{
					outputText("but before it does something rash, your " + nippleCockDescript + " " + tempSize + " inch nipplecocks grow painfully erect, throbbing in time with your racing heart. The creature burbles appreciatively, clearly glad that you have something to offer. ", false);
					if (mimicAppearance == 2 || mimicAppearance == 3)
					{
						outputText("The tentacles move your torso towards the thing’s toothy maw, and with mounting terror, you realize that it intends to suck all of your throbbing dicknipples into its nightmare hole of a mouth! As the echoes of your screams finally die away, you realize that your breasts are still intact, and that the horrible looking teeth are actually fairly soft. However, you quickly understand their purpose when they dig painfully into your tits as you attempt to pull them free. ", false);
					}
					else
					{
						outputText("You feel some kind of tentacle collect ", false);
						if (player.totalBreasts() * player.breastRows[0].nipplesPerBreast == 2) outputText("both of your " + nippleCockDescript + " dicknipples and engulf them in some kind of orifice. ", false);
						else outputText("every single one of your " + int(player.totalBreasts() * player.breastRows[0].nipplesPerBreast) + " " + nippleCockDescript + " dicknipples into a big bundle and engulf them all in a single large orifice. ", false);
					}
					outputText("\n\nThe ", false);
					//Mouth or suckers?
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("creature's mouth begins ", false);			
					else outputText("mouth-tentacle begins ", false);
					outputText("to suck and massage your cockteats with a sort of spinning motion. The combined sensations from that and the countless other tendrils quickly bring you to orgasm, causing you to spew unusually large amounts of ", false);
					if (player.breastRows[0].lactationMultiplier > 0) outputText("milky ", false);
					outputText("cum deep into the creatures hungry mouth. Unfortunately, the beast doesn’t seem satisfied with just one emission, and its ministrations become more forceful as you are made to cum again and again. Far beyond the limits of your endurance, you still manage to hold on to some last shred of consciousness. Even as dozens of small tendrils are forced into your tortured nippledicks in search of more cum, your only reaction is a weak moan. As the thing continues to alternate between scouring your body for any last traces of semen and attempting to coax you to further orgasm, you eventually slip into unconsciousness. ", false);
					//if you didnt get swallowed earlier, get swallowed now
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("\n\nJust before you black out, you look up to see yourself being lifted towards the beast’s suddenly huge, gaping maw. ", false);
				}
				//nipplecunts?
				if (player.hasFuckableNipples())
				{
					outputText("but before it does something rash, the ", false);
					//describe nipplecunts based on vag looseness
					if (player.vaginas[0].vaginalLooseness < 2) outputText("small openings ", false);
					if (player.vaginas[0].vaginalLooseness >= 2 && player.vaginas[0].vaginalLooseness < 4) outputText("puckered openings ", false);
					if (player.vaginas[0].vaginalLooseness >= 4) outputText("engorged lips ", false);
					outputText("on your nipples to ease open and begin ", false);
					//wetness + milkyness :P
					if (player.vaginas[0].vaginalWetness < 2) outputText("dripping ", false);
					if (player.vaginas[0].vaginalWetness >= 2 && player.vaginas[0].vaginalWetness < 4) outputText("drooling ", false);
					if (player.vaginas[0].vaginalWetness >= 4) outputText("spurting ", false);
					if (player.breastRows[0].lactationMultiplier > 0) outputText("milky ", false);
					outputText("fluids. The monster makes a surprised but appreciative gurgle as it begins to use its ", false);
					//what kind of tongue? box or rock = huge, boob/dick = whippy
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("long, whippy tongues ", false);
					else outputText("gigantic tongue", false);
					outputText("to slurp at this new bounty.\n\nYour mind reels as ", false);
					//what kind of tongue? box or rock = huge, boob/dick = whippy
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("the seemingly uncountable number of tongues and tendrils slurp, stroke, and suck at your breasts. ", false);
					else 
					{
						outputText("the monster’s huge tongue covers the entire front of your body, dragging its bumpy, slick surface over your ", false);
						if (player.totalBreasts() > 2) outputText(player.totalBreasts() + " ", false);
						outputText("breasts in long strokes. ", false);
					}
					outputText("You orgasm again and again, far beyond the limits of your endurance. Yet you still hold on to some last shred of consciousness. The creature’s ministrations become more forceful, but you’re too far gone to care. Even when the creature shoves ", false);
					//what kind of tongue? box or rock = huge, boob/dick = whippy
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("what must be two dozen of its wriggling tongues deep into each of your tortured nippples, exploring every nook and crevice", false);
					else outputText("its huge tongue deep into each of your tortured nipples one by one", false);
					outputText(", your reaction is only a weak moan. ", false);
					outputText("As the thing continues to alternate between scouring your body for any last traces of nectar and attempting to coax you to further orgasm, you eventually slip into unconsciousness. ", false);
					//if you didnt get swallowed earlier, get swallowed now
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("\n\nJust before you black out, you look up to see yourself being lifted towards the beast’s suddenly huge, gaping maw. ", false);
				}
				//just a boring, genderless freak?
				if (!player.breastRows[0].nippleCocks && !player.hasFuckableNipples())
				{
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("and its eyes narrow, giving it a singularly furious expression. ", false);
					else outputText("and the tentacles holding you seem to quiver with a palpable fury. ", false);
					outputText("\n\nWithout warning, hundreds of tentacles begin whipping and beating you violently. You try to scream, but your shouts are cut off by a punishing series of blows to the stomach. Your ears are filled with the monster's burbling roars of fury as you are pummeled into unconsciousness. ", false);
					//if you didnt get swallowed earlier, get swallowed now
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("\n\nJust before you black out, you look up to see yourself being lifted towards the beast’s suddenly huge, gaping maw. ", false);
				}
			}
			//Man parts!
			if (player.gender == 1)
			{		
				outputText("and your ", false);
				if (player.cockTotal() == 1) outputText(player.cockDescript() + " is ", false);
				else outputText(player.multiCockDescript() + " are ", false);
				outputText("soon rock hard. ", false);
				//did it swallow you, or does it have a mouth?
				if (mimicAppearance == 2 || mimicAppearance == 3)
				{
					outputText("The tentacles move your crotch towards the thing’s toothy maw, and with mounting terror, you realize that it intends to suck your throbbing dick", false);
					if (player.cockTotal() > 1) outputText("s", false);
					outputText(" into its nightmare hole of a mouth! As the echoes of your screams finally die away, you realize that your junk is still intact, and that the horrible looking teeth are actually fairly soft. However, you quickly understand their purpose when they dig painfully into your cock", false);
					if (player.cockTotal() == 1) outputText(" as you attempt to pull it free. ", false);
					else outputText("s as you attempt to pull them free. ", false);
				}
				else
				{
					outputText("You feel some kind of orifice enveloping ", false);
					if (player.cockTotal() == 1) outputText("your " + player.cockDescript() + ". ", false);
					else outputText("all of your cocks at once. ", false);
				}
				//Do you have dicknipples?
				if (player.breastRows[0].nippleCocks)
				{
					outputText("\n\nMeanwhile, the tiny tendrils continue to stimulate the rest of your body, causing your " + nippleCockDescript + " " + tempSize + " inch nipplecocks to grow painfully erect, throbbing in time with your racing heart. The creature lets loose an irritated burble", false);
					//if not swallowed
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText(", and you see its eyes narrow with anger", false);
					outputText(". It seems to be annoyed that you would dare sprout more cocks in such an inconvenient location! Your affront is dealt with quickly as your errant dicknipples are engulfed in hastily sprouted sucker tentacles. ", false);
				}
				//back to the main action!
				outputText("\n\nThe ", false);
				//Mouth or suckers?
				if (mimicAppearance == 2 || mimicAppearance == 3) 
				{			
					if (player.breastRows[0].nippleCocks) outputText("creature's mouths begin ", false);
					else outputText("creature's mouth begins ", false);			
				}
				else 
				{
					if (player.breastRows[0].nippleCocks) outputText("mouth-tentacles begin ", false);
					else outputText("mouth-tentacle begins ", false);
				}
				outputText("to suck and massage your cock", false);
				if (player.cockTotal() > 1 || player.breastRows[0].nippleCocks) outputText("s", false);
				outputText(" with a sort of spinning motion. The combined sensations from that and the countless other tendrils quickly bring you to orgasm, causing you to spew unusually large amounts of cum deep into the creatures hungry mouth",false);
				if (player.breastRows[0].nippleCocks) outputText("s", false);
				outputText(". Unfortunately, the beast doesn’t seem satisfied with just one emission, and its ministrations become more forceful as you are made to cum again and again. Far beyond the limits of your endurance, you still manage to hold on to some last shred of consciousness. Even as dozens of small tendrils are forced down your urethra", false);
				if (player.cockTotal() > 1 || player.breastRows[0].nippleCocks) outputText("s", false);
				outputText(" in search of more cum, your only reaction is a weak moan. As the thing continues to alternate between scouring your body for any last traces of semen and attempting to coax you to further orgasm, you eventually slip into unconsciousness. ", false);
				//if you didnt get swallowed earlier, get swallowed now
				if (mimicAppearance == 2 || mimicAppearance == 3) outputText("\n\nJust before you black out, you look up to see yourself being lifted towards the beast’s suddenly huge, gaping maw. ", false);
			}
			//Girl Parts!
			if (player.gender == 2)
			{
				outputText("and your " + player.vaginaDescript(), false);
				if (player.vaginas.length > 1) outputText("s are ", false);
				else outputText(" is ", false);
				//wetnesssss
				if (player.vaginas[0].vaginalWetness < 2) outputText("dripping ", false);
				if (player.vaginas[0].vaginalWetness >= 2 && player.vaginas[0].vaginalWetness < 4) outputText("drooling ", false);
				if (player.vaginas[0].vaginalWetness >= 4) outputText("spurting ", false);
				outputText("juices everywhere. The thing's ", false);
				//what kind of tongue? box or rock = huge, boob/dick = whippy
				if (mimicAppearance == 2 || mimicAppearance == 3) outputText("thin, whippy tongues run", false);
				else outputText("huge tongue runs", false);
				outputText(" across your " + player.vaginaDescript(), false);
				if (player.vaginas.length > 1) outputText("s", false);
				outputText(", and you hear the creature burble with satisfaction. It clearly likes the taste. ", false);
				//do you have fuckable nipples?
				if (player.hasFuckableNipples())
				{
					outputText("\n\nMeanwhile, the tiny tendrils continue to stimulate the rest of your body, causing the ", false);
					//describe nipplecunts based on vag looseness
					if (player.vaginas[0].vaginalLooseness < 2) outputText("small openings ", false);
					if (player.vaginas[0].vaginalLooseness >= 2 && player.vaginas[0].vaginalLooseness < 4) outputText("puckered openings ", false);
					if (player.vaginas[0].vaginalLooseness >= 4) outputText("engorged lips ", false);
					outputText("on your nipples to ease open and begin ", false);
					//wetness + milkyness :P
					if (player.vaginas[0].vaginalWetness < 2) outputText("dripping ", false);
					if (player.vaginas[0].vaginalWetness >= 2 && player.vaginas[0].vaginalWetness < 4) outputText("drooling ", false);
					if (player.vaginas[0].vaginalWetness >= 4) outputText("spurting ", false);
					if (player.breastRows[0].lactationMultiplier > 0) outputText("milky ", false);
					outputText("fluids. The monster makes a surprised but appreciative gurgle as it begins to use its ", false);
					//what kind of tongue? box or rock = huge, boob/dick = whippy
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("cluster of newly sprouted tongues ", false);
					else outputText("seemingly <i>even larger</i> tongue ", false);
					outputText("to slurp at this new bounty. ", false);
				}
				//back to the main action!
				outputText("\n\nYour mind reels as ", false);
				//what kind of tongue? box or rock = huge, boob/dick = whippy
				if (mimicAppearance == 2 || mimicAppearance == 3) 
				{
					outputText("the seemingly uncountable number of tongues and tendrils slurp, stroke, and suck at your " + player.vaginaDescript(), false);
					if (player.vaginas.length > 1) outputText("s", false); 
					outputText(" and " ,false);
					if (player.totalBreasts() > 2) outputText(player.totalBreasts() + " ", false);
					outputText("breasts. ", false);
				}
				else 
				{
					outputText("the monster’s huge tongue covers your crotch and the entire front of your body, dragging its bumpy, slick surface over ", false);
					if (player.vaginas.length == 1) outputText("your " + player.vaginaDescript(), false); 
					else outputText("all of your " + player.vaginaDescript() + "s", false);
					outputText(" and " ,false);
					if (player.totalBreasts() > 2) outputText(player.totalBreasts() + " ", false);
					outputText("breasts in long strokes. ", false);
				}
				outputText("You orgasm again and again, far beyond the limits of your endurance. Yet you still hold on to some last shred of consciousness. The creature’s ministrations become more forceful, but you’re too far gone to care. Even when the creature shoves ", false);
				//what kind of tongue? box or rock = huge, boob/dick = whippy
				if (mimicAppearance == 2 || mimicAppearance == 3) 
				{
					outputText("what must be two dozen of its wriggling tongues deep into ", false);
					if (player.vaginas.length == 1) outputText("your " + player.vaginaDescript(), false); 
					else outputText("each of your " + player.vaginaDescript() + "s", false);
					outputText(", exploring every nook and crevice", false);
				}
				else
				{
					outputText("its huge tongue deep into ", false);
					if (player.vaginas.length == 1) outputText("your " + player.vaginaDescript(), false); 
					else outputText("each of your " + player.vaginaDescript() + "s one by one", false);
				}
				outputText(", your reaction is only a weak moan. ", false);
				if (player.hasFuckableNipples()) outputText("Your moan drags out a bit longer as your poor nipples receive the same treatment. ", false);
				outputText("As the thing continues to alternate between scouring your body for any last traces of nectar and attempting to coax you to further orgasm, you eventually slip into unconsciousness. ", false);
				//if you didnt get swallowed earlier, get swallowed now
				if (mimicAppearance == 2 || mimicAppearance == 3) outputText("\n\nJust before you black out, you look up to see yourself being lifted towards the beast’s suddenly huge, gaping maw. ", false);
			}
			//Futaz!
			if (player.gender == 3)
			{		
				outputText(" your " + player.vaginaDescript(), false);
				if (player.vaginas.length > 1) outputText("s", false);
				//wetnesssss
				if (player.vaginas[0].vaginalWetness < 2) outputText(" dripping ", false);
				if (player.vaginas[0].vaginalWetness >= 2 && player.vaginas[0].vaginalWetness < 4) outputText(" drooling ", false);
				if (player.vaginas[0].vaginalWetness >= 4) outputText(" spurting ", false);
				outputText("juices everywhere while your ", false);
				if (player.cockTotal() == 1) outputText(player.cockDescript() + " rapidly becomes ", false);
				else outputText(player.multiCockDescript() + " rapidly become ", false);
				outputText("rock hard. Your eyes roll back in your head as the thing's ", false);
				//what kind of tongue? box or rock = huge, boob/dick = whippy
				if (mimicAppearance == 2 || mimicAppearance == 3) outputText("thin, whippy tongues run", false);
				else outputText("huge tongue runs", false);
				outputText(" across your " + player.vaginaDescript(), false);
				if (player.vaginas.length > 1) outputText("s", false);
				outputText(". ", false);
				outputText("You feel some kind of orifice enveloping ", false);
				if (player.cockTotal() == 1) outputText("your " + player.cockDescript() + ". ", false);
				else outputText("all of your cocks at once. ", false);
				//fun with tits?
				if (player.breastRows[0].nippleCocks || player.hasFuckableNipples()) outputText("\n\nMeanwhile, the tiny tendrils continue to stimulate the rest of your body, causing ", false);
				//do you have fuckable nipples?
				if (player.hasFuckableNipples())
				{
					//describe nipplecunts based on vag looseness
					if (player.vaginas[0].vaginalLooseness < 2) outputText("the small openings ", false);
					if (player.vaginas[0].vaginalLooseness >= 2 && player.vaginas[0].vaginalLooseness < 4) outputText("the puckered openings ", false);
					if (player.vaginas[0].vaginalLooseness >= 4) outputText("the engorged lips ", false);
					outputText("on your nipples to ease open and begin ", false);
					//wetness + milkyness :P
					if (player.vaginas[0].vaginalWetness < 2) outputText("dripping ", false);
					if (player.vaginas[0].vaginalWetness >= 2 && player.vaginas[0].vaginalWetness < 4) outputText("drooling ", false);
					if (player.vaginas[0].vaginalWetness >= 4) outputText("spurting ", false);
					if (player.breastRows[0].lactationMultiplier > 0) outputText("milky ", false);
					outputText("fluids. The monster makes a surprised but appreciative gurgle as it begins to use its ", false);
					//what kind of tongue? box or rock = huge, boob/dick = whippy
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText("cluster of newly sprouted tongues ", false);
					else outputText("seemingly <i>even larger</i> tongue ", false);
					outputText("to slurp at this new bounty. ", false);
				}
				//do you have nipplecocks?
				if (player.breastRows[0].nippleCocks)
				{
					outputText("your " + nippleCockDescript + " " + tempSize + " inch nipplecocks to grow painfully erect, throbbing in time with your racing heart. The creature lets loose an irritated burble", false);
					//if not swallowed
					if (mimicAppearance == 2 || mimicAppearance == 3) outputText(", and you see its eyes narrow with anger", false);
					outputText(". It seems to be annoyed that you would dare sprout more cocks in such an inconvenient location! Your affront is dealt with quickly as your errant dicknipples are engulfed in hastily sprouted sucker tentacles. ", false);
				}
				//back to the main action!
				outputText("\n\nYour mind reels as ", false);
				//what kind of tongue? box or rock = huge, boob/dick = whippy
				if (mimicAppearance == 2 || mimicAppearance == 3) 
				{
					outputText("the seemingly uncountable number of tongues and tendrils slurp, stroke, and suck at your " + player.vaginaDescript(), false);
					if (player.vaginas.length > 1) outputText("s", false); 
					outputText(" and " ,false);
					if (player.totalBreasts() > 2) outputText(player.totalBreasts() + " ", false);
					outputText("breasts while the ", false);
					if (player.breastRows[0].nippleCocks) outputText("creature's mouths begin ", false);
					else outputText("creature's mouth begins ", false);			
				}
				else 
				{
					outputText("the monster’s huge tongue slithers over your crotch, around your ", false);
					if (player.cockTotal() == 1 && !player.hasSheath()) outputText("cock, ", false);
					else if (!player.hasSheath()) outputText("bundle of cocks, ", false);
					else outputText("sheath, ", false);
					outputText("and up the entire front of your body, dragging its bumpy, slick surface over ", false);
					if (player.vaginas.length == 1) outputText("your " + player.vaginaDescript(), false); 
					else outputText("all of your " + player.vaginaDescript() + "s", false);
					outputText(" and " ,false);
					if (player.totalBreasts() > 2) outputText(player.totalBreasts() + " ", false);
					outputText("breasts in long strokes while the ", false);
					if (player.breastRows[0].nippleCocks) outputText("mouth-tentacles begin ", false);
					else outputText("mouth-tentacle begins ", false);
				}
				outputText("to suck and massage your cock", false);
				if (player.cockTotal() > 1 || player.breastRows[0].nippleCocks) outputText("s", false);
				outputText(" with a sort of spinning motion.", false);
				outputText("You orgasm again and again, far beyond the limits of your endurance. Yet you still hold on to some last shred of consciousness. The creature’s ministrations become more forceful, but you’re too far gone to care. Even when the creature shoves ", false);
				//what kind of tongue? box or rock = huge, boob/dick = whippy
				if (mimicAppearance == 2 || mimicAppearance == 3) 
				{
					outputText("what must be two dozen of its wriggling tongues deep into ", false);
					if (player.vaginas.length == 1) outputText("your " + player.vaginaDescript(), false); 
					else outputText("each of your " + player.vaginaDescript() + "s", false);
					outputText(", exploring every nook and crevice, ", false);
				}
				else
				{
					outputText("its huge tongue deep into ", false);
					if (player.vaginas.length == 1) outputText("your " + player.vaginaDescript(), false); 
					else outputText("each of your " + player.vaginaDescript() + "s one by one", false);
					
				}
				outputText(" while dozens of small tendrils are forced down your urethra", false);
				if (player.cockTotal() > 1 || player.breastRows[0].nippleCocks) outputText("s", false);
				outputText(" in search of more cum, your reaction is only a weak moan. ", false);
				if (player.hasVagina()) player.cuntChange(60, true);
				if (player.hasFuckableNipples()) outputText("Your moan drags out a bit longer as your poor nipples receive the same treatment. ", false);
				outputText("As the thing continues to alternate between scouring your body for any last traces of fluid and attempting to coax you to further orgasm, you eventually slip into unconsciousness. ", false);
				//if you didnt get swallowed earlier, get swallowed now
				if (mimicAppearance == 2 || mimicAppearance == 3) outputText("\n\nJust before you black out, you look up to see yourself being lifted towards the beast’s suddenly huge, gaping maw. ", false);
			}
			player.orgasm();
			doNext(mimicTentacleEnd);
		}

		public function mimicTentacleEnd():void {
			clearOutput();
			outputText("Much to your surprise, you wake up some time later. You aren’t sure where you are, or how you got there, but you are certainly glad to be alive. You are covered in some kind of slime, and your body seems strangely sensitive. ");
			if (player.hasVagina()) {
				if (mimicAppearance == 2 || mimicAppearance == 3) 
				{
					if (rand(5) > player.vaginas[0].vaginalWetness) 
					{
						player.vaginas[0].vaginalWetness++;
						outputText("<b>Strangely, even after that ordeal, your vagina seems wetter than usual.</b> ");
					}
				}
				else
				{
					if (rand(5) > player.vaginas[0].vaginalLooseness) 
					{
						player.vaginas[0].vaginalLooseness++;
						outputText("<b>Your cunt is painfully stretched from the ordeal, temporarily enlarged.</b> ");
					}
				}
			}
			dynStats("int", -2, "sen", 5, "cor", 2);
			combat.cleanupAfterCombat();
		}
		
		public function killTheMimic():void {
			clearOutput();
			outputText("The monster collapses, too brutally beaten to even harm you. You search the contents of the monster before heading off. ");
			combat.cleanupAfterCombat();
		}
		
		public function findSomeGems():void {
			var quantity:int = (rand(30) + 10 + player.level) * (1 + (player.perkv1(PerkLib.AscensionFortune) * 0.1));
			player.gems += quantity;
			outputText("Upon opening the small bag, you find " + quantity + " gems inside!");
			doNext(camp.returnToCampUseOneHour);
		}
	}

}