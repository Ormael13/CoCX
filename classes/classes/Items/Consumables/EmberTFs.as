package classes.Items.Consumables 
{
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.CockTypesEnum;
	import classes.PerkLib;

	/**
	 * Moved out of classes.Scenes.NPCs.EmberScene
	 * @since December 11, 2016
	 * @author Stadler76
	 */
	public class EmberTFs extends Consumable 
	{
		public function EmberTFs(type:int = 0):void 
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			switch (type) {
				case 1:
					id = "DrakHrt";
					shortName = "DrakeHeart";
					longName = "a drake's heart's flower";
					description = "A rare, beautiful flower.  It could make an exquisite perfume.  According to a legend, dragons give this flower to the ones they intend to court.";
					value = 50;
					break;

				default:
					id = "EmberBl";
					shortName = "EmberBlood";
					longName = "Embers's blood";
					description = "Ember's dragon blood.  Can't be bought or sold. Immediately consumed. >>>Should not see me.<<<";
					value = 0;
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			var tfSource:String = "EmberTFs-" + shortName;
			var temp:int;
			var drakesHeart:Boolean = tfSource == "EmberTFs-DrakeHeart";
			changes = 0;
			changeLimit = 2;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;

			if (drakesHeart) {
				output.text("You bring the flower up to your nose and smell it. It has exquisite smell."
				           +" You suddenly have the strange desire to eat it. You pop the flower into your mouth and chew."
				           +" It tastes like vanilla somehow. Before you know it, you're undergoing changes.");
			}

			//Gain Dragon Dick
			if (changes < changeLimit && player.countCocksOfType(CockTypesEnum.DRAGON) < player.totalCocks() && rand(3) == 0) {
				temp = 0;
				var choices:Array = [];
				var select:int;
				temp = player.cockTotal();
				//Build an array of all the locations for TF'able cocks.
				while (temp > 0) {
					temp--;
					if (player.cocks[temp].cockType != CockTypesEnum.DRAGON) choices[choices.length] = temp;
				}
				//Randomly choose one of those locations
				select = choices[rand(choices.length)];
				output.text("\n\nYour " + player.cockDescript(select) + " tingles as pins and needles sweep across it.  You pull open your [armor] to watch as it changes; the tip elongates and tapers, like a spear; a series of ridges form along the shaft, giving it an almost segmented look, and a prominent knot swells at its base.  You can't resist stroking it, until it begins dripping pre; ");
				if (player.sens >= 50) output.text("however, it's not until you press on your new, sensitive knot that you manage to blow your load and enjoy the last few spasms of pleasure as it finally finishes changing.");
				else output.text("but you sternly rein in your hands and tuck them into your armpits as the arousing changes run their course.");
				output.text("  <b>You now have a dragon penis.</b>");
				//lose lust if sens>=50, gain lust if else
				getGame().dynStats("sen", 10, "lus", 10);
				changes++;
				//Apply the TF
				player.cocks[select].cockType = CockTypesEnum.DRAGON;
				player.cocks[select].knotMultiplier = 1.3;
			}
			if (rand(5) == 0) mutations.updateOvipositionPerk(tfSource);
			//Gain Dragon Head
			if (changes < changeLimit && rand(3) == 0 && player.faceType != FACE_DRAGON && flags[kFLAGS.EMBER_ROUNDFACE] == 0) {
				output.text("\n\nYou scream as your face is suddenly twisted; your facial bones begin rearranging themselves under your skin, restructuring into a long, narrow muzzle.  Spikes of agony rip through your jaws as your teeth are brutally forced from your gums, giving you new rows of fangs - long, narrow and sharp.  Your jawline begins to sprout strange growths; small spikes grow along the underside of your muzzle, giving you an increasingly inhuman visage.\n\nFinally, the pain dies down, and you look for a convenient puddle to examine your changed appearance.\n\nYour head has turned into a reptilian muzzle, with small barbs on the underside of the jaw.  <b>You now have a dragon's face.</b>");
				player.faceType = FACE_DRAGON;
				changes++;
			}
			//-Existing horns become draconic, max of 4, max length of 1'
			if (!player.hasDragonHorns(true) && changes < changeLimit && rand(5) == 0)
				mutations.gainDraconicHorns(tfSource);
			//Gain Dragon Ears
			if (changes < changeLimit && rand(3) == 0 && player.earType != EARS_DRAGON) {
				player.earType = EARS_DRAGON;
				output.text("\n\nA prickling sensation suddenly fills your ears; unpleasant, but hardly painful.  It grows and grows until you can't stand it any more, and reach up to scratch at them.  To your surprise, you find them melting away like overheated candles.  You panic as they fade into nothingness, leaving you momentarily deaf and dazed, stumbling around in confusion.  Then, all of a sudden, hearing returns to you.  Gratefully investigating, you find you now have a pair of reptilian ear-holes, one on either side of your head.  A sudden pain strikes your temples, and you feel bony spikes bursting through the sides of your head, three on either side, which are quickly sheathed in folds of skin to resemble fins.  With a little patience, you begin to adjust these fins just like ears to aid your hearing.  <b>You now have dragon ears!</b>");
				changes++;
			}
			//Gain Dragon Tongue
			if (changes < changeLimit && rand(3) == 0 && player.tongueType != TONGUE_DRACONIC) {
				output.text("\n\nYour tongue suddenly falls out of your mouth and begins undulating as it grows longer.  For a moment it swings wildly, completely out of control; but then settles down and you find you can control it at will, almost like a limb.  You're able to stretch it to nearly 4 feet and retract it back into your mouth to the point it looks like a normal human tongue.  <b>You now have a draconic tongue.</b>");
				player.tongueType = TONGUE_DRACONIC;
				changes++;
				//Note: This type of tongue should be eligible for all things you can do with demon tongue... Dunno if it's best attaching a boolean just to change the description or creating a whole new tongue type.
			}
			//(Pending Tongue Masturbation Variants; if we ever get around to doing that.)
			//Gain Dragon Scales
			if (!player.hasDragonScales() && changes < changeLimit && rand(3) == 0) {
				output.text("\n\nPrickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed"
				           +" pins and needles.  You scratch yourself, hoping for relief; and when you look at your hands you notice small fragments"
				           +" of your [skinFurScales] hanging from your fingers.  Nevertheless you continue to scratch yourself, and when you're"
				           +" finally done, you look yourself over. New shield-like scales have grown to replace your peeled off [skinFurScales]."
				           +" They are smooth and look nearly as tough as iron.");
				player.skin.setProps({type: SKIN_TYPE_DRAGON_SCALES, adj: "tough", desc: "shield-shaped dragon scales"});
				//def bonus of scales
				player.underBody.type = UNDER_BODY_TYPE_DRAGON;
				player.underBody.copySkin({        // copy the main skin props to the underBody skin ...
					desc: "ventral dragon scales"  // ... and only override the desc
				});
				output.text("  <b>Your body is now covered in [skinTone], shield-shaped dragon scales with [underBody.skinTone] ventral scales"
				           +" covering your underside.</b>");
			}
			//<mod name="Reptile eyes" author="Stadler76">
			//Gain Dragon Eyes
			if (player.eyeType != EYES_DRAGON && player.hasDragonScales() && player.earType == EARS_DRAGON && player.hasDragonHorns() && changes < changeLimit && rand(4) == 0) {
				if (player.hasReptileEyes())
					output.text("\n\nYour eyes change slightly in their appearance.");
				else
				{
					output.text("\n\nYou feel a sudden surge of pain in your eyes as they begin to reshape. Your pupils begin to elongate becoming vertically slitted and your irises change their color, too.");
					output.text("\nAs the pain passes, you examine your eyes in a nearby puddle. You look into your new prideful, fierce dragon eyes with vertically slitted pupils and burning orange irises.");
					output.text("  They glitter even in the darkness. With a few tears remaining, the look is a bit blurry. Wanting to get a clearer look at them, you blink your remaining tears away and suddenly you realize, that you just did that with your second set of eyelids.");
				}
				output.text("  <b>You now have fierce dragon eyes.</b>");
				player.eyeType = EYES_DRAGON;
				changes++;
			}
			//</mod>
			//Gain Dragon Legs
			if (player.lowerBody != LOWER_BODY_TYPE_DRAGON && changes < changeLimit && rand(3) == 0) {
				//(if drider)
				if (player.lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY)
					output.text("\n\nA disquieting feeling ripples through your arachnid abdomen, and you find yourself losing control of your body from the waist down.  Your spidery legs flail madly as your abdomen visibly swells, chitin cracking ominously as the pressure builds up inside of you... and then explodes!  You wipe the gore from your face in disgust, wondering why you feel no pain.  Rolling over, you see that, caked with spider-slime, you now have a new pair of legs, human-like save for the scales and the bestial paws that serve as feet.  <b>You now have dragon feet.</b>");
				//(If naga)
				else if (player.isNaga()) {
					output.text("\n\nYou fall on your face to the ground, hissing and screeching in pain - it feels like someone has grabbed the tip of your tail, pulled it viciously straight, and is now splitting it up the middle with a knife!  Paralyzed from the waist down, you claw desperately at the earth to try and alleviate the pain, and can only think to thank your lucky stars when it fades away.  Looking down where your tail was, though the scales remain, you realize you've become a biped again, your new feet sporting bestial claws on their toes.  <b>You now have dragon feet.</b>");
				}
				//(If Goo)
				else if (player.isGoo()) {
					output.text("\n\nA strange tingling sensation fills you, and you watch as your gooey blob of a body begins to ripple and shudder; you try to make it stop, but you can't control it.  Before your eyes, it shapes itself into the appearance of legs, the colored slime growing denser and thicker, the surface membrane texturing itself to look like scales.  Before you've quite realized what's happened, the slime has set like water freezing, leaving you with humanoid legs once again, though tipped with claws and very reptilian in appearance.  <b>You now have dragon feet.</b>");
				}
				//(If hoofed legs)
				else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED) {
					output.text("\n\nYou bellow in pain as your legs break and reform and your hooves seem to suddenly explode, the bones within twisting themselves into monstrous three-toed appendages, more like those of some terrible lizard-thing than anything else. <b>You now have dragon feet.</b>");
				}
				//(if centaur)
				else if (player.isTaur()) {
					output.text("\n\nYou cry out as spasms of pain suddenly rip through your quadrupedal body, bringing you crashing onto the ground.  Words cannot define the agony as muscles and bones twist and shift and collapse violently.  When it's all over, you stagger upright, finding yourself standing on two legs again.  Though covered in scales and with the paws of some monster lizard instead of feet, they otherwise look like your old human legs.  <b>You now have dragon feet.</b>");
				}
				//(If non-hoofed legs)
				else {
					output.text("\n\nYou scream in agony as you feel the bones in your feet suddenly break and restructure themselves, toes fusing together, bone swelling out of the merged masses of flesh.  When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>");
				}
				player.lowerBody = LOWER_BODY_TYPE_DRAGON;
				player.legCount = 2;
				changes++;
			}
			//Gain Dragon Tail
			if (player.tailType != TAIL_TYPE_DRACONIC && changes < changeLimit && rand(3) == 0) {
				//(If no tail)
				if (player.tailType == TAIL_TYPE_NONE) output.text("\n\nA sudden dull, throbbing pain in your " + player.buttDescript() + " forces your hands to it; you can feel an ominous lump over your tail bone, swelling bigger and bigger with every heartbeat.  All of a sudden, it seems to explode, jutting out and around until it hovers near your ankles, the skin under your flesh hard and scaly.  <b>You now have a dragon tail flicking at your back, flexible as a whip.</b>");
				//(If tail)
				else output.text("\n\nAn icy sensation fills your behind as your tail suddenly goes curiously numb.  Twisting your head around, you watch as it melts and transforms into a reptilian appendage, long and flexible, its tip adorned with wicked spikes.  <b>You now have a dragon tail.</b>");
				player.tailType = TAIL_TYPE_DRACONIC;
				changes++
			}
			/*
			 //9999 - prolly not gonna do this!
			 Tail Slam Attack Effects:
			 Deals ⅓ normal damage, but pierces 30 defense (stacks with perks) and has a (strength / 2) chance of stunning the opponent that turn.
			 Note: Dunno how much defense critters usually have, but this is meant as a surprise attack of sorts, so it pierces a good amount of it.
			 Tail Slam Attack Description:
			 You spin around quickly, whipping your tail spikes at [enemy].

			 Hit: Your tail slams against it/" + emberMF("him","her") + " with brutal force, the spikes on the tip extending to puncture flesh.
			 Miss: Unfortunately, you lose your sense of depth as you whirl, and the tip swings harmlessly through the air in front of your target.
			 */
			//Grow Dragon Wings
			if (player.wingType != WING_TYPE_DRACONIC_LARGE && changes < changeLimit && rand(3) == 0) {
				if (player.wingType == WING_TYPE_NONE) {
					output.text("\n\nYou double over as waves of pain suddenly fill your shoulderblades; your back feels like it's swelling, flesh and muscles ballooning.  A sudden sound of tearing brings with it relief and you straighten up.  Upon your back now sit small, leathery wings, not unlike a bat's. <b>You now have small dragon wings.  They're not big enough to fly with, but they look adorable.</b>");
					player.wingType = WING_TYPE_DRACONIC_SMALL;
				}
				//(If Small Dragon Wings Present)
				else if (player.wingType == WING_TYPE_DRACONIC_SMALL) {
					output.text("\n\nA not-unpleasant tingling sensation fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger.  You spread them wide - they stretch further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and almost lifting you off your feet.  <b>You now have fully-grown dragon wings, capable of winging you through the air elegantly!</b>");
					player.wingType = WING_TYPE_DRACONIC_LARGE;
				}
				else if (player.wingType == WING_TYPE_SHARK_FIN) {
					output.text("\n\nA sensation of numbness suddenly fills your fin.  When it does away, it feels... different.  Looking back, you realize that it has been replaced by new, small wings, ones that you can only describe as draconic.  <b>Your shark-like fin has changed into dragon wings.</b>");
					player.wingType = WING_TYPE_DRACONIC_SMALL;
				}
				//(If other wings present)
				else {
					output.text("\n\nA sensation of numbness suddenly fills your wings.  When it dies away, they feel... different.  Looking back, you realize that they have been replaced by new, small wings, ones that you can only describe as draconic.  <b>Your wings have changed into dragon wings.</b>");
					player.wingType = WING_TYPE_DRACONIC_SMALL;
				}
				changes++;
			}
			// <mod name="Predator arms" author="Stadler76">
			//Gain Dragon Arms (Derived from ARM_TYPE_SALAMANDER)
			if (player.armType != ARM_TYPE_PREDATOR && player.hasDragonScales() && player.lowerBody == LOWER_BODY_TYPE_DRAGON && changes < changeLimit && rand(3) == 0) {
				output.text("\n\nYou scratch your biceps absentmindedly, but no matter how much you scratch, you can't get rid of the itch.  After a longer moment of ignoring it you finally glance down in irritation, only to discover that your arms former appearance has changed into those of some reptilian killer with shield-shaped " + player.skinTone + " scales and powerful, thick, curved steel-gray claws replacing your fingernails.");
				output.text("\n<b>You now have dragon arms.</b>");
				player.armType = ARM_TYPE_PREDATOR;
				mutations.updateClaws(CLAW_TYPE_DRAGON);
				changes++
			}
			//Claw transition
			if (player.armType == ARM_TYPE_PREDATOR && player.hasDragonScales() && player.clawType != CLAW_TYPE_DRAGON && changes < changeLimit && rand(3) == 0) {
				output.text("\n\nYour " + player.claws() + " change  a little to become more dragon-like.");
				mutations.updateClaws(CLAW_TYPE_DRAGON);
				output.text(" <b>You now have " + player.claws() + ".</b>");
				changes++
			}
			// </mod>
			//Get Dragon Breath (Tainted version)
			//Can only be obtained if you are considered a dragon-morph, once you do get it though, it won't just go away even if you aren't a dragon-morph anymore.

			if (player.dragonScore() >= 4 && changes < changeLimit && player.findPerk(PerkLib.Dragonfire) < 0) {
				output.text("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
				output.text("\n\nIt seems " + (drakesHeart ? "the flower" : "Ember's dragon blood") + " has awaked some kind of power within you... your throat and chest feel very sore, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragonfire!</b>)");
				player.createPerk(PerkLib.Dragonfire, 0, 0, 0, 0);
				if (getGame().emberScene.emberAffection() >= 75 && !drakesHeart) output.text("\n\nEmber immediately dives back in to soothe your battered throat and mouth with another kiss.");
				changes++;
			}
			if (player.dragonScore() >= 4 && rand(3) == 0 && player.gender > 0) {
				output.text("\n\nA sudden swell of lust races through your ");
				if (player.hasCock()) {
					output.text(player.cockDescript(0));
					if (player.hasVagina()) output.text(" and ");
				}
				if (player.hasVagina()) output.text(player.vaginaDescript());
				output.text(", making you wish " + (drakesHeart ? "you had a dragon to go with." : "Ember hadn't run you off") + ".  All you can think about now is fucking " + (drakesHeart ? "a dragon-morph" : getGame().emberScene.emberMF("him", "her")) + "; ");
				if (player.hasCock() && flags[kFLAGS.EMBER_GENDER] >= 2) {
					if (drakesHeart) {
						output.text("filling a womb with your seed and fertilizing those eggs");
					}
					else {
						output.text("filling her womb with your seed and fertilizing her eggs");
						if (player.hasVagina() && flags[kFLAGS.EMBER_GENDER] == 3) output.text(" even while ");
					}
				}
				if (player.hasVagina() && (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 1)) {
					output.text("taking that hard, spurting cock inside your own " + player.vaginaDescript(0));
				}
				output.text("... too late, you realize that <b>" + (drakesHeart ? "the flower" : "Ember's blood") + " has sent your draconic body into ");
				if (player.hasCock() && (flags[kFLAGS.EMBER_GENDER] >= 2 || drakesHeart) && (rand(2) == 0 || !player.hasVagina())) { //If hermaphrodite, the chance is 50/50.
					output.text("rut");
					
					player.goIntoRut(false);
					changes++; // is this really worth incrementing the changes? It even ignores the changeLimit
				}
				else {
					output.text("heat");
					
					player.goIntoHeat(false);
					changes++; // is this really worth incrementing the changes? It even ignores the changeLimit
				}
				output.text("</b>.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}

}
